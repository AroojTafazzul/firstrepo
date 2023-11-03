<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for : 

 Schedule Report Screen, System Form.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Laure Blin
##########################################################
-->
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:tools="xalan://com.misys.portal.common.tools.ConvertTools"
		xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		exclude-result-prefixes="localization tools securitycheck security">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="languages"/>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="action"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="fields"/>
  <xsl:param name="formname"/>
  <xsl:param name="productcode"/>
  <xsl:param name="token"/>

  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  <xsl:include href="../common/e2ee_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <xsl:apply-templates select="schedule_report"/>
  </xsl:template>
  
  <xsl:variable name="hasHourPermission">
  	 <xsl:value-of select="securitycheck:hasPermission($rundata,'sy_report_hours')"/>
  </xsl:variable>
  
  <xsl:template match="schedule_report">
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="schedule-report-details"/>
      
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
   <xsl:with-param name="xml-tag-name">schedule_report</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.schedule_report</xsl:with-param>
  <!--  <xsl:with-param name="override-help-access-key">SY_BTC_RD</xsl:with-param> -->
  <xsl:with-param name="override-help-access-key">
		<xsl:choose>
				<xsl:when test="security:isBank($rundata)">SY_SHD_BNK</xsl:when>
	   			<xsl:when test="security:isCustomer($rundata)">SY_SHD_C</xsl:when>
		</xsl:choose>
	</xsl:with-param>
  </xsl:call-template>

  <!-- We store the reports in a JavaScript array -->
   <script>
    var reports = [];
    <xsl:apply-templates select="avail_report" mode="array"/>
    var hasHoursPermi = <xsl:value-of select="$hasHourPermission"/>
  </script>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">brch_code</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">job_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">report_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="localization-dialog"/>
   <xsl:if test="$hasHourPermission = 'false'">
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">hour</xsl:with-param>
	    <xsl:with-param name="value">06</xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">minute</xsl:with-param>
	    <xsl:with-param name="value">00</xsl:with-param>
	   </xsl:call-template>
   </xsl:if>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">output</xsl:with-param>
	<xsl:with-param name="value">reportemailjob</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">schedulername</xsl:with-param>
	<xsl:with-param name="value">deactivateuserjob</xsl:with-param>
   </xsl:call-template>
 </div>
 </xsl:template>
 
 <!--
  Main Details of the Company 
  -->
 <xsl:template name="schedule-report-details">
  <div class="widgetContainer">
	<!-- Report Name -->
	<xsl:call-template name="select-field">
     	<xsl:with-param name="label">XSL_REPORT_NAME</xsl:with-param>
     	<xsl:with-param name="name">report_name</xsl:with-param>
     	<xsl:with-param name="required">Y</xsl:with-param>
     	<xsl:with-param name="options">
     		<xsl:apply-templates select="avail_report[@name]"/>
    	</xsl:with-param>
    </xsl:call-template>
	
	 <xsl:call-template name="multioption-group">
        <xsl:with-param name="group-label">XSL_JURISDICTION_FREQUENCY</xsl:with-param>
        <xsl:with-param name="content">
         	<!-- Day -->
			<xsl:call-template name="radio-field">
				<xsl:with-param name="label">XSL_JURISDICTION_FREQUENCY_DAILY</xsl:with-param>
		     	<xsl:with-param name="name">frequency</xsl:with-param>
		     	<xsl:with-param name="id">frequency_0</xsl:with-param>
		     	<xsl:with-param name="value">0</xsl:with-param>
		        <xsl:with-param name="checked"><xsl:if test="frequency[.='0']">Y</xsl:if></xsl:with-param>
			</xsl:call-template>
			<!-- Week: radio button and a template to add all days in a week -->
			<xsl:call-template name="radio-field">
				<xsl:with-param name="label">XSL_JURISDICTION_FREQUENCY_WEEKLY</xsl:with-param>
		     	<xsl:with-param name="name">frequency</xsl:with-param>
		     	<xsl:with-param name="id">frequency_1</xsl:with-param>
		     	<xsl:with-param name="value">1</xsl:with-param>
		        <xsl:with-param name="checked"><xsl:if test="frequency[.='1']">Y</xsl:if></xsl:with-param>
			</xsl:call-template>
			<!-- Month : radio button and input field -->
			<xsl:call-template name="radio-field">
				<xsl:with-param name="label">XSL_JURISDICTION_FREQUENCY_MONTHLY</xsl:with-param>
		     	<xsl:with-param name="name">frequency</xsl:with-param>
		     	<xsl:with-param name="id">frequency_2</xsl:with-param>
		     	<xsl:with-param name="value">2</xsl:with-param>
		        <xsl:with-param name="checked"><xsl:if test="frequency[.='2']">Y</xsl:if></xsl:with-param>
			</xsl:call-template>
			<!-- Note message: To indicate that schedulers will be based on owner Bank's Time-zone. -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="value"><xsl:value-of
					select="localization:getGTPString($language, 'NOTE_MSG_ALL_SCHEDULERS_WILL_BE_BASED_ON_OWNER_BANK_TIMEZONE')" /></xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">token</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
			</xsl:call-template>
        </xsl:with-param>
     </xsl:call-template>

	<div id="days_month_details" style="display:none">
		<xsl:call-template name="input-field">
		  <xsl:with-param name="label">XSL_JURISDICTION_FREQUENCY_DAY_OF_MONTH_LABEL</xsl:with-param>
	      <xsl:with-param name="name">day_of_month</xsl:with-param>
	      <xsl:with-param name="size">2</xsl:with-param>
          <xsl:with-param name="type">number</xsl:with-param>
          <xsl:with-param name="fieldsize">x-small</xsl:with-param>
	      <xsl:with-param name="maxsize">2</xsl:with-param>
	      <xsl:with-param name="override-constraints">{min:1,max:31}</xsl:with-param>
	      <xsl:with-param name="value"><xsl:if test="day_of_month != '-1'"><xsl:value-of select="day_of_month"/></xsl:if></xsl:with-param>
	    </xsl:call-template>
    </div>
	<div id="days_week_details" style="display:none">
		<xsl:call-template name="select-field">
		    <xsl:with-param name="label">XSL_JURISDICTION_FREQUENCY_WEEK_OF_DAY_LABEL</xsl:with-param>
	     	<xsl:with-param name="name">week_of_day</xsl:with-param>
	     	<xsl:with-param name="options">
	     		<option value="1">
	      			<xsl:value-of select="localization:getDecode($language, 'N082', 'SU')"/>
	     		</option>
	     		<option value="2">
	      			<xsl:value-of select="localization:getDecode($language, 'N082', 'MO')"/>
	     		</option>
	     		<option value="3">
	      			<xsl:value-of select="localization:getDecode($language, 'N082', 'TU')"/>
	     		</option>
	     		<option value="4">
	      			<xsl:value-of select="localization:getDecode($language, 'N082', 'WE')"/>
	     		</option>
	     		<option value="5">
	      			<xsl:value-of select="localization:getDecode($language, 'N082', 'TH')"/>
	     		</option>
	     		<option value="6">
	      			<xsl:value-of select="localization:getDecode($language, 'N082', 'FR')"/>
	     		</option>
	     		<option value="7">
	      			<xsl:value-of select="localization:getDecode($language, 'N082', 'SA')"/>
	     		</option>
	    	</xsl:with-param>
	    </xsl:call-template>
	</div>
	<xsl:if test="$hasHourPermission = 'true'">
	<div id="hour_details" style="display:none">
		<xsl:call-template name="select-field">
		    <xsl:with-param name="label">XSL_JURISDICTION_FREQUENCY_HOUR</xsl:with-param>
		    <xsl:with-param name="fieldsize">x-small</xsl:with-param>
	     	<xsl:with-param name="name">hour</xsl:with-param>
	     	<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
	     	<xsl:with-param name="value"><xsl:value-of select="hour"/></xsl:with-param>
	     	<xsl:with-param name="options">
	       		<xsl:call-template name="hours_options"/>
	      </xsl:with-param>
	    </xsl:call-template>
	    
	    <xsl:call-template name="input-field">
		    <xsl:with-param name="fieldsize">x-small</xsl:with-param>
	     	<xsl:with-param name="name">minute</xsl:with-param>
	     	<xsl:with-param name="type">number</xsl:with-param>
	     	<xsl:with-param name="override-constraints">{places:'0',min:0, max:59}</xsl:with-param>
	     	<xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
	    </xsl:call-template> 
	</div>
	</xsl:if>
	
	<!-- Output Format -->
	<xsl:call-template name="select-field">
     	<xsl:with-param name="label">OUTPUT_FORMAT</xsl:with-param>
     	<xsl:with-param name="name">viewer</xsl:with-param>
     	<xsl:with-param name="required">Y</xsl:with-param>
     	<xsl:with-param name="options">
     		<option value="csv">
      			<xsl:value-of select="localization:getDecode($language, 'N031', 'csv')"/>
     		</option>
     		<option value="xls">
      			<xsl:value-of select="localization:getDecode($language, 'N031', 'xls')"/>
     		</option>
     		<option value="pdf">
      			<xsl:value-of select="localization:getDecode($language, 'N031', 'pdf')"/>
     		</option>
    	</xsl:with-param>
    </xsl:call-template>
    
	<!-- Language / Locale -->
	<xsl:call-template name="select-field">
     	<xsl:with-param name="label">XSL_JURISDICTION_LANGUAGE_LOCALE</xsl:with-param>
     	<xsl:with-param name="name">alertlanguage</xsl:with-param>
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
    
	<!-- Email Address -->
	 <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_EMAIL_ADDRESS_HEADER</xsl:with-param>
      <xsl:with-param name="name">email</xsl:with-param>
      <xsl:with-param name="size">255</xsl:with-param>
      <xsl:with-param name="maxsize">255</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
   </div>
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
       <xsl:with-param name="value">REPORT_SAVE_SCHEDULE</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:if test="company_id[.!='']">
      	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">abbv_name</xsl:with-param>
       		<xsl:with-param name="value"/>
      	</xsl:call-template>
      </xsl:if>
	  <xsl:call-template name="e2ee_transaction"/>      
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
 
  <xsl:template match="avail_report" mode ="array">
  		reports['<xsl:value-of select="tools:filterString(@name)"/>'] = '<xsl:value-of select="@report_id"/>';
  </xsl:template>
  
  <!-- Template to fill out the Top/Down Menu for the "Report Name" field -->
  <xsl:template match="avail_report">
    <option>
      	<xsl:attribute name="value"><xsl:value-of select="@name"/></xsl:attribute>
      	<xsl:value-of select="@name"/>
    </option>
  </xsl:template>
  
  <xsl:template name="hours_options">
	<xsl:for-each select="hours/hour">
        <option>
           <xsl:attribute name="value">
            	<xsl:value-of select="."/>
           </xsl:attribute>
	       <xsl:value-of select="."/>
	    </option>
    </xsl:for-each>
  </xsl:template>
  
</xsl:stylesheet>