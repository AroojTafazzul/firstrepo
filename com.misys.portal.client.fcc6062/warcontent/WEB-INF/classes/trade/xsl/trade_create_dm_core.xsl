<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization securityCheck utils">
		
<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:import href="product_addons.xsl"/>
  	<xsl:import href="collaboration/collaboration.xsl"/>
    <xsl:import href="com_cross_references.xsl"/>
  
	<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>

  <!-- Get the session's informations -->
	<xsl:param name="rundata"/>

	<xsl:template match="/">
		<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"></script>
		<script type="text/javascript">
			<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script type="text/javascript" src="/content/OLD/javascript/com_currency.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/trade_create_dm.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_amount.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_date.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/trade_common_dm.js"/>

    <xsl:if test="securityCheck:hasPermission(utils:getUserACL($rundata),'collaboration_access',utils:getUserEntities($rundata))">
      <xsl:call-template name="COLLABORATION_JAVASCRIPT"/>
    </xsl:if>

		<xsl:apply-templates select="dm_tnx_record" mode="folder"/>
    
    <!-- Collaboration window -->
    <xsl:if test="securityCheck:hasPermission(utils:getUserACL($rundata),'collaboration_access',utils:getUserEntities($rundata))">
      <xsl:call-template name="collaboration">
        <xsl:with-param name="editable">true</xsl:with-param>
        <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
		<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
        <xsl:with-param name="entityFormName">fakeform1</xsl:with-param>
        <xsl:with-param name="productCode"><xsl:value-of select="product_code"/></xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    
	</xsl:template>


	<!--Import the common dm templates -->
	<xsl:include href="trade_common_dm.xsl"/>

</xsl:stylesheet>
