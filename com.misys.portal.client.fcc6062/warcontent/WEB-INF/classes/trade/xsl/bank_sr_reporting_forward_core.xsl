<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Received Standby LC (SR) Form, Bank Side.
 
 Note: Templates beginning with lc- are in lc_common.xsl

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
  <xsl:param name="product-code">SR</xsl:param> 
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
    <xsl:apply-templates select="sr_tnx_record"/>
  </xsl:template>
 
 <!-- 
   SR TNX FORM TEMPLATE.
  -->
  <xsl:template match="sr_tnx_record">
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
    
    <!-- Transaction details link and control -->
    <xsl:call-template name="transaction-details-link">
     <xsl:with-param name="show-transaction">
      <xsl:choose>
       <xsl:when test="tnx_type_code[.!='01']">N</xsl:when>
       <xsl:otherwise>Y</xsl:otherwise>
      </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
    
    <div id="transactionDetails">
     <xsl:if test="tnx_type_code[.='01']">
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
       <xsl:call-template name="lc-bank-general-details"/>
       <xsl:if test="sub_tnx_type_code[.='12' or .='19']">
        <xsl:call-template name="transfer-details"/>
       </xsl:if>
       
       <!-- Amt Details -->
       <xsl:call-template name="lc-amt-details">
        <xsl:with-param name="override-product-code">lc</xsl:with-param>
        <xsl:with-param name="show-bank-confirmation">Y</xsl:with-param>
        <xsl:with-param name="show-outstanding-amt">Y</xsl:with-param>
        <xsl:with-param name="show-form-lc"><xsl:if test="lc_type[.='01']">Y</xsl:if></xsl:with-param>
        <xsl:with-param name="show-variation-drawing"><xsl:if test="lc_type[.='01']">Y</xsl:if></xsl:with-param>
        <xsl:with-param name="show-standby">N</xsl:with-param>
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
       
       <!-- Narrative Details -->
       <xsl:if test="lc_type[.='01'] or lc_type[.='']">
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
   <xsl:with-param name="binding">misys.binding.bank.report_sr</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="override-product-code">lc</xsl:with-param>
  </xsl:call-template>
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">stnd_by_lc_flag</xsl:with-param>
    <xsl:with-param name="value">Y</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_lc_liab_amt</xsl:with-param>
   </xsl:call-template>
  </div>
 </xsl:template>
</xsl:stylesheet>