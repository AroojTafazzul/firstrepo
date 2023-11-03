<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Bankers Guarantee (BG) Amendment Form, Customer Side
 
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
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xd="http://www.pnp-software.com/XSLTdoc" 
        xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"   		
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
  <xsl:param name="product-code">BG</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/BankerGuaranteeScreen</xsl:param>
  <xsl:param name="Goods_description"/>
  <xsl:param name="Documents_required"/>
  <xsl:param name="Additional_Conditions"/>
  <xsl:param name="Amendment_Narrative"/>
  <xsl:param name="Discrepant_Details"/>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/amend_common.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  <xsl:include href="../../core/xsl/common/ls_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="bg_tnx_record"/>
  </xsl:template>
  
  <!-- 
   BG AMEND TNX FORM TEMPLATE.
  -->
  <xsl:template match="bg_tnx_record">
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
     
      <xsl:call-template name="hidden-fields"/>
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="general-details"/>
      <xsl:call-template name="bg-amend-amt-details">
      	<xsl:with-param name="show-os-amt">Y</xsl:with-param>
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
		      <xsl:if test="//limit_details/limit_reference[.!='']">
		       <xsl:call-template name="build-facility-data"/> 
		       <div id = "facilityLimitDetail" class="widgetContainer">
		   	  	<xsl:call-template name="facility-limit-section">
			  	  	<xsl:with-param name="isBank">Y</xsl:with-param>
			  	</xsl:call-template>
			  	<xsl:call-template name="hidden-field">
			  		<xsl:with-param name="name">orginal_facility_id</xsl:with-param>
			  		<xsl:with-param name="value"  select="//limit_details/facility_id"/>
			  	</xsl:call-template>
			  	<xsl:call-template name="hidden-field">
			  		<xsl:with-param name="name">orginal_limit_id</xsl:with-param>
			  		<xsl:with-param name="value" select="//limit_details/limit_id"/>
			  	</xsl:call-template>
			  	</div>
		  	 </xsl:if>
	   	 </xsl:otherwise>
   	 </xsl:choose>
   	 <xsl:choose>
   	 <xsl:when test="$displaymode = 'edit'">
   	 <xsl:call-template name="amend-renewal-details"/>
   	 </xsl:when> 
   	 <xsl:when test="$displaymode = 'view' and $mode = 'UNSIGNED'">
   	 <xsl:if test="renew_flag[.='Y']">
      <xsl:call-template name="amend-renewal-details"/>
      </xsl:if>
   	 </xsl:when>
   	 <xsl:when test="$displaymode = 'view' and $mode != 'UNSIGNED'">
      <xsl:call-template name="amend-renewal-details"/>
   	 </xsl:when>
   	 </xsl:choose>

        <xsl:call-template name="bg-amend-contract-details"/>      
      
      <xsl:if test="securitycheck:hasPermission($rundata,'ls_access') = 'true' and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true'">
			<xsl:call-template name="linked-ls-declaration"/>
	 		<xsl:call-template name="linked-licenses"/>
	  </xsl:if>
       <xsl:call-template name="amend-narrative"/>
      <xsl:call-template name="bank-instructions">
       <xsl:with-param name="send-mode-label">XSL_INSTRUCTIONS_AMD_ADV_SEND_MODE_LABEL</xsl:with-param>
       <xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
      </xsl:call-template>
      <!-- Reauthentication -->
      <xsl:call-template name="reauthentication"/>
      
      <!-- Charges (hidden section) -->
      <!-- <xsl:for-each select="charges/charge">
       <xsl:call-template name="charge-details-hidden"/>
      </xsl:for-each> -->
      
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
     <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
    	<xsl:call-template name="attachments-file-dojo">
    		<xsl:with-param name="callback">misys.toggleFields(misys._config.customerBanksMT798Channel[dijit.byId("recipient_bank_abbv_name").get("value")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01', null, ["delivery_channel"], false, false)</xsl:with-param>
    		<xsl:with-param name="title-size">35</xsl:with-param>
    	</xsl:call-template>   
    </xsl:if>

    <xsl:call-template name="realform"/>

    <xsl:call-template name="menu">
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
     <xsl:with-param name="show-return">Y</xsl:with-param>
    </xsl:call-template>
   </div>
    
   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>

   <!--  Collaboration Window -->     
   <xsl:call-template name="collaboration">
    <xsl:with-param name="editable">true</xsl:with-param>
    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    <xsl:with-param name="bank_name_widget_id">recipient_bank_name</xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id">recipient_bank_abbv_name</xsl:with-param>
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
   <xsl:with-param name="binding">misys.binding.trade.amend_bg</xsl:with-param>
   <xsl:with-param name="override-help-access-key">BG_03</xsl:with-param>
  </xsl:call-template>
 </xsl:template>

 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields"/>
  <div class="widgetContainer">
  <xsl:call-template name="localization-dialog"/>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">recipient_bank_abbv_name</xsl:with-param>
    <xsl:with-param name="value" select="recipient_bank/abbv_name"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">recipient_bank_name</xsl:with-param>
    <xsl:with-param name="value" select="recipient_bank/name"/>
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
   </xsl:if>
   <!-- <xsl:call-template name="hidden-field">
   <xsl:with-param name="name">beneficiary_name</xsl:with-param>
   <xsl:with-param name="value"><xsl:value-of select="beneficiary_name"/></xsl:with-param>
  </xsl:call-template> -->
  <xsl:call-template name="hidden-field">
   <xsl:with-param name="name">applicant_name</xsl:with-param>
   <xsl:with-param name="value"><xsl:value-of select="applicant_name"/></xsl:with-param>
  </xsl:call-template>
  </div>
 </xsl:template>

 <!--
   BG General Details Fieldset.
    
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
        <xsl:with-param name="name">bo_ref_id</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">iss_date</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">org_exp_date</xsl:with-param>
        <xsl:with-param name="value" select="org_previous_file/bg_tnx_record/exp_date"/>
       </xsl:call-template>
      </xsl:if>

      <!--  System ID. -->
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
       <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="ref_id" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
       <xsl:with-param name="id">general_bo_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="bo_ref_id" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      
      <!-- Start Date. -->
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_START_DATE_TYPE</xsl:with-param>
       <xsl:with-param name="name">iss_date_type_code</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:choose>
         <xsl:when test="iss_date_type_code[. = '01']">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ISSUANCE')"/>
         </xsl:when>
         <xsl:when test="iss_date_type_code[. = '02']">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_CONTRACT_SIGN')"/>
         </xsl:when>
         <xsl:when test="iss_date_type_code[. = '03']">
          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ADV_PAYMT')"/>
         </xsl:when>
         <xsl:when test="iss_date_type_code[. = '99']">
          <xsl:value-of select="iss_date_type_details"/>
         </xsl:when>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
      <xsl:with-param name="id">iss_date_view</xsl:with-param>
      <xsl:with-param name="value" select="iss_date" />
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     
     <!--  -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_ORG_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="id">exp_date_type_code_view</xsl:with-param>
      <xsl:with-param name="value">
       <xsl:choose>
       <xsl:when test="org_previous_file/bg_tnx_record/exp_date_type_code[. = '02']">
         <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_FIXED')"/>
       </xsl:when>
       <xsl:when test="org_previous_file/bg_tnx_record/exp_date_type_code[. = '03']">
         <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_ESTIMATED')"/>
       </xsl:when>
       <xsl:when test="org_previous_file/bg_tnx_record/exp_date_type_code[. = '01']">
         <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_NONE')"/>
       </xsl:when>
       <xsl:otherwise></xsl:otherwise>
     </xsl:choose>
      <xsl:if test="org_previous_file/bg_tnx_record/exp_date[.!='']">
       	  (<xsl:value-of select="org_previous_file/bg_tnx_record/exp_date"/>)
       </xsl:if>
      </xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     
     <!-- <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="name">exp_date_type_code</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:call-template name="bg-exp-dates"/>
      </xsl:with-param>
     </xsl:call-template> -->
   <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
       <xsl:with-param name="name">exp_date_type_code</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:call-template name="bg-exp-dates"/>
      </xsl:with-param>
     </xsl:call-template>
	 <xsl:choose>
     <xsl:when test ="exp_date_type_code[.!='01'] and ((org_previous_file/bg_tnx_record/exp_date[.!=''] and exp_date[.!=''] and not(org_previous_file/bg_tnx_record/exp_date=exp_date)) or exp_date[.!=''] ) ">
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">exp_date</xsl:with-param>
      <xsl:with-param name="value" select="exp_date" />
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="required">N</xsl:with-param>
     </xsl:call-template>
     </xsl:when>
      <xsl:when test ="exp_date_type_code[.!='01']">
      <xsl:call-template name="input-field">
      <xsl:with-param name="name">exp_date</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/bg_tnx_record/exp_date" />
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="required">N</xsl:with-param>
     </xsl:call-template> 
     </xsl:when>
     <xsl:otherwise>
      <xsl:call-template name="input-field">
      <xsl:with-param name="name">exp_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="required">N</xsl:with-param>
     </xsl:call-template> 
     </xsl:otherwise>
     </xsl:choose>
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
        <xsl:with-param name="messageValue"><xsl:value-of select="exp_event"/></xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
   </xsl:call-template>
    
     <!-- Amendment Date -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>
      <xsl:with-param name="name">amd_date</xsl:with-param>
      <xsl:with-param name="value" select="amd_date" />
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
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
   BG Amend Amount Details
   -->
  <xsl:template name="bg-amend-amt-details">
  	<xsl:param name="show-os-amt">N</xsl:param>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_GTEE_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">bg</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name">org_bg_amt</xsl:with-param>
      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
      <xsl:with-param name="override-amt-value"><xsl:value-of select="org_previous_file/bg_tnx_record/bg_amt"/></xsl:with-param>
     </xsl:call-template>
     <div>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">bg_cur_code</xsl:with-param>
      </xsl:call-template>
     </div>
    
     <!-- Increase / Decrease Amt -->
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_INC_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">bg</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name">inc_amt</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_DEC_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">bg</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name">dec_amt</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_NEW_GTEE_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">bg</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
     </xsl:call-template>
     <!-- Not required anymore, done the the Release specific screen 
     <xsl:call-template name="checkbox-field">
      <xsl:with-param name="name">bg_release_flag</xsl:with-param>
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_GTEE_RELEASE</xsl:with-param>
     </xsl:call-template>
     -->
     <xsl:if test="$show-os-amt='Y'">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="name">bg_liab_amt</xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="org_previous_file/bg_tnx_record/bg_cur_code"/>&nbsp;<xsl:value-of select="org_previous_file/bg_tnx_record/bg_liab_amt"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_bg_liab_amt</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="org_previous_file/bg_tnx_record/bg_liab_amt"/></xsl:with-param>  
      </xsl:call-template>
     </xsl:if>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
 	<xd:doc>
		<xd:short>Contract details section.</xd:short>
		<xd:detail>
			This template constructs contract details, this intern calls template guarantee-references-options
			for building the contract options.
		</xd:detail>
		<xd:param name="show-amddetails">if displaymode is view value is Y else N</xd:param>
	</xd:doc>
    <xsl:template name="bg-amend-contract-details"> 
     <xsl:param name="tnx-record" select="org_previous_file/bg_tnx_record"/> 
    <xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
    <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_CONTRACT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
        <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_ORG_GTEEDETAILS_CONTRACT_REF_LABEL</xsl:with-param>
       <xsl:with-param name="id">org_contract_ref</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:choose>
         <xsl:when test="$tnx-record/contract_ref!=''"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,'C051', $tnx-record/contract_ref)"/></xsl:when>
         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>   
      <xsl:if test= "$displaymode != 'edit' and $mode = 'UNSIGNED'">
       <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_NEW_GTEEDETAILS_CONTRACT_REF_LABEL</xsl:with-param>
       <xsl:with-param name="id">contract_ref</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:choose>
         <xsl:when test="contract_ref!=''"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,'C051', contract_ref)"/></xsl:when>
         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template> 
      </xsl:if>
      <xsl:choose>
	     	 <xsl:when test="$displaymode='edit'">
		       <xsl:call-template name="select-field">
			       <xsl:with-param name="label">XSL_NEW_GTEEDETAILS_CONTRACT_REF_LABEL</xsl:with-param>
			       <xsl:with-param name="name">contract_ref</xsl:with-param>
			       <xsl:with-param name="fieldsize">small</xsl:with-param>
			       <xsl:with-param name="options">
			       <xsl:call-template name="guarantee-references-options"/>
			       </xsl:with-param>
	     	   </xsl:call-template>
	     	 </xsl:when>
	     	 <xsl:when test="revolve_frequency[.!=''] and $displaymode='view'">
		     	 <xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_NEW_GTEEDETAILS_CONTRACT_REF_LABEL</xsl:with-param>
				     <xsl:with-param name="name">contract_ref</xsl:with-param>
				     <xsl:with-param name="fieldsize">small</xsl:with-param>
				     <xsl:with-param name="value">
				     	<xsl:value-of select="localization:getDecode($language,'*',$productCode,'C051', contract_ref)"/>
				     </xsl:with-param>
		     	  </xsl:call-template>
	     	 </xsl:when>
     	 </xsl:choose>
   	   <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_ORG_CONTRACT_NARRATIVE</xsl:with-param>
       <xsl:with-param name="id">org_contract_narrative</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:choose>
         <xsl:when test="$tnx-record/contract_narrative!=''"><xsl:value-of select="$tnx-record/contract_narrative"/></xsl:when>
         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_NEW_CONTRACT_NARRATIVE</xsl:with-param>
       	<xsl:with-param name="name">contract_narrative</xsl:with-param>
	       <xsl:with-param name="size">35</xsl:with-param>
	       <xsl:with-param name="maxsize">35</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_ORG_GTEEDETAILS_CONTRACT_DATE_LABEL</xsl:with-param>
       <xsl:with-param name="id">org_contract_date</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:choose>
         <xsl:when test="$tnx-record/contract_date!=''"><xsl:value-of select="$tnx-record/contract_date"/></xsl:when>
         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
	       <xsl:with-param name="name">contract_date</xsl:with-param>
	       <xsl:with-param name="label">XSL_NEW_GTEEDETAILS_CONTRACT_DATE_LABEL</xsl:with-param>
	       <xsl:with-param name="fieldsize">small</xsl:with-param>
	       <xsl:with-param name="size">10</xsl:with-param>
	       <xsl:with-param name="maxsize">10</xsl:with-param>
	       <xsl:with-param name="readonly">N</xsl:with-param>
	       <xsl:with-param name="type">date</xsl:with-param>
	     </xsl:call-template>

    <div id="tender-exp-date">
    <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_ORG_TENDER_EXP_DATE_LABEL</xsl:with-param>
       <xsl:with-param name="id">org_tender_expiry_date</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:choose>
         <xsl:when test="$tnx-record/tender_expiry_date!=''"><xsl:value-of select="$tnx-record/tender_expiry_date"/></xsl:when>
         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
	       <xsl:with-param name="name">tender_expiry_date</xsl:with-param>
	       <xsl:with-param name="label">XSL_NEW_TENDER_EXP_DATE_LABEL</xsl:with-param>
	       <xsl:with-param name="fieldsize">small</xsl:with-param>
	       <xsl:with-param name="size">10</xsl:with-param>
	       <xsl:with-param name="maxsize">10</xsl:with-param>
	       <xsl:with-param name="readonly">N</xsl:with-param>
	       <xsl:with-param name="type">date</xsl:with-param>
	  </xsl:call-template>
     </div>
		 <xsl:choose>
       <xsl:when test="$tnx-record/contract_amt[.!='']">
	        <xsl:call-template name="currency-field">
			      <xsl:with-param name="label">XSL_ORG_GTEEDETAILS_CONTRACT_AMT_LABEL</xsl:with-param>
			      <xsl:with-param name="override-currency-name">org_contract_cur_code</xsl:with-param>
			      <xsl:with-param name="override-amt-name">org_contract_amt</xsl:with-param>
			      <xsl:with-param name="product-code">contract</xsl:with-param>
		     	 <xsl:with-param name="override-amt-value"><xsl:value-of select ="$tnx-record/contract_amt"/></xsl:with-param>
		     	 <xsl:with-param name="override-currency-value"><xsl:value-of select ="$tnx-record/contract_cur_code"/></xsl:with-param>
		     	 <xsl:with-param name="show-button">N</xsl:with-param>
		     	 <xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
		     	 <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
    	 	</xsl:call-template>
	   </xsl:when>
	   <xsl:otherwise>
	   <xsl:call-template name="input-field">
      	  <xsl:with-param name="label">XSL_ORG_GTEEDETAILS_CONTRACT_AMT_LABEL</xsl:with-param>
	      <xsl:with-param name="name">org_contract_amt</xsl:with-param>
	      <xsl:with-param name="override-displaymode">view</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:with-param>
	   </xsl:call-template>
	   </xsl:otherwise>
	  </xsl:choose> 
      <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_NEW_GTEEDETAILS_CONTRACT_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="override-currency-name">contract_cur_code</xsl:with-param>
      <xsl:with-param name="override-amt-name">contract_amt</xsl:with-param>
      <xsl:with-param name="product-code">contract</xsl:with-param>
     </xsl:call-template>
       
 	<xsl:call-template name="input-field">
      	  <xsl:with-param name="label">XSL_ORG_GTEEDETAILS_CONTRACT_PCT_LABEL</xsl:with-param>
	      <xsl:with-param name="name">org_contract_pct</xsl:with-param>
	      <xsl:with-param name="fieldsize">small</xsl:with-param>
	      <xsl:with-param name="override-displaymode">view</xsl:with-param>
	      <xsl:with-param name="value">
	      <xsl:choose>
         <xsl:when test="$tnx-record/contract_pct!=''"><xsl:value-of select="$tnx-record/contract_pct"/></xsl:when>
         <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NO_VALUE')"/></xsl:otherwise>
        </xsl:choose></xsl:with-param>
     </xsl:call-template>
		<xsl:call-template name="input-field">
     	  <xsl:with-param name="label">XSL_NEW_GTEEDETAILS_CONTRACT_PCT_LABEL</xsl:with-param>
	      <xsl:with-param name="name">contract_pct</xsl:with-param>
	      <xsl:with-param name="type">number</xsl:with-param>
	      <xsl:with-param name="size">13</xsl:with-param>
	      <xsl:with-param name="maxsize">13</xsl:with-param>
	      <xsl:with-param name="fieldsize">small</xsl:with-param>
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
      <xsl:call-template name="e2ee_transaction"/>
      <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
</xsl:stylesheet>