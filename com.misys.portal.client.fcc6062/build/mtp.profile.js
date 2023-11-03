dependencies = {
	resourceName: "MTP",
	layers: [
	         // summary: 
	         //		This file describes the various "layers" of JavaScript that are 
	         //		loaded as the suer progresses through the application.
	         //
	         //		For more information on layers and dojo build visit
	         //
	         //			http://docs.dojocampus.org/build/index
	         //
	         //		Note that the layers are split between one unsecured layer, and the rest 
	         //		that are secured layers i.e. the unsecured layer (misys-base.js) should only 
	         //		contain the minimum imports required to load a page, and should not contain
	         //		imports that should be hidden from unsecured users.
	         
	         {
	        	// summary:
		        //	   This layer includes just the dojo core, and is discarded once built. It's
	        	//	   referenced in the layer misys_base.js
	        	
	        	 name: "dojoDiscardLayer",
	        	 discard: true,
	        	 dependencies: ["dojo._base"]
	         },
	         
	         {
	        	 // summary:
	        	 //		Unsecured layer, to be loaded at the bottom of all pages. misys_base 
	        	 //     should be the only file included
	        	 
	        	 name: "misys_base.js",
	        	 resourceName : "misys.layer.base",
	        	 layerDependencies: ["dojoDiscardLayer"],
	        	 dependencies: ["misys._base"]
	         },
	         
	         {
	        	// summary:
	        	//	   This layer lists imports that are included in misys_base.js and
	        	//	   hence don't need to be included in misys_common.js. Note that
	        	//	   discard is set to true, so you won't see this layer in the build
	        	//	   directory.
	        	 
	        	 name: "dijitDiscardLayer",
	        	 discard: true,
	        	 layerDependencies: ["dojoDiscardLayer"],
	        	 dependencies: [
					"dojo.parser",
					"dijit.dijit",
					"misys.widget.Dialog",
					"dijit.Tooltip",
					"dijit.ProgressBar",
					"dijit.form.Form",
					"dijit.form.Button",
					"dijit.form.CheckBox",
					"dijit.form.TextBox",
					"dijit.form.ValidationTextBox"
	        	 ]
	         },
	         
			 {
		         // summary:
		         // 	Secured layer, containing all core dojo/dijit functionality, should
	        	 //		be loaded at the bottom of all *secured* pages. 
		        	
		          name: "misys_common.js",
		          resourceName : "misys.layer.common",
		          layerDependencies : ["dijitDiscardLayer"],
		          dependencies: [
					   "dijit.form.DateTextBox",
					   "misys.form.CurrencyTextBox",
					   "dijit.form.FilteringSelect",
		        	   "dojo.data.ItemFileReadStore",
		        	   "misys.data.ItemFileReadStore",
    	               "dojo.data.ItemFileWriteStore",
    	               "dojox.uuid",
    	               "dojox.data.QueryReadStore",
					   "dojox.grid.DataGrid",
					   "dojox.grid.EnhancedGrid",
					   "dojox.grid.enhanced.plugins.IndirectSelection",
					   "dojox.NodeList.delegate",
					   "misys.common",
					   "misys.form.common",
					   "misys.form.file",
					   "misys.form.SimpleTextarea",
					   "misys.validation.common",
					   "misys.product.widget.AttachmentFiles",
					   "misys.product.widget.AttachmentFile",
					   "misys.grid._base",
					   "misys.grid.TopicListenerDataGrid",
					   "misys.grid.Pagination",
					   "misys.grid.IndirectSelection",
					   "misys.calendar.Calendar",
					   "misys.widget.Collaboration",
					   "misys.widget.Bookmark",
					   "misys.binding.SessionTimer",
					   "dijit.MenuBar",
					   "dijit.PopupMenuBarItem",
					   "dijit.Menu",
					   "dijit.form.Button",
					   "misys.widget.BookmarkMenu",
					   "dijit.form.DropDownButton",
					   "dijit.TooltipDialog",
					   "misys.widget.Tree",
					   "misys.binding.AsyncMessage"
		         ]
		    },
		         
			{
				// summary:
		        //  	This layer should be loaded by the report module 
				name: "misys_report.js",
				resourceName : "misys.layer.report",
				layerDependencies : ["misys_common.js"],
				dependencies: [
					   "dojo.behavior",
					   "dijit.layout.BorderContainer",
					   "misys.report.common",
		               "misys.grid.DataGrid",
		               "dojox.grid.EnhancedGrid",
					   "misys.grid.Pagination",
					   "dojox.grid.enhanced.plugins.IndirectSelection",
		               "misys.grid._ViewManager",
		               "misys.grid._View",
		               "misys.form.CurrencyTextBox",
		               "misys.grid.GridMultipleItems",
		               "dijit.form.DropDownButton",
					   "dijit.TooltipDialog"
		        ]
			},
			
			{
				// summary:
				// 	This layer is loaded only in DEBUG mode (and *not* PROD or DEBUG_ALL).
				//	It bundles together all the core dijit/dojo/dojox packages
				// 	that we typically won't want to debug.
				
				name: "dojo_core.js",
				resourceName : "dojo.layer.core",
				layerDependencies: ["dojoDiscardLayer"],
				dependencies: [
				    "dojo.io.iframe",
					"dojo.fx.easing",
					"dojo.data.ItemFileReadStore",
					"misys.data.ItemFileReadStore",
					"dojo.data.ItemFileWriteStore",
					"dojox.html.entities",
					"dojox.fx.scroll",
					"dijit.dijit",
					"dijit.Editor",
					"misys.widget.Dialog",
					"dijit.TitlePane",
					"dijit.Tooltip",
					"dijit.form.Form",
					"dijit.form.Button",
					"dijit.form.TextBox",
					"dijit.form.ValidationTextBox",
					"dijit.form.CheckBox",
					"dijit.Calendar",
					"dijit.Tooltip",
					"dijit.ProgressBar",
					"dijit.layout.ContentPane",
					"dijit.layout.TabContainer",
					"dijit.layout.BorderContainer",
					"dijit.form.DateTextBox",
					"misys.form.CurrencyTextBox",
					"dijit.form.FilteringSelect",
					"dijit.form.MultiSelect",
					"dijit.form.SimpleTextarea",
					"dojox.uuid",
					"dojox.validate",
					"dojox.grid.TreeGrid",
					"dojox.grid.DataGrid",
					"dojox.grid.EnhancedGrid",
					"dojox.grid.enhanced.plugins.IndirectSelection",
					"dojox.data.QueryReadStore",
					"dojox.layout.ContentPane",
					"dojox.layout.FloatingPane",
					"dojox.layout.ResizeHandle",
					"dojox.string.tokenize"
				]
		} 
	],
	prefixes: [
		[ "dijit", "../dijit" ],
		[ "dojox", "../dojox"],
		[ "misys", "../misys", "copyright.txt"]
	]
};