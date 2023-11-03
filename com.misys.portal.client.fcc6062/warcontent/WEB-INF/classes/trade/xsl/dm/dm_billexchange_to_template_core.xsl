<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
							 xmlns:gtp="http://www.neomalogic.com"
							xmlns:cmp="http://www.bolero.net">
	<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
	<xsl:template match="/">
		<!-- Main node -->
		<xsl:element name="dm_tnx_record">
			<xsl:apply-templates select="document/gtp:BillOfExchange"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="document/gtp:BillOfExchange">

			<xsl:element name="CountryOfOrigin">
				<xsl:element name="countryName">
					<xsl:value-of select="gtp:Body/gtp:GeneralInformation/gtp:PlaceOfIssue/gtp:locationName"/>
				</xsl:element>
			</xsl:element>
			<!--
			<xsl:element name="CountryOfDestination">
				<xsl:element name="countryName">
					<xsl:value-of select="country_of_destination"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="commercialInvoiceReference">
				<xsl:value-of select="comercial_invoice_identifier"/>
			</xsl:element>
			<xsl:element name="exportDocumentaryCreditReference">
				<xsl:value-of select="advising_bank_reference"/>
			</xsl:element>
			<xsl:element name="exporterReference">
				<xsl:value-of select="exporter_reference"/>
			</xsl:element>
			-->
			<xsl:element name="purchaseOrderReference">
				<xsl:value-of select="gtp:Body/gtp:GeneralInformation/gtp:PurchaseOrderIdentifier/gtp:documentNumber"/>
			</xsl:element>
			<xsl:element name="documentaryCreditReference">
				<xsl:value-of select="gtp:Body/gtp:GeneralInformation/gtp:DocumentaryCreditIdentifier/gtp:documentNumber"/>
			</xsl:element>
			
			<xsl:element name="Buyer">
				<xsl:apply-templates select="gtp:Body/gtp:Parties/gtp:Buyer"/>
			</xsl:element>
			<xsl:element name="Shipper">
				<xsl:apply-templates select="gtp:Body/gtp:Parties/gtp:Seller"/>
			</xsl:element>
			<xsl:element name="Consignee">
				<xsl:apply-templates select="gtp:Body/gtp:Parties/gtp:Consignee"/>
			</xsl:element>
			<xsl:element name="BillTo">
				<xsl:apply-templates select="gtp:Body/gtp:Parties/gtp:BillTo"/>
			</xsl:element>
			
			<!--Additional information-->
			<xsl:element name="AdditionalInformation">
				<xsl:apply-templates select="gtp:Body/gtp:AdditionalInformation/gtp:line"/>
			</xsl:element>
				
			<xsl:element name="Totals">
				<xsl:element name="Total">
					<xsl:element name="totalAmount">
						<xsl:value-of select="gtp:Body/gtp:Totals/gtp:TotalAmount/gtp:MultiCurrency/gtp:value"/>
					</xsl:element>
					<xsl:element name="totalCurrencyCode">
						<xsl:value-of select="gtp:Body/gtp:Totals/gtp:TotalAmount/gtp:MultiCurrency/gtp:currencyCode"/>
					</xsl:element>
				</xsl:element>
			</xsl:element>
	</xsl:template>

	
	<xsl:template match="gtp:Buyer | gtp:Seller| gtp:Consignee | gtp:BillTo">
		<xsl:element name="organizationName">
			<xsl:value-of select="gtp:organizationName"/>
		</xsl:element>
		<xsl:element name="organizationReference">
			<xsl:value-of select="gtp:OrganizationIdentification/gtp:organizationReference"/>
		</xsl:element>
		<xsl:element name="addressLine1">
			<xsl:value-of select="gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='1']"/>
		</xsl:element>
		<xsl:element name="addressLine2">
			<xsl:value-of select="gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='2']"/>
		</xsl:element>
		<xsl:element name="addressLine3">
			<xsl:value-of select="gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='3']"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="gtp:AdditionalInformation/gtp:line">
		<xsl:element name="line">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>


</xsl:stylesheet>
