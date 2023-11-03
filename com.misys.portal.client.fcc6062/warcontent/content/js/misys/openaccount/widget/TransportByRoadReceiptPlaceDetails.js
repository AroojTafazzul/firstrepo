/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.openaccount.widget.TransportByRoadReceiptPlaceDetails"]){dojo._hasResource["misys.openaccount.widget.TransportByRoadReceiptPlaceDetails"]=true;dojo.provide("misys.openaccount.widget.TransportByRoadReceiptPlaceDetails");dojo.experimental("misys.openaccount.widget.TransportByRoadReceiptPlaceDetails");dojo.require("misys.grid.GridMultipleItems");dojo.require("misys.openaccount.widget.TransportByRoadReceiptPlaceDetail");dojo.declare("misys.openaccount.widget.TransportByRoadReceiptPlaceDetails",[misys.grid.GridMultipleItems],{data:{identifier:"store_id",label:"store_id",items:[]},handle:null,templatePath:null,templateString:dojo.byId("transport-by-road-receipt-place-details-template")?dojo.byId("transport-by-road-receipt-place-details-template").innerHTML:"",xmlTagName:"road_receipt_places",xmlSubTagName:"road_receipt_place",gridColumns:["road_receipt_place_name","routing_summary_sub_type","ref_id","tnx_id"],propertiesMap:{ref_id:{_fieldName:"ref_id"},tnx_id:{_fieldName:"tnx_id"},road_receipt_place_name:{_fieldName:"road_receipt_place_name"},routing_summary_sub_type:{_fieldName:"road_receipt_place_rs_sub_type"}},layout:[{name:"Place Name",field:"road_receipt_place_name",width:"35%"},{name:" ",field:"actions",formatter:misys.grid.formatReportActions,width:"10%"},{name:"Id",field:"store_id",headerStyles:"display:none",cellStyles:"display:none"}],mandatoryFields:[],startup:function(){this.dataList=[];if(this.hasChildren()){dojo.forEach(this.getChildren(),function(_1){if(_1.createItem){var _2=_1.createItem();this.dataList.push(_2);}},this);}this.inherited(arguments);},openDialogFromExistingItem:function(_3,_4){this.inherited(arguments);},resetDialog:function(_5){this.inherited(arguments);},createItem:function(){if(this.hasChildren&&this.hasChildren()){var _6="misys.openaccount.widget.TransportByRoadReceiptPlaceDetails";var _7=[];dojo.forEach(this.getChildren(),function(_8){if(_8.createItem){_7.push(_8.createItem());}},this);var _9={_value:_7,_type:_6};var _a={};_a["road_receipt_place_details"]=_9;return _a;}return null;},addItem:function(_b){this.inherited(arguments);},createItemsFromJson:function(_c){this.inherited(arguments);},checkDialog:function(){if(!this.dialog){var _d=dijit.byId(this.dialogId);if(_d){this.dialog=_d;}else{var id=this.dialogId?this.dialogId:"dialog-"+dojox.uuid.generateRandomUuid();var _e=this.dialogClassName?this.dialogClassName:"misys.widget.Dialog";this.dialog=dojo.eval("new "+_e+"({}, dojo.byId('"+id+"'))");this.dialog.set("refocus",false);this.dialog.set("draggable",false);dojo.addClass(this.dialog.domNode,"multipleItemDialog");this.dialog.startup();document.body.appendChild(this.dialog.domNode);}}return this.dialog;},performValidation:function(){if(this.validateDialog(true)){if(dijit.byId("road_receipt_place_name")&&dijit.byId("road_receipt_place_name").get("value")===""){misys.dialog.show("ERROR",misys.getLocalization("emptyDialogSubmitError"));}else{this.inherited(arguments);}}}});}