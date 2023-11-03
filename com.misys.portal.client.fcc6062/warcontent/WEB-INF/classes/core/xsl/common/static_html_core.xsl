<?xml version="1.0" encoding="UTF-8" ?> 
<!--
   Copyright (c) 2000-2008 Misys (http://www.misys.com),
   All Rights Reserved.
   File necessary to have the correct link on system Features on customer side 
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
 <xsl:output indent="no" method="html"/>
 <xsl:param name="contextPath"/>
 <xsl:param name="servletPath"/>
 <xsl:variable name="apos">'</xsl:variable>
    
 <xsl:template match="@*|node()">
  <xsl:copy>
   <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
 </xsl:template>
    
 <xsl:template match="a[starts-with(@href, '/')]">
  <a>
   <xsl:attribute name="href"><xsl:value-of select="concat(concat($contextPath,$servletPath), @href)"/></xsl:attribute>
   <xsl:value-of select="."/>
  </a>
 </xsl:template>

 <xsl:template match="a[starts-with(@onclick, 'window.open')]">
  <a href="javascript:void(0)">
   <xsl:attribute name="onclick">window.open('<xsl:value-of select="concat(concat($contextPath,$servletPath), substring-after(@onclick, concat('window.open(', $apos)))"/></xsl:attribute>
   <xsl:value-of select="."/>
  </a>
 </xsl:template>
</xsl:stylesheet>