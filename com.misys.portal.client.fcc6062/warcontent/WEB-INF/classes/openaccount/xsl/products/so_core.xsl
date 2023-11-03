<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
<!--
   Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>
	<!-- Common elements to save among all products -->
	<xsl:include href="po_save_common.xsl"/>
	<xsl:include href="../../../core/xsl/products/save_common.xsl"/>
	<xsl:include href="lt.xsl"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process Purchase Order -->
	<xsl:template match="so_tnx_record">
		<result>
			<com.misys.portal.openaccount.product.so.common.SellOrder>
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
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>	
				<xsl:if test="issuer_ref_id">
					<issuer_ref_id>
						<xsl:value-of select="issuer_ref_id"/>
					</issuer_ref_id>
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
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(tnx_amt))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="tnx_amt"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</tnx_amt>
				</xsl:if>
				<!-- PO Amount? -->
				<xsl:if test="total_cur_code">
					<total_cur_code>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(total_cur_code))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="total_cur_code"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</total_cur_code>
				</xsl:if>
				<xsl:if test="fake_total_amt">
					<total_amt>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(total_amt))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="fake_total_amt"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</total_amt>
				</xsl:if>
				<xsl:if test="total_net_cur_code">
					<total_net_cur_code>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(total_net_cur_code))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="total_net_cur_code"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</total_net_cur_code>
				</xsl:if>
				<xsl:if test="total_net_amt">
					<total_net_amt>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(total_net_amt))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="total_net_amt"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</total_net_amt>
				</xsl:if>
				<xsl:if test="order_total_cur_code">
					<order_total_cur_code>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(order_total_cur_code))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="order_total_cur_code"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</order_total_cur_code>
				</xsl:if>
				<xsl:if test="order_total_amt">
					<order_total_amt>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(order_total_amt))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="order_total_amt"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</order_total_amt>
				</xsl:if>
				<xsl:if test="order_total_net_cur_code">
					<order_total_net_cur_code>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(order_total_net_cur_code))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="order_total_net_cur_code"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</order_total_net_cur_code>
				</xsl:if>
				<xsl:if test="order_total_net_amt">
					<order_total_net_amt>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(order_total_net_amt))"/>
							</xsl:when>
							<xsl:otherwise!-->
								<xsl:value-of select="order_total_net_amt"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</order_total_net_amt>
				</xsl:if>
				<xsl:if test="accpt_total_cur_code">
					<accpt_total_cur_code>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(accpt_total_cur_code))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="accpt_total_cur_code"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</accpt_total_cur_code>
				</xsl:if>
				<xsl:if test="accpt_total_amt">
					<accpt_total_amt>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(accpt_total_amt))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="accpt_total_amt"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</accpt_total_amt>
				</xsl:if>
				<xsl:if test="accpt_total_net_cur_code">
					<accpt_total_net_cur_code>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(accpt_total_net_cur_code))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="accpt_total_net_cur_code"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</accpt_total_net_cur_code>
				</xsl:if>
				<xsl:if test="accpt_total_net_amt">
					<accpt_total_net_amt>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(accpt_total_net_amt))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="accpt_total_net_amt"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</accpt_total_net_amt>
				</xsl:if>
				<xsl:if test="liab_total_cur_code">
					<liab_total_cur_code>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(liab_total_cur_code))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="liab_total_cur_code"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</liab_total_cur_code>
				</xsl:if>
				<xsl:if test="liab_total_amt">
					<liab_total_amt>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(liab_total_amt))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="liab_total_amt"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</liab_total_amt>
				</xsl:if>
				<xsl:if test="liab_total_net_cur_code">
					<liab_total_net_cur_code>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(liab_total_net_cur_code))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="liab_total_net_cur_code"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</liab_total_net_cur_code>
				</xsl:if>
				<xsl:if test="liab_total_net_amt">
					<liab_total_net_amt>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(liab_total_net_amt))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="liab_total_net_amt"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
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
				<xsl:if test="bo_ref_id">
					<bo_ref_id>
						<xsl:value-of select="bo_ref_id"/>
					</bo_ref_id>
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
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_name))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="seller_name"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</seller_name>
				</xsl:if>
				<xsl:if test="seller_bei">
					<seller_bei>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_bei))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="seller_bei"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</seller_bei>
				</xsl:if>
				<!-- moved to seller bank ? -->
				<!--xsl:if test="seller_bank_bic">
					<seller_bei>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_bank_bic))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="seller_bank_bic"/>
							</xsl:otherwise>
						</xsl:choose>
					</seller_bei>
				</xsl:if-->
				<xsl:if test="seller_street_name">
					<seller_street_name>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_street_name))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="seller_street_name"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</seller_street_name>
				</xsl:if>
				<xsl:if test="seller_post_code">
					<seller_post_code>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_post_code))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="seller_post_code"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</seller_post_code>
				</xsl:if>
				<xsl:if test="seller_town_name">
					<seller_town_name>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_town_name))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="seller_town_name"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</seller_town_name>
				</xsl:if>
				<xsl:if test="seller_country_sub_div">
					<seller_country_sub_div>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_country_sub_div))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="seller_country_sub_div"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</seller_country_sub_div>
				</xsl:if>
				<xsl:if test="seller_country">
					<seller_country>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_country))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="seller_country"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</seller_country>
				</xsl:if>
				<xsl:if test="seller_reference">
					<seller_reference>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_reference))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="seller_reference"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
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
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_name))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="buyer_name"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</buyer_name>
				</xsl:if>
				<xsl:if test="buyer_bei">
					<buyer_bei>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_bei))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="buyer_bei"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</buyer_bei>
				</xsl:if>
				<xsl:if test="buyer_street_name">
					<buyer_street_name>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_street_name))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="buyer_street_name"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</buyer_street_name>
				</xsl:if>
				<xsl:if test="buyer_post_code">
					<buyer_post_code>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_post_code))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="buyer_post_code"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</buyer_post_code>
				</xsl:if>
				<xsl:if test="buyer_town_name">
					<buyer_town_name>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_town_name))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="buyer_town_name"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</buyer_town_name>
				</xsl:if>
				<xsl:if test="buyer_country_sub_div">
					<buyer_country_sub_div>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_country_sub_div))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="buyer_country_sub_div"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</buyer_country_sub_div>
				</xsl:if>
				<xsl:if test="buyer_country">
					<buyer_country>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_country))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="buyer_country"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
					</buyer_country>
				</xsl:if>
				<xsl:if test="buyer_reference">
					<buyer_reference>
						<!--xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_reference))"/>
							</xsl:when>
							<xsl:otherwise-->
								<xsl:value-of select="buyer_reference"/>
							<!--/xsl:otherwise>
						</xsl:choose-->
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
				<!-- Buyer/Seller bank type-->
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
				<!-- Financing Request flag-->
				<xsl:if test="financing_request_flag">
					<additional_field name="financing_request_flag" type="string" scope="transaction" description=" Financing Request">
						<xsl:value-of select="financing_request_flag"/>
					</additional_field>
				</xsl:if>
				<!-- Flags used to detect draft or controlled mode (delete or not previous elements stored into ArrayList-->
				<!-- line item -->
				<xsl:if test="count(lineItems/lineItem) > 0">
					<additional_field name="hasLineItem" type="string" scope="none" description=" Flag to note if user was able to capture line items">Y</additional_field>
				</xsl:if>
				<!-- adjustment -->
				<xsl:if test="count(adjustments/adjustment) > 0">
					<additional_field name="hasAdjustment" type="string" scope="none" description=" Flag to note if user was able to capture adjustments">Y</additional_field>
				</xsl:if>
				<!-- tax -->
				<xsl:if test="count(taxes/tax) > 0">
					<additional_field name="hasTax" type="string" scope="none" description=" Flag to note if user was able to capture taxes">Y</additional_field>
				</xsl:if>
				<!-- freight charge -->
				<xsl:if test="count(freightCharges/freightCharge) > 0">
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
				<xsl:if test="count(//*[starts-with(name(), 'buyer_defined_informations')]) != 0
					or count(//*[starts-with(name(), 'seller_defined_informations')]) != 0">
					<additional_field name="hasUserInformation" type="string" scope="none" description=" Flag to note if user was able to capture buyer informations">Y</additional_field>
				</xsl:if>
				<!-- routing summary -->
				<xsl:if test="count(transports/transport) > 0">
					<additional_field name="hasRoutingSummary" type="string" scope="none" description=" Flag to note if user was able to capture summary informations">Y</additional_field>
				</xsl:if>
<!-- 				<xsl:choose> -->
<!-- 					<xsl:when test="count(//*[starts-with(name(),'po_routing_summary_individual_') and contains(name(), '_details_position_')]) != 0"> -->
<!-- 						<additional_field name="hasRoutingSummary" type="string" scope="none" description=" Flag to note if user was able to capture individual summary informations">Y</additional_field> -->
<!-- 					</xsl:when> -->
<!-- 					<xsl:when test="count(//*[starts-with(name(), 'po_routing_summary_multimodal_') and contains(name(),'_details_position_')]) != 0"> -->
<!-- 						<additional_field name="hasRoutingSummary" type="string" scope="none" description=" Flag to note if user was able to capture multiple routing summary informations">Y</additional_field> -->
<!-- 					</xsl:when> -->
<!-- 				</xsl:choose> -->
				<!-- contact -->
				<xsl:if test="count(contacts/contact) != 0">
					<additional_field name="hasContact" type="string" scope="none" description=" Flag to note if user was able to capture contact informations">Y</additional_field>
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
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.openaccount.product.so.common.SellOrder>
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
			
				<!-- Cross References -->
			<xsl:for-each select="//*[starts-with(name(), 'cross_ref_cross_reference_id')]">
				<xsl:call-template name="CROSS_REFERENCE">
					<xsl:with-param name="brchCode"><xsl:value-of select="/so_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-before(substring-after(name(), 'cross_ref_cross_reference_id'), '_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
