<?xml version="1.0"?>
<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="service utils">
	
	<!-- Process EC-->
	<xsl:template match="ec_tnx_record">
		
		<!-- Retrieve references from DB -->
		<!-- Declare variable at top-level to make them visible from any templates -->
		<xsl:variable name="references" select="service:manageTradeReferences(//product_code, //ref_id, //tnx_id, //bo_ref_id, //bo_tnx_id, //cust_ref_id, //company_id, //company_name, //drawer_reference, //remitting_bank/abbv_name, '06', //prod_stat_code, //tnx_type_code)"/>
	
		<xsl:variable name="ref_id" select="$references/references/ref_id"/>
		<xsl:variable name="tnx_id" select="$references/references/tnx_id"/>
		<xsl:variable name="company_id" select="$references/references/company_id"/>
		<xsl:variable name="company_name" select="$references/references/company_name"/>
		<xsl:variable name="entity" select="$references/references/entity"/>
		<xsl:variable name="main_bank_abbv_name" select="$references/references/main_bank_abbv_name"/>
		<xsl:variable name="main_bank_name" select="$references/references/main_bank_name"/>
		<xsl:variable name="customer_bank_reference" select="$references/references/customer_bank_reference"/>
		
		<result>
			<com.misys.portal.product.ec.common.ExportCollection>
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>
				
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
				<xsl:if test="cust_ref_id">
					<cust_ref_id>
						<xsl:value-of select="cust_ref_id"/>
					</cust_ref_id>
				</xsl:if>
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>
				<company_id>
					<xsl:value-of select="$company_id"/>
				</company_id>
				
				<xsl:if test="entity">
					<entity>
						<xsl:value-of select="entity"/>
					</entity>
				</xsl:if>
				<xsl:if test="$entity!='' and not(entity)">
					<entity><xsl:value-of select="$entity"/></entity>
				</xsl:if>
				<company_name>
					<xsl:value-of select="$company_name"/>
				</company_name>
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
				
				<xsl:call-template name="manageProdStatCode">
					<xsl:with-param name="product" select="."/>
				</xsl:call-template>
				
				<xsl:if test="tnx_stat_code">
					<tnx_stat_code>
						<xsl:value-of select="tnx_stat_code"/>
					</tnx_stat_code>
				</xsl:if>
				<xsl:if test="sub_tnx_stat_code">
					<sub_tnx_stat_code>
						<xsl:value-of select="sub_tnx_stat_code"/>
					</sub_tnx_stat_code>
				</xsl:if>
				
				<product_code>EC</product_code>

				<xsl:if test="inp_user_id">
					<inp_user_id><xsl:value-of select="inp_user_id"/></inp_user_id>
				</xsl:if>
				<xsl:if test="inp_user_dttm">
					<inp_user_dttm><xsl:value-of select="inp_user_dttm"/></inp_user_dttm>
				</xsl:if>
				<xsl:if test="ctl_user_id">
					<ctl_user_id><xsl:value-of select="ctl_user_id"/></ctl_user_id>
				</xsl:if>
				<xsl:if test="ctl_user_dttm">
					<ctl_user_dttm><xsl:value-of select="ctl_user_dttm"/></ctl_user_dttm>
				</xsl:if>
				<xsl:if test="release_user_id">
					<release_user_id><xsl:value-of select="release_user_id"/></release_user_id>
				</xsl:if>
				<xsl:if test="release_user_dttm">
					<release_user_dttm><xsl:value-of select="release_user_dttm"/></release_user_dttm>
				</xsl:if>
				<xsl:if test="bo_inp_user_id">
					<bo_inp_user_id><xsl:value-of select="bo_inp_user_id"/></bo_inp_user_id>
				</xsl:if>
				<xsl:if test="bo_inp_user_dttm">
					<bo_inp_user_dttm><xsl:value-of select="bo_inp_user_dttm"/></bo_inp_user_dttm>
				</xsl:if>
				<xsl:if test="bo_ctl_user_id">
					<bo_ctl_user_id><xsl:value-of select="bo_ctl_user_id"/></bo_ctl_user_id>
				</xsl:if>
				<xsl:if test="bo_ctl_user_dttm">
					<bo_ctl_user_dttm><xsl:value-of select="bo_ctl_user_dttm"/></bo_ctl_user_dttm>
				</xsl:if>
				<xsl:if test="bo_release_user_id">
					<bo_release_user_id><xsl:value-of select="bo_release_user_id"/></bo_release_user_id>
				</xsl:if>
				<xsl:if test="bo_release_user_dttm">
					<bo_release_user_dttm><xsl:value-of select="bo_release_user_dttm"/></bo_release_user_dttm>
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
				<xsl:choose>
					<xsl:when test="ec_liab_amt">
						<ec_liab_amt>
							<xsl:value-of select="ec_liab_amt"/>
						</ec_liab_amt>
					</xsl:when>
					<xsl:when test="ec_outstanding_amt">
						<ec_liab_amt>
							<xsl:value-of select="ec_outstanding_amt"/>
						</ec_liab_amt>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
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
				<xsl:if test="drawer_country">
					<drawer_country>
						<xsl:value-of select="drawer_country"/>
					</drawer_country>
				</xsl:if>
				<xsl:if test="drawer_dom">
					<drawer_dom>
						<xsl:value-of select="drawer_dom"/>
					</drawer_dom>
				</xsl:if>
				<xsl:if test="drawer_reference">
					<drawer_reference>
						<xsl:value-of select="$customer_bank_reference"/>
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
				<xsl:choose>
				<xsl:when test="inco_term_year and inco_term_year[. != ''] and utils:validateIncoYear(//inco_term_year,$main_bank_abbv_name)">
					<inco_term_year>
						<xsl:value-of select="inco_term_year"/>
					</inco_term_year>
				</xsl:when>
				<xsl:when test="not(inco_term_year) and inco_term and inco_term[. != ''] ">
				<inco_term_year>OTHER</inco_term_year>
				</xsl:when>
				<xsl:when test="inco_term_year">
				<inco_term_year>
						<xsl:value-of select="inco_term_year"/>
				</inco_term_year>
				</xsl:when>
				</xsl:choose>
				
				<xsl:choose>
				<xsl:when test="inco_term_year and inco_term and (inco_term[. != ''] or inco_term_year[. != '']) and utils:validateIncoTerm(//inco_term_year,//inco_term,$main_bank_abbv_name)">
					<inco_term>
						<xsl:value-of select="inco_term"/>
					</inco_term>
				</xsl:when>
				<xsl:when test="not(inco_term_year) and inco_term and inco_term[. != ''] and utils:validateIncoTerm('OTHER',//inco_term,$main_bank_abbv_name)">
				<inco_term>
						<xsl:value-of select="inco_term"/>
					</inco_term>
				</xsl:when>
				<xsl:when test="inco_term">
				<inco_term>
						<xsl:value-of select="inco_term"/>
					</inco_term>
				</xsl:when>
				</xsl:choose>
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
					<insr_req_flag>
						<xsl:value-of select="insr_req_flag"/>
					</insr_req_flag>
				</xsl:if>
				<xsl:if test="maturity_date">
					<maturity_date>
						<xsl:value-of select="maturity_date"/>
					</maturity_date>
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
				<xsl:if test="bo_release_dttm">
					<additional_field name="bo_release_dttm" type="time" scope="none" description=" back office release dttm">
						<xsl:value-of select="bo_release_dttm"/>
					</additional_field>
				</xsl:if>
				
				<xsl:apply-templates select="additional_field"/>
			</com.misys.portal.product.ec.common.ExportCollection>
			
			<!-- Banks -->
			<com.misys.portal.product.common.Bank role_code="06">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="brch_code"/></brch_code>
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<abbv_name><xsl:value-of select="$main_bank_abbv_name"/></abbv_name>
				<xsl:if test="remitting_bank/name"><name><xsl:value-of select="remitting_bank/name"/></name></xsl:if>
				<xsl:if test="$main_bank_name and not(remitting_bank/name)"><name><xsl:value-of select="$main_bank_name"/></name></xsl:if>
				<xsl:if test="remitting_bank/address_line_1"><address_line_1><xsl:value-of select="remitting_bank/address_line_1"/></address_line_1></xsl:if>
				<xsl:if test="remitting_bank/address_line_2"><address_line_2><xsl:value-of select="remitting_bank/address_line_2"/></address_line_2></xsl:if>
				<xsl:if test="remitting_bank/dom"><dom><xsl:value-of select="remitting_bank/dom"/></dom></xsl:if>
				<xsl:if test="remitting_bank/iso_code"><iso_code><xsl:value-of select="remitting_bank/iso_code"/></iso_code></xsl:if>
				<xsl:if test="remitting_bank/reference"><reference><xsl:value-of select="remitting_bank/reference"/></reference></xsl:if>
			</com.misys.portal.product.common.Bank>
						
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="collecting_bank"/>
				<xsl:with-param name="role_code">07</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="presenting_bank"/>
				<xsl:with-param name="role_code">08</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="correspondent_bank"/>
				<xsl:with-param name="role_code">13</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			
			
			<!-- Narratives -->
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_description_goods"/>
				<xsl:with-param name="type_code">01</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_additional_instructions"/>
				<xsl:with-param name="type_code">03</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="bo_comment"/>
				<xsl:with-param name="type_code">11</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="free_format_text"/>
				<xsl:with-param name="type_code">12</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="amd_details"/>
				<xsl:with-param name="type_code">13</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			
			
			<!-- Create Charges elements -->
			<xsl:apply-templates select="charges/charge">
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:apply-templates>
			
			<!-- Create Document elements -->
			<xsl:apply-templates select="documents/document">
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
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
			
			<!-- Creating attachments elements for existing attachments in database-->
			<xsl:for-each select="$references/references/attachments/attachment">
				<xsl:call-template name="attachment-details">
					<xsl:with-param name="attachment" select="."></xsl:with-param>
					<xsl:with-param name="ref_id" select="$ref_id"/>
					<xsl:with-param name="tnx_id" select="$tnx_id"/>
					<xsl:with-param name="company_id" select="$company_id"/>
		 		</xsl:call-template>
			</xsl:for-each>
			<!-- Linked Licenses -->
			<xsl:if test="linked_licenses">
				<xsl:apply-templates select="linked_licenses/license">
					<xsl:with-param name="ref_id" select="$ref_id"/>
					<xsl:with-param name="tnx_id" select="$tnx_id"/>
					<xsl:with-param name="company_id" select="$company_id"/>
					<xsl:with-param name="main_bank_name" select="//remitting_bank/abbv_name"/>
				</xsl:apply-templates>
			</xsl:if>
		</result>
	</xsl:template>
</xsl:stylesheet>
