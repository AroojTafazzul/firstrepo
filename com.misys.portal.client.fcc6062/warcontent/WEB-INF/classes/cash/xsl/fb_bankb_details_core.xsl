<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Reporting Fees And Billing Screen (FB-BANKB) Form.

Copyright (c) 2000-2017 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      24/02/2017
author:    Kishore Krishnamurthy
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
	xmlns:collabutils="xalan://com.misys.portal.common.tools.CollaborationUtils"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
	exclude-result-prefixes="xmlRender localization ftProcessing securitycheck utils security collabutils defaultresource">

	<!-- 
	Global Parameters.
	These are used in the imported XSL, and to set global params in the JS 
	-->
	<xsl:param name="rundata"/>
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	<xsl:param name="product-code">FB</xsl:param> 
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="optionmode">edit</xsl:param>
	<xsl:param name="option"></xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/FundTransferScreen</xsl:param>
	
	<!-- Global Imports. -->
	<xsl:include href="../../core/xsl/common/trade_common.xsl" /> 
	<xsl:include href="./common/ft_common.xsl" />
	 <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" /> 
  
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/">
		<xsl:apply-templates select="fb_tnx_record"/>
	</xsl:template>
	
	<xsl:template match="fb_tnx_record">
	<xsl:if test="$option= 'DETAILS'">
	<div id="event-summary">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="parse-widgets">N</xsl:with-param>
		<xsl:with-param name="legend">XSL_HEADER_EVENT_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
				<xsl:if test="release_dttm[.!='']">
					<xsl:call-template name="row-wrapper">
						<xsl:with-param name="id">event_summary_release_dttm_view</xsl:with-param>
						<xsl:with-param name="label">XSL_EVENT_DATE</xsl:with-param>
						<xsl:with-param name="content">
							<div class="content">
								<xsl:value-of select="converttools:formatReportDate(release_dttm,$rundata)"/>
							</div>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>	
			<xsl:if test="product_code[.!='']">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="id">event_summary_product_code_view</xsl:with-param>
					<xsl:with-param name="label">XSL_TRANSACTIONDETAILS_PRODUCT_CODE</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="localization:getDecode($language, 'N001', product_code[.])"/>
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="tnx_type_code[.!='']">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_TRANSACTIONDETAILS_PRODUCT_TYPE</xsl:with-param>
					<xsl:with-param name="id">event_summary_tnx_type_view</xsl:with-param>
					<xsl:with-param name="content">
						<div class="content">
							<xsl:value-of select="localization:getDecode($language, 'N002', tnx_type_code[.])"/>
							<xsl:if test="sub_tnx_type_code[.!='']">&nbsp;<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code[.])"/>
							</xsl:if>
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="row-wrapper">
				<xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
				<xsl:with-param name="id">event_summary_ref_id_view</xsl:with-param>
				<xsl:with-param name="content">
					<div class="content">
						<xsl:value-of select="ref_id"/>
					</div>
				</xsl:with-param>
			</xsl:call-template>

			<xsl:call-template name="row-wrapper">
				<xsl:with-param name="label">BANK_LABEL</xsl:with-param>
				<xsl:with-param name="id">event_summary_cust_ref_id_view</xsl:with-param>
				<xsl:with-param name="content">
					<div class="content">
						<xsl:value-of select="issuing_bank/name"/>
					</div>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:with-param>
			</xsl:call-template>

</div>
</xsl:if>
	
		<!-- Preloader -->
		<xsl:call-template name="loading-message"/>
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name" />
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
					<!-- Disclaimer Notice -->
					<xsl:call-template name="disclaimer" />
					<xsl:call-template name="hidden-fields" />
					<div>
						<xsl:call-template name="server-message">
							<xsl:with-param name="name">server_message</xsl:with-param>
							<xsl:with-param name="content"><xsl:value-of select="message" /></xsl:with-param>
							<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
						</xsl:call-template>
						<!-- Transfer sections -->						
						<xsl:call-template name="invoice-general-details"/>
					</div>
				</xsl:with-param>
			</xsl:call-template>
		</div>
	</xsl:template>

<xsl:template name="invoice-general-details">
		<xsl:param name="show-template-id">Y</xsl:param>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BANK_INVOICE_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			  <xsl:call-template name="column-container">
				 <xsl:with-param name="content">			 
			  <xsl:call-template name="column-wrapper">
			     <xsl:with-param name="content">
					<xsl:if test="$displaymode='view' and entities[number(.) &gt; 0]">                                     
 	 	 				 <div id="display_entity_row" class="field">
 	 	 				 <span class="label"><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></span>
 	 	 				 <div class="content"><xsl:value-of select="entity"/></div> 
 	 	 				 </div>                                                  
 	 				 </xsl:if>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_BANKINVOICEDETAILS_INVOICE_REFERENCE</xsl:with-param>	
							<xsl:with-param name="id">invoice_reference</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="bo_ref_id"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_BANKINVOICEDETAILS_INVOICE_CURRENCY</xsl:with-param>	
							<xsl:with-param name="id">invoice_ccy</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="fb_cur_code"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_BANKINVOICEDETAILS_INVOICE_AMOUNT</xsl:with-param>	
							<xsl:with-param name="id">invoice_amt</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="inv_amt"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_BANKINVOICEDETAILS_PRV_DUE_AMT</xsl:with-param>	
							<xsl:with-param name="id">prev_due_amt</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="prev_due_amt"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_BANKINVOICEDETAILS_RECD_AMT</xsl:with-param>	
							<xsl:with-param name="id">recd_amt</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="recd_amt"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_BANKINVOICEDETAILS_DUE_AMT</xsl:with-param>	
							<xsl:with-param name="id">due_amt</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="due_amt"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
				</xsl:with-param>
			 </xsl:call-template>
				<xsl:call-template name="column-wrapper">
						 <xsl:with-param name="content">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">ENTITY_LABEL</xsl:with-param>	
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="id">issuing_bank_name_view</xsl:with-param>
							<xsl:with-param name="value" select="entity" />
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_BANKINVOICEDETAILS_INVOICE_CUST_ID</xsl:with-param>	
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="id">customer_id</xsl:with-param>
							<xsl:with-param name="value" select="utils:decryptApplicantReference(applicant_reference)" />
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_BANKINVOICEDETAILS_INVOICE_DATE</xsl:with-param>	
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="id">inv_date</xsl:with-param>
							<xsl:with-param name="value" select="appl_date" />
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_BANKINVOICEDETAILS_INVOICE_DUE_DATE</xsl:with-param>	
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="id">inv_due_date</xsl:with-param>
							<xsl:with-param name="value" select="inv_due_date" />
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
		</xsl:with-param>
		</xsl:call-template>
	  </xsl:with-param>
    </xsl:call-template>
	</xsl:template>
	</xsl:stylesheet>
