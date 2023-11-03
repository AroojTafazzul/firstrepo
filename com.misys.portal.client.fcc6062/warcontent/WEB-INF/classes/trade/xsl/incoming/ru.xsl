<?xml version="1.0"?>
<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
				exclude-result-prefixes="localization service utils">

	<!-- Process BG-->
	<xsl:template match="br_tnx_record">
		
		<!-- Retrieve references from DB -->
		<!-- Declare variable at top-level to make them visible from any templates -->
		
		<xsl:variable name="valid_ref_id">
			<xsl:choose>
				<xsl:when test="utils:isStandbyRefId(//product_code, //ref_id)">
					<xsl:value-of select="service:retrieveRefIdFromBoRefId(//bo_ref_id, //product_code, //main_bank_abbv_name, '02')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="ref_id"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="references" select="service:manageTradeReferences(//product_code, $valid_ref_id, //tnx_id, //bo_ref_id, //bo_tnx_id, //cust_ref_id, //company_id, //company_name, //beneficiary_reference, //advising_bank/abbv_name, '02', //prod_stat_code, //tnx_type_code)"/>
	
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
			<com.misys.portal.product.ru.common.ReceivedUndertaking>
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>
				
				<xsl:attribute name="company_id">
					<xsl:value-of select="$company_id"/>
				</xsl:attribute>
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
				<product_code>BR</product_code>
				<xsl:if test="sub_product_code">
					<sub_product_code>
						<xsl:value-of select="sub_product_code"/>
					</sub_product_code>
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
				<xsl:if test="iss_date_type_code">
					<iss_date_type_code>
						<xsl:value-of select="iss_date_type_code"/>
					</iss_date_type_code>
				</xsl:if>
				<xsl:if test="iss_date_type_details">
					<iss_date_type_details>
						<xsl:value-of select="iss_date_type_details"/>
					</iss_date_type_details>
				</xsl:if>
				<xsl:if test="iss_date">
					<iss_date>
						<xsl:value-of select="iss_date"/>
					</iss_date>
				</xsl:if>
				<xsl:if test="exp_date_type_code">
					<exp_date_type_code>
						<xsl:value-of select="exp_date_type_code"/>
					</exp_date_type_code>
				</xsl:if>
				<xsl:if test="exp_date">
					<exp_date>
						<xsl:value-of select="exp_date"/>
					</exp_date>
				</xsl:if>
				<xsl:if test="exp_event">
					<exp_event>
						<xsl:value-of select="exp_event"/>
					</exp_event>
				</xsl:if>
				<xsl:if test="reduction_authorised">
					<reduction_authorised>
						<xsl:value-of select="reduction_authorised"/>
					</reduction_authorised>
				</xsl:if>
				<xsl:if test="reduction_clause">
					<reduction_clause>
						<xsl:value-of select="reduction_clause"/>
					</reduction_clause>
				</xsl:if>
				<xsl:if test="reduction_clause_other">
					<reduction_clause_other>
						<xsl:value-of select="reduction_clause_other"/>
					</reduction_clause_other>
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
				<xsl:if test="bg_cur_code">
					<bg_cur_code>
						<xsl:value-of select="bg_cur_code"/>
					</bg_cur_code>
				</xsl:if>
				<xsl:if test="bg_amt">
					<bg_amt>
						<xsl:value-of select="bg_amt"/>
					</bg_amt>
				</xsl:if>
				<xsl:if test="bg_liab_amt">
					<bg_liab_amt>
						<xsl:value-of select="bg_liab_amt"/>
					</bg_liab_amt>
				</xsl:if>
				<xsl:if test="bg_outstanding_amt">
					<bg_outstanding_amt>
						<xsl:value-of select="bg_outstanding_amt"/>
					</bg_outstanding_amt>
				</xsl:if>
				<!-- MPS-41651 BG Available amount -->
				<xsl:if test="bg_available_amt">
					<bg_available_amt>
						<xsl:value-of select="bg_available_amt" />
					</bg_available_amt>
				</xsl:if>
				<xsl:if test="bg_type_code">
					<bg_type_code>
						<xsl:value-of select="bg_type_code"/>
					</bg_type_code>
				</xsl:if>
				<xsl:if test="text_type_code">
					<text_type_code>
						<xsl:value-of select="text_type_code"/>
					</text_type_code>
				</xsl:if>
				<xsl:if test="bg_type_details">
					<bg_type_details>
						<xsl:value-of select="bg_type_details"/>
					</bg_type_details>
				</xsl:if>
				<xsl:if test="bg_rule">
					<bg_rule>
						<xsl:value-of select="bg_rule"/>
					</bg_rule>
				</xsl:if>
				<xsl:if test="bg_rule_other">
					<bg_rule_other>
						<xsl:value-of select="bg_rule_other"/>
					</bg_rule_other>
				</xsl:if>
				<xsl:if test="bg_text_type_code">
					<bg_text_type_code>
						<xsl:value-of select="bg_text_type_code"/>
					</bg_text_type_code>
				</xsl:if>
				<xsl:if test="bg_text_type_details">
					<bg_text_type_details>
						<xsl:value-of select="bg_text_type_details"/>
					</bg_text_type_details>
				</xsl:if>
				<xsl:if test="bg_release_flag">
					<bg_release_flag>
						<xsl:value-of select="bg_release_flag"/>
					</bg_release_flag>
				</xsl:if>
				<!-- Renewal details added  START -->
				<xsl:if test="renew_flag">
					<renew_flag>
						<xsl:value-of select="renew_flag"/>
					</renew_flag>
				</xsl:if>
				<xsl:if test="renewal_type">
					<renewal_type>
						<xsl:value-of select="renewal_type"/>
					</renewal_type>
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
				<xsl:if test="rolling_renewal_nb">
					<rolling_renewal_nb>
						<xsl:value-of select="rolling_renewal_nb"/>
					</rolling_renewal_nb>
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
				<xsl:if test="final_expiry_date">
					<final_expiry_date>
						<xsl:value-of select="final_expiry_date"/>
					</final_expiry_date>
				</xsl:if>
				<xsl:if test="projected_expiry_date">
					<projected_expiry_date>
						<xsl:value-of select="projected_expiry_date"/>
					</projected_expiry_date>
				</xsl:if> 
				<xsl:if test="rolling_day_in_month">
					<rolling_day_in_month>
						<xsl:value-of select="rolling_day_in_month"/>
					</rolling_day_in_month>
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
				<!-- Renewal details added  END -->
				
				
				
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
				<xsl:if test="ntrf_flag">
					<ntrf_flag>
						<xsl:value-of select="ntrf_flag"/>
					</ntrf_flag>
				</xsl:if>
				<xsl:if test="cfm_inst_code">
					<cfm_inst_code>
						<xsl:value-of select="cfm_inst_code"/>
					</cfm_inst_code>
				</xsl:if>
				<xsl:if test="bg_demand_indicator">
					<bg_demand_indicator>
						<xsl:value-of select="bg_demand_indicator"/>
					</bg_demand_indicator>
				</xsl:if>
				<xsl:if test="bg_govern_country">
					<bg_govern_country>
						<xsl:value-of select="bg_govern_country"/>
					</bg_govern_country>
				</xsl:if>
				<xsl:if test="bg_govern_text">
					<bg_govern_text>
						<xsl:value-of select="bg_govern_text"/>
					</bg_govern_text>
				</xsl:if>
				<xsl:if test="tolerance_positive_pct">
					<tolerance_positive_pct>
						<xsl:value-of select="tolerance_positive_pct"/>
					</tolerance_positive_pct>
				</xsl:if>
				<xsl:if test="tolerance_negative_pct">
					<tolerance_negative_pct>
						<xsl:value-of select="tolerance_negative_pct"/>
					</tolerance_negative_pct>
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
				<xsl:if test="beneficiary_country">
					<beneficiary_country>
						<xsl:value-of select="beneficiary_country"/>
					</beneficiary_country>
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
				<xsl:if test="related_ref">
					<related_ref>
						<xsl:value-of select="related_ref"/>
					</related_ref>
				</xsl:if>
				<xsl:if test="for_account">
					<for_account>
						<xsl:value-of select="for_account"/>
					</for_account>
				</xsl:if>
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
				<xsl:if test="issuing_bank_type_code">
					<issuing_bank_type_code>
						<xsl:value-of select="issuing_bank_type_code"/>
					</issuing_bank_type_code>
				</xsl:if>
				<xsl:if test="adv_send_mode">
					<adv_send_mode>
						<xsl:value-of select="adv_send_mode"/>
					</adv_send_mode>
				</xsl:if>
				<xsl:if test="contract_ref">
					<contract_ref>
						<xsl:value-of select="contract_ref"/>
					</contract_ref>
				</xsl:if>
				<xsl:if test="contract_narrative">
					<contract_narrative>
						<xsl:value-of select="contract_narrative"/>
					</contract_narrative>
				</xsl:if>
				<xsl:if test="tender_expiry_date">
					<tender_expiry_date>
						<xsl:value-of select="tender_expiry_date"/>
					</tender_expiry_date>
				</xsl:if>
				<xsl:if test="contract_date">
					<contract_date>
						<xsl:value-of select="contract_date"/>
					</contract_date>
				</xsl:if>
				<xsl:if test="contract_amt">
					<contract_amt>
						<xsl:value-of select="contract_amt"/>
					</contract_amt>
				</xsl:if>
				<xsl:if test="contract_cur_code">
					<contract_cur_code>
						<xsl:value-of select="contract_cur_code"/>
					</contract_cur_code>
				</xsl:if>
				<xsl:if test="contract_pct">
					<contract_pct>
						<xsl:value-of select="contract_pct"/>
					</contract_pct>
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
				<xsl:if test="maturity_date">
					<maturity_date>
						<xsl:value-of select="maturity_date"/>
					</maturity_date>
				</xsl:if>
				<xsl:if test="latest_response_date">
					<latest_response_date>
						<xsl:value-of select="latest_response_date"/>
					</latest_response_date>
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
				<xsl:if test="text_language">
					<text_language>
						<xsl:value-of select="text_language"/>
					</text_language>
				</xsl:if>
				<xsl:if test="text_language_other">
					<text_language_other>
						<xsl:value-of select="text_language_other"/>
					</text_language_other>
				</xsl:if>
				<xsl:if test="action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code"/>
					</action_req_code>
				</xsl:if>
				<xsl:if test="bg_code">
					<bg_code>
						<xsl:value-of select="bg_code"/>
					</bg_code>
				</xsl:if>
				<xsl:if test="bg_text_details_code">
					<bg_text_details_code>
						<xsl:value-of select="bg_text_details_code"/>
					</bg_text_details_code>
				</xsl:if>
				<xsl:if test="adv_bank_conf_req">
					<adv_bank_conf_req>
						<xsl:value-of select="adv_bank_conf_req"/>
					</adv_bank_conf_req>
				</xsl:if>
				<xsl:if test="character_commitment">
					<character_commitment>
						<xsl:value-of select="character_commitment"/>
					</character_commitment>
				</xsl:if>
				<xsl:if test="delivery_to">
					<delivery_to>
						<xsl:value-of select="delivery_to"/>
					</delivery_to>
				</xsl:if>
				<xsl:if test="delivery_to_other">
					<delivery_to_other>
						<xsl:value-of select="delivery_to_other"/>
					</delivery_to_other>
				</xsl:if>
				<xsl:if test="consortium">
					<consortium>
						<xsl:value-of select="consortium"/>
					</consortium>
				</xsl:if>
				<xsl:if test="consortium_details">
					<consortium_details>
						<xsl:value-of select="consortium_details"/>
					</consortium_details>
				</xsl:if>
				<xsl:if test="cr_avl_by_code">
					<cr_avl_by_code>
						<xsl:value-of select="cr_avl_by_code"/>
					</cr_avl_by_code>
				</xsl:if>

				<!-- Shipment Details START-->
				<xsl:if test="ship_from">
					<ship_from>
						<xsl:value-of select="ship_from"/>
					</ship_from>
				</xsl:if>
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
				<xsl:if test="ship_to">
					<ship_to>
						<xsl:value-of select="ship_to"/>
					</ship_to>
				</xsl:if>
				<xsl:if test="part_ship_detl">
					<part_ship_detl>
						<xsl:value-of select="part_ship_detl"/>
					</part_ship_detl>
				</xsl:if>
				<xsl:if test="tran_ship_detl">
					<tran_ship_detl>
						<xsl:value-of select="tran_ship_detl"/>
					</tran_ship_detl>
				</xsl:if>
				<xsl:if test="last_ship_date">
					<last_ship_date>
						<xsl:value-of select="last_ship_date"/>
					</last_ship_date>
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
				<!-- Shipment Details END-->

				<xsl:if test="guarantee_type_name">
					<guarantee_type_name>
						<xsl:value-of select="guarantee_type_name"/>
					</guarantee_type_name>
				</xsl:if>
				<xsl:if test="guarantee_type_company_id">
					<guarantee_type_company_id>
						<xsl:value-of select="guarantee_type_company_id"/>
					</guarantee_type_company_id>
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
				
				<xsl:if test="subject">
					<additional_field name="subject" type="string" scope="transaction" description="subject">
						<xsl:value-of select="subject"/>
			         </additional_field>
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
				<xsl:if test="purpose">
					<purpose>
						<xsl:value-of select="purpose"/>
					</purpose>
				</xsl:if>
				<xsl:if test="additional_cust_ref">
					<additional_cust_ref>
						<xsl:value-of select="additional_cust_ref"/>
					</additional_cust_ref>
				</xsl:if>
				<xsl:if test="approx_expiry_date">
					<approx_expiry_date>
						<xsl:value-of select="approx_expiry_date"/>
					</approx_expiry_date>
				</xsl:if>
				<xsl:if test="delv_org_undertaking">
					<delv_org_undertaking>
						<xsl:value-of select="delv_org_undertaking"/>
					</delv_org_undertaking>
				</xsl:if>
				<xsl:if test="delv_org_undertaking_text">
					<delv_org_undertaking_text>
						<xsl:value-of select="delv_org_undertaking_text"/>
					</delv_org_undertaking_text>
				</xsl:if>
					<xsl:choose>
					<xsl:when test="issuing_bank_ref">
						<issuing_bank_reference>
							<xsl:value-of select="issuing_bank_ref"/>
						</issuing_bank_reference>
					</xsl:when>
					<xsl:when test="issuing_bank_reference">
						<issuing_bank_reference>
							<xsl:value-of select="issuing_bank_reference"/>
						</issuing_bank_reference>
					</xsl:when>
					</xsl:choose>
				<xsl:if test="send_attachments_by">
					<send_attachments_by>
						<xsl:value-of select="send_attachments_by"/>
					</send_attachments_by>
				</xsl:if>
				<xsl:if test="send_attachments_by_other">
					<send_attachments_by_other>
						<xsl:value-of select="send_attachments_by_other"/>
					</send_attachments_by_other>
				</xsl:if>
				<xsl:if test="advise_date">
					<advise_date>
						<xsl:value-of select="advise_date"/>
					</advise_date>
				</xsl:if>
				<xsl:if test="conf_chrg_brn_by_code">
					<conf_chrg_brn_by_code>
						<xsl:value-of select="conf_chrg_brn_by_code"/>
					</conf_chrg_brn_by_code>
				</xsl:if>
				<xsl:if test="bg_rule_other">
					<bg_rule_other>
						<xsl:value-of select="bg_rule_other"/>
					</bg_rule_other>
				</xsl:if>
				<xsl:if test="adv_send_mode_text">
					<adv_send_mode_text>
						<xsl:value-of select="adv_send_mode_text"/>
					</adv_send_mode_text>
				</xsl:if>				
			  <xsl:if test="bo_release_dttm">
					<additional_field name="bo_release_dttm" type="time" scope="none" description=" back office release dttm">
						<xsl:value-of select="bo_release_dttm" />
					</additional_field>
				</xsl:if>
				<xsl:apply-templates select="additional_field"/>
			</com.misys.portal.product.ru.common.ReceivedUndertaking>
			
			<!-- Banks -->
			<com.misys.portal.product.common.Bank role_code="09">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="brch_code"/></brch_code>
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<abbv_name><xsl:value-of select="$main_bank_abbv_name"/></abbv_name>
				<xsl:if test="recipient_bank/name"><name><xsl:value-of select="recipient_bank/name"/></name></xsl:if>
				<xsl:if test="$main_bank_name and not(recipient_bank/name)"><name><xsl:value-of select="$main_bank_name"/></name></xsl:if>
				<xsl:if test="recipient_bank/address_line_1"><address_line_1><xsl:value-of select="recipient_bank/address_line_1"/></address_line_1></xsl:if>
				<xsl:if test="recipient_bank/address_line_2"><address_line_2><xsl:value-of select="recipient_bank/address_line_2"/></address_line_2></xsl:if>
				<xsl:if test="recipient_bank/dom"><dom><xsl:value-of select="recipient_bank/dom"/></dom></xsl:if>
				<xsl:if test="recipient_bank/address_line_4"><address_line_4><xsl:value-of select="recipient_bank/address_line_4"/></address_line_4></xsl:if>
				<xsl:if test="recipient_bank/iso_code"><iso_code><xsl:value-of select="recipient_bank/iso_code"/></iso_code></xsl:if>
				<xsl:if test="recipient_bank/reference"><reference><xsl:value-of select="recipient_bank/reference"/></reference></xsl:if>
			</com.misys.portal.product.common.Bank>
			
			
			<com.misys.portal.product.common.Bank role_code="01">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="brch_code"/></brch_code>
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<abbv_name><xsl:value-of select="$main_bank_abbv_name"/></abbv_name>
				<name><xsl:value-of select="$main_bank_name"/></name>
			</com.misys.portal.product.common.Bank>
			
			
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="issuing_bank"/>
				<xsl:with-param name="role_code">01</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			
			<!-- <xsl:call-template name="bank">
				<xsl:with-param name="bank" select="$main_bank_abbv_name"/>
				<xsl:with-param name="role_code">01</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template> -->
			
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="confirming_bank"/>
				<xsl:with-param name="role_code">10</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			
			<!-- SWIFT 2021 Banks -->
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="advisethru_bank"/>
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

			<!-- <xsl:call-template name="bank">
				<xsl:with-param name="bank" select="$main_bank_abbv_name"/>
				<xsl:with-param name="role_code">02</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template> -->
			
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
				<xsl:if test="advising_bank/address_line_4"><address_line_4><xsl:value-of select="advising_bank/address_line_4"/></address_line_4></xsl:if>
				<xsl:if test="advising_bank/iso_code"><iso_code><xsl:value-of select="advising_bank/iso_code"/></iso_code></xsl:if>
				<xsl:if test="advising_bank/reference"><reference><xsl:value-of select="advising_bank/reference"/></reference></xsl:if>
			</com.misys.portal.product.common.Bank>
			
			<!-- Narratives -->		
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
				<xsl:with-param name="narrative" select="narrative_cancellation"/>
				<xsl:with-param name="type_code">47</xsl:with-param>
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
				<xsl:with-param name="narrative" select="narrative_undertaking_terms_and_conditions"/>
				<xsl:with-param name="type_code">63</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_text_undertaking"/>
				<xsl:with-param name="type_code">54</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_underlying_transaction_details"/>
				<xsl:with-param name="type_code">49</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_presentation_instructions"/>
				<xsl:with-param name="type_code">50</xsl:with-param>
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
				<xsl:with-param name="narrative" select="amd_details"/>
				<xsl:with-param name="type_code">13</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
		
			<!-- Pb because of the xml file doesn't contain this field -->
			<!-- 
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="bg_document"/>
				<xsl:with-param name="type_code">18</xsl:with-param>
			</xsl:call-template>
			-->
			
			<!-- Create Charges elements -->
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
 	 	 	 
 	 	 	 <xsl:if test="linked_licenses">
				<xsl:apply-templates select="linked_licenses/license">
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
				<xsl:with-param name="main_bank_name" select="//advising_bank/abbv_name"/>
				</xsl:apply-templates>
			</xsl:if>
			<xsl:if test="variation">
			    <xsl:if test="type">
					<type>
						<xsl:value-of select="type"/>
					</type>
			    </xsl:if>
				<xsl:if test="advise_flag">
					<advise_flag>
						<xsl:value-of select="advise_flag"/>
					</advise_flag>
				</xsl:if>
				<xsl:if test="advise_reduction_days">
					<advise_reduction_days>
						<xsl:value-of select="advise_reduction_days"/>
					</advise_reduction_days>
				</xsl:if>
				<xsl:if test="maximum_nb_days">
					<maximum_nb_days>
						<xsl:value-of select="maximum_nb_days"/>
					</maximum_nb_days>
				</xsl:if>
				<xsl:if test="frequency">
					<frequency>
						<xsl:value-of select="frequency"/>
					</frequency>
				</xsl:if>
				<xsl:if test="period">
					<period>
						<xsl:value-of select="period"/>
					</period>
				</xsl:if>
				<xsl:if test="day_in_month">
					<day_in_month>
						<xsl:value-of select="day_in_month"/>
					</day_in_month>
				</xsl:if>
				<xsl:if test="variation/variation_lines/variation_line_item">			
					<xsl:apply-templates select="variation/variation_lines/variation_line_item">
					    <xsl:with-param name="type" select="variation/type"/>
						<xsl:with-param name="advise_flag" select="variation/advise_flag"/>
						<xsl:with-param name="advise_reduction_days" select="variation/advise_reduction_days"/>
						<xsl:with-param name="maximum_nb_days" select="variation/maximum_nb_days"/>
						<xsl:with-param name="frequency" select="variation/frequency"/>
						<xsl:with-param name="period" select="variation/period"/>
						<xsl:with-param name="day_in_month" select="variation/day_in_month"/>
						<xsl:with-param name="product_code" select="product_code"/>
					</xsl:apply-templates>
				</xsl:if>
			</xsl:if>
			<!-- TO DO -->	
		</result>
	</xsl:template>
</xsl:stylesheet>
