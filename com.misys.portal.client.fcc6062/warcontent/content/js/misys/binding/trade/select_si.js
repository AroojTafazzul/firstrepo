/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.trade.select_si"]){dojo._hasResource["misys.binding.trade.select_si"]=true;dojo.provide("misys.binding.trade.select_si");dojo.require("dijit.form.FilteringSelect");dojo.require("misys.form.common");dojo.require("misys.validation.common");dojo.require("misys.form.file");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("misys.widget.Dialog");dojo.require("dijit.ProgressBar");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.layout.ContentPane");dojo.require("misys.editor.plugins.ProductFieldChoice");dojo.require("dojo.data.ItemFileReadStore");dojo.require("dijit.layout.TabContainer");dojo.require("dijit.form.DateTextBox");dojo.require("misys.form.CurrencyTextBox");dojo.require("dijit.form.FilteringSelect");dojo.require("misys.form.SimpleTextarea");dojo.require("dijit.Editor");dojo.require("dijit._editor.plugins.FontChoice");dojo.require("dojox.editor.plugins.ToolbarLineBreak");dojo.require("misys.widget.Collaboration");(function(d,dj,m){var _1=new RegExp("si_name_section_","g"),_2=d.query("div[id^='si_name_section_']");function _3(){var _4=dj.byId("si_type_code").get("value"),_5,_6;d.forEach(_2,function(_7){_5=_7.id.replace(_1,"");if(_5!==_4){d.style(_7,"display","none");}else{m.animate("wipeIn",_7);}});};function _8(){var _9="";d.forEach(_2,function(_a){_9+="|"+_a.id.replace("si_name_section_","");});d.query("> option",dj.byId("si_type_code").store.root).forEach(function(_b){if(_9.indexOf(_b.value)<0){d.destroy(_b);}});};function _c(){var _d="",_e,_f;d.some(_2,function(div){if(d.style(div,"display")==="block"){_f=dj.byId("bg_name_select_"+div.id.replace(_1,""));_d=_f.get("value");return true;}return false;});if(_d){dj.byId("realform_featureid").set("value",_d);dj.byId("realform").submit();}else{m.dialog.show("ERROR",m.getLocalization("mustChooseStandByIssued"));}};function _10(){document.location.href=m._config.homeUrl;};function _11(url,_12,_13){var _14=_12||misys.getLocalization("transactionPopupWindowTitle"),_15=_13||"width=800,height=500,resizable=yes,scrollbars=yes",_16=d.global.open(url,_14,_15);if(!_16.opener){_16.opener=self;}_16.focus();};d.mixin(m,{generateDocument:function(_17,_18,_19,_1a,_1b,_1c,_1d){switch(_17.toLowerCase()){case "bg-document":var url=["/screen/ReportingPopup"];url.push("?option=",_18);url.push("&referenceid=",_19);url.push("&tnxid=",_1a);url.push("&featureid=",_1c);url.push("&companyId=",_1d);url.push("&productcode=",_1b);_11(m.getServletURL(url.join(""),null,m.getLocalization("pdfSummaryWindowTitle")));break;default:break;}}});})(dojo,dijit,misys);dojo.require("misys.client.binding.trade.select_si_client");}