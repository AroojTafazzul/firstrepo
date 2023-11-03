dojo.provide("misys.binding.system.trust_relationship");

dojo.require("dojo.data.ItemFileReadStore");
dojo.require("dijit.form.FilteringSelect");
dojo.require("dijit.layout.TabContainer");
dojo.require("misys.form.common");
dojo.require("misys.form.addons");
dojo.require("misys.validation.common");
dojo.require("dijit.form.Form");
dojo.require("dijit.form.Button");
dojo.require("dijit.form.TextBox");
dojo.require("dijit.form.NumberTextBox");
dojo.require("dijit.form.ValidationTextBox");
dojo.require("dijit.form.CheckBox");
dojo.require("misys.form.SimpleTextarea");
dojo.require("dijit.layout.ContentPane");
dojo.require("misys.form.MultiSelect");
dojo.require("dojox.xml.DomParser");
dojo.require("misys.form.CurrencyTextBox");
dojo.require("dijit.form.RadioButton");

dojo.require("dojo.data.ItemFileWriteStore");
dojo.require("dijit.Editor");
dojo.require("misys.grid.DataGrid");
dojo.require("misys.form.static_document");
dojo.require("dojox.lang.aspect");


/**
 * This File is for Trust Relationship
 * @class trust_relationship
 */
(function(/*Dojo*/d, /*Dijit*/dj, /*Misys*/m) {
	
	// Public functions & variables follow
	d.mixin(m, {
		bind : function() {
		
						m.connect("from_bank",  "onChange", function()
								{
									if(dj.byId("from_company"))
									{
										dj.byId("from_company").set("value","");
									}
								});
						m.connect("to_bank",  "onChange", function()
								{
									if(dj.byId("to_company"))
									{
										dj.byId("to_company").set("value","");
									}
								});
							}
	});
	
	
	})(dojo, dijit, misys);
