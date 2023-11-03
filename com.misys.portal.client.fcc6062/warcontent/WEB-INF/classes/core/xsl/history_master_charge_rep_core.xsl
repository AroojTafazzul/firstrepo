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
  	
 <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">view</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code"></xsl:param> 
  <xsl:param name="main-form-name"></xsl:param>
  <xsl:param name="realform-action"></xsl:param>

  <!-- Global Imports. -->
  <xsl:include href="common/trade_common.xsl" />
	
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
	<xsl:apply-templates/>
  </xsl:template>
	
	<!--TEMPLATE Main-->
	<xsl:template match="lc_tnx_record | se_tnx_record | fb_tnx_record |li_tnx_record | ri_tnx_record | sg_tnx_record | tf_tnx_record | el_tnx_record | ec_tnx_record | ic_tnx_record | ir_tnx_record | si_tnx_record | sr_tnx_record | bg_tnx_record | td_tnx_record | la_tnx_record | ft_tnx_record | po_tnx_record | so_tnx_record | in_tnx_record | br_tnx_record | fx_tnx_record | xo_tnx_record | ln_tnx_record | to_tnx_record | sp_tnx_record | fa_tnx_record | bk_tnx_record | ip_tnx_record | cn_tnx_record | cr_tnx_record | io_tnx_record | tu_tnx_record | ls_tnx_record | ea_tnx_record">
		<xsl:if test="count(charges/charge) > 0">
			<div class="widgetContainer">
				<div class="clear">&nbsp;</div>
				<table rowsPerPage='100' clientSort='true' class='grid' autoHeight='20' id='inquiryHistoryCharges' 
					   dojoType='dojox.grid.DataGrid' selectionMode='none'>
					<xsl:attribute name="summary"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODUCT_CHARGE_TABLE_CAPTION')"/></xsl:attribute>
					<xsl:attribute name="noDataMessage"><xsl:value-of select="localization:getGTPString($language, 'TABLE_NO_CHARGE_DATA')"/></xsl:attribute>
					<xsl:attribute name="loadingMessage"><xsl:value-of select="localization:getGTPString($language, 'TABLE_LOADING_CHARGE_DATA')"/></xsl:attribute>
					<caption><xsl:value-of select="localization:getGTPString($language, 'TYPE')"/></caption>
					<thead>
						<tr>
							<th width='10%' field='TYPE'><xsl:value-of select="localization:getGTPString($language, 'TYPE')"/></th>
							<th width='5%' field='CUR_CODE' classes='align-center'><xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/></th>
							<th width='10%' field='AMOUNT' classes='align-right'><xsl:value-of select="localization:getGTPString($language, 'AMOUNT')"/></th>
							<th width='5%' field='STATUS' classes='align-center'><xsl:value-of select="localization:getGTPString($language, 'STATUS')"/></th>
							<th width='5%' field='DATE' classes='align-center'><xsl:value-of select="localization:getGTPString($language, 'DATE')"/></th>
						</tr>
					</thead>
					<tfoot><tr><td></td></tr></tfoot>
					<tbody><tr><td></td><td></td><td></td><td></td></tr></tbody>
				</table>
			</div>
			<script>
				dojo.subscribe("ready", function(){ misys.grid.setStore( 			
				{"items":
					[
						<xsl:for-each select="charges/charge">
							<xsl:if test="position()>1">,</xsl:if>
							{
								"TYPE":"<xsl:choose><xsl:when test="chrg_code = 'OTHER' and additional_comment !=''"><xsl:value-of select="normalize-space(additional_comment)"/></xsl:when><xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N006', chrg_code)"/></xsl:otherwise></xsl:choose>",
								"CUR_CODE":"<xsl:choose><xsl:when test="eqv_cur_code[.!='']"><xsl:value-of select="eqv_cur_code"/></xsl:when><xsl:otherwise><xsl:value-of select="cur_code"/></xsl:otherwise></xsl:choose>",
								"AMOUNT":"<xsl:choose><xsl:when test="eqv_amt[.!='']"><xsl:value-of select="eqv_amt"/></xsl:when><xsl:otherwise><xsl:value-of select="amt"/></xsl:otherwise></xsl:choose>",
								"STATUS":"<xsl:value-of select="localization:getDecode($language, 'N057', status)"/>",
								"DATE":"<xsl:value-of select="settlement_date"/>",
								"CHARGEID":"CHARGEID_<xsl:value-of select="position()"/>"
							}
						</xsl:for-each>
					],
				 "label":"CHARGEID",
				 "identifier":"CHARGEID"}, null, dijit.byId('inquiryHistoryCharges'));});
		   </script>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>