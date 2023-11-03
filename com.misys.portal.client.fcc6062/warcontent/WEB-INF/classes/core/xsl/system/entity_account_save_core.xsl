<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process ENTITY ACCOUNT-->
	<xsl:template match="user_account">
		<result>
			<com.misys.portal.cash.product.ab.common.EntityAccount>
				<!-- keys must be attributes -->
				<xsl:attribute name="entity_id"><xsl:value-of select="entity_id"/></xsl:attribute>
				<xsl:attribute name="account_id"><xsl:value-of select="account_id"/></xsl:attribute>
			</com.misys.portal.cash.product.ab.common.EntityAccount>
		</result>
	</xsl:template>
	
	<xsl:template match="@*|node()">
		<xsl:apply-templates select="@*|node()" />
	</xsl:template>
</xsl:stylesheet>
