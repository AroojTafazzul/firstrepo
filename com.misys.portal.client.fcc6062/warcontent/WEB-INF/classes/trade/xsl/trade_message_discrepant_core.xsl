<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for trade message discrepant, customer side.

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
		exclude-result-prefixes="xmlRender localization securitycheck utils security">

  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:import href="../../core/xsl/report/report.xsl"/>
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="Goods_description"/>
  <xsl:param name="Documents_required"/>
  <xsl:param name="Additional_Conditions"/>
  <xsl:param name="Amendment_Narrative"/>
  <xsl:param name="Discrepant_Details"/>
  
  <!-- These params are empty for trade message -->
  <xsl:param name="realform-action"/>
  <xsl:param name="product-code"/>
  
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  
  <xsl:template match="/">
   <xsl:apply-templates/>
  </xsl:template>
   
  <!-- 
   TRADE MESSAGE DISCREPANT TNX FORM TEMPLATE.
  -->
  <xsl:template match="lc_tnx_record | si_tnx_record">
   <xsl:variable name="product-code"><xsl:value-of select="product_code"/></xsl:variable>
   <!-- Lower case product code -->
   <xsl:variable name="lowercase-product-code">
    <xsl:value-of select="translate($product-code,$up,$lo)"/>
   </xsl:variable>

   <xsl:variable name="screen-name">
    <xsl:choose>
     <xsl:when test="product_code[.='LC']">LetterOfCreditScreen</xsl:when>
     <xsl:when test="product_code[.='SI']">StandbyIssuedScreen</xsl:when>
    </xsl:choose>
   </xsl:variable>
   <xsl:variable name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$screen-name"/></xsl:variable>
  
	<xsl:variable name="helpKey">
    <xsl:choose>
     <xsl:when test="product_code[.='LC']">LC_12</xsl:when>
     <xsl:when test="product_code[.='SI']">SI_02</xsl:when>
    </xsl:choose>
   </xsl:variable>  
  
  
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
       <xsl:with-param name="node-name" select="name(.)"/>
       <xsl:with-param name="screen-name" select="$screen-name"/>
       <xsl:with-param name="show-template">N</xsl:with-param>
       <xsl:with-param name="show-return">Y</xsl:with-param>
      </xsl:call-template>
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
     
      <xsl:call-template name="hidden-fields">
       <xsl:with-param name="lowercase-product-code" select="$lowercase-product-code"/>
      </xsl:call-template>
      
      <!-- Hidden cross references -->
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      
      <xsl:call-template name="general-details" />
      
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
      
       <div id="bankInst">
        <xsl:call-template name="bank-instructions">
         <xsl:with-param name="send-mode-required">N</xsl:with-param>
         <xsl:with-param name="send-mode-displayed">N</xsl:with-param>
         <xsl:with-param name="principal-acc-displayed">N</xsl:with-param>
         <xsl:with-param name="fee-acc-displayed">N</xsl:with-param>
         <xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
         <xsl:with-param name="free-format-text-displayed">N</xsl:with-param>
         <xsl:with-param name="is-toc-item">N</xsl:with-param>
        </xsl:call-template>
      </div>
       <xsl:variable name="isMT798"><xsl:value-of select="is_MT798"/></xsl:variable>
      <xsl:call-template name="message-freeformat">
        <xsl:with-param name="mt798enabled"><xsl:value-of select="$isMT798"/></xsl:with-param>
   		  <xsl:with-param name="type">DISCREPANT</xsl:with-param>
        </xsl:call-template>
      
      <!-- comments for return - currently making only for LC and SI-->
    <xsl:if test="product_code[.='LC' or .='SI'] and tnx_stat_code[.!='03' and .!='04']">    <!-- MPS-43899 -->
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
    		<xsl:with-param name="callback">if(misys._config.customerBanksMT798Channel[dijit.byId("issuing_bank_abbv_name").get("value")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01'){dijit.byId("delivery_channel").set("disabled", false); dijit.byId("delivery_channel").set("required", true);dijit.byId("delivery_channel").set("readOnly", false);misys.toggleFields(true, null, ["delivery_channel"], false, false);}</xsl:with-param>
    		<xsl:with-param name="title-size">35</xsl:with-param>
    	</xsl:call-template>
    </xsl:if>	
    
    <!-- Message realform. -->
    <xsl:call-template name="realform">
     <xsl:with-param name="action" select="$action"/>
    </xsl:call-template>

	<!-- Reauthentication -->
      <xsl:call-template name="reauthentication"/>

    <xsl:call-template name="menu">
     <xsl:with-param name="node-name" select="name(.)"/>
     <xsl:with-param name="screen-name" select="$screen-name"/>
     <xsl:with-param name="show-template">N</xsl:with-param>
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
   
   <!--  Collaboration Window -->     
   <xsl:call-template name="collaboration">
    <xsl:with-param name="editable">true</xsl:with-param>
    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
   </xsl:call-template>
   
   <!-- Javascript imports -->
   <xsl:call-template name="js-imports"> 
    <xsl:with-param name="product-code" select="$product-code"/>
    <xsl:with-param name="lowercase-product-code" select="$lowercase-product-code"/>
    <xsl:with-param name="action" select="$action"/>
    <xsl:with-param name="help-key" select="$helpKey"/>
   </xsl:call-template>
  </xsl:template>

  <!--                                     -->  
  <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
  <!--                                     -->

  <xsl:template name="js-imports">
   <xsl:param name="product-code"/>
   <xsl:param name="action"/>
   <xsl:param name="lowercase-product-code"/>
   <xsl:param name="help-key"/>

   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.trade.message_discrepant</xsl:with-param>
    <xsl:with-param name="override-product-code" select="$product-code"/>
    <xsl:with-param name="override-lowercase-product-code" select="$lowercase-product-code"/>
    <xsl:with-param name="override-action" select="$action"/>
    <xsl:with-param name="override-help-access-key" select="$help-key"/>
   </xsl:call-template>
  </xsl:template>

  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <xsl:param name="lowercase-product-code"/>
   <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="show-type">N</xsl:with-param>
   </xsl:call-template>
   <div class="widgetContainer">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
     <xsl:with-param name="value" select="issuing_bank/abbv_name"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">issuing_bank_name</xsl:with-param>
     <xsl:with-param name="value" select="issuing_bank/name"/>
    </xsl:call-template> 
    <xsl:if test="entity[. != '']">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">entity</xsl:with-param>
    </xsl:call-template>
   </xsl:if>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">lc_cur_code</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">lc_amt</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">maturity_date</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">imp_bill_ref_id</xsl:with-param>
    </xsl:call-template>
    
    <!--Empty the principal and fee accounts-->
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">principal_act_no</xsl:with-param>
     <xsl:with-param name="value"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_act_no</xsl:with-param>
     <xsl:with-param name="value"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">adv_send_mode</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="adv_send_mode"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">product_code</xsl:with-param>				
	</xsl:call-template>
	  <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">prod_stat_code</xsl:with-param>
      <xsl:with-param name="value"></xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">disposal_instruction_notification</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'DISPOSAL_INSTRUCTION_NOTIFICATION')"/></xsl:with-param>
    </xsl:call-template>
   </div>
  </xsl:template>

  <!-- General Details. -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="button-type">
     <xsl:choose>
      <xsl:when test="count(cross_references/cross_reference[child_tnx_id = ../../tnx_id]/type_code[.='01']) &gt; 0">crossref-summary</xsl:when>
      <xsl:otherwise>summary-details</xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="content">
     <!--  System ID. -->
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
      <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
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
       <xsl:with-param name="id">general_cust_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="cust_ref_id" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">cust_ref_id</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
   
     <!-- Bank Reference -->
     <xsl:if test="bo_ref_id[.!='']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
       <xsl:with-param name="id">general_bo_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="bo_ref_id" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">bo_ref_id</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
   
     <!-- Issue Date -->
     <xsl:if test="iss_date[.!='']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
       <xsl:with-param name="id">iss_date_view</xsl:with-param>
       <xsl:with-param name="value" select="iss_date" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">iss_date</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     
     <!-- Exp Date -->
     <xsl:if test="exp_date[.!='']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
       <xsl:with-param name="id">exp_date_view</xsl:with-param>
       <xsl:with-param name="value" select="exp_date" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">exp_date</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
    
    <!-- Discrepancy Response -->
    <xsl:if test="product_code[.!='LC']"> 
      <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_DISCREPANCY_RESPONSE</xsl:with-param>
      <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
	    <xsl:when test="$displaymode='edit'">
	       <option value ="">
	       </option> 
		   <option value="08">
		    <xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/>
		   </option>
	       <option value="09">
	        <xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/>
	       </option>
	    </xsl:when>
	    <xsl:otherwise>
	     <xsl:choose>
          <xsl:when test="sub_tnx_type_code[.='08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/></xsl:when>
          <xsl:when test="sub_tnx_type_code[.='09']"><xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/></xsl:when>
         </xsl:choose>
	    </xsl:otherwise>
	   </xsl:choose>
      </xsl:with-param>
     </xsl:call-template> 
     </xsl:if>
     
     <xsl:if test="tnx_type_code[.!='24']">
	      <xsl:if test="product_code[.='LC']">
	      <xsl:if test="claim_reference!=''">
	          <xsl:call-template name="input-field">
	           <xsl:with-param name="label">XSL_CLAIM_REFERENCE_LABEL</xsl:with-param>
	           <xsl:with-param name="value"><xsl:value-of select="claim_reference"/></xsl:with-param>
	           <xsl:with-param name="override-displaymode">view</xsl:with-param>
	          </xsl:call-template>
	      </xsl:if>
	      <xsl:if test="linked_event_reference!=''">
	          <xsl:call-template name="input-field">
	           <xsl:with-param name="label">XSL_LINKED_EVENT_REFERENCE_LABEL</xsl:with-param>
	           <xsl:with-param name="value"><xsl:value-of select="linked_event_reference"/>
	           </xsl:with-param>
	           <xsl:with-param name="override-displaymode">view</xsl:with-param>
	          </xsl:call-template>
	      </xsl:if>
	      <xsl:if test="claim_present_date!=''">
	          <xsl:call-template name="input-field">
	           <xsl:with-param name="label">XSL_CLAIM_PRESENT_DATE_LABEL</xsl:with-param>
	           <xsl:with-param name="value"><xsl:value-of select="claim_present_date"/> </xsl:with-param>
	           <xsl:with-param name="override-displaymode">view</xsl:with-param>
	          </xsl:call-template>
	      </xsl:if>
	      <xsl:if test="claim_amt!=''">
	          <xsl:call-template name="input-field">
	           <xsl:with-param name="label">XSL_CLAIM_AMOUNT_LABEL</xsl:with-param>
	           <xsl:with-param name="value"><xsl:value-of select="claim_cur_code"/>&nbsp;<xsl:value-of select="claim_amt"/>
	           </xsl:with-param>
	           <xsl:with-param name="override-displaymode">view</xsl:with-param>
	          </xsl:call-template>
	      </xsl:if>
			<xsl:if test="(bo_comment[.!=''] and product_code[.='LC'])">
				<xsl:call-template name="big-textarea-wrapper">
					<xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT_BANK</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content" style="font:13px Arial, Helvetica, sans-serif;">
							<xsl:value-of select="bo_comment" />
						</div>
					</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
	
	      </xsl:if>
	      </xsl:if>
	      
     <xsl:if test="product_code[.='LC']">
     <xsl:variable name="radio-value" select="sub_tnx_type_code"/>
     <xsl:call-template name="multioption-inline-wrapper">
		      <xsl:with-param name="group-label">XSL_GENERALDETAILS_DISCREPANCY_RESPONSE</xsl:with-param>
		      <xsl:with-param name="show-required-prefix"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
		      <xsl:with-param name="content">
			        <xsl:call-template name="multichoice-field">
	   			      <xsl:with-param name="group-label">XSL_GENERALDETAILS_DISCREPANCY_RESPONSE</xsl:with-param>
					  <xsl:with-param name="label">XSL_DISCREPANCY_RESPONSE_AGREE_TO_PAY</xsl:with-param>
				      <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
				      <xsl:with-param name="id">disposal_instruction_accept</xsl:with-param>
				      <xsl:with-param name="value">08</xsl:with-param>
				       <xsl:with-param name="type">radiobutton</xsl:with-param>
				       <xsl:with-param name="checked"><xsl:if test="$radio-value = '08'">Y</xsl:if></xsl:with-param>
				      <xsl:with-param name="inline">Y</xsl:with-param>
				      <xsl:with-param name="disabled">N</xsl:with-param> 
				      <!-- <xsl:with-param name="show-required-prefix">N</xsl:with-param> -->
				     </xsl:call-template>
				     <xsl:call-template name="multichoice-field">
	   			      <xsl:with-param name="group-label">XSL_GENERALDETAILS_DISCREPANCY_RESPONSE</xsl:with-param>
					  <xsl:with-param name="label">XSL_DISCREPANCY_RESPONSE_HOLD_THE_DOCUMENT</xsl:with-param>
				      <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
				      <xsl:with-param name="id">disposal_instruction_hold</xsl:with-param>
				      <xsl:with-param name="value">09</xsl:with-param>
				      <xsl:with-param name="type">radiobutton</xsl:with-param>
				      <xsl:with-param name="checked"><xsl:if test="$radio-value = '09'">Y</xsl:if></xsl:with-param>
				      <xsl:with-param name="inline">Y</xsl:with-param>
				      <xsl:with-param name="disabled">N</xsl:with-param>
				      <!-- <xsl:with-param name="show-required-prefix">N</xsl:with-param> -->
				     </xsl:call-template>
		    	</xsl:with-param>
	    </xsl:call-template>
		</xsl:if>
	     
     </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!--
   Hidden fields for Message
   -->
  <xsl:template name="realform">
   <xsl:param name="action"/>
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="method">POST</xsl:with-param>
    <xsl:with-param name="action" select="$action"/>
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
       <xsl:with-param name="value">13</xsl:with-param>
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