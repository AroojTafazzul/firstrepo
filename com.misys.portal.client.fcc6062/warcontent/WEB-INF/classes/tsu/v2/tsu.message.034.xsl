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
		<tu_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/tu.xsd">
			<brch_code>00001</brch_code>
			<tnx_type_code>15</tnx_type_code>
			<prod_stat_code>03</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>TU</product_code>
			<creation_date><xsl:value-of select="tools:getCurrentDateTime()"/></creation_date>
			<tid><xsl:value-of select="//TxId/Id"/></tid>
			<!-- <po_ref_id><xsl:value-of select="//UsrTxRef/Id"/></po_ref_id>-->
			<message_type>034</message_type>
			<baseline_stat_code><xsl:value-of select="//NonXtndedSts/Sts"/></baseline_stat_code>
			<request_for_action><xsl:value-of select="//ReqForActn/Tp"/></request_for_action>
			<narrative_xml>
				<xsl:value-of select="$source"/>
			</narrative_xml>
		</tu_tnx_record>
	</xsl:template>

</xsl:stylesheet>
