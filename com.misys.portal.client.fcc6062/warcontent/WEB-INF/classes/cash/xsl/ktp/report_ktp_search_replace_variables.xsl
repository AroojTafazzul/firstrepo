<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	exclude-result-prefixes="msxsl">
	<xsl:output method="xml" indent="yes" />
	
	<xsl:param name="parameterName"/>
	<xsl:param name="parameterValue"/>
	<xsl:param name="parameterType"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	
	<!-- Filters -->
	<xsl:template match="value[@type = 'parameter' and . = $parameterName]">
			<parameterName><xsl:value-of select="."/></parameterName>
			<!-- 
			<value>
				<xsl:attribute name="type"><xsl:value-of select="$parameterType"/></xsl:attribute>
				<xsl:value-of select="$parameterValue"/>
			</value>
			-->
	</xsl:template>

	
</xsl:stylesheet>