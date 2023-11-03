<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
	exclude-result-prefixes="localization">
	
	<!--
   Copyright (c) 2000-2008 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
	-->

	<!--  <xsl:import href="common/com_cross_references.xsl"/> -->
	
	<xsl:output method="html" indent="no"/>
	<!-- Get the language code -->
	<xsl:param name="language"/>

	
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!--TEMPLATE Main-->
	<xsl:template match="lc_tnx_record | se_tnx_record | li_tnx_record | ri_tnx_record | sg_tnx_record | tf_tnx_record | el_tnx_record | ec_tnx_record | ic_tnx_record | ir_tnx_record | si_tnx_record | sr_tnx_record | bg_tnx_record | ft_tnx_record | po_tnx_record | so_tnx_record | in_tnx_record | br_tnx_record | td_tnx_record | la_tnx_record | fx_tnx_record | xo_tnx_record | ln_tnx_record | to_tnx_record | sp_tnx_record | fa_tnx_record | bk_tnx_record | ip_tnx_record | cn_tnx_record | cr_tnx_record">
	
	<xsl:if test="count(cross_references/cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id]) > 0 or count(cross_references/cross_reference[ref_id=../../ref_id and ref_id != child_ref_id]) > 0">

	<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"/>
		
	<!-- don't show reference to product that does not belong to the company (FSCM for instance) -->
    <!-- xsl:if test="count(cross_references/cross_reference[ref_id!=child_ref_id and ../../company_id=company_id]) > 0"-->
    <!-- test on company id is remove, hack because the company id does not exist at cross reference level -->
	<xsl:if test="count(cross_references/cross_reference[ref_id!=child_ref_id ">
     <!-- Details of ancestors -->
     <xsl:if test="count(cross_references/cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id]) > 0">
       <div class="label">
        <xsl:if test="count(cross_references/cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id]) > 1">
         <xsl:attribute name="style">height:<xsl:value-of select="count(cross_references/cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id])*10"/>px;</xsl:attribute>
        </xsl:if>
        <xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ANCESTOR_LINKED_REFERENCE')"/></div> 
      <div class="field">
       <ul>
         <xsl:for-each select="cross_references/cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id]">
         <li>
          <a href="javascript:void(0)">
           <xsl:attribute name="onclick">
            <xsl:choose>
             <xsl:when test="tnx_id[.!='']">misys.popup.showReporting('FULL', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="tnx_id"/>');return false;</xsl:when>
             <xsl:otherwise>misys.popup.showReporting('DETAILS', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>');return false;</xsl:otherwise>
            </xsl:choose>
           </xsl:attribute>
           <xsl:value-of select="ref_id"/>
          </a> (<xsl:value-of select="localization:getDecode($language, 'N043', type_code)"/>)
         </li>
        </xsl:for-each>
       </ul>
      </div>
     </xsl:if>

     <!-- Details of child-->
     <xsl:if test="count(cross_references/cross_reference[ref_id=../../ref_id and ref_id != child_ref_id]) > 0">
       <xsl:if test="count(cross_references/cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id]) > 1">
        <xsl:attribute name="style">height:<xsl:value-of select="count(cross_references/cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id])*10"/>px;</xsl:attribute>
       </xsl:if>
       <div class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_CHILD_LINKED_REFERENCE')"/></div> 
	   <div class="field">
       <ul>
        <xsl:for-each select="cross_references/cross_reference[ref_id=../../ref_id and ref_id != child_ref_id]">
         <li>
          <a href="javascript:void(0)">
           <xsl:attribute name="onclick">
            <xsl:choose>
             <xsl:when test="child_tnx_id[.!='']">misys.popup.showReporting('FULL', '<xsl:value-of select="child_product_code"/>', '<xsl:value-of select="child_ref_id"/>', '<xsl:value-of select="child_tnx_id"/>');return false;</xsl:when>
             <xsl:otherwise>misys.popup.showReporting('DETAILS', '<xsl:value-of select="child_product_code"/>', '<xsl:value-of select="child_ref_id"/>');return false;</xsl:otherwise>
            </xsl:choose>
           </xsl:attribute>
           <xsl:value-of select="child_ref_id"/>
          </a> (<xsl:value-of select="localization:getDecode($language, 'N043', type_code)"/>)
         </li>
        </xsl:for-each>
       </ul>
      </div>
     </xsl:if>
     
	</xsl:if>
	</xsl:if>
	</xsl:template>
</xsl:stylesheet>
