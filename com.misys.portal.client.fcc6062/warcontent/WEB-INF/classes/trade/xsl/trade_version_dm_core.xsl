<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		exclude-result-prefixes="localization">
		
<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:import href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:import href="../../core/xsl/common/com_cross_references.xsl"/>
	
	<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	
	<xsl:template match="/">
		<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"></script>
		<script type="text/javascript">
			<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script type="text/javascript" src="/content/OLD/javascript/com_currency.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/trade_open_dm.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_amount.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_date.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/trade_common_dm.js"></script>

		<xsl:apply-templates select="dm_tnx_record" mode="version"/>
	</xsl:template>


	<!--Import the common dm templates -->
	<xsl:include href="trade_common_dm_open.xsl"/>

</xsl:stylesheet>
