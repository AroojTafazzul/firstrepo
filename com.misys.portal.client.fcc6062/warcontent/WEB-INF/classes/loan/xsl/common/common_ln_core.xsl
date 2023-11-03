<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to forms on the customer side. This
stylesheet should be the first thing imported by customer-side
XSLTs.

This should be the first include for forms on the customer side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		exclude-result-prefixes="localization">
 
 <xsl:strip-space elements="*"/>
  
 <!--  Character encoding to use. -->
 <xsl:param name="encoding">
  <xsl:value-of select="localization:getGTPString($language, 'CHARSET')"/>
 </xsl:param>
  
 <!-- Lower-case product code -->
 <xsl:param name="lowercase-product-code">
  <xsl:value-of select="translate($product-code,$up,$lo)"/>
 </xsl:param>


 <xsl:template name="loan-exception-codes">
   <xsl:param name="option-required">Y</xsl:param>
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <xsl:if test="$option-required='N'">
      <option value=""></option>
     </xsl:if>
     <option value="42">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'CURTAILMENTS')"/>
     </option>
     <option value="43">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'FULL_PAYOFF')"/>
     </option>
     <option value="44">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'REPURCHASE')"/>
     </option>
     <option value="45">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'LOAN_SOLD')"/>
     </option>
     <option value="46">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'RECAST_SUBSTITUTION')"/>
     </option>
     <option value="47">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'TRANSFER_TO_REO')"/>
     </option>
     <option value="48">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'SHORT_PAYOFF_THIRD_PARTY')"/>
     </option>
     
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="sub_tnx_type_code[. = '42']"><xsl:value-of select="localization:getDecode($language, 'N003','CURTAILMENTS')"/></xsl:when>
      <xsl:when test="sub_tnx_type_code[. = '43']"><xsl:value-of select="localization:getDecode($language, 'N003','FULL_PAYOFF')"/></xsl:when>
      <xsl:when test="sub_tnx_type_code[. = '44']"><xsl:value-of select="localization:getDecode($language, 'N003','REPURCHASE')"/></xsl:when>
      <xsl:when test="sub_tnx_type_code[. = '45']"><xsl:value-of select="localization:getDecode($language, 'N003','LOAN_SOLD')"/></xsl:when>
      <xsl:when test="sub_tnx_type_code[. = '46']"><xsl:value-of select="localization:getDecode($language, 'N003','RECAST_SUBSTITUTION')"/></xsl:when>
      <xsl:when test="sub_tnx_type_code[. = '47']"><xsl:value-of select="localization:getDecode($language, 'N003','TRANSFER_TO_REO')"/></xsl:when>
      <xsl:when test="sub_tnx_type_code[. = '48']"><xsl:value-of select="localization:getDecode($language, 'N003','SHORT_PAYOFF_THIRD_PARTY')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>


 <xsl:template name="loan-reporting-method">
   <xsl:param name="option-required">Y</xsl:param>
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <xsl:if test="$option-required='N'">
      <option value=""></option>
     </xsl:if>
     <option value="49">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'ACTUAL_ACTUAL')"/>
     </option>
     <option value="50">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'SCHEDULED_ACTUAL')"/>
     </option>
     <option value="51">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'ACTUAL_SCHEDULED')"/>
     </option>
     <option value="52">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'SCHEDULED_SCHEDULED')"/>
     </option>
     
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="sub_tnx_type_code[. = '49']"><xsl:value-of select="localization:getDecode($language, 'N003','ACTUAL_ACTUAL')"/></xsl:when>
      <xsl:when test="sub_tnx_type_code[. = '50']"><xsl:value-of select="localization:getDecode($language, 'N003','SCHEDULED_ACTUAL')"/></xsl:when>
      <xsl:when test="sub_tnx_type_code[. = '51']"><xsl:value-of select="localization:getDecode($language, 'N003','ACTUAL_SCHEDULED')"/></xsl:when>
      <xsl:when test="sub_tnx_type_code[. = '52']"><xsl:value-of select="localization:getDecode($language, 'N003','SCHEDULED_SCHEDULED')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>

 <xsl:template name="loan-transaction-status">
   <xsl:param name="option-required">Y</xsl:param>
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <xsl:if test="$option-required='N'">
      <option value=""></option>
     </xsl:if>
     <option value="53">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'OPEN_STATUS')"/>
     </option>
     <option value="54">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'IN_PROCESS_STATUS')"/>
     </option>
     <option value="55">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'REJECTED_STATUS')"/>
     </option>
     <option value="56">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'REJECTED_UNDER_REVIEW_STATUS')"/>
     </option>
     <option value="57">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'APPROVED_STATUS')"/>
     </option>
     <option value="58">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'SENT_STATUS')"/>
     </option>
     <option value="59">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'FAIL_STATUS')"/>
     </option>
     <option value="60">
      <xsl:value-of select="localization:getDecode($language, 'N003', 'PASS_STATUS')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="sub_tnx_type_code[. = '53']"><xsl:value-of select="localization:getDecode($language, 'N003','OPEN_STATUS')"/></xsl:when>
      <xsl:when test="sub_tnx_type_code[. = '54']"><xsl:value-of select="localization:getDecode($language, 'N003','IN_PROCESS_STATUS')"/></xsl:when>
      <xsl:when test="sub_tnx_type_code[. = '55']"><xsl:value-of select="localization:getDecode($language, 'N003','REJECTED_STATUS')"/></xsl:when>
      <xsl:when test="sub_tnx_type_code[. = '56']"><xsl:value-of select="localization:getDecode($language, 'N003','REJECTED_UNDER_REVIEW_STATUS')"/></xsl:when>
      <xsl:when test="sub_tnx_type_code[. = '57']"><xsl:value-of select="localization:getDecode($language, 'N003','APPROVED_STATUS')"/></xsl:when>
      <xsl:when test="sub_tnx_type_code[. = '58']"><xsl:value-of select="localization:getDecode($language, 'N003','SENT_STATUS')"/></xsl:when>
      <xsl:when test="sub_tnx_type_code[. = '59']"><xsl:value-of select="localization:getDecode($language, 'N003','FAIL_STATUS')"/></xsl:when>
      <xsl:when test="sub_tnx_type_code[. = '60']"><xsl:value-of select="localization:getDecode($language, 'N003','PASS_STATUS')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>