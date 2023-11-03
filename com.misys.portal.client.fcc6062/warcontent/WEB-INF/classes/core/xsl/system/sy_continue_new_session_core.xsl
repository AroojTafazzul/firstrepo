<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Continue New Session Screen.

Copyright (c) 2000-2012 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      13/03/12
author:    Rajesh kumar P.B
email:     rajeshkumar.pb@misys.com
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
  <xsl:param name="nextscreen"/>
  <xsl:param name="mode"/><!--
  <xsl:param name="_e2EESessionId"/>
  --><xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">loginFormQA</xsl:param>
  
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
       <div class="loginFormLargeHeader">
      	<span class="logo"></span>
       </div>
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="continue_session"/>
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
  continue_session message
  -->
 <xsl:template name="continue_session">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">LOGIN</xsl:with-param>
   <xsl:with-param name="content">
    
    <div id="changePasswordQA">
    
     <!-- Existing username -->
    
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">username</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="login_page/username"/></xsl:with-param>
     </xsl:call-template>
     <!-- Existing company -->
    
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">company</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="login_page/company"/></xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">confirm</xsl:with-param>
      </xsl:call-template><!--
      <xsl:call-template name="hidden-field">
         <xsl:with-param name="name">e2ee_sid</xsl:with-param>
         <xsl:with-param name="value"><xsl:value-of select="$_e2EESessionId"/></xsl:with-param>
		</xsl:call-template>
       --><div id="continue_session">
  	   <xsl:value-of select="localization:getGTPString($language, 'LOGIN_SESSIONS_CONTINUE')"/>	
   </div>
   
   	 <div class="field"><!--
	      <label for="submit"/>
	      -->
	      <button dojoType="dijit.form.Button" name="cancel" id="cancel" type="submit" onclick="dijit.byId('confirm').set('value','N');" ><xsl:value-of select="localization:getGTPString($language, 'CANCEL')"/></button>
	      <button dojoType="dijit.form.Button" name="submit" id="submit" type="submit"  onclick=" dijit.byId('confirm').set('value','Y');"><xsl:value-of select="localization:getGTPString($language, 'PROCEED')"/></button>
     </div>

    </div>
  <!--   <script>
    dojo.ready(function(){
    	
		dojo.mixin(misys, {
		onFormConfirmSubmit:function() {
				   dijit.byId('confirm').set('value','Y');
          },
        onFormCancelSubmit:function() {
				   dijit.byId('confirm').set('value','N');
          }  
		});
	});   
	</script> -->
   </xsl:with-param>
  </xsl:call-template>
  
  <script type="text/javascript">
  </script>
 </xsl:template>
</xsl:stylesheet>