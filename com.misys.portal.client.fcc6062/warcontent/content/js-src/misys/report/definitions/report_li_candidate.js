dojo.provide("misys.report.definitions.report_li_candidate");


		// Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
		// All Rights Reserved. 
	
		//
		// LI candidate
		//

		// Define an array which stores the LC columns
		

		arrProductColumn["LI"][0] = "ref_id";
		arrProductColumn["LI"][1] = "template_id";
		arrProductColumn["LI"][2] = "bo_ref_id";
		arrProductColumn["LI"][3] = "cust_ref_id";
		arrProductColumn["LI"][4] = "deal_ref_id";
		arrProductColumn["LI"][7] = "prod_stat_code";
		arrProductColumn["LI"][17] = "appl_date";
		arrProductColumn["LI"][18] = "iss_date";
		arrProductColumn["LI"][19] = "exp_date";
		arrProductColumn["LI"][20] = "bene_type_code";
		arrProductColumn["LI"][21] = "bene_type_other";
		arrProductColumn["LI"][22] = "amd_no";
		arrProductColumn["LI"][23] = "last_ship_date";
		arrProductColumn["LI"][24] = "li_cur_code";
		arrProductColumn["LI"][25] = "li_amt";
		arrProductColumn["LI"][26] = "li_liab_amt";
		arrProductColumn["LI"][28] = "entity";
		arrProductColumn["LI"][29] = "beneficiary_name";
		arrProductColumn["LI"][30] = "beneficiary_address_line_1";
		arrProductColumn["LI"][31] = "beneficiary_address_line_2";
		arrProductColumn["LI"][32] = "beneficiary_dom";
		arrProductColumn["LI"][33] = "beneficiary_reference";
		
		arrProductColumn["LI"][35] = "applicant_name";
		arrProductColumn["LI"][36] = "applicant_address_line_1";
		arrProductColumn["LI"][37] = "applicant_address_line_2";
		arrProductColumn["LI"][38] = "applicant_dom";
		arrProductColumn["LI"][39] = "applicant_reference";
		arrProductColumn["LI"][40] = "expiry_place";
		arrProductColumn["LI"][41] = "bol_number";
		arrProductColumn["LI"][42] = "bol_date";
		arrProductColumn["LI"][43] = "shipping_mode";
		arrProductColumn["LI"][44] = "shipping_by";
		arrProductColumn["LI"][45] = "countersign_flag";
		arrProductColumn["LI"][46] = "trans_doc_type_code";
		arrProductColumn["LI"][64] = "principal_act_no";
		arrProductColumn["LI"][65] = "fee_act_no";
		
		arrProductColumn["LI"][69] = "IssuingBank@abbv_name";
		arrProductColumn["LI"][70] = "IssuingBank@name";
		arrProductColumn["LI"][71] = "IssuingBank@address_line_1";
		arrProductColumn["LI"][72] = "IssuingBank@address_line_2";
		arrProductColumn["LI"][73] = "IssuingBank@dom";
		
	//	arrProductColumn["LI"][97] = "Narrative@goodsDesc";

		arrProductColumn["LI"][100] = "Charge@chrg_code";
		arrProductColumn["LI"][101] = "Charge@amt";
		arrProductColumn["LI"][102] = "Charge@cur_code";
		arrProductColumn["LI"][103] = "Charge@status";
		arrProductColumn["LI"][104] = "Charge@additional_comment";
		arrProductColumn["LI"][105] = "Charge@settlement_date";

		//arrProductColumn["LI"][108] = "lc_ref_id";
		
		arrProductColumn["LI"][110] = "imp_bill_ref_id";
		  
		//
		// LI Transaction candidate
		//
		
		// Define an array which stores the LI Transaction columns
		

		arrProductColumn["LITnx"][0] = "ref_id";
		arrProductColumn["LITnx"][1] = "template_id";
		arrProductColumn["LITnx"][2] = "bo_ref_id";
		arrProductColumn["LITnx"][3] = "cust_ref_id";
		arrProductColumn["LITnx"][4] = "deal_ref_id";
		arrProductColumn["LITnx"][5] = "tnx_type_code";
		arrProductColumn["LITnx"][6] = "sub_tnx_type_code";
		arrProductColumn["LITnx"][7] = "prod_stat_code";
		arrProductColumn["LITnx"][14] = "tnx_val_date";
		arrProductColumn["LITnx"][15] = "tnx_amt";
		arrProductColumn["LITnx"][16] = "tnx_cur_code";
		
		arrProductColumn["LITnx"][18] = "appl_date";
		arrProductColumn["LITnx"][19] = "iss_date";
		arrProductColumn["LITnx"][20] = "exp_date";
		arrProductColumn["LITnx"][21] = "bene_type_code";
		arrProductColumn["LITnx"][22] = "bene_type_other";
		arrProductColumn["LITnx"][23] = "amd_no";
		arrProductColumn["LITnx"][24] = "last_ship_date";
		arrProductColumn["LITnx"][25] = "li_cur_code";
		arrProductColumn["LITnx"][26] = "li_amt";
		arrProductColumn["LITnx"][27] = "li_liab_amt";
		arrProductColumn["LITnx"][28] = "entity";
		arrProductColumn["LITnx"][29] = "beneficiary_name";
		arrProductColumn["LITnx"][30] = "beneficiary_address_line_1";
		arrProductColumn["LITnx"][31] = "beneficiary_address_line_2";
		arrProductColumn["LITnx"][32] = "beneficiary_dom";
		arrProductColumn["LITnx"][33] = "beneficiary_reference";
		
		arrProductColumn["LITnx"][35] = "applicant_name";
		arrProductColumn["LITnx"][36] = "applicant_address_line_1";
		arrProductColumn["LITnx"][37] = "applicant_address_line_2";
		arrProductColumn["LITnx"][38] = "applicant_dom";
		arrProductColumn["LITnx"][39] = "applicant_reference";
		arrProductColumn["LITnx"][40] = "expiry_place";
		arrProductColumn["LITnx"][41] = "bol_number";
		arrProductColumn["LITnx"][42] = "bol_date";
		arrProductColumn["LITnx"][43] = "shipping_mode";
		arrProductColumn["LITnx"][44] = "shipping_by";
		arrProductColumn["LITnx"][45] = "countersign_flag";
		arrProductColumn["LITnx"][46] = "trans_doc_type_code";
		arrProductColumn["LITnx"][64] = "principal_act_no";
		arrProductColumn["LITnx"][65] = "fee_act_no";
		
		arrProductColumn["LITnx"][69] = "IssuingBank@abbv_name";
		arrProductColumn["LITnx"][70] = "IssuingBank@name";
		arrProductColumn["LITnx"][71] = "IssuingBank@address_line_1";
		arrProductColumn["LITnx"][72] = "IssuingBank@address_line_2";
		arrProductColumn["LITnx"][73] = "IssuingBank@dom";
		
	/*	arrProductColumn["LITnx"][97] = "Narrative@goodsDesc";
		arrProductColumn["LITnx"][98] = "Narrative@boComment";
		arrProductColumn["LITnx"][99] = "Narrative@freeFormatText";
	*/	//arrProductColumn["LITnx"][108] = "lc_ref_id";
		
		arrProductColumn["LITnx"][110] = "imp_bill_ref_id";

		arrProductColumn["LITnx"][130] = "Inputter@last_name";
		arrProductColumn["LITnx"][131] = "Inputter@first_name";
		arrProductColumn["LITnx"][132] = "inp_dttm";
		arrProductColumn["LITnx"][135] = "LastController@validation_dttm";
		arrProductColumn["LITnx"][136] = "Releaser@last_name";
		arrProductColumn["LITnx"][137] = "Releaser@first_name";
		arrProductColumn["LITnx"][138] = "release_dttm";

		arrProductColumn["LITnx"][139] = "Charge@chrg_code";
		arrProductColumn["LITnx"][140] = "Charge@amt";
		arrProductColumn["LITnx"][141] = "Charge@cur_code";
		arrProductColumn["LITnx"][142] = "Charge@status";
		arrProductColumn["LITnx"][143] = "Charge@additional_comment";
		arrProductColumn["LITnx"][144] = "Charge@settlement_date";
		
		arrProductColumn["LITnx"][145] = "bo_release_dttm";
		arrProductColumn["LITnx"][194] = "LastController@LastControllerUser@first_name";
		arrProductColumn["LITnx"][195] = "LastController@LastControllerUser@last_name";
		