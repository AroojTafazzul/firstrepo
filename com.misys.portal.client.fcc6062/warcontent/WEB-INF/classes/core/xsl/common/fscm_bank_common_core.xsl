<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to forms on the bank side. This
stylesheet should be the first thing imported by bank-side
XSLTs.

This should be the first include for forms on the bank side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
base version: 1.9
date:      03/03/2011
author:    pavan kumar
email:     pavankumar.c@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
		xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		exclude-result-prefixes="localization converttools xmlRender security">

  <!--
   Copyright (c) 2000-2008 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
  -->
 
 <xsl:strip-space elements="*"/>
   
 <!-- Global parameters -->
 <xsl:param name="up">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:param>
 <xsl:param name="lo">abcdefghijklmnopqrstuvwxyz</xsl:param>
  
 <!--  Character encoding to use. -->
 <xsl:param name="encoding">
  <xsl:value-of select="localization:getGTPString($language, 'CHARSET')"/>
 </xsl:param>
  
 <!-- Lower-case product code -->
 <xsl:param name="lowercase-product-code">
  <xsl:value-of select="translate($product-code,$up,$lo)"/>
 </xsl:param>
 

 <!-- Local variable -->
 <xsl:variable name="realaction"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:variable>
 
 <!--
  Common includes. 
  -->

 <xsl:include href="common.xsl" />
 <xsl:include href="../../../core/xsl/common/form_templates.xsl" />
 <xsl:include href="../../../core/xsl/common/attachment_templates.xsl" />
 <xsl:include href="../../../core/xsl/common/com_cross_references.xsl"/>
  
 <!--  
  Hidden fields that are used across forms on the bank side.
 -->
 <xsl:template name="common-hidden-fields">
  <xsl:param name="show-type">Y</xsl:param>
  <xsl:param name="show-tnx-amt">Y</xsl:param>
  <xsl:param name="override-product-code" select="$lowercase-product-code"/>
  <xsl:param name="additional-fields"/>
  <div class="widgetContainer">
  	<xsl:call-template name="hidden-field">
     <xsl:with-param name="name">swiftBicCodeRegexValue</xsl:with-param>
	 <xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BIC_CHARSET')"/></xsl:with-param>
	</xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">product_code</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">ref_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">brch_code</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">tnx_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">cust_ref_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">appl_date</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">current_date</xsl:with-param>
   </xsl:call-template>
   <!-- Previous ctl date, used for synchronisation issues -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">old_ctl_dttm</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="bo_ctl_dttm" /></xsl:with-param>
   </xsl:call-template>
   <!-- Security Token -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">token</xsl:with-param>
   </xsl:call-template>
   <!-- Previous input date, used to know if the product has already been saved -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">old_inp_dttm</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="bo_inp_dttm" /></xsl:with-param>
   </xsl:call-template>
   <xsl:if test="$show-type='Y'">
    <xsl:variable name="type_name"><xsl:value-of select="$override-product-code"/>_type</xsl:variable>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name"><xsl:value-of select="$type_name" /></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="//*[name()=$type_name]" /></xsl:with-param>
    </xsl:call-template>
   </xsl:if>
   <xsl:copy-of select="$additional-fields"/>
  </div>
 </xsl:template>
 
 <!--
  Bank Reporting Area - Main Transaction Details 
  
  Common reporting area for all forms on the bank side.
  -->
 <xsl:template name="bank-reporting-area">
  <xsl:param name="option"/>
  <xsl:if test="security:isBank($rundata)">
 
  <xsl:call-template name="form-wrapper">
   <xsl:with-param name="name">fakeform0</xsl:with-param>
   <xsl:with-param name="validating">Y</xsl:with-param>
   <xsl:with-param name="content">
   
    <!--  Display common menu. -->
    <xsl:call-template name="menu">
     <xsl:with-param name="show-template">N</xsl:with-param>
    </xsl:call-template>

    <!-- Transaction Details Fieldset -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_TRANSACTION_DETAILS</xsl:with-param>
     <xsl:with-param name="button-type">
      <xsl:choose>
       <!-- Uncomment the following to always show/allow the edition from the customer -->
       <!--
       <xsl:when test="tnx_type_code[.!='15'] and not(tnx_type_code[.='01'] and product_code[.='EL' or .='SR' or .='IC' or .='IR' or .='BR']) and not(product_code[.='LC'] and release_dttm[.=''])">-->
       <xsl:when test="tnx_type_code[.!='15'] and not(tnx_type_code[.='01'] and product_code[.='EL' or .='SR' or .='IC' or .='IR' or .='BR'])">
        <xsl:choose>
         <xsl:when test="tnx_type_code[.='01']">summary-full</xsl:when>
         <xsl:otherwise>summary</xsl:otherwise>
        </xsl:choose>
       </xsl:when>
       <xsl:when test="tnx_type_code[.='15']">summary-details</xsl:when>
      </xsl:choose>
     </xsl:with-param>
     <xsl:with-param name="content">
      <!-- Hidden cross references -->
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      
      <!-- Display the company name in certain instances. -->
      <xsl:if test="$displaymode='view' or (product_code[.!='EL' and .!='SR' and .!='IC' and .!='IR' and .!='BR'] or tnx_type_code[.!='01'])">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_COMPANY_NAME</xsl:with-param>
        <xsl:with-param name="value" select="company_name" />
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      
      <xsl:if test="product_code[.='IN']">
      	<xsl:call-template name="hidden-field">
	     	<xsl:with-param name="name">old_liab_total_amt</xsl:with-param>
	     	<xsl:with-param name="value" select="liab_total_amt"/>
    	</xsl:call-template>
      </xsl:if>
      
      <xsl:variable name="product-code"><xsl:value-of select="product_code"/></xsl:variable>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_PRODUCT_CODE</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N001', $product-code)"/></xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
       <xsl:with-param name="value" select="ref_id"/>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <!-- <xsl:if test="product_code[.='LC']"> -->
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_TNX_ID</xsl:with-param>
        <xsl:with-param name="value" select="tnx_id"/>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
      <!-- </xsl:if> -->
		<xsl:if test = "fscm_program_code[.!='']">
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROGRAM</xsl:with-param>
				 <xsl:with-param name="name">fscm_program</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N084',fscm_program_code )"/></xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
		        <xsl:with-param name="name">fscm_program_code</xsl:with-param>
		     </xsl:call-template>
		</xsl:if>
	
      <xsl:if test="product_code[.='EL' or .='SR']">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_IMPORT_LC_REF_ID</xsl:with-param>
        <xsl:with-param name="value" select="lc_ref_id"/>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:if test="not(tnx_id) or tnx_type_code[.!='01']">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
        <xsl:with-param name="value" select="bo_ref_id"/>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
        <xsl:if test="product_code[.!='IP' and .!='IN' and .!='CN']">
	       <xsl:call-template name="hidden-field">
	        <xsl:with-param name="name">bo_ref_id</xsl:with-param>
	       </xsl:call-template>
	    </xsl:if>
      </xsl:if>
      <xsl:if test="cross_references">
       <xsl:apply-templates select="cross_references" mode="display_table_tnx"/>
      </xsl:if>
      <xsl:if test="(cross_references/cross_reference/type_code ='02') and (child_product_code != product_code)">
       <xsl:variable name="parent_file" select="xmlRender:getXMLMasterNode(cross_references/cross_reference[./type_code='02']/product_code, cross_references/cross_reference[./type_code='02']/ref_id, $language)"/>
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
        <xsl:with-param name="value" select="$parent_file/bo_ref_id"/>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:if test="product_code[.='LI']">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
        <xsl:with-param name="value" select="alt_lc_ref_id"/>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_TRANSACTION_TYPE</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:choose>
         <xsl:when test="tnx_type_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_01_NEW')"/></xsl:when>
         <xsl:when test="tnx_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_02_UPDATE')"/></xsl:when>
         <xsl:when test="tnx_type_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_03_AMEND')"/></xsl:when>
         <xsl:when test="tnx_type_code[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_04_EXTEND')"/></xsl:when>
         <xsl:when test="tnx_type_code[. = '05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_05_ACCEPT')"/></xsl:when>
         <xsl:when test="tnx_type_code[. = '06']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_06_CONFIRM')"/></xsl:when>
         <xsl:when test="tnx_type_code[. = '07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_07_CONSENT')"/></xsl:when>
         <xsl:when test="tnx_type_code[. = '08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_08_SETTLE')"/></xsl:when>
         <xsl:when test="tnx_type_code[. = '09']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_09_TRANSFER')"/></xsl:when>
         <xsl:when test="tnx_type_code[. = '10']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_10_DRAWDOWN')"/></xsl:when>
         <xsl:when test="tnx_type_code[. = '11']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_11_REVERSE')"/></xsl:when>
         <xsl:when test="tnx_type_code[. = '12']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_12_DELETE')"/></xsl:when>
         <xsl:when test="tnx_type_code[. = '13']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_13_INQUIRE')"/></xsl:when>
         <xsl:when test="tnx_type_code[. = '14']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_14_CANCEL')"/></xsl:when>
         <xsl:when test="tnx_type_code[. = '15']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_15_REPORTING')"/></xsl:when>
         <xsl:when test="tnx_type_code[. = '16']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_16_REINSTATE')"/></xsl:when>
         <xsl:when test="tnx_type_code[. = '17']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_17_PURGE')"/></xsl:when>
         <xsl:when test="tnx_type_code[. = '18']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_18_PRESENT')"/></xsl:when>
         <xsl:when test="tnx_type_code[. = '19']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_19_ASSIGN')"/></xsl:when>
        </xsl:choose>
        <xsl:if test="sub_tnx_type_code[. != '']">&nbsp;
         <xsl:choose>
          <xsl:when test="sub_tnx_type_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_01_INCREASE')"/></xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_02_DECREASE')"/></xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_03_TERMS')"/></xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_04_UPLOAD')"/></xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_05_RELEASE')"/></xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '06']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_06_BACK_TO_BACK')"/></xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_07_GENERATION')"/></xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_08_DISCREPANT_ACK')"/></xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '09']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_09_DISCREPANT_NACK')"/></xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '11']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '16']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
         </xsl:choose>
        </xsl:if>
       </xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      
      <xsl:if test="related_ref_id">
      <xsl:variable name="related_prod_code"><xsl:value-of select="substring(related_ref_id,1,2)"/></xsl:variable>
      	<xsl:call-template name="row-wrapper">
           	<xsl:with-param name="label">XSL_RELATED_REFERENCE</xsl:with-param>
           	<xsl:with-param name="id">related_ref_id</xsl:with-param>
           	<xsl:with-param name="override-displaymode">view</xsl:with-param>
           	<xsl:with-param name="content">
	            <xsl:element name="a">
	           		<xsl:attribute name="href">javascript:void(0)</xsl:attribute>
	           		<xsl:attribute name="onclick">misys.popup.showReporting('DETAILS','<xsl:value-of select="$related_prod_code"/>','<xsl:value-of select="related_ref_id"/>');return false;</xsl:attribute>
	           		<xsl:value-of select="related_ref_id"/>
	          	</xsl:element>
        	</xsl:with-param>
     	</xsl:call-template>
     </xsl:if>

	  <xsl:if test="product_code[.='EL'] and tnx_type_code[.!='01']">
	   <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_BILL_REF_ID</xsl:with-param>
        <xsl:with-param name="name">imp_bill_ref_id</xsl:with-param>
        <xsl:with-param name="maxsize">35</xsl:with-param>
        <xsl:with-param name="required">N</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
        <xsl:with-param name="name">maturity_date</xsl:with-param>
        <xsl:with-param name="required">N</xsl:with-param>
        <xsl:with-param name="size">10</xsl:with-param>
        <xsl:with-param name="fieldsize">small</xsl:with-param>
        <xsl:with-param name="type">date</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <div>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">tnx_type_code</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
        <xsl:with-param name="value">
         <xsl:choose>
          <xsl:when test="lc_type [.='02']">11</xsl:when>
          <xsl:otherwise><xsl:value-of select="sub_tnx_type_code" /></xsl:otherwise>
         </xsl:choose>
        </xsl:with-param>
       </xsl:call-template>
      </div>
      <xsl:if test="release_dttm[.!='']">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_RELEASE_DTTM</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="converttools:formatReportDate(release_dttm,$rundata,'SHORT','FULL')"/></xsl:with-param>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:if test="tnx_type_code[.='01'] and product_code[.='LC' or .='SI' or .='SG' or .='LI' or .='BG'] and not(issuing_bank_type_code[.='02'])">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
        <xsl:with-param name="name">iss_date</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
        <xsl:with-param name="size">10</xsl:with-param>
        <xsl:with-param name="fieldsize">small</xsl:with-param>
        <xsl:with-param name="type">date</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:if test="tnx_type_code[.='03']">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_NO</xsl:with-param>
        <xsl:with-param name="name">amd_no</xsl:with-param>
        <xsl:with-param name="type">number</xsl:with-param>
        <xsl:with-param name="size">2</xsl:with-param>
        <xsl:with-param name="maxsize">3</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>
        <xsl:with-param name="name">amd_date</xsl:with-param>
        <xsl:with-param name="size">10</xsl:with-param>
        <xsl:with-param name="fieldsize">small</xsl:with-param>
        <xsl:with-param name="type">date</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:if test="($displaymode='view' and tnx_type_code[.='15']) and (product_code[.='EL' or .='LC' or .='LI' or .='RI' or .='SG' or .='TF'])">
      	<xsl:call-template name="transaction_popup"/>
      </xsl:if>
     </xsl:with-param>
    </xsl:call-template>
  
    <!-- Reporting Details Fieldset. -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_REPORTING_DETAILS</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:choose>
       <!-- If the reporting message is an initial notification of EL, SR, IC or IR or BR -->
       <xsl:when test="tnx_type_code[.='01'] and product_code[.='EL' or .='SR' or .='IC' or .='IR' or .='BR' or .='RI']">
        <div>
         <xsl:call-template name="hidden-field">
          <xsl:with-param name="name">prod_stat_code</xsl:with-param>
          <xsl:with-param name="value">03</xsl:with-param>
         </xsl:call-template>
        </div>
       </xsl:when>
       <xsl:when test="tnx_type_code[.='13'] and (sub_tnx_type_code[.='08'] or sub_tnx_type_code[.='16'])">
        <xsl:call-template name="select-field">
         <xsl:with-param name="label">XSL_REPORTINGDETAILS_NEW_TNX_STAT_LABEL</xsl:with-param>
         <xsl:with-param name="name">prod_stat_code</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <xsl:with-param name="fieldsize">large</xsl:with-param>
         <xsl:with-param name="options"><xsl:call-template name="bank-prod-stat-codes"/></xsl:with-param>
        </xsl:call-template>
        <!-- Subject -->
        <xsl:call-template name="input-field">
           <xsl:with-param name="label">SUBJECT</xsl:with-param>
           <xsl:with-param name="name">subject</xsl:with-param>
           <xsl:with-param name="required">Y</xsl:with-param>
           <xsl:with-param name="maxsize">35</xsl:with-param>
           <xsl:with-param name="fieldsize">large</xsl:with-param>
        </xsl:call-template>
        <xsl:if test="$displaymode='edit' or ($displaymode='view' and tnx_amt[.!=''])">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_DOCS_AMT_LABEL</xsl:with-param>
           <xsl:with-param name="name">tnx_amt</xsl:with-param>
           <xsl:with-param name="size">20</xsl:with-param>
           <xsl:with-param name="maxsize">15</xsl:with-param>
           <xsl:with-param name="type">amount</xsl:with-param>
           <xsl:with-param name="fieldsize">small</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         <xsl:if test="product_code[.!='PO'] and product_code[.!='EL']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
           <xsl:with-param name="name">maturity_date</xsl:with-param>
           <xsl:with-param name="size">10</xsl:with-param>
           <xsl:with-param name="maxsize">10</xsl:with-param>
           <xsl:with-param name="type">date</xsl:with-param>
           <xsl:with-param name="fieldsize">small</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
        
      
        <xsl:if test="product_code[.='PO']">
         <div class="field">
          <div class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_UTILIZATION_FINANCING_REQUEST_ACK')"/></div>
          <div class="content"></div>
         </div>
        </xsl:if>
       </xsl:when>
       <!-- Else if the reporting is a response to a discrepant customer nack --> 
       <xsl:when test="tnx_type_code[.='13'] and sub_tnx_type_code[.='09']">
        <xsl:call-template name="select-field">
         <xsl:with-param name="label">XSL_REPORTINGDETAILS_NEW_TNX_STAT_LABEL</xsl:with-param>
         <xsl:with-param name="name">prod_stat_code</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <xsl:with-param name="fieldsize">large</xsl:with-param>
         <xsl:with-param name="options">
          <xsl:choose>
           <xsl:when test="$displaymode='edit'">
            <option value="07">
             <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_07_UPDATED')"/>
            </option>
            <option value="01">
             <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/>
            </option>
           </xsl:when>
           <xsl:otherwise>
            <xsl:choose>
             <xsl:when test="prod_stat_code[.='07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_07_UPDATED')"/></xsl:when>
             <xsl:when test="prod_stat_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/></xsl:when>
            </xsl:choose>
           </xsl:otherwise>
          </xsl:choose>
         </xsl:with-param>
        </xsl:call-template>
        <!-- Subject -->
        <xsl:call-template name="input-field">
           <xsl:with-param name="label">SUBJECT</xsl:with-param>
           <xsl:with-param name="name">subject</xsl:with-param>
           <xsl:with-param name="maxsize">35</xsl:with-param>
           <xsl:with-param name="required">Y</xsl:with-param>
           <xsl:with-param name="fieldsize">large</xsl:with-param>
         </xsl:call-template>
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_AMOUNTDETAILS_DOCS_AMT_LABEL</xsl:with-param>
         <xsl:with-param name="name">tnx_amt</xsl:with-param>
         <xsl:with-param name="size">20</xsl:with-param>
         <xsl:with-param name="maxsize">15</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <xsl:with-param name="type">amount</xsl:with-param>
         <xsl:with-param name="fieldsize">small</xsl:with-param>
        </xsl:call-template>
       </xsl:when>
       <!-- Else if the reporting message is a reply to a customer transaction record (not EL, SR or IC) -->
       <xsl:when test="tnx_type_code[.!='15']">
        <xsl:variable name="prod-stat-value">
         <xsl:choose>
          <!-- Conversion of tnx type code NEW to tnx status code NEW -->
          <xsl:when test="tnx_type_code[. = '01']">03</xsl:when>
          <!-- Conversion of tnx type code AMEND to tnx status code AMENDED (when it is not a BG Release) -->
          <xsl:when test="tnx_type_code[. = '03'] and (product_code[.='LC' or .='SI'] or bg_release_flag[.!='Y'])">08</xsl:when>
          <!-- Conversion of tnx type code AMEND to tnx status code RELEASED (when it is a BG Release) -->
          <xsl:when test="tnx_type_code[. = '03'] and product_code[.='BG'] and bg_release_flag[.='Y']">11</xsl:when>
          <!-- Conversion of tnx type code PRESENT to tnx status code Accepted-->
          <xsl:when test="tnx_type_code[. = '18'] and product_code[.='DM']">04</xsl:when>
          <!-- Conversion of tnx type code CONSENT to tnx status code Established (PO/SO)-->
          <xsl:when test="tnx_type_code[. = '07'] and product_code[.='PO' or .='SO']">32</xsl:when>
          <!-- Conversion of the other tnx type codes to tnx status code UPDATED -->
          <xsl:when test="sub_tnx_type_code and sub_tnx_type_code[.='85' or .='78' or .='91' or .='A0' or .='A2']">04</xsl:when>
          <xsl:otherwise>07</xsl:otherwise>
         </xsl:choose>
        </xsl:variable>
	    <xsl:if test="eligibility_flag">
	        <xsl:call-template name="hidden-field">
	        	<xsl:with-param name="name">eligibility_flag</xsl:with-param>
	        	<xsl:with-param name="value"><xsl:value-of select="eligibility_flag"/></xsl:with-param>
         	</xsl:call-template>
	    </xsl:if>
	    
	    <xsl:if test="finance_requested_flag">
	        <xsl:call-template name="hidden-field">
	        	<xsl:with-param name="name">finance_requested_flag</xsl:with-param>
	        	<xsl:with-param name="value"><xsl:value-of select="finance_requested_flag"/></xsl:with-param>
         	</xsl:call-template>
	    </xsl:if>
	    
	    <xsl:if test="finance_offer_flag">
	        <xsl:call-template name="hidden-field">
	        	<xsl:with-param name="name">finance_offer_flag</xsl:with-param>
	        	<xsl:with-param name="value"><xsl:value-of select="finance_offer_flag"/></xsl:with-param>
         	</xsl:call-template>
	    </xsl:if>
	    <xsl:if test="fscm_programme_code">
	        <xsl:call-template name="hidden-field">
	        	<xsl:with-param name="name">fscm_programme_code</xsl:with-param>
	        	<xsl:with-param name="value"><xsl:value-of select="fscm_programme_code"/></xsl:with-param>
         	</xsl:call-template>
	    </xsl:if>
        <xsl:call-template name="select-field">
         <xsl:with-param name="label">XSL_REPORTINGDETAILS_PROD_STAT_LABEL</xsl:with-param>
         <xsl:with-param name="name">prod_stat_code</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <xsl:with-param name="value">
          <xsl:choose>
           <xsl:when test="prod_stat_code[.!='01']">
            <xsl:value-of select="$prod-stat-value"/>
           </xsl:when>
           <xsl:otherwise>01</xsl:otherwise>
          </xsl:choose>
         </xsl:with-param>
         <xsl:with-param name="options">
          <xsl:choose>
           <xsl:when test="$displaymode='edit'">
            <option>
             <xsl:attribute name="value">
              <xsl:value-of select="$prod-stat-value"/>
             </xsl:attribute>
             <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_APPROVED')"/>
            </option>
            <option value="01">
             <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/>
            </option>
           </xsl:when>
           <xsl:otherwise>
            <xsl:choose>
             <xsl:when test="prod_stat_code[.='03'] or prod_stat_code[.='08'] or prod_stat_code[.='07'] or prod_stat_code[.='05'] or prod_stat_code[.='04'] or prod_stat_code[.='11']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_APPROVED')"/></xsl:when>
             <xsl:when test="prod_stat_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/></xsl:when>
            </xsl:choose>
           </xsl:otherwise>
          </xsl:choose>
         </xsl:with-param>
        </xsl:call-template>
       </xsl:when>
       <!-- Else if the reporting is a new message initiated by the bank (not EL, SR or IC New) -->
       <!-- Also added for EL and SR -->
       <xsl:otherwise>
        <xsl:call-template name="select-field">
         <xsl:with-param name="label">XSL_REPORTINGDETAILS_NEW_TNX_STAT_LABEL</xsl:with-param>
         <xsl:with-param name="name">prod_stat_code</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <xsl:with-param name="fieldsize">large</xsl:with-param>
         <xsl:with-param name="options"><xsl:call-template name="po-prod-stat-codes"/></xsl:with-param>
        </xsl:call-template>
        <!-- Financial Eligibility Status for Invoices  -->
        <xsl:variable name="eligibilityEnabled">
        	<xsl:choose>
        		<xsl:when test="product_code[.='IN'] and fscm_programme_code[.!='' and .!='01' and .!='05' and .!='06']">
		        	<xsl:choose>
		        		<xsl:when test="fscm_programme_code[.='03'] and finance_requested_flag[.='']">N</xsl:when>
		        		<xsl:otherwise>Y</xsl:otherwise>
		        	</xsl:choose>
        		</xsl:when>
        		<xsl:when test="product_code[.='IP'] and (fscm_programme_code !='' and (fscm_programme_code = '05' or fscm_programme_code = '06')) and (eligibility_flag = 'P' or (eligibility_flag = 'E' and tnx_stat_code = '05'))">Y</xsl:when>
        		<xsl:otherwise>N</xsl:otherwise>
        	</xsl:choose>
        </xsl:variable>
        <xsl:if test="$eligibilityEnabled = 'Y'">
         <xsl:variable name="eligibility_flag">
         	<xsl:value-of select="eligibility_flag"/>
         </xsl:variable>
          <xsl:variable name="org_eligibility_flag">
         	<xsl:value-of select="org_eligibility_flag"/>
         </xsl:variable>
         <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_REPORTINGDETAILS_ELIGIBILITY_STATUS_LABEL</xsl:with-param>
           <xsl:with-param name="id">eligibility_flag_content</xsl:with-param>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
           <xsl:with-param name="content"><div class="content" id = "eligibility_content">
            	<xsl:value-of select="localization:getDecode($language, 'N085',$eligibility_flag)"/>
            </div>
           </xsl:with-param>
          </xsl:call-template>
          <xsl:if test="$mode = 'UNSIGNED'">
	          <xsl:call-template name="hidden-field">
		         <xsl:with-param name="name">eligibility_flag</xsl:with-param>
		         <xsl:with-param name="value"><xsl:value-of select="eligibility_flag"/></xsl:with-param>
	         </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="hidden-field">
	         <xsl:with-param name="name">org_eligibility_flag</xsl:with-param>
	         <xsl:with-param name="value"><xsl:value-of select="org_eligibility_flag"/></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="hidden-field">
	         <xsl:with-param name="name">finance_requested_flag</xsl:with-param>
	         <xsl:with-param name="value"><xsl:value-of select="finance_requested_flag"/></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="hidden-field">
	         <xsl:with-param name="id">org_eligibility_content</xsl:with-param>
	         <xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N085',$org_eligibility_flag)"/></xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        <!-- Subject -->
        <xsl:if test="product_code[.!='CN']">
	       <xsl:call-template name="input-field">
	          <xsl:with-param name="label">SUBJECT</xsl:with-param>
	          <xsl:with-param name="name">subject</xsl:with-param>
	          <xsl:with-param name="maxsize">35</xsl:with-param>
	          <xsl:with-param name="required">Y</xsl:with-param>
	          <xsl:with-param name="fieldsize">large</xsl:with-param>
	       </xsl:call-template>
        </xsl:if>
        <!-- For LC or SI, the documents amount and maturity date may be used 
             when ACCEPTED, DISCREPANT, PAID AT SIGHT, PARTIALLY PAID AT SIGHT,
             SETTLED or PARTIALLY SETTLED  -->
        <!-- Also added for EL and SR -->
        <xsl:if test="product_code[.='LC' or .='SI' or .='EL' or .='SR' or .='IC' or .='EC']">
         <xsl:if test="$displaymode='edit' or ($displaymode='view' and tnx_amt[.!=''])">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_DOCS_AMT_LABEL</xsl:with-param>
           <xsl:with-param name="name">tnx_amt</xsl:with-param>
           <xsl:with-param name="size">20</xsl:with-param>
           <xsl:with-param name="maxsize">15</xsl:with-param>
           <xsl:with-param name="type">amount</xsl:with-param>
           <xsl:with-param name="fieldsize">small</xsl:with-param>
          </xsl:call-template>
          <!--  <b style="display:inline;float:right;width:50px">(
            <xsl:choose>
             <xsl:when test="product_code[.='EC']"><xsl:value-of select="ec_cur_code"/></xsl:when>
             <xsl:when test="product_code[.='IC']"><xsl:value-of select="ic_cur_code"/></xsl:when>
             <xsl:when test="product_code[.='IR']"><xsl:value-of select="ir_cur_code"/></xsl:when>
             <xsl:when test="product_code[.='PO' or .='SO' or .='IO']"><xsl:value-of select="total_cur_code"/></xsl:when>
             <xsl:otherwise><xsl:value-of select="lc_cur_code"/></xsl:otherwise>
            </xsl:choose>
          )</b>-->
         </xsl:if>
         <xsl:if test="product_code[.!='PO' and .!='SO' and .!='IN' and .!='EL']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
           <xsl:with-param name="name">maturity_date</xsl:with-param>
           <xsl:with-param name="size">10</xsl:with-param>
           <xsl:with-param name="maxsize">10</xsl:with-param>
           <xsl:with-param name="type">date</xsl:with-param>
           <xsl:with-param name="fieldsize">small</xsl:with-param>
          </xsl:call-template>
          
          <xsl:if test="$displaymode='edit' or ($displaymode='view' and tnx_amt[.!='']) and product_code[.='LC']">
	          <xsl:call-template name="input-field">
		           <xsl:with-param name="label">XSL_IB_REFERENCE_LABEL</xsl:with-param>
		           <xsl:with-param name="name">ibReference</xsl:with-param>
		           <xsl:with-param name="maxsize">35</xsl:with-param>
		           <xsl:with-param name="fieldsize">large</xsl:with-param>
		        </xsl:call-template>
	       </xsl:if>
          
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_REPORTINGDETAILS_LATEST_ANSWER_DATE</xsl:with-param>
           <xsl:with-param name="name">latest_answer_date</xsl:with-param>
           <xsl:with-param name="size">10</xsl:with-param>
           <xsl:with-param name="maxsize">10</xsl:with-param>
           <xsl:with-param name="type">date</xsl:with-param>
           <xsl:with-param name="fieldsize">small</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
        </xsl:if>
       </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="tnx_type_code[. = '01'] or (product_code[.='PO' or .='IN' or .='IP' or .='CN'] and bo_ref_id[.=''])">
        <xsl:choose>
      	  <xsl:when test="preallocated_flag[.='Y'] and bo_ref_id[.!='']">
      	   <xsl:call-template name="input-field">
	        <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
	        <xsl:with-param name="value"><xsl:value-of select="bo_ref_id"/> </xsl:with-param>
	        <xsl:with-param name="override-displaymode">view</xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="hidden-field">
	         <xsl:with-param name="name">bo_ref_id</xsl:with-param>
	       </xsl:call-template>
      	  </xsl:when>
      	  <xsl:otherwise>
      	   <xsl:call-template name="input-field">
	        <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
	        <xsl:with-param name="name">bo_ref_id</xsl:with-param>
	        <xsl:with-param name="required">Y</xsl:with-param>
	        <xsl:with-param name="size">16</xsl:with-param>
	        <xsl:with-param name="maxsize">16</xsl:with-param>
	       </xsl:call-template>
      	  </xsl:otherwise>
      	
      	</xsl:choose>
      
      
      
      </xsl:if>
      <!-- Display the Cover Letter generation choice for a Direct Collection -->
       <xsl:if test="product_code[. = 'EC'] and ec_type_code[.='02']">
         <xsl:call-template name="multichoice-field">
     		 <xsl:with-param name="type">checkbox</xsl:with-param>
	         <xsl:with-param name="label">XSL_REPORTINGDETAILS_DIR_COLL_LETTER_LABEL</xsl:with-param>
	         <xsl:with-param name="name">dir_coll_letter_flag</xsl:with-param>
	         <xsl:with-param name="checked"><xsl:if test="dir_coll_letter_flag[. = 'Y']">Y</xsl:if></xsl:with-param>
        </xsl:call-template>
        
        <!--<div class="field" style="padding-left:175px;">
		  <xsl:call-template name="get-button">
		   <xsl:with-param name="button-type">document</xsl:with-param>
		   <xsl:with-param name="override-form-name">fakeform0</xsl:with-param>
		  </xsl:call-template>
       </div>
        
       --></xsl:if>
       <xsl:if test="product_code[. = 'IP' or .='IN']">
       	<xsl:call-template name="currency-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_AMOUNT</xsl:with-param>
     			<xsl:with-param name="product-code">total_net</xsl:with-param>
     			<xsl:with-param name="show-amt">Y</xsl:with-param>
     			<xsl:with-param name="override-currency-value"><xsl:value-of select="total_net_cur_code"/></xsl:with-param>
     			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
     			<xsl:with-param name="swift-validate">N</xsl:with-param>
     			<xsl:with-param name="currency-readonly">Y</xsl:with-param>
     			<xsl:with-param name="show-button">N</xsl:with-param>
     			<xsl:with-param name="amt-readonly">Y</xsl:with-param>
     			<xsl:with-param name="currency-readonly">Y</xsl:with-param>
   		</xsl:call-template>
   		<xsl:choose>
	   		<xsl:when test="sub_tnx_type_code and sub_tnx_type_code[.='85' or .='78' or .='A2' or .='A0']">
	   			<xsl:choose>
		   			<xsl:when test="$mode != 'UNSIGNED'">
			   			<xsl:call-template name="checkbox-field">
								<xsl:with-param name="label">XSL_GENERALDETAILS_IN_FULL_FINANCING_FLAG</xsl:with-param>
				     			<xsl:with-param name="name">full_finance_accepted_flag</xsl:with-param>
				     			<xsl:with-param name="value"><xsl:value-of select="full_finance_accepted_flag"/></xsl:with-param>
				     			<xsl:with-param name="checked">
				     				<xsl:choose>
				     					<xsl:when test="full_finance_accepted_flag[.='N']">N</xsl:when>
				     					<xsl:otherwise>Y</xsl:otherwise>
				     				</xsl:choose>
				     			</xsl:with-param>
				   		</xsl:call-template>
				   	</xsl:when>
				   	<xsl:otherwise>
				   		<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_GENERALDETAILS_IN_FULL_FINANCING_FLAG_LABEL</xsl:with-param>
				           	<xsl:with-param name="name">full_finance_accepted_flag_view</xsl:with-param>
				           	<xsl:with-param name="value">
				           		<xsl:value-of select="localization:getDecode($language, 'N034', full_finance_accepted_flag)" />
				           	</xsl:with-param>
	           			</xsl:call-template>
				   	</xsl:otherwise>
				 </xsl:choose>
				 <xsl:if test="inv_eligible_amt[.!='']">
					 <xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_ELIGIBLE_AMT</xsl:with-param>
			           	<xsl:with-param name="product-code">requested</xsl:with-param>
			           	<xsl:with-param name="override-currency-value">
			     				<xsl:value-of select="inv_eligible_cur_code"/>
			     			</xsl:with-param>
			           	<xsl:with-param name="override-amt-value">
			           		<xsl:value-of select="inv_eligible_amt" />
			           	</xsl:with-param>
			           	<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
			           	<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
	          		</xsl:call-template>
          		</xsl:if>
		   		<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_ELIGIBLE_AMOUNT</xsl:with-param>
		     			<xsl:with-param name="product-code">inv_eligible</xsl:with-param>
		     			<xsl:with-param name="show-amt">Y</xsl:with-param>
		     			<xsl:with-param name="override-currency-value">
		     				<xsl:value-of select="total_net_cur_code"/>
		     			</xsl:with-param>
		     			<xsl:with-param name="swift-validate">N</xsl:with-param>
		     			<xsl:with-param name="show-button">N</xsl:with-param>
		     			<xsl:with-param name="amt-readonly">
		     				<xsl:choose>
		     					<xsl:when test="full_finance_accepted_flag[.='N']">N</xsl:when>
		     					<xsl:otherwise>Y</xsl:otherwise>
		     				</xsl:choose>
		     			</xsl:with-param>
		     			<xsl:with-param name="currency-readonly">Y</xsl:with-param>
		     			<xsl:with-param name="override-amt-value">
		     				<xsl:choose>
		     					<xsl:when test="inv_eligible_amt[.=''] and full_finance_accepted_flag[.!='N']">
		     						<xsl:value-of select="total_net_amt"/>
		     					</xsl:when>
		     					<xsl:otherwise>
		     						<xsl:value-of select="inv_eligible_amt"/>
		     					</xsl:otherwise>
		     				</xsl:choose>
		     			</xsl:with-param>
		   		</xsl:call-template>
		   		<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">org_inv_eligible_amt</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="inv_eligible_amt"/></xsl:with-param>				
				</xsl:call-template>
		   		<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_GENERALDETAILS_IN_FINANCE_AMOUNT</xsl:with-param>
		     			<xsl:with-param name="product-code">finance</xsl:with-param>
		     			<xsl:with-param name="show-amt">Y</xsl:with-param>
		     			<xsl:with-param name="override-currency-value">
		     				<xsl:choose>
		     					<xsl:when test="finance_cur_code !=''">
		     						<xsl:value-of select="finance_cur_code"/>
		     					</xsl:when>
		     					<xsl:otherwise>
		     						<xsl:value-of select="total_net_cur_code"/>
		     					</xsl:otherwise>
		     				</xsl:choose>
		     			</xsl:with-param>
		     			<xsl:with-param name="swift-validate">N</xsl:with-param>
		     			<xsl:with-param name="show-button">Y</xsl:with-param>
		     			<xsl:with-param name="amt-readonly">N</xsl:with-param>
		     			<xsl:with-param name="currency-readonly">N</xsl:with-param>
		     			<xsl:with-param name="override-amt-value">
		     				<xsl:choose>
		     					<xsl:when test="finance_amt !=''">
		     						<xsl:value-of select="finance_amt"/>
		     					</xsl:when>
		     					<xsl:otherwise>
		     						<xsl:value-of select="inv_eligible_amt"/>
		     					</xsl:otherwise>
		     				</xsl:choose>
		     			</xsl:with-param>
		   		</xsl:call-template>
	   		</xsl:when>
	   		<xsl:otherwise>
		   		<xsl:if test="not(sub_tnx_type_code[.='86' or .='79' or .='A3'])">
			   		<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_AMOUNTDETAILS_TNX_AMT_LABEL</xsl:with-param>
			     			<xsl:with-param name="product-code">tnx</xsl:with-param>
			     			<xsl:with-param name="show-amt">Y</xsl:with-param>
			     			<xsl:with-param name="override-currency-value"><xsl:value-of select="total_net_cur_code"/></xsl:with-param>
			     			<xsl:with-param name="swift-validate">N</xsl:with-param>
			     			<xsl:with-param name="currency-readonly">Y</xsl:with-param>
			     			<xsl:with-param name="show-button">N</xsl:with-param>
			     			<xsl:with-param name="currency-readonly">Y</xsl:with-param>
			   		</xsl:call-template>
			   	</xsl:if>
		   		<!-- Payment/Disbursement fields for Early Payment Programme -->
	        	<xsl:if test="fscm_programme_code[.='01'] and early_payment_ack[.='Y']">
			   		<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_ELIGIBLE_AMOUNT</xsl:with-param>
		     			<xsl:with-param name="product-code">inv_eligible</xsl:with-param>
		     			<xsl:with-param name="show-amt">Y</xsl:with-param>
		     			<xsl:with-param name="override-currency-value">
		     				<xsl:value-of select="total_net_cur_code"/>
		     			</xsl:with-param>
		     			<xsl:with-param name="swift-validate">N</xsl:with-param>
		     			<xsl:with-param name="show-button">N</xsl:with-param>
		     			<xsl:with-param name="amt-readonly">
		     				<xsl:choose>
		     					<xsl:when test="prod_stat_code[.='14']">N</xsl:when>
		     					<xsl:otherwise>Y</xsl:otherwise>
		     				</xsl:choose>
		     			</xsl:with-param>
		     			<xsl:with-param name="currency-readonly">Y</xsl:with-param>
		     			<xsl:with-param name="override-amt-value">
		     				<xsl:choose>
		     					<xsl:when test="inv_eligible_amt[.=''] and prod_stat_code[.!='15']">
		     						<xsl:value-of select="total_net_amt"/>
		     					</xsl:when>
		     					<xsl:otherwise>
		     						<xsl:value-of select="inv_eligible_amt"/>
		     					</xsl:otherwise>
		     				</xsl:choose>
		     			</xsl:with-param>
			   		</xsl:call-template>
			   		<xsl:call-template name="currency-field">
							<xsl:with-param name="label">XSL_GENERALDETAILS_IN_PAYMENT_AMOUNT</xsl:with-param>
			     			<xsl:with-param name="product-code">finance</xsl:with-param>
			     			<xsl:with-param name="show-amt">Y</xsl:with-param>
			     			<xsl:with-param name="override-currency-value"><xsl:value-of select="finance_cur_code"/></xsl:with-param>
			     			<xsl:with-param name="swift-validate">N</xsl:with-param>
			     			<xsl:with-param name="show-button">Y</xsl:with-param>
			     			<xsl:with-param name="amt-readonly">N</xsl:with-param>
			     			<xsl:with-param name="currency-readonly">N</xsl:with-param>
			     			<xsl:with-param name="override-amt-value">
			     				<xsl:value-of select="finance_amt"/>
			     			</xsl:with-param>
			   		</xsl:call-template>
	   		 	</xsl:if>
	   		</xsl:otherwise>
   		</xsl:choose>
   		<xsl:call-template name="currency-field">
			<xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
     			<xsl:with-param name="product-code">liab_total</xsl:with-param>
     			<xsl:with-param name="show-amt">Y</xsl:with-param>
     			<xsl:with-param name="override-currency-value"><xsl:value-of select="total_net_cur_code"/></xsl:with-param>
     			<xsl:with-param name="swift-validate">N</xsl:with-param>
     			<xsl:with-param name="currency-readonly">Y</xsl:with-param>
     			<xsl:with-param name="show-button">N</xsl:with-param>
     			<xsl:with-param name="amt-readonly">Y</xsl:with-param>
     			<xsl:with-param name="currency-readonly">Y</xsl:with-param>
   		</xsl:call-template>
       </xsl:if>
       
        <xsl:if test="product_code[. = 'CN']">
        	 	<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_CN_AMOUNT</xsl:with-param>
		     			<xsl:with-param name="product-code">cn</xsl:with-param>
		     			<xsl:with-param name="show-amt">Y</xsl:with-param>
		     			<!-- <xsl:with-param name="override-currency-value"><xsl:value-of select="cn_cur_code"/></xsl:with-param> -->
		     			<xsl:with-param name="swift-validate">N</xsl:with-param>
		     			<xsl:with-param name="currency-readonly">N</xsl:with-param>
		     			<xsl:with-param name="show-button">Y</xsl:with-param>
		     			<xsl:with-param name="currency-readonly">N</xsl:with-param>
		     			<xsl:with-param name="amt-readonly">N</xsl:with-param>
		     			<!-- <xsl:with-param name="override-amt-value">
		     				<xsl:value-of select="finance_amt"/>
		     			</xsl:with-param> -->
		   		</xsl:call-template>
        </xsl:if>
        <xsl:if test="(product_code[.='IN'] and fscm_programme_code[.!='01' and .!='06' and .!='05'] and  finance_offer_flag[.='Y']) or (product_code ='IP' and (fscm_programme_code ='05' or fscm_programme_code ='06') and  finance_offer_flag ='Y')">  
          <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_IN_FINANCE_OFFER_FLAG_LABEL</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language,'N034_Y')"/></xsl:with-param>
	     			<xsl:with-param name="override-displaymode">view</xsl:with-param>
		   	</xsl:call-template>
        </xsl:if>  
        
       <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT</xsl:with-param> 
           <xsl:with-param name="content"><div class="content">
             <xsl:call-template name="textarea-field">
			         <xsl:with-param name="name">bo_comment</xsl:with-param>
			         <xsl:with-param name="rows">13</xsl:with-param>
			         <xsl:with-param name="cols">75</xsl:with-param>
			         <xsl:with-param name="maxlines">500</xsl:with-param>
			         <xsl:with-param name="swift-validate">N</xsl:with-param>
		        </xsl:call-template>
           </div></xsl:with-param>
          </xsl:call-template>
         
    <!--   <xsl:if test="product_code[.='IN'] and fscm_programme_code[.!='01'] and  finance_offer_flag[.='Y']">    
      <xsl:variable name="action-req-value">        
          <xsl:if test="finance_offer_flag[.='Y'] and prod_stat_code[.='04' or .='07'] and sub_tnx_type_code[.='91']">07 </xsl:if>        
        </xsl:variable>  
        <xsl:call-template name="select-field">
      	 	<xsl:with-param name="label">XSL_REPORTINGDETAILS_ACTION_REQUIRED</xsl:with-param>
       		<xsl:with-param name="name">action_req_code</xsl:with-param>
       		<xsl:with-param name="value">	         
	           <xsl:if test="finance_offer_flag[.='Y'] and prod_stat_code[.='04' or .='07'] and  sub_tnx_type_code[.='91']">
	            	<xsl:value-of select="$action-req-value"/>
	           </xsl:if>
         	</xsl:with-param>
	       	<xsl:with-param name="options">
		        <xsl:choose>
		         <xsl:when test="$displaymode='edit'">
		          <option value="07" selected="true">
			          <xsl:attribute name="value">
			          		<xsl:value-of select="$action-req-value"/>
			          </xsl:attribute>
			           <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CONSENT_RESPONSE')"/>
		          </option>
		         </xsl:when>
		        <xsl:otherwise>
		         <xsl:choose>
		          <xsl:when test="action_req_code[.='07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CONSENT_RESPONSE')"/></xsl:when>        
		         </xsl:choose>
		        </xsl:otherwise>
		        </xsl:choose>
	       </xsl:with-param>
       <xsl:with-param name="readonly">
			<xsl:choose>
				<xsl:when test="finance_offer_flag[.='N']">N</xsl:when>
				<xsl:otherwise>Y</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
      </xsl:call-template>  
      </xsl:if> -->
         
         
     <xsl:if test="(product_code[.='IN'] and fscm_programme_code[.!='01'] and  finance_offer_flag[.='Y'])"> 
      <xsl:call-template name="select-field">
       <xsl:with-param name="label">XSL_REPORTINGDETAILS_ACTION_REQUIRED</xsl:with-param>
       <xsl:with-param name="name">action_req_code</xsl:with-param>
       <xsl:with-param name="options">
        <xsl:choose>
         <xsl:when test="$displaymode='edit'">        
          <option value="07">
           <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CONSENT_RESPONSE')"/>
          </option>        
          </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="action_req_code[.='07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CONSENT_RESPONSE')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
      </xsl:if> 
	   
     </xsl:with-param>
    </xsl:call-template> 
  
    <!-- Attach charges -->
    <xsl:if test="$displaymode='edit' or ($displaymode='view' and (charges/charge[created_in_session = 'Y']) != 0)">
   	 <xsl:call-template name="attachments-charges"/>
    </xsl:if>

   </xsl:with-param>
  </xsl:call-template>
  
  <!-- Realform -->
  <xsl:call-template name="bank-reporting-realform">
  	<xsl:with-param name="option"><xsl:value-of select="$option"/></xsl:with-param>
  </xsl:call-template>
  </xsl:if>
 </xsl:template>

  <!-- 
   Bank Reporting realform 
  -->
  <xsl:template name="bank-reporting-realform">
  	<xsl:param name="option"/>
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="method">POST</xsl:with-param>
    <xsl:with-param name="action" select="$realaction"/>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">mode</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="$mode"></xsl:value-of></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:choose>
		 <xsl:when test="$option !=''"><xsl:value-of select="$option"/></xsl:when>
         <xsl:when test="tnx_type_code[.='01'] and product_code[.='EL' or .='SR' or .='IC' or .='IR' or .='BR']">SCRATCH</xsl:when>
         <xsl:when test="tnx_type_code[.!='15']">PENDING</xsl:when>
         <xsl:otherwise>EXISTING</xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">productcode</xsl:with-param>
       <xsl:with-param name="value" select="$product-code"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tnxtype</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="tnx_type_code"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">referenceid</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="ref_id"/></xsl:with-param>
      </xsl:call-template>
      <xsl:if test="not(tnx_type_code[.='01'] and product_code[.='EL' or .='SR' or .='IC' or .='IR' or .='BR'])">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">tnxid</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="tnx_id"/></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
     </div>
    </xsl:with-param> 
   </xsl:call-template>
  </xsl:template>
  
  <!--
   Transactiond details link, and whether to show the details by default 
   -->
  <xsl:template name="transaction-details-link">
   <xsl:param name="show-transaction">
    <xsl:choose>
     <xsl:when test="$displaymode='view'">Y</xsl:when>
     <xsl:otherwise>N</xsl:otherwise>
    </xsl:choose>
   </xsl:param>

 	<xsl:if test="$show-transaction='N'">
 		<xsl:choose>
 			<xsl:when test="tnx_type_code[. = '01']">
			     <a id="editTransactionDetails" href="javascript:void(0)" style="display:none"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_EDIT_TRANSACTION')"/></a>
			     <a id="hideTransactionDetails" href="javascript:void(0)"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_HIDE_TRANSACTION')"/></a>
			     <div class="clear"></div><br/>
			</xsl:when>
 			<xsl:otherwise>
 				 <a id="editTransactionDetails" href="javascript:void(0)" ><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_EDIT_TRANSACTION')"/></a>
			     <a id="hideTransactionDetails" href="javascript:void(0)" style="display:none"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_HIDE_TRANSACTION')"/></a>
			     <div class="clear"></div><br/>
			     <script>
			     		dojo.ready(function(){
			     			misys.toggleTransaction(false);			
			     		});
			     </script>
 			</xsl:otherwise>
 		</xsl:choose> 
   </xsl:if>
  
  </xsl:template>
  
  <!--
   Bank product status codes. 
   -->
  <xsl:template name="bank-prod-stat-codes">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value=""/>
     <option value="07">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_07_UPDATED')"/>
     </option>
     <option value="04">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_04_ACCEPTED')"/>
     </option>
     <option value="13">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_13_PART_SETTLED')"/>
     </option>
     <option value="05">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_05_SETTLED')"/>
     </option>
     <option value="14">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_14_PART_SIGHT_PAYMT')"/>
     </option>
     <option value="15">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_15_FULL_SIGHT_PAYMT')"/>
     </option>
     <option value="01">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="prod_stat_code[.='07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_07_UPDATED')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_04_ACCEPTED')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='13']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_13_PART_SETTLED')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_05_SETTLED')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='14']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_14_PART_SIGHT_PAYMT')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='15']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_15_FULL_SIGHT_PAYMT')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <!--
   PO Product Status Codes   
  -->
  <xsl:template name="po-prod-stat-codes">
    <xsl:variable name="eligibilityEnabled">
       	<xsl:choose>
       		<xsl:when test="product_code[.='IN'] and finance_requested_flag[.!='Y'] and fscm_programme_code[.!='' and .!='01' and .!='05' and .!='06']">
	        	<xsl:choose>
	        		<xsl:when test="(fscm_programme_code[.='03']) and finance_requested_flag[.='']">N</xsl:when>
	        		<xsl:otherwise>Y</xsl:otherwise>
	        	</xsl:choose>
       		</xsl:when>
       		<xsl:when test="product_code[.='IP'] and fscm_programme_code !='' and (fscm_programme_code = '05' or fscm_programme_code = '06') and (eligibility_flag = 'P' or (eligibility_flag = 'E' and tnx_stat_code = '05'))">Y</xsl:when>
       		<xsl:otherwise>N</xsl:otherwise>
       	</xsl:choose>
     </xsl:variable>
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="07">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_07_UPDATED')"/>
     </option>
     <xsl:if test="prod_stat_code[.='PO']">
      <option value="32">
       <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_32_ESTABLISHED')"/>
      </option>
     </xsl:if>
     <option value="08">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_08_AMENDED')"/>
     </option>
     <option value="09">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_09_EXTENDED')"/>
     </option>
     <option value="04">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_04_ACCEPTED')"/>
     </option>
     <option value="05">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_05_SETTLED')"/>
     </option>
     <option value="13">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_13_PART_SETTLED')"/>
     </option>
     <option value="06">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_06_CANCELLED')"/>
     </option>
     <option value="11">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_11_RELEASED')"/>
     </option>
     <option value="12">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_12_ADVISE_OF_BILL_ARRV_DISCREPANT')"/>
     </option>
     <option value="14">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_14_PART_SIGHT_PAYMT')"/>
     </option>
     <option value="15">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_15_FULL_SIGHT_PAYMT')"/>
     </option>
      <option value="26">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_26_ADVISE_OF_BILL_ARRV_CLEAN')"/>
     </option>
     <option value="81">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_81_CANCEL_AWAITING_BENEFICIARY_RESPONSE')"/>
     </option>
     <option value="82">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_82_CANCEL_REFUSED')"/>
     </option>
     <option value="10">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_10_PURGED')"/>
     </option>
     <option value="01">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/>
     </option>
     <option value="84">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_84_CLAIM_PRESENTATION')"/>
     </option>
     <option value="85">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_85_CLAIM_SETTLEMENT')"/>
     </option>
     <option value="86">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_86_EXTEND_PAY')"/>
     </option>
     <xsl:if test="$eligibilityEnabled = 'Y'">
	     <option value="46">
	      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_46_ELIGIBLE')"/>
	     </option> 
	     <option value="47">
	      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_47_NOT_ELIGIBLE')"/>
	     </option>   
	  </xsl:if>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="prod_stat_code[.='07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_07_UPDATED')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_03_NEW')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='32']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_32_ESTABLISHED')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_08_AMENDED')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='09']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_09_EXTENDED')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_04_ACCEPTED')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_05_SETTLED')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='13']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_13_PART_SETTLED')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='06']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_06_CANCELLED')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='11']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_11_RELEASED')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='12']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_12_ADVISE_OF_BILL_ARRV_DISCREPANT')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='14']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_14_PART_SIGHT_PAYMT')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='15']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_15_FULL_SIGHT_PAYMT')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='81']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_81_CANCEL_AWAITING_BENEFICIARY_RESPONSE')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='82']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_82_CANCEL_REFUSED')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='10']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_10_PURGED')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='84']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_84_CLAIM_PRESENTATION')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='85']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_85_CLAIM_SETTLEMENT')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='86']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_86_EXTEND_PAY')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='26']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_26_ADVISE_OF_BILL_ARRV_CLEAN')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='46']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_46_ELIGIBLE')"/></xsl:when>
      <xsl:when test="prod_stat_code[.='47']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_47_NOT_ELIGIBLE')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <xsl:template name="common-general-details">
  	<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
 
		   <xsl:variable name="show-cust-ref-id">Y</xsl:variable>
		   <xsl:variable name="show-bo-ref-id">Y</xsl:variable>
		   <xsl:variable name="override-cust-ref-id-label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:variable>
		   <!-- Don't display this in unsigned mode. -->
		   <xsl:if test="$displaymode='edit'">
		   <!--  <xsl:call-template name="hidden-field">
		     <xsl:with-param name="name">appl_date</xsl:with-param>
		    </xsl:call-template> -->
		   </xsl:if>
		
		    
		    <!--  Application date. -->
		    <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
		     <xsl:with-param name="id">appl_date_view</xsl:with-param>
		     <xsl:with-param name="value" select="appl_date" />
		     <xsl:with-param name="type">date</xsl:with-param>
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
		    </xsl:call-template>
		
				<xsl:call-template name="common-po-general-details" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!--
		General Details Fieldset. Issue Date, Template Validation, Buyer
		Details, Seller Details.
	-->
	<xsl:template name="common-po-general-details">
		<xsl:param name="section_po_seller_reference">N</xsl:param>
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_INVOICE_DATE</xsl:with-param>
			<xsl:with-param name="name">iss_date</xsl:with-param>
			<xsl:with-param name="type">date</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
			<xsl:with-param name="fieldsize">small</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_DUE_DATE</xsl:with-param>
			<xsl:with-param name="name">due_date</xsl:with-param>
			<xsl:with-param name="type">date</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
			<xsl:with-param name="fieldsize">small</xsl:with-param>
		</xsl:call-template>
			
		<!-- Seller Details -->
		<!-- Display Entity for DF under seller, since seller is the portal customer -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="show-entity">
				        <xsl:choose>
				         <xsl:when test="fscm_programme_code = '02' and entity[.!='']">Y</xsl:when>
				         <xsl:otherwise>N</xsl:otherwise>
				        </xsl:choose>
			       </xsl:with-param>
					<xsl:with-param name="show-BEI">Y</xsl:with-param>
					<xsl:with-param name="prefix">seller</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
					<xsl:with-param name="readonly">Y</xsl:with-param>
					<xsl:with-param name="show-entity-button">N</xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
				</xsl:call-template>

				<!--
					If we have to, we show the reference field for applicants. This is
					specific to this form.
				-->
				<xsl:if test="$section_po_seller_reference='Y'">
					<xsl:if
					test="not(avail_main_banks/bank/entity/customer_reference) and not(avail_main_banks/bank/customer_reference)">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
						<xsl:with-param name="name">seller_reference</xsl:with-param>
						<xsl:with-param name="maxsize">34</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>

		<!-- Buyer Details -->
				<!-- Display Entity for other progarms, under buyer, since buyer is the portal customer -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="show-entity">
				        <xsl:choose>
				         <xsl:when test="fscm_programme_code = '02' or entity[.='']">N</xsl:when>
				         <xsl:otherwise>Y</xsl:otherwise>
				        </xsl:choose>
			       </xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
					<xsl:with-param name="show-BEI">Y</xsl:with-param>
					<xsl:with-param name="prefix">buyer</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
					<xsl:with-param name="readonly">Y</xsl:with-param>
					<xsl:with-param name="show-entity-button">N</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>

		<!-- Display other parties -->
		<xsl:if test="$displaymode='edit'">
		<xsl:call-template name="multichoice-field">
	    	<xsl:with-param name="label">XSL_INVOICE_PAYABLE_DISPLAY_OTHER_PARTIES</xsl:with-param>
	    	<xsl:with-param name="type">checkbox</xsl:with-param>
	    	<xsl:with-param name="name">display_other_parties</xsl:with-param>
	    	<xsl:with-param name="checked"><xsl:if test="bill_to_name[. != ''] or ship_to_name[. != ''] or consgn_to_name[. != '']">Y</xsl:if></xsl:with-param>
		</xsl:call-template>
		</xsl:if>

		<!--
			Other parties Tabgroup. Tab0 - Bill To Tab1 - Ship To Tab2 -
			Consignee
		-->
		<xsl:call-template name="tabgroup-wrapper">
			<xsl:with-param name="tabgroup-id">other_parties_section</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<!--  Tab 0_0 - Bill To  -->
			<xsl:with-param name="tab0-label">XSL_HEADER_BILL_TO_DETAILS</xsl:with-param>
			<xsl:with-param name="tab0-content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="prefix">bill_to</xsl:with-param>
					<xsl:with-param name="show-button">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
			<!--  Tab 0_1 - Ship To -->
			<xsl:with-param name="tab1-label">XSL_HEADER_SHIP_TO_DETAILS</xsl:with-param>
			<xsl:with-param name="tab1-content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="prefix">ship_to</xsl:with-param>
					<xsl:with-param name="show-button">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
			<!--  Tab 0_2 - Consignee -->
			<xsl:with-param name="tab2-label">XSL_HEADER_CONSIGNEE_DETAILS</xsl:with-param>
			<xsl:with-param name="tab2-content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="prefix">consgn</xsl:with-param>
					<xsl:with-param name="show-button">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<!--
		Goods Details Fieldset. 
		-->
	<xsl:template name="common-goods-details">
		<xsl:param name="product-currency-label">XSL_INVOICE_PAYABLE_CURRENCY_CODE</xsl:param>
		<xsl:param name="section_po_line_items">Y</xsl:param>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_DESCRIPTION_GOODS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_PURCHASE_ORDER_GOODS_DESC</xsl:with-param>
					<xsl:with-param name="name">goods_desc</xsl:with-param>
					<xsl:with-param name="size">70</xsl:with-param>
	     			<xsl:with-param name="maxsize">70</xsl:with-param>
	     			 <xsl:with-param name="fieldsize">x-large</xsl:with-param>
				</xsl:call-template>
				<xsl:choose>
					<xsl:when test="$option = 'FULL' or $option = 'DETAILS' or $mode = 'UNSIGNED'">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label"><xsl:value-of select="$product-currency-label"/></xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="total_cur_code"/></xsl:with-param>
							<xsl:with-param name="name">total_cur_code</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
					<xsl:call-template name="currency-field">
						<xsl:with-param name="label"><xsl:value-of select="$product-currency-label"/></xsl:with-param>
						<xsl:with-param name="product-code">total</xsl:with-param>
						<xsl:with-param name="override-currency-name">total_cur_code</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="show-amt">N</xsl:with-param>
					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			<!-- <xsl:if test="$section_po_line_items!='N'"> -->
				<!-- Buyer Details -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_LINE_ITEMS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
					&nbsp;
						<!-- Line items grid -->
						<xsl:call-template name="build-line-items-dojo-items">
							<xsl:with-param name="items" select="line_items/lt_tnx_record" />
							
						</xsl:call-template>
						<!-- Total Goods Amount -->
						<xsl:choose>
							<xsl:when test="$option = 'FULL' or $option = 'DETAILS' or $mode = 'UNSIGNED'">
								<br/>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="total_cur_code"/>&nbsp;<xsl:value-of select="total_amt"/></xsl:with-param>
									<xsl:with-param name="name">fake_total_amt</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL</xsl:with-param>
									<xsl:with-param name="product-code">total</xsl:with-param>
									<xsl:with-param name="override-currency-name">fake_total_cur_code</xsl:with-param>
									<xsl:with-param name="override-amt-name">fake_total_amt</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="amt-readonly">Y</xsl:with-param>
									<xsl:with-param name="show-button">N</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						<!-- This div is required to force the content to appear -->
						<div style="height:1px">&nbsp;</div>						
					</xsl:with-param>
				</xsl:call-template>
		<!-- </xsl:if> -->
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
		<!-- Amount Details Fieldset. -->
	<xsl:template name="common-amount-details">
		<xsl:param name="section_po_adjustements_details">N</xsl:param>
		<xsl:param name="section_amount_details">N</xsl:param>
		<xsl:param name="section_po_taxes_details">N</xsl:param>
		<xsl:param name="section_po_freight_charges_details">N</xsl:param>
		<div>
		<xsl:if test="$section_amount_details = 'N'">
			<xsl:attribute name="class">hide</xsl:attribute>
		</xsl:if>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<!-- Adjustments -->
				<xsl:if test="$section_po_adjustements_details!='N'">
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_HEADER_ADJUSTMENTS_DETAILS</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
							&nbsp;
							<xsl:call-template name="build-adjustments-dojo-items">
								<xsl:with-param name="items" select="adjustments/adjustment" />
								<xsl:with-param name="id">po-adjustments</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

				<!-- Taxes -->
				<xsl:if test="$section_po_taxes_details!='N'">
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_HEADER_TAXES_DETAILS</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
							&nbsp;
							<xsl:call-template name="build-taxes-dojo-items">
								<xsl:with-param name="items" select="taxes/tax" />
								<xsl:with-param name="id">po-taxes</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

				<!-- Freight charges -->
				<xsl:if test="$section_po_freight_charges_details!='N'">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_FREIGHT_CHARGES_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<!-- Price unit measure code -->
						<xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_FREIGHT_CHARGES_TYPE</xsl:with-param>
							<xsl:with-param name="name">freight_charges_type</xsl:with-param>
							<xsl:with-param name="options">
							 <xsl:choose>
        						<xsl:when test="$displaymode='edit'">
        						<option value="">&nbsp;</option>
								<option value="CLCT">
									<xsl:value-of
										select="localization:getDecode($language, 'N211', 'CLCT')" />
									<xsl:if test="freight_charges_type[. = 'CLCT']">
										<xsl:attribute name="selected" />
									</xsl:if>
								</option>
								<option value="PRPD">
									<xsl:value-of
										select="localization:getDecode($language, 'N211', 'PRPD')" />
									<xsl:if test="freight_charges_type[. = 'PRPD']">
										<xsl:attribute name="selected" />
									</xsl:if>
								</option>
								 </xsl:when>
						        <xsl:otherwise>
						         <xsl:choose>
						          <xsl:when test="freight_charges_type[. = 'CLCT']"><xsl:value-of select="localization:getDecode($language, 'N211', 'CLCT')" /></xsl:when>
						          <xsl:when test="freight_charges_type[. = 'PRPD']"><xsl:value-of select="localization:getDecode($language, 'N211', 'PRPD')" /></xsl:when>
						         </xsl:choose>
						        </xsl:otherwise>
						       </xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
							&nbsp;
						<xsl:call-template name="build-freight-charges-dojo-items">
							<xsl:with-param name="items"
								select="freightCharges/freightCharge" />
							<xsl:with-param name="id">po-freight-charges</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				
				<!-- Line Item Net Amount -->
				<div>
					<xsl:choose>
						<xsl:when test="$option = 'FULL' or $option = 'DETAILS' or $mode = 'UNSIGNED'">
							<br/>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_NET_AMT_LABEL</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="total_cur_code"/>&nbsp;<xsl:value-of select="total_amt"/></xsl:with-param>
								<xsl:with-param name="name">total_net_inv_amt</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="currency-field">
								<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_NET_AMT_LABEL</xsl:with-param>
								<xsl:with-param name="override-currency-name">total_net_inv_cur_code</xsl:with-param>
								<xsl:with-param name="override-amt-name">total_net_inv_amt</xsl:with-param>
								<xsl:with-param name="amt-readonly">Y</xsl:with-param>
								<xsl:with-param name="currency-readonly">Y</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
								<xsl:with-param name="show-button">N</xsl:with-param>
							</xsl:call-template>	
						</xsl:otherwise>
					</xsl:choose>
				</div>
			</xsl:with-param>
		</xsl:call-template>
		</div>
	</xsl:template>
	
		<!--  Payment Details Fieldset. -->
	<xsl:template name="common-payment-terms">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PAYMENT_TERMS_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="multioption-group">
			        <xsl:with-param name="group-label">XSL_DETAILS_PO_PAYMENT_TYPE</xsl:with-param>
			        <xsl:with-param name="content">
						<!-- events : onclick -->
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_HEADER_PO_PAYMENT_AMOUNT</xsl:with-param>
							<xsl:with-param name="name">payment_terms_type</xsl:with-param>
							<xsl:with-param name="id">payment_terms_type_1</xsl:with-param>
							<xsl:with-param name="value">AMNT</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_HEADER_PO_PAYMENT_PCT</xsl:with-param>
							<xsl:with-param name="name">payment_terms_type</xsl:with-param>
							<xsl:with-param name="id">payment_terms_type_2</xsl:with-param>
							<xsl:with-param name="value">PRCT</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				&nbsp;
				<xsl:call-template name="payments-new">
					<xsl:with-param name="items" select="payments/payment" />
					<xsl:with-param name="id">po-payments</xsl:with-param>
				</xsl:call-template>
						
			</xsl:with-param>
		</xsl:call-template>							
	</xsl:template>
	
		
	<!--  Settlment Details Fieldset. -->
	<xsl:template name="common-settlement-terms">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_SETTLEMENT_TERMS_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_PURCHASE_ORDER_SELLER_ACCOUNT</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE</xsl:with-param>
							<xsl:with-param name="name">seller_account_type</xsl:with-param>
							<xsl:with-param name="value">
							 <xsl:choose>
						          <xsl:when test="seller_account_iban[.!='']">IBAN</xsl:when>
						          <xsl:when test="seller_account_bban[.!='']">BBAN</xsl:when>
						          <xsl:when test="seller_account_upic[.!='']">UPIC</xsl:when>
						          <xsl:when test="seller_account_id[.!='']">OTHER</xsl:when>
						          <xsl:otherwise></xsl:otherwise>
						     </xsl:choose>
						     </xsl:with-param>
							<!-- events : onChange -->
							<xsl:with-param name="options">
							<xsl:choose>
        						<xsl:when test="$displaymode='edit'">
								<option value=""></option>
								<option value="IBAN">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN')" />
								</option>
								<option value="BBAN">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_BBAN')" />
								</option>
								<option value="UPIC">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_UPIC')" />
								</option>
								<option value="OTHER">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_OTHER')" />
								</option>
								 </xsl:when>
						        <xsl:otherwise>
						         <xsl:choose>
						          <xsl:when test="seller_account_type[. = '']"></xsl:when>
						          <xsl:when test="seller_account_iban[.!='']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN')" /></xsl:when>
						          <xsl:when test="seller_account_bban[.!='']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_BBAN')" /></xsl:when>
						          <xsl:when test="seller_account_upic[.!='']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_UPIC')" /></xsl:when>
						          <xsl:when test="seller_account_id[.!='']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_OTHER')" /></xsl:when>
						         </xsl:choose>
						        </xsl:otherwise>
						       </xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_NAME</xsl:with-param>
							<xsl:with-param name="name">seller_account_name</xsl:with-param>
							<!-- events : onblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="seller_account_name" />
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PURCHASE_ORDER_SELLER_ACCOUNT_NUMBER</xsl:with-param>
							<xsl:with-param name="name">seller_account_value</xsl:with-param>
							<!-- events : onfocus, onblur -->
							<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="seller_account_iban[.!='']"><xsl:value-of select="seller_account_iban" /></xsl:when>
									<xsl:when test="seller_account_bban[.!='']"><xsl:value-of select="seller_account_bban" /></xsl:when>
									<xsl:when test="seller_account_upic[.!='']"><xsl:value-of select="seller_account_upic" /></xsl:when>
									<xsl:when test="seller_account_id[.!='']"><xsl:value-of select="seller_account_id" /></xsl:when>
									<xsl:otherwise />
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>
						
					</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_PURCHASE_ORDER_FINANCIAL_INSTITUTION</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="button-type">fin_inst</xsl:with-param>
					<xsl:with-param name="content">
					
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_NAME</xsl:with-param>
							<xsl:with-param name="name">fin_inst_name</xsl:with-param>
							<!-- events : onblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_name" />
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>

						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PARTIESDETAILS_BIC_CODE</xsl:with-param>
							<xsl:with-param name="name">fin_inst_bic</xsl:with-param>
							<!-- events : onblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_bic" />
							</xsl:with-param>
							<xsl:with-param name="size">11</xsl:with-param>
							<xsl:with-param name="maxsize">11</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
							<xsl:with-param name="name">fin_inst_street_name</xsl:with-param>
							<!-- events : onblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_street_name" />
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">70</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
							<xsl:with-param name="name">fin_inst_post_code</xsl:with-param>
							<!-- event : sonblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_post_code" />
							</xsl:with-param>
							<xsl:with-param name="size">16</xsl:with-param>
							<xsl:with-param name="maxsize">16</xsl:with-param>
							<xsl:with-param name="fieldsize">x-small</xsl:with-param>
						</xsl:call-template>

						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
							<xsl:with-param name="name">fin_inst_town_name</xsl:with-param>
							<!-- event : sonblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_town_name" />
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>

						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
							<xsl:with-param name="name">fin_inst_country_sub_div</xsl:with-param>
							<!-- event : sonblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_country_sub_div" />
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">34</xsl:with-param>
						</xsl:call-template>

						 <xsl:call-template name="country-field">
							    <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY</xsl:with-param>
							    <xsl:with-param name="name">fin_inst_country</xsl:with-param>
							    <xsl:with-param name="value"><xsl:value-of select="fin_inst_country" /></xsl:with-param>
							    <xsl:with-param name="prefix" >fin_inst</xsl:with-param>
						   </xsl:call-template>

					</xsl:with-param>
				</xsl:call-template>

			</xsl:with-param>
		</xsl:call-template>							
	</xsl:template>
	
	<!--  Bank Details Fieldset. -->
	<xsl:template name="common-bank-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="issuing-bank-tabcontent">
					<xsl:with-param name="sender-name">seller</xsl:with-param>
					<xsl:with-param name="sender-reference-name">seller_reference</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<!--  Documents required Fieldset. -->
	<xsl:template name="common-documents-required">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED</xsl:with-param>
			<xsl:with-param name="content">
			
				<xsl:call-template name="localization-dialog"/>
		       <xsl:call-template name="multioption-group">
		        <xsl:with-param name="group-label">XSL_PURCHASE_ORDER_COMMERCIAL_DATASET</xsl:with-param>
		        <xsl:with-param name="content">
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_COMMERCIAL_DATASET_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">reqrd_commercial_dataset</xsl:with-param>
						<xsl:with-param name="id">reqrd_commercial_dataset_1</xsl:with-param>
						<xsl:with-param name="value">Y</xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="reqrd_commercial_dataset[. = 'Y' or . = '']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_COMMERCIAL_DATASET_NOT_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">reqrd_commercial_dataset</xsl:with-param>
						<xsl:with-param name="id">reqrd_commercial_dataset_2</xsl:with-param>
						<xsl:with-param name="value">N</xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="reqrd_commercial_dataset[. = 'N']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
	     	  </xsl:call-template>
	       	  <xsl:call-template name="multioption-group">
	       	  	 <xsl:with-param name="group-label">XSL_PURCHASE_ORDER_TRANSPORT_DATASET</xsl:with-param>
	       		 <xsl:with-param name="content">
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_TRANSPORT_DATASET_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">reqrd_transport_dataset</xsl:with-param>
						<xsl:with-param name="id">reqrd_transport_dataset_1</xsl:with-param>
						<xsl:with-param name="value">Y</xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="reqrd_transport_dataset[. = 'Y']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_TRANSPORT_DATASET_NOT_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">reqrd_transport_dataset</xsl:with-param>
						<xsl:with-param name="id">reqrd_transport_dataset_2</xsl:with-param>
						<xsl:with-param name="value">N</xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="reqrd_transport_dataset[. = 'N' or . = '']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
	     	  </xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_PURCHASE_ORDER_LAST_MATCH_DATE</xsl:with-param>
					<xsl:with-param name="name">last_match_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<!-- events : onblur -->
					<xsl:with-param name="value">
						<xsl:value-of select="last_match_date" />
					</xsl:with-param>
					<xsl:with-param name="size">10</xsl:with-param>
					<xsl:with-param name="maxsize">10</xsl:with-param>
				</xsl:call-template>
				
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
		<!--  Shipment details Fieldset. -->
	<xsl:template name="common-shipment-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			
			   <!-- Lastest Shipment Date, Partial and Trans Shipments-->
			   <xsl:call-template name="multioption-group">
			        <xsl:with-param name="group-label">XSL_SHIPMENTDETAILS_PART_SHIP_LABEL</xsl:with-param>
			        <xsl:with-param name="content">
				        <xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED</xsl:with-param>
							<xsl:with-param name="name">part_ship</xsl:with-param>
							<xsl:with-param name="id">part_ship_1</xsl:with-param>
							<xsl:with-param name="value">Y</xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="part_ship[. = 'Y' or . = '']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED</xsl:with-param>
							<xsl:with-param name="name">part_ship</xsl:with-param>
							<xsl:with-param name="id">part_ship_2</xsl:with-param>
							<xsl:with-param name="value">N</xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="part_ship[. = 'N']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
			        </xsl:with-param>
			    </xsl:call-template>
			    <xsl:call-template name="multioption-group">
			        <xsl:with-param name="group-label">XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL</xsl:with-param>
			        <xsl:with-param name="content">
			        	<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED</xsl:with-param>
							<xsl:with-param name="name">tran_ship</xsl:with-param>
							<xsl:with-param name="id">tran_ship_1</xsl:with-param>
							<xsl:with-param name="value">Y</xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="tran_ship[. = 'Y' or . = '']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED</xsl:with-param>
							<xsl:with-param name="name">tran_ship</xsl:with-param>
							<xsl:with-param name="id">tran_ship_2</xsl:with-param>
							<xsl:with-param name="value">N</xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="tran_ship[. = 'N']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
			        </xsl:with-param>
			   </xsl:call-template>
				
			  <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SHIPMENTDETAILS_LAST_SHIP_DATE</xsl:with-param>
					<!-- events : onblur, onfocus -->
					<xsl:with-param name="name">last_ship_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:value-of select="last_ship_date" />
					</xsl:with-param>
					<xsl:with-param name="size">10</xsl:with-param>
					<xsl:with-param name="maxsize">10</xsl:with-param>
			  </xsl:call-template>

			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<!--  Inco terms Fieldset. -->
	<xsl:template name="common-inco-terms">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_INCO_TERMS_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			&nbsp; 
				<xsl:call-template name="build-incoterms-dojo-items">
					<xsl:with-param name="items" select="incoterms/incoterm"/>
					<xsl:with-param name="id">po-incoterms</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Routing summary Fieldset. -->
	<xsl:template name="common-routing-summary">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_ROUTING_SUMMARY_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			
			<xsl:call-template name="select-field">
				<!-- events : onfocus and onchange -->
				<xsl:with-param name="label">XSL_PO_ROUTING_SUMMARY_TRANSPORT_TYPE</xsl:with-param>
				<xsl:with-param name="name">transport_type</xsl:with-param>
				<xsl:with-param name="options">
				<xsl:choose>
				 <xsl:when test="$displaymode='edit'">
					<option value="0">&nbsp;
					</option>
					<option value="01">
						<xsl:if
							test="count(/ip_tnx_record/routing_summaries/routing_summary/transport_type[. = '01']) != 0">
							<xsl:attribute name="selected" />
						</xsl:if>
						<xsl:value-of
							select="localization:getDecode($language, 'N213', '01')" />
					</option>
					<option value="02">
						<xsl:if
							test="count(/ip_tnx_record/routing_summaries/routing_summary/transport_type[. = '02']) != 0">
							<xsl:attribute name="selected" />
						</xsl:if>
						<xsl:value-of
							select="localization:getDecode($language, 'N213', '02')" />
					</option>
					</xsl:when>
			        <xsl:otherwise>
			         <xsl:choose>
			          <xsl:when test="transport_type[. = '0' or . = '' ]"></xsl:when>
			          <xsl:when test="transport_type[. = '01']"><xsl:value-of select="localization:getDecode($language, 'N213', '01')" /></xsl:when>
			          <xsl:when test="transport_type[. = '02']"><xsl:value-of select="localization:getDecode($language, 'N213', '02')" /></xsl:when>
			         </xsl:choose>
			         </xsl:otherwise>
			      </xsl:choose>   
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">transport_type_old</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="/ip_tnx_record/routing_summaries/routing_summary/transport_type"/></xsl:with-param>
			</xsl:call-template>
				<xsl:call-template name="routing-summary-individuals-div">
				<xsl:with-param name="hidden">
					<xsl:choose>
						<xsl:when test="count(/ip_tnx_record/routing_summaries/routing_summary/transport_type[. = '01']) != 0">N</xsl:when>
						<xsl:otherwise>Y</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="routing-summary-multimodal-div">
				<xsl:with-param name="hidden">
					<xsl:choose>
						<xsl:when test="count(/ip_tnx_record/routing_summaries/routing_summary/transport_type[. = '02']) != 0">N</xsl:when>
						<xsl:otherwise>Y</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
			

	</xsl:template>
	

<!-- User Details Fieldset. -->
	<xsl:template name="common-user-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_USER_INFORMATION_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_PURCHASE_ORDER_BUYER_INFORMATIONS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">&nbsp;
						<xsl:call-template name="user_defined_informations_buyer">
							<xsl:with-param name="items" select="user_defined_informations/user_defined_information[type=01]" />
							<xsl:with-param name="id">po-buyer-user-informations</xsl:with-param>
						</xsl:call-template>
					
					</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_PURCHASE_ORDER_SELLER_INFORMATIONS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">&nbsp;
						<xsl:call-template name="user_defined_informations_seller">
							<xsl:with-param name="items" select="user_defined_informations/user_defined_information[type=02]" />
							<xsl:with-param name="id">po-seller-user-informations</xsl:with-param>
						</xsl:call-template>
					
					</xsl:with-param>
				</xsl:call-template>
				
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Contact Person Details Fieldset. -->
	<xsl:template name="common-contact-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_CONTACT_PERSON_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-contact-details-dojo-items">
					<xsl:with-param name="items" select="contacts/contact" />
					<xsl:with-param name="id">po-contacts</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	
</xsl:stylesheet>