<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!--
   This stylesheet extracts the baseline from an InitialBaselineSubmission message.
-->

<xsl:stylesheet xmlns:xsl = "http://www.w3.org/1999/XSL/Transform" version = "1.0">
	<xsl:output method = "xml" indent = "yes"/>

	<xsl:template match = "/">
		<xsl:copy >
			<xsl:apply-templates select="//*[local-name() = 'Baseln']"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match = "*">
		<xsl:choose>
			<xsl:when test="local-name()='Qty'">
				<xsl:variable name="UnitOfMeasrCd"><xsl:value-of select="*[local-name() = 'UnitOfMeasrCd']"/></xsl:variable>
				<xsl:variable name="OthrUnitOfMeasr"><xsl:value-of select="*[local-name() = 'OthrUnitOfMeasr']"/></xsl:variable>
				<xsl:variable name="Val"><xsl:value-of select="*[local-name() = 'Val']"/></xsl:variable>
				<xsl:variable name="Fctr"><xsl:value-of select="*[local-name() = 'Fctr']"/></xsl:variable>
				<OrdrdQty>
					<xsl:if test="$UnitOfMeasrCd != ''"><UnitOfMeasrCd><xsl:value-of select="$UnitOfMeasrCd"/></UnitOfMeasrCd></xsl:if>
					<xsl:if test="$OthrUnitOfMeasr != ''"><OthrUnitOfMeasr><xsl:value-of select="$OthrUnitOfMeasr"/></OthrUnitOfMeasr></xsl:if>
					<Val><xsl:value-of select="$Val"/></Val>
					<xsl:if test="$Fctr != ''"><Fctr><xsl:value-of select="$Fctr"/></Fctr></xsl:if>
				</OrdrdQty>
				<AccptdQty>
					<xsl:if test="$UnitOfMeasrCd != ''"><UnitOfMeasrCd><xsl:value-of select="$UnitOfMeasrCd"/></UnitOfMeasrCd></xsl:if>
					<xsl:if test="$OthrUnitOfMeasr != ''"><OthrUnitOfMeasr><xsl:value-of select="$OthrUnitOfMeasr"/></OthrUnitOfMeasr></xsl:if>
					<Val><xsl:value-of select="$Val"/></Val>
					<xsl:if test="$Fctr != ''"><Fctr><xsl:value-of select="$Fctr"/></Fctr></xsl:if>
				</AccptdQty>
				<OutsdngQty>
					<xsl:if test="$UnitOfMeasrCd != ''"><UnitOfMeasrCd><xsl:value-of select="$UnitOfMeasrCd"/></UnitOfMeasrCd></xsl:if>
					<xsl:if test="$OthrUnitOfMeasr != ''"><OthrUnitOfMeasr><xsl:value-of select="$OthrUnitOfMeasr"/></OthrUnitOfMeasr></xsl:if>
					<Val><xsl:value-of select="$Val"/></Val>
					<xsl:if test="$Fctr != ''"><Fctr><xsl:value-of select="$Fctr"/></Fctr></xsl:if>
				</OutsdngQty>
				<PdgQty>
					<xsl:if test="$UnitOfMeasrCd != ''"><UnitOfMeasrCd><xsl:value-of select="$UnitOfMeasrCd"/></UnitOfMeasrCd></xsl:if>
					<xsl:if test="$OthrUnitOfMeasr != ''"><OthrUnitOfMeasr><xsl:value-of select="$OthrUnitOfMeasr"/></OthrUnitOfMeasr></xsl:if>
					<Val><xsl:value-of select="$Val"/></Val>
					<xsl:if test="$Fctr != ''"><Fctr><xsl:value-of select="$Fctr"/></Fctr></xsl:if>
				</PdgQty>
			</xsl:when>
			<xsl:when test="local-name()='TtlAmt'">
				<xsl:variable name="Ccy"><xsl:value-of select="@Ccy"/></xsl:variable>
				<xsl:variable name="TtlAmt"><xsl:value-of select="."/></xsl:variable>
				<xsl:choose>
					<xsl:when test="//Instr/Tp = 'LODG'">
						<xsl:element name="OrdrdAmt">
							<xsl:attribute name="Ccy"><xsl:value-of select="$Ccy"/></xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<OrdrdAmt><xsl:attribute name="Ccy"><xsl:value-of select="$Ccy"/></xsl:attribute>0</OrdrdAmt>
					</xsl:otherwise>
				</xsl:choose>
				<AccptdAmt><xsl:attribute name="Ccy"><xsl:value-of select="$Ccy"/></xsl:attribute>0</AccptdAmt>
				<xsl:choose>
					<xsl:when test="//Instr/Tp = 'LODG'">
						<xsl:element name="OutsdngAmt">
							<xsl:attribute name="Ccy"><xsl:value-of select="$Ccy"/></xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<OutsdngAmt><xsl:attribute name="Ccy"><xsl:value-of select="$Ccy"/></xsl:attribute>0</OutsdngAmt>
					</xsl:otherwise>
				</xsl:choose>
				<PdgAmt><xsl:attribute name="Ccy"><xsl:value-of select="$Ccy"/></xsl:attribute>0</PdgAmt>
			</xsl:when>
			<xsl:when test="local-name()='LineItmsTtlAmt'">
				<xsl:variable name="Ccy"><xsl:value-of select="@Ccy"/></xsl:variable>
				<xsl:variable name="LineItmsTtlAmt"><xsl:value-of select="."/></xsl:variable>
				<xsl:choose>
					<xsl:when test="//Instr/Tp = 'LODG'">
						<xsl:element name="OrdrdLineItmsTtlAmt">
							<xsl:attribute name="Ccy"><xsl:value-of select="$Ccy"/></xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<OrdrdLineItmsTtlAmt><xsl:attribute name="Ccy"><xsl:value-of select="$Ccy"/></xsl:attribute>0</OrdrdLineItmsTtlAmt>
					</xsl:otherwise>
				</xsl:choose>
				<AccptdLineItmsTtlAmt><xsl:attribute name="Ccy"><xsl:value-of select="$Ccy"/></xsl:attribute>0</AccptdLineItmsTtlAmt>
				<xsl:choose>
					<xsl:when test="//Instr/Tp = 'LODG'">
						<xsl:element name="OutsdngLineItmsTtlAmt">
							<xsl:attribute name="Ccy"><xsl:value-of select="$Ccy"/></xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<OutsdngLineItmsTtlAmt><xsl:attribute name="Ccy"><xsl:value-of select="$Ccy"/></xsl:attribute>0</OutsdngLineItmsTtlAmt>
					</xsl:otherwise>
				</xsl:choose>
				<PdgLineItmsTtlAmt><xsl:attribute name="Ccy"><xsl:value-of select="$Ccy"/></xsl:attribute>0</PdgLineItmsTtlAmt>
			</xsl:when>
			<xsl:when test="local-name()='TtlNetAmt'">
				<xsl:variable name="Ccy"><xsl:value-of select="@Ccy"/></xsl:variable>
				<xsl:choose>
					<xsl:when test="//Instr/Tp = 'LODG'">
						<xsl:element name="OrdrdTtlNetAmt">
							<xsl:attribute name="Ccy"><xsl:value-of select="$Ccy"/></xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<OrdrdTtlNetAmt><xsl:attribute name="Ccy"><xsl:value-of select="$Ccy"/></xsl:attribute>0</OrdrdTtlNetAmt>
					</xsl:otherwise>
				</xsl:choose>
				<AccptdTtlNetAmt><xsl:attribute name="Ccy"><xsl:value-of select="$Ccy"/></xsl:attribute>0</AccptdTtlNetAmt>
				<xsl:choose>
					<xsl:when test="//Instr/Tp = 'LODG'">
						<xsl:element name="OutsdngTtlNetAmt">
							<xsl:attribute name="Ccy"><xsl:value-of select="$Ccy"/></xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<OutsdngTtlNetAmt><xsl:attribute name="Ccy"><xsl:value-of select="$Ccy"/></xsl:attribute>0</OutsdngTtlNetAmt>
					</xsl:otherwise>
				</xsl:choose>
				<PdgTtlNetAmt><xsl:attribute name="Ccy"><xsl:value-of select="$Ccy"/></xsl:attribute>0</PdgTtlNetAmt>
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