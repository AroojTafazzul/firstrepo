<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="tools defaultresource">

	<xsl:output method="xml" indent="yes" />
	<xsl:param name="banks" />
	<xsl:param name="language">en</xsl:param>
	<xsl:variable name="companies" select="tools:manageBankBaseCurrency($banks)"/>
	<xsl:variable name="fxsource"><xsl:value-of select="defaultresource:getResource('FX_RATE_SOURCE')"/></xsl:variable>
	
	<!-- <xsl:variable name="bankAbbvName">
		<xsl:choose><xsl:when test="$banks != ''"><xsl:value-of select="$banks"/></xsl:when><xsl:otherwise>*</xsl:otherwise></xsl:choose>
	</xsl:variable> -->
	<xsl:variable name="bankAbbvName">*</xsl:variable>
	
	<xsl:template match="Message/Header[MsgType[. = 'FXRATE']]">
		<result>
		<xsl:if test="$fxsource='CASH'">
			<com.misys.portal.systemfeatures.common.ExchangeRateFile>
			 	<xsl:apply-templates select="/Message/Content/BankFXRate" mode="custom" />
			</com.misys.portal.systemfeatures.common.ExchangeRateFile>
		</xsl:if>
		</result>
	</xsl:template>
	<xsl:template match="BankFXRate" mode="custom">
		<xsl:variable name="Currency"><xsl:value-of select="Currency" /></xsl:variable>
		<xsl:variable name="Multiplicative"><xsl:value-of select="Multiplicative"/></xsl:variable>
		<xsl:variable name="BuyRate"><xsl:value-of select="BuyRate" /></xsl:variable>
		<xsl:variable name="MktRate"><xsl:value-of select="MktRate" /></xsl:variable>
		<xsl:variable name="SellRate"><xsl:value-of select="SellRate" /></xsl:variable>
		<!-- banks contain array list of banks -->
		<xsl:for-each select="$companies/companies/company">
    		 <xsl:call-template name="rate-apply">
			 	<xsl:with-param name="Currency"><xsl:value-of select="$Currency"/> </xsl:with-param>
			 	<xsl:with-param name="Multiplicative"><xsl:value-of select="$Multiplicative"/></xsl:with-param>
			 	<xsl:with-param name="BuyRate"><xsl:value-of select="$BuyRate"/> </xsl:with-param>
			 	<xsl:with-param name="MktRate"><xsl:value-of select="$MktRate"/> </xsl:with-param>
			 	<xsl:with-param name="SellRate"><xsl:value-of select="$SellRate"/> </xsl:with-param>
			 	<xsl:with-param name="bankname"><xsl:value-of select="company_name" /></xsl:with-param>
			 	<xsl:with-param name="baseIsoCode"><xsl:value-of select="base_cur_code" /></xsl:with-param>
			 </xsl:call-template>
  		</xsl:for-each>
		 
	</xsl:template>
	<xsl:template name="rate-apply">
		<xsl:param name="Currency"/>
		<xsl:param name="Multiplicative"/>
		<xsl:param name="BuyRate"/>
		<xsl:param name="MktRate"/>
		<xsl:param name="SellRate"/>
		<xsl:param name="bankname"/>
		<xsl:param name="baseIsoCode"/>
		
				<com.misys.portal.common.currency.Rate>
				<brch_code>00001</brch_code>
				<bank_abbv_name><xsl:value-of select="$bankname" /></bank_abbv_name>
				<xsl:choose>
				<!-- For division multiplicative tag will be 0 sent from back office  -->
					<xsl:when test ="$Multiplicative='0'">
						<iso_code>
							<xsl:value-of select="$baseIsoCode" />
						</iso_code>
						<base_iso_code >
							<xsl:value-of select="$Currency" />
						</base_iso_code>
					</xsl:when>
					<xsl:otherwise>
						<iso_code>
							<xsl:value-of select="$Currency" />
						</iso_code>
						<base_iso_code>
							<xsl:value-of select="$baseIsoCode" />
						</base_iso_code>
					</xsl:otherwise>
				</xsl:choose>
				<paty_val>1</paty_val>
				<buy_tt_rate>
					<xsl:value-of select="$BuyRate" />
				</buy_tt_rate>
				<mid_tt_rate>
					<xsl:value-of select="$MktRate" />
				</mid_tt_rate>
				<sell_tt_rate>
					<xsl:value-of select="$SellRate" />
				</sell_tt_rate>
				<euro_in_currency />
				<euro_rate>0</euro_rate>
			</com.misys.portal.common.currency.Rate>
	</xsl:template>
</xsl:stylesheet>
