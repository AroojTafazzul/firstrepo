<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
   		Copyright (c) 2000-2005 NEOMAlogic (http://www.neomalogic.com),
		All Rights Reserved. 
	-->
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates select="report/entities"/>
	</xsl:template>
		
	<xsl:template match="entity">
		<parameter_data>
			<brch_code>00001</brch_code>
			<parm_id>P310</parm_id>
			<key_1><xsl:value-of select="../../report_id"/></key_1>
			<key_2><xsl:value-of select="../../report_name"/></key_2>
			<key_3><xsl:value-of select="abbv_name"/></key_3>
		</parameter_data>
	</xsl:template>
</xsl:stylesheet>
