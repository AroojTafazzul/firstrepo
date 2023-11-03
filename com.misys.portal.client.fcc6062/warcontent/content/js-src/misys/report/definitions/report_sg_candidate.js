dojo.provide("misys.report.definitions.report_sg_candidate");


		// Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
		// All Rights Reserved. 
	
		//
		// SG candidate
		//

		// Define an array which stores the SG columns
		

		arrProductColumn["SG"][0] = "ref_id";
		arrProductColumn["SG"][2] = "bo_ref_id";
		arrProductColumn["SG"][3] = "cust_ref_id";
		arrProductColumn["SG"][7] = "prod_stat_code";
		arrProductColumn["SG"][17] = "appl_date";
		arrProductColumn["SG"][18] = "iss_date";
		arrProductColumn["SG"][21] = "exp_date";
		arrProductColumn["SG"][25] = "sg_cur_code";
		arrProductColumn["SG"][26] = "sg_amt";
		arrProductColumn["SG"][27] = "sg_liab_amt";
		arrProductColumn["SG"][28] = "entity";
		arrProductColumn["SG"][29] = "bol_number";
		arrProductColumn["SG"][30] = "shipping_mode";
		
		arrProductColumn["SG"][35] = "beneficiary_name";
		arrProductColumn["SG"][36] = "beneficiary_address_line_1";
		arrProductColumn["SG"][37] = "beneficiary_address_line_2";
		arrProductColumn["SG"][38] = "beneficiary_dom";
		arrProductColumn["SG"][39] = "beneficiary_reference";
		
		arrProductColumn["SG"][41] = "applicant_name";
		arrProductColumn["SG"][42] = "applicant_address_line_1";
		arrProductColumn["SG"][43] = "applicant_address_line_2";
		arrProductColumn["SG"][44] = "applicant_dom";
		arrProductColumn["SG"][45] = "applicant_reference";
		arrProductColumn["SG"][46] = "shipping_by";
		arrProductColumn["SG"][47] = "principal_act_no";
		arrProductColumn["SG"][48] = "fee_act_no";
		arrProductColumn["SG"][69] = "IssuingBank@abbv_name";
		arrProductColumn["SG"][70] = "IssuingBank@name";
		arrProductColumn["SG"][71] = "IssuingBank@address_line_1";
		arrProductColumn["SG"][72] = "IssuingBank@address_line_2";
		arrProductColumn["SG"][73] = "IssuingBank@dom";
		
	//	arrProductColumn["SG"][76] = "Narrative@goodsDesc";

		arrProductColumn["SG"][78] = "Charge@chrg_code";
		arrProductColumn["SG"][79] = "Charge@amt";
		arrProductColumn["SG"][80] = "Charge@cur_code";
		arrProductColumn["SG"][81] = "Charge@status";
		arrProductColumn["SG"][82] = "Charge@additional_comment";
		arrProductColumn["SG"][83] = "Charge@settlement_date";
		arrProductColumn["SG"][84] = "imp_bill_ref_id";
		//arrProductColumn["SG"][108] = "lc_ref_id";

		//
		// SG Transaction candidate
		//

		// Define an array which stores the SG Transaction columns
		

		arrProductColumn["SGTnx"][0] = "ref_id";
		arrProductColumn["SGTnx"][2] = "bo_ref_id";
		arrProductColumn["SGTnx"][3] = "bo_tnx_id";
		arrProductColumn["SGTnx"][4] = "cust_ref_id";
		arrProductColumn["SGTnx"][5] = "tnx_type_code";
		arrProductColumn["SGTnx"][6] = "sub_tnx_type_code";
		arrProductColumn["SGTnx"][7] = "prod_stat_code";
		arrProductColumn["SGTnx"][14] = "tnx_val_date";
		arrProductColumn["SGTnx"][15] = "tnx_amt";
		arrProductColumn["SGTnx"][16] = "tnx_cur_code";
		arrProductColumn["SGTnx"][17] = "tnx_stat_code";
		
		arrProductColumn["SGTnx"][18] = "appl_date";
		arrProductColumn["SGTnx"][19] = "iss_date";
		arrProductColumn["SGTnx"][21] = "exp_date";
		arrProductColumn["SGTnx"][25] = "sg_cur_code";
		arrProductColumn["SGTnx"][26] = "sg_amt";
		arrProductColumn["SGTnx"][27] = "sg_liab_amt";
		arrProductColumn["SGTnx"][28] = "entity";
		arrProductColumn["SGTnx"][29] = "bol_number";
		arrProductColumn["SGTnx"][30] = "shipping_mode";
		
		arrProductColumn["SGTnx"][35] = "beneficiary_name";
		arrProductColumn["SGTnx"][36] = "beneficiary_address_line_1";
		arrProductColumn["SGTnx"][37] = "beneficiary_address_line_2";
		arrProductColumn["SGTnx"][38] = "beneficiary_dom";
		arrProductColumn["SGTnx"][39] = "beneficiary_reference";
		
		arrProductColumn["SGTnx"][41] = "applicant_name";
		arrProductColumn["SGTnx"][42] = "applicant_address_line_1";
		arrProductColumn["SGTnx"][43] = "applicant_address_line_2";
		arrProductColumn["SGTnx"][44] = "applicant_dom";
		arrProductColumn["SGTnx"][45] = "applicant_reference";
		arrProductColumn["SGTnx"][46] = "shipping_by";
		arrProductColumn["SGTnx"][47] = "principal_act_no";
		arrProductColumn["SGTnx"][48] = "fee_act_no";
		
		arrProductColumn["SGTnx"][69] = "IssuingBank@abbv_name";
		arrProductColumn["SGTnx"][70] = "IssuingBank@name";
		arrProductColumn["SGTnx"][71] = "IssuingBank@address_line_1";
		arrProductColumn["SGTnx"][72] = "IssuingBank@address_line_2";
		arrProductColumn["SGTnx"][73] = "IssuingBank@dom";
		
		//arrProductColumn["SGTnx"][108] = "lc_ref_id";
		/*arrProductColumn["SGTnx"][109] = "Narrative@boComment";
		arrProductColumn["SGTnx"][110] = "Narrative@freeFormatText";
		arrProductColumn["SGTnx"][111] = "Narrative@goodsDesc";
*/
		arrProductColumn["SGTnx"][130] = "Inputter@last_name";
		arrProductColumn["SGTnx"][131] = "Inputter@first_name";
		arrProductColumn["SGTnx"][132] = "inp_dttm";
		arrProductColumn["SGTnx"][135] = "LastController@validation_dttm";
		arrProductColumn["SGTnx"][136] = "Releaser@last_name";
		arrProductColumn["SGTnx"][137] = "Releaser@first_name";
		arrProductColumn["SGTnx"][138] = "release_dttm";

		arrProductColumn["SGTnx"][139] = "Charge@chrg_code";
		arrProductColumn["SGTnx"][140] = "Charge@amt";
		arrProductColumn["SGTnx"][141] = "Charge@cur_code";
		arrProductColumn["SGTnx"][142] = "Charge@status";
		arrProductColumn["SGTnx"][143] = "Charge@additional_comment";
		arrProductColumn["SGTnx"][144] = "Charge@settlement_date";
		
		arrProductColumn["SGTnx"][145] = "bo_release_dttm";
		arrProductColumn["SGTnx"][146] = "sub_tnx_stat_code";
		arrProductColumn["SGTnx"][147] = "imp_bill_ref_id";
		arrProductColumn["SGTnx"][148] = "LastController@LastControllerUser@first_name";
		arrProductColumn["SGTnx"][149] = "LastController@LastControllerUser@last_name";
	
		// TODO: add the following entries at the right place, let in comment until field not added in screens
		//arrProductColumn["SG"][90] = "beneficiary_country";
		//arrProductColumn["SG"][91] = "applicant_country";
		
		//arrProductColumn["SGTnx"][150] = "beneficiary_country";
		//arrProductColumn["SGTnx"][151] = "applicant_country";