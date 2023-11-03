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
    <xsl:call-template name="bank-reporting-area"/>
    <!-- Attachments -->
    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
     <xsl:call-template name="attachments-file-dojo">
       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '01']"/>
       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template> 
	</xsl:if>
         
      <!-- The form that is submitted -->
    <!-- <xsl:call-template name="realform"/> -->
    <!--
    The <xsl:choose> below was present in v3, handling customer-specific requests to enable transaction editing. 
    The link should always be shown by default in v4, but the logic is kept as a comment, for reference 
    -->
    <!-- 
    <xsl:choose>
     <xsl:when test="tnx_type_code[.='15' or .='13']">
      -->
      <!-- Link to display transaction contents -->
   
<!--       <xsl:call-template name="transaction-details-link"/> -->
          
      <div id="transactionDetails">
       <xsl:call-template name="form-wrapper">
        <xsl:with-param name="name" select="$main-form-name"/>
        <xsl:with-param name="validating">Y</xsl:with-param>
        <xsl:with-param name="content">
<!--          <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2> -->
<!--          Disclaimer Notice -->
<!--          <xsl:call-template name="disclaimer"/> -->
         <xsl:call-template name="hidden-fields"/>
         <xsl:call-template name="general-details" />
         <xsl:call-template name="free-format-message"/>
         </xsl:with-param>
        </xsl:call-template>
       </div>
      

     <xsl:call-template name="menu">
      <xsl:with-param name="show-template">N</xsl:with-param>
      <xsl:with-param name="second-menu">Y</xsl:with-param>
     </xsl:call-template>
    </div>
   <!-- Javascript imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
  	<xsl:call-template name="hidden-field">
     <xsl:with-param name="name">entity</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">issuing_bank_name</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">upload_file_type</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">margin_account</xsl:with-param>
    </xsl:call-template>
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
<!--    <xsl:call-template name="hidden-field">
	 <xsl:with-param name="name">ctl_dttm</xsl:with-param>
   </xsl:call-template> 
   <xsl:call-template name="hidden-field">
	 <xsl:with-param name="name">ctl_user_id</xsl:with-param>
   </xsl:call-template>-->
   </div>
 </xsl:template>
 <xsl:template name="js-imports">
  <xsl:call-template name="common-js-imports">
  <xsl:with-param name="binding">misys.binding.bank.report_se</xsl:with-param>
  <xsl:with-param name="override-help-access-key">
	   <xsl:choose>
	   	<xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
	   	<xsl:otherwise>PR_01</xsl:otherwise>
	   </xsl:choose>
   </xsl:with-param> 
  </xsl:call-template>
 </xsl:template>
 <!-- Free format message -->
  <xsl:template name="free-format-message">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_CORRESPONDENCE_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:if test="$displaymode='edit'">
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
     </xsl:if>
     <xsl:if test="$displaymode='view' and free_format_text[.!='']">
      <xsl:call-template name="big-textarea-wrapper">
      <xsl:with-param name="label">XSL_HEADER_FREE_FORMAT_TITLE</xsl:with-param>
      <xsl:with-param name="content"><div class="content">
        <xsl:value-of select="free_format_text"/>
      </div></xsl:with-param>
     </xsl:call-template>
     </xsl:if>
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
   <!-- Hidden fields. -->
   <div>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">ref_id</xsl:with-param>
    </xsl:call-template>
    <!-- Don't display this in unsigned mode. -->
    <xsl:if test="$displaymode='edit'">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">appl_date</xsl:with-param>
     </xsl:call-template>
    </xsl:if>
   </div>
   
   <!--  System ID. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
    <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
    <xsl:with-param name="value" select="ref_id" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   
   <!--  Application date. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
    <xsl:with-param name="id">appl_date_view</xsl:with-param>
    <xsl:with-param name="value" select="appl_date" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>

   

   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_ENTITY</xsl:with-param>
    <xsl:with-param name="id">general_entity_view</xsl:with-param>
    <xsl:with-param name="value" select="entity" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   


   
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
    <xsl:with-param name="id">issuing_bank_name_view</xsl:with-param>
    <xsl:with-param name="value" select="issuing_bank/name" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   

   
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
    <xsl:with-param name="id">issuing_bank_abbv_name_view</xsl:with-param>
    <xsl:with-param name="value" select="issuing_bank_abbv_name" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   

   
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">UPLOAD_FILE_TYPE</xsl:with-param>
    <xsl:with-param name="id">upload_file_type_view</xsl:with-param>
    <xsl:with-param name="value" select="upload_file_type" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   

   
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_ACCOUNT_LABEL</xsl:with-param>
    <xsl:with-param name="id">margin_account_view</xsl:with-param>
    <xsl:with-param name="value" select="margin_account" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   

 
<!--        <xsl:variable name="tmpFileTpe"><xsl:value-of select="upload_file_type"></xsl:value-of></xsl:variable>
       <xsl:value-of select="$tmpFileTpe"></xsl:value-of>
       <xsl:call-template name="select-field">
        <xsl:with-param name="label">UPLOAD_FILE_TYPE</xsl:with-param>
        <xsl:with-param name="name">upload_file_type</xsl:with-param>
			<xsl:with-param name="options">
				<xsl:for-each select="upload_file_type">
					<option>
					<xsl:attribute name="value"><xsl:value-of select="."></xsl:value-of></xsl:attribute>
					 <xsl:value-of select="." />
					</option>
				</xsl:for-each>
			</xsl:with-param>
		</xsl:call-template> -->

<!--      
       <xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_ACCOUNT_LABEL</xsl:with-param>
			<xsl:with-param name="name">margin_account</xsl:with-param>
			<xsl:with-param name="button-type">account</xsl:with-param>
			<xsl:with-param name="type">account</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
			<xsl:with-param name="maxsize">34</xsl:with-param>
      </xsl:call-template>  -->
   
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
  
<xsl:template name="realform">
   <xsl:call-template name="form-wrapper">
   <xsl:with-param name="method">POST</xsl:with-param>
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="action" select="$realform-action"/>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">referenceid</xsl:with-param>
       <xsl:with-param name="value" select="ref_id"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tnxid</xsl:with-param>
       <xsl:with-param name="value" select="tnx_id"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">mode</xsl:with-param>
       <xsl:with-param name="value" select="$mode"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">SE_GENERIC_FILE_UPLOAD</xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tnxtype</xsl:with-param>
       <xsl:with-param name="value">01</xsl:with-param>
      </xsl:call-template>

      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">fileHashCode</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      

     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  </xsl:stylesheet>