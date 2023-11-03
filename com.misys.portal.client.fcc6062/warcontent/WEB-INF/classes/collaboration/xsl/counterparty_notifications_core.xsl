<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--
   Copyright (c) 2000-2005 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
  <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- Process Beneficiary -->
	<xsl:template match="static_beneficiary">
        
    <parameter_data>
      <parm_id>P250</parm_id>
      <company_id><xsl:value-of select="company_id"/></company_id>
      <key_1><xsl:value-of select="beneficiary_company_abbv_name"/></key_1>
      <xsl:for-each select="//*[starts-with(name(), 'counterparty_permission_') and .='Y']">
        <xsl:element name="data_{position()}">
          <xsl:value-of select="translate(substring-after(name(), 'counterparty_permission_'), $lowercase, $uppercase)"/>
        </xsl:element>
      </xsl:for-each>
    </parameter_data>
          
	</xsl:template>
  
</xsl:stylesheet>
