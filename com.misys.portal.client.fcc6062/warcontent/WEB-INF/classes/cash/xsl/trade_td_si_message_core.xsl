<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Request for TermDeposit Standing Instruction (TD) Form, Customer Side.

Copyright (c) 2000-2010 Misys (http://www.misys.com),
All Rights Reserved. 

##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	exclude-result-prefixes="localization">

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
	<xsl:param name="product-code">TD</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath" /><xsl:value-of select="$servletPath" />/screen/TermDepositScreen</xsl:param>
	
	<!-- Opics Specific, Standing Instructions -->
	<xsl:param name="td_si"/>
	
	<!-- Global Imports. -->
	<xsl:include href="../../core/xsl/common/trade_common.xsl" />
	<xsl:include href="cash_common.xsl" />
	
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/">
		<xsl:apply-templates select="td_tnx_record" />
	</xsl:template>

	<!-- SI TNX FORM TEMPLATE. -->
	<xsl:template match="td_tnx_record">
		<!-- Preloader -->
		<xsl:call-template name="loading-message" />

		<div >
			<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>

			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name" />
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
					<!-- Display common menu. -->
					<xsl:call-template name="menu">
						<xsl:with-param name="show-save">N</xsl:with-param>
						<xsl:with-param name="show-submit">Y</xsl:with-param>
						<xsl:with-param name="show-template">N</xsl:with-param>
					</xsl:call-template>

					<!-- Disclaimer Notice -->
					<xsl:call-template name="disclaimer" />

					<xsl:apply-templates select="cross_references" mode="hidden_form" />
					<xsl:call-template name="hidden-fields" />
					<xsl:call-template name="general-details" />

					<!-- FX Details. -->
					<xsl:call-template name="standing-instructions" />
		
				</xsl:with-param>
			</xsl:call-template>

			<!-- Form #1 : Attach Files -->
			<!-- <xsl:call-template name="attachments-file-dojo"/> -->

			<xsl:call-template name="realform" />

			<xsl:call-template name="menu">
				<xsl:with-param name="show-save">N</xsl:with-param>
				<xsl:with-param name="show-submit">Y</xsl:with-param>
				<xsl:with-param name="show-template">N</xsl:with-param>
				<xsl:with-param name="second-menu">Y</xsl:with-param>
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
				</xsl:call-template>
			 <!--  System ID. -->
     
	     <xsl:call-template name="input-field">
	      <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
	      <xsl:with-param name="value" select="ref_id" />
	      <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     </xsl:call-template>
	     
		  <xsl:call-template name="input-field">
		   <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
		   <xsl:with-param name="value" select="bo_ref_id" />
		   <xsl:with-param name="override-displaymode">view</xsl:with-param>
		  </xsl:call-template>
	     
	     <xsl:if test="cust_ref_id[.!='']">
	      <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
	       <xsl:with-param name="value" select="cust_ref_id" />
	       <xsl:with-param name="override-displaymode">view</xsl:with-param>
	      </xsl:call-template>
	     </xsl:if>
	     
	     <xsl:if test="trade_id[.!='']">
	      <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_TD_TRADE_ID_LABEL</xsl:with-param>
	       <xsl:with-param name="value" select="trade_id" />
	       <xsl:with-param name="override-displaymode">view</xsl:with-param>
	      </xsl:call-template>
	     </xsl:if>
	     
	     <xsl:if test="td_type[.!=''] and td_type[.!='SCRATCH'] ">
	      <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_TD_TYPE_LABEL</xsl:with-param>
	       <xsl:with-param name="value" select="td_type" />
	       <xsl:with-param name="override-displaymode">view</xsl:with-param>
	      </xsl:call-template>
	     </xsl:if>
	     
	      	<!-- old amount -->
		   	<xsl:call-template name="currency-field">
		      <xsl:with-param name="label">XSL_TD_AMOUNT_LABEL</xsl:with-param>
		      <xsl:with-param name="product-code">td</xsl:with-param>
		      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
		      <xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
		      <xsl:with-param name="override-amt-name">td_amt</xsl:with-param>
		      <xsl:with-param name="override-amt-value"><xsl:value-of select="td_amt"/></xsl:with-param>
		     </xsl:call-template>
		
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">td_cur_code</xsl:with-param>
		      </xsl:call-template>
		      
	     	<!-- original start date -->
			 <xsl:call-template name="input-field">
		      <xsl:with-param name="label">XSL_TD_VALUE_DATE_LABEL</xsl:with-param>
		      <xsl:with-param name="name">value_date</xsl:with-param>
		      <xsl:with-param name="value" select="value_date" />
		      <xsl:with-param name="override-displaymode">view</xsl:with-param>
		     </xsl:call-template>
		     
		     <!--original maturity date -->
			 <xsl:call-template name="input-field">
		      <xsl:with-param name="label">XSL_TD_MATURITY_DATE_LABEL</xsl:with-param>
		      <xsl:with-param name="name">maturity_date</xsl:with-param>
		      <xsl:with-param name="value" select="maturity_date" />
		      <xsl:with-param name="override-displaymode">view</xsl:with-param>
		     </xsl:call-template>
	     
	    	 <!-- interest label -->
		  	  <xsl:call-template name="currency-field">
			      <xsl:with-param name="label">XSL_TD_INTEREST_LABEL</xsl:with-param>
			      <xsl:with-param name="product-code">td</xsl:with-param>
			      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
			      <xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
			      <xsl:with-param name="override-amt-value"><xsl:value-of select="interest"/></xsl:with-param>
			      <xsl:with-param name="override-amt-name">interest_td</xsl:with-param>
		 	  </xsl:call-template>
		 	  
		   <!-- new total amount with interest -->
		   	 <xsl:call-template name="currency-field">
		      <xsl:with-param name="label">XSL_TD_TOTAL_WITH_INTEREST_LABEL</xsl:with-param>
		      <xsl:with-param name="product-code">td</xsl:with-param>
		      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
		      <xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
		      <xsl:with-param name="override-amt-value"><xsl:value-of select="total_with_interest"/></xsl:with-param>
		      <xsl:with-param name="override-amt-name">total_with_interest</xsl:with-param>
		  	 </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="standing-instructions">
		<xsl:call-template name="scriptJSForGrid"/>
		<xsl:call-template name="customer-instruction">
			<xsl:with-param name="legend">XSL_SI_CUSTOMER_INSTRUCTION</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="si-bank-instructions">
			<xsl:with-param name="legend">XSL_SI_BANK_INSTRUCTION</xsl:with-param>
			<xsl:with-param name="amt">td_amt</xsl:with-param>
			<xsl:with-param name="cur_code">td_cur_code</xsl:with-param>
		</xsl:call-template>
		<xsl:if test="org_previous_file/td_tnx_record/sub_tnx_type_code[.='26']">
			<!-- Customer far instruction -->
			<xsl:call-template name="customer-instruction">
				<xsl:with-param name="prefix">near</xsl:with-param>
				<xsl:with-param name="legend">XSL_SI_FAR_CUSTOMER_INSTRUCTION</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		
		<xsl:if test="org_previous_file/td_tnx_record/sub_tnx_type_code[.='27']">
			<!-- bank far instruction -->
			<xsl:call-template name="si-bank-instructions">
				<xsl:with-param name="prefix">near</xsl:with-param>
				<xsl:with-param name="legend">XSL_SI_FAR_BANK_INSTRUCTION</xsl:with-param>
				<xsl:with-param name="amt"><xsl:value-of select="org_previous_file/td_tnx_record/tnx_amt"/></xsl:with-param>
				<xsl:with-param name="cur_code">td_cur_code</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
<!--		<xsl:if test="org_previous_file/td_tnx_record/sub_tnx_type_code[.!='27']">-->
<!--			<xsl:if test="org_previous_file/td_tnx_record/interest_capitalisation[.='N']">-->
<!--			<xsl:call-template name="si-bank-instructions">-->
<!--				<xsl:with-param name="prefix">near</xsl:with-param>-->
<!--				<xsl:with-param name="legend">XSL_SI_FAR_BANK_INSTRUCTION</xsl:with-param>-->
<!--				<xsl:with-param name="amt">interest</xsl:with-param>-->
<!--				<xsl:with-param name="cur_code">td_cur_code</xsl:with-param>-->
<!--			</xsl:call-template>-->
<!--			</xsl:if>-->
<!--		</xsl:if>-->
		
		<xsl:call-template name="td-si-hidden-fields"/>
	</xsl:template>
	
	<xsl:template name="scriptJSForGrid">
		<script>
			dojo.ready(function(){
				misys._config = misys._config || {};
				dojo.mixin(misys._config,  {
					td_si : <xsl:value-of select="$td_si"/>
				});
			});
		</script>
	</xsl:template>

	<xsl:template name="td-si-hidden-fields">
	 <div class="widgetContainer">
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">receipt_instructions_id</xsl:with-param>
			<xsl:with-param name="value" />
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">payment_instructions_id</xsl:with-param>
			<xsl:with-param name="value" />
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">rec_id</xsl:with-param>
			<xsl:with-param name="value" />
		</xsl:call-template>
		
		
    	<xsl:call-template name="hidden-field">
	     	<xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
	     	<xsl:with-param name="value"><xsl:value-of select="org_previous_file/td_tnx_record/sub_tnx_type_code"/></xsl:with-param>
    	</xsl:call-template>
	 </div>
	</xsl:template>
	
	<!-- Additional JS imports for this form are -->
	<!-- added here. --> 
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.cash.TradeMessageSiTdBinding</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Additional hidden fields for this form are -->
	<!-- added here. -->
	<xsl:template name="hidden-fields">
		<xsl:call-template name="common-hidden-fields">
			<xsl:with-param name="show-type">N</xsl:with-param>
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