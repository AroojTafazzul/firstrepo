<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="tools defaultresource">

	<xsl:param name="source"/>
	
	<xsl:output
		method="xml"
		version="1.0"
		encoding="UTF-8"
		indent="yes"
		cdata-section-elements="narrative_xml"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:variable name="messageDetails" select="tools:getTSUMessageDetailsByTid(//RltdTxRefs/TxId)"/>
		<xsl:variable name="refId"><xsl:value-of select="$messageDetails/tsu_message_details/ref_id"/></xsl:variable>
		<xsl:variable name="companyId"><xsl:value-of select="$messageDetails/tsu_message_details/company_id"/></xsl:variable>
		<xsl:variable name="companyName"><xsl:value-of select="$messageDetails/tsu_message_details/company_name"/></xsl:variable>
		<xsl:variable name="bankDetails" select="tools:retrieveBankDetailsFromBICCode(//BuyrBk/BIC)"/>	
		<xsl:variable name="bankAbbvName"><xsl:value-of select="$bankDetails/bank_details/bank_abbv_name"/></xsl:variable>
		<xsl:variable name="bankName"><xsl:value-of select="$bankDetails/bank_details/bank_name"/></xsl:variable>
		<xsl:variable name="bankAddrLine1"><xsl:value-of select="$bankDetails/bank_details/bank_addr_line_1"/></xsl:variable>
		<xsl:variable name="bankAddrLine2"><xsl:value-of select="$bankDetails/bank_details/bank_addr_line_2"/></xsl:variable>
		<xsl:variable name="bankDom"><xsl:value-of select="$bankDetails/bank_details/bank_dom"/></xsl:variable>
		<xsl:variable name="bankRef"><xsl:value-of select="$bankDetails/bank_details/bank_ref"/></xsl:variable>
		<xsl:variable name="orderedAmt"><xsl:value-of select="tools:convertTSUAmount2MTPAmount(//Goods/TtlNetAmt)"/></xsl:variable>
		<xsl:variable name="language"><xsl:value-of select="defaultresource:getResource('LANGUAGE')"/></xsl:variable>
		<xsl:variable name="createDate" select="tools:convertISODateTime2MTPDateTime(//RptId/CreDtTm,$language)"/>
		
		<tu_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/tu.xsd">
			<ref_id><xsl:value-of select="$refId"/></ref_id>
			<company_id><xsl:value-of select="$companyId"/></company_id>
			<company_name><xsl:value-of select="$companyName"/></company_name>
			<brch_code>00001</brch_code>
			<tnx_type_code>15</tnx_type_code>
			<prod_stat_code>03</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>TM</product_code>
			<bo_release_dttm><xsl:value-of select="tools:getCurrentDateTime()"/></bo_release_dttm>
			<creation_date><xsl:value-of select="$createDate"/></creation_date>
			<tid><xsl:value-of select="//RltdTxRefs/TxId"/></tid>
			<message_type>017</message_type>
			<ordered_amt><xsl:value-of select="$orderedAmt"/></ordered_amt>
			<tnx_cur_code><xsl:value-of select="//Goods/TtlNetAmt/@Ccy"/></tnx_cur_code>
			<tnx_amt><xsl:value-of select="$orderedAmt"/></tnx_amt>
			<cur_code><xsl:value-of select="//Goods/TtlNetAmt/@Ccy"/></cur_code>
			<baseline_stat_code><xsl:value-of select="//TxSts"/></baseline_stat_code>
			<request_for_action><xsl:value-of select="//ReqForActn/Tp"/></request_for_action>
			<rptid><xsl:value-of select="//RptId/Id"/></rptid>
			<rptdate><xsl:value-of select="$createDate"/></rptdate>
			<invoice_no><xsl:value-of select ="//ComrclDataSet/ComrclDocRef/InvcNb"/></invoice_no>
			<report_type/>
			<error_code></error_code>
			<error_msg></error_msg>
			<issuing_bank>
					<abbv_name><xsl:value-of select="$bankAbbvName"/></abbv_name>
					<name><xsl:value-of select="$bankName"/></name>
					<address_line_1><xsl:value-of select="$bankAddrLine1"/></address_line_1>
					<address_line_2><xsl:value-of select="$bankAddrLine2"/></address_line_2>
					<dom><xsl:value-of select="$bankDom"/></dom>
					<reference><xsl:value-of select="$bankRef"/></reference>
					<iso_code><xsl:value-of select="//BuyrBk/BIC"/></iso_code>
			</issuing_bank>
			<narrative_xml>
				<xsl:value-of select="$source"/>
			</narrative_xml>
		</tu_tnx_record>
	</xsl:template>

</xsl:stylesheet>
