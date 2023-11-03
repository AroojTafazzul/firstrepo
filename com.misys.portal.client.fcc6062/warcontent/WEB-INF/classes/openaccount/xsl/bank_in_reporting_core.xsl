<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Invoice Payable Form (IP), Bank Side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
base version: 1.4
date:      24/1/2014
author:   Yashaswini.M
email:    yashaswini.m@misys.com
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
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">IN</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
  <xsl:param name="show-eucp">N</xsl:param>
  
  <!-- All marks used to shown/hidden form's sections-->
	<xsl:param name="section_po_line_items" />
	<xsl:param name="section_po_amount_details" />
	<xsl:param name="section_amount_details">Y</xsl:param>
	<xsl:param name="section_po_payment_terms">Y</xsl:param>
	<xsl:param name="section_po_settlement_terms">Y</xsl:param>
	<xsl:param name="section_po_documents_required">Y</xsl:param>
	<xsl:param name="section_po_shipment_details">Y</xsl:param>
	<xsl:param name="section_po_inco_terms">Y</xsl:param>
	<xsl:param name="section_po_routing_summary">Y</xsl:param>
	<xsl:param name="section_po_user_info">Y</xsl:param>
	<xsl:param name="section_po_contact">N</xsl:param>
	<xsl:param name="section_po_adjustements_details">Y</xsl:param>
	<xsl:param name="section_po_taxes_details">Y</xsl:param>
	<xsl:param name="section_po_freight_charges_details">Y</xsl:param>	
	<xsl:param name="section_line_item_adjustments_details">Y</xsl:param>	
	<xsl:param name="section_line_item_taxes_details">Y</xsl:param>
	<xsl:param name="section_line_item_freight_charges_details">Y</xsl:param>
	<xsl:param name="section_line_item_shipment_details">Y</xsl:param>
	<xsl:param name="section_shipment_sub_schedule">N</xsl:param>
	<xsl:param name="section_line_item_inco_terms_details">Y</xsl:param>
	<xsl:param name="section_line_item_po_reference">N</xsl:param>
	<xsl:param name="section_line_item_routing_summary">N</xsl:param>	
	<xsl:param name="show-template">N</xsl:param>
	<xsl:param name="product-currency-label">XSL_INVOICE_PAYABLE_CURRENCY_CODE</xsl:param>
	<xsl:param name="section_line_item_total_net_amount_details">Y</xsl:param>
	<xsl:param name="section_po_seller_reference">Y</xsl:param>	
 
  <!-- Global Imports. -->
  <xsl:include href="po_common.xsl" />
  <xsl:include href="../../core/xsl/products/product_addons.xsl" />
  <xsl:include href="../../core/xsl/common/fscm_bank_common.xsl" />
 <!--  <xsl:include href="../../core/xsl/products/product_addons.xsl" /> -->
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="in_tnx_record"/>
  </xsl:template>
 
 <!-- 
   IP TNX FORM TEMPLATE.
  -->
  <xsl:template match="in_tnx_record"> 
	   <!-- Preloader  -->
	   <xsl:call-template name="loading-message"/>
	   <!-- Line Items declaration -->
		<xsl:call-template name="line-items-declaration" />
		<!-- Product Identifiers declaration -->
		<xsl:call-template name="product-identifiers-declaration" />
		<!-- Product Categories declaration -->
		<xsl:call-template name="product-categories-declaration" />
		<!-- Product Characteristics declaration -->
		<xsl:call-template name="product-characteristics-declaration" />
		<!-- Adjustments declaration -->
		<xsl:call-template name="adjustments-declaration" />
		<!-- Payments declaration -->
		<xsl:call-template name="payments-declaration" />
		<!-- Taxes declaration -->
		<xsl:call-template name="taxes-declaration" />
		<!-- Freight Charges declaration -->
		<xsl:call-template name="freight-charges-declaration" />
		<!-- Incoterms declaration -->
		<xsl:call-template name="incoterms-declaration" />
		<!-- User defined informations declaration buyer -->
		<xsl:call-template name="user-defined-informations-declaration">
			<xsl:with-param name="user_info_type">01</xsl:with-param>
		</xsl:call-template>
		<!-- User defined informations declaration seller -->
		<xsl:call-template name="user-defined-informations-declaration" >
			<xsl:with-param name="user_info_type">02</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="contact-details-declaration" />
		<xsl:call-template name="sub-shipment-schedule-declaration"/>
		<xsl:call-template name="routing-summary-declaration" />
   		<div>
   			<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    		<!-- Display common reporting area -->
    		<xsl:call-template name="bank-reporting-area"/>

		    <!-- Link to display transaction contents -->
		    <!-- <xsl:call-template name="transaction-details-link"/> -->
    
    		<div id="transactionDetails">
	     		<xsl:if test="tnx_type_code[.='01']">
	     			<xsl:attribute name="style">display:block;</xsl:attribute>
	     		</xsl:if>
    		
     
				<!-- Form #0 : Main Form -->
				<xsl:call-template name="form-wrapper">
					<xsl:with-param name="name" select="$main-form-name" />
					<xsl:with-param name="validating">Y</xsl:with-param>
					<xsl:with-param name="content">
						<!-- Disclaimer Notice -->
	        			<xsl:call-template name="disclaimer"/>
	        
	        			<xsl:call-template name="hidden-fields"/>
				        <xsl:if test="tnx_type_code[.='01'] and release_dttm[.='']">
				        	<xsl:call-template name="instructions-send-mode"/>
				        </xsl:if>
	        
							<xsl:call-template name="general-details" />
							<!-- Goods details -->
							<xsl:call-template name="goods-details" />
							<!-- Amount details -->
							<xsl:if test="$section_po_amount_details!='N'">
								<xsl:call-template name="amount-details" />
							</xsl:if>
							<!-- Payment details -->
							<xsl:if test="$section_po_payment_terms!='N'">
								<xsl:call-template name="payment-terms" />
							</xsl:if>
							<!--Settlement Terms Details-->
							<xsl:if test="$section_po_settlement_terms!='N'">
								<xsl:call-template name="settlement-terms" />
							</xsl:if>
							<!--Documents required Details-->
							<xsl:if test="$section_po_documents_required!='N'">
								<xsl:call-template name="documents-required" />
							</xsl:if>
							<!--Shipment Details-->
							<xsl:if test="$section_po_shipment_details!='N'">
								<xsl:call-template name="shipment-details" />
							</xsl:if>
							<!--Inco Terms-->
							<xsl:if test="$section_po_inco_terms!='N'">
								<xsl:call-template name="inco-terms" />
							</xsl:if>
							<!--Routing summary Details-->
							<xsl:if test="$section_po_routing_summary!='N'">
								<xsl:call-template name="routing-summary" />
							</xsl:if>
							<!--User Details-->
							<xsl:if test="$section_po_user_info!='N'">
								<xsl:call-template name="user-details" />
							</xsl:if>
							<!--Contact Details-->
							<xsl:if test="$section_po_contact!='N' and tnx_type_code[.!='03']">
								<xsl:call-template name="contact-details" />
							</xsl:if>
							
							<xsl:choose>
								<xsl:when test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
									<xsl:call-template name="attachments-file-dojo">
										<xsl:with-param name="attachment-group">invoice</xsl:with-param>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="attachments-file-dojo">
							          	<xsl:with-param name="existing-attachments" select="attachments/attachment[type = '01']"/>
							          	<xsl:with-param name="legend">XSL_HEADER_CUSTOMER_FILE_UPLOAD</xsl:with-param>
							          	<xsl:with-param name="attachment-group">summarycustomer</xsl:with-param>
						          	</xsl:call-template>
						          	<xsl:call-template name="attachments-file-dojo">
							          	<xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
							          	<xsl:with-param name="legend">XSL_HEADER_BANK_FILE_UPLOAD</xsl:with-param>
							          	<xsl:with-param name="attachment-group">summarybank</xsl:with-param>
						          	</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
		
					</xsl:with-param>
				</xsl:call-template>
			</div>
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
   <xsl:with-param name="binding">misys.binding.bank.report_in</xsl:with-param>
   <xsl:with-param name="override-help-access-key">
	   <xsl:choose>
	   	<xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
	   	<xsl:otherwise>PR_01</xsl:otherwise>
	   </xsl:choose>
   </xsl:with-param> 
   <xsl:with-param name="show-period-js">Y</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 	<!-- Additional hidden fields for this form are  -->
	<!-- added here. -->
	<xsl:template name="hidden-fields">
		<xsl:call-template name="common-hidden-fields" />
		<div class="widgetContainer">
		<xsl:if test="$displaymode='view'">
			<!-- This field is sent in the unsigned view -->
			
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:value-of select="issuing_bank/abbv_name" />
					</xsl:with-param>
				</xsl:call-template>
			
		</xsl:if>
		</div>
	</xsl:template>
 <!--
  Advising / Advise Thru Bank
 -->
 <xsl:template match="advising_bank | advise_thru_bank">
  <xsl:param name="prefix"/>

  <!-- Name. -->
  <xsl:call-template name="input-field">
   <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
   <xsl:with-param name="value" select="name"/>
   <xsl:with-param name="required">
   <xsl:choose>
   		<xsl:when test="$prefix ='advising_bank'">Y</xsl:when>
   		<xsl:when test="$prefix ='advise_thru_bank'">N</xsl:when>
   </xsl:choose>
   </xsl:with-param>
   <xsl:with-param name="button-type"><xsl:value-of select="$prefix"/></xsl:with-param>
  </xsl:call-template>
   
  <!-- Address Lines -->
  <xsl:call-template name="input-field">
   <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_1</xsl:with-param>
   <xsl:with-param name="value" select="address_line_1"/>
   <xsl:with-param name="required">
   <xsl:choose>
   		<xsl:when test="$prefix ='advising_bank'">Y</xsl:when>
   		<xsl:when test="$prefix ='advise_thru_bank'">N</xsl:when>
   </xsl:choose>
   </xsl:with-param>
  </xsl:call-template>
  <xsl:call-template name="input-field">
   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_2</xsl:with-param>
   <xsl:with-param name="value" select="address_line_2"/>
  </xsl:call-template>
  <xsl:call-template name="input-field">
   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_dom</xsl:with-param>
   <xsl:with-param name="value" select="dom"/>
  </xsl:call-template>
  <xsl:choose>
  <xsl:when test="$prefix='advising_bank'">
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_JURISDICTION_BIC_CODE</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_iso_code</xsl:with-param>
    <xsl:with-param name="value" select="iso_code"/>
    <xsl:with-param name="size">11</xsl:with-param>
    <xsl:with-param name="maxsize">11</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_reference</xsl:with-param>
    <xsl:with-param name="value" select="reference"/>
    <xsl:with-param name="size">16</xsl:with-param>
    <xsl:with-param name="maxsize">64</xsl:with-param>
   </xsl:call-template>
  </xsl:when>
  <xsl:otherwise>
   <div>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">advise_thru_bank_iso_code</xsl:with-param>
     <xsl:with-param name="value" select="iso_code"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">advise_thru_bank_reference</xsl:with-param>
     <xsl:with-param name="value" select="reference"/>
    </xsl:call-template>
   </div>
  </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!--LC Instructions / Send Mode  -->
 <xsl:template name="instructions-send-mode">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_INSTRUCTIONS_REQ_SEND_MODE_LABEL</xsl:with-param>
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
	      <option value="03">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/>
	      </option>
	   </xsl:when>
	   <xsl:otherwise>
	    <xsl:choose>
          <xsl:when test="adv_send_mode[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/></xsl:when>
          <xsl:when test="adv_send_mode[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/></xsl:when>
          <xsl:when test="adv_send_mode[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/></xsl:when>
         </xsl:choose>
	   </xsl:otherwise>
	  </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>  
 </xsl:template>
 
 	<xsl:template name="general-details">
 		<xsl:call-template name="common-general-details" >
 			<xsl:with-param name="section_po_seller_reference">Y</xsl:with-param>
 		</xsl:call-template>
	</xsl:template>
	
		<!--
		Goods Details Fieldset. 
		-->
	<xsl:template name="goods-details">
		<xsl:call-template name="common-goods-details" >
			<xsl:with-param name="section_po_line_items" />
		</xsl:call-template>
	</xsl:template>
	
		<!-- Amount Details Fieldset. -->
	<xsl:template name="amount-details">
		<xsl:call-template name="common-amount-details" >
			<xsl:with-param name="section_amount_details">Y</xsl:with-param>
			<xsl:with-param name="section_po_adjustements_details">Y</xsl:with-param>
			<xsl:with-param name="section_po_taxes_details">Y</xsl:with-param>
			<xsl:with-param name="section_po_freight_charges_details">Y</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
		<!--  Payment Details Fieldset. -->
	<xsl:template name="payment-terms">
		<xsl:call-template name="common-payment-terms" />							
	</xsl:template>
	
		
	<!--  Settlment Details Fieldset. -->
	<xsl:template name="settlement-terms">
		<xsl:call-template name="common-settlement-terms" />							
	</xsl:template>
	
	<!--  Bank Details Fieldset. -->
	<xsl:template name="bank-details">
		<xsl:call-template name="common-bank-details" />
	</xsl:template>
	
	<!--  Documents required Fieldset. -->
	<xsl:template name="documents-required">
		<xsl:call-template name="common-documents-required" />
	</xsl:template>
	
		<!--  Shipment details Fieldset. -->
	<xsl:template name="shipment-details">
		<xsl:call-template name="common-shipment-details" />
	</xsl:template>

<!--  Inco terms Fieldset. -->
	<xsl:template name="inco-terms">
		<xsl:call-template name="common-inco-terms" />
	</xsl:template>
	
	<!-- Routing summary Fieldset. -->
	<xsl:template name="routing-summary">
		<xsl:call-template name="common-routing-summary" />
	</xsl:template>
	

<!-- User Details Fieldset. -->
	<xsl:template name="user-details">
		<xsl:call-template name="common-user-details" />
	</xsl:template>

	<!-- Contact Person Details Fieldset. -->
	<xsl:template name="contact-details">
		<xsl:call-template name="common-contact-details" />
	</xsl:template>	
    
    
	<!--
		General Details Fieldset. Issue Date, Template Validation, Buyer
		Details, Seller Details.
	-->
	<xsl:template name="po-general-details">
		<xsl:call-template name="common-po-general-details" />
	</xsl:template>
</xsl:stylesheet>