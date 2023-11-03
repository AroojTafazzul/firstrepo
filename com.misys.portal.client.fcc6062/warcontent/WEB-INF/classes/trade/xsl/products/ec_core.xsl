<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="utils">
	<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
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
	<!-- Process EC-->
	<xsl:template match="ec_tnx_record">
		<result>
			<com.misys.portal.product.ec.common.ExportCollection>
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="template_id">
					<template_id>
						<xsl:value-of select="template_id"/>
					</template_id>
				</xsl:if>
				<xsl:if test="bo_ref_id">
					<bo_ref_id>
						<xsl:value-of select="bo_ref_id"/>
					</bo_ref_id>
				</xsl:if>
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>	
				<xsl:if test="cust_ref_id">
					<cust_ref_id>
						<xsl:value-of select="cust_ref_id"/>
					</cust_ref_id>
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
				<xsl:if test="product_code">
					<product_code>
						<xsl:value-of select="product_code"/>
					</product_code>
				</xsl:if>
				<xsl:if test="appl_date">
					<appl_date>
						<xsl:value-of select="appl_date"/>
					</appl_date>
				</xsl:if>
				<xsl:if test="tnx_val_date">
					<tnx_val_date>
						<xsl:value-of select="tnx_val_date"/>
					</tnx_val_date>
				</xsl:if>
				<xsl:if test="tnx_cur_code">
					<tnx_cur_code>
						<xsl:value-of select="tnx_cur_code"/>
					</tnx_cur_code>
				</xsl:if>
				<xsl:if test="tnx_amt">
					<tnx_amt>
						<xsl:value-of select="tnx_amt"/>
					</tnx_amt>
				</xsl:if>
				<xsl:if test="ec_cur_code">
					<ec_cur_code>
						<xsl:value-of select="ec_cur_code"/>
					</ec_cur_code>
				</xsl:if>
				<xsl:if test="ec_amt">
					<ec_amt>
						<xsl:value-of select="ec_amt"/>
					</ec_amt>
				</xsl:if>
				<xsl:if test="ec_liab_amt">
					<ec_liab_amt>
						<xsl:value-of select="ec_liab_amt"/>
					</ec_liab_amt>
				</xsl:if>
				<xsl:if test="ec_outstanding_amt">
					<ec_outstanding_amt>
						<xsl:value-of select="ec_outstanding_amt"/>
					</ec_outstanding_amt>
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
				<xsl:if test="dir_coll_letter_flag">
					<dir_coll_letter_flag>
						<xsl:value-of select="dir_coll_letter_flag"/>
					</dir_coll_letter_flag>
				</xsl:if>
				<xsl:if test="boe_flag">
					<boe_flag>
						<xsl:value-of select="boe_flag"/>
					</boe_flag>
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
				<xsl:if test="tenor">
					<tenor>
						<xsl:value-of select="tenor"/>
					</tenor>
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
				<xsl:if test="fee_act_no">
					<fee_act_no>
						<xsl:value-of select="fee_act_no"/>
					</fee_act_no>
				</xsl:if>
				<xsl:if test="fwd_contract_no">
					<fwd_contract_no>
						<xsl:value-of select="fwd_contract_no"/>
					</fwd_contract_no>
				</xsl:if>
				<xsl:if test="insr_req_flag">
					<draft_term>
						<xsl:value-of select="insr_req_flag"/>
					</draft_term>
				</xsl:if>
				<xsl:if test="maturity_date">
					<maturity_date>
						<xsl:value-of select="maturity_date"/>
					</maturity_date>
				</xsl:if>
				<xsl:if test="action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code"/>
					</action_req_code>
				</xsl:if>
				<!-- Previous ctl date, used for synchronisation issues -->
				<xsl:if test="old_ctl_dttm">
					<additional_field name="old_ctl_dttm" type="time" scope="none" description="Previous control date used for synchronisation issues">
						<xsl:value-of select="old_ctl_dttm"/>
					</additional_field>
				</xsl:if>
				<!-- Previous input date, used to know if the product is already saved -->
				<xsl:if test="old_inp_dttm">
					<additional_field name="old_inp_dttm" type="time" scope="none" description="Previous input date used for synchronisation issues">
						<xsl:value-of select="old_inp_dttm"/>
					</additional_field>
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
				<!-- Security -->
				<xsl:if test="token">
					<additional_field name="token" type="string" scope="none" description="Security token">
						<xsl:value-of select="token"/>
					</additional_field>
				</xsl:if>
				<!-- 
				<xsl:if test="needs_refer_to">
					<additional_field name="needs_refer_to" type="string" scope="master">
						<xsl:value-of select="needs_refer_to"/>
					</additional_field>
				</xsl:if>
			
				<xsl:if test="needs_instr_by_code">
					<additional_field name="needs_instr_by_code" type="string" scope="master">
						<xsl:value-of select="needs_instr_by_code"/>
					</additional_field>
				</xsl:if>
				-->
				<!-- Re authentication -->
				<xsl:call-template name="AUTHENTICATION"/>
				<!-- collaboration -->
				<xsl:call-template name="collaboration" />
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.product.ec.common.ExportCollection>
			<com.misys.portal.product.common.Bank role_code="06">
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
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Bank role_code="07">
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
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Bank role_code="08">
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
			</com.misys.portal.product.common.Bank>
     		 <com.misys.portal.product.common.Bank role_code="13">
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
				<xsl:if test="correspondent_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="correspondent_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="correspondent_bank_name">
					<name>
						<xsl:value-of select="correspondent_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="correspondent_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="correspondent_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="correspondent_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="correspondent_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="correspondent_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="correspondent_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="correspondent_bank_dom">
					<dom>
						<xsl:value-of select="correspondent_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="correspondent_bank_iso_code">
					<iso_code>
						<xsl:value-of select="correspondent_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="correspondent_bank_reference">
					<reference>
						<xsl:value-of select="correspondent_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.Bank>
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
			<com.misys.portal.product.common.Narrative type_code="03">
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
				<xsl:if test="narrative_additional_instructions">
					<text>
						<xsl:value-of select="narrative_additional_instructions"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<xsl:if test="return_comments">
				<com.misys.portal.product.common.Narrative type_code="20">
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
						<text>
							<xsl:value-of select="return_comments"/>
						</text>
				</com.misys.portal.product.common.Narrative>
			</xsl:if>
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
				<com.misys.portal.product.common.Narrative type_code="20">
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
							<xsl:value-of select="return_comments"/>
						</text>
					</xsl:if>
				</com.misys.portal.product.common.Narrative>
			</xsl:if>
			<xsl:if test="amd_details">
				<com.misys.portal.product.common.Narrative type_code="13">
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
					<xsl:if test="amd_details">
						<text>
							<xsl:value-of select="amd_details"/>
						</text>
					</xsl:if>
				</com.misys.portal.product.common.Narrative>
			</xsl:if>

			<!-- Create Document elements -->
			<xsl:for-each select="//*[starts-with(name(), 'documents_details_code_')]">
				<xsl:call-template name="DOCUMENT">
					<xsl:with-param name="brchCode"><xsl:value-of select="//ec_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//ec_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//ec_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//ec_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'documents_details_code_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!-- Create Charge element -->
			
			<!-- First, those charges belonging to the current transaction -->
			<xsl:for-each select="//*[starts-with(name(), 'charge_details_chrg_details_')]">
				<xsl:call-template name="CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//ec_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//ec_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//ec_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//ec_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'charge_details_chrg_details_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!-- Second, the charges inputted earlier -->
			<xsl:for-each select="//*[starts-with(name(), 'old_charge_details_position_')]">
				<xsl:call-template name="OLD_CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//ec_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//ec_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//ec_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//ec_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'old_charge_details_position_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!-- Cross References -->
			<xsl:for-each select="//*[starts-with(name(), 'cross_ref_cross_reference_id')]">
				<xsl:call-template name="CROSS_REFERENCE">
					<xsl:with-param name="brchCode"><xsl:value-of select="/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="/company_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-before(substring-after(name(), 'cross_ref_cross_reference_id'), '_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			<xsl:if test="linked_licenses">
				<xsl:apply-templates select="linked_licenses/license"></xsl:apply-templates>
			</xsl:if>
		</result>
	</xsl:template>
	

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
