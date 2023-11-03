<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for general trade messages, customer side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      09/08/12
author:    Raja Rao
email:     raja.rao@misys.com
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
  <xsl:template match="ec_tnx_record">
   <xsl:variable name="product-code"><xsl:value-of select="product_code"/></xsl:variable>
   <!-- Lower case product code -->
   <xsl:variable name="lowercase-product-code">
    <xsl:value-of select="translate($product-code,$up,$lo)"/>
   </xsl:variable>

   <xsl:variable name="screen-name">ExportCollectionScreen</xsl:variable>
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
      
      <xsl:call-template name="message-general-details">
      </xsl:call-template>
      
      <xsl:call-template name="message-freeformat"/>
      <xsl:if test="tnx_stat_code[.!='03' and .!='04']">   <!-- MPS-43899 -->
      <xsl:call-template name="comments-for-return">
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
   	  </xsl:if>
      
     </xsl:with-param>
    </xsl:call-template>
   
    <!-- Form #1 : Attach Files -->
     <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
    	<xsl:call-template name="attachments-file-dojo">
    	<xsl:with-param name="title-size">35</xsl:with-param>
    	</xsl:call-template>
    </xsl:if>

    <!-- Message realform. -->
    <xsl:call-template name="realform">
     <xsl:with-param name="action" select="$action"/>
    </xsl:call-template>
  
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
   
  <!-- Reauthentication -->
  <xsl:call-template name="reauthentication"/>   
   
   <!--  Collaboration Window -->     
   <xsl:call-template name="collaboration">
    <xsl:with-param name="editable">true</xsl:with-param>
    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    <xsl:with-param name="bank_name_widget_id">remitting_bank_name</xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id">remitting_bank_abbv_name</xsl:with-param>
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
    <xsl:with-param name="binding">misys.binding.trade.message_ec</xsl:with-param>
    <xsl:with-param name="override-product-code" select="$product-code"/>
    <xsl:with-param name="override-lowercase-product-code" select="$lowercase-product-code"/>
    <xsl:with-param name="override-action" select="$action"/>
    <xsl:with-param name="override-help-access-key">EC_02</xsl:with-param>
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
      <xsl:with-param name="value"></xsl:with-param>
     </xsl:call-template>
     <xsl:if test="entity and entity[.!='']">
	     <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">entity</xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
   
     <!--Empty the principal and fee accounts-->
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">principal_act_no</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">fee_act_no</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template>
    </xsl:if>

    <!-- Displaying the bank details. -->
    <xsl:choose>
     <xsl:when test="product_code[.='LC' or .='SG' or .='LI' or .='TF' or .='SI' or .='BG' or . = 'FX' or . = 'XO' or . = 'FA']">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
       <xsl:with-param name="value" select="issuing_bank/abbv_name"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">issuing_bank_name</xsl:with-param>
       <xsl:with-param name="value" select="issuing_bank/name"/>
      </xsl:call-template> 
     </xsl:when>
     <xsl:when test="product_code[.='EL' or .='SR' or .='BR']">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">advising_bank_abbv_name</xsl:with-param>
       <xsl:with-param name="value" select="advising_bank/abbv_name"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">advising_bank_name</xsl:with-param>
       <xsl:with-param name="value" select="advising_bank/name"/>
      </xsl:call-template> 
     </xsl:when>
     <xsl:when test="product_code[.='EC' or .='IR']">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">remitting_bank_abbv_name</xsl:with-param>
       <xsl:with-param name="value" select="remitting_bank/abbv_name"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">remitting_bank_name</xsl:with-param>
       <xsl:with-param name="value" select="remitting_bank/name"/>
      </xsl:call-template> 
     </xsl:when>
     <xsl:when test="product_code[.='IC']">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">presenting_bank_abbv_name</xsl:with-param>
       <xsl:with-param name="value" select="presenting_bank/abbv_name"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">presenting_bank_name</xsl:with-param>
       <xsl:with-param name="value" select="presenting_bank/name"/>
      </xsl:call-template> 
     </xsl:when>
    </xsl:choose>
    <xsl:if test="product_code[.='EC' or .='IC']">
     <xsl:for-each select="documents/document">
      <xsl:call-template name="hidden-document-fields"/>
     </xsl:for-each>
    </xsl:if>
    <!-- The currency code and amount -->
    <xsl:if test="product_code[.='EC']">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">fwd_contract_no</xsl:with-param>
     </xsl:call-template>
    </xsl:if>
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
      <xsl:call-template name="e2ee_transaction"/>
      <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- 
   Hidden Collection Document Details
  -->
  <xsl:template name="hidden-document-fields">
   <div>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_position_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="position()"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_document_id_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="document_id"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_code_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="code"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_name_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="name"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_first_mail_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="first_mail"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_second_mail_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="second_mail"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_total_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="total"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_mapped_attachment_name_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="mapped_attachment_name"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_mapped_attachment_id_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="mapped_attachment_id"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_doc_no_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="doc_no"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_doc_date_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="doc_date"/>
    </xsl:call-template>
   </div>
  </xsl:template>
</xsl:stylesheet>