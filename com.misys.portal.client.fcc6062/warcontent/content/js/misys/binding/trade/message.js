/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.trade.message"]){dojo._hasResource["misys.binding.trade.message"]=true;dojo.provide("misys.binding.trade.message");dojo.require("misys.form.CurrencyTextBox");dojo.require("dijit.form.NumberTextBox");dojo.require("dijit.form.FilteringSelect");dojo.require("misys.form.common");dojo.require("misys.validation.common");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.layout.ContentPane");dojo.require("dijit.TooltipDialog");dojo.require("dojo.data.ItemFileReadStore");dojo.require("dijit.form.FilteringSelect");dojo.require("dojo.data.ItemFileReadStore");dojo.require("misys.form.SimpleTextarea");dojo.require("misys.form.file");dojo.require("misys.widget.Collaboration");(function(d,dj,m){var _1="deletegridrecord";d.mixin(m._config,{initReAuthParams:function(){var _2=m._config.productCode.toLowerCase();var _3=dj.byId(_2+"_cur_code");var _4=dj.byId(_2+"_amt");var _5={productCode:m._config.productCode.toUpperCase(),subProductCode:"",transactionTypeCode:"13",entity:dj.byId("entity")?dj.byId("entity").get("value"):"",currency:_3?_3.get("value"):"",amount:_4?m.trimAmount(_4.get("value")):"",es_field1:"",es_field2:""};return _5;}});function _6(_7){var _8=m._config.productCode.toLowerCase(),_9=dj.byId("sub_tnx_type_code")&&(dj.byId("sub_tnx_type_code").get("value")==="25"||dj.byId("sub_tnx_type_code").get("value")==="62"),_a,_b,_c;switch(_8){case "si":_8="lc";break;case "tf":_8="fin";break;default:break;}_a=function(){var _d=m._config.productCode.toLowerCase();if(_d==="lc"){if(dj.byId("sub_tnx_type_code")&&(dj.byId("sub_tnx_type_code").get("value")==="25")){m.toggleFields(_9,null,["tnx_amt"],_7);}else{m.toggleFields(_9,["principal_act_no","fee_act_no"],["tnx_amt"],_7);}if(dj.byId("is_amt_editable")&&dj.byId("is_amt_editable").get("value")==="true"){dj.byId("tnx_amt").set("readOnly",false);dj.byId("tnx_amt").set("disabled",false);}else{dj.byId("tnx_amt").set("readOnly",true);dj.byId("tnx_amt").set("disabled",true);m.toggleRequired("tnx_amt",false);}}else{m.toggleFields(_9,["fwd_contract_no"],["tnx_amt"],_7);}};_c=(_9)?"fadeIn":"fadeOut";m.animate(_c,d.byId("settlement-details"),_a);};function _e(){var _f=dj.byId("claim_amt");if(dj.byId("document_amt")&&dj.byId("document_amt").get("value")!==""&&_f.get("value")!==""&&_f.get("value")>dj.byId("document_amt").get("value")){var _10=misys.getLocalization("debitAmtLessThanDocumentAmt",[_f.get("value"),dj.byId("document_amt").get("value")]);var _11=_f.domNode;_f.set("state","Error");dj.showTooltip(_10,_11,0);var _12=function(){dj.hideTooltip(_11);};var _13=2000;setTimeout(_12,_13);}};function _14(){var _15=dj.byId("tnx_amt");if(_15&&dj.byId("document_amt")&&dj.byId("document_amt").get("value")!==""&&_15.get("value")!==""){var _16=dojo.number.parse(dj.byId("document_amt").get("value"));_16=!isNaN(_16)?_16:0;if(_15.get("value")>_16){var _17=misys.getLocalization("settlementAmtLessThanTnxAmt",[_15.get("value"),_16]);var _18=_15.domNode;_15.set("state","Error");dj.showTooltip(_17,_18,0);var _19=function(){dj.hideTooltip(_18);};var _1a=2000;setTimeout(_19,_1a);}}};d.mixin(m,{_submit:m.submit,bind:function(){m.connect("tnx_amt","onBlur",function(){if(!m.validateTnxAmount()){dj.byId("tnx_amt").set("value","");var _1b=function(){dj.hideTooltip(dj.byId("tnx_amt").domNode);};dj.showTooltip(this.invalidMessage,dj.byId("tnx_amt").domNode,0);setTimeout(_1b,10000);}});if(dojo.isIE){m.connect("sub_tnx_type_code","onClick",function(){this.focus();});}m.connect("sub_tnx_type_code","onChange",function(){_6(false);if(dj.byId("tnx_amt")&&dj.byId("claim_amt")&&dj.byId("claim_amt").get("value")!==""){dj.byId("tnx_amt").set("value",dj.byId("claim_amt").get("value"));}if(this.get("value")==="25"){_6(false);}else{if(this.get("value")==="24"){_6(true);}}var _1c=m.getMainBankAbbvName();var _1d=m._config.customerBanksMT798Channel[_1c]===true;if(_1d){if(d.byId("pending-list-grid")){d.byId("pending-list-grid").style.display="none";}if(dj.byId("sub_tnx_type_code").get("value")=="68"){m.animate("fadeIn",d.byId("bankInst"));if(dj.byId("free_format_text")){dj.byId("free_format_text").set("hide",true);dj.byId("free_format_text").set("rows",6);dj.byId("free_format_text").set("cols",35);dj.byId("free_format_text").set("maxSize",210);dj.byId("free_format_text").set("hide",false);}if(d.byId("pending-list-grid")){d.byId("pending-list-grid").style.display="block";}}if(dj.byId("product_code").get("value")==="EL"&&dj.byId("adv_send_mode")&&dj.byId("adv_send_mode").get("value")=="01"){m.animate("fadeIn",d.byId("bankInst"));}else{if((dj.byId("sub_tnx_type_code").get("value")=="46"||dj.byId("sub_tnx_type_code").get("value")=="47")&&dj.byId("adv_send_mode").get("value")=="01"){m.animate("fadeIn",d.byId("bankInst"));dj.byId("delivery_channel").set("disabled",true);dj.byId("delivery_channel").set("value",null);}else{if(dj.byId("product_code")&&dj.byId("product_code").get("value")==="SR"){if(d.byId("claimAmt")&&dj.byId("sub_tnx_type_code").get("value")=="25"){m.animate("fadeIn",d.byId("claimAmt"));dj.byId("claim_amt").set("required",true);}else{if(d.byId("claimAmt")){m.animate("fadeOut",d.byId("claimAmt"));dj.byId("claim_amt").set("value","");dj.byId("claim_amt").set("required",false);}}m.animate("fadeIn",d.byId("bankInst"));if(m.hasAttachments()){dj.byId("delivery_channel").set("disabled",false);dj.byId("adv_send_mode").set("required",true);}else{dj.byId("delivery_channel").set("disabled",true);dj.byId("delivery_channel").set("value",null);}dj.byId("adv_send_mode").set("required",true);}else{if(dj.byId("product_code")&&(dj.byId("product_code").get("value")==="LC"||dj.byId("product_code").get("value")==="SI")&&dj.byId("adv_send_mode")&&dj.byId("adv_send_mode").get("value")=="01"){m.animate("fadeIn",d.byId("bankInst"));if(dj.byId("attachment-file")){dj.byId("delivery_channel").set("disabled",false);dj.byId("adv_send_mode").set("required",true);}else{dj.byId("delivery_channel").set("disabled",true);dj.byId("delivery_channel").set("value",null);}}else{m.clearAndFadeClaimAmtAndBankInst();}}}}}});m.connect("claim_amt","onBlur",function(){_e();});m.connect("tnx_amt","onBlur",function(){_14();});m.connect("adv_send_mode","onChange",function(){var _1e=m.getMainBankAbbvName();if(dj.byId("adv_send_mode").get("value")=="01"&&m._config.customerBanksMT798Channel[_1e]===true&&m.hasAttachments()&&dj.byId("delivery_channel")){dj.byId("delivery_channel").set("disabled",false);dj.byId("delivery_channel").set("required",true);m.connectDeliveryChannelOnChange();}else{dj.byId("delivery_channel").set("required",false);dj.byId("delivery_channel").set("disabled",true);dj.byId("delivery_channel").set("value",null);}});m.connect("tnx_amt","onBlur",function(){var _1f=dj.byId("tnx_amt");if(_1f&&dj.byId("outstanding_amt")&&dj.byId("outstanding_amt").get("value")!==""&&_1f.get("value")!==""){var _20=dojo.number.parse(dj.byId("outstanding_amt").get("value"));_20=!isNaN(_20)?_20:0;if(_1f.get("value")>_20){var _21=misys.getLocalization("settlementAmountGreaterThanOutstanding");var _22=_1f.domNode;_1f.set("state","Error");dj.showTooltip(_21,_22,0);var _23=function(){dj.hideTooltip(_22);};var _24=2000;setTimeout(_23,_24);}}});m.connect("free_format_text","onBlur",function(){if(dj.byId("free_format_text").value&&dj.byId("sub_tnx_type_code")&&dj.byId("sub_tnx_type_code").get("value")=="68"){var _25=dj.byId("free_format_text").value;var _26;if(_25&&_25!=""&&_25!=null){_26=dj.byId("free_format_text").value.replaceAll("\n","").length;}if(_25&&_26&&_26>dj.byId("free_format_text").maxSize){var _27=misys.getLocalization("ciMaxSizeExceeded");var _28=this.domNode;this.set("state","Error");dj.showTooltip(_27,_28,0);return false;}}});m.connect("free_format_text","onChange",function(){if(dj.byId("free_format_text").value&&dj.byId("sub_tnx_type_code")&&dj.byId("sub_tnx_type_code").get("value")=="68"){var _29=dj.byId("free_format_text").value;var _2a;if(_29&&_29!=""&&_29!=null){_2a=dj.byId("free_format_text").value.replaceAll("\n","").length;}if(_29&&_2a&&_2a>dj.byId("free_format_text").maxSize){var _2b=misys.getLocalization("ciMaxSizeExceeded");var _2c=this.domNode;this.set("state","Error");dj.showTooltip(_2b,_2c,0);return false;}}});},onFormLoad:function(){var _2d=m.getMainBankAbbvName();var _2e=m._config.customerBanksMT798Channel[_2d]===true;m.setCurrency(dijit.byId("claim_cur_code"),["claim_amt"]);var _2f=dj.byId("sub_tnx_type_code");_6(true);if(_2e){if((_2f&&(_2f.get("value")=="25"||_2f.get("value")=="46"||_2f.get("value")=="47"))&&dj.byId("adv_send_mode")&&dj.byId("adv_send_mode").get("value")=="01"){m.animate("fadeIn",d.byId("bankInst"));m.connectDeliveryChannelOnChange();if(dj.byId("claim_amt")){m.animate("fadeIn",d.byId("claimAmt"));dj.byId("claim_amt").set("required",true);}dj.byId("adv_send_mode").set("required",true);}else{if(_2f&&_2f.get("value")=="25"&&((dj.byId("product_code")&&dj.byId("product_code").get("value")==="SR")||(dj.byId("adv_send_mode")&&dj.byId("adv_send_mode").get("value")=="01"))){m.animate("fadeIn",d.byId("bankInst"));m.connectDeliveryChannelOnChange();if(dj.byId("claim_amt")){m.animate("fadeIn",d.byId("claimAmt"));dj.byId("claim_amt").set("required",true);}dj.byId("adv_send_mode").set("required",true);}else{if(_2f&&_2f.get("value")=="68"){m.animate("fadeIn",d.byId("bankInst"));if(d.byId("pending-list-grid")){d.byId("pending-list-grid").style.display="block";}if(d.byId("selected_tnx")&&d.byId("selected_tnx").value){var _30=d.byId("selected_tnx").value;if(dj.byId(_30)){dj.byId(_30).set("checked",true);}}if(dj.byId("free_format_text")){dj.byId("free_format_text").set("hide",true);dj.byId("free_format_text").set("rows",6);dj.byId("free_format_text").set("cols",35);dj.byId("free_format_text").set("maxSize",210);dj.byId("free_format_text").set("hide",false);}}else{if(dj.byId("product_code").get("value")==="SR"&&dj.byId("adv_send_mode")&&dj.byId("adv_send_mode").get("value")==""){m.animate("fadeIn",d.byId("bankInst"));m.connectDeliveryChannelOnChange();dj.byId("adv_send_mode").set("required",true);}else{if(dj.byId("adv_send_mode")&&dj.byId("adv_send_mode").get("value")=="01"){if(dj.byId("product_code")&&(dj.byId("product_code").get("value")==="LC"||dj.byId("product_code").get("value")==="EL"||dj.byId("product_code").get("value")==="BG"||dj.byId("product_code").get("value")==="SI"||dj.byId("product_code").get("value")==="SR")){m.animate("fadeIn",d.byId("bankInst"));if(m.hasAttachments()){if(dj.byId("delivery_channel")){misys.toggleFields(true,null,["delivery_channel"],false,false);}}m.connectDeliveryChannelOnChange();}}}}}}if(dj.byId("adv_send_mode")){m.animate("wipeOut",d.byId("adv_send_mode_row"));m.toggleRequired("adv_send_mode",false);}}else{m.animate("fadeOut",d.byId("bankInst"));if(dj.byId("adv_send_mode")&&dj.byId("adv_send_mode").get("value")!==""){m.animate("wipeIn",d.byId("adv_send_mode_row"));m.toggleRequired("adv_send_mode",true);}else{if(dj.byId("adv_send_mode")&&dj.byId("adv_send_mode").get("value")===""){m.toggleRequired("adv_send_mode",false);}}}var _31=dojo.subscribe(_1,function(){m.toggleFields(m._config.customerBanksMT798Channel[_2d]===true&&m.hasAttachments(),null,["delivery_channel"],false,false);});if(dj.byId("tnx_amt")){if(dj.byId("lc_cur_code")){m.setCurrency("lc_cur_code",["tnx_amt"]);}if(dj.byId("ic_cur_code")){m.setCurrency("ic_cur_code",["tnx_amt"]);}}if(dj.byId("product_code")&&dj.byId("product_code").get("value")==="SR"){m.toggleRequired("sub_tnx_type_code",true);}},getMainBankAbbvName:function(){var _32="";if(dj.byId("product_code")&&(dj.byId("product_code").get("value")==="LC"||dj.byId("product_code").get("value")==="SG"||dj.byId("product_code").get("value")==="LI"||dj.byId("product_code").get("value")==="TF"||dj.byId("product_code").get("value")==="SI"||dj.byId("product_code").get("value")==="BG"||dj.byId("product_code").get("value")==="FX"||dj.byId("product_code").get("value")==="XO"||dj.byId("product_code").get("value")==="FA"||dj.byId("product_code").get("value")==="SI")){_32=dj.byId("issuing_bank_abbv_name")?dj.byId("issuing_bank_abbv_name").get("value"):"";}else{if(dj.byId("product_code")&&(dj.byId("product_code").get("value")==="EL"||dj.byId("product_code").get("value")==="SR"||dj.byId("product_code").get("value")==="BR")){_32=dj.byId("advising_bank_abbv_name")?dj.byId("advising_bank_abbv_name").get("value"):"";}else{if(dj.byId("product_code")&&(dj.byId("product_code").get("value")==="EC"||dj.byId("product_code").get("value")==="IR")){_32=dj.byId("remitting_bank_abbv_name")?dj.byId("remitting_bank_abbv_name").get("value"):"";}else{if(dj.byId("product_code")&&(dj.byId("product_code").get("value")==="IC")){_32=dj.byId("presenting_bank_abbv_name")?dj.byId("presenting_bank_abbv_name").get("value"):"";}}}}return _32;},connectDeliveryChannelOnChange:function(){if(dj.byId("delivery_channel")){if((dj.byId("adv_send_mode")&&dj.byId("adv_send_mode").get("value")!="01")||!m.hasAttachments()){dj.byId("delivery_channel").set("disabled",true);dj.byId("delivery_channel").set("value",null);dj.byId("delivery_channel").set("required",false);}m.animate("fadeIn","delivery_channel_row");m.connect("delivery_channel","onChange",function(){if(dj.byId("attachment-file")){if(dj.byId("delivery_channel").get("value")==="FACT"){dj.byId("attachment-file").displayFileAct(true);}else{dj.byId("attachment-file").displayFileAct(false);}}});dj.byId("delivery_channel").onChange();}m.toggleFields(m._config.customerBanksMT798Channel[m.getMainBankAbbvName()]===true&&m.hasAttachments(),null,["delivery_channel"],false,false);},clearAndFadeClaimAmtAndBankInst:function(){if(d.byId("claimAmt")){m.animate("fadeOut",d.byId("claimAmt"));dj.byId("claim_amt").set("value","");dj.byId("claim_amt").set("required",false);dj.byId("adv_send_mode").set("value","");dj.byId("adv_send_mode").set("required",false);if(dj.byId("delivery_channel")){dj.byId("delivery_channel").set("value","");dj.byId("delivery_channel").set("required",false);}}m.animate("fadeOut",d.byId("bankInst"));},beforeSubmitValidations:function(){var _33=true;var _34="";var _35=m.getMainBankAbbvName();var _36=m._config.customerBanksMT798Channel?m._config.customerBanksMT798Channel[_35]===true:false;var _37=dj.byId("sub_tnx_type_code");var _38=dj.byId("free_format_text");var _39=dj.byId("product_code");if(_36&&_37&&_37.get("value")=="68"&&d.byId("selected_tnx")&&(d.byId("selected_tnx").value==""||d.byId("selected_tnx").value==null)){_34+=misys.getLocalization("mandatoryPendingItemError");_33=false;}if((_39&&_39.get("value")=="LI")&&(_38&&dojo.string.trim(_38.get("value"))==="")){_38.set("required",true);_38.focus();_33=false;}else{_33=true;}m._config.onSubmitErrorMsg=_34;return _33;},beforeSaveValidations:function(){if(dj.byId("claim_cur_code")&&dj.byId("claim_amt")){var cur=dj.byId("claim_cur_code").get("value");var amt=dj.byId("claim_amt").get("value");dj.byId("tnx_amt").set("value",amt);dj.byId("tnx_cur_code").set("value",cur);}return true;},submit:function(_3a){if(dj.byId("claim_cur_code")&&dj.byId("claim_amt")){var cur=dj.byId("claim_cur_code").get("value");var amt=dj.byId("claim_amt").get("value");dj.byId("tnx_amt").set("value",amt);dj.byId("tnx_cur_code").set("value",cur);}var _3b=d.byId("pending_list_count")?d.byId("pending_list_count").value:0;var _3c;if(_3b&&d.isString(_3b)){_3c=d.number.parse(_3b);}if(m._config.pendingTnxIdArray){_3c=m._config.pendingTnxIdArray.length;for(var i=0;i<_3c;i++){var _3d=m._config.pendingTnxIdArray[i];if(d.byId(_3d)&&d.byId(_3d).checked===true&&d.byId("selected_tnx")){d.byId("selected_tnx").value=_3d;}}}m._submit(_3a);}});})(dojo,dijit,misys);dojo.require("misys.client.binding.trade.message_client");}