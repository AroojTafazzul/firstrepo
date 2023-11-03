<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:altova="http://www.altova.com" xmlns:altovaext="http://www.altova.com/xslt-extensions" 
    xmlns:clitype="clitype" xmlns:fn="http://www.w3.org/2005/xpath-functions" 
    xmlns:iso4217="http://www.xbrl.org/2003/iso4217" xmlns:ix="http://www.xbrl.org/2008/inlineXBRL" 
    xmlns:java="java" xmlns:link="http://www.xbrl.org/2003/linkbase" xmlns:map="http://www.w3.org/2005/xpath-functions/map" 
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:sps="http://www.altova.com/StyleVision/user-xpath-functions" 
    xmlns:xbrldi="http://xbrl.org/2006/xbrldi" xmlns:xbrli="http://www.xbrl.org/2003/instance" xmlns:xlink="http://www.w3.org/1999/xlink" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:svg="http://www.w3.org/2000/svg"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
    exclude-result-prefixes="defaultresource localization altova altovaext clitype fn iso4217 ix java link map math sps xbrldi xbrli xlink xs xsi">
    <xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
    <xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
    <xsl:param name="base_url"/>
    <xsl:param name="systemDate"/>
    <!-- Get the language code -->
    <xsl:param name="language"/>
    <xsl:param name="rundata"/>
    
    <xsl:variable name="isdynamiclogo">
        <xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
    </xsl:variable>
    
    <xsl:param name="SV_OutputFormat" select="'PDF'"/>
	<xsl:variable name="XML" select="/"/>
	<xsl:variable name="fo:layout-master-set">
		<fo:layout-master-set>
			<fo:simple-page-master master-name="page-master-0-even" margin-left="0.60in" margin-right="0.60in" page-height="11in" page-width="8.50in" margin-top="0.30in" margin-bottom="0.30in">
				<fo:region-body margin-top="0.49in" margin-bottom="0.49in" column-count="1" column-gap="0.50in"/>
			</fo:simple-page-master>
			<fo:simple-page-master master-name="page-master-0-odd" margin-left="0.60in" margin-right="0.60in" page-height="11in" page-width="8.50in" margin-top="0.30in" margin-bottom="0.30in">
				<fo:region-body margin-top="0.49in" margin-bottom="0.49in" column-count="1" column-gap="0.50in"/>
			</fo:simple-page-master>
			<fo:page-sequence-master master-name="page-master-0">
				<fo:repeatable-page-master-alternatives>
					<fo:conditional-page-master-reference master-reference="page-master-0-even" odd-or-even="even"/>
					<fo:conditional-page-master-reference master-reference="page-master-0-odd" odd-or-even="odd"/>
				</fo:repeatable-page-master-alternatives>
			</fo:page-sequence-master>
		</fo:layout-master-set>
	</xsl:variable>
	<xsl:variable name="altova:nPxPerIn" select="96"/>
	
   <xsl:template match="/">
		<fo:root>
			<xsl:copy-of select="$fo:layout-master-set"/>
			<fo:declarations>
				<x:xmpmeta xmlns:x="adobe:ns:meta/">
					<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
						<rdf:Description rdf:about="" xmlns:xmp="http://ns.adobe.com/xap/1.0/">
							<xmp:CreatorTool>Altova StyleVision Enterprise Edition 2014 rel. 2 sp1 (http://www.altova.com)</xmp:CreatorTool>
						</rdf:Description>
					</rdf:RDF>
				</x:xmpmeta>
			</fo:declarations>
			<fo:page-sequence force-page-count="no-force" master-reference="page-master-0" initial-page-number="auto" format="1">
				<fo:flow flow-name="xsl-region-body">
					<fo:block>
						<fo:block/>
						<fo:block>
							<fo:leader leader-pattern="space"/>
						</fo:block>
						<fo:inline-container>
							<fo:block>
								<xsl:text>&#x200B;</xsl:text>
							</fo:block>
						</fo:inline-container>
						<fo:table table-layout="fixed" width="100%" border-spacing="2pt">
							<fo:table-column column-width="1.790in"/>
							<fo:table-column column-width="2.670in"/>
							<fo:table-column column-width="4.500in"/>
							<xsl:variable name="altova:CurrContextGrid_1" select="."/>
							<fo:table-body start-indent="0pt">
								<xsl:variable name="altova:tablerows">
									<fo:table-row font-size="0.10in">
										<fo:table-cell padding="2pt" display-align="before">
											<fo:block-container overflow="hidden">
												<fo:block text-align="left">
													<xsl:for-each select="$XML">
														<xsl:for-each select="BillTextHeader">
															<xsl:for-each select="BatchBill">
																<xsl:for-each select="BillForContacts">
																	<xsl:for-each select="BillForContact">
																		<xsl:for-each select="Borrower">
																			<xsl:for-each select="shortname">
																				<xsl:variable name="value-of-template_2">
																					<xsl:apply-templates/>
																				</xsl:variable>
																				<xsl:choose>
																					<xsl:when test="contains(string($value-of-template_2),'&#x200B;')">
																						<fo:block>
																							<xsl:copy-of select="$value-of-template_2"/>
																						</fo:block>
																					</xsl:when>
																					<xsl:otherwise>
																						<fo:inline>
																							<xsl:copy-of select="$value-of-template_2"/>
																						</fo:inline>
																					</xsl:otherwise>
																				</xsl:choose>
																			</xsl:for-each>
																		</xsl:for-each>
																	</xsl:for-each>
																</xsl:for-each>
															</xsl:for-each>
														</xsl:for-each>
													</xsl:for-each>
													<fo:block/>
													<fo:inline>
														<xsl:text>&#160;</xsl:text>
													</fo:inline>
													<fo:inline>
														<xsl:value-of select="/BillTextHeader/BatchBill/BillForContacts/BillForContact/BillingContact/CustomerAddress/line1"/>
													</fo:inline>
													<fo:block/>
													<fo:inline>
														<xsl:text>&#160;</xsl:text>
													</fo:inline>
													<fo:inline>
														<xsl:value-of select="/BillTextHeader/BatchBill/BillForContacts/BillForContact/BillingContact/CustomerAddress/line2"/>
													</fo:inline>
													<fo:block/>
													<fo:inline>
														<xsl:text>&#160;</xsl:text>
													</fo:inline>
													<fo:inline>
														<xsl:value-of select="/BillTextHeader/BatchBill/BillForContacts/BillForContact/BillingContact/CustomerAddress/line3"/>
													</fo:inline>
													<fo:block/>
													<fo:inline>
														<xsl:text>&#160;</xsl:text>
													</fo:inline>
													<fo:inline>
														<xsl:value-of select="concat(/BillTextHeader/BatchBill/BillForContacts/BillForContact/BillingContact/CustomerAddress/line4 ,  &apos; &apos;,/BillTextHeader/BatchBill/BillForContacts/BillForContact/BillingContact/CustomerAddress/line5, &apos; &apos;, /BillTextHeader/BatchBill/BillForContacts/BillForContact/BillingContact/CustomerAddress/line6)"/>
													</fo:inline>
													<fo:block/>
													<fo:inline>
														<xsl:text>&#160;</xsl:text>
													</fo:inline>
													<fo:inline>
														<xsl:value-of select="/BillTextHeader/BatchBill/BillForContacts/BillForContact/BillingContact/CustomerAddress/city"/>
													</fo:inline>
													<fo:inline>
														<xsl:text>&#160;</xsl:text>
													</fo:inline>
													<fo:inline>
														<xsl:value-of select="/BillTextHeader/BatchBill/BillForContacts/BillForContact/BillingContact/CustomerAddress/stateCode"/>
													</fo:inline>
													<fo:inline>
														<xsl:text>&#160;</xsl:text>
													</fo:inline>
													<fo:inline>
														<xsl:value-of select="/BillTextHeader/BatchBill/BillForContacts/BillForContact/BillingContact/CustomerAddress/zip"/>
													</fo:inline>
													<fo:block/>
													<xsl:for-each select="$XML">
														<xsl:for-each select="BillTextHeader">
															<xsl:for-each select="BatchBill">
																<xsl:for-each select="BillForContacts">
																	<xsl:for-each select="BillForContact">
																		<xsl:for-each select="BillingContact">
																			<xsl:for-each select="CustomerAddress">
																				<xsl:for-each select="countryCode">
																					<xsl:variable name="value-of-template_3">
																						<xsl:apply-templates/>
																					</xsl:variable>
																					<xsl:choose>
																						<xsl:when test="contains(string($value-of-template_3),'&#x200B;')">
																							<fo:block>
																								<xsl:copy-of select="$value-of-template_3"/>
																							</fo:block>
																						</xsl:when>
																						<xsl:otherwise>
																							<fo:inline>
																								<xsl:copy-of select="$value-of-template_3"/>
																							</fo:inline>
																						</xsl:otherwise>
																					</xsl:choose>
																				</xsl:for-each>
																			</xsl:for-each>
																		</xsl:for-each>
																	</xsl:for-each>
																</xsl:for-each>
															</xsl:for-each>
														</xsl:for-each>
													</xsl:for-each>
													<fo:block/>
													<fo:block>
														<fo:leader leader-pattern="space"/>
													</fo:block>
													<fo:block>
														<fo:leader leader-pattern="space"/>
													</fo:block>
													<fo:inline font-size="8pt">
														<xsl:text>Contact:&#160; </xsl:text>
													</fo:inline>
													<xsl:for-each select="$XML">
														<xsl:for-each select="BillTextHeader">
															<xsl:for-each select="BatchBill">
																<xsl:for-each select="BillForContacts">
																	<xsl:for-each select="BillForContact">
																		<xsl:for-each select="BillingContact">
																			<xsl:for-each select="nameFirst">
																				<xsl:variable name="value-of-template_4">
																					<xsl:apply-templates/>
																				</xsl:variable>
																				<xsl:choose>
																					<xsl:when test="contains(string($value-of-template_4),'&#x200B;')">
																						<fo:block font-size="8pt">
																							<xsl:copy-of select="$value-of-template_4"/>
																						</fo:block>
																					</xsl:when>
																					<xsl:otherwise>
																						<fo:inline font-size="8pt">
																							<xsl:copy-of select="$value-of-template_4"/>
																						</fo:inline>
																					</xsl:otherwise>
																				</xsl:choose>
																			</xsl:for-each>
																			<fo:inline font-size="8pt">
																				<xsl:text>&#160;</xsl:text>
																			</fo:inline>
																			<xsl:for-each select="nameLast">
																				<xsl:variable name="value-of-template_5">
																					<xsl:apply-templates/>
																				</xsl:variable>
																				<xsl:choose>
																					<xsl:when test="contains(string($value-of-template_5),'&#x200B;')">
																						<fo:block font-size="8pt">
																							<xsl:copy-of select="$value-of-template_5"/>
																						</fo:block>
																					</xsl:when>
																					<xsl:otherwise>
																						<fo:inline font-size="8pt">
																							<xsl:copy-of select="$value-of-template_5"/>
																						</fo:inline>
																					</xsl:otherwise>
																				</xsl:choose>
																			</xsl:for-each>
																		</xsl:for-each>
																	</xsl:for-each>
																</xsl:for-each>
															</xsl:for-each>
														</xsl:for-each>
													</xsl:for-each>
													<fo:block/>
													<fo:block>
														<fo:leader leader-pattern="space"/>
													</fo:block>
													<fo:inline font-size="8pt">
														<xsl:text>Phone:&#160;&#160; </xsl:text>
													</fo:inline>
													<xsl:for-each select="$XML">
														<xsl:for-each select="BillTextHeader">
															<xsl:for-each select="BatchBill">
																<xsl:for-each select="BillForContacts">
																	<xsl:for-each select="BillForContact">
																		<xsl:for-each select="BillingContact">
																			<xsl:for-each select="CustomerAddress">
																				<xsl:for-each select="phone">
																					<xsl:variable name="value-of-template_6">
																						<xsl:apply-templates/>
																					</xsl:variable>
																					<xsl:choose>
																						<xsl:when test="contains(string($value-of-template_6),'&#x200B;')">
																							<fo:block font-size="8pt">
																								<xsl:copy-of select="$value-of-template_6"/>
																							</fo:block>
																						</xsl:when>
																						<xsl:otherwise>
																							<fo:inline font-size="8pt">
																								<xsl:copy-of select="$value-of-template_6"/>
																							</fo:inline>
																						</xsl:otherwise>
																					</xsl:choose>
																				</xsl:for-each>
																			</xsl:for-each>
																		</xsl:for-each>
																	</xsl:for-each>
																</xsl:for-each>
															</xsl:for-each>
														</xsl:for-each>
													</xsl:for-each>
													<fo:block/>
													<fo:block>
														<fo:leader leader-pattern="space"/>
													</fo:block>
													<fo:block>
														<fo:leader leader-pattern="space"/>
													</fo:block>
													<fo:inline font-size="8pt">
														<xsl:text>Re:&#160;&#160;&#160;&#160;&#160;&#160; </xsl:text>
													</fo:inline>
													<xsl:for-each select="$XML">
														<xsl:for-each select="BillTextHeader">
															<xsl:for-each select="BatchBill">
																<xsl:for-each select="BillForContacts">
																	<xsl:for-each select="BillForContact">
																		<xsl:for-each select="Deal">
																			<xsl:for-each select="alias">
																				<xsl:variable name="value-of-template_7">
																					<xsl:apply-templates/>
																				</xsl:variable>
																				<xsl:choose>
																					<xsl:when test="contains(string($value-of-template_7),'&#x200B;')">
																						<fo:block font-size="8pt">
																							<xsl:copy-of select="$value-of-template_7"/>
																						</fo:block>
																					</xsl:when>
																					<xsl:otherwise>
																						<fo:inline font-size="8pt">
																							<xsl:copy-of select="$value-of-template_7"/>
																						</fo:inline>
																					</xsl:otherwise>
																				</xsl:choose>
																			</xsl:for-each>
																		</xsl:for-each>
																	</xsl:for-each>
																</xsl:for-each>
															</xsl:for-each>
														</xsl:for-each>
													</xsl:for-each>
												</fo:block>
											</fo:block-container>
										</fo:table-cell>
										<fo:table-cell padding="2pt" display-align="before">
											<fo:block-container overflow="hidden">
												<fo:block text-align="left">
													<fo:block>
														<fo:leader leader-pattern="space"/>
													</fo:block>
													<fo:block>
														<fo:leader leader-pattern="space"/>
													</fo:block>
													<fo:block>
														<fo:leader leader-pattern="space"/>
													</fo:block>
													<fo:block>
														<fo:leader leader-pattern="space"/>
													</fo:block>
													<fo:block>
														<fo:leader leader-pattern="space"/>
													</fo:block>
												</fo:block>
											</fo:block-container>
										</fo:table-cell>
										<fo:table-cell padding="2pt" display-align="before">
											<fo:block-container overflow="hidden">
												<fo:block text-align="right">
													<fo:inline-container>
														<fo:block>
															<xsl:text>&#x200B;</xsl:text>
														</fo:block>
													</fo:inline-container>
													<fo:table table-layout="fixed" width="100%" border="solid 1pt gray" border-spacing="2pt">
														<fo:table-column column-width="1.190in"/>
														<fo:table-column column-width="2in"/>
														<xsl:variable name="altova:CurrContextGrid_8" select="."/>
														<fo:table-body start-indent="0pt">
															<xsl:variable name="altova:tablerows">
																<fo:table-row font-size="0.10in" line-height="8.5px">
																	<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																		<fo:block-container overflow="hidden">
																			<fo:block text-align="left">
																				<fo:inline>
																					<xsl:text>Prepared Date</xsl:text>
																				</fo:inline>
																			</fo:block>
																		</fo:block-container>
																	</fo:table-cell>
																	<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																		<fo:block-container overflow="hidden">
																			<fo:block text-align="right">
																				<xsl:for-each select="$XML">
																					<xsl:for-each select="BillTextHeader">
																						<xsl:for-each select="BatchBill">
																							<xsl:for-each select="BillForContacts">
																								<xsl:for-each select="BillForContact">
																									<xsl:for-each select="datePrepared">
																										<xsl:for-each select="day">
																											<fo:inline>
																												<xsl:value-of select="format-number(number(string(.)), '00')"/>
																											</fo:inline>
																										</xsl:for-each>
																										<fo:inline>
																											<xsl:text>/</xsl:text>
																										</fo:inline>
																										<xsl:for-each select="month">
																											<fo:inline>
																												<xsl:value-of select="format-number(number(string(.)), '00')"/>
																											</fo:inline>
																										</xsl:for-each>
																										<fo:inline>
																											<xsl:text>/</xsl:text>
																										</fo:inline>
																										<xsl:for-each select="year">
																											<fo:inline>
																												<xsl:value-of select="format-number(number(string(.)), '0000')"/>
																											</fo:inline>
																										</xsl:for-each>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																						</xsl:for-each>
																					</xsl:for-each>
																				</xsl:for-each>
																			</fo:block>
																		</fo:block-container>
																	</fo:table-cell>
																</fo:table-row>
																<fo:table-row font-size="0.10in" line-height="8.5px">
																	<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																		<fo:block-container overflow="hidden">
																			<fo:block text-align="left">
																				<fo:inline font-size="8pt" font-weight="bold">
																					<xsl:text>Due Date</xsl:text>
																				</fo:inline>
																			</fo:block>
																		</fo:block-container>
																	</fo:table-cell>
																	<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																		<fo:block-container overflow="hidden">
																			<fo:block text-align="right">
																				<xsl:for-each select="BillTextHeader">
																					<xsl:for-each select="BatchBill">
																						<xsl:for-each select="BillForContacts">
																							<xsl:for-each select="BillForContact">
																								<xsl:for-each select="billDueDate">
																									<xsl:for-each select="month">
																										<fo:inline font-size="8pt">
																											<xsl:value-of select="format-number(number(string(.)), '00')"/>
																										</fo:inline>
																									</xsl:for-each>
																									<fo:inline font-size="8pt">
																										<xsl:text>/</xsl:text>
																									</fo:inline>
																									<xsl:for-each select="day">
																										<fo:inline font-size="8pt">
																											<xsl:value-of select="format-number(number(string(.)), '00')"/>
																										</fo:inline>
																									</xsl:for-each>
																									<fo:inline font-size="8pt">
																										<xsl:text>/</xsl:text>
																									</fo:inline>
																									<xsl:for-each select="year">
																										<fo:inline font-size="8pt">
																											<xsl:value-of select="format-number(number(string(.)), '0000')"/>
																										</fo:inline>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																						</xsl:for-each>
																					</xsl:for-each>
																				</xsl:for-each>
																				<fo:block/>
																			</fo:block>
																		</fo:block-container>
																	</fo:table-cell>
																</fo:table-row>
																<fo:table-row font-size="0.10in" line-height="8.5px">
																	<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																		<fo:block-container overflow="hidden">
																			<fo:block text-align="left">
																				<fo:inline font-size="8pt">
																					<xsl:text>Principal Due</xsl:text>
																				</fo:inline>
																				<fo:block/>
																			</fo:block>
																		</fo:block-container>
																	</fo:table-cell>
																	<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																		<fo:block-container overflow="hidden">
																			<fo:block text-align="right">
																				<xsl:for-each select="$XML">
																					<xsl:for-each select="BillTextHeader">
																						<xsl:for-each select="BatchBill">
																							<xsl:for-each select="BillForContacts">
																								<xsl:for-each select="BillForContact">
																									<xsl:for-each select="BillTotals">
																										<xsl:for-each select="principalDueAmount">
																											<fo:inline>
																												<xsl:value-of select="format-number(number(string(.)), '###,##0.00')"/>
																											</fo:inline>
																										</xsl:for-each>
																										<fo:inline>
																											<xsl:text>&#160;</xsl:text>
																										</fo:inline>
																										<xsl:for-each select="currency">
																											<xsl:variable name="value-of-template_16">
																												<xsl:apply-templates/>
																											</xsl:variable>
																											<xsl:choose>
																												<xsl:when test="contains(string($value-of-template_16),'&#x200B;')">
																													<fo:block>
																														<xsl:copy-of select="$value-of-template_16"/>
																													</fo:block>
																												</xsl:when>
																												<xsl:otherwise>
																													<fo:inline>
																														<xsl:copy-of select="$value-of-template_16"/>
																													</fo:inline>
																												</xsl:otherwise>
																											</xsl:choose>
																										</xsl:for-each>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																						</xsl:for-each>
																					</xsl:for-each>
																				</xsl:for-each>
																				<fo:block/>
																			</fo:block>
																		</fo:block-container>
																	</fo:table-cell>
																</fo:table-row>
																<fo:table-row font-size="0.10in" line-height="8.5px">
																	<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																		<fo:block-container overflow="hidden">
																			<fo:block text-align="left">
																				<fo:inline font-size="8pt">
																					<xsl:text>Balance Forward</xsl:text>
																				</fo:inline>
																			</fo:block>
																		</fo:block-container>
																	</fo:table-cell>
																	<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																		<fo:block-container overflow="hidden">
																			<fo:block text-align="right">
																				<xsl:for-each select="$XML">
																					<xsl:for-each select="BillTextHeader">
																						<xsl:for-each select="BatchBill">
																							<xsl:for-each select="BillForContacts">
																								<xsl:for-each select="BillForContact">
																									<xsl:for-each select="BillTotals">
																										<xsl:for-each select="balanceForwardAmount">
																											<fo:inline>
																												<xsl:value-of select="format-number(number(string(.)), '###,##0.00')"/>
																											</fo:inline>
																										</xsl:for-each>
																										<fo:inline>
																											<xsl:text>&#160;</xsl:text>
																										</fo:inline>
																										<xsl:for-each select="currency">
																											<xsl:variable name="value-of-template_18">
																												<xsl:apply-templates/>
																											</xsl:variable>
																											<xsl:choose>
																												<xsl:when test="contains(string($value-of-template_18),'&#x200B;')">
																													<fo:block>
																														<xsl:copy-of select="$value-of-template_18"/>
																													</fo:block>
																												</xsl:when>
																												<xsl:otherwise>
																													<fo:inline>
																														<xsl:copy-of select="$value-of-template_18"/>
																													</fo:inline>
																												</xsl:otherwise>
																											</xsl:choose>
																										</xsl:for-each>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																						</xsl:for-each>
																					</xsl:for-each>
																				</xsl:for-each>
																				<fo:block/>
																			</fo:block>
																		</fo:block-container>
																	</fo:table-cell>
																</fo:table-row>
																<fo:table-row font-size="0.10in" line-height="8.5px">
																	<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																		<fo:block-container overflow="hidden">
																			<fo:block text-align="left">
																				<fo:inline font-size="8pt">
																					<xsl:text>Interest Due</xsl:text>
																				</fo:inline>
																				<fo:block/>
																			</fo:block>
																		</fo:block-container>
																	</fo:table-cell>
																	<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																		<fo:block-container overflow="hidden">
																			<fo:block text-align="right">
																				<xsl:for-each select="$XML">
																					<xsl:for-each select="BillTextHeader">
																						<xsl:for-each select="BatchBill">
																							<xsl:for-each select="BillForContacts">
																								<xsl:for-each select="BillForContact">
																									<xsl:for-each select="BillTotals">
																										<xsl:for-each select="interestDueAmount">
																											<fo:inline>
																												<xsl:value-of select="format-number(number(string(.)), '###,##0.00')"/>
																											</fo:inline>
																										</xsl:for-each>
																										<fo:inline>
																											<xsl:text>&#160;</xsl:text>
																										</fo:inline>
																										<xsl:for-each select="currency">
																											<xsl:variable name="value-of-template_20">
																												<xsl:apply-templates/>
																											</xsl:variable>
																											<xsl:choose>
																												<xsl:when test="contains(string($value-of-template_20),'&#x200B;')">
																													<fo:block>
																														<xsl:copy-of select="$value-of-template_20"/>
																													</fo:block>
																												</xsl:when>
																												<xsl:otherwise>
																													<fo:inline>
																														<xsl:copy-of select="$value-of-template_20"/>
																													</fo:inline>
																												</xsl:otherwise>
																											</xsl:choose>
																										</xsl:for-each>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																						</xsl:for-each>
																					</xsl:for-each>
																				</xsl:for-each>
																				<fo:block/>
																			</fo:block>
																		</fo:block-container>
																	</fo:table-cell>
																</fo:table-row>
																<fo:table-row font-size="0.10in" line-height="8.5px">
																	<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																		<fo:block-container overflow="hidden">
																			<fo:block text-align="left">
																				<fo:inline font-size="8pt">
																					<xsl:text>Late Charges Due</xsl:text>
																				</fo:inline>
																			</fo:block>
																		</fo:block-container>
																	</fo:table-cell>
																	<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																		<fo:block-container overflow="hidden">
																			<fo:block text-align="right">
																				<xsl:for-each select="$XML">
																					<xsl:for-each select="BillTextHeader">
																						<xsl:for-each select="BatchBill">
																							<xsl:for-each select="BillForContacts">
																								<xsl:for-each select="BillForContact">
																									<xsl:for-each select="BillTotals">
																										<xsl:for-each select="lateChargeFeesDueAmount">
																											<fo:inline>
																												<xsl:value-of select="format-number(number(string(.)), '###,##0.00')"/>
																											</fo:inline>
																										</xsl:for-each>
																										<fo:inline>
																											<xsl:text>&#160; </xsl:text>
																										</fo:inline>
																										<xsl:for-each select="currency">
																											<xsl:variable name="value-of-template_22">
																												<xsl:apply-templates/>
																											</xsl:variable>
																											<xsl:choose>
																												<xsl:when test="contains(string($value-of-template_22),'&#x200B;')">
																													<fo:block>
																														<xsl:copy-of select="$value-of-template_22"/>
																													</fo:block>
																												</xsl:when>
																												<xsl:otherwise>
																													<fo:inline>
																														<xsl:copy-of select="$value-of-template_22"/>
																													</fo:inline>
																												</xsl:otherwise>
																											</xsl:choose>
																										</xsl:for-each>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																						</xsl:for-each>
																					</xsl:for-each>
																				</xsl:for-each>
																				<fo:block/>
																			</fo:block>
																		</fo:block-container>
																	</fo:table-cell>
																</fo:table-row>
																<fo:table-row font-size="0.10in" line-height="8.5px">
																	<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																		<fo:block-container overflow="hidden">
																			<fo:block text-align="left">
																				<fo:inline font-size="8pt">
																					<xsl:text>Other Fees Due</xsl:text>
																				</fo:inline>
																			</fo:block>
																		</fo:block-container>
																	</fo:table-cell>
																	<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																		<fo:block-container overflow="hidden">
																			<fo:block text-align="right">
																				<xsl:for-each select="$XML">
																					<xsl:for-each select="BillTextHeader">
																						<xsl:for-each select="BatchBill">
																							<xsl:for-each select="BillForContacts">
																								<xsl:for-each select="BillForContact">
																									<xsl:for-each select="BillTotals">
																										<xsl:for-each select="feesDueAmount">
																											<fo:inline>
																												<xsl:value-of select="format-number(number(string(.)), '###,##0.00')"/>
																											</fo:inline>
																										</xsl:for-each>
																										<fo:inline>
																											<xsl:text>&#160;</xsl:text>
																										</fo:inline>
																										<xsl:for-each select="currency">
																											<xsl:variable name="value-of-template_24">
																												<xsl:apply-templates/>
																											</xsl:variable>
																											<xsl:choose>
																												<xsl:when test="contains(string($value-of-template_24),'&#x200B;')">
																													<fo:block>
																														<xsl:copy-of select="$value-of-template_24"/>
																													</fo:block>
																												</xsl:when>
																												<xsl:otherwise>
																													<fo:inline>
																														<xsl:copy-of select="$value-of-template_24"/>
																													</fo:inline>
																												</xsl:otherwise>
																											</xsl:choose>
																										</xsl:for-each>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																						</xsl:for-each>
																					</xsl:for-each>
																				</xsl:for-each>
																				<fo:block/>
																			</fo:block>
																		</fo:block-container>
																	</fo:table-cell>
																</fo:table-row>
																<fo:table-row font-size="0.10in" line-height="8.5px">
																	<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																		<fo:block-container overflow="hidden">
																			<fo:block text-align="left">
																				<fo:inline font-size="8pt" font-weight="bold">
																					<xsl:text>Total Amount Due</xsl:text>
																				</fo:inline>
																				<fo:block/>
																			</fo:block>
																		</fo:block-container>
																	</fo:table-cell>
																	<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																		<fo:block-container overflow="hidden">
																			<fo:block text-align="right">
																				<xsl:for-each select="$XML">
																					<xsl:for-each select="BillTextHeader">
																						<xsl:for-each select="BatchBill">
																							<xsl:for-each select="BillForContacts">
																								<xsl:for-each select="BillForContact">
																									<xsl:for-each select="BillTotals">
																										<xsl:for-each select="totalDueAmount">
																											<fo:inline font-weight="bold">
																												<xsl:value-of select="format-number(number(string(.)), '###,##0.00')"/>
																											</fo:inline>
																										</xsl:for-each>
																										<fo:inline font-weight="bold">
																											<xsl:text>&#160;</xsl:text>
																										</fo:inline>
																										<xsl:for-each select="currency">
																											<xsl:variable name="value-of-template_26">
																												<xsl:apply-templates/>
																											</xsl:variable>
																											<xsl:choose>
																												<xsl:when test="contains(string($value-of-template_26),'&#x200B;')">
																													<fo:block font-weight="bold">
																														<xsl:copy-of select="$value-of-template_26"/>
																													</fo:block>
																												</xsl:when>
																												<xsl:otherwise>
																													<fo:inline font-weight="bold">
																														<xsl:copy-of select="$value-of-template_26"/>
																													</fo:inline>
																												</xsl:otherwise>
																											</xsl:choose>
																										</xsl:for-each>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																						</xsl:for-each>
																					</xsl:for-each>
																				</xsl:for-each>
																				<fo:block/>
																			</fo:block>
																		</fo:block-container>
																	</fo:table-cell>
																</fo:table-row>
															</xsl:variable>
															<xsl:choose>
																<xsl:when test="string($altova:tablerows)">
																	<xsl:copy-of select="$altova:tablerows"/>
																</xsl:when>
																<xsl:otherwise>
																	<fo:table-row>
																		<fo:table-cell>
																			<fo:block/>
																		</fo:table-cell>
																	</fo:table-row>
																</xsl:otherwise>
															</xsl:choose>
														</fo:table-body>
													</fo:table>
													<fo:block>
														<fo:leader leader-pattern="space"/>
													</fo:block>
												</fo:block>
											</fo:block-container>
										</fo:table-cell>
									</fo:table-row>
								</xsl:variable>
								<xsl:choose>
									<xsl:when test="string($altova:tablerows)">
										<xsl:copy-of select="$altova:tablerows"/>
									</xsl:when>
									<xsl:otherwise>
										<fo:table-row>
											<fo:table-cell>
												<fo:block/>
											</fo:table-cell>
										</fo:table-row>
									</xsl:otherwise>
								</xsl:choose>
							</fo:table-body>
						</fo:table>
						<fo:block>
							<fo:leader leader-pattern="space"/>
						</fo:block>
						<fo:block>
							<fo:leader leader-pattern="space"/>
						</fo:block>
						<fo:inline>
							<xsl:text>Please be advised that the following payments will be due on </xsl:text>
						</fo:inline>
						<xsl:for-each select="BillTextHeader">
							<xsl:for-each select="BatchBill">
								<xsl:for-each select="BillForContacts">
									<xsl:for-each select="BillForContact">
										<xsl:for-each select="billDueDate">
											<xsl:for-each select="day">
												<fo:inline font-size="10pt">
													<xsl:value-of select="format-number(number(string(.)), '00')"/>
												</fo:inline>
											</xsl:for-each>
											<fo:inline font-size="10pt">
												<xsl:text>/</xsl:text>
											</fo:inline>
											<xsl:for-each select="month">
												<fo:inline font-size="10pt">
													<xsl:value-of select="format-number(number(string(.)), '00')"/>
												</fo:inline>
											</xsl:for-each>
											<fo:inline font-size="10pt">
												<xsl:text>/</xsl:text>
											</fo:inline>
											<xsl:for-each select="year">
												<fo:inline font-size="10pt">
													<xsl:value-of select="format-number(number(string(.)), '0000')"/>
												</fo:inline>
											</xsl:for-each>
										</xsl:for-each>
									</xsl:for-each>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:for-each>
						<fo:block/>
						<fo:block>
							<fo:leader leader-pattern="space"/>
						</fo:block>
						<xsl:if test="/BillTextHeader/BatchBill/BillForContacts/BillForContact/BillAssociationOwners/BillAssociationOwner/BillAssociationsForOwner/BillAssociation/Accrual/AccrualCycle/@id != &apos;&apos;">
							<fo:inline>
								<xsl:text>Please see below the Accrual Details</xsl:text>
							</fo:inline>
							<fo:block/>
							<fo:inline-container>
								<fo:block>
									<xsl:text>&#x200B;</xsl:text>
								</fo:block>
							</fo:inline-container>
							<xsl:if test="$XML">
								<fo:table table-layout="fixed" width="100%" border="solid 1pt gray" border-spacing="2pt">
									<fo:table-column column-width="proportional-column-width(1)"/>
									<fo:table-column column-width="proportional-column-width(1)"/>
									<fo:table-column column-width="proportional-column-width(1)"/>
									<fo:table-column column-width="proportional-column-width(1)"/>
									<fo:table-column column-width="proportional-column-width(1)"/>
									<fo:table-column column-width="proportional-column-width(1)"/>
									<xsl:variable name="altova:CurrContextGrid_30" select="."/>
									<fo:table-header start-indent="0pt">
										<xsl:variable name="altova:tablerows">
											<fo:table-row>
												<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
													<fo:block-container overflow="hidden">
														<fo:block text-align="center">
															<fo:inline font-size="7pt" font-weight="bold">
																<xsl:text>Start Date</xsl:text>
															</fo:inline>
														</fo:block>
													</fo:block-container>
												</fo:table-cell>
												<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
													<fo:block-container overflow="hidden">
														<fo:block text-align="center">
															<fo:inline font-size="7pt" font-weight="bold">
																<xsl:text>End Date</xsl:text>
															</fo:inline>
														</fo:block>
													</fo:block-container>
												</fo:table-cell>
												<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
													<fo:block-container overflow="hidden">
														<fo:block text-align="center">
															<fo:inline font-size="7pt" font-weight="bold">
																<xsl:text>Number Of Days</xsl:text>
															</fo:inline>
														</fo:block>
													</fo:block-container>
												</fo:table-cell>
												<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
													<fo:block-container overflow="hidden">
														<fo:block text-align="center">
															<fo:inline font-size="7pt" font-weight="bold">
																<xsl:text>Balance</xsl:text>
															</fo:inline>
														</fo:block>
													</fo:block-container>
												</fo:table-cell>
												<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
													<fo:block-container overflow="hidden">
														<fo:block text-align="center">
															<fo:inline font-size="7pt" font-weight="bold">
																<xsl:text>Rate</xsl:text>
															</fo:inline>
														</fo:block>
													</fo:block-container>
												</fo:table-cell>
												<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
													<fo:block-container overflow="hidden">
														<fo:block text-align="center">
															<fo:inline font-size="7pt" font-weight="bold">
																<xsl:text>Accrued</xsl:text>
															</fo:inline>
														</fo:block>
													</fo:block-container>
												</fo:table-cell>
											</fo:table-row>
										</xsl:variable>
										<xsl:choose>
											<xsl:when test="string($altova:tablerows)">
												<xsl:copy-of select="$altova:tablerows"/>
											</xsl:when>
											<xsl:otherwise>
												<fo:table-row>
													<fo:table-cell>
														<fo:block/>
													</fo:table-cell>
												</fo:table-row>
											</xsl:otherwise>
										</xsl:choose>
									</fo:table-header>
									<fo:table-body start-indent="0pt">
										<xsl:variable name="altova:tablerows">
											<xsl:for-each select="$XML">
												<xsl:for-each select="BillTextHeader">
													<xsl:for-each select="BatchBill">
														<xsl:for-each select="BillForContacts">
															<xsl:for-each select="BillForContact">
																<xsl:for-each select="BillAssociationOwners">
																	<xsl:for-each select="BillAssociationOwner">
																		<xsl:for-each select="BillAssociationsForOwner">
																			<xsl:for-each select="BillAssociation">
																				<xsl:for-each select="Accrual">
																					<xsl:for-each select="AccrualLineItems">
																						<xsl:for-each select="AccrualLineItem">
																							<fo:table-row>
																								<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																									<fo:block-container overflow="hidden">
																										<fo:block text-align="center">
																											<xsl:for-each select="startDate">
																												<xsl:for-each select="day">
																													<fo:inline font-size="7pt">
																														<xsl:value-of select="format-number(number(string(.)), '00')"/>
																													</fo:inline>
																												</xsl:for-each>
																												<fo:inline font-size="7pt">
																													<xsl:text>/</xsl:text>
																												</fo:inline>
																												<xsl:for-each select="month">
																													<fo:inline font-size="7pt">
																														<xsl:value-of select="format-number(number(string(.)), '00')"/>
																													</fo:inline>
																												</xsl:for-each>
																												<fo:inline font-size="7pt">
																													<xsl:text>/</xsl:text>
																												</fo:inline>
																												<xsl:for-each select="year">
																													<fo:inline font-size="7pt">
																														<xsl:value-of select="format-number(number(string(.)), '0000')"/>
																													</fo:inline>
																												</xsl:for-each>
																											</xsl:for-each>
																										</fo:block>
																									</fo:block-container>
																								</fo:table-cell>
																								<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																									<fo:block-container overflow="hidden">
																										<fo:block text-align="center">
																											<xsl:for-each select="endDate">
																												<xsl:for-each select="day">
																													<fo:inline font-size="7pt">
																														<xsl:value-of select="format-number(number(string(.)), '00')"/>
																													</fo:inline>
																												</xsl:for-each>
																												<fo:inline font-size="7pt">
																													<xsl:text>/</xsl:text>
																												</fo:inline>
																												<xsl:for-each select="month">
																													<fo:inline font-size="7pt">
																														<xsl:value-of select="format-number(number(string(.)), '00')"/>
																													</fo:inline>
																												</xsl:for-each>
																												<fo:inline font-size="7pt">
																													<xsl:text>/</xsl:text>
																												</fo:inline>
																												<xsl:for-each select="year">
																													<fo:inline font-size="7pt">
																														<xsl:value-of select="format-number(number(string(.)), '0000')"/>
																													</fo:inline>
																												</xsl:for-each>
																											</xsl:for-each>
																										</fo:block>
																									</fo:block-container>
																								</fo:table-cell>
																								<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																									<fo:block-container overflow="hidden">
																										<fo:block text-align="center">
																											<xsl:for-each select="numberOfDays">
																												<xsl:variable name="value-of-template_37">
																													<xsl:apply-templates/>
																												</xsl:variable>
																												<xsl:choose>
																													<xsl:when test="contains(string($value-of-template_37),'&#x200B;')">
																														<fo:block font-size="7pt">
																															<xsl:copy-of select="$value-of-template_37"/>
																														</fo:block>
																													</xsl:when>
																													<xsl:otherwise>
																														<fo:inline font-size="7pt">
																															<xsl:copy-of select="$value-of-template_37"/>
																														</fo:inline>
																													</xsl:otherwise>
																												</xsl:choose>
																											</xsl:for-each>
																										</fo:block>
																									</fo:block-container>
																								</fo:table-cell>
																								<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																									<fo:block-container overflow="hidden">
																										<fo:block text-align="center">
																											<xsl:for-each select="amountBalance">
																												<fo:inline font-size="7pt">
																													<xsl:value-of select="format-number(number(string(.)), '###,##0.00')"/>
																												</fo:inline>
																											</xsl:for-each>
																										</fo:block>
																									</fo:block-container>
																								</fo:table-cell>
																								<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																									<fo:block-container overflow="hidden">
																										<fo:block text-align="center">
																											<xsl:for-each select="rate">
																												<xsl:variable name="value-of-template_39">
																													<xsl:apply-templates/>
																												</xsl:variable>
																												<xsl:choose>
																													<xsl:when test="contains(string($value-of-template_39),'&#x200B;')">
																														<fo:block>
																															<xsl:copy-of select="$value-of-template_39"/>
																														</fo:block>
																													</xsl:when>
																													<xsl:otherwise>
																														<fo:inline>
																															<xsl:copy-of select="$value-of-template_39"/>
																														</fo:inline>
																													</xsl:otherwise>
																												</xsl:choose>
																											</xsl:for-each>
																											<fo:inline font-size="7pt">
																												<xsl:value-of select="concat((/BillTextHeader/BatchBill/BillForContacts/BillForContact/BillAssociationOwners/BillAssociationOwner/BillAssociationsForOwner/BillAssociation/Accrual/AccrualLineItems/AccrualLineItem/accrualRate * 100), &apos;%&apos;)"/>
																											</fo:inline>
																										</fo:block>
																									</fo:block-container>
																								</fo:table-cell>
																								<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																									<fo:block-container overflow="hidden">
																										<fo:block text-align="center">
																											<xsl:for-each select="amountAccrued">
																												<fo:inline font-size="7pt">
																													<xsl:value-of select="format-number(number(string(.)), '###,##0.00')"/>
																												</fo:inline>
																											</xsl:for-each>
																										</fo:block>
																									</fo:block-container>
																								</fo:table-cell>
																							</fo:table-row>
																						</xsl:for-each>
																					</xsl:for-each>
																				</xsl:for-each>
																			</xsl:for-each>
																		</xsl:for-each>
																	</xsl:for-each>
																</xsl:for-each>
															</xsl:for-each>
														</xsl:for-each>
													</xsl:for-each>
												</xsl:for-each>
											</xsl:for-each>
										</xsl:variable>
										<xsl:choose>
											<xsl:when test="string($altova:tablerows)">
												<xsl:copy-of select="$altova:tablerows"/>
											</xsl:when>
											<xsl:otherwise>
												<fo:table-row>
													<fo:table-cell>
														<fo:block/>
													</fo:table-cell>
												</fo:table-row>
											</xsl:otherwise>
										</xsl:choose>
									</fo:table-body>
								</fo:table>
							</xsl:if>
						</xsl:if>
						<fo:block/>
						<fo:block>
							<fo:leader leader-pattern="space"/>
						</fo:block>
						<fo:inline>
							<xsl:text>Please see below the Loan Details</xsl:text>
						</fo:inline>
						<fo:block/>
						<fo:inline-container>
							<fo:block>
								<xsl:text>&#x200B;</xsl:text>
							</fo:block>
						</fo:inline-container>
						<xsl:if test="$XML">
							<fo:table table-layout="fixed" width="100%" border="solid 1pt gray" border-spacing="2pt">
								<fo:table-column column-width="proportional-column-width(1)"/>
								<fo:table-column column-width="proportional-column-width(1)"/>
								<fo:table-column column-width="proportional-column-width(1)"/>
								<fo:table-column column-width="proportional-column-width(1)"/>
								<fo:table-column column-width="proportional-column-width(1)"/>
								<fo:table-column column-width="proportional-column-width(1)"/>
								<fo:table-column column-width="proportional-column-width(1)"/>
								<fo:table-column column-width="proportional-column-width(1)"/>
								<fo:table-column column-width="proportional-column-width(1)"/>
								<fo:table-column column-width="proportional-column-width(1)"/>
								<fo:table-column column-width="proportional-column-width(1)"/>
								<fo:table-column column-width="proportional-column-width(1)"/>
								<fo:table-column column-width="proportional-column-width(1)"/>
								<xsl:variable name="altova:CurrContextGrid_41" select="."/>
								<fo:table-header start-indent="0pt">
									<xsl:variable name="altova:tablerows">
										<fo:table-row>
											<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
												<fo:block-container overflow="hidden">
													<fo:block text-align="left">
														<fo:inline font-size="7pt">
															<xsl:text>Accrual Period</xsl:text>
														</fo:inline>
													</fo:block>
												</fo:block-container>
											</fo:table-cell>
											<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
												<fo:block-container overflow="hidden">
													<fo:block text-align="left">
														<fo:inline font-size="7pt">
															<xsl:text>Borrower Name</xsl:text>
														</fo:inline>
													</fo:block>
												</fo:block-container>
											</fo:table-cell>
											<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
												<fo:block-container overflow="hidden">
													<fo:block text-align="left">
														<fo:inline font-size="7pt">
															<xsl:text>Currency</xsl:text>
														</fo:inline>
													</fo:block>
												</fo:block-container>
											</fo:table-cell>
											<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
												<fo:block-container overflow="hidden">
													<fo:block text-align="left">
														<fo:inline font-size="7pt">
															<xsl:text>Facility</xsl:text>
														</fo:inline>
													</fo:block>
												</fo:block-container>
											</fo:table-cell>
											<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
												<fo:block-container overflow="hidden">
													<fo:block text-align="left">
														<fo:inline font-size="7pt">
															<xsl:text>Pricing Option</xsl:text>
														</fo:inline>
													</fo:block>
												</fo:block-container>
											</fo:table-cell>
											<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
												<fo:block-container overflow="hidden">
													<fo:block text-align="left">
														<fo:inline font-size="7pt">
															<xsl:text>Repricing Date</xsl:text>
														</fo:inline>
													</fo:block>
												</fo:block-container>
											</fo:table-cell>
											<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
												<fo:block-container overflow="hidden">
													<fo:block text-align="left">
														<fo:inline font-size="7pt">
															<xsl:text>Repricing Frequency</xsl:text>
														</fo:inline>
													</fo:block>
												</fo:block-container>
											</fo:table-cell>
											<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
												<fo:block-container overflow="hidden">
													<fo:block text-align="left">
														<fo:inline font-size="7pt">
															<xsl:text>Rate Basis</xsl:text>
														</fo:inline>
													</fo:block>
												</fo:block-container>
											</fo:table-cell>
											<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
												<fo:block-container overflow="hidden">
													<fo:block text-align="left">
														<fo:inline font-size="7pt">
															<xsl:text>Balance Forward</xsl:text>
														</fo:inline>
													</fo:block>
												</fo:block-container>
											</fo:table-cell>
											<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
												<fo:block-container overflow="hidden">
													<fo:block text-align="left">
														<fo:inline font-size="7pt">
															<xsl:text>Principal Due </xsl:text>
														</fo:inline>
													</fo:block>
												</fo:block-container>
											</fo:table-cell>
											<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
												<fo:block-container overflow="hidden">
													<fo:block text-align="left">
														<fo:inline font-size="7pt">
															<xsl:text>Interest Due</xsl:text>
														</fo:inline>
													</fo:block>
												</fo:block-container>
											</fo:table-cell>
											<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
												<fo:block-container overflow="hidden">
													<fo:block text-align="left">
														<fo:inline font-size="7pt">
															<xsl:text>Fees Due</xsl:text>
														</fo:inline>
													</fo:block>
												</fo:block-container>
											</fo:table-cell>
											<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
												<fo:block-container overflow="hidden">
													<fo:block text-align="left">
														<fo:inline font-size="7pt" font-weight="bold">
															<xsl:text>Total Due</xsl:text>
														</fo:inline>
													</fo:block>
												</fo:block-container>
											</fo:table-cell>
										</fo:table-row>
									</xsl:variable>
									<xsl:choose>
										<xsl:when test="string($altova:tablerows)">
											<xsl:copy-of select="$altova:tablerows"/>
										</xsl:when>
										<xsl:otherwise>
											<fo:table-row>
												<fo:table-cell>
													<fo:block/>
												</fo:table-cell>
											</fo:table-row>
										</xsl:otherwise>
									</xsl:choose>
								</fo:table-header>
								<fo:table-body start-indent="0pt">
									<xsl:variable name="altova:tablerows">
										<xsl:for-each select="$XML">
											<xsl:for-each select="BillTextHeader">
												<xsl:for-each select="BatchBill">
													<xsl:for-each select="BillForContacts">
														<xsl:for-each select="BillForContact">
															<xsl:for-each select="BillAssociationOwners">
																<xsl:for-each select="BillAssociationOwner">
																	<xsl:for-each select="BillAssociationsForOwner">
																		<xsl:for-each select="BillAssociation">
																			<fo:table-row>
																				<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																					<fo:block-container overflow="hidden">
																						<fo:block text-align="left">
																							<fo:inline font-size="7pt">
																								<xsl:text>&#160;&#160;&#160; </xsl:text>
																							</fo:inline>
																							<xsl:for-each select="Outstanding">
																								<xsl:for-each select="Loan">
																									<xsl:for-each select="accrualPeriod">
																										<xsl:variable name="value-of-template_42">
																											<xsl:apply-templates/>
																										</xsl:variable>
																										<xsl:choose>
																											<xsl:when test="contains(string($value-of-template_42),'&#x200B;')">
																												<fo:block font-size="7pt">
																													<xsl:copy-of select="$value-of-template_42"/>
																												</fo:block>
																											</xsl:when>
																											<xsl:otherwise>
																												<fo:inline font-size="7pt">
																													<xsl:copy-of select="$value-of-template_42"/>
																												</fo:inline>
																											</xsl:otherwise>
																										</xsl:choose>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																							<fo:inline font-size="7pt">
																								<xsl:text>&#160;</xsl:text>
																							</fo:inline>
																							<xsl:for-each select="Outstanding">
																								<xsl:for-each select="SBLCGuarantee">
																									<xsl:for-each select="accrualPeriod">
																										<xsl:variable name="value-of-template_43">
																											<xsl:apply-templates/>
																										</xsl:variable>
																										<xsl:choose>
																											<xsl:when test="contains(string($value-of-template_43),'&#x200B;')">
																												<fo:block font-size="7pt">
																													<xsl:copy-of select="$value-of-template_43"/>
																												</fo:block>
																											</xsl:when>
																											<xsl:otherwise>
																												<fo:inline font-size="7pt">
																													<xsl:copy-of select="$value-of-template_43"/>
																												</fo:inline>
																											</xsl:otherwise>
																										</xsl:choose>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																							<xsl:for-each select="Outstanding">
																								<xsl:for-each select="BillofExchange">
																									<xsl:for-each select="accrualPeriod">
																										<xsl:variable name="value-of-template_44">
																											<xsl:apply-templates/>
																										</xsl:variable>
																										<xsl:choose>
																											<xsl:when test="contains(string($value-of-template_44),'&#x200B;')">
																												<fo:block font-size="7pt">
																													<xsl:copy-of select="$value-of-template_44"/>
																												</fo:block>
																											</xsl:when>
																											<xsl:otherwise>
																												<fo:inline font-size="7pt">
																													<xsl:copy-of select="$value-of-template_44"/>
																												</fo:inline>
																											</xsl:otherwise>
																										</xsl:choose>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																							<xsl:for-each select="IssuingBankContainer">
																								<xsl:for-each select="ibcAccrualPeriod">
																									<xsl:variable name="value-of-template_45">
																										<xsl:apply-templates/>
																									</xsl:variable>
																									<xsl:choose>
																										<xsl:when test="contains(string($value-of-template_45),'&#x200B;')">
																											<fo:block font-size="7pt">
																												<xsl:copy-of select="$value-of-template_45"/>
																											</fo:block>
																										</xsl:when>
																										<xsl:otherwise>
																											<fo:inline font-size="7pt">
																												<xsl:copy-of select="$value-of-template_45"/>
																											</fo:inline>
																										</xsl:otherwise>
																									</xsl:choose>
																								</xsl:for-each>
																							</xsl:for-each>
																						</fo:block>
																					</fo:block-container>
																				</fo:table-cell>
																				<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																					<fo:block-container overflow="hidden">
																						<fo:block text-align="left">
																							<xsl:for-each select="Outstanding">
																								<xsl:for-each select="Loan">
																									<xsl:for-each select="borrowerName">
																										<xsl:variable name="value-of-template_46">
																											<xsl:apply-templates/>
																										</xsl:variable>
																										<xsl:choose>
																											<xsl:when test="contains(string($value-of-template_46),'&#x200B;')">
																												<fo:block font-size="7pt">
																													<xsl:copy-of select="$value-of-template_46"/>
																												</fo:block>
																											</xsl:when>
																											<xsl:otherwise>
																												<fo:inline font-size="7pt">
																													<xsl:copy-of select="$value-of-template_46"/>
																												</fo:inline>
																											</xsl:otherwise>
																										</xsl:choose>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																							<fo:inline font-size="7pt">
																								<xsl:text>&#160;</xsl:text>
																							</fo:inline>
																							<xsl:for-each select="Outstanding">
																								<xsl:for-each select="SBLCGuarantee">
																									<xsl:for-each select="borrowerName">
																										<xsl:variable name="value-of-template_47">
																											<xsl:apply-templates/>
																										</xsl:variable>
																										<xsl:choose>
																											<xsl:when test="contains(string($value-of-template_47),'&#x200B;')">
																												<fo:block font-size="7pt">
																													<xsl:copy-of select="$value-of-template_47"/>
																												</fo:block>
																											</xsl:when>
																											<xsl:otherwise>
																												<fo:inline font-size="7pt">
																													<xsl:copy-of select="$value-of-template_47"/>
																												</fo:inline>
																											</xsl:otherwise>
																										</xsl:choose>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																							<xsl:for-each select="Outstanding">
																								<xsl:for-each select="BillofExchange">
																									<xsl:for-each select="borrowerName">
																										<xsl:variable name="value-of-template_48">
																											<xsl:apply-templates/>
																										</xsl:variable>
																										<xsl:choose>
																											<xsl:when test="contains(string($value-of-template_48),'&#x200B;')">
																												<fo:block font-size="7pt">
																													<xsl:copy-of select="$value-of-template_48"/>
																												</fo:block>
																											</xsl:when>
																											<xsl:otherwise>
																												<fo:inline font-size="7pt">
																													<xsl:copy-of select="$value-of-template_48"/>
																												</fo:inline>
																											</xsl:otherwise>
																										</xsl:choose>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																							<xsl:for-each select="IssuingBankContainer">
																								<xsl:for-each select="borrowerName">
																									<xsl:variable name="value-of-template_49">
																										<xsl:apply-templates/>
																									</xsl:variable>
																									<xsl:choose>
																										<xsl:when test="contains(string($value-of-template_49),'&#x200B;')">
																											<fo:block font-size="7pt">
																												<xsl:copy-of select="$value-of-template_49"/>
																											</fo:block>
																										</xsl:when>
																										<xsl:otherwise>
																											<fo:inline font-size="7pt">
																												<xsl:copy-of select="$value-of-template_49"/>
																											</fo:inline>
																										</xsl:otherwise>
																									</xsl:choose>
																								</xsl:for-each>
																							</xsl:for-each>
																						</fo:block>
																					</fo:block-container>
																				</fo:table-cell>
																				<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																					<fo:block-container overflow="hidden">
																						<fo:block text-align="left">
																							<xsl:for-each select="Outstanding">
																								<xsl:for-each select="Loan">
																									<xsl:for-each select="currency">
																										<xsl:variable name="value-of-template_50">
																											<xsl:apply-templates/>
																										</xsl:variable>
																										<xsl:choose>
																											<xsl:when test="contains(string($value-of-template_50),'&#x200B;')">
																												<fo:block font-size="7pt">
																													<xsl:copy-of select="$value-of-template_50"/>
																												</fo:block>
																											</xsl:when>
																											<xsl:otherwise>
																												<fo:inline font-size="7pt">
																													<xsl:copy-of select="$value-of-template_50"/>
																												</fo:inline>
																											</xsl:otherwise>
																										</xsl:choose>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																							<fo:inline font-size="7pt">
																								<xsl:text>&#160;</xsl:text>
																							</fo:inline>
																							<xsl:for-each select="Outstanding">
																								<xsl:for-each select="SBLCGuarantee">
																									<xsl:for-each select="DBColumn">
																										<xsl:variable name="value-of-template_51">
																											<xsl:apply-templates/>
																										</xsl:variable>
																										<xsl:choose>
																											<xsl:when test="contains(string($value-of-template_51),'&#x200B;')">
																												<fo:block font-size="7pt">
																													<xsl:copy-of select="$value-of-template_51"/>
																												</fo:block>
																											</xsl:when>
																											<xsl:otherwise>
																												<fo:inline font-size="7pt">
																													<xsl:copy-of select="$value-of-template_51"/>
																												</fo:inline>
																											</xsl:otherwise>
																										</xsl:choose>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																							<xsl:for-each select="Outstanding">
																								<xsl:for-each select="BillofExchange">
																									<xsl:for-each select="currency">
																										<xsl:variable name="value-of-template_52">
																											<xsl:apply-templates/>
																										</xsl:variable>
																										<xsl:choose>
																											<xsl:when test="contains(string($value-of-template_52),'&#x200B;')">
																												<fo:block font-size="7pt">
																													<xsl:copy-of select="$value-of-template_52"/>
																												</fo:block>
																											</xsl:when>
																											<xsl:otherwise>
																												<fo:inline font-size="7pt">
																													<xsl:copy-of select="$value-of-template_52"/>
																												</fo:inline>
																											</xsl:otherwise>
																										</xsl:choose>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																							<xsl:for-each select="IssuingBankContainer">
																								<xsl:for-each select="DBColumn">
																									<xsl:variable name="value-of-template_53">
																										<xsl:apply-templates/>
																									</xsl:variable>
																									<xsl:choose>
																										<xsl:when test="contains(string($value-of-template_53),'&#x200B;')">
																											<fo:block font-size="7pt">
																												<xsl:copy-of select="$value-of-template_53"/>
																											</fo:block>
																										</xsl:when>
																										<xsl:otherwise>
																											<fo:inline font-size="7pt">
																												<xsl:copy-of select="$value-of-template_53"/>
																											</fo:inline>
																										</xsl:otherwise>
																									</xsl:choose>
																								</xsl:for-each>
																							</xsl:for-each>
																						</fo:block>
																					</fo:block-container>
																				</fo:table-cell>
																				<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																					<fo:block-container overflow="hidden">
																						<fo:block text-align="left">
																							<xsl:for-each select="Outstanding">
																								<xsl:for-each select="Loan">
																									<xsl:for-each select="Facility">
																										<xsl:for-each select="FacilityName">
																											<xsl:variable name="value-of-template_54">
																												<xsl:apply-templates/>
																											</xsl:variable>
																											<xsl:choose>
																												<xsl:when test="contains(string($value-of-template_54),'&#x200B;')">
																													<fo:block font-size="7pt">
																														<xsl:copy-of select="$value-of-template_54"/>
																													</fo:block>
																												</xsl:when>
																												<xsl:otherwise>
																													<fo:inline font-size="7pt">
																														<xsl:copy-of select="$value-of-template_54"/>
																													</fo:inline>
																												</xsl:otherwise>
																											</xsl:choose>
																										</xsl:for-each>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																							<fo:inline font-size="7pt">
																								<xsl:text>&#160;</xsl:text>
																							</fo:inline>
																							<xsl:for-each select="Outstanding">
																								<xsl:for-each select="SBLCGuarantee">
																									<xsl:for-each select="Facility">
																										<xsl:for-each select="FacilityName">
																											<xsl:variable name="value-of-template_55">
																												<xsl:apply-templates/>
																											</xsl:variable>
																											<xsl:choose>
																												<xsl:when test="contains(string($value-of-template_55),'&#x200B;')">
																													<fo:block font-size="7pt">
																														<xsl:copy-of select="$value-of-template_55"/>
																													</fo:block>
																												</xsl:when>
																												<xsl:otherwise>
																													<fo:inline font-size="7pt">
																														<xsl:copy-of select="$value-of-template_55"/>
																													</fo:inline>
																												</xsl:otherwise>
																											</xsl:choose>
																										</xsl:for-each>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																							<xsl:for-each select="IssuingBankContainer">
																								<xsl:for-each select="Facility">
																									<xsl:for-each select="FacilityName">
																										<xsl:variable name="value-of-template_56">
																											<xsl:apply-templates/>
																										</xsl:variable>
																										<xsl:choose>
																											<xsl:when test="contains(string($value-of-template_56),'&#x200B;')">
																												<fo:block font-size="7pt">
																													<xsl:copy-of select="$value-of-template_56"/>
																												</fo:block>
																											</xsl:when>
																											<xsl:otherwise>
																												<fo:inline font-size="7pt">
																													<xsl:copy-of select="$value-of-template_56"/>
																												</fo:inline>
																											</xsl:otherwise>
																										</xsl:choose>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																						</fo:block>
																					</fo:block-container>
																				</fo:table-cell>
																				<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																					<fo:block-container overflow="hidden">
																						<fo:block text-align="left">
																							<xsl:for-each select="Outstanding">
																								<xsl:for-each select="Loan">
																									<xsl:for-each select="pricingOption">
																										<xsl:variable name="value-of-template_57">
																											<xsl:apply-templates/>
																										</xsl:variable>
																										<xsl:choose>
																											<xsl:when test="contains(string($value-of-template_57),'&#x200B;')">
																												<fo:block font-size="7pt">
																													<xsl:copy-of select="$value-of-template_57"/>
																												</fo:block>
																											</xsl:when>
																											<xsl:otherwise>
																												<fo:inline font-size="7pt">
																													<xsl:copy-of select="$value-of-template_57"/>
																												</fo:inline>
																											</xsl:otherwise>
																										</xsl:choose>
																									</xsl:for-each>
																									<fo:inline font-size="7pt">
																										<xsl:text>&#160;</xsl:text>
																									</fo:inline>
																									<xsl:for-each select="alias">
																										<xsl:variable name="value-of-template_58">
																											<xsl:apply-templates/>
																										</xsl:variable>
																										<xsl:choose>
																											<xsl:when test="contains(string($value-of-template_58),'&#x200B;')">
																												<fo:block font-size="7pt">
																													<xsl:copy-of select="$value-of-template_58"/>
																												</fo:block>
																											</xsl:when>
																											<xsl:otherwise>
																												<fo:inline font-size="7pt">
																													<xsl:copy-of select="$value-of-template_58"/>
																												</fo:inline>
																											</xsl:otherwise>
																										</xsl:choose>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																							<fo:inline font-size="7pt">
																								<xsl:text>&#160;</xsl:text>
																							</fo:inline>
																							<xsl:for-each select="Outstanding">
																								<xsl:for-each select="SBLCGuarantee">
																									<xsl:for-each select="PricingOption">
																										<xsl:for-each select="pricingOptionDescription">
																											<xsl:variable name="value-of-template_59">
																												<xsl:apply-templates/>
																											</xsl:variable>
																											<xsl:choose>
																												<xsl:when test="contains(string($value-of-template_59),'&#x200B;')">
																													<fo:block font-size="7pt">
																														<xsl:copy-of select="$value-of-template_59"/>
																													</fo:block>
																												</xsl:when>
																												<xsl:otherwise>
																													<fo:inline font-size="7pt">
																														<xsl:copy-of select="$value-of-template_59"/>
																													</fo:inline>
																												</xsl:otherwise>
																											</xsl:choose>
																										</xsl:for-each>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																							<xsl:for-each select="Outstanding">
																								<xsl:for-each select="BillofExchange">
																									<xsl:for-each select="Facility">
																										<xsl:for-each select="FacilityName">
																											<xsl:variable name="value-of-template_60">
																												<xsl:apply-templates/>
																											</xsl:variable>
																											<xsl:choose>
																												<xsl:when test="contains(string($value-of-template_60),'&#x200B;')">
																													<fo:block font-size="7pt">
																														<xsl:copy-of select="$value-of-template_60"/>
																													</fo:block>
																												</xsl:when>
																												<xsl:otherwise>
																													<fo:inline font-size="7pt">
																														<xsl:copy-of select="$value-of-template_60"/>
																													</fo:inline>
																												</xsl:otherwise>
																											</xsl:choose>
																										</xsl:for-each>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																							<xsl:for-each select="IssuingBankContainer">
																								<xsl:for-each select="pricingOption">
																									<xsl:variable name="value-of-template_61">
																										<xsl:apply-templates/>
																									</xsl:variable>
																									<xsl:choose>
																										<xsl:when test="contains(string($value-of-template_61),'&#x200B;')">
																											<fo:block font-size="7pt">
																												<xsl:copy-of select="$value-of-template_61"/>
																											</fo:block>
																										</xsl:when>
																										<xsl:otherwise>
																											<fo:inline font-size="7pt">
																												<xsl:copy-of select="$value-of-template_61"/>
																											</fo:inline>
																										</xsl:otherwise>
																									</xsl:choose>
																								</xsl:for-each>
																							</xsl:for-each>
																						</fo:block>
																					</fo:block-container>
																				</fo:table-cell>
																				<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																					<fo:block-container overflow="hidden">
																						<fo:block text-align="left">
																							<xsl:for-each select="Outstanding">
																								<xsl:for-each select="Loan">
																									<xsl:for-each select="Repricing">
																										<xsl:for-each select="date">
																											<xsl:for-each select="day">
																												<fo:inline font-size="7pt">
																													<xsl:value-of select="format-number(number(string(.)), '00')"/>
																												</fo:inline>
																											</xsl:for-each>
																											<fo:inline font-size="7pt">
																												<xsl:text>/</xsl:text>
																											</fo:inline>
																											<xsl:for-each select="month">
																												<fo:inline font-size="7pt">
																													<xsl:value-of select="format-number(number(string(.)), '00')"/>
																												</fo:inline>
																											</xsl:for-each>
																											<fo:inline font-size="7pt">
																												<xsl:text>/</xsl:text>
																											</fo:inline>
																											<xsl:for-each select="year">
																												<fo:inline font-size="7pt">
																													<xsl:value-of select="format-number(number(string(.)), '0000')"/>
																												</fo:inline>
																											</xsl:for-each>
																										</xsl:for-each>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																						</fo:block>
																					</fo:block-container>
																				</fo:table-cell>
																				<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																					<fo:block-container overflow="hidden">
																						<fo:block text-align="left">
																							<xsl:for-each select="Outstanding">
																								<xsl:for-each select="Loan">
																									<xsl:for-each select="Repricing">
																										<xsl:for-each select="frequency">
																											<xsl:variable name="value-of-template_65">
																												<xsl:apply-templates/>
																											</xsl:variable>
																											<xsl:choose>
																												<xsl:when test="contains(string($value-of-template_65),'&#x200B;')">
																													<fo:block font-size="7pt">
																														<xsl:copy-of select="$value-of-template_65"/>
																													</fo:block>
																												</xsl:when>
																												<xsl:otherwise>
																													<fo:inline font-size="7pt">
																														<xsl:copy-of select="$value-of-template_65"/>
																													</fo:inline>
																												</xsl:otherwise>
																											</xsl:choose>
																										</xsl:for-each>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																						</fo:block>
																					</fo:block-container>
																				</fo:table-cell>
																				<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																					<fo:block-container overflow="hidden">
																						<fo:block text-align="left">
																							<xsl:for-each select="Outstanding">
																								<xsl:for-each select="Loan">
																									<xsl:for-each select="rateBasis">
																										<xsl:variable name="value-of-template_66">
																											<xsl:apply-templates/>
																										</xsl:variable>
																										<xsl:choose>
																											<xsl:when test="contains(string($value-of-template_66),'&#x200B;')">
																												<fo:block font-size="7pt">
																													<xsl:copy-of select="$value-of-template_66"/>
																												</fo:block>
																											</xsl:when>
																											<xsl:otherwise>
																												<fo:inline font-size="7pt">
																													<xsl:copy-of select="$value-of-template_66"/>
																												</fo:inline>
																											</xsl:otherwise>
																										</xsl:choose>
																									</xsl:for-each>
																								</xsl:for-each>
																							</xsl:for-each>
																						</fo:block>
																					</fo:block-container>
																				</fo:table-cell>
																				<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																					<fo:block-container overflow="hidden">
																						<fo:block text-align="left">
																							<xsl:for-each select="BillAssociationTotals">
																								<xsl:for-each select="balanceForwardAmount">
																									<fo:inline font-size="7pt">
																										<xsl:value-of select="format-number(number(string(.)), '###,##0.00')"/>
																									</fo:inline>
																								</xsl:for-each>
																							</xsl:for-each>
																						</fo:block>
																					</fo:block-container>
																				</fo:table-cell>
																				<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																					<fo:block-container overflow="hidden">
																						<fo:block text-align="left">
																							<xsl:for-each select="BillAssociationTotals">
																								<xsl:for-each select="principalDueAmount">
																									<fo:inline font-size="7pt">
																										<xsl:value-of select="format-number(number(string(.)), '###,##0.00')"/>
																									</fo:inline>
																								</xsl:for-each>
																							</xsl:for-each>
																						</fo:block>
																					</fo:block-container>
																				</fo:table-cell>
																				<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																					<fo:block-container overflow="hidden">
																						<fo:block text-align="left">
																							<xsl:for-each select="BillAssociationTotals">
																								<xsl:for-each select="interestDueAmount">
																									<fo:inline font-size="7pt">
																										<xsl:value-of select="format-number(number(string(.)), '###,##0.00')"/>
																									</fo:inline>
																								</xsl:for-each>
																							</xsl:for-each>
																						</fo:block>
																					</fo:block-container>
																				</fo:table-cell>
																				<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																					<fo:block-container overflow="hidden">
																						<fo:block text-align="left">
																							<xsl:for-each select="BillAssociationTotals">
																								<xsl:for-each select="feesDueAmount">
																									<xsl:variable name="value-of-template_70">
																										<xsl:apply-templates/>
																									</xsl:variable>
																									<xsl:choose>
																										<xsl:when test="contains(string($value-of-template_70),'&#x200B;')">
																											<fo:block font-size="7pt">
																												<xsl:copy-of select="$value-of-template_70"/>
																											</fo:block>
																										</xsl:when>
																										<xsl:otherwise>
																											<fo:inline font-size="7pt">
																												<xsl:copy-of select="$value-of-template_70"/>
																											</fo:inline>
																										</xsl:otherwise>
																									</xsl:choose>
																								</xsl:for-each>
																							</xsl:for-each>
																						</fo:block>
																					</fo:block-container>
																				</fo:table-cell>
																				<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																					<fo:block-container overflow="hidden">
																						<fo:block text-align="left">
																							<xsl:for-each select="BillAssociationTotals">
																								<xsl:for-each select="dueAmount">
																									<fo:inline font-size="7pt" font-weight="bold">
																										<xsl:value-of select="format-number(number(string(.)), '###,##0.00')"/>
																									</fo:inline>
																								</xsl:for-each>
																							</xsl:for-each>
																						</fo:block>
																					</fo:block-container>
																				</fo:table-cell>
																			</fo:table-row>
																		</xsl:for-each>
																	</xsl:for-each>
																</xsl:for-each>
															</xsl:for-each>
														</xsl:for-each>
													</xsl:for-each>
												</xsl:for-each>
											</xsl:for-each>
										</xsl:for-each>
									</xsl:variable>
									<xsl:choose>
										<xsl:when test="string($altova:tablerows)">
											<xsl:copy-of select="$altova:tablerows"/>
										</xsl:when>
										<xsl:otherwise>
											<fo:table-row>
												<fo:table-cell>
													<fo:block/>
												</fo:table-cell>
											</fo:table-row>
										</xsl:otherwise>
									</xsl:choose>
								</fo:table-body>
							</fo:table>
						</xsl:if>
						<fo:block>
							<fo:leader leader-pattern="space"/>
						</fo:block>
						<fo:block>
							<fo:leader leader-pattern="space"/>
						</fo:block>
						<fo:inline>
							<xsl:text>For Billing inquiries contact: </xsl:text>
						</fo:inline>
						<xsl:for-each select="$XML">
							<xsl:for-each select="BillTextHeader">
								<xsl:for-each select="BatchBill">
									<xsl:for-each select="BillForContacts">
										<xsl:for-each select="BillForContact">
											<xsl:for-each select="AgentContact">
												<xsl:for-each select="namePrefix">
													<xsl:variable name="value-of-template_72">
														<xsl:apply-templates/>
													</xsl:variable>
													<xsl:choose>
														<xsl:when test="contains(string($value-of-template_72),'&#x200B;')">
															<fo:block>
																<xsl:copy-of select="$value-of-template_72"/>
															</fo:block>
														</xsl:when>
														<xsl:otherwise>
															<fo:inline>
																<xsl:copy-of select="$value-of-template_72"/>
															</fo:inline>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:for-each>
												<fo:inline>
													<xsl:text>&#160;</xsl:text>
												</fo:inline>
												<xsl:for-each select="nameFirst">
													<xsl:variable name="value-of-template_73">
														<xsl:apply-templates/>
													</xsl:variable>
													<xsl:choose>
														<xsl:when test="contains(string($value-of-template_73),'&#x200B;')">
															<fo:block>
																<xsl:copy-of select="$value-of-template_73"/>
															</fo:block>
														</xsl:when>
														<xsl:otherwise>
															<fo:inline>
																<xsl:copy-of select="$value-of-template_73"/>
															</fo:inline>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:for-each>
												<fo:inline>
													<xsl:text>&#160;</xsl:text>
												</fo:inline>
												<xsl:for-each select="nameLast">
													<xsl:variable name="value-of-template_74">
														<xsl:apply-templates/>
													</xsl:variable>
													<xsl:choose>
														<xsl:when test="contains(string($value-of-template_74),'&#x200B;')">
															<fo:block>
																<xsl:copy-of select="$value-of-template_74"/>
															</fo:block>
														</xsl:when>
														<xsl:otherwise>
															<fo:inline>
																<xsl:copy-of select="$value-of-template_74"/>
															</fo:inline>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:for-each>
											</xsl:for-each>
										</xsl:for-each>
									</xsl:for-each>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:for-each>
						<fo:block/>
						<fo:block>
							<fo:leader leader-pattern="space"/>
						</fo:block>
						<xsl:choose>
							<xsl:when test="/BillTextHeader/BatchBill/BillForContacts/PrincipalRemittanceInstruction/@id !=&apos;&apos;">
								<fo:block>
									<fo:leader leader-pattern="space"/>
								</fo:block>
								<fo:inline font-size="10pt">
									<xsl:text>Please transfer the funds as below</xsl:text>
								</fo:inline>
								<fo:block/>
								<fo:inline-container>
									<fo:block>
										<xsl:text>&#x200B;</xsl:text>
									</fo:block>
								</fo:inline-container>
								<xsl:if test="$XML">
									<fo:table table-layout="fixed" width="100%" border="solid 1pt gray" border-spacing="2pt">
										<fo:table-column column-width="proportional-column-width(1)"/>
										<fo:table-column column-width="proportional-column-width(1)"/>
										<fo:table-column column-width="proportional-column-width(1)"/>
										<xsl:variable name="altova:CurrContextGrid_75" select="."/>
										<fo:table-header start-indent="0pt">
											<xsl:variable name="altova:tablerows">
												<fo:table-row>
													<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
														<fo:block-container overflow="hidden">
															<fo:block text-align="left">
																<fo:inline font-size="7pt">
																	<xsl:text>Book Transfer Account</xsl:text>
																</fo:inline>
															</fo:block>
														</fo:block-container>
													</fo:table-cell>
													<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
														<fo:block-container overflow="hidden">
															<fo:block text-align="left">
																<fo:inline font-size="7pt">
																	<xsl:text>Bank To Bank Instruction</xsl:text>
																</fo:inline>
															</fo:block>
														</fo:block-container>
													</fo:table-cell>
													<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
														<fo:block-container overflow="hidden">
															<fo:block text-align="left">
																<fo:inline font-size="7pt">
																	<xsl:text>Beneficiary Instruction</xsl:text>
																</fo:inline>
															</fo:block>
														</fo:block-container>
													</fo:table-cell>
												</fo:table-row>
											</xsl:variable>
											<xsl:choose>
												<xsl:when test="string($altova:tablerows)">
													<xsl:copy-of select="$altova:tablerows"/>
												</xsl:when>
												<xsl:otherwise>
													<fo:table-row>
														<fo:table-cell>
															<fo:block/>
														</fo:table-cell>
													</fo:table-row>
												</xsl:otherwise>
											</xsl:choose>
										</fo:table-header>
										<fo:table-body start-indent="0pt">
											<xsl:variable name="altova:tablerows">
												<xsl:for-each select="$XML">
													<xsl:for-each select="BillTextHeader">
														<xsl:for-each select="BatchBill">
															<xsl:for-each select="BillForContacts">
																<xsl:for-each select="BillForContact">
																	<xsl:for-each select="RemittanceInstructions">
																		<xsl:for-each select="PrincipalRemittanceInstruction">
																			<xsl:for-each select="BookPaymentInstruction">
																				<fo:table-row>
																					<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																						<fo:block-container overflow="hidden">
																							<fo:block text-align="left">
																								<xsl:for-each select="bookTransferAccount">
																									<xsl:variable name="value-of-template_76">
																										<xsl:apply-templates/>
																									</xsl:variable>
																									<xsl:choose>
																										<xsl:when test="contains(string($value-of-template_76),'&#x200B;')">
																											<fo:block font-size="7pt">
																												<xsl:copy-of select="$value-of-template_76"/>
																											</fo:block>
																										</xsl:when>
																										<xsl:otherwise>
																											<fo:inline font-size="7pt">
																												<xsl:copy-of select="$value-of-template_76"/>
																											</fo:inline>
																										</xsl:otherwise>
																									</xsl:choose>
																								</xsl:for-each>
																							</fo:block>
																						</fo:block-container>
																					</fo:table-cell>
																					<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																						<fo:block-container overflow="hidden">
																							<fo:block text-align="left">
																								<xsl:for-each select="bankToBankInstruction">
																									<xsl:variable name="value-of-template_77">
																										<xsl:apply-templates/>
																									</xsl:variable>
																									<xsl:choose>
																										<xsl:when test="contains(string($value-of-template_77),'&#x200B;')">
																											<fo:block font-size="7pt">
																												<xsl:copy-of select="$value-of-template_77"/>
																											</fo:block>
																										</xsl:when>
																										<xsl:otherwise>
																											<fo:inline font-size="7pt">
																												<xsl:copy-of select="$value-of-template_77"/>
																											</fo:inline>
																										</xsl:otherwise>
																									</xsl:choose>
																								</xsl:for-each>
																							</fo:block>
																						</fo:block-container>
																					</fo:table-cell>
																					<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																						<fo:block-container overflow="hidden">
																							<fo:block text-align="left">
																								<xsl:for-each select="beneficiaryInstruction">
																									<xsl:variable name="value-of-template_78">
																										<xsl:apply-templates/>
																									</xsl:variable>
																									<xsl:choose>
																										<xsl:when test="contains(string($value-of-template_78),'&#x200B;')">
																											<fo:block font-size="7pt">
																												<xsl:copy-of select="$value-of-template_78"/>
																											</fo:block>
																										</xsl:when>
																										<xsl:otherwise>
																											<fo:inline font-size="7pt">
																												<xsl:copy-of select="$value-of-template_78"/>
																											</fo:inline>
																										</xsl:otherwise>
																									</xsl:choose>
																								</xsl:for-each>
																							</fo:block>
																						</fo:block-container>
																					</fo:table-cell>
																				</fo:table-row>
																			</xsl:for-each>
																		</xsl:for-each>
																	</xsl:for-each>
																</xsl:for-each>
															</xsl:for-each>
														</xsl:for-each>
													</xsl:for-each>
												</xsl:for-each>
											</xsl:variable>
											<xsl:choose>
												<xsl:when test="string($altova:tablerows)">
													<xsl:copy-of select="$altova:tablerows"/>
												</xsl:when>
												<xsl:otherwise>
													<fo:table-row>
														<fo:table-cell>
															<fo:block/>
														</fo:table-cell>
													</fo:table-row>
												</xsl:otherwise>
											</xsl:choose>
										</fo:table-body>
									</fo:table>
								</xsl:if>
							</xsl:when>
							<xsl:when test="/BillTextHeader/BatchBill/BillForContacts/BillForContact/RemittanceInstructions/SingleRemittanceInstruction/@id != &apos;&apos;">
								<fo:block>
									<fo:leader leader-pattern="space"/>
								</fo:block>
								<fo:inline font-size="10pt">
									<xsl:text>Please transfer the funds as below</xsl:text>
								</fo:inline>
								<fo:block/>
								<fo:inline-container>
									<fo:block>
										<xsl:text>&#x200B;</xsl:text>
									</fo:block>
								</fo:inline-container>
								<xsl:if test="$XML">
									<fo:table table-layout="fixed" width="100%" border="solid 1pt gray" border-spacing="2pt">
										<fo:table-column column-width="proportional-column-width(1)"/>
										<fo:table-column column-width="proportional-column-width(1)"/>
										<fo:table-column column-width="proportional-column-width(1)"/>
										<xsl:variable name="altova:CurrContextGrid_79" select="."/>
										<fo:table-header start-indent="0pt">
											<xsl:variable name="altova:tablerows">
												<fo:table-row>
													<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
														<fo:block-container overflow="hidden">
															<fo:block text-align="left">
																<fo:inline font-size="7pt">
																	<xsl:text>Book Transfer Account</xsl:text>
																</fo:inline>
															</fo:block>
														</fo:block-container>
													</fo:table-cell>
													<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
														<fo:block-container overflow="hidden">
															<fo:block text-align="left">
																<fo:inline font-size="7pt">
																	<xsl:text>Bank To Bank Instruction</xsl:text>
																</fo:inline>
															</fo:block>
														</fo:block-container>
													</fo:table-cell>
													<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
														<fo:block-container overflow="hidden">
															<fo:block text-align="left">
																<fo:inline font-size="7pt">
																	<xsl:text>Beneficiary Instruction</xsl:text>
																</fo:inline>
															</fo:block>
														</fo:block-container>
													</fo:table-cell>
												</fo:table-row>
											</xsl:variable>
											<xsl:choose>
												<xsl:when test="string($altova:tablerows)">
													<xsl:copy-of select="$altova:tablerows"/>
												</xsl:when>
												<xsl:otherwise>
													<fo:table-row>
														<fo:table-cell>
															<fo:block/>
														</fo:table-cell>
													</fo:table-row>
												</xsl:otherwise>
											</xsl:choose>
										</fo:table-header>
										<fo:table-body start-indent="0pt">
											<xsl:variable name="altova:tablerows">
												<xsl:for-each select="$XML">
													<xsl:for-each select="BillTextHeader">
														<xsl:for-each select="BatchBill">
															<xsl:for-each select="BillForContacts">
																<xsl:for-each select="BillForContact">
																	<xsl:for-each select="RemittanceInstructions">
																		<xsl:for-each select="SingleRemittanceInstruction">
																			<xsl:for-each select="BookPaymentInstruction">
																				<fo:table-row>
																					<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																						<fo:block-container overflow="hidden">
																							<fo:block text-align="left">
																								<xsl:for-each select="bookTransferAccount">
																									<xsl:variable name="value-of-template_80">
																										<xsl:apply-templates/>
																									</xsl:variable>
																									<xsl:choose>
																										<xsl:when test="contains(string($value-of-template_80),'&#x200B;')">
																											<fo:block font-size="7pt">
																												<xsl:copy-of select="$value-of-template_80"/>
																											</fo:block>
																										</xsl:when>
																										<xsl:otherwise>
																											<fo:inline font-size="7pt">
																												<xsl:copy-of select="$value-of-template_80"/>
																											</fo:inline>
																										</xsl:otherwise>
																									</xsl:choose>
																								</xsl:for-each>
																							</fo:block>
																						</fo:block-container>
																					</fo:table-cell>
																					<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																						<fo:block-container overflow="hidden">
																							<fo:block text-align="left">
																								<xsl:for-each select="bankToBankInstruction">
																									<xsl:variable name="value-of-template_81">
																										<xsl:apply-templates/>
																									</xsl:variable>
																									<xsl:choose>
																										<xsl:when test="contains(string($value-of-template_81),'&#x200B;')">
																											<fo:block font-size="7pt">
																												<xsl:copy-of select="$value-of-template_81"/>
																											</fo:block>
																										</xsl:when>
																										<xsl:otherwise>
																											<fo:inline font-size="7pt">
																												<xsl:copy-of select="$value-of-template_81"/>
																											</fo:inline>
																										</xsl:otherwise>
																									</xsl:choose>
																								</xsl:for-each>
																							</fo:block>
																						</fo:block-container>
																					</fo:table-cell>
																					<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																						<fo:block-container overflow="hidden">
																							<fo:block text-align="left">
																								<xsl:for-each select="beneficiaryInstruction">
																									<xsl:variable name="value-of-template_82">
																										<xsl:apply-templates/>
																									</xsl:variable>
																									<xsl:choose>
																										<xsl:when test="contains(string($value-of-template_82),'&#x200B;')">
																											<fo:block font-size="7pt">
																												<xsl:copy-of select="$value-of-template_82"/>
																											</fo:block>
																										</xsl:when>
																										<xsl:otherwise>
																											<fo:inline font-size="7pt">
																												<xsl:copy-of select="$value-of-template_82"/>
																											</fo:inline>
																										</xsl:otherwise>
																									</xsl:choose>
																								</xsl:for-each>
																							</fo:block>
																						</fo:block-container>
																					</fo:table-cell>
																				</fo:table-row>
																			</xsl:for-each>
																		</xsl:for-each>
																	</xsl:for-each>
																</xsl:for-each>
															</xsl:for-each>
														</xsl:for-each>
													</xsl:for-each>
												</xsl:for-each>
											</xsl:variable>
											<xsl:choose>
												<xsl:when test="string($altova:tablerows)">
													<xsl:copy-of select="$altova:tablerows"/>
												</xsl:when>
												<xsl:otherwise>
													<fo:table-row>
														<fo:table-cell>
															<fo:block/>
														</fo:table-cell>
													</fo:table-row>
												</xsl:otherwise>
											</xsl:choose>
										</fo:table-body>
									</fo:table>
								</xsl:if>
								<fo:block>
									<fo:leader leader-pattern="space"/>
								</fo:block>
							</xsl:when>
							<xsl:when test="/BillTextHeader/BatchBill/BillForContacts/BillForContact/RemittanceInstructions/InterestRemittanceInstruction/@id !=&apos;&apos;">
								<fo:block>
									<fo:leader leader-pattern="space"/>
								</fo:block>
								<fo:inline font-size="10pt">
									<xsl:text>Please transfer the funds as below</xsl:text>
								</fo:inline>
								<fo:block/>
								<fo:inline-container>
									<fo:block>
										<xsl:text>&#x200B;</xsl:text>
									</fo:block>
								</fo:inline-container>
								<xsl:if test="$XML">
									<fo:table table-layout="fixed" width="100%" border="solid 1pt gray" border-spacing="2pt">
										<fo:table-column column-width="proportional-column-width(1)"/>
										<fo:table-column column-width="proportional-column-width(1)"/>
										<fo:table-column column-width="proportional-column-width(1)"/>
										<xsl:variable name="altova:CurrContextGrid_83" select="."/>
										<fo:table-header start-indent="0pt">
											<xsl:variable name="altova:tablerows">
												<fo:table-row>
													<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
														<fo:block-container overflow="hidden">
															<fo:block text-align="left">
																<fo:inline font-size="7pt">
																	<xsl:text>Transfer Account</xsl:text>
																</fo:inline>
															</fo:block>
														</fo:block-container>
													</fo:table-cell>
													<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
														<fo:block-container overflow="hidden">
															<fo:block text-align="left">
																<fo:inline font-size="7pt">
																	<xsl:text>Bank To Bank Instruction</xsl:text>
																</fo:inline>
															</fo:block>
														</fo:block-container>
													</fo:table-cell>
													<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
														<fo:block-container overflow="hidden">
															<fo:block text-align="left">
																<fo:inline font-size="7pt">
																	<xsl:text>Beneficiary Instruction</xsl:text>
																</fo:inline>
															</fo:block>
														</fo:block-container>
													</fo:table-cell>
												</fo:table-row>
											</xsl:variable>
											<xsl:choose>
												<xsl:when test="string($altova:tablerows)">
													<xsl:copy-of select="$altova:tablerows"/>
												</xsl:when>
												<xsl:otherwise>
													<fo:table-row>
														<fo:table-cell>
															<fo:block/>
														</fo:table-cell>
													</fo:table-row>
												</xsl:otherwise>
											</xsl:choose>
										</fo:table-header>
										<fo:table-body start-indent="0pt">
											<xsl:variable name="altova:tablerows">
												<xsl:for-each select="$XML">
													<xsl:for-each select="BillTextHeader">
														<xsl:for-each select="BatchBill">
															<xsl:for-each select="BillForContacts">
																<xsl:for-each select="BillForContact">
																	<xsl:for-each select="RemittanceInstructions">
																		<xsl:for-each select="InterestRemittanceInstruction">
																			<xsl:for-each select="BookPaymentInstruction">
																				<fo:table-row>
																					<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																						<fo:block-container overflow="hidden">
																							<fo:block text-align="left">
																								<xsl:for-each select="bookTransferAccount">
																									<xsl:variable name="value-of-template_84">
																										<xsl:apply-templates/>
																									</xsl:variable>
																									<xsl:choose>
																										<xsl:when test="contains(string($value-of-template_84),'&#x200B;')">
																											<fo:block font-size="7pt">
																												<xsl:copy-of select="$value-of-template_84"/>
																											</fo:block>
																										</xsl:when>
																										<xsl:otherwise>
																											<fo:inline font-size="7pt">
																												<xsl:copy-of select="$value-of-template_84"/>
																											</fo:inline>
																										</xsl:otherwise>
																									</xsl:choose>
																								</xsl:for-each>
																							</fo:block>
																						</fo:block-container>
																					</fo:table-cell>
																					<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																						<fo:block-container overflow="hidden">
																							<fo:block text-align="left">
																								<xsl:for-each select="bankToBankInstruction">
																									<xsl:variable name="value-of-template_85">
																										<xsl:apply-templates/>
																									</xsl:variable>
																									<xsl:choose>
																										<xsl:when test="contains(string($value-of-template_85),'&#x200B;')">
																											<fo:block font-size="7pt">
																												<xsl:copy-of select="$value-of-template_85"/>
																											</fo:block>
																										</xsl:when>
																										<xsl:otherwise>
																											<fo:inline font-size="7pt">
																												<xsl:copy-of select="$value-of-template_85"/>
																											</fo:inline>
																										</xsl:otherwise>
																									</xsl:choose>
																								</xsl:for-each>
																							</fo:block>
																						</fo:block-container>
																					</fo:table-cell>
																					<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																						<fo:block-container overflow="hidden">
																							<fo:block text-align="left">
																								<xsl:for-each select="beneficiaryInstruction">
																									<xsl:variable name="value-of-template_86">
																										<xsl:apply-templates/>
																									</xsl:variable>
																									<xsl:choose>
																										<xsl:when test="contains(string($value-of-template_86),'&#x200B;')">
																											<fo:block font-size="7pt">
																												<xsl:copy-of select="$value-of-template_86"/>
																											</fo:block>
																										</xsl:when>
																										<xsl:otherwise>
																											<fo:inline font-size="7pt">
																												<xsl:copy-of select="$value-of-template_86"/>
																											</fo:inline>
																										</xsl:otherwise>
																									</xsl:choose>
																								</xsl:for-each>
																							</fo:block>
																						</fo:block-container>
																					</fo:table-cell>
																				</fo:table-row>
																			</xsl:for-each>
																		</xsl:for-each>
																	</xsl:for-each>
																</xsl:for-each>
															</xsl:for-each>
														</xsl:for-each>
													</xsl:for-each>
												</xsl:for-each>
											</xsl:variable>
											<xsl:choose>
												<xsl:when test="string($altova:tablerows)">
													<xsl:copy-of select="$altova:tablerows"/>
												</xsl:when>
												<xsl:otherwise>
													<fo:table-row>
														<fo:table-cell>
															<fo:block/>
														</fo:table-cell>
													</fo:table-row>
												</xsl:otherwise>
											</xsl:choose>
										</fo:table-body>
									</fo:table>
								</xsl:if>
							</xsl:when>
							<xsl:when test="/BillTextHeader/BatchBill/BillForContacts/BillForContact/RemittanceInstructions/SBLCFeesRemittanceInstruction/@id !=&apos;&apos;">
								<fo:block>
									<fo:leader leader-pattern="space"/>
								</fo:block>
								<fo:inline>
									<xsl:text>Please transfer the funds as below</xsl:text>
								</fo:inline>
								<fo:inline-container>
									<fo:block>
										<xsl:text>&#x200B;</xsl:text>
									</fo:block>
								</fo:inline-container>
								<xsl:if test="$XML">
									<fo:table table-layout="fixed" width="100%" border="solid 1pt gray" border-spacing="2pt">
										<fo:table-column column-width="proportional-column-width(1)"/>
										<fo:table-column column-width="proportional-column-width(1)"/>
										<fo:table-column column-width="proportional-column-width(1)"/>
										<xsl:variable name="altova:CurrContextGrid_87" select="."/>
										<fo:table-header start-indent="0pt">
											<xsl:variable name="altova:tablerows">
												<fo:table-row>
													<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
														<fo:block-container overflow="hidden">
															<fo:block text-align="left">
																<fo:inline font-size="7pt">
																	<xsl:text>Transfer Account</xsl:text>
																</fo:inline>
															</fo:block>
														</fo:block-container>
													</fo:table-cell>
													<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
														<fo:block-container overflow="hidden">
															<fo:block text-align="left">
																<fo:inline font-size="7pt">
																	<xsl:text>Bank To Bank Instruction</xsl:text>
																</fo:inline>
															</fo:block>
														</fo:block-container>
													</fo:table-cell>
													<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
														<fo:block-container overflow="hidden">
															<fo:block text-align="left">
																<fo:inline font-size="7pt">
																	<xsl:text>Beneficiary Instruction</xsl:text>
																</fo:inline>
															</fo:block>
														</fo:block-container>
													</fo:table-cell>
												</fo:table-row>
											</xsl:variable>
											<xsl:choose>
												<xsl:when test="string($altova:tablerows)">
													<xsl:copy-of select="$altova:tablerows"/>
												</xsl:when>
												<xsl:otherwise>
													<fo:table-row>
														<fo:table-cell>
															<fo:block/>
														</fo:table-cell>
													</fo:table-row>
												</xsl:otherwise>
											</xsl:choose>
										</fo:table-header>
										<fo:table-body start-indent="0pt">
											<xsl:variable name="altova:tablerows">
												<xsl:for-each select="$XML">
													<xsl:for-each select="BillTextHeader">
														<xsl:for-each select="BatchBill">
															<xsl:for-each select="BillForContacts">
																<xsl:for-each select="BillForContact">
																	<xsl:for-each select="RemittanceInstructions">
																		<xsl:for-each select="SBLCFeesRemittanceInstruction">
																			<xsl:for-each select="BookPaymentInstruction">
																				<fo:table-row>
																					<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																						<fo:block-container overflow="hidden">
																							<fo:block text-align="left">
																								<xsl:for-each select="bookTransferAccount">
																									<xsl:variable name="value-of-template_88">
																										<xsl:apply-templates/>
																									</xsl:variable>
																									<xsl:choose>
																										<xsl:when test="contains(string($value-of-template_88),'&#x200B;')">
																											<fo:block font-size="7pt">
																												<xsl:copy-of select="$value-of-template_88"/>
																											</fo:block>
																										</xsl:when>
																										<xsl:otherwise>
																											<fo:inline font-size="7pt">
																												<xsl:copy-of select="$value-of-template_88"/>
																											</fo:inline>
																										</xsl:otherwise>
																									</xsl:choose>
																								</xsl:for-each>
																							</fo:block>
																						</fo:block-container>
																					</fo:table-cell>
																					<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																						<fo:block-container overflow="hidden">
																							<fo:block text-align="left">
																								<xsl:for-each select="bankToBankInstruction">
																									<xsl:variable name="value-of-template_89">
																										<xsl:apply-templates/>
																									</xsl:variable>
																									<xsl:choose>
																										<xsl:when test="contains(string($value-of-template_89),'&#x200B;')">
																											<fo:block font-size="7pt">
																												<xsl:copy-of select="$value-of-template_89"/>
																											</fo:block>
																										</xsl:when>
																										<xsl:otherwise>
																											<fo:inline font-size="7pt">
																												<xsl:copy-of select="$value-of-template_89"/>
																											</fo:inline>
																										</xsl:otherwise>
																									</xsl:choose>
																								</xsl:for-each>
																							</fo:block>
																						</fo:block-container>
																					</fo:table-cell>
																					<fo:table-cell border="solid 1pt gray" padding="2pt" display-align="center">
																						<fo:block-container overflow="hidden">
																							<fo:block text-align="left">
																								<xsl:for-each select="beneficiaryInstruction">
																									<xsl:variable name="value-of-template_90">
																										<xsl:apply-templates/>
																									</xsl:variable>
																									<xsl:choose>
																										<xsl:when test="contains(string($value-of-template_90),'&#x200B;')">
																											<fo:block font-size="7pt">
																												<xsl:copy-of select="$value-of-template_90"/>
																											</fo:block>
																										</xsl:when>
																										<xsl:otherwise>
																											<fo:inline font-size="7pt">
																												<xsl:copy-of select="$value-of-template_90"/>
																											</fo:inline>
																										</xsl:otherwise>
																									</xsl:choose>
																								</xsl:for-each>
																							</fo:block>
																						</fo:block-container>
																					</fo:table-cell>
																				</fo:table-row>
																			</xsl:for-each>
																		</xsl:for-each>
																	</xsl:for-each>
																</xsl:for-each>
															</xsl:for-each>
														</xsl:for-each>
													</xsl:for-each>
												</xsl:for-each>
											</xsl:variable>
											<xsl:choose>
												<xsl:when test="string($altova:tablerows)">
													<xsl:copy-of select="$altova:tablerows"/>
												</xsl:when>
												<xsl:otherwise>
													<fo:table-row>
														<fo:table-cell>
															<fo:block/>
														</fo:table-cell>
													</fo:table-row>
												</xsl:otherwise>
											</xsl:choose>
										</fo:table-body>
									</fo:table>
								</xsl:if>
							</xsl:when>
						</xsl:choose>
						<fo:block/>
					</fo:block>
					<fo:block id="SV_RefID_PageTotal"/>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
	<xsl:template name="altova:double-backslash">
		<xsl:param name="text"/>
		<xsl:param name="text-length"/>
		<xsl:variable name="text-after-bs" select="substring-after($text, '\')"/>
		<xsl:variable name="text-after-bs-length" select="string-length($text-after-bs)"/>
		<xsl:choose>
			<xsl:when test="$text-after-bs-length = 0">
				<xsl:choose>
					<xsl:when test="substring($text, $text-length) = '\'">
						<xsl:value-of select="concat(substring($text,1,$text-length - 1), '\\')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$text"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat(substring($text,1,$text-length - $text-after-bs-length - 1), '\\')"/>
				<xsl:call-template name="altova:double-backslash">
					<xsl:with-param name="text" select="$text-after-bs"/>
					<xsl:with-param name="text-length" select="$text-after-bs-length"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="altova:MakeValueAbsoluteIfPixels">
		<xsl:param name="sValue"/>
		<xsl:variable name="sBeforePx" select="substring-before($sValue, 'px')"/>
		<xsl:choose>
			<xsl:when test="$sBeforePx">
				<xsl:variable name="nLengthOfInteger">
					<xsl:call-template name="altova:GetCharCountOfIntegerAtEndOfString">
						<xsl:with-param name="sText" select="$sBeforePx"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="nPosOfInteger" select="string-length($sBeforePx) - $nLengthOfInteger + 1"/>
				<xsl:variable name="nValuePx" select="substring($sBeforePx, $nPosOfInteger)"/>
				<xsl:variable name="nValueIn" select="number($nValuePx) div number($altova:nPxPerIn)"/>
				<xsl:variable name="nLengthBeforeInteger" select="string-length($sBeforePx) - $nLengthOfInteger"/>
				<xsl:variable name="sRest">
					<xsl:call-template name="altova:MakeValueAbsoluteIfPixels">
						<xsl:with-param name="sValue" select="substring-after($sValue, 'px')"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="concat(substring($sBeforePx, 1, $nLengthBeforeInteger), string($nValueIn), 'in', $sRest)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$sValue"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="altova:GetCharCountOfIntegerAtEndOfString">
		<xsl:param name="sText"/>
		<xsl:variable name="sLen" select="string-length($sText)"/>
		<xsl:variable name="cLast" select="substring($sText, $sLen)"/>
		<xsl:choose>
			<xsl:when test="number($cLast) &gt;= 0 and number($cLast) &lt;= 9">
				<xsl:variable name="nResultOfRest">
					<xsl:call-template name="altova:GetCharCountOfIntegerAtEndOfString">
						<xsl:with-param name="sText" select="substring($sText, 1, $sLen - 1)"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="$nResultOfRest + 1"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>0</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
    
</xsl:stylesheet>
