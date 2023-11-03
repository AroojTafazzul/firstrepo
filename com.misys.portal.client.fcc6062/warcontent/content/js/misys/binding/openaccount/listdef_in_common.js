/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.openaccount.listdef_in_common"]){dojo._hasResource["misys.binding.openaccount.listdef_in_common"]=true;dojo.provide("misys.binding.openaccount.listdef_in_common");dojo.require("dojo.data.ItemFileReadStore");dojo.require("dojo.data.ItemFileWriteStore");dojo.require("dijit.form.FilteringSelect");dojo.require("misys.form.MultiSelect");dojo.require("dijit.layout.TabContainer");dojo.require("misys.form.common");dojo.require("misys.validation.common");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.layout.ContentPane");dojo.require("misys.form.CurrencyTextBox");(function(d,dj,m){d.subscribe("ready",function(){d.query(".dojoxGrid").forEach(function(g){if(g.id!=="nonSignedFolders"){m.connect(g.id,"onRowMouseOver",m._config.showTermsAndConditions);m.connect(g.id,"onRowMouseOut",m._config.hideTermsAndConditions);}});});d.mixin(m,{bind:function(){m.setValidation("cur_code",m.validateCurrency);m.connect("cur_code","onChange",_1);m.connect("cur_code","onChange",function(){misys.setCurrency(this,["AmountRange","AmountRange2"]);});m.connect("submitButton","onClick",_2);}});d.mixin(m._config,{saveOpenAccount:function(_3,_4){var _5=[],_6="",_7="";if(dj.byId("nonSignedFolders")){if(dijit.byId("nonSignedFolders").selection.selectedIndex!==-1){if(dj.byId("referenceid")){_6=dj.byId("referenceid").get("value");}if(dj.byId("tnxid")){_7=dj.byId("tnxid").get("value");}}}d.query(".dojoxGrid").forEach(function(g){_5.push(dj.byId(g.id));});m.grid.processRecords(_5,"/screen/AjaxScreen/action/RunGroupSubmission?s=InvoiceScreen&operation=SAVE&option=IP_FOLDER&mode=DRAFT&tnxtype=01&referenceid="+_6+"&tnxid="+_7+"&programcode="+_3+"&sub_tnx_type_code="+_4);},submitOpenAccount:function(_8,_9){var _a=[],_b="",_c="";if(dj.byId("nonSignedFolders")){if(dijit.byId("nonSignedFolders").selection.selectedIndex!==-1){if(dj.byId("referenceid")){_b=dj.byId("referenceid").get("value");}if(dj.byId("tnxid")){_c=dj.byId("tnxid").get("value");}}}d.query(".dojoxGrid").forEach(function(g){_a.push(dj.byId(g.id));});var _d="/screen/AjaxScreen/action/RunGroupSubmission?s=InvoiceScreen&operation=SUBMIT&option=IP_FOLDER&mode=DRAFT&tnxtype=01&referenceid="+_b+"&tnxid="+_c+"&programcode="+_8;if(_9!==null){_d=_d+"&sub_tnx_type_code="+_9;}m.grid.processRecords(_a,_d);},showTermsAndConditions:function(_e){if(this.selection.selected[_e.rowIndex]&&this.selection.selected[_e.rowIndex]===true){var _f;var _10=this.store._items[_e.rowIndex].i["fscm_programme_code"];_f=this.store._items[_e.rowIndex].i["MyParty@ObjectDataString@conditions_"+_10];dj.showTooltip(_f,_e.cellNode,0);}},hideTermsAndConditions:function(evt){dj.hideTooltip(evt.cellNode);}});function _1(){if(dj.byId("cur_code").value!=""){dj.byId("AmountRangevisible").set("disabled",false);dj.byId("AmountRange2visible").set("disabled",false);}else{if(dj.byId("cur_code").value==""){dj.byId("AmountRangevisible").set("disabled",true);dj.byId("AmountRange2visible").set("disabled",true);dj.byId("AmountRangevisible").reset();dj.byId("AmountRange2visible").reset();}}};function _2(){if(dj.byId("AmountRangevisible")){var _11=dj.byId("AmountRangevisible").value;var _12=isNaN(_11)?0:_11;dj.byId("AmountRange").set("value",_11);var _13=dj.byId("AmountRange2visible").value;dj.byId("AmountRange2").set("value",_13);}};})(dojo,dijit,misys);dojo.require("misys.client.binding.openaccount.listdef_in_common_client");}