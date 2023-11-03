<?xml version="1.0"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com), All Rights Reserved. -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="ls_tnx_record">
		<ls_tnx_record>
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
			<xsl:if test="auth_reference">
				<xsl:apply-templates select="auth_reference" mode="copy_element" />
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
			<xsl:if test="tnx_val_date">
				<xsl:apply-templates select="tnx_val_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="appl_date">
				<xsl:apply-templates select="appl_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="iss_date">
				<xsl:apply-templates select="iss_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="amd_date">
				<xsl:apply-templates select="amd_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="amd_no">
				<xsl:apply-templates select="amd_no" mode="copy_element" />
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
			<xsl:if test="ls_cur_code">
				<xsl:apply-templates select="ls_cur_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ls_amt">
				<xsl:apply-templates select="ls_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ls_liab_amt">
				<xsl:apply-templates select="ls_liab_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ls_def_id">
				<xsl:apply-templates select="ls_def_id" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ls_name">
				<xsl:apply-templates select="ls_name" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ls_number">
				<xsl:apply-templates select="ls_number" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ls_outstanding_amt">
				<xsl:apply-templates select="ls_outstanding_amt"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="ls_type">
				<xsl:apply-templates select="ls_type" mode="copy_element" />
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
			<xsl:if test="further_identification">
				<xsl:apply-templates select="further_identification"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="entity">
				<xsl:apply-templates select="entity" mode="copy_element" />
			</xsl:if>
			<xsl:if test="inco_term">
				<xsl:apply-templates select="inco_term" mode="copy_element" />
			</xsl:if>
			<xsl:if test="inco_place">
				<xsl:apply-templates select="inco_place" mode="copy_element" />
			</xsl:if>
			<xsl:if test="neg_tol_pct">
				<xsl:apply-templates select="neg_tol_pct" mode="copy_element" />
			</xsl:if>
			<xsl:if test="pstv_tol_pct">
				<xsl:apply-templates select="pstv_tol_pct" mode="copy_element" />
			</xsl:if>
			<xsl:if test="additional_amt">
				<xsl:apply-templates select="additional_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="additional_cur_code">
				<xsl:apply-templates select="additional_cur_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="origin_country">
				<xsl:apply-templates select="origin_country" mode="copy_element" />
			</xsl:if>
			<xsl:if test="supply_country">
				<xsl:apply-templates select="supply_country" mode="copy_element" />
			</xsl:if>
			<xsl:if test="latest_payment_date">
				<xsl:apply-templates select="latest_payment_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="total_amt">
				<xsl:apply-templates select="total_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="total_cur_code">
				<xsl:apply-templates select="total_cur_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="reg_date">
				<xsl:apply-templates select="reg_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="valid_to_date">
				<xsl:apply-templates select="valid_to_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="valid_from_date">
				<xsl:apply-templates select="valid_from_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="valid_for_nb">
				<xsl:apply-templates select="valid_for_nb" mode="copy_element" />
			</xsl:if>
			<xsl:if test="valid_for_period">
				<xsl:apply-templates select="valid_for_period" mode="copy_element" />
			</xsl:if>
			<xsl:if test="allow_multi_cur">
				<xsl:apply-templates select="allow_multi_cur" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ls_settlement_amt">
				<xsl:apply-templates select="ls_settlement_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="add_settlement_amt">
				<xsl:apply-templates select="add_settlement_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ls_clear">
				<xsl:apply-templates select="ls_clear" mode="copy_element" />
			</xsl:if>
			<xsl:if test="action_req_code">
				<xsl:apply-templates select="action_req_code" mode="copy_element" />
			</xsl:if>


			<xsl:if test="issuing_bank">
				<xsl:apply-templates select="issuing_bank" mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_description_goods">
				<xsl:apply-templates select="narrative_description_goods"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_additional_instructions">
				<xsl:apply-templates select="narrative_additional_instructions"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_additional_amount">
				<xsl:apply-templates select="narrative_additional_amount"
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
			<xsl:call-template name="cross_ref"></xsl:call-template>
			<xsl:if test="additional_field">
				<xsl:apply-templates select="additional_field"
					mode="copy_element" />
			</xsl:if>
		</ls_tnx_record>
	</xsl:template>



</xsl:stylesheet>