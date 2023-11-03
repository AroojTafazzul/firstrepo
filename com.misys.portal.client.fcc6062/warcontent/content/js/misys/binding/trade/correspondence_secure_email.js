/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.trade.correspondence_secure_email"]){dojo._hasResource["misys.binding.trade.correspondence_secure_email"]=true;dojo.provide("misys.binding.trade.correspondence_secure_email");dojo.require("dijit.layout.TabContainer");dojo.require("dijit.form.DateTextBox");dojo.require("misys.form.CurrencyTextBox");dojo.require("dijit.form.NumberTextBox");dojo.require("dijit.form.FilteringSelect");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("misys.widget.Dialog");dojo.require("dijit.ProgressBar");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("misys.form.file");dojo.require("misys.form.SimpleTextarea");dojo.require("misys.widget.Collaboration");dojo.require("misys.form.common");dojo.require("misys.validation.common");(function(d,dj,m){d.mixin(m._config,{initReAuthParams:function(){var _1={productCode:"SE",subProductCode:"",transactionTypeCode:"01",entity:dj.byId("entity")?dj.byId("entity").get("value"):"",currency:"",amount:"",es_field1:"",es_field2:""};return _1;}});function _2(){var _3=dj.byId("issuing_bank_abbv_name")?dj.byId("issuing_bank_abbv_name").get("value"):"";m.xhrPost({url:m.getServletURL("/screen/AjaxScreen/action/GetTopicsForBank"),handleAs:"json",content:{bank:_3},load:_4,customError:function(_5,_6){console.error("[misys.binding.trade.correspondence_secure_email] Technical error while getting Topics for Bank",_5);}});};function _4(_7,_8){var _9=dj.byId("topic");var _a=1;_9.store=new d.data.ItemFileReadStore({data:_7});};d.mixin(m,{bind:function(){if(dj.byId("bank_abbv_name")){dj.byId("bank_abbv_name").set("value","");}var _b="";m.connect("issuing_bank_abbv_name","onChange",m.populateReferences);m.connect("issuing_bank_abbv_name","onChange",function(){_2();var _c=dj.byId("issuing_bank_abbv_name").get("value");if(dj.byId("bank_abbv_name")){dj.byId("bank_abbv_name").set("value",_c);}});m.connect("entity","onChange",function(){if(dj.byId("issuing_bank_abbv_name")){dj.byId("issuing_bank_abbv_name").onChange();}});m.connect("issuing_bank_customer_reference","onChange",function(){if(dj.byId("applicant_reference")){var _d=this.get("value");dj.byId("applicant_reference").set("value",_d);}});},onFormLoad:function(){var _e=dj.byId("issuing_bank_customer_reference_temp");var _f;if(_e){_f=_e.value;}var _10=dj.byId("issuing_bank_abbv_name");if(_10){_10.onChange();}_e=dj.byId("issuing_bank_customer_reference");if(_e){_e.onChange();_e.set("value",_f);}}});})(dojo,dijit,misys);dojo.require("misys.client.binding.trade.correspondence_secure_email_client");}