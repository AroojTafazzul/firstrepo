<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for general trade messages, customer side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"    
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
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  
  <!-- These params are empty for trade message -->
  <xsl:param name="realform-action"/>
  <xsl:param name="product-code">LS</xsl:param>

  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />

  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <xsl:apply-templates/>
  </xsl:template>
  
  <!--
   LS MESSAGE
   -->
  <xsl:template match="ls_tnx_record">
   <xsl:variable name="product-code"><xsl:value-of select="product_code"/></xsl:variable>
   <!-- Lower case product code -->
   <xsl:variable name="lowercase-product-code">
    <xsl:value-of select="translate($product-code,$up,$lo)"/>
   </xsl:variable>

   <xsl:variable name="screen-name">LicenseScreen</xsl:variable>
   <xsl:variable name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$screen-name"/></xsl:variable>
  
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
       <xsl:with-param name="screen-name" select="$screen-name"/>
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
      <xsl:call-template name="general-details"/>
      <xsl:call-template name="message-freeformat">
        <xsl:with-param name="legend-id">free_format_msg</xsl:with-param>
      </xsl:call-template>
      <xsl:if test="tnx_stat_code[.!='03' and .!='04']">   <!-- MPS-43899 -->
      <xsl:call-template name="comments-for-return">
	  	<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	  	<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
   	  </xsl:if>
     </xsl:with-param>
    </xsl:call-template>
    
    <!-- Form #1 : Attach Files -->
   <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED') or ($displaymode != 'edit' and $mode = 'VIEw')">
       <xsl:call-template name="attachments-file-dojo"/>
    </xsl:if>
    <!-- Message realform. -->
    <xsl:call-template name="realform">
     <xsl:with-param name="action" select="$action"/>
    </xsl:call-template>
    
    
    <!-- Reauthentication -->
	<xsl:call-template name="reauthentication"/> 

	

    <xsl:call-template name="menu">
     <xsl:with-param name="node-name" select="name(.)"/>
     <xsl:with-param name="screen-name" select="$screen-name"/>
     <xsl:with-param name="show-template">N</xsl:with-param>
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
    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
   </xsl:call-template>

   <!-- Javascript and Dojo imports  -->
   <xsl:call-template name="js-imports"> 
    <xsl:with-param name="product-code"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="lowercase-product-code"><xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
    <xsl:with-param name="action"><xsl:value-of select="$action"/></xsl:with-param>
    <xsl:with-param name="override-help-access-key">LS_02</xsl:with-param>
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
    <xsl:with-param name="binding">misys.binding.trade.message_ls</xsl:with-param>
    <xsl:with-param name="override-product-code" select="$product-code"/>
    <xsl:with-param name="override-lowercase-product-code" select="$lowercase-product-code"/>
    <xsl:with-param name="override-action" select="$action"/>
   <xsl:with-param name="override-help-access-key"><xsl:value-of select="$product-code"/>_02</xsl:with-param>
   </xsl:call-template>
   
  </xsl:template>

  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <xsl:param name="lowercase-product-code"/>  
   <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="show-type">N</xsl:with-param>
    <xsl:with-param name="show-tnx-amt">N</xsl:with-param>
   </xsl:call-template>
   <div class="widgetContainer">
   <xsl:call-template name="localization-dialog"/>
    <xsl:if test="$displaymode='edit'">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">prod_stat_code</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="prod_stat_code"/></xsl:with-param>
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
    
    <!-- Displaying the bank details. -->
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
      <xsl:with-param name="value" select="issuing_bank/abbv_name"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">issuing_bank_name</xsl:with-param>
      <xsl:with-param name="value" select="issuing_bank/name"/>
     </xsl:call-template> 
    
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">ls_cur_code</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="ls_cur_code" /></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">ls_amt</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="org_ls_amt" /></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">additional_amt</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="org_add_amt" /></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">total_amt</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="org_total_amt" /></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">ls_liab_amt</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="org_liab_amt" /></xsl:with-param>
    </xsl:call-template>
    
    <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">reason_for_cancellation</xsl:with-param>
      <xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_REASON_FOR_CANCELLATION')"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">message_free_format</xsl:with-param>
      <xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_HEADER_FREE_FORMAT')"/>
     </xsl:call-template> 
    
   </div>
  </xsl:template>
  
  <!-- 
   General Details
   -->
  <xsl:template name="general-details">
   <xsl:call-template name="message-general-details">
    <xsl:with-param name="additional-details">
      <xsl:call-template name="input-field">
		   <xsl:with-param name="label">XSL_LICENSE_NUMBER</xsl:with-param>
		   <xsl:with-param name="id">ls_number_view</xsl:with-param>
		   <xsl:with-param name="value" select="ls_number" />
		   <xsl:with-param name="override-displaymode">view</xsl:with-param>
	  </xsl:call-template>
		
	  <xsl:call-template name="input-field">
		   <xsl:with-param name="label">XSL_AUTH_REFERENCE</xsl:with-param>
		   <xsl:with-param name="id">auth_reference_view</xsl:with-param>
		   <xsl:with-param name="value" select="auth_reference" />
		   <xsl:with-param name="override-displaymode">view</xsl:with-param>
	  </xsl:call-template>
		
	  <xsl:call-template name="input-field">
		   <xsl:with-param name="label">XSL_GENERALDETAILS_REG_DATE</xsl:with-param>
		   <xsl:with-param name="id">reg_date_view</xsl:with-param>
		   <xsl:with-param name="value" select="reg_date"/>
		   <xsl:with-param name="override-displaymode">view</xsl:with-param>
	  </xsl:call-template>
		
  	  <xsl:call-template name="select-field">
         <xsl:with-param name="label">XSL_GENERALDETAILS_MESSAGE_TYPE</xsl:with-param>
         <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <xsl:with-param name="fieldsize">medium</xsl:with-param>
         <xsl:with-param name="options">
          <xsl:choose>
           <xsl:when test="$displaymode='edit' and ($option = 'ACTION_REQUIRED' or sub_tnx_type_code[.='66' or .='67'])">
            <option value="66">
             <xsl:value-of select="localization:getDecode($language, 'N003', '66')"/>
            </option>
            <option value="67">
             <xsl:value-of select="localization:getDecode($language, 'N003', '67')"/>
            </option>
            </xsl:when>
           <xsl:when test="$displaymode='edit' and $option != 'ACTION_REQUIRED'">
            <option value="24">
             <xsl:value-of select="localization:getDecode($language, 'N003', '24')"/>
            </option>
            <xsl:if test="is_settlement_valid[.='Y']">
            <option value="25">
             <xsl:value-of select="localization:getDecode($language, 'N003', '25')"/>
            </option>
            </xsl:if>
            <option value="65">
             <xsl:value-of select="localization:getDecode($language, 'N003', '65')"/>
            </option>
            <option value="96">
             <xsl:value-of select="localization:getDecode($language, 'N003', '96')"/>
            </option>
           </xsl:when>
           <xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/></xsl:otherwise>
          </xsl:choose>
         </xsl:with-param>
      </xsl:call-template>
       <div id="settlement-details" style="display:none">
       <xsl:call-template name="currency-field">
	        <xsl:with-param name="label">XSL_AMOUNTDETAILS_LS_SETTLEMENT_AMT_LABEL</xsl:with-param>
	        <xsl:with-param name="product-code"><xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
	        <xsl:with-param name="override-currency-name">ls_cur_code</xsl:with-param>
	        <xsl:with-param name="override-amt-name">ls_settlement_amt</xsl:with-param>
	        <xsl:with-param name="show-button">N</xsl:with-param>
	        <xsl:with-param name="currency-readonly">Y</xsl:with-param>
	        <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	    </xsl:call-template>
	    <xsl:call-template name="currency-field">
	        <xsl:with-param name="label">XSL_AMOUNTDETAILS_ADD_SETTLEMENT_AMT_LABEL</xsl:with-param>
	        <xsl:with-param name="product-code"><xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
	        <xsl:with-param name="override-currency-name">ls_cur_code</xsl:with-param>
	        <xsl:with-param name="override-amt-name">add_settlement_amt</xsl:with-param>
	        <xsl:with-param name="show-button">N</xsl:with-param>
	        <xsl:with-param name="currency-readonly">Y</xsl:with-param>
	        <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	    </xsl:call-template>
       	<xsl:call-template name="currency-field">
	        <xsl:with-param name="label">XSL_AMOUNTDETAILS_TOTAL_SETTLEMENT_AMT_LABEL</xsl:with-param>
	        <xsl:with-param name="product-code"><xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
	        <xsl:with-param name="override-currency-name">ls_cur_code</xsl:with-param>
	        <xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param>
	        <xsl:with-param name="show-button">N</xsl:with-param>
	        <xsl:with-param name="currency-readonly">Y</xsl:with-param>
	        <xsl:with-param name="amt-readonly">Y</xsl:with-param>
	        <xsl:with-param name="required">Y</xsl:with-param>
	        <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	    </xsl:call-template>
       </div>
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
    	<xsl:with-param name="name">fileActIds</xsl:with-param>
      	<xsl:with-param name="value"/>
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