/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.bank.report_lc_swift"]){dojo._hasResource["misys.binding.bank.report_lc_swift"]=true;dojo.provide("misys.binding.bank.report_lc_swift");dojo.require("dojo.data.ItemFileReadStore");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("misys.widget.Dialog");dojo.require("dijit.ProgressBar");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.layout.ContentPane");dojo.require("dijit.form.DateTextBox");dojo.require("misys.form.CurrencyTextBox");dojo.require("dijit.form.FilteringSelect");dojo.require("dijit.layout.TabContainer");dojo.require("misys.form.SimpleTextarea");dojo.require("misys.widget.Collaboration");dojo.require("misys.form.addons");dojo.require("misys.form.common");dojo.require("misys.form.file");dojo.require("misys.validation.common");dojo.require("misys.binding.trade.ls_common");(function(d,dj,m){function _1(){var _2=true,_3=true;var _4,_5,_6,_7,_8,_9="",_a="",_b,_c,_d,_e;if(dj.byId("narrative_description_goods")&&dj.byId("narrative_documents_required")&&dj.byId("narrative_additional_instructions")&&dj.byId("narrative_special_beneficiary")){if(dj.byId("narrative_description_goods")){_4=dj.byId("narrative_description_goods").get("value")!==""?dj.byId("narrative_description_goods").get("value")+"\n":"";}if(dj.byId("narrative_documents_required")){_5=dj.byId("narrative_documents_required").get("value")!==""?dj.byId("narrative_documents_required").get("value")+"\n":"";}if(dj.byId("narrative_additional_instructions")){_6=dj.byId("narrative_additional_instructions").get("value")!==""?dj.byId("narrative_additional_instructions").get("value")+"\n":"";}if(dj.byId("narrative_special_beneficiary")){_7=dj.byId("narrative_special_beneficiary").get("value")!==""?dj.byId("narrative_special_beneficiary").get("value")+"\n":"";}if(dj.byId("narrative_special_recvbank")){_8=dj.byId("narrative_special_recvbank").get("value")!==""?dj.byId("narrative_special_recvbank").get("value")+"\n":"";}if(!m._config.isBank){_9=_4+_5+_6+_7;}else{_9=_4+_5+_6+_7+_8;}if(dj.byId(this.id)){_b=800*this.cols;_a=dj.byId(this.id).get("value")!==""?dj.byId(this.id).get("value")+"\n":"";_c=_a.length;_2=m.validateExtNarrativeSwiftInit2018(_a,true);}_3=m.validateExtNarrativeSwiftInit2018(_9,false);_d=1000*this.cols;_e=_9.length;if(_2){this.invalidMessage=m.getLocalization("invalidFieldSizeError",[_d,_e]);}else{this.invalidMessage=m.getLocalization("invalidSingleFieldLength",[_b,_c]);}return _2&&_3;}};d.mixin(m,{_bindSwift2018:function(){m.setValidation("advising_bank_iso_code",m.validateBICFormat);m.setValidation("advise_thru_bank_iso_code",m.validateBICFormat);m.setValidation("requested_confirmation_party_iso_code",m.validateBICFormat);m.setValidation("credit_available_with_bank_iso_code",m.validateBICFormat);m.setValidation("drawee_details_bank_iso_code",m.validateBICFormat);m.connect("advising_bank_iso_code","onChange",function(){var _f=this.get("value");if(_f.length>0){m.setRequiredFields(["advising_bank_name","advising_bank_address_line_1"],false);}});m.connect("advise_thru_bank_iso_code","onChange",function(){var _10=this.get("value");if(_10.length>0){m.setRequiredFields(["advise_thru_bank_name","advise_thru_bank_address_line_1"],false);}});m.connect("requested_confirmation_party_iso_code","onChange",function(){var _11=this.get("value");if(_11.length>0){dj.byId("requested_confirmation_party_name").set("state","");m.setRequiredFields(["requested_confirmation_party_name","requested_confirmation_party_address_line_1"],false);}});m.connect("req_conf_party_flag","onChange",m.resetBankRequiredFields);m.connect("req_conf_party_flag_filtered","onChange",m.resetBankRequiredFields);m.connect("req_conf_party_flag","onChange",function(){dj.byId("req_conf_party_flag_filtered").set("value",dj.byId("req_conf_party_flag").getValue());});m.connect("req_conf_party_flag_filtered","onChange",function(){dj.byId("req_conf_party_flag").set("value",dj.byId("req_conf_party_flag_filtered").getValue());});m.connect("amd_chrg_brn_by_code_1","onClick",m.amendChargesLC);m.connect("amd_chrg_brn_by_code_2","onClick",m.amendChargesLC);m.connect("amd_chrg_brn_by_code_3","onClick",m.amendChargesLC);m.connect("amd_chrg_brn_by_code_4","onClick",m.amendChargesLC);m.connect("amd_chrg_brn_by_code_5","onClick",m.amendChargesLC);m.connect("amd_chrg_brn_by_code_9","onClick",m.amendChargesLC);m.connect("cfm_inst_code_1","onClick",m.resetConfirmationChargesLC);m.connect("cfm_inst_code_2","onClick",m.resetConfirmationChargesLC);m.connect("cfm_inst_code_3","onClick",m.resetConfirmationChargesLC);m.connect("lc_amt","onBlur",m.calculateAmendTransactionAmount);m.connect("lc_liab_amt","onBlur",m.validateLCLiabAmt);m.connect("narrative_period_presentation","onBlur",function(){var _12=dj.byId("narrative_period_presentation").get("value");dj.byId("narrative_period_presentation_nosend").set("value",_12);});m.setValidation("period_presentation_days",m.validatePeriodPresentationDays);if(misys._config.swiftExtendedNarrativeEnabled){m.setValidation("narrative_additional_instructions",_1);m.setValidation("narrative_documents_required",_1);m.setValidation("narrative_description_goods",_1);m.setValidation("narrative_special_beneficiary",_1);if(dj.byId("narrative_special_recvbank")){m.setValidation("narrative_special_recvbank",_1);}}},_formLoadSwift2018:function(){var _13=dj.byId("tran_ship_detl").value;var _14=dj.byId("part_ship_detl").value;var _15=m._config.displayMode;if((_13!=""&&_13!="ALLOWED"&&_13!="NOT ALLOWED"&&_13!="NONE")&&_15=="edit"){document.getElementById("infoMessageTranshipment").style.display="block";document.getElementById("infoMessageTranshipment").style.paddingLeft="250px";}else{document.getElementById("infoMessageTranshipment").style.display="none";}if((_14!=""&&_14!="ALLOWED"&&_14!="NOT ALLOWED"&&_14!="NONE")&&_15=="edit"){document.getElementById("infoMessagePartialShipment").style.display="block";document.getElementById("infoMessagePartialShipment").style.paddingLeft="250px";}else{document.getElementById("infoMessagePartialShipment").style.display="none";}if(dj.byId("req_conf_party_flag_filtered")){dj.byId("req_conf_party_flag_filtered").set("value",dj.byId("req_conf_party_flag").getValue());m.setRequiredFields(["req_conf_party_flag_filtered"],false);}if(_15=="edit"){m.resetRequestedConfirmationParty();}var _16="requested-conf-party-bank-details";if(dj.byId("req_conf_party_flag")){var _17=dj.byId("req_conf_party_flag").value;if(_17==="Other"){d.byId(_16).style.display="block";}else{if(dj.byId(_16)){d.byId(_16).style.display="none";}}}m.refreshUIforAmendment();if(dj.byId("amd_chrg_brn_by_code_4")||dj.byId("amd_chrg_brn_by_code_5")){if(!(dj.byId("amd_chrg_brn_by_code_4").get("value")||(dj.byId("amd_chrg_brn_by_code_5")&&dj.byId("amd_chrg_brn_by_code_5").get("value")))){var _18=dj.byId("narrative_amend_charges_other");if(_18){_18.set("value","");_18.set("disabled",true);}}}if(dj.byId("cfm_inst_code_3")){if(dj.byId("cfm_inst_code_3").get("value")){dj.byId("req_conf_party_flag").set("required",false);m.toggleRequired("req_conf_party_flag",false);}else{dj.byId("req_conf_party_flag").set("required",true);m.toggleRequired("req_conf_party_flag",true);}}m.toggleNarrativeDivStatus(true,"");m.toggleRequired("req_conf_party_flag",false);m.toggleRequired("req_conf_party_flag_filtered",false);if(dj.byId("adv_send_mode")&&dj.byId("adv_send_mode").get("value")==="01"&&dj.byId("narrative_charges")){dj.byId("narrative_charges").maxSize=6;}},_beforeSubmitValidationsSwift2018:function(){if(dj.byId("adv_send_mode")&&dj.byId("adv_send_mode").get("value")==1&&document.getElementById("tabNarrativeDescriptionGoods")){var _19=false;if(dj.byId("is798")&&dj.byId("is798").get("value")!=""){_19=dj.byId("is798").get("value")=="Y"?true:false;}var _1a=[m._config.narrativeDescGoodsDataStore,m._config.narrativeDocsReqDataStore,m._config.narrativeAddInstrDataStore,m._config.narrativeSpBeneDataStore,m._config.narrativeSpRecvbankDataStore];var i,_1b=0,_1c=0,_1d=0,_1e="narrative-details-tabcontainer",_1f=true,_20;var _21=dj.byId("swiftregexzcharValue").get("value");var _22=new RegExp(_21);m._config.isNarrativeZCharValidArray=[true,true,true,true,true];var _23=[0,0,0,0,0];m._config.isSingleNarrativeValid=[true,true,true,true,true];var _24=["tabNarrativeDescriptionGoods","tabNarrativeDocumentsRequired","tabNarrativeAdditionalInstructions","tabNarrativeSpecialBeneficiary","tabNarrativeSpecialReceivingBank"];if(document.getElementById("tabNarrativeDescriptionGoods").status==true){for(itr=0;itr<5;itr++){i=0;_20=true;if(_1a&&_1a[itr]){d.forEach(_1a[itr],function(){if(_1a[itr][i]&&_1a[itr][i]!==null&&_20){_1a[itr][i].content[0].replace(/&#xa;/g,"\n");_1d+=_1a[itr][i].content[0].length;_1b+=_1a[itr][i].text_size[0];_23[itr]+=_1a[itr][i].text_size[0];_20=_22.test(_1a[itr][i].content[0]);m._config.isNarrativeZCharValidArray[itr]=_20;}i++;});}if(!m._config.isNarrativeZCharValidArray[itr]||(dojo.some(_23,function(_25){return _25>(_19?792:800);}))){if(!m._config.isNarrativeZCharValidArray[itr]){m.toggleNarrativeDivStatus(m._config.isNarrativeZCharValidArray[itr],_24[itr]);}else{if(_23[itr]>(_19?792:800)){m._config.isSingleNarrativeValid[itr]=false;m.toggleNarrativeDivStatus(m._config.isSingleNarrativeValid[itr],_24[itr]);_1f=false;}}}}if(_1b>(_19?992:1000)){d.forEach(m._config.isSingleNarrativeValid,function(){m._config.isSingleNarrativeValid[_1c]=true;});m.toggleNarrativeDivStatus(false);_1f=false;}}else{if(_1b>(_19?992:1000)||document.getElementById("tabNarrativeDescriptionGoods").status==false){_1c=0;d.forEach(m._config.isSingleNarrativeValid,function(){m._config.isSingleNarrativeValid[_1c]=true;});if(document.getElementById("tabNarrativeDescriptionGoods").status==true){m.toggleNarrativeDivStatus(false);}_1f=false;}}if(!_1f||(dojo.some(m._config.isNarrativeZCharValidArray,function(_26){return _26==false;}))){if(m._config.isNarrativeZCharValidArray.indexOf(false)>3){_1e="narrative-special-payments-beneficiary-tabcontainer";}dojox.fx.smoothScroll({node:document.getElementById(_1e),win:window}).play();return false;}}if(dj.byId("req_conf_party_flag")&&dj.byId("req_conf_party_flag").get("value")!==""){var _27=dj.byId("prod_stat_code").get("value");var _28=dj.byId("tnx_type_code").get("value");if(dj.byId("req_conf_party_flag").get("value")==="Advising Bank"){if(!((_28==="15"&&_27==="08")||_28==="03")){return m.validateBankEntry("advising_bank");}}else{if(dj.byId("req_conf_party_flag").get("value")==="Advise Thru Bank"){if(!((_28==="15"&&_27==="08")||_28==="03")){return m.validateBankEntry("advise_thru_bank");}}else{if(dj.byId("req_conf_party_flag").get("value")==="Other"){if(!m.validateBankEntry("requested_confirmation_party")){m._config.onSubmitErrorMsg=m.getLocalization("requestedConfirmationPartyError");return false;}else{return true;}}}}}if(dj.byId("narrative_period_presentation_nosend")&&dj.byId("narrative_period_presentation_nosend").get("value")!==""){var _29=dj.byId("narrative_period_presentation_nosend").get("value");if(_29.indexOf("\n")!=-1){m._config.onSubmitErrorMsg=m.getLocalization("periodOfPresentaionError");return false;}}return true;},_beforeSubmit2018:function(){if(dj.byId("tnx_type_code")&&dj.byId("tnx_type_code").get("value")==="03"){m.updateSubTnxTypeCode("lc");}}});})(dojo,dijit,misys);dojo.require("misys.client.binding.bank.report_lc_swift_client");}