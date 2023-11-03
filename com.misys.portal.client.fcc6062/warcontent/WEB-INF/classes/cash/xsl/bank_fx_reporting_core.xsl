<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Foreign Exchange (FX) Form, Bank Side.

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
  <xsl:param name="product-code">FX</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="fx_tnx_record"/>
  </xsl:template>
 
 <!-- 
   FX TNX FORM TEMPLATE.
  -->
  <xsl:template match="fx_tnx_record">
   <!-- Preloader  -->
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
      </xsl:call-template> 
	</xsl:if>
    
    <xsl:choose>
     <xsl:when test="tnx_type_code[.='15']">
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
         <xsl:call-template name="general-details"/>
         <xsl:call-template name="fx-transfer-details"/>
        </xsl:with-param>
       </xsl:call-template>
      </div>
     </xsl:when>
     <xsl:otherwise>
      <!-- If the case is Pending. -->
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
    </xsl:choose>

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
   <xsl:with-param name="binding">misys.binding.bank.report_fx</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="show-type">N</xsl:with-param>
   <xsl:with-param name="override-product-code">fx</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- 
  FX General Details
  -->
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
     <xsl:with-param name="name">ref_id</xsl:with-param>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">ref_id</xsl:with-param>
      <xsl:with-param name="name">ref_id_hidden</xsl:with-param>
     </xsl:call-template>

    <!-- Initiation From -->
    <xsl:if test="cross_references/cross_reference/type_code[.='02']">
     <xsl:variable name="parent_file" select="xmlRender:getXMLMasterNode(cross_references/cross_reference[./type_code='02']/product_code, cross_references/cross_reference[./type_code='02']/ref_id, $language)"/>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
      <xsl:with-param name="id">bo_ref_id_view</xsl:with-param>
      <xsl:with-param name="value" select="$parent_file/bo_ref_id"/>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
    </xsl:if>
    
    <!-- Cross Refs -->
    <!-- Shown in consolidated view -->
    <xsl:if test="cross_references">
     <xsl:apply-templates select="cross_references" mode="display_table_tnx"/>
    </xsl:if>
      
    <!-- Execution Date. 
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_EXECUTION_DATE</xsl:with-param>
     <xsl:with-param name="name">iss_date</xsl:with-param>
     <xsl:with-param name="size">10</xsl:with-param>
     <xsl:with-param name="maxsize">10</xsl:with-param>
     <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
    </xsl:call-template>-->
      
    <!-- Fund Transfer Currency. 
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_FT_CUR_CODE</xsl:with-param>
     <xsl:with-param name="name">input_cur_code</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="ft_cur_code"/></xsl:with-param>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>-->
    <!-- define a input cur code in the bank reporting form to fit with the client creation form and
              hence allows the javascript function checkField to run  in the two situations
    <div>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">input_cur_code</xsl:with-param>
      <xsl:with-param name="value" select="ft_cur_code"/>
     </xsl:call-template>
    </div>-->
    
    <!-- Get the ft type
    <xsl:variable name="ft_type"><xsl:value-of select="ft_type"/></xsl:variable>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_FT_TYPE</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N029', $ft_type)"/></xsl:with-param>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>-->
     
    <div class="clear"></div>
     
    <!-- Applicant Details -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="address">
       <xsl:with-param name="show-entity">
        <xsl:choose>
         <xsl:when test="entity[.='']">N</xsl:when>
         <xsl:otherwise>Y</xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="prefix">applicant</xsl:with-param>
       <xsl:with-param name="button-type">applicant</xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
  <!-- Beneficiary Details -->
  <xsl:call-template name="attachments-counterparties"/>
 </xsl:template>
 
 <!--
  FX Details 
  
  fx - prefix since template transfer-details already exists in common.xsl
  -->
 <xsl:template name="fx-transfer-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_PARTIESDETAILS_TRANSFER_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="currency-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_FX_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="product-code">fx</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
      </xsl:call-template>
    
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
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL</xsl:with-param>
      <xsl:with-param name="name">fwd_contract_no</xsl:with-param>
      <xsl:with-param name="size">34</xsl:with-param>
      <xsl:with-param name="maxsize">34</xsl:with-param>
     </xsl:call-template>-->
     
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>