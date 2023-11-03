<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for the details of

 Fund Transfer (FT) Form, Customer Side (MT101, MT103, FI103, FI202).

Copyright (c) 2000-2012 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      10/02/12
author:    Raja Rao
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
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

	<xsl:param name="isMultiBank">N</xsl:param>
	<xsl:param name="gpp_payment_flag"/>
	<xsl:param name="gpp_fee_config_cur_code"/>
	<xsl:param name="gpp_fee_config_amt"/>
	
	<!-- BEGIN FT TNX FORM TEMPLATE. -->
	<xsl:template match="ft_tnx_record">
		<!-- Preloader  -->
		<xsl:call-template name="loading-message"/>
		<script>
			dojo.ready(function(){
				misys._config = misys._config || {};
				dojo.mixin(misys._config, {
						productCode: '<xsl:value-of select="$product-code"/>',
					clearingCodes :  new Array(),
					countryCcy :  new Array(),
					clearingCodesDescription : new Array(),
					clearingCodesFormat : new Array(),
					clearingCodesRegExp : new Array(),
					clearingCodesMandatory : new Array(),
					countryCurrencyPair :  new Array(),
					ibanMandatory : new Array()
				});
				misys._config.gpp_payment_flag = '<xsl:value-of select="$gpp_payment_flag"/>';
         	  	misys._config.gpp_fee_config_cur_code = '<xsl:value-of select="$gpp_fee_config_cur_code"/>';
         	  	misys._config.gpp_fee_config_amt = '<xsl:value-of select="$gpp_fee_config_amt"/>';		
				misys._config.isMultiBank =<xsl:choose>
								 			<xsl:when test="$isMultiBank='Y'">true</xsl:when>
								 			<xsl:otherwise>false</xsl:otherwise>
								 		</xsl:choose>;
	            <xsl:if test="$isMultiBank='Y'">
	            	<xsl:call-template name="multibank-common-details"/>
				</xsl:if>	
				<xsl:for-each select="clearing_codes/clearing_code_set">
					<xsl:variable name="countryCcyPosition" select="position() - 1" />
					<xsl:variable name="country_currency"><xsl:value-of select="country_currency"/></xsl:variable>
					misys._config.clearingCodes["<xsl:value-of select="$country_currency"/>"] = new Array(<xsl:value-of select="count(codes_set/clearing_code)"/>);
					misys._config.clearingCodesDescription["<xsl:value-of select="$country_currency"/>"] = new Array(<xsl:value-of select="count(codes_set/clearing_code)"/>);
					<xsl:for-each select="codes_set/clearing_code">
						<xsl:variable name="position" select="position() - 1" />
						misys._config.clearingCodes["<xsl:value-of select="$country_currency"/>"][<xsl:value-of select="$position"/>]="<xsl:value-of select="code"/>";
						misys._config.clearingCodesDescription["<xsl:value-of select="$country_currency"/>"][<xsl:value-of select="$position"/>]="<xsl:value-of select="description"/>";
					</xsl:for-each>
					misys._config.countryCurrencyPair["<xsl:value-of select="$country_currency"/>"]="Y";
					misys._config.countryCcy[<xsl:value-of select="$countryCcyPosition"/>]= "<xsl:value-of select="$country_currency"/>";
				</xsl:for-each>

				<xsl:for-each select="clearing_codes/clearing_code_set/codes_set/clearing_code">
					misys._config.clearingCodesFormat["<xsl:value-of select="code"/>"] = "<xsl:value-of select="format"/>";
					misys._config.clearingCodesRegExp["<xsl:value-of select="code"/>"] = "<xsl:value-of select="regExp"/>";
					misys._config.clearingCodesMandatory["<xsl:value-of select="code"/>"] = "<xsl:value-of select="mandatoryIndicator"/>";
				</xsl:for-each>
				<xsl:for-each select="iban_codes/iban_set">
					misys._config.ibanMandatory["<xsl:value-of select="code"/>"] = "<xsl:value-of select="mandatoryIndicator"/>";
				</xsl:for-each>
			});
		</script>
		
		<div id="{$displaymode}">
			<!-- Form #0 : Main Form -->
			<xsl:variable name="ftFinancialRemittanceflag" select="defaultresource:getResource('FT_FR_DISPLAY')"></xsl:variable>
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name"/>
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
					<!-- Disclaimer Notice -->
					<xsl:call-template name="disclaimer"/>
					<xsl:call-template name="hidden-fields"/>
						
					<div>
						<xsl:variable name="hasRecurrence" select="securitycheck:hasPermission(utils:getUserACL($rundata),'ft_recurringpayment_access',utils:getUserEntities($rundata))"></xsl:variable>
						<xsl:if test="$displaymode='edit'">
							<div id="MT103_DISCLAIMER" class="remittanceDisclaimer" style="display:none;">
								<xsl:call-template name="simple-disclaimer">
									<xsl:with-param name="label">XSL_MT103_DISCLAIMER</xsl:with-param>
								</xsl:call-template>	      				
							</div>
						</xsl:if>
						<!--  Display common menu. -->
						<xsl:call-template name="menu" >
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
						<!-- Reauthentication -->	
						<xsl:call-template name="server-message">
							<xsl:with-param name="name">server_message</xsl:with-param>
							<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
							<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="reauthentication" />
					   <xsl:call-template name="bank-message"/>
						<xsl:call-template name="remittance-general-details" />
						
						<xsl:call-template name="recurring_content">
							<xsl:with-param name="override-displaymode"><xsl:value-of select="$displaymode"/></xsl:with-param>
						</xsl:call-template>
					
						<xsl:if test="sub_product_code[.='MT101']">
							<xsl:variable name="displayInterbankDetailsflag" select="defaultresource:getResource('MT101_INTER_BANK_DETAILS_DISPLAY')"/>
							<xsl:call-template name="remittance-beneficiary-details" /> 
							<xsl:if test="$displayInterbankDetailsflag = 'true'">
								<xsl:call-template name="intermediary-bank-details" />  
							</xsl:if>
							<xsl:call-template name="transaction-details">	      					
								<xsl:with-param name="show-request-date">Y</xsl:with-param>
							</xsl:call-template>
							<!-- FX Snippets Start -->
							<!-- Verifying amount access from bulk -->
							<xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
								<xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_bank_product_details/fx_bank_properties/fx_assign_products[.='Y']">  
									<xsl:call-template name="fx-template"/>
								</xsl:if>  
								<xsl:if test="$displaymode='view' and fx_rates_type and fx_rates_type[.!='']">
									<xsl:call-template name="fx-details-for-view" /> 
								</xsl:if>
							</xsl:if>
							<!-- FX Snippets End -->   		      		
							<xsl:call-template name="instruction-to-bank-details" />
							<xsl:call-template name="beneficiary-advices-section">
								<xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
								<xsl:with-param name="entity-widget-id">entity</xsl:with-param>
								<xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
							</xsl:call-template> 
							 <xsl:call-template name="remittance-notify-beneficiary-details"/> 
							<xsl:call-template name="transaction-remarks-details" />
						</xsl:if>
						
						<!-- BEGIN Section specific to MT103 -->
						<xsl:if test="sub_product_code[.='MT103']">
							<xsl:call-template name="remittance-beneficiary-details">   				
								<xsl:with-param name="show-branch-address">Y</xsl:with-param>	      		
							</xsl:call-template> 
							<xsl:variable name="displayInterbankDetailsflag" select="defaultresource:getResource('MT103_INTER_BANK_DETAILS_DISPLAY')"></xsl:variable>
							<script>
								dojo.ready(function(){			
					         	  	misys._config = misys._config || {};			
									misys._config.mt103_intermediary_details = <xsl:value-of select="defaultresource:getResource('MT103_INTER_BANK_DETAILS_DISPLAY')"/>;
								});
						  	</script>
							<xsl:if test="$displayInterbankDetailsflag = 'true'">
								<xsl:call-template name="intermediary-bank-details" />  
							</xsl:if>
							<xsl:variable name="show-debit-account-flag" select="defaultresource:getResource('CUSTOMER_MT103_CHARGE_ACC_SHOW')"/>
							<xsl:choose>
							<xsl:when test="$show-debit-account-flag = 'true'">
								<xsl:call-template name="transaction-details">	      					
									<xsl:with-param name="show-debit-account-for-charges">Y</xsl:with-param>
									<xsl:with-param name="override-sub-product-code" select="sub_product_code"/>
								</xsl:call-template>    
							</xsl:when>
							<xsl:otherwise>
                                 <xsl:call-template name="transaction-details">
                                   <xsl:with-param name="show-debit-account-for-charges">N</xsl:with-param>
                                 </xsl:call-template>
                            </xsl:otherwise>
                            </xsl:choose>
							<!-- FX Snippets Start -->
							<xsl:if test="not(amount_access) or  (amount_access[.='true'])">
								<xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_bank_product_details/fx_bank_properties/fx_assign_products[.='Y']">  
									<xsl:call-template name="fx-template"/>
								</xsl:if>  
								<xsl:if test="$displaymode='view' and fx_rates_type and fx_rates_type[.!='']">
									<xsl:call-template name="fx-details-for-view" /> 
								</xsl:if>
							</xsl:if>
							<!-- FX Snippets End --> 
							 <div id="ftFeeFetails" style="display: none;">
							<xsl:if test="$gpp_payment_flag='true'">
							<xsl:call-template name="ft-fee-details" />
							</xsl:if>
							</div>
							 <xsl:if test="$displaymode='view' and (not(recurring_payment_enabled) or recurring_payment_enabled[.='N'])">
						 		<xsl:call-template name="ft-fee-details-view" />
						 	</xsl:if>  		      	
							<xsl:call-template name="beneficiary-advice-details" /> 
							<xsl:call-template name="instruction-to-bank-details" />
							<xsl:if test="$ftFinancialRemittanceflag = 'true'">
								<xsl:choose>
									<xsl:when test="$displaymode='edit'">
										<xsl:call-template name="js-remittance-collections" />
									</xsl:when>
									<xsl:when test="$displaymode='view'">
										<xsl:call-template name="js-remittance-collections-view">
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
							<xsl:call-template name="beneficiary-advices-section">
								<xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
								<xsl:with-param name="entity-widget-id">entity</xsl:with-param>
								<xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
							</xsl:call-template>  
							 <xsl:call-template name="remittance-notify-beneficiary-details"/>
							<xsl:call-template name="transaction-remarks-details" />
						</xsl:if>
						<!-- END Section specific to MT103 -->
						
						<!-- BEGIN Section specific to FI103 -->
						<xsl:if test="sub_product_code[.='FI103']">
							<xsl:variable name="displayInterbankDetailsflag" select="defaultresource:getResource('FI103_INTER_BANK_DETAILS_DISPLAY')"/>
							<xsl:call-template name="ordering-customer-details" /> 
							<xsl:call-template name="remittance-beneficiary-details">   				
								<xsl:with-param name="show-branch-address">Y</xsl:with-param>	      		
							</xsl:call-template>  
							<xsl:if test="$displayInterbankDetailsflag = 'true'">
								<xsl:call-template name="intermediary-bank-details" />  
							</xsl:if>
							<xsl:call-template name="transaction-details">	      
								<xsl:with-param name="transaction-label">XSL_TRANSACTION_REFERENCE</xsl:with-param>	
								<xsl:with-param name="show-sender-to-receiver-info">Y</xsl:with-param>
								<xsl:with-param name="show-debit-account-for-charges">Y</xsl:with-param>
							</xsl:call-template>    
							<!-- FX Snippets Start -->
							<xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_bank_product_details/fx_bank_properties/fx_assign_products[.='Y']">  
								<xsl:call-template name="fx-template"/>
							</xsl:if>  
							<xsl:if test="$displaymode='view' and fx_rates_type and fx_rates_type[.!='']">
								<xsl:call-template name="fx-details-for-view" /> 
							</xsl:if>
							<!-- FX Snippets End -->   
							<!-- <xsl:call-template name="forex-details" />-->   
							<xsl:call-template name="beneficiary-advice-details" /> 
							<xsl:call-template name="instruction-to-bank-details" />
							<xsl:if test="$ftFinancialRemittanceflag = 'true'">
								<xsl:choose>
									<xsl:when test="$displaymode='edit'">
										<xsl:call-template name="js-remittance-collections" />
									</xsl:when>
									<xsl:when test="$displaymode='view'">
										<xsl:call-template name="js-remittance-collections-view">
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
							<xsl:call-template name="beneficiary-advices-section">
								<xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
								<xsl:with-param name="entity-widget-id">entity</xsl:with-param>
								<xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
							</xsl:call-template>  
							<xsl:call-template name="transaction-remarks-details" />
						</xsl:if>
						<!-- END Section specific to FI103 -->
						
						<!-- BEGIN Section specific to FI202 -->
						<xsl:if test="sub_product_code[.='FI202']">
							<xsl:variable name="displayInterbankDetailsflag" select="defaultresource:getResource('FI202_INTER_BANK_DETAILS_DISPLAY')"/>
							<xsl:call-template name="ordering-institution-details" /> 
							<xsl:call-template name="remittance-beneficiary-institution-details" />
							<xsl:if test="$displayInterbankDetailsflag = 'true'">
								<xsl:call-template name="intermediary-bank-details" />
							</xsl:if>  
							<xsl:call-template name="transaction-details">	      
								<xsl:with-param name="transaction-label">XSL_TRANSACTION_REFERENCE</xsl:with-param>	
								<xsl:with-param name="show-charge-option">N</xsl:with-param>
								<xsl:with-param name="show-related-reference">Y</xsl:with-param>
								<xsl:with-param name="show-sender-to-receiver-info">Y</xsl:with-param>
								<xsl:with-param name="show-payment-details-to-beneficiary">N</xsl:with-param>
							</xsl:call-template>    
							<!-- FX Snippets Start -->
							<xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_bank_product_details/fx_bank_properties/fx_assign_products[.='Y']">  
								<xsl:call-template name="fx-template"/>
							</xsl:if>  
							<xsl:if test="$displaymode='view' and fx_rates_type and fx_rates_type[.!='']">
								<xsl:call-template name="fx-details-for-view" /> 
							</xsl:if>
							<!-- FX Snippets End -->   		      	   
							<xsl:call-template name="beneficiary-advice-details" /> 
							<xsl:call-template name="instruction-to-bank-details" />
							<xsl:if test="$ftFinancialRemittanceflag = 'true'">
								<xsl:choose>
									<xsl:when test="$displaymode='edit'">
										<xsl:call-template name="js-remittance-collections" />
									</xsl:when>
									<xsl:when test="$displaymode='view'">
										<xsl:call-template name="js-remittance-collections-view">
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
							<xsl:call-template name="beneficiary-advices-section">
								<xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
								<xsl:with-param name="entity-widget-id">entity</xsl:with-param>
								<xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="transaction-remarks-details" />
						</xsl:if>
						<!-- comments for return -->
						<xsl:if test="$optionmode!='CANCEL'">
     						<xsl:call-template name="comments-for-return">
	  							<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   							<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
	   							<xsl:with-param name="swift-validate">N</xsl:with-param>
   	 						</xsl:call-template>
						</xsl:if>
						<!-- END Section specific to FI202 -->
					
						<!-- Display common menu, this time outside the form -->
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

   			<xsl:call-template name="realform"/>
		</div>
		
	   <!--  Collaboration Window -->     
	   <xsl:if test="$collaborationmode != 'none' and (not(bulk_ref_id) or bulk_ref_id[.=''])">
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
  
		<!-- Bene Advice Dialog and GridMultipleItem Template Node -->
		<xsl:call-template name="bene-advices-dialog-template"/>
		 
	</xsl:template>
	<!--  END FT TNX FORM TEMPLATE. -->


	<!-- BEGIN Real form for Remittance -->
	<xsl:template name="realform">
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name">realform</xsl:with-param>
			<xsl:with-param name="method">POST</xsl:with-param>
			<xsl:with-param name="action" select="$realform-action"/>
			<xsl:with-param name="content">
				<div class="widgetContainer">
				<xsl:call-template name="hidden-field">
						<xsl:with-param name="id">gpp_fee_config_flag</xsl:with-param>
						<xsl:with-param name="value" select="$gpp_payment_flag"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="id">gpp_fee_config_amt_cur_code</xsl:with-param>
						<xsl:with-param name="value" select="$gpp_fee_config_cur_code"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="id">gpp_fee_config_amt_val</xsl:with-param>
						<xsl:with-param name="value" select="$gpp_fee_config_amt"/>
					</xsl:call-template>
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
					<xsl:choose>
						<xsl:when test="bulk_ref_id[.='']">			
							<xsl:choose>
								<xsl:when test="$option='MT101' or $option='MT103'">			
									<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">option</xsl:with-param>
										<xsl:with-param name="value">REMITTANCE_CORP</xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">option_for_app_date</xsl:with-param>
										<xsl:with-param name="value">SCRATCH</xsl:with-param>
									</xsl:call-template>
								</xsl:when>	
								<xsl:when test="$option='FI103' or $option='FI202'">
									<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">option</xsl:with-param>
										<xsl:with-param name="value">REMITTANCE_FI</xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">option_for_app_date</xsl:with-param>
										<xsl:with-param name="value">SCRATCH</xsl:with-param>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">option</xsl:with-param>
										<xsl:with-param name="value" select="$option"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>	
						</xsl:when>
					</xsl:choose>					
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
	<!-- END Real form for Remittance -->

	<xsl:template name="remittance-general-details">
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
											<xsl:with-param name="product_types"><xsl:value-of select="concat(product_code, ':', sub_product_code)" /></xsl:with-param>
											<xsl:with-param name="product-types-required">Y</xsl:with-param>
											<xsl:with-param name="required">Y</xsl:with-param>
											<xsl:with-param name="override-displaymode">view</xsl:with-param>
										</xsl:call-template>
										<div id="display_sub_product_code_row" class="field">
											<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_SUB_PRODUCT')"/>&nbsp;</span>
											<div class="content"><xsl:if test="sub_product_code[.!='']"><xsl:value-of select="localization:getDecode($language, 'N047', concat(sub_product_code,'_BK'))"/></xsl:if></div> 
										</div>
									</xsl:when>
									<xsl:otherwise>
									<!-- <xsl:if test="$displaymode='view' and entities[number(.) &gt; 0] "> -->
									<xsl:if test="$displaymode='view' and entity[.!=''] and sub_prod_code[.!='FI103']">                                    
 	 	 								 <div id="display_entity_row" class="field">
 	 	 								 <span class="label"><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></span>
 	 	 								 <div class="content"><xsl:value-of select="entity"/></div> 
 	 	 								 </div>                                                  
 	 	 							 </xsl:if>
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_JURISDICTION_SUB_PRODUCT</xsl:with-param>	
											<xsl:with-param name="id">sub_product_code_view</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code)"/></xsl:with-param>
											<xsl:with-param name="override-displaymode">view</xsl:with-param>
										</xsl:call-template>
										<!-- <xsl:if test="entities[number(.) &gt; 0]"> -->
										<xsl:if test="entities[number(.) &gt; 0] and $displaymode='edit'">	
											<xsl:call-template name="entity-field">
												<xsl:with-param name="required">Y</xsl:with-param>
												<xsl:with-param name="button-type">entity</xsl:with-param>
												<xsl:with-param name="prefix">applicant</xsl:with-param>
												<xsl:with-param name="override-sub-product-code"><xsl:value-of select="concat(product_code, ':', sub_product_code)" /></xsl:with-param>
											</xsl:call-template>
										</xsl:if>
										<!-- Added for Multi bank customer to display the bank name drop down -->
										<xsl:if test="$isMultiBank='Y'">
											<xsl:choose>
												<xsl:when test="$displaymode = 'edit' and banks[number(.) &gt; 1]">
													<xsl:call-template name="select-field">
														<xsl:with-param name="label">CUSTOMER_BANK_LABEL</xsl:with-param>
														<xsl:with-param name="name">customer_bank</xsl:with-param>
														<xsl:with-param name="required">Y</xsl:with-param>
													</xsl:call-template>
													<xsl:call-template name="hidden-field">
														<xsl:with-param name="name">customer_bank_hidden</xsl:with-param>
														<xsl:with-param name="value"><xsl:value-of select="customer_bank"/></xsl:with-param>
													</xsl:call-template>
												</xsl:when>
												<xsl:otherwise>
													<xsl:call-template name="input-field">
														<xsl:with-param name="label">CUSTOMER_BANK_LABEL</xsl:with-param>
														<xsl:with-param name="name">customer_bank</xsl:with-param>
														<xsl:with-param name="value"><xsl:value-of select="customer_bank"/></xsl:with-param>
														<xsl:with-param name="readonly">Y</xsl:with-param>
													</xsl:call-template>
													<xsl:call-template name="hidden-field">
														<xsl:with-param name="name">customer_bank_hidden</xsl:with-param>
														<xsl:with-param name="value"><xsl:value-of select="customer_bank"/></xsl:with-param>
													</xsl:call-template>
												</xsl:otherwise>
											</xsl:choose>	
										</xsl:if>
										<xsl:call-template name="user-account-field">
											<xsl:with-param name="label">XSL_TRANSFER_FROM</xsl:with-param>
											<xsl:with-param name="name">applicant</xsl:with-param>
											<xsl:with-param name="entity-field">entity</xsl:with-param>
											<xsl:with-param name="dr-cr">debit</xsl:with-param>
											<xsl:with-param name="show-product-types">N</xsl:with-param>
											<xsl:with-param name="product_types"><xsl:value-of select="concat(product_code, ':', sub_product_code)" /></xsl:with-param>
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
									<script>
										dojo.ready(function(){
											misys._config = misys._config || {};
											misys._config.customerReferences = {};
											<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
										});
									</script>
								</xsl:if>
								<xsl:if test="$displaymode='edit'">
									<xsl:call-template name="recurring_checkbox" />
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">BANK_LABEL</xsl:with-param>	
									<xsl:with-param name="fieldsize">small</xsl:with-param>
									<xsl:with-param name="id">issuing_bank_name_view</xsl:with-param>
									<xsl:with-param name="value" select="issuing_bank/name" />
									<xsl:with-param name="override-displaymode">view</xsl:with-param>
								</xsl:call-template>
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
	<xsl:template name="remittance-notify-beneficiary-details">
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
    										maxLength="254" size="35" class="medium" value="{notify_beneficiary_email}" readOnly="readOnly" />
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
	<!-- BEGIN Remittance General Details Fieldset. 
	<xsl:template name="remittance-general-details1">
		<xsl:param name="show-template-id">Y</xsl:param>
		<xsl:param name="transfer-from-label">XSL_TRANSFER_FROM</xsl:param>
		<xsl:call-template name="fieldset-wrapper">   		
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content"> 	   			
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">			 
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<xsl:choose>
									<xsl:when test="">
										<xsl:if test="bulk_ref_id[.!='']">
											<div id="display_bulk_ref_id_row" class="field">
												<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_BK_REF_ID')"/></span>
												<div class="content"><xsl:value-of select="bulk_ref_id"/></div> 
											</div>
											<div id="display_entity_row" class="field">
												<span class="label"><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></span>
												<div class="content"><xsl:value-of select="entity"/></div> 
											</div>
											<div id="display_account_row" class="field">
												<span class="label"><xsl:value-of select="localization:getGTPString($language, $transfer-from-label)"/></span>
												<div class="content"><xsl:value-of select="applicant_act_name"/></div> 
											</div>
											<div id="display_sub_product_code_row" class="field">
												<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_SUB_PRODUCT')"/></span>
												<div class="content"><xsl:if test="sub_product_code[.!='']"><xsl:value-of select="localization:getDecode($language, 'N047', concat(sub_product_code,'_BK'))"/></xsl:if></div> 
											</div>
										</xsl:if>									
									</xsl:when>
									<xsl:otherwise>
										<xsl:if test="entities[number(.) &gt; 0]">
											<xsl:call-template name="entity-field">
												<xsl:with-param name="required">Y</xsl:with-param>
											    <xsl:with-param name="button-type">entity</xsl:with-param>
											    <xsl:with-param name="prefix">applicant</xsl:with-param>
											    <xsl:with-param name="override-sub-product-code"><xsl:value-of select="concat(product_code, ':', sub_product_code)" /></xsl:with-param>
										    </xsl:call-template>
										</xsl:if>
								    	<xsl:call-template name="user-account-field">
									     	<xsl:with-param name="label">XSL_TRANSFER_FROM</xsl:with-param>
										    <xsl:with-param name="name">applicant</xsl:with-param>
										    <xsl:with-param name="entity-field">entity</xsl:with-param>
										    <xsl:with-param name="dr-cr">debit</xsl:with-param>
										    <xsl:with-param name="show-product-types">N</xsl:with-param>
										    <xsl:with-param name="product_types"><xsl:value-of select="concat(product_code, ':', sub_product_code)" /></xsl:with-param>
										    <xsl:with-param name="product-types-required">Y</xsl:with-param>
										    <xsl:with-param name="required">Y</xsl:with-param>
								    	</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
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
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">BANK_LABEL</xsl:with-param>	
									<xsl:with-param name="fieldsize">small</xsl:with-param>
									<xsl:with-param name="value" select="issuing_bank/name" />
									<xsl:with-param name="override-displaymode">view</xsl:with-param>
								</xsl:call-template>
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
	</xsl:template>-->
	<!-- END Remittance General Details Fieldset. -->  
</xsl:stylesheet>