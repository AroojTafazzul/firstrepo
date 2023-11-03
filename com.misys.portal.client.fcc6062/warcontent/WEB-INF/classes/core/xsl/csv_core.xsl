<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	exclude-result-prefixes="localization">
<xsl:output method="text"/>
<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<!-- Get the language code -->
	<xsl:param name="language"/>
	
	<!-- Match template -->
	<xsl:template match="table">
		<xsl:apply-templates select="//*/tr"/>
	</xsl:template>

    <!-- Add Carriage return for each row -->
    <xsl:template match="tr"><xsl:text>
</xsl:text> 
      <xsl:apply-templates select="td"/>
	
   </xsl:template>
  
  <!-- Transform td into cell -->
  <xsl:template match="td">"<xsl:value-of select ="font"/>"<xsl:value-of select="localization:getGTPString($language, 'CSV_LIST_SEPARATOR')"/><xsl:if test="@colspan"><xsl:call-template name="colspan"><xsl:with-param name="colspan"><xsl:value-of select="@colspan"/></xsl:with-param></xsl:call-template></xsl:if></xsl:template>

  <!-- Add empty cells in case of colspan -->
  <xsl:template name="colspan">
    <xsl:param name="colspan"/><xsl:if test="number($colspan)>1">" "<xsl:value-of select="localization:getGTPString($language, 'CSV_LIST_SEPARATOR')"/><xsl:call-template name="colspan"><xsl:with-param name="colspan"><xsl:value-of select="number($colspan)-1"/></xsl:with-param></xsl:call-template></xsl:if>
  </xsl:template>
</xsl:stylesheet>