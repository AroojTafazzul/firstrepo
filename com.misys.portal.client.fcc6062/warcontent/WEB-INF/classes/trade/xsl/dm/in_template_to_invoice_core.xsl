<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gtp="http://www.neomalogic.com" xmlns:cmp="http://www.bolero.net">
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
		<xsl:element name="CommercialInvoice">
			<!--Header: empty so far -->
			<xsl:element name="Header">
				<xsl:element name="cmp:DocumentID">
					<xsl:element name="cmp:RID">
						<xsl:value-of select="commercialInvoiceReference"/>
					</xsl:element>
					<xsl:element name="cmp:GeneralID">
						<xsl:value-of select="commercialInvoiceReference"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="cmp:DocType">
					<xsl:element name="cmp:DocTypeCode"/>
				</xsl:element>
				<xsl:element name="cmp:Status"/>
			</xsl:element>
			<!--Body -->
			<xsl:element name="Body">
				<!--General information section -->
				<xsl:element name="GeneralInformation">
					<xsl:element name="dateOfIssue">
						<xsl:value-of select="prep_date"/>
					</xsl:element>
					<xsl:element name="PlaceOfIssue">
						<xsl:element name="locationName">
							<xsl:value-of select="CountryOfOrigin/countryName"/>
						</xsl:element>
					</xsl:element>Header
					<!--Purchase Order -->
					<xsl:element name="PurchaseOrderIdentifier">
						<xsl:element name="documentNumber">
							<xsl:value-of select="purchaseOrderReference"/>
						</xsl:element>
					</xsl:element>
					<!--Documentary credit: Issuing bank ref -->
					<xsl:element name="DocumentaryCreditIdentifier">
						<xsl:element name="documentNumber">
							<xsl:value-of select="documentaryCreditReference"/>
						</xsl:element>
					</xsl:element>
					<xsl:element name="Incoterms">
						<xsl:element name="incotermsCode">
							<xsl:value-of select="Incoterms/incotermsCode"/>
						</xsl:element>
						<xsl:element name="NamedLocation">
							<xsl:element name="locationName">
								<xsl:value-of select="Incoterms/incotermsPlace"/>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:element>
				<!-- Incoterms -->
				<!--Parties -->
				<xsl:element name="Parties">
					<!--Buyer is mandatory -->
					<xsl:element name="Buyer">
						<xsl:apply-templates select="Buyer"/>
					</xsl:element>
					<!--Seller is mandatory -->
					<xsl:element name="Seller">
						<xsl:apply-templates select="Shipper"/>
					</xsl:element>
					<!--Other are optionals -->
					<xsl:element name="Consignee">
						<xsl:apply-templates select="Consignee"/>
					</xsl:element>
					<xsl:element name="BillTo">
						<xsl:apply-templates select="BillTo"/>
					</xsl:element>
				</xsl:element>
				<!--TermsAndConditions-->
				<xsl:element name="TermsAndConditions">
					<xsl:copy-of select="TermsAndConditions/*"/>
				</xsl:element>
				<!--RoutingSummary-->
				<xsl:element name="RoutingSummary">
					<xsl:apply-templates select="RoutingSummary"/>
					<xsl:element name="CountryOfOrigin">
						<xsl:element name="countryName">
							<xsl:value-of select="CountryOfOrigin/countryName"/>
						</xsl:element>
					</xsl:element>
					<!-- No Country Of Dest
					<xsl:element name="CountryOfDestination">
						<xsl:element name="countryName">
							<xsl:value-of select="CountryOfDestination/countryName"/>
						</xsl:element>
					</xsl:element>-->
				</xsl:element>
				<!--LineItemDetails-->
				<xsl:element name="LineItemDetails">
					<xsl:apply-templates select="LineItemDetails/Item"/>
				</xsl:element>
				<!--GeneralChargesOrDiscounts-->
				<xsl:apply-templates select="GeneralChargesOrDiscounts"/>
				<!--Totals-->
				<xsl:element name="Totals">
					<xsl:element name="TotalAmount">
						<xsl:apply-templates select="Totals/Total"/>
					</xsl:element>
				</xsl:element>
				<!--PaymentTerms-->
				<xsl:element name="PaymentTerms">
					<xsl:element name="PaymentTermsDetail">
						<xsl:element name="UserDefinedPaymentTerms">
							<xsl:copy-of select="PaymentTerms/line"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>
				<!--Additional information-->
				<xsl:element name="AdditionalInformation">
					<xsl:copy-of select="AdditionalInformation/line"/>
				</xsl:element>
				<!--Additional information added fot GTP advices, not part of Bolero DTDs-->
				<!--PackingDetail-->
				<xsl:element name="gtp:PackingDetail">
					<xsl:element name="gtp:TotalNetWeight">
						<xsl:element name="gtp:value">
							<xsl:value-of select="PackingDetail/totalNetWeightValue"/>
						</xsl:element>
						<xsl:element name="gtp:weightUnitCode">
							<xsl:value-of select="PackingDetail/totalNetWeightUnitCode"/>
						</xsl:element>
					</xsl:element>
					<xsl:element name="gtp:TotalGrossWeight">
						<xsl:element name="gtp:value">
							<xsl:value-of select="PackingDetail/totalGrossWeightValue"/>
						</xsl:element>
						<xsl:element name="gtp:weightUnitCode">
							<xsl:value-of select="PackingDetail/totalNetWeightUnitCode"/>
						</xsl:element>
					</xsl:element>
					<xsl:element name="gtp:TotalNetVolume">
						<xsl:element name="gtp:value">
							<xsl:value-of select="PackingDetail/totalNetVolumeValue"/>
						</xsl:element>
						<xsl:element name="gtp:volumeUnitCode">
							<xsl:value-of select="PackingDetail/totalNetVolumeUnitCode"/>
						</xsl:element>
					</xsl:element>
					<xsl:element name="gtp:TotalGrossVolume">
						<xsl:element name="gtp:value">
							<xsl:value-of select="PackingDetail/totalGrossVolumeValue"/>
						</xsl:element>
						<xsl:element name="gtp:volumeUnitCode">
							<xsl:value-of select="PackingDetail/totalGrossVolumeUnitCode"/>
						</xsl:element>
					</xsl:element>
					<xsl:apply-templates select="PackingDetail/Package"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="Buyer | Shipper | Consignee | BillTo">
		<xsl:element name="organizationName">
			<xsl:value-of select="organizationName"/>
		</xsl:element>
		<xsl:element name="OrganizationIdentification">
			<xsl:element name="organizationReference">
				<xsl:value-of select="organizationReference"/>
			</xsl:element>
		</xsl:element>
		<xsl:element name="AddressInformation">
			<xsl:element name="FullAddress">
				<xsl:element name="line">
					<xsl:value-of select="addressLine1"/>
				</xsl:element>
				<xsl:element name="line">
					<xsl:value-of select="addressLine2"/>
				</xsl:element>
				<xsl:element name="line">
					<xsl:value-of select="addressLine3"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- Routing summary template -->
	<xsl:template match="RoutingSummary">
		<xsl:element name="transportService">
			<xsl:value-of select="transportService"/>
		</xsl:element>
		<xsl:choose>
			<xsl:when test="transportType[.='MARITIME' or .='INLANDWATER']">
				<xsl:element name="MeansOfTransport">
					<xsl:element name="SeaTransportIdentification">
						<xsl:element name="Vessel">
							<xsl:element name="vesselName">
								<xsl:value-of select="vesselName"/>
							</xsl:element>
						</xsl:element>
						<xsl:element name="VoyageDetail">
							<xsl:element name="voyageNumber">
								<xsl:value-of select="transportReference"/>
							</xsl:element>
							<xsl:element name="departureDate">
								<xsl:value-of select="departureDate"/>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:when>
			<xsl:when test="transportType[.='AIR']">
				<xsl:element name="MeansOfTransport">
					<xsl:element name="FlightDetails">
						<xsl:element name="flightNumber">
							<xsl:value-of select="transportReference"/>
						</xsl:element>
						<xsl:element name="departureDate">
							<xsl:value-of select="departureDate"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:when>
			<xsl:when test="transportType[.='ROAD']">
				<xsl:element name="MeansOfTransport">
					<xsl:element name="RoadTransportIdentification">
						<xsl:element name="licencePlateIdentification">
							<xsl:value-of select="transportReference"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:when>
			<xsl:when test="transportType[.='RAIL']">
				<xsl:element name="MeansOfTransport">
					<xsl:element name="RailTransportIdentification">
						<xsl:element name="locomotiveNumber">
							<xsl:value-of select="transportReference"/>
						</xsl:element>
						<xsl:element name="railCarNumber"/>
					</xsl:element>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
		<xsl:element name="PlaceOfLoading">
			<xsl:element name="locationName">
				<xsl:value-of select="PlaceOfLoading/locationName"/>
			</xsl:element>
		</xsl:element>
		<xsl:element name="PlaceOfDischarge">
			<xsl:element name="locationName">
				<xsl:value-of select="PlaceOfDischarge/locationName"/>
			</xsl:element>
		</xsl:element>
		<xsl:element name="PlaceOfDelivery">
			<xsl:element name="locationName">
				<xsl:value-of select="PlaceOfDelivery/locationName"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!--Product item template -->
	<xsl:template match="LineItemDetails/Item">
		<xsl:if test="totalPrice[.!='']">
			<xsl:element name="LineItem">
				<xsl:element name="lineItemNumber">
					<xsl:value-of select="itemNumber"/>
				</xsl:element>
				<xsl:element name="PurchaseOrderIdentifier">
					<xsl:element name="documentNumber">
						<xsl:value-of select="purchaseOrderReference"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="ExportLicenseIdentifier">
					<xsl:element name="documentNumber">
						<xsl:value-of select="exportLicenseReference"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="UnitPrice">
					<xsl:element name="value">
						<xsl:value-of select="basePrice"/>
					</xsl:element>
					<xsl:element name="currencyCode">
						<xsl:value-of select="baseCurrencyCode"/>
					</xsl:element>
					<xsl:element name="unitOfMeasureCode">
						<xsl:value-of select="baseUnitOfMeasureCode"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="LineItemQuantity">
					<xsl:element name="value">
						<xsl:value-of select="itemQuantity"/>
					</xsl:element>
					<xsl:element name="unitOfMeasureCode">
						<xsl:value-of select="itemQuantityUnitOfMeasureCode"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="gtp:EquivalentAmount">
					<xsl:element name="gtp:rate">
						<xsl:value-of select="rate"/>
					</xsl:element>
					<xsl:element name="gtp:value">
						<xsl:value-of select="totalPrice"/>
					</xsl:element>
					<xsl:element name="gtp:currencyCode">
						<xsl:value-of select="totalCurrencyCode"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="Product">
					<xsl:element name="productName">
						<xsl:value-of select="productName"/>
					</xsl:element>
					<xsl:element name="ProductIdentifiers">
						<xsl:element name="productIdentification">
							<xsl:value-of select="productIdentification"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<!-- Charges or Discounts template -->
	<xsl:template match="GeneralChargesOrDiscounts">
		<xsl:if test="chargeReportingAmount[.!=''] or chargeType[.!='']">
			<xsl:element name="GeneralChargesOrDiscounts">
				<xsl:element name="LumpSumChargeWithDocumentIdentifier">
					<xsl:element name="chargeType">
						<xsl:value-of select="chargeType"/>
					</xsl:element>
					<xsl:element name="ChargeAmount">
						<xsl:element name="value">
							<xsl:value-of select="chargeAmount"/>
						</xsl:element>
						<xsl:element name="currencyCode">
							<xsl:value-of select="chargeCurrencyCode"/>
						</xsl:element>
					</xsl:element>
					<xsl:element name="gtp:EquivalentAmount">
						<xsl:element name="gtp:rate">
							<xsl:value-of select="rate"/>
						</xsl:element>
						<xsl:element name="gtp:value">
							<xsl:value-of select="chargeReportingAmount"/>
						</xsl:element>
						<xsl:element name="gtp:currencyCode">
							<xsl:value-of select="chargeReportingCurrencyCode"/>
						</xsl:element>
					</xsl:element>
					<xsl:element name="DocumentIdentifier">
						<xsl:element name="documentNumber">
							<xsl:value-of select="chargeDescription"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<!-- Total template -->
	<xsl:template match="Totals/Total">
		<xsl:element name="MultiCurrency">
			<xsl:element name="value">
				<xsl:value-of select="totalAmount"/>
			</xsl:element>
			<xsl:element name="currencyCode">
				<xsl:value-of select="totalCurrencyCode"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!--Packing detail / Package template -->
	<!--Added for GTP advice generation, not required in Bolero -->
	<xsl:template match="PackingDetail/Package">
		<xsl:if test="typeOfPackage[.!=''] or productName[.!=''] or marksAndNumbers[.!='']">
			<xsl:element name="gtp:Package">
				<xsl:element name="gtp:PackageCount">
					<xsl:element name="gtp:numberOfPackages">
						<xsl:value-of select="numberOfPackages"/>
					</xsl:element>
					<xsl:element name="gtp:typeOfPackage">
						<xsl:value-of select="typeOfPackage"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="gtp:marksAndNumbers">
					<xsl:value-of select="marksAndNumbers"/>
				</xsl:element>
				<xsl:element name="gtp:PackageDimensions">
					<xsl:element name="gtp:heightValue">
						<xsl:value-of select="heightValue"/>
					</xsl:element>
					<xsl:element name="gtp:widthValue">
						<xsl:value-of select="widthValue"/>
					</xsl:element>
					<xsl:element name="gtp:lengthValue">
						<xsl:value-of select="lengthValue"/>
					</xsl:element>
					<xsl:element name="gtp:dimensionUnitCode">
						<xsl:value-of select="dimensionUnitCode"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="gtp:NetWeight">
					<xsl:element name="gtp:value">
						<xsl:value-of select="netWeightValue"/>
					</xsl:element>
					<xsl:element name="gtp:weightUnitCode">
						<xsl:value-of select="weightUnitCode"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="gtp:GrossWeight">
					<xsl:element name="gtp:value">
						<xsl:value-of select="grossWeightValue"/>
					</xsl:element>
					<xsl:element name="gtp:weightUnitCode">
						<xsl:value-of select="weightUnitCode"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="gtp:GrossVolume">
					<xsl:element name="gtp:value">
						<xsl:value-of select="grossVolumeValue"/>
					</xsl:element>
					<xsl:element name="gtp:volumeUnitCode">
						<xsl:value-of select="volumeUnitCode"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="gtp:Content">
					<xsl:element name="gtp:Product">
						<xsl:element name="gtp:productName">
							<xsl:value-of select="productName"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
