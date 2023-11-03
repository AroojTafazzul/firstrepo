<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for : TO DO : CANCEL + PASSBACK ENTITY

 Role Maintenance Screen, System Form.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      02/05/08
author:    Laure Blin
##########################################################
-->
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		exclude-result-prefixes="localization security">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="language">en</xsl:param>
  <!-- <xsl:param name="languages"/>-->
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="action"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="productcode"/>
  <xsl:param name="operation">SAVE_FEATURES</xsl:param>
  <xsl:param name="isMakerCheckerMode"/>
  <xsl:param name="makerCheckerState"/>
  <xsl:param name="token"/>
  <xsl:param name="processdttm"/>
  <xsl:param name="canCheckerReturnComments"/>
  <xsl:param name="checkerReturnCommentsMode"/>
  <xsl:param name="allowReturnAction">false</xsl:param>
  <!-- 
  <xsl:param name="fields"/>
  <xsl:param name="formname"/>
  -->  	
	
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  <xsl:include href="../common/maker_checker_common.xsl" />
  <xsl:include href="../../../core/xsl/common/e2ee_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

  <xsl:template match="/">
	<xsl:apply-templates select="role_record/role"/>
  </xsl:template>
  
  <xsl:template match="role_record/role">
   <!-- Loading message  -->
   <xsl:call-template name="loading-message"/>
  
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="roledesc-details"/>
      
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
 		<xsl:when test="security:isBank($rundata)"><xsl:value-of select="'SY_JURIS'"></xsl:value-of></xsl:when>
 		<xsl:otherwise><xsl:value-of select="'JM_01'"></xsl:value-of></xsl:otherwise>
 	</xsl:choose>
 	</xsl:variable>
  <xsl:call-template name="system-common-js-imports">
   <xsl:with-param name="xml-tag-name">role_record</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.role_desc</xsl:with-param>
   <xsl:with-param name="override-help-access-key"><xsl:value-of select="$help_access_key"/></xsl:with-param>
   <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>'</xsl:with-param>
   <xsl:with-param name="override-help-access-key">SY_JURIS_C</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">brch_code</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">role_id</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="id"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">name</xsl:with-param>
   </xsl:call-template>
 </div>
 </xsl:template>
 
 <!--
  Main Details of the Bank 
  -->
 <xsl:template name="roledesc-details">
 	<xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_ROLES_DETAILS</xsl:with-param>
   			 <xsl:with-param name="button-type">
   				<xsl:if test="$hideMasterViewLink!='true'">mc-master-details</xsl:if>
   			</xsl:with-param>
   			<xsl:with-param name="override-displaymode">edit</xsl:with-param>
   			<xsl:with-param name="content">
   			 <!-- Role Code -->
		     <xsl:call-template name="input-field">
		      <xsl:with-param name="label">XSL_JURISDICTION_ROLE_CODE</xsl:with-param>
		      <xsl:with-param name="name">name</xsl:with-param>
		      <xsl:with-param name="override-displaymode">view</xsl:with-param>
		     </xsl:call-template>
		     
		     <!-- Role Description -->
		     <xsl:call-template name="input-field">
		      <xsl:with-param name="label">XSL_JURISDICTION_ROLE_DESCRIPTION</xsl:with-param>
		      <xsl:with-param name="name">role_description</xsl:with-param>
		      <xsl:with-param name="size">99</xsl:with-param>
		      <xsl:with-param name="maxsize">99</xsl:with-param>
		      <xsl:with-param name="required">Y</xsl:with-param>
		     </xsl:call-template>
   			</xsl:with-param>
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
			<xsl:when test="../company_type[.='03']"> <xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/CustomerSystemFeaturesScreen</xsl:when>
			<xsl:otherwise> <xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/BankSystemFeaturesScreen</xsl:otherwise>
		</xsl:choose>
   </xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value" select="$operation"></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">ROLE_MAINTENANCE_MC</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">featureid</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="name"/></xsl:with-param>
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
       <xsl:call-template name="e2ee_transaction"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
</xsl:stylesheet>