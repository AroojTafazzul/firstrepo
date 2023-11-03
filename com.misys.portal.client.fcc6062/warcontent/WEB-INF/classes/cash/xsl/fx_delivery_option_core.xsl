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
  exclude-result-prefixes="localization securityCheck">
  
   <xsl:param name="option"/>
  
  <xsl:template name="fx-delivery-option-details">
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
						test="securityCheck:hasPermission($rundata,'fx_wfwd_purchase') and securityCheck:hasPermission($rundata,'fx_wfwd_sale')">
						<xsl:call-template name="fx-contract-type-option" />
					</xsl:when>
					<xsl:when
						test="not(securityCheck:hasPermission($rundata,'fx_wfwd_purchase')) and securityCheck:hasPermission($rundata,'fx_wfwd_sale')">
						<xsl:call-template name="fx-contract-type-sale" />
					</xsl:when>
					<xsl:when
						test="securityCheck:hasPermission($rundata,'fx_wfwd_purchase') and not(securityCheck:hasPermission($rundata,'fx_wfwd_sale'))">
						<xsl:call-template name="fx-contract-type-purchase" />
					</xsl:when>
					<xsl:otherwise>
						<!-- show nothing -->
					</xsl:otherwise>
				</xsl:choose> 
						  
			   <xsl:call-template name="fx-contract-type-option"/>
			   <xsl:call-template name="fx-currencies-fields"/>
			   <xsl:call-template name="fx-delivery-option-input-date"/>
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
						test="securityCheck:hasPermission($rundata,'fx_wfwd_purchase') and securityCheck:hasPermission($rundata,'fx_wfwd_sale')">
						<xsl:call-template name="fx-contract-type-option" />
					</xsl:when>
					<xsl:when
						test="not(securityCheck:hasPermission($rundata,'fx_wfwd_purchase')) and securityCheck:hasPermission($rundata,'fx_wfwd_sale')">
						<xsl:call-template name="fx-contract-type-sale" />
					</xsl:when>
					<xsl:when
						test="securityCheck:hasPermission($rundata,'fx_wfwd_purchase') and not(securityCheck:hasPermission($rundata,'fx_wfwd_sale'))">
						<xsl:call-template name="fx-contract-type-purchase" />
					</xsl:when>
					<xsl:otherwise>
						<!-- show nothing -->
					</xsl:otherwise>
				</xsl:choose> 		  
				
					<!-- <xsl:call-template name="fx-currencies-amount-fields"/> -->
				<xsl:if test="original_amt != fx_amt">
					<xsl:call-template name="currency-field">
					    <xsl:with-param name="label">XSL_CONTRACT_FX_ORG_CUR_AMT_LABEL</xsl:with-param>
					    <xsl:with-param name="product-code">input_fx</xsl:with-param>
					    <xsl:with-param name="override-currency-value"><xsl:value-of select="fx_cur_code"/></xsl:with-param>
				     	<xsl:with-param name="override-amt-value"><xsl:value-of select="original_amt"/></xsl:with-param>
				   	</xsl:call-template>
			   	</xsl:if>
		   	
<!-- 				<xsl:call-template name="currency-field"> -->
<!-- 				    <xsl:with-param name="label">XSL_CONTRACT_FX_COUNTER_ORG_CUR_AMT_LABEL</xsl:with-param> -->
<!-- 				    <xsl:with-param name="product-code">input_fx</xsl:with-param> -->
<!-- 				    <xsl:with-param name="override-currency-value"><xsl:value-of select="counter_cur_code"/></xsl:with-param> -->
<!-- 			     	<xsl:with-param name="override-amt-value"><xsl:value-of select="original_counter_amt"/></xsl:with-param> -->
<!-- 			   	</xsl:call-template> -->

				<xsl:call-template name="currency-field">
				    <xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_REMAINING_AMT</xsl:with-param>
				    <xsl:with-param name="product-code">fx_amt_report</xsl:with-param>
				    <xsl:with-param name="override-currency-value"><xsl:value-of select="fx_cur_code"/></xsl:with-param>
			     	<xsl:with-param name="override-amt-value"><xsl:value-of select="fx_amt"/></xsl:with-param>
			   	</xsl:call-template> 
			   	
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">rate_report</xsl:with-param>
					<xsl:with-param name="label">XSL_CONTRACT_FX_RATE_LABEL</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="rate"/></xsl:with-param>
					<xsl:with-param name="type">ratenumber</xsl:with-param>
				</xsl:call-template>
			   	
				<xsl:call-template name="currency-field">
				    <xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_REMAINING_COUNTER_AMT</xsl:with-param>
				    <xsl:with-param name="product-code">counter_amt_report</xsl:with-param>
				    <xsl:with-param name="override-currency-value"><xsl:value-of select="counter_cur_code"/></xsl:with-param>
			     	<xsl:with-param name="override-amt-value"><xsl:value-of select="counter_amt"/></xsl:with-param>
			   	</xsl:call-template> 
			    
			  <xsl:call-template name="input-field">
			        <xsl:with-param name="label">XSL_CONTRACT_FX_OPTION_DATE_LABEL</xsl:with-param>
					<xsl:with-param name="name">input_option</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="option_date"/></xsl:with-param>	      				
		      </xsl:call-template>
			  <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:with-param>
					<xsl:with-param name="name">input_value</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="value_date"/></xsl:with-param>	      				
		      </xsl:call-template>		      			    
			    
				<xsl:call-template name="input-field">
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_CONTRACT_FX_NOT_FOR_PAYMENT')"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>  
  
  </xsl:otherwise>
  </xsl:choose>
	<!-- WAITING POPUPS -->
	<xsl:call-template name="waiting-Dialog"/>
	<xsl:call-template name="loading-Dialog"/>
	
	
  </xsl:template>  
  
  
  
  <xsl:template name="fx-delivery-option-input-date">
   <xsl:call-template name="input-date-term-field">
        <xsl:with-param name="label">XSL_CONTRACT_FX_OPTION_DATE_LABEL</xsl:with-param>
		<xsl:with-param name="name">input_option</xsl:with-param>
		<xsl:with-param name="required">Y</xsl:with-param>	      				
		<xsl:with-param name="term-options">
	     	<option value="d"><xsl:value-of select="localization:getDecode($language, 'N413', 'd')"/></option>
	     	<option value="w"><xsl:value-of select="localization:getDecode($language, 'N413', 'w')"/></option>
	     	<option value="m"><xsl:value-of select="localization:getDecode($language, 'N413', 'm')"/></option>
	     	<option value="y"><xsl:value-of select="localization:getDecode($language, 'N413', 'y')"/></option>
	     </xsl:with-param>
	    
	    <xsl:with-param name="date">
			<xsl:choose>
				<xsl:when test="option_date_term_number[.!='']"><xsl:value-of select="option_date_term_number"/></xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="option_date"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="code">
			<xsl:choose>
				<xsl:when test="option_date_term_code[.!='']"><xsl:value-of select="option_date_term_code"/></xsl:when>
			</xsl:choose>
		</xsl:with-param>
	</xsl:call-template> 
    
    <xsl:call-template name="input-date-term-field">
        <xsl:with-param name="label">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:with-param>
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
				<xsl:otherwise>
					<xsl:value-of select="value_date"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="code">
			<xsl:choose>
				<xsl:when test="value_date_term_code[.!='']"><xsl:value-of select="value_date_term_code"/></xsl:when>
			</xsl:choose>
		</xsl:with-param>
    </xsl:call-template> 
   
   
  </xsl:template>
  
  <!--  template for takedown screens -->
  <!--
  ########################################################################
  #3 - TEMPLATES USE BY THE REVIEW MODE OF A FX TAKEDOWN UPDATE
  #
  ########################################################################
  -->
  
    <xsl:template name="fx-takedown-update-review">
  	<xsl:param name="originalDeal" select="org_previous_file/fx_tnx_record"/>
  		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_CONTRACT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			
				<!-- takedown deal -->
				<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">
					<xsl:choose>
						<xsl:when test="sub_tnx_type_code[.='50']">XSL_CONTRACT_FX_PAYMENT_SPLIT_DEAL_LABEL</xsl:when>
						<xsl:otherwise>XSL_CONTRACT_FX_TAKEDOWN_DEAL_LABEL</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">trade_id</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_TRADE_ID_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="trade_id"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">amt</xsl:with-param>
							<xsl:with-param name="label">XSL_ORG_CCY_AMT_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">rate</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_RATE_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="rate"/></xsl:with-param>
							<xsl:with-param name="type">ratenumber</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">counter_amt</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_SETTLEMENT_CTAMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="tnx_counter_cur_code"/>&nbsp;<xsl:value-of select="tnx_counter_amt"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">value_date</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="tnx_value_date"/></xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>		
			
			  	<!-- Original deal -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_CONTRACT_FX_ORG_DEAL_LABEL</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">original_trade_id</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_TRADE_ID_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$originalDeal/trade_id"/></xsl:with-param>
						</xsl:call-template>
						<xsl:if test="original_amt != fx_amt">
							<xsl:call-template name="input-field">
								<xsl:with-param name="name">original_amt</xsl:with-param>
								<xsl:with-param name="label">XSL_ORG_CCY_AMT_LABEL</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="$originalDeal/fx_cur_code"/>&nbsp;<xsl:value-of select="original_amt"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">original_rate</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_RATE_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$originalDeal/rate"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">original_counter_amt</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_SETTLEMENT_CTAMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$originalDeal/counter_cur_code"/>&nbsp;<xsl:value-of select="original_counter_amt"/></xsl:with-param>
						</xsl:call-template>						
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">original_value_date</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_WINDOW_START_DATE_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$originalDeal/option_date"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">original_value_date</xsl:with-param>
							<xsl:with-param name="label">
								<xsl:choose>
									<xsl:when test="sub_tnx_type_code[.='50']">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:when>
									<xsl:otherwise>XSL_CONTRACT_FX_WINDOW_END_DATE_LABEL</xsl:otherwise>
								</xsl:choose>							
							</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$originalDeal/value_date"/></xsl:with-param>
						</xsl:call-template>
						
					</xsl:with-param>
				</xsl:call-template>
				
				<!-- New deal -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_CONTRACT_FX_NEW_DEAL_LABEL</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">trade_id</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_TRADE_ID_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="org_previous_file/fx_tnx_record/trade_id"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">amt</xsl:with-param>
							<xsl:with-param name="label">XSL_ORG_CCY_AMT_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="fx_cur_code"/>&nbsp;<xsl:value-of select="fx_amt"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">rate</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_RATE_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="rate"/></xsl:with-param>
							<xsl:with-param name="type">ratenumber</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">counter_amt</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_SETTLEMENT_CTAMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="counter_cur_code"/>&nbsp;<xsl:value-of select="counter_amt"/></xsl:with-param>
						</xsl:call-template>
						 <!-- <xsl:call-template name="fx-delivery-option-input-date"/> -->
						 
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">input_option</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_WINDOW_START_DATE_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="option_date"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">input_value</xsl:with-param>
							<xsl:with-param name="label">
								<xsl:choose>
									<xsl:when test="sub_tnx_type_code[.='50']">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:when>
									<xsl:otherwise>XSL_CONTRACT_FX_WINDOW_END_DATE_LABEL</xsl:otherwise>
								</xsl:choose>							
							</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="value_date"/></xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
							  	 			
			</xsl:with-param>
		</xsl:call-template>
		
  </xsl:template>
  
  
  
  
  
  
  
  
  
  
</xsl:stylesheet>