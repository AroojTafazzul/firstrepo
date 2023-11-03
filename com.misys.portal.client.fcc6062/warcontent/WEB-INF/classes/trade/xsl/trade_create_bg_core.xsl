<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 New Banker's Guarantee (BG) Form, Customer Side

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
		xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
	    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="xmlRender localization securitycheck defaultresource utils security">
      
  <!-- Columns definition import -->
  <xsl:import href="../../core/xsl/report/report.xsl"/>
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  <xsl:include href="./common/bg_common.xsl" />
  <xsl:include href="../../core/xsl/common/ls_common.xsl" />
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">BG</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/BankerGuaranteeScreen</xsl:param>
  <xsl:param name="option"></xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/static_document_upload_templates.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl"/>
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="bg_tnx_record"/>
  </xsl:template>
  
  <!-- 
   BG TNX FORM TEMPLATE.
  -->
  <xsl:template match="bg_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>

   <xsl:call-template name="static-document-dialog"/>
  
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->
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
     
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details"/>
      
      <xsl:call-template name="bg-amt-details">
       <xsl:with-param name="override-product-code">bg</xsl:with-param>
      </xsl:call-template>
      
      <xsl:choose>
      	<xsl:when test = "$displaymode='edit'">
      		<xsl:call-template name="bg-renewal-details"/> 
      	</xsl:when>
      	<xsl:otherwise>
      		<xsl:if test="renew_flag[.='Y']">
      			<xsl:call-template name="bg-renewal-details"/>
      		</xsl:if>
      	</xsl:otherwise>
      </xsl:choose>
      
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:if test="$displaymode='edit'">
         <script>
         	dojo.ready(function(){
         		misys._config = misys._config || {};
				misys._config.customerReferences = {};
				<xsl:apply-templates select="avail_main_banks/bank" mode="entityBankMap"/>
				misys._config.customerBanksMT798Channel = {};
				<xsl:apply-templates select="avail_main_banks/bank" mode="customer_banks_communication_channel"/>
				misys._config.leadBankAccess = {};
				<xsl:apply-templates select="avail_main_banks/bank" mode="lead_bank"/>
				misys._config.provisionalProductTypes = {};
				<xsl:apply-templates select="provisional_flag/provisional" />
			});
		</script>
        </xsl:if>
        <div id="lead-bank-check-box">
	        <xsl:if test="not(security:isBank($rundata)) and securitycheck:hasPermission($rundata,'bg_lead_bank_access') = 'true'">
	        	<xsl:choose>
		          	<xsl:when test="$displaymode='view'">
			         	 <xsl:choose>
			          		<xsl:when test="lead_bank_flag = 'Y'">
			          			<xsl:call-template name="input-field">
			          				<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_LEAD_BANK')"/>
			          			</xsl:call-template>
			           		</xsl:when>
			         	</xsl:choose>
		          	</xsl:when>
		          	<xsl:otherwise>
		          		<xsl:call-template name="checkbox-field">
				           <xsl:with-param name="label">XSL_LEAD_BANK</xsl:with-param>
				           <xsl:with-param name="name">lead_bank_flag</xsl:with-param>
		          		</xsl:call-template>
		          	</xsl:otherwise>
          		</xsl:choose>
			</xsl:if>
		</div>
	    <xsl:call-template name="main-bank-selectbox">
         <xsl:with-param name="label">
          <xsl:choose>
           <xsl:when test="lead_bank_flag[.='Y']">XSL_LEAD_BANK_NAME</xsl:when>
		   <xsl:when test="issuing_bank_type_code[.='02'] or (not(security:isBank($rundata)))">XSL_TRANSACTIONDETAILS_RECIPIENT_BANK</xsl:when>
		   <xsl:otherwise>XSL_BANKDETAILS_TAB_RECIPIENT_ISSUING_BANK</xsl:otherwise>
		  </xsl:choose>
         </xsl:with-param>
         <xsl:with-param name="main-bank-name">recipient_bank</xsl:with-param>
         <xsl:with-param name="sender-name">applicant</xsl:with-param>
         <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="customer-reference-selectbox">
         <xsl:with-param name="main-bank-name">recipient_bank</xsl:with-param>
         <xsl:with-param name="sender-name">applicant</xsl:with-param>
         <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
        </xsl:call-template>
        
	    <!-- 
	      Tabgroup : Bank Details (3 Tabs)
	      Tab0 - Issuing Bank
	      Tab1 - Advising Bank
	      Tab3 - Confirming Bank
	    -->
	    <xsl:choose>
     	  <xsl:when test="issuing_bank_type_code[.='02'] or (not(security:isBank($rundata)))">
     	   <xsl:call-template name="tabgroup-wrapper">
     	     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	         <!-- Tab 0_0 - Issuing Bank  -->
	         <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_LOCAL_GUARANTOR</xsl:with-param>
	         <xsl:with-param name="tab0-content"> 
	          <xsl:call-template name="select-field">
	           <xsl:with-param name="label">XSL_ISSUING_INSTRUCTIONS_LABEL</xsl:with-param>
	           <xsl:with-param name="name">issuing_bank_type_code</xsl:with-param>
	           <xsl:with-param name="required">Y</xsl:with-param>
	           <xsl:with-param name="options">
	            <xsl:call-template name="bg-bankdetails-types"/>
	           </xsl:with-param>
	          </xsl:call-template>
	          <xsl:apply-templates select="issuing_bank">
	           <xsl:with-param name="theNodeName">issuing_bank</xsl:with-param>
	           <xsl:with-param name="required">Y</xsl:with-param>
              </xsl:apply-templates>
	        </xsl:with-param>
    
	        <!-- Tab 0_1 - Advising Bank  -->
	        <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_ADVISING_BANK</xsl:with-param>
	        <xsl:with-param name="tab1-content">
	        <xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and advising_bank/name[.!=''])">
	         <xsl:apply-templates select="advising_bank">
	          <xsl:with-param name="theNodeName">advising_bank</xsl:with-param>
	         </xsl:apply-templates>
	         </xsl:if>
	         <xsl:call-template name="checkbox-field">
		      <xsl:with-param name="label">XSL_ADVISING_BANK_CONFIRMATION_REQUIRED</xsl:with-param>
		      <xsl:with-param name="name">adv_bank_conf_req</xsl:with-param>
		     </xsl:call-template>
	        </xsl:with-param>
    
	        <!-- Tab 0_2 - Confirming Bank  -->
	        <xsl:with-param name="tab2-label">XSL_BANKDETAILS_TAB_CONFIRMING_BANK</xsl:with-param>
	        <xsl:with-param name="tab2-content">
	         <xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and confirming_bank/name[.!=''])">
	         <xsl:apply-templates select="confirming_bank">
	          <xsl:with-param name="theNodeName">confirming_bank</xsl:with-param>
	         </xsl:apply-templates>
	         </xsl:if>
	        </xsl:with-param>
	        
	        <!-- Tab 0_3 - Processing Bank  -->
	        <xsl:with-param name="tab3-label">XSL_BANKDETAILS_TAB_PROCESSING_BANK</xsl:with-param>
	        <xsl:with-param name="tab3-content">
	         <xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and processing_bank/name[.!=''])">
	         <xsl:apply-templates select="processing_bank">
	          <xsl:with-param name="theNodeName">processing_bank</xsl:with-param>
	          <xsl:with-param name="required">Y</xsl:with-param>
	         </xsl:apply-templates>
	         </xsl:if>
	        </xsl:with-param>
	       </xsl:call-template>  
     	  </xsl:when>
     	  <xsl:otherwise>
     	   <xsl:call-template name="tabgroup-wrapper">
	        <!-- Tab 0_1 - Advising Bank  -->
	        <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_ADVISING_BANK</xsl:with-param>
	        <xsl:with-param name="tab0-content">
	         <xsl:apply-templates select="advising_bank">
	          <xsl:with-param name="theNodeName">advising_bank</xsl:with-param>
	         </xsl:apply-templates>
	         <xsl:call-template name="checkbox-field">
		      <xsl:with-param name="label">XSL_ADVISING_BANK_CONFIRMATION_REQUIRED</xsl:with-param>
		      <xsl:with-param name="name">adv_bank_conf_req</xsl:with-param>
		     </xsl:call-template>
	        </xsl:with-param>
    
	        <!-- Tab 0_2 - Confirming Bank  -->
	        <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_CONFIRMING_BANK</xsl:with-param>
	        <xsl:with-param name="tab1-content">
	         <xsl:apply-templates select="confirming_bank">
	          <xsl:with-param name="theNodeName">confirming_bank</xsl:with-param>
	         </xsl:apply-templates>
	        </xsl:with-param>
	       </xsl:call-template>  
     	  </xsl:otherwise>
     	 </xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
     
      <!-- Bank Instructions -->
      <xsl:call-template name="bg-guarantee-details">
      	 <xsl:with-param name="pdfOption">
          <xsl:choose>
		   <xsl:when test="security:isBank($rundata)">PDF_BG_DOCUMENT_DETAILS_BANK</xsl:when>
		   <xsl:otherwise>PDF_BG_DOCUMENT_DETAILS</xsl:otherwise>
		  </xsl:choose>
         </xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="bg-contract-details">
      </xsl:call-template>
      
       <xsl:choose>
	      <xsl:when test="$displaymode = 'view'">
	      	<xsl:choose>
	      	<xsl:when test="$mode = 'UNSIGNED' and //limit_details/limit_reference[.!=''] ">
			   	  	<xsl:call-template name="facility-limit-section">
			   	  	<xsl:with-param name="isPreview">Y</xsl:with-param>
			   	  	</xsl:call-template>
		  	 </xsl:when>
		  	 <xsl:otherwise>
		  	 	<xsl:if test="//limit_details/limit_reference[.!='']">
		  	 	<xsl:call-template name="facility-limit-section">
			   	  	<xsl:with-param name="isPreview">Y</xsl:with-param>
			   	  	<xsl:with-param name="displayAmount">N</xsl:with-param>
			   	  	</xsl:call-template>
			   	 </xsl:if>
		  	 </xsl:otherwise>
		  	 </xsl:choose>
	      </xsl:when>
	      <xsl:otherwise>
		      <xsl:if test="//hasFacilities[.='Y']">
		       <xsl:call-template name="build-facility-data"/> 
			     <div id = "facilityLimitDetail">
			   	  	<xsl:call-template name="facility-limit-section"/>
		   		 </div>
		  	 </xsl:if>
	   	 </xsl:otherwise>
   	 </xsl:choose>
   	 
 	 <xsl:if test="securitycheck:hasPermission($rundata,'ls_access') = 'true' and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true'">
			<xsl:call-template name="linked-ls-declaration"/>
	 		<xsl:call-template name="linked-licenses"/>
	 	</xsl:if>
 		
      <xsl:call-template name="bank-instructions">
      	<xsl:with-param name="send-mode-displayed">Y</xsl:with-param>
		<xsl:with-param name="send-mode-required">Y</xsl:with-param>
		<xsl:with-param name="send-mode-label">XSL_GUARANTEE_DELIVERY_MODE</xsl:with-param>
        <xsl:with-param name="delivery-to-shown">Y</xsl:with-param>
        <xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
      </xsl:call-template>
      <!-- comments for return -->
      <xsl:if test="tnx_stat_code[.!='03' and .!='04']"> 
      <xsl:call-template name="comments-for-return">
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
   	  </xsl:if>
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="form-wrapper">
			<xsl:with-param name="name">downloadgteetext</xsl:with-param>
			<xsl:with-param name="parseFormOnLoad">Y</xsl:with-param>
			<xsl:with-param name="enctype">multipart/form-data</xsl:with-param>
			<xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/GuaranteeTextPopup</xsl:with-param>
			<xsl:with-param name="override-displaymode">edit</xsl:with-param>
			<xsl:with-param name="content">
				<div class="widgetContainer">
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">transactiondata</xsl:with-param>
					<xsl:with-param name="id">transactiondata_download_project</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">featureid</xsl:with-param>
					<xsl:with-param name="id">featureid_download_project</xsl:with-param>
					<xsl:with-param name="value">PROJET</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">gteeName</xsl:with-param>
					<xsl:with-param name="id">gteeName_download_project</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">company</xsl:with-param>
					<xsl:with-param name="id">company_download_project</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">bank</xsl:with-param>
					<xsl:with-param name="id">bank_download_project</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">entity</xsl:with-param>
					<xsl:with-param name="id">entity_download_project</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">parentEntity</xsl:with-param>
					<xsl:with-param name="id">parentEntity_download_project</xsl:with-param>
				</xsl:call-template>
				</div>
			</xsl:with-param>
			
	</xsl:call-template>
    <!-- Reauthentication -->
      <xsl:call-template name="reauthentication"/>
    
    <!-- Attach files. -->  
     
    <xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and $mode = 'UNSIGNED') or ($displaymode = 'view' and $mode = 'VIEW')">
    	<xsl:call-template name="attachments-file-dojo">
    		<xsl:with-param name="callback">misys.toggleFields(misys._config.customerBanksMT798Channel[dijit.byId("recipient_bank_abbv_name").get("value")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01', null, ["delivery_channel"], false, false)</xsl:with-param>
    		<xsl:with-param name="title-size">35</xsl:with-param>
    	</xsl:call-template>
    </xsl:if>

   <!-- Realform -->
   <xsl:call-template name="realform"/>
   
   <xsl:call-template name="menu">
     <xsl:with-param name="second-menu">Y</xsl:with-param>
     <xsl:with-param name="show-return">Y</xsl:with-param>
    </xsl:call-template>
  </div>

  <!-- Table of Contents -->
  <xsl:call-template name="toc"/>
  
  <!--  Collaboration Window -->     
  <xsl:call-template name="collaboration">
   <xsl:with-param name="editable">
    <xsl:choose>
     <xsl:when test="tnx_stat_code = '01' or tnx_stat_code = '02'">false</xsl:when>
     <xsl:otherwise>true</xsl:otherwise>
    </xsl:choose>
   </xsl:with-param>
   <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
   <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
   <xsl:with-param name="bank_name_widget_id">recipient_bank_name</xsl:with-param>
   <xsl:with-param name="bank_abbv_name_widget_id">recipient_bank_abbv_name</xsl:with-param>
  </xsl:call-template>
   
  <!-- Javascript imports  -->
  <xsl:call-template name="js-imports"/>
  
  <!-- Add the definition of columns (used in the RTE editor) -->
  <xsl:if test="$displaymode = 'edit'">
   <script>
    // Instantiate columns arrays
    var arrColumn = [];
    var arrProductColumn = [];
    var arrValuesSet = [];  

    // Add columns definitions
    <xsl:call-template name="Columns_Definitions"/>

    <!-- Include some eventual additional columns -->
    <xsl:call-template name="report_addons"/>

   </script>

   <!-- Retrieve the javascript products' columns and candidate for every product authorised for the current user -->
   <xsl:call-template name="Products_Columns_Candidates"/>
  </xsl:if>
  
 </xsl:template>

<!--                                     -->  
<!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
<!--                                     -->

 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="common-js-imports">
   <xsl:with-param name="binding">misys.binding.trade.create_bg</xsl:with-param>
   <xsl:with-param name="override-help-access-key">BG_01</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="show-type">N</xsl:with-param>
   <xsl:with-param name="additional-fields">
    <!-- Hidden fields for the unsigned view -->
  <xsl:if test="$displaymode='view'">
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">recipient_bank_abbv_name</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="recipient_bank/abbv_name"/></xsl:with-param>
    </xsl:call-template>
  </xsl:if>
  <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">lead_bank_label</xsl:with-param>
     <xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_LEAD_BANK_NAME')"/>
  </xsl:call-template>
  <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">recipient_bank_label</xsl:with-param>
     <xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_RECIPIENT_BANK')"/>
  </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
  <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">swiftregexValue</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX')"/></xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">product_code</xsl:with-param>				
	</xsl:call-template>
  <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_lead_bank_flag</xsl:with-param>
     <xsl:with-param name="value" select="lead_bank_flag"/>
  </xsl:call-template>
  <!-- Domestic Guarantee -->
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">form_mask</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="$form_mask"/></xsl:with-param>
  </xsl:call-template>
	</div>
 </xsl:template>

  <!--
    BG General Details Fieldset.
  -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <!-- Common general details. -->
     <xsl:call-template name="common-general-details"/>

     <!-- BG Details. -->
     <xsl:call-template name="bg-details"/>
      
     <!-- Applicant Details -->
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="address">
        <xsl:with-param name="show-entity">Y</xsl:with-param>
        <xsl:with-param name="show-country">Y</xsl:with-param>
        <xsl:with-param name="prefix">applicant</xsl:with-param>
       </xsl:call-template>
        
       <!--
        If we have to, we show the reference field for applicants. This is
        specific to this form.
        -->
        <!-- commented as part of MPS-39538  -->
       <!-- <xsl:if test="applicant_reference[.!=''] and ($displaymode='view')">
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
         <xsl:with-param name="name">applicant_reference</xsl:with-param>
         <xsl:with-param name="value"><xsl:value-of select="utils:decryptApplicantReference(applicant_reference)"/></xsl:with-param>
         <xsl:with-param name="maxsize">34</xsl:with-param>
        </xsl:call-template>
       </xsl:if> -->
      </xsl:with-param>
     </xsl:call-template>

     <xsl:call-template name="bg-alternative-applicant-details" />
     
     <!-- Beneficiary Details -->
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="button-type"></xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="address">
        <xsl:with-param name="show-reference">Y</xsl:with-param>
        <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
        <xsl:with-param name="show-country">Y</xsl:with-param>
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
     
     <!-- Contact Details -->
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_HEADER_CONTACT_DETAILS</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="button-type">contact</xsl:with-param>
      <xsl:with-param name="content">
      <xsl:if test="$displaymode='edit' or ($displaymode='view' and  
      (contact_name[.!=''] or contact_country[.!=''] or contact_address_line_1[.!=''] or 
      contact_address_line_2[.!=''] or contact_dom[.!=''] or contact_address_line_4[.!='']))">
       <xsl:call-template name="address">
        <xsl:with-param name="show-country">Y</xsl:with-param>
        <xsl:with-param name="prefix">contact</xsl:with-param>
        <xsl:with-param name="required">N</xsl:with-param>
       </xsl:call-template>
       </xsl:if>
      </xsl:with-param>
     </xsl:call-template>
     
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- BG Amount Details -->
  <xsl:template name="bg-amt-details">
   <xsl:param name="override-product-code"/>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
    <xsl:if test="$displaymode='edit' or ($displaymode='view' and  bg_amt != '')">
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_GTEE_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
    </xsl:if>

<!-- Displayed in details summary view -->
     <xsl:if test="$displaymode='view'">
      <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_available_amt</xsl:variable>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_AVAILABLE_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="name"><xsl:value-of select="$override-product-code"/>_available_amt</xsl:with-param>
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


   <!-- Displayed in details summary view -->
     <xsl:if test="$displaymode='view'  and security:isBank($rundata)">
      <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_liab_amt</xsl:variable>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL</xsl:with-param>
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
     
     

		 <div id="consortium_details">
			<!-- Consortium Details -->
			<div id="chkBoxAlignPopup">
		         <xsl:choose>
		          	<xsl:when test="$displaymode='view'">
			         	 <xsl:choose>
			          		<xsl:when test="consortium = 'Y'">
			          			<xsl:call-template name="input-field">
			          				<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_CONSORTIUM')"/>
			          			</xsl:call-template>
			           		</xsl:when>
			         	</xsl:choose>
		          	</xsl:when>
		          	<xsl:otherwise>
		          		<xsl:call-template name="checkbox-field">
				           <xsl:with-param name="label">XSL_AMOUNTDETAILS_CONSORTIUM</xsl:with-param>
				           <xsl:with-param name="name">consortium</xsl:with-param>
		          		</xsl:call-template>
		          	</xsl:otherwise>
		          </xsl:choose>
	         </div> 
			<xsl:call-template name="row-wrapper">
				<xsl:with-param name="id">consortium_details</xsl:with-param>
				<xsl:with-param name="label">XSL_CONSORTIUM_DETAILS_LABEL</xsl:with-param>
				<xsl:with-param name="type">textarea</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="textarea-field">
						<xsl:with-param name="name">consortium_details</xsl:with-param>
						<xsl:with-param name="button-type"></xsl:with-param>
						<xsl:with-param name="rows">6</xsl:with-param>
						<xsl:with-param name="cols">35</xsl:with-param>
						<xsl:with-param name="maxlines">6</xsl:with-param>        
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
	          
	      <xsl:if test="$displaymode='edit' or ($displaymode='view' and net_exposure_amt != '')">
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_AMOUNTDETAILS_NET_EXPOSUER_LABEL</xsl:with-param>
				<xsl:with-param name="override-currency-name">net_exposure_cur_code</xsl:with-param>
				<xsl:with-param name="override-amt-name">net_exposure_amt</xsl:with-param>
				<xsl:with-param name="override-product-code">net_exposure</xsl:with-param>     
			</xsl:call-template>
		  </xsl:if>
		</div>     
     
		<!-- Charges -->
		<xsl:if test="$displaymode='edit' or ($displaymode='view' and open_chrg_brn_by_code != '')">
			<xsl:apply-templates select="open_chrg_brn_by_code">
				<xsl:with-param name="node-name">open_chrg_brn_by_code</xsl:with-param>
				<xsl:with-param name="label">XSL_CHRGDETAILS_BG_ISS_LABEL</xsl:with-param>
			</xsl:apply-templates>
		</xsl:if>
		<xsl:if test="$displaymode='edit' or ($displaymode='view' and corr_chrg_brn_by_code != '')">
			<xsl:apply-templates select="corr_chrg_brn_by_code">
				<xsl:with-param name="node-name">corr_chrg_brn_by_code</xsl:with-param>
				<xsl:with-param name="label">XSL_CHRGDETAILS_BG_CORR_LABEL</xsl:with-param>
			</xsl:apply-templates>
		</xsl:if>
     
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- 
   BG Details 
  -->
  <xsl:template name="bg-details">
   <xsl:call-template name="select-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_EFFECTIVE_DATE_TYPE</xsl:with-param>
    <xsl:with-param name="name">iss_date_type_code</xsl:with-param>
    <xsl:with-param name="fieldsize">x-large</xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
    <xsl:with-param name="options">
     <xsl:call-template name="bg-start-dates"/>
    </xsl:with-param>
   </xsl:call-template>
   <xsl:if test="$displaymode='edit'">
    <xsl:call-template name="input-field">
     <xsl:with-param name="name">iss_date_type_details</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
    </xsl:call-template>
   </xsl:if>
   <!-- Issue Date -->
   <!-- Displayed in consolidated view -->
   <xsl:if test="$displaymode='view' and (not(tnx_id) or tnx_type_code[.!='01'])">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
     <xsl:with-param name="name">iss_date</xsl:with-param>
    </xsl:call-template>
   </xsl:if>

   <xsl:if test="amd_no[.!='']">
		<xsl:call-template name="row-wrapper">
			<xsl:with-param name="label">XSL_GENERALDETAILS_AMD_NO</xsl:with-param>
			<xsl:with-param name="content"><div class="content">
                 <xsl:value-of select="utils:formatAmdNo(amd_no)"/></div>
			</xsl:with-param>
		</xsl:call-template>
   </xsl:if>
   <xsl:if test="$displaymode='edit'">
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="name">exp_date_type_code</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:call-template name="bg-exp-dates"/>
      </xsl:with-param>
     </xsl:call-template>
   
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">exp_date</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
   </xsl:if>
   <xsl:if test="$displaymode='view'">
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE_TYPE</xsl:with-param>
      <xsl:with-param name="name">exp_date_type_code</xsl:with-param>      
      <xsl:with-param name="options">
       <xsl:call-template name="bg-exp-dates"/>
      </xsl:with-param>
     </xsl:call-template>
    <xsl:if test="exp_date_type_code[.!= '01']">   
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">exp_date</xsl:with-param>
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="exp_date"/></xsl:with-param>
     </xsl:call-template>
    </xsl:if>
   </xsl:if>
   
   <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">exp_event</xsl:with-param>
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_EVENT</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">exp_event</xsl:with-param>
        <xsl:with-param name="button-type"></xsl:with-param>
        <xsl:with-param name="rows">4</xsl:with-param>
        <xsl:with-param name="cols">35</xsl:with-param>
        <xsl:with-param name="maxlines">4</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
   </xsl:call-template>
   <div id="chkBoxAlignPopup">
         <xsl:choose>
          	<xsl:when test="$displaymode='view'">
	         	 <xsl:choose>
	          		<xsl:when test="reduction_authorised = 'Y'">
	          			<xsl:call-template name="input-field">
	          				<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REDUCTION_AUTHORISED')"/>
	          			</xsl:call-template>
	           		</xsl:when>
	         	</xsl:choose>
          	</xsl:when>
          	<xsl:otherwise>
          		<xsl:call-template name="checkbox-field">
		           <xsl:with-param name="label">XSL_GENERALDETAILS_REDUCTION_AUTHORISED</xsl:with-param>
		           <xsl:with-param name="name">reduction_authorised</xsl:with-param>
          		</xsl:call-template>
          	</xsl:otherwise>
          </xsl:choose>
   </div>
   <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_REDUCTION_CLAUSE</xsl:with-param>
     <xsl:with-param name="name">reduction_clause</xsl:with-param>
     <xsl:with-param name="options">
      <xsl:call-template name="bg-reduction-clause"/>
   </xsl:with-param>
   </xsl:call-template>
   <xsl:if test="$displaymode='edit'">
    <xsl:call-template name="input-field">
      <xsl:with-param name="name">reduction_clause_other</xsl:with-param>
      <xsl:with-param name="maxsize">35</xsl:with-param>
      <!-- <xsl:with-param name="readonly">Y</xsl:with-param> -->
    </xsl:call-template>
   </xsl:if>
    
  </xsl:template>
  
  <!--
   BG Realform
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
      	<xsl:with-param name="name">fileActIds</xsl:with-param>
      	<xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="e2ee_transaction"/>
   <xsl:call-template name="reauth_params"/>
      </div>
     </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
 <!-- 
  BG Start Dates 
  -->
  <xsl:template name="bg-start-dates">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="01">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ISSUANCE')"/>
     </option>
     <option value="02">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_CONTRACT_SIGN')"/>
     </option>
     <option value="03">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ADV_PAYMT')"/>
     </option>
     <option value="99">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_OTHER')"/>
     </option>
   </xsl:when>
   <xsl:otherwise>
    <xsl:choose>
     <xsl:when test="iss_date_type_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ISSUANCE')"/></xsl:when>
     <xsl:when test="iss_date_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_CONTRACT_SIGN')"/></xsl:when>
     <xsl:when test="iss_date_type_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ADV_PAYMT')"/></xsl:when>
     <xsl:when test="iss_date_type_code[. = '99']">
      <xsl:value-of select="iss_date_type_details"/>
     </xsl:when>
    </xsl:choose>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
  
</xsl:stylesheet>