dojo.provide("misys.openaccount.widget.PaymentCertificateDatasetDetail");
dojo.experimental("misys.openacount.widget.PaymentCertificateDatasetDetail"); 

dojo.require("dijit._Contained");
dojo.require("dijit._Widget");
dojo.require("dijit._Container");
dojo.require("misys.layout.SimpleItem");

// our declared class
dojo.declare("misys.openaccount.widget.PaymentCertificateDatasetDetail",
	[ dijit._Widget, dijit._Contained, dijit._Container, misys.layout.SimpleItem ],
	// class properties:
	{
			payment_ceds_cert_type: "",
			payment_ceds_cert_type_hidden: "",
			payment_cert_dataset_id: "",
			payment_cert_dataset_version: "",
			payment_cert_dataset_submitter_bic: "",
			payment_ceds_po_authrsd_inspctn_ind: "",
			payment_ceds_po_cert_id: "",
			payment_ceds_po_goods_desc: "",
			payment_ceds_certfdchrtcs_origin: "",
			payment_ceds_certfdchrtcs_qlty: "",
			payment_ceds_certfdchrtcs_anlys: "",
			payment_ceds_certfdchrtcs_wt_unit: "",
			payment_ceds_certfdchrtcs_wt_othrunit: "",
			payment_ceds_certfdchrtcs_wt_val: "",
			payment_ceds_certfdchrtcs_wt_fctr: "",
			payment_ceds_certfdchrtcs_qty_unit: "",
			payment_ceds_certfdchrtcs_qty_othrunit: "",
			payment_ceds_certfdchrtcs_qty_val: "",
			payment_ceds_certfdchrtcs_qty_fctr: "",
			payment_ceds_certfdchrtcs_hlthIndctn: "",
			payment_ceds_certfdchrtcs_phytosntryIndctn: "",
			payment_ceds_iss_date: "",
			payment_ceds_poi_strtnm: "",
			payment_ceds_poi_pstcdid: "",
			payment_ceds_poi_twnnm: "",
			payment_ceds_poi_ctrysubdvsn: "",
			payment_ceds_poi_ctry: "",
			payment_ceds_po_issuer_nm: "",
			payment_ceds_po_issr_prtry_id: "",
			payment_ceds_po_issr_prtry_id_type: "",
			payment_ceds_po_issr_strtnm: "",
			payment_ceds_po_issr_pstcdid: "",
			payment_ceds_po_issr_twnnm: "",
			payment_ceds_po_issr_ctrysubdvsn: "",
			payment_ceds_po_issr_ctry: "",
			payment_ceds_po_inspctn_fr_dt: "",
			payment_ceds_po_inspctn_to_dt: "",
			payment_ceds_po_manfctr_nm: "",
			payment_ceds_po_manfctr_prtry_id: "",
			payment_ceds_po_manfctr_prtry_id_type: "",
			payment_ceds_po_manfctr_strtnm: "",
			payment_ceds_po_manfctr_pstcdid: "",
			payment_ceds_po_manfctr_twnnm: "",
			payment_ceds_po_manfctr_ctrysubdvsn: "",
			payment_ceds_po_manfctr_ctry: "",
			payment_certificate_ds_addtl_inf: "",
			line_item_payment_certificate: "",
			
	
				
		createItem: function()
		{
			var paymentCertificateAddtlInfText = this.get("payment_certificate_ds_addtl_inf");
			paymentCertificateAddtlInfObj = "";
			if(paymentCertificateAddtlInfText){
				paymentCertificateAddtlInfObj = new misys.openaccount.widget.PaymentCertificateAddtnlInfs();
				paymentCertificateAddtlInfObj.createItemsFromJson(paymentCertificateAddtlInfText);
			}
			var paymentCertificateLineItemText = this.get("line_item_payment_certificate");
			paymentCertificateLineItemObj = "";
			if(paymentCertificateLineItemText){
				paymentCertificateLineItemObj = new misys.openaccount.widget.PaymentCertificateLineItems();
				paymentCertificateLineItemObj.createItemsFromJson(paymentCertificateLineItemText);
			}
			var item = {
					payment_ceds_cert_type:  this.get("payment_ceds_cert_type"),
					payment_ceds_cert_type_hidden: this.get("payment_ceds_cert_type_hidden"),
					payment_cert_dataset_id: this.get("payment_cert_dataset_id"),
					payment_cert_dataset_version: this.get("payment_cert_dataset_version"),
					payment_cert_dataset_submitter_bic: this.get("payment_cert_dataset_submitter_bic"),
					payment_ceds_po_authrsd_inspctn_ind: this.get("payment_ceds_po_authrsd_inspctn_ind"),
					payment_ceds_po_cert_id: this.get("payment_ceds_po_cert_id"),
					payment_ceds_po_goods_desc: this.get("payment_ceds_po_goods_desc"),
					payment_ceds_certfdchrtcs_origin: this.get("payment_ceds_certfdchrtcs_origin"),
					payment_ceds_certfdchrtcs_qlty: this.get("payment_ceds_certfdchrtcs_qlty"),
					payment_ceds_certfdchrtcs_anlys: this.get("payment_ceds_certfdchrtcs_anlys"),
					payment_ceds_certfdchrtcs_wt_unit: this.get("payment_ceds_certfdchrtcs_wt_unit"),
					payment_ceds_certfdchrtcs_wt_othrunit: this.get("payment_ceds_certfdchrtcs_wt_othrunit"),
					payment_ceds_certfdchrtcs_wt_val: this.get("payment_ceds_certfdchrtcs_wt_val"),
					payment_ceds_certfdchrtcs_wt_fctr: this.get("payment_ceds_certfdchrtcs_wt_fctr"),
					payment_ceds_certfdchrtcs_qty_unit: this.get("payment_ceds_certfdchrtcs_qty_unit"),
					payment_ceds_certfdchrtcs_qty_othrunit: this.get("payment_ceds_certfdchrtcs_qty_othrunit"),
					payment_ceds_certfdchrtcs_qty_val: this.get("payment_ceds_certfdchrtcs_qty_val"),
					payment_ceds_certfdchrtcs_qty_fctr: this.get("payment_ceds_certfdchrtcs_qty_fctr"),
					payment_ceds_certfdchrtcs_hlthIndctn: this.get("payment_ceds_certfdchrtcs_hlthIndctn"),
					payment_ceds_certfdchrtcs_phytosntryIndctn: this.get("payment_ceds_certfdchrtcs_phytosntryIndctn"),
					
					payment_ceds_iss_date: this.get("payment_ceds_iss_date"),
					payment_ceds_poi_strtnm: this.get("payment_ceds_poi_strtnm"),
					payment_ceds_poi_pstcdid: this.get("payment_ceds_poi_pstcdid"),
					payment_ceds_poi_twnnm: this.get("payment_ceds_poi_twnnm"),
					payment_ceds_poi_ctrysubdvsn: this.get("payment_ceds_poi_ctrysubdvsn"),
					payment_ceds_poi_ctry: this.get("payment_ceds_poi_ctry"),
					payment_ceds_po_issuer_nm: this.get("payment_ceds_po_issuer_nm"),
					payment_ceds_po_issr_prtry_id: this.get("payment_ceds_po_issr_prtry_id"),
					payment_ceds_po_issr_prtry_id_type: this.get("payment_ceds_po_issr_prtry_id_type"),
					payment_ceds_po_issr_strtnm: this.get("payment_ceds_po_issr_strtnm"),
					payment_ceds_po_issr_pstcdid: this.get("payment_ceds_po_issr_pstcdid"),
					payment_ceds_po_issr_twnnm: this.get("payment_ceds_po_issr_twnnm"),
					payment_ceds_po_issr_ctrysubdvsn: this.get("payment_ceds_po_issr_ctrysubdvsn"),
					payment_ceds_po_issr_ctry: this.get("payment_ceds_po_issr_ctry"),
					payment_ceds_po_inspctn_fr_dt: this.get("payment_ceds_po_inspctn_fr_dt"),
					payment_ceds_po_inspctn_to_dt: this.get("payment_ceds_po_inspctn_to_dt"),
					payment_ceds_po_manfctr_nm: this.get("payment_ceds_po_manfctr_nm"),
					payment_ceds_po_manfctr_prtry_id: this.get("payment_ceds_po_manfctr_prtry_id"),
					payment_ceds_po_manfctr_prtry_id_type: this.get("payment_ceds_po_manfctr_prtry_id_type"),
					payment_ceds_po_manfctr_strtnm: this.get("payment_ceds_po_manfctr_strtnm"),
					payment_ceds_po_manfctr_pstcdid: this.get("payment_ceds_po_manfctr_pstcdid"),
					payment_ceds_po_manfctr_twnnm: this.get("payment_ceds_po_manfctr_twnnm"),
					payment_ceds_po_manfctr_ctrysubdvsn: this.get("payment_ceds_po_manfctr_ctrysubdvsn"),
					payment_ceds_po_manfctr_ctry: this.get("payment_ceds_po_manfctr_ctry"),
					payment_certificate_ds_addtl_inf: "",
					line_item_payment_certificate: ""
					
										
			};
			if(this.hasChildren && this.hasChildren())
			{
				dojo.forEach(this.getChildren(), function(child){
					if (child.createItem)
					{
						var items = child.createItem();
						if (items != null)
						{
							dojo.mixin(item, items);
						}
					}
				}, this);
    		}
    		return item;
		},

		constructor: function()
		{
			console.debug("[CertificateDatasetDetail] constructor");
		}
	}
);