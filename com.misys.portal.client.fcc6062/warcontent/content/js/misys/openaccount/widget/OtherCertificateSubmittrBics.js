/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.openaccount.widget.OtherCertificateSubmittrBics"]){dojo._hasResource["misys.openaccount.widget.OtherCertificateSubmittrBics"]=true;dojo.provide("misys.openaccount.widget.OtherCertificateSubmittrBics");dojo.experimental("misys.openaccount.widget.OtherCertificateSubmittrBics");dojo.require("misys.grid.GridMultipleItems");dojo.require("misys.openaccount.widget.OtherCertificateSubmittrBic");dojo.declare("misys.openaccount.widget.OtherCertificateSubmittrBics",[misys.grid.GridMultipleItems],{data:{identifier:"store_id",label:"store_id",items:[]},templatePath:null,templateString:dojo.byId("other-certificate-bic-template").innerHTML,dialogId:"other-certificate-bic-dialog-template",xmlTagName:"BICs",xmlSubTagName:"BIC",gridColumns:["ocds_bic"],propertiesMap:{BIC:{_fieldName:"ocds_bic"}},layout:[{name:"BIC",field:"ocds_bic",width:"35%"},{name:" ",field:"actions",formatter:misys.grid.formatReportActions,width:"10%"}],mandatoryFields:[],startup:function(){this.dataList=[];if(this.hasChildren()){dojo.forEach(this.getChildren(),function(_1){if(_1.createItem){var _2=_1.createItem();this.dataList.push(_2);}},this);}this.inherited(arguments);},createItem:function(){if(this.hasChildren&&this.hasChildren()){var _3="misys.openaccount.widget.OtherCertificateSubmittrBics";var _4=[];dojo.forEach(this.getChildren(),function(_5){if(_5.createItem){_4.push(_5.createItem());}},this);var _6={_value:_4,_type:_3};var _7={};_7["other_certificate_dataset_bic"]=_6;return _7;}return null;},openDialogFromExistingItem:function(_8,_9){this.inherited(arguments);},resetDialog:function(_a){this.inherited(arguments);},addItem:function(_b){this.inherited(arguments);},createItemsFromJson:function(_c){this.inherited(arguments);},performValidation:function(){if(this.validateDialog(true)){this.inherited(arguments);}}});}