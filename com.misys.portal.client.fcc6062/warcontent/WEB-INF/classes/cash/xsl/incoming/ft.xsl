<?xml version="1.0"?>
<!--
   Copyright (c) 2000-2011 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
	<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				xmlns:default="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
				exclude-result-prefixes="service default">
			
	<!-- Process FT -->
	<xsl:template match="ft_tnx_record">
		<xsl:param name="incoming_mode" />
		<xsl:param name="param_company_id" />
		<xsl:param name="param_ref_id" />
		<xsl:param name="param_tnx_id" />
		<xsl:param name="param_counterparty_id" />
		<xsl:param name="param_company_name" />
		<xsl:param name="param_entity" />
		<xsl:param name="param_main_bank_abbv_name" />
		<xsl:param name="param_main_bank_name" />
		<xsl:param name="param_main_bank_address_line_1" />
		<xsl:param name="param_main_bank_address_line_2" />
		
	
		<!-- Retrieve references from DB -->
		<!-- Declare variable at top-level to make them visible from any templates -->

		<xsl:variable name="passRefId"><xsl:value-of select="default:getResource('PASS_FBCC_REFID_AS_IFMID')"/></xsl:variable>
		<xsl:variable name="search_id">
			<xsl:choose>
				<xsl:when test="$passRefId = 'true'">
					<xsl:value-of select="//ref_id"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="//tnx_id"/> 
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="references" select="service:retrieveManageReferences(//product_code, //sub_product_code, $search_id, //bo_ref_id, //bo_tnx_id, //cust_ref_id, //company_id, //company_name, //applicant_reference, //issuing_bank/abbv_name, '01')"/>
		<xsl:variable name="ref_id">
			<xsl:choose>
				<xsl:when test="$incoming_mode = 'bulk'">
					<xsl:value-of select="$param_ref_id"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$references/references/ref_id"/> 
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="tnx_id">
			<xsl:choose>
				<xsl:when test="$incoming_mode = 'bulk'">
					<xsl:value-of select="$param_tnx_id"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$references/references/tnx_id"/> 
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="company_id">
			<xsl:choose>
				<xsl:when test="$incoming_mode = 'bulk'">
					<xsl:value-of select="$param_company_id"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$references/references/company_id"/> 
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="company_name">
			<xsl:choose>
				<xsl:when test="$incoming_mode = 'bulk'">
					<xsl:value-of select="$param_company_name"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$references/references/company_name"/> 
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="entity">
			<xsl:choose>
				<xsl:when test="$incoming_mode = 'bulk'">
					<xsl:value-of select="$param_entity"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$references/references/entity"/> 
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="main_bank_abbv_name">
			<xsl:choose>
				<xsl:when test="$incoming_mode = 'bulk'">
					<xsl:value-of select="$param_main_bank_abbv_name"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$references/references/main_bank_abbv_name"/> 
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="main_bank_name">
			<xsl:choose>
				<xsl:when test="$incoming_mode = 'bulk'">
					<xsl:value-of select="$param_main_bank_name"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$references/references/main_bank_name"/> 
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="customer_bank_reference" select="$references/references/customer_bank_reference"/>

		<com.misys.portal.cash.product.ft.common.FundTransfer>
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>
				
				<xsl:if test="bo_ref_id">
					<bo_ref_id>
						<xsl:value-of select="bo_ref_id"/>
					</bo_ref_id>
				</xsl:if>
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>
				<xsl:if test="cust_ref_id">
					<cust_ref_id>
						<xsl:value-of select="cust_ref_id"/>
					</cust_ref_id>
				</xsl:if>
				<company_id>
					<xsl:value-of select="$company_id"/>
				</company_id>
				<xsl:if test="entity">
					<entity>
						<xsl:value-of select="entity"/>
					</entity>
				</xsl:if>
				<xsl:if test="$entity!='' and not(entity)">
					<entity><xsl:value-of select="$entity"/></entity>
				</xsl:if>
				<company_name>
					<xsl:value-of select="$company_name"/>
				</company_name>
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
				
				<xsl:call-template name="manageProdStatCode">
					<xsl:with-param name="product" select="."/>
				</xsl:call-template>
				
				<xsl:if test="tnx_stat_code">
					<tnx_stat_code>
						<xsl:value-of select="tnx_stat_code"/>
					</tnx_stat_code>
				</xsl:if>
				<xsl:if test="sub_tnx_stat_code">
					<sub_tnx_stat_code>
						<xsl:value-of select="sub_tnx_stat_code"/>
					</sub_tnx_stat_code>
				</xsl:if>
				<product_code>FT</product_code>

				<xsl:if test="inp_user_id">
					<inp_user_id><xsl:value-of select="inp_user_id"/></inp_user_id>
				</xsl:if>
				<xsl:if test="inp_dttm">
					<inp_dttm><xsl:value-of select="inp_dttm"/></inp_dttm>
				</xsl:if>
				<xsl:if test="ctl_user_id">
					<ctl_user_id><xsl:value-of select="ctl_user_id"/></ctl_user_id>
				</xsl:if>
				<xsl:if test="ctl_dttm">
					<ctl_dttm><xsl:value-of select="ctl_dttm"/></ctl_dttm>
				</xsl:if>
				<xsl:if test="release_user_id">
					<release_user_id><xsl:value-of select="release_user_id"/></release_user_id>
				</xsl:if>
				<xsl:if test="release_dttm">
					<release_dttm><xsl:value-of select="release_dttm"/></release_dttm>
				</xsl:if>
				<xsl:if test="bo_inp_user_id">
					<bo_inp_user_id><xsl:value-of select="bo_inp_user_id"/></bo_inp_user_id>
				</xsl:if>
				<xsl:if test="bo_inp_dttm">
					<bo_inp_dttm><xsl:value-of select="bo_inp_dttm"/></bo_inp_dttm>
				</xsl:if>
				<xsl:if test="bo_ctl_user_id">
					<bo_ctl_user_id><xsl:value-of select="bo_ctl_user_id"/></bo_ctl_user_id>
				</xsl:if>
				<xsl:if test="bo_ctl_dttm">
					<bo_ctl_dttm><xsl:value-of select="bo_ctl_dttm"/></bo_ctl_dttm>
				</xsl:if>
				<xsl:if test="bo_release_user_id">
					<bo_release_user_id><xsl:value-of select="bo_release_user_id"/></bo_release_user_id>
				</xsl:if>
				<xsl:if test="bo_release_dttm">
					<bo_release_dttm><xsl:value-of select="bo_release_dttm"/></bo_release_dttm>
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
				<xsl:if test="iss_date">
					<iss_date>
						<xsl:value-of select="iss_date"/>
					</iss_date>
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
				<xsl:choose>
				<xsl:when test="sub_product_code">
					<sub_product_code>
						<xsl:value-of select="sub_product_code"/>
					</sub_product_code>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="ft_type">
						<sub_product_code>
							<xsl:choose>
								<xsl:when test="ft_type='01'">TINT</xsl:when>
								<xsl:when test="ft_type='02'">TTPT</xsl:when>
							</xsl:choose>
						</sub_product_code>
					</xsl:if>
				</xsl:otherwise>
				</xsl:choose>
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
				<xsl:if test="ft_type">
					<ft_type>
						<xsl:value-of select="ft_type"/>
					</ft_type>
				</xsl:if>
				<xsl:if test="rate">
					<rate>
						<xsl:value-of select="rate"/>
					</rate>
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
				<xsl:if test="applicant_act_description">
					<applicant_act_description>
						<xsl:value-of select="applicant_act_description"/>
					</applicant_act_description>
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
						<xsl:value-of select="$customer_bank_reference"/>
					</applicant_reference>
				</xsl:if>
				<xsl:if test="open_chrg_brn_by_code">
					<open_chrg_brn_by_code>
						<xsl:value-of select="open_chrg_brn_by_code"/>
					</open_chrg_brn_by_code>
				</xsl:if>
				<xsl:if test="fee_act_no">
					<fee_act_no>
						<xsl:value-of select="fee_act_no"/>
					</fee_act_no>
				</xsl:if>
				<xsl:if test="feeAmt">
					<fee_amt>
						<xsl:value-of select="feeAmt"/>
					</fee_amt>
				</xsl:if>
				<xsl:if test="feeCurCode">
					<fee_cur_code>
						<xsl:value-of select="feeCurCode"/>
					</fee_cur_code>
				</xsl:if>
				<xsl:if test="template_id">
					<template_id>
						<xsl:value-of select="template_id"/>
					</template_id>
				</xsl:if>
				<xsl:if test="adv_send_mode">
					<adv_send_mode>
						<xsl:value-of select="adv_send_mode"/>
					</adv_send_mode>
				</xsl:if>
				<xsl:if test="priority">
					<priority>
						<xsl:value-of select="priority"/>
					</priority>
				</xsl:if>		
				<xsl:if test="action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code"/>
					</action_req_code>
				</xsl:if>
				<xsl:if test="fee_entity">
					<entity>
						<xsl:value-of select="fee_entity" />
					</entity>
				</xsl:if>
	
				<xsl:if test="fee_borrower_reference">
					<applicant_reference>
						<xsl:value-of
							select="utils:decryptApplicantReference(fee_borrower_reference)" />
					</applicant_reference>
				</xsl:if>
				<xsl:if test="fee_effective_date">
					<iss_date>
						<xsl:value-of select="fee_effective_date" />
					</iss_date>
				</xsl:if>
				<xsl:if test="fee_type">
					<fee_type>
						<xsl:value-of select="fee_type" />
					</fee_type>
				</xsl:if>
				<xsl:if test="fee_description">
					<fee_description>
						<xsl:value-of select="fee_description" />
					</fee_description>
				</xsl:if>
				<xsl:if test="fee_rid">
					<fee_rid>
						<xsl:value-of select="fee_rid" />
					</fee_rid>
				</xsl:if>
	
				<xsl:if test="fee_cycle_id">
					<cycle_id>
						<xsl:value-of select="fee_cycle_id" />
					</cycle_id>
				</xsl:if>
	
	
				<xsl:if test="fee_cycle_start_date">
					<cycle_start_date>
						<xsl:value-of select="fee_cycle_start_date" />
					</cycle_start_date>
				</xsl:if>
	
				<xsl:if test="fee_cycle_end_date">
					<cycle_end_date>
						<xsl:value-of select="fee_cycle_end_date" />
					</cycle_end_date>
				</xsl:if>
	
				<xsl:if test="fee_cycle_due_date">
					<cycle_due_date>
						<xsl:value-of select="fee_cycle_due_date" />
					</cycle_due_date>
				</xsl:if>
	
				<xsl:if test="cycle_due_amt">
					<cycle_due_amt>
						<xsl:value-of select="cycle_due_amt" />
					</cycle_due_amt>
				</xsl:if>
	
				<xsl:if test="cycle_paid_amt">
					<cycle_paid_amt>
						<xsl:value-of select="cycle_paid_amt" />
					</cycle_paid_amt>
				</xsl:if>
				<xsl:if test="fee_amt">
					<fee_amt>
						<xsl:value-of select="fee_amt" />
					</fee_amt>
				</xsl:if>
				<xsl:if test="fee_cur_code">
					<fee_cur_code>
						<xsl:value-of select="fee_cur_code" />
					</fee_cur_code>
				</xsl:if>
				<!-- bulk fields -->
				<xsl:if test="$incoming_mode = 'bulk'">
					<bulk_ref_id>
						<xsl:value-of select="$param_ref_id"/>
					</bulk_ref_id>
					<bulk_tnx_id>
						<xsl:value-of select="$param_tnx_id"/>
					</bulk_tnx_id>
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
				<xsl:if test="bo_release_dttm">
					<additional_field name="bo_release_dttm" type="time" scope="none" description=" back office release dttm">
						<xsl:value-of select="bo_release_dttm"/>
					</additional_field>
				</xsl:if>
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
				<xsl:if test="pre_approved_dttm">
					<additional_field name="pre_approved_dttm" type="date" scope="master">
						<xsl:value-of select="pre_approved_dttm"/>
					</additional_field>
				</xsl:if>	
				<xsl:if test="beneficiary_mode">
					<additional_field name="beneficiary_mode" type="string" scope="master">
						<xsl:value-of select="beneficiary_mode"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="fx_deal_no">
					<additional_field name="fx_deal_no" type="string" scope="master">
						<xsl:value-of select="fx_deal_no"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="payment_deal_no">
					<additional_field name="payment_deal_no" type="string" scope="master">
						<xsl:value-of select="payment_deal_no"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="xfer_deal_no">
					<additional_field name="xfer_deal_no" type="string" scope="master">
						<xsl:value-of select="xfer_deal_no"/>
					</additional_field>
				</xsl:if>
				<xsl:if test = "fx_contract_nbr_1">
				<additional_field name="fx_contract_nbr_1" type="string" scope="master">
    					<xsl:value-of select="fx_contract_nbr_1"/>
   				</additional_field>
				</xsl:if>
				<!-- 
				<xsl:call-template name="COUNTERPARTY_NB"/>
				-->
				
				<xsl:apply-templates select="additional_field"/>
				
			</com.misys.portal.cash.product.ft.common.FundTransfer>
			
			<!-- Banks -->
			<com.misys.portal.product.common.Bank role_code="01">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="brch_code"/></brch_code>
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<abbv_name><xsl:value-of select="$main_bank_abbv_name"/></abbv_name>
				<xsl:if test="issuing_bank/name"><name><xsl:value-of select="issuing_bank/name"/></name></xsl:if>
				<xsl:if test="$main_bank_name and not(issuing_bank/name)"><name><xsl:value-of select="$main_bank_name"/></name></xsl:if>
				<xsl:choose>
				  <xsl:when test="$incoming_mode = 'bulk'">
				 	 <address_line_1><xsl:value-of select="param_main_bank_address_line_1"/></address_line_1>
				  	 <address_line_2><xsl:value-of select="param_main_bank_address_line_2"/></address_line_2>
				  </xsl:when>
				  <xsl:otherwise>
				  	<xsl:if test="issuing_bank/address_line_1"><address_line_1><xsl:value-of select="issuing_bank/address_line_1"/></address_line_1></xsl:if>
					<xsl:if test="issuing_bank/address_line_2"><address_line_2><xsl:value-of select="issuing_bank/address_line_2"/></address_line_2></xsl:if>
				  </xsl:otherwise>
				</xsl:choose>
				<xsl:if test="issuing_bank/dom"><dom><xsl:value-of select="issuing_bank/dom"/></dom></xsl:if>
				<xsl:if test="issuing_bank/iso_code"><iso_code><xsl:value-of select="issuing_bank/iso_code"/></iso_code></xsl:if>
				<xsl:if test="issuing_bank/reference"><reference><xsl:value-of select="issuing_bank/reference"/></reference></xsl:if>
			</com.misys.portal.product.common.Bank>
			
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="account_with_bank"/>
				<xsl:with-param name="role_code">11</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="bank">
				<xsl:with-param name="bank" select="pay_through_bank"/>
				<xsl:with-param name="role_code">12</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			
			<!-- Narratives -->
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="narrative_additional_instructions"/>
				<xsl:with-param name="type_code">03</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="bo_comment"/>
				<xsl:with-param name="type_code">11</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="free_format_text"/>
				<xsl:with-param name="type_code">12</xsl:with-param>
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:call-template>
			
			<!-- Create Attachment elements for attachments which are part of the incoming xml-->
			<xsl:if test="tnx_stat_code">
				<xsl:apply-templates select="attachments/attachment">
					<xsl:with-param name="tnx_stat_code" select="tnx_stat_code"/>
					<xsl:with-param name="ref_id" select="$ref_id"/>
					<xsl:with-param name="tnx_id" select="$tnx_id"/>
					<xsl:with-param name="company_id" select="$company_id"/>
				</xsl:apply-templates>
			</xsl:if> 
			<!-- Creating attachments elements for existing attachments in database-->
			<xsl:for-each select="$references/references/attachments/attachment">
				<xsl:call-template name="attachment-details">
					<xsl:with-param name="attachment" select="."></xsl:with-param>
					<xsl:with-param name="ref_id" select="$ref_id"/>
					<xsl:with-param name="tnx_id" select="$tnx_id"/>
					<xsl:with-param name="company_id" select="$company_id"/>
		 		</xsl:call-template>
			</xsl:for-each>
			
			<!-- <xsl:choose>
				<xsl:when test="$incoming_mode = 'bulk'">
					Create Charge element
					<xsl:apply-templates select="charges/charge">
						<xsl:with-param name="ref_id" select="$ref_id"/>
						<xsl:with-param name="tnx_id" select="$tnx_id"/>
						<xsl:with-param name="company_id" select="$company_id"/>
					</xsl:apply-templates>
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="$references/references/charges/charge">
						<xsl:call-template name="CHARGES_EXISTING">
						 	<xsl:with-param name="charge" select="."></xsl:with-param>
							<xsl:with-param name="brchCode" select="brch_code"></xsl:with-param>
							<xsl:with-param name="companyId" select="$company_id"></xsl:with-param>
							<xsl:with-param name="refId" select="$ref_id"></xsl:with-param>
							<xsl:with-param name="tnxId" select="$tnx_id"></xsl:with-param>
							<xsl:with-param name="counterPartyId"><xsl:value-of select="$param_counterparty_id"/></xsl:with-param>
				 		</xsl:call-template>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose> -->		
			
			<xsl:apply-templates select="charges/charge">
						<xsl:with-param name="ref_id" select="$ref_id"/>
						<xsl:with-param name="tnx_id" select="$tnx_id"/>
						<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:apply-templates>
						
			<!-- Cross References -->
			<xsl:apply-templates select="cross_references/cross_reference"/>
			<!-- Linked Licenses -->
			<xsl:if test="linked_licenses">
				<xsl:apply-templates select="linked_licenses/license">
					<xsl:with-param name="ref_id" select="$ref_id"/>
					<xsl:with-param name="tnx_id" select="$tnx_id"/>
					<xsl:with-param name="company_id" select="$company_id"/>
					<xsl:with-param name="main_bank_name" select="//issuing_bank/abbv_name"/>
				</xsl:apply-templates>
			</xsl:if>
			<!-- Error -->
			<xsl:apply-templates select="errors/error">
			    <xsl:with-param name="ref_id"><xsl:value-of select="$ref_id"/></xsl:with-param>
			    <xsl:with-param name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:with-param>
			</xsl:apply-templates>
			
			<!-- Create counterparties elements  -->
			
			<xsl:choose>
				<xsl:when test="$incoming_mode = 'bulk'">
					<xsl:call-template name="COUNTERPARTY_BULK">
						<xsl:with-param name="brchCode"><xsl:value-of select="$brch_code"/></xsl:with-param>
						<xsl:with-param name="companyId"><xsl:value-of select="$company_id"/></xsl:with-param>
						<xsl:with-param name="refId"><xsl:value-of select="$ref_id"/></xsl:with-param>
						<xsl:with-param name="tnxId"><xsl:value-of select="$tnx_id"/></xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="$references/references/counterparty">
					<xsl:call-template name="COUNTERPARTY">
						<xsl:with-param name="references" select="$references"></xsl:with-param>
						<xsl:with-param name="brchCode"><xsl:value-of select="$brch_code"/></xsl:with-param>
						<xsl:with-param name="companyId"><xsl:value-of select="$company_id"/></xsl:with-param>
						<xsl:with-param name="refId"><xsl:value-of select="$ref_id"/></xsl:with-param>
						<xsl:with-param name="tnxId"><xsl:value-of select="$tnx_id"/></xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="COUNTERPARTY_REF">
						<xsl:with-param name="references" select="$references"></xsl:with-param>
						<xsl:with-param name="brchCode"><xsl:value-of select="$brch_code"/></xsl:with-param>
						<xsl:with-param name="companyId"><xsl:value-of select="$company_id"/></xsl:with-param>
						<xsl:with-param name="refId"><xsl:value-of select="$ref_id"/></xsl:with-param>
						<xsl:with-param name="tnxId"><xsl:value-of select="$tnx_id"/></xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose> 
	</xsl:template>
	
	<xsl:template name="COUNTERPARTY">
		<xsl:param name="references" />
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		<com.misys.portal.product.common.Counterparty>
		<xsl:attribute name="ref_id"><xsl:value-of select="$refId"/></xsl:attribute>
		<xsl:attribute name="tnx_id"><xsl:value-of select="$tnxId"/></xsl:attribute>
		<xsl:attribute name="counterparty_id"><xsl:value-of select="$references/references/counterparty/counterparty_id"/></xsl:attribute>
		<counterparty_type><xsl:value-of select="$references/references/counterparty/counterparty_type" /></counterparty_type>
		<cpty_bank_country><xsl:value-of select="$references/references/counterparty/cpty_bank_country" /></cpty_bank_country>
		<cpty_bank_swift_bic_code><xsl:value-of select="$references/references/counterparty/cpty_bank_swift_bic_code" /></cpty_bank_swift_bic_code>
		<cpty_branch_dom><xsl:value-of select="$references/references/counterparty/cpty_branch_dom" /></cpty_branch_dom>
		<xsl:if test="$brchCode">
			<brch_code><xsl:value-of select="$brchCode"/></brch_code>
		</xsl:if>
		<xsl:if test="$companyId">
			<company_id><xsl:value-of select="$companyId"/></company_id>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/counterparty_act_no">
			<counterparty_act_no>
				<xsl:value-of select="$references/references/counterparty/counterparty_act_no"/>
			</counterparty_act_no>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/counterparty_label"> 
			<counterparty_label>
				<xsl:value-of select="$references/references/counterparty/counterparty_label"/>
			</counterparty_label>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/counterparty_abbv_name"> 
		<counterparty_abbv_name>
			<xsl:value-of select="$references/references/counterparty/counterparty_abbv_name"/>
		</counterparty_abbv_name>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/counterparty_name"> 
		<counterparty_name>
			<xsl:value-of select="$references/references/counterparty/counterparty_name"/>
		</counterparty_name>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/counterparty_address_line_1"> 
		<counterparty_address_line_1>
			<xsl:value-of select="$references/references/counterparty/counterparty_address_line_1"/>
		</counterparty_address_line_1>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/ounterparty_address_line_2"> 
		<counterparty_address_line_2>
			<xsl:value-of select="$references/references/counterparty/ounterparty_address_line_2"/>
		</counterparty_address_line_2>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/counterparty_dom"> 
		<counterparty_dom>
			<xsl:value-of select="$references/references/counterparty/counterparty_dom"/>
		</counterparty_dom>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/counterparty_cur_code"> 
		<counterparty_cur_code>
			<xsl:value-of select="$references/references/counterparty/counterparty_cur_code"/>
		</counterparty_cur_code>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/counterparty_reference"> 
		<counterparty_reference>
			<xsl:value-of select="$references/references/counterparty/counterparty_reference"/>
		</counterparty_reference>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/counterparty_amt"> 
		<counterparty_amt>
			<xsl:value-of select="$references/references/counterparty/counterparty_amt"/>
		</counterparty_amt>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/counterparty_act_iso_code"> 
		<counterparty_act_iso_code>
			<xsl:value-of select="$references/references/counterparty/counterparty_act_iso_code"/>
		</counterparty_act_iso_code>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/counterparty_iss_date"> 
		<counterparty_iss_date>
			<xsl:value-of select="$references/references/counterparty/counterparty_iss_date"/>
		</counterparty_iss_date>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/counterparty_country"> 
		<counterparty_country>
			<xsl:value-of select="$references/references/counterparty/counterparty_country"/>
		</counterparty_country>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/open_chrg_brn_by_code"> 
		<open_chrg_brn_by_code>
			<xsl:value-of select="$references/references/counterparty/open_chrg_brn_by_code"/>
		</open_chrg_brn_by_code>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/regulatory_reporting_code"> 
		<regulatory_reporting_code>
			<xsl:value-of select="$references/references/counterparty/regulatory_reporting_code"/>
		</regulatory_reporting_code>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/regulatory_reporting_country"> 
		<regulatory_reporting_country>
			<xsl:value-of select="$references/references/counterparty/regulatory_reporting_country"/>
		</regulatory_reporting_country>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/cpty_bank_code"> 
		<cpty_bank_code>
			<xsl:value-of select="$references/references/counterparty/cpty_bank_code"/>
		</cpty_bank_code>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/cpty_bank_name"> 
		<cpty_bank_name>
			<xsl:value-of select="$references/references/counterparty/cpty_bank_name"/>
		</cpty_bank_name>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/cpty_bank_address_line_1"> 
		<cpty_bank_address_line_1>
			<xsl:value-of select="$references/references/counterparty/cpty_bank_address_line_1"/>
		</cpty_bank_address_line_1>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/cpty_bank_address_line_2"> 
		<cpty_bank_address_line_2>
			<xsl:value-of select="$references/references/counterparty/cpty_bank_address_line_2"/>
		</cpty_bank_address_line_2>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/cpty_bank_dom"> 
		<cpty_bank_dom>
			<xsl:value-of select="$references/references/counterparty/cpty_bank_dom"/>
		</cpty_bank_dom>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/cpty_branch_code"> 
		<cpty_branch_code>
			<xsl:value-of select="$references/references/counterparty/cpty_branch_code"/>
		</cpty_branch_code>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/cpty_branch_name"> 
		<cpty_branch_name>
			<xsl:value-of select="$references/references/counterparty/cpty_branch_name"/>
		</cpty_branch_name>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/cpty_branch_address_line_1"> 
		<cpty_branch_address_line_1>
			<xsl:value-of select="$references/references/counterparty/cpty_branch_address_line_1"/>
		</cpty_branch_address_line_1>
		</xsl:if>
		<xsl:if test="$references/references/counterparty/cpty_branch_address_line_2"> 
		<cpty_branch_address_line_2>
			<xsl:value-of select="$references/references/counterparty/cpty_branch_address_line_2"/>
		</cpty_branch_address_line_2>
		</xsl:if>
	</com.misys.portal.product.common.Counterparty>
	</xsl:template>
	
	<xsl:template name="COUNTERPARTY_REF">
		<xsl:param name="references" />
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		<com.misys.portal.product.common.Counterparty>
		<xsl:attribute name="ref_id"><xsl:value-of select="$refId"/></xsl:attribute>
		<xsl:attribute name="tnx_id"><xsl:value-of select="$tnxId"/></xsl:attribute>
		<xsl:if test="counterparty_id">
						<counterparty_id>
							<xsl:value-of select="counterparties/counterparty/counterparty_id"/>
						</counterparty_id>
					</xsl:if>
					<xsl:if test="counterparty_type">
						<counterparty_type>
							<xsl:value-of select="counterparties/counterparty/counterparty_type"/>
						</counterparty_type>
					</xsl:if>
					<xsl:if test="cpty_bank_country">
						<cpty_bank_country>
							<xsl:value-of select="counterparties/counterparty/cpty_bank_country"/>
						</cpty_bank_country>
					</xsl:if>
					<xsl:if test="cpty_bank_swift_bic_code">
						<cpty_bank_swift_bic_code>
							<xsl:value-of select="counterparties/counterparty/cpty_bank_swift_bic_code"/>
						</cpty_bank_swift_bic_code>
					</xsl:if>
					<xsl:if test="cpty_branch_dom">
						<cpty_branch_dom>
							<xsl:value-of select="counterparties/counterparty/cpty_branch_dom"/>
						</cpty_branch_dom>
					</xsl:if>
		
		<xsl:if test="$brchCode">
			<brch_code><xsl:value-of select="$brchCode"/></brch_code>
		</xsl:if>
		<xsl:if test="$companyId">
			<company_id><xsl:value-of select="$companyId"/></company_id>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/counterparty_act_no">
			<counterparty_act_no>
				<xsl:value-of select="counterparties/counterparty/counterparty_act_no"/>
			</counterparty_act_no>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/counterparty_label"> 
			<counterparty_label>
				<xsl:value-of select="counterparties/counterparty/counterparty_label"/>
			</counterparty_label>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/counterparty_abbv_name"> 
		<counterparty_abbv_name>
			<xsl:value-of select="counterparties/counterparty/counterparty_abbv_name"/>
		</counterparty_abbv_name>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/counterparty_name"> 
		<counterparty_name>
			<xsl:value-of select="counterparties/counterparty/counterparty_name"/>
		</counterparty_name>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/counterparty_address_line_1"> 
		<counterparty_address_line_1>
			<xsl:value-of select="counterparties/counterparty/counterparty_address_line_1"/>
		</counterparty_address_line_1>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/counterparty_address_line_2"> 
		<counterparty_address_line_2>
			<xsl:value-of select="counterparties/counterparty/counterparty_address_line_2"/>
		</counterparty_address_line_2>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/counterparty_dom"> 
		<counterparty_dom>
			<xsl:value-of select="counterparties/counterparty/counterparty_dom"/>
		</counterparty_dom>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/counterparty_cur_code"> 
		<counterparty_cur_code>
			<xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/>
		</counterparty_cur_code>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/counterparty_reference"> 
		<counterparty_reference>
			<xsl:value-of select="counterparties/counterparty/counterparty_reference"/>
		</counterparty_reference>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/counterparty_amt"> 
		<counterparty_amt>
			<xsl:value-of select="counterparties/counterparty/counterparty_amt"/>
		</counterparty_amt>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/counterparty_act_iso_code"> 
		<counterparty_act_iso_code>
			<xsl:value-of select="counterparties/counterparty/counterparty_act_iso_code"/>
		</counterparty_act_iso_code>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/counterparty_iss_date"> 
		<counterparty_iss_date>
			<xsl:value-of select="counterparties/counterparty/counterparty_iss_date"/>
		</counterparty_iss_date>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/counterparty_country"> 
		<counterparty_country>
			<xsl:value-of select="counterparties/counterparty/counterparty_country"/>
		</counterparty_country>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/open_chrg_brn_by_code"> 
		<open_chrg_brn_by_code>
			<xsl:value-of select="counterparties/counterparty/open_chrg_brn_by_code"/>
		</open_chrg_brn_by_code>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/regulatory_reporting_code"> 
		<regulatory_reporting_code>
			<xsl:value-of select="counterparties/counterparty/regulatory_reporting_code"/>
		</regulatory_reporting_code>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/regulatory_reporting_country"> 
		<regulatory_reporting_country>
			<xsl:value-of select="counterparties/counterparty/regulatory_reporting_country"/>
		</regulatory_reporting_country>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/cpty_bank_code"> 
		<cpty_bank_code>
			<xsl:value-of select="counterparties/counterparty/cpty_bank_code"/>
		</cpty_bank_code>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/cpty_bank_name"> 
		<cpty_bank_name>
			<xsl:value-of select="counterparties/counterparty/cpty_bank_name"/>
		</cpty_bank_name>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/cpty_bank_address_line_1"> 
		<cpty_bank_address_line_1>
			<xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_1"/>
		</cpty_bank_address_line_1>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/cpty_bank_address_line_2"> 
		<cpty_bank_address_line_2>
			<xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_2"/>
		</cpty_bank_address_line_2>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/cpty_bank_dom"> 
		<cpty_bank_dom>
			<xsl:value-of select="counterparties/counterparty/cpty_bank_dom"/>
		</cpty_bank_dom>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/cpty_branch_code"> 
		<cpty_branch_code>
			<xsl:value-of select="counterparties/counterparty/cpty_branch_code"/>
		</cpty_branch_code>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/cpty_branch_name"> 
		<cpty_branch_name>
			<xsl:value-of select="counterparties/counterparty/cpty_branch_name"/>
		</cpty_branch_name>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/cpty_branch_address_line_1"> 
		<cpty_branch_address_line_1>
			<xsl:value-of select="counterparties/counterparty/cpty_branch_address_line_1"/>
		</cpty_branch_address_line_1>
		</xsl:if>
		<xsl:if test="counterparties/counterparty/cpty_branch_address_line_2"> 
		<cpty_branch_address_line_2>
			<xsl:value-of select="counterparties/counterparty/cpty_branch_address_line_2"/>
		</cpty_branch_address_line_2>
		</xsl:if>
	</com.misys.portal.product.common.Counterparty>
	</xsl:template>
	
	<!-- For Bulk Transactions we still get the counterparty information in form of xml  -->
	<xsl:template name="COUNTERPARTY_BULK">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		<xsl:param name="counterPartyId"/>
			<xsl:for-each select="counterparties/counterparty">
						<com.misys.portal.product.common.Counterparty counterparty_type="02">
						<xsl:if test="$refId">
							<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
						</xsl:if>
						<xsl:if test="$tnxId">
							<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
						</xsl:if>
						<xsl:choose>
							<xsl:when test="counterparty_id">
								<xsl:attribute name="counterparty_id">
									<xsl:value-of select="counterparty_id"/>
								</xsl:attribute>
							 </xsl:when>
							 <xsl:otherwise>
	                            <xsl:attribute name="counterparty_id">
		                              <xsl:value-of select="$counterPartyId"/>
		                         </xsl:attribute>
		                     </xsl:otherwise>
	                    </xsl:choose>

						<xsl:if test="$brchCode">
							<brch_code><xsl:value-of select="$brchCode"/></brch_code>
						</xsl:if>
						<xsl:if test="$companyId">
							<company_id><xsl:value-of select="$companyId"/></company_id>
						</xsl:if>
						<xsl:if test="counterparty_act_no">
							<counterparty_act_no>
								<xsl:value-of select="counterparty_act_no"/>
							</counterparty_act_no>
						</xsl:if>
						<xsl:if test="counterparty_label">
							<counterparty_label>
								<xsl:value-of select="counterparty_label"/>
							</counterparty_label>
						</xsl:if>
						<xsl:if test="counterparty_abbv_name">
							<counterparty_abbv_name>
								<xsl:value-of select="counterparty_abbv_name"/>
							</counterparty_abbv_name>
						</xsl:if>
						<xsl:if test="counterparty_name">
							<counterparty_name>
								<xsl:value-of select="counterparty_name"/>
							</counterparty_name>
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
						<xsl:if test="counterparty_dom">
							<counterparty_dom>
								<xsl:value-of select="counterparty_dom"/>
							</counterparty_dom>
						</xsl:if>
						<xsl:if test="counterparty_cur_code">
							<counterparty_cur_code>
								<xsl:value-of select="counterparty_cur_code"/>
							</counterparty_cur_code>
						</xsl:if>
						<xsl:if test="counterparty_reference">
							<counterparty_reference>
								<xsl:value-of select="counterparty_reference"/>
							</counterparty_reference>
						</xsl:if>
						<xsl:if test="counterparty_amt">
							<counterparty_amt>
								<xsl:value-of select="counterparty_amt"/>
							</counterparty_amt>
						</xsl:if>
						<xsl:if test="counterparty_act_iso_code">
							<counterparty_act_iso_code>
								<xsl:value-of select="counterparty_act_iso_code"/>
							</counterparty_act_iso_code>
						</xsl:if>
						<xsl:if test="counterparty_iss_date">
							<counterparty_iss_date>
								<xsl:value-of select="counterparty_iss_date"/>
							</counterparty_iss_date>
						</xsl:if>
						<xsl:if test="counterparty_country">
							<counterparty_country>
								<xsl:value-of select="counterparty_country"/>
							</counterparty_country>
						</xsl:if>						
						<xsl:if test="open_chrg_brn_by_code">
							<open_chrg_brn_by_code>
								<xsl:value-of select="open_chrg_brn_by_code"/>
							</open_chrg_brn_by_code>
						</xsl:if>
						<xsl:if test="regulatory_reporting_code">
							<regulatory_reporting_code>
								<xsl:value-of select="regulatory_reporting_code"/>
							</regulatory_reporting_code>
						</xsl:if>
						<xsl:if test="regulatory_reporting_country">
							<regulatory_reporting_country>
								<xsl:value-of select="regulatory_reporting_country"/>
							</regulatory_reporting_country>
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
						<xsl:if test="cpty_bank_swift_bic_code">
							<cpty_bank_swift_bic_code>
								<xsl:value-of select="cpty_bank_swift_bic_code"/>
							</cpty_bank_swift_bic_code>
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
					</com.misys.portal.product.common.Counterparty>
			</xsl:for-each>
	</xsl:template>
	
	<!-- Add a additionnal field to store number of beneficiaries -->
	<!-- and the name of the beneficiary if there is only one -->
	<!-- save  the number of beneficiaries-->
	<!-- save the name too if there is only one beneficiary-->
	<!-- 
	<xsl:template name="COUNTERPARTY_NB">
		
		<xsl:variable name="counterparty_nb">
			<xsl:value-of select="count(//*[starts-with(name(), 'counterparty_details_position_')])-count(//*[starts-with(name(), 'counterparty_details_position_nbElement')])"/>
		</xsl:variable>
		<additional_field name="counterparty_nb" type="integer" scope="master" description=" Number of counterparties.">
			<xsl:value-of select="$counterparty_nb"/>
		</additional_field>				
		
		<xsl:if test="$counterparty_nb = '1'">
			<additional_field name="objectdata_counterparty_name" type="string" scope="master" description=" Name of the counterparty .">
				<xsl:value-of select="//*[starts-with(name(), 'counterparty_details_name_') and not(contains(substring-after(name(), 'counterparty_details_name_') ,'nbElement'))][1]"/>
			</additional_field>
		</xsl:if>
	</xsl:template>
	-->
	
	<!-- Charge template -->
	
	<xsl:template name="CHARGES_EXISTING">
		<xsl:param name="charge" />
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		<com.misys.portal.product.common.Charge>
			<!-- keys as attributes -->
			<xsl:attribute name="chrg_id"><xsl:value-of select="$charge/chrg_id"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="$refId"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="$tnxId"/></xsl:attribute>
			<xsl:if test="$brchCode">
				<brch_code><xsl:value-of select="$brchCode"/></brch_code>
			</xsl:if>
			<xsl:if test="$companyId">
				<company_id><xsl:value-of select="$companyId"/></company_id>
			</xsl:if>
			<xsl:element name="chrg_code"><xsl:value-of select="$charge/chrg_code"/></xsl:element>
			<xsl:element name="amt"><xsl:value-of select="$charge/amt"/></xsl:element>
			<xsl:element name="cur_code"><xsl:value-of select="$charge/cur_code"/></xsl:element>
			<xsl:element name="status"><xsl:value-of select="$charge/status"/></xsl:element>
			<xsl:element name="bearer_role_code"><xsl:value-of select="$charge/bearer_role_code"/></xsl:element>
			<xsl:element name="exchange_rate"><xsl:value-of select="$charge/exchange_rate"/></xsl:element>
			<xsl:element name="eqv_amt"><xsl:value-of select="$charge/eqv_amt"/></xsl:element>
			<xsl:element name="eqv_cur_code"><xsl:value-of select="$charge/eqv_cur_code"/></xsl:element>
			<xsl:element name="additional_comment"><xsl:value-of select="$charge/additional_comment"/></xsl:element>
			<xsl:element name="inception_date"><xsl:value-of select="$charge/inception_date"/></xsl:element>
			<xsl:element name="settlement_date"><xsl:value-of select="$charge/settlement_date"/></xsl:element>
			<xsl:element name="created_in_session"><xsl:value-of select="$charge/created_in_session"/></xsl:element>
			<xsl:element name="chrg_type"><xsl:value-of select="$charge/chrg_type"/></xsl:element>
		</com.misys.portal.product.common.Charge>
	</xsl:template>
</xsl:stylesheet>