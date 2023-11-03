<?xml version="1.0" encoding="UTF-8"?>
<!-- 
##########################################################
Templates for Request for Treasury Term Deposit Form, Customer Side.
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
	  <xsl:param name="rundata"/>
	  <xsl:param name="option"/>    
	  <xsl:param name="language">en</xsl:param>
	  <xsl:param name="mode">DRAFT</xsl:param>
	  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	  <xsl:param name="product-code">TD</xsl:param>
	  <xsl:param name="sub-product-code">TRTD</xsl:param> 
	  <xsl:param name="main-form-name">fakeform1</xsl:param>
	  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TreasuryTermDepositScreen</xsl:param> 	
 	
 	<!-- Global Imports. -->
 	
 	
 	<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
  	<xsl:include href="../../core/xsl/common/trade_common.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
	<xsl:include href="../../cash/xsl/cash_common.xsl" />
	<xsl:include href="../../cash/xsl/request_common.xsl" />
	<xsl:include href="../../cash/xsl/fx_common.xsl" />
  	
  	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
 	<xsl:template match="/">
    	<xsl:apply-templates select="td_tnx_record"/>
    </xsl:template>
	 
  	<!--  FX TNX FORM TEMPLATE.  -->
	
	<xsl:template match="td_tnx_record">
   
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
  
   <div>
		    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
		
		    <!-- Form #0 : Main Form -->
		    <xsl:call-template name="form-wrapper">
		     <xsl:with-param name="name" select="$main-form-name"/>
		     <xsl:with-param name="validating">Y</xsl:with-param>
		     <xsl:with-param name="content">
		      <!--  Display common menu. -->
		      <xsl:call-template name="menu">
		       <xsl:with-param name="show-save">N</xsl:with-param>
		       <xsl:with-param name="show-submit">N</xsl:with-param>
		       <xsl:with-param name="show-template">N</xsl:with-param>
		      </xsl:call-template>
		      
		      <!-- Disclaimer Notice -->
		      <xsl:call-template name="disclaimer"/>
		     
		      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
		      <xsl:call-template name="hidden-fields"/>
		
		      <xsl:call-template name="fx-general-details" />
		      <xsl:call-template name="bank-details"/>
		      
		      <!-- Customer Payment Details and Bank Detail (Settlement Detail In View Mode) --> 
			<xsl:call-template name="customer_and_bank_instruction_view" />
			
			<!-- Return comments -->
			<xsl:call-template name="comments-for-return">
			<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
			<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
			</xsl:call-template>
		     
		      <!-- request Details. -->
		      <xsl:call-template name="td-details"/>
		      
		      <!-- response Details. -->
			<xsl:if test="$displaymode != 'view' or ($displaymode = 'view' and (not(tnx_id) or tnx_type_code!='13'))"> 
				<xsl:call-template name="TD-trade-details"/>
			</xsl:if>
		   			
		   		<xsl:call-template name="reauthentication" />
				<xsl:call-template name="e2ee_transaction"/>
				<xsl:call-template name="reauth_params"/>
		
			<!-- WAITING POPUPS -->
			<xsl:call-template name="waiting-Dialog"/>
			<xsl:call-template name="loading-Dialog"/>
			
		     </xsl:with-param>
		    </xsl:call-template>
		
			
		    <xsl:call-template name="realform"/>
		
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

	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
   			<xsl:with-param name="binding">misys.binding.treasury.create_td_trtd</xsl:with-param>
   			<xsl:with-param name="override-help-access-key">TRTD_01</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
		
	
		<!-- Additional hidden fields for this form are  -->
 
 		 <xsl:template name="hidden-fields">
		  <xsl:call-template name="common-hidden-fields">
		    <xsl:with-param name="show-type">N</xsl:with-param>
		    <xsl:with-param name="additional-fields">
		     <xsl:call-template name="hidden-field">
			  <xsl:with-param name="name">td_type</xsl:with-param>
		     </xsl:call-template>
		     <xsl:call-template name="hidden-field">
	    				<xsl:with-param name="name">product_type</xsl:with-param>
	    				<xsl:with-param name="value">TRSRY</xsl:with-param>
	   			</xsl:call-template>
		     <xsl:call-template name="hidden-field">
	    			<xsl:with-param name="name">sub_product_code</xsl:with-param>
	    			<xsl:with-param name="value">TRTD</xsl:with-param>
	   			</xsl:call-template>
		    </xsl:with-param> 
		  </xsl:call-template>
		 </xsl:template>
		
		<!-- TD General Details -->
		  <xsl:template name="td-details">
			<xsl:if test="$displaymode='edit'">
		 	 <div id="request-details">
					<xsl:attribute name="style">display:block</xsl:attribute>
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_HEADER_REQUEST_FOR_DEPOSIT_DETAILS</xsl:with-param>
						<xsl:with-param name="content"> 
							<xsl:call-template name="currency-field">
							    <xsl:with-param name="label">XSL_TD_AMOUNT_LABEL</xsl:with-param>
							    <xsl:with-param name="product-code">input_td</xsl:with-param>
							    <xsl:with-param name="override-currency-value"><xsl:value-of select="td_cur_code"/></xsl:with-param>
						     	<xsl:with-param name="override-amt-value"><xsl:value-of select="td_amt"/></xsl:with-param>
							    <xsl:with-param name="required">Y</xsl:with-param>
						   	</xsl:call-template>
						   	
						   	<!-- Start Date -->
							<xsl:call-template name="input-date-or-term-field">
							        <xsl:with-param name="label">XSL_TD_START_DATE</xsl:with-param>
									<xsl:with-param name="name">input_value</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="term-options">							
										<xsl:call-template name="code-data-options">
											<xsl:with-param name="paramId">C043</xsl:with-param>
											<xsl:with-param name="productCode">TD</xsl:with-param>
											<xsl:with-param name="specificOrder">Y</xsl:with-param>
										</xsl:call-template>
									</xsl:with-param>
									<xsl:with-param name="static-options">
									 	<xsl:call-template name="code-data-options">
											 <xsl:with-param name="paramId">C044</xsl:with-param>
											 <xsl:with-param name="productCode">TD</xsl:with-param>
											 <xsl:with-param name="specificOrder">Y</xsl:with-param>
										</xsl:call-template>
									</xsl:with-param>
								    <xsl:with-param name="date">
										<xsl:choose>
											<xsl:when test="request_value_term_number[.!='']"><xsl:value-of select="request_value_term_number"/></xsl:when>
											<xsl:otherwise><xsl:value-of select="request"/></xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>
									<xsl:with-param name="code">
										<xsl:choose>
											<xsl:when test="request_value_term_code[.!='']"><xsl:value-of select="request_value_term_code"/></xsl:when>
										</xsl:choose>
									</xsl:with-param>
			   				 </xsl:call-template>
							

							<!-- Maturity Date -->
		    			<xsl:call-template name="input-date-or-term-field">
							        <xsl:with-param name="label">XSL_TD_MATURITY_DATE_LABEL</xsl:with-param>
									<xsl:with-param name="name">input_maturity</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="term-options">							
										<xsl:call-template name="code-data-options">
											<xsl:with-param name="paramId">C045</xsl:with-param>
											<xsl:with-param name="productCode">TD</xsl:with-param>
											<xsl:with-param name="specificOrder">Y</xsl:with-param>
										</xsl:call-template>
									</xsl:with-param>
								    <xsl:with-param name="date">
										<xsl:choose>
											<xsl:when test="request_value_term_number[.!='']"><xsl:value-of select="request_value_term_number"/></xsl:when>
											<xsl:otherwise><xsl:value-of select="request"/></xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>
									<xsl:with-param name="code">
										<xsl:choose>
											<xsl:when test="request_value_term_code[.!='']"><xsl:value-of select="request_value_term_code"/></xsl:when>
										</xsl:choose>
									</xsl:with-param>
			   				 </xsl:call-template>

						  <!--remarks-->
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_TD_REMARKS</xsl:with-param>
						   		<xsl:with-param name="name">remarks</xsl:with-param>
						   		<xsl:with-param name="maxsize">70</xsl:with-param>
							</xsl:call-template> 				
						 	<xsl:call-template name="request-button"/>
						</xsl:with-param>
					</xsl:call-template>
			</div>
			</xsl:if>
		  </xsl:template>
		
	<xsl:template name="TD-trade-details">
		<xsl:call-template name="trade-details">
			<xsl:with-param name="content">
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">trade_id_report</xsl:with-param>
					<xsl:with-param name="label">XSL_TD_TRADE_ID_LABEL</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">fncPerformRequest</xsl:when>
							<xsl:otherwise><xsl:value-of select="trade_id"/></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">trade_id</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">rec_id</xsl:with-param>
				</xsl:call-template>
				
				<xsl:if test="$displaymode='view'">
					<xsl:call-template name="currency-field">
					    <xsl:with-param name="label">XSL_TD_AMOUNT_LABEL</xsl:with-param>
					    <xsl:with-param name="product-code">input_td</xsl:with-param>
					    <xsl:with-param name="override-currency-value"><xsl:value-of select="td_cur_code"/></xsl:with-param>
				     	<xsl:with-param name="override-amt-value"><xsl:value-of select="td_amt"/></xsl:with-param>
					    <xsl:with-param name="required">Y</xsl:with-param>
				   	</xsl:call-template>
			   	</xsl:if>
				
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">value_date_report</xsl:with-param>
					<xsl:with-param name="label">XSL_TD_START_DATE</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">fncPerformRequest</xsl:when>
							<xsl:otherwise><xsl:value-of select="value_date"/></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">maturity_date_report</xsl:with-param>
					<xsl:with-param name="label">XSL_TD_MATURITY_DATE_LABEL</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">fncPerformRequest</xsl:when>
							<xsl:otherwise><xsl:value-of select="maturity_date"/></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">rate_report</xsl:with-param>
					<xsl:with-param name="label">LOAN_INTEREST_RATE</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="type">ratenumber</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">fncPerformRequest</xsl:when>
							<xsl:otherwise><xsl:value-of select="rate"/></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="appendClass">strong_rate</xsl:with-param>
				</xsl:call-template>
				
				<xsl:if test="$displaymode='view'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">interest_capitalisation</xsl:with-param>
						<xsl:with-param name="label">XSL_TD_INTEREST_CAPITALISATION_LABEL</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">interest_report</xsl:with-param>
					<xsl:with-param name="label">XSL_INTEREST_AMOUNT</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">fncPerformRequest</xsl:when>
							<xsl:otherwise><xsl:value-of select="interest"/></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				
				<xsl:if test="$displaymode='view'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">total_with_interest</xsl:with-param>
						<xsl:with-param name="label">XSL_TD_TOTAL_WITH_INTEREST_LABEL</xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">remarks</xsl:with-param>
						<xsl:with-param name="label">XSL_TD_REMARKS_LABEL</xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">reversal_reason</xsl:with-param>
						<xsl:with-param name="label">XSL_TD_CANCEL_REASON_LABEL</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$displaymode!='view'">
					<div id="traderRemarksContainer">
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">trader_remarks_report</xsl:with-param>
							<xsl:with-param name="label">XSL_TD_REMARKS</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="$displaymode='edit'">fncPerformRequest</xsl:when>
									<xsl:otherwise><xsl:value-of select="trader_remarks"/></xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</div>
				</xsl:if>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">trader_remarks</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">td_cur_code</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">td_amt</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">rate</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">value_date</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">maturity_date</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">interest</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
			</xsl:call-template>
</xsl:template>
		
		   <!-- Hidden fields   -->
		  <xsl:template name="realform">
			   <xsl:call-template name="form-wrapper">
			    <xsl:with-param name="name">realform</xsl:with-param>
			    <xsl:with-param name="method">POST</xsl:with-param>
			    <xsl:with-param name="action" select="$realform-action"/>
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
						      <xsl:with-param name="value" select="$mode"/>
					     </xsl:call-template>
					     <xsl:call-template name="hidden-field">
						      <xsl:with-param name="name">tnxtype</xsl:with-param>
						      <xsl:with-param name="value">01</xsl:with-param>
					     </xsl:call-template>
					     <xsl:call-template name="hidden-field">
						      <xsl:with-param name="name">attIds</xsl:with-param>
						      <xsl:with-param name="value"/>
					     </xsl:call-template>
					     <xsl:call-template name="hidden-field">
						      <xsl:with-param name="name">TransactionData</xsl:with-param>
						      <xsl:with-param name="value"/>
					     </xsl:call-template>
					     <xsl:call-template name="hidden-field">
						      <xsl:with-param name="name">option</xsl:with-param>
						      <xsl:with-param name="value"/>
					     </xsl:call-template>
					     <xsl:call-template name="hidden-field">
							  <xsl:with-param name="name">productcode</xsl:with-param>
							  <xsl:with-param name="value" select="$product-code" />
						 </xsl:call-template>
						 <xsl:call-template name="hidden-field">
						 	  <xsl:with-param name="name">subproductcode</xsl:with-param>
							  <xsl:with-param name="value" select="$sub-product-code" />
						 </xsl:call-template>
				     </div>
				    </xsl:with-param>
			   </xsl:call-template>
		  </xsl:template>
</xsl:stylesheet>
