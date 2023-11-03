<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				exclude-result-prefixes="service">
	
<!--
   Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->	
	<!-- Common elements to save among all products -->
	<xsl:include href="lt.xsl"/>
	<!-- Process Import Open Account -->
	<xsl:template match="io_tnx_record">
<!-- Retrieve references from DB -->
		<!-- Declare variable at top-level to make them visible from any templates -->
		<xsl:variable name="references" select="service:manageReferences(//product_code, //ref_id, //tnx_id, //bo_ref_id, //cust_ref_id, //company_id, //company_name, //buyer_reference, //issuing_bank/abbv_name, '01')"/>
	
		<xsl:variable name="ref_id" select="$references/references/ref_id"/>
		<xsl:variable name="tnx_id" select="$references/references/tnx_id"/>
		<xsl:variable name="company_id" select="$references/references/company_id"/>
		<xsl:variable name="company_name" select="$references/references/company_name"/>
		<xsl:variable name="entity" select="$references/references/entity"/>
		<xsl:variable name="main_bank_abbv_name" select="$references/references/main_bank_abbv_name"/>
		<xsl:variable name="main_bank_name" select="$references/references/main_bank_name"/>
		<xsl:variable name="customer_bank_reference" select="$references/references/customer_bank_reference"/>
		<result>
			<com.misys.portal.openaccount.product.io.common.ImportOpenAccount>
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="$company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="entity">
					<entity>
						<xsl:value-of select="$entity"/>
					</entity>
				</xsl:if>
				<xsl:if test="company_name">
					<company_name>
						<xsl:value-of select="$company_name"/>
					</company_name>
				</xsl:if>
				<xsl:if test="product_code">
					<product_code>
						<xsl:value-of select="product_code"/>
					</product_code>
				</xsl:if>
				<xsl:if test="po_ref_id">
					<po_ref_id>
						<xsl:value-of select="po_ref_id"/>
					</po_ref_id>
				</xsl:if>
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>	
				<xsl:if test="template_id">
					<template_id>
						<xsl:value-of select="template_id"/>
					</template_id>
				</xsl:if>
				<xsl:if test="template_description">
					<template_description>
						<xsl:value-of select="template_description"/>
					</template_description>
				</xsl:if>
				<xsl:if test="tnx_val_date">
					<tnx_val_date>
						<xsl:value-of select="tnx_val_date"/>
					</tnx_val_date>
				</xsl:if>
				<xsl:if test="appl_date">
					<appl_date>
						<xsl:value-of select="appl_date"/>
					</appl_date>
				</xsl:if>
				<xsl:if test="iss_date">
					<iss_date>
						<xsl:value-of select="iss_date"/>
					</iss_date>
				</xsl:if>
				<xsl:if test="due_date">
					<due_date>
							<xsl:value-of select="due_date"/>
					</due_date>
				</xsl:if>
				<xsl:if test="amd_date">
					<amd_date>
						<xsl:value-of select="amd_date"/>
					</amd_date>
				</xsl:if>
				<xsl:if test="amd_no">
					<amd_no>
						<xsl:value-of select="amd_no"/>
					</amd_no>
				</xsl:if>
				<xsl:if test="last_ship_date">
					<last_ship_date>
						<xsl:value-of select="last_ship_date"/>
					</last_ship_date>
				</xsl:if>
				<xsl:if test="tnx_cur_code">
					<tnx_cur_code>
						<xsl:value-of select="tnx_cur_code"/>
					</tnx_cur_code>
				</xsl:if>
				<xsl:if test="freight_charges_type">
					<freight_charges_type>
						<xsl:value-of select="freight_charges_type"/>
					</freight_charges_type>
				</xsl:if>
				<xsl:if test="payment_terms_type">
					<payment_terms_type>
						<xsl:value-of select="payment_terms_type"/>
					</payment_terms_type>
				</xsl:if>
				<xsl:if test="goods_desc">
					<goods_desc>
						<xsl:value-of select="goods_desc"/>
					</goods_desc>
				</xsl:if>				
				<xsl:if test="tnx_amt">
					<tnx_amt>
						<xsl:value-of select="tnx_amt"/>
					</tnx_amt>
				</xsl:if>
				<!-- IO Amount? -->
				<xsl:if test="total_cur_code">
					<total_cur_code>
						<xsl:value-of select="total_cur_code"/>
					</total_cur_code>
				</xsl:if>
				<xsl:if test="total_amt">
					<total_amt>
						<xsl:value-of select="total_amt"/>
					</total_amt>
				</xsl:if>
				<xsl:if test="total_net_cur_code">
					<total_net_cur_code>
						<xsl:value-of select="total_net_cur_code"/>
					</total_net_cur_code>
				</xsl:if>
				<xsl:if test="total_net_amt">
					<total_net_amt>
						<xsl:value-of select="total_net_amt"/>
					</total_net_amt>
				</xsl:if>
				<xsl:if test="order_total_cur_code">
					<order_total_cur_code>
						<xsl:value-of select="order_total_cur_code"/>
					</order_total_cur_code>
				</xsl:if>
				<xsl:if test="order_total_amt">
					<order_total_amt>
						<xsl:value-of select="order_total_amt"/>
					</order_total_amt>
				</xsl:if>
				<xsl:if test="order_total_net_cur_code">
					<order_total_net_cur_code>
							<xsl:value-of select="order_total_net_cur_code"/>
					</order_total_net_cur_code>
				</xsl:if>
				<xsl:if test="order_total_net_amt">
					<order_total_net_amt>
						<xsl:value-of select="order_total_net_amt"/>
					</order_total_net_amt>
				</xsl:if>
				<xsl:if test="accpt_total_cur_code">
					<accpt_total_cur_code>
						<xsl:value-of select="accpt_total_cur_code"/>
					</accpt_total_cur_code>
				</xsl:if>
				<xsl:if test="accpt_total_amt">
					<accpt_total_amt>
						<xsl:value-of select="accpt_total_amt"/>
					</accpt_total_amt>
				</xsl:if>
				<xsl:if test="accpt_total_net_cur_code">
					<accpt_total_net_cur_code>
						<xsl:value-of select="accpt_total_net_cur_code"/>
					</accpt_total_net_cur_code>
				</xsl:if>
				<xsl:if test="accpt_total_net_amt">
					<accpt_total_net_amt>
						<xsl:value-of select="accpt_total_net_amt"/>
					</accpt_total_net_amt>
				</xsl:if>
				<xsl:if test="liab_total_cur_code">
					<liab_total_cur_code>
						<xsl:value-of select="liab_total_cur_code"/>
					</liab_total_cur_code>
				</xsl:if>
				<xsl:if test="liab_total_amt">
					<liab_total_amt>
						<xsl:value-of select="liab_total_amt"/>
					</liab_total_amt>
				</xsl:if>
				<xsl:if test="liab_total_net_cur_code">
					<liab_total_net_cur_code>
						<xsl:value-of select="liab_total_net_cur_code"/>
					</liab_total_net_cur_code>
				</xsl:if>
				<xsl:if test="liab_total_net_amt">
					<liab_total_net_amt>
						<xsl:value-of select="liab_total_net_amt"/>
					</liab_total_net_amt>
				</xsl:if>
				<xsl:if test="tnx_type_code">
					<tnx_type_code>
						<xsl:value-of select="tnx_type_code"/>
					</tnx_type_code>
				</xsl:if>
				<xsl:if test="sub_tnx_type_code">
					<sub_tnx_type_code>
						<xsl:value-of select="sub_tnx_type_code"/>
					</sub_tnx_type_code>
				</xsl:if>
				<xsl:if test="prod_stat_code">
					<prod_stat_code>
						<xsl:value-of select="prod_stat_code"/>
					</prod_stat_code>
				</xsl:if>
				<xsl:if test="tnx_stat_code">
					<tnx_stat_code>
						<xsl:value-of select="tnx_stat_code"/>
					</tnx_stat_code>
				</xsl:if>
				<xsl:if test="cust_ref_id">
					<cust_ref_id>
						<xsl:value-of select="cust_ref_id"/>
					</cust_ref_id>
				</xsl:if>
				<xsl:if test="po_ref_id">
					<po_ref_id>
						<xsl:value-of select="po_ref_id"/>
					</po_ref_id>
				</xsl:if>
				<xsl:if test="bo_ref_id">
					<bo_ref_id>
						<xsl:value-of select="bo_ref_id"/>
					</bo_ref_id>
				</xsl:if>
				<xsl:if test="tma_used_status">
					<tma_used_status>
						<xsl:value-of select="tma_used_status"/>
					</tma_used_status>
				</xsl:if>
				<xsl:if test="bpo_used_status">
					<bpo_used_status>
						<xsl:value-of select="bpo_used_status"/>
					</bpo_used_status>
				</xsl:if>
				<xsl:if test="exp_date">
					<exp_date>
						<xsl:value-of select="exp_date"/>
					</exp_date>
				</xsl:if>
				<xsl:if test="expiry_place">
					<expiry_place>
						<xsl:value-of select="expiry_place"/>
					</expiry_place>
				</xsl:if>
				<xsl:if test="invoice_iss_date">
					<invoice_iss_date>
						<xsl:value-of select="invoice_iss_date" />
					</invoice_iss_date>
				</xsl:if>
				<xsl:if test="invoice_number">
					<invoice_number>
						<xsl:value-of select="invoice_number" />
					</invoice_number>
				</xsl:if>
				<xsl:if test="payment_amt">
					<payment_amt>
						<xsl:value-of select="payment_amt" />
					</payment_amt>
				</xsl:if>
				<xsl:if test="payment_due_date">
					<payment_due_date>
						<xsl:value-of select="payment_due_date" />
					</payment_due_date>
				</xsl:if>
				<!-- documents required-->
				<xsl:if test="reqrd_commercial_dataset">
					<reqrd_commercial_dataset>
						<xsl:value-of select="reqrd_commercial_dataset"/>
					</reqrd_commercial_dataset>
				</xsl:if>
				<xsl:if test="reqrd_transport_dataset">
					<reqrd_transport_dataset>
						<xsl:value-of select="reqrd_transport_dataset"/>
					</reqrd_transport_dataset>
				</xsl:if>
				<xsl:if test="last_match_date">
					<last_match_date>
						<xsl:value-of select="last_match_date"/>
					</last_match_date>
				</xsl:if>
				<xsl:if test="outstanding_total_net_amt">
					<outstanding_total_net_amt>
						<xsl:value-of select="outstanding_total_net_amt" />
					</outstanding_total_net_amt>
				</xsl:if>
				<xsl:if test="pending_total_amt">
					<pending_total_amt>
						<xsl:value-of select="pending_total_amt" />
					</pending_total_amt>
				</xsl:if>
				<xsl:if test="pending_total_net_amt">
					<pending_total_net_amt>
						<xsl:value-of select="pending_total_net_amt" />
					</pending_total_net_amt>
				</xsl:if>
				<!-- Previous ctl date, used for synchronisation issues -->
				<xsl:if test="old_ctl_dttm">
					<additional_field name="old_ctl_dttm" type="time" scope="none" description=" Previous control date used for synchronisation issues">
						<xsl:value-of select="old_ctl_dttm"/>
					</additional_field>
				</xsl:if>
				 <!-- Previous input date, used to know if the product is already saved -->
				<xsl:if test="old_inp_dttm">
					<additional_field name="old_inp_dttm" type="time" scope="none" description="Previous input date used for synchronisation issues">
						<xsl:value-of select="old_inp_dttm"/>
					</additional_field>
				</xsl:if>
				
				<!-- Shipment Details-->
				<xsl:if test="part_ship">
					<part_ship>
						<xsl:value-of select="part_ship"/>
					</part_ship>
				</xsl:if>
				<xsl:if test="tran_ship">
					<tran_ship>
						<xsl:value-of select="tran_ship"/>
					</tran_ship>
				</xsl:if>
				<!-- Seller -->
				<xsl:if test="seller_abbv_name">
					<seller_abbv_name>
						<xsl:value-of select="seller_abbv_name"/>
					</seller_abbv_name>
				</xsl:if>
				<xsl:if test="seller_name">
					<seller_name>
						<xsl:value-of select="seller_name"/>
					</seller_name>
				</xsl:if>
				<xsl:if test="seller_bei">
					<seller_bei>
						<xsl:value-of select="seller_bei"/>
					</seller_bei>
				</xsl:if>
				<xsl:if test="seller_street_name">
					<seller_street_name>
						<xsl:value-of select="seller_street_name"/>
					</seller_street_name>
				</xsl:if>
				<xsl:if test="seller_post_code">
					<seller_post_code>
						<xsl:value-of select="seller_post_code"/>
					</seller_post_code>
				</xsl:if>
				<xsl:if test="seller_town_name">
					<seller_town_name>
						<xsl:value-of select="seller_town_name"/>
					</seller_town_name>
				</xsl:if>
				<xsl:if test="seller_country_sub_div">
					<seller_country_sub_div>
						<xsl:value-of select="seller_country_sub_div"/>
					</seller_country_sub_div>
				</xsl:if>
				<xsl:if test="seller_country">
					<seller_country>
						<xsl:value-of select="seller_country"/>
					</seller_country>
				</xsl:if>
				<xsl:if test="seller_reference">
					<seller_reference>
							<xsl:value-of select="seller_reference"/>
					</seller_reference>
				</xsl:if>
				<!-- Buyer -->
				<xsl:if test="buyer_abbv_name">
					<buyer_abbv_name>
						<xsl:value-of select="buyer_abbv_name"/>
					</buyer_abbv_name>
				</xsl:if>
				<xsl:if test="buyer_name">
					<buyer_name>
						<xsl:value-of select="buyer_name"/>
					</buyer_name>
				</xsl:if>
				<xsl:if test="buyer_bei">
					<buyer_bei>
						<xsl:value-of select="buyer_bei"/>
					</buyer_bei>
				</xsl:if>
				<xsl:if test="buyer_street_name">
					<buyer_street_name>
						<xsl:value-of select="buyer_street_name"/>
					</buyer_street_name>
				</xsl:if>
				<xsl:if test="buyer_post_code">
					<buyer_post_code>
						<xsl:value-of select="buyer_post_code"/>
					</buyer_post_code>
				</xsl:if>
				<xsl:if test="buyer_town_name">
					<buyer_town_name>
						<xsl:value-of select="buyer_town_name"/>
					</buyer_town_name>
				</xsl:if>
				<xsl:if test="buyer_country_sub_div">
					<buyer_country_sub_div>
						<xsl:value-of select="buyer_country_sub_div"/>
					</buyer_country_sub_div>
				</xsl:if>
				<xsl:if test="buyer_country">
					<buyer_country>
						<xsl:value-of select="buyer_country"/>
					</buyer_country>
				</xsl:if>
				<xsl:if test="buyer_reference">
					<buyer_reference>
						<xsl:value-of select="$customer_bank_reference"/>
					</buyer_reference>
				</xsl:if>
				<!-- Bill to -->
				<xsl:if test="bill_to_abbv_name">
					<bill_to_abbv_name>
						<xsl:value-of select="bill_to_abbv_name"/>
					</bill_to_abbv_name>
				</xsl:if>
				<xsl:if test="bill_to_name">
					<bill_to_name>
						<xsl:value-of select="bill_to_name"/>
					</bill_to_name>
				</xsl:if>
				<xsl:if test="bill_to_bei">
					<bill_to_bei>
						<xsl:value-of select="bill_to_bei"/>
					</bill_to_bei>
				</xsl:if>
				<xsl:if test="bill_to_street_name">
					<bill_to_street_name>
						<xsl:value-of select="bill_to_street_name"/>
					</bill_to_street_name>
				</xsl:if>
				<xsl:if test="bill_to_post_code">
					<bill_to_post_code>
						<xsl:value-of select="bill_to_post_code"/>
					</bill_to_post_code>
				</xsl:if>
				<xsl:if test="bill_to_town_name">
					<bill_to_town_name>
						<xsl:value-of select="bill_to_town_name"/>
					</bill_to_town_name>
				</xsl:if>
				<xsl:if test="bill_to_country_sub_div">
					<bill_to_country_sub_div>
						<xsl:value-of select="bill_to_country_sub_div"/>
					</bill_to_country_sub_div>
				</xsl:if>
				<xsl:if test="bill_to_country">
					<bill_to_country>
						<xsl:value-of select="bill_to_country"/>
					</bill_to_country>
				</xsl:if>
				<!-- Ship to -->
				<xsl:if test="ship_to_abbv_name">
					<ship_to_abbv_name>
						<xsl:value-of select="ship_to_abbv_name"/>
					</ship_to_abbv_name>
				</xsl:if>
				<xsl:if test="ship_to_name">
					<ship_to_name>
						<xsl:value-of select="ship_to_name"/>
					</ship_to_name>
				</xsl:if>
				<xsl:if test="ship_to_bei">
					<ship_to_bei>
						<xsl:value-of select="ship_to_bei"/>
					</ship_to_bei>
				</xsl:if>
				<xsl:if test="ship_to_street_name">
					<ship_to_street_name>
						<xsl:value-of select="ship_to_street_name"/>
					</ship_to_street_name>
				</xsl:if>
				<xsl:if test="ship_to_post_code">
					<ship_to_post_code>
						<xsl:value-of select="ship_to_post_code"/>
					</ship_to_post_code>
				</xsl:if>
				<xsl:if test="ship_to_town_name">
					<ship_to_town_name>
						<xsl:value-of select="ship_to_town_name"/>
					</ship_to_town_name>
				</xsl:if>
				<xsl:if test="ship_to_country_sub_div">
					<ship_to_country_sub_div>
						<xsl:value-of select="ship_to_country_sub_div"/>
					</ship_to_country_sub_div>
				</xsl:if>
				<xsl:if test="ship_to_country">
					<ship_to_country>
						<xsl:value-of select="ship_to_country"/>
					</ship_to_country>
				</xsl:if>
				<!-- Consignee -->
				<xsl:if test="consgn_abbv_name">
					<consgn_abbv_name>
						<xsl:value-of select="consgn_abbv_name"/>
					</consgn_abbv_name>
				</xsl:if>
				<xsl:if test="consgn_name">
					<consgn_name>
						<xsl:value-of select="consgn_name"/>
					</consgn_name>
				</xsl:if>
				<xsl:if test="consgn_bei">
					<consgn_bei>
						<xsl:value-of select="consgn_bei"/>
					</consgn_bei>
				</xsl:if>
				<xsl:if test="consgn_street_name">
					<consgn_street_name>
						<xsl:value-of select="consgn_street_name"/>
					</consgn_street_name>
				</xsl:if>
				<xsl:if test="consgn_post_code">
					<consgn_post_code>
						<xsl:value-of select="consgn_post_code"/>
					</consgn_post_code>
				</xsl:if>
				<xsl:if test="consgn_town_name">
					<consgn_town_name>
						<xsl:value-of select="consgn_town_name"/>
					</consgn_town_name>
				</xsl:if>
				<xsl:if test="consgn_country_sub_div">
					<consgn_country_sub_div>
						<xsl:value-of select="consgn_country_sub_div"/>
					</consgn_country_sub_div>
				</xsl:if>
				<xsl:if test="consgn_country">
					<consgn_country>
						<xsl:value-of select="consgn_country"/>
					</consgn_country>
				</xsl:if>
				<!-- Seller Account -->
				<xsl:if test="seller_account_name">
					<seller_account_name>
						<xsl:value-of select="seller_account_name"/>
					</seller_account_name>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="seller_account_type[.='IBAN']">
						<seller_account_iban>
							<xsl:value-of select="seller_account_value"/>
						</seller_account_iban>
						<seller_account_bban/>
						<seller_account_upic/>
						<seller_account_id/>
					</xsl:when>
					<xsl:when test="seller_account_type[.='BBAN']">
						<seller_account_bban>
							<xsl:value-of select="seller_account_value"/>
						</seller_account_bban>
						<seller_account_iban/>
						<seller_account_upic/>
						<seller_account_id/>
					</xsl:when>
					<xsl:when test="seller_account_type[.='UPIC']">
						<seller_account_upic>
							<xsl:value-of select="seller_account_value"/>
						</seller_account_upic>
						<seller_account_bban/>
						<seller_account_iban/>
						<seller_account_id/>
					</xsl:when>
					<xsl:when test="seller_account_type[.='OTHER']">
						<seller_account_id>
							<xsl:value-of select="seller_account_value"/>
						</seller_account_id>
						<seller_account_bban/>
						<seller_account_upic/>
						<seller_account_iban/>
					</xsl:when>
				</xsl:choose>
				<!-- Financial Institution -->
				<xsl:if test="fin_inst_name">
					<fin_inst_name>
						<xsl:value-of select="fin_inst_name"/>
					</fin_inst_name>
				</xsl:if>
				<xsl:if test="fin_inst_bic">
					<fin_inst_bic>
						<xsl:value-of select="fin_inst_bic"/>
					</fin_inst_bic>
				</xsl:if>
				<xsl:if test="fin_inst_street_name">
					<fin_inst_street_name>
						<xsl:value-of select="fin_inst_street_name"/>
					</fin_inst_street_name>
				</xsl:if>
				<xsl:if test="fin_inst_post_code">
					<fin_inst_post_code>
						<xsl:value-of select="fin_inst_post_code"/>
					</fin_inst_post_code>
				</xsl:if>
				<xsl:if test="fin_inst_town_name">
					<fin_inst_town_name>
						<xsl:value-of select="fin_inst_town_name"/>
					</fin_inst_town_name>
				</xsl:if>
				<xsl:if test="fin_inst_country_sub_div">
					<fin_inst_country_sub_div>
						<xsl:value-of select="fin_inst_country_sub_div"/>
					</fin_inst_country_sub_div>
				</xsl:if>
				<xsl:if test="fin_inst_country">
					<fin_inst_country>
						<xsl:value-of select="fin_inst_country"/>
					</fin_inst_country>
				</xsl:if>
				<xsl:if test="data_set_id">
					<data_set_id>
						<xsl:value-of select="data_set_id"/>
					</data_set_id>
				</xsl:if>
				<!-- Buyer/Seller bank type -->
				<xsl:if test="buyer_bank_type_code">
					<buyer_bank_type_code>
						<xsl:value-of select="buyer_bank_type_code"/>
					</buyer_bank_type_code>
				</xsl:if>
				<xsl:if test="seller_bank_type_code">
					<seller_bank_type_code>
						<xsl:value-of select="seller_bank_type_code"/>
					</seller_bank_type_code>
				</xsl:if>
				<xsl:if test="issuer_type_code">
					<issuer_type_code>
						<xsl:value-of select="issuer_type_code"/>
					</issuer_type_code>
				</xsl:if>
				<xsl:if test="final_presentation">
					<final_presentation>
						<xsl:value-of select="final_presentation"/>
					</final_presentation>
				</xsl:if>
				<xsl:if test="submission_type">
					<submission_type>
						<xsl:value-of select="submission_type"/>
					</submission_type>
				</xsl:if>
				<xsl:if test="tid">
					<tid>
						<xsl:value-of select="tid"/>
					</tid>
				</xsl:if>
				<!-- Financing Request flag -->
				<xsl:if test="supplier_fin_request_flag">
					<additional_field name="supplier_fin_request_flag" type="string" scope="transaction" description=" Financing Request">
						<xsl:value-of select="supplier_fin_request_flag"/>
					</additional_field>
				</xsl:if>
				<!-- Financing Request flag-->
				<xsl:if test="supplier_fin_eligible_flag">
					<additional_field name="supplier_fin_eligible_flag" type="string" scope="transaction" description=" Supplier Financing Request">
						<xsl:value-of select="supplier_fin_eligible_flag"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="supplier_fin_cur_code">
					<additional_field name="supplier_fin_cur_code" type="string" scope="transaction" description=" Supplier Financing Request Currency">
						<xsl:value-of select="supplier_fin_cur_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="supplier_fin_amt">
					<additional_field name="supplier_fin_amt" type="amount" scope="transaction" currency="supplier_fin_cur_code" description=" Supplier Financing Request Amount">
						<xsl:value-of select="supplier_fin_amt"/>
					</additional_field>
				</xsl:if>
				<!-- Flags used to detect draft or controlled mode (delete or not previous elements stored into ArrayList-->
				<!-- line item -->
				<xsl:if test="count(line_items/lt_tnx_record) > 0">
					<additional_field name="hasLineItem" type="string" scope="none" description=" Flag to note if user was able to capture line items">Y</additional_field>
				</xsl:if>
				<!-- adjustment -->
				<xsl:if test="count(adjustments/allowance) > 0">
					<additional_field name="hasAdjustment" type="string" scope="none" description=" Flag to note if user was able to capture adjustments">Y</additional_field>
				</xsl:if>
				<!-- tax -->
				<xsl:if test="count(taxes/allowance) > 0">
					<additional_field name="hasTax" type="string" scope="none" description=" Flag to note if user was able to capture taxes">Y</additional_field>
				</xsl:if>
				<!-- freight charge -->
				<xsl:if test="count(freight_charges/allowance) > 0">
					<additional_field name="hasFreightCharge" type="string" scope="none" description=" Flag to note if user was able to capture freight charges">Y</additional_field>
				</xsl:if>
				<!-- payment term -->
				<xsl:if test="count(payments/payment) != 0">
					<additional_field name="hasPayment" type="string" scope="none" description=" Flag to note if user was able to capture payment terms">Y</additional_field>
				</xsl:if>
				<!-- inco term -->
				<xsl:if test="count(incoterms/incoterm) > 0">
					<additional_field name="hasIncoTerm" type="string" scope="none" description=" Flag to note if user was able to capture inco terms">Y</additional_field>
				</xsl:if>
				<!-- user information -->
				<xsl:if test="count(//*/user_defined_information) != 0">
					<additional_field name="hasUserInformation" type="string" scope="none" description=" Flag to note if user was able to capture buyer informations">Y</additional_field>
				</xsl:if>
				<!-- Individual Routing Summary -->
				<xsl:if test="count(routing_summaries/rs_tnx_record) > 0 or count(routing_summaries/air_routing_summaries/rs_tnx_record) > 0 or count(routing_summaries/sea_routing_summaries/rs_tnx_record) > 0 or count(routing_summaries/road_routing_summaries/rs_tnx_record) > 0 or count(routing_summaries/rail_routing_summaries/rs_tnx_record) > 0 or ((routing_summaries/rs_tnx_record/final_dest_place or routing_summaries/rs_tnx_record/taking_in_charge) and (routing_summaries/rs_tnx_record/final_dest_place != '' or routing_summaries/rs_tnx_record/taking_in_charge != ''))">
					<additional_field name="hasRoutingSummary" type="string" scope="none" description=" Flag to note if user was able to capture summary informations">Y</additional_field>
				</xsl:if>
				<!--Multimodal Routing Summaries : TB Added later-->
				<xsl:if test="(routing_summaries/rs_tnx_record/place_of_final_destination or routing_summaries/rs_tnx_record/taking_in_charge) and (routing_summaries/rs_tnx_record/place_of_final_destination != '' or routing_summaries/rs_tnx_record/taking_in_charge != '')">
					<xsl:call-template name="multimodalRS">
						<xsl:with-param name="brchCode" select="brch_code"/>
						<xsl:with-param name="companyId" select="company_id"/>
						<xsl:with-param name="linked_ref_id" select="linked_ref_id"/>
						<xsl:with-param name="linked_tnx_id" select="linked_tnx_id"/>
						<xsl:with-param name="place_of_final_destination" select="routing_summaries/rs_tnx_record/place_of_final_destination"/>
						<xsl:with-param name="taking_in_charge" select="routing_summaries/rs_tnx_record/taking_in_charge"/>
					</xsl:call-template>
				</xsl:if>
				
				
				<!-- contact -->
				<xsl:if test="count(contacts/contact) != 0">
					<additional_field name="hasContact" type="string" scope="none" description=" Flag to note if user was able to capture contact informations">Y</additional_field>
				</xsl:if>
				<xsl:if test="invoice_cust_ref_id">
					<additional_field name="invoice_cust_ref_id" type="string" scope="transaction" description="Supplier Invoice customer reference">
						<xsl:value-of select="invoice_cust_ref_id"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code"/>
					</action_req_code>
				</xsl:if>
				<xsl:if test="seller_account_type_code">
					<seller_account_type_code>
						<xsl:value-of select="seller_account_type_code"/>
					</seller_account_type_code>
				</xsl:if>
				<xsl:if test="seller_account_type_prop">
					<seller_account_type_prop>
						<xsl:value-of select="seller_account_type_prop"/>
					</seller_account_type_prop>
				</xsl:if>
				<xsl:if test="earliest_ship_date">
					<earliest_ship_date>
						<xsl:value-of select="earliest_ship_date"/>
					</earliest_ship_date>
				</xsl:if>
				<xsl:if test="tma_version_no">
					<tma_version_no>
						<xsl:value-of select="tma_version_no"/>
					</tma_version_no>
				</xsl:if>
				<xsl:if test="seller_account_cur_code">
					<seller_account_cur_code>
						<xsl:value-of select="seller_account_cur_code"/>
					</seller_account_cur_code>
				</xsl:if>
				<xsl:if test="intent_to_pay_flag">
					<intent_to_pay_flag>
						<xsl:value-of select="intent_to_pay_flag"/>
					</intent_to_pay_flag>
				</xsl:if>
				<xsl:if test="buyer_proprietary_id">
					<buyer_proprietary_id>
						<xsl:value-of select="buyer_proprietary_id"/>
					</buyer_proprietary_id>
				</xsl:if>
				<xsl:if test="buyer_proprietary_id_type">
					<buyer_proprietary_id_type>
						<xsl:value-of select="buyer_proprietary_id_type"/>
					</buyer_proprietary_id_type>
				</xsl:if>
				<xsl:if test="seller_proprietary_id">
					<seller_proprietary_id>
						<xsl:value-of select="seller_proprietary_id"/>
					</seller_proprietary_id>
				</xsl:if>
				<xsl:if test="seller_proprietary_id_type">
					<seller_proprietary_id_type>
						<xsl:value-of select="seller_proprietary_id_type"/>
					</seller_proprietary_id_type>
				</xsl:if>
				<xsl:if test="buyer_submitting_bank_bic">
					<buyer_submitting_bank_bic>
						<xsl:value-of select="buyer_submitting_bank_bic"/>
					</buyer_submitting_bank_bic>
				</xsl:if>
				<xsl:if test="seller_submitting_bank_bic">
					<seller_submitting_bank_bic>
						<xsl:value-of select="seller_submitting_bank_bic"/>
					</seller_submitting_bank_bic>
				</xsl:if>
				<!-- Security -->
				<xsl:if test="token">
					<additional_field name="token" type="string" scope="none" description="Security token">
						<xsl:value-of select="token"/>
					</additional_field>
				</xsl:if>
				<!-- Re authentication -->
				<xsl:call-template name="AUTHENTICATION"/>
				<!-- collaboration -->
				<xsl:call-template name="collaboration" />
			</com.misys.portal.openaccount.product.io.common.ImportOpenAccount>
			<!-- issuing bank -->		
			<!-- Banks -->
			<com.misys.portal.product.common.Bank role_code="01">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="brch_code"/></brch_code>
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<abbv_name><xsl:value-of select="$main_bank_abbv_name"/></abbv_name>
				<xsl:if test="issuing_bank/name"><name><xsl:value-of select="issuing_bank/name"/></name></xsl:if>
				<xsl:if test="$main_bank_name and not(issuing_bank/name)"><name><xsl:value-of select="$main_bank_name"/></name></xsl:if>
				<xsl:if test="issuing_bank/address_line_1"><address_line_1><xsl:value-of select="issuing_bank/address_line_1"/></address_line_1></xsl:if>
				<xsl:if test="issuing_bank/address_line_2"><address_line_2><xsl:value-of select="issuing_bank/address_line_2"/></address_line_2></xsl:if>
				<xsl:if test="issuing_bank/dom"><dom><xsl:value-of select="issuing_bank/dom"/></dom></xsl:if>
				<xsl:if test="issuing_bank/iso_code"><iso_code><xsl:value-of select="issuing_bank/iso_code"/></iso_code></xsl:if>
				<xsl:if test="issuing_bank/reference"><reference><xsl:value-of select="issuing_bank/reference"/></reference></xsl:if>
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Bank role_code="02">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="advising_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="advising_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="advising_bank_name">
					<name>
						<xsl:value-of select="advising_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="advising_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="advising_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="advising_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="advising_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="advising_bank_dom">
					<dom>
						<xsl:value-of select="advising_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="advising_bank_iso_code">
					<iso_code>
						<xsl:value-of select="advising_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="advising_bank_reference">
					<reference>
						<xsl:value-of select="advisingB_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Bank role_code="14">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="seller_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="seller_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="seller_bank_name">
					<name>
						<xsl:value-of select="seller_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="seller_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="seller_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="seller_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="seller_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="seller_bank_dom">
					<dom>
						<xsl:value-of select="seller_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="seller_bank_iso_code">
					<iso_code>
						<xsl:value-of select="seller_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="seller_bank_reference">
					<reference>
						<xsl:value-of select="seller_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Bank role_code="15">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="buyer_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="buyer_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="buyer_bank_name">
					<name>
						<xsl:value-of select="buyer_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="buyer_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="buyer_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="buyer_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="buyer_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="buyer_bank_dom">
					<dom>
						<xsl:value-of select="buyer_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="buyer_bank_iso_code">
					<iso_code>
						<xsl:value-of select="buyer_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="buyer_bank_reference">
					<reference>
						<xsl:value-of select="buyer_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Narrative type_code="11">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="return_comments">
					<text>
						<xsl:value-of select="return_comments" />
					</text>
				</xsl:if>
				<xsl:if test="bo_comment">
					<text>
						<xsl:value-of select="bo_comment"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="12">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="free_format_text">
					<text>
						<xsl:value-of select="free_format_text"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="21">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="commercial_dataset">
					<text>
						<xsl:value-of select="commercial_dataset" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="22">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="transport_dataset">
					<text>
						<xsl:value-of select="transport_dataset" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="23">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="insurance_dataset">
					<text>
						<xsl:value-of select="insurance_dataset" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="24">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="certificate_dataset">
					<text>
						<xsl:value-of select="certificate_dataset" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="25">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="other_certificate_dataset">
					<text>
						<xsl:value-of select="other_certificate_dataset" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="26">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
				
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				 <xsl:if test="bank_payment_obligation/bpo">
					<text>
						<xsl:value-of select="bank_payment_obligation/bpo" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			
			<com.misys.portal.product.common.Narrative type_code="28">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
				
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="forward_dataset_submission">
					<text>
						<xsl:value-of select="forward_dataset_submission" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="29">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
				
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="dataset_match_report">
					<text>
						<xsl:value-of select="dataset_match_report" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="30">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
				
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="baseline_report">
					<text>
						<xsl:value-of select="baseline_report" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="31">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
				
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="full_push_through_report">
					<text>
						<xsl:value-of select="full_push_through_report" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			
			<com.misys.portal.product.common.Narrative type_code="32">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
				
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="delta_report">
					<text>
						<xsl:value-of select="delta_report" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			
			<com.misys.portal.product.common.Narrative type_code="34">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
				
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="mismatches">
					<text>
						<xsl:value-of select="mismatches" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			
			<com.misys.portal.product.common.Narrative type_code="35">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
				
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="payment_transport_dataset">
					<text>
						<xsl:value-of select="payment_transport_dataset" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			
			<com.misys.portal.product.common.Narrative type_code="36">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
				
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="baseline_match_report">
					<text>
						<xsl:value-of select="baseline_match_report" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			
			<com.misys.portal.product.common.Narrative type_code="37">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
				
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="payment_certificate_dataset">
					<text>
						<xsl:value-of select="payment_certificate_dataset" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			
			<com.misys.portal.product.common.Narrative type_code="38">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
				
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="payment_insurance_dataset">
					<text>
						<xsl:value-of select="payment_insurance_dataset" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			
			<com.misys.portal.product.common.Narrative type_code="39">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
				
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="payment_other_certificate_dataset">
					<text>
						<xsl:value-of select="payment_other_certificate_dataset" />
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
		
			<xsl:apply-templates select="bank_payment_obligation/bpo_xml/PmtOblgtn">
				<xsl:with-param name="brchCode" select="brch_code"/>
				<xsl:with-param name="companyId" select="company_id"/>
				<xsl:with-param name="refId" select="ref_id"/>
				<xsl:with-param name="tnxId" select="tnx_id"/>
			</xsl:apply-templates> 
			
			<!--Allowances (Adjustments)-->
			<xsl:apply-templates select="adjustments/allowance">
				<xsl:with-param name="brchCode" select="brch_code"/>
				<xsl:with-param name="companyId" select="company_id"/>
				<xsl:with-param name="refId" select="ref_id"/>
				<xsl:with-param name="tnxId" select="tnx_id"/>
			</xsl:apply-templates>
			
			<!--Allowances (Tax)-->
			<xsl:apply-templates select="taxes/allowance">
				<xsl:with-param name="brchCode" select="brch_code"/>
				<xsl:with-param name="companyId" select="company_id"/>
				<xsl:with-param name="refId" select="ref_id"/>
				<xsl:with-param name="tnxId" select="tnx_id"/>
			</xsl:apply-templates>
			
			<!--Allowances (Freight charge)-->
			<xsl:apply-templates select="freight_charges/allowance">
				<xsl:with-param name="brchCode" select="brch_code"/>
				<xsl:with-param name="companyId" select="company_id"/>
				<xsl:with-param name="refId" select="ref_id"/>
				<xsl:with-param name="tnxId" select="tnx_id"/>
			</xsl:apply-templates>
			
			<!--Contacts-->
			<xsl:apply-templates select="contacts/contact">
				<xsl:with-param name="brchCode" select="brch_code"/>
				<xsl:with-param name="companyId" select="company_id"/>
				<xsl:with-param name="refId" select="ref_id"/>
				<xsl:with-param name="tnxId" select="tnx_id"/>
			</xsl:apply-templates>
			
			<!--Payement terms-->
			<xsl:apply-templates select="payments/payment">
				<xsl:with-param name="brchCode" select="brch_code"/>
				<xsl:with-param name="companyId" select="company_id"/>
				<xsl:with-param name="refId" select="ref_id"/>
				<xsl:with-param name="tnxId" select="tnx_id"/>
				<xsl:with-param name="payment_terms_type" select="payment_terms_type"/>
			</xsl:apply-templates>
			
			<!--Buyer information & Seller Information -->
			<xsl:apply-templates select="user_defined_informations/user_defined_information">
				<xsl:with-param name="brchCode" select="brch_code"/>
				<xsl:with-param name="companyId" select="company_id"/>
				<xsl:with-param name="refId" select="$ref_id"/>
				<xsl:with-param name="tnxId" select="$tnx_id"/>
			</xsl:apply-templates>

			<!--Incoterm -->
			<xsl:apply-templates select="incoterms/incoterm">
				<xsl:with-param name="brchCode" select="brch_code"/>
				<xsl:with-param name="companyId" select="$company_id"/>
				<xsl:with-param name="refId" select="$ref_id"/>
				<xsl:with-param name="tnxId" select="$tnx_id"/>
			</xsl:apply-templates>

			<!--Individual Routing Summaries -->
			 <xsl:apply-templates select="routing_summaries/air_routing_summaries/rs_tnx_record | routing_summaries/sea_routing_summaries/rs_tnx_record | routing_summaries/rail_routing_summaries/rs_tnx_record | routing_summaries/road_routing_summaries/rs_tnx_record">
				<xsl:with-param name="brchCode" select="brch_code"/>
				<xsl:with-param name="companyId" select="$company_id"/>
				<xsl:with-param name="linked_ref_id" select="$ref_id"/>
				<xsl:with-param name="linked_tnx_id" select="$tnx_id"/>
			</xsl:apply-templates>
			
			<!-- Line Items -->
			<xsl:apply-templates select="line_items/lt_tnx_record">
				<xsl:with-param name="ref_id"><xsl:value-of select="ref_id"/></xsl:with-param>
				<xsl:with-param name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:with-param>
				<!-- <xsl:with-param name="brchCode"><xsl:value-of select="brch_code"/></xsl:with-param> -->
				<xsl:with-param name="companyId"><xsl:value-of select="company_id"/></xsl:with-param>
				<!-- <xsl:with-param name="companyName"><xsl:value-of select="company_name"/></xsl:with-param>
				<xsl:with-param name="entity"><xsl:value-of select="entity"/></xsl:with-param> -->
			</xsl:apply-templates>
			
				<!-- Cross References -->
			<xsl:apply-templates select="cross_references/cross_reference"/>
			
			<!-- Create Attachment elements -->
			<xsl:if test="tnx_stat_code">
                <xsl:apply-templates select="attachments/attachment">
                   <xsl:with-param name="tnx_stat_code" select="tnx_stat_code"/>
                   <xsl:with-param name="ref_id" select="$ref_id"/>
                   <xsl:with-param name="tnx_id" select="$tnx_id"/>
                   <xsl:with-param name="company_id" select="$company_id"/>
                </xsl:apply-templates>
            </xsl:if>
		</result>
	</xsl:template>
	
	 <xsl:template match="bank_payment_obligation/bpo_xml/PmtOblgtn">
			<xsl:param name="brchCode" />
			<xsl:param name="companyId" />
			<xsl:param name="refId" />
			<xsl:param name="tnxId" />
			<com.misys.portal.openaccount.product.baseline.util.BankPaymentObligation>
				<xsl:if test="$refId">
					<xsl:attribute name="ref_id"><xsl:value-of select="$refId" /></xsl:attribute>
				</xsl:if>
				<xsl:if test="$tnxId">
					<xsl:attribute name="tnx_id"><xsl:value-of select="$tnxId" /></xsl:attribute>
				</xsl:if>
		
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code" />
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id" />
					</company_id>
				</xsl:if>
				<xsl:if test="OblgrBk/BIC">
					<obligor_bank_bic>
						<xsl:value-of select="OblgrBk/BIC" />
					</obligor_bank_bic>
				</xsl:if>
				<xsl:if test="RcptBk/BIC">
					<recipient_bank_bic>
						<xsl:value-of select="RcptBk/BIC" />
					</recipient_bank_bic>
				</xsl:if>
				<xsl:if test="XpryDt">
					<expiry_date>
						<xsl:value-of select="XpryDt" />
					</expiry_date>
				</xsl:if>
				<xsl:if test="AplblLaw">
					<applicable_law>
						<xsl:value-of select="AplblLaw" />
					</applicable_law>
				</xsl:if>
				<xsl:if test="SttlmTerms/CdtrAgt/BIC">
					<creditor_agent_bic>
						<xsl:value-of select="SttlmTerms/CdtrAgt/BIC" />
					</creditor_agent_bic>
				</xsl:if>
				<xsl:if test="SttlmTerms/CdtrAgt/NmAndAdr/Nm">
					<creditor_agent_name>
						<xsl:value-of select="SttlmTerms/CdtrAgt/NmAndAdr/Nm" />
					</creditor_agent_name>
				</xsl:if>
				<xsl:variable name="idIban">
					<xsl:value-of select="SttlmTerms/CdtrAcct/Id/IBAN" />
				</xsl:variable>
				<xsl:variable name="idBban">
					<xsl:value-of select="SttlmTerms/CdtrAcct/Id/BBAN" />
				</xsl:variable>
				<xsl:variable name="idUpic">
					<xsl:value-of select="SttlmTerms/CdtrAcct/Id/UPIC" />
				</xsl:variable>
				<xsl:variable name="idProp">
					<xsl:value-of select="SttlmTerms/CdtrAcct/Id/PrtryAcct/Id" />
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$idIban != ''">
						<creditor_account_id>
							<xsl:value-of select="$idIban" />
						</creditor_account_id>
					</xsl:when>
					<xsl:when test="$idBban != ''">
						<creditor_account_id>
							<xsl:value-of select="$idBban" />
						</creditor_account_id>
					</xsl:when>
					<xsl:when test="$idUpic != ''">
						<creditor_account_id>
							<xsl:value-of select="$idUpic" />
						</creditor_account_id>
					</xsl:when>
					<xsl:when test="$idProp != ''">
						<creditor_account_id>
							<xsl:value-of select="$idProp" />
						</creditor_account_id>
					</xsl:when>
				</xsl:choose>
				<xsl:variable name="accountTypeCode">
					<xsl:value-of select="SttlmTerms/CdtrAcct/Tp/Cd" />
				</xsl:variable>
				<xsl:variable name="accountTypeProp">
					<xsl:value-of select="SttlmTerms/CdtrAcct/Tp/Prtry" />
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$accountTypeCode != ''">
						<creditor_account_code>
							<xsl:value-of select="$accountTypeCode" />
						</creditor_account_code>
					</xsl:when>
					<xsl:when test="$accountTypeProp !=''">
						<creditor_account_code>
							<xsl:value-of select="$accountTypeProp" />
						</creditor_account_code>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="SttlmTerms/CdtrAcct/Nm">
					<creditor_account_name>
						<xsl:value-of select="SttlmTerms/CdtrAcct/Nm" />
					</creditor_account_name>
				</xsl:if>
				<xsl:if test="SttlmTerms/CdtrAcct/Ccy">
					<creditor_account_currency>
						<xsl:value-of select="SttlmTerms/CdtrAcct/Ccy" />
					</creditor_account_currency>
				</xsl:if>
				<xsl:if test="Amt">
					<bpo_amount>
						<xsl:value-of select="Amt" />
					</bpo_amount>
				</xsl:if>
				<xsl:if test="Pctg">
					<bpo_percent>
						<xsl:value-of select="Pctg" />
					</bpo_percent>
				</xsl:if>
				<bpo_outstanding_amt>
				</bpo_outstanding_amt>
				<xsl:if test="is_valid">
					<is_valid>
						<xsl:value-of select="is_valid" />
					</is_valid>
				</xsl:if>
			</com.misys.portal.openaccount.product.baseline.util.BankPaymentObligation>
		</xsl:template> 

</xsl:stylesheet>
