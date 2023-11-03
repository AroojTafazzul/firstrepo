/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.system.guarantee"]){dojo._hasResource["misys.binding.system.guarantee"]=true;dojo.provide("misys.binding.system.guarantee");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.layout.ContentPane");dojo.require("dijit.form.FilteringSelect");dojo.require("misys.form.MultiSelect");dojo.require("dijit.Editor");dojo.require("dijit._editor._Plugin");dojo.require("dijit._editor.plugins.AlwaysShowToolbar");dojo.require("dijit._editor.plugins.FontChoice");dojo.require("dijit._editor.plugins.TextColor");dojo.require("dijit._editor.plugins.LinkDialog");dojo.require("dojox.editor.plugins.ToolbarLineBreak");dojo.require("misys.editor.plugins.ProductFieldChoice");dojo.require("misys.form.SimpleTextarea");dojo.require("dojo.data.ItemFileWriteStore");dojo.require("misys.grid.DataGrid");dojo.require("misys.widget.Dialog");dojo.require("misys.form.static_document");dojo.require("misys.system.widget.Customers");dojo.require("misys.report.widget.Column");dojo.require("misys.common");dojo.require("misys.form.common");dojo.require("misys.validation.common");(function(d,dj,m){function _1(){var _2=d.byId("document-editor"),_3=this.get("value");if(_3==="02"){m.animate("fadeIn",_2,function(){_10();m.createRteEditor("BG","bg_document");});}else{m.animate("fadeOut",_2);}m.toggleFields(_3==="02",null,["bg_document"]);_5();setTimeout(function(){var _4=dj.byId("bg_document");if(_4){_4.focus();}},1000);};function _5(){var _6=d.byId("specimen-section"),_7=d.byId("autoSpecimen-section"),_8=dj.byId("text_type_code_1"),_9=dj.byId("specimen"),_a=dj.byId("auto_specimen_name"),_b=dj.byId("specimen_name"),_c=d.byId("specimen-checkbox-div");dj.byId("specimen_name").set("readOnly",true);if(_8&&_8.get("checked")){if(_9&&_9.get("checked")){_a.set("value","");_a.set("required",false);_b.set("required",true);m.animate("fadeOut",_7);m.animate("fadeIn",_6);m.animate("fadeIn",_c);}else{_b.set("value","");m.animate("fadeOut",_6);m.animate("fadeIn",_c);m.animate("fadeIn",_7);_a.set("readonly",false);_a.set("required",true);m.toggleFields(true,null,["auto_specimen_name"]);}}else{_a.set("value","");_b.set("value","");_8.set("checked",false);_b.set("required",false);_a.set("required",false);m.animate("fadeOut",_6);m.animate("fadeOut",_7);m.animate("fadeOut",_c);}};function _d(){var _e=d.byId("specimen-section"),_f=this.get("value");if(_f==="on"){m.animate("fadeIn",_e);}else{m.animate("fadeOut",_e);}m.toggleFields(_f==="on",null,["specimen_name"]);_5();};function _10(){d.require("misys.report.definitions.report_all_candidates");d.require("misys.report.definitions.report_audit_candidate");d.require("misys.report.definitions.report_lt_candidate");d.require("misys.report.definitions.report_bg_candidate");initialiseProductArrays("bg");d.require("misys.report.definitions.report_bn_candidate");initialiseProductArrays("bn");d.require("misys.report.definitions.report_ec_candidate");initialiseProductArrays("ec");d.require("misys.report.definitions.report_el_candidate");initialiseProductArrays("el");d.require("misys.report.definitions.report_ft_candidate");initialiseProductArrays("ft");d.require("misys.report.definitions.report_ic_candidate");initialiseProductArrays("ic");d.require("misys.report.definitions.report_in_candidate");initialiseProductArrays("in");d.require("misys.report.definitions.report_ip_candidate");initialiseProductArrays("ip");d.require("misys.report.definitions.report_ir_candidate");initialiseProductArrays("ir");d.require("misys.report.definitions.report_lc_candidate");initialiseProductArrays("lc");d.require("misys.report.definitions.report_li_candidate");initialiseProductArrays("li");d.require("misys.report.definitions.report_ri_candidate");initialiseProductArrays("ri");d.require("misys.report.definitions.report_se_candidate");initialiseProductArrays("se");initialiseProductArrays("lt");d.require("misys.report.definitions.report_po_candidate");initialiseProductArrays("po");d.require("misys.report.definitions.report_sg_candidate");initialiseProductArrays("sg");d.require("misys.report.definitions.report_si_candidate");initialiseProductArrays("si");d.require("misys.report.definitions.report_so_candidate");initialiseProductArrays("so");d.require("misys.report.definitions.report_sr_candidate");initialiseProductArrays("sr");d.require("misys.report.definitions.report_tf_candidate");initialiseProductArrays("tf");d.require("misys.report.definitions.report_tu_candidate");initialiseProductArrays("tu");d.require("misys.report.definitions.report_bg_template_candidate");initialiseProductArrays("bg_template");d.require("misys.report.definitions.report_ec_template_candidate");initialiseProductArrays("ec_template");d.require("misys.report.definitions.report_ft_template_candidate");initialiseProductArrays("ft_template");d.require("misys.report.definitions.report_lc_template_candidate");initialiseProductArrays("lc_template");d.require("misys.report.definitions.report_lt_template_candidate");initialiseProductArrays("lt_template");d.require("misys.report.definitions.report_po_template_candidate");initialiseProductArrays("po_template");d.require("misys.report.definitions.report_si_template_candidate");initialiseProductArrays("si_template");};function _11(){var _12=d.byId("customers-section");_12.style.display=(this.get("checked")?"none":"block");if(this.get("checked")){var _13=dj.byId("customers");if(_13){_13.clear();}}};function _14(){dj.byId("customerOkButton").set("disabled",true);var _15=["customer_abbv_name","customer_name"],_16=false,_17,_18;_16=d.every(_15,function(id){_17=dj.byId(id);if(_17){_18=_17.get("value");if(!_18||_17.state==="Error"){m.showTooltip(m.getLocalization("mandatoryFieldsError"),_17.domNode,["above","before"]);_17.state="Error";_17._setStateClass();dj.setWaiState(_17.focusNode,"invalid","true");return false;}}return true;});dj.byId("customerOkButton").set("disabled",false);if(!_16){return false;}else{dj.byId("customer-dialog-template").gridMultipleItemsWidget.updateData();dj.byId("customers").dialog.hide();return true;}};d.mixin(m,{bind:function(){m.setValidation("customer_abbv_name",m.validateCharacters);m.connect("customerOkButton","onMouseUp",_14);m.connect("staticDocumentAddButton","onClick",m.openStaticDocumentDialog);},resetStaticDocument:function(){dj.byId("staticDocumentUploadDialog").hide();dj.byId("static_title").reset();dj.byId("static_file").reset();},onFormLoad:function(){var _19=d.byId("autoSpecimen-section"),_1a=dj.byId("auto_specimen_name"),_1b=d.byId("specimen-checkbox-div"),_1c=d.byId("specimen-section");_1a.set("value","");_1a.set("required",false);if(dj.byId("text_type_code_1").get("checked")&&dj.byId("specimen").get("checked")){m.animate("fadeOut",_19);m.animate("fadeIn",_1c);m.animate("fadeIn",_1b);}else{if(dj.byId("text_type_code_1").get("checked")&&!(dj.byId("specimen").get("checked"))){m.animate("fadeIn",_19);m.animate("fadeOut",_1c);m.animate("fadeIn",_1b);_1a.set("value",_1a._resetValue);}else{if(dj.byId("text_type_code_2").get("checked")){m.animate("fadeOut",_19);m.animate("fadeOut",_1c);m.animate("fadeOut",_1b);}}}}});d.ready(function(){dojo.parser.parse("edit");m.animate("fadeIn",d.byId("specimen-checkbox-div"));m.connect("text_type_code_1","onClick",_1);m.connect("text_type_code_2","onClick",_1);m.connect("standard","onClick",_11);m.connect("specimen","onClick",_d);var _1d=dj.byId("standard");if(_1d&&_1d.get("checked")){_1d.onClick();}if(!dj.byId("text_type_code_2").get("checked")){dj.byId("text_type_code_1").set("checked",true);}var _1e=dj.byId("text_type_code_2").get("checked");if(_1e){d.style("document-editor","display","block");m.toggleFields(_1e,null,["bg_document"]);if(_1e){_10();m.createRteEditor("BG","bg_document");}}else{var _1f=dj.byId("text_type_code_1").get("checked");var _20=dj.byId("specimen");var _21=dj.byId("specimen_name");var _22=dj.byId("auto_specimen_name");if(_22.value){d.style("autoSpecimen-section","display","block");m.toggleFields(true,null,["auto_specimen_name"]);}else{_20.set("checked",_1f);d.style("specimen-section","display",_1f?"block":"none");m.toggleFields(_1f,null,["specimen_name"]);dj.byId("specimen_name").set("readOnly",true);}}});})(dojo,dijit,misys);dojo.require("misys.client.binding.system.guarantee_client");}