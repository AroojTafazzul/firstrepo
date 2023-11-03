<?xml version="1.0"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com), All Rights Reserved. -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="lc_tnx_record">
		<lc_tnx_record>
			<xsl:copy-of select="@*"/>
			<xsl:if test="brch_code">
				<xsl:apply-templates select="brch_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ref_id">
				<xsl:apply-templates select="ref_id" mode="copy_element" />
			</xsl:if>
			<xsl:if test="template_id">
				<xsl:apply-templates select="template_id" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_ref_id">
				<xsl:apply-templates select="bo_ref_id" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_tnx_id">
				<xsl:apply-templates select="bo_tnx_id" mode="copy_element" />
			</xsl:if>
			<xsl:if test="cust_ref_id">
				<xsl:apply-templates select="cust_ref_id" mode="copy_element" />
			</xsl:if>
			<xsl:if test="tnx_id">
				<xsl:apply-templates select="tnx_id" mode="copy_element" />
			</xsl:if>
			<xsl:if test="company_id">
				<xsl:apply-templates select="company_id" mode="copy_element" />
			</xsl:if>
			<xsl:if test="company_name">
				<xsl:apply-templates select="company_name" mode="copy_element" />
			</xsl:if>
			<xsl:if test="adv_send_mode">
				<xsl:apply-templates select="adv_send_mode"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="tnx_type_code">
				<xsl:apply-templates select="tnx_type_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="sub_tnx_type_code">
				<xsl:apply-templates select="sub_tnx_type_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="prod_stat_code">
				<xsl:apply-templates select="prod_stat_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="tnx_stat_code">
				<xsl:apply-templates select="tnx_stat_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="product_code">
				<xsl:apply-templates select="product_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="sub_product_code">
				<xsl:apply-templates select="sub_product_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="inp_user_id">
				<xsl:apply-templates select="inp_user_id" mode="copy_element" />
			</xsl:if>
			<xsl:if test="inp_dttm">
				<xsl:apply-templates select="inp_dttm" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ctl_user_id">
				<xsl:apply-templates select="ctl_user_id" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ctl_dttm">
				<xsl:apply-templates select="ctl_dttm" mode="copy_element" />
			</xsl:if>
			<xsl:if test="release_user_id">
				<xsl:apply-templates select="release_user_id"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="release_dttm">
				<xsl:apply-templates select="release_dttm" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_inp_user_id">
				<xsl:apply-templates select="bo_inp_user_id"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_inp_dttm">
				<xsl:apply-templates select="bo_inp_dttm" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_ctl_user_id">
				<xsl:apply-templates select="bo_ctl_user_id"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_ctl_dttm">
				<xsl:apply-templates select="bo_ctl_dttm" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_release_user_id">
				<xsl:apply-templates select="bo_release_user_id"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_release_dttm">
				<xsl:apply-templates select="bo_release_dttm"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="tnx_val_date">
				<xsl:apply-templates select="tnx_val_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="appl_date">
				<xsl:apply-templates select="appl_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="iss_date">
				<xsl:apply-templates select="iss_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="exp_date">
				<xsl:apply-templates select="exp_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="amd_date">
				<xsl:apply-templates select="amd_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="amd_no">
				<xsl:apply-templates select="amd_no" mode="copy_element" />
			</xsl:if>
			<xsl:if test="last_ship_date">
				<xsl:apply-templates select="last_ship_date"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="tnx_cur_code">
				<xsl:apply-templates select="tnx_cur_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="tnx_amt">
				<xsl:apply-templates select="tnx_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_tnx_id">
				<xsl:apply-templates select="bo_tnx_id" mode="copy_element" />
			</xsl:if>
			<xsl:if test="lc_cur_code">
				<xsl:apply-templates select="lc_cur_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="lc_amt">
				<xsl:apply-templates select="lc_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="lc_liab_amt">
				<xsl:apply-templates select="lc_liab_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="lc_outstanding_amt">
				<xsl:apply-templates select="lc_outstanding_amt"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="lc_type">
				<xsl:apply-templates select="lc_type" mode="copy_element" />
			</xsl:if>
			<xsl:if test="beneficiary_abbv_name">
				<xsl:apply-templates select="beneficiary_abbv_name"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="beneficiary_name">
				<xsl:apply-templates select="beneficiary_name"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="beneficiary_address_line_1">
				<xsl:apply-templates select="beneficiary_address_line_1"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="beneficiary_address_line_2">
				<xsl:apply-templates select="beneficiary_address_line_2"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="beneficiary_dom">
				<xsl:apply-templates select="beneficiary_dom"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="beneficiary_country">
				<xsl:apply-templates select="beneficiary_country"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="beneficiary_reference">
				<xsl:apply-templates select="beneficiary_reference"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="applicant_abbv_name">
				<xsl:apply-templates select="applicant_abbv_name"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="applicant_name">
				<xsl:apply-templates select="applicant_name"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="applicant_address_line_1">
				<xsl:apply-templates select="applicant_address_line_1"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="applicant_address_line_2">
				<xsl:apply-templates select="applicant_address_line_2"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="applicant_dom">
				<xsl:apply-templates select="applicant_dom"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="applicant_country">
				<xsl:apply-templates select="applicant_country"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="applicant_reference">
				<xsl:apply-templates select="applicant_reference"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="entity">
				<xsl:apply-templates select="entity" mode="copy_element" />
			</xsl:if>
			<xsl:if test="expiry_place">
				<xsl:apply-templates select="expiry_place" mode="copy_element" />
			</xsl:if>
			<xsl:if test="inco_term">
				<xsl:apply-templates select="inco_term" mode="copy_element" />
			</xsl:if>
			<xsl:if test="inco_place">
				<xsl:apply-templates select="inco_place" mode="copy_element" />
			</xsl:if>
			<xsl:if test="part_ship_detl">
				<xsl:apply-templates select="part_ship_detl"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="tran_ship_detl">
				<xsl:apply-templates select="tran_ship_detl"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="ship_from">
				<xsl:apply-templates select="ship_from" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ship_loading">
				<xsl:apply-templates select="ship_loading" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ship_discharge">
				<xsl:apply-templates select="ship_discharge"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="ship_to">
				<xsl:apply-templates select="ship_to" mode="copy_element" />
			</xsl:if>
			<xsl:if test="draft_term">
				<xsl:apply-templates select="draft_term" mode="copy_element" />
			</xsl:if>
			<xsl:if test="cty_of_dest">
				<xsl:apply-templates select="cty_of_dest" mode="copy_element" />
			</xsl:if>
			<xsl:if test="rvlv_lc_type_code">
				<xsl:apply-templates select="rvlv_lc_type_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="max_no_of_rvlv">
				<xsl:apply-templates select="max_no_of_rvlv"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="neg_tol_pct">
				<xsl:apply-templates select="neg_tol_pct" mode="copy_element" />
			</xsl:if>
			<xsl:if test="pstv_tol_pct">
				<xsl:apply-templates select="pstv_tol_pct" mode="copy_element" />
			</xsl:if>
			<xsl:if test="max_cr_desc_code">
				<xsl:apply-templates select="max_cr_desc_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="cr_avl_by_code">
				<xsl:apply-templates select="cr_avl_by_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="dir_reim_flag">
				<xsl:apply-templates select="dir_reim_flag"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="irv_flag">
				<xsl:apply-templates select="irv_flag" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ntrf_flag">
				<xsl:apply-templates select="ntrf_flag" mode="copy_element" />
			</xsl:if>
			<xsl:if test="stnd_by_lc_flag">
				<xsl:apply-templates select="stnd_by_lc_flag"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="cfm_inst_code">
				<xsl:apply-templates select="cfm_inst_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="req_conf_party_flag">
				<xsl:apply-templates select="req_conf_party_flag"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="cfm_flag">
				<xsl:apply-templates select="cfm_flag" mode="copy_element" />
			</xsl:if>
			<xsl:if test="cfm_chrg_brn_by_code">
				<xsl:apply-templates select="cfm_chrg_brn_by_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="corr_chrg_brn_by_code">
				<xsl:apply-templates select="corr_chrg_brn_by_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="open_chrg_brn_by_code">
				<xsl:apply-templates select="open_chrg_brn_by_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="amd_chrg_brn_by_code">
				<xsl:apply-templates select="amd_chrg_brn_by_code"
					mode="copy_element" />
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

			<xsl:if test="additional_field[@name='renew_flag']">
				<xsl:apply-templates select="/node()/additional_field[@name='renew_flag']"
					mode="add_to_element" />
			</xsl:if>
			<xsl:if test="additional_field[@name='renew_on_code']">
				<xsl:apply-templates
					select="/node()/additional_field[@name='renew_on_code']" mode="add_to_element" />
			</xsl:if>
			<xsl:if test="additional_field[@name='renewal_calendar_date']">
				<xsl:apply-templates
					select="/node()/additional_field[@name='renewal_calendar_date']"
					mode="add_to_element" />
			</xsl:if>
			<xsl:if test="additional_field[@name='renew_for_nb']">
				<xsl:apply-templates
					select="/node()/additional_field[@name='renew_for_nb']" mode="add_to_element" />
			</xsl:if>
			<xsl:if test="additional_field[@name='renew_for_period']">
				<xsl:apply-templates
					select="/node()/additional_field[@name='renew_for_period']" mode="add_to_element" />
			</xsl:if>
			<xsl:if test="additional_field[@name='advise_renewal_flag']">
				<xsl:apply-templates
					select="/node()/additional_field[@name='advise_renewal_flag']"
					mode="add_to_element" />
			</xsl:if>
			<xsl:if test="additional_field[@name='advise_renewal_days_nb']">
				<xsl:apply-templates
					select="/node()/additional_field[@name='advise_renewal_days_nb']"
					mode="add_to_element" />
			</xsl:if>
			<xsl:if test="additional_field[@name='rolling_renewal_flag']">
				<xsl:apply-templates
					select="/node()/additional_field[@name='rolling_renewal_flag']"
					mode="add_to_element" />
			</xsl:if>
			<xsl:if test="additional_field[@name='rolling_renewal_nb']">
				<xsl:apply-templates
					select="/node()/additional_field[@name='rolling_renewal_nb']" mode="add_to_element" />
			</xsl:if>
			<xsl:if test="additional_field[@name='rolling_cancellation_days']">
				<xsl:apply-templates
					select="/node()/additional_field[@name='rolling_cancellation_days']"
					mode="add_to_element" />
			</xsl:if>
			<xsl:if test="additional_field[@name='renew_amt_code']">
				<xsl:apply-templates
					select="/node()/additional_field[@name='renew_amt_code']" mode="add_to_element" />
			</xsl:if>


			<xsl:if test="principal_act_no">
				<xsl:apply-templates select="principal_act_no"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="fee_act_no">
				<xsl:apply-templates select="fee_act_no" mode="copy_element" />
			</xsl:if>
			<xsl:if test="eucp_flag">
				<xsl:apply-templates select="eucp_flag" mode="copy_element" />
			</xsl:if>
			<xsl:if test="eucp_version">
				<xsl:apply-templates select="eucp_version" mode="copy_element" />
			</xsl:if>
			<xsl:if test="eucp_presentation_place">
				<xsl:apply-templates select="eucp_presentation_place"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="maturity_date">
				<xsl:apply-templates select="maturity_date"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="latest_answer_date">
				<xsl:apply-templates select="latest_answer_date"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="applicable_rules">
				<xsl:apply-templates select="applicable_rules"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="applicable_rules_text">
				<xsl:apply-templates select="applicable_rules_text"
					mode="copy_element" />
			</xsl:if>

			<!-- Revolving LC Details : START -->
			<xsl:if test="revolving_flag">
				<xsl:apply-templates select="revolving_flag"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="revolve_period">
				<xsl:apply-templates select="revolve_period"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="revolve_frequency">
				<xsl:apply-templates select="revolve_frequency"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="revolve_time_no">
				<xsl:apply-templates select="revolve_time_no"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="cumulative_flag">
				<xsl:apply-templates select="cumulative_flag"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="next_revolve_date">
				<xsl:apply-templates select="next_revolve_date"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="notice_days">
				<xsl:apply-templates select="notice_days"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="charge_upto">
				<xsl:apply-templates select="charge_upto"
					mode="copy_element" />
			</xsl:if>
			<!-- Revolving LC Details : END -->		

			<!-- Alternative Applicant Party details -->
			<xsl:if test="alt_applicant_name">
				<xsl:apply-templates select="alt_applicant_name"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="alt_applicant_address_line_1">
				<xsl:apply-templates select="alt_applicant_address_line_1"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="alt_applicant_address_line_2">
				<xsl:apply-templates select="alt_applicant_address_line_2"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="alt_applicant_dom">
				<xsl:apply-templates select="alt_applicant_dom"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="alt_applicant_country">
				<xsl:apply-templates select="alt_applicant_country"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="for_account_flag">
				<xsl:apply-templates select="for_account_flag"
					mode="copy_element"/>
			</xsl:if>
			<xsl:if test="period_presentation_days">
				<xsl:apply-templates select="period_presentation_days"
					mode="copy_element"/>
			</xsl:if>
			<xsl:if test="alt_applicant_cust_ref">
				<xsl:apply-templates select="alt_applicant_cust_ref"
					mode="copy_element"/>
			</xsl:if>
			<xsl:if test="additional_field[@name='advising_bank_lc_ref_id']">
				<xsl:apply-templates
					select="/node()/additional_field[@name='advising_bank_lc_ref_id']"
					mode="add_to_element" />
			</xsl:if>
			<xsl:if test="additional_field[@name='tenor_type']">
				<xsl:apply-templates select="/node()/additional_field[@name='tenor_type']"
					mode="add_to_element" />
			</xsl:if>
			<xsl:if test="additional_field[@name='tenor_maturity_date']">
				<xsl:apply-templates
					select="/node()/additional_field[@name='tenor_maturity_date']"
					mode="add_to_element" />
			</xsl:if>
			<xsl:if test="additional_field[@name='tenor_days']">
				<xsl:apply-templates select="/node()/additional_field[@name='tenor_days']"
					mode="add_to_element" />
			</xsl:if>
			<xsl:if test="additional_field[@name='tenor_period']">
				<xsl:apply-templates
					select="/node()/additional_field[@name='tenor_period']" mode="add_to_element" />
			</xsl:if>
			<xsl:if test="additional_field[@name='tenor_from_after']">
				<xsl:apply-templates
					select="/node()/additional_field[@name='tenor_from_after']" mode="add_to_element" />
			</xsl:if>
			<xsl:if test="additional_field[@name='tenor_days_type']">
				<xsl:apply-templates
					select="/node()/additional_field[@name='tenor_days_type']" mode="add_to_element" />
			</xsl:if>
			<xsl:if test="additional_field[@name='tenor_type_details']">
				<xsl:apply-templates
					select="/node()/additional_field[@name='tenor_type_details']" mode="add_to_element" />
			</xsl:if>



			<xsl:if test="issuing_bank">
				<xsl:apply-templates select="issuing_bank" mode="copy_element" />
			</xsl:if>
			<xsl:if test="advising_bank">
				<xsl:apply-templates select="advising_bank"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="advise_thru_bank">
				<xsl:apply-templates select="advise_thru_bank"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="credit_available_with_bank">
				<xsl:apply-templates select="credit_available_with_bank"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="drawee_details_bank">
				<xsl:apply-templates select="drawee_details_bank"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="requested_confirmation_party">
				<xsl:apply-templates select="requested_confirmation_party"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_description_goods">
				<xsl:apply-templates select="narrative_description_goods"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_documents_required">
				<xsl:apply-templates select="narrative_documents_required"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_additional_instructions">
				<xsl:apply-templates select="narrative_additional_instructions"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_special_beneficiary">
				<xsl:apply-templates select="narrative_special_beneficiary"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_special_recvbank">
				<xsl:apply-templates select="narrative_special_recvbank"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_charges">
				<xsl:apply-templates select="narrative_charges"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_additional_amount">
				<xsl:apply-templates select="narrative_additional_amount"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_payment_instructions">
				<xsl:apply-templates select="narrative_payment_instructions"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_period_presentation">
				<xsl:apply-templates select="narrative_period_presentation"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_amend_charges_other">
				<xsl:apply-templates select="narrative_amend_charges_other"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="fwd_contract_no">
				<xsl:apply-templates select="fwd_contract_no"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_shipment_period">
				<xsl:apply-templates select="narrative_shipment_period"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_sender_to_receiver">
				<xsl:apply-templates select="narrative_sender_to_receiver"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_full_details">
				<xsl:apply-templates select="narrative_full_details"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_comment">
				<xsl:apply-templates select="bo_comment" mode="copy_element" />
			</xsl:if>
			<xsl:if test="free_format_text">
				<xsl:apply-templates select="free_format_text"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="amd_details">
				<xsl:apply-templates select="amd_details" mode="copy_element" />
			</xsl:if>
			<xsl:if test="charges">
				<xsl:apply-templates select="charges" mode="copy_element" />
			</xsl:if>
			<xsl:if test="transport_mode">
				<xsl:apply-templates select="transport_mode" mode="copy_element" />
			</xsl:if>
			<xsl:if test="attachments">
				<xsl:apply-templates select="attachments" mode="copy_element" />
			</xsl:if>
			<xsl:if test="linked_licenses">
				<xsl:apply-templates select="linked_licenses" mode="copy_element" />
			</xsl:if>			
			<xsl:choose>
				<xsl:when test="cross_references">
					<xsl:apply-templates select="cross_references" mode="copy_element" />
				</xsl:when>
				<xsl:otherwise>					
					<xsl:call-template name="cross_ref"></xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="additional_field">
				<xsl:apply-templates select="additional_field" mode="copy_additional">
					<xsl:with-param name="ignoreAdditional">
					advising_bank_lc_ref_id,tenor_type,tenor_maturity_date,tenor_days,tenor_period,tenor_from_after,tenor_days_type,tenor_type_details,					
					renew_flag,renew_on_code,renewal_calendar_date,renew_for_nb,renew_for_period,advise_renewal_flag,advise_renewal_days_nb,
					rolling_renewal_flag,rolling_renewal_nb,rolling_cancellation_days,renew_amt_code
					</xsl:with-param>
				</xsl:apply-templates>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="prod_stat_code='12'">
					<action_req_code>12</action_req_code>
				</xsl:when>
				<xsl:when test="prod_stat_code[.='78' or .='79' or .='84' or .='98'] and action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code"/>
					</action_req_code>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="claim_cur_code">
				<xsl:apply-templates select="claim_cur_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="claim_amt">
				<xsl:apply-templates select="claim_amt"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="claim_reference">
				<xsl:apply-templates select="claim_reference"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="claim_present_date">
				<xsl:apply-templates select="claim_present_date"
					mode="copy_element" />
			</xsl:if>
		</lc_tnx_record>
	</xsl:template>



</xsl:stylesheet>