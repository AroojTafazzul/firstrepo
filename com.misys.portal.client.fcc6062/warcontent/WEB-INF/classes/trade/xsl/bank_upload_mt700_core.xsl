<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Export Letter of Credit (EL) Form, Bank Side
 
 Note: Templates beginning with lc- are in lc_common.xsl

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
  <xsl:param name="product-code">EL</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
  <xsl:param name="show-eucp">N</xsl:param>
  <xsl:param name="option"/>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" />
  <xsl:include href="../../core/xsl/common/lc_common.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="el_tnx_record"/>
  </xsl:template>
 
 <!-- 
   EL TNX FORM TEMPLATE.
  -->
  <xsl:template match="el_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>

   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Display common reporting area, realform and top menu-->
    <xsl:call-template name="bank-reporting-area">
    	<xsl:with-param name="option"><xsl:value-of select="$option"/></xsl:with-param>
    </xsl:call-template>
    
    <!-- Attachments -->
    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
     <xsl:call-template name="attachments-file-dojo">
       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
       <xsl:with-param name="title-size">35</xsl:with-param>
      </xsl:call-template> 
	</xsl:if>
    
    <!-- Attachments -->
    <xsl:call-template name="attachments-file-dojo">
    	<xsl:with-param name="attachment-group">OTHER</xsl:with-param>
    	<xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD_MT700</xsl:with-param>
    	<xsl:with-param name="title-size">35</xsl:with-param>
    	<xsl:with-param name="max-files">8</xsl:with-param>
    </xsl:call-template>

    <div id="transactionDetails">
     <xsl:if test="tnx_type_code[.='01']">
      <xsl:attribute name="style">display:block;</xsl:attribute>
     </xsl:if>
     <!-- Form #0 : Main Form -->
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
        
        
    <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    	<xsl:with-param name="content">
    
		    <xsl:if test="$displaymode='view'">
		      	<xsl:call-template name="input-field">
		       	<xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
		       	<xsl:with-param name="value" select="ref_id" />
		      	</xsl:call-template>
		     </xsl:if>
     
		     <xsl:if test="$displaymode='view' and (not(tnx_id) or tnx_type_code[.!='01'])">
		      <xsl:call-template name="input-field">
		       <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
		       <xsl:with-param name="value" select="bo_ref_id" />
		      </xsl:call-template>
		     </xsl:if>
		        <!-- Beneficiary Details -->
		     <xsl:call-template name="fieldset-wrapper">
		      <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
		      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
		      <xsl:with-param name="content">
		       <xsl:call-template name="address">
		        <xsl:with-param name="prefix">beneficiary</xsl:with-param>
		        <xsl:with-param name="show-entity">Y</xsl:with-param>
		        <xsl:with-param name="show-entity-button">Y</xsl:with-param>
		        <xsl:with-param name="search-button-type"><xsl:if test="tnx_type_code[.='01']">bank-beneficiary</xsl:if></xsl:with-param>
		        <xsl:with-param name="entity-required">N</xsl:with-param>
		        <xsl:with-param name="show-abbv">Y</xsl:with-param>
		        <xsl:with-param name="readonly">Y</xsl:with-param>
		        <xsl:with-param name="show-name">N</xsl:with-param>
   				<xsl:with-param name="show-address">N</xsl:with-param>
		       </xsl:call-template>
		      </xsl:with-param>
		     </xsl:call-template>
	       	
	       	<xsl:call-template name="eucp-details">
	      	  <xsl:with-param name="show-eucp" select="$show-eucp"/>
	     	</xsl:call-template>
       
       </xsl:with-param>
       </xsl:call-template>
       
       <xsl:call-template name="lc-amt-details">
        <xsl:with-param name="override-product-code">lc</xsl:with-param>
        <xsl:with-param name="show-bank-confirmation">Y</xsl:with-param>
        <xsl:with-param name="show-outstanding-amt">N</xsl:with-param>
        <xsl:with-param name="show-form-lc">N</xsl:with-param>
        <xsl:with-param name="show-variation-drawing">N</xsl:with-param>
      	<xsl:with-param name="show-amt">N</xsl:with-param>
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
   <xsl:with-param name="binding">misys.binding.bank.upload_swift_el</xsl:with-param>
   <xsl:with-param name="override-help-access-key">EL_01</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="override-product-code">lc</xsl:with-param>
  </xsl:call-template>
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_lc_liab_amt</xsl:with-param>
   </xsl:call-template>
  </div>
 </xsl:template>
</xsl:stylesheet>