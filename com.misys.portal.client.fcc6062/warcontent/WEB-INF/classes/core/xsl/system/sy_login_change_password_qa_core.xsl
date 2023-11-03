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
					<xsl:with-param name="validating">Y</xsl:with-param>
					<xsl:with-param name="onsubmit">
    					<xsl:choose>
							<xsl:when test="defaultresource:getResource('ENABLE_CLIENT_SIDE_ENCRYPTION') = 'true'">return misys.encryptBeforeSubmit();</xsl:when>
							<xsl:otherwise>return misys.onFormSubmit();</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="content">
						<div class="loginFormLarge"> 
							<div class="loginFormLargeHeader">
								<span class="logo"></span>
							</div>
							<xsl:call-template name="hidden-fields"/>
							<xsl:call-template name="linking-fields"/>
							<xsl:call-template name="change-password-fields"/>
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</div>
		</div>
	   
		<!-- Javascript imports  -->
		<xsl:call-template name="js-imports"/>
	
		<!-- password policy fields -->
		<xsl:call-template name="e2ee-password-policy">
			<xsl:with-param name="password_mimimum_length"><xsl:value-of select="$password_mimimum_length"/></xsl:with-param>
			<xsl:with-param name="password_maximum_length"><xsl:value-of select="$password_maximum_length"/></xsl:with-param>
			<xsl:with-param name="password_charset"><xsl:value-of select="$password_charset"/></xsl:with-param>
			<xsl:with-param name="allowUserNameInPasswordValue"><xsl:value-of select="defaultresource:getResource('ALLOW_USERNAME_IN_PASSWORD_VALUE')"/></xsl:with-param>
		</xsl:call-template>
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
  
	<!-- Additional hidden fields for this form are  -->
	<!-- added here. -->
	<xsl:template name="hidden-fields">
		<div class="widgetContainer">
		<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">mode</xsl:with-param>
				<xsl:with-param name="value" select="$mode"/>
		</xsl:call-template>

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
	<xsl:template name="change-password-fields">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">SY_CHANGEPASSWORD</xsl:with-param>
			<xsl:with-param name="content">
				<div id="changePasswordQA">
					<!-- Existing company -->
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">LOGIN_COMPANYMSG</xsl:with-param>
						<xsl:with-param name="id">login_page_company_view</xsl:with-param>
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
		
					<!-- username change related fields -->
					<xsl:call-template name="multichoice-field">
						<xsl:with-param name="name">change_username</xsl:with-param>
						<xsl:with-param name="label">XSL_JURISDICTION_CHANGEUSERNAME_CHECKBOX</xsl:with-param>
						<xsl:with-param name="type">checkbox</xsl:with-param>
					</xsl:call-template>
					 
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_JURISDICTION_NEW_USERNAME</xsl:with-param>
						<xsl:with-param name="name">new_user_name</xsl:with-param>
						<xsl:with-param name="size">12</xsl:with-param>
						<xsl:with-param name="maxsize">32</xsl:with-param>
						<xsl:with-param name="readonly">N</xsl:with-param>
						<xsl:with-param name="disabled">Y</xsl:with-param>
						<xsl:with-param name="required">N</xsl:with-param>
						<xsl:with-param name="uppercase">Y</xsl:with-param>
						<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('LOGINID_VALIDATION_REGEX')"/></xsl:with-param>
						<xsl:with-param name="fieldsize">small</xsl:with-param>
					</xsl:call-template> 
		
					<!-- contact details related fields -->
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">SY_UPDATE_CONTACT_DETAILS</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_JURISDICTION_MOBILE_PHONE</xsl:with-param>
								<xsl:with-param name="name">phone</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="login_page/phone"/></xsl:with-param>
								<xsl:with-param name="size">24</xsl:with-param>
								<xsl:with-param name="maxsize">24</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_JURISDICTION_EMAIL</xsl:with-param>
								<xsl:with-param name="name">email</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="login_page/email"/></xsl:with-param>
								<xsl:with-param name="size">255</xsl:with-param>
								<xsl:with-param name="maxsize">255</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
		
					<!-- password change related fields -->
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">CHANGE_PASSWORD</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">     
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">SY_CURRENT_PASSWORD</xsl:with-param>
								<xsl:with-param name="id">password</xsl:with-param>
								<xsl:with-param name="name">password</xsl:with-param>
								<xsl:with-param name="type">password</xsl:with-param>
								<xsl:with-param name="size">12</xsl:with-param>
								<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('PASSWORD_MAXIMUM_LENGTH')"/></xsl:with-param>
								<xsl:with-param name="fieldsize">small</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">SY_NEW_PASSWORD</xsl:with-param>
								<xsl:with-param name="id">password_value</xsl:with-param>
								<xsl:with-param name="name">password_value</xsl:with-param>
								<xsl:with-param name="size">12</xsl:with-param>
								<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('PASSWORD_MAXIMUM_LENGTH')"/></xsl:with-param>
								<xsl:with-param name="fieldsize">small</xsl:with-param>
								<xsl:with-param name="type">password</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">SY_CONFIRM_NEW_PASSWORD</xsl:with-param>
								<xsl:with-param name="id">password_confirm</xsl:with-param>
								<xsl:with-param name="name">password_confirm</xsl:with-param>
								<xsl:with-param name="type">password</xsl:with-param>
								<xsl:with-param name="size">12</xsl:with-param>
								<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('PASSWORD_MAXIMUM_LENGTH')"/></xsl:with-param>
								<xsl:with-param name="fieldsize">small</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
		
					<!-- Q&A details related fields -->
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">SY_SETQUESTIONANSWER</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
							<xsl:for-each select="login_page/question"> 
								<xsl:variable name="count" select="position()"/>
								<xsl:call-template name="input-field">
									<xsl:with-param name="override-label"><xsl:value-of select="$count" />.<xsl:value-of select="." /></xsl:with-param>
									<xsl:with-param name="name">answer_<xsl:value-of select="$count"/></xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="fieldsize">large</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">question_<xsl:value-of select="$count"/></xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="." /></xsl:with-param>
								</xsl:call-template>
							</xsl:for-each>
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">totalquestions</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="login_page/total_no_questions" /></xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
		
					<div class="field">
						<label for="submit"/>
						<button dojoType="dijit.form.Button" style="width:15px" name="submit" id="submit" type="submit"><xsl:value-of select="localization:getGTPString($language, 'SUBMIT')"/></button>
					</div>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

</xsl:stylesheet>