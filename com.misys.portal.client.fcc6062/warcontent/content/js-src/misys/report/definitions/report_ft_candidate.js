dojo.provide("misys.report.definitions.report_ft_candidate");


		// Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
		// All Rights Reserved. 
	
		// Defining Recurring related column constants
		var FT_CONSTANT = "FT";
		var FT_TNX_CONSTANT = "FTTnx";
		var RECURRING_FREQUENCY_CONSTANT = "ObjectDataString@recurring_frequency";
		var RECURRING_NUMBER_TRANSFERS_CONSTANT = "ObjectDataNumber@recurring_number_transfers";
		var RECURRING_START_DATE_CONSTANT = "ObjectDataDate@recurring_start_date";
		var RECURRING_END_DATE_CONSTANT = "ObjectDataDate@recurring_end_date";
		var RECURRING_PAYMENT_ENABLED_CONSTANT = "ObjectDataString@recurring_payment_enabled";

		// FT candidate
		// Define an array which stores the FT columns
		
		arrProductColumn["FT"].push("ref_id");
		arrProductColumn["FT"].push("bo_ref_id");
		arrProductColumn["FT"].push("cust_ref_id");
		arrProductColumn["FT"].push("prod_stat_code");
		arrProductColumn["FT"].push("appl_date");
		arrProductColumn["FT"].push("iss_date");
		arrProductColumn["FT"].push("ft_cur_code");
		arrProductColumn["FT"].push("ft_amt");
		arrProductColumn["FT"].push("IssuingBank@name");
		arrProductColumn["FT"].push("applicant_act_name");
		arrProductColumn["FT"].push("applicant_act_no");
		arrProductColumn["FT"].push("applicant_name");
		arrProductColumn["FT"].push("sub_product_code");
		arrProductColumn["FT"].push("Counterparty@counterparty_name"); 
		arrProductColumn["FT"].push("Counterparty@counterparty_address_line_1");
		arrProductColumn["FT"].push("Counterparty@counterparty_address_line_2");
		arrProductColumn["FT"].push("Counterparty@counterparty_dom");
		arrProductColumn["FT"].push("Counterparty@counterparty_act_no");
		arrProductColumn["FT"].push("Counterparty@cpty_bank_swift_bic_code");
		arrProductColumn["FT"].push("Counterparty@cpty_bank_name");
		arrProductColumn["FT"].push("Counterparty@cpty_bank_address_line_1");
		arrProductColumn["FT"].push("Counterparty@cpty_bank_address_line_2");
		arrProductColumn["FT"].push("Counterparty@cpty_bank_dom");
		arrProductColumn["FT"].push("Counterparty@cpty_bank_country");
		arrProductColumn["FT"].push("ObjectDataString@beneficiary_bank_branch_address_line_1");
		arrProductColumn["FT"].push("ObjectDataString@beneficiary_bank_branch_address_line_2");
		arrProductColumn["FT"].push("ObjectDataString@beneficiary_bank_branch_dom");
		arrProductColumn["FT"].push("ObjectDataString@intermediary_bank_swift_bic_code");
		arrProductColumn["FT"].push("ObjectDataString@intermediary_bank_name");
		arrProductColumn["FT"].push("ObjectDataString@intermediary_bank_address_line_1");
		arrProductColumn["FT"].push("ObjectDataString@intermediary_bank_address_line_2");
		arrProductColumn["FT"].push("ObjectDataString@intermediary_bank_dom");
		arrProductColumn["FT"].push("ObjectDataString@intermediary_bank_country");
		arrProductColumn["FT"].push("ObjectDataString@charge_option");
		arrProductColumn["FT"].push("ObjectDataClob@payment_details_to_beneficiary");
		arrProductColumn["FT"].push("ObjectDataClob@instruction_to_bank");
		arrProductColumn["FT"].push("ObjectDataString@cnaps_bank_code");
		arrProductColumn["FT"].push("ObjectDataString@cnaps_bank_name");
		arrProductColumn["FT"].push("Counterparty@counterparty_reference");
		arrProductColumn["FT"].push("ObjectDataDate@related_transaction_date");
		arrProductColumn["FT"].push("ObjectDataString@urgent_transfer");
		arrProductColumn["FT"].push("ObjectDataString@business_type");
		arrProductColumn["FT"].push("ObjectDataString@business_detail_type");
		arrProductColumn["FT"].push("ObjectDataString@cross_border_remark");
		arrProductColumn["FT"].push("Narrative@freeFormatText");
		arrProductColumn["FT"].push("ObjectDataString@notify_beneficiary_email");
		arrProductColumn["FT"].push("ObjectDataString@clearing_code");
		arrProductColumn["FT"].push("ObjectDataString@mups_description_address_line_1");
		arrProductColumn["FT"].push("ObjectDataString@mups_description_address_line_2");
		arrProductColumn["FT"].push("ObjectDataString@mups_description_address_line_3");
		arrProductColumn["FT"].push("ObjectDataString@mups_description_address_line_4");
		arrProductColumn[FT_CONSTANT].push(RECURRING_FREQUENCY_CONSTANT);
		arrProductColumn[FT_CONSTANT].push(RECURRING_NUMBER_TRANSFERS_CONSTANT);
		arrProductColumn[FT_CONSTANT].push(RECURRING_START_DATE_CONSTANT);
		arrProductColumn[FT_CONSTANT].push(RECURRING_END_DATE_CONSTANT);
		arrProductColumn[FT_CONSTANT].push(RECURRING_PAYMENT_ENABLED_CONSTANT);
		
	
		// FT Transaction candidate
		
		// Define an array which stores the FT Transaction columns
		
		arrProductColumn["FTTnx"].push("ref_id");
		arrProductColumn["FTTnx"].push("tnx_id");
		arrProductColumn["FTTnx"].push("bo_ref_id");
		arrProductColumn["FTTnx"].push("cust_ref_id");
		arrProductColumn["FTTnx"].push("sub_product_code");
		arrProductColumn["FTTnx"].push("prod_stat_code");
		arrProductColumn["FTTnx"].push("tnx_type_code");
		arrProductColumn["FTTnx"].push("tnx_stat_code");
		arrProductColumn["FTTnx"].push("sub_tnx_stat_code");
		arrProductColumn["FTTnx"].push("appl_date");
		arrProductColumn["FTTnx"].push("iss_date");
		arrProductColumn["FTTnx"].push("ft_cur_code");
		arrProductColumn["FTTnx"].push("ft_amt");
		arrProductColumn["FTTnx"].push("IssuingBank@name");
		
		arrProductColumn["FTTnx"].push("applicant_act_name");
		arrProductColumn["FTTnx"].push("applicant_act_no");
		arrProductColumn["FTTnx"].push("applicant_name");
		arrProductColumn["FTTnx"].push("applicant_address_line_1");
		arrProductColumn["FTTnx"].push("applicant_address_line_2");
		arrProductColumn["FTTnx"].push("applicant_dom");
		arrProductColumn["FTTnx"].push("applicant_reference");
		
		arrProductColumn["FTTnx"].push("Counterparty@counterparty_name");
		arrProductColumn["FTTnx"].push("Counterparty@counterparty_address_line_1");
		arrProductColumn["FTTnx"].push("Counterparty@counterparty_address_line_2");
		arrProductColumn["FTTnx"].push("Counterparty@counterparty_dom");
		arrProductColumn["FTTnx"].push("Counterparty@counterparty_act_no");
		arrProductColumn["FTTnx"].push("Counterparty@cpty_bank_swift_bic_code");
		arrProductColumn["FTTnx"].push("Counterparty@cpty_bank_name");
		arrProductColumn["FTTnx"].push("Counterparty@cpty_bank_address_line_1");
		arrProductColumn["FTTnx"].push("Counterparty@cpty_bank_address_line_2");
		arrProductColumn["FTTnx"].push("Counterparty@cpty_bank_dom");
		arrProductColumn["FTTnx"].push("Counterparty@cpty_bank_country");
		
		arrProductColumn["FTTnx"].push("ObjectDataString@beneficiary_bank_branch_address_line_1");
		arrProductColumn["FTTnx"].push("ObjectDataString@beneficiary_bank_branch_address_line_2");
		arrProductColumn["FTTnx"].push("ObjectDataString@beneficiary_bank_branch_dom");
		
		arrProductColumn["FTTnx"].push("ObjectDataString@intermediary_bank_swift_bic_code");
		arrProductColumn["FTTnx"].push("ObjectDataString@intermediary_bank_name");
		arrProductColumn["FTTnx"].push("ObjectDataString@intermediary_bank_address_line_1");
		arrProductColumn["FTTnx"].push("ObjectDataString@intermediary_bank_address_line_2");
		arrProductColumn["FTTnx"].push("ObjectDataString@intermediary_bank_dom");
		arrProductColumn["FTTnx"].push("ObjectDataString@intermediary_bank_country");
		arrProductColumn["FTTnx"].push("ObjectDataString@charge_option");
		
		arrProductColumn["FTTnx"].push("ObjectDataClob@payment_details_to_beneficiary");
		arrProductColumn["FTTnx"].push("ObjectDataClob@instruction_to_bank");
		arrProductColumn["FTTnx"].push("ObjectDataString@applicant_act_pab");
		
		arrProductColumn["FTTnx"].push("ObjectDataString@cnaps_bank_code");
		arrProductColumn["FTTnx"].push("ObjectDataString@cnaps_bank_name");
		arrProductColumn["FTTnx"].push("Counterparty@counterparty_reference");
		
		arrProductColumn["FTTnx"].push("ObjectDataDate@related_transaction_date");
		
		arrProductColumn["FTTnx"].push("ObjectDataString@urgent_transfer");
		arrProductColumn["FTTnx"].push("ObjectDataString@business_type");
		arrProductColumn["FTTnx"].push("ObjectDataString@business_detail_type");
		arrProductColumn["FTTnx"].push("ObjectDataString@cross_border_remark");
		
		arrProductColumn["FTTnx"].push("bo_release_dttm");
		
		arrProductColumn["FTTnx"].push("Inputter@last_name");
		arrProductColumn["FTTnx"].push("Inputter@first_name");
		arrProductColumn["FTTnx"].push("inp_dttm");
		arrProductColumn["FTTnx"].push("Releaser@last_name");
		arrProductColumn["FTTnx"].push("Releaser@first_name");
		arrProductColumn["FTTnx"].push("release_dttm");
		arrProductColumn["FTTnx"].push("Narrative@freeFormatText");
		arrProductColumn["FTTnx"].push("ObjectDataString@notify_beneficiary_email");
		arrProductColumn["FTTnx"].push("ObjectDataString@clearing_code");
		arrProductColumn["FTTnx"].push("ObjectDataString@mups_description_address_line_1");
		arrProductColumn["FTTnx"].push("ObjectDataString@mups_description_address_line_2");
		arrProductColumn["FTTnx"].push("ObjectDataString@mups_description_address_line_3");
		arrProductColumn["FTTnx"].push("ObjectDataString@mups_description_address_line_4");
		arrProductColumn[FT_TNX_CONSTANT].push(RECURRING_FREQUENCY_CONSTANT);
		arrProductColumn[FT_TNX_CONSTANT].push(RECURRING_NUMBER_TRANSFERS_CONSTANT);
		arrProductColumn[FT_TNX_CONSTANT].push(RECURRING_START_DATE_CONSTANT);
		arrProductColumn[FT_TNX_CONSTANT].push(RECURRING_END_DATE_CONSTANT);
		arrProductColumn[FT_TNX_CONSTANT].push(RECURRING_PAYMENT_ENABLED_CONSTANT);
		
		
		/* FT Column definition */
		  /*Available in report_addons_core.xsl and report_core.xsl files*/
		
		// ORDER-BY: column options - starts
		/*arrProductOrderColumn["FTTnx"].push("ObjectDataString@field_id");*/
		// ORDER-BY: column options - starts
		
		// CRITERIA: column options - starts
		arrProductCriteriaColumn["FT"].push("ref_id");
		arrProductCriteriaColumn["FT"].push("sub_product_code");
		arrProductCriteriaColumn["FT"].push("prod_stat_code");
		arrProductCriteriaColumn["FT"].push("tnx_type_code");
		arrProductCriteriaColumn["FT"].push("appl_date");
		arrProductCriteriaColumn["FT"].push("iss_date");
		arrProductCriteriaColumn["FT"].push("ft_cur_code");
		arrProductCriteriaColumn["FT"].push("ft_amt");
		arrProductCriteriaColumn["FT"].push("Counterparty@counterparty_name");
		arrProductCriteriaColumn["FT"].push("Counterparty@counterparty_act_no");
		arrProductCriteriaColumn["FT"].push("Counterparty@cpty_bank_name");
		arrProductCriteriaColumn["FT"].push("applicant_act_name");
		arrProductCriteriaColumn["FT"].push("bo_ref_id");
		arrProductCriteriaColumn["FT"].push("applicant_act_no");
		arrProductCriteriaColumn["FT"].push("Counterparty@counterparty_dom"); 
		arrProductCriteriaColumn["FT"].push("Counterparty@cpty_bank_swift_bic_code");
		arrProductCriteriaColumn["FT"].push("Counterparty@cpty_bank_dom");
		arrProductCriteriaColumn["FT"].push("Counterparty@cpty_bank_country");
		arrProductCriteriaColumn["FT"].push("ObjectDataString@beneficiary_bank_branch_dom");
		arrProductCriteriaColumn["FT"].push("ObjectDataString@intermediary_bank_swift_bic_code");
		arrProductCriteriaColumn["FT"].push("ObjectDataString@intermediary_bank_name");
		arrProductCriteriaColumn["FT"].push("ObjectDataString@intermediary_bank_dom");
		arrProductCriteriaColumn["FT"].push("ObjectDataString@intermediary_bank_country");
		arrProductCriteriaColumn["FT"].push("ObjectDataString@cnaps_bank_code");
		arrProductCriteriaColumn["FT"].push("ObjectDataString@cnaps_bank_name");
		arrProductCriteriaColumn["FT"].push("ObjectDataDate@related_transaction_date");
		arrProductCriteriaColumn["FT"].push("ObjectDataString@clearing_code");
		arrProductCriteriaColumn[FT_CONSTANT].push(RECURRING_FREQUENCY_CONSTANT);
		arrProductCriteriaColumn[FT_CONSTANT].push(RECURRING_NUMBER_TRANSFERS_CONSTANT);
		arrProductCriteriaColumn[FT_CONSTANT].push(RECURRING_START_DATE_CONSTANT);
		arrProductCriteriaColumn[FT_CONSTANT].push(RECURRING_END_DATE_CONSTANT);
		arrProductCriteriaColumn[FT_CONSTANT].push(RECURRING_PAYMENT_ENABLED_CONSTANT);
		
		arrProductCriteriaColumn["FTTnx"].push("ref_id");
		arrProductCriteriaColumn["FTTnx"].push("tnx_id");
		arrProductCriteriaColumn["FTTnx"].push("sub_product_code");
		arrProductCriteriaColumn["FTTnx"].push("prod_stat_code");
		arrProductCriteriaColumn["FTTnx"].push("tnx_type_code");
		arrProductCriteriaColumn["FTTnx"].push("appl_date");
		arrProductCriteriaColumn["FTTnx"].push("iss_date");
		arrProductCriteriaColumn["FTTnx"].push("ft_cur_code");
		arrProductCriteriaColumn["FTTnx"].push("ft_amt");
		arrProductCriteriaColumn["FTTnx"].push("Counterparty@counterparty_name");
		arrProductCriteriaColumn["FTTnx"].push("Counterparty@counterparty_act_no");
		arrProductCriteriaColumn["FTTnx"].push("Counterparty@cpty_bank_name");
		arrProductCriteriaColumn["FTTnx"].push("applicant_act_name");
		arrProductCriteriaColumn["FTTnx"].push("tnx_stat_code");
		arrProductCriteriaColumn["FTTnx"].push("sub_tnx_stat_code");
		arrProductCriteriaColumn["FTTnx"].push("Inputter@last_name");
		arrProductCriteriaColumn["FTTnx"].push("Inputter@first_name");
		arrProductCriteriaColumn["FTTnx"].push("inp_dttm");
		arrProductCriteriaColumn["FTTnx"].push("Releaser@last_name");
		arrProductCriteriaColumn["FTTnx"].push("Releaser@first_name");
		arrProductCriteriaColumn["FTTnx"].push("release_dttm");
		arrProductCriteriaColumn["FTTnx"].push("bo_ref_id");
		arrProductCriteriaColumn["FTTnx"].push("applicant_act_no");
		arrProductCriteriaColumn["FTTnx"].push("Counterparty@counterparty_dom"); 
		arrProductCriteriaColumn["FTTnx"].push("Counterparty@cpty_bank_swift_bic_code");
		arrProductCriteriaColumn["FTTnx"].push("Counterparty@cpty_bank_dom");
		arrProductCriteriaColumn["FTTnx"].push("Counterparty@cpty_bank_country");
		arrProductCriteriaColumn["FTTnx"].push("ObjectDataString@beneficiary_bank_branch_dom");
		arrProductCriteriaColumn["FTTnx"].push("ObjectDataString@intermediary_bank_swift_bic_code");
		arrProductCriteriaColumn["FTTnx"].push("ObjectDataString@intermediary_bank_name");
		arrProductCriteriaColumn["FTTnx"].push("ObjectDataString@intermediary_bank_dom");
		arrProductCriteriaColumn["FTTnx"].push("ObjectDataString@intermediary_bank_country");
		arrProductCriteriaColumn["FTTnx"].push("bo_release_dttm");
		arrProductCriteriaColumn["FTTnx"].push("ObjectDataString@cnaps_bank_code");
		arrProductCriteriaColumn["FTTnx"].push("ObjectDataString@cnaps_bank_name");
		arrProductCriteriaColumn["FTTnx"].push("ObjectDataDate@related_transaction_date");
		arrProductCriteriaColumn["FTTnx"].push("ObjectDataString@clearing_code");
		arrProductCriteriaColumn[FT_TNX_CONSTANT].push(RECURRING_FREQUENCY_CONSTANT);
		arrProductCriteriaColumn[FT_TNX_CONSTANT].push(RECURRING_NUMBER_TRANSFERS_CONSTANT);
		arrProductCriteriaColumn[FT_TNX_CONSTANT].push(RECURRING_START_DATE_CONSTANT);
		arrProductCriteriaColumn[FT_TNX_CONSTANT].push(RECURRING_END_DATE_CONSTANT);
		arrProductCriteriaColumn[FT_TNX_CONSTANT].push(RECURRING_PAYMENT_ENABLED_CONSTANT);
		// CRITERIA: column options - ends
		
		// GROUPING: column options - starts
		arrProductGroupColumn["FT"].push("sub_product_code");
		arrProductGroupColumn["FT"].push("prod_stat_code");
		arrProductGroupColumn["FT"].push("tnx_type_code");
		arrProductGroupColumn["FT"].push("appl_date");
		arrProductGroupColumn["FT"].push("iss_date");
		arrProductGroupColumn["FT"].push("ft_cur_code");
		arrProductGroupColumn["FT"].push("ft_amt");
		arrProductGroupColumn["FT"].push("Counterparty@counterparty_name");
		arrProductGroupColumn["FT"].push("Counterparty@counterparty_act_no");
		arrProductGroupColumn["FT"].push("Counterparty@cpty_bank_name"); 
		arrProductGroupColumn["FT"].push("applicant_act_name"); 
		arrProductGroupColumn["FT"].push("applicant_act_no");

		arrProductGroupColumn["FT"].push("Counterparty@counterparty_dom"); 
		arrProductGroupColumn["FT"].push("Counterparty@cpty_bank_swift_bic_code");
		arrProductGroupColumn["FT"].push("Counterparty@cpty_bank_dom");
		arrProductGroupColumn["FT"].push("Counterparty@cpty_bank_country");
		arrProductGroupColumn["FT"].push("ObjectDataString@beneficiary_bank_branch_dom");
		arrProductGroupColumn["FT"].push("ObjectDataString@intermediary_bank_swift_bic_code");
		arrProductGroupColumn["FT"].push("ObjectDataString@intermediary_bank_name");
		arrProductGroupColumn["FT"].push("ObjectDataString@intermediary_bank_dom");
		arrProductGroupColumn["FT"].push("ObjectDataString@intermediary_bank_country");
		arrProductGroupColumn["FT"].push("ObjectDataString@cnaps_bank_code");
		arrProductGroupColumn["FT"].push("ObjectDataString@cnaps_bank_name");
		arrProductGroupColumn["FT"].push("ObjectDataDate@related_transaction_date");
		arrProductGroupColumn["FT"].push("ObjectDataString@clearing_code");
		arrProductGroupColumn[FT_CONSTANT].push(RECURRING_FREQUENCY_CONSTANT);
		arrProductGroupColumn[FT_CONSTANT].push(RECURRING_NUMBER_TRANSFERS_CONSTANT);
		arrProductGroupColumn[FT_CONSTANT].push(RECURRING_START_DATE_CONSTANT);
		arrProductGroupColumn[FT_CONSTANT].push(RECURRING_END_DATE_CONSTANT);
		arrProductGroupColumn[FT_CONSTANT].push(RECURRING_PAYMENT_ENABLED_CONSTANT);
		
		arrProductGroupColumn["FTTnx"].push("sub_product_code");
		arrProductGroupColumn["FTTnx"].push("prod_stat_code");
		arrProductGroupColumn["FTTnx"].push("tnx_type_code");
		arrProductGroupColumn["FTTnx"].push("appl_date");
		arrProductGroupColumn["FTTnx"].push("iss_date");
		arrProductGroupColumn["FTTnx"].push("ft_cur_code");
		arrProductGroupColumn["FTTnx"].push("ft_amt");
		arrProductGroupColumn["FTTnx"].push("Counterparty@counterparty_name");
		arrProductGroupColumn["FTTnx"].push("Counterparty@counterparty_act_no");
		arrProductGroupColumn["FTTnx"].push("Counterparty@cpty_bank_name");
		arrProductGroupColumn["FTTnx"].push("applicant_act_name");
		arrProductGroupColumn["FTTnx"].push("applicant_act_no");
		arrProductGroupColumn["FTTnx"].push("tnx_stat_code");
		arrProductGroupColumn["FTTnx"].push("sub_tnx_stat_code");
		arrProductGroupColumn["FTTnx"].push("Inputter@last_name");
		arrProductGroupColumn["FTTnx"].push("Inputter@first_name");
		arrProductGroupColumn["FTTnx"].push("inp_dttm");
		arrProductGroupColumn["FTTnx"].push("Releaser@last_name");
		arrProductGroupColumn["FTTnx"].push("Releaser@first_name");
		arrProductGroupColumn["FTTnx"].push("release_dttm");
		arrProductGroupColumn["FTTnx"].push("Counterparty@counterparty_dom"); 
		arrProductGroupColumn["FTTnx"].push("Counterparty@cpty_bank_swift_bic_code");
		arrProductGroupColumn["FTTnx"].push("Counterparty@cpty_bank_dom");
		arrProductGroupColumn["FTTnx"].push("Counterparty@cpty_bank_country");
		arrProductGroupColumn["FTTnx"].push("ObjectDataString@beneficiary_bank_branch_dom");
		arrProductGroupColumn["FTTnx"].push("ObjectDataString@intermediary_bank_swift_bic_code");
		arrProductGroupColumn["FTTnx"].push("ObjectDataString@intermediary_bank_name");
		arrProductGroupColumn["FTTnx"].push("ObjectDataString@intermediary_bank_dom");
		arrProductGroupColumn["FTTnx"].push("ObjectDataString@intermediary_bank_country");
		arrProductGroupColumn["FTTnx"].push("ObjectDataString@cnaps_bank_code");
		arrProductGroupColumn["FTTnx"].push("ObjectDataString@cnaps_bank_name");
		arrProductGroupColumn["FTTnx"].push("ObjectDataDate@related_transaction_date");
		arrProductGroupColumn["FTTnx"].push("ObjectDataString@clearing_code");
		arrProductGroupColumn[FT_TNX_CONSTANT].push(RECURRING_FREQUENCY_CONSTANT);
		arrProductGroupColumn[FT_TNX_CONSTANT].push(RECURRING_NUMBER_TRANSFERS_CONSTANT);
		arrProductGroupColumn[FT_TNX_CONSTANT].push(RECURRING_START_DATE_CONSTANT);
		arrProductGroupColumn[FT_TNX_CONSTANT].push(RECURRING_END_DATE_CONSTANT);
		arrProductGroupColumn[FT_TNX_CONSTANT].push(RECURRING_PAYMENT_ENABLED_CONSTANT);

		// GROUPING: column options - ends
		
		// CHART-AXIS: column options - starts
		arrProductChartXAxisColumn["FT"].push("sub_product_code");
		arrProductChartXAxisColumn["FT"].push("prod_stat_code");
		arrProductChartXAxisColumn["FT"].push("tnx_type_code");
		arrProductChartXAxisColumn["FT"].push("appl_date");
		arrProductChartXAxisColumn["FT"].push("iss_date");
		arrProductChartXAxisColumn["FT"].push("ft_cur_code");
		arrProductChartXAxisColumn["FT"].push("ft_amt");
		arrProductChartXAxisColumn["FT"].push("Counterparty@counterparty_name");
		arrProductChartXAxisColumn["FT"].push("Counterparty@counterparty_act_no");
		arrProductChartXAxisColumn["FT"].push("Counterparty@cpty_bank_name"); 
		arrProductChartXAxisColumn["FT"].push("applicant_act_name"); 
		arrProductChartXAxisColumn["FT"].push("applicant_act_no"); 
		arrProductChartXAxisColumn["FT"].push("bo_ref_id");
		arrProductChartXAxisColumn["FT"].push("Counterparty@counterparty_dom"); 
		arrProductChartXAxisColumn["FT"].push("Counterparty@cpty_bank_swift_bic_code");
		arrProductChartXAxisColumn["FT"].push("Counterparty@cpty_bank_dom");
		arrProductChartXAxisColumn["FT"].push("Counterparty@cpty_bank_country");
		arrProductChartXAxisColumn["FT"].push("ObjectDataString@beneficiary_bank_branch_dom");
		arrProductChartXAxisColumn["FT"].push("ObjectDataString@intermediary_bank_swift_bic_code");
		arrProductChartXAxisColumn["FT"].push("ObjectDataString@intermediary_bank_name");
		arrProductChartXAxisColumn["FT"].push("ObjectDataString@intermediary_bank_dom");
		arrProductChartXAxisColumn["FT"].push("ObjectDataString@intermediary_bank_country");
		arrProductChartXAxisColumn["FT"].push("ObjectDataString@cnaps_bank_code");
		arrProductChartXAxisColumn["FT"].push("ObjectDataString@cnaps_bank_name");
		arrProductChartXAxisColumn["FT"].push("ObjectDataDate@related_transaction_date");
		arrProductChartXAxisColumn["FT"].push("ObjectDataString@clearing_code");
		arrProductChartXAxisColumn[FT_CONSTANT].push(RECURRING_FREQUENCY_CONSTANT);
		arrProductChartXAxisColumn[FT_CONSTANT].push(RECURRING_NUMBER_TRANSFERS_CONSTANT);
		arrProductChartXAxisColumn[FT_CONSTANT].push(RECURRING_START_DATE_CONSTANT);
		arrProductChartXAxisColumn[FT_CONSTANT].push(RECURRING_END_DATE_CONSTANT);
		arrProductChartXAxisColumn[FT_CONSTANT].push(RECURRING_PAYMENT_ENABLED_CONSTANT);
						
		arrProductChartXAxisColumn["FTTnx"].push("sub_product_code");
		arrProductChartXAxisColumn["FTTnx"].push("prod_stat_code");
		arrProductChartXAxisColumn["FTTnx"].push("tnx_type_code");
		arrProductChartXAxisColumn["FTTnx"].push("appl_date");
		arrProductChartXAxisColumn["FTTnx"].push("iss_date");
		arrProductChartXAxisColumn["FTTnx"].push("ft_cur_code");
		arrProductChartXAxisColumn["FTTnx"].push("ft_amt");
		arrProductChartXAxisColumn["FTTnx"].push("Counterparty@counterparty_name");
		arrProductChartXAxisColumn["FTTnx"].push("Counterparty@counterparty_act_no");
		arrProductChartXAxisColumn["FTTnx"].push("Counterparty@cpty_bank_name");
		arrProductChartXAxisColumn["FTTnx"].push("applicant_act_name");
		arrProductChartXAxisColumn["FTTnx"].push("applicant_act_no");
		arrProductChartXAxisColumn["FTTnx"].push("tnx_stat_code");
		arrProductChartXAxisColumn["FTTnx"].push("sub_tnx_stat_code");
		arrProductChartXAxisColumn["FTTnx"].push("Inputter@last_name");
		arrProductChartXAxisColumn["FTTnx"].push("Inputter@first_name");
		arrProductChartXAxisColumn["FTTnx"].push("inp_dttm");
		arrProductChartXAxisColumn["FTTnx"].push("Releaser@last_name");
		arrProductChartXAxisColumn["FTTnx"].push("Releaser@first_name");
		arrProductChartXAxisColumn["FTTnx"].push("release_dttm");
		arrProductChartXAxisColumn["FTTnx"].push("bo_ref_id");	
		arrProductChartXAxisColumn["FTTnx"].push("Counterparty@counterparty_dom"); 
		arrProductChartXAxisColumn["FTTnx"].push("Counterparty@cpty_bank_swift_bic_code");
		arrProductChartXAxisColumn["FTTnx"].push("Counterparty@cpty_bank_dom");
		arrProductChartXAxisColumn["FTTnx"].push("Counterparty@cpty_bank_country");
		arrProductChartXAxisColumn["FTTnx"].push("ObjectDataString@beneficiary_bank_branch_dom");
		arrProductChartXAxisColumn["FTTnx"].push("ObjectDataString@intermediary_bank_swift_bic_code");
		arrProductChartXAxisColumn["FTTnx"].push("ObjectDataString@intermediary_bank_name");
		arrProductChartXAxisColumn["FTTnx"].push("ObjectDataString@intermediary_bank_dom");
		arrProductChartXAxisColumn["FTTnx"].push("ObjectDataString@intermediary_bank_country");
		arrProductChartXAxisColumn["FTTnx"].push("ObjectDataString@cnaps_bank_code");
		arrProductChartXAxisColumn["FTTnx"].push("ObjectDataString@cnaps_bank_name");
		arrProductChartXAxisColumn["FTTnx"].push("ObjectDataDate@related_transaction_date");
		arrProductChartXAxisColumn["FTTnx"].push("ObjectDataString@clearing_code");
		arrProductChartXAxisColumn[FT_TNX_CONSTANT].push(RECURRING_FREQUENCY_CONSTANT);
		arrProductChartXAxisColumn[FT_TNX_CONSTANT].push(RECURRING_NUMBER_TRANSFERS_CONSTANT);
		arrProductChartXAxisColumn[FT_TNX_CONSTANT].push(RECURRING_START_DATE_CONSTANT);
		arrProductChartXAxisColumn[FT_TNX_CONSTANT].push(RECURRING_END_DATE_CONSTANT);
		arrProductChartXAxisColumn[FT_TNX_CONSTANT].push(RECURRING_PAYMENT_ENABLED_CONSTANT);
		
		// CHART-AXIS: column options - ends
		
		// AGGREGATE: column options - starts
		arrProductAggregateColumn["FT"].push("sub_product_code");
		arrProductAggregateColumn["FT"].push("prod_stat_code");
		arrProductAggregateColumn["FT"].push("tnx_type_code");
		arrProductAggregateColumn["FT"].push("appl_date");
		arrProductAggregateColumn["FT"].push("iss_date");
		arrProductAggregateColumn["FT"].push("ft_cur_code");
		arrProductAggregateColumn["FT"].push("ft_amt");
		arrProductAggregateColumn["FT"].push("Counterparty@counterparty_name");
		arrProductAggregateColumn["FT"].push("Counterparty@counterparty_act_no");
		arrProductAggregateColumn["FT"].push("Counterparty@cpty_bank_name"); 
		arrProductAggregateColumn["FT"].push("applicant_act_name"); 
		arrProductAggregateColumn["FT"].push("applicant_act_no");
		arrProductAggregateColumn["FT"].push("Counterparty@counterparty_dom"); 
		arrProductAggregateColumn["FT"].push("Counterparty@cpty_bank_swift_bic_code");
		arrProductAggregateColumn["FT"].push("Counterparty@cpty_bank_dom");
		arrProductAggregateColumn["FT"].push("Counterparty@cpty_bank_country");
		arrProductAggregateColumn["FT"].push("ObjectDataString@beneficiary_bank_branch_dom");
		arrProductAggregateColumn["FT"].push("ObjectDataString@intermediary_bank_swift_bic_code");
		arrProductAggregateColumn["FT"].push("ObjectDataString@intermediary_bank_name");
		arrProductAggregateColumn["FT"].push("ObjectDataString@intermediary_bank_dom");
		arrProductAggregateColumn["FT"].push("ObjectDataString@intermediary_bank_country");
		arrProductAggregateColumn["FT"].push("ObjectDataString@cnaps_bank_code");
		arrProductAggregateColumn["FT"].push("ObjectDataString@cnaps_bank_name");
		arrProductAggregateColumn["FT"].push("ObjectDataDate@related_transaction_date");
		arrProductAggregateColumn["FT"].push("ObjectDataString@clearing_code");
		arrProductAggregateColumn[FT_CONSTANT].push(RECURRING_FREQUENCY_CONSTANT);
		arrProductAggregateColumn[FT_CONSTANT].push(RECURRING_NUMBER_TRANSFERS_CONSTANT);
		arrProductAggregateColumn[FT_CONSTANT].push(RECURRING_START_DATE_CONSTANT);
		arrProductAggregateColumn[FT_CONSTANT].push(RECURRING_END_DATE_CONSTANT);
		arrProductAggregateColumn[FT_CONSTANT].push(RECURRING_PAYMENT_ENABLED_CONSTANT);
		
		arrProductAggregateColumn["FTTnx"].push("sub_product_code");
		arrProductAggregateColumn["FTTnx"].push("prod_stat_code");
		arrProductAggregateColumn["FTTnx"].push("tnx_type_code");
		arrProductAggregateColumn["FTTnx"].push("appl_date");
		arrProductAggregateColumn["FTTnx"].push("iss_date");
		arrProductAggregateColumn["FTTnx"].push("ft_cur_code");
		arrProductAggregateColumn["FTTnx"].push("ft_amt");
		arrProductAggregateColumn["FTTnx"].push("Counterparty@counterparty_name");
		arrProductAggregateColumn["FTTnx"].push("Counterparty@counterparty_act_no");
		arrProductAggregateColumn["FTTnx"].push("Counterparty@cpty_bank_name");
		arrProductAggregateColumn["FTTnx"].push("applicant_act_name");
		arrProductAggregateColumn["FTTnx"].push("applicant_act_no");
		arrProductAggregateColumn["FTTnx"].push("tnx_stat_code");
		arrProductAggregateColumn["FTTnx"].push("sub_tnx_stat_code");
		arrProductAggregateColumn["FTTnx"].push("Inputter@last_name");
		arrProductAggregateColumn["FTTnx"].push("Inputter@first_name");
		arrProductAggregateColumn["FTTnx"].push("inp_dttm");
		arrProductAggregateColumn["FTTnx"].push("Releaser@last_name");
		arrProductAggregateColumn["FTTnx"].push("Releaser@first_name");
		arrProductAggregateColumn["FTTnx"].push("release_dttm");
		arrProductAggregateColumn["FTTnx"].push("Counterparty@counterparty_dom"); 
		arrProductAggregateColumn["FTTnx"].push("Counterparty@cpty_bank_swift_bic_code");
		arrProductAggregateColumn["FTTnx"].push("Counterparty@cpty_bank_dom");
		arrProductAggregateColumn["FTTnx"].push("Counterparty@cpty_bank_country");
		arrProductAggregateColumn["FTTnx"].push("ObjectDataString@beneficiary_bank_branch_dom");
		arrProductAggregateColumn["FTTnx"].push("ObjectDataString@intermediary_bank_swift_bic_code");
		arrProductAggregateColumn["FTTnx"].push("ObjectDataString@intermediary_bank_name");
		arrProductAggregateColumn["FTTnx"].push("ObjectDataString@intermediary_bank_dom");
		arrProductAggregateColumn["FTTnx"].push("ObjectDataString@intermediary_bank_country");
		arrProductAggregateColumn["FTTnx"].push("ObjectDataString@cnaps_bank_code");
		arrProductAggregateColumn["FTTnx"].push("ObjectDataString@cnaps_bank_name");
		arrProductAggregateColumn["FTTnx"].push("ObjectDataDate@related_transaction_date");
		arrProductAggregateColumn["FTTnx"].push("ObjectDataString@clearing_code");
		arrProductAggregateColumn[FT_TNX_CONSTANT].push(RECURRING_FREQUENCY_CONSTANT);
		arrProductAggregateColumn[FT_TNX_CONSTANT].push(RECURRING_NUMBER_TRANSFERS_CONSTANT);
		arrProductAggregateColumn[FT_TNX_CONSTANT].push(RECURRING_START_DATE_CONSTANT);
		arrProductAggregateColumn[FT_TNX_CONSTANT].push(RECURRING_END_DATE_CONSTANT);
		arrProductAggregateColumn[FT_TNX_CONSTANT].push(RECURRING_PAYMENT_ENABLED_CONSTANT);

		// AGGREGATE: column options - ends
