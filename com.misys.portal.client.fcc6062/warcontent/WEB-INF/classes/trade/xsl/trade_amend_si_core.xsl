<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Letter of Credit (LC) Amendment Form, Customer Side.
 
 Note: Templates beginning with amend- are in amend_common.xsl

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
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="defaultresource">
  
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
  <xsl:param name="product-code">SI</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/StandbyIssuedScreen</xsl:param>
  <xsl:param name="Goods_description"/>
  <xsl:param name="Documents_required"/>
  <xsl:param name="Additional_Conditions"/>
  <xsl:param name="Amendment_Narrative"/>
  <xsl:param name="Discrepant_Details"/>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/amend_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="si_tnx_record"/>
  </xsl:template>
  
  <!-- 
   SI AMEND TNX FORM TEMPLATE.
  -->
  <xsl:template match="si_tnx_record">
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
      <xsl:with-param name="show-return">Y</xsl:with-param>
      <xsl:with-param name="show-template">N</xsl:with-param>
      </xsl:call-template>
       <xsl:call-template name="build-inco-terms-data"/>
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
     
      <xsl:call-template name="hidden-fields"/>
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="general-details"/>
      <xsl:call-template name="amend-amt-details">
       <xsl:with-param name="show-release-flag">Y</xsl:with-param>
       <xsl:with-param name="show-os-amt">Y</xsl:with-param>
       <xsl:with-param name="override-product-code">lc</xsl:with-param>
       <xsl:with-param name="tnx-record" select="org_previous_file/si_tnx_record"/>
      </xsl:call-template>
      <xsl:call-template name="amend-renewal-details"/>
      <!-- <xsl:call-template name="standby-lc-details">
      	<xsl:with-param name="isAmend">Y</xsl:with-param>
      </xsl:call-template> -->
      <xsl:call-template name="amend-shipment-details">
        <xsl:with-param name="tnx-record" select="org_previous_file/si_tnx_record"/>
      </xsl:call-template>
      <xsl:call-template name="amend-narrative"/>
      <xsl:call-template name="bank-instructions">
       <xsl:with-param name="send-mode-displayed">N</xsl:with-param>
       <xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
       <xsl:with-param name="override-form-name">fakeform1</xsl:with-param>
      </xsl:call-template>
      
      <!-- Charges (hidden section) -->
      <!-- <xsl:for-each select="charges/charge">
       <xsl:call-template name="charge-details-hidden"/>
      </xsl:for-each> -->
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
    	<xsl:call-template name="attachments-file-dojo">
   			<xsl:with-param name="callback">misys.toggleFields(misys._config.customerBanksMT798Channel[dijit.byId("issuing_bank_abbv_name").get("value")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01', null, ["delivery_channel"], false, false)</xsl:with-param>
   			<xsl:with-param name="title-size">35</xsl:with-param>
   		</xsl:call-template>
    </xsl:if>

    <xsl:call-template name="realform"/>
	  <!-- Reauthentication -->
      <xsl:call-template name="reauthentication"/>

    <xsl:call-template name="menu">
     <xsl:with-param name="second-menu">Y</xsl:with-param>
     <xsl:with-param name="show-return">Y</xsl:with-param>
     <xsl:with-param name="show-template">N</xsl:with-param>
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
				<xsl:apply-templates select="avail_main_banks/bank" mode="customer_banks_communication_channel"/>
			});
		</script>
	   </xsl:if> 

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
   <xsl:with-param name="binding">misys.binding.trade.amend_si</xsl:with-param>
   <xsl:with-param name="override-help-access-key">SI_03</xsl:with-param>
  </xsl:call-template>
 </xsl:template>

 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="override-product-code">lc</xsl:with-param>
  </xsl:call-template>
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">issuing_bank_name</xsl:with-param>
    <xsl:with-param name="value" select="issuing_bank/name"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
   </xsl:call-template>
  <xsl:if test="entity[. != '']">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">entity</xsl:with-param>
   </xsl:call-template>
  </xsl:if>
   <xsl:if test="$displaymode='edit'">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
    </xsl:call-template>

    <!-- Original Shipment Fields -->
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_ship_from</xsl:with-param>
     <xsl:with-param name="value" select="org_previous_file/si_tnx_record/ship_from"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_ship_loading</xsl:with-param>
     <xsl:with-param name="value" select="org_previous_file/si_tnx_record/ship_loading"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_ship_discharge</xsl:with-param>
     <xsl:with-param name="value" select="org_previous_file/si_tnx_record/ship_discharge"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_ship_to</xsl:with-param>
     <xsl:with-param name="value" select="org_previous_file/si_tnx_record/ship_to"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_last_ship_date</xsl:with-param>
     <xsl:with-param name="value" select="org_previous_file/si_tnx_record/last_ship_date"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_narrative_shipment_period</xsl:with-param>
     <xsl:with-param name="value" select="org_previous_file/si_tnx_record/narrative_shipment_period"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_narrative_additional_amount</xsl:with-param>
     <xsl:with-param name="value" select="org_previous_file/si_tnx_record/narrative_additional_amount"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">product_code</xsl:with-param>				
	</xsl:call-template>
   </xsl:if>
  </div>
 </xsl:template>

 <!--
   SI General Details Fieldset.
    
   Common General Details, Applicant Details, Beneficiary Details.
  -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <!-- <xsl:with-param name="button-type">summary-details</xsl:with-param> -->
   	<xsl:with-param name="button-type">
  		<xsl:choose>
  			<xsl:when test="$swift2018Enabled and tnx_type_code[.='03'] and $mode='UNSIGNED'">amend-summary-details</xsl:when>
  			<xsl:otherwise>summary-details</xsl:otherwise>
  		</xsl:choose>
  	</xsl:with-param>
    <xsl:with-param name="content">
     <div id="generaldetails">
      <!-- Hidden fields. -->
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">ref_id</xsl:with-param>
      </xsl:call-template>
      <xsl:if test="$displaymode='edit'">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">appl_date</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">cust_ref_id</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">bo_ref_id</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">org_iss_date</xsl:with-param>
        <xsl:with-param name="value" select="org_previous_file/si_tnx_record/iss_date"/>
       </xsl:call-template>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">org_exp_date</xsl:with-param>
        <xsl:with-param name="value" select="org_previous_file/si_tnx_record/exp_date"/>
       </xsl:call-template>
        <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">adv_send_mode</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="adv_send_mode"/></xsl:with-param>
	    </xsl:call-template>
      </xsl:if>
      <!--  System ID. -->
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
       <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="ref_id" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      
      <xsl:if test="cust_ref_id[.!='']">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
        <xsl:with-param name="id">general_cust_ref_id_view</xsl:with-param>
        <xsl:with-param name="value" select="cust_ref_id" />
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
       <xsl:with-param name="id">general_bo_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="bo_ref_id" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
       <xsl:with-param name="id">org_previous_iss_date_view</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/iss_date"/>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
	  <xsl:if test="org_previous_file/si_tnx_record/exp_date[.!='']">
	      <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_GENERALDETAILS_ORG_EXPIRY_DATE</xsl:with-param>
	       <xsl:with-param name="id">org_previous_exp_date_view</xsl:with-param>
	       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/exp_date"/>
	       <xsl:with-param name="override-displaymode">view</xsl:with-param>
	      </xsl:call-template>
	  </xsl:if>
      <!--  Expiry Date. --> 
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_NEW_EXPIRY_DATE</xsl:with-param>
       <xsl:with-param name="name">exp_date</xsl:with-param>
       <xsl:with-param name="size">10</xsl:with-param>
       <xsl:with-param name="maxsize">10</xsl:with-param>
       <xsl:with-param name="type">date</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
      </xsl:call-template>
      
      <!--  Amendment Date. --> 
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>
       <xsl:with-param name="name">amd_date</xsl:with-param>
       <xsl:with-param name="size">10</xsl:with-param>
       <xsl:with-param name="maxsize">10</xsl:with-param>
       <xsl:with-param name="type">date</xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">amd_no</xsl:with-param>
      </xsl:call-template>
      <xsl:if test="$displaymode='view'">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">amd_date</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
     </div>   
	    <xsl:call-template name="fieldset-wrapper">
	     <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
	     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	     <xsl:with-param name="button-type"></xsl:with-param>
	     <xsl:with-param name="content">
	      <xsl:call-template name="address">
	       <xsl:with-param name="prefix">beneficiary</xsl:with-param>
	       <xsl:with-param name="show-reference">Y</xsl:with-param>
	       <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>
	        <xsl:with-param name="show-country">Y</xsl:with-param>
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
      <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
   <script>
	   dojo.ready(function(){
		        	misys._config = misys._config || {};
					misys._config.release_flag = <xsl:value-of select="defaultresource:getResource('AMEND_RELEASE_FLAG')"/>;	
				});
	</script>
  </xsl:template>
</xsl:stylesheet>