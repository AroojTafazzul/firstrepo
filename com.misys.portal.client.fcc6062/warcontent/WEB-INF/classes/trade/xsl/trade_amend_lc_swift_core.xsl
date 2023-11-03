<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Main Amendment Letter of Credit form xsl for LC Amendment SWIFT 2018 format
 
Copyright (c) 2017-2018 (http://www.finastra.com),
All Rights Reserved. 

version:   1.0
date:      09/12/2017
author:    Avilash Ghosh

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
	exclude-result-prefixes="xmlRender localization securitycheck utils defaultresource security">
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <!-- Columns definition import -->
	<xsl:import href="../../core/xsl/report/report.xsl"/>
  <xsl:param name="rundata"/>
  <xsl:param name="formLoad">false</xsl:param>
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
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/lc_common.xsl" />
  <xsl:include href="../../core/xsl/common/amend_lc_common_new.xsl" />
  <xsl:include href="../../core/xsl/common/ls_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="lc_tnx_record"/>
  </xsl:template>
  
  <!-- 
   LC TNX FORM TEMPLATE.
   
  -->
  <xsl:template match="lc_tnx_record">
   <!-- Preloader -->
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
      
      <xsl:call-template name="general-details" />
      <xsl:choose>
      	<xsl:when test="defaultresource:getResource('STANDBY_CHECKBOX_DISABLED') = 'true' or $swift2019Enabled">
      		<xsl:call-template name="amend-amt-details">										<!-- from amend_lc_common_new_core -->
	      	<xsl:with-param name="show-revolving">
		      	<xsl:choose>
		      		<xsl:when test="sub_tnx_type_code[.!='06']">Y</xsl:when>
		      		<xsl:otherwise>N</xsl:otherwise>
		      	</xsl:choose>
	      	</xsl:with-param>
	      	<xsl:with-param name="show-standby">N</xsl:with-param>
	      </xsl:call-template>
      	</xsl:when>
      	<xsl:otherwise>
	      <xsl:call-template name="amend-amt-details">										<!-- from amend_lc_common_new_core -->
	      	<xsl:with-param name="show-revolving">
		      	<xsl:choose>
		      		<xsl:when test="sub_tnx_type_code[.!='06']">Y</xsl:when>
		      		<xsl:otherwise>N</xsl:otherwise>
		      	</xsl:choose>
	      	</xsl:with-param>
	      </xsl:call-template>
      	</xsl:otherwise>
      </xsl:choose>										<!-- from amend_lc_common_new_core -->
      <xsl:choose>
	      <xsl:when test="$displaymode = 'view' and revolving_flag = 'Y' and sub_tnx_type_code[.!='06']">
	      	<xsl:call-template name="lc-revolving-details" />							<!-- from amend_lc_common_new_core -->
	      </xsl:when>
	      <xsl:when test="$displaymode = 'edit' and sub_tnx_type_code[.!='06']">
		      <div id="revolving-details" style="display:none;">
		      	<xsl:call-template name="lc-revolving-details" />						<!-- from amend_lc_common_new_core -->
		      </div>
	      </xsl:when>
      </xsl:choose>
      
      <!-- 
       This template is used by Upload LC in view mode; we hide the following sections
       in this case. 
      --> 
      <xsl:if test="lc_type[.!='04'] or tnx_type_code[.!='01']">
       <xsl:call-template name="lc-payment-details">									<!-- from amend_lc_common_new_core -->
       		<xsl:with-param name="required">Y</xsl:with-param>
	   </xsl:call-template>
       <xsl:call-template name="amend-shipment-details"/> 								<!-- from amend_lc_common_new_core -->
      </xsl:if>
	  <div style="display:none;">
			<xsl:call-template name="amend-issue-bank-details"/>						<!-- from amend_lc_common_new_core -->
	  </div>      
      <!-- Bank details -->
      <xsl:call-template name="amend-lc-bank-details"/>									<!-- from amend_lc_common_new_core -->
   
   	  <xsl:if test="securitycheck:hasPermission($rundata,'ls_access') = 'true' and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true'">
		<xsl:call-template name="linked-ls-declaration"/>
 		<xsl:call-template name="linked-licenses"/>
 	 </xsl:if>
 
 	<xsl:if test="is_MT798[.='N']">
   	  <xsl:choose>
	      <xsl:when test="$displaymode = 'view' and amd_details[.!='']">
	      	<xsl:call-template name="amend-common-narrative" />							<!-- from amend_lc_common_new_core -->
	      </xsl:when>
	      <xsl:when test="$displaymode = 'edit'">
		      <xsl:call-template name="amend-common-narrative"/>
	      </xsl:when>
      </xsl:choose>
     </xsl:if>
   
	   <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
	    <xsl:with-param name="content">
	    
	      <!-- Narrative Details -->
	     <xsl:call-template name="lc-narrative-swift-details">
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
			<xsl:with-param name="in-fieldset">N</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="lc-swift-narrative-special-payments-beneficiary"/>
	   
	      <!-- Narrative Period -->
	       <xsl:choose>
	      	<xsl:when test = "$swift2018Enabled" >
	      		 <xsl:call-template name="lc-narrative-period-swift2018">			<!-- from lc_common_swift_core -->
	      		 	<xsl:with-param name="in-fieldset">N</xsl:with-param>
	     		 </xsl:call-template>
	      	</xsl:when>
	      	<xsl:otherwise>
	      		 <xsl:call-template name="lc-narrative-period">						<!-- from lc_common_core -->
	      		 	<xsl:with-param name="in-fieldset">N</xsl:with-param>
	     		 </xsl:call-template>
	      	</xsl:otherwise>
	      </xsl:choose>
	      <xsl:call-template name="fieldset-wrapper">
	      <xsl:with-param name="legend">XSL_LEGACY_DETAILS_LABEL</xsl:with-param>
	      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	      <xsl:with-param name="content">
	       <!-- <xsl:if test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE'] or tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE']"> -->
	       		<xsl:call-template name="legacy-template"/>
	       <!-- </xsl:if> -->
	      </xsl:with-param>
	     </xsl:call-template>
      
      </xsl:with-param>
      </xsl:call-template>
      
      
      <!-- Bank Instructions -->
      <xsl:call-template name="bank-instructions">										<!-- from trade_common_core -->
       <xsl:with-param name="send-mode-label">XSL_INSTRUCTIONS_AMD_ADV_SEND_MODE_LABEL</xsl:with-param>
       <xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
        <xsl:with-param name="send-mode-required">Y</xsl:with-param>
      </xsl:call-template>
      
      <xsl:if test="$displaymode = 'view' and narrative_full_details != ''">
      	<xsl:call-template name="lc-narrative-full">									<!-- from lc_common_core -->
      		<xsl:with-param name="label">XSL_HEADER_FREEFORMAT_NARRATIVE</xsl:with-param>
      	</xsl:call-template>
      </xsl:if>
      
	  <!-- Reauthentication -->
      <xsl:call-template name="reauthentication"/>
      
      <!-- comments for return -->
      <xsl:call-template name="comments-for-return">									<!-- from trade_common_core -->
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
		
     </xsl:with-param>
    </xsl:call-template>
    
      <!-- Form #1 : Attach Files -->
     <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
    	<xsl:call-template name="attachments-file-dojo">
    		<xsl:with-param name="callback">misys.toggleFields(misys._config.customerBanksMT798Channel[dijit.byId("issuing_bank_abbv_name").get("value")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01', null, ["delivery_channel"], false, false)</xsl:with-param>
    		<xsl:with-param name="title-size">35</xsl:with-param>
    	</xsl:call-template>    	
    </xsl:if>
    
    <!-- The form that's submitted -->
    <xsl:call-template name="realform"/>

    <!-- Display common menu, this time outside the form -->
    <xsl:call-template name="menu">
     <xsl:with-param name="second-menu">Y</xsl:with-param>
     <xsl:with-param name="show-return">Y</xsl:with-param>
      <xsl:with-param name="show-template">N</xsl:with-param>
    </xsl:call-template>
   </div>
	<!-- Template to initialize the product and category map data for dynamic phrase. -->
	<xsl:call-template name="populate-phrase-data"/>
	 <xsl:call-template name="build-inco-terms-data"/>
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
   
   <!--  Collaboration Window -->     
   <xsl:call-template name="collaboration">
    <xsl:with-param name="editable">true</xsl:with-param>
    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
   </xsl:call-template>
   
    <!-- Add the communication channel in the page (MT798 or standard)
   Fields are switched depending on it -->
	<xsl:if test="$displaymode='edit'">
    <script>
    	dojo.ready(function(){
    		misys._config = misys._config || {};
			misys._config.customerBanksMT798Channel = {};
			<xsl:apply-templates select="main_bank/bank" mode="customer_banks_communication_channel"/>
		});
	</script>
   </xsl:if>  
  
	<xsl:call-template name="amendedNarrativesStore"/>
   <!-- Javascript and Dojo imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>

  <!--                                     -->  
  <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
  <!--                                     -->
 
  <!-- Additional JS imports for this form are -->
  <!-- added here. -->
  <xsl:template name="js-imports">
   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.trade.amend_lc_swift2018</xsl:with-param>
    <xsl:with-param name="show-period-js">Y</xsl:with-param>
    <xsl:with-param name="override-help-access-key">LC_03</xsl:with-param>
   </xsl:call-template>
   <script type="text/javascript">
		dojo.ready(function(){
			misys._config.swiftExtendedNarrativeEnabled = <xsl:value-of select="defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE')" />
		});
	</script>
  </xsl:template>
  
  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <div class="widgetContainer">
   <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="additional-fields">
     <xsl:if test="$displaymode='view'">
      <!-- This field is sent in the unsigned view -->
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
      </xsl:call-template>
     </xsl:if>
    </xsl:with-param>
   </xsl:call-template>
   <xsl:choose>
   	  <xsl:when test="entities[.= '0']"/>
	  <xsl:when test="entity[. != '']">
	   	 <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">entity</xsl:with-param>
	    </xsl:call-template>
      </xsl:when>
   </xsl:choose>
   <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">swiftregexValue</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX')"/></xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">swiftregexzcharValue</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX_ZCHAR')"/></xsl:with-param>
   </xsl:call-template>
    <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">narrative_period_presentation_nosend</xsl:with-param>
       <xsl:with-param name="value" select="narrative_period_presentation"/>
     </xsl:call-template>
	<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">product_code</xsl:with-param>				
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">sub_product_code</xsl:with-param>				
	</xsl:call-template>
	 <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_exp_date</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/exp_date"/>
      </xsl:call-template>
       <xsl:call-template name="hidden-field">
      		<xsl:with-param name="name">org_narrative_description_goods</xsl:with-param>
      		<xsl:with-param name="value" select="org_previous_file/lc_tnx_record/narrative_description_goods"/>
   	</xsl:call-template> 
   	<xsl:call-template name="hidden-field">
      		<xsl:with-param name="name">org_narrative_documents_required</xsl:with-param>
      		<xsl:with-param name="value" select="org_previous_file/lc_tnx_record/narrative_documents_required"/>
   	</xsl:call-template> 
   	<xsl:call-template name="hidden-field">
      	<xsl:with-param name="name">org_narrative_additional_instructions</xsl:with-param>
      	<xsl:with-param name="value" select="org_previous_file/lc_tnx_record/narrative_additional_instructions"/>
   	</xsl:call-template>
   	<xsl:call-template name="hidden-field">
      		<xsl:with-param name="name">org_narrative_special_beneficiary</xsl:with-param>
      		<xsl:with-param name="value" select="org_previous_file/lc_tnx_record/narrative_special_beneficiary"/>
   	</xsl:call-template>
   <xsl:if test="$displaymode='edit'">
	<!-- Master Revolve fields -->
	<xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_revolve_time_no</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/revolve_time_no"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_revolve_frequency</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/revolve_frequency"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_revolve_period</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/revolve_period"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_next_revolve_date</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/next_revolve_date"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_notice_days</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/notice_days"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_charge_upto</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/charge_upto"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_expiry_place</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/expiry_place"/>
   </xsl:call-template>
  
   <!-- Master Shipment Fields -->
    <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_part_ship_detl</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/part_ship_detl"/>
    </xsl:call-template> 
    <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_tran_ship_detl</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/tran_ship_detl"/>
    </xsl:call-template> 
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_ship_from</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/ship_from"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_ship_loading</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/ship_loading"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_ship_discharge</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/ship_discharge"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_ship_to</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/ship_to"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_last_ship_date</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/last_ship_date"/>
   </xsl:call-template>
    <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_amd_date</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/amd_date"/>
   </xsl:call-template>
   <!--  <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_inco_term</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/inco_term"/>
    </xsl:call-template>  -->
    <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_inco_place</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/inco_place"/>
    </xsl:call-template>
    <!-- Master Narrative field values -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_narrative_shipment_period</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/narrative_shipment_period"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_narrative_additional_amount</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/narrative_additional_amount"/>
   </xsl:call-template>
   	<xsl:call-template name="hidden-field">
      	<xsl:with-param name="name">org_narrative_period_presentation</xsl:with-param>
      	<xsl:with-param name="value" select="org_previous_file/lc_tnx_record/narrative_period_presentation"/>
   	</xsl:call-template> 
   	<!-- Master Credit available with Bank values -->
   	 <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_credit_available_with_bank_name</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/credit_available_with_bank/name"/>
     </xsl:call-template>
       <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_credit_available_with_bank_role_code</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/credit_available_with_bank/role_code" />
     </xsl:call-template>
     
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_credit_available_with_bank_address_line_1</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/credit_available_with_bank/address_line_1" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_credit_available_with_bank_address_line_2</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/credit_available_with_bank/address_line_2" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_credit_available_with_bank_address_line_4</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/credit_available_with_bank/address_line_4" />
     </xsl:call-template>
     <!-- Master Requested confirmation party values -->
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_req_conf_party_flag</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/req_conf_party_flag" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_requested_confirmation_party_name</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/requested_confirmation_party/name" />
     </xsl:call-template>
      <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_requested_confirmation_party_address_line_1</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/requested_confirmation_party/address_line_1" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_requested_confirmation_party_address_line_2</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/requested_confirmation_party/address_line_2" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_requested_confirmation_party_address_line_4</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/requested_confirmation_party/address_line_4" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_requested_confirmation_party_iso_code</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/requested_confirmation_party/iso_code" />
     </xsl:call-template>
      <!-- Master Form of LC values -->
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_irv_flag</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/irv_flag" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_ntrf_flag</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/ntrf_flag" />
     </xsl:call-template>
       <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_trf_flag</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/trf_flag" />
     </xsl:call-template>
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_stnd_by_lc_flag</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/stnd_by_lc_flag" />
     </xsl:call-template>
      <!-- Master Confirmation Instructions values -->
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cfm_inst_code_1</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/cfm_inst_code" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cfm_inst_code_2</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/cfm_inst_code" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cfm_inst_code_3</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/cfm_inst_code" />
     </xsl:call-template>
      <!-- Master Issuing Bank charges values -->
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_open_chrg_brn_by_code_1</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/open_chrg_brn_by_code" />
     </xsl:call-template>
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_open_chrg_brn_by_code_2</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/open_chrg_brn_by_code" />
     </xsl:call-template>
      <!-- Master Outside country charges values -->
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_corr_chrg_brn_by_code_1</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/corr_chrg_brn_by_code" />
     </xsl:call-template>
        <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_corr_chrg_brn_by_code_2</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/corr_chrg_brn_by_code" />
     </xsl:call-template>
      <!-- Master Confirmation charges values -->
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cfm_chrg_brn_by_code_1</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/cfm_chrg_brn_by_code" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cfm_chrg_brn_by_code_2</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/cfm_chrg_brn_by_code" />
     </xsl:call-template>
      <!-- Master Amend charges by values -->
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_amd_chrg_brn_by_code_1</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/amd_chrg_brn_by_code" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_amd_chrg_brn_by_code_2</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/amd_chrg_brn_by_code" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_amd_chrg_brn_by_code_3</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/amd_chrg_brn_by_code" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_amd_chrg_brn_by_code_4</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/amd_chrg_brn_by_code" />
     </xsl:call-template>
      <!-- Master Credit available by values -->
  	 <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cr_avl_by_code_1</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/cr_avl_by_code" />
     </xsl:call-template>
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cr_avl_by_code_2</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/cr_avl_by_code" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cr_avl_by_code_3</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/cr_avl_by_code" />
     </xsl:call-template>
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cr_avl_by_code_4</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/cr_avl_by_code" />
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_cr_avl_by_code_5</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/cr_avl_by_code" />
     </xsl:call-template>
      <!-- Master Payment /Draft by values -->
     <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_tenor_type_1</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/tenor_type" />
     </xsl:call-template>
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_tenor_type_2</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/tenor_type" />
     </xsl:call-template>
      <xsl:call-template name="hidden-field">
    	 <xsl:with-param name="name">org_tenor_type_3</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/tenor_type" />
     </xsl:call-template>
     <!-- Master Drawee details values -->
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_drawee_details_bank_name</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/drawee_details_bank/name"/>
     </xsl:call-template>
     <!-- Advise send mode master value-->
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_adv_send_mode</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/adv_send_mode"/>
     </xsl:call-template>
      <!-- Tolerance%  master value-->
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_pstv_tol_pct</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/pstv_tol_pct"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_neg_tol_pct</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/neg_tol_pct"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_applicable_rules</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/applicable_rules"/>
     </xsl:call-template>
         
  </xsl:if>
</div>
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
       <xsl:with-param name="value">03</xsl:with-param>
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
   Bank customer communication channel (MT798 or standard). 
   -->
 <xsl:template match="main_bank/bank" mode="customer_banks_communication_channel">
    misys._config.customerBanksMT798Channel['<xsl:value-of select="abbv_name"/>'] = <xsl:value-of select="@mt798_enabled"/>;
 </xsl:template>
 
</xsl:stylesheet>