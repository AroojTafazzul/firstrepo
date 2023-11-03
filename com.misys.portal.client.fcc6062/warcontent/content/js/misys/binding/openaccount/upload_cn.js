/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.openaccount.upload_cn"]){dojo._hasResource["misys.binding.openaccount.upload_cn"]=true;dojo.provide("misys.binding.openaccount.upload_cn");dojo.require("dojo.data.ItemFileReadStore");dojo.require("dijit.layout.TabContainer");dojo.require("dijit.form.DateTextBox");dojo.require("misys.form.CurrencyTextBox");dojo.require("dijit.form.FilteringSelect");dojo.require("dijit.form.Form");dojo.require("dijit.form.Button");dojo.require("dijit.form.TextBox");dojo.require("misys.widget.Dialog");dojo.require("dijit.ProgressBar");dojo.require("dijit.form.ValidationTextBox");dojo.require("dijit.form.CheckBox");dojo.require("dijit.layout.ContentPane");dojo.require("misys.widget.Collaboration");dojo.require("misys.form.file");dojo.require("misys.form.common");dojo.require("misys.validation.common");(function(d,dj,m){d.mixin(m._config,{initReAuthParams:function(){var _1={productCode:"CN",subProductCode:"",transactionTypeCode:"01",entity:dj.byId("entity")?dj.byId("entity").get("value"):"",currency:"",amount:"",es_field1:"",es_field2:""};return _1;}});d.mixin(m,{bind:function(){m.connect("issuing_bank_abbv_name","onChange",m.populateReferences);m.connect("issuing_bank_customer_reference","onChange",m.setSellerReference);if(dj.byId("issuing_bank_abbv_name")){m.connect("entity","onChange",function(){dj.byId("issuing_bank_abbv_name").onChange();});}m.setValidation("buyer_country",m.validateCountry);m.setValidation("seller_country",m.validateCountry);},onFormLoad:function(){var _2=dj.byId("issuing_bank_customer_reference"),_3=dj.byId("issuing_bank_abbv_name"),_4;if(_2){_4=_2.value;}if(_3){_3.onChange();}if(_2){_2.onChange();_2.set("value",_4);}m.animate("fadeOut",d.byId("submit_upload"));m.animate("fadeOut",d.byId("overwrite_contact_radio_div"));},beforeSubmitValidations:function(){if(dj.byId("attachment-file")&&dj.byId("attachment-file").store){if(dj.byId("attachment-file").store._arrayOfAllItems.length>0){m._config.onSubmitErrorMsg="";return true;}}else{m._config.onSubmitErrorMsg=m.getLocalization("attachementfilenotpresenterror");}return false;}});})(dojo,dijit,misys);dojo.require("misys.client.binding.openaccount.upload_cn_client");}