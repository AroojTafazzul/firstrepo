/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.cash.account_statement_search"]){dojo._hasResource["misys.binding.cash.account_statement_search"]=true;dojo.provide("misys.binding.cash.account_statement_search");dojo.require("misys.validation.common");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("dijit.form.Select");dojo.require("misys.form.common");dojo.require("dijit.Tooltip");dojo.require("misys.widget.Dialog");(function(d,dj,m){var _1=true;var _2=["Current Day","Previous Day","Current Month","Previous Month","dateRange"];function _3(){var _4=dj.byId("export_list_option");if(_4!="screen"){var _5="AccountStatement."+_4;dj.byId("filename_option").set("value",_5);}};function _6(){if((dj.byId("from_date").get("value")!==""&&dj.byId("to_date").get("value")!=="")&&(dj.byId("from_date").get("value")!==null&&dj.byId("to_date").get("value")!==null)){var _7=dj.byId("from_date");var to=dj.byId("to_date");var _8=m.localizeDate(_7);var _9=m.localizeDate(to);var _a=((_9.getTime()-_8.getTime())/(1000*60*60*24));var _b=parseInt(dj.byId("limit_range").getValue(),10);if(!m.compareDateFields(_7,to)){this.invalidMessage=m.getLocalization("toDateGreaterThanFromDateError",[dj.byId("from_date").get("displayedValue"),dj.byId("to_date").get("displayedValue")]);m.showTooltip(m.getLocalization("toDateGreaterThanFromDateError",[dj.byId("to_date").get("displayedValue"),dj.byId("from_date").get("displayedValue")]),d.byId("to_date"),["below"]);return false;}if(_a>_b){this.invalidMessage=m.getLocalization("actualRangeGreaterThanLimitRangeError",[dj.byId("limit_range").get("displayedValue")]);m.showTooltip(m.getLocalization("actualRangeGreaterThanLimitRangeError",[dj.byId("limit_range").get("displayedValue")]),d.byId("to_date"),["below"]);return false;}else{dojo.query("input:submit","TransactionSearchForm").removeAttr("disabled");return true;}}};function _c(){var to=dj.byId("to_date");var _d=dj.byId("today");var _e=misys.getLocalization("requiredToolTip");if((to.get("value")==="")||(to.get("value")===null)){to.set("state","Error");dj.hideTooltip(to.domNode);dj.showTooltip(_e,to.domNode,0);var _f=function(){dj.hideTooltip(to.domNode);};setTimeout(_f,1500);return false;}else{if(!m.compareDateFields(to,_d)){to.set("state","Error");this.invalidMessage=m.getLocalization("toDateLessThanOrEqualToTodaysDateError",[dj.byId("to_date").get("displayedValue"),dj.byId("today").get("value")]);m.showTooltip(m.getLocalization("toDateLessThanOrEqualToTodaysDateError",[dj.byId("to_date").get("displayedValue"),dj.byId("today").get("value")]),d.byId("to_date"),["below"]);return false;}else{dojo.query("input:submit","TransactionSearchForm").removeAttr("disabled");return true;}}};function _10(){d.forEach(_2,function(_11,i){if(dj.byId(_11)){if(dj.byId(_11).get("checked")){dj.byId("rangeOption").set("value",i+1);}}});};function _12(){var _13=dj.byId("from_date");var _14=misys.getLocalization("requiredToolTip");if((_13.get("value")==="")||(_13.get("value")===null)){_13.set("state","Error");dj.hideTooltip(_13.domNode);dj.showTooltip(_14,_13.domNode,0);var _15=function(){dj.hideTooltip(_13.domNode);};setTimeout(_15,1500);return false;}else{if((dj.byId("from_date").get("value")!=="")&&(dj.byId("from_date").get("value")!==null)){var _16=dj.byId("today");if(!m.compareDateFields(_13,_16)){_13.set("state","Error");this.invalidMessage=m.getLocalization("fromDateLessThanOrEqualToTodaysDateError",[dj.byId("from_date").get("displayedValue"),dj.byId("today").get("value")]);m.showTooltip(m.getLocalization("fromDateLessThanOrEqualToTodaysDateError",[dj.byId("from_date").get("displayedValue"),dj.byId("today").get("value")]),d.byId("from_date"),["below"]);return false;}}else{dojo.query("input:submit","TransactionSearchForm").removeAttr("disabled");return true;}}};function _17(){var _18;var _19=/^[^\*]/;var _1a=dj.byId("entity");var _1b;if(_1a){if(dj.byId("entity").get("value")!==""&&dj.byId("entity").get("value").search(_19)===-1){dj.byId("entity").set("value","");dijit.byId("entity").focus();m.showTooltip(m.getLocalization("entityInputError"),d.byId("entity"),0);_18=function(){dj.hideTooltip(dijit.byId("entity").domNode);};setTimeout(_18,1500);return false;}else{if(dj.byId("entity").get("value")===""){_1b=misys.getLocalization("mandatoryEntMessage",[dijit.byId("entity").get("value")]);dijit.byId("entity").focus();dijit.hideTooltip(dijit.byId("entity").domNode);dijit.showTooltip(_1b,dijit.byId("entity").domNode,0);_18=function(){dj.hideTooltip(dijit.byId("entity").domNode);};setTimeout(_18,1500);return false;}}}else{if(dj.byId("account_no").get("value")!==""&&dj.byId("account_no").get("value").search(_19)===-1){dj.byId("account_no").set("value","");dijit.byId("account_no").focus();m.showTooltip(m.getLocalization("accountInputError"),d.byId("account_no"),0);_18=function(){dj.hideTooltip(dijit.byId("account_no").domNode);};setTimeout(_18,1500);return false;}else{if(dj.byId("account_no").get("value")===""){_1b=misys.getLocalization("mandatoryAcctNumberMessage",[dijit.byId("account_no").get("value")]);dijit.byId("account_no").focus();dijit.hideTooltip(dijit.byId("account_no").domNode);dijit.showTooltip(_1b,dijit.byId("account_no").domNode,0);_18=function(){dj.hideTooltip(dijit.byId("account_no").domNode);};setTimeout(_18,1500);return false;}}}return true;};function _1c(url,_1d,_1e){var _1f=_1d||misys.getLocalization("transactionPopupWindowTitle"),_20=_1e||"width=800,height=500,resizable=yes,scrollbars=yes",_21=d.global.open(url,_1f,_20);if(!_21.opener){_21.opener=self;}_21.focus();};function _22(_23){if(dj.byId(_23)&&(dj.byId(_23).get("value")==""||dj.byId(_23).get("value")==null)){dj.byId(_23).set("state","Error");this.invalidMessage=m.getLocalization("awbToolTip",[dj.byId(_23).get("displayedValue"),dj.byId(_23).get("value")]);m.showTooltip(m.getLocalization("awbToolTip",[dj.byId(_23).get("displayedValue"),dj.byId(_23).get("value")]),d.byId(_23),["below"]);return false;}return true;};function _24(){var _25=null;var _26=null;if(dj.byId("bank_abbv_name")){_26=dj.byId("bank_abbv_name");}if(dj.byId("entity")&&dj.byId("entity").get("value")!==""){_25=dj.byId("entity").get("value");}else{_25="All";}if(misys._config.entityBanksMap){var _27=null;_27=m._config.entityBanksMap[_25];if(_27&&_26){_26.store=new dojo.data.ItemFileReadStore({data:{identifier:"value",label:"name",items:_27}});_26.fetchProperties={sort:[{attribute:"name"}]};}}};function _28(){var _29=dj.byId("bank_abbv_name").get("value");if(misys&&misys._config&&misys._config.businessDateForBank&&misys._config.businessDateForBank[_29][0]&&misys._config.businessDateForBank[_29][0].value!==""){var _2a=misys._config.businessDateForBank[_29][0].value;var _2b=_2a.substring(0,4);var _2c=_2a.substring(5,7);var _2d=_2a.substring(8,10);var _2e=_2d+"/"+_2c+"/"+_2b;var _2f=new Date(_2b,_2c-1,_2d);_2f.setDate(_2f.getDate()-1);_2f=_2f.getDate()+"/"+(_2f.getMonth()+1)+"/"+_2f.getFullYear();var _30=new Date(_2b,_2c-1,1);_30=_30.getDate()+"/"+(_30.getMonth()+1)+"/"+_30.getFullYear();var _31=new Date(_2b,_2c-2,1);var _32=new Date(_31.getFullYear(),_31.getMonth()+1,0);_31=_31.getDate()+"/"+(_31.getMonth()+1)+"/"+_31.getFullYear();_32=_32.getDate()+"/"+(_32.getMonth()+1)+"/"+_32.getFullYear();dj.byId("today").set("value",_2e);dj.byId("yesterday").set("value",_2f);dj.byId("currentMonthStart").set("value",_30);dj.byId("previousMonthStart").set("value",_31);dj.byId("previousMonthEnd").set("value",_32);}if(_1&&dj.byId("account_no")){dj.byId("account_no").set("value","");}_1=true;};d.mixin(m,{openAccountDetails:function(_33,_34){var _35="/screen/AjaxScreen/action/AccountAdditionalDetailsAction";var _36={};var _37=m.getLocalization("accountDetailsTitle");_36.accountfeatureid=_33;_36.custentity=_34;var _38=new dj.Dialog({id:"account_details_dialog",title:_37,ioMethod:misys.xhrPost,ioArgs:{content:_36},href:m.getServletURL(_35),style:"width: 640px;height:auto"});_38.connect(_38,"hide",function(e){dj.byId("account_details_dialog").destroy();});_38.show();},bind:function(){m.connect("dateRange","onChange",function(){if(dj.byId("dateRange").get("checked")){dj.byId("from_date").set("displayedValue","");dj.byId("to_date").set("displayedValue","");dj.byId("from_date").set("disabled",false);dj.byId("to_date").set("disabled",false);m.toggleRequired("from_date",true);m.toggleRequired("to_date",true);}else{dj.byId("from_date").set("disabled",true);dj.byId("to_date").set("disabled",true);m.toggleRequired("from_date",false);m.toggleRequired("to_date",false);}});m.connect("account_no","onChange",_17);m.connect("account_no","onChange",function(){dj.byId("account_no").set("state","");});m.connect("Current Day","onChange",function(){if(dj.byId("Current Day").get("checked")){dj.byId("create_date").set("displayedValue",dj.byId("today").get("value"));dj.byId("create_date2").set("displayedValue",dj.byId("today").get("value"));}});m.connect("Previous Day","onChange",function(){if(dj.byId("Previous Day").get("checked")){dj.byId("create_date").set("displayedValue",dj.byId("yesterday").get("value"));dj.byId("create_date2").set("displayedValue",dj.byId("yesterday").get("value"));}});m.connect("Current Month","onChange",function(){if(dj.byId("Current Month").get("checked")){if(dj.byId("currentMonthStart").get("value")===dj.byId("today").get("value")){dj.byId("create_date").set("displayedValue",dj.byId("today").get("value"));dj.byId("create_date2").set("displayedValue",dj.byId("today").get("value"));}else{dj.byId("create_date").set("displayedValue",dj.byId("currentMonthStart").get("value"));dj.byId("create_date2").set("displayedValue",dj.byId("today").get("value"));}}});m.connect("Previous Month","onChange",function(){if(dj.byId("Previous Month").get("checked")){dj.byId("create_date").set("displayedValue",dj.byId("previousMonthStart").get("value"));dj.byId("create_date2").set("displayedValue",dj.byId("previousMonthEnd").get("value"));}});if(d.byId("TransactionSearchForm")){m.connect("TransactionSearchForm","onSubmit",function(e){var _39=dj.byId("entity"),_3a=dj.byId("account_no"),_3b="";var _3c;if(_39){if(e&&(_3a.get("value")===""||_39.get("value")==="")){_17();e.preventDefault();}_3b=misys.getLocalization("accountStatementErrorToolTip",[_39.get("value"),_3a.get("value")]);if("S"+_39.get("value")==="S"){_39.set("focus",true);_39.set("state","Error");dj.hideTooltip(_39.domNode);dj.showTooltip(_3b,_39.domNode,0);_3c=function(){dj.hideTooltip(_39.domNode);};setTimeout(_3c,1500);}}if(e&&(_3a.get("value")==="")){_17();e.preventDefault();}_3b=misys.getLocalization("accountStatementErrorToolTip",[_3a.get("value")]);if(dj.byId("export_list").get("value")==="screen"){dj.byId("export_list").set("value","");}if(!(dj.byId("account_id")&&dj.byId("account_id").get("value"))){if("S"+_3a.get("value")==="S"){_3a.set("focus",true);_3a.set("state","Error");dj.hideTooltip(_3a.domNode);dj.showTooltip(_3b,_3a.domNode,0);_3c=function(){dj.hideTooltip(_3a.domNode);};setTimeout(_3c,1500);}}if(dj.byId("dateRange").get("checked")&&(dj.byId("from_date").get("displayedValue")===""||dj.byId("to_date").get("displayedValue")==="")){m.toggleRequired("from_date",true);m.toggleRequired("to_date",true);_12();_c();_6();e.preventDefault();}if(dj.byId("dateRange")&&(dj.byId("dateRange").get("checked")&&!_6())){e.preventDefault();d.stopEvent(e);if(!d.every(["from_date","to_date"],_22)){d.stopEvent(e);}}});}m.connect("from_date","onChange",function(){_12();_6();if(dj.byId("from_date")){dj.byId("create_date").set("value",dj.byId("from_date").get("value"));}});m.connect("to_date","onChange",function(){var res=_c();if(res){_6();if(dj.byId("to_date")){dj.byId("create_date2").set("value",dj.byId("to_date").get("value"));}}});m.connect("account_type","onChange",function(){if(dj.byId("account_type").get("value")==="02"){dj.byId("dateRange").reset();d.style("dateRanges","display","none");d.style("note_div","display","none");}else{d.style("note_div","display","block");d.style("dateRanges","display","block");}});m.connect("entity","onChange",function(){if(dj.byId("entity").get("value")==="*"||dj.byId("entity").get("value")==="**"){dj.byId("entity").set("value","");dijit.byId("entity").focus();m.showTooltip(m.getLocalization("entityInputError"),d.byId("entity"),0);}if(dj.byId("account_no")){dj.byId("account_no").set("value","");dj.byId("account_id").set("value","");}if(dj.byId("bank_abbv_name")){dj.byId("bank_abbv_name").set("value","");}if(dj.byId("entity").get("value")!==""){dj.byId("entity").set("state","");dj.byId("account_no").set("state","");}_24();});d.query(".dojoxGrid").forEach(function(g){m.connect(g.id,"_onFetchComplete",function(){m.resizeGrids();});});},exportABStatementListToFormat:function(_3d){_3d=_3d.toUpperCase();_10();var url=["/screen/AccountBalanceScreen?operation=LIST_STATEMENTS"];url.push("&export_list_option=",_3d);url.push("&filename=","AccountStatement.pdf");url.push("&in_memory_export=","true");url.push("&type=","export");if(dj.byId("entity")){url.push("&entity=",dj.byId("entity").get("value"));}url.push("&account_no=",dj.byId("account_no").get("value"));url.push("&stmtrange=",dj.byId("rangeOption").get("value"));url.push("&create_date=",dj.byId("create_date").get("displayedValue"));url.push("&create_date2=",dj.byId("create_date2").get("displayedValue"));url.push("&owner_type=",dj.byId("owner_type").get("value"));url.push("&bic_code=",dj.byId("bic_code").get("value"));_1c(misys.getServletURL(url.join("")));},onFormLoad:function(){m.connect("export_list_option","onChange",_3);m.connect("bank_abbv_name","onChange",_28);d.style("rangeParametersDiv","display","none");if(!dj.byId("dateRange").get("checked")&&dj.byId("from_date")&&dj.byId("to_date")){dj.byId("from_date").reset();dj.byId("to_date").reset();dj.byId("from_date").set("disabled",true);dj.byId("to_date").set("disabled",true);}if(dj.byId("bank_abbv_name")&&dj.byId("bank_abbv_name").get("value")===""){dj.byId("bank_abbv_name").set("required",false);}var _3e=false;d.forEach(_2,function(_3f,i){if(dj.byId(_3f)){if(dj.byId(_3f).get("checked")){_3e=true;}}});if(!dj.byId("dateRange").get("checked")){if(!_3e){dj.byId("Previous Day").set("checked",true);}}if(dj.byId("account_type").get("value")==="02"){dj.byId("dateRange").reset();d.style("dateRanges","display","none");}m.toggleRequired("entity",true);m.toggleRequired("account_no",true);_24();if(dj.byId("bank_name_hidden")&&dj.byId("bank_name_hidden").get("value")!==""&&dj.byId("bank_abbv_name")){if(dj.byId("bank_abbv_name").get("value")===""){_1=false;}dj.byId("bank_abbv_name").set("value",dj.byId("bank_name_hidden").get("value"));}m.toggleRequired("entity",true);if(dj.byId("account_no").get("value")===""&&_1==="true"){m.dialog.show("ERROR",m.getLocalization("accountInputError"));return;}m.connect("account_no","onChange",function(){if(dj.byId("bank_abbv_name")&&dj.byId("account_no")&&dj.byId("account_no").get("value")!==""&&dj.byId("bank_abbv_name").get("value")===""){_1=false;dj.byId("bank_abbv_name").set("value",m._config.customerBankName);}});}});})(dojo,dijit,misys);dojo.require("misys.client.binding.cash.account_statement_search_client");}