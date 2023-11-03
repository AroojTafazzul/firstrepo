<?xml version="1.0"?>
<!--
  		Copyright (c) 2000-2008 Misys (http://www.misys.com)
  		All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
				xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
					xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="service utils">
			
	<!-- Process Letter of Credit and Issued Stand By-->
	<xsl:template match="lc_tnx_record | si_tnx_record">
<!-- Retrieve references from DB -->
		<!-- Declare variable at top-level to make them visible from any templates -->
		<xsl:variable name="references" select="service:manageTradeReferences(//product_code, //ref_id, //tnx_id, //bo_ref_id, //bo_tnx_id, //cust_ref_id, //company_id, //company_name, //applicant_reference, //issuing_bank/abbv_name, '01', //prod_stat_code, //tnx_type_code)"/>	
		
		<xsl:variable name="ref_id" select="$references/references/ref_id"/>
		<xsl:variable name="tnx_id" select="$references/references/tnx_id"/>
		<xsl:variable name="sub_prod_code" select="$references/references/sub_prod_code"/>
		<xsl:variable name="company_id" select="$references/references/company_id"/>
		<xsl:variable name="company_name" select="$references/references/company_name"/>
		<xsl:variable name="entity" select="$references/references/entity"/>
		<xsl:variable name="main_bank_abbv_name" select="$references/references/main_bank_abbv_name"/>
		<xsl:variable name="main_bank_name" select="$references/references/main_bank_name"/>
		<xsl:variable name="customer_bank_reference" select="$references/references/customer_bank_reference"/>
		<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
     	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" /> 
		<xsl:variable name="creditType" select="translate(credit_available_with_bank/name,$uppercase,$smallcase)"/>
		<xsl:variable name="draweeType" select="translate(drawee_details_bank/name,$uppercase,$smallcase)"/>
		<result>
			<com.misys.portal.product.lc.common.LetterOfCredit>
				<xsl:variable name="parent_ref_id" select="service:retrieveRefIdFromBoRefId(//parent_bo_ref_id, 'EL')"/>
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>
				<company_id>
					<xsl:value-of select="$company_id"/>
				</company_id>
				<xsl:if test="entity">
					<entity><xsl:value-of select= "service:validateEntityFromCompanyName(//company_name,//entity )"/></entity>
				</xsl:if>
				<xsl:if test="$entity!='' and not(entity)">
					<entity><xsl:value-of select="$entity"/></entity>
				</xsl:if>
				<company_name>
					<xsl:value-of select="$company_name"/>
				</company_name>
				<xsl:if test="product_code">
					<product_code>
						<xsl:value-of select="product_code"/>
					</product_code>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="sub_product_code">
						<sub_product_code>
							<xsl:value-of select="sub_product_code"/>
						</sub_product_code>
					</xsl:when>
					<xsl:when test="$sub_prod_code!=''">
						<sub_product_code>
							<xsl:value-of select="$sub_prod_code"/>
						</sub_product_code>
					</xsl:when>
					<xsl:when test="product_code[.='LC']">
						<sub_product_code>LCSTD</sub_product_code>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="sub_product_code">
					<sub_product_code>
						<xsl:value-of select="sub_product_code"/>
					</sub_product_code>
				</xsl:if>
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>
				<xsl:if test="related_ref_id">
					<related_ref_id>
						<xsl:value-of select="related_ref_id"/>
					</related_ref_id>
				</xsl:if>	
				<xsl:if test="latest_answer_date">
					<latest_answer_date>
						<xsl:value-of select="latest_answer_date"/>
					</latest_answer_date>
				</xsl:if>
				<xsl:if test="fwd_contract_no">
					<fwd_contract_no>
						<xsl:value-of select="fwd_contract_no"/>
					</fwd_contract_no>
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
				<xsl:if test="exp_date">
					<exp_date>
						<xsl:value-of select="exp_date"/>
					</exp_date>
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
				<xsl:if test="proactive_amd">
					<additional_field name = "proactive_amd" type ="string" scope="none" description ="Pro active flag to be set by TI">
						<xsl:value-of select="proactive_amd"/>
					</additional_field>
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
				<xsl:if test="tnx_amt">
					<tnx_amt>
						<xsl:value-of select="tnx_amt"/>
					</tnx_amt>
				</xsl:if>
				<xsl:if test="lc_cur_code">
					<lc_cur_code>
						<xsl:value-of select="lc_cur_code"/>
					</lc_cur_code>
				</xsl:if>
				<xsl:if test="lc_amt">
					<lc_amt>
						<xsl:value-of select="lc_amt"/>
					</lc_amt>
				</xsl:if>
				<xsl:if test="lc_liab_amt">
					<lc_liab_amt>
						<xsl:value-of select="lc_liab_amt"/>
					</lc_liab_amt>
				</xsl:if>
				<xsl:if test="release_amt">
					<release_amt>
						<xsl:value-of select="release_amt"/>
					</release_amt>
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
				<!-- Value may be split into 2 fields -->
				<xsl:if test="part_ship_detl">
					<part_ship_detl>
						<xsl:choose>
                  	<xsl:when test="part_ship_detl_text [. != '']">
								<xsl:value-of select="part_ship_detl_text"/>
                  	</xsl:when>
                  	<xsl:otherwise>
								<xsl:value-of select="translate(part_ship_detl, $smallcase, $uppercase)"/>
                  	</xsl:otherwise>
                  </xsl:choose>
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
				<!-- Values may be split into 2 fields -->
				<xsl:if test="tran_ship_detl">
					<tran_ship_detl>
						<xsl:choose>
                  	<xsl:when test="tran_ship_detl_text [. != '']">
								<xsl:value-of select="tran_ship_detl_text"/>
                  	</xsl:when>
                  	<xsl:otherwise>
								<xsl:value-of select="translate(tran_ship_detl, $smallcase, $uppercase)"/>
                  	</xsl:otherwise>
                  </xsl:choose>
					</tran_ship_detl>
				</xsl:if>
				<xsl:if test="cty_of_dest">
					<cty_of_dest>
						<xsl:value-of select="cty_of_dest"/>
					</cty_of_dest>
				</xsl:if>
				<xsl:if test="rvlv_lc_type_code">
					<rvlv_lc_type_code>
						<xsl:value-of select="rvlv_lc_type_code"/>
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
				<xsl:if test="req_conf_party_flag">
					<req_conf_party_flag>
						<xsl:value-of select="req_conf_party_flag"/>
					</req_conf_party_flag>
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
				<xsl:if test="beneficiary_country">
					<beneficiary_country>
						<xsl:value-of select="beneficiary_country"/>
					</beneficiary_country>
				</xsl:if>
				<xsl:if test="beneficiary_reference">
					<beneficiary_reference>
						<xsl:value-of select="beneficiary_reference"/>
					</beneficiary_reference>
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
				<xsl:if test="applicant_country">
					<applicant_country>
						<xsl:value-of select="applicant_country"/>
					</applicant_country>
				</xsl:if>
				<xsl:if test="applicant_reference">
					<applicant_reference>
						<xsl:value-of select="$customer_bank_reference"/>
					</applicant_reference>
				</xsl:if>
				<xsl:if test="claim_cur_code">
					<claim_cur_code>
						<xsl:value-of select="claim_cur_code"/>
					</claim_cur_code>
				</xsl:if>
				<xsl:if test="claim_amt">
					<claim_amt>
						<xsl:value-of select="claim_amt"/>
					</claim_amt>
				</xsl:if>
				<xsl:if test="claim_reference">
					<claim_reference>
						<xsl:value-of select="claim_reference"/>
					</claim_reference>
				</xsl:if>
				<xsl:if test="claim_present_date">
					<claim_present_date>
						<xsl:value-of select="claim_present_date"/>
					</claim_present_date>
				</xsl:if>
				<xsl:if test="linked_event_reference">
					<linked_event_reference>
						<xsl:value-of select="linked_event_reference"/>
					</linked_event_reference>
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
				<xsl:if test="draft_term">
					<draft_term>
						<xsl:value-of select="draft_term"/>
					</draft_term>
				</xsl:if>
				<xsl:if test="cust_ref_id">
					<cust_ref_id>
					<xsl:choose>
						<xsl:when test="defaultresource:getResource('UNIQUE_CUSTREFID_MT798') = 'false'">
							<xsl:value-of select="cust_ref_id"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select= "service:validateCustRefID(//company_name,//product_code,//sub_product_code,//cust_ref_id,//tnx_type_code)"/>
						</xsl:otherwise>
					</xsl:choose>
					</cust_ref_id>
				</xsl:if>
				<xsl:if test="bo_ref_id">
					<bo_ref_id>
						<xsl:value-of select="bo_ref_id"/>
					</bo_ref_id>
				</xsl:if>
				<xsl:if test="doc_ref_no">
					<doc_ref_no>
						<xsl:value-of select="doc_ref_no"/>
					</doc_ref_no>
				</xsl:if>
				<xsl:if test="maturity_date">
					<maturity_date>
						<xsl:value-of select="maturity_date"/>
					</maturity_date>
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
				<xsl:if test="action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code"/>
					</action_req_code>
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
				<xsl:if test="debit_amt">
					<debit_amt>
						<xsl:value-of select="debit_amt"/>
					</debit_amt>
				</xsl:if>
				<xsl:if test="transport_mode">
					<transport_mode>
						<xsl:value-of select="transport_mode"/>
					</transport_mode>
				</xsl:if>
				<xsl:if test="delivery_channel">
					<delivery_channel>
						<xsl:value-of select="delivery_channel"/>
					</delivery_channel>
				</xsl:if>	
				
				<!-- Revolving LC Details : START -->
				<xsl:if test="revolving_flag">
					<revolving_flag>
						<xsl:value-of select="revolving_flag"/>
					</revolving_flag>
				</xsl:if>	
				<xsl:if test="revolve_period">
					<revolve_period>
						<xsl:value-of select="revolve_period"/>
					</revolve_period>
				</xsl:if>	
				<xsl:if test="revolve_frequency">
					<revolve_frequency>
						<xsl:value-of select="revolve_frequency"/>
					</revolve_frequency>
				</xsl:if>	
				<xsl:if test="revolve_time_no">
					<revolve_time_no>
						<xsl:value-of select="revolve_time_no"/>
					</revolve_time_no>
				</xsl:if>	
				<xsl:if test="cumulative_flag">
					<cumulative_flag>
						<xsl:value-of select="cumulative_flag"/>
					</cumulative_flag>
				</xsl:if>	
				<xsl:if test="next_revolve_date">
					<next_revolve_date>
						<xsl:value-of select="next_revolve_date"/>
					</next_revolve_date>
				</xsl:if>	
				<xsl:if test="notice_days">
					<notice_days>
						<xsl:value-of select="notice_days"/>
					</notice_days>
				</xsl:if>	
				<xsl:if test="charge_upto">
					<charge_upto>
						<xsl:value-of select="charge_upto"/>
					</charge_upto>
				</xsl:if>	
				<!-- Revolving LC Details : END -->			
				
				<xsl:if test="provisional_status">
					<provisional_status>
						<xsl:value-of select="provisional_status"/>
					</provisional_status>
				</xsl:if>
				
				<!-- Alternate Party Details -->
				<xsl:if test="alt_applicant_name">
					<alt_applicant_name>
						<xsl:value-of select="alt_applicant_name"/>
					</alt_applicant_name>
				</xsl:if>
				<xsl:if test="alt_applicant_address_line_1">
					<alt_applicant_address_line_1>
						<xsl:value-of select="alt_applicant_address_line_1"/>
					</alt_applicant_address_line_1>
				</xsl:if>
				<xsl:if test="alt_applicant_address_line_2">
					<alt_applicant_address_line_2>
						<xsl:value-of select="alt_applicant_address_line_2"/>
					</alt_applicant_address_line_2>
				</xsl:if>
				<xsl:if test="alt_applicant_address_line_4">
					<alt_applicant_address_line_4>
						<xsl:value-of select="alt_applicant_address_line_4"/>
					</alt_applicant_address_line_4>
				</xsl:if>
				<xsl:if test="alt_applicant_dom">
					<alt_applicant_dom>
						<xsl:value-of select="alt_applicant_dom"/>
					</alt_applicant_dom>
				</xsl:if>
				<xsl:if test="alt_applicant_country">
					<alt_applicant_country>
						<xsl:value-of select="alt_applicant_country"/>
					</alt_applicant_country>
				</xsl:if>
				<xsl:if test="for_account_flag">
					<for_account_flag>
						<xsl:value-of select="for_account_flag"/>
					</for_account_flag>
				</xsl:if>
				<xsl:if test="period_presentation_days">
					<period_presentation_days>
						<xsl:value-of select="period_presentation_days"/>
					</period_presentation_days>
				</xsl:if>
				<xsl:if test="alt_applicant_cust_ref">
					<alt_applicant_cust_ref>
						<xsl:value-of select="alt_applicant_cust_ref"/>
					</alt_applicant_cust_ref>
				</xsl:if>
				<!-- Added for TI integration -->
				<xsl:if test="tenor_type">
					<tenor_type>
						<xsl:value-of select="tenor_type"/>
					</tenor_type>
				</xsl:if>
				<xsl:if test="tenor_maturity_date">
					<tenor_maturity_date>
						<xsl:value-of select="tenor_maturity_date"/>
					</tenor_maturity_date>
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
				<xsl:if test="product_type_code">
					<product_type_code>
						<xsl:value-of select="product_type_code"/>
					</product_type_code>
				</xsl:if>
				<xsl:if test="product_type_details">
					<product_type_details>
						<xsl:value-of select="product_type_details"/>
					</product_type_details>
				</xsl:if>
				<!-- Standby LC Rules Applicable code -->
				<xsl:if test="standby_rule_code">
					<standby_rule_code>
						<xsl:value-of select="standby_rule_code"/>
					</standby_rule_code>
				</xsl:if>
				<xsl:if test="standby_rule_other">
					<standby_rule_other>
						<xsl:value-of select="standby_rule_other"/>
					</standby_rule_other>
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
				<xsl:if test="$parent_ref_id != ''">
					<additional_field name="parent_ref_id" type="string" scope="master" description="Ref id of parent SR or EL">
						<xsl:value-of select="$parent_ref_id"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="parent_bo_ref_id">
					<additional_field name="parent_bo_ref_id" type="string" scope="master" description="BO ref id of parent SR or EL">
						<xsl:value-of select="parent_bo_ref_id"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="advising_bank_lc_ref_id">
					<advising_bank_lc_ref_id>
						<xsl:value-of select="advising_bank_lc_ref_id"/>
					</advising_bank_lc_ref_id>
				</xsl:if>
				
				<xsl:if test="cfm_chrg_applicant">
					<cfm_chrg_applicant>
						<xsl:value-of select="cfm_chrg_applicant"/>
					</cfm_chrg_applicant>
				</xsl:if>
				<xsl:if test="cfm_chrg_beneficiary">
					<cfm_chrg_beneficiary>
						<xsl:value-of select="cfm_chrg_beneficiary"/>
					</cfm_chrg_beneficiary>
				</xsl:if>
				<xsl:if test="corr_chrg_applicant">
					<corr_chrg_applicant>
						<xsl:value-of select="corr_chrg_applicant"/>
					</corr_chrg_applicant>
				</xsl:if>
				<xsl:if test="corr_chrg_beneficiary">
					<corr_chrg_beneficiary>
						<xsl:value-of select="corr_chrg_beneficiary"/>
					</corr_chrg_beneficiary>
				</xsl:if>
				<xsl:if test="open_chrg_applicant">
					<open_chrg_applicant>
						<xsl:value-of select="open_chrg_applicant"/>
					</open_chrg_applicant>
				</xsl:if>
				<xsl:if test="open_chrg_beneficiary">
					<open_chrg_beneficiary>
						<xsl:value-of select="open_chrg_beneficiary"/>
					</open_chrg_beneficiary>
				</xsl:if>
				<xsl:if test="cancellation_req_flag">
					<cancellation_req_flag>
						<xsl:value-of select="cancellation_req_flag"/>
					</cancellation_req_flag>
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
				<xsl:if test="purpose">
					<purpose>
						<xsl:value-of select="purpose"/>
					</purpose>
				</xsl:if>
				<xsl:if test="demand_indicator">
					<demand_indicator>
						<xsl:value-of select="demand_indicator"/>
					</demand_indicator>
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
				
			</com.misys.portal.product.lc.common.LetterOfCredit>
			
			<!-- Banks -->
			<com.misys.portal.product.common.Bank role_code="01">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="brch_code"/></brch_code>
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<abbv_name><xsl:value-of select="$main_bank_abbv_name"/></abbv_name>
				<xsl:if test="issuing_bank/name"><name><xsl:value-of select="issuing_bank/name"/></name></xsl:if>
				<xsl:if test="$main_bank_name and not(issuing_bank/name)"><name><xsl:value-of select="$main_bank_name"/></name></xsl:if>
				<xsl:if test="issuing_bank/address_line_1"><address_line_1><xsl:value-of select="issuing_bank/address_line_1"/></address_line_1></xsl:if>
				<xsl:if test="issuing_bank/address_line_2"><address_line_2><xsl:value-of select="issuing_bank/address_line_2"/></address_line_2></xsl:if>
				<xsl:if test="issuing_bank/dom"><dom><xsl:value-of select="issuing_bank/dom"/></dom></xsl:if>
				<xsl:if test="issuing_bank/iso_code"><iso_code><xsl:value-of select="issuing_bank/iso_code"/></iso_code></xsl:if>
				<xsl:if test="issuing_bank/reference"><reference><xsl:value-of select="issuing_bank/reference"/></reference></xsl:if>
			</com.misys.portal.product.common.Bank>
						
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="advising_bank"/>
				<xsl:with-param name="role_code">02</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="advise_thru_bank"/>
				<xsl:with-param name="role_code">03</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:choose>
			<xsl:when test="$creditType='issuing bank' or $creditType=localization:getGTPString('en', 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ISSUING_BANK')">
			<com.misys.portal.product.common.Bank role_code="04">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="brch_code"/></brch_code>
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<abbv_name><xsl:value-of select="$main_bank_abbv_name"/></abbv_name>
				<xsl:if test="issuing_bank/name"><name><xsl:value-of select="issuing_bank/name"/></name></xsl:if>
				<xsl:if test="$main_bank_name and not(issuing_bank/name)"><name><xsl:value-of select="$main_bank_name"/></name></xsl:if>
				<xsl:if test="issuing_bank/address_line_1"><address_line_1><xsl:value-of select="issuing_bank/address_line_1"/></address_line_1></xsl:if>
				<xsl:if test="issuing_bank/address_line_2"><address_line_2><xsl:value-of select="issuing_bank/address_line_2"/></address_line_2></xsl:if>
				<xsl:if test="issuing_bank/dom"><dom><xsl:value-of select="issuing_bank/dom"/></dom></xsl:if>
				<xsl:if test="issuing_bank/iso_code"><iso_code><xsl:value-of select="issuing_bank/iso_code"/></iso_code></xsl:if>
				<xsl:if test="issuing_bank/reference"><reference><xsl:value-of select="issuing_bank/reference"/></reference></xsl:if>
			</com.misys.portal.product.common.Bank>
			</xsl:when>
			<xsl:when test="$creditType='advising bank' or $creditType=localization:getGTPString('en', 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ADVISING_BANK')">
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="advising_bank"/>
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
			<xsl:choose>
				<xsl:when test="$draweeType = 'issuing bank'">
					<xsl:call-template name="bank_with_type">
						<xsl:with-param name="bank" select="drawee_details_bank"/>
						<xsl:with-param name="role_code">05</xsl:with-param>
						<xsl:with-param name="type">01</xsl:with-param>
						<xsl:with-param name="ref_id" select="$ref_id"/>
						<xsl:with-param name="tnx_id" select="$tnx_id"/>
						<xsl:with-param name="company_id" select="$company_id"/>
					</xsl:call-template>
	            </xsl:when>
	            <xsl:when test="$draweeType = 'advising bank'">
					<xsl:call-template name="bank_with_type">
						<xsl:with-param name="bank" select="drawee_details_bank"/>
						<xsl:with-param name="role_code">05</xsl:with-param>
						<xsl:with-param name="type">02</xsl:with-param>
						<xsl:with-param name="ref_id" select="$ref_id"/>
						<xsl:with-param name="tnx_id" select="$tnx_id"/>
						<xsl:with-param name="company_id" select="$company_id"/>
					</xsl:call-template>
	            </xsl:when>
	            <xsl:when test="$draweeType = 'any bank'">
					<xsl:call-template name="bank_with_type">
						<xsl:with-param name="bank" select="drawee_details_bank"/>
						<xsl:with-param name="role_code">05</xsl:with-param>
						<xsl:with-param name="type">03</xsl:with-param>
						<xsl:with-param name="ref_id" select="$ref_id"/>
						<xsl:with-param name="tnx_id" select="$tnx_id"/>
						<xsl:with-param name="company_id" select="$company_id"/>
					</xsl:call-template>
	            </xsl:when>
	            <xsl:when test="$draweeType = 'confirming bank'">
					<xsl:call-template name="bank_with_type">
						<xsl:with-param name="bank" select="drawee_details_bank"/>
						<xsl:with-param name="role_code">05</xsl:with-param>
						<xsl:with-param name="type">04</xsl:with-param>
						<xsl:with-param name="ref_id" select="$ref_id"/>
						<xsl:with-param name="tnx_id" select="$tnx_id"/>
						<xsl:with-param name="company_id" select="$company_id"/>
					</xsl:call-template>
	            </xsl:when>
	            <xsl:when test="$draweeType = 'negotiating bank'">
					<xsl:call-template name="bank_with_type">
						<xsl:with-param name="bank" select="drawee_details_bank"/>
						<xsl:with-param name="role_code">05</xsl:with-param>
						<xsl:with-param name="type">05</xsl:with-param>
						<xsl:with-param name="ref_id" select="$ref_id"/>
						<xsl:with-param name="tnx_id" select="$tnx_id"/>
						<xsl:with-param name="company_id" select="$company_id"/>
					</xsl:call-template>
	            </xsl:when>
	            <xsl:when test="$draweeType = 'reimbursing bank'">
					<xsl:call-template name="bank_with_type">
						<xsl:with-param name="bank" select="drawee_details_bank"/>
						<xsl:with-param name="role_code">05</xsl:with-param>
						<xsl:with-param name="type">06</xsl:with-param>
						<xsl:with-param name="ref_id" select="$ref_id"/>
						<xsl:with-param name="tnx_id" select="$tnx_id"/>
						<xsl:with-param name="company_id" select="$company_id"/>
					</xsl:call-template>
	            </xsl:when>
	            <xsl:when test="$draweeType = 'applicant'">
					<xsl:call-template name="bank_with_type">
						<xsl:with-param name="bank" select="drawee_details_bank"/>
						<xsl:with-param name="role_code">05</xsl:with-param>
						<xsl:with-param name="type">07</xsl:with-param>
						<xsl:with-param name="ref_id" select="$ref_id"/>
						<xsl:with-param name="tnx_id" select="$tnx_id"/>
						<xsl:with-param name="company_id" select="$company_id"/>
					</xsl:call-template>
	            </xsl:when>
	            <xsl:when test="$draweeType = 'advise thru bank'">
					<xsl:call-template name="bank_with_type">
						<xsl:with-param name="bank" select="drawee_details_bank"/>
						<xsl:with-param name="role_code">05</xsl:with-param>
						<xsl:with-param name="type">08</xsl:with-param>
						<xsl:with-param name="ref_id" select="$ref_id"/>
						<xsl:with-param name="tnx_id" select="$tnx_id"/>
						<xsl:with-param name="company_id" select="$company_id"/>
					</xsl:call-template>
	            </xsl:when>
	            <xsl:when test="$draweeType = 'other'">
					<xsl:call-template name="bank_with_type">
						<xsl:with-param name="bank" select="drawee_details_bank"/>
						<xsl:with-param name="role_code">05</xsl:with-param>
						<xsl:with-param name="type">99</xsl:with-param>
						<xsl:with-param name="ref_id" select="$ref_id"/>
						<xsl:with-param name="tnx_id" select="$tnx_id"/>
						<xsl:with-param name="company_id" select="$company_id"/>
					</xsl:call-template>
	            </xsl:when>
            </xsl:choose>            
			
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="advise_thru_bank"/>
				<xsl:with-param name="role_code">06</xsl:with-param>
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
				<xsl:with-param name="narrative" select="narrative_amend_charges_other"/>
				<xsl:with-param name="type_code">42</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			
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
			
			<!-- Create Charges elements -->
			<xsl:apply-templates select="charges/charge">
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:apply-templates>
			
			<!-- Create Attachment elements for attachments which are part of the incoming xml-->
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
			
			<!-- Following piece of code to retain the cross references if there are no referencs in the i\
				 incoming xml: Retrieve existing cross references and do the update on same -->
			<xsl:for-each select="$references/references/cross_references/cross_reference">
				<xsl:call-template name="cross_reference_details">
					<xsl:with-param name="cross_reference" select="."></xsl:with-param>
					<xsl:with-param name="ref_id" select="$ref_id"/>
					<xsl:with-param name="tnx_id" select="$tnx_id"/>
					<xsl:with-param name="company_id" select="$company_id"/>
		 		</xsl:call-template>
			</xsl:for-each>
			<!-- Cross References -->
			<xsl:apply-templates select="cross_references/cross_reference">
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="product_code" select="product_code"/>
			</xsl:apply-templates>
			<!-- Linked Licenses -->
			<xsl:if test="linked_licenses">
				<xsl:apply-templates select="linked_licenses/license">
					<xsl:with-param name="ref_id" select="$ref_id"/>
					<xsl:with-param name="tnx_id" select="$tnx_id"/>
					<xsl:with-param name="company_id" select="$company_id"/>
					<xsl:with-param name="main_bank_name" select="//issuing_bank/abbv_name"/>
				</xsl:apply-templates>
			</xsl:if>
		</result>
	</xsl:template>
	<xsl:template name="cross_reference_details">
		<xsl:param name="cross_reference"/>
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="company_id"/>
	
		<com.misys.portal.product.common.CrossReference>
			<xsl:if test="$cross_reference/cross_reference_id">
				<xsl:attribute name="cross_reference_id">
					<xsl:value-of select="$cross_reference/cross_reference_id"/>
				</xsl:attribute>
			</xsl:if>							
			<brch_code><xsl:value-of select="$cross_reference/brch_code"/></brch_code>
			<xsl:if test="$cross_reference/product_code">
				<product_code>
					<xsl:value-of select="$cross_reference/product_code"/>
				</product_code>
			</xsl:if>
			<xsl:if test="$cross_reference/ref_id">
				<ref_id>
					<xsl:value-of select="$cross_reference/ref_id"/>
				</ref_id>
			</xsl:if>
			<xsl:if test="$cross_reference/tnx_id">
				<tnx_id>
					<xsl:value-of select="$cross_reference/tnx_id"/>
				</tnx_id>
			</xsl:if>
			<xsl:if test="$cross_reference/child_product_code">
				<child_product_code>
					<xsl:value-of select="$cross_reference/child_product_code"/>
				</child_product_code>
			</xsl:if>
			<xsl:if test="$cross_reference/child_ref_id">
				<child_ref_id>
					<xsl:value-of select="$cross_reference/child_ref_id"/>
				</child_ref_id>
			</xsl:if>
			<xsl:if test="$cross_reference/child_tnx_id">
				<child_tnx_id>
					<xsl:value-of select="$cross_reference/child_tnx_id"/>
				</child_tnx_id>
			</xsl:if>
			<xsl:if test="$cross_reference/type_code">
				<type_code>
					<xsl:value-of select="$cross_reference/type_code"/>
				</type_code>
			</xsl:if>
		</com.misys.portal.product.common.CrossReference>
	</xsl:template>
	
	<xsl:template name="bank_with_type">
		<xsl:param name="bank"/>
		<xsl:param name="role_code"/>
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="company_id"/>
		<xsl:param name="type"/>
		
		<com.misys.portal.product.common.Bank>
			<xsl:attribute name="role_code"><xsl:value-of select="$role_code"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			<company_id><xsl:value-of select="$company_id"/></company_id>
			<xsl:if test="$bank/abbv_name"><abbv_name><xsl:value-of select="$bank/abbv_name"/></abbv_name></xsl:if>
			<xsl:if test="$bank/name"><name><xsl:value-of select="$bank/name"/></name></xsl:if>
			<xsl:if test="$bank/address_line_1"><address_line_1><xsl:value-of select="$bank/address_line_1"/></address_line_1></xsl:if>
			<xsl:if test="$bank/address_line_2"><address_line_2><xsl:value-of select="$bank/address_line_2"/></address_line_2></xsl:if>
			<xsl:if test="$bank/dom"><dom><xsl:value-of select="$bank/dom"/></dom></xsl:if>
			<xsl:if test="$bank/address_line_4"><address_line_4><xsl:value-of select="$bank/address_line_4"/></address_line_4></xsl:if>
			<xsl:if test="$bank/iso_code"><iso_code><xsl:value-of select="$bank/iso_code"/></iso_code></xsl:if>
			<xsl:if test="$bank/reference"><reference><xsl:value-of select="$bank/reference"/></reference></xsl:if>
			<xsl:if test="$type"><type><xsl:value-of select="$type"/></type></xsl:if>
		</com.misys.portal.product.common.Bank>		
	</xsl:template>
</xsl:stylesheet>
