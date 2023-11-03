<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="utils">
<!--
   Copyright (c) 2000-2011 Misys(http://www.misys.com),
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
	<!-- Process BK -->
	<xsl:template match="bk_tnx_record">
		<result>
			<com.misys.portal.product.bk.common.Bulk>
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
				
				<xsl:if test="appl_date">
					<appl_date>
						<xsl:value-of select="appl_date"/>
					</appl_date>
				</xsl:if>
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
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
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="company_name">
					<company_name>
						<xsl:value-of select="company_name"/>
					</company_name>
				</xsl:if>
				
				<xsl:if test="deal_name">
					<deal_name>
						<xsl:value-of select="deal_name"/>
					</deal_name>
				</xsl:if>
				
				<xsl:if test="interest_payment">
					<interest_payment>
						<xsl:value-of select="interest_payment"/>
					</interest_payment>
				</xsl:if>
				
				<xsl:if test="borrower_settlement_ind">
					<borrower_settlement_ind>
						<xsl:value-of select="borrower_settlement_ind"/>
					</borrower_settlement_ind>
				</xsl:if>
				
				<xsl:if test="adjust_payment_options">
					<adjust_payment_options>
						<xsl:value-of select="adjust_payment_options"/>
					</adjust_payment_options>
				</xsl:if>
				
				<xsl:if test="cust_ref_id">
					<cust_ref_id>
						<xsl:value-of select="cust_ref_id"/>
					</cust_ref_id>
				</xsl:if>
				<xsl:if test="sub_product_code[.='LNRPN'] and count(repricing_new_loans/ln_tnx_record) = 1">
        			<cust_ref_id>
						<xsl:value-of select="repricing_new_loans/ln_tnx_record/new_loan_our_ref"/>
					</cust_ref_id>
       			</xsl:if>
				<xsl:if test="entity">
					<entity>
						<xsl:value-of select="entity"/>
					</entity>
				</xsl:if>
				<xsl:if test="prod_stat_code">
					<prod_stat_code>
						<xsl:value-of select="prod_stat_code"/>
					</prod_stat_code>
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
				<xsl:if test="child_product_code">
					<child_product_code>
						<xsl:value-of select="child_product_code"/>
					</child_product_code>
				</xsl:if>
				<xsl:if test="child_sub_product_code">
					<child_sub_product_code>
						<xsl:value-of select="child_sub_product_code"/>
					</child_sub_product_code>
				</xsl:if>
				<xsl:if test="sub_tnx_type_code">
					<sub_tnx_type_code>
						<xsl:value-of select="sub_tnx_type_code"/>
					</sub_tnx_type_code>
				</xsl:if>
				<xsl:if test="tnx_stat_code">
					<tnx_stat_code>
						<xsl:value-of select="tnx_stat_code"/>
					</tnx_stat_code>
				</xsl:if>
				<xsl:if test="tnx_type_code">
					<tnx_type_code>
						<xsl:value-of select="tnx_type_code"/>
					</tnx_type_code>
				</xsl:if>
				<xsl:if test="tnx_val_date">
					<tnx_val_date>
						<xsl:value-of select="tnx_val_date"/>
					</tnx_val_date>
				</xsl:if>
				<xsl:if test="value_date">
					<value_date>
						<xsl:value-of select="value_date"/>
					</value_date>
				</xsl:if>
				<xsl:if test="value_date_unsigned and value_date_unsigned[.!='']">
					<value_date>
						<xsl:value-of select="value_date_unsigned"/>
					</value_date>
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
				<xsl:if test="bk_product_code">
					<bk_product_code>
						<xsl:value-of select="bk_product_code"/>
					</bk_product_code>
				</xsl:if>
				<xsl:if test="bk_cur_code">
					<bk_cur_code>
						<xsl:value-of select="bk_cur_code"/>
					</bk_cur_code>
				</xsl:if>
				<xsl:if test="bk_total_amt">
					<bk_total_amt>
						<xsl:value-of select="bk_total_amt"/>
					</bk_total_amt>
				</xsl:if>
				<xsl:if test="bk_highest_amt">
					<bk_highest_amt>
						<xsl:value-of select="bk_highest_amt"/>
					</bk_highest_amt>
				</xsl:if>
				<xsl:if test="bk_fin_cur_code">
					<bk_fin_cur_code>
						<xsl:value-of select="bk_fin_cur_code"/>
					</bk_fin_cur_code>
				</xsl:if>
				<xsl:if test="bk_fin_amt">
					<bk_fin_amt>
						<xsl:value-of select="bk_fin_amt"/>
					</bk_fin_amt>
				</xsl:if>
				
				<xsl:if test="bk_repay_date">
					<bk_repay_date>
						<xsl:value-of select="bk_repay_date"/>
					</bk_repay_date>
				</xsl:if>
				<xsl:if test="bk_repaid_cur_code">
					<bk_repaid_cur_code>
						<xsl:value-of select="bk_repaid_cur_code"/>
					</bk_repaid_cur_code>
				</xsl:if>
				<xsl:if test="bk_repaid_amt">
					<bk_repaid_amt>
						<xsl:value-of select="bk_repaid_amt"/>
					</bk_repaid_amt>
				</xsl:if>
				<xsl:if test="record_number">
					<record_number>
						<xsl:value-of select="record_number"/>
					</record_number>
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
				<xsl:if test="applicant_act_no != '' or applicant_collection_act_no = ''">
					<applicant_act_no>
						<xsl:value-of select="applicant_act_no"/>
					</applicant_act_no>
				</xsl:if>
				<xsl:if test="applicant_collection_act_no != ''">
					<applicant_act_no>
						<xsl:value-of select="applicant_collection_act_no"/>
					</applicant_act_no>
				</xsl:if>
				<xsl:if test="applicant_act_description != '' or applicant_collection_act_description = ''">
					<applicant_act_description>
						<xsl:value-of select="applicant_act_description"/>
					</applicant_act_description>
				</xsl:if>
				<xsl:if test="applicant_collection_act_description != ''">
					<applicant_act_description>
						<xsl:value-of select="applicant_collection_act_description"/>
					</applicant_act_description>
				</xsl:if>
				<xsl:if test="applicant_act_cur_code !='' or applicant_collection_act_cur_code = ''">
					<applicant_act_cur_code>
						<xsl:value-of select="applicant_act_cur_code"/>
					</applicant_act_cur_code>
				</xsl:if>
				<xsl:if test="applicant_collection_act_cur_code != ''">
					<applicant_act_cur_code>
						<xsl:value-of select="applicant_collection_act_cur_code"/>
					</applicant_act_cur_code>
				</xsl:if>				
				
				<xsl:if test="applicant_act_name != '' or applicant_collection_act_name = ''">
					<applicant_act_name>
						<xsl:value-of select="applicant_act_name"/>
					</applicant_act_name>
				</xsl:if>
				<xsl:if test="applicant_collection_act_name != ''">
					<applicant_act_name>
						<xsl:value-of select="applicant_collection_act_name"/>
					</applicant_act_name>
				</xsl:if>
				<xsl:if test="applicant_collection_reference != ''">
					<applicant_reference>
						<xsl:value-of select="utils:decryptApplicantReference(applicant_collection_reference)"/>
					</applicant_reference>
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
				<xsl:if test="applicant_reference!=''">
					<applicant_reference>
						<xsl:value-of select="utils:decryptApplicantReference(applicant_reference)"/>
					</applicant_reference>
				</xsl:if>
				<xsl:if test="sub_product_code[.='LNRPN'] and borrower_reference[.!='']">
					<applicant_reference>
						<xsl:value-of select="utils:decryptApplicantReference(borrower_reference)"/>
					</applicant_reference>
				</xsl:if>
				<xsl:if test="sub_product_code[.='BLFP'] and borrower_reference[.!='']">
					<applicant_reference>
						<xsl:value-of select="utils:decryptApplicantReference(borrower_reference)"/>
					</applicant_reference>
				</xsl:if>
				<xsl:if test="open_chrg_brn_by_code">
					<open_chrg_brn_by_code>
						<xsl:value-of select="open_chrg_brn_by_code"/>
					</open_chrg_brn_by_code>
				</xsl:if>
				<xsl:if test="feeAccount">
					<fee_act_no>
						<xsl:value-of select="feeAccount"/>
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
					<xsl:if test="description">
					<description>
						<xsl:value-of select="description"/>
					</description>
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
				<xsl:if test="bk_transaction_code">
					<additional_field name="bk_transaction_code" type="string" scope="master" description="bulk transaction code">
						<xsl:value-of select="bk_transaction_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="accept_legal_text">
						<additional_field name="isLegalTextAccepted" type="string" scope="master" description="Accept Legal Text">
							<xsl:value-of select="accept_legal_text"/>
						</additional_field>
				 </xsl:if>
				<xsl:if test="legal_text_value">
					<additional_field name="legal_text_value" type="text" scope="master" description="Legal Text Value">
						<xsl:value-of select="legal_text_value"/>
					</additional_field>
				   </xsl:if>
				   
				   <xsl:if test="authorizer_id">
					<additional_field name="authorizer_id" type="string" scope="master" description="Authorizer Id">
						<xsl:value-of select="authorizer_id"/>
						</additional_field>
				 </xsl:if>
				<xsl:if test="bk_particular">
					<additional_field name="bk_particular" type="string" scope="master" description="bulk Particulars">
						<xsl:value-of select="bk_particular"/>
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
				<xsl:if test="applicant_act_pab">
					<additional_field name="applicant_act_pab" type="string" scope="master">
						<xsl:value-of select="applicant_act_pab"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bk_type">
					<bk_type>
						<xsl:value-of select="bk_type"/>
					</bk_type>
				</xsl:if>
				<xsl:if test="payroll_type">
					<additional_field name="payroll_type" type="string" scope="master" description="Payroll type">
						<xsl:value-of select="payroll_type"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="express">
					<additional_field name="express" type="string" scope="master" description="Express flag">
						<xsl:value-of select="express"/>
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
				<!-- Security -->
				<xsl:if test="token">
					<additional_field name="token" type="string" scope="none" description="Security token">
						<xsl:value-of select="token"/>
					</additional_field>
				</xsl:if>
				<!-- Additional Fields Required by Datamapper -->
				<xsl:if test="account_bank_id">
					<additional_field name="account_bank_id" type="string" scope="none" description="Bank Id for the account">
						<xsl:value-of select="account_bank_id"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="account_branch_no">
					<additional_field name="account_branch_no" type="string" scope="none" description="Branch Number for the account">
						<xsl:value-of select="account_branch_no"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="legal_id_no">
				  <additional_field name="legal_id_no" type="string" scope="master" description="Applicant reference's(Entity) Legal Id no ">
					<xsl:value-of select="legal_id_no"/>
				  </additional_field>
				</xsl:if>
				<xsl:if test="country_legalid">
				  <additional_field name="country_legalid" type="string" scope="master" description="Applicant reference's(Entity) legal id's country  ">
					<xsl:value-of select="country_legalid"/>
				  </additional_field>
				</xsl:if>
				<xsl:if test="legal_id_type">
				  <additional_field name="legal_id_type" type="string" scope="master" description="Applicant reference's(Entity) legal id type">
					<xsl:value-of select="legal_id_type"/>
				  </additional_field>
				</xsl:if>				
				
				<xsl:if test="total_principal_amt">
				  <additional_field name="total_principal_amt" type="string" scope="master" description="Total Principal Payment Amount">
					<xsl:value-of select="total_principal_amt"/>
				  </additional_field>
				</xsl:if>
				
				<xsl:if test="bulk_Effective_Date">
				  <additional_field name="bulk_Effective_Date" type="date" scope="master" description="Loan Bulk Effective Date">
					<xsl:value-of select="bulk_Effective_Date"/>
				  </additional_field>
				</xsl:if>
				
				<xsl:if test="bulk_facility_name">
				  <additional_field name="bulk_facility_name" type="string" scope="master" description="Loan Bulk Facility Name">
					<xsl:value-of select="bulk_facility_name"/>
				  </additional_field>
				</xsl:if>
				<xsl:if test="facility_type">
					<additional_field name="facility_type" type="string" scope="master" description="Facility Type">
					<xsl:value-of select="facility_type"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="clearing_code">
					<additional_field name="clearing_code" type="string" scope="master" description="Clearing Code">
						<xsl:value-of select="clearing_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bulk_facility_id">
					<additional_field name="bulk_facility_id" type="string" scope="master" description="Loan Bulk Facility ID">
						<xsl:value-of select="bulk_facility_id"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="fcn">
					<additional_field name="fcn" type="string" scope="master" description="Facility FCN">
						<xsl:value-of select="fcn"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bulk_fee_types_desc">
					<additional_field name="bulk_fee_types_desc" type="string" scope="master" description="Loan Fee types description">
						<xsl:value-of select="bulk_fee_types_desc"/>
					</additional_field>
				</xsl:if>
				<xsl:for-each select="interestPayments/interestPayment">
					<xsl:variable name="id" select="utils:handleSpace(loanAlias)"/>
					<additional_field name="interestDueAmt_{$id}" type="string" scope="master" description="Interest Payment due">
						<xsl:value-of select="interesteDueAmt"/>
					</additional_field>
					<additional_field name="cycleStartDate_{$id}" type="string" scope="master" description="Interest cycle Start Date">
						<xsl:value-of select="cycleStartDate"/>
					</additional_field>
				</xsl:for-each>
			
			   <!-- END:Additional Fields Required by Datamapper -->
				<!-- Re authentication -->
				<xsl:call-template name="AUTHENTICATION"/>
				<!-- collaboration -->
				<xsl:call-template name="collaboration" />
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.product.bk.common.Bulk>
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
			<com.misys.portal.product.common.Bank role_code="11">
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
				<xsl:if test="beneficiary_bank_country">
					<country>
						<xsl:value-of select="beneficiary_bank_country"/>
					</country>
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
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Bank role_code="12">
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
			</com.misys.portal.product.common.Bank>
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
					<xsl:if test="return_comments">
						<text>
							<xsl:value-of select="return_comments"/>
						</text>
					</xsl:if>
				</com.misys.portal.product.common.Narrative>
			</xsl:if>
						
			<!-- If Bulk Invoice Financing -->
			<xsl:if test="child_product_code = 'IN'">
				<xsl:apply-templates select="invoice_items/invoice"/>
			</xsl:if>
			<xsl:if test="child_product_code = 'IP'">
				<xsl:apply-templates select="invoice_payable_items/invoice_payable"/>
			</xsl:if>	
				
			
			<!-- Create Charge element -->
			
			<!-- First, those charges belonging to the current transaction -->
			<xsl:for-each select="//*[starts-with(name(), 'charge_details_chrg_details_')]">
				<xsl:call-template name="CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//bk_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//bk_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//bk_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//bk_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'charge_details_chrg_details_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!-- Second, the charges inputted earlier -->
			<xsl:for-each select="//*[starts-with(name(), 'old_charge_details_position_')]">
				<xsl:call-template name="OLD_CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//bk_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//bk_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//bk_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//bk_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'old_charge_details_position_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!-- Cross References -->
			<xsl:choose>
				<xsl:when test = "product_code[.='BK'] and sub_product_code[.='LNRPN']">
					<xsl:for-each select="//*[starts-with(name(), 'cross_ref_cross_reference_id_')]">
						<xsl:call-template name="CROSS_REFERENCE">
							<xsl:with-param name="brchCode"><xsl:value-of select="/brch_code"/></xsl:with-param>
							<xsl:with-param name="companyId"><xsl:value-of select="/company_id"/></xsl:with-param>
							<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'cross_ref_cross_reference_id_')"/></xsl:with-param>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="//*[starts-with(name(), 'cross_ref_cross_reference_id')]">
						<xsl:call-template name="CROSS_REFERENCE">
							<xsl:with-param name="brchCode"><xsl:value-of select="/brch_code"/></xsl:with-param>
							<xsl:with-param name="companyId"><xsl:value-of select="/company_id"/></xsl:with-param>
							<xsl:with-param name="position"><xsl:value-of select="substring-before(substring-after(name(), 'cross_ref_cross_reference_id'), '_')"/></xsl:with-param>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
			
			
			<xsl:for-each select="repricing_new_loans/ln_tnx_record">
			<com.misys.portal.product.ln.common.LoanFile>
					
					<com.misys.portal.product.ln.common.Loan>
						
							<xsl:if test="new_loan_ref_id">
										<ref_id>
											<xsl:value-of select="new_loan_ref_id"/>
										</ref_id>
							</xsl:if>
							
							<xsl:if test="new_loan_tnx_id">
								<tnx_id>
									<xsl:value-of select="new_loan_tnx_id"/>
								</tnx_id>
							</xsl:if>						
						<xsl:if test="../../applicant_abbv_name">
							<applicant_abbv_name>
								<xsl:value-of select="../../applicant_abbv_name"/>
							</applicant_abbv_name>
						</xsl:if>							
							
							<xsl:if test="../../sub_tnx_type_code">
								<sub_tnx_type_code>
									<xsl:value-of select="../../sub_tnx_type_code"/>
								</sub_tnx_type_code>
							</xsl:if>		
							
							<xsl:if test="../../tnx_type_code">
								<tnx_type_code>
									<xsl:value-of select="../../tnx_type_code"/>
							</tnx_type_code>
							</xsl:if>			
								
							<brch_code>
								<xsl:value-of select="../../brch_code"/>
							</brch_code>								
							
							<xsl:if test="new_loan_entity">
								<entity>
									<xsl:value-of select="new_loan_entity"/>
								</entity>
							</xsl:if>
			
							<xsl:if test="new_loan_ccy">
								<tnx_cur_code>
									<xsl:value-of select="new_loan_ccy"/>
								</tnx_cur_code>
							</xsl:if>				
											
							<!-- from Loan -->
							<xsl:if test="new_loan_facility_id">
								<bo_facility_id>
									<xsl:value-of select="new_loan_facility_id"/>
								</bo_facility_id>
							</xsl:if>
							<xsl:if test="new_loan_facility_name">
								<bo_facility_name>
									<xsl:value-of select="new_loan_facility_name"/>
								</bo_facility_name>
							</xsl:if>
							<xsl:if test="new_loan_deal_id">
								<bo_deal_id>
									<xsl:value-of select="new_loan_deal_id"/>
								</bo_deal_id>
							</xsl:if>
							<xsl:if test="new_loan_deal_name">
								<bo_deal_name>
									<xsl:value-of select="new_loan_deal_name"/>
								</bo_deal_name>
							</xsl:if>
			
							<xsl:if test="new_loan_fcn">
								<fcn>
									<xsl:value-of select="new_loan_fcn"/>
								</fcn>
							</xsl:if>
							<xsl:if test="new_fx_conversion_rate">
								<fx_conversion_rate>
									<xsl:value-of select="new_fx_conversion_rate"/>
								</fx_conversion_rate>
							</xsl:if>
							
							<xsl:if test="new_fac_cur_code">
								<fac_cur_code>
									<xsl:value-of select="new_fac_cur_code"/>
								</fac_cur_code>
							</xsl:if>
			
							<xsl:if test="new_loan_borrower_reference">
								<borrower_reference>
									<xsl:value-of select="utils:decryptApplicantReference(new_loan_borrower_reference)"/>
								</borrower_reference>
							</xsl:if>				
			
							<xsl:if test="new_loan_effective_date">
								<effective_date>
									<xsl:value-of select="new_loan_effective_date"/>
								</effective_date>
							</xsl:if>
									
							<xsl:if test="new_loan_maturity_date">
								<ln_maturity_date>
									<xsl:value-of select="new_loan_maturity_date"/>
								</ln_maturity_date>
							</xsl:if>				
							<xsl:if test="new_loan_maturity_date">
								<maturity_date>
									<xsl:value-of select="new_loan_maturity_date"/>
								</maturity_date>
							</xsl:if>
							<xsl:if test="new_loan_ccy">
								<ln_cur_code>
									<xsl:value-of select="new_loan_ccy"/>
								</ln_cur_code>
							</xsl:if>
							<xsl:if test="new_loan_outstanding_amt">
								<ln_amt>
									<xsl:value-of select="new_loan_outstanding_amt"/>
								</ln_amt>
							</xsl:if>
							
							
							<xsl:if test="../../appl_date">
								<appl_date>
									<xsl:value-of select="../../appl_date"/>
								</appl_date>
							</xsl:if>
							
							<xsl:if test="new_loan_outstanding_amt">
								<tnx_amt>
									<xsl:value-of select="new_loan_outstanding_amt"/>
								</tnx_amt>
							</xsl:if>
			
							<xsl:if test="new_loan_repricing_riskType">
								<risk_type>
									<xsl:value-of select="new_loan_repricing_riskType"/>
								</risk_type>
							</xsl:if>
			
							<xsl:if test="new_loan_pricing_option">
								<pricing_option>
									<xsl:value-of select="new_loan_pricing_option"/>
								</pricing_option>
							</xsl:if>
							<xsl:if test="new_loan_matchFunding">
								<match_funding>
									<xsl:value-of select="new_loan_matchFunding"/>
								</match_funding>
							</xsl:if>
							<xsl:if test="rem_inst_description">
								<rem_inst_description>
									<xsl:value-of select="rem_inst_description"/>
								</rem_inst_description>
							</xsl:if>
							<xsl:if test="rem_inst_location_code">
								<rem_inst_location_code>
									<xsl:value-of select="rem_inst_location_code"/>
								</rem_inst_location_code>
							</xsl:if>
							<xsl:if test="rem_inst_servicing_group_alias">
								<rem_inst_servicing_group_alias> 
									<xsl:value-of select="rem_inst_servicing_group_alias"/>
								</rem_inst_servicing_group_alias>
							</xsl:if>
							<xsl:if test="rem_inst_account_no">
								<rem_inst_account_no> 
									<xsl:value-of select="rem_inst_account_no"/>
								</rem_inst_account_no>
							</xsl:if>
							<xsl:if test="new_loan_repricing_date">
								<repricing_date>
									<xsl:value-of select="new_loan_repricing_date"/>
								</repricing_date>
							</xsl:if>
							<xsl:if test="new_loan_repricing_frequency">
								<repricing_frequency>
									<xsl:value-of select="new_loan_repricing_frequency"/>
								</repricing_frequency>
							</xsl:if>
							
							<xsl:if test="../../company_id">
								<company_id>
									<xsl:value-of select="../../company_id"/>
								</company_id>
							</xsl:if>
							
							<xsl:if test="../../company_name">
								<company_name>
									<xsl:value-of select="../../company_name"/>
								</company_name>
							</xsl:if>
							
							<!-- Security -->
							<xsl:if test="token">
								<additional_field name="token" type="string" scope="none" description="Security token">
									<xsl:value-of select="token"/>
								</additional_field>
							</xsl:if>
							
							<xsl:if test="new_loan_our_ref">
								<cust_ref_id>
									<xsl:value-of select="new_loan_our_ref"/>
								</cust_ref_id>
							</xsl:if>
							     <!-- Custom additional fields -->
			     			<xsl:call-template name="product-additional-fields"/>
							 </com.misys.portal.product.ln.common.Loan>	
							 
							 
			<com.misys.portal.product.common.Bank role_code="01">
				<xsl:attribute name="ref_id"><xsl:value-of select="../../ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="../../tnx_id"/></xsl:attribute>
				<xsl:if test="../../brch_code">
					<brch_code>
						<xsl:value-of select="../../brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="../../company_id">
					<company_id>
						<xsl:value-of select="../../company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="../../issuing_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="../../issuing_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="../../issuing_bank_name">
					<name>
						<xsl:value-of select="../../issuing_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="../../issuing_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="../../issuing_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="../../issuing_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="../../issuing_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="../../issuing_bank_dom">
					<dom>
						<xsl:value-of select="../../issuing_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="../../issuing_bank_iso_code">
					<iso_code>
						<xsl:value-of select="../../issuing_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="../../issuing_bank_reference">
					<reference>
						<xsl:value-of select="../../issuing_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.Bank>
			<com.misys.portal.product.common.Narrative>
				<xsl:if test="../../brch_code">
					<brch_code>
						<xsl:value-of select="../../brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="../../company_id">
					<company_id>
						<xsl:value-of select="../../company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="../../ref_id">
					<ref_id>
						<xsl:value-of select="../../ref_id"/>
					</ref_id>
				</xsl:if>
				<xsl:if test="../../tnx_id">
					<tnx_id>
						<xsl:value-of select="../../tnx_id"/>
					</tnx_id>
				</xsl:if>
				<type_code>11</type_code>
				<xsl:if test="../../bo_comment">
					<text>
						<xsl:value-of select="../../bo_comment"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative>
				<xsl:if test="../../brch_code">
					<brch_code>
						<xsl:value-of select="../../brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="../../company_id">
					<company_id>
						<xsl:value-of select="../../company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="../../ref_id">
					<ref_id>
						<xsl:value-of select="../../ref_id"/>
					</ref_id>
				</xsl:if>
				<xsl:if test="../../tnx_id">
					<tnx_id>
						<xsl:value-of select="../../tnx_id"/>
					</tnx_id>
				</xsl:if>
				<type_code>12</type_code>
				<xsl:if test="../../free_format_text">
					<text>
						<xsl:value-of select="../../free_format_text"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative>
				<xsl:if test="../../brch_code">
					<brch_code>
						<xsl:value-of select="../../brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="../../company_id">
					<company_id>
						<xsl:value-of select="../../company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="../../ref_id">
					<ref_id>
						<xsl:value-of select="../../ref_id"/>
					</ref_id>
				</xsl:if>
				<xsl:if test="../../tnx_id">
					<tnx_id>
						<xsl:value-of select="../../tnx_id"/>
					</tnx_id>
				</xsl:if>
				<type_code>13</type_code>
				<xsl:if test="../../amd_details">
					<text>
						<xsl:value-of select="../../amd_details"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			</com.misys.portal.product.ln.common.LoanFile>
				
			</xsl:for-each>
			
			<xsl:for-each select="linked_loans/loan_ref_id">
				<com.misys.portal.product.common.CrossReference>
					<ref_id><xsl:value-of select="../../ref_id"/></ref_id>
					<tnx_id><xsl:value-of select="../../tnx_id"/></tnx_id>
					<product_code>BK</product_code>
					<child_ref_id><xsl:value-of select="."/></child_ref_id>
					<child_tnx_id><xsl:value-of select="../../tnx_id"/></child_tnx_id>
					<child_product_code>LN</child_product_code>
					<type_code>09</type_code>
				</com.misys.portal.product.common.CrossReference>
			</xsl:for-each>
			
			<xsl:for-each select="fee_tnx_list/ft_tnx_record">
				<com.misys.portal.cash.product.ft.common.FundTransferFile>
			
					<com.misys.portal.cash.product.ft.common.FundTransfer>
			
						<xsl:if test="fee_ref_id">
							<ref_id>
								<xsl:value-of select="fee_ref_id" />
							</ref_id>
						</xsl:if>
			
						<xsl:if test="fee_tnx_id">
							<tnx_id>
								<xsl:value-of select="fee_tnx_id" />
							</tnx_id>
						</xsl:if>
						<xsl:if test="../../applicant_abbv_name">
							<applicant_abbv_name>
								<xsl:value-of select="../../applicant_abbv_name" />
							</applicant_abbv_name>
						</xsl:if>
			
						<xsl:if test="../../sub_tnx_type_code">
							<sub_tnx_type_code>
								<xsl:value-of select="../../sub_tnx_type_code" />
							</sub_tnx_type_code>
						</xsl:if>
			
						<xsl:if test="../../tnx_type_code">
							<tnx_type_code>
								<xsl:value-of select="../../tnx_type_code" />
							</tnx_type_code>
						</xsl:if>
						<xsl:if test="sub_product_code">
							<sub_product_code>
								<xsl:value-of select="sub_product_code" />
							</sub_product_code>
						</xsl:if>
			
						<brch_code>
							<xsl:value-of select="../../brch_code" />
						</brch_code>
			
						<xsl:if test="fee_entity">
							<entity>
								<xsl:value-of select="fee_entity" />
							</entity>
						</xsl:if>
			
						<xsl:if test="fee_borrower_reference">
							<applicant_reference>
								<xsl:value-of
									select="utils:decryptApplicantReference(../../borrower_reference)" />
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
						<xsl:if test="ft_amt">
							<ft_amt>
								<xsl:value-of select="ft_amt" />
							</ft_amt>
						</xsl:if>
						<xsl:if test="ft_cur_code">
							<ft_cur_code>
								<xsl:value-of select="ft_cur_code" />
							</ft_cur_code>
						</xsl:if>
						<xsl:if test="tnx_cur_code">
							<tnx_cur_code>
								<xsl:value-of select="tnx_cur_code" />
							</tnx_cur_code>
						</xsl:if>
						<xsl:if test="tnx_amt">
							<tnx_amt>
								<xsl:value-of select="tnx_amt" />
							</tnx_amt>
						</xsl:if>
						<xsl:if test="cycle_paid_amt">
							<cycle_paid_amt>
								<xsl:value-of select="cycle_paid_amt" />
							</cycle_paid_amt>
						</xsl:if>
						<xsl:if test="../../appl_date">
							<appl_date>
								<xsl:value-of select="../../appl_date" />
							</appl_date>
						</xsl:if>
						<xsl:if test="../../company_id">
							<company_id>
								<xsl:value-of select="../../company_id" />
							</company_id>
						</xsl:if>
			
						<xsl:if test="../../company_name">
							<company_name>
								<xsl:value-of select="../../company_name" />
							</company_name>
						</xsl:if>
						<!-- Security -->
						<xsl:if test="token">
							<additional_field name="token" type="string"
								scope="none" description="Security token">
								<xsl:value-of select="token" />
							</additional_field>
						</xsl:if>
						<!-- Custom additional fields -->
						<xsl:call-template name="product-additional-fields" />
					</com.misys.portal.cash.product.ft.common.FundTransfer>
			
			
					<com.misys.portal.product.common.Bank
						role_code="01">
						<xsl:attribute name="ref_id"><xsl:value-of
							select="../../ref_id" /></xsl:attribute>
						<xsl:attribute name="tnx_id"><xsl:value-of
							select="../../tnx_id" /></xsl:attribute>
						<xsl:if test="../../brch_code">
							<brch_code>
								<xsl:value-of select="../../brch_code" />
							</brch_code>
						</xsl:if>
						<xsl:if test="../../company_id">
							<company_id>
								<xsl:value-of select="../../company_id" />
							</company_id>
						</xsl:if>
						<xsl:if test="../../issuing_bank_abbv_name">
							<abbv_name>
								<xsl:value-of select="../../issuing_bank_abbv_name" />
							</abbv_name>
						</xsl:if>
						<xsl:if test="../../issuing_bank_name">
							<name>
								<xsl:value-of select="../../issuing_bank_name" />
							</name>
						</xsl:if>
						<xsl:if test="../../issuing_bank_address_line_1">
							<address_line_1>
								<xsl:value-of
									select="../../issuing_bank_address_line_1" />
							</address_line_1>
						</xsl:if>
						<xsl:if test="../../issuing_bank_address_line_2">
							<address_line_2>
								<xsl:value-of
									select="../../issuing_bank_address_line_2" />
							</address_line_2>
						</xsl:if>
						<xsl:if test="../../issuing_bank_dom">
							<dom>
								<xsl:value-of select="../../issuing_bank_dom" />
							</dom>
						</xsl:if>
						<xsl:if test="../../issuing_bank_iso_code">
							<iso_code>
								<xsl:value-of select="../../issuing_bank_iso_code" />
							</iso_code>
						</xsl:if>
						<xsl:if test="../../issuing_bank_reference">
							<reference>
								<xsl:value-of select="../../issuing_bank_reference" />
							</reference>
						</xsl:if>
					</com.misys.portal.product.common.Bank>
					<com.misys.portal.product.common.Narrative>
						<xsl:if test="../../brch_code">
							<brch_code>
								<xsl:value-of select="../../brch_code" />
							</brch_code>
						</xsl:if>
						<xsl:if test="../../company_id">
							<company_id>
								<xsl:value-of select="../../company_id" />
							</company_id>
						</xsl:if>
						<xsl:if test="../../ref_id">
							<ref_id>
								<xsl:value-of select="../../ref_id" />
							</ref_id>
						</xsl:if>
						<xsl:if test="../../tnx_id">
							<tnx_id>
								<xsl:value-of select="../../tnx_id" />
							</tnx_id>
						</xsl:if>
						<type_code>11</type_code>
						<xsl:if test="../../bo_comment">
							<text>
								<xsl:value-of select="../../bo_comment" />
							</text>
						</xsl:if>
					</com.misys.portal.product.common.Narrative>
					<com.misys.portal.product.common.Narrative>
						<xsl:if test="../../brch_code">
							<brch_code>
								<xsl:value-of select="../../brch_code" />
							</brch_code>
						</xsl:if>
						<xsl:if test="../../company_id">
							<company_id>
								<xsl:value-of select="../../company_id" />
							</company_id>
						</xsl:if>
						<xsl:if test="../../ref_id">
							<ref_id>
								<xsl:value-of select="../../ref_id" />
							</ref_id>
						</xsl:if>
						<xsl:if test="../../tnx_id">
							<tnx_id>
								<xsl:value-of select="../../tnx_id" />
							</tnx_id>
						</xsl:if>
						<type_code>12</type_code>
						<xsl:if test="../../free_format_text">
							<text>
								<xsl:value-of select="../../free_format_text" />
							</text>
						</xsl:if>
					</com.misys.portal.product.common.Narrative>
					<com.misys.portal.product.common.Narrative>
						<xsl:if test="../../brch_code">
							<brch_code>
								<xsl:value-of select="../../brch_code" />
							</brch_code>
						</xsl:if>
						<xsl:if test="../../company_id">
							<company_id>
								<xsl:value-of select="../../company_id" />
							</company_id>
						</xsl:if>
						<xsl:if test="../../ref_id">
							<ref_id>
								<xsl:value-of select="../../ref_id" />
							</ref_id>
						</xsl:if>
						<xsl:if test="../../tnx_id">
							<tnx_id>
								<xsl:value-of select="../../tnx_id" />
							</tnx_id>
						</xsl:if>
						<type_code>13</type_code>
						<xsl:if test="../../amd_details">
							<text>
								<xsl:value-of select="../../amd_details" />
							</text>
						</xsl:if>
					</com.misys.portal.product.common.Narrative>
				</com.misys.portal.cash.product.ft.common.FundTransferFile>
			</xsl:for-each>
		</result>
	</xsl:template>
	

     <xsl:template name="product-additional-fields"/>
     
     <xsl:template match="invoice_items/invoice">
		<com.misys.portal.openaccount.product.in.common.InvoiceFile>
			<!-- Common Values -->
			<com.misys.portal.openaccount.product.in.common.Invoice>
				<ref_id><xsl:value-of select="invoice_ref_id"/></ref_id>
				<product_code>IN</product_code>
				<tnx_id><xsl:value-of select="utils:getTnxIdForInvoiceBulked(//ref_id, invoice_ref_id)"/></tnx_id>				
				
		</com.misys.portal.openaccount.product.in.common.Invoice>
		
		</com.misys.portal.openaccount.product.in.common.InvoiceFile>
		
		</xsl:template>
	   <xsl:template match="invoice_payable_items/invoice_payable">
		<com.misys.portal.openaccount.product.ip.common.InvoicePayableFile>
			<!-- Common Values -->
			<com.misys.portal.openaccount.product.ip.common.InvoicePayable>
				<ref_id><xsl:value-of select="invoice_payable_ref_id"/></ref_id>
				<product_code>IP</product_code>
				<tnx_id><xsl:value-of select="utils:getTnxIdForInvoiceBulked(//ref_id, invoice_payable_ref_id)"/></tnx_id>				
			</com.misys.portal.openaccount.product.ip.common.InvoicePayable>		
		</com.misys.portal.openaccount.product.ip.common.InvoicePayableFile>
		
		</xsl:template>
     </xsl:stylesheet>
