<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
User Accounts Assignment Screen

Copyright (c) 2000-2012 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      2011
author:    Gurudath Reddy
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		exclude-result-prefixes="localization securitycheck utils security">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="action"/>
  <xsl:param name="company"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="isMakerCheckerMode"/>
  <xsl:param name="makerCheckerState"/>
  <xsl:param name="token"/>
  <xsl:param name="canCheckerReturnComments"/>
  <xsl:param name="checkerReturnCommentsMode"/>
  <xsl:param name="allowReturnAction">false</xsl:param>
  <xsl:param name="tnx-id"></xsl:param>
  <xsl:param name="operation">SAVE_FEATURES</xsl:param>
   <xsl:param name="processdttm"/>
  
  <!-- Global Imports. -->
   <xsl:include href="../common/system_common.xsl" />
  <xsl:include href="../common/maker_checker_common.xsl" />
  <xsl:include href="sy_jurisdiction.xsl" />
  <xsl:include href="sy_user_accounts_widget.xsl"/>
  <xsl:include href="sy_reauthenticationdialog.xsl" />
  <xsl:include href="../common/e2ee_common.xsl" />
 
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

  <xsl:template match="/">
	<xsl:apply-templates select="user_accounts_record"/>
  </xsl:template>
  
  <xsl:template match="user_accounts_record">
   <!-- Loading message  -->
   <xsl:call-template name="loading-message"/>
  
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    
     <!-- Reauthentication -->
    <xsl:call-template name="server-message">
 		<xsl:with-param name="name">server_message</xsl:with-param>
 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="reauthentication" />
	
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <!-- Show the user details -->
	  <xsl:apply-templates select="static_user" mode="display"/>
	 
      <xsl:call-template name="user-accounts-component"/>

      <xsl:if test="$canCheckerReturnComments = 'true'">
     	<xsl:call-template name="comments-for-return-mc">
      		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
      	</xsl:call-template>
      </xsl:if>
      <!--  Display common menu. -->
      <xsl:call-template name="maker-checker-menu"/>
    
     </xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="realform"/>
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
 <xsl:variable name="help_access_key">
  	<xsl:choose>
 		<xsl:when test="security:isBank($rundata)"><xsl:value-of select="'UA_01'"></xsl:value-of></xsl:when>
 		<xsl:otherwise><xsl:value-of select="'CUA_01'"></xsl:value-of></xsl:otherwise>
 	</xsl:choose>
 	</xsl:variable>
  <xsl:call-template name="system-common-js-imports">
   <xsl:with-param name="xml-tag-name">user_accounts_record</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.user_accounts_mc</xsl:with-param>
   <xsl:with-param name="override-help-access-key"><xsl:value-of select="$help_access_key"/></xsl:with-param>
    <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?company=<xsl:value-of select="$company"/>&amp;option=<xsl:value-of select="$option"/>'</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- 
  Realform
  -->
 <xsl:template name="realform">
  <!-- Do not display this section when the counterparty mode is 'counterparty' -->
  <xsl:if test="$collaborationmode != 'counterparty'">
  <xsl:call-template name="form-wrapper">
   <xsl:with-param name="name">realform</xsl:with-param>
   <xsl:with-param name="method">POST</xsl:with-param>
   <xsl:with-param name="action">
    <xsl:choose>
     <xsl:when test="$nextscreen"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:when>
     <xsl:otherwise><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/CSFCustomerUserAccountsMCPortlet</xsl:otherwise>
    </xsl:choose>
   </xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value" select="$operation"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">
       	<xsl:choose>
         <xsl:when test="$option='CUSTOMER_USER_ACCOUNTS_ASSIGNMENT_MC'">CUSTOMER_USER_ACCOUNTS_ASSIGNMENT_MC</xsl:when>
         <xsl:otherwise>USER_ACCOUNTS_ASSIGNMENT_MC</xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
	  <xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">featureid</xsl:with-param>
    	<xsl:with-param name="value"><xsl:value-of select="static_user/login_id"/></xsl:with-param>
   	  </xsl:call-template>
   	  <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">processdttm</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$processdttm"/></xsl:with-param>
      </xsl:call-template>	 
	  <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">mode</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$draftMode"/></xsl:with-param>
      </xsl:call-template>
   	  <xsl:if test="$option='CUSTOMER_USER_ACCOUNTS_ASSIGNMENT_MC'">
   	  	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">company</xsl:with-param>
       		<xsl:with-param name="value"><xsl:value-of select="static_user/company_abbv_name"/></xsl:with-param>
      	</xsl:call-template>
   	  </xsl:if> 
   	  <xsl:if test="$tnx-id !=''">
   	  	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">tnxid</xsl:with-param>
       		<xsl:with-param name="value"><xsl:value-of select="$tnx-id"/></xsl:with-param>
      	</xsl:call-template>
   	  </xsl:if> 
   	   <xsl:call-template name="reauth_params"/>
   	   <xsl:call-template name="e2ee_transaction"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
</xsl:stylesheet>