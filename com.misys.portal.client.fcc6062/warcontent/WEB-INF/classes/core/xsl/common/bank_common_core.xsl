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
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
		xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:loanIQ="xalan://com.misys.portal.loan.loaniq.LoanIQAdapter"
		xmlns:java="http://xml.apache.org/xalan/java"
		xmlns:xd="http://www.pnp-software.com/XSLTdoc"
		exclude-result-prefixes="localization defaultresource converttools xmlRender security utils loanIQ java xd">

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
 <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
 <xsl:param name="actionDownImage"><xsl:value-of select="$images_path"/>action-down.png</xsl:param>
 <xsl:param name="actionUpImage"><xsl:value-of select="$images_path"/>action-up.png</xsl:param>
 
 <!--
  Common includes. 
  -->

 <xsl:include href="common.xsl" />
 <xsl:include href="form_templates.xsl" />
 <xsl:include href="attachment_templates.xsl" />
 <xsl:include href="com_cross_references.xsl"/>
  <xsl:include href="e2ee_common.xsl" />
 
 <!--
   General Details fields, common to forms on the customer side.
   
   System ID, Template ID, Customer Reference, Application Date.
   -->
  <xsl:template name="common-general-details">
   <xsl:param name="show-template-id">Y</xsl:param>
   <xsl:param name="show-cust-ref-id">Y</xsl:param>
<!--    Hidden fields. -->
<!--   <xsl:call-template name="hidden-field">-->
<!--    <xsl:with-param name="name">ref_id</xsl:with-param>-->
<!--   </xsl:call-template>-->
   <!-- Don't display this in unsigned mode. -->
<!--   <xsl:if test="$displaymode='edit'">-->
<!--    <xsl:call-template name="hidden-field">-->
<!--     <xsl:with-param name="name">appl_date</xsl:with-param>-->
<!--    </xsl:call-template>-->
<!--   </xsl:if>-->
	<xsl:call-template name="localization-dialog"/> 
	
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
	     <xsl:with-param name="size">20</xsl:with-param>
	     <xsl:with-param name="maxsize">64</xsl:with-param>
	    </xsl:call-template>
    </xsl:if>
    
    <!--  Application date. -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
     <xsl:with-param name="id">general_appl_date_view</xsl:with-param>
     <xsl:with-param name="value" select="appl_date" />
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
 <!--  
  Hidden fields that are used across forms on the bank side.
 -->
 <xsl:template name="common-hidden-fields">
  <xsl:param name="show-type">Y</xsl:param>
  <xsl:param name="show-cust_ref_id">Y</xsl:param>
  <xsl:param name="show-tnx-amt">Y</xsl:param>
  <xsl:param name="override-product-code" select="$lowercase-product-code"/>
  <xsl:param name="additional-fields"/>
  <div class="widgetContainer">
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
    <xsl:if test="$show-cust_ref_id='Y'">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">cust_ref_id</xsl:with-param>
   </xsl:call-template>
   </xsl:if>
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
	<xsl:call-template name="hidden-field">
  	<xsl:with-param name="name">org_delivery_to</xsl:with-param>
 	 <xsl:with-param name="value"><xsl:value-of select="delivery_to"/></xsl:with-param>
	</xsl:call-template>
   <xsl:copy-of select="$additional-fields"/>
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">swiftBicCodeRegexValue</xsl:with-param>
	 <xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BIC_CHARSET')"/></xsl:with-param>
	</xsl:call-template>
   	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">swiftregexValue</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX')"/></xsl:with-param>
	</xsl:call-template>
<!-- 	<xsl:call-template name="hidden-field">
	    	<xsl:with-param name="name">decAmendmentAmt</xsl:with-param>
	    </xsl:call-template> -->
	<!-- <xsl:if test="product_code[.='LC']">
		<xsl:call-template name="hidden-field">
	    	<xsl:with-param name="name">tnx_amt</xsl:with-param>
	    </xsl:call-template>
    </xsl:if> -->
   </div>
 </xsl:template>
 
 <!--
  Bank Reporting Area - Main Transaction Details 
  
  Common reporting area for all forms on the bank side.
  -->
  
   <xd:doc>
  	<xd:short>Menu field(save,Submit,cancel,help etc) for transactions(buttons located begnning of page)</xd:short>
  	<xd:detail>
	Menu field(save,Submit,cancel,help etc) for transactions(buttons located begnning of page)
  	</xd:detail>
  	<xd:param name="hide-reporting-message-details">To remove bank transaction status from records attached to bulk</xd:param>
  	<xd:param name="hide-charge-details">To remove bank transaction status from records attached to bulk</xd:param>
  	<xd:param name="ftbulk-bank-cancel">Cancel button to behave like normal cancel for some cases in bulk</xd:param>
  </xd:doc>
  
 <xsl:template name="bank-reporting-area">
 <xsl:param name="hide-reporting-message-details">N</xsl:param>
 <xsl:param name="hide-charge-details">N</xsl:param>
 <xsl:param name="ftbulk-bank-cancel">N</xsl:param>
  <xsl:param name="option"/>
  <xsl:param name="forward">N</xsl:param>
  <xsl:if test="security:isBank($rundata)">
 
  <xsl:call-template name="form-wrapper">
   <xsl:with-param name="name">fakeform0</xsl:with-param>
   <xsl:with-param name="validating">Y</xsl:with-param>
   <xsl:with-param name="content">
   
   
   <xsl:choose>
    <xsl:when test="$forward='Y'">
	    <!--  Display forward menu. -->
	    <xsl:call-template name="menu">
	      <xsl:with-param name="show-template">N</xsl:with-param>
     	  <xsl:with-param name="show-submit">N</xsl:with-param>
   		  <xsl:with-param name="show-forward">Y</xsl:with-param>
   		  <xsl:with-param name="show-reject">Y</xsl:with-param>
	    </xsl:call-template>
    </xsl:when>
        <!--  Display common menu. -->
	    <xsl:when test="product_code[.='LC'] and tnx_type_code[.='01'])">
		    	<xsl:call-template name="menu">
		   	    <xsl:with-param name="show-template">Y</xsl:with-param>
		   	    </xsl:call-template>
		</xsl:when>
    <xsl:otherwise>
        <!--  Display common menu. -->
        <xsl:choose>
	        <xsl:when test="$ftbulk-bank-cancel='Y'">
	        	<xsl:call-template name="menu">
				  <xsl:with-param name="show-template">N</xsl:with-param>
				     <xsl:with-param name="cash-bankft-bulk-cancel">Y</xsl:with-param>
				  </xsl:call-template>
		    </xsl:when>
		    <xsl:otherwise>
			    <xsl:call-template name="menu">
			     	<xsl:with-param name="show-template">N</xsl:with-param>
			    </xsl:call-template>
		    </xsl:otherwise>
	    </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
   
    <!-- Transaction Details Fieldset -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend"> <xsl:choose>
				<xsl:when test="security:isBank($rundata) and (product_code[.='LN'])">XSL_HEADER_GENERAL_DETAILS</xsl:when>
				<xsl:otherwise>XSL_HEADER_TRANSACTION_DETAILS</xsl:otherwise>
			</xsl:choose>
	</xsl:with-param>
     <xsl:with-param name="button-type">
     <xsl:if test ="(product_code [.='LC'] and (release_dttm[.!=''] or iss_date [.!=''])) or product_code[.!='LC']">
      <xsl:choose>
       <!-- Uncomment the following to always show/allow the edition from the customer -->
       <!--
       <xsl:when test="tnx_type_code[.!='15'] and not(tnx_type_code[.='01'] and product_code[.='EL' or .='SR' or .='IC' or .='IR' or .='BR']) and not(product_code[.='LC'] and release_dttm[.=''])">-->
       <xsl:when test="tnx_type_code[.!='15'] and not(tnx_type_code[.='01'] and product_code[.='EL' or .='SR' or .='IC' or .='IR' or .='BR'])">
        <xsl:choose>
         <xsl:when test="tnx_type_code[.='01']">summary-full</xsl:when>
         <xsl:when test="product_code[.='LN'] and tnx_type_code[.='03']">summary-full</xsl:when>
         <xsl:when test="product_code[.='LN'] and tnx_type_code[.='13']">summary-full</xsl:when>
         <xsl:when test="product_code[.='TD']">summary-full</xsl:when>
         <xsl:when test="product_code[.='LC' or .='SI'] and tnx_type_code[.='03'] and $swift2018Enabled">amend-summary-details</xsl:when>
         <xsl:otherwise>summary</xsl:otherwise>
        </xsl:choose>
       </xsl:when>
       <xsl:when test="product_code[.='EL' or .='SR'] and tnx_type_code[.='15'] and prod_stat_code[.='08'] and tnx_stat_code[.='06'] and $swift2018Enabled">amend-summary-details</xsl:when>
       <xsl:when test="tnx_type_code[.='15']">summary-details</xsl:when>
      </xsl:choose>
      </xsl:if>
     </xsl:with-param>
     <xsl:with-param name="content">
      <!-- Hidden cross references -->
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      
      <!-- Display the company name in certain instances. -->
      <xsl:if test="(($displaymode='view' or (product_code[.!='EL' and .!='SR' and .!='IC' and .!='IR' and .!='BR'] or tnx_type_code[.!='01'])) and (product_code[.!='LN'] or (product_code[.='LN'] and $displaymode='edit')))">
       
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_COMPANY_NAME</xsl:with-param>
        <xsl:with-param name="id">company_name_view</xsl:with-param>
        <xsl:with-param name="value" select="utils:getCompanyName(ref_id,product_code)" />
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      
     <xsl:if test="security:isBank($rundata) and (product_code[.='LN'])">
	      <xsl:call-template name="input-field">
	        <xsl:with-param name="label">XSL_FACILITYDETAILS_DEAL</xsl:with-param>
			<xsl:with-param name="name">bo_deal_name</xsl:with-param>
	        <xsl:with-param name="override-displaymode">view</xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_FACILITYDETAILS_FACILITY</xsl:with-param>
		    <xsl:with-param name="name">bo_facility_name</xsl:with-param>
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>	
  </xsl:if>
    	       <!-- bo ref id -->
     <xsl:if test="(product_code[.='LN'] and tnx_type_code[.='01'] and $displaymode='view'))">
		<div style="white-space:pre;">
		<xsl:call-template name="input-field">
			<xsl:with-param name="name">bo_ref_id</xsl:with-param>
			<xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID_LN</xsl:with-param>
			<xsl:with-param name="override-displaymode">view</xsl:with-param>
			<xsl:with-param name="appendClass">loanAlias</xsl:with-param>
		</xsl:call-template>
		</div>
	 </xsl:if>
      
      
     <xsl:if test="product_code[.!='LN'] or (product_code[.='LN'] and $displaymode='edit')">
      <xsl:variable name="product-code"><xsl:value-of select="product_code"/></xsl:variable>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_PRODUCT_CODE</xsl:with-param>
       <xsl:with-param name="id">product_code_view</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N001', $product-code)"/></xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
       <xsl:with-param name="id">tnx_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="ref_id"/>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
     <xsl:if test="product_code[.!='LN'] or (product_code[.='LN'] and $displaymode='edit')">     
      <div style="white-space:pre;">
      	<xsl:call-template name="input-field">
      	  <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
          <xsl:with-param name="id">tnx_cust_ref_id_view</xsl:with-param>
          <xsl:with-param name="value"><xsl:value-of select="cust_ref_id"/></xsl:with-param>
          <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
       </div>
     </xsl:if>       
       <xsl:if test="product_code[.='IC']">
	  <xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_TRANSACTIONDETAILS_PRESENTING_BANK</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="presenting_bank/name" /></xsl:with-param>
	  </xsl:call-template>						
       <xsl:if test="appl_date[. != '']">
	   <xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="appl_date" /></xsl:with-param>
	   </xsl:call-template>
	   </xsl:if>
	   </xsl:if>
      <xsl:if test="product_code[.='EL' or .='SR']">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_IMPORT_LC_REF_ID</xsl:with-param>
        <xsl:with-param name="id">tnx_lc_ref_id_view</xsl:with-param>
        <xsl:with-param name="value" select="lc_ref_id"/>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:if test="not(tnx_id) or tnx_type_code[.!='01'] or (product_code[.='LS'] and $displaymode='view' and security:isBank($rundata))">
       <div style="white-space:pre;">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label"> 
            <xsl:choose>
				<xsl:when test="security:isBank($rundata) and (product_code[.='LN'])">XSL_GENERALDETAILS_BO_REF_ID_LN</xsl:when>
				<xsl:otherwise>XSL_GENERALDETAILS_BO_REF_ID</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
        <xsl:with-param name="id">tnx_bo_ref_id_view</xsl:with-param>
        <xsl:with-param name="value" select="bo_ref_id"/>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
       </div>
       <xsl:if test="product_code[.!='IP' and .!='IN']">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">bo_ref_id</xsl:with-param>
        <xsl:with-param name="value" select="bo_ref_id"/>
       </xsl:call-template>
       </xsl:if>
      </xsl:if>
      <xsl:if test="cross_references">
      <xsl:choose>
      <xsl:when test="product_code[.='LI' or .='SG' or .='TF' or .='SI' or .='LC']">
       <xsl:apply-templates select="cross_references" mode="display_table_master"/>
       </xsl:when>
      <xsl:when test="product_code[.='BK'] and sub_product_code[.='LNRPN']">
        <xsl:apply-templates select="cross_references" mode="display_table_master"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="cross_references" mode="display_table_tnx"/>
      </xsl:otherwise>
       </xsl:choose>
      </xsl:if>
      <xsl:if test="cross_references/cross_reference/type_code[.='02']">
       <xsl:variable name="parent_file" select="xmlRender:getXMLMasterNode(cross_references/cross_reference[./type_code='02']/product_code, cross_references/cross_reference[./type_code='02']/ref_id, $language)"/>
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
        <xsl:with-param name="id">tnx_parent_bo_ref_id_view</xsl:with-param>
        <xsl:with-param name="value" select="$parent_file/bo_ref_id"/>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:if test="product_code[.='LI']">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
        <xsl:with-param name="id">tnx_alt_lc_ref_id_view</xsl:with-param>
        <xsl:with-param name="value" select="alt_lc_ref_id"/>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
     <xsl:if test="product_code[.!='LN'] or (product_code[.='LN'] and $displaymode='edit')">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_TRANSACTION_TYPE</xsl:with-param>
       <xsl:with-param name="id">tnx_type_code_view</xsl:with-param>
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
          <!-- <xsl:when test="sub_tnx_type_code[. = '08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_08_DISCREPANT_ACK')"/></xsl:when>		          <xsl:when test="sub_tnx_type_code[. = '08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_08_DISCREPANT_ACK')"/></xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '09']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_09_DISCREPANT_NACK')"/></xsl:when> -->		          <xsl:when test="sub_tnx_type_code[. = '09']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_09_DISCREPANT_NACK')"/></xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '08'] and product_code[.='LC']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_DISCREPANCY_RESPONSE')"/></xsl:when>		
          <xsl:when test="sub_tnx_type_code[. = '08'] and product_code[.!='LC']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_08_DISCREPANT_ACK')"/></xsl:when>		
          <xsl:when test="sub_tnx_type_code[. = '09'] and product_code[.='LC']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_DISCREPANCY_RESPONSE')"/></xsl:when>		
          <xsl:when test="sub_tnx_type_code[. = '09'] and product_code[.!='LC']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_09_DISCREPANT_NACK')"/></xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '11']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '12']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '16']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '19']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '65']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '66']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '67']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '96']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '88']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_88_WORDING_ACK')"/></xsl:when>
          <xsl:when test="sub_tnx_type_code[. = '89']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_89_WORDING_NACK')"/></xsl:when>
         </xsl:choose>
        </xsl:if>
       </xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
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
      <xsl:if test="sub_tnx_type_code[.!= ''] and product_code[.='LC']">		
	          <xsl:call-template name="input-field">		
	           <xsl:with-param name="label">XSL_GENERALDETAILS_DISCREPANCY_RESPONSE</xsl:with-param>		
	           <xsl:with-param name="value">		
	           <xsl:choose>		
	           <xsl:when test="sub_tnx_type_code[. = '08'] and product_code[.='LC']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DISCREPANCY_RESPONSE_AGREE_TO_PAY')"/></xsl:when>		
	           <xsl:when test="sub_tnx_type_code[. = '09'] and product_code[.='LC']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DISCREPANCY_RESPONSE_HOLD_THE_DOCUMENT')"/></xsl:when>		
	           </xsl:choose>		
	           </xsl:with-param>		
	            <xsl:with-param name="override-displaymode">view</xsl:with-param>		
	          </xsl:call-template>		
	      </xsl:if>
      <xsl:if test="release_dttm[.!=''] and (product_code[.!='LN'] or (product_code[.='LN'] and $displaymode='edit'))">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_RELEASE_DTTM</xsl:with-param>
        <xsl:with-param name="id">release_dttm_view</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="converttools:formatReportDate(release_dttm,$rundata,'FULL','FULL')"/></xsl:with-param>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:if test="(free_format_text[.!=''] and product_code[.='LC'] and (sub_tnx_type_code[.='08'] or sub_tnx_type_code[.='09']))"> 		
		        	<xsl:call-template name="big-textarea-wrapper">		
			           <xsl:with-param name="label">XSL_FREE_FORMAT_CUSTOMER_INSTRUCTIONS</xsl:with-param>		
			           <xsl:with-param name="content"><div class="content">		
					    	 		<xsl:value-of select="free_format_text"/>		
			           </div></xsl:with-param>		
			           <xsl:with-param name="override-displaymode">view</xsl:with-param>		
			          </xsl:call-template>		
		</xsl:if>
      <xsl:if test="$displaymode='edit' and tnx_type_code[.='01'] and product_code[.='LC' or .='SI' or .='SG' or .='LI' or .='BG' or .='LS']">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
        <xsl:with-param name="name">iss_date</xsl:with-param>
        <xsl:with-param name="required"><xsl:if test="$mode!='RELEASE'">Y</xsl:if></xsl:with-param>
        <xsl:with-param name="size">10</xsl:with-param>
        <xsl:with-param name="fieldsize">small</xsl:with-param>
        <xsl:with-param name="type">date</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      
      <!-- To display issue date under transaction details MPS-59344 and MPS-59460   -->
      <xsl:if test="$displaymode='view' or (tnx_type_code[.='15'] and product_code[.='BG'])">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
	     <xsl:with-param name="id">general_iss_date_view</xsl:with-param>
	     <xsl:with-param name="value" select="iss_date" />
	     <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
       </xsl:if>
       
       <xsl:if test="tnx_type_code[.='15'] and product_code[.='BG']">
           <div id="amd_no_date_bg_display_div">
			       <xsl:call-template name="input-field">
			        <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>
			        <xsl:with-param name="name">amd_date</xsl:with-param>
			        <xsl:with-param name="size">10</xsl:with-param>
			        <xsl:with-param name="fieldsize">small</xsl:with-param>
			        <xsl:with-param name="type">date</xsl:with-param>
			       </xsl:call-template>
			 </div>
			       <xsl:call-template name="hidden-field">
			          <xsl:with-param name="name">org_inc_amt</xsl:with-param>
			           <xsl:with-param name="value"><xsl:value-of select="inc_amt"/></xsl:with-param>
       			 </xsl:call-template>
          		<xsl:call-template name="hidden-field">
			          <xsl:with-param name="name">org_dec_amt</xsl:with-param>
			           <xsl:with-param name="value"><xsl:value-of select="dec_amt"/></xsl:with-param>
         		 </xsl:call-template> 
		       	  
      </xsl:if>
    <xsl:if test="tnx_type_code[.='03'] or (tnx_type_code[.='15'] and product_code[.='LC' or .='SI'] and $swift2018Enabled)">
	      <div id="amd_no_date_display_div">
		       <xsl:call-template name="input-field">
		        <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>
		        <xsl:with-param name="name">amd_date</xsl:with-param>
		        <xsl:with-param name="size">10</xsl:with-param>
		        <xsl:with-param name="fieldsize">small</xsl:with-param>
		        <xsl:with-param name="type">date</xsl:with-param>
		       </xsl:call-template>
	       </div>
	  
   <xsl:call-template name="hidden-field">
          <xsl:with-param name="name">org_inc_amt</xsl:with-param>
           <xsl:with-param name="value"><xsl:value-of select="inc_amt"/></xsl:with-param>
        </xsl:call-template>
          <xsl:call-template name="hidden-field">
          <xsl:with-param name="name">org_dec_amt</xsl:with-param>
           <xsl:with-param name="value"><xsl:value-of select="dec_amt"/></xsl:with-param>
          </xsl:call-template> 
          
 
      </xsl:if>
     <!--  <xsl:if test="tnx_type_code[.='15'] and $displaymode='edit' and product_code[.!='LC' and .!='SI' and .!='BG']">
         <xsl:call-template name="hidden-field">
          <xsl:with-param name="name">org_inc_amt</xsl:with-param>
           <xsl:with-param name="value"><xsl:value-of select="inc_amt"/></xsl:with-param>
        </xsl:call-template>
          <xsl:call-template name="hidden-field">
          <xsl:with-param name="name">org_dec_amt</xsl:with-param>
           <xsl:with-param name="value"><xsl:value-of select="dec_amt"/></xsl:with-param>
          </xsl:call-template>
       </xsl:if> -->
      <xsl:if test="product_code[.='BK'] and sub_product_code[.='LNRPN']">
	       <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
		     <xsl:with-param name="id">general_appl_date_view</xsl:with-param>
		     <xsl:with-param name="value" select="appl_date" />
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
	  	  </xsl:call-template>
      </xsl:if>
      <xsl:if test="($displaymode='view' and tnx_type_code[.='15']) and (product_code[.='EL' or .='LC' or .='LI' or .='RI' or .='SG' or .='TF'])">
      <xsl:call-template name="transaction_popup"/>
      </xsl:if>
      <xsl:if test="product_code[.='LN'] and $displaymode='view'">    
       	<xsl:call-template name="borrower-details" />
       		<xsl:if test="borrower_name != ''">
				<xsl:call-template name="entity-details" />
			</xsl:if>
      </xsl:if>
     </xsl:with-param>
    </xsl:call-template>
	 
    <!-- Reporting Details Fieldset. -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_REPORTING_DETAILS</xsl:with-param>
     <xsl:with-param name="content">
       <xsl:if test="product_code[.='LC' or .='EL' or .='SI' or .='SR']">
       <!-- <xsl:call-template name="hidden-field">
			<xsl:with-param name="name">swiftregexValue</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX')"/></xsl:with-param>
	   </xsl:call-template> -->
	   <xsl:call-template name="hidden-field">
			<xsl:with-param name="name">swiftregexzcharValue</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX_ZCHAR')"/></xsl:with-param>
	   </xsl:call-template>
	   </xsl:if>
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
         <xsl:with-param name="options">
         <xsl:choose>
         	<xsl:when test="$mode='RELEASE' or product_code[.='LN']">
            <xsl:choose>
			    <xsl:when test="$displaymode='edit'">
			     			<option value="02">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_11_RELEASED')"/>
							</option>
			            <option value="01">
			             <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/>
			            </option>
			    </xsl:when>
			    <xsl:otherwise>
			     <xsl:choose>
			      <xsl:when test="prod_stat_code[.='11']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_11_RELEASED')"/></xsl:when>
			     <xsl:when test="prod_stat_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/></xsl:when>
			     </xsl:choose>
			    </xsl:otherwise>
  		 </xsl:choose>     	
         </xsl:when>
         <xsl:otherwise>
        	 <xsl:call-template name="bank-prod-stat-codes"/>
         </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
   </xsl:call-template>
        
        <xsl:if test="($displaymode='edit' or ($displaymode='view' and tnx_amt[.!=''])) and (product_code[.!='LN'])">
          <xsl:call-template name="currency-field">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_DOCS_AMT_LABEL</xsl:with-param>
          <!--  <xsl:with-param name="name">tnx_amt</xsl:with-param>
           <xsl:with-param name="size">20</xsl:with-param>
           <xsl:with-param name="maxsize">15</xsl:with-param>
           <xsl:with-param name="type">amount</xsl:with-param>
           <xsl:with-param name="fieldsize">small</xsl:with-param> -->
            <xsl:with-param name="label">XSL_AMOUNTDETAILS_DOCS_AMT_LABEL</xsl:with-param>
           <xsl:with-param name="product-code"><xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
             <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
          <xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param>
           <xsl:with-param name="override-currency-name">
                <xsl:choose>
          <xsl:when test="product_code[.='LC'] or product_code[.='SI'] or product_code[.='EL'] or product_code[.='SR']">lc_cur_code</xsl:when>
           <xsl:when test="product_code[.='BG'] or product_code[.='BR']">bg_cur_code</xsl:when>
               <xsl:otherwise><xsl:value-of select="$lowercase-product-code"/>_cur_code</xsl:otherwise>
               </xsl:choose>
               </xsl:with-param>
          </xsl:call-template>
         </xsl:if>
		 <xsl:if test="product_code[.='LC']">
	          <xsl:call-template name="input-field">
		     	<xsl:with-param name="label">XSL_DOC_REF_NO</xsl:with-param>
		    	 <xsl:with-param name="name">doc_ref_no</xsl:with-param>
		    	 <xsl:with-param name="disabled">Y</xsl:with-param>
		    	 <xsl:with-param name="size">16</xsl:with-param>
		    	 <xsl:with-param name="maxsize">16</xsl:with-param>
		   	 </xsl:call-template>
	   	 </xsl:if>
         <xsl:if test="product_code[.!='PO' and .!='LN']">
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
       <!--  <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_AMOUNTDETAILS_DOCS_AMT_LABEL</xsl:with-param>
         <xsl:with-param name="name">tnx_amt</xsl:with-param>
         <xsl:with-param name="size">20</xsl:with-param>
         <xsl:with-param name="maxsize">15</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <xsl:with-param name="type">amount</xsl:with-param>
         <xsl:with-param name="fieldsize">small</xsl:with-param>
        </xsl:call-template> -->
        <xsl:call-template name="currency-field">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_DOCS_AMT_LABEL</xsl:with-param>
           <xsl:with-param name="product-code"><xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
           <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
           <xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param>
           </xsl:call-template>
		  <xsl:if test="product_code[.='LC']">
	         <xsl:call-template name="input-field">
		     	<xsl:with-param name="label">XSL_DOC_REF_NO</xsl:with-param>
		    	 <xsl:with-param name="name">doc_ref_no</xsl:with-param>
		    	  <xsl:with-param name="disabled">Y</xsl:with-param>
		    	 <xsl:with-param name="size">16</xsl:with-param>
		    	 <xsl:with-param name="maxsize">16</xsl:with-param>
		   	 </xsl:call-template>
	   	 </xsl:if>
       </xsl:when>
            
       <xsl:when test="tnx_type_code[.='13'] and sub_tnx_type_code[.='88' or .='89'] and product_code[.='BG' or .='SI' or .='LC']">
        <xsl:call-template name="select-field">
         <xsl:with-param name="label">XSL_REPORTINGDETAILS_NEW_TNX_STAT_LABEL</xsl:with-param>
         <xsl:with-param name="name">prod_stat_code</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <xsl:with-param name="fieldsize">large</xsl:with-param>
         <xsl:with-param name="options">
          <xsl:choose>
           <xsl:when test="$displaymode='edit'">
            <option value="78">
             <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_78_WORDING_UNDER_REVIEW')"/>
            </option>
            <option value="79">
             <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_79_FINAL_WORDING')"/>
            </option>
            <xsl:if test="org_prod_stat_code[.='79']">
            <option value="03">
             <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_APPROVED')"/>
            </option>
            <option value="01">
             <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/>
            </option>
            </xsl:if>
           </xsl:when>
           <xsl:otherwise>
            <xsl:choose>
             <xsl:when test="prod_stat_code[.='78']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_78_WORDING_UNDER_REVIEW')"/></xsl:when>
             <xsl:when test="prod_stat_code[.='79']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_79_FINAL_WORDING')"/></xsl:when>
             <xsl:when test="prod_stat_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_APPROVED')"/></xsl:when>
             <xsl:when test="prod_stat_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/></xsl:when>
            </xsl:choose>
           </xsl:otherwise>
          </xsl:choose>
         </xsl:with-param>
        </xsl:call-template>
        </xsl:when>
        <xsl:when test="tnx_type_code[.='03'] and sub_tnx_type_code[.='05'] and product_code[.='SI' or .='BG' ]">
       	 <xsl:call-template name="hidden-field">
           <xsl:with-param name="name">lc_release_flag</xsl:with-param>
           <xsl:with-param name="value"><xsl:value-of select="lc_release_flag"/></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="hidden-field">
           <xsl:with-param name="name">bg_release_flag</xsl:with-param>
           <xsl:with-param name="value"><xsl:value-of select="bg_release_flag"/></xsl:with-param>
         </xsl:call-template>
        
        <xsl:call-template name="select-field">
         <xsl:with-param name="label">XSL_REPORTINGDETAILS_PROD_STAT_LABEL</xsl:with-param>
         <xsl:with-param name="name">prod_stat_code</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <xsl:with-param name="fieldsize">large</xsl:with-param>
         <xsl:with-param name="options">
          <xsl:choose>
           <xsl:when test="$mode='RELEASE'">
          <xsl:choose>
         	<xsl:when test="$displaymode='edit'">
         		<option value="02">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_11_RELEASED')"/>
				</option>
			    <option value="01">
			    	<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/>
			    </option>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
			    	<xsl:when test="prod_stat_code[.='11']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_11_RELEASED')"/></xsl:when>
			     	<xsl:when test="prod_stat_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/></xsl:when>
			    </xsl:choose>
			</xsl:otherwise>
  		  </xsl:choose>     	
          </xsl:when>
          <xsl:otherwise>
          <xsl:choose>
           <xsl:when test="$displaymode='edit'">
           <xsl:if test="lc_release_flag[.!='Y'] or bg_release_flag[.!='Y']">
            <option value="03">
             <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_APPROVED')"/>
            </option>
            <option value="01">
             <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/>
            </option>
            </xsl:if>
            <xsl:if test="lc_release_flag[.='Y'] or bg_release_flag[.='Y']">
            <option value="76">
             <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_APPROVED')"/>
            </option>
            <option value="01">
             <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/>
            </option>
            </xsl:if>
           </xsl:when>
           <xsl:otherwise>
            <xsl:choose>
             <xsl:when test="prod_stat_code[.='03'] or prod_stat_code[.='76']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_APPROVED')"/></xsl:when>
             <xsl:when test="prod_stat_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/></xsl:when>
             <xsl:when test="prod_stat_code[.='06']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_06_CANCELLED')"/></xsl:when>
            </xsl:choose>
           </xsl:otherwise>
             </xsl:choose>
           </xsl:otherwise>
          </xsl:choose>
         </xsl:with-param>
        </xsl:call-template>
        <xsl:if test="$displaymode='edit' or ($displaymode='view' and release_amt[.!=''])">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_SI_RELEASE_AMT_LABEL</xsl:with-param>
           <xsl:with-param name="name">release_amt</xsl:with-param>
           <xsl:with-param name="size">20</xsl:with-param>
           <xsl:with-param name="maxsize">15</xsl:with-param>
           <xsl:with-param name="type">amount</xsl:with-param>
           <xsl:with-param name="fieldsize">small</xsl:with-param>
          </xsl:call-template>
          </xsl:if>
        </xsl:when>
       <!-- Else if the reporting message is a reply to a customer transaction record (not EL, SR or IC) -->
       <xsl:when test="tnx_type_code[.!='15']">
        <xsl:variable name="prod-stat-value">
         <xsl:choose>
          <!-- Conversion of tnx type code NEW to tnx status code NEW  -->
          <xsl:when test="sub_tnx_stat_code[.='17']">02</xsl:when>
          <!-- Conversion of tnx type code NEW to tnx status code NEW -->
          <xsl:when test="tnx_type_code[.='01']">03</xsl:when>
          <!-- Conversion of tnx type code AMEND to tnx status code AMENDED (when it is not a BG Release or In case of license) -->
          <xsl:when test="tnx_type_code[.='03'] and (product_code[.='LC' or .='SI' or .='LS' or .='EC'] or bg_release_flag[.!='Y'])">08</xsl:when>
          <!-- Conversion of tnx type code AMEND to tnx status code RELEASED (when it is a BG Release) -->
          <xsl:when test="tnx_type_code[.='03'] and product_code[.='BG'] and bg_release_flag[.='Y']">11</xsl:when>
          <!-- Conversion of tnx type code PRESENT to tnx status code Accepted-->
          <xsl:when test="tnx_type_code[.='18'] and product_code[.='DM']">04</xsl:when>
          <!-- Conversion of tnx type code CONSENT to tnx status code Established (PO/SO)-->
          <xsl:when test="tnx_type_code[.='07'] and product_code[.='PO' or .='SO']">32</xsl:when>
          <!-- Amend awaiting for beneficiary approval Acceptance-->
		  <xsl:when test="tnx_type_code[.='13'] and (sub_tnx_type_code[.=46] or sub_tnx_type_code[.=66]) and prod_stat_code[.=31]">08</xsl:when>
		  <!-- Amend awaiting for beneficiary approval Rejection-->
		  <xsl:when test="tnx_type_code[.='13'] and (sub_tnx_type_code[.=47] or sub_tnx_type_code[.=67]) and prod_stat_code[.=31]">32</xsl:when>
		  <!-- Cancel awaiting for beneficiary approval Acceptance-->
		  <xsl:when test="tnx_type_code[.='13'] and (sub_tnx_type_code[.=46] or sub_tnx_type_code[.=66]) and prod_stat_code[.=81]">06</xsl:when>
		  <!-- Cancel awaiting for beneficiary approval Rejection-->
		  <xsl:when test="tnx_type_code[.='13'] and (sub_tnx_type_code[.=47] or sub_tnx_type_code[.=67]) and prod_stat_code[.=81]">82</xsl:when>
		  <xsl:when test="tnx_type_code[.='13'] and prod_stat_code[.=08] and (sub_tnx_type_code[.=24] or sub_tnx_type_code[.=25])">07</xsl:when>
		  <!-- Already Amended -->
		  <xsl:when test="tnx_type_code[.='13'] and prod_stat_code[.=08]">08</xsl:when>
		  <!-- Already Canceled -->
		  <xsl:when test="tnx_type_code[.='13'] and prod_stat_code[.=06]">06</xsl:when>
          <!-- Conversion of sub tnx type code Request for book off to tnx status code Book Off-->
          <xsl:when test="tnx_type_code[.='13'] and product_code[.='LS'] and sub_tnx_type_code[.='65']">A3</xsl:when>
          <!-- Conversion of sub tnx type code Accept to tnx status code Accepted-->
          <xsl:when test="tnx_type_code[.='13'] and product_code[.='LS'] and sub_tnx_type_code[.='66']">04</xsl:when>
          <!-- Conversion of sub tnx type code Cancel to product status code Cancelled-->
          <xsl:when test="tnx_type_code[.='13'] and product_code[.='LS'] and sub_tnx_type_code[.='96']">06</xsl:when>
          <!-- Conversion of sub tnx type code Accept to product status code New for Financing Request Provisional Flow-->
          <xsl:when test="tnx_type_code[.='13'] and product_code[.='TF'] and sub_tnx_type_code[.='66']">03</xsl:when>
          <!-- Conversion of sub tnx type code Reject to product status code Cancelled for Financing Request Provisional Flow-->
          <xsl:when test="tnx_type_code[.='13'] and product_code[.='TF'] and sub_tnx_type_code[.='67']">06</xsl:when>
          <!-- Conversion of the other tnx type codes to tnx status code UPDATED -->
          <xsl:otherwise>07</xsl:otherwise>
         </xsl:choose>
        </xsl:variable>
        <xsl:if test="$hide-reporting-message-details !='Y'">
        <xsl:call-template name="select-field">
         <xsl:with-param name="label">XSL_REPORTINGDETAILS_NEW_TNX_STAT_LABEL</xsl:with-param>
         <xsl:with-param name="name">prod_stat_code</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <!--<xsl:with-param name="value">
           <xsl:if test="prod_stat_code[.!='']">
            <xsl:value-of select="$prod-stat-value"/>
           </xsl:if>
         </xsl:with-param>-->
         <xsl:with-param name="options">
          <xsl:choose>
           <xsl:when test="$displaymode='edit'">
            <option>
             <xsl:attribute name="value">
              <xsl:value-of select="$prod-stat-value"/>
             </xsl:attribute>
             <xsl:choose>
	             <xsl:when test="$prod-stat-value !='02'">
	             	<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_APPROVED')"/>
	             </xsl:when>
	             <xsl:otherwise>
	             	 <xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXSTATCODE_05_STOPOVER_TO_SENT')"/>
	             </xsl:otherwise>
             </xsl:choose>
            </option>
            <option value="01">
             <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/>
            </option>
            <xsl:if test="prod_stat_code [.='98']">
            <option value="98">
            	<xsl:value-of select="localization:getDecode($language, 'N005', prod_stat_code)"/>
            </option>
            </xsl:if>
           </xsl:when>
           <xsl:otherwise>
            <xsl:choose>
			 <xsl:when test="prod_stat_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/></xsl:when>
              <xsl:when test="prod_stat_code[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXSTATCODE_05_STOPOVER_TO_SENT')"/></xsl:when>
              <xsl:when test="prod_stat_code[.='98']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_98_PROVISIONAL')"/></xsl:when>
              <xsl:when test="$prod-stat-value !='02'"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_APPROVED')"/></xsl:when>
             </xsl:choose>
           </xsl:otherwise>
          </xsl:choose>
         </xsl:with-param>
        </xsl:call-template>
        </xsl:if>
         <xsl:if test="$displaymode='view' and bo_ref_id[.!=''] and (product_code[.='SI'] and tnx_type_code[.!='01']) or product_code[.='SR']">
	    <xsl:call-template name="input-field">
     	<xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
     	<xsl:with-param name="value" select="bo_ref_id" />
    	</xsl:call-template>
       </xsl:if>
        <xsl:if test="$displaymode='view' and release_dttm[.!=''] and product_code[.='SI']">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_RELEASE_DTTM</xsl:with-param>
        <xsl:with-param name="id">release_dttm_view</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="converttools:formatReportDate(release_dttm,$rundata,'FULL','FULL')"/></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
       </xsl:when>
       <xsl:when test="product_code[.='LS'] and tnx_type_code[.='15']">
	       	<xsl:call-template name="select-field">
	         <xsl:with-param name="label">XSL_REPORTINGDETAILS_NEW_TNX_STAT_LABEL</xsl:with-param>
	         <xsl:with-param name="name">prod_stat_code</xsl:with-param>
	         <xsl:with-param name="required">Y</xsl:with-param>
	         <xsl:with-param name="fieldsize">large</xsl:with-param>
	         <xsl:with-param name="options"><xsl:call-template name="ls-prod-stat-codes"/></xsl:with-param>
	         </xsl:call-template>
     	     <div id="clear-check-box" style="display:none;">
			     <xsl:call-template name="checkbox-field">
				     <xsl:with-param name="label">XSL_LICENSE_CLEARED</xsl:with-param>
				     <xsl:with-param name="name">ls_clear</xsl:with-param>
			     </xsl:call-template>
			 </div>
		</xsl:when>
       <!-- Else if the reporting is a new message initiated by the bank (not EL, SR or IC New) -->
       <!-- Also added for EL and SR -->
       <xsl:otherwise>
       <xsl:choose>
 		<xsl:when test="security:isBank($rundata) and (product_code[.='LN'])">
 		</xsl:when>
     <xsl:otherwise>
       <xsl:if test="$hide-reporting-message-details !='Y'">
        <xsl:call-template name="select-field">
         <xsl:with-param name="label">XSL_REPORTINGDETAILS_NEW_TNX_STAT_LABEL</xsl:with-param>
         <xsl:with-param name="name">prod_stat_code</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <xsl:with-param name="fieldsize">large</xsl:with-param>
         <xsl:with-param name="options"><xsl:call-template name="prod-stat-codes"/></xsl:with-param>
        </xsl:call-template>
        </xsl:if>
        </xsl:otherwise>
        </xsl:choose>
		
        <xsl:if test="product_code[.='BG' or .='SI' or .='LC'] ">
        <xsl:choose>
        <xsl:when test= "(sub_tnx_type_code[.='25' or .='62' or .='63'] or prod_stat_code[.='84' or .='85' or .='87' or .='88']) and $displaymode='view'"> 
        	<div id='claimDetails'>
        		 <xsl:call-template name="input-field">
			         <xsl:with-param name="label">XSL_CLAIM_REFERENCE_LABEL</xsl:with-param>
			         <xsl:with-param name="name">claim_reference</xsl:with-param>
			         <xsl:with-param name="size">35</xsl:with-param>
			         <xsl:with-param name="maxsize">35</xsl:with-param>
			         <xsl:with-param name="type">text</xsl:with-param>
			         <xsl:with-param name="value"><xsl:value-of select="claim_reference"/></xsl:with-param>
			         <xsl:with-param name="required">Y</xsl:with-param>
			         <xsl:with-param name="fieldsize">small</xsl:with-param>
		         </xsl:call-template>
        		<xsl:call-template name="input-field">
	        		 <xsl:with-param name="label">XSL_CLAIM_PRESENT_DATE_LABEL</xsl:with-param>
				     <xsl:with-param name="name">claim_present_date</xsl:with-param>
				     <xsl:with-param name="size">10</xsl:with-param>
				     <xsl:with-param name="maxsize">10</xsl:with-param>
				      <xsl:with-param name="value"><xsl:value-of select="claim_present_date"/></xsl:with-param>
				     <xsl:with-param name="type">date</xsl:with-param>
				     <xsl:with-param name="fieldsize">small</xsl:with-param>
				     <xsl:with-param name="required">Y</xsl:with-param>
			    </xsl:call-template>
			    <xsl:call-template name="currency-field">
				     <xsl:with-param name="label">
				     <xsl:if test="$displaymode='edit' or ($displaymode='view' and claim_amt != '')">XSL_CLAIM_AMOUNT_LABEL</xsl:if>
				     </xsl:with-param>
				     <xsl:with-param name="product-code">claim</xsl:with-param>
				     <xsl:with-param name="override-currency-value"><xsl:value-of select="claim_cur_code"/></xsl:with-param>
				     <xsl:with-param name="override-amt-value"><xsl:value-of select="claim_amt"/></xsl:with-param>
				     <xsl:with-param name="currency-readonly">Y</xsl:with-param>
				     <xsl:with-param name="show-button">N</xsl:with-param>
				     <xsl:with-param name="required">Y</xsl:with-param>
			    </xsl:call-template> 
        	</div>
			</xsl:when>
			<xsl:when test= "($displaymode='edit')">
        	<div id='claimDetails'>
        		 <xsl:call-template name="input-field">
			         <xsl:with-param name="label">XSL_CLAIM_REFERENCE_LABEL</xsl:with-param>
			         <xsl:with-param name="name">claim_reference</xsl:with-param>
			         <xsl:with-param name="size">35</xsl:with-param>
			         <xsl:with-param name="maxsize">35</xsl:with-param>
			         <xsl:with-param name="type">text</xsl:with-param>
			         <xsl:with-param name="value"><xsl:value-of select="claim_reference"/></xsl:with-param>
			         <xsl:with-param name="required">Y</xsl:with-param>
			         <xsl:with-param name="fieldsize">small</xsl:with-param>
		         </xsl:call-template>
        		<xsl:call-template name="input-field">
	        		 <xsl:with-param name="label">XSL_CLAIM_PRESENT_DATE_LABEL</xsl:with-param>
				     <xsl:with-param name="name">claim_present_date</xsl:with-param>
				     <xsl:with-param name="size">10</xsl:with-param>
				     <xsl:with-param name="maxsize">10</xsl:with-param>
				      <xsl:with-param name="value"><xsl:value-of select="claim_present_date"/></xsl:with-param>
				     <xsl:with-param name="type">date</xsl:with-param>
				     <xsl:with-param name="fieldsize">small</xsl:with-param>
				     <xsl:with-param name="required">Y</xsl:with-param>
			    </xsl:call-template>
			    <xsl:call-template name="currency-field">
				     <xsl:with-param name="label">
				     <xsl:if test="$displaymode='edit' or ($displaymode='view' and claim_amt != '')">XSL_CLAIM_AMOUNT_LABEL</xsl:if>
				     </xsl:with-param>
				     <xsl:with-param name="product-code">claim</xsl:with-param>
				     <xsl:with-param name="override-currency-value"><xsl:value-of select="claim_cur_code"/></xsl:with-param>
				     <xsl:with-param name="override-amt-value"><xsl:value-of select="claim_amt"/></xsl:with-param>
				     <xsl:with-param name="currency-readonly">Y</xsl:with-param>
				     <xsl:with-param name="show-button">N</xsl:with-param>
				     <xsl:with-param name="required">Y</xsl:with-param>
			    </xsl:call-template> 
        	</div>
			</xsl:when>
         </xsl:choose>
        	<xsl:if test="product_code[.='BG']">
        		<!-- <xsl:call-template name="hidden-field">
				<xsl:with-param name="name">swiftregexValue</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX')"/></xsl:with-param>
			</xsl:call-template> -->
	        	<xsl:call-template name="hidden-field">
			         <xsl:with-param name="name">iss_date</xsl:with-param>
			         <xsl:with-param name="value"><xsl:value-of select="iss_date"/></xsl:with-param>
		         </xsl:call-template>
		         <xsl:call-template name="hidden-field">
			         <xsl:with-param name="name">tnx_amt</xsl:with-param>
			         <xsl:with-param name="value"><xsl:value-of select="tnx_amt"/></xsl:with-param>
		         </xsl:call-template>
	         </xsl:if>
        </xsl:if>
         <xsl:if test="product_code[.='BG']">
        	<div id='ExtendPay'>
        	<xsl:call-template name="input-field">
	        		 <xsl:with-param name="label">XSL_EXTEND_PAY_DATE_LABEL</xsl:with-param>
				     <xsl:with-param name="name">extend_pay_date</xsl:with-param>
				     <xsl:with-param name="size">10</xsl:with-param>
				     <xsl:with-param name="maxsize">10</xsl:with-param>
				     <xsl:with-param name="value"><xsl:value-of select="extend_pay_date"/></xsl:with-param>
				     <xsl:with-param name="type">date</xsl:with-param>
				     <xsl:with-param name="fieldsize">small</xsl:with-param>
				     <xsl:with-param name="required">Y</xsl:with-param>
			    </xsl:call-template>
			    <xsl:call-template name="input-field">
	        		 <xsl:with-param name="label">XSL_LATEST_DATE_REPLY_LABEL</xsl:with-param>
				     <xsl:with-param name="name">latest_date_reply</xsl:with-param>
				     <xsl:with-param name="size">10</xsl:with-param>
				     <xsl:with-param name="maxsize">10</xsl:with-param>
				      <xsl:with-param name="value"><xsl:value-of select="latest_date_reply"/></xsl:with-param>
				     <xsl:with-param name="type">date</xsl:with-param>
				     <xsl:with-param name="fieldsize">small</xsl:with-param>
				     <xsl:with-param name="required">Y</xsl:with-param>
			    </xsl:call-template>
        	</div>
        	</xsl:if>
         <xsl:if test="product_code[.='LC' or .='BG' or .='SR' or .='BR' or .='SI']">
	          <xsl:call-template name="input-field">
		     	<xsl:with-param name="label">XSL_DOC_REF_NO</xsl:with-param>
		    	 <xsl:with-param name="name">doc_ref_no</xsl:with-param>
		    	  <xsl:with-param name="disabled">Y</xsl:with-param>
		    	 <xsl:with-param name="size">16</xsl:with-param>
		    	 <xsl:with-param name="maxsize">16</xsl:with-param>
		   	 </xsl:call-template>
	   	 </xsl:if>
        <!-- For LC or SI, the documents amount and maturity date may be used 
             when ACCEPTED, DISCREPANT, PAID AT SIGHT, PARTIALLY PAID AT SIGHT,
             SETTLED or PARTIALLY SETTLED  -->
        <!-- Also added for EL and SR -->
        <xsl:if test="product_code[.='LC' or .='SI' or .='EL' or .='SR' or .='IC' or .='EC']">
        <div id="doc-details">
         <xsl:if test="$displaymode='edit' or ($displaymode='view' and tnx_amt[.!=''] and product_code[.='EL' or .='SR' or .='IC']) or 
         ($displaymode='view' and tnx_amt[.!=''] and product_code[.='LC' or .='SI' or .='EC'] and 
         (prod_stat_code[.='04' or .='12' or .='13' or .='14' or .='15' or .='05' or .='07' or .='A9' or .='26' or .='84' or .='85']))">
          <xsl:call-template name="currency-field">
           <xsl:with-param name="label">XSL_AMOUNTDETAILS_DOCS_AMT_LABEL</xsl:with-param>
           <!-- <xsl:with-param name="name">tnx_amt</xsl:with-param>
           <xsl:with-param name="size">20</xsl:with-param>
           <xsl:with-param name="maxsize">15</xsl:with-param>
           <xsl:with-param name="type">amount</xsl:with-param>
           <xsl:with-param name="fieldsize">small</xsl:with-param>
          </xsl:call-template> -->
          <xsl:with-param name="product-code"><xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
           <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
           <xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param>
            <xsl:with-param name="override-currency-name">
                <xsl:choose>
             <xsl:when test="product_code[.='LC'] or product_code[.='SI'] or product_code[.='EL'] or product_code[.='SR']">lc_cur_code</xsl:when>
               <xsl:otherwise><xsl:value-of select="$lowercase-product-code"/>_cur_code</xsl:otherwise>
            </xsl:choose></xsl:with-param>
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
         <xsl:if test="product_code[.!='PO' and .!='SO' and .!='IN']">
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
           <xsl:with-param name="name">maturity_date</xsl:with-param>
           <xsl:with-param name="size">10</xsl:with-param>
           <xsl:with-param name="maxsize">10</xsl:with-param>
           <xsl:with-param name="type">date</xsl:with-param>
           <xsl:with-param name="fieldsize">small</xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_REPORTINGDETAILS_LATEST_ANSWER_DATE</xsl:with-param>
           <xsl:with-param name="name">latest_answer_date</xsl:with-param>
           <xsl:with-param name="size">10</xsl:with-param>
           <xsl:with-param name="maxsize">10</xsl:with-param>
           <xsl:with-param name="type">date</xsl:with-param>
           <xsl:with-param name="fieldsize">small</xsl:with-param>
          </xsl:call-template>
         </xsl:if>
         </div>
        </xsl:if>
       </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="tnx_type_code[. = '01'] or (product_code[.='PO' or .='IN'] and bo_ref_id[.=''])">
        <xsl:choose>
      	  <xsl:when test="preallocated_flag[.='Y'] and bo_ref_id[.!='']">
      	   <xsl:call-template name="input-field">
	        <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
	        <xsl:with-param name="id">general_bo_ref_id_view</xsl:with-param>
	        <xsl:with-param name="value"><xsl:value-of select="bo_ref_id"/> </xsl:with-param>
	        <xsl:with-param name="override-displaymode">view</xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="hidden-field">
	       	 <xsl:with-param name="id">general_bo_ref_id_view</xsl:with-param>
	         <xsl:with-param name="name">bo_ref_id</xsl:with-param>
	         <xsl:with-param name="value"><xsl:value-of select="bo_ref_id"/></xsl:with-param>
	         <xsl:with-param name="required"><xsl:if test="$mode!='RELEASE'">Y</xsl:if></xsl:with-param>
	       </xsl:call-template>
      	  </xsl:when>
      	  <xsl:otherwise>
      	  <div style="white-space:pre;">
	      	   <xsl:call-template name="input-field">
		        <xsl:with-param name="label"><xsl:choose>
		        <xsl:when test="product_code[.='LN'] and $displaymode='view'">XSL_GENERALDETAILS_BO_OUTSTANDING_ALIAS</xsl:when>
		        <xsl:otherwise>XSL_GENERALDETAILS_BO_REF_ID</xsl:otherwise>
		        </xsl:choose>
		        
		        </xsl:with-param>
		        <xsl:with-param name="name">bo_ref_id</xsl:with-param>
		        <xsl:with-param name="required">N</xsl:with-param>
		        <xsl:with-param name="size">35</xsl:with-param>
		        <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('BO_REFERENCE_LENGTH_PRODUCT')"/></xsl:with-param>
		        <xsl:with-param name="regular-expression">
	 	 	 	 <xsl:value-of select="defaultresource:getResource('BO_REFERENCE_VALIDATION_PRODUCT')"/>
	 	 	 	</xsl:with-param>
		       </xsl:call-template>
	       </div>
      	  </xsl:otherwise>	
      	</xsl:choose>
      </xsl:if>
      <!-- Display the Cover Letter generation choice for a Direct Collection -->
       <xsl:if test="product_code[. = 'EC'] and ec_type_code[.='02']">
        <xsl:call-template name="checkbox-field">
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
       <xsl:if test="$hide-reporting-message-details != 'Y'">
	     <xsl:if test="$displaymode='edit'">
		      <xsl:call-template name="row-wrapper">
		       <xsl:with-param name="id">bo_comment</xsl:with-param>
		       <xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT</xsl:with-param>
		       <xsl:with-param name="type">textarea</xsl:with-param>
		       <xsl:with-param name="content">
		        <xsl:call-template name="textarea-field">
		         <xsl:with-param name="name">bo_comment</xsl:with-param>
		         <xsl:with-param name="rows">13</xsl:with-param>
		         <xsl:with-param name="cols">65</xsl:with-param>
		          <xsl:with-param name="maxlines">250</xsl:with-param>
		         <xsl:with-param name="swift-validate">N</xsl:with-param>
		        </xsl:call-template>
		       </xsl:with-param>
		      </xsl:call-template>
	      </xsl:if>
      </xsl:if>
      <xsl:if test="$displaymode='view' and bo_comment[.!='']">
      <xsl:call-template name="big-textarea-wrapper">
      <xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT_BANK</xsl:with-param>
      <xsl:with-param name="content"><div class="content">
        <xsl:value-of select="bo_comment"/>
      </div></xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <xsl:if test="product_code[.!='FT' and .!='TD' and .!='BK' and .!='SE' and .!='LN'] and not(tnx_type_code[.='01'] and product_code[.='LS'])">
      <xsl:call-template name="select-field">
       <xsl:with-param name="label">XSL_REPORTINGDETAILS_ACTION_REQUIRED</xsl:with-param>
       <xsl:with-param name="name">action_req_code</xsl:with-param>
       <xsl:with-param name="options">
        <xsl:choose>
         <xsl:when test="$displaymode='edit'">
          <option value=""/>
          <option value="99">
           <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CUSTOMER_INSTRUCTIONS')"/>
          </option>
          <xsl:if test="$product-code='LC'">
          <option value="26">          	
           <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CLEAN_RESPONSE')"/>
          </option>
          </xsl:if>
          <option value="07">
           <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CONSENT_RESPONSE')"/>
          </option>
          <option value="03">
           <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_AMENDMENT_RESPONSE')"/>
          </option>
          <option value="05">
           <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CANCEL_RESPONSE')"/>
          </option>
          <!-- The discrepancy response value should be there at the 4th position in the store, as it has a dependecy on the report_si js. If changed, needs to be changed in the js as well. -->
          <xsl:if test="$product-code!='LS'">
          <option value="12">
           <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_DISCREPANCY_RESPONSE')"/>
          </option>
          </xsl:if>
          </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="action_req_code[.='99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CUSTOMER_INSTRUCTIONS')"/></xsl:when>
          <xsl:when test="action_req_code[.='12']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_DISCREPANCY_RESPONSE')"/></xsl:when>
          <xsl:when test="action_req_code[.='26']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CLEAN_RESPONSE')"/></xsl:when>
          <xsl:when test="action_req_code[.='07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CONSENT_RESPONSE')"/></xsl:when>
          <xsl:when test="action_req_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_AMENDMENT_RESPONSE')"/></xsl:when>
          <xsl:when test="action_req_code[.='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CANCEL_RESPONSE')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
      </xsl:if> 
     </xsl:with-param>
    </xsl:call-template>
  
    <!-- Attach charges -->
    <xsl:if test="$hide-charge-details !='Y'">
    <xsl:if test="$displaymode='edit' or ($displaymode='view' and (product_code[.!='LS'] and product_code[.!='TF'] and product_code[.!='FT'] ) and (charges/charge[created_in_session = 'Y']) != 0)">
   	 <xsl:call-template name="attachments-charges"/>
    </xsl:if>
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
        <xsl:with-param name="value">
	       	<xsl:choose>
	       		<xsl:when test="$mode != ''"><xsl:value-of select="$mode"/></xsl:when>
	       		<xsl:otherwise>DRAFT</xsl:otherwise>
	       	</xsl:choose>
       </xsl:with-param>
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
      <xsl:call-template name="e2ee_transaction"/>
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
  <xsl:param name="show-hyperlink">Y</xsl:param>
  <xsl:param name="enable_to_edit_customer_details_bank_side"/>
   
  <xsl:if test="$displaymode='edit' and $show-hyperlink='Y'">
 	
 		<xsl:choose>
 			<xsl:when test="$product-code = 'FT' or $product-code = 'TD' or $product-code = 'BK'">
 				<a id="editTransactionDetails" onclick="misys.toggleTransaction(true);" href="javascript:void(0)" style="display:none"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTIONDETAILS')"/></a>
 			</xsl:when>
 			<xsl:when test="$displaymode='view'">
 	 	        <a id="editTransactionDetails" onclick="misys.toggleTransaction(true);" href="javascript:void(0)" style="display:none"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTIONDETAILS')"/></a>
			</xsl:when>
 			<xsl:otherwise>
 			 <xsl:choose>
 			 <xsl:when test="defaultresource:getResource('ENABLE_TO_EDIT_CUSTOMER_DETAILS_BANK_SIDE')='true'">
 				<a id="editTransactionDetails" onclick="misys.toggleTransaction(true);" href="javascript:void(0)" style="display:none"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_EDIT_TRANSACTION')"/></a>
 			</xsl:when>
			 <xsl:otherwise>
			 <xsl:if test="product_code[.!='FT' and .!='SE' and .!= 'FX' and .!='TD' and .!='XO' and .!='BK' and .!='CN' and .!='FA' and .!='RI']">
			 <a id="hideTransactionDetails" onclick="misys.toggleTransaction(false);" href="javascript:void(0)" style="display:none"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_HIDE_TRANSACTION')"/></a>
			 </xsl:if>
			 </xsl:otherwise>
			 </xsl:choose>
 			</xsl:otherwise>
 		</xsl:choose>
 		
	 	<xsl:choose>
		 	<xsl:when test="defaultresource:getResource('ENABLE_TO_EDIT_CUSTOMER_DETAILS_BANK_SIDE')='true'">
		<a id="hideTransactionDetails" onclick="misys.toggleTransaction(false);" href="javascript:void(0)"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_HIDE_TRANSACTION')"/></a>
		<div class="clear"></div><br/>	
		</xsl:when>
	 	<xsl:otherwise>
		 <xsl:if test="product_code[.!='FT' and .!='SE' and .!= 'FX' and .!='TD' and .!='XO' and .!='BK' and .!='CN' and .!='FA' and .!='RI']">
		 <a id="editTransactionDetails" onclick="misys.toggleTransaction(true,true);" href="javascript:void(0)"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_EDIT_TRANSACTION')"/></a>		   
 		 </xsl:if>
                
		 </xsl:otherwise>
 		</xsl:choose>
   </xsl:if>
   <script>
    dojo.ready(function(){ 
		dojo.mixin(misys._config, {
				enable_to_edit_customer_details_bank_side :'<xsl:value-of select="defaultresource:getResource('ENABLE_TO_EDIT_CUSTOMER_DETAILS_BANK_SIDE')"/>'
		});
	});   
	</script>
                
  </xsl:template>
  
  <!--
   Bank product status codes. 
   -->
  <xsl:template name="bank-prod-stat-codes">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <!-- <option value=""/> -->
     <option value="07">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_07_UPDATED')"/>
     </option>
     <option value="04">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_04_ACCEPTED')"/>
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
	<xsl:template name="prod-stat-codes">
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<option value="07">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_07_UPDATED')"/>
				</option>
				<xsl:if test="$product-code = 'PO'">
					<option value="72">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_72_PO_ESTABLISHED')"/>
					</option>
				</xsl:if>
				<option value="66">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_66_ESTABLISHED')"/>
				</option>
				<option value="32">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_32_AMENDMENT_REFUSED')"/>
				</option>
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
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_12_DISCREPANT')"/>
				</option>
				<xsl:if test="$product-code='LC'">
					<option value="26">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_26_CLEAN')"/>
					</option>
					<option value="A9">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_A9_PRE_ADVISE_BILL')"/>
					</option>
				</xsl:if>
				<option value="14">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_14_PART_SIGHT_PAYMT')"/>
				</option>
				<option value="15">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_15_FULL_SIGHT_PAYMT')"/>
				</option>
				<option value="31">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_31_AMENDMENT_AWAITING_BENEFICIARY_APPROVAL')"/>
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
				<option value="42">
 	 	 	 		<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_42_EXPIRED')"/>
 	 	 	 	</option>
				<!-- 
				<option value="01">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/>
				</option>
				-->
				<xsl:if test="($product-code='BG' or $product-code='SI' or $product-code='LC') and prod_stat_code[.!='78' and .!='79' and .!='98']">
				<option value="84">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_84_CLAIM_PRESENTATION')"/>
				</option>
				</xsl:if>
				<option value="85">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_85_CLAIM_SETTLEMENT')"/>
				</option>
				<xsl:if test="$product-code='BG'">
				<option value="86">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_86_EXTEND_PAY')"/>

				</option>
				</xsl:if>
				<option value="16">
			      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_16_NOTIFICATION_OF_CHARGES')"/>
			    </option>
			    <option value="24">
			      <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_24_REQUEST_FOR_SETTLEMENT')"/>
			    </option>  
				<xsl:if test="($product-code='BG' or $product-code='SI' or $product-code='LC') and prod_stat_code[.='98' or .='78' or .='79']">
		          <option value="78">          	
		           <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_78_WORDING_UNDER_REVIEW')"/>
		          </option>
		          <option value="79">          	
		           <xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_79_FINAL_WORDING')"/>
		          </option>
		        </xsl:if>            
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="prod_stat_code[.='07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_07_UPDATED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_03_NEW')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='32']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_32_AMENDMENT_REFUSED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_08_AMENDED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='09']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_09_EXTENDED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_04_ACCEPTED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_05_SETTLED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='13']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_13_PART_SETTLED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='06']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_06_CANCELLED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='11']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_11_RELEASED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='12']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_12_DISCREPANT')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='14']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_14_PART_SIGHT_PAYMT')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='15']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_15_FULL_SIGHT_PAYMT')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='31']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_31_AMENDMENT_AWAITING_BENEFICIARY_APPROVAL')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='81']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_81_CANCEL_AWAITING_BENEFICIARY_RESPONSE')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='82']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_82_CANCEL_REFUSED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='10']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_10_PURGED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='42']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_42_EXPIRED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='84']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_84_CLAIM_PRESENTATION')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='85']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_85_CLAIM_SETTLEMENT')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='86']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_86_EXTEND_PAY')"/></xsl:when>      
					<xsl:when test="prod_stat_code[.='26']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_26_CLEAN')"/></xsl:when> 
					<xsl:when test="prod_stat_code[.='A9']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_A9_PRE_ADVISE_BILL')"/></xsl:when> 
					<xsl:when test="prod_stat_code[.='78']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_78_WORDING_UNDER_REVIEW')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='79']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_79_FINAL_WORDING')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='16']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_16_NOTIFICATION_OF_CHARGES')"/></xsl:when>
     				<xsl:when test="prod_stat_code[.='24']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_24_REQUEST_FOR_SETTLEMENT')"/></xsl:when>
     				<xsl:when test="prod_stat_code[.='66']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_66_ESTABLISHED')"/></xsl:when>
     				<xsl:when test="prod_stat_code[.='72']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_72_PO_ESTABLISHED')"/></xsl:when>
     				<xsl:when test="prod_stat_code[.='98']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_98_PROVISIONAL')"/></xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!--
	LS Product Status Codes   
	-->
	<xsl:template name="ls-prod-stat-codes">
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<option value="07">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_07_UPDATED')"/>
				</option>
				<option value="08">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_08_AMENDED')"/>
				</option>
				<option value="09">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_09_EXTENDED')"/>
				</option>
				<option value="05">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_05_SETTLED')"/>
				</option>
				<option value="13">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_13_PART_SETTLED')"/>
				</option>
				<option value="80">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_80_RENEWED')"/>
				</option>
				<option value="06">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_06_CANCELLED')"/>
				</option>
				<option value="10">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_10_PURGED')"/>
				</option>
				<option value="42">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_42_EXPIRED')"/>
				</option>
				<xsl:if test="org_prod_stat_code[.!='A3']">
					<option value="A3">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_A3_BOOK_OFF')"/>
					</option>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="prod_stat_code[.='07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_07_UPDATED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_03_NEW')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_08_AMENDED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='09']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_09_EXTENDED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_05_SETTLED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='13']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_13_PART_SETTLED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='80']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_80_RENEWED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='06']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_06_CANCELLED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='10']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_10_PURGED')"/></xsl:when>
     				<xsl:when test="prod_stat_code[.='42']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_42_EXPIRED')"/></xsl:when>
     				<xsl:when test="prod_stat_code[.='A3']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_A3_BOOK_OFF')"/></xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
		<!-- Borrower Details -->
	<xsl:template name="borrower-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="input-field">
		    		<xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
		     		<xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
		     		<xsl:with-param name="override-displaymode">view</xsl:with-param>
		     		<xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
	    		</xsl:call-template>
	   			<xsl:call-template name="input-field">
		    		<xsl:with-param name="name">borrower_reference</xsl:with-param>
		     		<xsl:with-param name="label">XSL_LOAN_BORROWER_REFERENCE</xsl:with-param>
		     		<xsl:with-param name="override-displaymode">view</xsl:with-param>
		     		<xsl:with-param name="value"><xsl:value-of select="utils:decryptApplicantReference(borrower_reference)"/></xsl:with-param>
	    		</xsl:call-template>
	    		<xsl:call-template name="hidden-field">
	    			<xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
	    			<xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
	    		</xsl:call-template>
	    		<xsl:call-template name="hidden-field">
	    			<xsl:with-param name="name">issuing_bank_name</xsl:with-param>
	    			<xsl:with-param name="value"><xsl:value-of select="issuing_bank/name"/></xsl:with-param>
	    		</xsl:call-template>
	    		<xsl:call-template name="hidden-field">
	    			<xsl:with-param name="name">borrower_reference</xsl:with-param>
	    		</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Entity Details -->
	<xsl:template name="entity-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_ENTITY_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
					<script>
						dojo.ready(function(){
							misys._config = misys._config || {};
							misys._config.customerReferences = {};
							<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
						});
					</script>
					<xsl:call-template name="address">
			        <xsl:with-param name="show-entity">Y</xsl:with-param>
					<xsl:with-param name="prefix">borrower</xsl:with-param>
					</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="loan_interest">
<xsl:variable name="interestDetails" select="loanIQ:getInterestDetails(bo_ref_id)"/>	
<xsl:if test="$displaymode = 'view'">
			<xsl:if test="not(tnx_id)">	
				<xsl:if test="$interestDetails[.!= '']">
				 <xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_INTEREST_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">	
						
						<xsl:if test="$interestDetails/interest_cycle_frequency[.!= '']">
							<xsl:call-template name="input-field">
								<xsl:with-param name="name"></xsl:with-param>
								<xsl:with-param name="label">XLS_INTEREST_DETAILS_INTEREST_CYC_FREQUENCY</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="$interestDetails/interest_cycle_frequency" /></xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
						</xsl:if>				
			
						<!-- base_rate -->
 						<xsl:if test="$interestDetails/base_rate[.!= '']">
						<xsl:call-template name="input-field">
			  				<xsl:with-param name="label">XLS_INTEREST_DETAILS_BASE_RATE</xsl:with-param>
			  				<xsl:with-param name="value"><xsl:value-of select="loanIQ:formatRateValues($interestDetails/base_rate,$interestDetails/currency,$language)" />%</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						
						<xsl:if test="$interestDetails/spread[.!= '']">
							<xsl:call-template name="input-field">
				  				<xsl:with-param name="label">XLS_INTEREST_DETAILS_SPREAD</xsl:with-param>
				  				<xsl:with-param name="value"><xsl:value-of select="loanIQ:formatRateValues($interestDetails/spread,$interestDetails/currency,$language)" />%</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						
						<xsl:if test="$interestDetails/rac_rate[.!= '']">
							<xsl:call-template name="input-field">
				  				<xsl:with-param name="label">XLS_INTEREST_DETAILS_RAC_RATE</xsl:with-param>
				  				<xsl:with-param name="value"><xsl:value-of select="loanIQ:formatRateValues($interestDetails/rac_rate,$interestDetails/currency,$language)" />%</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
						</xsl:if>	
			
						<xsl:if test="$interestDetails/all_in_rate[.!= '']">
							<xsl:call-template name="input-field">
				  				<xsl:with-param name="label">XLS_INTEREST_DETAILS_ALL_IN_RATE</xsl:with-param>
				  				<xsl:with-param name="value"><xsl:value-of select="loanIQ:formatRateValues($interestDetails/all_in_rate,$interestDetails/currency,$language)" />%</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
						</xsl:if>	
						<xsl:if test="$interestDetails/projected_interested_due[.!= '']">
										<xsl:call-template name="input-field">
							  				<xsl:with-param name="label">XLS_PROJECTED_INTERESTED_DUE</xsl:with-param>
							  				<xsl:with-param name="value"><xsl:value-of select="$interestDetails/projected_interested_due" /></xsl:with-param>
											<xsl:with-param name="override-displaymode">view</xsl:with-param>
										</xsl:call-template>	
									</xsl:if>		
						
																			
		  									
		
										<xsl:if test="$interestDetails/total_interest_amount[.!= '']">
										<xsl:call-template name="fieldset-wrapper">
											<xsl:with-param name="content">			
					
												<xsl:variable name="arrayList1" select="java:java.util.ArrayList.new()" />
												<xsl:variable name="void" select="java:add($arrayList1, concat('', $interestDetails/today_date))" />
												<xsl:variable name="void" select="java:add($arrayList1, concat('', $interestDetails/currency))" />
												<xsl:variable name="void" select="java:add($arrayList1, concat('', loanIQ:getFormatedAmount($interestDetails/total_interest_amount,$interestDetails/currency,$language)))" />
												<xsl:variable name="args1" select="java:toArray($arrayList1)" />
					
												<xsl:value-of
													select="localization:getFormattedString($language, 'LOAN_DETAILS_INTEREST_DUE', $args1)"
													disable-output-escaping="yes" />
					
												<xsl:call-template name="input-field">
													<xsl:with-param name="name">
														total_interest_Due_Amt
													</xsl:with-param>
													<xsl:with-param name="override-displaymode">
														view
													</xsl:with-param>
												</xsl:call-template>
					
											</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
						
								
					</xsl:with-param>
				</xsl:call-template>
				
			</xsl:if>			
<!-- 							<xsl:if test="not(tnx_id)"> -->
								<xsl:call-template name="loanInterestCycle-details" />
<!-- 							</xsl:if> -->
						</xsl:if>
			</xsl:if>
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XLS_INTEREST_DETAILS_ALL_IN_RATE</xsl:with-param>
				<xsl:with-param name="name">interest_rateType</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>    
</xsl:template>

<xsl:template name="loanInterestCycle-details">

		<div class="loanInterestDetails">
			<!-- Header with toggle link -->
			<div class="wipeInOutTabHeader">
				<div id="actionDown" onclick="misys.toggleLoanInterestDetails()" style="cursor: pointer; display: block;">
				    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_INTEREST_CYCLE_DETAILS')"/>
				    <span class="collapsingImgSpan">
				        <img>
				        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
				        </img>
				    </span>
				</div>
				<div id="actionUp" onclick="misys.toggleLoanInterestDetails()" style="display: none; cursor: pointer;">
				    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_INTEREST_CYCLE_DETAILS')"/>
				    <span class="collapsingImgSpan">
				        <img>
				        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionUpImage)"/></xsl:attribute>
				        </img>
				    </span>
				</div>
			</div>
			<div id="loanInterestDetailsContainer" >
				<div class="clear multigrid">

					<script type="text/javascript">
						var interestDetailsGridLayout, pluginsData;
						dojo.ready(function(){
					    	interestDetailsGridLayout = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_INTEREST_CYCLE_NO')"/>", "field": "interest_cycle", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_START_DATE')"/>", "field": "start_date", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_END_DATE')"/>", "field": "end_date", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_DUE_DATE')"/>", "field": "adjusted_due_date", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_PRJ_CYC_DUE')"/>", "field": "projected_cycleDue_amt", "width": "15%", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_ACCURED_TO_DATE')"/>", "field": "accrued_toDate_amt", "width": "15%", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_PAID_TO_DATE')"/>", "field": "paid_toDate_amt", "width": "10%", "styles":"white-space:nowrap;text-align: right;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LN_BILLED_INTEREST')"/>", "field": "billed_interest_amt", "width": "10%", "styles":"text-align: right;white-space:nowrap;", "headerStyles":"white-space:nowrap;"}
					                   ]
					                  					                   
					              ]};
							pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
		
					<div style="width:100%;height:100%;" class="widgetContainer clear">
						<div dojoType="dojox.data.QueryReadStore" jsId="storeInterestDetails" requestMethod="post">
							<xsl:attribute name="url">								
									
										<xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/AjaxScreen/action/GetJSONData?listdef=loan/listdef/customer/LN/inquiryLNInterestCycleInfo.xml&amp;borefid=<xsl:value-of select='bo_ref_id'/>
									
								
							</xsl:attribute>
						</div>
					    <table rowsPerPage="50" 
							plugins="pluginsData" 
							store="storeInterestDetails" structure="interestDetailsGridLayout" class="grid" 
							autoHeight="true" id="gridLoanInterestDetails" dojoType="dojox.grid.EnhancedGrid" 
							noDataMessage="{localization:getGTPString($language, 'TABLE_NO_DATA')}" selectionMode="none" selectable="true" 
							escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
							<thead>
								<tr></tr>
							</thead>
							<tfoot>
								<tr><td></td></tr>
							</tfoot>
							<tbody>
								<tr><td></td></tr>
							</tbody>
						</table>

<!-- 						<div class="clear" style="height:1px">&nbsp;</div> -->
					</div>
				
				
				
				
<!-- 		</xsl:with-param> -->
<!-- 	</xsl:call-template> -->
	</div></div></div>
</xsl:template>
</xsl:stylesheet>