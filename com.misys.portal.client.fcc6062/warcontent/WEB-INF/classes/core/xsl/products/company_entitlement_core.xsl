<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="category">
		<result>
			<com.misys.portal.product.util.CompanyEntitlement>
				<xsl:if test="entitlement_id">
						<entitlement_id>
							<xsl:value-of select="entitlement_id"/>
						</entitlement_id>
					</xsl:if>
					<xsl:if test="entitlement_code">
						<entitlement_code>
							<xsl:value-of select="entitlement_code"/>
						</entitlement_code>
					</xsl:if>
					<xsl:if test="company_id">
						<company_id>
							<xsl:value-of select="company_id"/>
						</company_id>
					</xsl:if>
					<xsl:if test="entitlement_description">
						<entitlement_description>
							<xsl:value-of select="entitlement_description"/>
						</entitlement_description>
					</xsl:if>
			</com.misys.portal.product.util.CompanyEntitlement>
		</result>
	</xsl:template>
</xsl:stylesheet>