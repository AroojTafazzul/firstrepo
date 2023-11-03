<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:manager="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
 xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
 xmlns:tools="xalan://com.misys.portal.common.tools.ConvertTools"
 xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
 xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
 xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
 xmlns:businesscode="xalan://com.misys.portal.common.resources.BusinessCodesResourceProvider" 
 exclude-result-prefixes="manager utils tools security localization defaultresource businesscode">
 
 <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
 
 <xsl:param name="banks"/>
 <xsl:param name="language">en</xsl:param>
 <!--
 Copyright (c) 2000-2012 Misys (http://www.misys.com),
 All Rights Reserved. 
 -->
 <xsl:template match="Message/Content/BaseRateCodes/BaseRateCode | Message/Content/DifferentialRateCodes/DifferentialRateCode">
  <result>
   <com.misys.portal.common.currency.BaseRateCodes>
   <baserate_id><xsl:value-of select="utils:generateCurrentTimeMillis()"/></baserate_id>
     <rate_code><xsl:value-of select="RateCode/text()"/></rate_code>
     <xsl:if test="BaseRate">
         <rate_code_flag>B</rate_code_flag>
     </xsl:if>
     <xsl:if test="DifferentialRate">
         <rate_code_flag>D</rate_code_flag>
     </xsl:if>
     <xsl:if test="BaseRate">
         <base_rate><xsl:value-of select="BaseRate"/></base_rate>
     </xsl:if>
     <xsl:if test="DifferentialRate">
         <diff_rate><xsl:value-of select="DifferentialRate"/></diff_rate>
     </xsl:if>
     <date_applicable><xsl:value-of select="tools:stringInternalToDateTimeString(DateApplicable)"/></date_applicable>
     <last_maintained_date><xsl:value-of select="tools:stringInternalToDateTimeString(DateLastMaintained)"/></last_maintained_date>
   </com.misys.portal.common.currency.BaseRateCodes>
  </result>
 </xsl:template>
</xsl:stylesheet>