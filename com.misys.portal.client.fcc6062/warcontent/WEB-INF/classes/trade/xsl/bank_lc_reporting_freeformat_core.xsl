<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for
 
Letter Of Credit Free Format Form, Bank Side.
 
Some templates beginning with lc- can be found in lc-common.xsl
 
date:      11/03/2015
email:     shrashank.gupta@misys.com
##########################################################
-->
<xsl:stylesheet
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
   xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
   exclude-result-prefixes="localization utils">
 
 <!--
  Global Parameters.
  These are used in the imported XSL, and to set global params in the JS
 -->
 <xsl:param name="rundata"/>
 <xsl:param name="language">en</xsl:param>
 <xsl:param name="mode">DRAFT</xsl:param>
 <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
 <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
 <xsl:param name="product-code">LC</xsl:param>
 <xsl:param name="main-form-name">fakeform1</xsl:param>
 <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
 <xsl:param name="show-eucp">N</xsl:param>
 
 <!-- Global Imports. -->
 <xsl:include href="../../core/xsl/common/bank_common.xsl" />
 <xsl:include href="../../core/xsl/common/lc_common.xsl" />
 
 <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
 <xsl:template match="/">
   <xsl:apply-templates select="lc_tnx_record"/>
 </xsl:template>
 
<!--
  LC TNX FORM TEMPLATE.
 -->
 <xsl:template match="lc_tnx_record">
  <!-- Preloader  -->
  <xsl:call-template name="loading-message"/>
 
  <div>
   <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
 
   <!-- Display common reporting area -->
   <xsl:call-template name="bank-reporting-area"/>
   
   <!-- Attachments -->
   <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
    <xsl:call-template name="attachments-file-dojo">
      <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
      <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
      <xsl:with-param name="title-size">35</xsl:with-param>
    </xsl:call-template>
   </xsl:if>
   
    <!-- Link to display transaction contents -->
    <xsl:call-template name="transaction-details-link">
         <xsl:with-param name="show-transaction">
              <xsl:choose>
               <xsl:when test="tnx_type_code[.!='01'] and tnx_type_code[.!='03'] and $displaymode='edit'">N</xsl:when>
               <xsl:otherwise>Y</xsl:otherwise>
              </xsl:choose>
	     </xsl:with-param>
   		 <xsl:with-param name="show-hyperlink">
			<xsl:choose>
				<xsl:when test="(tnx_type_code[.='01'] or tnx_type_code[.='03']) and defaultresource:getResource('ENABLE_EDITING_INIT_AMEND_TNX_DETAILS_BY_BANK')='true'">Y</xsl:when>
				<xsl:when test="tnx_type_code[.='13'] and defaultresource:getResource('ENABLE_EDITING_MSG_TNX_DETAILS_BY_BANK')='true'">Y</xsl:when>
				<xsl:when test="tnx_type_code[.='15']">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
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
        <xsl:with-param name="show-form-lc">N</xsl:with-param>
   		<xsl:with-param name="show-variation-drawing">N</xsl:with-param>
       </xsl:call-template>
 
        <xsl:call-template name="lc-narrative-full"/> 
      </xsl:with-param>
     </xsl:call-template>
    </div>
  
  <xsl:call-template name="menu">
   <xsl:with-param name="show-template">N</xsl:with-param>
   <xsl:with-param name="second-menu">Y</xsl:with-param>
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
  <xsl:with-param name="binding">misys.binding.bank.report_freeformat_lc</xsl:with-param>
  <xsl:with-param name="show-period-js">Y</xsl:with-param>   
  <xsl:with-param name="override-help-access-key">
           <xsl:choose>
                <xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
                <xsl:otherwise>PR_01</xsl:otherwise>
           </xsl:choose>
  </xsl:with-param>
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
  <xsl:call-template name="hidden-field">
   <xsl:with-param name="name">org_lc_liab_amt</xsl:with-param>
  </xsl:call-template>
  <xsl:call-template name="hidden-field">
   <xsl:with-param name="name">prv_pod_stat_code</xsl:with-param>
  </xsl:call-template>
 </div>
</xsl:template>
 
<!--
 LC General Details
 -->
<xsl:template name="general-details">
<xsl:call-template name="fieldset-wrapper">
  <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
  <xsl:with-param name="content">
 <!-- Expiry Date -->
 <xsl:call-template name="input-field">
  <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
  <xsl:with-param name="name">exp_date</xsl:with-param>
  <xsl:with-param name="size">10</xsl:with-param>
  <xsl:with-param name="maxsize">10</xsl:with-param>
  <xsl:with-param name="type">date</xsl:with-param>
  <xsl:with-param name="fieldsize">small</xsl:with-param>
  <xsl:with-param name="required">Y</xsl:with-param>
 </xsl:call-template>
 
 <!-- Expiry Place -->
 <xsl:call-template name="input-field">
  <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:with-param>
  <xsl:with-param name="name">expiry_place</xsl:with-param>
  <xsl:with-param name="maxsize">29</xsl:with-param>
 </xsl:call-template>
 
 <!-- Applicant Details. -->
  <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="button-type"><xsl:if test="tnx_type_code ='01' and release_dttm =''">bank-applicant</xsl:if></xsl:with-param>
       <xsl:with-param name="content">
        <xsl:call-template name="address">
         <xsl:with-param name="show-entity">
          <xsl:choose>
           <xsl:when test="entity =''">N</xsl:when>
           <xsl:otherwise>Y</xsl:otherwise>
          </xsl:choose>
         </xsl:with-param>
         <xsl:with-param name="show-entity-button"><xsl:if test="tnx_type_code ='01'">Y</xsl:if></xsl:with-param>
         <xsl:with-param name="entity-type">bank-entity</xsl:with-param>
         <xsl:with-param name="show-abbv"><xsl:if test="tnx_type_code ='01' and release_dttm =''">Y</xsl:if></xsl:with-param>
         <xsl:with-param name="readonly"><xsl:if test="tnx_type_code ='01' and release_dttm =''">Y</xsl:if></xsl:with-param>
         <xsl:with-param name="prefix">applicant</xsl:with-param>
         <xsl:with-param name="show-reference"><xsl:if test="$displaymode='view'">Y</xsl:if></xsl:with-param>
        </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
</xsl:template>
</xsl:stylesheet>