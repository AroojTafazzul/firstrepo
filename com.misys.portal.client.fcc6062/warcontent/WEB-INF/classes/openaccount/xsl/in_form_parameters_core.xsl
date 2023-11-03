<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
   Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates select="section_records"/>
	</xsl:template>
	
	<!-- Process Parameters -->
	<xsl:template match="section_records">
		<parameter_data>
			<xsl:element name="parm_id">P650</xsl:element>
			<xsl:element name="key_1">*</xsl:element>
			<xsl:element name="key_2">*</xsl:element>
			<xsl:apply-templates select="*"/>
		</parameter_data>
	</xsl:template>
	
	<xsl:template match="*">
		<xsl:if test="starts-with(name(),'section_') and .='Y'">
			<xsl:element name="data_1"><xsl:value-of select="name()"/></xsl:element>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
