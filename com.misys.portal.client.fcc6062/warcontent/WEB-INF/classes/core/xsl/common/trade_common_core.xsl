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
		xmlns:xd="http://www.pnp-software.com/XSLTdoc"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" 
		exclude-result-prefixes="localization utils security defaultresource">
 
 <xsl:strip-space elements="*"/>
  
 <xsl:param name="up">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:param>
 <xsl:param name="lo">abcdefghijklmnopqrstuvwxyz</xsl:param>
  <xsl:param name="send-mode-required">Y</xsl:param>
  <xsl:param name="issuingBankNameOrAbbvname">abbv_name</xsl:param>
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
 <xsl:include href="form_templates.xsl" />
 <xsl:include href="attachment_templates.xsl" />
 <xsl:include href="../../../collaboration/xsl/collaboration.xsl"/> 
 <xsl:include href="com_cross_references.xsl"/>

 <!--  
  Hidden fields that are used across forms on the customer side.
 -->
 <xsl:template name="common-hidden-fields">
  <xsl:param name="show-type">Y</xsl:param>
  <xsl:param name="show-tnx-amt">Y</xsl:param>
  <xsl:param name="show-tnx-id">Y</xsl:param>
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
	<xsl:if test ="$show-tnx-id='Y'">
   	 <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">tnx_id</xsl:with-param>
   	</xsl:call-template>
   </xsl:if>
   <xsl:if test="$show-tnx-amt='Y'">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">tnx_amt</xsl:with-param>
    </xsl:call-template>
   </xsl:if>
    <xsl:if test="$show-tnx-amt='Y'">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">tnx_cur_code</xsl:with-param>
    </xsl:call-template>
   </xsl:if>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">swiftBicCodeRegexValue</xsl:with-param>
	 <xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BIC_CHARSET')"/></xsl:with-param>
	</xsl:call-template>
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">is798</xsl:with-param>
	 <xsl:with-param name="value"><xsl:value-of select="is_MT798"/></xsl:with-param>
	</xsl:call-template>
	   
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
   <xsl:choose>
	<xsl:when test="inco_term_year and inco_term_year[.!=''] and inco_term[.!='']">
   	 <xsl:call-template name="hidden-field">
  	<xsl:with-param name="name">org_term_year</xsl:with-param>
 	 <xsl:with-param name="value"><xsl:value-of select="inco_term_year"/></xsl:with-param>
	</xsl:call-template>
	</xsl:when>
	<xsl:when test="inco_term[.!='']">
	 <xsl:call-template name="hidden-field">
  	<xsl:with-param name="name">org_term_year</xsl:with-param>
 	 <xsl:with-param name="value">OTHER</xsl:with-param>
	</xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
	 <xsl:call-template name="hidden-field">
  	<xsl:with-param name="name">org_term_year</xsl:with-param>
 	 <xsl:with-param name="value"><xsl:value-of select="inco_term_year"/></xsl:with-param>
	</xsl:call-template>
	</xsl:otherwise>
	</xsl:choose>
	<xsl:call-template name="hidden-field">
  	<xsl:with-param name="name">org_inco_term</xsl:with-param>
 	 <xsl:with-param name="value"><xsl:value-of select="inco_term"/></xsl:with-param>
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
   <xsl:param name="cross-ref-summary-option"></xsl:param>
   <xsl:param name="show-product-code">N</xsl:param>
   <xsl:param name="show-sub-product-code">N</xsl:param>
   <!-- Hidden fields. -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">ref_id</xsl:with-param>
   </xsl:call-template>
  <xsl:call-template name="localization-dialog"/>
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
   
   <xsl:if test="entity[.!=''] and (product_code[.='FT' or .='BK']) and $displaymode='view'">
	   <xsl:call-template name="input-field">
	    <xsl:with-param name="label">ENTITY_LABEL</xsl:with-param>
	    <xsl:with-param name="id">general_entity_view</xsl:with-param>
	    <xsl:with-param name="value" select="entity" />
	    <xsl:with-param name="override-displaymode">view</xsl:with-param>
	   </xsl:call-template>
   </xsl:if>
   
   <!-- Template ID. -->
   <xsl:if test="$show-template-id='Y' and sub_product_code[.!='BANKB']">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_ID</xsl:with-param>
     <xsl:with-param name="name">template_id</xsl:with-param>
     <xsl:with-param name="size">15</xsl:with-param>
     <xsl:with-param name="maxsize">20</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="swift-validate">N</xsl:with-param>
    </xsl:call-template>
   </xsl:if>
   
    <!-- Customer reference -->
    <xsl:if test="$show-cust-ref-id='Y'">
    	<xsl:choose>
    		<xsl:when test="product_code[.='FX'] or (product_code[.='TD'] and sub_product_code[.='TRTD']) or (product_code[.='FT'] and (sub_product_code[.='TRINT'] or sub_product_code[.='TRTPT']))">
    			<xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
				     <xsl:with-param name="name">cust_ref_id</xsl:with-param>
				     <xsl:with-param name="size">20</xsl:with-param>
				     <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TREASURY_LENGTH')"/></xsl:with-param>
				     <xsl:with-param name="regular-expression">
				     			<xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TREASURY_VALIDATION_REGEX')"/>
				     </xsl:with-param>
				     <xsl:with-param name="fieldsize">small</xsl:with-param>
			    </xsl:call-template>
			 </xsl:when>
			 <xsl:when
				test="product_code[.='LC'] or product_code[.='EC'] or product_code[.='BG'] or product_code[.='TF'] or product_code[.='SG'] or product_code[.='SI'] or product_code[.='LI'] or product_code[.='LS']">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
					<xsl:with-param name="name">cust_ref_id</xsl:with-param>
					<xsl:with-param name="size">20</xsl:with-param>
					<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
			 </xsl:when>
			 <xsl:otherwise>   
			    <xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
				     <xsl:with-param name="name">cust_ref_id</xsl:with-param>
				     <xsl:with-param name="size">20</xsl:with-param>
				     <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
				     <xsl:with-param name="regular-expression">
				     			<xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_VALIDATION_REGEX')"/>
				     </xsl:with-param>
   				     <xsl:with-param name="fieldsize">small</xsl:with-param>
			    </xsl:call-template>
	    	</xsl:otherwise>
	    </xsl:choose>
    </xsl:if>
    
    <!-- Bank Reference -->
   <!-- Shown in consolidated view -->
   <xsl:if test="$displaymode='view' and bo_ref_id!='' and (not(tnx_id) or (tnx_type_code[.!='01'] and product_code[.!='FX']) or preallocated_flag[.='Y'])">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
     <xsl:with-param name="id">general_bo_ref_id_view</xsl:with-param>
     <xsl:with-param name="value" select="bo_ref_id" />
    </xsl:call-template>
   </xsl:if>

   <xsl:if test="(product_code[.='FX'] or (product_code[.='TD'] and sub_product_code[.='TRTD']) or (product_code[.='FT'] and (sub_product_code[.='TRINT'] or sub_product_code[.='TRTPT']))) and ($displaymode='view' and tnx_type_code[.!='13'])">
   <xsl:call-template name="row-wrapper">
        <xsl:with-param name="id">event_summary_bo_ref_id_view</xsl:with-param>
        <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
        <xsl:with-param name="content"><div class="content">
          <xsl:value-of select="bo_ref_id"/>
        </div></xsl:with-param>
       </xsl:call-template>
    </xsl:if>
    
   <!-- Cross Refs -->
   <!-- Shown in consolidated view  -->
   <xsl:if test="cross_references">
   	 <xsl:choose>
      <xsl:when test="product_code[.='LI' or .='SG' or .='TF' or .='SI' or .='LC']">
       <xsl:apply-templates select="cross_references" mode="display_table_master"/>
      </xsl:when>
      <xsl:otherwise>
     <xsl:apply-templates select="cross_references" mode="display_table_tnx">
     	<xsl:with-param name="cross-ref-summary-option"><xsl:value-of select="$cross-ref-summary-option"/></xsl:with-param>
    </xsl:apply-templates>
    </xsl:otherwise>
    </xsl:choose>
   </xsl:if>

	<xsl:if test="$show-product-code='Y'">
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_TRANSACTIONDETAILS_PRODUCT_CODE</xsl:with-param>
			<xsl:with-param name="id">product_code</xsl:with-param>
			<xsl:with-param name="value" select="localization:getGTPString($language,concat('TOPMENU_', product_code))" />
			<xsl:with-param name="override-displaymode">view</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	
	<xsl:if test="$show-sub-product-code='Y'">
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_TRANSACTIONDETAILS_PRODUCT_CODE</xsl:with-param>
			<xsl:with-param name="id">sub_product_code</xsl:with-param>
			<xsl:with-param name="value" select="localization:getGTPString($language,concat('TOPMENU_',sub_product_code))" />
			<xsl:with-param name="override-displaymode">view</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
   
    <!--  Application date. -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
     <xsl:with-param name="id">appl_date_view</xsl:with-param>
     <xsl:with-param name="value" select="appl_date" />
	 <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    
    <xsl:if test="iss_date[.!=''] and (not(tnx_id) or tnx_type_code[.!='01']) and product_code[.='LS']">
    	 <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
		     <xsl:with-param name="id">iss_date_view</xsl:with-param>
		     <xsl:with-param name="value" select="iss_date" />
			 <xsl:with-param name="type">date</xsl:with-param>
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    	</xsl:call-template>
	</xsl:if>
	<xsl:if test="amd_no[.!=''] and product_code[.='LS']">
		<xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_COUNT</xsl:with-param>
		     <xsl:with-param name="id">amd_no_view</xsl:with-param>
		     <xsl:with-param name="value" select="amd_no" />
			 <xsl:with-param name="type">amd_no</xsl:with-param>
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    	</xsl:call-template>
	</xsl:if>
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
     <xsl:if test="iss_date[.!=''] and not(product_code[.='EL'] and sub_tnx_type_code[.='87'])">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">
	       <xsl:choose>
	       	<xsl:when test="product_code[.='TF']">XSL_GENERALDETAILS_REQUESTED_ISSUE_DATE</xsl:when>
	       	<xsl:otherwise>XSL_GENERALDETAILS_ISSUE_DATE</xsl:otherwise>
	       </xsl:choose>
       </xsl:with-param>
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
      Also display the financing type, amount, requested percentage, requested amount in case of provisional flow. 
      -->
     <xsl:choose>
      <xsl:when test="product_code[.='TF']">
       <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR_DAYS</xsl:with-param>
	    <xsl:with-param name="name">tenor_view</xsl:with-param>
	    <xsl:with-param name="value" select="tenor" />
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
	   </xsl:call-template>
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
        <xsl:with-param name="id">general_details_maturity_date_view</xsl:with-param>
        <xsl:with-param name="value" select="maturity_date" />
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
       <xsl:if test="$displaymode='edit'">
        <xsl:call-template name="hidden-field">
         <xsl:with-param name="name">maturity_date</xsl:with-param>
        </xsl:call-template>
       </xsl:if>
       <xsl:if test="cross_references/cross_reference/type_code[.='01'] and org_previous_file/tf_tnx_record/prod_stat_code[.='98']">
       		<xsl:call-template name="input-field">
			    <xsl:with-param name="label">XSL_FINANCINGTYPE_LABEL</xsl:with-param>
			    <xsl:with-param name="name">sub_product_code_view</xsl:with-param>
			    <xsl:with-param name="override-displaymode">view</xsl:with-param>
			    <xsl:with-param name="value">
			     <xsl:choose>
					<xsl:when test="$displaymode='edit'">
						<option value='OTHER'>
							<xsl:value-of select="localization:getDecode($language, 'N047', 'OTHER')"/>
						</option>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code)"/>
					</xsl:otherwise>
				</xsl:choose>
			    </xsl:with-param>
		    </xsl:call-template>
		    <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_AMOUNTDETAILS_FIN_AMT_LABEL</xsl:with-param>
			     <xsl:with-param name="name">fin_amt_view</xsl:with-param>
			     <xsl:with-param name="value"><xsl:value-of select="fin_cur_code"/>&nbsp;<xsl:value-of select="fin_amt"/></xsl:with-param>
			     <xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
		    <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_ELIGIBLE_PCT</xsl:with-param>
			     <xsl:with-param name="name">req_pct</xsl:with-param>
			     <xsl:with-param name="size">3</xsl:with-param>
			     <xsl:with-param name="maxsize">5</xsl:with-param>
			     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
			     <xsl:with-param name="type">percentnumber</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="currency-field">
		      	<xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_ELIGIBLE_AMT</xsl:with-param>
		      	<xsl:with-param name="product-code">req</xsl:with-param>
		      	<xsl:with-param name="override-currency-value">
		   			<xsl:value-of select="fin_cur_code"/>
				</xsl:with-param>
				<xsl:with-param name="currency-readonly">Y</xsl:with-param>
				<xsl:with-param name="amt-readonly">Y</xsl:with-param>
				<xsl:with-param name="show-button">N</xsl:with-param>
		    </xsl:call-template>
       </xsl:if>
      </xsl:when>
      <xsl:when test="product_code[.='SI']">
      	<!-- see trade_message_si.xsl -->
      </xsl:when>
      <xsl:when test="product_code[.='BG']">
       	<!-- see trade_message_bg.xsl -->     
      </xsl:when>    
      <xsl:when test="product_code[.='EL']">
       	 <!-- see trade_message_transfer.xsl --> 
      </xsl:when>
      <xsl:otherwise>
       <!-- Expiry Date -->
       <xsl:if test="exp_date[.!='']">
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
         <xsl:with-param name="id">general_details_exp_date_view</xsl:with-param>
         <xsl:with-param name="value" select="exp_date"/>
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
  	<xsl:param name="required">Y</xsl:param>
  	<xsl:param name="mt798enabled">N</xsl:param>
  	<xsl:param name="max-length"/>
  	<xsl:param name="legend-id"/>
  	<xsl:param name="value"/>
  	<xsl:param name="type"/>
  	 <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">
	    <xsl:choose>
	    	<xsl:when test="sub_tnx_type_code[.='96']">XSL_REASON_FOR_CANCELLATION</xsl:when>
	    	<xsl:otherwise>XSL_HEADER_FREE_FORMAT</xsl:otherwise>
	    </xsl:choose> 
    </xsl:with-param>
    <xsl:with-param name="legend-id"><xsl:value-of select="$legend-id"/></xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">free_format_text</xsl:with-param>
     <xsl:with-param name="label">XSL_FREE_FORMAT_CUSTOMER_INSTRUCTIONS</xsl:with-param>
      <xsl:with-param name="required"><xsl:value-of select="$required"/></xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
      	<xsl:choose>
      	<xsl:when test="product_code[.='LC' or .='SI']">
	       <xsl:call-template name="textarea-field">
	        <xsl:with-param name="name">free_format_text</xsl:with-param>
	         <xsl:with-param name="swift-validate">
	        <xsl:choose>
	        		<xsl:when test="$mt798enabled = 'Y' and adv_send_mode[. = '01']">Y</xsl:when>
	        		<xsl:otherwise>N</xsl:otherwise>
	        	</xsl:choose>
	        </xsl:with-param>
	       <xsl:with-param name="rows">
	        	<xsl:choose>
	        		 <xsl:when test="($mt798enabled = 'Y' and adv_send_mode[. = '01'] and $type = 'DISCREPANT') or ($mt798enabled = 'Y' and sub_tnx_type_code[.='68'])">6</xsl:when> 
	        		<xsl:otherwise>12</xsl:otherwise>
	        	</xsl:choose>
	        </xsl:with-param>
	         <xsl:with-param name="maxlines">
	        	<xsl:choose>
	              	<xsl:when test="$mt798enabled = 'Y' and adv_send_mode[. = '01']">
	        		<xsl:choose>
	        		<xsl:when test="$type = 'DISCREPANT'">6</xsl:when>
	        		<xsl:otherwise>35</xsl:otherwise>
	        		</xsl:choose>
	        		</xsl:when>
	        		
	        		<xsl:otherwise>149</xsl:otherwise>
	        	</xsl:choose>
	        </xsl:with-param>
	        <xsl:with-param name="cols">
	       	<xsl:choose>
	        		<xsl:when test="$mt798enabled = 'Y' and adv_send_mode[. = '01']">
	        		<xsl:choose>
		        		<xsl:when test="$type = 'DISCREPANT' or sub_tnx_type_code[.='68']">35</xsl:when>
		        		<xsl:otherwise>50</xsl:otherwise>
		        		</xsl:choose>
	        		</xsl:when>
	        		<xsl:otherwise>65</xsl:otherwise>
	        	</xsl:choose>
	        </xsl:with-param>
	        <xsl:with-param name="required"><xsl:value-of select="$required"/></xsl:with-param>
	        <xsl:with-param name="value"><xsl:value-of select="$value"/></xsl:with-param>
	        <xsl:with-param name="maxSize">
	        	<xsl:if test="$mt798enabled = 'Y' and sub_tnx_type_code[.='68']">210</xsl:if>
	        </xsl:with-param>
	       </xsl:call-template>
       </xsl:when>
       <xsl:when test="product_code[.='SI']">
	       <xsl:call-template name="textarea-field">
	        <xsl:with-param name="name">free_format_text</xsl:with-param>
	        <xsl:with-param name="phrase-params">{'category':'12'}</xsl:with-param>
	        <xsl:with-param name="swift-validate">
	        <xsl:choose>
	        		<xsl:when test="$mt798enabled = 'Y' and adv_send_mode[. = '01']">Y</xsl:when>
	        		<xsl:otherwise>N</xsl:otherwise>
	        	</xsl:choose>
	        </xsl:with-param>
	      <xsl:with-param name="rows">
	        	<xsl:choose>
	        		 <xsl:when test="$mt798enabled = 'Y' and adv_send_mode[. = '01'] and $type = 'DISCREPANT'">6</xsl:when> 
	        			<xsl:otherwise>12</xsl:otherwise>
	        	</xsl:choose>
	        </xsl:with-param>
	       <xsl:with-param name="maxlines">
	        	<xsl:choose>
	              	<xsl:when test="$mt798enabled = 'Y' and adv_send_mode[. = '01']">
	        		<xsl:choose>
	        		<xsl:when test="$type = 'DISCREPANT'">6</xsl:when>
	        		<xsl:otherwise>35</xsl:otherwise>
	        		</xsl:choose>
	        		</xsl:when>
	        		
	        		<xsl:otherwise>149</xsl:otherwise>
	        	</xsl:choose>
	        </xsl:with-param>
	       <xsl:with-param name="cols">
	       	<xsl:choose>
	        		<xsl:when test="$mt798enabled = 'Y' and adv_send_mode[. = '01']">
	        		<xsl:choose>
	        		<xsl:when test="$type = 'DISCREPANT'">35</xsl:when>
	        		<xsl:otherwise>50</xsl:otherwise>
	        		</xsl:choose>
	        		</xsl:when>
	        		<xsl:otherwise>65</xsl:otherwise>
	        	</xsl:choose>
	        </xsl:with-param>
	        <xsl:with-param name="required"><xsl:value-of select="$required"/></xsl:with-param>
	        <xsl:with-param name="value"><xsl:value-of select="$value"/></xsl:with-param>
	        <xsl:with-param name="maxlength"><xsl:value-of select="$max-length"/></xsl:with-param>
	       </xsl:call-template>
       </xsl:when>
       <xsl:when test="product_code[.='EL' or .='SR']">
       		<xsl:call-template name="textarea-field">
		        <xsl:with-param name="name">free_format_text</xsl:with-param>
       	         <xsl:with-param name="swift-validate">
		        	<xsl:choose>
		        		<xsl:when test="defaultresource:isSwift2018Enabled() and $mt798enabled = 'Y' and adv_send_mode[. = '01'] and product_code[.='EL']">Y</xsl:when>
		        		<xsl:otherwise>N</xsl:otherwise>
		        	</xsl:choose>
		        </xsl:with-param>
		        <xsl:with-param name="rows">
		        	<xsl:choose>
		        		<xsl:when test="defaultresource:isSwift2018Enabled() and $mt798enabled = 'Y' and product_code[.='EL']">6</xsl:when>
		        		<xsl:otherwise>12</xsl:otherwise>
		        	</xsl:choose>
		        </xsl:with-param>
		        <xsl:with-param name="maxlines">
		        	<xsl:choose>
		        		<xsl:when test="defaultresource:isSwift2018Enabled() and $mt798enabled = 'Y' and product_code[.='EL']">6</xsl:when>
		        		<xsl:when test="$mt798enabled = 'Y'">35</xsl:when>
		        		<xsl:otherwise>149</xsl:otherwise>
		        	</xsl:choose>
		        </xsl:with-param>
		        <xsl:with-param name="cols">
		        	<xsl:choose>
		        		<xsl:when test="defaultresource:isSwift2018Enabled() and $mt798enabled = 'Y' and product_code[.='EL']">35</xsl:when>
		        		<xsl:when test="$mt798enabled = 'Y'">50</xsl:when>
		        		<xsl:otherwise>65</xsl:otherwise>
		        	</xsl:choose>
		        </xsl:with-param>
		        <xsl:with-param name="required"><xsl:value-of select="$required"/></xsl:with-param>
		        <xsl:with-param name="value"><xsl:value-of select="$value"/></xsl:with-param>
		        <xsl:with-param name="maxSize">
	        		<xsl:if test="$mt798enabled = 'Y' and sub_tnx_type_code[.='68'] and product_code[.='EL']">210</xsl:if>
	        	</xsl:with-param>
	       </xsl:call-template>
       </xsl:when>
       <xsl:otherwise>
       		<xsl:call-template name="textarea-field">
		        <xsl:with-param name="name">free_format_text</xsl:with-param>
		        <xsl:with-param name="swift-validate">N</xsl:with-param>
		        <xsl:with-param name="rows">12</xsl:with-param>
		        <xsl:with-param name="maxlines">
		        	<xsl:choose>
		        		<xsl:when test="$mt798enabled = 'Y'">35</xsl:when>
		        		<xsl:otherwise>149</xsl:otherwise>
		        	</xsl:choose>
		        </xsl:with-param>
		        <xsl:with-param name="cols">
		        	<xsl:choose>
		        		<xsl:when test="$mt798enabled = 'Y'">50</xsl:when>
		        		<xsl:otherwise>65</xsl:otherwise>
		        	</xsl:choose>
		        </xsl:with-param>
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
     <xsl:choose>
    	<xsl:when test="tnx_type_code[.='03'] and tnx_stat_code[.!='04'] and $displaymode='view' and product_code[.='EC']">
    		<xsl:call-template name="row-wrapper">
           	<xsl:with-param name="label">XSL_AMOUNTDETAILS_COLL_AMT_LABEL</xsl:with-param>
           		<xsl:with-param name="content"><div class="content">
             		<xsl:value-of select="ec_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="org_previous_file/ec_tnx_record/ec_amt"/>
          </div></xsl:with-param>
          </xsl:call-template>
       	</xsl:when>
    	<xsl:otherwise>
     	<xsl:call-template name="currency-field">
      		<xsl:with-param name="label" select="$label"/>
      		<xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
      		<xsl:with-param name="required">Y</xsl:with-param>
     	</xsl:call-template>
    	</xsl:otherwise>
     </xsl:choose>
     <xsl:if test="(product_code[.='LC']or product_code[.='EL'] or product_code[.='SI']) and lc_type[.=02]">
     	<xsl:call-template name="applicable-rules"/>
     </xsl:if>
     <!-- Displayed in details summary view -->
     <xsl:if test="$displaymode='view'">
      <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_outstanding_amt</xsl:variable>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="name"><xsl:value-of select="$override-product-code"/>_outstanding_amt</xsl:with-param>
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
     <!-- MPS-55947(In case of of collections liability amount won't be updated as per banks perspective) -->
     <!-- Displayed in details summary view -->
     <xsl:if test="$displaymode='view' and (product_code[.!='EC'] and product_code[.!='IC']) and security:isBank($rundata)">
      <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_liab_amt</xsl:variable>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">
       <xsl:choose>
	       	<xsl:when test="product_code[.='SG' or .='LI']">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:when>
	       	<xsl:otherwise>XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL</xsl:otherwise>
	   </xsl:choose>
	   </xsl:with-param>
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
    misys._config.customerReferences['<xsl:value-of select="abbv_name"/>_'] = [<xsl:call-template name="quote_replace"><xsl:with-param name="input_text"><xsl:value-of select="@name"/></xsl:with-param></xsl:call-template><xsl:apply-templates select="customer_reference" mode="array"/>];
    misys._config.isoCodes = misys._config.isoCodes || {};
    misys._config.isoCodes['<xsl:value-of select="abbv_name"/>'] = '<xsl:value-of select="iso_code"/>';
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates select="entity[customer_reference and customer_reference/reference != '']" mode="array"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template match="bank" mode="entityBankMap">
     <xsl:variable name="bankNameOrAbbvName">
  	 	<xsl:value-of select="defaultresource:getResource('ISSUINGBANK_NAME_OR_ABBVNAME')"/>
  	 </xsl:variable>
    		 misys._config.entityBankMap = misys._config.entityBankMap || {};
    		 misys._config.entityBankMap[<xsl:choose>
	    								<xsl:when test="$bankNameOrAbbvName = 'name'">
	    									'<xsl:value-of select="name"/>'
	    								</xsl:when>
	    								<xsl:otherwise>
	    									'<xsl:value-of select="abbv_name"/>'
	    								</xsl:otherwise>
    								</xsl:choose>] = [<xsl:for-each select="entity">
    													<xsl:if test="customer_reference">
    														'<xsl:value-of select="customer_reference/bank_abbv_name"/>',
    														'<xsl:value-of select="@name"/>',
    													</xsl:if>
    												 </xsl:for-each>];
    <xsl:apply-templates select="../bank" mode="customer_references"/>
 </xsl:template>
 
 
   <!--
   Bank customer communication channel (MT798 or standard). 
   -->
 <xsl:template match="bank" mode="customer_banks_communication_channel">
    misys._config.customerBanksMT798Channel['<xsl:value-of select="abbv_name"/>'] = <xsl:value-of select="@mt798_enabled"/>;
 </xsl:template>
 
 <!--
   Banks with lead bank access permission
   -->
 <xsl:template match="bank" mode="lead_bank">
    misys._config.leadBankAccess['<xsl:value-of select="abbv_name"/>'] = <xsl:value-of select="@lead_bank_access"/>;
 </xsl:template>
 
 <!--
   Building array of guaranteetypes for which the provisional status is applicable
   -->
 <xsl:template match="provisional">
    misys._config.provisionalProductTypes['<xsl:value-of select="type_code"/>'] = <xsl:value-of select="@enabled"/>;
    
 </xsl:template>
  
 <!--
  Entity References. 
  -->
 <xsl:template match="entity[customer_reference and customer_reference/reference != '']" mode="array">
   misys._config.customerReferences['<xsl:value-of select="../abbv_name"/>_<xsl:call-template name="quote_replace"><xsl:with-param name="input_text"><xsl:value-of select="@name"/></xsl:with-param></xsl:call-template>'] = [<xsl:apply-templates select="customer_reference" mode="array"/>];
   misys._config.isoCodes = misys._config.isoCodes || {};
   misys._config.isoCodes['<xsl:value-of select="../abbv_name"/>'] = '<xsl:value-of select="../iso_code"/>';
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
  <xsl:template match="customer_reference" mode="array">'<xsl:call-template name="quote_replace"><xsl:with-param name="input_text"><xsl:choose><xsl:when test="defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'"><xsl:value-of select="utils:decryptApplicantReference(reference)"/></xsl:when><xsl:otherwise><xsl:value-of select="description"/></xsl:otherwise></xsl:choose></xsl:with-param></xsl:call-template>','<xsl:call-template name="quote_replace"><xsl:with-param name="input_text"><xsl:value-of select="reference"/></xsl:with-param></xsl:call-template>'<xsl:if test="not(position()=last())">,</xsl:if></xsl:template>
 
 <!--
  Bank Name Options  
  -->
  <xsl:variable name="bankNameOrAbbvName">
  <xsl:value-of select="defaultresource:getResource('ISSUINGBANK_NAME_OR_ABBVNAME')"/>
 </xsl:variable> 
 <xsl:template match="bank" mode="main">
  <xsl:param name="bank"><xsl:value-of select="abbv_name"/></xsl:param>
  <option>
<xsl:attribute name="value"><xsl:value-of select="$bank"/></xsl:attribute>
   <xsl:choose>
      <xsl:when test="$bankNameOrAbbvName = 'name'">
        <xsl:value-of select="name"/>
     </xsl:when>
     <xsl:otherwise>
       <xsl:value-of select="abbv_name"/>
     </xsl:otherwise>
  </xsl:choose>
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
  <!-- <xsl:param name="send-mode-required">Y</xsl:param> -->
  <xsl:param name="send-mode-displayed">Y</xsl:param>
  <xsl:param name="send-mode-label">XSL_INSTRUCTIONS_LC_ADV_SEND_MODE_LABEL</xsl:param>
  <xsl:param name="forward-contract-shown">N</xsl:param>
  <xsl:param name="principal-acc-displayed">Y</xsl:param>
  <xsl:param name="fee-acc-displayed">Y</xsl:param>
  <xsl:param name="delivery-to-shown">N</xsl:param>
  <xsl:param name="delivery-channel-displayed">N</xsl:param>
  <xsl:param name="free-format-text-displayed">Y</xsl:param>
  <xsl:param name="is-toc-item">Y</xsl:param>
  
  <div>
  	<script>
  		var deliveryChannelFileAct;
  		<xsl:choose>
	  	<xsl:when test="delivery_channel[.='FACT']"> 
	  		deliveryChannelFileAct = true;
		</xsl:when>
		<xsl:otherwise>
			deliveryChannelFileAct = false;
		</xsl:otherwise>
		</xsl:choose>
  	</script>
  </div>
  
  <xsl:choose>
    <xsl:when test="$mode = 'DRAFT' and $displaymode='view'">
     <!-- Don't show the file details for the draft view mode, but do in all other cases -->
     
    </xsl:when>

    <xsl:otherwise>
   
    <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_INSTRUCTIONS</xsl:with-param>
    <xsl:with-param name="toc-item">
   		<xsl:choose>
       		<xsl:when test="$is-toc-item = 'N'">N</xsl:when>
       		<xsl:otherwise>Y</xsl:otherwise>
       	</xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="content">
     <xsl:if test="$send-mode-displayed='Y'">
      <xsl:call-template name="select-field">
       <xsl:with-param name="label" select="$send-mode-label"/>
       <xsl:with-param name="name">adv_send_mode</xsl:with-param>
       <xsl:with-param name="required"><xsl:value-of select="$send-mode-required"/></xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
         <xsl:with-param name="options">
       <xsl:choose>
      	<xsl:when test="is_MT798[. = 'Y']">
      	  <option value="01">
    	     <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/>
	       </option>
      	</xsl:when>
      	<xsl:otherwise>
      	      <xsl:call-template name="adv-send-options">
        	<xsl:with-param name="option-required"><xsl:value-of select="$send-mode-required"/></xsl:with-param>
        </xsl:call-template>
      	</xsl:otherwise>
       </xsl:choose>
  
       </xsl:with-param>
      </xsl:call-template>
        <xsl:call-template name="input-field">
		   <xsl:with-param name="name">adv_send_mode_text</xsl:with-param>
		    <xsl:with-param name="readonly">Y</xsl:with-param>
		   <xsl:with-param name="required">N</xsl:with-param>
		   <xsl:with-param name="maxsize">35</xsl:with-param>
	   </xsl:call-template>
     </xsl:if>
    <xsl:if test="$delivery-channel-displayed='Y'">
	<xsl:call-template name="select-field">
		<xsl:with-param name="label">XSL_FILESDETAILS_FILEACT_DELIVERY_CHANNEL</xsl:with-param>
		<xsl:with-param name="name">delivery_channel</xsl:with-param>
		<xsl:with-param name="fieldsize">small</xsl:with-param>
	 	<xsl:with-param name="value"><xsl:value-of select="delivery_channel"/></xsl:with-param> 			
		<xsl:with-param name="options">
			<xsl:call-template name="delivery-channel-options"/>
		</xsl:with-param>
	</xsl:call-template>
	</xsl:if>      
	<xsl:variable name="trade_account_source_static">
		<xsl:value-of select="defaultresource:getResource('TRADE_ACCOUNT_SOURCE_STATIC')"/>
	</xsl:variable>       
     <xsl:if test="$principal-acc-displayed='Y'">
     <xsl:choose>
     	<xsl:when test="$trade_account_source_static = 'true'">
          <xsl:call-template name="principal-account-field">
       		<xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
       		<xsl:with-param name="type">account</xsl:with-param>
      		<xsl:with-param name="name">principal_act_no</xsl:with-param>
      		<xsl:with-param name="id">principal_act_no</xsl:with-param>
       		<xsl:with-param name="readonly">Y</xsl:with-param>
       		<xsl:with-param name="size">34</xsl:with-param>
       		<xsl:with-param name="maxsize">34</xsl:with-param>
       		<xsl:with-param name="entity-field">entity</xsl:with-param>
       		<xsl:with-param name="show-product-types">N</xsl:with-param>
         </xsl:call-template>
       </xsl:when>
       <xsl:otherwise>
     		<xsl:choose>
     			<xsl:when test="product_code[.='FT'] and (sub_product_code[.='TINT'] or sub_product_code[.='TTPT'])">
     			 <xsl:call-template name="user-account-field">
					<xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
					<xsl:with-param name="name">principal</xsl:with-param>
					<xsl:with-param name="entity-field">entity</xsl:with-param>
					<xsl:with-param name="dr-cr">debit</xsl:with-param>
					<xsl:with-param name="show-product-types">N</xsl:with-param>
					<xsl:with-param name="product_types"><xsl:value-of select="concat(product_code,':',sub_product_code)"/></xsl:with-param>
        			<xsl:with-param name="product-types-required">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
					<xsl:with-param name="trade_internal_account">Y</xsl:with-param>
				 </xsl:call-template>	    			
     			</xsl:when>
     			<xsl:otherwise>
     			 <xsl:call-template name="user-account-field">
					<xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
					<xsl:with-param name="name">principal</xsl:with-param>
					<xsl:with-param name="entity-field">entity</xsl:with-param>
					<xsl:with-param name="dr-cr">debit</xsl:with-param>
					<xsl:with-param name="show-product-types">N</xsl:with-param>
					<xsl:with-param name="product_types"><xsl:value-of select="product_code"/></xsl:with-param>
        			<xsl:with-param name="product-types-required">N</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
					<xsl:with-param name="trade_internal_account">Y</xsl:with-param>
				 </xsl:call-template>     			
     			</xsl:otherwise>
     		</xsl:choose>
     	</xsl:otherwise>      
     </xsl:choose>
    </xsl:if>
     <xsl:if test="$fee-acc-displayed='Y'">
     <xsl:choose>
     	<xsl:when test="$trade_account_source_static = 'true'">
             <xsl:call-template name="principal-account-field">
                <xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
     		    <xsl:with-param name="type">account</xsl:with-param>
                <xsl:with-param name="name">fee_act_no</xsl:with-param>
                <xsl:with-param name="id">fee_act_no</xsl:with-param>
                <xsl:with-param name="readonly">Y</xsl:with-param>
     			<xsl:with-param name="size">34</xsl:with-param>
      			<xsl:with-param name="maxsize">34</xsl:with-param>
      			<xsl:with-param name="entity-field">entity</xsl:with-param>
                <xsl:with-param name="show-product-types">N</xsl:with-param>
              </xsl:call-template>
       </xsl:when>
     	 <xsl:otherwise>
     		<xsl:choose>
     			<xsl:when test="product_code[.='FT'] and (sub_product_code[.='TINT'] or sub_product_code[.='TTPT'])">
     			 <xsl:call-template name="user-account-field">
					<xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
					<xsl:with-param name="name">fee</xsl:with-param>
					<xsl:with-param name="entity-field">entity</xsl:with-param>
					<xsl:with-param name="dr-cr">debit</xsl:with-param>
					<xsl:with-param name="show-product-types">N</xsl:with-param>
					<xsl:with-param name="product_types"><xsl:value-of select="concat(product_code,':',sub_product_code)"/></xsl:with-param>
        			<xsl:with-param name="product-types-required">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
					<xsl:with-param name="trade_internal_account">Y</xsl:with-param>
				 </xsl:call-template>	    			
     			</xsl:when>
     			<xsl:otherwise>
     			 <xsl:call-template name="user-account-field">
					<xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
					<xsl:with-param name="name">fee</xsl:with-param>
					<xsl:with-param name="entity-field">entity</xsl:with-param>
					<xsl:with-param name="dr-cr">debit</xsl:with-param>
					<xsl:with-param name="show-product-types">N</xsl:with-param>
					<xsl:with-param name="product_types"><xsl:value-of select="product_code"/></xsl:with-param>
        			<xsl:with-param name="product-types-required">N</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
					<xsl:with-param name="trade_internal_account">Y</xsl:with-param>
				 </xsl:call-template>     			
     			</xsl:otherwise>
     		</xsl:choose>
     	</xsl:otherwise>      
      </xsl:choose>	   		
     </xsl:if>
     <xsl:if test="$forward-contract-shown='Y'">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL</xsl:with-param>
       <xsl:with-param name="name">fwd_contract_no</xsl:with-param>
       <xsl:with-param name="size">34</xsl:with-param>
       <xsl:with-param name="maxsize">34</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:if test="$delivery-to-shown='Y'">
	     <xsl:call-template name="select-field">
	      <xsl:with-param name="label">XSL_GTEEDETAILS_DELIVERY_TO_LABEL</xsl:with-param>
	      <xsl:with-param name="name">delivery_to</xsl:with-param>
	      <xsl:with-param name="options">
	       <xsl:call-template name="bg-delivery-to"/>
	      </xsl:with-param>
	     </xsl:call-template>
	     <xsl:if test="$displaymode='edit'">
		     <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="id">delivery_to_other</xsl:with-param>
		      <xsl:with-param name="override-label">&nbsp;</xsl:with-param>
		      <xsl:with-param name="type">textarea</xsl:with-param>
		      <xsl:with-param name="content">
		       <xsl:call-template name="textarea-field">
		        <xsl:with-param name="name">delivery_to_other</xsl:with-param>
		        <xsl:with-param name="button-type"></xsl:with-param>
		        <xsl:with-param name="rows">4</xsl:with-param>
		        <xsl:with-param name="cols">35</xsl:with-param>
		        <xsl:with-param name="maxlines">4</xsl:with-param>
		       </xsl:call-template>
		      </xsl:with-param>
		     </xsl:call-template>
	     </xsl:if>
	  </xsl:if>
	
     <xsl:if test="$free-format-text-displayed='Y'">
     <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">free_format_text</xsl:with-param>
      <xsl:with-param name="label">XSL_INSTRUCTIONS_OTHER_INFORMATION</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
      	<xsl:choose>
      	<xsl:when test="product_code[.='LC' or .='SI']">
      	  <xsl:choose>
      	<xsl:when test="is_MT798[. = 'Y']">
	       <xsl:call-template name="textarea-field">
	        <xsl:with-param name="name">free_format_text</xsl:with-param>
	        <xsl:with-param name="phrase-params">{'category':'12'}</xsl:with-param>
	        <xsl:with-param name="swift-validate">Y</xsl:with-param>
	          <xsl:with-param name="rows">6</xsl:with-param>
	        <xsl:with-param name="cols">35</xsl:with-param>
	        <xsl:with-param name="maxlines">6</xsl:with-param>
	        </xsl:call-template>
	        </xsl:when>
	        <xsl:otherwise>
	        <xsl:call-template name="textarea-field">
	         <xsl:with-param name="name">free_format_text</xsl:with-param>
	        <xsl:with-param name="swift-validate">Y</xsl:with-param>
	       <xsl:with-param name="rows">13</xsl:with-param>
	        <xsl:with-param name="cols">65</xsl:with-param>
	         <xsl:with-param name="maxlines">485</xsl:with-param>
	        <xsl:with-param name="maxlength">32000</xsl:with-param>
	        </xsl:call-template>
	        </xsl:otherwise>
	        </xsl:choose>
	     
	    </xsl:when>
	    <xsl:when test="product_code[.='BG']">
	    <xsl:choose>
      	<xsl:when test="is_MT798[. = 'Y']">
	       <xsl:call-template name="textarea-field">
	        <xsl:with-param name="name">free_format_text</xsl:with-param>
	        <xsl:with-param name="swift-validate">N</xsl:with-param>
	        <xsl:with-param name="rows">13</xsl:with-param>
	        <xsl:with-param name="cols">65</xsl:with-param>
	        <xsl:with-param name="maxlines">100</xsl:with-param>
	        <xsl:with-param name="maxlength">1747</xsl:with-param>
	       </xsl:call-template>
	       </xsl:when>
	        <xsl:otherwise>
	         <xsl:call-template name="textarea-field">
	        <xsl:with-param name="name">free_format_text</xsl:with-param>
	        <xsl:with-param name="swift-validate">N</xsl:with-param>
	        <xsl:with-param name="rows">13</xsl:with-param>
	        <xsl:with-param name="cols">65</xsl:with-param>
	        <xsl:with-param name="maxlines">485</xsl:with-param>
	        <xsl:with-param name="maxlength">32000</xsl:with-param>
	       </xsl:call-template>
	       </xsl:otherwise>
	       </xsl:choose>
	        
	    </xsl:when>
	    
	    <xsl:otherwise>
	    	<xsl:call-template name="textarea-field">
	        <xsl:with-param name="name">free_format_text</xsl:with-param>
	        <xsl:with-param name="swift-validate">N</xsl:with-param>
	        <xsl:with-param name="rows">13</xsl:with-param>
	        <xsl:with-param name="cols">65</xsl:with-param>
	        <xsl:with-param name="maxlines">27</xsl:with-param>
	       </xsl:call-template>
	    </xsl:otherwise>
	    </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <xsl:if test="$swift2019Enabled and product_code[.='SI'] and tnx_type_code[.!='13'] ">
	     	<xsl:if test="$displaymode = 'edit'"> 
				<xsl:call-template name="select-field">
			      <xsl:with-param name="label">XSL_BENE_ADVICE_DELIVERY_MODE</xsl:with-param>
			      <xsl:with-param name="name">delv_org</xsl:with-param>
			      <xsl:with-param name="required">Y</xsl:with-param>
			      <xsl:with-param name="options">
			       <xsl:call-template name="delivery-mode-options"/>
			      </xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="input-field">
			       <xsl:with-param name="name">delv_org_text</xsl:with-param>
			       <xsl:with-param name="size">35</xsl:with-param>
			       <xsl:with-param name="maxsize">35</xsl:with-param>
			       	<xsl:with-param name="disabled">
				       <xsl:choose>
			     		<xsl:when test="delv_org[.='99']">N</xsl:when>
			     		<xsl:otherwise>Y</xsl:otherwise>
			   		   </xsl:choose>
			   		</xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="select-field">
			      <xsl:with-param name="label">XSL_LC_DELIVERY_TO_COLLECTION_BY</xsl:with-param>
			      <xsl:with-param name="name">delivery_to</xsl:with-param>
			      <xsl:with-param name="fieldsize">small</xsl:with-param>
			      <xsl:with-param name="options">
			       <xsl:call-template name="delivery-to-options"/>
			      </xsl:with-param>
			     </xsl:call-template>
					<xsl:call-template name="row-wrapper">
					    <xsl:with-param name="id">narrative_delivery_to</xsl:with-param>
					    <xsl:with-param name="label">N002_BLANK</xsl:with-param>
					    <xsl:with-param name="type">textarea</xsl:with-param>
					    <xsl:with-param name="content">
					     <xsl:call-template name="textarea-field">
					      	<xsl:with-param name="name">narrative_delivery_to</xsl:with-param>
					      	<xsl:with-param name="messageValue"><xsl:value-of select="narrative_delivery_to/text"/></xsl:with-param>
      						<xsl:with-param name="phrase-params">{'category':'62'}</xsl:with-param>
				      		<xsl:with-param name="cols">35</xsl:with-param>
      						<xsl:with-param name="rows">6</xsl:with-param>
			  				<xsl:with-param name="maxlines">6</xsl:with-param>
					       <xsl:with-param name="swift-validate">Y</xsl:with-param>
					     </xsl:call-template>
					    </xsl:with-param>
					</xsl:call-template>	
			</xsl:if>
   		</xsl:if>
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
   <xsl:param name="option-required">Y</xsl:param>
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <xsl:if test="$option-required='N'">
      <option value=""></option>
     </xsl:if>
     	<xsl:if test="($product-code = 'LC')">
            <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C056</xsl:with-param>
			 <xsl:with-param name="productCode">LC</xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="($product-code = 'SI')">
	        <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C057</xsl:with-param>
			 <xsl:with-param name="productCode">SI</xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:if>		
		<xsl:if test="($product-code = 'FT')">
	        <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C058</xsl:with-param>
			 <xsl:with-param name="productCode">FT</xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			 <xsl:with-param name="subProductCode">TTPT</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="($product-code = 'BG')">
	        <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C059</xsl:with-param>
			 <xsl:with-param name="productCode">BG</xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="($product-code = 'EA')">
	        <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C060</xsl:with-param>
			 <xsl:with-param name="productCode">EA</xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="($product-code = 'BR')">
	        <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C061</xsl:with-param>
			 <xsl:with-param name="productCode">BR</xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="($product-code = 'EL')">
	        <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C062</xsl:with-param>
			 <xsl:with-param name="productCode">EL</xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="($product-code = 'EC')">
	        <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C063</xsl:with-param>
			 <xsl:with-param name="productCode">EC</xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:if> 
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="adv_send_mode[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/></xsl:when>
      <xsl:when test="adv_send_mode[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/></xsl:when>
      <xsl:when test="adv_send_mode[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/></xsl:when>
      <xsl:when test="adv_send_mode[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_REGISTERED_POST')"/></xsl:when>
 	  <xsl:when test="adv_send_mode[. = '99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_OTHER')"/></xsl:when>
    
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>

  
  <!-- template general details -->
  <xsl:template name="template-general-details">
   <div class="widgetContainer">
  
    <!-- Existing template -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_ID</xsl:with-param>
     <xsl:with-param name="id">template_id_view</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="template_id"/></xsl:with-param>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">template_id</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="template_id"/></xsl:with-param>
    </xsl:call-template>
    
    <!-- Template Description -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_DESCRIPTION</xsl:with-param>
     <xsl:with-param name="name">template_description</xsl:with-param>
     <xsl:with-param name="size">45</xsl:with-param>
     <xsl:with-param name="maxsize">200</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
    </xsl:call-template>
   </div>
  </xsl:template>
  
  <xsl:template name="fx-details-for-view">
   <xsl:if test="fx_rates_type[.!=''] and ((fx_rates_type[.='01'] and fx_exchange_rate and fx_exchange_rate[.!='']) or (fx_rates_type[.='02']))">
   <xsl:call-template name="fieldset-wrapper">
	           <xsl:with-param name="legend">XSL_HEADER_EXCHANGE_RATE</xsl:with-param>
	           <xsl:with-param name="content">
	            <xsl:if test="fx_rates_type[.!='']">
	             <xsl:call-template name="row-wrapper">
	             <xsl:with-param name="appendClass">fx_rate</xsl:with-param>
	              <xsl:with-param name="label">XSL_FX_RATES</xsl:with-param>
	              <xsl:with-param name="content">
	              	<div class="content">
	                <xsl:if test="fx_rates_type[. = '01']">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_BOARD_RATES')" />
					</xsl:if>
					<xsl:if test="fx_rates_type[. = '02']">
					    <xsl:value-of select="localization:getGTPString($language, 'XSL_FX_CONTRACTS')" />
					</xsl:if>
	              </div>
	             </xsl:with-param>
	             </xsl:call-template>
	             <xsl:if test="fx_rates_type[.='01']">
		             <xsl:call-template name="exchange-rate-template"></xsl:call-template>
		             <xsl:if test="fx_tolerance_rate[. != '']">
		             	<xsl:call-template name="tolerance-rate-template"></xsl:call-template>
		             </xsl:if>
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
				   		<xsl:with-param name="content">
				   			<div class="content">
				   	 			<xsl:value-of select="fx_exchange_rate_cur_code"/>&nbsp;<xsl:value-of select="fx_exchange_rate_amt"/>
				   	  		</div>
				   	  	</xsl:with-param>
				   	</xsl:call-template>
				  	</xsl:with-param>
				</xsl:call-template>
        	</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="column-container">
        	<xsl:with-param name="content">
				<xsl:call-template name="column-wrapper">
				   	<xsl:with-param name="content">
					<xsl:call-template name="row-wrapper">
					   	<xsl:with-param name="label"></xsl:with-param>
					   	<xsl:with-param name="content">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_BOARD_RATE_LABEL')"></xsl:value-of>
					   	</xsl:with-param>
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
           <xsl:call-template name="column-container">
        	<xsl:with-param name="content">
				<xsl:call-template name="column-wrapper">
				   	<xsl:with-param name="content">
					<xsl:call-template name="row-wrapper">
					   	<xsl:with-param name="label"></xsl:with-param>
					   	<xsl:with-param name="content">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_BOARD_RATE_LABEL')"></xsl:value-of>
					   	</xsl:with-param>
					</xsl:call-template>
					</xsl:with-param>
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
              			<div><p></p></div>
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
         
       <xsl:call-template name="input-field">
	    <xsl:with-param name="name">disclaimer</xsl:with-param>
	    <xsl:with-param name="type">text</xsl:with-param>
	    <xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_FX_CONTRACT_LABEL')"></xsl:value-of></xsl:with-param>
	    <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>	
   </xsl:template>
   
   <!-- comments for return -->
   <xsl:template name="comments-for-return">
    <xsl:param name="value" />
    <xsl:param name="mode" />
    <xsl:if test="security:isCustomer($rundata) or security:isCounterparty($rundata)">
   		<xsl:call-template name="fieldset-wrapper">
	  		<xsl:with-param name="legend">XSL_HEADER_MC_COMMENTS_FOR_RETURN</xsl:with-param>
	   		<xsl:with-param name="id">comments-for-return</xsl:with-param>
	   		<xsl:with-param name="content">
			    <xsl:call-template name="textarea-field">
					<xsl:with-param name="label">XSL_HEADER_MC_COMMENTS_FOR_RETURN</xsl:with-param>
					<xsl:with-param name="show-label">N</xsl:with-param>
					<xsl:with-param name="name">return_comments</xsl:with-param>
					<xsl:with-param name="swift-validate">N</xsl:with-param>
					<xsl:with-param name="messageValue"><xsl:value-of select="$value"/></xsl:with-param>
					<xsl:with-param name="rows">5</xsl:with-param>
				   	<xsl:with-param name="cols">50</xsl:with-param>
			   		<xsl:with-param name="maxlines">300</xsl:with-param>
			   		<xsl:with-param name="override-displaymode">
			   			<xsl:choose>
			   				<xsl:when test="$mode = 'UNSIGNED'">edit</xsl:when>
			   				<xsl:otherwise>view</xsl:otherwise>
			   			</xsl:choose>
			   		</xsl:with-param>
			 	</xsl:call-template>
	   		</xsl:with-param>
   		</xsl:call-template>
   	</xsl:if>
   </xsl:template>
   
   	<!-- comments for close -->
   <xsl:template name="comments-for-close">
    <xsl:param name="value" />
    <xsl:param name="mode" />
    <xsl:param name="toc-item">Y</xsl:param>
   		<xsl:call-template name="fieldset-wrapper">
	  		<xsl:with-param name="legend">XSL_HEADER_MC_COMMENTS_FOR_CLOSE</xsl:with-param>
	   		<xsl:with-param name="id">comments-for-close</xsl:with-param>
	   		<xsl:with-param name="toc-item" select="$toc-item"/>
	   		<xsl:with-param name="content">
	   		&nbsp;
			    <xsl:call-template name="textarea-field">
					<xsl:with-param name="label"></xsl:with-param>
					<xsl:with-param name="name">close_comments</xsl:with-param>
					<xsl:with-param name="messageValue"><xsl:value-of select="$value"/></xsl:with-param>
					<xsl:with-param name="rows">5</xsl:with-param>
				   	<xsl:with-param name="cols">50</xsl:with-param>
			   		<xsl:with-param name="maxlines">300</xsl:with-param>
			 	</xsl:call-template>
	   		</xsl:with-param>
   		</xsl:call-template>
   </xsl:template>
   
   <!-- comments for reject -->
   <xsl:template name="comments-for-reject">
    <xsl:param name="value" />
    <xsl:param name="mode" />
   		<xsl:call-template name="fieldset-wrapper">
	  		<xsl:with-param name="legend">XSL_HEADER_MC_COMMENTS_FOR_REJECT</xsl:with-param>
	   		<xsl:with-param name="id">comments-for-reject</xsl:with-param>
	   		<xsl:with-param name="content">
	   			&nbsp;
		   		<xsl:call-template name="textarea-field">
					<xsl:with-param name="label"></xsl:with-param>
					<xsl:with-param name="name">reject_comments</xsl:with-param>
					<xsl:with-param name="messageValue"><xsl:value-of select="$value"/></xsl:with-param>
					<xsl:with-param name="rows">5</xsl:with-param>
				   	<xsl:with-param name="cols">50</xsl:with-param>
			   		<xsl:with-param name="maxlines">300</xsl:with-param>
			   		<xsl:with-param name="override-displaymode">
			   			<xsl:choose>
			   				<xsl:when test="$mode = 'ACCEPT'">edit</xsl:when>
			   				<xsl:otherwise>view</xsl:otherwise>
			   			</xsl:choose>
			   		</xsl:with-param>
				</xsl:call-template>
	   		</xsl:with-param>
   		</xsl:call-template>
   </xsl:template>
	<!-- Template to initialize the product and category map data for dynamic phrase. -->
	<xsl:template name="populate-phrase-data">
		<script>
			dojo.ready(function(){
			  		misys._config = misys._config || {};
			  		
			  		dojo.mixin(misys._config, {
			  			
			   		phraseTypesProductMap : {
			    			<xsl:if test="count(//avail_products/products) > 0" >
				        		<xsl:for-each select="//avail_products/products/type" >
				        			<xsl:variable name="phrase-type" select="."/>
				        			'<xsl:value-of select="$phrase-type"/>': [
				        			<xsl:for-each select="//avail_products/products[type=$phrase-type]/product_code" >
					   				<xsl:variable name="productCode">
										<xsl:value-of select="."/>
   							  		</xsl:variable>
	   								{ 	value:"<xsl:value-of select="."/>",
			         					name:
	  							  		<xsl:choose>
		   									<xsl:when test="defaultresource:isSwift2019Enabled() and $productCode = 'BG'">
		   										"<xsl:value-of select="localization:getDecode($language, 'N001', 'IU' )"/>"
		   									</xsl:when>
		   									<xsl:when test="defaultresource:isSwift2019Enabled() and $productCode = 'BR'">
		   										"<xsl:value-of select="localization:getDecode($language, 'N001', 'RU' )"/>"
		   									</xsl:when>
		   									<xsl:otherwise>
		   										"<xsl:value-of select="localization:getDecode($language, 'N001', . )"/>"
		   									</xsl:otherwise>
	   									</xsl:choose>
			         				},
			   						</xsl:for-each>
			   						]<xsl:if test="not(position()=last())">,</xsl:if>
				         		</xsl:for-each>
				         		,'*':[<xsl:for-each select="//avail_products/products[type='01']/product_code" >
					   					<xsl:variable name="productCode">
											<xsl:value-of select="."/>
   							  			</xsl:variable>
	   									{ 	value:"<xsl:value-of select="."/>",
			         						name:
	  							  			<xsl:choose>
			   									<xsl:when test="defaultresource:isSwift2019Enabled() and $productCode = 'BG'">
			   										"<xsl:value-of select="localization:getDecode($language, 'N001', 'IU' )"/>"
			   									</xsl:when>
			   									<xsl:when test="defaultresource:isSwift2019Enabled() and $productCode = 'BR'">
			   										"<xsl:value-of select="localization:getDecode($language, 'N001', 'RU' )"/>"
			   									</xsl:when>
			   									<xsl:otherwise>
			   										"<xsl:value-of select="localization:getDecode($language, 'N001', . )"/>"
			   									</xsl:otherwise>
	   										</xsl:choose>
			         					},
			   						</xsl:for-each>]
			         		</xsl:if>
						},
			   		
		  			productCategoryMap : {
			    			<xsl:if test="count(//phrase_categories/product_category_map/product) > 0" >
				        		<xsl:for-each select="//phrase_categories/product_category_map/product/product_code" >
				        			<xsl:variable name="productCode" select="." />
			   						'<xsl:value-of select="."/>': [
				   						<xsl:for-each select="//phrase_categories/product_category_map/product[product_code=$productCode]/category" >
				   							<xsl:variable name="categoryDescription" select="category_desc" />
				   							<xsl:variable name="categoryCode" select="category_code" />
				   							{ value:"<xsl:value-of select="$categoryCode"/>",
						         				name:"<xsl:value-of select="$categoryDescription"/>"},
				   						</xsl:for-each>
			   							]<xsl:if test="not(position()=last())">,</xsl:if>
				         		</xsl:for-each>
				         		,'*':[{name:"*",value:"99" }]
			         		</xsl:if>
						}
					});
		   		});
		</script>
	</xsl:template>
	
	 <!--Transactiond details link, and whether to show the details by default -->
 	<xd:doc>
		<xd:short>To show or not Transactiond details link.</xd:short>
		<xd:detail>
			Transactiond details link, and whether to show the details by default
		</xd:detail>
		<xd:param name="show-amddetails">if displaymode is view value is Y else N</xd:param>
	</xd:doc>
 	 <xsl:template name="amend-details-link">
 	   <xsl:param name="show-amddetails">
 	   <xsl:choose>
 	 	 <xsl:when test="$displaymode='view'">Y</xsl:when>
 	 	 <xsl:otherwise>N</xsl:otherwise>
 	  </xsl:choose>
 	 </xsl:param>
 	<xsl:if test="$show-amddetails='N'">
 	 	<script>
 	 	  dojo.ready(function(){
 	 	  misys.toggleAmdDetails(false);                
 	 	  });
 	 	</script>
 	 	<a id="showAmdDetails" onclick="misys.toggleAmdDetails(true);" href="javascript:void(0)" style="display:none"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_AMDDETAILS')"/></a>
 	 	 <a id="hideAmdDetails" onclick="misys.toggleAmdDetails(false);" href="javascript:void(0)"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_HIDE_AMDDETAILS')"/></a>
 	 	
 	 	 <div class="clear"></div><br/>   
 	 	                   
 	 </xsl:if>
 	</xsl:template>
 	
 	<!-- 
	  EC Tenor Details
	  -->
	 <xsl:template name="tenor-details">
	  <xsl:if test="$displaymode='edit'">
	  <xsl:call-template name="select-field">
	   <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR</xsl:with-param>
	   <xsl:with-param name="name">term_code</xsl:with-param>
	   <xsl:with-param name="required">Y</xsl:with-param>
	   <xsl:with-param name="fieldsize">x-large</xsl:with-param>
	   <xsl:with-param name="options">
	    <xsl:call-template name="ec-tenor-types"/>
	   </xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="input-field">
	   <xsl:with-param name="name">tenor_desc</xsl:with-param>
	   <xsl:with-param name="maxsize">35</xsl:with-param>
	   <xsl:with-param name="readonly">N</xsl:with-param>
	  </xsl:call-template>
	  <xsl:variable name="radio-value" select="tenor_type"/>
	     <xsl:call-template name="multioption-inline-wrapper">
		      <xsl:with-param name="group-label">XSL_DRAFT_AGAINST</xsl:with-param>
		      <xsl:with-param name="content">
			        <xsl:call-template name="multichoice-field">
	   			      <xsl:with-param name="group-label">XSL_DRAFT_AGAINST</xsl:with-param>
					  <xsl:with-param name="label">XSL_PAYMENTDETAILS_TENOR_SIGHT</xsl:with-param>
				      <xsl:with-param name="name">tenor_type</xsl:with-param>
				      <xsl:with-param name="id">tenor_type_1</xsl:with-param>
				      <xsl:with-param name="value">01</xsl:with-param>
				      <xsl:with-param name="checked"><xsl:if test="$radio-value = '01'">Y</xsl:if></xsl:with-param>
				      <xsl:with-param name="type">radiobutton</xsl:with-param>
				      <xsl:with-param name="inline">Y</xsl:with-param>
				      <xsl:with-param name="disabled">Y</xsl:with-param>
				     </xsl:call-template>
				     <xsl:call-template name="multichoice-field">
	   			      <xsl:with-param name="group-label">XSL_DRAFT_AGAINST</xsl:with-param>
					  <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR_ACEP</xsl:with-param>
				      <xsl:with-param name="name">tenor_type</xsl:with-param>
				      <xsl:with-param name="id">tenor_type_2</xsl:with-param>
				      <xsl:with-param name="value">02</xsl:with-param>
				      <xsl:with-param name="checked"><xsl:if test="$radio-value = '02'">Y</xsl:if></xsl:with-param>
				      <xsl:with-param name="type">radiobutton</xsl:with-param>
				      <xsl:with-param name="inline">Y</xsl:with-param>
				      <xsl:with-param name="disabled">Y</xsl:with-param>
				     </xsl:call-template>
				     <xsl:call-template name="multichoice-field">
	   			      <xsl:with-param name="group-label">XSL_DRAFT_AGAINST</xsl:with-param>
					  <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR_AVAL</xsl:with-param>
				      <xsl:with-param name="name">tenor_type</xsl:with-param>
				      <xsl:with-param name="id">tenor_type_3</xsl:with-param>
				      <xsl:with-param name="value">03</xsl:with-param>
				      <xsl:with-param name="checked"><xsl:if test="$radio-value = '03'">Y</xsl:if></xsl:with-param>
				      <xsl:with-param name="type">radiobutton</xsl:with-param>
				      <xsl:with-param name="inline">Y</xsl:with-param>
				      <xsl:with-param name="disabled">Y</xsl:with-param>
				     </xsl:call-template>
		    	</xsl:with-param>
	    </xsl:call-template>
	  <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_PAYMENTDETAILS_TENOR_MATURITY</xsl:with-param>
	    <xsl:with-param name="name">tenor_maturity_date</xsl:with-param>
	    <xsl:with-param name="size">10</xsl:with-param>
	    <xsl:with-param name="maxsize">10</xsl:with-param>
	    <xsl:with-param name="fieldsize">small</xsl:with-param>
	    <xsl:with-param name="type">date</xsl:with-param>
	    <xsl:with-param name="swift-validate">N</xsl:with-param>
	    <!-- Made editable Mode for the issue MPS-42032 -->
	   <!--  <xsl:with-param name="readonly">Y</xsl:with-param> -->
	   </xsl:call-template>
	   <xsl:call-template name="input-field">
	    <xsl:with-param name="name">disclaimer</xsl:with-param>
	    <xsl:with-param name="type">date</xsl:with-param>
	    <xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_MATURITY_DISCLAIMER')"></xsl:value-of></xsl:with-param>
	    <xsl:with-param name="override-displaymode">view</xsl:with-param>
	   </xsl:call-template>
	      <xsl:call-template name="multioption-inline-wrapper">
	      <xsl:with-param name="group-label">XSL_TENOR_PERIOD</xsl:with-param>
	      <xsl:with-param name="group-id">tenor_period_label</xsl:with-param>
	      <xsl:with-param name="show-required-prefix">N</xsl:with-param>
	      <xsl:with-param name="content">
	
	        <div class="x-small" maxLength="3" id="tenor_days" name="tenor_days" dojoType="dijit.form.NumberTextBox" trim="true" value="">
	         <xsl:attribute name="value"><xsl:value-of select="tenor_days"/></xsl:attribute>
	         <xsl:attribute name="required">N</xsl:attribute>
	         <xsl:attribute name="constraints">{places:'0',min:1, max:999}</xsl:attribute>
	        </div>
	        <select autocomplete="true" dojoType="dijit.form.FilteringSelect" name="tenor_period" id="tenor_period" class="small">
		     <xsl:attribute name="value"><xsl:value-of select="tenor_period"/></xsl:attribute>
	         <option value="D">
	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENORDETAILS_TENOR_DAYS')"/>
	         </option>
	         <option value="W">
	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENORDETAILS_TENOR_WEEKS')"/>
	         </option>
	         <option value="M">
	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENORDETAILS_TENOR_MONTHS')"/>
	         </option>
	         <option value="Y">
	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENORDETAILS_TENOR_YEARS')"/>
	         </option>
	        </select>
	        <select autocomplete="true" dojoType="dijit.form.FilteringSelect" name="tenor_from_after" id="tenor_from_after" class="medium">
		     <xsl:attribute name="value"><xsl:value-of select="tenor_from_after"/></xsl:attribute>
		     <xsl:call-template name="tenor-period-details-options"/>
	        </select><br/>
	        
	        </xsl:with-param>
	      </xsl:call-template>
	       <xsl:call-template name="select-field">
			   <xsl:with-param name="label">XSL_TENOR_START</xsl:with-param>
			   <xsl:with-param name="name">tenor_days_type</xsl:with-param>
			   <xsl:with-param name="fieldsize">large</xsl:with-param>
			   <xsl:with-param name="options">
			   <xsl:call-template name="tenor-days-types-options"/>
			   </xsl:with-param>
	  		</xsl:call-template>
	  		<xsl:call-template name="input-field">
		      <xsl:with-param name="name">tenor_type_details</xsl:with-param>
		      <xsl:with-param name="maxsize">222</xsl:with-param>
	  		</xsl:call-template>
	  		<xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_BASE_DATE</xsl:with-param>
		    <xsl:with-param name="name">tenor_base_date</xsl:with-param>
		    <xsl:with-param name="required">N</xsl:with-param>
		    <xsl:with-param name="size">10</xsl:with-param>
		    <xsl:with-param name="maxsize">10</xsl:with-param>
		    <xsl:with-param name="fieldsize">small</xsl:with-param>
		    <xsl:with-param name="type">date</xsl:with-param>
	   		</xsl:call-template>  
	         </xsl:if>
	         <xsl:if test="$displaymode='view'">
			     	 <xsl:call-template name="input-field">
					     <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR</xsl:with-param>
					     <xsl:with-param name="value">
					     	<xsl:call-template name="ec-tenor-types"/>
					     	<xsl:if test="tenor_desc[.!='']"><xsl:text> / </xsl:text><xsl:value-of select="tenor_desc"/></xsl:if>
					     	<xsl:if test="term_code[.!='01'] and (term_code[.!='03'] or tenor_type[.!='01']) and tenor_days[.!=''] and tenor_period[.!='']">
					     	<xsl:text> / </xsl:text><xsl:value-of select="tenor_days"/>
					     	<xsl:text> </xsl:text>
					     	<xsl:choose>
					     	<xsl:when test="tenor_period[.='D']">
					     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_DAYS')"/>
					     	</xsl:when>
					     	<xsl:when test="tenor_period[.='W']">
					     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_WEEKS')"/>
					     	</xsl:when>
					     	<xsl:when test="tenor_period[.='M']">
					     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_MONTHS')"/>
					     	</xsl:when>
					     	<xsl:when test="tenor_period[.='Y']">
					     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_YEARS')"/>
					     	</xsl:when>
					     	</xsl:choose>
					     		<xsl:choose>
							     	<xsl:when test="tenor_from_after[.='A']">
							     	<xsl:text> </xsl:text>
							     	          <xsl:value-of select="localization:getDecode($language, 'C052', tenor_from_after)"/>
							     	<xsl:text> </xsl:text>
							     	</xsl:when>
							     	<xsl:when test="tenor_from_after[.='E']">
							     	<xsl:text> </xsl:text>
							     	          <xsl:value-of select="localization:getDecode($language, 'C052', tenor_from_after)"/>
							     	<xsl:text> </xsl:text>
							     	</xsl:when>
							     	<xsl:when test="tenor_from_after[.='F']">
							     	<xsl:text> </xsl:text>
							     	          <xsl:value-of select="localization:getDecode($language, 'C052', tenor_from_after)"/>
							     	<xsl:text> </xsl:text>
							     	</xsl:when>	
						     	</xsl:choose>
					     	<xsl:choose>
					     	<xsl:when test="tenor_days_type[.='O']">
					     			<xsl:value-of select="tenor_type_details"/>
					     	</xsl:when>
					     	<xsl:otherwise>
	     					     	 <xsl:value-of select="localization:getDecode($language, 'C053', tenor_days_type)"/>
					     	</xsl:otherwise>
					     	</xsl:choose>
					     	</xsl:if>
					     </xsl:with-param>
			     	  </xsl:call-template>
			     	   <xsl:call-template name="input-field">
					     <xsl:with-param name="label">XSL_DRAFT_AGAINST</xsl:with-param>
					     <xsl:with-param name="value">
					     <xsl:choose>
					     <xsl:when test="tenor_type[.='01']">
					     <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_SIGHT')"></xsl:value-of>
					     </xsl:when>
   					     <xsl:when test="tenor_type[.='02']">
   					     <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_ACEP')"></xsl:value-of>
   					     </xsl:when>
   					     <xsl:when test="tenor_type[.='03']">
   					     <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_AVAL')"></xsl:value-of>
   					     </xsl:when>
					     </xsl:choose>
					     </xsl:with-param>
					    </xsl:call-template>
			     	  <xsl:if test="tenor_type[.='02'] or tenor_type[.='03']">
			     	  	 <xsl:call-template name="input-field">
					     <xsl:with-param name="label">XSL_PAYMENTDETAILS_TENOR_MATURITY</xsl:with-param>
					     <xsl:with-param name="value">
					     <xsl:value-of select="tenor_maturity_date"></xsl:value-of>
					     </xsl:with-param>
					     </xsl:call-template>
					     <xsl:call-template name="input-field">
					     <xsl:with-param name="label">XSL_BASE_DATE</xsl:with-param>
					     <xsl:with-param name="value">
					     <xsl:value-of select="tenor_base_date"></xsl:value-of>
					     </xsl:with-param>
					     </xsl:call-template>
					      <xsl:call-template name="input-field">
						    <xsl:with-param name="name">disclaimer</xsl:with-param>
						    <xsl:with-param name="type">date</xsl:with-param>
						    <xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_MATURITY_DISCLAIMER')"></xsl:value-of></xsl:with-param>
						    <xsl:with-param name="override-displaymode">view</xsl:with-param>
						   </xsl:call-template>
			     	  </xsl:if>
	         </xsl:if>
	 </xsl:template>
	 
	 <!--
	   EC Tenor Types
	   -->
	  <xsl:template name="ec-tenor-types">
	   <xsl:choose>
	    <xsl:when test="$displaymode='edit'">
	     <option value="01">
	      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DP')"/>
	      </option>
	     <option value="02">
	      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DA')"/>
	     </option>
	     <option value="04">
	      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_AVAL')"/>
	     </option>
	     <option value="03">
	      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_OTHER')"/>
	     </option>
	    </xsl:when>
	    <xsl:otherwise>
	     <xsl:choose>
	      <xsl:when test="term_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DP')"/></xsl:when>
	      <xsl:when test="term_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DA')"/></xsl:when>
	      <xsl:when test="term_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_OTHER')"/></xsl:when>
	      <xsl:when test="term_code[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_AVAL')"/></xsl:when>
	     </xsl:choose>
	    </xsl:otherwise>
	   </xsl:choose>
	  </xsl:template>
	  
	  <!-- Options for tenor period -->
	  <xsl:template name="tenor-period-details-options">
		<xsl:for-each select="tenor_period_details/tenor_period_detail">
			<option>
			<xsl:attribute name="value">
			<xsl:value-of select="tenor_period_code"></xsl:value-of>
			</xsl:attribute>
			<xsl:value-of select="tenor_period_desc"></xsl:value-of>
			</option>
		</xsl:for-each>
		</xsl:template>
	  
	  <!-- Options for tenor days type -->
	  <xsl:template name="tenor-days-types-options">
		<xsl:for-each select="tenor_days_types/tenor_days_type">
			<option>
			<xsl:attribute name="value">
			<xsl:value-of select="tenor_days_code"></xsl:value-of>
			</xsl:attribute>
			<xsl:value-of select="tenor_days_desc"></xsl:value-of>
			</option>
		</xsl:for-each>
		</xsl:template>
 	<xsl:template name="applicable-rules">
	      <xsl:call-template name="select-field">
	      <xsl:with-param name="label">XSL_GTEEDETAILS_RULES_LABEL</xsl:with-param>
	      <xsl:with-param name="name">applicable_rules</xsl:with-param>
	      <xsl:with-param name="options">
	       <xsl:call-template name="rules"/>
	      </xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="input-field">
		   <xsl:with-param name="name">applicable_rules_text</xsl:with-param>
		   <xsl:with-param name="maxsize">35</xsl:with-param>
		   <xsl:with-param name="readonly">Y</xsl:with-param>
		   <xsl:with-param name="required">Y</xsl:with-param>
		 </xsl:call-template>
	  </xsl:template>
  
   <xsl:template name="rules">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="01">
      <xsl:value-of select="localization:getDecode($language, 'N065', '01')"/>
     </option>
     <option value="02">
      <xsl:value-of select="localization:getDecode($language, 'N065', '02')"/>
     </option>
     <option value="03">
      <xsl:value-of select="localization:getDecode($language, 'N065', '03')"/>
     </option>
     <option value="04">
      <xsl:value-of select="localization:getDecode($language, 'N065', '04')"/>
     </option>
     <option value="05">
      <xsl:value-of select="localization:getDecode($language, 'N065', '05')"/>
     </option>
     <option value="09">
      <xsl:value-of select="localization:getDecode($language, 'N065', '09')"/>
     </option>
     <option value="99">
      <xsl:value-of select="localization:getDecode($language, 'N065', '99')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="applicable_rules[. = '01']"><xsl:value-of select="localization:getDecode($language, 'N065', '01')"/></xsl:when>
      <xsl:when test="applicable_rules[. = '02']"><xsl:value-of select="localization:getDecode($language, 'N065', '02')"/></xsl:when>
      <xsl:when test="applicable_rules[. = '03']"><xsl:value-of select="localization:getDecode($language, 'N065', '03')"/></xsl:when>
      <xsl:when test="applicable_rules[. = '04']"><xsl:value-of select="localization:getDecode($language, 'N065', '04')"/></xsl:when>
      <xsl:when test="applicable_rules[. = '05']"><xsl:value-of select="localization:getDecode($language, 'N065', '05')"/></xsl:when>
      <xsl:when test="applicable_rules[. = '09']"><xsl:value-of select="localization:getDecode($language, 'N065', '09')"/></xsl:when>
      <xsl:when test="applicable_rules[. = '99']"><xsl:value-of select="localization:getDecode($language, 'N065', '99')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template> 
  <xsl:template name="delivery-mode-options">
   <xsl:param name="option-required">Y</xsl:param>
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <xsl:if test="$option-required='N'">
      <option value=""></option>
     </xsl:if>
     	<xsl:if test="($product-code = 'SI')">
            <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C083</xsl:with-param>
			 <xsl:with-param name="productCode">SI</xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:when>
   </xsl:choose>
  </xsl:template>
    
 
 <xsl:template name="delivery-to-options">
  <xsl:param name="option-required">Y</xsl:param>
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <xsl:if test="$option-required='Y'">
      <option value=""></option>
     </xsl:if>
     	<xsl:if test="($product-code = 'SI')">
            <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C084</xsl:with-param>
			 <xsl:with-param name="productCode">SI</xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:when>
   </xsl:choose>
  </xsl:template>
  
  <xsl:template name="demand-indicator">
   <xsl:param name="option-required">Y</xsl:param>
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
       	<xsl:if test="($product-code = 'SI')">
            <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C089</xsl:with-param>
			 <xsl:with-param name="productCode">SI</xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:when>
   </xsl:choose>
  </xsl:template>
 </xsl:stylesheet>