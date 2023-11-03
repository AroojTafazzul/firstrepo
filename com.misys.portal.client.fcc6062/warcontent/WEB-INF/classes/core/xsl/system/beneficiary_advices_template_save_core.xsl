<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--
   Copyright (c) 2000-2012 Misys (http://www.misys.com),
   All Rights Reserved. 
-->   
   <xsl:template match="beneficiary_advice">
   		<parameter_data>
			<parm_id>P115</parm_id>
			<brch_code>00001</brch_code>
			<key_1><xsl:value-of select="templateId"/></key_1>
  			<key_2><xsl:value-of select="description"/></key_2>
  			<key_3><xsl:value-of select="all_entities"/></key_3>
			<xsl:for-each select="columns/column">
				<data>
					<data_1><xsl:value-of select="position()"/></data_1>
					<data_2><xsl:value-of select="./label"/></data_2>
					<data_3><xsl:value-of select="./type"/></data_3>
					<data_4><xsl:value-of select="./alignment"/></data_4>
					<data_5><xsl:value-of select="./width"/></data_5>
				</data>
			</xsl:for-each>
  		</parameter_data>
   </xsl:template>
</xsl:stylesheet>
