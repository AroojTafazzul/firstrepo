<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="tools utils defaultresource">

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
		<xsl:variable name="messageType"><xsl:value-of select="tools:getTSUMessageInfo(//AckdMsgRef/Id, 'message_type')"/></xsl:variable>
		<xsl:variable name="refId"><xsl:value-of select="tools:getTSUMessageRefByTnxInfo(//AckdMsgRef/Id, 'ref_id')"/></xsl:variable>
		<xsl:variable name="isUpdatedTnx"><xsl:value-of select="tools:updateTransaction($refId, //AckdMsgRef/Id, //TxId/Id)"/></xsl:variable>
		<xsl:variable name="language"><xsl:value-of select="defaultresource:getResource('LANGUAGE')"/></xsl:variable>
		<xsl:variable name="createDate" select="tools:convertISODateTime2MTPDateTime(//AckId/CreDtTm,$language)"/>
		<tu_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/tu.xsd">
			<ref_id><xsl:value-of select="$refId"/></ref_id>
			<tnx_id><xsl:value-of select="//AckdMsgRef/Id"/></tnx_id>
			<brch_code>00001</brch_code>
			<tnx_type_code>15</tnx_type_code>
			<prod_stat_code>02</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>TM</product_code>
			<creation_date><xsl:value-of select="$createDate"/></creation_date>
			<bo_release_dttm><xsl:value-of select="tools:getCurrentDateTime()"/></bo_release_dttm>
			<tid><xsl:value-of select="//TxId/Id"/></tid>
			<xsl:if test="$messageType = '019'">
				<po_ref_id><xsl:value-of select="tools:getTSUMessageInfo(//AckdMsgRef/Id, 'po_ref_id')"/></po_ref_id>
			</xsl:if>
			<message_type>001</message_type>
			<baseline_stat_code><xsl:value-of select="//TxSts/Sts"/></baseline_stat_code>
			<request_for_action><xsl:value-of select="//ReqForActn/Tp"/></request_for_action>
			<report_type/>
			<error_code></error_code>
			<error_msg></error_msg>
			<narrative_xml>
				<xsl:value-of select="$source"/>
			</narrative_xml>
		</tu_tnx_record>
	</xsl:template>

</xsl:stylesheet>
