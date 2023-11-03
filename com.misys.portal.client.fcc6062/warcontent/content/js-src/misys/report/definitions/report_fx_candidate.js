dojo.provide("misys.report.definitions.report_fx_candidate");


		// Copyright (c) 2000-2010 Misys (http://www.misys.com),
		// All Rights Reserved. 
	
		//
		// FX candidate
		//

		// Define an array which stores the FX columns
		

		arrProductColumn["FX"][0] = "ref_id";
		arrProductColumn["FX"][1] = "cust_ref_id";
		arrProductColumn["FX"][2] = "prod_stat_code";
		arrProductColumn["FX"][3] = "appl_date";
		arrProductColumn["FX"][4] = "iss_date";
		arrProductColumn["FX"][5] = "maturity_date";
		arrProductColumn["FX"][6] = "fx_cur_code";
		arrProductColumn["FX"][7] = "fx_amt";
		arrProductColumn["FX"][8] = "near_amt";
		arrProductColumn["FX"][9] = "counter_cur_code";
		arrProductColumn["FX"][10] = "counter_amt";
		arrProductColumn["FX"][11] = "near_counter_amt";
		arrProductColumn["FX"][12] = "fx_type";
		arrProductColumn["FX"][13] = "rate";
		arrProductColumn["FX"][14] = "near_rate";
		arrProductColumn["FX"][15] = "contract_type";
		arrProductColumn["FX"][16] = "trade_id";
		arrProductColumn["FX"][17] = "value_date";
		arrProductColumn["FX"][18] = "option_date";
		arrProductColumn["FX"][19] = "near_date";
		arrProductColumn["FX"][20] = "fx_liab_amt";		
		arrProductColumn["FX"][21] = "fee_act_no";
		
		arrProductColumn["FX"][22] = "entity";
		arrProductColumn["FX"][23] = "applicant_name";
		arrProductColumn["FX"][24] = "applicant_address_line_1";
		arrProductColumn["FX"][25] = "applicant_address_line_2";
		arrProductColumn["FX"][26] = "applicant_dom";
		arrProductColumn["FX"][27] = "applicant_reference";
				
		arrProductColumn["FX"][28] = "IssuingBank@name";
		arrProductColumn["FX"][29] = "IssuingBank@address_line_1";
		arrProductColumn["FX"][30] = "IssuingBank@address_line_2";
		arrProductColumn["FX"][31] = "IssuingBank@dom";
		
		arrProductColumn["FX"][32]= "Charge@chrg_code";
		arrProductColumn["FX"][33]= "Charge@amt";
		arrProductColumn["FX"][34]= "Charge@cur_code";
		arrProductColumn["FX"][35]= "Charge@status";
		arrProductColumn["FX"][36] = "Charge@additional_comment";
		arrProductColumn["FX"][37] = "Charge@settlement_date";
				
		arrProductColumn["FX"][38] = "sub_product_code";
		arrProductColumn["FX"][39] = "bo_ref_id";
		arrProductColumn["FX"][40] = "action_req_code";
		arrProductColumn["FX"][41] = "original_amt";
		arrProductColumn["FX"][42] = "original_counter_amt";

		//
		// FX Transaction candidate
		//

		// Define an array which stores the FX Transaction columns
		

		arrProductColumn["FXTnx"][0] = "ref_id";
		arrProductColumn["FXTnx"][1] = "cust_ref_id";
		arrProductColumn["FXTnx"][2] = "tnx_type_code";
		arrProductColumn["FXTnx"][3] = "sub_tnx_type_code";
		arrProductColumn["FXTnx"][4] = "prod_stat_code";
		arrProductColumn["FXTnx"][5] = "tnx_val_date";
		arrProductColumn["FXTnx"][6] = "tnx_amt";
		arrProductColumn["FXTnx"][7] = "tnx_cur_code";
		
		arrProductColumn["FXTnx"][8] = "appl_date";
		arrProductColumn["FXTnx"][9] = "iss_date";
		arrProductColumn["FXTnx"][10] = "maturity_date";
		arrProductColumn["FXTnx"][11] = "fx_cur_code";
		arrProductColumn["FXTnx"][12] = "fx_amt";
		arrProductColumn["FXTnx"][13] = "near_amt";
		arrProductColumn["FXTnx"][14] = "counter_cur_code";
		arrProductColumn["FXTnx"][15] = "counter_amt";
		arrProductColumn["FXTnx"][16] = "near_counter_amt";
		arrProductColumn["FXTnx"][17] = "fx_type";
		arrProductColumn["FXTnx"][18] = "rate";
		arrProductColumn["FXTnx"][19] = "near_rate";
		arrProductColumn["FXTnx"][20] = "contract_type";
		arrProductColumn["FXTnx"][21] = "trade_id";
		arrProductColumn["FXTnx"][22] = "value_date";
		arrProductColumn["FXTnx"][23] = "option_date";
		arrProductColumn["FXTnx"][25] = "near_date";
		arrProductColumn["FXTnx"][26] = "fx_liab_amt";		
		arrProductColumn["FXTnx"][27] = "fee_act_no";
		
		arrProductColumn["FXTnx"][28] = "entity";
		arrProductColumn["FXTnx"][29] = "applicant_name";
		arrProductColumn["FXTnx"][30] = "applicant_address_line_1";
		arrProductColumn["FXTnx"][31] = "applicant_address_line_2";
		arrProductColumn["FXTnx"][32] = "applicant_dom";
		arrProductColumn["FXTnx"][33] = "applicant_reference";
				
		arrProductColumn["FXTnx"][34] = "IssuingBank@name";
		arrProductColumn["FXTnx"][35] = "IssuingBank@address_line_1";
		arrProductColumn["FXTnx"][36] = "IssuingBank@address_line_2";
		arrProductColumn["FXTnx"][37] = "IssuingBank@dom";
		
		arrProductColumn["FXTnx"][38] = "Inputter@last_name";
		arrProductColumn["FXTnx"][39] = "Inputter@first_name";
		arrProductColumn["FXTnx"][40] = "inp_dttm";
		arrProductColumn["FXTnx"][41] = "LastController@LastControllerUser@first_name";
		arrProductColumn["FXTnx"][42] = "LastController@LastControllerUser@last_name";
		arrProductColumn["FXTnx"][43] = "LastController@validation_dttm";
		arrProductColumn["FXTnx"][44] = "Releaser@last_name";
		arrProductColumn["FXTnx"][45] = "Releaser@first_name";
		arrProductColumn["FXTnx"][46] = "release_dttm";

		arrProductColumn["FXTnx"][47] = "Charge@chrg_code";
		arrProductColumn["FXTnx"][48] = "Charge@amt";
		arrProductColumn["FXTnx"][49] = "Charge@cur_code";
		arrProductColumn["FXTnx"][50] = "Charge@status";
		arrProductColumn["FXTnx"][51] = "Charge@additional_comment";
		arrProductColumn["FXTnx"][52] = "Charge@settlement_date";

		arrProductColumn["FXTnx"][53] = "bo_release_dttm";
		
		arrProductColumn["FXTnx"][54] = "sub_product_code";
		arrProductColumn["FXTnx"][55] = "bo_ref_id";
		arrProductColumn["FXTnx"][56] = "action_req_code";
		arrProductColumn["FXTnx"][57] = "original_amt";
		arrProductColumn["FXTnx"][58] = "original_counter_amt";
