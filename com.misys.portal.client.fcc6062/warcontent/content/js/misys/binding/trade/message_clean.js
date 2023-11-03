/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.trade.message_clean"]){dojo._hasResource["misys.binding.trade.message_clean"]=true;dojo.provide("misys.binding.trade.message_clean");dojo.require("misys.form.common");dojo.require("misys.validation.common");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.layout.ContentPane");dojo.require("dojo.data.ItemFileReadStore");dojo.require("misys.form.SimpleTextarea");dojo.require("dijit.form.DateTextBox");dojo.require("dijit.form.FilteringSelect");dojo.require("dijit.layout.TabContainer");dojo.require("dijit.form.DateTextBox");dojo.require("misys.form.CurrencyTextBox");dojo.require("dijit.form.NumberTextBox");dojo.require("misys.form.file");dojo.require("misys.widget.Collaboration");dojo.require("misys.widget.Dialog");dojo.require("dijit.ProgressBar");dojo.require("dijit.layout.TabContainer");dojo.require("misys.form.CurrencyTextBox");dojo.require("dijit.form.FilteringSelect");(function(d,dj,m){d.mixin(m._config,{initReAuthParams:function(){var _1={productCode:"LC",subProductCode:"",transactionTypeCode:"13",entity:dj.byId("entity")?dj.byId("entity").get("value"):"",currency:dj.byId("lc_cur_code").get("value"),amount:m.trimAmount(dj.byId("lc_amt").get("value")),es_field1:m.trimAmount(dj.byId("lc_amt").get("value")),es_field2:""};return _1;}});function _2(_3){var _4=function(){var _5=dijit.byId("debit_amt");_5.set("state","Error");m.defaultBindTheFXTypes();dj.byId("debit_amt").set("value","");dj.byId("principal_act_name").set("value","");dj.byId("principal_act_cur_code").set("value","");dj.byId("principal_act_no").set("value","");dj.byId("principal_act_description").set("value","");dj.byId("principal_act_pab").set("value","");};m.dialog.show("ERROR",_3,"",function(){setTimeout(_4,500);});};function _6(){var _7=dj.byId("debit_amt");if(dj.byId("document_amt")&&dj.byId("document_amt").get("value")!==""&&_7.get("value")!==""&&_7.get("value")>dj.byId("document_amt").get("value")){var _8=misys.getLocalization("debitAmtLessThanDocumentAmt",[_7.get("value"),dj.byId("document_amt").get("value")]);var _9=_7.domNode;_7.set("state","Error");dj.showTooltip(_8,_9,0);var _a=function(){dj.hideTooltip(_9);};var _b=2000;setTimeout(_a,_b);}};d.mixin(m._config,{initReAuthParams:function(){var _c={productCode:m._config.productCode,subProductCode:"",transactionTypeCode:"13",entity:dj.byId("entity")?dj.byId("entity").get("value"):"",currency:dj.byId("lc_cur_code").get("value"),amount:m.trimAmount(dj.byId("document_amt").get("value")),es_field1:m.trimAmount(dj.byId("document_amt").get("value")),es_field2:""};return _c;}});d.mixin(m,{fireFXAction:function(){if(m._config.fxParamData&&m._config.fxParamData[m._config.productCode].fxParametersData.isFXEnabled==="Y"){var _d,_e,_f;var _10=dj.byId("debit_cur_code").get("value");var _11=dj.byId("debit_amt").get("value");var _12=dj.byId("principal_act_cur_code").get("value");var _13=m._config.productCode;var _14=false;var _15="";if(dj.byId("issuing_bank_abbv_name")&&dj.byId("issuing_bank_abbv_name").get("value")!==""){_15=dj.byId("issuing_bank_abbv_name").get("value");}if(_10!==""&&!isNaN(_11)&&_13!==""&&_15!==""){if(_10!==_12){_d=_12;_e=_10;_f=_12;}if(_d&&_d!==""&&_e&&_e!==""){if(d.byId("fx-section")){m.animate("wipeIn",d.byId("fx-section"));}m.fetchFXDetails(_d,_e,_11,_13,_15,_f,_14);if(dj.byId("fx_rates_type_1")&&dj.byId("fx_rates_type_1").get("checked")){if(isNaN(dj.byId("fx_exchange_rate").get("value"))||dj.byId("fx_exchange_rate_cur_code").get("value")===""||isNaN(dj.byId("fx_exchange_rate_amt").get("value"))||(m._config.fxParamData[m._config.productCode].fxParametersData.toleranceDispInd==="Y"&&(isNaN(dj.byId("fx_tolerance_rate").get("value"))||isNaN(dj.byId("fx_tolerance_rate_amt").get("value"))||dj.byId("fx_tolerance_rate_cur_code").get("value")===""))){_2(m.getLocalization("FXDefaultErrorMessage"));}}}else{if(d.byId("fx-section")){d.style("fx-section","display","none");}m.defaultBindTheFXTypes();}}}},bind:function(){misys.setValidation("debit_cur_code",misys.validateCurrency);misys.connect("debit_cur_code","onChange",function(){misys.setCurrency(this,["debit_amt"]);});misys.connect("debit_amt","onBlur",function(){_6();});if(m._config.fxParamData&&m._config.fxParamData[m._config.productCode].fxParametersData.isFXEnabled==="Y"){m.connect("debit_cur_code","onChange",function(){m.setCurrency(this,["debit_amt"]);if(dj.byId("debit_cur_code").get("value")!==""&&!isNaN(dj.byId("debit_amt").get("value"))){m.fireFXAction();}else{m.defaultBindTheFXTypes();}});m.connect("debit_amt","onChange",function(){m.setTnxAmt(this.get("value"));if(!isNaN(dj.byId("debit_amt").get("value"))&&dj.byId("debit_cur_code").get("value")!==""){m.fireFXAction();}else{m.defaultBindTheFXTypes();}});m.connect("principal_act_name","onChange",function(){if(dj.byId("principal_act_cur_code")&&dj.byId("principal_act_cur_code").get("value")!==""){m.fireFXAction();}else{m.defaultBindTheFXTypes();if(d.byId("fx-section")&&(d.style(d.byId("fx-section"),"display")!=="none")){m.animate("wipeOut",d.byId("fx-section"));}}});}},onFormLoad:function(){misys.setCurrency(dijit.byId("debit_cur_code"),["debit_amt"]);if(d.byId("fx-section")){if((dj.byId("fx_exchange_rate_cur_code")&&dj.byId("fx_exchange_rate_cur_code").get("value")!=="")||(dj.byId("fx_total_utilise_cur_code")&&dj.byId("fx_total_utilise_cur_code").get("value")!=="")){m.animate("wipeIn",d.byId("fx-section"));}else{d.style("fx-section","display","none");}}if(m._config.fxParamData&&m._config.fxParamData[m._config.productCode].fxParametersData.isFXEnabled==="Y"){m.initializeFX(m._config.productCode);m.onloadFXActions();}},beforeSubmitValidations:function(){if(m._config.fxParamData&&m._config.fxParamData[m._config.productCode].fxParametersData.isFXEnabled==="Y"){if(!m.fxBeforeSubmitValidation()){return false;}var _16=true;var _17="";var _18=dj.byId("fx_rates_type_2");var _19=dj.byId("fx_total_utilise_amt");var _1a=dj.byId("debit_amt");if(_18.get("checked")&&_19&&!isNaN(_19.get("value"))&&_1a&&!isNaN(_1a.get("value"))){if(_1a.get("value")<_19.get("value")){_17+=m.getLocalization("FXUtiliseAmtGreaterMessage");_16=false;}}m._config.onSubmitErrorMsg=_17;return _16;}else{return true;}}});})(dojo,dijit,misys);dojo.require("misys.client.binding.trade.message_clean_client");}