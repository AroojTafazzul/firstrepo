/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.trade.client_avail_info_fa"]){dojo._hasResource["misys.binding.trade.client_avail_info_fa"]=true;dojo.provide("misys.binding.trade.client_avail_info_fa");dojo.require("misys.form.common");dojo.require("misys.validation.common");dojo.require("misys.form.file");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("misys.widget.Dialog");dojo.require("dijit.ProgressBar");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.layout.ContentPane");dojo.require("misys.editor.plugins.ProductFieldChoice");dojo.require("dojo.data.ItemFileReadStore");dojo.require("dijit.layout.TabContainer");dojo.require("dijit.form.DateTextBox");dojo.require("misys.form.CurrencyTextBox");dojo.require("dijit.form.FilteringSelect");dojo.require("misys.form.SimpleTextarea");dojo.require("dijit.Editor");dojo.require("dijit._editor.plugins.FontChoice");dojo.require("dojox.editor.plugins.ToolbarLineBreak");dojo.require("misys.widget.Collaboration");dojo.require("misys.form.static_document");(function(d,dj,m){d.mixin(m,{viewExposureEnquiry:function(){m.animate("fadeOut",d.byId("clientActInfo"),function(){});m.animate("fadeIn",d.byId("clientExpoInfo"),function(){});dojo.query("#GTPRootPortlet .portlet-title")[0].innerHTML=m.getLocalization("FAClientExpoTitleMessage");},hideDebtorDetails:function(){m.animate("fadeOut",d.byId("clientExpoInfo"),function(){});m.animate("fadeIn",d.byId("clientActInfo"),function(){});dojo.query("#GTPRootPortlet .portlet-title")[0].innerHTML=m.getLocalization("FAClientAvailTitleMessage");},bind:function(){},onFormLoad:function(){m.animate("fadeOut",d.byId("clientExpoInfo"),function(){});dojo.query("#GTPRootPortlet .portlet-title")[0].innerHTML=m.getLocalization("FAClientAvailTitleMessage");}});})(dojo,dijit,misys);dojo.require("misys.client.binding.trade.client_avail_info_fa_client");}