<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	exclude-result-prefixes="tools">
	
	<xsl:output
		method="xml"
		version="1.0"
		encoding="UTF-8"
		indent="yes"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:variable name="messageType"><xsl:value-of select="tools:getTSUMessageInfo(//AckdMsgRef/Id, 'message_type')"/></xsl:variable>
		<bn_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/bn.xsd">
			<brch_code>00001</brch_code>
			<prod_stat_code>03</prod_stat_code>
			<product_code>BN</product_code>
			<tid><xsl:value-of select="//TxId/Id"/></tid>
			<xsl:if test="$messageType = '019'">
				<po_ref_id><xsl:value-of select="tools:getTSUMessageInfo(//AckdMsgRef/Id, 'po_ref_id')"/></po_ref_id>
			</xsl:if>
			<baseline_stat_code><xsl:value-of select="//TxSts/Sts"/></baseline_stat_code>
		</bn_tnx_record>
	</xsl:template>

</xsl:stylesheet>
