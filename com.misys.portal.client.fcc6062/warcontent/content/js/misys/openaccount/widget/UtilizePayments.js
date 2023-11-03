/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.openaccount.widget.UtilizePayments"]){dojo._hasResource["misys.openaccount.widget.UtilizePayments"]=true;dojo.provide("misys.openaccount.widget.UtilizePayments");dojo.experimental("misys.openaccount.widget.UtilizePayments");dojo.require("misys.grid.GridMultipleItems");dojo.require("misys.openaccount.widget.Payment");dojo.require("misys.openaccount.widget.Payments");dojo.require("misys.openaccount.FormOpenAccountEvents");dojo.declare("misys.openaccount.widget.UtilizePayments",[misys.openaccount.widget.Payments],{data:{identifier:"store_id",label:"store_id",items:[]},gridColumns:["code","payment_date","label","other_paymt_terms","nb_days","cur_code","amt","pct"],propertiesMap:{ref_id:{_fieldName:"ref_id"},tnx_id:{_fieldName:"tnx_id"},payment_id:{_fieldName:"payment_id"},payment_date:{_fieldName:"details_date"},code:{_fieldName:"details_code"},label:{_fieldName:"details_label"},other_paymt_terms:{_fieldName:"details_other_paymt_terms"},nb_days:{_fieldName:"details_nb_days"},cur_code:{_fieldName:"details_cur_code"},amt:{_fieldName:"details_amt"},pct:{_fieldName:"details_pct"}},layout:[{name:"Payment Type",get:misys.getPaymentType,width:"25%"},{name:"Ccy",field:"cur_code",width:"15%"},{name:"Amount/Rate",get:misys.getPaymentAmountRate,width:"25%"},{name:"Date",field:"payment_date",width:"25%"},{name:" ",field:"actions",formatter:misys.grid.formatReportActions,width:"10%"}],getMandatoryProperties:function(_1){var _2=[];_2.push("code");_2.push("payment_date");_2.push(_1.amt==""?"pct":"amt");return _2;},startup:function(){misys.animate("fadeIn",dojo.byId("po_payment_date"));misys.toggleRequired("details_date",true);this.inherited(arguments);},openDialogFromExistingItem:function(_3,_4){if(misys._config.displayMode==="view"){misys.disconnectById("details_amt");misys.disconnectById("details_pct");}this.inherited(arguments);}});}