<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

Accept terms and conditions screen.

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
	<xsl:param name="context-path"/>
	<xsl:param name="action"/>
	<xsl:param name="mode"/>
	<xsl:param name="displaymode">edit</xsl:param>
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	<xsl:param name="main-form-name">loginFormQA</xsl:param>
	<xsl:param name="logoutAction"/>

	<!-- Global Imports. -->
	<xsl:include href="../common/system_common.xsl" />
	<xsl:include href="sy_bank_terms_condition.xsl" />

	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

	<!-- Main Login Template -->
	<xsl:template match="/">
		<div id="formContainerQA">
			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name"/>
				<xsl:with-param name="action" select="$url"/>
                <xsl:with-param name="onsubmit">return misys.onPageSubmit();</xsl:with-param>
				<xsl:with-param name="method">post</xsl:with-param>
				<xsl:with-param name="content">
					<div class="loginFormLarge">
						<div class="loginFormLargeHeader">
							<span class="logo"></span>
						</div>
						<xsl:call-template name="hidden-fields"/>
						<xsl:call-template name="linking-fields"/>
						<xsl:call-template name="terms"/>
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
    	  	dojo.require("misys.binding.system.login");
    	  	dojo.mixin(misys, {  
	        	onPageSubmit : function() {
		        	if(dijit.byId('<xsl:value-of select="$main-form-name"/>').validate()) {
		            	// Show an dialog underlay to prevent user from interacting with the form
			          	misys.dialog.show("PROGRESS");
			          	// Hide the alert box as the message is not needed
			          	if (dojo.byId("alertDialog")) { 
							dojo.style(dojo.byId("alertDialog"), "display", "none");
						}
						return true;
			         } 
			         else {
			            return false;
			         }
		        }
		    });
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
	
	<!-- Change Password Fields -->
	<xsl:template name="terms">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">SY_TERMS_CONDITION</xsl:with-param>
   			<xsl:with-param name="content">
    
				<div id="changePasswordQA">
					<!-- Existing company -->
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">LOGIN_COMPANYMSG</xsl:with-param>
						<xsl:with-param name="id">login_page_company_view</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="login_page/company"/></xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">company</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="login_page/company"/></xsl:with-param>
					</xsl:call-template>
					<!-- Existing username -->
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">LOGIN_USERNAMEMSG</xsl:with-param>
						<xsl:with-param name="id">login_page_username_view</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="login_page/username"/></xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">username</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="login_page/username"/></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="bank-terms-conditions" />
					<div class="field">
						<label for="submit"/>
						<input type="checkbox" dojoType="dijit.form.CheckBox" name="tandcflag" id="tandcflag">
							<xsl:attribute name="onChange">if(this.checked){dijit.byId('submit').set('disabled',false);}else{dijit.byId('submit').set('disabled',true);}</xsl:attribute>
						</input>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_ACCEPT_TERMS')"/>
					</div>
					<div class="field">
						<label for="submit"/>
						<button dojoType="dijit.form.Button" type="button" name="cancel" id="cancel" >
							<xsl:attribute name="onClick">document.location.href='<xsl:value-of select="$logoutAction"/>';</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'CANCEL')"/>
						</button>
						<button dojoType="dijit.form.Button" name="submit" id="submit" type="submit" disabled="true">							
							<xsl:value-of select="localization:getGTPString($language, 'OK')"/>
						</button>
					</div>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
</xsl:stylesheet>