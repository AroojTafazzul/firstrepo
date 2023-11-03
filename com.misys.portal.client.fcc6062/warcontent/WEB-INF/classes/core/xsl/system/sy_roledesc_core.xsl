<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for : TO DO : CANCEL + PASSBACK ENTITY

 Phrase Screen, System Form.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      02/05/08
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
  <!-- <xsl:param name="languages"/>-->
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="action"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="productcode"/>
  <!-- 
  <xsl:param name="fields"/>
  <xsl:param name="formname"/>
  -->  	
	
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

  <xsl:template match="/">
	<xsl:apply-templates select="role_record/role"/>
  </xsl:template>
  
  <xsl:template match="role_record/role">
   <!-- Loading message  -->
   <xsl:call-template name="loading-message"/>
  
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="roledesc-details"/>
      
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
   <xsl:with-param name="xml-tag-name">role_record</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.role_desc</xsl:with-param>
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
    <xsl:with-param name="name">role_id</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="id"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">name</xsl:with-param>
   </xsl:call-template>
 </div>
 </xsl:template>
 
 <!--
  Main Details of the Bank 
  -->
 <xsl:template name="roledesc-details">
 	<div class="widgetContainer">
 	 <!-- Role Code -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_ROLE_CODE</xsl:with-param>
      <xsl:with-param name="name">name</xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     
     <!-- Role Description -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_ROLE_DESCRIPTION</xsl:with-param>
      <xsl:with-param name="name">role_description</xsl:with-param>
      <xsl:with-param name="size">99</xsl:with-param>
      <xsl:with-param name="maxsize">99</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
    </div> 
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
   <xsl:with-param name="action">
   		<xsl:choose>
			<xsl:when test="../company_type[.='03']"> <xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/CustomerSystemFeaturesScreen</xsl:when>
			<xsl:otherwise> <xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/BankSystemFeaturesScreen</xsl:otherwise>
		</xsl:choose>
   </xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">ROLE_MAINTENANCE</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">featureid</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="name"/></xsl:with-param>
      </xsl:call-template>
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>