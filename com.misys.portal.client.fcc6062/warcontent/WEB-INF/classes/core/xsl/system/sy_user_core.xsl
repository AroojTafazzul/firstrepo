<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 User Screen, System Form.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      29/04/08
author:    Laure Blin
##########################################################
-->
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization securitycheck utils">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="languages"/>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="token"/>
  <xsl:param name="action"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="operation"/>

  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
    
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <xsl:apply-templates select="static_user"/>
  </xsl:template>
  
  <xsl:template match="static_user">
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
      <xsl:call-template name="user-main-details"/>
      <xsl:call-template name="user-prefs"/>
      <xsl:call-template name="user-other-details"/> 
      
      <!--  Display common menu. -->
      <xsl:call-template name="system-menu"/>
      
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
  <xsl:call-template name="system-common-js-imports">
   <xsl:with-param name="xml-tag-name">static_user</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.user</xsl:with-param>
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
    <xsl:with-param name="name">user_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_abbv_name</xsl:with-param>
   </xsl:call-template>
   <xsl:if test="login_id[.!=''] and $displaymode='edit'">
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">login_id</xsl:with-param>
	    <xsl:with-param name="id">login_id_hidden</xsl:with-param>
	   </xsl:call-template>
   </xsl:if>
   <!-- Security token -->
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">token</xsl:with-param>
   </xsl:call-template>
 </div>
 </xsl:template>
 
 <!--
  Main Details of the Company 
  -->
 <xsl:template name="user-main-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_MAIN_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
   	
   	<!-- Company -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_JURISDICTION_COMPANY</xsl:with-param>
      <xsl:with-param name="name">company_abbv_name</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <!-- To modify the mode from "Edit" to "View" -->
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
    
    <!-- Login Id -->
    <xsl:if test="login_id[.!=''] and $displaymode='edit'">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_JURISDICTION_LOGIN_ID</xsl:with-param>
       <xsl:with-param name="name">login_id</xsl:with-param>
       <xsl:with-param name="size">32</xsl:with-param>
       <xsl:with-param name="maxsize">32</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>  
      </xsl:call-template>    
   </xsl:if>

     
     <xsl:if test="login_id[.=''] or $displaymode='view'">

      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_JURISDICTION_LOGIN_ID</xsl:with-param>
       <xsl:with-param name="name">login_id</xsl:with-param>
       <xsl:with-param name="size">32</xsl:with-param>
       <xsl:with-param name="maxsize">32</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
      </xsl:call-template>
      
   	  <!-- Password -->
   	  <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_JURISDICTION_PASSWORD</xsl:with-param>
       <xsl:with-param name="name">password_value</xsl:with-param>
       <xsl:with-param name="type">password</xsl:with-param>
       <xsl:with-param name="size">12</xsl:with-param>
       <xsl:with-param name="maxsize">12</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
   	  </xsl:call-template>
   
   	  <!-- Confirm Password -->
   	  <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_JURISDICTION_CONFIRM_PASSWORD</xsl:with-param>
       <xsl:with-param name="name">password_confirm</xsl:with-param>
       <xsl:with-param name="type">password</xsl:with-param>
       <xsl:with-param name="size">12</xsl:with-param>
       <xsl:with-param name="maxsize">12</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
   	  </xsl:call-template>
   	 </xsl:if>

     <!-- First Name -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_FIRST_NAME</xsl:with-param>
      <xsl:with-param name="name">first_name</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
     
     <!-- Last Name -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_LAST_NAME</xsl:with-param>
      <xsl:with-param name="name">last_name</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
  
     <!-- Address -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_ADDRESS</xsl:with-param>
      <xsl:with-param name="name">address_line_1</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="./address_line_1"/></xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">address_line_2</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="./address_line_2"/></xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">dom</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="./dom"/></xsl:with-param>
     </xsl:call-template>
	
	 <!-- Status -->     
	 <xsl:call-template name="select-field">
     	<xsl:with-param name="label">XSL_JURISDICTION_ACTIVE_LABEL</xsl:with-param>
     	<xsl:with-param name="name">actv_flag</xsl:with-param>
     	<xsl:with-param name="fieldsize">small</xsl:with-param>
     	<xsl:with-param name="required">Y</xsl:with-param>
     	<xsl:with-param name="options">
     		<xsl:call-template name="actv_flag-options"/>
    	</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="authentication_mode"/>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
  <!--
  Type and Preferences 
  -->
  <xsl:template name="user-prefs">
  	<xsl:variable name="current"><xsl:value-of select="language"/></xsl:variable>
  	<xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_HEADER_PREFERENCES_DETAILS</xsl:with-param>
   		<xsl:with-param name="content">
	  		<!-- Time Zone -->
	  		<xsl:call-template name="select-field">
     			<xsl:with-param name="label">XSL_JURISDICTION_TIME_ZONE</xsl:with-param>
     			<xsl:with-param name="name">time_zone</xsl:with-param>
     			<xsl:with-param name="required">Y</xsl:with-param>
     			<xsl:with-param name="options">
     				<xsl:choose>
     					<xsl:when test="$displaymode='edit'">
		     				<xsl:call-template name="time_zone-options"/>
     					</xsl:when>
     					<xsl:otherwise>
     						<xsl:value-of select="time_zone" />
     					</xsl:otherwise>
     				</xsl:choose>
     			</xsl:with-param>
     		</xsl:call-template>
	  		
	  		<!-- Selection of the language -->
	  		<xsl:call-template name="select-field">
    			<xsl:with-param name="label">XSL_JURISDICTION_LANGUAGE_LOCALE</xsl:with-param>
    			<xsl:with-param name="name">correspondence_language</xsl:with-param>
    			<xsl:with-param name="value"><xsl:value-of select="language"/></xsl:with-param>
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
    		
    		    		
    		<!-- Selection of the currency: in "system_common.xsl"-->
    		<xsl:call-template name="currency-template"/>
      		
  		</xsl:with-param>
  	</xsl:call-template>
  </xsl:template>
 
 
 <!--
 Others Details 
  -->
  <xsl:template name="user-other-details">
  	<xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_HEADER_OTHER_DETAILS</xsl:with-param>
   		<xsl:with-param name="content">
   			<xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_JURISDICTION_PHONE</xsl:with-param>
      			<xsl:with-param name="name">phone</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="./phone"/></xsl:with-param>
      			<xsl:with-param name="size">32</xsl:with-param>
       			<xsl:with-param name="maxsize">32</xsl:with-param>
    		</xsl:call-template>
    		
    		<xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_JURISDICTION_FAX</xsl:with-param>
      			<xsl:with-param name="name">fax</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="./fax"/></xsl:with-param>
      			<xsl:with-param name="size">32</xsl:with-param>
       			<xsl:with-param name="maxsize">32</xsl:with-param>
    		</xsl:call-template>
    		
    		<xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_JURISDICTION_EMAIL</xsl:with-param>
      			<xsl:with-param name="name">email</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="./email"/></xsl:with-param>
      			<xsl:with-param name="size">40</xsl:with-param>
       			<xsl:with-param name="maxsize">255</xsl:with-param>
    		</xsl:call-template>

			<!-- Users accessing Summit must declare their Summit user name -->
			<xsl:if test="securitycheck:hasPermission(utils:getUserACL($rundata),'sy_summit_username',utils:getUserEntities($rundata))">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SUMMIT_USERNAME</xsl:with-param>
					<xsl:with-param name="name">summit_username</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="./summit_username"/></xsl:with-param>
					<xsl:with-param name="size">20</xsl:with-param>
					<xsl:with-param name="maxsize">20</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
    		
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
   <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">
	       <xsl:choose>
	       	<xsl:when test="$option != ''"><xsl:value-of select="$option"/></xsl:when>
	       	<xsl:otherwise>USER_ACCOUNT_MAINTENANCE</xsl:otherwise>
	       </xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
       <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">token</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="$token" /></xsl:with-param>
  		</xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
      </xsl:call-template>
      <xsl:if test="login_id[.!=''] and $operation!='ADD_FEATURES'">
      	<xsl:call-template name="hidden-field">
      		<xsl:with-param name="name">featureid</xsl:with-param>
      		<xsl:with-param name="value"><xsl:value-of select="login_id"/></xsl:with-param>
      	</xsl:call-template>
      </xsl:if>
      <!-- Company is only passed for customer user maintenance on bank side -->
	  <xsl:if test="$option='CUSTOMER_USER_PROFILE_MAINTENANCE' or $option='BANK_USER_PROFILE_MAINTENANCE'">
	  	<xsl:call-template name="hidden-field">
      		<xsl:with-param name="name">company</xsl:with-param>
      		<xsl:with-param name="value"><xsl:value-of select="company_abbv_name"/></xsl:with-param>
      	</xsl:call-template>
	  </xsl:if>
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
  <!--
    Status type options.
   -->
  <xsl:template name="actv_flag-options">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="A">
       	<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ACTIVE_YES')"/>
     </option>
     <option value="I">
      	<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ACTIVE_NO')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
      	<xsl:if test="actv_flag[. = 'A']"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ACTIVE_YES')"/></xsl:if>
      	<xsl:if test="actv_flag[. = 'I']"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ACTIVE_NO')"/></xsl:if>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <xsl:template name="authentication_mode">
   <xsl:choose>
    <xsl:when test="authentication">
	 <xsl:apply-templates select="authentication"/>
	</xsl:when>
	<xsl:otherwise>
	 <xsl:if test="reauth_mode[.!=''] and count(reauth_mode/data_1[.!='NO_REAUTH']) >1">
	  <xsl:call-template name="row-wrapper">
       <xsl:with-param name="label">XSL_JURISDICTION_REAUTHENTICATION_MODE_LABEL</xsl:with-param>
       <xsl:with-param name="id">reauth_mode_view</xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:value-of select="localization:getDecode($language, 'N090', reauth_mode)"/>
       </xsl:with-param>
      </xsl:call-template>
	 </xsl:if>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
	
 <xsl:template match="authentication">
  <xsl:call-template name="row-wrapper">
   <xsl:with-param name="override-displaymode">view</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_JURISDICTION_REAUTHENTICATION_MODE_LABEL</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="name">reauth_mode</xsl:with-param>
     <xsl:with-param name="options">
      <xsl:choose>
       <xsl:when test="$displaymode='edit'">
        <xsl:apply-templates select="data_1"/>
       </xsl:when>
       <xsl:otherwise/>
      </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
	
 <xsl:template match="data_1">
  <option>
	<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	<xsl:value-of select="localization:getDecode($language, 'N090', .)"/>
  </option>
 </xsl:template>

</xsl:stylesheet>