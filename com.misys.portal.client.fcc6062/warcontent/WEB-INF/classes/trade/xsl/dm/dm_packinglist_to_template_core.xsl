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
			<xsl:apply-templates select="document/PackingList"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="document/PackingList">

			<!--
			<xsl:element name="exportDocumentaryCreditReference">
				<xsl:value-of select="advising_bank_reference"/>
			</xsl:element>
			<xsl:element name="exporterReference">
				<xsl:value-of select="exporter_reference"/>
			</xsl:element>
			-->
			<xsl:element name="commercialInvoiceReference">
				<xsl:value-of select="Body/GeneralInformation/CommercialInvoiceIdentifier/documentNumber"/>
			</xsl:element>
			<xsl:element name="purchaseOrderReference">
				<xsl:value-of select="Body/GeneralInformation/PurchaseOrderIdentifier/documentNumber"/>
			</xsl:element>
			<xsl:element name="CountryOfOrigin">
				<xsl:element name="countryName">
					<xsl:value-of select="Body/GeneralInformation/CountryOfOrigin/countryName"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="CountryOfDestination">
				<xsl:element name="countryName">
					<xsl:value-of select="Body/GeneralInformation/CountryOfDestination/countryName"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="documentaryCreditReference">
				<xsl:value-of select="Body/GeneralInformation/gtp:DocumentaryCreditIdentifier/gtp:documentNumber"/>
			</xsl:element>
			
			<!--Parties-->
			<xsl:element name="Buyer">
				<xsl:apply-templates select="Body/Parties/Buyer"/>
			</xsl:element>
			<xsl:element name="Shipper">
				<xsl:apply-templates select="Body/Parties/IssuingParty"/>
			</xsl:element>
			<xsl:element name="Consignee">
				<xsl:apply-templates select="Body/Parties/Consignee"/>
			</xsl:element>
			
			<!--TermsAndConditions-->
			<xsl:element name="TermsAndConditions">
				<xsl:copy-of select="Body/TermsAndConditions/*"/>
			</xsl:element>
				
			<!--RoutingSummary-->
			<xsl:element name="RoutingSummary">
				<!-- No transport service in Packing list -->
				<xsl:element name="transportService"/>
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
				<xsl:apply-templates select="Body/Consignment/ConsignmentDetail/Commodity/CommodityDescription"/>
			</xsl:element>
				
			<!--Additional information-->
			<xsl:element name="AdditionalInformation">
				<xsl:apply-templates select="Body/AdditionalInformation/line"/>
			</xsl:element>
				
			<!--PAcking details-->
			<xsl:element name="PackingDetail">
				<xsl:element name="totalNetWeightValue">
					<xsl:value-of select="Body/PackingDetail/TotalNetWeight/value"/>
				</xsl:element>
				<xsl:element name="totalNetWeightUnitCode">
					<xsl:value-of select="Body/PackingDetail/TotalNetWeight/weightUnitCode"/>
				</xsl:element>
				<xsl:element name="totalGrossWeightValue">
					<xsl:value-of select="Body/PackingDetail/TotalGrossWeight/value"/>
				</xsl:element>
				<xsl:element name="totalGrossWeightUnitCode">
					<xsl:value-of select="Body/PackingDetail/TotalGrossWeight/weightUnitCode"/>
				</xsl:element>
				<xsl:element name="totalNetVolumeValue">
					<xsl:value-of select="Body/PackingDetail/TotalNetVolume/value"/>
				</xsl:element>
				<xsl:element name="totalNetVolumeUnitCode">
					<xsl:value-of select="Body/PackingDetail/TotalNetVolume/volumeUnitCode"/>
				</xsl:element>
				<xsl:element name="totalGrossVolumeValue">
					<xsl:value-of select="Body/PackingDetail/TotalGrossVolume/value"/>
				</xsl:element>
				<xsl:element name="totalGrossVolumeUnitCode">
					<xsl:value-of select="Body/PackingDetail/TotalGrossVolume/volumeUnitCode"/>
				</xsl:element>
				<xsl:apply-templates select="Body/PackingDetail/Package"/>
			</xsl:element>
			
	</xsl:template>

	
	<xsl:template match="Buyer | Shipper | Consignee | IssuingParty">
		<xsl:element name="organizationName">
			<xsl:value-of select="organizationName"/>
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
		<xsl:element name="organizationReference">
			<xsl:value-of select="OrganizationIdentification/organizationReference"/>
		</xsl:element>
	</xsl:template>

	<!-- Additioanl information template -->
	<xsl:template match="AdditionalInformation/line">
		<xsl:element name="line">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<!-- Product/Consignment template -->
	<xsl:template match="Consignment/ConsignmentDetail/Commodity/CommodityDescription">
		<xsl:element name="Item">
			<xsl:element name="itemNumber">
				<xsl:value-of select="position()"/>
			</xsl:element>
			<xsl:element name="productName">
				<xsl:value-of select="line[position()='1']"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<!--Packing detail / Package template -->
	<xsl:template match="PackingDetail/Package">
		<xsl:element name="Package">
			<xsl:element name="numberOfPackages">
				<xsl:value-of select="PackageCount/numberOfPackages"/>
			</xsl:element>
			<xsl:element name="typeOfPackage">
				<xsl:value-of select="PackageCount/typeOfPackage"/>
			</xsl:element>
			<xsl:element name="marksAndNumbers">
				<xsl:value-of select="marksAndNumbers"/>
			</xsl:element>
			<xsl:element name="heightValue">
				<xsl:value-of select="PackageDimensions/heightValue"/>
			</xsl:element>
			<xsl:element name="widthValue">
				<xsl:value-of select="PackageDimensions/widthValue"/>
			</xsl:element>
			<xsl:element name="lengthValue">
				<xsl:value-of select="PackageDimensions/lengthValue"/>
			</xsl:element>
			<xsl:element name="dimensionUnitCode">
				<xsl:value-of select="PackageDimensions/dimensionUnitCode"/>
			</xsl:element>
			<xsl:element name="netWeightValue">
				<xsl:value-of select="NetWeight/value"/>
			</xsl:element>
			<xsl:element name="grossWeightValue">
				<xsl:value-of select="GrossWeight/value"/>
			</xsl:element>
			<xsl:element name="weightUnitCode">
				<xsl:value-of select="NetWeight/weightUnitCode"/>
			</xsl:element>
			<xsl:element name="grossVolumeValue">
				<xsl:value-of select="GrossVolume/value"/>
			</xsl:element>
			<xsl:element name="volumeUnitCode">
				<xsl:value-of select="GrossVolume/volumeUnitCode"/>
			</xsl:element>
			<xsl:element name="productName">
				<xsl:value-of select="Content/Product/productName"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

</xsl:stylesheet>
