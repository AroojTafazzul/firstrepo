/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.openaccount.widget.FinalDestinationTransports"]){dojo._hasResource["misys.openaccount.widget.FinalDestinationTransports"]=true;dojo.provide("misys.openaccount.widget.FinalDestinationTransports");dojo.experimental("misys.openaccount.widget.FinalDestinationTransports");dojo.require("misys.grid.GridMultipleItems");dojo.require("misys.openaccount.widget.Transport");dojo.declare("misys.openaccount.widget.FinalDestinationTransports",[misys.grid.GridMultipleItems],{data:{identifier:"store_id",label:"store_id",items:[]},templatePath:null,templateString:dojo.byId("routing-summary-final-destination-template")?dojo.byId("routing-summary-final-destination-template").innerHTML:"",dialogId:"routing-summary-final-destination-dialog-template",xmlTagName:"transports",xmlSubTagName:"transport",gridColumns:["transport_id","transport_mode","transport_type","transport_sub_type","transport_sub_type_label","transport_group","final_place_name"],propertiesMap:{tnx_id:{_fieldName:"tnx_id"},ref_id:{_fieldName:"ref_id"},transport_id:{_fieldName:"final_destination_transport_id"},transport_mode:{_fieldName:"final_destination_transport_mode"},transport_type:{_fieldName:"transport_type"},transport_sub_type:{_fieldName:"final_destination_transport_sub_type"},transport_sub_type_label:{_fieldName:"final_destination_transport_sub_type_label"},transport_group:{_fieldName:"final_destination_transport_group"},final_place_name:{_fieldName:"final_destination_name"}},layout:[{name:"Destination",field:"final_place_name",width:"90%"},{name:" ",field:"actions",formatter:misys.grid.formatReportActions,width:"10%"}],startup:function(){this.dataList=[];if(this.hasChildren()){dojo.forEach(this.getChildren(),function(_1){if(_1.createItem){var _2=_1.createItem();this.dataList.push(_2);}},this);}this.inherited(arguments);}});}