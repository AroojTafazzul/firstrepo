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
		<xsl:apply-templates select="dm_tnx_record"/>
	</xsl:template>
	<xsl:template match="dm_tnx_record">
		<!-- Main node -->
		<xsl:element name="gtp:BillOfExchange" xmlns:gtp="http://www.neomalogic.com" xmlns:cmp="http://www.bolero.net">
			<!--Header: empty so far -->
			<xsl:element name="gtp:Header">
				<xsl:element name="gtp:DocumentID">
					<xsl:element name="gtp:RID"/>
					<xsl:element name="gtp:GeneralID"/>
				</xsl:element>
				<xsl:element name="gtp:DocType">
					<xsl:element name="gtp:DocTypeCode"/>
				</xsl:element>
				<xsl:element name="gtp:Status"/>
			</xsl:element>
			<!--Body -->
			<xsl:element name="gtp:Body">
				<!--General information section -->
				<xsl:element name="gtp:GeneralInformation">
					<xsl:element name="gtp:dateOfIssue">
						<xsl:value-of select="prep_date"/>
					</xsl:element>
					<xsl:element name="gtp:PlaceOfIssue">
						<xsl:element name="gtp:locationName">
							<xsl:value-of select="CountryOfOrigin/countryName"/>
						</xsl:element>
					</xsl:element>
					<!--Purchase Order -->
					<xsl:element name="gtp:PurchaseOrderIdentifier">
						<xsl:element name="gtp:documentNumber">
							<xsl:value-of select="purchaseOrderReference"/>
						</xsl:element>
					</xsl:element>
					<!--Documentary credit: Issuing bank ref -->
					<xsl:element name="gtp:DocumentaryCreditIdentifier">
						<xsl:element name="gtp:documentNumber">
							<xsl:value-of select="documentaryCreditReference"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>
				<!--Parties -->
				<xsl:element name="gtp:Parties">
					<!--Buyer is mandatory -->
					<xsl:element name="gtp:Buyer">
						<xsl:apply-templates select="Buyer"/>
					</xsl:element>
					<!--Seller is mandatory -->
					<xsl:element name="gtp:Seller">
						<xsl:apply-templates select="Shipper"/>
					</xsl:element>
					<!--Other are optionals -->
					<xsl:element name="gtp:Consignee">
						<xsl:apply-templates select="Consignee"/>
					</xsl:element>
					<xsl:element name="gtp:BillTo">
						<xsl:apply-templates select="BillTo"/>
					</xsl:element>
				</xsl:element>
				
				<!--Additional information-->
				<xsl:element name="gtp:AdditionalInformation">
					<xsl:apply-templates select="AdditionalInformation/line"/>
				</xsl:element>
				
				<!--Totals-->
				<xsl:element name="gtp:Totals">
					<xsl:element name="gtp:TotalAmount">
						<xsl:apply-templates select="Totals/Total"/>
					</xsl:element>
				</xsl:element>
				
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="Buyer | Shipper | Consignee | BillTo">
		<xsl:element name="gtp:organizationName">
			<xsl:value-of select="organizationName"/>
		</xsl:element>
		<xsl:element name="gtp:OrganizationIdentification">
			<xsl:element name="gtp:organizationReference">
				<xsl:value-of select="organizationReference"/>
			</xsl:element>
		</xsl:element>
		<xsl:element name="gtp:AddressInformation">
			<xsl:element name="gtp:FullAddress">
				<xsl:element name="gtp:line">
					<xsl:value-of select="addressLine1"/>
				</xsl:element>
				<xsl:element name="gtp:line">
					<xsl:value-of select="addressLine2"/>
				</xsl:element>
				<xsl:element name="gtp:line">
					<xsl:value-of select="addressLine3"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
		
	<xsl:template match="AdditionalInformation/line">
		<xsl:element name="gtp:line">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<!-- Total template -->
	<xsl:template match="Totals/Total">
		<xsl:element name="gtp:MultiCurrency">
			<xsl:element name="gtp:value">
				<xsl:value-of select="totalAmount"/>
			</xsl:element>
			<xsl:element name="gtp:currencyCode">
				<xsl:value-of select="totalCurrencyCode"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
		
</xsl:stylesheet>
