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
 <xsl:template match="Message/Content/TierRateCodes/TierRateCode">
  <result>
   <com.misys.portal.common.currency.TierRateCodes>
    <tierrate_id><xsl:value-of select="utils:generateCurrentTimeMillis()"/></tierrate_id>
      <rate_code><xsl:value-of select="RateCode"/></rate_code>
      <date_last_applicable><xsl:value-of select="tools:stringInternalToDateTimeString(DateLastApplicable)"/></date_last_applicable>
      <xsl:if test="TierLevel0">
        <tier_level_0><xsl:value-of select="TierLevel0"/></tier_level_0>
      </xsl:if>
      <xsl:if test="TierLevel1">
        <tier_level_1><xsl:value-of select="TierLevel1"/></tier_level_1>
      </xsl:if>
      <xsl:if test="TierLevel2">
        <tier_level_2><xsl:value-of select="TierLevel2"/></tier_level_2>
      </xsl:if>
      <xsl:if test="TierLevel3">
        <tier_level_3><xsl:value-of select="TierLevel3"/></tier_level_3>
      </xsl:if>
      <xsl:if test="TierLevel4">
        <tier_level_4><xsl:value-of select="TierLevel4"/></tier_level_4>
      </xsl:if>
      <xsl:if test="TierLevel5">
        <tier_level_5><xsl:value-of select="TierLevel5"/></tier_level_5>
      </xsl:if>
      <xsl:if test="TierLevel6">
        <tier_level_6><xsl:value-of select="TierLevel6"/></tier_level_6>
      </xsl:if>
      <xsl:if test="TierLevel7">
        <tier_level_7><xsl:value-of select="TierLevel7"/></tier_level_7>
      </xsl:if>
      <xsl:if test="TierLevel8">
        <tier_level_8><xsl:value-of select="TierLevel8"/></tier_level_8>
      </xsl:if>
      <xsl:if test="TierLevel9">
        <tier_level_9><xsl:value-of select="TierLevel9"/></tier_level_9>
      </xsl:if>
      <xsl:apply-templates select="BaseRateCodeFor"/>
      <xsl:apply-templates select="DifferentialRateCodeFor"/>
      </com.misys.portal.common.currency.TierRateCodes>
      </result>
      </xsl:template>
      
      <xsl:template match="BaseRateCodeFor">
        <xsl:if test="Level0">
          <baserate_level_0><xsl:value-of select="Level0"/></baserate_level_0>
        </xsl:if>
        <xsl:if test="Level1">
          <baserate_level_1><xsl:value-of select="Level1"/></baserate_level_1>
        </xsl:if>
        <xsl:if test="Level2">
          <baserate_level_2><xsl:value-of select="Level2"/></baserate_level_2>
        </xsl:if>
        <xsl:if test="Level3">
          <baserate_level_3><xsl:value-of select="Level3"/></baserate_level_3>
        </xsl:if>
        <xsl:if test="Level4">
          <baserate_level_4><xsl:value-of select="Level4"/></baserate_level_4>
        </xsl:if>
        <xsl:if test="Level5">
          <baserate_level_5><xsl:value-of select="Level5"/></baserate_level_5>
        </xsl:if>
        <xsl:if test="Level6">
          <baserate_level_6><xsl:value-of select="Level6"/></baserate_level_6>
        </xsl:if>
        <xsl:if test="Level7">
          <baserate_level_7><xsl:value-of select="Level7"/></baserate_level_7>
        </xsl:if>
        <xsl:if test="Level8">
          <baserate_level_8><xsl:value-of select="Level8"/></baserate_level_8>
        </xsl:if>
        <xsl:if test="Level9">
          <baserate_level_9><xsl:value-of select="Level9"/></baserate_level_9>
        </xsl:if>
      </xsl:template>
     
      <xsl:template match="DifferentialRateCodeFor">
        <xsl:if test="Level0">
          <diffrate_level_0><xsl:value-of select="Level0"/></diffrate_level_0>
        </xsl:if>
        <xsl:if test="Level1">
          <diffrate_level_1><xsl:value-of select="Level1"/></diffrate_level_1>
        </xsl:if>
        <xsl:if test="Level2">
          <diffrate_level_2><xsl:value-of select="Level2"/></diffrate_level_2>
        </xsl:if>
        <xsl:if test="Level3">
          <diffrate_level_3><xsl:value-of select="Level3"/></diffrate_level_3>
        </xsl:if>
        <xsl:if test="Level4">
          <diffrate_level_4><xsl:value-of select="Level4"/></diffrate_level_4>
        </xsl:if>
        <xsl:if test="Level5">
          <diffrate_level_5><xsl:value-of select="Level5"/></diffrate_level_5>
        </xsl:if>
        <xsl:if test="Level6">
          <diffrate_level_6><xsl:value-of select="Level5"/></diffrate_level_6>
        </xsl:if>
        <xsl:if test="Level7">
          <diffrate_level_7><xsl:value-of select="Level7"/></diffrate_level_7>
        </xsl:if>
        <xsl:if test="Level8">
          <diffrate_level_8><xsl:value-of select="Level8"/></diffrate_level_8>
        </xsl:if>
        <xsl:if test="Level9">
          <diffrate_level_9><xsl:value-of select="Level9"/></diffrate_level_9>
        </xsl:if>
      </xsl:template>
   
</xsl:stylesheet>