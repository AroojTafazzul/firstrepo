<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for : 

 Authentication Screen, System Form.

Copyright (c) 2000-2013 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Laure Blin
##########################################################
-->
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization defaultresource">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="token"/>
  <xsl:param name="action"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  <xsl:include href="sy_jurisdiction.xsl"/>
  <xsl:include href="../common/e2ee_common.xsl" />
  <!-- 
  <xsl:include href="product_addons.xsl"/>
  -->
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <xsl:call-template name="sy_authentication"/>
  </xsl:template>
  
  <xsl:template name="sy_authentication">
   <!-- Loading message  -->
   <xsl:call-template name="loading-message"/>

   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="authentication-details"/>
      
      <!-- Password Template -->
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_PASSWORD_DETAILS</xsl:with-param>
       <xsl:with-param name="content">
       <xsl:call-template name="password-fields"/>
       	
       </xsl:with-param>
      </xsl:call-template>
      
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
   <xsl:with-param name="xml-tag-name">static_user</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.authentication</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
   <!-- Company only required on bank side, customer or maintenance -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">change_password</xsl:with-param>
    <xsl:with-param name="value">Y</xsl:with-param>
   </xsl:call-template>
 </div>
 </xsl:template>
 
 <!--
  Main Details of the Company 
  -->
 <xsl:template name="authentication-details">
	<!-- Display the User Details: in jurisdiction.xsl, also add some hidden-fields -->
	<xsl:apply-templates select="static_user" mode="display"/>
 </xsl:template>
 
 <xsl:template name="password-fields">
	<!-- Display the password fields -->

        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_JURISDICTION_PASSWORD</xsl:with-param>
         <xsl:with-param name="id">password_value</xsl:with-param>
         <xsl:with-param name="name"><xsl:if test="$isE2EEEnabled !='true'">password_value</xsl:if></xsl:with-param>
		 <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('PASSWORD_MAXIMUM_LENGTH')"/></xsl:with-param>
         <xsl:with-param name="type">password</xsl:with-param>
         <xsl:with-param name="fieldsize">small</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_JURISDICTION_CONFIRM_PASSWORD</xsl:with-param>
         <xsl:with-param name="id">password_confirm</xsl:with-param>
         <xsl:with-param name="name"><xsl:if test="$isE2EEEnabled !='true'">password_confirm</xsl:if></xsl:with-param>
   		<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('PASSWORD_MAXIMUM_LENGTH')"/></xsl:with-param>
         <xsl:with-param name="type">password</xsl:with-param>
         <xsl:with-param name="fieldsize">small</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param> 
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
       <xsl:with-param name="value"><xsl:value-of select="$option"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">featureid</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="static_user/login_id"/></xsl:with-param>
      </xsl:call-template>
      <xsl:if test="$option='CUSTOMER_USER_AUTHENTICATION_MAINTENANCE' or $option='BANK_AUTHENTICATION_MAINTENANCE' or $option='CUSTOMER_AUTHENTICATION_MAINTENANCE' or $option='BANK_USER_AUTHENTICATION_MAINTENANCE'">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">company</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="static_user/company_abbv_name"/></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">token</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="$token" /></xsl:with-param>
  		</xsl:call-template>
      <xsl:if test="company_id[.!='']">
      	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">featureid</xsl:with-param>
      		<xsl:with-param name="value">abbv_name</xsl:with-param>
      	</xsl:call-template>
      </xsl:if>
	  <xsl:call-template name="e2ee_transaction"/>      
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>