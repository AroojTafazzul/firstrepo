/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.SySubscriptionPackageBinding"]){dojo._hasResource["misys.binding.SySubscriptionPackageBinding"]=true;dojo.provide("misys.binding.SySubscriptionPackageBinding");dojo.require("misys.form.MultiSelect");dojo.require("dijit.form.FilteringSelect");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.NumberTextBox");dojo.require("misys.form.CurrencyTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.layout.ContentPane");dojo.require("misys.validation.common");dojo.require("misys.form.common");fncDoBinding=function(){misys.setValidation("sp_code",fncValidateCharacters);misys.setValidation("sp_description",fncValidateCharacters);misys.connect("add","onClick",function(){misys.addMultiSelectItems(dijit.byId("product_list"),dijit.byId("avail_list_nosend"));});misys.connect("remove","onClick",function(){misys.addMultiSelectItems(dijit.byId("avail_list_nosend"),dijit.byId("product_list"));});};fncDoFormOnLoadEvents=function(){var _1=dojo.hitch(dijit.byId("roletype"),_fncTogglePermissionDetails);_1();};fncGenerateTransactionXML=function(){var _2=dijit.byId("product_list");var _3="";dojo.query("#edit .validate").forEach(function(_4){var _5=dijit.byId(_4.id).getDescendants();dojo.forEach(_5,function(_6){_3+=misys.fieldToXML(_6);});});dojo.require("dojox.xml.DomParser");var _7=dojox.xml.DomParser.parse(_3);var _8="subscription_package";var _9=misys._config.xmlTagName;var _a="<"+_9+"><"+_8+">";_a+=fncGetNodeValue(_7,"subscription_code");_a+=fncGetNodeValue(_7,"subscription_description");_a+=fncGetNodeValue(_7,"charging_cur_code");_a+=fncGetNodeValue(_7,"standard_charge");_a+=fncGetNodeValue(_7,"waived");_a+=fncGetNodeValue(_7,"special_charge");_a+=fncGetNodeValue(_7,"special_charge_expiry_date");_a+=fncGetNodeValue(_7,"transaction_retention_period");_a+=fncGetNodeValue(_7,"no_of_free_tokens");_a+="</"+_8+">";if(_7.getElementsByTagName("product_list").length>0){_a+=_addExistingPermissions(_7,"product_list");}_a+="</"+_9+">";return _a;};_fncTogglePermissionDetails=function(_b){var _c=dojo.byId("products-attached-to-subscription-package");if(this.get&&this.get("value")!="01"){misys.animate("fadeOut",_c);var _d=dijit.byId("product_list");var _e=dijit.byId("avail_list_nosend");_d.reset();_d.invertSelection();misys.addMultiSelectItems(_e,_d);_e.reset();}else{misys.animate("fadeIn",_c);}};_addExistingPermissions=function(_f,_10){var _11=_f.getElementsByTagName(_10)[0];var _12=[];if(_11){var _13=_11.childNodes[0];if(_13&&_13.nodeValue){_12=_13.nodeValue.split(",");}}var _14="<existing_products>";if(_12.length>0){dojo.forEach(_12,function(_15){if(_15!=null&&_15!=""){_14+="<product_record><product_code>"+_15+"</product_code></product_record>";}});}return _14+="</existing_products>";};}