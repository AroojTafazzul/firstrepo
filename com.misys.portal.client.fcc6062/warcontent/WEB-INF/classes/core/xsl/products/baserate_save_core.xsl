<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <!-- Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com), All 
  Rights Reserved. -->
 <!--xsl:template match="/"> <xsl:apply-templates/> </xsl:template -->
 <!-- Process RATE -->
 <!-- All rates are equal to mid_tt_rate -->
 <xsl:template match="static_rate">
  <result>
   <com.misys.portal.common.currency.BaseRateCodes>
    <rate_code><xsl:value-of select="rate_code" /></rate_code>
    <base_rate><xsl:value-of select="base_rate" /></base_rate>
    <date_applicable><xsl:value-of select="date_applicable" /></date_applicable>
    <date_last_maintenance><xsl:value-of select="date_last_maintenance" /></date_last_maintenance>
   </com.misys.portal.common.currency.BaseRateCodes>
  </result>
 </xsl:template>
</xsl:stylesheet>