<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for main login page.

Main Login Page.

Copyright (c) 2000-2013 Misys (http://www.misys.com),
All Rights Reserved. 

author:    Raja Rao
email:     raja.rao@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:common="http://exslt.org/common"
    xmlns:jetspeedresources="xalan://com.misys.portal.core.util.JetspeedResources"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    exclude-result-prefixes="localization common jetspeedresources">
  
	<!-- Global Parameters. -->
	<!-- These are used in the XSL, and to set global params in the JS -->
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="languages"/>
	<xsl:param name="url"/>
	<xsl:param name="languageChangeUrl"/>
	<xsl:param name="action"/>
	<xsl:param name="displaymode">edit</xsl:param>
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	<xsl:param name="main-form-name">loginFormQA</xsl:param>
	<xsl:param name="screenName"><xsl:value-of select="jetspeedresources:getString('screen.login')" /></xsl:param>
	<xsl:param name="password_mimimum_length"/>
	<xsl:param name="password_maximum_length"/>
	<xsl:param name="password_charset"/>
	<xsl:param name="companyCaseSensitive"/>
	<xsl:param name="userCaseSensitive"/>

	<!-- Global Imports. -->
	<xsl:include href="../common/system_common.xsl"/>

	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  
	<!-- Main Login Template -->
	<xsl:template match="/">
		<!-- Form #0 : Main Form -->
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name" select="$main-form-name"/>
			<xsl:with-param name="action" select="$url"/>
			<xsl:with-param name="validating">Y</xsl:with-param>
			<!-- <xsl:with-param name="onsubmit">return misys.onFormSubmit();</xsl:with-param> -->
			<xsl:with-param name="content">
				<div id="loginForm" class="loginFormSmall"> 
					<xsl:call-template name="hidden-fields"/>
					<xsl:call-template name="linking-fields"/>
					<xsl:call-template name="languages"/>
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
		<script>dojoConfig = {async: true, parseOnLoad: true}</script>
		<script>		
		dojo.ready(function(){
			dojo.require("misys.binding.system.fb_sso_login");
			dojo.require("dijit.form.Select");
		});
		</script>
	</xsl:template>
 
	<!-- Additional hidden fields for this form are  -->
	<!-- added here. -->
	<xsl:template name="hidden-fields">
		<div class="widgetContainer">
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">userSelectedLanguage</xsl:with-param>
				<xsl:with-param name="value">
					<xsl:choose>
						<xsl:when test="login_page/user_selected_language != ''"><xsl:value-of select="login_page/user_selected_language"/></xsl:when>	
						<xsl:otherwise>en</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param> 
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
				<div id="login_fields">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">LOGIN_USERNAMEMSG</xsl:with-param>
						<xsl:with-param name="name">username</xsl:with-param>
						<xsl:with-param name="size">12</xsl:with-param>
						<xsl:with-param name="uppercase">
						<xsl:choose>
						<xsl:when test="$userCaseSensitive = 'true'">N</xsl:when>
						<xsl:otherwise>Y</xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="maxsize">32</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="fieldsize">small</xsl:with-param>
						<xsl:with-param name="swift-validate">N</xsl:with-param>
					</xsl:call-template>
					<input type="password" name="foilautofill" maxlength="25" value="" style="display:none; "/>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">LOGIN_PASSWORDMSG</xsl:with-param>
						<xsl:with-param name="id">password</xsl:with-param>
						<xsl:with-param name="name">password</xsl:with-param>
						<xsl:with-param name="size">12</xsl:with-param>
						<xsl:with-param name="maxsize">25</xsl:with-param>
						<xsl:with-param name="fieldsize">small</xsl:with-param>
						<xsl:with-param name="type">password</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>	
						<xsl:with-param name="swift-validate">N</xsl:with-param>
					</xsl:call-template>
				</div>	
				<div id="buttonsdiv">
					<button dojoType="dijit.form.Button" name="clear" id="clear" type="clear" onclick="misys.onFormClear()"><xsl:value-of select="localization:getGTPString($language, 'CLEAR')"/></button>
					<button dojoType="dijit.form.Button" name="login" id="login" type="submit"><xsl:value-of select="localization:getGTPString($language, 'LOGIN')"/></button>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
 
	<xsl:template name="languages">
		<!-- Only display the choice if there's more than one language node -->
		<xsl:if test="count(common:node-set($languages)/languages/language) > 1">
			<div id="loginLanguages">
				<xsl:choose>
				<xsl:when test="defaultresource:getResource('LANGUAGE_FLAGS_DISPLAY_ENABLED') = 'true' ">
					<div id="languageSelectionContainer" class="widgetContainer">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">path</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="$screenName"/></xsl:with-param>
							</xsl:call-template>
					<div id="languageSelection" class="dijit dijitReset dijitInlineTable dijitLeft small dijitTextBox dijitComboBox" dojoType="dijit.form.Select">
							<xsl:attribute  name="value">
								<xsl:choose>
										<xsl:when test="login_page/user_selected_language != ''"><xsl:value-of select="login_page/user_selected_language"/></xsl:when>	
										<xsl:otherwise>en</xsl:otherwise>
								</xsl:choose>		
							</xsl:attribute>
							<xsl:attribute name="class">small</xsl:attribute>
				        	<xsl:for-each select="common:node-set($languages)/languages/language">
				        	<span>
		        				<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
								<img>
									<xsl:attribute name="src"><xsl:value-of select="$contextPath"/>/content/mobile/content/images/flags/<xsl:value-of select="."/>.png</xsl:attribute>
									<xsl:attribute name="title"><xsl:value-of select="localization:getDecode($language, 'N061', .)"/></xsl:attribute>
								</img>&nbsp;&nbsp;<xsl:value-of select="localization:getDecode($language, 'N061', .)"/>
							</span>
							</xsl:for-each>
						</div>
					</div>	
				</xsl:when>
				<xsl:otherwise>						
					
						<div id="languageSelectionContainer" class="widgetContainer">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">path</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="$screenName"/></xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="select-field">
								<xsl:with-param name="name">languageSelection</xsl:with-param>
								<xsl:with-param name="fieldsize">small</xsl:with-param>
								<xsl:with-param name="value">
									<xsl:choose>
										<xsl:when test="login_page/user_selected_language != ''"><xsl:value-of select="login_page/user_selected_language"/></xsl:when>	
										<xsl:otherwise>en</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param> 
								<xsl:with-param name="options">
									<xsl:for-each select="common:node-set($languages)/languages/language">
										<option>
											<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
											<xsl:value-of select="localization:getDecode($language, 'N061', .)"/>
										</option>
									</xsl:for-each>
								</xsl:with-param>
							</xsl:call-template>
						</div>
				</xsl:otherwise>	
			</xsl:choose>
			</div>		
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>