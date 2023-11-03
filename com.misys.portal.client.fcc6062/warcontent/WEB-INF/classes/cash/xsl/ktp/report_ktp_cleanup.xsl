<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	exclude-result-prefixes="msxsl">
	<xsl:output method="xml" indent="yes" />
	
	<xsl:param name="userAccounts"/>
	<xsl:param name="searchParameters"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	
	<!-- Remove empty columns -->
	<xsl:template match="column[@name='ref_id' or @name='tnx_id' or @name='']">
	</xsl:template>

	<!-- Remove empty criteria -->
	<xsl:template match="criteria">
		<xsl:if test="value != ''">
			<xsl:copy>
				<xsl:apply-templates select="@* | node()" />
			</xsl:copy>
		</xsl:if>
	</xsl:template>

	<!-- Convert value type "AmountRange" to "Number" -->
	<xsl:template match="value[@type='AmountRange']">
		<xsl:element name="value">
			<xsl:attribute name="type">Number</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	
	<!-- Convert value type "account" to "String" -->
	<xsl:template match="value[@type='account']">
		<xsl:element name="value">
			<xsl:attribute name="type">String</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>


</xsl:stylesheet>