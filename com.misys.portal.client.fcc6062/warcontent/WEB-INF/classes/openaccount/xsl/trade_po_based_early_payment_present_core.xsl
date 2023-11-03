<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<!--
##########################################################
Templates for

 Invoice Presentation Form, Customer Side.
 
 Note: Templates beginning with lc- are in lc_common.xsl

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      24/07/11
author:    Gilles Weber
email:     gilles.weber@misys.com
##########################################################
	-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	exclude-result-prefixes="localization">
		
	<xsl:param name="rundata" />
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param>
	<xsl:param name="product-code">IN</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath" /><xsl:value-of select="$servletPath" />/screen/InvoiceScreen</xsl:param>

	
	<!-- All marks used to shown/hidden form's sections-->
	<xsl:param name="section_in_line_items"/>
	<xsl:param name="section_in_amount_details"/>
	<xsl:param name="section_in_inco_terms"/>
	<xsl:param name="section_in_routing_summary"/>
	
	<xsl:param name="section_li_product"/>
	<xsl:param name="section_li_amount_details"/>
	<xsl:param name="section_li_shipment_details"/>
	<xsl:param name="section_li_inco_terms"/>
	<xsl:param name="section_li_routing_summary"/>
	
	<xsl:param name="section_line_item_adjustments_details"></xsl:param>
	<xsl:param name="section_line_item_taxes_details"></xsl:param>
	<xsl:param name="section_line_item_freight_charges_details"></xsl:param>
	<xsl:param name="section_line_item_shipment_details"></xsl:param>
	<xsl:param name="section_line_item_inco_terms_details"></xsl:param>
	
	<xsl:include href="po_common.xsl"/>
<!-- 	<xsl:include href="../../collaboration/xsl/collaboration.xsl"/> -->
	<xsl:include href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:include href="../../core/xsl/common/com_cross_references.xsl"/>
	
	<!-- Global Imports. -->
	<xsl:include href="../../core/xsl/common/trade_common.xsl" />
	
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

	<xsl:template match="/">
		<xsl:apply-templates select="in_tnx_record"/>
	</xsl:template>

	<!--TEMPLATE Main-->

	<xsl:template match="in_tnx_record">

	<!-- Include some eventual additional elements -->
<!-- 	<xsl:call-template name="client_addons"/> -->
	
		<!-- Preloader  -->
		<xsl:call-template name="loading-message" />

        <!-- Payments declaration -->
		<xsl:call-template name="payments-declaration" />
					
		<!-- ***************************** -->
		<!-- Widgets' template declaration -->
		<!-- ***************************** -->
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>

			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name" />
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
					<!--  Display common menu.  -->
					<xsl:call-template name="menu" />

					<!-- Disclaimer Notice -->
					<xsl:call-template name="disclaimer" />

					<xsl:apply-templates select="cross_references" mode="hidden_form" />

					

					<xsl:call-template name="hidden-fields" />
					<xsl:call-template name="general-details" />
			
					<!-- Payment terms -->
					<xsl:call-template name="payment-terms"/>
					
					<!-- Bank Instructions -->
					<xsl:call-template name="bank-instructions">
						<xsl:with-param name="send-mode-displayed">N</xsl:with-param>
						<xsl:with-param name="forward-contract-shown">N</xsl:with-param>
						<xsl:with-param name="principal-acc-displayed">N</xsl:with-param>
						<xsl:with-param name="fee-acc-displayed">N</xsl:with-param>
						<xsl:with-param name="title">XSL_HEADER_OTHER_INFORMATION</xsl:with-param>
  					</xsl:call-template>

					<xsl:call-template name="attachments-file-dojo">
						<xsl:with-param name="legend">XSL_REPORT_IN</xsl:with-param>
						<xsl:with-param name="max-files">1</xsl:with-param>
						<xsl:with-param name="attachment-group">invoice</xsl:with-param>
						<xsl:with-param name="existing-attachments" select="attachments/attachment[type = '07']"/>
					</xsl:call-template>

					<xsl:call-template name="attachments-file-dojo">
						<xsl:with-param name="legend">XSL_HEADER_OPTIONAL_FILE_UPLOAD</xsl:with-param>
						<xsl:with-param name="max-files">3</xsl:with-param>
						<xsl:with-param name="attachment-group">optional</xsl:with-param>
						<xsl:with-param name="existing-attachments" select="attachments/attachment[type = '06']"/>
					</xsl:call-template>

					<!-- Goods details -->
					<!-- <xsl:call-template name="goods-details" />-->
 
					<!-- Amount details -->
					<!--<xsl:if test="$section_in_amount_details!='N'">
						<xsl:call-template name="amount-details" />
					</xsl:if>-->
					
					<!-- Payment details -->
					<!--	<xsl:call-template name="payment-terms" />-->
					
					<!--Settlement Terms Details-->
					<!--	<xsl:call-template name="settlement-terms" />-->
					
					<!--Bank Details-->
					<!--<xsl:if test="tnx_type_code[. != '03']">
						<xsl:call-template name="bank-details" />
					</xsl:if>-->
					
					<!-- Reauthentication -->
					<xsl:call-template name="authentication">
						<xsl:with-param name="reauth_mode">PASSWORD</xsl:with-param>
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
		</xsl:call-template>
		
		<!-- The form that's submitted -->
		<xsl:call-template name="realform" />
		
		<!-- Javascript and Dojo imports  -->
		<xsl:call-template name="js-imports" />

	</xsl:template>

	<!--                                     -->
	<!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
	<!--                                     -->

	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.openaccount.present_in</xsl:with-param>
			<xsl:with-param name="show-period-js">Y</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Additional hidden fields for this form are  -->
	<!-- added here. -->
	<xsl:template name="hidden-fields">
		<xsl:call-template name="common-hidden-fields">
			<xsl:with-param name="show-tnx-amt">N</xsl:with-param>
			<xsl:with-param name="additional-fields">
			
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">fin_cur_code</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="tnx_cur_code" /></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">fin_amt</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="tnx_amt" /></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">tnx_cur_code</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">buyer_abbv_name</xsl:with-param>
		</xsl:call-template>
						
			<!-- <div style="display:none">
				<xsl:call-template name="issuing-bank-tabcontent"/>
			</div>-->
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">issuing_bank_name</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="issuing_bank/name"/></xsl:with-param>
		</xsl:call-template>
			
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">payment_terms_type</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">issuer_ref_id</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
		</xsl:call-template>
<!-- 		<xsl:call-template name="hidden-field"> -->
<!-- 			<xsl:with-param name="name">parent_ref_id</xsl:with-param> -->
<!-- 			<xsl:with-param name="value"><xsl:value-of select="org_previous_file/cross_references/cross_reference/ref_id"/></xsl:with-param> -->
<!-- 		</xsl:call-template> -->
<!-- 		<xsl:call-template name="hidden-field"> -->
<!-- 			<xsl:with-param name="name">so_ref_id</xsl:with-param> -->
<!-- 			<xsl:with-param name="value"><xsl:value-of select="org_previous_file/so_tnx_record/ref_id"/></xsl:with-param> -->
<!-- 		</xsl:call-template> -->
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">presentation_flag</xsl:with-param>
			<xsl:with-param name="value">Y</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">total_cur_code</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">total_amt</xsl:with-param>
		</xsl:call-template>
<!-- 		<xsl:call-template name="hidden-field"> -->
<!-- 			<xsl:with-param name="name">so_ref_id</xsl:with-param> -->
<!-- 		</xsl:call-template> -->
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">buyer_name</xsl:with-param>
		</xsl:call-template>
			
			</xsl:with-param>
		</xsl:call-template>
		
	</xsl:template>

	<!--
		General Details Fieldset. 
		-->
	<xsl:template name="general-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="button-type">initiation-from-details</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="common-general-details">
					<xsl:with-param name="show-bo-ref-id">N</xsl:with-param>
					<xsl:with-param name="show-template-id">N</xsl:with-param>
					<xsl:with-param name="show-cust-ref-id">Y</xsl:with-param>
					<xsl:with-param name="override-cust-ref-id-label">XSL_GENERALDETAILS_IN_ISSUER_REF_ID</xsl:with-param>
					<xsl:with-param name="required-cust-ref-id">Y</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="in-general-details"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
		<!--
		General Details Fieldset. Invoice Date, Presentation Amount,
		Early Payment details.
		-->
	<xsl:template name="in-general-details">
		<!--  Invoice date. -->
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_DATE</xsl:with-param>
			<xsl:with-param name="name">iss_date</xsl:with-param>
			<xsl:with-param name="value" select="iss_date" />
			<xsl:with-param name="type">date</xsl:with-param>
			<xsl:with-param name="fieldsize">small</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
		</xsl:call-template>

		<!-- Presentation amount -->
		<xsl:call-template name="currency-field">
			<xsl:with-param name="label">XSL_DOCUMENT_PRESENTATION_AMOUNT</xsl:with-param>
			<xsl:with-param name="product-code">tnx</xsl:with-param>
<!-- 			<xsl:with-param name="override-currency-name">tnx_cur_code</xsl:with-param> -->
<!-- 			<xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param> -->
<!-- 			<xsl:with-param name="show-currency">Y</xsl:with-param> -->
			<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
			<xsl:with-param name="show-button">N</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
		</xsl:call-template>

		<!-- Early Payment -->
		<xsl:choose>
			<xsl:when test="counterparty_early_payment[. = 'Y']">
				<div class="no-left-margin">	
					<xsl:if test="$displaymode='edit'">
						<div>
							<p><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_UTILIZATION_FINANCING_REQUEST')"/></p>
						</div>
						<br/>
						<div>
							<p><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_UTILIZATION_FINANCING_REQUEST_DISCLAIMER')"/></p>
						</div>
					</xsl:if>				
					<br/>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_INVOICE_EARLY_PAYMENT_YES</xsl:with-param>
						<xsl:with-param name="name">financing_request_flag</xsl:with-param>
						<xsl:with-param name="id">financing_request_flag_1</xsl:with-param>
						<xsl:with-param name="value">Y</xsl:with-param>
						<xsl:with-param name="checked"><xsl:if test="financing_request_flag[. = 'Y']">Y</xsl:if></xsl:with-param>
					</xsl:call-template>
					<div>
						<p><xsl:value-of select="localization:getGTPString($language, 'XSL_INVOICE_EARLY_PAYMENT_YES_DESCRIPTION')"/></p>
					</div>
	
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_INVOICE_EARLY_PAYMENT_OPTION</xsl:with-param>
						<xsl:with-param name="name">financing_request_flag</xsl:with-param>
						<xsl:with-param name="id">financing_request_flag_2</xsl:with-param>
						<xsl:with-param name="value">O</xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:choose>
								<xsl:when test="financing_request_flag[.='Y']">N</xsl:when>
								<xsl:when test="financing_request_flag[.='N']">N</xsl:when>
								<xsl:otherwise>Y</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					
					<xsl:if test="$displaymode='edit'">
					<div>
						<p><xsl:value-of select="localization:getGTPString($language, 'XSL_INVOICE_EARLY_PAYMENT_OPTION_DESCRIPTION')"/></p>
					</div>
					</xsl:if>
	
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_INVOICE_EARLY_PAYMENT_NO</xsl:with-param>
						<xsl:with-param name="name">financing_request_flag</xsl:with-param>
						<xsl:with-param name="id">financing_request_flag_3</xsl:with-param>
						<xsl:with-param name="value">N</xsl:with-param>
						<xsl:with-param name="checked"><xsl:if test="financing_request_flag[. = 'N']">Y</xsl:if></xsl:with-param>
					</xsl:call-template>
	
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_BUYER_ADVANCE_PAYMENT_CONDITIONS</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
							<xsl:call-template name="textarea-field">
							<xsl:with-param name="name">counterparty_early_payment_conds</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">financing_request_flag</xsl:with-param>
					<xsl:with-param name="value">N</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	


	<!--  Payment Details Fieldset. -->
	<xsl:template name="payment-terms">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PAYMENT_TERMS_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			<!--  Magic div nbsp without that, this widget don't display ! -->
				<div>&nbsp;</div>
				<div style="display:none">
				<xsl:call-template name="checkbox-field">
				   <xsl:with-param name="name">payment_terms_type_1</xsl:with-param>
				   <xsl:with-param name="label"></xsl:with-param>
				   <xsl:with-param name="checked">
				   <xsl:choose>
						<xsl:when test="payment_terms_type='AMNT'">Y</xsl:when>
						<xsl:otherwise>N</xsl:otherwise>
					</xsl:choose>
					</xsl:with-param>
   				</xsl:call-template>
   				<xsl:call-template name="checkbox-field">
				   <xsl:with-param name="name">payment_terms_type_2</xsl:with-param>
				   <xsl:with-param name="label"></xsl:with-param>
				   <xsl:with-param name="checked">N</xsl:with-param>
   				</xsl:call-template>
   				</div>
				<xsl:call-template name="payments-new">
					<xsl:with-param name="override-displaymode">editonly</xsl:with-param><!--  can edit but not create -->
					<xsl:with-param name="type">invoice_presentation</xsl:with-param> 
					<xsl:with-param name="items" select="payments/payment" />
					<xsl:with-param name="id">po-payments</xsl:with-param>
				</xsl:call-template>
						
			</xsl:with-param>
		</xsl:call-template>							
	</xsl:template>
	
	<!--  Settlment Details Fieldset. -->
	<xsl:template name="settlement-terms">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_SETTLEMENT_TERMS_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_PURCHASE_ORDER_SELLER_ACCOUNT</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
					
						<xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE</xsl:with-param>
							<xsl:with-param name="name">seller_account_type</xsl:with-param>
							<!-- events : onChange -->
							<xsl:with-param name="options">
								<option value="">&nbsp;
								</option>
								<option value="IBAN">
									<xsl:if test="seller_account_iban[.!='']">
										<xsl:attribute name="selected" />
									</xsl:if>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN')" />
								</option>
								<option value="BBAN">
									<xsl:if test="seller_account_bban[.!='']">
										<xsl:attribute name="selected" />
									</xsl:if>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_BBAN')" />
								</option>
								<option value="UPIC">
									<xsl:if test="seller_account_upic[.!='']">
										<xsl:attribute name="selected" />
									</xsl:if>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_UPIC')" />
								</option>
								<option value="OTHER">
									<xsl:if test="seller_account_id[.!='']">
										<xsl:attribute name="selected" />
									</xsl:if>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_OTHER')" />
								</option>
							</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_NAME</xsl:with-param>
							<xsl:with-param name="name">seller_account_name</xsl:with-param>
							<!-- events : onblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="seller_account_name" />
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PURCHASE_ORDER_SELLER_ACCOUNT_NUMBER</xsl:with-param>
							<xsl:with-param name="name">seller_account_value</xsl:with-param>
							<!-- events : onfocus, onblur -->
							<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="seller_account_iban[.!='']"><xsl:value-of select="seller_account_iban" /></xsl:when>
									<xsl:when test="seller_account_bban[.!='']"><xsl:value-of select="seller_account_bban" /></xsl:when>
									<xsl:when test="seller_account_upic[.!='']"><xsl:value-of select="seller_account_upic" /></xsl:when>
									<xsl:when test="seller_account_id[.!='']"><xsl:value-of select="seller_account_id" /></xsl:when>
									<xsl:otherwise />
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>
						
					</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_PURCHASE_ORDER_FINANCIAL_INSTITUTION</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
					
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_NAME</xsl:with-param>
							<xsl:with-param name="name">fin_inst_name</xsl:with-param>
							<!-- events : onblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_name" />
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>

						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PARTIESDETAILS_BIC_CODE</xsl:with-param>
							<xsl:with-param name="name">fin_inst_bic</xsl:with-param>
							<!-- events : onblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_bic" />
							</xsl:with-param>
							<xsl:with-param name="size">11</xsl:with-param>
							<xsl:with-param name="maxsize">11</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
							<xsl:with-param name="name">fin_inst_street_name</xsl:with-param>
							<!-- events : onblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_street_name" />
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">70</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
							<xsl:with-param name="name">fin_inst_post_code</xsl:with-param>
							<!-- event : sonblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_post_code" />
							</xsl:with-param>
							<xsl:with-param name="size">16</xsl:with-param>
							<xsl:with-param name="maxsize">16</xsl:with-param>
							<xsl:with-param name="fieldsize">x-small</xsl:with-param>
						</xsl:call-template>

						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
							<xsl:with-param name="name">fin_inst_town_name</xsl:with-param>
							<!-- event : sonblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_town_name" />
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>

						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
							<xsl:with-param name="name">fin_inst_country_sub_div</xsl:with-param>
							<!-- event : sonblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_country_sub_div" />
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">34</xsl:with-param>
						</xsl:call-template>

						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY</xsl:with-param>
							<xsl:with-param name="name">fin_inst_country</xsl:with-param>
							<!-- event : sonblur -->
							<xsl:with-param name="value">
								<xsl:value-of select="fin_inst_country" />
							</xsl:with-param>
							<xsl:with-param name="size">2</xsl:with-param>
							<xsl:with-param name="maxsize">2</xsl:with-param>
						</xsl:call-template>

					</xsl:with-param>
				</xsl:call-template>

			</xsl:with-param>
		</xsl:call-template>							
	</xsl:template>


<xsl:template name="hidden-bank-field">
	<xsl:param name="prefix"></xsl:param>
	
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="$prefix/name"/></xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_abbv_name</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="$prefix/abbv_name"/></xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_iso_code</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="$prefix/iso_code"/></xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="override-displaymode">view</xsl:with-param>
		<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_Type_Issuing</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, XSL_BANKDETAILS_TYPE_ISSUING)"/></xsl:with-param>
	</xsl:call-template>
</xsl:template>


<xsl:template name="bank-details">
	<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<script>
					dojo.ready(function(){
						misys._config = misys._config || {};
						misys._config.customerReferences = {};
						<xsl:apply-templates select="avail_main_banks/bank"	mode="customer_references" />
					});
				</script>
				<xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_TRANSACTIONDETAILS_ISSUING_BANK</xsl:with-param>
						<xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
						<!-- 
							<xsl:attribute name="onchange">document.<xsl:value-of select="$main_bank_form"/>.<xsl:value-of select="$main_bank_name"/>_name.value = this.options[this.selectedIndex].text;fncPopulateReferences(this,document.<xsl:value-of select="$main_bank_form"/>.<xsl:value-of select="$main_bank_name"/>_customer_reference,document.<xsl:value-of select="$main_bank_form"/>.<xsl:value-of select="$sender_reference_name"/>, document.fakeform1.entity);fncRestoreInputStyle('<xsl:value-of select="$main_bank_form"/>','<xsl:value-of select="$main_bank_name"/>_abbv_name');</xsl:attribute>
						 -->
						<xsl:with-param name="options">
						      <xsl:if test="count(avail_main_banks/bank)>1">
						        <option value="">&nbsp;</option>
						      </xsl:if>
						      <xsl:apply-templates select="avail_main_banks/bank" mode="main"/>
						</xsl:with-param>
				</xsl:call-template>
				<!--
					The selection of the related customer reference (turned into
					the buyer_reference) if at least one exists
				-->
				<xsl:call-template name="customer_reference_selectbox">
					<xsl:with-param name="main_bank_form">issuing_bank_form</xsl:with-param>
					<xsl:with-param name="main_bank_name">issuing_bank</xsl:with-param>
					<xsl:with-param name="sender_name">buyer</xsl:with-param>
					<xsl:with-param name="sender_reference_name">buyer_reference</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">issuing_bank_iso_code</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="issuing_bank/iso_code" /></xsl:with-param>
				</xsl:call-template>
			
		
		
		<!-- If the transaction is TSU based, don't allow to update Buyer Bank and Seller Bank -->
		
			
			<xsl:call-template name="tabgroup-wrapper">
			<xsl:with-param name="tabgroup-id">bank-details_section</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<!--  Tab 0_0 - SELLER_BANK  -->
			<xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_SELLER_BANK</xsl:with-param>
			<xsl:with-param name="tab0-content">
			<xsl:choose>
				<xsl:when test="tid != ''">
				<xsl:choose>
						<xsl:when test="seller_bank_type_code[.='01']">
							<xsl:call-template name="hidden-bank-field">
								<xsl:with-param name="prefix">seller_bank</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="seller_bank/name[.!='']">
							<xsl:call-template name="seller-bank-tab">
								<xsl:with-param name="theNodeName">seller_bank</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
				</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
				<xsl:call-template name="seller-bank-tab">
					<xsl:with-param name="theNodeName">seller_bank</xsl:with-param>
					<xsl:with-param name="theTypeCode" select="seller_bank_type_code"/>
				</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
				
			</xsl:with-param>
			<!--  Tab 0_1 - BUYER_BANK -->
			<xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_BUYER_BANK</xsl:with-param>
			<xsl:with-param name="tab1-content">
			
			<xsl:choose>
				<xsl:when test="tid != ''">
				<xsl:choose>
						<xsl:when test="buyer_bank_type_code[.='02']">
							<xsl:call-template name="hidden-bank-field">
								<xsl:with-param name="prefix">buyer_bank</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="buyer_bank/name[.!='']">
							<xsl:call-template name="buyer_bank-tab">
								<xsl:with-param name="theNodeName">buyer_bank</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
				</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
				<xsl:call-template name="buyer_bank-tab">
					<xsl:with-param name="theNodeName">buyer_bank</xsl:with-param>
					<xsl:with-param name="theTypeCode" select="buyer_bank_type_code"/>
					<xsl:with-param name="theSubmissionType" select="submission_type"/>
				</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		
	</xsl:with-param>
	</xsl:call-template>
	
</xsl:template>

<!--  Inco terms Fieldset. -->
	<xsl:template name="inco-terms">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_INCO_TERMS_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp; 
				<xsl:call-template name="build-incoterms-dojo-items">
					<xsl:with-param name="items" select="incoterms/incoterm"/>
					<xsl:with-param name="id" select="po-incoterms" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Routing summary Fieldset. -->
	<xsl:template name="routing-summary">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_ROUTING_SUMMARY_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			
			<xsl:call-template name="select-field">
				<!-- events : onfocus and onchange -->
				<xsl:with-param name="label">XSL_PO_ROUTING_SUMMARY_TRANSPORT_TYPE</xsl:with-param>
				<xsl:with-param name="name">transport_type</xsl:with-param>
				<xsl:with-param name="options">
					<option value="0">&nbsp;
					</option>
					<option value="01">
						<xsl:if
							test="count(/po_tnx_record/routing_summaries/routing_summary/transport_type[. = '01']) != 0">
							<xsl:attribute name="selected" />
						</xsl:if>
						<xsl:value-of
							select="localization:getDecode($language, 'N213', '01')" />
					</option>
					<option value="02">
						<xsl:if
							test="count(/po_tnx_record/routing_summaries/routing_summary/transport_type[. = '02']) != 0">
							<xsl:attribute name="selected" />
						</xsl:if>
						<xsl:value-of
							select="localization:getDecode($language, 'N213', '02')" />
					</option>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">transport_type_old</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="/po_tnx_record/routing_summaries/routing_summary/transport_type"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="routing-summary-individuals-div"/>
			<xsl:call-template name="routing-summary-multimodal-div"/>
		</xsl:with-param>
	</xsl:call-template>
	</xsl:template>
			
	<!--Other Templates-->
	
	<!--TEMPLATE Buyer Bank-->

	<xsl:template name="buyer_bank-tab">
		<xsl:param name="theNodeName"/>
		<xsl:param name="theNodeDescription"/>
		<xsl:param name="theTypeCode"/>
		<xsl:param name="theSubmissionType"/>

	
		<xsl:call-template name="select-field">
			<xsl:with-param name="label">XSL_BANKDETAILS_TYPE_LABEL</xsl:with-param>
			<xsl:with-param name="name">buyer_bank_type_code</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, XSL_BANKDETAILS_TYPE_ISSUING)"/></xsl:with-param>
			<xsl:with-param name="options">
				<option value="01">
					<xsl:if test="contains($theTypeCode,'01')">
						<xsl:attribute name="selected"/>
					</xsl:if>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_ISSUING')"/>
				</option>
				<option value="02">
					<xsl:if test="contains($theTypeCode,'02')">
						<xsl:attribute name="selected"/>
					</xsl:if>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_OTHER')"/>
				</option>
			</xsl:with-param>
		</xsl:call-template>
	
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
			<xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_name</xsl:with-param>
			<xsl:with-param name="button-type">bank</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	    <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_address_line_1</xsl:with-param>
	    <xsl:with-param name="value" select="address_line_1" />
	   </xsl:call-template>
	   <xsl:call-template name="input-field">
	    <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_address_line_2</xsl:with-param>
	    <xsl:with-param name="value" select="address_line_2" />
	   </xsl:call-template>
	   <xsl:call-template name="input-field">
	    <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_dom</xsl:with-param>
	    <xsl:with-param name="value" select="dom" />
	   </xsl:call-template>
		
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_iso_code</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="iso_code"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">submission_type</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="$theSubmissionType"/></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="seller-bank-tab">
		<xsl:param name="theNodeName"/>
		<xsl:param name="theTypeCode"/>


	<xsl:call-template name="select-field">
			<xsl:with-param name="label">XSL_BANKDETAILS_TYPE_LABEL</xsl:with-param>
			<xsl:with-param name="name">seller_bank_type_code</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, XSL_BANKDETAILS_TYPE_ISSUING)"/></xsl:with-param>
			<xsl:with-param name="options">
				<option value="01">
					<xsl:if test="contains($theTypeCode,'01')">
						<xsl:attribute name="selected"/>
					</xsl:if>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_ISSUING')"/>
				</option>
				<option value="*">
					<xsl:if test="contains($theTypeCode,'*')">
						<xsl:attribute name="selected"/>
					</xsl:if>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_OTHER')"/>
				</option>
			</xsl:with-param>
		</xsl:call-template>
	
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
			<xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_name</xsl:with-param>
			<xsl:with-param name="button-type">bank</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	    <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_address_line_1</xsl:with-param>
	    <xsl:with-param name="value" select="address_line_1" />
	   </xsl:call-template>
	   <xsl:call-template name="input-field">
	    <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_address_line_2</xsl:with-param>
	    <xsl:with-param name="value" select="address_line_2" />
	   </xsl:call-template>
	   <xsl:call-template name="input-field">
	    <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_dom</xsl:with-param>
	    <xsl:with-param name="value" select="dom" />
	   </xsl:call-template>
		
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_iso_code</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="iso_code"/></xsl:with-param>
		</xsl:call-template>

	</xsl:template>
	
		<!--
   PO Realform.
   -->
	<xsl:template name="realform">
		<!--
			Do not display this section when the counterparty mode is
			'counterparty'
		-->
		<xsl:if test="$collaborationmode != 'counterparty'">
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
							<xsl:with-param name="value">18</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">attIds</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">TransactionData</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
					</div>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
