<?xml version="1.0"?>
<!--
   Copyright (c) 2000-2010 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
				exclude-result-prefixes="tools defaultresource">
				
	
	<xsl:template match="/">
	<xsl:variable name="fxsource"><xsl:value-of select="defaultresource:getResource('FX_RATE_SOURCE')"/></xsl:variable>
	<xsl:choose>
		<!-- To handle multiple fx orders -->
		<xsl:when test="Subscription/Publications/Publication[ItemArray/anyType/PublishedEventName='OREV']">
			<xsl:apply-templates select="Subscription/Publications" mode="xo"/>
		</xsl:when>
		<xsl:otherwise>
			<transactions>
				<xsl:choose>
					<xsl:when test="Subscription/Publications/Publication[ItemArray/anyType/PublishedEventName='ACCT'] or Subscription/Publications/Publication[ItemArray/anyType/PublishedEventName='SKAM']">
						<xsl:apply-templates select="Subscription/Publications" mode="accounts"/>
					</xsl:when>
					<xsl:when test="Subscription/Publications/Publication[ItemArray/anyType/PublishedEventName='CMDTMTP']">
						<xsl:apply-templates select="Subscription/Publications" mode="statements"/>
						<xsl:apply-templates select="Subscription/Publications" mode="products"/>
					</xsl:when>
					<xsl:when test="Subscription/Publications/Publication[ItemArray/anyType/PublishedEventName='CMABMTP']">
						<xsl:apply-templates select="Subscription/Publications" mode="balances"/>
					</xsl:when>
					<!-- <xsl:when test="Subscription/Publications/Publication[ItemArray/anyType/PublishedEventName='OREV']">
						<xsl:apply-templates select="Subscription/Publications" mode="xo"/>
					</xsl:when> -->
					
					<xsl:when test="Subscription/Publications/Publication[ItemArray/anyType/PublishedEventName='XTFXRate'] and ($fxsource='TREASURY')">
						<xsl:apply-templates select="Subscription/Publications" mode="fxrate"/>
					</xsl:when>
					
				</xsl:choose>
			</transactions>
		</xsl:otherwise>
	</xsl:choose>
	
	</xsl:template>
	
	<!-- HACK to correct MSSQL DateTime -->
	<xsl:template name="opicsDate2portalDate">
		<xsl:param name="date"/>
		<xsl:if test="$date != '0001-01-01T00:00:00'">
			<xsl:value-of select="substring($date, 9, 2)"/>/<xsl:value-of select="substring($date, 6, 2)"/>/<xsl:value-of select="substring($date, 1, 4)"/>
		</xsl:if>
		<!-- ELSE DO NOTHING TO AVOID HAVING A 0001 year in MSSQL -->
	</xsl:template> 

	<!-- Include all products -->
  	<xsl:include href="opicsAccounts2portalAccounts.xsl"/>
	<xsl:include href="opicsStatements2portalStatements.xsl"/>
  	<xsl:include href="opicsFXOrders2portalFXOrders.xsl"/>
	<xsl:include href="opicsFXRate2portalFXRate.xsl" />
	<xsl:include href="opicsStatements2portalProducts.xsl" />

</xsl:stylesheet>