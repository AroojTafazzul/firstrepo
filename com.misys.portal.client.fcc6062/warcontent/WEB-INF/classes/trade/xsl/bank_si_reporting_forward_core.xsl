<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Issued Standby LC (SI) Form, Bank Side.
 
 Some templates beginning with lc- can be found in lc-common.xsl

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
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
    exclude-result-prefixes="localization defaultresource utils">

  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">SI</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
  <xsl:param name="show-eucp">N</xsl:param>
  <xsl:param name="Goods_description"/>
  <xsl:param name="Documents_required"/>
  <xsl:param name="Additional_Conditions"/>
  <xsl:param name="Amendment_Narrative"/>
  <xsl:param name="Discrepant_Details"/>

  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" />
  <xsl:include href="../../core/xsl/common/lc_common.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="si_tnx_record"/>
  </xsl:template>
 
 <!-- 
   SI TNX FORM TEMPLATE.
  -->
  <xsl:template match="si_tnx_record">
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
       <xsl:with-param name="title-size">35</xsl:with-param>
      </xsl:call-template> 
	</xsl:if>
    
    <!--
    The <xsl:choose> below was present in v3, handling customer-specific requests to enable transaction editing. 
    The link should always be shown by default in v4, but the logic is kept as a comment, for reference 
    -->
   <!-- <xsl:choose>  --> 
    
    <!-- The details of the SI are only shown if the beneficiary is not defined (it means that the transaction
           has been initiated through the Upload option and some mandatory fields are still missing  -->
    <!--xsl:when test="tnx_type_code[.='01'] and attachments/attachment[type = '01']">
      <hr/>
      <p><b><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></b></p>
    </xsl:when-->
    <!-- Uncomment line to enable SI detail editing 
    <xsl:when test="tnx_type_code[.='15' or .='13' or .='01' or .='03']">
    -->
    <!-- 
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
      <xsl:if test="$displaymode='view'">
       <xsl:attribute name="style">position:relative;left:0;</xsl:attribute>
      </xsl:if>
      <!-- Form #0 : Main Form -->
      <xsl:call-template name="form-wrapper">
       <xsl:with-param name="name" select="$main-form-name"/>
       <xsl:with-param name="validating">Y</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:if test="tnx_type_code[.!='01']">
         <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
        </xsl:if>
        <!-- Disclaimer Notice -->
        <xsl:call-template name="disclaimer"/>
        <xsl:call-template name="hidden-fields"/>
        <xsl:call-template name="general-details"/>

        <xsl:call-template name="lc-amt-details">
         <xsl:with-param name="override-product-code">lc</xsl:with-param>
         <xsl:with-param name="show-bank-confirmation">N</xsl:with-param>
         <xsl:with-param name="show-outstanding-amt">Y</xsl:with-param>
         <xsl:with-param name="show-form-lc"><xsl:if test="lc_type[.='01']">Y</xsl:if></xsl:with-param>
         <xsl:with-param name="show-variation-drawing"><xsl:if test="lc_type[.='01']">Y</xsl:if></xsl:with-param>
        </xsl:call-template>

        
        <xsl:if test="lc_type[.='01']">
         <xsl:call-template name="lc-renewal-details"/>
         <xsl:call-template name="lc-bank-payment-details"/>
         <xsl:call-template name="lc-bank-shipment-details"/>
        </xsl:if>
        <xsl:if test="lc_type[.='02']">
         <xsl:call-template name="lc-narrative-full">
          <xsl:with-param name="label">XSL_HEADER_STANDBY_LC_DETAILS</xsl:with-param>
         </xsl:call-template>  
        </xsl:if>

        <xsl:if test="lc_type[.='01']">
         <xsl:call-template name="bank-details"/>
        <xsl:call-template name="lc-narrative-details">
			<xsl:with-param name="documents-required-required">
				<xsl:if test = "defaultresource:getResource('MAKE_DOCUMENTS_REQUIRED_MANDATORY') = 'true'">
					<xsl:value-of select="'Y'"/>
				</xsl:if>
				<xsl:if test = "defaultresource:getResource('MAKE_DOCUMENTS_REQUIRED_MANDATORY') = 'false'">
					<xsl:value-of select="'N'"/>
				</xsl:if>	
			</xsl:with-param>
			<xsl:with-param name="description-goods-required">
				<xsl:if test = "defaultresource:getResource('MAKE_DESC_OF_GOODS_MANDATORY') = 'true'">
					<xsl:value-of select="'Y'"/>
				</xsl:if>
				<xsl:if test = "defaultresource:getResource('MAKE_DESC_OF_GOODS_MANDATORY') = 'false'">
					<xsl:value-of select="'N'"/>
				</xsl:if>	
			</xsl:with-param>
		</xsl:call-template>
         <xsl:call-template name="lc-narrative-charges"/>
         <xsl:call-template name="lc-bank-narrative-other"/>
        </xsl:if>
       </xsl:with-param>
      </xsl:call-template>
     </div>
   <!--  </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="form-wrapper">
      <xsl:with-param name="name" select="$main-form-name"/>
      <xsl:with-param name="validating">Y</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="common-hidden-fields">
        <xsl:with-param name="override-product-code">lc</xsl:with-param>
       </xsl:call-template>
       <div>
        <xsl:call-template name="hidden-field">
         <xsl:with-param name="name">exp_date</xsl:with-param>
        </xsl:call-template>
       </div>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose> -->
   
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
   <xsl:with-param name="binding">misys.binding.bank.report_si</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="show-type">Y</xsl:with-param>
   <xsl:with-param name="override-product-code">lc</xsl:with-param>
  </xsl:call-template>
  <div class="widgetContainer">
   <!-- 
   This should only be present when we don't show the stnd_by_lc_flag checkbox, 
   which we always do at the moment
   
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">stnd_by_lc_flag</xsl:with-param>
    <xsl:with-param name="id">stnd_by_lc_flag_hidden_field</xsl:with-param>
    <xsl:with-param name="value">Y</xsl:with-param>
   </xsl:call-template>
    -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">principal_act_no</xsl:with-param>
    <xsl:with-param name="value" select="''"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">fee_act_no</xsl:with-param>
    <xsl:with-param name="value" select="''"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_lc_liab_amt</xsl:with-param>
   </xsl:call-template>
  </div>
 </xsl:template>
 
 <!-- 
  SI General Details
  -->
 <xsl:template name="general-details">
 <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
   <!-- The Issue Date needs to be shown only for a reporting, 
           it is in the reporting section for the New Upload -->
     <xsl:if test="tnx_type_code[.='15' or .='13']">
	  <!-- Issue Date -->
	  <xsl:call-template name="input-field">
	   <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
	   <xsl:with-param name="name">iss_date</xsl:with-param>
	   <xsl:with-param name="size">10</xsl:with-param>
	   <xsl:with-param name="maxsize">10</xsl:with-param>
	   <xsl:with-param name="type">date</xsl:with-param>
	   <xsl:with-param name="fieldsize">small</xsl:with-param>
	   <xsl:with-param name="required">Y</xsl:with-param>
	  </xsl:call-template>
    </xsl:if>
  
  <!-- Expiry Date -->
  <xsl:call-template name="input-field">
   <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
   <xsl:with-param name="name">exp_date</xsl:with-param>
   <xsl:with-param name="size">10</xsl:with-param>
   <xsl:with-param name="maxsize">10</xsl:with-param>
   <xsl:with-param name="type">date</xsl:with-param>
   <xsl:with-param name="fieldsize">small</xsl:with-param>
   <xsl:with-param name="required"><xsl:if test="$product-code='LC'">Y</xsl:if></xsl:with-param>
  </xsl:call-template>
  
  <!-- Expiry Place -->
  <xsl:call-template name="input-field">
   <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:with-param>
   <xsl:with-param name="name">expiry_place</xsl:with-param>
   <xsl:with-param name="maxsize">29</xsl:with-param>
  </xsl:call-template>
  
  <xsl:call-template name="input-field">
   <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_NO</xsl:with-param>
   <xsl:with-param name="name">amd_no</xsl:with-param>
   <xsl:with-param name="size">2</xsl:with-param>
   <xsl:with-param name="maxsize">3</xsl:with-param>     
   <xsl:with-param name="override-value">Y</xsl:with-param>
   <xsl:with-param name="custom-value"><xsl:value-of select="utils:formatAmdNo(amd_no)"/></xsl:with-param>
  </xsl:call-template>
  <xsl:call-template name="input-field">
   <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>
   <xsl:with-param name="name">amd_date</xsl:with-param>
   <xsl:with-param name="size">10</xsl:with-param>
   <xsl:with-param name="maxsize">10</xsl:with-param>
   <xsl:with-param name="type">date</xsl:with-param>
   <xsl:with-param name="fieldsize">small</xsl:with-param>
  </xsl:call-template>
  
  <!-- 
   Change show-eucp (global param in the main xslt of the form) to Y to show the EUCP section.
   Pass in a show-presentation parameter set to Y to display the presentation fields.
    
   If set to N, the template will instead insert a hidden field with the value 1.0
  -->
  <xsl:call-template name="eucp-details">
   <xsl:with-param name="show-eucp" select="$show-eucp"/>
  </xsl:call-template>
  
  <!-- Applicant Details. -->
  <xsl:if test="lc_type[.='01']">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
    <!-- Add applicant search popup for LC initiations on bank side -->
    <xsl:with-param name="button-type"><xsl:if test="tnx_type_code[.='01'] and release_dttm[.='']">applicant</xsl:if></xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="address">
      <xsl:with-param name="prefix">applicant</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
     </xsl:call-template>
     <xsl:choose>
      <xsl:when test="tnx_type_code[.='01'] and release_dttm[.='']">
       <xsl:call-template name="select-field">
        <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
        <xsl:with-param name="name">applicant_reference</xsl:with-param>
        <xsl:with-param name="options"><xsl:apply-templates select="customer_references/customer_reference"/></xsl:with-param>
       </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
        <xsl:with-param name="name">applicant_reference</xsl:with-param>
        <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('APPLICANT_REFERENCE_LENGTH')"/></xsl:with-param>
       </xsl:call-template>
      </xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
   
   <!-- Beneficiary Details -->
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
    <xsl:with-param name="button-type">beneficiary</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="address">
      <xsl:with-param name="show-reference">Y</xsl:with-param>
      <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
      <xsl:with-param name="prefix">beneficiary</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:if>
  </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- 
  SI Bank Details
  -->
 <xsl:template name="bank-details">
  <xsl:call-template name="tabgroup-wrapper">
   <xsl:with-param name="tabgroup-label">XSL_HEADER_BANK_DETAILS</xsl:with-param>

   <!-- Tab 1_0 - Advising Bank  -->
   <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_ADVISING_BANK</xsl:with-param>
   <xsl:with-param name="tab0-content">
    <!-- Documents Required Details -->
    <xsl:apply-templates select="advising_bank">
     <xsl:with-param name="prefix">advising_bank</xsl:with-param>
    </xsl:apply-templates> 
   </xsl:with-param>
   
   <!-- Tab 1_2 - Advise Thru Bank  -->
   <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_ADVISE_THRU_BANK</xsl:with-param>
   <xsl:with-param name="tab1-content">
    <!-- Documents Required Details -->
    <xsl:apply-templates select="advise_thru_bank">
     <xsl:with-param name="prefix">advise_thru_bank</xsl:with-param>
    </xsl:apply-templates>
   </xsl:with-param>
  </xsl:call-template> 
 </xsl:template>
 
 <!--
  Advising / Advise Thru Bank
 -->
 <xsl:template match="advising_bank | advise_thru_bank">
  <xsl:param name="prefix"/>
  
  <!-- Name. -->
  <xsl:call-template name="input-field">
   <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
   <xsl:with-param name="value" select="name"/>
   <xsl:with-param name="required">Y</xsl:with-param>
   <xsl:with-param name="button-type"><xsl:value-of select="$prefix"/></xsl:with-param>
  </xsl:call-template>
   
  <!-- Address Lines -->
  <xsl:call-template name="input-field">
   <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_1</xsl:with-param>
   <xsl:with-param name="value" select="address_line_1"/>
   <xsl:with-param name="required">Y</xsl:with-param>
  </xsl:call-template>
  <xsl:call-template name="input-field">
   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_2</xsl:with-param>
   <xsl:with-param name="value" select="address_line_2"/>
  </xsl:call-template>
  <xsl:call-template name="input-field">
   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_dom</xsl:with-param>
   <xsl:with-param name="value" select="dom"/>
  </xsl:call-template>
  <xsl:call-template name="input-field">
   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_4</xsl:with-param>
   <xsl:with-param name="value" select="address_line_4"/>
  </xsl:call-template>
  <xsl:choose>
  <xsl:when test="$prefix='advising_bank'">
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_JURISDICTION_BIC_CODE</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_iso_code</xsl:with-param>
    <xsl:with-param name="value" select="iso_code"/>
    <xsl:with-param name="size">11</xsl:with-param>
    <xsl:with-param name="maxsize">11</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_reference</xsl:with-param>
    <xsl:with-param name="value" select="reference"/>
    <xsl:with-param name="size">16</xsl:with-param>
    <xsl:with-param name="maxsize">64</xsl:with-param>
   </xsl:call-template>
  </xsl:when>
  <xsl:otherwise>
   <div>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">advise_thru_bank_iso_code</xsl:with-param>
     <xsl:with-param name="value" select="iso_code"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">advise_thru_bank_reference</xsl:with-param>
     <xsl:with-param name="value" select="reference"/>
    </xsl:call-template>
   </div>
  </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
</xsl:stylesheet>