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
	<!-- Process LC Template File and Stand By Issued LC-->
	<xsl:template match="lc_tnx_record | si_tnx_record">
		<result>
			<com.misys.portal.product.lc.common.TemplateLetterOfCredit>
				<xsl:if test="template_id">
					<xsl:attribute name="template_id">
						<xsl:value-of select="template_id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_type">
					<additional_field name="credit_available_with_bank_type"
				type="string" scope="master">
						<xsl:value-of select="credit_available_with_bank_type"/>
					</additional_field>
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
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
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
				<xsl:if test="sub_product_code">
					<sub_product_code>
						<xsl:value-of select="sub_product_code"/>
					</sub_product_code>
				</xsl:if>
				<xsl:if test="lc_type">
					<lc_type>
						<xsl:value-of select="lc_type"/>
					</lc_type>
				</xsl:if>
				<xsl:if test="provisional_status">
 	                 <provisional_status>
	                     <xsl:value-of select="provisional_status"/>
	                  </provisional_status>
	            </xsl:if>
				<xsl:if test="template_description">
					<template_description>
						<xsl:value-of select="template_description"/>
					</template_description>
				</xsl:if>
				<xsl:if test="expiry_place">
					<expiry_place>
						<xsl:value-of select="expiry_place"/>
					</expiry_place>
				</xsl:if>
				<xsl:if test="inco_term">
					<inco_term>
						<xsl:value-of select="inco_term"/>
					</inco_term>
				</xsl:if>
				<xsl:if test="inco_term_year">
					<inco_term_year>
						<xsl:value-of select="inco_term_year"/>
					</inco_term_year>
				</xsl:if>
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
								<xsl:value-of select="part_ship_detl"/>
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
				<!-- Value may be split into 2 fields -->
				<xsl:if test="tran_ship_detl">
					<tran_ship_detl>
						<xsl:choose>
                  	<xsl:when test="tran_ship_detl_text [. != '']">
								<xsl:value-of select="tran_ship_detl_text"/>
                  	</xsl:when>
                  	<xsl:otherwise>
								<xsl:value-of select="tran_ship_detl"/>
                  	</xsl:otherwise>
                  </xsl:choose>
					</tran_ship_detl>
				</xsl:if>
				<xsl:if test="cty_of_dest">
					<cty_of_dest>
						<xsl:value-of select="cty_of_dest"/>
					</cty_of_dest>
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
				<xsl:if test="cr_avl_by_code">
					<cr_avl_by_code>
						<xsl:value-of select="cr_avl_by_code"/>
					</cr_avl_by_code>
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
						<xsl:value-of select="utils:decryptApplicantReference(applicant_reference)"/>
					</applicant_reference>
				</xsl:if>
				<!-- Ignore field due to TI structured fields not saved -->
				<xsl:if test="draft_term">
					<draft_term>
						<xsl:value-of select="draft_term"/>
					</draft_term>
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
				<xsl:if test="version">
					<version>
						<xsl:value-of select="version"/>
					</version>
				</xsl:if>
				<xsl:if test="eucp_presentation_place">
					<eucp_presentation_place>
						<xsl:value-of select="eucp_presentation_place"/>
					</eucp_presentation_place>
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
				<xsl:if test="cust_ref_id">
					<cust_ref_id>
						<xsl:value-of select="cust_ref_id"/>
					</cust_ref_id>
				</xsl:if>
				
				<!-- Added for TI integration -->
				<!-- xsl:if test="tenor_type">
					<additional_field name="tenor_type" type="string" scope="master">
						<xsl:value-of select="tenor_type"/>
					</additional_field>
				</xsl:if-->
				<xsl:if test="tenor_type">
					<tenor_type>
						<xsl:value-of select="tenor_type"/>
					</tenor_type>
				</xsl:if>
				<!-- xsl:if test="tenor_maturity_date">
					<additional_field name="tenor_maturity_date" type="date" scope="master">
						<xsl:value-of select="tenor_maturity_date"/>
					</additional_field>
				</xsl:if-->
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
				<xsl:if test="transport_mode">
					<transport_mode>
						<xsl:value-of select="transport_mode"/>
					</transport_mode>
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
				<xsl:if test="alt_applicant_cust_ref">
					<alt_applicant_cust_ref>
						<xsl:value-of select="alt_applicant_cust_ref"/>
					</alt_applicant_cust_ref>
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
				<xsl:if test="stand_by_lc_code">
					<stand_by_lc_code>
						<xsl:value-of select="stand_by_lc_code"/>
					</stand_by_lc_code>
				</xsl:if>
				<xsl:if test="standby_template_bank_id">
					<standby_template_bank_id>
						<xsl:value-of select="standby_template_bank_id"/>
					</standby_template_bank_id>
				</xsl:if>
				<xsl:if test="standby_text_type_code">
					<standby_text_type_code>
						<xsl:value-of select="standby_text_type_code"/>
					</standby_text_type_code>
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
				<!-- Standby LC final expiry date -->
				<xsl:if test="final_expiry_date">
					<final_expiry_date>
						<xsl:value-of select="final_expiry_date"/>
					</final_expiry_date>
				</xsl:if>	
				
				<xsl:if test="adv_send_mode">
					<adv_send_mode>
						<xsl:value-of select="adv_send_mode"/>
					</adv_send_mode>
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
				<!-- SWIFT 2018 -->
				<xsl:if test="period_presentation_days">
					<period_presentation_days>
						<xsl:value-of select="period_presentation_days"/>
					</period_presentation_days>
				</xsl:if>			
				<!-- 
				<xsl:if test="tenor_days">
					<additional_field name="tenor_days" type="string" scope="master">
						<xsl:value-of select="tenor_days"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="tenor_period">
					<additional_field name="tenor_period" type="string" scope="master">
						<xsl:value-of select="tenor_period"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="tenor_from_after">
					<additional_field name="tenor_from_after" type="string" scope="master">
						<xsl:value-of select="tenor_from_after"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="tenor_days_type">
					<additional_field name="tenor_days_type" type="string" scope="master">
						<xsl:value-of select="tenor_days_type"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="tenor_type_details">
					<additional_field name="tenor_type_details" type="string" scope="master">
						<xsl:value-of select="tenor_type_details"/>
					</additional_field>
				</xsl:if>
				-->
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
				<xsl:if test="transfer_condition">
					<transfer_condition>
						<xsl:value-of select="transfer_condition"/>
					</transfer_condition>
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
     </com.misys.portal.product.lc.common.TemplateLetterOfCredit>
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
				<xsl:if test="issuing_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="issuing_bank_address_line_4"/>
					</address_line_4>
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
			<com.misys.portal.product.common.TemplateBank role_code="02">
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
				<xsl:if test="advising_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="advising_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="advising_bank_name">
					<name>
						<xsl:value-of select="advising_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="advising_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="advising_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="advising_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="advising_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="advising_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="advising_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="advising_bank_dom">
					<dom>
						<xsl:value-of select="advising_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="advising_bank_iso_code">
					<iso_code>
						<xsl:value-of select="advising_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="advising_bank_reference">
					<reference>
						<xsl:value-of select="advising_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateBank role_code="03">
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
				<xsl:if test="advise_thru_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="advise_thru_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="advise_thru_bank_name">
					<name>
						<xsl:value-of select="advise_thru_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="advise_thru_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="advise_thru_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="advise_thru_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="advise_thru_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="advise_thru_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="advise_thru_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="advise_thru_bank_dom">
					<dom>
						<xsl:value-of select="advise_thru_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="advise_thru_bank_iso_code">
					<iso_code>
						<xsl:value-of select="advise_thru_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="advise_thru_bank_reference">
					<reference>
						<xsl:value-of select="advise_thru_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateBank role_code="04">
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
				<xsl:if test="credit_available_with_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="credit_available_with_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_name">
					<xsl:choose>
	                  	<xsl:when test="credit_available_with_bank_type [. = 'Other' or . = '']">
							<name>
								<xsl:value-of select="credit_available_with_bank_name"/>
							</name>
	                  	</xsl:when>
	                  	<xsl:otherwise>
							<name>
								<xsl:value-of select="credit_available_with_bank_type"/>
							</name>
	                  	</xsl:otherwise>
                  	</xsl:choose>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="credit_available_with_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="credit_available_with_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="credit_available_with_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_dom">
					<dom>
						<xsl:value-of select="credit_available_with_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_iso_code">
					<iso_code>
						<xsl:value-of select="credit_available_with_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_reference">
					<reference>
						<xsl:value-of select="credit_available_with_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateBank role_code="05">
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
				<xsl:if test="drawee_details_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="drawee_details_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="drawee_details_bank_name">
					<name>
						<xsl:value-of select="drawee_details_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="drawee_details_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="drawee_details_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="drawee_details_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="drawee_details_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="drawee_details_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="drawee_details_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="drawee_details_bank_dom">
					<dom>
						<xsl:value-of select="drawee_details_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="drawee_details_bank_iso_code">
					<iso_code>
						<xsl:value-of select="drawee_details_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="drawee_details_bank_reference">
					<reference>
						<xsl:value-of select="drawee_details_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<!-- SWIFT 2018 -->
			<com.misys.portal.product.common.TemplateBank role_code="17">
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
				<xsl:if test="requested_confirmation_party_abbv_name">
					<abbv_name>
						<xsl:value-of select="requested_confirmation_party_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="requested_confirmation_party_name">
					<name>
						<xsl:value-of select="requested_confirmation_party_name"/>
					</name>
				</xsl:if>
				<xsl:if test="requested_confirmation_party_address_line_1">
					<address_line_1>
						<xsl:value-of select="requested_confirmation_party_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="requested_confirmation_party_address_line_2">
					<address_line_2>
						<xsl:value-of select="requested_confirmation_party_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="requested_confirmation_party_dom">
					<dom>
						<xsl:value-of select="requested_confirmation_party_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="requested_confirmation_party_address_line_4">
					<address_line_4>
						<xsl:value-of select="requested_confirmation_party_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="requested_confirmation_party_iso_code">
					<iso_code>
						<xsl:value-of select="requested_confirmation_party_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="requested_confirmation_party_reference">
					<reference>
						<xsl:value-of select="requested_confirmation_party_reference"/>
					</reference>
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
			<com.misys.portal.product.common.TemplateNarrative type_code="02">
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
				<xsl:if test="narrative_documents_required">
					<text>
						<xsl:value-of select="narrative_documents_required"/>
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
			<com.misys.portal.product.common.TemplateNarrative type_code="04">
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
				<xsl:if test="narrative_charges">
					<text>
						<xsl:value-of select="narrative_charges"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="05">
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
				<xsl:if test="narrative_additional_amount">
					<text>
						<xsl:value-of select="narrative_additional_amount"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="06">
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
				<xsl:if test="narrative_payment_instructions">
					<text>
						<xsl:value-of select="narrative_payment_instructions"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="07">
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
				<xsl:if test="narrative_period_presentation">
					<text>
						<xsl:value-of select="narrative_period_presentation"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="08">
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
				<xsl:if test="narrative_shipment_period">
					<text>
						<xsl:value-of select="narrative_shipment_period"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="09">
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
				<xsl:if test="narrative_sender_to_receiver">
					<text>
						<xsl:value-of select="narrative_sender_to_receiver"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="10">
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
				<xsl:if test="narrative_full_details">
					<text>
						<xsl:value-of select="narrative_full_details"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="12">
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
				<xsl:if test="free_format_text">
					<text>
						<xsl:value-of select="free_format_text"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="40">
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
				<xsl:if test="narrative_special_beneficiary">
					<text>
						<xsl:value-of select="narrative_special_beneficiary"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="48">
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
				<xsl:if test="narrative_transfer_conditions">
					<text>
						<xsl:value-of select="narrative_transfer_conditions"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			
			<com.misys.portal.product.common.TemplateNarrative type_code="62">
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
				<xsl:if test="narrative_delivery_to">
					<text>
						<xsl:value-of select="narrative_delivery_to"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
