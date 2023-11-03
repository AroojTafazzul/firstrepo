<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for the details of

Transaction Bulk (BK) Form, Customer Side.

Copyright (c) 2000-2012 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      10/02/12
author:    Mauricio
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
        xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
        xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
        xmlns:collabutils="xalan://com.misys.portal.common.tools.CollaborationUtils"
        xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
        exclude-result-prefixes="localization securitycheck utils defaultresource collabutils">
        
        <xsl:param name="openPending">false</xsl:param>
        <xsl:param name="optionmode">edit</xsl:param>
	    <xsl:param name="option">BULK</xsl:param>
        <xsl:param name="isMultiBank">N</xsl:param>
        <xsl:param name="nicknameEnabled"/>
        <xsl:param name="option_for_app_date"/>
        <xsl:param name="beneficiaryNicknameEnabled"/>

<xsl:include href="bk_common.xsl"/>

<!-- 
	 BK TNX FORM TEMPLATE.
	-->
	<xsl:template match="bk_tnx_record">
		<!-- Preloader  -->

		<script>
			dojo.ready(function(){
			
         	  	misys._config = (misys._config) || {};
				misys._config.nickname = '<xsl:value-of select="$nicknameEnabled"/>';
				misys._config.option_for_app_date = '<xsl:value-of select="$option_for_app_date"/>';	
				misys._config.beneficiarynickname = '<xsl:value-of select="$beneficiaryNicknameEnabled"/>';
				misys._config.businessDateForBank = misys._config.businessDateForBank || 
				{
					<xsl:value-of select="utils:getAllBankBusinessDate($rundata)"/>
				};
	            misys._config.isMultiBank =<xsl:choose>
									 			<xsl:when test="$isMultiBank='Y'">true</xsl:when>
									 			<xsl:otherwise>false</xsl:otherwise>
									 		</xsl:choose>;
	            <xsl:if test="$isMultiBank='Y'">
	            dojo.mixin(misys._config, {
					entityBanksCollection : {
			   			<xsl:if test="count(/bk_tnx_record/avail_main_banks/entities_banks_list/entity_banks/mb_entity) > 0" >
			        		<xsl:for-each select="/bk_tnx_record/avail_main_banks/entities_banks_list/entity_banks/mb_entity" >
			        			<xsl:variable name="mb_entity" select="self::node()/text()" />
			  						<xsl:value-of select="."/>: [
			   						<xsl:for-each select="/bk_tnx_record/avail_main_banks/entities_banks_list/entity_banks[mb_entity=$mb_entity]/customer_bank" >
			   							{ value:"<xsl:value-of select="."/>",
					         				name:"<xsl:value-of select="."/>"},
			   						</xsl:for-each>
			   						]<xsl:if test="not(position()=last())">,</xsl:if>
			         		</xsl:for-each>
			       		</xsl:if>
					},
					<!-- Banks for without entity customers.  -->
					wildcardLinkedBanksCollection : {
			   			<xsl:if test="count(/bk_tnx_record/avail_main_banks/bank/abbv_name) > 0" >
			  						"customerBanksForWithoutEntity" : [
				        			<xsl:for-each select="/bk_tnx_record/avail_main_banks/bank/abbv_name" >
			   							{ value:"<xsl:value-of select="."/>",
					         				name:"<xsl:value-of select="."/>"},
				         			</xsl:for-each>
			   						]
			       		</xsl:if>
					},
					
					customerBankDetails : {
			       		<xsl:if test="count(/bk_tnx_record/customer_banks_details/bank_abbv_desc/bank_abbv_name) > 0" >
			        		<xsl:for-each select="/bk_tnx_record/customer_banks_details/bank_abbv_desc/bank_abbv_name" >
			        			<xsl:variable name="bank_abbv_name" select="self::node()/text()" />
			  						<xsl:value-of select="."/>: [
			   						<xsl:for-each select="/bk_tnx_record/customer_banks_details/bank_abbv_desc[bank_abbv_name=$bank_abbv_name]/bank_desc" >
			   							{ value:"<xsl:value-of select="."/>",
					         				name:"<xsl:value-of select="."/>"},
			   						</xsl:for-each>
			   						]<xsl:if test="not(position()=last())">,</xsl:if>
			         		</xsl:for-each>
			       		</xsl:if>
					},
					
					bankBaseCurCode :	{
						<xsl:for-each select="/bk_tnx_record/avail_main_banks/bank">
		  						"<xsl:value-of select="abbv_name"/>": "<xsl:value-of select="bank_base_cur_code"/>"
		   						<xsl:if test="not(position()=last())">,</xsl:if>
		         		</xsl:for-each>
		         	}
				});
				</xsl:if>
			});
	  	</script>
				
		<xsl:call-template name="loading-message"/>
		
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
		    <!-- Form #0 : Main Form -->
		    <xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name"/>
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
		      		
		      		<xsl:call-template name="js-bulk-product-collections">
		      			<xsl:with-param name="isFromDraft" select="$openPending"/>
		      		</xsl:call-template>
		      		
		      		<!-- Disclaimer Notice -->
		      		<xsl:call-template name="disclaimer"/>      
			      	<xsl:call-template name="bk-hidden-fields" />	      	    
					<div id="content1">
					 <xsl:if test="$displaymode != 'view'">
					 	<xsl:call-template name="fieldset-wrapper">	
				    		<xsl:with-param name="legend">XSL_HEADER_BK_DETAILS</xsl:with-param>
				    		<xsl:with-param name="content">
				    			<xsl:if test="entities[number(.) &gt; 0]">
								  	<xsl:call-template name="entity-field">
									    <xsl:with-param name="required">Y</xsl:with-param>
									    <xsl:with-param name="button-type">entity</xsl:with-param>
									    <xsl:with-param name="prefix">applicant</xsl:with-param>
									    <!-- <xsl:with-param name="override-sub-product-code">BK:MPIBX,BK:MLIBP,BK:MLIBR,BK:MPMEP,BK:MPMT3,BK:MPPCO,BK:MPPID,BK:MLIBM,BK:MPIBG,BK:MLIBX</xsl:with-param>  -->
									    <xsl:with-param name="override-sub-product-code">BK:MPTPT,BK:MPINT,BK:MPDOM,BK:MPMT3</xsl:with-param>
								    </xsl:call-template>
								</xsl:if>
								<!-- Bank to which Bulk-order needs to be linked to. -->
								<xsl:if test="$isMultiBank='Y'">
									<xsl:choose>
										<xsl:when test="$displaymode = 'edit'">
											<xsl:call-template name="select-field">
												<xsl:with-param name="label">CUSTOMER_BANK_LABEL</xsl:with-param>
												<xsl:with-param name="name">customer_bank</xsl:with-param>
												<xsl:with-param name="required">Y</xsl:with-param>
											</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											 <xsl:call-template name="input-field">
												<xsl:with-param name="label">CUSTOMER_BANK_LABEL</xsl:with-param>
												<xsl:with-param name="name">customer_bank</xsl:with-param>
												<xsl:with-param name="override-displaymode">view</xsl:with-param>
												<xsl:with-param name="disabled">Y</xsl:with-param>
								   			</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">customer_bank_hidden</xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select="customer_bank"/></xsl:with-param>
									</xsl:call-template>
									<!-- Message Div: No Customer Bank available. Try with different Entity or Bank! whichever applicable. -->
							 		<div id="no-customer-bank-message-div">
										<xsl:call-template name="server-message">
											<xsl:with-param name="name">no_customer_bank_message</xsl:with-param>
											<xsl:with-param name="show-close">N</xsl:with-param>
											<xsl:with-param name="content">
												<xsl:value-of select="localization:getGTPString($language, 'MSG_NO_CUSTOMER_BANK_AVAILABLE')"/>
											</xsl:with-param>
											<!-- This is not a server message we are just using the serverMessage CSS style. -->
											<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
										</xsl:call-template>
							    	</div>
								</xsl:if>								
								  	<xsl:call-template name="select-field">
								  	    <xsl:with-param name="label">XSL_BK_PRODUCT_GROUP_LABEL</xsl:with-param>
									    <xsl:with-param name="required">Y</xsl:with-param>
									    <xsl:with-param name="name">bk_type</xsl:with-param>
									    <xsl:with-param name="value"><xsl:value-of select="bk_type"/></xsl:with-param>
									</xsl:call-template>
								    <xsl:if test="$displaymode='edit' or ($displaymode='view' and bk_type='PAYRL')">
									<div id="payrolltype">
										<xsl:call-template name="select-field">
									  	    <xsl:with-param name="label">XSL_BK_PAYROLL_TYPE_LABEL</xsl:with-param>
										    <xsl:with-param name="name">payroll_type</xsl:with-param>
										    <xsl:with-param name="required">N</xsl:with-param>
										</xsl:call-template>
									</div>
								 </xsl:if>
									 <!-- Add logic depending on previous fieds -->
									<xsl:choose>
										<xsl:when test="child_sub_product_code[.='']">
											<xsl:call-template name="select-field">
										    	<xsl:with-param name="label">XSL_CHILD_SUB_PRODUCT_CODE</xsl:with-param>
											    <xsl:with-param name="required">Y</xsl:with-param>
											     <xsl:with-param name="name">child_sub_product_code</xsl:with-param>
											</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
												<xsl:call-template name="input-field">
											  	    <xsl:with-param name="label">XSL_CHILD_SUB_PRODUCT_CODE</xsl:with-param>
												    <xsl:with-param name="name">child_sub_product_code</xsl:with-param>
												    <xsl:with-param name="required">Y</xsl:with-param>
												    <xsl:with-param name="readonly">Y</xsl:with-param>
												</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								    
								   
								    <!--  FOR TEST SUB PRODUCT CODE: hidden --><!--
								  	<xsl:call-template name="input-field">
								  	    <xsl:with-param name="label">XSL_BULK_TYPE</xsl:with-param>
									    <xsl:with-param name="id">sub_product_code_display</xsl:with-param>
									    <xsl:with-param name="required">Y</xsl:with-param>
									    <xsl:with-param name="readonly">Y</xsl:with-param>
									    <xsl:with-param name="product-types-required">Y</xsl:with-param>
									     <xsl:with-param name="value">
       									<xsl:value-of select="localization:getDecode($language, 'N047',sub_product_code)"/>
									   </xsl:with-param>
									</xsl:call-template>-->
										<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">sub_product_code_display</xsl:with-param>
											<xsl:with-param name="value"></xsl:with-param>
										</xsl:call-template>
									<div id="display_sub_product_code_row" class="field">
									  <span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_BULK_TYPE')"/></span>
									  <div class="content" id="display_value_sub_product_code_row"><xsl:value-of select="localization:getDecode($language, 'N047',sub_product_code)"/></div> 
								  	</div>

									<div id="otherpayments">
								    	<xsl:call-template name="user-account-field">
									     	<xsl:with-param name="label">XSL_TRANSFER_FROM</xsl:with-param>			
										    <xsl:with-param name="name">applicant</xsl:with-param>
										    <xsl:with-param name="entity-field">entity</xsl:with-param>
										    <xsl:with-param name="required">Y</xsl:with-param>
										    <xsl:with-param name="dr-cr">debit</xsl:with-param>
										    <xsl:with-param name="show-product-types">N</xsl:with-param>
										    <xsl:with-param name="product_types-as-js">Y</xsl:with-param>
										    <xsl:with-param name="product_types">'BK:'+dijit.byId('sub_product_code').get('value')</xsl:with-param>
										    <!-- xsl:with-param name="product_types">FT:MT101,FT:FI202,FT:FI103,FT:MT103,FT:IBG,FT:IAFT,FT:MEPS,FT:PICO,FT:PIDD,FT:IBGEX,FT:GPC</xsl:with-param-->
										    <xsl:with-param name="product-types-required">N</xsl:with-param>
								    	</xsl:call-template>
							    	</div>
							    	
							        <div id="collection">
								    	<xsl:call-template name="user-account-field">
									     	<xsl:with-param name="label">XSL_TRANSFER_TO</xsl:with-param>			
										    <xsl:with-param name="name">applicant_collection</xsl:with-param>
										    <xsl:with-param name="entity-field">entity</xsl:with-param>
										    <xsl:with-param name="required">Y</xsl:with-param>
										    <xsl:with-param name="dr-cr">credit</xsl:with-param>
										    <xsl:with-param name="show-product-types">N</xsl:with-param>
										    <xsl:with-param name="product_types-as-js">Y</xsl:with-param>
										    <xsl:with-param name="product_types">'BK:'+dijit.byId('sub_product_code').get('value')</xsl:with-param>
										    <!-- xsl:with-param name="product_types">FT:MT101,FT:FI202,FT:FI103,FT:MT103,FT:IBG,FT:IAFT,FT:MEPS,FT:PICO,FT:PIDD,FT:IBGEX,FT:GPC</xsl:with-param-->
										    <xsl:with-param name="product-types-required">N</xsl:with-param>
								    	</xsl:call-template>
								    </div>
							    	<!-- xsl:if test="($displaymode='view' )">
							    		<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">sub_product_code</xsl:with-param>
											<xsl:with-param name="value" select="sub_product_code"/>
										</xsl:call-template>
							    	</xsl:if-->
							    	<xsl:if test="($displaymode='view' and bk_type='PAYRL')">
							    		<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">payroll_type</xsl:with-param>
											<xsl:with-param name="value" select="payroll_type"/>
										</xsl:call-template>
							    	</xsl:if>
									<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">sub_product_code_hidden</xsl:with-param>
										<xsl:with-param name="value" select="sub_product_code"/>
									</xsl:call-template>
									<xsl:call-template name="currency-field">
									  <xsl:with-param name="label">XSL_BK_CURRENCY</xsl:with-param>
									  <xsl:with-param name="product-code">bk</xsl:with-param>
									  <xsl:with-param name="required">Y</xsl:with-param>
									  <xsl:with-param name="show-amt">N</xsl:with-param>
									   <xsl:with-param name="currency-readonly">Y</xsl:with-param>
									   <xsl:with-param name="show-button">N</xsl:with-param>									 								  
									</xsl:call-template>
									<xsl:value-of select="bk_cur_code"></xsl:value-of>
									<div id = "clearingCode_div">
									   <xsl:if test="$displaymode='edit'">
										     <xsl:call-template name="select-field">
										  	    <xsl:with-param name="label">XSL_CLEARING_CODE_NAME</xsl:with-param>
												<xsl:with-param name="name">clearing_code</xsl:with-param>
												<xsl:with-param name="fieldsize">small</xsl:with-param>
											    <xsl:with-param name="name">clearing_code</xsl:with-param>
											    <xsl:with-param name="options">			       		
													<option value="NEFT">
														<xsl:value-of select="localization:getGTPString($language, 'IFSC_NEFT')"/>
													</option>
													<option value="RTGS">
														<xsl:value-of select="localization:getGTPString($language, 'IFSC_RTGS')"/>
													</option>
												</xsl:with-param>	
												</xsl:call-template>		
										</xsl:if>
									</div>
									<xsl:if test="$displaymode='edit'"> 
								     <div id="pab_checkbox_row">
								       <xsl:call-template name="multichoice-field"> 
  			 							<xsl:with-param name="type">checkbox</xsl:with-param> 
     								    <xsl:with-param name="label">XSL_TABLE_HEADER_PAB</xsl:with-param> 
 	  			 						<xsl:with-param name="name">pre_approved</xsl:with-param>
  	  								   </xsl:call-template>
								     </div>
								   </xsl:if>
									<xsl:if test="$displaymode='edit'">
									 <div id="initButtons">
										<div dojoType="dijit.form.Button" id="button_intrmdt_ok">
														<xsl:value-of select="localization:getGTPString($language, 'OK')"/>
										</div>
									 </div>
									 <script>
									   dojo.ready(function(){
										        	misys._config = misys._config || {};
													misys._config.customerReferences = {};
														<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
													misys._config.non_pab_allowed = <xsl:value-of select="defaultresource:getResource('NON_PAB_ALLOWED')"/>;	
													});
									</script>
								    </xsl:if>
								    <xsl:call-template name="column-wrapper">
										<xsl:with-param name="content">
											<xsl:call-template name="hidden-field">
												<xsl:with-param name="name">sub_product_code_unsigned</xsl:with-param>
												<xsl:with-param name="value" select="sub_product_code"></xsl:with-param>
											</xsl:call-template>
											<xsl:call-template name="hidden-field">
												<xsl:with-param name="name">display_entity_unsigned</xsl:with-param>
												<xsl:with-param name="value" select="entity"></xsl:with-param>
											</xsl:call-template>
											<xsl:call-template name="hidden-field">
												<xsl:with-param name="name">bk_cur_code_unsigned</xsl:with-param>
												<xsl:with-param name="value" select="bk_cur_code"></xsl:with-param>
											</xsl:call-template>
											<xsl:call-template name="hidden-field">
												<xsl:with-param name="name">bk_total_amt_unsigned</xsl:with-param>
												<xsl:with-param name="value" select="bk_total_amt"></xsl:with-param>
											</xsl:call-template>								
										</xsl:with-param>
									</xsl:call-template>
					   		</xsl:with-param>
				   		</xsl:call-template>
				   	 </xsl:if>
					</div>
				
					<div id="content2">	      		
						<!--  Display common menu. -->
						<xsl:call-template name="menu">
							<xsl:with-param name="show-cancel-bulk">Y</xsl:with-param>
							<xsl:with-param name="show-reject">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'">Y</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-return">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-submit-bulk">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'or (modifiedBeneficiary[.='Y'])">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-submit">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'or ($mode='UNSIGNED' and modifiedBeneficiary[.='Y'])">N</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-save">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-template">
								<xsl:choose>
									<xsl:when test="bulk_ref_id[.!='']">N</xsl:when>
									<xsl:when test="$optionmode='CANCEL'">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<!-- Reauthentication -->
					    <xsl:call-template name="server-message">
					 		<xsl:with-param name="name">server_message</xsl:with-param>
					 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
					 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="reauthentication" />
						
						<xsl:call-template name="bulk-general-details" >
		      		   		  <xsl:with-param name="show-child-transactions">Y</xsl:with-param>
		      		   		  <xsl:with-param name="show-eligible-bulks-for-merge">N</xsl:with-param>
		      		   		  <xsl:with-param name="child-product-code"><xsl:value-of select="child_product_code"/></xsl:with-param>
		      		   		</xsl:call-template>
		      		   	
	      		   		<!-- comments for return -->
	      		   		<xsl:if test="tnx_stat_code[.!='03' and .!='04']">   <!-- MPS-43899 -->
	     					<xsl:call-template name="comments-for-return">
		  						<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
		   						<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
	   	 					</xsl:call-template>
   	 					</xsl:if>
   	 					<xsl:call-template name="menu">
							<xsl:with-param name="show-cancel-bulk">Y</xsl:with-param>
							<xsl:with-param name="second-menu">Y</xsl:with-param>
							<xsl:with-param name="show-reject">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'">Y</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-return">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-template">
								<xsl:choose>
									<xsl:when test="bulk_ref_id[.='']">Y</xsl:when>
									<xsl:when test="$optionmode='CANCEL'">N</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-submit-bulk">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'or (modifiedBeneficiary[.='Y'])">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-submit">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'or ($mode='UNSIGNED' and modifiedBeneficiary[.='Y'])">N</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-save">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</div>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="realform"/>
		</div>
       
        <!--  Collaboration Window -->
        <xsl:if test="$collaborationmode != 'none'">
       		<xsl:call-template name="collaboration">
			    <xsl:with-param name="editable">true</xsl:with-param>
			    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
			    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
			    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
				<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
			</xsl:call-template>
			<script>
				dojo.ready(function(){			
	         	  	misys._config = misys._config || {};			
					misys._config.task_mode = '<xsl:value-of select="collabutils:getProductTaskMode($rundata, $product-code, sub_product_code)"/>';
				});
		  	</script>
		</xsl:if>
       
		<!-- Javascript imports  -->
		<xsl:call-template name="js-imports"/> 
	</xsl:template>
  
  	<!--
	Real form for Bulk
	-->
	<xsl:template name="realform">
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name">realform</xsl:with-param>
			<xsl:with-param name="method">POST</xsl:with-param>
			<xsl:with-param name="action" select="$realform-action"/>
			<xsl:with-param name="content">
				<div class="widgetContainer">
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">referenceid</xsl:with-param>
						<xsl:with-param name="value" select="ref_id"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">tnxid</xsl:with-param>
						<xsl:with-param name="value" select="tnx_id"/>
					</xsl:call-template>      
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">operation</xsl:with-param>
						<xsl:with-param name="id">realform_operation</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">mode</xsl:with-param>
						<xsl:with-param name="value" select="$mode"/>
					</xsl:call-template> 
					<xsl:if test="$option='CANCEL'">
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">option</xsl:with-param>
							<xsl:with-param name="value" select="$option"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="$option !='CANCEL'">
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">option</xsl:with-param>
							<xsl:with-param name="value">BULK</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">tnxtype</xsl:with-param>
						<xsl:with-param name="value">01</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">attIds</xsl:with-param>
						<xsl:with-param name="value"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">TransactionData</xsl:with-param>
						<xsl:with-param name="value"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">bulk_autoforward</xsl:with-param>
						<xsl:with-param name="value"/>
					</xsl:call-template>   
					<xsl:call-template name="e2ee_transaction"/>
					<xsl:call-template name="reauth_params"/>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">applicant_act_no</xsl:with-param>
    					<xsl:with-param name="value"><xsl:value-of select="applicant_act_no"/></xsl:with-param>
					</xsl:call-template>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="bulk-transaction-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend"></xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<!-- LEP Transaction Amount Field -->
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_BK_CURRENCY</xsl:with-param>
									<xsl:with-param name="product-code">bk</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="show-amt">N</xsl:with-param>
								</xsl:call-template>
							  	<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>	
									<xsl:with-param name="name">cust_ref_id</xsl:with-param>
									<xsl:with-param name="size">16</xsl:with-param>
									<xsl:with-param name="maxsize">64</xsl:with-param>
									<xsl:with-param name="fieldsize">small</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="textarea-field">	
									<xsl:with-param name="label">XSL_GENERALDETAILS_PAYMENT_DETAILS</xsl:with-param>
									<xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
									<xsl:with-param name="cols">35</xsl:with-param>
									<xsl:with-param name="rows">4</xsl:with-param>
									<xsl:with-param name="maxlines">4</xsl:with-param>	
									<xsl:with-param name="swift-validate">Y</xsl:with-param>
						 		</xsl:call-template>
						 		<xsl:if test="$displaymode='edit'">
									<div id="initButtons">
										<div dojoType="dijit.form.Button" id="button_intrmdt_ok">
											<xsl:value-of select="localization:getGTPString($language, 'OK')"/>
										</div>
									</div>
							        <script>
							        	dojo.ready(function(){
							        		misys._config = misys._config || {};
											misys._config.customerReferences = {};
											<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
										});
									</script>
							     </xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">sub_product_code_unsigned</xsl:with-param>
									<xsl:with-param name="value" select="sub_product_code"></xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">display_entity_unsigned</xsl:with-param>
									<xsl:with-param name="value" select="entity"></xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">bk_cur_code_unsigned</xsl:with-param>
									<xsl:with-param name="value" select="bk_cur_code"></xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">bk_total_amt_unsigned</xsl:with-param>
									<xsl:with-param name="value" select="bk_total_amt"></xsl:with-param>
								</xsl:call-template>								
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>