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
  xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
  xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
  xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
  xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
  exclude-result-prefixes="localization utils security securitycheck defaultresource">
	
	<xsl:template name="waiting-Dialog">
 <div class="widgetContainer">
	<xsl:call-template name="dialog">
		<xsl:with-param name="id">delayDialog</xsl:with-param>
	    <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REQUEST_DELAY_DIALOG_TITLE')" /></xsl:with-param>
	    <xsl:with-param name="content">
	    	<div id="waitingMessage">
	    		<xsl:value-of select="localization:getGTPString($language, 'XSL_REQUEST_DELAY_DISCLAIMER')" />
	    	</div>
	    	<div id="continueMessage">
	    		<xsl:value-of select="localization:getGTPString($language, 'XSL_REQUEST_DELAY_CONTINUE_DISCLAIMER')" />
	    	</div>
	    	<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">quote_id</xsl:with-param>
			</xsl:call-template>   
	    </xsl:with-param>
		<xsl:with-param name="buttons">
		   	<xsl:call-template name="row-wrapper">
				<xsl:with-param name="content">
					<xsl:call-template name="button-wrapper">
						<xsl:with-param name="id">continueDelayId</xsl:with-param>
						<xsl:with-param name="label">XSL_ACTION_CONTINUE</xsl:with-param>
						<xsl:with-param name="onclick">misys.fncContinueDelayDialog();</xsl:with-param>
						<xsl:with-param name="show-text-label">Y</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="button-wrapper">
						<xsl:with-param name="id">cancelDelayId</xsl:with-param>
						<xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
						<xsl:with-param name="onclick">misys.fncCancelDelayRequest();</xsl:with-param>
						<xsl:with-param name="show-text-label">Y</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
	    </xsl:with-param>
	</xsl:call-template>
 </div>
</xsl:template>
	
		<!-- 
	   FT Transfer Details
	   -->
	  <xsl:template name="ft-transfer-payment-details">
	  	<div id="request-details" class="widgetContainer">
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_PARTIESDETAILS_TRANSFER_DETAILS</xsl:with-param>
				<xsl:with-param name="content">
			
				<!-- FT type -->
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_CONTRACT_FX_TYPE_LABEL</xsl:with-param>
						<xsl:with-param name="name">ft_type</xsl:with-param>
						<xsl:with-param name="value" select="localization:getDecode($language, 'N029', ft_type[.])" />
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
					
					<xsl:if test="$displaymode !='view' and ft_type[.='01']" >
			 			<xsl:call-template name="user-account-field">
					          <xsl:with-param name="label">XSL_FT_DEBIT_ACCOUNT_LABEL</xsl:with-param>
					          <xsl:with-param name="name">applicant</xsl:with-param>
					          <xsl:with-param name="entity-field">entity</xsl:with-param>
					          <xsl:with-param name="option">useraccount</xsl:with-param>
					          <xsl:with-param name="show-product-types">N</xsl:with-param>
					          <xsl:with-param name="product_types">FT:TRINT</xsl:with-param>
					          <xsl:with-param name="account_types">12,07</xsl:with-param>
					          <xsl:with-param name="required">Y</xsl:with-param>
					    </xsl:call-template>
					</xsl:if>					        
					<xsl:if test="$displaymode !='view' and ft_type[.='02']" >		
			 			<xsl:call-template name="user-account-field">
					          <xsl:with-param name="label">XSL_FT_DEBIT_ACCOUNT_LABEL</xsl:with-param>
					          <xsl:with-param name="name">applicant</xsl:with-param>
					          <xsl:with-param name="entity-field">entity</xsl:with-param>
					          <xsl:with-param name="option">useraccount</xsl:with-param>
					          <xsl:with-param name="show-product-types">N</xsl:with-param>
					          <xsl:with-param name="product_types">FT:TRTPT</xsl:with-param>
					          <xsl:with-param name="account_types">12,07</xsl:with-param>
					          <xsl:with-param name="required">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:if>        
				<!-- Beneficiary Details -->
					<xsl:if test="ft_type[.='01'] and sub_product_code[.='TRINT']">
						<xsl:call-template name="user-account-field">
						  	<xsl:with-param name="label">XSL_FT_CREDIT_ACCOUNT_LABEL</xsl:with-param>
						  	<xsl:with-param name="name">beneficiary</xsl:with-param>
						  	<xsl:with-param name="product_types">FT:TRINT</xsl:with-param>
						    <xsl:with-param name="maxsize">34</xsl:with-param>
						    <xsl:with-param name="required">Y</xsl:with-param>
						    <xsl:with-param name="show-product-types">N</xsl:with-param>
						    <xsl:with-param name="account_types">12,07</xsl:with-param>
						    <xsl:with-param name="entity-field">entity</xsl:with-param>
						    <xsl:with-param name="excluded-value-field">applicant_act_no</xsl:with-param> 
						</xsl:call-template>
												
						<xsl:if test="$displaymode !='view'">
							<xsl:call-template name="currency-field">
							     <xsl:with-param name="label">XSL_TREASURY_FT_AMT_LABEL</xsl:with-param>
							     <xsl:with-param name="product-code">ft</xsl:with-param>
							     <xsl:with-param name="show-currency">Y</xsl:with-param>
							     <xsl:with-param name="show-button">Y</xsl:with-param>
							     <xsl:with-param name="value"><xsl:value-of select="ft_amt"/></xsl:with-param>
							     <xsl:with-param name="currency-readonly">N</xsl:with-param>
							     <xsl:with-param name="override-amt-name">ft_amt</xsl:with-param>
							     <xsl:with-param name="required">Y</xsl:with-param> 
			     		</xsl:call-template>
			     		</xsl:if>
					</xsl:if>
					
					<xsl:if test="sub_product_code[.='TRTPT']">
						<xsl:if test="$displaymode !='view'">
							<xsl:call-template name="currency-field">
							     <xsl:with-param name="label">XSL_FT_DEBIT_ACCOUNT_CURRENCY</xsl:with-param>
							     <xsl:with-param name="product-code">applicant</xsl:with-param>
							     <xsl:with-param name="show-currency">Y</xsl:with-param>
							     <xsl:with-param name="show-button">N</xsl:with-param>
							     <xsl:with-param name="value"><xsl:value-of select="applicant_cur_code"/></xsl:with-param>
							      <xsl:with-param name="override-currency-value"><xsl:value-of select="applicant_act_cur_code"/></xsl:with-param>
							      <xsl:with-param name="override-amt-value"><xsl:value-of select="applicant_act_amt"/></xsl:with-param>
							     <xsl:with-param name="currency-readonly">N</xsl:with-param>
							     <xsl:with-param name="override-amt-name">applicant_act_amt</xsl:with-param>
							     <xsl:with-param name="required">Y</xsl:with-param> 
				     		</xsl:call-template>
				     	</xsl:if>
				     	<xsl:if test="$displaymode !='view'">
							<xsl:call-template name="currency-field">
							     <xsl:with-param name="label">XSL_TREASURY_PAYMENT_AMT_LABEL</xsl:with-param>
							     <xsl:with-param name="product-code">payment</xsl:with-param>
							     <xsl:with-param name="show-currency">Y</xsl:with-param>
							     <xsl:with-param name="show-button">Y</xsl:with-param>
							     <xsl:with-param name="value"><xsl:value-of select="payment_cur_code"/></xsl:with-param>
							      <xsl:with-param name="override-currency-value"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></xsl:with-param>
							     <xsl:with-param name="override-amt-value"><xsl:value-of select="payment_amt"/></xsl:with-param>
							     <xsl:with-param name="currency-readonly">N</xsl:with-param>
							     <xsl:with-param name="override-amt-name">payment_amt</xsl:with-param>
							     <xsl:with-param name="required">Y</xsl:with-param> 
				     		</xsl:call-template>
				     	</xsl:if>
					</xsl:if>
				
					<xsl:call-template name="input-date-or-term-field">
				        <xsl:with-param name="label">XSL_CONTRACT_FT_REQUEST_DATE_LABEL</xsl:with-param>
						<xsl:with-param name="name">request_value</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="term-options">
							<xsl:choose>
								<xsl:when test="sub_product_code[.='TRINT']">
									 <xsl:call-template name="date-term-options">
									</xsl:call-template> 
								</xsl:when>
								<xsl:when test="sub_product_code[.='TRTPT']">
									<xsl:call-template name="date-term-options">
									</xsl:call-template>
								</xsl:when>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="static-options">
								<xsl:choose>
									<xsl:when test="sub_product_code[.='TRINT']">
										<xsl:call-template name="treasury-value-date-static-options">
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="sub_product_code[.='TRTPT']">
										<xsl:call-template name="treasury-value-date-static-options">
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
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
						   	
				   	<xsl:call-template name="hidden-field">
				   		<xsl:with-param name="name">iss_date</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
	    	<xsl:with-param name="name">bank_instruction_indicator</xsl:with-param>
	     	<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator"/>
	   		 </xsl:call-template>
					<xsl:if test="$displaymode='view'">
						<!-- debit reference -->
						<xsl:if test="payment_deal_no[.!='']">
							<xsl:call-template name="input-field">
								<xsl:with-param name="name">payment_deal_no</xsl:with-param>
								<xsl:with-param name="label">XSL_GENERALDETAILS_BO_DEBIT_ID</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						
						<!-- credit reference -->
						<xsl:if test="xfer_deal_no[.!='']">
							<xsl:call-template name="input-field">
								<xsl:with-param name="name">xfer_deal_no</xsl:with-param>
								<xsl:with-param name="label">XSL_GENERALDETAILS_BO_CREDIT_ID</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- fx reference -->
						<xsl:if test="fx_deal_no[.!='']">
							<xsl:call-template name="input-field">
								<xsl:with-param name="name">fx_deal_no</xsl:with-param>
								<xsl:with-param name="label">XSL_GENERALDETAILS_BO_FX_ID</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
												
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">review_debitAccountNumber</xsl:with-param>
							<xsl:with-param name="label">XSL_PARTIESDETAILS_ORDERING_ACT_NO</xsl:with-param>
							<xsl:with-param name="value" select="applicant_act_no"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="tnx_type_code[.!='01'] or $displaymode='view'">	
						<xsl:if test="tnx_stat_code[.='01'] and ft_cur_code[.!=''] and ft_amt[.!=''] and counterparties/counterparty/counterparty_amt[.='']">
							<xsl:call-template name="input-field">
								<xsl:with-param name="name">review_debitAmount</xsl:with-param>
								<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_CCY_AND_AMT</xsl:with-param>
								<xsl:with-param name="value">
								<xsl:value-of select="ft_cur_code"/>&nbsp;<xsl:value-of select="ft_amt"/>						
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="debit_ccy[.!=''] and debit_amt[.!='']">
							<xsl:call-template name="input-field">
								<xsl:with-param name="name">review_debitAmount</xsl:with-param>
								<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_CCY_AND_AMT</xsl:with-param>
								<xsl:with-param name="value">
								<xsl:value-of select="debit_ccy"/>&nbsp;<xsl:value-of select="debit_amt"/>						
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="(counterparties/counterparty/counterparty_cur_code[.!=''] and counterparties/counterparty/counterparty_amt[.!='']) and sub_product_code[.!='TRTPT']">
							<xsl:call-template name="input-field">
								<xsl:with-param name="name">review_transferAmount</xsl:with-param>
								<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_TRANSFERT_CURRENCY_AMOUNT</xsl:with-param>
								<xsl:with-param name="value">
								<xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/>&nbsp;<xsl:value-of select="counterparties/counterparty/counterparty_amt"/>						
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="(counterparties/counterparty/counterparty_cur_code[.!=''] and counterparties/counterparty/counterparty_amt[.!='']) and sub_product_code[.='TRTPT']">
						<xsl:call-template name="input-field">
								<xsl:with-param name="name">review_transferAmount</xsl:with-param>
								<xsl:with-param name="label">XSL_TREASURY_PAYMENT_AMT_LABEL</xsl:with-param>
								<xsl:with-param name="value">
								<xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/>&nbsp;<xsl:value-of select="counterparties/counterparty/counterparty_amt"/>						
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:if>
					
					<xsl:if test="$displaymode='view'">
						<xsl:if test="rate[.!='']">
							<xsl:call-template name="input-field">
								<xsl:with-param name="name">review_rate</xsl:with-param>
								<xsl:with-param name="label">XSL_CONTRACT_FX_RATE_LABEL</xsl:with-param>
								<xsl:with-param name="value" select="rate"/>
							</xsl:call-template>
						</xsl:if>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">review_executionDate</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FT_REQUEST_DATE_LABEL</xsl:with-param>
							<xsl:with-param name="value" select="iss_date"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="$displaymode='view' and $mode='UNSIGNED'">
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">request_value</xsl:with-param>
							<xsl:with-param name="value" select="request_value"/>
						</xsl:call-template>
					</xsl:if>
					
					  <xsl:variable name="FTCharge"><xsl:value-of select="defaultresource:getResource('FX_ENABLE_FT_CHARGE')"/></xsl:variable>
							
		<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">FTCharge</xsl:with-param>
    	<xsl:with-param name="value" select="$FTCharge"/>
	</xsl:call-template> 

	<xsl:choose>
		<xsl:when test="$mode = 'DRAFT' and $displaymode = 'edit' and $FTCharge = 'true'">
			<xsl:call-template name="multioption-group">
				<xsl:with-param name="group-label">XSL_CHRGDETAILS_BORN_BY_LABEL</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:choose>
						<xsl:when test="$mode = 'DRAFT' and ft_type[.='02']">				
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">
								<xsl:choose>
									<xsl:when test="ft_type[.='01'] or ft_type[.='05']">XSL_FT_CHARGE_DEBIT_ACCOUNT_LABEL</xsl:when>
									<xsl:otherwise>XSL_FT_CHARGE_APPLICANT_LABEL</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="name">open_chrg_brn_by_code</xsl:with-param>
							<xsl:with-param name="id">open_chrg_brn_by_code_1</xsl:with-param>
							<xsl:with-param name="value">01</xsl:with-param>
	<!-- 						<xsl:with-param name="disabled">Y</xsl:with-param> -->
						</xsl:call-template>
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">
								<xsl:choose>
									<xsl:when test="ft_type[.='01'] or ft_type[.='05']">XSL_FT_CHARGE_CREDIT_ACCOUNT_LABEL</xsl:when>
									<xsl:otherwise>XSL_FT_CHARGE_BENEFICIARY_LABEL</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="name">open_chrg_brn_by_code</xsl:with-param>
							<xsl:with-param name="id">open_chrg_brn_by_code_2</xsl:with-param>
							<xsl:with-param name="value">02</xsl:with-param>
	<!-- 						<xsl:with-param name="disabled">Y</xsl:with-param> -->
						</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="radio-field">
								<xsl:with-param name="label">
									<xsl:choose>
										<xsl:when test="ft_type[.='01'] or ft_type[.='05']">XSL_FT_CHARGE_DEBIT_ACCOUNT_LABEL</xsl:when>
										<xsl:otherwise>XSL_FT_CHARGE_APPLICANT_LABEL</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
								<xsl:with-param name="name">open_chrg_brn_by_code</xsl:with-param>
								<xsl:with-param name="id">open_chrg_brn_by_code_1</xsl:with-param>
								<xsl:with-param name="value">01</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="radio-field">
								<xsl:with-param name="label">
									<xsl:choose>
										<xsl:when test="ft_type[.='01'] or ft_type[.='05']">XSL_FT_CHARGE_CREDIT_ACCOUNT_LABEL</xsl:when>
										<xsl:otherwise>XSL_FT_CHARGE_BENEFICIARY_LABEL</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
								<xsl:with-param name="name">open_chrg_brn_by_code</xsl:with-param>
								<xsl:with-param name="id">open_chrg_brn_by_code_2</xsl:with-param>
								<xsl:with-param name="value">02</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>					
					<xsl:if test="ft_type[.='05']">
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_FT_CHARGE_BENEFICIARY_LABEL</xsl:with-param>
							<xsl:with-param name="name">open_chrg_brn_by_code</xsl:with-param>
							<xsl:with-param name="id">open_chrg_brn_by_code_3</xsl:with-param>
							<xsl:with-param name="value">03</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:when>
		<xsl:otherwise>
		 <xsl:if test="$FTCharge = 'true'">
			<xsl:call-template name="multioption-group">
					<xsl:with-param name="group-label">XSL_CHRGDETAILS_BORN_BY_LABEL</xsl:with-param>
					<xsl:with-param name="content">
					<xsl:choose>
						<xsl:when test="$mode = 'DRAFT' and ft_type[.='02']">				
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">
								<xsl:choose>
									<xsl:when test="ft_type[.='01'] or ft_type[.='05']">XSL_FT_CHARGE_DEBIT_ACCOUNT_LABEL</xsl:when>
									<xsl:otherwise>XSL_FT_CHARGE_APPLICANT_LABEL</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="name">open_chrg_brn_by_code</xsl:with-param>
							<xsl:with-param name="id">open_chrg_brn_by_code_1</xsl:with-param>
							<xsl:with-param name="value">01</xsl:with-param>
							<xsl:with-param name="disabled">Y</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">
								<xsl:choose>
									<xsl:when test="ft_type[.='01'] or ft_type[.='05']">XSL_FT_CHARGE_CREDIT_ACCOUNT_LABEL</xsl:when>
									<xsl:otherwise>XSL_FT_CHARGE_BENEFICIARY_LABEL</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="name">open_chrg_brn_by_code</xsl:with-param>
							<xsl:with-param name="id">open_chrg_brn_by_code_2</xsl:with-param>
							<xsl:with-param name="value">02</xsl:with-param>
							<xsl:with-param name="disabled">Y</xsl:with-param>
						</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="radio-field">
								<xsl:with-param name="label">
									<xsl:choose>
										<xsl:when test="ft_type[.='01'] or ft_type[.='05']">XSL_FT_CHARGE_DEBIT_ACCOUNT_LABEL</xsl:when>
										<xsl:otherwise>XSL_FT_CHARGE_APPLICANT_LABEL</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
								<xsl:with-param name="name">open_chrg_brn_by_code</xsl:with-param>
								<xsl:with-param name="id">open_chrg_brn_by_code_1</xsl:with-param>
								<xsl:with-param name="value">01</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="radio-field">
								<xsl:with-param name="label">
									<xsl:choose>
										<xsl:when test="ft_type[.='01'] or ft_type[.='05']">XSL_FT_CHARGE_CREDIT_ACCOUNT_LABEL</xsl:when>
										<xsl:otherwise>XSL_FT_CHARGE_BENEFICIARY_LABEL</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
								<xsl:with-param name="name">open_chrg_brn_by_code</xsl:with-param>
								<xsl:with-param name="id">open_chrg_brn_by_code_2</xsl:with-param>
								<xsl:with-param name="value">02</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>					
						<xsl:if test="ft_type[.='05']">
							<xsl:call-template name="radio-field">
								<xsl:with-param name="label">XSL_FT_CHARGE_BENEFICIARY_LABEL</xsl:with-param>
								<xsl:with-param name="name">open_chrg_brn_by_code</xsl:with-param>
								<xsl:with-param name="id">open_chrg_brn_by_code_3</xsl:with-param>
								<xsl:with-param name="value">03</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!-- account charge -->
				<xsl:variable name="chargeAccChargeCurrency"><xsl:value-of select="defaultresource:getResource('FX_ENABLE_FT_CHARGEACCOUNT')"/></xsl:variable>						
				<xsl:if test="$chargeAccChargeCurrency = 'true'">			
					<!-- charge account number-->
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
		</xsl:otherwise>
	</xsl:choose>

		</xsl:with-param>
	</xsl:call-template>
		</div>
		<xsl:call-template name="waiting-Dialog"/>
	</xsl:template>
	
	 <xsl:template name="date-term-options">
	 	<xsl:call-template name="code-data-options">
		 <xsl:with-param name="paramId">C041</xsl:with-param>
		 <xsl:with-param name="productCode">FT</xsl:with-param>
		 <xsl:with-param name="specificOrder">Y</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	 <xsl:template name="treasury-value-date-static-options">
	 	<xsl:call-template name="code-data-options">
		 <xsl:with-param name="paramId">C042</xsl:with-param>
		 <xsl:with-param name="productCode">FT</xsl:with-param>
		 <xsl:with-param name="specificOrder">Y</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


	<xsl:template name="ft-bank-instructions-preview">
		<xsl:if test="$displaymode='view'">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.!=''] and counterparties/counterparty[counterparty_type='04']/counterparty_name[.!='']">		
			<div id="bank-instructions" class="widgetContainer">
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_SETTLEMENT_DETAILS</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_SETTLEMENT_DETAILS_BENEFICIARY_DETAILS</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_NAME</xsl:with-param>
							<xsl:with-param name="name">beneficiary_name</xsl:with-param>
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/counterparty_name" />
						</xsl:call-template>
					</xsl:with-param>
					</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				</div>
			</xsl:if>
		</xsl:if>
	</xsl:template> 
	
</xsl:stylesheet>