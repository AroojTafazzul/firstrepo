<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Review screen for multiple finance request IP, Customer Side.

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
    xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools"
	exclude-result-prefixes="localization convertTools">

  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
	<xsl:param name="rundata"/>
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="option">IP_FINANCE_REQUEST</xsl:param>
	<xsl:param name="product-code">IP</xsl:param>
	
	<xsl:include href="../../core/xsl/common/trade_common.xsl" />
	<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
	
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/InvoicePayableScreen</xsl:param>
	
	<!-- These params are empty for trade message -->
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes"/>
	<xsl:template match="finance_request_summary">
		<xsl:call-template name="finance-request-summary"/>
	</xsl:template>
	<xsl:template name="finance-request-summary">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="content">
			<div style="width:100%;height:100%;" class="widgetContainer clear">
				<table style="width:100%">
					  <thead>
					  	<tr>
				        <th class="multiSubmissionListHeader userAccountColumnCell" style="width:20%;padding-bottom: 8px;text-align:center" colspan="5"><xsl:value-of select="localization:getGTPString($language, 'AUDIT_RESULT')"/></th>
				       </tr>
					  </thead>
					  <thead>
				       <tr>
				        <th class="multiSubmissionListHeader userAccountColumnCell" scope="col" style="width:20%;padding-bottom: 8px;text-align:center"><xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/></th>
				        <th class="multiSubmissionListHeader userAccountColumnCell" scope="col" style="width:20%;padding-bottom: 8px;text-align:center"><xsl:value-of select="localization:getGTPString($language, 'SELLER_NAME')"/></th>
				       	<th class="multiSubmissionListHeader userAccountColumnCell" scope="col" style="width:10%;padding-bottom: 8px;text-align:center"><xsl:value-of select="localization:getGTPString($language, 'GRID_INVOICE_REQUESTED_AMOUNT')"/></th>
				       	<th class="multiSubmissionListHeader userAccountColumnCell" scope="col" style="width:20%;padding-bottom: 8px;text-align:center"><xsl:value-of select="localization:getGTPString($language, 'STATUS')"/></th>
				       	<th class="multiSubmissionListHeader userAccountColumnCell" scope="col" style="width:30%;padding-bottom: 8px;text-align:center"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_SHOW_COMMENTS')"/></th>
				       </tr>
				       </thead>
						<xsl:attribute name="id">finance_request_summary</xsl:attribute>      
				         <xsl:for-each select="invoice">
				         <tbody>
				          <tr class="multiSubmissionColumnCell multiSubmissionColumnCellValuePlacement" style="width:800px;vertical-align: middle">
				         	<td style="text-align:center">
				         		<a href="javascript:void(0)">
						           <xsl:attribute name="onclick">
						           		misys.popup.showReporting('FULL', '<xsl:value-of select="$product-code"/>', '<xsl:value-of select="reference_id"/>', '<xsl:value-of select="tnx_id"/>');return false;
						           </xsl:attribute>
						           <xsl:value-of select="reference_id"/>
						        </a>
					        </td>
				           	<td style="text-align:center"><xsl:value-of select="cp_name"/></td>
				           	<td style="text-align:right;padding-right:5px;">
				           		<xsl:value-of select="finance_requested_cur_code"/>&nbsp;<xsl:value-of select="finance_requested_amt"/>
				           	</td>
				           	<td style="text-align:center"><xsl:value-of select="status"/></td>
				           	<td style="text-align:center"><xsl:value-of select="message"/></td>
				          </tr>
				          </tbody>
				         </xsl:for-each>
			     </table>
			 </div>
			</xsl:with-param>
		</xsl:call-template>
	    <xsl:call-template name="hidden-field">
	     	 <xsl:with-param name="name">product_code</xsl:with-param>
	   		 <xsl:with-param name="value">IP</xsl:with-param>
	 	</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>