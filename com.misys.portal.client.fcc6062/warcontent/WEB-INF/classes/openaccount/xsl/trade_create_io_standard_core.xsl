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
	xmlns:xd="http://www.pnp-software.com/XSLTdoc"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="xmlRender localization securitycheck utils security defaultresource">
	<xd:doc type="stylesheet">
 	</xd:doc>

	<!--
		Global Parameters. These are used in the imported XSL, and to set
		global params in the JS
	-->
	<xsl:param name="rundata" />
	<xd:doc type="string">
  	<xd:short>Language code in lower case.</xd:short>
  	<xd:detail>
  	 For example, <code>en</code> for English
  	<br/>Should be set in form that import this file, even if no value is assigned
  	</xd:detail>
  </xd:doc>
	<xsl:param name="language">en</xsl:param>
	<xd:doc type="string">
  	<xd:short>mode code in upper case.</xd:short>
  	<xd:detail>
  	 For example, <code>DRAFT</code> for Saving
  	<br/>Should be set  that import this file, even if no value is assigned
  	</xd:detail>
  </xd:doc>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xd:doc type="string">
	  <xd:short>Display mode in which the screen is rendered.</xd:short>
	  <xd:detail>
	  	One of <code>view</code> or <code>edit</code>.
	  	<br/>Should be set in form that import this file, even if no value is assigned
	  </xd:detail>
  </xd:doc>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xd:doc type="string">
	  <xd:short>collaboration mode</xd:short>
	  <xd:detail>
	  	One of <code>none</code> or <code>counterparty</code> or <code>bank</code>
	  	<br/>Should be set in form that import this file, even if no value is assigned
	  </xd:detail>
  </xd:doc>
	<xsl:param name="collaborationmode">none</xsl:param>
	<!--
		set to none, counterparty or bank, depending on whether we are in a
		collab summary screen
	-->	
	 <xd:doc type="string">
	  <xd:short>product-code in upper case</xd:short>
   </xd:doc>
	<xsl:param name="product-code">IO</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath" /><xsl:value-of select="$servletPath" />/screen/ImportOpenAccountScreen</xsl:param>

	<!-- if value = 'TEMPLATE', open all dynamic input forms -->
	<xd:doc>
	<xd:param name="options">Raw HTML, listing the &lt;option&gt; tags for this element</xd:param>
	</xd:doc>
	<xsl:param name="option" />

	<!-- All marks used to shown/hidden form's sections-->
	 <xd:doc>
	<xd:param name="section_po_line_items">Line item section of the IO</xd:param>
	</xd:doc>
	<xsl:param name="section_po_line_items">
		<xsl:if test="$displaymode = 'view'">
			<xsl:choose>
				<xsl:when test="io_tnx_record/line_items/lt_tnx_record">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:param>
	<xd:doc>
	<xd:param name="section_po_amount_details">Amount Details such as price and quantity section</xd:param>
	<xd:param name="section_po_payment_terms">Terms of payment in amount or percentage</xd:param>
	<xd:param name="section_po_settlement_terms">Terms of Settlement of Creditor</xd:param>
	<xd:param name="section_po_documents_required">Commercial and Transport dataset details</xd:param>
	<xd:param name="section_po_shipment_details">Shipment Details</xd:param>
	<xd:param name="section_po_inco_terms">Rules for any mode of transport</xd:param>
	<xd:param name="section_po_routing_summary">Details of shipment will be transported</xd:param>
	<xd:param name="section_po_user_info">User Defines Information</xd:param>
	<xd:param name="section_po_contact">Contact information based on contact type</xd:param>
	</xd:doc>
	<xsl:param name="section_po_amount_details"/>
	<xsl:param name="section_po_payment_terms" />
	<xsl:param name="section_po_settlement_terms" />
	<xsl:param name="section_po_documents_required" />
	<xsl:param name="section_po_shipment_details" />
	<xsl:param name="section_po_inco_terms">
		<xsl:if test="$displaymode = 'view'">
			<xsl:choose>
				<xsl:when test="io_tnx_record/incoterms/incoterm">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:param>
	<xsl:param name="section_po_routing_summary">
		<xsl:if test="$displaymode = 'view'">
			<xsl:choose>
				<xsl:when test="io_tnx_record/routing_summaries">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:param>
	<xsl:param name="section_po_user_info">
		<xsl:if test="$displaymode = 'view'">
			<xsl:choose>
				<xsl:when test="io_tnx_record/user_defined_informations/user_defined_information">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:param>
	<xsl:param name="section_po_contact">
		<xsl:if test="$displaymode = 'view'">
			<xsl:choose>
				<xsl:when test="io_tnx_record/contacts/contact">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:param>
<xd:doc>
	<xd:param name="section_line_item_po_reference">Line Item Purchase Order Reference</xd:param>
	<xd:param name="section_line_item_adjustments_details">Adjustment(Rebate,Discount etc) in line items</xd:param>
	<xd:param name="section_line_item_taxes_details">Taxes(National,Consumption etc) on line items</xd:param>
	<xd:param name="section_line_item_freight_charges_details">Details of freign charges such as Airway charge etc</xd:param>
	<xd:param name="section_line_item_shipment_details">Shipment Details date</xd:param>
	<xd:param name="section_line_item_inco_terms_details">Rules for any mode of transport</xd:param>
	<xd:param name="section_line_item_total_net_amount_details">Total net amount</xd:param>
	<xd:param name="section_line_item_routing_summary">Details of shipment will be transported</xd:param>
	 </xd:doc>
	<xsl:param name="section_line_item_po_reference">N</xsl:param>
	<xsl:param name="section_line_item_adjustments_details" />
	<xsl:param name="section_line_item_taxes_details" />
	<xsl:param name="section_line_item_freight_charges_details" />
	<xsl:param name="section_line_item_shipment_details" />
	<xsl:param name="section_line_item_inco_terms_details" />
	<xsl:param name="section_line_item_total_net_amount_details" />
	<xsl:param name="section_line_item_routing_summary" />
	<xsl:param name="section_shipment_sub_schedule"/>
	

	<xd:doc type="string">
  	<xd:short>Error floating pane display.</xd:short>
  	<xd:detail>
  	 If <code>errorPopupMode</code> is error then a error floaing pane would be displayed.
  	<br/>By default this mode is none. Refer P765 parameter as this should be configured to diplay the error floating pane.
  	</xd:detail>
  </xd:doc>
	<xsl:param name="errorPopupMode">none</xsl:param>
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
		<xsl:apply-templates select="io_tnx_record" />
	</xsl:template>

	<!--TEMPLATE Main-->
	<xd:doc>
		<xd:short>Import Open Account Transaction Record</xd:short>
		<xd:detail>Calls different template to declare different fields</xd:detail>
	</xd:doc>

	<xsl:template match="io_tnx_record">
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
		<xsl:call-template name="sub-shipment-schedule-declaration"/>
		<xsl:call-template name="contact-details-declaration" />
		
		<xsl:call-template name="commercial-ds-details-declaration" />
		
		<xsl:call-template name="transport-ds-details-declaration" />
		
		<xsl:call-template name="insurance-ds-details-declaration" />
		
		<xsl:call-template name="insurance-bic-declaration" />
		
		<xsl:call-template name="insurance-required-clause-declaration" />
		
		<xsl:call-template name="certificate-ds-details-declaration" />
		
		<xsl:call-template name="certificate-bic-declaration" />
		
		<xsl:call-template name="certificate-line-item-id-declaration" />
		
		<xsl:call-template name="other-certificate-ds-details-declaration" />
		
		<xsl:call-template name="other-certificate-bic-declaration" />
		
		<xsl:call-template name="individual-routing-summary-declaration" />
		
		<xsl:call-template name="bank-payment-obligation-details-declaration" />
				
		<xsl:call-template name="bpo-payment-terms-declaration" />
		
		<xsl:call-template name="transport-by-air-dept-details-declaration" />
		
		<xsl:call-template name="transport-by-air-dest-details-declaration" />
		
		<xsl:call-template name="transport-by-sea-discharge-port-details-declaration"/>
		
		<xsl:call-template name="transport-by-sea-loading-port-details-declaration"/>
		
		<xsl:call-template name="transport-by-rail-receipt-place-details-declaration"/>
		
		<xsl:call-template name="transport-by-rail-delivery-place-details-declaration"/>
		
		<xsl:call-template name="transport-by-road-receipt-place-details-declaration"/>
		
		<xsl:call-template name="transport-by-road-delivery-place-details-declaration"/>
		
			
		<!-- ******************* -->
		<!-- Import Open Account form -->
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
								<xsl:with-param name="show-template">N</xsl:with-param>
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

					<!-- Disclaimer Notice -->
					<xsl:call-template name="disclaimer" />

					<xsl:apply-templates select="cross_references"
						mode="hidden_form" />
						
					<xsl:call-template name="hidden-fields" />
					
					<xsl:if test="error_msg != ''"> 
						<xsl:call-template name ="warnings" />
					</xsl:if>
					
					<xsl:call-template name="general-details" />
						<!-- comments for close -->
						<div id = "closeComments" style="display:none">
						    <xsl:call-template name="comments-for-close">
							 	<xsl:with-param name="value"><xsl:value-of select="close_comments"/></xsl:with-param>
							 	<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
							 	<xsl:with-param name="toc-item">N</xsl:with-param>
						   	</xsl:call-template>
						</div>
						<xsl:choose>
						<xsl:when test="tnx_type_code = '38'">
							<div id="transactionDetails" style="display:none">
								<!-- Bank details -->
								<xsl:call-template name="oa-bank-details">
									<xsl:with-param name="sender-name">buyer</xsl:with-param>
								</xsl:call-template>
								<!-- Goods details -->
								<xsl:call-template name="oa-goods-details">
									<xsl:with-param name="toc-item">N</xsl:with-param>
								</xsl:call-template>
			 
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
								
								<!-- Bank Payment Obligation Details -->
								<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./bank_payment_obligation/PmtOblgtn)">
								<xsl:call-template name="bank-payment-obligation-ds-details"/>
								</xsl:if>
								
								<!--Documents required Details-->
								<xsl:if test="$section_po_documents_required!='N'">
									<xsl:call-template name="oa-documents-required" />
								</xsl:if>
								
								<!--Inco Terms-->
								<xsl:if test="$section_po_inco_terms!='N'">
									<xsl:call-template name="oa-inco-terms" />
								</xsl:if>
								
								<!--Routing summary Details-->
								<xsl:if test="$section_po_routing_summary!='N'">
									<xsl:call-template name="routing-summary">
										<xsl:with-param name="toc-item">N</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								
								<!--User Details-->
								<xsl:if test="$section_po_user_info!='N'">
									<xsl:call-template name="oa-user-details" />
								</xsl:if>
								
								<!--Contact Details-->
								<xsl:if test="$section_po_contact!='N'">
									<xsl:call-template name="oa-contact-details" />
								</xsl:if>
								
								<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./commercial_dataset/ComrclDataSetReqrd)">
								<xsl:call-template name="commercial-ds-details" />
								</xsl:if>
								
								<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./transport_dataset/TrnsprtDataSetReqrd)">
								<xsl:call-template name="transport-ds-details" />
								</xsl:if>
								
								<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./insurance_dataset/InsrncDataSetReqrd)">
								<xsl:call-template name="insurance-ds-details" />
								</xsl:if>
								
								<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./certificate_dataset/CertDataSetReqrd)">
								<xsl:call-template name="certificate-ds-details" />
								</xsl:if>
								
								<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./other_certificate_dataset/OthrCertDataSetReqrd)">
								<xsl:call-template name="other-certificate-ds-details" />
								</xsl:if>																				
							</div>						
						</xsl:when>
						<xsl:otherwise>
							<div id="transactionDetails">
								<!-- Bank details -->
								<xsl:call-template name="oa-bank-details">
									<xsl:with-param name="sender-name">buyer</xsl:with-param>
								</xsl:call-template>
								<!-- Goods details -->
								<xsl:call-template name="oa-goods-details">
									<xsl:with-param name="toc-item">Y</xsl:with-param>
								</xsl:call-template>
			 
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
								
								<!-- Bank Payment Obligation Details -->
								<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./bank_payment_obligation/PmtOblgtn)">
								<xsl:call-template name="bank-payment-obligation-ds-details"/>
								</xsl:if>
								
								<!--Documents required Details-->
								<xsl:if test="$section_po_documents_required!='N'">
									<xsl:call-template name="oa-documents-required" />
								</xsl:if>
								
								<!--Inco Terms-->
								<xsl:if test="$section_po_inco_terms!='N'">
									<xsl:call-template name="oa-inco-terms" />
								</xsl:if>
								
								<!--Routing summary Details-->
								<xsl:if test="$section_po_routing_summary!='N'">
									<xsl:call-template name="routing-summary">
										<xsl:with-param name="toc-item">Y</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								
								<!--User Details-->
								<xsl:if test="$section_po_user_info!='N'">
									<xsl:call-template name="oa-user-details" />
								</xsl:if>
								
								<!--Contact Details-->
								<xsl:if test="$section_po_contact!='N'">
									<xsl:call-template name="oa-contact-details" />
								</xsl:if>
								
								<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./commercial_dataset/ComrclDataSetReqrd)">
								<xsl:call-template name="commercial-ds-details" />
								</xsl:if>
								
								<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./transport_dataset/TrnsprtDataSetReqrd)">
								<xsl:call-template name="transport-ds-details" />
								</xsl:if>
								
								<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./insurance_dataset/InsrncDataSetReqrd)">
								<xsl:call-template name="insurance-ds-details" />
								</xsl:if>
								
								<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./certificate_dataset/CertDataSetReqrd)">
								<xsl:call-template name="certificate-ds-details" />
								</xsl:if>
								
								<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./other_certificate_dataset/OthrCertDataSetReqrd)">
								<xsl:call-template name="other-certificate-ds-details" />
								</xsl:if>
							</div>
						</xsl:otherwise>
						</xsl:choose>
						<!-- Display mismatches in tabular format, when available. -->
						<xsl:if test="mismatches != '' and mismatches/Rpt != ''">
							<xsl:call-template name="mismatch-report-declaration">
					   			<xsl:with-param name="node" select="mismatches/Rpt" />
					   		</xsl:call-template>
				   		</xsl:if>
						<!-- comments for return -->
						<xsl:call-template name="comments-for-return">
						 	<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
						 	<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
					   	</xsl:call-template>
					   	
					   	<!-- Instructions to Bank -->
					   	<xsl:if test="($displaymode='edit')">
						<xsl:call-template name="instructions-to-bank">
						 	<xsl:with-param name="value"><xsl:value-of select="free_format_text"/></xsl:with-param>
						 	<xsl:with-param name="displaymode">edit</xsl:with-param>
					   	</xsl:call-template>
					   	</xsl:if>
				</xsl:with-param>										
			</xsl:call-template>						
		</div>
		
		<!-- Form #1 : Attach Files -->
		<xsl:choose>
			<xsl:when test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED') or ($displaymode != 'edit' and $mode = 'VIEW')">
				<xsl:if test = "sub_tnx_type_code = '83'">
					<xsl:call-template name="attachments-file-dojo">
			          	<xsl:with-param name="existing-attachments" select="attachments/attachment[type = '07']"/>
			          	<xsl:with-param name="legend">XSL_HEADER_TRANSACTIONAL_ATTACHMENT</xsl:with-param>
			          	<xsl:with-param name="attachment-group">summarybank</xsl:with-param>
			          	<xsl:with-param name="override-displaymode">view</xsl:with-param>
		          	</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="attachments-file-dojo">
					<xsl:with-param name="existing-attachments" select="attachments/attachment[type = '01']"/>
					<xsl:with-param name="attachment-group">purchaseorder</xsl:with-param>
				</xsl:call-template>
				
				<xsl:if test = "attachments/attachment[type = '02']!=''">
					<xsl:call-template name="attachments-file-dojo">
			          	<xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
			          	<xsl:with-param name="legend">XSL_HEADER_BANK_FILE_UPLOAD</xsl:with-param>
			          	<xsl:with-param name="attachment-group">summarybank</xsl:with-param>
			          	<xsl:with-param name="override-displaymode">view</xsl:with-param>
		          	</xsl:call-template>
	          	</xsl:if>
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
		          	<xsl:call-template name="attachments-file-dojo">
			          	<xsl:with-param name="existing-attachments" select="attachments/attachment[type = '07']"/>
			          	<xsl:with-param name="legend">XSL_HEADER_TRANSACTIONAL_ATTACHMENT</xsl:with-param>
			          	<xsl:with-param name="attachment-group">summarybank</xsl:with-param>
		          	</xsl:call-template>
	          	</xsl:if>
			</xsl:otherwise>
		</xsl:choose>

		<!-- Table of Contents -->
		<xsl:call-template name="toc" />
		<xsl:if test="$errorPopupMode='error'">
			<xsl:call-template name="errors"/>
		</xsl:if>
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
					<xsl:with-param name="show-template">N</xsl:with-param>
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
	<xd:doc>
		<xd:short>Imports JavaScript Files</xd:short>
		<xd:detail>
		 The javascript files for IO screen is imported
 		</xd:detail>
	</xd:doc>
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.openaccount.create_io</xsl:with-param>
			<xsl:with-param name="show-period-js">Y</xsl:with-param>
			<xsl:with-param name="override-help-access-key">PO_01</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Additional hidden fields for this form are  -->
	<!-- added here. -->
	<xd:doc>
		<xd:short>Hidden fields</xd:short>
		<xd:detail>
			Additional hidden fields for this form is added here.
 		</xd:detail>
	</xd:doc>
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
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">buyer_bank_bpo_added</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">obligor_bank_hidden</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">resubmission_count</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="resubmission_count"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">allowed_resubmission_count</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('OA_RESUMBIT_MAX_COUNT')"/></xsl:with-param>
			</xsl:call-template>
			</div>
	</xsl:template>

	<!-- General Details Fieldset. -->
	<xd:doc>
		<xd:short>General Details</xd:short>
		<xd:detail>
			This section sets different parameters for different template being called by field such as label(General details etc),this also defines variable
			for general details.
 		</xd:detail>
	</xd:doc>
	<xsl:template name="general-details">
	 <xsl:variable name="changeoption"><xsl:value-of select="utils:getActionRequiredOption(product_code,'*',tnx_type_code,prod_stat_code)"/></xsl:variable>
		<xsl:variable name="lookup-type">
			<xsl:choose>
				<xsl:when test="tnx_type_code ='31' and prod_stat_code = '75'">crossref-full-resubmission</xsl:when>
				<xsl:when test="prod_stat_code[.='43']">
					<xsl:choose>
						<xsl:when test="$changeoption='FULL'">crossref-full</xsl:when>
						<xsl:when test="$changeoption='SUMMARY'">crossref-summary</xsl:when>
					</xsl:choose>			
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="button-type"><xsl:value-of select="$lookup-type"/></xsl:with-param>
			<xsl:with-param name="content">
				<xsl:variable name="show-template-id">N</xsl:variable>
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
				<xsl:if test="cross_references and (cross_references/cross_reference/product_code != cross_references/cross_reference/child_product_code)">
					<xsl:apply-templates select="cross_references" mode="display_table_master"/>
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
						<xsl:with-param name="maxsize">16</xsl:with-param>
						<xsl:with-param name="required">
							<xsl:if test="sub_tnx_type_code != '83'">Y</xsl:if>
						</xsl:with-param>
						<xsl:with-param name="readonly"><xsl:if test="tnx_type_code[.='38'] or sub_tnx_type_code = '83'" >Y</xsl:if></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<!-- Display the PO Reference in readonly mode, for initiate IO from PO. 
				For other cases, it is an editable field. -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_PO_REF_ID</xsl:with-param>
					<xsl:with-param name="name">po_ref_id</xsl:with-param>
					<xsl:with-param name="size">35</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="readonly"><xsl:if test="tnx_type_code[.='30' or .='31' or .='38'] or (cross_references and cross_references[.!= ''] and tnx_type_code='01')" >Y</xsl:if></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_PO_ISS_DATE</xsl:with-param>
					<xsl:with-param name="name">po_issue_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<xsl:with-param name="size">10</xsl:with-param>
					<xsl:with-param name="maxsize">10</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
					<xsl:with-param name="readonly"><xsl:if test="tnx_type_code[.='30' or .='31' or .='38']  or (cross_references and cross_references[.!= ''] and tnx_type_code='01')" >Y</xsl:if></xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
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


	
	<!--
		General Details Fieldset. Issue Date, Template Validation, Buyer
		Details, Seller Details.
	-->
	<xd:doc>
		<xd:short>PO General Details</xd:short>
		<xd:detail>
			This template contains PO Purchase Order General Details Section which contains issue date,expiry date,expiry place,Provisional Status,TMA used status,buyer details,seller details etc. 
 		</xd:detail>
	</xd:doc>
	<xsl:template name="po-general-details">
		<xsl:if test="$displaymode='edit'">
			<div>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
					<xsl:with-param name="name">iss_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<xsl:with-param name="size">10</xsl:with-param>
					<xsl:with-param name="maxsize">10</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="readonly"><xsl:if test="tnx_type_code[.='31' or .='38']" >Y</xsl:if></xsl:with-param>
				</xsl:call-template>
			</div>
			
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
				<xsl:with-param name="name">exp_date</xsl:with-param>
				<xsl:with-param name="type">date</xsl:with-param>
				<xsl:with-param name="size">10</xsl:with-param>
				<xsl:with-param name="maxsize">10</xsl:with-param>
				<xsl:with-param name="fieldsize">small</xsl:with-param>
			</xsl:call-template>
			<!-- Removed as per story MPSSC-6739 -->
			<!-- <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:with-param>
      			<xsl:with-param name="name">expiry_place</xsl:with-param>
      			<xsl:with-param name="maxsize">35</xsl:with-param>
     		</xsl:call-template> -->
		</xsl:if>
		<xsl:choose>
		<xsl:when test="prod_stat_code ='43'">
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">provisional_status</xsl:with-param>
				<xsl:with-param name="value"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="securitycheck:hasCompanyPermission($rundata,'provisional_enable')">
				<xsl:choose>
					<xsl:when test="$displaymode='edit'">
					     <xsl:call-template name="checkbox-field">
						     <xsl:with-param name="label">XSL_PROVISIONAL</xsl:with-param>
						     <xsl:with-param name="name">provisional_status</xsl:with-param>
						     <xsl:with-param name="checked">
						     	<xsl:choose>
									<xsl:when test="tnx_type_code = '01'">Y</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
						     </xsl:with-param>
						     <xsl:with-param name="disabled">
							     <xsl:choose>
									<xsl:when test="tnx_type_code[.='31' or .='38' or .='01']">Y</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<!-- Disabled, doesn't make the check box not editable, readonly does it. -->
							<xsl:with-param name="readonly"><xsl:if test="tnx_type_code[.='31' or .='38' or .='01']" >Y</xsl:if></xsl:with-param>
						 </xsl:call-template>
					 </xsl:when>
					 <xsl:when test="$displaymode='view' and provisional_status = 'Y'">
					 	<xsl:call-template name="input-field">
						    <xsl:with-param name="name">provisional_status_view</xsl:with-param>
						    <xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_PROVISIONAL')"/></xsl:with-param>
					 	</xsl:call-template>
					 </xsl:when>
				 </xsl:choose>
			</xsl:if>
			</xsl:otherwise>
			</xsl:choose>
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<xsl:call-template name="checkbox-field">
			     	<xsl:with-param name="label">XSL_TMA_USED</xsl:with-param>
			     	<xsl:with-param name="name">tma_used_status</xsl:with-param>
			     	 <xsl:with-param name="checked">
						     	<xsl:choose>
									<xsl:when test="tnx_type_code [.='31' or .='01']">Y</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
				    </xsl:with-param>
					<xsl:with-param name="readonly"><xsl:if test="tnx_type_code[.='31']" >Y</xsl:if></xsl:with-param>     
			     	<xsl:with-param name="disabled">
					     <xsl:choose>
							<xsl:when test="tnx_type_code[.='38' or .='01']">Y</xsl:when>
							<xsl:otherwise>N</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$displaymode='view' and tma_used_status = 'Y'">
			 	<xsl:call-template name="input-field">
				    <xsl:with-param name="name">tma_used_status_view</xsl:with-param>
				    <xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_TMA_USED')"/></xsl:with-param>
			 	</xsl:call-template>
			 </xsl:when>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<xsl:call-template name="checkbox-field">
					   <xsl:with-param name="label">XSL_BPO_USED</xsl:with-param>
					   <xsl:with-param name="name">bpo_used_status</xsl:with-param>
					   <xsl:with-param name="value"><xsl:value-of select="bpo_used_status"/></xsl:with-param>
					      <xsl:with-param name="checked">
					   	<xsl:choose>
					   		<xsl:when test="bank_payment_obligation/PmtOblgtn/OblgrBk/BIC != '' and bank_payment_obligation/PmtOblgtn/RcptBk/BIC != ''">Y</xsl:when>
					   		<xsl:otherwise>N</xsl:otherwise>
					   	</xsl:choose>
				   	</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$displaymode='view' and bpo_used_status = 'Y'">
			 	<xsl:call-template name="input-field">
				    <xsl:with-param name="name">bpo_used_status_view</xsl:with-param>
				    <xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_BPO_USED')"/></xsl:with-param>
			 	</xsl:call-template>
			 </xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<xsl:call-template name="checkbox-field">
					   <xsl:with-param name="label">XSL_INTENT_TO_PAY_FLAG</xsl:with-param>
					   <xsl:with-param name="name">intent_to_pay_flag</xsl:with-param>
					   <xsl:with-param name="value"><xsl:value-of select="intent_to_pay_flag"/></xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$displaymode='view' and intent_to_pay_flag = 'Y'">
			 	<xsl:call-template name="input-field">
				    <xsl:with-param name="name">intent_to_pay_flag_view</xsl:with-param>
				    <xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_INTENT_TO_PAY_FLAG')"/></xsl:with-param>
			 	</xsl:call-template>
			 </xsl:when>
		</xsl:choose>
		
		<xsl:choose>
			<xsl:when test="tnx_type_code [.= '38'] and $displaymode='view'">
				<div class="field checkbox">
					<span class="label"></span>
					<ul class="content">
				          <li><xsl:value-of select="localization:getGTPString($language, 'XSL_CLOSE_TRANSACTION')"/>
				          </li>
			         </ul>
		         </div>
			</xsl:when>
			<xsl:when test="tnx_type_code [.= '31' or .= '38'] and $mode = 'DRAFT'">
				<xsl:call-template name="checkbox-field">
				     <xsl:with-param name="label">XSL_CLOSE_TRANSACTION</xsl:with-param>
				     <xsl:with-param name="name">close_tnx</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
		
		<!-- Issue Date -->
		<!-- Displayed in consolidated view -->
		<xsl:if	test="$displaymode='view'">
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
				<xsl:with-param name="name">iss_date</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		&nbsp;

		<xsl:if test="bo_comment[.!='']">
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_BANK_MESSAGE</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
					    <xsl:call-template name="input-field">
						    <xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT</xsl:with-param>
						    <xsl:with-param name="id">bo_comment_view</xsl:with-param>
						    <xsl:with-param name="value" select="bo_comment" />
						    <xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bo_comment</xsl:with-param>
				<xsl:with-param name="value" select="bo_comment" />
			</xsl:call-template>
		</xsl:if>
		<!-- Display the Buyer and Seller Details in readonly mode, for initiate IO from PO. 
				For other cases, they are editable fields. -->
	<div id ="buyerSellerDetails">
		<xsl:choose>
			<xsl:when test = "cross_references and cross_references[.!= ''] and cross_references/cross_reference/product_code[.='PO']">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-entity">Y</xsl:with-param>
							<xsl:with-param name="show-country-icon">N</xsl:with-param>
							<xsl:with-param name="show-entity-button">Y</xsl:with-param>
							<xsl:with-param name="prefix">buyer</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>											
						</xsl:call-template>
						<!--
							If we have to, we show the reference field for applicants. This is
							specific to this form.
						-->
						<xsl:if
							test="not(avail_main_banks/bank/entity/customer_reference) and not(avail_main_banks/bank/customer_reference)">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
								<xsl:with-param name="name">buyer_reference</xsl:with-param>
								<xsl:with-param name="maxsize">34</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-country-icon">N</xsl:with-param>
							<xsl:with-param name="prefix">seller</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<xsl:with-param name="readonly-bank-bic">N</xsl:with-param>
							<xsl:with-param name="show-bank-bic">Y</xsl:with-param>
							<xsl:with-param name="show-button">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-entity">Y</xsl:with-param>
							<xsl:with-param name="show-entity-button">
							<xsl:choose>
								<xsl:when test="prod_stat_code[.='75'] and tnx_type_code[.='31'] and buyer_name[.!='']">N</xsl:when>
								<xsl:otherwise>Y</xsl:otherwise>
							</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="readonly">
								<xsl:choose>
									<xsl:when test="prod_stat_code[.='75'] and tnx_type_code[.='31'] and buyer_name[.!='']">Y</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-country-icon">
								<xsl:choose>
									<xsl:when test="prod_stat_code[.='75'] and tnx_type_code[.='31'] and buyer_name[.!=''] and buyer_country[.!='']">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="prefix">buyer</xsl:with-param>
						</xsl:call-template>
						
						<!--
							If we have to, we show the reference field for applicants. This is
							specific to this form.
						-->
						<xsl:if
							test="not(avail_main_banks/bank/entity/customer_reference) and not(avail_main_banks/bank/customer_reference)">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
								<xsl:with-param name="name">buyer_reference</xsl:with-param>
								<xsl:with-param name="maxsize">34</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-button">
								<xsl:if test="prod_stat_code[.!='75'] and tnx_type_code[.!='31'] and seller_name[.='']">Y</xsl:if>
							</xsl:with-param>
							<xsl:with-param name="prefix">seller</xsl:with-param>
							<xsl:with-param name="show-bank-bic">Y</xsl:with-param>
							<xsl:with-param name="readonly-bank-bic">N</xsl:with-param>
							<xsl:with-param name="show-country-icon">
								<xsl:choose>
									<xsl:when test="prod_stat_code[.!='75'] and tnx_type_code[.!='31'] and seller_name[.=''] and seller_country[.='']">Y</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>	
							<xsl:with-param name="readonly">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	
		
		

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
			 <!-- Tab 0_0 - Bill To  -->
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
			 <!-- Tab 0_2 - Consignee -->
			<xsl:with-param name="tab2-label">XSL_HEADER_CONSIGNEE_DETAILS</xsl:with-param>
			<xsl:with-param name="tab2-content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="prefix">consgn</xsl:with-param>
					<xsl:with-param name="show-button">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		</div>
	</xsl:template>
		
	<!--Other Templates-->

	<!--
   PO Realform.
   -->
   <xd:doc>
   	<xd:short>Contains hidden field data</xd:short>
   	<xd:detail>This field contain all hidden field data such as tnx id,mode and sets its parameters</xd:detail>
   </xd:doc>
	<xsl:template name="realform">
		<!--
			Do not display this section when the collaboration mode is
			'counterparty'
		-->
		<xsl:if test="$collaborationmode != 'counterparty'">
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
							<xsl:with-param name="value" select="tnx_type_code"/>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">subtnxtype</xsl:with-param>
							<xsl:with-param name="value" select="sub_tnx_type_code"/>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">prodstatus</xsl:with-param>
							<xsl:with-param name="value" select="prod_stat_code"/>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">attIds</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">TransactionData</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">error_msg</xsl:with-param>
							<xsl:with-param name="value" select="error_msg"/>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">close_tnx</xsl:with-param>
							<xsl:with-param name="value" select="close_tnx"/>
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
		</xsl:if>
	</xsl:template>
	
</xsl:stylesheet>
