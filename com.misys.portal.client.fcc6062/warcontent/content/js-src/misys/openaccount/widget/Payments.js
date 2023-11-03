dojo.provide("misys.openaccount.widget.Payments");
dojo.experimental("misys.openaccount.widget.Payments"); 

dojo.require("misys.openaccount.FormOpenAccountEvents");
dojo.require("misys.grid.GridMultipleItems");
dojo.require("misys.openaccount.widget.Payment");

// our declared class
dojo.declare("misys.openaccount.widget.Payments",
		[ misys.grid.GridMultipleItems ],
		// class properties:
		{
		data: { identifier: "store_id", label: "store_id", items: [] },
		
		templatePath: null,
		templateString: dojo.byId("payments-template")? dojo.byId("payments-template").innerHTML : '',
		dialogId: "payment-dialog-template",
		xmlTagName: "payments",
		xmlSubTagName: "payment",
		
		gridColumns: ["code", "label", "other_paymt_terms", "nb_days", "cur_code", "amt", "pct"],
        
		propertiesMap: {
			ref_id: {_fieldName: "ref_id"},
			tnx_id: {_fieldName: "tnx_id"},
			payment_id : {_fieldName: "payment_id"},
			code: {_fieldName: "details_code"},
			label: {_fieldName: "details_label"},
			other_paymt_terms: {_fieldName: "details_other_paymt_terms"},
			nb_days: {_fieldName: "details_nb_days"},
			cur_code: {_fieldName: "details_cur_code"},
			amt: {_fieldName: "details_amt"},
			pct: {_fieldName: "details_pct"}
			},

		layout: [
				{ name: "Payment Type", get: misys.getPaymentType, width: "35%" },
				{ name: "Ccy", field: "cur_code", width: "15%" },
				{ name: "Amount/Rate", field: "amt", get: misys.getPaymentAmountRate, width: "40%" },
				{ name: " ", field: "actions", formatter: misys.grid.formatReportActions, width: "10%" }
				],
				
		getMandatoryProperties: function(item){
			var mandatoryProperties = [];
			mandatoryProperties.push("code");
			mandatoryProperties.push(item.amt == "" ? "pct" : "amt");
			return mandatoryProperties;
		},
        
		startup: function(){
			console.debug("[Payments] startup start");
			
			// Prepare data store
			this.dataList = [];
			if(this.hasChildren())
			{
				dojo.forEach(this.getChildren(), function(child){
					// Mark the child as started.
					// This will prevent Dojo from parsing the child
					// as we don't want to make it appear on the form now.
					if (child.createItem)
					{
						var item = child.createItem();
						this.dataList.push(item);
					}
				}, this);
			}
			this.inherited(arguments);
			console.debug("[Payments] startup end");
		},
    	
		openDialogFromExistingItem: function(items, request)
		{
			console.debug("[Payments] openDialogFromExistingItem start");
			
			// In view mode, disconnect events on amount and rate fields
			// as they are not properly rendered otherwise
			if (misys._config.displayMode === "view") {
				misys.disconnectById("details_amt");
				misys.disconnectById("details_pct");				
			}

			this.inherited(arguments);

			console.debug("[Payments] openDialogFromExistingItem end");
		},
		
		updateData: function(event)
		{
			console.debug("[Payments] updateData start");
			
			this.inherited(arguments);
			if(dijit.byId("part_ship_2") && dijit.byId("part_ship_2").get("checked") === true && dijit.byId("add_payment_term_button")) {
				dijit.byId("add_payment_term_button").set("disabled",true);
			}
			
			console.debug("[Payments] updateData end");
		},
		
		resetDialog: function(items, request)
		{
			console.debug("[Payments] resetDialog start");
			
			this.inherited(arguments);
			
			//not very good line items not always connected to total_cur_code field
			if (dijit.byId("total_cur_code")){
				var poCurCode = dijit.byId("total_cur_code").get("value");
				// Update existing line items
				dijit.byId("details_cur_code").set("value", poCurCode);
			}
			console.debug("[Payments] resetDialog end");
		},
		
		addItem: function(event)
		{
			console.debug("[Payments] addItem start");

			this.inherited(arguments);			
			
			console.debug("[Payments] addItem end");
		},
		
		performValidation: function()
		{
			console.debug("[Payments] validate start");
			if(this.validateDialog(true))
			{
				if((dijit.byId("details_pct") && dijit.byId("details_pct").get("value") === "") && (dijit.byId("details_amt") && isNaN(dijit.byId("details_amt").get("value"))))
				{
					misys.dialog.show("ERROR", misys.getLocalization("addAmtOrPercentage"));
				}
				else if ((dijit.byId("details_code") && dijit.byId("details_code").get("value") === "") && (dijit.byId("details_other_paymt_terms") && dijit.byId("details_other_paymt_terms").get("value") === "")) {
					misys.dialog.show("ERROR", misys.getLocalization("addPaymentTermCode"));
				}
				else if(dijit.byId("total_net_amt"))
				{
					var sumAmt = 0;
					var	Amt= 0;
					var totalNetAmt = parseFloat(dijit.byId("total_net_amt").get("value"));
					var paymentAmt =  parseFloat(dijit.byId("details_amt").get("value"));
					var paymentPct = (parseFloat(dijit.byId("details_pct").get("value"))/100)*totalNetAmt ;
					//Payment amount/percentage check with the total net amount.
					if(this.grid && this.grid.store && this.grid.store._arrayOfTopLevelItems)
					{
						var storeId = this.grid.gridMultipleItemsWidget.dialog.storeId;
						this.grid.store.fetch({
							query:{store_id:"*"},
							onComplete: dojo.hitch(this.grid, function(items, request){
								dojo.forEach(items, function(item){
									//Modifying an existing record check.
									if(storeId)
									{
										//If Amount is given add the amount to calculate total amount.
										if(item.amt[0] != "" && (item.store_id[0]!=storeId))
										{
											sumAmt = sumAmt + parseFloat(item.amt[0].replace(",",""));
										}
										//If Percentage is given, convert it to amount add it to calculate total amount.
										else if(item.pct[0] != "" && (item.store_id[0]!=storeId))
										{
											Amt = (parseFloat(item.pct[0])/100)*totalNetAmt ;
											sumAmt = sumAmt + Amt;
										}
									}
									//Adding a new record check.
									else 
									{
										if(item.amt[0] != "")
										{
											sumAmt = sumAmt + parseFloat(item.amt[0].replace(",",""));
										}
										else if(item.pct[0] != "")
										{
											Amt = (parseFloat(item.pct[0])/100)*totalNetAmt ;
											sumAmt = sumAmt + Amt;
										}
									}
									
								});
							})
						});
					}					
					if(paymentAmt === 0 || paymentPct === 0)
					{
						misys.dialog.show("ERROR", misys.getLocalization("paymentAmtOrPercentageIsZero"));
					}
					else if(paymentAmt &&(sumAmt + paymentAmt > totalNetAmt))
					{
						misys.dialog.show("ERROR", misys.getLocalization("paymentAmtOrPercentage"));
					}
					else if(paymentPct && (sumAmt + paymentPct > totalNetAmt))
					{
						misys.dialog.show("ERROR", misys.getLocalization("paymentAmtOrPercentage"));
					}
				else
				{
					this.inherited(arguments);
				}
			}
			
			console.debug("[Payments] validate end");
		}
	}
	}
);