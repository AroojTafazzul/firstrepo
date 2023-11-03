<?xml version="1.0" encoding="UTF-8"?>

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

<xsl:import href="bank_common.xsl"/>

<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	
	<xsl:template match="/">
		<xsl:apply-templates select="dm_tnx_record"/>
	</xsl:template>

	<!--TEMPLATE Main for LC records-->

	<xsl:template match="dm_tnx_record">

	<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"></script>
	<script type="text/javascript">
		<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
	</script>
	<script type="text/javascript" src="/content/OLD/javascript/com_currency.js"></script>
	<script type="text/javascript" src="/content/OLD/javascript/bank_common_reporting.js"></script>
	<script type="text/javascript" src="/content/OLD/javascript/bank_dm_reporting.js"></script>
	<script type="text/javascript" src="/content/OLD/javascript/com_amount.js"></script>
	<script type="text/javascript" src="/content/OLD/javascript/com_date.js"></script>
	<script type="text/javascript" src="/content/OLD/javascript/com_attachment.js"></script>
	
	<table border="0" width="100%" cellspacing="2" cellpadding="4" class="FORMTABLEBORDER">
	<tr>
	<td class="FORMTABLE" align="center">
	
	<table border="0">
	<!-- Display Common Reporting Input Area -->
	<xsl:call-template name="bank_reporting_area"/>
	
	<tr>
	<td align="left">
	
			
	</td>
	</tr>
	</table>
	
	</td>
	</tr>
	</table>

	</xsl:template>


</xsl:stylesheet>
