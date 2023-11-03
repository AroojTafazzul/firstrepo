<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

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
		<xsl:apply-templates select="document_record"/>
	</xsl:template>

	<xsl:template match="document_record">
		<parameter_data>
			<parm_id>P051</parm_id>
			<xsl:if test="brch_code">
				<brch_code><xsl:value-of select="brch_code"/></brch_code>
			</xsl:if>
			<xsl:if test="company_id">
				<company_id><xsl:value-of select="company_id"/></company_id>
			</xsl:if>
			<key_1><xsl:value-of select="document_format"/></key_1>
			<key_2><xsl:value-of select="document_code"/></key_2>
			<xsl:apply-templates select="transformation"/>
		</parameter_data>
	</xsl:template>

	<!-- Template for Transformation Description -->
	<xsl:template match="transformation">
		<xsl:element name="data_{position()}">
			<xsl:value-of select="code"/>
		</xsl:element>
		
	</xsl:template>

		
</xsl:stylesheet>
