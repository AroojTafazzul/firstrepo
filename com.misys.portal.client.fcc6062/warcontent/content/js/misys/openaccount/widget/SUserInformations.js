/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.openaccount.widget.SUserInformations"]){dojo._hasResource["misys.openaccount.widget.SUserInformations"]=true;dojo.provide("misys.openaccount.widget.SUserInformations");dojo.experimental("misys.openaccount.widget.SUserInformations");dojo.require("misys.grid.GridMultipleItems");dojo.require("misys.openaccount.widget.SUserInformation");dojo.declare("misys.openaccount.widget.SUserInformations",[misys.grid.GridMultipleItems],{data:{identifier:"store_id",label:"store_id",items:[]},templatePath:null,templateString:dojo.byId("po_seller-user-defined-template").innerHTML,dialogId:"po_seller-user-defined-dialog-template",xmlTagName:"seller_defined_informations",xmlSubTagName:"seller_defined_information",gridColumns:["user_id","info_id","label","information"],propertiesMap:{user_id:{_fieldName:"po_seller_user_id"},info_id:{_fieldName:"po_seller_info_id"},label:{_fieldName:"po_seller_label"},information:{_fieldName:"po_seller_information"}},layout:[{name:"Label",field:"label",width:"25%"},{name:"Information",field:"information",width:"65%"},{name:" ",field:"actions",formatter:misys.grid.formatReportActions,width:"10%"}],startup:function(){this.dataList=[];if(this.hasChildren()){dojo.forEach(this.getChildren(),function(_1){if(_1.createItem){var _2=_1.createItem();this.dataList.push(_2);}},this);}this.inherited(arguments);},openDialogFromExistingItem:function(_3,_4){this.inherited(arguments);},addItem:function(_5){this.inherited(arguments);},performValidation:function(){var _6=new RegExp(/^[a-zA-Z0-9][a-zA-Z0-9-+('.&\,@#$*) ]*$/g);if(this.validateDialog(true)){if((dijit.byId("po_seller_label")&&dijit.byId("po_seller_label").get("value")==="")&&(dijit.byId("po_seller_information")&&dijit.byId("po_seller_information").get("value")==="")){misys.dialog.show("ERROR",misys.getLocalization("addLabelOrInfo"));}else{if(_6.test(dijit.byId("po_seller_information").get("value"))){this.inherited(arguments);}else{misys.dialog.show("ERROR","The field contain non-supported characters.");this.focus();}}}misys.markFormDirty();}});}