<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for Re Authentication Page.

Copyright (c) 2000-2013 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      10/01/12
author:    Raja Rao

##########################################################
-->
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    exclude-result-prefixes="localization securityCheck">

	<!-- Global Imports. -->
	<xsl:import href="../common/common.xsl" />
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	
	<xsl:template name="reauthentication">
		<xsl:variable name="reauth_enable">
			<xsl:value-of select="securityCheck:isReauthenticationEnabled('true')"/>
		</xsl:variable>
		<xsl:if test="$reauth_enable = 'true' ">
			<div class="widgetContainer" style="display: none;">
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">reauth_perform</xsl:with-param>
					<xsl:with-param name="value">Y</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="dialog">
					<xsl:with-param name="id">reauth_dialog</xsl:with-param>
					<xsl:with-param name="validate">Y</xsl:with-param>
					<xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'REAUTHENTICATION')"/></xsl:with-param>
					<xsl:with-param name="content"> 
						<div id="reauth_dialog_content">
							<!-- Content will be populated here from the ajax call -->  
						</div>
						<div id="reauth_dialog_password">
							<xsl:call-template name="input-field">
								<xsl:with-param name="name">reauth_password</xsl:with-param>
								<xsl:with-param name="type">password</xsl:with-param>     	  
								<xsl:with-param name="override-displaymode">edit</xsl:with-param> 
								<xsl:with-param name="hide-label">Y</xsl:with-param>
								<xsl:with-param name="fieldsize">container-width</xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:with-param>
					<xsl:with-param name="buttons">
						<xsl:call-template name="row-wrapper">
							<xsl:with-param name="content">
								<div id="reauth_sb">
									<button dojoType="dijit.form.Button" type="button" id="doReauthentication"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/></button>
								</div>
								<button dojoType="dijit.form.Button" type="button" id="cancelReauthentication"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/></button>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</div>	 
			<script>
				dojo.ready(function() {
					dojo.require("misys.binding.dialog.reauth");
				});
			</script>
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
					encryptBeforeSubmitReauth: function(){
						return misys.beforeSubmitEncryptionReauth();												
					},
					encrypt : function(passPhrase){
						return misys.encryptText(passPhrase);
   	    	 		}
				});
			});
			</script>
		</xsl:if>
		</xsl:if>
	</xsl:template>
  
	<xsl:template name="reauth_params">
		<xsl:variable name="reauth_enable">
			<xsl:value-of select="securityCheck:isReauthenticationEnabled('true')"/>
		</xsl:variable>
		<xsl:if test="$reauth_enable = 'true' ">
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">reauth_otp_response</xsl:with-param>
				<xsl:with-param name="value"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
  
</xsl:stylesheet>