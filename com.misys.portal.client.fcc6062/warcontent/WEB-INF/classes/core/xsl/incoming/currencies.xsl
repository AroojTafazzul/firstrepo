<?xml version="1.0" encoding="UTF-8" ?>
<!--
  		Copyright (c) 2000-2008 Misys (http://www.misys.com)
  		All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="currency_records">
		<result>
			<com.misys.portal.interfaces.incoming.CurrencyFile>
				<xsl:apply-templates select="currency_record"/>
			</com.misys.portal.interfaces.incoming.CurrencyFile>
		</result>
	</xsl:template>

	<xsl:template match="currency_record">
		<com.misys.portal.common.currency.Currency>
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			<iso_code><xsl:value-of select="iso_code"/></iso_code>				
			<name><xsl:value-of select="name"/></name>
			<major_name><xsl:value-of select="major_name"/></major_name>
			<minor_name><xsl:value-of select="minor_name"/></minor_name>
			<decimal_number><xsl:value-of select="decimal_number"/></decimal_number>
			<parity><xsl:value-of select="parity"/></parity>
			<round_code><xsl:value-of select="round_code"/></round_code>
			<princ_country_code><xsl:value-of select="princ_country_code"/></princ_country_code>
		</com.misys.portal.common.currency.Currency>
	</xsl:template>
</xsl:stylesheet>
