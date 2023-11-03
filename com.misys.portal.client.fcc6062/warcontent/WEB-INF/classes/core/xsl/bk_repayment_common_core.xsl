<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for the details of

Transaction Bulk (BK) Repayment for IP from Customer Side.

Copyright (c) 2000-2017 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/07/2017
author:    Meenal Sahasrabudhe
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
        
 	<xsl:template name="bulk_finances_repay">
 		<xsl:param name="childProduct"/>
		<script type="text/javascript">
			var invoiceItems =[];
			<xsl:choose>
				<xsl:when test="$childProduct='IN'">
					<xsl:for-each select="product_file_set/in_tnx_record">
						var refInv = "<xsl:value-of select="./ref_id"/>";
						invoiceItems.push({ "REFERENCEID" :"<xsl:value-of select="./ref_id"/>",
						"INVOICE_REFERENCE_LABEL":"<xsl:value-of select="./issuer_ref_id"/>",
						"ENTITY":"<xsl:value-of select="./entity"/>",
						"PROGRAM_NAME" :"<xsl:value-of select="./fscm_program/program_name"/>",
						"BUYER_NAME" :"<xsl:value-of select="./buyer_name"/>",
						"SELLER_NAME" :"<xsl:value-of select="./seller_name"/>",
						"CURCODE" :"<xsl:value-of select="./total_net_cur_code"/>",
						"FINANCE_AMOUNT" :"<xsl:value-of select="./finance_amt"/>",
						"OUTSTANDING_REPAY_AMOUNT" :"<xsl:value-of select="./outstanding_repayment_amt"/>",
						"TOTAL_REPAID_AMOUNT" :"<xsl:value-of select="./total_repaid_amt"/>",
						"FINANCE_ISSUE_DATE" :"<xsl:value-of select="./fin_date"/>",
						"FINANCE_DUE_DATE" :"<xsl:value-of select="./fin_due_date"/>",
						"STATUS" :"<xsl:value-of select="localization:getDecode($language, 'N005', ./prod_stat_code[.])"/>",
						"ACTION" : "<![CDATA[<img src=\"/content/images/delete.png\" onClick =\"javascript:misys.deleteItemFromBulkGrid('invoicesGrid',refInv)\"/>]]>"});
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="$childProduct='IP'">
					<xsl:for-each select="product_file_set/ip_tnx_record">
						var refInv = "<xsl:value-of select="./ref_id"/>";
						invoiceItems.push({ "REFERENCEID" :"<xsl:value-of select="./ref_id"/>",
						"INVOICE_REFERENCE_LABEL":"<xsl:value-of select="./issuer_ref_id"/>",
						"ENTITY":"<xsl:value-of select="./entity"/>",
						"PROGRAM_NAME" :"<xsl:value-of select="./fscm_program/program_name"/>",
						"BUYER_NAME" :"<xsl:value-of select="./buyer_name"/>",
						"SELLER_NAME" :"<xsl:value-of select="./seller_name"/>",
						"CURCODE" :"<xsl:value-of select="./total_net_cur_code"/>",
						"FINANCE_AMOUNT" :"<xsl:value-of select="./finance_amt"/>",
						"OUTSTANDING_REPAY_AMOUNT" :"<xsl:value-of select="./outstanding_repayment_amt"/>",
						"TOTAL_REPAID_AMOUNT" :"<xsl:value-of select="./total_repaid_amt"/>",
						"FINANCE_ISSUE_DATE" :"<xsl:value-of select="./fin_date"/>",
						"FINANCE_DUE_DATE" :"<xsl:value-of select="./fin_due_date"/>",
						"STATUS" :"<xsl:value-of select="localization:getDecode($language, 'N005', ./prod_stat_code[.])"/>",
						"ACTION" : "<![CDATA[<img src=\"/content/images/delete.png\" onClick =\"javascript:misys.deleteInvoicePayableRecord(refInv)\"/>]]>"});
					</xsl:for-each>
				</xsl:when>
			</xsl:choose>
		</script>
	</xsl:template>      
 
	<xsl:template name="bulk-finances-repay-grid">
		<xsl:param name="childProduct"/>
		<p>&nbsp;</p>
  		 <xsl:call-template name="hidden-field">
		    <xsl:with-param name="name">delete_icon</xsl:with-param>
		    <xsl:with-param name="value"><xsl:value-of select="utils:getImagePath($deleteImage)"/></xsl:with-param>
		   </xsl:call-template>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_FINANCES</xsl:with-param>
			<xsl:with-param name="content">
				<div id="in-items-template">
					<div class="clear multigrid">
						<script type="text/javascript">
						var gridLayoutBulkTransaction, pluginsData;
						dojo.ready(function(){
					    	gridLayoutBulkTransaction = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>", "field": "REFERENCEID", "width": "10em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                  <xsl:if test="entity and entity!=''">
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'ENTITY')"/>", "field": "ENTITY", "width": "12%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                  </xsl:if>
					                  { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_REFERENCE_LABEL')"/>", "field": "INVOICE_REFERENCE_LABEL", "width": "10em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                  { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'PROGRAM_NAME')"/>", "field": "PROGRAM_NAME", "width": "10%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
									  <xsl:choose>
										  <xsl:when test="$childProduct = 'IP'">
										   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'SELLER_NAME')"/>", "field": "SELLER_NAME", "width": "10%", "styles":"white-space:nowrap;", "headerStyles":"white-space:nowrap;"},
						                  </xsl:when>
						                   <xsl:when test="$childProduct = 'IN'">
										   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'BUYER_NAME')"/>", "field": "BUYER_NAME", "width": "10%", "styles":"white-space:nowrap;", "headerStyles":"white-space:nowrap;"},
						                  </xsl:when>
					                  </xsl:choose>
					                   
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/>", "field": "CURCODE", "width": "4em", "styles":"text-align: center;white-space:nowrap;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'FINANCED_AMNT')"/>", "field": "FINANCE_AMOUNT", "width": "12%", "styles":"text-align: right;", "headerStyles":"white-space:nowrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'OUTSTANDING_REPAY_AMT')"/>", "field": "OUTSTANDING_REPAY_AMOUNT", "width": "15%", "styles":"text-align: right;", "headerStyles":"white-space:nowrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'FINANCE_ISSUE_DATE')"/>", "field": "FINANCE_ISSUE_DATE", "width": "15%", "styles":"text-align: right;", "headerStyles":"white-space:nowrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'FINANCE_DUE_DATE')"/>", "field": "FINANCE_DUE_DATE", "width": "15%", "styles":"text-align: right;", "headerStyles":"white-space:nowrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'STATUS')"/>", "field": "STATUS", "width": "15%", "styles":"text-align: center;", "headerStyles":"white-space:nowrap;text-align: center"}
					                    <xsl:if test="$displaymode='edit'">
					                   		,{ "noresize":"true", "name": "&nbsp;", "field": "ACTION", "width": "3em", "styles": "text-align:center;", "headerStyles": "text-align: center", "formatter": misys.grid.formatHTML}
					                    ]
					                   </xsl:if>
					                  
					              ]};
							pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
						<div style="width:100%;height:100%;" class="widgetContainer clear">
						<xsl:choose>
	
						 <xsl:when test="$mode='DRAFT' or $mode='UNSIGNED'">
						 	<xsl:choose>
						 		<xsl:when test="$childProduct='IP'">
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
						 		<xsl:when test="$childProduct='IN'">
						 			<table plugins="pluginsData" structure="gridLayoutBulkTransaction" class="grid" 
										autoHeight="true" id="invoicesGrid" dojoType="dojox.grid.EnhancedGrid" 
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
						 	</xsl:choose>
							
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
							      <tbody></tbody>
							      <!-- <tbody>
									<xsl:attribute name="id">invoice_payable_table_details</xsl:attribute>      
							         <xsl:for-each select="invoicePayables/invoicePayable">
							          <tr>
							         	<td><xsl:value-of select="ls_ref_id"/></td>
							         	<td><xsl:value-of select="bo_ref_id"/></td>
							           	<td><xsl:value-of select="ls_number"/></td>
							           	<td><xsl:value-of select="ls_allocated_amt"/></td>
							           	<td><xsl:value-of select="ls_allocated_add_amt"/></td>
							          </tr>
							         </xsl:for-each>
							      </tbody> -->
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
						<xsl:choose>
							<xsl:when test="$childProduct='IP'">
								<div id="finance-items-add" class="widgetContainer">
									<div id="finance_lookup" type="button" dojoType="dijit.form.Button">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_FINANCES')" />
									</div>
								</div>
							</xsl:when>
							<xsl:when test="$childProduct='IN'">
								<div id="finance-items-add" class="widgetContainer">
									<div id="finance_lookup" type="button" dojoType="dijit.form.Button">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_FINANCES')" />
									</div>
								</div>
							</xsl:when>
						</xsl:choose>
						
						</xsl:if>	
					</div>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="bulk-finances-repay-grid-view">
		<xsl:param name="childProduct"/>
		<p>&nbsp;</p>
		<div id="invoiceGridContainer" class="widgetContainer">
				<p/>
				<div name="invoiceGridList" id="invoiceGridList">
					<script type="text/javascript">
						var gridLayoutBulkTransaction, pluginsData;
						dojo.ready(function(){
					    	gridLayoutBulkTransaction = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>", "field": "ref_id", "width": "10em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                  <xsl:if test="entity and entity!=''">
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'ENTITY')"/>", "field": "entity", "width": "12%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                  </xsl:if>
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_REFERENCE_LABEL')"/>", "field": "issuer_ref_id", "width": "10em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'PROGRAM_NAME')"/>", "field": "fscm_prog@program_name", "width": "12%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'SELLER_NAME')"/>", "field": "seller_name", "width": "20%", "styles":"white-space:nowrap;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'BUYER_NAME')"/>", "field": "buyer_name", "width": "20%", "styles":"white-space:nowrap;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/>", "field": "total_net_cur_code", "width": "4em", "styles":"text-align: center;white-space:nowrap;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'FINANCED_AMNT')"/>", "field": "finance_amt", "width": "15%", "styles":"text-align: right;", "headerStyles":"white-space:nowrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'OUTSTANDING_REPAY_AMT')"/>", "field": "outstanding_repayment_amt", "width": "20%", "styles":"text-align: right;", "headerStyles":"white-space:nowrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'TOTAL_REPAID_AMT')"/>", "field": "total_repaid_amt", "width": "20%", "styles":"text-align: right;", "headerStyles":"white-space:nowrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'FINANCE_ISSUE_DATE')"/>", "field": "fin_date", "width": "15%", "styles":"text-align: right;", "headerStyles":"white-space:nowrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'FINANCE_DUE_DATE')"/>", "field": "fin_due_date", "width": "15%", "styles":"text-align: right;", "headerStyles":"white-space:nowrap;text-align: center"},					                   
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'STATUS')"/>", "field": "status", "width": "10%", "styles":"text-align: center;", "headerStyles":"white-space:nowrap;text-align: center"}]
					                  
					              ]};
							pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
		
					<div style="width:100%;height:100%;" class="widgetContainer clear">
						<div dojoType="dojox.data.QueryReadStore" jsId="storeBulkTransaction" requestMethod="post">
							<xsl:attribute name="url">
								<xsl:if test="$childProduct = 'IN'">
									<xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/AjaxScreen/action/GetJSONData?listdef=openaccount/listdef/customer/IN/showINTransactionsInBulkRepayment.xml&amp;bulk_ref_id=<xsl:value-of select='ref_id'/>
								</xsl:if>
								<xsl:if test="$childProduct = 'IP'">
									<xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/AjaxScreen/action/GetJSONData?listdef=openaccount/listdef/customer/IP/showIPTransactionsInBulkRepayment.xml&amp;bulk_ref_id=<xsl:value-of select='ref_id'/>
								</xsl:if>
							</xsl:attribute>
						</div>
						
						<xsl:if test="$childProduct = 'IN'">
						    <table rowsPerPage="50" 
								plugins="pluginsData" 
								store="storeBulkTransaction" structure="gridLayoutBulkTransaction" class="grid" 
								autoHeight="true" id="invoicesGrid" dojoType="dojox.grid.EnhancedGrid" 
								noDataMessage="{localization:getGTPString($language, 'TABLE_NO_DATA')}" selectionMode="none" selectable="true" 
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
						</xsl:if>
						<xsl:if test="$childProduct = 'IP'">
							<table rowsPerPage="50" 
								plugins="pluginsData" 
								store="storeBulkTransaction" structure="gridLayoutBulkTransaction" class="grid" 
								autoHeight="true" id="invoicePayablesGrid" dojoType="dojox.grid.EnhancedGrid" 
								noDataMessage="{localization:getGTPString($language, 'TABLE_NO_DATA')}" selectionMode="none" selectable="true" 
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
						</xsl:if>
						<div class="clear" style="height:1px">&nbsp;</div>
					</div>
				</div>
			</div>
	</xsl:template>
	<xsl:template name="disclaimer-bulk-repayment">
	    <div class="disclaimer">
	     <p><xsl:value-of select="localization:getGTPString($language, 'XSL_BULK_REPAYMENT_NOTE')"/></p>
	    </div>
	</xsl:template>
	<xsl:template name="bank-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="issuing-bank-tabcontent"/>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">issuing_bank_customer_reference_hidden</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>	
		</xsl:call-template>
	
	</xsl:template>
	
	<!-- Repayment Details -->
	<xsl:template name="bulk-repayment-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_FINANCE_REPAYMENT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			    <xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_BK_TOTAL_REPAYMENT_AMT</xsl:with-param>
					<xsl:with-param name="product-code">bk_total</xsl:with-param>
					<xsl:with-param name="override-currency-value" select="bk_cur_code"/>
					<xsl:with-param name="override-amt-name">bk_total_amt</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
					<xsl:with-param name="amt-readonly">Y</xsl:with-param>
					<xsl:with-param name="currency-readonly">Y</xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
					<xsl:with-param name="constraints">N</xsl:with-param>
					<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_BK_REPAID_DATE</xsl:with-param>
					<xsl:with-param name="name">bk_repay_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">bk_cur_code</xsl:with-param>  
					<xsl:with-param name="value"><xsl:value-of select="bk_total_cur_code"/></xsl:with-param>
			    </xsl:call-template>
			    <xsl:call-template name="hidden-field">
				    <xsl:with-param name="name">base_ccy</xsl:with-param>  
				</xsl:call-template>
				<xsl:if test=" bk_repaid_amt != ''">
					<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_BK_REPAID_AMT</xsl:with-param>
					<xsl:with-param name="product-code">bk_repaid_amt</xsl:with-param>
					<xsl:with-param name="override-currency-value" select="bk_repaid_cur_code"/>
					<xsl:with-param name="override-amt-name">bk_repaid_amt</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
					<xsl:with-param name="amt-readonly">Y</xsl:with-param>
					<xsl:with-param name="currency-readonly">Y</xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
					<xsl:with-param name="constraints">N</xsl:with-param>
					<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>