/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.openaccount.listdef_ip_common"]){dojo._hasResource["misys.binding.openaccount.listdef_ip_common"]=true;dojo.provide("misys.binding.openaccount.listdef_ip_common");dojo.require("dojo.data.ItemFileReadStore");dojo.require("dojo.data.ItemFileWriteStore");dojo.require("dijit.form.FilteringSelect");dojo.require("misys.form.MultiSelect");dojo.require("dijit.layout.TabContainer");dojo.require("misys.form.common");dojo.require("misys.validation.common");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.layout.ContentPane");dojo.require("misys.form.CurrencyTextBox");(function(d,dj,m){d.subscribe("ready",function(){d.query(".dojoxGrid").forEach(function(g){if(g.id!=="nonSignedFolders"){m.connect(g.id,"onRowMouseOver",m._config.showTermsAndConditions);m.connect(g.id,"onRowMouseOut",m._config.hideTermsAndConditions);}});});d.mixin(m,{bind:function(){m.setValidation("cur_code",m.validateCurrency);m.connect("cur_code","onChange",_1);m.connect("cur_code","onChange",function(){misys.setCurrency(this,["AmountRange","AmountRange2"]);});m.connect("submitButton","onClick",_2);}});d.mixin(m._config,{saveOpenAccount:function(_3){var _4=[],_5="",_6="";if(dj.byId("nonSignedFolders")){if(dijit.byId("nonSignedFolders").selection.selectedIndex!==-1){if(dj.byId("referenceid")){_5=dj.byId("referenceid").get("value");}if(dj.byId("tnxid")){_6=dj.byId("tnxid").get("value");}}}d.query(".dojoxGrid").forEach(function(g){_4.push(dj.byId(g.id));});m.grid.processRecords(_4,"/screen/AjaxScreen/action/RunGroupSubmission?s=InvoicePayableScreen&operation=SAVE&option=IP_FOLDER&mode=DRAFT&tnxtype=01&referenceid="+_5+"&tnxid="+_6+"&programcode="+_3);},submitOpenAccount:function(_7){var _8=[],_9="",_a="";if(dj.byId("nonSignedFolders")){if(dijit.byId("nonSignedFolders").selection.selectedIndex!==-1){if(dj.byId("referenceid")){_9=dj.byId("referenceid").get("value");}if(dj.byId("tnxid")){_a=dj.byId("tnxid").get("value");}}}d.query(".dojoxGrid").forEach(function(g){_8.push(dj.byId(g.id));});m.grid.processRecords(_8,"/screen/AjaxScreen/action/RunGroupSubmission?s=InvoicePayableScreen&operation=SUBMIT&option=IP_FOLDER&mode=DRAFT&tnxtype=01&referenceid="+_9+"&tnxid="+_a+"&programcode="+_7);},showTermsAndConditions:function(_b){if(this.selection.selected[_b.rowIndex]&&this.selection.selected[_b.rowIndex]===true){var _c=this.store._items[_b.rowIndex].i["Counterparty@ObjectDataString@conditions_01"];dj.showTooltip(_c,_b.cellNode,0);}},hideTermsAndConditions:function(_d){dj.hideTooltip(_d.cellNode);}});function _1(){if(dj.byId("cur_code").value!=""){dj.byId("AmountRangevisible").set("disabled",false);dj.byId("AmountRange2visible").set("disabled",false);}else{if(dj.byId("cur_code").value==""){dj.byId("AmountRangevisible").set("disabled",true);dj.byId("AmountRange2visible").set("disabled",true);dj.byId("AmountRangevisible").reset();dj.byId("AmountRange2visible").reset();}}};function _2(){if(dj.byId("AmountRangevisible")){var _e=dj.byId("AmountRangevisible").value;var _f=isNaN(_e)?0:_e;dj.byId("AmountRange").set("value",_e);var _10=dj.byId("AmountRange2visible").value;dj.byId("AmountRange2").set("value",_10);}};})(dojo,dijit,misys);dojo.require("misys.client.binding.openaccount.listdef_ip_common_client");}