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
 <xsl:template match="Message/Content/SplConditions/SplCondition">
  <result>
   <com.misys.portal.cash.product.ab.common.AccountSpecialConditions>
        <xsl:if test="ReferenceNo">
            <ref_num><xsl:value-of select="ReferenceNo"/></ref_num>
        </xsl:if>
        <xsl:if test="not(ReferenceNo)">
           <ref_num/>
        </xsl:if>
        <xsl:if test="Description">
            <description><xsl:value-of select="Description"/></description>
        </xsl:if>
        <xsl:if test="not(Description)">
           <description/>
        </xsl:if>          
   </com.misys.portal.cash.product.ab.common.AccountSpecialConditions>
  </result>
 </xsl:template>
</xsl:stylesheet>