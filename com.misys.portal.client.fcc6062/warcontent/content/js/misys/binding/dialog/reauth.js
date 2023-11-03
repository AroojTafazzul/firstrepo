/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.dialog.reauth"]){dojo._hasResource["misys.binding.dialog.reauth"]=true;dojo.provide("misys.binding.dialog.reauth");dojo.require("misys.validation.common");(function(d,dj,m){var _1="reauth_dialog";var _2=false;function _3(_4){_2=false;_4.hide();var _5=dj.findWidgets(dojo.byId("reauth_dialog_content"));dojo.forEach(_5,function(w){w.destroyRecursive(false);});dojo.empty("reauth_dialog_content");if(dj.byId("realform_operation")){var _6=dj.byId("realform_operation");_6.set("value",originalOperationValue);}if(dj.byId("alertDialog")){dj.byId("alertDialog").hide();}};function _7(_8,_9){if(_8.validate()){if(d.isFunction(m._config.reauthSubmit)){_8.hide();m._config.reauthSubmit();}else{dj.byId("reauth_otp_response")?dj.byId("reauth_otp_response").set("value",dj.byId("reauth_password").get("value")):"";dj.byId("TransactionData")?dj.byId("TransactionData").set("value",misys.formToXML()):"";if(dijit.byId("doReauthentication")){dijit.byId("doReauthentication").set("disabled",true);}_8.hide();dj.byId("realform").submit();}_9++;}};d.mixin(m,{beforeSubmitEncryptionReauth:function(){if(dj.byId("clientSideEncryption")){try{if(dijit.byId("reauth_password")&&dijit.byId("reauth_password").get("value")!==""){dijit.byId("reauth_password").set("value",misys.encrypt(dijit.byId("reauth_password").get("value")));if(dijit.byId("doReauthentication")){dijit.byId("doReauthentication").set("disabled",true);}}return true;}catch(error){misys.dialog.show("ERROR",misys.getLocalization("passwordNotEncrypted"),"",function(){});if(dijit.byId("doReauthentication")){dijit.byId("doReauthentication").set("disabled",false);}return false;}}}});d.subscribe("ready",function(){var _a=dj.byId(_1),_b=0;m.setValidation("reauth_password",m.validatePassword);if(_a){var _c=dj.byId("reauth_password");m.dialog.connect(_a,"onShow",function(){_c.set("required",true);});m.dialog.connect(_a,"onHide",function(){_c.set("value","");_c.set("required",false);});m.dialog.connect(_a,"onKeyPress",function(_d){switch(_d.keyCode){case d.keys.ESCAPE:d.stopEvent(_d);_3(_a);break;case d.keys.ENTER:if(dijit.byId("doReauthentication")&&!_2){dijit.byId("doReauthentication").focus();}if(dj.byId("clientSideEncryption")){misys.encryptBeforeSubmitReauth();}if(_b===0&&!_2){_7(_a,_b);d.stopEvent(_d);break;}default:break;}});m.dialog.connect("doReauthentication","onClick",function(){if(dj.byId("clientSideEncryption")){misys.encryptBeforeSubmitReauth();}if(m.isFormDirty&&m.isFormDirty===true){m.isFormDirty=false;}if(_b===0){_7(_a,_b);}},_1);m.dialog.connect("cancelReauthentication","onClick",function(){_3(_a);},_1);m.dialog.connect("doReauthentication","onFocus",function(){_2=false;},_1);m.dialog.connect("cancelReauthentication","onFocus",function(){_2=true;},_1);}});})(dojo,dijit,misys);dojo.require("misys.client.binding.dialog.reauth_client");}