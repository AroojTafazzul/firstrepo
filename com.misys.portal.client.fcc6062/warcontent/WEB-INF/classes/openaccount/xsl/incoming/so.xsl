<?xml version="1.0"?>
<!-- Copyright (c) 2000-2008 Misys (http://www.misys.com) All Rights Reserved. -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
	exclude-result-prefixes="service">

	<!-- Get the parameters -->
	<!-- Common elements to save among all products -->
	<xsl:include href="lt.xsl" />


	<!-- Process Purchase Order -->
	<xsl:template match="so_tnx_record">

		<!-- Retrieve references from DB -->
		<!-- Declare variable at top-level to make them visible from any templates -->
		<!-- <xsl:variable name="references" select="service:manageReferences('SO', 
			//ref_id, //tnx_id, //bo_ref_id, //cust_ref_id, //company_id, //company_name, 
			//buyer_reference, //advising_bank/abbv_name, '02')"/> -->
		<xsl:variable name="references"
			select="service:manageReferences('SO', //ref_id, //tnx_id, //bo_ref_id, //cust_ref_id, //company_id, //company_name, //buyer_reference, //advising_bank/abbv_name, '02')" />

		<xsl:variable name="ref_id" select="$references/references/ref_id" />
		<xsl:variable name="tnx_id" select="$references/references/tnx_id" />
		<xsl:variable name="company_id" select="$references/references/company_id" />
		<xsl:variable name="company_name" select="$references/references/company_name" />
		<xsl:variable name="entity" select="$references/references/entity" />
		<xsl:variable name="main_bank_abbv_name"
			select="$references/references/main_bank_abbv_name" />
		<xsl:variable name="main_bank_name"
			select="$references/references/main_bank_name" />
		<xsl:variable name="customer_bank_reference"
			select="$references/references/customer_bank_reference" />
		<result>

			<com.misys.portal.openaccount.product.so.common.SellOrder>
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id" /></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id" /></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code" />
					</brch_code>
				</xsl:if>
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id" />
					</bo_tnx_id>
				</xsl:if>
				<company_id>
					<xsl:value-of select="$company_id" />
				</company_id>
				<xsl:if test="entity">
					<entity>
						<xsl:value-of select="entity" />
					</entity>
				</xsl:if>
				<xsl:if test="$entity!='' and not(entity)">
					<entity>
						<xsl:value-of select="$entity" />
					</entity>
				</xsl:if>
				<company_name>
					<xsl:value-of select="$company_name" />
				</company_name>

				<product_code>SO</product_code>

				<xsl:if test="inp_user_id">
					<inp_user_id>
						<xsl:value-of select="inp_user_id" />
					</inp_user_id>
				</xsl:if>
				<xsl:if test="inp_user_dttm">
					<inp_user_dttm>
						<xsl:value-of select="inp_user_dttm" />
					</inp_user_dttm>
				</xsl:if>
				<xsl:if test="ctl_user_id">
					<ctl_user_id>
						<xsl:value-of select="ctl_user_id" />
					</ctl_user_id>
				</xsl:if>
				<xsl:if test="ctl_user_dttm">
					<ctl_user_dttm>
						<xsl:value-of select="ctl_user_dttm" />
					</ctl_user_dttm>
				</xsl:if>
				<xsl:if test="release_user_id">
					<release_user_id>
						<xsl:value-of select="release_user_id" />
					</release_user_id>
				</xsl:if>
				<xsl:if test="release_user_dttm">
					<release_user_dttm>
						<xsl:value-of select="release_user_dttm" />
					</release_user_dttm>
				</xsl:if>
				<xsl:if test="bo_inp_user_id">
					<bo_inp_user_id>
						<xsl:value-of select="bo_inp_user_id" />
					</bo_inp_user_id>
				</xsl:if>
				<xsl:if test="bo_inp_user_dttm">
					<bo_inp_user_dttm>
						<xsl:value-of select="bo_inp_user_dttm" />
					</bo_inp_user_dttm>
				</xsl:if>
				<xsl:if test="bo_ctl_user_id">
					<bo_ctl_user_id>
						<xsl:value-of select="bo_ctl_user_id" />
					</bo_ctl_user_id>
				</xsl:if>
				<xsl:if test="bo_ctl_user_dttm">
					<bo_ctl_user_dttm>
						<xsl:value-of select="bo_ctl_user_dttm" />
					</bo_ctl_user_dttm>
				</xsl:if>
				<xsl:if test="bo_release_user_id">
					<bo_release_user_id>
						<xsl:value-of select="bo_release_user_id" />
					</bo_release_user_id>
				</xsl:if>
				<xsl:if test="bo_release_user_dttm">
					<bo_release_user_dttm>
						<xsl:value-of select="bo_release_user_dttm" />
					</bo_release_user_dttm>
				</xsl:if>

				<xsl:if test="issuer_ref_id">
					<issuer_ref_id>
						<xsl:value-of select="issuer_ref_id" />
					</issuer_ref_id>
				</xsl:if>
				<xsl:if test="template_id">
					<template_id>
						<xsl:value-of select="template_id" />
					</template_id>
				</xsl:if>
				<xsl:if test="template_description">
					<template_description>
						<xsl:value-of select="template_description" />
					</template_description>
				</xsl:if>
				<xsl:if test="tnx_val_date">
					<tnx_val_date>
						<xsl:value-of select="tnx_val_date" />
					</tnx_val_date>
				</xsl:if>
				<xsl:if test="appl_date">
					<appl_date>
						<xsl:value-of select="appl_date" />
					</appl_date>
				</xsl:if>
				<xsl:if test="iss_date">
					<iss_date>
						<xsl:value-of select="iss_date" />
					</iss_date>
				</xsl:if>
				<xsl:if test="amd_date">
					<amd_date>
						<xsl:value-of select="amd_date" />
					</amd_date>
				</xsl:if>
				<xsl:if test="amd_no">
					<amd_no>
						<xsl:value-of select="amd_no" />
					</amd_no>
				</xsl:if>
				<xsl:if test="last_ship_date">
					<last_ship_date>
						<xsl:value-of select="last_ship_date" />
					</last_ship_date>
				</xsl:if>
				<xsl:if test="tnx_cur_code">
					<tnx_cur_code>
						<xsl:value-of select="tnx_cur_code" />
					</tnx_cur_code>
				</xsl:if>
				<xsl:if test="freight_charges_type">
					<freight_charges_type>
						<xsl:value-of select="freight_charges_type" />
					</freight_charges_type>
				</xsl:if>
				<xsl:if test="payment_terms_type">
					<payment_terms_type>
						<xsl:value-of select="payment_terms_type" />
					</payment_terms_type>
				</xsl:if>
				<xsl:if test="goods_desc">
					<goods_desc>
						<xsl:value-of select="goods_desc" />
					</goods_desc>
				</xsl:if>
				<xsl:if test="tnx_amt">
					<tnx_amt>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(tnx_amt))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="tnx_amt" />
						<!--/xsl:otherwise> </xsl:choose -->
					</tnx_amt>
				</xsl:if>
				<!-- PO Amount? -->
				<xsl:if test="total_cur_code">
					<total_cur_code>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(total_cur_code))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="total_cur_code" />
						<!--/xsl:otherwise> </xsl:choose -->
					</total_cur_code>
				</xsl:if>
				<xsl:if test="total_amt">
					<total_amt>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(total_amt))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="total_amt" />
						<!--/xsl:otherwise> </xsl:choose -->
					</total_amt>
				</xsl:if>
				<xsl:if test="total_net_cur_code">
					<total_net_cur_code>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(total_net_cur_code))"/> 
							</xsl:when> <xsl:otherwise -->
						<xsl:value-of select="total_net_cur_code" />
						<!--/xsl:otherwise> </xsl:choose -->
					</total_net_cur_code>
				</xsl:if>
				<xsl:if test="total_net_amt">
					<total_net_amt>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(total_net_amt))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="total_net_amt" />
						<!--/xsl:otherwise> </xsl:choose -->
					</total_net_amt>
				</xsl:if>
				<xsl:if test="order_total_cur_code">
					<order_total_cur_code>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(order_total_cur_code))"/> 
							</xsl:when> <xsl:otherwise -->
						<xsl:value-of select="order_total_cur_code" />
						<!--/xsl:otherwise> </xsl:choose -->
					</order_total_cur_code>
				</xsl:if>
				<xsl:if test="order_total_amt">
					<order_total_amt>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(order_total_amt))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="order_total_amt" />
						<!--/xsl:otherwise> </xsl:choose -->
					</order_total_amt>
				</xsl:if>
				<xsl:if test="order_total_net_cur_code">
					<order_total_net_cur_code>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(order_total_net_cur_code))"/> 
							</xsl:when> <xsl:otherwise -->
						<xsl:value-of select="order_total_net_cur_code" />
						<!--/xsl:otherwise> </xsl:choose -->
					</order_total_net_cur_code>
				</xsl:if>
				<xsl:if test="order_total_net_amt">
					<order_total_net_amt>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(order_total_net_amt))"/> 
							</xsl:when> <xsl:otherwise! -->
						<xsl:value-of select="order_total_net_amt" />
						<!--/xsl:otherwise> </xsl:choose -->
					</order_total_net_amt>
				</xsl:if>
				<xsl:if test="accpt_total_cur_code">
					<accpt_total_cur_code>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(accpt_total_cur_code))"/> 
							</xsl:when> <xsl:otherwise -->
						<xsl:value-of select="accpt_total_cur_code" />
						<!--/xsl:otherwise> </xsl:choose -->
					</accpt_total_cur_code>
				</xsl:if>
				<xsl:if test="accpt_total_amt">
					<accpt_total_amt>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(accpt_total_amt))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="accpt_total_amt" />
						<!--/xsl:otherwise> </xsl:choose -->
					</accpt_total_amt>
				</xsl:if>
				<xsl:if test="accpt_total_net_cur_code">
					<accpt_total_net_cur_code>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(accpt_total_net_cur_code))"/> 
							</xsl:when> <xsl:otherwise -->
						<xsl:value-of select="accpt_total_net_cur_code" />
						<!--/xsl:otherwise> </xsl:choose -->
					</accpt_total_net_cur_code>
				</xsl:if>
				<xsl:if test="accpt_total_net_amt">
					<accpt_total_net_amt>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(accpt_total_net_amt))"/> 
							</xsl:when> <xsl:otherwise -->
						<xsl:value-of select="accpt_total_net_amt" />
						<!--/xsl:otherwise> </xsl:choose -->
					</accpt_total_net_amt>
				</xsl:if>
				<xsl:if test="liab_total_cur_code">
					<liab_total_cur_code>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(liab_total_cur_code))"/> 
							</xsl:when> <xsl:otherwise -->
						<xsl:value-of select="liab_total_cur_code" />
						<!--/xsl:otherwise> </xsl:choose -->
					</liab_total_cur_code>
				</xsl:if>
				<xsl:if test="liab_total_amt">
					<liab_total_amt>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(liab_total_amt))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="liab_total_amt" />
						<!--/xsl:otherwise> </xsl:choose -->
					</liab_total_amt>
				</xsl:if>
				<xsl:if test="liab_total_net_cur_code">
					<liab_total_net_cur_code>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(liab_total_net_cur_code))"/> 
							</xsl:when> <xsl:otherwise -->
						<xsl:value-of select="liab_total_net_cur_code" />
						<!--/xsl:otherwise> </xsl:choose -->
					</liab_total_net_cur_code>
				</xsl:if>
				<xsl:if test="liab_total_net_amt">
					<liab_total_net_amt>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(liab_total_net_amt))"/> 
							</xsl:when> <xsl:otherwise -->
						<xsl:value-of select="liab_total_net_amt" />
						<!--/xsl:otherwise> </xsl:choose -->
					</liab_total_net_amt>
				</xsl:if>
				<xsl:if test="tnx_type_code">
					<tnx_type_code>
						<xsl:value-of select="tnx_type_code" />
					</tnx_type_code>
				</xsl:if>
				<xsl:if test="sub_tnx_type_code">
					<sub_tnx_type_code>
						<xsl:value-of select="sub_tnx_type_code" />
					</sub_tnx_type_code>
				</xsl:if>
				<xsl:if test="prod_stat_code">
					<prod_stat_code>
						<xsl:value-of select="prod_stat_code" />
					</prod_stat_code>
				</xsl:if>
				<xsl:if test="tnx_stat_code">
					<tnx_stat_code>
						<xsl:value-of select="tnx_stat_code" />
					</tnx_stat_code>
				</xsl:if>
				<xsl:if test="cust_ref_id">
					<cust_ref_id>
						<xsl:value-of select="cust_ref_id" />
					</cust_ref_id>
				</xsl:if>
				<xsl:if test="bo_ref_id">
					<bo_ref_id>
						<xsl:value-of select="bo_ref_id" />
					</bo_ref_id>
				</xsl:if>
				<!-- documents required -->
				<xsl:if test="reqrd_commercial_dataset">
					<reqrd_commercial_dataset>
						<xsl:value-of select="reqrd_commercial_dataset" />
					</reqrd_commercial_dataset>
				</xsl:if>
				<xsl:if test="reqrd_transport_dataset">
					<reqrd_transport_dataset>
						<xsl:value-of select="reqrd_transport_dataset" />
					</reqrd_transport_dataset>
				</xsl:if>
				<xsl:if test="last_match_date">
					<last_match_date>
						<xsl:value-of select="last_match_date" />
					</last_match_date>
				</xsl:if>
				<!-- Previous ctl date, used for synchronisation issues -->
				<xsl:if test="old_ctl_dttm">
					<additional_field name="old_ctl_dttm" type="time"
						scope="none" description=" Previous control date used for synchronisation issues">
						<xsl:value-of select="old_ctl_dttm" />
					</additional_field>
				</xsl:if>
				<!-- Previous input date, used to know if the product is already saved -->
				<xsl:if test="old_inp_dttm">
					<additional_field name="old_inp_dttm" type="time"
						scope="none" description="Previous input date used for synchronisation issues">
						<xsl:value-of select="old_inp_dttm" />
					</additional_field>
				</xsl:if>
				<!-- Shipment Details -->
				<xsl:if test="part_ship">
					<part_ship>
						<xsl:value-of select="part_ship" />
					</part_ship>
				</xsl:if>
				<xsl:if test="tran_ship">
					<tran_ship>
						<xsl:value-of select="tran_ship" />
					</tran_ship>
				</xsl:if>
				<xsl:if test="last_ship_date">
					<last_ship_date>
						<xsl:value-of select="last_ship_date" />
					</last_ship_date>
				</xsl:if>
				<!-- Seller -->
				<xsl:if test="seller_abbv_name">
					<seller_abbv_name>
						<xsl:value-of select="seller_abbv_name" />
					</seller_abbv_name>
				</xsl:if>
				<xsl:if test="seller_name">
					<seller_name>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(seller_name))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="seller_name" />
						<!--/xsl:otherwise> </xsl:choose -->
					</seller_name>
				</xsl:if>
				<xsl:if test="seller_bei">
					<seller_bei>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(seller_bei))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="seller_bei" />
						<!--/xsl:otherwise> </xsl:choose -->
					</seller_bei>
				</xsl:if>
				<!-- moved to seller bank ? -->
				<!--xsl:if test="seller_bank_bic"> <seller_bei> <xsl:choose> <xsl:when 
					test="$companyType=$customerType and $IsEncrypted='true'"> <xsl:value-of 
					select="encryption:uncypher(string(seller_bank_bic))"/> </xsl:when> <xsl:otherwise> 
					<xsl:value-of select="seller_bank_bic"/> </xsl:otherwise> </xsl:choose> </seller_bei> 
					</xsl:if -->
				<xsl:if test="seller_street_name">
					<seller_street_name>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(seller_street_name))"/> 
							</xsl:when> <xsl:otherwise -->
						<xsl:value-of select="seller_street_name" />
						<!--/xsl:otherwise> </xsl:choose -->
					</seller_street_name>
				</xsl:if>
				<xsl:if test="seller_post_code">
					<seller_post_code>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(seller_post_code))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="seller_post_code" />
						<!--/xsl:otherwise> </xsl:choose -->
					</seller_post_code>
				</xsl:if>
				<xsl:if test="seller_town_name">
					<seller_town_name>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(seller_town_name))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="seller_town_name" />
						<!--/xsl:otherwise> </xsl:choose -->
					</seller_town_name>
				</xsl:if>
				<xsl:if test="seller_country_sub_div">
					<seller_country_sub_div>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(seller_country_sub_div))"/> 
							</xsl:when> <xsl:otherwise -->
						<xsl:value-of select="seller_country_sub_div" />
						<!--/xsl:otherwise> </xsl:choose -->
					</seller_country_sub_div>
				</xsl:if>
				<xsl:if test="seller_country">
					<seller_country>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(seller_country))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="seller_country" />
						<!--/xsl:otherwise> </xsl:choose -->
					</seller_country>
				</xsl:if>
				<xsl:if test="seller_reference">
					<seller_reference>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(seller_reference))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="seller_reference" />
						<!--/xsl:otherwise> </xsl:choose -->
					</seller_reference>
				</xsl:if>
				<!-- Buyer -->
				<xsl:if test="buyer_abbv_name">
					<buyer_abbv_name>
						<xsl:value-of select="buyer_abbv_name" />
					</buyer_abbv_name>
				</xsl:if>
				<xsl:if test="buyer_name">
					<buyer_name>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(buyer_name))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="buyer_name" />
						<!--/xsl:otherwise> </xsl:choose -->
					</buyer_name>
				</xsl:if>
				<xsl:if test="buyer_bei">
					<buyer_bei>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(buyer_bei))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="buyer_bei" />
						<!--/xsl:otherwise> </xsl:choose -->
					</buyer_bei>
				</xsl:if>
				<xsl:if test="buyer_street_name">
					<buyer_street_name>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(buyer_street_name))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="buyer_street_name" />
						<!--/xsl:otherwise> </xsl:choose -->
					</buyer_street_name>
				</xsl:if>
				<xsl:if test="buyer_post_code">
					<buyer_post_code>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(buyer_post_code))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="buyer_post_code" />
						<!--/xsl:otherwise> </xsl:choose -->
					</buyer_post_code>
				</xsl:if>
				<xsl:if test="buyer_town_name">
					<buyer_town_name>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(buyer_town_name))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="buyer_town_name" />
						<!--/xsl:otherwise> </xsl:choose -->
					</buyer_town_name>
				</xsl:if>
				<xsl:if test="buyer_country_sub_div">
					<buyer_country_sub_div>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(buyer_country_sub_div))"/> 
							</xsl:when> <xsl:otherwise -->
						<xsl:value-of select="buyer_country_sub_div" />
						<!--/xsl:otherwise> </xsl:choose -->
					</buyer_country_sub_div>
				</xsl:if>
				<xsl:if test="buyer_country">
					<buyer_country>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(buyer_country))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="buyer_country" />
						<!--/xsl:otherwise> </xsl:choose -->
					</buyer_country>
				</xsl:if>
				<xsl:if test="buyer_reference">
					<buyer_reference>
						<!--xsl:choose> <xsl:when test="$companyType=$customerType and $IsEncrypted='true'"> 
							<xsl:value-of select="encryption:uncypher(string(buyer_reference))"/> </xsl:when> 
							<xsl:otherwise -->
						<xsl:value-of select="$customer_bank_reference" />
						<!-- <xsl:value-of select="buyer_reference"/> -->
						<!--/xsl:otherwise> </xsl:choose -->
					</buyer_reference>
				</xsl:if>
				<!-- Bill to -->
				<xsl:if test="bill_to_abbv_name">
					<bill_to_abbv_name>
						<xsl:value-of select="bill_to_abbv_name" />
					</bill_to_abbv_name>
				</xsl:if>
				<xsl:if test="bill_to_name">
					<bill_to_name>
						<xsl:value-of select="bill_to_name" />
					</bill_to_name>
				</xsl:if>
				<xsl:if test="bill_to_bei">
					<bill_to_bei>
						<xsl:value-of select="bill_to_bei" />
					</bill_to_bei>
				</xsl:if>
				<xsl:if test="bill_to_street_name">
					<bill_to_street_name>
						<xsl:value-of select="bill_to_street_name" />
					</bill_to_street_name>
				</xsl:if>
				<xsl:if test="bill_to_post_code">
					<bill_to_post_code>
						<xsl:value-of select="bill_to_post_code" />
					</bill_to_post_code>
				</xsl:if>
				<xsl:if test="bill_to_town_name">
					<bill_to_town_name>
						<xsl:value-of select="bill_to_town_name" />
					</bill_to_town_name>
				</xsl:if>
				<xsl:if test="bill_to_country_sub_div">
					<bill_to_country_sub_div>
						<xsl:value-of select="bill_to_country_sub_div" />
					</bill_to_country_sub_div>
				</xsl:if>
				<xsl:if test="bill_to_country">
					<bill_to_country>
						<xsl:value-of select="bill_to_country" />
					</bill_to_country>
				</xsl:if>
				<!-- Ship to -->
				<xsl:if test="ship_to_abbv_name">
					<ship_to_abbv_name>
						<xsl:value-of select="ship_to_abbv_name" />
					</ship_to_abbv_name>
				</xsl:if>
				<xsl:if test="ship_to_name">
					<ship_to_name>
						<xsl:value-of select="ship_to_name" />
					</ship_to_name>
				</xsl:if>
				<xsl:if test="ship_to_bei">
					<ship_to_bei>
						<xsl:value-of select="ship_to_bei" />
					</ship_to_bei>
				</xsl:if>
				<xsl:if test="ship_to_street_name">
					<ship_to_street_name>
						<xsl:value-of select="ship_to_street_name" />
					</ship_to_street_name>
				</xsl:if>
				<xsl:if test="ship_to_post_code">
					<ship_to_post_code>
						<xsl:value-of select="ship_to_post_code" />
					</ship_to_post_code>
				</xsl:if>
				<xsl:if test="ship_to_town_name">
					<ship_to_town_name>
						<xsl:value-of select="ship_to_town_name" />
					</ship_to_town_name>
				</xsl:if>
				<xsl:if test="ship_to_country_sub_div">
					<ship_to_country_sub_div>
						<xsl:value-of select="ship_to_country_sub_div" />
					</ship_to_country_sub_div>
				</xsl:if>
				<xsl:if test="ship_to_country">
					<ship_to_country>
						<xsl:value-of select="ship_to_country" />
					</ship_to_country>
				</xsl:if>
				<!-- Consignee -->
				<xsl:if test="consgn_abbv_name">
					<consgn_abbv_name>
						<xsl:value-of select="consgn_abbv_name" />
					</consgn_abbv_name>
				</xsl:if>
				<xsl:if test="consgn_name">
					<consgn_name>
						<xsl:value-of select="consgn_name" />
					</consgn_name>
				</xsl:if>
				<xsl:if test="consgn_bei">
					<consgn_bei>
						<xsl:value-of select="consgn_bei" />
					</consgn_bei>
				</xsl:if>
				<xsl:if test="consgn_street_name">
					<consgn_street_name>
						<xsl:value-of select="consgn_street_name" />
					</consgn_street_name>
				</xsl:if>
				<xsl:if test="consgn_post_code">
					<consgn_post_code>
						<xsl:value-of select="consgn_post_code" />
					</consgn_post_code>
				</xsl:if>
				<xsl:if test="consgn_town_name">
					<consgn_town_name>
						<xsl:value-of select="consgn_town_name" />
					</consgn_town_name>
				</xsl:if>
				<xsl:if test="consgn_country_sub_div">
					<consgn_country_sub_div>
						<xsl:value-of select="consgn_country_sub_div" />
					</consgn_country_sub_div>
				</xsl:if>
				<xsl:if test="consgn_country">
					<consgn_country>
						<xsl:value-of select="consgn_country" />
					</consgn_country>
				</xsl:if>
				<!-- Seller Account -->
				<xsl:if test="seller_account_name">
					<seller_account_name>
						<xsl:value-of select="seller_account_name" />
					</seller_account_name>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="seller_account_type[.='IBAN']">
						<seller_account_iban>
							<xsl:value-of select="seller_account_value" />
						</seller_account_iban>
						<seller_account_bban />
						<seller_account_upic />
						<seller_account_id />
					</xsl:when>
					<xsl:when test="seller_account_type[.='BBAN']">
						<seller_account_bban>
							<xsl:value-of select="seller_account_value" />
						</seller_account_bban>
						<seller_account_iban />
						<seller_account_upic />
						<seller_account_id />
					</xsl:when>
					<xsl:when test="seller_account_type[.='UPIC']">
						<seller_account_upic>
							<xsl:value-of select="seller_account_value" />
						</seller_account_upic>
						<seller_account_bban />
						<seller_account_iban />
						<seller_account_id />
					</xsl:when>
					<xsl:when test="seller_account_type[.='OTHER']">
						<seller_account_id>
							<xsl:value-of select="seller_account_value" />
						</seller_account_id>
						<seller_account_bban />
						<seller_account_upic />
						<seller_account_iban />
					</xsl:when>
				</xsl:choose>
				<!-- Financial Institution -->
				<xsl:if test="fin_inst_name">
					<fin_inst_name>
						<xsl:value-of select="fin_inst_name" />
					</fin_inst_name>
				</xsl:if>
				<xsl:if test="fin_inst_bic">
					<fin_inst_bic>
						<xsl:value-of select="fin_inst_bic" />
					</fin_inst_bic>
				</xsl:if>
				<xsl:if test="fin_inst_street_name">
					<fin_inst_street_name>
						<xsl:value-of select="fin_inst_street_name" />
					</fin_inst_street_name>
				</xsl:if>
				<xsl:if test="fin_inst_post_code">
					<fin_inst_post_code>
						<xsl:value-of select="fin_inst_post_code" />
					</fin_inst_post_code>
				</xsl:if>
				<xsl:if test="fin_inst_town_name">
					<fin_inst_town_name>
						<xsl:value-of select="fin_inst_town_name" />
					</fin_inst_town_name>
				</xsl:if>
				<xsl:if test="fin_inst_country_sub_div">
					<fin_inst_country_sub_div>
						<xsl:value-of select="fin_inst_country_sub_div" />
					</fin_inst_country_sub_div>
				</xsl:if>
				<xsl:if test="fin_inst_country">
					<fin_inst_country>
						<xsl:value-of select="fin_inst_country" />
					</fin_inst_country>
				</xsl:if>
				<xsl:if test="data_set_id">
					<data_set_id>
						<xsl:value-of select="data_set_id" />
					</data_set_id>
				</xsl:if>
				<!-- Buyer/Seller bank type -->
				<xsl:if test="buyer_bank_type_code">
					<buyer_bank_type_code>
						<xsl:value-of select="buyer_bank_type_code" />
					</buyer_bank_type_code>
				</xsl:if>
				<xsl:if test="seller_bank_type_code">
					<seller_bank_type_code>
						<xsl:value-of select="seller_bank_type_code" />
					</seller_bank_type_code>
				</xsl:if>
				<xsl:if test="issuer_type_code">
					<issuer_type_code>
						<xsl:value-of select="issuer_type_code" />
					</issuer_type_code>
				</xsl:if>
				<xsl:if test="final_presentation">
					<final_presentation>
						<xsl:value-of select="final_presentation" />
					</final_presentation>
				</xsl:if>
				<xsl:if test="submission_type">
					<submission_type>
						<xsl:value-of select="submission_type" />
					</submission_type>
				</xsl:if>
				<xsl:if test="tid">
					<tid>
						<xsl:value-of select="tid" />
					</tid>
				</xsl:if>
				<xsl:if test="po_ref_id">
					<po_ref_id>
						<xsl:value-of select="po_ref_id" />
					</po_ref_id>
				</xsl:if>
				<xsl:if test="po_issue_date">
					<po_issue_date>
						<xsl:value-of select="po_issue_date" />
					</po_issue_date>
				</xsl:if>

				<!-- Flags used to detect draft or controlled mode (delete or not previous 
					elements stored into ArrayList -->
				<!-- line item -->
				<xsl:if test="count(//*/lt_tnx_record) != 0">
					<additional_field name="hasLineItem" type="string"
						scope="none" description=" Flag to note if user was able to capture line items">Y</additional_field>
				</xsl:if>
				<!-- adjustment -->
				<xsl:if test="count(//*/adjustment) != 0">
					<additional_field name="hasAdjustment" type="string"
						scope="none" description=" Flag to note if user was able to capture adjustments">Y</additional_field>
				</xsl:if>
				<!-- tax -->
				<xsl:if test="count(//*/tax) != 0">
					<additional_field name="hasTax" type="string"
						scope="none" description=" Flag to note if user was able to capture taxes">Y</additional_field>
				</xsl:if>
				<!-- freight charge -->
				<xsl:if test="count(//*/freight_charges) != 0">
					<additional_field name="hasFreightCharge" type="string"
						scope="none" description=" Flag to note if user was able to capture freight charges">Y</additional_field>
				</xsl:if>
				<!-- payment term -->
				<xsl:if test="count(//*/payment) != 0">
					<additional_field name="hasPayment" type="string"
						scope="none" description=" Flag to note if user was able to capture payment terms">Y</additional_field>
				</xsl:if>
				<!-- inco term -->
				<xsl:if test="count(//*/incoterm) != 0">
					<additional_field name="hasIncoTerm" type="string"
						scope="none" description=" Flag to note if user was able to capture inco terms">Y</additional_field>
				</xsl:if>
				<!-- user information -->
				<xsl:if test="count(//*/user_defined_information) != 0">
					<additional_field name="hasUserInformation" type="string"
						scope="none"
						description=" Flag to note if user was able to capture buyer informations">Y</additional_field>
				</xsl:if>
				<!-- routing summary -->
				<xsl:choose>
					<xsl:when test="count(//*/routing_summary) != 0">
						<additional_field name="hasRoutingSummary" type="string"
							scope="none"
							description=" Flag to note if user was able to capture individual summary informations">Y</additional_field>
					</xsl:when>
				</xsl:choose>
				<!-- contact -->
				<xsl:if test="count(//*/contact) != 0">
					<additional_field name="hasContact" type="string"
						scope="none"
						description=" Flag to note if user was able to capture contact informations">Y</additional_field>
				</xsl:if>
				<xsl:if test="invoice_cust_ref_id">
					<additional_field name="invoice_cust_ref_id" type="string"
						scope="transaction" description="Supplier Invoice customer reference">
						<xsl:value-of select="invoice_cust_ref_id" />
					</additional_field>
				</xsl:if>
				<xsl:if test="action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code" />
					</action_req_code>
				</xsl:if>
			</com.misys.portal.openaccount.product.so.common.SellOrder>
			<!-- advising bank -->
			<com.misys.portal.product.common.Bank
				role_code="02">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id" /></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id" /></xsl:attribute>
				<brch_code>
					<xsl:value-of select="brch_code" />
				</brch_code>
				<company_id>
					<xsl:value-of select="$company_id" />
				</company_id>
				<abbv_name>
					<xsl:value-of select="$main_bank_abbv_name" />
				</abbv_name>
				<xsl:if test="advising_bank/name">
					<name>
						<xsl:value-of select="advising_bank/name" />
					</name>
				</xsl:if>
				<xsl:if test="$main_bank_name and not(advising_bank/name)">
					<name>
						<xsl:value-of select="$main_bank_name" />
					</name>
				</xsl:if>
				<xsl:if test="advising_bank/address_line_1">
					<address_line_1>
						<xsl:value-of select="advising_bank/address_line_1" />
					</address_line_1>
				</xsl:if>
				<xsl:if test="advising_bank/address_line_2">
					<address_line_2>
						<xsl:value-of select="advising_bank/address_line_2" />
					</address_line_2>
				</xsl:if>
				<xsl:if test="advising_bank/dom">
					<dom>
						<xsl:value-of select="advising_bank/dom" />
					</dom>
				</xsl:if>
				<xsl:if test="advising_bank/iso_code">
					<iso_code>
						<xsl:value-of select="advising_bank/iso_code" />
					</iso_code>
				</xsl:if>
				<xsl:if test="advising_bank/reference">
					<reference>
						<xsl:value-of select="advising_bank/reference" />
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.Bank>

			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="issuing_bank" />
				<xsl:with-param name="role_code">
					01
				</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id" />
				<xsl:with-param name="tnx_id" select="$tnx_id" />
				<xsl:with-param name="company_id" select="$company_id" />
			</xsl:call-template>
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="seller_bank" />
				<xsl:with-param name="role_code">
					14
				</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id" />
				<xsl:with-param name="tnx_id" select="$tnx_id" />
				<xsl:with-param name="company_id" select="$company_id" />
			</xsl:call-template>
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="buyer_bank" />
				<xsl:with-param name="role_code">
					15
				</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id" />
				<xsl:with-param name="tnx_id" select="$tnx_id" />
				<xsl:with-param name="company_id" select="$company_id" />
			</xsl:call-template>
			<!-- Narrative -->
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="bo_comment" />
				<xsl:with-param name="type_code">
					11
				</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id" />
				<xsl:with-param name="tnx_id" select="$tnx_id" />
				<xsl:with-param name="company_id" select="$company_id" />
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="free_format_text" />
				<xsl:with-param name="type_code">
					12
				</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id" />
				<xsl:with-param name="tnx_id" select="$tnx_id" />
				<xsl:with-param name="company_id" select="$company_id" />
			</xsl:call-template>

			<!-- Create Charges elements -->
			<xsl:apply-templates select="charges/charge">
				<xsl:with-param name="ref_id" select="$ref_id" />
				<xsl:with-param name="tnx_id" select="$tnx_id" />
				<xsl:with-param name="company_id" select="$company_id" />
			</xsl:apply-templates>

			<!-- Cross References -->
			<xsl:apply-templates select="cross_references/cross_reference" />

			<!-- Buyer Defined Informations -->
			<xsl:apply-templates
				select="user_defined_informations/user_defined_information">
				<xsl:with-param name="company_id">
					<xsl:value-of select="$company_id" />
				</xsl:with-param>
				<xsl:with-param name="ref_id">
					<xsl:value-of select="$ref_id" />
				</xsl:with-param>
				<xsl:with-param name="tnx_id">
					<xsl:value-of select="$tnx_id" />
				</xsl:with-param>
			</xsl:apply-templates>

			<!--Allowances (Adjustments, Taxes and Freight Charges) -->
			<xsl:apply-templates select="freight_charges/allowance">
				<xsl:with-param name="company_id">
					<xsl:value-of select="$company_id" />
				</xsl:with-param>
				<xsl:with-param name="ref_id">
					<xsl:value-of select="$ref_id" />
				</xsl:with-param>
				<xsl:with-param name="tnx_id">
					<xsl:value-of select="$tnx_id" />
				</xsl:with-param>
			</xsl:apply-templates>

			<xsl:apply-templates select="taxes/allowance">
				<xsl:with-param name="company_id">
					<xsl:value-of select="$company_id" />
				</xsl:with-param>
				<xsl:with-param name="ref_id">
					<xsl:value-of select="$ref_id" />
				</xsl:with-param>
				<xsl:with-param name="tnx_id">
					<xsl:value-of select="$tnx_id" />
				</xsl:with-param>
			</xsl:apply-templates>

			<xsl:apply-templates select="adjustments/allowance">
				<xsl:with-param name="company_id">
					<xsl:value-of select="$company_id" />
				</xsl:with-param>
				<xsl:with-param name="ref_id">
					<xsl:value-of select="$ref_id" />
				</xsl:with-param>
				<xsl:with-param name="tnx_id">
					<xsl:value-of select="$tnx_id" />
				</xsl:with-param>
			</xsl:apply-templates>

			<!-- Payments -->
			<xsl:apply-templates select="payments/payment">
				<xsl:with-param name="company_id">
					<xsl:value-of select="$company_id" />
				</xsl:with-param>
				<xsl:with-param name="ref_id">
					<xsl:value-of select="$ref_id" />
				</xsl:with-param>
				<xsl:with-param name="tnx_id">
					<xsl:value-of select="$tnx_id" />
				</xsl:with-param>
			</xsl:apply-templates>

			<!-- Incoterms -->
			<xsl:apply-templates select="incoterms/incoterm">
				<xsl:with-param name="company_id">
					<xsl:value-of select="$company_id" />
				</xsl:with-param>
				<xsl:with-param name="ref_id">
					<xsl:value-of select="$ref_id" />
				</xsl:with-param>
				<xsl:with-param name="tnx_id">
					<xsl:value-of select="$tnx_id" />
				</xsl:with-param>
			</xsl:apply-templates>

			<!-- Routing Summary (Transports) -->
			<xsl:apply-templates select="routing_summaries/routing_summary">
				<xsl:with-param name="company_id">
					<xsl:value-of select="$company_id" />
				</xsl:with-param>
				<xsl:with-param name="ref_id">
					<xsl:value-of select="$ref_id" />
				</xsl:with-param>
				<xsl:with-param name="tnx_id">
					<xsl:value-of select="$tnx_id" />
				</xsl:with-param>
			</xsl:apply-templates>

			<!-- Contacts -->
			<xsl:apply-templates select="contacts/contact">
				<xsl:with-param name="company_id">
					<xsl:value-of select="$company_id" />
				</xsl:with-param>
				<xsl:with-param name="ref_id">
					<xsl:value-of select="$ref_id" />
				</xsl:with-param>
				<xsl:with-param name="tnx_id">
					<xsl:value-of select="$tnx_id" />
				</xsl:with-param>
			</xsl:apply-templates>

			<!-- Line Items -->
			<xsl:apply-templates select="line_items/lt_tnx_record">
				<xsl:with-param name="company_id">
					<xsl:value-of select="$company_id" />
				</xsl:with-param>
				<xsl:with-param name="ref_id">
					<xsl:value-of select="$ref_id" />
				</xsl:with-param>
				<xsl:with-param name="tnx_id">
					<xsl:value-of select="$tnx_id" />
				</xsl:with-param>
			</xsl:apply-templates>

			<!-- Create Attachment elements -->
			<xsl:if test="tnx_stat_code">
				<xsl:apply-templates select="attachments/attachment">
					<xsl:with-param name="tnx_stat_code" select="tnx_stat_code" />
					<xsl:with-param name="ref_id" select="$ref_id" />
					<xsl:with-param name="tnx_id" select="$tnx_id" />
					<xsl:with-param name="company_id" select="$company_id" />
				</xsl:apply-templates>
			</xsl:if>
		</result>
	</xsl:template>
</xsl:stylesheet>
