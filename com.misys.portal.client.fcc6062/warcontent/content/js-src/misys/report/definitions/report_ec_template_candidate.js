dojo.provide("misys.report.definitions.report_ec_template_candidate");


		// Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
		// All Rights Reserved. 
		
		//
		// EC Template candidate
		//
		
		// Define an array which stores the LC Template columns
		

		arrProductColumn["ECTemplate"][0] = "template_id";
		arrProductColumn["ECTemplate"][1] = "template_description";
		arrProductColumn["ECTemplate"][27] = "ec_type_code";
		
		arrProductColumn["ECTemplate"][29] = "drawee_name";
		arrProductColumn["ECTemplate"][30] = "drawee_address_line_1";
		arrProductColumn["ECTemplate"][31] = "drawee_address_line_2";
		arrProductColumn["ECTemplate"][32] = "drawee_dom";
		arrProductColumn["ECTemplate"][33] = "drawee_reference";
		
		arrProductColumn["ECTemplate"][35] = "drawer_name";
		arrProductColumn["ECTemplate"][36] = "drawer_address_line_1";
		arrProductColumn["ECTemplate"][37] = "drawer_address_line_2";
		arrProductColumn["ECTemplate"][38] = "drawer_dom";
		arrProductColumn["ECTemplate"][39] = "drawer_reference";
		arrProductColumn["ECTemplate"][40] = "bol_number";
		arrProductColumn["ECTemplate"][41] = "shipping_mode";
		arrProductColumn["ECTemplate"][42] = "shipping_by";
		arrProductColumn["ECTemplate"][43] = "ship_from";
		arrProductColumn["ECTemplate"][44] = "ship_to";
		arrProductColumn["ECTemplate"][45] = "inco_term";
		arrProductColumn["ECTemplate"][120] = "inco_term_year";
		arrProductColumn["ECTemplate"][46] = "inco_place";
		arrProductColumn["ECTemplate"][47] = "term_code";
		arrProductColumn["ECTemplate"][48] = "docs_send_mode";
		arrProductColumn["ECTemplate"][50] = "accpt_adv_send_mode";
		arrProductColumn["ECTemplate"][51] = "protest_non_paymt";
		arrProductColumn["ECTemplate"][52] = "protest_non_accpt";
		arrProductColumn["ECTemplate"][53] = "protest_adv_send_mode";
		arrProductColumn["ECTemplate"][54] = "accpt_defd_flag";
		arrProductColumn["ECTemplate"][55] = "store_goods_flag";
		
		arrProductColumn["ECTemplate"][56] = "needs_refer_to";
		arrProductColumn["ECTemplate"][57] = "needs_instr_by_code";
		
		arrProductColumn["ECTemplate"][58] = "paymt_adv_send_mode";
		arrProductColumn["ECTemplate"][59] = "tenor_desc";
		arrProductColumn["ECTemplate"][60] = "tenor";
		arrProductColumn["ECTemplate"][61] = "tenor_unit";
		arrProductColumn["ECTemplate"][62] = "tenor_event";
		arrProductColumn["ECTemplate"][63] = "tenor_start_date";
		arrProductColumn["ECTemplate"][64] = "tenor_maturity_date";
		arrProductColumn["ECTemplate"][65] = "waive_chrg_flag";
		arrProductColumn["ECTemplate"][66] = "corr_chrg_brn_by_code";
		arrProductColumn["ECTemplate"][67] = "open_chrg_brn_by_code";
		arrProductColumn["ECTemplate"][68] = "int_rate";
		arrProductColumn["ECTemplate"][69] = "int_start_date";
		arrProductColumn["ECTemplate"][70] = "int_maturity_date";
		arrProductColumn["ECTemplate"][71] = "principal_act_no";
		arrProductColumn["ECTemplate"][72] = "fee_act_no";
		arrProductColumn["ECTemplate"][74] = "free_format_text";
		
		arrProductColumn["ECTemplate"][76] = "RemittingBank@abbv_name";
		arrProductColumn["ECTemplate"][77] = "RemittingBank@name";
		arrProductColumn["ECTemplate"][78] = "RemittingBank@address_line_1";
		arrProductColumn["ECTemplate"][79] = "RemittingBank@address_line_2";
		arrProductColumn["ECTemplate"][80] = "RemittingBank@dom";
		
		arrProductColumn["ECTemplate"][85] = "CollectingBank@name";
		arrProductColumn["ECTemplate"][86] = "CollectingBank@address_line_1";
		arrProductColumn["ECTemplate"][87] = "CollectingBank@address_line_2";
		arrProductColumn["ECTemplate"][88] = "CollectingBank@dom";
		
		arrProductColumn["ECTemplate"][90] = "PresentingBank@name";
		arrProductColumn["ECTemplate"][91] = "PresentingBank@address_line_1";
		arrProductColumn["ECTemplate"][92] = "PresentingBank@address_line_2";
		arrProductColumn["ECTemplate"][93] = "PresentingBank@dom";
		
		//arrProductColumn["ECTemplate"][105] = "Narrative@additionalInstructions";

		arrProductColumn["ECTemplate"][106] = "Document@code";
		arrProductColumn["ECTemplate"][107] = "Document@name";
		arrProductColumn["ECTemplate"][108] = "Document@first_mail";
		arrProductColumn["ECTemplate"][109] = "Document@second_mail";
		arrProductColumn["ECTemplate"][110] = "Document@total";
		arrProductColumn["ECTemplate"][111] = "Document@doc_no";
		arrProductColumn["ECTemplate"][112] = "Document@doc_date" ;
		arrProductColumn["ECTemplate"][113] = "tenor_base_date" ;
		arrProductColumn["ECTemplate"][114] = "tenor_type" ;
		arrProductColumn["ECTemplate"][115] = "tenor_days" ;
		arrProductColumn["ECTemplate"][116] = "tenor_period" ;
		arrProductColumn["ECTemplate"][117] = "tenor_from_after" ;
		arrProductColumn["ECTemplate"][118] = "tenor_days_type" ;
		arrProductColumn["ECTemplate"][119] = "tenor_type_details" ;

		// TODO: add the following entries at the right place, let in comment until field not added in screens
		//arrProductColumn["ECTemplate"][110] = "drawee_country";
		//arrProductColumn["ECTemplate"][111] = "drawer_country";