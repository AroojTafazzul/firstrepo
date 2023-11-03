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
	<!-- Process Foreign Exchange -->
	<xsl:template match="la_tnx_record">
		<result>
			<com.misys.portal.cash.product.la.common.CashLoan>
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
				<xsl:if test="la_cur_code">
					<la_cur_code>
						<xsl:value-of select="la_cur_code"/>
					</la_cur_code>
				</xsl:if>
				<xsl:if test="la_amt">
					<la_amt>
						<xsl:value-of select="la_amt"/>
					</la_amt>
				</xsl:if>
				<xsl:if test="la_liab_amt">
					<la_liab_amt>
						<xsl:value-of select="la_liab_amt"/>
					</la_liab_amt>
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
				<xsl:if test="applicant_reference">
					<applicant_reference>
						<xsl:value-of select="applicant_reference"/>
					</applicant_reference>
				</xsl:if>
				<xsl:if test="fee_act_no">
					<fee_act_no>
						<xsl:value-of select="fee_act_no"/>
					</fee_act_no>
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
				<xsl:if test="maturity_date_hidden">
					<maturity_date>
						<xsl:value-of select="maturity_date_hidden"/>
					</maturity_date>
				</xsl:if>
				<xsl:if test="maturity_date_number">
					<maturity_date_term_number>
						<xsl:value-of select="maturity_date_number"/>
					</maturity_date_term_number>
				</xsl:if>
				<xsl:if test="maturity_date_code">
					<maturity_date_term_code>
						<xsl:value-of select="maturity_date_code"/>
					</maturity_date_term_code>
				</xsl:if>
				<xsl:if test="trade_id">
					<trade_id>
						<xsl:value-of select="trade_id"/>
					</trade_id>
				</xsl:if>
				<xsl:if test="rate">
					<rate>
						<xsl:value-of select="rate"/>
					</rate>
				</xsl:if>
				<xsl:if test="interest">
					<interest>
						<xsl:value-of select="interest"/>
					</interest>
				</xsl:if>
				<xsl:if test="total_with_interest">
					<total_with_interest>
						<xsl:value-of select="total_with_interest"/>
					</total_with_interest>
				</xsl:if>
				<xsl:if test="account_id">
					<account_id>
						<xsl:value-of select="ACCOUNT_ID"/>
					</account_id>
				</xsl:if>
				<xsl:if test="value_date_hidden">
					<value_date>
						<xsl:value-of select="value_date_hidden"/>
					</value_date>
				</xsl:if>				
				<xsl:if test="value_date_number">
					<value_date_term_number>
						<xsl:value-of select="value_date_number"/>
					</value_date_term_number>
				</xsl:if>				
				<xsl:if test="value_date_code">
					<value_date_term_code>
						<xsl:value-of select="value_date_code"/>
					</value_date_term_code>
				</xsl:if>
				
				<xsl:if test="reversal_reason">
					<additional_field name="reversal_reason" type="string" scope="transaction" description="Reversal reason">
						<xsl:value-of select="reversal_reason"/>
					</additional_field>
				</xsl:if>	
				
				<xsl:if test="remarks">
					<remarks>
						<xsl:value-of select="remarks"/>
					</remarks>
				</xsl:if>		
				<!-- Previous ctl date, used or synchronization issues -->
				<xsl:if test="old_ctl_dttm">
					<additional_field name="old_ctl_dttm" type="time" scope="none" description="Previous control date used for synchronisation issues">
						<xsl:value-of select="old_ctl_dttm"/>
					</additional_field>
				</xsl:if>
	        	<!-- Previous input date, used to know if the product is already saved -->
				<xsl:if test="old_inp_dttm">
					<additional_field name="old_inp_dttm" type="time" scope="none" description="Previous input date used for synchronisation issues">
						<xsl:value-of select="old_inp_dttm"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="token">
					<additional_field name="token" type="string" scope="none" description="Security token">
						<xsl:value-of select="token"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="rec_id">
					<additional_field name="rec_id" type="string" scope="none" description="Opics Request Id.">
						<xsl:value-of select="rec_id"/>
					</additional_field>
				</xsl:if>
				
				<!-- Standing Instruction Details -->
				<xsl:if test="payment_instructions_id">
					<additional_field name="payment_instructions_id" type="string" scope="transaction" description="Payment Instructions Id.">
						<xsl:value-of select="payment_instructions_id"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="receipt_instructions_id">
					<additional_field name="receipt_instructions_id" type="string" scope="transaction" description="Receipt Instructions Id.">
						<xsl:value-of select="receipt_instructions_id"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="additional_details_line_1_input">
					<additional_field name="additional_details_line_1" type="string" scope="transaction" description="Additional Details Line 1">
						<xsl:value-of select="additional_details_line_1_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="additional_details_line_2_input">
					<additional_field name="additional_details_line_2" type="string" scope="transaction" description="Additional Details Line 2">
						<xsl:value-of select="additional_details_line_2_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="additional_details_line_3_input">
					<additional_field name="additional_details_line_3" type="string" scope="transaction" description="Additional Details Line 3">
						<xsl:value-of select="additional_details_line_3_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="additional_details_line_4_input">
					<additional_field name="additional_details_line_4" type="string" scope="transaction" description="Additional Details Line 4">
						<xsl:value-of select="additional_details_line_4_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="payment_cur">
					<additional_field name="payment_cur" type="string" scope="transaction" description="Payment Cur.">
						<xsl:value-of select="payment_cur"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="payment_amt">
					<additional_field name="payment_amt" type="string" scope="transaction" description="Payment Amount">
						<xsl:value-of select="payment_amt"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="payment_type">
					<additional_field name="payment_type" type="string" scope="transaction" description="Payment Type">
						<xsl:value-of select="payment_type"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_name">
					<additional_field name="beneficiary_name" type="string" scope="transaction" description="Beneficiary Name">
						<xsl:value-of select="beneficiary_name"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_address">
					<additional_field name="beneficiary_address" type="string" scope="transaction" description="Beneficiary Address">
						<xsl:value-of select="beneficiary_address"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_city">
					<additional_field name="beneficiary_city" type="string" scope="transaction" description="Beneficiary City">
						<xsl:value-of select="beneficiary_city"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_country">
					<additional_field name="beneficiary_country_code" type="string" scope="transaction" description="Beneficiary Country Code">
						<xsl:value-of select="beneficiary_country"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_account">
					<additional_field name="beneficiary_account" type="string" scope="transaction" description="Beneficiary Account">
						<xsl:value-of select="beneficiary_account"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_bank">
					<additional_field name="beneficiary_bank" type="string" scope="transaction" description="Beneficiary Bank">
						<xsl:value-of select="beneficiary_bank"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_bank_routing_number">
					<additional_field name="beneficiary_bank_routing_number" type="string" scope="transaction" description="Beneficiary Bank Routing Number">
						<xsl:value-of select="beneficiary_bank_routing_number"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_bank_branch">
					<additional_field name="beneficiary_bank_branch" type="string" scope="transaction" description="Beneficiary Bank Branch">
						<xsl:value-of select="beneficiary_bank_branch"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_bank_address">
					<additional_field name="beneficiary_bank_address" type="string" scope="transaction" description="Beneficiary Bank Address">
						<xsl:value-of select="beneficiary_bank_address"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_bank_city">
					<additional_field name="beneficiary_bank_city" type="string" scope="transaction" description="Beneficiary Bank City">
						<xsl:value-of select="beneficiary_bank_city"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_bank_country">
					<additional_field name="beneficiary_bank_country" type="string" scope="transaction" description="Beneficiary Bank Country">
						<xsl:value-of select="beneficiary_bank_country"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_bank_account">
					<additional_field name="beneficiary_bank_account" type="string" scope="transaction" description="Beneficiary Bank Account">
						<xsl:value-of select="beneficiary_bank_account"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="intermediary_bank">
					<additional_field name="intermediary_bank" type="string" scope="transaction" description="Intermediary Bank">
						<xsl:value-of select="intermediary_bank"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="intermediary_bank_aba">
					<additional_field name="intermediary_bank_aba" type="string" scope="transaction" description="Intermediary Bank ABA/SWIFT ID/Telex">
						<xsl:value-of select="intermediary_bank_aba"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="intermediary_bank_street">
					<additional_field name="intermediary_bank_street" type="string" scope="transaction" description="Intermediary Bank Street">
						<xsl:value-of select="intermediary_bank_street"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="intermediary_bank_city">
					<additional_field name="intermediary_bank_city" type="string" scope="transaction" description="Intermediary Bank City">
						<xsl:value-of select="intermediary_bank_city"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="intermediary_bank_country">
					<additional_field name="intermediary_bank_country" type="string" scope="transaction" description="Intermediary Bank Country">
						<xsl:value-of select="intermediary_bank_country"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="intermediary_bank_instruction_1">
					<additional_field name="intermediary_bank_instruction_1" type="string" scope="transaction" description="Intermediary Bank Instruction 1">
						<xsl:value-of select="intermediary_bank_instruction_1"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="intermediary_bank_instruction_2">
					<additional_field name="intermediary_bank_instruction_2" type="string" scope="transaction" description="Intermediary Bank Instruction 2">
						<xsl:value-of select="intermediary_bank_instruction_2"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="free_additional_details_line_1_input">
					<additional_field name="free_additional_details_line_1" type="string" scope="transaction" description="Free additional Details Line 1.">
						<xsl:value-of select="free_additional_details_line_1_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="free_additional_details_line_2_input">
					<additional_field name="free_additional_details_line_2" type="string" scope="transaction" description="Free additional Details Line 2.">
						<xsl:value-of select="free_additional_details_line_2_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="free_additional_details_line_3_input">
					<additional_field name="free_additional_details_line_3" type="string" scope="transaction" description="Free additional Details Line 3.">
						<xsl:value-of select="free_additional_details_line_3_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="free_additional_details_line_4_input">
					<additional_field name="free_additional_details_line_4" type="string" scope="transaction" description="Free additional Details Line 4.">
						<xsl:value-of select="free_additional_details_line_4_input"/>
					</additional_field>
				</xsl:if>
				
				
				<!-- Far Instruction  -->
				<!-- Standing Instructions Details -->
				<xsl:if test="near_payment_instructions_id">
					<additional_field name="near_payment_instructions_id" type="string" scope="transaction" description="Near Payment Instructions Id.">
						<xsl:value-of select="near_payment_instructions_id"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_receipt_instructions_id">
					<additional_field name="near_receipt_instructions_id" type="string" scope="transaction" description="Near Receipt Instructions Id.">
						<xsl:value-of select="near_receipt_instructions_id"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="near_additional_details_line_1_input">
					<additional_field name="near_additional_details_line_1" type="string" scope="transaction" description="Near Additional Details Line 1">
						<xsl:value-of select="near_additional_details_line_1_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_additional_details_line_2_input">
					<additional_field name="near_additional_details_line_2" type="string" scope="transaction" description="Near Additional Details Line 2">
						<xsl:value-of select="near_additional_details_line_2_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_additional_details_line_3_input">
					<additional_field name="near_additional_details_line_3" type="string" scope="transaction" description="Near Additional Details Line 3">
						<xsl:value-of select="near_additional_details_line_3_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_additional_details_line_4_input">
					<additional_field name="near_additional_details_line_4" type="string" scope="transaction" description="Near Additional Details Line 4">
						<xsl:value-of select="near_additional_details_line_4_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_payment_cur">
					<additional_field name="near_payment_cur" type="string" scope="transaction" description="Near Payment Cur">
						<xsl:value-of select="near_payment_cur"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_payment_amt">
					<additional_field name="near_payment_amt" type="string" scope="transaction" description="Near Payment Amt">
						<xsl:value-of select="near_payment_amt"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_payment_type">
					<additional_field name="near_payment_type" type="string" scope="transaction" description="Near Payment Type">
						<xsl:value-of select="near_payment_type"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_name">
					<additional_field name="near_beneficiary_name" type="string" scope="transaction" description="Near Beneficiary Name">
						<xsl:value-of select="near_beneficiary_name"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_address">
					<additional_field name="near_beneficiary_address" type="string" scope="transaction" description="Near Beneficiary Address">
						<xsl:value-of select="near_beneficiary_address"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_city">
					<additional_field name="near_beneficiary_city" type="string" scope="transaction" description="Near Beneficiary City">
						<xsl:value-of select="near_beneficiary_city"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_country">
					<additional_field name="near_beneficiary_country_code" type="string" scope="transaction" description="Near Beneficiary Country Code">
						<xsl:value-of select="near_beneficiary_country"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_account">
					<additional_field name="near_beneficiary_account" type="string" scope="transaction" description="Near Beneficiary Account">
						<xsl:value-of select="near_beneficiary_account"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_bank">
					<additional_field name="near_beneficiary_bank" type="string" scope="transaction" description="Near Beneficiary Bank">
						<xsl:value-of select="near_beneficiary_bank"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_bank_routing_number">
					<additional_field name="near_beneficiary_bank_routing_number" type="string" scope="transaction" description="Near Beneficiary Bank Routing Number">
						<xsl:value-of select="near_beneficiary_bank_routing_number"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_bank_branch">
					<additional_field name="near_beneficiary_bank_branch" type="string" scope="transaction" description="Near Beneficiary Bank Branch">
						<xsl:value-of select="near_beneficiary_bank_branch"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_bank_address">
					<additional_field name="near_beneficiary_bank_address" type="string" scope="transaction" description="Near Beneficiary Bank Address">
						<xsl:value-of select="near_beneficiary_bank_address"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_bank_city">
					<additional_field name="near_beneficiary_bank_city" type="string" scope="transaction" description="Near Beneficiary Bank City">
						<xsl:value-of select="near_beneficiary_bank_city"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_bank_country">
					<additional_field name="near_beneficiary_bank_country" type="string" scope="transaction" description="Near Beneficiary Bank Country">
						<xsl:value-of select="near_beneficiary_bank_country"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_bank_account">
					<additional_field name="near_beneficiary_bank_account" type="string" scope="transaction" description="Near Beneficiary Bank Account">
						<xsl:value-of select="near_beneficiary_bank_account"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_intermediary_bank">
					<additional_field name="near_intermediary_bank" type="string" scope="transaction" description="Near Intermediary Bank">
						<xsl:value-of select="near_intermediary_bank"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_intermediary_bank_aba">
					<additional_field name="near_intermediary_bank_aba" type="string" scope="transaction" description="Near Intermediary Bank ABA/SWIFT ID/Telex">
						<xsl:value-of select="near_intermediary_bank_aba"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_intermediary_bank_street">
					<additional_field name="near_intermediary_bank_street" type="string" scope="transaction" description="Near Intermediary Bank Street">
						<xsl:value-of select="near_intermediary_bank_street"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_intermediary_bank_city">
					<additional_field name="near_intermediary_bank_city" type="string" scope="transaction" description="Near Intermediary Bank City">
						<xsl:value-of select="near_intermediary_bank_city"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_intermediary_bank_country">
					<additional_field name="near_intermediary_bank_country" type="string" scope="transaction" description="Near Intermediary Bank Country">
						<xsl:value-of select="near_intermediary_bank_country"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_intermediary_bank_instruction_1">
					<additional_field name="near_intermediary_bank_instruction_1" type="string" scope="transaction" description="Near Intermediary Bank Instruction 1">
						<xsl:value-of select="near_intermediary_bank_instruction_1"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_intermediary_bank_instruction_2">
					<additional_field name="near_intermediary_bank_instruction_2" type="string" scope="transaction" description="Near Intermediary Bank Instruction 2">
						<xsl:value-of select="near_intermediary_bank_instruction_2"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_free_additional_details_line_1_input">
					<additional_field name="near_free_additional_details_line_1" type="string" scope="transaction" description="Near Free additional Details Line 1">
						<xsl:value-of select="near_free_additional_details_line_1_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_free_additional_details_line_2_input">
					<additional_field name="near_free_additional_details_line_2" type="string" scope="transaction" description="Near Free additional Details Line 2">
						<xsl:value-of select="near_free_additional_details_line_2_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_free_additional_details_line_3_input">
					<additional_field name="near_free_additional_details_line_3" type="string" scope="transaction" description="Near Free additional Details Line 3">
						<xsl:value-of select="near_free_additional_details_line_3_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_free_additional_details_line_4_input">
					<additional_field name="near_free_additional_details_line_4" type="string" scope="transaction" description="Near Free additional Details Line 4">
						<xsl:value-of select="near_free_additional_details_line_4_input"/>
					</additional_field>
				</xsl:if>
				<!-- End of Standing Instructions Details -->
				
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.cash.product.la.common.CashLoan>
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
				<type_code>12</type_code>
				<xsl:if test="free_format_text">
					<text>
						<xsl:value-of select="free_format_text"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			
			<!-- Create Charge element -->
			
			<!-- First, those charges belonging to the current transaction -->
			<xsl:for-each select="//*[starts-with(name(), 'charge_details_chrg_details_')]">
				<xsl:call-template name="CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//ft_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//ft_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//ft_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//ft_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'charge_details_chrg_details_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!-- Second, the charges inputted earlier -->
			<xsl:for-each select="//*[starts-with(name(), 'old_charge_details_position_')]">
				<xsl:call-template name="OLD_CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//ft_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//ft_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//ft_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//ft_tnx_record/tnx_id"/></xsl:with-param>
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
			
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
