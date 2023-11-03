<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to forms on the customer side. This
stylesheet should be the first thing imported by customer-side
XSLTs.

This should be the first include for forms on the customer side.

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
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization utils">
 
 <xsl:strip-space elements="*"/>
  
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

 <!--
  Common includes. 
  -->
  
 <xsl:include href="common.xsl" />
 <xsl:include href="../../../core/xsl/common/form_templates.xsl" />
 <xsl:include href="../../../core/xsl/common/attachment_templates.xsl" />
 <xsl:include href="../../../collaboration/xsl/collaboration.xsl"/> 
 <xsl:include href="../../../core/xsl/common/com_cross_references.xsl"/>

 <!--  
  Hidden fields that are used across forms on the customer side.
 -->
 <xsl:template name="common-hidden-fields">
  <xsl:param name="show-type">Y</xsl:param>
  <xsl:param name="show-tnx-amt">Y</xsl:param>
  <xsl:param name="override-product-code" select="$lowercase-product-code"></xsl:param>
  <xsl:param name="additional-fields"/>
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">brch_code</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_name</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">tnx_id</xsl:with-param>
   </xsl:call-template>
   <xsl:if test="$show-tnx-amt='Y'">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">tnx_amt</xsl:with-param>
    </xsl:call-template>
   </xsl:if>
   
   <!-- Previous ctl date, used for synchronisation issues -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">old_ctl_dttm</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="ctl_dttm" /></xsl:with-param>
   </xsl:call-template>
   
   <!-- Previous input date, used to know if the product has already been saved -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">old_inp_dttm</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="inp_dttm" /></xsl:with-param>
   </xsl:call-template>
   <xsl:if test="$show-type='Y' and $displaymode='edit'">
    <xsl:variable name="type_name"><xsl:value-of select="$override-product-code"/>_type</xsl:variable>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name"><xsl:value-of select="$type_name" /></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="//*[name()=$type_name]" /></xsl:with-param>
    </xsl:call-template>
   </xsl:if>
   
   <!-- Security token -->
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">token</xsl:with-param>
   </xsl:call-template>
   <xsl:copy-of select="$additional-fields"/>
  </div>
 </xsl:template>
 
  <!--
   General Details fields, common to forms on the customer side.
   
   System ID, Template ID, Customer Reference, Application Date.
   -->
  <xsl:template name="common-general-details">
   <xsl:param name="show-template-id">Y</xsl:param>
   <xsl:param name="show-cust-ref-id">Y</xsl:param>
   <!-- Hidden fields. -->
   <xsl:call-template name="hidden-field">
	<xsl:with-param name="name">ref_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">bulk_ref_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">bulk_tnx_id</xsl:with-param>
   </xsl:call-template>
   <!-- Don't display this in unsigned mode. -->
   <xsl:if test="$displaymode='edit'">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">appl_date</xsl:with-param>
    </xsl:call-template>
   </xsl:if>

   <!--  System ID. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
    <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
    <xsl:with-param name="value" select="ref_id" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   
   <!-- Bank Reference -->
   <!-- Shown in consolidated view -->
   <xsl:if test="$displaymode='view' and (not(tnx_id) or tnx_type_code[.!='01'])">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
     <xsl:with-param name="value" select="bo_ref_id" />
    </xsl:call-template>
   </xsl:if>
   
   <!-- Cross Refs -->
   <!-- Shown in consolidated view  -->
   <xsl:if test="cross_references">
    <xsl:apply-templates select="cross_references" mode="display_table_tnx"/>
   </xsl:if>
    
   <!-- Template ID. -->
   <xsl:if test="$show-template-id='Y'">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_ID</xsl:with-param>
     <xsl:with-param name="name">template_id</xsl:with-param>
     <xsl:with-param name="size">15</xsl:with-param>
     <xsl:with-param name="maxsize">20</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
    </xsl:call-template>
   </xsl:if>
    
    <!-- Customer reference -->
    <xsl:if test="$show-cust-ref-id='Y'">
	    <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
	     <xsl:with-param name="name">cust_ref_id</xsl:with-param>
	     <xsl:with-param name="size">16</xsl:with-param>
	     <xsl:with-param name="maxsize">64</xsl:with-param>
	     <xsl:with-param name="fieldsize">small</xsl:with-param>
	    </xsl:call-template>
    </xsl:if>
    
     <xsl:choose>
     <xsl:when test="product_code[.='BG']"> 
     	<xsl:call-template name="multichoice-field">
           <xsl:with-param name="group-label">XSL_GENERALDETAILS_SUBTYPE_DETAILS</xsl:with-param>
	       <xsl:with-param name="label">XSL_BANK_GUARANTEE</xsl:with-param>
	       <xsl:with-param name="name">bg_sub_type_details</xsl:with-param>
	       <xsl:with-param name="id">bg_sub_type_details_1</xsl:with-param>
	       <xsl:with-param name="value">01</xsl:with-param>
	       <xsl:with-param name="checked"><xsl:if test="bg_sub_type_details[. = '01'] or bg_sub_type_details[. = ''] or not(bg_sub_type_details)">Y</xsl:if></xsl:with-param>
	       <xsl:with-param name="type">radiobutton</xsl:with-param>
	     </xsl:call-template>
         
	     <xsl:call-template name="multichoice-field">
	      <xsl:with-param name="label">XSL_COUNTER_GUARANTEE</xsl:with-param>
	      <xsl:with-param name="name">bg_sub_type_details</xsl:with-param>
	      <xsl:with-param name="id">bg_sub_type_details_2</xsl:with-param>
	      <xsl:with-param name="value">02</xsl:with-param>
	      <xsl:with-param name="checked"><xsl:if test="bg_sub_type_details_2[. = '02']">Y</xsl:if></xsl:with-param>
	      <xsl:with-param name="type">radiobutton</xsl:with-param>
	     </xsl:call-template>
     
    </xsl:when>
    </xsl:choose>
    
    <!--  Application date. -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
     <xsl:with-param name="id">appl_date_view</xsl:with-param>
     <xsl:with-param name="value" select="appl_date" />
     <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <!--
   General Details fieldset, used in trade message and trade message transfer.
   -->
  <xsl:template name="message-general-details">
   <xsl:param name="additional-details"/>
   <xsl:variable name="changeoption"><xsl:value-of select="utils:getActionRequiredOption(product_code,'*',tnx_type_code,prod_stat_code)"/></xsl:variable>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="button-type">
    <xsl:if test="$changeoption='UPDATED'">cross-ref-updated</xsl:if>  
     <xsl:if test="$changeoption='FULL'">crossref-full</xsl:if>
     <xsl:if test="$changeoption='SUMMARY'">crossref-summary</xsl:if>
    </xsl:with-param>
    <xsl:with-param name="content">
     <!--  System ID. -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
      <xsl:with-param name="id">general_details_ref_id_view</xsl:with-param>
      <xsl:with-param name="value" select="ref_id" />
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">ref_id</xsl:with-param>
     </xsl:call-template>
   
     <!-- Customer Reference -->
     <xsl:if test="cust_ref_id[.!='']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
       <xsl:with-param name="id">general_details_cust_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="cust_ref_id" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:if test="$displaymode='edit'">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">cust_ref_id</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
     </xsl:if>
   
     <!-- Bank Reference -->
     <xsl:if test="bo_ref_id[.!='']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
       <xsl:with-param name="id">general_details_bo_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="bo_ref_id" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:if test="$displaymode='edit'">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">bo_ref_id</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
     </xsl:if>
     
     <!-- Issue Date -->
     <xsl:if test="iss_date[.!='']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
       <xsl:with-param name="id">general_details_iss_date_view</xsl:with-param>
       <xsl:with-param name="value" select="iss_date"/>
       <xsl:with-param name="type">date</xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:if test="$displaymode='edit'">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">iss_date</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
     </xsl:if>
   
     <!--
      Display the maturity date for TF transactions, expiry date otherwise. 
      -->
     <xsl:choose>
      <xsl:when test="product_code[.='TF']">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
        <xsl:with-param name="id">maturity_date_view</xsl:with-param>
        <xsl:with-param name="value" select="maturity_date" />
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
       <xsl:if test="$displaymode='edit'">
        <xsl:call-template name="hidden-field">
         <xsl:with-param name="name">maturity_date</xsl:with-param>
        </xsl:call-template>
       </xsl:if>
      </xsl:when>
      <xsl:when test="product_code[.='SI']">
      	<!-- see trade_message_si.xsl -->
      </xsl:when>
      <xsl:when test="product_code[.='BG']">
       	<!-- see trade_message_bg.xsl -->     
      </xsl:when>      
      <xsl:otherwise>
       <!-- Expiry Date -->
       <xsl:if test="exp_date[.!='']">
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
         <xsl:with-param name="id">exp_date_view</xsl:with-param>
         <xsl:with-param name="value" select="exp_date"/>
         <xsl:with-param name="type">date</xsl:with-param>
         <xsl:with-param name="override-displaymode">view</xsl:with-param>
        </xsl:call-template>
        <xsl:if test="$displaymode='edit'">
         <xsl:call-template name="hidden-field">
          <xsl:with-param name="name">exp_date</xsl:with-param>
         </xsl:call-template>
        </xsl:if>
       </xsl:if>
      </xsl:otherwise>
     </xsl:choose>
     <xsl:copy-of select="$additional-details"/>
    </xsl:with-param> 
   </xsl:call-template>
  </xsl:template>
  
  <!--
   Message freeformat textarea, used in trade message and trade message transfer.
   -->
  <xsl:template name="message-freeformat">
  	<xsl:param name="required">N</xsl:param>
  	<xsl:param name="value"/>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_FREE_FORMAT</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">free_format_text</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
      	<xsl:choose>
      	<xsl:when test="product_code[.='LC' or .='SI']">
	       <xsl:call-template name="textarea-field">
	        <xsl:with-param name="name">free_format_text</xsl:with-param>
	        <xsl:with-param name="swift-validate">N</xsl:with-param>
	        <xsl:with-param name="rows">12</xsl:with-param>
	        <xsl:with-param name="cols">65</xsl:with-param>
	        <xsl:with-param name="maxlines">100</xsl:with-param>
	        <xsl:with-param name="required"><xsl:value-of select="$required"/></xsl:with-param>
	        <xsl:with-param name="value"><xsl:value-of select="$value"/></xsl:with-param>
	       </xsl:call-template>
	    </xsl:when>
	    <xsl:otherwise>
	    	<xsl:call-template name="textarea-field">
	        <xsl:with-param name="name">free_format_text</xsl:with-param>
	        <xsl:with-param name="swift-validate">N</xsl:with-param>
	        <xsl:with-param name="rows">12</xsl:with-param>
	        <xsl:with-param name="cols">65</xsl:with-param>
	        <xsl:with-param name="maxlines">100</xsl:with-param>
	        <xsl:with-param name="required"><xsl:value-of select="$required"/></xsl:with-param>
	        <xsl:with-param name="value"><xsl:value-of select="$value"/></xsl:with-param>
	       </xsl:call-template>
	    </xsl:otherwise>
	    </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template> 
  </xsl:template>

  <!--
   Basic Amount Details fieldset, containing just currency and amount fields. 
   -->
  <xsl:template name="basic-amt-details">
   <xsl:param name="override-product-code" select="$lowercase-product-code"/>
   <xsl:param name="label">XSL_AMOUNTDETAILS_LC_AMT_LABEL</xsl:param>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label" select="$label"/>
      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
     <!-- Displayed in details summary view -->
     <xsl:if test="$displaymode='view'">
      <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_liab_amt</xsl:variable>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="name"><xsl:value-of select="$override-product-code"/>_liab_amt</xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
       <xsl:with-param name="value">
         <xsl:variable name="field-value"><xsl:value-of select="//*[name()=$field-name]"/></xsl:variable>
         <xsl:variable name="curcode-field-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>
         <xsl:variable name="curcode-field-value"><xsl:value-of select="//*[name()=$curcode-field-name]"/></xsl:variable>
	     <xsl:if test="$field-value !=''">
	      <xsl:value-of select="$curcode-field-value"></xsl:value-of>&nbsp;<xsl:value-of select="$field-value"></xsl:value-of>
	     </xsl:if>
	   </xsl:with-param>
      </xsl:call-template>
     </xsl:if>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!--
   Bank customer references array. 
   -->
 <xsl:template match="bank" mode="customer_references">
  <xsl:choose>
   <xsl:when test="../../entities[.= '0']">
    misys._config.customerReferences['<xsl:value-of select="abbv_name"/>_'] = [<xsl:if test="count(customer_reference/reference)>1">'','',</xsl:if><xsl:call-template name="quote_replace"><xsl:with-param name="input_text"><xsl:value-of select="@name"/></xsl:with-param></xsl:call-template><xsl:apply-templates select="customer_reference" mode="array"/>];
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates select="entity" mode="array"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
  
 <!--
  Entity References. 
  -->
 <xsl:template match="entity" mode="array">
   misys._config.customerReferences['<xsl:value-of select="../abbv_name"/>_<xsl:call-template name="quote_replace"><xsl:with-param name="input_text"><xsl:value-of select="@name"/></xsl:with-param></xsl:call-template>'] = [<xsl:if test="count(customer_reference/reference)>1">'','',</xsl:if><xsl:apply-templates select="customer_reference" mode="array"/>];
 </xsl:template>
  
 <!--
  Customer reference options 
  -->
 <xsl:template match="customer_reference" mode="option">
  <xsl:param name="selected_reference"/>
   <option>
	   <xsl:attribute name="value"><xsl:value-of select="reference"/></xsl:attribute>
   	   <xsl:value-of select="description"/>
  </option>
 </xsl:template>
  
 <!--
  Customer reference array 
  -->
 <xsl:template match="customer_reference" mode="array">'<xsl:call-template name="quote_replace"><xsl:with-param name="input_text"><xsl:value-of select="description"/></xsl:with-param></xsl:call-template>','<xsl:call-template name="quote_replace"><xsl:with-param name="input_text"><xsl:value-of select="reference"/></xsl:with-param></xsl:call-template>'<xsl:if test="not(position()=last())">,</xsl:if></xsl:template>
  
 <!--
  Bank Name Options  
  -->
 <xsl:template match="bank" mode="main">
  <xsl:param name="bank"><xsl:value-of select="abbv_name"/></xsl:param>
  <option>
   <xsl:attribute name="value"><xsl:value-of select="$bank"/></xsl:attribute>
   <xsl:value-of select="name"/>
  </option>
 </xsl:template>
 
 <xsl:template match="bank" mode="main-text">
  <xsl:param name="bank"><xsl:value-of select="abbv_name"/></xsl:param>
  <xsl:if test="../../issuing_bank/abbv_name=$bank">
   <xsl:value-of select="name"/>
  </xsl:if>
 </xsl:template>

  <!--
   Instructions for the Bank Fieldset.
   -->
 <xsl:template name="bank-instructions">
  <xsl:param name="send-mode-required">Y</xsl:param>
  <xsl:param name="send-mode-displayed">Y</xsl:param>
  <xsl:param name="send-mode-label">XSL_INSTRUCTIONS_LC_ADV_SEND_MODE_LABEL</xsl:param>
  <xsl:param name="forward-contract-shown">N</xsl:param>
  <xsl:param name="principal-acc-displayed">Y</xsl:param>
  <xsl:param name="fee-acc-displayed">Y</xsl:param>
  <xsl:param name="show-margin-account">N</xsl:param>
  <xsl:param name="show-customer-name">N</xsl:param>
  <xsl:param name="show-customer-id">N</xsl:param>
  
  <xsl:param name="principal-acct-dr-cr">dr</xsl:param>
  <xsl:param name="fee-acct-dr-cr">dr</xsl:param>
  <xsl:param name="margin-acct-dr-cr">dr</xsl:param>
  <xsl:param name="internal-external-accts">internal</xsl:param>
  
  <xsl:choose>
    <xsl:when test="$mode = 'DRAFT' and $displaymode='view'">
     <!-- Don't show the file details for the draft view mode, but do in all other cases -->
     
    </xsl:when>

    <xsl:otherwise>
    <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_INSTRUCTIONS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:if test="$send-mode-displayed='Y'">
      <xsl:call-template name="select-field">
       <xsl:with-param name="label" select="$send-mode-label"/>
       <xsl:with-param name="name">adv_send_mode</xsl:with-param>
       <xsl:with-param name="required">Y<!--<xsl:value-of select="$send-mode-required"/>--></xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="options">
        <xsl:call-template name="adv-send-options"/>
       </xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:if test="$principal-acc-displayed='Y'">
      <xsl:call-template name="user-account-field">
	  	<xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
	  	<xsl:with-param name="name">principal</xsl:with-param>
	    <xsl:with-param name="entity-field">entity</xsl:with-param>
	    <xsl:with-param name="dr-cr"><xsl:value-of select="$principal-acct-dr-cr"/></xsl:with-param>
	    <xsl:with-param name="product_types"></xsl:with-param>
	    <xsl:with-param name="required">N</xsl:with-param>
	    <xsl:with-param name="show-product-types">N</xsl:with-param>
	    <xsl:with-param name="value"><xsl:value-of select="principal_act_name"/></xsl:with-param>
	    <xsl:with-param name="internal-external-accts"><xsl:value-of select="$internal-external-accts"/></xsl:with-param>
	  </xsl:call-template>
	  </xsl:if>
     <xsl:if test="$fee-acc-displayed='Y'">
     <xsl:call-template name="user-account-field">
	  	<xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
	  	<xsl:with-param name="name">fee</xsl:with-param>
	    <xsl:with-param name="entity-field">entity</xsl:with-param>
	    <xsl:with-param name="dr-cr"><xsl:value-of select="$fee-acct-dr-cr"/></xsl:with-param>
	    <xsl:with-param name="product_types"></xsl:with-param>
	    <xsl:with-param name="required">Y</xsl:with-param>
	    <xsl:with-param name="show-product-types">N</xsl:with-param>
	    <xsl:with-param name="value"><xsl:value-of select="fee_act_name"/></xsl:with-param>
	    <xsl:with-param name="internal-external-accts"><xsl:value-of select="$internal-external-accts"/></xsl:with-param>
	  </xsl:call-template>
	  </xsl:if>
     <xsl:if test="product_code[.!='BG'] and product_code[.!='SG'] and product_code[.!='TF']">
     <xsl:call-template name="multichoice-field">
     <xsl:with-param name="label">XSL_BANKDETAILS_LCHOLD_ORIGINAL</xsl:with-param>
     <xsl:with-param name="name">lc_hold_flag</xsl:with-param>
     <xsl:with-param name="type">checkbox</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <xsl:if test="$show-margin-account='Y'">  
     <xsl:if test="$displaymode='edit'">  
     	<xsl:call-template name="multichoice-field">
			<xsl:with-param name="label">XSL_INSTRUCTIONS_MARGIN_LABEL</xsl:with-param>
			<xsl:with-param name="name">margin_indicator</xsl:with-param>
			<xsl:with-param name="type">checkbox</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
		<div id="margin-account-div">
		 <xsl:call-template name="user-account-field">
		  	<xsl:with-param name="label">XSL_INSTRUCTIONS_MARGIN_ACCOUNT_LABEL</xsl:with-param>
		  	<xsl:with-param name="name">margin</xsl:with-param>
		    <xsl:with-param name="entity-field">entity</xsl:with-param>
		    <xsl:with-param name="dr-cr"><xsl:value-of select="$margin-acct-dr-cr"/></xsl:with-param>
		    <xsl:with-param name="product_types"></xsl:with-param>
		    <xsl:with-param name="required">N</xsl:with-param>
		    <xsl:with-param name="show-clear-button">N</xsl:with-param>
		    <xsl:with-param name="show-product-types">N</xsl:with-param>
	     	<xsl:with-param name="value"><xsl:value-of select="margin_act_name"/></xsl:with-param>
	     	<xsl:with-param name="internal-external-accts"><xsl:value-of select="$internal-external-accts"/></xsl:with-param>
	  </xsl:call-template>
	 <xsl:if test="product_code[.!='BG']">
	 		<div class="margin-msg"><xsl:value-of select="localization:getGTPString($language, 'XSL_MARGIN_ACCOUNT_MESSAGE')"></xsl:value-of></div>
		</xsl:if>	
		
		<xsl:if test="product_code[.='BG']">
		 <xsl:if test="$displaymode='edit' or margin_indicator[.='Y']">		 
		 	<div class="margin-msg"><xsl:value-of select="localization:getGTPString($language, 'XSL_MARGIN_ACCOUNT_BG_MESSAGE')"></xsl:value-of></div>		 
		 </xsl:if>
		</xsl:if>
		</div>
     </xsl:if>
     
     <xsl:if test="$forward-contract-shown='Y'">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL</xsl:with-param>
       <xsl:with-param name="name">fwd_contract_no</xsl:with-param>
       <xsl:with-param name="size">34</xsl:with-param>
       <xsl:with-param name="maxsize">34</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     
     <xsl:if test="$show-customer-name='Y'">
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GTEEDETAILS_COLLECTOR_NAME</xsl:with-param>
      <xsl:with-param name="name">collector_name</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="maxsize">30</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     
     <xsl:if test="$show-customer-id='Y'">
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GTEEDETAILS_COLLECTOR_ID</xsl:with-param>
      <xsl:with-param name="name">collector_id</xsl:with-param>
      <xsl:with-param name="maxsize">20</xsl:with-param>
     </xsl:call-template>   
     </xsl:if>
     <xsl:call-template name="big-textarea-wrapper">
      <xsl:with-param name="id">free_format_text</xsl:with-param>
      <xsl:with-param name="label">XSL_INSTRUCTIONS_OTHER_INFORMATION</xsl:with-param>     
      <xsl:with-param name="content">
      	<xsl:choose>
      	<xsl:when test="product_code[.='LC' or .='SI']">
	       <xsl:call-template name="textarea-field">
	        <xsl:with-param name="name">free_format_text</xsl:with-param> 
	        <xsl:with-param name="phrase-params">{'category':'12'}</xsl:with-param>       
	        <xsl:with-param name="rows">3</xsl:with-param>
			<xsl:with-param name="cols">65</xsl:with-param>
			<xsl:with-param name="maxlines">100</xsl:with-param>
	       </xsl:call-template>
	     </xsl:when>
	     <xsl:otherwise>
	     	<xsl:call-template name="textarea-field">
	        <xsl:with-param name="name">free_format_text</xsl:with-param> 
	        <xsl:with-param name="rows">3</xsl:with-param>
			<xsl:with-param name="cols">65</xsl:with-param>
			<xsl:with-param name="maxlines">100</xsl:with-param>
	       </xsl:call-template>
	     </xsl:otherwise>
	     </xsl:choose>
      </xsl:with-param>
     </xsl:call-template> 
    </xsl:with-param>
   </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
 </xsl:template>
  
  <!-- 
   Charge hidden details, common to LC, SI and BG. 
  -->
  <xsl:template name="charge-details-hidden">
   <div class="widgetContainer">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_charge_details_position_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="position()" />
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_charge_details_chrg_id_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="chrg_id" />
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_charge_details_chrg_code_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="chrg_code" />
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_charge_details_amt_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="amt" />
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_charge_details_cur_code_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="cur_code" />
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_charge_details_status_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="status" />
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_charge_details_bearer_role_code_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="bearer_role_code" />
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_charge_details_exchange_rate_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="exchange_rate" />
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_charge_details_eqv_amt_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="eqv_amt" />
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_charge_details_eqv_cur_code_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="eqv_cur_code" />
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_charge_details_settlement_date_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="settlement_date" />
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_charge_details_additional_comment_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="additional_comment" />
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_charge_details_created_in_session_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="created_in_session" />
    </xsl:call-template>
   </div>
  </xsl:template>
 
  <!--
    Send type options.
   -->
  <xsl:template name="adv-send-options">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="01">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/>
     </option><!--
     <option value="02">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/>
     </option>
     --><option value="03">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/>
     </option>
     <xsl:if test="ft_type and ft_type = '02'">
      <option value="04">
       <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_REGISTERED_POST')"/>
      </option>
     </xsl:if>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="adv_send_mode[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/></xsl:when>
      <!--<xsl:when test="adv_send_mode[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/></xsl:when>
      --><xsl:when test="adv_send_mode[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/></xsl:when>
      <xsl:when test="adv_send_mode[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_REGISTERED_POST')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
   <xsl:template name="fx-details-for-view">
  <xsl:if test="(fx_rates_type[.!=''] and ((fx_rates_type[.='01'] and fx_exchange_rate and fx_exchange_rate[.!='']) or (fx_rates_type[.='02'])))">
  <xsl:call-template name="fieldset-wrapper">
	           <xsl:with-param name="legend">XSL_HEADER_EXCHANGE_RATE</xsl:with-param>
	           <xsl:with-param name="content">
	             <xsl:call-template name="row-wrapper">
	              <xsl:with-param name="label">XSL_FX_RATES</xsl:with-param>
	              <xsl:with-param name="content"><div class="content">
	                <xsl:if test="fx_rates_type[. = '01']">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_BOARD_RATES')" />
					</xsl:if>
					<xsl:if test="fx_rates_type[. = '02']">
					    <xsl:value-of select="localization:getGTPString($language, 'XSL_FX_CONTRACTS')" />
					</xsl:if>
	              </div></xsl:with-param>
	             </xsl:call-template>
	             <xsl:if test="fx_rates_type[.='01']">
		             <xsl:call-template name="exchange-rate-template"></xsl:call-template>
		             <xsl:if test="fx_tolerance_rate[. != '']">
		             	<xsl:call-template name="tolerance-rate-template"></xsl:call-template>
		             </xsl:if>
		             <xsl:call-template name="row-wrapper">
		              <xsl:with-param name="label"></xsl:with-param>
		              <xsl:with-param name="content"><div class="content" align="left">
					     <xsl:value-of select="localization:getGTPString($language, 'XSL_FX_BOARD_RATE_LABEL')"></xsl:value-of>
	                  </div></xsl:with-param>
	                </xsl:call-template>
	             </xsl:if>
	             <xsl:if test="fx_rates_type[.='02']">
		             <xsl:call-template name="nbr-of-fx-contracts-">
				     <xsl:with-param name="i">1</xsl:with-param>
				     <xsl:with-param name="count"><xsl:value-of select="fx_nbr_contracts"/></xsl:with-param>
				     </xsl:call-template>
				     <xsl:if test="fx_nbr_contracts[. > '1']">
				     <xsl:call-template name="total-amt-utilise-template" />
				     </xsl:if>
	             </xsl:if>
	            </xsl:with-param>
       </xsl:call-template>
     </xsl:if>  
  </xsl:template>
  
  <!-- Exchange Rate  and Equivalent Amount-->
  <xsl:template name="exchange-rate-template">
       <xsl:call-template name="column-container">
           <xsl:with-param name="content">
              <xsl:call-template name="column-wrapper">
	            <xsl:with-param name="content">
	            <xsl:call-template name="row-wrapper">
			      <xsl:with-param name="label">XSL_FX_EXCHANGE_RATE</xsl:with-param>
			      <xsl:with-param name="content">
					<div class="content"><xsl:value-of select="fx_exchange_rate" /></div>
			      </xsl:with-param>
			     </xsl:call-template>
		        </xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="column-wrapper">
               <xsl:with-param name="content">
               <xsl:call-template name="row-wrapper">
	      		 <xsl:with-param name="label">XSL_FX_EQUIVALENT_AMT</xsl:with-param>
	      	 		<xsl:with-param name="content"><div class="content">
	      	 	  <xsl:value-of select="fx_exchange_rate_cur_code"/>&nbsp;<xsl:value-of select="fx_exchange_rate_amt"/>
	     	  	</div></xsl:with-param>
	     		 </xsl:call-template>
		      </xsl:with-param>
           </xsl:call-template>
           </xsl:with-param>
        </xsl:call-template>
  </xsl:template>
   <!-- Tolerance Rate and EQuivalent Amount -->
    <xsl:template name="tolerance-rate-template">
    <xsl:call-template name="column-container">
           <xsl:with-param name="content">
              <xsl:call-template name="column-wrapper">
	            <xsl:with-param name="content">
	            <xsl:call-template name="row-wrapper">
			      <xsl:with-param name="label">XSL_FX_TOLERANCE_RATE</xsl:with-param>
			      <xsl:with-param name="content">
					<div class="content"><xsl:value-of select="fx_tolerance_rate" /></div>
			      </xsl:with-param>
			     </xsl:call-template>
		        </xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="column-wrapper">
               <xsl:with-param name="content">
               <xsl:call-template name="row-wrapper">
	      		 <xsl:with-param name="label">XSL_FX_EQUIVALENT_AMT</xsl:with-param>
	      	 		<xsl:with-param name="content"><div class="content">
	      	 	  <xsl:value-of select="fx_tolerance_rate_cur_code"/>&nbsp;<xsl:value-of select="fx_tolerance_rate_amt"/>
	     	  	</div></xsl:with-param>
	     		 </xsl:call-template>
		      </xsl:with-param>
           </xsl:call-template>
           </xsl:with-param>
        </xsl:call-template>
  	</xsl:template>
  
  <xsl:template name="nbr-of-fx-contracts-">
	   <xsl:param name="i"      />
	   <xsl:param name="count" />
	   <xsl:if test="$i &lt;= $count">
	   <xsl:variable name="row"><xsl:value-of select="$i" /></xsl:variable>
	      <xsl:call-template name="fx-contract-fields">
	       <xsl:with-param name="row"><xsl:value-of select="$i" /></xsl:with-param>
	      </xsl:call-template>
	   </xsl:if>
	   <xsl:if test="$i &lt;= $count">
	      <xsl:call-template name="nbr-of-fx-contracts-">
	          <xsl:with-param name="i">
	              <xsl:value-of select="$i + 1"/>
	          </xsl:with-param>
	          <xsl:with-param name="count">
	              <xsl:value-of select="$count"/>
	          </xsl:with-param>
	      </xsl:call-template>
		   </xsl:if>
	  </xsl:template>
	  
	<xsl:template name="fx-contract-fields">
    <xsl:param name="row" />
		   <xsl:if test="//*[starts-with(name(), concat('fx_contract_nbr_', $row))]">
		       <xsl:call-template name="column-container">
		           <xsl:with-param name="content">
		              <xsl:call-template name="column-wrapper">
			            <xsl:with-param name="content">
			            <xsl:call-template name="row-wrapper">
					      <xsl:with-param name="label">XSL_FX_CONTRACT_NBR</xsl:with-param>
					      <xsl:with-param name="content">
							<div class="content"><xsl:value-of select="//*[starts-with(name(), concat('fx_contract_nbr_', $row))]"></xsl:value-of></div>
					      </xsl:with-param>
					     </xsl:call-template>
				        </xsl:with-param>
		             </xsl:call-template>
		             <xsl:if test="//*[starts-with(name(), concat('fx_contract_nbr_amt_', $row))][.!='']">
			             <xsl:call-template name="column-wrapper">
			               <xsl:with-param name="content">
			               <xsl:call-template name="row-wrapper">
				      		 <xsl:with-param name="label">XSL_FX_EQUIVALENT_AMT</xsl:with-param>
				      	 		<xsl:with-param name="content"><div class="content">
				      	 	  <xsl:value-of select="//*[starts-with(name(), concat('fx_contract_nbr_cur_code_', $row))]"></xsl:value-of>&nbsp;
				      	 	  <xsl:value-of select="//*[starts-with(name(), concat('fx_contract_nbr_amt_', $row))]"></xsl:value-of>
				     	  	</div></xsl:with-param>
				     		 </xsl:call-template>
					      </xsl:with-param>
			           </xsl:call-template>
		           </xsl:if>
		           </xsl:with-param>
		        </xsl:call-template>
			</xsl:if>
	</xsl:template>
	
  <xsl:template name="total-amt-utilise-template">
       <xsl:call-template name="column-container">
           <xsl:with-param name="content">
              <xsl:call-template name="column-wrapper">
	            <xsl:with-param name="content">
	            <xsl:call-template name="row-wrapper">
			      <xsl:with-param name="content">
					<div class="content"><xsl:value-of select="localization:getGTPString($language, 'XSL_FX_CONTRACT_LABEL')" /></div>
			      </xsl:with-param>
			     </xsl:call-template>
		        </xsl:with-param>
             </xsl:call-template>
             <xsl:if test="fx_total_utilise_amt[.!='']">
             <xsl:call-template name="column-wrapper">
               <xsl:with-param name="content">
               <xsl:call-template name="row-wrapper">
	      		 <xsl:with-param name="label">XSL_FX_TOTAL_AMT_TO_UTILISE</xsl:with-param>
	      	 		<xsl:with-param name="content"><div class="content">
	      	 	  <xsl:value-of select="fx_total_utilise_cur_code"/>&nbsp;<xsl:value-of select="fx_total_utilise_amt"/>
	     	  	</div></xsl:with-param>
	     		 </xsl:call-template>
		      </xsl:with-param>
           </xsl:call-template>
           </xsl:if>
           </xsl:with-param>
        </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>