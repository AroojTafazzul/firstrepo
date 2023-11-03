<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="*">
		<result>
			<com.misys.portal.product.util.SubsidiaryEntitlement>
				<xsl:if test="subsidiary_id">
						<subsidiary_id>
							<xsl:value-of select="subsidiary_id"/>
						</subsidiary_id>
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
					<xsl:if test="subsidiary_code">
						<subsidiary_code>
							<xsl:value-of select="subsidiary_code"/>
						</subsidiary_code>
					</xsl:if>
			</com.misys.portal.product.util.SubsidiaryEntitlement>
		</result>
	</xsl:template>
</xsl:stylesheet>