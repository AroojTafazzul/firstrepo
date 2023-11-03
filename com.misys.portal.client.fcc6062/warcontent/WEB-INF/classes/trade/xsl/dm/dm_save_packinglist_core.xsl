<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:encryption="xalan://com.misys.portal.common.security.sso.Cypher" exclude-result-prefixes="encryption converttools">
	<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>
	<xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process Document Preparation-->
	<xsl:template match="document_tnx_record">
		<result>
			<com.misys.portal.product.dm.common.DocumentInstance>
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
				<xsl:attribute name="document_id"><xsl:value-of select="document_id"/></xsl:attribute>

				<brch_code>
					<xsl:value-of select="brch_code"/>
				</brch_code>
				<company_id>
					<xsl:value-of select="company_id"/>
				</company_id>
				<description>
					<xsl:value-of select="description"/>
				</description>
				<code>
					<xsl:value-of select="code"/>
				</code>
				<title>
					<xsl:value-of select="title"/>
				</title>
				<type>
					<xsl:value-of select="type"/>
				</type>
				<xsl:if test="from_template">
					<additional_field name="from_template" type="string" scope="none">
						<xsl:value-of select="from_template"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="from_document_id">
					<additional_field name="from_document_id" type="string" scope="none">
						<xsl:value-of select="from_document_id"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="from_version">
					<additional_field name="from_version" type="string" scope="none">
						<xsl:value-of select="from_version"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="from_folder">
					<additional_field name="from_folder" type="string" scope="none">
						<xsl:value-of select="from_folder"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="attached">
					<additional_field name="attached" type="string" scope="none">
						<xsl:value-of select="attached"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="deleted">
					<additional_field name="deleted" type="string" scope="none">
						<xsl:value-of select="deleted"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="file_name">
					<additional_field name="file_name" type="string" scope="none">
						<xsl:value-of select="file_name"/>
					</additional_field>
				</xsl:if>
				<format>
					<xsl:value-of select="format"/>
				</format>
				<version>
					<xsl:value-of select="version"/>
				</version>
				<cust_ref_id>
					<xsl:value-of select="cust_ref_id"/>
				</cust_ref_id>
				<prep_date>
					<xsl:value-of select="prep_date"/>
				</prep_date>
				<!-- Template data -->
				<!-- The following test make sure the data is generated only for document generation (and not upload) -->
				<!-- The total_currency existence cjecking also makes sure the data element won't be created at control time -->
				<xsl:if test="type[.='01']">
					<!-- Full document preparation folder -->
					<!-- The data is stored as text. We therefore need to convert all amounts and dates - received in user locale - to a standard default format for future use -->
					<xsl:element name="data">
						<xsl:element name="PackingList" xmlns:gtp="http://www.neomalogic.com" xmlns:cmp="http://www.bolero.net">
							<!--Header: empty so far -->
							<xsl:element name="Header">
								<xsl:element name="cmp:DocumentID">
									<xsl:element name="cmp:RID">
										<xsl:value-of select="cust_ref_id"/>
									</xsl:element>
									<xsl:element name="cmp:GeneralID">
										<xsl:value-of select="cust_ref_id"/>
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
										<xsl:if test="prep_date[.!='']">
											<!-- As already explained, the data is stored as text. We therefore need to convert all amounts and dates 
											 received in user locale to a standard default format for future use -->
											<xsl:variable name="date">
												<xsl:value-of select="prep_date"/>
											</xsl:variable>
											<xsl:value-of select="converttools:getDefaultTimestampRepresentation($date,$language)"/>
										</xsl:if>
									</xsl:element>
									<xsl:element name="PlaceOfIssue">
										<xsl:element name="locationName">
											<xsl:value-of select="country_of_origin"/>
										</xsl:element>
									</xsl:element>
									<!--Purchase Order -->
									<xsl:element name="PurchaseOrderIdentifier">
										<xsl:element name="documentNumber">
											<xsl:value-of select="purchase_order_identifier"/>
										</xsl:element>
									</xsl:element>
									<!--Commercial invoice -->
									<xsl:element name="CommercialInvoiceIdentifier">
										<xsl:element name="documentNumber">
											<xsl:value-of select="comercial_invoice_identifier"/>
										</xsl:element>
									</xsl:element>
									<xsl:element name="CountryOfOrigin">
										<xsl:element name="countryName">
											<xsl:value-of select="country_of_origin"/>
										</xsl:element>
									</xsl:element>
									<xsl:element name="CountryOfDestination">
										<xsl:element name="countryName">
											<xsl:value-of select="country_of_destination"/>
										</xsl:element>
									</xsl:element>
									<!--Documentary credit: Issuing bank ref -->
									<xsl:element name="gtp:DocumentaryCreditIdentifier">
										<xsl:element name="gtp:documentNumber">
											<xsl:value-of select="issuing_bank_reference"/>
										</xsl:element>
									</xsl:element>
								</xsl:element>
								<!--Parties -->
								<xsl:element name="Parties">
									<xsl:element name="IssuingParty">
										<xsl:element name="organizationName">
											<xsl:value-of select="issuing_party_name"/>
										</xsl:element>
										<xsl:element name="OrganizationIdentification">
											<xsl:element name="organizationReference">
												<xsl:value-of select="issuing_party_reference"/>
											</xsl:element>
										</xsl:element>
										<xsl:element name="AddressInformation">
											<xsl:element name="FullAddress">
												<xsl:element name="line">
													<xsl:value-of select="issuing_party_address_line_1"/>
												</xsl:element>
												<xsl:element name="line">
													<xsl:value-of select="issuing_party_address_line_2"/>
												</xsl:element>
												<xsl:element name="line">
													<xsl:value-of select="issuing_party_dom"/>
												</xsl:element>
											</xsl:element>
										</xsl:element>
									</xsl:element>
									<xsl:element name="Buyer">
										<xsl:element name="organizationName">
											<xsl:value-of select="buyer_name"/>
										</xsl:element>
										<xsl:element name="OrganizationIdentification">
											<xsl:element name="organizationReference">
												<xsl:value-of select="buyer_reference"/>
											</xsl:element>
										</xsl:element>
										<xsl:element name="AddressInformation">
											<xsl:element name="FullAddress">
												<xsl:element name="line">
													<xsl:value-of select="buyer_address_line_1"/>
												</xsl:element>
												<xsl:element name="line">
													<xsl:value-of select="buyer_address_line_2"/>
												</xsl:element>
												<xsl:element name="line">
													<xsl:value-of select="buyer_dom"/>
												</xsl:element>
											</xsl:element>
										</xsl:element>
									</xsl:element>
									<xsl:element name="Seller">
										<xsl:element name="organizationName">
											<xsl:value-of select="seller_name"/>
										</xsl:element>
										<xsl:element name="OrganizationIdentification">
											<xsl:element name="organizationReference">
												<xsl:value-of select="seller_reference"/>
											</xsl:element>
										</xsl:element>
										<xsl:element name="AddressInformation">
											<xsl:element name="FullAddress">
												<xsl:element name="line">
													<xsl:value-of select="seller_address_line_1"/>
												</xsl:element>
												<xsl:element name="line">
													<xsl:value-of select="seller_address_line_2"/>
												</xsl:element>
												<xsl:element name="line">
													<xsl:value-of select="seller_dom"/>
												</xsl:element>
											</xsl:element>
										</xsl:element>
									</xsl:element>
									<xsl:element name="Consignee">
										<xsl:element name="organizationName">
											<xsl:value-of select="consignee_name"/>
										</xsl:element>
										<xsl:element name="OrganizationIdentification">
											<xsl:element name="organizationReference">
												<xsl:value-of select="consignee_reference"/>
											</xsl:element>
										</xsl:element>
										<xsl:element name="AddressInformation">
											<xsl:element name="FullAddress">
												<xsl:element name="line">
													<xsl:value-of select="consignee_address_line_1"/>
												</xsl:element>
												<xsl:element name="line">
													<xsl:value-of select="consignee_address_line_2"/>
												</xsl:element>
												<xsl:element name="line">
													<xsl:value-of select="consignee_dom"/>
												</xsl:element>
											</xsl:element>
										</xsl:element>
									</xsl:element>
								</xsl:element>
								<!--*****************-->
								<!-- Term details -->
								<!--*****************-->
								<xsl:element name="TermsAndConditions">
									<xsl:call-template name="TERM_DETAILS"/>
								</xsl:element>
								<!--RoutingSummary-->
								<xsl:element name="RoutingSummary">
									<!-- No transport service in DTD 
									<xsl:element name="gtp:transportService">
										<xsl:value-of select="transport_service"/>
									</xsl:element>
									-->
									<xsl:choose>
										<xsl:when test="transport_type[.='MARITIME' or .='INLANDWATER']">
											<xsl:element name="MeansOfTransport">
												<xsl:element name="SeaTransportIdentification">
													<xsl:element name="Vessel">
														<xsl:element name="vesselName">
															<xsl:value-of select="vessel_name"/>
														</xsl:element>
													</xsl:element>
													<xsl:element name="VoyageDetail">
														<xsl:element name="voyageNumber">
															<xsl:value-of select="transport_reference"/>
														</xsl:element>
														<xsl:element name="departureDate">
															<xsl:if test="departure_date[.!='']">
																<!-- As already explained, the data is stored 	as text. We therefore need to convert all amounts and dates 
																 received in user locale to a standard default format for future use -->
																<xsl:variable name="date">
																	<xsl:value-of select="departure_date"/>
																</xsl:variable>
																<xsl:value-of select="converttools:getDefaultTimestampRepresentation($date,$language)"/>
															</xsl:if>
														</xsl:element>
													</xsl:element>
												</xsl:element>
											</xsl:element>
										</xsl:when>
										<xsl:when test="transport_type[.='AIR']">
											<xsl:element name="MeansOfTransport">
												<xsl:element name="FlightDetails">
													<xsl:element name="flightNumber">
														<xsl:value-of select="transport_reference"/>
													</xsl:element>
													<xsl:element name="departureDate">
														<xsl:if test="departure_date[.!='']">
															<!-- As already explained, the data is stored 	as text. We therefore need to convert all amounts and dates 
															 received in user locale to a standard default format for future use -->
															<xsl:variable name="date">
																<xsl:value-of select="departure_date"/>
															</xsl:variable>
															<xsl:value-of select="converttools:getDefaultTimestampRepresentation($date,$language)"/>
														</xsl:if>
													</xsl:element>
												</xsl:element>
											</xsl:element>
										</xsl:when>
										<xsl:when test="transport_type[.='ROAD']">
											<xsl:element name="MeansOfTransport">
												<xsl:element name="RoadTransportIdentification">
													<xsl:element name="licencePlateIdentification">
														<xsl:value-of select="transport_reference"/>
													</xsl:element>
												</xsl:element>
											</xsl:element>
										</xsl:when>
										<xsl:when test="transport_type[.='RAIL']">
											<xsl:element name="MeansOfTransport">
												<xsl:element name="RailTransportIdentification">
													<xsl:element name="locomotiveNumber">
														<xsl:value-of select="transport_reference"/>
													</xsl:element>
													<xsl:element name="railCarNumber"/>
												</xsl:element>
											</xsl:element>
										</xsl:when>
										<xsl:otherwise/>
									</xsl:choose>
									<xsl:element name="PlaceOfLoading">
										<xsl:element name="locationName">
											<xsl:value-of select="place_of_loading"/>
										</xsl:element>
									</xsl:element>
									<xsl:element name="PlaceOfDischarge">
										<xsl:element name="locationName">
											<xsl:value-of select="place_of_discharge"/>
										</xsl:element>
									</xsl:element>
									<xsl:element name="PlaceOfDelivery">
										<xsl:element name="locationName">
											<xsl:value-of select="place_of_delivery"/>
										</xsl:element>
									</xsl:element>
								</xsl:element>
								<!--*****************-->
								<!-- Product details -->
								<!--*****************-->
								<xsl:element name="Consignment">
									<xsl:element name="ConsignmentDetail">
										<xsl:call-template name="PRODUCT_SIMPLE"/>
									</xsl:element>
								</xsl:element>
								<!--*****************-->
								<!-- Packing details -->
								<!--*****************-->
								<xsl:element name="PackingDetail">
									<xsl:element name="TotalNetWeight">
										<xsl:element name="value">
											<!--
											<xsl:value-of select="total_net_weight"/>
											-->
											<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(total_net_weight, $language)"/>
										</xsl:element>
										<xsl:element name="weightUnitCode">
											<xsl:value-of select="total_net_weight_unit"/>
										</xsl:element>
									</xsl:element>
									<xsl:element name="TotalGrossWeight">
										<xsl:element name="value">
											<!--
											<xsl:value-of select="total_gross_weight"/>
											-->
											<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(total_gross_weight, $language)"/>
										</xsl:element>
										<xsl:element name="weightUnitCode">
											<xsl:value-of select="total_gross_weight_unit"/>
										</xsl:element>
									</xsl:element>
									<xsl:element name="TotalNetVolume">
										<xsl:element name="value">
											<!--
											<xsl:value-of select="total_net_volume"/>
											-->
											<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(total_net_volume, $language)"/>
										</xsl:element>
										<xsl:element name="volumeUnitCode">
											<xsl:value-of select="total_net_volume_unit"/>
										</xsl:element>
									</xsl:element>
									<xsl:element name="TotalGrossVolume">
										<xsl:element name="value">
											<!--
											<xsl:value-of select="total_gross_volume"/>
											-->
											<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(total_gross_volume, $language)"/>
										</xsl:element>
										<xsl:element name="volumeUnitCode">
											<xsl:value-of select="total_gross_volume_unit"/>
										</xsl:element>
									</xsl:element>
									<xsl:call-template name="PACKING_DETAILS"/>
								</xsl:element>
								<!--*****************-->
								<!--Additional Information-->
								<!--*****************-->
								<xsl:element name="AdditionalInformation">
									<xsl:element name="line">
										<xsl:value-of select="additionnal_information"/>
									</xsl:element>
								</xsl:element>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:if>
			</com.misys.portal.product.dm.common.DocumentInstance>
		</result>
	</xsl:template>
	<!--**************************-->
	<!-- Product details template -->
	<!--**************************-->
	<xsl:template name="PRODUCT_SIMPLE" xmlns:gtp="http://www.neomalogic.com" xmlns:cmp="http://www.bolero.net">
		<xsl:for-each select="//*[starts-with(name(), 'product_details_position_')]">
			<xsl:variable name="position">
				<xsl:value-of select="substring-after(name(), 'product_details_position_')"/>
			</xsl:variable>
			<xsl:element name="Commodity">
				<xsl:element name="CommodityDescription">
					<xsl:element name="line">
						<xsl:value-of select="//*[starts-with(name(), concat('product_details_product_description_', $position))]"/>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<!--***********************-->
	<!-- Term details template -->
	<!--***********************-->
	<xsl:template name="TERM_DETAILS">
		<xsl:for-each select="//*[starts-with(name(), 'term_details_position_')]">
			<xsl:variable name="position">
				<xsl:value-of select="substring-after(name(), 'term_details_position_')"/>
			</xsl:variable>
			<xsl:element name="clause">
				<xsl:value-of select="//*[starts-with(name(), concat('term_details_term_clause_', $position))]"/>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<!--**************************-->
	<!-- Packing details template -->
	<!--**************************-->
	<xsl:template name="PACKING_DETAILS" xmlns:gtp="http://www.neomalogic.com" xmlns:cmp="http://www.bolero.net">
		<xsl:for-each select="//*[starts-with(name(), 'packing_details_position_')]">
			<xsl:variable name="position">
				<xsl:value-of select="substring-after(name(), 'packing_details_position_')"/>
			</xsl:variable>
			<xsl:element name="Package">
				<xsl:element name="PackageCount">
					<xsl:element name="numberOfPackages">
						<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(//*[starts-with(name(), concat('packing_details_package_number_', $position))], $language)"/>
						<!--
						<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_number_', $position))]"/>
						-->
					</xsl:element>
					<xsl:element name="typeOfPackage">
						<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_type_', $position))]"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="marksAndNumbers">
					<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_marks_', $position))]"/>
				</xsl:element>
				<xsl:element name="PackageDimensions">
					<xsl:element name="heightValue">
						<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(//*[starts-with(name(), concat('packing_details_package_height_', $position))], $language)"/>
						<!--
						<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_height_', $position))]"/>
						-->
					</xsl:element>
					<xsl:element name="widthValue">
						<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(//*[starts-with(name(), concat('packing_details_package_width_', $position))], $language)"/>
						<!--
						<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_width_', $position))]"/>
						-->
					</xsl:element>
					<xsl:element name="lengthValue">
						<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(//*[starts-with(name(), concat('packing_details_package_length_', $position))], $language)"/>
						<!--
						<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_length_', $position))]"/>
						-->
					</xsl:element>
					<xsl:element name="dimensionUnitCode">
						<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_dimension_unit_', $position))]"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="NetWeight">
					<xsl:element name="value">
						<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(//*[starts-with(name(), concat('packing_details_package_netweight_', $position))], $language)"/>
						<!--
						<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_netweight_', $position))]"/>
						-->
					</xsl:element>
					<xsl:element name="weightUnitCode">
						<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_weight_unit_', $position))]"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="GrossWeight">
					<xsl:element name="value">
						<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(//*[starts-with(name(), concat('packing_details_package_grossweight_', $position))], $language)"/>
						<!--
						<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_grossweight_', $position))]"/>
						-->
					</xsl:element>
					<xsl:element name="weightUnitCode">
						<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_weight_unit_', $position))]"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="GrossVolume">
					<xsl:element name="value">
						<xsl:value-of select="converttools:getDefaultBigDecimalRepresentation(//*[starts-with(name(), concat('packing_details_package_grossvolume_', $position))], $language)"/>
						<!--
						<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_grossvolume_', $position))]"/>
						-->
					</xsl:element>
					<xsl:element name="volumeUnitCode">
						<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_volume_unit_', $position))]"/>
					</xsl:element>
				</xsl:element>
				<xsl:element name="Content">
					<xsl:element name="Product">
						<xsl:element name="productName">
							<xsl:value-of select="//*[starts-with(name(), concat('packing_details_package_description_', $position))]"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
