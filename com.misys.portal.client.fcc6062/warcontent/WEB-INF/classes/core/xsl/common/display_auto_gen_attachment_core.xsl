<!--
##########################################################
Templates for displaying transaction summaries.

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
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
 xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
 xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
 xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
 exclude-result-prefixes="localization converttools xmlRender security">
 
 <xsl:param name="rundata"/>
 <xsl:param name="language">en</xsl:param>
 <xsl:param name="mode"/>
 <xsl:param name="displaymode">view</xsl:param>
 <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
 <xsl:param name="product-code"/>
 <xsl:param name="main-form-name"/>
 <xsl:param name="realform-action"/>
 
   <xsl:include href="trade_common.xsl"/>
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
   
  <xsl:template match="/">
   <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="lc_tnx_record | ri_tnx_record | li_tnx_record | sg_tnx_record | tf_tnx_record | el_tnx_record | ec_tnx_record | ic_tnx_record | ir_tnx_record | si_tnx_record | sr_tnx_record | bg_tnx_record | ft_tnx_record | po_tnx_record | so_tnx_record | in_tnx_record | br_tnx_record | ln_tnx_record | sw_tnx_record | td_tnx_record | fx_tnx_record | xo_tnx_record | eo_tnx_record | sw_tnx_record | ts_tnx_record | cs_tnx_record | cx_tnx_record | ct_tnx_record | st_tnx_record | se_tnx_record | sp_tnx_record | fa_tnx_record">
   	<div class="widgetContainer">
   		<xsl:if test="attachments/attachment[auto_gen_doc_code != '' and ((security:isBank($rundata) and type = '02') or (security:isCustomer($rundata) and type = '01'))]">
         <xsl:call-template name="attachments-file-dojo">
          <xsl:with-param name="existing-attachments" select="attachments/attachment[auto_gen_doc_code != '' and ((security:isBank($rundata) and type = '02') or (security:isCustomer($rundata) and type = '01'))]"/>
          <xsl:with-param name="legend"></xsl:with-param>
          <xsl:with-param name="with-wrapper">N</xsl:with-param>
         </xsl:call-template> 
    	</xsl:if>
    </div>
   </xsl:template>
  
 
 </xsl:stylesheet>