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
			<xsl:apply-templates select="document/CommercialInvoice"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="document/CommercialInvoice">

			<xsl:element name="CountryOfOrigin">
				<xsl:element name="countryName">
					<xsl:value-of select="Body/RoutingSummary/CountryOfOrigin/countryName"/>
				</xsl:element>
			</xsl:element>
			<!-- No country of dest in commercial invoice
			<xsl:element name="CountryOfDestination">
				<xsl:element name="countryName">
					<xsl:value-of select="Body/RoutingSummary/CountryOfDestination/countryName"/>
				</xsl:element>
			</xsl:element>
			-->
			<!--
			<xsl:element name="exportDocumentaryCreditReference">
				<xsl:value-of select="advising_bank_reference"/>
			</xsl:element>
			<xsl:element name="exporterReference">
				<xsl:value-of select="exporter_reference"/>
			</xsl:element>
			<xsl:element name="commercialInvoiceReference">
				<xsl:value-of select="Header/cmp:DocumentID/cmp:GeneralID"/>
			</xsl:element>
			-->
			<xsl:element name="purchaseOrderReference">
				<xsl:value-of select="Body/GeneralInformation/PurchaseOrderIdentifier/documentNumber"/>
			</xsl:element>
			<xsl:element name="documentaryCreditReference">
				<xsl:value-of select="Body/GeneralInformation/DocumentaryCreditIdentifier/documentNumber"/>
			</xsl:element>
			
			<!--Incoterms-->
			<xsl:element name="Incoterms">
				<xsl:element name="incotermsCode">
					<xsl:value-of select="Body/GeneralInformation/Incoterms/incotermsCode"/>
				</xsl:element>
				<xsl:element name="incotermsPlace">
					<xsl:value-of select="Body/GeneralInformation/Incoterms/NamedLocation/locationName"/>
				</xsl:element>
			</xsl:element>

			<!--Parties-->
			<xsl:element name="Buyer">
				<xsl:apply-templates select="Body/Parties/Buyer"/>
			</xsl:element>
			<xsl:element name="Shipper">
				<xsl:apply-templates select="Body/Parties/Seller"/>
			</xsl:element>
			<xsl:element name="Consignee">
				<xsl:apply-templates select="Body/Parties/Consignee"/>
			</xsl:element>
			<xsl:element name="BillTo">
				<xsl:apply-templates select="Body/Parties/BillTo"/>
			</xsl:element>
			
			<!--TermsAndConditions-->
			<xsl:element name="TermsAndConditions">
				<xsl:copy-of select="Body/TermsAndConditions/*"/>
			</xsl:element>
				
			<!--RoutingSummary-->
			<xsl:element name="RoutingSummary">
				<xsl:element name="transportService">
					<xsl:value-of select="Body/RoutingSummary/transportService"/>
				</xsl:element>
				<xsl:choose>
					<xsl:when test="Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification">
						<xsl:element name="transportType">MARITIME</xsl:element>
						<xsl:element name="departureDate">
							<xsl:value-of select="Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/VoyageDetail/departureDate"/>
						</xsl:element>
						<xsl:element name="transportReference">
							<xsl:value-of select="Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/VoyageDetail/voyageNumber"/>
						</xsl:element>
						<xsl:element name="vesselName">
							<xsl:value-of select="Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/Vessel/vesselName"/>
						</xsl:element>
					</xsl:when>
					<xsl:when test="Body/RoutingSummary/MeansOfTransport/FlightDetails">
						<xsl:element name="transportType">AIR</xsl:element>
						<xsl:element name="departureDate">
							<xsl:value-of select="Body/RoutingSummary/FlightDetails/departureDate"/>
						</xsl:element>
						<xsl:element name="transportReference">
							<xsl:value-of select="Body/RoutingSummary/FlightDetails/flightNumber"/>
						</xsl:element>
					</xsl:when>
					<xsl:when test="Body/RoutingSummary/MeansOfTransport/RoadTransportIdentification">
						<xsl:element name="transportType">ROAD</xsl:element>
						<xsl:element name="transportReference">
							<xsl:value-of select="Body/RoutingSummary/RoadTransportIdentification/licencePlateIdentification"/>
						</xsl:element>
					</xsl:when>
					<xsl:when test="Body/RoutingSummary/MeansOfTransport/RailTransportIdentification">
						<xsl:element name="transportType">RAIL</xsl:element>
						<xsl:element name="transportReference">
							<xsl:value-of select="Body/RoutingSummary/RailTransportIdentification/locomotiveNumber"/> - <xsl:value-of select="Body/RoutingSummary/RailTransportIdentification/railCarNumber"/>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:element name="PlaceOfLoading">
					<xsl:element name="locationName">
						<xsl:value-of select="Body/RoutingSummary/PlaceOfLoading/locationName"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="PlaceOfDischarge">
					<xsl:element name="locationName">
						<xsl:value-of select="Body/RoutingSummary/PlaceOfDischarge/locationName"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="PlaceOfDelivery">
					<xsl:element name="locationName">
						<xsl:value-of select="Body/RoutingSummary/PlaceOfDelivery/locationName"/>
					</xsl:element>
				</xsl:element>
				<!-- Doesn't exist in Commercial Invoice
				<xsl:element name="PlaceOfReceipt">
					<xsl:element name="locationName">
						<xsl:value-of select="place_of_receipt"/>
					</xsl:element>
				</xsl:element>
				-->
			</xsl:element>

			<!--LineItemDetails-->
			<xsl:element name="LineItemDetails">
				<xsl:apply-templates select="Body/LineItemDetails/LineItem"/>
			</xsl:element>
				
			<!--GeneralChargesOrDiscounts-->
			<xsl:apply-templates select="Body/GeneralChargesOrDiscounts/LumpSumChargeWithDocumentIdentifier"/>
				
			<!--PaymentTerms-->
			<xsl:element name="PaymentTerms">
				<xsl:copy-of select="Body/PaymentTerms/PaymentTermsDetail/UserDefinedPaymentTerms/line"/>
			</xsl:element>
				
			<!--Additional information-->
			<xsl:element name="AdditionalInformation">
				<xsl:apply-templates select="Body/AdditionalInformation/line"/>
			</xsl:element>
				
			<!--PAcking details-->
			<xsl:element name="PackingDetail">
				<xsl:element name="totalNetWeightValue">
					<xsl:value-of select="Body/gtp:PackingDetail/gtp:TotalNetWeight/gtp:value"/>
				</xsl:element>
				<xsl:element name="totalNetWeightUnitCode">
					<xsl:value-of select="Body/gtp:PackingDetail/gtp:TotalNetWeight/gtp:weightUnitCode"/>
				</xsl:element>
				<xsl:element name="totalGrossWeightValue">
					<xsl:value-of select="Body/gtp:PackingDetail/gtp:TotalGrossWeight/gtp:value"/>
				</xsl:element>
				<xsl:element name="totalGrossWeightUnitCode">
					<xsl:value-of select="Body/gtp:PackingDetail/gtp:TotalGrossWeight/gtp:weightUnitCode"/>
				</xsl:element>
				<xsl:element name="totalNetVolumeValue">
					<xsl:value-of select="Body/gtp:PackingDetail/gtp:TotalNetVolume/gtp:value"/>
				</xsl:element>
				<xsl:element name="totalNetVolumeUnitCode">
					<xsl:value-of select="Body/gtp:PackingDetail/gtp:TotalNetVolume/gtp:volumeUnitCode"/>
				</xsl:element>
				<xsl:element name="totalGrossVolumeValue">
					<xsl:value-of select="Body/gtp:PackingDetail/gtp:TotalGrossVolume/gtp:value"/>
				</xsl:element>
				<xsl:element name="totalGrossVolumeUnitCode">
					<xsl:value-of select="Body/gtp:PackingDetail/gtp:TotalGrossVolume/gtp:volumeUnitCode"/>
				</xsl:element>
				<xsl:apply-templates select="Body/gtp:PackingDetail/gtp:Package"/>
			</xsl:element>
			
			<!--Totals-->
			<xsl:element name="Totals">
				<xsl:element name="Total">
					<xsl:element name="totalAmount">
						<xsl:value-of select="Body/Totals/TotalAmount/MultiCurrency/value"/>
					</xsl:element>
					<xsl:element name="totalCurrencyCode">
						<xsl:value-of select="Body/Totals/TotalAmount/MultiCurrency/currencyCode"/>
					</xsl:element>
				</xsl:element>
			</xsl:element>
	</xsl:template>

	
	<xsl:template match="Buyer | Shipper | Sellet | Consignee | BillTo">
		<xsl:element name="organizationName">
			<xsl:value-of select="organizationName"/>
		</xsl:element>
		<xsl:element name="organizationReference">
			<xsl:value-of select="OrganizationIdentification/organizationReference"/>
		</xsl:element>
		<xsl:element name="addressLine1">
			<xsl:value-of select="AddressInformation/FullAddress/line[position()='1']"/>
		</xsl:element>
		<xsl:element name="addressLine2">
			<xsl:value-of select="AddressInformation/FullAddress/line[position()='2']"/>
		</xsl:element>
		<xsl:element name="addressLine3">
			<xsl:value-of select="AddressInformation/FullAddress/line[position()='3']"/>
		</xsl:element>
	</xsl:template>

	<!-- Additioanl information template -->
	<xsl:template match="AdditionalInformation/line">
		<xsl:element name="line">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<!-- Product/Items template -->
	<xsl:template match="LineItemDetails/LineItem">
		<xsl:element name="Item">
			<xsl:element name="itemNumber">
				<xsl:value-of select="lineItemNumber"/>
			</xsl:element>
			<xsl:element name="productIdentification">
				<xsl:value-of select="Product/ProductIdentifiers/productIdentification"/>
			</xsl:element>
			<xsl:element name="productName">
				<xsl:value-of select="Product/productName"/>
			</xsl:element>
			<xsl:element name="purchaseOrderReference">
				<xsl:value-of select="PurchaseOrderIdentifier/documentNumber"/>
			</xsl:element>
			<xsl:element name="exportLicenseReference">
				<xsl:value-of select="ExportLicenseIdentifier/documentNumber"/>
			</xsl:element>
			<xsl:element name="baseCurrencyCode">
				<xsl:value-of select="UnitPrice/currencyCode"/>
			</xsl:element>
			<xsl:element name="basePrice">
				<xsl:value-of select="UnitPrice/value"/>
			</xsl:element>
			<xsl:element name="baseUnitOfMeasureCode">
				<xsl:value-of select="UnitPrice/unitOfMeasureCode"/>
			</xsl:element>
			<xsl:element name="itemQuantity">
				<xsl:value-of select="LineItemQuantity/value"/>
			</xsl:element>
			<xsl:element name="itemQuantityUnitOfMeasureCode">
				<xsl:value-of select="LineItemQuantity/unitOfMeasureCode"/>
			</xsl:element>
			<xsl:element name="rate">
				<xsl:value-of select="gtp:EquivalentAmount/gtp:rate"/>
			</xsl:element>
			<xsl:element name="totalPrice">
				<xsl:value-of select="gtp:EquivalentAmount/gtp:value"/>
			</xsl:element>
			<xsl:element name="totalCurrencyCode">
				<xsl:value-of select="gtp:EquivalentAmount/gtp:currencyCode"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<!-- Charges or Discounts template -->
	<xsl:template match="GeneralChargesOrDiscounts/LumpSumChargeWithDocumentIdentifier">
		<xsl:element name="GeneralChargesOrDiscounts">
			<xsl:element name="chargeType">
				<xsl:value-of select="chargeType"/>
			</xsl:element>
			<xsl:element name="chargeAmount">
				<xsl:value-of select="ChargeAmount/value"/>
			</xsl:element>
			<xsl:element name="chargeCurrencyCode">
				<xsl:value-of select="ChargeAmount/currencyCode"/>
			</xsl:element>
			<xsl:element name="rate">
				<xsl:value-of select="gtp:EquivalentAmount/gtp:rate"/>
			</xsl:element>
			<xsl:element name="chargeReportingAmount">
				<xsl:value-of select="gtp:EquivalentAmount/gtp:value"/>
			</xsl:element>
			<xsl:element name="chargeReportingCurrencyCode">
				<xsl:value-of select="gtp:EquivalentAmount/gtp:currencyCode"/>
			</xsl:element>
			<xsl:element name="chargeDescription">
				<xsl:value-of select="DocumentIdentifier/documentNumber"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<!--Packing detail / Package template -->
	<xsl:template match="gtp:PackingDetail/gtp:Package">
		<xsl:element name="Package">
			<xsl:element name="numberOfPackages">
				<xsl:value-of select="gtp:PackageCount/gtp:numberOfPackages"/>
			</xsl:element>
			<xsl:element name="typeOfPackage">
				<xsl:value-of select="gtp:PackageCount/gtp:typeOfPackage"/>
			</xsl:element>
			<xsl:element name="marksAndNumbers">
				<xsl:value-of select="gtp:marksAndNumbers"/>
			</xsl:element>
			<xsl:element name="heightValue">
				<xsl:value-of select="gtp:PackageDimensions/gtp:heightValue"/>
			</xsl:element>
			<xsl:element name="widthValue">
				<xsl:value-of select="gtp:PackageDimensions/gtp:widthValue"/>
			</xsl:element>
			<xsl:element name="lengthValue">
				<xsl:value-of select="gtp:PackageDimensions/gtp:lengthValue"/>
			</xsl:element>
			<xsl:element name="dimensionUnitCode">
				<xsl:value-of select="gtp:PackageDimensions/gtp:dimensionUnitCode"/>
			</xsl:element>
			<xsl:element name="netWeightValue">
				<xsl:value-of select="gtp:NetWeight/gtp:value"/>
			</xsl:element>
			<xsl:element name="grossWeightValue">
				<xsl:value-of select="gtp:GrossWeight/gtp:value"/>
			</xsl:element>
			<xsl:element name="weightUnitCode">
				<xsl:value-of select="gtp:NetWeight/gtp:weightUnitCode"/>
			</xsl:element>
			<xsl:element name="grossVolumeValue">
				<xsl:value-of select="gtp:GrossVolume/gtp:value"/>
			</xsl:element>
			<xsl:element name="volumeUnitCode">
				<xsl:value-of select="gtp:GrossVolume/gtp:volumeUnitCode"/>
			</xsl:element>
			<xsl:element name="productName">
				<xsl:value-of select="gtp:Content/gtp:Product/gtp:productName"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

</xsl:stylesheet>
