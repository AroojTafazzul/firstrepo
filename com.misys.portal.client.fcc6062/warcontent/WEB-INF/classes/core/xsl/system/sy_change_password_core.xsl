<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for change password screen.

This screen will be used in case following cases
user logging in and the password expired
changing password from forgot password link.
and the first time login (Q&A functionality is not required) 

Password Change Screen without Q&A.

Copyright (c) 2000-2013 Misys (http://www.misys.com),
All Rights Reserved. 

author:    Raja Rao
email:     raja.rao@misys.com
##########################################################
-->
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"  
    xmlns:buildversion="xalan://com.misys.portal.Version"  
    exclude-result-prefixes="localization defaultresource">
  
  <!-- Global Parameters. -->
  <!-- These are used in the XSL, and to set global params in the JS -->
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="url"/>
  <xsl:param name="action"/>
  <xsl:param name="token"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">loginFormQA</xsl:param>
  <xsl:param name="password_mimimum_length"/>
  <xsl:param name="password_maximum_length"/>
  <xsl:param name="password_charset"/>
  	   <!-- common variable to use for cache bursting when manually providing js source -->
  <xsl:variable name="build_number"><xsl:value-of select="concat('?',buildversion:getBuildNumber())"/></xsl:variable>
  
  <!-- Global Imports. -->
  <xsl:include href="../../../core/xsl/common/system_common.xsl"/>
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  
  <!-- Main Login Template -->
  <xsl:template match="/">
   <!-- Form #0 : Main Form -->
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name" select="$main-form-name"/>
    <xsl:with-param name="action" select="$url"/>
    <xsl:with-param name="onsubmit">
    	<xsl:choose>
			<xsl:when test="defaultresource:getResource('ENABLE_CLIENT_SIDE_ENCRYPTION') = 'true'">return misys.encryptBeforeSubmit();</xsl:when>
			<xsl:otherwise>return misys.onFormSubmit();</xsl:otherwise>
		</xsl:choose>
	</xsl:with-param>
    <xsl:with-param name="content">
    <div id="loginFormChangePassword" class="loginFormSmall">
     <xsl:call-template name="hidden-fields"/>
     <xsl:call-template name="change-password-fields"/>
    </div>
    </xsl:with-param>
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
  <script type="text/javascript">
   	dojo.ready(function(){
 		dojo.require("misys.binding.system.reset_password");
 	});
  </script>
  <xsl:call-template name="client-side-pwdencryption"/>
 </xsl:template>
 
   <!-- Template for client side password encryption -->
<xsl:template name="client-side-pwdencryption">
 	<xsl:if test="defaultresource:getResource('ENABLE_CLIENT_SIDE_ENCRYPTION') = 'true'">
 	<xsl:call-template name="security-encryption-keys"/>
 	<div class="widgetContainer">
 	 	<xsl:call-template name="hidden-field">
    		<xsl:with-param name="name">clientSideEncryption</xsl:with-param>
    		<xsl:with-param name="value">Y</xsl:with-param>
   		</xsl:call-template>     
   	</div>
			<xsl:call-template name="security-pwd-encryption-js-imports"/>
			<script>
		dojo.ready(function(){
				dojo.mixin(misys, {
					encryptBeforeSubmit : function(){
						return misys.beforeSubmitEncryption();												
					},
					beforeSubmitValidations : function(){
						return misys.encryptBeforeSubmit();
					},
					encrypt : function(passPhrase){
						return misys.encryptText(passPhrase);
   	    	 		}
				});
			});
			</script>
		</xsl:if>
	</xsl:template>
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
 <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
  </xsl:call-template>
  </div>
 </xsl:template>
 
 <!--
  Login Fields 
  -->
 <xsl:template name="change-password-fields">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">CHANGE_PASSWORD</xsl:with-param>
   <xsl:with-param name="content">
   <div id="changePassword">
    <xsl:call-template name="input-field">
	     <xsl:with-param name="label">LOGIN_COMPANYMSG</xsl:with-param>
	     <xsl:with-param name="name">company</xsl:with-param>
	     <xsl:with-param name="size">12</xsl:with-param>
	     <xsl:with-param name="maxsize">35</xsl:with-param>
	     <xsl:with-param name="required">Y</xsl:with-param>
	     <xsl:with-param name="fieldsize">small</xsl:with-param>
	     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    	 <xsl:with-param name="swift-validate">N</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">LOGIN_USERNAMEMSG</xsl:with-param>
     <xsl:with-param name="name">username</xsl:with-param>
     <xsl:with-param name="size">12</xsl:with-param>
     <xsl:with-param name="maxsize">32</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="swift-validate">N</xsl:with-param>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_PASSWORD</xsl:with-param>
      <xsl:with-param name="id">password_value</xsl:with-param>
      <xsl:with-param name="name">password_value</xsl:with-param>
      <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('PASSWORD_MAXIMUM_LENGTH')"/></xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="type">password</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
    
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_CONFIRM_PASSWORD</xsl:with-param>
      <xsl:with-param name="id">password_confirm</xsl:with-param>
      <xsl:with-param name="name">password_confirm</xsl:with-param>
      <xsl:with-param name="type">password</xsl:with-param>
      <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('PASSWORD_MAXIMUM_LENGTH')"/></xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
    <xsl:call-template name="row-wrapper">
     <xsl:with-param name="id">submit</xsl:with-param>
     <xsl:with-param name="content">
      <button dojoType="dijit.form.Button" name="login" id="login" type="submit"><xsl:value-of select="localization:getGTPString($language, 'SUBMIT')"/></button>
     </xsl:with-param>
    </xsl:call-template>
    </div>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
</xsl:stylesheet>