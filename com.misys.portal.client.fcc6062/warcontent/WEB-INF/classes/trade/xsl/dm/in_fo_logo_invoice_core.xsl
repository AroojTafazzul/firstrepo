<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:cmp="http://www.bolero.net" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:gtp="http://www.neomalogic.com" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	
	<xsl:param name="isDraft" select="'Y'"/>
	<xsl:param name="logo_url"/>
	<xsl:template match="CommercialInvoice">

		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master margin-bottom="10pt" margin-left="30pt" margin-right="30pt" master-name="last-page" page-height="841.9pt" page-width="595.3pt">
					<fo:region-before extent="30pt"/>
					<fo:region-after extent="60pt" region-name="last-page-after"/>
					<fo:region-body margin-bottom="30pt" margin-top="30pt"/>
				</fo:simple-page-master>
				<fo:simple-page-master margin-bottom="10pt" margin-left="30pt" margin-right="30pt" master-name="all-pages" page-height="841.9pt" page-width="595.3pt">
					<fo:region-before extent="30pt"/>
					<fo:region-after extent="30pt" region-name="all-pages-after"/>
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
	<xsl:template match="Body/TermsAndConditions/clause | Body/PaymentTerms/PaymentTermsDetail/UserDefinedPaymentTerms/line | AdditionalInformation/line">
		<fo:block text-indent="5pt">
			<xsl:value-of select="."/>
			<xsl:text/>
		</fo:block>
	</xsl:template>
	
	<!-- Goods template-->
	<xsl:template match="Body/LineItemDetails/LineItem">
		<fo:table-row>
			<fo:table-cell>
				<fo:block text-indent="5pt">
					<xsl:if test="Product/ProductIdentifiers/productIdentification[.!=''] or Product/productName[.!='']">
						<xsl:value-of select="lineItemNumber"/>
						<xsl:text>. </xsl:text>
					</xsl:if>
					<xsl:if test="Product/ProductIdentifiers/productIdentification[.!='']">
						<xsl:value-of select="Product/ProductIdentifiers/productIdentification"/>
						<xsl:if test="Product/productName[.!='']">
							<xsl:text> - </xsl:text>
						</xsl:if>
					</xsl:if>
					<xsl:value-of select="Product/productName"/>
					<xsl:text/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block text-align="center">
					<xsl:if test="LineItemQuantity/value[.!='']">
						<xsl:value-of select="LineItemQuantity/value"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="LineItemQuantity/unitOfMeasureCode"/>
					</xsl:if>
					<xsl:text/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<!-- 
				<xsl:variable name="price"><xsl:value-of select="UnitPrice/value"/></xsl:variable>
				<xsl:variable name="qty"><xsl:value-of select="LineItemQuantity/value"/></xsl:variable>
				-->
				<fo:table>
					<!-- Initial splitting in 2 collumns -->
					<fo:table-column column-width="57pt"/>
					<fo:table-column column-width="50pt"/>
					<fo:table-body>
						<!-- Headers -->
						<fo:table-row>
							<!-- Currency -->
							<fo:table-cell>
								<fo:block text-align="start" text-indent="10pt">
									<xsl:if test="gtp:EquivalentAmount/gtp:value[.!='']">
										<xsl:value-of select="gtp:EquivalentAmount/gtp:currencyCode"/>
									</xsl:if>
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
							<!-- Amount -->
							<fo:table-cell>
								<fo:block text-align="end">
									<xsl:text> </xsl:text>
									<xsl:if test="gtp:EquivalentAmount/gtp:value[.!='']">
										<xsl:value-of select="gtp:EquivalentAmount/gtp:value"/>
										<!-- 
										<xsl:value-of select="$qty*$price"/>
										-->
									</xsl:if>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>


	<!--Charges-->
	<xsl:template match="Body/GeneralChargesOrDiscounts/LumpSumChargeWithDocumentIdentifier">
		<fo:table-row>
			<!--Charges description-->
			<fo:table-cell>
				<fo:block text-indent="5pt">
					<xsl:if test="chargeType[.!='']">
						<xsl:value-of select="chargeType"/>
						<xsl:if test="DocumentIdentifier/documentNumber[.!='']">
							<xsl:text> - </xsl:text>
						</xsl:if>
					</xsl:if>
					<xsl:value-of select="DocumentIdentifier/documentNumber"/>
					<xsl:text/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell/>
			<!--Charges amount-->
			<fo:table-cell>
				<fo:table>
					<!-- Initial splitting in 2 collumns -->
					<fo:table-column column-width="57pt"/>
					<fo:table-column column-width="50pt"/>
					<fo:table-body>
						<!-- Headers -->
						<fo:table-row>
							<!-- Currency -->
							<fo:table-cell>
								<fo:block text-align="start" text-indent="10pt">
									<xsl:if test="gtp:EquivalentAmount/gtp:value[.!='']">
										<xsl:value-of select="gtp:EquivalentAmount/gtp:currencyCode"/>
									</xsl:if>
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
							<!-- Amount -->
							<fo:table-cell>
								<fo:block text-align="end">
									<xsl:text> </xsl:text>
									<xsl:if test="gtp:EquivalentAmount/gtp:value[.!='']">
										<xsl:value-of select="gtp:EquivalentAmount/gtp:value"/>
									</xsl:if>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<!--Packing description-->
	<xsl:template match="Body/gtp:PackingDetail/gtp:Package">
		<fo:block text-indent="5pt">
			<xsl:value-of select="gtp:PackageCount/gtp:numberOfPackages"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="gtp:PackageCount/gtp:typeOfPackage"/>
			<xsl:if test="gtp:Content/gtp:Product/gtp:productName[.!='']">
				<xsl:text> - </xsl:text>
				<xsl:value-of select="gtp:Content/gtp:Product/gtp:productName"/>
			</xsl:if>
		</fo:block>
		<fo:block text-indent="20pt">
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
		<fo:block text-indent="20pt">
			<xsl:if test="gtp:NetWeight/gtp:value[.!='']">
				<xsl:text>Net weight: </xsl:text>
				<xsl:value-of select="gtp:NetWeight/gtp:value"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="gtp:NetWeight/gtp:weightUnitCode"/>
				<xsl:if test="gtp:GrossWeight/gtp:value[.!='']">
					<xsl:text>, </xsl:text>
				</xsl:if>
			</xsl:if>
			<xsl:if test="gtp:GrossWeight/gtp:value[.!='']">
				<xsl:text>Gross weight: </xsl:text>
				<xsl:value-of select="gtp:GrossWeight/gtp:value"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="gtp:GrossWeight/gtp:weightUnitCode"/>
			</xsl:if>
			<xsl:text/>
		</fo:block>
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
						<fo:table-column column-width="150pt"/>
						<fo:table-column column-width="150pt"/>
						<fo:table-column column-width="232pt"/>
						<fo:table-body>
							<fo:table-row height="70pt">
								<!-- Company logo -->
								<fo:table-cell>
									<fo:external-graphic height="46.5pt" space-start.optimum="10.0pt" width="142.5pt">
										<xsl:attribute name="src">
                  <xsl:value-of select="$logo_url"/>
                </xsl:attribute>
									</fo:external-graphic>
								</fo:table-cell>
								<!-- Seller data -->
								<fo:table-cell height="62.5pt">
									<fo:block>
										<xsl:value-of select="Body/Parties/Seller/organizationName"/>
									</fo:block>
									<fo:block>
										<xsl:value-of select="Body/Parties/Seller/AddressInformation/FullAddress/line[position()='1']"/>
									</fo:block>
									<fo:block>
										<xsl:value-of select="Body/Parties/Seller/AddressInformation/FullAddress/line[position()='2']"/>
									</fo:block>
									<fo:block>
										<xsl:value-of select="Body/Parties/Seller/AddressInformation/FullAddress/line[position()='3']"/>
									</fo:block>
								</fo:table-cell>
								<!-- Document header -->
								<fo:table-cell display-align="after" font-size="14pt" font-weight="bold">
									<fo:block text-align="end">Commercial Invoice</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<fo:table-row height="10pt"/>
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
												<!-- Buyer data -->
												<fo:table-row>
													<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="62.5pt">
														<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Buyer</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="Body/Parties/Buyer/organizationName"/>
														</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='1']"/>
														</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='2']"/>
														</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='3']"/>
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
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Vessel / Aircraft</fo:block>
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
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Invoice No</fo:block>
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
                                    <xsl:value-of select="Body/GeneralInformation/PurchaseOrderIdentifier/documentNumber"/>
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
																				<xsl:value-of select="Body/GeneralInformation/DocumentaryCreditIdentifier/documentNumber"/>
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
																				<xsl:value-of select="Body/RoutingSummary/CountryOfOrigin/countryName"/>
																			</fo:block>
																		</fo:table-cell>
																		<!-- Right collumn: country of destination -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Country of Destination</fo:block>
																			<fo:block text-align="center">
																				<xsl:value-of select="Body/RoutingSummary/CountryOfDestination/countryName"/>
																			</fo:block>
																		</fo:table-cell>
																	</fo:table-row>
																</fo:table-body>
															</fo:table>
														</fo:block>
													</fo:table-cell>
												</fo:table-row>
												<!-- Terms -->
												<fo:table-row>
													<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt">
														<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Terms of Delivery and Payment</fo:block>
														<xsl:if test="Body/GeneralInformation/Incoterms/incotermsCode[.!='']">
															<fo:block text-indent="5pt">
																<xsl:value-of select="Body/GeneralInformation/Incoterms/incotermsCode"/>
																<xsl:text> </xsl:text>
																<xsl:value-of select="Body/GeneralInformation/Incoterms/NamedLocation/locationName"/>
															</fo:block>
														</xsl:if>
														<xsl:apply-templates select="Body/TermsAndConditions/clause"/>
														<xsl:apply-templates select="Body/PaymentTerms/PaymentTermsDetail/UserDefinedPaymentTerms/line"/>
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
					<!-- Goods table-->
					<fo:table>
						<!-- Initial splitting in three collumns -->
						<fo:table-column border-color="black" border-style="solid" border-width="0.5pt" column-width="302pt"/>
						<fo:table-column border-color="black" border-style="solid" border-width="0.5pt" column-width="115pt"/>
						<fo:table-column border-color="black" border-style="solid" border-width="0.5pt" column-width="115pt"/>
						<fo:table-body>
							<!-- Headers -->
							<fo:table-row>
								<fo:table-cell>
									<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Description of Goods</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-size="8pt" font-weight="bold" text-align="center">Quantity</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-size="8pt" font-weight="bold" text-align="center">Amount</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<fo:table-row height="8pt"/>
							<xsl:apply-templates select="Body/LineItemDetails/LineItem"/>
							<fo:table-row height="14pt"/>
							<!-- Charges -->
							<fo:table-row>
								<fo:table-cell>
									<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Charges</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<fo:table-row height="8pt"/>
							<xsl:apply-templates select="Body/GeneralChargesOrDiscounts/LumpSumChargeWithDocumentIdentifier"/>
							<fo:table-row height="14pt"/>
							<!-- Packing details -->
							<fo:table-row>
								<fo:table-cell>
									<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Packing Summary</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<fo:table-row height="8pt"/>
							<fo:table-row>
								<fo:table-cell>
									<xsl:apply-templates select="Body/gtp:PackingDetail/gtp:Package"/>
								</fo:table-cell>
								<fo:table-cell/>
								<fo:table-cell/>
							</fo:table-row>
							<fo:table-row height="14pt"/>
						</fo:table-body>
					</fo:table>
					<!-- Total table-->
					<fo:table>
						<!-- Initial splitting in three collumns -->
						<fo:table-column column-width="302pt"/>
						<fo:table-column border-color="black" border-style="solid" border-width="0.5pt" column-width="230pt"/>
						<fo:table-body>
							<!-- Headers -->
							<fo:table-row>
								<fo:table-cell/>
								<fo:table-cell>
									<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Total Amount</fo:block>
									<fo:block text-align="center">
										<xsl:value-of select="Body/Totals/TotalAmount/MultiCurrency/currencyCode"/>
										<xsl:text> </xsl:text>
										<xsl:value-of select="Body/Totals/TotalAmount/MultiCurrency/value"/>
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
										<xsl:text>It is hereby certified that this invoice shows the actual price of the goods</xsl:text>
									</fo:block>
									<fo:block font-size="8pt">
										<xsl:text>described, that no other invoice has been or will be issued, and that all</xsl:text>
									</fo:block>
									<fo:block font-size="8pt">
										<xsl:text>particularities are true and correct.</xsl:text>
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
