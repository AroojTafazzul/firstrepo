<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Export Collection (EC) Amendment Form, Customer Side.
 
 Note: Templates beginning with amend- are in amend_common.xsl

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      09/09/15
author:    Shailly Palod
email:     shailly.palodn@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
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
  <!-- Columns definition import -->
  <xsl:import href="../../core/xsl/report/report.xsl"/>
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
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
  <xsl:include href="../../core/xsl/common/ls_common.xsl" />
  <xsl:include href="../../core/xsl/common/amend_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  
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
      <xsl:with-param name="show-template">N</xsl:with-param>
      </xsl:call-template>
        <xsl:call-template name="build-inco-terms-data"/>
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
      
      <xsl:call-template name="hidden-fields"/>
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="general-details" />
      <xsl:call-template name="ec-amend-amt-details">
      	<xsl:with-param name="show-os-amt">Y</xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="ec-shipment-details"/>
      <xsl:call-template name="ec-collection-instructions"/>
      <xsl:call-template name="attachments-documents">
      	<xsl:with-param name="product_code">EC</xsl:with-param>
      </xsl:call-template> 
      <xsl:call-template name="amend-narrative"/>    
      <xsl:call-template name="ec-bank-instructions">
      	<xsl:with-param name="is-amendment">Y</xsl:with-param>
      </xsl:call-template>
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
     <xsl:with-param name="show-template">N</xsl:with-param>
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
   <xsl:with-param name="binding">misys.binding.trade.amend_ec</xsl:with-param>
   <xsl:with-param name="override-help-access-key">EC_03</xsl:with-param>
  </xsl:call-template>
 </xsl:template>

 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="show-type">N</xsl:with-param>
  </xsl:call-template>
  <div class="widgetContainer">
  <xsl:call-template name="localization-dialog"/>
  <xsl:call-template name="hidden-field">
	   <xsl:with-param name="name">remitting_bank_abbv_name</xsl:with-param>
	   <xsl:with-param name="value" select="remitting_bank/abbv_name"/>
  </xsl:call-template>
  <xsl:call-template name="hidden-field">
	   <xsl:with-param name="name">remitting_bank_name</xsl:with-param>
	   <xsl:with-param name="value" select="remitting_bank/name"/>
  </xsl:call-template>
   <xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">ref_id</xsl:with-param>
    	<xsl:with-param name="value"><xsl:value-of select="ref_id"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">cust_ref_id</xsl:with-param>	
		<xsl:with-param name="value"><xsl:value-of select="cust_ref_id"/></xsl:with-param>			
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">bo_ref_id</xsl:with-param>
    	<xsl:with-param name="value"><xsl:value-of select="bo_ref_id"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">template_id</xsl:with-param>		
		<xsl:with-param name="value"><xsl:value-of select="template_id"/></xsl:with-param>		
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">drawee_name</xsl:with-param>	
		<xsl:with-param name="value"><xsl:value-of select="drawee_name"/></xsl:with-param>			
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">drawee_abbv_name</xsl:with-param>	
		<xsl:with-param name="value"><xsl:value-of select="drawee_abbv_name"/></xsl:with-param>			
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">drawer_name</xsl:with-param>	
		<xsl:with-param name="value"><xsl:value-of select="drawer_name"/></xsl:with-param>			
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">drawer_abbv_name</xsl:with-param>	
		<xsl:with-param name="value"><xsl:value-of select="drawer_abbv_name"/></xsl:with-param>			
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">ec_cur_code</xsl:with-param>
    	<xsl:with-param name="value"><xsl:value-of select="ec_cur_code"/></xsl:with-param>
   </xsl:call-template>
   <xsl:if test="entity[.!='']">
   <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">entity</xsl:with-param>		
		<xsl:with-param name="value"><xsl:value-of select="entity"/></xsl:with-param>		
   </xsl:call-template>
   </xsl:if>
  <xsl:if test="$displaymode='edit'">
	   <xsl:call-template name="hidden-field">
	    	<xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
			<xsl:with-param name="name">product_code</xsl:with-param>				
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
	   		<xsl:with-param name="name">appl_date</xsl:with-param>
	   </xsl:call-template>
  </xsl:if>
   <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">tnx_cur_code</xsl:with-param>		
		<xsl:with-param name="value"><xsl:value-of select="ec_cur_code"/></xsl:with-param>		
   </xsl:call-template>
  </div>
  
 </xsl:template>
 
 <!--
  EC General Details Fieldset.
    
  Common General Details, Applicant Details, Beneficiary Details.
 -->
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="button-type">summary-details</xsl:with-param>
   <xsl:with-param name="content">
    <div id="generaldetails">
     <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
	    <xsl:with-param name="id">ref_id</xsl:with-param>
	    <xsl:with-param name="value" select="ref_id" />
	    <xsl:with-param name="override-displaymode">view</xsl:with-param>
	 </xsl:call-template>
	 <xsl:if test="bo_ref_id[.!='']">
		 <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
		    <xsl:with-param name="id">bo_ref_id</xsl:with-param>
		    <xsl:with-param name="value" select="bo_ref_id" />
		    <xsl:with-param name="override-displaymode">view</xsl:with-param>
		 </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="cust_ref_id[.!='']">
		 <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
		    <xsl:with-param name="id">cust_ref_id</xsl:with-param>
		    <xsl:with-param name="value" select="cust_ref_id" />
		    <xsl:with-param name="override-displaymode">view</xsl:with-param>
		 </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="template_id[.!='']">
		 <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_ID</xsl:with-param>
		    <xsl:with-param name="id">template_id</xsl:with-param>
		    <xsl:with-param name="value" select="template_id" />
		    <xsl:with-param name="override-displaymode">view</xsl:with-param>
		 </xsl:call-template>
	 </xsl:if>
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
     
     <!-- Amendment Date -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>
      <xsl:with-param name="name">amd_date</xsl:with-param>
      <xsl:with-param name="value" select="amd_date" />
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">amd_no</xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$displaymode='view'">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">amd_date</xsl:with-param>
      </xsl:call-template>
     </xsl:if>

     <!-- EC Tenor Details -->
     <xsl:call-template name="tenor-details"/>

     <!-- <xsl:call-template name="drawer-details"/> -->
    </div>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template> 
 
 <!-- EC Amend Amount Details -->
 <xsl:template name="ec-amend-amt-details">
  	<xsl:param name="show-os-amt">N</xsl:param>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_EC_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">ec</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name">org_ec_amt</xsl:with-param>
      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
      <xsl:with-param name="override-amt-value"><xsl:value-of select="org_previous_file/ec_tnx_record/ec_amt"/></xsl:with-param>
     </xsl:call-template>
    
     <!-- Increase / Decrease Amt -->
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_INC_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">ec</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name">inc_amt</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_DEC_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">ec</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name">dec_amt</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_EC_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">ec</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="amt-readonly">N</xsl:with-param>  <!-- MPS-63496 -->
     </xsl:call-template>
     <xsl:if test="$show-os-amt='Y'">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="name">ec_liab_amt</xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="org_previous_file/ec_tnx_record/ec_cur_code"/>&nbsp;<xsl:value-of select="org_previous_file/ec_tnx_record/ec_liab_amt"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_ec_liab_amt</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="org_previous_file/ec_tnx_record/ec_liab_amt"/></xsl:with-param>  
      </xsl:call-template>
     </xsl:if>
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
     <xsl:with-param name="show-entity-button">N</xsl:with-param>
     <xsl:with-param name="readonly">Y</xsl:with-param>
     <xsl:with-param name="prefix">drawer</xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
      
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_DRAWEE_DETAILS</xsl:with-param>
   <xsl:with-param name="legend-type">indented-header</xsl:with-param>
   <xsl:with-param name="button-type">drawee</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="address">
     <xsl:with-param name="show-country">Y</xsl:with-param>
     <xsl:with-param name="show-reference">Y</xsl:with-param>
     <xsl:with-param name="readonly">Y</xsl:with-param>
     <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
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
       <xsl:with-param name="value">03</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">fileActIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="e2ee_transaction"/>
      <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
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
    <xsl:with-param name="value" select="name"/>
    <xsl:with-param name="button-type"><xsl:value-of select="$prefix"/></xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
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
   <xsl:call-template name="input-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_4</xsl:with-param>
    <xsl:with-param name="value" select="address_line_4"/>
   </xsl:call-template>
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
<!--  -->  
<!-- END LOCAL TEMPLATES FOR THIS FORM -->
<!--  -->

</xsl:stylesheet>