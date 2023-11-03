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
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
     
      <xsl:call-template name="hidden-fields"/>
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="general-details"/>
       <xsl:call-template name="si-release-amt-details"/>
       <!-- MPS-40578 07-08-17 -->
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<xsl:call-template name="release-narrative"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="amd_details[.!='']">
					<xsl:call-template name="release-narrative"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
      <xsl:call-template name="bank-instructions">
       <xsl:with-param name="send-mode-displayed">N</xsl:with-param>
       <xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
       <xsl:with-param name="override-form-name">fakeform1</xsl:with-param>
      </xsl:call-template>
      
      <!-- Charges (hidden section) -->
      <xsl:for-each select="charges/charge">
       <xsl:call-template name="charge-details-hidden"/>
      </xsl:for-each>
      <xsl:if test="tnx_stat_code[.!='03' and .!='04']">   <!-- MPS-43899 -->
       <xsl:call-template name="comments-for-return">
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
   	  </xsl:if>
     </xsl:with-param>
    </xsl:call-template>

   <!-- Attach Files -->
     <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
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
   <xsl:with-param name="binding">misys.binding.trade.release_si</xsl:with-param>
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
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">entity</xsl:with-param>
   </xsl:call-template>
    <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">adv_send_mode</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="adv_send_mode"/></xsl:with-param>
    </xsl:call-template>
   <xsl:if test="$displaymode='edit'">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
     <xsl:with-param name="value">05</xsl:with-param>
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
    <xsl:with-param name="button-type">summary-details</xsl:with-param>
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
      </xsl:if>
      <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">amd_no</xsl:with-param>
     </xsl:call-template>
      <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">org_exp_date</xsl:with-param>
        <xsl:with-param name="value" select="org_previous_file/si_tnx_record/exp_date"/>
      </xsl:call-template>
      <xsl:if test="$displaymode='view'">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">amd_date</xsl:with-param>
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
      
      <xsl:if test="bo_ref_id[.!='']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
       <xsl:with-param name="id">general_bo_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="bo_ref_id" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      
     <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
	    <xsl:with-param name="id">org_previous_appl_date_view</xsl:with-param>
	    <xsl:with-param name="value" select="org_previous_file/si_tnx_record/appl_date"/>
	    <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
       <xsl:with-param name="id">org_previous_iss_date_view</xsl:with-param>
       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/iss_date"/>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      
      		<xsl:if test="org_previous_file/si_tnx_record/lc_exp_date_type_code[.!='']">
				<xsl:variable name="lc_exp_date_type_code"><xsl:value-of select="org_previous_file/si_tnx_record/lc_exp_date_type_code"></xsl:value-of></xsl:variable>
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
      
      <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_ORG_EXPIRY_DATE</xsl:with-param>
	    <xsl:with-param name="id">org_previous_exp_date_view</xsl:with-param>
	    <xsl:with-param name="value" select="org_previous_file/si_tnx_record/exp_date"/>
	    <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      
      <xsl:if test="exp_event[.!='']">
	        <xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="content">
						<div class="label">
							<span class="field">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_EVENT')" />
							</span>
						</div>
							<span class="narrativeFieldValue">
								<xsl:value-of select="exp_event" />
							</span>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	    <xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_LC_PLACE_OF_JURISDICTION</xsl:with-param>
			<xsl:with-param name="name">lc_govern_country</xsl:with-param>
			<xsl:with-param name="prefix">lc_govern</xsl:with-param>
			<xsl:with-param name="button-type">codevalue</xsl:with-param>
			<xsl:with-param name="fieldsize">x-small</xsl:with-param>
			<xsl:with-param name="uppercase">Y</xsl:with-param>
			<xsl:with-param name="size">2</xsl:with-param>
			<xsl:with-param name="maxsize">2</xsl:with-param>
			<xsl:with-param name="required">N</xsl:with-param>
			<xsl:with-param name="override-displaymode">view</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="input-field">  
			<xsl:with-param name="label">GOVERNING_LABEL</xsl:with-param>
			<xsl:with-param name="name">lc_govern_text</xsl:with-param>
			<xsl:with-param name="maxsize">65</xsl:with-param>
			<xsl:with-param name="swift-validate">Y</xsl:with-param>
			<xsl:with-param name="override-displaymode">view</xsl:with-param>
		</xsl:call-template>
		
		<xsl:if test="demand_indicator[.!='']">
			<xsl:variable name="demand_indicator_code"><xsl:value-of select="demand_indicator"></xsl:value-of></xsl:variable>
			<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
			<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
			<xsl:variable name="parameterId">C089</xsl:variable>
			<xsl:call-template name="input-field">
			 	<xsl:with-param name="label">XSL_DEMAND_INDICATOR</xsl:with-param>
			 	<xsl:with-param name="name">demand_indicator</xsl:with-param>
			 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $demand_indicator_code)"/></xsl:with-param>
			 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
			</xsl:call-template>
		</xsl:if>
		
		<xsl:if test="ntrf_flag[.!=''] and ntrf_flag[.='N'] and narrative_transfer_conditions/text[.!='']">
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="content">
						<div class="label">
							<span class="field">
								<xsl:value-of select="localization:getGTPString($language, 'TRANSFER_CONDITION')" />
							</span>
						</div>
							<span class="narrativeFieldValue">
								<xsl:value-of select="narrative_transfer_conditions/text" />
							</span>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		
     <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:with-param>
	    <xsl:with-param name="id">org_previous_appl_date_view</xsl:with-param>
	    <xsl:with-param name="value" select="org_previous_file/si_tnx_record/expiry_place"/>
	    <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      
     <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_COUNT</xsl:with-param>
	    <xsl:with-param name="id">org_previous_appl_date_view</xsl:with-param>
	    <xsl:with-param name="value" select="//si_tnx_record/amd_no"/>
	    <xsl:with-param name="override-displaymode">view</xsl:with-param>
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
      
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template> 
  
   <!-- 
   SI Release Amount Details
   -->
  <xsl:template name="si-release-amt-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="checkbox-field">
      <xsl:with-param name="name">lc_release_flag</xsl:with-param>
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_GTEE_RELEASE_FULL</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_SI_RELEASE_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">lc</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name">release_amt</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <!-- <xsl:with-param name="amt-readonly">Y</xsl:with-param> -->
      <xsl:with-param name="override-amt-value"><xsl:value-of select="release_amt"/></xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">utilized_amt</xsl:with-param>
        <xsl:with-param name="value" select="utilized_amt"/>
     </xsl:call-template>
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_LC_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">lc</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name">lc_amt</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
      <xsl:with-param name="override-amt-value"><xsl:value-of select="lc_amt"/></xsl:with-param>
     </xsl:call-template>

     <div>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">lc_cur_code</xsl:with-param>
      </xsl:call-template>
     </div>
     <div id="org-lc-lib-amt">
     <xsl:if test="$displaymode='edit'">
      <!-- <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_lc_liab_amt</xsl:with-param>
      </xsl:call-template> -->
      <xsl:call-template name="currency-field">
      <xsl:with-param name="product-code">lc</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name">org_lc_liab_amt</xsl:with-param>
      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
      <xsl:with-param name="override-amt-value"><xsl:value-of select="org_lc_liab_amt"/></xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     </div>

    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
   <xsl:template name="release-narrative">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_RELEASE_NARRATIVE</xsl:with-param>
    <xsl:with-param name="content">
     <!-- This empty tag is needed for this to appear, I'm not sure why. -->
     <div style="display:none">&nbsp;</div>
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="id">amd_details</xsl:with-param>
       <xsl:with-param name="type">textarea</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:call-template name="textarea-field">
         <xsl:with-param name="name">amd_details</xsl:with-param>
         <xsl:with-param name="rows">10</xsl:with-param>
         <xsl:with-param name="cols">50</xsl:with-param>
         <xsl:with-param name="maxlines">35</xsl:with-param>
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
       <xsl:with-param name="name">subtnxtype</xsl:with-param>
       <xsl:with-param name="value">05</xsl:with-param>
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
  </xsl:template>
</xsl:stylesheet>