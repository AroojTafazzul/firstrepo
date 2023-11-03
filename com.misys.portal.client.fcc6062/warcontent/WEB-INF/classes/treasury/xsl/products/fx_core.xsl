<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="utils">
	<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>
	
	<!-- Common elements to save among all products -->
	<xsl:include href="../../../core/xsl/products/save_common.xsl"/>
	
	<!-- Common templates used among cash products -->
	<xsl:include href="../../../cash/xsl/cash_save_common.xsl"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process Foreign Exchange -->
	<xsl:template match="fx_tnx_record">
		<result>
			<com.misys.portal.cash.product.fx.common.ForeignExchange>
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
				
				<xsl:if test="original_amt">
					<original_amt>
						<xsl:value-of select="original_amt"/>
					</original_amt>
				</xsl:if>
				
				<xsl:if test="fx_type">
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
						<xsl:value-of select="utils:decryptApplicantReference(applicant_reference)"/>
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
				
				<xsl:if test="rate">
					<rate>
						<xsl:value-of select="rate"/>
					</rate>
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
				<xsl:if test="sub_product_code">
					<sub_product_code>
						<xsl:value-of select="sub_product_code"/>
					</sub_product_code>
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
				<!--This should be removed and input_value_code should be used-->
				<xsl:if test="input_value_period">
					<additional_field name="input_value_period" type="string" scope="none" description="Opics Date Value Code.">
						<xsl:value-of select="input_value_period"/>
					</additional_field>
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
				<xsl:if test="parent_deal_id">
					<additional_field name="parent_deal_id" type="string" scope="none" description="parent_deal_id">
						<xsl:value-of select="parent_deal_id"/>
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
								
				<xsl:if test="payment_instructions_id">
					<payment_instructions_id>
						<xsl:value-of select="payment_instructions_id"/>
					</payment_instructions_id>
				</xsl:if>
				<xsl:if test="//fx_tnx_record/customer_payment/instruction_indicator">
					<payment_instructions_usual_id>
						<xsl:value-of select="//fx_tnx_record/customer_payment/instruction_indicator"/>
					</payment_instructions_usual_id>
				</xsl:if>
				<xsl:if test="receipt_instructions_id">
					<receipt_instructions_id>
						<xsl:value-of select="receipt_instructions_id"/>
					</receipt_instructions_id>
				</xsl:if>
				<xsl:if test="//fx_tnx_record/bank_payment/instruction_indicator">
					<receipt_instructions_usual_id>
						<xsl:value-of select="//fx_tnx_record/bank_payment/instruction_indicator"/>
					</receipt_instructions_usual_id>
				</xsl:if>
				<xsl:if test="instructions_type">
					<instructions_type>
						<xsl:value-of select="instructions_type"/>
					</instructions_type>
				</xsl:if>
				<xsl:if test="near_instructions_type">
					<additional_field name="instructions_type" type="string" scope="transaction" description="indicator on the type of instruction : 01 Bank Instruction, 02 Free Format instruction">
						<xsl:value-of select="near_instructions_type"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="ctrps">
					<ctrps>
						<xsl:value-of select="ctrps"/>
					</ctrps>
				</xsl:if>
				<hasDDA>
					<xsl:choose>
						<xsl:when test="cust_payment_account_act_name[.!='']">Y</xsl:when>
						<xsl:otherwise>N</xsl:otherwise>
					</xsl:choose>
				</hasDDA>
				<xsl:if test="receipt_completed_indicator">
					<RECEIPT_COMPLETED_INDICATOR>
						<xsl:value-of select="receipt_completed_indicator"/>
					</RECEIPT_COMPLETED_INDICATOR>							
				</xsl:if>
				<xsl:if test="payment_completed_indicator">
					<PAYMENT_COMPLETED_INDICATOR>
						<xsl:value-of select="payment_completed_indicator"/>
					</PAYMENT_COMPLETED_INDICATOR>
				</xsl:if>
				
				<!-- End of Standing Instructions Details -->
				
				<!-- Re authentication -->
				<xsl:call-template name="AUTHENTICATION"/>				
			
		     	<!-- Custom additional fields -->
		     	<xsl:call-template name="product-additional-fields"/>
		     	
     		</com.misys.portal.cash.product.fx.common.ForeignExchange>     		
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
			
				<xsl:if test="fx_type[.='SWAP']">
					<!-- NEAR instructions -->
					<com.misys.portal.product.common.Counterparty counterparty_type="OPICS_NEAR_CUSTOMER_PAYMENT">
						<xsl:if test="near_payment_instructions_id[.!='']">
							<xsl:call-template name="near-customer-payment"/>
						</xsl:if>
					</com.misys.portal.product.common.Counterparty>
					
					<com.misys.portal.product.common.Counterparty counterparty_type="OPICS_NEAR_BANK_PAYMENT">
						<xsl:choose>
							<xsl:when test="near_receipt_instructions_id[.!='']">
								<xsl:call-template name="near-bank-payment"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="free-format">
									<xsl:with-param name="prefix">near</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>						
					</com.misys.portal.product.common.Counterparty>
		
					<!-- FAR instructions -->
					<!-- 	<com.misys.portal.product.common.Counterparty counterparty_type="OPICS_FAR_CUSTOMER_PAYMENT">
						<xsl:if test="far_payment_instructions_id[.!='']">
							<xsl:call-template name="far-customer-payment"/>
						</xsl:if>
					</com.misys.portal.product.common.Counterparty>
					
					<com.misys.portal.product.common.Counterparty counterparty_type="OPICS_FAR_BANK_PAYMENT">
						<xsl:choose>
							<xsl:when test="far_receipt_instructions_id[.!='']">
								<xsl:call-template name="far-bank-payment"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="free-format">
									<xsl:with-param name="prefix">far</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>						
					</com.misys.portal.product.common.Counterparty> -->
				</xsl:if>
				
				<!-- Standard instructions -->
				<com.misys.portal.product.common.Counterparty counterparty_type="03">
					<xsl:choose>
				 		<xsl:when test="fx_mode = 'UNSIGNED'">
							<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
							<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
							<xsl:attribute name="counterparty_id"><xsl:value-of select="customer_counterparty_id"/></xsl:attribute>
				 		</xsl:when>
						<xsl:when test="payment_instructions_id[.!=''] ">
							<xsl:call-template name="customer-payment"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="cust_payment_account_act_name[.!=''] or cust_payment_cur_code[.!='']">
								<xsl:call-template name="dda-customer-payment"/>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</com.misys.portal.product.common.Counterparty>
			
				<com.misys.portal.product.common.Counterparty counterparty_type="04">
					<xsl:choose>
				 		<xsl:when test="fx_mode = 'UNSIGNED'">
							<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
							<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
							<xsl:attribute name="counterparty_id"><xsl:value-of select="bank_counterparty_id"/></xsl:attribute>
				 		</xsl:when>
						<xsl:when test="receipt_instructions_id[.!='']">
							<xsl:call-template name="bank-payment"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="free-format"/>
						</xsl:otherwise>
					</xsl:choose>						
				</com.misys.portal.product.common.Counterparty>
			
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
