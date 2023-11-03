<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:Doc="urn:swift:xsd:$tsmt.018.001.02"
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
		<bn_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/bn.xsd">
			<brch_code>00001</brch_code>
			<prod_stat_code>03</prod_stat_code>
			<product_code>BN</product_code>
			<tid><xsl:value-of select="//Doc:TxId/Doc:Id"/></tid>
			<po_ref_id><xsl:value-of select="//Doc:PurchsOrdrRef/Doc:Id"/></po_ref_id>
			<role>FPTR</role>
			<cur_code><xsl:value-of select="//Doc:Goods/Doc:TtlNetAmt/@Ccy"/></cur_code>
			<xsl:choose>
				<!-- When the FullPushThroughReport is a re-submission with no mismatch -->
				<xsl:when test="//Doc:RptPurp/Doc:Tp = 'FWRE' and Doc:TxSts/Doc:Sts = 'ESTD'">
					<ordered_amt><xsl:value-of select="tools:convertTSUAmount2MTPAmount(//Doc:Goods/Doc:TtlNetAmt)"/></ordered_amt>
					<!--<outstanding_amt><xsl:value-of select="tools:convertTSUAmount2MTPAmount(//Doc:Goods/Doc:TtlNetAmt)"/></outstanding_amt>-->
					<accepted_amt>0</accepted_amt>
					<!--<pending_amt>0</pending_amt>-->
				</xsl:when>
				<xsl:otherwise>
					<ordered_amt>0</ordered_amt>
					<!--<outstanding_amt>0</outstanding_amt>-->
					<accepted_amt>0</accepted_amt>
					<!--<pending_amt>0</pending_amt>-->
				</xsl:otherwise>
			</xsl:choose>
			<buyer_name><xsl:value-of select="//Doc:Buyr/Doc:Nm"/></buyer_name>
			<seller_name><xsl:value-of select="//Doc:Sellr/Doc:Nm"/></seller_name>
			<baseline_stat_code><xsl:value-of select="//Doc:TxSts/Doc:Sts"/></baseline_stat_code>
			
			<!-- Create the issuing bank only upon receipt of the first FullPushThroughReport message -->
			<xsl:if test="//Doc:RptPurp/Doc:Tp = 'FWIS'">
				<issuing_bank>
					<abbv_name><xsl:value-of select="tools:retrieveBankAbbvNameFromBICCode(//Doc:SellrBk/Doc:BIC)"/></abbv_name>
					<name><xsl:value-of select="tools:retrieveBankNameFromBICCode(//Doc:SellrBk/Doc:BIC)"/></name>
					<address_line_1><xsl:value-of select="tools:retrieveBankAddressLine1FromBICCode(//Doc:SellrBk/Doc:BIC)"/></address_line_1>
					<address_line_2><xsl:value-of select="tools:retrieveBankAddressLine2FromBICCode(//Doc:SellrBk/Doc:BIC)"/></address_line_2>
					<dom><xsl:value-of select="tools:retrieveBankDomFromBICCode(//Doc:SellrBk/Doc:BIC)"/></dom>
					<reference><xsl:value-of select="tools:retrieveBankReferenceFromBICCode(//Doc:SellrBk/Doc:BIC)"/></reference>
					<iso_code><xsl:value-of select="//Doc:SellrBk/Doc:BIC"/></iso_code>
				</issuing_bank>
			</xsl:if>
			
			<!-- Always create the Baseline as the baseline content could be possibly modified in a FullPushThroughReport -->
			<narrative_xml>
				<xsl:variable name="baseline" select="tools:createXMLBaseline($source, 'PushdThrghBaseln', 'Doc')"/>
				<xsl:value-of select="tools:createBaseline($baseline, '/config/swift/TSU/baseline.018.baselineCreate.xsl', //Doc:TxSts/Doc:Sts)"/>
			</narrative_xml>
		</bn_tnx_record>
	</xsl:template>

</xsl:stylesheet>
