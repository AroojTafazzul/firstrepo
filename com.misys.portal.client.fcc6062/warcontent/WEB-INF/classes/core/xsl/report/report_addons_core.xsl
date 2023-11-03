<?xml version="1.0"?>

<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
	exclude-result-prefixes="localization securityCheck security converttools">

<!--
   Copyright (c) 2001-2011 Misys (http://www.misys.com),
   All Rights Reserved. 
-->

	<!-- ******************************************************	-->
	<!-- Add more columns available through the Report Designer	-->
	<!-- Empty templates in the standard version				-->
	<!-- ******************************************************	-->

	<xsl:template name="report_addons">	
			<!-- Common columns for all products -->
		    
		    <xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SG')">
				arrProductColumn["SG"][202] = "ObjectDataString@gen_sg_indemnity_flag";
				arrColumn["ObjectDataString@gen_sg_indemnity_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_gen_sg_indemnity_flag')"/>");
			 </xsl:if>
			
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'TF')">
				
				arrProductColumn["TF"][201] = "sub_product_code";
				arrProductColumn["TF"][202] = "ObjectDataString@related_reference";
				arrProductColumn["TF"][203] = "ObjectDataAmount@bill_amt";
				arrProductColumn["TF"][204] = "ObjectDataString@bill_amt_cur_code";
				arrProductColumn["TF"][205] = "ObjectDataString@description_of_goods";
				arrProductColumn["TF"][206] = "ObjectDataAmount@interest_amt";
				arrProductColumn["TF"][207] = "ObjectDataString@repayment_mode";
				arrProductColumn["TF"][208] = "ObjectDataAmount@repayment_amt";
				arrProductColumn["TF"][209] = "ObjectDataString@repayment_cur_code";
				arrProductColumn["TF"][210] = "ObjectDataString@settlement_code";
				arrProductColumn["TF"][211] = "ObjectDataString@source_fund";
			
				<!-- TF Tnx columns -->
				
				arrProductColumn["TFTnx"][201] = "ObjectDataString@subject";
				
				<!-- TF Column definition -->
				
				arrColumn["ObjectDataString@sub_product_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_sub_product_code')"/>");
				arrColumn["ObjectDataString@related_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_related_reference')"/>");
				arrColumn["ObjectDataAmount@bill_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bill_amt')"/>");
				arrColumn["ObjectDataString@bill_amt_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bill_amt_cur_code')"/>");
				arrColumn["ObjectDataString@description_of_goods"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_description_of_goods')"/>");
				arrColumn["ObjectDataAmount@interest_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_interest_amt')"/>");
				arrColumn["ObjectDataString@repayment_mode"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_repayment_mode')"/>");
				arrColumn["ObjectDataAmount@repayment_amt"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_repayment_amt')"/>");
				arrColumn["ObjectDataString@repayment_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_repayment_cur_code')"/>");
				arrColumn["ObjectDataString@settlement_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_settlement_code')"/>");
				arrColumn["ObjectDataString@source_fund"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_source_fund')"/>");
				arrColumn["ObjectDataString@subject"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_subject')"/>");
							
		    </xsl:if>  		    
		   
		   	<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FA')">
				
				<!-- FA  columns -->
			
				arrProductColumn["FA"][201] = "ObjectDataString@client_code";
				arrProductColumn["FA"][202] = "ObjectDataString@account_type";
				arrProductColumn["FA"][203] = "ObjectDataDate@processing_date";
				arrProductColumn["FA"][204] = "ObjectDataString@amt_avail_for_adv_payment";
				arrProductColumn["FA"][205] = "ObjectDataString@adv_currency";
				arrProductColumn["FA"][206] = "ObjectDataString@short_name";
				arrProductColumn["FA"][207] = "ObjectDataString@account_type_des";
				arrProductColumn["FA"][208] = "ObjectDataString@adv_currency_name";
				
				<!-- FA Column definition -->
				
				arrColumn["ObjectDataString@client_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_client_code')"/>");
				arrColumn["ObjectDataString@account_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_account_type')"/>");
				arrColumn["ObjectDataDate@processing_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_processing_date')"/>");
				arrColumn["ObjectDataString@amt_avail_for_adv_payment"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_amt_avail_for_adv_payment')"/>");
				arrColumn["ObjectDataString@adv_currency"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_adv_currency')"/>");
				arrColumn["ObjectDataDate@short_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_short_name')"/>");
				arrColumn["ObjectDataString@account_type_des"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_account_type_des')"/>");
				arrColumn["ObjectDataString@adv_currency_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_adv_currency_name')"/>");
							
		    </xsl:if>  		    
		  
		    <xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FT')">
				
				
							
				<!-- FT Tnx columns -->
				
				
				
				
				<!-- FT Column definition -->
				
				arrColumn["ObjectDataString@applicant_act_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_act_cur_code')"/>");
				arrColumn["ObjectDataString@applicant_act_description"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_act_description')"/>");
				arrColumn["ObjectDataString@applicant_act_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_act_name')"/>");
				arrColumn["ObjectDataAmount@fee_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fee_amt')"/>");
				arrColumn["ObjectDataString@fee_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fee_cur_code')"/>");
				arrColumn["ObjectDataString@bo_account_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bo_account_id')"/>");
				arrColumn["ObjectDataString@bo_account_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bo_account_type')"/>");
				arrColumn["ObjectDataString@bo_account_currency"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bo_account_currency')"/>");
				arrColumn["ObjectDataString@bo_branch_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bo_branch_code')"/>");
				arrColumn["ObjectDataString@bo_product_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bo_product_type')"/>");
				arrColumn["ObjectDataString@beneficiary_mode"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_mode')"/>");
				arrColumn["ObjectDataString@product_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_product_type')"/>");
				arrColumn["ObjectDataString@ordering_customer_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_customer_name')"/>");
				arrColumn["ObjectDataString@ordering_customer_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_customer_address_line_1')"/>");
				arrColumn["ObjectDataString@ordering_customer_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_customer_address_line_2')"/>");
				arrColumn["ObjectDataString@ordering_customer_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_customer_dom')"/>");
				arrColumn["ObjectDataString@ordering_customer_account"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_customer_account')"/>");
				arrColumn["ObjectDataString@ordering_customer_swift_bic_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_customer_swift_bic_code')"/>");
				arrColumn["ObjectDataString@ordering_customer_bank_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_customer_bank_name')"/>");
				arrColumn["ObjectDataString@ordering_customer_bank_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_customer_bank_address_line_1')"/>");
				arrColumn["ObjectDataString@ordering_customer_bank_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_customer_bank_address_line_2')"/>");
				arrColumn["ObjectDataString@ordering_customer_bank_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_customer_bank_dom')"/>");
				arrColumn["ObjectDataString@ordering_customer_bank_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_customer_bank_country')"/>");
				arrColumn["ObjectDataString@ordering_customer_bank_account"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_customer_bank_account')"/>");
				arrColumn["ObjectDataString@ordering_institution_swift_bic_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_institution_swift_bic_code')"/>");
				arrColumn["ObjectDataString@ordering_institution_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_institution_name')"/>");
				arrColumn["ObjectDataString@ordering_institution_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_institution_address_line_1')"/>");
				arrColumn["ObjectDataString@ordering_institution_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_institution_address_line_2')"/>");
				arrColumn["ObjectDataString@ordering_institution_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_institution_dom')"/>");
				arrColumn["ObjectDataString@ordering_institution_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_institution_country')"/>");
				arrColumn["ObjectDataString@ordering_institution_account"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_institution_account')"/>");
				arrColumn["ObjectDataString@beneficiary_institution_swift_bic_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_institution_swift_bic_code')"/>");
				arrColumn["Counterparty@cpty_bank_swift_bic_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_bank_swift_bic_code')"/>");
				arrColumn["Counterparty@cpty_bank_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_bank_name')"/>");
				arrColumn["Counterparty@cpty_bank_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_bank_address_line_1')"/>");
				arrColumn["Counterparty@cpty_bank_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_bank_address_line_2')"/>");
				arrColumn["ObjectDataString@beneficiary_bank_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_bank_address_line_2')"/>");
				arrColumn["Counterparty@cpty_bank_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_bank_dom')"/>");
				arrColumn["Counterparty@cpty_bank_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_bank_country')"/>");
				arrColumn["ObjectDataString@beneficiary_bank_branch_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_bank_branch_address_line_1')"/>");
				arrColumn["ObjectDataString@beneficiary_bank_branch_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_bank_branch_address_line_2')"/>");
				arrColumn["ObjectDataString@beneficiary_bank_branch_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_bank_branch_dom')"/>");
				arrColumn["ObjectDataString@beneficiary_bank_clearing_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_bank_clearing_code')"/>");
				arrColumn["ObjectDataString@beneficiary_bank_clearing_code_desc"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_bank_clearing_code_desc')"/>");
				arrColumn["ObjectDataString@intermediary_bank_swift_bic_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_intermediary_bank_swift_bic_code')"/>");
				arrColumn["ObjectDataString@ordering_bank_swift_bic_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordering_bank_swift_bic_code')"/>");
				arrColumn["ObjectDataString@intermediary_bank_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_intermediary_bank_name')"/>");
				arrColumn["ObjectDataString@intermediary_bank_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_intermediary_bank_address_line_1')"/>");
				arrColumn["ObjectDataString@intermediary_bank_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_intermediary_bank_address_line_2')"/>");
				arrColumn["ObjectDataString@intermediary_bank_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_intermediary_bank_dom')"/>");
				arrColumn["ObjectDataString@intermediary_bank_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_intermediary_bank_country')"/>");
				arrColumn["ObjectDataString@intermediary_bank_clearing_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_intermediary_bank_clearing_code')"/>");
				arrColumn["ObjectDataString@intermediary_bank_clearing_code_desc"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_intermediary_bank_clearing_code_desc')"/>");
				arrColumn["ObjectDataString@charge_option"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_charge_option')"/>");
				arrColumn["ObjectDataString@related_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_related_reference')"/>");
				arrColumn["ObjectDataClob@payment_details_to_beneficiary"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_payment_details_to_beneficiary')"/>");
				arrColumn["ObjectDataString@sender_to_receiver_info"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_sender_to_receiver_info')"/>");
				arrColumn["ObjectDataDate@processing_date"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_processing_date')"/>");
				arrColumn["ObjectDataDate@request_date"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_request_date')"/>");
				arrColumn["ObjectDataString@debit_account_for_charges"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_debit_account_for_charges')"/>");
				arrColumn["ObjectDataClob@instruction_to_bank"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_instruction_to_bank')"/>");
				arrColumn["ObjectDataString@transaction_remarks"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_transaction_remarks')"/>");
				arrColumn["ObjectDataString@customer_payee_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_customer_payee_id')"/>");
				arrColumn["ObjectDataString@payee_Code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_payee_Code')"/>");
				arrColumn["ObjectDataString@payee_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_payee_name')"/>");
				arrColumn["ObjectDataString@transfer_date"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_transfer_date')"/>");
				arrColumn["ObjectDataDate@recurring_start_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COLUMN_recurring_start_date')"/>");
				arrColumn["ObjectDataDate@recurring_end_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COLUMN_recurring_end_date')"/>");
				arrColumn["ObjectDataString@recurring_frequency"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_recurring_frequency')"/>");
				arrColumn["ObjectDataString@recurring_on"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_recurring_on')"/>");
				arrColumn["ObjectDataNumber@recurring_number_transfers"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_recurring_number_transfers')"/>");
				arrColumn["ObjectDataString@recurring_payment_enabled"] = new Array("AvailableBooleanStrings", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_recurring_payment_enabled')"/>");
				arrColumn["ObjectDataString@action"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_action')"/>");
				arrColumn["ObjectDataString@start_date"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_start_date')"/>");
				arrColumn["ObjectDataString@end_date"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_end_date')"/>");
				arrColumn["ObjectDataString@beneficiary_name_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_name_2')"/>");
				arrColumn["ObjectDataString@beneficiary_name_3"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_name_3')"/>");
				arrColumn["ObjectDataString@beneficiary_address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_address_line_4')"/>");
				arrColumn["ObjectDataString@drawn_on_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_drawn_on_country')"/>");
				arrColumn["ObjectDataString@collecting_bank_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_collecting_bank_code')"/>");
				arrColumn["ObjectDataString@collecting_branch_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_collecting_branch_code')"/>");
				arrColumn["ObjectDataString@collectors_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_collectors_name')"/>");
				arrColumn["ObjectDataString@collectors_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_collectors_id')"/>");
				arrColumn["ObjectDataString@mailing_other_name_address"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_mailing_other_name_address')"/>");
				arrColumn["ObjectDataString@mailing_other_postal_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_mailing_other_postal_code')"/>");
				arrColumn["ObjectDataString@mailing_other_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_mailing_other_country')"/>");
				arrColumn["ObjectDataString@bene_adv_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_flag')"/>");
				arrColumn["ObjectDataString@bene_adv_email_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_email_flag')"/>");
				arrColumn["ObjectDataString@bene_adv_email_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_email_1')"/>");
				arrColumn["ObjectDataString@bene_adv_email_21"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_email_21')"/>");
				arrColumn["ObjectDataString@bene_adv_email_22"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_email_22')"/>");
				arrColumn["ObjectDataString@bene_adv_phone_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_phone_flag')"/>");
				arrColumn["ObjectDataString@bene_adv_phone"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_phone')"/>");
				arrColumn["ObjectDataString@bene_adv_fax_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_fax_flag')"/>");
				arrColumn["ObjectDataString@bene_adv_fax"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_fax')"/>");
				arrColumn["ObjectDataString@bene_adv_ivr_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_ivr_flag')"/>");
				arrColumn["ObjectDataString@bene_adv_ivr"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_ivr')"/>");
				arrColumn["ObjectDataString@bene_adv_print_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_print_flag')"/>");
				arrColumn["ObjectDataString@bene_adv_mail_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_mail_flag')"/>");
				arrColumn["ObjectDataString@bene_adv_mailing_name_add_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_mailing_name_add_1')"/>");
				arrColumn["ObjectDataString@bene_adv_mailing_name_add_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_mailing_name_add_2')"/>");
				arrColumn["ObjectDataString@bene_adv_mailing_name_add_3"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_mailing_name_add_3')"/>");
				arrColumn["ObjectDataString@bene_adv_mailing_name_add_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_mailing_name_add_4')"/>");
				arrColumn["ObjectDataString@bene_adv_mailing_name_add_5"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_mailing_name_add_5')"/>");
				arrColumn["ObjectDataString@bene_adv_mailing_name_add_6"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_mailing_name_add_6')"/>");
				arrColumn["ObjectDataString@bene_adv_postal_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_postal_code')"/>");
				arrColumn["ObjectDataString@bene_adv_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_country')"/>");
				arrColumn["ObjectDataString@bene_adv_beneficiary_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_beneficiary_id')"/>");
				arrColumn["ObjectDataString@bene_adv_payer_name_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_payer_name_1')"/>");
				arrColumn["ObjectDataString@bene_adv_payer_name_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_payer_name_2')"/>");
				arrColumn["ObjectDataString@bene_adv_payer_ref_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_payer_ref_no')"/>");
				arrColumn["ObjectDataString@bene_adv_free_format_msg"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_free_format_msg')"/>");
				arrColumn["ObjectDataString@bene_adv_table_format"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_table_format')"/>");
				arrColumn["ObjectDataString@bene_adv_table_format_time"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_adv_table_format_time')"/>");
				arrColumn["ObjectDataString@bene_advice_table_data"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_advice_table_data')"/>");
				arrColumn["Counterparty@counterparty_act_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_act_no')"/>");
				arrColumn["Counterparty@counterparty_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_reference')"/>");
				arrColumn["Counterparty@counterparty_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_address_line_1')"/>");
				arrColumn["Counterparty@counterparty_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_address_line_2')"/>");
				arrColumn["ObjectDataString@counterparty_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_country')"/>");
				arrColumn["ObjectDataString@counterparty_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_abbv_name')"/>");
				arrColumn["ObjectDataString@counterparty_act_iso_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_act_iso_code')"/>");
				arrColumn["Counterparty@counterparty_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_name')"/>");
				arrColumn["Counterparty@counterparty_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_dom')"/>");
				arrColumn["ObjectDataString@counterparty_amt"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_amt')"/>");
				arrColumn["ObjectDataString@counterparty_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_cur_code')"/>");
				arrColumn["ObjectDataString@cpty_bank_swift_bic_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_bank_swift_bic_code')"/>");
				arrColumn["ObjectDataString@cpty_bank_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_bank_code')"/>");
				arrColumn["ObjectDataString@cpty_bank_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_bank_name')"/>");
				arrColumn["ObjectDataString@cpty_bank_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_bank_dom')"/>");
				arrColumn["ObjectDataString@cpty_branch_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_branch_code')"/>");
				arrColumn["ObjectDataString@cpty_branch_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_branch_name')"/>");
				arrColumn["ObjectDataString@cpty_branch_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_branch_address_line_1')"/>");
				arrColumn["ObjectDataString@cpty_branch_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_branch_address_line_2')"/>");
				<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FT','HVPS') or securityCheck:hasCompanyProductPermission($rundata,'FT','HVXB')">
					arrColumn["ObjectDataString@cnaps_bank_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cnaps_bank_code')"/>");
					arrColumn["ObjectDataString@cnaps_bank_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cnaps_bank_name')"/>");
				</xsl:if>
				arrColumn["ObjectDataDate@related_transaction_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_related_transaction_date')"/>");
				arrColumn["ObjectDataString@urgent_transfer"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_urgent_transfer')"/>");
				arrColumn["ObjectDataString@business_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_business_type')"/>");
				arrColumn["ObjectDataString@business_detail_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_business_detail_type')"/>");
				arrColumn["ObjectDataString@cross_border_remark"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cross_border_remark')"/>");
				
				<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FT','MUPS')">
					arrColumn["ObjectDataString@clearing_code"] = new Array("AvailableClearingCode", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_clearing_code')"/>");
					arrColumn["ObjectDataString@mups_description_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_mups_description_address_line_1')"/>");
					arrColumn["ObjectDataString@mups_description_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_mups_description_address_line_2')"/>");
					arrColumn["ObjectDataString@mups_description_address_line_3"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_mups_description_address_line_3')"/>");
					arrColumn["ObjectDataString@mups_description_address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_mups_description_address_line_4')"/>");
				</xsl:if>
				arrColumn["sub_product_code"] = new Array("AvaliableSubProductType", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_sub_product_code')"/>");

				arrColumn["ObjectDataString@notify_beneficiary_email"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_notify_beneficiary_email')"/>");
		    </xsl:if>  
		    
		    <!-- TD and TDTnx columns -->
			
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'TD')">
			
		arrColumn["ObjectDataString@placement_act_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_placement_act_name')"/>");
		arrColumn["ObjectDataString@placement_act_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_placement_act_cur_code')"/>");
		arrColumn["ObjectDataString@placement_act_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_placement_act_no')"/>");
		arrColumn["ObjectDataString@placement_act_description"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_placement_act_description')"/>");
		arrColumn["ObjectDataString@placement_act_pab"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_placement_act_pab')"/>");	
				arrColumn["ObjectDataString@debit_act_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_debit_act_name')"/>");
				arrColumn["ObjectDataString@debit_act_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_debit_act_cur_code')"/>");
				arrColumn["ObjectDataString@debit_act_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_debit_act_no')"/>");
				arrColumn["ObjectDataString@debit_act_description"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_debit_act_description')"/>");
				arrColumn["ObjectDataString@debit_act_pab"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_debit_act_pab')"/>");
		arrColumn["ObjectDataString@credit_act_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_credit_act_name')"/>");
		arrColumn["ObjectDataString@credit_act_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_credit_act_cur_code')"/>");
		arrColumn["ObjectDataString@credit_act_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_credit_act_no')"/>");
		arrColumn["ObjectDataString@credit_act_description"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_credit_act_description')"/>");
		arrColumn["ObjectDataString@credit_act_pab"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_credit_act_pab')"/>");
	
		arrColumn["ObjectDataString@maturity_instruction_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_maturity_instruction_code')"/>");
		arrColumn["ObjectDataString@accured_interest"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_accured_interest')"/>");
		arrColumn["ObjectDataString@premature_withdrawal_penalty"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_premature_withdrawal_penalty')"/>");
		arrColumn["ObjectDataString@withholding_tax"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_withholding_tax')"/>");
		arrColumn["ObjectDataString@hold_mail_charges"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_hold_mail_charges')"/>");
		arrColumn["ObjectDataString@annual_postage_fee"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_annual_postage_fee')"/>");
		arrColumn["ObjectDataString@withdrawable_interest"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_withdrawable_interest')"/>");
		arrColumn["ObjectDataString@net_settlement_amount"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_net_settlement_amount')"/>");
		arrColumn["ObjectDataString@maturity_instruction_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_maturity_instruction_code')"/>");
		arrColumn["Narrative@bo_comment"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@boComment')"/>", "CLOB");
		arrColumn["Narrative@free_format_text"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@freeFormatText')"/>", "CLOB");	 

			</xsl:if>	
			 <!-- SE and SETnx columns -->
			
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SE')">
			
		arrColumn["priority"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_priority')"/>");
		arrColumn["issuer_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_issuer_type')"/>");
		arrColumn["req_read_receipt"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_req_read_receipt')"/>");
		arrColumn["read_dttm"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_read_dttm')"/>");
		arrColumn["se_act_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_se_act_no')"/>");
		arrColumn["ObjectDataString@upload_file_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_upload_file_type')"/>");		
		arrColumn["ObjectDataString@tenor_days_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tenor_days_type')"/>");
		arrColumn["ObjectDataString@tenor_maturity_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tenor_maturity_date')"/>");
		arrColumn["ObjectDataString@deduct_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_deduct_cur_code')"/>");
		arrColumn["ObjectDataString@deduct_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_deduct_amt')"/>");
		arrColumn["ObjectDataString@to_act_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_to_act_no')"/>");
		arrColumn["ObjectDataString@add_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_add_cur_code')"/>");
		arrColumn["ObjectDataString@add_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_add_amt')"/>");
		arrColumn["ObjectDataString@from_act_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_from_act_no')"/>");
		arrColumn["ObjectDataString@close_act_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_close_act_no')"/>");
		arrColumn["ObjectDataString@instruction_radio"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_instruction_radio')"/>");
		arrColumn["ObjectDataString@checkbook_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_checkbook_no')"/>");
		arrColumn["ObjectDataString@chequebook_format"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_chequebook_format')"/>");
		arrColumn["ObjectDataString@cheque_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cheque_type')"/>");
		arrColumn["ObjectDataString@cheque_number_from"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cheque_number_from')"/>");
		arrColumn["ObjectDataString@cheque_number_to"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cheque_number_to')"/>");
		arrColumn["ObjectDataString@no_of_cheque_books"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_no_of_cheque_books')"/>");
		arrColumn["ObjectDataString@format_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_format_name')"/>");
		arrColumn["ObjectDataString@map_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_map_code')"/>");
		arrColumn["ObjectDataString@format_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_format_type')"/>");
		arrColumn["ObjectDataString@amendable"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_amendable')"/>");
		arrColumn["ObjectDataString@file_encrypted"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_file_encrypted')"/>");
		arrColumn["ObjectDataString@override_duplicate_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_override_duplicate_reference')"/>");
		arrColumn["ObjectDataString@upload_description"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_upload_description')"/>");
		arrColumn["ObjectDataString@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_reference')"/>");
		arrColumn["ObjectDataString@file_upload_act_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_file_upload_act_name')"/>");
		arrColumn["ObjectDataString@value_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_value_date')"/>");
		arrColumn["ObjectDataString@payroll_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_payroll_type')"/>");
		arrColumn["ObjectDataString@file_upload_act_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_file_upload_act_cur_code')"/>");
		arrColumn["ObjectDataString@file_upload_act_description"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_file_upload_act_description')"/>");
		arrColumn["sub_product_code"] = new Array("AvaliableSubProductType", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_sub_product_code')"/>");
		  		    
					</xsl:if>	
			   
	 </xsl:template>
	
	<xsl:template name="Specific_Column_Value_Description">
		<xsl:param name="columnName"></xsl:param>
		<xsl:param name="columnValue"></xsl:param>
	</xsl:template>
	
	<xsl:template name="Specific_Columns_Definitions">		   
						
	</xsl:template>
	
</xsl:stylesheet>

