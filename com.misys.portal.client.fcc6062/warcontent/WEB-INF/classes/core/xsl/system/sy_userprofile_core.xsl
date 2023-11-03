<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 User Profile Screen, System Form.

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
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
        xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
        xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
        xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization securityCheck security utils">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="languages"/>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="token"/>
  <xsl:param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:param>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="resetpasswordenabled">false</xsl:param>
  <xsl:param name="password_mimimum_length"/>
  <xsl:param name="password_maximum_length"/>
  <xsl:param name="password_charset"/>
  <xsl:param name="password_display_disabled"/> 
   <xsl:param name="company_type"/>
  
  

  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  <xsl:include href="sy_jurisdiction.xsl"/>
  <xsl:include href="../common/e2ee_common.xsl" />
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  
  <xsl:template match="/">
   <xsl:call-template name="loading-message"/>
    
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <!-- User Details in View Mode -->
      <xsl:apply-templates select="static_user" mode="display"/>
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="profile-fields"/>
      
      <!--  Display common menu. -->
      <xsl:call-template name="system-menu"/>
     </xsl:with-param>
    </xsl:call-template>
    
    <xsl:call-template name="realform"/>

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
 	<xsl:call-template name="client-side-pwdencryption"/>
  <xsl:call-template name="system-common-js-imports">
   <xsl:with-param name="xml-tag-name">static_user</xsl:with-param>
   <xsl:with-param name="override-help-access-key">SY_PROFILE</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.user_profile</xsl:with-param>
   <xsl:with-param name="override-help-access-key">SY_PROFILE</xsl:with-param>
  </xsl:call-template>
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
   	 <xsl:with-param name="name">nextscreen</xsl:with-param>
   	 <xsl:with-param name="value" select="$nextscreen"/>
  	</xsl:call-template>
   <xsl:call-template name="localization-dialog"/>
  </div>
 </xsl:template>

 <!-- Language -->
 <xsl:template name="profile-fields">
  <xsl:variable name="current"><xsl:value-of select="static_user/correspondence_language"/></xsl:variable>
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_JURISDICTION_LANGUAGE</xsl:with-param>
   <xsl:with-param name="content">
    
   <!-- Language -->
   <xsl:call-template name="select-field">
    <xsl:with-param name="label">XSL_JURISDICTION_LANGUAGE_LOCALE</xsl:with-param>
    <xsl:with-param name="name">correspondence_language</xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
    <xsl:with-param name="options">
 	 <xsl:choose>
      <xsl:when test="$displaymode='edit'">
       <xsl:if test="string($languages) != ''">
        <xsl:for-each select="$languages/languages/language">
          <xsl:variable name="optionLanguage"><xsl:value-of select="."/></xsl:variable>
   	      <option>
	 	   <xsl:attribute name="value"><xsl:value-of select="$optionLanguage"/></xsl:attribute>
 		   <xsl:value-of select="localization:getDecode($language, 'N061', $optionLanguage)"/>
   	      </option>
         </xsl:for-each>
        </xsl:if>
       </xsl:when>
       <xsl:otherwise>
        <xsl:variable name="optionLanguage"><xsl:value-of select="./language"/></xsl:variable>
     	<xsl:value-of select="localization:getDecode($language, 'N061', $optionLanguage)"/>
       </xsl:otherwise>
     </xsl:choose>
   </xsl:with-param>
  </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
  
  <!-- landing page products dropdown template -->
    <xsl:if test="$company_type='03'">
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_JURISDICTION_LANDING_PAGE_PRODUCT</xsl:with-param>
      <xsl:with-param name="content">
         <xsl:call-template name="select-field">
            <xsl:with-param name="label">XSL_REPORT_PRODUCT</xsl:with-param>
            <xsl:with-param name="name">landing_product</xsl:with-param>
            <xsl:with-param name="required">N</xsl:with-param>
            <xsl:with-param name="options">
               <xsl:choose>
                  <xsl:when test="$displaymode='edit'">
                      <xsl:for-each select="static_user/product_codes/product_code">
                          <xsl:variable name="productCode" select="."/>
                           <xsl:variable name="local_key" select="concat('XSL_REPORT_', $productCode)"/>
                           <xsl:if test="securityCheck:hasCompanyProductPermission($rundata,$productCode) and defaultresource:getResource('CASH_UNIFICATION') = 'false'"> 
                               <option value="{$productCode}"><xsl:value-of select="localization:getGTPString($language, $local_key)"/></option>
                           </xsl:if>
                           <xsl:if test="securityCheck:hasCompanyProductPermission($rundata,$productCode) and
                           		defaultresource:getResource('CASH_UNIFICATION') = 'true' and $productCode != 'FT' and $productCode != 'TD' and $productCode != 'BK' )"> 
                           		<option value="{$productCode}"><xsl:value-of select="localization:getGTPString($language, $local_key)"/></option>
                           </xsl:if>
                      </xsl:for-each>
                  </xsl:when>
               </xsl:choose>
            </xsl:with-param>
         </xsl:call-template>
       </xsl:with-param>
     </xsl:call-template>
    </xsl:if>
  
  <!-- Password Details -->
  <xsl:if test= "$password_display_disabled != 'true' ">
	  <xsl:call-template name="fieldset-wrapper">
	   <xsl:with-param name="legend">XSL_HEADER_PASSWORD_DETAILS</xsl:with-param>
	   <xsl:with-param name="content">
	    <xsl:call-template name="checkbox-field">
	     <xsl:with-param name="name">change_password</xsl:with-param>
	     <xsl:with-param name="label">XSL_JURISDICTION_CHANGEPASSWORD_CHECKBOX</xsl:with-param>
	    </xsl:call-template>
	    <input type="password" name="foilautofill" maxlength="25" value="" style="display:none; "/>
	    <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_JURISDICTION_OLD_PASSWORD</xsl:with-param>
	     <xsl:with-param name="id">old_password_value</xsl:with-param>
	     <xsl:with-param name="name">old_password_value</xsl:with-param>
	     <xsl:with-param name="size">12</xsl:with-param>
	     <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('PASSWORD_MAXIMUM_LENGTH')"/></xsl:with-param>
	     <xsl:with-param name="disabled">Y</xsl:with-param>
	     <xsl:with-param name="fieldsize">small</xsl:with-param>
	     <xsl:with-param name="type">password</xsl:with-param>
	    </xsl:call-template>
	    <input type="password" name="foilautofill" maxlength="25" value="" style="display:none; "/>
	    <xsl:call-template name="input-field">
	     <xsl:with-param name="label">SY_NEWPASSWORDMSG</xsl:with-param>
	     <xsl:with-param name="id">password_value</xsl:with-param>
	     <xsl:with-param name="name">password_value</xsl:with-param>
	     <xsl:with-param name="size">12</xsl:with-param>
	     <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('PASSWORD_MAXIMUM_LENGTH')"/></xsl:with-param>
	     <xsl:with-param name="disabled">Y</xsl:with-param>
	     <xsl:with-param name="type">password</xsl:with-param>
	     <xsl:with-param name="fieldsize">small</xsl:with-param>
	    </xsl:call-template>
	    <input type="password" name="foilautofill" maxlength="25" value="" style="display:none; "/>
	    <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_JURISDICTION_CONFIRM_PASSWORD</xsl:with-param>
	     <xsl:with-param name="id">password_confirm</xsl:with-param>
	     <xsl:with-param name="name">password_confirm</xsl:with-param>
	     <xsl:with-param name="size">12</xsl:with-param>
	     <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('PASSWORD_MAXIMUM_LENGTH')"/></xsl:with-param>
	     <xsl:with-param name="disabled">Y</xsl:with-param>
	     <xsl:with-param name="type">password</xsl:with-param>
	     <xsl:with-param name="fieldsize">small</xsl:with-param>
	    </xsl:call-template>
	   </xsl:with-param>
	  </xsl:call-template>
  </xsl:if>
  <!-- End: Password Details -->
  
  <xsl:if test="$resetpasswordenabled = 'true'">
  <xsl:if test="static_user/company_type = '03'">
  <!-- Start: Q&A Details -->  
  <xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="legend">SY_SETQUESTIONANSWER</xsl:with-param>
	<xsl:with-param name="content">
		<xsl:call-template name="checkbox-field">
		<xsl:with-param name="name">change_qa</xsl:with-param>
		<xsl:with-param name="label">XSL_JURISDICTION_CHANGEQA_CHECKBOX</xsl:with-param>
		</xsl:call-template>
		<div id="qaDiv" name="qaDiv">
		<script type="text/javascript">
  			 var answerIdArray = new Array();
  			 var counter = 0;
        </script>
		<xsl:for-each select="static_user/user_qa/question"> 
		<xsl:variable name="count" select="position()"/>
		<xsl:call-template name="hidden-field">
		 <xsl:with-param name="name">question_<xsl:value-of select="$count"/></xsl:with-param>
		 <xsl:with-param name="value"><xsl:value-of select="." /></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
		 <xsl:with-param name="override-label"><xsl:value-of select="$count" />.<xsl:value-of select="." /></xsl:with-param>
		 <xsl:with-param name="name">answer_<xsl:value-of select="$count"/></xsl:with-param>
		 <xsl:with-param name="size">50</xsl:with-param>
		 <xsl:with-param name="maxsize">255</xsl:with-param>
		 <xsl:with-param name="fieldsize">large</xsl:with-param>
		 <xsl:with-param name="required">N</xsl:with-param>
		 <xsl:with-param name="disabled">N</xsl:with-param>
		</xsl:call-template>  
		<script type="text/javascript"> 
		answerIdArray[counter] =  "answer_"+<xsl:value-of select="$count"/> ;
		counter++;
		</script>
		</xsl:for-each>
		<xsl:call-template name="hidden-field">
		 <xsl:with-param name="name">totalquestions</xsl:with-param>
		 <xsl:with-param name="value"><xsl:value-of select="static_user/user_qa/total_no_questions" /></xsl:with-param>
		</xsl:call-template>
		</div>
    </xsl:with-param>
  </xsl:call-template>
  <!-- End: Q&A Details -->
  </xsl:if>
  </xsl:if>
 </xsl:template>
 
 <!-- 
  Realform
  -->
 <xsl:template name="realform">
  <!-- Do not display this section when the counterparty mode is 'counterparty' -->
  <xsl:if test="$collaborationmode != 'counterparty'">
  <xsl:call-template name="form-wrapper">
   <xsl:with-param name="name">realform</xsl:with-param>
   <xsl:with-param name="action"><xsl:value-of select="$action"/></xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value">SAVE_PROFILE</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value" select="$option"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
       <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">token</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="$token" /></xsl:with-param>
  		</xsl:call-template>
  		<xsl:call-template name="hidden-field">
        <xsl:with-param name="name">SelectedLanguageForChangeProf</xsl:with-param> 
       </xsl:call-template>
	 <xsl:call-template name="e2ee_transaction"/>  		
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
</xsl:stylesheet>