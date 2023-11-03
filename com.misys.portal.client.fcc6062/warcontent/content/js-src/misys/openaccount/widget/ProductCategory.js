dojo.provide("misys.openaccount.widget.ProductCategory");
dojo.experimental("misys.openacount.widget.ProductCategory"); 

dojo.require("dijit._Contained");
dojo.require("dijit._Widget");
dojo.require("misys.layout.SimpleItem");

// our declared class
dojo.declare("misys.openaccount.widget.ProductCategory",
	[ dijit._Widget, dijit._Contained, misys.layout.SimpleItem ],
	// class properties:
	{
		goods_id: '',
		ref_id: '',
		tnx_id: '',
		type: '',
		type_label: '',
		other_type: '',
		description: '',
		is_valid: "Y",
			
		createItem: function()
		{
			var item = {
				goods_id: this.get('goods_id'),
				ref_id: this.get('ref_id'),
				tnx_id: this.get('tnx_id'),
				type: this.get('type'),
				type_label: this.get('type_label'),
				other_type: this.get('other_type'),
				description: this.get('description'),
				is_valid: this.get("is_valid")
			};
			if(this.hasChildren && this.hasChildren())
    		{
				dojo.forEach(this.getChildren(), function(child){
					if (child.createItem) {
						item.push(child.createItem());
					}
				}, this);
    		}
    		return item;
		},

		constructor: function()
		{
			this.inherited(arguments);
			console.debug("[ProductCategory] constructor");
		}
	}
);