<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="text"/>

	<xsl:variable name="apos">'</xsl:variable>
	<xsl:variable name="cr"><xsl:text>
</xsl:text></xsl:variable>

  	<xsl:template match="/">
		<xsl:apply-templates select="root/dataset/gtp_role"/>
 	</xsl:template>
 
	<xsl:template match="gtp_role">
		<xsl:variable name="role_id" select="role_id"/>
		<xsl:apply-templates select="//gtp_role_permission[role_id=$role_id]">
			<xsl:with-param name="role_id" select="$role_id"/>
			<xsl:with-param name="role_name" select="translate(ROLENAME, $apos, '')"/>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="gtp_role_permission">
		<xsl:param name="role_id"/>
		<xsl:param name="role_name"/>	
		<xsl:variable name="permission_id" select="permission_id"/>
		<xsl:value-of select="$role_id"/>;<xsl:value-of select="$role_name"/>;<xsl:value-of select="$permission_id"/>;<xsl:value-of select="translate(//gtp_permission[permission_id=$permission_id]/PERMISSION, $apos, '')"/><xsl:value-of select="$cr"/>
	</xsl:template>

</xsl:stylesheet>