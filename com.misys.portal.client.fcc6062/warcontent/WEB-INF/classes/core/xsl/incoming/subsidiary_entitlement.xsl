<?xml version="1.0" encoding="UTF-8"?>
<!--
   Copyright (c) 2000-2010 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="tools">
		
	<xsl:template match="userCategories">
		<result>
			<com.misys.portal.interfaces.incoming.EntitlementSet>
				<xsl:apply-templates select="category" />
			</com.misys.portal.interfaces.incoming.EntitlementSet>
		</result>
	</xsl:template>
	<xsl:template match="category">
	<xsl:variable name="references"
			select="tools:manageCompanyEntitlementReferences(corporation, categoryCode, categoryDesc)" />
		<com.misys.portal.product.util.CompanyEntitlement>
			<xsl:if test="entitlement_id">
			<entitlement_id>
				<xsl:value-of select="entitlement_id"/>
			</entitlement_id>
		</xsl:if>
			<entitlement_code>
				<xsl:value-of select="$references/references/entitlement_code"/>
			</entitlement_code>
			<company_id>
				<xsl:value-of select="$references/references/company_id"/>
			</company_id>
			<entitlement_description>
				<xsl:value-of select="$references/references/entitlement_description"/>
			</entitlement_description>
		</com.misys.portal.product.util.CompanyEntitlement>
	</xsl:template>	
</xsl:stylesheet>