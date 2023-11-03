<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	exclude-result-prefixes="localization">
<xsl:output method="text"/>
<!--
   Copyright (c) 2000-2005 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<!-- Get the language code -->
	<!--xsl:param name="language"/-->
	
	<!-- Match template -->
	<xsl:template match="table">
		<com.misys.portal.report.processor.ListDef>
			<com.misys.portal.report.processor.List>
				<xsl:apply-templates select="//*/tr[position() = 1]"/>
				<com.misys.portal.report.processor.GroupNode>
					<xsl:apply-templates select="//*/tr[not(position() = 1)]"/>
				</com.misys.portal.report.processor.GroupNode>
			</com.misys.portal.report.processor.List>
		</com.misys.portal.report.processor.ListDef>
	</xsl:template>

    <!-- .. for first row -->
    <xsl:template match="tr[position() = 1]">
		<com.misys.portal.report.processor.Columns>
      		<xsl:apply-templates select="td"/>
		</com.misys.portal.report.processor.Columns>
   	</xsl:template>

    <!-- .. for each row -->
    <xsl:template match="tr[not(position() = 1)]">
		<com.misys.portal.report.processor.Record>
      		<xsl:apply-templates select="td"/>
		</com.misys.portal.report.processor.Record>
   	</xsl:template>

	<!-- Transform td into cell -->
  	<xsl:template match="td">
		<com.misys.portal.report.processor.Cell>
			<xsl:if test="@align">
				<xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
			</xsl:if>
			<xsl:value-of select="."/>
		</com.misys.portal.report.processor.Cell>
	</xsl:template>

</xsl:stylesheet>