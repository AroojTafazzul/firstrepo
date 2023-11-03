<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:Doc="urn:swift:xsd:$tsmt.001.001.02"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	exclude-result-prefixes="tools">
	
	<!--<xsl:param name="context"/>-->

	<xsl:output
		method="xml"
		version="1.0"
		encoding="UTF-8"
		indent="yes"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<!--<xsl:variable name="messageType"><xsl:value-of select="tools:getTSUMessageInfo($context, //Doc:AckdMsgRef/Doc:Id, 'message_type')"/></xsl:variable>-->
		<xsl:variable name="messageType"><xsl:value-of select="tools:getTSUMessageInfo(//Doc:AckdMsgRef/Doc:Id, 'message_type')"/></xsl:variable>
		<bn_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/bn.xsd">
			<brch_code>00001</brch_code>
			<prod_stat_code>03</prod_stat_code>
			<product_code>BN</product_code>
			<tid><xsl:value-of select="//Doc:TxId/Doc:Id"/></tid>
			<xsl:if test="$messageType = '019'">
				<!--<po_ref_id><xsl:value-of select="tools:getTSUMessageInfo($context, //Doc:AckdMsgRef/Doc:Id, 'po_ref_id')"/></po_ref_id>-->
				<po_ref_id><xsl:value-of select="tools:getTSUMessageInfo(//Doc:AckdMsgRef/Doc:Id, 'po_ref_id')"/></po_ref_id>
			</xsl:if>
			<baseline_stat_code><xsl:value-of select="//Doc:TxSts/Doc:Sts"/></baseline_stat_code>
		</bn_tnx_record>
	</xsl:template>

</xsl:stylesheet>
