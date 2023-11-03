<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Financing Request (TF) Form, Bank Side.

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
  <xsl:param name="product-code">TF</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>

  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="tf_tnx_record"/>
  </xsl:template>
 
 <!-- 
   TF TNX FORM TEMPLATE.
  -->
  <xsl:template match="tf_tnx_record">
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
     <xsl:call-template name="transaction-details-link">
		<xsl:with-param name="show-transaction">
			<xsl:choose>
				<xsl:when test="tnx_type_code[.!='01'] or (tnx_type_code[.='01'] and $displaymode = 'edit')">N</xsl:when>
					<xsl:otherwise>Y</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
	</xsl:call-template>
     
     <div id="transactionDetails">
      <xsl:call-template name="form-wrapper">
       <xsl:with-param name="name" select="$main-form-name"/>
       <xsl:with-param name="validating">Y</xsl:with-param>
       <xsl:with-param name="content">
        <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
        
        <!-- Disclaimer Notice -->
        <xsl:call-template name="disclaimer"/>
        
        <xsl:call-template name="hidden-fields"/>
       
        <!-- Initiation From -->
        <xsl:call-template name="general-details"/>
        <xsl:call-template name="amt-details"/>
        
        <!-- Additional  -->
        <xsl:call-template name="fieldset-wrapper">
         <xsl:with-param name="legend">XSL_HEADER_ADDITIONAL_DETAILS</xsl:with-param>
         <xsl:with-param name="content">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="id">goods_desc</xsl:with-param>
           <xsl:with-param name="type">textarea</xsl:with-param>
           <xsl:with-param name="content">
            <xsl:call-template name="textarea-field">
             <xsl:with-param name="name">goods_desc</xsl:with-param>
             <xsl:with-param name="rows">12</xsl:with-param>
             <xsl:with-param name="required">Y</xsl:with-param>
            </xsl:call-template>
           </xsl:with-param>
          </xsl:call-template>
         </xsl:with-param>
        </xsl:call-template>
       </xsl:with-param>
      </xsl:call-template>
     </div>
    <!-- </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="form-wrapper">
      <xsl:with-param name="name" select="$main-form-name"/>
      <xsl:with-param name="validating">Y</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="common-hidden-fields">
        <xsl:with-param name="show-type">N</xsl:with-param>
       </xsl:call-template>
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
 
 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
 
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="common-js-imports">
   <xsl:with-param name="binding">misys.binding.bank.report_tf</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="show-type">N</xsl:with-param>
   <xsl:with-param name="override-product-code">tf</xsl:with-param>
  </xsl:call-template>
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">principal_act_no</xsl:with-param>
    <xsl:with-param name="value" select="''"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">fee_act_no</xsl:with-param>
    <xsl:with-param name="value" select="''"/>
   </xsl:call-template>
  </div>
 </xsl:template>
 
 <!-- 
  TF General Details
  -->
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
     <xsl:with-param name="name">iss_date</xsl:with-param>
     <xsl:with-param name="size">10</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR_DAYS</xsl:with-param>
     <xsl:with-param name="name">tenor</xsl:with-param>
     <xsl:with-param name="size">4</xsl:with-param>
     <xsl:with-param name="maxsize">4</xsl:with-param>
     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
     <xsl:with-param name="name">maturity_date</xsl:with-param>
     <xsl:with-param name="size">10</xsl:with-param>
     <xsl:with-param name="maxsize">10</xsl:with-param>
     <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_FINANCINGTYPE_LABEL</xsl:with-param>
     <xsl:with-param name="name">fin_type</xsl:with-param>
     <xsl:with-param name="fieldsize">x-large</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="options">
      <xsl:call-template name="tf-financing-types"/>
     </xsl:with-param>
    </xsl:call-template>
   
    <!-- Applicant Details -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="button-type"><xsl:if test="tnx_type_code[.='01']">applicant</xsl:if></xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="address">
       <xsl:with-param name="show-entity">
        <xsl:choose>
         <xsl:when test="entity[.='']">N</xsl:when>
         <xsl:otherwise>Y</xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="show-entity-button"><xsl:if test="tnx_type_code[.='01']">N</xsl:if></xsl:with-param>
       <xsl:with-param name="entity-required">N</xsl:with-param>
       <xsl:with-param name="prefix">applicant</xsl:with-param>
       <xsl:with-param name="show-reference">Y</xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!--
  TF Amt Details 
  -->
 <xsl:template name="amt-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="currency-field">
     <xsl:with-param name="label">XSL_AMOUNTDETAILS_GTEE_AMT_LABEL</xsl:with-param>
     <xsl:with-param name="product-code">fin</xsl:with-param>
    </xsl:call-template> 
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
     <xsl:with-param name="name">fin_liab_amt</xsl:with-param>
     <xsl:with-param name="size">20</xsl:with-param>
     <xsl:with-param name="maxsize">15</xsl:with-param>
     <xsl:with-param name="type">amount</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="value">
      <xsl:if test="fin_liab_amt[.!='']">
       <xsl:choose>
        <xsl:when test="$displaymode='view'">
         <xsl:value-of select="fin_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="fin_liab_amt"></xsl:value-of>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="fin_liab_amt"/></xsl:otherwise>
       </xsl:choose>
      </xsl:if>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
</xsl:stylesheet>