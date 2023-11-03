<?xml version="1.0"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com), All Rights Reserved. -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="ft_tnx_record">
		<ft_tnx_record>
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
			<xsl:if test="bo_tnx_id">
				<xsl:apply-templates select="bo_tnx_id" mode="copy_element" />
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
			<xsl:if test="open_chrg_brn_by_code">
				<xsl:apply-templates select="open_chrg_brn_by_code"
					mode="copy_element" />
			</xsl:if>


			<xsl:if test="fee_act_no">
				<xsl:apply-templates select="fee_act_no" mode="copy_element" />
			</xsl:if>


			<xsl:if test="issuing_bank">
				<xsl:apply-templates select="issuing_bank" mode="copy_element" />
			</xsl:if>
			<xsl:if test="account_with_bank">
				<xsl:apply-templates select="account_with_bank" mode="copy_element" />
			</xsl:if>
			<xsl:if test="pay_through_bank">
				<xsl:apply-templates select="pay_through_bank" mode="copy_element" />
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
			<xsl:if test="attachments">
				<xsl:apply-templates select="attachments" mode="copy_element" />
			</xsl:if>
			<xsl:if test="linked_licenses">
				<xsl:apply-templates select="linked_licenses" mode="copy_element" />
			</xsl:if>
			<xsl:if test="counterparties">
				<xsl:apply-templates select="counterparties" mode="copy_element" />
			</xsl:if>
			<xsl:if test="additional_field">
				<xsl:apply-templates select="additional_field" mode="copy_additional">
					<xsl:with-param name="ignoreAdditional">					
					renew_flag,renew_on_code,renewal_calendar_date,renew_for_nb,renew_for_period,
					rolling_renewal_flag,rolling_renewal_nb,rolling_cancellation_days,renew_amt_code
					</xsl:with-param>
				</xsl:apply-templates>
			</xsl:if>
			<xsl:call-template name="cross_ref"></xsl:call-template>
			<xsl:if test="prod_stat_code='12'">
				<action_req_code>12</action_req_code>
			</xsl:if>
			
			<xsl:if test="ft_type">
				<sub_product_code>
					<xsl:choose>
						<xsl:when test="ft_type='01'">TINT</xsl:when>
						<xsl:when test="ft_type='02'">TTPT</xsl:when>
					</xsl:choose>
				</sub_product_code>
			</xsl:if>

			<!-- FT Specific -->
		   <xsl:if test="applicant_act_no">
		    <xsl:apply-templates select="applicant_act_no" mode="copy_element" />
		   </xsl:if>
		
		   <xsl:if test="fee_amt">
		    <xsl:apply-templates select="fee_amt" mode="copy_element" />
		   </xsl:if>
		
		   <xsl:if test="fee_cur_code">
		    <xsl:apply-templates select="fee_cur_code" mode="copy_element" />
		   </xsl:if>
		
		   <xsl:if test="ft_amt">
		    <xsl:apply-templates select="ft_amt" mode="copy_element" />
		   </xsl:if>
		
		   <xsl:if test="ft_cur_code">
		    <xsl:apply-templates select="ft_cur_code" mode="copy_element" />
		   </xsl:if>
		
		   <xsl:if test="ft_type">
		    <xsl:apply-templates select="ft_type" mode="copy_element" />
		   </xsl:if>
		
		   <xsl:if test="priority">
		    <xsl:apply-templates select="priority" mode="copy_element" />
		   </xsl:if>
		
		   <xsl:if test="rate">
		    <xsl:apply-templates select="rate" mode="copy_element" />
		   </xsl:if>
		
		</ft_tnx_record>
	</xsl:template>


</xsl:stylesheet>