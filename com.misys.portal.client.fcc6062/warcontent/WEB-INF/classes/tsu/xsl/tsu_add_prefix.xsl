<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:Doc="uri:some-name-space">
<xsl:output method="xml" version="1.0" omit-xml-declaration="no"/>
<xsl:template match="/">
<xsl:apply-templates />
</xsl:template>
<xsl:template match="*">
<xsl:variable name="eName" select="local-name()"/>
<xsl:element name="Doc:{$eName}" namespace="uri:some-name-space">
<xsl:for-each select="@*">
<xsl:variable name="aName" select="local-name()"/>
<xsl:attribute name="{$aName}"><xsl:value-of select="." /></xsl:attribute>
</xsl:for-each>
<xsl:apply-templates />
</xsl:element>
</xsl:template>
</xsl:stylesheet>