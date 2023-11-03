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
  <xsl:param name="product-code">LC</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/LetterOfCreditScreen</xsl:param>
  
  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <xsl:apply-templates select="lc_tnx_record"/>
  </xsl:template>
  
  <!-- 
   LC UPLOAD TNX FORM TEMPLATE.
  -->
  <xsl:template match="lc_tnx_record">
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
        <xsl:with-param name="show-return">Y</xsl:with-param>
      </xsl:call-template>
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
     
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details" />
      <xsl:call-template name="basic-amt-details"/>
      <xsl:call-template name="reauthentication"/>
      <!-- comments for return -->
      <xsl:call-template name="comments-for-return">
             <xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
             <xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
    
    <!-- Form #1 : Attach Files -->
     <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
    	<xsl:call-template name="attachments-file-dojo"/>
    </xsl:if>

    <xsl:call-template name="realform"/>

    <xsl:call-template name="menu">
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="show-return">Y</xsl:with-param>
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
    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
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
    <xsl:with-param name="binding">misys.binding.trade.upload_lc</xsl:with-param>
    <xsl:with-param name="override-help-access-key">LC_99</xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <xsl:call-template name="common-hidden-fields"/>
  <div class="widgetContainer">
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
			<xsl:with-param name="name">product_code</xsl:with-param>				
		</xsl:call-template>
	  	<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">sub_product_code</xsl:with-param>				
		</xsl:call-template>
	</div>
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
      
     <!--  Expiry Date. --> 
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="name">exp_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
     </xsl:call-template>
      
     <!-- Expiry place. -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:with-param>
      <xsl:with-param name="name">expiry_place</xsl:with-param>
      <xsl:with-param name="maxsize">29</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
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
      <xsl:with-param name="button-type">entity</xsl:with-param>
      <xsl:with-param name="prefix">applicant</xsl:with-param>
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
      <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
      <xsl:with-param name="sender-name">applicant</xsl:with-param>
      <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
      <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ISSUING_BANK</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="customer-reference-selectbox">
      <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
      <xsl:with-param name="sender-name">applicant</xsl:with-param>
      <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
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
		<xsl:with-param name="name">LC_Screen</xsl:with-param>
		<xsl:with-param name="value">Upload</xsl:with-param>
	  </xsl:call-template>
      <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">applicant_name</xsl:with-param>
		<xsl:with-param name="value" select="applicant_name"/>
	  </xsl:call-template>
	  <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">applicant_address_line_1</xsl:with-param>
		<xsl:with-param name="value" select="applicant_address_line_1"/>
	  </xsl:call-template>
	  <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">applicant_address_line_2</xsl:with-param>
		<xsl:with-param name="value" select="applicant_address_line_2"/>
	  </xsl:call-template>
	  <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">applicant_dom</xsl:with-param>
		 <xsl:with-param name="value" select="applicant_dom"/>
	  </xsl:call-template>
 	 	 	 	
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
 </xsl:stylesheet>