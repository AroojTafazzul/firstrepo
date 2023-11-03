<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for : TO DO : CANCEL + PASSBACK ENTITY

 Rate Screen, System Form.

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
		exclude-result-prefixes="localization">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  	<xsl:param name="option"/>
  	<xsl:param name="language">en</xsl:param>
  	<xsl:param name="nextscreen"/>
  	<xsl:param name="mode">DRAFT</xsl:param>
  	<xsl:param name="action"/>
  <xsl:param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:param>
	<xsl:param name="displaymode">edit</xsl:param>
  	<xsl:param name="operation">SAVE_FEATURES</xsl:param>
  	<xsl:param name="isMakerCheckerMode"/>
	<xsl:param name="makerCheckerState"/>
	<xsl:param name="canCheckerReturnComments"/>
	<xsl:param name="checkerReturnCommentsMode"/>
  	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
   	<xsl:param name="main-form-name">fakeform1</xsl:param>
   	<xsl:param name="modifyMode">N</xsl:param>
   	<xsl:param name="token"/>
	<xsl:param name="processdttm"/>
	<xsl:param name="company"/>
   	<xsl:param name="allowReturnAction">false</xsl:param>
  	<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:param>
  	<xsl:param name="product-code"/>
  	<xsl:param name="upload-file-url"/>
  <xsl:param name="override_company_abbv_name"></xsl:param>
  	
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
   <xsl:include href="../../../core/xsl/common/e2ee_common.xsl" />
  <xsl:include href="../common/maker_checker_common.xsl" />

  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

  <xsl:template match="/">
	<xsl:apply-templates select="static_rate"/>
  </xsl:template>
  
  <xsl:template match="static_rate">
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
      <xsl:call-template name="rate-details"/>
      <xsl:if test="$canCheckerReturnComments = 'true'">
		<xsl:call-template name="comments-for-return-mc">
	 	<xsl:with-param name="value"><xsl:value-of select="rate/return_comments"/></xsl:with-param>
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
  <xsl:call-template name="system-common-js-imports">
   <xsl:with-param name="xml-tag-name">static_rate</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.rate</xsl:with-param>
   <xsl:with-param name="show-period-js">Y</xsl:with-param>
   <xsl:with-param name="override-help-access-key">RATE</xsl:with-param>
   <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>'</xsl:with-param>
   <xsl:with-param name="override-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/></xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">iso_code</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="currency/iso_code"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">bank_abbv_name</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="bank_abbv_name"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">base_iso_code</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="base_iso_code"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">rate_type</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="rate_type"/></xsl:with-param>
   </xsl:call-template>
 </div>
 </xsl:template>
 
 <!--
  Main Details of the Bank 
  -->
 <xsl:template name="rate-details">
  <xsl:call-template name="fieldset-wrapper">
   <!-- TODO Should have its own localised strings. -->
   <xsl:with-param name="legend">XSL_HEADER_PO_ADJUSTMENT_RATE</xsl:with-param>
   <xsl:with-param name="button-type">
   		<xsl:if test="$hideMasterViewLink!='true'">mc-master-details</xsl:if>
   </xsl:with-param>
   <xsl:with-param name="override-displaymode">edit</xsl:with-param>
   <xsl:with-param name="content"> 	
 	<!-- Start Value Date --> 
    <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_RATE_START_VALUE_DATE</xsl:with-param>
      <xsl:with-param name="id">rate_start_value_date_view</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="rate/start_value_date"/></xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    
    <!-- End Value Date --> 
    <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_RATE_END_VALUE_DATE</xsl:with-param>
      <xsl:with-param name="id">rate_end_value_date_view</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="rate/end_value_date"/></xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
 	
 	<!-- Currency -->
 	<xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_FROM_CURRENCY</xsl:with-param>
      <xsl:with-param name="id">currency_iso_code_view</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="currency/iso_code"/></xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    
    <!-- Name --> 
    <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_NAME</xsl:with-param>
      <xsl:with-param name="id">currency_name_view</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="currency/name"/></xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    
    <!-- Base Currency --> 
    <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_PIVOT_TO_CURRENCY</xsl:with-param>
      <xsl:with-param name="id">pivot_currency_iso_code_view</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="pivot_currency/iso_code"/></xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
     
    <!-- Name --> 
    <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_NAME</xsl:with-param>
      <xsl:with-param name="id">pivot_currency_name_view</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="pivot_currency/name"/></xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    
    <!-- Exchange Rate --> 
  
    <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_BUY_RATE</xsl:with-param>
      <xsl:with-param name="name">buy_tt_rate</xsl:with-param>
      <xsl:with-param name="size">15</xsl:with-param>
      <xsl:with-param name="maxsize">15</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="type">exchrate</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="rate/buy_tt_rate"/></xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_RATE</xsl:with-param>
      <xsl:with-param name="name">mid_tt_rate</xsl:with-param>
      <xsl:with-param name="size">15</xsl:with-param>
      <xsl:with-param name="maxsize">15</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="type">exchrate</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="rate/mid_tt_rate"/></xsl:with-param>
      <xsl:with-param name="override-number-constraint">{pattern:'####.######'}</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_SELL_RATE</xsl:with-param>
      <xsl:with-param name="name">sell_tt_rate</xsl:with-param>
      <xsl:with-param name="size">15</xsl:with-param>
      <xsl:with-param name="maxsize">15</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="type">exchrate</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="rate/sell_tt_rate"/></xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
    </xsl:call-template>
    
    <!-- Parity --> 
    <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_PARITY</xsl:with-param>
      <xsl:with-param name="name">paty_val</xsl:with-param>
      <xsl:with-param name="size">6</xsl:with-param>
      <xsl:with-param name="maxsize">6</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="type">parity</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="rate/paty_val"/></xsl:with-param>
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
   <xsl:with-param name="action"><xsl:value-of select="$action"/></xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value" select="$operation"></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">option</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:choose>
		<xsl:when test="$option != ''"><xsl:value-of select="$option"/></xsl:when>
		<xsl:otherwise>RATE_MAINTENANCE_MC</xsl:otherwise>
		</xsl:choose>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="rate/tnx_id[.!='']">
	 <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">tnxid</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="rate/tnx_id"/></xsl:with-param>
	</xsl:call-template>
	</xsl:if>
	<!-- <xsl:if test="rate/iso_code[.!='']">
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">featureid</xsl:with-param>
	        <xsl:with-param name="value"><xsl:value-of select="rate/iso_code"/></xsl:with-param>
		</xsl:call-template>
	</xsl:if> -->
     
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
	  <xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">featureid</xsl:with-param>
    	<xsl:with-param name="value"><xsl:value-of select="currency/iso_code"/></xsl:with-param>
   	  </xsl:call-template>	
   	  <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">token</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="$token" /></xsl:with-param>
  		</xsl:call-template> 
		<xsl:call-template name="e2ee_transaction"/>  
  	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">mode</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="$draftMode"/></xsl:with-param>
	</xsl:call-template>  
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">processdttm</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="$processdttm"/></xsl:with-param>
	</xsl:call-template>
	
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>