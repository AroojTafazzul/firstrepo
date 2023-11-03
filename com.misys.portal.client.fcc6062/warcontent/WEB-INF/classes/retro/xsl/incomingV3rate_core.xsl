<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com), All Rights Reserved. -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="tools defaultresource">
	
	<xsl:output method="xml" indent="yes" />
	<xsl:param name="banks"/>
	<xsl:variable name="companies" select="tools:manageBankBaseCurrency($banks)"/>	
	<xsl:variable name="fxsource"><xsl:value-of select="defaultresource:getResource('FX_RATE_SOURCE')"/></xsl:variable>			
	<xsl:template match="exchange_rate_records">		
		<xsl:if test="$fxsource='TI'">	
		<exchange_rate_records xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">	
			<xsl:apply-templates select="exchange_rate_record" mode="custom" />
		</exchange_rate_records>			
		</xsl:if>		
	</xsl:template>
	
	<xsl:template match="exchange_rate_record" mode="custom">
		<xsl:variable name="brch_code" select="brch_code"/>
		<xsl:variable name="iso_code" select="iso_code"/>
		<xsl:variable name="base_iso_code" select="base_iso_code"/>	
		<xsl:variable name="paty_val" select="paty_val"/>
		<xsl:variable name="buy_tt_rate" select="buy_tt_rate"/>	
		<xsl:variable name="mid_tt_rate" select="mid_tt_rate"/>	
		<xsl:variable name="sell_tt_rate" select="sell_tt_rate"/>	
		<xsl:variable name="euro_in_currency" select="euro_in_currency"/>		
		
		<xsl:for-each select="$companies/companies/company">
		<exchange_rate_record>
				 <xsl:variable name="bankAbbvName">
					<xsl:choose>
						<xsl:when test="company_name[.!='']"><xsl:value-of select="company_name"/></xsl:when>
						<xsl:otherwise>*</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>				
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>
				<bank_abbv_name><xsl:value-of select="$bankAbbvName"/></bank_abbv_name>
				<iso_code><xsl:value-of select="$iso_code"/></iso_code>				
				<base_iso_code><xsl:value-of select="$base_iso_code"/></base_iso_code>				
				<paty_val><xsl:value-of select="$paty_val"/></paty_val>
				<buy_tt_rate><xsl:value-of select="$buy_tt_rate"/></buy_tt_rate>
				<mid_tt_rate><xsl:value-of select="$mid_tt_rate"/></mid_tt_rate>
				<sell_tt_rate><xsl:value-of select="$sell_tt_rate"/></sell_tt_rate>
				<euro_in_currency><xsl:value-of select="$euro_in_currency"/></euro_in_currency>						
		</exchange_rate_record>		
  		</xsl:for-each>		 
	</xsl:template>


</xsl:stylesheet>