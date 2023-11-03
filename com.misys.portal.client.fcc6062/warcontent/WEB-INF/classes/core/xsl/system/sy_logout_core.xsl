<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Logout Screen.

Copyright (c) 2000-2012 Misys (http://www.misys.com),
All Rights Reserved. 

##########################################################
-->
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    exclude-result-prefixes="localization defaultresource">
  
  <!-- Global Parameters. -->
  <!-- These are used in the XSL, and to set global params in the JS -->
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="url"/>
  <xsl:param name="action"/>
  <xsl:param name="nextscreen"/>
  <xsl:param name="mode"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="angularMode"><xsl:value-of select="defaultresource:getResource('ANGULAR_HOMEPAGE')" /></xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">loginFormQA</xsl:param>
  <xsl:param name="homeAction"/>
  <xsl:param name="loginTime"/>
  <xsl:param name="logoutTime"/>
  <xsl:param name="duration"/>
  <xsl:param name="loginDetails"/>
  
  
  <!-- Global Imports. -->
  <xsl:include href="../../../core/xsl/common/system_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  
  <!-- Main Login Template -->
  <xsl:template match="/">
   <div id="formContainerQA">
     <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="action" select="$url"/>
     <xsl:with-param name="method">post</xsl:with-param>
     <xsl:with-param name="content">
     <div class="loginFormLarge">
      <!-- <div class="loginFormLargeHeader">
      	<span class="logo"></span>
      </div> -->
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="logoutContent"/>
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
 		dojo.require("dojo.parser");
    	dojo.require("dijit.form.Form");
    	dojo.require("dijit.form.Button");
    	dojo.require("dijit.form.TextBox");
 	});
  
  </script>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">nextscreen</xsl:with-param>
    <xsl:with-param name="value" select="$nextscreen"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">mode</xsl:with-param>
    <xsl:with-param name="value" select="$mode"/>
   </xsl:call-template>
  </div>
 </xsl:template>
 
 <!--
  Logout actual content
  -->
 <xsl:template name="logoutContent">
  <xsl:call-template name="fieldset-wrapper">
   <!-- <xsl:with-param name="legend">SY_TERMS_CONDITION</xsl:with-param> -->
   <xsl:with-param name="content">
   
       <div id="changePasswordQA">
        
        <div class="logoutHeade1"><xsl:value-of select="localization:getGTPString($language, 'XSL_LOGOUT_HEADER_1')"/></div>
        <div class="logoutHeade2"><xsl:value-of select="localization:getGTPString($language, 'XSL_LOGOUT_HEADER_2')"/></div>
        
        <xsl:if test="$loginDetails = 'true'">
    	    <div class="logoutTableContainer">
    	    	<table class="logoutTable">
    	    		<tr class="tableHeadLogout">
    	    			<td><xsl:value-of select="localization:getGTPString($language, 'XSL_LOGIN_COLUMN')"/></td>
    	    			<td><xsl:value-of select="localization:getGTPString($language, 'XSL_LOGOUT_COLUMN')"/></td>
    	    			<td><xsl:value-of select="localization:getGTPString($language, 'XSL_DURATION_COLUMN')"/></td>
    	    		</tr>
    	    		<tr>
    	    			<td><xsl:value-of select="$loginTime"/></td>
    	    			<td><xsl:value-of select="$logoutTime"/></td>
    	    			<td><xsl:value-of select="$duration"/></td>
    	    		</tr>
    	    	</table>
    	    </div>
        </xsl:if>
        
        <div class="logoutContent1"><xsl:value-of select="localization:getGTPString($language, 'XSL_LOGOUT_CONTENT_1')" disable-output-escaping="yes"/></div>
        <div class="logoutContent2"><xsl:value-of select="localization:getGTPString($language, 'XSL_LOGOUT_CONTENT_2')" disable-output-escaping="yes"/></div>
        
        <!-- Back to login screen button -->
        <div class="goToHomePageButton">
        	<xsl:choose>
        		<xsl:when test="$angularMode = 'true'">
        			 <button dojoType="dijit.form.Button" name="goToHomeButton" id="goToHomeButton">
    	     			<xsl:attribute name="onClick">misys.post({action:'GTPLoginScreen', params : [{name:'commonToken', value:'$ajaxtoken'},{name:'dojologout', value:'true'}]})</xsl:attribute>
    	     			<xsl:value-of select="localization:getGTPString($language, 'XSL_GO_TO_HOME_PAGE_BUTTON')"/>
    	     		 </button>
        		</xsl:when>
        		<xsl:otherwise>
        			<button dojoType="dijit.form.Button" name="goToHomeButton" id="goToHomeButton">
    	     			<xsl:attribute name="onClick">document.location.href='<xsl:value-of select="$homeAction"/>';</xsl:attribute>
    	     			<xsl:value-of select="localization:getGTPString($language, 'XSL_GO_TO_HOME_PAGE_BUTTON')"/>
    	     		 </button>
        		</xsl:otherwise>
        	</xsl:choose>
         </div>
    	</div>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
</xsl:stylesheet>