dojo.provide("misys.report.definitions.report_bg_candidate");


		// Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
		// All Rights Reserved. 
	
		//
		// BG candidate
		//

		// Define an array which stores the BG columns
		

		arrProductColumn["BG"][0] = "ref_id";
		arrProductColumn["BG"][1] = "template_id";
		arrProductColumn["BG"][2] = "bo_ref_id";
		arrProductColumn["BG"][3] = "cust_ref_id";
		arrProductColumn["BG"][7] = "prod_stat_code";
		arrProductColumn["BG"][17] = "appl_date";
		arrProductColumn["BG"][18] = "iss_date";
		arrProductColumn["BG"][19] = "iss_date_type_code";
		arrProductColumn["BG"][20] = "iss_date_type_details";
		arrProductColumn["BG"][21] = "exp_date";
		arrProductColumn["BG"][22] = "exp_date_type_code";
		arrProductColumn["BG"][23] = "amd_date";
		arrProductColumn["BG"][24] = "amd_no";
		arrProductColumn["BG"][25] = "bg_cur_code";
		arrProductColumn["BG"][26] = "bg_amt";
		
		arrProductColumn["BG"][27] = "entity";
		arrProductColumn["BG"][28] = "applicant_name";
		arrProductColumn["BG"][29] = "applicant_address_line_1";
		arrProductColumn["BG"][30] = "applicant_address_line_2";
		arrProductColumn["BG"][31] = "applicant_dom";
		arrProductColumn["BG"][32] = "applicant_country";
		arrProductColumn["BG"][33] = "applicant_reference";
		
		arrProductColumn["BG"][34] = "beneficiary_name";
		arrProductColumn["BG"][35] = "beneficiary_address_line_1";
		arrProductColumn["BG"][36] = "beneficiary_address_line_2";
		arrProductColumn["BG"][37] = "beneficiary_dom";
		arrProductColumn["BG"][38] = "beneficiary_country";
		arrProductColumn["BG"][39] = "beneficiary_reference";
		
		arrProductColumn["BG"][40] = "bg_liab_amt";
		arrProductColumn["BG"][41] = "bg_type_code";
		arrProductColumn["BG"][42] = "bg_type_details";
		arrProductColumn["BG"][43] = "bg_rule";
		arrProductColumn["BG"][44] = "bg_text_type_code";
		arrProductColumn["BG"][45] = "bg_text_type_details";
		arrProductColumn["BG"][46] = "text_language";
		arrProductColumn["BG"][47] = "text_language_other";
		
		arrProductColumn["BG"][48] = "bg_release_flag";
		
		arrProductColumn["BG"][49] = "issuing_bank_type_code";
		arrProductColumn["BG"][50] = "adv_send_mode";
		arrProductColumn["BG"][51] = "contract_ref";
		arrProductColumn["BG"][52] = "contract_date";
		arrProductColumn["BG"][53] = "contract_amt";
		arrProductColumn["BG"][54] = "contract_cur_code";
		arrProductColumn["BG"][55] = "contract_pct";
		arrProductColumn["BG"][56] = "principal_act_no";
		arrProductColumn["BG"][57] = "fee_act_no";
		
		arrProductColumn["BG"][58] = "bg_rule_other";
		
		arrProductColumn["BG"][59] = "renew_flag";
		arrProductColumn["BG"][60] = "renew_on_code";
		arrProductColumn["BG"][61] = "renewal_calendar_date";
		arrProductColumn["BG"][62] = "renew_for_nb";
		arrProductColumn["BG"][63] = "renew_for_period";
		arrProductColumn["BG"][64] = "advise_renewal_flag";
		arrProductColumn["BG"][65] = "advise_renewal_days_nb";
		arrProductColumn["BG"][66] = "rolling_renewal_flag";
		arrProductColumn["BG"][67] = "rolling_renewal_nb";
		arrProductColumn["BG"][68] = "rolling_cancellation_days";
		arrProductColumn["BG"][69] = "renew_amt_code";
		
		arrProductColumn["BG"][70] = "IssuingBank@name";
		arrProductColumn["BG"][71] = "IssuingBank@address_line_1";
		arrProductColumn["BG"][72] = "IssuingBank@address_line_2";
		arrProductColumn["BG"][73] = "IssuingBank@dom";
		
		arrProductColumn["BG"][77] = "AdvisingBank@name";
		arrProductColumn["BG"][78] = "AdvisingBank@address_line_1";
		arrProductColumn["BG"][79] = "AdvisingBank@address_line_2";
		arrProductColumn["BG"][80] = "AdvisingBank@dom";
		arrProductColumn["BG"][81] = "adv_bank_conf_req";
		
		arrProductColumn["BG"][90] = "RecipientBank@abbv_name";
		arrProductColumn["BG"][91] = "RecipientBank@name";
		arrProductColumn["BG"][92] = "RecipientBank@address_line_1";
		arrProductColumn["BG"][93] = "RecipientBank@address_line_2";
		arrProductColumn["BG"][94] = "RecipientBank@dom";
		
		arrProductColumn["BG"][98] = "ConfirmingBank@name";
		arrProductColumn["BG"][99] = "ConfirmingBank@address_line_1";
		arrProductColumn["BG"][100] = "ConfirmingBank@address_line_2";
		arrProductColumn["BG"][101] = "ConfirmingBank@dom";
		
		//arrProductColumn["BG"][104] = "Narrative@additionalInstructions";
		
		arrProductColumn["BG"][110]= "Charge@chrg_code";
		arrProductColumn["BG"][111]= "Charge@amt";
		arrProductColumn["BG"][112]= "Charge@cur_code";
		arrProductColumn["BG"][113]= "Charge@status";
		arrProductColumn["BG"][114] = "Charge@additional_comment";
		arrProductColumn["BG"][115] = "Charge@settlement_date";
		
		// Object Data
		arrProductColumn["BG"][116] = "ObjectDataString@mur_codes_sent";
		arrProductColumn["BG"][117] = "ObjectDataString@mur_codes_ack";
		arrProductColumn["BG"][118] = "ObjectDataString@mur_codes_nak";
		
		arrProductColumn["BG"][160] = "exp_event";
		arrProductColumn["BG"][161] = "reduction_authorised";
		arrProductColumn["BG"][162] = "reduction_clause";
		arrProductColumn["BG"][163] = "reduction_clause_other";
		arrProductColumn["BG"][164] = "contact_name";
		arrProductColumn["BG"][165] = "contact_address_line_1";
		arrProductColumn["BG"][166] = "contact_address_line_2";
		arrProductColumn["BG"][167] = "contact_dom";
		arrProductColumn["BG"][168] = "contact_country";
		arrProductColumn["BG"][169] = "for_account";
		arrProductColumn["BG"][170] = "alt_applicant_name";
		arrProductColumn["BG"][171] = "alt_applicant_address_line_1";
		arrProductColumn["BG"][172] = "alt_applicant_address_line_2";
		arrProductColumn["BG"][173] = "alt_applicant_dom";
		arrProductColumn["BG"][174] = "alt_applicant_country";
		arrProductColumn["BG"][175] = "consortium";
		arrProductColumn["BG"][176] = "net_exposure_cur_code";
		arrProductColumn["BG"][177] = "net_exposure_amt";
		arrProductColumn["BG"][178] = "character_commitment";
		arrProductColumn["BG"][179] = "delivery_to";
		arrProductColumn["BG"][180] = "delivery_to_other";
		arrProductColumn["BG"][181] = "final_expiry_date";
		arrProductColumn["BG"][183] = "claim_cur_code";
		arrProductColumn["BG"][184] = "claim_amt";
		arrProductColumn["BG"][185] = "claim_reference";
		arrProductColumn["BG"][186] = "claim_present_date";
		arrProductColumn["BG"][187] = "doc_ref_no";
		arrProductColumn["BG"][188] = "rolling_renew_for_nb";
		arrProductColumn["BG"][189] = "rolling_day_in_month";
		arrProductColumn["BG"][190] = "rolling_renew_for_period";
		arrProductColumn["BG"][191] = "rolling_renew_on_code";
		arrProductColumn["BG"][192] = "projected_expiry_date";
		arrProductColumn["BG"][193] = "contract_narrative";
		arrProductColumn["BG"][194] = "tender_expiry_date";
		arrProductColumn["BG"][195] = "bg_available_amt";
		arrProductColumn["BG"][202] = "adv_send_mode_text";
		
		
		
		
		//
		// BG Transaction candidate
		//

		// Define an array which stores the BG Transaction columns
		

		arrProductColumn["BGTnx"][0] = "ref_id";
		arrProductColumn["BGTnx"][1] = "template_id";
		arrProductColumn["BGTnx"][2] = "bo_ref_id";
		arrProductColumn["BGTnx"][3] = "bo_tnx_id";
		arrProductColumn["BGTnx"][4] = "cust_ref_id";
		arrProductColumn["BGTnx"][5] = "tnx_type_code";
		arrProductColumn["BGTnx"][6] = "sub_tnx_type_code";
		arrProductColumn["BGTnx"][7] = "prod_stat_code";
		arrProductColumn["BGTnx"][14] = "tnx_val_date";
		arrProductColumn["BGTnx"][15] = "tnx_amt";
		arrProductColumn["BGTnx"][16] = "tnx_cur_code";
		arrProductColumn["BGTnx"][17] = "tnx_stat_code";
		
		arrProductColumn["BGTnx"][18] = "appl_date";
		arrProductColumn["BGTnx"][19] = "iss_date";
		arrProductColumn["BGTnx"][20] = "iss_date_type_code";
		arrProductColumn["BGTnx"][21] = "iss_date_type_details";
		arrProductColumn["BGTnx"][22] = "exp_date";
		arrProductColumn["BGTnx"][23] = "exp_date_type_code";
		arrProductColumn["BGTnx"][24] = "amd_date";
		arrProductColumn["BGTnx"][25] = "amd_no";
		arrProductColumn["BGTnx"][26] = "bg_cur_code";
		arrProductColumn["BGTnx"][27] = "bg_amt";
		arrProductColumn["BGTnx"][28] = "bg_liab_amt";
		arrProductColumn["BGTnx"][29] = "bg_type_code";
		arrProductColumn["BGTnx"][30] = "bg_type_details";
		arrProductColumn["BGTnx"][31] = "bg_rule";
		arrProductColumn["BGTnx"][32] = "bg_text_type_code";
		arrProductColumn["BGTnx"][33] = "bg_text_type_details";
		arrProductColumn["BGTnx"][34] = "bg_release_flag";
		arrProductColumn["BGTnx"][35] = "entity";
		arrProductColumn["BGTnx"][36] = "beneficiary_name";
		arrProductColumn["BGTnx"][37] = "beneficiary_address_line_1";
		arrProductColumn["BGTnx"][38] = "beneficiary_address_line_2";
		arrProductColumn["BGTnx"][39] = "beneficiary_dom";
		arrProductColumn["BGTnx"][40] = "beneficiary_country";
		arrProductColumn["BGTnx"][41] = "beneficiary_reference";
		
		arrProductColumn["BGTnx"][42] = "applicant_name";
		arrProductColumn["BGTnx"][43] = "applicant_address_line_1";
		arrProductColumn["BGTnx"][44] = "applicant_address_line_2";
		arrProductColumn["BGTnx"][45] = "applicant_dom";
		arrProductColumn["BGTnx"][46] = "applicant_country";
		arrProductColumn["BGTnx"][47] = "applicant_reference";
		
		arrProductColumn["BGTnx"][48] = "issuing_bank_type_code";
		
		arrProductColumn["BGTnx"][49] = "contract_ref";
		arrProductColumn["BGTnx"][50] = "contract_date";
		arrProductColumn["BGTnx"][51] = "contract_amt";
		arrProductColumn["BGTnx"][52] = "contract_cur_code";
		arrProductColumn["BGTnx"][53] = "contract_pct";
		arrProductColumn["BGTnx"][54] = "principal_act_no";
		arrProductColumn["BGTnx"][55] = "fee_act_no";
		
		arrProductColumn["BGTnx"][56] = "text_language";
		arrProductColumn["BGTnx"][57] = "text_language_other";
		
		arrProductColumn["BGTnx"][58] = "bg_rule_other";
		
		arrProductColumn["BGTnx"][59] = "renew_flag";
		arrProductColumn["BGTnx"][60] = "renew_on_code";
		arrProductColumn["BGTnx"][61] = "renewal_calendar_date";
		arrProductColumn["BGTnx"][62] = "renew_for_nb";
		arrProductColumn["BGTnx"][63] = "renew_for_period";
		arrProductColumn["BGTnx"][64] = "advise_renewal_flag";
		arrProductColumn["BGTnx"][65] = "advise_renewal_days_nb";
		arrProductColumn["BGTnx"][66] = "rolling_renewal_flag";
		arrProductColumn["BGTnx"][67] = "rolling_renewal_nb";
		arrProductColumn["BGTnx"][68] = "rolling_cancellation_days";
		arrProductColumn["BGTnx"][69] = "renew_amt_code";
		
		arrProductColumn["BGTnx"][70] = "IssuingBank@name";
		arrProductColumn["BGTnx"][71] = "IssuingBank@address_line_1";
		arrProductColumn["BGTnx"][72] = "IssuingBank@address_line_2";
		arrProductColumn["BGTnx"][73] = "IssuingBank@dom";
		
		arrProductColumn["BGTnx"][77] = "AdvisingBank@name";
		arrProductColumn["BGTnx"][78] = "AdvisingBank@address_line_1";
		arrProductColumn["BGTnx"][79] = "AdvisingBank@address_line_2";
		arrProductColumn["BGTnx"][80] = "AdvisingBank@dom";
		arrProductColumn["BGTnx"][81] = "adv_bank_conf_req";
		
		arrProductColumn["BGTnx"][90] = "RecipientBank@abbv_name";
		arrProductColumn["BGTnx"][91] = "RecipientBank@name";
		arrProductColumn["BGTnx"][92] = "RecipientBank@address_line_1";
		arrProductColumn["BGTnx"][93] = "RecipientBank@address_line_2";
		arrProductColumn["BGTnx"][94] = "RecipientBank@dom";
		
		arrProductColumn["BGTnx"][98] = "ConfirmingBank@name";
		arrProductColumn["BGTnx"][99] = "ConfirmingBank@address_line_1";
		arrProductColumn["BGTnx"][100] = "ConfirmingBank@address_line_2";
		arrProductColumn["BGTnx"][101] = "ConfirmingBank@dom";
		
		/*arrProductColumn["BGTnx"][104] = "Narrative@additionalInstructions";
		arrProductColumn["BGTnx"][105] = "Narrative@boComment";
		arrProductColumn["BGTnx"][106] = "Narrative@freeFormatText";
		arrProductColumn["BGTnx"][107] = "Narrative@amdDetails";	*/	

		arrProductColumn["BGTnx"][130] = "Inputter@last_name";
		arrProductColumn["BGTnx"][131] = "Inputter@first_name";
		arrProductColumn["BGTnx"][132] = "inp_dttm";
		/*arrProductColumn["BGTnx"][133] = "Controller@last_name";
		arrProductColumn["BGTnx"][134] = "Controller@first_name";*/
		arrProductColumn["BGTnx"][135] = "LastController@validation_dttm";
		arrProductColumn["BGTnx"][136] = "Releaser@last_name";
		arrProductColumn["BGTnx"][137] = "Releaser@first_name";
		arrProductColumn["BGTnx"][138] = "release_dttm";

		arrProductColumn["BGTnx"][139] = "Charge@chrg_code";
		arrProductColumn["BGTnx"][140] = "Charge@amt";
		arrProductColumn["BGTnx"][141] = "Charge@cur_code";
		arrProductColumn["BGTnx"][142] = "Charge@status";
		arrProductColumn["BGTnx"][143] = "Charge@additional_comment";
		arrProductColumn["BGTnx"][144] = "Charge@settlement_date";
		
		arrProductColumn["BGTnx"][145] = "bo_release_dttm";
		
		// Object Data
		arrProductColumn["BGTnx"][146] = "ObjectDataString@mur_codes_sent";
		arrProductColumn["BGTnx"][147] = "ObjectDataString@mur_codes_ack";
		arrProductColumn["BGTnx"][148] = "ObjectDataString@mur_codes_nak";
	
		// TODO: add the following entries at the right place, let in comment until field not added in screens
		//arrProductColumn["BG"][120] = "beneficiary_country";
		//arrProductColumn["BG"][121] = "applicant_country";
		
		//arrProductColumn["BGTnx"][150] = "beneficiary_country";
		//arrProductColumn["BGTnx"][151] = "applicant_country";
		
		arrProductColumn["BGTnx"][160] = "exp_event";
		arrProductColumn["BGTnx"][161] = "reduction_authorised";
		arrProductColumn["BGTnx"][162] = "reduction_clause";
		arrProductColumn["BGTnx"][163] = "reduction_clause_other";
		arrProductColumn["BGTnx"][164] = "contact_name";
		arrProductColumn["BGTnx"][165] = "contact_address_line_1";
		arrProductColumn["BGTnx"][166] = "contact_address_line_2";
		arrProductColumn["BGTnx"][167] = "contact_dom";
		arrProductColumn["BGTnx"][168] = "contact_country";
		arrProductColumn["BGTnx"][169] = "for_account";
		arrProductColumn["BGTnx"][170] = "alt_applicant_name";
		arrProductColumn["BGTnx"][171] = "alt_applicant_address_line_1";
		arrProductColumn["BGTnx"][172] = "alt_applicant_address_line_2";
		arrProductColumn["BGTnx"][173] = "alt_applicant_dom";
		arrProductColumn["BGTnx"][174] = "alt_applicant_country";
		arrProductColumn["BGTnx"][175] = "consortium";
		arrProductColumn["BGTnx"][176] = "net_exposure_cur_code";
		arrProductColumn["BGTnx"][177] = "net_exposure_amt";
		arrProductColumn["BGTnx"][178] = "character_commitment";
		arrProductColumn["BGTnx"][179] = "delivery_to";
		arrProductColumn["BGTnx"][180] = "delivery_to_other";
		arrProductColumn["BGTnx"][181] = "sub_tnx_stat_code";
		arrProductColumn["BGTnx"][182] = "final_expiry_date";
		arrProductColumn["BGTnx"][183] = "claim_cur_code";
		arrProductColumn["BGTnx"][184] = "claim_amt";
		arrProductColumn["BGTnx"][185] = "claim_reference";
		arrProductColumn["BGTnx"][186] = "claim_present_date";
		arrProductColumn["BGTnx"][187] = "doc_ref_no";
		arrProductColumn["BGTnx"][188] = "rolling_renew_for_nb";
		arrProductColumn["BGTnx"][189] = "rolling_day_in_month";
		arrProductColumn["BGTnx"][190] = "rolling_renew_for_period";
		arrProductColumn["BGTnx"][191] = "rolling_renew_on_code";
		arrProductColumn["BGTnx"][192] = "projected_expiry_date";
		arrProductColumn["BGTnx"][193] = "contract_narrative";
		arrProductColumn["BGTnx"][194] = "tender_expiry_date";
		arrProductColumn["BGTnx"][195] = "bg_available_amt";
		arrProductColumn["BGTnx"][207] = "LastController@LastControllerUser@first_name";
		arrProductColumn["BGTnx"][208] = "LastController@LastControllerUser@last_name";
		arrProductColumn["BGTnx"][220] = "adv_send_mode_text";
		
		
