/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.common.remote_authorisation"]){dojo._hasResource["misys.binding.common.remote_authorisation"]=true;dojo.provide("misys.binding.common.remote_authorisation");(function(d,dj,m){d.mixin(m,{sendEsignRequest:function(_1){if(dj.byId("authoriser_name").get("value")===""){m.dialog.show("ERROR",m.getLocalization("selectAuthoriserError"));return;}if(!dj.byId("esign_request_mode_email").get("checked")&&!dj.byId("esign_request_mode_sms").get("checked")){m.dialog.show("ERROR",m.getLocalization("selectRequestModeError"));return;}if(dj.byId("authoriser_name").get("value")!==""&&(dj.byId("esign_request_mode_email").get("checked")||dj.byId("esign_request_mode_sms").get("checked"))){dj.byId("realform_operation").set("value",_1);if(dj.byId("esign_request_mode_email").get("checked")){dj.byId("request_mode").set("value","email");}else{dj.byId("request_mode").set("value","sms");}var _2=function(){dj.byId("TransactionData").set("value",m.formToXML());dj.byId("realform").submit();};m.dialog.show("CONFIRMATION",m.getLocalization("sendEsignRequestConfirm"),"",_2);}},submitProxyAuthorise:function(_3,_4){if(dj.byId("authoriser").get("value")===""){m.dialog.show("ERROR",m.getLocalization("selectAuthoriserError"));return;}if(dj.byId("remote_auth_otp_response").get("value")===""){m.dialog.show("ERROR",m.getLocalization("inputOTPResponseError"));return;}if(dj.byId("authoriser").get("value")!==""&&dj.byId("remote_auth_otp_response").get("value")!==""){dj.byId("realform_operation").set("value",_4);dj.byId("authoriser_id").set("value",dj.byId("authoriser").get("value"));var _5=true,_6;var _7=function(){m.xhrPost({url:m.getServletURL("/screen/AjaxScreen/action/ValidateHolidayCutOffMultipleSubmission"),sync:true,handleAs:"json",content:{"batch_id":_3},load:function(_8,_9){_5=_8.isValid;_6=_8.autoForwardTransactionDetails;},error:function(_a,_b){console.error("[misys.grid._base] submitBatchWithHolidayCutOffValidation error",_a);}});if(_5){dj.byId("TransactionData").set("value",m.formToXML());dj.byId("realform").submit();}else{var _c=[];_c.push("<b>"+m.getLocalization("autoForwardMultipleSubmission")+"</b><br/>");d.forEach(_6,function(_d){_c.push("<li>"+_d+"</li>");});var _e=function(){dj.byId("autoForward").set("value","Y");dj.byId("TransactionData").set("value",m.formToXML());dj.byId("realform").submit();};m.dialog.show("CONFIRMATION",_c.join(""),"",_e);}};m.dialog.show("CONFIRMATION",m.getLocalization("proxyAuthoriseTransaction"),"",_7);}},bind:function(){m.connect("authoriser_name","onChange",function(){if(dj.byId("email").get("value")!==""){d.byId("email_display").innerHTML=dj.byId("email").get("value");dj.byId("esign_request_mode_email").set("checked",false);dj.byId("esign_request_mode_email").set("disabled",false);if(dj.byId("mobile_phone").get("value")===""){dj.byId("esign_request_mode_email").set("checked",true);dj.byId("esign_request_mode_sms").set("checked",false);dj.byId("esign_request_mode_sms").set("disabled",true);d.byId("mobile_phone_display").innerHTML="-";}else{d.byId("mobile_phone_display").innerHTML=dj.byId("mobile_phone").get("value");dj.byId("esign_request_mode_sms").set("checked",false);dj.byId("esign_request_mode_sms").set("disabled",false);}}else{dj.byId("esign_request_mode_email").set("checked",false);dj.byId("esign_request_mode_email").set("disabled",true);d.byId("email_display").innerHTML="-";if(dj.byId("mobile_phone").get("value")===""){dj.byId("esign_request_mode_sms").set("checked",false);dj.byId("esign_request_mode_sms").set("disabled",true);d.byId("mobile_phone_display").innerHTML="-";}else{d.byId("mobile_phone_display").innerHTML=dj.byId("mobile_phone").get("value");dj.byId("esign_request_mode_sms").set("disabled",false);dj.byId("esign_request_mode_sms").set("checked",true);}}if(dj.byId("email").get("value")!==""&&dj.byId("mobile_phone").get("value")!==""){dj.byId("esign_request_mode_sms").set("checked",true);}});}});})(dojo,dijit,misys);dojo.require("misys.client.binding.common.remote_authorisation_client");}