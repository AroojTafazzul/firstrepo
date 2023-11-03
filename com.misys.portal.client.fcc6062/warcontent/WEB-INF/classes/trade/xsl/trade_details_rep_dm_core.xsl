<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization converttools securityCheck utils">
		
<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
<xsl:import href="trade_common.xsl"/>
<xsl:import href="collaboration/collaboration.xsl"/>

<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
  
  <!-- Available modules -->
  <xsl:param name="modules"/>
	
	<xsl:template match="/">
		<script type="text/javascript" src="/content/OLD/javascript/trade_common_dm.js"></script>
      <xsl:if test="$modules/modules/module[. = 'collaboration'] and tnx_id">
      <xsl:call-template name="COLLABORATION_JAVASCRIPT"/>
    </xsl:if>
    
		<xsl:apply-templates select="dm_tnx_record" mode="folder"/>
    
    <xsl:if test="securityCheck:hasPermission(utils:getUserACL($rundata),'collaboration_access',utils:getUserEntities($rundata)) and tnx_id">
      <xsl:call-template name="COLLABORATION_JAVASCRIPT"/>
    </xsl:if>

    
	</xsl:template>
	
	<!-- We redirect to the DM reporting layout -->
	<xsl:include href="trade_common_rep_dm.xsl"/>

	<!--TEMPLATE Main-->

	
	
</xsl:stylesheet>
