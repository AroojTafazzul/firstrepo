<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for
 
Issued Stand By Letter Of Credit Free Format Form(SI), Bank Side.
 
Some templates beginning with lc- can be found in lc-common.xsl
 
date:      20/03/2015
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
 <xsl:param name="product-code">SI</xsl:param>
 <xsl:param name="main-form-name">fakeform1</xsl:param>
 <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
 <xsl:param name="show-eucp">N</xsl:param>
 
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
   <xsl:call-template name="bank-reporting-area"/>
   
   <!-- Attachments -->
   <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
    <xsl:call-template name="attachments-file-dojo">
      <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02' or type = '01']"/>
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
 
        <xsl:call-template name="lc-narrative-full">
         <xsl:with-param name="label">XSL_HEADER_STANDBY_LC_DETAILS</xsl:with-param>
        </xsl:call-template>  
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
  <xsl:with-param name="binding">misys.binding.bank.report_freeformat_si</xsl:with-param>
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
 SI General Details
 -->
<xsl:template name="general-details">
<xsl:call-template name="fieldset-wrapper">
  <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
  <xsl:with-param name="content">
  <!-- Expiry Type -->
		<xsl:if test="$swift2019Enabled and $displaymode = 'edit'"> 
			<xsl:call-template name="select-field">
			<xsl:with-param name="label">GENERALDETAILS_EXPIRY_TYPE</xsl:with-param>
			<xsl:with-param name="name">lc_exp_date_type_code</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
			 <xsl:with-param name="fieldsize">small</xsl:with-param>
			<xsl:with-param name="options">
			<xsl:call-template name="exp-date-type-code-options"/>
		     </xsl:with-param>
		    </xsl:call-template>
		</xsl:if>
		 <xsl:if test="$swift2019Enabled and $displaymode = 'view'">
			<xsl:if test="lc_exp_date_type_code[.!='']">
				<xsl:variable name="lc_exp_date_type_code"><xsl:value-of select="lc_exp_date_type_code"></xsl:value-of></xsl:variable>
				<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
				<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
				<xsl:variable name="parameterId">C085</xsl:variable>
				<xsl:call-template name="input-field">
				 	<xsl:with-param name="label">GENERALDETAILS_EXPIRY_TYPE</xsl:with-param>
				 	<xsl:with-param name="name">lc_exp_date_type_code</xsl:with-param>
				 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $lc_exp_date_type_code)"/></xsl:with-param>
				 	<xsl:with-param name="override-displaymode">view</xsl:with-param>
				 </xsl:call-template>
			</xsl:if>
		</xsl:if>
 <!-- Expiry Date -->
 <xsl:call-template name="input-field">
  <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
  <xsl:with-param name="name">exp_date</xsl:with-param>
  <xsl:with-param name="size">10</xsl:with-param>
  <xsl:with-param name="maxsize">10</xsl:with-param>
  <xsl:with-param name="type">date</xsl:with-param>
  <xsl:with-param name="fieldsize">small</xsl:with-param>
  <xsl:with-param name="required">
     <xsl:choose>
      <xsl:when test="$swift2019Enabled and lc_exp_date_type_code='01'">Y</xsl:when>
	  <xsl:when test="$swift2019Enabled and (lc_exp_date_type_code='02' or lc_exp_date_type_code='03')">N</xsl:when>      
	  <xsl:otherwise>Y</xsl:otherwise>
     </xsl:choose>
  </xsl:with-param>
  <xsl:with-param name="disabled">
    <xsl:choose>
      <xsl:when test="$swift2019Enabled and lc_exp_date_type_code='03'">Y</xsl:when>
      <xsl:otherwise>N</xsl:otherwise>
     </xsl:choose>
   </xsl:with-param>
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
  <!-- Beneficiary Details -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="button-type"></xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="address">
       <xsl:with-param name="prefix">beneficiary</xsl:with-param>
       <xsl:with-param name="show-reference">Y</xsl:with-param>
       <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
	   <xsl:with-param name="reg-exp"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_VALIDATION_REGEX')"/></xsl:with-param>       
       <xsl:with-param name="show-country">Y</xsl:with-param>
       <xsl:with-param name="required-country">Y</xsl:with-param>
       <xsl:with-param name="button-content">
          <xsl:call-template name="get-button">
	        <xsl:with-param name="button-type">beneficiary</xsl:with-param>
	        <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
	        <xsl:with-param name="non-dijit-button">Y</xsl:with-param>
	      </xsl:call-template>
       </xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template> 
 </xsl:with-param>
 </xsl:call-template>
</xsl:template>
</xsl:stylesheet>