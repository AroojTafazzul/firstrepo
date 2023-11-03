<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!--
   This stylesheet extracts the baseline from an InitialBaselineSubmission message.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version = "1.0"
				xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
				exclude-result-prefixes="tools">

	<xsl:output method="xml" indent="yes"/>
	
	<xsl:param name="source"/>
	
	<xsl:variable name="baselineReport" select="tools:convertToNode($source)"/>

	<xsl:template match="/">
		<xsl:copy >
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match = "*">
		<xsl:choose>
			<xsl:when test="local-name()='LineItmDtls'">
				<xsl:variable name="lineItemId"><xsl:value-of select="./LineItmId"/></xsl:variable>
				<xsl:choose>
					<xsl:when test="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]">

						<LineItmDtls>
							<!-- Line Item Id -->
							<xsl:copy-of select="LineItmId"/>
							<!-- Product Name -->
							<xsl:choose>
								<xsl:when test="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/PdctNm">
									<xsl:apply-templates select="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/PdctNm"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="PdctNm"/>
								</xsl:otherwise>
							</xsl:choose>
							<!-- Product Identifier -->
							<xsl:apply-templates select="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/PdctIdr"/>
							<!-- Product Characteristics -->
							<xsl:apply-templates select="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/PdctChrtcs"/>
							<!-- Product Category -->
							<xsl:apply-templates select="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/PdctCtgy"/>
							<!-- Ordered quantity -->
							<xsl:choose>
								<xsl:when test="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/OrdrdQty">
									<xsl:apply-templates select="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/OrdrdQty"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="OrdrdQty"/>
								</xsl:otherwise>
							</xsl:choose>
							<!-- Accepted quantity -->
							<xsl:choose>
								<xsl:when test="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/AccptdQty">
									<xsl:apply-templates select="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/AccptdQty"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="AccptdQty"/>
								</xsl:otherwise>
							</xsl:choose>
							<!-- Outstanding quantity -->
							<xsl:choose>
								<xsl:when test="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/OutsdngQty">
									<xsl:apply-templates select="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/OutsdngQty"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="OutsdngQty"/>
								</xsl:otherwise>
							</xsl:choose>
							<!-- Pending quantity -->
							<xsl:choose>
								<xsl:when test="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/PdgQty">
									<xsl:apply-templates select="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/PdgQty"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="PdgQty"/>
								</xsl:otherwise>
							</xsl:choose>
							<!-- Quantity tolerance -->
							<xsl:choose>
								<xsl:when test="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/QtyTlrnce">
									<xsl:apply-templates select="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/QtyTlrnce"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="QtyTlrnce"/>
								</xsl:otherwise>
							</xsl:choose>
							<!-- Ordered amount -->
							<xsl:choose>
								<xsl:when test="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/OrdrdAmt">
									<xsl:apply-templates select="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/OrdrdAmt"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="OrdrdAmt"/>
								</xsl:otherwise>
							</xsl:choose>
							<!-- Accepted amount -->
							<xsl:choose>
								<xsl:when test="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/AccptdAmt">
									<xsl:apply-templates select="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/AccptdAmt"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="AccptdAmt"/>
								</xsl:otherwise>
							</xsl:choose>
							<!-- Outstanding amount -->
							<xsl:choose>
								<xsl:when test="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/OutsdngAmt">
									<xsl:apply-templates select="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/OutsdngAmt"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="OutsdngAmt"/>
								</xsl:otherwise>
							</xsl:choose>
							<!-- Pending amount -->
							<xsl:choose>
								<xsl:when test="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/PdgAmt">
									<xsl:apply-templates select="$baselineReport//*[local-name()='LineItmDtls' and ./LineItmId=$lineItemId]/PdgAmt"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="PdgAmt"/>
								</xsl:otherwise>
							</xsl:choose>
							
						</LineItmDtls>
						
					</xsl:when>
					<xsl:otherwise>
						<xsl:element name="{local-name()}">
							<xsl:apply-templates select = "node()|@*"/>
						</xsl:element>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="local-name()='OrdrdLineItmsTtlAmt' or
							local-name()='AccptdLineItmsTtlAmt' or
							local-name()='OutsdngLineItmsTtlAmt' or
							local-name()='PdgLineItmsTtlAmt' or
							local-name()='OrdrdTtlNetAmt' or
							local-name()='AccptdTtlNetAmt' or
							local-name()='OutsdngTtlNetAmt' or
							local-name()='PdgTtlNetAmt'">
				<xsl:variable name="elementName"><xsl:value-of select="local-name()"/></xsl:variable>
				<xsl:element name="{$elementName}">
					<xsl:choose>
						<xsl:when test="$baselineReport//*[local-name()=$elementName]">
							<xsl:attribute name="Ccy"><xsl:value-of select="$baselineReport//*[local-name()=$elementName]/@Ccy"/></xsl:attribute>
							<xsl:value-of select="$baselineReport//*[local-name()=$elementName]"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="{local-name()}">
					<xsl:apply-templates select = "node()|@*"/>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match = "@*">
		<xsl:attribute name="{local-name()}">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:template>
	
</xsl:stylesheet>