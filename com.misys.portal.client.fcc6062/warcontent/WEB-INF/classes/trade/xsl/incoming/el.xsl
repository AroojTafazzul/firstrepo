<?xml version="1.0"?>
<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				xmlns:localization="xalan://com.misys.portal.common.localization.Localization"				
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="service utils">

	<!-- Process EL File and Received Stand By-->
	<xsl:template match="el_tnx_record | sr_tnx_record">
	
		<!-- Retrieve references from DB -->
		<!-- Declare variable at top-level to make them visible from any templates -->
		<xsl:variable name="references" select="service:manageTradeReferences(//product_code, //ref_id, //tnx_id, //bo_ref_id, //bo_tnx_id, //cust_ref_id, //company_id, //company_name, //beneficiary_reference, //advising_bank/abbv_name, '02', //prod_stat_code, //tnx_type_code)"/>
	
		<xsl:variable name="ref_id" select="$references/references/ref_id"/>
		<xsl:variable name="tnx_id" select="$references/references/tnx_id"/>
		<xsl:variable name="company_id" select="$references/references/company_id"/>
		<xsl:variable name="company_name" select="$references/references/company_name"/>
		<xsl:variable name="entity" select="$references/references/entity"/>
		<xsl:variable name="main_bank_abbv_name" select="$references/references/main_bank_abbv_name"/>
		<xsl:variable name="main_bank_name" select="$references/references/main_bank_name"/>
		<xsl:variable name="customer_bank_reference" select="$references/references/customer_bank_reference"/>
		<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
     	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" /> 
		<xsl:variable name="creditType" select="translate(credit_available_with_bank/name,$uppercase,$smallcase)"/>
		
		<result>
			<com.misys.portal.product.el.common.ExportLetterOfCredit>
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>

				<xsl:if test="template_id">
					<template_id>
						<xsl:value-of select="template_id"/>
					</template_id>
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
					<entity>
						<xsl:value-of select="$entity"/>
					</entity>
				</xsl:if>
				<company_name>
					<xsl:value-of select="$company_name"/>
				</company_name>
				
				<xsl:if test="product_code">
					<product_code>
						<xsl:value-of select="product_code"/>
					</product_code>
				</xsl:if>
			
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
		 
		 		
				<xsl:if test="lc_ref_id">
					<lc_ref_id>
						<xsl:value-of select="lc_ref_id"/>
					</lc_ref_id>
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
				<xsl:if test="exp_date">
					<exp_date>
						<xsl:value-of select="exp_date"/>
					</exp_date>
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
				<xsl:if test="lc_cur_code">
					<lc_cur_code>
						<xsl:value-of select="lc_cur_code"/>
					</lc_cur_code>
				</xsl:if>
				<xsl:if test="tnx_amt">
					<tnx_amt>
						<xsl:value-of select="tnx_amt"/>
					</tnx_amt>
				</xsl:if>
				<!-- Set the lc available amt to lc amt only in case of seek beneficiary approval for amend. -->
				<xsl:if test="lc_amt">
					<xsl:choose>
						<xsl:when test="prod_stat_code = '31' and tnx_stat_code ='04' and tnx_type_code = '03' and lc_available_amt">
							<lc_amt>
								<xsl:value-of select="lc_available_amt"/>
							</lc_amt>
						</xsl:when>
						<xsl:otherwise>
							<lc_amt>
								<xsl:value-of select="lc_amt"/>
							</lc_amt>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:if test="lc_liab_amt">
					<lc_liab_amt>
						<xsl:value-of select="lc_liab_amt"/>
					</lc_liab_amt>
				</xsl:if>
				 
				<xsl:if test="lc_outstanding_amt">
					<lc_outstanding_amt>
						<xsl:value-of select="lc_outstanding_amt"/>
					</lc_outstanding_amt>
				</xsl:if>
				
				<!-- MPS-41561 - Available Amount -->
				<xsl:if test="lc_available_amt">
					<lc_available_amt>
						<xsl:value-of select="lc_available_amt"/>
					</lc_available_amt>
				</xsl:if>
				
				<xsl:if test="lc_type">
					<lc_type>
						<xsl:value-of select="lc_type"/>
					</lc_type>
				</xsl:if>
				<xsl:if test="expiry_place">
					<expiry_place>
						<xsl:value-of select="expiry_place"/>
					</expiry_place>
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
				<xsl:if test="part_ship_detl">
					<part_ship_detl>
						<xsl:value-of select="translate(part_ship_detl, $smallcase, $uppercase)"/>
					</part_ship_detl>
				</xsl:if>
				<xsl:if test="ship_from">
					<ship_from>
						<xsl:value-of select="ship_from"/>
					</ship_from>
				</xsl:if>
				<!-- SWIFT 2006 -->
				<xsl:if test="ship_loading">
					<ship_loading>
						<xsl:value-of select="ship_loading"/>
					</ship_loading>
				</xsl:if>
				<xsl:if test="ship_discharge">
					<ship_discharge>
						<xsl:value-of select="ship_discharge"/>
					</ship_discharge>
				</xsl:if>
				<!-- SWIFT 2006 -->
				<xsl:if test="ship_to">
					<ship_to>
						<xsl:value-of select="ship_to"/>
					</ship_to>
				</xsl:if>
				<xsl:if test="tran_ship_detl">
					<tran_ship_detl>
						<xsl:value-of select="translate(tran_ship_detl, $smallcase, $uppercase)"/>
					</tran_ship_detl>
				</xsl:if>
				<xsl:if test="cty_of_dest">
					<cty_of_dest>
						<xsl:value-of select="cty_of_dest"/>
					</cty_of_dest>
				</xsl:if>
				<xsl:if test="rvlv_lc_type">
					<rvlv_lc_type_code>
						<xsl:value-of select="rvlv_lc_type"/>
					</rvlv_lc_type_code>
				</xsl:if>
				<xsl:if test="max_no_of_rvlv">
					<max_no_of_rvlv>
						<xsl:value-of select="max_no_of_rvlv"/>
					</max_no_of_rvlv>
				</xsl:if>
				<xsl:if test="neg_tol_pct">
					<neg_tol_pct>
						<xsl:value-of select="neg_tol_pct"/>
					</neg_tol_pct>
				</xsl:if>
				<xsl:if test="pstv_tol_pct">
					<pstv_tol_pct>
						<xsl:value-of select="pstv_tol_pct"/>
					</pstv_tol_pct>
				</xsl:if>
				<xsl:if test="max_cr_desc_code">
					<max_cr_desc_code>
						<xsl:value-of select="max_cr_desc_code"/>
					</max_cr_desc_code>
				</xsl:if>
				<xsl:if test="cfm_flag">
					<cfm_flag>
						<xsl:value-of select="cfm_flag"/>
					</cfm_flag>
				</xsl:if>
				<xsl:if test="cr_avl_by_code">
					<cr_avl_by_code>
						<xsl:value-of select="cr_avl_by_code"/>
					</cr_avl_by_code>
				</xsl:if>
				<xsl:if test="dir_reim_flag">
					<dir_reim_flag>
						<xsl:value-of select="dir_reim_flag"/>
					</dir_reim_flag>
				</xsl:if>
				<xsl:if test="irv_flag">
					<irv_flag>
						<xsl:value-of select="irv_flag"/>
					</irv_flag>
				</xsl:if>
				<xsl:if test="ntrf_flag">
					<ntrf_flag>
						<xsl:value-of select="ntrf_flag"/>
					</ntrf_flag>
				</xsl:if>
				<xsl:if test="stnd_by_lc_flag">
					<stnd_by_lc_flag>
						<xsl:value-of select="stnd_by_lc_flag"/>
					</stnd_by_lc_flag>
				</xsl:if>
				<xsl:if test="cfm_inst_code">
					<cfm_inst_code>
						<xsl:value-of select="cfm_inst_code"/>
					</cfm_inst_code>
				</xsl:if>
				<xsl:if test="cfm_chrg_brn_by_code">
					<cfm_chrg_brn_by_code>
						<xsl:value-of select="cfm_chrg_brn_by_code"/>
					</cfm_chrg_brn_by_code>
				</xsl:if>
				<xsl:if test="corr_chrg_brn_by_code">
					<corr_chrg_brn_by_code>
						<xsl:value-of select="corr_chrg_brn_by_code"/>
					</corr_chrg_brn_by_code>
				</xsl:if>
				<xsl:if test="open_chrg_brn_by_code">
					<open_chrg_brn_by_code>
						<xsl:value-of select="open_chrg_brn_by_code"/>
					</open_chrg_brn_by_code>
				</xsl:if>
				<xsl:if test="amd_chrg_brn_by_code">
					<amd_chrg_brn_by_code>
						<xsl:value-of select="amd_chrg_brn_by_code"/>
					</amd_chrg_brn_by_code>
				</xsl:if>
				<xsl:if test="imp_bill_ref_id">
					<imp_bill_ref_id>
						<xsl:value-of select="imp_bill_ref_id"/>
					</imp_bill_ref_id>
				</xsl:if>
				<xsl:if test="adv_send_mode">
					<adv_send_mode>
						<xsl:value-of select="adv_send_mode"/>
					</adv_send_mode>
				</xsl:if>
				<xsl:if test="adv_send_mode_text">
					<adv_send_mode_text>
						<xsl:value-of select="adv_send_mode_text"/>
					</adv_send_mode_text>
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
				<xsl:if test="beneficiary_abbv_name">
					<beneficiary_abbv_name>
						<xsl:value-of select="beneficiary_abbv_name"/>
					</beneficiary_abbv_name>
				</xsl:if>
				<xsl:if test="not(beneficiary_abbv_name)">
					<beneficiary_abbv_name>
						<xsl:value-of select="$company_name"/>
					</beneficiary_abbv_name>
				</xsl:if>				
				<xsl:if test="beneficiary_name">
					<beneficiary_name>
						<xsl:value-of select="beneficiary_name"/>
					</beneficiary_name>
				</xsl:if>
				<xsl:if test="beneficiary_address_line_1">
					<beneficiary_address_line_1>
						<xsl:value-of select="beneficiary_address_line_1"/>
					</beneficiary_address_line_1>
				</xsl:if>
				<xsl:if test="beneficiary_address_line_2">
					<beneficiary_address_line_2>
						<xsl:value-of select="beneficiary_address_line_2"/>
					</beneficiary_address_line_2>
				</xsl:if>
				<xsl:if test="beneficiary_address_line_4">
					<beneficiary_address_line_4>
						<xsl:value-of select="beneficiary_address_line_4"/>
					</beneficiary_address_line_4>
				</xsl:if>
				<xsl:if test="beneficiary_dom">
					<beneficiary_dom>
						<xsl:value-of select="beneficiary_dom"/>
					</beneficiary_dom>
				</xsl:if>
				<xsl:if test="$customer_bank_reference">
					<beneficiary_reference>
						<xsl:value-of select="$customer_bank_reference"/>
					</beneficiary_reference>
				</xsl:if>
				<xsl:if test="beneficiary_reference and $customer_bank_reference=''">
					<beneficiary_reference>
						<xsl:value-of select="beneficiary_reference"/>
					</beneficiary_reference>
				</xsl:if>
				<xsl:if test="sec_beneficiary_name">
					<sec_beneficiary_name>
						<xsl:value-of select="sec_beneficiary_name"/>
					</sec_beneficiary_name>
				</xsl:if>
				<xsl:if test="sec_beneficiary_abbv_name">
					<sec_beneficiary_abbv_name>
						<xsl:value-of select="sec_beneficiary_abbv_name"/>
					</sec_beneficiary_abbv_name>
				</xsl:if>
				<xsl:if test="sec_beneficiary_address_line_1">
					<sec_beneficiary_address_line_1>
						<xsl:value-of select="sec_beneficiary_address_line_1"/>
					</sec_beneficiary_address_line_1>
				</xsl:if>
				<xsl:if test="sec_beneficiary_address_line_2">
					<sec_beneficiary_address_line_2>
						<xsl:value-of select="sec_beneficiary_address_line_2"/>
					</sec_beneficiary_address_line_2>
				</xsl:if>
				<xsl:if test="sec_beneficiary_address_line_4">
					<sec_beneficiary_address_line_4>
						<xsl:value-of select="sec_beneficiary_address_line_4"/>
					</sec_beneficiary_address_line_4>
				</xsl:if>
				<xsl:if test="sec_beneficiary_dom">
					<sec_beneficiary_dom>
						<xsl:value-of select="sec_beneficiary_dom"/>
					</sec_beneficiary_dom>
				</xsl:if>
				<xsl:if test="sec_beneficiary_reference">
					<sec_beneficiary_reference>
						<xsl:value-of select="sec_beneficiary_reference"/>
					</sec_beneficiary_reference>
				</xsl:if>
				
				<xsl:if test="assignee_name">
					<assignee_name>
						<xsl:value-of select="assignee_name"/>
					</assignee_name>
				</xsl:if>
				<xsl:if test="assignee_address_line_1">
					<assignee_address_line_1>
						<xsl:value-of select="assignee_address_line_1"/>
					</assignee_address_line_1>
				</xsl:if>
				<xsl:if test="assignee_address_line_2">
					<assignee_address_line_2>
						<xsl:value-of select="assignee_address_line_2"/>
					</assignee_address_line_2>
				</xsl:if>
				<xsl:if test="assignee_address_line_4">
					<assignee_address_line_4>
						<xsl:value-of select="assignee_address_line_4"/>
					</assignee_address_line_4>
				</xsl:if>
				<xsl:if test="assignee_dom">
					<assignee_dom>
						<xsl:value-of select="assignee_dom"/>
					</assignee_dom>
				</xsl:if>
				<xsl:if test="assignee_reference">
					<assignee_reference>
						<xsl:value-of select="assignee_reference"/>
					</assignee_reference>
				</xsl:if>
			
				<xsl:if test="notify_amendment_flag">
					<notify_amendment_flag>
						<xsl:value-of select="notify_amendment_flag"/>
					</notify_amendment_flag>
				</xsl:if>
			 
				<xsl:if test="substitute_invoice_flag">
					<substitute_invoice_flag>
						<xsl:value-of select="substitute_invoice_flag"/>
					</substitute_invoice_flag>
				</xsl:if>
				<xsl:if test="advise_mode_code">
					<advise_mode_code>
						<xsl:value-of select="advise_mode_code"/>
					</advise_mode_code>
				</xsl:if>
				<xsl:if test="applicable_rules">
					<applicable_rules>
						<xsl:value-of select="applicable_rules"/>
					</applicable_rules>
				</xsl:if>
				<xsl:if test="applicable_rules_text">
					<applicable_rules_text>
						<xsl:value-of select="applicable_rules_text"/>
					</applicable_rules_text>
				</xsl:if>
				<xsl:if test="applicant_abbv_name">
					<applicant_abbv_name>
						<xsl:value-of select="applicant_abbv_name"/>
					</applicant_abbv_name>
				</xsl:if>
				<xsl:if test="applicant_name">
					<applicant_name>
						<xsl:value-of select="applicant_name"/>
					</applicant_name>
				</xsl:if>
				<xsl:if test="applicant_address_line_1">
					<applicant_address_line_1>
						<xsl:value-of select="applicant_address_line_1"/>
					</applicant_address_line_1>
				</xsl:if>
				<xsl:if test="applicant_address_line_2">
					<applicant_address_line_2>
						<xsl:value-of select="applicant_address_line_2"/>
					</applicant_address_line_2>
				</xsl:if>
				<xsl:if test="applicant_address_line_4">
					<applicant_address_line_4>
						<xsl:value-of select="applicant_address_line_4"/>
					</applicant_address_line_4>
				</xsl:if>
				<xsl:if test="applicant_dom">
					<applicant_dom>
						<xsl:value-of select="applicant_dom"/>
					</applicant_dom>
				</xsl:if>
				<xsl:if test="applicant_reference">
					<applicant_reference>
						<xsl:value-of select="applicant_reference"/>
					</applicant_reference>
				</xsl:if>
				
				<xsl:if test="renew_flag">
					<renew_flag>
						<xsl:value-of select="renew_flag"/>
					</renew_flag>
				</xsl:if>
				<xsl:if test="renew_on_code">
					<renew_on_code>
						<xsl:value-of select="renew_on_code"/>
					</renew_on_code>
				</xsl:if>
				<xsl:if test="renewal_calendar_date">
					<renewal_calendar_date>
						<xsl:value-of select="renewal_calendar_date"/>
					</renewal_calendar_date>
				</xsl:if>
				<xsl:if test="renew_for_nb">
					<renew_for_nb>
						<xsl:value-of select="renew_for_nb"/>
					</renew_for_nb>
				</xsl:if>
				<xsl:if test="renew_for_period">
					<renew_for_period>
						<xsl:value-of select="renew_for_period"/>
					</renew_for_period>
				</xsl:if>
				<xsl:if test="advise_renewal_flag">
					<advise_renewal_flag>
						<xsl:value-of select="advise_renewal_flag"/>
					</advise_renewal_flag>
				</xsl:if>
				<xsl:if test="advise_renewal_days_nb">
					<advise_renewal_days_nb>
						<xsl:value-of select="advise_renewal_days_nb"/>
					</advise_renewal_days_nb>
				</xsl:if>
				<xsl:if test="rolling_renewal_flag">
					<rolling_renewal_flag>
						<xsl:value-of select="rolling_renewal_flag"/>
					</rolling_renewal_flag>
				</xsl:if>
				<xsl:if test="rolling_renew_on_code">
					<rolling_renew_on_code>
						<xsl:value-of select="rolling_renew_on_code"/>
					</rolling_renew_on_code>
				</xsl:if>
				<xsl:if test="rolling_renew_for_nb">
					<rolling_renew_for_nb>
						<xsl:value-of select="rolling_renew_for_nb"/>
					</rolling_renew_for_nb>
				</xsl:if>
				<xsl:if test="rolling_renew_for_period">
					<rolling_renew_for_period>
						<xsl:value-of select="rolling_renew_for_period"/>
					</rolling_renew_for_period>
				</xsl:if>
				<xsl:if test="rolling_renewal_nb">
					<rolling_renewal_nb>
						<xsl:value-of select="rolling_renewal_nb"/>
					</rolling_renewal_nb>
				</xsl:if>
				<xsl:if test="rolling_day_in_month">
					<rolling_day_in_month>
						<xsl:value-of select="rolling_day_in_month"/>
					</rolling_day_in_month>
				</xsl:if>
				<xsl:if test="rolling_cancellation_days">
					<rolling_cancellation_days>
						<xsl:value-of select="rolling_cancellation_days"/>
					</rolling_cancellation_days>
				</xsl:if>
				<xsl:if test="renew_amt_code">
					<renew_amt_code>
						<xsl:value-of select="renew_amt_code"/>
					</renew_amt_code>
				</xsl:if>
				<xsl:if test="projected_expiry_date">
					<projected_expiry_date>
						<xsl:value-of select="projected_expiry_date"/>
					</projected_expiry_date>
				</xsl:if>
				<!-- Standby LC Rolling final expiry date -->
				<xsl:if test="final_expiry_date">
					<final_expiry_date>
						<xsl:value-of select="final_expiry_date"/>
					</final_expiry_date>
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
				<xsl:if test="doc_ref_no">
					<doc_ref_no>
						<xsl:value-of select="doc_ref_no"/>
					</doc_ref_no>
				</xsl:if>
				<xsl:if test="draft_term">
					<draft_term>
						<xsl:value-of select="draft_term"/>
					</draft_term>
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
				<xsl:if test="maturity_date">
					<maturity_date>
						<xsl:value-of select="maturity_date"/>
					</maturity_date>
				</xsl:if>
				<xsl:if test="eucp_flag">
					<eucp_flag>
						<xsl:value-of select="eucp_flag"/>
					</eucp_flag>
				</xsl:if>
				<xsl:if test="eucp_version">
					<eucp_version>
						<xsl:value-of select="eucp_version"/>
					</eucp_version>
				</xsl:if>
				<xsl:if test="eucp_presentation_place">
					<eucp_presentation_place>
						<xsl:value-of select="eucp_presentation_place"/>
					</eucp_presentation_place>
				</xsl:if>
				<xsl:if test="delivery_channel">
					<delivery_channel>
						<xsl:value-of select="delivery_channel"/>
					</delivery_channel>
				</xsl:if>
				<xsl:if test="action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code"/>
					</action_req_code>
				</xsl:if>				
				<xsl:if test="period_presentation_days">
					<period_presentation_days>
						<xsl:value-of select="period_presentation_days"/>
					</period_presentation_days>
				</xsl:if>	
				<xsl:if test="req_conf_party_flag">
					<req_conf_party_flag>
						<xsl:value-of select="req_conf_party_flag"/>
					</req_conf_party_flag>
				</xsl:if>			
				<!-- Previous ctl date, used for synchronisation issues -->
				<xsl:if test="old_ctl_dttm">
					<additional_field name="old_ctl_dttm" type="time" scope="none" description=" Previous control date used for synchronisation issues">
						<xsl:value-of select="old_ctl_dttm"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="advising_bank_customer_reference">
					<additional_field name="advising_bank_customer_reference" type="string" scope="master">
						<xsl:value-of select="advising_bank_customer_reference"/>
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
				<xsl:if test="proactive_amd">
					<additional_field name = "proactive_amd" type ="string" scope="none" description ="Pro active flag to be set by TI">
						<xsl:value-of select="proactive_amd"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="lc_govern_country">
					<lc_govern_country>
						<xsl:value-of select="lc_govern_country"/>
					</lc_govern_country>
				</xsl:if>
				<xsl:if test="lc_govern_text">
					<lc_govern_text>
						<xsl:value-of select="lc_govern_text"/>
					</lc_govern_text>
				</xsl:if>
				<xsl:if test="delv_org">
					<delv_org>
						<xsl:value-of select="delv_org"/>
					</delv_org>
				</xsl:if>
				<xsl:if test="delv_org_text">
					<delv_org_text>
						<xsl:value-of select="delv_org_text"/>
					</delv_org_text>
				</xsl:if>
				<xsl:if test="delivery_to">
					<delivery_to>
						<xsl:value-of select="delivery_to"/>
					</delivery_to>
				</xsl:if>
				<xsl:if test="lc_exp_date_type_code">
					<lc_exp_date_type_code>
						<xsl:value-of select="lc_exp_date_type_code"/>
					</lc_exp_date_type_code>
				</xsl:if>
				<xsl:if test="exp_event">
					<exp_event>
						<xsl:value-of select="exp_event"/>
					</exp_event>
				</xsl:if>
				<xsl:if test="demand_indicator">
					<demand_indicator>
						<xsl:value-of select="demand_indicator"/>
					</demand_indicator>
				</xsl:if>
				<xsl:if test="purpose">
					<purpose>
						<xsl:value-of select="purpose"/>
					</purpose>
				</xsl:if>
				<xsl:if test="not(additional_field[@name='credit_available_with_bank_type'])">
				<xsl:choose>
				<xsl:when test="$creditType='advising bank' or $creditType=localization:getGTPString('en', 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ADVISING_BANK') or $creditType='any bank' or $creditType=localization:getGTPString('en', 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ANY_BANK') or $creditType='issuing bank' or $creditType=localization:getGTPString('en', 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ISSUING_BANK')">
	      		<additional_field name = "credit_available_with_bank_type" type ="string" scope="master">
					<xsl:value-of select="credit_available_with_bank/name"/>
				</additional_field>
				</xsl:when>
				<xsl:otherwise>
				<additional_field name = "credit_available_with_bank_type" type ="string" scope="master">
					 <xsl:value-of select="localization:getGTPString('en', 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_OTHER')"/>
				</additional_field>
				</xsl:otherwise>
				</xsl:choose>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_type">
						<additional_field name="credit_available_with_bank_type"
					type="string" scope="master">
							<xsl:value-of select="credit_available_with_bank_type"/>
						</additional_field>
				</xsl:if>				
				<xsl:apply-templates select="additional_field"/>
				
			</com.misys.portal.product.el.common.ExportLetterOfCredit>
			
			<!-- Banks -->
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="issuing_bank"/>
				<xsl:with-param name="role_code">01</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
				
			<com.misys.portal.product.common.Bank role_code="02">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="brch_code"/></brch_code>
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<abbv_name><xsl:value-of select="$main_bank_abbv_name"/></abbv_name>
				<xsl:if test="advising_bank/name"><name><xsl:value-of select="advising_bank/name"/></name></xsl:if>
				<xsl:if test="$main_bank_name and not(advising_bank/name)"><name><xsl:value-of select="$main_bank_name"/></name></xsl:if>
				<xsl:if test="advising_bank/address_line_1"><address_line_1><xsl:value-of select="advising_bank/address_line_1"/></address_line_1></xsl:if>
				<xsl:if test="advising_bank/address_line_2"><address_line_2><xsl:value-of select="advising_bank/address_line_2"/></address_line_2></xsl:if>
				<xsl:if test="advising_bank/dom"><dom><xsl:value-of select="advising_bank/dom"/></dom></xsl:if>
				<xsl:if test="advising_bank/iso_code"><iso_code><xsl:value-of select="advising_bank/iso_code"/></iso_code></xsl:if>
				<xsl:if test="advising_bank/reference"><reference><xsl:value-of select="advising_bank/reference"/></reference></xsl:if>
			</com.misys.portal.product.common.Bank>
			
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="advise_thru_bank"/>
				<xsl:with-param name="role_code">03</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:choose>
			<xsl:when test="$creditType='advising bank' or $creditType=localization:getGTPString('en', 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ADVISING_BANK')">
			<com.misys.portal.product.common.Bank role_code="04">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="brch_code"/></brch_code>
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<abbv_name><xsl:value-of select="$main_bank_abbv_name"/></abbv_name>
				<xsl:if test="advising_bank/name"><name><xsl:value-of select="advising_bank/name"/></name></xsl:if>
				<xsl:if test="$main_bank_name and not(advising_bank/name)"><name><xsl:value-of select="$main_bank_name"/></name></xsl:if>
				<xsl:if test="advising_bank/address_line_1"><address_line_1><xsl:value-of select="advising_bank/address_line_1"/></address_line_1></xsl:if>
				<xsl:if test="advising_bank/address_line_2"><address_line_2><xsl:value-of select="advising_bank/address_line_2"/></address_line_2></xsl:if>
				<xsl:if test="advising_bank/dom"><dom><xsl:value-of select="advising_bank/dom"/></dom></xsl:if>
				<xsl:if test="advising_bank/address_line_4"><address_line_4><xsl:value-of select="advising_bank/address_line_4"/></address_line_4></xsl:if>
				<xsl:if test="advising_bank/iso_code"><iso_code><xsl:value-of select="advising_bank/iso_code"/></iso_code></xsl:if>
				<xsl:if test="advising_bank/reference"><reference><xsl:value-of select="advising_bank/reference"/></reference></xsl:if>
			</com.misys.portal.product.common.Bank>
			</xsl:when>
			<xsl:when test="$creditType='issuing bank' or $creditType=localization:getGTPString('en', 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ISSUING_BANK')">
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="issuing_bank"/>
				<xsl:with-param name="role_code">04</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="credit_available_with_bank"/>
				<xsl:with-param name="role_code">04</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			</xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="drawee_details_bank"/>
				<xsl:with-param name="role_code">05</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="requested_confirmation_party"/>
				<xsl:with-param name="role_code">17</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="first_advising_bank"/>
				<xsl:with-param name="role_code">18</xsl:with-param>
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
				<xsl:with-param name="narrative" select="narrative_documents_required"/>
				<xsl:with-param name="type_code">02</xsl:with-param>
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
				<xsl:with-param name="narrative" select="narrative_charges"/>
				<xsl:with-param name="type_code">04</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_additional_amount"/>
				<xsl:with-param name="type_code">05</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_payment_instructions"/>
				<xsl:with-param name="type_code">06</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_period_presentation"/>
				<xsl:with-param name="type_code">07</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_shipment_period"/>
				<xsl:with-param name="type_code">08</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_sender_to_receiver"/>
				<xsl:with-param name="type_code">09</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_full_details"/>
				<xsl:with-param name="type_code">10</xsl:with-param>
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
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_special_beneficiary"/>
				<xsl:with-param name="type_code">40</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_special_recvbank"/>
				<xsl:with-param name="type_code">41</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>		
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_amend_charges_other"/>
				<xsl:with-param name="type_code">42</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>	
			<!-- Create Charge element -->
			<xsl:apply-templates select="charges/charge">
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:apply-templates>
			
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
					<xsl:with-param name="ref_id" select="ref_id"/>
					<xsl:with-param name="tnx_id" select="tnx_id"/>
					<xsl:with-param name="company_id" select="company_id"/>
		 		</xsl:call-template>
			</xsl:for-each>

			<!-- Cross References -->
			<xsl:apply-templates select="cross_references/cross_reference">
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="product_code" select="product_code"/>
			</xsl:apply-templates>
			
			<!-- Create Document elements -->
			<xsl:apply-templates select="documents/document">
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:apply-templates>
			
			<!-- Linked Licenses -->
			<xsl:if test="linked_licenses">
				<xsl:apply-templates select="linked_licenses/license">
					<xsl:with-param name="ref_id" select="$ref_id"/>
					<xsl:with-param name="tnx_id" select="$tnx_id"/>
					<xsl:with-param name="company_id" select="$company_id"/>
					<xsl:with-param name="main_bank_name" select="//advising_bank/abbv_name"/>
				</xsl:apply-templates>
			</xsl:if>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_transfer_conditions"/>
				<xsl:with-param name="type_code">48</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_delivery_to"/>
				<xsl:with-param name="type_code">62</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
		</result>
	</xsl:template>
			
</xsl:stylesheet>
