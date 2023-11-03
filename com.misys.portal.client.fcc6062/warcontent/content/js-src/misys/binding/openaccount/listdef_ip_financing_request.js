/**
 * 
 *//**
 * 
 */dojo.provide("misys.binding.openaccount.listdef_ip_financing_request");
/*
-----------------------------------------------------------------------------
Scripts for the list def binding for Invoice Payable
Copyright (c) 2000-2016 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      18/01/2017
author:		Meenal Sahasrabudhe
-----------------------------------------------------------------------------
*/

dojo.require("dojo.data.ItemFileReadStore");
dojo.require("dojo.data.ItemFileWriteStore");
dojo.require("dijit.form.FilteringSelect");
dojo.require("misys.form.MultiSelect");
dojo.require("dijit.layout.TabContainer");
dojo.require("misys.form.common");
dojo.require("misys.openaccount.StringUtils");
dojo.require("misys.validation.common");
dojo.require("dijit.form.Form");
dojo.require("dijit.form.Button");
dojo.require("dijit.form.TextBox");
dojo.require("dijit.form.ValidationTextBox");
dojo.require("dijit.form.CheckBox");
dojo.require("dijit.layout.ContentPane");
dojo.require("misys.form.CurrencyTextBox");

(function(/*Dojo*/d, /*dj*/dj, /*Misys*/m) {
	d.subscribe("ready", function(){
		m._config = (m._config) || {};
		m._config.cellNodeReference;
		d.query(".dojoxGrid").forEach(function(grid){
			if(grid.id !== "nonSignedFolders")
			{
				m.connect(grid.id, "onRowClick", m._config.storeCellNodeReference);
				m.connect(grid.id, "onHeaderCellClick", function(evt)
				{
					if(m._config.cellNodeReference && m._config.cellNodeReference.cellNode)
					{
						dj.hideTooltip(m._config.cellNodeReference.cellNode);
						m._config.cellNodeReference.cellNode = null;
					}
				});
			}
		});
	});
	d.mixin(m, {
		bind : function() {
			// validating Amount range
			m.connect("AmountRangevisible", "onChange", _validateMinMaxAmount);
			m.connect("AmountRange2visible", "onChange", _validateMinMaxAmount);
			//validating due date and issue date fields
			m.connect("iss_date", "onChange", _validateIssueFromDate);
			m.connect("iss_date2", "onChange", _validateIssueToDate);
			m.connect("due_date", "onChange", _validateDueFromDate);
			m.connect("due_date2", "onChange", _validateDueToDate);
			// validate the currency
			m.setValidation("cur_code", m.validateCurrency);
			m.connect("cur_code", "onChange", _enableAmountRange);
			m.connect("cur_code", "onChange", function() {
				misys.setCurrency(this, [ "AmountRange", "AmountRange2" ]);
			});
			// set the amount value
			m.connect("submitButton", "onClick", _setAmountValue);
		}
	});
	d.mixin(m._config, {
		submitOpenAccount : function(/*String*/ productCode) {
				var grids = [],
					referenceid = "",
					baseCcy = "",
					tnxid = "";
			
			if(dj.byId("nonSignedFolders") && dijit.byId("nonSignedFolders").selection.selectedIndex !== -1)
			{
				if(dj.byId("referenceid"))
				{
					referenceid = dj.byId("referenceid").get("value");
				}
				if(dj.byId("tnxid"))
				{
					tnxid = dj.byId("tnxid").get("value");
				}
			}
			baseCcy = dj.byId("base_ccy").get("value");
			d.query(".dojoxGrid").forEach(function(g){
				grids.push(dj.byId(g.id));
			});		
			var gridlist = d.isArray(grids) ? grids : [grids],
					targetNode = d.byId("batchContainer"),
					items = [],
					keys = "",
					intNbKeys = 0,
					reference, xhrArgs;
				d.forEach(gridlist, function(grids){
					//for multipage selection
					var cache = grids.selection.preserver._selectedById;
					items = grids.selection.getSelected();
					
					if(items && items.length)
					{
						d.forEach(items, function(selectedItem)
						{
							// extract the reference
							reference = grids.store.getValues(selectedItem, "box_ref");
	
							// separator
							if(keys !== "")
							{
								keys += ", ";
							}
							keys += reference;
							intNbKeys++;
						});
					}
				});			
			if(keys === ""){
				m.dialog.show("ERROR", m.getLocalization("noTransactionsSelectedError"));
			}
			else
			{
				var URL = window.location.pathname;
				m.post({action:URL, params:[{name:"list_keys",value:keys}, {name:"base_ccy",value:baseCcy}, {name:"operation",value:"MULTI_LIST_FINANCING"},{name:"option",value:"IP_FINANCE_REQUEST"},{name:"mode",value:"DRAFT"},{name:"productcode",value:"IP"}]});
			}
		},		
		
		storeCellNodeReference : function(evt)
		{
			//  summary: 
			//  Preserve the cell node reference for selected event of the check box
			m._config.cellNodeReference = evt;
		}
	});
	function _enableAmountRange() {
	//  summary:
	//		Enables or disables the amount field based on cur code
		if (dj.byId("cur_code").value !== "") {
			dj.byId("AmountRangevisible").set("disabled", false);
			dj.byId("AmountRange2visible").set("disabled", false);
		} else if (dj.byId("cur_code").value === "") {
			dj.byId("AmountRangevisible").set("disabled", true);
			dj.byId("AmountRange2visible").set("disabled", true);
			dj.byId("AmountRangevisible").reset();
			dj.byId("AmountRange2visible").reset();
		}
	}
	function _setAmountValue() {
		if(dj.byId("AmountRangevisible")){
		var amountRange = dj.byId("AmountRangevisible").value;
		var amountRangeValue = isNaN(amountRange) ? 0 : amountRange;
		// set the amount range value
		dj.byId("AmountRange").set("value", amountRange);
		var amountRange2 = dj.byId("AmountRange2visible").value;
		dj.byId("AmountRange2").set("value", amountRange2);
		}
	}
	function _validateMinMaxAmount() {
		//  summary:
	    //        Validates minimum amount. Minimum amount should be greater than zero and less than maximum amount.
	    //        Validates maximum amount. maximum amount should be greater than zero and greater than minimum amount.
		var amount = this.get("value");
		console.debug("[misys.validation.common] Validating the amount. Value", amount);
		var toValue = dj.byId("AmountRange2visible").get("value");
		var fromValue = dj.byId("AmountRangevisible").get("value");
		var toAmtWidget = false;
		var widget1 = dj.byId("AmountRangevisible");
		var widget = dj.byId("AmountRange2visible");
				if (fromValue > toValue)
				{
			  		var displayMessage = misys.getLocalization("invalidMaxAmountValueError");
			  		toAmtWidget = true;
			  	}
				else if (toValue < 0)
			  	{
					displayMessage = misys.getLocalization("invalidAmountValueError");
					toAmtWidget = true;
			  	}
				else if (fromValue < 0)
			  	{
					displayMessage = misys.getLocalization("invalidAmountValueError");
					widget1.focus();
			 		widget1.set("state","Error");
			 		dj.hideTooltip(widget1.domNode);
			 		dj.showTooltip(displayMessage, widget1.domNode, 0);
			 		dj.showTooltip(displayMessage, domNode, 0);
			 		return false;
			  	}
				if(toAmtWidget)
				{
				  	widget.focus();
			 		widget.set("state","Error");
			 		dj.hideTooltip(widget.domNode);
			 		dj.showTooltip(displayMessage, widget.domNode, 0);
			 		dj.showTooltip(displayMessage, domNode, 0);
			 		return false;
				}
		 return true;
	}
	function _validateIssueFromDate() {
		// summary:
		// Validates the data entered for creation from date
		// tags:
		// public, validation

		// Return true for empty values

		//var that = this;
		if (this.get("value") === null) {
			return true;
		}
		console.debug("[Validate] Validating Issue From Date. Value = "+ this.get("value"));
		// Test that the last shipment date is greater than or equal to
		// the application date
		var creationToDate = dj.byId("iss_date2");
		if (!m.compareDateFields(this, creationToDate)) {
			var widget = dj.byId("iss_date");
				displayMessage = misys.getLocalization("InvoiceIssueDateFromLesserThanInvoiceIssueDateTo");
				widget.focus();
				widget.set("state","Error");
				dj.hideTooltip(widget.domNode);
				dj.showTooltip(displayMessage, widget.domNode, 0);
		}

		return true;
	}
	function _validateIssueToDate() {
		// summary:
		// Validates the data entered for creation to date
		// tags:
		// public, validation

		// Return true for empty values
		//var that = this;
		if (this.get("value") === null) {
			return true;
		}
		console.debug("[Validate] Validating Creation To Date. Value = "+ this.get("value"));
		// Test that the last shipment date is greater than or equal to
		// the application date
		var creationFromDate = dj.byId("iss_date");
		if (!m.compareDateFields(creationFromDate, this)) {
			var widget = dj.byId("iss_date2");
			  	displayMessage = misys.getLocalization("InvoiceIssueDateToGreaterThanInvoiceIssueDateFrom");
		 		widget.focus();
		 		widget.set("state","Error");
		 		dj.hideTooltip(widget.domNode);
		 		dj.showTooltip(displayMessage, widget.domNode, 0);
		 	return false;		
		}

		return true;
	}
	function _validateDueFromDate() {
		// summary:
		// Validates the data entered for maturity from date
		// tags:
		// public, validation

		// Return true for empty values
		//var that = this;
		if (this.get("value") === null) {
			return true;
		}
		console.debug("[Validate] Validating Maturity From Date. Value = "+ this.get("value"));
		// Test that the last shipment date is greater than or equal to
		// the application date
		var maturityToDate = dj.byId("due_date2");
		if (!m.compareDateFields(this, maturityToDate)) {
			var widget = dj.byId("due_date"),
			    displayMessage = misys.getLocalization("InvoiceDueDateFromGreaterThanInvoiceDueDateTo");
		 		widget.focus();
		 		widget.set("state","Error");
		 		dj.hideTooltip(widget.domNode);
		 		dj.showTooltip(displayMessage, widget.domNode, 0);
		 		dj.showTooltip(displayMessage,
					domNode, 0);
		 		return false;
		}
		return true;
	}
	function _validateDueToDate() {

		// summary:
		// Validates the data entered for maturity to date
		// tags:
		// public, validation

		// Return true for empty values
		//var that = this;
		if (this.get("value") === null) {
			return true;
		}
		console.debug("[Validate] Validating Maturity To Date. Value = "+ this.get("value"));
		// Test that the last shipment date is greater than or equal to
		// the application date
		var maturityFromDate = dj.byId("due_date");
		if (!m.compareDateFields(maturityFromDate, this)) {
			var widget = dj.byId("due_date2");
			 	displayMessage = misys.getLocalization("InvoiceDueDateToLesserThanInvoiceDueDateFrom");
		 		widget.focus();
		 		widget.set("state","Error");
		 		dj.hideTooltip(widget.domNode);
		 		dj.showTooltip(displayMessage, widget.domNode, 0);
		}
		return true;
	}
})(dojo, dijit, misys);//Including the client specific implementation
       dojo.require("misys.client.binding.openaccount.listdef_ip_financing_request_client");