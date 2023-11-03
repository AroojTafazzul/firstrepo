/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.openaccount.listdef_in_message"]){dojo._hasResource["misys.binding.openaccount.listdef_in_message"]=true;dojo.provide("misys.binding.openaccount.listdef_in_message");dojo.require("dojo.data.ItemFileReadStore");dojo.require("dojo.data.ItemFileWriteStore");dojo.require("dijit.form.FilteringSelect");dojo.require("misys.form.MultiSelect");dojo.require("dijit.layout.TabContainer");dojo.require("misys.form.common");dojo.require("misys.validation.common");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.layout.ContentPane");dojo.require("misys.form.CurrencyTextBox");(function(d,dj,m){d.subscribe("ready",function(){d.query(".dojoxGrid").forEach(function(g){if(g.id!=="nonSignedFolders"){m.connect(g.id,"onRowMouseOver",m._config.showTermsAndConditions);m.connect(g.id,"onRowMouseOut",m._config.hideTermsAndConditions);}});});d.mixin(m,{bind:function(){m.setValidation("cur_code",m.validateCurrency);m.connect("cur_code","onChange",_1);m.connect("cur_code","onChange",function(){misys.setCurrency(this,["AmountRange","AmountRange2"]);});m.connect("submitButton","onClick",_2);}});d.mixin(m._config,{submitOpenAccount:function(_3,_4){var _5=[],_6="",_7="";if(dj.byId("nonSignedFolders")){if(dijit.byId("nonSignedFolders").selection.selectedIndex!==-1){if(dj.byId("referenceid")){_6=dj.byId("referenceid").get("value");}if(dj.byId("tnxid")){_7=dj.byId("tnxid").get("value");}}}d.query(".dojoxGrid").forEach(function(g){_5.push(dj.byId(g.id));});m.grid.processRecords(_5,"/screen/AjaxScreen/action/RunGroupSubmission?s=InvoiceScreen&operation=SUBMIT&option=IN_EARLY_PAYMENT_REQUEST&mode=DRAFT&tnxtype=13&referenceid="+_6+"&tnxid="+_7+"&programcode="+_3+"&sub_tnx_type_code="+_4);},showTermsAndConditions:function(_8){if(this.selection.selected[_8.rowIndex]&&this.selection.selected[_8.rowIndex]===true){var _9;var _a=this.store._items[_8.rowIndex].i["fscm_programme_code"];_9=this.store._items[_8.rowIndex].i["MyParty@ObjectDataString@conditions_"+_a];dj.showTooltip(_9,_8.cellNode,0);}},hideTermsAndConditions:function(_b){dj.hideTooltip(_b.cellNode);}});function _1(){if(dj.byId("cur_code").value!=""){dj.byId("AmountRangevisible").set("disabled",false);dj.byId("AmountRange2visible").set("disabled",false);}else{if(dj.byId("cur_code").value==""){dj.byId("AmountRangevisible").set("disabled",true);dj.byId("AmountRange2visible").set("disabled",true);dj.byId("AmountRangevisible").reset();dj.byId("AmountRange2visible").reset();}}};function _2(){if(dj.byId("AmountRangevisible")){var _c=dj.byId("AmountRangevisible").value;var _d=isNaN(_c)?0:_c;dj.byId("AmountRange").set("value",_c);var _e=dj.byId("AmountRange2visible").value;dj.byId("AmountRange2").set("value",_e);}};})(dojo,dijit,misys);dojo.require("misys.client.binding.openaccount.listdef_in_message_client");}