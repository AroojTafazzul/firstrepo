<?xml version="1.0"?>
<!--
  		Copyright (c) 2000-2008 Misys (http://www.misys.com)'
  		All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				exclude-result-prefixes="tools">
			
	<!-- Common templates used among cash products -->
	<xsl:include href="../../../cash/xsl/cash_save_common.xsl"/>
		
	<!-- Process foreign eXchange Order -->
	<xsl:template match="fx_tnx_record">
	
		<!-- Retrieve references from DB -->
		<xsl:variable name="retrieve_ref_id" select="tools:retrieveRefIdFromBoRefIdAndTradeId(bo_ref_id,trade_id,product_code, null, null)"/>
		<xsl:variable name="retrieve_tnx_id" select="tools:retrieveTnxIdFromTradeIdOrBoTnxId($retrieve_ref_id,trade_id, bo_tnx_id, product_code, null, null)"/>
		<!--xsl:variable name="retrieve_cust_bank_ref" select="tools:retrieveCustomerBankReference($retrieve_ref_id, $retrieve_tnx_id, product_code)"/-->
		
		<!-- Declare variable at top-level to make them visible from any templates -->
		<xsl:variable name="references" select="tools:manageReferences(product_code, $retrieve_ref_id, $retrieve_tnx_id, bo_ref_id, cust_ref_id, company_id, company_name, applicant_reference, issuing_bank/abbv_name, '01')"/>
		<xsl:variable name="ref_id" select="$references/references/ref_id"/>
		<xsl:variable name="tnx_id" select="$references/references/tnx_id"/>
		<xsl:variable name="company_id" select="$references/references/company_id"/>
		<xsl:variable name="company_name" select="$references/references/company_name"/>
		<xsl:variable name="entity" select="$references/references/entity"/>
		<xsl:variable name="main_bank_abbv_name" select="$references/references/main_bank_abbv_name"/>
		<xsl:variable name="main_bank_name" select="$references/references/main_bank_name"/>
		<xsl:variable name="product_code">FX</xsl:variable>
		
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
			<com.misys.portal.cash.product.fx.common.ForeignExchange>
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="$company_id">
					<company_id>
						<xsl:value-of select="$company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="$entity">
					<entity>
						<xsl:value-of select="$entity"/>
					</entity>
				</xsl:if>
				<xsl:if test="$company_name">
					<company_name>
						<xsl:value-of select="$company_name"/>
					</company_name>
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
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
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
				<xsl:if test="tnx_cur_code ">
					<tnx_cur_code>
						<xsl:value-of select="tnx_cur_code"/>
					</tnx_cur_code>
				</xsl:if>
				<xsl:if test="tnx_amt">
					<tnx_amt>
						<xsl:value-of select="tnx_amt"/>
					</tnx_amt>
				</xsl:if>
				<xsl:if test="tnx_counter_amt">
					<tnx_counter_amt>
						<xsl:value-of select="tnx_counter_amt"/>
					</tnx_counter_amt>
				</xsl:if>
				<xsl:if test="tnx_counter_cur_code">
					<tnx_counter_cur_code>
						<xsl:value-of select="tnx_counter_cur_code"/>
					</tnx_counter_cur_code>
				</xsl:if>
				<xsl:if test="fx_cur_code">
					<fx_cur_code>
						<xsl:value-of select="fx_cur_code"/>
					</fx_cur_code>
				</xsl:if>
				<xsl:if test="fx_amt">
					<fx_amt>
						<xsl:value-of select="fx_amt"/>
					</fx_amt>
				</xsl:if>
				<xsl:if test="near_amt">
					<near_amt>
						<xsl:value-of select="near_amt"/>
					</near_amt>
				</xsl:if>
				<xsl:if test="fx_liab_amt">
					<fx_liab_amt>
						<xsl:value-of select="fx_liab_amt"/>
					</fx_liab_amt>
				</xsl:if>
				<!-- If the refid is different of '' we don't update the type-->
				<xsl:if test="fx_type and fx_type[.!='']">
					<fx_type>
						<xsl:value-of select="fx_type"/>
					</fx_type>
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
				<xsl:if test="maturity_date">
					<maturity_date>
						<xsl:value-of select="maturity_date"/>
					</maturity_date>
				</xsl:if>
				<xsl:if test="counter_amt">
					<counter_amt>
						<xsl:value-of select="counter_amt"/>
					</counter_amt>
				</xsl:if>
				<xsl:if test="near_counter_amt">
					<near_counter_amt>
						<xsl:value-of select="near_counter_amt"/>
					</near_counter_amt>
				</xsl:if>
				<xsl:if test="counter_cur_code">
					<counter_cur_code>
						<xsl:value-of select="counter_cur_code"/>
					</counter_cur_code>
				</xsl:if>
				<xsl:if test="rate">
					<rate>
						<xsl:value-of select="rate"/>
					</rate>
				</xsl:if>
				<xsl:if test="liquidation_amt">
					<liquidation_amt>
						<xsl:value-of select="liquidation_amt"/>
					</liquidation_amt>
				</xsl:if>
				
				<xsl:if test="liquidation_cur_code">
					<liquidation_cur_code>
						<xsl:value-of select="liquidation_cur_code"/>
					</liquidation_cur_code>
				</xsl:if>
				
				<xsl:if test="liquidation_date">
					<liquidation_date>
						<xsl:value-of select="liquidation_date"/>
					</liquidation_date>
				</xsl:if>
				
				<xsl:if test="liquidation_rate">
					<liquidation_rate>
						<xsl:value-of select="liquidation_rate"/>
					</liquidation_rate>
				</xsl:if>
				
				<xsl:if test="liquidation_profit_loss">
					<liquidation_profit_loss>
						<xsl:value-of select="liquidation_profit_loss"/>
					</liquidation_profit_loss>
				</xsl:if>
				<xsl:if test="near_rate">
					<near_rate>
						<xsl:value-of select="near_rate"/>
					</near_rate>
				</xsl:if>
				<xsl:if test="contract_type">
					<contract_type>
						<xsl:value-of select="contract_type"/>
					</contract_type>
				</xsl:if>
				<xsl:if test="trade_id">
					<trade_id>
						<xsl:value-of select="trade_id"/>
					</trade_id>
				</xsl:if>				
				<xsl:if test="value_date">
					<value_date>
						<xsl:value-of select="value_date"/>
					</value_date>
					<tnx_val_date>
						<xsl:value-of select="value_date"/>
					</tnx_val_date>
				</xsl:if>				
				<xsl:if test="input_value_number">
					<value_date_term_number>
						<xsl:value-of select="input_value_number"/>
					</value_date_term_number>
				</xsl:if>				
				<xsl:if test="input_value_code">
					<value_date_term_code>
						<xsl:value-of select="input_value_code"/>
					</value_date_term_code>
				</xsl:if>				
				<xsl:if test="option_date">
					<option_date>
						<xsl:value-of select="option_date"/>
					</option_date>
				</xsl:if>				
				<xsl:if test="input_option_number">
					<option_date_term_number>
						<xsl:value-of select="input_option_number"/>
					</option_date_term_number>
				</xsl:if>				
				<xsl:if test="input_option_code">
					<option_date_term_code>
						<xsl:value-of select="input_option_code"/>
					</option_date_term_code>
				</xsl:if>				
				<xsl:if test="near_date">
					<near_value_date>
						<xsl:value-of select="near_date"/>
					</near_value_date>
				</xsl:if>				
				<xsl:if test="input_near_number">
					<near_value_date_term_number>
						<xsl:value-of select="input_near_number"/>
					</near_value_date_term_number>
				</xsl:if>				
				<xsl:if test="input_near_code">
					<near_value_date_term_code>
						<xsl:value-of select="input_near_code"/>
					</near_value_date_term_code>
				</xsl:if>
				<!-- In takedown case remarks is fill by ajax with inputtakedown remarks -->
				<xsl:choose>
					<xsl:when test="sub_tnx_type_code[.='31'] or sub_tnx_type_code[.='50']">
						<xsl:if test="input_takedown_remarks">
							<remarks>
								<xsl:value-of select="input_takedown_remarks"/>
							</remarks>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="remarks">
							<remarks>
								<xsl:value-of select="remarks"/>
							</remarks>
						</xsl:if>
					</xsl:otherwise>						
				</xsl:choose>
				
				<xsl:if test="action_req_code">
					<action_req_code>
						<xsl:value-of select="action_req_code"/>
					</action_req_code>
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
				
				<!--Takedown values-->
				<xsl:if test="input_takedown_amt">
					<additional_field name="input_takedown_amt" type="string" scope="none" description="takedown amt">
						<xsl:value-of select="input_takedown_amt"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="input_takedown_value_date">
					<additional_field name="input_takedown_value_date" type="string" scope="none" description="takedown value date">
						<xsl:value-of select="input_takedown_value_date"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="input_takedown_value_code">
					<additional_field name="input_takedown_value_code" type="string" scope="none" description="takedown value date">
						<xsl:value-of select="input_takedown_value_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="input_takedown_value_number">
					<additional_field name="input_takedown_value_number" type="string" scope="none" description="takedown value date">
						<xsl:value-of select="input_takedown_value_number"/>
					</additional_field>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="takedown_value_date != ''">
						<additional_field name="takedown_value_date" type="date" scope="transaction" description="takedown value date">
							<xsl:value-of select="takedown_value_date" />
						</additional_field>
					</xsl:when>
					<xsl:otherwise>
						<additional_field name="takedown_value_date" type="date" scope="transaction" description="takedown value date">
							<xsl:value-of select="value_date"/>
						</additional_field>
					</xsl:otherwise>
				</xsl:choose>
								
				<xsl:if test="original_amt">
					<original_amt>
						<xsl:value-of select="original_amt"/>
					</original_amt>
				</xsl:if>

				<xsl:if test="original_counter_amt">
					<original_counter_amt>
						<xsl:value-of select="original_counter_amt"/>
					</original_counter_amt>
				</xsl:if>

				<xsl:if test="original_cur_code">
					<original_cur_code>
						<xsl:value-of select="original_cur_code"/>
					</original_cur_code>
				</xsl:if>
				
				<xsl:if test="original_counter_cur_code">
					<original_counter_cur_code>
						<xsl:value-of select="original_counter_cur_code"/>
					</original_counter_cur_code>
				</xsl:if>
				
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
				<xsl:if test="intermediary_bank_aba">
					<additional_field name="intermediary_bank_aba" type="string" scope="none" description="Intermediary Bank ABA/SWIFT ID/Telex">
						<xsl:value-of select="intermediary_bank_aba"/>
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
				<xsl:if test="ctrps">
					<ctrps>
						<xsl:value-of select="ctrps"/>
					</ctrps>
				</xsl:if>

				<!-- End of Standing Instructions Details -->
				
				<xsl:if test="parent_deal_id">
					<additional_field name="parent_deal_id" type="string" scope="none" description="Parent deal ID">
						<xsl:value-of select="parent_deal_id"/>
					</additional_field>
				</xsl:if>
				
				<xsl:choose> 
					<xsl:when test="action_req_code='81'">
						<RECEIPT_COMPLETED_INDICATOR>Y</RECEIPT_COMPLETED_INDICATOR>							
					</xsl:when>
					<xsl:when test="action_req_code='82'">
						<PAYMENT_COMPLETED_INDICATOR>Y</PAYMENT_COMPLETED_INDICATOR>
					</xsl:when>
					<xsl:when test="action_req_code[.='']">
						<PAYMENT_COMPLETED_INDICATOR>Y</PAYMENT_COMPLETED_INDICATOR>
						<RECEIPT_COMPLETED_INDICATOR>Y</RECEIPT_COMPLETED_INDICATOR>
					</xsl:when>
				</xsl:choose>
				
				<xsl:apply-templates select="additional_field"/>
				
				<additional_field name="createChild" type="string" scope="none" description="Flag to identify whether child to be created">
					<xsl:value-of select="$createChild"/>
				</additional_field>
				
				<additional_field name="updateChild" type="string" scope="none" description="Flag to identify whether needs to update child transaction">
				    <xsl:value-of select="$updateChild"/>
				</additional_field>
			</com.misys.portal.cash.product.fx.common.ForeignExchange>
			

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

			
			<com.misys.portal.product.common.Bank role_code="01">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="brch_code"/></brch_code>
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<abbv_name><xsl:value-of select="$main_bank_abbv_name"/></abbv_name>
				<xsl:if test="issuing_bank_name">
					<name>
						<xsl:value-of select="issuing_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="$main_bank_name and not(issuing_bank_name)">
					<name><xsl:value-of select="$main_bank_name"/></name>
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
<!-- 			Cross References -->
			<xsl:apply-templates select="cross_references/cross_reference" mode="opics_ssi_cross_ref">
				<xsl:with-param name="ref_id" select="$ref_id"/>
				<xsl:with-param name="tnx_id" select="$tnx_id"/>
				<xsl:with-param name="product_code">FX</xsl:with-param>
				<xsl:with-param name="action_req_code"><xsl:value-of select="action_req_code"/></xsl:with-param>
				<xsl:with-param name="child_tnx_id"><xsl:value-of select="$child_tnx_id"/></xsl:with-param>
			</xsl:apply-templates>
			</result>
	</xsl:template>
	
	<!-- Cross Reference  -->
	<xsl:template match="cross_reference" mode="opics_ssi_cross_ref">
		<xsl:param name="ref_id"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="product_code">FX</xsl:param>
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
