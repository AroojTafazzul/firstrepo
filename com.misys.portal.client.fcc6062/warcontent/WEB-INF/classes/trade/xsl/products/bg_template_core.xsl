<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="utils">
	<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
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
	<!-- Process BG template-->
	<xsl:template match="bg_tnx_record">
		<result>
			<com.misys.portal.product.bg.common.TemplateBankerGuarantee>
				<xsl:if test="template_id">
					<xsl:attribute name="template_id">
						<xsl:value-of select="template_id"/>
					</xsl:attribute>
				</xsl:if>
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
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>	
				<xsl:if test="template_description">
					<template_description>
						<xsl:value-of select="template_description"/>
					</template_description>
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
				<xsl:if test="provisional_status">
					<provisional_status>
						<xsl:value-of select="provisional_status"/>
					</provisional_status>
				</xsl:if>
				<xsl:if test="bg_rule">
					<bg_rule>
						<xsl:value-of select="bg_rule"/>
					</bg_rule>
				</xsl:if>
				<xsl:if test="bg_rule_other">
					<bg_rule_other>
						<xsl:value-of select="bg_rule_other"/>
					</bg_rule_other>
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
				<xsl:if test="bg_release_flag">
					<bg_release_flag>
						<xsl:value-of select="bg_release_flag"/>
					</bg_release_flag>
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
						<xsl:value-of select="utils:decryptApplicantReference(applicant_reference)"/>
					</applicant_reference>
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
				<xsl:if test="bg_code">
					<bg_code>
						<xsl:value-of select="bg_code"/>
					</bg_code>
				</xsl:if>
				<xsl:if test="exp_event">
					<exp_event>
						<xsl:value-of select="exp_event"/>
					</exp_event>
				</xsl:if>
				<xsl:if test="for_account">
					<for_account>
						<xsl:value-of select="for_account"/>
					</for_account>
				</xsl:if>
				<xsl:if test="adv_bank_conf_req">
					<adv_bank_conf_req>
						<xsl:value-of select="adv_bank_conf_req"/>
					</adv_bank_conf_req>
				</xsl:if>
				<xsl:if test="consortium">
					<consortium>
						<xsl:value-of select="consortium"/>
					</consortium>
				</xsl:if>
				<xsl:if test="consortium_details">
					<consortium_details>
						<xsl:value-of select="consortium_details"/>
					</consortium_details>
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
				<xsl:if test="character_commitment">
					<character_commitment>
						<xsl:value-of select="character_commitment"/>
					</character_commitment>
				</xsl:if>
				<xsl:if test="delivery_to">
					<delivery_to>
						<xsl:value-of select="delivery_to"/>
					</delivery_to>
				</xsl:if>
				<xsl:if test="delivery_to_other">
					<delivery_to_other>
						<xsl:value-of select="delivery_to_other"/>
					</delivery_to_other>
				</xsl:if>
				<xsl:if test="alt_applicant_name">
					<alt_applicant_name>
						<xsl:value-of select="alt_applicant_name"/>
					</alt_applicant_name>
				</xsl:if>
				<xsl:if test="alt_applicant_address_line_1">
					<alt_applicant_address_line_1>
						<xsl:value-of select="alt_applicant_address_line_1"/>
					</alt_applicant_address_line_1>
				</xsl:if>
				<xsl:if test="alt_applicant_address_line_2">
					<alt_applicant_address_line_2>
						<xsl:value-of select="alt_applicant_address_line_2"/>
					</alt_applicant_address_line_2>
				</xsl:if>
				<xsl:if test="alt_applicant_address_line_4">
					<alt_applicant_address_line_4>
						<xsl:value-of select="alt_applicant_address_line_4"/>
					</alt_applicant_address_line_4>
				</xsl:if>
				<xsl:if test="alt_applicant_dom">
					<alt_applicant_dom>
						<xsl:value-of select="alt_applicant_dom"/>
					</alt_applicant_dom>
				</xsl:if>
				<xsl:if test="alt_applicant_country">
					<alt_applicant_country>
						<xsl:value-of select="alt_applicant_country"/>
					</alt_applicant_country>
				</xsl:if>
				<xsl:if test="contact_name">
					<contact_name>
						<xsl:value-of select="contact_name"/>
					</contact_name>
				</xsl:if>
				<xsl:if test="contact_address_line_1">
					<contact_address_line_1>
						<xsl:value-of select="contact_address_line_1"/>
					</contact_address_line_1>
				</xsl:if>
				<xsl:if test="contact_address_line_2">
					<contact_address_line_2>
						<xsl:value-of select="contact_address_line_2"/>
					</contact_address_line_2>
				</xsl:if>
				<xsl:if test="contact_address_line_4">
					<contact_address_line_4>
						<xsl:value-of select="contact_address_line_4"/>
					</contact_address_line_4>
				</xsl:if>
				<xsl:if test="contact_dom">
					<contact_dom>
						<xsl:value-of select="contact_dom"/>
					</contact_dom>
				</xsl:if>
				<xsl:if test="contact_country">
					<contact_country>
						<xsl:value-of select="contact_country"/>
					</contact_country>
				</xsl:if>
				<xsl:if test="guarantee_type_company_id">
					<guarantee_type_company_id>
						<xsl:value-of select="guarantee_type_company_id"/>
					</guarantee_type_company_id>
				</xsl:if>
				<xsl:if test="guarantee_type_name">
					<guarantee_type_name>
						<xsl:value-of select="guarantee_type_name"/>
					</guarantee_type_name>
				</xsl:if>
				<xsl:if test="lead_bank_flag">
					<lead_bank_flag>
						<xsl:value-of select="lead_bank_flag"/>
					</lead_bank_flag>
				</xsl:if>
				<!-- Renewal details added  START -->
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
				
				<!-- Renewal details added  END -->
				<xsl:if test="beneficiary_email">
					<additional_field name="beneficiary_email" type="string" scope="master">
						<xsl:value-of select="beneficiary_email"/>
					</additional_field>
				</xsl:if>	
				<xsl:if test="beneficiary_contact_number">
					<additional_field name="beneficiary_contact_number" type="string" scope="master" description="beneficiary_contact_number">
						<xsl:value-of select="beneficiary_contact_number"/>
					</additional_field>
				</xsl:if>	
				<xsl:if test="beneficiary_fax_num">
					<additional_field name="beneficiary_fax_num" type="string" scope="master" description="beneficiary_fax_num">
						<xsl:value-of select="beneficiary_fax_num"/>
					</additional_field>
				</xsl:if>								
				<xsl:if test="ordering_party_name">
					<additional_field name="ordering_party_name" type="string" scope="master" description="Ordering Party Name">
						<xsl:value-of select="ordering_party_name"/>
					</additional_field>
				</xsl:if>				
				<xsl:if test="ordering_party_address_line_1">
					<additional_field name="ordering_party_address_line_1" type="string" scope="master" description="Ordering Party Address Address Line 1">
						<xsl:value-of select="ordering_party_address_line_1"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="ordering_party_address_line_2">
					<additional_field name="ordering_party_address_line_2" type="string" scope="master" description="Ordering Party Address Address Line 2">
						<xsl:value-of select="ordering_party_address_line_2"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="ordering_party_address_line_4">
					<additional_field name="ordering_party_address_line_4" type="string" scope="master" description="Ordering Party Address Address Line 4">
						<xsl:value-of select="ordering_party_address_line_4"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="ordering_party_address_dom">
					<additional_field name="ordering_party_address_dom" type="string" scope="master" description="Ordering Party Address Dom">
						<xsl:value-of select="ordering_party_address_dom"/>
					</additional_field>
				</xsl:if>				
				<xsl:if test="ordering_party_contact_name">
					<additional_field name="ordering_party_contact_name" type="string" scope="master" description="Ordering Party Contact Name">
						<xsl:value-of select="ordering_party_contact_name"/>
					</additional_field>
				</xsl:if>				
				<xsl:if test="ordering_party_phone">
					<additional_field name="ordering_party_phone" type="string" scope="master" description="Ordering Party Contact Phone Number">
						<xsl:value-of select="ordering_party_phone"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bg_guarantee_purpose">
					<additional_field name="bg_guarantee_purpose" type="string" scope="master" description="bg_guarantee_purpose">
						<xsl:value-of select="bg_guarantee_purpose"/>
					</additional_field>
				</xsl:if>				
				<xsl:if test="bg_claim_period">
					<additional_field name="bg_claim_period" type="string" scope="master" description="Claim Period">
						<xsl:value-of select="bg_claim_period"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bg_renewal">
					<additional_field name="bg_renewal" type="string" scope="master" description="Renewal Check box">
						<xsl:value-of select="bg_renewal"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bg_previous_guarantee_reference">
					<additional_field name="bg_previous_guarantee_reference" type="string" scope="master" description="Previous Guarantee Reference">
						<xsl:value-of select="bg_previous_guarantee_reference"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bg_gurantee_purpose">
					<additional_field name="bg_gurantee_purpose" type="string" scope="master" description="bg_gurantee_purpose">
						<xsl:value-of select="bg_gurantee_purpose"/>
					</additional_field>
				</xsl:if>	
				<xsl:if test="stylesheetname">
					<additional_field name="stylesheetname" type="string" scope="master" description="stylesheetname">
						<xsl:value-of select="stylesheetname"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="document_id">
					<additional_field name="document_id" type="string" scope="master">
						<xsl:value-of select="document_id"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="margin_indicator">
			 		<additional_field name="margin_indicator" type="string" scope="master" description="Margin_deposit_indicator">
						<xsl:value-of select="margin_indicator"/>
					 </additional_field>
				</xsl:if>
				<!-- Domestic Guarantees -->
				<xsl:if test="form_mask">
					<additional_field name="form_mask" scope="master" type="string">
						<xsl:value-of select="form_mask"/>
					</additional_field>
				</xsl:if>
				<!-- Re authentication -->
				<xsl:call-template name="AUTHENTICATION"/>
				<!-- collaboration -->
				<xsl:call-template name="collaboration" />
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.product.bg.common.TemplateBankerGuarantee>
			<com.misys.portal.product.common.TemplateBank role_code="09">
				<xsl:if test="template_id">
					<xsl:attribute name="template_id">
						<xsl:value-of select="template_id"/>
					</xsl:attribute>
				</xsl:if>
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
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateBank role_code="01">
				<xsl:if test="template_id">
					<xsl:attribute name="template_id">
						<xsl:value-of select="template_id"/>
					</xsl:attribute>
				</xsl:if>
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
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateBank role_code="10">
				<xsl:if test="template_id">
					<xsl:attribute name="template_id">
						<xsl:value-of select="template_id"/>
					</xsl:attribute>
				</xsl:if>
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
				<xsl:if test="confirming_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="confirming_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="confirming_bank_name">
					<name>
						<xsl:value-of select="confirming_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="confirming_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="confirming_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="confirming_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="confirming_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="confirming_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="confirming_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="confirming_bank_dom">
					<dom>
						<xsl:value-of select="confirming_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="confirming_bank_iso_code">
					<iso_code>
						<xsl:value-of select="confirming_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="confirming_bank_reference">
					<reference>
						<xsl:value-of select="confirming_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateBank role_code="02">
				<xsl:if test="template_id">
					<xsl:attribute name="template_id">
						<xsl:value-of select="template_id"/>
					</xsl:attribute>
				</xsl:if>
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
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateNarrative type_code="03">
				<xsl:if test="template_id">
					<xsl:attribute name="template_id">
						<xsl:value-of select="template_id"/>
					</xsl:attribute>
				</xsl:if>
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
				<xsl:if test="narrative_additional_instructions">
					<text>
						<xsl:value-of select="narrative_additional_instructions"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateBank role_code="16">
				<xsl:if test="template_id">
					<xsl:attribute name="template_id">
						<xsl:value-of select="template_id"/>
					</xsl:attribute>
				</xsl:if>
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
				<xsl:if test="processing_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="processing_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="processing_bank_name">
					<name>
						<xsl:value-of select="processing_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="processing_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="processing_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="processing_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="processing_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="processing_bank_address_line_4">
					<address_line_4>
						<xsl:value-of select="processing_bank_address_line_4"/>
					</address_line_4>
				</xsl:if>
				<xsl:if test="processing_bank_dom">
					<dom>
						<xsl:value-of select="processing_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="processing_bank_iso_code">
					<iso_code>
						<xsl:value-of select="processing_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="processing_bank_reference">
					<reference>
						<xsl:value-of select="processing_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
