<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################

 Phrase Screen, System Form.

Copyright (c) 2000-20011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      26/04/11
author:    Pascal Marzin
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		exclude-result-prefixes="localization">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="action"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
<!--  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/CustomerSystemFeaturesScreen</xsl:param>-->
  <xsl:param name="productcode"/>
  
  <!-- 
  <xsl:param name="fields"/>
  <xsl:param name="formname"/>
  -->  	
   
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  <xsl:include href="../common/file_upload_widgets.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
	<xsl:apply-templates select="account_balance"/>
  </xsl:template>
  
  <xsl:template match="account_balance">
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
      <xsl:call-template name="account-details"/>
      
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
		<xsl:with-param name="binding">misys.binding.system.account_management</xsl:with-param>
		<xsl:with-param name="xml-tag-name">account_management</xsl:with-param>
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
    <xsl:with-param name="name">owner_type</xsl:with-param>
   </xsl:call-template>
    <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">format</xsl:with-param>
   </xsl:call-template>
    <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">type</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_name</xsl:with-param>
   </xsl:call-template>
    <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">bank_abbv_name</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">account_id</xsl:with-param>
   </xsl:call-template>
<!--   <xsl:call-template name="hidden-field">-->
<!--    <xsl:with-param name="name">country</xsl:with-param>-->
<!--   </xsl:call-template>-->
<!--   <xsl:call-template name="hidden-field">-->
<!--    <xsl:with-param name="name">bank_name</xsl:with-param>-->
<!--   </xsl:call-template>-->
<!--   <xsl:call-template name="hidden-field">-->
<!--    <xsl:with-param name="name">iso_code</xsl:with-param>-->
<!--   </xsl:call-template>-->
  </div>
 </xsl:template>
 
 <!--
  Main Details of the Bank 
  -->
 <xsl:template name="account-details">
   
   <xsl:call-template name="fieldset-wrapper">
    	<xsl:with-param name="legend">XSL_SYSTEMFEATURES_ACCOUNT_DETAILS</xsl:with-param>
    	<xsl:with-param name="content">
    		<!-- Active Flag -->
			<xsl:call-template name="checkbox-field">
				<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACTIVE_FLAG_LABEL</xsl:with-param>
				<xsl:with-param name="name">actv_flag</xsl:with-param>
				<xsl:with-param name="id">actv_flag</xsl:with-param>
				<xsl:with-param name="value">01</xsl:with-param>
				<xsl:with-param name="disabled">Y</xsl:with-param>
				<xsl:with-param name="checked"><xsl:if test="actv_flag[. = 'Y']">Y</xsl:if></xsl:with-param>
			</xsl:call-template>
			<!-- Account Number -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_NO</xsl:with-param>
				<xsl:with-param name="name">account_no</xsl:with-param>
				<xsl:with-param name="size">34</xsl:with-param>
				<xsl:with-param name="disabled">Y</xsl:with-param>
				<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('ACCOUNT_NUMBER_LENGTH')"/></xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			<!-- Account Name -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_NAME</xsl:with-param>
				<xsl:with-param name="name">account_name</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="name"/></xsl:with-param>
				<xsl:with-param name="size">34</xsl:with-param>
				<xsl:with-param name="maxsize">34</xsl:with-param>
				<xsl:with-param name="disabled">Y</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			<!-- Description -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_DESCRIPTION</xsl:with-param>
				<xsl:with-param name="name">description</xsl:with-param>
				<xsl:with-param name="size">34</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="disabled">Y</xsl:with-param>
				<xsl:with-param name="maxsize">34</xsl:with-param>
			</xsl:call-template>
			<!-- Account currency -->
     		<xsl:call-template name="currency-field">
			    <xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_CURRENCY</xsl:with-param>
			    <xsl:with-param name="product-code">currency</xsl:with-param>
			    <xsl:with-param name="override-currency-value"><xsl:value-of select="cur_code"/></xsl:with-param>
			    <xsl:with-param name="override-amt-displaymode">N</xsl:with-param>
			    <xsl:with-param name="currency-readonly">Y</xsl:with-param>
			    <xsl:with-param name="show-button">N</xsl:with-param>
			    <xsl:with-param name="required">Y</xsl:with-param>
		   	</xsl:call-template>
    	</xsl:with-param>
    </xsl:call-template>
   
   <xsl:call-template name="attachments-file-dojo">
    	<xsl:with-param name="attachment-group">OTHER</xsl:with-param>
    	<xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD_MT940</xsl:with-param>
    	<xsl:with-param name="max-files">1</xsl:with-param>
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
       <xsl:with-param name="value">SAVE_UPLOAD_ACCOUNT</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">OTHER_ACCOUNT_MAINTENANCE</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">companyid</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="company_id"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">accountid</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="account_id"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <!-- 
      <xsl:if test="$formname != ''">
		<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">formname</xsl:with-param>
       		<xsl:with-param name="value"/>
      	</xsl:call-template>	
	  </xsl:if>	
	  <xsl:if test="$fields != ''">
	  	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">fields</xsl:with-param>
       		<xsl:with-param name="value"/>
      	</xsl:call-template>	
	  </xsl:if>			
	  <xsl:if test="$productcode != '' ">
		  <xsl:call-template name="hidden-field">
	   		<xsl:with-param name="name">productcode</xsl:with-param>
       		<xsl:with-param name="value"/>
      	  </xsl:call-template>	
	  </xsl:if>
	  -->
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
  <!--
    Account Type options.
   -->
  <xsl:template name="accountType-options">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="01">
      	<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_TYPE_INTRA')"/>
     </option>
     <option value="02">
      	<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_TYPE_EXTER')"/>
     </option>
     <option value="03">
      	<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_TYPE_CARD')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:if test="format[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_FORMAT_BBAN')"/></xsl:if>
     <xsl:if test="format[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_FORMAT_IBAN')"/></xsl:if>
     <xsl:if test="format[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_FORMAT_UPIC')"/></xsl:if>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
</xsl:stylesheet>