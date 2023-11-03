<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for maintaining entities, customer side.

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
  	xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:crypto="xalan://com.misys.portal.security.crypto.Crypto"
	exclude-result-prefixes="xmlRender localization securitycheck utils security crypto">

  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="nextscreen"/>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  
  <!-- These params are empty for maintain entity -->
  <xsl:param name="realform-action"/>
  <xsl:param name="product-code"/>
  
  <!-- Global Imports. -->
  <xsl:include href="common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  
  <xsl:template match="/">
   <xsl:apply-templates/>
  </xsl:template>
  
  <!-- 
   ENTITY MAINTAIN TNX FORM TEMPLATE.
  -->
  <xsl:template match="*">
   <xsl:variable name="product-code"><xsl:value-of select="product_code"/></xsl:variable>
   <xsl:variable name="node-name"><xsl:value-of select="name(.)"/></xsl:variable>
   
   <!-- Lower case product code -->
   <xsl:variable name="lowercase-product-code">
    <xsl:value-of select="translate($product-code,$up,$lo)"/>
   </xsl:variable>

   <xsl:variable name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:variable>
  
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
  
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
     
      <!--  Display common menu. -->
      <xsl:call-template name="menu">
       <xsl:with-param name="node-name" select="$node-name"/>
       <xsl:with-param name="show-template">N</xsl:with-param>
       <xsl:with-param name="show-save">N</xsl:with-param>
      </xsl:call-template>
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
     
      <xsl:call-template name="hidden-fields">
       <xsl:with-param name="lowercase-product-code" select="$lowercase-product-code"/>
      </xsl:call-template>
      
      <!-- Hidden cross references -->
      <xsl:if test="product_code[.!='IN' and .!='IP']">
     	<xsl:apply-templates select="cross_references" mode="hidden_form"/>
      </xsl:if>
      
      <xsl:call-template name="general-details">
       <xsl:with-param name="product-code" select="$product-code"/>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
   
    <!-- Message realform. -->
    <xsl:call-template name="realform">
     <xsl:with-param name="action" select="$action"/>
    </xsl:call-template>
    
    <!-- Reauthentication -->
      <xsl:call-template name="reauthentication"/>
		
    <xsl:call-template name="menu">
     <xsl:with-param name="node-name" select="$node-name"/>
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="show-save">N</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
    </xsl:call-template>
   </div>
   
   <!-- Javascript imports -->
   <xsl:call-template name="js-imports">
    <xsl:with-param name="override-product-code"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="override-lowercase-product-code"><xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
    <xsl:with-param name="override-action"><xsl:value-of select="$action"/></xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!--                                     -->  
  <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
  <!--                                     -->

  <!-- Additional javascript for this form are  -->
  <!-- added here. -->
  <xsl:template name="js-imports">
   <xsl:param name="override-action"></xsl:param>
   <xsl:param name="override-product-code"></xsl:param>
   <xsl:param name="override-lowercase-product-code"></xsl:param>
   
   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.trade.maintain_entities</xsl:with-param>
    <xsl:with-param name="show-period-js">Y</xsl:with-param>
    <xsl:with-param name="override-action" select="$override-action"/>
    <xsl:with-param name="override-product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
    <xsl:with-param name="override-lowercase-product-code"><xsl:value-of select="$override-lowercase-product-code"/></xsl:with-param>
    <xsl:with-param name="override-help-access-key"><xsl:value-of select="$override-product-code"/>_17</xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <xsl:param name="lowercase-product-code"/>
   <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="show-type">N</xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- General Details -->
  <xsl:template name="general-details">
   <xsl:param name="product-code"/>
  
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">

     <!--  System ID. -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
      <xsl:with-param name="value" select="ref_id" />
      <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">ref_id</xsl:with-param>
     </xsl:call-template>
   
     <!-- Customer Reference -->
     <xsl:if test="cust_ref_id[.!='']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
       <xsl:with-param name="id">general_cust_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="cust_ref_id" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">cust_ref_id</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
   
     <!-- Bank Reference -->
     <xsl:if test="bo_ref_id[.!='']">
     <div style="white-space:pre;">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
       <xsl:with-param name="id">general_bo_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="bo_ref_id" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      </div>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">bo_ref_id</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
      
     <!-- Cross References -->
     <xsl:if test="cross_references">
      <xsl:apply-templates select="cross_references" mode="display_table_tnx"/>
     </xsl:if>
     <xsl:if test="cross_references/cross_reference/type_code[.='02']">
      <xsl:variable name="parent_file" select="xmlRender:getXMLMasterNode(cross_references/cross_reference[./type_code='02']/product_code, cross_references/cross_reference[./type_code='02']/ref_id, $language)"/>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
       <xsl:with-param name="id">parent_file_bo_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="$parent_file/bo_ref_id"/>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
      
     <xsl:if test="alt_lc_ref_id[.!='']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
       <xsl:with-param name="id">general_alt_lc_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="alt_lc_ref_id"/>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:if test="deal_ref_id[.!='']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_DEAL_REF_ID</xsl:with-param>
       <xsl:with-param name="id">general_deal_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="deal_ref_id"/>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:if test="prod_stat_code[.!='']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_REPORTINGDETAILS_PROD_STAT_LABEL</xsl:with-param>
       <xsl:with-param name="id">prod_stat_code_view</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N005', prod_stat_code[.])"/></xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:if test="$product-code = 'LS'">
	  <xsl:variable name="productCode">*</xsl:variable>
	  <xsl:variable name="subProductCode">*</xsl:variable>
	  <xsl:variable name="parameterId">C026</xsl:variable>
	   <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_LICENSE_TYPE</xsl:with-param>
	    <xsl:with-param name="id">ls_type_value</xsl:with-param>
	    <xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, ls_type)"/></xsl:with-param>
	    <xsl:with-param name="override-displaymode">view</xsl:with-param>
	   </xsl:call-template>
       <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_LICENSE_NUMBER</xsl:with-param>
	    <xsl:with-param name="name">ls_number</xsl:with-param>
	    <xsl:with-param name="value" select="ls_number" />
	    <xsl:with-param name="override-displaymode">view</xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_AUTH_REFERENCE</xsl:with-param>
	    <xsl:with-param name="name">auth_reference</xsl:with-param>
	    <xsl:with-param name="value" select="auth_reference" />
	    <xsl:with-param name="override-displaymode">view</xsl:with-param>
	   </xsl:call-template>
     </xsl:if>
      
     <!-- Applicant Abbv Name -->
     <xsl:choose>
      <xsl:when test="applicant_abbv_name[. != '']">
       <xsl:call-template name="fieldset-wrapper">
        <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
        <xsl:with-param name="legend-type">indented-header</xsl:with-param>
        <xsl:with-param name="content">
         <xsl:if test="applicant_name[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
           <xsl:with-param name="id">applicant_name_view</xsl:with-param>
           <xsl:with-param name="value" select="applicant_name"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="applicant_address_line_1[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
           <xsl:with-param name="id">applicant_address_line_1_view</xsl:with-param>
           <xsl:with-param name="value" select="applicant_address_line_1"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="applicant_address_line_2[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="id">applicant_address_line_2_view</xsl:with-param>
           <xsl:with-param name="value" select="applicant_address_line_2"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="applicant_dom[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="id">applicant_dom_view</xsl:with-param>
           <xsl:with-param name="value" select="applicant_dom"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="applicant_reference[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
           <xsl:with-param name="id">applicant_reference_view</xsl:with-param>
           <xsl:with-param name="value" select="applicant_reference"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <!-- Entity -->
         <xsl:call-template name="set-entity-field">
          <xsl:with-param name="override-product-code" select="$product-code"/>
         </xsl:call-template>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:when>
      <xsl:when test ="beneficiary_abbv_name[. != '']">
       <xsl:call-template name="fieldset-wrapper">
        <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
        <xsl:with-param name="legend-type">indented-header</xsl:with-param>
        <xsl:with-param name="content">
         <xsl:if test="beneficiary_name[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
           <xsl:with-param name="id">beneficiary_name_view</xsl:with-param>
           <xsl:with-param name="value" select="beneficiary_name"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="beneficiary_address_line_1[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
           <xsl:with-param name="id">beneficiary_address_line_1_view</xsl:with-param>
           <xsl:with-param name="value" select="beneficiary_address_line_1"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="beneficiary_address_line_2[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="id">beneficiary_address_line_2_view</xsl:with-param>
           <xsl:with-param name="value" select="beneficiary_address_line_2"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="beneficiary_dom[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="id">beneficiary_dom_view</xsl:with-param>
           <xsl:with-param name="value" select="beneficiary_dom"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="beneficiary_reference[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
           <xsl:with-param name="id">beneficiary_reference_view</xsl:with-param>
           <xsl:with-param name="value" select="beneficiary_reference"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <!-- Entity -->
         <xsl:call-template name="set-entity-field">
          <xsl:with-param name="override-product-code" select="$product-code"/>
         </xsl:call-template>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:when>
      <xsl:when test ="drawee_abbv_name[. != ''] or product_code[.='IC']">
       <xsl:call-template name="fieldset-wrapper">
        <xsl:with-param name="legend">XSL_HEADER_DRAWEE_DETAILS</xsl:with-param>
        <xsl:with-param name="content">
         <xsl:if test="drawee_name[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
           <xsl:with-param name="id">drawee_name_view</xsl:with-param>
           <xsl:with-param name="value" select="drawee_name"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="drawee_address_line_1[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
           <xsl:with-param name="id">drawee_address_line_1_view</xsl:with-param>
           <xsl:with-param name="value" select="drawee_address_line_1"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="drawee_address_line_2[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="id">drawee_address_line_2_view</xsl:with-param>
           <xsl:with-param name="value" select="drawee_address_line_2"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="drawee_dom[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="id">drawee_dom_view</xsl:with-param>
           <xsl:with-param name="value" select="drawee_dom"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="drawee_reference[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
           <xsl:with-param name="id">drawee_reference_view</xsl:with-param>
           <xsl:with-param name="value" select="drawee_reference"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <!-- Entity -->
         <xsl:call-template name="set-entity-field">
          <xsl:with-param name="override-product-code" select="$product-code"/>
         </xsl:call-template>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:when>
      <xsl:when test ="drawer_abbv_name[. != ''] or product_code[.='IC']">
       <xsl:call-template name="fieldset-wrapper">
        <xsl:with-param name="legend">XSL_HEADER_DRAWER_DETAILS</xsl:with-param>
        <xsl:with-param name="content">
         <xsl:if test="drawer_name[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
           <xsl:with-param name="id">drawer_name_view</xsl:with-param>
           <xsl:with-param name="value" select="drawer_name"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="drawer_address_line_1[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
           <xsl:with-param name="id">drawer_address_line_1_view</xsl:with-param>
           <xsl:with-param name="value" select="drawer_address_line_1"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="drawer_address_line_2[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="id">drawer_address_line_2_view</xsl:with-param>
           <xsl:with-param name="value" select="drawer_address_line_2"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="drawer_dom[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="id">drawer_dom_view</xsl:with-param>
           <xsl:with-param name="value" select="drawer_dom"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="drawer_reference[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
           <xsl:with-param name="id">drawer_reference_view</xsl:with-param>
           <xsl:with-param name="value" select="drawer_reference"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <!-- Entity -->
         <xsl:call-template name="set-entity-field">
          <xsl:with-param name="override-product-code" select="$product-code"/>
         </xsl:call-template>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:when>
      <xsl:when test ="remitter_abbv_name[. != '']">
       <xsl:call-template name="fieldset-wrapper">
        <xsl:with-param name="legend">XSL_HEADER_REMITTER_DETAILS</xsl:with-param>
        <xsl:with-param name="content">
         <xsl:if test="remitter_name[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
           <xsl:with-param name="id">remitter_name_view</xsl:with-param>
           <xsl:with-param name="value" select="remitter_name"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="remitter_address_line_1[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
           <xsl:with-param name="id">remitter_address_line_1_view</xsl:with-param>
           <xsl:with-param name="value" select="remitter_address_line_1"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="remitter_address_line_2[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="id">remitter_address_line_2_view</xsl:with-param>
           <xsl:with-param name="value" select="remitter_address_line_2"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="remitter_dom[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="id">remitter_dom_view</xsl:with-param>
           <xsl:with-param name="value" select="remitter_dom"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="remitter_reference[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
           <xsl:with-param name="id">remitter_reference_view</xsl:with-param>
           <xsl:with-param name="value" select="remitter_reference"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <!-- Entity -->
         <xsl:call-template name="set-entity-field">
          <xsl:with-param name="override-product-code" select="$product-code"/>
         </xsl:call-template>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:when>
      <xsl:when test ="buyer_abbv_name[. != '']">
       <xsl:call-template name="fieldset-wrapper">
        <xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
        <xsl:with-param name="content">
         <xsl:if test="buyer_name[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
           <xsl:with-param name="id">buyer_name_view</xsl:with-param>
           <xsl:with-param name="value" select="buyer_name"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="buyer_address_line_1[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
           <xsl:with-param name="id">buyer_address_line_1_view</xsl:with-param>
           <xsl:with-param name="value" select="buyer_address_line_1"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="buyer_address_line_2[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="id">buyer_address_line_2_view</xsl:with-param>
           <xsl:with-param name="value" select="buyer_address_line_2"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="buyer_dom[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="id">buyer_dom_view</xsl:with-param>
           <xsl:with-param name="value" select="buyer_dom"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="buyer_reference[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
           <xsl:with-param name="id">buyer_reference_view</xsl:with-param>
           <xsl:with-param name="value" select="buyer_reference"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <!-- Entity -->
         <xsl:call-template name="set-entity-field">
          <xsl:with-param name="override-product-code" select="$product-code"/>
         </xsl:call-template>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:when>
      <xsl:when test ="seller_abbv_name[. != '']">
       <xsl:call-template name="fieldset-wrapper">
        <xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
        <xsl:with-param name="content">
         <xsl:if test="seller_name[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
           <xsl:with-param name="id">seller_name_view</xsl:with-param>
           <xsl:with-param name="value" select="seller_name"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="seller_address_line_1[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
           <xsl:with-param name="id">seller_address_line_1_view</xsl:with-param>
           <xsl:with-param name="value" select="seller_address_line_1"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="seller_address_line_2[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="id">seller_address_line_2_view</xsl:with-param>
           <xsl:with-param name="value" select="seller_address_line_2"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="seller_dom[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="id">seller_dom_view</xsl:with-param>
           <xsl:with-param name="value" select="seller_dom"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="seller_reference[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
           <xsl:with-param name="id">seller_reference_view</xsl:with-param>
           <xsl:with-param name="value" select="seller_reference"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <!-- Entity -->
         <xsl:call-template name="set-entity-field">
          <xsl:with-param name="override-product-code" select="$product-code"/>
         </xsl:call-template>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:when>
      <xsl:when test="borrower_abbv_name[. != '']">
       <xsl:call-template name="fieldset-wrapper">
        <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
        <xsl:with-param name="legend-type">indented-header</xsl:with-param>
        <xsl:with-param name="content">
         <xsl:if test="borrower_name[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
           <xsl:with-param name="id">borrower_name_view</xsl:with-param>
           <xsl:with-param name="value" select="borrower_name"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="borrower_address_line_1[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
           <xsl:with-param name="id">borrower_address_line_1_view</xsl:with-param>
           <xsl:with-param name="value" select="applicant_address_line_1"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="borrower_address_line_2[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="id">borrower_address_line_2_view</xsl:with-param>
           <xsl:with-param name="value" select="borrower_address_line_2"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="borrower_dom[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="id">borrower_dom_view</xsl:with-param>
           <xsl:with-param name="value" select="borrower_dom"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="borrower_reference[.!='']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
           <xsl:with-param name="id">borrower_reference_view</xsl:with-param>
           <xsl:with-param name="value" select="borrower_reference"/>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <!-- Entity -->
         <xsl:call-template name="set-entity-field">
          <xsl:with-param name="override-product-code" select="$product-code"/>
         </xsl:call-template>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:when>      
     </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
   
  </xsl:template>

  <!--
   Hidden fields for Message
   -->
  <xsl:template name="realform">
   <xsl:param name="action"/>
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="method">POST</xsl:with-param>
    <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="localization-dialog"/>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value">SUBMIT</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">UPDATE_ENTITY</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">productcode</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="product_code"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="set-entity-field">
   <!-- Optional -->
   <xsl:param name="entity-label">XSL_PARTIESDETAILS_ENTITY</xsl:param>
   <xsl:param name="required">Y</xsl:param>
   <xsl:param name="override-product-code" select="product_code"/>
   <xsl:if test="entities">   
   	<xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_PARTIESDETAILS_ENTITY</xsl:with-param>
     <xsl:with-param name="id">entity</xsl:with-param>
     <xsl:with-param name="name">entity</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="readonly">Y</xsl:with-param>
     <xsl:with-param name="button-type">set-entity</xsl:with-param>
     <xsl:with-param name="override-product-code" select="$override-product-code"/>
     <xsl:with-param name="override-applicant-reference"><xsl:value-of select="crypto:encrypt(reference)"/></xsl:with-param>
    </xsl:call-template>
   </xsl:if>
   <xsl:if test="not(entities) and entity">
   	<xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_PARTIESDETAILS_ENTITY</xsl:with-param>
     <xsl:with-param name="id">entity</xsl:with-param>
     <xsl:with-param name="name">entity</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="readonly">Y</xsl:with-param>
     <xsl:with-param name="button-type">set-entity</xsl:with-param>
     <xsl:with-param name="override-product-code" select="$override-product-code"/>      
    </xsl:call-template>
   </xsl:if>   
  </xsl:template>
</xsl:stylesheet>