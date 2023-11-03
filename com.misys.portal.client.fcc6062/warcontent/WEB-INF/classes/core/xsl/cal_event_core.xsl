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
        exclude-result-prefixes="localization"
        xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="languages"/>
  <xsl:param name="nextscreen"/>
  <xsl:param name="date"/>
  <xsl:param name="option"/>
  <xsl:param name="token"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>

  <!-- Global Imports. -->
  <xsl:include href="common/system_common.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  
  <xsl:template match="/">
   <xsl:apply-templates select="event_record"/>
  </xsl:template>
  
  <xsl:template match="event_record">
   <xsl:call-template name="loading-message"/>
    
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details"/>
     </xsl:with-param>
    </xsl:call-template>
   
    <!-- Message realform. -->
    <xsl:call-template name="realform"/>
     
    <xsl:call-template name="menu">
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="show-submit">Y</xsl:with-param>
     <xsl:with-param name="show-save">N</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
    </xsl:call-template>
   </div>
   
   <!-- Javascript imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>
  
 <!--                                     -->  
  <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
  <!--                                     -->

  <!-- Additional javascript for this form are  -->
  <!-- added here. -->
  <xsl:template name="js-imports">
   <xsl:call-template name="system-common-js-imports">
    <xsl:with-param name="xml-tag-name">event_record</xsl:with-param>
    <xsl:with-param name="binding">misys.binding.system.event_calendar</xsl:with-param>
    <xsl:with-param name="override-home-url">'/screen/FullEventsScreen?operation=LIST_FEATURES&amp;date=<xsl:value-of select="$date"/>'</xsl:with-param>
    <xsl:with-param name="override-help-access-key">OTH_CAL</xsl:with-param>
   </xsl:call-template>
   <script>
    dojo.ready(function(){
    	misys._config = (misys._config) || {};
    	dojo.mixin(misys._config, {
    		productCode : ""
    	});
    });
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
     <xsl:with-param name="name">occurrence_id</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">company_id</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">evt_id</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">tnx_id</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
    </xsl:call-template>
   </div>
  </xsl:template>
  
  <!-- General Details -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_EVENT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <div id="generaldetails" class="calEventsDetails">
     	<xsl:choose>
     		<xsl:when test="$displaymode='edit'">
     	
		      <div id="date_type_1_row" class="field">
		        <label for="date_type_1">
		         <xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_STATIC')"/>
		        </label>
		        <div id="date_type_1_radio_div" class="inlineBlock">
			        <input dojoType="dijit.form.RadioButton" type="radio" name="date_type" id="date_type_1" value="F">
			          <xsl:if test="occurrence_id != '' or evt_id != ''">
			          	<xsl:attribute name="disabled">true</xsl:attribute>
			          </xsl:if>
			          <xsl:if test="date_type = 'S'">
			           <xsl:attribute name="checked">checked</xsl:attribute>
			          </xsl:if>
			         </input>
		         </div>
		        <div class="small" maxLength="10" id="evt_date" name="evt_date" dojoType="dijit.form.DateTextBox" trim="true">
		         <xsl:attribute name="value"><xsl:value-of select="evt_date"/></xsl:attribute>
		         <xsl:attribute name="displayedValue"><xsl:value-of select="evt_date"/></xsl:attribute>
		        </div>
		      
		      </div>
		      
		      <div id="date_type_2_row" class="field">
		        <label for="date_type_2">
		         <xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_RECURSIVE')"/>
		        </label>
		        <div id="date_type_2_radio_div" class="inlineBlock">
			        <input dojoType="dijit.form.RadioButton" type="radio" name="date_type" id="date_type_2" value="R">
			          <xsl:if test="occurrence_id != '' or evt_id != ''">
			          	<xsl:attribute name="disabled">true</xsl:attribute>
			          </xsl:if>
			          <xsl:if test="date_type = 'R'">
			           <xsl:attribute name="checked">checked</xsl:attribute>
			          </xsl:if>
			         </input>
		         </div>
		        <xsl:call-template name="hidden-field">
			    	<xsl:with-param name="name">date_recursive_type</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
			    	<xsl:with-param name="name">event_id</xsl:with-param>
			    	<xsl:with-param name="value"><xsl:value-of select="evt_id"/></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
			    	<xsl:with-param name="name">occurence_id</xsl:with-param>
			    	<xsl:with-param name="value"><xsl:value-of select="occurrence_id"/></xsl:with-param>
				</xsl:call-template>
		        
		        <div id="recursive_event_div">
			        <!-- Start date -->
			        <div id="start_date_row" class="field inlineBlock" style="margin:0px 5px;">
			         	<label for="start_date" ><xsl:value-of select="localization:getGTPString($language, 'XSL_NEWS_START_DATE')"/></label>			            
				       <div class="small" maxLength="10" id="start_date" name="start_date" dojoType="dijit.form.DateTextBox" trim="true">				         
				         <xsl:attribute name="displayedValue"><xsl:value-of select="start_date"/></xsl:attribute>
				        </div>
				     </div>
			        
				    <!-- End date -->
				    <div id="end_date_row" class="field inlineBlock" style="margin:0px 5px;">
				    <label for="end_date" style="width: 85px !important;"><xsl:value-of select="localization:getGTPString($language, 'XSL_NEWS_END_DATE')"/></label>	
				        <div class="small" maxLength="10" id="end_date" name="end_date" dojoType="dijit.form.DateTextBox" trim="true">
				         
				         <xsl:attribute name="displayedValue"><xsl:value-of select="end_date"/></xsl:attribute>
				        </div>
				    </div>
				    
				    <div id="date_recursive_type_1_row" class="field" style="margin-left:230px;">
				        <input dojoType="dijit.form.RadioButton" type="radio" style="margin-left:18px;" name="date_recursive_type_radio" id="date_recursive_type_1" value="01">
				          <xsl:if test="date_recursive_type = '01'">
				           <xsl:attribute name="checked">checked</xsl:attribute>
				          </xsl:if>
				         </input>
				         <label for="date_recursive_type_1" style="width:30px !important;" class="NoAsterik">
				         	<xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_DAILY')"/>
				        </label>
				         <!-- <span><xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_DAILY')"/></span> -->
				     </div>
				     
				     <div id="date_recursive_type_2_row" class="field" style="margin-left:230px;">
				        <input dojoType="dijit.form.RadioButton" type="radio" class="NoAsterik" style="margin-left:18px;" name="date_recursive_type_radio" id="date_recursive_type_2" value="02">
				          <xsl:if test="date_recursive_type = '02'">
				           <xsl:attribute name="checked">checked</xsl:attribute>
				          </xsl:if>
				         </input>
				         <label for="date_recursive_type_2" style="width:44px !important;" class="NoAsterik">
				         	<xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_WEEKLY')"/>
				        </label>
				         <!-- <span style="margin-right:5px;"><xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_WEEKLY')"/></span>-->
				        <select autocomplete="true" dojoType="dijit.form.FilteringSelect" style="margin-left: 7px;" name="day_of_week" id="day_of_week" class="small">
				     	  <xsl:attribute name="value"><xsl:value-of select="day_of_week"/></xsl:attribute>
				     	  <xsl:call-template name="days-of-the-week-options"/>
				     	</select>
				     </div>
				     
				     <div id="date_recursive_type_3_row" class="field" style="margin-left:230px;">   
				         <input dojoType="dijit.form.RadioButton" type="radio" style="margin-left:18px;" name="date_recursive_type_radio" id="date_recursive_type_3" value="03">
				          <xsl:if test="date_recursive_type = '03'">
				           <xsl:attribute name="checked">checked</xsl:attribute>
				          </xsl:if>
				         </input>
				          <label for="date_recursive_type_3" style="width:50px !important;" class="NoAsterik">
				        	<xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_MONTHLY')"/>
				        	</label>
				         <!-- <span style="margin-right:5px;"><xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_MONTHLY')"/></span> -->
				        <select autocomplete="true" dojoType="dijit.form.FilteringSelect" name="day_of_month" id="day_of_month" class="x-small">
				     	  <xsl:attribute name="value"><xsl:value-of select="day_of_month"/></xsl:attribute>
				     	  <xsl:call-template name="days-of-the-month-options"/>
				     	</select>
				     </div>
			    </div>
		      </div>
	      </xsl:when>
	      <xsl:otherwise>
	      	  <!--<div id="event_type_tow" class="field required">
	      	  	<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_TYPE')"/></span>
	      	  	<div class="content"><xsl:value-of select="localization:getDecode($language, 'N903', date_type)"/></div>
	      	  </div>-->
	      	  
	      	  <!--<xsl:choose>
	      	  	<xsl:when test="date_type = 'S'">-->
	      	  		<div id="event_date_tow" class="field required">
		      	  	  <span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_DATE')"/></span>
		      	  	  <div class="content"><xsl:value-of select="evt_date"/></div>
		      	    </div>
	      	  	<!--</xsl:when>
	      	  	<xsl:otherwise>
	      	  		<div id="start_date_tow" class="field required">
		      	  	  <span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_START_DATE')"/></span>
		      	  	  <div class="content"><xsl:value-of select="start_date"/></div>
		      	    </div>
		      	    <div id="end_date_tow" class="field required">
		      	  	  <span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_END_DATE')"/></span>
		      	  	  <div class="content"><xsl:value-of select="end_date"/></div>
		      	    </div>
		      	    <div id="event_occurrence_type_tow" class="field required">
		      	  	  <span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_OCCURRENCE_TYPE')"/></span>
		      	  	  <div class="content">
		      	  	  <xsl:value-of select="localization:getDecode($language, 'N904', date_recursive_type)"/>
		      	  	  <xsl:choose>
		      	  	  	<xsl:when test="date_recursive_type = '02'"> (<xsl:value-of select="localization:getDecode($language, 'N905', day_of_week)"/>)</xsl:when>
		      	  	  	<xsl:when test="date_recursive_type = '03'"> (<xsl:value-of select="day_of_month"/>)</xsl:when>
		      	  	  	<xsl:otherwise>
		      	  	  	</xsl:otherwise>
		      	  	  </xsl:choose>
		      	  	  </div>
		      	    </div>
	      	  	</xsl:otherwise>
	      	  
	      	  </xsl:choose>-->
	      	  
	      </xsl:otherwise>
	      
      	</xsl:choose>
      
      
      
      <!-- Title. -->
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_CALENDAR_TITLE</xsl:with-param>
       <xsl:with-param name="name">title</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
      </xsl:call-template>
      
      <!-- Title -->
      <xsl:call-template name="select-field">
       <xsl:with-param name="label">XSL_CALENDAR_TYPE_LABEL</xsl:with-param>
       <xsl:with-param name="name">type</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
        <xsl:with-param name="options">
         <xsl:choose>
		  <xsl:when test="$displaymode='edit'">
		    <option value="01">
	          <xsl:value-of select="localization:getGTPString($language, 'XSL_CALENDAR_TYPE_PUBLIC')"/>
	         </option>
	        <option value="02">
	         <xsl:value-of select="localization:getGTPString($language, 'XSL_CALENDAR_TYPE_PRIVATE')"/>
	        </option>
		  </xsl:when>
		  <xsl:otherwise>
		   <xsl:choose>
	        <xsl:when test="type[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CALENDAR_TYPE_PUBLIC')"/></xsl:when>
	        <xsl:when test="type[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CALENDAR_TYPE_PRIVATE')"/></xsl:when>
	       </xsl:choose>
		  </xsl:otherwise>
		 </xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
      
      <!-- Description -->
     <div id="desc_custom" class="description-calender">
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="id">evt_description</xsl:with-param>
       <xsl:with-param name="label">XSL_CALENDAR_DESCRIPTION</xsl:with-param>
       <xsl:with-param name="type">textarea</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:call-template name="textarea-field">
         <xsl:with-param name="name">description</xsl:with-param>
         <xsl:with-param name="id">evt_description</xsl:with-param>
         <xsl:with-param name="rows">10</xsl:with-param>
         <xsl:with-param name="cols">60</xsl:with-param>
         <xsl:with-param name="maxlines">25</xsl:with-param>
          <xsl:with-param name="maxlength">255</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <xsl:with-param name="button-type">phrase</xsl:with-param>
        </xsl:call-template>
       </xsl:with-param>
      </xsl:call-template>
      </div>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!--
   Hidden fields for Message
   -->
  <xsl:template name="realform">
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="e2ee_transaction"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="days-of-the-week-options">
    <option value="2">
	  <xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_MONDAY')"/>
	</option>
	<option value="3">
	  <xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_TUESDAY')"/>
	</option>
	<option value="4">
	  <xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_WEDNESDAY')"/>
	</option>
	<option value="5">
	  <xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_THURSDAY')"/>
	</option>
	<option value="6">
	  <xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_FRIDAY')"/>
	</option>
	<option value="7">
	  <xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_SATURDAY')"/>
	</option>
	<option value="1">
	  <xsl:value-of select="localization:getGTPString($language, 'XSL_EVENT_SUNDAY')"/>
	</option>
  </xsl:template>
  
  <xsl:template name="days-of-the-month-options">
    <option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	<option value="6">6</option>
	<option value="7">7</option>
	<option value="8">8</option>
	<option value="9">9</option>
	<option value="10">10</option>
	<option value="11">11</option>
	<option value="12">12</option>
	<option value="13">13</option>
	<option value="14">14</option>
	<option value="15">15</option>
	<option value="16">16</option>
	<option value="17">17</option>
	<option value="18">18</option>
	<option value="19">19</option>
	<option value="20">20</option>
	<option value="21">21</option>
	<option value="22">22</option>
	<option value="23">23</option>
	<option value="24">24</option>
	<option value="25">25</option>
	<option value="26">26</option>
	<option value="27">27</option>
	<option value="28">28</option>
	<option value="29">29</option>
	<option value="30">30</option>
	<option value="31">31</option>
  </xsl:template>
  
</xsl:stylesheet>




