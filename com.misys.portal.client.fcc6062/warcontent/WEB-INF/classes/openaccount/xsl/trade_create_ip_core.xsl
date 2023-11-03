<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	exclude-result-prefixes="localization securityCheck">

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
	<xsl:param name="product-code">IP</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="nextscreen" />
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath" /><xsl:value-of select="$servletPath" />/screen/InvoicePayableScreen</xsl:param>

	<!-- if value = 'TEMPLATE', open all dynamic input forms -->
	<xsl:param name="option" />

	<!-- All marks used to shown/hidden form's sections-->
	<xsl:param name="section_po_line_items">Y</xsl:param>
	<xsl:param name="section_po_amount_details">Y</xsl:param>
	<xsl:param name="section_amount_details">Y</xsl:param>
	<xsl:param name="section_po_payment_terms">Y</xsl:param>
	<xsl:param name="section_po_settlement_terms">Y</xsl:param>
	<xsl:param name="section_po_documents_required" />
	<xsl:param name="section_po_shipment_details" />
	<xsl:param name="section_po_inco_terms">Y</xsl:param>
	<xsl:param name="section_po_routing_summary">Y</xsl:param>
	<xsl:param name="section_po_user_info" />
	<xsl:param name="section_po_contact" />
	<xsl:param name="section_po_adjustements_details">Y</xsl:param>
	<xsl:param name="section_po_taxes_details">Y</xsl:param>
	<xsl:param name="section_po_freight_charges_details">Y</xsl:param>
	<xsl:param name="section_po_buyer_reference">Y</xsl:param>
	<xsl:param name="section_line_item_adjustments_details">Y</xsl:param>	
	<xsl:param name="section_line_item_taxes_details">Y</xsl:param>	
	<xsl:param name="section_line_item_freight_charges_details">Y</xsl:param>
	<xsl:param name="section_line_item_shipment_details" />
	<xsl:param name="section_line_item_inco_terms_details">Y</xsl:param>
	<xsl:param name="section_line_item_po_reference">N</xsl:param>
	<xsl:param name="section_line_item_total_net_amount_details">Y</xsl:param>	
	<xsl:param name="section_line_item_routing_summary">N</xsl:param>
	<xsl:param name="section_shipment_sub_schedule">N</xsl:param>
	<xsl:param name="show-template" />
	<xsl:param name="product-currency-label">XSL_INVOICE_PAYABLE_CURRENCY_CODE</xsl:param>

	<xsl:include href="../../openaccount/xsl/po_common.xsl" />
	<xsl:include href="../../core/xsl/products/product_addons.xsl" />
	<xsl:include href="../../core/xsl/common/com_cross_references.xsl" />
	<xsl:include href="../../core/xsl/common/trade_common.xsl" />
	<xsl:include href="../../openaccount/xsl/trade_create_ip_details.xsl" />
	<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
	<xsl:include href="../../core/xsl/common/fscm_common.xsl" />

	<xsl:output method="html" version="4.01" indent="no"
		encoding="UTF-8" omit-xml-declaration="yes" />
	
	<xsl:template match="/">
		<xsl:apply-templates select="ip_tnx_record" />
	</xsl:template>

	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.openaccount.create_ip</xsl:with-param>
			<xsl:with-param name="show-period-js">Y</xsl:with-param>
			<xsl:with-param name="override-lowercase-product-code">ip</xsl:with-param>
			<xsl:with-param name="override-help-access-key">IP_01</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
