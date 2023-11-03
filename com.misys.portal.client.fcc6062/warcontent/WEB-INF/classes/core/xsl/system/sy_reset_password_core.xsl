<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Main Login Page.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
##########################################################
-->
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    exclude-result-prefixes="localization">
  
  <!-- Global Parameters. -->
  <!-- These are used in the XSL, and to set global params in the JS -->
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="url"/>
  <xsl:param name="action"/>
  <xsl:param name="token"/>
  <xsl:param name="token-key"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">loginFormQA</xsl:param>
  <xsl:param name="password_mimimum_length"/>
  <xsl:param name="password_maximum_length"/>
  <xsl:param name="password_charset"/>
  
  
  <!-- Global Imports. -->
  <xsl:include href="../../../core/xsl/common/system_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  
  <!-- Main Login Template -->
  <xsl:template match="/">
   <!-- Form #0 : Main Form -->
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name" select="$main-form-name"/>
    <xsl:with-param name="action" select="$url"/>
    <xsl:with-param name="content">
    <div id="loginForm" class="loginFormSmall"> 
     <xsl:call-template name="hidden-fields"/>
     <xsl:call-template name="login-fields"/>
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
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
 <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
  </xsl:call-template>
   <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token-key</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token-key"/></xsl:with-param>
  </xsl:call-template>
  </div>
 </xsl:template>
 
 <!--
  Login Fields 
  -->
 <xsl:template name="login-fields">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">LOGIN</xsl:with-param>
    <xsl:with-param name="content">
	    <xsl:call-template name="input-field">
		     <xsl:with-param name="label">LOGIN_COMPANYMSG</xsl:with-param>
		     <xsl:with-param name="name">company</xsl:with-param>
		     <xsl:with-param name="size">12</xsl:with-param>
		     <xsl:with-param name="maxsize">35</xsl:with-param>
		     <xsl:with-param name="required">Y</xsl:with-param>
		     <xsl:with-param name="uppercase">Y</xsl:with-param>
		     <xsl:with-param name="fieldsize">small</xsl:with-param>
		     <xsl:with-param name="swift-validate">N</xsl:with-param>
	    </xsl:call-template>
	    <xsl:call-template name="input-field">
		     <xsl:with-param name="label">LOGIN_USERNAMEMSG</xsl:with-param>
		     <xsl:with-param name="name">username</xsl:with-param>
		     <xsl:with-param name="size">12</xsl:with-param>
		     <xsl:with-param name="maxsize">32</xsl:with-param>
		     <xsl:with-param name="required">Y</xsl:with-param>
		     <xsl:with-param name="uppercase">Y</xsl:with-param>
		     <xsl:with-param name="fieldsize">small</xsl:with-param>
		     <xsl:with-param name="swift-validate">N</xsl:with-param>
	    </xsl:call-template>
    <xsl:call-template name="row-wrapper">
     <xsl:with-param name="id">submit</xsl:with-param>
     <xsl:with-param name="content">
      <button dojoType="dijit.form.Button" name="clear" id="clear" type="clear" onclick="dijit.byId('username').set('value','');dijit.byId('company').set('value','');"><xsl:value-of select="localization:getGTPString($language, 'CLEAR')"/></button>
      <button dojoType="dijit.form.Button" name="login" id="login" type="submit"><xsl:value-of select="localization:getGTPString($language, 'SUBMIT')"/></button>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
</xsl:stylesheet>