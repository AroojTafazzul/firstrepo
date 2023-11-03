<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for change password screen with questions to be 
answered by the user at the first time login.

These question and answers are used in case of 
forgot password (reset password).

Password Change Screen with Q&A.

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
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	exclude-result-prefixes="localization defaultresource">

	<!-- Global Parameters. -->
	<!-- These are used in the XSL, and to set global params in the JS -->
	<xsl:param name="languages"/>
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="url"/>
	<xsl:param name="action"/>
	<xsl:param name="token"/>
	<xsl:param name="redirect"/>
  	<xsl:param name="queryString"/>
  	<xsl:param name="nextscreen"/>
	<xsl:param name="mode"/>
	<xsl:param name="displaymode">edit</xsl:param>
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	<xsl:param name="main-form-name">loginFormQA</xsl:param>
	<xsl:param name="password_mimimum_length"/>
	<xsl:param name="password_maximum_length"/>
	<xsl:param name="password_charset"/>
	<xsl:param name="logoutAction"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
    <xsl:param name="noticeImage"><xsl:value-of select="$images_path"/>notice.png</xsl:param>
	
  
	<!-- Global Imports. -->
	<xsl:include href="../common/system_common.xsl"/>
  
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

	<!-- Main Login Template -->
	<xsl:template match="/">
		<div id="{$displaymode}">
			<div id="formContainerQA">
				<!-- Form #0 : Main Form -->
				<xsl:call-template name="form-wrapper">
					<xsl:with-param name="name" select="$main-form-name"/>
					<xsl:with-param name="action" select="$url"/>
					<xsl:with-param name="method">post</xsl:with-param>
					<xsl:with-param name="validating">N</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="browser-close-msg"/>
						<div class="loginFormLarge"> 
							<div class="loginFormLargeHeader">
								<span class="logo"></span>
							</div>
							<xsl:call-template name="browser-close-logout-button"/>
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</div>
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
				dojo.require("misys.binding.system.login");
			});
		 </script>
		<!-- for client side password encryption -->
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
 
	<!-- Change Password Fields -->
	<xsl:template name="browser-close-logout-button">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="content">
				<div id="browserExit">
					<div class="field">
						<label for="submit"/>
						<button dojoType="dijit.form.Button" type="button" name="cancel" id="cancel" >
							<xsl:attribute name="onClick">document.location.href='<xsl:value-of select="$logoutAction"/>';</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'LOGOUT')"/>
						</button>
					</div>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="browser-close-msg">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="content">
				<div class="notice"><img><xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($noticeImage)"/></xsl:attribute></img><p><xsl:value-of select="localization:getGTPString($language, 'LOGIN_SESSIONS_MSG_ON_BROWSER_CLOSE')" disable-output-escaping="yes"/></p></div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>