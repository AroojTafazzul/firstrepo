<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:cmp="http://www.bolero.net" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:gtp="http://www.neomalogic.com" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	
	<xsl:param name="logo_url"/>
	<xsl:param name="isDraft" select="'Y'"/>
	<xsl:template match="CertificateOfOrigin">

		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master margin-bottom="10pt" margin-left="30pt" margin-right="30pt" master-name="last-page" page-height="841.9pt" page-width="595.3pt">
					<fo:region-before extent="30pt"/>
					<fo:region-after extent="60pt" region-name="last-page-after"/>
					<fo:region-body margin-bottom="30pt" margin-top="30pt"/>
				</fo:simple-page-master>
				<fo:simple-page-master margin-bottom="10pt" margin-left="30pt" margin-right="30pt" master-name="all-pages" page-height="841.9pt" page-width="595.3pt">
					<fo:region-before extent="30pt"/>
					<fo:region-after extent="90pt" region-name="all-pages-after"/>
					<fo:region-body margin-bottom="30pt" margin-top="30pt"/>
				</fo:simple-page-master>
				<fo:page-sequence-master master-reference="Section1-ps">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference master-reference="all-pages" page-position="first"/>
						<fo:conditional-page-master-reference master-reference="last-page" page-position="last"/>
						<fo:conditional-page-master-reference master-reference="all-pages" page-position="rest"/>
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>
			<fo:page-sequence master-name="Section1-ps">
				<!-- HEADER-->
				
				<!-- FOOTER for all pages-->
				
				<!-- FOOTER for lats page : additional legal informations-->
				
				<!-- BODY-->
				
			<xsl:call-template name="header"/>
        <xsl:call-template name="footer"/>
        <xsl:call-template name="body"/>
      </fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!-- Basic template that output the result in a block element -->
	<xsl:template match="AdditionalInformation/line">
		<fo:block text-indent="5pt">
			<xsl:value-of select="."/>
			<xsl:text/>
		</fo:block>
	</xsl:template>
	
	<!-- Goods template-->
	<xsl:template match="Body/ConsignmentDetail/Product">
		<fo:block text-indent="5pt">
			<xsl:if test="ProductIdentifiers/productIdentification[.!=''] or productName[.!='']">
				<xsl:value-of select="position()"/>
				<xsl:text>. </xsl:text>
			</xsl:if>
			<xsl:if test="ProductIdentifiers/productIdentification[.!='']">
				<xsl:value-of select="ProductIdentifiers/productIdentification"/>
				<xsl:if test="productName[.!='']">
					<xsl:text> - </xsl:text>
				</xsl:if>
			</xsl:if>
			<xsl:value-of select="productName"/>
			<xsl:if test="ProductQuantity/value[.!='']">
				<xsl:text> (Qty: </xsl:text>
				<xsl:value-of select="ProductQuantity/value"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="ProductQuantity/unitOfMeasureCode"/>
				<xsl:text>)</xsl:text>
			</xsl:if>
			<xsl:text/>
		</fo:block>
	</xsl:template>

	<!--Packing description-->
	<xsl:template match="Body/gtp:PackingDetail/gtp:Package">
		<fo:table-row>
			<fo:table-cell>
				<fo:block text-align="center">
					<xsl:value-of select="gtp:marksAndNumbers"/>
					<xsl:text/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block text-indent="5pt">
					<xsl:value-of select="gtp:PackageCount/gtp:numberOfPackages"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="gtp:PackageCount/gtp:typeOfPackage"/>
					<xsl:if test="gtp:Content/gtp:Product/gtp:productName[.!='']">
						<xsl:text> - </xsl:text>
						<xsl:value-of select="gtp:Content/gtp:Product/gtp:productName"/>
					</xsl:if>
					<xsl:text/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block text-align="center">
					<xsl:if test="gtp:GrossWeight/gtp:value[.!='']">
						<xsl:value-of select="gtp:GrossWeight/gtp:value"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="gtp:GrossWeight/gtp:weightUnitCode"/>
					</xsl:if>
					<xsl:text/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block text-align="center">
					<xsl:if test="gtp:PackageDimensions/gtp:heightValue[.!='']">
						<xsl:value-of select="gtp:PackageDimensions/gtp:heightValue"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="gtp:PackageDimensions/gtp:dimensionUnitCode"/>
						<xsl:if test="gtp:PackageDimensions/gtp:widthValue[.!=''] or gtp:PackageDimensions/gtp:lengthValue[.!='']">
							<xsl:text> x </xsl:text>
						</xsl:if>
					</xsl:if>
					<xsl:if test="gtp:PackageDimensions/gtp:widthValue[.!='']">
						<xsl:value-of select="gtp:PackageDimensions/gtp:widthValue"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="gtp:PackageDimensions/gtp:dimensionUnitCode"/>
						<xsl:if test="gtp:PackageDimensions/gtp:lengthValue[.!='']">
							<xsl:text> x </xsl:text>
						</xsl:if>
					</xsl:if>
					<xsl:if test="gtp:PackageDimensions/gtp:lengthValue[.!='']">
						<xsl:value-of select="gtp:PackageDimensions/gtp:lengthValue"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="gtp:PackageDimensions/gtp:dimensionUnitCode"/>
					</xsl:if>
					<xsl:text/>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
	
<xsl:template name="header">
    <fo:static-content flow-name="xsl-region-before">
				</fo:static-content>
  </xsl:template>
  <xsl:template name="body">
    <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="11.0pt">
					<!-- Buyer plus title-->
					<fo:table>
						<!-- Initial splitting in a single row of two collumns -->
						<fo:table-column border-color="black" border-style="solid" border-width="0.5pt" column-width="266pt"/>
						<fo:table-column column-width="266pt"/>
						<fo:table-body>
							<fo:table-row>
								<!-- Issuing Party data -->
								<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="62.5pt">
									<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Certificate Issued By</fo:block>
									<fo:block text-indent="30pt">
										<xsl:value-of select="Body/Parties/IssuingParty/organizationName"/>
									</fo:block>
									<fo:block text-indent="30pt">
										<xsl:value-of select="Body/Parties/IssuingParty/AddressInformation/FullAddress/line[position()='1']"/>
									</fo:block>
									<fo:block text-indent="30pt">
										<xsl:value-of select="Body/Parties/IssuingParty/AddressInformation/FullAddress/line[position()='2']"/>
									</fo:block>
									<fo:block text-indent="30pt">
										<xsl:value-of select="Body/Parties/IssuingParty/AddressInformation/FullAddress/line[position()='3']"/>
									</fo:block>
								</fo:table-cell>
								<!-- Document header -->
								<fo:table-cell display-align="center" font-size="14pt" font-weight="bold">
									<fo:block text-align="center">Certificate Of Origin</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
					<!-- General details table-->
					<fo:table border-color="black" border-style="solid" border-width="0.5pt">
						<!-- Initial splitting in a single row of two collumns -->
						<fo:table-column column-width="266pt"/>
						<!-- Specific border definition in oder to double the last cell border-->
						<fo:table-column column-width="266pt"/>
						<fo:table-body>
							<fo:table-row>
								<!-- Left collumn -->
								<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt">
									<fo:block>
										<fo:table>
											<fo:table-column column-width="266pt"/>
											<fo:table-body>
												<!-- Exporter data -->
												<fo:table-row>
													<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="62.5pt">
														<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Exporter</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="Body/Parties/Shipper/organizationName"/>
														</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="Body/Parties/Shipper/AddressInformation/FullAddress/line[position()='1']"/>
														</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="Body/Parties/Shipper/AddressInformation/FullAddress/line[position()='2']"/>
														</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="Body/Parties/Shipper/AddressInformation/FullAddress/line[position()='3']"/>
														</fo:block>
													</fo:table-cell>
												</fo:table-row>
												<!-- Consignee data -->
												<fo:table-row>
													<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="62.5pt">
														<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Consignee</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="Body/Parties/Consignee/organizationName"/>
														</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='1']"/>
														</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='2']"/>
														</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='3']"/>
														</fo:block>
													</fo:table-cell>
												</fo:table-row>
												<fo:table-row>
													<fo:table-cell>
														<fo:block>
															<fo:table>
																<!-- Splitting in two collumns -->
																<fo:table-column column-width="133pt"/>
																<fo:table-column column-width="133pt"/>
																<fo:table-body>
																	<fo:table-row>
																		<!-- Left collumn: Departure date -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Departure Date</fo:block>
																			<xsl:if test="Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification">
																				<fo:block text-align="center">
																					<xsl:value-of select="Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/VoyageDetail/departureDate"/>
																				</fo:block>
																			</xsl:if>
																			<xsl:if test="Body/RoutingSummary/MeansOfTransport/FlightDetails">
																				<fo:block text-align="center">
																					<xsl:value-of select="Body/RoutingSummary/MeansOfTransport/FlightDetails/departureDate"/>
																				</fo:block>
																			</xsl:if>
																		</fo:table-cell>
																		<!-- Right collumn empty -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt"/>
																	</fo:table-row>
																	<fo:table-row>
																		<!-- Left collumn: Identifier -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Vessel / Aircraft etc</fo:block>
																			<xsl:if test="Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification">
																				<fo:block text-align="center">
																					<xsl:value-of select="Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/Vessel/vesselName"/>
																					<xsl:text> </xsl:text>
																					<xsl:value-of select="Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/VoyageDetail/voyageNumber"/>
																				</fo:block>
																			</xsl:if>
																			<xsl:if test="Body/RoutingSummary/MeansOfTransport/FlightDetails">
																				<fo:block text-align="center">
																					<xsl:value-of select="Body/RoutingSummary/MeansOfTransport/FlightDetails/flightNumber"/>
																				</fo:block>
																			</xsl:if>
																			<xsl:if test="Body/RoutingSummary/MeansOfTransport/RailTransportIdentification">
																				<fo:block text-align="center">
																					<xsl:value-of select="Body/RoutingSummary/MeansOfTransport/RailTransportIdentification/locomotiveNumber"/>
																					<xsl:text> </xsl:text>
																					<xsl:value-of select="Body/RoutingSummary/MeansOfTransport/RailTransportIdentification/railCarNumber"/>
																				</fo:block>
																			</xsl:if>
																			<xsl:if test="Body/RoutingSummary/MeansOfTransport/RoadTransportIdentification">
																				<fo:block text-align="center">
																					<xsl:value-of select="Body/RoutingSummary/MeansOfTransport/RoadTransportIdentification/licencePlateIdentification"/>
																				</fo:block>
																			</xsl:if>
																		</fo:table-cell>
																		<!-- Right collumn: Port of loading -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Port of Loading</fo:block>
																			<fo:block text-align="center">
																				<xsl:value-of select="Body/RoutingSummary/PlaceOfLoading/locationName"/>
																			</fo:block>
																		</fo:table-cell>
																	</fo:table-row>
																	<fo:table-row>
																		<!-- Left collumn: Port of descharge -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Port of Discharge</fo:block>
																			<fo:block text-align="center">
																				<xsl:value-of select="Body/RoutingSummary/PlaceOfDischarge/locationName"/>
																			</fo:block>
																		</fo:table-cell>
																		<!-- Right collumn: Place of delivery by on-carrier -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Place of Defivery by On-Carrier</fo:block>
																			<fo:block text-align="center">
																				<xsl:value-of select="Body/RoutingSummary/PlaceOfDelivery/locationName"/>
																			</fo:block>
																		</fo:table-cell>
																	</fo:table-row>
																</fo:table-body>
															</fo:table>
														</fo:block>
													</fo:table-cell>
												</fo:table-row>
											</fo:table-body>
										</fo:table>
									</fo:block>
								</fo:table-cell>
								<!-- Right collumn -->
								<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt">
									<fo:block>
										<fo:table>
											<fo:table-column column-width="266pt"/>
											<fo:table-body>
												<!--References, locations, date-->
												<fo:table-row>
													<fo:table-cell>
														<fo:block>
															<fo:table>
																<!-- Splitting in two collumns -->
																<fo:table-column column-width="133pt"/>
																<fo:table-column column-width="133pt"/>
																<fo:table-body>
																	<fo:table-row>
																		<!-- Left collumn: invoice number -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">No</fo:block>
																			<fo:block text-align="center">
                                    <xsl:value-of select="Header"/>
                                  </fo:block>
																		</fo:table-cell>
																		<!-- Right collumn: Date -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Date</fo:block>
																			<fo:block text-align="center">
																				<xsl:value-of select="Body/GeneralInformation/dateOfIssue"/>
																			</fo:block>
																		</fo:table-cell>
																	</fo:table-row>
																	<fo:table-row>
																		<!-- Left collumn: Buyer reference -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Purchase Order</fo:block>
																			<fo:block text-align="center">
																				<xsl:value-of select="Body/GeneralInformation/gtp:PurchaseOrderIdentifier/gtp:documentNumber"/>
																				<xsl:text/>
																			</fo:block>
																		</fo:table-cell>
																		<!-- Right collumn: Seller reference -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Exporter Reference</fo:block>
																			<fo:block text-align="center">None</fo:block>
																		</fo:table-cell>
																	</fo:table-row>
																	<fo:table-row>
																		<!-- Left collumn: LC reference -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">LC Reference</fo:block>
																			<fo:block height="12pt" text-align="center">
																				<xsl:value-of select="Body/GeneralInformation/gtp:DocumentaryCreditIdentifier/gtp:documentNumber"/>
																				<xsl:text/>
																			</fo:block>
																		</fo:table-cell>
																		<!-- Right collumn -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt"/>
																	</fo:table-row>
																	<fo:table-row>
																		<!-- Left collumn: Country of origin -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Country of Origin of Goods</fo:block>
																			<fo:block text-align="center">
																				<xsl:value-of select="Body/GeneralInformation/CountryOfOrigin/countryName"/>
																				<xsl:text/>
																			</fo:block>
																		</fo:table-cell>
																		<!-- Right collumn: country of destination -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Country of Destination</fo:block>
																			<fo:block text-align="center">
																				<xsl:value-of select="Body/GeneralInformation/CountryOfDestination/countryName"/>
																				<xsl:text/>
																			</fo:block>
																		</fo:table-cell>
																	</fo:table-row>
																</fo:table-body>
															</fo:table>
														</fo:block>
													</fo:table-cell>
												</fo:table-row>
												<!-- Additional Information -->
												<fo:table-row>
													<fo:table-cell border-color="black" border-left-style="solid" border-right-style="solid" border-top-style="solid" border-width="0.5pt">
														<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Additional Information</fo:block>
														<xsl:apply-templates select="Body/AdditionalInformation/line"/>
													</fo:table-cell>
												</fo:table-row>
											</fo:table-body>
										</fo:table>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
					<!-- Top section table end -->
					<!-- Header table-->
					<fo:table>
						<!-- Initial splitting in four collumns -->
						<fo:table-column border-color="black" border-style="solid" border-width="0.5pt" column-width="532pt"/>
						<fo:table-body>
							<!-- Headers -->
							<fo:table-row height="14pt">
								<fo:table-cell>
									<fo:block font-size="8pt" font-weight="bold" text-align="center">Particularities Furnished By Shipper</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
					<!-- Goods table-->
					<fo:table>
						<!-- Initial splitting in four collumns -->
						<fo:table-column border-color="black" border-style="solid" border-width="0.5pt" column-width="100pt"/>
						<fo:table-column border-color="black" border-style="solid" border-width="0.5pt" column-width="272pt"/>
						<fo:table-column border-color="black" border-style="solid" border-width="0.5pt" column-width="60pt"/>
						<fo:table-column border-color="black" border-style="solid" border-width="0.5pt" column-width="100pt"/>
						<fo:table-body>
							<!-- Headers -->
							<fo:table-row>
								<fo:table-cell>
									<fo:block font-size="8pt" font-weight="bold" text-align="center">Marks and Numbers</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Number and Kinds of Packages</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-size="8pt" font-weight="bold" text-align="center">Gross Weight</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-size="8pt" font-weight="bold" text-align="center">Measurements</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<fo:table-row height="8pt"/>
							<xsl:apply-templates select="Body/gtp:PackingDetail/gtp:Package"/>
							<fo:table-row height="14pt"/>
							<!-- Googs details -->
							<fo:table-row>
								<fo:table-cell/>
								<fo:table-cell>
									<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Description of Goods</fo:block>
								</fo:table-cell>
								<fo:table-cell/>
								<fo:table-cell/>
							</fo:table-row>
							<fo:table-row height="8pt"/>
							<fo:table-row>
								<fo:table-cell/>
								<fo:table-cell>
									<xsl:apply-templates select="Body/ConsignmentDetail/Product"/>
								</fo:table-cell>
								<fo:table-cell/>
								<fo:table-cell/>
							</fo:table-row>
							<fo:table-row height="14pt"/>
						</fo:table-body>
					</fo:table>
					<fo:table>
						<fo:table-column column-width="532pt"/>
						<fo:table-body>
							<fo:table-row height="14pt">
								<fo:table-cell>
									<fo:block font-size="8pt">
										<xsl:text> </xsl:text>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<fo:table-row>
								<fo:table-cell>
									<fo:block font-size="8pt">
										<xsl:text>The undersigned hereby certifies that the above mentioned goods are the manufacture or produce of the country as shown above.</xsl:text>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
					<!-- Technical block used to get the last page number -->
					<fo:block font-size="1pt" id="LastPage"/>
				</fo:flow>
  </xsl:template>
  <xsl:template name="footer">
    <fo:static-content flow-name="all-pages-after">
					<!-- Page number -->
					<fo:table>
						<fo:table-column column-width="232pt"/>
						<fo:table-column column-width="300pt"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell>
									<fo:block font-size="8pt">
										<xsl:text/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-size="8pt" text-align="end">
										<xsl:text>Place and date of issue, name, signature and stamp of competent authority</xsl:text>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<fo:table-row height="50pt"/>
						</fo:table-body>
					</fo:table>
					<fo:table>
						<fo:table-column column-width="150pt"/>
						<fo:table-column column-width="232pt"/>
						<fo:table-column column-width="150pt"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell/>
								<fo:table-cell>
									<xsl:if test="$isDraft = 'Y'">
										<fo:block color="gray" font-family="sans-serif" font-size="20.0pt" font-weight="bold" text-align="center">DRAFT</fo:block>
									</xsl:if>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-family="serif" font-size="10.0pt" text-align="end">Page <fo:page-number/> of <fo:page-number-citation ref-id="LastPage"/>
              </fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:static-content>
    <fo:static-content flow-name="last-page-after">
					<!-- Draft watermark-->
					<fo:table>
						<fo:table-column column-width="150pt"/>
						<fo:table-column column-width="232pt"/>
						<fo:table-column column-width="150pt"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell/>
								<fo:table-cell>
									<xsl:if test="$isDraft = 'Y'">
										<fo:block color="gray" font-family="sans-serif" font-size="20.0pt" font-weight="bold" text-align="center">DRAFT</fo:block>
									</xsl:if>
								</fo:table-cell>
								<fo:table-cell/>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
					<!-- Page number -->
					<fo:table>
						<fo:table-column column-width="382pt"/>
						<fo:table-column column-width="150pt"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell>
									<!-- Bottom legal text -->
									<fo:block font-size="8pt">
										<xsl:text>The undersigned hereby certifies that the above mentioned goods are the manufacture or produce of the country as shown above</xsl:text>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell display-align="after">
									<fo:block font-family="serif" font-size="10.0pt" text-align="end">Page <fo:page-number/> of <fo:page-number-citation ref-id="LastPage"/>
              </fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:static-content>
  </xsl:template>
</xsl:stylesheet>
