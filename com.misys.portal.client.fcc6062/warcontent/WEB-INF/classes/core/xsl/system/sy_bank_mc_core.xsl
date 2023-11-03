<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for : TO DO : CANCEL + PASSBACK ENTITY

 Bank Screen, System Form.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
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
  <xsl:param name="token"/>
  
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <xsl:apply-templates select="static_bank"/>
  </xsl:template>
  
  <xsl:template match="static_bank">
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
      <!-- Template in "system_common.xsl": same template as "sy_company.xsl" 
 		To deal with Main details (Tabs for SWIFT and POSTAL address) -->
 	  <xsl:call-template name="main-details"/>
 	  <!-- Template in "system_common.xsl": To deal with the password part -->
      <xsl:call-template name="initial-admin-password"/>
      <xsl:call-template name="bank-prefs"/>
      <xsl:call-template name="bank-other-details"/> 
      
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
   <xsl:with-param name="xml-tag-name">static_bank</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.bank</xsl:with-param>
   <xsl:with-param name="override-home-url">'/screen/BankSystemFeaturesScreen?option=BANK_ACCOUNT_MAINTENANCE'</xsl:with-param>
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
    <xsl:with-param name="name">company_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_group</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">owner_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">address_address_line_1</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="address_line_1"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">type</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">swift_address_address_line_1</xsl:with-param>
   </xsl:call-template>
 </div>
 </xsl:template>

  <!--
  Type and Preferences 
  -->
  <xsl:template name="bank-prefs">
<!--  	<xsl:variable name="current"><xsl:value-of select="language"/></xsl:variable>-->
  	<xsl:call-template name="fieldset-wrapper">
   	 <xsl:with-param name="legend">XSL_HEADER_TYPE_PREFERENCES_DETAILS</xsl:with-param>
   	 <xsl:with-param name="content">
	  <!-- Selection of the language -->
	  <xsl:call-template name="select-field">
     	<xsl:with-param name="label">XSL_JURISDICTION_LANGUAGE_LOCALE</xsl:with-param>
     	<xsl:with-param name="name">language</xsl:with-param>
     	<xsl:with-param name="value"><xsl:value-of select="language"/></xsl:with-param>
     	<xsl:with-param name="required">Y</xsl:with-param>
     	<xsl:with-param name="options">
	       <xsl:choose>
     	    <xsl:when test="$displaymode='edit'">
     	     <xsl:if test="string($languages) != ''">
	      	  <xsl:for-each select="$languages/languages/language">
	       		<xsl:variable name="optionLanguage"><xsl:value-of select="."/></xsl:variable>
	   			 <option>
	    		  <xsl:attribute name="value"><xsl:value-of select="$optionLanguage"/></xsl:attribute>
	    		  <xsl:value-of select="localization:getDecode($language, 'N061', $optionLanguage)"/>
	   			 </option>
	      	  </xsl:for-each>
	      	 </xsl:if>
	      	</xsl:when>
	        <xsl:otherwise>
	         <xsl:variable name="optionLanguage"><xsl:value-of select="language"/></xsl:variable>
     	     <xsl:value-of select="localization:getDecode($language, 'N061', $optionLanguage)"/>
	        </xsl:otherwise>
	       </xsl:choose>
     	</xsl:with-param>
    </xsl:call-template>
    		
    <!-- Selection of the currency: in "system_common.xsl" -->
    <xsl:call-template name="currency-template"/>
      		
  </xsl:with-param>
 </xsl:call-template>
</xsl:template>

 <!--
 Others Details 
  -->
  <xsl:template name="bank-other-details">
  	<xsl:call-template name="fieldset-wrapper">
   	 <xsl:with-param name="legend">XSL_HEADER_OTHER_DETAILS</xsl:with-param>
   	 <xsl:with-param name="content">
	  <xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_JURISDICTION_CONTACT_NAME</xsl:with-param>
		<xsl:with-param name="name">contact_name</xsl:with-param>
	  </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_JURISDICTION_PHONE</xsl:with-param>
       <xsl:with-param name="name">phone</xsl:with-param>
       <xsl:with-param name="size">32</xsl:with-param>
       <xsl:with-param name="maxsize">32</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
      	<xsl:with-param name="label">XSL_JURISDICTION_FAX</xsl:with-param>
      	<xsl:with-param name="name">fax</xsl:with-param>
      	<xsl:with-param name="size">32</xsl:with-param>
       	<xsl:with-param name="maxsize">32</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
      	<xsl:with-param name="label">XSL_JURISDICTION_TELEX</xsl:with-param>
      	<xsl:with-param name="name">telex</xsl:with-param>
      	<xsl:with-param name="size">32</xsl:with-param>
       	<xsl:with-param name="maxsize">32</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
      	<xsl:with-param name="label">XSL_JURISDICTION_BIC_CODE</xsl:with-param>
      	<xsl:with-param name="name">iso_code</xsl:with-param>
      	<xsl:with-param name="size">11</xsl:with-param>
       	<xsl:with-param name="maxsize">11</xsl:with-param>
        <xsl:with-param name="uppercase">Y</xsl:with-param>
        <xsl:with-param name="fieldsize">small</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
      	<xsl:with-param name="label">XSL_JURISDICTION_EMAIL</xsl:with-param>
      	<xsl:with-param name="name">email</xsl:with-param>
      	<xsl:with-param name="size">40</xsl:with-param>
       	<xsl:with-param name="maxsize">255</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
      	<xsl:with-param name="label">XSL_JURISDICTION_EMAIL</xsl:with-param>
      	<xsl:with-param name="name">web_address</xsl:with-param>
      	<xsl:with-param name="size">40</xsl:with-param>
       	<xsl:with-param name="maxsize">40</xsl:with-param>
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
       <xsl:with-param name="value"><xsl:value-of select="$option"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
      </xsl:call-template>
      <xsl:if test="company_id[.!='']">
      	<xsl:call-template name="hidden-field">
      		<xsl:with-param name="name">featureid</xsl:with-param>
      		<xsl:with-param name="value"><xsl:value-of select="abbv_name"/></xsl:with-param>
      	</xsl:call-template>
      </xsl:if>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
</xsl:stylesheet>