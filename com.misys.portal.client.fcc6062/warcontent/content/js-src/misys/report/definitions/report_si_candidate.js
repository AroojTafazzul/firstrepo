dojo.provide("misys.report.definitions.report_si_candidate");


		// Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
		// All Rights Reserved. 
	
		//
		// SI candidate
		//

		// Define an array which stores the SI columns
		

		arrProductColumn["SI"][0] = "ref_id";
		arrProductColumn["SI"][1] = "template_id";
		arrProductColumn["SI"][2] = "bo_ref_id";
		arrProductColumn["SI"][3] = "cust_ref_id";
		arrProductColumn["SI"][4] = "adv_send_mode";
		arrProductColumn["SI"][7] = "prod_stat_code";
		arrProductColumn["SI"][17] = "appl_date";
		arrProductColumn["SI"][18] = "iss_date";
		arrProductColumn["SI"][19] = "exp_date";
		arrProductColumn["SI"][20] = "amd_date";
		arrProductColumn["SI"][22] = "amd_no";
		arrProductColumn["SI"][23] = "last_ship_date";
		arrProductColumn["SI"][24] = "lc_cur_code";
		arrProductColumn["SI"][25] = "lc_amt";
		arrProductColumn["SI"][26] = "lc_liab_amt";
		arrProductColumn["SI"][27] = "lc_type";
		arrProductColumn["SI"][28] = "entity";
		arrProductColumn["SI"][29] = "beneficiary_name";
		arrProductColumn["SI"][30] = "beneficiary_address_line_1";
		arrProductColumn["SI"][31] = "beneficiary_address_line_2";
		arrProductColumn["SI"][32] = "beneficiary_dom";
		arrProductColumn["SI"][33] = "beneficiary_reference";
		
		arrProductColumn["SI"][35] = "applicant_name";
		arrProductColumn["SI"][36] = "applicant_address_line_1";
		arrProductColumn["SI"][37] = "applicant_address_line_2";
		arrProductColumn["SI"][38] = "applicant_dom";
		arrProductColumn["SI"][39] = "applicant_reference";
		arrProductColumn["SI"][40] = "expiry_place";
		arrProductColumn["SI"][41] = "inco_term";
		arrProductColumn["SI"][112] = "inco_term_year";
		arrProductColumn["SI"][42] = "inco_place";
		arrProductColumn["SI"][43] = "part_ship_detl";
		arrProductColumn["SI"][44] = "tran_ship_detl";
		arrProductColumn["SI"][45] = "ship_from";
		// SWIFT 2006
		arrProductColumn["SI"][46] = "ship_loading";
		arrProductColumn["SI"][47] = "ship_discharge";
		// SWIFT 2006
		arrProductColumn["SI"][48] = "ship_to";
		arrProductColumn["SI"][49] = "draft_term";
		arrProductColumn["SI"][50] = "cty_of_dest";
		
		arrProductColumn["SI"][51] = "neg_tol_pct";
		arrProductColumn["SI"][52] = "pstv_tol_pct";
		
		arrProductColumn["SI"][54] = "cr_avl_by_code";
		arrProductColumn["SI"][55] = "dir_reim_flag";
		arrProductColumn["SI"][56] = "irv_flag";
		arrProductColumn["SI"][57] = "ntf_flag";
		arrProductColumn["SI"][58] = "stnd_by_lc_flag";
		arrProductColumn["SI"][59] = "cfm_inst_code";
		arrProductColumn["SI"][60] = "cfm_flag";
		arrProductColumn["SI"][61] = "cfm_chrg_brn_by_code";
		arrProductColumn["SI"][62] = "corr_chrg_brn_by_code";
		arrProductColumn["SI"][63] = "open_chrg_brn_by_code";

		arrProductColumn["SI"][64] = "renew_flag";
		arrProductColumn["SI"][65] = "renew_on_code";
		arrProductColumn["SI"][66] = "renewal_calendar_date";
		arrProductColumn["SI"][67] = "renew_for_nb";
		arrProductColumn["SI"][68] = "renew_for_period";
		arrProductColumn["SI"][69] = "advise_renewal_flag";
		arrProductColumn["SI"][70] = "advise_renewal_days_nb";
		arrProductColumn["SI"][71] = "rolling_renewal_flag";
		arrProductColumn["SI"][72] = "rolling_renewal_nb";
		arrProductColumn["SI"][73] = "rolling_cancellation_days";
		arrProductColumn["SI"][74] = "renew_amt_code";
		
		arrProductColumn["SI"][78] = "principal_act_no";
		arrProductColumn["SI"][79] = "fee_act_no";
		arrProductColumn["SI"][80] = "IssuingBank@abbv_name";
		arrProductColumn["SI"][81] = "IssuingBank@name";
		arrProductColumn["SI"][82] = "IssuingBank@address_line_1";
		arrProductColumn["SI"][83] = "IssuingBank@address_line_2";
		arrProductColumn["SI"][84] = "IssuingBank@dom";
		
		arrProductColumn["SI"][87] = "AdvisingBank@name";
		arrProductColumn["SI"][88] = "AdvisingBank@address_line_1";
		arrProductColumn["SI"][89] = "AdvisingBank@address_line_2";
		arrProductColumn["SI"][90] = "AdvisingBank@dom";
		
		arrProductColumn["SI"][94] = "AdviseThruBank@name";
		arrProductColumn["SI"][95] = "AdviseThruBank@address_line_1";
		arrProductColumn["SI"][96] = "AdviseThruBank@address_line_2";
		arrProductColumn["SI"][97] = "AdviseThruBank@dom";
		
		arrProductColumn["SI"][101] = "CreditAvailableWithBank@name";
		arrProductColumn["SI"][102] = "CreditAvailableWithBank@address_line_1";
		arrProductColumn["SI"][103] = "CreditAvailableWithBank@address_line_2";
		arrProductColumn["SI"][104] = "CreditAvailableWithBank@dom";
		
		arrProductColumn["SI"][108] = "DraweeDetailsBank@name";
		arrProductColumn["SI"][109] = "DraweeDetailsBank@address_line_1";
		arrProductColumn["SI"][110] = "DraweeDetailsBank@address_line_2";
		arrProductColumn["SI"][111] = "DraweeDetailsBank@dom";
		/* MPS-50897 :These 3 narrative are removed from report designer in 
		 * swift 2018 onwards. moved them to report_core.xsl to add them conditionally
		arrProductColumn["SI"][114] = "Narrative@goodsDesc";
		arrProductColumn["SI"][115] = "Narrative@docsRequired";
		arrProductColumn["SI"][116] = "Narrative@additionalInstructions";*/
		/*arrProductColumn["SI"][117] = "Narrative@chargesDetails";
		arrProductColumn["SI"][118] = "Narrative@additionalAmount";
		arrProductColumn["SI"][119] = "Narrative@paymentInstructions";
		arrProductColumn["SI"][120] = "Narrative@periodOfPresentation";
		arrProductColumn["SI"][121] = "Narrative@shipmentPeriod";
		arrProductColumn["SI"][122] = "Narrative@senderToReceiver";
*/
		arrProductColumn["SI"][123] = "Charge@chrg_code";
		arrProductColumn["SI"][124] = "Charge@amt";
		arrProductColumn["SI"][125] = "Charge@cur_code";
		arrProductColumn["SI"][126] = "Charge@status";
		arrProductColumn["SI"][127] = "Charge@additional_comment";
		arrProductColumn["SI"][128] = "Charge@settlement_date";
		// Issued Stand By LC type
		arrProductColumn["SI"][129] = "product_type_code";
		// Issued Stand by LC template name
		arrProductColumn["SI"][130] = "stand_by_lc_code";
		arrProductColumn["SI"][131] = "lc_release_flag";
		arrProductColumn["SI"][132] = "standby_rule_code";
		arrProductColumn["SI"][133] = "final_expiry_date";
		arrProductColumn["SI"][179] = "claim_cur_code";
		arrProductColumn["SI"][180] = "claim_amt";
		arrProductColumn["SI"][181] = "claim_reference";
		arrProductColumn["SI"][182] = "claim_present_date";
		arrProductColumn["SI"][183] = "rolling_renew_on_code";
		arrProductColumn["SI"][184] = "rolling_renew_for_nb";
		arrProductColumn["SI"][185] =	 "rolling_renew_for_period";
		arrProductColumn["SI"][186] = "rolling_day_in_month";
		arrProductColumn["SI"][187] = "projected_expiry_date";
		arrProductColumn["SI"][188] = "doc_ref_no";
		arrProductColumn["SI"][189] = "lc_available_amt";
		arrProductColumn["SI"][190] = "imp_bill_ref_id";
		arrProductColumn["SI"][199] = "demand_indicator";
		arrProductColumn["SI"][220] = "adv_send_mode_text";
		// Object Data
		/*arrProductColumn["SI"][129] = "ObjectDataString@mur_codes_sent";
		arrProductColumn["SI"][130] = "ObjectDataString@mur_codes_ack";
		arrProductColumn["SI"][131] = "ObjectDataString@mur_codes_nak";
		arrProductColumn["SI"][132] = "fwd_contract_no";*/
		
		//
		// SI Transaction candidate
		//

		// Define an array which stores the SI Transaction columns
		

		arrProductColumn["SITnx"][0] = "ref_id";
		arrProductColumn["SITnx"][1] = "template_id";
		arrProductColumn["SITnx"][2] = "bo_ref_id";
		arrProductColumn["SITnx"][3] = "bo_tnx_id";
		arrProductColumn["SITnx"][4] = "cust_ref_id";
		arrProductColumn["SITnx"][5] = "adv_send_mode";
		arrProductColumn["SITnx"][6] = "tnx_type_code";
		arrProductColumn["SITnx"][7] = "sub_tnx_type_code";
		arrProductColumn["SITnx"][8] = "prod_stat_code";
		arrProductColumn["SITnx"][14] = "tnx_val_date";
		arrProductColumn["SITnx"][15] = "tnx_amt";
		arrProductColumn["SITnx"][16] = "tnx_cur_code";
		arrProductColumn["SITnx"][17] = "tnx_stat_code";
		
		arrProductColumn["SITnx"][18] = "appl_date";
		arrProductColumn["SITnx"][19] = "iss_date";
		arrProductColumn["SITnx"][20] = "exp_date";
		arrProductColumn["SITnx"][21] = "amd_date";
		arrProductColumn["SITnx"][22] = "amd_no";
		arrProductColumn["SITnx"][23] = "last_ship_date";
		arrProductColumn["SITnx"][24] = "lc_cur_code";
		arrProductColumn["SITnx"][25] = "lc_amt";
		arrProductColumn["SITnx"][26] = "lc_liab_amt";
		arrProductColumn["SITnx"][27] = "lc_type";
		arrProductColumn["SITnx"][28] = "entity";
		arrProductColumn["SITnx"][29] = "beneficiary_name";
		arrProductColumn["SITnx"][30] = "beneficiary_address_line_1";
		arrProductColumn["SITnx"][31] = "beneficiary_address_line_2";
		arrProductColumn["SITnx"][32] = "beneficiary_dom";
		arrProductColumn["SITnx"][33] = "beneficiary_reference";
		
		arrProductColumn["SITnx"][35] = "applicant_name";
		arrProductColumn["SITnx"][36] = "applicant_address_line_1";
		arrProductColumn["SITnx"][37] = "applicant_address_line_2";
		arrProductColumn["SITnx"][38] = "applicant_dom";
		arrProductColumn["SITnx"][39] = "applicant_reference";
		arrProductColumn["SITnx"][40] = "expiry_place";
		arrProductColumn["SITnx"][41] = "inco_term";
		arrProductColumn["SITnx"][139] = "inco_term_year";
		arrProductColumn["SITnx"][42] = "inco_place";
		arrProductColumn["SITnx"][43] = "part_ship_detl";
		arrProductColumn["SITnx"][44] = "tran_ship_detl";
		arrProductColumn["SITnx"][45] = "ship_from";
		// SWIFT 2006
		arrProductColumn["SITnx"][46] = "ship_loading";
		arrProductColumn["SITnx"][47] = "ship_discharge";
		// SWIFT 2006
		arrProductColumn["SITnx"][48] = "ship_to";
		arrProductColumn["SITnx"][49] = "draft_term";
		arrProductColumn["SITnx"][50] = "cty_of_dest";
		
		arrProductColumn["SITnx"][51] = "neg_tol_pct";
		arrProductColumn["SITnx"][52] = "pstv_tol_pct";
		
		arrProductColumn["SITnx"][54] = "cr_avl_by_code";
		arrProductColumn["SITnx"][55] = "dir_reim_flag";
		arrProductColumn["SITnx"][56] = "irv_flag";
		arrProductColumn["SITnx"][57] = "ntf_flag";
		arrProductColumn["SITnx"][58] = "stnd_by_lc_flag";
		arrProductColumn["SITnx"][59] = "cfm_inst_code";
		arrProductColumn["SITnx"][60] = "cfm_flag";
		arrProductColumn["SITnx"][61] = "cfm_chrg_brn_by_code";
		arrProductColumn["SITnx"][62] = "corr_chrg_brn_by_code";
		arrProductColumn["SITnx"][63] = "open_chrg_brn_by_code";
		
		arrProductColumn["SITnx"][70] = "renew_flag";
		arrProductColumn["SITnx"][71] = "renew_on_code";
		arrProductColumn["SITnx"][72] = "renewal_calendar_date";
		arrProductColumn["SITnx"][73] = "renew_for_nb";
		arrProductColumn["SITnx"][74] = "renew_for_period";
		arrProductColumn["SITnx"][75] = "advise_renewal_flag";
		arrProductColumn["SITnx"][76] = "advise_renewal_days_nb";
		arrProductColumn["SITnx"][77] = "rolling_renewal_flag";
		arrProductColumn["SITnx"][78] = "rolling_renewal_nb";
		arrProductColumn["SITnx"][79] = "rolling_cancellation_days";
		arrProductColumn["SITnx"][80] = "renew_amt_code";

		arrProductColumn["SITnx"][84] = "principal_act_no";
		arrProductColumn["SITnx"][85] = "fee_act_no";
		
		arrProductColumn["SITnx"][89] = "IssuingBank@abbv_name";
		arrProductColumn["SITnx"][90] = "IssuingBank@name";
		arrProductColumn["SITnx"][91] = "IssuingBank@address_line_1";
		arrProductColumn["SITnx"][92] = "IssuingBank@address_line_2";
		arrProductColumn["SITnx"][93] = "IssuingBank@dom";
		
		arrProductColumn["SITnx"][97] = "AdvisingBank@name";
		arrProductColumn["SITnx"][98] = "AdvisingBank@address_line_1";
		arrProductColumn["SITnx"][99] = "AdvisingBank@address_line_2";
		arrProductColumn["SITnx"][100] = "AdvisingBank@dom";
		
		arrProductColumn["SITnx"][104] = "AdviseThruBank@name";
		arrProductColumn["SITnx"][105] = "AdviseThruBank@address_line_1";
		arrProductColumn["SITnx"][106] = "AdviseThruBank@address_line_2";
		arrProductColumn["SITnx"][107] = "AdviseThruBank@dom";
		
		arrProductColumn["SITnx"][111] = "CreditAvailableWithBank@name";
		arrProductColumn["SITnx"][112] = "CreditAvailableWithBank@address_line_1";
		arrProductColumn["SITnx"][113] = "CreditAvailableWithBank@address_line_2";
		arrProductColumn["SITnx"][114] = "CreditAvailableWithBank@dom";
		
		arrProductColumn["SITnx"][118] = "DraweeDetailsBank@name";
		arrProductColumn["SITnx"][119] = "DraweeDetailsBank@address_line_1";
		arrProductColumn["SITnx"][120] = "DraweeDetailsBank@address_line_2";
		arrProductColumn["SITnx"][121] = "DraweeDetailsBank@dom";
		/* MPS-50897 :These 3 narrative are removed from report designer in 
		 * swift 2018 onwards. moved them to report_core.xsl to add them conditionally
		arrProductColumn["SITnx"][124] = "Narrative@goodsDesc";
		arrProductColumn["SITnx"][125] = "Narrative@docsRequired";
		arrProductColumn["SITnx"][126] = "Narrative@additionalInstructions";*/
		/*arrProductColumn["SITnx"][127] = "Narrative@chargesDetails";
		arrProductColumn["SITnx"][128] = "Narrative@additionalAmount";
		arrProductColumn["SITnx"][129] = "Narrative@paymentInstructions";
		arrProductColumn["SITnx"][130] = "Narrative@periodOfPresentation";
		arrProductColumn["SITnx"][131] = "Narrative@shipmentPeriod";
		arrProductColumn["SITnx"][132] = "Narrative@senderToReceiver";
		arrProductColumn["SITnx"][133] = "Narrative@boComment";
		arrProductColumn["SITnx"][134] = "Narrative@freeFormatText";
		arrProductColumn["SITnx"][135] = "Narrative@amdDetails";		
*/
		arrProductColumn["SITnx"][140] = "Inputter@last_name";
		arrProductColumn["SITnx"][141] = "Inputter@first_name";
		arrProductColumn["SITnx"][142] = "inp_dttm";
		arrProductColumn["SITnx"][145] = "LastController@validation_dttm";
		arrProductColumn["SITnx"][146] = "Releaser@last_name";
		arrProductColumn["SITnx"][147] = "Releaser@first_name";
		arrProductColumn["SITnx"][148] = "release_dttm";

		
		
		// id from 150 to 158 used in report.xsl to list id present only on bank side
		arrProductColumn["SITnx"][160] = "Charge@chrg_code";
		arrProductColumn["SITnx"][161] = "Charge@amt";
		arrProductColumn["SITnx"][162] = "Charge@cur_code";
		arrProductColumn["SITnx"][163] = "Charge@status";
		arrProductColumn["SITnx"][164] = "Charge@additional_comment";
		arrProductColumn["SITnx"][165] = "Charge@settlement_date";
		
		arrProductColumn["SITnx"][166] = "bo_release_dttm";
				
		arrProductColumn["SITnx"][167] = "maturity_date";
		
		// Object Data
		/*arrProductColumn["SITnx"][168] = "ObjectDataString@mur_codes_sent";
		arrProductColumn["SITnx"][169] = "ObjectDataString@mur_codes_ack";
		arrProductColumn["SITnx"][170] = "ObjectDataString@mur_codes_nak";*/
		arrProductColumn["SITnx"][171] = "fwd_contract_no";
		arrProductColumn["SITnx"][172] = "sub_tnx_stat_code";
		// Issued Stand By LC type
		arrProductColumn["SITnx"][173] = "product_type_code";
		// Issued Stand by LC template name
		arrProductColumn["SITnx"][174] = "stand_by_lc_code";
		arrProductColumn["SITnx"][175] = "lc_release_flag";
		arrProductColumn["SITnx"][176] = "standby_rule_code";
		arrProductColumn["SITnx"][177] = "final_expiry_date";
		arrProductColumn["SITnx"][178] = "release_amt";
		arrProductColumn["SITnx"][179] = "claim_cur_code";
		arrProductColumn["SITnx"][180] = "claim_amt";
		arrProductColumn["SITnx"][181] = "claim_reference";
		arrProductColumn["SITnx"][182] = "claim_present_date";
		arrProductColumn["SITnx"][183] = "rolling_renew_on_code";
		arrProductColumn["SITnx"][184] = "rolling_renew_for_nb";
		arrProductColumn["SITnx"][185] = "rolling_renew_for_period";
		arrProductColumn["SITnx"][186] = "rolling_day_in_month";
		arrProductColumn["SITnx"][187] = "projected_expiry_date";
		arrProductColumn["SITnx"][188] = "doc_ref_no";
		arrProductColumn["SITnx"][167] = "beneficiary_country";
		arrProductColumn["SITnx"][168] = "applicant_country";
		arrProductColumn["SITnx"][169] = "lc_available_amt";
		arrProductColumn["SITnx"][170] = "imp_bill_ref_id";
		arrProductColumn["SITnx"][191] = "LastController@LastControllerUser@first_name";
		arrProductColumn["SITnx"][192] = "LastController@LastControllerUser@last_name";
		
		arrProductColumn["SITnx"][201] = "demand_indicator";	
		arrProductColumn["SITnx"][222] = "adv_send_mode_text";
	