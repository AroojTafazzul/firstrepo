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
	<xsl:variable name="messageDetails" select="tools:getTSUMessageDetailsByRequestId(//RltdMsgRef/Id)"/>
	<xsl:variable name="language"><xsl:value-of select="defaultresource:getResource('LANGUAGE')"/></xsl:variable>
	<xsl:variable name="refId" select="$messageDetails/tsu_message_details/ref_id"/>
	<xsl:variable name="companyName"><xsl:value-of select="$messageDetails/tsu_message_details/company_name"/></xsl:variable>
	<xsl:variable name="companyId"><xsl:value-of select="$messageDetails/tsu_message_details/company_id"/></xsl:variable>
	<xsl:variable name="bankAbbvName"><xsl:value-of select="$messageDetails/tsu_message_details/bank_abbv_name"/></xsl:variable>
	<xsl:variable name="bankName"><xsl:value-of select="$messageDetails/tsu_message_details/bank_name"/></xsl:variable>
	<xsl:variable name="bankAddrLine1"><xsl:value-of select="$messageDetails/tsu_message_details/bank_addr_line_1"/></xsl:variable>
	<xsl:variable name="bankAddrLine2"><xsl:value-of select="$messageDetails/tsu_message_details/bank_addr_line_2"/></xsl:variable>
	<xsl:variable name="bankDom"><xsl:value-of select="$messageDetails/tsu_message_details/bank_dom"/></xsl:variable>
	<xsl:variable name="bankRef"><xsl:value-of select="$messageDetails/tsu_message_details/bank_ref"/></xsl:variable>
	<xsl:variable name="bankISOCode"><xsl:value-of select="$messageDetails/tsu_message_details/bank_iso_code"/></xsl:variable>
	<xsl:variable name="rptDate" select="tools:convertISODateTime2MTPDateTime(//RptId/CreDtTm,$language)"/>
	<xsl:variable name="dateTime"><xsl:value-of select="tools:getCurrentDateTime()"/></xsl:variable>
		<tu_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/tu.xsd">
			<brch_code>00001</brch_code>
			<ref_id><xsl:value-of select="$refId"/></ref_id>
			<company_id><xsl:value-of select="$companyId"/></company_id>
			<company_name><xsl:value-of select="$companyName"/></company_name>
			<tnx_type_code>81</tnx_type_code>
			<prod_stat_code>03</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>TM</product_code>
			<creation_date><xsl:value-of select="tools:getCurrentDateTime()"/></creation_date>
			<message_type>037</message_type>
			<rptid><xsl:value-of select="//RptId/Id"/></rptid>
			<rptdate><xsl:value-of select="$rptDate"/></rptdate>
			<bo_release_dttm><xsl:value-of select="$dateTime"/></bo_release_dttm>
			<issuing_bank>
				<abbv_name><xsl:value-of select="$bankAbbvName"/></abbv_name>
				<name><xsl:value-of select="$bankName"/></name>
				<iso_code><xsl:value-of select="$bankISOCode"/></iso_code>
				<address_line_1><xsl:value-of select="$bankAddrLine1"/></address_line_1>
				<address_line_2><xsl:value-of select="$bankAddrLine2"/></address_line_2>
				<dom><xsl:value-of select="$bankDom"/></dom>
				<reference><xsl:value-of select="$bankRef"/></reference>
			</issuing_bank>
			<request_id><xsl:value-of select="//RltdMsgRef/Id"/></request_id>
			<baseline_stat_code><xsl:value-of select="//RptdItms/Sts"/></baseline_stat_code>
			<narrative_xml>
				<xsl:value-of select="$source"/>
			</narrative_xml>
		</tu_tnx_record>
	</xsl:template>

</xsl:stylesheet>
