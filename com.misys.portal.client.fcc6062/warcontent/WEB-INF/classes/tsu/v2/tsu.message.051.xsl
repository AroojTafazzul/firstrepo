<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:resources="xalan://com.misys.portal.core.util.JetspeedResources"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	exclude-result-prefixes="resources tools">

	<xsl:param name="source"/>
	
	<xsl:output
		method="xml"
		version="1.0"
		encoding="UTF-8"
		indent="yes"
		cdata-section-elements="narrative_xml"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:variable name="bicCode" select="tools:retrieveBicCode()"/>
		<xsl:variable name="messageDetails" select="tools:getTSUMessageDetailsByTid(//TxId/Id)"/>		
		<xsl:variable name="refId"><xsl:value-of select="$messageDetails/tsu_message_details/ref_id"/></xsl:variable>
		<xsl:variable name="companyId"><xsl:value-of select="$messageDetails/tsu_message_details/company_id"/></xsl:variable>
		<xsl:variable name="companyName"><xsl:value-of select="$messageDetails/tsu_message_details/company_name"/></xsl:variable>
		<xsl:variable name="bankDetailsFromBic" select="tools:retrieveBankDetailsFromBICCode($bicCode)" />
		<xsl:variable name="bankAbbvName" select="$bankDetailsFromBic/bank_details/bank_abbv_name"/>
		<xsl:variable name="bankAddrLine1" select="$bankDetailsFromBic/bank_details/bank_addr_line_1"/>
		<xsl:variable name="bankAddrLine2" select="$bankDetailsFromBic/bank_details/bank_addr_line_2"/>
		<xsl:variable name="bankName" select="$bankDetailsFromBic/bank_details/bank_name"/>
		<xsl:variable name="bankDom" select="$bankDetailsFromBic/bank_details/bank_dom"/>
		<xsl:variable name="bankRef" select="$bankDetailsFromBic/bank_details/bank_ref"/>
		<xsl:variable name="dateTime"><xsl:value-of select="tools:getCurrentDateTime()"/></xsl:variable>
		<xsl:variable name="tnxAmt"><xsl:value-of select="$messageDetails/tsu_message_details/ordered_amt"/></xsl:variable>
		<xsl:variable name="tnxCurCode"><xsl:value-of select="$messageDetails/tsu_message_details/cur_code"/></xsl:variable>
		<xsl:variable name="language"><xsl:value-of select="defaultresource:getResource('LANGUAGE')"/></xsl:variable>
		
		<tu_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/tu.xsd">
			<brch_code>00001</brch_code>
			<rptid><xsl:value-of select="//NtfctnId/Id"/></rptid>
			<company_id><xsl:value-of select="$companyId"/></company_id>
			<company_name><xsl:value-of select="$companyName"/></company_name>
			<tid><xsl:value-of select="//TxId/Id"/></tid>
			<ref_id><xsl:value-of select="$refId"/></ref_id>
			<product_code>TM</product_code>
			<tnx_type_code>15</tnx_type_code>
			<prod_stat_code>03</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>TM</product_code>
			<creation_date><xsl:value-of select="tools:getCurrentDateTime()"/></creation_date>
			<tnx_cur_code><xsl:value-of select="$tnxCurCode"/></tnx_cur_code>
			<tnx_amt><xsl:value-of select="$tnxAmt"/></tnx_amt>
			<tid><xsl:value-of select="//TxId/Id"/></tid>
			<message_type>051</message_type>
			<baseline_stat_code><xsl:value-of select="//TxSts/Sts"/></baseline_stat_code>
			<request_for_action><xsl:value-of select="//ReqForActn/Tp"/></request_for_action>
			<tma_ack>R</tma_ack> <!-- Included R as the value so that 51-message should not available in the pending tnx list for incoming TM. Default values are  [Y/N/null] -->
			<issuing_bank>
					<abbv_name><xsl:value-of select="$bankAbbvName"/></abbv_name>
					<name><xsl:value-of select="$bankName"/></name>
					<address_line_1><xsl:value-of select="$bankAddrLine1"/></address_line_1>
					<address_line_2><xsl:value-of select="$bankAddrLine2"/></address_line_2>
					<dom><xsl:value-of select="$bankDom"/></dom>
					<reference><xsl:value-of select="$bankRef"/></reference>
			</issuing_bank>
			<narrative_xml>
				<xsl:value-of select="$source"/>
			</narrative_xml>
		</tu_tnx_record>
	</xsl:template>

</xsl:stylesheet>
