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
		<xsl:variable name="bicCode" select="tools:retrieveBicCode()"/>
		<xsl:variable name="messageDetails" select="tools:getTSUMessageDetailsByTid(//TxId/Id)"/>
		<xsl:variable name="refId"><xsl:value-of select="$messageDetails/tsu_message_details/ref_id"/></xsl:variable>
		<xsl:variable name="companyId"><xsl:value-of select="$messageDetails/tsu_message_details/company_id"/></xsl:variable>
		<xsl:variable name="companyName"><xsl:value-of select="$messageDetails/tsu_message_details/company_name"/></xsl:variable>
		<xsl:variable name="isSeller" select="tools:isSeller($bicCode,//DataSetMtchRpt/SellrBk/BIC,//DataSetMtchRpt/BuyrBk/BIC,$messageDetails)"/>
		
		<xsl:variable name="bankDetailsFromBuyerBic" select="tools:retrieveBankDetailsFromBICCode(//DataSetMtchRpt/BuyrBk/BIC)" />
		<xsl:variable name="bankDetailsFromSellerBic" select="tools:retrieveBankDetailsFromBICCode(//DataSetMtchRpt/SellrBk/BIC)" />
		<xsl:variable name="bankAbbvName">
			<xsl:choose>
					<xsl:when test="$isSeller = 'true'">
						<xsl:value-of select="$bankDetailsFromSellerBic/bank_details/bank_abbv_name"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$bankDetailsFromBuyerBic/bank_details/bank_abbv_name"/>
					</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="bankName">
				<xsl:choose>
					<xsl:when test="$isSeller = 'true'">
						<xsl:value-of select="$bankDetailsFromSellerBic/bank_details/bank_name"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$bankDetailsFromBuyerBic/bank_details/bank_name"/>
					</xsl:otherwise>
				</xsl:choose>
		</xsl:variable>
		<xsl:variable name="bankAddrLine1">
			<xsl:choose>
					<xsl:when test="$isSeller = 'true'">
						<xsl:value-of select="$bankDetailsFromSellerBic/bank_details/bank_addr_line_1"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$bankDetailsFromBuyerBic/bank_details/bank_addr_line_1"/>
					</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="bankAddrLine2">
			<xsl:choose>
					<xsl:when test="$isSeller = 'true'">
						<xsl:value-of select="$bankDetailsFromSellerBic/bank_details/bank_addr_line_2"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$bankDetailsFromBuyerBic/bank_details/bank_addr_line_2"/>
					</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="bankDom">
			<xsl:choose>
					<xsl:when test="$isSeller = 'true'">
						<xsl:value-of select="$bankDetailsFromSellerBic/bank_details/bank_dom"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$bankDetailsFromBuyerBic/bank_details/bank_dom"/>
					</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="bankRef">
			<xsl:choose>
					<xsl:when test="$isSeller = 'true'">
						<xsl:value-of select="$bankDetailsFromSellerBic/bank_details/bank_ref"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$bankDetailsFromBuyerBic/bank_details/bank_ref"/>
					</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
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
			<tid><xsl:value-of select="//TxId/Id"/></tid>
			<message_type>013</message_type>
			<baseline_stat_code><xsl:value-of select="//TxSts/Sts"/></baseline_stat_code>
			<request_for_action><xsl:value-of select="//ReqForActn/Tp"/></request_for_action>
			<rptid><xsl:value-of select="//RptId/Id"/></rptid>
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
					<xsl:choose>
						<xsl:when test="$isSeller = 'true'">
							<iso_code><xsl:value-of select="//SellrBk/BIC"/></iso_code>
						</xsl:when>
						<xsl:otherwise>
							<iso_code><xsl:value-of select="//BuyrBk/BIC"/></iso_code>
						</xsl:otherwise>
					</xsl:choose>
			</issuing_bank>
			<narrative_xml>
				<xsl:value-of select="$source"/>
			</narrative_xml>
		</tu_tnx_record>
	</xsl:template>

</xsl:stylesheet>
