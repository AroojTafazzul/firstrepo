/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.loan.create_se_dt"]){dojo._hasResource["misys.binding.loan.create_se_dt"]=true;dojo.provide("misys.binding.loan.create_se_dt");dojo.require("dijit.layout.TabContainer");dojo.require("dijit.form.DateTextBox");dojo.require("misys.form.CurrencyTextBox");dojo.require("dijit.form.NumberTextBox");dojo.require("dijit.form.FilteringSelect");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("misys.widget.Dialog");dojo.require("dijit.ProgressBar");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("misys.form.file");dojo.require("misys.form.SimpleTextarea");dojo.require("misys.widget.Collaboration");dojo.require("misys.form.common");dojo.require("misys.validation.common");dojo.require("misys.binding.SessionTimer");(function(d,dj,m){d.mixin(m._config,{initReAuthParams:function(){var _1={productCode:"SE",subProductCode:"",transactionTypeCode:"01",entity:dj.byId("entity")?dj.byId("entity").get("value"):"",currency:"",amount:"",es_field1:"",es_field2:""};return _1;}});function _2(){var _3=dj.byId("attIds");var _4=false;var _5=0;if(_3){var _6=[dj.byId("attachment-file"),dj.byId("attachment-fileOTHER")];d.forEach(_6,function(_7){if(_7&&_7.grid){var _8=_7.grid.store._arrayOfAllItems;d.forEach(_8,function(_9,i){if(_9!==null){_4=true;_5++;}});}});}if(_4===false){m._config.onSubmitErrorMsg=m.getLocalization("mandatoryMinimumFileUploadTypeError");}return _4;};d.mixin(m,{bind:function(){},onFormLoad:function(){},beforeSaveValidations:function(){var _a=dj.byId("entity");if(_a&&_a.get("value")===""){return false;}else{return true;}},beforeSubmitValidations:function(){return _2();}});})(dojo,dijit,misys);dojo.require("misys.client.binding.loan.create_se_dt_client");}