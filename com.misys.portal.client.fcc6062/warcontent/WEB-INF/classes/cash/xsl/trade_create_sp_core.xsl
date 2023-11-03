<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Request for Sweep (SP) Form, Customer Side.

Copyright (c) 2000-2010 Misys (http://www.misys.com),
All Rights Reserved.  

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
        xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
        exclude-result-prefixes="localization">

  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">SP</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/SweepScreen</xsl:param>
  <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
  <xsl:param name="editImage"><xsl:value-of select="$images_path"/>edit.png</xsl:param>
 
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="cash_common.xsl" />
  <xsl:include href="./request_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="sp_tnx_record"/>
  </xsl:template>
  
  <!-- 
   FX TNX FORM TEMPLATE.
  -->
  <xsl:template match="sp_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
  
   <div >
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <!--  Display common menu. -->
      <xsl:call-template name="menu">
       <xsl:with-param name="show-save">N</xsl:with-param>
       <xsl:with-param name="show-template">N</xsl:with-param>
      </xsl:call-template>
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
     
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details"/>
     
      <!-- request Details. -->
      <xsl:call-template name="sp-details"/>

     </xsl:with-param>
    </xsl:call-template>

    <!-- Form #1 : Attach Files -->
    <!--  
    <xsl:call-template name="attachments-file-dojo"/>
	-->
	
    <xsl:call-template name="realform"/>

    <xsl:call-template name="menu">
		<xsl:with-param name="show-save">N</xsl:with-param>
	    <xsl:with-param name="show-template">N</xsl:with-param>
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
   <xsl:with-param name="binding">misys.binding.cash.TradeCreateSpBinding</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="show-type">N</xsl:with-param>
    <xsl:with-param name="additional-fields">
     <xsl:call-template name="hidden-field">
	  <xsl:with-param name="name">sp_type</xsl:with-param>
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
  
  
  <!-- SP General Details -->
  <xsl:template name="sp-details">
  <div id="request-details">
		<xsl:if test="$displaymode='edit'">
			<xsl:attribute name="style">display:block</xsl:attribute>
		</xsl:if>
		<!-- General part -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_SP_DETAIL_SWEEP</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SP_TARGET_ACCOUNT</xsl:with-param>
					<xsl:with-param name="name">concentration_account_no</xsl:with-param>
					<xsl:with-param name="maxsize">34</xsl:with-param>
					<xsl:with-param name="button-type">account</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="disabled">Y</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="account-popup">
					<xsl:with-param name="id">concentrationAccount</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">applicant_reference</xsl:with-param>
					<xsl:with-param name="value"/>
				</xsl:call-template>
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_SP_TARGET_ACCOUNT_CURRENCY</xsl:with-param>
					<xsl:with-param name="product-code">concentration_account</xsl:with-param>
					<xsl:with-param name="override-amt-displaymode">N</xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
					<xsl:with-param name="disabled">Y</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SP_DESCRIPTION</xsl:with-param>
					<xsl:with-param name="name">sweeping_description</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="maxsize">250</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="multioption-group">
					<xsl:with-param name="group-label">XSL_SP_SWEEPING_METHOD</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="checkbox-field">
							<xsl:with-param name="label">XSL_SP_SWEEPING_METHOD_DEFICIT</xsl:with-param>
							<xsl:with-param name="name">sweeping_method_deficit</xsl:with-param>
							<xsl:with-param name="id">sweeping_method_deficit</xsl:with-param>
							<xsl:with-param name="value">01</xsl:with-param>
							<xsl:with-param name="checked"><xsl:if test="sweep_method[. = 'DEFICIT_AND_SURPLUS'] or sweep_method[. = 'DEFICIT']">Y</xsl:if></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="checkbox-field">
							<xsl:with-param name="label">XSL_SP_SWEEPING_METHOD_SURPLUS</xsl:with-param>
							<xsl:with-param name="name">sweeping_method_surplus</xsl:with-param>
							<xsl:with-param name="id">sweeping_method_surplus</xsl:with-param>
							<xsl:with-param name="value">02</xsl:with-param>
							<xsl:with-param name="checked"><xsl:if test="sweep_method[. = 'DEFICIT_AND_SURPLUS'] or sweep_method[. = 'SURPLUS']">Y</xsl:if></xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<!-- Sweeping rules part -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_SP_SWEEPING_RULES</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<div id="funding-currency-field">
							<xsl:call-template name="currency-field">
								<xsl:with-param name="label">XSL_SP_MIN_BALANCE</xsl:with-param>
								<xsl:with-param name="product-code">min_balance</xsl:with-param>
								<xsl:with-param name="show-button">N</xsl:with-param>
								<xsl:with-param name="get-data-action">GetCashStaticData</xsl:with-param>
								<xsl:with-param name="user-action">Test</xsl:with-param>
								<xsl:with-param name="override-currency-value"><xsl:value-of select="floor_amt_cur_code"/></xsl:with-param>
								<xsl:with-param name="override-amt-value"><xsl:value-of select="floor_amt"/></xsl:with-param>
							</xsl:call-template>
						</div>
						<div id="receiving-currency-field">
							<xsl:call-template name="currency-field">
								<xsl:with-param name="label">XSL_SP_MAX_BALANCE</xsl:with-param>
								<xsl:with-param name="product-code">max_balance</xsl:with-param>
								<xsl:with-param name="show-button">N</xsl:with-param>
								<xsl:with-param name="get-data-action">GetCashStaticData</xsl:with-param>
								<xsl:with-param name="user-action">Test</xsl:with-param>
								<xsl:with-param name="override-currency-value"><xsl:value-of select="ceiling_amt_cur_code"/></xsl:with-param>
								<xsl:with-param name="override-amt-value"><xsl:value-of select="ceiling_amt"/></xsl:with-param>
							</xsl:call-template>
						</div>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SP_START_DATE</xsl:with-param>
							<xsl:with-param name="name">start_date</xsl:with-param>
							<xsl:with-param name="maxsize">10</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
							<xsl:with-param name="type">date</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SP_END_DATE</xsl:with-param>
							<xsl:with-param name="name">end_date</xsl:with-param>
							<xsl:with-param name="maxsize">10</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
							<xsl:with-param name="type">date</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="multioption-group">
							<xsl:with-param name="group-label">XSL_SP_FREQUENCY</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="radio-field">
									<xsl:with-param name="label">XSL_SP_FREQUENCY_DAILY</xsl:with-param>
									<xsl:with-param name="name">frequency</xsl:with-param>
									<xsl:with-param name="id">frequency_daily</xsl:with-param>
									<xsl:with-param name="value">DAILY</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="radio-field">
									<xsl:with-param name="label">XSL_SP_FREQUENCY_WEEKLY</xsl:with-param>
									<xsl:with-param name="name">frequency</xsl:with-param>
									<xsl:with-param name="id">frequency_weekly</xsl:with-param>
									<xsl:with-param name="value">WEEKLY</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="radio-field">
									<xsl:with-param name="label">XSL_SP_FREQUENCY_MONTHLY</xsl:with-param>
									<xsl:with-param name="name">frequency</xsl:with-param>
									<xsl:with-param name="id">frequency_monthly</xsl:with-param>
									<xsl:with-param name="value">MONTHLY</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="radio-field">
									<xsl:with-param name="label">XSL_SP_FREQUENCY_ANNUALLY</xsl:with-param>
									<xsl:with-param name="name">frequency</xsl:with-param>
									<xsl:with-param name="id">frequency_annually</xsl:with-param>
									<xsl:with-param name="value">ANNUALLY</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<!-- Debit Accounts part -->
				<div id="funding-attachments-accounts-field">
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_SP_FUNDING_ACCT</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
							<xsl:call-template name="attachments-accounts">
								<xsl:with-param name="prefix">funding</xsl:with-param>
								<xsl:with-param name="existing-accounts" select="//funding_accounts/funding_account"/>
							</xsl:call-template>
							<xsl:call-template name="account-popup">
								<xsl:with-param name="id">fundingAccount</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</div>
				<!-- Credit Accounts part -->
				<div id="receiving-attachments-accounts-field">
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_SP_RECEIVING_ACCT</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
							<xsl:call-template name="attachments-accounts">
								<xsl:with-param name="prefix">receiving</xsl:with-param>
								<xsl:with-param name="existing-accounts" select="//receiving_accounts/receiving_account"/>
							</xsl:call-template>
							<xsl:call-template name="account-popup">
								<xsl:with-param name="id">receivingAccount</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</div>
			</xsl:with-param>
		</xsl:call-template>
  </div>
  </xsl:template>

  <!--
   Hidden fields for Request for Financing
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
					<xsl:with-param name="name">option</xsl:with-param>
					<xsl:with-param name="value"/>
				</xsl:call-template>
			</div>
		</xsl:with-param>
	</xsl:call-template>
  </xsl:template>
  
  
  
  <xsl:template name="attachments-accounts">
  	<xsl:param name="max-attachments">-1</xsl:param>
	<xsl:param name="existing-accounts"/>
	<xsl:param name="prefix"/>
 
	<xsl:call-template name="accounts-table">
    	<xsl:with-param name="max-attachments" select="$max-attachments"/>
    	<xsl:with-param name="existing-accounts" select="$existing-accounts"/>
    	<xsl:with-param name="table-caption">XSL_BENEFICIARIES_TABLE_CAPTION</xsl:with-param>
    	<xsl:with-param name="table-summary">XSL_BENEFICIARIES_TABLE_SUMMARY</xsl:with-param>
    	<xsl:with-param name="table-thead">
    		<th class="sp-acct-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_SP_HEADER_FUNDING_ACT_NO')"/></th>
    		<th class="sp-amt-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_SP_HEADER_MIN_TRANSFER_AMT')"/></th>
    		<th class="sp-amt-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_SP_HEADER_KEEPING_BALANCE')"/></th>
		</xsl:with-param>
		<xsl:with-param name="prefix" select="$prefix"/>
		<xsl:with-param name="empty-table-notice">XSL_SP_TABLE_NO_ACCOUNTS</xsl:with-param>
		<xsl:with-param name="delete-attachments-notice">XSL_TITLE_DOCUMENT_NOTICE</xsl:with-param>
	</xsl:call-template>
    
    <!--
      Hidden Fields for existing attachments
     -->
	<xsl:for-each select="$existing-accounts">
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_account_no_<xsl:value-of select="sweep_account_id"/></xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="account_no"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_min_transfer_cur_code_<xsl:value-of select="sweep_account_id"/></xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="min_transfer_cur_code"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_min_transfer_amt_<xsl:value-of select="sweep_account_id"/></xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="min_transfer_amount"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_keep_balance_cur_code_<xsl:value-of select="sweep_account_id"/></xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="keep_balance_cur_code"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_keep_balance_amt_<xsl:value-of select="sweep_account_id"/></xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="keep_balance_amount"/></xsl:with-param>
		</xsl:call-template>
	</xsl:for-each> 
    
    <!--
     Static Edit Fields 
     -->
	<xsl:if test="$displaymode='edit'">
		<xsl:variable name="currentEntity">
			<xsl:value-of select="//entity"/>
		</xsl:variable>
    
		<xsl:variable name="currentFTType">
			<xsl:value-of select="//ft_type"/>
		</xsl:variable>
 
		<script>
			dojo.ready(function(){
				misys._config = misys._config || {};
				dojo.mixin(misys._config,  {
					counterpartyAttached : <xsl:value-of select="count($existing-accounts)"/>
				});
			});
		</script>
     
		<button dojoType="dijit.form.Button" type="button">
			<xsl:attribute name="id"><xsl:value-of select="$prefix"/>AccountOpenDialog</xsl:attribute>
			<xsl:attribute name="onclick">fncOpenAddAccountPopup('<xsl:value-of select="$prefix"/>', 'FUNDING_ACCT_SWEEPING');</xsl:attribute><!-- CHANGE PARAMETER FOR THE ACCOUNT SERVICE -->
			<xsl:value-of select="localization:getGTPString($language, 'XSL_SP_ACC_ACCT_LABEL')"/>
		</button>
     
		<!-- Holder div for hidden fields, created when an item is added -->
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$prefix"/>account_fields</xsl:attribute>
		</div>
     
		<xsl:call-template name="addAccountPopup">
			<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
		</xsl:call-template>
     
	</xsl:if>
  </xsl:template>
  
  <xsl:template name="accounts-table">
	<xsl:param name="max-attachments"/>
	<xsl:param name="existing-accounts"/>
	<xsl:param name="table-caption"/>
	<xsl:param name="table-summary"/>
	<xsl:param name="table-thead"/>
	<xsl:param name="prefix"/>
	<xsl:param name="optionvalue"/>
	<xsl:param name="empty-table-notice"/>
	<xsl:param name="delete-attachments-notice"/>
	<xsl:param name="bank-abbv" />
	<xsl:param name="hasEntities"/>
  
	<table border="0" cellpadding="0" cellspacing="0" class="attachments">
		<xsl:if test="count($existing-accounts) = 0">
			<xsl:attribute name="style">display:none;</xsl:attribute>
		</xsl:if>
		<xsl:attribute name="id"><xsl:value-of select="$prefix"/>account-master-table</xsl:attribute>
		<xsl:attribute name="summary"><xsl:value-of select="localization:getGTPString($language, $table-summary)"/></xsl:attribute>
		<caption style="display:none"><xsl:value-of select="localization:getGTPString($language, $table-caption)"/> <xsl:if test="$max-attachments!='-1'">(<xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_MAX')"/> <xsl:value-of select="$max-attachments"/>)</xsl:if></caption>
		<thead>
			<tr>
				<xsl:copy-of select="$table-thead"/>
				<xsl:if test="$displaymode='edit'">
					<th class="table-buttons"/>
				</xsl:if>
			</tr>
		</thead>
		<tbody>
			<xsl:choose>
				<xsl:when test="count($existing-accounts) = 0"><tr style="display:none;"><td/><td/><td/><td/><td/></tr></xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="$existing-accounts">
						<!-- 
						Set a variable to hold the item ID 
						-->
						<xsl:variable name="attachment-id">
							<xsl:value-of select="sweep_account_id"/>
						</xsl:variable>

						<!-- Set the row -->
						<tr class="existing-attachment">
							<xsl:attribute name="id"><xsl:value-of select="$prefix"/>account_row_<xsl:value-of select="$attachment-id"/></xsl:attribute>
								<xsl:call-template name="account-table-row">
									<xsl:with-param name="prefix" select="$prefix"></xsl:with-param>
								</xsl:call-template>
							<xsl:if test="$displaymode='edit'">
								<td>
									<button dojoType="dijit.form.Button" type="button" class="noborder">
										<xsl:attribute name="onclick">misys.editTransactionAddon('account', <xsl:value-of select="$attachment-id"/>);</xsl:attribute>
										<img>
											<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($editImage)"/></xsl:attribute>
												<xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
										</img>
									</button>
						
									<div dojoType="dijit.form.DropDownButton" class="noborder">
										<xsl:attribute name="label"><![CDATA[<img src="]]><xsl:value-of select="$contextPath"/>/<![CDATA[content/images/delete.png" title="]]><xsl:value-of select="localization:getGTPString($language, 'XSL_TITLE_HELP_DELETE')"/><![CDATA["/>]]></xsl:attribute>
						
										<span/>
										<div dojoType="dijit.TooltipDialog">
											<xsl:attribute name="execute">misys.deleteTransactionAddon('account', <xsl:value-of select="$attachment-id"/>)</xsl:attribute>
											<xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_TITLE_ATTACHMENT_DELETE')"/></xsl:attribute>
											<p><xsl:value-of select="localization:getGTPString($language, $delete-attachments-notice)"/></p>
											<button dojoType="dijit.form.Button" type="submit"><xsl:value-of select="localization:getGTPString($language, 'XSL_TITLE_ATTACHMENT_DELETE')"/></button>
										</div>
									</div>
								</td>
							</xsl:if>
						</tr>
					</xsl:for-each>
				</xsl:otherwise>
  			</xsl:choose>
		</tbody>
	</table>

	<!-- Disclaimer -->
	<p class="empty-list-notice">
		<xsl:attribute name="id"><xsl:value-of select="$prefix"/>-account-notice</xsl:attribute>
		<xsl:if test="count($existing-accounts)!=0">
			<xsl:attribute name="style">display:none</xsl:attribute>
		</xsl:if>
		<strong><xsl:value-of select="localization:getGTPString($language, $empty-table-notice)"/><xsl:if test="$max-attachments!=-1 and $displaymode='edit'">(<xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_MAX')"/> <xsl:value-of select="$max-attachments"/>)</xsl:if></strong>
	</p>
  </xsl:template>
  
  <!-- Template used to add static data to account tables -->
  <xsl:template name="account-table-row">
  	<xsl:param name="prefix"/>
	<td><xsl:value-of select="account_no"/></td>
	<td><xsl:value-of select="min_transfer_cur_code"/>&nbsp;<xsl:value-of select="min_transfer_amount"/></td>
	<td><xsl:value-of select="keep_balance_cur_code"/>&nbsp;<xsl:value-of select="keep_balance_amount"/></td>
  </xsl:template>
  
  <xsl:template name="addAccountPopup">
  	<xsl:param name="prefix"/>
	<div class="widgetContainer">
 	<xsl:call-template name="dialog">
 		<xsl:with-param name="id"><xsl:value-of select="$prefix"/>accountDialog</xsl:with-param>
    	<xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACCOUNT_DIALOG_TITLE')" /></xsl:with-param>
	    <xsl:with-param name="content">
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_SP_ACCT_LABEL</xsl:with-param>
				<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_acct_no_send</xsl:with-param>
				<xsl:with-param name="maxsize">34</xsl:with-param>
				<xsl:with-param name="button-type">account</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="disabled">Y</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_SP_MIN_TRANSFER_AMT</xsl:with-param>
				<xsl:with-param name="product-code"><xsl:value-of select="$prefix"/>_min_transfer_no_send</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="show-button">N</xsl:with-param>
				<xsl:with-param name="get-data-action">GetCashStaticData</xsl:with-param>
				<xsl:with-param name="user-action">Test</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_SP_KEEPING_BALANCE</xsl:with-param>
				<xsl:with-param name="product-code"><xsl:value-of select="$prefix"/>_keep_balance_no_send</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="show-button">N</xsl:with-param>
				<xsl:with-param name="get-data-action">GetCashStaticData</xsl:with-param>
				<xsl:with-param name="user-action">Test</xsl:with-param>
			</xsl:call-template>
	    </xsl:with-param>
	    <xsl:with-param name="buttons">
	    	<xsl:call-template name="row-wrapper">
				<xsl:with-param name="content">
					<xsl:call-template name="button-wrapper">
						<xsl:with-param name="label">ACTION_USER_ADD</xsl:with-param>
						<xsl:with-param name="onclick">fncAddAccount('<xsl:value-of select="$prefix"/>');</xsl:with-param>
						<xsl:with-param name="show-text-label">Y</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="button-wrapper">
						<xsl:with-param name="label">ACTION_USER_CANCEL</xsl:with-param>
						<xsl:with-param name="onclick">fncCancelAddAccount('<xsl:value-of select="$prefix"/>');</xsl:with-param>
						<xsl:with-param name="show-text-label">Y</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
	    </xsl:with-param>
 	</xsl:call-template>
 	</div>
  </xsl:template>
</xsl:stylesheet>