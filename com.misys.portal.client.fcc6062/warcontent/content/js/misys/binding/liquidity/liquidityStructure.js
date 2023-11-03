/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.liquidity.liquidityStructure"]){dojo._hasResource["misys.binding.liquidity.liquidityStructure"]=true;dojo.provide("misys.binding.liquidity.liquidityStructure");dojo.require("misys.validation.common");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("dijit.form.Select");dojo.require("misys.form.common");dojo.require("dijit.Tooltip");dojo.require("misys.widget.Dialog");(function(d,dj,m){function _1(){if((dj.byId("effective_date_FROM").get("value")!==""&&dj.byId("effective_date_TO").get("value")!=="")&&(dj.byId("effective_date_FROM").get("value")!==null&&dj.byId("effective_date_TO").get("value")!==null)){var _2=dj.byId("effective_date_FROM");var to=dj.byId("effective_date_TO");if(!m.compareDateFields(_2,to)){this.invalidMessage=m.getLocalization("toDateGreaterThanFromDateError",[dj.byId("effective_date_TO").get("displayedValue"),dj.byId("effective_date_FROM").get("displayedValue")]);dj.byId("effective_date_TO").set("state","Error");dj.hideTooltip(dj.byId("effective_date_TO").domNode);m.showTooltip(invalidMessage,d.byId("effective_date_TO"));return false;}}};function _3(){if((dj.byId("effective_date_FROM").get("value")!==""&&dj.byId("effective_date_TO").get("value")!=="")&&(dj.byId("effective_date_FROM").get("value")!==null&&dj.byId("effective_date_TO").get("value")!==null)){var _4=dj.byId("effective_date_FROM");var to=dj.byId("effective_date_TO");if(!m.compareDateFields(_4,to)){this.invalidMessage=m.getLocalization("fromDateLessThanToDateError",[dj.byId("effective_date_FROM").get("displayedValue"),dj.byId("effective_date_TO").get("displayedValue")]);dj.byId("effective_date_FROM").set("state","Error");dj.hideTooltip(dj.byId("effective_date_FROM").domNode);m.showTooltip(invalidMessage,d.byId("effective_date_FROM"));return false;}}};d.mixin(m,{bind:function(){m.connect("effective_date_FROM","onBlur",function(){_3();});m.connect("effective_date_TO","onBlur",function(){_1();});}});})(dojo,dijit,misys);dojo.require("misys.client.binding.liquidity.liquidityStructure_client");}