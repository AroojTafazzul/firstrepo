<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:default="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:tnxidgenerator="xalan://com.misys.portal.product.util.generator.TransactionIdGenerator"
	xmlns:refidgenerator="xalan://com.misys.portal.product.util.generator.ReferenceIdGenerator"
	exclude-result-prefixes="default tools localization tnxidgenerator refidgenerator">

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
	<xsl:template match="DataSetMtchRpt">

		<xsl:variable name="tid"><xsl:value-of select="TxId/Id"/></xsl:variable>
		<xsl:variable name="soRefId"><xsl:value-of select="tools:retrieveSOfromTID($tid, $BIC)"/></xsl:variable>
		
		<xsl:if test="$soRefId != ''">
			<xsl:variable name="soTnxId"><xsl:value-of select="tnxidgenerator:generate()"/></xsl:variable>
			<xsl:variable name="nbMismatches"><xsl:value-of select="Rpt/NbOfMisMtchs"/></xsl:variable>
			<xsl:variable name="tuRefId" select="refidgenerator:generate('TU')"/>

			<so_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/so.xsd">
				<brch_code>00001</brch_code>
				<ref_id><xsl:value-of select="$soRefId"/></ref_id>
				<tnx_id><xsl:value-of select="$soTnxId"/></tnx_id>
				<company_name><xsl:value-of select="tools:retrieveFieldValueFromProduct('SO', $soRefId, 'company_name')"/></company_name>
				<tnx_type_code>15</tnx_type_code>
				<sub_tnx_type_code/>
				<prod_stat_code>
					<xsl:choose>
						<xsl:when test="$nbMismatches = '0'">74</xsl:when>
						<xsl:otherwise>75</xsl:otherwise>
					</xsl:choose>
				</prod_stat_code>
				<tnx_stat_code>04</tnx_stat_code>
				<product_code>SO</product_code>
				<additional_field name="hasLineItem" type="string" scope="none">N</additional_field>
				<additional_field name="RptId" type="string" scope="transaction" description="DataSetMatchReport Id">
					<xsl:value-of select="RptId"/>
				</additional_field>
				<advising_bank>
					<abbv_name><xsl:value-of select="tools:retrieveBankAbbvNameFromBICCode($BIC)"/></abbv_name>
					<iso_code><xsl:value-of select="$BIC"/></iso_code>
				</advising_bank>
				<bo_comment>
					<xsl:if test="$nbMismatches != '0'">
						<xsl:value-of select="localization:getGTPString($language, 'INTERFACE_PO_INVOICE_MISMATCH')"/>
						<xsl:apply-templates select="Rpt/MisMtchInf"/>
					</xsl:if>
				</bo_comment>

				<!-- Link DataSetMatchReport with Purchase Order Advice -->
				<cross_references>
					<cross_reference>
						<ref_id><xsl:value-of select="$soRefId"/></ref_id>
						<tnx_id><xsl:value-of select="$soTnxId"/></tnx_id>
						<product_code>SO</product_code>
						<child_product_code>TU</child_product_code>
						<child_ref_id><xsl:value-of select="$tuRefId"/></child_ref_id>
						<type_code>
							<xsl:choose>
								<xsl:when test="$nbMismatches != '0'">01</xsl:when>
								<xsl:otherwise>07</xsl:otherwise>
							</xsl:choose>
						</type_code>
					</cross_reference>
				</cross_references>

			</so_tnx_record>
		</xsl:if>
	</xsl:template>
	
	<!-- Create the BO comment from the TSU DataSetMatchReport -->
	<xsl:template match="MisMtchInf">
		<xsl:call-template name="format_line">
			<xsl:with-param name="input_text" select="RuleDesc"/>
			<xsl:with-param name="length">60</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

</xsl:stylesheet>
