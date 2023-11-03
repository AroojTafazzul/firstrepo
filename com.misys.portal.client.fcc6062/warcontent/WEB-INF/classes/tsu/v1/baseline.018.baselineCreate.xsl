<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!--
   This stylesheet extracts the baseline from an InitialBaselineSubmission message.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version = "1.0"
				xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
				exclude-result-prefixes="tools">

	<xsl:output method="xml" indent="yes"/>
	
	<xsl:param name="baselineStatus"/>
	
	<xsl:template match="/">
		<xsl:copy >
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match = "*">
		<xsl:choose>
			<xsl:when test="local-name()='Qty'">
				<xsl:choose>
					<xsl:when test="$baselineStatus = 'ESTD'">
						<OrdrdQty>
							<UnitOfMeasrCd><xsl:value-of select="./*[local-name()='UnitOfMeasrCd']"/></UnitOfMeasrCd>
							<Val><xsl:value-of select="./*[local-name()='Val']"/></Val>
						</OrdrdQty>
						<AccptdQty>
							<UnitOfMeasrCd><xsl:value-of select="./*[local-name()='UnitOfMeasrCd']"/></UnitOfMeasrCd>
							<Val>0</Val>
						</AccptdQty>
						<OutsdngQty>
							<UnitOfMeasrCd><xsl:value-of select="./*[local-name()='UnitOfMeasrCd']"/></UnitOfMeasrCd>
							<Val><xsl:value-of select="./*[local-name()='Val']"/></Val>
						</OutsdngQty>
						<PdgQty>
							<UnitOfMeasrCd><xsl:value-of select="./*[local-name()='UnitOfMeasrCd']"/></UnitOfMeasrCd>
							<Val>0</Val>
						</PdgQty>
					</xsl:when>
					<xsl:otherwise>
						<OrdrdQty>
							<UnitOfMeasrCd><xsl:value-of select="./*[local-name()='UnitOfMeasrCd']"/></UnitOfMeasrCd>
							<Val>0</Val>
						</OrdrdQty>
						<AccptdQty>
							<UnitOfMeasrCd><xsl:value-of select="./*[local-name()='UnitOfMeasrCd']"/></UnitOfMeasrCd>
							<Val>0</Val>
						</AccptdQty>
						<OutsdngQty>
							<UnitOfMeasrCd><xsl:value-of select="./*[local-name()='UnitOfMeasrCd']"/></UnitOfMeasrCd>
							<Val>0</Val>
						</OutsdngQty>
						<PdgQty>
							<UnitOfMeasrCd><xsl:value-of select="./*[local-name()='UnitOfMeasrCd']"/></UnitOfMeasrCd>
							<Val>0</Val>
						</PdgQty>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="local-name()='TtlAmt'">
				<xsl:choose>
					<xsl:when test="$baselineStatus = 'ESTD'">
						<OrdrdTtlAmt>
							<xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>
							<xsl:value-of select="."/>
						</OrdrdTtlAmt>
						<AccptdTtlAmt><xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>0</AccptdTtlAmt>
						<OutsdngTtlAmt>
							<xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>
							<xsl:value-of select="."/>
						</OutsdngTtlAmt>
						<PdgTtlAmt><xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>0</PdgTtlAmt>
					</xsl:when>
					<xsl:otherwise>
						<OrdrdTtlAmt><xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>0</OrdrdTtlAmt>
						<AccptdTtlAmt><xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>0</AccptdTtlAmt>
						<OutsdngTtlAmt><xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>0</OutsdngTtlAmt>
						<PdgTtlAmt><xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>0</PdgTtlAmt>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="local-name()='LineItmsTtlAmt'">
				<xsl:choose>
					<xsl:when test="$baselineStatus = 'ESTD'">
						<OrdrdLineItmsTtlAmt>
							<xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>
							<xsl:value-of select="."/>
						</OrdrdLineItmsTtlAmt>
						<AccptdLineItmsTtlAmt><xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>0</AccptdLineItmsTtlAmt>
						<OutsdngLineItmsTtlAmt>
							<xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>
							<xsl:value-of select="."/>
						</OutsdngLineItmsTtlAmt>
						<PdgLineItmsTtlAmt><xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>0</PdgLineItmsTtlAmt>
					</xsl:when>
					<xsl:otherwise>
						<OrdrdLineItmsTtlAmt><xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>0</OrdrdLineItmsTtlAmt>
						<AccptdLineItmsTtlAmt><xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>0</AccptdLineItmsTtlAmt>
						<OutsdngLineItmsTtlAmt><xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>0</OutsdngLineItmsTtlAmt>
						<PdgLineItmsTtlAmt><xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>0</PdgLineItmsTtlAmt>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="local-name()='TtlNetAmt'">
				<xsl:choose>
					<xsl:when test="$baselineStatus = 'ESTD'">
						<OrdrdTtlNetAmt>
							<xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>
							<xsl:value-of select="."/>
						</OrdrdTtlNetAmt>
						<AccptdTtlNetAmt><xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>0</AccptdTtlNetAmt>
						<OutsdngTtlNetAmt>
							<xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>
							<xsl:value-of select="."/>
						</OutsdngTtlNetAmt>
						<PdgTtlNetAmt><xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>0</PdgTtlNetAmt>
					</xsl:when>
					<xsl:otherwise>
						<OrdrdTtlNetAmt><xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>0</OrdrdTtlNetAmt>
						<AccptdTtlNetAmt><xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>0</AccptdTtlNetAmt>
						<OutsdngTtlNetAmt><xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>0</OutsdngTtlNetAmt>
						<PdgTtlNetAmt><xsl:attribute name="Ccy"><xsl:value-of select="./@Ccy"/></xsl:attribute>0</PdgTtlNetAmt>
					</xsl:otherwise>
				</xsl:choose>
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