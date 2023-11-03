<?xml version="1.0" encoding="UTF-8"?>
<!-- 
##########################################################
Templates for Request for Foreign Exchange (FX) Form, Customer Side.
Copyright (c) 2000-2014 Misys (http://www.misys.com), All Rights Reserved.
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
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="xmlRender localization securitycheck utils defaultresource security">

  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
	<xsl:param name="rundata" />
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen -->
	<xsl:param name="product-code">FX</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath" /><xsl:value-of select="$servletPath" />/screen/ForeignExchangeScreen</xsl:param>

	<!-- Global Imports. -->
	<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
	<xsl:include href="../../core/xsl/common/trade_common.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
	<xsl:include href="./cash_common.xsl" />
	<xsl:include href="./request_common.xsl" />
	<xsl:include href="./fx_common.xsl" />
	<xsl:include href="./fx_spot.xsl" />
	<xsl:include href="./fx_forward.xsl" />
	<xsl:include href="./fx_swap.xsl" />
	<xsl:include href="./fx_delivery_option.xsl" />
	<xsl:include href="./fx_settlement.xsl" />
	<xsl:include href="./fx_windowforward.xsl" />

  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/">
		<xsl:apply-templates select="fx_tnx_record" />
	</xsl:template>

	<!-- FX TNX FORM TEMPLATE. -->
	<xsl:template match="fx_tnx_record">
		<!-- Preloader -->
		<xsl:call-template name="loading-message" />

		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>

			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name" />
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">

					<!-- Display common menu. -->
					<xsl:call-template name="menu">
						<xsl:with-param name="show-save">N</xsl:with-param>
						<xsl:with-param name="show-submit">N</xsl:with-param>
						<xsl:with-param name="show-template">N</xsl:with-param>
					</xsl:call-template>

					<!-- Disclaimer Notice -->
					<xsl:call-template name="disclaimer" />

					<xsl:apply-templates select="cross_references" mode="hidden_form" />

					<xsl:call-template name="hidden-fields" />

					<xsl:call-template name="fx-general-details" />
					
					<xsl:call-template name="bank-details"/>

					<!-- FX Details. -->
					<xsl:call-template name="fx-details" />

					<!-- Customer Payment Details and Bank Detail (Settlement Detail In View Mode) --> 
					<xsl:call-template name="customer_and_bank_instruction_view" />
					
					<!-- Return comments -->
					<xsl:call-template name="comments-for-return">
	  					<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   					<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   					</xsl:call-template>
					
					<xsl:call-template name="reauthentication" />
					<xsl:call-template name="e2ee_transaction"/>
					<xsl:call-template name="reauth_params"/>

					<!-- FX Bank Payment Details (Debit Account) -->
					<!-- <xsl:if test="$displaymode='view'"> -->
					<!-- <xsl:choose> -->
					<!-- <xsl:when test="$option !='' and $option ='DETAILS'"> -->
					<!-- <xsl:call-template name="fx-settlement-details-section"/> -->
					<!-- </xsl:when> -->
					<!-- <xsl:when test="$option !='' and $option ='FULL'"> -->
					<!-- <xsl:call-template name="fx-settlement-details-countertparty"/> -->
					<!-- </xsl:when> -->
					<!-- <xsl:otherwise> -->
					<!-- </xsl:otherwise> -->
					<!-- </xsl:choose> -->
					<!-- </xsl:if> -->

				</xsl:with-param>
			</xsl:call-template>

			<!-- Form #1 : Attach Files -->
			<!-- <xsl:call-template name="attachments-file-dojo"/> -->

			<xsl:call-template name="realform" />

			<xsl:call-template name="menu">
				<xsl:with-param name="show-save">N</xsl:with-param>
				<xsl:with-param name="show-submit">N</xsl:with-param>
				<xsl:with-param name="show-template">N</xsl:with-param>
				<xsl:with-param name="second-menu">Y</xsl:with-param>
			</xsl:call-template>
		</div>


		<!-- Javascript imports -->
		<xsl:call-template name="js-imports" />
	</xsl:template>
	<!-- -->
	<!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
	<!-- -->

	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
   			<xsl:with-param name="binding">misys.binding.cash.create_fx</xsl:with-param>
   			 <xsl:with-param name="override-help-access-key">FX_01</xsl:with-param>
		</xsl:call-template>
		<script>
			dojo.ready(function(){
				misys._config = (misys._config) || {};
            }
            ];			
		});
		</script>
	</xsl:template>

	<!-- Additional hidden fields for this form are -->
	<!-- added here. -->
	<xsl:template name="hidden-fields">
		<xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="show-type">N</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


	<xsl:template name="general-details">
		<!-- General details for fx order -->
		<!-- <xsl:call-template name="fx-general-details"/> -->
	</xsl:template>

	<xsl:template name="general-details-preview">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="common-general-details">
					<xsl:with-param name="show-template-id">N</xsl:with-param>
					<xsl:with-param name="show-cust-ref-id">N</xsl:with-param>
					<xsl:with-param name="show-bo-ref-id">N</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
			    	<xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
					<xsl:with-param name="value" select="bo_ref_id" />
			    	<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
			    	<xsl:with-param name="label">XSL_CONTRACT_FX_TRADE_ID_LABEL</xsl:with-param>
					<xsl:with-param name="value" select="trade_id" />
			    	<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>

				<!-- not required for window forwards -->
				<xsl:if test="sub_product_code[.!='DOPT']">
					<!-- Near and far fields for swap -->
					<xsl:choose>
						<xsl:when test="sub_product_code[.='SWAP']">
							<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CONTRACT_FX_NEAR_VALUE_DATE_LABEL</xsl:with-param>
							<xsl:with-param name="value" select="normalize-space(org_previous_file/fx_tnx_record/near_value_date)" />
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CONTRACT_FX_FAR_VALUE_DATE_LABEL</xsl:with-param>
							<xsl:with-param name="value" select="normalize-space(org_previous_file/fx_tnx_record/value_date)" />
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>

							<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CONTRACT_FX_NEAR_AMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="value" select="normalize-space(concat(org_previous_file/fx_tnx_record/fx_cur_code, ' ', org_previous_file/fx_tnx_record/near_amt))" />
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CONTRACT_FX_FAR_AMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="value" select="normalize-space(concat(org_previous_file/fx_tnx_record/fx_cur_code, ' ', org_previous_file/fx_tnx_record/fx_amt))" />
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_AMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="value" select="normalize-space(concat(org_previous_file/fx_tnx_record/tnx_cur_code, ' ', org_previous_file/fx_tnx_record/tnx_amt))" />
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_CONTRACT_FX_RATE_LABEL</xsl:with-param>
						<xsl:with-param name="value" select="rate" />
					<xsl:with-param name="type">ratenumber</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
					<!-- Near and far fields for swap -->
					<xsl:choose>
						<xsl:when test="sub_product_code[.='SWAP']">
							<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CONTRACT_FX_RECEIVING_NEAR_COUNTER_AMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="value" select="normalize-space(concat(org_previous_file/fx_tnx_record/counter_cur_code, ' ', org_previous_file/fx_tnx_record/near_counter_amt))" />
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CONTRACT_FX_RECEIVING_FAR_COUNTER_AMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="value" select="normalize-space(concat(org_previous_file/fx_tnx_record/counter_cur_code, ' ', org_previous_file/fx_tnx_record/counter_amt))" />
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CONTRACT_FX_SETTLEMENT_AMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="value" select="normalize-space(concat(org_previous_file/fx_tnx_record/tnx_counter_cur_code, ' ', org_previous_file/fx_tnx_record/tnx_counter_amt))" />
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="sub_product_code[.!='SWAP']">
							<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:with-param>
								<xsl:with-param name="value" select="value_date" />
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
				</xsl:if>

				<xsl:choose>
					<xsl:when test="sub_product_code[.!='SWAP']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">ENTITY_LABEL</xsl:with-param>
							<xsl:with-param name="value" select="normalize-space(org_previous_file/fx_tnx_record/entity)" />
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">sub_product_code</xsl:with-param>
					<xsl:with-param name="value" select="sub_product_code" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- FX General Details -->
	<xsl:template name="fx-details">
		<!-- For fx initiation and fx inquiry (displaymode = view and no tnx_type_code tag in xml flow)-->
		<xsl:if test="$displaymode != 'view' or ($displaymode = 'view' and (not(tnx_id) or tnx_type_code!='13'))"> 
			<xsl:choose>
				<xsl:when test="sub_product_code[.='SPOT']">
					<xsl:call-template name="fx-spot-details" />
				</xsl:when>
				<xsl:when test="sub_product_code[.='FWD']">
					<xsl:call-template name="fx-forward-details" />
				</xsl:when>
				<xsl:when test="sub_product_code[.='SWAP']">
					<xsl:call-template name="fx-swap-details" />
				</xsl:when>
				<xsl:when test="sub_product_code[.='DOPT']">
					<xsl:call-template name="fx-delivery-option-details" />
				</xsl:when>
				<xsl:when test="sub_product_code[.='WFWD']">
					<xsl:call-template name="fx-window-forward-details" />
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		<!-- for fx update review only (because we use only one template for review) -->
		<!-- <xsl:if test="tnx_type_code[.='13'] and $displaymode='view' and sub_tnx_type_code[.!='37']">
			<xsl:call-template name="fx-update-review" />
		</xsl:if> -->
	</xsl:template>

  <!--
   Hidden fields for Request for Financing
   -->
	<xsl:template name="realform">
		<xsl:call-template name="form-wrapper">
		    <xsl:with-param name="name">realform</xsl:with-param>
		    <xsl:with-param name="method">POST</xsl:with-param>
			<xsl:with-param name="action" select="$realform-action" />
			<xsl:with-param name="content">
				<div class="widgetContainer">
					<xsl:call-template name="hidden-field">
       					<xsl:with-param name="name">referenceid</xsl:with-param>
						<xsl:with-param name="value" select="ref_id" />
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
       					<xsl:with-param name="name">tnxid</xsl:with-param>
						<xsl:with-param name="value" select="tnx_id" />
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
      					<xsl:with-param name="value">01</xsl:with-param>
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
      					<xsl:with-param name="name">option</xsl:with-param>
						<xsl:with-param name="value" />
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">productcode</xsl:with-param>
						<xsl:with-param name="value" select="$product-code" />
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">subproductcode</xsl:with-param>
						<xsl:with-param name="value" select="sub_product_code" />
					</xsl:call-template>

					<xsl:choose>
						<xsl:when test="defaultresource:getResource('ENABLE_FX_COUNTER_AMOUNT') = 'true'">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">enableCounterCurrency</xsl:with-param>
								<xsl:with-param name="value">true</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">enableCounterCurrency</xsl:with-param>
								<xsl:with-param name="value">false</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>