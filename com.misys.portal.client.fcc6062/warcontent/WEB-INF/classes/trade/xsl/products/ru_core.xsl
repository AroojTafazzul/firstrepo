<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
				exclude-result-prefixes="localization service utils">
	<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>

	<!-- Common elements to save among all products -->
	<xsl:include href="../../../core/xsl/products/save_common.xsl"/>
	<xsl:variable name="brch_code" select="'00001'"/>
	<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" /> 
	<xsl:variable name="creditType"><xsl:value-of select="credit_available_with_bank/name"/></xsl:variable>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process BR-->
	<xsl:template match="br_tnx_record">
		<result>
			<com.misys.portal.product.ru.common.ReceivedUndertaking>
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
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
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
				<xsl:if test="sub_product_code">
					<sub_product_code>
						<xsl:value-of select="sub_product_code"/>
					</sub_product_code>
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
				<xsl:if test="text_type_code">
					<text_type_code>
						<xsl:value-of select="text_type_code"/>
					</text_type_code>
				</xsl:if>
				<xsl:if test="bg_type_details">
					<bg_type_details>
						<xsl:value-of select="bg_type_details"/>
					</bg_type_details>
				</xsl:if>
				<xsl:if test="bg_rule">
					<bg_rule>
						<xsl:value-of select="bg_rule"/>
					</bg_rule>
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
				<!--
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
				-->
				<!-- Renewal details added  START -->
				<xsl:if test="renew_flag">
					<renew_flag>
						<xsl:value-of select="renew_flag"/>
					</renew_flag>
				</xsl:if>
				<xsl:if test="renewal_type">
					<renewal_type>
						<xsl:value-of select="renewal_type"/>
					</renewal_type>
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
				<xsl:if test="rolling_day_in_month">
					<rolling_day_in_month>
						<xsl:value-of select="rolling_day_in_month"/>
					</rolling_day_in_month>
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
				<!-- Renewal details added  END -->
				<xsl:if test="bg_release_flag">
					<bg_release_flag>
						<xsl:value-of select="bg_release_flag"/>
					</bg_release_flag>
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
				<xsl:if test="related_ref">
					<related_ref>
						<xsl:value-of select="related_ref"/>
					</related_ref>
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
				<xsl:if test="maturity_date">
					<maturity_date>
						<xsl:value-of select="maturity_date"/>
					</maturity_date>
				</xsl:if>
				<xsl:if test="latest_response_date">
					<latest_response_date>
						<xsl:value-of select="latest_response_date"/>
					</latest_response_date>
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
				<xsl:if test="delivery_channel">
					<delivery_channel>
						<xsl:value-of select="delivery_channel"/>
					</delivery_channel>
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
				<!-- Security -->
				<xsl:if test="token">
					<additional_field name="token" type="string" scope="none" description="Security token">
						<xsl:value-of select="token"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="purpose">
					<purpose>
						<xsl:value-of select="purpose"/>
					</purpose>
				</xsl:if>
				<xsl:if test="open_chrg_brn_by_code">
					<open_chrg_brn_by_code>
						<xsl:value-of select="open_chrg_brn_by_code"/>
					</open_chrg_brn_by_code>
				</xsl:if>
                <xsl:if test="corr_chrg_brn_by_code">
					<corr_chrg_brn_by_code>
						<xsl:value-of select="corr_chrg_brn_by_code"/>
					</corr_chrg_brn_by_code>
				</xsl:if>
				<xsl:if test="delivery_to">
					<delivery_to>
						<xsl:value-of select="delivery_to"/>
					</delivery_to>
				</xsl:if>
				<xsl:if test="ntrf_flag">
					<ntrf_flag>
						<xsl:value-of select="ntrf_flag"/>
					</ntrf_flag>
				</xsl:if>
				<xsl:if test="cfm_inst_code">
					<cfm_inst_code>
						<xsl:value-of select="cfm_inst_code"/>
					</cfm_inst_code>
				</xsl:if>
				<xsl:if test="bg_demand_indicator">
					<bg_demand_indicator>
						<xsl:value-of select="bg_demand_indicator"/>
					</bg_demand_indicator>
				</xsl:if>
				<xsl:if test="bg_govern_country">
					<bg_govern_country>
						<xsl:value-of select="bg_govern_country"/>
					</bg_govern_country>
				</xsl:if>
				<xsl:if test="bg_govern_text">
					<bg_govern_text>
						<xsl:value-of select="bg_govern_text"/>
					</bg_govern_text>
				</xsl:if>
				<xsl:if test="delivery_to_other">
					<delivery_to_other>
						<xsl:value-of select="delivery_to_other"/>
					</delivery_to_other>
				</xsl:if>
				<xsl:if test="tolerance_positive_pct">
					<tolerance_positive_pct>
						<xsl:value-of select="tolerance_positive_pct"/>
					</tolerance_positive_pct>
				</xsl:if>
				<xsl:if test="tolerance_negative_pct">
					<tolerance_negative_pct>
						<xsl:value-of select="tolerance_negative_pct"/>
					</tolerance_negative_pct>
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

				<!-- Shipment Details START-->
				<xsl:if test="ship_from">
					<ship_from>
						<xsl:value-of select="ship_from"/>
					</ship_from>
				</xsl:if>
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
				<xsl:if test="ship_to">
					<ship_to>
						<xsl:value-of select="ship_to"/>
					</ship_to>
				</xsl:if>
				<xsl:if test="part_ship_detl">
					<part_ship_detl>
						<xsl:value-of select="part_ship_detl"/>
					</part_ship_detl>
				</xsl:if>
				<xsl:if test="tran_ship_detl">
					<tran_ship_detl>
						<xsl:value-of select="tran_ship_detl"/>
					</tran_ship_detl>
				</xsl:if>
				<xsl:if test="last_ship_date">
					<last_ship_date>
						<xsl:value-of select="last_ship_date"/>
					</last_ship_date>
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
				<!-- Shipment Details END-->
				
				<!-- Credit Available By -->
				<xsl:if test="cr_avl_by_code">
					<cr_avl_by_code>
						<xsl:value-of select="cr_avl_by_code"/>
					</cr_avl_by_code>
				</xsl:if>
				<!-- Credit Available By End -->
				<xsl:if test="not(additional_field[@name='credit_available_with_bank_type'])">
					<xsl:choose>
					<xsl:when test="credit_available_with_bank/name[.='Issuing Bank'] or credit_available_with_bank/name[.='Advising Bank'] or credit_available_with_bank/name[.='Any Bank']">
		      		<additional_field name = "credit_available_with_bank_type" type ="string" scope="master">
						<xsl:value-of select="credit_available_with_bank/name"/>
					</additional_field>
					</xsl:when>
					<xsl:otherwise>
					<additional_field name = "credit_available_with_bank_type" type ="string" scope="master">
						 <xsl:value-of select="localization:getGTPString('en', 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_OTHER')"/>
					</additional_field>
					</xsl:otherwise>
					</xsl:choose>
					</xsl:if>
					<xsl:if test="credit_available_with_bank_type">
							<additional_field name="credit_available_with_bank_type"
						type="string" scope="master">
								<xsl:value-of select="credit_available_with_bank_type"/>
							</additional_field>
				</xsl:if>
				<xsl:if test="additional_cust_ref">
					<additional_cust_ref>
						<xsl:value-of select="additional_cust_ref"/>
					</additional_cust_ref>
				</xsl:if>
				<xsl:if test="approx_expiry_date">
					<approx_expiry_date>
						<xsl:value-of select="approx_expiry_date"/>
					</approx_expiry_date>
				</xsl:if>
				<xsl:if test="delv_org_undertaking">
					<delv_org_undertaking>
						<xsl:value-of select="delv_org_undertaking"/>
					</delv_org_undertaking>
				</xsl:if>
				<xsl:if test="delv_org_undertaking_text">
					<delv_org_undertaking_text>
						<xsl:value-of select="delv_org_undertaking_text"/>
					</delv_org_undertaking_text>
				</xsl:if>
				<xsl:if test="issuing_bank_reference">
					<issuing_bank_reference>
						<xsl:value-of select="issuing_bank_reference"/>
					</issuing_bank_reference>
				</xsl:if>
				<xsl:if test="send_attachments_by">
					<send_attachments_by>
						<xsl:value-of select="send_attachments_by"/>
					</send_attachments_by>
				</xsl:if>
				<xsl:if test="send_attachments_by_other">
					<send_attachments_by_other>
						<xsl:value-of select="send_attachments_by_other"/>
					</send_attachments_by_other>
				</xsl:if>
				<xsl:if test="advise_date">
					<advise_date>
						<xsl:value-of select="advise_date"/>
					</advise_date>
				</xsl:if>
				<xsl:if test="conf_chrg_brn_by_code">
					<conf_chrg_brn_by_code>
						<xsl:value-of select="conf_chrg_brn_by_code"/>
					</conf_chrg_brn_by_code>
				</xsl:if>
				<xsl:if test="bg_rule_other">
					<bg_rule_other>
						<xsl:value-of select="bg_rule_other"/>
					</bg_rule_other>
				</xsl:if>
				<xsl:if test="adv_send_mode_text">
					<adv_send_mode_text>
						<xsl:value-of select="adv_send_mode_text"/>
					</adv_send_mode_text>
				</xsl:if>					

				<!-- Re authentication -->
				<xsl:call-template name="AUTHENTICATION"/>
				<!-- collaboration -->
				<xsl:call-template name="collaboration" />
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.product.ru.common.ReceivedUndertaking>
     
     <!-- Create Charges elements -->
     		<xsl:if test="charges">
				<xsl:apply-templates select="charges/charge">
				<xsl:with-param name="ref_id" select="ref_id"/>
				<xsl:with-param name="tnx_id" select="tnx_id"/>
				<xsl:with-param name="company_id" select="company_id"/>
			</xsl:apply-templates>
			</xsl:if>								
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
				<xsl:if test="recipient_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="recipient_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="recipient_bank_dom">
					<dom>
						<xsl:value-of select="recipient_bank_dom"/>
					</dom>
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
				<xsl:if test="issuing_bank/abbv_name">
					<abbv_name>
						<xsl:value-of select="issuing_bank/abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="issuing_bank/name">
					<name>
						<xsl:value-of select="issuing_bank/name"/>
					</name>
				</xsl:if>
				<xsl:if test="issuing_bank/address_line_1">
					<address_line_1>
						<xsl:value-of select="issuing_bank/address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="issuing_bank/address_line_2">
					<address_line_2>
						<xsl:value-of select="issuing_bank/address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="issuing_bank/dom">
					<dom>
						<xsl:value-of select="issuing_bank/dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="issuing_bank/address_line_4">
					<address_line_4>
						<xsl:value-of select="issuing_bank/address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="issuing_bank/iso_code">
					<iso_code>
						<xsl:value-of select="issuing_bank/iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="issuing_bank/reference">
					<reference>
						<xsl:value-of select="issuing_bank/reference"/>
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
				<xsl:if test="confirming_bank/abbv_name">
					<abbv_name>
						<xsl:value-of select="confirming_bank/abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="confirming_bank/name">
					<name>
						<xsl:value-of select="confirming_bank/name"/>
					</name>
				</xsl:if>
				<xsl:if test="confirming_bank/address_line_1">
					<address_line_1>
						<xsl:value-of select="confirming_bank/address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="confirming_bank/address_line_2">
					<address_line_2>
						<xsl:value-of select="confirming_bank/address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="confirming_bank/dom">
					<dom>
						<xsl:value-of select="confirming_bank/dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="confirming_bank/address_line_4">
					<address_line_4>
						<xsl:value-of select="confirming_bank/address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="confirming_bank/iso_code">
					<iso_code>
						<xsl:value-of select="confirming_bank/iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="confirming_bank/reference">
					<reference>
						<xsl:value-of select="confirming_bank/reference"/>
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
				<xsl:if test="advisethru_bank/abbv_name">
					<abbv_name>
						<xsl:value-of select="advisethru_bank/abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="advisethru_bank/name">
					<name>
						<xsl:value-of select="advisethru_bank/name"/>
					</name>
				</xsl:if>
				<xsl:if test="advisethru_bank/address_line_1">
					<address_line_1>
						<xsl:value-of select="advisethru_bank/address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="advisethru_bank/address_line_2">
					<address_line_2>
						<xsl:value-of select="advisethru_bank/address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="advisethru_bank/dom">
					<dom>
						<xsl:value-of select="advisethru_bank/dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="advisethru_bank/address_line_4">
					<address_line_4>
						<xsl:value-of select="advisethru_bank/address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="advisethru_bank/iso_code">
					<iso_code>
						<xsl:value-of select="advisethru_bank/iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="advisethru_bank/reference">
					<reference>
						<xsl:value-of select="advisethru_bank/reference"/>
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
				<xsl:if test="credit_available_with_bank/abbv_name">
					<abbv_name>
						<xsl:value-of select="credit_available_with_bank/abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="credit_available_with_bank/name">
					<name>
						<xsl:value-of select="credit_available_with_bank/name"/>
					</name>
				</xsl:if>
				<xsl:if test="credit_available_with_bank/address_line_1">
					<address_line_1>
						<xsl:value-of select="credit_available_with_bank/address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="credit_available_with_bank/address_line_2">
					<address_line_2>
						<xsl:value-of select="credit_available_with_bank/address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="credit_available_with_bank/dom">
					<dom>
						<xsl:value-of select="credit_available_with_bank/dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="credit_available_with_bank/address_line_4">
					<address_line_4>
						<xsl:value-of select="credit_available_with_bank/address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="credit_available_with_bank/iso_code">
					<iso_code>
						<xsl:value-of select="credit_available_with_bank/iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="credit_available_with_bank/reference">
					<reference>
						<xsl:value-of select="credit_available_with_bank/reference"/>
					</reference>
				</xsl:if>
				<xsl:if test="credit_available_with_bank/type">
					<type>
						<xsl:value-of select="credit_available_with_bank/type"/>
					</type>
				</xsl:if>
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Narrative type_code="47">
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
				<xsl:if test="narrative_cancellation">
					<text>
						<xsl:value-of select="narrative_cancellation"/>
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
			<com.misys.portal.product.common.Narrative type_code="63">
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
				<xsl:if test="narrative_undertaking_terms_and_conditions">
					<text>
						<xsl:value-of select="narrative_undertaking_terms_and_conditions"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="54">
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
				<xsl:if test="narrative_text_undertaking">
					<text>
						<xsl:value-of select="narrative_text_undertaking"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="49">
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
				<xsl:if test="narrative_underlying_transaction_details">
					<text>
						<xsl:value-of select="narrative_underlying_transaction_details"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative type_code="50">
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
				<xsl:if test="narrative_presentation_instructions">
					<text>
						<xsl:value-of select="narrative_presentation_instructions"/>
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
						
			<xsl:if test="variation">
				 <xsl:apply-templates select="variation/variation_line_item">
					<xsl:with-param name="product_code">BR</xsl:with-param>
				</xsl:apply-templates> 				
			 </xsl:if> 

     <!-- Create Charges elements -->

			<!-- First, those charges belonging to the current transaction -->
			<xsl:for-each select="//*[starts-with(name(), 'charge_details_chrg_details_')]">
				<xsl:call-template name="CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//br_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//br_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//br_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//br_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'charge_details_chrg_details_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!-- Second, the charges inputted earlier -->
			<xsl:for-each select="//*[starts-with(name(), 'old_charge_details_position_')]">
				<xsl:call-template name="OLD_CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//br_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//br_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//br_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//br_tnx_record/tnx_id"/></xsl:with-param>
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
				<xsl:apply-templates select="linked_licenses/license">
				</xsl:apply-templates>
			</xsl:if>
		
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     
         	<!-- Charges -->
	<xsl:template match="charge">
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="company_id"/>
	
		<com.misys.portal.product.common.Charge>
			<!-- keys as attributes --> 
			<xsl:attribute name="chrg_id"><xsl:value-of select="chrg_id"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
			
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
			<xsl:if test="chrg_code">
				<chrg_code><xsl:value-of select="chrg_code"/></chrg_code>
			</xsl:if>
			<xsl:if test="amt">
				<amt><xsl:value-of select="amt"/></amt>
			</xsl:if>
			<xsl:if test="cur_code">
				<cur_code><xsl:value-of select="cur_code"/></cur_code>
			</xsl:if>
			<xsl:if test="status">
				<status><xsl:value-of select="status"/></status>
			</xsl:if>
			<xsl:if test="bearer_role_code">
				<bearer_role_code><xsl:value-of select="bearer_role_code"/></bearer_role_code>
			</xsl:if>
			<xsl:if test="exchange_rate">
				<exchange_rate><xsl:value-of select="exchange_rate"/></exchange_rate>
			</xsl:if>
			<xsl:if test="eqv_amt">
				<eqv_amt><xsl:value-of select="eqv_amt"/></eqv_amt>
			</xsl:if>
			<xsl:if test="eqv_cur_code">
				<eqv_cur_code><xsl:value-of select="eqv_cur_code"/></eqv_cur_code>
			</xsl:if>
			<xsl:if test="additional_comment">
				<additional_comment><xsl:value-of select="additional_comment"/></additional_comment>
			</xsl:if>
			<xsl:if test="inception_date">
				<inception_date><xsl:value-of select="inception_date"/></inception_date>
			</xsl:if>
			<xsl:if test="settlement_date">
				<settlement_date><xsl:value-of select="settlement_date"/></settlement_date>
			</xsl:if>
			<xsl:if test="created_in_session">
				<created_in_session><xsl:value-of select="created_in_session"/></created_in_session>
			</xsl:if>
			<xsl:if test="chrg_type">
				<chrg_type><xsl:value-of select="chrg_type"/></chrg_type>
			</xsl:if>
		</com.misys.portal.product.common.Charge>
	</xsl:template>
     </xsl:stylesheet>