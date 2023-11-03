<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Bankers Guarantee (BG) Release Form, Customer Side
 
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
        exclude-result-prefixes="localization">
        
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
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  
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
      <xsl:call-template name="bg-release-amt-details"/>
      <xsl:call-template name="bg_amend-narrative"/>
      <div id="bankInst">
	      <xsl:call-template name="bank-instructions">
	       <xsl:with-param name="send-mode-displayed">N</xsl:with-param>
	       <xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
	      </xsl:call-template>
      </div>
      <xsl:if test="tnx_stat_code[.!='03' and .!='04']">   <!-- MPS-43899 -->
       <xsl:call-template name="comments-for-return">
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
   	  </xsl:if>

      <!-- Reauthentication -->
      <xsl:call-template name="reauthentication"/>

      <!-- Charges (hidden section) -->
      <xsl:for-each select="charges/charge">
       <xsl:call-template name="charge-details-hidden"/>
      </xsl:for-each>
      </xsl:with-param>
    </xsl:call-template>

    <!-- Form #1 : Attach Files -->
    <xsl:call-template name="attachments-file-dojo">
   		<!-- <xsl:with-param name="callback">if(misys._config.customerBanksMT798Channel[dijit.byId("recipient_bank_abbv_name").get("value")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01'){dijit.byId("delivery_channel").set("disabled", false); dijit.byId("delivery_channel").set("required", true);dijit.byId("delivery_channel").set("readOnly", false);}</xsl:with-param> -->
   		<xsl:with-param name="callback">misys.toggleFields(misys._config.customerBanksMT798Channel[dijit.byId("recipient_bank_abbv_name").get("value")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01', null, ["delivery_channel"], false, false)</xsl:with-param>
   		<xsl:with-param name="title-size">35</xsl:with-param>
   	</xsl:call-template>

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
   <xsl:with-param name="binding">misys.binding.trade.release_bg</xsl:with-param>
  </xsl:call-template>
 </xsl:template>

 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields"/>
  <div class="widgetContainer">
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
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">org_exp_date_type_code</xsl:with-param>
        <xsl:with-param name="value" select="org_previous_file/bg_tnx_record/exp_date_type_code"/>
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
       </xsl:choose>
       <xsl:if test="org_previous_file/bg_tnx_record/exp_date[.!='']">
       (<xsl:value-of select="org_previous_file/bg_tnx_record/exp_date"/>)
       </xsl:if>
      </xsl:with-param>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
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
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- 
   BG Amend Amount Details
   -->
  <xsl:template name="bg-release-amt-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="checkbox-field">
      <xsl:with-param name="name">bg_release_flag</xsl:with-param>
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_GTEE_RELEASE_FULL</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_GTEE_RELEASE_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">bg</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name">release_amt</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <!-- <xsl:with-param name="amt-readonly">Y</xsl:with-param> -->
      <xsl:with-param name="override-amt-value"><xsl:value-of select="release_amt"/></xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">bg</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name">bg_os_amt</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
      <xsl:with-param name="override-amt-value"><xsl:value-of select="org_bg_liab_amt"/></xsl:with-param>
     </xsl:call-template>
     <div>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">bg_cur_code</xsl:with-param>
      </xsl:call-template>
     <!-- <xsl:if test="$displaymode='edit'">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_bg_liab_amt</xsl:with-param>
      </xsl:call-template>
     </xsl:if> -->
     </div>
     
     <div id="org-bg-lib-amt">
     <xsl:if test="$displaymode='edit'">
      <!-- <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">org_lc_liab_amt</xsl:with-param>
      </xsl:call-template> -->
      <xsl:call-template name="currency-field">
      <xsl:with-param name="product-code">bg</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name">org_bg_liab_amt</xsl:with-param>
      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
      <xsl:with-param name="override-amt-value"><xsl:value-of select="org_bg_liab_amt"/></xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     </div>

    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="bg_amend-narrative">
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
        </xsl:call-template>
       </xsl:with-param>
      </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!--
   Hidden fields for Banker Guarantee
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
  
  <!--
   Bank customer communication channel (MT798 or standard). 
   -->
 <xsl:template match="main_bank/bank" mode="customer_banks_communication_channel">
    misys._config.customerBanksMT798Channel['<xsl:value-of select="abbv_name"/>'] = <xsl:value-of select="@mt798_enabled"/>;
 </xsl:template>
</xsl:stylesheet>