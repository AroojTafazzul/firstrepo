/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.system.widget.CounterpartyPrograms"]){dojo._hasResource["misys.system.widget.CounterpartyPrograms"]=true;dojo.provide("misys.system.widget.CounterpartyPrograms");dojo.experimental("misys.system.widget.CounterpartyPrograms");dojo.require("misys.grid.GridMultipleItems");dojo.require("misys.system.widget.CounterpartyProgram");dojo.declare("misys.system.widget.CounterpartyPrograms",[misys.grid.GridMultipleItems],{data:{identifier:"store_id",label:"store_id",items:[]},handle:null,templatePath:null,templateString:dojo.byId("cptyProgs-template").innerHTML?dojo.byId("cptyProgs-template").innerHTML:"",dialogId:"cptyProg-dialog-template",gridId:"cptyProg_defn_grid",xmlTagName:"fscm_counterparty_list",xmlsubTagName:"fscm_counterparty_record",gridColumns:["cpty_abbv_name","cpty_name","cpty_bo_status","cpty_prog_cpty_assn_status","cpty_limit_cur_code","cpty_limit_amt","cpty_beneficiary_id","cpty_program_cpty_id","cpty_showDelete"],propertiesMap:{cpty_abbv_name:{_fieldName:"cpty_abbv_name"},cpty_name:{_fieldName:"cpty_name"},cpty_bo_status:{_fieldName:"cpty_bo_status"},cpty_prog_cpty_assn_status:{_fieldName:"cpty_prog_cpty_assn_status"},cpty_limit_cur_code:{_fieldName:"cpty_limit_cur_code"},cpty_limit_amt:{_fieldName:"cpty_limit_amt"},cpty_beneficiary_id:{_fieldName:"cpty_beneficiary_id"},cpty_program_cpty_id:{_fieldName:"cpty_program_cpty_id"},cpty_showDelete:{_fieldName:"cpty_showDelete"}},basicMap:{cpty_abbv_name:{_fieldName:"cpty_abbv_name"},cpty_name:{_fieldName:"cpty_name"}},layout:[{name:"cpty_abbv_name",field:"cpty_abbv_name",width:"25%"},{name:"cpty_name",field:"cpty_name",width:"25%"},{name:"cpty_bo_status",field:"cpty_bo_status",width:"10%"},{name:"cpty_prog_cpty_assn_status",field:"cpty_prog_cpty_assn_status",width:"10%"},{name:"cpty_limit_cur_code",field:"cpty_limit_cur_code",width:"8%"},{name:"cpty_limit_amt",field:"cpty_limit_amt",width:"12%"},{name:" ",field:"actions",formatter:misys.grid.formatCptyDeleteActions,width:"10%"}],startup:function(){this.dataList=[];if(this.hasChildren()){dojo.forEach(this.getChildren(),function(_1){if(_1.createItem){var _2=_1.createItem();this.dataList.push(_2);}},this);}this.inherited(arguments);},_showCounterPartyDeleteMsg:function(_3){},createDataGrid:function(){this.inherited(arguments);var _4=this.grid;var _5=_4;misys.connect(_4,"onDelete",function(){misys.dialog.connect(dijit.byId("okButton"),"onMouseUp",function(){window.location.reload();var _6=dijit.byId("program_id").get("value");var _7=dijit.byId("cptyProg_defn_grid").selection.getSelected()[0].cpty_beneficiary_id;var _8=dijit.byId("cptyProg_defn_grid").selection.getSelected()[0].cpty_program_cpty_id;misys.xhrPost({url:misys.getServletURL("/screen/AjaxScreen/action/DeleteAssociatedCounterPartyAction"),handleAs:"json",sync:true,content:{programId:_6,prgCptyId:_8,beneficiaryId:_7},load:this._showCounterPartyDeleteMsg});},"alertDialog");});},resetDialog:function(_9,_a){this.inherited(arguments);},openDialogFromExistingItem:function(_b,_c){this.inherited(arguments);},addItem:function(_d){var _e=this;var _f=false;if(_f){_e.inherited(arguments);}}});}