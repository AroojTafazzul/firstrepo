<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
	<!-- Process EL File and Received Stand By-->
	<xsl:template match="el_tnx_record | sr_tnx_record">
		<result>
			<com.misys.portal.product.el.common.ExportLetterOfCredit>
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
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>	
				<xsl:if test="lc_ref_id">
					<lc_ref_id>
						<xsl:value-of select="lc_ref_id"/>
					</lc_ref_id>
				</xsl:if>
				<xsl:if test="tnx_val_date">
					<tnx_val_date>
						<xsl:value-of select="tnx_val_date"/>
					</tnx_val_date>
				</xsl:if>
				<xsl:if test="appl_date">
					<appl_date>
						<xsl:value-of select="appl_date"/>
					</appl_date>
				</xsl:if>
				<xsl:if test="iss_date">
					<iss_date>
						<xsl:value-of select="iss_date"/>
					</iss_date>
				</xsl:if>
				<xsl:if test="boe_flag">
					<boe_flag>
						<xsl:value-of select="boe_flag"/>
					</boe_flag>
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
				<xsl:if test="exp_date">
					<exp_date>
						<xsl:value-of select="exp_date"/>
					</exp_date>
				</xsl:if>
				<xsl:if test="last_ship_date">
					<last_ship_date>
						<xsl:value-of select="last_ship_date"/>
					</last_ship_date>
				</xsl:if>
				<xsl:if test="tnx_cur_code">
					<tnx_cur_code>
						<xsl:value-of select="tnx_cur_code"/>
					</tnx_cur_code>
				</xsl:if>
				<xsl:if test="lc_cur_code">
					<lc_cur_code>
						<xsl:value-of select="lc_cur_code"/>
					</lc_cur_code>
				</xsl:if>
				<xsl:if test="tnx_amt">
					<tnx_amt>
						<xsl:value-of select="tnx_amt"/>
					</tnx_amt>
				</xsl:if>
				<xsl:if test="lc_cur_code">
					<lc_cur_code>
						<xsl:value-of select="lc_cur_code"/>
					</lc_cur_code>
				</xsl:if>
				<xsl:if test="lc_amt">
					<lc_amt>
						<xsl:value-of select="lc_amt"/>
					</lc_amt>
				</xsl:if>
				<xsl:if test="lc_liab_amt">
					<lc_liab_amt>
						<xsl:value-of select="lc_liab_amt"/>
					</lc_liab_amt>
				</xsl:if>
				<xsl:if test="lc_outstanding_amt">
					<lc_outstanding_amt>
						<xsl:value-of select="lc_outstanding_amt"/>
					</lc_outstanding_amt>
				</xsl:if>
				
				<!-- MPS-41561 - Available Amount -->
				<xsl:if test="lc_available_amt">
					<lc_available_amt>
						<xsl:value-of select="lc_available_amt"/>
					</lc_available_amt>
				</xsl:if>
				
				<xsl:if test="lc_type">
					<lc_type>
						<xsl:value-of select="lc_type"/>
					</lc_type>
				</xsl:if>
				<xsl:if test="expiry_place">
					<expiry_place>
						<xsl:value-of select="expiry_place"/>
					</expiry_place>
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
				<xsl:if test="part_ship_detl">
					<part_ship_detl>
					<xsl:choose>
                  	<xsl:when test="part_ship_detl_nosend [. != 'OTHER']">
								<xsl:value-of select="part_ship_detl_nosend"/>
                  	</xsl:when>
                  	<xsl:otherwise>
								<xsl:value-of select="part_ship_detl"/>
                  	</xsl:otherwise>
                  </xsl:choose>
					</part_ship_detl>
				</xsl:if>
				<xsl:if test="ship_from">
					<ship_from>
						<xsl:value-of select="ship_from"/>
					</ship_from>
				</xsl:if>
				<!-- SWIFT 2006 -->
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
				<!-- SWIFT 2006 -->
				<xsl:if test="ship_to">
					<ship_to>
						<xsl:value-of select="ship_to"/>
					</ship_to>
				</xsl:if>
				<xsl:if test="tran_ship_detl">
					<tran_ship_detl>
					<xsl:choose>
                  	<xsl:when test="tran_ship_detl_nosend [. != 'OTHER']">
								<xsl:value-of select="tran_ship_detl_nosend"/>
                  	</xsl:when>
                  	<xsl:otherwise>
								<xsl:value-of select="tran_ship_detl"/>
                  	</xsl:otherwise>
                  </xsl:choose>
					</tran_ship_detl>
				</xsl:if>
				<xsl:if test="cty_of_dest">
					<cty_of_dest>
						<xsl:value-of select="cty_of_dest"/>
					</cty_of_dest>
				</xsl:if>
				<xsl:if test="rvlv_lc_type">
					<rvlv_lc_type_code>
						<xsl:value-of select="rvlv_lc_type"/>
					</rvlv_lc_type_code>
				</xsl:if>
				<xsl:if test="max_no_of_rvlv">
					<max_no_of_rvlv>
						<xsl:value-of select="max_no_of_rvlv"/>
					</max_no_of_rvlv>
				</xsl:if>
				<xsl:if test="neg_tol_pct">
					<neg_tol_pct>
						<xsl:value-of select="neg_tol_pct"/>
					</neg_tol_pct>
				</xsl:if>
				<xsl:if test="pstv_tol_pct">
					<pstv_tol_pct>
						<xsl:value-of select="pstv_tol_pct"/>
					</pstv_tol_pct>
				</xsl:if>
				<xsl:if test="max_cr_desc_code">
					<max_cr_desc_code>
						<xsl:value-of select="max_cr_desc_code"/>
					</max_cr_desc_code>
				</xsl:if>
				<xsl:if test="cfm_flag">
					<cfm_flag>
						<xsl:value-of select="cfm_flag"/>
					</cfm_flag>
				</xsl:if>
				<xsl:if test="cr_avl_by_code">
					<cr_avl_by_code>
						<xsl:value-of select="cr_avl_by_code"/>
					</cr_avl_by_code>
				</xsl:if>
				<xsl:if test="dir_reim_flag">
					<dir_reim_flag>
						<xsl:value-of select="dir_reim_flag"/>
					</dir_reim_flag>
				</xsl:if>
				<xsl:if test="irv_flag">
					<irv_flag>
						<xsl:value-of select="irv_flag"/>
					</irv_flag>
				</xsl:if>
				<xsl:if test="ntrf_flag">
					<ntrf_flag>
						<xsl:value-of select="ntrf_flag"/>
					</ntrf_flag>
				</xsl:if>
				<xsl:if test="stnd_by_lc_flag">
					<stnd_by_lc_flag>
						<xsl:value-of select="stnd_by_lc_flag"/>
					</stnd_by_lc_flag>
				</xsl:if>
				<xsl:if test="cfm_inst_code">
					<cfm_inst_code>
						<xsl:value-of select="cfm_inst_code"/>
					</cfm_inst_code>
				</xsl:if>
				<!-- MPSSC 11179 -->
				<xsl:if test="req_conf_party_flag">
					<req_conf_party_flag>
						<xsl:value-of select="req_conf_party_flag"/>
					</req_conf_party_flag>
				</xsl:if>
				<xsl:if test="proactive_amd">
					<additional_field name = "proactive_amd" type ="string" scope="none" description ="Pro active flag to be set by TI">
						<xsl:value-of select="proactive_amd"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="cfm_chrg_brn_by_code">
					<cfm_chrg_brn_by_code>
						<xsl:value-of select="cfm_chrg_brn_by_code"/>
					</cfm_chrg_brn_by_code>
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
				<xsl:if test="amd_chrg_brn_by_code">
					<amd_chrg_brn_by_code>
						<xsl:value-of select="amd_chrg_brn_by_code"/>
					</amd_chrg_brn_by_code>
				</xsl:if>
				<xsl:if test="imp_bill_ref_id">
					<imp_bill_ref_id>
						<xsl:value-of select="imp_bill_ref_id"/>
					</imp_bill_ref_id>
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
				<xsl:if test="sec_beneficiary_name">
					<sec_beneficiary_name>
						<xsl:value-of select="sec_beneficiary_name"/>
					</sec_beneficiary_name>
				</xsl:if>
				<xsl:if test="sec_beneficiary_abbv_name">
					<sec_beneficiary_abbv_name>
						<xsl:value-of select="sec_beneficiary_abbv_name"/>
					</sec_beneficiary_abbv_name>
				</xsl:if>
				<xsl:if test="sec_beneficiary_address_line_1">
					<sec_beneficiary_address_line_1>
						<xsl:value-of select="sec_beneficiary_address_line_1"/>
					</sec_beneficiary_address_line_1>
				</xsl:if>
				<xsl:if test="sec_beneficiary_address_line_2">
					<sec_beneficiary_address_line_2>
						<xsl:value-of select="sec_beneficiary_address_line_2"/>
					</sec_beneficiary_address_line_2>
				</xsl:if>
				<xsl:if test="sec_beneficiary_address_line_4">
					<sec_beneficiary_address_line_4>
						<xsl:value-of select="sec_beneficiary_address_line_4"/>
					</sec_beneficiary_address_line_4>
				</xsl:if>
				<xsl:if test="sec_beneficiary_dom">
					<sec_beneficiary_dom>
						<xsl:value-of select="sec_beneficiary_dom"/>
					</sec_beneficiary_dom>
				</xsl:if>
				<xsl:if test="sec_beneficiary_country">
					<sec_beneficiary_country>
						<xsl:value-of select="sec_beneficiary_country"/>
					</sec_beneficiary_country>
				</xsl:if>
				<xsl:if test="sec_beneficiary_reference">
					<sec_beneficiary_reference>
						<xsl:value-of select="sec_beneficiary_reference"/>
					</sec_beneficiary_reference>
				</xsl:if>
				<xsl:if test="assignee_name">
					<assignee_name>
						<xsl:value-of select="assignee_name"/>
					</assignee_name>
				</xsl:if>
				<xsl:if test="assignee_address_line_1">
					<assignee_address_line_1>
						<xsl:value-of select="assignee_address_line_1"/>
					</assignee_address_line_1>
				</xsl:if>
				<xsl:if test="assignee_address_line_2">
					<assignee_address_line_2>
						<xsl:value-of select="assignee_address_line_2"/>
					</assignee_address_line_2>
				</xsl:if>
				<xsl:if test="assignee_address_line_4">
					<assignee_address_line_4>
						<xsl:value-of select="assignee_address_line_4"/>
					</assignee_address_line_4>
				</xsl:if>
				<xsl:if test="assignee_dom">
					<assignee_dom>
						<xsl:value-of select="assignee_dom"/>
					</assignee_dom>
				</xsl:if>
				<xsl:if test="assignee_country">
					<assignee_country>
						<xsl:value-of select="assignee_country"/>
					</assignee_country>
				</xsl:if>
				<xsl:if test="assignee_reference">
					<assignee_reference>
						<xsl:value-of select="assignee_reference"/>
					</assignee_reference>
				</xsl:if>
				<xsl:if test="notify_amendment_flag">
					<notify_amendment_flag>
						<xsl:value-of select="notify_amendment_flag"/>
					</notify_amendment_flag>
				</xsl:if>
				<xsl:if test="substitute_invoice_flag">
					<substitute_invoice_flag>
						<xsl:value-of select="substitute_invoice_flag"/>
					</substitute_invoice_flag>
				</xsl:if>
				<xsl:if test="advise_mode_code">
					<advise_mode_code>
						<xsl:value-of select="advise_mode_code"/>
					</advise_mode_code>
				</xsl:if>
				<xsl:if test="delv_org">
					<delv_org>
						<xsl:value-of select="delv_org"/>
					</delv_org>
				</xsl:if>
				<xsl:if test="delv_org_text">
					<delv_org_text>
						<xsl:value-of select="delv_org_text"/>
					</delv_org_text>
				</xsl:if>
				<xsl:if test="delivery_to">
					<delivery_to>
						<xsl:value-of select="delivery_to"/>
					</delivery_to>
				</xsl:if>
				<xsl:if test="lc_exp_date_type_code">
					<lc_exp_date_type_code>
						<xsl:value-of select="lc_exp_date_type_code"/>
					</lc_exp_date_type_code>
				</xsl:if>
				<xsl:if test="exp_event">
					<exp_event>
						<xsl:value-of select="exp_event"/>
					</exp_event>
				</xsl:if>
				<xsl:if test="lc_govern_country">
					<lc_govern_country>
						<xsl:value-of select="lc_govern_country"/>
					</lc_govern_country>
				</xsl:if>
				<xsl:if test="lc_govern_text">
					<lc_govern_text>
						<xsl:value-of select="lc_govern_text"/>
					</lc_govern_text>
				</xsl:if>
				<xsl:if test="demand_indicator">
					<demand_indicator>
						<xsl:value-of select="demand_indicator"/>
					</demand_indicator>
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
						<xsl:value-of select="applicant_reference"/>
					</applicant_reference>
				</xsl:if>
				<xsl:if test="applicant_contact_number">
					<applicant_contact_number>
						<xsl:value-of select="applicant_contact_number"/>
					</applicant_contact_number>
				</xsl:if>
				<xsl:if test="applicant_email">
					<applicant_email>
						<xsl:value-of select="applicant_email"/>
					</applicant_email>
				</xsl:if>
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
				<xsl:if test="rolling_renewal_nb">
					<rolling_renewal_nb>
						<xsl:value-of select="rolling_renewal_nb"/>
					</rolling_renewal_nb>
				</xsl:if>
				<xsl:if test="rolling_day_in_month">
					<rolling_day_in_month>
						<xsl:value-of select="rolling_day_in_month"/>
					</rolling_day_in_month>
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
				<xsl:if test="projected_expiry_date">
					<projected_expiry_date>
						<xsl:value-of select="projected_expiry_date"/>
					</projected_expiry_date>
				</xsl:if>
				<!-- Standby LC Rolling final expiry date -->
				<xsl:if test="final_expiry_date">
					<final_expiry_date>
						<xsl:value-of select="final_expiry_date"/>
					</final_expiry_date>
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
				<xsl:if test="applicable_rules">
					<applicable_rules>
						<xsl:value-of select="applicable_rules"/>
					</applicable_rules>
				</xsl:if>
				<xsl:if test="applicable_rules_text">
					<applicable_rules_text>
						<xsl:value-of select="applicable_rules_text"/>
					</applicable_rules_text>
				</xsl:if>
				<xsl:if test="draft_term">
					<draft_term>
						<xsl:value-of select="draft_term"/>
					</draft_term>
				</xsl:if>
				<xsl:if test="cust_ref_id">
					<cust_ref_id>
						<xsl:value-of select="cust_ref_id"/>
					</cust_ref_id>
				</xsl:if>
				<xsl:if test="bo_ref_id">
					<bo_ref_id>
						<xsl:value-of select="bo_ref_id"/>
					</bo_ref_id>
				</xsl:if>
				<xsl:if test="maturity_date">
					<maturity_date>
						<xsl:value-of select="maturity_date"/>
					</maturity_date>
				</xsl:if>
				<xsl:if test="eucp_flag">
					<eucp_flag>
						<xsl:value-of select="eucp_flag"/>
					</eucp_flag>
				</xsl:if>
				<xsl:if test="eucp_version">
					<eucp_version>
						<xsl:value-of select="eucp_version"/>
					</eucp_version>
				</xsl:if>
				<xsl:if test="eucp_presentation_place">
					<eucp_presentation_place>
						<xsl:value-of select="eucp_presentation_place"/>
					</eucp_presentation_place>
				</xsl:if>
				<xsl:if test="action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code"/>
					</action_req_code>
				</xsl:if>
				<xsl:if test="delivery_channel">
					<delivery_channel>
						<xsl:value-of select="delivery_channel"/>
					</delivery_channel>
				</xsl:if>
				<xsl:if test="advising_bank_customer_reference">
					<additional_field name="advising_bank_customer_reference" type="string" scope="master">
						<xsl:value-of select="advising_bank_customer_reference"/>
					</additional_field>
				</xsl:if>
				<!-- Previous ctl date, used for synchronisation issues -->
				<xsl:if test="old_ctl_dttm">
					<additional_field name="old_ctl_dttm" type="time" scope="none" description=" Previous control date used for synchronisation issues">
						<xsl:value-of select="old_ctl_dttm"/>
					</additional_field>
				</xsl:if>
				<!-- Previous input date, used to know if the product is already saved -->
				<xsl:if test="old_inp_dttm">
					<additional_field name="old_inp_dttm" type="time" scope="none" description="Previous input date used for synchronisation issues">
						<xsl:value-of select="old_inp_dttm"/>
					</additional_field>
				</xsl:if>
				<!-- SWIFT 2018 -->
				<xsl:if test="period_presentation_days">
					<period_presentation_days>
						<xsl:value-of select="period_presentation_days"/>
					</period_presentation_days>
				</xsl:if>	
				<!-- Security -->
				<xsl:if test="token">
					<additional_field name="token" type="string" scope="none" description="Security token">
						<xsl:value-of select="token"/>
					</additional_field>
				</xsl:if>
				<!-- Re authentication -->
				<xsl:call-template name="AUTHENTICATION"/>
				<!-- collaboration -->
				<xsl:call-template name="collaboration" />
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.product.el.common.ExportLetterOfCredit>
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
				<xsl:if test="issuing_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="issuing_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="issuing_bank_dom">
					<dom>
						<xsl:value-of select="issuing_bank_dom"/>
					</dom>
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
				<xsl:if test="advising_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="advising_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="advising_bank_dom">
					<dom>
						<xsl:value-of select="advising_bank_dom"/>
					</dom>
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
			<com.misys.portal.product.common.Bank role_code="03">
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
				<xsl:if test="advise_thru_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="advise_thru_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="advise_thru_bank_name">
					<name>
						<xsl:value-of select="advise_thru_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="advise_thru_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="advise_thru_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="advise_thru_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="advise_thru_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="advise_thru_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="advise_thru_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="advise_thru_bank_dom">
					<dom>
						<xsl:value-of select="advise_thru_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="advise_thru_bank_iso_code">
					<iso_code>
						<xsl:value-of select="advise_thru_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="advise_thru_bank_reference">
					<reference>
						<xsl:value-of select="advise_thru_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Bank role_code="04">
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
				<xsl:if test="credit_available_with_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="credit_available_with_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_name">
					<name>
						<xsl:value-of select="credit_available_with_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="credit_available_with_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="credit_available_with_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="credit_available_with_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_dom">
					<dom>
						<xsl:value-of select="credit_available_with_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_iso_code">
					<iso_code>
						<xsl:value-of select="credit_available_with_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="credit_available_with_bank_reference">
					<reference>
						<xsl:value-of select="credit_available_with_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Bank role_code="05">
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
				<xsl:if test="drawee_details_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="drawee_details_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="drawee_details_bank_name">
					<name>
						<xsl:value-of select="drawee_details_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="drawee_details_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="drawee_details_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="drawee_details_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="drawee_details_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="drawee_details_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="drawee_details_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="drawee_details_bank_dom">
					<dom>
						<xsl:value-of select="drawee_details_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="drawee_details_bank_iso_code">
					<iso_code>
						<xsl:value-of select="drawee_details_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="drawee_details_bank_reference">
					<reference>
						<xsl:value-of select="drawee_details_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.Bank>
			<!-- SWIFT 2018 -->
			<com.misys.portal.product.common.Bank role_code="17">
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
				<xsl:if test="requested_confirmation_party_abbv_name">
					<abbv_name>
						<xsl:value-of select="requested_confirmation_party_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="requested_confirmation_party_name">
					<name>
						<xsl:value-of select="requested_confirmation_party_name"/>
					</name>
				</xsl:if>
				<xsl:if test="requested_confirmation_party_address_line_1">
					<address_line_1>
						<xsl:value-of select="requested_confirmation_party_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="requested_confirmation_party_address_line_2">
					<address_line_2>
						<xsl:value-of select="requested_confirmation_party_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="requested_confirmation_party_dom">
					<dom>
						<xsl:value-of select="requested_confirmation_party_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="requested_confirmation_party_address_line_4">
					<address_line_4>
						<xsl:value-of select="requested_confirmation_party_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="requested_confirmation_party_iso_code">
					<iso_code>
						<xsl:value-of select="requested_confirmation_party_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="requested_confirmation_party_reference">
					<reference>
						<xsl:value-of select="requested_confirmation_party_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Bank role_code="18">
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
				<xsl:if test="first_advising_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="first_advising_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="first_advising_bank_name">
					<name>
						<xsl:value-of select="first_advising_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="first_advising_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="first_advising_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="first_advising_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="first_advising_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="first_advising_bank_dom">
					<dom>
						<xsl:value-of select="first_advising_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="first_advising_bank_line_address__4">
					<address_line_4>
						<xsl:value-of select="first_advising_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="first_advising_bank_iso_code">
					<iso_code>
						<xsl:value-of select="first_advising_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="first_advising_bank_reference">
					<reference>
						<xsl:value-of select="first_advising_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Narrative type_code="01">
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
				<xsl:if test="narrative_description_goods">
					<text>
						<xsl:value-of select="narrative_description_goods"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="02">
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
				<xsl:if test="narrative_documents_required">
					<text>
						<xsl:value-of select="narrative_documents_required"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
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
			<com.misys.portal.product.common.Narrative type_code="04">
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
				<xsl:if test="narrative_charges">
					<text>
						<xsl:value-of select="narrative_charges"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="05">
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
				<xsl:if test="narrative_additional_amount">
					<text>
						<xsl:value-of select="narrative_additional_amount"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="06">
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
				<xsl:if test="narrative_payment_instructions">
					<text>
						<xsl:value-of select="narrative_payment_instructions"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="07">
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
				<xsl:if test="narrative_period_presentation">
					<text>
						<xsl:value-of select="narrative_period_presentation"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="08">
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
				<xsl:if test="narrative_shipment_period">
					<text>
						<xsl:value-of select="narrative_shipment_period"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="09">
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
				<xsl:if test="narrative_sender_to_receiver">
					<text>
						<xsl:value-of select="narrative_sender_to_receiver"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="10">
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
				<xsl:if test="narrative_full_details">
					<text>
						<xsl:value-of select="narrative_full_details"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
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
			
				<xsl:if test="return_comments">
					<com.misys.portal.product.common.Narrative
						type_code="20">
						<xsl:attribute name="ref_id"><xsl:value-of select="ref_id" /></xsl:attribute>
						<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id" /></xsl:attribute>
						<xsl:if test="brch_code">
							<brch_code>
								<xsl:value-of select="brch_code" />
							</brch_code>
						</xsl:if>
						<xsl:if test="company_id">
							<company_id>
								<xsl:value-of select="company_id" />
							</company_id>
						</xsl:if>
						<!-- <xsl:if test="return_comments"> -->
							<text>
								<xsl:value-of select="return_comments" />
							</text>
						<!-- </xsl:if> -->
					</com.misys.portal.product.common.Narrative>
					
				</xsl:if>
			<!-- SWIFT 2018 -->
			<com.misys.portal.product.common.Narrative type_code="40">
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
				<xsl:if test="narrative_special_beneficiary">
					<text>
						<xsl:value-of select="narrative_special_beneficiary"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
				<com.misys.portal.product.common.Narrative type_code="41">
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
				<xsl:if test="narrative_special_recvbank">
					<text>
						<xsl:value-of select="narrative_special_recvbank"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="42">
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
				<xsl:if test="narrative_amend_charges_other">
					<text>
						<xsl:value-of select="narrative_amend_charges_other"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="43">
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
				<xsl:if test="narrative_legacy_partial_shipment">
					<text>
						<xsl:value-of select="narrative_legacy_partial_shipment"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="44">
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
				<xsl:if test="narrative_legacy_tran_shipment">
					<text>
						<xsl:value-of select="narrative_legacy_tran_shipment"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="45">
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
				<xsl:if test="narrative_legacy_period_of_presentation">
					<text>
						<xsl:value-of select="narrative_legacy_period_of_presentation"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="46">
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
				<xsl:if test="narrative_legacy_max_credit_amount">
					<text>
						<xsl:value-of select="narrative_legacy_max_credit_amount"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			
			<com.misys.portal.product.common.Narrative type_code="48">
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
				<xsl:if test="narrative_transfer_conditions">
					<text>
						<xsl:value-of select="narrative_transfer_conditions"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			
			<com.misys.portal.product.common.Narrative type_code="62">
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
				<xsl:if test="narrative_delivery_to">
					<text>
						<xsl:value-of select="narrative_delivery_to"/>
					</text>
				</xsl:if>
		  </com.misys.portal.product.common.Narrative>
						
			<!-- Create Document elements -->
			<xsl:for-each select="//*[starts-with(name(), 'documents_details_code_')]">
				<xsl:call-template name="DOCUMENT">
					<xsl:with-param name="brchCode"><xsl:value-of select="//ec_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//ec_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//ec_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//ec_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'documents_details_code_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			<!-- Create Charge element -->
			
			<!-- First, those charges belonging to the current transaction -->
			<xsl:for-each select="//*[starts-with(name(), 'charge_details_chrg_details_')]">
				<xsl:call-template name="CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="/*/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="/*/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="/*/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="/*/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'charge_details_chrg_details_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!-- Second, the charges inputted earlier -->
			<xsl:for-each select="//*[starts-with(name(), 'old_charge_details_position_')]">
				<xsl:call-template name="OLD_CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="/*/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="/*/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="/*/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="/*/tnx_id"/></xsl:with-param>
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
