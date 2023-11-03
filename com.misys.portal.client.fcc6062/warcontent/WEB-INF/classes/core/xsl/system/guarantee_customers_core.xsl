<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
   		Copyright (c) 2000-2005 NEOMAlogic (http://www.neomalogic.com),
		All Rights Reserved. 
	-->
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates select="guarantee/customers"/>
	</xsl:template>
		
	<xsl:template match="customer">
		<parameter_data>
			<brch_code>00001</brch_code>
			<company_id><xsl:value-of select="../../user_company_id"/></company_id>
			<parm_id>P227</parm_id>
			<key_1><xsl:value-of select="../../name_"/></key_1>
			<key_2><xsl:value-of select="abbv_name"/></key_2>
			<key_3>
				<xsl:choose>
					<xsl:when test="not(entity) or entity=''">**</xsl:when>
					<xsl:otherwise><xsl:value-of select="entity"/></xsl:otherwise>
				</xsl:choose>
			</key_3>
			<key_9>
				<xsl:choose>
					<xsl:when test="not(entity_name) or entity_name='' or entity_name='null' ">**</xsl:when>
					<xsl:otherwise><xsl:value-of select="entity_name"/></xsl:otherwise>
				</xsl:choose>
			</key_9>
		</parameter_data>
	</xsl:template>
</xsl:stylesheet>
