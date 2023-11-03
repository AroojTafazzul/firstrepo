<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				exclude-result-prefixes="tools">
	<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<!-- Common templates used among cash products -->
	<xsl:include href="../../../cash/xsl/cash_save_common.xsl"/>


	<!-- Process Foreign Exchange -->
	<xsl:template match="td_tnx_record">
		<!-- Retrieve references from DB -->
		<!-- Declare variable at top-level to make them visible from any templates -->
		
		<!-- Get the ref_id from bo_ref_id if this is a treasury Term Deposit -->
		<xsl:variable name="retrieve_ref_id">
			<xsl:choose>
				<xsl:when test="sub_product_code and sub_product_code[.='TRTD']">
					<xsl:value-of select="tools:retrieveRefIdFromBoRefId(bo_ref_id, product_code, null, null)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="ref_id"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<!-- Get the tnx_id from trade_id or bo_ref_id if this is a treasury Term Deposit -->
		<xsl:variable name="retrieve_tnx_id">
			<xsl:choose>
				<xsl:when test="sub_product_code and sub_product_code[.='TRTD']">
					<xsl:value-of select="tools:retrieveTnxIdFromTradeIdOrBoTnxId($retrieve_ref_id,trade_id, bo_tnx_id, product_code, null, null)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="tnx_id"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		
		<xsl:variable name="references" select="tools:manageReferences(product_code, $retrieve_ref_id, $retrieve_tnx_id, bo_ref_id, cust_ref_id, company_id, company_name, applicant_reference, issuing_bank/abbv_name, '01')"/>
		
		<xsl:variable name="ref_id" select="$references/references/ref_id"/>
		<xsl:variable name="tnx_id" select="$references/references/tnx_id"/>
		<xsl:variable name="company_id" select="$references/references/company_id"/>
		<xsl:variable name="company_name" select="$references/references/company_name"/>
		<xsl:variable name="entity" select="$references/references/entity"/>
		<xsl:variable name="main_bank_abbv_name" select="$references/references/main_bank_abbv_name"/>
		<xsl:variable name="main_bank_name" select="$references/references/main_bank_name"/>
		<xsl:variable name="customer_bank_reference" select="$references/references/customer_bank_reference"/>
		
		<xsl:variable name="child_tnx_id" select="tools:retrieveCrossReferenceChildTnxId($ref_id, $tnx_id)"/>
		<xsl:variable name="createChild">
			<xsl:choose>
				<xsl:when test="action_req_code[.='80']">N</xsl:when>
				<xsl:when test="action_req_code[.!='80'] and $child_tnx_id != ''">N</xsl:when>
				<xsl:otherwise>Y</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="updateChild">
		<xsl:choose>
				<xsl:when test="action_req_code[.!='80'] and $child_tnx_id != ''">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		
		<result>
			<com.misys.portal.cash.product.td.common.TermDeposit>
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>
				
				<company_id>
					<xsl:value-of select="$company_id"/>
				</company_id>
				<xsl:if test="entity">
					<entity><xsl:value-of select="entity"/></entity>
				</xsl:if>
				<xsl:if test="$entity!='' and not(entity)">
					<entity><xsl:value-of select="$entity"/></entity>
				</xsl:if>
				<company_name>
					<xsl:value-of select="$company_name"/>
				</company_name>
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
				<xsl:if test="td_cur_code">
					<td_cur_code>
						<xsl:value-of select="td_cur_code"/>
					</td_cur_code>
				</xsl:if>
				<xsl:if test="td_amt">
					<td_amt>
						<xsl:value-of select="td_amt"/>
					</td_amt>
				</xsl:if>
				<xsl:if test="td_liab_amt">
					<td_liab_amt>
						<xsl:value-of select="td_liab_amt"/>
					</td_liab_amt>
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
				<xsl:if test="applicant_act_description">
					<applicant_act_description>
							<xsl:value-of select="applicant_act_description"/>
					</applicant_act_description>
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
				<xsl:if test="$customer_bank_reference">
					<applicant_reference>
						<xsl:value-of select="$customer_bank_reference"/>
					</applicant_reference>
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
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>
				<xsl:if test="maturity_date">
					<maturity_date>
						<xsl:value-of select="maturity_date"/>
					</maturity_date>
				</xsl:if>
				<xsl:if test="maturity_date_term_number and maturity_date_term_number[.!='']">
					<maturity_date_term_number>
						<xsl:value-of select="maturity_date_term_number"/>
					</maturity_date_term_number>
				</xsl:if>
				<xsl:if test="maturity_date_term_code and maturity_date_term_code[.!='']">
					<maturity_date_term_code>
						<xsl:value-of select="maturity_date_term_code"/>
					</maturity_date_term_code>
				</xsl:if>
				<xsl:if test="rebook_input_maturity_number and rebook_input_maturity_number[.!='']">
					<maturity_date_term_number>
						<xsl:value-of select="rebook_input_maturity_number"/>
					</maturity_date_term_number>
				</xsl:if>
				<xsl:if test="rebook_input_maturity_code and rebook_input_maturity_code[.!='']">
					<maturity_date_term_code>
						<xsl:value-of select="rebook_input_maturity_code"/>
					</maturity_date_term_code>
				</xsl:if>
				<xsl:if test="rebook_input_value_number and rebook_input_value_number[.!='']">
					<value_date_term_number>
						<xsl:value-of select="rebook_input_value_number"/>
					</value_date_term_number>
				</xsl:if>
				<xsl:if test="rebook_input_value_code and rebook_input_value_code[.!='']">
					<value_date_term_code>
						<xsl:value-of select="rebook_input_value_code"/>
					</value_date_term_code>
				</xsl:if>
				<xsl:if test="trade_id">
					<trade_id>
						<xsl:value-of select="trade_id"/>
					</trade_id>
				</xsl:if>
				<xsl:if test="td_type">
					<td_type>
						<xsl:value-of select="td_type"/>
					</td_type>
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
				<xsl:if test="interest_capitalisation">
					<interest_capitalisation>
						<xsl:value-of select="interest_capitalisation"/>
					</interest_capitalisation>
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
				<xsl:if test="value_date">
					<value_date>
						<xsl:value-of select="value_date"/>
					</value_date>
				</xsl:if>
				<xsl:if test="value_date_term_number and value_date_term_number[.!='']">
					<value_date_term_number>
						<xsl:value-of select="value_date_term_number"/>
					</value_date_term_number>
				</xsl:if>				
				<xsl:if test="value_date_term_code and value_date_term_code[.!='']">
					<value_date_term_code>
						<xsl:value-of select="value_date_term_code"/>
					</value_date_term_code>
				</xsl:if>				
				<xsl:if test="action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code"/>
					</action_req_code>
				</xsl:if>
				
				<xsl:if test="remarks">
					<remarks>
						<xsl:value-of select="remarks"/>
					</remarks>
				</xsl:if>		
				<xsl:if test="reversal_reason">
					<reversal_reason>
						<xsl:value-of select="reversal_reason"/>
					</reversal_reason>
				</xsl:if>	
				<xsl:if test="payment_type">
					<payment_type>
						<xsl:value-of select="payment_type"/>
					</payment_type>
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
					<rec_id>
						<xsl:value-of select="rec_id"/>
					</rec_id>
				</xsl:if>
				
				<!-- Standing Instruction Details -->
				<xsl:if test="payment_instructions_id">
					<payment_instructions_id>
						<xsl:value-of select="payment_instructions_id"/>
					</payment_instructions_id>
				</xsl:if>
				<xsl:if test="receipt_instructions_id">
					<receipt_instructions_id>
						<xsl:value-of select="receipt_instructions_id"/>
					</receipt_instructions_id>
				</xsl:if>
				<xsl:if test="additional_details_line_1_input">
					<additional_field name="additional_details_line_1" type="string" scope="none" description="Additional Details Line 1">
						<xsl:value-of select="additional_details_line_1_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="additional_details_line_2_input">
					<additional_field name="additional_details_line_2" type="string" scope="none" description="Additional Details Line 2">
						<xsl:value-of select="additional_details_line_2_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="additional_details_line_3_input">
					<additional_field name="additional_details_line_3" type="string" scope="none" description="Additional Details Line 3">
						<xsl:value-of select="additional_details_line_3_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="additional_details_line_4_input">
					<additional_field name="additional_details_line_4" type="string" scope="none" description="Additional Details Line 4">
						<xsl:value-of select="additional_details_line_4_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="payment_cur">
					<additional_field name="payment_cur" type="string" scope="transaction" description="Payment Cur.">
						<xsl:value-of select="payment_cur"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="payment_amt">
					<additional_field name="payment_amt" type="amount" scope="transaction" description="Payment Amount">
						<xsl:value-of select="payment_amt"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="payment_type">
					<payment_type>
						<xsl:value-of select="payment_type"/>
					</payment_type>
				</xsl:if>
				<xsl:if test="beneficiary_name">
					<additional_field name="beneficiary_name" type="string" scope="none" description="Beneficiary Name">
						<xsl:value-of select="beneficiary_name"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_address">
					<additional_field name="beneficiary_address" type="string" scope="none" description="Beneficiary Address">
						<xsl:value-of select="beneficiary_address"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_city">
					<additional_field name="beneficiary_city" type="string" scope="none" description="Beneficiary City">
						<xsl:value-of select="beneficiary_city"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_country">
					<additional_field name="beneficiary_country_code" type="string" scope="none" description="Beneficiary Country Code">
						<xsl:value-of select="beneficiary_country"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_account">
					<additional_field name="beneficiary_account" type="string" scope="none" description="Beneficiary Account">
						<xsl:value-of select="beneficiary_account"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_bank">
					<additional_field name="beneficiary_bank" type="string" scope="none" description="Beneficiary Bank">
						<xsl:value-of select="beneficiary_bank"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_bank_routing_number">
					<additional_field name="beneficiary_bank_routing_number" type="string" scope="none" description="Beneficiary Bank Routing Number">
						<xsl:value-of select="beneficiary_bank_routing_number"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_bank_branch">
					<additional_field name="beneficiary_bank_branch" type="string" scope="none" description="Beneficiary Bank Branch">
						<xsl:value-of select="beneficiary_bank_branch"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_bank_address">
					<additional_field name="beneficiary_bank_address" type="string" scope="none" description="Beneficiary Bank Address">
						<xsl:value-of select="beneficiary_bank_address"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_bank_city">
					<additional_field name="beneficiary_bank_city" type="string" scope="none" description="Beneficiary Bank City">
						<xsl:value-of select="beneficiary_bank_city"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_bank_country">
					<additional_field name="beneficiary_bank_country" type="string" scope="none" description="Beneficiary Bank Country">
						<xsl:value-of select="beneficiary_bank_country"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_bank_account">
					<additional_field name="beneficiary_bank_account" type="string" scope="none" description="Beneficiary Bank Account">
						<xsl:value-of select="beneficiary_bank_account"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="intermediary_bank">
					<additional_field name="intermediary_bank" type="string" scope="none" description="Intermediary Bank">
						<xsl:value-of select="intermediary_bank"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="intermediary_bank_aba">
					<additional_field name="intermediary_bank_aba" type="string" scope="none" description="Intermediary Bank ABA/SWIFT ID/Telex">
						<xsl:value-of select="intermediary_bank_aba"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="intermediary_bank_street">
					<additional_field name="intermediary_bank_street" type="string" scope="none" description="Intermediary Bank Street">
						<xsl:value-of select="intermediary_bank_street"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="intermediary_bank_city">
					<additional_field name="intermediary_bank_city" type="string" scope="none" description="Intermediary Bank City">
						<xsl:value-of select="intermediary_bank_city"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="intermediary_bank_country">
					<additional_field name="intermediary_bank_country" type="string" scope="none" description="Intermediary Bank Country">
						<xsl:value-of select="intermediary_bank_country"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="intermediary_bank_instruction_1">
					<additional_field name="intermediary_bank_instruction_1" type="string" scope="none" description="Intermediary Bank Instruction 1">
						<xsl:value-of select="intermediary_bank_instruction_1"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="intermediary_bank_instruction_2">
					<additional_field name="intermediary_bank_instruction_2" type="string" scope="none" description="Intermediary Bank Instruction 2">
						<xsl:value-of select="intermediary_bank_instruction_2"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="free_additional_details_line_1_input">
					<additional_field name="free_additional_details_line_1" type="string" scope="none" description="Free additional Details Line 1.">
						<xsl:value-of select="free_additional_details_line_1_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="free_additional_details_line_2_input">
					<additional_field name="free_additional_details_line_2" type="string" scope="none" description="Free additional Details Line 2.">
						<xsl:value-of select="free_additional_details_line_2_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="free_additional_details_line_3_input">
					<additional_field name="free_additional_details_line_3" type="string" scope="none" description="Free additional Details Line 3.">
						<xsl:value-of select="free_additional_details_line_3_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="free_additional_details_line_4_input">
					<additional_field name="free_additional_details_line_4" type="string" scope="none" description="Free additional Details Line 4.">
						<xsl:value-of select="free_additional_details_line_4_input"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="prod_code">
					<prodcode>
						<xsl:value-of select="prod_code"/>
					</prodcode>
				</xsl:if>
				
				<xsl:if test="prod_type">
					<prodtype>
						<xsl:value-of select="prod_type"/>
					</prodtype>
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
					<additional_field name="near_additional_details_line_1" type="string" scope="none" description="Near Additional Details Line 1">
						<xsl:value-of select="near_additional_details_line_1_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_additional_details_line_2_input">
					<additional_field name="near_additional_details_line_2" type="string" scope="none" description="Near Additional Details Line 2">
						<xsl:value-of select="near_additional_details_line_2_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_additional_details_line_3_input">
					<additional_field name="near_additional_details_line_3" type="string" scope="none" description="Near Additional Details Line 3">
						<xsl:value-of select="near_additional_details_line_3_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_additional_details_line_4_input">
					<additional_field name="near_additional_details_line_4" type="string" scope="none" description="Near Additional Details Line 4">
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
					<additional_field name="near_beneficiary_name" type="string" scope="none" description="Near Beneficiary Name">
						<xsl:value-of select="near_beneficiary_name"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_address">
					<additional_field name="near_beneficiary_address" type="string" scope="none" description="Near Beneficiary Address">
						<xsl:value-of select="near_beneficiary_address"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_city">
					<additional_field name="near_beneficiary_city" type="string" scope="none" description="Near Beneficiary City">
						<xsl:value-of select="near_beneficiary_city"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_country">
					<additional_field name="near_beneficiary_country_code" type="string" scope="none" description="Near Beneficiary Country Code">
						<xsl:value-of select="near_beneficiary_country"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_account">
					<additional_field name="near_beneficiary_account" type="string" scope="none" description="Near Beneficiary Account">
						<xsl:value-of select="near_beneficiary_account"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_bank">
					<additional_field name="near_beneficiary_bank" type="string" scope="none" description="Near Beneficiary Bank">
						<xsl:value-of select="near_beneficiary_bank"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_bank_routing_number">
					<additional_field name="near_beneficiary_bank_routing_number" type="string" scope="none" description="Near Beneficiary Bank Routing Number">
						<xsl:value-of select="near_beneficiary_bank_routing_number"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_bank_branch">
					<additional_field name="near_beneficiary_bank_branch" type="string" scope="none" description="Near Beneficiary Bank Branch">
						<xsl:value-of select="near_beneficiary_bank_branch"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_bank_address">
					<additional_field name="near_beneficiary_bank_address" type="string" scope="none" description="Near Beneficiary Bank Address">
						<xsl:value-of select="near_beneficiary_bank_address"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_bank_city">
					<additional_field name="near_beneficiary_bank_city" type="string" scope="none" description="Near Beneficiary Bank City">
						<xsl:value-of select="near_beneficiary_bank_city"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_bank_country">
					<additional_field name="near_beneficiary_bank_country" type="string" scope="none" description="Near Beneficiary Bank Country">
						<xsl:value-of select="near_beneficiary_bank_country"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_beneficiary_bank_account">
					<additional_field name="near_beneficiary_bank_account" type="string" scope="none" description="Near Beneficiary Bank Account">
						<xsl:value-of select="near_beneficiary_bank_account"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_intermediary_bank">
					<additional_field name="near_intermediary_bank" type="string" scope="none" description="Near Intermediary Bank">
						<xsl:value-of select="near_intermediary_bank"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_intermediary_bank_aba">
					<additional_field name="near_intermediary_bank_aba" type="string" scope="none" description="Near Intermediary Bank ABA/SWIFT ID/Telex">
						<xsl:value-of select="near_intermediary_bank_aba"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_intermediary_bank_street">
					<additional_field name="near_intermediary_bank_street" type="string" scope="none" description="Near Intermediary Bank Street">
						<xsl:value-of select="near_intermediary_bank_street"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_intermediary_bank_city">
					<additional_field name="near_intermediary_bank_city" type="string" scope="none" description="Near Intermediary Bank City">
						<xsl:value-of select="near_intermediary_bank_city"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_intermediary_bank_country">
					<additional_field name="near_intermediary_bank_country" type="string" scope="none" description="Near Intermediary Bank Country">
						<xsl:value-of select="near_intermediary_bank_country"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_intermediary_bank_instruction_1">
					<additional_field name="near_intermediary_bank_instruction_1" type="string" scope="none" description="Near Intermediary Bank Instruction 1">
						<xsl:value-of select="near_intermediary_bank_instruction_1"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_intermediary_bank_instruction_2">
					<additional_field name="near_intermediary_bank_instruction_2" type="string" scope="none" description="Near Intermediary Bank Instruction 2">
						<xsl:value-of select="near_intermediary_bank_instruction_2"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_free_additional_details_line_1_input">
					<additional_field name="near_free_additional_details_line_1" type="string" scope="none" description="Near Free additional Details Line 1">
						<xsl:value-of select="near_free_additional_details_line_1_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_free_additional_details_line_2_input">
					<additional_field name="near_free_additional_details_line_2" type="string" scope="none" description="Near Free additional Details Line 2">
						<xsl:value-of select="near_free_additional_details_line_2_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_free_additional_details_line_3_input">
					<additional_field name="near_free_additional_details_line_3" type="string" scope="none" description="Near Free additional Details Line 3">
						<xsl:value-of select="near_free_additional_details_line_3_input"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="near_free_additional_details_line_4_input">
					<additional_field name="near_free_additional_details_line_4" type="string" scope="none" description="Near Free additional Details Line 4">
						<xsl:value-of select="near_free_additional_details_line_4_input"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="placement_act_name">
					<additional_field name="placement_act_name" type="string" scope="master" description="placement Account Name">
						<xsl:value-of select="placement_act_name"/>
					</additional_field>
				</xsl:if>					
				<xsl:if test="placement_act_cur_code">
					<additional_field name="placement_act_cur_code" type="string" scope="master" description="placement Account Currency Code">
						<xsl:value-of select="placement_act_cur_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="placement_act_no">
					<additional_field name="placement_act_no" type="string" scope="master" description="Debit Account Number">
						<xsl:value-of select="placement_act_no"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="placement_act_description">
					<additional_field name="placement_act_description" type="string" scope="master" description="placement Account Description">
						<xsl:value-of select="placement_act_description"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="placement_act_pab">
					<additional_field name="placement_act_pab" type="string" scope="master" description="placement Account Pre Approved Beneficiary">
						<xsl:value-of select="placement_act_pab"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="applicant_act_pab">
					<additional_field name="applicant_act_pab" type="string" scope="master" description="Debit Account Pre Approved Beneficiary">
						<xsl:value-of select="applicant_act_pab"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="credit_act_name">
					<additional_field name="credit_act_name" type="string" scope="master" description="Credit Account Name">
						<xsl:value-of select="credit_act_name"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="credit_act_cur_code">
					<additional_field name="credit_act_cur_code" type="string" scope="master" description="Credit Account Currency Code">
						<xsl:value-of select="credit_act_cur_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="credit_act_no">
					<additional_field name="credit_act_no" type="string" scope="master" description="Credit Account Number">
						<xsl:value-of select="credit_act_no"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="credit_act_description">
					<additional_field name="credit_act_description" type="string" scope="master" description="Credit Account Description">
						<xsl:value-of select="credit_act_description"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="credit_act_pab">
					<additional_field name="credit_act_pab" type="string" scope="master" description="Credit Account Pre Approval Beneficiary">
						<xsl:value-of select="credit_act_pab"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="maturity_instruction">
					<additional_field name="maturity_instruction" type="string" scope="master" description="Maturity Instraction Code">
						<xsl:value-of select="maturity_instruction"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="maturity_instruction_name">
					<additional_field name="maturity_instruction_name" type="string" scope="master" description="Maturity Instraction Name">
						<xsl:value-of select="maturity_instruction_name"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="accured_interest">
					<additional_field name="accured_interest" type="string" scope="master" description="Accured Interest">
						<xsl:value-of select="accured_interest"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="premature_withdrawal_penalty">
					<additional_field name="premature_withdrawal_penalty" type="string" scope="master" description="Premature Withdrawal Penalty">
						<xsl:value-of select="premature_withdrawal_penalty"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="withholding_tax">
					<additional_field name="withholding_tax" type="string" scope="master" description="Withholding Tax">
						<xsl:value-of select="withholding_tax"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="hold_mail_charges">
					<additional_field name="hold_mail_charges" type="string" scope="master" description="Hold Mail Charges">
						<xsl:value-of select="hold_mail_charges"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="annual_postage_fee">
					<additional_field name="annual_postage_fee" type="string" scope="master" description="Annual Postage Fee">
						<xsl:value-of select="annual_postage_fee"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="withdrawable_interest">
					<additional_field name="withdrawable_interest" type="string" scope="master" description="Withdrawable Interest">
						<xsl:value-of select="withdrawable_interest"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="net_settlement_amount">
					<additional_field name="net_settlement_amount" type="string" scope="master" description="Net Settlement Amount">
						<xsl:value-of select="net_settlement_amount"/>
					</additional_field>
				</xsl:if>

				<xsl:if test="DueWtdrwDt">
					<additional_field name="DueWtdrwDt" type="string" scope="master" description="Due Date/Withdrawal Date">
						<xsl:value-of select="DueWtdrwDt"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="HoldCode">
					<additional_field name="HoldCode" type="string" scope="master" description="Hold Code">
						<xsl:value-of select="HoldCode"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="PledgeBranchCode">
					<additional_field name="PledgeBranchCode" type="string" scope="master" description="Pledge Branch Code">
						<xsl:value-of select="PledgeBranchCode"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="FundValDate">
					<additional_field name="FundValDate" type="string" scope="master" description="Fund Value Date">
						<xsl:value-of select="FundValDate"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="ReplCost">
					<additional_field name="ReplCost" type="string" scope="master" description="Replacement Cost">
						<xsl:value-of select="ReplCost"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="SibidSibor">
					<additional_field name="SibidSibor" type="string" scope="master" description="sibid/sibor">
						<xsl:value-of select="SibidSibor"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="WaiveIndicator">
					<additional_field name="WaiveIndicator" type="string" scope="master" description="Waive Indicator">
						<xsl:value-of select="WaiveIndicator"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="TranchNum">
					<additional_field name="TranchNum" type="string" scope="master" description="Tranch Number">
						<xsl:value-of select="TranchNum"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="MinAmt">
					<additional_field name="MinAmt" type="string" scope="master" description="Minimum Amount">
						<xsl:value-of select="MinAmt"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="SgdDepAmt">
					<additional_field name="SgdDepAmt" type="string" scope="master" description="SGD equivalence of deposit amount">
						<xsl:value-of select="SgdDepAmt"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="SgdXchgRate">
					<additional_field name="SgdXchgRate" type="string" scope="master" description="SGD Exchange rate used to compute SGD equivalent">
						<xsl:value-of select="SgdXchgRate"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="ConvertedAmt">
					<additional_field name="ConvertedAmt" type="string" scope="master" description="Converted Amount">
						<xsl:value-of select="ConvertedAmt"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="CtrRate">
					<additional_field name="CtrRate" type="string" scope="master" description="Contract Rate">
						<xsl:value-of select="CtrRate"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="FcfdAmt">
					<additional_field name="FcfdAmt" type="string" scope="master" description="FCFD amount in deposit ccy">
						<xsl:value-of select="FcfdAmt"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="bank_value_date">
					<additional_field name="bank_value_date" type="date" scope="master" description="Bank Value Date Received in TD PASS1">
						<xsl:value-of select="bank_value_date"/>
					</additional_field>
				</xsl:if>
				
				<xsl:choose> 
					<xsl:when test="action_req_code='81'">
						<RECEIPT_COMPLETED_INDICATOR>Y</RECEIPT_COMPLETED_INDICATOR>							
					</xsl:when>
					<xsl:when test="action_req_code='82'">
						<PAYMENT_COMPLETED_INDICATOR>Y</PAYMENT_COMPLETED_INDICATOR>
					</xsl:when>
				</xsl:choose>
				
				<additional_field name="createChild" type="string" scope="none" description="Flag to identify whether child to be created">
					<xsl:value-of select="$createChild"/>
				</additional_field>
				
				<additional_field name="updateChild" type="string" scope="none" description="Flag to identify whether needs to update child transaction">
				    <xsl:value-of select="$updateChild"/>
				</additional_field>
				</com.misys.portal.cash.product.td.common.TermDeposit>
				
	<!-- Counterparty Details for settlement instructions -->
		
		<xsl:if test="sub_product_code and sub_product_code[.='TRTD']">
					
			<com.misys.portal.product.common.Counterparty counterparty_type="03">
				
				<counterparty_id> 
					<xsl:value-of select="tools:retrieveCounterPartyId ($tnx_id, $ref_id, '03')" />
				</counterparty_id>
								
				<xsl:call-template name="incoming-customer-payment"/>
				
				
				<xsl:if test="settlement_cust_ref[.='']">
						<counterparty_name>
							<xsl:value-of select="$references/references/counterparty/counterparty_name"/>
						</counterparty_name>
				</xsl:if>
				<xsl:if test="$references/references/counterparty/counterparty_cur_code">
						<counterparty_cur_code>
							<xsl:value-of select="$references/references/counterparty/counterparty_cur_code"/>
						</counterparty_cur_code>
				</xsl:if> 
				<xsl:if test="$references/references/counterparty/counterparty_act_no">
						<counterparty_act_no>
							<xsl:value-of select="$references/references/counterparty/counterparty_act_no"/>
						</counterparty_act_no>
				</xsl:if> 
				
			</com.misys.portal.product.common.Counterparty>

			<com.misys.portal.product.common.Counterparty counterparty_type="04">
				<counterparty_id> 
					<xsl:value-of select="tools:retrieveCounterPartyId ($tnx_id, $ref_id, '04')" />
				</counterparty_id>
				
				<xsl:choose>
					<xsl:when test="receipt_instructions_id != ''">
						<xsl:call-template name="bank-payment"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="free-format">
							<xsl:with-param name="countryText">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>						
			</com.misys.portal.product.common.Counterparty>
					
		</xsl:if>
				
	<!-- End of Counterparty Details for settlement instructions -->
				
				
				
				
			<com.misys.portal.product.common.Bank role_code="01">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<abbv_name><xsl:value-of select="$main_bank_abbv_name"/></abbv_name>
				<xsl:if test="issuing_bank/name"><name><xsl:value-of select="issuing_bank/name"/></name></xsl:if>
				<xsl:if test="$main_bank_name and not(issuing_bank/name)"><name><xsl:value-of select="$main_bank_name"/></name></xsl:if>
				<xsl:if test="issuing_bank/address_line_1"><address_line_1><xsl:value-of select="issuing_bank/address_line_1"/></address_line_1></xsl:if>
				<xsl:if test="issuing_bank/address_line_2"><address_line_2><xsl:value-of select="issuing_bank/address_line_2"/></address_line_2></xsl:if>
				<xsl:if test="issuing_bank/dom"><dom><xsl:value-of select="issuing_bank/dom"/></dom></xsl:if>
				<xsl:if test="issuing_bank/iso_code"><iso_code><xsl:value-of select="issuing_bank/iso_code"/></iso_code></xsl:if>
				<xsl:if test="issuing_bank/reference"><reference><xsl:value-of select="issuing_bank/reference"/></reference></xsl:if>
			</com.misys.portal.product.common.Bank>
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
			
			<!-- Create Charges elements -->
			<xsl:apply-templates select="charges/charge">
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="company_id" select="$company_id"/>
			</xsl:apply-templates>
			
			<!-- Create Attachment elements -->
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
					<xsl:with-param name="ref_id" select="ref_id"/>
					<xsl:with-param name="tnx_id" select="tnx_id"/>
					<xsl:with-param name="company_id" select="company_id"/>
		 		</xsl:call-template>
			</xsl:for-each>
			
			
			<!-- Cross References -->
			<xsl:if test="not(sub_product_code) or sub_product_code[.='']">
				<xsl:apply-templates select="cross_references/cross_reference" />
			</xsl:if>
			
			<xsl:if test="sub_product_code and sub_product_code[.='TRTD']">
				<xsl:apply-templates select="cross_references/cross_reference" mode="opics_ssi_cross_ref">
					<xsl:with-param name="ref_id" select="$ref_id"/>
					<xsl:with-param name="tnx_id" select="$tnx_id"/>
					<xsl:with-param name="product_code">TD</xsl:with-param>
					<xsl:with-param name="action_req_code"><xsl:value-of select="action_req_code"/></xsl:with-param>
					<xsl:with-param name="child_tnx_id"><xsl:value-of select="$child_tnx_id"/></xsl:with-param>
				</xsl:apply-templates>
				
			</xsl:if>
			
		</result>
	</xsl:template>
	
	
	
	
	<!-- Cross Reference  -->
	<xsl:template match="cross_reference" mode="opics_ssi_cross_ref">
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="product_code">TD</xsl:param>
		<xsl:param name="action_req_code"></xsl:param>
		<xsl:param name="child_tnx_id"/>
		
		<xsl:variable name="cross_ref_id" select="tools:retrieveCrossRefId($ref_id , $tnx_id , $product_code , $ref_id , null , $product_code )"/>
			<com.misys.portal.product.common.CrossReference>
			<xsl:if test="cross_reference_id">
				<xsl:attribute name="cross_reference_id">
					<xsl:value-of select="$cross_ref_id"/>
				</xsl:attribute>
			</xsl:if>						
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			<product_code><xsl:value-of select="$product_code"/></product_code>
			<ref_id><xsl:value-of select="$ref_id"/></ref_id>
			<tnx_id><xsl:value-of select="$tnx_id"/></tnx_id>
			<child_product_code><xsl:value-of select="$product_code"/></child_product_code>
			<child_ref_id><xsl:value-of select="$ref_id"/></child_ref_id>
			<xsl:choose> 
				<xsl:when test="$child_tnx_id !=''">
					<child_tnx_id><xsl:value-of select="$child_tnx_id"/></child_tnx_id>
				</xsl:when>
				<xsl:otherwise>
					<child_tnx_id></child_tnx_id>
				</xsl:otherwise>
			</xsl:choose>
			<type_code>01</type_code>
		</com.misys.portal.product.common.CrossReference>
	</xsl:template>
</xsl:stylesheet>
