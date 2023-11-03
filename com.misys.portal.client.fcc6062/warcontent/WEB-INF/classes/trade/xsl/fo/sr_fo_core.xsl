<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<!-- Copyright (c) 2006-2013 Misys , All Rights Reserved -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl" />
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl" />
	<xsl:param name="base_url" />
	<xsl:param name="systemDate" />
	<!-- Get the language code -->
	<xsl:param name="language" />
	<xsl:param name="rundata" />
	<xsl:include href="sr_content_fo.xsl" />
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" font-family="{$pdfFont}" writing-mode="{$writingMode}">

			<xsl:call-template name="general-layout-master" />
			
			<!-- bookmark section -->
			<fo:bookmark-tree>
			        <fo:bookmark internal-destination="gendetails">
			            <fo:bookmark-title><xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')" />
						</fo:bookmark-title>
			        </fo:bookmark>
			        <fo:bookmark internal-destination="bankdetails">
			            <fo:bookmark-title><xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_BANK_DETAILS')" />
						</fo:bookmark-title>
			        </fo:bookmark>
			        <fo:bookmark internal-destination="amountdetails">
			            <fo:bookmark-title>
			            	<xsl:choose>
								<xsl:when test="$swift2018Enabled">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_CONFIRMATION_DETAILS')" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_DETAILS')"/>
								</xsl:otherwise>
							</xsl:choose>
						</fo:bookmark-title>
			        </fo:bookmark>
			        <fo:bookmark internal-destination="paymentdetails">
			            <fo:bookmark-title><xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_PAYMENT_DETAILS')" />
						</fo:bookmark-title>
			        </fo:bookmark>
			        <fo:bookmark internal-destination="renewaldetails">
			            <fo:bookmark-title><xsl:value-of
									select="localization:getGTPString($language, 'XSL_RENEWAL_DETAILS_LABEL')" />
						</fo:bookmark-title>
			        </fo:bookmark>
			        <fo:bookmark internal-destination="shipmentdetails">
			            <fo:bookmark-title><xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_SHIPMENT_DETAILS')" />
						</fo:bookmark-title>
			        </fo:bookmark>
			        <fo:bookmark internal-destination="lcdetails">
			            <fo:bookmark-title><xsl:value-of
										select="localization:getGTPString($language, 'XSL_HEADER_STANDBY_LC_DETAILS')" />
						</fo:bookmark-title>
			        </fo:bookmark>
			        <fo:bookmark internal-destination="narative">
			            <fo:bookmark-title><xsl:value-of
											select="localization:getGTPString($language, 'XSL_HEADER_NARRATIVE_DETAILS')" />
						</fo:bookmark-title>
			        </fo:bookmark>
			    </fo:bookmark-tree>
			    
			<fo:page-sequence initial-page-number="1"
				master-reference="Section1-ps">
				<!-- Put the name of the bank on the left -->
				<fo:static-content text-align="center" flow-name="xsl-region-start">
					<fo:block font-size="8pt" text-align="center" color="#FFFFFF"
						font-weight="bold" font-family="{$pdfFont}">
						<xsl:value-of select="localization:getDecode($language, 'N001', sr_tnx_record/product_code[.])"/>
					</fo:block>
				</fo:static-content>
				<!--Apply sr_content_fo.xsl on sr_tnx_record-->
				<xsl:apply-templates select="child::*[1]" />
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>
