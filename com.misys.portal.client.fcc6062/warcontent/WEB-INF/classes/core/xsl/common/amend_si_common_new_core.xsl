<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to amendment forms (lc_amend, si_amend etc)
on the customer and bank sides.

Amendentment forms should import this template after importing
trade_common.xsl (on the customer side) or bank_common.xsl (on the bank
side).

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xd="http://www.pnp-software.com/XSLTdoc"
  xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
  xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
  xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
  xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
  exclude-result-prefixes="localization utils defaultresource security">

  <!-- Renewal details -->
   <xd:doc>
		<xd:short>Creates renewal details section.</xd:short>
		<xd:detail>
			This tempalte will create the renewal section.
		</xd:detail>
  </xd:doc>
   <xsl:template name="amend-renewal-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_RENEWAL_DETAILS_LABEL</xsl:with-param>
    <xsl:with-param name="content">
     <!-- Don't show checkbox value in summary -->
     <xsl:if test="$displaymode='edit'">
      <xsl:call-template name="checkbox-field">
       <xsl:with-param name="name">renew_flag</xsl:with-param>
       <xsl:with-param name="label">XSL_RENEWAL_ALLOWED</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_RENEWAL_RENEW_ON</xsl:with-param>
      <xsl:with-param name="name">renew_on_code</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="required">N</xsl:with-param>
      
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
	       <option value="01">
	        <xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/>
	       </option>
	       <option value="02">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CALENDAR')"/>
	       </option>
        </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="renew_on_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/></xsl:when>
          <xsl:when test="renew_on_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CALENDAR')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="name">renewal_calendar_date</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="size">10</xsl:with-param>
       <xsl:with-param name="maxsize">10</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="type">date</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_RENEWAL_RENEW_FOR</xsl:with-param>
       <xsl:with-param name="name">renew_for_nb</xsl:with-param>
       <xsl:with-param name="fieldsize">x-small</xsl:with-param>
       <xsl:with-param name="size">3</xsl:with-param>
       <xsl:with-param name="maxsize">3</xsl:with-param>
       <xsl:with-param name="override-constraints">{min:0,max:999}</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="type">integer</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="select-field">
       <xsl:with-param name="name">renew_for_period</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="options">
       <xsl:call-template name="renew-time-period-options"/>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:choose>
      <xsl:when test="$displaymode='edit'">
       <xsl:call-template name="checkbox-field">
        <xsl:with-param name="name">advise_renewal_flag</xsl:with-param>
        <xsl:with-param name="label">XSL_RENEWAL_ADVISE</xsl:with-param>
        <xsl:with-param name="disabled">Y</xsl:with-param>
       </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
      <xsl:if test="advise_renewal_flag[.!='N']  or advise_renewal_flag[. = '']">
       <div class="indented-header">
        <h3><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_ADVISE')"/></h3>
       </div>
       </xsl:if>
      </xsl:otherwise>
     </xsl:choose>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_RENEWAL_DAYS_NOTICE</xsl:with-param>
      <xsl:with-param name="name">advise_renewal_days_nb</xsl:with-param>
      <xsl:with-param name="fieldsize">x-small</xsl:with-param>
      <xsl:with-param name="size">3</xsl:with-param>
      <xsl:with-param name="maxsize">3</xsl:with-param>
      <xsl:with-param name="override-constraints">{min:0, max:999}</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="type">integer</xsl:with-param>
     </xsl:call-template>
     <xsl:choose>
      <xsl:when test="$displaymode='edit'">
       <xsl:call-template name="checkbox-field">
        <xsl:with-param name="name">rolling_renewal_flag</xsl:with-param>
        <xsl:with-param name="label">XSL_RENEWAL_ROLLING_RENEWAL</xsl:with-param>
        <xsl:with-param name="disabled">Y</xsl:with-param>
       </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
       <div class="indented-header">
        <h3><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_ROLLING_RENEWAL')"/></h3>
       </div>
      </xsl:otherwise>
     </xsl:choose>
     <xsl:if test="product_code[.='SI'] or product_code[.='BG']">
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_RENEWAL_RENEW_ON</xsl:with-param>
      <xsl:with-param name="name">rolling_renew_on_code</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
	       <option value="01">
	        <xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/>
	       </option>
	       <option value="03">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EVERY')"/>
	       </option>
        </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="rolling_renew_on_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/></xsl:when>
          <xsl:when test="rolling_renew_on_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EVERY')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$displaymode='edit' or ($displaymode='view' and rolling_renew_on_code[.='03'])">
     <xsl:call-template name="input-field">
       <xsl:with-param name="label">FREQUENCY_LABEL</xsl:with-param>
       <xsl:with-param name="name">rolling_renew_for_nb</xsl:with-param>
       <xsl:with-param name="fieldsize">x-small</xsl:with-param>
       <xsl:with-param name="size">3</xsl:with-param>
       <xsl:with-param name="maxsize">3</xsl:with-param>
       <xsl:with-param name="override-constraints">{min:0,max:999}</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="type">integer</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="select-field">
       <xsl:with-param name="name">rolling_renew_for_period</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="disabled">Y</xsl:with-param>
       <xsl:with-param name="options">
       <xsl:call-template name="renew-time-period-options"/>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_ROLLING_DAY_IN_MONTH</xsl:with-param>
       <xsl:with-param name="name">rolling_day_in_month</xsl:with-param>
       <xsl:with-param name="fieldsize">x-small</xsl:with-param>
       <xsl:with-param name="size">2</xsl:with-param>
       <xsl:with-param name="maxsize">2</xsl:with-param>
       <xsl:with-param name="override-constraints">{min:1,max:31}</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="type">integer</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     </xsl:if>
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">rolling_renewal_nb</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_NUMBER_RENEWALS</xsl:with-param>
      <xsl:with-param name="fieldsize">x-small</xsl:with-param>
      <xsl:with-param name="size">3</xsl:with-param>
      <xsl:with-param name="maxsize">3</xsl:with-param>
      <xsl:with-param name="override-constraints">{min:0, max:999}</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="type">integer</xsl:with-param>
      <xsl:with-param name="value">
      	<xsl:choose>
      		<xsl:when test="rolling_renewal_nb[.!='']"><xsl:value-of select="rolling_renewal_nb"/></xsl:when>
      		<xsl:when test="rolling_renewal_flag[.!='Y'] and renew_flag[.='Y']">1</xsl:when>
      	</xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">rolling_cancellation_days</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_CANCELLATION_NOTICE</xsl:with-param>
      <xsl:with-param name="fieldsize">x-small</xsl:with-param>
      <xsl:with-param name="size">3</xsl:with-param>
      <xsl:with-param name="maxsize">3</xsl:with-param>
      <xsl:with-param name="override-constraints">{min:0, max:999}</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="type">integer</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">renew_amount_code</xsl:with-param>
       <xsl:with-param name="id">renew_amount_code</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="renew_amt_code"/></xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="multioption-group">
      <xsl:with-param name="group-label">XSL_RENEWAL_AMOUNT</xsl:with-param>
      <xsl:with-param name="content">
 		<xsl:choose>
    		<xsl:when test="$displaymode='edit'">
			    <xsl:call-template name="radio-field">
			         <xsl:with-param name="label">XSL_RENEWAL_ORIGINAL_AMOUNT</xsl:with-param>
			         <xsl:with-param name="name">renew_amt_code</xsl:with-param>
			         <xsl:with-param name="id">renew_amt_code_1</xsl:with-param>
			         <xsl:with-param name="readonly">Y</xsl:with-param>
			         <xsl:with-param name="value">01</xsl:with-param>
			        </xsl:call-template>
			        <xsl:call-template name="radio-field">
			         <xsl:with-param name="label">XSL_RENEWAL_CURRENT_AMOUNT</xsl:with-param>
			         <xsl:with-param name="name">renew_amt_code</xsl:with-param>
			         <xsl:with-param name="id">renew_amt_code_2</xsl:with-param>
			         <xsl:with-param name="readonly">Y</xsl:with-param>
			         <xsl:with-param name="value">02</xsl:with-param>
			        </xsl:call-template>
    		</xsl:when>
    		<xsl:otherwise>
     			<xsl:choose>
      				<xsl:when test="renew_amt_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_ORIGINAL_AMOUNT')"/></xsl:when>
      				<xsl:when test="renew_amt_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CURRENT_AMOUNT')"/></xsl:when>
    	 		</xsl:choose>
    		</xsl:otherwise>
   		</xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:if test="(product_code[.='SI'] or product_code[.='BG']) and projected_expiry_date[.!='']">
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">projected_expiry_date</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_PROJECTED_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="readonly">
      	<xsl:choose>
	    	<xsl:when test="security:isBank($rundata)">N</xsl:when>
	    	<xsl:otherwise>Y</xsl:otherwise>
	    </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">final_expiry_date</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_FINAL_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="readonly">N</xsl:with-param>
      <xsl:with-param name="required">N</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field"> 
	    <xsl:with-param name="name">is_bank</xsl:with-param>
	    <xsl:with-param name="value">
	      	<xsl:choose>
		    	<xsl:when test="security:isBank($rundata)">Y</xsl:when>
		    	<xsl:otherwise>N</xsl:otherwise>
		    </xsl:choose>
	    </xsl:with-param>
	  </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!-- 
   Amend Narrative.
   -->
  <xsl:template name="amend-narrative">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMENDMENT_NARRATIVE</xsl:with-param>
    <xsl:with-param name="content">
     <!-- This empty tag is needed for this to appear, I'm not sure why. -->
     <div style="display:none">&nbsp;</div>
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="id">amd_details</xsl:with-param>
       <xsl:with-param name="type">textarea</xsl:with-param>
       <xsl:with-param name="content">
       <xsl:choose>
      	<xsl:when test="product_code[.='LC']">
        <xsl:call-template name="textarea-field">
         <xsl:with-param name="name">amd_details</xsl:with-param>
         <xsl:with-param name="phrase-params">{'category':'13'}</xsl:with-param>
         <xsl:with-param name="rows">10</xsl:with-param>
         <xsl:with-param name="cols">50</xsl:with-param>
          <!-- Increasing as per TI confirmation that filed can accormodate 15860 including CR  -->
         <xsl:with-param name="maxlines">305</xsl:with-param> 
        </xsl:call-template>
       </xsl:when>
      	<xsl:when test="product_code[.='SI']">
        <xsl:call-template name="textarea-field">
         <xsl:with-param name="name">amd_details</xsl:with-param>
         <xsl:with-param name="rows">10</xsl:with-param>
         <xsl:with-param name="cols">50</xsl:with-param>
         <xsl:with-param name="maxlines">70</xsl:with-param> 
        </xsl:call-template>
       </xsl:when>
       <xsl:when test="product_code[.='LS']">
        <xsl:call-template name="textarea-field">
         <xsl:with-param name="name">amd_details</xsl:with-param>
         <xsl:with-param name="rows">10</xsl:with-param>
         <xsl:with-param name="cols">50</xsl:with-param>
         <xsl:with-param name="maxlines">128</xsl:with-param>
        </xsl:call-template>
       </xsl:when>
       <xsl:when test="product_code[.='EC']">
        <xsl:call-template name="textarea-field">
         <xsl:with-param name="name">amd_details</xsl:with-param>
         <xsl:with-param name="rows">4</xsl:with-param>
         <xsl:with-param name="cols">50</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <xsl:with-param name="maxlines">4</xsl:with-param>
        </xsl:call-template>
       </xsl:when>
       <xsl:otherwise>
       	<xsl:call-template name="textarea-field">
         <xsl:with-param name="name">amd_details</xsl:with-param>
         <xsl:with-param name="rows">10</xsl:with-param>
         <xsl:with-param name="cols">50</xsl:with-param>
          <!-- Increasing as per TI confirmation that filed can accormodate 15860 including CR  -->
         <xsl:with-param name="maxlines">305</xsl:with-param> 
        </xsl:call-template>
       </xsl:otherwise>
       </xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
</xsl:stylesheet>