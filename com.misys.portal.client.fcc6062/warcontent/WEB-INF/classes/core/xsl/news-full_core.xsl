<?xml version="1.0" encoding="UTF-8" ?>

<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 version="1.0"
 xmlns:appdata="xalan://com.misys.portal.common.tools.GTPApplicationData"
 xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
 exclude-result-prefixes="appdata">
<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
	This product includes software developed by the Java Apache Project (http://java.apache.org/).
-->
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

    <!-- News parent template -->
	<xsl:template match="/content">
      <xsl:apply-templates select="/content/channel/item"/>
	</xsl:template>

    <!-- News Items -->
	<xsl:template match="/content/channel/item">
     <div class="para">
      <div class="icon">
       <xsl:call-template name="topics">
        <xsl:with-param name="topic"><xsl:value-of select="./topic"/></xsl:with-param>
       </xsl:call-template>
      </div>
      <div class="paracontent">
       <h3>
        <xsl:choose>
         <xsl:when test="link[. != '']">
          <a>
           <xsl:attribute name="href"><xsl:value-of select="link"/></xsl:attribute>
           <xsl:value-of select="./title"/>
          </a>
         </xsl:when> 
         <xsl:otherwise>
          <xsl:value-of select="./title"/>         
         </xsl:otherwise>
        </xsl:choose>
       </h3>
       <p>
        <xsl:apply-templates select="./quote"/>
        <xsl:value-of select="./description" disable-output-escaping="yes"/>
       </p>
      </div>
     </div>
     <div class="clear">&nbsp;</div>
	</xsl:template>

    <!-- Quote -->
	<xsl:template match="/content/channel/item/quote">
     <p class="para-quote">from:
	  <a>
	   <xsl:attribute name="href"><xsl:value-of select="./link"/></xsl:attribute>
	   <xsl:value-of select="./author"/>
	  </a>
	 </p>
     <xsl:apply-templates select="./p"/>
	</xsl:template>

	<xsl:template match="p">
     <xsl:value-of select="."/>
	</xsl:template>
    
	<xsl:template name="topics">
     <xsl:param name="topic"/>
	 <xsl:variable name="link"  select="/content/channel/topics/entry[@name=$topic]/image/link"/>
	 <xsl:variable name="url"   select="/content/channel/topics/entry[@name=$topic]/image/url"/>
	 <xsl:variable name="title" select="/content/channel/topics/entry[@name=$topic]/image/title"/>
	 <a>
	  <xsl:attribute name="href"><xsl:value-of select="$link"/></xsl:attribute>
      <img alt="{$title}" title="{$title}">
       <xsl:attribute name="src"><xsl:value-of select="appdata:getContextPath()"/><xsl:value-of select="utils:getImagePath($url)"/></xsl:attribute>
      </img>
     </a>
	</xsl:template>
</xsl:stylesheet>