<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for trade message clean, customer side, Client specific.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/20/2013
author:    Aneesh
email:     aneesh.ph@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		exclude-result-prefixes="localization">

  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="option"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  
  <!-- These params are empty for trade message -->
  <xsl:param name="realform-action"/>
  <xsl:param name="product-code"/>
  
  <!-- Global Imports. -->
   <!-- TODO This still points to the Client trade_common.xsl. 
   Is this still necessary? -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/fx_common.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  
  <xsl:template match="/">
   <xsl:apply-templates/>
  </xsl:template>
  
  <!-- 
   TRADE MESSAGE CLEAN TNX FORM TEMPLATE.
  -->
  <xsl:template match="br_tnx_record">
   <xsl:variable name="product-code"><xsl:value-of select="product_code"/></xsl:variable>
   <!-- Lower case product code -->
   <xsl:variable name="lowercase-product-code">
    <xsl:value-of select="translate($product-code,$up,$lo)"/>
   </xsl:variable>

   <xsl:variable name="screen-name">
    <xsl:choose>
     <xsl:when test="product_code[.='BR']">GuaranteeReceivedScreen</xsl:when>
    </xsl:choose>
   </xsl:variable>
   <xsl:variable name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$screen-name"/></xsl:variable>
  
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
   
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
 	 	
	<!-- Reauthentication -->
    
    <xsl:call-template name="server-message">
 		<xsl:with-param name="name">server_message</xsl:with-param>
 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
	 </xsl:call-template>
		 
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
      
      <xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_product/fx_assign_products[.='Y']">
       <xsl:call-template name="fx-template"/>
      </xsl:if> 
      
       <xsl:if test="$displaymode='view' and fx_rates_type and fx_rates_type[.!='']">
		<xsl:call-template name="fx-details-for-view" /> 
 	   </xsl:if>
      
       <xsl:variable name="isMT798"><xsl:value-of select="is_MT798"/></xsl:variable>
      <xsl:call-template name="message-freeformat">
        <xsl:with-param name="mt798enabled"><xsl:value-of select="$isMT798"/></xsl:with-param>
      </xsl:call-template>
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
   		  <!-- <xsl:with-param name="callback">if(misys._config.customerBanksMT798Channel[dijit.byId("advising_bank_abbv_name").get("value")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01'){dijit.byId("delivery_channel").set("disabled", false); dijit.byId("delivery_channel").set("required", true);dijit.byId("delivery_channel").set("readOnly", false);}</xsl:with-param>  -->
   		  <xsl:with-param name="callback">misys.toggleFields(misys._config.customerBanksMT798Channel[dijit.byId("advising_bank_abbv_name").get("value")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01', null, ["delivery_channel"], false, false)</xsl:with-param>
   	      <xsl:with-param name="title-size">35</xsl:with-param>
   	    </xsl:call-template>
    	
    </xsl:if>

    <!-- Message realform. -->
    <xsl:call-template name="realform">
     <xsl:with-param name="action" select="$action"/>
    </xsl:call-template>

	<xsl:call-template name="reauthentication" />

    <xsl:call-template name="menu">
     <xsl:with-param name="node-name" select="name(.)"/>
     <xsl:with-param name="screen-name" select="$screen-name"/>
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
    <xsl:with-param name="bank_name_widget_id">advising_bank_name</xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id">advising_bank_abbv_name</xsl:with-param>
   </xsl:call-template>
  
  <!-- Javascript imports -->
   <xsl:call-template name="js-imports"> 
    <xsl:with-param name="product-code" select="$product-code"/>
    <xsl:with-param name="lowercase-product-code" select="$lowercase-product-code"/>
    <xsl:with-param name="action" select="$action"/>
   </xsl:call-template>
  </xsl:template>

  <!--                                     -->  
  <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
  <!--                                     -->

  <xsl:template name="js-imports">
   <xsl:param name="product-code"/>
   <xsl:param name="action"/>
   <xsl:param name="lowercase-product-code"/>

   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.trade.message_claim</xsl:with-param>
    <xsl:with-param name="override-product-code" select="$product-code"/>
    <xsl:with-param name="override-lowercase-product-code" select="$lowercase-product-code"/>
    <xsl:with-param name="override-action" select="$action"/>
    <xsl:with-param name="override-help-access-key">BR_01</xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <xsl:param name="lowercase-product-code"/>
   <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="show-type">N</xsl:with-param>
    <xsl:with-param name="show-tnx-amt">N</xsl:with-param>
    <xsl:with-param name="additional-fields">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">advising_bank_abbv_name</xsl:with-param>
     <xsl:with-param name="value" select="advising_bank/abbv_name"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">advising_bank_name</xsl:with-param>
     <xsl:with-param name="value" select="advising_bank/name"/>
    </xsl:call-template> 
   <xsl:if test="entity[. != '']">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">entity</xsl:with-param>
    </xsl:call-template>
   </xsl:if>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">tnx_cur_code</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">tnx_amt</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">maturity_date</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">imp_bill_ref_id</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
  		<xsl:with-param name="name">prod_stat_code</xsl:with-param>
 	</xsl:call-template>
    
    <!--Empty the principal and fee accounts
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">principal_act_no</xsl:with-param>
     <xsl:with-param name="value"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_act_no</xsl:with-param>
     <xsl:with-param name="value"/>
    </xsl:call-template>-->
   </xsl:with-param>
   </xsl:call-template>
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
     
    <!--IB Reference -->
     <xsl:if test="ibReference[.!='']">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_IB_REFERENCE_LABEL</xsl:with-param>
       <xsl:with-param name="id">iss_date_view</xsl:with-param>
       <xsl:with-param name="value" select="ibReference" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">ibReference</xsl:with-param>
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

     <xsl:choose>
 		<xsl:when test="$option = 'ACTION_REQUIRED' or sub_tnx_type_code[.='66' or .='67']">
 			<xsl:call-template name="select-field">
		         <xsl:with-param name="label">XSL_GENERALDETAILS_MESSAGE_TYPE</xsl:with-param>
		         <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
		         <xsl:with-param name="required">Y</xsl:with-param>
		         <xsl:with-param name="fieldsize">medium</xsl:with-param>
		         <xsl:with-param name="override-displaymode">
		         	<xsl:value-of select="$displaymode"/>
		         </xsl:with-param>
		         <xsl:with-param name="options">
		          <xsl:choose>
		           <xsl:when test="$displaymode='edit'">
		            <option value="66">
		             <xsl:value-of select="localization:getDecode($language, 'N003', '66')"/>
		            </option>
		            <option value="67">
		             <xsl:value-of select="localization:getDecode($language, 'N003', '67')"/>
		            </option>
		           </xsl:when>
		           <xsl:otherwise>
		            <xsl:choose>
		             <xsl:when test="sub_tnx_type_code[.='66']"><xsl:value-of select="localization:getDecode($language, 'N003', '66')"/></xsl:when>
		             <xsl:when test="sub_tnx_type_code[.='67']"><xsl:value-of select="localization:getDecode($language, 'N003', '67')"/></xsl:when>
		            </xsl:choose>
		           </xsl:otherwise>
		          </xsl:choose>
		         </xsl:with-param>
		    </xsl:call-template>
 		</xsl:when>
 		<xsl:otherwise>
	 		<xsl:call-template name="select-field">
		         <xsl:with-param name="label">XSL_GENERALDETAILS_MESSAGE_TYPE</xsl:with-param>
		         <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
		         <xsl:with-param name="required">Y</xsl:with-param>
		         <xsl:with-param name="fieldsize">medium</xsl:with-param>
		         <xsl:with-param name="override-displaymode">
		         	<xsl:value-of select="$displaymode"/>
		         </xsl:with-param>
		         <xsl:with-param name="options">
		          <xsl:choose>
		           <xsl:when test="$displaymode='edit'">
		          	<option value="24">
		             <xsl:value-of select="localization:getDecode($language, 'N003', '24')"/>
		            </option>
		          	<xsl:if test="product_code[.!='BR']">
		            <option value="25">
		             <xsl:value-of select="localization:getDecode($language, 'N003', '25')"/>
		            </option>
		            </xsl:if>
		           </xsl:when>
		           <xsl:otherwise>
		            <xsl:choose>
		             <xsl:when test="sub_tnx_type_code[.='24']"><xsl:value-of select="localization:getDecode($language, 'N003', '24')"/></xsl:when>
		             <xsl:when test="sub_tnx_type_code[.='25']"><xsl:value-of select="localization:getDecode($language, 'N003', '25')"/></xsl:when>		             
		            </xsl:choose>
		           </xsl:otherwise>
		          </xsl:choose>
		         </xsl:with-param>
		    </xsl:call-template>
	    </xsl:otherwise>
	  </xsl:choose>
      <xsl:if test="$displaymode='view'">
        <xsl:call-template name="hidden-field">
		  	<xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
		  	<xsl:with-param name="value"><xsl:value-of select="sub_tnx_type_code"/></xsl:with-param>
		</xsl:call-template>
      </xsl:if>
     
      <!-- Guarnatee Amount -->
	  <xsl:call-template name="currency-field">
		<xsl:with-param name="label">XSL_AMOUNTDETAILS_GTEE_AMT_LABEL</xsl:with-param>
		<xsl:with-param name="override-currency-value"><xsl:value-of select="bg_cur_code"/></xsl:with-param>          				
		<xsl:with-param name="override-amt-value">
			<xsl:choose>
					<xsl:when test="bg_amt[.!='']">
						<xsl:value-of select="bg_amt" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="tnx_amt" />
					</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
		<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
		<xsl:with-param name="show-button">N</xsl:with-param>
		<xsl:with-param name="required">N</xsl:with-param>
		<xsl:with-param name="product-code">bg</xsl:with-param>
	  </xsl:call-template>
     
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">lc_message_type_clean</xsl:with-param>
       	<xsl:with-param name="value">BillArrivalClean</xsl:with-param>
      </xsl:call-template>
      <div style="display:none;">
	      <xsl:call-template name="currency-field">
			<xsl:with-param name="override-amt-value">
				<xsl:choose>
					<xsl:when test="bg_amt[.!='']">
						<xsl:value-of select="bg_amt" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="tnx_amt" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="override-currency-value"><xsl:value-of select="bg_cur_code"/></xsl:with-param>
			<xsl:with-param name="override-amt-name">bg_amt</xsl:with-param>
			<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
			<xsl:with-param name="show-button">N</xsl:with-param>
			<xsl:with-param name="required">N</xsl:with-param>
			<xsl:with-param name="product-code">bg</xsl:with-param>
		  </xsl:call-template>
	  </div>
	  
	  <xsl:choose>
	  	<xsl:when test="$mode = 'UNSIGNED'">
	  		<xsl:if test="claim_amt != ''">
      		<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_AMOUNTDETAILS_CLAIM_AMT_LABEL</xsl:with-param>
				<xsl:with-param name="override-product-code">claim</xsl:with-param>
				<xsl:with-param name="override-currency-name">claim_cur_code</xsl:with-param>
				<xsl:with-param name="override-currency-value"><xsl:value-of select="bg_cur_code"/></xsl:with-param>    
				<xsl:with-param name="override-amt-value"><xsl:value-of select="tnx_amt"/></xsl:with-param>          			
				<xsl:with-param name="override-amt-name">claim_amt</xsl:with-param>
				<xsl:with-param name="currency-readonly">Y</xsl:with-param>
				<xsl:with-param name="show-button">N</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
	  	    </xsl:call-template>
	  	    </xsl:if>
	  	</xsl:when>
	  	<xsl:otherwise>
	  		<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_AMOUNTDETAILS_CLAIM_AMT_LABEL</xsl:with-param>
				<xsl:with-param name="override-product-code">claim</xsl:with-param>
				<xsl:with-param name="override-currency-name">claim_cur_code</xsl:with-param>
				<xsl:with-param name="override-currency-value"><xsl:value-of select="bg_cur_code"/></xsl:with-param>    
				<xsl:with-param name="override-amt-value"><xsl:value-of select="tnx_amt"/></xsl:with-param>          			
				<xsl:with-param name="override-amt-name">claim_amt</xsl:with-param>
				<xsl:with-param name="currency-readonly">Y</xsl:with-param>
				<xsl:with-param name="show-button">N</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
	  	    </xsl:call-template>
	  	</xsl:otherwise>
	  </xsl:choose>
	<!-- 
    <xsl:call-template name="simple-disclaimer">
		<xsl:with-param name="label">XSL_MSG_BANK_FINANCING_MESSAGE</xsl:with-param>
	</xsl:call-template> -->
	    
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
    
	  	<div id="bank_instructions_row"> 
	  		<xsl:variable name="isMT798"><xsl:value-of select="is_MT798"/></xsl:variable>
	    	<xsl:if test = "$isMT798 = 'Y'">
				 <xsl:call-template name="hidden-field">
				  	<xsl:with-param name="name">adv_send_mode</xsl:with-param>
				  	<xsl:with-param name="value">01</xsl:with-param>
		    	</xsl:call-template>
		  	</xsl:if>
		  	<xsl:call-template name="bank-instructions">
		      	<xsl:with-param name="send-mode-displayed">
		      		<xsl:choose>
		      			<xsl:when test="$isMT798 = 'Y'">N</xsl:when>
		      			<xsl:otherwise>Y</xsl:otherwise>
		      		</xsl:choose>
		      	</xsl:with-param>
				<xsl:with-param name="send-mode-required">N</xsl:with-param>
		        <xsl:with-param name="delivery-to-shown">N</xsl:with-param>
		        <xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
		        <xsl:with-param name="principal-acc-displayed">N</xsl:with-param>
		  		<xsl:with-param name="fee-acc-displayed">N</xsl:with-param>
		  		<xsl:with-param name="free-format-text-displayed">N</xsl:with-param>
		  		<xsl:with-param name="is-toc-item">
		         	<xsl:choose>
		         		<xsl:when test="$isMT798 = 'N'">N</xsl:when>
		         		<xsl:otherwise>Y</xsl:otherwise>
		         	</xsl:choose>
		         </xsl:with-param>
		    </xsl:call-template>
	    </div>
    
     
	  <xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_product/fx_assign_products[.='Y']">
	     <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">fx_rates_type_temp</xsl:with-param>
	       <xsl:with-param name="value"><xsl:value-of select="fx_rates_type"></xsl:value-of></xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">fx_master_currency</xsl:with-param>
	       <xsl:with-param name="value"><xsl:value-of select="fx_contract_nbr_cur_code_1"></xsl:value-of></xsl:with-param>
	      </xsl:call-template>
	     <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">product_code</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="$product-code"></xsl:value-of></xsl:with-param>
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
      <xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_product/fx_assign_products[.='Y']">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">fxinteresttoken</xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      <xsl:call-template name="e2ee_transaction"/>      
      <xsl:call-template name="reauth_params"/>      
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  <!-- for disclaimers -->
	<xsl:template name="simple-disclaimer">
			<xsl:param name="label"/>
			<xsl:param name="bank-specific-label">XSL_MSG_BANK_SETTLEMENT_LABEL.<xsl:value-of select="advising_bank/abbv_name"></xsl:value-of></xsl:param>
			<div><xsl:value-of select="localization:getGTPString($language, $label)" disable-output-escaping="yes" />&nbsp;<a target="_blank"><xsl:attribute name="href"><xsl:value-of select="localization:getGTPString($language, $bank-specific-label)" disable-output-escaping="yes" /></xsl:attribute><xsl:value-of select="localization:getGTPString($language, $bank-specific-label)" disable-output-escaping="yes" /></a></div>
	</xsl:template>
</xsl:stylesheet>