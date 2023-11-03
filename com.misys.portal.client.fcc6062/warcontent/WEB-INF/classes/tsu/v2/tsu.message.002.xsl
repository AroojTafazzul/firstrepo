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
			<creation_date><xsl:value-of select="tools:getCurrentDateTime()"/></creation_date>
			<product_code>TU</product_code>
			<!-- <tid><xsl:value-of select="//TxId/Id"/></tid>
			<po_ref_id><xsl:value-of select="//UsrTxRef/Id"/></po_ref_id>-->
			<message_type>002</message_type>
			<xsl:if test="//RptdNtty/BIC">
			<issuing_bank>
				<abbv_name><xsl:value-of select="tools:retrieveBankAbbvNameFromBICCode(//RptdNtty/BIC)"/></abbv_name>
				<name><xsl:value-of select="tools:retrieveBankNameFromBICCode(//RptdNtty/BIC)"/></name>
				<address_line_1><xsl:value-of select="tools:retrieveBankAddressLine1FromBICCode(//RptdNtty/BIC)"/></address_line_1>
				<address_line_2><xsl:value-of select="tools:retrieveBankAddressLine2FromBICCode(//RptdNtty/BIC)"/></address_line_2>
				<dom><xsl:value-of select="tools:retrieveBankDomFromBICCode(//RptdNtty/BIC)"/></dom>
				<reference><xsl:value-of select="tools:retrieveBankReferenceFromBICCode(//RptdNtty/BIC)"/></reference>
				<iso_code><xsl:value-of select="//RptdNtty/BIC"/></iso_code>
			</issuing_bank>
			</xsl:if>
			<narrative_xml>
				<xsl:value-of select="$source"/>
			</narrative_xml>
		</tu_tnx_record>
	</xsl:template>

</xsl:stylesheet>
