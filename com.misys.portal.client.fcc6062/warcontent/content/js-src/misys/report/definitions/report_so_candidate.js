dojo.provide("misys.report.definitions.report_so_candidate");


		// Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
		// All Rights Reserved. 
	
		//
		// SO candidate
		//

		// Define an array which stores the SO columns
		

		arrProductColumn["SO"][0] = "ref_id";
		arrProductColumn["SO"][1] = "template_id";
		arrProductColumn["SO"][2] = "bo_ref_id";
		arrProductColumn["SO"][3] = "cust_ref_id";
		arrProductColumn["SO"][7] = "prod_stat_code";
		arrProductColumn["SO"][17] = "entity";
		arrProductColumn["SO"][18] = "group_id";
		arrProductColumn["SO"][19] = "appl_date";
		arrProductColumn["SO"][20] = "iss_date";
		arrProductColumn["SO"][22] = "issuer_ref_id";
		arrProductColumn["SO"][23] = "buyer_abbv_name";
		arrProductColumn["SO"][24] = "buyer_name";
		arrProductColumn["SO"][25] = "buyer_bei";
		arrProductColumn["SO"][26] = "buyer_bank_bic";
		arrProductColumn["SO"][27] = "buyer_street_name";
		arrProductColumn["SO"][28] = "buyer_post_code";
		arrProductColumn["SO"][29] = "buyer_town_name";
		arrProductColumn["SO"][30] = "buyer_country_sub_div";
		arrProductColumn["SO"][31] = "buyer_country";
		arrProductColumn["SO"][32] = "buyer_reference";
		arrProductColumn["SO"][33] = "seller_abbv_name";
		arrProductColumn["SO"][109] = "seller_name";
		arrProductColumn["SO"][35] = "seller_bei";
		arrProductColumn["SO"][36] = "seller_bank_bic";
		arrProductColumn["SO"][37] = "seller_street_name";
		arrProductColumn["SO"][38] = "seller_post_code";
		arrProductColumn["SO"][39] = "seller_town_name";
		arrProductColumn["SO"][40] = "seller_country_sub_div";
		arrProductColumn["SO"][41] = "seller_country";
		arrProductColumn["SO"][42] = "seller_reference";
		arrProductColumn["SO"][43] = "bill_to_abbv_name";
		arrProductColumn["SO"][44] = "bill_to_name";
		arrProductColumn["SO"][45] = "bill_to_bei";
		arrProductColumn["SO"][46] = "bill_to_street_name";
		arrProductColumn["SO"][47] = "bill_to_post_code";
		arrProductColumn["SO"][48] = "bill_to_town_name";
		arrProductColumn["SO"][49] = "bill_to_country_sub_div";
		arrProductColumn["SO"][50] = "bill_to_country";
		arrProductColumn["SO"][51] = "ship_to_abbv_name";
		arrProductColumn["SO"][52] = "ship_to_name";
		arrProductColumn["SO"][53] = "ship_to_bei";
		arrProductColumn["SO"][54] = "ship_to_street_name";
		arrProductColumn["SO"][55] = "ship_to_post_code";
		arrProductColumn["SO"][56] = "ship_to_town_name";
		arrProductColumn["SO"][57] = "ship_to_country_sub_div";
		arrProductColumn["SO"][58] = "ship_to_country";
		arrProductColumn["SO"][59] = "consgn_abbv_name";
		arrProductColumn["SO"][60] = "consgn_name";
		arrProductColumn["SO"][61] = "consgn_bei";
		arrProductColumn["SO"][62] = "consgn_street_name";
		arrProductColumn["SO"][63] = "consgn_post_code";
		arrProductColumn["SO"][64] = "consgn_town_name";
		arrProductColumn["SO"][65] = "consgn_country_sub_div";
		arrProductColumn["SO"][66] = "consgn_country";
		arrProductColumn["SO"][67] = "goods_desc";
		arrProductColumn["SO"][68] = "part_ship";
		arrProductColumn["SO"][69] = "tran_ship";
		arrProductColumn["SO"][70] = "last_ship_date";
		arrProductColumn["SO"][71] = "nb_mismatch";
		arrProductColumn["SO"][72] = "full_match";
		arrProductColumn["SO"][73] = "total_amt";
		arrProductColumn["SO"][74] = "total_cur_code";
		arrProductColumn["SO"][75] = "total_net_amt";
		arrProductColumn["SO"][76] = "total_net_cur_code";
		arrProductColumn["SO"][77] = "order_total_amt";
		arrProductColumn["SO"][78] = "order_total_cur_code";
		arrProductColumn["SO"][79] = "order_total_net_amt";
		arrProductColumn["SO"][80] = "order_total_net_cur_code";
		arrProductColumn["SO"][81] = "accpt_total_amt";
		arrProductColumn["SO"][82] = "accpt_total_cur_code";
		arrProductColumn["SO"][83] = "accpt_total_net_amt";
		arrProductColumn["SO"][84] = "accpt_total_net_cur_code";
		arrProductColumn["SO"][85] = "liab_total_amt";
		arrProductColumn["SO"][86] = "liab_total_cur_code";
		arrProductColumn["SO"][87] = "liab_total_net_amt";
		arrProductColumn["SO"][88] = "liab_total_net_cur_code";
		arrProductColumn["SO"][89] = "fin_inst_bic";
		arrProductColumn["SO"][90] = "fin_inst_name";
		arrProductColumn["SO"][91] = "fin_inst_street_name";
		arrProductColumn["SO"][92] = "fin_inst_post_code";
		arrProductColumn["SO"][93] = "fin_inst_town_name";
		arrProductColumn["SO"][94] = "fin_inst_country_sub_div";
		arrProductColumn["SO"][95] = "fin_inst_country";
		arrProductColumn["SO"][96] = "seller_account_name";
		arrProductColumn["SO"][97] = "seller_account_iban";
		arrProductColumn["SO"][98] = "seller_account_bban";
		arrProductColumn["SO"][99] = "seller_account_upic";
		arrProductColumn["SO"][100] = "seller_account_id";
		arrProductColumn["SO"][101] = "reqrd_commercial_dataset";
		arrProductColumn["SO"][102] = "reqrd_transport_dataset";
		arrProductColumn["SO"][103] = "last_match_date";
		//arrProductColumn["SO"][104] = "submitr_bic";
		//arrProductColumn["SO"][105] = "data_set_id";
		arrProductColumn["SO"][106] = "freight_charges_type";
		//arrProductColumn["SO"][107] = "version";

		
		arrProductColumn["SO"][108] = "BuyerBank@name";
		arrProductColumn["SO"][109] = "BuyerBank@address_line_1";
		arrProductColumn["SO"][110] = "BuyerBank@address_line_2";
		arrProductColumn["SO"][111] = "BuyerBank@dom";
		
		arrProductColumn["SO"][112] = "SellerBank@name";
		arrProductColumn["SO"][113] = "SellerBank@address_line_1";
		arrProductColumn["SO"][114] = "SellerBank@address_line_2";
		arrProductColumn["SO"][115] = "SellerBank@dom";
						
		arrProductColumn["SO"][130] = "Charge@chrg_code";
		arrProductColumn["SO"][131] = "Charge@amt";
		arrProductColumn["SO"][132] = "Charge@cur_code";
		arrProductColumn["SO"][133] = "Charge@status";
		arrProductColumn["SO"][134] = "Charge@additional_comment";
		arrProductColumn["SO"][135] = "Charge@settlement_date";

		//
		// SO Transaction candidate
		//

		// Define an array which stores the SO Transaction columns
		

		arrProductColumn["SOTnx"][0] = "ref_id";
		arrProductColumn["SOTnx"][1] = "template_id";
		arrProductColumn["SOTnx"][2] = "bo_ref_id";
		arrProductColumn["SOTnx"][3] = "cust_ref_id";
		arrProductColumn["SOTnx"][5] = "tnx_type_code";
		arrProductColumn["SOTnx"][6] = "sub_tnx_type_code";
		arrProductColumn["SOTnx"][7] = "prod_stat_code";
		
		arrProductColumn["SOTnx"][108] = "tnx_val_date";
		arrProductColumn["SOTnx"][109] = "tnx_amt";
		arrProductColumn["SOTnx"][110] = "tnx_cur_code";
		arrProductColumn["SOTnx"][111] = "entity";
		
		arrProductColumn["SOTnx"][19] = "appl_date";
		arrProductColumn["SOTnx"][20] = "iss_date";
		arrProductColumn["SOTnx"][21] = "group_id";
		arrProductColumn["SOTnx"][22] = "issuer_ref_id";
		arrProductColumn["SOTnx"][23] = "buyer_abbv_name";
		arrProductColumn["SOTnx"][24] = "buyer_name";
		arrProductColumn["SOTnx"][25] = "buyer_bei";
		arrProductColumn["SOTnx"][26] = "buyer_bank_bic";
		arrProductColumn["SOTnx"][27] = "buyer_street_name";
		arrProductColumn["SOTnx"][28] = "buyer_post_code";
		arrProductColumn["SOTnx"][29] = "buyer_town_name";
		arrProductColumn["SOTnx"][30] = "buyer_country_sub_div";
		arrProductColumn["SOTnx"][31] = "buyer_country";
		arrProductColumn["SOTnx"][32] = "buyer_reference";
		arrProductColumn["SOTnx"][33] = "seller_abbv_name";
		arrProductColumn["SOTnx"][34] = "seller_name";
		arrProductColumn["SOTnx"][35] = "seller_bei";
		arrProductColumn["SOTnx"][36] = "seller_bank_bic";
		arrProductColumn["SOTnx"][37] = "seller_street_name";
		arrProductColumn["SOTnx"][38] = "seller_post_code";
		arrProductColumn["SOTnx"][39] = "seller_town_name";
		arrProductColumn["SOTnx"][40] = "seller_country_sub_div";
		arrProductColumn["SOTnx"][41] = "seller_country";
		arrProductColumn["SOTnx"][42] = "seller_reference";
		arrProductColumn["SOTnx"][43] = "bill_to_abbv_name";
		arrProductColumn["SOTnx"][44] = "bill_to_name";
		arrProductColumn["SOTnx"][45] = "bill_to_bei";
		arrProductColumn["SOTnx"][46] = "bill_to_street_name";
		arrProductColumn["SOTnx"][47] = "bill_to_post_code";
		arrProductColumn["SOTnx"][48] = "bill_to_town_name";
		arrProductColumn["SOTnx"][49] = "bill_to_country_sub_div";
		arrProductColumn["SOTnx"][50] = "bill_to_country";
		arrProductColumn["SOTnx"][51] = "ship_to_abbv_name";
		arrProductColumn["SOTnx"][52] = "ship_to_name";
		arrProductColumn["SOTnx"][53] = "ship_to_bei";
		arrProductColumn["SOTnx"][54] = "ship_to_street_name";
		arrProductColumn["SOTnx"][55] = "ship_to_post_code";
		arrProductColumn["SOTnx"][56] = "ship_to_town_name";
		arrProductColumn["SOTnx"][57] = "ship_to_country_sub_div";
		arrProductColumn["SOTnx"][58] = "ship_to_country";
		arrProductColumn["SOTnx"][59] = "consgn_abbv_name";
		arrProductColumn["SOTnx"][60] = "consgn_name";
		arrProductColumn["SOTnx"][61] = "consgn_bei";
		arrProductColumn["SOTnx"][62] = "consgn_street_name";
		arrProductColumn["SOTnx"][63] = "consgn_post_code";
		arrProductColumn["SOTnx"][64] = "consgn_town_name";
		arrProductColumn["SOTnx"][65] = "consgn_country_sub_div";
		arrProductColumn["SOTnx"][66] = "consgn_country";
		arrProductColumn["SOTnx"][67] = "goods_desc";
		arrProductColumn["SOTnx"][68] = "part_ship";
		arrProductColumn["SOTnx"][69] = "tran_ship";
		arrProductColumn["SOTnx"][70] = "last_ship_date";
		arrProductColumn["SOTnx"][71] = "nb_mismatch";
		arrProductColumn["SOTnx"][72] = "full_match";
		arrProductColumn["SOTnx"][73] = "total_amt";
		arrProductColumn["SOTnx"][74] = "total_cur_code";
		arrProductColumn["SOTnx"][75] = "total_net_amt";
		arrProductColumn["SOTnx"][76] = "total_net_cur_code";
		arrProductColumn["SOTnx"][77] = "order_total_amt";
		arrProductColumn["SOTnx"][78] = "order_total_cur_code";
		arrProductColumn["SOTnx"][79] = "order_total_net_amt";
		arrProductColumn["SOTnx"][80] = "order_total_net_cur_code";
		arrProductColumn["SOTnx"][81] = "accpt_total_amt";
		arrProductColumn["SOTnx"][82] = "accpt_total_cur_code";
		arrProductColumn["SOTnx"][83] = "accpt_total_net_amt";
		arrProductColumn["SOTnx"][84] = "accpt_total_net_cur_code";
		arrProductColumn["SOTnx"][85] = "liab_total_amt";
		arrProductColumn["SOTnx"][86] = "liab_total_cur_code";
		arrProductColumn["SOTnx"][87] = "liab_total_net_amt";
		arrProductColumn["SOTnx"][88] = "liab_total_net_cur_code";
		arrProductColumn["SOTnx"][89] = "fin_inst_bic";
		arrProductColumn["SOTnx"][90] = "fin_inst_name";
		arrProductColumn["SOTnx"][91] = "fin_inst_street_name";
		arrProductColumn["SOTnx"][92] = "fin_inst_post_code";
		arrProductColumn["SOTnx"][93] = "fin_inst_town_name";
		arrProductColumn["SOTnx"][94] = "fin_inst_country_sub_div";
		arrProductColumn["SOTnx"][95] = "fin_inst_country";
		arrProductColumn["SOTnx"][96] = "seller_account_name";
		arrProductColumn["SOTnx"][97] = "seller_account_iban";
		arrProductColumn["SOTnx"][98] = "seller_account_bban";
		arrProductColumn["SOTnx"][99] = "seller_account_upic";
		arrProductColumn["SOTnx"][100] = "seller_account_id";
		arrProductColumn["SOTnx"][101] = "reqrd_commercial_dataset";
		arrProductColumn["SOTnx"][102] = "reqrd_transport_dataset";
		arrProductColumn["SOTnx"][103] = "last_match_date";
		//arrProductColumn[SOTnx][104] = "submitr_bic";
		//arrProductColumn["SOTnx"][105] = "data_set_id";
		arrProductColumn["SOTnx"][106] = "freight_charges_type";
		//arrProductColumn["SOTnx"][107] = "version";

		
		arrProductColumn["SOTnx"][108] = "BuyerBank@name";
		arrProductColumn["SOTnx"][109] = "BuyerBank@address_line_1";
		arrProductColumn["SOTnx"][110] = "BuyerBank@address_line_2";
		arrProductColumn["SOTnx"][111] = "BuyerBank@dom";
		
		arrProductColumn["SOTnx"][112] = "SellerBank@name";
		arrProductColumn["SOTnx"][113] = "SellerBank@address_line_1";
		arrProductColumn["SOTnx"][114] = "SellerBank@address_line_2";
		arrProductColumn["SOTnx"][115] = "SellerBank@dom";
						
		arrProductColumn["SOTnx"][130] = "Inputter@last_name";
		arrProductColumn["SOTnx"][131] = "Inputter@first_name";
		arrProductColumn["SOTnx"][132] = "inp_dttm";
		arrProductColumn["SOTnx"][135] = "LastController@validation_dttm";
		arrProductColumn["SOTnx"][136] = "Releaser@last_name";
		arrProductColumn["SOTnx"][137] = "Releaser@first_name";
		arrProductColumn["SOTnx"][138] = "release_dttm";
		
		arrProductColumn["SOTnx"][140] = "Charge@chrg_code";
		arrProductColumn["SOTnx"][141] = "Charge@amt";
		arrProductColumn["SOTnx"][142] = "Charge@cur_code";
		arrProductColumn["SOTnx"][143] = "Charge@status";
		arrProductColumn["SOTnx"][144] = "Charge@additional_comment";
		arrProductColumn["SOTnx"][145] = "Charge@settlement_date";

		arrProductColumn["SOTnx"][150] = "bo_release_dttm";
	