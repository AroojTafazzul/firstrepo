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
	<xsl:template match="event_record">
		<parameter_data>

			<brch_code>00001</brch_code>
			<parm_id>P954</parm_id>

			<xsl:if test="company_id">
				<company_id>
					<xsl:value-of select="company_id"/>
				</company_id>
			</xsl:if>
			
			<xsl:if test="type">
				<key_1>
					<xsl:value-of select="type"/>
				</key_1>
			</xsl:if>
			<xsl:if test="occurrence_id">
				<key_3>
					<xsl:value-of select="occurrence_id"/>
				</key_3>
			</xsl:if>
			
			<xsl:if test="start_date">
				<data_1>
					<xsl:value-of select="start_date"/>
				</data_1>
			</xsl:if>
			<xsl:if test="end_date">
				<data_2>
					<xsl:value-of select="end_date"/>
				</data_2>
			</xsl:if>
			<xsl:if test="date_recursive_type">
				<data_3>
					<xsl:value-of select="date_recursive_type"/>
				</data_3>
			</xsl:if>
			<xsl:if test="day_of_week">
				<data_4>
					<xsl:value-of select="day_of_week"/>
				</data_4>
			</xsl:if>
			<xsl:if test="day_of_month">
				<data_5>
					<xsl:value-of select="day_of_month"/>
				</data_5>
			</xsl:if>
			<xsl:if test="date_type">
				<data_6>
					<xsl:value-of select="date_type"/>
				</data_6>
			</xsl:if>
			<xsl:if test="title">
				<data_7>
					<xsl:value-of select="title"/>
				</data_7>
			</xsl:if>
			<xsl:if test="type">
				<data_8>
					<xsl:value-of select="type"/>
				</data_8>
			</xsl:if>
			<xsl:if test="description">
				<data_9>
					<xsl:value-of select="substring(description,1,255)"/>
				</data_9>
			</xsl:if>
			
		</parameter_data>
	</xsl:template>

</xsl:stylesheet>
