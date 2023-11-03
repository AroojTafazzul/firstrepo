<?xml version="1.0" encoding="UTF-8"?>
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
	exclude-result-prefixes="xmlRender localization securitycheck utils security">

	<!--
		Global Parameters. These are used in the imported XSL, and to set
		global params in the JS
	-->
	<xsl:param name="rundata" />
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param>
	<xsl:param name="link_tnx_id"/>
	<!--
		set to none, counterparty or bank, depending on whether we are in a
		collab summary screen
	-->	
	<xsl:param name="product-code">EA</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath" /><xsl:value-of select="$servletPath" />/screen/ExportOpenAccountScreen</xsl:param>

	<!-- if value = 'TEMPLATE', open all dynamic input forms -->
	<xsl:param name="option" />

	<!-- All marks used to shown/hidden form's sections-->
	<xsl:param name="section_po_line_items">
		<xsl:if test="$displaymode = 'view'">
			<xsl:choose>
				<xsl:when test="ea_tnx_record/line_items/lt_tnx_record">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:param>
	<xsl:param name="section_po_amount_details"></xsl:param>
	<xsl:param name="section_po_payment_terms" />
	<xsl:param name="section_po_settlement_terms" />
	<xsl:param name="section_po_documents_required" />
	<xsl:param name="section_po_shipment_details" />
	<xsl:param name="section_po_inco_terms">
		<xsl:if test="$displaymode = 'view'">
			<xsl:choose>
				<xsl:when test="ea_tnx_record/incoterms/incoterm">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:param>
	<xsl:param name="section_po_routing_summary">
		<xsl:if test="$displaymode = 'view'">
			<xsl:choose>
				<xsl:when test="ea_tnx_record/routing_summaries/routing_summary">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:param>
	<xsl:param name="section_po_user_info">
		<xsl:if test="$displaymode = 'view'">
			<xsl:choose>
				<xsl:when test="ea_tnx_record/user_defined_informations/user_defined_information">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:param>
	<xsl:param name="section_po_contact">
		<xsl:if test="$displaymode = 'view'">
			<xsl:choose>
				<xsl:when test="ea_tnx_record/contacts/contact">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:param>

	<xsl:param name="section_line_item_po_reference">N</xsl:param>
	<xsl:param name="section_line_item_adjustments_details" />
	<xsl:param name="section_line_item_taxes_details" />
	<xsl:param name="section_line_item_freight_charges_details" />
	<xsl:param name="section_line_item_shipment_details" />
	<xsl:param name="section_line_item_inco_terms_details" />
	<xsl:param name="section_line_item_total_net_amount_details" />
	

	<!-- <xsl:param name="section_li_product" />
	<xsl:param name="section_li_amount_details" />
	<xsl:param name="section_li_shipment_details" />
	<xsl:param name="section_li_inco_terms" />
	<xsl:param name="section_li_routing_summary" />-->

	<xsl:include href="po_common.xsl" />
	<xsl:include href="../../core/xsl/products/product_addons.xsl" />
	<xsl:include href="../../core/xsl/common/com_cross_references.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />

	<!-- Global Imports. -->
	<xsl:include href="../../core/xsl/common/trade_common.xsl" />

	<xsl:output method="html" version="4.01" indent="no"
		encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/">
		<xsl:apply-templates select="ea_tnx_record" />
	</xsl:template>

	<!--TEMPLATE Main-->

	<xsl:template match="ea_tnx_record">
		<!-- Preloader  -->
		<xsl:call-template name="loading-message" />

		<!-- ***************************** -->
		<!-- Widgets' template declaration -->
		<!-- ***************************** -->
		<!-- Line Items declaration -->
		<xsl:call-template name="line-items-declaration" />
		<!-- Product Identifiers declaration -->
		<xsl:call-template name="product-identifiers-declaration" />
		<!-- Product Categories declaration -->
		<xsl:call-template name="product-categories-declaration" />
		<!-- Product Characteristics declaration -->
		<xsl:call-template name="product-characteristics-declaration" />
		<!-- Adjustments declaration -->
		<xsl:call-template name="adjustments-declaration" />
		<!-- Payments declaration -->
		<xsl:call-template name="payments-declaration" />
		<!-- Taxes declaration -->
		<xsl:call-template name="taxes-declaration" />
		<!-- Freight Charges declaration -->
		<xsl:call-template name="freight-charges-declaration" />
		<!-- Incoterms declaration -->
		<xsl:call-template name="incoterms-declaration" />
		<!-- User defined informations declaration buyer -->
		<xsl:call-template name="user-defined-informations-declaration" >
			<xsl:with-param name="user_info_type">01</xsl:with-param>
		</xsl:call-template>
		<!-- User defined informations declaration seller -->
		<xsl:call-template name="user-defined-informations-declaration" >
			<xsl:with-param name="user_info_type">02</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="contact-details-declaration" />
		
		<xsl:call-template name="commercial-ds-details-declaration" />
		
		<xsl:call-template name="transport-ds-details-declaration" />
		
		<xsl:call-template name="payment-transport-ds-details-declaration" />
		
		<xsl:call-template name="insurance-ds-details-declaration" />
		
		<xsl:call-template name="insurance-bic-declaration" />
		
		<xsl:call-template name="insurance-required-clause-declaration" />
		
		<xsl:call-template name="certificate-ds-details-declaration" />
		
		<xsl:call-template name="certificate-bic-declaration" />
		
		<xsl:call-template name="certificate-line-item-id-declaration" />
		
		<xsl:call-template name="other-certificate-ds-details-declaration" />
		
		<xsl:call-template name="other-certificate-bic-declaration" />
		
		<xsl:call-template name="routing-summary-declaration" />
		
		<xsl:call-template name="bank-payment-obligation-details-declaration" />
		
		<xsl:call-template name="charges-declaration" />
		
		<xsl:call-template name="bpo-payment-terms-declaration" />
			
		<!-- ******************* -->
		<!-- Export Open Account form -->
		<!-- ******************* -->
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>

			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name" />
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">						
					<!--  Display common menu.  -->
					<xsl:call-template name="menu">
						<xsl:with-param name="show-template">N</xsl:with-param>
						<xsl:with-param name="show-return">Y</xsl:with-param>
						<xsl:with-param name="show-save">
						<xsl:choose>
							<xsl:when test="tnx_type_code[.='61' or .='63']">Y</xsl:when>
							<xsl:otherwise>N</xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>

					<!-- Disclaimer Notice -->
					<xsl:call-template name="disclaimer" />

					<xsl:apply-templates select="cross_references"
						mode="hidden_form" />
					<xsl:call-template name="hidden-fields" />
					<xsl:call-template name="general-details" /><!-- 
					<xsl:choose>
					<xsl:when test="prod_stat_code != 'A6'"> -->
					
						<!-- comments for close -->
						<div id = "closeComments" style="display:none">
						    <xsl:call-template name="comments-for-close">
							 	<xsl:with-param name="value"><xsl:value-of select="close_comments"/></xsl:with-param>
							 	<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
						   	</xsl:call-template>
						</div>
						<div id="transactionDetails">
							<!-- Goods details -->
							<xsl:if test="not(tnx_type_code) or tnx_type_code[. != '55']">
								<xsl:call-template name="goods-details" />
							</xsl:if>
							
							<!-- Commercial Document Reference Block -->
							<xsl:if test="prod_stat_code[.='A6']">
		 						<xsl:call-template name="commercial-document-details"/>
		 					</xsl:if>
		 					
							<!-- Amount details -->
							<xsl:if test="$section_po_amount_details!='N'">
								<xsl:call-template name="amount-details" />
							</xsl:if>
							
							<!-- Payment details -->
							<xsl:if test="$section_po_payment_terms!='N'">
								<xsl:call-template name="payment-terms" />
							</xsl:if>
							<xsl:if test="not(tnx_type_code) or tnx_type_code[. != '55']">
								<!--Settlement Terms Details-->
								<xsl:if test="$section_po_settlement_terms!='N'">
									<xsl:call-template name="settlement-terms" />
								</xsl:if>
							</xsl:if>
							
							<!-- Bank details -->
							<xsl:call-template name="bank-details" />
							
							<!-- Bank Payment Obligation Details  -->
							<xsl:if test="prod_stat_code[.='98'] and($displaymode='edit' or ($displaymode='view' and ./bank_payment_obligation/PmtOblgtn))">
								<xsl:call-template name="bank-payment-obligation-ds-details"/>
							</xsl:if>
							<xsl:if test="not(tnx_type_code) or tnx_type_code[. != '55']">
								<!--Documents required Details
								<xsl:if test="$section_po_documents_required!='N'">
									<xsl:call-template name="documents-required" />
								</xsl:if>
								
								Shipment Details-->
								<xsl:if test="$section_po_shipment_details!='N'">
									<xsl:call-template name="shipment-details" />
								</xsl:if>
								
								<!--Inco Terms-->
								<xsl:if test="$section_po_inco_terms!='N'">
									<xsl:call-template name="inco-terms" />
								</xsl:if>
								
								<!--Routing summary Details-->
								<xsl:if test="$section_po_routing_summary!='N'">
									<xsl:call-template name="routing-summary" />
								</xsl:if>
								
								<!--User Details-->
								<xsl:if test="$section_po_user_info!='N'">
									<xsl:call-template name="user-details" />
								</xsl:if>
								
								<!--Contact Details-->
								<xsl:if test="$section_po_contact!='N' and tnx_type_code[.!='03']">
									<xsl:call-template name="contact-details" />
								</xsl:if>
								
								<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./commercial_dataset/ComrclDataSetReqrd)">
									<xsl:if test="prod_stat_code[. !='A6' and . != '54']">
										<xsl:call-template name="commercial-ds-details" />
									</xsl:if>
								</xsl:if>
								
								<xsl:choose>
									<xsl:when test="prod_stat_code[.='A6']">
										<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./payment_transport_dataset/TrnsprtDataSet)">
											<xsl:call-template name="payment-transport-ds-details" />
										</xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./transport_dataset/TrnsprtDataSetReqrd)">
											<xsl:call-template name="transport-ds-details" />
										</xsl:if>
									</xsl:otherwise>
								</xsl:choose>
				
								<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./insurance_dataset/InsrncDataSetReqrd)">
								<xsl:call-template name="insurance-ds-details" />
								</xsl:if>
								
								<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./certificate_dataset/CertDataSetReqrd)">
								<xsl:call-template name="certificate-ds-details" />
								</xsl:if>
								
								<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./other_certificate_dataset/OthrCertDataSetReqrd)">
								<xsl:call-template name="other-certificate-ds-details" />
								</xsl:if>
							</xsl:if>
							<xsl:if test="prod_stat_code[.='54'] and ($displaymode='edit' or ($displaymode='view' and ./free_format_text/text != ''))">
								<xsl:call-template name="bank-instructions" />
							</xsl:if>
							<xsl:if test="tnx_type_code[.='03']">
							<xsl:call-template name="amend-narrative"/>
							</xsl:if> 
						</div>
						<!-- comments for return -->
						<xsl:call-template name="comments-for-return">
						 	<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
						 	<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
					   	</xsl:call-template><!-- 
				   	</xsl:when>
				   	<xsl:otherwise>
				   		<xsl:call-template name="commercial-goods-details" />
				   		<xsl:call-template name="baseline-amount-details" />
				   		<xsl:call-template name="baseline-payment-details" />
				   		<xsl:call-template name="baseline-settlement-terms-details">
				   			<xsl:with-param name="node" select="forward_dataset_submission/FwdDataSetSubmissnRpt/ComrclDataSet/SttlmTerms" />
				   		</xsl:call-template>
				   		<xsl:call-template name="bpo-insurance-dataset-deatils">
				   			<xsl:with-param name="node" select="forward_dataset_submission/FwdDataSetSubmissnRpt/InsrncDataSet" />
				   		</xsl:call-template>
				   		<xsl:call-template name="bpo-certificate-dataset-deatils">
				   			<xsl:with-param name="node" select="forward_dataset_submission/FwdDataSetSubmissnRpt/CertDataSet" />
				   		</xsl:call-template>
				   		<xsl:call-template name="bpo-other-certificate-dataset-deatils">
				   			<xsl:with-param name="node" select="forward_dataset_submission/FwdDataSetSubmissnRpt/OthrCertDataSet" />
				   		</xsl:call-template>
				   		<xsl:call-template name="dataset-mismatch-info">
				   			<xsl:with-param name="items" select="dataset_match_report/DataSetMtchRpt/Rpt/MisMtchInf" />
				   		</xsl:call-template>
				   	</xsl:otherwise>
				   	</xsl:choose> -->
				</xsl:with-param>										
			</xsl:call-template>						
		</div>
		
		<!-- Form #1 : Attach Files -->
		<xsl:choose>
			<xsl:when test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
				<xsl:call-template name="attachments-file-dojo">
					<xsl:with-param name="attachment-group">purchaseorder</xsl:with-param>
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
	          	<xsl:call-template name="attachments-file-dojo">
		          	<xsl:with-param name="existing-attachments" select="attachments/attachment[type = '07']"/>
		          	<xsl:with-param name="legend">XSL_HEADER_AUTO_GENERATED_FILES</xsl:with-param>
		          	<xsl:with-param name="attachment-group">optional</xsl:with-param>
	          	</xsl:call-template>
	          	</xsl:if>
			</xsl:otherwise>
		</xsl:choose>

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
			<xsl:with-param name="show-return">Y</xsl:with-param>
			<xsl:with-param name="show-save">
			<xsl:choose>
				<xsl:when test="tnx_type_code[.='61' or .='63']">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="show-template">N</xsl:with-param>
		</xsl:call-template>
		
		<!-- The form that's submitted -->
		<xsl:call-template name="realform" />
		<!-- Reauthentication -->
      <xsl:call-template name="reauthentication"/>

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
			<xsl:with-param name="binding">misys.binding.openaccount.create_ea</xsl:with-param>
			<xsl:with-param name="show-period-js">Y</xsl:with-param>
			<xsl:with-param name="override-help-access-key">PO_01</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Additional hidden fields for this form are  -->
	<!-- added here. -->
	<xsl:template name="hidden-fields">
		<xsl:call-template name="common-hidden-fields" />
		<div class="widgetContainer">
			<xsl:if test="$displaymode='view'">
				<!-- This field is sent in the unsigned view -->
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:value-of select="issuing_bank/abbv_name" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">product_code</xsl:with-param>				
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">buyer_bank_bpo_added</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">obligor_bank_hidden</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">original_total_amt</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="original_amt"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">original_total_net_amt</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="original_net_amt"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">action_req_code</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="action_req_code"/></xsl:with-param>
			</xsl:call-template>
		</div>
	</xsl:template>

	<!-- General Details Fieldset. -->
	<xsl:template name="general-details">
	 <xsl:variable name="changeoption"><xsl:value-of select="utils:getActionRequiredOption(product_code,'*',tnx_type_code,prod_stat_code)"/></xsl:variable>
		<xsl:variable name="lookup-type">
			<xsl:if test="tnx_type_code[.='31']">crossref-full</xsl:if>
			<xsl:if test="prod_stat_code[.='43'] or tnx_type_code[.='03']">
     			<xsl:if test="$changeoption='FULL'">crossref-full</xsl:if>
     			<xsl:if test="$changeoption='SUMMARY'">crossref-summary</xsl:if>
			</xsl:if>
		</xsl:variable>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="button-type"><xsl:value-of select="$lookup-type"/></xsl:with-param>
			<xsl:with-param name="content">
				<xsl:variable name="show-template-id">N</xsl:variable>
				<xsl:variable name="show-cust-ref-id">Y</xsl:variable>
				<xsl:variable name="show-bo-ref-id">Y</xsl:variable>
				<xsl:variable name="override-cust-ref-id-label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:variable>
				<!-- Hidden fields. -->
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">ref_id</xsl:with-param>
				</xsl:call-template>
				<!-- Don't display this in unsigned mode. -->
				<xsl:if test="$displaymode='edit'">
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">appl_date</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<!--  System ID. -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
					<xsl:with-param name="id">general_ref_id_view</xsl:with-param>
					<xsl:with-param name="value" select="ref_id" />
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>

				<!-- Bank Reference -->
				<!-- Shown in consolidated view -->
				<xsl:if test="$show-bo-ref-id='Y' and $displaymode='view' and (not(tnx_id) or tnx_type_code[.!='01'])">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
						<xsl:with-param name="value" select="bo_ref_id" />
					</xsl:call-template>
				</xsl:if>
				<!-- Cross Refs -->
				<!-- Shown in consolidated view  -->
				<xsl:if test="cross_references and (cross_references/cross_reference/product_code != cross_references/cross_reference/child_product_code)">
					<xsl:apply-templates select="cross_references" mode="display_table_tnx"/>
				</xsl:if>
				<!-- Template ID. -->
				<xsl:if test="$show-template-id='Y'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_ID</xsl:with-param>
						<xsl:with-param name="name">template_id</xsl:with-param>
						<xsl:with-param name="size">15</xsl:with-param>
						<xsl:with-param name="maxsize">20</xsl:with-param>
						<xsl:with-param name="fieldsize">small</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<!-- Customer reference -->
				<xsl:if test="$show-cust-ref-id='Y'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label"><xsl:value-of select="$override-cust-ref-id-label"/></xsl:with-param>
						<xsl:with-param name="name">cust_ref_id</xsl:with-param>
						<xsl:with-param name="size">20</xsl:with-param>
						<xsl:with-param name="maxsize">16</xsl:with-param>
						<xsl:with-param name="required">N</xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<!-- Display the PO Reference in readonly mode, for initiate IO from PO. 
				For other cases, it is an editable field. -->
				<xsl:choose>
					<xsl:when test="cross_references and cross_references[.!= '']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_GENERALDETAILS_PO_REF_ID</xsl:with-param>
							<xsl:with-param name="value" select="po_ref_id" />
							<!-- <xsl:with-param name="override-displaymode">view</xsl:with-param> -->
							<xsl:with-param name="readonly">Y</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
					       <xsl:with-param name="name">po_ref_id</xsl:with-param>
					       <xsl:with-param name="value" select="po_ref_id"/>
					    </xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_GENERALDETAILS_PO_REF_ID</xsl:with-param>
							<xsl:with-param name="name">po_ref_id</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="required">N</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>				
				</xsl:choose>
			
				<!--  Application date. -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
					<xsl:with-param name="id">appl_date_view</xsl:with-param>
					<xsl:with-param name="value" select="appl_date" />
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="po-general-details" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Goods Details Fieldset.-->
	<xsl:template name="goods-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_DESCRIPTION_GOODS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:if test="$displaymode='edit'">
					<xsl:call-template name="textarea-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_GOODS_DESC</xsl:with-param>
						<xsl:with-param name="name">goods_desc</xsl:with-param>
						<xsl:with-param name="maxlines">2</xsl:with-param>
						<xsl:with-param name="cols">35</xsl:with-param>
						<xsl:with-param name="rows">5</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$displaymode='view' and goods_desc[.!='']">
				      <xsl:call-template name="big-textarea-wrapper">
				      <xsl:with-param name="label">XSL_PURCHASE_ORDER_GOODS_DESC</xsl:with-param>
				      <xsl:with-param name="content"><div class="content">
				        <xsl:value-of select="goods_desc"/>
				      </div></xsl:with-param>
				     </xsl:call-template>
			    </xsl:if>
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_EXPORT_OPEN_ACCOUNT_CURRENCY_CODE</xsl:with-param>
					<xsl:with-param name="product-code">total</xsl:with-param>
					<xsl:with-param name="override-currency-name">total_cur_code</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="show-amt">N</xsl:with-param>
					<xsl:with-param name="currency-readonly">
						<xsl:choose>
							<xsl:when test="tnx_type_code[.='03']">Y</xsl:when>
							<xsl:otherwise>N</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="show-button">
						<xsl:choose>
							<xsl:when test="tnx_type_code[.='03']">N</xsl:when>
							<xsl:otherwise>Y</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				&nbsp;
				<xsl:if test="$section_po_line_items!='N'">	
					<!-- Buyer Details -->
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_HEADER_LINE_ITEMS</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
							&nbsp;
							<!-- Line items grid -->
							<xsl:call-template name="build-line-items-dojo-items">
								<xsl:with-param name="items" select="line_items/lt_tnx_record" />
							</xsl:call-template>
							&nbsp;
							<!-- Total Goods Amount -->
							<xsl:choose>
								<xsl:when test="$option = 'FULL' or $option = 'DETAILS' or $displaymode='view'">
									<br/>
									<xsl:call-template name="input-field">
										<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL</xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select="total_cur_code"/>&nbsp;<xsl:value-of select="total_amt"/></xsl:with-param>
										<xsl:with-param name="name">fake_total_amt</xsl:with-param>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="currency-field">
										<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL</xsl:with-param>
										<xsl:with-param name="product-code">total</xsl:with-param>
										<xsl:with-param name="override-currency-name">fake_total_cur_code</xsl:with-param>
										<xsl:with-param name="override-amt-name">fake_total_amt</xsl:with-param>
										<xsl:with-param name="currency-readonly">Y</xsl:with-param>
										<xsl:with-param name="amt-readonly">Y</xsl:with-param>
										<xsl:with-param name="show-button">N</xsl:with-param>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<!--  Payment Details Fieldset. -->
	<xsl:template name="payment-terms">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PAYMENT_TERMS_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			<xsl:if test="not(tnx_type_code) or tnx_type_code[.='61' or .='55' or .='63']">
			&nbsp;
				<xsl:if test="$displaymode='edit'">
					<xsl:choose>
						<xsl:when test="tnx_type_code[.='63']">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PAYMENT_DUE_DATE</xsl:with-param>
								<xsl:with-param name="id">pymnt_due_date</xsl:with-param>
								<xsl:with-param name="value" select="pymnt_due_date" />
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_EXPECTED_PAYMENT_DATE</xsl:with-param>
								<xsl:with-param name="id">expected_payment_date</xsl:with-param>
								<xsl:with-param name="value" select="expected_payment_date" />
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="hidden-field">
					       <xsl:with-param name="name">expected_payment_date</xsl:with-param>
					       <xsl:with-param name="value" select="expected_payment_date"/>
					     </xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PAYMENT_DUE_DATE</xsl:with-param>
								<xsl:with-param name="name">pymnt_due_date</xsl:with-param>
								<xsl:with-param name="type">date</xsl:with-param>
								<xsl:with-param name="required">N</xsl:with-param>
								<xsl:with-param name="readonly">N</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				
			<xsl:if test="$displaymode='view'">
			<xsl:choose>
			<xsl:when test="tnx_type_code[.='63']">
				<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_PAYMENT_DUE_DATE</xsl:with-param>
						<xsl:with-param name="name">pymnt_due_date</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="pymnt_due_date"/></xsl:with-param>
				</xsl:call-template>
				<xsl:if test="expected_payment_date[. != '']">
					<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_EXPECTED_PAYMENT_DATE</xsl:with-param>
							<xsl:with-param name="name">expected_payment_date</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="expected_payment_date"/></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:when>
			 <xsl:when test="tnx_type_code[.='55']">
				<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_EXPECTED_PAYMENT_DATE</xsl:with-param>
						<xsl:with-param name="name">expected_payment_date</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="expected_payment_date"/></xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_PAYMENT_DUE_DATE</xsl:with-param>
						<xsl:with-param name="name">pymnt_due_date</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="pymnt_due_date"/></xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			</xsl:if>	
			&nbsp;
			<xsl:if test="not(tnx_type_code) or tnx_type_code[. != '55']">
				<xsl:call-template name="multioption-group">
			        <xsl:with-param name="group-label">XSL_DETAILS_PO_PAYMENT_TYPE</xsl:with-param>
			        <xsl:with-param name="content">
						<!-- events : onclick  -->
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_HEADER_PO_PAYMENT_AMOUNT</xsl:with-param>
							<xsl:with-param name="name">payment_terms_type</xsl:with-param>
							<xsl:with-param name="id">payment_terms_type_1</xsl:with-param>
							<xsl:with-param name="value">AMNT</xsl:with-param>
							<xsl:with-param name="checked">
							<xsl:choose>
								<xsl:when test="payments/payment/amt[.!='']">Y</xsl:when>
								<xsl:otherwise>N</xsl:otherwise>
							</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="radio-value"><xsl:value-of select="payment_terms_type"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_HEADER_PO_PAYMENT_PCT</xsl:with-param>
							<xsl:with-param name="name">payment_terms_type</xsl:with-param>
							<xsl:with-param name="id">payment_terms_type_2</xsl:with-param>
							<xsl:with-param name="value">PRCT</xsl:with-param>
							<xsl:with-param name="checked">
							<xsl:choose>
								<xsl:when test="payments/payment/pct[.!='']">Y</xsl:when>
								<xsl:otherwise>N</xsl:otherwise>
							</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="radio-value"><xsl:value-of select="payment_terms_type"/></xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			
				<!-- 
				<div style="display:none;">
					<xsl:attribute name="id">po_payment_template</xsl:attribute>
					<xsl:call-template name="PAYMENT_DETAILS">
						<xsl:with-param name="structure_name">po_payment</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_payments</xsl:with-param>
					</xsl:call-template>
				</div>

				<xsl:call-template name="payments">
					<xsl:with-param name="structure_name">po_payment</xsl:with-param>
					<xsl:with-param name="form_name">form_payments</xsl:with-param>
					<xsl:with-param name="currency">total_cur_code</xsl:with-param>
					<xsl:with-param name="currency_form_name">form_goods</xsl:with-param>
				</xsl:call-template>
				-->
					<xsl:call-template name="payments-new">
						<xsl:with-param name="items" select="payments/payment" />
						<xsl:with-param name="id">po-payments</xsl:with-param>
					</xsl:call-template>
				</xsl:if>	
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
							<xsl:with-param name="value">
							 <xsl:choose>
						          <xsl:when test="seller_account_iban[.!='']">IBAN</xsl:when>
						          <xsl:when test="seller_account_bban[.!='']">BBAN</xsl:when>
						          <xsl:when test="seller_account_upic[.!='']">UPIC</xsl:when>
						          <xsl:when test="seller_account_id[.!='']">OTHER</xsl:when>
						          <xsl:otherwise></xsl:otherwise>
						     </xsl:choose>
						     </xsl:with-param>
							<!-- events : onChange -->
							<xsl:with-param name="options">
							<xsl:choose>
        						<xsl:when test="$displaymode='edit'">
								<option value=""></option>
								<option value="IBAN">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN')" />
								</option>
								<option value="BBAN">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_BBAN')" />
								</option>
								<option value="UPIC">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_UPIC')" />
								</option>
								<option value="OTHER">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_OTHER')" />
								</option>
								 </xsl:when>
						        <xsl:otherwise>
						         <xsl:choose>
						          <xsl:when test="seller_account_type[. = '']"></xsl:when>
						          <xsl:when test="seller_account_iban[.!='']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN')" /></xsl:when>
						          <xsl:when test="seller_account_bban[.!='']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_BBAN')" /></xsl:when>
						          <xsl:when test="seller_account_upic[.!='']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_UPIC')" /></xsl:when>
						          <xsl:when test="seller_account_id[.!='']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_OTHER')" /></xsl:when>
						         </xsl:choose>
						        </xsl:otherwise>
						       </xsl:choose>
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
					<xsl:with-param name="button-type">fin_inst</xsl:with-param>
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

						 <xsl:call-template name="country-field">
							    <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY</xsl:with-param>
							    <xsl:with-param name="name">fin_inst_country</xsl:with-param>
							    <xsl:with-param name="value"><xsl:value-of select="fin_inst_country" /></xsl:with-param>
							    <xsl:with-param name="prefix" >fin_inst</xsl:with-param>
						   </xsl:call-template>

					</xsl:with-param>
				</xsl:call-template>

			</xsl:with-param>
		</xsl:call-template>							
	</xsl:template>

	<!--  Bank Details Fieldset. -->
	<xsl:template name="bank-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_SELLER_BANK_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="issuing-bank-tabcontent">
					<xsl:with-param name="sender-name">seller</xsl:with-param>
					<xsl:with-param name="sender-reference-name">seller_reference</xsl:with-param>
   				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
<xsl:template name="bank-instructions">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_INSTRUCTIONS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="big-textarea-wrapper">
     <xsl:with-param name="id">free_format_text</xsl:with-param>
     <xsl:with-param name="label">XSL_INSTRUCTIONS_OTHER_INFORMATION</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="textarea-field">
       <xsl:with-param name="name">free_format_text</xsl:with-param>
       <xsl:with-param name="swift-validate">N</xsl:with-param>
       <xsl:with-param name="rows">8</xsl:with-param>
       <xsl:with-param name="cols">65</xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template> 
 </xsl:template>
	
	<!--  Documents required Fieldset. -->
	<xsl:template name="documents-required">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED</xsl:with-param>
			<xsl:with-param name="content">
			
		       <xsl:call-template name="multioption-group">
		        <xsl:with-param name="group-label">XSL_PURCHASE_ORDER_COMMERCIAL_DATASET</xsl:with-param>
		        <xsl:with-param name="content">
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_COMMERCIAL_DATASET_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">reqrd_commercial_dataset</xsl:with-param>
						<xsl:with-param name="id">reqrd_commercial_dataset_1</xsl:with-param>
						<xsl:with-param name="value">Y</xsl:with-param>
						<xsl:with-param name="radio-value"><xsl:value-of select="reqrd_commercial_dataset" /></xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="reqrd_commercial_dataset[. = 'Y' or . = '']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_COMMERCIAL_DATASET_NOT_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">reqrd_commercial_dataset</xsl:with-param>
						<xsl:with-param name="id">reqrd_commercial_dataset_2</xsl:with-param>
						<xsl:with-param name="value">N</xsl:with-param>
						<xsl:with-param name="radio-value"><xsl:value-of select="reqrd_commercial_dataset" /></xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="reqrd_commercial_dataset[. = 'N']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
	     	  </xsl:call-template>
	       	  <xsl:call-template name="multioption-group">
	       	  	 <xsl:with-param name="group-label">XSL_PURCHASE_ORDER_TRANSPORT_DATASET</xsl:with-param>
	       		 <xsl:with-param name="content">
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_TRANSPORT_DATASET_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">reqrd_transport_dataset</xsl:with-param>
						<xsl:with-param name="id">reqrd_transport_dataset_1</xsl:with-param>
						<xsl:with-param name="value">Y</xsl:with-param>
						<xsl:with-param name="radio-value"><xsl:value-of select="reqrd_transport_dataset" /></xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="reqrd_transport_dataset[. = 'Y']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_TRANSPORT_DATASET_NOT_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">reqrd_transport_dataset</xsl:with-param>
						<xsl:with-param name="id">reqrd_transport_dataset_2</xsl:with-param>
						<xsl:with-param name="value">N</xsl:with-param>
						<xsl:with-param name="radio-value"><xsl:value-of select="reqrd_transport_dataset" /></xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="reqrd_transport_dataset[. = 'N' or . = '']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
	     	  </xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_PURCHASE_ORDER_LAST_MATCH_DATE</xsl:with-param>
					<xsl:with-param name="name">last_match_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<!-- events : onblur -->
					<xsl:with-param name="value">
						<xsl:value-of select="last_match_date" />
					</xsl:with-param>
					<xsl:with-param name="size">10</xsl:with-param>
					<xsl:with-param name="maxsize">10</xsl:with-param>
				</xsl:call-template>
				
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!--  Shipment details Fieldset. -->
	<xsl:template name="shipment-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			
			   <!-- Lastest Shipment Date, Partial and Trans Shipments-->
			   <xsl:call-template name="multioption-group">
			        <xsl:with-param name="group-label">XSL_SHIPMENTDETAILS_PART_SHIP_LABEL</xsl:with-param>
			        <xsl:with-param name="content">
				        <xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED</xsl:with-param>
							<xsl:with-param name="name">part_ship</xsl:with-param>
							<xsl:with-param name="id">part_ship_1</xsl:with-param>
							<xsl:with-param name="value">Y</xsl:with-param>
							<xsl:with-param name="radio-value"><xsl:value-of select="part_ship" /></xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="part_ship[. = 'Y' or . = '']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED</xsl:with-param>
							<xsl:with-param name="name">part_ship</xsl:with-param>
							<xsl:with-param name="id">part_ship_2</xsl:with-param>
							<xsl:with-param name="value">N</xsl:with-param>
							<xsl:with-param name="radio-value"><xsl:value-of select="part_ship" /></xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="part_ship[. = 'N']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
			        </xsl:with-param>
			    </xsl:call-template>
			    <xsl:call-template name="multioption-group">
			        <xsl:with-param name="group-label">XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL</xsl:with-param>
			        <xsl:with-param name="content">
			        	<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED</xsl:with-param>
							<xsl:with-param name="name">tran_ship</xsl:with-param>
							<xsl:with-param name="id">tran_ship_1</xsl:with-param>
							<xsl:with-param name="value">Y</xsl:with-param>
							<xsl:with-param name="radio-value"><xsl:value-of select="tran_ship" /></xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="tran_ship[. = 'Y' or . = '']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED</xsl:with-param>
							<xsl:with-param name="name">tran_ship</xsl:with-param>
							<xsl:with-param name="id">tran_ship_2</xsl:with-param>
							<xsl:with-param name="value">N</xsl:with-param>
							<xsl:with-param name="radio-value"><xsl:value-of select="tran_ship" /></xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="tran_ship[. = 'N']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
			        </xsl:with-param>
			   </xsl:call-template>
				
			  <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SHIPMENTDETAILS_LAST_SHIP_DATE</xsl:with-param>
					<!-- events : onblur, onfocus -->
					<xsl:with-param name="name">last_ship_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:value-of select="last_ship_date" />
					</xsl:with-param>
					<xsl:with-param name="size">10</xsl:with-param>
					<xsl:with-param name="maxsize">10</xsl:with-param>
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
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">
								<option value="0">&nbsp;</option>
								<option value="01">
									<xsl:if	test="count(./routing_summaries/routing_summary/transport_type[. = '01']) != 0">
										<xsl:attribute name="selected" />
									</xsl:if>
									<xsl:value-of select="localization:getDecode($language, 'N213', '01')" />
								</option>
								<option value="02">
									<xsl:if test="count(./routing_summaries/routing_summary/transport_type[. = '02']) != 0">
										<xsl:attribute name="selected" />
									</xsl:if>
									<xsl:value-of select="localization:getDecode($language, 'N213', '02')" />
								</option>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="transport_type[. = '0' or . = '' ]"></xsl:when>
									<xsl:when test="transport_type[. = '01']"><xsl:value-of select="localization:getDecode($language, 'N213', '01')" /></xsl:when>
									<xsl:when test="transport_type[. = '02']"><xsl:value-of select="localization:getDecode($language, 'N213', '02')" /></xsl:when>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>   
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">transport_type_old</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="./routing_summaries/routing_summary/transport_type"/></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="routing-summary-individuals-div">
					<xsl:with-param name="isWidgetContainer">N</xsl:with-param>
					<xsl:with-param name="hidden">
						<xsl:choose>
							<xsl:when test="count(./routing_summaries/routing_summary/transport_type[. = '01']) != 0">N</xsl:when>
							<xsl:otherwise>Y</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="routing-summary-multimodal-div">
					<xsl:with-param name="isWidgetContainer">N</xsl:with-param>
					<xsl:with-param name="hidden">
						<xsl:choose>
							<xsl:when test="count(./routing_summaries/routing_summary/transport_type[. = '02']) != 0">N</xsl:when>
							<xsl:otherwise>Y</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- User Details Fieldset. -->
	<xsl:template name="user-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_USER_INFORMATION_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_PURCHASE_ORDER_BUYER_INFORMATIONS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">&nbsp;
						<xsl:call-template name="user_defined_informations_buyer">
							<xsl:with-param name="items" select="user_defined_informations/user_defined_information[type=01]" />
							<xsl:with-param name="id" select="po-buyer-user-informations" />
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_PURCHASE_ORDER_SELLER_INFORMATIONS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">&nbsp;
						<xsl:call-template name="user_defined_informations_seller">
							<xsl:with-param name="items" select="user_defined_informations/user_defined_information[type=02]" />
							<xsl:with-param name="id" select="po-seller-user-informations" />
						</xsl:call-template>
					
					</xsl:with-param>
				</xsl:call-template>
				
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Contact Person Details Fieldset. -->
	<xsl:template name="contact-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_CONTACT_PERSON_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-contact-details-dojo-items">
					<xsl:with-param name="items" select="contacts/contact" />
					<xsl:with-param name="id" select="po-contacts" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>		


	<xsl:template name="commercial-ds-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_PURCHASE_ORDER_COMMERCIAL_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-commercial-ds-details-dojo-items">
					<xsl:with-param name="items" select="commercial_dataset/ComrclDataSetReqrd/Submitr" />
					<xsl:with-param name="id" select="commercial-ds" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="transport-ds-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_PURCHASE_ORDER_TRANSPORT_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-transport-ds-details-dojo-items">
					<xsl:with-param name="items" select="transport_dataset/TrnsprtDataSetReqrd/Submitr" />
					<xsl:with-param name="id" select="transport-ds" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="payment-transport-ds-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_PURCHASE_ORDER_TRANSPORT_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-payment-transport-ds-details-dojo-items">
					<xsl:with-param name="items" select="payment_transport_dataset/TrnsprtDataSet/Submitr" />
					<xsl:with-param name="id" select="payment-transport-ds" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>		
	
	<xsl:template name="insurance-ds-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_PURCHASE_ORDER_INSURANCE_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-insurance-ds-details-dojo-items">
					<xsl:with-param name="items" select="insurance_dataset/InsrncDataSetReqrd" />
					<xsl:with-param name="id" select="insurance-ds" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>		
	
	<xsl:template name="certificate-ds-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_PURCHASE_ORDER_CERTIFICATE_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-certificate-ds-details-dojo-items">
					<xsl:with-param name="items" select="certificate_dataset/CertDataSetReqrd" />
					<xsl:with-param name="id" select="certificate-ds" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="other-certificate-ds-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_PURCHASE_ORDER_OTHER_CERTIFICATE_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-other-certificate-ds-details-dojo-items">
					<xsl:with-param name="items" select="other_certificate_dataset/OthrCertDataSetReqrd" />
					<xsl:with-param name="id" select="other-certificate-ds" />
				</xsl:call-template>

			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	
	
	<xsl:template name="bank-payment-obligation-ds-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_PURCHASE_ORDER_BPO_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				&nbsp;
				<xsl:call-template name="build-bank-payment-obligation-details-dojo-items">
					<xsl:with-param name="items" select="bank_payment_obligation/PmtOblgtn" />
					<xsl:with-param name="id" select="bank-payment-obligation-ds" />
				</xsl:call-template>
				
			</xsl:with-param>
		</xsl:call-template>

	</xsl:template>
	
	
	<!-- Amount Details Fieldset. -->
	<xsl:template name="amount-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				&nbsp;
				<!-- show amout details only for new payment initiation and for  Intent to Pay -->
				<xsl:if test="not(tnx_type_code) or tnx_type_code[.='61' or .='55' or .='59']">
					<xsl:call-template name="baseline-amount-details" />
				</xsl:if>
				<!-- Adjustments -->
				<xsl:if test="not(tnx_type_code) or tnx_type_code[. != '55']">
					<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./adjustments/adjustment)">
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_HEADER_ADJUSTMENTS_DETAILS</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
							&nbsp;
							<xsl:call-template name="build-adjustments-dojo-items">
								<xsl:with-param name="items" select="adjustments/adjustment" />
								<xsl:with-param name="id">po-adjustments</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
	
					<!-- Taxes -->
					<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./taxes/tax)">
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_HEADER_TAXES_DETAILS</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
							&nbsp;
							<xsl:call-template name="build-taxes-dojo-items">
								<xsl:with-param name="items" select="taxes/tax" />
								<xsl:with-param name="id">po-taxes</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					
					<!-- Freight charges -->
					<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./freightCharges/freightCharge)">
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_HEADER_FREIGHT_CHARGES_DETAILS</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
							<!-- Price unit measure code -->
							<xsl:call-template name="select-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_FREIGHT_CHARGES_TYPE</xsl:with-param>
								<xsl:with-param name="name">freight_charges_type</xsl:with-param>
								<xsl:with-param name="options">
								 <xsl:choose>
	        						<xsl:when test="$displaymode='edit'">
		        						<option value="">&nbsp;</option>
										<option value="CLCT">
											<xsl:value-of
												select="localization:getDecode($language, 'N211', 'CLCT')" />
											<xsl:if test="freight_charges_type[. = 'CLCT']">
												<xsl:attribute name="selected" />
											</xsl:if>
										</option>
										<option value="PRPD">
											<xsl:value-of
												select="localization:getDecode($language, 'N211', 'PRPD')" />
											<xsl:if test="freight_charges_type[. = 'PRPD']">
												<xsl:attribute name="selected" />
											</xsl:if>
										</option>
									</xsl:when>
							        <xsl:otherwise>
								        <xsl:choose>
									        <xsl:when test="freight_charges_type[. = 'CLCT']"><xsl:value-of select="localization:getDecode($language, 'N211', 'CLCT')" /></xsl:when>
									        <xsl:when test="freight_charges_type[. = 'PRPD']"><xsl:value-of select="localization:getDecode($language, 'N211', 'PRPD')" /></xsl:when>
								        </xsl:choose>
							        </xsl:otherwise>
							       </xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
							&nbsp;
							<xsl:call-template name="build-freight-charges-dojo-items">
								<xsl:with-param name="items"
									select="freightCharges/freightCharge" />
								<xsl:with-param name="id">po-freight-charges</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!-- Line Item Net Amount -->
					&nbsp;
					<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_NET_AMT_LABEL</xsl:with-param>
						<xsl:with-param name="override-currency-name">total_net_cur_code</xsl:with-param>
						<xsl:with-param name="override-amt-name">total_net_amt</xsl:with-param>
						<xsl:with-param name="amt-readonly">Y</xsl:with-param>
						<xsl:with-param name="currency-readonly">Y</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				&nbsp;
				
				<xsl:if test="prod_stat_code[.='54']">
					<xsl:if test="intent_to_pay_amt[. != '']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_INTENT_TO_PAY_AMOUNT</xsl:with-param>
							<xsl:with-param name="id">intent_to_pay_amt</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="intent_to_pay_amt"></xsl:value-of>
							</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
					       <xsl:with-param name="name">intent_to_pay_amt</xsl:with-param>
					       <xsl:with-param name="value" select="intent_to_pay_amt"/>
					     </xsl:call-template>
					</xsl:if>
					<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_FINANCE_AMOUNT</xsl:with-param>
						<xsl:with-param name="override-currency-name">finance_cur_code</xsl:with-param>
						<xsl:with-param name="override-amt-name">finance_amt</xsl:with-param>
						<xsl:with-param name="amt-readonly">N</xsl:with-param>
						<xsl:with-param name="currency-readonly">Y</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="show-button">N</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_REQUESTING_FINANCE_CUR_CODE</xsl:with-param>
					<xsl:with-param name="product-code">request_finance</xsl:with-param>
					<xsl:with-param name="override-currency-name">request_finance_cur_code</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="currency-readonly">N</xsl:with-param>
					<xsl:with-param name="show-amt">N</xsl:with-param>
					<xsl:with-param name="show-button">Y</xsl:with-param>
				</xsl:call-template>				
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Commercial Document Reference Block -->
	<xsl:template name="commercial-document-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_COMMERCIAL_DOCUMENT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				&nbsp;
				<xsl:if test="$displaymode='edit'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_INVOICE_NUMBER</xsl:with-param>
						<xsl:with-param name="name">invoice_number</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_COMMERCIAL_DOCUMENT_ISSUE_DATE</xsl:with-param>
						<xsl:with-param name="name">invoice_iss_date</xsl:with-param>
						<xsl:with-param name="type">date</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$displaymode='view'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_INVOICE_NUMBER</xsl:with-param>
						<xsl:with-param name="name">invoice_number</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select ="invoice_number"/></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_COMMERCIAL_DOCUMENT_ISSUE_DATE</xsl:with-param>
						<xsl:with-param name="name">invoice_iss_date</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select ="invoice_iss_date"/></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		
	</xsl:template>
	
	<!--
		General Details Fieldset. Issue Date, Template Validation, Buyer
		Details, Seller Details.
	-->
	<xsl:template name="po-general-details">
		<xsl:if test="$displaymode='edit'">
			<div>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
					<xsl:with-param name="name">iss_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="readonly">N</xsl:with-param>
				</xsl:call-template>
			</div>
			
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
				<xsl:with-param name="name">exp_date</xsl:with-param>
				<xsl:with-param name="type">date</xsl:with-param>
				<xsl:with-param name="readonly">N</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:with-param>
      			<xsl:with-param name="name">expiry_place</xsl:with-param>
      			<xsl:with-param name="maxsize">35</xsl:with-param>
      			<xsl:with-param name="readonly">N</xsl:with-param>
     		</xsl:call-template>
		</xsl:if>
		<!-- <xsl:choose>
		<xsl:when test="prod_stat_code ='43' or tnx_type_code ='03'">
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">provisional_status</xsl:with-param>
				<xsl:with-param name="value"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="securitycheck:hasCompanyPermission($rundata,'provisional_enable') and prod_stat_code ='98'">
			     <xsl:call-template name="checkbox-field">
				     <xsl:with-param name="label">XSL_PROVISIONAL</xsl:with-param>
				     <xsl:with-param name="name">provisional_status</xsl:with-param>
				     <xsl:with-param name="disabled">Y</xsl:with-param>
				     <xsl:with-param name="checked">Y</xsl:with-param>
				 </xsl:call-template>
			</xsl:if>
			</xsl:otherwise>
			</xsl:choose>-->
		<xsl:if test="prod_stat_code ='98'">
			<xsl:call-template name="checkbox-field">
				     <xsl:with-param name="label">XSL_PROVISIONAL</xsl:with-param>
				     <xsl:with-param name="name">provisional_status</xsl:with-param>
				     <xsl:with-param name="disabled">Y</xsl:with-param>
				     <xsl:with-param name="checked">Y</xsl:with-param>
	 		</xsl:call-template>
			<xsl:call-template name="checkbox-field">
		     	<xsl:with-param name="label">XSL_TMA_USED</xsl:with-param>
		     	<xsl:with-param name="name">tma_used_status</xsl:with-param>
		     	<xsl:with-param name="disabled">Y</xsl:with-param>
		     	<xsl:with-param name="checked">Y</xsl:with-param>
			</xsl:call-template> 
	
			<xsl:call-template name="checkbox-field">
				   <xsl:with-param name="label">XSL_BPO_USED</xsl:with-param>
				   <xsl:with-param name="name">bpo_used_status</xsl:with-param>
				   <xsl:with-param name="value"><xsl:value-of select="bpo_used_status"/></xsl:with-param>
				   <xsl:with-param name="disabled">Y</xsl:with-param>
				   <xsl:with-param name="checked">
					   	<xsl:choose>
					   		<xsl:when test="bank_payment_obligation/PmtOblgtn/OblgrBk/BIC != '' and bank_payment_obligation/PmtOblgtn/RcptBk/BIC != ''">Y</xsl:when>
					   		<xsl:otherwise>N</xsl:otherwise>
					   	</xsl:choose>
				   	</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		
		<xsl:if test="tnx_type_code [.='03']">
		<xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_LABEL_TMA_REF</xsl:with-param>
      			<xsl:with-param name="name">tid</xsl:with-param>
      			<xsl:with-param name="maxsize">35</xsl:with-param>
      			<xsl:with-param name="readonly">Y</xsl:with-param>
     		</xsl:call-template>
     		</xsl:if>	
		<xsl:choose>
			<xsl:when test="tnx_type_code [.='30' or .= '31' or .= '38' or .= '15'] and $mode = 'DRAFT'">
				<xsl:call-template name="checkbox-field">
				     <xsl:with-param name="label">XSL_CLOSE_TRANSACTION</xsl:with-param>
				     <xsl:with-param name="name">close_tnx</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<!-- <xsl:when test="tnx_type_code [.= '38'] and($mode = 'UNSIGNED' or $option = 'FULL')">
				<div class="field checkbox">
					<span class="label"></span>
					<ul class="content">
				          <li><xsl:value-of select="localization:getGTPString($language, 'XSL_CLOSE_TRANSACTION')"/>
				          </li>
			         </ul>
		         </div>
			</xsl:when> -->
		</xsl:choose>
		
		<!-- Issue Date -->
		<!-- Displayed in consolidated view -->
		<xsl:if	test="$displaymode='view'">
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
				<xsl:with-param name="name">iss_date</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		&nbsp;

		<!-- Display the Buyer and Seller Details in readonly mode, for initiate IO from PO. 
				For other cases, they are editable fields. -->
	<div id ="buyerSellerDetails">
		<xsl:choose>
			<xsl:when test = "cross_references and cross_references[.!= '']">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-entity">N</xsl:with-param>
							<xsl:with-param name="show-BEI">Y</xsl:with-param>
							<xsl:with-param name="show-country-icon">N</xsl:with-param>
							<xsl:with-param name="show-entity-button">N</xsl:with-param>
							<xsl:with-param name="prefix">buyer</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
						</xsl:call-template>
						<!--
							If we have to, we show the reference field for applicants. This is
							specific to this form.
						-->
						<xsl:if
							test="not(avail_main_banks/bank/entity/customer_reference) and not(avail_main_banks/bank/customer_reference)">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
								<xsl:with-param name="name">buyer_reference</xsl:with-param>
								<xsl:with-param name="maxsize">34</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-BEI">Y</xsl:with-param>
							<xsl:with-param name="show-entity">Y</xsl:with-param>
							<xsl:with-param name="show-country-icon">N</xsl:with-param>
							<xsl:with-param name="prefix">seller</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<xsl:with-param name="readonly-bank-bic">Y</xsl:with-param>
							<xsl:with-param name="show-bank-bic">N</xsl:with-param>
							<xsl:with-param name="show-button">N</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-entity">N</xsl:with-param>
							<xsl:with-param name="show-entity-button">N</xsl:with-param>
							<xsl:with-param name="show-country-icon">N</xsl:with-param>
							<xsl:with-param name="show-BEI">Y</xsl:with-param>
							<xsl:with-param name="prefix">buyer</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>		
						</xsl:call-template>
						<!--
							If we have to, we show the reference field for applicants. This is
							specific to this form.
						-->
						<xsl:if
							test="not(avail_main_banks/bank/entity/customer_reference) and not(avail_main_banks/bank/customer_reference)">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
								<xsl:with-param name="name">buyer_reference</xsl:with-param>
								<xsl:with-param name="maxsize">34</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-entity">Y</xsl:with-param>
							<xsl:with-param name="show-button">N</xsl:with-param>
							<xsl:with-param name="show-BEI">Y</xsl:with-param>
							<xsl:with-param name="prefix">seller</xsl:with-param>
							<xsl:with-param name="show-bank-bic">N</xsl:with-param>
							<xsl:with-param name="readonly-bank-bic">Y</xsl:with-param>
							<xsl:with-param name="show-country-icon">N</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	
		
		

		<!-- Display other parties -->
		<xsl:if test="$displaymode='edit'">
		<xsl:call-template name="checkbox-field">
			<xsl:with-param name="name">display_other_parties</xsl:with-param>
			<xsl:with-param name="label">XSL_PURCHASE_ORDER_DISPLAY_OTHER_PARTIES</xsl:with-param>
			<xsl:with-param name="checked"><xsl:if test="bill_to_name[. != ''] or ship_to_name[. != ''] or consgn_to_name[. != '']">Y</xsl:if></xsl:with-param>
			<xsl:with-param name="disabled">Y</xsl:with-param>
		</xsl:call-template>
		</xsl:if>

		<!--
			Other parties Tabgroup. Tab0 - Bill To Tab1 - Ship To Tab2 -
			Consignee
		-->
		<xsl:call-template name="tabgroup-wrapper">
			<xsl:with-param name="tabgroup-id">other_parties_section</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			 <!-- Tab 0_0 - Bill To  -->
			<xsl:with-param name="tab0-label">XSL_HEADER_BILL_TO_DETAILS</xsl:with-param>
			<xsl:with-param name="tab0-content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="prefix">bill_to</xsl:with-param>
					<xsl:with-param name="show-button">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
			<!--  Tab 0_1 - Ship To -->
			<xsl:with-param name="tab1-label">XSL_HEADER_SHIP_TO_DETAILS</xsl:with-param>
			<xsl:with-param name="tab1-content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="prefix">ship_to</xsl:with-param>
					<xsl:with-param name="show-button">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
			 <!-- Tab 0_2 - Consignee -->
			<xsl:with-param name="tab2-label">XSL_HEADER_CONSIGNEE_DETAILS</xsl:with-param>
			<xsl:with-param name="tab2-content">
				<xsl:call-template name="party-details">
					<xsl:with-param name="prefix">consgn</xsl:with-param>
					<xsl:with-param name="show-button">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		</div>
	</xsl:template>
	
	<xsl:template name="amend-narrative">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMENDMENT_NARRATIVE</xsl:with-param>
    <xsl:with-param name="content">
     <!-- This empty tag is needed for this to appear, I'm not sure why. -->
     <div style="display:none">&nbsp;</div>
      <xsl:call-template name="row-wrapper">
       <xsl:with-param name="id">amd_details</xsl:with-param>
       <xsl:with-param name="type">textarea</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:call-template name="textarea-field">
         <xsl:with-param name="name">amd_details</xsl:with-param>
         <xsl:with-param name="rows">10</xsl:with-param>
         <xsl:with-param name="cols">50</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
        </xsl:call-template>
       </xsl:with-param>
      </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
	

	
	<!--Other Templates-->

	<!--TEMPLATE Issuing Bank (Main Details)-->
	<!--
		<xsl:template match="bank" mode="main"> <xsl:param
		name="bank"><xsl:value-of select="abbv_name"/></xsl:param> <option>
		<xsl:attribute name="value"><xsl:value-of
		select="$bank"/></xsl:attribute> <xsl:if
		test="../../issuing_bank/abbv_name=$bank"> <xsl:attribute
		name="selected"/> </xsl:if> <xsl:value-of select="name"/> </option>

		</xsl:template>
	-->
	<!--
   PO Realform.
   -->
	<xsl:template name="realform">
		<!--
			Do not display this section when the collaboration mode is
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
							<xsl:with-param name="value" select="tnx_type_code"/>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">prodstatus</xsl:with-param>
							<xsl:with-param name="value" select="prod_stat_code"/>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">link_tnx_id</xsl:with-param>
							<xsl:with-param name="value" select="$link_tnx_id"/>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">attIds</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">TransactionData</xsl:with-param>
							<xsl:with-param name="value" />
						</xsl:call-template>
						<xsl:call-template name="reauth_params"/>
					</div>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!-- Baseline Payment terms -->
	<xsl:template name="baseline-payment-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PAYMENT_TERMS_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-baseline-payments-details">
					<xsl:with-param name="items" select="forward_dataset_submission/FwdDataSetSubmissnRpt/ComrclDataSet/PmtTerms" />
					<xsl:with-param name="id">baseline-payments</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Amount Details Fieldset. -->
	<xsl:template name="baseline-amount-details">
			<xsl:if test="$displaymode='edit'">
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_ORDERED_LINE_ITEMS_TOTAL_AMOUNT</xsl:with-param>
					<xsl:with-param name="override-currency-name">order_total_cur_code</xsl:with-param>
					<xsl:with-param name="override-amt-name">order_total_amt</xsl:with-param>
					<xsl:with-param name="amt-readonly">Y</xsl:with-param>
					<xsl:with-param name="currency-readonly">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_ACCEPTED_LINE_ITEMS_TOTAL_AMOUNT</xsl:with-param>
					<xsl:with-param name="override-currency-name">accpt_total_cur_code</xsl:with-param>
					<xsl:with-param name="override-amt-name">accpt_total_amt</xsl:with-param>
					<xsl:with-param name="amt-readonly">Y</xsl:with-param>
					<xsl:with-param name="currency-readonly">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_OUTSTANDING_LINE_ITEMS_TOTAL_AMOUNT</xsl:with-param>
					<xsl:with-param name="override-currency-name">outstanding_total_cur_code</xsl:with-param>
					<xsl:with-param name="override-amt-name">outstanding_total_amt</xsl:with-param>
					<xsl:with-param name="amt-readonly">Y</xsl:with-param>
					<xsl:with-param name="currency-readonly">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_PENDING_LINE_ITEMS_TOTAL_AMOUNT</xsl:with-param>
					<xsl:with-param name="override-currency-name">pending_total_cur_code</xsl:with-param>
					<xsl:with-param name="override-amt-name">pending_total_amt</xsl:with-param>
					<xsl:with-param name="amt-readonly">Y</xsl:with-param>
					<xsl:with-param name="currency-readonly">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_ORDERED_NET_TOTAL_AMOUNT</xsl:with-param>
					<xsl:with-param name="override-currency-name">order_total_net_cur_code</xsl:with-param>
					<xsl:with-param name="override-amt-name">order_total_net_amt</xsl:with-param>
					<xsl:with-param name="amt-readonly">Y</xsl:with-param>
					<xsl:with-param name="currency-readonly">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_ACCEPTED_NET_TOTAL_AMOUNT</xsl:with-param>
					<xsl:with-param name="override-currency-name">accpt_total_net_cur_code</xsl:with-param>
					<xsl:with-param name="override-amt-name">accpt_total_net_amt</xsl:with-param>
					<xsl:with-param name="amt-readonly">Y</xsl:with-param>
					<xsl:with-param name="currency-readonly">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_OUTSTANDING_NET_TOTAL_AMOUNT</xsl:with-param>
					<xsl:with-param name="override-currency-name">outstanding_total_net_cur_code</xsl:with-param>
					<xsl:with-param name="override-amt-name">outstanding_total_net_amt</xsl:with-param>
					<xsl:with-param name="amt-readonly">Y</xsl:with-param>
					<xsl:with-param name="currency-readonly">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_PENDING_NET_TOTAL_AMOUNT</xsl:with-param>
					<xsl:with-param name="override-currency-name">pending_total_net_cur_code</xsl:with-param>
					<xsl:with-param name="override-amt-name">pending_total_net_amt</xsl:with-param>
					<xsl:with-param name="amt-readonly">Y</xsl:with-param>
					<xsl:with-param name="currency-readonly">Y</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
				</xsl:call-template>
				<!-- <xsl:if test="prod_stat_code[.='54']">
					<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_FINANCE_AMOUNT</xsl:with-param>
						<xsl:with-param name="override-currency-name">finance_cur_code</xsl:with-param>
						<xsl:with-param name="override-amt-name">finance_amt</xsl:with-param>
						<xsl:with-param name="amt-readonly">N</xsl:with-param>
						<xsl:with-param name="currency-readonly">N</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="show-button">Y</xsl:with-param>
					</xsl:call-template>				
				</xsl:if> -->	
			</xsl:if>
			<xsl:if test="$displaymode='view'">
			<xsl:choose>
				<xsl:when test="tnx_type_code[. = '55']">
					<xsl:if test="intent_to_pay_amt[. != '']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_INTENT_TO_PAY_AMOUNT</xsl:with-param>
							<xsl:with-param name="name">intent_to_pay_amt</xsl:with-param>
							<xsl:with-param name="type">amount</xsl:with-param>
							<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
							<xsl:with-param name="value">
						         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="intent_to_pay_amt"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="order_total_amt[. != '']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_ORDERED_LINE_ITEMS_TOTAL_AMOUNT</xsl:with-param>
							<xsl:with-param name="name">order_total_amt</xsl:with-param>
							<xsl:with-param name="type">amount</xsl:with-param>
							<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
							<xsl:with-param name="value">
						         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="order_total_amt"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="accpt_total_amt[. != '']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_ACCEPTED_LINE_ITEMS_TOTAL_AMOUNT</xsl:with-param>
							<xsl:with-param name="name">accpt_total_amt</xsl:with-param>
							<xsl:with-param name="type">amount</xsl:with-param>
							<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
							<xsl:with-param name="value">
						         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="accpt_total_amt"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="outstanding_total_amt[. != '']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_OUTSTANDING_LINE_ITEMS_TOTAL_AMOUNT</xsl:with-param>
							<xsl:with-param name="name">outstanding_total_amt</xsl:with-param>
							<xsl:with-param name="type">amount</xsl:with-param>
							<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
							<xsl:with-param name="value">
						         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="outstanding_total_amt"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="pending_total_amt[. != '']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PENDING_LINE_ITEMS_TOTAL_AMOUNT</xsl:with-param>
							<xsl:with-param name="name">pending_total_amt</xsl:with-param>
							<xsl:with-param name="type">amount</xsl:with-param>
							<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
							<xsl:with-param name="value">
						         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="pending_total_amt"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="order_total_net_amt[. != '']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_ORDERED_NET_TOTAL_AMOUNT</xsl:with-param>
							<xsl:with-param name="name">order_total_net_amt</xsl:with-param>
							<xsl:with-param name="type">amount</xsl:with-param>
							<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
							<xsl:with-param name="value">
						         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="order_total_net_amt"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="accpt_total_net_amt[. != '']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_ACCEPTED_NET_TOTAL_AMOUNT</xsl:with-param>
							<xsl:with-param name="name">accpt_total_net_amt</xsl:with-param>
							<xsl:with-param name="type">amount</xsl:with-param>
							<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
							<xsl:with-param name="value">
						         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="accpt_total_net_amt"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="outstanding_total_net_amt[. != '']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_OUTSTANDING_NET_TOTAL_AMOUNT</xsl:with-param>
							<xsl:with-param name="name">outstanding_total_net_amt</xsl:with-param>
							<xsl:with-param name="type">amount</xsl:with-param>
							<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
							<xsl:with-param name="value">
						         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="outstanding_total_net_amt"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="pending_total_net_amt[. != '']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PENDING_NET_TOTAL_AMOUNT</xsl:with-param>
							<xsl:with-param name="name">pending_total_net_amt</xsl:with-param>
							<xsl:with-param name="type">amount</xsl:with-param>
							<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
							<xsl:with-param name="value">
						         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="pending_total_net_amt"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="commercial-goods-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_LINE_ITEMS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<!-- Line items grid -->
				<xsl:call-template name="build-commercial-dataset-line-items-dojo-items">
					<xsl:with-param name="items" select="forward_dataset_submission/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/ComrclLineItms" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		
	</xsl:template>
	
</xsl:stylesheet>
