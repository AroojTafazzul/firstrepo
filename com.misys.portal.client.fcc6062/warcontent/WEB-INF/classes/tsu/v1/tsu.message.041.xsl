<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:Doc="urn:swift:xsd:$tsmt.041.001.02"
	xmlns:resources="xalan://com.misys.portal.core.util.JetspeedResources"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	exclude-result-prefixes="resources tools">

	<xsl:param name="source"/>
	
	<xsl:output
		method="xml"
		version="1.0"
		encoding="UTF-8"
		indent="yes"
		cdata-section-elements="narrative_xml"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:variable name="bicCode"><xsl:value-of select="resources:getString('product.tsu.issuer.bic.default')"/></xsl:variable>
		<tu_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/tu.xsd">
			<brch_code>00001</brch_code>
			<tnx_type_code>15</tnx_type_code>
			<prod_stat_code>03</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>TU</product_code>
			<creation_date><xsl:value-of select="tools:getCurrentDateTime()"/></creation_date>
			<message_type>041</message_type>
			<issuing_bank>
				<abbv_name><xsl:value-of select="tools:retrieveBankAbbvNameFromBICCode($bicCode)"/></abbv_name>
				<name><xsl:value-of select="tools:retrieveBankNameFromBICCode($bicCode)"/></name>
				<address_line_1><xsl:value-of select="tools:retrieveBankAddressLine1FromBICCode($bicCode)"/></address_line_1>
				<address_line_2><xsl:value-of select="tools:retrieveBankAddressLine2FromBICCode($bicCode)"/></address_line_2>
				<dom><xsl:value-of select="tools:retrieveBankDomFromBICCode($bicCode)"/></dom>
				<reference><xsl:value-of select="tools:retrieveBankReferenceFromBICCode($bicCode)"/></reference>
				<iso_code><xsl:value-of select="$bicCode"/></iso_code>
			</issuing_bank>
			<narrative_xml>
				<xsl:value-of select="$source"/>
			</narrative_xml>
		</tu_tnx_record>
	</xsl:template>

</xsl:stylesheet>
