<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for general trade message transfers, customer side.

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
  	xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
    xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="xmlRender localization securitycheck utils security">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="show-eucp">N</xsl:param>
  
  <!-- These params are empty for trade message -->
  <xsl:param name="realform-action"/>
  <xsl:param name="product-code"/>
  <xsl:param name="maxUploadSizeMessage"/>

  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl"/>
  <xsl:include href="../../core/xsl/common/ls_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  <xsl:include href="../../core/xsl/common/lc_common.xsl" />
  
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <xsl:apply-templates/>
  </xsl:template>
  
  <!--
   EL / SR TNX FORM TEMPLATE 
   -->
  <xsl:template match="el_tnx_record | sr_tnx_record">
   <xsl:variable name="product-code"><xsl:value-of select="product_code"/></xsl:variable>
   <!-- Lower case product code -->
   <xsl:variable name="lowercase-product-code">
    <xsl:value-of select="translate($product-code,$up,$lo)"/>
   </xsl:variable>

   <xsl:variable name="screen-name">
    <xsl:choose>
     <xsl:when test="product_code[.='EL']">ExportLetterOfCreditScreen</xsl:when>
     <xsl:when test="product_code[.='SR']">StandbyReceivedScreen</xsl:when>
    </xsl:choose>
   </xsl:variable>
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
      <xsl:variable name="isMT798"><xsl:value-of select="is_MT798"/></xsl:variable>
      <!--  Display common menu. -->
      <xsl:call-template name="menu">
       <xsl:with-param name="node-name" select="name(.)"/>
       <xsl:with-param name="screen-name" select="$screen-name"/>
       <xsl:with-param name="show-template">N</xsl:with-param>
       <xsl:with-param name="show-return">Y</xsl:with-param>
      </xsl:call-template>
       <xsl:call-template name="build-inco-terms-data"/>
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
      
      <xsl:call-template name="hidden-fields">
       <xsl:with-param name="lowercase-product-code" select="$lowercase-product-code"/>
      </xsl:call-template>
      <!-- Hidden cross references -->
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="general-details">
      	<xsl:with-param name="product-code"><xsl:value-of select="$product-code"/></xsl:with-param>
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
	   <xsl:if test="defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true'">
	  <xsl:if test="lc_type[.='01'] or lc_type[.='']">
		  <xsl:call-template name="linked-ls-declaration"/>
		  <xsl:call-template name="linked-licenses"/>
	  </xsl:if>
	  </xsl:if>
      <div id="bankInst">
      <xsl:variable name="isMT798"><xsl:value-of select="is_MT798"/></xsl:variable>
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
      </xsl:call-template>
      <!-- comments for return -->
      <xsl:if test="tnx_stat_code[.!='03' and .!='04']">   <!-- MPS-43899 -->
      <xsl:call-template name="comments-for-return">
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
   	  </xsl:if>
   	   <xsl:if test="$swift2019Enabled and product_code[.='SR']">
       <xsl:call-template name="delivery-instructions"/>
       </xsl:if>
     </xsl:with-param>
    </xsl:call-template>
    
    <!-- Form #1 : Attach Files -->
     <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED') or ($displaymode != 'edit' and $mode = 'VIEW')">
    	<xsl:call-template name="attachments-file-dojo">
    		<xsl:with-param name="callback">misys.toggleFields(misys._config.customerBanksMT798Channel[dijit.byId("advising_bank_abbv_name").get("value")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01', null, ["delivery_channel"], false, false)</xsl:with-param>
    		<xsl:with-param name="title-size">35</xsl:with-param>
    	</xsl:call-template>
    </xsl:if>

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
   
   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>
   <!--  Floating collabration window -->
		    <xsl:call-template name="collaboration">
		       <xsl:with-param name="editable">true</xsl:with-param>
		       <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
		       <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
		       <xsl:with-param name="bank_name_widget_id">advising_bank_abbv_name</xsl:with-param>
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

  <!-- Additional JS imports for this form are -->
  <!-- added here. -->
  <xsl:template name="js-imports">
   <xsl:param name="product-code"/>
   <xsl:param name="action"/>
   <xsl:param name="lowercase-product-code"/>

   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.trade.message_transfer_<xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
    <xsl:with-param name="show-collaboration-js">N</xsl:with-param>
    <xsl:with-param name="override-product-code" select="$product-code"/>
    <xsl:with-param name="override-lowercase-product-code" select="$lowercase-product-code"/>
    <xsl:with-param name="override-action" select="$action"/>
    <xsl:with-param name="override-help-access-key">EL_TRANS</xsl:with-param>
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
   <xsl:param name="lowercase-product-code"/>
   <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="show-type">N</xsl:with-param>
    <xsl:with-param name="show-tnx-amt">N</xsl:with-param>
   </xsl:call-template>
   <div class="widgetContainer">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">advising_bank_abbv_name</xsl:with-param>
     <xsl:with-param name="value" select="advising_bank/abbv_name"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">lc_cur_code</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">lc_amt</xsl:with-param>
    </xsl:call-template>
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
    <xsl:if test="product_code[.='EL' or .='SR']">
       <xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">swiftregexValue</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX')"/></xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
			<xsl:with-param name="name">swiftregexzcharValue</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX_ZCHAR')"/></xsl:with-param>
	   </xsl:call-template>
	 </xsl:if>
    <xsl:if test="lc_type[.='01'] or lc_type[.='']">
	    <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">entity</xsl:with-param>
	     <xsl:with-param name="value">
	     <xsl:choose>
	     	<xsl:when test="org_previous_file/el_tnx_record/entity != ''">
	     		<xsl:value-of select="org_previous_file/el_tnx_record/entity" />
	     	</xsl:when>
	     	<xsl:otherwise>
	     		<xsl:value-of select="entity" />
	     	</xsl:otherwise>
	     </xsl:choose>
	     </xsl:with-param>
	    </xsl:call-template>
	    <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">beneficiary_name</xsl:with-param>
	     <xsl:with-param name="value">
	     <xsl:choose>
	     	<xsl:when test="org_previous_file/el_tnx_record/beneficiary_name != ''">
	     		<xsl:value-of select="org_previous_file/el_tnx_record/beneficiary_name" />
	     	</xsl:when>
	     	<xsl:otherwise>
	     		<xsl:value-of select="beneficiary_name" />
	     	</xsl:otherwise>
	     </xsl:choose>
	     </xsl:with-param>
	    </xsl:call-template>
	    <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">beneficiary_abbv_name</xsl:with-param>
	     <xsl:with-param name="value">
	     <xsl:choose>
	     	<xsl:when test="org_previous_file/el_tnx_record/beneficiary_name != ''">
	     		<xsl:value-of select="org_previous_file/el_tnx_record/beneficiary_abbv_name" />
	     	</xsl:when>
	     	<xsl:otherwise>
	     		<xsl:value-of select="beneficiary_abbv_name" />
	     	</xsl:otherwise>
	     </xsl:choose>
	    </xsl:with-param>
	    </xsl:call-template>
	     <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">assignee_exp_date</xsl:with-param>
	     <xsl:with-param name="value"><xsl:value-of select="exp_date"/></xsl:with-param>
	    </xsl:call-template>
    </xsl:if>
     <!-- Original Expiry Date -->
    <xsl:if test="sub_tnx_type_code[.!='19']">
    	
	    <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">org_exp_date</xsl:with-param>
	     <xsl:with-param name="value"><xsl:value-of select="org_previous_file/el_tnx_record/exp_date" /></xsl:with-param>
	    </xsl:call-template>
	   
	    <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">org_last_ship_date</xsl:with-param>
	     <xsl:with-param name="value"><xsl:value-of select="org_previous_file/el_tnx_record/last_ship_date" /></xsl:with-param>
	    </xsl:call-template>
	    <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">narrative_period_presentation_nosend</xsl:with-param>
	       <xsl:with-param name="value" select="narrative_period_presentation"/>
      	</xsl:call-template>
      	<xsl:if test="$swift2018Enabled">
      		<xsl:if test="product_code[.='SR'] and sub_tnx_type_code[.='12' or .='19']">
	      		<xsl:call-template name="hidden-field">
			    	<xsl:with-param name="name">narrative_description_goods</xsl:with-param>
			    	<xsl:with-param name="value"/>
			    </xsl:call-template>
			    <xsl:call-template name="hidden-field">
			    	<xsl:with-param name="name">narrative_special_beneficiary</xsl:with-param>
			    	<xsl:with-param name="value"/>
			    </xsl:call-template>
      		</xsl:if>
	        <xsl:call-template name="hidden-field">
		    	<xsl:with-param name="name">narrative_documents_required</xsl:with-param>
		    	<xsl:with-param name="value"/>
		    </xsl:call-template>
		    <xsl:call-template name="hidden-field">
		    	<xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
		    	<xsl:with-param name="value"/>
		    </xsl:call-template>
		    <xsl:call-template name="hidden-field">
		    	<xsl:with-param name="name">narrative_special_recvbank</xsl:with-param>
		    	<xsl:with-param name="value"/>
		    </xsl:call-template>
      	</xsl:if>
	 </xsl:if>
   </div>
  </xsl:template>
  
  <!-- 
   Transfer General Details
   -->
  <xsl:template name="general-details">
  	<xsl:param name="product-code"/>
    <xsl:call-template name="message-general-details">
       <xsl:with-param name="additional-details">
       	 
	     <xsl:choose>
	      <!-- ASSIGNEE: sub_tnx_type_code = 19 -->
	      <xsl:when test="(product_code[.='EL'] or product_code[.='SR']) and sub_tnx_type_code[.='19']">
	       <xsl:call-template name="fieldset-wrapper">
	        <xsl:with-param name="legend">XSL_HEADER_ASSIGNEE_DETAILS</xsl:with-param>
	        <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	        <xsl:with-param name="content">
	         <xsl:call-template name="address">
	          <xsl:with-param name="prefix">assignee</xsl:with-param>
	          <xsl:with-param name="show-button">Y</xsl:with-param>
       		  <xsl:with-param name="search-button-type">assignee</xsl:with-param>
	         </xsl:call-template>
	        </xsl:with-param>
	       </xsl:call-template>
	      </xsl:when>
	      <!-- TRANSFER: sub_tnx_type_code = 12 -->
	      <xsl:otherwise>
	        <xsl:if test="product_code[.='EL']"> 	
		        <!-- Org Expiry Date -->
		       	<xsl:call-template name="input-field">
				 <xsl:with-param name="label">XSL_GENERALDETAILS_ORG_EXPIRY_DATE</xsl:with-param>
				 <xsl:with-param name="name">org_exp_date</xsl:with-param>
				 <xsl:with-param name="value"><xsl:value-of select="org_previous_file/el_tnx_record/exp_date" /></xsl:with-param>
				 <xsl:with-param name="override-displaymode">view</xsl:with-param>
			    </xsl:call-template>      
		      	<!-- Expiry Date -->
		       	<xsl:call-template name="input-field">
				 <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE_TRANSFER</xsl:with-param>
				 <xsl:with-param name="name">exp_date</xsl:with-param>
				 <xsl:with-param name="size">10</xsl:with-param>
				 <xsl:with-param name="maxsize">10</xsl:with-param>
				 <xsl:with-param name="fieldsize">small</xsl:with-param>
				 <xsl:with-param name="type">date</xsl:with-param>
				 <xsl:with-param name="swift-validate">N</xsl:with-param>
				 <xsl:with-param name="required">Y</xsl:with-param>
			   </xsl:call-template>
			   <!-- Expiry Place -->
			   <xsl:call-template name="input-field">
			    <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE_TRANSFER</xsl:with-param>
			    <xsl:with-param name="name">expiry_place</xsl:with-param>
			    <xsl:with-param name="required">N</xsl:with-param>
			    <xsl:with-param name="maxsize">29</xsl:with-param>
			   </xsl:call-template>
		   </xsl:if>
		   <xsl:if test="product_code[.='EL'] or product_code[.='SR']"> 	
	      	   <!-- Second Beneficiary -->
		       <xsl:call-template name="fieldset-wrapper">
		        <xsl:with-param name="legend">XSL_HEADER_SECOND_BENEFICIARY_DETAILS</xsl:with-param>
		        <xsl:with-param name="legend-type">indented-header</xsl:with-param>
		        <xsl:with-param name="content">
		         <xsl:call-template name="address">
		          <xsl:with-param name="prefix">sec_beneficiary</xsl:with-param>
		          <xsl:with-param name="show-button">Y</xsl:with-param>
       			  <xsl:with-param name="search-button-type">sec_beneficiary</xsl:with-param>
		          <xsl:with-param name="show-country">Y</xsl:with-param>
		          <xsl:with-param name="show-abbv">
		          	 <xsl:choose>
		          	 <xsl:when test="product_code[.='EL']">Y</xsl:when>
		          	 <xsl:otherwise>N</xsl:otherwise>
		          	 </xsl:choose>
		          </xsl:with-param>
		           <xsl:with-param name="readonly">
		            <xsl:choose>
		          	 <xsl:when test="product_code[.='EL']">N</xsl:when>
		          	 <xsl:otherwise>Y</xsl:otherwise>
		          	 </xsl:choose>
		          	 </xsl:with-param>
		            <xsl:with-param name="address-readonly">N</xsl:with-param>
		         </xsl:call-template>
		        </xsl:with-param>
		       </xsl:call-template>
		       		       
		        <xsl:call-template name="transfer-details">
			      <xsl:with-param name="product-code" select="$product-code"/>
			    </xsl:call-template>
		    </xsl:if>
		    
      	</xsl:otherwise>
     </xsl:choose>
     
     <xsl:call-template name="amt-details"/>
     
     <!-- Only for EL Transfer -->
     <xsl:if test="product_code[.='EL'] and sub_tnx_type_code[.!='19']">
     	<xsl:call-template name="additional-shipment-details"/>
    	<xsl:choose>
	      	<xsl:when test="$swift2018Enabled">
				<xsl:if test="not(($displaymode = 'view' and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'false') or ($displaymode = 'edit'))">
					<xsl:call-template name="view-mode-extedned-narrative">
						<xsl:with-param name="messageValue"><xsl:value-of select="narrative_description_goods"/></xsl:with-param>
						<xsl:with-param name="name">narrative_description_goods</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
	      		<xsl:call-template name="additional-narrative-details-swift2018"/>
	      		<xsl:choose>
	      			<xsl:when test="(($displaymode = 'view' and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'false') or ($displaymode = 'edit'))">
	      				<xsl:call-template name="el-narrative-special-payments"/>
	      			</xsl:when>
	      			<xsl:otherwise>
	      			<xsl:call-template name="view-mode-extedned-narrative">
						<xsl:with-param name="messageValue"><xsl:value-of select="narrative_special_beneficiary"/></xsl:with-param>
						<xsl:with-param name="name">narrative_special_beneficiary</xsl:with-param>
					</xsl:call-template>
	      			</xsl:otherwise>
	      		</xsl:choose>	      		
	      	</xsl:when>
	      	<xsl:otherwise>
	      		<xsl:call-template name="additional-narrative-details"/>
	      	</xsl:otherwise>
	    </xsl:choose> 
     </xsl:if>
     
    	 <xsl:call-template name="fieldset-wrapper">
		      <xsl:with-param name="legend">XSL_LEGACY_DETAILS_LABEL</xsl:with-param>
		      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
		      <xsl:with-param name="content">
		       		<xsl:call-template name="legacy-template"/>
		      </xsl:with-param>
		   </xsl:call-template>
     
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  
  <!--
   Additional Shipment Details
   -->
  <xsl:template name="additional-shipment-details">
  	 <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_HEADER_SHIPMENT_NARRATIVE_DETAILS</xsl:with-param>
	    <xsl:with-param name="content">
	     <!-- Last Shipment Date -->
	     <xsl:call-template name="input-field">
	      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_LAST_SHIP_DATE_TRANSFER</xsl:with-param>
	      <xsl:with-param name="name">last_ship_date</xsl:with-param>
	      <xsl:with-param name="size">10</xsl:with-param>
	      <xsl:with-param name="maxsize">10</xsl:with-param>
	      <xsl:with-param name="fieldsize">small</xsl:with-param>
	      <xsl:with-param name="button-type">date</xsl:with-param>
	      <xsl:with-param name="type">date</xsl:with-param>
	     </xsl:call-template>
	        <xsl:choose>
		<xsl:when test= "$displaymode = 'edit'">
         <xsl:call-template name="select-field">
	 	<xsl:with-param name="label">XSL_INCO_TERM_YEAR</xsl:with-param>
		<xsl:with-param name="name">inco_term_year</xsl:with-param>	 
		 <xsl:with-param name="fieldsize">small</xsl:with-param>
		  <xsl:with-param name="required">N</xsl:with-param>	 
	</xsl:call-template>
	   </xsl:when>
		<xsl:otherwise>
			<xsl:variable name="inco_year"><xsl:value-of select="inco_term_year"/></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_INCO_TERM_YEAR</xsl:with-param>
					<xsl:with-param name="name">inco_term_year_display</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="$inco_year"/></xsl:with-param>
				</xsl:call-template>
		</xsl:otherwise>
	 </xsl:choose>
	 <xsl:choose>
		<xsl:when test= "$displaymode = 'edit'">
	  <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_TERM_TRANSFER</xsl:with-param>
      <xsl:with-param name="name">inco_term</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      </xsl:call-template>
       </xsl:when>
		<xsl:otherwise>
		<xsl:variable name="incoTerm"><xsl:value-of select="inco_term"/></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_TERM_TRANSFER</xsl:with-param>
					<xsl:with-param name="name">inco_term_display</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*','*','N212',$incoTerm)"/></xsl:with-param>
				</xsl:call-template>
		</xsl:otherwise>
	 </xsl:choose>
	     <xsl:call-template name="input-field">
	      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_PLACE_TRANSFER</xsl:with-param>
	      <xsl:with-param name="name">inco_place</xsl:with-param>
	      <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('SHIPMENT_NAMED_PLACE_LENGTH')"/></xsl:with-param>
	     </xsl:call-template>
	    </xsl:with-param>
	   </xsl:call-template>	 
  </xsl:template>

   <!-- 
   Narratives
   
   Tab0 - Description of Goods Details
   Tab1 - Period for Presentation
   Tab2 - Shipment Period
  -->
  <xsl:template name="additional-narrative-details">
  	
  	<xsl:param name="in-fieldset">N</xsl:param><!-- Note: Issue if we put Y here. The first tab is not displayed -->
  	
   <!-- Tabgroup #1 : Narrative Details (3 Tabs) -->
   <xsl:call-template name="tabgroup-wrapper">
    
    <xsl:with-param name="tabgroup-label">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
   	<xsl:with-param name="in-fieldset"><xsl:value-of select="$in-fieldset"></xsl:value-of></xsl:with-param>
   	   
    <!-- Tab 0 - Description of Goods  -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS_TRANSFER</xsl:with-param>
    <xsl:with-param name="tab0-content"> 
     <!-- Form #1 : Narrative Description of Goods Details -->
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_description_goods</xsl:with-param>
      <xsl:with-param name="cols">65</xsl:with-param>
      <xsl:with-param name="rows">6</xsl:with-param>
      <xsl:with-param name="maxlines">100</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 1 - Period Presentation  -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_PERIOD_PRESENTATION_TRANSFER</xsl:with-param>
    <xsl:with-param name="tab1-content">
     <!-- Form #2 : Narrative Period Presentation -->
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_period_presentation</xsl:with-param>
      <xsl:with-param name="cols">35</xsl:with-param>
      <xsl:with-param name="rows">4</xsl:with-param>
      <xsl:with-param name="maxlines">4</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 2 - Shipment Period  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_SHIPMENT_PERIOD_TRANSFER</xsl:with-param>
    <xsl:with-param name="tab2-content">
     <!-- Form #3 : Narrative Shipment Period -->
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_shipment_period</xsl:with-param>
      <xsl:with-param name="rows">6</xsl:with-param>
      <xsl:with-param name="cols">65</xsl:with-param>
      <xsl:with-param name="maxlines">6</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
   <!-- 
   Narratives
   
   Tab0 - Description of Goods Details
   Tab1 - Period for Presentation
   Tab2 - Shipment Period
  -->
  <!-- new template for swift2018 -->
  <xsl:template name="additional-narrative-details-swift2018">
  	
  	<xsl:param name="in-fieldset">N</xsl:param><!-- Note: Issue if we put Y here. The first tab is not displayed -->
  	
   <!-- Tabgroup #1 : Narrative Details (3 Tabs) -->
   <xsl:call-template name="tabgroup-wrapper">
     <xsl:with-param name="tabgroup-height">180px;</xsl:with-param>
    <xsl:with-param name="tabgroup-label">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
   	<xsl:with-param name="in-fieldset"><xsl:value-of select="$in-fieldset"></xsl:value-of></xsl:with-param>
   	   
    <!-- Tab 0 - Description of Goods  -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS_TRANSFER</xsl:with-param>
    <xsl:with-param name="tab0-content"> 
     <!-- Form #1 : Narrative Description of Goods Details -->
     <xsl:if test="(($displaymode = 'view' and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'false') or ($displaymode = 'edit'))">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_description_goods</xsl:with-param>
      <xsl:with-param name="cols">65</xsl:with-param>
      <xsl:with-param name="rows">6</xsl:with-param>
        <xsl:with-param name="maxlines">
			<xsl:choose>
			   	<xsl:when test="$swift2018Enabled and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">800</xsl:when>
				<xsl:otherwise>100</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="button-type-ext-view">
	   		<xsl:choose>
	  			<xsl:when test="$swift2018Enabled and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">extended-narrative</xsl:when>
	  			<xsl:otherwise/>
 			</xsl:choose>
	  	</xsl:with-param>
	  	<xsl:with-param name="messageValue">
			<xsl:choose>
			   	<xsl:when test="$swift2018Enabled and product_code = 'EL' and (sub_tnx_type_code[.='12' or .='19'] and tnx_stat_code[.='01'])">
					<xsl:choose>
						<xsl:when test="tnx_stat_code[.='01' or .='02']"><xsl:value-of select="narrative_description_goods"/></xsl:when>
						<xsl:otherwise></xsl:otherwise>
					</xsl:choose>
				</xsl:when>
	 			<xsl:when test="$swift2018Enabled"><xsl:value-of select="//narrative_description_goods/issuance/data/datum/text"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="narrative_description_goods"/></xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
    </xsl:with-param>
     
    <!-- Tab 1 - Period Presentation  -->
   <!--  <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_PERIOD_PRESENTATION_TRANSFER</xsl:with-param> -->
   <xsl:with-param name="tab1-label">XSL_TAB_PERIOD_PRESENTATION_IN_DAYS_TRANSFER</xsl:with-param>   
    <xsl:with-param name="tab1-content">
    	<xsl:if test="$displaymode='edit'">
    		<xsl:value-of select="localization:getGTPString($language, 'XSL_PERIOD_NO_OF_DAYS')"/>
			<div class="x-small" maxLength="3" dojoType="dijit.form.NumberTextBox" trim="true">
				<xsl:attribute name="id">period_presentation_days</xsl:attribute>
				<xsl:attribute name="name">period_presentation_days</xsl:attribute>
				<xsl:attribute name="value">
					<xsl:value-of select="period_presentation_days"/>
				</xsl:attribute>
				<xsl:attribute name="constraints">{places:'0',min:0, max:999}</xsl:attribute>			
			</div>
		</xsl:if>
		<xsl:if test="period_presentation_days[.!=''] and $displaymode='view'">
			<div>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_PERIOD_NO_OF_DAYS')"/>
				<b><xsl:value-of select="period_presentation_days"/></b>	
			</div>
		</xsl:if>
     	<!-- Form #2 : Narrative Period Presentation -->
     	<xsl:if test="$displaymode='edit'">
     	    <div>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_TAB_PERIOD_DESCRIPTION')"/> 
			</div>
			<div> 
				<xsl:call-template name="textarea-field">
					<xsl:with-param name="name">narrative_period_presentation</xsl:with-param>
					<xsl:with-param name="cols">35</xsl:with-param>
					<xsl:with-param name="rows">4</xsl:with-param>
					<xsl:with-param name="maxlines">1</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:if>
		<xsl:if test="narrative_period_presentation[.!=''] and $displaymode='view'">
			<div>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_TAB_PERIOD_DESCRIPTION')"/>
				<b><xsl:value-of select="narrative_period_presentation"/></b>	
			</div>
		</xsl:if>
    </xsl:with-param>
     
    <!-- Tab 2 - Shipment Period  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_SHIPMENT_PERIOD_TRANSFER</xsl:with-param>
    <xsl:with-param name="tab2-content">
     <!-- Form #3 : Narrative Shipment Period -->
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_shipment_period</xsl:with-param>
      <xsl:with-param name="rows">6</xsl:with-param>
      <xsl:with-param name="cols">65</xsl:with-param>
      <xsl:with-param name="maxlines">6</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- END NEW CODE -->
  <!-- Swift 2018 -->
  <xsl:template name="el-narrative-special-payments">
    <xsl:call-template name="tabgroup-wrapper">
	<xsl:with-param name="tabgroup-height">350px;</xsl:with-param>
	<xsl:with-param name="in-fieldset">N</xsl:with-param>
    <!-- Tab 0 - Special payment conditions for Beneficiary -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVE_TAB_SPECIAL_PMNT_CON_BENEF_TNF_HEAD</xsl:with-param>
    <xsl:with-param name="tab0-content">
     <xsl:call-template name="textarea-field">
      <xsl:with-param name="name">narrative_special_beneficiary</xsl:with-param>
      	<xsl:with-param name="maxlines">
			<xsl:choose>
				<xsl:when test="$swift2018Enabled and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">800</xsl:when>
				<xsl:otherwise>100</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="button-type-ext-view">
	   		<xsl:choose>
	  			<xsl:when test="$swift2018Enabled and defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">extended-narrative</xsl:when>
	  			<xsl:otherwise/>
 			</xsl:choose>
	  	</xsl:with-param>
       <xsl:with-param name="messageValue">
      		 <xsl:if test="$swift2018Enabled and product_code = 'EL' and (sub_tnx_type_code[.='12' or .='19'] and tnx_stat_code[.='01'])">
		   	 <xsl:value-of select="narrative_special_beneficiary"/></xsl:if>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
    <!-- Tab 1 - Special payment conditions for Receiving Bank -->
    </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="view-mode-extedned-narrative">
    	<xsl:param name="messageValue"/>
    	<xsl:param name="name"/>
   		<xsl:if test="$messageValue!=''">
   		<div class="indented-header">
			<h3 class="toc-item">
				<span class="legend">
					<xsl:choose>
						<xsl:when test = "$name = 'narrative_description_goods'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS_TRANSFER')" /></xsl:when>
						<xsl:when test = "$name = 'narrative_special_beneficiary'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_TAB_SPECIAL_PMNT_CON_BENEF_TNF_HEAD')" /></xsl:when>
						<xsl:when test = "$name = 'narrative_special_recvbank'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_TAB_SPECIAL_PMNT_CON_RECEIV_TNF_HEAD')" /></xsl:when>
					</xsl:choose>
					<xsl:call-template name="get-button">
						<xsl:with-param name="button-type">extended-narrative</xsl:with-param>
						<xsl:with-param name="id"><xsl:value-of select="$name" /></xsl:with-param>
						<xsl:with-param name="messageValue"><xsl:value-of select="$messageValue" /></xsl:with-param>
						<xsl:with-param name="non-dijit-button">Y</xsl:with-param>
					</xsl:call-template>
				</span>
			</h3>				
			<xsl:call-template name="textarea-field">
				<xsl:with-param name="id"><xsl:value-of select="$name" /></xsl:with-param>
				<xsl:with-param name="messageValue"><xsl:value-of select="convertTools:displaySwiftNarrative($messageValue, 12)" /></xsl:with-param>
			</xsl:call-template>
		</div>  
		</xsl:if>  
    </xsl:template>
  <!-- 
   Amount Details
   -->
  <xsl:template name="amt-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_ORG_LC_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">lc</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name">org_lc_amt</xsl:with-param>
      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
      <xsl:with-param name="override-amt-value"><xsl:value-of select="lc_amt"/></xsl:with-param>
     </xsl:call-template>
    <div id="utilizedAmt" style="display:none;">
 	 <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_ELC_UTILIZED_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="product-code">lc</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-amt-name">utilized_amt</xsl:with-param>
      <xsl:with-param name="amt-readonly">Y</xsl:with-param>
      <xsl:with-param name="override-amt-value"><xsl:value-of select="utilized_amt"/></xsl:with-param>
     </xsl:call-template>
     
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">utilized_amt_cur_code</xsl:with-param>
        <xsl:with-param name="value" select="utilized_amt_cur_code"/>
     </xsl:call-template>
     </div>
    <xsl:choose>
      	<xsl:when test="sub_tnx_type_code[.='19']">
      		<xsl:call-template name="checkbox-field">
	         <xsl:with-param name="label">XSL_AMOUNTDETAILS_FULL_ASG_AMT_LABEL</xsl:with-param>
	         <xsl:with-param name="name">full_trf_flag</xsl:with-param>
	         <xsl:with-param name="value"><xsl:if test="lc_amt=tnx_amt">Y</xsl:if></xsl:with-param>
	        </xsl:call-template>
		     <xsl:call-template name="currency-field">
		      <xsl:with-param name="label">XSL_AMOUNTDETAILS_ASG_AMT_LABEL</xsl:with-param>
		      <xsl:with-param name="product-code">lc</xsl:with-param>
		      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
		      <xsl:with-param name="override-currency-name">lc_cur_code</xsl:with-param>
		      <xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param>
		      <!-- Fin message genration rely on this value. So, marking tnx_amt mandatory -->
		      <xsl:with-param name="required">Y</xsl:with-param>
		     </xsl:call-template> 
      	</xsl:when>
      	<xsl:when test="sub_tnx_type_code[.='12']">
      	<div id="fullTrf" style="margin-left:-43px">
			<xsl:call-template name="checkbox-field">
				<xsl:with-param name="label">XSL_AMOUNTDETAILS_FULL_TRF_AMT_LABEL</xsl:with-param>
				<xsl:with-param name="name">full_trf_flag</xsl:with-param>
				<xsl:with-param name="value"><xsl:if test="lc_amt=tnx_amt">Y</xsl:if></xsl:with-param>
			</xsl:call-template>
			</div>
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_AMOUNTDETAILS_TRF_AMT_LABEL</xsl:with-param>
				<xsl:with-param name="product-code">lc</xsl:with-param>
				<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
				<xsl:with-param name="override-currency-name">lc_cur_code</xsl:with-param>
				<xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param>
				<!-- Fin message genration rely on this value. So, marking tnx_amt mandatory -->
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
      	</xsl:when>
      	<xsl:otherwise>
      		<xsl:call-template name="checkbox-field">
	         <xsl:with-param name="label">XSL_AMOUNTDETAILS_FULL_TRF_AMT_LABEL</xsl:with-param>
	         <xsl:with-param name="name">full_trf_flag</xsl:with-param>
	         <xsl:with-param name="value"><xsl:if test="lc_amt=tnx_amt">Y</xsl:if></xsl:with-param>
	        </xsl:call-template>
		     <xsl:call-template name="currency-field">
		      <xsl:with-param name="label">XSL_AMOUNTDETAILS_TRF_AMT_LABEL</xsl:with-param>
		      <xsl:with-param name="product-code">lc</xsl:with-param>
		      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
		      <xsl:with-param name="override-currency-name">lc_cur_code</xsl:with-param>
		      <xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param>
		     </xsl:call-template>
      	</xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="applicable-rules"/>
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
      <xsl:choose>
      	<xsl:when test="sub_tnx_type_code[.='19']">
      		<xsl:call-template name="hidden-field">
	         <xsl:with-param name="name">option</xsl:with-param>
	         <xsl:with-param name="value">ASSIGNEE</xsl:with-param>
	        </xsl:call-template>
      	</xsl:when>
      	<xsl:otherwise>
      		<xsl:call-template name="hidden-field">
	         <xsl:with-param name="name">option</xsl:with-param>
	         <xsl:with-param name="value">TRANSFER</xsl:with-param>
	        </xsl:call-template>
      	</xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="e2ee_transaction"/>
      <xsl:call-template name="reauth_params"/>      
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>