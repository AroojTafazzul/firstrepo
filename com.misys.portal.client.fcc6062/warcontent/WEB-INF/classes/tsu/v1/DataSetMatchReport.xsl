<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<!--
   Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process TSU Acknowledgment  -->
	<xsl:template match="Document">
		<xsl:apply-templates select="tsmt.013.001.01"/>
	</xsl:template>
	<xsl:template match="tsmt.013.001.01">
		<po_tnx_record>
			<brch_code>00001</brch_code>
			<ref_id>?????</ref_id>
			<tnx_type_code>15</tnx_type_code>
			<prod_stat_code>
				<xsl:choose>
					<xsl:when test="Rpt/NbOfMisMtchs[.='0']">34</xsl:when>
					<xsl:otherwise>35</xsl:otherwise>
				</xsl:choose>
			</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>PO</product_code>
			<bo_comment>
				<xsl:choose>
					<xsl:when test="Rpt/NbOfMisMtchs[.='0']">
	Your counterparty has submited Documents that match your purchase order.
					
		1. Submitted document(s):
						<xsl:apply-templates select="CmpardDocRef"/>
					</xsl:when>
					<xsl:otherwise>
	Your counterparty has submited Documents that do not match your purchase order.
					
		1. Submitted document(s): <xsl:apply-templates select="CmpardDocRef"/>
						
		2. Mismatch Information(s).
			-Number of mismatch(es): <xsl:value-of select="Rpt/NbOfMisMtchs"/>
			-Details: 
				<xsl:apply-templates select="Rpt/MisMtchInf"/>
					</xsl:otherwise>
				</xsl:choose>
			</bo_comment>
		</po_tnx_record>
	</xsl:template>
	<!-- -->
	<xsl:template match="CmpardDocRef">
			-type: <xsl:choose>
						<xsl:when test="Tp[.='BASE']">Baseline</xsl:when>
						<xsl:when test="Tp[.='TRDS']">Transport Data Set</xsl:when>
						<xsl:when test="Tp[.='CODS']">Commercial data Set</xsl:when>
					</xsl:choose>-version: <xsl:value-of select="Vrsn"/>
	</xsl:template>
	<!-- -->
	<xsl:template match="MisMtchInf">
				<xsl:value-of select="SeqNb"/> Rule: <xsl:value-of select="RuleId"/>-<xsl:value-of select="RuleDesc"/>
				Elements: <xsl:apply-templates select="MisMtchdElmt"/>
	</xsl:template>
	<!-- -->
	<xsl:template match="MisMtchdElmt">
				<!--ElmtPth>String</ElmtPth-->
				Name: <xsl:value-of select="ElmtNm"/>, Value: <xsl:value-of select="ElmtVal"/>
				
	</xsl:template>
</xsl:stylesheet>
