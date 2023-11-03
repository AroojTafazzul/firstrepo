<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:Doc="urn:swift:xsd:$tsmt.011.001.02"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	exclude-result-prefixes="tools">
	
	<xsl:param name="context"/>
	<xsl:param name="source"/>
	
	<xsl:output
		method="xml"
		version="1.0"
		encoding="UTF-8"
		indent="yes"
		cdata-section-elements="narrative_xml"/>
	
	<!-- Match template -->
	<xsl:template match="/">

		<!-- <xsl:variable name="messageType"><xsl:value-of select="tools:getTSUMessageInfo($context, //Doc:RltdMsgRef/Doc:Id, 'message_type')"/></xsl:variable>-->
		<bn_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/bn.xsd">
			<brch_code>00001</brch_code>
			<prod_stat_code>08</prod_stat_code>
			<product_code>BN</product_code>
			<tid><xsl:value-of select="//Doc:TxId/Doc:Id"/></tid>
			<!-- <xsl:if test="$messageType = '009'">
				<po_ref_id><xsl:value-of select="//Doc:UsrTxRef/Doc:Id"/></po_ref_id>
			</xsl:if>-->
			<ordered_amt><xsl:value-of select="tools:convertTSUAmount2MTPAmount(//Doc:RptdLineItm/Doc:OrdrdTtlNetAmt)"/></ordered_amt>
			<accepted_amt><xsl:value-of select="tools:convertTSUAmount2MTPAmount(//Doc:RptdLineItm/Doc:AccptdTtlNetAmt)"/></accepted_amt>
			<buyer_name><xsl:value-of select="//Doc:Buyr/Doc:Nm"/></buyer_name>
			<seller_name><xsl:value-of select="//Doc:Sellr/Doc:Nm"/></seller_name>
			<baseline_stat_code><xsl:value-of select="//Doc:TxSts/Doc:Sts"/></baseline_stat_code>
			<!-- <xsl:if test="$messageType = '009'">
				<narrative_xml>
					<xsl:value-of select="tools:retrieveXMLBaselineFromTSUMessage($context, //Doc:RltdMsgRef/Doc:Id, 'Baseln', '')"/>
				</narrative_xml>
			</xsl:if>-->
			<narrative_xml>
				<!-- <xsl:apply-templates select="$baseline"/>-->
				<!-- <xsl:value-of select="tools:updateBaselineFromBaselineReport($context, //Doc:TxId/Doc:Id, $source)"/>-->
				<xsl:value-of select="tools:updateBaseline(//Doc:TxId/Doc:Id, $source, '/config/swift/TSU/baseline.011.baselineUpdate.xsl')"/>
			</narrative_xml>
			
		</bn_tnx_record>
	</xsl:template>

	<!-- <xsl:template match = "*">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select = "node()|@*"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match = "@*">
		<xsl:attribute name="{local-name()}">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:template>-->

</xsl:stylesheet>
