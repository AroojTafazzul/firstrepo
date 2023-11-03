/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.cash.opics.si_popup_management"]){dojo._hasResource["misys.binding.cash.opics.si_popup_management"]=true;dojo.provide("misys.binding.cash.opics.si_popup_management");(function(d,dj,m){_fncDoDisplay=function(_1,_2){if(_2&&_2!==""){dojo.query("#summary_"+_1+"_row div.content").forEach(function(_3){_3.innerHTML=_2;});if(dojo.byId("summary_"+_1+"_row")){dojo.style(dojo.byId("summary_"+_1+"_row"),"display","");}}else{dojo.query("#summary_"+_1+"_row div.content").forEach(function(_4){_4.innerHTML=null;});if(dojo.byId("summary_"+_1+"_row")){dojo.style(dojo.byId("summary_"+_1+"_row"),"display","none");}}if(dijit.byId(_1)){dijit.byId(_1).set("value",_2);}};_fncDoDisplayFieldNameForEmptyValue=function(_5,_6){if(_6&&_6!==""){dojo.query("#summary_"+_5+"_row div.content").forEach(function(_7){_7.innerHTML=_6;});if(dojo.byId("summary_"+_5+"_row")){dojo.style(dojo.byId("summary_"+_5+"_row"),"display","");}}else{dojo.query("#summary_"+_5+"_row div.content").forEach(function(_8){_8.innerHTML="";});}if(dijit.byId(_5)){dijit.byId(_5).set("value",_6);}};_fncBlankSummaryStyle=function(_9){if(dojo.byId("summary_"+_9+"_row")){dojo.style(dojo.byId("summary_"+_9+"_row"),"display","none");}};d.mixin(m,{showSiDialog:function(_a,_b){var _c=_a.status;dijit.byId(_b+"siDialog").show();_fncDoDisplay(_b+"si_currency",_a.currency);_fncDoDisplay(_b+"si_instruction_indicator",_a.instruction_indicator);_fncDoDisplay(_b+"si_beneficiary_institution",_a.beneficiary_institution);_fncDoDisplay(_b+"si_beneficiary_account",_a.beneficiary_account);_fncDoDisplay(_b+"si_beneficiary_account_bic",_a.beneficiary_bank_bic);_fncDoDisplay(_b+"si_account_with_institution",_a.account_with_institution);_fncDoDisplay(_b+"si_account_with_institution_BIC",_a.account_with_institution_BIC);_fncDoDisplay(_b+"si_settlement_means",_a.settlementMeans);_fncDoDisplay(_b+"si_settlement_account",_a.account);if(_a.additionalBankInstructions){_fncDoDisplay(_b+"si_intermediary_bank",_a.additionalBankInstructions[0].intermediary_bank);_fncDoDisplay(_b+"si_intermediary_bank_bic",_a.additionalBankInstructions[0].intermediary_bic);if((_a.additionalBankInstructions[0].intermediary_address&&_a.additionalBankInstructions[0].intermediary_address!=="")||(_a.additionalBankInstructions[0].intermediary_city&&_a.additionalBankInstructions[0].intermediary_city!=="")||(_a.additionalBankInstructions[0].intermediary_country_code&&_a.additionalBankInstructions[0].intermediary_country_code!=="")){_fncDoDisplayFieldNameForEmptyValue(_b+"si_intermediary_bank_street",_a.additionalBankInstructions[0].intermediary_address);_fncDoDisplay(_b+"si_intermediary_bank_city",_a.additionalBankInstructions[0].intermediary_city);_fncDoDisplay(_b+"si_intermediary_bank_country",_a.additionalBankInstructions[0].intermediary_country_code);}else{_fncBlankSummaryStyle(_b+"si_intermediary_bank_street");_fncBlankSummaryStyle(_b+"si_intermediary_bank_city");_fncBlankSummaryStyle(_b+"si_intermediary_bank_country");}_fncDoDisplay(_b+"si_intermediary_bank_account_number",_a.additionalBankInstructions[0].intermediary_bank_account_number);var _d=_a.additionalBankInstructions[0].intermediary_bank_account_number;if(_d&&_d[0]){if(_d[0].substring(0,1)==="/"){_fncDoDisplay(_b+"si_intermediary_bank_aba",_d[0].substring(1));}else{_fncDoDisplay(_b+"si_intermediary_bank_aba",_a.additionalBankInstructions[0].intermediary_bank_account_number);}}_fncDoDisplay(_b+"si_intermediary_bank_instruction_1",_a.additionalBankInstructions[0].routing_instructions_1);_fncDoDisplay(_b+"si_intermediary_bank_instruction_2",_a.additionalBankInstructions[0].routing_instructions_2);_fncDoDisplay(_b+"si_intermediary_bank_instruction_3",_a.additionalBankInstructions[0].routing_instructions_3);_fncDoDisplay(_b+"si_intermediary_bank_instruction_4",_a.additionalBankInstructions[0].routing_instructions_4);_fncDoDisplay(_b+"si_intermediary_bank_instruction_5",_a.additionalBankInstructions[0].routing_instructions_5);_fncDoDisplay(_b+"si_intermediary_bank_instruction_6",_a.additionalBankInstructions[0].routing_instructions_6);_fncDoDisplay(_b+"si_additional_detail_1",_a.additionalBankInstructions[0].payment_details_1);_fncDoDisplay(_b+"si_additional_detail_2",_a.additionalBankInstructions[0].payment_details_2);_fncDoDisplay(_b+"si_additional_detail_3",_a.additionalBankInstructions[0].payment_details_3);_fncDoDisplay(_b+"si_additional_detail_4",_a.additionalBankInstructions[0].payment_details_4);if((_a.additionalBankInstructions[0].swift_charges_type&&_a.additionalBankInstructions[0].swift_charges_type!=="")||(_a.additionalBankInstructions[0].ordering_cust_name&&_a.additionalBankInstructions[0].ordering_cust_name!=="")||(_a.additionalBankInstructions[0].ordering_cust_address&&_a.additionalBankInstructions[0].ordering_cust_address!=="")||(_a.additionalBankInstructions[0].ordering_cust_citystate&&_a.additionalBankInstructions[0].ordering_cust_citystate!=="")||(_a.additionalBankInstructions[0].ordering_cust_country&&_a.additionalBankInstructions[0].ordering_cust_country!=="")||(_a.additionalBankInstructions[0].ordering_cust_account&&_a.additionalBankInstructions[0].ordering_cust_account!=="")||(_a.settlementMeans&&_a.settlementMeans!=="")||(_a.account&&_a.account!=="")){if(d.byId("paymentBeneficiaryPopup")){d.style(d.byId("paymentBeneficiaryPopup"),"display","block");}}else{if(d.byId("paymentBeneficiaryPopup")){d.style(d.byId("paymentBeneficiaryPopup"),"display","none");}}if((_a.additionalBankInstructions[0].intermediary_bic&&_a.additionalBankInstructions[0].intermediary_bic!=="")||(_a.additionalBankInstructions[0].intermediary_address&&_a.additionalBankInstructions[0].intermediary_address!=="")||(_a.additionalBankInstructions[0].intermediary_city&&_a.additionalBankInstructions[0].intermediary_city!=="")||(_a.additionalBankInstructions[0].intermediary_country_code&&_a.additionalBankInstructions[0].intermediary_country_code!=="")||(_a.additionalBankInstructions[0].intermediary_bank_account_number&&_a.additionalBankInstructions[0].intermediary_bank_account_number!=="")||(_a.additionalBankInstructions[0].routing_instructions_1&&_a.additionalBankInstructions[0].routing_instructions_1!=="")||(_a.additionalBankInstructions[0].routing_instructions_2&&_a.additionalBankInstructions[0].routing_instructions_2!=="")||(_a.additionalBankInstructions[0].routing_instructions_3&&_a.additionalBankInstructions[0].routing_instructions_3!=="")||(_a.additionalBankInstructions[0].routing_instructions_4&&_a.additionalBankInstructions[0].routing_instructions_4!=="")||(_a.additionalBankInstructions[0].routing_instructions_5&&_a.additionalBankInstructions[0].routing_instructions_5!=="")){d.style(d.byId("additionalDetailsPopup"),"display","block");}else{d.style(d.byId("additionalDetailsPopup"),"display","none");}if((_a.additionalBankInstructions[0].payment_details_1&&_a.additionalBankInstructions[0].payment_details_1!=="")||(_a.additionalBankInstructions[0].payment_details_2&&_a.additionalBankInstructions[0].payment_details_2!=="")||(_a.additionalBankInstructions[0].payment_details_3&&_a.additionalBankInstructions[0].payment_details_3!=="")||(_a.additionalBankInstructions[0].payment_details_4&&_a.additionalBankInstructions[0].payment_details_4!=="")){d.style(d.byId("paymentDetailsPopup"),"display","block");}else{d.style(d.byId("paymentDetailsPopup"),"display","none");}if(_a.additionalBankInstructions[0].swift_charges_type==="OUR"){_fncDoDisplay(_b+"si_swift_charges_type",dijit.byId("summary_"+_b+"si_swift_charges_type_01").get("value"));}else{if(_a.additionalBankInstructions[0].swift_charges_type==="BEN"){_fncDoDisplay(_b+"si_swift_charges_type",dijit.byId("summary_"+_b+"si_swift_charges_type_02").get("value"));}else{if(_a.additionalBankInstructions[0].swift_charges_type==="SHA"){_fncDoDisplay(_b+"si_swift_charges_type",dijit.byId("summary_"+_b+"si_swift_charges_type_05").get("value"));}else{_fncDoDisplay(_b+"si_swift_charges_type",_a.additionalBankInstructions[0].swift_charges_type);}}}_fncDoDisplay(_b+"si_ordering_cust_name",_a.additionalBankInstructions[0].ordering_cust_name);if((_a.additionalBankInstructions[0].ordering_cust_address&&_a.additionalBankInstructions[0].ordering_cust_address!=="")||(_a.additionalBankInstructions[0].ordering_cust_citystate&&_a.additionalBankInstructions[0].ordering_cust_citystate!=="")||(_a.additionalBankInstructions[0].ordering_cust_country&&_a.additionalBankInstructions[0].ordering_cust_country!=="")){_fncDoDisplayFieldNameForEmptyValue(_b+"si_ordering_cust_address",_a.additionalBankInstructions[0].ordering_cust_address);_fncDoDisplay(_b+"si_ordering_cust_citystate",_a.additionalBankInstructions[0].ordering_cust_citystate);_fncDoDisplay(_b+"si_ordering_cust_country",_a.additionalBankInstructions[0].ordering_cust_country);}else{_fncBlankSummaryStyle(_b+"si_ordering_cust_address");_fncBlankSummaryStyle(_b+"si_ordering_cust_citystate");_fncBlankSummaryStyle(_b+"si_ordering_cust_country");}_fncDoDisplay(_b+"si_ordering_cust_account",_a.additionalBankInstructions[0].ordering_cust_account);}else{_fncDoDisplay(_b+"si_intermediary_bank",null);_fncDoDisplay(_b+"si_intermediary_bank_bic",null);_fncDoDisplay(_b+"si_intermediary_bank_street",null);_fncDoDisplay(_b+"si_intermediary_bank_city",null);_fncDoDisplay(_b+"si_intermediary_bank_country",null);_fncDoDisplay(_b+"si_intermediary_bank_account_number",null);_fncDoDisplay("si_intermediary_bank_aba",null);_fncDoDisplay(_b+"si_intermediary_bank_instruction_1",null);_fncDoDisplay(_b+"si_intermediary_bank_instruction_2",null);_fncDoDisplay(_b+"si_intermediary_bank_instruction_3",null);_fncDoDisplay(_b+"si_intermediary_bank_instruction_4",null);_fncDoDisplay(_b+"si_intermediary_bank_instruction_5",null);_fncDoDisplay(_b+"si_intermediary_bank_instruction_6",null);_fncDoDisplay(_b+"si_additional_detail_1",null);_fncDoDisplay(_b+"si_additional_detail_2",null);_fncDoDisplay(_b+"si_additional_detail_3",null);_fncDoDisplay(_b+"si_additional_detail_4",null);_fncDoDisplay(_b+"si_swift_charges_type",null);_fncDoDisplay(_b+"si_ordering_cust_name",null);_fncDoDisplay(_b+"si_ordering_cust_address",null);_fncDoDisplay(_b+"si_ordering_cust_citystate",null);_fncDoDisplay(_b+"si_ordering_cust_country",null);_fncDoDisplay(_b+"si_ordering_cust_account",null);}},closeSiDialog:function(_e){if(_e!=null&&_e!=""){_e=_e+"_";}else{_e="";}dijit.byId(_e+"siDialog").hide();}});})(dojo,dijit,misys);}