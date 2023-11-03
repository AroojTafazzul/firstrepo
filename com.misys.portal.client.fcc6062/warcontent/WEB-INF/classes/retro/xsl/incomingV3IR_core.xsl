<?xml version="1.0"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com), All Rights Reserved. -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="ir_tnx_record">
		<ir_tnx_record>
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
			<xsl:if test="cust_ref_id">
				<xsl:apply-templates select="cust_ref_id" mode="copy_element" />
			</xsl:if>
			<xsl:if test="tnx_id">
				<xsl:apply-templates select="tnx_id" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_tnx_id">
				<xsl:apply-templates select="bo_tnx_id" mode="copy_element" />
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
			<xsl:if test="ir_cur_code">
				<xsl:apply-templates select="ir_cur_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ir_amt">
				<xsl:apply-templates select="ir_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ir_liab_amt">
				<xsl:apply-templates select="ir_liab_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ir_outstanding_amt">
				<xsl:apply-templates select="ir_outstanding_amt"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="ir_type_code">
				<xsl:apply-templates select="ir_type_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ir_sub_type_code">
				<xsl:apply-templates select="ir_sub_type_code"
					mode="copy_element" />
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
			<xsl:if test="entity">
				<xsl:apply-templates select="entity" mode="copy_element" />
			</xsl:if>
			<xsl:if test="remitter_abbv_name">
				<xsl:apply-templates select="remitter_abbv_name"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="remitter_name">
				<xsl:apply-templates select="remitter_name"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="remitter_address_line_1">
				<xsl:apply-templates select="remitter_address_line_1"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="remitter_address_line_2">
				<xsl:apply-templates select="remitter_address_line_2"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="remitter_dom">
				<xsl:apply-templates select="remitter_dom" mode="copy_element" />
			</xsl:if>
			<xsl:if test="remitter_country">
				<xsl:apply-templates select="remitter_country"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="remitter_reference">
				<xsl:apply-templates select="remitter_reference"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="fee_act_no">
				<xsl:apply-templates select="fee_act_no" mode="copy_element" />
			</xsl:if>
			<xsl:if test="remittance_date">
				<xsl:apply-templates select="remittance_date"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="act_no">
				<xsl:apply-templates select="act_no" mode="copy_element" />
			</xsl:if>
			<xsl:if test="fwd_contract_no">
				<xsl:apply-templates select="fwd_contract_no"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="instructions_required">
				<xsl:apply-templates select="instructions_required"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_comment">
				<xsl:apply-templates select="bo_comment" mode="copy_element" />
			</xsl:if>
			<xsl:if test="free_format_text">
				<xsl:apply-templates select="free_format_text"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="maturity_date">
				<xsl:apply-templates select="maturity_date"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="link_tnx_id">
				<xsl:apply-templates select="link_tnx_id" mode="copy_element" />
			</xsl:if>
			<xsl:if test="remitting_bank">
				<xsl:apply-templates select="remitting_bank"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="issuing_bank">
				<xsl:apply-templates select="issuing_bank" mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_payment_details">
				<xsl:apply-templates select="narrative_payment_details"
					mode="copy_element" />
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
			<xsl:if test="prod_stat_code='12'">
				<action_req_code>12</action_req_code>
			</xsl:if>

		</ir_tnx_record>
	</xsl:template>



</xsl:stylesheet>