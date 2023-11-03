<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Shipping Guarantee (SE) Form, Bank Side.

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
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    exclude-result-prefixes="localization">
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">SE</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" />

  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="se_tnx_record"/>
  </xsl:template>
 <!-- 
   SE TNX FORM TEMPLATE.
  -->
  <xsl:template match="se_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    <!-- Display common reporting area -->
    <xsl:call-template name="bank-reporting-area">
    	<xsl:with-param name="forward">Y</xsl:with-param>
    </xsl:call-template>
    <!-- Attachments -->
    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
     <xsl:call-template name="attachments-file-dojo">
       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
      </xsl:call-template> 
	</xsl:if>
    <!--
    The <xsl:choose> below was present in v3, handling customer-specific requests to enable transaction editing. 
    The link should always be shown by default in v4, but the logic is kept as a comment, for reference 
    -->
    <!-- 
    <xsl:choose>
     <xsl:when test="tnx_type_code[.='15' or .='13']">
      -->
      <!-- Link to display transaction contents -->
      <xsl:call-template name="transaction-details-link"/>
      <div id="transactionDetails">
       <xsl:call-template name="form-wrapper">
        <xsl:with-param name="name" select="$main-form-name"/>
        <xsl:with-param name="validating">Y</xsl:with-param>
        <xsl:with-param name="content">
         <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
         <!-- Disclaimer Notice -->
         <xsl:call-template name="disclaimer"/>
         <xsl:call-template name="hidden-fields"/>
         <xsl:call-template name="general-details" />
         <xsl:call-template name="free-format-message"/>
         </xsl:with-param>
        </xsl:call-template>
       </div>
      <!--  </xsl:when>
      <xsl:otherwise>
       <xsl:call-template name="form-wrapper">
        <xsl:with-param name="name" select="$main-form-name"/>
        <xsl:with-param name="validating">Y</xsl:with-param>
        <xsl:with-param name="content">
         <xsl:call-template name="common-hidden-fields"/>
         <div>
          <xsl:call-template name="hidden-field">
          <xsl:with-param name="name">exp_date</xsl:with-param>
          </xsl:call-template>
         </div>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:otherwise>
     </xsl:choose>  -->
     <xsl:call-template name="menu">
      <xsl:with-param name="show-template">N</xsl:with-param>
      <xsl:with-param name="second-menu">Y</xsl:with-param>
     <xsl:with-param name="show-submit">N</xsl:with-param>
     <xsl:with-param name="show-forward">Y</xsl:with-param>
     <xsl:with-param name="show-reject">Y</xsl:with-param>
     </xsl:call-template>
    </div>
   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>
   <!-- Javascript imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
  	<xsl:call-template name="hidden-field">
     <xsl:with-param name="name">ref_id</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">brch_code</xsl:with-param>
     <xsl:with-param name="value" select="brch_code"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">company_id</xsl:with-param>
     <xsl:with-param name="value" select="company_id"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">company_name</xsl:with-param>
     <xsl:with-param name="value" select="company_name"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">tnx_id</xsl:with-param>
     <xsl:with-param name="value" select="tnx_id"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_ctl_dttm</xsl:with-param>
     <xsl:with-param name="value" select="bo_ctl_dttm"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_inp_dttm</xsl:with-param>
     <xsl:with-param name="value" select="old_inp_dttm"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">token</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">date_time</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
	 <xsl:with-param name="name">appl_date</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
	 <xsl:with-param name="name">release_dttm</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
	 <xsl:with-param name="name">release_user_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
	 <xsl:with-param name="name">ctl_dttm</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
	 <xsl:with-param name="name">ctl_user_id</xsl:with-param>
   </xsl:call-template>
   </div>
 </xsl:template>
 <xsl:template name="js-imports">
  <xsl:call-template name="common-js-imports">
  <xsl:with-param name="binding">misys.binding.bank.report_se</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 <!-- Free format message -->
  <xsl:template name="free-format-message">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_CORRESPONDENCE_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">free_format_text_row</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">free_format_text</xsl:with-param>
        <xsl:with-param name="rows">16</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
        <xsl:with-param name="button-type"></xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="se-general-details"/>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  <xsl:template name="se-general-details">

   <!-- Instruction -->
 	<xsl:choose>
 		<xsl:when test="se_type='06' or se_type='02'">
 		   <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_PAYMENTDETAILS_SE_INSTRUCTION</xsl:with-param>
		    <xsl:with-param name="id">se_type_view</xsl:with-param>
		    <xsl:with-param name="value" select="localization:getDecode($language, 'N430', se_type)" />
		    <xsl:with-param name="override-displaymode">view</xsl:with-param>
		   </xsl:call-template>
		   <xsl:call-template name="hidden-field">
	        <xsl:with-param name="name">se_type</xsl:with-param>
	        <xsl:with-param name="value" select="se_type"/>
	       </xsl:call-template>
	       <xsl:call-template name="hidden-field">
		     <xsl:with-param name="name">topic</xsl:with-param>
		     <xsl:with-param name="value" select="localization:getDecode($language, 'N430', se_type)"/>
		   </xsl:call-template>
 		</xsl:when>
 		<xsl:otherwise>
 		   <xsl:call-template name="select-field">
			<xsl:with-param name="label">XSL_PAYMENTDETAILS_SE_INSTRUCTION</xsl:with-param>
			<xsl:with-param name="name">se_type</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
			<xsl:with-param name="options">
			  <xsl:call-template name="instruction-types"/>
			</xsl:with-param>
		   </xsl:call-template>
		   <xsl:call-template name="hidden-field">
		     <xsl:with-param name="name">topic</xsl:with-param>
		     <xsl:with-param name="value"/>
		   </xsl:call-template>
		   <div></div>
 		</xsl:otherwise>
 	</xsl:choose>
	   
   
   <!-- Ordering Account -->
   <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_PAYMENTDETAILS_SE_ORDERING_ACCOUNT</xsl:with-param>
     <xsl:with-param name="button-type">accountforbank</xsl:with-param>
     <xsl:with-param name="type">account</xsl:with-param>
     <xsl:with-param name="name">act_no</xsl:with-param>
     <xsl:with-param name="disabled">Y</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="size">34</xsl:with-param>
     <xsl:with-param name="maxsize">34</xsl:with-param>
   </xsl:call-template>
   
   
  </xsl:template>
  
  <xsl:template name="instruction-types">
  	  <xsl:choose>
	  	<xsl:when test="$displaymode='edit'">
	  		<option value="01">
		      <xsl:value-of select="localization:getDecode($language, 'N430', '01')"/>
		    </option>
		    <option value="03">
		      <xsl:value-of select="localization:getDecode($language, 'N430', '03')"/>
		     </option>
		     <option value="04">
		      <xsl:value-of select="localization:getDecode($language, 'N430', '04')"/>
		     </option>
		     <option value="05">
		      <xsl:value-of select="localization:getDecode($language, 'N430', '05')"/>
		     </option>
	  	</xsl:when>
	  	<xsl:otherwise>
	  		<option>
	  		  <xsl:attribute name="value"><xsl:value-of select="//se_type"/> </xsl:attribute>
		      <xsl:value-of select="localization:getDecode($language, 'N430', //se_type)"/>
		    </option>
	  	</xsl:otherwise>
	  </xsl:choose>

  </xsl:template>
  

  
  
  
  </xsl:stylesheet>