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
   xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
  exclude-result-prefixes="localization">
  
  <xsl:template name="fx-swap-details">
  <xsl:if test="$displaymode='edit'">
	<div id="request-details" class="widgetContainer">
		<xsl:if test="$displaymode='edit'">
			<xsl:attribute name="style">display:block</xsl:attribute>
		</xsl:if>
		
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_REQUEST_FOR_QUOTE_DETAILS</xsl:with-param>
			<xsl:with-param name="content"> 
				<xsl:call-template name="fx-contract-type-label"/>
				<xsl:call-template name="fx-contract-type-option"/>
				<!-- input area -->
				<xsl:call-template name="currency-field">
				    <xsl:with-param name="label">XSL_CONTRACT_FX_CURRENCY_LABEL</xsl:with-param>
				    <!-- <xsl:with-param name="override-currency-name">near_cur_code</xsl:with-param>-->
<!--				    <xsl:with-param name="override-product-code">near</xsl:with-param>-->
				    <xsl:with-param name="product-code">input_fx</xsl:with-param>
				    <xsl:with-param name="required">Y</xsl:with-param>
				    <xsl:with-param name="show-amt">N</xsl:with-param>
<!--				    <xsl:with-param name="override-currency-value" select="fx_cur_code"/>-->
			   </xsl:call-template>
			   <xsl:call-template name="currency-field">
				    <xsl:with-param name="label">XSL_CONTRACT_FX_SETTLEMENT_CURRENCY_LABEL</xsl:with-param>
				    <!-- <xsl:with-param name="override-currency-name">far_cur_code</xsl:with-param>-->
<!--				    <xsl:with-param name="override-product-code">far</xsl:with-param>-->
				    <xsl:with-param name="product-code">input_counter</xsl:with-param>
				    <xsl:with-param name="required">Y</xsl:with-param>
				    <xsl:with-param name="show-amt">N</xsl:with-param>
			   </xsl:call-template>
			   	<xsl:call-template name="fx-swap-input-date"/>
			   <xsl:call-template name="currency-field">
				    <xsl:with-param name="label">XSL_CONTRACT_FX_NEAR_AMOUNT_LABEL</xsl:with-param>
<!--				    <xsl:with-param name="override-product-code">near</xsl:with-param>-->
				    <xsl:with-param name="product-code">input_near</xsl:with-param>
				    <xsl:with-param name="required">Y</xsl:with-param>
				    <xsl:with-param name="show-button">N</xsl:with-param>
				    <xsl:with-param name="show-currency">N</xsl:with-param>
				</xsl:call-template>
   				<xsl:call-template name="currency-field">
				    <xsl:with-param name="label">XSL_CONTRACT_FX_FAR_AMOUNT_LABEL</xsl:with-param>
<!--				    <xsl:with-param name="override-product-code">far</xsl:with-param>-->
				    <xsl:with-param name="product-code">input_far</xsl:with-param>
				    <xsl:with-param name="required">Y</xsl:with-param>
				    <xsl:with-param name="show-button">N</xsl:with-param>
				    <xsl:with-param name="show-currency">N</xsl:with-param>
				</xsl:call-template>
     			<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_FX_REMARKS</xsl:with-param>
				   	<xsl:with-param name="name">remarks</xsl:with-param>
				   	<xsl:with-param name="maxsize">70</xsl:with-param>
				</xsl:call-template>   
   
   				<xsl:call-template name="fx-action-button"/>
			</xsl:with-param>
		</xsl:call-template>
	</div>
	</xsl:if>
	<xsl:call-template name="fx-swap-trade-details"/>
	<!-- WAITING POPUPS -->
	<xsl:call-template name="waiting-Dialog"/>
	<xsl:call-template name="loading-Dialog"/>
  </xsl:template>
  
  <xsl:template name="fx-swap-input-date">
    
    <xsl:call-template name="input-date-term-field">
        <xsl:with-param name="label">XSL_CONTRACT_FX_NEAR_VALUE_DATE_LABEL</xsl:with-param>
		<xsl:with-param name="name">input_near</xsl:with-param>
		<xsl:with-param name="required">Y</xsl:with-param>	      				
		<xsl:with-param name="term-options">
	     	<option value="d"><xsl:value-of select="localization:getDecode($language, 'N413', 'd')"/></option>
	     	<option value="w"><xsl:value-of select="localization:getDecode($language, 'N413', 'w')"/></option>
	     	<option value="m"><xsl:value-of select="localization:getDecode($language, 'N413', 'm')"/></option>
	     	<option value="y"><xsl:value-of select="localization:getDecode($language, 'N413', 'y')"/></option>
	     </xsl:with-param>
	     <xsl:with-param name="static-options">
	     	<option value="SPOT"><xsl:value-of select="localization:getDecode($language, 'N413', 'SPOT')"/></option>
	    </xsl:with-param>
	     <xsl:with-param name="date">
			<xsl:choose>
				<xsl:when test="near_value_date_term_number[.!='']"><xsl:value-of select="near_value_date_term_number"/></xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="near_value_date"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="code">
			<xsl:choose>
				<xsl:when test="near_value_date_term_code[.!='']"><xsl:value-of select="near_value_date_term_code"/></xsl:when>
			</xsl:choose>
		</xsl:with-param>
    </xsl:call-template>
    
    <xsl:call-template name="input-date-term-field">
        <xsl:with-param name="label">XSL_CONTRACT_FX_FAR_VALUE_DATE_LABEL</xsl:with-param>
		<xsl:with-param name="name">input_value</xsl:with-param>
		<xsl:with-param name="required">Y</xsl:with-param>	      				
		<xsl:with-param name="term-options">
	     	<option value="d"><xsl:value-of select="localization:getDecode($language, 'N413', 'd')"/></option>
	     	<option value="w"><xsl:value-of select="localization:getDecode($language, 'N413', 'w')"/></option>
	     	<option value="m"><xsl:value-of select="localization:getDecode($language, 'N413', 'm')"/></option>
	     	<option value="y"><xsl:value-of select="localization:getDecode($language, 'N413', 'y')"/></option>
	     </xsl:with-param>
		<xsl:with-param name="date">
			<xsl:choose>
				<xsl:when test="value_date_term_number[.!='']"><xsl:value-of select="value_date_term_number"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="value_date"/></xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="code">
			<xsl:choose>
				<xsl:when test="value_date_term_code[.!='']"><xsl:value-of select="value_date_term_code"/></xsl:when>
			</xsl:choose>
		</xsl:with-param>
    </xsl:call-template> 
    
  </xsl:template>
  
  <xsl:template name="fx-swap-trade-details">
  	<div id="trade-details">
<!--		<xsl:if test="$displaymode='edit'">-->
<!--			<xsl:attribute name="style">display:none</xsl:attribute>-->
<!--		</xsl:if>	-->
	   <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_HEADER_CONTRACT_DETAILS</xsl:with-param>
	    <xsl:with-param name="content"> 	
				
				<xsl:if test="$displaymode='view'">
					<xsl:call-template name="fx-contract-type-label"/>
					<xsl:call-template name="fx-contract-type-option"/>
				</xsl:if>
				<xsl:if test="$displaymode='edit'">	
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">trade_id_report</xsl:with-param>
					<xsl:with-param name="label">XSL_CONTRACT_FX_TRADE_ID_LABEL</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
							<xsl:otherwise><xsl:value-of select="trade_id"/></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">trade_id</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">rec_id</xsl:with-param>
				</xsl:call-template>
				<!-- Begin Near Deal Details -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_CONTRACT_FX_SWAP_NEAR_LABEL</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
		    			<xsl:call-template name="input-field">
							<xsl:with-param name="name">near_amt_report</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_RECEIVING_AMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
									<xsl:otherwise><xsl:value-of select="concat(fx_cur_code, ' ', near_amt)"/></xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">near_rate_report</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_RATE_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
									<xsl:otherwise><xsl:value-of select="near_rate"/></xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">near_counter_amt_report</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_RECEIVING_COUNTER_AMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
									<xsl:otherwise><xsl:value-of select="concat(counter_cur_code, ' ', near_counter_amt)"/></xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">near_date_report</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="$displaymode='edit'">setByFncPerformc</xsl:when>
									<xsl:otherwise><xsl:value-of select="near_value_date"/></xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<!-- End Near Deal Details -->
				<br/>
				<!-- Begin Far Deal Details-->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_CONTRACT_FX_SWAP_FAR_LABEL</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
		    			<xsl:call-template name="input-field">
							<xsl:with-param name="name">far_amt_report</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_RECEIVING_FAR_AMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
									<xsl:otherwise><xsl:value-of select="concat(fx_cur_code, ' ', fx_amt)"/></xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">far_rate_report</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_RATE_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
									<xsl:otherwise><xsl:value-of select="rate"/></xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">far_counter_amt_report</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_RECEIVING_FAR_COUNTER_AMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
									<xsl:otherwise><xsl:value-of select="concat(counter_cur_code, ' ', counter_amt)"/></xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">far_date_report</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_FAR_VALUE_DATE_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
									<xsl:otherwise><xsl:value-of select="value_date"/></xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
					<div id="traderRemarksContainer">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">trader_remarks_report</xsl:with-param>
						<xsl:with-param name="label">XSL_FX_TRADER_REMARKS</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:choose>
								<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
								<xsl:otherwise><xsl:value-of select="trader_remarks"/></xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</div>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">trader_remarks</xsl:with-param>
				</xsl:call-template>
				 <!-- End Far Deal Details -->
				 
				<!-- Hidden fields to send data when form is post --> 
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">fx_cur_code</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">fx_amt</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">counter_cur_code</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">rate</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">counter_amt</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">value_date</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">maturity_date</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">near_date</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">near_counter_currency_code</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">near_counter_amt</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">near_rate</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">near_currency_code</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">near_amt</xsl:with-param>
				</xsl:call-template>

				<xsl:if test="$displaymode='edit'">
					<xsl:call-template name="row-wrapper">
						<xsl:with-param name="content">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_RATES_DISCLAIMER')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="row-wrapper">
						<xsl:with-param name="content">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_RATE_VALIDITY_DISCLAIMER_PREFIX')"/>
							<span id="validitySpan"></span>
						</xsl:with-param>
					</xsl:call-template>
					<div id="progressBarCash" class="field">
					<label for="customerReference_details_nosend">&nbsp;</label>
					<div dojoType="dijit.ProgressBar" style="width:300px" jsId="jsProgress" id="countdownProgress" maximum="10"></div>
					</div>
					<xsl:call-template name="fx-accept-button"/>
					<xsl:call-template name="cash-rate-progress-bar"/>
					<xsl:call-template name="input-field">
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_CONTRACT_FX_COMMITMENT_TO_CONTRACT')"/>
					</xsl:call-template>
		      	</xsl:if>
		</xsl:with-param>
		</xsl:call-template>
	</div>
  </xsl:template>
  <!-- Template to choose the contract option (purchase / sale) -->
  <xsl:template name="fx-swap-contract-type-option">
	<xsl:call-template name="multioption-group">
    <xsl:with-param name="group-label">XSL_CONTRACT_FX_CONTRACT_TYPE_LABEL</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="radio-field">
      <xsl:with-param name="label">XSL_CONTRACT_FX_PURCHAGE_SELL_LABEL</xsl:with-param>
      <xsl:with-param name="name">contract_type</xsl:with-param>
      <xsl:with-param name="id">contract_type_1</xsl:with-param>
      <xsl:with-param name="value">01</xsl:with-param>
      <xsl:with-param name="checked">Y</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="radio-field">
      <xsl:with-param name="label">XSL_CONTRACT_FX_SELL_PURCHAGE_LABEL</xsl:with-param>
      <xsl:with-param name="name">contract_type</xsl:with-param>
      <xsl:with-param name="id">contract_type_2</xsl:with-param>
      <xsl:with-param name="value">02</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
</xsl:stylesheet>