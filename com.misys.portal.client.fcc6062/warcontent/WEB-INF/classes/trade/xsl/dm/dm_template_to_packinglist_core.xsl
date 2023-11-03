<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
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
		<xsl:element name="PackingList">
			<!--Header: empty so far -->
			<xsl:element name="Header">
				<xsl:element name="cmp:DocumentID">
					<xsl:element name="cmp:RID"/>
					<xsl:element name="cmp:GeneralID"/>
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
					</xsl:element>
					<!--Purchase Order -->
					<xsl:element name="PurchaseOrderIdentifier">
						<xsl:element name="documentNumber">
							<xsl:value-of select="purchaseOrderReference"/>
						</xsl:element>
					</xsl:element>
					<!--Commercial invoice -->
					<xsl:element name="CommercialInvoiceIdentifier">
						<xsl:element name="documentNumber">
							<xsl:value-of select="commercialInvoiceReference"/>
						</xsl:element>
					</xsl:element>
					<xsl:element name="CountryOfOrigin">
						<xsl:element name="countryName">
							<xsl:value-of select="CountryOfOrigin/countryName"/>
						</xsl:element>
					</xsl:element>
					<xsl:element name="CountryOfDestination">
						<xsl:element name="countryName">
							<xsl:value-of select="CountryOfDestination/countryName"/>
						</xsl:element>
					</xsl:element>
					<!--GTP : Documentary credit: Issuing bank ref -->
					<xsl:element name="gtp:DocumentaryCreditIdentifier">
						<xsl:element name="gtp:documentNumber">
							<xsl:value-of select="documentaryCreditReference"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>
					
					
				<!--Parties -->
				<xsl:element name="Parties">
					<!--IssuingParty is mandatory -->
					<xsl:element name="IssuingParty">
						<xsl:apply-templates select="Shipper"/>
					</xsl:element>
					<!--Other are optionals -->
					<xsl:element name="Buyer">
						<xsl:apply-templates select="Buyer"/>
					</xsl:element>
					<xsl:element name="Seller">
						<xsl:apply-templates select="Shipper"/>
					</xsl:element>
					<xsl:element name="Consignee">
						<xsl:apply-templates select="Consignee"/>
					</xsl:element>
				</xsl:element>
				
				<!--TermsAndConditions-->
				<xsl:element name="TermsAndConditions">
					<xsl:copy-of select="TermsAndConditions/*"/>
				</xsl:element>
				
				<!--RoutingSummary-->
				<xsl:element name="RoutingSummary">
					<xsl:apply-templates select="RoutingSummary"/>
				</xsl:element>
				
				<!--Consignment-->
				<xsl:element name="Consignment">
					<xsl:element name="ConsignmentDetail">
						<xsl:apply-templates select="LineItemDetails/Item"/>
					</xsl:element>
				</xsl:element>
				
				<!--PackingDetail-->
				<xsl:element name="PackingDetail">
				
					<xsl:element name="TotalNetWeight">
						<xsl:element name="value">
							<xsl:value-of select="PackingDetail/totalNetWeightValue"/>
						</xsl:element>
						<xsl:element name="weightUnitCode">
							<xsl:value-of select="PackingDetail/totalNetWeightUnitCode"/>
						</xsl:element>
					</xsl:element>
					
					<xsl:element name="TotalGrossWeight">
						<xsl:element name="value">
							<xsl:value-of select="PackingDetail/totalGrossWeightValue"/>
						</xsl:element>
						<xsl:element name="weightUnitCode">
							<xsl:value-of select="PackingDetail/totalNetWeightUnitCode"/>
						</xsl:element>
					</xsl:element>
					
					<xsl:element name="TotalNetVolume">
						<xsl:element name="value">
							<xsl:value-of select="PackingDetail/totalNetVolumeValue"/>
						</xsl:element>
						<xsl:element name="volumeUnitCode">
							<xsl:value-of select="PackingDetail/totalNetVolumeUnitCode"/>
						</xsl:element>
					</xsl:element>
					
					<xsl:element name="TotalGrossVolume">
						<xsl:element name="value">
							<xsl:value-of select="PackingDetail/totalGrossVolumeValue"/>
						</xsl:element>
						<xsl:element name="volumeUnitCode">
							<xsl:value-of select="PackingDetail/totalGrossVolumeUnitCode"/>
						</xsl:element>
					</xsl:element>
					
					<xsl:apply-templates select="PackingDetail/Package"/>
				</xsl:element>
				
				<!--Additional information-->
				<xsl:element name="AdditionalInformation">
					<xsl:copy-of select="AdditionalInformation/line"/>
				</xsl:element>
				
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	
	<!-- Parties template -->
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
		<!-- No transport service in DTD
		<xsl:element name="transportService">
			<xsl:value-of select="transportService"/>
		</xsl:element> -->
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
			<xsl:otherwise>
			</xsl:otherwise>
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
	
	<!--Consignment template (based on common structureLineItem: DO NOT MIX WITH COMMERCIAL INVOICE STYLESHEET) -->
	<xsl:template match="LineItemDetails/Item">
		<xsl:element name="Commodity">
			<xsl:element name="CommodityDescription">
				<xsl:element name="line">
					<xsl:value-of select="productName"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	<!--Packing detail / Package template -->
	<xsl:template match="PackingDetail/Package">
		<xsl:element name="Package">
			<xsl:element name="PackageCount">
				<xsl:element name="numberOfPackages">
					<xsl:value-of select="numberOfPackages"/>
				</xsl:element>
				<xsl:element name="typeOfPackage">
					<xsl:value-of select="typeOfPackage"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="marksAndNumbers">
				<xsl:value-of select="marksAndNumbers"/>
			</xsl:element>
			<xsl:element name="PackageDimensions">
				<xsl:element name="heightValue">
					<xsl:value-of select="heightValue"/>
				</xsl:element>
				<xsl:element name="widthValue">
					<xsl:value-of select="widthValue"/>
				</xsl:element>
				<xsl:element name="lengthValue">
					<xsl:value-of select="lengthValue"/>
				</xsl:element>
				<xsl:element name="dimensionUnitCode">
					<xsl:value-of select="dimensionUnitCode"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="NetWeight">
				<xsl:element name="value">
					<xsl:value-of select="netWeightValue"/>
				</xsl:element>
				<xsl:element name="weightUnitCode">
					<xsl:value-of select="weightUnitCode"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="GrossWeight">
				<xsl:element name="value">
					<xsl:value-of select="grossWeightValue"/>
				</xsl:element>
				<xsl:element name="weightUnitCode">
					<xsl:value-of select="weightUnitCode"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="GrossVolume">
				<xsl:element name="value">
					<xsl:value-of select="grossVolumeValue"/>
				</xsl:element>
				<xsl:element name="volumeUnitCode">
					<xsl:value-of select="volumeUnitCode"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="Content">
				<xsl:element name="Product">
					<xsl:element name="productName">
						<xsl:value-of select="productName"/>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	

</xsl:stylesheet>
