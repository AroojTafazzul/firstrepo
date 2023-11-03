<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for general trade messages, customer side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
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
  
  <!-- TODO: The xsl needs to be separated for Claim, Extend/Pay and correspondence. -->
  
  <!-- Columns definition import -->
  <xsl:import href="../../core/xsl/report/report.xsl"/>
  
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  
  <!-- These params are empty for trade message -->
  <xsl:param name="realform-action"/>
  <xsl:param name="product-code">SI</xsl:param>

  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />

  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <xsl:apply-templates/>
  </xsl:template>
  
  <!--
   SI MESSAGE
   -->
  <xsl:template match="si_tnx_record">
   <xsl:variable name="product-code"><xsl:value-of select="product_code"/></xsl:variable>
   <!-- Lower case product code -->
   <xsl:variable name="lowercase-product-code">
    <xsl:value-of select="translate($product-code,$up,$lo)"/>
   </xsl:variable>

   <xsl:variable name="screen-name">StandbyIssuedScreen</xsl:variable>
   <xsl:variable name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$screen-name"/></xsl:variable>
  
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
      <xsl:call-template name="general-details"/>
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
	  <xsl:variable name="isMT798"><xsl:value-of select="is_MT798"/></xsl:variable>
	  <xsl:variable name="max-length"><xsl:value-of select="defaultresource:getResource('FREE_FORMAT_MAXLENGTH')"/></xsl:variable>
      <div id="bankInst">
      <xsl:call-template name="bank-instructions">
       <xsl:with-param name="send-mode-required">N</xsl:with-param>
       <xsl:with-param name="send-mode-displayed">N</xsl:with-param>
       <xsl:with-param name="principal-acc-displayed">N</xsl:with-param>
       <xsl:with-param name="fee-acc-displayed">N</xsl:with-param>
       <xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
       <xsl:with-param name="free-format-text-displayed">N</xsl:with-param>
       <xsl:with-param name="is-toc-item">
	       	<xsl:choose>
	       		<xsl:when test="$isMT798 = 'N'">N</xsl:when>
	       		<xsl:otherwise>Y</xsl:otherwise>
	       	</xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
      </div>
      <xsl:call-template name="message-freeformat">
        <xsl:with-param name="mt798enabled"><xsl:value-of select="$isMT798"/></xsl:with-param>
		<xsl:with-param name="max-length"><xsl:value-of select="$max-length"/></xsl:with-param>
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
    		<xsl:with-param name="callback">misys.toggleFields(misys._config.customerBanksMT798Channel[dijit.byId("issuing_bank_abbv_name").get("value")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01', null, ["delivery_channel"], false, false)</xsl:with-param>
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

   <!-- Javascript and Dojo imports  -->
   <xsl:call-template name="js-imports"> 
    <xsl:with-param name="product-code"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="lowercase-product-code"><xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
    <xsl:with-param name="action"><xsl:value-of select="$action"/></xsl:with-param>
    <xsl:with-param name="override-help-access-key">SI_02</xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!--                                     -->  
  <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
  <!--                                     -->

  <!-- Additional JS imports for this form are -->
  <!-- added here. -->
  <xsl:template name="js-imports">
   <xsl:param name="product-code"/>
   <xsl:param name="lowercase-product-code"/>
   <xsl:param name="action"/>

   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">    
	    <xsl:choose>
	    	<xsl:when test="(org_previous_file/si_tnx_record/prod_stat_code[.='86'] or prod_stat_code[.='84'] or sub_tnx_type_code[.='62' or .='63'])  and sub_tnx_type_code[.!= '24' and .!='25']">misys.binding.trade.message_si</xsl:when>
	    	<xsl:otherwise>misys.binding.trade.message</xsl:otherwise>
	    </xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="override-product-code" select="$product-code"/>
    <xsl:with-param name="override-lowercase-product-code" select="$lowercase-product-code"/>
    <xsl:with-param name="override-action" select="$action"/>
    <xsl:with-param name="override-help-access-key">SI_02</xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <xsl:param name="lowercase-product-code"/>  
  	<xsl:variable name="show-tnx-amt">
  		<xsl:choose>
  			<xsl:when test="org_previous_file/si_tnx_record/prod_stat_code[.='86']">N</xsl:when>
  			<xsl:otherwise>N</xsl:otherwise>
  		</xsl:choose>  	
  	</xsl:variable>
   <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="show-type">N</xsl:with-param>
    <xsl:with-param name="show-tnx-amt"><xsl:value-of select="$show-tnx-amt"/></xsl:with-param>
   </xsl:call-template>
   <div class="widgetContainer">
   <xsl:call-template name="localization-dialog"/>
    <xsl:if test="$displaymode='edit'">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">prod_stat_code</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="org_previous_file/si_tnx_record/prod_stat_code"/></xsl:with-param>
     </xsl:call-template>
     <xsl:if test="entity[. != '']">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">entity</xsl:with-param>
     </xsl:call-template>
      </xsl:if>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">product_code</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="product_code"/></xsl:with-param>
     </xsl:call-template>
   
     <!--Empty the principal and fee accounts-->
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">adv_send_mode</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="adv_send_mode"/></xsl:with-param>
     </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$displaymode='view'">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">principal_act_no</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="principal_act_no"/></xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">fee_act_no</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="fee_act_no"/></xsl:with-param>
     </xsl:call-template>
     </xsl:if>

    <!-- Displaying the bank details. -->
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
      <xsl:with-param name="value" select="issuing_bank/abbv_name"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">issuing_bank_name</xsl:with-param>
      <xsl:with-param name="value" select="issuing_bank/name"/>
     </xsl:call-template> 
    
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">lc_cur_code</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="//lc_cur_code" /></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">lc_amt</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="//lc_amt" /></xsl:with-param>
    </xsl:call-template>
    
   </div>
  </xsl:template>
  
  <!-- 
   General Details
   -->
  <xsl:template name="general-details">
   <xsl:call-template name="message-general-details">
    <xsl:with-param name="additional-details">
   	<xsl:choose>
   	<!-- claim Presentation -->
   	<xsl:when test="(prod_stat_code[.='84'] or sub_tnx_type_code[.='62' or .='63' or .='25']) and sub_tnx_type_code != '24' and securitycheck:hasPermission($rundata,'si_claim_access') = 'true'">
 		<xsl:if test="claim_present_date[.!='']">
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_CLAIM_PRESENT_DATE_LABEL</xsl:with-param>
         <xsl:with-param name="id">claim_present_date_view</xsl:with-param>
         <xsl:with-param name="value" select="claim_present_date"/>
         <xsl:with-param name="override-displaymode">view</xsl:with-param>
        </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="claim_reference[.!='']">
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_CLAIM_REFERENCE_LABEL</xsl:with-param>
         <xsl:with-param name="id">claim_reference_view</xsl:with-param>
         <xsl:with-param name="value" select="claim_reference"/>
         <xsl:with-param name="override-displaymode">view</xsl:with-param>
        </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="org_previous_file/si_tnx_record/claim_cur_code[.!=''] and org_previous_file/si_tnx_record/claim_amt[.!='']">
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_CLAIM_AMOUNT_LABEL</xsl:with-param>
         <xsl:with-param name="id">claim_amt_view</xsl:with-param>
         <xsl:with-param name="value"><xsl:value-of select="claim_cur_code"/>&nbsp;<xsl:value-of select="org_previous_file/si_tnx_record/claim_amt"/></xsl:with-param>
         <xsl:with-param name="override-displaymode">view</xsl:with-param>
        </xsl:call-template>
        <xsl:if test="$displaymode='edit'">
	        <xsl:call-template name="hidden-field">
			  	<xsl:with-param name="name">claim_amt</xsl:with-param>
			  	<xsl:with-param name="value"><xsl:value-of select="org_previous_file/si_tnx_record/claim_amt"/></xsl:with-param>
			</xsl:call-template>
        </xsl:if>
        </xsl:if>
 	
 	<xsl:choose>
 		<xsl:when test="$option = 'ACTION_REQUIRED' or sub_tnx_type_code[.='62' or .='63']">
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
		            <option value="62">
		             <xsl:value-of select="localization:getDecode($language, 'N003', '62')"/>
		            </option>
		            <option value="63">
		             <xsl:value-of select="localization:getDecode($language, 'N003', '63')"/>
		            </option>
		           </xsl:when>
		           <xsl:otherwise>
		            <xsl:choose>
		             <xsl:when test="sub_tnx_type_code[.='62']"><xsl:value-of select="localization:getDecode($language, 'N003', '62')"/></xsl:when>
		             <xsl:when test="sub_tnx_type_code[.='63']"><xsl:value-of select="localization:getDecode($language, 'N003', '63')"/></xsl:when>
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
		         <!--  <xsl:with-param name="value">25</xsl:with-param> -->
		         <!--  <xsl:with-param name="readonly">Y</xsl:with-param> -->
		         <xsl:with-param name="fieldsize">medium</xsl:with-param>
		         <xsl:with-param name="override-displaymode">
		         	<xsl:value-of select="$displaymode"/>
		         </xsl:with-param>
		         <xsl:with-param name="options">
		          <xsl:choose>
		           <xsl:when test="$displaymode='edit' and action_req_code[.='']">
		           <option value="24">
		             <xsl:value-of select="localization:getDecode($language, 'N003', '24')"/>
		            </option>
		            <option value="25">
		             <xsl:value-of select="localization:getDecode($language, 'N003', '25')"/>
		            </option>
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
        <xsl:if test="$displaymode='edit'">
	        <xsl:call-template name="hidden-field">
			  	<xsl:with-param name="name">is_amt_editable</xsl:with-param>
			  	<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('IS_SETTLEMENT_AMT_EDITABLE')"/></xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<!-- Added as part of MPS-50578 -->
        <xsl:if test="($displaymode='view' and sub_tnx_type_code[.='25' or .='62']) or ($displaymode='edit' and sub_tnx_type_code[.!='25']) ">
        <div id="claim-settlement-details">
            <xsl:call-template name="currency-field">
	         <xsl:with-param name="label">XSL_AMOUNTDETAILS_SETTLEMENT_AMT_LABEL</xsl:with-param>
	         <xsl:with-param name="product-code"><xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
	         <xsl:with-param name="override-currency-name">tnx_cur_code</xsl:with-param>
	         <xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param>
	         <xsl:with-param name="show-button">N</xsl:with-param>
	         <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	         <xsl:with-param name="override-currency-value"><xsl:value-of select="lc_cur_code"/></xsl:with-param>
	         <xsl:with-param name="override-amt-displaymode">
	         	<xsl:choose>
	         	<xsl:when test="$displaymode='edit' and defaultresource:getResource('IS_SETTLEMENT_AMT_EDITABLE') = 'true'">edit</xsl:when>
	         	<xsl:otherwise>view</xsl:otherwise>
	         	</xsl:choose>
	         </xsl:with-param>
	         <xsl:with-param name="override-amt-value">
	         	<xsl:choose>
	         		<xsl:when test="tnx_amt[.!='']">
	         			<xsl:value-of select="tnx_amt"/>
	         		</xsl:when>
	         		<xsl:otherwise>
	         			<xsl:value-of select="claim_amt"/>
	         		</xsl:otherwise>
	         	</xsl:choose>
	         </xsl:with-param>
	        </xsl:call-template>
	        <xsl:call-template name="principal-account-field">
		       <xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
		       <xsl:with-param name="type">account</xsl:with-param>
		       <xsl:with-param name="name">principal_act_no</xsl:with-param>
		       <xsl:with-param name="readonly">Y</xsl:with-param>
		       <xsl:with-param name="size">34</xsl:with-param>
		       <xsl:with-param name="maxsize">34</xsl:with-param>
		       <xsl:with-param name="entity-field">entity</xsl:with-param>
		       <xsl:with-param name="show-product-types">N</xsl:with-param>
		      </xsl:call-template>
	        <xsl:call-template name="principal-account-field">
		      <xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
		      <xsl:with-param name="type">account</xsl:with-param>
		      <xsl:with-param name="name">fee_act_no</xsl:with-param>
		      <xsl:with-param name="readonly">Y</xsl:with-param>
		      <xsl:with-param name="size">34</xsl:with-param>
		      <xsl:with-param name="maxsize">34</xsl:with-param>
		      <xsl:with-param name="entity-field">entity</xsl:with-param>
		      <xsl:with-param name="show-product-types">N</xsl:with-param>
		    </xsl:call-template>
        </div>
        </xsl:if>
	  </xsl:when>
	<xsl:when test="org_previous_file/si_tnx_record/prod_stat_code[.='86']  and sub_tnx_type_code[.!='24' and .!='25']">
 	<xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXTEND_OR_PAY_RESPONSE</xsl:with-param>
      <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
	    <xsl:when test="$displaymode='edit'">
	       <option value ="">
	       </option>
		   <option value="20">
		    <xsl:value-of select="localization:getDecode($language, 'N003', '20')"/>
		   </option>
	       <option value="21">
	        <xsl:value-of select="localization:getDecode($language, 'N003', '21')"/>
	       </option>
	    </xsl:when>
	    <xsl:otherwise>
	     <xsl:choose>
          <xsl:when test="sub_tnx_type_code[.='20']"><xsl:value-of select="localization:getDecode($language, 'N003', '20')"/></xsl:when>
          <xsl:when test="sub_tnx_type_code[.='21']"><xsl:value-of select="localization:getDecode($language, 'N003', '21')"/></xsl:when>
         </xsl:choose>
	    </xsl:otherwise>
	   </xsl:choose>	   
      </xsl:with-param>
     </xsl:call-template>
     </xsl:when>
  	<xsl:when test="org_previous_file/si_tnx_record/prod_stat_code[.='78' or .='79'] or sub_tnx_type_code[.='88' or .='89']">
	  <xsl:call-template name="select-field">
	     <xsl:with-param name="label">XSL_GENERALDETAILS_WORDING_RESPONSE</xsl:with-param>
	     <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
	     <xsl:with-param name="required">Y</xsl:with-param>
	     <xsl:with-param name="options">
	      <xsl:choose>
		    <xsl:when test="$displaymode='edit'"> 			      
			   <xsl:choose>
		       <xsl:when test="org_previous_file/si_tnx_record/prod_stat_code[.='78']">
			       <option value="88">
				    <xsl:value-of select="localization:getGTPString($language, 'XSL_WUR_YES')"/>
				   </option>
			       <option value="89">
			        <xsl:value-of select="localization:getGTPString($language, 'XSL_WUR_NO')"/>
			       </option>
		       </xsl:when>
		       <xsl:otherwise>
				   <option value="88">
				    <xsl:value-of select="localization:getGTPString($language, 'XSL_FW_YES')"/>
				   </option>
			       <option value="89">
			        <xsl:value-of select="localization:getGTPString($language, 'XSL_FW_NO')"/>
			       </option>
		       </xsl:otherwise>
		       </xsl:choose>
		    </xsl:when>
		    <xsl:otherwise>
		     <xsl:choose>
		         <xsl:when test="sub_tnx_type_code[.='88'] and org_previous_file/si_tnx_record/prod_stat_code[.='78']"><xsl:value-of select="localization:getGTPString($language, 'XSL_WUR_YES')"/></xsl:when>
		         <xsl:when test="sub_tnx_type_code[.='88'] and org_previous_file/si_tnx_record/prod_stat_code[.='79']"><xsl:value-of select="localization:getGTPString($language, 'XSL_FW_YES')"/></xsl:when>
		         <xsl:when test="sub_tnx_type_code[.='89'] and org_previous_file/si_tnx_record/prod_stat_code[.='78']"><xsl:value-of select="localization:getGTPString($language, 'XSL_WUR_NO')"/></xsl:when>
		         <xsl:when test="sub_tnx_type_code[.='89'] and org_previous_file/si_tnx_record/prod_stat_code[.='79']"><xsl:value-of select="localization:getGTPString($language, 'XSL_FW_NO')"/></xsl:when>
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
         	<xsl:choose>
         		<xsl:when test="$option = 'ACTION_REQUIRED'">view</xsl:when>
         		<xsl:otherwise><xsl:value-of select="$displaymode"/></xsl:otherwise>
         	</xsl:choose>
         </xsl:with-param>	         
         <xsl:with-param name="options">
          <xsl:choose>
           <xsl:when test="$displaymode='edit' and $option != 'ACTION_REQUIRED'">
            <option value="24">
             <xsl:value-of select="localization:getDecode($language, 'N003', '24')"/>
            </option>
            <option value="25">
             <xsl:value-of select="localization:getDecode($language, 'N003', '25')"/>
            </option>
           </xsl:when>
           <xsl:otherwise>
            <xsl:choose>
			 <xsl:when test="$option = 'ACTION_REQUIRED'"><xsl:value-of select="localization:getDecode($language, 'N043', '01')"/></xsl:when>	            
             <xsl:when test="prod_stat_code[.='24']"><xsl:value-of select="localization:getDecode($language, 'N003', '24')"/></xsl:when>
             <xsl:when test="prod_stat_code[.='25']"><xsl:value-of select="localization:getDecode($language, 'N003', '25')"/></xsl:when>
            </xsl:choose>
           </xsl:otherwise>
          </xsl:choose>
         </xsl:with-param>
        </xsl:call-template>
       </xsl:otherwise>
	</xsl:choose>
	
	<xsl:choose>
     	<xsl:when test="org_previous_file/si_tnx_record/prod_stat_code[.='86'] and sub_tnx_type_code[.!='24' and .!='25']">
	     	<xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_GENERALDETAILS_ORG_EXPIRY_DATE</xsl:with-param>
	       <xsl:with-param name="id">org_previous_exp_date_view</xsl:with-param>
	       <xsl:with-param name="value" select="org_previous_file/si_tnx_record/exp_date"/>
	       <xsl:with-param name="override-displaymode">view</xsl:with-param>
	      </xsl:call-template>    
           <xsl:call-template name="hidden-field">
           	<xsl:with-param name="name">org_previous_exp_date</xsl:with-param>
           	<xsl:with-param name="value" select="org_previous_file/si_tnx_record/exp_date"/>
           </xsl:call-template>
	      <!-- Expiry Date -->
	      <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_GENERALDETAILS_NEW_EXPIRY_DATE</xsl:with-param>
	       <xsl:with-param name="name">exp_date</xsl:with-param>
	       <xsl:with-param name="size">10</xsl:with-param>
	       <xsl:with-param name="maxsize">10</xsl:with-param>
	       <xsl:with-param name="type">date</xsl:with-param>
	       <xsl:with-param name="fieldsize">small</xsl:with-param>
	       <xsl:with-param name="required">Y</xsl:with-param>
	      </xsl:call-template> 
     	</xsl:when>
     	 <xsl:otherwise>
	   	 	<!-- Expiry Type -->
	   	 	 <xsl:if test="lc_exp_date_type_code[.!='']">
				<xsl:variable name="lc_exp_date_type_code"><xsl:value-of select="lc_exp_date_type_code"></xsl:value-of></xsl:variable>
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
	 		<!-- Original Expiry Date -->
	       <xsl:if test="exp_date[.!='']">
	       <xsl:call-template name="input-field">
	        <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
	        <xsl:with-param name="id">exp_date_view</xsl:with-param>
	        <xsl:with-param name="value" select="exp_date"/>
	        <xsl:with-param name="override-displaymode">view</xsl:with-param>
	       </xsl:call-template>
	       <xsl:if test="$displaymode='edit'">
	        <xsl:call-template name="hidden-field">
	         <xsl:with-param name="name">exp_date</xsl:with-param>
	          <xsl:with-param name="value" select="exp_date"/>
	        </xsl:call-template>
	       </xsl:if>
			</xsl:if>
		</xsl:otherwise>    
     </xsl:choose> 
      
      <!-- Display amount details in edit mode and view mode only if it has been set -->
     <xsl:if test="org_previous_file/si_tnx_record/prod_stat_code[.='86'] and ($displaymode = 'edit' or tnx_amt[.!='']) and sub_tnx_type_code[.!='24' and .!='25']">     
   		<xsl:call-template name="amt-details"/>
   	</xsl:if>
	   
   <xsl:if test="sub_tnx_type_code[.!='62' and .!='63']">
        <div id="settlement-details" style="display:none">
        	<xsl:call-template name="currency-field">
		         <xsl:with-param name="label">XSL_AMOUNTDETAILS_SETTLEMENT_AMT_LABEL</xsl:with-param>
		         <xsl:with-param name="product-code"><xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
		         <xsl:with-param name="override-currency-name">lc_cur_code</xsl:with-param>
		         <xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param>
		         <xsl:with-param name="show-button">N</xsl:with-param>
		         <xsl:with-param name="currency-readonly">Y</xsl:with-param>
		         <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	        </xsl:call-template>
	        <xsl:call-template name="input-field">
		         <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
		         <xsl:with-param name="name">lc_liab_amt</xsl:with-param>
		         <xsl:with-param name="maxsize">34</xsl:with-param>
		         <xsl:with-param name="override-displaymode">view</xsl:with-param>
	        </xsl:call-template>
	        <xsl:call-template name="hidden-field">
		      	<xsl:with-param name="name">outstanding_amt</xsl:with-param>
		      	<xsl:with-param name="value"><xsl:value-of select="lc_liab_amt" /></xsl:with-param>
			</xsl:call-template>
	        <xsl:call-template name="input-field">
		         <xsl:with-param name="label">XSL_AMOUNTDETAILS_FORWARD_CONTRACT_LABEL</xsl:with-param>
		         <xsl:with-param name="name">fwd_contract_no</xsl:with-param>
		         <xsl:with-param name="maxsize">34</xsl:with-param>
	        </xsl:call-template>
        </div>
    </xsl:if>
    </xsl:with-param>
    
   </xsl:call-template>        
  </xsl:template>
  
  <!-- 
   Pay Details Details
   -->
  <xsl:template name="amt-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_TNX_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">lc</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param>
      <xsl:with-param name="amt-readonly">N</xsl:with-param>
     </xsl:call-template>
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
      <xsl:call-template name="reauth_params"/>  
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>