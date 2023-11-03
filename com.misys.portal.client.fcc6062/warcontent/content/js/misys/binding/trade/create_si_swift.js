/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.trade.create_si_swift"]){dojo._hasResource["misys.binding.trade.create_si_swift"]=true;dojo.provide("misys.binding.trade.create_si_swift");dojo.require("dijit.layout.TabContainer");dojo.require("dijit.form.DateTextBox");dojo.require("misys.form.CurrencyTextBox");dojo.require("dijit.form.NumberTextBox");dojo.require("dijit.form.FilteringSelect");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("misys.widget.Dialog");dojo.require("dijit.ProgressBar");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("misys.form.SimpleTextarea");dojo.require("misys.widget.Collaboration");dojo.require("misys.form.common");dojo.require("misys.form.file");dojo.require("misys.validation.common");dojo.require("misys.binding.SessionTimer");dojo.require("misys.binding.trade.ls_common");(function(d,dj,m){function _1(){var _2=true,_3=true;var _4,_5,_6,_7,_8,_9="",_a="",_b,_c,_d,_e;if(dj.byId("narrative_description_goods")&&dj.byId("narrative_documents_required")&&dj.byId("narrative_additional_instructions")&&dj.byId("narrative_special_beneficiary")){if(dj.byId("narrative_description_goods")){_4=dj.byId("narrative_description_goods").get("value")!==""?dj.byId("narrative_description_goods").get("value")+"\n":"";}if(dj.byId("narrative_documents_required")){_5=dj.byId("narrative_documents_required").get("value")!==""?dj.byId("narrative_documents_required").get("value")+"\n":"";}if(dj.byId("narrative_additional_instructions")){_6=dj.byId("narrative_additional_instructions").get("value")!==""?dj.byId("narrative_additional_instructions").get("value")+"\n":"";}if(dj.byId("narrative_special_beneficiary")){_7=dj.byId("narrative_special_beneficiary").get("value")!==""?dj.byId("narrative_special_beneficiary").get("value")+"\n":"";}if(dj.byId("narrative_special_recvbank")){_8=dj.byId("narrative_special_recvbank").get("value")!==""?dj.byId("narrative_special_recvbank").get("value")+"\n":"";}if(!m._config.isBank){_9=_4+_5+_6+_7;}else{_9=_4+_5+_6+_7+_8;}if(dj.byId(this.id)){_b=800*this.cols;_a=dj.byId(this.id).get("value")!==""?dj.byId(this.id).get("value")+"\n":"";_c=_a.length;_2=m.validateExtNarrativeSwiftInit2018(_a,true);}_3=m.validateExtNarrativeSwiftInit2018(_9,false);_d=1000*this.cols;_e=_9.length;if(_2){this.invalidMessage=m.getLocalization("invalidFieldSizeError",[_d,_e]);}else{this.invalidMessage=m.getLocalization("invalidSingleFieldLength",[_b,_c]);}return _2&&_3;}};d.mixin(m,{_bindSwift2018:function(){m.connect("cfm_inst_code_1","onClick",m.resetConfirmationChargesLC);m.connect("cfm_inst_code_2","onClick",m.resetConfirmationChargesLC);m.connect("cfm_inst_code_3","onClick",m.resetConfirmationChargesLC);m.setValidation("advising_bank_iso_code",m.validateBICFormat);m.setValidation("advise_thru_bank_iso_code",m.validateBICFormat);m.setValidation("requested_confirmation_party_iso_code",m.validateBICFormat);if(misys._config.swiftExtendedNarrativeEnabled){m.setValidation("narrative_additional_instructions",_1);m.setValidation("narrative_documents_required",_1);m.setValidation("narrative_description_goods",_1);m.setValidation("narrative_special_beneficiary",_1);if(dj.byId("narrative_special_recvbank")){m.setValidation("narrative_special_recvbank",_1);}}m.connect("advising_bank_iso_code","onChange",function(){var _f=this.get("value");if(_f.length>0){m.setRequiredFields(["advising_bank_name","advising_bank_address_line_1"],false);}});m.connect("advise_thru_bank_iso_code","onChange",function(){var _10=this.get("value");if(_10.length>0){m.setRequiredFields(["advise_thru_bank_name","advise_thru_bank_address_line_1"],false);}});m.connect("requested_confirmation_party_iso_code","onChange",function(){var _11=this.get("value");if(_11.length>0){m.setRequiredFields(["requested_confirmation_party_name","requested_confirmation_party_address_line_1"],false);}});m.connect("req_conf_party_flag","onChange",m.resetBankRequiredFields);m.connect("narrative_period_presentation","onBlur",function(){var _12=dj.byId("narrative_period_presentation").get("value");dj.byId("narrative_period_presentation_nosend").set("value",_12);});m.setValidation("period_presentation_days",m.validatePeriodPresentationDays);},_onFormLoadSwift2018:function(){var _13=dj.byId("CREATE_OPTION").get("value");if(_13==="EXISTING"||_13==="BACK_TO_BACK"){m.dialog.show("CONFIRMATION",m.getLocalization("warningMsgCreateLC"),"","","","","",function(){var _14="/screen/StandbyIssuedScreen?option="+_13+"&tnxtype=01";window.location.href=misys.getServletURL(_14);return;});}var _15=dj.byId("tran_ship_detl").value;var _16=dj.byId("part_ship_detl").value;var _17=m._config.displayMode;if(_17==="edit"){m.resetRequestedConfirmationParty();}if((_15!=""&&_15!="ALLOWED"&&_15!="NOT ALLOWED"&&_15!="NONE")&&_17==="edit"){d.byId("infoMessageTranshipment").style.display="block";d.byId("infoMessageTranshipment").style.paddingLeft="250px";}else{d.byId("infoMessageTranshipment").style.display="none";}if((_16!=""&&_16!="ALLOWED"&&_16!="NOT ALLOWED"&&_16!="NONE")&&_17==="edit"){d.byId("infoMessagePartialShipment").style.display="block";d.byId("infoMessagePartialShipment").style.paddingLeft="250px";}else{d.byId("infoMessagePartialShipment").style.display="none";}if(dj.byId("req_conf_party_flag")){var _18=dj.byId("req_conf_party_flag").value;if(_18==="Other"){d.byId("requested-conf-party-bank-details").style.display="block";}else{d.byId("requested-conf-party-bank-details").style.display="none";}}},_beforeSubmitValidationsSwift2018:function(){if(dj.byId("req_conf_party_flag")&&dj.byId("req_conf_party_flag").get("value")!==""){if(dj.byId("req_conf_party_flag").get("value")==="Advising Bank"){return m.validateBankEntry("advising_bank");}else{if(dj.byId("req_conf_party_flag").get("value")==="Advise Thru Bank"){return m.validateBankEntry("advise_thru_bank");}else{if(dj.byId("req_conf_party_flag").get("value")==="Other"){if(!m.validateBankEntry("requested_confirmation_party")){m._config.onSubmitErrorMsg=m.getLocalization("requestedConfirmationPartyError");return false;}else{return true;}}}}}if(dj.byId("narrative_period_presentation_nosend")&&dj.byId("narrative_period_presentation_nosend").get("value")!==""){var _19=dj.byId("narrative_period_presentation_nosend").get("value");if(_19.indexOf("\n")!=-1){m._config.onSubmitErrorMsg=m.getLocalization("periodOfPresentaionError");return false;}}if(dj.byId("rolling_renewal_flag")&&dj.byId("rolling_renewal_nb")&&dj.byId("rolling_renewal_flag").get("checked")&&d.number.parse(dj.byId("rolling_renewal_nb").get("value"))===1){dj.byId("rolling_renewal_nb").set("state","Error");m._config.onSubmitErrorMsg=m.getLocalization("invalidNumberOfRollingRenewals");dj.byId("rolling_renewal_nb").set("value"," ");return false;}return true;}});})(dojo,dijit,misys);dojo.require("misys.client.binding.trade.create_si_swift_client");}