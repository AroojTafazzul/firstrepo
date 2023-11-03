dojo.provide("misys.report.definitions.report_tf_candidate");


		// Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
		// All Rights Reserved. 
	
		//
		// TF candidate
		//

		// Define an array which stores the TF columns
		

		arrProductColumn["TF"][0] = "ref_id";
		arrProductColumn["TF"][2] = "bo_ref_id";
		arrProductColumn["TF"][3] = "cust_ref_id";
		arrProductColumn["TF"][7] = "prod_stat_code";
		arrProductColumn["TF"][17] = "appl_date";
		arrProductColumn["TF"][18] = "iss_date";
		arrProductColumn["TF"][25] = "fin_cur_code";
		arrProductColumn["TF"][26] = "fin_amt";
		arrProductColumn["TF"][27] = "fin_liab_amt";
		arrProductColumn["TF"][28] = "fin_type";
		arrProductColumn["TF"][29] = "entity";
		arrProductColumn["TF"][30] = "tenor";
		arrProductColumn["TF"][31] = "maturity_date";
		
		arrProductColumn["TF"][41] = "applicant_name";
		arrProductColumn["TF"][42] = "applicant_address_line_1";
		arrProductColumn["TF"][43] = "applicant_address_line_2";
		arrProductColumn["TF"][44] = "applicant_dom";
		
		arrProductColumn["TF"][47] = "principal_act_no";
		arrProductColumn["TF"][48] = "fee_act_no";
		
		arrProductColumn["TF"][69] = "IssuingBank@abbv_name";
		arrProductColumn["TF"][70] = "IssuingBank@name";
		arrProductColumn["TF"][71] = "IssuingBank@address_line_1";
		arrProductColumn["TF"][72] = "IssuingBank@address_line_2";
		arrProductColumn["TF"][73] = "IssuingBank@dom";

		arrProductColumn["TF"][76] = "Charge@chrg_code";
		arrProductColumn["TF"][77] = "Charge@amt";
		arrProductColumn["TF"][78] = "Charge@cur_code";
		arrProductColumn["TF"][79] = "Charge@status";
		arrProductColumn["TF"][80] = "Charge@additional_comment";
		arrProductColumn["TF"][81] = "Charge@settlement_date";

	//	arrProductColumn["TF"][100] = "Narrative@goodsDesc";
		//arrProductColumn["TF"][108] = "lc_ref_id";
		arrProductColumn["TF"][109] = "imp_bill_ref_id";
		arrProductColumn["TF"][150] = "fwd_contract_no";
//		arrProductColumn["TF"][151] = "ObjectDataString@sub_product_code_text";
		// Provisional Flow
		arrProductColumn["TF"][152] = "req_pct";
		arrProductColumn["TF"][153] = "req_amt";
		arrProductColumn["TF"][154] = "req_cur_code";
		arrProductColumn["TF"][156] = "fin_outstanding_amt";
		
		//
		// TF Transaction candidate
		//

		// Define an array which stores the TF Transaction columns
		

		arrProductColumn["TFTnx"][0] = "ref_id";
		arrProductColumn["TFTnx"][2] = "bo_ref_id";
		arrProductColumn["TFTnx"][3] = "cust_ref_id";
		arrProductColumn["TFTnx"][5] = "tnx_type_code";
		arrProductColumn["TFTnx"][6] = "sub_tnx_type_code";
		arrProductColumn["TFTnx"][7] = "prod_stat_code";
		arrProductColumn["TFTnx"][14] = "tnx_val_date";
		arrProductColumn["TFTnx"][15] = "tnx_amt";
		arrProductColumn["TFTnx"][16] = "tnx_cur_code";
		arrProductColumn["TFTnx"][17] = "tnx_stat_code";
		
		arrProductColumn["TFTnx"][18] = "appl_date";
		arrProductColumn["TFTnx"][19] = "iss_date";
		arrProductColumn["TFTnx"][25] = "fin_cur_code";
		arrProductColumn["TFTnx"][26] = "fin_amt";
		arrProductColumn["TFTnx"][27] = "fin_liab_amt";
		arrProductColumn["TFTnx"][28] = "fin_type";
		arrProductColumn["TFTnx"][29] = "entity";
		arrProductColumn["TFTnx"][30] = "tenor";
		arrProductColumn["TFTnx"][31] = "maturity_date";
		
		arrProductColumn["TFTnx"][41] = "applicant_name";
		arrProductColumn["TFTnx"][42] = "applicant_address_line_1";
		arrProductColumn["TFTnx"][43] = "applicant_address_line_2";
		arrProductColumn["TFTnx"][44] = "applicant_dom";
		
		arrProductColumn["TFTnx"][47] = "principal_act_no";
		arrProductColumn["TFTnx"][48] = "fee_act_no";
		
		arrProductColumn["TFTnx"][69] = "IssuingBank@abbv_name";
		arrProductColumn["TFTnx"][70] = "IssuingBank@name";
		arrProductColumn["TFTnx"][71] = "IssuingBank@address_line_1";
		arrProductColumn["TFTnx"][72] = "IssuingBank@address_line_2";
		arrProductColumn["TFTnx"][73] = "IssuingBank@dom";
		
		//arrProductColumn["TFTnx"][108] = "lc_ref_id";
		arrProductColumn["TFTnx"][109] = "imp_bill_ref_id";
		/*arrProductColumn["TFTnx"][110] = "Narrative@boComment";
		arrProductColumn["TFTnx"][111] = "Narrative@freeFormatText";
		arrProductColumn["TFTnx"][112] = "Narrative@goodsDesc";
*/
		arrProductColumn["TFTnx"][130] = "Inputter@last_name";
		arrProductColumn["TFTnx"][131] = "Inputter@first_name";
		arrProductColumn["TFTnx"][132] = "inp_dttm";
		arrProductColumn["TFTnx"][135] = "LastController@validation_dttm";
		arrProductColumn["TFTnx"][136] = "Releaser@last_name";
		arrProductColumn["TFTnx"][137] = "Releaser@first_name";
		arrProductColumn["TFTnx"][138] = "release_dttm";

		arrProductColumn["TFTnx"][139] = "Charge@chrg_code";
		arrProductColumn["TFTnx"][140] = "Charge@amt";
		arrProductColumn["TFTnx"][141] = "Charge@cur_code";
		arrProductColumn["TFTnx"][142] = "Charge@status";
		arrProductColumn["TFTnx"][143] = "Charge@additional_comment";
		arrProductColumn["TFTnx"][144] = "Charge@settlement_date";
		
		arrProductColumn["TFTnx"][145] = "bo_release_dttm";
		arrProductColumn["TFTnx"][150] = "fwd_contract_no";
//		arrProductColumn["TFTnx"][151] = "ObjectDataString@sub_product_code_text";
		arrProductColumn["TFTnx"][152] = "sub_tnx_stat_code";
		
		// Provisional Flow
		arrProductColumn["TFTnx"][153] = "req_pct";
		arrProductColumn["TFTnx"][154] = "req_amt";
		arrProductColumn["TFTnx"][155] = "req_cur_code";
		arrProductColumn["TFTnx"][156] = "provisional_status";
		arrProductColumn["TFTnx"][157] = "fin_outstanding_amt";
		arrProductColumn["TFTnx"][169] = "LastController@LastControllerUser@first_name";
		arrProductColumn["TFTnx"][170] = "LastController@LastControllerUser@last_name";
	
		// TODO: add the following entries at the right place, let in comment until field not added in screens
		//arrProductColumn["TF"][110] = "applicant_country";
		
		//arrProductColumn["TFTnx"][150] = "applicant_country";