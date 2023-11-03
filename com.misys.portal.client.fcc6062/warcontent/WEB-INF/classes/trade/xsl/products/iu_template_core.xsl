<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="utils">
				
	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>
	
	<!-- Common elements to save among all products -->
	<xsl:include href="../../../core/xsl/products/save_common.xsl"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process BG template-->
	<xsl:template match="bg_tnx_record">
		<result>
			<com.misys.portal.product.iu.common.TemplateIssuedUndertaking>
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
				<xsl:if test="credit_available_with_bank_type">
					<additional_field name="credit_available_with_bank_type"
				type="string" scope="master">
						<xsl:value-of select="credit_available_with_bank_type"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="cu_credit_available_with_bank_type">
					<additional_field name="cu_credit_available_with_bank_type"
				type="string" scope="master">
						<xsl:value-of select="cu_credit_available_with_bank_type"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>	
				<xsl:if test="template_description">
					<template_description>
						<xsl:value-of select="template_description"/>
					</template_description>
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
				<xsl:if test="sub_product_code">
					<sub_product_code>
						<xsl:value-of select="sub_product_code"/>
					</sub_product_code>
				</xsl:if>
				<xsl:if test="iss_date_type_code">
					<iss_date_type_code>
						<xsl:value-of select="iss_date_type_code"/>
					</iss_date_type_code>
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
				<xsl:if test="provisional_status">
					<provisional_status>
						<xsl:value-of select="provisional_status"/>
					</provisional_status>
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
				<xsl:if test="additional_cust_ref">
					<additional_cust_ref>
						<xsl:value-of select="additional_cust_ref"/>
					</additional_cust_ref>
				</xsl:if>
				<xsl:if test="cust_ref_id">
					<cust_ref_id>
						<xsl:value-of select="cust_ref_id"/>
					</cust_ref_id>
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
				<xsl:if test="bg_code">
					<bg_code>
						<xsl:value-of select="bg_code"/>
					</bg_code>
				</xsl:if>
				<xsl:if test="for_account">
					<for_account>
						<xsl:value-of select="for_account"/>
					</for_account>
				</xsl:if>
				<xsl:if test="adv_bank_conf_req">
					<adv_bank_conf_req>
						<xsl:value-of select="adv_bank_conf_req"/>
					</adv_bank_conf_req>
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
				<xsl:if test="contact_name">
					<contact_name>
						<xsl:value-of select="contact_name"/>
					</contact_name>
				</xsl:if>
				<xsl:if test="contact_address_line_1">
					<contact_address_line_1>
						<xsl:value-of select="contact_address_line_1"/>
					</contact_address_line_1>
				</xsl:if>
				<xsl:if test="contact_address_line_2">
					<contact_address_line_2>
						<xsl:value-of select="contact_address_line_2"/>
					</contact_address_line_2>
				</xsl:if>
				<xsl:if test="contact_address_line_4">
					<contact_address_line_4>
						<xsl:value-of select="contact_address_line_4"/>
					</contact_address_line_4>
				</xsl:if>
				<xsl:if test="contact_dom">
					<contact_dom>
						<xsl:value-of select="contact_dom"/>
					</contact_dom>
				</xsl:if>
				<xsl:if test="contact_country">
					<contact_country>
						<xsl:value-of select="contact_country"/>
					</contact_country>
				</xsl:if>
				<xsl:if test="guarantee_type_company_id">
					<guarantee_type_company_id>
						<xsl:value-of select="guarantee_type_company_id"/>
					</guarantee_type_company_id>
				</xsl:if>
				<xsl:if test="guarantee_type_name">
					<guarantee_type_name>
						<xsl:value-of select="guarantee_type_name"/>
					</guarantee_type_name>
				</xsl:if>
				<xsl:if test="lead_bank_flag">
					<lead_bank_flag>
						<xsl:value-of select="lead_bank_flag"/>
					</lead_bank_flag>
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
				<!-- Credit Available By -->
				<xsl:if test="cr_avl_by_code">
					<cr_avl_by_code>
						<xsl:value-of select="cr_avl_by_code"/>
					</cr_avl_by_code>
				</xsl:if>
				<xsl:if test="final_expiry_date">
					<final_expiry_date>
						<xsl:value-of select="final_expiry_date"/>
					</final_expiry_date>
				</xsl:if>
				<!-- Renewal details added  END -->
								
				<xsl:if test="purpose">
					<purpose>
						<xsl:value-of select="purpose"/>
					</purpose>
				</xsl:if>
				
				<xsl:if test="bei_code">
					<bei_code>
						<xsl:value-of select="bei_code"/>
					</bei_code>
				</xsl:if>
				
				<xsl:if test="bg_conf_instructions">
					<bg_conf_instructions>
						<xsl:value-of select="bg_conf_instructions"/>
					</bg_conf_instructions>
				</xsl:if>
				
				<xsl:if test="conf_chrg_brn_by_code">
					<conf_chrg_brn_by_code>
						<xsl:value-of select="conf_chrg_brn_by_code"/>
					</conf_chrg_brn_by_code>
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
				
				<xsl:if test="bg_demand_indicator">
					<bg_demand_indicator>
						<xsl:value-of select="bg_demand_indicator"/>
					</bg_demand_indicator>
				</xsl:if>
				
				<xsl:if test="bg_transfer_indicator">
					<bg_transfer_indicator>
						<xsl:value-of select="bg_transfer_indicator"/>
					</bg_transfer_indicator>
				</xsl:if>
				
				<xsl:if test="bg_special_terms">
					<bg_special_terms>
						<xsl:value-of select="bg_special_terms"/>
					</bg_special_terms>
				</xsl:if>
				
				<xsl:if test="adv_send_mode_text">
					<adv_send_mode_text>
						<xsl:value-of select="adv_send_mode_text"/>
					</adv_send_mode_text>
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
				
				<xsl:if test="send_attachments_by">
					<send_attachments_by>
						<xsl:value-of select="send_attachments_by"/>
					</send_attachments_by>
				</xsl:if>
				
				<xsl:if test="cu_effective_date_type_code">
					<cu_effective_date_type_code>
						<xsl:value-of select="cu_effective_date_type_code"/>
					</cu_effective_date_type_code>
				</xsl:if>
				
				<xsl:if test="cu_exp_date_type_code">
					<cu_exp_date_type_code>
						<xsl:value-of select="cu_exp_date_type_code"/>
					</cu_exp_date_type_code>
				</xsl:if>
				<xsl:if test="cu_sub_product_code">
					<cu_sub_product_code>
						<xsl:value-of select="cu_sub_product_code"/>
					</cu_sub_product_code>
				</xsl:if>
				
				<xsl:if test="cu_consortium">
					<cu_consortium>
						<xsl:value-of select="cu_consortium"/>
					</cu_consortium>
				</xsl:if>
				
				<xsl:if test="cu_consortium_details">
					<cu_consortium_details>
						<xsl:value-of select="cu_consortium_details"/>
					</cu_consortium_details>
				</xsl:if>
				
				<xsl:if test="cu_conf_instructions">
					<cu_conf_instructions>
						<xsl:value-of select="cu_conf_instructions"/>
					</cu_conf_instructions>
				</xsl:if>
				
				<xsl:if test="cu_open_chrg_brn_by_code">
					<cu_open_chrg_brn_by_code>
						<xsl:value-of select="cu_open_chrg_brn_by_code"/>
					</cu_open_chrg_brn_by_code>
				</xsl:if>
				
				<xsl:if test="cu_corr_chrg_brn_by_code">
					<cu_corr_chrg_brn_by_code>
						<xsl:value-of select="cu_corr_chrg_brn_by_code"/>
					</cu_corr_chrg_brn_by_code>
				</xsl:if>
				
				<xsl:if test="cu_conf_chrg_brn_by_code">
					<cu_conf_chrg_brn_by_code>
						<xsl:value-of select="cu_conf_chrg_brn_by_code"/>
					</cu_conf_chrg_brn_by_code>
				</xsl:if>
				
				<xsl:if test="cu_renewal_type">
					<cu_renewal_type>
						<xsl:value-of select="cu_renewal_type"/>
					</cu_renewal_type>
				</xsl:if>
				
				<xsl:if test="cu_renew_flag">
					<cu_renew_flag>
						<xsl:value-of select="cu_renew_flag"/>
					</cu_renew_flag>
				</xsl:if>
				
				<xsl:if test="cu_renew_on_code">
					<cu_renew_on_code>
						<xsl:value-of select="cu_renew_on_code"/>
					</cu_renew_on_code>
				</xsl:if>
				
				<xsl:if test="cu_renew_for_nb">
					<cu_renew_for_nb>
						<xsl:value-of select="cu_renew_for_nb"/>
					</cu_renew_for_nb>
				</xsl:if>
				
				<xsl:if test="cu_renew_for_period">
					<cu_renew_for_period>
						<xsl:value-of select="cu_renew_for_period"/>
					</cu_renew_for_period>
				</xsl:if>
				
				<xsl:if test="cu_advise_renewal_flag">
					<cu_advise_renewal_flag>
						<xsl:value-of select="cu_advise_renewal_flag"/>
					</cu_advise_renewal_flag>
				</xsl:if>
				
				<xsl:if test="cu_advise_renewal_days_nb">
					<cu_advise_renewal_days_nb>
						<xsl:value-of select="cu_advise_renewal_days_nb"/>
					</cu_advise_renewal_days_nb>
				</xsl:if>
				
				<xsl:if test="cu_rolling_renewal_flag">
					<cu_rolling_renewal_flag>
						<xsl:value-of select="cu_rolling_renewal_flag"/>
					</cu_rolling_renewal_flag>
				</xsl:if>
				
				<xsl:if test="cu_rolling_renew_on_code">
					<cu_rolling_renew_on_code>
						<xsl:value-of select="cu_rolling_renew_on_code"/>
					</cu_rolling_renew_on_code>
				</xsl:if>
				
				<xsl:if test="cu_rolling_renew_for_nb">
					<cu_rolling_renew_for_nb>
						<xsl:value-of select="cu_rolling_renew_for_nb"/>
					</cu_rolling_renew_for_nb>
				</xsl:if>
				
				<xsl:if test="cu_rolling_renew_for_period">
					<cu_rolling_renew_for_period>
						<xsl:value-of select="cu_rolling_renew_for_period"/>
					</cu_rolling_renew_for_period>
				</xsl:if>
				
				<xsl:if test="cu_rolling_day_in_month">
					<cu_rolling_day_in_month>
						<xsl:value-of select="cu_rolling_day_in_month"/>
					</cu_rolling_day_in_month>
				</xsl:if>
				
				<xsl:if test="cu_rolling_renewal_nb">
					<cu_rolling_renewal_nb>
						<xsl:value-of select="cu_rolling_renewal_nb"/>
					</cu_rolling_renewal_nb>
				</xsl:if>
				
				<xsl:if test="cu_rolling_renewal_nb">
					<cu_rolling_renewal_nb>
						<xsl:value-of select="cu_rolling_renewal_nb"/>
					</cu_rolling_renewal_nb>
				</xsl:if>

				<xsl:if test="cu_rolling_cancellation_days">
					<cu_rolling_cancellation_days>
						<xsl:value-of select="cu_rolling_cancellation_days"/>
					</cu_rolling_cancellation_days>
				</xsl:if>
				
				<xsl:if test="cu_renew_amt_code">
					<cu_renew_amt_code>
						<xsl:value-of select="cu_renew_amt_code"/>
					</cu_renew_amt_code>
				</xsl:if>
				
				<xsl:if test="cu_type_code">
					<cu_type_code>
						<xsl:value-of select="cu_type_code"/>
					</cu_type_code>
				</xsl:if>
				
				<xsl:if test="cu_rule">
					<cu_rule>
						<xsl:value-of select="cu_rule"/>
					</cu_rule>
				</xsl:if>
				
				<xsl:if test="cu_rule_other">
					<cu_rule_other>
						<xsl:value-of select="cu_rule_other"/>
					</cu_rule_other>
				</xsl:if>
				
				<xsl:if test="cu_govern_country">
					<cu_govern_country>
						<xsl:value-of select="cu_govern_country"/>
					</cu_govern_country>
				</xsl:if>
				
				<xsl:if test="cu_govern_text">
					<cu_govern_text>
						<xsl:value-of select="cu_govern_text"/>
					</cu_govern_text>
				</xsl:if>
				
				<xsl:if test="cu_demand_indicator">
					<cu_demand_indicator>
						<xsl:value-of select="cu_demand_indicator"/>
					</cu_demand_indicator>
				</xsl:if>
				
				<xsl:if test="cu_transfer_indicator">
					<cu_transfer_indicator>
						<xsl:value-of select="cu_transfer_indicator"/>
					</cu_transfer_indicator>
				</xsl:if>
				
				<xsl:if test="cu_text_type_code">
					<cu_text_type_code>
						<xsl:value-of select="cu_text_type_code"/>
					</cu_text_type_code>
				</xsl:if>
				
				<xsl:if test="cu_text_type_details">
					<cu_text_type_details>
						<xsl:value-of select="cu_text_type_details"/>
					</cu_text_type_details>
				</xsl:if>
				
				<xsl:if test="cu_text_language">
					<cu_text_language>
						<xsl:value-of select="cu_text_language"/>
					</cu_text_language>
				</xsl:if>
				
				<xsl:if test="cu_text_language_other">
					<cu_text_language_other>
						<xsl:value-of select="cu_text_language_other"/>
					</cu_text_language_other>
				</xsl:if>
				
				<!-- Counter Credit Available By -->
				<xsl:if test="cu_cr_avl_by_code">
					<cu_cr_avl_by_code>
						<xsl:value-of select="cu_cr_avl_by_code"/>
					</cu_cr_avl_by_code>
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
				<!-- Shipment Details END-->
				
				<xsl:if test="bg_tolerance_positive_pct">
					<bg_tolerance_positive_pct>
						<xsl:value-of select="bg_tolerance_positive_pct"/>
					</bg_tolerance_positive_pct>
				</xsl:if>
				
				<xsl:if test="bg_tolerance_negative_pct">
					<bg_tolerance_negative_pct>
						<xsl:value-of select="bg_tolerance_negative_pct"/>
					</bg_tolerance_negative_pct>
				</xsl:if>
				
				<xsl:if test="cu_tolerance_positive_pct">
					<cu_tolerance_positive_pct>
						<xsl:value-of select="cu_tolerance_positive_pct"/>
					</cu_tolerance_positive_pct>
				</xsl:if>
				
				<xsl:if test="cu_tolerance_negative_pct">
					<cu_tolerance_negative_pct>
						<xsl:value-of select="cu_tolerance_negative_pct"/>
					</cu_tolerance_negative_pct>
				</xsl:if>
				
				<xsl:if test="cu_exp_event">
					<cu_exp_event>
						<xsl:value-of select="cu_exp_event"/>
					</cu_exp_event>
				</xsl:if>
				
				<xsl:if test="cu_net_exposure_cur_code">
					<cu_net_exposure_cur_code>
						<xsl:value-of select="cu_net_exposure_cur_code"/>
					</cu_net_exposure_cur_code>
				</xsl:if>
				
				<xsl:if test="cu_net_exposure_amt">
					<cu_net_exposure_amt>
						<xsl:value-of select="cu_net_exposure_amt"/>
					</cu_net_exposure_amt>
				</xsl:if>
				
				<xsl:if test="cancellation_req_flag">
					<cancellation_req_flag>
						<xsl:value-of select="cancellation_req_flag"/>
					</cancellation_req_flag>
				</xsl:if>
				
				<xsl:if test="customer_identifier">
					<customer_identifier>
						<xsl:value-of select="customer_identifier"/>
					</customer_identifier>
				</xsl:if>
				
				<xsl:if test="customer_identifier_other">
					<customer_identifier_other>
						<xsl:value-of select="customer_identifier_other"/>
					</customer_identifier_other>
				</xsl:if>
				
				<xsl:if test="beneficiary_email">
					<additional_field name="beneficiary_email" type="string" scope="master">
						<xsl:value-of select="beneficiary_email"/>
					</additional_field>
				</xsl:if>	
				<xsl:if test="beneficiary_contact_number">
					<additional_field name="beneficiary_contact_number" type="string" scope="master" description="beneficiary_contact_number">
						<xsl:value-of select="beneficiary_contact_number"/>
					</additional_field>
				</xsl:if>	
				<xsl:if test="beneficiary_fax_num">
					<additional_field name="beneficiary_fax_num" type="string" scope="master" description="beneficiary_fax_num">
						<xsl:value-of select="beneficiary_fax_num"/>
					</additional_field>
				</xsl:if>								
				<xsl:if test="ordering_party_name">
					<additional_field name="ordering_party_name" type="string" scope="master" description="Ordering Party Name">
						<xsl:value-of select="ordering_party_name"/>
					</additional_field>
				</xsl:if>				
				<xsl:if test="ordering_party_address_line_1">
					<additional_field name="ordering_party_address_line_1" type="string" scope="master" description="Ordering Party Address Address Line 1">
						<xsl:value-of select="ordering_party_address_line_1"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="ordering_party_address_line_2">
					<additional_field name="ordering_party_address_line_2" type="string" scope="master" description="Ordering Party Address Address Line 2">
						<xsl:value-of select="ordering_party_address_line_2"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="ordering_party_address_line_4">
					<additional_field name="ordering_party_address_line_4" type="string" scope="master" description="Ordering Party Address Address Line 4">
						<xsl:value-of select="ordering_party_address_line_4"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="ordering_party_address_dom">
					<additional_field name="ordering_party_address_dom" type="string" scope="master" description="Ordering Party Address Dom">
						<xsl:value-of select="ordering_party_address_dom"/>
					</additional_field>
				</xsl:if>				
				<xsl:if test="ordering_party_contact_name">
					<additional_field name="ordering_party_contact_name" type="string" scope="master" description="Ordering Party Contact Name">
						<xsl:value-of select="ordering_party_contact_name"/>
					</additional_field>
				</xsl:if>				
				<xsl:if test="ordering_party_phone">
					<additional_field name="ordering_party_phone" type="string" scope="master" description="Ordering Party Contact Phone Number">
						<xsl:value-of select="ordering_party_phone"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bg_guarantee_purpose">
					<additional_field name="bg_guarantee_purpose" type="string" scope="master" description="bg_guarantee_purpose">
						<xsl:value-of select="bg_guarantee_purpose"/>
					</additional_field>
				</xsl:if>				
				<xsl:if test="bg_claim_period">
					<additional_field name="bg_claim_period" type="string" scope="master" description="Claim Period">
						<xsl:value-of select="bg_claim_period"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bg_renewal">
					<additional_field name="bg_renewal" type="string" scope="master" description="Renewal Check box">
						<xsl:value-of select="bg_renewal"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bg_previous_guarantee_reference">
					<additional_field name="bg_previous_guarantee_reference" type="string" scope="master" description="Previous Guarantee Reference">
						<xsl:value-of select="bg_previous_guarantee_reference"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bg_gurantee_purpose">
					<additional_field name="bg_gurantee_purpose" type="string" scope="master" description="bg_gurantee_purpose">
						<xsl:value-of select="bg_gurantee_purpose"/>
					</additional_field>
				</xsl:if>	
				<xsl:if test="stylesheetname">
					<additional_field name="stylesheetname" type="string" scope="master" description="stylesheetname">
						<xsl:value-of select="stylesheetname"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="document_id">
					<additional_field name="document_id" type="string" scope="master">
						<xsl:value-of select="document_id"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="margin_indicator">
			 		<additional_field name="margin_indicator" type="string" scope="master" description="Margin_deposit_indicator">
						<xsl:value-of select="margin_indicator"/>
					 </additional_field>
				</xsl:if>
				
				<!-- Re authentication -->
				<xsl:call-template name="AUTHENTICATION"/>
				<!-- collaboration -->
				<xsl:call-template name="collaboration" />
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.product.iu.common.TemplateIssuedUndertaking>
     <com.misys.portal.product.common.TemplatePartyDetails type_code="06">
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
				<xsl:if test="cu_contact/abbv_name">
					<abbv_name>
						<xsl:value-of select="cu_contact/abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="cu_contact_abbv_name">
					<abbv_name>
						<xsl:value-of select="cu_contact_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="cu_contact/name">
					<name>
						<xsl:value-of select="cu_contact/name"/>
					</name>
				</xsl:if>
				<xsl:if test="cu_contact_name">
					<name>
						<xsl:value-of select="cu_contact_name"/>
					</name>
				</xsl:if>
				<xsl:if test="cu_contact/address_line_1">
					<address_line_1>
						<xsl:value-of select="cu_contact/address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="cu_contact_address_line_1">
					<address_line_1>
						<xsl:value-of select="cu_contact_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="cu_contact/address_line_2">
					<address_line_2>
						<xsl:value-of select="cu_contact/address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="cu_contact_address_line_2">
					<address_line_2>
						<xsl:value-of select="cu_contact_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="cu_contact/dom">
					<dom>
						<xsl:value-of select="cu_contact/dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="cu_contact_dom">
					<dom>
						<xsl:value-of select="cu_contact_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="cu_contact/address_line_4">
					<address_line_4>
						<xsl:value-of select="cu_contact/address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="cu_contact_address_line_4">
					<address_line_4>
						<xsl:value-of select="cu_contact_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="cu_contact/country">
					<country>
						<xsl:value-of select="cu_contact/country"/>
					</country>
				</xsl:if>
				<xsl:if test="cu_contact_country">
					<country>
						<xsl:value-of select="cu_contact_country"/>
					</country>
				</xsl:if>
				<xsl:if test="cu_contact/bei_code">
					<bei_code>
						<xsl:value-of select="cu_contact/bei_code"/>
					</bei_code>
				</xsl:if>
				<xsl:if test="cu_contact_bei_code">
					<bei_code>
						<xsl:value-of select="cu_contact_bei_code"/>
					</bei_code>
				</xsl:if>
				<xsl:if test="cu_contact/reference">
					<reference>
						<xsl:value-of select="cu_contact/reference"/>
					</reference>
				</xsl:if>
				<xsl:if test="cu_contact_reference">
					<reference>
						<xsl:value-of select="cu_contact_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplatePartyDetails>
			<com.misys.portal.product.common.TemplatePartyDetails type_code="05">
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
				<xsl:if test="cu_beneficiary/abbv_name">
					<abbv_name>
						<xsl:value-of select="cu_beneficiary/abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="cu_beneficiary_abbv_name">
					<abbv_name>
						<xsl:value-of select="cu_beneficiary_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="cu_beneficiary/name">
					<name>
						<xsl:value-of select="cu_beneficiary/name"/>
					</name>
				</xsl:if>
				<xsl:if test="cu_beneficiary_name">
					<name>
						<xsl:value-of select="cu_beneficiary_name"/>
					</name>
				</xsl:if>
				<xsl:if test="cu_beneficiary/address_line_1">
					<address_line_1>
						<xsl:value-of select="cu_beneficiary/address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="cu_beneficiary_address_line_1">
					<address_line_1>
						<xsl:value-of select="cu_beneficiary_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="cu_beneficiary/address_line_2">
					<address_line_2>
						<xsl:value-of select="cu_beneficiary/address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="cu_beneficiary_address_line_2">
					<address_line_2>
						<xsl:value-of select="cu_beneficiary_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="cu_beneficiary/dom">
					<dom>
						<xsl:value-of select="cu_beneficiary/dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="cu_beneficiary_dom">
					<dom>
						<xsl:value-of select="cu_beneficiary_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="cu_beneficiary/address_line_4">
					<address_line_4>
						<xsl:value-of select="cu_beneficiary/address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="cu_beneficiary_address_line_4">
					<address_line_4>
						<xsl:value-of select="cu_beneficiary_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="cu_beneficiary/country">
					<country>
						<xsl:value-of select="cu_beneficiary/country"/>
					</country>
				</xsl:if>
				<xsl:if test="cu_beneficiary_country">
					<country>
						<xsl:value-of select="cu_beneficiary_country"/>
					</country>
				</xsl:if>
				<xsl:if test="cu_beneficiary/bei_code">
					<bei_code>
						<xsl:value-of select="cu_beneficiary/bei_code"/>
					</bei_code>
				</xsl:if>
				<xsl:if test="cu_beneficiary_bei_code">
					<bei_code>
						<xsl:value-of select="cu_beneficiary_bei_code"/>
					</bei_code>
				</xsl:if>
				<xsl:if test="cu_beneficiary/reference">
					<reference>
						<xsl:value-of select="cu_beneficiary/reference"/>
					</reference>
				</xsl:if>
				<xsl:if test="cu_beneficiary_reference">
					<reference>
						<xsl:value-of select="cu_beneficiary_reference"/>
					</reference>
				</xsl:if>
	</com.misys.portal.product.common.TemplatePartyDetails>
     <com.misys.portal.product.common.TemplateBank role_code="09">
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
				<xsl:if test="recipient_bank/abbv_name">
					<abbv_name>
						<xsl:value-of select="recipient_bank/abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="recipient_bank/name">
					<name>
						<xsl:value-of select="recipient_bank/name"/>
					</name>
				</xsl:if>
				<xsl:if test="recipient_bank/address_line_1">
					<address_line_1>
						<xsl:value-of select="recipient_bank/address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="recipient_bank/address_line_2">
					<address_line_2>
						<xsl:value-of select="recipient_bank/address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="recipient_bank/dom">
					<dom>
						<xsl:value-of select="recipient_bank/dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="recipient_bank/address_line_4">
					<address_line_4>
						<xsl:value-of select="recipient_bank/address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="recipient_bank/iso_code">
					<iso_code>
						<xsl:value-of select="recipient_bank/iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="recipient_bank/reference">
					<reference>
						<xsl:value-of select="recipient_bank/reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
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
				<xsl:if test="issuing_bank/abbv_name">
					<abbv_name>
						<xsl:value-of select="issuing_bank/abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="issuing_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="issuing_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="issuing_bank/name">
					<name>
						<xsl:value-of select="issuing_bank/name"/>
					</name>
				</xsl:if>
				<xsl:if test="issuing_bank_name">
					<name>
						<xsl:value-of select="issuing_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="issuing_bank/address_line_1">
					<address_line_1>
						<xsl:value-of select="issuing_bank/address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="issuing_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="issuing_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="issuing_bank/address_line_2">
					<address_line_2>
						<xsl:value-of select="issuing_bank/address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="issuing_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="issuing_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="issuing_bank/dom">
					<dom>
						<xsl:value-of select="issuing_bank/dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="issuing_bank_dom">
					<dom>
						<xsl:value-of select="issuing_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="issuing_bank/address_line_4">
					<address_line_4>
						<xsl:value-of select="issuing_bank/address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="issuing_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="issuing_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="issuing_bank/iso_code">
					<iso_code>
						<xsl:value-of select="issuing_bank/iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="issuing_bank_iso_code">
					<iso_code>
						<xsl:value-of select="issuing_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="issuing_bank/reference">
					<reference>
						<xsl:value-of select="issuing_bank/reference"/>
					</reference>
				</xsl:if>
				<xsl:if test="issuing_bank_reference">
					<reference>
						<xsl:value-of select="issuing_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateBank role_code="10">
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
				<xsl:if test="confirming_bank/abbv_name">
					<abbv_name>
						<xsl:value-of select="confirming_bank/abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="confirming_bank/name">
					<name>
						<xsl:value-of select="confirming_bank/name"/>
					</name>
				</xsl:if>
				<xsl:if test="confirming_bank/address_line_1">
					<address_line_1>
						<xsl:value-of select="confirming_bank/address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="confirming_bank/address_line_2">
					<address_line_2>
						<xsl:value-of select="confirming_bank/address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="confirming_bank/dom">
					<dom>
						<xsl:value-of select="confirming_bank/dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="confirming_bank/address_line_4">
					<address_line_4>
						<xsl:value-of select="confirming_bank/address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="confirming_bank/iso_code">
					<iso_code>
						<xsl:value-of select="confirming_bank/iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="confirming_bank/reference">
					<reference>
						<xsl:value-of select="confirming_bank/reference"/>
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
				<xsl:if test="advising_bank/abbv_name">
					<abbv_name>
						<xsl:value-of select="advising_bank/abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="advising_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="advising_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="advising_bank/name">
					<name>
						<xsl:value-of select="advising_bank/name"/>
					</name>
				</xsl:if>
				<xsl:if test="advising_bank_name">
					<name>
						<xsl:value-of select="advising_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="advising_bank/address_line_1">
					<address_line_1>
						<xsl:value-of select="advising_bank/address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="advising_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="advising_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="advising_bank/address_line_2">
					<address_line_2>
						<xsl:value-of select="advising_bank/address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="advising_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="advising_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="advising_bank/dom">
					<dom>
						<xsl:value-of select="advising_bank/dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="advising_bank_dom">
					<dom>
						<xsl:value-of select="advising_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="advising_bank/address_line_4">
					<address_line_4>
						<xsl:value-of select="advising_bank/address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="advising_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="advising_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="advising_bank/iso_code">
					<iso_code>
						<xsl:value-of select="advising_bank/iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="advising_bank_iso_code">
					<iso_code>
						<xsl:value-of select="advising_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="advising_bank/reference">
					<reference>
						<xsl:value-of select="advising_bank/reference"/>
					</reference>
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
				<xsl:if test="advisethru_bank/abbv_name">
					<abbv_name>
						<xsl:value-of select="advisethru_bank/abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="advise_thru_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="advise_thru_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="advisethru_bank/name">
					<name>
						<xsl:value-of select="advisethru_bank/name"/>
					</name>
				</xsl:if>
				<xsl:if test="advise_thru_bank_name">
					<name>
						<xsl:value-of select="advise_thru_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="advisethru_bank/address_line_1">
					<address_line_1>
						<xsl:value-of select="advisethru_bank/address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="advise_thru_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="advise_thru_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="advisethru_bank/address_line_2">
					<address_line_2>
						<xsl:value-of select="advisethru_bank/address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="advise_thru_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="advise_thru_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="advisethru_bank/dom">
					<dom>
						<xsl:value-of select="advisethru_bank/dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="advise_thru_bank_dom">
					<dom>
						<xsl:value-of select="advise_thru_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="advisethru_bank/address_line_4">
					<address_line_4>
						<xsl:value-of select="advisethru_bank/address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="advise_thru_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="advise_thru_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="advisethru_bank/iso_code">
					<iso_code>
						<xsl:value-of select="advisethru_bank/iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="advise_thru_bank_iso_code">
					<iso_code>
						<xsl:value-of select="advise_thru_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="advisethru_bank/reference">
					<reference>
						<xsl:value-of select="advisethru_bank/reference"/>
					</reference>
				</xsl:if>
				<xsl:if test="advise_thru_bank_reference">
					<reference>
						<xsl:value-of select="advise_thru_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateBank role_code="16">
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
				<xsl:if test="processing_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="processing_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="processing_bank_name">
					<name>
						<xsl:value-of select="processing_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="processing_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="processing_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="processing_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="processing_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="processing_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="processing_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="processing_bank_dom">
					<dom>
						<xsl:value-of select="processing_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="processing_bank_iso_code">
					<iso_code>
						<xsl:value-of select="processing_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="processing_bank_reference">
					<reference>
						<xsl:value-of select="processing_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateBank role_code="20">
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
				<xsl:if test="cu_recipient_bank/abbv_name">
					<abbv_name>
						<xsl:value-of select="cu_recipient_bank/abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="cu_recipient_bank/name">
					<name>
						<xsl:value-of select="cu_recipient_bank/name"/>
					</name>
				</xsl:if>
				<xsl:if test="cu_recipient_bank/address_line_1">
					<address_line_1>
						<xsl:value-of select="cu_recipient_bank/address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="cu_recipient_bank/address_line_2">
					<address_line_2>
						<xsl:value-of select="cu_recipient_bank/address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="cu_recipient_bank/dom">
					<dom>
						<xsl:value-of select="cu_recipient_bank/dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="cu_recipient_bank/address_line_4">
					<address_line_4>
						<xsl:value-of select="cu_recipient_bank/address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="cu_recipient_bank/iso_code">
					<iso_code>
						<xsl:value-of select="cu_recipient_bank/iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="cu_recipient_bank/reference">
					<reference>
						<xsl:value-of select="cu_recipient_bank/reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateBank role_code="04">
				<xsl:if test="template_id">
					<xsl:attribute name="template_id">
						<xsl:value-of select="template_id"/>
					</xsl:attribute>
				</xsl:if>
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
				<xsl:if test="credit_available_with_bank/abbv_name">
					<abbv_name>
						<xsl:value-of select="credit_available_with_bank/abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="credit_available_with_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="credit_available_with_bank/name">
					<name>
						<xsl:value-of select="credit_available_with_bank/name"/>
					</name>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_name">
					<name>
						<xsl:value-of select="credit_available_with_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="credit_available_with_bank/address_line_1">
					<address_line_1>
						<xsl:value-of select="credit_available_with_bank/address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="credit_available_with_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="credit_available_with_bank/address_line_2">
					<address_line_2>
						<xsl:value-of select="credit_available_with_bank/address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="credit_available_with_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="credit_available_with_bank/dom">
					<dom>
						<xsl:value-of select="credit_available_with_bank/dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_dom">
					<dom>
						<xsl:value-of select="credit_available_with_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="credit_available_with_bank/address_line_4">
					<address_line_4>
						<xsl:value-of select="credit_available_with_bank/address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="credit_available_with_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="credit_available_with_bank/iso_code">
					<iso_code>
						<xsl:value-of select="credit_available_with_bank/iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_iso_code">
					<iso_code>
						<xsl:value-of select="credit_available_with_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="credit_available_with_bank/reference">
					<reference>
						<xsl:value-of select="credit_available_with_bank/reference"/>
					</reference>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_reference">
					<reference>
						<xsl:value-of select="credit_available_with_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			
			<com.misys.portal.product.common.TemplateBank role_code="21">
				<xsl:if test="template_id">
					<xsl:attribute name="template_id">
						<xsl:value-of select="template_id"/>
					</xsl:attribute>
				</xsl:if>
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
				<xsl:if test="cu_credit_available_with_bank/abbv_name">
					<abbv_name>
						<xsl:value-of select="cu_credit_available_with_bank/abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="cu_credit_available_with_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="cu_credit_available_with_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="cu_credit_available_with_bank/name">
					<name>
						<xsl:value-of select="cu_credit_available_with_bank/name"/>
					</name>
				</xsl:if>
				<xsl:if test="cu_credit_available_with_bank_name">
					<name>
						<xsl:value-of select="cu_credit_available_with_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="cu_credit_available_with_bank/address_line_1">
					<address_line_1>
						<xsl:value-of select="cu_credit_available_with_bank/address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="cu_credit_available_with_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="cu_credit_available_with_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="cu_credit_available_with_bank/address_line_2">
					<address_line_2>
						<xsl:value-of select="cu_credit_available_with_bank/address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="cu_credit_available_with_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="cu_credit_available_with_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="cu_credit_available_with_bank/dom">
					<dom>
						<xsl:value-of select="cu_credit_available_with_bank/dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="cu_credit_available_with_bank_dom">
					<dom>
						<xsl:value-of select="cu_credit_available_with_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="cu_credit_available_with_bank/address_line_4">
					<address_line_4>
						<xsl:value-of select="cu_credit_available_with_bank/address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="cu_credit_available_with_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="cu_credit_available_with_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="cu_credit_available_with_bank/iso_code">
					<iso_code>
						<xsl:value-of select="cu_credit_available_with_bank/iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="cu_credit_available_with_bank_iso_code">
					<iso_code>
						<xsl:value-of select="cu_credit_available_with_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="cu_credit_available_with_bank/reference">
					<reference>
						<xsl:value-of select="cu_credit_available_with_bank/reference"/>
					</reference>
				</xsl:if>
				<xsl:if test="cu_credit_available_with_bank_reference">
					<reference>
						<xsl:value-of select="cu_credit_available_with_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
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
			<com.misys.portal.product.common.TemplateNarrative type_code="47">
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
				<xsl:if test="narrative_cancellation">
					<text>
						<xsl:value-of select="narrative_cancellation"/>
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
			<com.misys.portal.product.common.TemplateNarrative type_code="56">
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
				<xsl:if test="narrative_transfer_conditions_cu">
					<text>
						<xsl:value-of select="narrative_transfer_conditions_cu"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="59">
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
				<xsl:if test="narrative_cancellation_cu">
					<text>
						<xsl:value-of select="narrative_cancellation_cu"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="61">
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
				<xsl:if test="customer_contact_details">
					<text>
						<xsl:value-of select="customer_contact_details"/>
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
			<com.misys.portal.product.common.TemplateNarrative type_code="54">
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
				<xsl:if test="narrative_text_undertaking">
					<text>
						<xsl:value-of select="narrative_text_undertaking"/>
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
			<com.misys.portal.product.common.TemplateNarrative type_code="49">
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
				<xsl:if test="narrative_underlying_transaction_details">
					<text>
						<xsl:value-of select="narrative_underlying_transaction_details"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="50">
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
				<xsl:if test="narrative_presentation_instructions">
					<text>
						<xsl:value-of select="narrative_presentation_instructions"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="53">
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
				<xsl:if test="narrative_additional_amount_cu">
					<text>
						<xsl:value-of select="narrative_additional_amount_cu"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="51">
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
				<xsl:if test="narrative_undertaking_terms_and_conditions_cu">
					<text>
						<xsl:value-of select="narrative_undertaking_terms_and_conditions_cu"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="58">
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
				<xsl:if test="narrative_presentation_instructions_cu">
					<text>
						<xsl:value-of select="narrative_presentation_instructions_cu"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="55">
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
				<xsl:if test="narrative_underlying_transaction_details_cu">
					<text>
						<xsl:value-of select="narrative_underlying_transaction_details_cu"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
