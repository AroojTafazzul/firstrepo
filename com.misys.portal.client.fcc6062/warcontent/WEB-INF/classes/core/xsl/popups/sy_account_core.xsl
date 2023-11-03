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
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="action"/>
  <xsl:param name="token"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="productcode"/>
   
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

  <xsl:template match="/">
	<xsl:apply-templates select="static_account"/>
  </xsl:template>
  
  <xsl:template match="static_account">
   <div id="popupscreen">

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="account-details"/>
      
      <!--  Display common menu. -->
      <xsl:call-template name="popup-menu"/>
     
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="realform"/>
   </div>
  </xsl:template>

 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->

 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">brch_code</xsl:with-param>
    <xsl:with-param name="id">popup_brch_code</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_id</xsl:with-param>
    <xsl:with-param name="id">popup_company_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">account_id</xsl:with-param>
    <xsl:with-param name="id">popup_account_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_name</xsl:with-param>
    <xsl:with-param name="id">popup_company_name</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">country</xsl:with-param>
    <xsl:with-param name="id">popup_country</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">bank_name</xsl:with-param>
    <xsl:with-param name="id">popup_bank_name</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">iso_code</xsl:with-param>
    <xsl:with-param name="id">popup_iso_code</xsl:with-param>
   </xsl:call-template>
    <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	 <xsl:with-param name="id">popup_token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
  </div>
 </xsl:template>
 
 <!--
  Main Details of the Bank 
  -->
 <xsl:template name="account-details">
   <xsl:param name="productCode">
      <xsl:choose>
        <xsl:when test="not (productcode[.=''])"><xsl:value-of select="$productcode"/></xsl:when>
        <xsl:otherwise>*</xsl:otherwise>
      </xsl:choose>
    </xsl:param>
     
     <!--set account properties-->
	<xsl:variable name="company_name">
		<xsl:choose>
			<xsl:when test="company_name[.='']">
				<xsl:value-of select="static_company/name"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="company_name"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="address_line_1">
		<xsl:choose>
			<xsl:when test="address_line_1[.='']">
				<xsl:value-of select="static_company/address_line_1"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="address_line_1"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="address_line_2">
		<xsl:choose>
			<xsl:when test="address_line_2[.='']">
				<xsl:value-of select="static_company/address_line_2"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="address_line_2"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="dom">
		<xsl:choose>
			<xsl:when test="dom[.='']">
				<xsl:value-of select="static_company/dom"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="dom"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="country">
		<xsl:choose>
			<xsl:when test="country[.='']">
				<xsl:value-of select="static_company/country"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="country"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>	
	<xsl:variable name="bank_name">
		<xsl:value-of select="bank_name"/>
	</xsl:variable>	
	<xsl:variable name="iso_code">
		<xsl:value-of select="iso_code"/>
	</xsl:variable>	
     
     
 	<!-- Entity -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">OpenAddAccountCSF</xsl:with-param>
     <xsl:with-param name="content">
 	  <xsl:call-template name="entity-field">
       <xsl:with-param name="button-type">system-entity</xsl:with-param>
       <xsl:with-param name="required">
        <xsl:choose>
        <xsl:when test="count(entities)='1'">N</xsl:when>
        <xsl:otherwise>Y</xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
      </xsl:call-template>

    
 	 <!-- Account Number -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_NO</xsl:with-param>
      <xsl:with-param name="name">account_no</xsl:with-param>
      <xsl:with-param name="id">popup_account_no</xsl:with-param>
      <xsl:with-param name="size">34</xsl:with-param>
      <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('ACCOUNT_NUMBER_LENGTH')"/></xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
     
     <!-- Direction -->
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_TYPE</xsl:with-param>
      <xsl:with-param name="name">type</xsl:with-param>
      <xsl:with-param name="id">popup_type</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:call-template name="direction-options"/>
      </xsl:with-param>
     </xsl:call-template>
     
     <!-- Description -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_DESCRIPTION</xsl:with-param>
      <xsl:with-param name="name">description</xsl:with-param>
      <xsl:with-param name="id">popup_description</xsl:with-param>
      <xsl:with-param name="size">34</xsl:with-param>
      <xsl:with-param name="maxsize">34</xsl:with-param>
     </xsl:call-template>
     
     <!-- Account Type -->
     <xsl:call-template name="select-field">
     	<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_FORMAT</xsl:with-param>
     	<xsl:with-param name="name">format</xsl:with-param>
     	<xsl:with-param name="id">popup_format</xsl:with-param>
        <xsl:with-param name="fieldsize">small</xsl:with-param>
     	<xsl:with-param name="required">Y</xsl:with-param>
     	<xsl:with-param name="options">
     		<xsl:call-template name="accountType-options"/>
    	</xsl:with-param>
    </xsl:call-template>
    
    <!-- Address -->
    <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_ADDRESS</xsl:with-param>
      <xsl:with-param name="name">address_line_1</xsl:with-param>
      <xsl:with-param name="id">popup_address_line_1</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">address_line_2</xsl:with-param>
      <xsl:with-param name="id">popup_address_line_2</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">dom</xsl:with-param>
      <xsl:with-param name="id">popup_dom</xsl:with-param>
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
   <xsl:with-param name="id">popup_realform</xsl:with-param>
   <xsl:with-param name="method">POST</xsl:with-param>
   <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">popup_realform_operation</xsl:with-param>
       <xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="id">popup_option</xsl:with-param>
       <xsl:with-param name="value">ACCOUNTS_MAINTENANCE</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="id">popup_TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
   <!--
    Direction options.
   -->
  <xsl:template name="direction-options">
     <xsl:choose>
      <xsl:when test="$displaymode='edit'">
       <option value="01">
      	<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_TYPE_FLOW')"/>
       </option>
       <option value="02">
      	<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_TYPE_CREDIT')"/>
       </option>
       <option value="03">
      	<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_TYPE_CREDIT_FLOW')"/>
       </option>
      </xsl:when>
      <xsl:otherwise>
       <xsl:if test="type[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_TYPE_FLOW')"/></xsl:if>
       <xsl:if test="type[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_TYPE_CREDIT')"/></xsl:if>
       <xsl:if test="type[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_TYPE_CREDIT_FLOW')"/></xsl:if>
      </xsl:otherwise>
     </xsl:choose>
  </xsl:template>
  
  <!--
    Account Type options.
   -->
  <xsl:template name="accountType-options">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="01">
      	<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_FORMAT_BBAN')"/>
     </option>
     <option value="02">
      	<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_FORMAT_IBAN')"/>
     </option>
     <option value="03">
      	<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_FORMAT_UPIC')"/>
     </option>
     <option value="04">
      	<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_FORMAT_OTHER')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:if test="format[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_FORMAT_BBAN')"/></xsl:if>
     <xsl:if test="format[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_FORMAT_IBAN')"/></xsl:if>
     <xsl:if test="format[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_FORMAT_UPIC')"/></xsl:if>
     <xsl:if test="format[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_FORMAT_OTHER')"/></xsl:if>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
</xsl:stylesheet>