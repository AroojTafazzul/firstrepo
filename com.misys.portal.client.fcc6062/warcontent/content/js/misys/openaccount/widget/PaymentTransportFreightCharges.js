/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.openaccount.widget.PaymentTransportFreightCharges"]){dojo._hasResource["misys.openaccount.widget.PaymentTransportFreightCharges"]=true;dojo.provide("misys.openaccount.widget.PaymentTransportFreightCharges");dojo.experimental("misys.openaccount.widget.PaymentTransportFreightCharges");dojo.require("misys.grid.GridMultipleItems");dojo.require("misys.openaccount.FormOpenAccountEvents");dojo.require("misys.openaccount.widget.PaymentTransportFreightCharge");dojo.declare("misys.openaccount.widget.PaymentTransportFreightCharges",[misys.grid.GridMultipleItems],{data:{identifier:"store_id",label:"store_id",items:[]},templatePath:null,templateString:dojo.byId("payment-transport-freight-charges-template").innerHTML,dialogId:"payment-transport-freight-charge-dialog-template",xmlTagName:"freightCharges",xmlSubTagName:"freightCharge",gridColumns:["type","type_label","other_type","cur_code","amt","type_hidden"],propertiesMap:{type:{_fieldName:"payment_transport_freight_charge_type"},type_label:{_fieldName:"payment_transport_freight_charge_type_label"},other_type:{_fieldName:"payment_transport_freight_charge_other_type"},cur_code:{_fieldName:"payment_transport_freight_charge_cur_code"},amt:{_fieldName:"payment_transport_freight_charge_amt"},type_hidden:{_fieldName:"type_hidden"}},layout:[{name:"Freight Charge Type",get:misys.getTransportFreightChargesType,field:"type_hidden",width:"35%"},{name:"Ccy",field:"cur_code",width:"15%"},{name:"Amount",get:misys.getFreightAmount,width:"40%"},{name:" ",field:"actions",formatter:misys.grid.formatReportActions,width:"10%"}],mandatoryFields:["type"],startup:function(){this.dataList=[];if(this.hasChildren()){dojo.forEach(this.getChildren(),function(_1){if(_1.createItem){var _2=_1.createItem();this.dataList.push(_2);}},this);}this.inherited(arguments);},openDialogFromExistingItem:function(_3,_4){if(misys._config.displayMode==="view"){misys.disconnectById("payment_transport_freight_charge_amt");}this.inherited(arguments);},resetDialog:function(_5){this.inherited(arguments);this.defaultFreightCharges();},defaultFreightCharges:function(){if(dijit.byId("total_cur_code")){dijit.byId("freight_charge_cur_code").set("value",dijit.byId("total_cur_code").get("value"));}},createDataGrid:function(){this.inherited(arguments);var _6=this.grid;misys.connect(_6,"onDelete",function(){misys.dialog.connect(dijit.byId("okButton"),"onMouseUp",function(){setTimeout(dojo.hitch(misys,"computeLineItemAmount"),1000);},"alertDialog");});},createItemsFromJson:function(_7){this.inherited(arguments);},updateData:function(_8){this.inherited(arguments);misys.computeLineItemAmount();misys.markFormDirty();},performValidation:function(){if(this.validateDialog(true)){if(dijit.byId("freight_charge_amt")&&isNaN(dijit.byId("freight_charge_amt").get("value"))&&dijit.byId("freight_charge_rate")&&isNaN(dijit.byId("freight_charge_rate").get("value"))){misys.dialog.show("ERROR",misys.getLocalization("addAmtOrRate"));}else{this.inherited(arguments);}}}});}