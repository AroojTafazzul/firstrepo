<?xml version="1.0"?>
<!--
  		Copyright (c) 2000-2008 Misys (http://www.misys.com)
  		All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				exclude-result-prefixes="tools">
			
	<!-- Exchange Rate Records -->
	<xsl:template match="Publications" mode="fxrate">
		<exchange_rate_records xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			<xsl:apply-templates select="Publication/ItemArray/anyType" mode="PublishedRate"/>
		</exchange_rate_records>
	</xsl:template>
					
	<xsl:template match="anyType" mode="PublishedRate">
		<xsl:variable name="bank_abbv_name" select="tools:retrieveBankabbvNameFromBranchCode(./BR)"/>
		<xsl:variable name="brch_code" select="BR"/>
		<xsl:variable name="iso_code" select="CURRENCY"/>
		<xsl:variable name="base_iso_code" select="COUNTERCURRENCY"/>	
		<xsl:variable name="rate" select="RATE"/>	
		<xsl:variable name="rate_type" select="BIDOFFER"/>		
		<xsl:variable name="euro_rate" select="0"/>
	
		<exchange_rate_record>
			
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			
			<bank_abbv_name><xsl:value-of select="$bank_abbv_name"/></bank_abbv_name>
		
			<iso_code><xsl:value-of select="$iso_code"/></iso_code>
			
			<base_iso_code><xsl:value-of select="$base_iso_code"/></base_iso_code>
			
			<paty_val>
				<xsl:choose>
					<xsl:when test="string-length(substring-before($rate, '.'))>4">100</xsl:when>
					<xsl:otherwise>1</xsl:otherwise>
				</xsl:choose>
			</paty_val>
			
			<xsl:choose>
				<xsl:when test="$rate_type='B'">
					<buy_tt_rate><xsl:value-of select="$rate"/></buy_tt_rate>
				</xsl:when>
				<xsl:otherwise>
					<buy_tt_rate/>
				</xsl:otherwise>
			</xsl:choose>
			
			<xsl:choose>
				<xsl:when test="$rate_type='O'">
					<sell_tt_rate><xsl:value-of select="$rate"/></sell_tt_rate>
				</xsl:when>
				<xsl:otherwise>
					<sell_tt_rate/>
				</xsl:otherwise>
			</xsl:choose>
			
			<xsl:choose>
				<xsl:when test="$rate_type='M'">
					<mid_tt_rate><xsl:value-of select="$rate"/></mid_tt_rate>
				</xsl:when>
				<xsl:otherwise>
					<mid_tt_rate/>
				</xsl:otherwise>
			</xsl:choose>
			
			<euro_in_currency/>

			<euro_rate><xsl:value-of select="$euro_rate"/></euro_rate>
	
			<!-- additional_field name="direct_mode" type="string" scope="none">indirect</additional_field -->
	
		</exchange_rate_record>
	</xsl:template>
		
</xsl:stylesheet>