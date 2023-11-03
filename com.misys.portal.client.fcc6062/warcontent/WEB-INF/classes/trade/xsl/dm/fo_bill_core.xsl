<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:gtp="http://www.neomalogic.com" xmlns:utils="xalan://com.misys.portal.common.tools.Utils" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="utils" version="1.0">

	<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	
	<xsl:param name="isDraft" select="'Y'"/>
	<xsl:param name="logo_url"/>
	<xsl:template match="gtp:BillOfExchange">

		<fo:root>
			<fo:layout-master-set>
				<fo:simple-page-master margin-bottom="10pt" margin-left="30pt" margin-right="30pt" master-name="last-page" page-height="300pt" page-width="595.3pt">
					<fo:region-before extent="30pt"/>
					<fo:region-after extent="30pt" region-name="last-page-after"/>
					<fo:region-body margin-bottom="30pt" margin-top="30pt"/>
				</fo:simple-page-master>
				<fo:simple-page-master margin-bottom="10pt" margin-left="30pt" margin-right="30pt" master-name="all-pages" page-height="300pt" page-width="595.3pt">
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

	
<xsl:template name="header">
    <fo:static-content flow-name="xsl-region-before">
				</fo:static-content>
  </xsl:template>
  <xsl:template name="body">
    <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="11.0pt">
					<!-- Buyer plus title-->
					<fo:table>
						<!-- Initial splitting in a single row of two collumns -->
						<fo:table-column column-width="300pt"/>
						<fo:table-column column-width="232pt"/>
						<fo:table-body>
							<fo:table-row height="70pt">
								<!-- Seller data -->
								<fo:table-cell height="45pt">
									<fo:block>
										<xsl:value-of select="gtp:Body/gtp:Parties/gtp:Seller/gtp:organizationName"/>
									</fo:block>
									<fo:block>
										<xsl:value-of select="gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='1']"/>
									</fo:block>
									<fo:block>
										<xsl:value-of select="gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='2']"/>
									</fo:block>
									<fo:block>
										<xsl:value-of select="gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='3']"/>
									</fo:block>
								</fo:table-cell>
								<!-- Document header -->
								<fo:table-cell display-align="center" font-size="14pt" font-weight="bold">
									<fo:block text-align="center">Bill Of Exchange</fo:block>
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
									<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Total Amount</fo:block>
									<fo:block text-align="center">
										<xsl:value-of select="gtp:Body/gtp:Totals/gtp:TotalAmount/gtp:MultiCurrency/gtp:currencyCode"/>
										<xsl:text> </xsl:text>
										<xsl:value-of select="gtp:Body/gtp:Totals/gtp:TotalAmount/gtp:MultiCurrency/gtp:value"/>
									</fo:block>
								</fo:table-cell>
								<!-- Right collumn: Date -->
								<fo:table-cell border-color="black" border-style="solid" border-width="0.5pt" height="25pt">
									<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">Date</fo:block>
									<fo:block text-align="center">
										<xsl:value-of select="gtp:Body/gtp:GeneralInformation/gtp:dateOfIssue"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
					<!-- Top section table end -->
					<!-- Text-->
					<fo:table border-color="black" border-style="solid" border-width="0.5pt">
						<!-- Initial splitting in 2 collumns -->
						<fo:table-column column-width="5pt"/>
						<fo:table-column column-width="527pt"/>
						<fo:table-body>
							<!-- Headers -->
							<fo:table-row height="14pt"/>
							<fo:table-row>
								<fo:table-cell>
									<fo:block/>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block text-indent="0pt">
										<xsl:text>At sight of this exchange pay ................................................................. the sum of </xsl:text>
										<xsl:variable name="amount">
                  <xsl:value-of select="gtp:Body/gtp:Totals/gtp:TotalAmount/gtp:MultiCurrency/gtp:value"/>
                </xsl:variable>
										<xsl:variable name="currency">
                  <xsl:value-of select="gtp:Body/gtp:Totals/gtp:TotalAmount/gtp:MultiCurrency/gtp:currencyCode"/>
                </xsl:variable>
										<xsl:value-of select="utils:spellout('en', $amount, $currency)"/>
										<xsl:text>  only.</xsl:text>
									</fo:block>
									<fo:block text-indent="0pt">
										<xsl:text>Value received drawn under ............................................................................................................................................</xsl:text>
									</fo:block>
									<fo:block text-indent="0pt">
										<xsl:text>.........................................................................................................................................................................................</xsl:text>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<fo:table-row height="14pt"/>
						</fo:table-body>
					</fo:table>
					<fo:table border-color="black" border-style="solid" border-width="0.5pt">
						<!-- Initial splitting in collumns -->
						<fo:table-column column-width="10pt"/>
						<fo:table-column column-width="190pt"/>
						<fo:table-column column-width="132pt"/>
						<fo:table-column column-width="200pt"/>
						<fo:table-body>
							<!-- Headers -->
							<fo:table-row height="7pt"/>
							<fo:table-row height="50pt">
								<fo:table-cell>
									<fo:block font-size="8pt" font-weight="bold" text-indent="2pt">To:</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block text-indent="30pt">
										<xsl:value-of select="gtp:Body/gtp:Parties/gtp:BillTo/gtp:organizationName"/>
									</fo:block>
									<fo:block text-indent="30pt">
										<xsl:value-of select="gtp:Body/gtp:Parties/gtp:BillTo/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='1']"/>
									</fo:block>
									<fo:block text-indent="30pt">
										<xsl:value-of select="gtp:Body/gtp:Parties/gtp:BillTo/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='2']"/>
									</fo:block>
									<fo:block text-indent="30pt">
										<xsl:value-of select="gtp:Body/gtp:Parties/gtp:BillTo/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='3']"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell/>
								<fo:table-cell display-align="after">
									<fo:block font-size="8pt" font-weight="bold" text-align="center">Authorised Signatory</fo:block>
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
								<fo:table-cell/>
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
									<xsl:text/>
								</fo:table-cell>
								<fo:table-cell display-align="after">
									<xsl:text/>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:static-content>
  </xsl:template>
</xsl:stylesheet>
