<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="text"/>

	<xsl:variable name="apos">'</xsl:variable>
	<xsl:variable name="cr"><xsl:text>
</xsl:text></xsl:variable>

  	<xsl:template match="/">
		<xsl:apply-templates select="root/dataset/gtp_permission"/>
 	</xsl:template>
 
	<xsl:template match="gtp_permission">
		<xsl:value-of select="permission_id"/>;<xsl:value-of select="translate(PERMISSION, $apos, '')"/><xsl:value-of select="$cr"/>
	</xsl:template>

</xsl:stylesheet>