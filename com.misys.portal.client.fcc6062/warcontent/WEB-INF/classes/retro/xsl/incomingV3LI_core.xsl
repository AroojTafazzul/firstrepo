<?xml version="1.0"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com), All Rights Reserved. -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
<xsl:template match="li_tnx_record">
	<li_tnx_record>
			<xsl:copy-of select="@*"/>
			<xsl:if test="brch_code">
				<xsl:apply-templates select="brch_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ref_id">
				<xsl:apply-templates select="ref_id" mode="copy_element" />
			</xsl:if>
			<xsl:if test="lc_ref_id">
				<xsl:apply-templates select="lc_ref_id" mode="copy_element" />
			</xsl:if>
			<xsl:if test="alt_lc_ref_id">
				<xsl:apply-templates select="alt_lc_ref_id" mode="copy_element" />
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
			<xsl:if test="deal_ref_id">
				<xsl:apply-templates select="deal_ref_id" mode="copy_element" />
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
			<xsl:if test="imp_bill_ref_id">
				<xsl:apply-templates select="imp_bill_ref_id" mode="copy_element" />
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
			<xsl:if test="sub_tnx_stat_code">
				<xsl:apply-templates select="sub_tnx_stat_code"
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
			<xsl:if test="bo_inp_user_id">
				<xsl:apply-templates select="bo_inp_user_id"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_inp_dttm">
				<xsl:apply-templates select="bo_inp_dttm" mode="copy_element" />
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
			<xsl:if test="tnx_cur_code">
				<xsl:apply-templates select="tnx_cur_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="tnx_amt">
				<xsl:apply-templates select="tnx_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_tnx_id">
				<xsl:apply-templates select="bo_tnx_id" mode="copy_element" />
			</xsl:if>
			<xsl:if test="li_cur_code">
				<xsl:apply-templates select="li_cur_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="li_amt">
				<xsl:apply-templates select="li_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="li_liab_amt">
				<xsl:apply-templates select="li_liab_amt" mode="copy_element" />
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
			<xsl:if test="bene_type_code">
				<xsl:apply-templates select="bene_type_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bene_type_other">
				<xsl:apply-templates select="bene_type_other" mode="copy_element" />
			</xsl:if>
			<xsl:if test="countersign_flag">
				<xsl:apply-templates select="countersign_flag" mode="copy_element" />
			</xsl:if>
			<xsl:if test="trans_doc_type_code">
				<xsl:apply-templates select="trans_doc_type_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="trans_doc_type_other">
				<xsl:apply-templates select="trans_doc_type_other" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bol_number">
				<xsl:apply-templates select="bol_number" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bol_date">
				<xsl:apply-templates select="bol_date" mode="copy_element" />
			</xsl:if>
			<xsl:if test="shipping_mode">
				<xsl:apply-templates select="shipping_mode" mode="copy_element" />
			</xsl:if>
			<xsl:if test="shipping_by">
				<xsl:apply-templates select="shipping_by" mode="copy_element" />
			</xsl:if>
			<xsl:if test="principal_act_no">
				<xsl:apply-templates select="principal_act_no"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="fee_act_no">
				<xsl:apply-templates select="fee_act_no" mode="copy_element" />
			</xsl:if>
			<xsl:if test="issuing_bank">
				<xsl:apply-templates select="issuing_bank" mode="copy_element" />
			</xsl:if>
			<xsl:if test="narrative_description_goods">
				<xsl:apply-templates select="narrative_description_goods"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_comment">
				<xsl:apply-templates select="bo_comment" mode="copy_element" />
			</xsl:if>
			<xsl:if test="free_format_text">
				<xsl:apply-templates select="free_format_text"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="attachments">
				<xsl:apply-templates select="attachments" mode="copy_element" />
			</xsl:if>
			<xsl:call-template name="cross_ref"></xsl:call-template>
			<xsl:if test="additional_field">
				<xsl:apply-templates select="additional_field" mode="copy_additional">
				</xsl:apply-templates>
			</xsl:if>
		</li_tnx_record>
	</xsl:template>



</xsl:stylesheet>