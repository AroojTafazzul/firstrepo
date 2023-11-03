<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:default="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	exclude-result-prefixes="default tools localization">

	<xsl:import href="common.xsl"/>
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:param name="context"/>
	<xsl:param name="language"/>
	<xsl:param name="BIC"/>
	
	<!--
	Copyright (c) 2000-2007 NEOMAlogic (http://www.neomalogic.com),
	All Rights Reserved. 
	-->
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="Document">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Process TSU Message -->
	<xsl:template match="MisMtchRjctnNtfctn">

		<xsl:variable name="inRefId"><xsl:value-of select="tools:retrieveRefIdFromDataSetMatchReportId(DataSetMtchRptRef/Id, 'IN')"/></xsl:variable>
		
		<xsl:if test="$inRefId != '' and tools:doesProductExist('IN', $inRefId)">
			<in_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/in.xsd">
				<brch_code>00001</brch_code>
				<ref_id><xsl:value-of select="$inRefId"/></ref_id>
				<tnx_type_code>36</tnx_type_code>
				<sub_tnx_type_code/>
				<prod_stat_code>76</prod_stat_code>
				<tnx_stat_code>04</tnx_stat_code>
				<product_code>IN</product_code>
				<additional_field name="hasLineItem" type="string" scope="none">N</additional_field>
				<issuing_bank>
					<abbv_name><xsl:value-of select="tools:retrieveBankAbbvNameFromBICCode($BIC)"/></abbv_name>
					<iso_code><xsl:value-of select="$BIC"/></iso_code>
				</issuing_bank>
				<bo_comment>
					<xsl:value-of select="localization:getGTPString($language, 'INTERFACE_PO_TO_IN_REJECT')"/>
					<xsl:value-of select="RjctnRsn/MisMtchInf/GblRjctnRsn/Desc"/>
					<xsl:apply-templates select="RjctnRsn/RjctdElmt"/>
				</bo_comment>
			</in_tnx_record>
		</xsl:if>
	</xsl:template>
	
	<!-- Create the BO comment from the TSU MisMatchRejectionNotification -->
	<xsl:template match="RjctdElmt">
		<xsl:call-template name="format_line">
			<xsl:with-param name="input_text" select="IndvRjctnRsn"/>
			<xsl:with-param name="length">60</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

</xsl:stylesheet>
