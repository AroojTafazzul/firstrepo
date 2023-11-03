<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

Advance Payments (FA) Form, Bank Side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      04/04/11
author:    Ramesh M
email:     ramesh.mandala@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
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
  <xsl:param name="product-code">FA</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/FactoringScreen</xsl:param>

  <!-- Global Imports. -->
  <xsl:include href="common/bank_common.xsl" />
  <!-- <xsl:include href="../../core/xsl/common/bank_common.xsl" /> -->
  <!-- <xsl:include href="../../xsl/report/report.xsl"/>  -->
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="fa_tnx_record"/>
  </xsl:template>
 
 <!-- 
   FA TNX FORM TEMPLATE.
  -->
  <xsl:template match="fa_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>

   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Display common reporting area -->
    <xsl:call-template name="bank-reporting-area"/>
    
   
      <!-- Link to display transaction contents (transaction hidden by default) -->
      <xsl:call-template name="transaction-details-link"/>
     
      <div id="transactionDetails">
       <xsl:call-template name="form-wrapper">
        <xsl:with-param name="name" select="$main-form-name"/>
        <xsl:with-param name="validating">Y</xsl:with-param>
        <xsl:with-param name="content">
         <!-- Disclaimer Notice -->
         <xsl:call-template name="disclaimer"/>
        
         <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
         <xsl:call-template name="hidden-fields"/>
         <xsl:call-template name="general-details"/>
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
   <xsl:with-param name="binding">misys.binding.bank.report_fa</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="show-type">N</xsl:with-param>
   <xsl:with-param name="override-product-code">fa</xsl:with-param>
  </xsl:call-template>
  <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">applicant_reference</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="applicant_reference"/></xsl:with-param>
   </xsl:call-template>
 </xsl:template>
 
 <!-- 
  FA General Details
  -->
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content"> 
      <!--  System ID. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
    <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
    <xsl:with-param name="value" select="ref_id" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>


    <!--  Application date. -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
     <xsl:with-param name="id">appl_date_view</xsl:with-param>
     <xsl:with-param name="value" select="appl_date" />
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>  
   
   
    <!--  Entity. -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">ENTITY_LABEL</xsl:with-param>
	 <xsl:with-param name="id">general_entity_view</xsl:with-param>
	  <xsl:with-param name="value" select="entity" />
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    
    <!--  Factor Pro Client Code -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_FACTOR_PRO_CLIENT_CODE</xsl:with-param>
     <xsl:with-param name="id">client_code_view</xsl:with-param>
     <xsl:with-param name="value" select='concat(client_code, " ", short_name)' />
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>    
    
   <!--  Factor Pro Account Type. -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_FACTOR_PRO_ACCOUNT_TYPE</xsl:with-param>
     <xsl:with-param name="id">account_type_view</xsl:with-param>
     <xsl:with-param name="value" select='concat(account_type, " ", account_type_des)' />
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>    
    
   
   <!--  Factor Pro Advance Currency. -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_FACTOR_PRO_ADVANCE_CURRENCY</xsl:with-param>
     <xsl:with-param name="id">adv_currency_view</xsl:with-param>
     <xsl:with-param name="value" select='concat(adv_currency, " ", adv_currency_name)' />
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template> 
    
   <!--  Factor Pro Advance Currency. -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_FACTOR_PRO_DRAWDOWN_AMOUNT</xsl:with-param>
     <xsl:with-param name="id">amt_avail_for_adv_payment_view</xsl:with-param>
     <xsl:with-param name="value" select="amt_avail_for_adv_payment" />
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template> 
    <xsl:if test="$displaymode='view'">
 	 <div style="text-align:center;font-weight:bold;">(<xsl:value-of select="localization:getGTPString($language, 'PROCESSING_DATE_MSG')"/><xsl:text>  </xsl:text><xsl:value-of select="account_type_info/client_act_infos/processing_date"/>)</div>
   </xsl:if>
   
   <!--  Factor Pro Latest Available Amount. -->
     <xsl:call-template name="input-field">
	   <xsl:with-param name="label">XSL_FACTOR_PRO_LATEST_AVAIL_AMOUNT</xsl:with-param>
	   <xsl:with-param name="name">latest_avail_amount</xsl:with-param>
	   <xsl:with-param name="size">20</xsl:with-param>
	   <xsl:with-param name="maxsize">34</xsl:with-param>
	   <xsl:with-param name="button-type">factorProRetrieve</xsl:with-param>	   
    </xsl:call-template>  
   
       <xsl:call-template name="multichoice-field">
     	<xsl:with-param name="type">checkbox</xsl:with-param>
	    <xsl:with-param name="label">XSL_REQUEST_MAX_AMOUNT</xsl:with-param>
	    <xsl:with-param name="name">request_max_amt</xsl:with-param>
	    <xsl:with-param name="checked"><xsl:if test="request_max_amt[. = 'Y']">Y</xsl:if></xsl:with-param>
	   </xsl:call-template>		 
	       <!-- FA Currency and Amount -->
      <xsl:call-template name="currency-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_FA_AMT_LABEL</xsl:with-param>
		<xsl:with-param name="product-code">fa</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="show-button">N</xsl:with-param>
      </xsl:call-template>   
      <div style="text-align:center;font-weight:bold;"><xsl:value-of select="localization:getGTPString($language, 'FACTORING_CLAUSE')"/></div>    
   </xsl:with-param>
   
  </xsl:call-template>
  
 </xsl:template>
 
 <!-- 
  FA Amount Details
  -->
 <xsl:template name="amt-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="currency-field">
     <xsl:with-param name="label">XSL_AMOUNTDETAILS_GTEE_AMT_LABEL</xsl:with-param>
     <xsl:with-param name="product-code">fa</xsl:with-param>
    </xsl:call-template> 
    </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- 
  FA Bank Details
  -->
 <xsl:template name="bank-details">
  <xsl:call-template name="tabgroup-wrapper">
   <xsl:with-param name="tabgroup-label">XSL_HEADER_BANK_DETAILS</xsl:with-param>
   
   <!-- Tab 1_0 - Issuing Bank  -->
   <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_ISSUING_BANK</xsl:with-param>
   <xsl:with-param name="tab0-content"> 
    <xsl:apply-templates select="issuing_bank">
     <xsl:with-param name="prefix" select="'issuing_bank'"/>
    </xsl:apply-templates>
   </xsl:with-param>
   
   <!-- Tab 1_1 - Advising Bank  -->
   <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_ADVISING_BANK</xsl:with-param>
   <xsl:with-param name="tab1-content">
    <!-- Form #5 : Documents Required Details -->
    <xsl:apply-templates select="advising_bank">
     <xsl:with-param name="prefix" select="'advising_bank'"/>
    </xsl:apply-templates>
   </xsl:with-param>
   
   <!-- Tab 1_2 - Confirming Bank  -->
   <xsl:with-param name="tab2-label">XSL_BANKDETAILS_TAB_CONFIRMING_BANK</xsl:with-param>
   <xsl:with-param name="tab2-content">
    <!-- Form #5 : Documents Required Details -->
    <xsl:apply-templates select="confirming_bank">
     <xsl:with-param name="prefix" select="'confirming_bank'"/>
    </xsl:apply-templates>
   </xsl:with-param>
  </xsl:call-template> 
 </xsl:template>
 
 <!--
  Remitting or collecting bank  
 -->
 <xsl:template match="advising_bank | confirming_bank">
  <xsl:param name="prefix"/>

   <!-- Name. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
    <xsl:with-param name="value" select="name"/>
    <xsl:with-param name="button-type"><xsl:value-of select="$prefix"/></xsl:with-param>
    <xsl:with-param name="override-form-name">form_<xsl:value-of select="$prefix"/></xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
   </xsl:call-template>   
 </xsl:template>
 
 <!-- 
  -->
 <xsl:template match="issuing_bank">
  <xsl:param name="prefix"/>

  <xsl:call-template name="select-field">
   <xsl:with-param name="label">XSL_BANKDETAILS_TYPE_LABEL</xsl:with-param>
   <xsl:with-param name="name">issuing_bank_type_code</xsl:with-param>
   <xsl:with-param name="options">
    <xsl:choose>
     <xsl:when test="$displaymode='edit'">
      <option value="01">
	   <xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_RECIPIENT')"/>
	  </option>
	  <option value="02">
	   <xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_OTHER')"/>
	  </option>
     </xsl:when>
     <xsl:otherwise>
      <xsl:choose>
	   <xsl:when test="contains(issuing_bank_type_code,'01')"><xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_RECIPIENT')"/></xsl:when>
	   <xsl:when test="contains(issuing_bank_type_code,'02')"><xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_OTHER')"/></xsl:when>
	  </xsl:choose>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:with-param>
  </xsl:call-template> 

   <!-- Name. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
    <xsl:with-param name="value" select="name"/>
    <xsl:with-param name="button-type"><xsl:value-of select="$prefix"/></xsl:with-param>
    <xsl:with-param name="override-form-name">form_<xsl:value-of select="$prefix"/></xsl:with-param>
    <xsl:with-param name="readonly">Y</xsl:with-param>
   </xsl:call-template>
   

 </xsl:template>
 </xsl:stylesheet>