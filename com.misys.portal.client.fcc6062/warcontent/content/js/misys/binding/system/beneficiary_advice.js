/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.system.beneficiary_advice"]){dojo._hasResource["misys.binding.system.beneficiary_advice"]=true;dojo.provide("misys.binding.system.beneficiary_advice");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.layout.ContentPane");dojo.require("dijit.form.FilteringSelect");dojo.require("misys.widget.Dialog");dojo.require("misys.system.widget.Customers");dojo.require("misys.system.widget.BeneficiaryAdvicesTemplateColumns");dojo.require("misys.common");dojo.require("misys.form.common");dojo.require("misys.validation.common");dojo.require("misys.form.PercentNumberTextBox");(function(d,dj,m){function _1(){var _2=d.byId("customers-section");if(dj.byId("all_entities").get("checked")){dojo.style(_2,"display","none");var _3=dj.byId("customers");}else{dojo.style(_2,"display","block");}};function _4(){dj.byId("customerOkButton").set("disabled",true);var _5=["customer_abbv_name","customer_name"],_6=false,_7,_8;_6=d.every(_5,function(id){_7=dj.byId(id);if(_7){_8=_7.get("value");if(!_8||_7.state==="Error"){m.showTooltip(m.getLocalization("mandatoryFieldsError"),_7.domNode,["above","before"]);_7.state="Error";_7._setStateClass();dj.setWaiState(_7.focusNode,"invalid","true");return false;}}return true;});dj.byId("customerOkButton").set("disabled",false);if(!_6){d.forEach(_5,function(id){_7=dj.byId(id);if(_7){_8=_7.get("value");if(!_8||_7.state==="Error"){_7.state="Error";_7._setStateClass();dj.setWaiState(_7.focusNode,"invalid","true");}}});return false;}else{dj.byId("customer-dialog-template").gridMultipleItemsWidget.updateData();dj.byId("customers").dialog.hide();return true;}};function _9(){dj.byId("columnOkButton").set("disabled",true);var _a=["column_label","column_type","column_alignment","column_width"],_b=false,_c,_d;if(dj.byId("column_type").get("value")==="03"){_a=["column_label","column_type","column_alignment"];}_b=d.every(_a,function(id){_c=dj.byId(id);if(_c){_d=_c.get("value");if(!_d||_c.state==="Error"){m.showTooltip(m.getLocalization("mandatoryFieldsError"),_c.domNode,["above","before"]);_c.state="Error";_c._setStateClass();dj.setWaiState(_c.focusNode,"invalid","true");return false;}}return true;});dj.byId("columnOkButton").set("disabled",false);if(!_b){d.forEach(_a,function(id){_c=dj.byId(id);if(_c){_d=_c.get("value");if(!_d||_c.state==="Error"){_c.state="Error";_c._setStateClass();dj.setWaiState(_c.focusNode,"invalid","true");}}});return false;}else{dj.byId("column-dialog-template").gridMultipleItemsWidget.updateData();dj.byId("columns").dialog.hide();return true;}};function _e(){var _f=dj.byId("columns-grid");var _10=dj.byId("column_label");if(_f&&_f.store&&_f.store._arrayOfAllItems){d.forEach(_f.store._arrayOfAllItems,function(_11){var _12=(dojo.isArray(_11.label)?_11.label[0]:_11.label);var _13=(dojo.isArray(_11.store_id)?_11.store_id[0]:_11.store_id);if(_12){var _14=_12.replace(/\s/g,"");var _15=_10.get("value").replace(/\s/g,"");if(m._config&&m._config.beneAdvColumnsDialogStoreId){if(_13&&_13!==m._config.beneAdvColumnsDialogStoreId&&_14===_15){m.showTooltip(m.getLocalization("beneAdvColumnExists"),_10.domNode,["above","before"]);_10.state="Error";_10._setStateClass();dj.setWaiState(_10.focusNode,"invalid","true");}}else{if(_14===_15){m.showTooltip(m.getLocalization("beneAdvColumnExists"),_10.domNode,["above","before"]);_10.state="Error";_10._setStateClass();dj.setWaiState(_10.focusNode,"invalid","true");}}}});}};d.mixin(m,{bind:function(){m.connect("customerOkButton","onMouseUp",_4);m.connect("all_entities","onClick",_1);m.connect("columnOkButton","onMouseUp",_9);m.connect("column_type","onChange",function(){dj.byId("column_type_label").set("value",dj.byId("column_type").get("displayedValue"));if(dj.byId("column_type").get("value")==="03"){dj.byId("column_width").set("value","");dj.byId("column_width").set("required",false);dj.byId("column_width").set("readOnly",true);}else{dj.byId("column_width").set("required",true);dj.byId("column_width").set("readOnly",false);}if(dj.byId("column_type").get("value")==="01"){dj.byId("column_width").set("constraints",{min:5});}else{dj.byId("column_width").set("constraints",{min:1});}});m.setValidation("column_label",m.validateAlphaNumericBeneAdv);m.connect("column_label","onBlur",_e);m.connect(dj.byId("columns").dialog,"onHide",function(){if(misys._config&&misys._config.beneAdvColumnsDialogStoreId){misys._config.beneAdvColumnsDialogStoreId=null;}});},onFormLoad:function(){_1();},beforeSubmitValidations:function(){var _16=dj.byId("columns").grid;if(!_16||_16.rowCount<1){m._config.onSubmitErrorMsg=m.getLocalization("columnsMandatory");return false;}if(!dj.byId("all_entities").get("checked")){var _17=dj.byId("customers").grid;if(!_17||_17.rowCount<1){m._config.onSubmitErrorMsg=m.getLocalization("associatedCustomersMandatory");return false;}}return true;},validateAlphaNumericBeneAdv:function(){var _18="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_ ";var _19;var _1a=d.every(this.get("value"),function(_1b){_19=_1b;return (_18.indexOf(_1b)<0)?false:true;});if(!_1a){this.invalidMessage=m.getLocalization("illegalCharError",[_19]);}return _1a;}});})(dojo,dijit,misys);dojo.require("misys.client.binding.system.beneficiary_advice_client");}