/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.openaccount.widget.SeaRoutingSummaries"]){dojo._hasResource["misys.openaccount.widget.SeaRoutingSummaries"]=true;dojo.provide("misys.openaccount.widget.SeaRoutingSummaries");dojo.experimental("misys.openaccount.widget.SeaRoutingSummaries");dojo.require("misys.grid.GridMultipleItems");dojo.require("misys.openaccount.widget.RoutingSummary");dojo.declare("misys.openaccount.widget.SeaRoutingSummaries",[misys.grid.GridMultipleItems],{data:{identifier:"store_id",label:"store_id",items:[]},templatePath:null,templateString:dojo.byId("routing-summary-sea-template")?dojo.byId("routing-summary-sea-template").innerHTML:"",dialogId:"routing-summary-sea-dialog-template",xmlTagName:"routingSummaries",xmlSubTagName:"routingSummary",gridColumns:["routing_summary_mode","routing_summary_type","linked_ref_id","linked_tnx_id","sea_carrier_name","transport_by_sea_loading_ports","transport_by_sea_discharge_ports"],propertiesMap:{tnx_id:{_fieldName:"tnx_id"},ref_id:{_fieldName:"ref_id"},routing_summary_mode:{_fieldName:"sea_routing_summary_mode"},routing_summary_type:{_fieldName:"sea_routing_summary_type"},linked_ref_id:{_fieldName:"linked_ref_id"},linked_tnx_id:{_fieldName:"linked_tnx_id"},sea_carrier_name:{_fieldName:"sea_carrier_name"},transport_by_sea_loading_ports:{_fieldName:"transport_by_sea_loading_ports",_type:"misys.openaccount.widget.TransportBySeaLoadingPortDetails"},transport_by_sea_discharge_ports:{_fieldName:"transport_by_sea_discharge_ports",_type:"misys.openaccount.widget.TransportBySeaDischargePortDetails"}},layout:[{name:"Sea Carrier Name",field:"sea_carrier_name",width:"75%"},{name:" ",field:"actions",formatter:misys.grid.formatReportActions,width:"10%"},{name:"Id",field:"store_id",headerStyles:"display:none",cellStyles:"display:none"}],typeMap:{"misys.openaccount.widget.TransportBySeaLoadingPortDetails":{"type":Array,"deserialize":function(_1){var _2={};_2._type="misys.openaccount.widget.TransportBySeaLoadingPortDetails";_2._values=_1;return _2;}},"misys.openaccount.widget.TransportBySeaDischargePortDetails":{"type":Array,"deserialize":function(_3){var _4={};_4._type="misys.openaccount.widget.TransportBySeaDischargePortDetails";_4._values=_3;return _4;}}},mandatoryFields:[],startup:function(){this.inherited(arguments);},openDialogFromExistingItem:function(_5,_6){this.inherited(arguments);},resetDialog:function(_7,_8){this.inherited(arguments);},addItem:function(_9){if(this.id.match("^line_item_")=="line_item_"){if(misys.checkPOChildrens()){misys.dialog.show("ERROR",misys.getLocalization("tooManyPODetailsError"));return;}}else{if(misys.checkLineItemChildrens()){misys.dialog.show("ERROR",misys.getLocalization("tooManyPODetailsError"));return;}}this.inherited(arguments);},createDataGrid:function(){this.inherited(arguments);var _a=this.grid;var _b=dijit.byId("air_routing_summaries");var _c=dijit.byId("sea_routing_summaries");var _d=dijit.byId("road_routing_summaries");var _e=dijit.byId("rail_routing_summaries");var _f=dijit.byId("line_item_air_routing_summaries");var _10=dijit.byId("line_item_sea_routing_summaries");var _11=dijit.byId("line_item_road_routing_summaries");var _12=dijit.byId("line_item_rail_routing_summaries");misys.connect(_a,"onDelete",function(){misys.dialog.connect(dijit.byId("okButton"),"onMouseUp",function(){_f.addButtonNode.set("disabled",false);_10.addButtonNode.set("disabled",false);_11.addButtonNode.set("disabled",false);_12.addButtonNode.set("disabled",false);_b.addButtonNode.set("disabled",false);_c.addButtonNode.set("disabled",false);_d.addButtonNode.set("disabled",false);_e.addButtonNode.set("disabled",false);},"alertDialog");});},performValidation:function(){var _13=dijit.byId("transport_by_sea_discharge_ports");if(_13&&(_13.store===null||(_13.store&&(_13.store._arrayOfAllItems.length===0||(_13.store._arrayOfAllItems.length===1&&_13.store._arrayOfAllItems[0]===null))))){misys.dialog.show("ERROR",misys.getLocalization("transportBySeaDischMandatoryError"));return;}if(this.validateDialog(true)){this.inherited(arguments);}},updateData:function(){this.inherited(arguments);var _14=dijit.byId("air_routing_summaries");var _15=dijit.byId("sea_routing_summaries");var _16=dijit.byId("road_routing_summaries");var _17=dijit.byId("rail_routing_summaries");var _18=dijit.byId("line_item_air_routing_summaries");var _19=dijit.byId("line_item_sea_routing_summaries");var _1a=dijit.byId("line_item_road_routing_summaries");var _1b=dijit.byId("line_item_rail_routing_summaries");if(dijit.byId("tran_ship_2")&&dijit.byId("tran_ship_2").get("checked")===true){var _1c=dijit.byId("line_item_sea_routing_summaries");if(_1c&&_1c.store&&_1c.store._arrayOfTopLevelItems.length>0){if(_18&&_18.addButtonNode){_18.addButtonNode.set("disabled",true);}if(_19&&_19.addButtonNode){_19.addButtonNode.set("disabled",true);}if(_1a&&_1a.addButtonNode){_1a.addButtonNode.set("disabled",true);}if(_1b&&_1b.addButtonNode){_1b.addButtonNode.set("disabled",true);}}else{if(_14&&_14.addButtonNode){_14.addButtonNode.set("disabled",true);}if(_15&&_15.addButtonNode){_15.addButtonNode.set("disabled",true);}if(_16&&_16.addButtonNode){_16.addButtonNode.set("disabled",true);}if(_17&&_17.addButtonNode){_17.addButtonNode.set("disabled",true);}}}}});}