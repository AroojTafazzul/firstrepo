<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output
		method="xml"
		version="1.0"
		encoding="UTF-8"
		indent="yes"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<bn_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/bn.xsd">
			<brch_code>00001</brch_code>
			<prod_stat_code>03</prod_stat_code>
			<product_code>BN</product_code>
			<tid><xsl:value-of select="//TxId/Id"/></tid>
			<!-- <po_ref_id><xsl:value-of select="//UsrTxRef/Id"/></po_ref_id>-->
			<baseline_stat_code><xsl:value-of select="//XtndedSts/Sts"/></baseline_stat_code>
		</bn_tnx_record>
	</xsl:template>

</xsl:stylesheet>
