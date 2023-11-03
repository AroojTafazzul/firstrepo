<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com), All 
	Rights Reserved. -->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:localization="xalan://com.misys.portal.common.localization.Localization" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>

	<xsl:variable name="headerFontSize">7</xsl:variable>
	<xsl:variable name="blockFontSize">7</xsl:variable>
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>
	
	<xsl:param name="advicesLogoImage">url('<xsl:value-of select="$base_url" />/advices/logo.gif')</xsl:param>

	<xsl:template match="sg_tnx_record">
		<!-- HEADER -->
		
		<!-- FOOTER -->
		
		<!-- BODY -->
		
	<xsl:call-template name="header"/>
    <xsl:call-template name="footer"/>
    <xsl:call-template name="body"/>
  </xsl:template>
	
	<xsl:template name="report_row">
	<xsl:param name="reportTitle"/>
	<xsl:param name="reportConentFontSize"/>
	<xsl:param name="reportContent_line1"/>
	<xsl:param name="reportContent_line2"/>
	<xsl:param name="reportContent_line3"/>
	<xsl:param name="reportContent_line4"/>
	<xsl:param name="reportContent_line5"/>
	<xsl:param name="reportContent_line6"/>
	<xsl:param name="reportContent_line7"/>
	<xsl:param name="reportContent_line8"/>
	<xsl:param name="reportContent_line9"/>
	<xsl:param name="reportTitleAlign"/>
	<fo:table-row>
		<fo:table-cell>
			<fo:block>
				<xsl:call-template name="report_section">
					<xsl:with-param name="reportTitle" select="$reportTitle"/>
					<xsl:with-param name="reportConentFontSize" select="$reportConentFontSize"/>
					<xsl:with-param name="reportTitleAlign" select="$reportTitleAlign"/>
					<xsl:with-param name="reportContent_line1" select="$reportContent_line1"/>
					<xsl:with-param name="reportContent_line2" select="$reportContent_line2"/>
					<xsl:with-param name="reportContent_line3" select="$reportContent_line3"/>
					<xsl:with-param name="reportContent_line4" select="$reportContent_line4"/>
					<xsl:with-param name="reportContent_line5" select="$reportContent_line5"/>
					<xsl:with-param name="reportContent_line6" select="$reportContent_line6"/>
					<xsl:with-param name="reportContent_line7" select="$reportContent_line7"/>
					<xsl:with-param name="reportContent_line8" select="$reportContent_line8"/>
					<xsl:with-param name="reportContent_line9" select="$reportContent_line9"/>
				</xsl:call-template>
			</fo:block>
		</fo:table-cell>
	</fo:table-row>
	</xsl:template>
	
	<xsl:template name="report_section">
		<xsl:param name="reportTitle"/>
		<xsl:param name="reportConentFontSize"/>
		<xsl:param name="reportContent_line1"/>
		<xsl:param name="reportContent_line2"/>
		<xsl:param name="reportContent_line3"/>
		<xsl:param name="reportContent_line4"/>
		<xsl:param name="reportContent_line5"/>
		<xsl:param name="reportContent_line6"/>
		<xsl:param name="reportContent_line7"/>
		<xsl:param name="reportContent_line8"/>
		<xsl:param name="reportContent_line9"/>
		<xsl:param name="reportTitleAlign">left</xsl:param>
		
		<fo:block background-color="#7692B7" color="#FFFFFF" space-after.conditionality="retain" space-before.conditionality="retain">
			<xsl:attribute name="font-size">
        <xsl:value-of select="$headerFontSize"/>
      </xsl:attribute>
			<xsl:attribute name="text-align">
        <xsl:value-of select="$reportTitleAlign"/>
      </xsl:attribute>
			<xsl:choose>
				<xsl:when test="$reportTitle='BLANK_HEADER'">
				 
				</xsl:when>
				<xsl:otherwise>
				<xsl:value-of select="localization:getGTPString($language, $reportTitle)"/>	
				</xsl:otherwise>
			</xsl:choose>
		</fo:block>
		<fo:block space-after.conditionality="retain" space-before="1mm" space-before.conditionality="retain" start-indent="10.0pt">
			<fo:block>
				<xsl:attribute name="font-size">
				<xsl:choose>
					<xsl:when test="$reportConentFontSize != ''">
						<xsl:value-of select="$reportConentFontSize"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$blockFontSize"/>
					</xsl:otherwise>
				</xsl:choose>
				</xsl:attribute>
				<fo:block>
          <xsl:value-of select="$reportContent_line1"/>
        </fo:block>
				<fo:block>
          <xsl:value-of select="$reportContent_line2"/>
        </fo:block>
				<fo:block>
          <xsl:value-of select="$reportContent_line3"/>
        </fo:block>
				<fo:block>
          <xsl:value-of select="$reportContent_line4"/>
        </fo:block>
				<fo:block>
          <xsl:value-of select="$reportContent_line5"/>
        </fo:block>
				<fo:block>
          <xsl:value-of select="$reportContent_line6"/>
        </fo:block>
				<fo:block>
          <xsl:value-of select="$reportContent_line7"/>
        </fo:block>
				<fo:block>
          <xsl:value-of select="$reportContent_line8"/>
        </fo:block>
				<fo:block>
          <xsl:value-of select="$reportContent_line9"/>
        </fo:block>
				<fo:block> </fo:block>
				<fo:block> </fo:block>
			</fo:block>
		</fo:block>
	</xsl:template>
<xsl:template name="header">
    <fo:static-content flow-name="xsl-region-before">
			<xsl:call-template name="header_bank_text"/>
		</fo:static-content>
  </xsl:template>
  <xsl:template name="header_bank_text">
	  	<fo:block font-size="8.0pt" font-family="Helvetica">
						<fo:table width="440.0pt">
							<fo:table-column column-width="150.0pt"/>
							<fo:table-column column-width="100.0pt"/>
							<fo:table-column column-width="100.0pt"/>
							<fo:table-column column-width="45.0pt"/>
							<fo:table-column column-width="45.0pt"/>
							<fo:table-body>
								<fo:table-row>
									<!-- Bank logo -->
									<fo:table-cell>
									<fo:block>
										<xsl:call-template name="logo"/>
									</fo:block>
									</fo:table-cell>
										<xsl:call-template name="header-text"/>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>
	  </xsl:template>
	  <xsl:template name="logo">
		<fo:block start-indent="{number($pdfMargin)}pt">
			<fo:external-graphic content-height="1.5cm" content-width="3.5cm">
				<xsl:attribute name="src">
                    <xsl:choose>
                   		<xsl:when test="$isdynamiclogo='true'">url('<xsl:value-of select="$base_url" />/advices/<xsl:value-of select="recipient_bank/abbv_name" />.gif')</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="utils:getImagePath($advicesLogoImage)"></xsl:value-of>
						</xsl:otherwise>
					</xsl:choose>
                </xsl:attribute>
			</fo:external-graphic>
		</fo:block>
	</xsl:template>
	  <xsl:template name="header-text">
			<xsl:if test="issuing_bank/name[.!='']">
								<fo:table-cell font-size="8.0pt">
									<fo:block>
										<xsl:value-of select="issuing_bank/name" />
									</fo:block>
									<xsl:if test="issuing_bank/address_line_1[.!='']">
										<fo:block>
											   <xsl:value-of select="issuing_bank/address_line_1"/>
										</fo:block>
									</xsl:if>
									<xsl:if test="issuing_bank/address_line_2[.!='']">
										<fo:block>
											    <xsl:value-of select="issuing_bank/address_line_2"/>
										</fo:block>
									</xsl:if>
									<xsl:if test="issuing_bank/dom[.!='']">
										<fo:block>
											    <xsl:value-of select="issuing_bank/dom"/>
										</fo:block>
									</xsl:if>
									<xsl:if test="issuing_bank/address_line_4[.!='']">
										<fo:block>
											    <xsl:value-of select="issuing_bank/address_line_4"/>
										</fo:block>
									</xsl:if>
								</fo:table-cell>
								<xsl:if test="issuing_bank/phone[.!=''] or issuing_bank/fax[.!=''] or issuing_bank/telex[.!=''] or issuing_bank/iso_code[.!='']">
									<fo:table-cell font-size="8.0pt">
										<xsl:if test="issuing_bank/phone[.!='']">
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FO_COMMON_PHONE')" />
											    	<xsl:value-of select="issuing_bank/phone"/>
											</fo:block>
										</xsl:if>
										<xsl:if test="issuing_bank/fax[.!='']">
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FO_COMMON_FAX')" />
											    	<xsl:value-of select="issuing_bank/fax"/>
											</fo:block>
										</xsl:if>
										<xsl:if test="issuing_bank/telex[.!='']">
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FO_COMMON_TELEX')" />
											    	<xsl:value-of select="issuing_bank/telex"/>
											</fo:block>
										</xsl:if>
										<xsl:if test="issuing_bank/iso_code[.!='']">
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FO_COMMON_SWIFT')" />
											    	<xsl:value-of select="issuing_bank/iso_code"/>
											</fo:block>
										</xsl:if>
									</fo:table-cell>
								</xsl:if>
								<xsl:if test="product_code[.!= '']">
								<fo:table-cell border-left="1px solid {$backgroundSubtitles}"
											   font-size="{number(substring-before($pdfFontSize,'pt'))+2}pt">
									<fo:block font-weight="bold" text-align="center" end-indent="{number($pdfMargin)}pt">
										<xsl:value-of select="localization:getDecode($language, 'N001', product_code)" />
									</fo:block>
								</fo:table-cell>
							</xsl:if>
							<xsl:if test="sub_product_code[.!= 'SMP']">
								<fo:table-cell border-left="1px solid {$backgroundSubtitles}"
											   font-size="{number(substring-before($pdfFontSize,'pt'))+2}pt">
									<fo:block font-weight="bold" text-align="center" end-indent="{number($pdfMargin)}pt">
										<xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code)" />
									</fo:block>
								</fo:table-cell>
							</xsl:if>
							</xsl:if>
	</xsl:template>
  <xsl:template name="body">
    <fo:flow flow-name="xsl-region-body" font-size="10.0pt" xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider">
					<!-- <xsl:call-template name="disclammer_template" /> -->
					<fo:block xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider" white-space-collapse="false">
						<fo:table font-family="Courier" table-layout="fixed" width="100%">
							<fo:table-column column-width="46%"/>
							<fo:table-column column-width="54%"/>
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell number-columns-spanned="2">
										<fo:block text-align="right">
                  <xsl:attribute name="font-size">
                    <xsl:value-of select="$blockFontSize"/>
                  </xsl:attribute>
										 <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/>
                  <xsl:value-of select="ref_id"/>
                </fo:block>
									</fo:table-cell>
								</fo:table-row>
								<fo:table-row keep-with-next="always">
									<fo:table-cell border-left="#7692B7 solid 1px" border-right="#7692B7 solid 1px">
										<fo:block>
											<fo:table>
												<fo:table-body start-indent="0pt">
													<xsl:call-template name="report_row">
														<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_NAME_ADRESS_SHIPPERS</xsl:with-param>
														<xsl:with-param name="reportContent_line1">
                          <xsl:value-of select="beneficiary_name"/>
                        </xsl:with-param>
														<xsl:with-param name="reportContent_line2">
                          <xsl:value-of select="beneficiary_address_line_1"/>
                        </xsl:with-param>
														<xsl:with-param name="reportContent_line3">
                          <xsl:value-of select="beneficiary_address_line_2"/>
                        </xsl:with-param>
														<xsl:with-param name="reportContent_line4">
                          <xsl:value-of select="beneficiary_dom"/>
                        </xsl:with-param>
														<xsl:with-param name="reportContent_line5">
                          <xsl:value-of select="beneficiary_country"/>
                        </xsl:with-param>
													</xsl:call-template>
													<xsl:call-template name="report_row">
														<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_NAME_ADRESS_CONSIGNEE</xsl:with-param>
														<xsl:with-param name="reportContent_line1">
                          <xsl:value-of select="consignee_name"/>
                        </xsl:with-param>
														<xsl:with-param name="reportContent_line2">
                          <xsl:value-of select="consignee_address_line_1"/>
                        </xsl:with-param>
														<xsl:with-param name="reportContent_line3">
                          <xsl:value-of select="consignee_address_line_2"/>
                        </xsl:with-param>
														<xsl:with-param name="reportContent_line4">
                          <xsl:value-of select="consignee_dom"/>
                        </xsl:with-param>
													</xsl:call-template>
												</fo:table-body>
											</fo:table>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell border-right="#7692B7 solid 1px">
										<fo:table>
											<fo:table-body start-indent="0pt">
												<xsl:call-template name="report_row">
														<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_NAME_ADRESS_BANK</xsl:with-param>
														<xsl:with-param name="reportContent_line1">
                        <xsl:value-of select="issuing_bank/name"/>
                      </xsl:with-param>
														<xsl:with-param name="reportContent_line2">
                        <xsl:value-of select="issuing_bank/address_line_1"/>
                      </xsl:with-param>
														<xsl:with-param name="reportContent_line3">
                        <xsl:value-of select="issuing_bank/address_line_2"/>
                      </xsl:with-param>
														<xsl:with-param name="reportContent_line4">
                        <xsl:value-of select="issuing_bank/dom"/>
                      </xsl:with-param>
												</xsl:call-template>
												<xsl:call-template name="report_row">
														<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_BILL_OF_LADING_NO</xsl:with-param>
														<xsl:with-param name="reportContent_line1">
                        <xsl:value-of select="bol_number"/>
                      </xsl:with-param>
												</xsl:call-template>
												<xsl:call-template name="report_row">
														<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_PLACE_DATE_ISSUE</xsl:with-param>
														<xsl:with-param name="reportContent_line1">
                        <xsl:value-of select="iss_date"/>
                      </xsl:with-param>
														<xsl:with-param name="reportContent_line2">
                        <xsl:value-of select="place_of_issue"/>
                      </xsl:with-param>
												</xsl:call-template>
											</fo:table-body>
										</fo:table>
									</fo:table-cell>
								</fo:table-row>
								
								<!-- Second Row -->
								<fo:table-row keep-with-next="always">
									<fo:table-cell border-left="#7692B7 solid 1px" border-right="#7692B7 solid 1px">
										<fo:block>
											<fo:table>
												<fo:table-body start-indent="0pt">
													<xsl:call-template name="report_row">
														<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_NAME_ADDRESS_NOTIFY_PARTY</xsl:with-param>
														<xsl:with-param name="reportContent_line1">
                          <xsl:value-of select="notifyParty_name"/>
                        </xsl:with-param>
														<xsl:with-param name="reportContent_line2">
                          <xsl:value-of select="notifyParty_address_line_1"/>
                        </xsl:with-param>
														<xsl:with-param name="reportContent_line3">
                          <xsl:value-of select="notifyParty_address_line_2"/>
                        </xsl:with-param>
														<xsl:with-param name="reportContent_line4">
                          <xsl:value-of select="notifyParty_dom"/>
                        </xsl:with-param>
													</xsl:call-template>
												</fo:table-body>
											</fo:table>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell border-right="#7692B7 solid 1px">
										<fo:table>
											<fo:table-body start-indent="0pt">
												<xsl:call-template name="report_row">
														<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_PLACE_OF_RECEIPT</xsl:with-param>
														<xsl:with-param name="reportContent_line1">
                        <xsl:value-of select="place_of_receipt"/>
                      </xsl:with-param>
												</xsl:call-template>
											</fo:table-body>
										</fo:table>
									</fo:table-cell>
								</fo:table-row>
								
								<!-- Third Row start -->
								<fo:table-row keep-with-next="always">
									<fo:table-cell border-left="#7692B7 solid 1px" border-right="#7692B7 solid 1px">
										<fo:block>
											<fo:table>
												<fo:table-body start-indent="0pt">
													<fo:table-row>
														<fo:table-cell>
															<fo:block>
																<fo:table>
																	<fo:table-body start-indent="0pt">
																		<fo:table-row>
																			<fo:table-cell border-right="#7692B7 solid 1px">
																				<xsl:call-template name="report_section">
																						<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_VESSEL_VOYAGE_NO</xsl:with-param>
																						<xsl:with-param name="reportContent_line1"> </xsl:with-param>
																				</xsl:call-template>
																			</fo:table-cell>
																			<fo:table-cell>
																				<xsl:call-template name="report_section">
																						<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_PORT_OF_LOADING</xsl:with-param>
																						<xsl:with-param name="reportContent_line1">
                                        <xsl:value-of select="port_of_loading"/>
                                      </xsl:with-param>
																				</xsl:call-template>
																			</fo:table-cell>
																		</fo:table-row>
																		<fo:table-row>
																			<fo:table-cell border-right="#7692B7 solid 1px" number-columns-spanned="2">
																				<xsl:call-template name="report_section">
																							<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_PORT_OF_DISCHARGE</xsl:with-param>
																							<xsl:with-param name="reportContent_line1">
                                        <xsl:value-of select="port_of_discharge"/>
                                      </xsl:with-param>
																				</xsl:call-template>
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
									<fo:table-cell border-right="#7692B7 solid 1px">
										<fo:table>
											<fo:table-body start-indent="0pt">
												<xsl:call-template name="report_row">
															<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_PLACE_OF_DELIVERY</xsl:with-param>
															<xsl:with-param name="reportContent_line1">
                        <xsl:value-of select="place_of_delivery"/>
                      </xsl:with-param>
												</xsl:call-template>
											</fo:table-body>
										</fo:table>
									</fo:table-cell>
								</fo:table-row>
								<!-- Third Row End -->
								
								<!-- Fourth Row start -->
								<fo:table-row keep-with-next="always">
									<fo:table-cell border-left="#7692B7 solid 1px" border-right="#7692B7 solid 1px">
										<fo:block>
											<fo:table>
												<fo:table-body start-indent="0pt">
													<xsl:call-template name="report_row">
															<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_MARKS_NOS</xsl:with-param>
															<xsl:with-param name="reportContent_line1">   </xsl:with-param>
													</xsl:call-template>
												</fo:table-body>
											</fo:table>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell border-right="#7692B7 solid 1px">
										<fo:table>
											<fo:table-body start-indent="0pt">
												<xsl:call-template name="report_row">
															<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_NO_KIND_OF_PACKAGES</xsl:with-param>
															<xsl:with-param name="reportContent_line1"> </xsl:with-param>
															<xsl:with-param name="reportContent_line2"> </xsl:with-param>
															<xsl:with-param name="reportContent_line3"> </xsl:with-param>
												</xsl:call-template>
											</fo:table-body>
										</fo:table>
									</fo:table-cell>
								</fo:table-row>
								<!-- Fourth Row End -->
								
								<!-- Fifth Row Start -->
								<fo:table-row keep-with-next="always">
									<fo:table-cell border-left="#7692B7 solid 1px" border-right="#7692B7 solid 1px" number-columns-spanned="2">
										<fo:block>
											<fo:table>
												<fo:table-body start-indent="0pt">
													<xsl:call-template name="report_row">
															<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_ABOVE_PARTICULARS_AS_CONTAINED</xsl:with-param>
															<xsl:with-param name="reportTitleAlign">center</xsl:with-param>
															<xsl:with-param name="reportContent_line1">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_SG_INDEMNITY_PARTICULARS_LINE1')"/>
															</xsl:with-param>
															<xsl:with-param name="reportContent_line2">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_SG_INDEMNITY_PARTICULARS_LINE2')"/>
															</xsl:with-param>
															<xsl:with-param name="reportContent_line3">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_SG_INDEMNITY_PARTICULARS_LINE3')"/>
															</xsl:with-param>
															<xsl:with-param name="reportContent_line4">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_SG_INDEMNITY_PARTICULARS_LINE4')"/>
															</xsl:with-param>
															<xsl:with-param name="reportContent_line5">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_SG_INDEMNITY_PARTICULARS_LINE5')"/>
															</xsl:with-param>
															<xsl:with-param name="reportContent_line6">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_SG_INDEMNITY_PARTICULARS_LINE5')"/>
															</xsl:with-param>
													</xsl:call-template>
												</fo:table-body>
											</fo:table>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<!-- Fifth Row End -->
								
								<!-- Sixth Row start -->
								<fo:table-row keep-with-next="always">
									<fo:table-cell border-left="#7692B7 solid 1px" border-right="#7692B7 solid 1px" number-columns-spanned="2">
										<fo:block>
											<fo:table>
												<fo:table-body start-indent="0pt">
													<xsl:call-template name="report_row">
															<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_WE_JOIN_ABOVE_INDEMNITY</xsl:with-param>
															<xsl:with-param name="reportContent_line1">   </xsl:with-param>
													</xsl:call-template>
												</fo:table-body>
											</fo:table>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<!-- Sixth Row End -->
								
								<!-- Seventh Row Start -->
								<fo:table-row keep-with-next="always">
									<fo:table-cell border-left="#7692B7 solid 1px" border-right="#7692B7 solid 1px">
										<fo:block>
											<fo:table>
												<fo:table-body start-indent="0pt">
													<xsl:call-template name="report_row">
															<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_BANK_REF_NO</xsl:with-param>
															<xsl:with-param name="reportContent_line1">
                          <xsl:value-of select="bo_ref_id"/>
                        </xsl:with-param>
													</xsl:call-template>
												</fo:table-body>
											</fo:table>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell border-right="#7692B7 solid 1px">
										<fo:table>
											<fo:table-body start-indent="0pt">
												<xsl:call-template name="report_row">
															<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_SIGNATORS_COMPANY</xsl:with-param>
															<xsl:with-param name="reportContent_line1">   </xsl:with-param>
												</xsl:call-template>
											</fo:table-body>
										</fo:table>
									</fo:table-cell>
								</fo:table-row>
								<!-- Seventh Row End -->
								
								<!-- Eight Row Start-->
								<fo:table-row keep-with-next="always">
									<fo:table-cell border-left="#7692B7 solid 1px" border-right="#7692B7 solid 1px">
										<fo:block>
											<fo:table>
												<fo:table-body start-indent="0pt">
													<xsl:call-template name="report_row">
															<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_NAME_OF_BANK_SIGNATORY</xsl:with-param>
															<xsl:with-param name="reportContent_line1">   </xsl:with-param>
													</xsl:call-template>
												</fo:table-body>
											</fo:table>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell border-right="#7692B7 solid 1px">
										<fo:table>
											<fo:table-body start-indent="0pt">
												<xsl:call-template name="report_row">
															<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_NAME_OF_SIGNATORY</xsl:with-param>
															<xsl:with-param name="reportContent_line1">   </xsl:with-param>
												</xsl:call-template>
											</fo:table-body>
										</fo:table>
									</fo:table-cell>
								</fo:table-row>
								<!-- Eight Row End-->
								
								<!-- Nineth Row Start-->
								<fo:table-row keep-with-next="always">
									<fo:table-cell border-left="#7692B7 solid 1px" border-right="#7692B7 solid 1px">
										<fo:block>
											<fo:table>
												<fo:table-body start-indent="0pt">
													<xsl:call-template name="report_row">
															<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_DATE_21</xsl:with-param>
															<xsl:with-param name="reportContent_line1">   </xsl:with-param>
													</xsl:call-template>
												</fo:table-body>
											</fo:table>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell border-right="#7692B7 solid 1px">
										<fo:table>
											<fo:table-body start-indent="0pt">
												<xsl:call-template name="report_row">
															<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_DATE_22</xsl:with-param>
															<xsl:with-param name="reportContent_line1">   </xsl:with-param>
												</xsl:call-template>
											</fo:table-body>
										</fo:table>
									</fo:table-cell>
								</fo:table-row>
								<!-- Nineth Row End-->
								
								<!-- Tenth Row Start-->
								<fo:table-row keep-with-next="always">
									<fo:table-cell border-left="#7692B7 solid 1px" border-right="#7692B7 solid 1px">
										<fo:block>
											<fo:table>
												<fo:table-body start-indent="0pt">
													<xsl:call-template name="report_row">
															<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_DATE_23</xsl:with-param>
															<xsl:with-param name="reportContent_line1">   </xsl:with-param>
													</xsl:call-template>
												</fo:table-body>
											</fo:table>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell border-right="#7692B7 solid 1px">
										<fo:table>
											<fo:table-body start-indent="0pt">
												<xsl:call-template name="report_row">
															<xsl:with-param name="reportTitle">XSL_SG_INDEMNITY_DATE_24</xsl:with-param>
															<xsl:with-param name="reportContent_line1">   </xsl:with-param>
												</xsl:call-template>
											</fo:table-body>
										</fo:table>
									</fo:table-cell>
								</fo:table-row>
								<!-- Tenth Row End-->
								
								<!-- Eleventh Row Start -->
								<fo:table-row keep-with-next="always">
									<fo:table-cell border-left="#7692B7 solid 1px" border-right="#7692B7 solid 1px" number-columns-spanned="2">
										<fo:block border-bottom="#7692B7 solid 1px">
											<fo:table>
												<fo:table-body start-indent="0pt">
													<xsl:call-template name="report_row">
															<xsl:with-param name="reportTitle">BLANK_HEADER</xsl:with-param>
															<xsl:with-param name="reportConentFontSize">6</xsl:with-param>
															<xsl:with-param name="reportContent_line1">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_SG_INDEMNITY_TC_LINE1')"/>
															</xsl:with-param>
															<xsl:with-param name="reportContent_line2">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_SG_INDEMNITY_TC_LINE2')"/>
															</xsl:with-param>
															<xsl:with-param name="reportContent_line3">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_SG_INDEMNITY_TC_LINE3')"/>
															</xsl:with-param>
															<xsl:with-param name="reportContent_line4">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_SG_INDEMNITY_TC_LINE4')"/>
															</xsl:with-param>
															<xsl:with-param name="reportContent_line5">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_SG_INDEMNITY_TC_LINE5')"/>
															</xsl:with-param>
															<xsl:with-param name="reportContent_line6">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_SG_INDEMNITY_TC_LINE6')"/>
															</xsl:with-param>
													</xsl:call-template>
												</fo:table-body>
											</fo:table>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<!-- Eleventh Row End -->
							</fo:table-body>
						</fo:table>
					</fo:block>
				</fo:flow>
  </xsl:template>
  <xsl:template name="footer">
    <fo:static-content flow-name="xsl-region-after">
			<fo:block font-family="{$pdfFont}" font-size="8.0pt" keep-together="always">
				<fo:block color="{$footerFontColor}" text-align="start">
					<xsl:attribute name="end-indent">
	                                 	<xsl:value-of select="number($pdfMargin)"/>pt
	                                 </xsl:attribute>
					<xsl:value-of select="convertTools:internalDateToStringDate($systemDate,$language)"/>
				</fo:block>
			</fo:block>
		</fo:static-content>
  </xsl:template>
</xsl:stylesheet>
