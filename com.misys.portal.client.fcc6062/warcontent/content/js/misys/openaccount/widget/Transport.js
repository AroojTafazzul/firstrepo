/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.openaccount.widget.Transport"]){dojo._hasResource["misys.openaccount.widget.Transport"]=true;dojo.provide("misys.openaccount.widget.Transport");dojo.experimental("misys.openacount.widget.Transport");dojo.require("dijit._Contained");dojo.require("dijit._Widget");dojo.require("misys.layout.SimpleItem");dojo.declare("misys.openaccount.widget.Transport",[dijit._Widget,dijit._Contained,misys.layout.SimpleItem],{ref_id:"",tnx_id:"",transport_id:"",transport_mode:"",transport_type:"",transport_sub_type:"",transport_sub_type_label:"",transport_group:"",airport_name:"",airport_code:"",town:"",port_name:"",place_name:"",taking_in:"",final_place_name:"",is_valid:"Y",createItem:function(){var _1={ref_id:this.get("ref_id"),tnx_id:this.get("tnx_id"),transport_id:this.get("transport_id"),transport_mode:this.get("transport_mode"),transport_type:this.get("transport_type"),transport_sub_type:this.get("transport_sub_type"),transport_sub_type_label:this.get("transport_sub_type_label"),transport_group:this.get("transport_group"),airport_name:this.get("airport_name"),airport_code:this.get("airport_code"),town:this.get("town"),port_name:this.get("port_name"),place_name:this.get("place_name"),taking_in:this.get("taking_in"),final_place_name:this.get("final_place_name"),is_valid:this.get("is_valid")};if(this.hasChildren&&this.hasChildren()){dojo.forEach(this.getChildren(),function(_2){if(_2.createItem){_1.push(_2.createItem());}},this);}return _1;},constructor:function(){}});}