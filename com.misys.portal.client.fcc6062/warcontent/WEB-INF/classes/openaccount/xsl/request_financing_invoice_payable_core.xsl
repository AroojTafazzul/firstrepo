<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Request for finance multiple selection IP, Customer Side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      11/03/2017
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
		xmlns:java="http://xml.apache.org/xalan/java"
        exclude-result-prefixes="localization securitycheck utils defaultresource">
        
        <xsl:variable name="fscm_cash_customization_enable">
  		  <xsl:value-of select="defaultresource:getResource('FSCM_CASH_CUSTOMIZATION_ENABLE')"/>
  	    </xsl:variable>
  	
 	
 	<xsl:param name="product-code">IP</xsl:param>
	<xsl:template name="invoice-payable-grid">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="content">
				<div id="in-items-template">
					<script type="text/javascript">
						var gridLayoutIPTransaction, pluginsData;
						dojo.ready(function(){
					    	gridLayoutIPTransaction = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>", "field": "reference_id", "width": "10em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_REFERENCE_LABEL')"/>", "field": "issuer_ref_id", "width": "8em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                  <xsl:if test="entities and entities > '0'">
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'ENTITY')"/>", "field": "entity", "width": "12%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                  </xsl:if>
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'SELLER_NAME')"/>", "field": "seller_name", "width": "20%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/>", "field": "cur_code", "width": "4em", "styles":"text-align: center;white-space:nowrap;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_DATE')"/>", "field": "iss_date", "width": "15%", "styles":"text-align: center;", "headerStyles":"white-space:nowrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'AMOUNT')"/>", "field": "amt", "width": "15%", "styles":"text-align: right;", "headerStyles":"white-space:nowrap;text-align: center"},
					                   <xsl:if test=" ($fscm_cash_customization_enable = 'true')">
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_DISCOUNT_AMOUNT')"/>", "field": "discount_amt", "width": "15%", "styles":"text-align: right;", "headerStyles":"white-space:nowrap;text-align: center"},
					                   </xsl:if>
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'FINANCE_ELIGIBLE_AMT')"/>", "field": "inv_eligible_amt", "width": "15%", "styles":"text-align: right;", "headerStyles":"white-space:nowrap;text-align: center"}
					                   ]
					              ]};
							pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
					<div style="width:100%;height:100%;" class="widgetContainer clear">
						<div dojoType="dojox.data.QueryReadStore" jsId="storeIPDetails" requestMethod="post">
							<xsl:attribute name="url">								
								<xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/AjaxScreen/action/BaseLineAction?ajaxoption=MULTI_IP_REQUEST
								&amp;list_keys=<xsl:value-of select="referenceids"/>
								&amp;operation=<xsl:value-of select="operation"/>
							</xsl:attribute>
						</div>
					    <table rowsPerPage="50" 
							plugins="pluginsData" 
							store="storeIPDetails" structure="gridLayoutIPTransaction" class="grid" 
							autoHeight="true" id="gridDetails" dojoType="dojox.grid.EnhancedGrid" 
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
						<xsl:variable name="arrayList1" select="java:java.util.ArrayList.new()" />
						<xsl:variable name="void" select="java:add($arrayList1, concat('', base_cur_code))" />
						<xsl:variable name="args1" select="java:toArray($arrayList1)" />
						<table width="100%">
							<tbody>
								<tr style="background-color:#D0D0D0;">
									<td width="82.5%" style="text-align:left;font-size: 9pt;font-weight: bold">
										<xsl:value-of select="localization:getFormattedString($language, 'TOTAL_INVOICE_AMOUNT_GROUP_SUMMARY', $args1)"/>
									</td>
									<td width="17.5%" style="text-align:right;font-size: 9pt;font-weight: bold">
										<xsl:value-of select="grand_total"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	 	<xsl:call-template name="hidden-field">
	     	 <xsl:with-param name="name">base_cur_code</xsl:with-param>
	   		 <xsl:with-param name="value"><xsl:value-of select="base_cur_code"/></xsl:with-param>
	 	</xsl:call-template>
	 	<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">product_code</xsl:with-param>
			<xsl:with-param name="value">IP</xsl:with-param>				
		</xsl:call-template>
		<xsl:call-template name="invoice-payable-requested-amt"/>
	</xsl:template>
	<xsl:template name="open-selected-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="content">
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_IN_FINANCE_CURRENCY</xsl:with-param>
					<xsl:with-param name="product-code">finance</xsl:with-param>
					<xsl:with-param name="show-amt">N</xsl:with-param>
					<xsl:with-param name="override-currency-value"><xsl:value-of select="base_cur_code"/></xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
					<xsl:with-param name="currency-readonly">Y</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_GENERALDETAILS_IN_FINANCE_REQUESTED_PCT</xsl:with-param>
				     <xsl:with-param name="name">inv_eligible_pct</xsl:with-param>
				     <xsl:with-param name="size">3</xsl:with-param>
				     <xsl:with-param name="maxsize">5</xsl:with-param>
				     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
				     <xsl:with-param name="required">Y</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="invoice-payable-grid"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="invoice-payable-requested-amt">
		<xsl:call-template name="currency-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_IN_FINANCE_REQUESTED_AMT</xsl:with-param>
			<xsl:with-param name="product-code">requested</xsl:with-param>
			<xsl:with-param name="override-currency-value">
     			<xsl:value-of select="base_cur_code"/>
     		</xsl:with-param>
			<xsl:with-param name="override-amt-value">
	    		<xsl:value-of select="requested_amt"/>
	    	</xsl:with-param>
	    	<xsl:with-param name="show-amt">Y</xsl:with-param>
			<xsl:with-param name="amt-readonly">Y</xsl:with-param>
			<xsl:with-param name="currency-readonly">Y</xsl:with-param>
			<xsl:with-param name="show-button">N</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="realform">
	   <xsl:call-template name="form-wrapper">
	    <xsl:with-param name="name">realform</xsl:with-param>
	    <xsl:with-param name="method">POST</xsl:with-param>
	    <xsl:with-param name="action" select="$realform-action"/>
	    <xsl:with-param name="content">	
	     <div class="widgetContainer">
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">operation</xsl:with-param>
				<xsl:with-param name="id">realform_operation</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">referenceids</xsl:with-param>
				<xsl:with-param name="value" select="referenceids"/>
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">tnxtype</xsl:with-param>
		       <xsl:with-param name="value">63</xsl:with-param>
		    </xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">TransactionData</xsl:with-param>
				<xsl:with-param name="value"/>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
			 	<xsl:with-param name="name">base_ccy</xsl:with-param>
				<xsl:with-param name="value" select="base_cur_code"></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
			 	<xsl:with-param name="name">mode</xsl:with-param>
				<xsl:with-param name="value">DRAFT</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
			 	<xsl:with-param name="name">option</xsl:with-param>
				<xsl:with-param name="value">IP_FINANCE_REQUEST</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
		       	<xsl:with-param name="name">token</xsl:with-param>
		       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
		    </xsl:call-template>
		    <xsl:call-template name="hidden-field">
		       	<xsl:with-param name="name">productcode</xsl:with-param>
		       	<xsl:with-param name="value">IP</xsl:with-param>
		    </xsl:call-template>
		    <xsl:call-template name="hidden-field">
		    	<xsl:with-param name="name">grand_total</xsl:with-param>  
		      	<xsl:with-param name="value"><xsl:value-of select="grand_total"/></xsl:with-param>
		    </xsl:call-template>
		    <xsl:call-template name="hidden-field">
	     		<xsl:with-param name="name">percentage_value</xsl:with-param>
	   		 	<xsl:with-param name="value"><xsl:value-of select="inv_eligible_pct"/></xsl:with-param>
	 		</xsl:call-template>
	      	<xsl:call-template name="e2ee_transaction"/>
	      	<xsl:call-template name="reauth_params"/>
	     </div>
	    </xsl:with-param>
	   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>