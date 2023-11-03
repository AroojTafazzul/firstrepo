<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="utils">
	
<!--
   Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>
	<!-- Common elements to save among all products -->
	<xsl:include href="../../../openaccount/xsl/products/po_save_common.xsl"/>
	<xsl:include href="../../../core/xsl/products/save_common.xsl"/>
	<xsl:include href="../../../openaccount/xsl/products/lt.xsl"/>
	<xsl:include href="rs.xsl"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Process Purchase Order -->
	<xsl:template match="ip_tnx_record">
		<result>
			<com.misys.portal.openaccount.product.ip.common.InvoicePayable>
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
				<xsl:if test="entity">
					<entity>
						<xsl:value-of select="entity"/>
					</entity>
				</xsl:if>
				<xsl:if test="company_name">
					<company_name>
						<xsl:value-of select="company_name"/>
					</company_name>
				</xsl:if>
				<xsl:if test="product_code">
					<product_code>
						<xsl:value-of select="product_code"/>
					</product_code>
				</xsl:if>
				<xsl:if test="issuer_ref_id">
					<issuer_ref_id>
						<xsl:value-of select="issuer_ref_id"/>
					</issuer_ref_id>
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
				<xsl:if test="program_id">
					<program_id><xsl:value-of select="program_id"/></program_id>
				</xsl:if>
				<xsl:if test="adjustment_cur_code">
					<adjustment_cur_code>
						<xsl:value-of select="total_cur_code"/>
					</adjustment_cur_code>
				</xsl:if>
				<xsl:if test="total_adjustments">
					<total_adjustments><xsl:value-of select="total_adjustments"/></total_adjustments>
				</xsl:if>
				<xsl:if test="template_description">
					<template_description>
						<xsl:value-of select="template_description"/>
					</template_description>
				</xsl:if>
				<xsl:if test="adjustment_direction">
					<adjustment_direction>
						<xsl:value-of select="adjustment_direction"/>
					</adjustment_direction>
				</xsl:if>
				<xsl:if test="tnx_val_date">
					<tnx_val_date>
						<xsl:value-of select="tnx_val_date"/>
					</tnx_val_date>
				</xsl:if>
				<xsl:if test="bo_release_dttm">
					<bo_release_dttm>
						<xsl:value-of select="bo_release_dttm"/>
					</bo_release_dttm>
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
				<!-- PO Amount? -->
				<xsl:if test="total_cur_code">
					<total_cur_code>
						<xsl:value-of select="total_cur_code"/>
					</total_cur_code>
				</xsl:if>
				<xsl:if test="face_total_cur_code">
					<face_total_cur_code>
						<xsl:value-of select="total_cur_code"/>
					</face_total_cur_code>
				</xsl:if>
				<xsl:if test="total_amt">
					<total_amt>
						<xsl:value-of select="total_amt"/>
					</total_amt>
				</xsl:if>
				<xsl:if test="face_total_amt">
					<total_amt>
						<xsl:value-of select="face_total_amt"/>
					</total_amt>
				</xsl:if>
				<xsl:if test="fake_total_amt">
					<total_amt>
						<xsl:value-of select="fake_total_amt"/>
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
				<xsl:if test="finance_repayment_cur_code">
					<finance_repayment_cur_code>
						<xsl:value-of select="finance_repayment_cur_code" />
					</finance_repayment_cur_code>
				</xsl:if>
				<xsl:if test="finance_repayment_amt">
					<finance_repayment_amt>
						<xsl:value-of select="finance_repayment_amt" />
					</finance_repayment_amt>
				</xsl:if>
				<xsl:if test="finance_repayment_action">
					<finance_repayment_action>
						<xsl:value-of select="finance_repayment_action" />
					</finance_repayment_action>
				</xsl:if>
				<xsl:if test="settlement_cur_code">
					<settlement_cur_code>
						<xsl:value-of select="settlement_cur_code" />
					</settlement_cur_code>
				</xsl:if>
				<xsl:if test="settlement_amt">
					<settlement_amt>
						<xsl:value-of select="settlement_amt" />
					</settlement_amt>
				</xsl:if>
				<xsl:if test="settlement_percentage">
					<settlement_percentage>
						<xsl:value-of select="settlement_percentage"/>
					</settlement_percentage>
				</xsl:if>
				<xsl:if test="settlement_date">
					<settlement_date>
						<xsl:value-of select="settlement_date"/>
					</settlement_date>
				</xsl:if>
				<xsl:if test="collection_req_flag">
					<collection_req_flag>
						<xsl:value-of select="collection_req_flag"/>
					</collection_req_flag>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="liab_total_cur_code">
						<liab_total_cur_code>
							<xsl:value-of select="liab_total_cur_code"/>
						</liab_total_cur_code>
					</xsl:when>
					<xsl:when test="total_net_cur_code">				
						<liab_total_cur_code>
							<xsl:value-of select="total_net_cur_code"/>
						</liab_total_cur_code>	
					</xsl:when>			
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="liab_total_amt">
						<liab_total_amt>
							<xsl:value-of select="liab_total_amt"/>
						</liab_total_amt>
					</xsl:when>
					<xsl:when test="total_net_amt">
						<liab_total_amt>
							<xsl:value-of select="total_net_amt"/>
						</liab_total_amt>							
					</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
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
				<xsl:if test="sub_product_code">
					<sub_product_code>
						<xsl:value-of select="sub_product_code"/>
					</sub_product_code>
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
				<xsl:if test="bo_ref_id">
					<bo_ref_id>
						<xsl:value-of select="bo_ref_id"/>
					</bo_ref_id>
				</xsl:if>
				<xsl:if test="fin_bo_ref_id">
					<fin_bo_ref_id>
						<xsl:value-of select="fin_bo_ref_id"/>
					</fin_bo_ref_id>
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
				<xsl:if test="last_ship_date">
					<last_ship_date>
						<xsl:value-of select="last_ship_date"/>
					</last_ship_date>
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
						<xsl:value-of select="utils:decryptApplicantReference(seller_reference)"/>
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
								<xsl:value-of select="utils:decryptApplicantReference(buyer_reference)"/>
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
				<xsl:if test="fscm_programme_code">
					<fscm_programme_code>
						<xsl:value-of select="fscm_programme_code"/>
					</fscm_programme_code>
				</xsl:if>
				<xsl:if test="inv_eligible_amt">
					<inv_eligible_amt>
						<xsl:value-of select="inv_eligible_amt"/>
					</inv_eligible_amt>
				</xsl:if>
				<xsl:if test="inv_eligible_cur_code">
					<inv_eligible_cur_code>
						<xsl:value-of select="inv_eligible_cur_code"/>
					</inv_eligible_cur_code>
				</xsl:if>
				<xsl:if test="finance_amt">
					<finance_amt>
						<xsl:value-of select="finance_amt"/>
					</finance_amt>
				</xsl:if>
				<xsl:if test="finance_cur_code">
					<finance_cur_code>
						<xsl:value-of select="finance_cur_code"/>
					</finance_cur_code>
				</xsl:if>
				<!-- Financing Request flag-->
				<xsl:if test="financing_request_flag">
					<additional_field name="financing_request_flag" type="string" scope="transaction" description=" Financing Request">
						<xsl:value-of select="financing_request_flag"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="finance_requested_flag">
					<finance_requested_flag>
						<xsl:value-of select="finance_requested_flag"/>
					</finance_requested_flag>
				</xsl:if>
				<xsl:if test="finance_requested_amt">
					<finance_requested_amt>
						<xsl:value-of select="finance_requested_amt"/>
					</finance_requested_amt>
				</xsl:if>
				<xsl:if test="finance_requested_cur_code">
					<finance_requested_cur_code>
						<xsl:value-of select="finance_requested_cur_code"/>
					</finance_requested_cur_code>
				</xsl:if>
				<xsl:if test="finance_offer_flag">
					<finance_offer_flag>
						<xsl:value-of select="finance_offer_flag" />
					</finance_offer_flag>
				</xsl:if>
				<xsl:if test="fin_cur_code">
					<additional_field name="fin_cur_code" type="string" scope="transaction" description=" Financing Request Currency">
						<xsl:value-of select="fin_cur_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="fin_amt">
					<additional_field name="fin_amt" type="amount" scope="transaction" currency="fin_cur_code" description=" Financing Request Amount">
						<xsl:value-of select="fin_amt"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="inv_eligible_pct">
					<inv_eligible_pct>
						<xsl:value-of select="inv_eligible_pct"/>
					</inv_eligible_pct>
				</xsl:if>
				<!-- Eligibility Flag -->
				<eligibility_flag>
					<xsl:choose>
    					<xsl:when test="prod_stat_code='46'">E</xsl:when>
    					<xsl:when test="prod_stat_code='47'">N</xsl:when>
   						<xsl:when test="eligibility_flag">
							<xsl:value-of select="eligibility_flag"/>
						</xsl:when>
						<xsl:when test="org_eligibility_flag">
							<xsl:value-of select="org_eligibility_flag"/>
						</xsl:when>
   						<!-- <xsl:otherwise>P</xsl:otherwise> -->
			     	</xsl:choose>
			     </eligibility_flag>
			     <xsl:if test="full_finance_accepted_flag and prod_stat_code[.!='01']">
					<full_finance_accepted_flag>
						<xsl:value-of select="full_finance_accepted_flag"/>
					</full_finance_accepted_flag>
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
				<!-- If count > 0, set to "Y", else if typecode is "01"(New), set to N, else dont set the value at all. -->
				<!-- line item -->
				<xsl:choose>
					<xsl:when test="count(lineItems/lineItem) > 0">
						<additional_field name="hasLineItem" type="string" scope="none" description=" Flag to note if user was able to capture line items">Y</additional_field>
					</xsl:when>
					<xsl:when test="tnxTypeCode = '01'">
						<additional_field name="hasLineItem" type="string" scope="none" description=" Flag to note if user was able to capture line items">N</additional_field>
					</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
				<!-- adjustment -->
				<xsl:choose>
					<xsl:when test="count(adjustments/adjustment) > 0">
						<additional_field name="hasAdjustment" type="string" scope="none" description=" Flag to note if user was able to capture adjustments">Y</additional_field>
					</xsl:when>
					<xsl:when test="tnxTypeCode = '01'">
						<additional_field name="hasAdjustment" type="string" scope="none" description=" Flag to note if user was able to capture adjustments">N</additional_field>
					</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
				<!-- tax -->
				<xsl:choose>
					<xsl:when test="count(taxes/tax) > 0">
						<additional_field name="hasTax" type="string" scope="none" description=" Flag to note if user was able to capture taxes">Y</additional_field>
					</xsl:when>
					<xsl:when test="tnxTypeCode = '01'">
						<additional_field name="hasTax" type="string" scope="none" description=" Flag to note if user was able to capture taxes">N</additional_field>
					</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
				<!-- freight charge -->
				<xsl:choose>
					<xsl:when test="count(freightCharges/freightCharge) > 0">
						<additional_field name="hasFreightCharge" type="string" scope="none" description=" Flag to note if user was able to capture freight charges">Y</additional_field>
					</xsl:when>
					<xsl:when test="tnxTypeCode = '01'">
						<additional_field name="hasFreightCharge" type="string" scope="none" description=" Flag to note if user was able to capture freight charges">N</additional_field>
					</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
				<!-- payment term -->
				<xsl:choose>
					<xsl:when test="count(payments/payment) > 0">
						<additional_field name="hasPayment" type="string" scope="none" description=" Flag to note if user was able to capture payment terms">Y</additional_field>
					</xsl:when>
					<xsl:when test="tnxTypeCode = '01'">
						<additional_field name="hasPayment" type="string" scope="none" description=" Flag to note if user was able to capture payment terms">N</additional_field>
					</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
				<!-- inco term -->
				<xsl:choose>
					<xsl:when test="count(incoterms/incoterm) > 0">
						<additional_field name="hasIncoTerm" type="string" scope="none" description=" Flag to note if user was able to capture inco terms">Y</additional_field>
					</xsl:when>
					<xsl:when test="tnxTypeCode = '01'">
						<additional_field name="hasIncoTerm" type="string" scope="none" description=" Flag to note if user was able to capture inco terms">N</additional_field>
					</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
				<!-- user information -->
				<xsl:choose>
					<xsl:when test="count(//*[starts-with(name(), 'buyer_defined_informations')]) != 0
					or count(//*[starts-with(name(), 'seller_defined_informations')]) != 0">
						<additional_field name="hasUserInformation" type="string" scope="none" description=" Flag to note if user was able to capture buyer informations">Y</additional_field>
					</xsl:when>
					<xsl:when test="tnxTypeCode = '01'">
						<additional_field name="hasUserInformation" type="string" scope="none" description=" Flag to note if user was able to capture buyer informations">N</additional_field>
					</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
				<!-- routing summary -->
				<xsl:choose>
					<xsl:when test="count(transports/transport) > 0">
						<additional_field name="hasRoutingSummary" type="string" scope="none" description=" Flag to note if user was able to capture summary informations">Y</additional_field>
					</xsl:when>
					<xsl:when test="tnxTypeCode = '01'">
						<additional_field name="hasRoutingSummary" type="string" scope="none" description=" Flag to note if user was able to capture summary informations">N</additional_field>
					</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
				<!-- contact -->
				<xsl:choose>
					<xsl:when test="count(contacts/contact) > 0">
						<additional_field name="hasContact" type="string" scope="none" description=" Flag to note if user was able to capture Contact informations">Y</additional_field>
					</xsl:when>
					<xsl:when test="tnxTypeCode = '01'">
						<additional_field name="hasContact" type="string" scope="none" description=" Flag to note if user was able to capture Contact informations">N</additional_field>
					</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
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
				<!-- Security -->
				<xsl:if test="token">
					<additional_field name="token" type="string" scope="none" description="Security token">
						<xsl:value-of select="token"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="subject">
					<additional_field name="subject" type="string" scope="transaction" description="subject">
						<xsl:value-of select="subject"/>
			         </additional_field>
			    </xsl:if>
				<xsl:if test="conditions">
					<additional_field name="conditions" type="text" scope="master" description="FSCM Program conditions">
						<xsl:value-of select="conditions"/>
					</additional_field>
				</xsl:if>
				<!-- Re authentication -->
				<xsl:call-template name="AUTHENTICATION"/>
				<!-- collaboration -->
				<xsl:call-template name="collaboration" />
			    <xsl:call-template name="FX_DETAILS" />
			    
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.openaccount.product.ip.common.InvoicePayable>
     <!--  Narrative Desciption goods -->
	    <com.misys.portal.product.common.Narrative type_code="01">
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
			<xsl:if test="narrative_description_goods">
				<text>
					<xsl:value-of select="narrative_description_goods"/>
				</text>
			</xsl:if>
		</com.misys.portal.product.common.Narrative>
     
     
			<!-- issuing bank -->
			<com.misys.portal.product.common.Bank role_code="01">
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
				<xsl:if test="issuing_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="issuing_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="issuing_bank_name">
					<name>
						<xsl:value-of select="issuing_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="issuing_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="issuing_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="issuing_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="issuing_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="issuing_bank_dom">
					<dom>
						<xsl:value-of select="issuing_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="issuing_bank_iso_code">
					<iso_code>
						<xsl:value-of select="issuing_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="issuing_bank_reference">
					<reference>
						<xsl:value-of select="issuing_bank_reference"/>
					</reference>
				</xsl:if>
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
							<xsl:if test="return_comments">
					<com.misys.portal.product.common.Narrative
						type_code="20">
						<xsl:attribute name="ref_id"><xsl:value-of select="ref_id" /></xsl:attribute>
						<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id" /></xsl:attribute>
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
						<!-- <xsl:if test="return_comments"> -->
							<text>
								<xsl:value-of select="return_comments" />
							</text>
						<!-- </xsl:if> -->
					</com.misys.portal.product.common.Narrative>
				</xsl:if>
			
			
				<!--Allowances (Adjustments)-->
			<xsl:apply-templates select="adjustments/adjustment">
				<xsl:with-param name="brchCode" select="brch_code"/>
				<xsl:with-param name="companyId" select="company_id"/>
				<xsl:with-param name="refId" select="ref_id"/>
				<xsl:with-param name="tnxId" select="tnx_id"/>
			</xsl:apply-templates>
			
			<!--Allowances (Tax)-->
			<xsl:apply-templates select="taxes/tax">
				<xsl:with-param name="brchCode" select="brch_code"/>
				<xsl:with-param name="companyId" select="company_id"/>
				<xsl:with-param name="refId" select="ref_id"/>
				<xsl:with-param name="tnxId" select="tnx_id"/>
			</xsl:apply-templates>
			
			<!--Allowances (Freight charge)-->
			<xsl:apply-templates select="freightCharges/freightCharge">
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
			
			<!--Seller Information -->
			<xsl:apply-templates select="seller_defined_informations/seller_defined_information">
				<xsl:with-param name="brchCode" select="brch_code"/>
				<xsl:with-param name="companyId" select="company_id"/>
				<xsl:with-param name="refId" select="ref_id"/>
				<xsl:with-param name="tnxId" select="tnx_id"/>
			</xsl:apply-templates>
			
				<!--Buyer information -->
			<xsl:apply-templates select="buyer_defined_informations/buyer_defined_information">
				<xsl:with-param name="brchCode" select="brch_code"/>
				<xsl:with-param name="companyId" select="company_id"/>
				<xsl:with-param name="refId" select="ref_id"/>
				<xsl:with-param name="tnxId" select="tnx_id"/>
			</xsl:apply-templates>
			
			<!--Incoterm -->
			<xsl:apply-templates select="incoterms/incoterm">
				<xsl:with-param name="brchCode" select="brch_code"/>
				<xsl:with-param name="companyId" select="company_id"/>
				<xsl:with-param name="refId" select="ref_id"/>
				<xsl:with-param name="tnxId" select="tnx_id"/>
			</xsl:apply-templates>
			
			<!--Transports -->
			<xsl:apply-templates select="transports/transport">
				<xsl:with-param name="brchCode" select="brch_code"/>
				<xsl:with-param name="companyId" select="company_id"/>
				<xsl:with-param name="refId" select="ref_id"/>
				<xsl:with-param name="tnxId" select="tnx_id"/>
				<xsl:with-param name="transport_type" select="transport_type"/>
			</xsl:apply-templates>
			
			
			<!-- Line Items -->
			<xsl:apply-templates select="lineItems/lineItem">
				<xsl:with-param name="poRefId"><xsl:value-of select="ref_id"/></xsl:with-param>
				<xsl:with-param name="poTnxId"><xsl:value-of select="tnx_id"/></xsl:with-param>
				<xsl:with-param name="brchCode"><xsl:value-of select="brch_code"/></xsl:with-param>
				<xsl:with-param name="companyId"><xsl:value-of select="company_id"/></xsl:with-param>
				<xsl:with-param name="companyName"><xsl:value-of select="company_name"/></xsl:with-param>
				<xsl:with-param name="entity"><xsl:value-of select="entity"/></xsl:with-param>
			</xsl:apply-templates>
			
			<!-- Create Charge element -->
			
			<!-- First, those charges belonging to the current transaction -->
			<xsl:for-each select="//*[starts-with(name(), 'charge_details_chrg_details_')]">
				<xsl:call-template name="CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//ip_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//ip_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//ip_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//ip_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'charge_details_chrg_details_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!-- Second, the charges inputted earlier -->
			<xsl:for-each select="//*[starts-with(name(), 'old_charge_details_position_')]">
				<xsl:call-template name="OLD_CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//ip_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//ip_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//ip_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//ip_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'old_charge_details_position_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
				<!-- Cross References -->
			<xsl:for-each select="//*[starts-with(name(), 'cross_ref_cross_reference_id')]">
				<xsl:call-template name="CROSS_REFERENCE">
					<xsl:with-param name="brchCode"><xsl:value-of select="/brch_code"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-before(substring-after(name(), 'cross_ref_cross_reference_id'), '_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
