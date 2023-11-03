<?xml version="1.0"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com), All Rights Reserved. -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="ec_tnx_record">
		<ec_tnx_record>
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
			<xsl:if test="bo_ctl_dttm">
				<xsl:apply-templates select="bo_ctl_dttm" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_ctl_user_id">
				<xsl:apply-templates select="bo_ctl_user_id"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_release_dttm">
				<xsl:apply-templates select="bo_release_dttm"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_release_user_id">
				<xsl:apply-templates select="bo_release_user_id"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="appl_date">
				<xsl:apply-templates select="appl_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="tnx_val_date">
				<xsl:apply-templates select="tnx_val_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="tnx_cur_code">
				<xsl:apply-templates select="tnx_cur_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="tnx_amt">
				<xsl:apply-templates select="tnx_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ec_cur_code">
				<xsl:apply-templates select="ec_cur_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ec_amt">
				<xsl:apply-templates select="ec_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ec_liab_amt">
				<xsl:apply-templates select="ec_liab_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ec_outstanding_amt">
				<xsl:apply-templates select="ec_outstanding_amt"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="ec_type_code">
				<xsl:apply-templates select="ec_type_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="drawee_abbv_name">
				<xsl:apply-templates select="drawee_abbv_name"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="drawee_name">
				<xsl:apply-templates select="drawee_name" mode="copy_element" />
			</xsl:if>
			<xsl:if test="drawee_address_line_1">
				<xsl:apply-templates select="drawee_address_line_1"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="drawee_address_line_2">
				<xsl:apply-templates select="drawee_address_line_2"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="drawee_dom">
				<xsl:apply-templates select="drawee_dom" mode="copy_element" />
			</xsl:if>
			<xsl:if test="drawee_country">
				<xsl:apply-templates select="drawee_country"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="drawee_reference">
				<xsl:apply-templates select="drawee_reference"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="drawer_abbv_name">
				<xsl:apply-templates select="drawer_abbv_name"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="drawer_name">
				<xsl:apply-templates select="drawer_name" mode="copy_element" />
			</xsl:if>
			<xsl:if test="drawer_address_line_1">
				<xsl:apply-templates select="drawer_address_line_1"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="drawer_address_line_2">
				<xsl:apply-templates select="drawer_address_line_2"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="drawer_dom">
				<xsl:apply-templates select="drawer_dom" mode="copy_element" />
			</xsl:if>
			<xsl:if test="drawer_country">
				<xsl:apply-templates select="drawer_country"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="drawer_reference">
				<xsl:apply-templates select="drawer_reference"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="entity">
				<xsl:apply-templates select="entity" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bol_number">
				<xsl:apply-templates select="bol_number" mode="copy_element" />
			</xsl:if>
			<xsl:if test="shipping_mode">
				<xsl:apply-templates select="shipping_mode"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="shipping_by">
				<xsl:apply-templates select="shipping_by" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ship_from">
				<xsl:apply-templates select="ship_from" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ship_to">
				<xsl:apply-templates select="ship_to" mode="copy_element" />
			</xsl:if>
			<xsl:if test="inco_term">
				<xsl:apply-templates select="inco_term" mode="copy_element" />
			</xsl:if>
			<xsl:if test="inco_place">
				<xsl:apply-templates select="inco_place" mode="copy_element" />
			</xsl:if>
			<xsl:if test="term_code">
				<xsl:apply-templates select="term_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="docs_send_mode">
				<xsl:apply-templates select="docs_send_mode"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="accpt_adv_send_mode">
				<xsl:apply-templates select="accpt_adv_send_mode"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="protest_non_paymt">
				<xsl:apply-templates select="protest_non_paymt"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="protest_non_accpt">
				<xsl:apply-templates select="protest_non_accpt"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="protest_adv_send_mode">
				<xsl:apply-templates select="protest_adv_send_mode"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="accpt_defd_flag">
				<xsl:apply-templates select="accpt_defd_flag"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="store_goods_flag">
				<xsl:apply-templates select="store_goods_flag"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="paymt_adv_send_mode">
				<xsl:apply-templates select="paymt_adv_send_mode"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="tenor_desc">
				<xsl:apply-templates select="tenor_desc" mode="copy_element" />
			</xsl:if>
			<xsl:if test="tenor">
				<xsl:apply-templates select="tenor" mode="copy_element" />
			</xsl:if>
			<xsl:if test="tenor_unit">
				<xsl:apply-templates select="tenor_unit" mode="copy_element" />
			</xsl:if>
			<xsl:if test="tenor_event">
				<xsl:apply-templates select="tenor_event" mode="copy_element" />
			</xsl:if>
			<xsl:if test="tenor_start_date">
				<xsl:apply-templates select="tenor_start_date"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="tenor_maturity_date">
				<xsl:apply-templates select="tenor_maturity_date"
					mode="copy_element" />
			</xsl:if>
			
			<xsl:if test="tenor_base_date">
				<xsl:apply-templates select="tenor_base_date"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="tenor_type">
				<xsl:apply-templates select="tenor_type"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="tenor_days">
				<xsl:apply-templates select="tenor_days"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="tenor_period">
				<xsl:apply-templates select="tenor_period"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="tenor_from_after">
				<xsl:apply-templates select="tenor_from_after"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="tenor_days_type">
				<xsl:apply-templates select="tenor_days_type"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="tenor_type_details">
				<xsl:apply-templates select="tenor_type_details"
					mode="copy_element" />
			</xsl:if>
			
			<xsl:if test="open_chrg_brn_by_code">
				<xsl:apply-templates select="open_chrg_brn_by_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="corr_chrg_brn_by_code">
				<xsl:apply-templates select="corr_chrg_brn_by_code"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="waive_chrg_flag">
				<xsl:apply-templates select="waive_chrg_flag"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="int_rate">
				<xsl:apply-templates select="int_rate" mode="copy_element" />
			</xsl:if>
			<xsl:if test="int_start_date">
				<xsl:apply-templates select="int_start_date"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="int_maturity_date">
				<xsl:apply-templates select="int_maturity_date"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="principal_act_no">
				<xsl:apply-templates select="principal_act_no"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="fee_act_no">
				<xsl:apply-templates select="fee_act_no" mode="copy_element" />
			</xsl:if>
			<xsl:if test="fwd_contract_no">
				<xsl:apply-templates select="fwd_contract_no"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="insr_req_flag">
				<xsl:apply-templates select="insr_req_flag"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="dir_coll_letter_flag">
				<xsl:apply-templates select="dir_coll_letter_flag"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="amd_date">
				<xsl:apply-templates select="amd_date"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="amd_no">
				<xsl:apply-templates select="amd_no"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="maturity_date">
				<xsl:apply-templates select="maturity_date"
					mode="copy_element" />
			</xsl:if>
			
			
			<xsl:if test="additional_field[@name='needs_refer_to']">
				<xsl:apply-templates select="/node()/additional_field[@name='needs_refer_to']"
					mode="add_to_element" />
			</xsl:if>
			<xsl:if test="additional_field[@name='needs_instr_by_code']">
				<xsl:apply-templates select="/node()/additional_field[@name='needs_instr_by_code']"
					mode="add_to_element" />
			</xsl:if>
			
			
			<xsl:if test="remitting_bank">
				<xsl:apply-templates select="remitting_bank"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="collecting_bank">
				<xsl:apply-templates select="collecting_bank"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="presenting_bank">
				<xsl:apply-templates select="presenting_bank"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="correspondent_bank">
				<xsl:apply-templates select="correspondent_bank"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_description_goods">
				<xsl:apply-templates select="narrative_description_goods"
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
			<xsl:if test="charges">
				<xsl:apply-templates select="charges" mode="copy_element" />
			</xsl:if>
			<xsl:if test="attachments">
				<xsl:apply-templates select="attachments" mode="copy_element" />
			</xsl:if>
			<xsl:if test="documents">
				<xsl:apply-templates select="documents" mode="copy_element" />
			</xsl:if>
			<xsl:if test="linked_licenses">
				<xsl:apply-templates select="linked_licenses" mode="copy_element" />
			</xsl:if>
			<xsl:call-template name="cross_ref"></xsl:call-template>
			<xsl:if test="additional_field">
				<xsl:apply-templates select="additional_field" mode="copy_additional">
					<xsl:with-param name="ignoreAdditional">
					needs_refer_to,needs_instr_by_code
					</xsl:with-param>
				</xsl:apply-templates>
			</xsl:if>
			<xsl:if test="prod_stat_code='12'">
				<action_req_code>12</action_req_code>
			</xsl:if>

		</ec_tnx_record>
	</xsl:template>



</xsl:stylesheet>