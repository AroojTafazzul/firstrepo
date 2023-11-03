<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	exclude-result-prefixes="tools">

	<xsl:param name="source"/>
	
	<xsl:output
		method="xml"
		version="1.0"
		encoding="UTF-8"
		indent="yes"
		cdata-section-elements="narrative_xml"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:variable name="messageDetails" select="tools:getTSUMessageDetailsByTid(//TxId/Id)"/>
		<xsl:variable name="refId"><xsl:value-of select="$messageDetails/tsu_message_details/ref_id"/></xsl:variable>
		<xsl:variable name="companyId"><xsl:value-of select="$messageDetails/tsu_message_details/company_id"/></xsl:variable>
		<xsl:variable name="companyName"><xsl:value-of select="$messageDetails/tsu_message_details/company_name"/></xsl:variable>
		<xsl:variable name="dateTime"><xsl:value-of select="tools:getCurrentDateTime()"/></xsl:variable>
		<xsl:variable name="language"><xsl:value-of select="defaultresource:getResource('LANGUAGE')"/></xsl:variable>
		<xsl:variable name="createDate" select="tools:convertISODateTime2MTPDateTime(//RjctnId/CreDtTm,$language)"/>
		<xsl:variable name="bankAbbvName"><xsl:value-of select="tools:retrieveCompanyAbbvName($refId)"/></xsl:variable>
			<tu_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/tu.xsd">
				<ref_id><xsl:value-of select="$refId"/></ref_id>
				<company_id><xsl:value-of select="$companyId"/></company_id>
				<company_name><xsl:value-of select="$companyName"/></company_name>
				<brch_code>00001</brch_code>
				<tnx_type_code>15</tnx_type_code>
				<prod_stat_code>03</prod_stat_code>
				<tnx_stat_code>04</tnx_stat_code>
				<product_code>TM</product_code>
				<tid><xsl:value-of select="//TxId/Id"/></tid>
				<!-- <po_ref_id><xsl:value-of select="//UsrTxRef/Id"/></po_ref_id>-->
				<message_type>007</message_type>
				<baseline_stat_code><xsl:value-of select="//TxSts/Sts"/></baseline_stat_code>
				<request_for_action><xsl:value-of select="//ReqForActn/Tp"/></request_for_action>
				<bo_release_dttm><xsl:value-of select="$dateTime"/></bo_release_dttm>
				<creation_date><xsl:value-of select="$createDate"/></creation_date>
				<report_type></report_type>
				<rptid><xsl:value-of select="//RjctnId/Id"/></rptid>
				<error_code></error_code>
				<error_msg></error_msg>
				<issuing_bank>
					<abbv_name><xsl:value-of select="$bankAbbvName"/></abbv_name>
				</issuing_bank>
				<narrative_xml>
					<xsl:value-of select="$source"/>
				</narrative_xml>
			</tu_tnx_record>
	</xsl:template>

</xsl:stylesheet>
