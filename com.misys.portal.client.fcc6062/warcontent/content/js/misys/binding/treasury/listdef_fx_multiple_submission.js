/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.treasury.listdef_fx_multiple_submission"]){dojo._hasResource["misys.binding.treasury.listdef_fx_multiple_submission"]=true;dojo.provide("misys.binding.treasury.listdef_fx_multiple_submission");dojo.require("dojo.data.ItemFileReadStore");dojo.require("dojo.data.ItemFileWriteStore");dojo.require("dijit.form.FilteringSelect");dojo.require("misys.form.MultiSelect");dojo.require("dijit.layout.TabContainer");dojo.require("misys.form.common");dojo.require("misys.openaccount.StringUtils");dojo.require("misys.validation.common");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.layout.ContentPane");dojo.require("misys.form.CurrencyTextBox");dojo.require("misys.binding.common.reauth_listdef_common");dojo.require("misys.binding.system.reauth");dojo.require("misys.binding.common.reauth_listdef");(function(d,dj,m){d.mixin(m._config,{doReauthSubmit:function(_1){var _2={};if(d.isFunction(m._config.initReAuthParams)){_2=m._config.initReAuthParams();m._config.reauthXhrParams=m._config.reauthXhrParams||{};m._config.reauthXhrParams=_1;m._config.executeReauthentication(_2);}},initReAuthParams:function(){reAuthParams={productCode:"FX",subProductCode:dj.byId("sub_product_code")?dj.byId("sub_product_code").get("value"):"",transactionTypeCode:"01",entity:dj.byId("entity")?dj.byId("entity").get("value"):"",currency:"",amount:"",es_field1:"",es_field2:""};return reAuthParams;},reauthSubmit:function(){var _3=dj.byId("reauth_password").get("value");d.mixin(m._config.reauthXhrParams.content,{reauth_otp_response:_3});m.xhrPost(m._config.reauthXhrParams);setTimeout(d.hitch(dijit.byId(m._config.getGridId()),"render"),100);dj.byId("reauth_password").set("value","");dj.byId("reauth_dialog").hide();},nonReauthSubmit:function(){m.xhrPost(m._config.reauthXhrParams);setTimeout(d.hitch(dijit.byId(m._config.getGridId()),"render"),100);},submitFXOrder:function(){var _4=[],_5="",_6="";if(dj.byId("nonSignedFolders")){if(dijit.byId("nonSignedFolders").selection.selectedIndex!==-1){if(dj.byId("referenceid")){_5=dj.byId("referenceid").get("value");}if(dj.byId("tnxid")){_6=dj.byId("tnxid").get("value");}}}d.query(".dojoxGrid").forEach(function(g){_4.push(dj.byId(g.id));});m._config.processRecords(_4,"/screen/AjaxScreen/action/TreasuryMultipleSubmission?s=ForeignExchangeScreen&option=STANDING_INSTRUCTIONS&mode=UNSIGNED&tnxtype=13&referenceid="+_5+"&tnxid="+_6);},processRecords:function(_7,_8,_9){var _a=d.isArray(_7)?_7:[_7],_b=d.byId("batchContainer"),_c=[],_d="",_e=0,_f,_10;m.animate("wipeOut",_b);d.forEach(_a,function(_11){_c=_11.selection.getSelected();if(_c&&_c.length){d.forEach(_c,function(_12){_f=_11.store.getValues(_12,"box_ref");if(_d!==""){_d+=", ";}_d+=_f;_e++;});}});if(_e>0){m._config._processRecords(_a,_8,_d,_9);}else{if(_e===0){m.dialog.show("ERROR",m.getLocalization("noTransactionsSelectedError"));}}},_processRecords:function(_13,url,_14,_15){_13=d.isArray(_13)?_13:[_13];var _16={"list_keys":_14},_17=d.byId("batchContainer"),_18;_18={url:m.getServletURL(url),handleAs:"text",sync:true,content:_16,load:function(_19){_19=_19.replace(/\n/g,"<br>");_19=_19.replace(/\t/g,"&nbsp;&nbsp;&nbsp;");_17.innerHTML=_19;setTimeout(function(){m.animate("wipeIn","batchContainer");},500);m._config.groups=[];d.forEach(_13,function(g){g.setStore(g.store);d.hitch(g,"render")();m.connect(g,"_onFetchComplete",function(){g.selection.clear();});});}};if(_15){d.mixin(_18,{handle:_15});}var _1a=dj.byId("reauth_perform");if((_1a&&_1a.get("value")==="Y")&&d.isFunction(m._config.doReauthSubmit)){m._config.doReauthSubmit(_18);}else{m.xhrPost(_18);}}});})(dojo,dijit,misys);dojo.require("misys.client.binding.openaccount.listdef_fx_multiple_submission_client");}