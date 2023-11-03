<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
  xmlns:tools="xalan://com.misys.portal.common.tools.Tools"
  xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
  xmlns:user="xalan://com.misys.portal.security.GTPUser"
  xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
  xmlns:converttool="xalan://com.misys.portal.common.tools.ConvertTools"
  xmlns:exslt="http://exslt.org/common"
  exclude-result-prefixes="localization tools security">
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
	<xsl:param name="rundata"/>
  	<xsl:param name="option"/>
  	<xsl:param name="language">en</xsl:param>
  	<xsl:param name="nextscreen"/>
  	<xsl:param name="mode">DRAFT</xsl:param>
  	<xsl:param name="action"/>
	<xsl:param name="displaymode">edit</xsl:param>
  	<xsl:param name="operation">SAVE_FEATURES</xsl:param>
  	<xsl:param name="isMakerCheckerMode"/>
	<xsl:param name="makerCheckerState"/>
	<xsl:param name="canCheckerReturnComments"/>
	<xsl:param name="checkerReturnCommentsMode"/>
  	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
   	<xsl:param name="main-form-name">fakeform1</xsl:param>
   	<xsl:param name="modifyMode">N</xsl:param>
   	<xsl:param name="token"/>
	<xsl:param name="processdttm"/>
	<xsl:param name="company"/>
   	<xsl:param name="allowReturnAction">false</xsl:param>
  	<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:param>
  	<xsl:param name="product-code"/>
  	<xsl:param name="upload-file-url"/>
  <xsl:param name="override_company_abbv_name"></xsl:param>
  <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
  <xsl:param name="actionDownImage"><xsl:value-of select="$images_path"/>action-down.png</xsl:param>
  <xsl:param name="actionUpImage"><xsl:value-of select="$images_path"/>action-up.png</xsl:param>
  
  	<!-- <xsl:include href="../common/system_common.xsl" /> -->
   	<xsl:include href="../common/trade_common.xsl" /> 
	<xsl:include href="../common/maker_checker_common.xsl" />
	<!--  <xsl:include href="sy_jurisdiction.xsl" /> -->
	<!-- <xsl:include href="sy_customer_beneficiary_common.xsl" /> -->
	<xsl:include href="sy_reauthenticationdialog.xsl" />
	<!-- E2EE call --> 
	 <!-- <xsl:include href="../../../core/xsl/common/e2ee_common.xsl" /> -->
	 <xsl:include href="../common/e2ee_common.xsl" />
	<!-- <xsl:include href="../common/attachment_templates.xsl" /> -->
  
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/">
    	<xsl:apply-templates select="beneficiary_upload"/>
  	</xsl:template>
  
  
	<xsl:template match="beneficiary_upload"> 
		<!-- Preloader -->
		<xsl:call-template name="loading-message"/>

		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
			<xsl:call-template name="server-message">
				<xsl:with-param name="name">server_message</xsl:with-param>
				<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
				<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
			</xsl:call-template>
		    <!-- Form #0 : Main Form -->
		    <xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name"/>
			    <xsl:with-param name="validating">Y</xsl:with-param>
			    <xsl:with-param name="content">
					<xsl:call-template name="beneficiary-general-details"/>
					<xsl:if test="$displaymode = 'edit'">
				    	<xsl:call-template name="attachments-file-dojo">
				    		<xsl:with-param name="attachment_type">BENEFICIARY_FILE_UPLOAD</xsl:with-param>
				    	    <xsl:with-param name="attachment-group">OTHER</xsl:with-param>
				    		<xsl:with-param name="legend">XSL_HEADER_BULK_FILE_UPLOAD</xsl:with-param>
				   	 		<xsl:with-param name="max-files">1</xsl:with-param>
				   	 	</xsl:call-template>
				    </xsl:if>
				    <xsl:if test="$displaymode = 'view'">
				    	<xsl:call-template name="uploaded-file-details"/>
				    	<xsl:call-template name="upload-results"/>	
				    </xsl:if>
				    <xsl:if test="$canCheckerReturnComments = 'true'">
						<xsl:call-template name="comments-for-return-mc">
							<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!--  Display common menu. -->
					<xsl:call-template name="maker-checker-menu">
						<xsl:with-param name="show-save">N</xsl:with-param>
					</xsl:call-template>
					<!-- Reauthentication -->
		      		<xsl:call-template name="reauthentication"/>
			      </xsl:with-param>
	        </xsl:call-template>
			<xsl:call-template name="realform"/> 
			<!-- Javascript and Dojo imports  -->
			<xsl:call-template name="js-imports"/>
		</div>
	</xsl:template>   
   
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">	                                        
			<xsl:with-param name="xml-tag-name">beneficiary_upload</xsl:with-param>
	    	<xsl:with-param name="binding">misys.binding.system.beneficiary_upload_mc</xsl:with-param>
	    	<xsl:with-param name="show-period-js">Y</xsl:with-param>
	    	<xsl:with-param name="override-help-access-key">BU_01</xsl:with-param>
	    	<xsl:with-param name="override-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/><xsl:if test="$override_company_abbv_name!=''">&amp;company=<xsl:value-of select="$override_company_abbv_name"/></xsl:if></xsl:with-param>
	    </xsl:call-template>
	</xsl:template>
	<!-- <xsl:call-template name="hidden-fields" /> -->

	<xsl:template name="beneficiary-general-details">
		<div>  
			<!-- Don't display this in unsigned mode. -->
			<xsl:if test="$displaymode='edit'">
				<xsl:call-template name="hidden-field">
      				<xsl:with-param name="name">appl_date</xsl:with-param>
     			</xsl:call-template>
    		</xsl:if>
   		</div>
  
		<xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   			<xsl:with-param name="button-type">
   				<xsl:if test="$hideMasterViewLink!='true'">mc-master-details</xsl:if>
   			</xsl:with-param> 
   			<xsl:with-param name="override-displaymode">edit</xsl:with-param>
   			<xsl:with-param name="content">
				<!-- File description -->
				<xsl:call-template name="input-field">
			 		<xsl:with-param name="label">XSL_FILE_DESCRIPTION</xsl:with-param>
			 		<xsl:with-param name="name">description</xsl:with-param>
			 	</xsl:call-template>
				<!-- Date uploaded: For New records this is the creation date, otherwise the last maintenance date -->
				<xsl:if test="$displaymode='view'">
					<xsl:call-template name="input-field">
				 		<xsl:with-param name="label">UPLOAD_DATE</xsl:with-param>
				 		<xsl:with-param name="name">
				 			<xsl:choose>
				 				<xsl:when test="string-length(last_maintenance_date)=0">creation_date</xsl:when>
				 				<xsl:otherwise>last_maintenance_date</xsl:otherwise>
				 			</xsl:choose>	
				 		</xsl:with-param>
				 	</xsl:call-template>
				</xsl:if>
				<!-- Maker User: To be displayed only for Checker in Maker-Checker scenario -->
				<xsl:if test="$isMakerCheckerMode = 'true' and $displaymode = 'view' and maker_id != ''">
					<xsl:variable name="maker" select="security:getUser(maker_id)"/>
					<xsl:call-template name="input-field">
				 		<xsl:with-param name="label">MAKER_USER</xsl:with-param>
				 		<xsl:with-param name="name">maker_user</xsl:with-param>
				 		<xsl:with-param name="value">
				 			<xsl:value-of select="user:getLastName($maker)"/>, <xsl:value-of select="user:getFirstName($maker)"/>
				 		</xsl:with-param>			  
					</xsl:call-template>
				</xsl:if>
				<!-- Beneficiary type -->
   				<xsl:choose>
					<xsl:when test= "$displaymode = 'edit'">
						<xsl:call-template name="select-field">
					     	<xsl:with-param name="label">PRODUCT_TYPE_OR_BENEFICIARY_CATEGORY_LABEL</xsl:with-param>
					     	<xsl:with-param name="name">product_type</xsl:with-param>
					     	<xsl:with-param name="required">Y</xsl:with-param>
					     	<xsl:with-param name="value"><xsl:value-of select="product_type"/></xsl:with-param>
					     	<xsl:with-param name="options">
					     		<xsl:for-each select="product_type">
					     		    <option>
						           <xsl:attribute name="value"><xsl:value-of select="product_type_desc" /></xsl:attribute>
						            <xsl:value-of select="product_type_val" />
						            </option>
					     		</xsl:for-each>
					    	</xsl:with-param>
						</xsl:call-template>			
				    </xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">PRODUCT_TYPE_OR_BENEFICIARY_CATEGORY_LABEL</xsl:with-param>
							<xsl:with-param name="name">product_type</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N117', product_type)"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">product_type</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="product_type"/></xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>		
		 		</xsl:choose>
				<!-- Status -->
				<xsl:if test="$displaymode = 'view'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">BENE_FILE_STATUS</xsl:with-param>
						<xsl:with-param name="name">status</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N801', status)"/></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
		 		
		 		<!-- hidden fields -->
		 		<xsl:call-template name="hidden-field">
            		<xsl:with-param name="name">brch_code</xsl:with-param>
              		<xsl:with-param name="value" select="brch_code"/>
              	</xsl:call-template>
              	<xsl:call-template name="hidden-field">
              		<xsl:with-param name="name">company_id</xsl:with-param>
             		<xsl:with-param name="value" select="company_id"/>
             	</xsl:call-template>
			    <xsl:call-template name="hidden-field">
			    	<xsl:with-param name="name">customer_abbv_name</xsl:with-param>
			     	<xsl:with-param name="value" select="customer_abbv_name"/>
			    </xsl:call-template>
			    <xsl:call-template name="hidden-field">
			    	<xsl:with-param name="name">bank_id</xsl:with-param>
			     	<xsl:with-param name="value" select="bank_id"/>
			    </xsl:call-template>
				<xsl:call-template name="hidden-field">
		     		<xsl:with-param name="name">bank_abbv_name</xsl:with-param>
		     		<xsl:with-param name="value" select="bank_abbv_name"/>
		    	</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="uploaded-file-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_FILE_DETAILS</xsl:with-param>			 
			<xsl:with-param name="content">
			<xsl:choose>
			   <xsl:when test ="num_failed =-1">
				<xsl:call-template name="input-field">
			 		<xsl:with-param name="label">XSL_NUM_BENE_TOTAL</xsl:with-param>			 		
			 		<xsl:with-param name="value">0</xsl:with-param>
			 	</xsl:call-template>
			 	</xsl:when>
			 	<xsl:otherwise>
			 	<xsl:call-template name="input-field">
			 		<xsl:with-param name="label">XSL_NUM_BENE_TOTAL</xsl:with-param>
			 		<xsl:with-param name="name">num_total</xsl:with-param>
			 		
			 	</xsl:call-template>			 	
			 	</xsl:otherwise>
			 </xsl:choose>
			 	<xsl:variable name="uploadedFileLink" select="$upload-file-url"></xsl:variable>
			 	<span class="label">
			 		<a href="{$uploadedFileLink}">
			 			<xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_VIEW_UPLOAD')"/>
			 		</a>
			 	</span>	
			</xsl:with-param>
		</xsl:call-template>	
	</xsl:template>
	
	<xsl:template name="upload-results">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">MENU_BK_UPLOAD_RESULTS</xsl:with-param>			 
			<xsl:with-param name="content">
				<xsl:call-template name="input-field">
			 		<xsl:with-param name="label">XSL_NUM_BENE_NEW</xsl:with-param>
			 		<xsl:with-param name="name">num_new</xsl:with-param>
			 	</xsl:call-template>
			 	<xsl:call-template name="input-field">
			 		<xsl:with-param name="label">XSL_NUM_BENE_MODIFIED</xsl:with-param>
			 		<xsl:with-param name="name">num_modified</xsl:with-param>
			 	</xsl:call-template>
			 	<xsl:choose>
			 	<xsl:when test ="num_failed =-1">
			 	<xsl:call-template name="input-field">
			 		<xsl:with-param name="label">XSL_NUM_BENE_FAILED</xsl:with-param>
			 		<xsl:with-param name="value">0</xsl:with-param>
			 	</xsl:call-template>
			 	</xsl:when>
			 	<xsl:otherwise>
			 	<xsl:call-template name="input-field">
			 		<xsl:with-param name="label">XSL_NUM_BENE_FAILED</xsl:with-param>
			 		<xsl:with-param name="name">num_failed</xsl:with-param>
			 	</xsl:call-template>			 	
			 	</xsl:otherwise>
			 	</xsl:choose>
			 	<xsl:if test="num_failed > 0 or num_failed =-1">
			 		<xsl:call-template name="failed-records"/>
			 	</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="failed-records">
		<xsl:variable name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:variable>
		<div>
			<!-- Header with toggle link -->
			<div class="wipeInOutTabHeader">
				<div id="actionDown" onclick="misys.toggleFailedRecordsGrid()" style="cursor: pointer; display: block;">
				    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_VIEW_FAILED')"/>
				    <span class="collapsingImgSpan">
				        <img>
				        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
				        </img>
				    </span>
				</div>
				<div id="actionUp" onclick="misys.toggleFailedRecordsGrid()" style="display: none; cursor: pointer;">
				    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_VIEW_FAILED')"/>
				    <span class="collapsingImgSpan">
				        <img>
				        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionUpImage)"/></xsl:attribute>
				        </img>
				    </span>
				</div>
			</div>
			<!-- Failed records table -->
			<div id="failedRecords" style="height: auto; display: none; width:100%;">
				<table class="beneficiaryFailedRecordsTable">
					<tr>
						<th width="10%">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINE_NO')"/>
						</th>
						<th width="10%">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_COL_NO')"/>
						</th>
						<th width="20%">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENE_ID')"/>
						</th>
						<th width="40%">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FAIL_REASON')"/>
						</th>
						<th width="20%">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINE_TEXT')"/>
						</th>
					</tr>
					<xsl:for-each select="error_details/static_error">
						<xsl:sort select="lineno" data-type="number"/>
										
						<tr>
							<td>
								<xsl:value-of select="lineno"/>
							</td>
							<td>
								<xsl:value-of select="colno"/>
							</td>
							<td>
								<xsl:value-of select="benid"/>
							</td>
							<td class="errorMsg">
								<xsl:variable name="errorMsg"><xsl:value-of select="error_msg"/></xsl:variable>
								<xsl:variable name="messageArgs"><xsl:value-of select="message_args"/></xsl:variable>
								<xsl:choose>
									<xsl:when test="localized = 'N'">
									<xsl:value-of select="tools:formatMessageWithArgs($language, $errorMsg,$messageArgs)"/>
									</xsl:when>
									<xsl:otherwise>
									<xsl:value-of select="$errorMsg"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>
								<xsl:value-of select="value"/>
							</td>
						</tr>
					</xsl:for-each>
				</table>
				
			
				<!-- <div class="alignCenterWithPadding" style="width:100%;">
					Table header row
					<div>
						<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell" style="width:10%;">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINE_NO')"/>
						</div>
						<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell" style="width:10%;">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENE_ID')"/>
						</div>
						<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell" style="width:10%;">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_COL_NO')"/>
						</div>
						<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell" style="width:30%;">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FAIL_REASON')"/>
						</div>
						<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell" style="width:30%;">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINE_TEXT')"/>
						</div>
					</div>
					Table body
					<xsl:for-each select="error_details/static_error">
						<xsl:sort select="lineno"/>
						<div style="width:100%;">
							<div class="userAccountsTableCell userAccountColumnCell userAccountsTableCellOdd alignCenterWithPadding" style="width:10%;">
								<xsl:value-of select="lineno"/>
							</div>
							<div class="userAccountsTableCell userAccountColumnCell userAccountsTableCellOdd alignCenterWithPadding" style="width:10%;">
								<xsl:value-of select="benid"/>
							</div>
							<div class="userAccountsTableCell userAccountColumnCell userAccountsTableCellOdd alignCenterWithPadding" style="width:10%;">
								If colno is a numeric value, increment by 1. Else, show as is
								<xsl:choose>
									<xsl:when test="string(number(colno)) != 'NaN'">
										<xsl:value-of select="colno + 1"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="colno"/>
									</xsl:otherwise>
								</xsl:choose>
							</div>
							<div class="userAccountsTableCell userAccountColumnCell userAccountsTableCellOdd alignCenterWithPadding" style="width:30%;text-align:left;">
								<xsl:value-of select="error_msg"/>
							</div>
							<div class="userAccountsTableCell userAccountColumnCell userAccountsTableCellOdd alignCenterWithPadding" style="width:30%;text-align:left;">
								<xsl:value-of select="value"/>
							</div>
						</div>
					</xsl:for-each>
				</div> -->
			</div>		
		</div>
	</xsl:template>   			
   			
   	<xsl:template name="realform">
   	 <xsl:call-template name="form-wrapper">
		    <xsl:with-param name="name">realform</xsl:with-param>
		    <xsl:with-param name="method">POST</xsl:with-param>
		    <xsl:with-param name="action" select="$realform-action"/>
		    <xsl:with-param name="content">
		    <div class="widgetContainer">
		    			<xsl:call-template name="localization-dialog"/>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">operation</xsl:with-param>
							<xsl:with-param name="id">realform_operation</xsl:with-param>
							<xsl:with-param name="value" select="$operation"></xsl:with-param> 
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">option</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="$option != ''"><xsl:value-of select="$option"/></xsl:when>
									<xsl:otherwise>CUSTOMER_BENEFICIARY_UPLOAD_MAINTENANCE_MC</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">TransactionData</xsl:with-param>
						</xsl:call-template>
					
					<xsl:if test="./bene_upload_id[.!='']">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">featureid</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="./bene_upload_id"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="./tnx_id[.!='']">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">tnxid</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="./tnx_id"/></xsl:with-param>
							</xsl:call-template>
							</xsl:if>
						
						
						<xsl:if test="$option='CUSTOMER_BENEFICIARY_UPLOAD_MAINTENANCE_MC'">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">company</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="./customer_abbv_name"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">token</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
                            <xsl:with-param name="name">attIds</xsl:with-param>
                            <xsl:with-param name="value"/>
                        </xsl:call-template>
						 <xsl:call-template name="hidden-field">
							<xsl:with-param name="name">processdttm</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$processdttm"/></xsl:with-param>
						</xsl:call-template> 
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">mode</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$draftMode"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="reauth_params"/>
						<xsl:call-template name="e2ee_transaction"/>
					</div>
		    </xsl:with-param>
		    </xsl:call-template>
		
	</xsl:template> 
   			
   	<xsl:template name="avail_sub_products">
		<!-- NEW PORTAL V5 TYPES -->
		<option value="TPT"><xsl:value-of select="localization:getDecode($language, 'N047', 'TPT')"/></option>
		<option value="DOM"><xsl:value-of select="localization:getDecode($language, 'N047', 'DOM')"/></option>		
		<option value="MT103"><xsl:value-of select="localization:getDecode($language, 'N047', 'MT103')"/></option>
		<option value="DD"><xsl:value-of select="localization:getDecode($language, 'N047', 'DD')"/></option>
		<option value="MEPS"><xsl:value-of select="localization:getDecode($language, 'N047', 'MEPS')"/></option>
		<option value="RTGS"><xsl:value-of select="localization:getDecode($language, 'N047', 'RTGS')"/></option>
	</xsl:template>
 
  
  </xsl:stylesheet>
