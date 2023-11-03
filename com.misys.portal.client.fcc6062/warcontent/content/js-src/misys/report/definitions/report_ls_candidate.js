/**
 * 
 */dojo.provide("misys.report.definitions.report_ls_candidate");


		// Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
		// All Rights Reserved. 
	
		//
		// LS candidate
		//

		// Define an array which stores the LS columns
		

		arrProductColumn["LS"][0] = "ref_id";
		arrProductColumn["LS"][1] = "additional_amt";
		arrProductColumn["LS"][2] = "additional_cur_code";
		arrProductColumn["LS"][3] = "amd_date";
		arrProductColumn["LS"][4] = "amd_no";
		arrProductColumn["LS"][7] = "appl_date";
		arrProductColumn["LS"][17] = "applicant_abbv_name";
		arrProductColumn["LS"][18] = "applicant_address_line_1";
		arrProductColumn["LS"][19] = "applicant_address_line_2";
		arrProductColumn["LS"][20] = "applicant_dom";
		arrProductColumn["LS"][22] = "applicant_country";
		arrProductColumn["LS"][23] = "applicant_name";
		arrProductColumn["LS"][24] = "applicant_reference";
		/*arrProductColumn["LS"][25] = "applicant_legal_country";
		arrProductColumn["LS"][26] = "applicant_legal_type";*/
		arrProductColumn["LS"][27] = "further_identification";
		arrProductColumn["LS"][28] = "auth_reference";
		arrProductColumn["LS"][29] = "beneficiary_name";
		arrProductColumn["LS"][30] = "beneficiary_address_line_1";
		arrProductColumn["LS"][31] = "beneficiary_address_line_2";
		arrProductColumn["LS"][32] = "beneficiary_dom";
		arrProductColumn["LS"][33] = "beneficiary_reference";
		
		arrProductColumn["LS"][35] = "beneficiary_country";
		arrProductColumn["LS"][37] = "bo_ref_id";
		arrProductColumn["LS"][38] = "brch_code";
		arrProductColumn["LS"][39] = "bulk_ref_id";
	//	arrProductColumn["LS"][40] = "company_name";
		arrProductColumn["LS"][41] = "company_id";
		arrProductColumn["LS"][42] = "origin_country";
		arrProductColumn["LS"][43] = "supply_country";
		arrProductColumn["LS"][44] = "cust_ref_id";
		arrProductColumn["LS"][45] = "entity";
		// SWIFT 2006
		arrProductColumn["LS"][46] = "inco_place";
		arrProductColumn["LS"][47] = "inco_term";
		arrProductColumn["LS"][112] = "inco_term_year";
		// SWIFT 2006
		arrProductColumn["LS"][48] = "iss_date";
		arrProductColumn["LS"][49] = "latest_payment_date";
		arrProductColumn["LS"][50] = "ls_amt";
		
		arrProductColumn["LS"][51] = "ls_cur_code";
		arrProductColumn["LS"][52] = "ls_def_id";
		arrProductColumn["LS"][53] = "ls_name";
		arrProductColumn["LS"][54] = "ls_number";
		arrProductColumn["LS"][55] = "ls_outstanding_amt";
		arrProductColumn["LS"][56] = "ls_type";
	
		arrProductColumn["LS"][58] = "neg_tol_pct";
	
		arrProductColumn["LS"][60] = "prod_stat_code";
		arrProductColumn["LS"][61] = "product_code";
		arrProductColumn["LS"][62] = "pstv_tol_pct";
		arrProductColumn["LS"][63] = "reg_date";
	//	arrProductColumn["LS"][64] = "sub_product_code";
		arrProductColumn["LS"][65] = "template_id";
		arrProductColumn["LS"][66] = "total_amt";
		arrProductColumn["LS"][67] = "total_cur_code";
		arrProductColumn["LS"][68] = "allow_multi_cur";
		arrProductColumn["LS"][69] = "IssuingBank@abbv_name";
		arrProductColumn["LS"][70] = "IssuingBank@name";
		arrProductColumn["LS"][71] = "IssuingBank@address_line_1";
		arrProductColumn["LS"][72] = "IssuingBank@address_line_2";
		arrProductColumn["LS"][73] = "IssuingBank@dom";
		arrProductColumn["LS"][74] = "IssuingBank@reference";
		
		/*arrProductColumn["LS"][104] = "Narrative@goodsDesc";
		arrProductColumn["LS"][106] = "Narrative@additionalInstructions";
		arrProductColumn["LS"][107] = "Narrative@chargesDetails";
		arrProductColumn["LS"][108] = "Narrative@additionalAmount";
		arrProductColumn["LS"][109] =  "Narrative@return_comments";*/
     
		
		arrProductColumn["LS"][113] = "Charge@chrg_code";
		arrProductColumn["LS"][114] = "Charge@amt";
		arrProductColumn["LS"][115] = "Charge@cur_code";
		arrProductColumn["LS"][116] = "Charge@status";
		arrProductColumn["LS"][117] = "Charge@additional_comment";
		arrProductColumn["LS"][118] = "Charge@settlement_date";  
		
		arrProductColumn["LS"][125] = "valid_to_date";
		arrProductColumn["LS"][126] = "valid_from_date";
		arrProductColumn["LS"][127] = "valid_for_nb";
		arrProductColumn["LS"][128] = "valid_for_period";
		arrProductColumn["LS"][129] = "ls_liab_amt";
		
		
		//
		// LS Transaction candidate
		//
		
		// Define an array which stores the LS Transaction columns
		

		arrProductColumn["LSTnx"][0] = "ref_id";
		arrProductColumn["LSTnx"][1] = "tnx_id";
		arrProductColumn["LSTnx"][2] = "action_req_code";
		arrProductColumn["LSTnx"][3] = "additional_amt";
		arrProductColumn["LSTnx"][4] = "additional_cur_code";
		arrProductColumn["LSTnx"][5] = "amd_date";
		arrProductColumn["LSTnx"][6] = "amd_no";
		arrProductColumn["LSTnx"][7] = "appl_date";
		arrProductColumn["LSTnx"][14] = "applicant_abbv_name";
		arrProductColumn["LSTnx"][15] = "applicant_address_line_1";
		arrProductColumn["LSTnx"][16] = "applicant_address_line_2";
		arrProductColumn["LSTnx"][17] = "bo_tnx_id";

		arrProductColumn["LSTnx"][18] = "applicant_dom";
		arrProductColumn["LSTnx"][19] = "applicant_country";
		arrProductColumn["LSTnx"][20] = "applicant_name"; 
		arrProductColumn["LSTnx"][21] = "applicant_reference";
		/*arrProductColumn["LSTnx"][22] = "applicant_legal_country";
		arrProductColumn["LSTnx"][23] = "applicant_legal_type";*/
		arrProductColumn["LSTnx"][24] = "further_identification";
		arrProductColumn["LSTnx"][25] = "auth_reference";
		arrProductColumn["LSTnx"][26] = "ls_liab_amt";
		arrProductColumn["LSTnx"][28] = "beneficiary_address_line_1";
		
		arrProductColumn["LSTnx"][29] = "beneficiary_address_line_2";
		arrProductColumn["LSTnx"][30] = "beneficiary_dom";
		arrProductColumn["LSTnx"][31] = "beneficiary_country";
		arrProductColumn["LSTnx"][32] = "beneficiary_name";
		arrProductColumn["LSTnx"][33] = "beneficiary_reference";
	
		
		arrProductColumn["LSTnx"][35] = "bo_inp_user_id";
		arrProductColumn["LSTnx"][36] = "bo_ref_id";
		arrProductColumn["LSTnx"][37] = "bo_release_dttm";
		arrProductColumn["LSTnx"][38] = "bo_release_user_id";
		arrProductColumn["LSTnx"][39] = "brch_code";
		arrProductColumn["LSTnx"][40] = "bulk_ref_id"; 
		arrProductColumn["LSTnx"][41] = "bulk_tnx_id";
		// arrProductColumn["LSTnx"][42] = "company_name";
		arrProductColumn["LSTnx"][43] = "origin_country";
		arrProductColumn["LSTnx"][44] = "supply_country"; 
	
		
		arrProductColumn["LSTnx"][50] = "cust_ref_id";
		
	
		arrProductColumn["LSTnx"][52] = "entity";
		
	//	arrProductColumn["LSTnx"][54] = "imp_bill_ref_id";
		
	
		arrProductColumn["LSTnx"][57] = "inco_place";
		arrProductColumn["LSTnx"][58] = "inco_term";
		arrProductColumn["LSTnx"][112] = "inco_term_year";
		//arrProductColumn["LSTnx"][59] = "inp_dttm";
		arrProductColumn["LSTnx"][60] = "inp_user_id";
		arrProductColumn["LSTnx"][61] = "iss_date";
		arrProductColumn["LSTnx"][62] = "latest_payment_date";
		arrProductColumn["LSTnx"][63] = "ls_amt";
		arrProductColumn["LSTnx"][64] = "ls_cur_code";
		arrProductColumn["LSTnx"][65] = "ls_def_id";
		arrProductColumn["LSTnx"][66] = "ls_name";
		arrProductColumn["LSTnx"][67] = "ls_number";
		arrProductColumn["LSTnx"][68] = "ls_outstanding_amt";
		
		arrProductColumn["LSTnx"][69] = "IssuingBank@abbv_name";
		arrProductColumn["LSTnx"][70] = "IssuingBank@name";
		arrProductColumn["LSTnx"][71] = "IssuingBank@address_line_1";
		arrProductColumn["LSTnx"][72] = "IssuingBank@address_line_2";
		arrProductColumn["LSTnx"][73] = "IssuingBank@dom";
		arrProductColumn["LSTnx"][74] = "IssuingBank@reference" ;
		
		
		
		//arrProductColumn["LSTnx"][104] = "Narrative@goodsDesc";
	//	arrProductColumn["LSTnx"][105] = "Narrative@docsRequired";
		//arrProductColumn["LSTnx"][106] = "Narrative@additionalInstructions";
	//	arrProductColumn["LSTnx"][107] = "Narrative@chargesDetails";
		//arrProductColumn["LSTnx"][108] = "Narrative@additionalAmount";
	//	arrProductColumn["LSTnx"][109] =  "Narrative@return_comments";
	//	arrProductColumn["LSTnx"][109] =  "Narrative@return_comments";
	//	arrProductColumn["LSTnx"][109] = "Narrative@paymentInstructions";
	//	arrProductColumn["LSTnx"][110] = "Narrative@periodOfPresentation";
	//	arrProductColumn["LSTnx"][111] = "Narrative@shipmentPeriod";
	//	arrProductColumn["LSTnx"][112] = "Narrative@senderToReceiver";
//		arrProductColumn["LSTnx"][113] = "Narrative@boComment";
//		arrProductColumn["LSTnx"][114] = "Narrative@freeFormatText";			
//		arrProductColumn["LSTnx"][115] = "Narrative@amdDetails";
//			
		arrProductColumn["LSTnx"][130] = "Inputter@last_name";
		arrProductColumn["LSTnx"][131] = "Inputter@first_name";
		arrProductColumn["LSTnx"][132] = "inp_dttm";
		arrProductColumn["LSTnx"][133] = "Controller@last_name";
		arrProductColumn["LSTnx"][134] = "Controller@first_name";
		arrProductColumn["LSTnx"][135] = "LastController@validation_dttm";
		arrProductColumn["LSTnx"][136] = "Releaser@last_name";
		arrProductColumn["LSTnx"][137] = "Releaser@first_name";
		arrProductColumn["LSTnx"][138] = "release_dttm";
		
		arrProductColumn["LSTnx"][139] = "Charge@chrg_code";
		arrProductColumn["LSTnx"][140] = "Charge@amt";
		arrProductColumn["LSTnx"][141] = "Charge@cur_code";
		arrProductColumn["LSTnx"][142] = "Charge@status";
		arrProductColumn["LSTnx"][143] = "Charge@additional_comment";
		arrProductColumn["LSTnx"][144] = "Charge@settlement_date";
		
		arrProductColumn["LSTnx"][160] = "Attachment@title";
		arrProductColumn["LSTnx"][161] = "Attachment@description";
		arrProductColumn["LSTnx"][162] = "Attachment@file_name";
		arrProductColumn["LSTnx"][163] = "Attachment@type";
		arrProductColumn["LSTnx"][164] = "Attachment@status";
		arrProductColumn["LSTnx"][165] = "ls_type";
	
		arrProductColumn["LSTnx"][167] = "neg_tol_pct";
	
		arrProductColumn["LSTnx"][169] = "prod_stat_code";
		arrProductColumn["LSTnx"][170] = "product_code";
		arrProductColumn["LSTnx"][171] = "pstv_tol_pct";
		
		arrProductColumn["LSTnx"][173] = "reg_date";
	
		
		arrProductColumn["LSTnx"][176] = "release_user_id";
		arrProductColumn["LSTnx"][177] = "sub_tnx_type_code";
	//	arrProductColumn["LSTnx"][178] = "sub_product_code";
		arrProductColumn["LSTnx"][179] = "sub_tnx_stat_code";
		arrProductColumn["LSTnx"][180] = "template_id";
		arrProductColumn["LSTnx"][181] = "total_amt";
		
		arrProductColumn["LSTnx"][183] = "total_cur_code";
		arrProductColumn["LSTnx"][184] = "tnx_amt";
		arrProductColumn["LSTnx"][185] = "tnx_cur_code";
		arrProductColumn["LSTnx"][186] = "tnx_stat_code";
		arrProductColumn["LSTnx"][187] = "tnx_type_code";
		arrProductColumn["LSTnx"][189] = "tnx_val_date";
		arrProductColumn["LSTnx"][190] = "valid_to_date";
		arrProductColumn["LSTnx"][191] = "valid_from_date";
		arrProductColumn["LSTnx"][192] = "valid_for_nb";
		arrProductColumn["LSTnx"][193] = "valid_for_period";
		arrProductColumn["LSTnx"][194] = "allow_multi_cur";
		arrProductColumn["LSTnx"][195] = "LastController@LastControllerUser@first_name";
		arrProductColumn["LSTnx"][196] = "LastController@LastControllerUser@last_name";
		
		//Bank Side permissions 
		/* 
		 * arrProductColumn["LSTnx"][201] = "company_name";
			arrProductColumn["LSTnx"][202] = "BOInputter@last_name";
			arrProductColumn["LSTnx"][203] = "BOInputter@first_name";
			arrProductColumn["LSTnx"][204] = "bo_inp_dttm";
			arrProductColumn["LSTnx"][205] = "BOController@last_name";
			arrProductColumn["LSTnx"][206] = "BOController@first_name";
			arrProductColumn["LSTnx"][207] = "bo_ctl_dttm";
			arrProductColumn["LSTnx"][208] = "BOReleaser@last_name";
			arrProductColumn["LSTnx"][209] = "BOReleaser@first_name"; */
		
		 
		
		
		
		