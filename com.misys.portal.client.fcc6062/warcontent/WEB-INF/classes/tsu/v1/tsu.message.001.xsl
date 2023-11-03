<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:Doc="urn:swift:xsd:$tsmt.001.001.02"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	exclude-result-prefixes="tools utils">

	<!--<xsl:param name="context"/>-->
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
		<xsl:variable name="messageType"><xsl:value-of select="tools:getTSUMessageInfo(//Doc:AckdMsgRef/Doc:Id, 'message_type')"/></xsl:variable>
		<tu_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/tu.xsd">
			<brch_code>00001</brch_code>
			<tnx_type_code>15</tnx_type_code>
			<prod_stat_code>03</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>TU</product_code>
			<creation_date><xsl:value-of select="tools:getCurrentDateTime()"/></creation_date>
			<tid><xsl:value-of select="//Doc:TxId/Doc:Id"/></tid>
			<xsl:if test="$messageType = '019'">
				<po_ref_id><xsl:value-of select="tools:getTSUMessageInfo(//Doc:AckdMsgRef/Doc:Id, 'po_ref_id')"/></po_ref_id>
			</xsl:if>
			<message_type>001</message_type>
			<baseline_stat_code><xsl:value-of select="//Doc:TxSts/Doc:Sts"/></baseline_stat_code>
			<request_for_action><xsl:value-of select="//Doc:ReqForActn/Doc:Tp"/></request_for_action>
			<link_ref_id><xsl:value-of select="//Doc:AckdMsgRef/Doc:Id"/></link_ref_id>
			<narrative_xml>
				<xsl:value-of select="$source"/>
			</narrative_xml>
		</tu_tnx_record>
	</xsl:template>

</xsl:stylesheet>
