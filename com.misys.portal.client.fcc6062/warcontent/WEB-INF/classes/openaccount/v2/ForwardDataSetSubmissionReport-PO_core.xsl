<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:default="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:tsutools="xalan://com.misys.portal.tsu.util.common.Tools"
	xmlns:tsuinterfacetools="xalan://com.misys.portal.tsu.interfaces.xml.incoming.Tools"
	xmlns:tools="xalan://com.misys.portal.openaccount.product.baseline.util.Tools"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	exclude-result-prefixes="default tools localization tsuinterfacetools">

	<xsl:import href="common.xsl"/>
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:param name="context"/>
	<xsl:param name="language"/>
	<xsl:param name="BIC"/>
	<xsl:param name="source"/>
	
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
	<!-- There can be multiple PO events as an invoice can refer to multiple POs -->
	<xsl:template match="TxRltdRefs/TxId">
		<xsl:variable name="tid"><xsl:value-of select="."/></xsl:variable>
		<xsl:variable name="poRefId"><xsl:value-of select="tsutools:retrievePOfromTID($tid, $BIC)"/></xsl:variable>
		
		<xsl:if test="$poRefId != ''">
		</xsl:if>
		
	</xsl:template>
		
	<xsl:template match="FwdDataSetSubmissnRpt">
	
		<!-- TODO: Browse all TIDs in case the dataset refers to multiple POs -->
		<!-- <xsl:for-each select="TxRltdRefs/TxId">-->
			<xsl:variable name="tid"><xsl:value-of select="."/></xsl:variable>
			<xsl:variable name="poRefId"><xsl:value-of select="tsutools:retrievePOfromTID(TxRltdRefs/TxId, $BIC)"/></xsl:variable>
		
			<po_tnx_record
					xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
					xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/po.xsd">
				<brch_code>00001</brch_code>
				<ref_id><xsl:value-of select="$poRefId"/></ref_id>
				<company_name><xsl:value-of select="tsutools:retrieveFieldValueFromProduct('PO', $poRefId, 'company_name')"/></company_name>
				<tnx_type_code>15</tnx_type_code>
				<sub_tnx_type_code/>
				<prod_stat_code>45</prod_stat_code>
				<tnx_stat_code>04</tnx_stat_code>
				<product_code>PO</product_code>
				<tnx_cur_code><xsl:value-of select="//ComrclDataSet/Goods/TtlNetAmt/@Ccy"/></tnx_cur_code>
				<tnx_amt>
					<xsl:call-template name="TP_amount">
						<xsl:with-param name="amount"><xsl:value-of select="//ComrclDataSet/Goods/TtlNetAmt"/></xsl:with-param>
					</xsl:call-template>
				</tnx_amt>
	      	
				<additional_field name="hasLineItem" type="string" scope="none">Y</additional_field>
				<additional_field name="generatePDFInvoice" type="string" scope="none">Y</additional_field>
				<additional_field name="xmlInvoice" type="string" scope="none">
					<xsl:value-of select="tsuinterfacetools:generateXMLInvoiceFromForwardDataSetSubmissionReport($context, $source)"/>
				</additional_field>
				<issuing_bank>
					<abbv_name><xsl:value-of select="tsutools:retrieveBankAbbvNameFromBICCode($BIC)"/></abbv_name>
					<iso_code><xsl:value-of select="$BIC"/></iso_code>
				</issuing_bank>
			</po_tnx_record>
		
		<!-- </xsl:for-each>-->
		
		<!-- <xsl:if test="$poRefId != ''">

			<po_tnx_record
					xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
					xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/po.xsd">
				<brch_code>00001</brch_code>
				<ref_id><xsl:value-of select="$poRefId"/></ref_id>
				<tnx_type_code>15</tnx_type_code>
				<sub_tnx_type_code/>
				<prod_stat_code>45</prod_stat_code>
				<tnx_stat_code>04</tnx_stat_code>
				<product_code>PO</product_code>
				<tnx_cur_code><xsl:value-of select="ComrclDataSet/Goods/TtlNetAmt/@Ccy"/></tnx_cur_code>
				<tnx_amt>
					<xsl:call-template name="TP_amount">
						<xsl:with-param name="amount"><xsl:value-of select="ComrclDataSet/Goods/TtlNetAmt"/></xsl:with-param>
					</xsl:call-template>
				</tnx_amt>
	      	
				<additional_field name="hasLineItem" type="string" scope="none">Y</additional_field>
				<additional_field name="generatePDFInvoice" type="string" scope="none">Y</additional_field>
				<additional_field name="xmlInvoice" type="string" scope="none">Y</additional_field>
				<issuing_bank>
					<abbv_name><xsl:value-of select="tools:retrieveBankAbbvNameFromBICCode($BIC)"/></abbv_name>
					<iso_code><xsl:value-of select="$BIC"/></iso_code>
				</issuing_bank>
			</po_tnx_record>
			
		</xsl:if>-->
		
	</xsl:template>

</xsl:stylesheet>