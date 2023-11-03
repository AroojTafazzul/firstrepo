/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.bank.report_ri"]){dojo._hasResource["misys.binding.bank.report_ri"]=true;dojo.provide("misys.binding.bank.report_ri");dojo.require("misys.form.common");dojo.require("misys.validation.common");dojo.require("misys.form.file");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("misys.widget.Dialog");dojo.require("dijit.ProgressBar");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.layout.ContentPane");dojo.require("dijit.layout.TabContainer");dojo.require("dijit.form.DateTextBox");dojo.require("misys.form.CurrencyTextBox");dojo.require("dijit.form.NumberTextBox");dojo.require("dijit.form.FilteringSelect");dojo.require("misys.form.addons");dojo.require("misys.form.SimpleTextarea");dojo.require("dojo.data.ItemFileReadStore");dojo.require("misys.widget.Collaboration");(function(d,dj,m){d.mixin(m,{bind:function(){m.setValidation("ic_cur_code",m.validateCurrency);m.connect("prod_stat_code","onChange",m.validateOutstandingAmount);m.connect("ic_cur_code","onChange",function(){m.setCurrency(this,["ic_amt","ic_liab_amt"]);});m.connect("term_code","onChange",function(){m.toggleFields((this.get("value")!="01"),null,["tenor_desc"]);m.toggleFields((this.get("value")=="02"),null,["maturity_date"]);});m.connect("ic_amt","onBlur",function(){m.setTnxAmt(this.get("value"));});m.connect("prod_stat_code","onChange",m.toggleProdStatCodeFields);m.connect("prod_stat_code","onChange",function(){var _1=this.get("value");m.toggleFields(_1&&_1!=="01"&&_1!=="18",null,["iss_date","bo_ref_id"]);});},onFormLoad:function(){m.setCurrency(dj.byId("ic_cur_code"),["tnx_amt","ic_amt","ic_liab_amt"]);var _2=dj.byId("term_code");if(_2){m.toggleFields((_2.get("value")=="03"),null,["tenor_desc"],true);}}});})(dojo,dijit,misys);dojo.require("misys.client.binding.bank.report_ri_client");}