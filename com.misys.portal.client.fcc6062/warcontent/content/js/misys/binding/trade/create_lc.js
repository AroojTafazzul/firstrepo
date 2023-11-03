/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.trade.create_lc"]){dojo._hasResource["misys.binding.trade.create_lc"]=true;dojo.provide("misys.binding.trade.create_lc");dojo.require("dijit.layout.TabContainer");dojo.require("dijit.form.DateTextBox");dojo.require("misys.form.CurrencyTextBox");dojo.require("dijit.form.NumberTextBox");dojo.require("dijit.form.FilteringSelect");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("misys.widget.Dialog");dojo.require("dijit.ProgressBar");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("misys.form.SimpleTextarea");dojo.require("misys.widget.Collaboration");dojo.require("misys.form.common");dojo.require("misys.form.file");dojo.require("misys.validation.common");dojo.require("misys.binding.SessionTimer");dojo.require("misys.binding.trade.ls_common");dojo.require("misys.binding.trade.create_lc_swift");dojo.require("misys.purchaseorder.widget.PurchaseOrder");dojo.require("misys.purchaseorder.widget.PurchaseOrders");dojo.require("misys.purchaseorder.FormPurchaseOrderEvents");(function(d,dj,m){var _1="NOT ALLOWED";var _2="ALLOWED";var _3="revolving-details";var _4="alternate-party-details";function _5(){if((dj.byId("adv_send_mode")&&dj.byId("adv_send_mode").get("value")==="01")&&(dj.byId("inco_term")&&dj.byId("inco_term").get("value")!="")){var _6=98;if(m._config.swiftExtendedNarrativeEnabled){_6=798;}if(dj.byId("narrative_description_goods")&&dj.byId("narrative_description_goods").get("value")!==""&&dijit.byId("narrative_description_goods").rowCount>_6){misys.dialog.show("ERROR",misys.getLocalization("descOfGoodsExceedMaxWhenIncoTermSelected"),"",function(){dj.byId("narrative_description_goods").focus();dj.byId("narrative_description_goods").set("state","Error");});return false;}else{return true;}}return true;};var _7="deletegridrecord";var _8=true;m._config=m._config||{};m._config.lcCurCode=m._config.lcCurCode||{};m._config.applicant=m._config.applicant||{entity:"",name:"",addressLine1:"",addressLine2:"",dom:""};m._config.beneficiary=m._config.beneficiary||{name:"",addressLine1:"",addressLine2:"",dom:""};m._config.expDate=m._config.expDate||{};m._config.lastShipDate=m._config.lastShipDate||{};function _9(){dj.byId("principal_act_no").set("value","");dj.byId("fee_act_no").set("value","");};d.mixin(m._config,{initReAuthParams:function(){var _a={productCode:"LC",subProductCode:"",transactionTypeCode:"01",entity:dj.byId("entity")?dj.byId("entity").get("value"):"",currency:dj.byId("lc_cur_code")?dj.byId("lc_cur_code").get("value"):"",amount:dj.byId("lc_amt")?m.trimAmount(dj.byId("lc_amt").get("value")):"",bankAbbvName:dj.byId("issuing_bank_abbv_name")?dj.byId("issuing_bank_abbv_name").get("value"):"",es_field1:"",es_field2:""};return _a;},xmlTransform:function(_b){var _c="<lc_tnx_record>";if(_b.indexOf(_c)!=-1){var _d=m._config.xmlTagName,_e=_d?["<",_d,">"]:[],_f="</lc_tnx_record>",_10="",_11=-1;_10=_b.substring(_c.length,(_b.length-_f.length));if(m._config.swift2018Enabled){var i=0,_12,_13,_14;var _15=["narrative_description_goods","narrative_documents_required","narrative_additional_instructions","narrative_special_beneficiary"];for(var itr=0;itr<4;itr++){_14=itr==0?_10.substring(0,_10.indexOf("<"+_15[itr]+">")):_14.substring(0,_14.indexOf("<"+_15[itr]+">"));_14=_14.concat("<"+_15[itr]+">");if(dj.byId(_15[itr])){_14=_14.concat("<![CDATA[");_14=_14.concat("<issuance>");_14=_14.concat("<sequence>");_14=_14.concat("0");_14=_14.concat("</sequence>");_14=_14.concat("<data>");_14=_14.concat("<datum>");_14=_14.concat("<id>");_14=_14.concat("0");_14=_14.concat("</id>");_14=_14.concat("<verb>");_14=_14.concat("ISSUANCE");_14=_14.concat("</verb>");_14=_14.concat("<text>");_14=_14.concat("]]><![CDATA["+dojo.trim(dj.byId(_15[itr]).get("value")));_14=_14.concat("</text>");_14=_14.concat("</datum>");_14=_14.concat("</data>");_14=_14.concat("</issuance>");_14=_14.concat("]]>");}_14=_14.concat(_10.substring(_10.indexOf("</"+_15[itr]+">"),_10.length));}_e.push(_14);}else{_e.push(_10);}if(dj.byId("gridLicense")&&dj.byId("gridLicense").store&&dj.byId("gridLicense").store!==null&&dj.byId("gridLicense").store._arrayOfAllItems.length>0){_e.push("<linked_licenses>");dj.byId("gridLicense").store.fetch({query:{REFERENCEID:"*"},onComplete:dojo.hitch(dj.byId("gridLicense"),function(_16,_17){dojo.forEach(_16,function(_18){_e.push("<license>");_e.push("<ls_ref_id>",_18.REFERENCEID,"</ls_ref_id>");_e.push("<bo_ref_id>",_18.BO_REF_ID,"</bo_ref_id>");_e.push("<ls_number>",_18.LS_NUMBER,"</ls_number>");_e.push("<ls_allocated_amt>",_18.LS_ALLOCATED_AMT,"</ls_allocated_amt>");_e.push("<ls_amt>",_18.LS_AMT,"</ls_amt>");_e.push("<ls_os_amt>",_18.LS_OS_AMT,"</ls_os_amt>");_e.push("<converted_os_amt>",_18.CONVERTED_OS_AMT,"</converted_os_amt>");_e.push("<allow_overdraw>",_18.ALLOW_OVERDRAW,"</allow_overdraw>");_e.push("</license>");});})});_e.push("</linked_licenses>");}if(_d){_e.push("</",_d,">");}return _e.join("");}else{return _b;}}});d.mixin(m,{bind:function(){m.setValidation("template_id",m.validateTemplateId);m.setValidation("tenor_maturity_date",m.validateMaturityDate);m.setValidation("exp_date",m.validateTradeExpiryDate);m.setValidation("pstv_tol_pct",m.validateTolerance);m.setValidation("neg_tol_pct",m.validateTolerance);m.setValidation("max_cr_desc_code",m.validateMaxCreditTerm);m.setValidation("last_ship_date",m.validateLastShipmentDate);m.setValidation("lc_cur_code",m.validateCurrency);m.setValidation("beneficiary_country",m.validateCountry);m.setValidation("alt_applicant_country",m.validateCountry);m.setValidation("lc_cur_code",m.validateCurrency);m.setValidation("fake_total_cur_code",m.validateCurrency);m.setValidation("total_net_cur_code",m.validateCurrency);m.setValidation("line_item_price_cur_code",m.validateCurrency);m.setValidation("line_item_total_net_cur_code",m.validateCurrency);m.connect("irv_flag","onClick",m.checkIrrevocableFlag);m.connect("ntrf_flag","onClick",m.checkNonTransferableFlag);m.connect("stnd_by_lc_flag","onClick",m.checkStandByFlag);if(m._config.charge_splitting_lc){if(dj.byId("open_chrg_brn_by_code_3")){dj.byId("open_chrg_brn_by_code_3").set("disabled",false);dj.byId("corr_chrg_brn_by_code_3").set("disabled",false);m.connect("open_chrg_brn_by_code_1","onClick",m.checkApplBeneCharges);m.connect("open_chrg_brn_by_code_2","onClick",m.checkApplBeneCharges);m.connect("open_chrg_brn_by_code_3","onClick",m.checkApplBeneCharges);m.connect("corr_chrg_brn_by_code_1","onClick",m.checkApplBeneCharges);m.connect("corr_chrg_brn_by_code_2","onClick",m.checkApplBeneCharges);m.connect("corr_chrg_brn_by_code_3","onClick",m.checkApplBeneCharges);if(dj.byId("open_chrg_brn_by_code_3").get("checked")){dj.byId("open_chrg_applicant").set("disabled",false).set("required",true);dj.byId("open_chrg_beneficiary").set("disabled",false).set("required",true);}if(dj.byId("corr_chrg_brn_by_code_3").get("checked")){dj.byId("corr_chrg_applicant").set("disabled",false).set("required",true);dj.byId("corr_chrg_beneficiary").set("disabled",false).set("required",true);}}if(dj.byId("cfm_chrg_brn_by_code_3")){dj.byId("cfm_chrg_brn_by_code_3").set("disabled",false);m.connect("cfm_chrg_brn_by_code_3","onClick",m.checkConfirmationCharges);if(dj.byId("cfm_chrg_brn_by_code_3").get("checked")){dj.byId("cfm_chrg_applicant").set("disabled",false).set("required",true);dj.byId("cfm_chrg_beneficiary").set("disabled",false).set("required",true);}}}m.connect("cfm_chrg_brn_by_code_1","onClick",m.checkConfirmationCharges);m.connect("cfm_chrg_brn_by_code_2","onClick",m.checkConfirmationCharges);m.connect("cr_avl_by_code_1","onClick",m.togglePaymentDraftAt);m.connect("cr_avl_by_code_1","onClick",m.setDraftTerm);m.connect("cr_avl_by_code_2","onClick",m.togglePaymentDraftAt);m.connect("cr_avl_by_code_3","onClick",m.togglePaymentDraftAt);m.connect("cr_avl_by_code_4","onClick",m.togglePaymentDraftAt);m.connect("cr_avl_by_code_5","onClick",m.togglePaymentDraftAt);m.connect("cr_avl_by_code_5","onChange",function(){dj.byId("draft_term").set("value","");});m.connect("cr_avl_by_code_2","onClick",m.setDraftTerm);m.connect("cr_avl_by_code_2","onClick",m.setDraweeDetailBankName);m.connect("cr_avl_by_code_3","onClick",m.setDraftTerm);m.connect("cr_avl_by_code_3","onClick",m.setDraweeDetailBankName);m.connect("cr_avl_by_code_4","onClick",m.setDraftTerm);m.connect("adv_send_mode","onClick",m.setDraftTerm);m.connect("tenor_type_1","onClick",m.toggleDraftTerm);m.connect("tenor_type_1","onClick",m.setDraftTerm);m.connect("tenor_type_2","onClick",m.toggleDraftTerm);m.connect("tenor_type_3","onClick",m.toggleDraftTerm);m.connect("pstv_tol_pct","onChange",function(){if(dj.byId("booking_amt")){m.validateLimitBookingAmount("true");}});m.connect("lc_amt","onBlur",function(){m.setTnxAmt(this.get("value"));m.validateLimitBookingAmount("true");});m.connect("last_ship_date","onChange",function(){m.toggleDependentFields(this,dj.byId("narrative_shipment_period"),m.getLocalization("shipmentDateOrPeriodExclusivityError"));});m.connect("last_ship_date","onClick",function(){m.toggleDependentFields(this,dj.byId("narrative_shipment_period"),m.getLocalization("shipmentDateOrPeriodExclusivityError"));});m.connect("tenor_maturity_date","onBlur",m.setDraftTerm);m.connect("tenor_days_type","onBlur",m.setDraftTerm);m.connect("tenor_type_details","onBlur",m.setDraftTerm);m.connect("lc_cur_code","onChange",function(){m.setCurrency(this,["lc_amt"]);});m.connect("credit_available_with_bank_type","onChange",m.setCreditAvailBy);m.connect("tenor_period","onChange",m.setDraftTerm);m.connect("tenor_from_after","onChange",m.setDraftTerm);m.connect("tenor_days","onChange",m.setDraftTerm);m.connect("tenor_days_type","onChange",function(){m.toggleFields((this.get("value")=="99"),null,["tenor_type_details"]);});m.connect("drawee_details_bank_name","onChange",m.initDraweeFields);m.connect("issuing_bank_abbv_name","onChange",m.populateReferences);m.connect("issuing_bank_abbv_name","onChange",m.updateBusinessDate);if(dj.byId("issuing_bank_abbv_name")){m.connect("entity","onChange",function(){dj.byId("issuing_bank_abbv_name").onChange();if(dj.byId("issuing_bank_customer_reference")){m.populateFacilityReference(dj.byId("issuing_bank_customer_reference"));}});}m.connect("adv_send_mode","onChange",function(){m.toggleMT798Fields("issuing_bank_abbv_name");});m.connect("issuing_bank_abbv_name","onChange",function(){m.toggleMT798Fields("issuing_bank_abbv_name");});m.connect("issuing_bank_abbv_name","onChange",function(){if(dj.byId("issuing_bank_abbv_name").get("value")!=""){m.getIncoYear();}});m.connect("inco_term_year","onChange",m.getIncoTerm);m.connect("inco_term_year","onClick",function(){if(dj.byId("issuing_bank_abbv_name").get("value")==""&&(this.store._arrayOfAllItems==undefined||this.store._arrayOfAllItems.length==0)){m.dialog.show("ERROR",m.getLocalization("selectBankToProceed"),"","");}});m.connect("inco_term","onClick",function(){if(dj.byId("issuing_bank_abbv_name").get("value")==""&&(this.store._arrayOfAllItems==undefined||this.store._arrayOfAllItems.length==0)){m.dialog.show("ERROR",m.getLocalization("selectBankToProceed"),"","");}else{if(dj.byId("inco_term_year").get("value")==""&&(this.store._arrayOfAllItems==undefined||this.store._arrayOfAllItems.length==0)){m.dialog.show("ERROR",m.getLocalization("selectIncoYearToProceed"),"","");}}});m.connect("issuing_bank_customer_reference","onChange",m.setApplicantReference);m.connect("issuing_bank_customer_reference","onChange",function(){if(dj.byId("issuing_bank_customer_reference")){m.populateFacilityReference(dj.byId("issuing_bank_customer_reference"));}});m.connect("part_ship_detl_nosend","onChange",function(){var _19=dj.byId("part_ship_detl_nosend").value;dj.byId("part_ship_detl").set("value",_19);if(m._config.swift2018Enabled){if(_19==="CONDITIONAL"){d.byId("infoMessagePartialShipment").style.display="block";d.byId("infoMessagePartialShipment").style.paddingLeft="250px";}else{d.byId("infoMessagePartialShipment").style.display="none";}}m.toggleFields(_19&&_19!==_2&&_19!==_1&&_19!=="NONE",null,["part_ship_detl_text_nosend"]);});m.connect("part_ship_detl_text_nosend","onBlur",function(){var _1a=dj.byId("part_ship_detl_nosend").value;if(_1a==="OTHER"){dj.byId("part_ship_detl").set("value",dj.byId("part_ship_detl_text_nosend").value);}else{dj.byId("part_ship_detl").set("value",dj.byId("part_ship_detl_nosend").value);}});m.connect("tran_ship_detl_nosend","onChange",function(){var _1b=dj.byId("tran_ship_detl_nosend").value;dj.byId("tran_ship_detl").set("value",_1b);if(m._config.swift2018Enabled){if(_1b==="CONDITIONAL"){d.byId("infoMessageTranshipment").style.display="block";d.byId("infoMessageTranshipment").style.paddingLeft="250px";}else{d.byId("infoMessageTranshipment").style.display="none";}}m.toggleFields(_1b&&_1b!==_2&&_1b!==_1&&_1b!=="NONE",null,["tran_ship_detl_text_nosend"]);});m.connect("tran_ship_detl_text_nosend","onBlur",function(){if(dj.byId("tran_ship_detl_nosend").value==="OTHER"||dj.byId("tran_ship_detl_nosend").value==="Other"){dj.byId("tran_ship_detl").set("value",dj.byId("tran_ship_detl_text_nosend").value);}else{dj.byId("tran_ship_detl").set("value",dj.byId("tran_ship_detl_nosend").value);}});m.connect("tenor_days","onFocus",m.setDraftDaysReadOnly);m.connect("tenor_period","onFocus",m.setDraftDaysReadOnly);m.connect("tenor_from_after","onFocus",m.setDraftDaysReadOnly);m.connect("tenor_days_type","onFocus",m.setDraftDaysReadOnly);m.connect("draft_term","onFocus",function(){this.set("readOnly",!dj.byId("cr_avl_by_code_5").get("checked"));});m.connect("narrative_description_goods","onBlur",function(){_5();});m.connect("narrative_shipment_period","onChange",function(){m.toggleDependentFields(this,dj.byId("last_ship_date"),m.getLocalization("shipmentDateOrPeriodExclusivityError"));});m.connect("narrative_shipment_period","onClick",function(){m.toggleDependentFields(this,dj.byId("last_ship_date"),m.getLocalization("shipmentDateOrPeriodExclusivityError"));});m.connect("eucp_flag","onClick",function(){m.toggleFields(this.get("checked"),null,["eucp_details"]);});m.connect("inco_term","onChange",function(){m.toggleFields(this.get("value"),null,["inco_place"],false,false);});m.connect("inco_term_year","onChange",function(){m.toggleFields(this.get("value"),null,["inco_term"],false,true);});m.connect("adv_send_mode","onChange",function(){if(dj.byId("adv_send_mode")&&dj.byId("adv_send_mode").get("value")==="01"){_5();}});m.connect("transport_mode_nosend","onChange",function(){var _1c=this.get("value");dj.byId("transport_mode").set("value",_1c);m.toggleFields(_1c&&_1c!=="AIRT"&&_1c!=="SEAT"&&_1c!=="RAIL"&&_1c!=="ROAD"&&_1c!=="MULT",null,["transport_mode_text_nosend"],false,false);});m.connect("transport_mode_text_nosend","onBlur",function(){dj.byId("transport_mode").set("value",this.get("value"));});m.connect("entity_img_label","onClick",_9);m.connect("license_lookup","onClick",function(){m.getLicenses("lc");});m.connect("lc_cur_code","onChange",function(){m.clearLicenseGrid(this,m._config.lcCurCode,"lc");});m.connect("entity","onChange",function(){m.clearLicenseGrid(this,m._config.applicant,"lc");});m.connect("beneficiary_name","onChange",function(){m.clearLicenseGrid(this,m._config.beneficiary,"lc");});m.connect("exp_date","onChange",function(){m.clearLicenseGrid(this,m._config.expDate,"lc");});m.connect("last_ship_date","onChange",function(){m.clearLicenseGrid(this,m._config.lastShipDate,"lc");});m.connect("revolving_flag","onChange",function(){if(this.get("checked")){m.animate("fadeIn",d.byId(_3));}else{m.animate("fadeOut",d.byId(_3));dj.byId("revolve_period").set("value","");dj.byId("revolve_frequency").set("value","");dj.byId("revolve_time_no").set("value","");dj.byId("cumulative_flag").set("checked",false);dj.byId("notice_days").set("value","");}});m.connect("revolving_flag","onChange",function(){m.toggleFields((this.get("value")==="on"),null,["revolve_period","revolve_frequency"]);});m.connect("for_account_flag","onChange",function(){if(this.get("checked")){m.animate("fadeIn",d.byId(_4));}else{m.animate("fadeOut",d.byId(_4));dj.byId("alt_applicant_name").set("value","");dj.byId("alt_applicant_address_line_1").set("value","");dj.byId("alt_applicant_address_line_2").set("value","");dj.byId("alt_applicant_dom").set("value","");dj.byId("alt_applicant_country").set("value","");}});m.connect("for_account_flag","onChange",function(){m.toggleFields((this.get("value")==="on"),["alt_applicant_address_line_2","alt_applicant_dom"],["alt_applicant_name","alt_applicant_address_line_1","alt_applicant_country"]);});m.connect("revolve_period","onBlur",function(){m.validateIntegerValue(dj.byId("revolve_period"));});m.connect("revolve_time_no","onBlur",function(){m.validateIntegerValue(dj.byId("revolve_time_no"));});m.connect("notice_days","onBlur",function(){m.validateIntegerValue(dj.byId("notice_days"));});if(m._config.swift2018Enabled){m._bindSwift2018();}else{m.connect("cfm_inst_code_1","onClick",m.resetConfirmationCharges);m.connect("cfm_inst_code_2","onClick",m.resetConfirmationCharges);m.connect("cfm_inst_code_3","onClick",m.resetConfirmationCharges);}m.connect("applicable_rules","onChange",function(){m.toggleFields((this.get("value")=="99"),null,["applicable_rules_text"]);});m.connect("adv_send_mode","onChange",function(){m.toggleFields((this.get("value")=="99"),null,["adv_send_mode_text"]);});m.connect("facility_id","onChange",m.getLimitDetails);m.connect("beneficiary_country","onChange",function(){if(dj.byId("issuing_bank_customer_reference")){m.populateFacilityReference(dj.byId("issuing_bank_customer_reference"));}});m.connect("facility_id","onChange",function(){if(this&&this.get("value")+"S"!=="S"){m.toggleFields(true,null,["limit_id","booking_amt","booking_cur_code"],true,true);}else{m.toggleFields(false,null,["limit_id","booking_amt","booking_cur_code"],true,true);}});m.connect("limit_id","onChange",m.setLimitFieldsValue);m.setValidation("booking_cur_code",m.validateCurrency);m.connect("facility_id","onChange",m.validateLimitBookingAmount);m.connect("limit_id","onChange",m.validateLimitBookingAmount);m.connect("lc_amt","onChange",m.validateLimitBookingAmount);m.connect("lc_cur_code","onChange",m.validateLimitBookingAmount);m.connect("booking_amt","onBlur",m.validateLimitBookingAmount);m.connect("po_activated","onChange",m.toggleDisableButtons);m.connect("lc_cur_code","onBlur",m.checkLineItemsCurrencyTotalCurrency);m.connect("lc_cur_code","onChange",m.managePOCurrency);m.connect("lc_cur_code","onFocus",m.saveOldPOCurrency);m.connect("line_item_qty_val","onBlur",m.computeLineItemAmount);m.connect("line_item_price_amt","onBlur",m.computeLineItemAmount);m.connect(dj.byId("line_item_qty_unit_measr_code"),"onChange",function(){dj.byId("line_item_price_unit_measr_code").set("value",this.get("value"));});m.connect("line_item_qty_unit_measr_code","onChange",function(){if(dojo.byId("line_item_qty_unit_measr_other_row")){if(this.get("value")==="OTHR"){m.animate("fadeIn","line_item_qty_unit_measr_other_row");dj.byId("line_item_qty_unit_measr_other").set("readOnly",false);m.toggleRequired("line_item_qty_unit_measr_other",true);}else{m.animate("fadeOut","line_item_qty_unit_measr_other_row");dj.byId("line_item_qty_unit_measr_other").set("readOnly",true);dj.byId("line_item_qty_unit_measr_other").set("value","");m.toggleRequired("line_item_qty_unit_measr_other",false);}}});m.connect("fake_total_cur_code","onChange",function(){m.setCurrency(this,["fake_total_amt"]);});m.connect("fake_total_amt","onChange",function(){m.setTnxAmt(this.get("value"));});m.connect("total_net_cur_code","onChange",function(){m.setCurrency(this,["total_net_amt"]);});m.connect("line_item_price_cur_code","onChange",function(){m.setCurrency(this,["line_item_price_amt"]);});m.connect("line_item_total_cur_code","onChange",function(){m.setCurrency(this,["line_item_total_amt"]);});m.connect("line_item_total_net_cur_code","onChange",function(){m.setCurrency(this,["line_item_total_net_amt"]);});m.connect("lc_cur_code","onChange",function(){m.setCurrency(this,["lc_amt"]);});m.connect("lc_amt","onChange",function(){m.setTnxAmt(this.get("value"));});m.connect(dijit.byId("dialogPOSubmit"),"onClick",function(){var _1d=dj.byId("line_item_total_cur_code").get("value");var _1e=dj.byId("line_item_qty_val").get("value");var _1f=dj.byId("line_item_qty_unit_measr_code").get("displayedValue");var _20=dj.byId("line_item_price_unit_measr_code").get("displayedValue");var _21=dj.byId("line_item_price_amt").get("value");var _22=dj.byId("line_item_product_name").get("value");var _23="";var _24="";if(dj.byId("line_item_qty_tol_pstv_pct")&&dj.byId("line_item_qty_tol_pstv_pct").get("value")!=null&&!isNaN(dj.byId("line_item_qty_tol_pstv_pct").get("value"))){_23="(Tolerance: +"+dj.byId("line_item_qty_tol_pstv_pct").get("value")+")";}if(dj.byId("line_item_qty_tol_neg_pct")&&dj.byId("line_item_qty_tol_neg_pct").get("value")!=null&&!isNaN(dj.byId("line_item_qty_tol_neg_pct").get("value"))){_24="(Tolerance: -"+dj.byId("line_item_qty_tol_neg_pct").get("value")+")";}if(_1e&&_1f&&_20&&_21&&_22){var _25="";_25=dj.byId("narrative_description_goods").get("value");var _26=_25+"\n\r+"+_1e+" "+_1f+" of "+_22+"\n\r+"+_23+_24+" at "+_21+" "+_1d+" per "+_20;dj.byId("narrative_description_goods").set("value",_26);}});m.connect(dj.byId("line_item_qty_unit_measr_code"),"onChange",function(){dj.byId("line_item_qty_unit_measr_label").set("value",this.get("displayedValue"));});m.connect("applicant_address_line_4","onFocus",function(){m.showTooltip(m.getLocalization("addressLine4ToolTip",[dj.byId("applicant_address_line_4").get("displayedValue"),dj.byId("applicant_address_line_4").get("value")]),d.byId("applicant_address_line_4"),["right"],5000);});m.connect("alt_applicant_address_line_4","onFocus",function(){m.showTooltip(m.getLocalization("addressLine4ToolTip",[dj.byId("alt_applicant_address_line_4").get("displayedValue"),dj.byId("alt_applicant_address_line_4").get("value")]),d.byId("alt_applicant_address_line_4"),["right"],5000);});m.connect("beneficiary_address_line_4","onFocus",function(){m.showTooltip(m.getLocalization("addressLine4ToolTip",[dj.byId("beneficiary_address_line_4").get("displayedValue"),dj.byId("beneficiary_address_line_4").get("value")]),d.byId("beneficiary_address_line_4"),["right"],5000);});m.connect("credit_available_with_bank_address_line_4","onFocus",function(){m.showTooltip(m.getLocalization("addressLine4ToolTip",[dj.byId("credit_available_with_bank_address_line_4").get("displayedValue"),dj.byId("credit_available_with_bank_address_line_4").get("value")]),d.byId("credit_available_with_bank_address_line_4"),["right"],5000);});m.connect("advising_bank_address_line_4","onFocus",function(){m.showTooltip(m.getLocalization("addressLine4ToolTip",[dj.byId("advising_bank_address_line_4").get("displayedValue"),dj.byId("advising_bank_address_line_4").get("value")]),d.byId("advising_bank_address_line_4"),["right"],5000);});m.connect("advise_thru_bank_address_line_4","onFocus",function(){m.showTooltip(m.getLocalization("addressLine4ToolTip",[dj.byId("advise_thru_bank_address_line_4").get("displayedValue"),dj.byId("advise_thru_bank_address_line_4").get("value")]),d.byId("advise_thru_bank_address_line_4"),["right"],5000);});m.connect("requested_confirmation_party_address_line_4","onFocus",function(){m.showTooltip(m.getLocalization("addressLine4ToolTip",[dj.byId("requested_confirmation_party_address_line_4").get("displayedValue"),dj.byId("requested_confirmation_party_address_line_4").get("value")]),d.byId("requested_confirmation_party_address_line_4"),["right"],5000);});},onFormLoad:function(){m._config.lcCurCode=dj.byId("lc_cur_code").get("value");m._config.beneficiary.name=dj.byId("beneficiary_name").get("value");m._config.beneficiary.addressLine1=dj.byId("beneficiary_address_line_1").get("value");m._config.beneficiary.addressLine2=dj.byId("beneficiary_address_line_2").get("value");m._config.beneficiary.dom=dj.byId("beneficiary_dom").get("value");m._config.applicant.entity=dj.byId("entity")?dj.byId("entity").get("value"):"";m._config.applicant.name=dj.byId("applicant_name").get("value");m._config.applicant.addressLine1=dj.byId("applicant_address_line_1").get("value");m._config.applicant.addressLine2=dj.byId("applicant_address_line_2").get("value");m._config.applicant.dom=dj.byId("applicant_dom").get("value");m._config.expDate=dj.byId("exp_date").get("displayedValue");m._config.lastShipDate=dj.byId("last_ship_date").get("displayedValue");m.setCurrency(dj.byId("lc_cur_code"),["lc_amt"]);m.setCurrency(dj.byId("total_net_cur_code"),["total_net_amt"]);m.toggleDisableButtons();if(d.byId("line_item_qty_unit_measr_other_row")){m.animate("fadeOut","line_item_qty_unit_measr_other_row");}var _27="line-items";if(dj.byId(_27)&&dj.byId(_27).grid){_27.grid._refresh();}var _28=dj.byId("credit_available_with_bank_type");if(_28){_28.onChange();}var _29=dj.byId("applicable_rules");if(_29){m.toggleFields(_29.get("value")=="99",null,["applicable_rules_text"]);}var _2a=dj.byId("adv_send_mode");if(_2a){m.toggleFields(_2a.get("value")=="99",null,["adv_send_mode_text"]);}var _2b=dj.byId("part_ship_detl_nosend");if(_2b){var _2c=_2b.get("value");m.toggleFields(_2c&&_2c!==_2&&_2c!==_1&&_2c!=="NONE",null,["part_ship_detl_text_nosend"],true);}var _2d=dj.byId("part_ship_detl");if(_2d&&_2d.get("value")===""){_2d.set("value",_2b.get("value"));}var _2e=dj.byId("tran_ship_detl_nosend");if(_2e){var _2f=_2e.get("value");m.toggleFields(_2f&&_2f!==_2&&_2f!==_1&&_2f!=="NONE",null,["tran_ship_detl_text_nosend"]);}var _30=dj.byId("tran_ship_detl");if(_30&&_30.get("value")===""){_30.set("value",_2e.get("value"));}if(m._config.swift2018Enabled){m._onFormLoadSwift2018();}if(m._config.purchase_order_assistant=="true"){m.animate("fadeIn",d.byId(_27));m.animate("fadeIn",d.byId("fake_total_cur_code_row"));m.animate("fadeIn",d.byId("total_net_cur_code_row"));}else{m.animate("fadeOut",d.byId(_27));m.animate("fadeOut",d.byId("fake_total_cur_code_row"));m.animate("fadeOut",d.byId("total_net_cur_code_row"));}var _31=["cr_avl_by_code_1","cr_avl_by_code_2","cr_avl_by_code_3","cr_avl_by_code_4","cr_avl_by_code_5"];d.forEach(_31,function(id){var _32=dj.byId(id);if(_32&&_32.get("checked")){_32.onClick();}});var _33=dj.byId("eucp_flag");if(_33){m.toggleFields(_33.get("checked"),null,["eucp_details"]);}var _34=dj.byId("tenor_days_type")?dj.byId("tenor_days_type").get("value"):"";if(_34){m.toggleFields(_34==="99",null,["tenor_type_details"],true);}var _35=dj.byId("issuing_bank_abbv_name");if(_35){_35.onChange();}var _36=dj.byId("issuing_bank_customer_reference");if(_36){_36.onChange();}if(dj.byId("inco_term_year")){m.getIncoYear();dijit.byId("inco_term_year").set("value",dj.byId("org_term_year").get("value"));}if(dj.byId("inco_term")){if(dj.byId("issuing_bank_abbv_name")&&dj.byId("issuing_bank_abbv_name").get("value")!=""&&dj.byId("inco_term_year")&&dj.byId("inco_term_year").get("value")!=""){m.getIncoTerm();}dijit.byId("inco_term").set("value",dj.byId("org_inco_term").get("value"));}var _37=dj.byId("cr_avl_by_code_1").get("checked"),_38=dj.byId("cr_avl_by_code_2").get("checked"),_39=dj.byId("cr_avl_by_code_3").get("checked"),_3a=dj.byId("cr_avl_by_code_5").get("checked");if(!_37&&!_38&&!_39&&!_3a){m.setDraftTerm();}var _3b=dj.byId("drawee_details_bank_name");if(_3b){_3b.onChange();}var _3c=dj.byId("inco_term")?dj.byId("inco_term").get("value"):"";if(_3c){m.toggleFields(_3c,null,["inco_place"],false,true);}else{m.toggleFields(_3c,null,["inco_place"],false,false);}var _3d=dojo.subscribe(_7,function(){m.toggleFields(m._config.customerBanksMT798Channel[_35]==true&&m.hasAttachments(),null,["delivery_channel"],false,false);});var _3e=dj.byId("transport_mode").get("value");if(_3e!=""&&_3e!=="AIRT"&&_3e!=="SEAT"&&_3e!=="RAIL"&&_3e!=="ROAD"&&_3e!=="MULT"){dj.byId("transport_mode_nosend").set("value","OTHR");}var _3f=dj.byId("transport_mode_nosend");if(_3f){var _40=_3f.get("value");m.toggleFields(_40&&_40!=="AIRT"&&_40!=="SEAT"&&_40!=="RAIL"&&_40!=="ROAD"&&_40!=="MULT",null,["transport_mode_text_nosend"]);}var _41=dj.byId("transport_mode");if(_41&&_41.get("value")===""){_41.set("value",_3f.get("value"));}var _42=dj.byId("facility_id"),_43=dj.byId("facility_reference");if(dj.byId("issuing_bank_customer_reference")){m.populateFacilityReference(dj.byId("issuing_bank_customer_reference"));}if(_43&&_42.get("value")+"S"==="S"){if(_43.get("value")+"S"!=="S"){m._config.isLoading=true;}_42.set("displayedValue",_43.get("value"));}m.populateGridOnLoad("lc");if(dj.byId("revolving_flag")){if(dj.byId("revolving_flag").get("checked")){m.animate("fadeIn",d.byId(_3));}else{m.animate("fadeOut",d.byId(_3));dj.byId("revolve_period").set("value","");dj.byId("revolve_frequency").set("value","");dj.byId("revolve_time_no").set("value","");dj.byId("cumulative_flag").set("checked",false);dj.byId("notice_days").set("value","");}}var _44=dj.byId("revolving_flag");if(_44){m.toggleFields(_44.get("value")==="on",null,["revolve_period","revolve_frequency"]);}if(dj.byId("for_account_flag")){if(dj.byId("for_account_flag").get("checked")){m.animate("fadeIn",d.byId(_4));}else{m.animate("fadeOut",d.byId(_4));dj.byId("alt_applicant_name").set("value","");dj.byId("alt_applicant_address_line_1").set("value","");dj.byId("alt_applicant_address_line_2").set("value","");dj.byId("alt_applicant_dom").set("value","");dj.byId("alt_applicant_country").set("value","");}}var _45=dj.byId("for_account_flag");if(_45){m.toggleFields(_45.get("value")==="on",["alt_applicant_address_line_2","alt_applicant_dom"],["alt_applicant_name","alt_applicant_address_line_1","alt_applicant_country"]);}if(dj.byId("formLoad")){dj.byId("formLoad").set("value","false");}},beforeSaveValidations:function(){var _46=dj.byId("principal_act_no");if(_46&&_46.get("value")!==""){if(!m.validatePricipleAccount()){m._config.onSubmitErrorMsg=m.getLocalization("invalidPrincipleAccountError",[_46.get("displayedValue")]);m.showTooltip(m.getLocalization("invalidPrincipleAccountError",[_46.get("displayedValue")]),_46.domNode);_46.focus();return false;}}var _47=dj.byId("fee_act_no");if(_47&&_47.get("value")!==""){if(!m.validateFeeAccount()){m._config.onSubmitErrorMsg=m.getLocalization("invalidFeeAccountError",[_47.get("displayedValue")]);m.showTooltip(m.getLocalization("invalidFeeAccountError",[_47.get("displayedValue")]),_47.domNode);_47.focus();return false;}}var _48=dj.byId("entity");m.setDraftTerm();if(_48&&_48.get("value")==""){return false;}else{return true;}},beforeSubmitValidations:function(){if(!(m.validateLength(["applicant","alt_applicant","beneficiary","credit_available_with_bank","advising_bank","advise_thru_bank"]))){return false;}var _49=true;var _4a=true;if(!_5()){m._config.onSubmitErrorMsg=m.getLocalization("descOfGoodsExceedMaxWhenIncoTermSelected");return false;}if(dj.byId("lc_amt")){if(!m.validateAmount((dj.byId("lc_amt"))?dj.byId("lc_amt"):0)){m._config.onSubmitErrorMsg=m.getLocalization("amountcannotzero");dj.byId("lc_amt").set("value","");return false;}}if(m._config.swift2018Enabled){_49=m._beforeSubmitValidationsSwift2018();if(!_49){return _49;}}if(_4a===true&&dj.byId("booking_amt")){_4a=m.validateLimitBookingAmount();}if(!m.validateAmountField("open_chrg_applicant")||!m.validateAmountField("open_chrg_beneficiary")||!m.validateAmountField("corr_chrg_applicant")||!m.validateAmountField("corr_chrg_beneficiary")||!m.validateAmountField("cfm_chrg_applicant")||!m.validateAmountField("cfm_chrg_beneficiary")){return false;}if((dj.byId("tenor_type_1")&&dj.byId("tenor_type_2")&&dj.byId("tenor_type_3"))&&!dj.byId("tenor_type_1").get("checked")&&!dj.byId("tenor_type_2").get("checked")&&!dj.byId("tenor_type_3").get("checked")&&dj.byId("draft_term").get("value")===""){m._config.onSubmitErrorMsg=m.getLocalization("mandatoryPaymentTypeError");return false;}var _4b=dj.byId("principal_act_no");if(_4b&&_4b.get("value")!==""){if(!m.validatePricipleAccount()){m._config.onSubmitErrorMsg=m.getLocalization("invalidPrincipleAccountError",[_4b.get("displayedValue")]);m.showTooltip(m.getLocalization("invalidPrincipleAccountError",[_4b.get("displayedValue")]),_4b.domNode);_4b.focus();return false;}}var _4c=dj.byId("fee_act_no");if(_4c&&_4c.get("value")!==""){if(!m.validateFeeAccount()){m._config.onSubmitErrorMsg=m.getLocalization("invalidFeeAccountError",[_4c.get("displayedValue")]);m.showTooltip(m.getLocalization("invalidFeeAccountError",[_4c.get("displayedValue")]),_4c.domNode);_4c.focus();return false;}}m.setDraftTerm();if(_4a===true){_4a=m.validateLSAmtSumAgainstTnxAmt("lc");}if(dj.byId("issuing_bank_abbv_name")&&!m.validateApplDate(dj.byId("issuing_bank_abbv_name").get("value"))){m._config.onSubmitErrorMsg=m.getLocalization("changeInApplicationDates");m.goToTop();return false;}return _4a;},validateAmountField:function(_4d){var _4e=dj.byId(_4d);if(_4e){if(!_4e.get("disabled")&&_4e.get("required")){if(!m.validateAmount(_4e)){m._config.onSubmitErrorMsg=m.getLocalization("amountcannotzero");_4e.set("value","");return false;}}}return true;}});})(dojo,dijit,misys);dojo.require("misys.client.binding.trade.create_lc_client");}