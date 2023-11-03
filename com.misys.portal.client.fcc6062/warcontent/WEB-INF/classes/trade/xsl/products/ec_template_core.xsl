<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="utils">
	<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>

	<!-- Common elements to save among all products -->
	<xsl:include href="../../../core/xsl/products/save_common.xsl"/>

	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process Template EC-->
	<xsl:template match="ec_tnx_record">
		<result>
			<com.misys.portal.product.ec.common.TemplateExportCollection>
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

				<xsl:if test="template_description">
					<template_description>
						<xsl:value-of select="template_description"/>
					</template_description>
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
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>	
				<xsl:if test="product_code">
					<product_code>
						<xsl:value-of select="product_code"/>
					</product_code>
				</xsl:if>
				<xsl:if test="ec_type_code">
					<ec_type_code>
						<xsl:value-of select="ec_type_code"/>
					</ec_type_code>
				</xsl:if>
				<xsl:if test="drawee_abbv_name">
					<drawee_abbv_name>
						<xsl:value-of select="drawee_abbv_name"/>
					</drawee_abbv_name>
				</xsl:if>
				<xsl:if test="drawee_name">
					<drawee_name>
						<xsl:value-of select="drawee_name"/>
					</drawee_name>
				</xsl:if>
				<xsl:if test="drawee_address_line_1">
					<drawee_address_line_1>
						<xsl:value-of select="drawee_address_line_1"/>
					</drawee_address_line_1>
				</xsl:if>
				<xsl:if test="drawee_address_line_2">
					<drawee_address_line_2>
						<xsl:value-of select="drawee_address_line_2"/>
					</drawee_address_line_2>
				</xsl:if>
				<xsl:if test="drawee_address_line_4">
					<drawee_address_line_4>
						<xsl:value-of select="drawee_address_line_4"/>
					</drawee_address_line_4>
				</xsl:if>
				<xsl:if test="drawee_dom">
					<drawee_dom>
						<xsl:value-of select="drawee_dom"/>
					</drawee_dom>
				</xsl:if>
				<xsl:if test="drawee_country">
					<drawee_country>
						<xsl:value-of select="drawee_country"/>
					</drawee_country>
				</xsl:if>
				<xsl:if test="drawee_reference">
					<drawee_reference>
						<xsl:value-of select="drawee_reference"/>
					</drawee_reference>
				</xsl:if>
				<xsl:if test="drawer_abbv_name">
					<drawer_abbv_name>
						<xsl:value-of select="drawer_abbv_name"/>
					</drawer_abbv_name>
				</xsl:if>
				<xsl:if test="drawer_name">
					<drawer_name>
						<xsl:value-of select="drawer_name"/>
					</drawer_name>
				</xsl:if>
				<xsl:if test="drawer_address_line_1">
					<drawer_address_line_1>
						<xsl:value-of select="drawer_address_line_1"/>
					</drawer_address_line_1>
				</xsl:if>
				<xsl:if test="drawer_address_line_2">
					<drawer_address_line_2>
						<xsl:value-of select="drawer_address_line_2"/>
					</drawer_address_line_2>
				</xsl:if>
				<xsl:if test="drawer_address_line_4">
					<drawer_address_line_4>
						<xsl:value-of select="drawer_address_line_4"/>
					</drawer_address_line_4>
				</xsl:if>
				<xsl:if test="drawer_dom">
					<drawer_dom>
						<xsl:value-of select="drawer_dom"/>
					</drawer_dom>
				</xsl:if>
				<xsl:if test="drawer_country">
					<drawer_country>
						<xsl:value-of select="drawer_country"/>
					</drawer_country>
				</xsl:if>
				<xsl:if test="drawer_reference">
					<drawer_reference>
                    	<xsl:value-of select="utils:decryptApplicantReference(drawer_reference)"/>
					</drawer_reference>
				</xsl:if>
				<xsl:if test="bol_number">
					<bol_number>
						<xsl:value-of select="bol_number"/>
					</bol_number>
				</xsl:if>
				<xsl:if test="shipping_mode">
					<shipping_mode>
						<xsl:value-of select="shipping_mode"/>
					</shipping_mode>
				</xsl:if>
				<xsl:if test="shipping_by">
					<shipping_by>
						<xsl:value-of select="shipping_by"/>
					</shipping_by>
				</xsl:if>
				<xsl:if test="ship_from">
					<ship_from>
						<xsl:value-of select="ship_from"/>
					</ship_from>
				</xsl:if>
				<xsl:if test="ship_to">
					<ship_to>
						<xsl:value-of select="ship_to"/>
					</ship_to>
				</xsl:if>
				<xsl:if test="inco_term_year">
					<inco_term_year>
						<xsl:value-of select="inco_term_year"/>
					</inco_term_year>
				</xsl:if>
				<xsl:if test="inco_term">
					<inco_term>
						<xsl:value-of select="inco_term"/>
					</inco_term>
				</xsl:if>
				<xsl:if test="inco_place">
					<inco_place>
						<xsl:value-of select="inco_place"/>
					</inco_place>
				</xsl:if>
				<xsl:if test="term_code">
					<term_code>
						<xsl:value-of select="term_code"/>
					</term_code>
				</xsl:if>
				<xsl:if test="docs_send_mode">
					<docs_send_mode>
						<xsl:value-of select="docs_send_mode"/>
					</docs_send_mode>
				</xsl:if>
				<xsl:if test="accpt_adv_send_mode">
					<accpt_adv_send_mode>
						<xsl:value-of select="accpt_adv_send_mode"/>
					</accpt_adv_send_mode>
				</xsl:if>
				<xsl:if test="protest_non_paymt">
					<protest_non_paymt>
						<xsl:value-of select="protest_non_paymt"/>
					</protest_non_paymt>
				</xsl:if>
				<xsl:if test="protest_non_accpt">
					<protest_non_accpt>
						<xsl:value-of select="protest_non_accpt"/>
					</protest_non_accpt>
				</xsl:if>
				<xsl:if test="protest_adv_send_mode">
					<protest_adv_send_mode>
						<xsl:value-of select="protest_adv_send_mode"/>
					</protest_adv_send_mode>
				</xsl:if>
				<xsl:if test="accpt_defd_flag">
					<accpt_defd_flag>
						<xsl:value-of select="accpt_defd_flag"/>
					</accpt_defd_flag>
				</xsl:if>
				<xsl:if test="store_goods_flag">
					<store_goods_flag>
						<xsl:value-of select="store_goods_flag"/>
					</store_goods_flag>
				</xsl:if>
				<xsl:if test="paymt_adv_send_mode">
					<paymt_adv_send_mode>
						<xsl:value-of select="paymt_adv_send_mode"/>
					</paymt_adv_send_mode>
				</xsl:if>
				<xsl:if test="tenor_desc">
					<tenor_desc>
						<xsl:value-of select="tenor_desc"/>
					</tenor_desc>
				</xsl:if>
				<xsl:if test="tenor_unit">
					<tenor>
						<xsl:value-of select="tenor_unit"/>
					</tenor>
				</xsl:if>
				<xsl:if test="tenor_event">
					<tenor>
						<xsl:value-of select="tenor_event"/>
					</tenor>
				</xsl:if>
				<xsl:if test="tenor">
					<tenor>
						<xsl:value-of select="tenor"/>
					</tenor>
				</xsl:if>
				<xsl:if test="tenor_start_date">
					<tenor_start_date>
						<xsl:value-of select="tenor_start_date"/>
					</tenor_start_date>
				</xsl:if>
				<xsl:if test="tenor_maturity_date">
					<tenor_maturity_date>
						<xsl:value-of select="tenor_maturity_date"/>
					</tenor_maturity_date>
				</xsl:if>
				
				<xsl:if test="needs_refer_to">
					<needs_refer_to>
						<xsl:value-of select="needs_refer_to"/>
					</needs_refer_to>
				</xsl:if>
				<xsl:if test="needs_instr_by_code">
					<needs_instr_by_code>
						<xsl:value-of select="needs_instr_by_code"/>
					</needs_instr_by_code>
				</xsl:if>
				<xsl:if test="tenor_base_date">
					<tenor_base_date>
						<xsl:value-of select="tenor_base_date"/>
					</tenor_base_date>
				</xsl:if>
				<xsl:if test="tenor_type">
					<tenor_type>
						<xsl:value-of select="tenor_type"/>
					</tenor_type>
				</xsl:if>
				<xsl:if test="tenor_days">
					<tenor_days>
						<xsl:value-of select="tenor_days"/>
					</tenor_days>
				</xsl:if>
				<xsl:if test="tenor_period">
					<tenor_period>
						<xsl:value-of select="tenor_period"/>
					</tenor_period>
				</xsl:if>
				<xsl:if test="tenor_from_after">
					<tenor_from_after>
						<xsl:value-of select="tenor_from_after"/>
					</tenor_from_after>
				</xsl:if>
				<xsl:if test="tenor_days_type">
					<tenor_days_type>
						<xsl:value-of select="tenor_days_type"/>
					</tenor_days_type>
				</xsl:if>
				<xsl:if test="tenor_type_details">
					<tenor_type_details>
						<xsl:value-of select="tenor_type_details"/>
					</tenor_type_details>
				</xsl:if>
				<xsl:if test="open_chrg_brn_by_code">
					<open_chrg_brn_by_code>
						<xsl:value-of select="open_chrg_brn_by_code"/>
					</open_chrg_brn_by_code>
				</xsl:if>
				<xsl:if test="corr_chrg_brn_by_code">
					<corr_chrg_brn_by_code>
						<xsl:value-of select="corr_chrg_brn_by_code"/>
					</corr_chrg_brn_by_code>
				</xsl:if>
				<xsl:if test="waive_chrg_flag">
					<waive_chrg_flag>
						<xsl:value-of select="waive_chrg_flag"/>
					</waive_chrg_flag>
				</xsl:if>
				<xsl:if test="int_rate">
					<int_rate>
						<xsl:value-of select="int_rate"/>
					</int_rate>
				</xsl:if>
				<xsl:if test="int_start_rate">
					<int_start_rate>
						<xsl:value-of select="int_start_rate"/>
					</int_start_rate>
				</xsl:if>
				<xsl:if test="int_maturity_date">
					<int_maturity_date>
						<xsl:value-of select="int_maturity_date"/>
					</int_maturity_date>
				</xsl:if>
				<xsl:if test="principal_act_no">
					<principal_act_no>
						<xsl:value-of select="principal_act_no"/>
					</principal_act_no>
				</xsl:if>
				<xsl:if test="not(ref_id)">
					<additional_field name="update_template" type="string" scope="none">Y</additional_field>
				</xsl:if>
				<xsl:if test="template_update_date">
					<template_update_date>
						<xsl:value-of select="template_update_date"/>
					</template_update_date>
				</xsl:if>
				<xsl:if test="last_usage_date">
					<last_usage_date>
						<xsl:value-of select="last_usage_date"/>
					</last_usage_date>
				</xsl:if>
				<xsl:if test="template_usage_count">
					<template_usage_count>
						<xsl:value-of select="template_usage_count"/>
					</template_usage_count>
				</xsl:if>				
				<!-- Re authentication -->
				<xsl:call-template name="AUTHENTICATION"/>
				<!-- collaboration -->
				<xsl:call-template name="collaboration" />
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.product.ec.common.TemplateExportCollection>
			<com.misys.portal.product.common.TemplateBank role_code="06">
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
				<xsl:if test="remitting_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="remitting_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="remitting_bank_name">
					<name>
						<xsl:value-of select="remitting_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="remitting_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="remitting_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="remitting_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="remitting_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="remitting_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="remitting_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="remitting_bank_dom">
					<dom>
						<xsl:value-of select="remitting_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="remitting_bank_iso_code">
					<iso_code>
						<xsl:value-of select="remitting_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="remitting_bank_reference">
					<reference>
						<xsl:value-of select="remitting_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateBank role_code="07">
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
				<xsl:if test="collecting_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="collecting_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="collecting_bank_name">
					<name>
						<xsl:value-of select="collecting_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="collecting_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="collecting_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="collecting_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="collecting_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="collecting_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="collecting_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="collecting_bank_dom">
					<dom>
						<xsl:value-of select="collecting_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="collecting_bank_iso_code">
					<iso_code>
						<xsl:value-of select="collecting_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="collecting_bank_reference">
					<reference>
						<xsl:value-of select="collecting_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateBank role_code="08">
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
				<xsl:if test="presenting_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="presenting_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="presenting_bank_name">
					<name>
						<xsl:value-of select="presenting_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="presenting_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="presenting_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="presenting_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="presenting_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="presenting_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="presenting_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="presenting_bank_dom">
					<dom>
						<xsl:value-of select="presenting_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="presenting_bank_iso_code">
					<iso_code>
						<xsl:value-of select="presenting_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="presenting_bank_reference">
					<reference>
						<xsl:value-of select="presenting_bank_reference"/>
					</reference>
				</xsl:if>
				<xsl:if test="presenting_bank_contact_name">
					<contact_name>
						<xsl:value-of select="presenting_bank_contact_name"/>
					</contact_name>
				</xsl:if>
				<xsl:if test="presenting_bank_phone">
					<phone>
						<xsl:value-of select="presenting_bank_phone"/>
					</phone>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateNarrative type_code="01">
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
				<xsl:if test="narrative_description_goods">
					<text>
						<xsl:value-of select="narrative_description_goods"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="03">
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
				<xsl:if test="narrative_additional_instructions">
					<text>
						<xsl:value-of select="narrative_additional_instructions"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>

			<!-- Create Document elements -->
			<xsl:for-each select="//*[starts-with(name(), 'documents_details_code_')]">
				<xsl:call-template name="TEMPLATE_DOCUMENT">
					<xsl:with-param name="brchCode"><xsl:value-of select="//ec_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//ec_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="templateId"><xsl:value-of select="//ec_tnx_record/template_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'documents_details_code_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>

		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
