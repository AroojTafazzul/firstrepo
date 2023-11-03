<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 New Letter Of Credit (LC) Free Format, Customer Side.
 
 Note: Templates beginning with lc- are in lc_common.xsl

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      03/02/2015
email:     shrashank.gupta@misys.com
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
		exclude-result-prefixes="xmlRender localization securitycheck utils security">
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <!-- Columns definition import -->
  <xsl:import href="../../core/xsl/report/report.xsl"/>
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">LC</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/LetterOfCreditScreen</xsl:param>

  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
   <xsl:include href="../../core/xsl/common/lc_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="lc_tnx_record"/>
  </xsl:template>
  
  <!-- 
   SI FREEFORMAT TNX FORM TEMPLATE.
  -->
  <xsl:template match="lc_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
  
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <!--  Display common menu. -->
     <xsl:call-template name="menu">
     	<xsl:with-param name="show-return">Y</xsl:with-param>
     </xsl:call-template>
      
      
      <!-- Disclaimer Notice -->
     <xsl:call-template name="disclaimer"/>
     
     <xsl:call-template name="hidden-fields"/>
     <xsl:call-template name="general-details" />
      <xsl:call-template name="basic-amt-details-with-variation">
     <xsl:with-param name="override-product-code">lc</xsl:with-param>
    </xsl:call-template>
      <xsl:call-template name="lc-bank-details" />
     <xsl:call-template name="letterofcredit-narrative"/>
      <!-- Bank Instructions -->
      <xsl:call-template name="bank-instructions">
      	<xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
      </xsl:call-template>
     <!-- comments for return -->
     <xsl:if test="tnx_stat_code[.!='03' and .!='04']">   <!-- MPS-43899 -->
     <xsl:call-template name="comments-for-return">
	 	<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	 	<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	 </xsl:call-template>
   	 </xsl:if>
     </xsl:with-param>
    </xsl:call-template>

    <!-- Attachment files -->
    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
    	<xsl:call-template name="attachments-file-dojo"/>
    </xsl:if>

    <!-- Realform -->
    <xsl:call-template name="realform"/>
    
    <xsl:call-template name="reauthentication"/> 


    
    <xsl:call-template name="menu">
    	<xsl:with-param name="second-menu">Y</xsl:with-param>
    	<xsl:with-param name="show-return">Y</xsl:with-param>
    </xsl:call-template>
   </div>
   
	<!-- Template to initialize the product and category map data for dynamic phrase. -->
	<xsl:call-template name="populate-phrase-data"/>
	<script>
		<!-- Instantiate columns arrays -->
		<xsl:call-template name="product-arraylist-initialisation"/>
		
		<!-- Add columns definitions -->
		<xsl:call-template name="Columns_Definitions"/>
		
		<!-- Include some eventual additional columns -->
		<xsl:call-template name="report_addons"/>
	</script>
	<!-- Retrieve the javascript products' columns and candidate for every product authorised for the current user -->
	<xsl:call-template name="Products_Columns_Candidates"/>
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
	    <xsl:with-param name="binding">misys.binding.trade.freeformat_lc</xsl:with-param>
	    <xsl:with-param name="show-collaboration-js">N</xsl:with-param>
	    <xsl:with-param name="override-help-access-key">LC_02</xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <xsl:call-template name="common-hidden-fields">
   		<xsl:with-param name="override-product-code">lc</xsl:with-param>
   </xsl:call-template>
   <div class="widgetContainer">
	    <xsl:call-template name="hidden-field">
		     <xsl:with-param name="name">stnd_by_lc_flag</xsl:with-param>
		   </xsl:call-template>
	    <xsl:call-template name="hidden-field">
	    	 <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
	    </xsl:call-template>
	    <xsl:call-template name="hidden-field">
			<xsl:with-param name="name">product_code</xsl:with-param>				
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">sub_product_code</xsl:with-param>				
	</xsl:call-template>
   </div>
  </xsl:template>

  <!--
    SI General Details Fieldset.
    
    Common General Details, Applicant Details, Beneficiary Details.
  -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <div id="generaldetails">

      <!-- Common general details. -->
      <xsl:call-template name="common-general-details"/>
      
      <!-- Hidden Fields -->
      <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">iss_date</xsl:with-param>
      </xsl:call-template>
      
      <!--  Expiry Date. --> 
      <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
        <xsl:with-param name="name">exp_date</xsl:with-param>
        <xsl:with-param name="size">10</xsl:with-param>
        <xsl:with-param name="maxsize">10</xsl:with-param>
        <xsl:with-param name="type">date</xsl:with-param>
        <xsl:with-param name="fieldsize">small</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
      </xsl:call-template>
      
      <!-- Expiry place. -->
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:with-param>
       <xsl:with-param name="name">expiry_place</xsl:with-param>
       <xsl:with-param name="maxsize">29</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
      </xsl:call-template>
      
     <!-- Applicant details -->     
      <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
	    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	    <xsl:with-param name="content">
	     <xsl:call-template name="address">
	      <xsl:with-param name="show-entity">Y</xsl:with-param>
	      <xsl:with-param name="prefix">applicant</xsl:with-param>
	     </xsl:call-template>
	      <xsl:if test="applicant_reference[.!=''] and $displaymode='view' and product_code [.='LC']">
	      <xsl:variable name="ref"><xsl:value-of select="applicant_reference"/></xsl:variable>
	      <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
           <xsl:with-param name="name">applicant_reference</xsl:with-param>
           <xsl:with-param name="value">
	            <xsl:value-of select="utils:decryptApplicantReference($ref)"/>
	       </xsl:with-param>
           <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('APPLICANT_REFERENCE_LENGTH')"/></xsl:with-param>
		 </xsl:call-template>
          </xsl:if>    
	<xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_ALTERNATE_PARTY_DETAILS</xsl:with-param>
    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
    <xsl:with-param name="content">
    <xsl:if test="$displaymode = 'edit'">
    <xsl:call-template name="checkbox-field">
     <xsl:with-param name="label">XSL_FOR_THE_ACCOUNT_OF</xsl:with-param>
     <xsl:with-param name="name">for_account_flag</xsl:with-param>
    </xsl:call-template>
    </xsl:if>
    <xsl:choose>
	      <xsl:when test="$displaymode = 'view' and for_account_flag = 'Y'">
	      	<xsl:call-template name="lc-alternative-applicant-details" />
	      </xsl:when>
	      <xsl:when test="$displaymode = 'edit'">
		      <div id="alternate-party-details" style="display:none;">
		      	<xsl:call-template name="lc-alternative-applicant-details" />
		      </div>
	      </xsl:when>
      </xsl:choose>
	  </xsl:with-param>
	  </xsl:call-template>
	     </xsl:with-param>
     </xsl:call-template>
     
      <!-- Beneficiary Details -->
   <!-- Hide it from LC Upload -->
   <xsl:if test="lc_type[.!='04'] or tnx_type_code[.!='01']">
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
   </xsl:if>
   <!-- issuing bank -->
   <xsl:if test="$displaymode = 'view' and $product-code='LC'">
    <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_BANKDETAILS_TAB_ISSUING_BANK</xsl:with-param>
       <xsl:with-param name="legend-type">indented-header</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:apply-templates select="issuing_bank">
         <xsl:with-param name="theNodeName">issuing_bank</xsl:with-param>
         <xsl:with-param name="show-button">Y</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
        </xsl:apply-templates>
       </xsl:with-param>
      </xsl:call-template>
   </xsl:if>
     
    </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
   <xsl:template name="lc_freeformat_bank_details">
   <xsl:if test="$displaymode='edit'">
      <script>
      		dojo.ready(function(){
      			misys._config = misys._config || {};
				misys._config.customerReferences = {};
				<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
			});
	 </script>
     </xsl:if>
     <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
	    <xsl:with-param name="content">
	    <div id="bankdetails">
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
	     </div>
     </xsl:with-param>
     </xsl:call-template>
     </xsl:template>
  <!-- 
   Letter of credit Narrative Fieldset
   -->
  <xsl:template name="letterofcredit-narrative">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
    <div id="letterofcredit-narrative">
     <xsl:call-template name="big-textarea-wrapper">
      <xsl:with-param name="id">narrative_full_details</xsl:with-param>
      <xsl:with-param name="label">XSL_LABEL_NARRATIVE_DETAILS</xsl:with-param>
	  <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">narrative_full_details</xsl:with-param>
        <xsl:with-param name="rows">16</xsl:with-param>
		<xsl:with-param name="cols">69</xsl:with-param>
		<xsl:with-param name="maxlines">425</xsl:with-param>
		<xsl:with-param name="required">Y</xsl:with-param>
		<xsl:with-param name="word-wrap">Y</xsl:with-param>
		<xsl:with-param name="swift-validate">N</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
     </div>
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
     	<xsl:call-template name="reauth_params"/>    
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  
</xsl:stylesheet>