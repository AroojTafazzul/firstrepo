<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Fund Transfer (FT) Form, Bank Side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    exclude-result-prefixes="localization xmlRender securitycheck utils security defaultresource">

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
  <xsl:param name="newPaymentFromScratch">false</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
  <xsl:param name="bank_reporting">false</xsl:param>
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" /> 
  <xsl:include href="./common/ft_common.xsl" />
  <xsl:include href="./common/remittance_common.xsl" />
  <xsl:include href="../../core/xsl/common/beneficiary_advices_common.xsl" />
  <xsl:include href="../../core/xsl/common/bank_fx_common.xsl" />
  <xsl:include href="../../collaboration/xsl/collaboration.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="ft_tnx_record"/>
  </xsl:template>
 
 <!-- 
   FT TNX FORM TEMPLATE.
  -->
  <xsl:template match="ft_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
   <xsl:variable name="bankReporting"><xsl:value-of select="$bank_reporting"/></xsl:variable>
   
	    <script>
			dojo.ready(function(){
				console.log('bank_ft_remittance_bank_ft_remittance_bank_ft_remittance_bank_ft_remittance_bank_ft_remittance_'+'<xsl:value-of select="$bank_reporting"/>');
				
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
				 //Call Template to initialize the recurring payment details related configuration
				 <xsl:call-template name="recurring_payment_details_script" />
			});
	</script>

   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    <xsl:variable name="ftFinancialRemittanceflag" select="defaultresource:getResource('FT_FR_DISPLAY')"></xsl:variable>

    <!-- Display common reporting area -->
    		<xsl:call-template name="bank-reporting-area">
    		<xsl:with-param name="hide-reporting-message-details"><xsl:if test="tnx_type_code='54' or bulk_ref_id[.!='']">Y</xsl:if></xsl:with-param>
    		<xsl:with-param name="hide-charge-details"><xsl:if test="tnx_type_code='54'or bulk_ref_id[.!='']">Y</xsl:if></xsl:with-param>
    		 <xsl:with-param name="ftbulk-bank-cancel"><xsl:if test="tnx_type_code='54'or bulk_ref_id[.!=''] ">Y</xsl:if></xsl:with-param>
    		</xsl:call-template>
    		
    		<!-- Attachments -->
    		<xsl:if test="tnx_type_code!='54' and bulk_ref_id[.='']">
			    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
			    	 <xsl:call-template name="attachments-file-dojo">
				       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
				       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
			      	</xsl:call-template> 
				</xsl:if>
			</xsl:if>
    
    <!--
    The <xsl:choose> below was present in v3, handling customer-specific requests to enable transaction editing. 
    The link should always be shown by default in v4, but the logic is kept as a comment, for reference 
    -->
    <!-- 
    <xsl:choose>
     
    -->
      <!-- Link to display transaction contents -->
      <xsl:call-template name="transaction-details-link"/>
      
      <div id="transactionDetails">
       <xsl:call-template name="form-wrapper">
        <xsl:with-param name="name" select="$main-form-name"/>
        <xsl:with-param name="validating">Y</xsl:with-param>
        <xsl:with-param name="content">
         <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
         
         <!-- Disclaimer Notice -->
         <xsl:call-template name="disclaimer"/>
         
         <xsl:call-template name="hidden-fields"/>
<!--         <xsl:call-template name="general-details"/>-->
			<!--
		 	 General Details Fieldset. 
		  	-->
		  		<xsl:call-template name="fieldset-wrapper">   		
			   		<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			   		<xsl:with-param name="content">
			   		<xsl:call-template name="input-field">
				     	<xsl:with-param name="label">ENTITY_LABEL</xsl:with-param>	
				     	<xsl:with-param name="disabled">Y</xsl:with-param>	
						<xsl:with-param name="id">entity_view</xsl:with-param>
						<xsl:with-param name="fieldsize">small</xsl:with-param>
			   			<xsl:with-param name="value" select="entity" />
			   			<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
						
					<xsl:call-template name="input-field">
				     	<xsl:with-param name="label">XSL_TRANSFER_FROM</xsl:with-param>	
				     	<xsl:with-param name="id">transfer_from_view</xsl:with-param>
						<xsl:with-param name="fieldsize">small</xsl:with-param>
		    			<xsl:with-param name="value" select="applicant_act_name" />
		    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="input-field">
				     	<xsl:with-param name="label">BANK_LABEL</xsl:with-param>
				     	<xsl:with-param name="name">issuing_bank_name</xsl:with-param>	
						<xsl:with-param name="fieldsize">small</xsl:with-param>
			   			<xsl:with-param name="value" select="issuing_bank/name" />
			   			<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>	
					
					<xsl:call-template name="input-field">
				     	<xsl:with-param name="label">XSL_PRODUCT_TYPE</xsl:with-param>			
					    <xsl:with-param name="name">product_type</xsl:with-param>
			   			<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code[.])"/></xsl:with-param>
			   			<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
				  	<xsl:call-template name="common-general-details">
				  		<xsl:with-param name="show-template-id">N</xsl:with-param>
			     		<xsl:with-param name="show-cust-ref-id">N</xsl:with-param>			     		
			  		</xsl:call-template>
					</xsl:with-param>
		  		</xsl:call-template>		  		
		  		 <xsl:call-template name="recurring_content">
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="isBankReporting">view</xsl:with-param>
				 </xsl:call-template>
				<xsl:if test="sub_product_code[.='MT101']">
	     			<xsl:call-template name="remittance-beneficiary-details" /> 
	     			<xsl:variable name="displayInterbankDetailsflag" select="defaultresource:getResource('MT101_INTER_BANK_DETAILS_DISPLAY')"/>
	     			<xsl:if test="$displayInterbankDetailsflag = 'true'">
		      			<xsl:call-template name="intermediary-bank-details" />
		      		</xsl:if>  
		      		<xsl:call-template name="transaction-details">	      					
		    			<xsl:with-param name="show-request-date">Y</xsl:with-param>
		    			 <xsl:with-param name="override-displaymode">view</xsl:with-param> 
		      		</xsl:call-template>    
		      		<!-- <xsl:call-template name="forex-details" /> -->
		      		<!-- bulk amount access handling -->
	      			<xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
			      		<xsl:if test="fx_rates_type and fx_rates_type[.!='']">
	        				<xsl:call-template name="bank-fx-template">
	        					<xsl:with-param name="override-displaymode">view</xsl:with-param>
	        				</xsl:call-template>
	        			</xsl:if> 
        			</xsl:if>    
		      		<xsl:call-template name="instruction-to-bank-details">
		      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
		      		</xsl:call-template>  
		      		<xsl:call-template name="transaction-remarks-details" >
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
	     		</xsl:if>
	     		
	     		<xsl:if test="sub_product_code[.='MT103']">
	     			<xsl:variable name="displayInterbankDetailsflag" select="defaultresource:getResource('MT103_INTER_BANK_DETAILS_DISPLAY')"/>
			      	<xsl:call-template name="remittance-beneficiary-details">   				
<!--		     			<xsl:with-param name="show-branch-address">Y</xsl:with-param>	      		-->
			      	</xsl:call-template> 
			      	<xsl:if test="$displayInterbankDetailsflag = 'true'">
			      		<xsl:call-template name="intermediary-bank-details" />
			      	</xsl:if>  
			      	<xsl:call-template name="transaction-details">	      					
		     			 <xsl:with-param name="override-displaymode">view</xsl:with-param> 
			      	</xsl:call-template>    
			      	<xsl:if test="$ftFinancialRemittanceflag = 'true'">
						<xsl:call-template name="js-remittance-collections-view"/>
					</xsl:if>
			      	<!-- <xsl:call-template name="forex-details" /> -->
			      	<!-- bulk amount access handling -->
	      			<xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
			      		<xsl:if test="fx_rates_type and fx_rates_type[.!='']">
	        				<xsl:call-template name="bank-fx-template">
	        					<xsl:with-param name="override-displaymode">view</xsl:with-param>
	        				</xsl:call-template>
	        			</xsl:if>  
	        		</xsl:if>	  
			      	<xsl:call-template name="beneficiary-advice-details" /> 
			      	<xsl:call-template name="instruction-to-bank-details">
		      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
		      		</xsl:call-template>   
			      	<xsl:call-template name="transaction-remarks-details" >
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
	     		</xsl:if>
	     		<xsl:if test="sub_product_code[.='FI103']">
	     		<xsl:variable name="displayInterbankDetailsflag" select="defaultresource:getResource('FI103_INTER_BANK_DETAILS_DISPLAY')"/>
			      	<xsl:call-template name="ordering-customer-details" /> 
			      	<xsl:call-template name="remittance-beneficiary-details">   				
			      	</xsl:call-template>  
			      	<xsl:if test="$displayInterbankDetailsflag = 'true'">
			      		<xsl:call-template name="intermediary-bank-details" />
			      	</xsl:if>  
			      	<xsl:call-template name="transaction-details">	      
			      		<xsl:with-param name="transaction-label">XSL_TRANSACTION_REFERENCE</xsl:with-param>	
			      		<xsl:with-param name="show-sender-to-receiver-info">Y</xsl:with-param>
		     			<xsl:with-param name="show-debit-account-for-charges">Y</xsl:with-param>
		     			<!-- <xsl:with-param name="override-displaymode">view</xsl:with-param> --> 
			      	</xsl:call-template>    
			      	<xsl:if test="$ftFinancialRemittanceflag = 'true'">
			      		<xsl:call-template name="js-remittance-collections-view"/>
					</xsl:if>
			      	<!-- <xsl:call-template name="forex-details" /> -->
		      		<xsl:if test="fx_rates_type and fx_rates_type[.!='']">
        				<xsl:call-template name="bank-fx-template"/>
        			</xsl:if>    
			      	<xsl:call-template name="beneficiary-advice-details" /> 
			      	<xsl:call-template name="instruction-to-bank-details">
		      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
		      		</xsl:call-template>   
			      	<xsl:call-template name="transaction-remarks-details" >
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
	     		</xsl:if>
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
			      		<!-- <xsl:with-param name="override-displaymode">view</xsl:with-param> -->
			      	</xsl:call-template>    
			      	<xsl:if test="$ftFinancialRemittanceflag = 'true'">
						<xsl:call-template name="js-remittance-collections-view"/>
					</xsl:if>
			      	<!-- <xsl:call-template name="forex-details" /> -->
		      		<xsl:if test="fx_rates_type and fx_rates_type[.!='']">
        				<xsl:call-template name="bank-fx-template">
        					<xsl:with-param name="override-displaymode">view</xsl:with-param>
        				</xsl:call-template>
        			</xsl:if>  
			      	<xsl:call-template name="beneficiary-advice-details" /> 
			      	<xsl:call-template name="instruction-to-bank-details">
		      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
		      		</xsl:call-template>  
			      	
			      	<xsl:call-template name="beneficiary-advices-section">
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template> 
			      	<xsl:call-template name="transaction-remarks-details" >
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
	     		</xsl:if>
        </xsl:with-param>
       </xsl:call-template>
      </div>
   
    <xsl:call-template name="menu">
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
      <xsl:with-param name="cash-bankft-bulk-cancel"><xsl:if test="tnx_type_code='54' or bulk_ref_id[.!='']">Y</xsl:if></xsl:with-param>
    </xsl:call-template>
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
	   </xsl:if>
	
  <!-- Javascript imports  -->
  <xsl:call-template name="js-imports"/>
  
  <!-- Bene Advice Dialog and GridMultipleItem Template Node -->
  <xsl:call-template name="bene-advices-dialog-template"/>
 </xsl:template>
 
 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
 
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="common-js-imports">
<!--   <xsl:with-param name="binding">misys.binding.cash.BankReportingFtBinding</xsl:with-param>-->
	<xsl:with-param name="binding">misys.binding.bank.report_remittance</xsl:with-param>
	<xsl:with-param name="override-help-access-key">
	   <xsl:choose>
	   	<xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
	   	<xsl:otherwise>PR_01</xsl:otherwise>
	   </xsl:choose>
	</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 <xsl:template name="ordering-customer-details">
   		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend">XSL_HEADER_ORDERING_CUSTOMER_DETAILS</xsl:with-param>
	     	<xsl:with-param name="button-type"></xsl:with-param>	
	     	<xsl:with-param name="content">
	     		<xsl:call-template name="column-container">
				<xsl:with-param name="content">			 
					<xsl:call-template name="column-wrapper">
						<xsl:with-param name="content">
		     	
			      	<xsl:call-template name="address">	      	
			       		<xsl:with-param name="prefix">ordering_customer</xsl:with-param>	
			       		<xsl:with-param name="show-name">Y</xsl:with-param>  			       		
			       		<xsl:with-param name="name-label">NAME_LABEL</xsl:with-param>
			       		<xsl:with-param name="show-reference">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-name">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-number">N</xsl:with-param>
			       		<xsl:with-param name="show-fax-number">N</xsl:with-param>
			       		<xsl:with-param name="show-email">N</xsl:with-param>
			       		<xsl:with-param name="swift-validate">N</xsl:with-param>
			       		<!-- <xsl:with-param name="override-displaymode">
							<xsl:choose>
								<xsl:when test="$bank_reporting='true'">
									edit
						  		</xsl:when>
						  		<xsl:otherwise>view</xsl:otherwise>
						  	</xsl:choose>
						</xsl:with-param> -->
			       		<xsl:with-param name="override-displaymode">view</xsl:with-param>
			      	</xsl:call-template>	
			      	
			       	<xsl:call-template name="account-field">
			       		<xsl:with-param name="prefix">ordering_customer</xsl:with-param>			       		
			       		<xsl:with-param name="required">Y</xsl:with-param>  			 
			       		<xsl:with-param name="override-displaymode">view</xsl:with-param>  
			       	</xsl:call-template>
		      	    </xsl:with-param>
		      	    </xsl:call-template>
		      	    <xsl:call-template name="column-wrapper">
					<xsl:with-param name="content">
		    		
					<xsl:call-template name="input-field">
	                  <xsl:with-param name="label">XSL_ORIGINATING_INSTITUTION_SWIFT_BIC_CODE</xsl:with-param>
	                  <xsl:with-param name="name">ordering_customer_bank_swift_bic_code</xsl:with-param>
	                  <xsl:with-param name="size">11</xsl:with-param>
	                  <xsl:with-param name="maxsize">11</xsl:with-param>
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
	                  <xsl:with-param name="override-displaymode">view</xsl:with-param> 
	                </xsl:call-template>
		    		
			      	<xsl:call-template name="address">	      	
			       		<xsl:with-param name="prefix">ordering_customer_bank</xsl:with-param>		
			       		<xsl:with-param name="show-name">Y</xsl:with-param>   
	          		 	<xsl:with-param name="name-label">XSL_PARTIESDETAILS_BANK_NAME_AND</xsl:with-param>
			       		<xsl:with-param name="show-reference">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-name">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-number">N</xsl:with-param>
			       		<xsl:with-param name="show-fax-number">N</xsl:with-param>
			       		<xsl:with-param name="show-email">N</xsl:with-param>	      		    		
			       		<xsl:with-param name="show-country">Y</xsl:with-param>
			       		<xsl:with-param name="swift-validate">N</xsl:with-param>	 
			       		<xsl:with-param name="required">Y</xsl:with-param>
			       		<xsl:with-param name="override-displaymode">view</xsl:with-param>
			      	</xsl:call-template>
			      	
			      	<xsl:call-template name="account-field">
			       		<xsl:with-param name="prefix">ordering_customer_bank</xsl:with-param>
			       		<xsl:with-param name="override-displaymode">view</xsl:with-param>			       			 
			       	</xsl:call-template>
			      </xsl:with-param> 	
    		    </xsl:call-template>
    		  </xsl:with-param>
    		</xsl:call-template>    
	    </xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="remittance-beneficiary-details">
   		<xsl:param name="beneficiary-header-label">XSL_HEADER_BENEFICIARY_DETAILS</xsl:param>   			
   		<xsl:param name="beneficiary-name-label">XSL_BENEFICIARYDETAILS_NAME_REMITTANCE</xsl:param>   	 
   		<xsl:param name="beneficiary-account-label">XSL_BENEFICIARY_ACCOUNT_REMITTANCE</xsl:param>    	 
   		<xsl:param name="beneficiary-swiftcode-label">XSL_SWIFT_BIC_CODE</xsl:param>  	    	 
   		<xsl:param name="beneficiary-bank-address-label">XSL_PARTIESDETAILS_BANK_NAME_AND</xsl:param>  		
   	    <xsl:param name="show-branch-address">N</xsl:param>
   	    <xsl:variable name="pre-approved_beneficiary_only" select="not(securitycheck:hasPermission(utils:getUserACL($rundata),'ft_regular_beneficiary_access',utils:getUserEntities($rundata))) or (defaultresource:getResource('NON_PAB_ALLOWED') = 'false')"/>
   		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend" select="$beneficiary-header-label"/>
	     	<xsl:with-param name="button-type"></xsl:with-param>	
	     	<xsl:with-param name="content">
		       <xsl:call-template name="column-container">
				 <xsl:with-param name="content">			 
				  <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">	
			      		<xsl:call-template name="input-field">
						  <xsl:with-param name="label">XSL_PARTIESDETAILS_BENEFICIARY_NAME_AND_REMITTANCE</xsl:with-param>
						  <xsl:with-param name="name">beneficiary_name</xsl:with-param>		
						  <xsl:with-param name="swift-validate">Y</xsl:with-param>
						  <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_name"/></xsl:with-param>
						  <xsl:with-param name="maxsize">35</xsl:with-param>
						  <!-- <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_REGEX')"/></xsl:with-param> -->
						  <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
						  <xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="beneficiary-nickname-field-template"/>						
						<xsl:call-template name="input-field">
							    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
							    <xsl:with-param name="name">beneficiary_address</xsl:with-param>
							    <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_address_line_1"/></xsl:with-param>
							    <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
							    <xsl:with-param name="required">Y</xsl:with-param>
							    <xsl:with-param name="override-displaymode">view</xsl:with-param>
						   </xsl:call-template>
						   <xsl:call-template name="input-field">
							     <xsl:with-param name="name">beneficiary_city</xsl:with-param>
							     <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_address_line_2"/></xsl:with-param>
							     <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
						   		 <xsl:with-param name="override-displaymode">view</xsl:with-param>
						   </xsl:call-template>
						   <xsl:call-template name="input-field">
							     <xsl:with-param name="name">beneficiary_dom</xsl:with-param>
							     <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_dom"/></xsl:with-param>
							     <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template> 
						<!-- When from Bulk Show this country and make it mandatroy -->
						<!-- Making this part configurable as discussed with Product Management for MPS-30472 -->
						<xsl:if test="bulk_ref_id[.!=''] and (defaultresource:getResource('SHOW_BENEFICIARY_COUNTRY_CODE') = 'true')">
							<xsl:call-template name="country-field">
				    			<xsl:with-param name="label">XSL_BENEFICIARY_COUNTRY</xsl:with-param>
				      			<xsl:with-param name="name">beneficiary_country</xsl:with-param>
				      			<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_country"/></xsl:with-param>
				      			<xsl:with-param name="prefix">beneficiary</xsl:with-param>
				      			<xsl:with-param name="required">Y</xsl:with-param>
				      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
				    		</xsl:call-template>
						</xsl:if>
						
	                    <xsl:call-template name="input-field">
						    <xsl:with-param name="label">XSL_BENEFICIARY_ACCOUNT_REMITTANCE</xsl:with-param>
						    <xsl:with-param name="name">beneficiary_account</xsl:with-param>	
						    <xsl:with-param name="maxsize">34</xsl:with-param>	
						    <xsl:with-param name="required">Y</xsl:with-param>
						    <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_act_no"/></xsl:with-param>
						    <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
						    <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_ACCOUNT_NO_VALIDATION_REGEX')"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>						  	
					  	</xsl:call-template>
					  	
					  	<div id="pre_approved_row" class="field">
							<span class="label"/>
							<div id="REMITTANCE" class="content">
							   	 <xsl:attribute name="style">
							   	 <xsl:choose>
							   	 	<xsl:when test="pre_approved_status[.='Y']">display:inline</xsl:when>
							   	 	<xsl:otherwise>display:none</xsl:otherwise>
							   	 </xsl:choose>
							   	 </xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language,'XSL_REMITTANCE_PAB')"/>
							</div> 
						</div>
					  	
		      	</xsl:with-param>
		      	</xsl:call-template>
		      	 <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">	
					<xsl:call-template name="input-field">
	                  <xsl:with-param name="label">XSL_SWIFT_BIC_CODE</xsl:with-param>
	                  <xsl:with-param name="name">cpty_bank_swift_bic_code</xsl:with-param>
	                  <xsl:with-param name="size">11</xsl:with-param>
	                  <xsl:with-param name="maxsize">11</xsl:with-param>
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
	                  <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
	                  <xsl:with-param name="override-displaymode">view</xsl:with-param>
	                </xsl:call-template>
	                
			      	<xsl:call-template name="address">    
			       		<xsl:with-param name="prefix">cpty_bank</xsl:with-param>		
			       		<xsl:with-param name="show-name">Y</xsl:with-param>   
	          		 	<xsl:with-param name="name-label" select="$beneficiary-bank-address-label"/>
			       		<xsl:with-param name="show-reference">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-name">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-number">N</xsl:with-param>
			       		<xsl:with-param name="show-fax-number">N</xsl:with-param>
			       		<xsl:with-param name="show-email">N</xsl:with-param>	       		    		
			       		<xsl:with-param name="show-country">Y</xsl:with-param>
			       		<xsl:with-param name="swift-validate">N</xsl:with-param>
			       		
			       		<xsl:with-param name="override-displaymode">view</xsl:with-param>
			      	</xsl:call-template>
			      	<xsl:if test="$show-branch-address='Y'">
			      		<xsl:if test="$displaymode='edit'">
						<xsl:call-template name="multichoice-field">
	          		 		<xsl:with-param name="label">XSL_BRANCH_ADDRESS_CHECKBOX</xsl:with-param>
	          		 		<xsl:with-param name="type">checkbox</xsl:with-param>
	           		 		<xsl:with-param name="name">branch_address_flag</xsl:with-param>	           		 		
		            	</xsl:call-template>
		            	</xsl:if>
		            	<div id="bankBranchContent">	
			            	<xsl:call-template name="address">	      	
					       		<xsl:with-param name="prefix">beneficiary_bank_branch</xsl:with-param>	
					       		<xsl:with-param name="show-name">N</xsl:with-param>      
					       		<xsl:with-param name="address-label">XSL_BRANCH_ADDRESS</xsl:with-param>
					       		<xsl:with-param name="show-reference">N</xsl:with-param>
					       		<xsl:with-param name="show-contact-name">N</xsl:with-param>
					       		<xsl:with-param name="show-contact-number">N</xsl:with-param>
					       		<xsl:with-param name="show-fax-number">N</xsl:with-param>
					       		<xsl:with-param name="show-email">N</xsl:with-param>	 
					       		<xsl:with-param name="swift-validate">N</xsl:with-param>
					       		<xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
					      	</xsl:call-template>      	
				      	</div>			      		
	            	</xsl:if>	
			      	<xsl:call-template name="clearing-code-desc-field">
		    			<xsl:with-param name="prefix">beneficiary_bank</xsl:with-param>	
		    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
		    		</xsl:call-template>
	    			</xsl:with-param>
	    		  </xsl:call-template>
	    		 </xsl:with-param>
	    	</xsl:call-template>
	    </xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="clearing-code-desc-field">
		<xsl:param name="prefix"/>
		<xsl:param name="override-displaymode"/>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="id"><xsl:value-of select="$prefix"/>_clearing_code_section</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="input-field">
			     	<xsl:with-param name="label">XSL_CLEARING_CODE_DESCRIPTION</xsl:with-param>			
				    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_clearing_code</xsl:with-param>
			   		<xsl:with-param name="maxsize">34</xsl:with-param>
			   		<xsl:with-param name="readonly">N</xsl:with-param>
			   		<xsl:with-param name="size">10</xsl:with-param>
			   		<xsl:with-param name="override-displaymode" select="$override-displaymode"/>
			    </xsl:call-template>
			    <xsl:call-template name="input-field">
				    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_clearing_code_desc</xsl:with-param>
			   		<xsl:with-param name="maxsize">34</xsl:with-param>
			   		<xsl:with-param name="readonly">N</xsl:with-param>
			   		<xsl:with-param name="size">10</xsl:with-param>
			    	<xsl:with-param name="override-displaymode" select="$override-displaymode"/>
			    </xsl:call-template>
			    <!-- <xsl:call-template name="select-field">
				    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_clearing_code_desc</xsl:with-param>
				    <xsl:with-param name="fieldsize">s-medium</xsl:with-param>
				    <xsl:with-param name="content-after">
					   <xsl:if test="$displaymode='edit'"> 	
					   	<xsl:call-template name="button-wrapper">
						      <xsl:with-param name="label">XSL_CLEARING_CODE_FORMAT</xsl:with-param>
						      <xsl:with-param name="show-image">Y</xsl:with-param>
						      <xsl:with-param name="show-border">N</xsl:with-param>		      
		    		  				  <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($questionImage)"/></xsl:with-param>
				      		  <xsl:with-param name="onclick">misys.show<xsl:value-of select="$prefix"/>ClearingCodeFormat();return false;</xsl:with-param>
				      		  <xsl:with-param name="non-dijit-button">N</xsl:with-param>
						</xsl:call-template>
					   </xsl:if>
				    </xsl:with-param>
			   	</xsl:call-template> -->
			</xsl:with-param>
		</xsl:call-template>
    </xsl:template>
    <xsl:template name="intermediary-bank-details">
	   		<xsl:call-template name="fieldset-wrapper">
		     	<xsl:with-param name="legend">XSL_HEADER_INTERMEDIARY_BANK_DETAILS</xsl:with-param>
		     	<xsl:with-param name="button-type"></xsl:with-param>
		     	<xsl:with-param name="content">
		     	<xsl:call-template name="column-container">
				 <xsl:with-param name="content">			 
				  <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">	
					<xsl:call-template name="input-field">
	                  <xsl:with-param name="label">XSL_SWIFT_BIC_CODE</xsl:with-param>
	                  <xsl:with-param name="name">intermediary_bank_swift_bic_code</xsl:with-param>
	                  <xsl:with-param name="size">11</xsl:with-param>
	                  <xsl:with-param name="maxsize">11</xsl:with-param>
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
	                  <xsl:with-param name="override-displaymode">view</xsl:with-param>
	                </xsl:call-template>
			   		
			      	<xsl:call-template name="address">	      	
			       		<xsl:with-param name="prefix">intermediary_bank</xsl:with-param>	
			       		<xsl:with-param name="show-name">Y</xsl:with-param>   
	          		 	<xsl:with-param name="name-label">XSL_PARTIESDETAILS_BANK_NAME_AND</xsl:with-param> 
			       		<xsl:with-param name="show-reference">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-name">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-number">N</xsl:with-param>
			       		<xsl:with-param name="show-fax-number">N</xsl:with-param>
			       		<xsl:with-param name="show-email">N</xsl:with-param>	       		    		
			       		<xsl:with-param name="show-country">Y</xsl:with-param>
			       		<xsl:with-param name="swift-validate">N</xsl:with-param>			       		
			       		<xsl:with-param name="required">N</xsl:with-param>
			       		<xsl:with-param name="override-displaymode">view</xsl:with-param>
			      	</xsl:call-template>
			      	</xsl:with-param>
			      	</xsl:call-template>
			      	
			       <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">
			      	<xsl:call-template name="clearing-code-desc-field">
			   			<xsl:with-param name="prefix">intermediary_bank</xsl:with-param>	
			   		</xsl:call-template>
   				</xsl:with-param>
				</xsl:call-template>
			  </xsl:with-param>
			  </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
   	</xsl:template>
   	
   	<xsl:template name="transaction-details">
   		<xsl:param name="transaction-label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:param>
   		<xsl:param name="show-charge-option">Y</xsl:param>
   		<xsl:param name="show-related-reference">N</xsl:param>
   		<xsl:param name="show-sender-to-receiver-info">N</xsl:param>
   		<xsl:param name="show-request-date">N</xsl:param>
   		<xsl:param name="show-debit-account-for-charges">N</xsl:param>
   		<xsl:param name="show-payment-details-to-beneficiary">Y</xsl:param>
   		<xsl:param name="override-displaymode"/>
   		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend">XSL_HEADER_TRANSACTION_DETAILS</xsl:with-param>
	     	<xsl:with-param name="content">
	     	<xsl:call-template name="column-container">
				 <xsl:with-param name="content">			 
				  <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">	
	     		<!-- Remittance amount field -->
	     		<xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
						<xsl:call-template name="input-field">
					      	<xsl:with-param name="label">XSL_AMOUNTDETAILS_REMITTANCE_AMT_LABEL</xsl:with-param>
						   	<xsl:with-param name="name">ft_amt</xsl:with-param>
						   	<xsl:with-param name="value"><xsl:value-of select="ft_cur_code"/>&#160;<xsl:value-of select="ft_amt"/></xsl:with-param>
						   	<xsl:with-param name="override-displaymode">view</xsl:with-param>
					    </xsl:call-template>
				    </xsl:if>
				    <!-- Charge Option -->
				    <xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
				    <xsl:if test="$show-charge-option='Y'">
					  	<xsl:call-template name="input-field">
					      	<xsl:with-param name="label">XSL_CHARGE_OPTION</xsl:with-param>
					      	<xsl:with-param name="name">charge_option</xsl:with-param>
					      	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*','FT',sub_product_code[.],'C081',charge_option)"/></xsl:with-param>
					      	<xsl:with-param name="override-displaymode">view</xsl:with-param>
					      	<xsl:with-param name="fieldsize">large</xsl:with-param>
					   	</xsl:call-template>
				   	</xsl:if>
			    	
			    	<!-- Related Reference -->	
			    	<xsl:if test="$show-related-reference='Y'">
				    	<xsl:call-template name="input-field">
			     			<xsl:with-param name="label">XSL_RELATED_REFERENCE</xsl:with-param>		
				    		<xsl:with-param name="name">related_reference</xsl:with-param>
			   				<xsl:with-param name="size">16</xsl:with-param>
			   				<xsl:with-param name="maxsize">16</xsl:with-param>
			   				<xsl:with-param name="fieldsize">large</xsl:with-param>
			   				<xsl:with-param name="required">Y</xsl:with-param>
			   				<xsl:with-param name="swift-validate">Y</xsl:with-param>
			   		        <xsl:with-param name="override-displaymode">view</xsl:with-param>
			    		</xsl:call-template>
		    		</xsl:if>
		    	</xsl:if>
		    	<!-- Customer Reference -->	
		    	<xsl:call-template name="input-field">
	     			<xsl:with-param name="label" select="$transaction-label"/>			
		    		<xsl:with-param name="name">cust_ref_id</xsl:with-param>
	   				<xsl:with-param name="size">16</xsl:with-param>
	   				<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_CASH_LENGTH')"/></xsl:with-param>
	   				<xsl:with-param name="regular-expression">
	   							<xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_CASH_VALIDATION_REGEX')"/>
	   				</xsl:with-param>
	   				<xsl:with-param name="fieldsize">small</xsl:with-param>
	   				<xsl:with-param name="override-displaymode">view</xsl:with-param>
	    		</xsl:call-template>
	    		<xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
	    		<!-- Payment Details to Beneficiary -->
	    		<xsl:if test="$show-payment-details-to-beneficiary='Y'">
	    			<xsl:choose>
			    		<xsl:when test="$displaymode='edit'">
						      <xsl:call-template name="textarea-field">
				     			<xsl:with-param name="label">XSL_PAYMENTS_DETAILS_TO_BENEFICIARY</xsl:with-param>	
						        <xsl:with-param name="name">payment_details_to_beneficiary</xsl:with-param>
						        <xsl:with-param name="cols">35</xsl:with-param>
						        <xsl:with-param name="rows">4</xsl:with-param>
						        <xsl:with-param name="maxlines">4</xsl:with-param>
						       	<xsl:with-param name="swift-validate">Y</xsl:with-param>
						       	<xsl:with-param name="override-displaymode" select="$override-displaymode"/>
						    </xsl:call-template>
					      </xsl:when>
					      <xsl:when test="$displaymode='view' and payment_details_to_beneficiary[.!='']">
					      <xsl:call-template name="big-textarea-wrapper">
					      <xsl:with-param name="label">XSL_PAYMENTS_DETAILS_TO_BENEFICIARY</xsl:with-param>
					      <xsl:with-param name="content"><div class="content">
					        <xsl:value-of select="payment_details_to_beneficiary"/>
					      </div></xsl:with-param>
					     </xsl:call-template>
					     </xsl:when>
				     </xsl:choose>
			    </xsl:if>
		  		
			    <xsl:if test="bulk_ref_id[.!=''] and transaction_code and transaction_code/transaction_codes[.!='']">
		    	 <xsl:call-template name="select-field">
								      	<xsl:with-param name="label">XSL_BK_TRANSACTION_CODE</xsl:with-param>
								      	<xsl:with-param name="name">bk_transaction_code</xsl:with-param>
								      	<xsl:with-param name="fieldsize">medium</xsl:with-param>
								      	<xsl:with-param name="required">N</xsl:with-param>
								      	<xsl:with-param name="options">			       		
											<xsl:choose>
												<xsl:when test="$displaymode='edit'">
												<xsl:for-each select="transaction_code/transaction_codes">
												    <option>
													    <xsl:attribute name="value"><xsl:value-of select="transaction_code_id"></xsl:value-of></xsl:attribute>
													    <xsl:value-of select="tranaction_code_des"/>
												    </option>
												</xsl:for-each>
											   </xsl:when>
											</xsl:choose>
								     	</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
				 </xsl:if>
			    <xsl:if test="$show-sender-to-receiver-info='Y'">
			    	<div>
			    	<xsl:choose>
			    		<xsl:when test="$displaymode='edit'">
						      <xsl:call-template name="textarea-field">
				     			<xsl:with-param name="label">XSL_SENDER_TO_RECEIVER_INFORMATION</xsl:with-param>	
						        <xsl:with-param name="name">sender_to_receiver_info</xsl:with-param>
						        <xsl:with-param name="cols">35</xsl:with-param>
						        <xsl:with-param name="rows">6</xsl:with-param>
						        <xsl:with-param name="maxlines">6</xsl:with-param>
						        <xsl:with-param name="swift-validate">Y</xsl:with-param>	
						         <xsl:with-param name="override-displaymode">view</xsl:with-param>		        
						    </xsl:call-template>
					      </xsl:when>
					      <xsl:when test="$displaymode='view' and sender_to_receiver_info[.!='']">
					      <xsl:call-template name="big-textarea-wrapper">
					      <xsl:with-param name="label">XSL_SENDER_TO_RECEIVER_INFORMATION</xsl:with-param>
					      <xsl:with-param name="content"><div class="content">
					        <xsl:value-of select="sender_to_receiver_info"/>
					      </div></xsl:with-param>
					      <xsl:with-param name="override-displaymode">view</xsl:with-param>
					     </xsl:call-template>
					     </xsl:when>
				     </xsl:choose>
				     </div>
			    </xsl:if>
			    </xsl:with-param>
			    </xsl:call-template>
			    <xsl:call-template name="column-wrapper">
				<xsl:with-param name="content">
				<xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
				<div id="process_request_dates_div">
					<xsl:if test="(($displaymode='edit' and bulk_ref_id[.='']) or ($displaymode='view' and recurring_payment_enabled[.='N']))">
					    <xsl:call-template name="input-field">
						    <xsl:with-param name="label">XSL_PROCESSING_DATE</xsl:with-param>
						    <xsl:with-param name="name">iss_date</xsl:with-param>
						    <xsl:with-param name="override-displaymode">view</xsl:with-param>
					   	</xsl:call-template>
					   	
					   	<!--  Request Date. --> 			   	 
					    <xsl:if test="$show-request-date='Y'">
						   	<xsl:call-template name="business-date-field">
							    <xsl:with-param name="label">XSL_REQUEST_DATE</xsl:with-param>
							    <xsl:with-param name="name">request_date</xsl:with-param>
							    <xsl:with-param name="size">10</xsl:with-param>
							    <xsl:with-param name="maxsize">10</xsl:with-param>
							    <xsl:with-param name="fieldsize">small</xsl:with-param>
							    <xsl:with-param name="type">date</xsl:with-param>
							    <xsl:with-param name="swift-validate">N</xsl:with-param>
							    <xsl:with-param name="required">Y</xsl:with-param>
							    <xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
							    <xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
							    <xsl:with-param name="cur-code-widget-id">ft_cur_code</xsl:with-param>
							    <xsl:with-param name="override-displaymode">
								    <xsl:choose>
								    	<xsl:when test="bulk_ref_id[.='']">
									    	<xsl:choose>
									    	<xsl:when test="$override-displaymode != '' "><xsl:value-of select="$override-displaymode"/></xsl:when>
									    	<xsl:when test="$override-displaymode ='view'">view</xsl:when>
									    	<xsl:when test="$displaymode = 'edit'">edit</xsl:when>
									    	<xsl:otherwise>view</xsl:otherwise>
									    	</xsl:choose>
								    	</xsl:when>
								    	<xsl:otherwise>view</xsl:otherwise>
								    </xsl:choose>
							    </xsl:with-param>
						   	</xsl:call-template>	
				    	</xsl:if>
			    	</xsl:if>
		    	</div>	
		    	</xsl:if>
		    	<xsl:variable name="pre-approved_beneficiary_only" select="not(securitycheck:hasPermission(utils:getUserACL($rundata),'ft_regular_beneficiary_access',utils:getUserEntities($rundata))) or (defaultresource:getResource('NON_PAB_ALLOWED') = 'false')"/>
		    	<xsl:call-template name="hidden-field">
			   		<xsl:with-param name="id">beneficiary_bank_clearing_code_desc_no_send</xsl:with-param>
			   		<xsl:with-param name="value"><xsl:value-of select ="beneficiary_bank_clearing_code_desc"/></xsl:with-param>
			   	</xsl:call-template>
			   	<xsl:call-template name="hidden-field">
			   		<xsl:with-param name="id">intermediary_bank_clearing_code_desc_no_send</xsl:with-param>
			   		<xsl:with-param name="value"><xsl:value-of select ="intermediary_bank_clearing_code_desc"/></xsl:with-param>
			   	</xsl:call-template>
			   	<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">option_for_tnx</xsl:with-param>
						<xsl:with-param name="value" select="$option"/>
				</xsl:call-template>
			    <xsl:call-template name="hidden-field">
					<xsl:with-param name="name">iss_date_unsigned</xsl:with-param>
			     	<xsl:with-param name="value" select="iss_date"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">beneficiary_bank_swift_bic_code</xsl:with-param>
			     	<xsl:with-param name="value" select="beneficiary_bank_swift_bic_code"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">debit_account_for_charges</xsl:with-param>
			     	<xsl:with-param name="value" select="debit_account_for_charges"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">charge_act_cur_code</xsl:with-param>
			     	<xsl:with-param name="value" select="charge_act_cur_code"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">charge_act_no</xsl:with-param>
			     	<xsl:with-param name="value" select="charge_act_no"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">base_cur_code</xsl:with-param>
			     	<xsl:with-param name="value" select="base_cur_code"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">request_date_unsigned</xsl:with-param>
			     	<xsl:with-param name="value" select="request_date"></xsl:with-param>
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
					<xsl:with-param name="name">regexValue</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_REGEX')"/></xsl:with-param>
				</xsl:call-template>						
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">allowedProducts</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_EXCLUDED_PRODUCTS')"/></xsl:with-param>
				</xsl:call-template>										
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">product_type</xsl:with-param>
						<xsl:with-param name="value" select="sub_product_code"></xsl:with-param>
					</xsl:call-template>
				<xsl:choose>
				<xsl:when test="security:isBank($rundata)">
		    	<xsl:call-template name="hidden-field">
			      <xsl:with-param name="name">fx_rates_type_temp</xsl:with-param>
			      <xsl:with-param name="value"><xsl:value-of select="fx_rates_type"></xsl:value-of></xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="hidden-field">
			      <xsl:with-param name="name">fx_master_currency</xsl:with-param>
			     <xsl:with-param name="value"><xsl:value-of select="fx_contract_nbr_cur_code_1"></xsl:value-of></xsl:with-param>
			    </xsl:call-template>			    
				</xsl:when>
				<xsl:when test="not(security:isBank($rundata))">
				<xsl:call-template name="hidden-field">
			      <xsl:with-param name="name">fx_rates_type_temp</xsl:with-param>
			      <xsl:with-param name="value"><xsl:value-of select="fx_rates_type"></xsl:value-of></xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="hidden-field">
			      <xsl:with-param name="name">fx_master_currency</xsl:with-param>
			     <xsl:with-param name="value"><xsl:value-of select="fx_contract_nbr_cur_code_1"></xsl:value-of></xsl:with-param>
			    </xsl:call-template>
			    </xsl:when>
			    </xsl:choose>
			    <xsl:choose>
			    <xsl:when test="$pre-approved_beneficiary_only ='true'">
			    <xsl:call-template name="hidden-field">
			      <xsl:with-param name="name">pre_approved_beneficiary_status</xsl:with-param>
			     <xsl:with-param name="value">Y</xsl:with-param>
			    </xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
				<xsl:call-template name="hidden-field">
			      <xsl:with-param name="name">pre_approved_beneficiary_status</xsl:with-param>
			     <xsl:with-param name="value">N</xsl:with-param>
			    </xsl:call-template>
				</xsl:otherwise>
				</xsl:choose>
		    	<!--  Debit Account For Charges -->
			    <xsl:if test="$show-debit-account-for-charges='Y'">
			    	<xsl:call-template name="input-field">
				  		<xsl:with-param name="label">XSL_DEBIT_ACCOUNT_FOR_CHARGES</xsl:with-param>
				  		<xsl:with-param name="name">charge_act_name</xsl:with-param>
				    	<xsl:with-param name="value"><xsl:value-of select="debit_account_for_charges"/></xsl:with-param>
				    	<xsl:with-param name="override-displaymode">view</xsl:with-param>
			    	</xsl:call-template>
		    	</xsl:if>	
	    	</xsl:with-param>
		   </xsl:call-template>
		  </xsl:with-param>
		 </xsl:call-template>
	   </xsl:with-param>
	</xsl:call-template>
	</xsl:template>
 
</xsl:stylesheet>