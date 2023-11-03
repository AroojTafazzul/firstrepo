<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="utils">
	<!--
   Copyright (c) 2000-2012 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>

	<!-- Common elements to save among all products -->
	<xsl:include href="../../../core/xsl/products/save_common.xsl"/>
	
	<!-- to include -->	
<!--	<xsl:include href="ft.xsl"/>-->

	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process Template FT-->
	<xsl:template match="ft_tnx_record">
		<result>
			<com.misys.portal.cash.product.ft.common.TemplateFundTransfer>
				<xsl:attribute name="company_id"><xsl:value-of select="company_id"/></xsl:attribute>
				<xsl:attribute name="template_id"><xsl:value-of select="template_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
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
				<xsl:if test="sub_product_code">
					<sub_product_code>
						<xsl:value-of select="sub_product_code"/>
					</sub_product_code>
				</xsl:if>
				<xsl:if test="fwd_contract_no">
					<fwd_contract_no>
						<xsl:value-of select="fwd_contract_no"/>
					</fwd_contract_no>
				</xsl:if>
				<xsl:if test="applicant_act_no">
					<applicant_act_no>
						<xsl:value-of select="applicant_act_no"/>
					</applicant_act_no>
				</xsl:if>
				<xsl:if test="applicant_act_cur_code">
					<applicant_act_cur_code>
						<xsl:value-of select="applicant_act_cur_code"/>
					</applicant_act_cur_code>
				</xsl:if>
				<xsl:if test="applicant_act_name">
					<applicant_act_name>
						<xsl:value-of select="applicant_act_name"/>
					</applicant_act_name>
				</xsl:if>
				<xsl:if test="bo_account_id">
					<additional_field name="bo_account_id" type="string" scope="master">
							<xsl:value-of select="bo_account_id"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bo_account_type">
					<additional_field name="bo_account_type" type="string" scope="master">
							<xsl:value-of select="bo_account_type"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bo_account_currency">
					<additional_field name="bo_account_currency" type="string" scope="master">
							<xsl:value-of select="bo_account_currency"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bo_branch_code">
					<additional_field name="bo_branch_code" type="string" scope="master">
							<xsl:value-of select="bo_branch_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bo_product_type">
					<additional_field name="bo_product_type" type="string" scope="master">
							<xsl:value-of select="bo_product_type"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="applicant_act_description">
					<applicant_act_description>
						<xsl:value-of select="applicant_act_description"/>
					</applicant_act_description>
				</xsl:if>
				<xsl:if test="transfer_from">
					<applicant_act_no>
						<xsl:value-of select="transfer_from"/>
					</applicant_act_no>
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
				  <xsl:if test="urgent_transfer">
            <additional_field name="urgent_transfer" type="string" scope="master">
                <xsl:value-of select="urgent_transfer" />
            </additional_field>
        </xsl:if>			
        <xsl:if test="business_type">
            <additional_field name="business_type" type="string" scope="master">
                <xsl:value-of select="business_type" />
            </additional_field>
        </xsl:if>				
        <xsl:if test="business_detail_type">
            <additional_field name="business_detail_type" type="string" scope="master">
                <xsl:value-of select="business_detail_type" />
            </additional_field>
        </xsl:if>				
        <xsl:if test="cnaps_bank_code">
            <additional_field name="cnaps_bank_code" type="string" scope="master">
                <xsl:value-of select="cnaps_bank_code" />
            </additional_field>
        </xsl:if>				
        <xsl:if test="cnaps_bank_name">
            <additional_field name="cnaps_bank_name" type="string" scope="master">
                <xsl:value-of select="cnaps_bank_name" />
            </additional_field>
        </xsl:if>				
        <xsl:if test="related_transaction_date">
            <additional_field name="related_transaction_date" type="date" scope="master">
                <xsl:value-of select="related_transaction_date" />
            </additional_field>
        </xsl:if>				
        <xsl:if test="cross_border_remark">
            <additional_field name="cross_border_remark" type="string" scope="master">
                <xsl:value-of select="cross_border_remark" />
            </additional_field>
        </xsl:if>				
		  <xsl:if test="routing_identifier_nra">
            <additional_field name="routing_identifier_nra" type="string" scope="master">
                <xsl:value-of select="routing_identifier_nra" />
            </additional_field>
        </xsl:if>
<!--				<xsl:if test="bo_tnx_id">-->
<!--					<bo_tnx_id>-->
<!--						<xsl:value-of select="bo_tnx_id"/>-->
<!--					</bo_tnx_id>-->
<!--				</xsl:if>	-->
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
				<xsl:if test="open_chrg_brn_by_code">
					<open_chrg_brn_by_code>
						<xsl:value-of select="open_chrg_brn_by_code"/>
					</open_chrg_brn_by_code>
				</xsl:if>
				<xsl:if test="template_description">
					<template_description>
						<xsl:value-of select="template_description"/>
					</template_description>
				</xsl:if>
				<xsl:if test="ft_type">
					<ft_type>
						<xsl:value-of select="ft_type"/>
					</ft_type>
				</xsl:if>
				<xsl:if test="ft_cur_code">
					<ft_cur_code>
						<xsl:value-of select="ft_cur_code"/>
					</ft_cur_code>
				</xsl:if>
				<xsl:if test="ft_amt">
					<ft_amt>
						<xsl:value-of select="ft_amt"/>
					</ft_amt>
				</xsl:if>
				<xsl:if test="cust_ref_id">
					<cust_ref_id>
						<xsl:value-of select="cust_ref_id"/>
					</cust_ref_id>
				</xsl:if>
				<xsl:if test="applicant_country">
					<applicant_country>
						<xsl:value-of select="applicant_country"/>
					</applicant_country>
				</xsl:if>
				<xsl:if test="priority">
					<priority>
						<xsl:value-of select="priority"/>
					</priority>					
				</xsl:if>
				<xsl:if test="adv_send_mode">
					<adv_send_mode>
						<xsl:value-of select="adv_send_mode"/>
					</adv_send_mode>
				</xsl:if>				
				
				<!-- Paper Instruments Additional fields START -->				
				<xsl:if test="beneficiary_name_2">
					<additional_field name="beneficiary_name_2" type="string" scope="master">
						<xsl:value-of select="beneficiary_name_2"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="beneficiary_name_3">
					<additional_field name="beneficiary_name_3" type="string" scope="master">
						<xsl:value-of select="beneficiary_name_3"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="beneficiary_address_line_4">
					<additional_field name="beneficiary_address_line_4" type="string" scope="master">
						<xsl:value-of select="beneficiary_address_line_4"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="beneficiary_postal_code">
					<additional_field name="beneficiary_postal_code" type="string" scope="master">
						<xsl:value-of select="beneficiary_postal_code"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="drawn_on_country">
					<additional_field name="drawn_on_country" type="string" scope="master">
						<xsl:value-of select="drawn_on_country"/>
					</additional_field>
				</xsl:if>
								
				<xsl:if test="collecting_bank_code">
					<additional_field name="collecting_bank_code" type="string" scope="master">
						<xsl:value-of select="collecting_bank_code"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="collecting_branch_code">
					<additional_field name="collecting_branch_code" type="string" scope="master">
						<xsl:value-of select="collecting_branch_code"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="collectors_name">
					<additional_field name="collectors_name" type="string" scope="master">
						<xsl:value-of select="collectors_name"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="collectors_id">
					<additional_field name="collectors_id" type="string" scope="master">
						<xsl:value-of select="collectors_id"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="mailing_other_name_address">
					<additional_field name="mailing_other_name_address" type="string" scope="master">
						<xsl:value-of select="mailing_other_name_address"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="mailing_other_postal_code">
					<additional_field name="mailing_other_postal_code" type="string" scope="master">
						<xsl:value-of select="mailing_other_postal_code"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="mailing_other_country">
					<additional_field name="mailing_other_country" type="string" scope="master">
						<xsl:value-of select="mailing_other_country"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="has_intermediary">
					<additional_field name="has_intermediary" type="string" scope="master">
						<xsl:value-of select="has_intermediary"/>
					</additional_field>
				</xsl:if>
			 
			    <!-- Paper Instruments Additional fields END -->
			
				<!-- Remittance Additional fields -->	
				<xsl:if test="pre_approved">
					<additional_field name="pre_approved" type="string" scope="master">
						<xsl:value-of select="pre_approved"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="pre_approved_status">
					<additional_field name="pre_approved_status" type="string" scope="master">
						<xsl:value-of select="pre_approved_status"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="applicant_act_pab">
					<additional_field name="applicant_act_pab" type="string" scope="master">
						<xsl:value-of select="applicant_act_pab"/>
					</additional_field>
				</xsl:if>	
				<xsl:if test="beneficiary_mode">
					<additional_field name="beneficiary_mode" type="string" scope="master">
						<xsl:value-of select="beneficiary_mode"/>
					</additional_field>
				</xsl:if>						
				<xsl:if test="transfer_from">
					<additional_field name="transfer_from" type="string" scope="master">
						<xsl:value-of select="transfer_from"/>
					</additional_field>
				</xsl:if>				
				<xsl:if test="product_type">
					<additional_field name="product_type" type="string" scope="master">
						<xsl:value-of select="product_type"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="ordering_customer_name">
					<additional_field name="ordering_customer_name" type="string" scope="master">
						<xsl:value-of select="ordering_customer_name"/>
					</additional_field>
				</xsl:if>							
				<xsl:if test="ordering_customer_address_line_1">
					<additional_field name="ordering_customer_address_line_1" type="string" scope="master">
						<xsl:value-of select="ordering_customer_address_line_1"/>
					</additional_field>
				</xsl:if>			
				<xsl:if test="ordering_customer_address_line_2">
					<additional_field name="ordering_customer_address_line_2" type="string" scope="master">
						<xsl:value-of select="ordering_customer_address_line_2"/>
					</additional_field>
				</xsl:if>			
				<xsl:if test="ordering_customer_dom">
					<additional_field name="ordering_customer_dom" type="string" scope="master">
						<xsl:value-of select="ordering_customer_dom"/>
					</additional_field>
				</xsl:if>			
				<xsl:if test="ordering_customer_account">
					<additional_field name="ordering_customer_account" type="string" scope="master">
						<xsl:value-of select="ordering_customer_account"/>
					</additional_field>
				</xsl:if>			
				<xsl:if test="ordering_customer_swift_bic_code">
					<additional_field name="ordering_customer_swift_bic_code" type="string" scope="master">
						<xsl:value-of select="ordering_customer_swift_bic_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="ordering_customer_bank_swift_bic_code">
					<additional_field name="ordering_customer_bank_swift_bic_code" type="string" scope="master">
						<xsl:value-of select="ordering_customer_bank_swift_bic_code"/>
					</additional_field>
				</xsl:if>			
				<xsl:if test="ordering_customer_bank_name">
					<additional_field name="ordering_customer_bank_name" type="string" scope="master">
						<xsl:value-of select="ordering_customer_bank_name"/>
					</additional_field>
				</xsl:if>							
				<xsl:if test="ordering_customer_bank_address_line_1">
					<additional_field name="ordering_customer_bank_address_line_1" type="string" scope="master">
						<xsl:value-of select="ordering_customer_bank_address_line_1"/>
					</additional_field>
				</xsl:if>			
				<xsl:if test="ordering_customer_bank_address_line_2">
					<additional_field name="ordering_customer_bank_address_line_2" type="string" scope="master">
						<xsl:value-of select="ordering_customer_bank_address_line_2"/>
					</additional_field>
				</xsl:if>			
				<xsl:if test="ordering_customer_bank_dom">
					<additional_field name="ordering_customer_bank_dom" type="string" scope="master">
						<xsl:value-of select="ordering_customer_bank_dom"/>
					</additional_field>
				</xsl:if>				
				<xsl:if test="ordering_customer_bank_country">
					<additional_field name="ordering_customer_bank_country" type="string" scope="master">
						<xsl:value-of select="ordering_customer_bank_country"/>
					</additional_field>
				</xsl:if>									
				<xsl:if test="ordering_customer_bank_account">
					<additional_field name="ordering_customer_bank_account" type="string" scope="master">
						<xsl:value-of select="ordering_customer_bank_account"/>
					</additional_field>
				</xsl:if>	
										
				<xsl:if test="ordering_institution_swift_bic_code">
					<additional_field name="ordering_institution_swift_bic_code" type="string" scope="master">
						<xsl:value-of select="ordering_institution_swift_bic_code"/>
					</additional_field>
				</xsl:if>	
				<xsl:if test="ordering_institution_name">
					<additional_field name="ordering_institution_name" type="string" scope="master">
						<xsl:value-of select="ordering_institution_name"/>
					</additional_field>
				</xsl:if>							
				<xsl:if test="ordering_institution_address_line_1">
					<additional_field name="ordering_institution_address_line_1" type="string" scope="master">
						<xsl:value-of select="ordering_institution_address_line_1"/>
					</additional_field>
				</xsl:if>			
				<xsl:if test="ordering_institution_address_line_2">
					<additional_field name="ordering_institution_address_line_2" type="string" scope="master">
						<xsl:value-of select="ordering_institution_address_line_2"/>
					</additional_field>
				</xsl:if>			
				<xsl:if test="ordering_institution_dom">
					<additional_field name="ordering_institution_dom" type="string" scope="master">
						<xsl:value-of select="ordering_institution_dom"/>
					</additional_field>
				</xsl:if>			
				<xsl:if test="ordering_institution_country">
					<additional_field name="ordering_institution_country" type="string" scope="master">
						<xsl:value-of select="ordering_institution_country"/>
					</additional_field>
				</xsl:if>			
				<xsl:if test="ordering_institution_account">
					<additional_field name="ordering_institution_account" type="string" scope="master">
						<xsl:value-of select="ordering_institution_account"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_email_1">
					<additional_field name="bene_email_1" type="string" scope="master">
						<xsl:value-of select="bene_email_1"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_email_no_send">
					<additional_field name="bene_adv_email_no_send" type="string" scope="master">
						<xsl:value-of select="bene_adv_email_no_send"/>
					</additional_field>
				</xsl:if>							
				<xsl:if test="beneficiary_institution_swift_bic_code">
					<additional_field name="beneficiary_institution_swift_bic_code" type="string" scope="master">
						<xsl:value-of select="beneficiary_institution_swift_bic_code"/>
					</additional_field>
				</xsl:if>					
				<xsl:if test="branch_address_flag">
					<additional_field name="branch_address_flag" type="string" scope="master">
						<xsl:value-of select="branch_address_flag"/>
					</additional_field>
				</xsl:if>								
				<xsl:if test="beneficiary_bank_clearing_code">
					<additional_field name="beneficiary_bank_clearing_code" type="string" scope="master">
						<xsl:value-of select="beneficiary_bank_clearing_code"/>
					</additional_field>
				</xsl:if>				
				<xsl:if test="beneficiary_bank_clearing_code_desc">
					<additional_field name="beneficiary_bank_clearing_code_desc" type="string" scope="master">
						<xsl:value-of select="beneficiary_bank_clearing_code_desc"/>
					</additional_field>
				</xsl:if>				
				<xsl:if test="intermediary_bank_swift_bic_code">
					<additional_field name="intermediary_bank_swift_bic_code" type="string" scope="master">
						<xsl:value-of select="intermediary_bank_swift_bic_code"/>
					</additional_field>
				</xsl:if>					
				<xsl:if test="intermediary_bank_name">
					<additional_field name="intermediary_bank_name" type="string" scope="master">
						<xsl:value-of select="intermediary_bank_name"/>
					</additional_field>
				</xsl:if>							
				<xsl:if test="intermediary_bank_address_line_1">
					<additional_field name="intermediary_bank_address_line_1" type="string" scope="master">
						<xsl:value-of select="intermediary_bank_address_line_1"/>
					</additional_field>
				</xsl:if>			
				<xsl:if test="intermediary_bank_address_line_2">
					<additional_field name="intermediary_bank_address_line_2" type="string" scope="master">
						<xsl:value-of select="intermediary_bank_address_line_2"/>
					</additional_field>
				</xsl:if>			
				<xsl:if test="intermediary_bank_dom">
					<additional_field name="intermediary_bank_dom" type="string" scope="master">
						<xsl:value-of select="intermediary_bank_dom"/>
					</additional_field>
				</xsl:if>				
				<xsl:if test="intermediary_bank_country">
					<additional_field name="intermediary_bank_country" type="string" scope="master">
						<xsl:value-of select="intermediary_bank_country"/>
					</additional_field>
				</xsl:if>				
				<xsl:if test="intermediary_bank_clearing_code">
					<additional_field name="intermediary_bank_clearing_code" type="string" scope="master">
						<xsl:value-of select="intermediary_bank_clearing_code"/>
					</additional_field>
				</xsl:if>				
				<xsl:if test="intermediary_bank_clearing_code_desc">
					<additional_field name="intermediary_bank_clearing_code_desc" type="string" scope="master">
						<xsl:value-of select="intermediary_bank_clearing_code_desc"/>
					</additional_field>
				</xsl:if>			
				<xsl:if test="charge_option">
					<additional_field name="charge_option" type="string" scope="master">
						<xsl:value-of select="charge_option"/>
					</additional_field>
				</xsl:if>						
				<xsl:if test="related_reference">
					<additional_field name="related_reference" type="string" scope="master">
						<xsl:value-of select="related_reference"/>
					</additional_field>
				</xsl:if>		
				<xsl:if test="customer_reference">
					<additional_field name="customer_reference" type="string" scope="master">
						<xsl:value-of select="customer_reference"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="payment_details_to_beneficiary">
					<additional_field name="payment_details_to_beneficiary" type="text" scope="master">
						<xsl:value-of select="payment_details_to_beneficiary"/>
					</additional_field>
				</xsl:if>			
				<xsl:if test="sender_to_receiver_info">
					<additional_field name="sender_to_receiver_info" type="text" scope="master">
						<xsl:value-of select="sender_to_receiver_info"/>
					</additional_field>
				</xsl:if>							
				<xsl:if test="processing_date">
					<additional_field name="processing_date" type="date" scope="master">
						<xsl:value-of select="processing_date"/>
					</additional_field>
				</xsl:if>							
				<xsl:if test="request_date">
					<additional_field name="request_date" type="date" scope="master">
						<xsl:value-of select="request_date"/>
					</additional_field>
				</xsl:if>							
				<xsl:if test="debit_account_for_charges">
					<additional_field name="debit_account_for_charges" type="string" scope="master">
						<xsl:value-of select="debit_account_for_charges"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="charge_act_cur_code">
					<additional_field name="charge_act_cur_code" type="string" scope="master">
						<xsl:value-of select="charge_act_cur_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="charge_act_no">
					<additional_field name="charge_act_no" type="string" scope="master">
						<xsl:value-of select="charge_act_no"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="instruction_to_bank">
					<additional_field name="instruction_to_bank" type="text" scope="master">
						<xsl:value-of select="instruction_to_bank"/>
					</additional_field>
				</xsl:if>				
				<xsl:if test="transaction_remarks">
					<additional_field name="transaction_remarks" type="text" scope="master">
						<xsl:value-of select="transaction_remarks"/>
					</additional_field>
				</xsl:if>	
				
				<!-- Beneficiary Advice Additional Fields -->
				<xsl:if test="bene_adv_flag">
					<additional_field name="bene_adv_flag" type="string" scope="master">
						<xsl:value-of select="bene_adv_flag"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_email_flag">
					<additional_field name="bene_adv_email_flag" type="string" scope="master">
						<xsl:value-of select="bene_adv_email_flag"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_email_1">
					<additional_field name="bene_adv_email_1" type="string" scope="master">
						<xsl:value-of select="bene_adv_email_1"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_email_21">
					<additional_field name="bene_adv_email_21" type="string" scope="master">
						<xsl:value-of select="bene_adv_email_21"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_email_22">
					<additional_field name="bene_adv_email_22" type="string" scope="master">
						<xsl:value-of select="bene_adv_email_22"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_phone_flag">
					<additional_field name="bene_adv_phone_flag" type="string" scope="master">
						<xsl:value-of select="bene_adv_phone_flag"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_phone">
					<additional_field name="bene_adv_phone" type="string" scope="master">
						<xsl:value-of select="bene_adv_phone"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_fax_flag">
					<additional_field name="bene_adv_fax_flag" type="string" scope="master">
						<xsl:value-of select="bene_adv_fax_flag"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_fax">
					<additional_field name="bene_adv_fax" type="string" scope="master">
						<xsl:value-of select="bene_adv_fax"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_ivr_flag">
					<additional_field name="bene_adv_ivr_flag" type="string" scope="master">
						<xsl:value-of select="bene_adv_ivr_flag"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_ivr">
					<additional_field name="bene_adv_ivr" type="string" scope="master">
						<xsl:value-of select="bene_adv_ivr"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_print_flag">
					<additional_field name="bene_adv_print_flag" type="string" scope="master">
						<xsl:value-of select="bene_adv_print_flag"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_mail_flag">
					<additional_field name="bene_adv_mail_flag" type="string" scope="master">
						<xsl:value-of select="bene_adv_mail_flag"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_mailing_name_add_1">
					<additional_field name="bene_adv_mailing_name_add_1" type="string" scope="master">
						<xsl:value-of select="bene_adv_mailing_name_add_1"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_mailing_name_add_2">
					<additional_field name="bene_adv_mailing_name_add_2" type="string" scope="master">
						<xsl:value-of select="bene_adv_mailing_name_add_2"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_mailing_name_add_3">
					<additional_field name="bene_adv_mailing_name_add_3" type="string" scope="master">
						<xsl:value-of select="bene_adv_mailing_name_add_3"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_mailing_name_add_4">
					<additional_field name="bene_adv_mailing_name_add_4" type="string" scope="master">
						<xsl:value-of select="bene_adv_mailing_name_add_4"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_mailing_name_add_5">
					<additional_field name="bene_adv_mailing_name_add_5" type="string" scope="master">
						<xsl:value-of select="bene_adv_mailing_name_add_5"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_mailing_name_add_6">
					<additional_field name="bene_adv_mailing_name_add_6" type="string" scope="master">
						<xsl:value-of select="bene_adv_mailing_name_add_6"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_postal_code">
					<additional_field name="bene_adv_postal_code" type="string" scope="master">
						<xsl:value-of select="bene_adv_postal_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_country">
					<additional_field name="bene_adv_country" type="string" scope="master">
						<xsl:value-of select="bene_adv_country"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_beneficiary_id">
					<additional_field name="bene_adv_beneficiary_id" type="string" scope="master">
						<xsl:value-of select="bene_adv_beneficiary_id"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_payer_name_1">
					<additional_field name="bene_adv_payer_name_1" type="string" scope="master">
						<xsl:value-of select="bene_adv_payer_name_1"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_payer_name_2">
					<additional_field name="bene_adv_payer_name_2" type="string" scope="master">
						<xsl:value-of select="bene_adv_payer_name_2"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_payer_ref_no">
					<additional_field name="bene_adv_payer_ref_no" type="string" scope="master">
						<xsl:value-of select="bene_adv_payer_ref_no"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_free_format_msg">
					<additional_field name="bene_adv_free_format_msg" type="text" scope="master">
						<xsl:value-of select="bene_adv_free_format_msg"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_table_format">
					<additional_field name="bene_adv_table_format" type="string" scope="master">
						<xsl:value-of select="bene_adv_table_format"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_table_format_json">
					<additional_field name="bene_adv_table_format_json" type="string" scope="master">
						<xsl:value-of select="bene_adv_table_format_json"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_adv_table_format_time">
					<additional_field name="bene_adv_table_format_time" type="string" scope="master">
						<xsl:value-of select="bene_adv_table_format_time"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_advices">
					<additional_field name="bene_advice_table_data" type="string" scope="master">
						[<xsl:for-each select="bene_advices/bene_advice">{<xsl:for-each select="child::*">'<xsl:value-of select="name(.)"/>':'<xsl:value-of select="."/>'<xsl:if test="position()!=last()">,</xsl:if></xsl:for-each>}<xsl:if test="position()!=last()">,</xsl:if></xsl:for-each>]
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_bank_swift_bic_code">
					<additional_field name="beneficiary_bank_swift_bic_code" type="string" scope="master">
						<xsl:value-of select="beneficiary_bank_swift_bic_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_bank_branch_address_line_1">
					<additional_field name="beneficiary_bank_branch_address_line_1" type="string" scope="master">
						<xsl:value-of select="beneficiary_bank_branch_address_line_1"/>
					</additional_field>
				</xsl:if>			
				<xsl:if test="beneficiary_bank_branch_address_line_2">
					<additional_field name="beneficiary_bank_branch_address_line_2" type="string" scope="master">
						<xsl:value-of select="beneficiary_bank_branch_address_line_2"/>
					</additional_field>
				</xsl:if>			
				<xsl:if test="beneficiary_bank_branch_dom">
					<additional_field name="beneficiary_bank_branch_dom" type="string" scope="master">
						<xsl:value-of select="beneficiary_bank_branch_dom"/>
					</additional_field>
				</xsl:if>
				<!-- Recurring payment -->
				<xsl:if test="recurring_payment_enabled">
					<additional_field name="recurring_payment_enabled" type="string" scope="master">
						<xsl:value-of select="recurring_payment_enabled"/>
					</additional_field>
				</xsl:if>				
				<xsl:if test="recurring_start_date">
					<additional_field name="recurring_start_date" type="date" scope="master">
						<xsl:value-of select="recurring_start_date"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="recurring_end_date">
					<additional_field name="recurring_end_date" type="date" scope="master">
						<xsl:value-of select="recurring_end_date"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="recurring_frequency">
					<additional_field name="recurring_frequency" type="string" scope="master">
						<xsl:value-of select="recurring_frequency"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="recurring_on">
					<additional_field name="recurring_on" type="string" scope="master">
						<xsl:value-of select="recurring_on"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="recurring_number_transfers">
					<additional_field name="recurring_number_transfers" type="integer" scope="master">
						<xsl:value-of select="recurring_number_transfers"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="notify_beneficiary">
						<additional_field name="notify_beneficiary" type="string" scope="master">
							<xsl:value-of select="notify_beneficiary"/>
						</additional_field>
				</xsl:if>
				<xsl:if test="notify_beneficiary_choice">
						<additional_field name="notify_beneficiary_choice" type="string" scope="master">
							<xsl:value-of select="notify_beneficiary_choice"/>
						</additional_field>
				</xsl:if>
				<xsl:if test="notify_beneficiary_email">
						<additional_field name="notify_beneficiary_email" type="string" scope="master">
							<xsl:value-of select="notify_beneficiary_email"/>
						</additional_field>
				</xsl:if>	
				<xsl:if test="clearing_code">
					<additional_field name="clearing_code" type="string" scope="master" description="clearingcode">
						<xsl:value-of select="clearing_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="mups_description_address_line_1">
					<additional_field name="mups_description_address_line_1" type="string" scope="master" description="Description Address line 1">
						<xsl:value-of select="mups_description_address_line_1"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="mups_description_address_line_2">
					<additional_field name="mups_description_address_line_2" type="string" scope="master" description="Description Address line 2">
						<xsl:value-of select="mups_description_address_line_2"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="mups_description_address_line_3">
					<additional_field name="mups_description_address_line_3" type="string" scope="master" description="Description Address line 3">
						<xsl:value-of select="mups_description_address_line_3"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="mups_description_address_line_4">
					<additional_field name="mups_description_address_line_4" type="string" scope="master" description="Description Address line 4">
						<xsl:value-of select="mups_description_address_line_4"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="transfer_purpose">
					<transfer_purpose>
						<xsl:value-of select="transfer_purpose"/>
					</transfer_purpose>
				</xsl:if>					
				<xsl:call-template name="COUNTERPARTY_NB"/>
				<!-- Re authentication -->
				<xsl:call-template name="AUTHENTICATION"/>
				
				<!-- FX Common Fields -->
				<xsl:call-template name="FX_DETAILS" />
				
				<!-- collaboration -->
				<xsl:call-template name="collaboration" />
				<xsl:if test="template_update_date">
					<template_update_date>
						<xsl:value-of select="template_update_date"/>
					</template_update_date>
				</xsl:if>
				<xsl:if test="last_usage_date">
					<last_usage_date>
						<xsl:value-of select="last_usage_date"/>
					</last_usage_date>
				</xsl:if>
				<xsl:if test="template_usage_count">
					<template_usage_count>
						<xsl:value-of select="template_usage_count"/>
					</template_usage_count>
				</xsl:if>
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.cash.product.ft.common.TemplateFundTransfer>
			<com.misys.portal.product.common.TemplateCounterparty>
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
				<xsl:if test="beneficiary_abbv_name">
					<counterparty_abbv_name>
						<xsl:value-of select="beneficiary_abbv_name"/>
					</counterparty_abbv_name>
				</xsl:if>
				<xsl:if test="beneficiary_name">
					<counterparty_name>
						<xsl:value-of select="substring(beneficiary_name,0,35)"/>
					</counterparty_name>
				</xsl:if>
				<xsl:if test="beneficiary_iso_code and (not(beneficiary_swift_bic_code))">
					<counterparty_act_iso_code>
						<xsl:value-of select="beneficiary_iso_code"/>
					</counterparty_act_iso_code>
				</xsl:if>
				<xsl:if test="beneficiary_swift_bic_code and (not(beneficiary_iso_code))">
					<counterparty_act_iso_code>
						<xsl:value-of select="beneficiary_swift_bic_code"/>
					</counterparty_act_iso_code>
				</xsl:if>
				<xsl:if test="beneficiary_account">
					<counterparty_act_no>
						<xsl:value-of select="beneficiary_account"/>
					</counterparty_act_no>
				</xsl:if>
				<xsl:if test="beneficiary_reference">
					<counterparty_reference>
						<xsl:value-of select="beneficiary_reference"/>
					</counterparty_reference>
				</xsl:if>			
				<xsl:if test="beneficiary_address">
					<counterparty_address_line_1>
						<xsl:value-of select="beneficiary_address"/>
					</counterparty_address_line_1>
				</xsl:if>							
				<xsl:if test="beneficiary_city">
					<counterparty_address_line_2>
						<xsl:value-of select="beneficiary_city"/>
					</counterparty_address_line_2>
				</xsl:if>
				<xsl:if test="beneficiary_country">
					<counterparty_country>
						<xsl:value-of select="beneficiary_country"/>
					</counterparty_country>
				</xsl:if>
				<xsl:if test="beneficiary_iso_code">
					<counterparty_act_iso_code>
						<xsl:value-of select="beneficiary_iso_code"/>
					</counterparty_act_iso_code>
				</xsl:if>
				<xsl:if test="beneficiary_dom">
					<counterparty_dom>
						<xsl:value-of select="beneficiary_dom"/>
					</counterparty_dom>
				</xsl:if>
				<xsl:if test="counterparty_abbv_name">
					<counterparty_abbv_name>
						<xsl:value-of select="counterparty_abbv_name"/>
					</counterparty_abbv_name>
				</xsl:if>
				<xsl:if test="counterparty_name">
					<counterparty_name>
						<xsl:value-of select="substring(counterparty_name,0,35)"/>
					</counterparty_name>
				</xsl:if>
				<xsl:if test="counterparty_act_no">
					<counterparty_act_no>
						<xsl:value-of select="counterparty_act_no"/>
					</counterparty_act_no>
				</xsl:if>
				<xsl:if test="counterparty_reference">
					<counterparty_reference>
						<xsl:value-of select="counterparty_reference"/>
					</counterparty_reference>
				</xsl:if>			
				<xsl:if test="counterparty_address_line_1">
					<counterparty_address_line_1>
						<xsl:value-of select="counterparty_address_line_1"/>
					</counterparty_address_line_1>
				</xsl:if>							
				<xsl:if test="counterparty_address_line_2">
					<counterparty_address_line_2>
						<xsl:value-of select="counterparty_address_line_2"/>
					</counterparty_address_line_2>
				</xsl:if>
				<xsl:if test="counterparty_country">
					<counterparty_country>
						<xsl:value-of select="counterparty_country"/>
					</counterparty_country>
				</xsl:if>
				<xsl:if test="counterparty_dom">
					<counterparty_dom>
						<xsl:value-of select="counterparty_dom"/>
					</counterparty_dom>
				</xsl:if>
				<xsl:if test="beneficiary_act_cur_code">
					<counterparty_cur_code>
						<xsl:value-of select="beneficiary_act_cur_code"/>
					</counterparty_cur_code>
				</xsl:if>
				<xsl:if test="counterparty_cur_code">
					<counterparty_cur_code>
						<xsl:value-of select="counterparty_cur_code"/>
					</counterparty_cur_code>
				</xsl:if>
				<xsl:if test="cpty_bank_swift_bic_code">
					<cpty_bank_swift_bic_code name="cpty_bank_swift_bic_code" type="text" scope="master">
						<xsl:value-of select="cpty_bank_swift_bic_code"/>
					</cpty_bank_swift_bic_code>	
				</xsl:if>
				<xsl:if test="cpty_bank_code">
					<cpty_bank_code>
						<xsl:value-of select="cpty_bank_code"/>
					</cpty_bank_code>
				</xsl:if>
				<xsl:if test="cpty_bank_name">
					<cpty_bank_name>
						<xsl:value-of select="cpty_bank_name"/>
					</cpty_bank_name>
				</xsl:if>
				<xsl:if test="cpty_bank_address_line_1">
					<cpty_bank_address_line_1>
						<xsl:value-of select="cpty_bank_address_line_1"/>
					</cpty_bank_address_line_1>
				</xsl:if>
				<xsl:if test="cpty_bank_address_line_2">
					<cpty_bank_address_line_2>
						<xsl:value-of select="cpty_bank_address_line_2"/>
					</cpty_bank_address_line_2>
				</xsl:if>
				<xsl:if test="cpty_bank_dom">
					<cpty_bank_dom>
						<xsl:value-of select="cpty_bank_dom"/>
					</cpty_bank_dom>
				</xsl:if>
				<xsl:if test="cpty_branch_code">
					<cpty_branch_code>
						<xsl:value-of select="cpty_branch_code"/>
					</cpty_branch_code>
				</xsl:if>
				<xsl:if test="cpty_branch_name">
					<cpty_branch_name>
						<xsl:value-of select="cpty_branch_name"/>
					</cpty_branch_name>
				</xsl:if>
				<xsl:if test="cpty_branch_address_line_1">
					<cpty_branch_address_line_1>
						<xsl:value-of select="cpty_branch_address_line_1"/>
					</cpty_branch_address_line_1>
				</xsl:if>
				<xsl:if test="cpty_branch_address_line_2">
					<cpty_branch_address_line_2>
						<xsl:value-of select="cpty_branch_address_line_2"/>
					</cpty_branch_address_line_2>
				</xsl:if>
				<xsl:if test="cpty_bank_country">
					<cpty_bank_country>
						<xsl:value-of select="cpty_bank_country"/>
					</cpty_bank_country>
				</xsl:if>
				
			</com.misys.portal.product.common.TemplateCounterparty>
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
			<com.misys.portal.product.common.TemplateBank role_code="11">
				<xsl:attribute name="company_id"><xsl:value-of select="company_id"/></xsl:attribute>
				<xsl:attribute name="template_id"><xsl:value-of select="template_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="account_with_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="account_with_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="account_with_bank_name">
					<name>
						<xsl:value-of select="account_with_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="account_with_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="account_with_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="account_with_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="account_with_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="account_with_bank_dom">
					<dom>
						<xsl:value-of select="account_with_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="account_with_bank_iso_code">
					<iso_code>
						<xsl:value-of select="account_with_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="account_with_bank_reference">
					<reference>
						<xsl:value-of select="account_with_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateBank role_code="12">
				<xsl:attribute name="company_id"><xsl:value-of select="company_id"/></xsl:attribute>
				<xsl:attribute name="template_id"><xsl:value-of select="template_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="pay_through_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="pay_through_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="pay_through_bank_name">
					<name>
						<xsl:value-of select="pay_through_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="pay_through_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="pay_through_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="pay_through_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="pay_through_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="pay_through_bank_dom">
					<dom>
						<xsl:value-of select="pay_through_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="pay_through_bank_iso_code">
					<iso_code>
						<xsl:value-of select="pay_through_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="pay_through_bank_reference">
					<reference>
						<xsl:value-of select="pay_through_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.TemplateBank>
			<com.misys.portal.product.common.TemplateNarrative type_code="03">
				<xsl:attribute name="company_id"><xsl:value-of select="company_id"/></xsl:attribute>
				<xsl:attribute name="template_id"><xsl:value-of select="template_id"/></xsl:attribute>

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
			<com.misys.portal.product.common.TemplateNarrative type_code="11">
				<xsl:attribute name="company_id"><xsl:value-of select="company_id"/></xsl:attribute>
				<xsl:attribute name="template_id"><xsl:value-of select="template_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="bo_comment">
					<text>
						<xsl:value-of select="bo_comment"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>
			<com.misys.portal.product.common.TemplateNarrative type_code="12">
				<xsl:attribute name="company_id"><xsl:value-of select="company_id"/></xsl:attribute>
				<xsl:attribute name="template_id"><xsl:value-of select="template_id"/></xsl:attribute>

				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="free_format_text">
					<text>
						<xsl:value-of select="free_format_text"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.TemplateNarrative>

			<!-- Create Counterparty elements -->
			<!--<xsl:call-template name="TEMPLATE_COUNTERPARTY">
				<xsl:with-param name="brchCode"><xsl:value-of select="//ft_tnx_record/brch_code"/></xsl:with-param>
				<xsl:with-param name="companyId"><xsl:value-of select="//ft_tnx_record/company_id"/></xsl:with-param>
				<xsl:with-param name="templateId"><xsl:value-of select="//ft_tnx_record/template_id"/></xsl:with-param>
				<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'documents_details_position_')"/></xsl:with-param>
			</xsl:call-template>

		--></result>
	</xsl:template>
	
	<!-- Add a additionnal field to store number of beneficiaries -->
	<!-- and the name of the beneficiary if there is only one -->
	<xsl:template name="COUNTERPARTY_NB">
		<!-- save  the number of beneficiaries-->
		<xsl:variable name="counterparty_nb">
			<xsl:value-of select="count(//*[starts-with(name(), 'counterparty_details_position_')])-count(//*[starts-with(name(), 'counterparty_details_position_nbElement')])"/>
		</xsl:variable>
		<additional_field name="counterparty_nb" type="integer" scope="master" description=" Number of counterparties.">
			<xsl:value-of select="$counterparty_nb"/>
		</additional_field>				
		<!-- save the name too if there is only one beneficiary-->
		<xsl:if test="$counterparty_nb = '1'">
			<additional_field name="objectdata_counterparty_name" type="string" scope="master" description=" Name of the counterparty .">
				<xsl:value-of select="//*[starts-with(name(), 'counterparty_details_name_') and not(contains(substring-after(name(), 'counterparty_details_name_') ,'nbElement'))][1]"/>
			</additional_field>
		</xsl:if>
	</xsl:template>	

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>