<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	exclude-result-prefixes="tools">

	<xsl:param name="source"/>
	<xsl:param name="BIC"/>

	<xsl:output
		method="xml"
		version="1.0"
		encoding="UTF-8"
		indent="yes"
		cdata-section-elements="narrative_xml"/>
			
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:choose>
		<!-- When Forward Initial Submission or Forward Re Submission -->
		<xsl:when test="//RptPurp/Tp = 'FWIS' or //RptPurp/Tp = 'FWRE'">
		<bn_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/bn.xsd">
			<brch_code>00001</brch_code>
			<prod_stat_code>03</prod_stat_code>
			<product_code>BN</product_code>
			<tid><xsl:value-of select="//TxId/Id"/></tid>
			<po_ref_id><xsl:value-of select="//PurchsOrdrRef/Id"/></po_ref_id>
			<role>FPTR</role>
			<cur_code><xsl:value-of select="//Goods/TtlNetAmt/@Ccy"/></cur_code>
			<xsl:choose>
				<!-- When the FullPushThroughReport is a re-submission with no mismatch -->
				<xsl:when test="//RptPurp/Tp = 'FWRE' and TxSts/Sts = 'ESTD'">
					<ordered_amt><xsl:value-of select="tools:convertTSUAmount2MTPAmount(//Goods/TtlNetAmt)"/></ordered_amt>
					<!--<outstanding_amt><xsl:value-of select="tools:convertTSUAmount2MTPAmount(//Goods/TtlNetAmt)"/></outstanding_amt>-->
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
			<buyer_name><xsl:value-of select="//Buyr/Nm"/></buyer_name>
			<seller_name><xsl:value-of select="//Sellr/Nm"/></seller_name>
			<baseline_stat_code><xsl:value-of select="//TxSts/Sts"/></baseline_stat_code>
			
			<!-- Create the issuing bank only upon receipt of the first FullPushThroughReport message -->
			<xsl:if test="//RptPurp/Tp = 'FWIS'">
				<!--<issuing_bank>
					<abbv_name><xsl:value-of select="tools:retrieveBankAbbvNameFromBICCode(//SellrBk/BIC)"/></abbv_name>
					<name><xsl:value-of select="tools:retrieveBankNameFromBICCode(//SellrBk/BIC)"/></name>
					<address_line_1><xsl:value-of select="tools:retrieveBankAddressLine1FromBICCode(//SellrBk/BIC)"/></address_line_1>
					<address_line_2><xsl:value-of select="tools:retrieveBankAddressLine2FromBICCode(//SellrBk/BIC)"/></address_line_2>
					<dom><xsl:value-of select="tools:retrieveBankDomFromBICCode(//SellrBk/BIC)"/></dom>
					<reference><xsl:value-of select="tools:retrieveBankReferenceFromBICCode(//SellrBk/BIC)"/></reference>
					<iso_code><xsl:value-of select="//SellrBk/BIC"/></iso_code>
				</issuing_bank>-->
				<issuing_bank>
					<abbv_name><xsl:value-of select="tools:retrieveBankAbbvNameFromBICCode($BIC)"/></abbv_name>
					<name><xsl:value-of select="tools:retrieveBankNameFromBICCode($BIC)"/></name>
					<address_line_1><xsl:value-of select="tools:retrieveBankAddressLine1FromBICCode($BIC)"/></address_line_1>
					<address_line_2><xsl:value-of select="tools:retrieveBankAddressLine2FromBICCode($BIC)"/></address_line_2>
					<dom><xsl:value-of select="tools:retrieveBankDomFromBICCode($BIC)"/></dom>
					<reference><xsl:value-of select="tools:retrieveBankReferenceFromBICCode($BIC)"/></reference>
					<iso_code><xsl:value-of select="$BIC"/></iso_code>
				</issuing_bank>
			</xsl:if>
			
			<!-- Always create the Baseline as the baseline content could be possibly modified in a FullPushThroughReport -->
			<narrative_xml>
				<xsl:variable name="baseline" select="tools:createXMLBaselineV2($source, 'PushdThrghBaseln', '')"/>
				<xsl:value-of select="tools:createBaseline($baseline, '/config/swift/v2/TSU/baseline.018.baselineCreate.xsl', //TxSts/Sts)"/>
			</narrative_xml>
		</bn_tnx_record>
		</xsl:when>
		<!-- Otherwise we are dealing with a Forward Amend -->
		<xsl:otherwise>
			<bn_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/bn.xsd">
				<brch_code>00001</brch_code>
				<prod_stat_code>08</prod_stat_code>
				<product_code>BN</product_code>
				<tid><xsl:value-of select="//TxId/Id"/></tid>
				<baseline_stat_code><xsl:value-of select="//TxSts/Sts"/></baseline_stat_code>
			</bn_tnx_record>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
