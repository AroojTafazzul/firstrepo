<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:cmp="http://www.bolero.net" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:gtp="http://www.neomalogic.com" xmlns:localization="xalan://com.misys.portal.common.localization.Localization" xmlns:utils="xalan://com.misys.portal.common.tools.Utils" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href="po_fo_common.xsl"/>

	<xsl:variable name="language">en</xsl:variable>
	<xsl:param name="logo_url"/>
	<!-- Determine if the invoice is not draft -->
	<xsl:param name="isDraft"/>
	<!--xsl:param name="isDraft">
		<xsl:choose>
			<xsl:when test="/in_tnx_record/prod_stat_code[.='03']">Y</xsl:when>
			<xsl:otherwise>N</xsl:otherwise>
		</xsl:choose>
	</xsl:param-->
	
	<xsl:template match="in_tnx_record">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master margin-bottom="10pt" margin-left="30pt" margin-right="30pt" master-name="last-page" page-height="841.9pt" page-width="595.3pt">
					<fo:region-body margin-bottom="30pt" margin-top="30pt"/>
					<fo:region-before extent="30pt"/>
					<fo:region-after extent="60pt" region-name="last-page-after"/>
				</fo:simple-page-master>
				<fo:simple-page-master margin-bottom="10pt" margin-left="30pt" margin-right="30pt" master-name="all-pages" page-height="841.9pt" page-width="595.3pt">
					<fo:region-body margin-bottom="30pt" margin-top="30pt"/>
					<fo:region-before extent="30pt"/>
					<fo:region-after extent="30pt" region-name="all-pages-after"/>
				</fo:simple-page-master>
				<fo:page-sequence-master master-name="Section1-ps">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference master-reference="all-pages" page-position="first"/>
						<fo:conditional-page-master-reference master-reference="last-page" page-position="last"/>
						<fo:conditional-page-master-reference master-reference="all-pages" page-position="rest"/>
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="Section1-ps">
				<!-- HEADER-->
				<!--fo:static-content flow-name="xsl-region-before">
				</fo:static-content-->
				<!-- FOOTER for all pages-->
				<!--fo:static-content flow-name="all-pages-after"-->
					<!-- Page number -->
					<!--fo:table>
						<fo:table-column column-width="150pt"/>
						<fo:table-column column-width="232pt"/>
						<fo:table-column column-width="150pt"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell><fo:block> </fo:block></fo:table-cell>
								<fo:table-cell>
									<xsl:if test="$isDraft = 'Y'">
										<fo:block color="gray" font-size="20.0pt" font-family="sans-serif" font-weight="bold" text-align="center">DRAFT</fo:block>
									</xsl:if>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-size="10.0pt" font-family="serif" text-align="end">Page <fo:page-number/> of <fo:page-number-citation ref-id="LastPage"/></fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table-->
				<!--/fo:static-content-->
				
				<!-- FOOTER for lats page : additional legal informations-->
				
				<!-- BODY-->
				
			<xsl:call-template name="footer"/>
        <xsl:call-template name="body"/>
      </fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!-- Basic template that output the result in a block element -->
	<xsl:template match="line_items/lt_tnx_record/incoterms/incoterm">
		<fo:block text-indent="5pt">
			<xsl:if test="../../product_name[.!='']">(<xsl:value-of select="../../product_name"/>)</xsl:if> : <xsl:value-of select="localization:getDecode($language, 'N212', code)"/> - <xsl:if test="location[.!='']">
        <xsl:value-of select="location"/>
      </xsl:if>
			<xsl:text/>
		</fo:block>
	</xsl:template>
	<xsl:template match="incoterms/incoterm">
		<fo:block text-indent="5pt">
			<xsl:value-of select="localization:getDecode($language, 'N212', code)"/> - <xsl:if test="location[.!='']">
        <xsl:value-of select="location"/>
      </xsl:if>
			<xsl:text/>
		</fo:block>
	</xsl:template>
	<xsl:template match="payments/payment">
		<fo:block text-indent="5pt">
			<xsl:choose>
				<xsl:when test="amt[.!='']">
          <xsl:value-of select="localization:getDecode($language, 'N208', code)"/> - <xsl:if test="nb_days[.!='']">
            <xsl:value-of select="nb_days"/> DAYS - </xsl:if>
          <xsl:value-of select="cur_code"/> <xsl:value-of select="amt"/>
        </xsl:when>
				<xsl:when test="pct[.!='']">
          <xsl:value-of select="localization:getDecode($language, 'N208', code)"/> - <xsl:if test="nb_days[.!='']">
            <xsl:value-of select="nb_days"/> DAYS - </xsl:if>
          <xsl:value-of select="pct"/>%</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
			<xsl:text/>
		</fo:block>
	</xsl:template>
	
	<!-- Goods template-->
	<xsl:template match="line_items/lt_tnx_record">
		<fo:table-row>
			<fo:table-cell>
				<fo:block text-indent="5pt">
					<xsl:if test="product_name[.!='']">
						- <xsl:value-of select="product_name"/>
					</xsl:if>
					<xsl:if test="product_orgn[.!='']">
						(ORIGIN: <xsl:value-of select="product_orgn"/>)
					</xsl:if>
					<xsl:text/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block text-align="center">
					<xsl:if test="qty_val[.!='']">
						<xsl:value-of select="qty_val"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="localization:getDecode($language, 'N202', qty_unit_measr_code)"/>
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
					<!-- Initial splitting in 2 columns -->
					<fo:table-column column-width="57pt"/>
					<fo:table-column column-width="50pt"/>
					<fo:table-body>
						<!-- Headers -->
						<fo:table-row>
							<!-- Currency -->
							<fo:table-cell>
								<fo:block text-align="start" text-indent="10pt">
									<xsl:if test="total_amt[.!='']">
										<xsl:value-of select="total_cur_code"/>
									</xsl:if>
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
							<!-- Amount -->
							<fo:table-cell>
								<fo:block text-align="end">
									<xsl:text> </xsl:text>
									<xsl:if test="total_amt[.!='']">
										<xsl:value-of select="total_amt"/>
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
	<xsl:template match="taxes/allowance">
		<fo:table-row>
			<!--Charges description-->
			<fo:table-cell>
				<fo:block text-indent="5pt">
					- <xsl:if test="type[.!='']">
						<!--xsl:value-of select="type"/-->
						<xsl:value-of select="localization:getDecode($language, 'N210', type)"/>
						
					</xsl:if>
					<xsl:text/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
        <fo:block> </fo:block>
      </fo:table-cell>
			<!--Charges amount-->
			<fo:table-cell>
				<fo:table>
					<!-- Initial splitting in 2 columns -->
					<fo:table-column column-width="57pt"/>
					<fo:table-column column-width="50pt"/>
					<fo:table-body>
						<!-- Headers -->
						<fo:table-row>
							<!-- Currency -->
							<fo:table-cell>
								<fo:block text-align="start" text-indent="10pt">
									<xsl:if test="amt[.!='']">
										<xsl:value-of select="cur_code"/>
									</xsl:if>
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
							<!-- Amount -->
							<fo:table-cell>
								<fo:block text-align="end">
									<xsl:text> </xsl:text>
									<xsl:if test="amt[.!='']">
										<xsl:value-of select="amt"/>
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
	
<xsl:template name="body">
    <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="11.0pt">
					<!-- Buyer plus title-->
					<fo:table>
						<!-- Initial splitting in a single row of two columns -->
						<fo:table-column border-color="black" border-style="solid" border-width="0.5pt" column-width="266pt"/>
						<fo:table-column column-width="266pt"/>
						<fo:table-body>
							<fo:table-row>
								<!-- Seller data -->
								<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="62.5pt">
									<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Seller</fo:block>
									<fo:block text-indent="30pt">
										<xsl:value-of select="seller_name"/>
									</fo:block>
									<fo:block text-indent="30pt">
										<xsl:value-of select="seller_street_name"/>
									</fo:block>
									<fo:block text-indent="30pt">
										<xsl:value-of select="seller_town_name"/>   <xsl:value-of select="seller_post_code"/>
									</fo:block>
									<fo:block text-indent="30pt">aaaaaaaaaaa
										<xsl:value-of select="seller_country"/>
									</fo:block>
								</fo:table-cell>
								<!-- Document header -->
								<fo:table-cell display-align="center" font-size="14pt" font-weight="bold">
									<fo:block text-align="center">Commercial Invoice</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
					<!-- General details table-->
					<fo:table border-color="black" border-style="solid" border-width="0.5pt">
						<!-- Initial splitting in a single row of two columns -->
						<fo:table-column column-width="266pt"/>
						<!-- Specific border definition in oder to double the last cell border-->
						<fo:table-column column-width="266pt"/>
						<fo:table-body>
							<fo:table-row>
								<!-- Left column -->
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
															<xsl:value-of select="consgn_name"/>
														</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="consgn_street_name"/>
														</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="consgn_town_name"/>  <xsl:value-of select="consgn_post_code"/>
														</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="consgn_country"/>
														</fo:block>
													</fo:table-cell>
												</fo:table-row>
												<!-- Buyer data -->
												<fo:table-row>
													<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="62.5pt">
														<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Buyer</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="buyer_name"/>
														</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="buyer_street_name"/>
														</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="buyer_town_name"/>  <xsl:value-of select="buyer_post_code"/>
														</fo:block>
														<fo:block text-indent="30pt">
															<xsl:value-of select="buyer_country"/>
														</fo:block>
													</fo:table-cell>
												</fo:table-row>
												<fo:table-row>
													<fo:table-cell>
														<fo:block>
															<fo:table>
																<!-- Splitting in two columns -->
																<fo:table-column column-width="133pt"/>
																<fo:table-column column-width="133pt"/>
																<fo:table-body>
																	<fo:table-row>
																		<!-- Left column: Departure date -->
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
																		<!-- Right column empty -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
                                  <fo:block> </fo:block>
                                </fo:table-cell>
																	</fo:table-row>
																	<fo:table-row>
																		<!-- Left column: Identifier -->
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
																		<!-- Right column: Port of loading -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Port of Loading</fo:block>
																			<fo:block text-align="center">
																				<xsl:value-of select="Body/RoutingSummary/PlaceOfLoading/locationName"/>
																			</fo:block>
																		</fo:table-cell>
																	</fo:table-row>
																	<fo:table-row>
																		<!-- Left column: Port of descharge -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Port of Discharge</fo:block>
																			<fo:block text-align="center">
																				<xsl:value-of select="Body/RoutingSummary/PlaceOfDischarge/locationName"/>
																			</fo:block>
																		</fo:table-cell>
																		<!-- Right column: Place of delivery by on-carrier -->
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
								<!-- Right column -->
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
																<!-- Splitting in two columns -->
																<fo:table-column column-width="133pt"/>
																<fo:table-column column-width="133pt"/>
																<fo:table-body>
																	<fo:table-row>
																		<!-- Left column: invoice number -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Invoice No</fo:block>
																			<fo:block text-align="center">
                                    <xsl:value-of select="ref_id"/>
                                  </fo:block>
																		</fo:table-cell>
																		<!-- Right column: Date -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Date</fo:block>
																			<fo:block text-align="center">
																				<xsl:value-of select="iss_date"/>
																			</fo:block>
																			<!--fo:block text-align="center">
																				<xsl:value-of select="utils:transformNiceDate(iss_date, 'FULL', '')"/>
																			</fo:block-->
																		</fo:table-cell>
																	</fo:table-row>
																	<fo:table-row>
																		<!-- Left column: Buyer reference -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Purchase Order</fo:block>
																			<fo:block text-align="center">
                                    <xsl:value-of select="issuer_ref_id"/>
                                  </fo:block>
																		</fo:table-cell>
																		<!-- Right column: Seller reference -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Exporter Reference</fo:block>
																			<fo:block text-align="center">
                                    <xsl:value-of select="cust_ref_id"/>
                                  </fo:block>
																		</fo:table-cell>
																	</fo:table-row>
																	<fo:table-row>
																		<!-- Left column: LC reference -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">LC Reference</fo:block>
																			<fo:block height="12pt" text-align="center">
																				<xsl:value-of select="Body/GeneralInformation/DocumentaryCreditIdentifier/documentNumber"/>
																			</fo:block>
																		</fo:table-cell>
																		<!-- Right column -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
                                  <fo:block> </fo:block>
                                </fo:table-cell>
																	</fo:table-row>
																	<fo:table-row>
																		<!-- Left column: Country of origin -->
																		<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
																			<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Country of Origin of Goods</fo:block>
																			<fo:block text-align="center">
																				<xsl:value-of select="Body/RoutingSummary/CountryOfOrigin/countryName"/>
																			</fo:block>
																		</fo:table-cell>
																		<!-- Right column: country of destination -->
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
														<xsl:if test="count(line_items/lt_tnx_record/incoterms/incoterm) != 0 or count(incoterms/incoterm) != 0">
															<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">- IncoTerm :</fo:block>
														</xsl:if>
														<xsl:apply-templates select="line_items/lt_tnx_record/incoterms/incoterm"/>
														<xsl:apply-templates select="incoterms/incoterm"/>
														<xsl:if test="count(payments/payment) != 0">
																<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">- Payment :</fo:block>
														</xsl:if>
														<xsl:apply-templates select="payments/payment"/>
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
						<!-- Initial splitting in three columns -->
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
							<!--fo:table-row height="8pt"/-->
               		<fo:table-row>
               			<fo:table-cell>
               				<fo:block text-indent="5pt">
               						<xsl:value-of select="goods_desc"/>
               					<xsl:text/>
               				</fo:block>
               			</fo:table-cell>
               			<fo:table-cell>
               				<fo:block text-indent="5pt">
               					<xsl:text/>
               				</fo:block>
               			</fo:table-cell>
               			<fo:table-cell>
               				<fo:block text-indent="5pt">
               					<xsl:text/>
               				</fo:block>
               			</fo:table-cell>
               		</fo:table-row>
							<!--fo:table-row height="8pt"/-->
							<xsl:apply-templates select="line_items/lt_tnx_record"/>
							<!--fo:table-row height="14pt"/-->
							<!-- Charges -->
							<xsl:if test="taxes/allowance">
								<fo:table-row>
									<fo:table-cell>
										<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Charges</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<!--fo:table-row height="8pt"/-->
								<xsl:apply-templates select="taxes/allowance"/>
								<!--fo:table-row height="14pt"/-->
							</xsl:if>
							<!-- Packing details -->
							<xsl:if test="Body/gtp:PackingDetail/gtp:Package">
								<fo:table-row>
									<fo:table-cell>
										<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Packing Summary</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<!--fo:table-row height="8pt"/-->
								<fo:table-row>
									<fo:table-cell>
										<xsl:apply-templates select="Body/gtp:PackingDetail/gtp:Package"/>
									</fo:table-cell>
									<fo:table-cell>
                <fo:block> </fo:block>
              </fo:table-cell>
									<fo:table-cell>
                <fo:block> </fo:block>
              </fo:table-cell>
								</fo:table-row>
							</xsl:if>
							<!--fo:table-row height="14pt"/-->
						</fo:table-body>
					</fo:table>
					<!-- Total table-->
					<fo:table>
						<!-- Initial splitting in three columns -->
						<fo:table-column column-width="302pt"/>
						<fo:table-column border-color="black" border-style="solid" border-width="0.5pt" column-width="230pt"/>
						<fo:table-body>
							<!-- Headers -->
							<fo:table-row>
								<fo:table-cell>
              <fo:block> </fo:block>
            </fo:table-cell>
								<fo:table-cell>
									<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Total Amount</fo:block>
									<fo:block text-align="center">
										<xsl:value-of select="total_cur_code"/>
										<xsl:text> </xsl:text>
										<xsl:value-of select="total_amt"/>
									</fo:block>
									<!--fo:block>Paid : <xsl:value-of select="utils:spellout('en', total_amt, total_cur_code)"/></fo:block-->
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
					<xsl:if test="$isDraft = 'Y'">
						<fo:block color="gray" font-family="sans-serif" font-size="20.0pt" font-weight="bold" text-align="center">DRAFT</fo:block>
					</xsl:if>
					<fo:block font-family="serif" font-size="10.0pt" text-align="end">Page <fo:page-number/> of <fo:page-number-citation ref-id="LastPage"/>
					</fo:block>
				</fo:static-content>
    <fo:static-content flow-name="last-page-after">
					<!-- Draft watermark-->
					<xsl:if test="$isDraft = 'Y'">
					<fo:table>
						<fo:table-column column-width="150pt"/>
						<fo:table-column column-width="232pt"/>
						<fo:table-column column-width="150pt"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell>
                <fo:block> </fo:block>
              </fo:table-cell>
								<fo:table-cell>
									<fo:block color="gray" font-family="sans-serif" font-size="20.0pt" font-weight="bold" text-align="center">DRAFT</fo:block>
								</fo:table-cell>
								<fo:table-cell>
                <fo:block> </fo:block>
              </fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
					</xsl:if>
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
									<fo:block font-family="serif" font-size="10.0pt" text-align="end">lllllPage <fo:page-number/> of <fo:page-number-citation ref-id="LastPage"/>
              </fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:static-content>
  </xsl:template>
</xsl:stylesheet>
