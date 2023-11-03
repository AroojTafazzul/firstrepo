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
	<!-- Process BG-->
	<xsl:template match="bg_tnx_record">
		<result>
			<com.misys.portal.product.bg.common.BankerGuarantee>
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>

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
				<xsl:if test="release_amt">
					<release_amt>
						<xsl:value-of select="release_amt"/>
					</release_amt>
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
				<xsl:if test="beneficiary_dom">
					<beneficiary_dom>
						<xsl:value-of select="beneficiary_dom"/>
					</beneficiary_dom>
				</xsl:if>
				<xsl:if test="beneficiary_address_line_4">
					<beneficiary_address_line_4>
						<xsl:value-of select="beneficiary_address_line_4"/>
					</beneficiary_address_line_4>
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
				<xsl:if test="applicant_dom">
					<applicant_dom>
						<xsl:value-of select="applicant_dom"/>
					</applicant_dom>
				</xsl:if>
				<xsl:if test="applicant_address_line_4">
					<applicant_address_line_4>
						<xsl:value-of select="applicant_address_line_4"/>
					</applicant_address_line_4>
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
				<xsl:if test="contact_dom">
					<contact_dom>
						<xsl:value-of select="contact_dom"/>
					</contact_dom>
				</xsl:if>
				<xsl:if test="contact_address_line_4">
					<contact_address_line_4>
						<xsl:value-of select="contact_address_line_4"/>
					</contact_address_line_4>
				</xsl:if>
				<xsl:if test="contact_country">
					<contact_country>
						<xsl:value-of select="contact_country"/>
					</contact_country>
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
				<xsl:if test="alt_applicant_dom">
					<alt_applicant_dom>
						<xsl:value-of select="alt_applicant_dom"/>
					</alt_applicant_dom>
				</xsl:if>
				<xsl:if test="alt_applicant_address_line_4">
					<alt_applicant_address_line_4>
						<xsl:value-of select="alt_applicant_address_line_4"/>
					</alt_applicant_address_line_4>
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
				<xsl:if test="adv_send_mode_text">
					<adv_send_mode_text>
						<xsl:value-of select="adv_send_mode_text"/>
					</adv_send_mode_text>
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
				<xsl:if test="net_exposure_cur_code">
					<net_exposure_cur_code>
						<xsl:value-of select="net_exposure_cur_code"/>
					</net_exposure_cur_code>
				</xsl:if>
				<xsl:if test="net_exposure_amt">
					<net_exposure_amt>
						<xsl:value-of select="net_exposure_amt"/>
					</net_exposure_amt>
				</xsl:if>
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
				<xsl:if test="delivery_channel">
					<delivery_channel>
						<xsl:value-of select="delivery_channel"/>
					</delivery_channel>
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
				
			<xsl:if test="rolling_day_in_month">
					<rolling_day_in_month>
						<xsl:value-of select="rolling_day_in_month"/>
					</rolling_day_in_month>
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
				
				<!-- Renewal details added  END -->
				
				<!-- Previous ctl date, used for synchronisation issues -->
				<xsl:if test="old_ctl_dttm">
					<additional_field name="old_ctl_dttm" type="time" scope="none" description=" Previous control date used for synchronisation issues">
						<xsl:value-of select="old_ctl_dttm"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="document_id">
					<additional_field name="document_id" type="string" scope="master">
						<xsl:value-of select="document_id"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="parent_ref_id">
					<additional_field name="parent_ref_id"
				type="string" scope="master">
						<xsl:value-of select="parent_ref_id"/>
					</additional_field>
				</xsl:if>
				<!-- Previous input date, used to know if the product is already saved -->
				<xsl:if test="old_inp_dttm">
					<additional_field name="old_inp_dttm" type="time" scope="none" description="Previous input date used for synchronisation issues">
						<xsl:value-of select="old_inp_dttm"/>
					</additional_field>
				</xsl:if>
				<!-- Security -->
				<xsl:if test="token">
					<additional_field name="token" type="string" scope="none" description="Security token">
						<xsl:value-of select="token"/>
					</additional_field>
				</xsl:if>
				<!-- Domestic Guarantees -->
				<xsl:if test="form_mask">
					<additional_field name="form_mask" scope="master" type="string">
						<xsl:value-of select="form_mask"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="extend_pay_date">
					<additional_field name="extend_pay_date" type="date" scope="master" description="Extend or Pay date">
						<xsl:value-of select="extend_pay_date" />
					</additional_field>
				</xsl:if>
				
				<xsl:if test="latest_date_reply">
					<additional_field name="latest_date_reply" type="date" scope="master" description="Latest Date for Reply">
						<xsl:value-of select="latest_date_reply" />
					</additional_field>
				</xsl:if>
				<!-- Re authentication -->
				<xsl:call-template name="AUTHENTICATION"/>
				<!-- collaboration -->
				<xsl:call-template name="collaboration" />
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.product.bg.common.BankerGuarantee>
			<com.misys.portal.product.common.Bank role_code="09">
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
				<xsl:if test="recipient_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="recipient_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="recipient_bank_name">
					<name>
						<xsl:value-of select="recipient_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="recipient_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="recipient_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="recipient_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="recipient_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="recipient_bank_dom">
					<dom>
						<xsl:value-of select="recipient_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="recipient_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="recipient_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="recipient_bank_iso_code">
					<iso_code>
						<xsl:value-of select="recipient_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="recipient_bank_reference">
					<reference>
						<xsl:value-of select="recipient_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Bank role_code="01">
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
				<xsl:if test="issuing_bank_dom">
					<dom>
						<xsl:value-of select="issuing_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="issuing_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="issuing_bank_address_line_4"/>
					</address_line_4>
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
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Bank role_code="10">
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
				<xsl:if test="confirming_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="confirming_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="confirming_bank_name">
					<name>
						<xsl:value-of select="confirming_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="confirming_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="confirming_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="confirming_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="confirming_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="confirming_bank_dom">
					<dom>
						<xsl:value-of select="confirming_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="confirming_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="confirming_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="confirming_bank_iso_code">
					<iso_code>
						<xsl:value-of select="confirming_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="confirming_bank_reference">
					<reference>
						<xsl:value-of select="confirming_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Bank role_code="02">
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
				<xsl:if test="advising_bank_dom">
					<dom>
						<xsl:value-of select="advising_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="advising_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="advising_bank_address_line_4"/>
					</address_line_4>
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
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Bank role_code="16">
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
				<xsl:if test="processing_bank_dom">
					<dom>
						<xsl:value-of select="processing_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="processing_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="processing_bank_address_line_4"/>
					</address_line_4>
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
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.LimitProduct>
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
				<xsl:if test="facility_id">
					<facility_id>
						<xsl:value-of select="facility_id"/>
					</facility_id>
				</xsl:if>
				<xsl:if test="facility_reference">
					<facility_reference>
						<xsl:value-of select="facility_reference"/>
					</facility_reference>
				</xsl:if>
				<xsl:if test="limit_id">
					<limit_id>
						<xsl:value-of select="limit_id"/>
					</limit_id>
				</xsl:if>
				<xsl:if test="limit_reference">
					<limit_reference>
						<xsl:value-of select="limit_reference"/>
					</limit_reference>
				</xsl:if>
				<xsl:if test="booking_cur_code">
					<cur_code>
						<xsl:value-of select="booking_cur_code"/>
					</cur_code>
				</xsl:if>
				<xsl:if test="booking_amt">
					<booking_amt>
						<xsl:value-of select="booking_amt"/>
					</booking_amt>
				</xsl:if>
			</com.misys.portal.product.common.LimitProduct>
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
			<com.misys.portal.product.common.Narrative type_code="18">
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
				<xsl:if test="bg_document">
					<text>
						<xsl:value-of select="bg_document"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
						
			<!-- Create Charge element -->
			
			<!-- First, those charges belonging to the current transaction -->
			<xsl:for-each select="//*[starts-with(name(), 'charge_details_chrg_details_')]">
				<xsl:call-template name="CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//bg_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//bg_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//bg_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//bg_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'charge_details_chrg_details_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!-- Second, the charges inputted earlier -->
			<xsl:for-each select="//*[starts-with(name(), 'old_charge_details_position_')]">
				<xsl:call-template name="OLD_CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//bg_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//bg_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//bg_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//bg_tnx_record/tnx_id"/></xsl:with-param>
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