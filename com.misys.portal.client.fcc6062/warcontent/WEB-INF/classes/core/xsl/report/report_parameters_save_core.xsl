<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
		xmlns:business_codes="xalan://com.misys.portal.common.resources.BusinessCodesResourceProvider"
		exclude-result-prefixes="localization securityCheck security converttools business_codes">

<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:output method="xml" indent="no"/>
	
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<!--TEMPLATE Main-->
	<xsl:template match="parameters_data">
		<parameter_data>
			<xsl:if test="brch_code">
				<brch_code>
					<xsl:value-of select="brch_code"/>
				</brch_code>
			</xsl:if>
			<xsl:if test="parm_id">
				<parm_id>
					<xsl:value-of select="parm_id"/>
				</parm_id>
			</xsl:if>
			<xsl:if test="company_id">
				<company_id>
					<xsl:value-of select="company_id"/>
				</company_id>
			</xsl:if>
			<xsl:if test="wild_card_ind">
				<wild_card_ind>
					<xsl:value-of select="wild_card_ind"/>
				</wild_card_ind>
			</xsl:if>
			<xsl:if test="data_1">
				<data_1>
					<xsl:value-of select="data_1"/>
				</data_1>
			</xsl:if>
			<xsl:if test="data_3">
				<data_3>
					<xsl:value-of select="data_3"/>
				</data_3>
			</xsl:if>
			<xsl:if test="data_4">
				<data_4>
					<xsl:value-of select="data_4"/>
				</data_4>
			</xsl:if>
			<xsl:if test="data_5">
				<data_5>
					<xsl:value-of select="data_5"/>
				</data_5>
			</xsl:if>
			<xsl:if test="data_6">
				<data_6>
					<xsl:value-of select="data_6"/>
				</data_6>
			</xsl:if>
			
		</parameter_data>
	</xsl:template>

</xsl:stylesheet>
