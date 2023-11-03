<?xml version="1.0" encoding="UTF-8" ?>
<!--
  		Copyright (c) 2000-2008 Misys (http://www.misys.com)
  		All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="codedata_records">
		<result>
			<com.misys.portal.interfaces.incoming.CodeDataFile/>
			<xsl:apply-templates select="codedata_record"/>
		</result>
	</xsl:template>

	<xsl:template match="codedata_record">
		<com.misys.portal.common.tools.CodeData>
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			<company_id><xsl:value-of select="company_id"/></company_id>				
			<product_code><xsl:value-of select="product_code"/></product_code>				
			<code_id><xsl:value-of select="code_id"/></code_id>				
			<code_val><xsl:value-of select="code_val"/></code_val>				
			<short_desc><xsl:value-of select="short_desc"/></short_desc>				
			<long_desc><xsl:value-of select="long_desc"/></long_desc>				
		</com.misys.portal.common.tools.CodeData>
	</xsl:template>
</xsl:stylesheet>
