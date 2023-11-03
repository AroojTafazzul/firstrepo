<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com), All 
		Rights Reserved. -->
	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<!-- Process USER ACCOUNT -->
	<xsl:template match="user_account">
		<result>
			<com.misys.portal.cash.product.ab.common.UserAccountTnx>
				<!-- keys must be attributes -->
				<xsl:attribute name="user_id"><xsl:value-of select="user_id" /></xsl:attribute>
				<xsl:attribute name="account_id"><xsl:value-of select="account_id" /></xsl:attribute>
				<xsl:attribute name="entity_id"><xsl:value-of select="entity_id"/></xsl:attribute>
				<xsl:attribute name="context_key"><xsl:value-of select="context_key" /></xsl:attribute>
				<xsl:attribute name="context_value"><xsl:value-of select="context_value" /></xsl:attribute>
				<return_comments>
					<xsl:value-of select="return_comments" />
				</return_comments>
			</com.misys.portal.cash.product.ab.common.UserAccountTnx>
		</result>
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:apply-templates select="@*|node()" />
	</xsl:template>
</xsl:stylesheet>
