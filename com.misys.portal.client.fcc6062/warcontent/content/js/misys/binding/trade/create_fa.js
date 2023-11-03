/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.trade.create_fa"]){dojo._hasResource["misys.binding.trade.create_fa"]=true;dojo.provide("misys.binding.trade.create_fa");dojo.require("misys.form.common");dojo.require("misys.validation.common");dojo.require("misys.form.file");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("misys.widget.Dialog");dojo.require("dijit.ProgressBar");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.layout.ContentPane");dojo.require("misys.editor.plugins.ProductFieldChoice");dojo.require("dojo.data.ItemFileReadStore");dojo.require("dijit.layout.TabContainer");dojo.require("dijit.form.DateTextBox");dojo.require("misys.form.CurrencyTextBox");dojo.require("dijit.form.FilteringSelect");dojo.require("misys.form.SimpleTextarea");dojo.require("dijit.Editor");dojo.require("dijit._editor.plugins.FontChoice");dojo.require("dojox.editor.plugins.ToolbarLineBreak");dojo.require("misys.widget.Collaboration");dojo.require("misys.form.static_document");(function(d,dj,m){function _1(){var _2=dj.byId("request_max_amt").get("checked"),_3=dj.byId("fa_amt"),_4=dj.byId("fa_cur_code");if(_2){_3.set("required",false);_3.set("disabled",true);_4.set("required",false);_4.set("disabled",true);_3.set("value","");}else{_3.set("required",true);_3.set("disabled",false);_4.set("required",true);_4.set("disabled",false);}};d.mixin(m,{bind:function(){m.connect("issuing_bank_abbv_name","onChange",m.populateReferences);if(dj.byId("issuing_bank_abbv_name")){m.connect("entity","onChange",function(){dj.byId("issuing_bank_abbv_name").onChange();});}m.setValidation("fa_cur_code",m.validateCurrency);m.connect("fa_cur_code","onChange",function(){m.setCurrency(this,["fa_amt"]);});m.connect("issuing_bank_customer_reference","onChange",m.setApplicantReference);m.connect("request_max_amt","onClick",_1);},onFormLoad:function(){if(dj.byId("fa_amt").value===0){dj.byId("fa_amt").set("value","");}m.setCurrency(dj.byId("fa_cur_code"),["fa_amt"]);var _5=dj.byId("request_max_amt").get("checked");if(_5){dj.byId("fa_amt").set("disabled",true);dj.byId("fa_cur_code").set("disabled",true);dj.byId("fa_amt").set("value","");}var _6=dj.byId("issuing_bank_abbv_name");if(_6){_6.onChange();}var _7=dj.byId("issuing_bank_customer_reference");if(_7){_7.onChange();}}});})(dojo,dijit,misys);dojo.require("misys.client.binding.trade.create_fa_client");}