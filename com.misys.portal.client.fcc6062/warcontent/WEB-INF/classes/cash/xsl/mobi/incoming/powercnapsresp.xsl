<?xml version="1.0" encoding="UTF-8"?>
	<!--
	   Copyright (c) 2000-2012 Misys (http://www.misys.com),
	   All Rights Reserved. 
	-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:default="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="tools localization">
 
	<xsl:param name="language">en</xsl:param>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:template match="text()">
		<xsl:value-of select='normalize-space()'/>
	</xsl:template>

	<!-- Process FT -->
	<xsl:template match="Application/CommonResHdr[APPNAME[. = 'POWERCNAPS']] ">
		<xsl:variable name="process_info" select="INFO"/>
		<xsl:variable name="process_status" select="PROCSTATUS"/>
		<xsl:variable name="references" select="tools:retrieveManageReferences('FT',TRANSID)"/>
		<xsl:variable name="ref_id" select="$references/references/ref_id"/>
		<xsl:variable name="tnx_id" select="$references/references/tnx_id"/>
		<xsl:variable name="company_id" select="$references/references/company_id"/>
		<xsl:variable name="company_name" select="$references/references/company_name"/>
		<xsl:variable name="main_bank_abbv_name" select="$references/references/main_bank_abbv_name"/>
		<xsl:variable name="brch_code" select="$references/references/brch_code"></xsl:variable>
		
				
		<com.misys.portal.cash.product.ft.common.FundTransfer ref_id="{$ref_id}" tnx_id="{$tnx_id}">
			<company_name><xsl:value-of select="$company_name"/></company_name>
			<prod_stat_code>
				<xsl:if test="$process_status = '00'">02</xsl:if>
				<xsl:if test="$process_status != '00'">01</xsl:if>			
			</prod_stat_code>
			<tnx_stat_code>
				<xsl:if test="$process_status = '00'">03</xsl:if>
				<xsl:if test="$process_status != '00'">04</xsl:if>			
			</tnx_stat_code>
			<xsl:if test="$process_status = '00'">
				<sub_tnx_stat_code>88</sub_tnx_stat_code>
			</xsl:if>
			<product_code>FT</product_code>
		</com.misys.portal.cash.product.ft.common.FundTransfer>

		<!-- Banks -->
		<com.misys.portal.product.common.Bank role_code="01">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<abbv_name><xsl:value-of select="$main_bank_abbv_name"/></abbv_name>
				<name><xsl:value-of select="$main_bank_abbv_name"/></name>
		</com.misys.portal.product.common.Bank>
		
		<xsl:call-template name="COUNTERPARTY">
			<xsl:with-param name="references" select="$references"></xsl:with-param>
			<xsl:with-param name="brchCode" select="$brch_code"></xsl:with-param>
			<xsl:with-param name="companyId"><xsl:value-of select="$company_id"/></xsl:with-param>
			<xsl:with-param name="refId"><xsl:value-of select="$ref_id"/></xsl:with-param>
			<xsl:with-param name="tnxId"><xsl:value-of select="$tnx_id"/></xsl:with-param>
		</xsl:call-template>
		
		<xsl:if test="$process_status != '00'">
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="$process_info"/>
				<xsl:with-param name="type_code">11</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>		
		</xsl:if>

	</xsl:template>
	
</xsl:stylesheet>
