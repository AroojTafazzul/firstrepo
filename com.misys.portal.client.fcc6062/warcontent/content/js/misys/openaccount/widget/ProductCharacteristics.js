/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.openaccount.widget.ProductCharacteristics"]){dojo._hasResource["misys.openaccount.widget.ProductCharacteristics"]=true;dojo.provide("misys.openaccount.widget.ProductCharacteristics");dojo.experimental("misys.openaccount.widget.ProductCharacteristics");dojo.require("misys.grid.GridMultipleItems");dojo.require("misys.openaccount.widget.ProductCharacteristic");dojo.declare("misys.openaccount.widget.ProductCharacteristics",[misys.grid.GridMultipleItems],{data:{identifier:"store_id",label:"store_id",items:[]},templatePath:null,templateString:dojo.byId("product-characteristics-template").innerHTML,dialogId:"product-characteristic-dialog-template",xmlTagName:"productCharacteristics",xmlSubTagName:"productCharacteristic",gridColumns:["type","type_label","other_type","description","goods_id","ref_id","tnx_id"],propertiesMap:{goods_id:{_fieldName:"goods_id"},ref_id:{_fieldName:"ref_id"},tnx_id:{_fieldName:"tnx_id"},type:{_fieldName:"product_characteristic_code"},type_label:{_fieldName:"product_characteristic_code_label"},other_type:{_fieldName:"product_characteristic_other_code"},description:{_fieldName:"product_characteristic_description"}},layout:[{name:"Code",field:"type_label",get:misys.grid.formatOpenAccountProductType,width:"30%"},{name:"Description",field:"description",width:"60%"},{name:" ",field:"actions",formatter:misys.grid.formatReportActions,width:"10%"},{name:"Id",field:"store_id",headerStyles:"display:none",cellStyles:"display:none"}],mandatoryFields:["type","description"],startup:function(){this.dataList=[];if(this.hasChildren()){dojo.forEach(this.getChildren(),function(_1){if(_1.createItem){var _2=_1.createItem();this.dataList.push(_2);}},this);}this.inherited(arguments);},openDialogFromExistingItem:function(_3,_4){this.inherited(arguments);},addItem:function(_5){this.inherited(arguments);},createItemsFromJson:function(_6){this.inherited(arguments);},performValidation:function(){if(this.validateDialog(true)){this.inherited(arguments);}}});}