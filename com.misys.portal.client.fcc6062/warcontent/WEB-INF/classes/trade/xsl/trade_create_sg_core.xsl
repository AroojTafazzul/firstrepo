<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Shipping Guarantee (SG) Form, Customer Side.

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
        xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"                
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"		   
	    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="xmlRender localization securitycheck utils security defaultresource">
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">SG</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/ShippingGuaranteeScreen</xsl:param>
  <xsl:param name="option"></xsl:param>
  <xsl:param name="operation"></xsl:param>

  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>

  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl"/>
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes"/>
  <xsl:template match="/">
    <xsl:apply-templates select="sg_tnx_record"/>
  </xsl:template>
  
  <!-- 
   SG TNX FORM TEMPLATE.
  -->
  <xsl:template match="sg_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <!--  Display common menu. -->
      <xsl:call-template name="menu">
       <xsl:with-param name="show-template">N</xsl:with-param>
       <xsl:with-param name="show-return">Y</xsl:with-param>
      </xsl:call-template>
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>     
	  <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details"/>
      <xsl:if test="$displaymode='edit' or ($displaymode='view' and  sg_amt != '')">
      <xsl:call-template name="basic-amt-details">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_GTEE_AMT_LABEL</xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      <xsl:call-template name="sg-guarantee-details"/>
      <xsl:call-template name="description-goods"/>
      

      <xsl:call-template name="bank-instructions">
       <xsl:with-param name="send-mode-displayed">N</xsl:with-param>
      </xsl:call-template>
      
	  <!-- Reauthentication -->
	  <xsl:call-template name="reauthentication"/>
	   <!-- comments for return -->
	   <xsl:if test="tnx_stat_code[.!='03' and .!='04']">   <!-- MPS-43899 -->
      <xsl:call-template name="comments-for-return">
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
   	  </xsl:if>
     </xsl:with-param>
    </xsl:call-template>

    <!-- Form #1 : Attach Files -->
     <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED') or ($displaymode != 'edit' and $mode = 'VIEW')">
    	<xsl:call-template name="attachments-file-dojo"/>
    </xsl:if>

    <xsl:call-template name="realform"/>

    <xsl:call-template name="menu">
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="show-return">Y</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
    </xsl:call-template>
   </div>

   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>
   
   <!--  Collaboration Window -->     
   <xsl:call-template name="collaboration">
    <xsl:with-param name="editable">true</xsl:with-param>
    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
   </xsl:call-template>
 
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
    <xsl:with-param name="binding">misys.binding.trade.create_sg</xsl:with-param>
    <xsl:with-param name="override-help-access-key">SG_01</xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="show-type">N</xsl:with-param>
   </xsl:call-template>
   <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">option</xsl:with-param>
      <xsl:with-param name="value" select="$option"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">operation</xsl:with-param>
      <xsl:with-param name="value" select="$operation"/>
     </xsl:call-template>
     </div>
  </xsl:template>
 
  <!--
   SG General Details Fieldset.
    
   Common General Details, Applicant Details, Beneficiary Details.
  -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <!-- Common general details. -->
     <xsl:call-template name="common-general-details">
      <xsl:with-param name="show-template-id">N</xsl:with-param>
     </xsl:call-template>
      
	<!-- Initiation From -->
	<xsl:choose>
		<xsl:when test="cross_references/cross_reference/type_code[.='02']">
			<xsl:variable name="parent_file" select="xmlRender:getXMLMasterNode(cross_references/cross_reference[./type_code='02']/product_code, cross_references/cross_reference[./type_code='02']/ref_id, $language)"/>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
				<xsl:with-param name="id">parent_file_bo_ref_id_view</xsl:with-param>
				<xsl:with-param name="value" select="$parent_file/bo_ref_id" />
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bo_lc_ref_id</xsl:with-param>
				<xsl:with-param name="value" select="$parent_file/bo_ref_id"/>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">lc_ref_id</xsl:with-param>
				<xsl:with-param name="value" select="$parent_file/ref_id"/>
		 	</xsl:call-template>
		 	<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">parent_lc_cur_code</xsl:with-param>
				<xsl:with-param name="value" select="$parent_file/lc_cur_code"/>
		 	</xsl:call-template>	 
		 	<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">parent_lc_liab_amt</xsl:with-param>
				<xsl:with-param name="value" select="$parent_file/lc_liab_amt"/>
		 	</xsl:call-template>	 
		</xsl:when>
		<xsl:when test="bo_lc_ref_id != ''">
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
				<xsl:with-param name="id">bo_lc_ref_id_view</xsl:with-param>
				<xsl:with-param name="value" select="bo_lc_ref_id" />
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bo_lc_ref_id</xsl:with-param>
				<xsl:with-param name="value" select="bo_lc_ref_id"/>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
      
     <!-- Hidden Fields -->
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">iss_date</xsl:with-param>
     </xsl:call-template>
     
      <!-- Issue Date -->
   <!-- Displayed in consolidated view -->
   <xsl:if test="$displaymode='view' and (not(tnx_id) or tnx_type_code[.!='01'])">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
     <xsl:with-param name="name">iss_date</xsl:with-param>
    </xsl:call-template>
   </xsl:if>
      
     <!--  Expiry Date. --> 
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="name">exp_date</xsl:with-param>
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

     <!-- Applicant Details -->
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="address">
        <xsl:with-param name="show-entity">Y</xsl:with-param>
        <xsl:with-param name="show-address">Y</xsl:with-param>
        <xsl:with-param name="prefix">applicant</xsl:with-param>
       </xsl:call-template>
        
       <!--
        If we have to, we show the reference field for applicants. This is
        specific to this form.
        -->
       <!-- <xsl:if test="not(avail_main_banks/bank/entity/customer_reference) and not(avail_main_banks/bank/customer_reference)">
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
         <xsl:with-param name="name">applicant_reference</xsl:with-param>
         <xsl:with-param name="value">
         <xsl:variable name="ref"><xsl:value-of select="applicant_reference"/></xsl:variable>
         <xsl:value-of select="utils:decryptApplicantReference($ref)"/>
         </xsl:with-param>
         <xsl:with-param name="maxsize">34</xsl:with-param>
        </xsl:call-template>
       </xsl:if> -->
      </xsl:with-param>
     </xsl:call-template>
     
     <!-- Beneficiary Details -->
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_HEADER_SG_BENEFICIARY_DETAILS</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <!-- <xsl:with-param name="button-type">beneficiary</xsl:with-param> -->
      <xsl:with-param name="content">
       <xsl:if test="$displaymode='edit'">
        <script>
        	dojo.ready(function(){
        		misys._config = misys._config || {};
				misys._config.customerReferences = {};
				<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
			});
		</script>
       </xsl:if>
      
       <xsl:call-template name="address">
        <xsl:with-param name="show-reference">Y</xsl:with-param>
        <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
        <xsl:with-param name="prefix">beneficiary</xsl:with-param>
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
     <!-- Bank Name -->
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ISSUING_BANK</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:if test="$displaymode='edit'">
        <script>
        	dojo.ready(function(){
        		misys._config = misys._config || {};
				misys._config.customerReferences = {};
				<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
			});
		</script>
       </xsl:if>
       <xsl:call-template name="main-bank-selectbox">
        <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
        <xsl:with-param name="sender-name">applicant</xsl:with-param>
        <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="customer-reference-selectbox">
        <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
        <xsl:with-param name="sender-name">applicant</xsl:with-param>
        <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template> 

  <!-- Description of Goods -->
  <xsl:template name="description-goods">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_DESCRIPTION_GOODS</xsl:with-param>  
	     <xsl:with-param name="content">
	     <xsl:call-template name="row-wrapper">
	      <xsl:with-param name="id">goods_desc</xsl:with-param>
	       <xsl:with-param name="label">XSL_LABEL_DESCRIPTION_GOODS</xsl:with-param>
	        <xsl:with-param name="required">Y</xsl:with-param>
	      <xsl:with-param name="type">textarea</xsl:with-param>
	      <xsl:with-param name="content">
	       <xsl:call-template name="textarea-field">
	        <xsl:with-param name="name">goods_desc</xsl:with-param>
	        <xsl:with-param name="rows">12</xsl:with-param>
		<xsl:with-param name="cols">64</xsl:with-param>
	        <xsl:with-param name="maxlines">100</xsl:with-param>
	        <xsl:with-param name="maxlength"></xsl:with-param>
	        <xsl:with-param name="maxlength"><xsl:value-of select="defaultresource:getResource('TRADE_GOODS_DESCRIPTION_FIELD_LENGTH')"/></xsl:with-param>
	        <xsl:with-param name="required">Y</xsl:with-param>
	       </xsl:call-template>
	      </xsl:with-param>
	     </xsl:call-template>
	    </xsl:with-param>
	   </xsl:call-template>
	  </xsl:template>

  <!--
   Hidden fields for Letter of Credit 
   -->
  <xsl:template name="realform">
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="method">POST</xsl:with-param>
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
      <xsl:with-param name="name">tnxtype</xsl:with-param>
      <xsl:with-param name="value">01</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">attIds</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">TransactionData</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template>
     <!-- Create SG from Existing LC initiate and in save draft check for cross references product code to be LC or SI and make the variable isfromExistingLC ='Y' to differenciate from Existing LC and copy from SG  -->
     <xsl:if test="((tnx_type_code = '01' and $option = 'EXISTING' and $operation != 'DISPLAY_LIST') or (cross_references/cross_reference/product_code[.='LC' or .='SI']))">
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">isfromExistingLC</xsl:with-param>
			<xsl:with-param name="value">Y</xsl:with-param>
	</xsl:call-template>
						</xsl:if>
     <xsl:call-template name="e2ee_transaction"/>
     <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>