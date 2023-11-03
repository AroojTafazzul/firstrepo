<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for remittance letter generation, customer side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      27/10/15
author:    Shailly Palod
email:     shailly.palod@misys.com
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
		exclude-result-prefixes="xmlRender localization securitycheck utils security">

  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <!-- Columns definition import -->
  <xsl:import href="../../core/xsl/report/report.xsl"/>
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <!--<xsl:param name="option"></xsl:param>-->
  
  <!-- These params are empty for trade message -->
  <xsl:param name="realform-action"/>
  <xsl:param name="product-code"/>
  
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl"/>
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  
  <xsl:template match="/">
   <xsl:apply-templates/>
  </xsl:template>
  
  <!-- 
   TRADE MESSAGE TNX FORM TEMPLATE.
  -->
  <xsl:template match="el_tnx_record">
   <xsl:variable name="product-code"><xsl:value-of select="product_code"/></xsl:variable>
   <!-- Lower case product code -->
   <xsl:variable name="lowercase-product-code">
    <xsl:value-of select="translate($product-code,$up,$lo)"/>
   </xsl:variable>

   <xsl:variable name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/ExportLetterOfCreditScreen</xsl:variable>

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
       <xsl:with-param name="node-name" select="name(.)"/>
       <xsl:with-param name="screen-name">ExportLetterOfCreditScreen</xsl:with-param>
       <xsl:with-param name="show-template">N</xsl:with-param>
       <xsl:with-param name="show-return">Y</xsl:with-param>
      </xsl:call-template>
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
    
      <xsl:call-template name="hidden-fields">
       <xsl:with-param name="lowercase-product-code" select="$lowercase-product-code"/>
      </xsl:call-template>
      

      <!-- Hidden cross references -->
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      
      <xsl:call-template name="message-general-details">
      	<xsl:with-param name="additional-details">
      	<xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_DATE</xsl:with-param>
	       <xsl:with-param name="id">tnx_val_date_view</xsl:with-param>
	       <xsl:with-param name="value" select="tnx_val_date"/>
	       <xsl:with-param name="type">date</xsl:with-param>
	       <xsl:with-param name="override-displaymode">view</xsl:with-param>
	      </xsl:call-template>
      	<xsl:call-template name="currency-field">
	       <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_AMOUNT</xsl:with-param>
	       <xsl:with-param name="product-code">tnx</xsl:with-param>
	       <xsl:with-param name="override-currency-value"><xsl:value-of select="tnx_cur_code"/></xsl:with-param>
	       <xsl:with-param name="override-amt-value"><xsl:value-of select="tnx_amt"/></xsl:with-param>
	       <xsl:with-param name="required">Y</xsl:with-param>
	       <xsl:with-param name="show-button">N</xsl:with-param>
	    </xsl:call-template>
	    <xsl:if test="product_code[.='EL'] and cr_avl_by_code[.!='01'] and sub_tnx_type_code[.='87']">
	    	<div id="boe">
	     	<xsl:call-template name="checkbox-field">
	       		<xsl:with-param name="label">XSL_REPORTINGDETAILS_BILL_OF_EXCHANGE</xsl:with-param>
	       		<xsl:with-param name="name">boe_flag</xsl:with-param>
	       		<xsl:with-param name="checked"><xsl:if test="boe_flag[. = 'Y']">Y</xsl:if></xsl:with-param>
	     	</xsl:call-template>
	     </div>
	    </xsl:if>
      	</xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:call-template name="address">
         <xsl:with-param name="prefix">applicant</xsl:with-param>
         <xsl:with-param name="override-displaymode">view</xsl:with-param>
         <xsl:with-param name="show-entity-button">N</xsl:with-param>
        </xsl:call-template>
       </xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="attachments-documents">
      	<xsl:with-param name="product_code">EL</xsl:with-param>
      </xsl:call-template>
      
       <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS</xsl:with-param>
	    <xsl:with-param name="content">
	      <xsl:choose>
		     <xsl:when test="$displaymode='edit'">
			     <xsl:call-template name="row-wrapper">
			     <xsl:with-param name="id">narrative_additional_instructions</xsl:with-param>
			      <xsl:with-param name="label">XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS</xsl:with-param>
			       <xsl:with-param name="required">Y</xsl:with-param>
			      <xsl:with-param name="type">textarea</xsl:with-param>
			      <xsl:with-param name="content">
			       <xsl:call-template name="textarea-field">
			        <xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
			        <xsl:with-param name="required">Y</xsl:with-param>
			        <xsl:with-param name="rows">6</xsl:with-param>
			        <xsl:with-param name="maxlines">200</xsl:with-param>
			       </xsl:call-template>
			      </xsl:with-param>
			     </xsl:call-template>
		     </xsl:when>
		     <xsl:when test="$displaymode='view' and narrative_additional_instructions[.!='']">
		     	<xsl:call-template name="big-textarea-wrapper">
			      <xsl:with-param name="content"><div class="content">
			        <xsl:value-of select="narrative_additional_instructions"/>
			      </div></xsl:with-param>
			     </xsl:call-template>
		     </xsl:when>
	     </xsl:choose>
	  	</xsl:with-param>
	  </xsl:call-template>
     
     <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS</xsl:with-param>
	    <xsl:with-param name="content">
	     <xsl:choose>
		     <xsl:when test="$displaymode='edit'">
			     <xsl:call-template name="row-wrapper">
			      <xsl:with-param name="id">narrative_payment_instructions</xsl:with-param>
			       <xsl:with-param name="label">XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS</xsl:with-param>
			       <xsl:with-param name="required">Y</xsl:with-param>
			      <xsl:with-param name="type">textarea</xsl:with-param>
			      <xsl:with-param name="content">
			       <xsl:call-template name="textarea-field">
			        <xsl:with-param name="name">narrative_payment_instructions</xsl:with-param>
			        <xsl:with-param name="required">Y</xsl:with-param>
			        <xsl:with-param name="rows">6</xsl:with-param>
			        <!-- <xsl:with-param name="cols">35</xsl:with-param> -->
			       </xsl:call-template>
			      </xsl:with-param>
			     </xsl:call-template>
		     </xsl:when>
		     <xsl:when test="$displaymode='view' and narrative_payment_instructions[.!='']">
		     	<xsl:call-template name="big-textarea-wrapper">
			      <xsl:with-param name="content"><div class="content">
			        <xsl:value-of select="narrative_payment_instructions"/>
			      </div></xsl:with-param>
			     </xsl:call-template>
		     </xsl:when>
	     </xsl:choose>
	    </xsl:with-param>
	  </xsl:call-template>
      
       <!-- comments for return - currently making only for choosed product-->
       <xsl:if test="tnx_stat_code[.!='03' and .!='04']">   <!-- MPS-43899 -->
      <xsl:call-template name="comments-for-return">
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
   	  </xsl:if>
     </xsl:with-param>
    </xsl:call-template>
   
    <!-- Message realform. -->
    <xsl:call-template name="realform">
     <xsl:with-param name="action" select="$action"/>
    </xsl:call-template>
  
    <xsl:call-template name="menu">
     <xsl:with-param name="node-name" select="name(.)"/>
     <xsl:with-param name="screen-name">ExportLetterOfCreditScreen</xsl:with-param>
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
     <xsl:with-param name="show-return">Y</xsl:with-param>
    </xsl:call-template>
   </div>
   
   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>
   
  <!-- Reauthentication -->
  <xsl:call-template name="reauthentication"/>   
   
   <!--  Collaboration Window -->     
   <xsl:call-template name="collaboration">
    <xsl:with-param name="editable">true</xsl:with-param>
    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
   </xsl:call-template>

   <!-- Javascript and Dojo imports  -->
   <xsl:call-template name="js-imports">
    <xsl:with-param name="product-code"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="lowercase-product-code"><xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
    <xsl:with-param name="action"><xsl:value-of select="$action"/></xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!--                                     -->  
  <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
  <!--                                     -->

  <!-- Additional JS imports for this form are -->
  <!-- added here. -->
  <xsl:template name="js-imports">
   <xsl:param name="product-code"/>
   <xsl:param name="lowercase-product-code"/>
   <xsl:param name="action"/>

   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.trade.message_remittance</xsl:with-param>
    <xsl:with-param name="override-product-code" select="$product-code"/>
    <xsl:with-param name="override-lowercase-product-code" select="$lowercase-product-code"/>
    <xsl:with-param name="override-action" select="$action"/>
    <xsl:with-param name="override-help-access-key">EL_02</xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <xsl:param name="lowercase-product-code"/>
   <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="show-type">N</xsl:with-param>
    <xsl:with-param name="show-tnx-amt">N</xsl:with-param>
    <xsl:with-param name="additional-fields">
     <xsl:if test="$displaymode='edit'">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">prod_stat_code</xsl:with-param>
     </xsl:call-template>
     <xsl:if test="entity and entity[.!='']">
	     <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">entity</xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">product_code</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="product_code"/></xsl:with-param>
     </xsl:call-template>
    </xsl:if>

	<xsl:call-template name="hidden-field">
      <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="sub_tnx_type_code"/></xsl:with-param>
     </xsl:call-template>
    <!-- Displaying the bank details. -->
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">advising_bank_abbv_name</xsl:with-param>
       <xsl:with-param name="value" select="advising_bank/abbv_name"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">advising_bank_name</xsl:with-param>
       <xsl:with-param name="value" select="advising_bank/name"/>
      </xsl:call-template> 
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">bo_tnx_id</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="bo_tnx_id"/></xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
      	     <xsl:with-param name="name">org_lc_available_amt</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="lc_available_amt"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
      	     <xsl:with-param name="name">lc_cur_code</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="lc_cur_code"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
      	     <xsl:with-param name="name">lc_available_amt</xsl:with-param>
             <xsl:with-param name="value"><xsl:value-of select="lc_available_amt"/></xsl:with-param>
    </xsl:call-template>
    
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
    <xsl:with-param name="action" select="$action"/>
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
       <xsl:with-param name="value">13</xsl:with-param>
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
       <xsl:with-param name="name">fileActIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="e2ee_transaction"/>
      <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
</xsl:stylesheet>