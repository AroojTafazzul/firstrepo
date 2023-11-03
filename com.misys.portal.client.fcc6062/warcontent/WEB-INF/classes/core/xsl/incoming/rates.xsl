<?xml version="1.0" encoding="UTF-8" ?>
<!--
  		Copyright (c) 2000-2008 Misys (http://www.misys.com)
  		All Rights Reserved. 
-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	exclude-result-prefixes="tools utils">	

	<xsl:param name="banks"/>
	<xsl:variable name="companies" select="tools:manageBankBaseCurrency($banks)"/>	
	<xsl:template match="exchange_rate_records">
		<result>
			<com.misys.portal.systemfeatures.common.ExchangeRateFile>
				<xsl:apply-templates select="exchange_rate_record"/>
			</com.misys.portal.systemfeatures.common.ExchangeRateFile>
		</result>
	</xsl:template>
	
	<xsl:template match="exchange_rate_record">
		<xsl:variable name="brch_code" select="brch_code"/>
		<xsl:variable name="iso_code" select="iso_code"/>
		<xsl:variable name="base_iso_code" select="base_iso_code"/>	
		<xsl:variable name="paty_val" select="paty_val"/>
		<xsl:variable name="buy_tt_rate" select="buy_tt_rate"/>	
		<xsl:variable name="mid_tt_rate" select="mid_tt_rate"/>	
		<xsl:variable name="sell_tt_rate" select="sell_tt_rate"/>	
		<xsl:variable name="euro_in_currency" select="euro_in_currency"/>
		<xsl:variable name="euro_rate" select="euro_rate"/>	
		<xsl:variable name="update_date" select="update_date"/>	
		<xsl:variable name="start_value_date" select="start_value_date"/>	
		<xsl:variable name="end_value_date" select="end_value_date"/>
		
		<xsl:choose>
			<xsl:when test="bank_abbv_name[.!='']">
				<com.misys.portal.common.currency.Rate>
					<brch_code><xsl:value-of select="$brch_code"/></brch_code>
					<bank_abbv_name><xsl:value-of select="bank_abbv_name"/></bank_abbv_name>
					<iso_code><xsl:value-of select="$iso_code"/></iso_code>				
					<base_iso_code><xsl:value-of select="$base_iso_code"/></base_iso_code>				
					<paty_val><xsl:value-of select="$paty_val"/></paty_val>
					<buy_tt_rate><xsl:value-of select="$buy_tt_rate"/></buy_tt_rate>
					<mid_tt_rate><xsl:value-of select="$mid_tt_rate"/></mid_tt_rate>
					<sell_tt_rate><xsl:value-of select="$sell_tt_rate"/></sell_tt_rate>
					<euro_in_currency><xsl:value-of select="$euro_in_currency"/></euro_in_currency>
					<euro_rate><xsl:value-of select="$euro_rate"/></euro_rate>
					<update_date><xsl:value-of select="$update_date"/></update_date>
					<start_value_date><xsl:value-of select="$start_value_date"/></start_value_date>
					<end_value_date><xsl:value-of select="$end_value_date"/></end_value_date>
					<xsl:apply-templates select="additional_field"/>
				</com.misys.portal.common.currency.Rate>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="$companies/companies/company">
					<xsl:variable name="bankAbbvName">
						
						<xsl:choose>
							<xsl:when test="company_name[.!=''] and utils:checkCompanyType(company_name)"><xsl:value-of select="company_name"/></xsl:when>
							<xsl:otherwise>*</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>	
					<com.misys.portal.common.currency.Rate>
						<brch_code><xsl:value-of select="$brch_code"/></brch_code>
						<bank_abbv_name><xsl:value-of select="$bankAbbvName"/></bank_abbv_name>
						<iso_code><xsl:value-of select="$iso_code"/></iso_code>				
						<base_iso_code><xsl:value-of select="$base_iso_code"/></base_iso_code>				
						<paty_val><xsl:value-of select="$paty_val"/></paty_val>
						<buy_tt_rate><xsl:value-of select="$buy_tt_rate"/></buy_tt_rate>
						<mid_tt_rate><xsl:value-of select="$mid_tt_rate"/></mid_tt_rate>
						<sell_tt_rate><xsl:value-of select="$sell_tt_rate"/></sell_tt_rate>
						<euro_in_currency><xsl:value-of select="$euro_in_currency"/></euro_in_currency>
						<euro_rate><xsl:value-of select="$euro_rate"/></euro_rate>
						<update_date><xsl:value-of select="$update_date"/></update_date>
						<start_value_date><xsl:value-of select="$start_value_date"/></start_value_date>
						<end_value_date><xsl:value-of select="$end_value_date"/></end_value_date>
						<xsl:apply-templates select="additional_field"/>
					</com.misys.portal.common.currency.Rate>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
