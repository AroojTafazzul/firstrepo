<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Main Login Page.

Copyright (c) 2000-2013 Misys (http://www.misys.com),
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
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">loginFormQA</xsl:param>
  <xsl:param name="password_mimimum_length"/>
  <xsl:param name="password_maximum_length"/>
  <xsl:param name="password_charset"/>
  
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  
  <!-- Main Login Template -->
  <xsl:template match="/">
   <!-- Form #0 : Main Form -->
   <div id="formContainerQA">
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name" select="$main-form-name"/>
    <xsl:with-param name="action" select="$url"/>
    <xsl:with-param name="content">
    <div class="loginFormLarge"> 
      <div class="loginFormLargeHeader">
      	<span class="logo"></span>
      </div>
     <xsl:call-template name="hidden-fields"/>
     <xsl:call-template name="user_questions"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
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
  <xsl:for-each select="reset_password_page/question_number"> 
   <xsl:variable name="count" select="position()"/>
   <xsl:call-template name="hidden-field">
   <xsl:with-param name="name">question_number_<xsl:value-of select="$count"/></xsl:with-param>
   <xsl:with-param name="value"><xsl:value-of select="." /></xsl:with-param>
   </xsl:call-template>
  </xsl:for-each>
  
  <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
  </xsl:call-template>
 </div>
 </xsl:template>

 <xsl:template name="user_questions">
 <div id="changePasswordQA">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">QUESTION_FOR_PASSWORD_RESET</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">LOGIN_COMPANYMSG</xsl:with-param>
     <xsl:with-param name="name">company</xsl:with-param>
     <xsl:with-param name="size">12</xsl:with-param>
     <xsl:with-param name="maxsize">35</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="swift-validate">N</xsl:with-param>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">LOGIN_USERNAMEMSG</xsl:with-param>
     <xsl:with-param name="name">username</xsl:with-param>
     <xsl:with-param name="size">12</xsl:with-param>
     <xsl:with-param name="maxsize">32</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="swift-validate">N</xsl:with-param>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="fact-question"></xsl:call-template>
    <xsl:call-template name="opinion-question"></xsl:call-template>
    <xsl:call-template name="row-wrapper">
     <xsl:with-param name="id">submit</xsl:with-param>
     <xsl:with-param name="content">
      <button dojoType="dijit.form.Button" name="clear" id="clear" type="clear" onclick="misys.clearFields();"><xsl:value-of select="localization:getGTPString($language, 'CLEAR')"/></button>
      <button dojoType="dijit.form.Button" name="login" id="login" type="submit"><xsl:value-of select="localization:getGTPString($language, 'SUBMIT')"/></button>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
  </div>
 </xsl:template>
 
 <xsl:template name="opinion-question">
   <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend"></xsl:with-param>
   <xsl:with-param name="legend-type">intended-header</xsl:with-param>
   <xsl:with-param name="content">
  	   <xsl:for-each select="reset_password_page/opinion_question"> 
  	    <xsl:variable name="count" select="position()"/>
        <xsl:call-template name="input-field">
        <xsl:with-param name="override-label"><xsl:value-of select="." /></xsl:with-param>
        <xsl:with-param name="name">answer_<xsl:value-of select="$count"/></xsl:with-param>
        <xsl:with-param name="size">50</xsl:with-param>
        <xsl:with-param name="maxsize">255</xsl:with-param>
        <xsl:with-param name="fieldsize">large</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">question_<xsl:value-of select="$count"/></xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="." /></xsl:with-param>
       </xsl:call-template>
      </xsl:for-each>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">totalopinionquestions</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="reset_password_page/total_questions" /></xsl:with-param>
      </xsl:call-template>
   
   </xsl:with-param>
   </xsl:call-template>

 </xsl:template>
 
 <xsl:template name="fact-question">
 <div>
 <table>
   <xsl:for-each select="reset_password_page/fact_questions"> 
   <xsl:variable name="count" select="position()"/>
    <tr>
       <td class="label" align="right">
       <xsl:value-of select="localization:getGTPString($language, 'N048_*')"/>
       <xsl:value-of select="question"></xsl:value-of></td>
       <td>
      	<xsl:element name="input">
 	     <xsl:attribute name="type">radio</xsl:attribute>
 	     <xsl:attribute name="name">option_<xsl:value-of select="$count"/></xsl:attribute>
 	     <xsl:attribute name="id">option_a_<xsl:value-of select="$count"/></xsl:attribute>
 	     <xsl:attribute name="value"><xsl:value-of select="option_a"/></xsl:attribute>
	     <xsl:attribute name="dojoType">dijit.form.RadioButton</xsl:attribute>
	     <xsl:attribute name="checked">true</xsl:attribute>
       </xsl:element>
       </td>
       <td style="margin-right:2px;"><xsl:value-of select="option_a"></xsl:value-of></td>
        <td>
      	<xsl:element name="input">
 	     <xsl:attribute name="type">radio</xsl:attribute>
 	     <xsl:attribute name="name">option_<xsl:value-of select="$count"/></xsl:attribute>
 	     <xsl:attribute name="id">option_b_<xsl:value-of select="$count"/></xsl:attribute>
 	     <xsl:attribute name="value"><xsl:value-of select="option_b"/></xsl:attribute>
	     <xsl:attribute name="dojoType">dijit.form.RadioButton</xsl:attribute>
       </xsl:element>
       </td>
       <td style="margin-right:2px;"><xsl:value-of select="option_b"></xsl:value-of></td>
        <td>
      	<xsl:element name="input">
 	     <xsl:attribute name="type">radio</xsl:attribute>
 	     <xsl:attribute name="name">option_<xsl:value-of select="$count"/></xsl:attribute>
 	     <xsl:attribute name="id">option_c_<xsl:value-of select="$count"/></xsl:attribute>
 	     <xsl:attribute name="value"><xsl:value-of select="option_c"/></xsl:attribute>
	     <xsl:attribute name="dojoType">dijit.form.RadioButton</xsl:attribute>
       </xsl:element>
       </td>
       <td style="margin-right:2px;"><xsl:value-of select="option_c"></xsl:value-of></td>
    </tr>
    <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">question_number_fa_<xsl:value-of select="$count"/></xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="question_number_fa" /></xsl:with-param>
       </xsl:call-template>
    </xsl:for-each>
    <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">totalfactquestions</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="reset_password_page/total_fa_questions" /></xsl:with-param>
      </xsl:call-template>
 </table>
 </div>
 </xsl:template>
 
</xsl:stylesheet>