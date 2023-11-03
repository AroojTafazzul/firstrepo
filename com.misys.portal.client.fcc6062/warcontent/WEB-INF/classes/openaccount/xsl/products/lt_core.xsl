<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.pnp-software.com/XSLTdoc">
	
	<!--
   Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
		
	<!-- Line Item -->
	<xd:doc>
		<xd:short>Line Item Template</xd:short>
		<xd:detail>This template sets poRefId,poTnxId,branch code,Company Id etc parameters,adds attributes reference id and transaction id and fills it with given selected value.
	It fills all the fields of line item with the given selected value present in it</xd:detail>
		<xd:param name="poRefId">Purchase Order Reference Id of Transaction</xd:param>
		<xd:param name="poTnxId">Purchase Order Transaction Id of Transaction</xd:param>
		<xd:param name="brchCode">Branch code of the bank</xd:param>
		<xd:param name="companyId">Identification of the company making the transaction</xd:param>
		<xd:param name="companyName">Name of the company making the transaction</xd:param>
		<xd:param name="entity">Entity of the company performing the transaction</xd:param>
	</xd:doc>
	<xsl:template match="lineItems/lineItem">
		<xsl:param name="poRefId"/>
		<xsl:param name="poTnxId"/>
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="companyName"/>
		<xsl:param name="entity"/>
		
<!--		<xsl:param name="position">XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</xsl:param>-->
		
<!--		<result subobject='true'>-->

		<com.misys.portal.openaccount.product.baseline.common.LineItemFile>
			<!-- Common Values -->
			<com.misys.portal.openaccount.product.baseline.common.LineItem>
				 <xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>  

				<xsl:if test="product_code">
					<product_code>LT</product_code>
				</xsl:if>
				
				<!--  po_ref_id is always equals to the PO ref_id (parent) (same for tnx_id, ...)-->
				<po_ref_id><xsl:value-of select="$poRefId"/></po_ref_id>
				<po_tnx_id><xsl:value-of select="$poTnxId"/></po_tnx_id>
				<brch_code><xsl:value-of select="$brchCode"/></brch_code>
				<company_id><xsl:value-of select="$companyId"/></company_id>
				<entity><xsl:value-of select="$entity"/></entity>
				<company_name><xsl:value-of select="$companyName"/></company_name>
				<is_valid><xsl:value-of select="is_valid"/></is_valid>
		
				<!-- other fields -->
				<xsl:if test="template_id">
					<template_id><xsl:value-of select="template_id"/></template_id>
				</xsl:if>
				<xsl:if test="template_description">
					<template_description><xsl:value-of select="template_description"/></template_description>
				</xsl:if>
				<xsl:if test="tnx_val_date">
					<tnx_val_date><xsl:value-of select="tnx_val_date"/></tnx_val_date>
				</xsl:if>
				<xsl:if test="appl_date">
					<appl_date><xsl:value-of select="appl_date"/></appl_date>
				</xsl:if>
				<xsl:if test="tnx_cur_code">
					<tnx_cur_code><xsl:value-of select="tnx_cur_code"/></tnx_cur_code>
				</xsl:if>
				<xsl:if test="tnx_type_code">
					<tnx_type_code><xsl:value-of select="tnx_type_code"/></tnx_type_code>
				</xsl:if>
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>	
				<xsl:if test="sub_tnx_type_code">
					<sub_tnx_type_code><xsl:value-of select="sub_tnx_type_code"/></sub_tnx_type_code>
				</xsl:if>
				<xsl:if test="prod_stat_code">
					<prod_stat_code><xsl:value-of select="prod_stat_code"/></prod_stat_code>
				</xsl:if>
				<xsl:if test="tnx_stat_code">
					<tnx_stat_code><xsl:value-of select="tnx_stat_code"/></tnx_stat_code>
				</xsl:if>
				
				<xsl:if test="cust_ref_id">
					<cust_ref_id><xsl:value-of select="cust_ref_id"/></cust_ref_id>
				</xsl:if>
				<xsl:if test="bo_ref_id">
					<bo_ref_id><xsl:value-of select="bo_ref_id"/></bo_ref_id>
				</xsl:if>

				<!-- Line Item Number -->
				<line_item_number>
					<xsl:choose>
						<xsl:when test="line_item_number">
							<xsl:value-of select="line_item_number"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="position()"/>
						</xsl:otherwise>
					</xsl:choose>
				</line_item_number>
				
				<!-- Product -->
				<xsl:if test="product_name">
					<product_name>
						<xsl:value-of select="product_name"/>
					</product_name>
				</xsl:if>
				<xsl:if test="product_orgn">
					<product_orgn>
						<xsl:value-of select="product_orgn"/>
					</product_orgn>
				</xsl:if>
				
				<!-- Quantity -->
				<xsl:if test="qty_unit_measr_code">
					<qty_unit_measr_code>
						<xsl:value-of select="qty_unit_measr_code"/>
					</qty_unit_measr_code>
				</xsl:if>
				<xsl:if test="qty_other_unit_measr">
					<qty_other_unit_measr>
						<xsl:value-of select="qty_other_unit_measr"/>
					</qty_other_unit_measr>
				</xsl:if>
				<xsl:if test="qty_val">
					<qty_val>
						<xsl:value-of select="qty_val"/>
					</qty_val>
				</xsl:if>
				<xsl:if test="qty_factor">
					<qty_factor>
						<xsl:value-of select="qty_factor"/>
					</qty_factor>
				</xsl:if>
				<xsl:if test="qty_tol_pstv_pct">
					<qty_tol_pstv_pct>
						<xsl:value-of select="qty_tol_pstv_pct"/>
					</qty_tol_pstv_pct>
				</xsl:if>
				<xsl:if test="qty_tol_neg_pct">
					<qty_tol_neg_pct>
						<xsl:value-of select="qty_tol_neg_pct"/>
					</qty_tol_neg_pct>
				</xsl:if>
				
				<!-- Price -->
				<xsl:if test="price_unit_measr_code">
					<price_unit_measr_code>
						<xsl:value-of select="price_unit_measr_code"/>
					</price_unit_measr_code>
				</xsl:if>
				<xsl:if test="price_other_unit_measr">
					<price_other_unit_measr>
						<xsl:value-of select="price_other_unit_measr"/>
					</price_other_unit_measr>
				</xsl:if>
				<xsl:if test="price_amt">
					<price_amt>
						<xsl:value-of select="price_amt"/>
					</price_amt>
				</xsl:if>
				<xsl:if test="price_cur_code">
					<price_cur_code>
						<xsl:value-of select="price_cur_code"/>
					</price_cur_code>
				</xsl:if>
				<xsl:if test="price_factor">
					<price_factor>
						<xsl:value-of select="price_factor"/>
					</price_factor>
				</xsl:if>
				<xsl:if test="price_tol_pstv_pct">
					<price_tol_pstv_pct>
						<xsl:value-of select="price_tol_pstv_pct"/>
					</price_tol_pstv_pct>
				</xsl:if>
				<xsl:if test="price_tol_neg_pct">
					<price_tol_neg_pct>
						<xsl:value-of select="price_tol_neg_pct"/>
					</price_tol_neg_pct>
				</xsl:if>
				
				<!-- Amount-->
				<xsl:if test="tnx_amt">
					<tnx_amt>
						<xsl:value-of select="tnx_amt"/>
					</tnx_amt>
				</xsl:if>
				<xsl:if test="tnx_cur_code">
					<tnx_cur_code>
						<xsl:value-of select="tnx_cur_code"/>
					</tnx_cur_code>
				</xsl:if>
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
				<xsl:if test="earliest_ship_date">
					<earliest_ship_date>
						<xsl:value-of select="earliest_ship_date"/>
					</earliest_ship_date>
				</xsl:if>
				<!-- Freight charges type -->
				<xsl:if test="freight_charges_type">
					<freight_charges_type><xsl:value-of select="freight_charges_type"/></freight_charges_type>
				</xsl:if>	
				<!-- Shipment details -->
				<xsl:if test="last_ship_date">
					<last_ship_date>
						<xsl:value-of select="last_ship_date"/>
					</last_ship_date>
				</xsl:if>	
				
				<!-- Flags used to detect draft or controlled mode (delete or not previous elements stored into ArrayList-->
				<!-- adjustment -->
				<xsl:if test="count(adjustments/adjustment) != 0">
					<additional_field name="hasAdjustment" type="string" scope="none" description=" Flag to note if user was able to capture adjustments">Y</additional_field>
				</xsl:if>
				<!-- tax -->
				<xsl:if test="count(taxes/tax) != 0">
					<additional_field name="hasTax" type="string" scope="none" description=" Flag to note if user was able to capture taxes">Y</additional_field>
				</xsl:if>
				<!-- freight charge -->
				<xsl:if test="count(freightCharges/freightCharge) != 0">
					<additional_field name="hasFreightCharge" type="string" scope="none" description=" Flag to note if user was able to capture freight charges">Y</additional_field>
				</xsl:if>
				<!-- inco term -->
				<xsl:if test="count(incoterms/incoterm) != 0">
					<additional_field name="hasIncoTerm" type="string" scope="none" description=" Flag to note if user was able to capture inco terms">Y</additional_field>
				</xsl:if>
				<!-- Individual Routing Summary -->
				<xsl:if test="count(routingSummaries/routingSummary) > 0">
					<additional_field name="hasRoutingSummary" type="string" scope="none" description=" Flag to note if user was able to capture summary informations">Y</additional_field>
				</xsl:if>
				<!--Multimodal Routing Summaries -->
				<xsl:if test="final_dest_place != '' or taking_in_charge != ''">
					<xsl:call-template name="multimodalRS">
					<xsl:with-param name="brchCode" select="brch_code"/>
					<xsl:with-param name="companyId" select="company_id"/>
					<xsl:with-param name="linkedRefId" select="ref_id"/>
					<xsl:with-param name="linkedTnxId" select="tnx_id"/>
				</xsl:call-template>
				</xsl:if>
			</com.misys.portal.openaccount.product.baseline.common.LineItem>
			
			<!-- Product Identifiers -->
			<xsl:apply-templates select="productIdentifiers/productIdentifier"/>
			
			<!-- Product Characteristics -->
			<xsl:apply-templates select="productCharacteristics/productCharacteristic"/>

			<!-- Product Categories -->
			<xsl:apply-templates select="productCategories/productCategory"/>
			
			<!-- Shipment Sub schedules -->
			<xsl:apply-templates select="shipmentSchedules/shipmentSchedule"/>
			
			<!-- Incoterms -->
			<xsl:apply-templates select="incoterms/incoterm">
				<xsl:with-param name="brchCode"><xsl:value-of select="brch_code"/></xsl:with-param>
				<xsl:with-param name="companyId"><xsl:value-of select="company_id"/></xsl:with-param>
				<xsl:with-param name="refId"><xsl:value-of select="ref_id"/></xsl:with-param>
				<xsl:with-param name="tnxId"><xsl:value-of select="tnx_id"/></xsl:with-param>
			</xsl:apply-templates>
			
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
			
			<!--Routing Summaries -->
			<xsl:apply-templates select="routingSummaries/routingSummary">
				<xsl:with-param name="brchCode" select="brch_code"/>
				<xsl:with-param name="companyId" select="company_id"/>
				<xsl:with-param name="linkedRefId" select="ref_id"/>
				<xsl:with-param name="linkedTnxId" select="tnx_id"/>
			</xsl:apply-templates>

		</com.misys.portal.openaccount.product.baseline.common.LineItemFile>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Product Identifier</xd:short>
		<xd:detail>This template calls other template and passes a parameter in it.</xd:detail>
	</xd:doc>
	<xsl:template match="productIdentifiers/productIdentifier">
		<xsl:call-template name="PRODUCT_GOODS">
			<xsl:with-param name="goodsType">01</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Product Category</xd:short>
		<xd:detail>This template calls other template and passes a parameter in it.</xd:detail>
	</xd:doc>
	<xsl:template match="productCategories/productCategory">
		<xsl:call-template name="PRODUCT_GOODS">
			<xsl:with-param name="goodsType">02</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Product Characteristics</xd:short>
		<xd:detail>This template calls other template and passes a parameter in it.</xd:detail>
	</xd:doc>
	<xsl:template match="productCharacteristics/productCharacteristic">
		<xsl:call-template name="PRODUCT_GOODS">
			<xsl:with-param name="goodsType">03</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Product goods: identifiers, categories, caracteristics -->
	<xd:doc>
		<xd:short>Product Goods</xd:short>
		<xd:detail>This template calls other template and passes a parameter in it.</xd:detail>
	</xd:doc>
	<xsl:template name="PRODUCT_GOODS">
		<xsl:param name="goodsType"/>

		<com.misys.portal.openaccount.product.baseline.util.Goods>
			<xsl:if test="goods_id">
				<xsl:attribute name="goods_id">
					<xsl:value-of select="goods_id"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="$goodsType">
				<goods_type>
					<xsl:value-of select="$goodsType"/>
				</goods_type>
			</xsl:if>
			<xsl:if test="type">
				<type>
					<xsl:value-of select="type"/>
				</type>
			</xsl:if>
			<xsl:if test="other_type">
				<other_type>
					<xsl:value-of select="other_type"/>
				</other_type>
			</xsl:if>
			<xsl:if test="description">
				<xsl:choose>
					<xsl:when test="$goodsType='01'">
						<identifier>
							<xsl:value-of select="description"/>
						</identifier>
					</xsl:when>
					<xsl:when test="$goodsType='02'">
						<category>
							<xsl:value-of select="description"/>
						</category>									
					</xsl:when>
					<xsl:when test="$goodsType='03'">
						<characteristic>
							<xsl:value-of select="description"/>
						</characteristic>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="is_valid">
				<is_valid>
					<xsl:value-of select="is_valid"/>
				</is_valid>
			</xsl:if>
		</com.misys.portal.openaccount.product.baseline.util.Goods>
	</xsl:template>
	
	<xsl:template match="shipmentSchedules/shipmentSchedule">
		<xsl:call-template name="Shipment_Schedule" />
	</xsl:template>

	<xsl:template name="Shipment_Schedule">
		<com.misys.portal.openaccount.product.baseline.util.ShipmentSchedule>
			<xsl:if test="shipment_id">
				<xsl:attribute name="shipment_id">
					<xsl:value-of select="shipment_id"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="sub_shipment_quantity_value">
				<sub_shipment_quantity_value>
					<xsl:value-of select="sub_shipment_quantity_value"/>
				</sub_shipment_quantity_value>
			</xsl:if>
			<xsl:if test="schedule_earliest_ship_date">
				<schedule_earliest_ship_date>
					<xsl:value-of select="schedule_earliest_ship_date"/>
				</schedule_earliest_ship_date>
			</xsl:if>
			<xsl:if test="schedule_latest_ship_date">
				<schedule_latest_ship_date>
					<xsl:value-of select="schedule_latest_ship_date"/>
				</schedule_latest_ship_date>
			</xsl:if>
			<xsl:if test="is_valid">
				<is_valid>
					<xsl:value-of select="is_valid"/>
				</is_valid>
			</xsl:if>
		</com.misys.portal.openaccount.product.baseline.util.ShipmentSchedule>
	</xsl:template>
     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
