<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Financing Request (TF) Form, Bank Side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      07/03/08
base version: 1.5

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
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
    exclude-result-prefixes="localization utils">
    
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">TF</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>

  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" />
  <xsl:include href="../../core/xsl/common/tf_common.xsl" />
  <xsl:include href="../../core/xsl/common/bank_fx_common.xsl" />
  <xsl:include href="../../core/xsl/common/ls_common.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="tf_tnx_record"/>
  </xsl:template>
 
 <!-- 
   TF TNX FORM TEMPLATE.
  -->
  <xsl:template match="tf_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>

   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Display common reporting area -->
    <xsl:call-template name="bank-reporting-area"/>
    
    <!-- Attachments -->
    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
	<xsl:choose>
			<xsl:when test ="sub_tnx_stat_code[.='17']">
				     <xsl:call-template name="attachments-file-dojo">
				       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
				       <xsl:with-param name="title-size">35</xsl:with-param>
				      </xsl:call-template> 
			</xsl:when>
			<xsl:otherwise>
				     <xsl:call-template name="attachments-file-dojo">
				       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
				       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02' or type = '01']"/>
				       <xsl:with-param name="title-size">35</xsl:with-param>
				      </xsl:call-template> 
			</xsl:otherwise>
		</xsl:choose>

	</xsl:if>
    
    <!--
    The <xsl:choose> below was present in v3, handling customer-specific requests to enable transaction editing. 
    The link should always be shown by default in v4, but the logic is kept as a comment, for reference 
    -->
    <!-- 
    <xsl:choose>
     <xsl:when test="tnx_type_code[.='15' or .='13']">
     -->
    
     <!-- Link to display transaction contents -->
     <xsl:call-template name="transaction-details-link">
		<xsl:with-param name="show-transaction">
			<xsl:choose>
				<xsl:when test="tnx_type_code[.!='01'] and $displaymode='edit' or (tnx_type_code[.='01'] and $displaymode = 'edit')">N</xsl:when>
					<xsl:otherwise>Y</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="show-hyperlink">
			<xsl:choose>
				<xsl:when test="(tnx_type_code[.='01'] or tnx_type_code[.='03']) and defaultresource:getResource('ENABLE_EDITING_INIT_AMEND_TNX_DETAILS_BY_BANK')='true'">Y</xsl:when>
				<xsl:when test="tnx_type_code[.='13'] and defaultresource:getResource('ENABLE_EDITING_MSG_TNX_DETAILS_BY_BANK')='true'">Y</xsl:when>
				<xsl:when test="tnx_type_code[.='15']">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
	 </xsl:call-template>
     
     <div id="transactionDetails">
      <xsl:call-template name="form-wrapper">
       <xsl:with-param name="name" select="$main-form-name"/>
       <xsl:with-param name="validating">Y</xsl:with-param>
       <xsl:with-param name="content">
        <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
        
        <!-- Disclaimer Notice -->
        <xsl:call-template name="disclaimer"/>
        
        <xsl:call-template name="hidden-fields"/>
       
        <!-- Initiation From -->
        <xsl:call-template name="general-details"/>
        <xsl:call-template name="amt-details"/>
       
        
		<xsl:if test="fx_rates_type and fx_rates_type[.!='']">
        <xsl:call-template name="bank-fx-template"/>
        </xsl:if>
         <xsl:if test="securitycheck:hasPermission($rundata,'tradeadmin_ls_access') = 'true' and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true'">
			<xsl:call-template name="linked-ls-declaration"/>
	 		<xsl:call-template name="linked-licenses"/>
	   </xsl:if>

        <!--  Additional Details -->  
        <xsl:call-template name="fieldset-wrapper">
         <xsl:with-param name="legend">XSL_HEADER_ADDITIONAL_DETAILS</xsl:with-param>
         <xsl:with-param name="content">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="id">goods_desc</xsl:with-param>
            <xsl:with-param name="label">XSL_LABEL_ADDITIONAL_DETAILS</xsl:with-param>
           <xsl:with-param name="type">textarea</xsl:with-param>
           <xsl:with-param name="required">Y</xsl:with-param>
           <xsl:with-param name="content">
            <xsl:call-template name="textarea-field">
             <xsl:with-param name="name">goods_desc</xsl:with-param>
             <xsl:with-param name="rows">12</xsl:with-param>
             <xsl:with-param name="required">Y</xsl:with-param>
            </xsl:call-template>
           </xsl:with-param>
          </xsl:call-template>
         </xsl:with-param>
        </xsl:call-template>
        
       </xsl:with-param>
      </xsl:call-template>
     </div>
    <!-- </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="form-wrapper">
      <xsl:with-param name="name" select="$main-form-name"/>
      <xsl:with-param name="validating">Y</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="common-hidden-fields">
        <xsl:with-param name="show-type">N</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:otherwise>
    </xsl:choose>  -->
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
   <xsl:with-param name="binding">misys.binding.bank.report_tf</xsl:with-param>
   <xsl:with-param name="override-help-access-key">
	   <xsl:choose>
	   	<xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
	   	<xsl:otherwise>PR_01</xsl:otherwise>
	   </xsl:choose>
   </xsl:with-param> 
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="show-type">N</xsl:with-param>
   <xsl:with-param name="override-product-code">tf</xsl:with-param>
  </xsl:call-template>
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">principal_act_name</xsl:with-param>
     <xsl:with-param name="value" select="''"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">principal_act_cur_code</xsl:with-param>
     <xsl:with-param name="value" select="''"/> 
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">principal_act_description</xsl:with-param>
     <xsl:with-param name="value" select="''"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">principal_act_no</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="principal_act_no"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">principal_act_pab</xsl:with-param>
     <xsl:with-param name="value" select="''"/>
    </xsl:call-template>
    
     <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_act_name</xsl:with-param>
     <xsl:with-param name="value" select="''"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_act_cur_code</xsl:with-param>
     <xsl:with-param name="value" select="''"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_act_description</xsl:with-param>
     <xsl:with-param name="value" select="''"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_act_no</xsl:with-param>
	 <xsl:with-param name="value"><xsl:value-of select="fee_act_no"/></xsl:with-param>    
	</xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_act_pab</xsl:with-param>
     <xsl:with-param name="value" select="''"/>
    </xsl:call-template>
    <xsl:if test="fx_rates_type and fx_rates_type[.!='']">
	    <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">fx_rates_type_temp</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="fx_rates_type"></xsl:value-of></xsl:with-param>
	    </xsl:call-template>
	    <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">fx_master_currency</xsl:with-param>
	     <xsl:with-param name="value"><xsl:value-of select="fx_contract_nbr_cur_code_1"></xsl:value-of></xsl:with-param>
	    </xsl:call-template>
	     <xsl:call-template name="hidden-field">
		    <xsl:with-param name="name">fx_nbr_contracts</xsl:with-param>
		    <xsl:with-param name="value"><xsl:value-of select="fx_nbr_contracts"/></xsl:with-param>
		 </xsl:call-template>
	 </xsl:if>
  </div>
 </xsl:template>
 
 <!-- 
  TF General Details
  -->
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
     <xsl:with-param name="name">iss_date</xsl:with-param>
     <xsl:with-param name="size">10</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR_DAYS</xsl:with-param>
     <xsl:with-param name="name">tenor</xsl:with-param>
     <xsl:with-param name="type">number</xsl:with-param>
     <xsl:with-param name="size">3</xsl:with-param>
     <xsl:with-param name="maxsize">3</xsl:with-param>
    <xsl:with-param name="override-constraints">{min:0,pattern: '###'}</xsl:with-param>
     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
     <xsl:with-param name="name">maturity_date</xsl:with-param>
     <xsl:with-param name="size">10</xsl:with-param>
     <xsl:with-param name="maxsize">10</xsl:with-param>
     <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_FINANCINGTYPE_LABEL</xsl:with-param>
     <xsl:with-param name="name">sub_product_code</xsl:with-param>
     <xsl:with-param name="fieldsize">medium</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="disabled">Y</xsl:with-param>
     <xsl:with-param name="options">
      <!-- <xsl:call-template name="tf-financing-types"/> -->
      <xsl:choose>
      <xsl:when test="fin_type[. = '01']">
      <xsl:call-template name="tf-import-all-financing-types"/>
      </xsl:when>
      <xsl:when test="fin_type[. = '02']">
      <xsl:call-template name="tf-export-all-financing-types"/>
      </xsl:when>
      <xsl:when test="fin_type[. = '99']">
      <xsl:call-template name="tf-general-financing-types"/>
      </xsl:when>
      </xsl:choose>
     </xsl:with-param>
     <xsl:with-param name="disabled">N</xsl:with-param>
    </xsl:call-template>
    <xsl:choose>
    <xsl:when test="sub_product_code[.='IOTHF'] or sub_product_code[.='EOTHF']">
    <xsl:call-template name="input-field">
	    <xsl:with-param name="label"></xsl:with-param>
	    <xsl:with-param name="name">sub_product_code_text</xsl:with-param>
	    <xsl:with-param name="type">text</xsl:with-param>
	    <xsl:with-param name="size">35</xsl:with-param>
	    <xsl:with-param name="maxsize">35</xsl:with-param>
	    <xsl:with-param name="fieldsize">medium</xsl:with-param>
	    <xsl:with-param name="required">Y</xsl:with-param>	    
   </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="input-field">
	    <xsl:with-param name="label"></xsl:with-param>
	    <xsl:with-param name="name">sub_product_code_text</xsl:with-param>
	    <xsl:with-param name="type">text</xsl:with-param>
	    <xsl:with-param name="size">35</xsl:with-param>
	    <xsl:with-param name="maxsize">35</xsl:with-param>
	    <xsl:with-param name="fieldsize">medium</xsl:with-param>
	    <xsl:with-param name="disabled">Y</xsl:with-param>	    
   </xsl:call-template>
   </xsl:otherwise>
    
    </xsl:choose>
     
    <!-- Client Specific Additional Fields -->
    <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_RELATED_REFERENCE</xsl:with-param>
    <xsl:with-param name="name">related_reference</xsl:with-param>
    <xsl:with-param name="type">text</xsl:with-param>
    <xsl:with-param name="size">35</xsl:with-param>
    <xsl:with-param name="maxsize">35</xsl:with-param>
    <xsl:with-param name="fieldsize">medium</xsl:with-param>
    <xsl:with-param name="required">N</xsl:with-param>
   </xsl:call-template>
    <xsl:if test="bill_amt[.!='']">
    <xsl:call-template name="currency-field">
    <xsl:with-param name="label">XSL_BILL_AMOUNT</xsl:with-param>
    <xsl:with-param name="override-amt-name">bill_amt</xsl:with-param>
    <xsl:with-param name="override-currency-name">bill_amt_cur_code</xsl:with-param>
    <xsl:with-param name="currency-readonly">Y</xsl:with-param>
    <xsl:with-param name="amt-readonly">Y</xsl:with-param>
    <xsl:with-param name="show-button">N</xsl:with-param>
  </xsl:call-template>
  <!--<xsl:call-template name="hidden-field">
    <xsl:with-param name="name">bill_amt</xsl:with-param>
    <xsl:with-param name="value" select="bill_amt"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">bill_amt_cur_code</xsl:with-param>
    <xsl:with-param name="value" select="bill_amt_cur_code"/>
   </xsl:call-template>
  --></xsl:if>
    <xsl:call-template name="row-wrapper">
     <xsl:with-param name="id">description_of_goods</xsl:with-param>
     <xsl:with-param name="label">XSL_DESCRIPTION_OF_GOODS</xsl:with-param>
     <xsl:with-param name="type">textarea</xsl:with-param>
     <xsl:with-param name="content">
     <xsl:call-template name="textarea-field">
     <xsl:with-param name="name">description_of_goods</xsl:with-param>
     <xsl:with-param name="rows">3</xsl:with-param>
     <xsl:with-param name="cols">35</xsl:with-param>
     </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
    <!-- Applicant Details -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="button-type"><xsl:if test="tnx_type_code[.='01']">applicant</xsl:if></xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="address">
       <xsl:with-param name="show-entity">
        <xsl:choose>
         <xsl:when test="entity[.='']">N</xsl:when>
         <xsl:otherwise>Y</xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="show-entity-button"><xsl:if test="tnx_type_code[.='01']">N</xsl:if></xsl:with-param>
       <xsl:with-param name="entity-required">N</xsl:with-param>
       <xsl:with-param name="prefix">applicant</xsl:with-param>
       <xsl:with-param name="show-reference">N</xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
    <!-- Financing Bank Details -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_TRANSACTIONDETAILS_FINANCING_BANK</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="content">
     	<xsl:call-template name="financing_bank">
          <xsl:with-param name="prefix" select="'issuing_bank'"/>
        </xsl:call-template>
        </xsl:with-param>
     </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <xsl:template name="financing_bank">
   <xsl:param name="prefix"/>
       
   <xsl:variable name="main-bank-name-value">
     <xsl:value-of select="//*[name()=$prefix]/name"/>
   </xsl:variable>
   
   <xsl:variable name="appl_ref">
	  <xsl:value-of select="applicant_reference"/>
   </xsl:variable>
  
  <xsl:call-template name="input-field">
	   <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_FINANCING_BANK</xsl:with-param>
	   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
	   <xsl:with-param name="value" select="$main-bank-name-value"/>
	   <xsl:with-param name="readonly">Y</xsl:with-param>
  </xsl:call-template>

   <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
           <xsl:with-param name="name">applicant_reference</xsl:with-param>
           <xsl:with-param name="value">
           <xsl:choose>
           <xsl:when test="defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'">
           <xsl:value-of select="utils:decryptApplicantReference(//*/customer_references/customer_reference[reference=$appl_ref]/reference)"/>
	  	   </xsl:when>
	  	    <xsl:otherwise>
            <xsl:value-of select="utils:decryptApplicantReference(//*/customer_references/customer_reference[reference=$appl_ref]/reference)"/>
	  	   </xsl:otherwise>
	  	   </xsl:choose>
           </xsl:with-param>
           <xsl:with-param name="readonly">Y</xsl:with-param>
    </xsl:call-template>
  
 </xsl:template>
 
 <!--
  TF Amt Details 
  -->
 <xsl:template name="amt-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="currency-field">
     <xsl:with-param name="label">XSL_AMOUNTDETAILS_FIN_AMT_LABEL</xsl:with-param>
     <xsl:with-param name="product-code">fin</xsl:with-param>
    </xsl:call-template> 
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
     <xsl:with-param name="name">fin_liab_amt</xsl:with-param>
     <xsl:with-param name="appendClass">outstanding</xsl:with-param>
     <xsl:with-param name="size">20</xsl:with-param>
     <xsl:with-param name="maxsize">15</xsl:with-param>
     <xsl:with-param name="type">amount</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="currency-value"><xsl:value-of select="//*[name()='ic_cur_code']"/></xsl:with-param>
     <xsl:with-param name="value">
      <xsl:if test="fin_liab_amt[.!='']">
       <xsl:choose>
        <xsl:when test="$displaymode='view'">
         <xsl:value-of select="fin_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="fin_liab_amt"></xsl:value-of>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="fin_liab_amt"/></xsl:otherwise>
       </xsl:choose>
      </xsl:if>
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_ELIGIBLE_PCT</xsl:with-param>
	     <xsl:with-param name="name">req_pct</xsl:with-param>
	     <xsl:with-param name="size">3</xsl:with-param>
	     <xsl:with-param name="maxsize">5</xsl:with-param>
	     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
	     <xsl:with-param name="type">percentnumber</xsl:with-param>
	   </xsl:call-template>
    <xsl:call-template name="currency-field">
      	<xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_ELIGIBLE_AMT</xsl:with-param>
      	<xsl:with-param name="product-code">req</xsl:with-param>
      	<xsl:with-param name="override-currency-value">
   			<xsl:value-of select="req_cur_code"/>
		</xsl:with-param>
		<xsl:with-param name="currency-readonly">Y</xsl:with-param>
		<xsl:with-param name="amt-readonly">Y</xsl:with-param>
		<xsl:with-param name="show-button">N</xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
</xsl:stylesheet>