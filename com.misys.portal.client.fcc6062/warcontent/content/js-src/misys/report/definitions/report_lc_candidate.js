dojo.provide("misys.report.definitions.report_lc_candidate");


		// Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
		// All Rights Reserved. 
	
		//
		// LC candidate
		//

		// Define an array which stores the LC columns
		

		arrProductColumn["LC"][0] = "ref_id";
		arrProductColumn["LC"][1] = "template_id";
		arrProductColumn["LC"][2] = "bo_ref_id";
		arrProductColumn["LC"][3] = "cust_ref_id";
		arrProductColumn["LC"][4] = "adv_send_mode";
		arrProductColumn["LC"][7] = "prod_stat_code";
		arrProductColumn["LC"][17] = "appl_date";
		arrProductColumn["LC"][18] = "iss_date";
		arrProductColumn["LC"][19] = "exp_date";
		arrProductColumn["LC"][20] = "amd_date";
		arrProductColumn["LC"][22] = "amd_no";
		arrProductColumn["LC"][23] = "last_ship_date";
		arrProductColumn["LC"][24] = "lc_cur_code";
		arrProductColumn["LC"][25] = "lc_amt";
		arrProductColumn["LC"][26] = "lc_liab_amt";
		arrProductColumn["LC"][27] = "lc_type";
		arrProductColumn["LC"][28] = "entity";
		arrProductColumn["LC"][29] = "beneficiary_name";
		arrProductColumn["LC"][30] = "beneficiary_address_line_1";
		arrProductColumn["LC"][31] = "beneficiary_address_line_2";
		arrProductColumn["LC"][32] = "beneficiary_dom";
		arrProductColumn["LC"][33] = "beneficiary_reference";
		arrProductColumn["LC"][34] = "sub_product_code";
		arrProductColumn["LC"][35] = "applicant_name";
		arrProductColumn["LC"][36] = "applicant_address_line_1";
		arrProductColumn["LC"][37] = "applicant_address_line_2";
		arrProductColumn["LC"][38] = "applicant_dom";
		arrProductColumn["LC"][39] = "applicant_reference";
		arrProductColumn["LC"][40] = "expiry_place";
		arrProductColumn["LC"][41] = "inco_term";
		arrProductColumn["LC"][112] = "inco_term_year";
		arrProductColumn["LC"][42] = "inco_place";
		arrProductColumn["LC"][43] = "part_ship_detl";
		//SWIFT 2018
		arrProductColumn["LC"][44] = "tran_ship_detl";
		arrProductColumn["LC"][45] = "ship_from";
		// SWIFT 2006
		arrProductColumn["LC"][46] = "ship_loading";
		arrProductColumn["LC"][47] = "ship_discharge";
		// SWIFT 2006
		arrProductColumn["LC"][48] = "ship_to";
		arrProductColumn["LC"][49] = "draft_term";
		arrProductColumn["LC"][50] = "cty_of_dest";
		
		arrProductColumn["LC"][51] = "neg_tol_pct";
		arrProductColumn["LC"][52] = "pstv_tol_pct";
		
		arrProductColumn["LC"][54] = "cr_avl_by_code";
		arrProductColumn["LC"][55] = "dir_reim_flag";
		arrProductColumn["LC"][56] = "irv_flag";
		arrProductColumn["LC"][57] = "ntf_flag";
		arrProductColumn["LC"][58] = "stnd_by_lc_flag";
		arrProductColumn["LC"][59] = "cfm_inst_code";
		arrProductColumn["LC"][60] = "cfm_flag";
		arrProductColumn["LC"][61] = "cfm_chrg_brn_by_code";
		arrProductColumn["LC"][62] = "corr_chrg_brn_by_code";
		arrProductColumn["LC"][63] = "open_chrg_brn_by_code";
		arrProductColumn["LC"][64] = "principal_act_no";
		arrProductColumn["LC"][65] = "fee_act_no";
		arrProductColumn["LC"][69] = "IssuingBank@abbv_name";
		arrProductColumn["LC"][70] = "IssuingBank@name";
		arrProductColumn["LC"][71] = "IssuingBank@address_line_1";
		arrProductColumn["LC"][72] = "IssuingBank@address_line_2";
		arrProductColumn["LC"][73] = "IssuingBank@dom";
		
		arrProductColumn["LC"][77] = "AdvisingBank@name";
		arrProductColumn["LC"][78] = "AdvisingBank@address_line_1";
		arrProductColumn["LC"][79] = "AdvisingBank@address_line_2";
		arrProductColumn["LC"][80] = "AdvisingBank@dom";
		
		arrProductColumn["LC"][84] = "AdviseThruBank@name";
		arrProductColumn["LC"][85] = "AdviseThruBank@address_line_1";
		arrProductColumn["LC"][86] = "AdviseThruBank@address_line_2";
		arrProductColumn["LC"][87] = "AdviseThruBank@dom";
		
		arrProductColumn["LC"][91] = "CreditAvailableWithBank@name";
		arrProductColumn["LC"][92] = "CreditAvailableWithBank@address_line_1";
		arrProductColumn["LC"][93] = "CreditAvailableWithBank@address_line_2";
		arrProductColumn["LC"][94] = "CreditAvailableWithBank@dom";
		
		arrProductColumn["LC"][98] = "DraweeDetailsBank@name";
		arrProductColumn["LC"][99] = "DraweeDetailsBank@address_line_1";
		arrProductColumn["LC"][100] = "DraweeDetailsBank@address_line_2";
		arrProductColumn["LC"][101] = "DraweeDetailsBank@dom";
		
		/* MPS-50897 :These 3 narrative are removed from report designer in 
		 * swift 2018 onwards. moved them to report_core.xsl to add them conditionally
		arrProductColumn["LC"][104] = "Narrative@goodsDesc";
		arrProductColumn["LC"][105] = "Narrative@docsRequired";
		arrProductColumn["LC"][106] = "Narrative@additionalInstructions";*/
		/*	arrProductColumn["LC"][107] = "Narrative@chargesDetails";
		arrProductColumn["LC"][108] = "Narrative@additionalAmount";
		arrProductColumn["LC"][109] = "Narrative@paymentInstructions";
		arrProductColumn["LC"][110] = "Narrative@periodOfPresentation";
		arrProductColumn["LC"][111] = "Narrative@shipmentPeriod";
		arrProductColumn["LC"][112] = "Narrative@senderToReceiver";
		*/arrProductColumn["LC"][113] = "beneficiary_country";
		arrProductColumn["LC"][114] = "applicant_country";
		/*arrProductColumn["LC"][113] = "Charge@chrg_code";
		arrProductColumn["LC"][114] = "Charge@amt";
		arrProductColumn["LC"][115] = "Charge@cur_code";
		arrProductColumn["LC"][116] = "Charge@status";
		arrProductColumn["LC"][117] = "Charge@additional_comment";
		arrProductColumn["LC"][118] = "Charge@settlement_date";*/

		// Object data  
		/*arrProductColumn["LC"][119] = "ObjectDataString@mur_codes_sent";
		arrProductColumn["LC"][120] = "ObjectDataString@mur_codes_ack";
		arrProductColumn["LC"][121] = "ObjectDataString@mur_codes_nak";*/
		arrProductColumn["LC"][122] = "fwd_contract_no";
		arrProductColumn["LC"][123] = "latest_answer_date";
		arrProductColumn["LC"][124] = "doc_ref_no";
		
		arrProductColumn["LC"][125] = "revolving_flag";
		arrProductColumn["LC"][126] = "revolve_period";
		arrProductColumn["LC"][127] = "revolve_frequency";
		arrProductColumn["LC"][128] = "revolve_time_no";
		arrProductColumn["LC"][129] = "cumulative_flag";
		arrProductColumn["LC"][130] = "next_revolve_date";
		arrProductColumn["LC"][131] = "notice_days";
		arrProductColumn["LC"][132] = "charge_upto";
		arrProductColumn["LC"][133] = "alt_applicant_name";
		arrProductColumn["LC"][134] = "alt_applicant_address_line_1";
		arrProductColumn["LC"][135] = "alt_applicant_address_line_2";
		arrProductColumn["LC"][136] = "alt_applicant_dom";
		arrProductColumn["LC"][137] = "alt_applicant_country";
		arrProductColumn["LC"][138] = "for_account_flag";
		
		arrProductColumn["LC"][200] = "claim_cur_code";
		arrProductColumn["LC"][201] = "claim_amt";
		arrProductColumn["LC"][202] = "claim_reference";
		arrProductColumn["LC"][203] = "claim_present_date";
		arrProductColumn["LC"][143] = "lc_available_amt";
		arrProductColumn["LC"][144] = "applicable_rules";
		arrProductColumn["LC"][145] = "imp_bill_ref_id";
		arrProductColumn["LC"][146] = "adv_send_mode_text";
		
		arrProductColumn["LC"][204] = "PresentingBank@abbv_name";
		arrProductColumn["LC"][205] = "PresentingBank@name";
		arrProductColumn["LC"][206] = "PresentingBank@address_line_1";
		arrProductColumn["LC"][207] = "PresentingBank@address_line_2";
		arrProductColumn["LC"][208] = "PresentingBank@dom";
		
		arrProductColumn["LC"][209] = "tenor_type";
		arrProductColumn["LC"][210] = "tenor_maturity_date";
		arrProductColumn["LC"][211] = "tenor_days";
		arrProductColumn["LC"][212] = "tenor_period";
		arrProductColumn["LC"][213] = "tenor_from_after";
		arrProductColumn["LC"][214] = "tenor_days_type";
		arrProductColumn["LC"][215] = "tenor_type_details";

		//
		// LC Transaction candidate
		//
		
		// Define an array which stores the LC Transaction columns
		

		arrProductColumn["LCTnx"][0] = "ref_id";
		arrProductColumn["LCTnx"][1] = "template_id";
		arrProductColumn["LCTnx"][2] = "bo_ref_id";
		arrProductColumn["LCTnx"][3] = "bo_tnx_id";
		arrProductColumn["LCTnx"][4] = "cust_ref_id";
		arrProductColumn["LCTnx"][5] = "adv_send_mode";
		arrProductColumn["LCTnx"][6] = "tnx_type_code";
		arrProductColumn["LCTnx"][7] = "sub_tnx_type_code";
		arrProductColumn["LCTnx"][8] = "prod_stat_code";
		arrProductColumn["LCTnx"][14] = "tnx_val_date";
		arrProductColumn["LCTnx"][15] = "tnx_amt";
		arrProductColumn["LCTnx"][16] = "tnx_cur_code";
		arrProductColumn["LCTnx"][17] = "tnx_stat_code";

		arrProductColumn["LCTnx"][18] = "appl_date";
		arrProductColumn["LCTnx"][19] = "iss_date";
		arrProductColumn["LCTnx"][20] = "exp_date";
		arrProductColumn["LCTnx"][21] = "amd_date";
		arrProductColumn["LCTnx"][22] = "amd_no";
		arrProductColumn["LCTnx"][23] = "last_ship_date";
		arrProductColumn["LCTnx"][24] = "lc_cur_code";
		arrProductColumn["LCTnx"][25] = "lc_amt";
		arrProductColumn["LCTnx"][26] = "lc_liab_amt";
		arrProductColumn["LCTnx"][27] = "lc_type";
		arrProductColumn["LCTnx"][28] = "entity";
		arrProductColumn["LCTnx"][29] = "beneficiary_name";
		arrProductColumn["LCTnx"][30] = "beneficiary_address_line_1";
		arrProductColumn["LCTnx"][31] = "beneficiary_address_line_2";
		arrProductColumn["LCTnx"][32] = "beneficiary_dom";
		arrProductColumn["LCTnx"][33] = "beneficiary_reference";
		arrProductColumn["LCTnx"][34] = "sub_product_code";
		arrProductColumn["LCTnx"][35] = "applicant_name";
		arrProductColumn["LCTnx"][36] = "applicant_address_line_1";
		arrProductColumn["LCTnx"][37] = "applicant_address_line_2";
		arrProductColumn["LCTnx"][38] = "applicant_dom";
		arrProductColumn["LCTnx"][39] = "applicant_reference";
		arrProductColumn["LCTnx"][40] = "expiry_place";
		arrProductColumn["LCTnx"][41] = "inco_term";
		arrProductColumn["LCTnx"][112] = "inco_term_year";
		arrProductColumn["LCTnx"][42] = "inco_place";
		arrProductColumn["LCTnx"][43] = "part_ship_detl";
		//SWIFT 2018
		arrProductColumn["LCTnx"][44] = "tran_ship_detl";
		arrProductColumn["LCTnx"][45] = "ship_from";
		// SWIFT 2006
		arrProductColumn["LCTnx"][46] = "ship_loading";
		arrProductColumn["LCTnx"][47] = "ship_discharge";
		// SWIFT 2006
		arrProductColumn["LCTnx"][48] = "ship_to";
		arrProductColumn["LCTnx"][49] = "draft_term";
		arrProductColumn["LCTnx"][50] = "cty_of_dest";
		
		arrProductColumn["LCTnx"][51] = "neg_tol_pct";
		arrProductColumn["LCTnx"][52] = "pstv_tol_pct";
		arrProductColumn["LCTnx"][54] = "cr_avl_by_code";
		arrProductColumn["LCTnx"][55] = "dir_reim_flag";
		arrProductColumn["LCTnx"][56] = "irv_flag";
		arrProductColumn["LCTnx"][57] = "ntf_flag";
		arrProductColumn["LCTnx"][58] = "stnd_by_lc_flag";
		arrProductColumn["LCTnx"][59] = "cfm_inst_code";
		arrProductColumn["LCTnx"][60] = "cfm_flag";
		arrProductColumn["LCTnx"][61] = "cfm_chrg_brn_by_code";
		arrProductColumn["LCTnx"][62] = "corr_chrg_brn_by_code";
		arrProductColumn["LCTnx"][63] = "open_chrg_brn_by_code";
		arrProductColumn["LCTnx"][64] = "principal_act_no";
		arrProductColumn["LCTnx"][65] = "fee_act_no";
		
		arrProductColumn["LCTnx"][69] = "IssuingBank@abbv_name";
		arrProductColumn["LCTnx"][70] = "IssuingBank@name";
		arrProductColumn["LCTnx"][71] = "IssuingBank@address_line_1";
		arrProductColumn["LCTnx"][72] = "IssuingBank@address_line_2";
		arrProductColumn["LCTnx"][73] = "IssuingBank@dom";
		
		arrProductColumn["LCTnx"][77] = "AdvisingBank@name";
		arrProductColumn["LCTnx"][78] = "AdvisingBank@address_line_1";
		arrProductColumn["LCTnx"][79] = "AdvisingBank@address_line_2";
		arrProductColumn["LCTnx"][80] = "AdvisingBank@dom";
		
		arrProductColumn["LCTnx"][84] = "AdviseThruBank@name";
		arrProductColumn["LCTnx"][85] = "AdviseThruBank@address_line_1";
		arrProductColumn["LCTnx"][86] = "AdviseThruBank@address_line_2";
		arrProductColumn["LCTnx"][87] = "AdviseThruBank@dom";
		
		arrProductColumn["LCTnx"][91] = "CreditAvailableWithBank@name";
		arrProductColumn["LCTnx"][92] = "CreditAvailableWithBank@address_line_1";
		arrProductColumn["LCTnx"][93] = "CreditAvailableWithBank@address_line_2";
		arrProductColumn["LCTnx"][94] = "CreditAvailableWithBank@dom";
		
		arrProductColumn["LCTnx"][98] = "DraweeDetailsBank@name";
		arrProductColumn["LCTnx"][99] = "DraweeDetailsBank@address_line_1";
		arrProductColumn["LCTnx"][100] = "DraweeDetailsBank@address_line_2";
		arrProductColumn["LCTnx"][101] = "DraweeDetailsBank@dom";
		
		/* MPS-50897 :These 3 narrative are removed from report designer in 
		 * swift 2018 onwards. moved them to report_core.xsl to add them conditionally
		arrProductColumn["LCTnx"][104] = "Narrative@goodsDesc";
		arrProductColumn["LCTnx"][105] = "Narrative@docsRequired";
		arrProductColumn["LCTnx"][106] = "Narrative@additionalInstructions";*/
		/*arrProductColumn["LCTnx"][107] = "Narrative@chargesDetails";
		arrProductColumn["LCTnx"][108] = "Narrative@additionalAmount";
		arrProductColumn["LCTnx"][109] = "Narrative@paymentInstructions";
		arrProductColumn["LCTnx"][110] = "Narrative@periodOfPresentation";
		arrProductColumn["LCTnx"][111] = "Narrative@shipmentPeriod";
		arrProductColumn["LCTnx"][112] = "Narrative@senderToReceiver";
		arrProductColumn["LCTnx"][113] = "Narrative@boComment";
		arrProductColumn["LCTnx"][114] = "Narrative@freeFormatText";			
		arrProductColumn["LCTnx"][115] = "Narrative@amdDetails";*/
			
		arrProductColumn["LCTnx"][130] = "Inputter@last_name";
		arrProductColumn["LCTnx"][131] = "Inputter@first_name";
		arrProductColumn["LCTnx"][132] = "inp_dttm";
		arrProductColumn["LCTnx"][135] = "LastController@validation_dttm";
		arrProductColumn["LCTnx"][136] = "Releaser@last_name";
		arrProductColumn["LCTnx"][137] = "Releaser@first_name";
		arrProductColumn["LCTnx"][138] = "release_dttm";
		
		/*arrProductColumn["LCTnx"][139] = "Charge@chrg_code";
		arrProductColumn["LCTnx"][140] = "Charge@amt";
		arrProductColumn["LCTnx"][141] = "Charge@cur_code";
		arrProductColumn["LCTnx"][142] = "Charge@status";
		arrProductColumn["LCTnx"][143] = "Charge@additional_comment";
		arrProductColumn["LCTnx"][144] = "Charge@settlement_date";*/
		
		arrProductColumn["LCTnx"][145] = "bo_release_dttm";
		arrProductColumn["LCTnx"][146] = "maturity_date";

		// Object Data
		/*arrProductColumn["LCTnx"][147] = "ObjectDataString@mur_codes_sent";
		arrProductColumn["LCTnx"][148] = "ObjectDataString@mur_codes_ack";
		arrProductColumn["LCTnx"][149] = "ObjectDataString@mur_codes_nak";*/
		arrProductColumn["LCTnx"][150] = "fwd_contract_no";
		arrProductColumn["LCTnx"][151] = "latest_answer_date";		
		arrProductColumn["LCTnx"][160] = "Attachment@title";
		arrProductColumn["LCTnx"][161] = "Attachment@description";
		arrProductColumn["LCTnx"][162] = "Attachment@file_name";
		arrProductColumn["LCTnx"][163] = "Attachment@type";
		arrProductColumn["LCTnx"][164] = "Attachment@status";
		arrProductColumn["LCTnx"][165] = "sub_tnx_stat_code";
		arrProductColumn["LCTnx"][166] = "doc_ref_no";
		arrProductColumn["LCTnx"][167] = "beneficiary_country";
		arrProductColumn["LCTnx"][168] = "applicant_country";
		
		arrProductColumn["LCTnx"][169] = "revolving_flag";
		arrProductColumn["LCTnx"][170] = "revolve_period";
		arrProductColumn["LCTnx"][171] = "revolve_frequency";
		arrProductColumn["LCTnx"][172] = "revolve_time_no";
		arrProductColumn["LCTnx"][173] = "cumulative_flag";
		arrProductColumn["LCTnx"][174] = "next_revolve_date";
		arrProductColumn["LCTnx"][175] = "notice_days";
		arrProductColumn["LCTnx"][176] = "charge_upto";
		
		arrProductColumn["LCTnx"][177] = "alt_applicant_name";
		arrProductColumn["LCTnx"][178] = "alt_applicant_address_line_1";
		arrProductColumn["LCTnx"][179] = "alt_applicant_address_line_2";
		arrProductColumn["LCTnx"][180] = "alt_applicant_dom";
		arrProductColumn["LCTnx"][181] = "alt_applicant_country";
		arrProductColumn["LCTnx"][182] = "for_account_flag";		

		arrProductColumn["LCTnx"][183] = "claim_cur_code";
		arrProductColumn["LCTnx"][184] = "claim_amt";
		arrProductColumn["LCTnx"][185] = "claim_reference";
		arrProductColumn["LCTnx"][186] = "claim_present_date";
		arrProductColumn["LCTnx"][187] = "tenor_maturity_date";
		arrProductColumn["LCTnx"][188] = "lc_available_amt";
		arrProductColumn["LCTnx"][189] = "imp_bill_ref_id";
		arrProductColumn["LCTnx"][190] = "applicable_rules";
		arrProductColumn["LCTnx"][199] = "LastController@LastControllerUser@first_name";
		arrProductColumn["LCTnx"][200] = "LastController@LastControllerUser@last_name";
		arrProductColumn["LCTnx"][217] = "adv_send_mode_text";
		
		arrProductColumn["LCTnx"][220] = "PresentingBank@abbv_name";
		arrProductColumn["LCTnx"][221] = "PresentingBank@name";
		arrProductColumn["LCTnx"][222] = "PresentingBank@address_line_1";
		arrProductColumn["LCTnx"][223] = "PresentingBank@address_line_2";
		arrProductColumn["LCTnx"][224] = "PresentingBank@dom";
		
		arrProductColumn["LCTnx"][225] = "tenor_type";
		arrProductColumn["LCTnx"][226] = "tenor_days";
		arrProductColumn["LCTnx"][227] = "tenor_period";
		arrProductColumn["LCTnx"][228] = "tenor_from_after";
		arrProductColumn["LCTnx"][229] = "tenor_days_type";
		arrProductColumn["LCTnx"][210] = "tenor_type_details";
		