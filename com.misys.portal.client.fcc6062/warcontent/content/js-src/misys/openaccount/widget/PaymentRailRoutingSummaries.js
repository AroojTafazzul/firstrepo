dojo.provide("misys.openaccount.widget.PaymentRailRoutingSummaries");
dojo.experimental("misys.openaccount.widget.PaymentRailRoutingSummaries"); 

dojo.require("misys.grid.GridMultipleItems");
dojo.require("misys.openaccount.widget.PaymentRoutingSummary");

// our declared class
dojo.declare("misys.openaccount.widget.PaymentRailRoutingSummaries",
		[ misys.grid.GridMultipleItems ],
		// class properties:
		{
	data: { identifier: "store_id", label: "store_id", items: [] },
	templatePath: null,
	templateString: dojo.byId("payment-routing-summary-rail-template") ? dojo.byId('payment-routing-summary-rail-template').innerHTML : "",
	dialogId: 'payment-routing-summary-rail-dialog-template',
	xmlTagName: "",
	xmlSubTagName: "",
	
	gridColumns: ["payment_transport_rail_carrier_name", "payment_transport_rail_place_of_receipt", "payment_transport_rail_place_of_delivery"],
    
	propertiesMap: {
		payment_transport_rail_carrier_name: {_fieldName: 'payment_transport_rail_carrier_name'},
		payment_transport_rail_place_of_receipt: {_fieldName: 'payment_transport_rail_place_of_receipt'},
		payment_transport_rail_place_of_delivery: {_fieldName: 'payment_transport_rail_place_of_delivery'}
		},
        
		layout: [
				{ name: "Rail Carrier Name", field: "payment_transport_rail_carrier_name", width: "75%" },
				{ name: " ", field: "actions", formatter: misys.grid.formatReportActions, width: "10%" },
				{ name: "Id", field: "store_id", headerStyles: "display:none", cellStyles: "display:none" }
				],
				
		        
		mandatoryFields: [],

		startup: function(){
			console.debug("[RailRoutingSummaries] startup start");

			this.inherited(arguments);
			
			console.debug("[RailRoutingSummaries] startup end");
		},
    	
		openDialogFromExistingItem: function(items, request)
		{
			console.debug("[RailRoutingSummaries] openDialogFromExistingItem start");
			
			this.inherited(arguments);

			console.debug("[RailRoutingSummaries] openDialogFromExistingItem end");
		},
		
		resetDialog: function(items, request)
		{
			console.debug("[RailRoutingSummaries] resetDialog start");
			
			this.inherited(arguments);

			console.debug("[RailRoutingSummaries] resetDialog end");
		},

		addItem: function(event)
		{
			console.debug("[RailRoutingSummaries] addItem start");

			this.inherited(arguments);
			
			console.debug("[RailRoutingSummaries] addItem end");
		},
		
		createDataGrid: function()
		{
			this.inherited(arguments);
			var grid = this.grid;
			var widgetAir = dijit.byId("air_routing_summaries");
			var widgetSea = dijit.byId("sea_routing_summaries");
			var widgetRoad = dijit.byId("road_routing_summaries");
			var widgetRail = dijit.byId("rail_routing_summaries");
			var widgetLineAir = dijit.byId("line_item_air_routing_summaries");
			var widgetLineSea = dijit.byId("line_item_sea_routing_summaries");
			var widgetLineRoad = dijit.byId("line_item_road_routing_summaries");
			var widgetLineRail = dijit.byId("line_item_rail_routing_summaries");
			misys.connect(grid, "onDelete",
					function(){
						misys.dialog.connect(dijit.byId("okButton"), "onMouseUp", function(){
							widgetLineAir.addButtonNode.set("disabled", false);
							widgetLineSea.addButtonNode.set("disabled", false);
							widgetLineRoad.addButtonNode.set("disabled", false);
							widgetLineRail.addButtonNode.set("disabled", false);
							widgetAir.addButtonNode.set("disabled", false);
							widgetSea.addButtonNode.set("disabled", false);
							widgetRoad.addButtonNode.set("disabled", false);
							widgetRail.addButtonNode.set("disabled", false);
						}, "alertDialog");
			});
		},
		
		performValidation: function()
		{
			console.debug("[RailRoutingSummaries] validate start");

			if(this.validateDialog(true))
			{
				this.inherited(arguments);
			}
			console.debug("[RailRoutingSummaries] validate end");
		},
		updateData : function()
		{    
			console.debug("[Rail routing Summary Multimode] updateData start");
			this.inherited(arguments);
			var widgetAir = dijit.byId("air_routing_summaries");
			var widgetSea = dijit.byId("sea_routing_summaries");
			var widgetRoad = dijit.byId("road_routing_summaries");
			var widgetRail = dijit.byId("rail_routing_summaries");
			var widgetLineAir = dijit.byId("line_item_air_routing_summaries");
			var widgetLineSea = dijit.byId("line_item_sea_routing_summaries");
			var widgetLineRoad = dijit.byId("line_item_road_routing_summaries");
			var widgetLineRail = dijit.byId("line_item_rail_routing_summaries");
			
			if(dijit.byId("tran_ship_2") && dijit.byId("tran_ship_2").get("checked") === true){
				var gridLineItemRailRoutingSummary=dijit.byId("line_item_rail_routing_summaries");
				if(gridLineItemRailRoutingSummary && gridLineItemRailRoutingSummary.store && gridLineItemRailRoutingSummary.store._arrayOfTopLevelItems.length > 0){
					
					if (widgetLineAir && widgetLineAir.addButtonNode) {
						widgetLineAir.addButtonNode.set("disabled", true);
					}
					if (widgetLineSea && widgetLineSea.addButtonNode) {
						widgetLineSea.addButtonNode.set("disabled", true);
					}
					if (widgetLineRoad && widgetLineRoad.addButtonNode) {
						widgetLineRoad.addButtonNode.set("disabled", true);
					}
					if (widgetLineRail && widgetLineRail.addButtonNode) {
						widgetLineRail.addButtonNode.set("disabled", true);
					}	
				}
				else{
							if (widgetAir && widgetAir.addButtonNode) {
									widgetAir.addButtonNode.set("disabled", true);
							}
							if (widgetSea && widgetSea.addButtonNode) {
									widgetSea.addButtonNode.set("disabled", true);
							}
							if (widgetRoad && widgetRoad.addButtonNode) {
									widgetRoad.addButtonNode.set("disabled", true);
							}
							if (widgetRail && widgetRail.addButtonNode) {
									widgetRail.addButtonNode.set("disabled", true);
							}
				}
			}
			console.debug("[Rail routing Summary Multimode] updateData end");
		}
	}
);