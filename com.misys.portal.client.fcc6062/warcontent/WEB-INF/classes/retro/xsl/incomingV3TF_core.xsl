<?xml version="1.0"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com), All Rights Reserved. -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
    exclude-result-prefixes="utils">

	<xsl:template match="tf_tnx_record">
		<tf_tnx_record>
			<xsl:copy-of select="@*" />
			<xsl:if test="brch_code">
				<xsl:apply-templates select="brch_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="ref_id">
				<xsl:apply-templates select="ref_id" mode="copy_element" />
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
			<xsl:if test="imp_bill_ref_id">
				<xsl:apply-templates select="imp_bill_ref_id"
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
			<xsl:if test="fin_type">
				<xsl:call-template name="generateSubProductCode">
					<xsl:with-param name="financingType" select="fin_type"/>
				</xsl:call-template>
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
			<xsl:if test="tnx_cur_code">
				<xsl:apply-templates select="tnx_cur_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="tnx_amt">
				<xsl:apply-templates select="tnx_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="fin_cur_code">
				<xsl:apply-templates select="fin_cur_code" mode="copy_element" />
			</xsl:if>
			<xsl:if test="fin_amt">
				<xsl:apply-templates select="fin_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="fin_liab_amt">
				<xsl:apply-templates select="fin_liab_amt" mode="copy_element" />
			</xsl:if>
			<xsl:if test="fin_outstanding_amt">
				<xsl:apply-templates select="fin_outstanding_amt"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="fin_type">
				<xsl:call-template name="convertFinancingType">
					<xsl:with-param name="financingType" select="fin_type"/>
				</xsl:call-template>
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
			<xsl:if test="principal_act_no">
				<xsl:apply-templates select="principal_act_no"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="fee_act_no">
				<xsl:apply-templates select="fee_act_no" mode="copy_element" />
			</xsl:if>
			<xsl:if test="tenor">
				<xsl:apply-templates select="tenor" mode="copy_element" />
			</xsl:if>
			<xsl:if test="maturity_date">
				<xsl:apply-templates select="maturity_date"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="issuing_bank">
				<xsl:apply-templates select="issuing_bank" mode="copy_element" />
			</xsl:if>
			<xsl:if test="goods_desc">
				<xsl:apply-templates select="goods_desc" mode="copy_element" />
			</xsl:if>
			<xsl:if test="bo_comment">
				<xsl:apply-templates select="bo_comment" mode="copy_element" />
			</xsl:if>
			<xsl:if test="free_format_text">
				<xsl:apply-templates select="free_format_text"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="fwd_contract_no">
				<xsl:apply-templates select="fwd_contract_no"
					mode="copy_element" />
			</xsl:if>
			<xsl:if test="charges">
				<xsl:apply-templates select="charges" mode="copy_element" />
			</xsl:if>
			<xsl:if test="attachments">
				<xsl:apply-templates select="attachments" mode="copy_element" />
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
				<xsl:when test="prod_stat_code[.='98'] and action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code"/>
					</action_req_code>
				</xsl:when>
			</xsl:choose>
		</tf_tnx_record>
	</xsl:template>

	<!-- Convert financing type -->
	<xsl:template name="convertFinancingType">
		<xsl:param name="financingType"/>
		
		<fin_type>
			<xsl:choose>
				<xsl:when test="$financingType[.= '01' or .= '02' or .= '03' or .= '83' ]">01</xsl:when>
				<xsl:when test="$financingType[.= '20' or .= '21' or .= '22' or .= '23' or .= '24' or .= '86']">02</xsl:when>
				<xsl:otherwise>99</xsl:otherwise>
			</xsl:choose>
		</fin_type>
		
	</xsl:template>

	<!-- Generate sub product status code -->
	<xsl:template name="generateSubProductCode">
		<xsl:param name="financingType"/>
		
		<sub_product_code>
			<xsl:choose>
				<xsl:when test="$financingType = '01'">ITRPT</xsl:when>
				<xsl:when test="$financingType = '02'">ILNLC</xsl:when>
				<xsl:when test="$financingType = '03'">ILNIC</xsl:when>
				<xsl:when test="$financingType = '04'">IBCLC</xsl:when>
				<xsl:when test="$financingType = '20'">ECRBP</xsl:when>
				<xsl:when test="$financingType = '21'">EDILC</xsl:when>
				<xsl:when test="$financingType = '22'">EBEXP</xsl:when>
				<xsl:when test="$financingType = '23'">EDIEC</xsl:when>
				<xsl:when test="$financingType = '24'">EPCKC</xsl:when>
				<xsl:when test="$financingType = '83'">IOTHF</xsl:when>
				<xsl:when test="$financingType = '86'">EOTHF</xsl:when>
				<xsl:when test="$financingType = '99'">OTHER</xsl:when>
			</xsl:choose>
		</sub_product_code>
		
	</xsl:template>

</xsl:stylesheet>