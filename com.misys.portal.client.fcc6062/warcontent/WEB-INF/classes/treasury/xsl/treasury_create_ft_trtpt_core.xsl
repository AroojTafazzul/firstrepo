<?xml version="1.0" encoding="UTF-8"?>
<!-- 
##########################################################
Templates for Request for Fund Transfer External Payment Form, Customer Side.
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
	xmlns:jetSpeedResources="xalan://com.misys.portal.core.util.JetspeedResources"
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
	<xsl:param name="product-code">FT</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath" /><xsl:value-of select="$servletPath" />/screen/TreasuryFundTransferScreen</xsl:param>

	<!-- Global Imports. -->
	<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
	<xsl:include href="../../core/xsl/common/trade_common.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
	<xsl:include href="../../cash/xsl/cash_common.xsl" />
	<xsl:include href="../../cash/xsl/request_common.xsl" />
	<xsl:include href="../../cash/xsl/fx_common.xsl" />
	<xsl:include href="treasury_create_ft_common.xsl" />
	
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/">
		<xsl:apply-templates select="ft_tnx_record" />
	</xsl:template>

	<!-- FX TNX FORM TEMPLATE. -->
	<xsl:template match="ft_tnx_record">
		<!-- Preloader -->
		<xsl:call-template name="loading-message" />
		<xsl:call-template name="clearing-code-loader" />
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>

			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name" />
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
				
					<xsl:call-template name="menu">
						<xsl:with-param name="show-return">Y</xsl:with-param>
				      	<xsl:with-param name="show-template">N</xsl:with-param>
				      	<xsl:with-param name="show-save">Y</xsl:with-param>
				      	<xsl:with-param name="show-submit">N</xsl:with-param>
				      	<xsl:with-param name="treasury-fund-transfer-mode">Y</xsl:with-param>
					      	<xsl:with-param name="add-button-begin">
					      		<xsl:call-template name="button-wrapper">
						        <xsl:with-param name="label">XSL_ACTION_SUBMIT</xsl:with-param>
						        <xsl:with-param name="id">submitButton_FT</xsl:with-param>
						        <xsl:with-param name="show-text-label">Y</xsl:with-param>
						        <xsl:with-param name="onclick">misys.requestFT();</xsl:with-param>
						       </xsl:call-template>
					      	</xsl:with-param>
			      	</xsl:call-template>



					<!-- Disclaimer Notice -->
					<xsl:call-template name="disclaimer" />

					<xsl:apply-templates select="cross_references" mode="hidden_form" />

					<xsl:call-template name="hidden-fields" />

					<xsl:call-template name="fx-general-details" />
					
					<xsl:call-template name="bank-details"/>
					
					<xsl:call-template name="ft-transfer-payment-details"/>
					  
					<xsl:call-template name="deal-confirmation-dialog"/>
					
					<!-- Customer Payment Details and Bank Detail (Settlement Detail In View Mode) -->
					<xsl:call-template name="customer_and_bank_instruction_view"/>

					<!-- Return comments -->
					<xsl:call-template name="comments-for-return">
	  					<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   					<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   					</xsl:call-template>
					
					<xsl:call-template name="reauthentication" />
					<xsl:call-template name="e2ee_transaction"/>

					<xsl:call-template name="reauth_params"/>
					
					<xsl:call-template name="loading-Dialog"/>
					
	      			
	      			 <xsl:if test="ft_type[.='02'] and $displaymode!='view'">
						      <xsl:call-template name="fieldset-wrapper">
							 	 <xsl:with-param name="legend">XSL_SI_SELECT_BANK_INSTRUCTIONS_LABEL</xsl:with-param>
									  <xsl:with-param name="content">
									  <xsl:call-template name="si-bank-instructions">	
									  <xsl:with-param name="parse-widg">N</xsl:with-param>
									  <xsl:with-param name="free-format-only">N</xsl:with-param>
									  <xsl:with-param name="beneficiary-cur-code">payment_cur_code</xsl:with-param>
									  <xsl:with-param name="toc-item">Y</xsl:with-param>
									  </xsl:call-template>
								      </xsl:with-param>
							</xsl:call-template>
	 				 </xsl:if>
				</xsl:with-param>
			</xsl:call-template>

			<xsl:call-template name="realform" />
			
			<xsl:call-template name="menu">
			    <xsl:with-param name="second-menu">Y</xsl:with-param>
			    <xsl:with-param name="show-template">N</xsl:with-param>
			    <xsl:with-param name="show-submit">N</xsl:with-param>
			    <xsl:with-param name="show-return">Y</xsl:with-param>
			    <xsl:with-param name="treasury-fund-transfer-mode">Y</xsl:with-param>
		      	<xsl:with-param name="add-button-begin">
		      		<xsl:call-template name="button-wrapper">
				        <xsl:with-param name="label">XSL_ACTION_SUBMIT</xsl:with-param>
				        <xsl:with-param name="id">submitButton2_FT</xsl:with-param>
				        <xsl:with-param name="show-text-label">Y</xsl:with-param>
				        <xsl:with-param name="onclick">misys.requestFT();</xsl:with-param>
			    </xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</div>
		
		<!-- Table of Contents -->
   		<xsl:call-template name="toc"/>

		<!-- Javascript imports -->
		<xsl:call-template name="js-imports" />
	</xsl:template> 
	
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
   				<xsl:with-param name="binding">misys.binding.treasury.create_ft_trtpt</xsl:with-param>
   				<xsl:with-param name="override-help-access-key">TRTPT_01</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Additional hidden fields for this form are -->
	<!-- added here. -->
	<xsl:template name="hidden-fields">
	<xsl:variable name="swift_flag" select="defaultresource:getResource('OPICS_SWIFT_ENABLED')='true'"/>
		<xsl:call-template name="common-hidden-fields">
    		<xsl:with-param name="show-type">N</xsl:with-param>
    		<xsl:with-param name="additional-fields">
    				<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">instructions_type</xsl:with-param>
				    </xsl:call-template>
				    
				    <xsl:choose>
	    				<xsl:when test="$swift_flag='true'">
    					<xsl:call-template name="hidden-field">
	    				<xsl:with-param name="name">product_type</xsl:with-param>
	    				<xsl:with-param name="value">TRSRYFXFT</xsl:with-param>
	   					</xsl:call-template>
	   					</xsl:when>
	   					<xsl:otherwise>
	   					<xsl:call-template name="hidden-field">
	    				<xsl:with-param name="name">product_type</xsl:with-param>
	    				<xsl:with-param name="value">TRSRY</xsl:with-param>
	   					</xsl:call-template>
	   					</xsl:otherwise>
	   				</xsl:choose>
	   			<xsl:call-template name="hidden-field">
	    				<xsl:with-param name="name">product_code</xsl:with-param>
	    				<xsl:with-param name="value">FT</xsl:with-param>
	   			</xsl:call-template>
				<xsl:call-template name="hidden-field">
	    			<xsl:with-param name="name">sub_product_code</xsl:with-param>
	    			<xsl:with-param name="value" select="sub_product_code"/>
	   			</xsl:call-template>
	   			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">ft_type</xsl:with-param>
					<xsl:with-param name="value">02</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">debit_ccy</xsl:with-param>
					<xsl:with-param name="value" select="debit_ccy"/>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">deal_type</xsl:with-param>
				</xsl:call-template>			
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">request_number</xsl:with-param>   
				</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">payment_type</xsl:with-param>
						<xsl:with-param name="value">01</xsl:with-param>
					</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">receipt_instructions_id</xsl:with-param>
							<xsl:with-param name="value"/>
						</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">bo_tnx_id</xsl:with-param>   
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">rec_id</xsl:with-param>   
				</xsl:call-template>
					<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">debit_amt</xsl:with-param>
				</xsl:call-template>  
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">credit_amt</xsl:with-param>
				</xsl:call-template> 
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">debitAccountNumber</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">debitAccountName</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">debitAmount</xsl:with-param>
				</xsl:call-template> 
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">beneficiary_reference</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">creditAccountNumber</xsl:with-param>
					<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='02']/counterparty_act_no"/>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">creditAccountName</xsl:with-param>
					<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='02']/counterparty_name"/>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">counterparty_amt</xsl:with-param>
					<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='02']/counterparty_amt"/>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">counterparty_cur_code</xsl:with-param>
					<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='02']/counterparty_cur_code"/>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">rate</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">remarks</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">feeAccount</xsl:with-param>
					<xsl:with-param name="value" select="fee_act_no"/>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">feeAmt</xsl:with-param>
					<xsl:with-param name="value" select="fee_amt"/>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">feeCurCode</xsl:with-param>
					<xsl:with-param name="value" select="fee_cur_code"/>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">bo_ref_id</xsl:with-param>
					<xsl:with-param name="value" select="bo_ref_id"/>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">tnx_stat_code</xsl:with-param>
					<xsl:with-param name="value" select="tnx_stat_code"/>
				</xsl:call-template>
				
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">effDate</xsl:with-param>
				</xsl:call-template>
    		</xsl:with-param>
		</xsl:call-template>
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
						<xsl:with-param name="value">ACCEPT</xsl:with-param>
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
	
	<!--  Confirmation of Deal -->
	
	<xsl:template name="deal-confirmation-dialog">
	 <div class="widgetContainer">
		<xsl:call-template name="dialog">
			<xsl:with-param name="id">dealSummaryDialog</xsl:with-param>
		    <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_FT_DEAL_SUMMARY_DIALOG_TITLE')" /></xsl:with-param>
		    <xsl:with-param name="content">
		     			<!-- TRANSFER DETAILS -->
				<div id="TransferDetails">
					<xsl:call-template name="fieldset-wrapper">		
						<xsl:with-param name="legend">XSL_HEADER_TRANSFER_DETAILS</xsl:with-param>		
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="toc-item">N</xsl:with-param>				
						<xsl:with-param name="content">
							<xsl:call-template name="input-field">
									<xsl:with-param name="name">summary_bo_ref_id</xsl:with-param>
									<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_TRANSACTION_NUMBER</xsl:with-param>
									<xsl:with-param name="override-displaymode">view</xsl:with-param>
									<xsl:with-param name="value">&nbsp;</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="name">summary_executionDate</xsl:with-param>
								<xsl:with-param name="label">XSL_CONTRACT_FT_REQUEST_DATE_LABEL</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
								<xsl:with-param name="value">&nbsp;</xsl:with-param>
							</xsl:call-template>
						<xsl:call-template name="input-field">
								<xsl:with-param name="name">summary_rate</xsl:with-param>
								<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_RATE</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
								<xsl:with-param name="value">&nbsp;</xsl:with-param>
						   </xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</div>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_ORDERING_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">summary_debitAccountNumber</xsl:with-param>
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_ACCOUT</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">summary_debitAccountName1</xsl:with-param>
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_ACCOUNT_NAME</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">summary_debitAmount</xsl:with-param>
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_AMOUNT</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				
				<div id="transferDetailsId">
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_HEADER_TRANSFER_BENEFICIARY_DETAILS</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="toc-item">N</xsl:with-param>
						<xsl:with-param name="content">
					    	<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">summary_beneficiaryReference</xsl:with-param>
							</xsl:call-template>
					    	<xsl:call-template name="input-field">
								<xsl:with-param name="name">summary_beneficiaryName</xsl:with-param>
								<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_NAME</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
								<xsl:with-param name="value">&nbsp;</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="name">summary_creditAccountNumber</xsl:with-param>
								<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_ACCOUNT</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
								<xsl:with-param name="value">&nbsp;</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="name">summary_creditAccountName</xsl:with-param>
								<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_ACCOUNT_NAME</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
								<xsl:with-param name="value">&nbsp;</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="name">summary_transferAmount</xsl:with-param>
								<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_TRANSFERT_AMOUNT</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
								<xsl:with-param name="value">&nbsp;</xsl:with-param>
							</xsl:call-template>							
						</xsl:with-param>
					</xsl:call-template>
				</div>
				
						<!-- INSTRUCTION DETAILS -->
			<xsl:choose>
				<xsl:when test="ft_type[.='02'] or ft_type[.='05']">
						<!-- Exposing localization code values -->
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">swift_charges_type_01</xsl:with-param>
							<xsl:with-param name="value" select="localization:getDecode($language, 'N017', '01')"/>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">swift_charges_type_02</xsl:with-param>
							<xsl:with-param name="value" select="localization:getDecode($language, 'N017', '02')"/>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">swift_charges_type_05</xsl:with-param>
							<xsl:with-param name="value" select="localization:getDecode($language, 'N017', '05')"/>
						</xsl:call-template>				
					<div id="paymentDetailsIdBankInstructions">
						<xsl:call-template name="paymentDetails">
							<xsl:with-param name="mode">WIRE</xsl:with-param>
							<xsl:with-param name="prefix">summary_bi</xsl:with-param>
                            <xsl:with-param name="additionalDetailsDiv">additionalDetailsBankFormat</xsl:with-param>
							<xsl:with-param name="paymentDetailsDiv">paymentDetailsBankFormat</xsl:with-param>							
						</xsl:call-template>
					</div>
					<div id="paymentDetailsIdFreeFormat">
						<xsl:call-template name="paymentDetails">
							<xsl:with-param name="mode">WIRE</xsl:with-param>
							<xsl:with-param name="prefix">summary</xsl:with-param>
							<xsl:with-param name="additionalDetailsDiv">additionalDetailsFreeFormat</xsl:with-param>
							<xsl:with-param name="paymentDetailsDiv">paymentDetailsFreeFormat</xsl:with-param>
						</xsl:call-template>
					</div>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="paymentDetails">
						<xsl:with-param name="prefix">summary</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
					
		    </xsl:with-param>
			<xsl:with-param name="buttons">
			   	<xsl:call-template name="row-wrapper">
					<xsl:with-param name="content">
						<xsl:call-template name="button-wrapper">
							<xsl:with-param name="id">sendRequestId</xsl:with-param>
							<xsl:with-param name="label">XSL_ACTION_ACCEPT</xsl:with-param>
							<xsl:with-param name="onclick">misys.acceptFT();</xsl:with-param>
							<xsl:with-param name="show-text-label">Y</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="button-wrapper">
							<xsl:with-param name="id">rejectDelayId</xsl:with-param>
							<xsl:with-param name="label">XSL_ACTION_REJECT</xsl:with-param>
							<xsl:with-param name="onclick">misys.rejectFT();</xsl:with-param>
							<xsl:with-param name="show-text-label">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<div id="rateField">
					<xsl:call-template name="cash-rate-progress-bar"/>
				</div>
		    </xsl:with-param>
		</xsl:call-template>
	  </div>
	</xsl:template>


								
<!--  Finish Confirmation Dialog -->

<!-- <xsl:template name="ft-review-fields">

	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="included-in-toc">N</xsl:with-param>
		<xsl:with-param name="legend">XSL_HEADER_TRANSFER_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
			<div id="transferDetailsId">
				FT type
				<xsl:call-template name="display-and-hidden-field">
					<xsl:with-param name="label">XSL_CONTRACT_FX_TYPE_LABEL</xsl:with-param>
					<xsl:with-param name="name">ft_type</xsl:with-param>
					<xsl:with-param name="value" select="localization:getDecode($language, 'N029', ft_type)" />
				</xsl:call-template>
				
				debit reference
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">payment_deal_no</xsl:with-param>
					<xsl:with-param name="label">XSL_GENERALDETAILS_BO_DEBIT_ID</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>

				credit reference
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">xfer_deal_no</xsl:with-param>
					<xsl:with-param name="label">XSL_GENERALDETAILS_BO_CREDIT_ID</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>

				fx reference
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">fx_deal_no</xsl:with-param>
					<xsl:with-param name="label">XSL_GENERALDETAILS_BO_FX_ID</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">review_debitAccountNumber</xsl:with-param>
					<xsl:with-param name="label">XSL_PARTIESDETAILS_ORDERING_ACT_NO</xsl:with-param>
					<xsl:with-param name="value" select="applicant_act_no"/>
				</xsl:call-template>
				<xsl:choose>
					<xsl:when test="ft_type = '01'">
						debit notional
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">review_debitAmount</xsl:with-param>
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_CCY_AND_AMT</xsl:with-param>
							<xsl:with-param name="value">
							<xsl:value-of select="debit_ccy"/>&nbsp;<xsl:value-of select="debit_amt"/>						
							</xsl:with-param>
						</xsl:call-template>
						
						transfer notional
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">review_transferAmount</xsl:with-param>
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_TRANSFERT_CURRENCY_AMOUNT</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="counterparties/counterparty[counterparty_type='OPICS_BANK_PAYMENT']/counterparty_cur_code"/>&nbsp;<xsl:value-of select="counterparties/counterparty[counterparty_type='OPICS_BANK_PAYMENT']/counterparty_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="ft_type = '02'">	
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">review_debitAmount</xsl:with-param>
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_CCY_AND_AMT</xsl:with-param>
							<xsl:with-param name="value">	
							<xsl:value-of select="debit_ccy"/>&nbsp;<xsl:value-of select="debit_amt"/>						
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">review_debitAmount</xsl:with-param>
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_PAYEMENT_AMOUNT</xsl:with-param>
							<xsl:with-param name="value">
							<xsl:value-of select="ft_cur_code"/>&nbsp;<xsl:value-of select="ft_amt"/>						
							</xsl:with-param>
						</xsl:call-template>	
					</xsl:when>
				</xsl:choose>
				
				rate
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">review_rate</xsl:with-param>
					<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_RATE</xsl:with-param>
					<xsl:with-param name="value" select="rate"/>
					<xsl:with-param name="type">ratenumber</xsl:with-param>
				</xsl:call-template>
				
				issuing date
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">review_executionDate</xsl:with-param>
					<xsl:with-param name="label">XSL_GENERALDETAILS_EXECUTION_DATE</xsl:with-param>
					<xsl:with-param name="value" select="iss_date"/>
				</xsl:call-template>
								
				beneficiary bank account
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">review_beneficiary_bank_account</xsl:with-param>
					<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK_ACCOUNT</xsl:with-param>
					<xsl:with-param name="value" select="beneficiary_bank_account"/>
				</xsl:call-template>
				Charges Born By Flags
				<xsl:variable name="FTCharge"><xsl:value-of select="jetSpeedResources:getBoolean('FX.enable.FT.Charge')"/></xsl:variable>
				<xsl:if test="$FTCharge = 'true'">
					FT charge
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">review_open_chrg_brn_by_code</xsl:with-param>
						<xsl:with-param name="label">XSL_CHRGDETAILS_BORN_BY_LABEL</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:if test="open_chrg_brn_by_code[.!='']">
								<xsl:value-of select="localization:getDecode($language, 'N017', open_chrg_brn_by_code)"/>
							</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
							
				account charge
				<xsl:variable name="chargeAccChargeCurrency"><xsl:value-of select="jetSpeedResources:getBoolean('FX.enable.FT.ChargeAccount')"/></xsl:variable>	
				<xsl:if test="$chargeAccChargeCurrency = 'true'">		
		
					charge account number
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">review_fee_act_no</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_CHARGE_ACCT</xsl:with-param>
						<xsl:with-param name="value" select="fee_act_no"/>
					</xsl:call-template>		
		
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">review_chargeAmount</xsl:with-param>
						<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_CHARGE_AMT_CURRENCY_MC</xsl:with-param>
						<xsl:with-param name="value">
						<xsl:value-of select="fee_cur_code"/>&nbsp;<xsl:value-of select="fee_amt"/>						
						</xsl:with-param>
					</xsl:call-template>		
				</xsl:if>
			</div>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template> -->

</xsl:stylesheet>
