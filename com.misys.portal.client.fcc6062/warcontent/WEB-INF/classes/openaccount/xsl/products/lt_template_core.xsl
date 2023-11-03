<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:encryption="xalan://com.misys.portal.bnpp.common.security.sso.Cypher" exclude-result-prefixes="converttools encryption">
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
	<xsl:template match="lt_tnx_record">
		<result>
			<!--xsl:variable name="position">
				<xsl:value-of select="//*[substring-before(substring-after(name(), 'po_line_item_'), '_details_position"/>
			</xsl:variable>
			
			<xsl:if test="$position != 'nbElement'"-->
			
			<!-- Common Values -->
			<com.misys.portal.openaccount.product.baseline.common.TemplateLineItem>
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
				<xsl:if test="po_template_id">
					<po_template_id>
						<xsl:value-of select="po_template_id"/>
					</po_template_id>
				</xsl:if>
				<xsl:if test="template_description">
					<template_description>
						<xsl:value-of select="template_description"/>
					</template_description>
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
					
				<!-- Line Item Number -->
				<!-- TODO : ask MA -->
				<!-- <line_item_number>
					<xsl:choose>
						<xsl:when test="line_item_number[.!='']">
							<xsl:value-of select="line_item_number"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="position"/>
						</xsl:otherwise>
					</xsl:choose>
				</line_item_number>-->
				<xsl:if test="cust_ref_id">
					<line_item_number>
						<xsl:value-of select="cust_ref_id"/>
					</line_item_number>
				</xsl:if>
				
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
				
				<!-- collaboration -->
				<xsl:call-template name="collaboration" />				
			</com.misys.portal.openaccount.product.baseline.common.TemplateLineItem>
			
			<!-- Product Identifiers -->
			<xsl:call-template name="PRODUCT_GOODS">
				<xsl:with-param name="structure_name">product_identifier</xsl:with-param>
			</xsl:call-template>
			
			<!-- Product Characteristics -->
			<xsl:call-template name="PRODUCT_GOODS">
				<xsl:with-param name="structure_name">product_characteristic</xsl:with-param>
			</xsl:call-template>

			<!-- Product Categories -->
			<xsl:call-template name="PRODUCT_GOODS">
				<xsl:with-param name="structure_name">product_category</xsl:with-param>
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
				<xsl:with-param name="structure_name">inco_term</xsl:with-param>
			</xsl:call-template>	
			
			<!--Allowances (Adjustments)-->
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
				<xsl:with-param name="structure_name">adjustment</xsl:with-param>
			</xsl:call-template>		

			<!-- Create Charge element -->
			<!-- First, those charges belonging to the current transaction -->
			<!--xsl:for-each select="//*[starts-with(name(), 'charge_details_position_')]">
				<xsl:call-template name="CHARGE">
					<xsl:with-param name="brchCode">
						<xsl:value-of select="/*/brch_code"/>
					</xsl:with-param>
					<xsl:with-param name="companyId">
						<xsl:value-of select="/*/company_id"/>
					</xsl:with-param>
					<xsl:with-param name="refId">
						<xsl:value-of select="/*/template_id"/>
					</xsl:with-param>
					<xsl:with-param name="tnxId">
						<xsl:value-of select="/*/tnx_id"/>
					</xsl:with-param>
					<xsl:with-param name="position">
						<xsl:value-of select="substring-after(name(), 'charge_details_position_')"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each-->
			<!-- Second, the charges inputted earlier -->
			<!--xsl:for-each select="//*[starts-with(name(), 'old_charge_details_position_')]">
				<xsl:call-template name="OLD_CHARGE">
					<xsl:with-param name="brchCode">
						<xsl:value-of select="/*/brch_code"/>
					</xsl:with-param>
					<xsl:with-param name="companyId">
						<xsl:value-of select="/*/company_id"/>
					</xsl:with-param>
					<xsl:with-param name="refId">
						<xsl:value-of select="/*/template_id"/>
					</xsl:with-param>
					<xsl:with-param name="tnxId">
						<xsl:value-of select="/*/tnx_id"/>
					</xsl:with-param>
					<xsl:with-param name="position">
						<xsl:value-of select="substring-after(name(), 'old_charge_details_position_')"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each-->
			
			<!-- Cross References -->
			<xsl:for-each select="//*[starts-with(name(), 'cross_ref_cross_reference_id')]">
				<xsl:call-template name="CROSS_REFERENCE">
					<xsl:with-param name="brchCode"><xsl:value-of select="/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="/company_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-before(substring-after(name(), 'cross_ref_cross_reference_id'), '_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
	
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
				<xsl:with-param name="structureName">lt</xsl:with-param>
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
				<xsl:with-param name="structureName">lt_routing_summary_multimodal_airport</xsl:with-param>				
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
				<xsl:with-param name="structureName">lt_routing_summary_multimodal_port</xsl:with-param>				
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
				<xsl:with-param name="structureName">lt_routing_summary_multimodal_place</xsl:with-param>				
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
				<xsl:with-param name="structureName">lt_routing_summary_multimodal_taking_in_charge</xsl:with-param>				
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
				<xsl:with-param name="structureName">lt_routing_summary_multimodal_place_final_dest</xsl:with-param>				
			</xsl:call-template>			
		</result>
	</xsl:template>
	
	
		<!-- Product goods: identifiers, categories, caracteristics -->
	<xsl:template name ="PRODUCT_GOODS">
		<xsl:param name="structure_name"/>
		<xsl:if test="count(//*[starts-with(name(), concat($structure_name,'_details_position_'))]) != 0">
			<xsl:for-each select="//*[starts-with(name(), concat($structure_name,'_details_position_'))]">
				<xsl:variable name="position">
					<xsl:value-of select="substring-after(name(), concat($structure_name,'_details_position_'))"/>
				</xsl:variable>
				<xsl:if test="not(contains($position ,'nbElement'))">
					<com.misys.portal.openaccount.product.baseline.util.TemplateGoods>
						<xsl:if test="//*[starts-with(name(),concat($structure_name,'_details_goods_id_', $position))]">
							<xsl:attribute name="goods_id">
								<xsl:value-of select="//*[starts-with(name(),concat($structure_name,'_details_goods_id_', $position))]"/>
							</xsl:attribute>
						</xsl:if>
						
						<xsl:if test="//*[starts-with(name(),concat($structure_name,'_details_goods_type_', $position))]">
							<goods_type>
								<xsl:value-of select="//*[starts-with(name(),concat($structure_name,'_details_goods_type_', $position))]"/>
							</goods_type>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(),concat($structure_name,'_details_select_type_', $position))]">
							<type>
								<xsl:value-of select="//*[starts-with(name(),concat($structure_name,'_details_select_type_', $position))]"/>
							</type>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(),concat($structure_name,'_details_other_type_', $position))]">
							<other_type>
								<xsl:value-of select="//*[starts-with(name(),concat($structure_name,'_details_other_type_', $position))]"/>
							</other_type>
						</xsl:if>
						<xsl:if test="//*[starts-with(name(),concat($structure_name,'_details_description_', $position))]">
							<xsl:choose>
								<xsl:when test="count(//*[starts-with(name(),concat($structure_name,'_details_goods_type_', $position)) and .='01']) != 0">
									<identifier>
										<xsl:value-of select="//*[starts-with(name(),concat($structure_name,'_details_description_', $position))]"/>
									</identifier>
								</xsl:when>
								<xsl:when test="count(//*[starts-with(name(),concat($structure_name,'_details_goods_type_', $position)) and .='02']) != 0">
									<category>
										<xsl:value-of select="//*[starts-with(name(),concat($structure_name,'_details_description_', $position))]"/>
									</category>									
								</xsl:when>
								<xsl:when test="count(//*[starts-with(name(),concat($structure_name,'_details_goods_type_', $position)) and .='03']) != 0">
									<characteristic>
										<xsl:value-of select="//*[starts-with(name(),concat($structure_name,'_details_description_', $position))]"/>
									</characteristic>
								</xsl:when>
								<xsl:otherwise/>
							</xsl:choose>
						</xsl:if>
					</com.misys.portal.openaccount.product.baseline.util.TemplateGoods>
				</xsl:if>
			</xsl:for-each>	
		</xsl:if>	
	</xsl:template>
	


     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
