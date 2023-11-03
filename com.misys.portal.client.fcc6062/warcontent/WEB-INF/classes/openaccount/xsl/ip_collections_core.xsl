<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<!--
##########################################################
Templates for

 Open Account - Collections (IP) Form, Customer Side.
 
Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      06/29/17
author:    Chaitra Muralidhar
email:     chaitra.m@misys.com
##########################################################
-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:fscmUtils="xalan://com.misys.portal.openaccount.util.FSCMUtils"
	exclude-result-prefixes="localization securityCheck security defaultresource fscmUtils">
		
	<xsl:param name="rundata" />
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param>
	<xsl:param name="product-code">IP</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="nextscreen" />
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath" /><xsl:value-of select="$servletPath" />/screen/InvoicePayableScreen</xsl:param>
	<xsl:param name="hasEntity">N</xsl:param>

	
	<!-- All marks used to shown/hidden form's sections-->
	
	<xsl:param name="show-template">N</xsl:param>
	<xsl:param name="product-currency-label">XSL_INVOICE_PAYABLE_CURRENCY_CODE</xsl:param>
	<xsl:param name="show_buyer_button">Y</xsl:param>
	
	<xsl:variable name="fscm_cash_customization_enable">
  		<xsl:value-of select="defaultresource:getResource('FSCM_CASH_CUSTOMIZATION_ENABLE')"/>
  	</xsl:variable>
	
	<xsl:include href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:include href="../../core/xsl/common/com_cross_references.xsl"/>
	<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
	<xsl:include href="../../core/xsl/common/fx_common.xsl"/>
	<xsl:include href="../../core/xsl/common/fscm_common.xsl" />
	
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
 
	<xsl:template match="/">
		<xsl:apply-templates select="ip_tnx_record"/>
	</xsl:template>

	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.openaccount.create_ip_settlement</xsl:with-param>
			<xsl:with-param name="show-period-js">Y</xsl:with-param>
			<xsl:with-param name="override-lowercase-product-code">ip</xsl:with-param>
			<xsl:with-param name="override-help-access-key">IN_01</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="ip_tnx_record">
	<!-- Preloader  -->
	<xsl:call-template name="loading-message" />

	<div>
		<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>

	<!-- Form #0 : Main Form -->
	<xsl:call-template name="form-wrapper">
		<xsl:with-param name="name" select="$main-form-name" />
		<xsl:with-param name="validating">Y</xsl:with-param>
		<xsl:with-param name="content">
			<!--  Display common menu.  -->
			<xsl:call-template name="menu">
				<xsl:with-param name="show-template" select="$show-template"/>	
				<xsl:with-param name="show-return">Y</xsl:with-param>
			</xsl:call-template>

			<!-- Disclaimer Notice -->
			<xsl:call-template name="disclaimer" />
			
			<!-- Reauthentication -->	
		 	<xsl:call-template name="server-message">
		 		<xsl:with-param name="name">server_message</xsl:with-param>
		 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
		 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="reauthentication" />

			<xsl:apply-templates select="cross_references" mode="hidden_form" />
			<xsl:call-template name="hidden-fields" />
			<!-- FSCM General Details -->
			<xsl:call-template name="fscm-general-details">
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			<!-- Settlement Amount details -->
			<xsl:call-template name="settlement-amount-details" />
			<xsl:call-template name="exchange-rate-details" />	
			<xsl:call-template name="instructions-for-bank" />
			<xsl:call-template name="instructions-from-bank" />
			
		
			<!-- Form #1 : Attach Files -->
			<xsl:choose>
				<xsl:when test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
					<xsl:call-template name="attachments-file-dojo">
						<xsl:with-param name="attachment-group">invoice</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="$option ='DETAILS'">
					<xsl:call-template name="attachments-file-dojo">
			          	<xsl:with-param name="existing-attachments" select="attachments/attachment[type = '01']"/>
			          	<xsl:with-param name="legend">XSL_HEADER_CUSTOMER_FILE_UPLOAD</xsl:with-param>
			          	<xsl:with-param name="attachment-group">summarycustomer</xsl:with-param>
		          	</xsl:call-template>
		          	<xsl:call-template name="attachments-file-dojo">
			          	<xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
			          	<xsl:with-param name="legend">XSL_HEADER_BANK_FILE_UPLOAD</xsl:with-param>
			          	<xsl:with-param name="attachment-group">summarybank</xsl:with-param>
		          	</xsl:call-template>
		          	</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			
			<!-- comments for return -->
			<xsl:call-template name="comments-for-return">
				<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
				<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
			</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</div>

	<!-- Table of Contents -->
	<xsl:call-template name="toc" />

	<!--  Collaboration Window  -->
	<xsl:call-template name="collaboration">
		<xsl:with-param name="editable">true</xsl:with-param>
		<xsl:with-param name="productCode">
			<xsl:value-of select="$product-code" />
		</xsl:with-param>
		<xsl:with-param name="contextPath">
			<xsl:value-of select="$contextPath" />
		</xsl:with-param>
		<xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
		<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
	</xsl:call-template>

	<!-- Display common menu, this time outside the form -->
	<xsl:call-template name="menu">
		<xsl:with-param name="second-menu">Y</xsl:with-param>
		<xsl:with-param name="show-template" select="$show-template"/>
		<xsl:with-param name="show-return">Y</xsl:with-param>					
	</xsl:call-template>
	
	<!-- The form that's submitted -->
	<xsl:call-template name="realform" />
	
	<!-- Javascript and Dojo imports  -->
	<xsl:call-template name="js-imports" />
</xsl:template>

	<!--                                     -->
	<!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
	<!--                                     -->

	<!-- Additional hidden fields for this form are  -->
	<!-- added here. -->
	<xsl:template name="hidden-fields">
		<xsl:call-template name="common-hidden-fields" />
		<div class="widgetContainer">
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
				<xsl:with-param name="value">
					<xsl:value-of select="issuing_bank/abbv_name" />
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">issuing_bank_name</xsl:with-param>
				<xsl:with-param name="value">
					<xsl:value-of select="issuing_bank/name" />
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">product_code</xsl:with-param>				
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">sub_product_code</xsl:with-param>	
					<xsl:with-param name="value"><xsl:value-of select="sub_product_code"/></xsl:with-param>			
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">program_id</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="security:isCounterparty($rundata)">
		 	  	<xsl:call-template name="hidden-field">
		     		<xsl:with-param name="name">company_type</xsl:with-param>
		     	 	<xsl:with-param name="value"><xsl:value-of select="company_type"/></xsl:with-param>
		   		</xsl:call-template>
		   	</xsl:if>
		   	<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">fx_rates_type_temp</xsl:with-param>
			   	<xsl:with-param name="value"><xsl:value-of select="fx_rates_type"></xsl:value-of></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">fx_master_currency</xsl:with-param>
			    <xsl:with-param name="value"><xsl:value-of select="fx_contract_nbr_cur_code_1"></xsl:value-of></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">prod_stat_code</xsl:with-param>
			    <xsl:with-param name="value"><xsl:value-of select="prod_stat_code"></xsl:value-of></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">tnx_type_code</xsl:with-param>
			    <xsl:with-param name="value"><xsl:value-of select="tnx_type_code"></xsl:value-of></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="counterparty_abbv_name"><xsl:value-of select="seller_abbv_name" /></xsl:variable>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bene_access_opened</xsl:with-param>
			    <xsl:with-param name="value"><xsl:value-of select="fscmUtils:getBeneficiaryCollaborationDetails($rundata,$counterparty_abbv_name,'IN','access')"></xsl:value-of></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bene_email</xsl:with-param>
			    <xsl:with-param name="value"><xsl:value-of select="fscmUtils:getBeneficiaryCollaborationDetails($rundata,$counterparty_abbv_name,'IN','email')"></xsl:value-of></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">abbvName</xsl:with-param>
			    <xsl:with-param name="value"><xsl:value-of select="fscmUtils:getBeneficiaryCollaborationDetails($rundata,$counterparty_abbv_name,'IN','beneCompAbbvName')"></xsl:value-of></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">collection_req_flag</xsl:with-param>	
					<xsl:with-param name="value"><xsl:value-of select="collection_req_flag"/></xsl:with-param>			
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">collection_discount_flag</xsl:with-param>	
					<xsl:with-param name="value"><xsl:value-of select="collection_discount_flag"/></xsl:with-param>			
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
		     	<xsl:with-param name="name">eligibility_flag</xsl:with-param>
		     </xsl:call-template>
		</div>
	</xsl:template>
 	
	<!--
   PO Realform.
   -->
	<xsl:template name="realform">
		<!--
			Do not display this section when the counterparty mode is
			'counterparty'
		-->
		
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name">realform</xsl:with-param>
				<xsl:with-param name="action" select="$realform-action" />
				<xsl:with-param name="content">
					<div class="widgetContainer">
						<xsl:call-template name="hidden-field">
					       <xsl:with-param name="name">referenceid</xsl:with-param>
					       <xsl:with-param name="value" select="ref_id"/>
					      </xsl:call-template>
					      <xsl:call-template name="hidden-field">
					       <xsl:with-param name="name">tnxid</xsl:with-param>
					       <xsl:with-param name="value" select="tnx_id"/>
					      </xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">operation</xsl:with-param>
							<xsl:with-param name="id">realform_operation</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">mode</xsl:with-param>
							<xsl:with-param name="value" select="$mode" />
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">tnxtype</xsl:with-param>
							<xsl:with-param name="value">85</xsl:with-param>
						</xsl:call-template>
					<!-- 	<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">subtnxtype</xsl:with-param>
							<xsl:with-param name="value">A4</xsl:with-param>
						</xsl:call-template> -->
						<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">subproductcode</xsl:with-param>	
					<xsl:with-param name="value"><xsl:value-of select="sub_product_code"/></xsl:with-param>			
			</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">attIds</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">TransactionData</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
						  <xsl:call-template name="hidden-field">
							<xsl:with-param name="name">cashCustomizationEnable</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$fscm_cash_customization_enable"/></xsl:with-param>							
						 </xsl:call-template>
						<xsl:if test="tnx_type_code = '01' and $option = 'EXISTING'">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">isCopyFrom</xsl:with-param>
								<xsl:with-param name="value">Y</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:call-template name="e2ee_transaction"/>
						<xsl:call-template name="reauth_params"/>						
					</div>
				</xsl:with-param>
			</xsl:call-template>
		
	</xsl:template>
	
</xsl:stylesheet>
