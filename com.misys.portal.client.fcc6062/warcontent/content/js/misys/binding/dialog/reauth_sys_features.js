/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.dialog.reauth_sys_features"]){dojo._hasResource["misys.binding.dialog.reauth_sys_features"]=true;dojo.provide("misys.binding.dialog.reauth_sys_features");(function(d,dj,m){m._config=m._config||{};m._config.reAuthParams=m._config.reAuthParams||{productCode:"",subProductCode:"",transactionTypeCode:"",entity:"",currency:"",amount:"",es_field1:"",es_field2:""};d.mixin(m._config,{doReauthSubmit:function(_1){m._config.sf_submit_form=m._config.sf_submit_form||{};m._config.sf_submit_form=_1;var _2={};if(d.isFunction(m._config.initReAuthParams)){_2=m._config.initReAuthParams();m.checkAndShowReAuthDialog(_2);}else{console.error(response);m.setContentInReAuthDialog("ERROR","");dj.byId("reauth_dialog").show();}},reauthSubmit:function(){var _3=dj.byId("reauth_password").get("value");var _4=m._config.sf_submit_form;d.create("input",{id:"reauth_otp_response",name:"reauth_otp_response",type:"hidden",value:_3,dojoType:"dijit.form.TextBox",readOnly:"true"},_4.domNode);d.create("input",{id:"reauth_password",name:"reauth_password",type:"hidden",value:_3,dojoType:"dijit.form.TextBox",readOnly:"true"},_4.domNode);_4.submit();},nonReauthSubmit:function(){var _5=m._config.sf_submit_form;_5.submit();},initReAuthParams:function(){return m._config.reAuthParams;},setReAuthParams:function(_6,_7,_8,_9,_a){m._config.reAuthParams.productCode=_6;m._config.reAuthParams.subProductCode=_7;m._config.reAuthParams.transactionTypeCode=_8;m._config.reAuthParams.es_field1=_9;m._config.reAuthParams.es_field2=_a;}});})(dojo,dijit,misys);dojo.require("misys.client.binding.dialog.reauth_sys_features_client");}