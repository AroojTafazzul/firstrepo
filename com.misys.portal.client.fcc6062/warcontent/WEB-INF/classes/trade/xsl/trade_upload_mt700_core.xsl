<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Letter of Credit (LC) Upload Form, Customer Side.

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
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
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
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/ExportLetterOfCreditScreen</xsl:param>
  
  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl"/>
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <xsl:apply-templates select="el_tnx_record"/>
  </xsl:template>
  
  <!-- 
   LC UPLOAD TNX FORM TEMPLATE.
  -->
  <xsl:template match="el_tnx_record">
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
       <xsl:with-param name="show-template">N</xsl:with-param>
      </xsl:call-template>
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
     
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details" />
     </xsl:with-param>
    </xsl:call-template>
    
    <!-- Form #1 : Attach Files -->
    <!-- Attachments -->
     <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
    	<xsl:call-template name="attachments-file-dojo"/>
    </xsl:if>
        
    <!-- Attachments -->
    <xsl:call-template name="attachments-file-dojo">
    	<xsl:with-param name="attachment-group">OTHER</xsl:with-param>
    	<xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD_MT700</xsl:with-param>
    	<xsl:with-param name="max-files">4</xsl:with-param>
    	<xsl:with-param name="title-size">35</xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="realform"/>

    <xsl:call-template name="menu">
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
    </xsl:call-template>
   </div> 
    
   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>
   
   <!--  Collaboration Window -->     
   <xsl:call-template name="collaboration">
    <xsl:with-param name="editable">true</xsl:with-param>
    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    <xsl:with-param name="bank_name_widget_id"></xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id"></xsl:with-param>
   </xsl:call-template>
    
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
    <xsl:with-param name="binding">misys.binding.trade.upload_swift_el</xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <xsl:call-template name="common-hidden-fields"/>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!--
    LC Upload General Details Fieldset.
    
    Common General Details, Applicant Details, Beneficiary Details.
  -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <!-- Common general details. -->
     <xsl:call-template name="common-general-details">
      <xsl:with-param name="show-template-id">N</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">iss_date</xsl:with-param>
     </xsl:call-template>
      
     <!-- 
      Change show-eucp (global param in the main xslt of the form) to Y to show the EUCP section.
      Pass in a show-presentation parameter set to Y to display the presentation fields.
      
      If set to N, the template will instead insert a hidden field with the value 1.0
     -->
     <xsl:call-template name="eucp-details">
      <xsl:with-param name="show-eucp" select="$show-eucp"/>
     </xsl:call-template>
      
     <!-- Entity and Issuing Bank Name -->
     <xsl:call-template name="entity-field">
      <xsl:with-param name="button-type">entity-basic</xsl:with-param>
     </xsl:call-template>
      
     <xsl:if test="$displaymode='edit'">
      <script>
      	dojo.ready(function(){
      		misys._config = misys._config || {};
			misys._config.customerReferences = {};
			<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
		});
	 </script>
     </xsl:if>
     <xsl:call-template name="main-bank-selectbox">
      <xsl:with-param name="main-bank-name">advising_bank</xsl:with-param>
      <xsl:with-param name="sender-name">beneficiary</xsl:with-param>
      <xsl:with-param name="sender-reference-name">beneficiary_reference</xsl:with-param>
      <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ADVISING_BANK</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="customer-reference-selectbox">
      <xsl:with-param name="main-bank-name">advising_bank</xsl:with-param>
      <xsl:with-param name="sender-name">beneficiary</xsl:with-param>
      <xsl:with-param name="sender-reference-name">beneficiary_reference</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!--
   Hidden fields for Export Letter of Credit 
   -->
  <xsl:template name="realform">
   <!-- Do not display this section when the counterparty mode is 'counterparty' -->
   <xsl:if test="$collaborationmode != 'counterparty'">
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
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
 </xsl:stylesheet>