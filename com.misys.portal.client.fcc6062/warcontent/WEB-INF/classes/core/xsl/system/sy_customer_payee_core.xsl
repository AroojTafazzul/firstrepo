<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Customer Payee, System Form.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      13/10/2011
author:    Rajesh kumar
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:payeeutils="xalan://com.misys.portal.product.util.PayeeUtil"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization payeeutils">

  <!-- 	
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="languages"/>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="action"/>
  <xsl:param name="token"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="operation"/>
  <xsl:param name="maintenaceDetails"/>
  <xsl:param name="local_language"/>
  <xsl:param name="user_language"/>
  <xsl:param name="processdttm"/>
  <xsl:param name="currentmode"/>
  
  <xsl:param name="operation">SAVE_FEATURES</xsl:param>
   <xsl:param name="isMakerCheckerMode"/>
  <xsl:param name="makerCheckerState"/>
   <xsl:param name="canCheckerReturnComments"/>
  <xsl:param name="checkerReturnCommentsMode"/>
  <xsl:param name="allowReturnAction">false</xsl:param>
  <xsl:param name="isMultiBank">N</xsl:param>
  <xsl:param name="override_company_abbv_name"/>
  <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
  <xsl:param name="textImage"><xsl:value-of select="$images_path"/>pic_text.gif</xsl:param>
  <xsl:param name="checkOrRevertImage"><xsl:value-of select="$images_path"/>pic_checkorrevert.gif</xsl:param>
  
  

  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  <xsl:include href="../../../core/xsl/system/sy_jurisdiction.xsl" />
  <xsl:include href="sy_reauthenticationdialog.xsl" />
  <xsl:include href="../common/maker_checker_common.xsl" />
  <xsl:include href="../common/e2ee_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  
  <xsl:template match="/">
   <!-- Loading message  -->
   <xsl:call-template name="loading-message"/>
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
   	 <xsl:with-param name="name" select="$main-form-name"/>
   	 <xsl:with-param name="validating">Y</xsl:with-param>
   	 <xsl:with-param name="content">
      <xsl:apply-templates select="customer_payee_record" mode="input"/>
     <!--  <xsl:call-template name="system-menu" /> -->
      
<!--        <xsl:if test="$canCheckerReturnComments = 'true'">
      	<xsl:call-template name="comments-for-return-mc">
      		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
      	</xsl:call-template>
       </xsl:if> -->
      <!--  Display common menu. -->
      <xsl:call-template name="maker-checker-menu"/>
      
     </xsl:with-param>
    </xsl:call-template>
     <!-- Reauthentication Start -->
    <xsl:call-template name="server-message">
 		<xsl:with-param name="name">server_message</xsl:with-param>
 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="reauthentication" />
    <!-- Reauthentication End -->
     <xsl:call-template name="realform"/>
   </div>

   <!-- Javascript imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>
  
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="system-common-js-imports">
   <xsl:with-param name="xml-tag-name">customer_payee_record</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.customer_payee</xsl:with-param>
   <xsl:with-param name="override-help-access-key">SY_CUS_PAY</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
  	<!-- =========================================================================== -->
  	<!-- =================== Template for Basic Package Details in INPUT mode =============== -->
  	<!-- =========================================================================== -->
  	<xsl:template match="customer_payee_record" mode="input">
  	<xsl:variable name="loc_lan"><xsl:value-of select="$local_language"/></xsl:variable>
  	<xsl:variable name="user_lan"><xsl:value-of select="$user_language"/></xsl:variable>
  		<xsl:call-template name="fieldset-wrapper">
  		<xsl:with-param name="legend">XSL_HEADER_BASIC_CUSTOMER_PAYEE_DETAILS</xsl:with-param>
   			<xsl:with-param name="content">
   				<!-- Activate /In activate check box-->
   				<xsl:call-template name="checkbox-field">
							<xsl:with-param name="label">XSL_CUSTOMER_PAYEE_ACTIVATE</xsl:with-param>
							<xsl:with-param name="name">status</xsl:with-param>
							<xsl:with-param name="id">status</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<xsl:with-param name="checked">
					        <xsl:choose>
					         <xsl:when test="status = 'A'">Y</xsl:when>
					         <xsl:otherwise>N</xsl:otherwise>
					        </xsl:choose>
					       </xsl:with-param>
				</xsl:call-template>
   				<!-- Entity selection box -->
   				<xsl:if test="entities">
   				<xsl:call-template name="entity-field">
			      <xsl:with-param name="button-type">
				      	<xsl:choose>
				    		 <xsl:when test="security:isBank($rundata)">system-entity</xsl:when>
				    		 <xsl:otherwise>entity-basic</xsl:otherwise>
				    	</xsl:choose>
			 	   </xsl:with-param>
			 	   <xsl:with-param name="prefix"><xsl:value-of select="/customer_payee_record/payee_code"/></xsl:with-param>
			 	   <xsl:with-param name="override_company_abbv_name"><xsl:value-of select="/customer_payee_record/bank_abbv_name"/></xsl:with-param>
			 	   <xsl:with-param name="override-sub-product-code">BILLP</xsl:with-param>
			       <xsl:with-param name="required">
				        <xsl:choose>
				        <xsl:when test="count(entities)='1'">N</xsl:when>
				        <xsl:otherwise>Y</xsl:otherwise>
				        </xsl:choose>
			       </xsl:with-param>
			      </xsl:call-template>
			    </xsl:if>
			    <xsl:if test="$isMultiBank='Y'">
			    	<xsl:call-template name="input-field">
			    		<xsl:with-param name="label">BANK_NAME</xsl:with-param>
			    		<xsl:with-param name="name">bank_abbv_name</xsl:with-param>
			    		<xsl:with-param name="value"><xsl:value-of select="/customer_payee_record/bank_abbv_name"></xsl:value-of></xsl:with-param>
			    		<xsl:with-param name="override-displaymode">view</xsl:with-param>
			    	</xsl:call-template>
			    </xsl:if>
   			    <xsl:call-template name="input-field">
    				<xsl:with-param name="label">XSL_JURISDICTION_PAYEE_NAME</xsl:with-param>
    				<xsl:with-param name="name">payee_name</xsl:with-param>
      				<xsl:with-param name="value">
	      				<xsl:choose>
	      					<xsl:when test="$loc_lan = $user_lan and local_payee_name[.!='']"><xsl:value-of select="local_payee_name"/></xsl:when>
	      					<xsl:otherwise><xsl:value-of select="payee_name"/></xsl:otherwise>
	      				</xsl:choose>
      				</xsl:with-param>
      				<xsl:with-param name="size">70</xsl:with-param>
      				<xsl:with-param name="fieldsize">large</xsl:with-param>
     				<xsl:with-param name="maxsize">70</xsl:with-param>
     				<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>	
                    <xsl:with-param name="override-displaymode">view</xsl:with-param>
     			</xsl:call-template>
     			<xsl:if test="samp_bill_path[.!='']">	
					<a target="_blank">
					     	<xsl:attribute name="href"><xsl:value-of select="samp_bill_path"/></xsl:attribute>
					<img>
							<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($textImage)"/></xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_SAMPLE_BILL')"/></xsl:attribute>
					</img>
					</a>
      			</xsl:if>

     			<!-- Payee Description -->
				<xsl:choose>
					<xsl:when test="$displaymode='edit'">
						<xsl:call-template name="row-wrapper">
						     <xsl:with-param name="label">XSL_JURISDICTION_PAYEE_DESCRIPTION</xsl:with-param>
						     <xsl:with-param name="type">textarea</xsl:with-param>
						     <xsl:with-param name="content">
							     <xsl:call-template name="textarea-field">
								     <xsl:with-param name="name">description</xsl:with-param>
								     <xsl:with-param name="rows">3</xsl:with-param>
								     <xsl:with-param name="cols">50</xsl:with-param>
								     <xsl:with-param name="maxlines">3</xsl:with-param>
								     <xsl:with-param name="fieldsize">large</xsl:with-param>
									 <xsl:with-param name="required">N</xsl:with-param>
									 <xsl:with-param name="messageValue">
				      					<xsl:choose>
					      					<xsl:when test="$loc_lan = $user_lan and local_description[.!='']"><xsl:value-of select="local_description"/></xsl:when>
					      					<xsl:otherwise><xsl:value-of select="description"/></xsl:otherwise>
					      				</xsl:choose>
					      			</xsl:with-param>
						     	</xsl:call-template>
					     	</xsl:with-param>
					    </xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="description!=''">
						<xsl:call-template name="big-textarea-wrapper">
							<xsl:with-param name="label">XSL_JURISDICTION_PAYEE_DESCRIPTION</xsl:with-param>
							<xsl:with-param name="content">
								<div class="content">
									<xsl:value-of select="description"/>
								</div>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
				
				<!-- empty line -->
     			<div></div>
     			 <xsl:apply-templates select="customer_payee_refs/customer_payee_ref_record"/>	
       			<xsl:if test="$canCheckerReturnComments = 'true'">
      				<xsl:call-template name="comments-for-return-mc">
      					<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
      				</xsl:call-template>
      			</xsl:if>
     		</xsl:with-param>
  		</xsl:call-template>
  	</xsl:template>
  	<!-- Bill reference for Payee Registration -->
  	<xsl:template match="customer_payee_ref_record">
  	<xsl:variable name="payeeCode"><xsl:value-of select="/customer_payee_record/payee_code"/></xsl:variable>
	<xsl:variable name="reference_id"><xsl:value-of select="reference_id"/></xsl:variable>
	<xsl:variable name="loc_lan"><xsl:value-of select="$local_language"/></xsl:variable>
  	<xsl:variable name="user_lan"><xsl:value-of select="$user_language"/></xsl:variable>
  	<xsl:choose>
  	<xsl:when test="input_in_type[.='R']">
  		<xsl:choose>
	  		<xsl:when test="field_type[.='S']">
		      	<script>
			        var item = 0;
			        dojo.ready(function(){
			        	misys._config = misys._config || {};
			        	
				        dojo.mixin(misys._config,{
				        	referenceOptionsArray : misys._config.referenceOptionsArray || []
				        });
				       	misys._config.referenceOptionsArray["<xsl:value-of select="reference_seq"/>"] = misys._config.referenceOptionsArray["<xsl:value-of select="reference_seq"/>"] || [];
				       	
					});
				</script>
				<xsl:variable name="referenceSeq"><xsl:value-of select="reference_seq"/></xsl:variable>
				<xsl:variable name="option"><xsl:value-of select="ref_value"/></xsl:variable>
     			<xsl:call-template name="select-field">
     					<xsl:with-param name="label">
							<xsl:choose>
						    	<xsl:when test="$loc_lan = $user_lan and local_label[.!='']"><xsl:value-of select="local_label"/></xsl:when>
						      	<xsl:otherwise><xsl:value-of select="label"/></xsl:otherwise>
					      	</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="override-label">
							<xsl:choose>
						    	<xsl:when test="$loc_lan = $user_lan and local_label[.!='']"><xsl:value-of select="local_label"/></xsl:when>
						      	<xsl:otherwise><xsl:value-of select="label"/></xsl:otherwise>
					      	</xsl:choose>
						</xsl:with-param>
			      		<xsl:with-param name="name">customer_payee_ref_<xsl:value-of select="reference_seq"/></xsl:with-param>
			      		<xsl:with-param name="required">
			      		<xsl:choose><xsl:when test="optional[.='Y']">N</xsl:when><xsl:otherwise>Y</xsl:otherwise></xsl:choose>
			      		</xsl:with-param>
			      		<xsl:with-param name="value"><xsl:value-of select="ref_value"/></xsl:with-param>
			      		<xsl:with-param name="options">
			      		<xsl:choose>
			      			<xsl:when test="$displaymode='edit'">
								<xsl:for-each select="reference_options/reference_option">
									<option>
										<xsl:attribute name="value"><xsl:value-of select="option_code"></xsl:value-of></xsl:attribute>
										<xsl:value-of select="description" />
									</option>
								</xsl:for-each>
							</xsl:when>
							<xsl:otherwise>
									<option>
										<xsl:attribute name="value"><xsl:value-of select="reference_options/reference_option_selected/option_code"></xsl:value-of></xsl:attribute>
										<xsl:value-of select="reference_options/reference_option_selected/description" />
									</option>
							</xsl:otherwise>	
						</xsl:choose>	
							<xsl:for-each select="reference_options">
								<xsl:variable name="sourceReferenceSeq"><xsl:value-of select="@id"/></xsl:variable>
								<script>
								<xsl:for-each select="related_reference">
								<!-- Initializing the referenceOptions array -->
							  	<xsl:variable name="sourceReferenceValue"><xsl:value-of select="@value"/></xsl:variable>
								dojo.ready(function(){
					        		misys._config.referenceOptionsArray["<xsl:value-of select="$referenceSeq"/>"]["<xsl:value-of select="$sourceReferenceValue" />"] = misys._config.referenceOptionsArray["<xsl:value-of select="$referenceSeq"/>"]["<xsl:value-of select="$sourceReferenceValue" />"] || [];
					        		
								});
								</xsl:for-each>
								<!-- Connect event on the change of the field which has a related reference. The store for the related select field is created onChange. -->
								<xsl:if test="$sourceReferenceSeq != 'null'">
								dojo.subscribe("ready",function(){
							  			misys.connect("customer_payee_ref_<xsl:value-of select="$sourceReferenceSeq"/>","onChange",function(){
							  				dijit.byId("customer_payee_ref_<xsl:value-of select="$referenceSeq"/>").set("value", "");
								  			dijit.byId("customer_payee_ref_<xsl:value-of select="$referenceSeq"/>").store = null;
							  				dijit.byId("customer_payee_ref_<xsl:value-of select="$referenceSeq"/>").store = new dojo.data.ItemFileReadStore({
													data :{
															identifier : "value",
															label : "name",
															items : misys._config.referenceOptionsArray['<xsl:value-of select="$referenceSeq"/>'][this.getValue()]
														  }
														});
								  			});
										  			if(dijit.byId("customer_payee_ref_<xsl:value-of select="$referenceSeq"/>").get("value") === "")
										  			{
										  				<!-- verify if the source reference is selected -->
											  			if(dijit.byId("ref_<xsl:value-of select="$sourceReferenceSeq"/>").get("value") !== "")
											  			{
											  				<!-- as the source reference is selected so creating the store for the related reference -->
											  				dijit.byId("customer_payee_ref_<xsl:value-of select="$referenceSeq"/>").store = new dojo.data.ItemFileReadStore({
															data :{
																identifier : "value",
																label : "name",
																items : misys._config.referenceOptionsArray['<xsl:value-of select="$referenceSeq"/>'][dijit.byId("ref_<xsl:value-of select="$sourceReferenceSeq"/>").get("value")]
															}
															});
															<!-- verify if the related reference has a value -->
															if(dijit.byId("ref_<xsl:value-of select="$referenceSeq"/>").get("value") !== "")
											  				{
												  				<!-- as the related reference has a value so setting its value for display. -->
																dijit.byId("customer_payee_ref_<xsl:value-of select="$referenceSeq"/>").set("value", "<xsl:value-of select="$option"/>");
										  					}
														}
										  			}
						  			});
						  		</xsl:if>
  								
								</script>
								
								<script>
								<!-- Populating the array -->
								<xsl:for-each select="related_reference">
								<xsl:variable name="sourceReferenceValue"><xsl:value-of select="@value"/></xsl:variable>
								dojo.ready(function(){
					        		misys._config.referenceOptionsArray["<xsl:value-of select="$referenceSeq"/>"]["<xsl:value-of select="$sourceReferenceValue" />"] = [
					        		<xsl:for-each select="reference_option">
								    { 
		   								value:"<xsl:value-of select="./option_code"/>",name:"<xsl:value-of select="./description"/>"
		   							}
		   							<xsl:if test="not(position()=last())">,</xsl:if>
									</xsl:for-each>
					        		];
								});
								</xsl:for-each>
								
								</script>
							</xsl:for-each>
						</xsl:with-param>
		     	</xsl:call-template>
		     	<xsl:call-template name="hidden-field">
				   	<xsl:with-param name="name">ref_<xsl:value-of select="reference_seq"/></xsl:with-param>
				   	<xsl:with-param name="value"><xsl:value-of select="ref_value"/></xsl:with-param>
				</xsl:call-template>
     		</xsl:when>
     		<xsl:otherwise>
		    	<xsl:call-template name="input-field">
			      		<xsl:with-param name="label">
			      			<xsl:choose>
		      					<xsl:when test="$loc_lan = $user_lan and local_label[.!='']"><xsl:value-of select="local_label"/></xsl:when>
		      					<xsl:otherwise><xsl:value-of select="label"/></xsl:otherwise>
	      					</xsl:choose>
			      		</xsl:with-param>
			      		<xsl:with-param name="override-label">
			      			<xsl:choose>
		      					<xsl:when test="$loc_lan = $user_lan and local_label[.!='']"><xsl:value-of select="local_label"/></xsl:when>
		      					<xsl:otherwise><xsl:value-of select="label"/></xsl:otherwise>
	      					</xsl:choose>
			      		</xsl:with-param>
			      		<xsl:with-param name="name">customer_payee_ref_<xsl:value-of select="reference_seq"/></xsl:with-param>
			      		<!-- based on confirmation from angelica commented the following line. but as per fds this is the requirement-->
			      		<xsl:with-param name="required">
			      		<xsl:choose><xsl:when test="optional[.='Y']">N</xsl:when><xsl:otherwise>Y</xsl:otherwise></xsl:choose>
			      		</xsl:with-param>
			      		<!--<xsl:with-param name="required">N</xsl:with-param>
			      		--><xsl:with-param name="regular-expression"><xsl:value-of select="validation_format"/></xsl:with-param>
			      		<xsl:with-param name="size">35</xsl:with-param>
		     			<xsl:with-param name="maxsize">35</xsl:with-param>
			      		<xsl:with-param name="fieldsize">small</xsl:with-param>
			      		<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
			      		<xsl:with-param name="value"><xsl:value-of select="ref_value"/></xsl:with-param>
		     	</xsl:call-template>
     		</xsl:otherwise>
     	</xsl:choose>
     	<xsl:if test="help_message[.!=''] or local_help_message[.!='']">
	     	<xsl:call-template name="button-wrapper">
			      <xsl:with-param name="show-image">Y</xsl:with-param>
			      <xsl:with-param name="show-border">N</xsl:with-param>		      
	      		  <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($checkOrRevertImage)"/></xsl:with-param>
	      		  <xsl:with-param name="onclick">misys.showHelp('customer_payee_ref_<xsl:value-of select="reference_seq"/>');return false;</xsl:with-param>
	      		  <xsl:with-param name="non-dijit-button">N</xsl:with-param>
		   	 </xsl:call-template>
	   	 </xsl:if>	
		<div></div><!-- empty line -->
		<div style="display:block">
      	<xsl:call-template name="hidden-field">
	     	<xsl:with-param name="name">help_customer_payee_ref_<xsl:value-of select="reference_seq"/></xsl:with-param>
	     	<xsl:with-param name="value">
	     	<xsl:choose>
		      	<xsl:when test="$loc_lan = $user_lan and local_label[.!='']"><xsl:value-of select="local_help_message"/></xsl:when>
		      	<xsl:otherwise><xsl:value-of select="help_message"/></xsl:otherwise>
	      	</xsl:choose>
	        </xsl:with-param>
      	</xsl:call-template>
     	 </div>
      </xsl:when>
     </xsl:choose>
</xsl:template>
 

 <!-- ***************************************************************************************** -->
 <!-- ************************************** REALFORM ***************************************** -->
 <!-- ***************************************************************************************** -->
 <xsl:template name="realform">
  <!-- Do not display this section when the counterparty mode is 'counterparty' -->
  <xsl:if test="$collaborationmode != 'counterparty'">
  <xsl:call-template name="form-wrapper">
   <xsl:with-param name="name">realform</xsl:with-param>
   <xsl:with-param name="method">POST</xsl:with-param>
   <xsl:with-param name="action"> <xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:with-param>
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
        <xsl:with-param name="value"><xsl:value-of select="$option"/></xsl:with-param>
      </xsl:call-template>
       <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">processdttm</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$processdttm"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">bankName</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select ="/customer_payee_record/bank_abbv_name"></xsl:value-of></xsl:with-param>
      </xsl:call-template>
      
      <xsl:choose>
      <xsl:when test="customer_payee_record/customer_payee_id[.!='']">
      	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">featureid</xsl:with-param>
       		<xsl:with-param name="value"><xsl:value-of select="customer_payee_record/customer_payee_id"/></xsl:with-param>
      	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
      	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">featureid</xsl:with-param>
       		<xsl:with-param name="value"><xsl:value-of select="customer_payee_record/master_payee_id"/></xsl:with-param>
      	</xsl:call-template>
      </xsl:otherwise>
      </xsl:choose>
       <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">mode</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$draftMode"/></xsl:with-param>
      </xsl:call-template>
      <xsl:if test="customer_payee_record/tnx_id[.!='']">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">tnxid</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="customer_payee_record/tnx_id"/></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:call-template name="reauth_params"/>
      <xsl:call-template name="e2ee_transaction"/>
      <!--<xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">mode</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$displaymode"/></xsl:with-param>
      </xsl:call-template>
     --></div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
</xsl:stylesheet>