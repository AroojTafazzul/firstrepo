/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.bank.report_se"]){dojo._hasResource["misys.binding.bank.report_se"]=true;dojo.provide("misys.binding.bank.report_se");dojo.require("misys.form.common");dojo.require("misys.validation.common");dojo.require("misys.form.file");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("misys.widget.Dialog");dojo.require("dijit.ProgressBar");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.layout.ContentPane");dojo.require("dijit.form.DateTextBox");dojo.require("misys.form.CurrencyTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.form.FilteringSelect");dojo.require("misys.form.addons");dojo.require("misys.form.SimpleTextarea");dojo.require("dojo.data.ItemFileReadStore");dojo.require("misys.widget.Collaboration");(function(d,dj,m){d.mixin(m,{bind:function(){m.connect("se_type","onChange",function(){dj.byId("topic").set("value",dj.byId("se_type").get("displayedValue"));});m.connect("prod_stat_code","onChange",m.toggleProdStatCodeFields);},onFormLoad:function(){if(dj.byId("se_type")){dj.byId("topic").set("value",dj.byId("se_type").get("displayedValue"));}if(dj.byId("action_req_code")){m.toggleProdStatCodeFields();}}});})(dojo,dijit,misys);dojo.require("misys.client.binding.bank.report_se_client");}