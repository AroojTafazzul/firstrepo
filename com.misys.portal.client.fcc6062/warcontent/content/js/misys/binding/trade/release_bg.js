/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.trade.release_bg"]){dojo._hasResource["misys.binding.trade.release_bg"]=true;dojo.provide("misys.binding.trade.release_bg");dojo.require("misys.form.common");dojo.require("misys.validation.common");dojo.require("misys.form.file");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("misys.widget.Dialog");dojo.require("dijit.ProgressBar");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.layout.ContentPane");dojo.require("dijit.form.DateTextBox");dojo.require("dijit.form.CurrencyTextBox");dojo.require("dijit.form.FilteringSelect");dojo.require("misys.form.SimpleTextarea");dojo.require("misys.widget.Collaboration");(function(d,dj,m){var _1="deletegridrecord";function _2(){var _3=dj.byId("release_amt");var _4=dj.byId("org_bg_liab_amt");var _5=_3?_3.get("value"):"";var _6=_4?_4.get("value"):"";dj.byId("tnx_amt").set("value",_3);if(_3&&_4&&(_5<=0||_5>_6)){m.dialog.show("ERROR",m.getLocalization("releaseAmtGreaterThanOrgLiabAmtError"));return false;}return true;};d.mixin(m._config,{initReAuthParams:function(){var _7={productCode:"BG",subProductCode:"",transactionTypeCode:"03",entity:dj.byId("entity")?dj.byId("entity").get("value"):"",currency:dj.byId("bg_cur_code")?dj.byId("bg_cur_code").get("value"):"",amount:dj.byId("bg_amt")?m.trimAmount(dj.byId("bg_amt").get("value")):"",es_field1:"",es_field2:""};return _7;}});d.mixin(m,{bind:function(){m.connect("bg_release_flag","onClick",function(){var _8=dj.byId("release_amt"),_9=dj.byId("org_bg_liab_amt").get("value");if(this.get("checked")){_8.set("readOnly",true);_8.set("value",_9);}else{_8.set("readOnly",false);_8.set("value",_9);}});m.connect("release_amt","onBlur",_2);m.setValidation("amd_date",m.validateAmendmentDate);},onFormLoad:function(){var _a=dj.byId("recipient_bank_abbv_name").get("value");var _b=m._config.customerBanksMT798Channel[_a]===true&&dj.byId("adv_send_mode").get("value")==="01";var _c=d.byId("org-bg-lib-amt");m.animate("fadeOut",_c);m.setCurrency(dj.byId("bg_cur_code"),["release_amt"]);m.setCurrency(dj.byId("bg_cur_code"),["org_bg_liab_amt"]);m.setCurrency(dj.byId("bg_cur_code"),["bg_os_amt"]);var _d=dj.byId("tnx_amt");var _e=dj.byId("bg_release_flag");if(_e){var _f=dj.byId("release_amt"),_10=dj.byId("org_bg_liab_amt")?dj.byId("org_bg_liab_amt").get("value"):"";if(_e.get("value")=="on"){_f.set("readOnly",true);_f.set("value",_10);}else{if(_d&&_d.get("value")!==""&&_d.get("value")!==null&&_e.get("value")!=="on"){_f.set("readOnly",false);_f.set("value",_d.get("value"));}else{_f.set("readOnly",false);_f.set("value",_10);}}}var _11=dj.byId("sub_tnx_type_code");if(_11.get("value")=="05"&&_b){if(dj.byId("delivery_channel")&&dj.byId("adv_send_mode")&&dj.byId("adv_send_mode").get("value")==="01"&&m.hasAttachments()){misys.toggleFields(true,null,["delivery_channel"],false,false);}if(dj.byId("delivery_channel").get("value")===""&&!m.hasAttachments()){m.animate("fadeIn",d.byId("delivery_channel_row"));dj.byId("delivery_channel").set("disabled",true);}else{m.animate("fadeIn",d.byId("delivery_channel_row"));}if(dj.byId("delivery_channel")){m.animate("fadeIn","delivery_channel_row");m.connect("delivery_channel","onChange",function(){if(dj.byId("attachment-file")){if(dj.byId("delivery_channel").get("value")==="FACT"){dj.byId("attachment-file").displayFileAct(true);}else{dj.byId("attachment-file").displayFileAct(false);}}});dj.byId("delivery_channel").onChange();}}else{m.animate("fadeOut",d.byId("delivery_channel_row"));if(dj.byId("delivery_channel")){dj.byId("delivery_channel").set("required",false);}}if(_d){var _12=dj.byId("release_amt")?dj.byId("release_amt").get("value"):"";_d.set("value",_12);}var _13=dojo.subscribe(_1,function(){m.toggleFields(m._config.customerBanksMT798Channel[_a]===true&&m.hasAttachments(),null,["delivery_channel"],false,false);});},beforeSubmitValidations:function(){var _14=["bg_liab_amt","amd_details","file"];var _15=d.every(_14,function(id){if(d.byId(id)){return true;}return false;});if(_15){var _16=(d.query("#edit [id^='file_row_']").length>1);if(!_16&&!dj.byId("bg_liab_amt").get("value")&&(dj.byId("amd_details").get("value")==="")){m._config.onSubmitErrorMsg=m.getLocalization("noAmendmentError");return false;}}var _17=dj.byId("amd_date");if(_17&&dj.byId("org_exp_date")&&dj.byId("org_exp_date").get("value")!==null){var _18=dj.byId("org_exp_date");if(!m.compareDateFields(_17,_18)){m._config.onSubmitErrorMsg=m.getLocalization("amendDateGreaterThanOldExpiryDate",[_17.get("displayedValue"),_18.get("displayedValue")]);return false;}}var _19=dj.byId("release_amt");if(_19){return _2();}return true;}});})(dojo,dijit,misys);dojo.require("misys.client.binding.trade.release_bg_client");}