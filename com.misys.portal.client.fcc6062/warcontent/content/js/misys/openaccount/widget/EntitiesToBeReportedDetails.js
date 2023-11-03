/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.openaccount.widget.EntitiesToBeReportedDetails"]){dojo._hasResource["misys.openaccount.widget.EntitiesToBeReportedDetails"]=true;dojo.provide("misys.openaccount.widget.EntitiesToBeReportedDetails");dojo.experimental("misys.openaccount.widget.EntitiesToBeReportedDetails");dojo.require("misys.grid.GridMultipleItems");dojo.require("misys.openaccount.widget.EntitiesToBeReportedDetail");function _doesBICExists(_1){var _2=false;var _3=dijit.byId("submitter_bic").get("value");for(var i=0;i<_1.length;i++){if(_3===_1[i].BIC[0]){_2=true;break;}}return _2;};dojo.declare("misys.openaccount.widget.EntitiesToBeReportedDetails",[misys.grid.GridMultipleItems],{data:{identifier:"store_id",label:"store_id",items:[]},handle:null,templatePath:null,templateString:dojo.byId("entities-to-be-reported-details-template").innerHTML,dialogId:"entities-to-be-reported-template",xmlTagName:"Document",xmlSubTagName:"StsRptReq",openForEdit:false,gridColumns:["BIC"],propertiesMap:{BIC:{_fieldName:"entity_bic"}},bicMap:{BIC:{_fieldName:"BIC"}},layout:[{name:"Bic",field:"BIC",width:"90%"},{name:" ",field:"Actions",formatter:misys.grid.formatReportActions,width:"10%"},{name:"Id",field:"store_id",headerStyles:"display:none",cellStyles:"display:none"}],mandatoryFields:["BIC"],startup:function(){this.dataList=[];if(this.hasChildren()){dojo.forEach(this.getChildren(),function(_4){if(_4.createItem){var _5=_4.createItem();this.dataList.push(_5);}},this);}this.inherited(arguments);},openDialogFromExistingItem:function(_6,_7){if(this.store&&this.store._arrayOfTopLevelItems&&this.store._arrayOfTopLevelItems.length==1){this.openForEdit=true;}else{this.openForEdit=false;}this.inherited(arguments);},addItem:function(_8){this.inherited(arguments);if(dijit.byId("submitter_bic")&&this.store&&this.store._arrayOfTopLevelItems&&(this.store._arrayOfTopLevelItems.length==0||!_doesBICExists(this.store._arrayOfTopLevelItems))){dijit.byId("entity_bic").set("value",dijit.byId("submitter_bic").get("value"));}this.openForEdit=false;},createDataGrid:function(){this.inherited(arguments);var _9=this.grid;var _a=dijit.byId("entities-to-be-reported-ds");misys.connect(_9,"onDelete",function(){misys.dialog.connect(dijit.byId("okButton"),"onMouseUp",function(){_a.addButtonNode.set("disabled",false);},"alertDialog");});},toXML:function(){var _b=[];var _c="";_b.push("<narrative_xml>");_b.push("<![CDATA[");if(this.xmlTagName){_b.push("<",this.xmlTagName,">");}if(this.xmlSubTagName){_b.push("<",this.xmlSubTagName,">");}_c=_c.concat("<ReqId><Id>").concat(dijit.byId("request_id").get("value")).concat("</Id>");_c=_c.concat("<CreDtTm>").concat(dijit.byId("creation_dt_time").get("value")).concat("</CreDtTm></ReqId>");_b.push(_c);if(this.grid){this.grid.store.fetch({query:{store_id:"*"},onComplete:dojo.hitch(this,function(_d,_e){_b.push(this.itemToXML(_d,this.xmlSubTagName));})});}if(this.xmlSubTagName){_b.push("</",this.xmlSubTagName,">");}if(this.xmlTagName){_b.push("</",this.xmlTagName,">");}_b.push("]]>");_b.push("</narrative_xml>");return _b.join("");},itemToXML:function(_f,_10){var xml=[];var _11="";dojo.forEach(_f,function(_12){if(_12){for(var _13 in _12){if(_13!="store_id"&&_13.match("^_")!="_"){value=dojo.isArray(_12[_13])?_12[_13][0]:_12[_13];value+="";for(var _14 in this.bicMap){if(this.bicMap[_14]._fieldName===_13){_11=_11.concat("<NttiesToBeRptd>");_11=_11.concat("<").concat(_14).concat(">").concat(dojox.html.entities.encode(value,dojox.html.entities.html)).concat("</").concat(_14).concat(">").concat("</NttiesToBeRptd>");break;}}}}}},this);xml.push(_11);return xml.join("");},createItemsFromJson:function(_15){this.inherited(arguments);},performValidation:function(){var _16=true;if(this.validateDialog(true)){if(this.store&&this.store._arrayOfTopLevelItems&&this.store._arrayOfTopLevelItems.length>0&&!this.openForEdit){var bic=this.store._arrayOfTopLevelItems;for(var i=0;i<bic.length;i++){var _17=bic[i]&&bic[i].BIC?bic[i].BIC[0]:"";if(dijit.byId("entity_bic")&&dijit.byId("entity_bic").get("value")===_17){_16=false;misys.dialog.show("ERROR",misys.getLocalization("duplicateBICCodeError",[dijit.byId("entity_bic").get("value")]));break;}}}if(_16){this.inherited(arguments);}}},updateData:function(){this.inherited(arguments);}});}