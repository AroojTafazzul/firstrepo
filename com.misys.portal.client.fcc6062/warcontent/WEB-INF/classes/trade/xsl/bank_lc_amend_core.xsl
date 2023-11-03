<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Letter of Credit (LC) Amend Form, Bank Side.

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
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
    xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
    exclude-result-prefixes="localization defaultresource securitycheck ">
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">LC</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
  <xsl:param name="show-eucp">N</xsl:param>
  <xsl:param name="Goods_description"/>
  <xsl:param name="Documents_required"/>
  <xsl:param name="Additional_Conditions"/>
  <xsl:param name="Amendment_Narrative"/>
  <xsl:param name="Discrepant_Details"/>

  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" />
  <xsl:include href="../../core/xsl/common/amend_common.xsl" />
  <xsl:include href="../../trade/xsl/bank_lc_reporting.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="lc_tnx_record"/>
  </xsl:template>
 
 <!-- 
   LC TNX FORM TEMPLATE.
  -->
  <xsl:template match="lc_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>

   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Display common reporting area -->
    <xsl:call-template name="bank-reporting-area"/>
    <xsl:call-template name="build-inco-terms-data"/>
    <!-- Attachments -->
    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
     <xsl:call-template name="attachments-file-dojo">
       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
       <xsl:with-param name="title-size">35</xsl:with-param>
      </xsl:call-template> 
	</xsl:if>
    
    <!-- Link to display transaction contents -->
    <xsl:call-template name="transaction-details-link">
		<xsl:with-param name="show-transaction">
			<xsl:choose>
				<xsl:when test="tnx_type_code[.!='01'] or (tnx_type_code[.='01'] and $displaymode = 'edit')">N</xsl:when>
				<xsl:otherwise>Y</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:choose>
	<xsl:when test="not($swift2018Enabled)">
		<div id="transactionDetails">
	     <xsl:call-template name="form-wrapper">
	      <xsl:with-param name="name" select="$main-form-name"/>
	      <xsl:with-param name="validating">Y</xsl:with-param>
	      <xsl:with-param name="content">
	       <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
	       
	       <!-- Disclaimer Notice -->
	       <xsl:call-template name="disclaimer"/>
	       
	       <xsl:call-template name="hidden-fields-swift-off"/>
	       <xsl:call-template name="general-details-swift-off"/>
	       <xsl:call-template name="amend-amt-details">
	        <xsl:with-param name="show-os-amt">Y</xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="amend-shipment-details"/>
	       <xsl:call-template name="amend-narrative"/>
	       <xsl:call-template name="other-info"/>
			<xsl:choose>
				<xsl:when
					test="$displaymode = 'view' and stnd_by_lc_flag = 'Y'">
					<xsl:call-template name="lc-delivery-instructions" />
				</xsl:when>
				<xsl:when test="$displaymode = 'edit'">
					<div id="deliveryInstructions" style="display:none;">
						<xsl:call-template name="lc-delivery-instructions" />
					</div>
				</xsl:when>
			</xsl:choose>
	      </xsl:with-param>
	     </xsl:call-template>
	   </div>
	</xsl:when>
	<xsl:otherwise>
	 <xsl:call-template name="amendedNarrativesStore"/>
     
     <div id="transactionDetails">
      <xsl:if test="$displaymode='view'">
       <xsl:attribute name="style">position:relative;left:0;</xsl:attribute>
      </xsl:if>
      <xsl:call-template name="form-wrapper">
       <xsl:with-param name="name" select="$main-form-name"/>
       <xsl:with-param name="validating">Y</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:if test="tnx_type_code[.!='01']">
         <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
        </xsl:if>
        
        <!-- Disclaimer Notice -->
        <xsl:call-template name="disclaimer"/>
        
        <xsl:call-template name="hidden-fields"/>
        <xsl:call-template name="general-details" />
        
        <xsl:choose>
        	<xsl:when test="defaultresource:getResource('STANDBY_CHECKBOX_DISABLED') = 'true'">
	        	<xsl:call-template name="lc-amt-details-swift2018">
		        <xsl:with-param name="override-product-code">lc</xsl:with-param>
		        <xsl:with-param name="show-bank-confirmation">N</xsl:with-param>
		        <xsl:with-param name="show-available-amt">Y</xsl:with-param>
		 		<xsl:with-param name="show-liability-amt">Y</xsl:with-param>
		        <xsl:with-param name="show-form-lc"><xsl:if test="lc_type[.!='04']">Y</xsl:if></xsl:with-param>
		        <xsl:with-param name="show-variation-drawing"><xsl:if test="lc_type[.!='04']">Y</xsl:if></xsl:with-param>
		        <xsl:with-param name="show-revolving">Y</xsl:with-param>
		        <xsl:with-param name="show-standby">N</xsl:with-param>
	            </xsl:call-template>
        	</xsl:when>
        	<xsl:when test="$swift2019Enabled">
	        	<xsl:call-template name="lc-amt-details-swift2018">
		        <xsl:with-param name="override-product-code">lc</xsl:with-param>
		        <xsl:with-param name="show-bank-confirmation">N</xsl:with-param>
		        <xsl:with-param name="show-available-amt">Y</xsl:with-param>
		 		<xsl:with-param name="show-liability-amt">Y</xsl:with-param>
		        <xsl:with-param name="show-form-lc"><xsl:if test="lc_type[.!='04']">Y</xsl:if></xsl:with-param>
		        <xsl:with-param name="show-variation-drawing"><xsl:if test="lc_type[.!='04']">Y</xsl:if></xsl:with-param>
		        <xsl:with-param name="show-revolving">Y</xsl:with-param>
		        <xsl:with-param name="show-standby"><xsl:if test="security:isBank($rundata)">Y</xsl:if></xsl:with-param>
	            </xsl:call-template>
        	</xsl:when>
        	<xsl:otherwise>
		        <xsl:call-template name="lc-amt-details-swift2018">
			        <xsl:with-param name="override-product-code">lc</xsl:with-param>
			        <xsl:with-param name="show-bank-confirmation">N</xsl:with-param>
			        <xsl:with-param name="show-available-amt">Y</xsl:with-param>
			 		<xsl:with-param name="show-liability-amt">Y</xsl:with-param>
			        <xsl:with-param name="show-form-lc"><xsl:if test="lc_type[.!='04']">Y</xsl:if></xsl:with-param>
			        <xsl:with-param name="show-variation-drawing"><xsl:if test="lc_type[.!='04']">Y</xsl:if></xsl:with-param>
			        <xsl:with-param name="show-revolving">Y</xsl:with-param>
		        </xsl:call-template>
        	</xsl:otherwise>
        </xsl:choose>
        
        
   		
        <xsl:choose>
      		<xsl:when test="$displaymode = 'view' and revolving_flag = 'Y'">
      			<xsl:call-template name="lc-revolving-details" />
     	    </xsl:when>
            <xsl:when test="$displaymode = 'edit'">
	      		<div id="revolving-details" style="display:none;">
	      		<xsl:call-template name="lc-revolving-details" />
	      		</div>
      		</xsl:when>
     	</xsl:choose>
      <xsl:choose>
	      <xsl:when test="$displaymode = 'view' and stnd_by_lc_flag = 'Y' and $swift2019Enabled and security:isBank($rundata)">
	      	<xsl:call-template name="lc-renewal-details" />
	      </xsl:when>
	      <xsl:when test="$displaymode = 'edit' and $swift2019Enabled and security:isBank($rundata)">
		      <div id="renewalDetails" style="display:none;">
		      	<xsl:call-template name="lc-renewal-details" />
		      </div>
	      </xsl:when>
      </xsl:choose>
        <xsl:call-template name="payment-details"/>
    	<xsl:call-template name="shipment-details-swift2018"/>
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
			   	  	<xsl:call-template name="facility-limit-section">
				  	  	<xsl:with-param name="isBank">Y</xsl:with-param>
				  	</xsl:call-template>
		  	 </xsl:if>
	   	 </xsl:otherwise>
   	 </xsl:choose>

        <xsl:if test="securitycheck:hasPermission($rundata,'tradeadmin_ls_access') = 'true' and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true'">
			<xsl:call-template name="linked-ls-declaration"/>
	 		<xsl:call-template name="linked-licenses"/>
	   </xsl:if>
        
        <xsl:choose>
         <xsl:when test="lc_type[.='04']">
          <xsl:call-template name="fieldset-wrapper">
           <xsl:with-param name="legend">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
           <xsl:with-param name="content">
            <xsl:call-template name="textarea-field">
             <xsl:with-param name="name">narrative_full_details</xsl:with-param>
             <xsl:with-param name="rows">16</xsl:with-param>
            </xsl:call-template>
           </xsl:with-param>
          </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
         
	      <xsl:call-template name="bank-details-swift2018"/>
          <div id="view-narrative-swift">
      		<xsl:if test="$displaymode = 'edit'">
      		<xsl:call-template name="view-narrative-swift-details"/>
      		<xsl:call-template name="view-narrative-swift-special-payments"/>
     		</xsl:if>
     	   </div>
      		<div id="amend_narratives_display">
	        <xsl:if test="$displaymode = 'edit'">
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
			   </xsl:call-template>
	         <xsl:call-template name="lc-narrative-swift-special-payments"/>
	        </xsl:if>
	        </div>
	        <xsl:if test="$displaymode = 'view'">
		     <xsl:call-template name="fieldset-wrapper">
			    <xsl:with-param name="legend">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
			    <xsl:with-param name="in-fieldset">Y</xsl:with-param>
			    <xsl:with-param name="content">
				<xsl:call-template name="previewModeExtendedNarrative"/>
				</xsl:with-param>
			</xsl:call-template> 
			</xsl:if>
	      
	      <xsl:call-template name="lc-narrative-charges-swift2018"/>
          <xsl:call-template name="lc-bank-narrative-other"/>
          <xsl:choose>
          <xsl:when test="lc_type ='02' and $displaymode='edit'">
        	<xsl:call-template name="lc-narrative-full">
        		<xsl:with-param name="label">XSL_HEADER_FREEFORMAT_NARRATIVE</xsl:with-param>
        		<xsl:with-param name="readonly">Y</xsl:with-param>
        		<xsl:with-param name="button-required">N</xsl:with-param>
            </xsl:call-template>  
          </xsl:when>
          <xsl:when test="$displaymode='view' and (narrative_full_details != '')">
          	<xsl:call-template name="lc-narrative-full">
          		<xsl:with-param name="label">XSL_HEADER_FREEFORMAT_NARRATIVE</xsl:with-param>
          	</xsl:call-template>
          </xsl:when>
          </xsl:choose>
         </xsl:otherwise>
        </xsl:choose>
       
        <xsl:call-template name="instructions-send-mode"/>
		
			<xsl:choose>
				<xsl:when
					test="$displaymode = 'view' and stnd_by_lc_flag = 'Y'">
					<xsl:call-template name="lc-delivery-instructions" />
				</xsl:when>
				<xsl:when test="$displaymode = 'edit'">
					<div id="deliveryInstructions" style="display:none;">
						<xsl:call-template name="lc-delivery-instructions" />
					</div>
				</xsl:when>
			</xsl:choose>
	     
	    	<xsl:call-template name="fieldset-wrapper">
	      <xsl:with-param name="legend">XSL_LEGACY_DETAILS_LABEL</xsl:with-param>
	      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	      <xsl:with-param name="content">
	       		<xsl:call-template name="legacy-template"/>
	      </xsl:with-param>
	     </xsl:call-template>
        
       </xsl:with-param>
      </xsl:call-template>
     </div>
	</xsl:otherwise>
	</xsl:choose>

  <xsl:call-template name="menu">
   <xsl:with-param name="show-template">N</xsl:with-param>
   <xsl:with-param name="second-menu">Y</xsl:with-param>
  </xsl:call-template>
 </div>
  
 <!-- Table of Contents -->
 <xsl:call-template name="toc"/>

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
		  <xsl:with-param name="binding">
		  <xsl:choose>
			  <xsl:when test="not($swift2018Enabled)">misys.binding.bank.amend_lc</xsl:when>
			  <xsl:otherwise>misys.binding.bank.report_lc</xsl:otherwise>
		  </xsl:choose>
		  </xsl:with-param>
		   <xsl:with-param name="show-period-js">Y</xsl:with-param>
		   <xsl:with-param name="override-help-access-key">IMP_NOT</xsl:with-param>
	  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields-swift-off">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="show-type">N</xsl:with-param>
  </xsl:call-template>
  
  <!-- For new messages from customer, don't empty the principal and fee accounts-->
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
    <xsl:with-param name="value" select="issuing_bank/abbv_name"/>
   </xsl:call-template>
  <!--  <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">tnx_amt</xsl:with-param>
   </xsl:call-template> -->
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
    <xsl:with-param name="name">tnx_amt</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_narrative_shipment_period</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/narrative_shipment_period"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_narrative_additional_amount</xsl:with-param>
    <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/narrative_additional_amount"/>
   </xsl:call-template>
  </div>
 </xsl:template>
 
 <!--
  General Details 
  -->
 <xsl:template name="general-details-swift-off">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <div id="generaldetails">
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
      <xsl:with-param name="id">org_previous_iss_date_view</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/iss_date"/>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_iss_date</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/iss_date"/>
     </xsl:call-template>
      
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_ORG_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="id">org_previous_exp_date_view</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/exp_date"/>
      <xsl:with-param name="override-displaymode">view</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_exp_date</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/exp_date"/>
     </xsl:call-template>
      
     <!--  Expiry Date. --> 
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_NEW_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="name">exp_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
      <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">lc_liab_amt</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/lc_liab_amt"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">org_lc_liab_amt</xsl:with-param>
      <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/lc_liab_amt"/>
     </xsl:call-template>
    </div>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- 
  LC Other Info
  -->
 <xsl:template name="other-info">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_INSTRUCTIONS_OTHER_INFORMATION</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_INSTRUCTIONS_REQ_SEND_MODE_LABEL</xsl:with-param>
     <xsl:with-param name="name">adv_send_mode</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="options">
      <xsl:choose>
       <xsl:when test="$displaymode='edit'">
	      <option value="01">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/>
	      </option>
	      <option value="02">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/>
	      </option>
       </xsl:when>
       <xsl:otherwise>
        <xsl:choose>
         <xsl:when test="adv_send_mode[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/></xsl:when>
         <xsl:when test="adv_send_mode[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/></xsl:when>
        </xsl:choose>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_PARTIESDETAILS_ADVISING_BANK_LC_REFERENCE</xsl:with-param>
     <xsl:with-param name="name">advising_bank_lc_ref_id</xsl:with-param>
     <xsl:with-param name="size">16</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="row-wrapper">
     <xsl:with-param name="id">narrative_sender_to_receiver</xsl:with-param>
     <xsl:with-param name="label">XSL_NARRATIVEDETAILS_TAB_SENDER_TO_RECEIVER</xsl:with-param>
     <xsl:with-param name="type">textarea</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="textarea-field">
       <xsl:with-param name="name">narrative_sender_to_receiver</xsl:with-param>
       <xsl:with-param name="rows">6</xsl:with-param>
       <xsl:with-param name="cols">35</xsl:with-param>
       <xsl:with-param name="maxlines">6</xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
</xsl:stylesheet>