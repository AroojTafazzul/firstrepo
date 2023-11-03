<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" omit-xml-declaration="no" encoding="iso-8859-1" indent="no"/>
	<!--
   Copyright (c) 2000-2010 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
	<xsl:param name="oldfeed"/>
	<xsl:param name="oldcontent"/>
	<xsl:param name="newfeed"/>
	<xsl:param name="newcontent"/>
	
	<xsl:template match="@parent[.=$oldfeed] | @parent[.='EmptyFeed']">
		<xsl:attribute name="parent"><xsl:value-of select="$newfeed"></xsl:value-of></xsl:attribute>
	</xsl:template>
	
	<xsl:template match="@parent[.=$oldcontent] | @parent[.='EmptyContent']">
		<xsl:attribute name="parent"><xsl:value-of select="$newcontent"></xsl:value-of></xsl:attribute>
	</xsl:template>
	
	<xsl:template match="* | @* |text()|comment()">
		<xsl:copy>
			<xsl:apply-templates select="* | @* |text()|comment()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
	

