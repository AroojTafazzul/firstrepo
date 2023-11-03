<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools" 
	xmlns:encryption="xalan://com.misys.portal.bnpp.common.security.sso.Cypher" 
	exclude-result-prefixes="converttools encryption">
	
<!--
   Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>
	<!-- Common elements to save among all products -->
	<xsl:include href="po_template_save_common.xsl"/>
	<xsl:include href="../../../core/xsl/products/save_common.xsl"/>
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process Purchase Order -->
	<xsl:template match="in_tnx_record">
		<result>
			<com.misys.portal.openaccount.product.po.common.TemplateInvoice>
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
				<xsl:if test="freight_charges_type">
					<freight_charges_type>
						<xsl:value-of select="freight_charges_type"/>
					</freight_charges_type>
				</xsl:if>
				<xsl:if test="goods_desc">
					<goods_desc>
						<xsl:value-of select="goods_desc"/>
					</goods_desc>
				</xsl:if>
				<!-- check required -->
				<xsl:if test="checked">
					<checked>
						<xsl:value-of select="checked"/>
					</checked>
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
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_name))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="seller_name"/>
							</xsl:otherwise>
						</xsl:choose>
					</seller_name>
				</xsl:if>
				<xsl:if test="seller_bei">
					<seller_bei>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_bei))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="seller_bei"/>
							</xsl:otherwise>
						</xsl:choose>
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
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_street_name))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="seller_street_name"/>
							</xsl:otherwise>
						</xsl:choose>
					</seller_street_name>
				</xsl:if>
				<xsl:if test="seller_post_code">
					<seller_post_code>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_post_code))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="seller_post_code"/>
							</xsl:otherwise>
						</xsl:choose>
					</seller_post_code>
				</xsl:if>
				<xsl:if test="seller_town_name">
					<seller_town_name>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_town_name))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="seller_town_name"/>
							</xsl:otherwise>
						</xsl:choose>
					</seller_town_name>
				</xsl:if>
				<xsl:if test="seller_country_sub_div">
					<seller_country_sub_div>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_country_sub_div))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="seller_country_sub_div"/>
							</xsl:otherwise>
						</xsl:choose>
					</seller_country_sub_div>
				</xsl:if>
				<xsl:if test="seller_country">
					<seller_country>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_country))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="seller_country"/>
							</xsl:otherwise>
						</xsl:choose>
					</seller_country>
				</xsl:if>
				<xsl:if test="seller_reference">
					<seller_reference>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(seller_reference))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="seller_reference"/>
							</xsl:otherwise>
						</xsl:choose>
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
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_name))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="buyer_name"/>
							</xsl:otherwise>
						</xsl:choose>
					</buyer_name>
				</xsl:if>
				<xsl:if test="buyer_bei">
					<buyer_bei>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_bei))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="buyer_bei"/>
							</xsl:otherwise>
						</xsl:choose>
					</buyer_bei>
				</xsl:if>
				<xsl:if test="buyer_street_name">
					<buyer_street_name>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_street_name))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="buyer_street_name"/>
							</xsl:otherwise>
						</xsl:choose>
					</buyer_street_name>
				</xsl:if>
				<xsl:if test="buyer_post_code">
					<buyer_post_code>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_post_code))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="buyer_post_code"/>
							</xsl:otherwise>
						</xsl:choose>
					</buyer_post_code>
				</xsl:if>
				<xsl:if test="buyer_town_name">
					<buyer_town_name>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_town_name))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="buyer_town_name"/>
							</xsl:otherwise>
						</xsl:choose>
					</buyer_town_name>
				</xsl:if>
				<xsl:if test="buyer_country_sub_div">
					<buyer_country_sub_div>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_country_sub_div))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="buyer_country_sub_div"/>
							</xsl:otherwise>
						</xsl:choose>
					</buyer_country_sub_div>
				</xsl:if>
				<xsl:if test="buyer_country">
					<buyer_country>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_country))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="buyer_country"/>
							</xsl:otherwise>
						</xsl:choose>
					</buyer_country>
				</xsl:if>
				<xsl:if test="buyer_reference">
					<buyer_reference>
						<xsl:choose>
							<xsl:when test="$companyType=$customerType and $IsEncrypted='true'">
								<xsl:value-of select="encryption:uncypher(string(buyer_reference))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="buyer_reference"/>
							</xsl:otherwise>
						</xsl:choose>
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

				<!-- collaboration -->
				<xsl:call-template name="collaboration" />				
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.openaccount.product.po.common.TemplateInvoice>
			<com.misys.portal.product.common.TemplateBank role_code="15">
				<xsl:if test="template_id">
					<xsl:attribute name="template_id">
						<xsl:value-of select="template_id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="company_id">
					<xsl:attribute name="company_id">
						<xsl:value-of select="company_id"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
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
				<xsl:if test="buyer_bank_bic_code">
					<iso_code>
						<xsl:value-of select="buyer_bank_bic_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="buyer_bank_reference">
					<reference>
						<xsl:value-of select="buyer_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<!-- issuing bank -->
			<com.misys.portal.product.common.TemplateBank role_code="01">
				<xsl:if test="template_id">
					<xsl:attribute name="template_id">
						<xsl:value-of select="template_id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="company_id">
					<xsl:attribute name="company_id">
						<xsl:value-of select="company_id"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
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
			</com.misys.portal.product.common.TemplateBank>

			<!-- Buyer Defined Informations -->
			<xsl:for-each select="//*[starts-with(name(), 'po_buyer_defined_information_details_position')]">
				<xsl:call-template name="BUYER_DEFINED_INFORMATION">
					<xsl:with-param name="brchCode">
						<xsl:value-of select="/*/brch_code"/>
					</xsl:with-param>
					<xsl:with-param name="companyId">
						<xsl:value-of select="/*/company_id"/>
					</xsl:with-param>
					<xsl:with-param name="templateId">
						<xsl:value-of select="/*/template_id"/>
					</xsl:with-param>
					<xsl:with-param name="position">
						<xsl:value-of select="substring-after(name(), 'buyer_defined_information_details_position_')"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>

			<!-- Seller Defined Informations -->
			<xsl:for-each select="//*[starts-with(name(), 'po_seller_defined_information_details_position')]">
				<xsl:call-template name="SELLER_DEFINED_INFORMATION">
					<xsl:with-param name="brchCode">
						<xsl:value-of select="/*/brch_code"/>
					</xsl:with-param>
					<xsl:with-param name="companyId">
						<xsl:value-of select="/*/company_id"/>
					</xsl:with-param>
					<xsl:with-param name="templateId">
						<xsl:value-of select="/*/template_id"/>
					</xsl:with-param>
					<xsl:with-param name="position">
						<xsl:value-of select="substring-after(name(), 'seller_defined_information_details_position_')"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!--Allowances (Adjustments, Taxes and Freight Charges)-->
			<xsl:call-template name="ADJUSTMENT">
				<xsl:with-param name="brchCode">
					<xsl:value-of select="brch_code"/>
				</xsl:with-param>
				<xsl:with-param name="companyId">
					<xsl:value-of select="company_id"/>
				</xsl:with-param>
				<xsl:with-param name="templateId">
					<xsl:value-of select="template_id"/>
				</xsl:with-param>
				<xsl:with-param name="structure_name">po_adjustment</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="TAX">
				<xsl:with-param name="brchCode">
					<xsl:value-of select="brch_code"/>
				</xsl:with-param>
				<xsl:with-param name="companyId">
					<xsl:value-of select="company_id"/>
				</xsl:with-param>
				<xsl:with-param name="templateId">
					<xsl:value-of select="template_id"/>
				</xsl:with-param>
				<xsl:with-param name="structure_name">po_tax</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="FREIGHT_CHARGE">
				<xsl:with-param name="brchCode">
					<xsl:value-of select="brch_code"/>
				</xsl:with-param>
				<xsl:with-param name="companyId">
					<xsl:value-of select="company_id"/>
				</xsl:with-param>
				<xsl:with-param name="templateId">
					<xsl:value-of select="template_id"/>
				</xsl:with-param>
				<xsl:with-param name="structure_name">po_freight_charges</xsl:with-param>
			</xsl:call-template>
			
			<!-- Payments -->
			<xsl:call-template name="PAYMENT">
				<xsl:with-param name="brchCode">
					<xsl:value-of select="brch_code"/>
				</xsl:with-param>
				<xsl:with-param name="companyId">
					<xsl:value-of select="company_id"/>
				</xsl:with-param>
				<xsl:with-param name="templateId">
					<xsl:value-of select="template_id"/>
				</xsl:with-param>
				<xsl:with-param name="structure_name">po_payment</xsl:with-param>
			</xsl:call-template>
			
			<!-- Incoterms -->
			<xsl:call-template name="INCO_TERMS">
				<xsl:with-param name="brchCode">
					<xsl:value-of select="brch_code"/>
				</xsl:with-param>
				<xsl:with-param name="companyId">
					<xsl:value-of select="company_id"/>
				</xsl:with-param>
				<xsl:with-param name="templateId">
					<xsl:value-of select="template_id"/>
				</xsl:with-param>
				<xsl:with-param name="structure_name">po_inco_term</xsl:with-param>
			</xsl:call-template>

			<!-- Routing Summary (Transports)-->
			<xsl:call-template name="INDIVIDUAL_TRANSPORTS">
				<xsl:with-param name="brchCode">
					<xsl:value-of select="brch_code"/>
				</xsl:with-param>
				<xsl:with-param name="companyId">
					<xsl:value-of select="company_id"/>
				</xsl:with-param>
				<xsl:with-param name="templateId">
					<xsl:value-of select="template_id"/>
				</xsl:with-param>
				<xsl:with-param name="structureName">po</xsl:with-param>					
			</xsl:call-template>
			
			<!-- Routing Summary (Transports)-->
			<xsl:call-template name="MULTIMODAL_TRANSPORTS">
				<xsl:with-param name="brchCode">
					<xsl:value-of select="brch_code"/>
				</xsl:with-param>
				<xsl:with-param name="companyId">
					<xsl:value-of select="company_id"/>
				</xsl:with-param>
				<xsl:with-param name="templateId">
					<xsl:value-of select="template_id"/>
				</xsl:with-param>
				<xsl:with-param name="structureName">po_routing_summary_multimodal_airport</xsl:with-param>				
			</xsl:call-template>
			
			<!-- Routing Summary (Transports)-->
			<xsl:call-template name="MULTIMODAL_TRANSPORTS">
				<xsl:with-param name="brchCode">
					<xsl:value-of select="brch_code"/>
				</xsl:with-param>
				<xsl:with-param name="companyId">
					<xsl:value-of select="company_id"/>
				</xsl:with-param>
				<xsl:with-param name="templateId">
					<xsl:value-of select="template_id"/>
				</xsl:with-param>
				<xsl:with-param name="structureName">po_routing_summary_multimodal_port</xsl:with-param>				
			</xsl:call-template>
			
			<!-- Routing Summary (Transports)-->
			<xsl:call-template name="MULTIMODAL_TRANSPORTS">
				<xsl:with-param name="brchCode">
					<xsl:value-of select="brch_code"/>
				</xsl:with-param>
				<xsl:with-param name="companyId">
					<xsl:value-of select="company_id"/>
				</xsl:with-param>
				<xsl:with-param name="templateId">
					<xsl:value-of select="template_id"/>
				</xsl:with-param>
				<xsl:with-param name="structureName">po_routing_summary_multimodal_place</xsl:with-param>				
			</xsl:call-template>	
			
			<!-- Routing Summary (Transports)-->
			<xsl:call-template name="MULTIMODAL_TRANSPORTS">
				<xsl:with-param name="brchCode">
					<xsl:value-of select="brch_code"/>
				</xsl:with-param>
				<xsl:with-param name="companyId">
					<xsl:value-of select="company_id"/>
				</xsl:with-param>
				<xsl:with-param name="templateId">
					<xsl:value-of select="template_id"/>
				</xsl:with-param>
				<xsl:with-param name="structureName">po_routing_summary_multimodal_taking_in_charge</xsl:with-param>				
			</xsl:call-template>
			
			<!-- Routing Summary (Transports)-->
			<xsl:call-template name="MULTIMODAL_TRANSPORTS">
				<xsl:with-param name="brchCode">
					<xsl:value-of select="brch_code"/>
				</xsl:with-param>
				<xsl:with-param name="companyId">
					<xsl:value-of select="company_id"/>
				</xsl:with-param>
				<xsl:with-param name="templateId">
					<xsl:value-of select="template_id"/>
				</xsl:with-param>
				<xsl:with-param name="structureName">po_routing_summary_multimodal_place_final_dest</xsl:with-param>				
			</xsl:call-template>

			<!-- Contacts -->
			<xsl:call-template name="CONTACT">
				<xsl:with-param name="brchCode">
					<xsl:value-of select="brch_code"/>
				</xsl:with-param>
				<xsl:with-param name="companyId">
					<xsl:value-of select="company_id"/>
				</xsl:with-param>
				<xsl:with-param name="templateId">
					<xsl:value-of select="template_id"/>
				</xsl:with-param>
				<xsl:with-param name="structure_name">po_contact</xsl:with-param>
			</xsl:call-template>
			
			<!-- Line Items -->
			<!-- group field by structure name-->
			<!-- solution below would work with Xpath 2 -->
			<!--xsl:for-each select="//*[matches(name(), 'po_line_item_[0-9]{1}[0-9]*_details_position')]"-->
			<!--xsl:for-each select="*[starts-with(name(), 'po_line_item_') 
				and contains(name(), '_details_position') 
				and substring-after(name(), '_details_position_')='' 
				and not(contains(name(), 'product_identifier'))
				and not(contains(name(), 'product_characteristic'))
				and not(contains(name(), 'product_category'))
				and not(contains(name(), 'inco_term'))
				and not(contains(name(), 'adjustment'))]"-->
			<xsl:for-each select="//*[starts-with(name(), 'po_line_item_details_position_') and not(contains(name(),'nbElement'))]">
				<xsl:variable name="position">
					<xsl:value-of select="substring-after(name(), 'po_line_item_details_position_')"/>
				</xsl:variable>
				<xsl:variable name="structure_prefix">po_line_item_<xsl:value-of select="$position"/></xsl:variable>
				<xsl:if test="$position != 'nbElement'">
					<lt_tnx_record>
						<!-- simple line item fields -->
						<xsl:for-each select="//*[starts-with(name(), 'po_line_item_details_') and contains(name(), concat('_', $position)) and not(contains(name(),'nbElement'))]">
							<xsl:call-template name="rename_field">
								<xsl:with-param name="new_name"><xsl:value-of select="substring-after(substring-before(name(), concat('_', $position)), 'po_line_item_details_')"/></xsl:with-param>
							</xsl:call-template>
						</xsl:for-each>
						<!-- dynamic line item fields (product_identifier, product_characteristic, product_category, inco_term, adjustment) -->
						<xsl:for-each select="//*[starts-with(name(), $structure_prefix) and not(contains(name(),'nbElement'))]">
							<xsl:call-template name="rename_field">
								<xsl:with-param name="new_name"><xsl:value-of select="substring-after(name(), concat($structure_prefix, '_'))"/></xsl:with-param>
							</xsl:call-template>
						</xsl:for-each>
						<!--xsl:for-each select="//*[starts-with(name(), concat($structure_prefix, '_product_identifier'))
							or starts-with(name(), concat($structure_prefix, '_product_characteristic'))
							or starts-with(name(), concat($structure_prefix, '_product_category'))
							or starts-with(name(), concat($structure_prefix, '_inco_term'))
							or starts-with(name(), concat($structure_prefix, '_adjustment'))]"-->
							<!--xsl:element name="{name()}"><xsl:value-of select="$structure_prefix"/></xsl:element-->
								<!--xsl:call-template name="rename_structured_field">
								<xsl:with-param name="prefix"><xsl:value-of select="$structure_prefix"/></xsl:with-param>
							</xsl:call-template>
						</xsl:for-each-->
					</lt_tnx_record>
				</xsl:if>
			</xsl:for-each>															
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
