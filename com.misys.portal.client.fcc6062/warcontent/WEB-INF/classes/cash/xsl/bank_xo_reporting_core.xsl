<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Foreign Exchange Order (XO) Form, Bank Side.

Copyright (c) 2000-2010 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      10/26/10
author:    Charles Blonde
email:     charles.blonde@misys.com
##########################################################
-->
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
  <xsl:param name="product-code">XO</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
  <xsl:param name="show-eucp">N</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="xo_tnx_record"/>
  </xsl:template>
 
 <!-- 
   LC TNX FORM TEMPLATE.
  -->
  <xsl:template match="xo_tnx_record">
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
    <!-- The details of the LC are only shown if the beneficiary is not defined (it means that the transaction
           has been initiated through the Upload option and some mandatory fields are still missing  -->
    <!--xsl:when test="tnx_type_code[.='01'] and attachments/attachment[type = '01']">
      <hr/>
      <p><b><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></b></p>
    </xsl:when-->
    <!-- Uncomment line to enable LC detailed editing --> 
    <xsl:when test="tnx_type_code[.='15' or .='13' or .='01' or .='03']">
    
     <!-- Link to display transaction contents -->
     <xsl:call-template name="transaction-details-link"/>
     
     <div id="transactionDetails">
      <xsl:if test="$displaymode='view'">
       <xsl:attribute name="style">position:relative;left:0;</xsl:attribute>
      </xsl:if>
      <xsl:call-template name="form-wrapper">
       <xsl:with-param name="name" select="$main-form-name"/>
       <xsl:with-param name="validating">Y</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:if test="tnx_type_code[.!='01']">
         <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
        </xsl:if>
        
        <!-- Disclaimer Notice -->
        <xsl:call-template name="disclaimer"/>
        
        <xsl:call-template name="hidden-fields"/>
        <xsl:call-template name="general-details" />
              
        <xsl:call-template name="payment-details"/>
        <xsl:call-template name="shipment-details"/>
        
        <xsl:if test="tnx_type_code[.='01'] and release_dttm[.='']">
         <xsl:call-template name="instructions-send-mode"/>
        </xsl:if>
        
       </xsl:with-param>
      </xsl:call-template>
     </div>
    </xsl:when>
    <xsl:otherwise>
     <!-- Pending. -->
     <xsl:call-template name="form-wrapper">
      <xsl:with-param name="name" select="$main-form-name"/>
      <xsl:with-param name="validating">Y</xsl:with-param>
      <xsl:with-param name="content">
      <div>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">exp_date</xsl:with-param>
       </xsl:call-template>
       <xsl:if test="tnx_type_code[.='03']">
        <xsl:call-template name="hidden-field">
         <xsl:with-param name="name">iss_date</xsl:with-param>
        </xsl:call-template>
       </xsl:if>
      </div>
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
   <xsl:with-param name="binding">misys.binding.bank.report_lc</xsl:with-param>
   <xsl:with-param name="show-period-js">Y</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields"/>
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_lc_liab_amt</xsl:with-param>
   </xsl:call-template>
  
   <!-- For new messages from customer, don't empty the principal and fee accounts-->
   <xsl:if test="tnx_type_code[.!='01'] or release_dttm[.='']" >
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">principal_act_no</xsl:with-param>
     <xsl:with-param name="value" select="''"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_act_no</xsl:with-param>
     <xsl:with-param name="value" select="''"/>
    </xsl:call-template>
   </xsl:if>
  </div>
 </xsl:template>
 
 <!--
  General Details 
  -->
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
     <!-- The Issue Date needs to be shown only for a reporting, 
           it is in the reporting section for the New Upload -->
     <xsl:if test="tnx_type_code[.='15' or .='13']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
       <xsl:with-param name="name">iss_date</xsl:with-param>
       <xsl:with-param name="size">10</xsl:with-param>
       <xsl:with-param name="maxsize">10</xsl:with-param>
       <xsl:with-param name="type">date</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     
     <!--  Expiry Date. --> 
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="name">exp_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
     </xsl:call-template>
     
     <!-- Expiry place. -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:with-param>
      <xsl:with-param name="name">expiry_place</xsl:with-param>
      <xsl:with-param name="maxsize">29</xsl:with-param>
     </xsl:call-template>
      
     <!-- 
      Change show-eucp (global param in the main xslt of the form) to Y to show the EUCP section.
      Pass in a show-presentation parameter set to Y to display the presentation fields.
      
      If set to N, the template will instead insert a hidden field with the value 1.0
     -->
     <xsl:call-template name="eucp-details">
      <xsl:with-param name="show-eucp" select="$show-eucp"/>
     </xsl:call-template>
     
     <xsl:if test="lc_type[.!='04']">
      <!-- Applicant Details -->
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="button-type"><xsl:if test="tnx_type_code[.='01'] and release_dttm[.='']">bank-applicant</xsl:if></xsl:with-param>
       <xsl:with-param name="content">
        <xsl:call-template name="address">
         <xsl:with-param name="show-entity">
          <xsl:choose>
           <xsl:when test="entity[.='']">N</xsl:when>
           <xsl:otherwise>Y</xsl:otherwise>
          </xsl:choose>
         </xsl:with-param>
         <xsl:with-param name="show-entity-button"><xsl:if test="tnx_type_code[.='01']">Y</xsl:if></xsl:with-param>
         <xsl:with-param name="entity-type">bank-entity</xsl:with-param>
         <xsl:with-param name="show-abbv"><xsl:if test="tnx_type_code[.='01'] and release_dttm[.='']">Y</xsl:if></xsl:with-param>
         <xsl:with-param name="readonly"><xsl:if test="tnx_type_code[.='01'] and release_dttm[.='']">Y</xsl:if></xsl:with-param>
         <xsl:with-param name="prefix">applicant</xsl:with-param>
        </xsl:call-template>
        
        <!-- Case of LC initiations on bank side : applicant must be selected and not keyed --> 
        <xsl:choose>
         <xsl:when test="tnx_type_code[.='01'] and release_dttm[.=''] and customer_references/customer_reference">
          <xsl:call-template name="select-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
           <xsl:with-param name="name">applicant_reference</xsl:with-param>
           <xsl:with-param name="options"><xsl:apply-templates select="customer_references/customer_reference"/></xsl:with-param>
          </xsl:call-template>
         </xsl:when>
         <!-- Case of LC initiated on customer side : applicant already selected and not keyed --> 
         <xsl:otherwise>
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
           <xsl:with-param name="name">applicant_reference</xsl:with-param>
           <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('APPLICANT_REFERENCE_LENGTH')"/></xsl:with-param>
          </xsl:call-template>
         </xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
  
      <!-- Beneficiary Details -->
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="button-type">beneficiary</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:call-template name="address">
         <xsl:with-param name="show-reference">Y</xsl:with-param>
         <xsl:with-param name="prefix">beneficiary</xsl:with-param>
        </xsl:call-template>
       </xsl:with-param>
      </xsl:call-template>
     </xsl:if>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- 
  LC Payment Details
  -->
 <xsl:template name="payment-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_PAYMENT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_PAYMENTDETAILS_CR_AVAIL_WITH_LABEL</xsl:with-param>
     <xsl:with-param name="button-type">credit_available_with_bank</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:apply-templates select="credit_available_with_bank">
       <xsl:with-param name="theNodeName">credit_available_with_bank</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="show-button">N</xsl:with-param>
      </xsl:apply-templates>           
      
    </xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_PAYMENTDETAILS_DRAWEE_DETAILS_LABEL</xsl:with-param>
     <xsl:with-param name="button-type">drawee_details_bank</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:apply-templates select="drawee_details_bank">
       <xsl:with-param name="theNodeName">drawee_details_bank</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="show-button">N</xsl:with-param>
      </xsl:apply-templates>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
  <!--
   LC/SI Shipment Details Fieldset.
  -->
  <xsl:template name="shipment-details">
   <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_FROM</xsl:with-param>
     <xsl:with-param name="name">ship_from</xsl:with-param>
     <xsl:with-param name="maxsize">65</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_LOADING</xsl:with-param>
     <xsl:with-param name="name">ship_loading</xsl:with-param>
     <xsl:with-param name="maxsize">65</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_DISCHARGE</xsl:with-param>
     <xsl:with-param name="name">ship_discharge</xsl:with-param>
     <xsl:with-param name="maxsize">65</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_TO</xsl:with-param>
     <xsl:with-param name="name">ship_to</xsl:with-param>
     <xsl:with-param name="maxsize">65</xsl:with-param>
    </xsl:call-template>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_LABEL</xsl:with-param>
      <xsl:with-param name="name">part_ship_detl_nosend</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="part_ship_detl[. = '' or . = 'ALLOWED']">ALLOWED</xsl:when>
        <xsl:when test="part_ship_detl[. = 'NOT ALLOWED']">NOT ALLOWED</xsl:when>
        <xsl:otherwise>OTHER</xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
         <option value="ALLOWED">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/>
         </option>
         <option value="NOT ALLOWED">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/>
         </option>
         <option value="OTHER">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_OTHER')"/>
         </option>
        </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="part_ship_detl[. = '' or . = 'ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/></xsl:when>
          <xsl:when test="part_ship_detl[. = 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/></xsl:when>
          <xsl:when test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_OTHER')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$displaymode='edit' or part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="name">part_ship_detl_text_nosend</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:if test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED']"> 
         <xsl:value-of select="part_ship_detl"/>
        </xsl:if>
       </xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">part_ship_detl</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL</xsl:with-param>
      <xsl:with-param name="name">tran_ship_detl_nosend</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="tran_ship_detl[. = '' or . = 'ALLOWED']">ALLOWED</xsl:when>
        <xsl:when test="tran_ship_detl[. = 'NOT ALLOWED']">NOT ALLOWED</xsl:when>
        <xsl:otherwise>OTHER</xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
          <option value="ALLOWED">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/>
	      </option>
	      <option value="NOT ALLOWED">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/>
	      </option>
	      <option value="OTHER">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_OTHER')"/>
	      </option>
        </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="tran_ship_detl[. = '' or . = 'ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. = 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/></xsl:when>
          <xsl:when test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_OTHER')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$displaymode='edit' or tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="name">tran_ship_detl_text_nosend</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:if test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED']"> 
         <xsl:value-of select="tran_ship_detl"/>
        </xsl:if>
       </xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tran_ship_detl</xsl:with-param>
     </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SHIPMENTDETAILS_LAST_SHIP_DATE</xsl:with-param>
     <xsl:with-param name="name">last_ship_date</xsl:with-param>
     <xsl:with-param name="size">10</xsl:with-param>
     <xsl:with-param name="maxsize">10</xsl:with-param>
     <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_TERM</xsl:with-param>
     <xsl:with-param name="name">inco_term</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="options">
      <xsl:call-template name="purchase-terms-options"/>
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_PLACE</xsl:with-param>
     <xsl:with-param name="name">inco_place</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="maxsize">35</xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- 
  LC Bank Details
  -->
 <xsl:template name="bank-details">
 
  <xsl:call-template name="tabgroup-wrapper">
   <xsl:with-param name="tabgroup-label">XSL_HEADER_BANK_DETAILS</xsl:with-param>
   <xsl:with-param name="tabgroup-height">250px</xsl:with-param>

   <!-- Tab 1_0 - Advising Bank  -->
   <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_ADVISING_BANK</xsl:with-param>
   <xsl:with-param name="tab0-content">
    <xsl:apply-templates select="advising_bank">
     <xsl:with-param name="prefix">advising_bank</xsl:with-param>
    </xsl:apply-templates>
   </xsl:with-param>
   
   <!-- Tab 1_2 - Advise Thru Bank  -->
   <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_ADVISE_THRU_BANK</xsl:with-param>
   <xsl:with-param name="tab1-content">
    <xsl:apply-templates select="advise_thru_bank">
     <xsl:with-param name="prefix">advise_thru_bank</xsl:with-param>
    </xsl:apply-templates>
   </xsl:with-param>
  </xsl:call-template> 
 </xsl:template>
 
 <!--
  Advising / Advise Thru Bank
 -->
 <xsl:template match="advising_bank | advise_thru_bank">
  <xsl:param name="prefix"/>

  <!-- Name. -->
  <xsl:call-template name="input-field">
   <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
   <xsl:with-param name="value" select="name"/>
   <xsl:with-param name="required">Y</xsl:with-param>
   <xsl:with-param name="button-type"><xsl:value-of select="$prefix"/></xsl:with-param>
  </xsl:call-template>
   
  <!-- Address Lines -->
  <xsl:call-template name="input-field">
   <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_1</xsl:with-param>
   <xsl:with-param name="value" select="address_line_1"/>
   <xsl:with-param name="required">Y</xsl:with-param>
  </xsl:call-template>
  <xsl:call-template name="input-field">
   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_2</xsl:with-param>
   <xsl:with-param name="value" select="address_line_2"/>
  </xsl:call-template>
  <xsl:call-template name="input-field">
   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_dom</xsl:with-param>
   <xsl:with-param name="value" select="dom"/>
  </xsl:call-template>
  <xsl:choose>
  <xsl:when test="$prefix='advising_bank'">
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_JURISDICTION_BIC_CODE</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_iso_code</xsl:with-param>
    <xsl:with-param name="value" select="iso_code"/>
    <xsl:with-param name="size">11</xsl:with-param>
    <xsl:with-param name="maxsize">11</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_reference</xsl:with-param>
    <xsl:with-param name="value" select="reference"/>
    <xsl:with-param name="size">16</xsl:with-param>
    <xsl:with-param name="maxsize">64</xsl:with-param>
   </xsl:call-template>
  </xsl:when>
  <xsl:otherwise>
   <div class="widgetContainer">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">advise_thru_bank_iso_code</xsl:with-param>
     <xsl:with-param name="value" select="iso_code"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">advise_thru_bank_reference</xsl:with-param>
     <xsl:with-param name="value" select="reference"/>
    </xsl:call-template>
   </div>
  </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!--LC Instructions / Send Mode  -->
 <xsl:template name="instructions-send-mode">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_INSTRUCTIONS_REQ_SEND_MODE_LABEL</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_INSTRUCTIONS_REQ_SEND_MODE_LABEL</xsl:with-param>
     <xsl:with-param name="name">adv_send_mode</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="options">
      <xsl:choose>
	   <xsl:when test="$displaymode='edit'">
	      <option value="01">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/>
	      </option>
	      <option value="02">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/>
	      </option>
	      <option value="03">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/>
	      </option>
	   </xsl:when>
	   <xsl:otherwise>
	    <xsl:choose>
          <xsl:when test="adv_send_mode[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/></xsl:when>
          <xsl:when test="adv_send_mode[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/></xsl:when>
          <xsl:when test="adv_send_mode[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/></xsl:when>
         </xsl:choose>
	   </xsl:otherwise>
	  </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>  
 </xsl:template>
</xsl:stylesheet>