<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="xmlRender localization securitycheck utils security defaultresource">

	<!--
		Global Parameters. These are used in the imported XSL, and to set
		global params in the JS
	-->
	<xsl:param name="rundata" />
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param>
	<!--
		set to none, counterparty or bank, depending on whether we are in a
		collab summary screen
	-->	
	<xsl:param name="product-code">PO</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath" /><xsl:value-of select="$servletPath" />/screen/PurchaseOrderScreen</xsl:param>

	<!-- if value = 'TEMPLATE', open all dynamic input forms -->
	<xsl:param name="option" />

	<!-- All marks used to shown/hidden form's sections-->
	<xsl:param name="section_po_line_items" />
	<xsl:param name="section_po_amount_details" />
	<xsl:param name="section_po_payment_terms" />
	<xsl:param name="section_po_settlement_terms" />
	<xsl:param name="section_po_documents_required" />
	<xsl:param name="section_po_shipment_details" />
	<xsl:param name="section_po_inco_terms" />
	<xsl:param name="section_po_routing_summary" />
	<xsl:param name="section_po_user_info" />
	<xsl:param name="section_po_contact" />

	<xsl:param name="section_line_item_po_reference">N</xsl:param>
	<xsl:param name="section_line_item_adjustments_details" />
	<xsl:param name="section_line_item_taxes_details" />
	<xsl:param name="section_line_item_freight_charges_details" />
	<xsl:param name="section_line_item_shipment_details" />
	<xsl:param name="section_line_item_inco_terms_details" />
	<xsl:param name="section_line_item_total_net_amount_details" />
	<xsl:param name="section_line_item_routing_summary"/>
	<xsl:param name="section_shipment_sub_schedule"/>
	

	<!-- <xsl:param name="section_li_product" />
	<xsl:param name="section_li_amount_details" />
	<xsl:param name="section_li_shipment_details" />
	<xsl:param name="section_li_inco_terms" />
	<xsl:param name="section_li_routing_summary" />-->

	<xsl:include href="po_common.xsl" />
	<xsl:include href="../../core/xsl/products/product_addons.xsl" />
	<xsl:include href="../../core/xsl/common/com_cross_references.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />

	<!-- Global Imports. -->
	<xsl:include href="../../core/xsl/common/trade_common.xsl" />

	<xsl:output method="html" version="4.01" indent="no"
		encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/">
		<xsl:apply-templates select="po_tnx_record" />
	</xsl:template>

	<!--TEMPLATE Main-->

	<xsl:template match="po_tnx_record">
		<!-- Preloader  -->
		<xsl:call-template name="loading-message" />

		<!-- ***************************** -->
		<!-- Widgets' template declaration -->
		<!-- ***************************** -->
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
		<xsl:call-template name="payment-terms-declaration" />
		<!-- Taxes declaration -->
		<xsl:call-template name="taxes-declaration" />
		<!-- Freight Charges declaration -->
		<xsl:call-template name="freight-charges-declaration" />
		<!-- Incoterms declaration -->
		<xsl:call-template name="incoterms-declaration" />
		<!-- User defined informations declaration buyer -->
		<xsl:call-template name="user-defined-informations-declaration" >
			<xsl:with-param name="user_info_type">01</xsl:with-param>
		</xsl:call-template>
		<!-- User defined informations declaration seller -->
		<xsl:call-template name="user-defined-informations-declaration" >
			<xsl:with-param name="user_info_type">02</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="contact-details-declaration" />
		
		<xsl:call-template name="individual-routing-summary-declaration" />
		
		<xsl:call-template name="transport-by-air-dept-details-declaration" />
		
		<xsl:call-template name="transport-by-air-dest-details-declaration" />
		
		<xsl:call-template name="transport-by-sea-discharge-port-details-declaration"/>
		
		<xsl:call-template name="transport-by-sea-loading-port-details-declaration"/>
		
		<xsl:call-template name="transport-by-rail-receipt-place-details-declaration"/>
		
		<xsl:call-template name="transport-by-rail-delivery-place-details-declaration"/>
		
		<xsl:call-template name="transport-by-road-receipt-place-details-declaration"/>
		
		<xsl:call-template name="transport-by-road-delivery-place-details-declaration"/>
		
		<xsl:call-template name="sub-shipment-schedule-declaration"/>	
		
		
					
		<!-- ******************* -->
		<!-- Purchase Order form -->
		<!-- ******************* -->
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>

			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name" />
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
					<!--  Display common menu.  -->
					<xsl:call-template name="menu">
					<xsl:with-param name="show-return">Y</xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="server-message">
						<xsl:with-param name="name">server_message</xsl:with-param>
						<xsl:with-param name="content">
							<xsl:for-each select="message">
								<xsl:value-of select="." disable-output-escaping="yes"/>
							</xsl:for-each>
						</xsl:with-param>
						<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
					</xsl:call-template>
					
					
					<!-- <xsl:if test="error_msg != ''"> 
						<xsl:call-template name ="warnings" />
					</xsl:if> -->
					
					<!-- Disclaimer Notice -->
					<xsl:call-template name="disclaimer" />

					<xsl:apply-templates select="cross_references"
						mode="hidden_form" />
					<xsl:call-template name="hidden-fields" />
					<xsl:call-template name="general-details" />

					<!-- Bank details -->
					<xsl:call-template name="bank-details" />
					
					<!-- Goods details -->
					<xsl:call-template name="oa-goods-details" />
 
					<!-- Amount details -->
					<xsl:if test="$section_po_amount_details!='N'">
						<xsl:call-template name="amount-details" />
					</xsl:if>
					
					<!-- Payment details -->
					<xsl:if test="$section_po_payment_terms!='N'">
						<xsl:call-template name="oa-payment-terms" />
					</xsl:if>
					
					<!--Settlement Terms Details-->
					<xsl:if test="$section_po_settlement_terms!='N'">
						<xsl:call-template name="oa-settlement-terms" />
					</xsl:if>
					
					<!--Documents required Details-->
					<xsl:if test="$section_po_documents_required!='N'">
						<xsl:call-template name="documents-required" />
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
					
					<!-- comments for return -->
				    <xsl:call-template name="comments-for-return">
					 	<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
					 	<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
				   	</xsl:call-template>
					
				</xsl:with-param>
			</xsl:call-template>
		</div>
		
		<!-- Form #1 : Attach Files -->
		<xsl:choose>
			<xsl:when test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
				<xsl:call-template name="attachments-file-dojo">
					<xsl:with-param name="attachment-group">purchaseorder</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="$option ='DETAILS'">
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
	          	</xsl:if>
			</xsl:otherwise>
		</xsl:choose>

		<!-- Table of Contents -->
		<xsl:call-template name="toc" />

		<!--  Collaboration Window  -->
		<xsl:call-template name="collaboration">
			<xsl:with-param name="editable">true</xsl:with-param>
			<xsl:with-param name="productCode">
				<xsl:value-of select="$product-code" />
			</xsl:with-param>
			<xsl:with-param name="contextPath">
				<xsl:value-of select="$contextPath" />
			</xsl:with-param>
			<xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
			<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
		</xsl:call-template>

		<!-- Display common menu, this time outside the form -->
		<xsl:call-template name="menu">
			<xsl:with-param name="second-menu">Y</xsl:with-param>
			<xsl:with-param name="show-return">Y</xsl:with-param>
		</xsl:call-template>
		
		<!-- The form that's submitted -->
		<xsl:call-template name="realform" />
		<!-- Reauthentication -->
      <xsl:call-template name="reauthentication"/>

		<!-- Javascript and Dojo imports  -->
		<xsl:call-template name="js-imports" />

	</xsl:template>

	<!--                                     -->
	<!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
	<!--                                     -->

	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.openaccount.create_po</xsl:with-param>
			<xsl:with-param name="show-period-js">Y</xsl:with-param>
			<xsl:with-param name="override-help-access-key">PO_01</xsl:with-param>
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
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">product_code</xsl:with-param>				
			</xsl:call-template>
		</div>
	</xsl:template>

	<!-- General Details Fieldset. -->
	<xsl:template name="general-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:variable name="show-template-id">Y</xsl:variable>
				<xsl:variable name="show-cust-ref-id">Y</xsl:variable>
				<xsl:variable name="show-bo-ref-id">Y</xsl:variable>
				<xsl:variable name="override-cust-ref-id-label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:variable>
				<!-- Hidden fields. -->
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">ref_id</xsl:with-param>
				</xsl:call-template>
				<!-- Don't display this in unsigned mode. -->
				<xsl:if test="$displaymode='edit'">
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">appl_date</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<!--  System ID. -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
					<xsl:with-param name="id">general_ref_id_view</xsl:with-param>
					<xsl:with-param name="value" select="ref_id" />
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<!-- Bank Reference -->
				<!-- Shown in consolidated view -->
				<xsl:if test="$show-bo-ref-id='Y' and $displaymode='view' and (not(tnx_id) or tnx_type_code[.!='01'])">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
						<xsl:with-param name="value" select="bo_ref_id" />
					</xsl:call-template>
				</xsl:if>
				<!-- Cross Refs -->
				<!-- Shown in consolidated view  -->
				<xsl:if test="cross_references">
					<xsl:apply-templates select="cross_references" mode="display_table_tnx"/>
				</xsl:if>
				<!-- Template ID. -->
				<xsl:if test="$show-template-id='Y'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_ID</xsl:with-param>
						<xsl:with-param name="name">template_id</xsl:with-param>
						<xsl:with-param name="size">15</xsl:with-param>
						<xsl:with-param name="maxsize">20</xsl:with-param>
						<xsl:with-param name="fieldsize">small</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<!-- Customer reference -->
				<xsl:if test="$show-cust-ref-id='Y'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label"><xsl:value-of select="$override-cust-ref-id-label"/></xsl:with-param>
						<xsl:with-param name="name">cust_ref_id</xsl:with-param>
						<xsl:with-param name="size">20</xsl:with-param>
						<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_PO_LENGTH')"/></xsl:with-param>
						<xsl:with-param name="regular-expression">
						<xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_PO_VALIDATION_REGEX')"/>
						</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_PO_REF_ID</xsl:with-param>
					<xsl:with-param name="name">issuer_ref_id</xsl:with-param>
					<xsl:with-param name="size">35</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="regular-expression">
						<xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_PO_VALIDATION_REGEX')"/>
					</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
				</xsl:call-template>
				<!--  Application date. -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
					<xsl:with-param name="id">appl_date_view</xsl:with-param>
					<xsl:with-param name="value" select="appl_date" />
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="po-general-details" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--  Bank Details Fieldset. -->
	<xsl:template name="bank-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="issuing-bank-tabcontent">
					<xsl:with-param name="sender-name">buyer</xsl:with-param>
					<xsl:with-param name="sender-reference-name">buyer_reference</xsl:with-param>
   				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!--  Documents required Fieldset. -->
	<xsl:template name="documents-required">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED</xsl:with-param>
			<xsl:with-param name="content">
			
		       <xsl:call-template name="multioption-group">
		        <xsl:with-param name="group-label">XSL_PURCHASE_ORDER_COMMERCIAL_DATASET</xsl:with-param>
		        <xsl:with-param name="content">
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_COMMERCIAL_DATASET_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">reqrd_commercial_dataset</xsl:with-param>
						<xsl:with-param name="id">reqrd_commercial_dataset_1</xsl:with-param>
						<xsl:with-param name="value">Y</xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="reqrd_commercial_dataset[. = 'Y' or . = '']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_COMMERCIAL_DATASET_NOT_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">reqrd_commercial_dataset</xsl:with-param>
						<xsl:with-param name="id">reqrd_commercial_dataset_2</xsl:with-param>
						<xsl:with-param name="value">N</xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="reqrd_commercial_dataset[. = 'N']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
	     	  </xsl:call-template>
	       	  <xsl:call-template name="multioption-group">
	       	  	 <xsl:with-param name="group-label">XSL_PURCHASE_ORDER_TRANSPORT_DATASET</xsl:with-param>
	       		 <xsl:with-param name="content">
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_TRANSPORT_DATASET_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">reqrd_transport_dataset</xsl:with-param>
						<xsl:with-param name="id">reqrd_transport_dataset_1</xsl:with-param>
						<xsl:with-param name="value">Y</xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="reqrd_transport_dataset[. = 'Y']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_TRANSPORT_DATASET_NOT_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">reqrd_transport_dataset</xsl:with-param>
						<xsl:with-param name="id">reqrd_transport_dataset_2</xsl:with-param>
						<xsl:with-param name="value">N</xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="reqrd_transport_dataset[. = 'N' or . = '']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
	     	  </xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_PURCHASE_ORDER_LAST_MATCH_DATE</xsl:with-param>
					<xsl:with-param name="name">last_match_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<!-- events : onblur -->
					<xsl:with-param name="value">
						<xsl:value-of select="last_match_date" />
					</xsl:with-param>
					<xsl:with-param name="size">10</xsl:with-param>
					<xsl:with-param name="maxsize">10</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
				
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!--  Shipment details Fieldset. -->
	<xsl:template name="shipment-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			
			   <!-- Lastest Shipment Date, Partial and Trans Shipments-->
			   <xsl:call-template name="multioption-group">
			        <xsl:with-param name="group-label">XSL_SHIPMENTDETAILS_PART_SHIP_LABEL</xsl:with-param>
			        <xsl:with-param name="content">
				        <xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED</xsl:with-param>
							<xsl:with-param name="name">part_ship</xsl:with-param>
							<xsl:with-param name="id">part_ship_1</xsl:with-param>
							<xsl:with-param name="value">Y</xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="part_ship[. = 'Y' or . = '']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED</xsl:with-param>
							<xsl:with-param name="name">part_ship</xsl:with-param>
							<xsl:with-param name="id">part_ship_2</xsl:with-param>
							<xsl:with-param name="value">N</xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="part_ship[. = 'N']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
			        </xsl:with-param>
			    </xsl:call-template>
			    <xsl:call-template name="multioption-group">
			        <xsl:with-param name="group-label">XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL</xsl:with-param>
			        <xsl:with-param name="content">
			        	<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED</xsl:with-param>
							<xsl:with-param name="name">tran_ship</xsl:with-param>
							<xsl:with-param name="id">tran_ship_1</xsl:with-param>
							<xsl:with-param name="value">Y</xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="tran_ship[. = 'Y' or . = '']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED</xsl:with-param>
							<xsl:with-param name="name">tran_ship</xsl:with-param>
							<xsl:with-param name="id">tran_ship_2</xsl:with-param>
							<xsl:with-param name="value">N</xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="tran_ship[. = 'N']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
			        </xsl:with-param>
			   </xsl:call-template>
				
			  <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SHIPMENTDETAILS_LAST_SHIP_DATE</xsl:with-param>
					<!-- events : onblur, onfocus -->
					<xsl:with-param name="name">last_ship_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:value-of select="last_ship_date" />
					</xsl:with-param>
					<xsl:with-param name="size">10</xsl:with-param>
					<xsl:with-param name="maxsize">10</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
			  </xsl:call-template>

			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<!--  Inco terms Fieldset. -->
	<xsl:template name="inco-terms">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_INCO_TERMS_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp; 
				<xsl:call-template name="build-incoterms-dojo-items">
					<xsl:with-param name="items" select="incoterms/incoterm"/>
					<xsl:with-param name="id" select="po-incoterms" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- User Details Fieldset. -->
	<xsl:template name="user-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_USER_INFORMATION_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_PURCHASE_ORDER_BUYER_INFORMATIONS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">&nbsp;
						<xsl:call-template name="user_defined_informations_buyer">
							<xsl:with-param name="items" select="user_defined_informations/user_defined_information[type=01]" />
							<xsl:with-param name="id" select="po-buyer-user-informations" />
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_PURCHASE_ORDER_SELLER_INFORMATIONS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">&nbsp;
						<xsl:call-template name="user_defined_informations_seller">
							<xsl:with-param name="items" select="user_defined_informations/user_defined_information[type=02]" />
							<xsl:with-param name="id" select="po-seller-user-informations" />
						</xsl:call-template>
					
					</xsl:with-param>
				</xsl:call-template>
				
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Contact Person Details Fieldset. -->
	<xsl:template name="contact-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_CONTACT_PERSON_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-contact-details-dojo-items">
					<xsl:with-param name="items" select="contacts/contact" />
					<xsl:with-param name="id" select="po-contacts" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>		

	<!-- Amount Details Fieldset. -->
	<xsl:template name="amount-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				&nbsp;
				<!-- Adjustments -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_ADJUSTMENTS_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						&nbsp;
						<xsl:call-template name="build-adjustments-dojo-items">
							<xsl:with-param name="items" select="adjustments/adjustment" />
							<xsl:with-param name="id">po-adjustments</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>

				<!-- Taxes -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_TAXES_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						&nbsp;
						<xsl:call-template name="build-taxes-dojo-items">
							<xsl:with-param name="items" select="taxes/tax" />
							<xsl:with-param name="id">po-taxes</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>

				<!-- Freight charges -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_FREIGHT_CHARGES_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<!-- Price unit measure code -->
						<xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_FREIGHT_CHARGES_TYPE</xsl:with-param>
							<xsl:with-param name="name">freight_charges_type</xsl:with-param>
							<xsl:with-param name="options">
							 <xsl:choose>
        						<xsl:when test="$displaymode='edit'">
	        						<option value="">&nbsp;</option>
									<option value="CLCT">
										<xsl:value-of
											select="localization:getDecode($language, 'N211', 'CLCT')" />
										<xsl:if test="freight_charges_type[. = 'CLCT']">
											<xsl:attribute name="selected" />
										</xsl:if>
									</option>
									<option value="PRPD">
										<xsl:value-of
											select="localization:getDecode($language, 'N211', 'PRPD')" />
										<xsl:if test="freight_charges_type[. = 'PRPD']">
											<xsl:attribute name="selected" />
										</xsl:if>
									</option>
								</xsl:when>
						        <xsl:otherwise>
							        <xsl:choose>
								        <xsl:when test="freight_charges_type[. = 'CLCT']"><xsl:value-of select="localization:getDecode($language, 'N211', 'CLCT')" /></xsl:when>
								        <xsl:when test="freight_charges_type[. = 'PRPD']"><xsl:value-of select="localization:getDecode($language, 'N211', 'PRPD')" /></xsl:when>
							        </xsl:choose>
						        </xsl:otherwise>
						       </xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						&nbsp;
						<xsl:call-template name="build-freight-charges-dojo-items">
							<xsl:with-param name="items"
								select="freightCharges/freightCharge" />
							<xsl:with-param name="id">po-freight-charges</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<!-- Line Item Net Amount -->
				&nbsp;
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_NET_AMT_LABEL</xsl:with-param>
					<xsl:with-param name="override-currency-name">total_net_cur_code</xsl:with-param>
					<xsl:with-param name="override-amt-name">total_net_amt</xsl:with-param>
					<xsl:with-param name="amt-readonly">Y</xsl:with-param>
					<xsl:with-param name="currency-readonly">Y</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
				</xsl:call-template>

			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!--
		General Details Fieldset. Issue Date, Template Validation, Buyer
		Details, Seller Details.
	-->
	<xsl:template name="po-general-details">
		<xsl:if test="$displaymode='edit'">
			<div>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
					<xsl:with-param name="name">iss_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:if>
		<!-- Issue Date -->
		<!-- Displayed in consolidated view -->
		<xsl:if	test="$displaymode='view'">
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
				<xsl:with-param name="name">iss_date</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		&nbsp;

		<!-- Buyer Details -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="show-entity">Y</xsl:with-param>
					<xsl:with-param name="show-BEI">Y</xsl:with-param>
					<xsl:with-param name="prefix">buyer</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>

		<!-- Seller Details -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="show-button">Y</xsl:with-param>
					<xsl:with-param name="show-BEI">Y</xsl:with-param>
					<xsl:with-param name="prefix">seller</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>

		<!-- Display other parties -->
		<xsl:if test="$displaymode='edit'">
		<xsl:call-template name="checkbox-field">
			<xsl:with-param name="name">display_other_parties</xsl:with-param>
			<xsl:with-param name="label">XSL_PURCHASE_ORDER_DISPLAY_OTHER_PARTIES</xsl:with-param>
			<xsl:with-param name="checked"><xsl:if test="bill_to_name[. != ''] or ship_to_name[. != ''] or consgn_to_name[. != '']">Y</xsl:if></xsl:with-param>
		</xsl:call-template>
		</xsl:if>

		<!--
			Other parties Tabgroup. Tab0 - Bill To Tab1 - Ship To Tab2 -
			Consignee
		-->
		<xsl:call-template name="tabgroup-wrapper">
			<xsl:with-param name="tabgroup-id">other_parties_section</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<!--  Tab 0_0 - Bill To  -->
			<xsl:with-param name="tab0-label">XSL_HEADER_BILL_TO_DETAILS</xsl:with-param>
			<xsl:with-param name="tab0-content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="prefix">bill_to</xsl:with-param>
					<xsl:with-param name="show-button">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
			<!--  Tab 0_1 - Ship To -->
			<xsl:with-param name="tab1-label">XSL_HEADER_SHIP_TO_DETAILS</xsl:with-param>
			<xsl:with-param name="tab1-content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="prefix">ship_to</xsl:with-param>
					<xsl:with-param name="show-button">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
			<!--  Tab 0_2 - Consignee -->
			<xsl:with-param name="tab2-label">XSL_HEADER_CONSIGNEE_DETAILS</xsl:with-param>
			<xsl:with-param name="tab2-content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="prefix">consgn</xsl:with-param>
					<xsl:with-param name="show-button">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!--Other Templates-->

	<!--TEMPLATE Issuing Bank (Main Details)-->
	<!--
		<xsl:template match="bank" mode="main"> <xsl:param
		name="bank"><xsl:value-of select="abbv_name"/></xsl:param> <option>
		<xsl:attribute name="value"><xsl:value-of
		select="$bank"/></xsl:attribute> <xsl:if
		test="../../issuing_bank/abbv_name=$bank"> <xsl:attribute
		name="selected"/> </xsl:if> <xsl:value-of select="name"/> </option>

		</xsl:template>
	-->
	<!--
   PO Realform.
   -->
	<xsl:template name="realform">
		
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name">realform</xsl:with-param>
				<xsl:with-param name="action" select="$realform-action" />
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
							<xsl:with-param name="value" select="$mode" />
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">tnxtype</xsl:with-param>
							<xsl:with-param name="value">01</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">attIds</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">TransactionData</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
						<xsl:if test="tnx_type_code = '01' and $option = 'EXISTING'">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">isCopyFrom</xsl:with-param>
								<xsl:with-param name="value">Y</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:call-template name="reauth_params"/>
					</div>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
