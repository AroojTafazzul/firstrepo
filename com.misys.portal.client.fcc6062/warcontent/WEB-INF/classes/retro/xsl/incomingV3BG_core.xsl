<?xml version="1.0"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com), All Rights Reserved. -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="bg_tnx_record">
		<bg_tnx_record>
			<xsl:copy-of select="@*" />
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
			<xsl:if test="appl_date">
				<xsl:apply-templates select="appl_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="tnx_val_date">
				<xsl:apply-templates select="tnx_val_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="iss_date_type_code">
				<xsl:apply-templates select="iss_date_type_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="iss_date_type_details">
				<xsl:apply-templates select="iss_date_type_details"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="iss_date">
				<xsl:apply-templates select="iss_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="exp_date_type_code">
				<xsl:apply-templates select="exp_date_type_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="exp_date">
				<xsl:apply-templates select="exp_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="exp_event">
				<xsl:apply-templates select="exp_event" mode="copy_element" />
			</xsl:if>
			<xsl:if test="amd_no">
				<xsl:apply-templates select="amd_no" mode="copy_element" />
			</xsl:if>
			<xsl:if test="amd_date">
				<xsl:apply-templates select="amd_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="tnx_cur_code">
				<xsl:apply-templates select="tnx_cur_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="tnx_amt">
				<xsl:apply-templates select="tnx_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bg_cur_code">
				<xsl:apply-templates select="bg_cur_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bg_amt">
				<xsl:apply-templates select="bg_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bg_liab_amt">
				<xsl:apply-templates select="bg_liab_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bg_outstanding_amt">
				<xsl:apply-templates select="bg_outstanding_amt"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="bg_type_code">
				<xsl:apply-templates select="bg_type_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="text_type_code">
				<xsl:apply-templates select="text_type_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="bg_type_details">
				<xsl:apply-templates select="bg_type_details"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="bg_rule">
				<xsl:apply-templates select="bg_rule" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bg_rule_other">
				<xsl:apply-templates select="bg_rule_other" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bg_text_type_code">
				<xsl:apply-templates select="bg_text_type_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="bg_text_type_details">
				<xsl:apply-templates select="bg_text_type_details"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="bg_release_flag">
				<xsl:apply-templates select="bg_release_flag"
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
			<xsl:if test="issuing_bank_type_code">
				<xsl:apply-templates select="issuing_bank_type_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="adv_send_mode">
				<xsl:apply-templates select="adv_send_mode"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="contract_ref">
				<xsl:apply-templates select="contract_ref" mode="copy_element" />
			</xsl:if>
			<xsl:if test="contract_narrative">
				<xsl:apply-templates select="contract_narrative" mode="copy_element" />
			</xsl:if>
			<xsl:if test="tender_expiry_date">
				<xsl:apply-templates select="tender_expiry_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="contract_date">
				<xsl:apply-templates select="contract_date"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="contract_amt">
				<xsl:apply-templates select="contract_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="contract_cur_code">
				<xsl:apply-templates select="contract_cur_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="contract_pct">
				<xsl:apply-templates select="contract_pct" mode="copy_element" />
			</xsl:if>
			<xsl:if test="principal_act_no">
				<xsl:apply-templates select="principal_act_no"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="fee_act_no">
				<xsl:apply-templates select="fee_act_no" mode="copy_element" />
			</xsl:if>
			<xsl:if test="text_language">
				<xsl:apply-templates select="text_language"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="text_language_other">
				<xsl:apply-templates select="text_language_other"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="bg_text_details_code">
				<xsl:apply-templates select="bg_text_details_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="bg_code">
				<xsl:apply-templates select="bg_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="lead_bank_flag">
				<xsl:apply-templates select="lead_bank_flag" mode="copy_element" />
			</xsl:if>
			<!-- Start: Renewal Details -->
			<xsl:if test="renew_flag">
				<xsl:apply-templates select="renew_flag"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="renew_on_code">
				<xsl:apply-templates select="renew_on_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="renewal_calendar_date">
				<xsl:apply-templates select="renewal_calendar_date"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="renew_for_nb">
				<xsl:apply-templates select="renew_for_nb"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="renew_for_period">
				<xsl:apply-templates select="renew_for_period"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="advise_renewal_flag">
				<xsl:apply-templates select="advise_renewal_flag"
					mode="copy_element" />
			</xsl:if>
			
			<xsl:if test="advise_renewal_days_nb">
				<xsl:apply-templates select="advise_renewal_days_nb"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="rolling_renewal_flag">
				<xsl:apply-templates select="rolling_renewal_flag"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="rolling_renew_on_code">
				<xsl:apply-templates select="rolling_renew_on_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="rolling_renew_for_nb">
				<xsl:apply-templates select="rolling_renew_for_nb"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="rolling_renew_for_period">
				<xsl:apply-templates select="rolling_renew_for_period"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="rolling_day_in_month">
				<xsl:apply-templates select="rolling_day_in_month"
					mode="copy_element" />
			</xsl:if>			
			<xsl:if test="rolling_renewal_nb">
				<xsl:apply-templates select="rolling_renewal_nb"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="rolling_cancellation_days">
				<xsl:apply-templates select="rolling_cancellation_days"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="renew_amt_code">
				<xsl:apply-templates select="renew_amt_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="final_expiry_date">
				<xsl:apply-templates select="final_expiry_date"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="projected_expiry_date">
				<xsl:apply-templates select="projected_expiry_date"
					mode="copy_element" />
			</xsl:if>	
			
		<!-- End: Renewal Details -->
			
			<xsl:if test="recipient_bank">
				<xsl:apply-templates select="recipient_bank"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="issuing_bank">
				<xsl:apply-templates select="issuing_bank" mode="copy_element" />
			</xsl:if>
			<xsl:if test="confirming_bank">
				<xsl:apply-templates select="confirming_bank"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="advising_bank">
				<xsl:apply-templates select="advising_bank"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="processing_bank">
				<xsl:apply-templates select="processing_bank"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_additional_instructions">
				<xsl:apply-templates select="narrative_additional_instructions"
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
			<xsl:if test="bg_document">
				<xsl:apply-templates select="bg_document" mode="copy_element" />
			</xsl:if>
			<xsl:if test="charges">
				<xsl:apply-templates select="charges" mode="copy_element" />
			</xsl:if>
			<xsl:if test="open_chrg_brn_by_code">
				<xsl:apply-templates select="open_chrg_brn_by_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="corr_chrg_brn_by_code">
				<xsl:apply-templates select="corr_chrg_brn_by_code" mode="copy_element" />
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
				<xsl:apply-templates select="additional_field"
					mode="copy_element" />
			</xsl:if>
			<xsl:choose>
				<xsl:when test="prod_stat_code='12'">
					<action_req_code>12</action_req_code>
				</xsl:when>
				<!-- Commented as Amend and Cancel beneficiary response to be handled in Portal -->
				<!-- <xsl:when test="prod_stat_code='31'">
						<action_req_code>03</action_req_code>
				</xsl:when>
				<xsl:when test="prod_stat_code='81'">
					<action_req_code>05</action_req_code>
				</xsl:when> -->
				<xsl:when test="prod_stat_code[.='78' or .='79' or .='84' or .='98'] and action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code"/>
					</action_req_code>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="contact_name">
				<xsl:apply-templates select="contact_name"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="contact_address_line_1">
				<xsl:apply-templates select="contact_address_line_1"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="contact_address_line_2">
				<xsl:apply-templates select="contact_address_line_2"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="contact_dom">
				<xsl:apply-templates select="contact_dom"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="contact_country">
				<xsl:apply-templates select="contact_country"
					mode="copy_element" />
			</xsl:if>
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
		</bg_tnx_record>
	</xsl:template>



</xsl:stylesheet>