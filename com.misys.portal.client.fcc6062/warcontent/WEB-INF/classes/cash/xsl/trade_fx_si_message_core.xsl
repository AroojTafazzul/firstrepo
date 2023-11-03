<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Request for Foreign Exchange (SI) Form, Customer Side.

Copyright (c) 2000-2010 Misys (http://www.misys.com),
All Rights Reserved. 

##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="localization defaultresource">

	<!-- Global Parameters. These are used in the imported XSL, and to set global 
		params in the JS -->
	<xsl:param name="rundata" />
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> 
	<!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param>
	<!-- set to none, counterparty or bank, depending on whether we are in a 
	collab summary screen -->
	<xsl:param name="product-code">FX</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath" /><xsl:value-of select="$servletPath" />/screen/ForeignExchangeScreen</xsl:param>
	
	<!-- Opics Specific, Standing Instructions -->
	<xsl:param name="fx_si"/>
	<xsl:param name="rec_id"/>
	
	<!-- Global Imports. -->
	<xsl:include href="../../core/xsl/common/trade_common.xsl" />
	<xsl:include href="cash_common.xsl" />
	<xsl:include href="../../cash/xsl/request_common.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />

	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/">
		<xsl:apply-templates select="fx_tnx_record" />
	</xsl:template>

	<!-- SI TNX FORM TEMPLATE. -->
	<xsl:template match="fx_tnx_record">
		<!-- Preloader -->
		<xsl:call-template name="loading-message" />
		<xsl:call-template name="clearing-code-loader" />
		<div >
			<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>

			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name" />
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
					<!-- Display common menu. -->
					<xsl:call-template name="menu">
						<xsl:with-param name="show-save">Y</xsl:with-param>
						<xsl:with-param name="show-submit">Y</xsl:with-param>
						<xsl:with-param name="show-template">N</xsl:with-param>
						<xsl:with-param name="show-return">Y</xsl:with-param>
						<xsl:with-param name="add-button-begin">
				      		<xsl:call-template name="button-wrapper">
						        <xsl:with-param name="label">XSL_ACTION_SUBMIT</xsl:with-param>
						        <xsl:with-param name="id">submitButton1_FX</xsl:with-param>
						        <xsl:with-param name="show-text-label">Y</xsl:with-param>
						        <xsl:with-param name="onclick">misys.submit('SUBMIT');return false;</xsl:with-param>
					       </xsl:call-template>
					    </xsl:with-param>
					</xsl:call-template>

					<!-- Disclaimer Notice -->
					<xsl:call-template name="disclaimer" />

					<xsl:apply-templates select="cross_references" mode="hidden_form" />
					<xsl:call-template name="hidden-fields" />
					<xsl:call-template name="general-details" />

					<!-- FX Details. -->
					<xsl:call-template name="standing-instructions" />
					<xsl:call-template name="loading-Dialog"/>
					
					<!-- Reauthentication -->
				<xsl:call-template name="reauthentication" />
					<xsl:call-template name="reauth_params"/>					
					
		 <!-- comments for return -->
    	  <xsl:call-template name="comments-for-return">
	 	 		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   			<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   		  </xsl:call-template>
		
				</xsl:with-param>
			</xsl:call-template>

			<!-- Form #1 : Attach Files -->
			<!-- <xsl:call-template name="attachments-file-dojo"/> -->

			<xsl:call-template name="realform" />

			<xsl:call-template name="menu">
				<xsl:with-param name="show-save">Y</xsl:with-param>
				<xsl:with-param name="show-submit">Y</xsl:with-param>
				<xsl:with-param name="show-template">N</xsl:with-param>
				<xsl:with-param name="second-menu">Y</xsl:with-param>
				<xsl:with-param name="show-return">Y</xsl:with-param>
			</xsl:call-template>
		</div>

		<!-- Table of Contents -->
		<xsl:call-template name="toc" />

		<!-- Collaboration Window -->
		<!-- <xsl:call-template name="collaboration"> <xsl:with-param name="editable">true</xsl:with-param> 
			<xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param> 
			<xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
			<xsl:with-param name="bank_name_widget_id"></xsl:with-param>
			<xsl:with-param name="bank_abbv_name_widget_id"></xsl:with-param> 
			</xsl:call-template> -->

		<!-- Javascript imports -->
		<xsl:call-template name="js-imports" />
	</xsl:template>

	<!-- -->
	<!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
	<!-- -->
	<xsl:template name="general-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="common-general-details">
					<xsl:with-param name="show-template-id">N</xsl:with-param>
					<xsl:with-param name="show-cust-ref-id">N</xsl:with-param>
					<xsl:with-param name="show-bo-ref-id">N</xsl:with-param>
					<xsl:with-param name="show-bo-tnx-id">Y</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="$mode='DRAFT'">
				<xsl:call-template name="input-field">
			    	<xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
			    	<xsl:with-param name="value" select="bo_ref_id" />
			    	<xsl:with-param name="override-displaymode">view</xsl:with-param>
			    </xsl:call-template>
			    </xsl:if>
			    <xsl:call-template name="input-field">
			    	<xsl:with-param name="label">XSL_GENERALDETAILS_BO_TNX_ID</xsl:with-param>
			    	<xsl:with-param name="value" select="bo_tnx_id" />
			    	<xsl:with-param name="override-displaymode">view</xsl:with-param>
			    </xsl:call-template>
			    <xsl:call-template name="input-field">
			    	<xsl:with-param name="label">XSL_FX_TRADE_ID_LABEL</xsl:with-param>
			    	<xsl:with-param name="value" select="trade_id" />
			    	<xsl:with-param name="override-displaymode">view</xsl:with-param>
			    </xsl:call-template>
			    
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_AMOUNT_LABEL</xsl:with-param>
					<xsl:with-param name="value" select="normalize-space(concat(fx_cur_code, ' ',tnx_amt))" />
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
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
							<xsl:with-param name="value" select="normalize-space(concat(counter_cur_code, ' ',near_counter_amt))" />
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CONTRACT_FX_RECEIVING_FAR_COUNTER_AMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="value" select="normalize-space(concat(counter_cur_code, ' ',counter_amt))" />
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>	
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CONTRACT_FX_SETTLEMENT_AMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="value" select="normalize-space(concat(counter_cur_code, ' ',tnx_counter_amt))" />
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="sub_product_code[.!='SWAP']">			
						<xsl:choose>
							<xsl:when test="org_previous_file/fx_tnx_record/sub_tnx_type_code[.='31']">
								<xsl:if test="takedown_value_date[. != '']">
									<xsl:call-template name="input-field">
										<xsl:with-param name="label">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:with-param>
										<xsl:with-param name="value" select="takedown_value_date" />
										<xsl:with-param name="override-displaymode">view</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:with-param>
									<xsl:with-param name="value" select="value_date" />
									<xsl:with-param name="override-displaymode">view</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
				
				<xsl:if test="sub_product_code[.!='SWAP']">			
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">ENTITY_LABEL</xsl:with-param>
						<xsl:with-param name="value" select="normalize-space(org_previous_file/fx_tnx_record/entity)" />
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>	
				</xsl:if>
				
				<xsl:if test="product_code[.='TD']">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_CONTRACT_FX_SETTLEMENT_DATE_LABEL</xsl:with-param>
					<xsl:with-param name="value" select="maturity_date" />
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
			    <xsl:call-template name="hidden-field">
					<xsl:with-param name="name">sub_product_code</xsl:with-param>
					<xsl:with-param name="value" select="sub_product_code"/>
			    </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="standing-instructions">
		<xsl:call-template name="scriptJSForGrid"/>
		<!-- Near fields for swap -->
		<xsl:choose>
		<xsl:when test="sub_product_code[.='SWAP']">
			<xsl:call-template name="customer-instruction">
				<xsl:with-param name="legend">XSL_SI_NEAR_CUSTOMER_INSTRUCTION</xsl:with-param>
				<xsl:with-param name="prefix">near</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="si-bank-instructions">
				<xsl:with-param name="legend">XSL_SI_NEAR_BANK_INSTRUCTION</xsl:with-param>
				<xsl:with-param name="prefix">near</xsl:with-param>
				<xsl:with-param name="amt">near_amt</xsl:with-param>
				<xsl:with-param name="cur_code">fx_cur_code</xsl:with-param>
				<xsl:with-param name="beneficiary-cur-code">
					<xsl:choose>
						<xsl:when test="contract_type[.='01']">fx_cur_code</xsl:when>
						<xsl:when test="contract_type[.='02']">counter_cur_code</xsl:when>
						<xsl:otherwise>fx_cur_code</xsl:otherwise>
					</xsl:choose>
					</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		</xsl:choose>
		<!-- regular standing instructions fields -->
		<!-- customer instruction -->
		<xsl:call-template name="customer-instruction">
			<xsl:with-param name="legend">
				<xsl:choose>
					<xsl:when test="sub_product_code[.='SWAP']">XSL_SI_FAR_CUSTOMER_INSTRUCTION</xsl:when>
					<xsl:otherwise>XSL_SI_CUSTOMER_INSTRUCTION</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		
		<!-- bank instruction -->
		<xsl:choose>
			<xsl:when test="sub_product_code[.='SWAP']">
				<xsl:call-template name="si-bank-instructions">
					<xsl:with-param name="legend">XSL_SI_FAR_BANK_INSTRUCTION</xsl:with-param>
					<!-- Far value contain in fx_amt and fx_cur_code -->
					<xsl:with-param name="amt">counter_amt</xsl:with-param>
					<xsl:with-param name="cur_code">counter_cur_code</xsl:with-param>
					<xsl:with-param name="beneficiary-cur-code">fx_cur_code</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="si-bank-instructions">
					<xsl:with-param name="legend">XSL_SI_BANK_INSTRUCTION</xsl:with-param>
					<xsl:with-param name="amt">fx_amt</xsl:with-param>
					<xsl:with-param name="cur_code">fx_cur_code</xsl:with-param>
					<xsl:with-param name="beneficiary-cur-code">
					<xsl:choose>
						<xsl:when test="contract_type[.='01']">fx_cur_code</xsl:when>
						<xsl:when test="contract_type[.='02']">counter_cur_code</xsl:when>
						<xsl:otherwise>fx_cur_code</xsl:otherwise>
					</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="override-displaymode">
						<xsl:choose>
							<xsl:when test="$mode = 'DRAFT'">edit</xsl:when>
							<xsl:otherwise>view</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:call-template name="fx-si-hidden-fields"/>
	</xsl:template>

	<xsl:template name="scriptJSForGrid">
		<script>
			dojo.ready(function(){
				misys._config = misys._config || {};
				dojo.mixin(misys._config,  {
					fx_si : <xsl:value-of select="$fx_si"/>
				});
			});
		</script>
	</xsl:template>

	<xsl:template name="fx-si-hidden-fields">
	 <div class="widgetContainer">
	 <!-- The beneficiary popup uses this value to filter the beneficiation available for based on the entity selected		 -->
		<xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">entity</xsl:with-param>
	      <xsl:with-param name="value" select="normalize-space(org_previous_file/fx_tnx_record/entity)"/>
	    </xsl:call-template>
	    
	    <xsl:if test="sub_product_code[.='SWAP']">
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">near_payment_instructions_id</xsl:with-param>
				<xsl:with-param name="value" select="near_payment_instructions_id" />
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">near_receipt_instructions_id</xsl:with-param>
				<xsl:with-param name="value" select="near_receipt_instructions_id" />
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
		    	<xsl:with-param name="name">near_bank_instruction_indicator</xsl:with-param>
		     	<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator"/>
	    	</xsl:call-template>
	        <xsl:call-template name="hidden-field">
		    	<xsl:with-param name="name">near_customer_instruction_indicator</xsl:with-param>
		     	<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='03']/cpty_instruction_indicator"/>
		    </xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">far_payment_instructions_id</xsl:with-param>
				<xsl:with-param name="value" select="far_payment_instructions_id" />
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">far_receipt_instructions_id</xsl:with-param>
				<xsl:with-param name="value" select="far_receipt_instructions_id" />
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
		    	<xsl:with-param name="name">far_bank_instruction_indicator</xsl:with-param>
		     	<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator"/>
	    	</xsl:call-template>
	        <xsl:call-template name="hidden-field">
		    	<xsl:with-param name="name">far_customer_instruction_indicator</xsl:with-param>
		     	<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='03']/cpty_instruction_indicator"/>
		    </xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">near_payment_completed_indicator</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="NEAR_PAYMENT_COMPLETED_INDICATOR"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">near_receipt_completed_indicator</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="NEAR_PAYMENT_COMPLETED_INDICATOR"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">far_payment_completed_indicator</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="FAR_PAYMENT_COMPLETED_INDICATOR"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">far_receipt_completed_indicator</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="FAR_PAYMENT_COMPLETED_INDICATOR"/></xsl:with-param>
			</xsl:call-template> 			    
		</xsl:if>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">near_payment_instructions_id</xsl:with-param>
			<xsl:with-param name="value" />
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">near_receipt_instructions_id</xsl:with-param>
			<xsl:with-param name="value" />
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">receipt_instructions_id</xsl:with-param>
			<xsl:with-param name="value" select="receipt_instructions_id"/>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">payment_instructions_id</xsl:with-param>
			<xsl:with-param name="value" select="payment_instructions_id"/>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
	    	<xsl:with-param name="name">bank_instruction_indicator</xsl:with-param>
	     	<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator"/>
	    </xsl:call-template>
	    <xsl:call-template name="hidden-field">
	    	<xsl:with-param name="name">customer_instruction_indicator</xsl:with-param>
	     	<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='03']/cpty_instruction_indicator"/>
	    </xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">payment_completed_indicator</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="PAYMENT_COMPLETED_INDICATOR"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">receipt_completed_indicator</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="RECEIPT_COMPLETED_INDICATOR"/></xsl:with-param>
		</xsl:call-template>
	 	<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">rec_id</xsl:with-param>
			<xsl:with-param name="value" select="$rec_id" />
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">fx_amt</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">counter_amt</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">original_amt</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">original_counter_amt</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">tnx_cur_code</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">tnx_counter_amt</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">fx_cur_code</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">counter_cur_code</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">maturity_date</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">value_date</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">option_date</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">takedown_value_date</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">near_date</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">ctrps</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">bo_tnx_id</xsl:with-param>
		</xsl:call-template>
	     <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">issuing_bank_name</xsl:with-param>
			<xsl:with-param name="value" select="issuing_bank/name"/>
        </xsl:call-template>
        <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
			<xsl:with-param name="value" select="issuing_bank/abbv_name"/>
          </xsl:call-template>
	 </div>
	</xsl:template>
	
	<!-- Additional JS imports for this form are -->
	<!-- added here. --> 
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.cash.message_si_fx</xsl:with-param>
			<xsl:with-param name="override-help-access-key">FX_02</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Additional hidden fields for this form are -->
	<!-- added here. -->
	<xsl:template name="hidden-fields">
	<xsl:variable name="swift_flag" select="defaultresource:getResource('OPICS_SWIFT_ENABLED')='true'"/>
		<xsl:call-template name="common-hidden-fields">
			<xsl:with-param name="show-type">N</xsl:with-param>
			<xsl:with-param name="additional-fields">
		        <!-- TEMP FIX : TO REDO 
		        	Issue on release of a deal with counterparties getting cleared:
		        	Solution : 1/ not send anything but ref_id and tnx_id
		        			   2/ the transactionData should look like the one on "Edit Transaction" page
		        -->
		        <xsl:call-template name="hidden-field">
		            <xsl:with-param name="name">fx_mode</xsl:with-param>
					<xsl:with-param name="value" select="$mode"/>
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
		            <xsl:with-param name="name">customer_counterparty_id</xsl:with-param>
					<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='03']/counterparty_id"/>
		        </xsl:call-template>
		        <xsl:call-template name="hidden-field">
		            <xsl:with-param name="name">bank_counterparty_id</xsl:with-param>
					<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/counterparty_id"/>
		        </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Hidden fields for Request for Financing -->
	<xsl:template name="realform">
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name">realform</xsl:with-param>
			<xsl:with-param name="method">POST</xsl:with-param>
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
				       <xsl:with-param name="name">productcode</xsl:with-param>
				       <xsl:with-param name="value" select="$product-code" />
				    </xsl:call-template> 		    
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">tnxtype</xsl:with-param>
						<xsl:with-param name="value">13</xsl:with-param>
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
						<xsl:with-param name="value" >STANDING_INSTRUCTIONS</xsl:with-param>
					</xsl:call-template>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
</xsl:stylesheet>