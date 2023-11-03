<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--
   Correspondent Bank for EC save stylesheet.
-->
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Process Currency details -->
	<xsl:template match="existing_cur_list/existing_cur_details">
		<parameter_data>
			<brch_code>00001</brch_code>
			<parm_id>P502</parm_id>
			<key_2><xsl:value-of select="currency_code"/></key_2>
			<data_1><xsl:value-of select="currency_description"/></data_1>		
		</parameter_data>
	</xsl:template>
</xsl:stylesheet>
