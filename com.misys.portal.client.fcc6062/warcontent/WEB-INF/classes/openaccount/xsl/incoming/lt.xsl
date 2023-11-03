<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<!--
   Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<!-- Get the parameters -->
	<!--xsl:include href="../product_params.xsl"/-->
	<!-- Common elements to save among all products -->
	<!--xsl:include href="po_save_common.xsl"/-->
	<!-- Process Purchase Order -->
	<xsl:template match="line_items/lt_tnx_record">
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="company_id"/>
		<result subobject='true'>
			<com.misys.portal.openaccount.product.baseline.common.LineItemFile>
				<!-- Common Values -->
				<com.misys.portal.openaccount.product.baseline.common.LineItem>
					<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
					<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
	
					<!--product_code>LT</product_code-->
					
					<!--  po_ref_id is always equals to the PO ref_id (parent) (same for tnx_id, ...)-->
					<po_ref_id>
						<xsl:value-of select="$ref_id"/>
					</po_ref_id>
					<po_tnx_id>
						<xsl:value-of select="$tnx_id"/>
					</po_tnx_id>
					<xsl:if test="bo_tnx_id">
						<bo_tnx_id>
							<xsl:value-of select="bo_tnx_id"/>
						</bo_tnx_id>
					</xsl:if>
					<brch_code>
						<xsl:value-of select="$brch_code"/>
					</brch_code>
					<company_id>
						<xsl:value-of select="//company_id"/>
					</company_id>
					<entity>
						<xsl:value-of select="//entity"/>
					</entity>
					<company_name>
						<xsl:value-of select="//company_name"/>
					</company_name>
					
			
					<!-- other fields -->
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
					<xsl:if test="tnx_val_date">>
						<tnx_val_date>
							<xsl:value-of select="tnx_val_date"/>
						</tnx_val_date>
					</xsl:if>
					<xsl:if test="appl_date">
			 			<appl_date>
							<xsl:value-of select="appl_date"/>
						</appl_date>
					</xsl:if>
					<xsl:if test="tnx_cur_code">
						<tnx_cur_code>
							<xsl:value-of select="tnx_cur_code"/>
						</tnx_cur_code>
					</xsl:if>
					
					<tnx_type_code>
						<xsl:value-of select="//tnx_type_code"/>
					</tnx_type_code>
					<sub_tnx_type_code>
						<xsl:value-of select="//sub_tnx_type_code"/>
					</sub_tnx_type_code>
					<prod_stat_code>
						<xsl:value-of select="//prod_stat_code"/>
					</prod_stat_code>
					<tnx_stat_code>
						<xsl:value-of select="//tnx_stat_code"/>
					</tnx_stat_code>
					
					<xsl:if test="cust_ref_id">
						<cust_ref_id>
							<xsl:value-of select="cust_ref_id"/>
						</cust_ref_id>
					</xsl:if>
					
					<bo_ref_id>
						<xsl:value-of select="//bo_ref_id"/>
					</bo_ref_id>	
					
						
					<!-- Line Item Number -->
					<line_item_number>
						<!--xsl:choose>
							<xsl:when test="line_item_number"-->
								<xsl:value-of select="line_item_number"/>
							<!-- /xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$position"/>
							</xsl:otherwise>
						</xsl:choose-->
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
					<!-- Shipment details -->
					<xsl:if test="last_ship_date">
						<last_ship_date>
							<xsl:value-of select="last_ship_date"/>
						</last_ship_date>
					</xsl:if>
					<xsl:if test="earliest_ship_date">
						<earliest_ship_date>
							<xsl:value-of select="earliest_ship_date"/>
						</earliest_ship_date>
					</xsl:if>
				</com.misys.portal.openaccount.product.baseline.common.LineItem>
					
				<!-- Product Identifiers, Characteristics, Categories -->
				<xsl:apply-templates select="product_identifiers/product_identifier">
					<xsl:with-param name="company_id">
						<xsl:value-of select="$company_id"/>
					</xsl:with-param>
					<xsl:with-param name="ref_id">
						<xsl:value-of select="$ref_id"/>
					</xsl:with-param>
					<xsl:with-param name="tnx_id">
						<xsl:value-of select="$tnx_id"/>
					</xsl:with-param>
				</xsl:apply-templates>
				
				<!-- Product Categories -->
				<xsl:apply-templates select="product_categories/product_category">
					<xsl:with-param name="company_id">
						<xsl:value-of select="$company_id"/>
					</xsl:with-param>
					<xsl:with-param name="ref_id">
						<xsl:value-of select="$ref_id"/>
					</xsl:with-param>
					<xsl:with-param name="tnx_id">
						<xsl:value-of select="$tnx_id"/>
					</xsl:with-param>
				</xsl:apply-templates>
				
				<!-- Product Characteristics -->
				<xsl:apply-templates select="product_characteristics/product_characteristic">
					<xsl:with-param name="company_id">
						<xsl:value-of select="$company_id"/>
					</xsl:with-param>
					<xsl:with-param name="ref_id">
						<xsl:value-of select="$ref_id"/>
					</xsl:with-param>
					<xsl:with-param name="tnx_id">
						<xsl:value-of select="$tnx_id"/>
					</xsl:with-param>
				</xsl:apply-templates>
					
				<!-- Flags used to detect draft or controlled mode (delete or not previous elements stored into ArrayList-->
				<!--Allowances (Adjustments, Taxes and Freight Charges)-->
				<xsl:apply-templates select="adjustments/allowance">
					<xsl:with-param name="company_id">
						<xsl:value-of select="$company_id"/>
					</xsl:with-param>
					<xsl:with-param name="ref_id">
						<xsl:value-of select="$ref_id"/>
					</xsl:with-param>
					<xsl:with-param name="tnx_id">
						<xsl:value-of select="$tnx_id"/>
					</xsl:with-param>
					<xsl:with-param name="brchCode">
						<xsl:value-of select="$brch_code"/>
					</xsl:with-param>
				</xsl:apply-templates>
				
				<!-- Incoterms -->
				<xsl:apply-templates select="incoterms/incoterm">
					<xsl:with-param name="company_id">
						<xsl:value-of select="$company_id"/>
					</xsl:with-param>
					<xsl:with-param name="ref_id">
						<xsl:value-of select="$ref_id"/>
					</xsl:with-param>
					<xsl:with-param name="tnx_id">
						<xsl:value-of select="$tnx_id"/>
					</xsl:with-param>
					<xsl:with-param name="brchCode">
						<xsl:value-of select="$brch_code"/>
					</xsl:with-param>
				</xsl:apply-templates>
				
				<!--Allowances (Tax)-->
			<xsl:apply-templates select="taxes/allowance">
				<xsl:with-param name="company_id">
					<xsl:value-of select="$company_id"/>
				</xsl:with-param>
				<xsl:with-param name="ref_id">
					<xsl:value-of select="$ref_id"/>
				</xsl:with-param>
				<xsl:with-param name="tnx_id">
					<xsl:value-of select="$tnx_id"/>
				</xsl:with-param>
				<xsl:with-param name="brchCode">
					<xsl:value-of select="$brch_code"/>
				</xsl:with-param>
			</xsl:apply-templates>
			
			<!--Allowances (Freight charge)-->
			<xsl:apply-templates select="freight_charges/allowance">
				<xsl:with-param name="company_id">
					<xsl:value-of select="$company_id"/>
				</xsl:with-param>
				<xsl:with-param name="ref_id">
					<xsl:value-of select="$ref_id"/>
				</xsl:with-param>
				<xsl:with-param name="tnx_id">
					<xsl:value-of select="$tnx_id"/>
				</xsl:with-param>
				<xsl:with-param name="brchCode">
					<xsl:value-of select="$brch_code"/>
				</xsl:with-param>
			</xsl:apply-templates>

				<!--Routing Summaries -->
			<xsl:apply-templates select="routing_summaries/air_routing_summaries/rs_tnx_record | routing_summaries/sea_routing_summaries/rs_tnx_record | routing_summaries/rail_routing_summaries/rs_tnx_record | routing_summaries/road_routing_summaries/rs_tnx_record">
				<xsl:with-param name="brchCode" select="brch_code"/>
				<xsl:with-param name="companyId" select="$company_id"/>
				<xsl:with-param name="linked_ref_id" select="$ref_id"/>
				<xsl:with-param name="linked_tnx_id" select="$tnx_id"/>
			</xsl:apply-templates>
			
			<!--Multimodal Routing Summaries-->
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
			</com.misys.portal.openaccount.product.baseline.common.LineItemFile>
		</result>
	</xsl:template>
	
	<!-- Goods -->
	<xsl:template match="product_identifier | product_category | product_characteristic">
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="company_id"/>	
		<com.misys.portal.openaccount.product.baseline.util.Goods>
		<xsl:if test="$ref_id">
			<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
		</xsl:if>
		<xsl:if test="$tnx_id">
			<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
		</xsl:if>
	
		<brch_code><xsl:value-of select="$brch_code"/></brch_code>
		<xsl:if test="$company_id">
			<company_id><xsl:value-of select="$company_id"/></company_id>
		</xsl:if>
		
		<xsl:if test="goods_id">
			<goods_id>
				<xsl:value-of select="goods_id"/>
			</goods_id>
		</xsl:if>
		
		<xsl:if test="goods_type">
			<goods_type>
				<xsl:value-of select="goods_type"/>
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
		<xsl:if test="identifier">
			<identifier>
				<xsl:value-of select="identifier"/>
			</identifier>
		</xsl:if>
		<xsl:if test="category">
			<category>
				<xsl:value-of select="category"/>
			</category>	
		</xsl:if>
		<xsl:if test="characteristic">								
			<characteristic>
				<xsl:value-of select="characteristic"/>
			</characteristic>
		</xsl:if>
		<xsl:if test="is_valid">								
			<is_valid>
				<xsl:value-of select="is_valid"/>
			</is_valid>
		</xsl:if>
		</com.misys.portal.openaccount.product.baseline.util.Goods>
	</xsl:template>
</xsl:stylesheet>
