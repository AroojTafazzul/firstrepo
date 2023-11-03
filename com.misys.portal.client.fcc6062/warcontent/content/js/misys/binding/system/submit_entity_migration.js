/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.system.submit_entity_migration"]){dojo._hasResource["misys.binding.system.submit_entity_migration"]=true;dojo.provide("misys.binding.system.submit_entity_migration");dojo.require("misys.widget.Dialog");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.form.FilteringSelect");dojo.require("dijit.form.Form");dojo.require("dijit.form.NumberTextBox");dojo.require("misys.form.CurrencyTextBox");dojo.require("dijit.form.DateTextBox");dojo.require("misys.grid.DataGrid");dojo.require("misys.form.common");dojo.require("misys.validation.common");(function(d,dj,m){function _1(_2,_3){if(_2&&_3&&_2.get("value")==null&&_3.get("value")==null){return true;}var _4;if(!m.compareDateFields(_2,_3)){_4=misys.getLocalization("validFromDateGreaterThanValidToDateError",[_2.get("displayedValue"),_3.get("displayedValue")]);_2.set("state","Error");dj.hideTooltip(_2.domNode);dj.showTooltip(_4,_2.domNode,0);return false;}return true;};function _5(_6,_7){if(_6&&_7&&_6.get("value")==null&&_7.get("value")==null){return true;}var _8;if(!m.compareDateFields(_6,_7)){_8=misys.getLocalization("validFromDateGreaterThanValidToDateError",[_6.get("displayedValue"),_7.get("displayedValue")]);_7.set("state","Error");dj.hideTooltip(_7.domNode);dj.showTooltip(_8,_7.domNode,0);return false;}return true;};d.mixin(m._config,{fncSubmitMultipleEntityMigration:function(){var _9=[],_a="",_b=dj.byId("entityId");if(_b&&_b.get("value")+"S"==="S"){_b.state="Error";_b.focus();misys.dialog.show("ERROR",misys.getLocalization("entityNotSelectedError"));}else{if(_b){var _c=dj.byId("entityMigrationTnxGrid");if(_c&&_c.selection.getSelected().length===0){m.dialog.show("ERROR",m.getLocalization("noTransactionsSelectedError"));return;}_9.push(_c);var _d="/screen/AjaxScreen/action/EntityMigrationMultipleSubmission?entity="+_b.get("value");m.dialog.show("CONFIRMATION",m.getLocalization("submitTransactionsConfirmation",[_c.selection.getSelected().length]),"",function(){m.grid.processRecords(_9,_d);});}}}});d.mixin(m,{bind:function(){m.setValidation("currency",m.validateCurrency);m.setValidation("facility_ccy",m.validateCurrency);m.connect("creation_date_FROM","onBlur",function(){_1(this,dj.byId("creation_date_TO"));});m.connect("creation_date_TO","onBlur",function(){_5(dj.byId("creation_date_FROM"),this);});m.connect("facilityReviewFromDate","onBlur",function(){_1(this,dj.byId("facilityReviewToDate"));});m.connect("facilityReviewToDate","onBlur",function(){_5(dj.byId("facilityReviewFromDate"),this);});}});})(dojo,dijit,misys);}