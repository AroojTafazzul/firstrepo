<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Regular Export Collection (EC) Form, Customer Side.

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
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="xmlRender localization securitycheck utils security defaultresource">

  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">EC</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/ExportCollectionScreen</xsl:param>

  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/com_cross_references.xsl"/>
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl"/>
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  <xsl:include href="../../core/xsl/common/ls_common.xsl" /> 
    
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="ec_tnx_record"/>
  </xsl:template>
  
  <!-- 
   EC TNX FORM TEMPLATE.
  -->
  <xsl:template match="ec_tnx_record">
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
      <xsl:with-param name="show-return">Y</xsl:with-param>
      </xsl:call-template>
      
       <xsl:call-template name="build-inco-terms-data"/>
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
      
      <xsl:call-template name="hidden-fields"/>
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="general-details" />
      <xsl:call-template name="basic-amt-details">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_COLL_AMT_LABEL</xsl:with-param>
      </xsl:call-template>
      
      <!-- Tabgroup #0 : Bank Details (3 Tabs) -->
      <xsl:variable name="collectingBankLabel">
       <xsl:if test="collecting_bank/name[.!='']">XSL_BANKDETAILS_TAB_COLLECTING_BANK</xsl:if>
      </xsl:variable>
      <xsl:call-template name="tabgroup-wrapper">
       <xsl:with-param name="tabgroup-label">XSL_HEADER_BANK_DETAILS</xsl:with-param>
       <xsl:with-param name="tabgroup-id">bank-details-tabcontainer</xsl:with-param>
       <xsl:with-param name="tabgroup-height">290px</xsl:with-param>
     
       <!-- Tab 0_0 - Issuing Bank  -->
       <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_REMITTING_BANK</xsl:with-param>
       <xsl:with-param name="tab0-content">
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
         <xsl:with-param name="main-bank-name">remitting_bank</xsl:with-param>
         <xsl:with-param name="sender-name">drawer</xsl:with-param>
         <xsl:with-param name="sender-reference-name">drawer_reference</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="customer-reference-selectbox">
         <xsl:with-param name="main-bank-name">remitting_bank</xsl:with-param>
         <xsl:with-param name="sender-name">drawer</xsl:with-param>
         <xsl:with-param name="sender-reference-name">drawer_reference</xsl:with-param>
        </xsl:call-template>
       </xsl:with-param>
     
       <!-- Tab 0_1 - Advising Bank -->
       <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_PRESENTING_BANK</xsl:with-param>
       <xsl:with-param name="tab1-content">
        <xsl:apply-templates select="presenting_bank">
         <xsl:with-param name="theNodeName">presenting_bank</xsl:with-param>
         <xsl:with-param name="show-country">Y</xsl:with-param>
         <xsl:with-param name="required">
          <xsl:choose>
           <xsl:when test="ec_type_code[.='02']">Y</xsl:when>
           <xsl:otherwise>N</xsl:otherwise>
          </xsl:choose>
         </xsl:with-param>
        </xsl:apply-templates>
       </xsl:with-param>
       
       <!-- Tab 0_2 - Collecting Bank -->
       <!-- 
        This is usually shown only in the view mode (history screen). Since we can't add an if/else block here to check
        the displaymode, we instead check if ther is a collecting_bank value. If not, the label
        will be the empty string, and the tab is not shown.
       -->
       <xsl:with-param name="tab2-label">XSL_BANKDETAILS_TAB_COLLECTING_BANK</xsl:with-param>
       <xsl:with-param name="tab2-content">
        <xsl:apply-templates select="collecting_bank">
	      <xsl:with-param name="prefix" select="'collecting_bank'"/>
        </xsl:apply-templates>
       </xsl:with-param>
      </xsl:call-template>
     
      <xsl:if test="$displaymode='edit'">
         <script>
         	dojo.ready(function(){
         		misys._config = misys._config || {};
				dojo.mixin(misys._config,  {
				isDocumentMandatory : <xsl:value-of select="defaultresource:getResource('COLLECTION_DOCUMENT_MANDATORY')"/>
			});
			});
		 </script>
        </xsl:if>
      
      <xsl:call-template name="ec-shipment-details"/>
      <xsl:call-template name="ec-collection-instructions"/>
      <xsl:call-template name="attachments-documents">
      	<xsl:with-param name="product_code">EC</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="description-goods"/>      
	 <xsl:if test="$displaymode='edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')"> 
      <xsl:call-template name="ec-bank-instructions"/>
      </xsl:if>
  	  <xsl:if test="securitycheck:hasPermission($rundata,'ls_access') = 'true' and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true'">
		<xsl:call-template name="linked-ls-declaration"/>
 		<xsl:call-template name="linked-licenses"/>
 	 </xsl:if>
      <!-- comments for return -->
      <xsl:if test="tnx_stat_code[.!='03' and .!='04']">   <!-- MPS-43899 -->
      <xsl:call-template name="comments-for-return">
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
   	  </xsl:if>
     </xsl:with-param>
    </xsl:call-template>

	
     <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
    	<xsl:call-template name="attachments-file-dojo"/>
    </xsl:if>

    <xsl:call-template name="realform"/>
    <!-- Reauthentication -->
    <xsl:call-template name="reauthentication"/> 
 
    <xsl:call-template name="menu">
     <xsl:with-param name="second-menu">Y</xsl:with-param>
     <xsl:with-param name="show-return">Y</xsl:with-param>
    </xsl:call-template>
   </div>
 
   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>
   
   <!--  Collaboration Window -->     
   <xsl:call-template name="collaboration">
    <xsl:with-param name="editable">true</xsl:with-param>
    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    <xsl:with-param name="bank_name_widget_id">remitting_bank_name</xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id">remitting_bank_abbv_name</xsl:with-param>
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
   <xsl:with-param name="binding">misys.binding.trade.create_ec</xsl:with-param>
   <xsl:with-param name="override-help-access-key">EC_01</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="show-type">N</xsl:with-param>
   <xsl:with-param name="additional-fields">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">ec_type_code</xsl:with-param>
    </xsl:call-template>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">product_code</xsl:with-param>
	</xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>

 <!--
  EC General Details Fieldset.
    
  Common General Details, Applicant Details, Beneficiary Details.
 -->
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <div id="generaldetails">
     <!-- Common general details. -->
     <xsl:call-template name="common-general-details"/>    
     <xsl:call-template name="input-field">
      <xsl:with-param name="id">collection_type_view</xsl:with-param>
      <xsl:with-param name="label">XSL_GENERALDETAILS_COLL_TYPE_LABEL</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
        <xsl:when test="ec_type_code[.='01']">
         <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_COLL_TYPE_REGULAR')"/>
        </xsl:when>
        <xsl:when test="ec_type_code[.='02'] or ec_type_code[.='03']">
         <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_COLL_TYPE_DIRECT')"/>
        </xsl:when>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>

     <!-- EC Tenor Details -->
     <xsl:call-template name="tenor-details"/>
     <xsl:choose>
        <xsl:when test="ec_type_code[.='01']">
		 <xsl:call-template name="checkbox-field">
	       <xsl:with-param name="label">XSL_REPORTINGDETAILS_DIR_COLL_LETTER_LABEL</xsl:with-param>
	       <xsl:with-param name="name">dir_coll_letter_flag</xsl:with-param>
	       <xsl:with-param name="checked"><xsl:if test="dir_coll_letter_flag[. = 'Y']">Y</xsl:if></xsl:with-param>
	     </xsl:call-template>
	     <div id="boe">
	     	<xsl:call-template name="checkbox-field">
	       		<xsl:with-param name="label">XSL_REPORTINGDETAILS_BILL_OF_EXCHANGE</xsl:with-param>
	       		<xsl:with-param name="name">boe_flag</xsl:with-param>
	       		<xsl:with-param name="checked"><xsl:if test="boe_flag[. = 'Y']">Y</xsl:if></xsl:with-param>
	     	</xsl:call-template>
	     </div>
     	</xsl:when>
     	<xsl:when test="ec_type_code[.='02']">
		 <xsl:call-template name="checkbox-field">
	       <xsl:with-param name="label">XSL_REPORTINGDETAILS_DIR_COLL_LETTER_LABEL</xsl:with-param>
	       <xsl:with-param name="name">dir_coll_letter_flag</xsl:with-param>
	       <xsl:with-param name="checked"><xsl:if test="dir_coll_letter_flag[. = 'Y']">Y</xsl:if></xsl:with-param>
	     </xsl:call-template>
     	</xsl:when>
     	<xsl:when test="ec_type_code[.='03']">
     	<div id="boe">
		 <xsl:call-template name="checkbox-field">
	       <xsl:with-param name="label">XSL_REPORTINGDETAILS_BILL_OF_EXCHANGE</xsl:with-param>
	       <xsl:with-param name="name">boe_flag</xsl:with-param>
	       <xsl:with-param name="checked"><xsl:if test="boe_flag[. = 'Y']">Y</xsl:if></xsl:with-param>
	     </xsl:call-template>
	     </div>
     	</xsl:when>
     	<!-- <xsl:when test="ec_type_code[.='02']">
		 <xsl:call-template name="checkbox-field">
	       <xsl:with-param name="label">XSL_REPORTINGDETAILS_DIR_COLL_LETTER_LABEL</xsl:with-param>
	       <xsl:with-param name="name">dir_coll_cust_letter_flag</xsl:with-param>
	       <xsl:with-param name="checked"><xsl:if test="dir_coll_cust_letter_flag[. = 'Y']">Y</xsl:if></xsl:with-param>
	     </xsl:call-template>
     	</xsl:when> -->
     </xsl:choose>

     <xsl:call-template name="drawer-details"/>
    </div>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template> 
  
 
 <!-- Description of Goods -->
  <xsl:template name="description-goods">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_DESCRIPTION_GOODS</xsl:with-param>
    <xsl:with-param name="content">
    
    <xsl:call-template name="big-textarea-wrapper">
      <xsl:with-param name="id">narrative_description_goods</xsl:with-param>
      <xsl:with-param name="label">XSL_LABEL_DESCRIPTION_GOODS</xsl:with-param>
	  <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">narrative_description_goods</xsl:with-param>
        <xsl:with-param name="rows">12</xsl:with-param>
        <xsl:with-param name="maxlines">100</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
       </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!--
    EC Drawer Details
  -->
 <xsl:template name="drawer-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_DRAWER_DETAILS</xsl:with-param>
   <xsl:with-param name="legend-type">indented-header</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="address">
     <xsl:with-param name="show-entity">Y</xsl:with-param>
     <!-- Show reference in view mode -->
     <!-- <xsl:with-param name="show-reference"><xsl:if test="$displaymode='view'">Y</xsl:if></xsl:with-param> -->
     <xsl:with-param name="prefix">drawer</xsl:with-param>
    </xsl:call-template>
    <!-- Show decrypted reference in view mode. -->
    <xsl:if test="$displaymode='view' and drawer_reference [.!='']">
    	<xsl:variable name="drawer_ref">
              <xsl:value-of select="drawer_reference"/>
        </xsl:variable>
	  		<xsl:call-template name="input-field">
	         <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
	         <xsl:with-param name="name">drawer_reference</xsl:with-param>
	         <xsl:with-param name="value">
	         <xsl:choose>
		        <xsl:when test="count(avail_main_banks/bank/entity/customer_reference[reference=$drawer_ref]) >= 1">
	           		<xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$drawer_ref]/description"/>
	        	</xsl:when>
	       		<xsl:otherwise>
	           		<xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$drawer_ref]/description"/>
	        	</xsl:otherwise>
	        </xsl:choose>
        	</xsl:with-param>
        	<xsl:with-param name="maxsize">64</xsl:with-param>
	        </xsl:call-template>
    </xsl:if>
   </xsl:with-param>
  </xsl:call-template>
      
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_DRAWEE_DETAILS</xsl:with-param>
   <xsl:with-param name="legend-type">indented-header</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="address">
     <xsl:with-param name="show-country">Y</xsl:with-param>
     <xsl:with-param name="show-reference">Y</xsl:with-param>
     <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
     <xsl:with-param name="show-button">Y</xsl:with-param>
     <xsl:with-param name="prefix">drawee</xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>


  
  <!--
  EC Realform
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
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">swiftregexValue</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX')"/></xsl:with-param>
	  </xsl:call-template>
      <xsl:call-template name="e2ee_transaction"/>
         <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!--
   EC Tenor Types
   -->
  <xsl:template name="ec-tenor-types">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="01">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DP')"/>
      </option>
     <option value="02">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DA')"/>
     </option>
     <option value="04">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_AVAL')"/>
     </option>
     <option value="03">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_OTHER')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="term_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DP')"/></xsl:when>
      <xsl:when test="term_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DA')"/></xsl:when>
      <xsl:when test="term_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_OTHER')"/></xsl:when>
      <xsl:when test="term_code[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_AVAL')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <!--
  Presenting or collecting bank  
 -->
 <xsl:template match="collecting_bank">
  <xsl:param name="prefix"/>

   <!-- Name. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
    <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('NAME_TRADE_LENGTH')"/></xsl:with-param>
    <xsl:with-param name="value" select="name"/>
    <xsl:with-param name="type"><xsl:value-of select="$prefix"/></xsl:with-param>
    <xsl:with-param name="button-type"><xsl:value-of select="$prefix"/></xsl:with-param>
	<xsl:with-param name="override-product-code"><xsl:value-of select="product-code"/></xsl:with-param>
    <xsl:with-param name="required">N</xsl:with-param>
   </xsl:call-template>
   
   <!-- Address Lines -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_1</xsl:with-param>
    <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('ADDRESS1_TRADE_LENGTH')"/></xsl:with-param>
    <xsl:with-param name="value" select="address_line_1"/>
    <xsl:with-param name="required">N</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_2</xsl:with-param>
    <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('ADDRESS2_TRADE_LENGTH')"/></xsl:with-param>
    <xsl:with-param name="value" select="address_line_2"/>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_dom</xsl:with-param>
    <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('DOM_TRADE_LENGTH')"/></xsl:with-param>
    <xsl:with-param name="value" select="dom"/>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_4</xsl:with-param>
    <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('ADDRESS4_TRADE_LENGTH')"/></xsl:with-param>
    <xsl:with-param name="value" select="address_line_4"/>
    <xsl:with-param name="swift-validate">N</xsl:with-param>
   </xsl:call-template>
   <xsl:if test="$displaymode = 'view' and iso_code[.!='']">
        <xsl:call-template name="row-wrapper">
                <xsl:with-param name="label">XSL_PARTIESDETAILS_BIC_CODE</xsl:with-param>
                <xsl:with-param name="content"><div class="content">
                        <xsl:value-of select="iso_code"/></div>
                </xsl:with-param>
   		</xsl:call-template>
   </xsl:if>
   <div>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_iso_code</xsl:with-param>
     <xsl:with-param name="value" select="iso_code"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_reference</xsl:with-param>
     <xsl:with-param name="value" select="reference"></xsl:with-param>
    </xsl:call-template>
   </div>
 </xsl:template>
</xsl:stylesheet>