<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Free Format and Bank Instruction, Customer Side. Payment Details
 
Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      
author:    
email:     
##########################################################
-->

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

 <xsl:stylesheet 
	  version="1.0" 
	  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	  xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	  exclude-result-prefixes="localization">
  
  <xsl:template name="paymentDetails">
  		<xsl:param name="mode"/>
  		<xsl:param name="prefix"/>
  		<xsl:param name="paymentBeneficiaryDiv"/>
  		<xsl:param name="additionalDetailsDiv"/>
  		<xsl:param name="paymentDetailsDiv"/>
  		<div>  
    	 <xsl:choose>    
    	 <xsl:when test="$paymentBeneficiaryDiv='paymentBeneficiaryPopup'">
    	 <xsl:attribute name="id">paymentBeneficiaryPopup</xsl:attribute>    
    	 </xsl:when>
    	 <xsl:otherwise>
    	 	 <xsl:attribute name="id">paymentDetailsId</xsl:attribute>   
    	 </xsl:otherwise>  
    	 </xsl:choose>  
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="legend">XSL_HEADER_PAYMENT_BENEFICIARY_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
					 <!-- <xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_MEANS</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>settlement_means</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="appendClass">inlineLabel</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
					  </xsl:call-template>
					  <xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_ACCOUNTNUMBER</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>settlement_account</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="appendClass">inlineLabel</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
					  </xsl:call-template> -->	
					  <xsl:if test="$mode ='WIRE' or $mode = ''">
				    	<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_NAME</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_name</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_ADDRESS_1</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_address</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<!-- MPS-26864 -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_ADDRESS_2</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_address_2</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_CITY</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_city</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_COUNTRY</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_country</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_ACCOUNT</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>counterparty_details_act_no</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>					
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BIC</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_bic</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK_BIC_CODE_SWIFT</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>account_with_institution_BIC</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK_BRANCH</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_branch</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK_ADRESS</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_address</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK_CITY</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>account_with_bank_dom</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK_COUNTRY</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_country</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_NUMBER</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_routing_number</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>	
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK_ACCOUNT</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_account</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK_ABA</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_aba</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
					  </xsl:if>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_SWIFT_CHARGES_TYPE</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>swift_charges_type</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_ORDERING_CUST_NAME</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_name</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_ORDERING_CUST_ADDRESS</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_address</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_ORDERING_CUST_CITYSTATE</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_citystate</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_ORDERING_CUST_COUNTRY</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_country</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_ORDERING_CUST_ACCOUNT</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_account</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<!-- Exposing localization code values -->
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>swift_charges_type_01</xsl:with-param>
							<xsl:with-param name="value" select="localization:getDecode($language, 'N017', '01')"/>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>swift_charges_type_02</xsl:with-param>
							<xsl:with-param name="value" select="localization:getDecode($language, 'N017', '02')"/>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>swift_charges_type_05</xsl:with-param>
							<xsl:with-param name="value" select="localization:getDecode($language, 'N017', '05')"/>
						</xsl:call-template>
					  <xsl:if test="$mode ='WIRE' or $mode = ''">			
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_PAYEMENT_AMOUNT</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>paymentAmount</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
					  </xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</div>
			<xsl:if test="$mode ='WIRE' or $mode = 'POPUP'">
    	 <div>  
    	 <xsl:choose>    
    	 <xsl:when test="$additionalDetailsDiv='additionalDetailsFreeFormat'">      
    	 <xsl:attribute name="id">additionalDetailsFreeFormat</xsl:attribute>    
    	 </xsl:when>
    	 <xsl:when test="$additionalDetailsDiv='additionalDetailsPopup'">      
    	 <xsl:attribute name="id">additionalDetailsPopup</xsl:attribute>    
    	 </xsl:when>
    	 <xsl:when test="$additionalDetailsDiv='additionalDetailsBankFormat'">      
    	 <xsl:attribute name="id">additionalDetailsBankFormat</xsl:attribute>    
    	 </xsl:when>
    	 <xsl:otherwise>
    	 	 <xsl:attribute name="id">additionalDetailsId</xsl:attribute>   
    	 </xsl:otherwise>  
    	 </xsl:choose>  
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="legend">XSL_SI_ADDITIONAL_DETAILS_TAB_LABEL</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
					
					<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_INTERMEDIARY_BIC_CODE_SWIFT</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_bic</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
				    	<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_INTERMEDIARY_NAME</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>					
						<!-- same as intermediary bank account number -->
					  <!--xsl:if test="mode = 'WIRE'">	
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_INTERMEDIARY_BANK_ABA</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_aba</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="appendClass">inlineLabel</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
					  </xsl:if-->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_INTERMEDIARY_ADDRESS</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_street</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_INTERMEDIARY_CITY_STATE</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_city</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_INTERMEDIARY_COUNTRY</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_country</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_INTERMEDIARY_BANK_ABA</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_aba</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>						
						<!-- 						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_INTERMEDIARY_BANK_ABA</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_account_number</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="appendClass">inlineLabel</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						 -->						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_ROUTING_INSTRUCTION_1</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_1</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_ROUTING_INSTRUCTION_2</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_2</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_ROUTING_INSTRUCTION_3</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_3</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_ROUTING_INSTRUCTION_4</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_4</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_ROUTING_INSTRUCTION_5</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_5</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_ROUTING_INSTRUCTION_6</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_6</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</div>
			</xsl:if>
			<xsl:if test="$mode ='WIRE' or $mode = 'POPUP'">
			<div>
  	        <xsl:choose>    
    	    <xsl:when test="$paymentDetailsDiv='paymentDetailsFreeFormat'"> 
    	        <xsl:attribute name="id">paymentDetailsFreeFormat</xsl:attribute>    
    	    </xsl:when>
    	    <xsl:when test="$paymentDetailsDiv='paymentDetailsPopup'">
    	        <xsl:attribute name="id">paymentDetailsPopup</xsl:attribute>    
    	    </xsl:when>  
            <xsl:when test="$paymentDetailsDiv='paymentDetailsBankFormat'">
    	        <xsl:attribute name="id">paymentDetailsBankFormat</xsl:attribute>    
    	    </xsl:when>      	      	    
    	    <xsl:otherwise>
    	 	   <xsl:attribute name="id">paymentDetailsId</xsl:attribute>   
    	    </xsl:otherwise>  
    	    </xsl:choose>  						
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="legend">XSL_SI_PAYMENT_DETAILS_TAB_LABEL</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_SI_ADDITIONAL_DETAILS_LINE_1</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>additional_detail_1</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_SI_ADDITIONAL_DETAILS_LINE_2</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>additional_detail_2</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_SI_ADDITIONAL_DETAILS_LINE_3</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>additional_detail_3</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_SI_ADDITIONAL_DETAILS_LINE_4</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>additional_detail_4</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="appendClass">inlineLabel</xsl:with-param> -->
							<xsl:with-param name="value">&nbsp;</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</div>
			</xsl:if>

  </xsl:template>
</xsl:stylesheet>