dojo.provide("misys.report.definitions.report_iu_candidate");


		// Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
		// All Rights Reserved. 
	
		//
		// Existing IU Fields candidate
		//

		// Define an array which stores the IU columns
		

		arrProductColumn["BG"][0] = "ref_id";
		arrProductColumn["BG"][1] = "template_id";
		arrProductColumn["BG"][2] = "bo_ref_id";
		arrProductColumn["BG"][3] = "cust_ref_id";
		arrProductColumn["BG"][4] = "prod_stat_code";
		arrProductColumn["BG"][5] = "appl_date";
		arrProductColumn["BG"][6] = "iss_date";
		arrProductColumn["BG"][7] = "iss_date_type_code";
		arrProductColumn["BG"][8] = "iss_date_type_details";
		arrProductColumn["BG"][9] = "exp_date";
		arrProductColumn["BG"][10] = "exp_date_type_code";
		arrProductColumn["BG"][11] = "amd_date";
		arrProductColumn["BG"][12] = "amd_no";
		arrProductColumn["BG"][13] = "bg_cur_code";
		arrProductColumn["BG"][14] = "bg_amt";
		
		arrProductColumn["BG"][15] = "entity";
		arrProductColumn["BG"][16] = "applicant_name";
		arrProductColumn["BG"][17] = "applicant_address_line_1";
		arrProductColumn["BG"][18] = "applicant_address_line_2";
		arrProductColumn["BG"][19] = "applicant_dom";
		arrProductColumn["BG"][20] = "applicant_country";
		arrProductColumn["BG"][21] = "applicant_reference";
		
		arrProductColumn["BG"][22] = "beneficiary_name";
		arrProductColumn["BG"][23] = "beneficiary_address_line_1";
		arrProductColumn["BG"][24] = "beneficiary_address_line_2";
		arrProductColumn["BG"][25] = "beneficiary_dom";
		arrProductColumn["BG"][26] = "beneficiary_country";
		arrProductColumn["BG"][27] = "beneficiary_reference";
	
		arrProductColumn["BG"][28] = "bg_liab_amt";
		arrProductColumn["BG"][29] = "bg_type_code";
		arrProductColumn["BG"][30] = "bg_type_details";
		arrProductColumn["BG"][31] = "bg_rule";
		arrProductColumn["BG"][32] = "bg_text_type_code";
		arrProductColumn["BG"][33] = "bg_text_type_details";
		arrProductColumn["BG"][34] = "text_language";
		arrProductColumn["BG"][35] = "text_language_other";
		
		arrProductColumn["BG"][36] = "bg_release_flag";
	
		arrProductColumn["BG"][37] = "issuing_bank_type_code";
		arrProductColumn["BG"][38] = "adv_send_mode";
		arrProductColumn["BG"][39] = "contract_ref";
		arrProductColumn["BG"][40] = "contract_date";
		arrProductColumn["BG"][41] = "contract_amt";
		arrProductColumn["BG"][42] = "contract_cur_code";
		arrProductColumn["BG"][43] = "contract_pct";
		arrProductColumn["BG"][44] = "principal_act_no";
		arrProductColumn["BG"][45] = "fee_act_no";
		
		arrProductColumn["BG"][46] = "bg_rule_other";
		
		arrProductColumn["BG"][47] = "renew_flag";
		arrProductColumn["BG"][48] = "renew_on_code";
		arrProductColumn["BG"][49] = "renewal_calendar_date";
		arrProductColumn["BG"][50] = "renew_for_nb";
		arrProductColumn["BG"][51] = "renew_for_period";
		arrProductColumn["BG"][52] = "advise_renewal_flag";
		arrProductColumn["BG"][53] = "advise_renewal_days_nb";
		arrProductColumn["BG"][54] = "rolling_renewal_flag";
		arrProductColumn["BG"][55] = "rolling_renewal_nb";
		arrProductColumn["BG"][56] = "rolling_cancellation_days";
		arrProductColumn["BG"][57] = "renew_amt_code";
		
		arrProductColumn["BG"][58] = "IssuingBank@name";
		arrProductColumn["BG"][59] = "IssuingBank@address_line_1";
		arrProductColumn["BG"][60] = "IssuingBank@address_line_2";
		arrProductColumn["BG"][61] = "IssuingBankIU@dom";
		
		arrProductColumn["BG"][62] = "AdvisingBank@name";
		arrProductColumn["BG"][63] = "AdvisingBank@address_line_1";
		arrProductColumn["BG"][64] = "AdvisingBank@address_line_2";
		arrProductColumn["BG"][65] = "AdvisingBankIU@dom";
		arrProductColumn["BG"][66] = "adv_bank_conf_req";

		arrProductColumn["BG"][67] = "RecipientBank@name";
	
		arrProductColumn["BG"][68] = "ConfirmingBank@name";
		arrProductColumn["BG"][69] = "ConfirmingBank@address_line_1";
		arrProductColumn["BG"][70] = "ConfirmingBank@address_line_2";
		arrProductColumn["BG"][71] = "ConfirmingBank@dom";
	
		arrProductColumn["BG"][72]= "Charge@chrg_code";
		arrProductColumn["BG"][73]= "Charge@amt";
		arrProductColumn["BG"][74]= "Charge@cur_code";
		arrProductColumn["BG"][75]= "Charge@status";
		arrProductColumn["BG"][76] = "Charge@additional_comment";
		arrProductColumn["BG"][77] = "Charge@settlement_date";
	
		// Object Data
		arrProductColumn["BG"][78] = "ObjectDataString@mur_codes_sent";
		arrProductColumn["BG"][79] = "ObjectDataString@mur_codes_ack";
		arrProductColumn["BG"][80] = "ObjectDataString@mur_codes_nak";
		
		arrProductColumn["BG"][81] = "exp_event";
		arrProductColumn["BG"][82] = "contact_name";
		arrProductColumn["BG"][83] = "contact_address_line_1";
		arrProductColumn["BG"][84] = "contact_address_line_2";
		arrProductColumn["BG"][85] = "contact_dom";
		arrProductColumn["BG"][86] = "contact_country";
		arrProductColumn["BG"][87] = "for_account";
		arrProductColumn["BG"][88] = "alt_applicant_name";
		arrProductColumn["BG"][89] = "alt_applicant_address_line_1";
		arrProductColumn["BG"][90] = "alt_applicant_address_line_2";
		arrProductColumn["BG"][91] = "IssuedUndertaking@alt_applicant_dom";
		arrProductColumn["BG"][92] = "alt_applicant_country";
		arrProductColumn["BG"][93] = "consortium";
		arrProductColumn["BG"][94] = "net_exposure_cur_code";
		arrProductColumn["BG"][95] = "net_exposure_amt";
		arrProductColumn["BG"][96] = "character_commitment";
		arrProductColumn["BG"][97] = "delivery_to";
		arrProductColumn["BG"][98] = "delivery_to_other";
		arrProductColumn["BG"][99] = "final_expiry_date";
		arrProductColumn["BG"][100] = "claim_cur_code";
		arrProductColumn["BG"][101] = "claim_amt";
		arrProductColumn["BG"][102] = "claim_reference";
		arrProductColumn["BG"][103] = "claim_present_date";
		arrProductColumn["BG"][104] = "doc_ref_no";
		arrProductColumn["BG"][105] = "rolling_renew_for_nb";
		arrProductColumn["BG"][106] = "rolling_day_in_month";
		arrProductColumn["BG"][107] = "rolling_renew_for_period";
		arrProductColumn["BG"][108] = "rolling_renew_on_code";
		arrProductColumn["BG"][109] = "projected_expiry_date";
		arrProductColumn["BG"][110] = "contract_narrative";
		arrProductColumn["BG"][111] = "tender_expiry_date";
		arrProductColumn["BG"][112] = "bg_available_amt";
	
		// IU feilds
		arrProductColumn["BG"][113] = "additional_cust_ref";
		arrProductColumn["BG"][114] = "purpose";
		arrProductColumn["BG"][115] = "approx_expiry_date";
		arrProductColumn["BG"][116] = "bei_code";
		arrProductColumn["BG"][117] = "bg_conf_instructions";
		arrProductColumn["BG"][118] = "bg_govern_country";
		arrProductColumn["BG"][119] = "bg_govern_text";
		arrProductColumn["BG"][121] = "bg_special_terms";
		arrProductColumn["BG"][122] = "send_attachments_by";
		
		arrProductColumn["BG"][123] = "cu_effective_date_type_code";
		arrProductColumn["BG"][124] = "cu_exp_date_type_code";
		arrProductColumn["BG"][125] = "cu_exp_date";
		arrProductColumn["BG"][126] = "cu_effective_date_type_details";
	
		arrProductColumn["BG"][127] = "CUBeneProductPartyDetails@name";
		arrProductColumn["BG"][128] = "CUBeneProductPartyDetails@bei_code";
		arrProductColumn["BG"][129] = "CUBeneProductPartyDetails@address_line_1";
		arrProductColumn["BG"][130] = "CUBeneProductPartyDetails@address_line_2";
		arrProductColumn["BG"][131] = "CUBeneProductPartyDetails@dom";
		arrProductColumn["BG"][132] = "CUBeneProductPartyDetails@address_line_4";
		arrProductColumn["BG"][133] = "CUBeneProductPartyDetails@country";
		arrProductColumn["BG"][134] = "CUContactProductPartyDetails@name";
		arrProductColumn["BG"][135] = "CUContactProductPartyDetails@address_line_1";
		arrProductColumn["BG"][136] = "CUContactProductPartyDetails@address_line_2";
		arrProductColumn["BG"][137] = "CUContactProductPartyDetails@address_line_4";
		arrProductColumn["BG"][138] = "CUContactProductPartyDetails@dom";
	
		arrProductColumn["BG"][139] = "cu_sub_product_code";
		arrProductColumn["BG"][140] = "cu_cur_code";
		arrProductColumn["BG"][141] = "cu_amt";
		arrProductColumn["BG"][142] = "cu_tolerance_positive_pct";
		arrProductColumn["BG"][143] = "cu_tolerance_negative_pct";
		arrProductColumn["BG"][144] = "cu_consortium";
		arrProductColumn["BG"][145] = "cu_net_exposure_amt";
		arrProductColumn["BG"][146] = "cu_net_exposure_cur_code";

		arrProductColumn["BG"][147] = "cu_renew_flag";
		arrProductColumn["BG"][148] = "cu_renew_on_code";
		arrProductColumn["BG"][149] = "cu_renewal_calendar_date";
		arrProductColumn["BG"][150] = "cu_renew_for_nb";
		arrProductColumn["BG"][151] = "cu_renew_for_period";
		arrProductColumn["BG"][152] = "cu_advise_renewal_flag";
		arrProductColumn["BG"][153] = "cu_advise_renewal_days_nb";
		arrProductColumn["BG"][154] = "cu_rolling_renewal_flag";
		arrProductColumn["BG"][155] = "cu_rolling_renew_on_code";
		arrProductColumn["BG"][156] = "cu_rolling_renew_for_period";
		arrProductColumn["BG"][157] = "cu_rolling_day_in_month";
		arrProductColumn["BG"][158] = "cu_rolling_renewal_nb";
		arrProductColumn["BG"][159] = "cu_rolling_cancellation_days";
		arrProductColumn["BG"][160] = "cu_renew_amt_code";
		arrProductColumn["BG"][161] = "cu_final_expiry_date";
		
		arrProductColumn["BG"][162] = "cu_type_code";
		arrProductColumn["BG"][163] = "cu_rule";
		arrProductColumn["BG"][164] = "cu_rule_other";
		arrProductColumn["BG"][165] = "cu_govern_country";
		arrProductColumn["BG"][166] = "cu_govern_text";
		arrProductColumn["BG"][167] = "cu_text_language";
		arrProductColumn["BG"][168] = "cu_text_language_other";

		arrProductColumn["BG"][169] = "applicant_address_line_4";
		arrProductColumn["BG"][170] = "alt_applicant_address_line_4";
		arrProductColumn["BG"][171] = "beneficiary_address_line_4";
		arrProductColumn["BG"][172] = "contact_address_line_4";
		arrProductColumn["BG"][173] = "IssuedUndertaking@sub_product_code";
		arrProductColumn["BG"][174] = "bg_transfer_indicator";
		
		arrProductColumn["BG"][175] = "AdviseThruBank@name";
		arrProductColumn["BG"][176] = "AdviseThruBank@address_line_1";
		arrProductColumn["BG"][177] = "AdviseThruBank@address_line_2";
		arrProductColumn["BG"][178] = "AdviseThruBank@dom";
	
		arrProductColumn["BG"][179] = "ProcessingBank@name";
		arrProductColumn["BG"][180] = "ProcessingBank@address_line_1";
		arrProductColumn["BG"][181] = "ProcessingBank@address_line_2";
		arrProductColumn["BG"][182] = "ProcessingBank@dom";
		
		arrProductColumn["BG"][183] = "CURecipientBank@abbv_name";
		arrProductColumn["BG"][184] = "CURecipientBank@address_line_1";
		arrProductColumn["BG"][185] = "CURecipientBank@address_line_2";
		arrProductColumn["BG"][186] = "CURecipientBank@dom";
		arrProductColumn["BG"][187] = "CURecipientBank@address_line_4";
		arrProductColumn["BG"][188] = "CURecipientBank@iso_code";
		arrProductColumn["BG"][189] = "CURecipientBank@reference";
		
		arrProductColumn["BG"][190] = "cu_rolling_renew_for_nb";
		arrProductColumn["BG"][191] = "RecipientBank@iso_code";
		arrProductColumn["BG"][192] = "IssuingBank@address_line_4";
		arrProductColumn["BG"][193] = "AdvisingBank@address_line_4";
		arrProductColumn["BG"][194] = "ConfirmingBank@address_line_4";
		arrProductColumn["BG"][195] = "AdviseThruBank@address_line_4";
		arrProductColumn["BG"][196] = "ProcessingBank@address_line_4";
		arrProductColumn["BG"][197] = "provisional_status";
		arrProductColumn["BG"][198] = "cu_demand_indicator";
		arrProductColumn["BG"][199] = "cu_transfer_indicator";
		arrProductColumn["BG"][200] = "cu_text_type_code";
		arrProductColumn["BG"][201] = "cu_text_type_details";
		arrProductColumn["BG"][202] = "adv_send_mode_text";
		arrProductColumn["BG"][203] = "delv_org_undertaking";
		arrProductColumn["BG"][204] = "delv_org_undertaking_text";
	
		arrProductColumn["BG"][205] = "IssuingBank@iso_code";
		arrProductColumn["BG"][206] = "AdvisingBank@iso_code";
		arrProductColumn["BG"][207] = "ConfirmingBank@iso_code";
		arrProductColumn["BG"][208] = "AdviseThruBank@iso_code";
		arrProductColumn["BG"][209] = "ProcessingBank@iso_code";
		arrProductColumn["BG"][210] = "lead_bank_flag";
		arrProductColumn["BG"][211] = "cu_conf_instructions";
		arrProductColumn["BG"][212] = "bg_outstanding_amt";
		arrProductColumn["BG"][213] = "bg_tolerance_positive_pct";
		arrProductColumn["BG"][214] = "bg_tolerance_negative_pct";
		arrProductColumn["BG"][215] = "Variation@type";
		arrProductColumn["BG"][216] = "Variation@advise_flag";
		arrProductColumn["BG"][217] = "Variation@advise_reduction_days";
		arrProductColumn["BG"][218] = "Variation@operation";
		arrProductColumn["BG"][219] = "Variation@maximum_nb_days";
		arrProductColumn["BG"][220] = "Variation@frequency";
		arrProductColumn["BG"][221] = "Variation@period";
		arrProductColumn["BG"][222] = "Variation@day_in_month";
		arrProductColumn["BG"][223] = "Variation@first_date";
		arrProductColumn["BG"][224] = "Variation@percentage";
		arrProductColumn["BG"][225] = "Variation@cur_code";
		arrProductColumn["BG"][226] = "Variation@amount";
		arrProductColumn["BG"][227] = "Variation@section_type";
		arrProductColumn["BG"][228] = "renewal_type";
		arrProductColumn["BG"][229] = "cu_renewal_type";
		arrProductColumn["BG"][232] = "ship_from";
		arrProductColumn["BG"][233] = "ship_loading";
		arrProductColumn["BG"][234] = "ship_discharge";
		arrProductColumn["BG"][235] = "ship_to";
		arrProductColumn["BG"][236] = "part_ship_detl";
		arrProductColumn["BG"][237] = "tran_ship_detl";
		arrProductColumn["BG"][238] = "last_ship_date";
		arrProductColumn["BG"][239] = "inco_term_year";
		arrProductColumn["BG"][240] = "inco_term";
		arrProductColumn["BG"][241] = "inco_place";
		arrProductColumn["BG"][242] = "cr_avl_by_code";
		arrProductColumn["BG"][243] = "cu_cr_avl_by_code";
		arrProductColumn["BG"][244] = "req_conf_party";

		arrProductColumn["BG"][245] = "RequestedConfirmationParty@name";
		arrProductColumn["BG"][246] = "RequestedConfirmationParty@address_line_1";
		arrProductColumn["BG"][247] = "RequestedConfirmationParty@address_line_2";
		arrProductColumn["BG"][248] = "RequestedConfirmationParty@dom";
		arrProductColumn["BG"][249] = "RequestedConfirmationParty@address_line_4";
		arrProductColumn["BG"][250] = "RequestedConfirmationParty@iso_code";
		
		arrProductColumn["BG"][251] = "CreditAvailableWithBank@name";
		arrProductColumn["BG"][252] = "CreditAvailableWithBank@address_line_1";
		arrProductColumn["BG"][253] = "CreditAvailableWithBank@address_line_2";
		arrProductColumn["BG"][254] = "CreditAvailableWithBank@dom";
		arrProductColumn["BG"][255] = "CreditAvailableWithBank@address_line_4";
		arrProductColumn["BG"][256] = "CreditAvailableWithBank@iso_code";
		
		arrProductColumn["BG"][257] = "CUCreditAvailableWithBank@name";
		arrProductColumn["BG"][258] = "CUCreditAvailableWithBank@address_line_1";
		arrProductColumn["BG"][259] = "CUCreditAvailableWithBank@address_line_2";
		arrProductColumn["BG"][260] = "CUCreditAvailableWithBank@dom";
		arrProductColumn["BG"][261] = "CUCreditAvailableWithBank@address_line_4";
		arrProductColumn["BG"][262] = "CUCreditAvailableWithBank@iso_code";
	
		arrProductColumn["BG"][263] = "maturity_date";
		arrProductColumn["BG"][264] = "latest_response_date";
		arrProductColumn["BG"][265] = "action_req_code";
		
		arrProductColumn["BG"][266] = "cu_corr_chrg_brn_by_code";
		arrProductColumn["BG"][267] = "cu_open_chrg_brn_by_code";
		arrProductColumn["BG"][268] = "cu_conf_chrg_brn_by_code";
		arrProductColumn["BG"][269] = "corr_chrg_brn_by_code";
		arrProductColumn["BG"][270] = "open_chrg_brn_by_code";
		arrProductColumn["BG"][271] = "conf_chrg_brn_by_code";
		arrProductColumn["BG"][272] = "cu_liab_amt";
		arrProductColumn["BG"][273] = "cu_available_amt";	
		arrProductColumn["BG"][274] = "bg_demand_indicator";
		arrProductColumn["BG"][275] = "Narrative@underlyingTransactionDetails";
		arrProductColumn["BG"][276] = "Narrative@textOfUndertaking";
		
		// Define an array which stores the IU Transaction columns
		//
		// IU Transaction candidate
		//

		arrProductColumn["BGTnx"][0] = "ref_id";
		arrProductColumn["BGTnx"][1] = "template_id";
		arrProductColumn["BGTnx"][2] = "bo_ref_id";
		arrProductColumn["BGTnx"][3] = "bo_tnx_id";
		arrProductColumn["BGTnx"][4] = "cust_ref_id";
		arrProductColumn["BGTnx"][5] = "tnx_type_code";
		arrProductColumn["BGTnx"][6] = "sub_tnx_type_code";
		arrProductColumn["BGTnx"][7] = "prod_stat_code";
		arrProductColumn["BGTnx"][8] = "tnx_val_date";
		arrProductColumn["BGTnx"][9] = "tnx_amt";
		arrProductColumn["BGTnx"][10] = "tnx_cur_code";
		arrProductColumn["BGTnx"][11] = "tnx_stat_code";
		
		arrProductColumn["BGTnx"][12] = "appl_date";
		arrProductColumn["BGTnx"][13] = "iss_date";
		arrProductColumn["BGTnx"][14] = "iss_date_type_code";
		arrProductColumn["BGTnx"][15] = "iss_date_type_details";
		arrProductColumn["BGTnx"][16] = "extended_date";
		arrProductColumn["BGTnx"][17] = "exp_date";
		arrProductColumn["BGTnx"][18] = "exp_date_type_code";
		arrProductColumn["BGTnx"][19] = "amd_date";
		arrProductColumn["BGTnx"][20] = "amd_no";
		arrProductColumn["BGTnx"][21] = "bg_cur_code";
		arrProductColumn["BGTnx"][22] = "bg_amt";
		arrProductColumn["BGTnx"][23] = "bg_liab_amt";
		arrProductColumn["BGTnx"][24] = "bg_type_code";
		arrProductColumn["BGTnx"][25] = "bg_type_details";
		arrProductColumn["BGTnx"][26] = "bg_rule";
		arrProductColumn["BGTnx"][27] = "bg_text_type_code";
		arrProductColumn["BGTnx"][28] = "bg_text_type_details";
		arrProductColumn["BGTnx"][29] = "bg_release_flag";
		arrProductColumn["BGTnx"][30] = "entity";
		arrProductColumn["BGTnx"][31] = "beneficiary_name";
		arrProductColumn["BGTnx"][32] = "beneficiary_address_line_1";
		arrProductColumn["BGTnx"][33] = "beneficiary_address_line_2";
		arrProductColumn["BGTnx"][34] = "beneficiary_dom";
		arrProductColumn["BGTnx"][35] = "beneficiary_country";
		arrProductColumn["BGTnx"][36] = "beneficiary_reference";

		arrProductColumn["BGTnx"][37] = "applicant_name";
		arrProductColumn["BGTnx"][38] = "applicant_address_line_1";
		arrProductColumn["BGTnx"][39] = "applicant_address_line_2";
		arrProductColumn["BGTnx"][40] = "applicant_dom";
		arrProductColumn["BGTnx"][41] = "applicant_country";
		arrProductColumn["BGTnx"][42] = "applicant_reference";

		arrProductColumn["BGTnx"][43] = "issuing_bank_type_code";

		arrProductColumn["BGTnx"][44] = "contract_ref";
		arrProductColumn["BGTnx"][45] = "contract_date";
		arrProductColumn["BGTnx"][46] = "contract_amt";
		arrProductColumn["BGTnx"][47] = "contract_cur_code";
		arrProductColumn["BGTnx"][48] = "contract_pct";
		arrProductColumn["BGTnx"][49] = "principal_act_no";
		arrProductColumn["BGTnx"][50] = "fee_act_no";

		arrProductColumn["BGTnx"][51] = "text_language";
		arrProductColumn["BGTnx"][52] = "text_language_other";

		arrProductColumn["BGTnx"][53] = "bg_rule_other";

		arrProductColumn["BGTnx"][54] = "renew_flag";
		arrProductColumn["BGTnx"][55] = "renew_on_code";
		arrProductColumn["BGTnx"][56] = "renewal_calendar_date";
		arrProductColumn["BGTnx"][57] = "renew_for_nb";
		arrProductColumn["BGTnx"][58] = "renew_for_period";
		arrProductColumn["BGTnx"][59] = "advise_renewal_flag";
		arrProductColumn["BGTnx"][60] = "advise_renewal_days_nb";
		arrProductColumn["BGTnx"][61] = "rolling_renewal_flag";
		arrProductColumn["BGTnx"][62] = "rolling_renewal_nb";
		arrProductColumn["BGTnx"][63] = "rolling_cancellation_days";
		arrProductColumn["BGTnx"][64] = "renew_amt_code";

		arrProductColumn["BGTnx"][65] = "IssuingBank@name";
		arrProductColumn["BGTnx"][66] = "IssuingBank@address_line_1";
		arrProductColumn["BGTnx"][67] = "IssuingBank@address_line_2";
		arrProductColumn["BGTnx"][68] = "IssuingBankIU@dom";

		arrProductColumn["BGTnx"][69] = "AdvisingBank@name";
		arrProductColumn["BGTnx"][70] = "AdvisingBank@address_line_1";
		arrProductColumn["BGTnx"][71] = "AdvisingBank@address_line_2";
		arrProductColumn["BGTnx"][72] = "AdvisingBankIU@dom";
		arrProductColumn["BGTnx"][73] = "adv_bank_conf_req";

		arrProductColumn["BGTnx"][74] = "RecipientBank@name";

		arrProductColumn["BGTnx"][75] = "ConfirmingBank@name";
		arrProductColumn["BGTnx"][76] = "ConfirmingBank@address_line_1";
		arrProductColumn["BGTnx"][77] = "ConfirmingBank@address_line_2";
		arrProductColumn["BGTnx"][78] = "ConfirmingBank@dom";
		arrProductColumn["BGTnx"][79] = "Inputter@last_name";
		arrProductColumn["BGTnx"][80] = "Inputter@first_name";
		arrProductColumn["BGTnx"][81] = "inp_dttm";
		arrProductColumn["BGTnx"][82] = "LastController@validation_dttm";
		arrProductColumn["BGTnx"][83] = "Releaser@last_name";
		arrProductColumn["BGTnx"][84] = "Releaser@first_name";
		arrProductColumn["BGTnx"][85] = "release_dttm";
		arrProductColumn["BGTnx"][86] = "Charge@chrg_code";
		arrProductColumn["BGTnx"][87] = "Charge@amt";
		arrProductColumn["BGTnx"][88] = "Charge@cur_code";
		arrProductColumn["BGTnx"][89] = "Charge@status";
		arrProductColumn["BGTnx"][90] = "Charge@additional_comment";
		arrProductColumn["BGTnx"][91] = "Charge@settlement_date";
		arrProductColumn["BGTnx"][92] = "bo_release_dttm";
		arrProductColumn["BGTnx"][93] = "ObjectDataString@mur_codes_sent";
		arrProductColumn["BGTnx"][94] = "ObjectDataString@mur_codes_ack";
		arrProductColumn["BGTnx"][95] = "ObjectDataString@mur_codes_nak";

		// TODO: add the following entries at the right place, let in comment until field not added in screens
		//arrProductColumn["BG"][120] = "beneficiary_country";
		//arrProductColumn["BG"][121] = "applicant_country";
		
		//arrProductColumn["BGTnx"][150] = "beneficiary_country";
		//arrProductColumn["BGTnx"][151] = "applicant_country";

		arrProductColumn["BGTnx"][96] = "exp_event";
		arrProductColumn["BGTnx"][97] = "contact_name";
		arrProductColumn["BGTnx"][98] = "contact_address_line_1";
		arrProductColumn["BGTnx"][99] = "contact_address_line_2";
		arrProductColumn["BGTnx"][100] = "contact_dom";
		arrProductColumn["BGTnx"][101] = "contact_country";
		arrProductColumn["BGTnx"][102] = "for_account";
		arrProductColumn["BGTnx"][103] = "alt_applicant_name";
		arrProductColumn["BGTnx"][104] = "alt_applicant_address_line_1";
		arrProductColumn["BGTnx"][105] = "alt_applicant_address_line_2";
		arrProductColumn["BGTnx"][106] = "IssuedUndertaking@alt_applicant_dom";
		arrProductColumn["BGTnx"][107] = "alt_applicant_country";
		arrProductColumn["BGTnx"][108] = "consortium";
		arrProductColumn["BGTnx"][109] = "net_exposure_cur_code";
		arrProductColumn["BGTnx"][110] = "net_exposure_amt";
		arrProductColumn["BGTnx"][111] = "character_commitment";
		arrProductColumn["BGTnx"][112] = "delivery_to";
		arrProductColumn["BGTnx"][113] = "delivery_to_other";
		arrProductColumn["BGTnx"][114] = "sub_tnx_stat_code";
		arrProductColumn["BGTnx"][115] = "final_expiry_date";
		arrProductColumn["BGTnx"][116] = "claim_cur_code";
		arrProductColumn["BGTnx"][117] = "claim_amt";
		arrProductColumn["BGTnx"][118] = "claim_reference";
		arrProductColumn["BGTnx"][119] = "claim_present_date";
		arrProductColumn["BGTnx"][120] = "doc_ref_no";
		arrProductColumn["BGTnx"][121] = "rolling_renew_for_nb";
		arrProductColumn["BGTnx"][122] = "rolling_day_in_month";
		arrProductColumn["BGTnx"][123] = "rolling_renew_for_period";
		arrProductColumn["BGTnx"][124] = "rolling_renew_on_code";
		arrProductColumn["BGTnx"][125] = "projected_expiry_date";
		arrProductColumn["BGTnx"][126] = "contract_narrative";
		arrProductColumn["BGTnx"][127] = "tender_expiry_date";
		arrProductColumn["BGTnx"][128] = "bg_available_amt";
		arrProductColumn["BGTnx"][129] = "LastController@LastControllerUser@first_name";
		arrProductColumn["BGTnx"][130] = "LastController@LastControllerUser@last_name";
		arrProductColumn["BGTnx"][131] = "additional_cust_ref";
		arrProductColumn["BGTnx"][132] = "purpose";
		arrProductColumn["BGTnx"][133] = "approx_expiry_date";
		arrProductColumn["BGTnx"][134] = "bei_code";
		arrProductColumn["BGTnx"][135] = "bg_conf_instructions";
		arrProductColumn["BGTnx"][136] = "bg_govern_country";
		arrProductColumn["BGTnx"][137] = "bg_govern_text";
		arrProductColumn["BGTnx"][139] = "bg_special_terms";
		arrProductColumn["BGTnx"][140] = "send_attachments_by";
		arrProductColumn["BGTnx"][141] = "cu_effective_date_type_code";
		arrProductColumn["BGTnx"][142] = "cu_exp_date_type_code";
		arrProductColumn["BGTnx"][143] = "cu_exp_date";
		arrProductColumn["BGTnx"][144] = "cu_effective_date_type_details";
		arrProductColumn["BGTnx"][145] = "CUBeneProductPartyDetails@name";
		arrProductColumn["BGTnx"][146] = "CUBeneProductPartyDetails@bei_code";
		arrProductColumn["BGTnx"][147] = "CUBeneProductPartyDetails@address_line_1";
		arrProductColumn["BGTnx"][148] = "CUBeneProductPartyDetails@address_line_2";
		arrProductColumn["BGTnx"][149] = "CUBeneProductPartyDetails@dom";
		arrProductColumn["BGTnx"][150] = "CUBeneProductPartyDetails@address_line_4";
		arrProductColumn["BGTnx"][151] = "CUBeneProductPartyDetails@country";
		arrProductColumn["BGTnx"][152] = "CUContactProductPartyDetails@name";
		arrProductColumn["BGTnx"][153] = "CUContactProductPartyDetails@address_line_1";
		arrProductColumn["BGTnx"][154] = "CUContactProductPartyDetails@address_line_2";
		arrProductColumn["BGTnx"][155] = "CUContactProductPartyDetails@address_line_4";
		arrProductColumn["BGTnx"][156] = "CUContactProductPartyDetails@dom";
		arrProductColumn["BGTnx"][157] = "cu_sub_product_code";
		arrProductColumn["BGTnx"][158] = "cu_cur_code";
		arrProductColumn["BGTnx"][159] = "cu_amt";
		arrProductColumn["BGTnx"][160] = "cu_tolerance_positive_pct";
		arrProductColumn["BGTnx"][161] = "cu_tolerance_negative_pct";
		arrProductColumn["BGTnx"][162] = "cu_consortium";
		arrProductColumn["BGTnx"][163] = "cu_net_exposure_amt";
		arrProductColumn["BGTnx"][164] = "cu_net_exposure_cur_code";
		arrProductColumn["BGTnx"][165] = "cu_renew_flag";
		arrProductColumn["BGTnx"][166] = "cu_renew_on_code";
		arrProductColumn["BGTnx"][167] = "cu_renewal_calendar_date";
		arrProductColumn["BGTnx"][168] = "cu_renew_for_nb";
		arrProductColumn["BGTnx"][169] = "cu_renew_for_period";
		arrProductColumn["BGTnx"][170] = "cu_advise_renewal_flag";
		arrProductColumn["BGTnx"][171] = "cu_advise_renewal_days_nb";
		arrProductColumn["BGTnx"][172] = "cu_rolling_renewal_flag";
		arrProductColumn["BGTnx"][173] = "cu_rolling_renew_on_code";
		arrProductColumn["BGTnx"][174] = "cu_rolling_renew_for_period";
		arrProductColumn["BGTnx"][175] = "cu_rolling_day_in_month";
		arrProductColumn["BGTnx"][176] = "cu_rolling_renewal_nb";
		arrProductColumn["BGTnx"][177] = "cu_rolling_cancellation_days";
		arrProductColumn["BGTnx"][178] = "cu_renew_amt_code";
		arrProductColumn["BGTnx"][179] = "cu_final_expiry_date";
		arrProductColumn["BGTnx"][180] = "cu_type_code";
		arrProductColumn["BGTnx"][181] = "cu_rule";
		arrProductColumn["BGTnx"][182] = "cu_rule_other";
		arrProductColumn["BGTnx"][183] = "cu_govern_country";
		arrProductColumn["BGTnx"][184] = "cu_govern_text";
		arrProductColumn["BGTnx"][185] = "cu_text_language";
		arrProductColumn["BGTnx"][186] = "cu_text_language_other";
		arrProductColumn["BGTnx"][187] = "applicant_address_line_4";
		arrProductColumn["BGTnx"][188] = "alt_applicant_address_line_4";
		arrProductColumn["BGTnx"][189] = "beneficiary_address_line_4";
		arrProductColumn["BGTnx"][190] = "contact_address_line_4";
		arrProductColumn["BGTnx"][191] = "IssuedUndertaking@sub_product_code";
		arrProductColumn["BGTnx"][192] = "bg_transfer_indicator";
		arrProductColumn["BGTnx"][193] = "AdviseThruBank@name";
		arrProductColumn["BGTnx"][194] = "AdviseThruBank@address_line_1";
		arrProductColumn["BGTnx"][195] = "AdviseThruBank@address_line_2";
		arrProductColumn["BGTnx"][196] = "AdviseThruBank@dom";
		arrProductColumn["BGTnx"][197] = "ProcessingBank@name";
		arrProductColumn["BGTnx"][198] = "ProcessingBank@address_line_1";
		arrProductColumn["BGTnx"][199] = "ProcessingBank@address_line_2";
		arrProductColumn["BGTnx"][200] = "ProcessingBank@dom";
		arrProductColumn["BGTnx"][201] = "CURecipientBank@abbv_name";
		arrProductColumn["BGTnx"][202] = "CURecipientBank@address_line_1";
		arrProductColumn["BGTnx"][203] = "CURecipientBank@address_line_2";
		arrProductColumn["BGTnx"][204] = "CURecipientBank@dom";
		arrProductColumn["BGTnx"][205] = "CURecipientBank@address_line_4";
		arrProductColumn["BGTnx"][206] = "CURecipientBank@iso_code";
		arrProductColumn["BGTnx"][207] = "CURecipientBank@reference";
		arrProductColumn["BGTnx"][208] = "cu_rolling_renew_for_nb";
		arrProductColumn["BGTnx"][209] = "RecipientBank@iso_code";
		arrProductColumn["BGTnx"][210] = "IssuingBank@address_line_4";
		arrProductColumn["BGTnx"][211] = "AdvisingBank@address_line_4";
		arrProductColumn["BGTnx"][212] = "ConfirmingBank@address_line_4";
		arrProductColumn["BGTnx"][213] = "AdviseThruBank@address_line_4";
		arrProductColumn["BGTnx"][214] = "ProcessingBank@address_line_4";
		arrProductColumn["BGTnx"][215] = "provisional_status";
		arrProductColumn["BGTnx"][216] = "cu_demand_indicator";
		arrProductColumn["BGTnx"][217] = "cu_transfer_indicator";
		arrProductColumn["BGTnx"][218] = "cu_text_type_code";
		arrProductColumn["BGTnx"][219] = "cu_text_type_details";
		arrProductColumn["BGTnx"][220] = "adv_send_mode_text";
		arrProductColumn["BGTnx"][221] = "delv_org_undertaking";
		arrProductColumn["BGTnx"][222] = "delv_org_undertaking_text";
		arrProductColumn["BGTnx"][223] = "adv_send_mode";
		arrProductColumn["BGTnx"][224] = "IssuingBank@iso_code";
		arrProductColumn["BGTnx"][225] = "AdvisingBank@iso_code";
		arrProductColumn["BGTnx"][226] = "ConfirmingBank@iso_code";
		arrProductColumn["BGTnx"][227] = "AdviseThruBank@iso_code";
		arrProductColumn["BGTnx"][228] = "ProcessingBank@iso_code";
		arrProductColumn["BGTnx"][229] = "lead_bank_flag";
		arrProductColumn["BGTnx"][230] = "cu_conf_instructions";
		arrProductColumn["BGTnx"][231] = "bg_outstanding_amt";
		arrProductColumn["BGTnx"][232] = "bg_tolerance_positive_pct";
		arrProductColumn["BGTnx"][233] = "bg_tolerance_negative_pct";
		arrProductColumn["BGTnx"][234] = "Variation@type";
		arrProductColumn["BGTnx"][235] = "Variation@advise_flag";
		arrProductColumn["BGTnx"][236] = "Variation@advise_reduction_days";
		arrProductColumn["BGTnx"][237] = "Variation@operation";
		arrProductColumn["BGTnx"][238] = "Variation@maximum_nb_days";
		arrProductColumn["BGTnx"][239] = "Variation@frequency";
		arrProductColumn["BGTnx"][240] = "Variation@period";
		arrProductColumn["BGTnx"][241] = "Variation@day_in_month";
		arrProductColumn["BGTnx"][242] = "Variation@first_date";
		arrProductColumn["BGTnx"][243] = "Variation@percentage";
		arrProductColumn["BGTnx"][244] = "Variation@cur_code";
		arrProductColumn["BGTnx"][245] = "Variation@amount";
		arrProductColumn["BGTnx"][246] = "Variation@section_type";
		arrProductColumn["BGTnx"][247] = "renewal_type";
		arrProductColumn["BGTnx"][248] = "cu_renewal_type";
		arrProductColumn["BGTnx"][251] = "ship_from";
		arrProductColumn["BGTnx"][252] = "ship_loading";
		arrProductColumn["BGTnx"][253] = "ship_discharge";
		arrProductColumn["BGTnx"][254] = "ship_to";
		arrProductColumn["BGTnx"][255] = "part_ship_detl";
		arrProductColumn["BGTnx"][256] = "tran_ship_detl";
		arrProductColumn["BGTnx"][257] = "last_ship_date";
		arrProductColumn["BGTnx"][258] = "inco_term_year";
		arrProductColumn["BGTnx"][259] = "inco_term";
		arrProductColumn["BGTnx"][260] = "inco_place";
		arrProductColumn["BGTnx"][261] = "cr_avl_by_code";
		arrProductColumn["BGTnx"][262] = "cu_cr_avl_by_code";
		arrProductColumn["BGTnx"][263] = "req_conf_party";
		
		arrProductColumn["BGTnx"][264] = "RequestedConfirmationParty@name";
		arrProductColumn["BGTnx"][265] = "RequestedConfirmationParty@address_line_1";
		arrProductColumn["BGTnx"][266] = "RequestedConfirmationParty@address_line_2";
		arrProductColumn["BGTnx"][267] = "RequestedConfirmationParty@dom";
		arrProductColumn["BGTnx"][268] = "RequestedConfirmationParty@address_line_4";
		arrProductColumn["BGTnx"][269] = "RequestedConfirmationParty@iso_code";
		
		arrProductColumn["BGTnx"][270] = "CreditAvailableWithBank@name";
		arrProductColumn["BGTnx"][271] = "CreditAvailableWithBank@address_line_1";
		arrProductColumn["BGTnx"][272] = "CreditAvailableWithBank@address_line_2";
		arrProductColumn["BGTnx"][273] = "CreditAvailableWithBank@dom";
		arrProductColumn["BGTnx"][274] = "CreditAvailableWithBank@address_line_4";
		arrProductColumn["BGTnx"][275] = "CreditAvailableWithBank@iso_code";
		
		arrProductColumn["BGTnx"][276] = "CUCreditAvailableWithBank@name";
		arrProductColumn["BGTnx"][277] = "CUCreditAvailableWithBank@address_line_1";
		arrProductColumn["BGTnx"][278] = "CUCreditAvailableWithBank@address_line_2";
		arrProductColumn["BGTnx"][279] = "CUCreditAvailableWithBank@dom";
		arrProductColumn["BGTnx"][280] = "CUCreditAvailableWithBank@address_line_4";
		arrProductColumn["BGTnx"][281] = "CUCreditAvailableWithBank@iso_code";
		
		arrProductColumn["BGTnx"][282] = "maturity_date";
		arrProductColumn["BGTnx"][283] = "latest_response_date";
		arrProductColumn["BGTnx"][284] = "action_req_code";
		
		arrProductColumn["BGTnx"][285] = "cu_corr_chrg_brn_by_code";
		arrProductColumn["BGTnx"][286] = "cu_open_chrg_brn_by_code";
		arrProductColumn["BGTnx"][287] = "cu_conf_chrg_brn_by_code";
		arrProductColumn["BGTnx"][288] = "corr_chrg_brn_by_code";
		arrProductColumn["BGTnx"][289] = "open_chrg_brn_by_code";
		arrProductColumn["BGTnx"][290] = "conf_chrg_brn_by_code";
		arrProductColumn["BGTnx"][291] = "cu_liab_amt";
		arrProductColumn["BGTnx"][292] = "cu_available_amt";
		arrProductColumn["BGTnx"][293] = "bg_demand_indicator";
		arrProductColumn["BGTnx"][294] = "Narrative@underlyingTransactionDetails";
		arrProductColumn["BGTnx"][295] = "Narrative@textOfUndertaking";
	