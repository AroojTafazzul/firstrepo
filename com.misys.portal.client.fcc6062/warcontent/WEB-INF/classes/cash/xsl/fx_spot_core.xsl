<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to all 

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      10/15/10
author:    Pascal Marzin
email:     Pascal.Marzin@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
  xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
  xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
  exclude-result-prefixes="localization securitycheck utils">
  
  <xsl:template name="fx-spot-details">	
  <xsl:choose>
  <xsl:when test="$displaymode='edit'">
	<div id="request-details" class="widgetContainer">
		<xsl:if test="$displaymode='edit'">
			<xsl:attribute name="style">display:block</xsl:attribute>
		</xsl:if>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_REQUEST_FOR_QUOTE_DETAILS</xsl:with-param>
			<xsl:with-param name="content"> 
				<xsl:call-template name="fx-contract-type-label"/>
				<xsl:choose>
					<xsl:when
						test="securitycheck:hasPermission($rundata,'fx_spot_purchase') and securitycheck:hasPermission($rundata,'fx_spot_sale')">
						<xsl:call-template name="fx-contract-type-option" />
					</xsl:when>
					<xsl:when
						test="not(securitycheck:hasPermission($rundata,'fx_spot_purchase')) and securitycheck:hasPermission($rundata,'fx_spot_sale')">
						<xsl:call-template name="fx-contract-type-sale" />
					</xsl:when>
					<xsl:when
						test="securitycheck:hasPermission($rundata,'fx_spot_purchase') and not(securitycheck:hasPermission($rundata,'fx_spot_sale'))">
						<xsl:call-template name="fx-contract-type-purchase" />
					</xsl:when>
					<xsl:otherwise>
						<!-- show nothing -->
					</xsl:otherwise>
				</xsl:choose>			    
		    
				
				<xsl:call-template name="fx-currencies-fields"/>
				
				
				<xsl:choose>
					<xsl:when
						test="not(securitycheck:hasPermission($rundata,'fx_spot_purchase')) and securitycheck:hasPermission($rundata,'fx_spot_sale')">
						
				<!-- Value Date -->	
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">XSL_VALUE_DATE_FX_LABEL</xsl:with-param>
					<xsl:with-param name="name">input_value_period</xsl:with-param>
					<xsl:with-param name="value">CASH</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
		        <xsl:with-param name="options">
		         <xsl:choose>
				  <xsl:when test="$displaymode='edit'">
					<xsl:call-template name="code-data-options">
					 <xsl:with-param name="paramId">C035</xsl:with-param>
					 <xsl:with-param name="productCode">FX</xsl:with-param>
					 <xsl:with-param name="specificOrder">Y</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
		 		<xsl:call-template name="input-field">
		 		<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="label">XSL_VALUE_DATE_FX_LABEL</xsl:with-param>
					<xsl:with-param name="name">value_date</xsl:with-param>
					<xsl:with-param name="value" select="value_date"/>
				</xsl:call-template>
				</xsl:otherwise>
				 </xsl:choose>
				</xsl:with-param>
				</xsl:call-template>						
						
					</xsl:when>
					<xsl:when
						test="securitycheck:hasPermission($rundata,'fx_spot_purchase') and not(securitycheck:hasPermission($rundata,'fx_spot_sale'))">
				<!-- Value Date -->	
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">XSL_VALUE_DATE_FX_LABEL</xsl:with-param>
					<xsl:with-param name="name">input_value_period</xsl:with-param>
					<xsl:with-param name="value">SPOT</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
		        <xsl:with-param name="options">
		         <xsl:choose>
				  <xsl:when test="$displaymode='edit'">
					<xsl:call-template name="code-data-options">
					 <xsl:with-param name="paramId">C035</xsl:with-param>
					 <xsl:with-param name="productCode">FX</xsl:with-param>
					 <xsl:with-param name="specificOrder">Y</xsl:with-param>
					</xsl:call-template>
				   </xsl:when>
				<xsl:otherwise>
		 		<xsl:call-template name="input-field">
		 		<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="label">XSL_VALUE_DATE_FX_LABEL</xsl:with-param>
					<xsl:with-param name="name">value_date</xsl:with-param>
					<xsl:with-param name="value" select="value_date"/>
				</xsl:call-template>
				</xsl:otherwise>
				 </xsl:choose>
				</xsl:with-param>
				</xsl:call-template>						
						
						
					</xsl:when>
					<xsl:otherwise>
				<!-- Value Date -->	
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">XSL_VALUE_DATE_FX_LABEL</xsl:with-param>
					<xsl:with-param name="name">input_value_period</xsl:with-param>
					<xsl:with-param name="value">SPOT</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
		        <xsl:with-param name="options">
		         <xsl:choose>
				  <xsl:when test="$displaymode='edit'">
					<xsl:call-template name="code-data-options">
					 <xsl:with-param name="paramId">C035</xsl:with-param>
					 <xsl:with-param name="productCode">FX</xsl:with-param>
					 <xsl:with-param name="specificOrder">Y</xsl:with-param>
					</xsl:call-template>
				  </xsl:when>
				<xsl:otherwise>
		 		<xsl:call-template name="input-field">
		 		<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="label">XSL_VALUE_DATE_FX_LABEL</xsl:with-param>
					<xsl:with-param name="name">value_date</xsl:with-param>
					<xsl:with-param name="value" select="value_date"/>
				</xsl:call-template>
				</xsl:otherwise>
				 </xsl:choose>
				</xsl:with-param>
				</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose> 	
				<xsl:if test="securitycheck:hasPermission($rundata,'fx_spot_ddaccount')">
					<xsl:call-template name="user-account-field">
					  	<xsl:with-param name="label">XSL_FX_DEBIT_ACCOUNT_LABEL</xsl:with-param>
					  	<xsl:with-param name="name">cust_payment_account</xsl:with-param>
					    <xsl:with-param name="product_types">FX:SPOT</xsl:with-param>
					    <xsl:with-param name="maxsize">34</xsl:with-param>
					    <xsl:with-param name="required">Y</xsl:with-param>
					    <xsl:with-param name="readonly">Y</xsl:with-param>
					    <xsl:with-param name="show-product-types">N</xsl:with-param>
					    <xsl:with-param name="internal-external-accts">10</xsl:with-param>
					    <xsl:with-param name="account_types">12</xsl:with-param>
					    <xsl:with-param name="entity-field">entity</xsl:with-param>
					    <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_name"/></xsl:with-param>
					    <xsl:with-param name="ccy-code-fields">cust_payment_cur_code</xsl:with-param>
					     <xsl:with-param name="excluded-acct-type">12</xsl:with-param>
					  </xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">counterparty_cur_code</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">cust_payment_cur_code</xsl:with-param>
						<xsl:with-param name="value">USD</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
										
				  <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_FX_REMARKS</xsl:with-param>
				   	<xsl:with-param name="name">remarks</xsl:with-param>
				   	<xsl:with-param name="maxsize">70</xsl:with-param>
				</xsl:call-template>   
				<xsl:call-template name="input-field">
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_CONTRACT_FX_NOT_FOR_PAYMENT')"/>
				</xsl:call-template> 
				<xsl:call-template name="fx-action-button"/>
			</xsl:with-param>
		</xsl:call-template>
	</div>
	<xsl:call-template name="fx-trade-details"/>
	</xsl:when>
	 <xsl:otherwise>
		<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_CONTRACT_DETAILS</xsl:with-param>			
		<xsl:with-param name="content">

				<xsl:call-template name="fx-contract-type-label"/>
			    
				<xsl:choose>
					<xsl:when
						test="securitycheck:hasPermission($rundata,'fx_spot_purchase') and securitycheck:hasPermission($rundata,'fx_spot_sale')">
						<xsl:call-template name="fx-contract-type-option" />
					</xsl:when>
					<xsl:when test="$displaymode='view' and contract_type[.!='']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_TYPE_LABEL</xsl:with-param>
							<xsl:with-param name="name">contract_type</xsl:with-param>
		       				<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="contract_type[.='01']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_PURCHASE_LABEL')"/>
									</xsl:when>
									<xsl:when test="contract_type[.='02']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_SALE_LABEL')"/>
									</xsl:when>
									<xsl:otherwise>
										show nothing
									</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
		    		</xsl:when>
					<xsl:otherwise>
						<!-- show nothing -->
					</xsl:otherwise>
				</xsl:choose>
							
				<xsl:call-template name="currency-field">
				    <xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_REMAINING_AMT</xsl:with-param>
				    <xsl:with-param name="product-code">input_fx</xsl:with-param>
				    <xsl:with-param name="override-currency-value"><xsl:value-of select="fx_cur_code"/></xsl:with-param>
			     	<xsl:with-param name="override-amt-value"><xsl:value-of select="fx_amt"/></xsl:with-param>
			   	</xsl:call-template>   	

				<xsl:call-template name="input-field">
					<xsl:with-param name="name">rate_report</xsl:with-param>
					<xsl:with-param name="label">XSL_CONTRACT_FX_RATE_LABEL</xsl:with-param>
					<xsl:with-param name="type">ratenumber</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="rate"/></xsl:with-param>
				</xsl:call-template>
			 	
				<xsl:call-template name="currency-field">
				    <xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_REMAINING_COUNTER_AMT</xsl:with-param>
				    <xsl:with-param name="product-code">counter_amt_report</xsl:with-param>
				    <xsl:with-param name="override-currency-value"><xsl:value-of select="counter_cur_code"/></xsl:with-param>
			     	<xsl:with-param name="override-amt-value"><xsl:value-of select="counter_amt"/></xsl:with-param>
			   	</xsl:call-template>
				
				<xsl:choose>
					<xsl:when test="not(securitycheck:hasPermission($rundata,'fx_spot_purchase')) and securitycheck:hasPermission($rundata,'fx_spot_sale')">						
							<!-- Value Date -->	
							<xsl:call-template name="select-field">
								<xsl:with-param name="label">XSL_VALUE_DATE_FX_LABEL</xsl:with-param>
								<xsl:with-param name="name">input_value_period</xsl:with-param>
								<xsl:with-param name="value">CASH</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
						        <xsl:with-param name="options">
							 		<xsl:call-template name="input-field">
							 		<xsl:with-param name="override-displaymode">view</xsl:with-param>
										<xsl:with-param name="label">XSL_VALUE_DATE_FX_LABEL</xsl:with-param>
										<xsl:with-param name="name">value_date</xsl:with-param>
										<xsl:with-param name="value" select="value_date"/>
									</xsl:call-template>
								</xsl:with-param>
							</xsl:call-template>						
					</xsl:when>
					<xsl:when test="securitycheck:hasPermission($rundata,'fx_spot_purchase') and not(securitycheck:hasPermission($rundata,'fx_spot_sale'))">
								<!-- Value Date -->	
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_VALUE_DATE_FX_LABEL</xsl:with-param>
									<xsl:with-param name="name">input_value_period</xsl:with-param>
									<xsl:with-param name="value">SPOT</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
							        <xsl:with-param name="options">
										 		<xsl:call-template name="input-field">
										 		<xsl:with-param name="override-displaymode">view</xsl:with-param>
													<xsl:with-param name="label">XSL_VALUE_DATE_FX_LABEL</xsl:with-param>
													<xsl:with-param name="name">value_date</xsl:with-param>
													<xsl:with-param name="value" select="value_date"/>
												</xsl:call-template>

									</xsl:with-param>
								</xsl:call-template>										
					</xsl:when>
					<xsl:otherwise>
							<!-- Value Date -->	
							<xsl:call-template name="select-field">
								<xsl:with-param name="label">XSL_VALUE_DATE_FX_LABEL</xsl:with-param>
								<xsl:with-param name="name">input_value_period</xsl:with-param>
								<xsl:with-param name="value">SPOT</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
						        <xsl:with-param name="options">
								 		<xsl:call-template name="input-field">
								 		<xsl:with-param name="override-displaymode">view</xsl:with-param>
											<xsl:with-param name="label">XSL_VALUE_DATE_FX_LABEL</xsl:with-param>
											<xsl:with-param name="name">value_date</xsl:with-param>
											<xsl:with-param name="value" select="value_date"/>
										</xsl:call-template>
								</xsl:with-param>
							</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose> 	
				
				<xsl:call-template name="input-field">
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_CONTRACT_FX_NOT_FOR_PAYMENT')"/>
				</xsl:call-template>
				
				<xsl:if test="$displaymode='view'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">remarks</xsl:with-param>
						<xsl:with-param name="label">XSL_FX_REMARKS</xsl:with-param>
					</xsl:call-template>
				</xsl:if> 	
				
			</xsl:with-param>
		</xsl:call-template>  
  </xsl:otherwise>
  </xsl:choose>
	<!-- WAITING POPUPS -->
	<xsl:call-template name="waiting-Dialog"/>
	<xsl:call-template name="loading-Dialog"/>
  </xsl:template>
  
</xsl:stylesheet>