<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
   		Copyright (c) 2000-2012 Misys (http://www.misys.com),
		All Rights Reserved. 
	-->
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates select="beneficiary_advice/customers"/>
	</xsl:template>
		
	<xsl:template match="customer">
		<parameter_data>
			<brch_code>00001</brch_code>
			<parm_id>P116</parm_id>
			<key_1><xsl:value-of select="../../templateId"/></key_1>
			<key_2><xsl:value-of select="abbv_name"/></key_2>
			<key_3><xsl:value-of select="entity"/></key_3>
		</parameter_data>
	</xsl:template>
</xsl:stylesheet>