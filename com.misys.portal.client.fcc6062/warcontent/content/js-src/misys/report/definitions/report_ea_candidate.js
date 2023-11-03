dojo.provide("misys.report.definitions.report_ea_candidate");


		// Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
		// All Rights Reserved. 
	
		//
		// EA candidate
		//

		// Define an array which stores the EA columns
		

		arrProductColumn["EA"][0] = "ref_id";
		arrProductColumn["EA"][1] = "template_id";
		arrProductColumn["EA"][2] = "bo_ref_id";
		arrProductColumn["EA"][3] = "cust_ref_id";
		arrProductColumn["EA"][7] = "prod_stat_code";
		arrProductColumn["EA"][17] = "entity";
		arrProductColumn["EA"][18] = "group_id";
		arrProductColumn["EA"][19] = "appl_date";
		arrProductColumn["EA"][20] = "iss_date";
		arrProductColumn["EA"][22] = "issuer_ref_id";
		arrProductColumn["EA"][23] = "buyer_abbv_name";
		arrProductColumn["EA"][24] = "buyer_name";
		arrProductColumn["EA"][25] = "buyer_bei";
		arrProductColumn["EA"][26] = "buyer_bank_bic";
		arrProductColumn["EA"][27] = "buyer_street_name";
		arrProductColumn["EA"][28] = "buyer_post_code";
		arrProductColumn["EA"][29] = "buyer_town_name";
		arrProductColumn["EA"][30] = "buyer_country_sub_div";
		arrProductColumn["EA"][31] = "buyer_country";
		arrProductColumn["EA"][32] = "buyer_reference";
		arrProductColumn["EA"][33] = "seller_abbv_name";
		arrProductColumn["EA"][34] = "seller_name";
		arrProductColumn["EA"][35] = "seller_bei";
		arrProductColumn["EA"][36] = "seller_bank_bic";
		arrProductColumn["EA"][37] = "seller_street_name";
		arrProductColumn["EA"][38] = "seller_post_code";
		arrProductColumn["EA"][39] = "seller_town_name";
		arrProductColumn["EA"][40] = "seller_country_sub_div";
		arrProductColumn["EA"][41] = "seller_country";
		arrProductColumn["EA"][42] = "seller_reference";
		arrProductColumn["EA"][43] = "bill_to_abbv_name";
		arrProductColumn["EA"][44] = "bill_to_name";
		arrProductColumn["EA"][45] = "bill_to_bei";
		arrProductColumn["EA"][46] = "bill_to_street_name";
		arrProductColumn["EA"][47] = "bill_to_post_code";
		arrProductColumn["EA"][48] = "bill_to_town_name";
		arrProductColumn["EA"][49] = "bill_to_country_sub_div";
		arrProductColumn["EA"][50] = "bill_to_country";
		arrProductColumn["EA"][51] = "ship_to_abbv_name";
		arrProductColumn["EA"][52] = "ship_to_name";
		arrProductColumn["EA"][53] = "ship_to_bei";
		arrProductColumn["EA"][54] = "ship_to_street_name";
		arrProductColumn["EA"][55] = "ship_to_post_code";
		arrProductColumn["EA"][56] = "ship_to_town_name";
		arrProductColumn["EA"][57] = "ship_to_country_sub_div";
		arrProductColumn["EA"][58] = "ship_to_country";
		arrProductColumn["EA"][59] = "consgn_abbv_name";
		arrProductColumn["EA"][60] = "consgn_name";
		arrProductColumn["EA"][61] = "consgn_bei";
		arrProductColumn["EA"][62] = "consgn_street_name";
		arrProductColumn["EA"][63] = "consgn_post_code";
		arrProductColumn["EA"][64] = "consgn_town_name";
		arrProductColumn["EA"][65] = "consgn_country_sub_div";
		arrProductColumn["EA"][66] = "consgn_country";
		arrProductColumn["EA"][67] = "goods_desc";
		arrProductColumn["EA"][68] = "part_ship";
		arrProductColumn["EA"][69] = "tran_ship";
		arrProductColumn["EA"][70] = "last_ship_date";
		arrProductColumn["EA"][71] = "nb_mismatch";
		arrProductColumn["EA"][72] = "full_match";
		arrProductColumn["EA"][73] = "total_amt";
		arrProductColumn["EA"][74] = "total_cur_code";
		arrProductColumn["EA"][75] = "total_net_amt";
		arrProductColumn["EA"][76] = "total_net_cur_code";
		arrProductColumn["EA"][77] = "order_total_amt";
		arrProductColumn["EA"][78] = "order_total_cur_code";
		arrProductColumn["EA"][79] = "order_total_net_amt";
		arrProductColumn["EA"][80] = "order_total_net_cur_code";
		arrProductColumn["EA"][81] = "accpt_total_amt";
		arrProductColumn["EA"][82] = "accpt_total_cur_code";
		arrProductColumn["EA"][83] = "accpt_total_net_amt";
		arrProductColumn["EA"][84] = "accpt_total_net_cur_code";
		arrProductColumn["EA"][85] = "liab_total_amt";
		arrProductColumn["EA"][86] = "liab_total_cur_code";
		arrProductColumn["EA"][87] = "liab_total_net_amt";
		arrProductColumn["EA"][88] = "liab_total_net_cur_code";
		arrProductColumn["EA"][89] = "fin_inst_bic";
		arrProductColumn["EA"][90] = "fin_inst_name";
		arrProductColumn["EA"][91] = "fin_inst_street_name";
		arrProductColumn["EA"][92] = "fin_inst_post_code";
		arrProductColumn["EA"][93] = "fin_inst_town_name";
		arrProductColumn["EA"][94] = "fin_inst_country_sub_div";
		arrProductColumn["EA"][95] = "fin_inst_country";
		arrProductColumn["EA"][96] = "seller_account_name";
		arrProductColumn["EA"][97] = "seller_account_iban";
		arrProductColumn["EA"][98] = "seller_account_bban";
		arrProductColumn["EA"][99] = "seller_account_upic";
		arrProductColumn["EA"][100] = "seller_account_id";
		arrProductColumn["EA"][101] = "reqrd_commercial_dataset";
		arrProductColumn["EA"][102] = "reqrd_transport_dataset";
		arrProductColumn["EA"][103] = "last_match_date";
		//arrProductColumn["EA"][104] = "submitr_bic";
		//arrProductColumn["EA"][105] = "data_set_id";
		arrProductColumn["EA"][106] = "freight_charges_type";
		//arrProductColumn["EA"][107] = "version";

		
		arrProductColumn["EA"][108] = "BuyerBank@name";
		arrProductColumn["EA"][109] = "BuyerBank@address_line_1";
		arrProductColumn["EA"][110] = "BuyerBank@address_line_2";
		arrProductColumn["EA"][111] = "BuyerBank@dom";
		
		arrProductColumn["EA"][112] = "SellerBank@name";
		arrProductColumn["EA"][113] = "SellerBank@address_line_1";
		arrProductColumn["EA"][114] = "SellerBank@address_line_2";
		arrProductColumn["EA"][115] = "SellerBank@dom";
						
		arrProductColumn["EA"][130] = "Charge@chrg_code";
		arrProductColumn["EA"][131] = "Charge@amt";
		arrProductColumn["EA"][132] = "Charge@cur_code";
		arrProductColumn["EA"][133] = "Charge@status";
		arrProductColumn["EA"][134] = "Charge@additional_comment";
		arrProductColumn["EA"][135] = "Charge@settlement_date";

		//
		// EA Transaction candidate
		//

		// Define an array which stores the EA Transaction columns
		

		arrProductColumn["EATnx"][0] = "ref_id";
		arrProductColumn["EATnx"][1] = "template_id";
		arrProductColumn["EATnx"][2] = "bo_ref_id";
		arrProductColumn["EATnx"][3] = "cust_ref_id";
		arrProductColumn["EATnx"][5] = "tnx_type_code";
		arrProductColumn["EATnx"][6] = "sub_tnx_type_code";
		arrProductColumn["EATnx"][7] = "prod_stat_code";
		
		arrProductColumn["EATnx"][108] = "tnx_val_date";
		arrProductColumn["EATnx"][109] = "tnx_amt";
		arrProductColumn["EATnx"][110] = "tnx_cur_code";
		arrProductColumn["EATnx"][111] = "entity";
		
		arrProductColumn["EATnx"][19] = "appl_date";
		arrProductColumn["EATnx"][20] = "iss_date";
		arrProductColumn["EATnx"][21] = "group_id";
		arrProductColumn["EATnx"][22] = "issuer_ref_id";
		arrProductColumn["EATnx"][23] = "buyer_abbv_name";
		arrProductColumn["EATnx"][24] = "buyer_name";
		arrProductColumn["EATnx"][25] = "buyer_bei";
		arrProductColumn["EATnx"][26] = "buyer_bank_bic";
		arrProductColumn["EATnx"][27] = "buyer_street_name";
		arrProductColumn["EATnx"][28] = "buyer_post_code";
		arrProductColumn["EATnx"][29] = "buyer_town_name";
		arrProductColumn["EATnx"][30] = "buyer_country_sub_div";
		arrProductColumn["EATnx"][31] = "buyer_country";
		arrProductColumn["EATnx"][32] = "buyer_reference";
		arrProductColumn["EATnx"][33] = "seller_abbv_name";
		arrProductColumn["EATnx"][34] = "seller_name";
		arrProductColumn["EATnx"][35] = "seller_bei";
		arrProductColumn["EATnx"][36] = "seller_bank_bic";
		arrProductColumn["EATnx"][37] = "seller_street_name";
		arrProductColumn["EATnx"][38] = "seller_post_code";
		arrProductColumn["EATnx"][39] = "seller_town_name";
		arrProductColumn["EATnx"][40] = "seller_country_sub_div";
		arrProductColumn["EATnx"][41] = "seller_country";
		arrProductColumn["EATnx"][42] = "seller_reference";
		arrProductColumn["EATnx"][43] = "bill_to_abbv_name";
		arrProductColumn["EATnx"][44] = "bill_to_name";
		arrProductColumn["EATnx"][45] = "bill_to_bei";
		arrProductColumn["EATnx"][46] = "bill_to_street_name";
		arrProductColumn["EATnx"][47] = "bill_to_post_code";
		arrProductColumn["EATnx"][48] = "bill_to_town_name";
		arrProductColumn["EATnx"][49] = "bill_to_country_sub_div";
		arrProductColumn["EATnx"][50] = "bill_to_country";
		arrProductColumn["EATnx"][51] = "ship_to_abbv_name";
		arrProductColumn["EATnx"][52] = "ship_to_name";
		arrProductColumn["EATnx"][53] = "ship_to_bei";
		arrProductColumn["EATnx"][54] = "ship_to_street_name";
		arrProductColumn["EATnx"][55] = "ship_to_post_code";
		arrProductColumn["EATnx"][56] = "ship_to_town_name";
		arrProductColumn["EATnx"][57] = "ship_to_country_sub_div";
		arrProductColumn["EATnx"][58] = "ship_to_country";
		arrProductColumn["EATnx"][59] = "consgn_abbv_name";
		arrProductColumn["EATnx"][60] = "consgn_name";
		arrProductColumn["EATnx"][61] = "consgn_bei";
		arrProductColumn["EATnx"][62] = "consgn_street_name";
		arrProductColumn["EATnx"][63] = "consgn_post_code";
		arrProductColumn["EATnx"][64] = "consgn_town_name";
		arrProductColumn["EATnx"][65] = "consgn_country_sub_div";
		arrProductColumn["EATnx"][66] = "consgn_country";
		arrProductColumn["EATnx"][67] = "goods_desc";
		arrProductColumn["EATnx"][68] = "part_ship";
		arrProductColumn["EATnx"][69] = "tran_ship";
		arrProductColumn["EATnx"][70] = "last_ship_date";
		arrProductColumn["EATnx"][71] = "nb_mismatch";
		arrProductColumn["EATnx"][72] = "full_match";
		arrProductColumn["EATnx"][73] = "total_amt";
		arrProductColumn["EATnx"][74] = "total_cur_code";
		arrProductColumn["EATnx"][75] = "total_net_amt";
		arrProductColumn["EATnx"][76] = "total_net_cur_code";
		arrProductColumn["EATnx"][77] = "order_total_amt";
		arrProductColumn["EATnx"][78] = "order_total_cur_code";
		arrProductColumn["EATnx"][79] = "order_total_net_amt";
		arrProductColumn["EATnx"][80] = "order_total_net_cur_code";
		arrProductColumn["EATnx"][81] = "accpt_total_amt";
		arrProductColumn["EATnx"][82] = "accpt_total_cur_code";
		arrProductColumn["EATnx"][83] = "accpt_total_net_amt";
		arrProductColumn["EATnx"][84] = "accpt_total_net_cur_code";
		arrProductColumn["EATnx"][85] = "liab_total_amt";
		arrProductColumn["EATnx"][86] = "liab_total_cur_code";
		arrProductColumn["EATnx"][87] = "liab_total_net_amt";
		arrProductColumn["EATnx"][88] = "liab_total_net_cur_code";
		arrProductColumn["EATnx"][89] = "fin_inst_bic";
		arrProductColumn["EATnx"][90] = "fin_inst_name";
		arrProductColumn["EATnx"][91] = "fin_inst_street_name";
		arrProductColumn["EATnx"][92] = "fin_inst_post_code";
		arrProductColumn["EATnx"][93] = "fin_inst_town_name";
		arrProductColumn["EATnx"][94] = "fin_inst_country_sub_div";
		arrProductColumn["EATnx"][95] = "fin_inst_country";
		arrProductColumn["EATnx"][96] = "seller_account_name";
		arrProductColumn["EATnx"][97] = "seller_account_iban";
		arrProductColumn["EATnx"][98] = "seller_account_bban";
		arrProductColumn["EATnx"][99] = "seller_account_upic";
		arrProductColumn["EATnx"][100] = "seller_account_id";
		arrProductColumn["EATnx"][101] = "reqrd_commercial_dataset";
		arrProductColumn["EATnx"][102] = "reqrd_transport_dataset";
		arrProductColumn["EATnx"][103] = "last_match_date";
		//arrProductColumn[EATnx][104] = "submitr_bic";
		//arrProductColumn["EATnx"][105] = "data_set_id";
		arrProductColumn["EATnx"][106] = "freight_charges_type";
		//arrProductColumn["EATnx"][107] = "version";

		
		arrProductColumn["EATnx"][108] = "BuyerBank@name";
		arrProductColumn["EATnx"][109] = "BuyerBank@address_line_1";
		arrProductColumn["EATnx"][110] = "BuyerBank@address_line_2";
		arrProductColumn["EATnx"][111] = "BuyerBank@dom";
		
		arrProductColumn["EATnx"][112] = "SellerBank@name";
		arrProductColumn["EATnx"][113] = "SellerBank@address_line_1";
		arrProductColumn["EATnx"][114] = "SellerBank@address_line_2";
		arrProductColumn["EATnx"][115] = "SellerBank@dom";
						
		arrProductColumn["EATnx"][130] = "Inputter@last_name";
		arrProductColumn["EATnx"][131] = "Inputter@first_name";
		arrProductColumn["EATnx"][132] = "inp_dttm";
		arrProductColumn["EATnx"][133] = "Controller@last_name";
		arrProductColumn["EATnx"][134] = "Controller@first_name";
		arrProductColumn["EATnx"][135] = "LastController@validation_dttm";
		arrProductColumn["EATnx"][136] = "Releaser@last_name";
		arrProductColumn["EATnx"][137] = "Releaser@first_name";
		arrProductColumn["EATnx"][138] = "release_dttm";
		
		arrProductColumn["EATnx"][140] = "Charge@chrg_code";
		arrProductColumn["EATnx"][141] = "Charge@amt";
		arrProductColumn["EATnx"][142] = "Charge@cur_code";
		arrProductColumn["EATnx"][143] = "Charge@status";
		arrProductColumn["EATnx"][144] = "Charge@additional_comment";
		arrProductColumn["EATnx"][145] = "Charge@settlement_date";

		arrProductColumn["EATnx"][150] = "bo_release_dttm";
	