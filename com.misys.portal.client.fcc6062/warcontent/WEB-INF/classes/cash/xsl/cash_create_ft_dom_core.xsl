<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Domestic Fund Transfer (FT-DOM) Form.

Copyright (c) 2000-2012 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      25/10/2012
author:    Mauricio Moura
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:collabutils="xalan://com.misys.portal.common.tools.CollaborationUtils"
	exclude-result-prefixes="xmlRender localization ftProcessing securitycheck utils security defaultresource collabutils">

	<!-- 
	Global Parameters.
	These are used in the imported XSL, and to set global params in the JS 
	-->
	<xsl:param name="rundata"/>
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	<xsl:param name="product-code">FT</xsl:param> 
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="optionmode">edit</xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/FundTransferScreen</xsl:param>
	<xsl:param name="isMultiBank">N</xsl:param>
	<xsl:param name="nicknameEnabled"/>
	<xsl:param name="option_for_app_date"/>
	<xsl:param name="beneficiaryNicknameEnabled"/>	
	
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="clearImage"><xsl:value-of select="$images_path"/>pic_clear.gif</xsl:param>
	
	
	<!-- Global Imports. -->
	<xsl:include href="../../core/xsl/common/trade_common.xsl" />
	<xsl:include href="./common/ft_common.xsl" />
	<xsl:include href="../../core/xsl/common/fx_common.xsl" />
	<xsl:include href="../../core/xsl/common/fx_common_multibank.xsl" />
	<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/">
		<xsl:apply-templates select="ft_tnx_record"/>
	</xsl:template>
	
	<xsl:template match="ft_tnx_record">
		<!-- Preloader -->

		<script>
			dojo.ready(function(){
			
         	  	misys._config = (misys._config) || {};	
         	  	misys._config.nickname = '<xsl:value-of select="$nicknameEnabled"/>';
         	  	misys._config.beneficiarynickname = '<xsl:value-of select="$beneficiaryNicknameEnabled"/>';
         	  	misys._config.option_for_app_date = '<xsl:value-of select="$option_for_app_date"/>';
				misys._config.recurring_product = misys._config.recurring_product || 
			   {
			   <xsl:for-each select="recurring_payment/recurring_product">
			     '<xsl:value-of select="sub_prod_type" />':'<xsl:value-of select="flag" />'
			     <xsl:if test="position()!=last()">,</xsl:if>
			   </xsl:for-each> 
			   };	
			   
			    <xsl:if test="$isMultiBank !='Y'">
					misys._config.offset = misys._config.offset ||
					[ 
					{
					<xsl:for-each select="start_dt_offset/offset">
							'<xsl:value-of select="sub_prod_type_offset" />':[<xsl:value-of select="minimum_offset" />,<xsl:value-of select="maximum_offset" />]
							<xsl:if test="position()!=last()">,</xsl:if>
					</xsl:for-each>	
					}
					];	
					misys._config.frequency_mode = misys._config.frequency_mode || 
					[
					{
					<xsl:for-each select="frequency/frequency_mode">
						'<xsl:value-of select="frequency_type"/>':['<xsl:value-of select="exact_flag" />','<xsl:value-of select="last_flag" />','<xsl:value-of select="transfer_limit" />']
		            	<xsl:if test="position()!=last()">,</xsl:if>
		            </xsl:for-each>
		            }
		            ];		
				</xsl:if>
				<xsl:if test="$isMultiBank ='Y'">
					misys._config.offset = misys._config.offset ||
						[ 
						{
						<xsl:for-each select="start_dt_offset/offset">
								'<xsl:value-of select="sub_prod_type_offset" />_<xsl:value-of select="bank" />':[<xsl:value-of select="minimum_offset" />,<xsl:value-of select="maximum_offset" />]
								<xsl:if test="position()!=last()">,</xsl:if>
						</xsl:for-each>	
						}
						];
						misys._config.frequency_mode = misys._config.frequency_mode || 
			            [
			            {
			            <xsl:for-each select="/ft_tnx_record/frequency/frequency_per_bank">
				   						<xsl:for-each select="frequency_mode">
											'<xsl:value-of select="frequency_type"/>_<xsl:value-of select="bank_abbv_name"/>':['<xsl:value-of select="exact_flag" />','<xsl:value-of select="last_flag" />','<xsl:value-of select="transfer_limit" />']
				            					<xsl:if test="position()!=last()">,</xsl:if>
				            			</xsl:for-each>
				            			<xsl:if test="count(frequency_mode) > 0">
				            				<xsl:if test="position()!=last()">,</xsl:if>
				            			</xsl:if>
			         	</xsl:for-each>
			         	}
			         	];
				</xsl:if>
	            misys._config.isMultiBank =<xsl:choose>
									 			<xsl:when test="$isMultiBank='Y'">true</xsl:when>
									 			<xsl:otherwise>false</xsl:otherwise>
									 		</xsl:choose>;
	            <xsl:if test="$isMultiBank='Y'">
		            <xsl:call-template name="per-bank-recurring"/>
		            <xsl:call-template name="per-bank-recurring-frequency"/>
	            	<xsl:call-template name="multibank-common-details"/>
				</xsl:if>
			});
	  	</script>  
		
		<xsl:call-template name="loading-message"/>
     
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name" />
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
					<!-- Disclaimer Notice -->
					<xsl:call-template name="disclaimer" />
					<xsl:call-template name="hidden-fields" />
					<xsl:if test="$displaymode='edit'">
						<div id="DOM_DISCLAIMER" class="ftDisclaimer domDisclaimer">
							<xsl:call-template name="simple-disclaimer">
								<xsl:with-param name="label">XSL_FT_DOM_DISCLAIMER</xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:if>
					<div>
						<!-- Display common menu. -->
						<xsl:call-template name="menu">
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
							<xsl:with-param name="show-submit">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'or ($mode='UNSIGNED' and modifiedBeneficiary[.='Y'])">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
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
						<xsl:call-template name="server-message">
							<xsl:with-param name="name">server_message</xsl:with-param>
							<xsl:with-param name="content"><xsl:value-of select="message" /></xsl:with-param>
							<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
						</xsl:call-template>
						<!-- Reauthentication -->
						<xsl:call-template name="reauthentication" />
						<!-- Transfer sections -->						
						<xsl:call-template name="dom-general-details"/>
						<xsl:call-template name="recurring_content">
							<xsl:with-param name="isMultiBank"><xsl:value-of select="$isMultiBank"/></xsl:with-param>
							<xsl:with-param name="override-displaymode"><xsl:value-of select="$displaymode"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="dom-transfer-to-details" />
						<xsl:call-template name="dom-transaction-details" />
						<!-- FX Snippets Start -->
							<xsl:if test="not(amount_access) or  (amount_access[.='true'])">
								<xsl:if test="$displaymode='edit'and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_bank_product_details/fx_bank_properties/fx_assign_products[.='Y']">  
									<xsl:call-template name="fx-template"/>
								</xsl:if>  
								<xsl:if test="$displaymode='view' and fx_rates_type and fx_rates_type[.!='']">
									<xsl:call-template name="fx-details-for-view" /> 
								</xsl:if>
							</xsl:if>
							<!-- FX Snippets End -->  
						<xsl:call-template name="dom-notify-beneficiary-details" />

						<xsl:call-template name="transaction-remarks-details" />
						<!-- comments for return -->
						<xsl:if test="$optionmode!='CANCEL'">
     						<xsl:call-template name="comments-for-return">
	  							<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   							<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	 						</xsl:call-template>
						</xsl:if>

						<!-- Display common menu, this time under the form -->
						<xsl:call-template name="menu">
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
							<xsl:with-param name="show-submit">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'or ($mode='UNSIGNED' and modifiedBeneficiary[.='Y'])">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
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
			<xsl:call-template name="realform" />    
		</div>
		
	   <!--  Collaboration Window --> 
	   <xsl:if test="$collaborationmode != 'none' and ( not(bulk_ref_id) or bulk_ref_id[.=''] )">
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
	Real form for FT DOM
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
					<xsl:if test="$option='CANCEL'">
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">option</xsl:with-param>
							<xsl:with-param name="value" select="$option"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">option_for_tnx</xsl:with-param>
							<xsl:with-param name="value" select="$option"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">mode</xsl:with-param>
						<xsl:with-param name="value" select="$mode"/>
					</xsl:call-template> 
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
					<xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_bank_product_details/fx_bank_properties/fx_assign_products[.='Y']">
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">fxinteresttoken</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="hidden-field">
					    <xsl:with-param name="name">productcode</xsl:with-param>
					    <xsl:with-param name="value" select="$product-code"/>
				    </xsl:call-template>
				    <xsl:call-template name="hidden-field">
				    	<xsl:with-param name="name">subproductcode</xsl:with-param>
				    	<xsl:with-param name="value"><xsl:value-of select="sub_product_code"/></xsl:with-param>
				   	</xsl:call-template>
					<xsl:call-template name="e2ee_transaction"/>
					<xsl:call-template name="reauth_params"/>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.cash.create_ft_dom</xsl:with-param>
			<xsl:with-param name="override-help-access-key">
			     <xsl:choose>
			       <xsl:when test="$option ='CANCEL'">FT_CANCEL</xsl:when>
			       <xsl:otherwise>CASH_FT</xsl:otherwise>
			     </xsl:choose>
 		  </xsl:with-param> 
		</xsl:call-template>
		<script>
			dojo.ready(function(){
				misys._config = (misys._config) || {};
				misys._config.offset = misys._config.offset ||
				[{
					<xsl:for-each select="start_dt_offset/offset">
						'<xsl:value-of select="sub_prod_type_offset" />':[<xsl:value-of select="minimum_offset" />,<xsl:value-of select="maximum_offset" />]
						<xsl:if test="position()!=last()">,</xsl:if>
					</xsl:for-each>	
				}];			
		});
		</script>
 	</xsl:template>



	<xsl:template name="dom-transfer-to-details">
		<xsl:variable name="pre-approved_beneficiary_only" select="not(securitycheck:hasPermission(utils:getUserACL($rundata),'ft_regular_beneficiary_access',utils:getUserEntities($rundata))) or (defaultresource:getResource('NON_PAB_ALLOWED') = 'false')"/>

	   	<!-- Transfer to options for 3rd party transfer -->
		<xsl:call-template name="fieldset-wrapper">
		  <xsl:with-param name="legend">XSL_HEADER_TRANSFER_TO_DETAILS</xsl:with-param>
			 <xsl:with-param name="content">
			 <xsl:call-template name="column-container">
					<xsl:with-param name="content">
				   <xsl:call-template name="column-wrapper">
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PARTIESDETAILS_BENEFICIARY_NAME</xsl:with-param>
							<xsl:with-param name="name">beneficiary_name</xsl:with-param>		
							<xsl:with-param name="swift-validate">Y</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_name"/></xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>	
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<!-- <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_REGEX')"/></xsl:with-param> -->
							<xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>				
						</xsl:call-template>
						
						<xsl:if test="$displaymode='edit'">
							<xsl:call-template name="button-wrapper">
								<xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
								<xsl:with-param name="show-image">Y</xsl:with-param>
								<xsl:with-param name="show-border">N</xsl:with-param>
								<xsl:with-param name="id">beneficiary_img</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="not($pre-approved_beneficiary_only)">
								<xsl:call-template name="button-wrapper">
									<xsl:with-param name="id">clear_img</xsl:with-param>
									<xsl:with-param name="label">XSL_ALT_CLEAR</xsl:with-param>
									<xsl:with-param name="show-image">Y</xsl:with-param>
									<xsl:with-param name="show-border">N</xsl:with-param>
									<xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($clearImage)"/></xsl:with-param>
								</xsl:call-template>					   
							</xsl:if>
						</xsl:if>
						<xsl:call-template name="beneficiary-nickname-field-template"/>
						
						<xsl:call-template name="row-wrapper">
							<xsl:with-param name="required"><xsl:if test="$displaymode = 'edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="label">XSL_BENEFICIARY_ACCOUNT</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:if test="$displaymode = 'edit' or ($displaymode ='view' and sub_product_code[.='DOM'])">
			    					<div>
			    						<xsl:attribute name="class">CUR <xsl:if test="$displaymode !='edit'"> inlineBlock</xsl:if></xsl:attribute>
			    						<xsl:choose>
			    							<xsl:when test="$displaymode = 'edit'">
			    								
				    								<div name="beneficiary_act_cur_code" id="beneficiary_act_cur_code" trim="true" uppercase="true" dojoType="dijit.form.ValidationTextBox" regExp="^[a-zA-Z]*$" class="xx-small inlineBlock inlineBlockNoLabel" maxLength="3">										
				    									<xsl:attribute name="value"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></xsl:attribute>
				    									<xsl:attribute name="displayedValue"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></xsl:attribute>
				    									<xsl:attribute name="readOnly">Y</xsl:attribute>
				    								</div>
			    							
			    							</xsl:when>
			    							<xsl:otherwise>
			    								<span class="content" style="padding-right: 0.5em;"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></span>
			    							</xsl:otherwise>
			    						</xsl:choose>
			    				
			    						<!-- Hidden fields to store information related to Beneficary Account Validation when product type is DOM -->
			    						<xsl:call-template name="hidden-field">
			    							<xsl:with-param name="name">bo_account_id</xsl:with-param>
			    						</xsl:call-template>
			    						<xsl:call-template name="hidden-field">
			    							<xsl:with-param name="name">bo_account_type</xsl:with-param>
			    						</xsl:call-template>
			    						<xsl:call-template name="hidden-field">
			    							<xsl:with-param name="name">bo_account_currency</xsl:with-param>
			    						</xsl:call-template>
			    						<xsl:call-template name="hidden-field">
			    							<xsl:with-param name="name">bo_branch_code</xsl:with-param>
			    						</xsl:call-template>
			    						<xsl:call-template name="hidden-field">
			    							<xsl:with-param name="name">bo_product_type</xsl:with-param>
			    						</xsl:call-template>
			    						<xsl:call-template name="hidden-field">
			    							<xsl:with-param name="name">bene_email_1</xsl:with-param>
			    						</xsl:call-template>
			    						<xsl:call-template name="hidden-field">
			    							<xsl:with-param name="name">bene_email_2</xsl:with-param>
			    						</xsl:call-template>
			    					</div>	
			    				</xsl:if>	
			    				<xsl:call-template name="input-field">
			    				    <xsl:with-param name="type">account</xsl:with-param>
			    				    <xsl:with-param name="name">beneficiary_account</xsl:with-param>	
			    				    <xsl:with-param name="maxlength"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_ACCOUNT_NO_VALIDATION_REGEX')"/></xsl:with-param>	
			    				    <xsl:with-param name="required">Y</xsl:with-param>	
			    				    <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel NoAsterik small</xsl:with-param>
			    				    <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_act_no"/></xsl:with-param>
			    				    <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
			    				    <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_ACCOUNT_NO_VALIDATION_REGEX')"/></xsl:with-param>
			    				</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
							
						<!-- This Empty div is to show inline for DOM product , used in JS -->				
						<div class="CUR"/>
						<div id="pre_approved_row" class="field">
							<span class="label"/>
							<div id="PAB" class="content">
								<xsl:attribute name="style">
									<xsl:choose>
										<xsl:when test="pre_approved_status[.='Y']">display:inline</xsl:when>
										<xsl:otherwise>display:none</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language,'XSL_TPT_PAB')"/>
							</div> 
						</div>
						<xsl:choose>
							<xsl:when test="$displaymode='edit' and transfer_purpose_list/transfer_purpose_details/transfer_purpose_description[.!='']">
								<xsl:call-template name="select-field">
								      <xsl:with-param name="label">XSL_TRANSFER_PURPOSE</xsl:with-param>
								      <xsl:with-param name="name">transfer_purpose</xsl:with-param>
								      <xsl:with-param name="required">Y</xsl:with-param>
								      <xsl:with-param name="options">
								      		<xsl:call-template name="transfer_purpose_mode_options"/>
								      </xsl:with-param>
								 </xsl:call-template>
							 </xsl:when>
							<xsl:otherwise>
							 <xsl:if test="transfer_purpose[.!='']">
							 <xsl:variable name="transfer_purpose_code"><xsl:value-of select="transfer_purpose"></xsl:value-of></xsl:variable>
							 <xsl:call-template name="input-field">
							 	<xsl:with-param name="label">XSL_TRANSFER_PURPOSE</xsl:with-param>
							 	<xsl:with-param name="name">transfer_purpose</xsl:with-param>
							 	<xsl:with-param name="value"><xsl:value-of select="utils:retrieveTransferPurposeDesc($rundata, $transfer_purpose_code)"/></xsl:with-param>
							 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
							 </xsl:call-template>
							 </xsl:if>
							 </xsl:otherwise>
							 
						 </xsl:choose>
						</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="column-wrapper">
						<xsl:with-param name="content">
					    	<xsl:call-template name="input-field">
						      	 <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_BRANCH_CODE</xsl:with-param>
							     <xsl:with-param name="name">cpty_bank_code</xsl:with-param>
							     <xsl:with-param name="maxsize">4</xsl:with-param>	
							     <xsl:with-param name="fieldsize">xx-small</xsl:with-param>
			                     <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
			                     <xsl:with-param name="required">Y</xsl:with-param>		
			                     <xsl:with-param name="value"><xsl:if test="sub_product_code = 'DOM'"><xsl:value-of select="counterparties/counterparty/cpty_bank_code"/></xsl:if></xsl:with-param>	
			                     <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>	     			  
							 </xsl:call-template>	
							 &nbsp;/ &nbsp;
							 <xsl:call-template name="input-field">
							     <xsl:with-param name="name">cpty_branch_code</xsl:with-param>	
						   		 <xsl:with-param name="maxsize">3</xsl:with-param>	
						   		 <xsl:with-param name="fieldsize">xx-small</xsl:with-param>
			                     <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel NoAsterik</xsl:with-param>
			                     <xsl:with-param name="required">Y</xsl:with-param>	
			                     <xsl:with-param name="value"><xsl:if test="sub_product_code = 'DOM'"><xsl:value-of select="counterparties/counterparty/cpty_branch_code"/></xsl:if></xsl:with-param>
			                     <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
			                 </xsl:call-template>	
			                 <xsl:choose>
			                 <xsl:when test="bulk_ref_id[.!='']">
							     <xsl:if test="not($pre-approved_beneficiary_only) and $displaymode='edit'">	
									<xsl:call-template name="button-wrapper">
										<xsl:with-param name="show-image">Y</xsl:with-param>
										<xsl:with-param name="show-border">N</xsl:with-param>
										<xsl:with-param name="onclick">misys.showBankBranchCodeDialog('bank_branch_code', "['cpty_bank_code', 'cpty_branch_code', 'cpty_branch_name','cpty_bank_name']", '', '', 'N', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_LIST_OF_BANKS')"/>',false);return false;</xsl:with-param>
										<xsl:with-param name="id">bank_img</xsl:with-param>
										<xsl:with-param name="non-dijit-button">N</xsl:with-param>
									</xsl:call-template>
				               	</xsl:if>	
				              </xsl:when> 
				              <xsl:otherwise>
				                 <xsl:if test="not($pre-approved_beneficiary_only) and $displaymode='edit'">	
									<xsl:call-template name="button-wrapper">
										<xsl:with-param name="show-image">Y</xsl:with-param>
										<xsl:with-param name="show-border">N</xsl:with-param>
										<xsl:with-param name="onclick">misys.showBankBranchCodeDialog('bank_branch_code', "['cpty_bank_code', 'cpty_branch_code', 'cpty_branch_name','cpty_bank_name']", '', '', 'N', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_LIST_OF_BANKS')"/>',false);return false;</xsl:with-param>
										<xsl:with-param name="id">bank_img</xsl:with-param>
										<xsl:with-param name="non-dijit-button">N</xsl:with-param>
									</xsl:call-template>
				               	</xsl:if>	
				              </xsl:otherwise>
			               	</xsl:choose>	
						  <xsl:call-template name="input-field">
						    <xsl:with-param name="label">XSL_BENEFICIARY_BANK_NAME_WITH_ADDRESS</xsl:with-param>
						    <xsl:with-param name="name">cpty_bank_name</xsl:with-param>
						    <xsl:with-param name="fieldsize">medium</xsl:with-param>
						    <xsl:with-param name="required">Y</xsl:with-param>			
						    <!-- <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param> -->
						  	<xsl:with-param name="readonly">Y</xsl:with-param>
						  	<xsl:with-param name="swift-validate">N</xsl:with-param>
						  </xsl:call-template>
				      	  <xsl:call-template name="input-field">
						    <xsl:with-param name="label">XSL_PARTIESDETAILS_BRANCH_NAME</xsl:with-param>
						    <xsl:with-param name="name">cpty_branch_name</xsl:with-param>	
						    <xsl:with-param name="fieldsize">medium</xsl:with-param>
						    <xsl:with-param name="required">Y</xsl:with-param>			
						    <!-- <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param> -->		  
						  	<xsl:with-param name="readonly">Y</xsl:with-param>
						  	<xsl:with-param name="swift-validate">N</xsl:with-param>
						  </xsl:call-template>
						</xsl:with-param>
						</xsl:call-template>       				
					</xsl:with-param>
		 	        </xsl:call-template>
					
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">bk_sub_product_code</xsl:with-param>
				    </xsl:call-template>
				    <xsl:call-template name="hidden-field">
						<xsl:with-param name="name">currency_res</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="currency_res"/></xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="dom-transaction-details">	 	
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_TRANSACTION_DETAILS</xsl:with-param>
			<xsl:with-param name="content">		
				<xsl:call-template name="column-container">
				<xsl:with-param name="content">
					<xsl:call-template name="column-wrapper">
					<xsl:with-param name="content">
					<xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
						<xsl:call-template name="currency-field">
							<xsl:with-param name="label">XSL_AMOUNTDETAILS_TRANSFER</xsl:with-param>
							<xsl:with-param name="product-code">ft</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
							<xsl:with-param name="currency-readonly">
								<xsl:choose>
									<xsl:when test="bulk_ref_id[.!='']">Y</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>				   		
							</xsl:with-param>
							<xsl:with-param name="show-button">
								<xsl:choose>
									<xsl:when test="bulk_ref_id[.!='']">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
					
						<xsl:if test="bulk_ref_id[.!=''] and sub_product_code [.='IBG' or .='IBGEX']">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_BK_PARTICULARS</xsl:with-param>
								<xsl:with-param name="name">bk_particular</xsl:with-param>
								<xsl:with-param name="fieldsize">small</xsl:with-param>
								<xsl:with-param name="size">12</xsl:with-param>
								<xsl:with-param name="maxsize">12</xsl:with-param>	
							</xsl:call-template> 
						</xsl:if>
						<div id="transfer_date_div">
							<xsl:choose>
								<xsl:when test="$displaymode='edit' and bulk_ref_id[.='']">
									<xsl:call-template name="business-date-field">
										<xsl:with-param name="label">XSL_GENERALDETAILS_TRANSFER_DATE</xsl:with-param>
										<xsl:with-param name="name">iss_date</xsl:with-param>
										<xsl:with-param name="size">10</xsl:with-param>
										<xsl:with-param name="maxsize">10</xsl:with-param>
										<xsl:with-param name="required">Y</xsl:with-param>
										<xsl:with-param name="fieldsize">small</xsl:with-param>
										<xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
										<xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
										<xsl:with-param name="cur-code-widget-id">ft_cur_code</xsl:with-param>
										<xsl:with-param name="override-displaymode">
											<xsl:choose>
												<xsl:when test="bulk_ref_id[.='']">
													<xsl:choose>
														<xsl:when test="$displaymode = 'edit'">edit</xsl:when>
							    						<xsl:otherwise>view</xsl:otherwise>
													</xsl:choose>
						  							</xsl:when>
						  							<xsl:otherwise>view</xsl:otherwise>
						  						</xsl:choose>
						  					</xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">sub_product_code_custom</xsl:with-param>
						   			</xsl:call-template>
								</xsl:when>
								<xsl:when test="$displaymode='view'">				
									<xsl:if test="not(recurring_payment_enabled) or recurring_payment_enabled[.='N']">
										<xsl:call-template name="business-date-field">
											<xsl:with-param name="label">XSL_GENERALDETAILS_TRANSFER_DATE</xsl:with-param>
											<xsl:with-param name="name">iss_date</xsl:with-param>
											<xsl:with-param name="size">10</xsl:with-param>
											<xsl:with-param name="maxsize">10</xsl:with-param>
											<xsl:with-param name="required">Y</xsl:with-param>
											<xsl:with-param name="fieldsize">small</xsl:with-param>
											<xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
											<xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
											<xsl:with-param name="cur-code-widget-id">ft_cur_code</xsl:with-param>
											<xsl:with-param name="override-displaymode">
												<xsl:choose>
													<xsl:when test="bulk_ref_id[.='']">
														<xsl:choose>
															<xsl:when test="$displaymode = 'edit'">edit</xsl:when>
															<xsl:otherwise>view</xsl:otherwise>
														</xsl:choose>
													</xsl:when>
													<xsl:otherwise>view</xsl:otherwise>
												</xsl:choose>
											</xsl:with-param>
										</xsl:call-template>
										<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">sub_product_code_custom</xsl:with-param>
										</xsl:call-template>					
									</xsl:if>
								</xsl:when>
							</xsl:choose>	
						</div>			
						
						
								
						<!-- Verifying amount access from bulk -->
			   			<div>
							<xsl:if test="bulk_ref_id[.!='']">
								<xsl:variable name="transactionCodeRequired">
									<xsl:choose>
										<xsl:when test="sub_product_code[.='MLDOM'] or sub_product_code[.='MLDOX']">
											<xsl:value-of select="'Y'"></xsl:value-of>
										</xsl:when>
										<xsl:otherwise>	
											<xsl:value-of select="'N'"></xsl:value-of>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
						<xsl:if test="bulk_ref_id[.!=''] and transaction_code and transaction_code/transaction_codes[.!='']">
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_BK_TRANSACTION_CODE</xsl:with-param>
									<xsl:with-param name="name">bk_transaction_code</xsl:with-param>
									<xsl:with-param name="fieldsize">medium</xsl:with-param>
									<xsl:with-param name="required"><xsl:value-of select="$transactionCodeRequired"/></xsl:with-param>
									<xsl:with-param name="options">			       		
										<xsl:choose>
											<xsl:when test="$displaymode='edit'">
												<xsl:for-each select="transaction_code/transaction_codes">
													<option value="{transaction_code_id}">
														<xsl:value-of select="tranaction_code_des"/>
													</option>
												</xsl:for-each>
											</xsl:when>
										</xsl:choose>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
					</xsl:if>
						</div>
						<!-- some hidden fields -->
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">iss_date_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="iss_date"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">sub_product_code_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="sub_product_code"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">display_entity_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="entity"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">ft_cur_code_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="ft_cur_code"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">applicant_act_cur_code_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="applicant_act_cur_code"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">ft_amt_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="ft_amt"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">recurring_start_date_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="recurring_start_date"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">recurring_end_date_unsigned</xsl:with-param>
			     			<xsl:with-param name="value" select="recurring_end_date"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">base_cur_code</xsl:with-param>
						    <xsl:with-param name="value" select="base_cur_code"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">regexValue</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_REGEX')"/></xsl:with-param>
						</xsl:call-template>						
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">allowedProducts</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_EXCLUDED_PRODUCTS')"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">product_type</xsl:with-param>
							<xsl:with-param name="value">DOM</xsl:with-param>
						</xsl:call-template>
						
						
						<!-- <xsl:call-template name="hidden-field">
							<xsl:with-param name="name">ref_id</xsl:with-param>
						</xsl:call-template> -->
					</xsl:with-param>
					</xsl:call-template>
					 <xsl:call-template name="column-wrapper">
				 <xsl:with-param name="content">
				 	<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>	
					<xsl:with-param name="name">cust_ref_id</xsl:with-param>
					<xsl:with-param name="size">16</xsl:with-param>
					<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_CASH_LENGTH')"/></xsl:with-param>
					<xsl:with-param name="regular-expression">
							<xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_CASH_VALIDATION_REGEX')"/>
					</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="cust_ref_id"/></xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_BEN_REF</xsl:with-param>	
					<xsl:with-param name="name">beneficiary_reference</xsl:with-param>
					<xsl:with-param name="size">19</xsl:with-param>
					<xsl:with-param name="maxsize">19</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_reference"/></xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
				 </xsl:with-param>
			</xsl:call-template>	
			  <xsl:call-template name="hidden-field"> 
  							<xsl:with-param name="name">tnx_cur_code</xsl:with-param> 
  						</xsl:call-template> 
			</xsl:with-param>
			</xsl:call-template>	
		</xsl:with-param>
		</xsl:call-template>			
	</xsl:template>
	
	<xsl:template name="dom-general-details">
		<xsl:param name="show-template-id">Y</xsl:param>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>		
			<xsl:with-param name="content">
			<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
				<xsl:choose>
					<xsl:when test="bulk_ref_id[.!='']">
						<div id="display_bulk_ref_id_row" class="field">
							<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_BK_REF_ID')"/>&nbsp;</span>
							<div class="content"><xsl:value-of select="bulk_ref_id"/></div> 
						</div>
						<xsl:if test="entities[number(.) &gt; 0]">
							<div id="display_entity_row" class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></span>
								<div class="content"><xsl:value-of select="entity"/></div> 
							</div>
							<xsl:call-template name="hidden-field">
						       <xsl:with-param name="name">entity</xsl:with-param>
						    </xsl:call-template>
						</xsl:if>
						<!-- START- Multibank fields -->
						<div id="display_customer_bank_row" class="field">
							<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BANK_LABEL')"/>&nbsp;</span>
							<div class="content" id="display_customer_bank"><xsl:value-of select="issuing_bank/name"/></div> 
						</div>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">customer_bank</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="customer_banks_details_ft/customer_bank"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">customer_bank_hidden</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="customer_banks_details_ft/customer_bank_hidden"/></xsl:with-param>
						</xsl:call-template>
						<!-- END- Multibank fields -->
						<xsl:call-template name="user-account-field">
				           <xsl:with-param name="label">XSL_TRANSFER_FROM</xsl:with-param>
				          <xsl:with-param name="name">applicant</xsl:with-param>
				          <xsl:with-param name="entity-field">entity</xsl:with-param>
				          <xsl:with-param name="dr-cr">debit</xsl:with-param>
				          <xsl:with-param name="show-product-types">N</xsl:with-param>
				          <xsl:with-param name="product_types">FT:DOM</xsl:with-param>
				          <xsl:with-param name="product-types-required">Y</xsl:with-param>
				          <xsl:with-param name="required">Y</xsl:with-param>
				           <xsl:with-param name="override-displaymode">view</xsl:with-param>
				         </xsl:call-template>
				         <xsl:call-template name="nickname-field-template"/>
						 <div id="display_sub_product_code_row" class="field">
							<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_SUB_PRODUCT')"/>&nbsp;</span>
							<div class="content"><xsl:if test="sub_product_code[.!='']"><xsl:value-of select="localization:getDecode($language, 'N047', concat(sub_product_code,'_BK'))"/></xsl:if></div> 
						</div>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="$displaymode='view'  and entity[.!=''] and sub_product_code[.!='DOM']">                                     
	 	 	 			 	<div id="display_entity_row" class="field">
	 	 	 	 			<span class="label"><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></span>
	 	 	 	 			<div class="content"><xsl:value-of select="entity"/></div> 
	 	 	 	 			</div>                                                  
	 	 	 			 </xsl:if>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_JURISDICTION_SUB_PRODUCT</xsl:with-param>	
							<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N047', 'DOM')"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="entities[number(.) &gt; 0] and $displaymode='edit'">
							<xsl:call-template name="entity-field">
								<xsl:with-param name="required">Y</xsl:with-param>
							    <xsl:with-param name="button-type">entity</xsl:with-param>
							    <xsl:with-param name="prefix">applicant</xsl:with-param>
							    <xsl:with-param name="override-sub-product-code">FT:DOM</xsl:with-param>
						    </xsl:call-template>
						</xsl:if>
						
						<!-- Bank to which beneficiary needs to be linked to. -->
						<xsl:if test="$isMultiBank='Y'">
							  <xsl:call-template name="customer-bank-field"/>
						</xsl:if>
						
				    	<xsl:call-template name="user-account-field">
					     	<xsl:with-param name="label">XSL_TRANSFER_FROM</xsl:with-param>
						    <xsl:with-param name="name">applicant</xsl:with-param>
						    <xsl:with-param name="entity-field">entity</xsl:with-param>
						    <xsl:with-param name="dr-cr">debit</xsl:with-param>
						    <xsl:with-param name="show-product-types">N</xsl:with-param>
						    <xsl:with-param name="product_types">FT:DOM</xsl:with-param>
						    <xsl:with-param name="product-types-required">Y</xsl:with-param>
						    <xsl:with-param name="required">Y</xsl:with-param>
					    	<xsl:with-param name="isMultiBankParam">
					    		<xsl:choose>
					    			<xsl:when test="$isMultiBank='Y'">Y</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
					    		</xsl:choose>
					    	</xsl:with-param>
				    	</xsl:call-template>
				    	<xsl:call-template name="nickname-field-template"/>
					  </xsl:otherwise>
				</xsl:choose>
					    	<xsl:if test="$displaymode='edit'">
								   <xsl:call-template name="recurring_checkbox" />
							 </xsl:if>
							<xsl:if test="$displaymode='edit'">
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
							   <xsl:if test="bulk_ref_id = ''">
							       <xsl:call-template name="input-field">
										<xsl:with-param name="label">BANK_LABEL</xsl:with-param>	
										<xsl:with-param name="fieldsize">small</xsl:with-param>
										<xsl:with-param name="value" select="issuing_bank/name" />
										<xsl:with-param name="override-displaymode">view</xsl:with-param>
									</xsl:call-template>
							  	</xsl:if>
								<xsl:call-template name="common-general-details">
									<xsl:with-param name="show-cust-ref-id">N</xsl:with-param>
									<xsl:with-param name="show-template-id">
										<xsl:choose>
											<xsl:when test="bulk_ref_id[.!='']">N</xsl:when>
											<xsl:otherwise><xsl:value-of select="$show-template-id"/></xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>	
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="dom-notify-beneficiary-details">
		
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_FT_BENEFICIARY_NOTIFICATION</xsl:with-param>
					<xsl:with-param name="content">
					<div class="ft-notify-beneficiary-details">						
								<div class="multioption-group-label">
									<!-- the dijits are declared directly here because of some limitations on the way they're disposed in 
									the page when using the templates. Particulary because radio and check box are centered and 
									when having a text box in the same line as a radio button -->
		                            <!-- Well, not sure about that, had to add the standard CSS/DIV by hand sooo... -->
		                            <div class="field checkbox">
		    							<label for="notify_beneficiary">
		    								<input dojoType="dijit.form.CheckBox" type="checkbox" name="notify_beneficiary" id="notify_beneficiary">
		    									<xsl:if test="notify_beneficiary[.='Y']">
		    										<xsl:attribute name="checked">checked</xsl:attribute>
		    									</xsl:if>
		    									<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_NOTIFY_BENEFICIARY')"/>
		    								</input>
		    							</label>
									</div>
									
		                            <div class="field radio">
		    							<label for="notify_beneficiary_choice_1" id="label_notify_beneficiary_choice_1">
		    								<input dojoType="dijit.form.RadioButton" type="radio" name="notify_beneficiary_choice" id="notify_beneficiary_choice_1" value="default_email">
		    									<xsl:if test="notify_beneficiary_choice[.='default_email']">
		    										<xsl:attribute name="checked">checked</xsl:attribute>
		    									</xsl:if>
		    									<xsl:if test="not(notify_beneficiary[.='Y'])">
		    										<xsl:attribute name="disabled">disabled</xsl:attribute>
		    									</xsl:if>
		    									<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_DEFAULT_EMAIL')"/>
		    								</input>
		    							</label>
		    							<xsl:if test="notify_beneficiary_choice[.='default_email']">
		    								<span id="notify_beneficiary_email_node">
		    									<div trim="true" dojoType="dijit.form.ValidationTextBox" name="notify_beneficiary_email" id="notify_beneficiary_email" 
		    										maxLength="254" size="35" class="medium" value="{notify_beneficiary_email}">
		    										<xsl:if test="not(notify_beneficiary[.='Y'])">
		    											<xsl:attribute name="disabled">disabled</xsl:attribute>
		    										</xsl:if>
		    									</div>
		    								</span>
		    							</xsl:if>
									</div>
		                            <div class="field radio">
		    							<label for="notify_beneficiary_choice_2" id="label_notify_beneficiary_choice_2">
		    								<input dojoType="dijit.form.RadioButton" type="radio" name="notify_beneficiary_choice" id="notify_beneficiary_choice_2" value="alternative_email">
		    									<xsl:if test="notify_beneficiary_choice[.='alternative_email']">
		    										<xsl:attribute name="checked">checked</xsl:attribute>
		    									</xsl:if>
		    									<xsl:if test="not(notify_beneficiary[.='Y'])">
		    										<xsl:attribute name="disabled">disabled</xsl:attribute>
		    									</xsl:if>
		    									<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_ALTERNATIVE_EMAIL')"/>
		    								</input>
		    							</label>
		    							<xsl:if test="not(notify_beneficiary_choice[.='default_email'])">
		    								<span id="notify_beneficiary_email_node">
		    									<div trim="true" dojoType="dijit.form.ValidationTextBox" name="notify_beneficiary_email" id="notify_beneficiary_email" 
		    										maxLength="500" size="35" class="medium" value="{notify_beneficiary_email}">
		    										<xsl:if test="not(notify_beneficiary[.='Y'])">
		    											<xsl:attribute name="disabled">disabled</xsl:attribute>
		    										</xsl:if>
		    									</div>
		    								</span>
		    							</xsl:if>
		                            </div>
								</div>
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="notify_beneficiary[.='Y']">
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_FT_BENEFICIARY_NOTIFICATION</xsl:with-param>
						<xsl:with-param name="content">
						  	<div id="notify_beneficiary_row" class="field">
								<span class="label">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_NOTIFY_BENEFICIARY')"/>
								</span>
								<div class="content">
									<xsl:value-of select="notify_beneficiary_email"/>
								</div>
							</div>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>			
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>
	
	<xsl:template name="transfer_purpose_mode_options">
     <xsl:for-each select="transfer_purpose_list/transfer_purpose_details">
        <option>
           <xsl:attribute name="value">
            <xsl:value-of select="transfer_purpose_code"></xsl:value-of>
            </xsl:attribute>
            <xsl:value-of select="transfer_purpose_description"/>
        </option>
      </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
