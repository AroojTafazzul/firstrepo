<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Fund Transfer (FT) Form, Customer Side.
 
 Note: Templates beginning with lc- are in lc_common.xsl

Copyright (c) 2000-2011 Misys (http://www.misys.com),
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
        xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
        exclude-result-prefixes="xmlRender localization ftProcessing">
       
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
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/FundTransferScreen</xsl:param>

  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="cash_common.xsl" />
  <xsl:include href="request_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="ft_tnx_record"/>
  </xsl:template>
  
  <!-- 
   LC TNX FORM TEMPLATE.
  -->
  <xsl:template match="ft_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
  
   <div>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <!--  Display common menu. -->
      <xsl:call-template name="menu"/>
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
      
      <xsl:call-template name="hidden-fields"/>
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="general-details" />
      
      <xsl:choose>
      <xsl:when test="$displaymode='view'">
      	<xsl:call-template name="review-fields"/>
      </xsl:when>
      <xsl:otherwise>
      <xsl:call-template name="ft-transfer-details"/>
      
<!--      <xsl:if test="ft_type[.='02']">-->
       <!-- Bank Details -->
<!--       <xsl:call-template name="tabgroup-wrapper">-->
<!--        <xsl:with-param name="tabgroup-label">XSL_HEADER_BANK_DETAILS</xsl:with-param>-->
<!--        <xsl:with-param name="tabgroup-id">bank-details-tabcontainer</xsl:with-param>-->
   
        <!-- Tab #0 - Ordering Bank  -->
<!--        <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_ORDERING_BANK</xsl:with-param>-->
<!--        <xsl:with-param name="tab0-content">-->
<!--         <xsl:call-template name="issuing-bank-tabcontent"/>-->
<!--        </xsl:with-param>-->
   
        <!-- Tab #1 - Account With Bank -->
<!--        <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_ACCOUNT_WITH_BANK</xsl:with-param>-->
<!--        <xsl:with-param name="tab1-content">-->
<!--         <xsl:apply-templates select="account_with_bank">-->
<!--          <xsl:with-param name="theNodeName">account_with_bank</xsl:with-param>-->
<!--         </xsl:apply-templates>-->
<!--        </xsl:with-param>-->
   
        <!-- Tab #2 - Advise Thru Bank -->
<!--        <xsl:with-param name="tab2-label">XSL_BANKDETAILS_TAB_PAY_THROUGH_BANK</xsl:with-param>-->
<!--        <xsl:with-param name="tab2-content">-->
<!--         <xsl:apply-templates select="pay_through_bank">-->
<!--          <xsl:with-param name="theNodeName">pay_through_bank</xsl:with-param>-->
<!--         </xsl:apply-templates>-->
<!--        </xsl:with-param>-->
<!--      </xsl:call-template>-->
<!--     </xsl:if>-->

	  <xsl:call-template name="bank-instructions">
	   <xsl:with-param name="send-mode-label">XSL_INSTRUCTIONS_FT_ADV_SEND_MODE_LABEL</xsl:with-param>
	    <xsl:with-param name="send-mode-displayed">
	      <xsl:choose>
	       <xsl:when test="ft_type = '02'">Y</xsl:when>
	       <xsl:otherwise>N</xsl:otherwise>
	      </xsl:choose>
	    </xsl:with-param>
	    <xsl:with-param name="principal-acc-displayed">N</xsl:with-param>
	   <xsl:with-param name="send-mode-required">N</xsl:with-param>
	  </xsl:call-template>
	  
	  <xsl:call-template name="deal-confirmation-dialog"/>
	  <xsl:call-template name="waiting-Dialog"/>
	  <xsl:call-template name="loading-Dialog"/>
	  <xsl:call-template name="account-popup">
	  	<xsl:with-param name="id">orderingAccount</xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="account-popup">
	  	<xsl:with-param name="id">beneficiaryAccount</xsl:with-param>
	  </xsl:call-template>
	  
	  </xsl:otherwise>
	  </xsl:choose>
	  </xsl:with-param>
	 </xsl:call-template>
	 
	 
	<xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
    	<xsl:call-template name="attachments-file-dojo"/>
    </xsl:if>

   <xsl:call-template name="realform"/>
    
   <xsl:call-template name="menu">
    <xsl:with-param name="second-menu">Y</xsl:with-param>
   </xsl:call-template>
  </div>
     
  <!-- Table of Contents -->
  <xsl:call-template name="toc"/>
  
  <!--  Collaboration Window -->     
  <!--       
  <xsl:call-template name="collaboration">
   <xsl:with-param name="editable">true</xsl:with-param>
   <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
   <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
   <xsl:with-param name="bank_name_widget_id"></xsl:with-param>
   <xsl:with-param name="bank_abbv_name_widget_id"></xsl:with-param>
  </xsl:call-template>
  -->
  
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
   <xsl:with-param name="binding">misys.binding.cash.TradeCreateFtBinding</xsl:with-param>
  </xsl:call-template>
 </xsl:template>

  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
	<xsl:call-template name="common-hidden-fields">
		<xsl:with-param name="additional-fields">
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">beneficiaryName</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">applicant_reference</xsl:with-param>
				<xsl:with-param name="id">applicant_reference_hidden</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">deal_type</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">beneficiary_reference</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bo_tnx_id</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">request_number</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bo_ref_id</xsl:with-param>
			</xsl:call-template>
			<!-- Begin to delete ? -->
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">applicantName</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">debitAccountNumber</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">debitAccountName</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">creditAccountNumber</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">creditAccountName</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">executionDate</xsl:with-param>
			</xsl:call-template>
			<!-- End to delete ? -->
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">transactionNumber</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">rate</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">feeAccount</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">feeAmt</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">feeCurCode</xsl:with-param>
			</xsl:call-template>
			
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">counterparty_cur_code</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">counterparty_amt</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
  </xsl:template>

 <!--
   FT General Details Fieldset.
    
   Common General Details, Applicant Details, Beneficiary Details.
  -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <div id="generaldetails">
      <!-- Common general details. -->
      <xsl:call-template name="common-general-details"/>
      
      <!-- Initiation From -->
      <xsl:if test="cross_references/cross_reference/type_code[.='02']">
       <xsl:variable name="parent_file" select="xmlRender:getXMLMasterNode(cross_references/cross_reference[./type_code='02']/product_code, cross_references/cross_reference[./type_code='02']/ref_id, $language)"/>
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
        <xsl:with-param name="value" select="$parent_file/bo_ref_id"/>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      
      
      <!-- 
      		Fund Transfer Currency.
      		 Hidding this field, the transfer currency is made in FT Transfer Details
       -->
<!--      <xsl:call-template name="input-field">-->
<!--       <xsl:with-param name="label">XSL_GENERALDETAILS_FT_CUR_CODE</xsl:with-param>-->
<!--       <xsl:with-param name="name">input_cur_code</xsl:with-param>-->
<!--       <xsl:with-param name="value"><xsl:value-of select="ft_cur_code"/></xsl:with-param>-->
<!--       <xsl:with-param name="size">3</xsl:with-param>-->
<!--       <xsl:with-param name="fieldsize">x-small</xsl:with-param>-->
<!--       <xsl:with-param name="maxsize">3</xsl:with-param>-->
<!--       <xsl:with-param name="button-type">ft_currency</xsl:with-param>-->
<!--       <xsl:with-param name="uppercase">Y</xsl:with-param>-->
<!--       <xsl:with-param name="required">Y</xsl:with-param>-->
<!--      </xsl:call-template>-->
      
      <!-- Applicant Details -->
      <div class="clear"></div>
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:call-template name="address">
         <xsl:with-param name="show-entity">Y</xsl:with-param>
         <xsl:with-param name="prefix">applicant</xsl:with-param>
        </xsl:call-template>
        
        <!--
         If we have to, we show the reference field for applicants. This is
         specific to this form.
         -->
        <xsl:if test="not(avail_main_banks/bank/entity/customer_reference) and not(avail_main_banks/bank/customer_reference)">
         <xsl:call-template name="input-field">
          <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
          <xsl:with-param name="name">applicant_reference</xsl:with-param>
          <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('APPLICANT_REFERENCE_LENGTH')"/></xsl:with-param>
         </xsl:call-template>
        </xsl:if>
       
       </xsl:with-param>
      </xsl:call-template>
      
      <!-- 
      		Beneficiary Details.
      		Replace older Beneficiary Details field
       -->
     
      
     </div>
    </xsl:with-param>
   </xsl:call-template>
   <!-- Beneficiary Details : Hiding this field for the moment -->
   <!-- Adding beneficiary account is made under Applicant details -->
<!--   <xsl:call-template name="attachments-counterparties"/>-->
  </xsl:template>
  
  <!-- 
   FT Transfer Details
   -->
  <xsl:template name="ft-transfer-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_PARTIESDETAILS_TRANSFER_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
		
			<!-- Ordering details -->
			<xsl:if test="$displaymode='edit'">
				<script>
					dojo.ready(function(){
						misys._config = misys._config || {};
						misys._config.customerReferences = {};
						<xsl:apply-templates select="avail_main_banks/bank"	mode="customer_references" />
					});
				</script>
			</xsl:if>
<!--					<xsl:call-template name="main-bank-selectbox">-->
<!--						<xsl:with-param name="label">-->
<!--							<xsl:choose>-->
<!--								<xsl:when test="ft_type[.='01']">XSL_PARTIESDETAILS_BANK_NAME</xsl:when>-->
<!--								<xsl:otherwise>XSL_PARTIESDETAILS_BANK_NAME</xsl:otherwise>-->
<!--							</xsl:choose>-->
<!--						</xsl:with-param>-->
<!--						<xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>-->
<!--						<xsl:with-param name="sender-name">applicant</xsl:with-param>-->
<!--						<xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>-->
<!--					</xsl:call-template>-->
<!--					<xsl:call-template name="customer-reference-selectbox">-->
<!--						<xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>-->
<!--						<xsl:with-param name="sender-name">applicant</xsl:with-param>-->
<!--						<xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>-->
<!--					</xsl:call-template>-->
					
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FT_DEBIT_ACCOUNT_LABEL</xsl:with-param>
				<xsl:with-param name="name">applicant_act_no</xsl:with-param>
				<xsl:with-param name="maxsize">34</xsl:with-param>
				<xsl:with-param name="button-type">account</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="disabled">Y</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_FT_DEBIT_ACCOUNT_CURRENCY</xsl:with-param>
				<xsl:with-param name="product-code">applicant_act</xsl:with-param>
				<xsl:with-param name="override-amt-displaymode">N</xsl:with-param>
				<xsl:with-param name="show-button">N</xsl:with-param>
				<xsl:with-param name="disabled">Y</xsl:with-param>
			</xsl:call-template>
			<br/>
			<!-- Beneficiary Details -->
			<xsl:if test="ft_type[.='01'] or ft_type[.='05']">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_FT_CREDIT_ACCOUNT_LABEL</xsl:with-param>
					<xsl:with-param name="name">transfer_account</xsl:with-param>
					<xsl:with-param name="maxsize">34</xsl:with-param>
					<xsl:with-param name="button-type">account</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="disabled">Y</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_FT_CREDIT_ACCOUNT_CURRENCY</xsl:with-param>
					<xsl:with-param name="product-code">transfer_account</xsl:with-param>
					<xsl:with-param name="override-amt-displaymode">N</xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
					<xsl:with-param name="disabled">Y</xsl:with-param>
				</xsl:call-template>
				<!-- tranfert amt -->
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_AMOUNTDETAILS_FT_AMT_LABEL</xsl:with-param>
					<xsl:with-param name="product-code">ft</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="show-button">Y</xsl:with-param>
					<xsl:with-param name="get-data-action">GetCashStaticData</xsl:with-param>
					<xsl:with-param name="user-action">Test</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="ft_type[.='02']  or ft_type[.='05']">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="legend">XSL_FT_BENEFICIARY_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FREE_FORMAT_INSTRUCTIONS_NAME_LABEL</xsl:with-param>
							<xsl:with-param name="name">beneficiary_name</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="fieldsize">medium</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FREE_FORMAT_INSTRUCTIONS_ACCOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="name">counterparty_details_act_no</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="fieldsize">medium</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FREE_FORMAT_INSTRUCTIONS_ADDRESS_LABEL</xsl:with-param>
							<xsl:with-param name="name">beneficiary_address</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="fieldsize">medium</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FREE_FORMAT_INSTRUCTIONS_CITY_CITY</xsl:with-param>
							<xsl:with-param name="name">beneficiary_city</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="fieldsize">medium</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FREE_FORMAT_INSTRUCTIONS_COUNTRY_LABEL</xsl:with-param>
							<xsl:with-param name="name">beneficiary_country</xsl:with-param>
							<xsl:with-param name="prefix">beneficiary</xsl:with-param>
							<xsl:with-param name="button-type">codevalue</xsl:with-param>
							<xsl:with-param name="disabled">Y</xsl:with-param>
							<xsl:with-param name="fieldsize">x-small</xsl:with-param>
						    <xsl:with-param name="size">2</xsl:with-param>
						    <xsl:with-param name="maxsize">2</xsl:with-param>
						    <xsl:with-param name="required">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<br/>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="legend">XSL_FT_BENEFICIARY_BANK_LABEL</xsl:with-param>
					<xsl:with-param name="content">	
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FREE_FORMAT_INSTRUCTIONS_NAME_LABEL</xsl:with-param>
						<xsl:with-param name="name">account_with_bank_name</xsl:with-param>
						<xsl:with-param name="size">35</xsl:with-param>
						<xsl:with-param name="maxsize">35</xsl:with-param>
						<xsl:with-param name="fieldsize">medium</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FREE_FORMAT_INSTRUCTIONS_ACCOUNT_LABEL</xsl:with-param>
						<xsl:with-param name="name">beneficiary_bank_account</xsl:with-param>
						<xsl:with-param name="size">35</xsl:with-param>
						<xsl:with-param name="maxsize">35</xsl:with-param>
						<xsl:with-param name="fieldsize">medium</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FREE_FORMAT_INSTRUCTIONS_CITY_CITY</xsl:with-param>
						<xsl:with-param name="name">account_with_bank_dom</xsl:with-param>
						<xsl:with-param name="size">35</xsl:with-param>
						<xsl:with-param name="maxsize">35</xsl:with-param>
						<xsl:with-param name="fieldsize">medium</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FREE_FORMAT_INSTRUCTIONS_COUNTRY_LABEL</xsl:with-param>
						<xsl:with-param name="name">beneficiary_bank_country</xsl:with-param>
						<xsl:with-param name="prefix">beneficiary_bank</xsl:with-param>
						<xsl:with-param name="button-type">codevalue</xsl:with-param>
						<xsl:with-param name="disabled">Y</xsl:with-param>
						<xsl:with-param name="fieldsize">x-small</xsl:with-param>
					    <xsl:with-param name="size">2</xsl:with-param>
					    <xsl:with-param name="maxsize">2</xsl:with-param>
					    <xsl:with-param name="required">Y</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FREE_FORMAT_INSTRUCTIONS_BANK_NUMBER</xsl:with-param>
						<xsl:with-param name="name">beneficiary_bank_routing_number</xsl:with-param>
						<xsl:with-param name="size">35</xsl:with-param>
						<xsl:with-param name="maxsize">35</xsl:with-param>
						<xsl:with-param name="fieldsize">medium</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FREE_FORMAT_INSTRUCTIONS_BANK_BRANCH</xsl:with-param>
						<xsl:with-param name="name">beneficiary_bank_branch</xsl:with-param>
						<xsl:with-param name="size">35</xsl:with-param>
						<xsl:with-param name="maxsize">35</xsl:with-param>
						<xsl:with-param name="fieldsize">medium</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FREE_FORMAT_INSTRUCTIONS_BANK_ADRESS</xsl:with-param>
						<xsl:with-param name="name">beneficiary_bank_address</xsl:with-param>
						<xsl:with-param name="size">35</xsl:with-param>
						<xsl:with-param name="maxsize">35</xsl:with-param>
						<xsl:with-param name="fieldsize">medium</xsl:with-param>
					</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<!-- payment amt -->
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_AMOUNTDETAILS_FT_AMT_LABEL</xsl:with-param>
					<xsl:with-param name="product-code">payment</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="show-button">
						<xsl:choose>
							<xsl:when test="ft_type[.='05']">N</xsl:when>
							<xsl:otherwise>Y</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="get-data-action">GetCashStaticData</xsl:with-param>
					<xsl:with-param name="user-action">Test</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<br/>
			
			<!-- Execution Date. -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_EXECUTION_DATE</xsl:with-param>
				<xsl:with-param name="name">iss_date</xsl:with-param>
				<xsl:with-param name="size">10</xsl:with-param>
				<xsl:with-param name="maxsize">10</xsl:with-param>
				<xsl:with-param name="type">date</xsl:with-param>
				<xsl:with-param name="fieldsize">small</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL</xsl:with-param>
				<xsl:with-param name="name">fwd_contract_no</xsl:with-param>
				<xsl:with-param name="size">34</xsl:with-param>
				<xsl:with-param name="maxsize">34</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="multioption-group">
				<xsl:with-param name="group-label">XSL_CHRGDETAILS_BORN_BY_LABEL</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">
							<xsl:choose>
								<xsl:when test="ft_type[.='01'] or ft_type[.='05']">XSL_FT_CHARGE_DEBIT_ACCOUNT_LABEL</xsl:when>
								<xsl:otherwise>XSL_FT_CHARGE_APPLICANT_LABEL</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="name">open_chrg_brn_by_code</xsl:with-param>
						<xsl:with-param name="id">open_chrg_brn_by_code_1</xsl:with-param>
						<xsl:with-param name="value">01</xsl:with-param>
<!--						<xsl:with-param name="checked"><xsl:if test="self::node()[. = $first-value]">Y</xsl:if></xsl:with-param>-->
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">
							<xsl:choose>
								<xsl:when test="ft_type[.='01'] or ft_type[.='05']">XSL_FT_CHARGE_CREDIT_ACCOUNT_LABEL</xsl:when>
								<xsl:otherwise>XSL_FT_CHARGE_BENEFICIARY_LABEL</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="name">open_chrg_brn_by_code</xsl:with-param>
						<xsl:with-param name="id">open_chrg_brn_by_code_2</xsl:with-param>
						<xsl:with-param name="value">02</xsl:with-param>
<!--						<xsl:with-param name="checked"><xsl:if test="self::node()[. = $second-value]">Y</xsl:if></xsl:with-param>-->
					</xsl:call-template>
					<xsl:if test="ft_type[.='05']">
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_FT_CHARGE_BENEFICIARY_LABEL</xsl:with-param>
							<xsl:with-param name="name">open_chrg_brn_by_code</xsl:with-param>
							<xsl:with-param name="id">open_chrg_brn_by_code_3</xsl:with-param>
							<xsl:with-param name="value">03</xsl:with-param>
	<!--						<xsl:with-param name="checked"><xsl:if test="self::node()[. = $second-value]">Y</xsl:if></xsl:with-param>-->
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="row-wrapper">
				<xsl:with-param name="id">narrative_additional_instructions</xsl:with-param>
<!--						<xsl:with-param name="required">Y</xsl:with-param>-->
				<xsl:with-param name="label">XSL_PAYMENTDETAILS_MESSAGE_LABEL</xsl:with-param>
				<xsl:with-param name="type">textarea</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="textarea-field">
						<xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
						<xsl:with-param name="rows">13</xsl:with-param>
						<xsl:with-param name="cols">40</xsl:with-param>
<!--						<xsl:with-param name="required">Y</xsl:with-param>-->
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>
  
<xsl:template name="deal-confirmation-dialog">
 <div class="widgetContainer">
	<xsl:call-template name="dialog">
		<xsl:with-param name="id">dealSummaryDialog</xsl:with-param>
	    <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_FT_DEAL_SUMMARY_DIALOG_TITLE')" /></xsl:with-param>
	    <xsl:with-param name="content">
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_ORDERING_DETAILS</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">summary_applicantName</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_CUSTOMER</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						<xsl:with-param name="value">&nbsp;</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">summary_debitAccountNumber</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_ACCOUT</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						<xsl:with-param name="value">&nbsp;</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">summary_debitAccountName</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_ACCOUNT_NAME</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						<xsl:with-param name="value">&nbsp;</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">summary_debitAmount</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_AMOUNT</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						<xsl:with-param name="value">&nbsp;</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<div id="transferDetailsId">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_TRANSFER_BENEFICIARY_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
				    	<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">summary_beneficiaryReference</xsl:with-param>
						</xsl:call-template>
				    	<xsl:call-template name="input-field">
							<xsl:with-param name="name">summary_beneficiaryName</xsl:with-param>
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_NAME</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">summary_creditAccountNumber</xsl:with-param>
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_ACCOUNT</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">summary_creditAccountName</xsl:with-param>
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_ACCOUNT_NAME</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">summary_transferAmount</xsl:with-param>
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_TRANSFERT_AMOUNT</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</div>
			<div id="paymentDetailsId">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_PAYMENT_BENEFICIARY_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
				    	<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_NAME</xsl:with-param>
							<xsl:with-param name="name">summary_beneficiary_name</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_ACCOUNT</xsl:with-param>
							<xsl:with-param name="name">summary_counterparty_details_act_no</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_ADDRESS</xsl:with-param>
							<xsl:with-param name="name">summary_beneficiary_address</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_CITY</xsl:with-param>
							<xsl:with-param name="name">summary_beneficiary_city</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_COUNTRY</xsl:with-param>
							<xsl:with-param name="name">summary_beneficiary_country</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK</xsl:with-param>
							<xsl:with-param name="name">summary_account_with_bank_name</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK_ACCOUNT</xsl:with-param>
							<xsl:with-param name="name">summary_beneficiary_bank_account</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK_CITY</xsl:with-param>
							<xsl:with-param name="name">summary_account_with_bank_dom</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK_COUNTRY</xsl:with-param>
							<xsl:with-param name="name">summary_beneficiary_bank_country</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK_NUMBER</xsl:with-param>
							<xsl:with-param name="name">summary_beneficiary_bank_routing_number</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK_BRANCH</xsl:with-param>
							<xsl:with-param name="name">summary_beneficiary_bank_branch</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK_ADRESS</xsl:with-param>
							<xsl:with-param name="name">summary_beneficiary_bank_address</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">summary_paymentAmount</xsl:with-param>
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_PAYEMENT_AMOUNT</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</div>
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_TRANSFER_DETAILS</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">summary_bo_ref_id</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_TRANSACTION_NUMBER</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						<xsl:with-param name="value">&nbsp;</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">summary_executionDate</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_APPLICATION_DATE</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						<xsl:with-param name="value">&nbsp;</xsl:with-param>
					</xsl:call-template>
<!--					<xsl:call-template name="input-field">-->
<!--						<xsl:with-param name="name">summary_amount</xsl:with-param>-->
<!--						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_TRANSFER_AMOUNT</xsl:with-param>-->
<!--						<xsl:with-param name="override-displaymode">view</xsl:with-param>-->
<!--						<xsl:with-param name="value">&nbsp;</xsl:with-param>-->
<!--					</xsl:call-template>-->
<!--					<xsl:call-template name="input-field">-->
<!--						<xsl:with-param name="name">summaryCurrency</xsl:with-param>-->
<!--						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_TRANSFER_CURRENCY</xsl:with-param>-->
<!--						<xsl:with-param name="override-displaymode">view</xsl:with-param>-->
<!--						<xsl:with-param name="value">&nbsp;</xsl:with-param>-->
<!--					</xsl:call-template>-->
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">summary_feeAccount</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_CHARGE_ACCT</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						<xsl:with-param name="value">&nbsp;</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">summary_feeAmount</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_CHARGE_AMT</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						<xsl:with-param name="value">&nbsp;</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">summary_rate</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_RATE</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						<xsl:with-param name="value">&nbsp;</xsl:with-param>
					</xsl:call-template>
					<div id="rateField">
						<xsl:call-template name="row-wrapper">
							<xsl:with-param name="content">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_RATES_DISCLAIMER')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="row-wrapper">
							<xsl:with-param name="content">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_RATE_VALIDITY_DISCLAIMER_PREFIX')"/>
								<span id="validitySpan"></span>
							</xsl:with-param>
						</xsl:call-template>
						<div id="progressBarCash" class="field">
						<label for="customerReference_details_nosend">&nbsp;</label>
						<div dojoType="dijit.ProgressBar" style="width:300px" jsId="jsProgress" id="countdownProgress" maximum="10"></div>
						</div>
					</div>
				</xsl:with-param>
			</xsl:call-template>
	    </xsl:with-param>
		<xsl:with-param name="buttons">
		   	<xsl:call-template name="row-wrapper">
				<xsl:with-param name="content">
					<xsl:call-template name="button-wrapper">
						<xsl:with-param name="id">sendRequestId</xsl:with-param>
						<xsl:with-param name="label">XSL_ACTION_OK</xsl:with-param>
						<xsl:with-param name="onclick">fncAcceptFT();</xsl:with-param>
						<xsl:with-param name="show-text-label">Y</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="button-wrapper">
						<xsl:with-param name="id">rejectDelayId</xsl:with-param>
						<xsl:with-param name="label">XSL_ACTION_REJECT</xsl:with-param>
						<xsl:with-param name="onclick">fncRejectFT();</xsl:with-param>
						<xsl:with-param name="show-text-label">Y</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
	    </xsl:with-param>
	</xsl:call-template>
  </div>
</xsl:template>
  
<xsl:template name="review-fields">

	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_PARTIESDETAILS_TRANSFER_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_ORDERING_DETAILS</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">review_applicantName</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_CUSTOMER</xsl:with-param>
						<xsl:with-param name="value" select="applicant_name"/>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">review_debitAccountNumber</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_ACCOUT</xsl:with-param>
						<xsl:with-param name="value" select="applicant_act_no"/>
					</xsl:call-template>
<!--					<xsl:call-template name="input-field">-->
<!--						<xsl:with-param name="name">review_debitAccountName</xsl:with-param>-->
<!--						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_ACCOUNT_NAME</xsl:with-param>-->
<!--						<xsl:with-param name="value" select=""/>-->
<!--					</xsl:call-template>-->
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">review_debitAmount</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_AMOUNT</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="ft_cur_code"/>&nbsp;<xsl:value-of select="ft_amt"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<div id="transferDetailsId">
			<xsl:if test="ft_type[.='01'] or ft_type[.='05']">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_TRANSFER_BENEFICIARY_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
				    	<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">review_beneficiaryReference</xsl:with-param>
						</xsl:call-template>
<!--				    	<xsl:call-template name="input-field">-->
<!--							<xsl:with-param name="name">review_beneficiaryName</xsl:with-param>-->
<!--							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_NAME</xsl:with-param>-->
<!--							<xsl:with-param name="value" select="counterparty[counterparty_type='TRANSFER']/counterparty_name"/>-->
<!--						</xsl:call-template>-->
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">review_creditAccountNumber</xsl:with-param>
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_ACCOUNT</xsl:with-param>
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='TRANSFER']/counterparty_act_no"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">review_creditAccountName</xsl:with-param>
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_ACCOUNT_NAME</xsl:with-param>
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='TRANSFER']/counterparty_name"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">review_transferAmount</xsl:with-param>
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_TRANSFERT_AMOUNT</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="counterparties/counterparty[counterparty_type='TRANSFER']/counterparty_cur_code"/>&nbsp;
								<xsl:value-of select="counterparties/counterparty[counterparty_type='TRANSFER']/counterparty_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			</div>
			
			<div id="paymentDetailsId">
			<xsl:if test="ft_type[.='02'] or ft_type[.='05']">	
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_PAYMENT_BENEFICIARY_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
				    	<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_NAME</xsl:with-param>
							<xsl:with-param name="name">review_beneficiary_name</xsl:with-param>
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='PAYMENT']/counterparty_name"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_ACCOUNT</xsl:with-param>
							<xsl:with-param name="name">review_counterparty_details_act_no</xsl:with-param>
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='PAYMENT']/counterparty_act_no"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_ADDRESS</xsl:with-param>
							<xsl:with-param name="name">review_beneficiary_address</xsl:with-param>
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='PAYMENT']/counterparty_address_line_1"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_CITY</xsl:with-param>
							<xsl:with-param name="name">review_beneficiary_city</xsl:with-param>
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='PAYMENT']/counterparty_address_line_2"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_COUNTRY</xsl:with-param>
							<xsl:with-param name="name">review_beneficiary_country_code</xsl:with-param>
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='PAYMENT']/counterparty_dom"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK</xsl:with-param>
							<xsl:with-param name="name">review_account_with_bank_name</xsl:with-param>
							<xsl:with-param name="value" select="account_with_bank/name"/>
						</xsl:call-template>
<!--						<xsl:call-template name="input-field">-->
<!--							<xsl:with-param name="label">XSL_SI_FX_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_ACCOUNT</xsl:with-param>-->
<!--							<xsl:with-param name="name">review_beneficiary_bank_account</xsl:with-param>-->
<!--							<xsl:with-param name="value" select=""/>-->
<!--						</xsl:call-template>-->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK_CITY</xsl:with-param>
							<xsl:with-param name="name">review_account_with_bank_dom</xsl:with-param>
							<xsl:with-param name="value" select="account_with_bank/dom"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_COUNTRY</xsl:with-param>
							<xsl:with-param name="name">review_beneficiary_bank_country</xsl:with-param>
							<xsl:with-param name="value" select="account_with_bank/country"/>
						</xsl:call-template>
<!--						<xsl:call-template name="input-field">-->
<!--							<xsl:with-param name="label">XSL_SI_FX_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_NUMBER</xsl:with-param>-->
<!--							<xsl:with-param name="name">review_beneficiary_bank_routing_number</xsl:with-param>-->
<!--							<xsl:with-param name="value" select=""/>-->
<!--						</xsl:call-template>-->
<!--						<xsl:call-template name="input-field">-->
<!--							<xsl:with-param name="label">XSL_SI_FX_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_BRANCH</xsl:with-param>-->
<!--							<xsl:with-param name="name">review_beneficiary_bank_branch</xsl:with-param>-->
<!--							<xsl:with-param name="value" select=""/>-->
<!--						</xsl:call-template>-->
<!--						<xsl:call-template name="input-field">-->
<!--							<xsl:with-param name="label">XSL_SI_FX_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_ADRESS</xsl:with-param>-->
<!--							<xsl:with-param name="name">review_beneficiary_bank_address</xsl:with-param>-->
<!--							<xsl:with-param name="value" select=""/>-->
<!--						</xsl:call-template>-->
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">review_paymentAmount</xsl:with-param>
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_PAYEMENT_AMOUNT</xsl:with-param>
							<xsl:with-param name="value">
							<xsl:value-of select="counterparties/counterparty[counterparty_type='PAYMENT']/counterparty_cur_code"/>&nbsp;<xsl:value-of select="counterparties/counterparty[counterparty_type='PAYMENT']/counterparty_amt"/>
						</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			</div>
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_TRANSFER_DETAILS</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">review_fee_account</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_CHARGE_ACCT</xsl:with-param>
						<xsl:with-param name="value" select="fee_act_no"/>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">review_fee_amount</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_CHARGE_AMT</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="fee_cur_code"/>&nbsp;<xsl:value-of select="fee_amt"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">review_bo_ref_id</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_TRANSACTION_NUMBER</xsl:with-param>
						<xsl:with-param name="value" select="bo_ref_id"/>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">review_executionDate</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_APPLICATION_DATE</xsl:with-param>
						<xsl:with-param name="value" select="appl_date"/>
					</xsl:call-template>
<!--					<xsl:call-template name="input-field">-->
<!--						<xsl:with-param name="name">review_feeAccount</xsl:with-param>-->
<!--						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_CHARGE_ACCT</xsl:with-param>-->
<!--						<xsl:with-param name="value" select=""/>-->
<!--					</xsl:call-template>-->
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">review_rate</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_RATE</xsl:with-param>
						<xsl:with-param name="value" select="rate"/>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


  <!--
   Hidden fields for Letter of Credit 
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
      </xsl:call-template> <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value"/>
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
      <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">productcode</xsl:with-param>
	    <xsl:with-param name="value" select="$product-code"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">subproductcode</xsl:with-param>
    	<xsl:with-param name="value"><xsl:value-of select="sub_product_code"/></xsl:with-param>
   	  </xsl:call-template>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>