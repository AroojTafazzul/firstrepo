<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:Doc="urn:swift:xsd:$tsmt.011.001.02"
	xmlns:default="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
	xmlns:intools="xalan://com.misys.portal.interfaces.tools.InterfacesTools"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	xmlns:openaccounttools="xalan://com.misys.portal.openaccount.product.baseline.util.Tools"
	exclude-result-prefixes="default intools tools">

	<xsl:import href="common.xsl"/>
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<!-- Get the interface environment -->
	<xsl:param name="context"/>
	<xsl:param name="BIC"/>
	<xsl:param name="language"/>
	<xsl:param name="source"/>
	
	<!--
	Copyright (c) 2000-2007 NEOMAlogic (http://www.neomalogic.com),
	All Rights Reserved. 
	-->
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="Doc:Document">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Process TSU Message -->
	<xsl:template match="Doc:tsmt.011.001.02">
		
		<!-- Process only if the baseline is not precalculated -->
		<!-- <xsl:if test="Doc:RptTp/Doc:Tp != 'PREC'">-->
		
			<!-- Detect if the baseline is related to a PO or a SO -->
			<xsl:variable name="poRefId"><xsl:value-of select="tools:retrievePOfromTID(Doc:TxId/Doc:Id, $BIC)"/></xsl:variable>
			<xsl:variable name="soRefId"><xsl:value-of select="tools:retrieveSOfromTID(Doc:TxId/Doc:Id, $BIC)"/></xsl:variable>

			<xsl:choose>
				<!-- Purchase Order -->
				<xsl:when test="$poRefId != ''">
					<xsl:value-of select="openaccounttools:updatePOFromBaselineReport($poRefId, $source)"/>
				</xsl:when>
				<!-- Advised Purchase Order -->
				<xsl:when test="$soRefId != ''">
					<xsl:value-of select="openaccounttools:updateSOFromBaselineReport($soRefId, $source)"/>
				</xsl:when>
			</xsl:choose>
		
		<!-- </xsl:if>-->
		
	</xsl:template>
	
</xsl:stylesheet>