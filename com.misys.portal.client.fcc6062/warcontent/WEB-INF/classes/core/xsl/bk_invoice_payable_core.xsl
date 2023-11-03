<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
 Invoice Transaction Bulk (BK) Form, Customer Side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      11/03/2016
author:    Kenneth Ivanson D. Laurel
##########################################################
-->

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
        xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
        xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
        exclude-result-prefixes="localization securitycheck utils defaultresource">
        
        
 <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>	
 <xsl:param name="deleteImage"><xsl:value-of select="$images_path"/>delete.png</xsl:param>	
 
 
 	<xsl:template name="bulk_invoice_payables">
		<script type="text/javascript">
			var invoiceItems =[];
			<xsl:for-each select="product_file_set/ip_tnx_record">
				var refInv = "<xsl:value-of select="./ref_id"/>";
				invoiceItems.push({ "REFERENCEID" :"<xsl:value-of select="./ref_id"/>","INVOICE_REFERENCE_LABEL" :"<xsl:value-of select="./issuer_ref_id"/>","ENTITY":"<xsl:value-of select="./entity"/>","PROGRAM_NAME" :"<xsl:value-of select="./fscm_program/program_name"/>","SELLER_NAME" :"<xsl:value-of select="./seller_name"/>","CURCODE" :"<xsl:value-of select="./total_net_cur_code"/>","AMOUNT" :"<xsl:value-of select="./total_net_amt"/>","OS_AMOUNT" :"<xsl:value-of select="./liab_total_net_amt"/>","INVOICE_DATE" :"<xsl:value-of select="./iss_date"/>","INVOICE_DUE_DATE" :"<xsl:value-of select="./due_date"/>","STATUS" :"<xsl:value-of select="localization:getDecode($language, 'N005', ./prod_stat_code[.])"/>", "FIN_REQUESTED_PERCENT" :"<xsl:value-of select="./inv_eligible_pct"/>","ACTION" : "<![CDATA[<img src=\"/content/images/delete.png\" onClick =\"javascript:misys.deleteInvoicePayableRecord(refInv)\"/>]]>"});
			</xsl:for-each>	
		</script>
	</xsl:template>      
 
	<xsl:template name="bulk-invoice-payable-grid">
		<xsl:param name="product"/>
		<p>&nbsp;</p>
  		 <xsl:call-template name="hidden-field">
		    <xsl:with-param name="name">delete_icon</xsl:with-param>
		    <xsl:with-param name="value"><xsl:value-of select="utils:getImagePath($deleteImage)"/></xsl:with-param>
		   </xsl:call-template>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_INVOICE_PAYABLE</xsl:with-param>
			<xsl:with-param name="content">
				<div id="in-items-template">
					<div class="clear multigrid">
						<script type="text/javascript">
						var gridLayoutBulkTransaction, pluginsData;
						dojo.ready(function(){
					    	gridLayoutBulkTransaction = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>", "field": "REFERENCEID", "width": "10%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_REFERENCE_LABEL')"/>", "field": "INVOICE_REFERENCE_LABEL", "width": "10em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'PROGRAM_NAME')"/>", "field": "PROGRAM_NAME", "width": "10%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'SELLER_NAME')"/>", "field": "SELLER_NAME", "width": "10%", "styles":"white-space:nowrap;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/>", "field": "CURCODE", "width": "5%", "styles":"text-align: center;white-space:nowrap;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'AMOUNT')"/>", "field": "AMOUNT", "width": "5%", "styles":"text-align: right;", "headerStyles":"white-space:nowrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'OS_AMOUNT')"/>", "field": "OS_AMOUNT", "width": "5%", "styles":"text-align: right;", "headerStyles":"white-space:nowrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_DATE')"/>", "field": "INVOICE_DATE", "width": "10%", "styles":"text-align: right;", "headerStyles":"white-space:nowrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_DUE_DATE')"/>", "field": "INVOICE_DUE_DATE", "width": "10%", "styles":"text-align: right;", "headerStyles":"white-space:nowrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'STATUS')"/>", "field": "STATUS", "width": "20%", "styles":"text-align: center;", "headerStyles":"white-space:nowrap;text-align: center"},
<!-- 					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'FIN_REQUESTED_PERCENT')"/>", "field":"FIN_REQUESTED_PERCENT", "width": "5%", "styles":"white-space:nowrap;text-align: center"}
 -->					                    <xsl:if test="$displaymode='edit'">
					                   		,{ "noresize":"true", "name": "&nbsp;", "field": "ACTION", "width": "6em", "styles": "text-align:center;", "headerStyles": "text-align: center", "formatter": misys.grid.formatHTML}
					                    ]
					                   </xsl:if>
					                  
					              ]};
							pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
						<div style="width:100%;height:100%;" class="widgetContainer clear">
						<xsl:choose>
	
						 <xsl:when test="$mode='DRAFT' or $mode='UNSIGNED'">
							<table plugins="pluginsData" structure="gridLayoutBulkTransaction" class="grid" 
								autoHeight="true" id="invoicePayablesGrid" dojoType="dojox.grid.EnhancedGrid" 
								noDataMessage="{localization:getGTPString($language, 'TABLE_NO_DATA')}" selectionMode="none" selectable="false" singleClickEdit="true"
								escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
								<thead>
									<tr></tr>
								</thead>
								<tfoot>
									<tr><td></td></tr>
								</tfoot>
								<tbody>
									<tr><td></td></tr>
								</tbody>
							</table>
						</xsl:when>
						<xsl:otherwise>
							<table border="0" cellpadding="0" cellspacing="0" class="attachments">
						     <xsl:attribute name="id">in_table</xsl:attribute>
						      <xsl:choose>
						      	<xsl:when test="invoicePayables/invoicePayable">
							      <thead>
							       <tr>
							        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/></th>
							        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_BACK_OFFICE_REFERENCE')"/></th>
							        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'LICENSE_NUMBER')"/></th>
							       	<th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'LS_ALLOCATED_AMT')"/></th>
							       	<!-- <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'LS_ALLOCATED_ADD_AMT')"/></th> -->
							       </tr>
							      </thead>
							      <tbody>
									<xsl:attribute name="id">invoice_payable_table_details</xsl:attribute>      
							         <xsl:for-each select="invoicePayables/invoicePayable">
							          <tr>
							         	<td><xsl:value-of select="ls_ref_id"/></td>
							         	<td><xsl:value-of select="bo_ref_id"/></td>
							           	<td><xsl:value-of select="ls_number"/></td>
							           	<td><xsl:value-of select="ls_allocated_amt"/></td>
							           	<!-- <td><xsl:value-of select="ls_allocated_add_amt"/></td> -->
							          </tr>
							         </xsl:for-each>
							      </tbody>
							    </xsl:when>
							    <xsl:otherwise>
							      	<div><xsl:value-of select="localization:getGTPString($language, 'XSL_NO_INVOICE_ITEMS')"/></div>
							      	<tbody></tbody>
							    </xsl:otherwise>
						      </xsl:choose>
						     </table>
						</xsl:otherwise>
						</xsl:choose>
							<div class="clear" style="height:1px">&nbsp;</div>
						</div>
						<xsl:if test="$displaymode='edit'">
						<div id="invoice-payable-items-add" class="widgetContainer">
							<div id="invoice_payable_lookup" type="button" dojoType="dijit.form.Button">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_INVOICE_PAYABLES')" />
							</div>
						</div>
						</xsl:if>	
					</div>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>