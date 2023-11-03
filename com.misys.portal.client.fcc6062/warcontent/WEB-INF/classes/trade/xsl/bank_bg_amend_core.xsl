<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Bankers Guarantee (BG) Amend Form, Bank Side.

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
  <xsl:param name="product-code">BG</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
  <xsl:param name="Goods_description"/>
  <xsl:param name="Documents_required"/>
  <xsl:param name="Additional_Conditions"/>
  <xsl:param name="Amendment_Narrative"/>
  <xsl:param name="Discrepant_Details"/>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" />
  <xsl:include href="../../core/xsl/common/amend_common.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="bg_tnx_record"/>
  </xsl:template>
 
 <!-- 
   BG TNX FORM TEMPLATE.
  -->
  <xsl:template match="bg_tnx_record">
   <!-- Loading message  -->
   <xsl:call-template name="loading-message"/>

   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Display common reporting area -->
    <xsl:call-template name="bank-reporting-area"/>

    <!-- Attachments -->
    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
     <xsl:call-template name="attachments-file-dojo">
       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
       <xsl:with-param name="title-size">35</xsl:with-param>
      </xsl:call-template> 
	</xsl:if>
    
    <!-- Link to display transaction contents -->
    <xsl:call-template name="transaction-details-link">
     <xsl:with-param name="show-transaction">Y</xsl:with-param>
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
       <xsl:call-template name="general-details"/>
       <xsl:call-template name="bg-amend-amt-details"/>
        <xsl:call-template name="amend-renewal-details"/>
       <xsl:call-template name="amend-narrative"/>
        <xsl:call-template name="bank-instructions">
        <xsl:with-param name="send-mode-label">XSL_INSTRUCTIONS_AMD_ADV_SEND_MODE_LABEL</xsl:with-param>
       <xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
       </xsl:call-template>
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
   <xsl:with-param name="binding">misys.binding.bank.amend_bg</xsl:with-param>
  </xsl:call-template>
 </xsl:template>

 
 
 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="show-type">N</xsl:with-param>
   <xsl:with-param name="additional-fields">
    <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_name</xsl:with-param>
   </xsl:call-template>
 <!--   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
   </xsl:call-template> -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">recipient_bank_abbv_name</xsl:with-param>
    <xsl:with-param name="value" select="recipient_bank/abbv_name"/>
   </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!--
  BG General Details 
  -->
 <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="button-type">summary-details</xsl:with-param>
    <xsl:with-param name="content">
     <div id="generaldetails">
      <!-- Hidden fields. -->
     <!--  <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">ref_id</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">appl_date</xsl:with-param>
      </xsl:call-template> -->

      <!--  System ID. -->
     <!--  <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
       <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="ref_id" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
       <xsl:with-param name="id">general_bo_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="bo_ref_id" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">bo_ref_id</xsl:with-param>
      </xsl:call-template> -->
      
     <!--  Start Date. -->
    <!--  <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_START_DATE_TYPE</xsl:with-param>
       <xsl:with-param name="name">iss_date_type_code</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:choose>
         <xsl:when test="iss_date_type_code[. = '01']">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ISSUANCE')"/>
         </xsl:when>
         <xsl:when test="iss_date_type_code[. = '02']">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_CONTRACT_SIGN')"/>
         </xsl:when>
         <xsl:when test="iss_date_type_code[. = '03']">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ADV_PAYMT')"/>
         </xsl:when>
         BEGIN NXBP Specific
         <xsl:when test="iss_date_type_code[. = '50']">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_COVER_PAYMT')"/>
         </xsl:when>
         END NXBP Specific
         <xsl:when test="iss_date_type_code[. = '99']">
          <xsl:value-of select="iss_date_type_details"/>
         </xsl:when>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template> -->
     
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
      <xsl:with-param name="id">general_iss_date_view</xsl:with-param>
      <xsl:with-param name="value" select="iss_date" />
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">iss_date</xsl:with-param>
     </xsl:call-template>
     
     <!-- Expiry Date -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_ORG_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="id">expiry_date_view</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="org_previous_file/bg_tnx_record/exp_date_type_code[. = '02']">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_FIXED')"/>
        </xsl:when>
        <xsl:when test="org_previous_file/bg_tnx_record/exp_date_type_code[. = '03']">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_PROJECTED')"/>
        </xsl:when>
        <xsl:when test="org_previous_file/bg_tnx_record/exp_date_type_code[. = '01']">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_NONE')"/>
        </xsl:when>
        <!-- BEGIN NXBP Specific -->
        <xsl:when test="org_exp_date_type_code[. = '50']">
         <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_WITH_CADUCITY')"/>
        </xsl:when>
        <xsl:when test="org_exp_date_type_code[. = '51']">
         <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_WITHOUT_CADUCITY')"/>
        </xsl:when>
        <xsl:when test="org_exp_date_type_code[. = '52']">
         <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_THEORETICAL')"/>
        </xsl:when>
        <xsl:when test="org_exp_date_type_code[. = '99']">
         <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_OTHER')"/>
        </xsl:when>             
        <!-- END NXBP Specific -->
       </xsl:choose>
       <xsl:if test="org_previous_file/bg_tnx_record/exp_date[.!='']">
       (<xsl:value-of select="org_previous_file/bg_tnx_record/exp_date"/>)
       </xsl:if>
      </xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     
     <xsl:if test="org_exp_date[.!='']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_ORG_EXPIRY_DATE</xsl:with-param>
       <xsl:with-param name="value" select="org_exp_date"/>
      </xsl:call-template>
     </xsl:if>

	<xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="name">exp_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
     </xsl:call-template>
	
     <!-- <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_NEW_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="name">exp_date_type_code</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:call-template name="bank-bg-exp-dates"/>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">exp_date</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="substring(localization:getGTPString($language, 'DATE_FORMAT'),1,2)='dd'">
          <xsl:if test="number(concat(substring(amd_date,7,4),substring(amd_date,4,2),substring(amd_date,1,2))) &lt; number(concat(substring(exp_date,7,4),substring(exp_date,4,2),substring(exp_date,1,2))) or exp_date_type_code[.!='50']">
            <xsl:value-of select="exp_date"/>
          </xsl:if>
        </xsl:when>
        <xsl:when test="substring(localization:getGTPString($language, 'DATE_FORMAT'),1,2)='MM'">
          <xsl:if test="number(concat(substring(amd_date,7,4),substring(amd_date,1,2),substring(amd_date,4,2))) &lt; number(concat(substring(exp_date,7,4),substring(exp_date,1,2),substring(exp_date,4,2))) or exp_date_type_code[.!='50']">
            <xsl:value-of select="exp_date"/>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise/>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_exp_date</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_exp_date_type_code</xsl:with-param>
     </xsl:call-template> -->
    
     <!-- Amendment Date -->
    <!--  <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>
      <xsl:with-param name="name">amd_date</xsl:with-param>
      <xsl:with-param name="value" select="amd_date" />
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param> 
      </xsl:call-template> -->
     <!-- <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">amd_no</xsl:with-param>
     </xsl:call-template> -->
      </div>
      
		<xsl:call-template name="fieldset-wrapper">
	     <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
	     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	     <xsl:with-param name="button-type"></xsl:with-param>
	     <xsl:with-param name="content">
	      <xsl:call-template name="address">
	       <xsl:with-param name="prefix">beneficiary</xsl:with-param>
	       <xsl:with-param name="show-reference">Y</xsl:with-param>
	       <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
	        <xsl:with-param name="show-country">Y</xsl:with-param>
	       <xsl:with-param name="button-content">
	          <xsl:call-template name="get-button">
		        <xsl:with-param name="button-type">beneficiary</xsl:with-param>
		        <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
		        <xsl:with-param name="non-dijit-button">Y</xsl:with-param>
		      </xsl:call-template>
	       </xsl:with-param>
	      </xsl:call-template>
	        </xsl:with-param>
	    </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
 </xsl:template>

 
 <!-- XSL_HEADER_AMOUNT_DETAILS
   -->
 <xsl:template name="bg-amend-amt-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_GTEE_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">bg</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name">org_bg_amt</xsl:with-param>
      <xsl:with-param name="override-amt-value"><xsl:value-of select="org_previous_file/bg_tnx_record/bg_amt"/></xsl:with-param>
     </xsl:call-template>
     <div>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">bg_cur_code</xsl:with-param>
      </xsl:call-template>
     </div>
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_INC_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">bg</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name">inc_amt</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_DEC_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">bg</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name">dec_amt</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_GTEE_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">bg</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
       <xsl:with-param name="amt-readonly">Y</xsl:with-param>
     </xsl:call-template>

     <xsl:if test="org_previous_file/bg_tnx_record/bg_amt_2[.!='']">
       <xsl:call-template name="currency-field">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_OTHER_GTEE_AMT_LABEL</xsl:with-param>
        <xsl:with-param name="product-code">bg</xsl:with-param>
        <xsl:with-param name="override-currency-name">bg_cur_code_2</xsl:with-param>
        <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
        <xsl:with-param name="override-amt-name">org_bg_amt_2</xsl:with-param>
        <xsl:with-param name="override-amt-value"><xsl:value-of select="org_previous_file/bg_tnx_record/bg_amt_2"/></xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="currency-field">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_INC_AMT_LABEL</xsl:with-param>
        <xsl:with-param name="product-code">bg</xsl:with-param>
        <xsl:with-param name="override-currency-name">bg_cur_code_2</xsl:with-param>
        <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
        <xsl:with-param name="override-amt-name">inc_amt_2</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="currency-field">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_DEC_AMT_LABEL</xsl:with-param>
        <xsl:with-param name="product-code">bg</xsl:with-param>
        <xsl:with-param name="override-currency-name">bg_cur_code_2</xsl:with-param>
        <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
        <xsl:with-param name="override-amt-name">dec_amt_2</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="currency-field">
        <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_OTHER_GTEE_AMT_LABEL</xsl:with-param>
        <xsl:with-param name="product-code">bg</xsl:with-param>
        <xsl:with-param name="override-currency-name">bg_cur_code_2</xsl:with-param>
        <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
        <xsl:with-param name="override-amt-name">bg_amt_2</xsl:with-param>
       </xsl:call-template>
     </xsl:if>
     <xsl:if test="org_previous_file/bg_tnx_record/bg_amt_3[.!='']">
      <xsl:call-template name="currency-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_OTHER_GTEE_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="product-code">bg</xsl:with-param>
       <xsl:with-param name="override-currency-name">bg_cur_code_3</xsl:with-param>
       <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
       <xsl:with-param name="override-amt-name">org_bg_amt_3</xsl:with-param>
       <xsl:with-param name="override-amt-value"><xsl:value-of select="org_previous_file/bg_tnx_record/bg_amt_3"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="currency-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_INC_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="override-currency-name">bg_cur_code_3</xsl:with-param>
       <xsl:with-param name="product-code">bg</xsl:with-param>
       <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
       <xsl:with-param name="override-amt-name">inc_amt_3</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="currency-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_DEC_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="override-currency-name">bg_cur_code_3</xsl:with-param>
       <xsl:with-param name="product-code">bg</xsl:with-param>
       <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
       <xsl:with-param name="override-amt-name">dec_amt_3</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="currency-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_OTHER_GTEE_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="override-currency-name">bg_cur_code_3</xsl:with-param>
       <xsl:with-param name="product-code">bg</xsl:with-param>
       <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
       <xsl:with-param name="override-amt-name">bg_amt_3</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:if test="org_previous_file/bg_tnx_record/bg_amt_4[.!='']">
      <xsl:call-template name="currency-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_OTHER_GTEE_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="product-code">bg</xsl:with-param>
       <xsl:with-param name="override-currency-name">bg_cur_code_4</xsl:with-param>
       <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
       <xsl:with-param name="override-amt-name">org_bg_amt_4</xsl:with-param>
       <xsl:with-param name="override-amt-value"><xsl:value-of select="org_previous_file/bg_tnx_record/bg_amt_3"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="currency-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_INC_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="override-currency-name">bg_cur_code_4</xsl:with-param>
       <xsl:with-param name="product-code">bg</xsl:with-param>
       <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
       <xsl:with-param name="override-amt-name">inc_amt_3</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="currency-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_DEC_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="override-currency-name">bg_cur_code_4</xsl:with-param>
       <xsl:with-param name="product-code">bg</xsl:with-param>
       <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
       <xsl:with-param name="override-amt-name">dec_amt_3</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="currency-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_OTHER_GTEE_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="override-currency-name">bg_cur_code_4</xsl:with-param>
       <xsl:with-param name="product-code">bg</xsl:with-param>
       <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
       <xsl:with-param name="override-amt-name">bg_amt_3</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
       <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="name">bg_liab_amt</xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
       <xsl:with-param name="value">
       <xsl:value-of select="bg_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="bg_liab_amt"></xsl:value-of>
	   </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">bg_liab_amt</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="bg_liab_amt"/></xsl:with-param>  
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_bg_liab_amt</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="bg_liab_amt"/></xsl:with-param>  
      </xsl:call-template>
     <!-- <xsl:call-template name="checkbox-field">
      <xsl:with-param name="name">bg_release_flag</xsl:with-param>
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_GTEE_RELEASE</xsl:with-param>
     </xsl:call-template>   -->
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
 
 <!-- 
  Bank Instructions
  -->
  <xsl:template name="bank-instructions">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_INSTRUCTIONS</xsl:with-param>
   <xsl:with-param name="content">
    
    <xsl:if test="master_principal_act_no[.!='']">
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
      <xsl:with-param name="name">master_principal_act_no</xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">principal_act_no</xsl:with-param>
      <xsl:with-param name="value" select="master_principal_act_no"/>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
      <xsl:with-param name="name">master_fee_act_no</xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">fee_act_no</xsl:with-param>
      <xsl:with-param name="value" select="master_fee_act_no"/>
     </xsl:call-template>
    </xsl:if>
    <xsl:call-template name="big-textarea-wrapper">
     <xsl:with-param name="id">free_format_text</xsl:with-param>
     <xsl:with-param name="label">XSL_INSTRUCTIONS_OTHER_INFORMATION</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="textarea-field">
       <xsl:with-param name="name">free_format_text</xsl:with-param>
       <xsl:with-param name="swift-validate">N</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="disabled">Y</xsl:with-param>
       <xsl:with-param name="rows">8</xsl:with-param>
       <xsl:with-param name="cols">65</xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template> 
 </xsl:template>
 
 <!-- 
  BG Exp Dates options
  -->
  <xsl:template name="bank-bg-exp-dates">
  <xsl:choose>
   <xsl:when test="$displaymode='edit'">
    <option value=""/>
    <!-- BEGIN NXBP Specific -->
    <option value="50">
     <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_WITH_CADUCITY')"/>
    </option>
    <option value="51">
     <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_WITHOUT_CADUCITY')"/>
    </option>
    <option value="52">
     <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_THEORETICAL')"/>
    </option>
    <option value="99">
     <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_OTHER')"/>
    </option>
   </xsl:when>
   <xsl:otherwise>
    <xsl:choose>
     <xsl:when test="exp_date_type_code[. = '50']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_WITH_CADUCITY')"/></xsl:when>
     <xsl:when test="exp_date_type_code[. = '51']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_WITHOUT_CADUCITY')"/></xsl:when>
     <xsl:when test="exp_date_type_code[. = '52']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_THEORETICAL')"/></xsl:when>
     <xsl:when test="exp_date_type_code[. = '99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_OTHER')"/></xsl:when>
     <xsl:when test="exp_date_type_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_NONE')"/></xsl:when>
     <xsl:when test="exp_date_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_FIXED')"/></xsl:when>
     <xsl:when test="exp_date_type_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_PROJECTED')"/></xsl:when>
    </xsl:choose>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
</xsl:stylesheet>