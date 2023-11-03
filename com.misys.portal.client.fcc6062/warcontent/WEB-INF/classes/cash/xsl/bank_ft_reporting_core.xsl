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
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    exclude-result-prefixes="localization xmlRender">

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
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" /> 
  <xsl:include href="../../core/xsl/common/remittance_common.xsl" />
  <xsl:include href="../../core/xsl/common/cash_common.xsl" />
 
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
   <script>
			dojo.ready(function(){
			
				misys._config = misys._config || {};
				dojo.mixin(misys._config, {
						productCode: '<xsl:value-of select="$product-code"/>',
						clearingCodes :  new Array(),
						clearingCodesDescription : new Array(),
						clearingCodesFormat : new Array(),
						clearingCodesRegExp : new Array(),
						clearingCodesMandatory : new Array(),
						countryCurrencyPair :  new Array(),
						ibanMandatory : new Array()
						
				});
				<xsl:for-each select="clearing_codes/clearing_code_set">
					<xsl:variable name="country_currency"><xsl:value-of select="country_currency"/></xsl:variable>
						misys._config.clearingCodes["<xsl:value-of select="$country_currency"/>"] = new Array(<xsl:value-of select="count(codes_set/clearing_code)"/>);
						misys._config.clearingCodesDescription["<xsl:value-of select="$country_currency"/>"] = new Array(<xsl:value-of select="count(codes_set/clearing_code)"/>);
						<xsl:for-each select="codes_set/clearing_code">
							<xsl:variable name="position" select="position() - 1" />
							misys._config.clearingCodes["<xsl:value-of select="$country_currency"/>"][<xsl:value-of select="$position"/>]="<xsl:value-of select="code"/>";
	        				misys._config.clearingCodesDescription["<xsl:value-of select="$country_currency"/>"][<xsl:value-of select="$position"/>]="<xsl:value-of select="description"/>";
						</xsl:for-each>
						misys._config.countryCurrencyPair["<xsl:value-of select="$country_currency"/>"]="Y";
						
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

   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Display common reporting area -->
    <xsl:call-template name="bank-reporting-area"/>
    
    <!-- Attachments -->
    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
     <xsl:call-template name="attachments-file-dojo">
       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
      </xsl:call-template> 
	</xsl:if>
    
    <!--
    The <xsl:choose> below was present in v3, handling customer-specific requests to enable transaction editing. 
    The link should always be shown by default in v4, but the logic is kept as a comment, for reference 
    -->
    <!-- 
    <xsl:choose>
     <xsl:when test="tnx_type_code[.='15']">
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
<!--		 	<xsl:template name="general-details-bank">-->
		  		<xsl:call-template name="fieldset-wrapper">   		
			   		<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			   		<xsl:with-param name="content">
			   		<xsl:call-template name="hidden-field">
<!--				    	<xsl:with-param name="name">sub_product_code</xsl:with-param>-->
					</xsl:call-template>	
					<xsl:call-template name="input-field">
				     	<xsl:with-param name="label">ENTITY_LABEL</xsl:with-param>	
				     	<xsl:with-param name="id">entity_view</xsl:with-param>
				     	<xsl:with-param name="disabled">Y</xsl:with-param>	
						<xsl:with-param name="fieldsize">small</xsl:with-param>
			   			<xsl:with-param name="value" select="entity" />
			   			<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
						
					<xsl:call-template name="input-field">
				     	<xsl:with-param name="label">XSL_TRANSFER_FROM</xsl:with-param>	
				     	<xsl:with-param name="id">transfer_from_view</xsl:with-param>
						<xsl:with-param name="fieldsize">small</xsl:with-param>
		    			<xsl:with-param name="value" select="transfer_from" />
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
			   			<xsl:with-param name="value">
								<xsl:if test="sub_product_code[. = 'MT101']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_REMITTANCE_SUB_PRODUCT_MT101')"/>
								</xsl:if>
								<xsl:if test="sub_product_code[. = 'MT103']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_REMITTANCE_SUB_PRODUCT_MT103')"/>
								</xsl:if>
								<xsl:if test="sub_product_code[. = 'FI103']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_REMITTANCE_SUB_PRODUCT_FI103')"/>
								</xsl:if>
								<xsl:if test="sub_product_code[. = 'FI202']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_REMITTANCE_SUB_PRODUCT_FI202')"/>
								</xsl:if>
			      			</xsl:with-param>
			   			<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
				  	<xsl:call-template name="common-general-details">
			     			<xsl:with-param name="show-cust-ref-id">N</xsl:with-param>
			  			</xsl:call-template>
					</xsl:with-param>
		  		</xsl:call-template>
<!--		 	</xsl:template>-->
         <xsl:if test="sub_product_code[.='MT101']">
	     			<xsl:call-template name="beneficiary-details" /> 
		      		<xsl:call-template name="intermediary-bank-details" />  
		      		<xsl:call-template name="transaction-details">	      					
		    			<xsl:with-param name="show-request-date">Y</xsl:with-param>
		      		</xsl:call-template>    
		      		<xsl:call-template name="forex-details" />     
		      		<xsl:call-template name="instruction-to-bank-details" />  
		      		<xsl:call-template name="transaction-remarks-details" />
	     		</xsl:if>
	     		<xsl:if test="sub_product_code[.='MT103']">
	     			<div id="recurringContent">
			      		<xsl:call-template name="recurring-details" />
			      	</div>
			      	<xsl:call-template name="beneficiary-details">   				
		     			<xsl:with-param name="show-branch-address">Y</xsl:with-param>	      		
			      	</xsl:call-template> 
			      	<xsl:call-template name="intermediary-bank-details" />  
			      	<xsl:call-template name="transaction-details">	      					
		     			<xsl:with-param name="show-debit-account-for-charges">Y</xsl:with-param>
			      	</xsl:call-template>    
			      	<xsl:call-template name="forex-details" />     
			      	<xsl:call-template name="beneficiary-advice-details" /> 
			      	<xsl:call-template name="instruction-to-bank-details" />  
			      	<xsl:call-template name="transaction-remarks-details" />
	     		</xsl:if>
	     		<xsl:if test="sub_product_code[.='FI103']">
			      	<xsl:call-template name="ordering-customer-details" /> 
			      	<xsl:call-template name="beneficiary-details">   				
		     			<xsl:with-param name="show-branch-address">Y</xsl:with-param>	      		
			      	</xsl:call-template>  
			      	<xsl:call-template name="intermediary-bank-details" />  
			      	<xsl:call-template name="transaction-details">	      
			      		<xsl:with-param name="transaction-label">XSL_TRANSACTION_REFERENCE</xsl:with-param>	
			      		<xsl:with-param name="show-sender-to-receiver-info">Y</xsl:with-param>
		     			<xsl:with-param name="show-debit-account-for-charges">Y</xsl:with-param>
			      	</xsl:call-template>    
			      	<xsl:call-template name="forex-details" />     
			      	<xsl:call-template name="beneficiary-advice-details" /> 
			      	<xsl:call-template name="instruction-to-bank-details" />  
			      	<xsl:call-template name="transaction-remarks-details" />
	     		</xsl:if>
	     		<xsl:if test="sub_product_code[.='FI202']">
			      	<xsl:call-template name="ordering-institution-details" /> 
			      	<xsl:call-template name="beneficiary-details">   				
		     			<xsl:with-param name="beneficiary-header-label">XSL_HEADER_BENEFICIARY_INSTITUTION_DETAILS</xsl:with-param>				
		     			<xsl:with-param name="beneficiary-name-label">XSL_BENEFICIARY_INSTITUTION_NAME</xsl:with-param>	 
		     			<xsl:with-param name="beneficiary-account-label">XSL_BENEFICIARY_INSTITUTION_ACCOUNT</xsl:with-param>
		     			<xsl:with-param name="beneficiary-swiftcode-label">XSL_BENEFICIARY_INSTITUTION_SWIFT_CODE</xsl:with-param>
		     			<xsl:with-param name="beneficiary-bank-address-label">XSL_BENEFICIARY_INSTITUTION_BANK_ADDRESS_NAME</xsl:with-param>     			     		
			      	</xsl:call-template>  
			      	<xsl:call-template name="intermediary-bank-details" />  
			      	<xsl:call-template name="transaction-details">	      
			      		<xsl:with-param name="transaction-label">XSL_TRANSACTION_REFERENCE</xsl:with-param>	
			      		<xsl:with-param name="show-charge-option">N</xsl:with-param>
			      		<xsl:with-param name="show-related-reference">Y</xsl:with-param>
			      		<xsl:with-param name="show-sender-to-receiver-info">Y</xsl:with-param>
			      		<xsl:with-param name="show-payment-details-to-beneficiary">N</xsl:with-param>
			      	</xsl:call-template>    
			      	<xsl:call-template name="forex-details" />     
			      	<xsl:call-template name="beneficiary-advice-details" /> 
			      	<xsl:call-template name="instruction-to-bank-details" />  
			      	<xsl:call-template name="transaction-remarks-details" />
	     		</xsl:if>
<!--         <xsl:call-template name="ft-transfer-details"/>-->
        </xsl:with-param>
       </xsl:call-template>
      </div>

    <xsl:call-template name="menu">
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
    </xsl:call-template>
   </div>
   
  <!-- Table of Contents -->
  <xsl:call-template name="toc"/>

  <!-- Javascript imports  -->
  <xsl:call-template name="js-imports"/>
 </xsl:template>
 
 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
 
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="common-js-imports">
	 <xsl:with-param name="binding">misys.binding.bank.report_remittance</xsl:with-param>
	 <xsl:with-param name="override-help-access-key">
	   <xsl:choose>
	   	<xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
	   	<xsl:otherwise>PR_01</xsl:otherwise>
	   </xsl:choose>
	   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- 
  FT General Details
  -->
<!--   <xsl:template name="general-details">-->
<!--  <xsl:call-template name="fieldset-wrapper">-->
<!--   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>-->
<!--   <xsl:with-param name="content">-->
<!--    <xsl:call-template name="input-field">-->
<!--     <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>-->
<!--     <xsl:with-param name="name">ref_id</xsl:with-param>-->
<!--     <xsl:with-param name="override-displaymode">view</xsl:with-param>-->
<!--    </xsl:call-template>-->
<!--     <xsl:call-template name="hidden-field">-->
<!--      <xsl:with-param name="name">ref_id</xsl:with-param>-->
<!--      <xsl:with-param name="name">ref_id_hidden</xsl:with-param>-->
<!--     </xsl:call-template>-->
<!--    <xsl:call-template name="input-field">-->
<!--     <xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_ID</xsl:with-param>-->
<!--     <xsl:with-param name="name">template_id</xsl:with-param>-->
<!--     <xsl:with-param name="size">15</xsl:with-param>-->
<!--     <xsl:with-param name="maxsize">20</xsl:with-param>-->
<!--    </xsl:call-template>-->
<!---->
<!--     Initiation From -->
<!--    <xsl:if test="cross_references/cross_reference/type_code[.='02']">-->
<!--     <xsl:variable name="parent_file" select="xmlRender:getXMLMasterNode(cross_references/cross_reference[./type_code='02']/product_code, cross_references/cross_reference[./type_code='02']/ref_id, $language)"/>-->
<!--     <xsl:call-template name="input-field">-->
<!--      <xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>-->
<!--      <xsl:with-param name="value" select="$parent_file/bo_ref_id"/>-->
<!--      <xsl:with-param name="override-displaymode">view</xsl:with-param>-->
<!--     </xsl:call-template>-->
<!--    </xsl:if>-->
<!--    -->
<!--     Cross Refs -->
<!--     Shown in consolidated view -->
<!--    <xsl:if test="cross_references">-->
<!--     <xsl:apply-templates select="cross_references" mode="display_table_tnx"/>-->
<!--    </xsl:if>-->
<!--      -->
<!--     Execution Date. -->
<!--    <xsl:call-template name="input-field">-->
<!--     <xsl:with-param name="label">XSL_GENERALDETAILS_EXECUTION_DATE</xsl:with-param>-->
<!--     <xsl:with-param name="name">iss_date</xsl:with-param>-->
<!--     <xsl:with-param name="size">10</xsl:with-param>-->
<!--     <xsl:with-param name="maxsize">10</xsl:with-param>-->
<!--     <xsl:with-param name="type">date</xsl:with-param>-->
<!--     <xsl:with-param name="fieldsize">small</xsl:with-param>-->
<!--     <xsl:with-param name="required">Y</xsl:with-param>-->
<!--    </xsl:call-template>-->
<!--      -->
<!--     Fund Transfer Currency.  -->
<!--    <xsl:call-template name="input-field">-->
<!--     <xsl:with-param name="label">XSL_GENERALDETAILS_FT_CUR_CODE</xsl:with-param>-->
<!--     <xsl:with-param name="name">input_cur_code</xsl:with-param>-->
<!--     <xsl:with-param name="value"><xsl:value-of select="ft_cur_code"/></xsl:with-param>-->
<!--     <xsl:with-param name="override-displaymode">view</xsl:with-param>-->
<!--    </xsl:call-template>-->
<!--     define a input cur code in the bank reporting form to fit with the client creation form and-->
<!--              hence allows the javascript function checkField to run  in the two situations-->
<!--    <div>-->
<!--     <xsl:call-template name="hidden-field">-->
<!--      <xsl:with-param name="name">input_cur_code</xsl:with-param>-->
<!--      <xsl:with-param name="value" select="ft_cur_code"/>-->
<!--     </xsl:call-template>-->
<!--    </div>-->
<!--    -->
<!--     Get the ft type-->
<!--    <xsl:variable name="ft_type"><xsl:value-of select="ft_type"/></xsl:variable>-->
<!--    <xsl:call-template name="input-field">-->
<!--     <xsl:with-param name="label">XSL_GENERALDETAILS_FT_TYPE</xsl:with-param>-->
<!--     <xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N029', $ft_type)"/></xsl:with-param>-->
<!--     <xsl:with-param name="override-displaymode">view</xsl:with-param>-->
<!--    </xsl:call-template>-->
<!--     -->
<!--    <div class="clear"></div>-->
<!--     -->
<!--     Applicant Details -->
<!--    <xsl:call-template name="fieldset-wrapper">-->
<!--     <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>-->
<!--     <xsl:with-param name="legend-type">indented-header</xsl:with-param>-->
<!--     <xsl:with-param name="content">-->
<!--      <xsl:call-template name="address">-->
<!--       <xsl:with-param name="show-entity">-->
<!--        <xsl:choose>-->
<!--         <xsl:when test="entity[.='']">N</xsl:when>-->
<!--         <xsl:otherwise>Y</xsl:otherwise>-->
<!--        </xsl:choose>-->
<!--       </xsl:with-param>-->
<!--       <xsl:with-param name="show-entity-button">N</xsl:with-param>-->
<!--       <xsl:with-param name="prefix">applicant</xsl:with-param>-->
<!--      </xsl:call-template>-->
<!---->
<!--      <xsl:call-template name="input-field">-->
<!--       <xsl:with-param name="label">XSL_PARTIESDETAILS_ORDERING_ACT_NO</xsl:with-param>-->
<!--       <xsl:with-param name="name">applicant_act_no</xsl:with-param>-->
<!--       <xsl:with-param name="override-displaymode">view</xsl:with-param>-->
<!--      </xsl:call-template>-->
<!--     </xsl:with-param>-->
<!--    </xsl:call-template>-->
<!--   </xsl:with-param>-->
<!--  </xsl:call-template>-->
<!--   Beneficiary Details -->
<!--  <xsl:call-template name="attachments-counterparties"/>-->
<!-- </xsl:template> -->
 
 <!--
  FT Transfer Details 
  
  ft- prefix since template transfer-details already exists in common.xsl
  -->
<!-- <xsl:template name="ft-transfer-details">-->
<!--   <xsl:call-template name="fieldset-wrapper">-->
<!--    <xsl:with-param name="legend">XSL_PARTIESDETAILS_TRANSFER_DETAILS</xsl:with-param>-->
<!--    <xsl:with-param name="content">-->
<!--      <xsl:call-template name="currency-field">-->
<!--       <xsl:with-param name="label">XSL_AMOUNTDETAILS_FT_AMT_LABEL</xsl:with-param>-->
<!--       <xsl:with-param name="product-code">ft</xsl:with-param>-->
<!--       <xsl:with-param name="required">Y</xsl:with-param>-->
<!--      </xsl:call-template>-->
    
     <!-- <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_FT_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="name">ft_cur_code</xsl:with-param>
       <xsl:with-param name="size">3</xsl:with-param>
       <xsl:with-param name="fieldsize">x-small</xsl:with-param>
       <xsl:with-param name="maxsize">3</xsl:with-param>
       <xsl:with-param name="uppercase">Y</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="button-type">currency</xsl:with-param>
       <xsl:with-param name="name">ft_amt</xsl:with-param>
       <xsl:with-param name="size">20</xsl:with-param>
       <xsl:with-param name="maxsize">15</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="type">amount</xsl:with-param>
      </xsl:call-template>
      --> 
<!--     <xsl:call-template name="input-field">-->
<!--      <xsl:with-param name="label">XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL</xsl:with-param>-->
<!--      <xsl:with-param name="name">fwd_contract_no</xsl:with-param>-->
<!--      <xsl:with-param name="size">34</xsl:with-param>-->
<!--      <xsl:with-param name="maxsize">34</xsl:with-param>-->
<!--     </xsl:call-template>-->
     
     <!-- Bank Details -->
<!--     <xsl:call-template name="tabgroup-wrapper">-->
<!--      <xsl:with-param name="tabgroup-label">XSL_HEADER_BANK_DETAILS</xsl:with-param>-->
<!--      <xsl:with-param name="legend-type">indented-header</xsl:with-param>-->
<!--   -->
      <!-- Tab #0 - Account With Bank -->
<!--      <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_ACCOUNT_WITH_BANK</xsl:with-param>-->
<!--      <xsl:with-param name="tab0-content">-->
<!--        Account With Bank Details  -->
<!--       <xsl:apply-templates select="account_with_bank">-->
<!--        <xsl:with-param name="theNodeName">account_with_bank</xsl:with-param>-->
<!--       </xsl:apply-templates>-->
<!--      </xsl:with-param>-->
   
      <!-- Tab #2 - Advise Thru Bank -->
<!--      <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_PAY_THROUGH_BANK</xsl:with-param>-->
<!--      <xsl:with-param name="tab1-content">-->
       <!-- Advise Thru Bank Details  -->
<!--       <xsl:apply-templates select="pay_through_bank">-->
<!--        <xsl:with-param name="theNodeName">pay_through_bank</xsl:with-param>-->
<!--       </xsl:apply-templates>-->
<!--      </xsl:with-param>-->
<!--     </xsl:call-template>-->
<!--    </xsl:with-param>-->
<!--   </xsl:call-template>-->
<!--  </xsl:template>-->
</xsl:stylesheet>