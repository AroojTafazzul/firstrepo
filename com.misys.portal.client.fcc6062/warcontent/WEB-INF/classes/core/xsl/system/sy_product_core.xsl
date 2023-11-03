<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 User Screen, System Form.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      29/04/08
author:    Laure Blin
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
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="languages"/>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="action"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="operation"/>

  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
    
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <xsl:apply-templates select="static_product"/>
  </xsl:template>
  
  <xsl:template match="static_product">
   <xsl:param name="productCode">
    <xsl:choose>
     <xsl:when test="not (productcode[.=''])"><xsl:value-of select="$productcode"/></xsl:when>
     <xsl:otherwise>*</xsl:otherwise>
    </xsl:choose>
   </xsl:param>
    
   <!--Define the nodeName variable for the current static data -->
   <xsl:variable name="nodeName"><xsl:value-of select="name(.)"/></xsl:variable>
  
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="product-details"/>
      
      <!--  Display common menu. -->
      <xsl:call-template name="system-menu"/>
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="realform"/>
   </div>

   <!-- Javascript imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>
  
 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
 
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="system-common-js-imports">
   <xsl:with-param name="binding">misys.binding.system.product</xsl:with-param>
   <xsl:with-param name="xml-tag-name">static_product</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">brch_code</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">product_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_id</xsl:with-param>
   </xsl:call-template>
 </div>
 </xsl:template>
 
 <!--
  Main Details of the Company 
  -->
 <xsl:template name="product-details">
 	 
 	 <!-- Entity -->
 	 <xsl:choose>
         <xsl:when test="entities">
		   	<xsl:call-template name="input-field">
    			<xsl:with-param name="button-type">entity</xsl:with-param>
    			<xsl:with-param name="label">XSL_JURISDICTION_ENTITY</xsl:with-param>
    			<xsl:with-param name="name">entity</xsl:with-param>
       			<xsl:with-param name="required">Y</xsl:with-param>
   			</xsl:call-template>
 		</xsl:when>
 		<xsl:otherwise>
            <xsl:call-template name="hidden-field">
    			<xsl:with-param name="name">entity</xsl:with-param>
    			<xsl:with-param name="value">*</xsl:with-param>
   			</xsl:call-template>
        </xsl:otherwise>
 	</xsl:choose>
 	
 	<!-- Code -->
    <xsl:call-template name="input-field">
    	<xsl:with-param name="label">XSL_SYSTEMFEATURES_PRODUCT_CODE</xsl:with-param>
      	<xsl:with-param name="name">code</xsl:with-param>
    	<xsl:with-param name="required">Y</xsl:with-param>
    </xsl:call-template>
    
    <!-- Content -->
    <xsl:call-template name="row-wrapper">
     <xsl:with-param name="id">description</xsl:with-param>
     <xsl:with-param name="label">XSL_SYSTEMFEATURES_PRODUCT_DESCRIPTION</xsl:with-param>
     <xsl:with-param name="type">textarea</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="textarea-field">
       <xsl:with-param name="name">description</xsl:with-param>
       <xsl:with-param name="rows">5</xsl:with-param>
       <xsl:with-param name="cols">50</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <!-- Necessary to avoid having a popup window linked to the textarea -->
       <xsl:with-param name="button-type"></xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
 	
 </xsl:template>
 

 <!-- 
  Realform
  -->
 <xsl:template name="realform">
  <!-- Do not display this section when the counterparty mode is 'counterparty' -->
  <xsl:if test="$collaborationmode != 'counterparty'">
  <xsl:call-template name="form-wrapper">
   <xsl:with-param name="name">realform</xsl:with-param>
   <xsl:with-param name="method">POST</xsl:with-param>
   <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">PRODUCTS_MAINTENANCE</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <!-- TO SEE -->
      <!-- 
      <xsl:if test="$formname != ''">
		<input type="hidden" name="formname" value="{$formname}"/>
	  </xsl:if>	
	  <xsl:if test="$fields != ''">
		<input type="hidden" name="fields" value="{$fields}"/>
	  </xsl:if>			
      <xsl:if test="$productCode != '' ">
        <input type="hidden" name="productcode">
          <xsl:attribute name="value">
            <xsl:value-of select="$productCode"/>
          </xsl:attribute>
        </input>
      </xsl:if>
      -->
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>