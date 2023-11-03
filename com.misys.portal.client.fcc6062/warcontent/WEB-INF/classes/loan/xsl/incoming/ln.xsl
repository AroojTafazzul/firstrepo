<?xml version="1.0"?>
<!--
  		Copyright (c) 2000-2008 Misys (http://www.misys.com)
  		All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				xmlns:loanIQ="xalan://com.misys.portal.loan.loaniq.LoanIQAdapter"
				exclude-result-prefixes="service loanIQ">

	<xsl:template match="loans">
		<result>
			<xsl:apply-templates select="ln_tnx_record"></xsl:apply-templates>
		</result>
	</xsl:template>
	
	<!-- Process the facility access Level change -->
	<xsl:template match="facility_access_details">	
		<xsl:variable name="manageFacilityAccess" select="service:managefacilityAccess(./facilityId, ./access_type)"/>	
	</xsl:template>
	
	<!-- Process the facility name change -->
	<xsl:template match="facility_change_details">	
		<xsl:variable name="facilityNameChange" select="service:manageLoanfacilityNameChange(./facility_id, ./facility_name)"/>	
	</xsl:template>
	
	<!-- Process the deal name change -->
	<xsl:template match="deal_change_details">	
		<xsl:variable name="dealNameChange" select="service:manageLoanDealNameChange(./deal_id, ./deal_name)"/>	
	</xsl:template>
	
	<xsl:template match="alias_change_details">	
		<xsl:variable name="aliasNameChange" select="service:manageLoanAliasChange(./old_alias, ./new_alias)"/>	
	</xsl:template>
	
	<!-- Process Loan-->
	<xsl:template match="ln_tnx_record">
	
		<!-- Retrieve references from DB -->
		<!-- Declare variable at top-level to make them visible from any templates -->
		<xsl:variable name="references" select="service:manageReferences(./product_code, ./ref_id, service:retrieveTnxIdFromBoRefId(./bo_ref_id,./bo_tnx_id,'LN',''), ./bo_ref_id, ./bo_tnx_id, ./cust_ref_id, ./company_id, ./company_name, ./borrower_reference, ./issuing_bank/abbv_name, '01')"/>
	
		<xsl:variable name="ref_id" select="$references/references/ref_id"/>
		<xsl:variable name="tnx_id" select="$references/references/tnx_id"/>
		<xsl:variable name="company_id" select="$references/references/company_id"/>
		<xsl:variable name="company_name" select="$references/references/company_name"/>
		<xsl:variable name="entity" select="$references/references/entity"/>
		<xsl:variable name="main_bank_abbv_name" select="$references/references/main_bank_abbv_name"/>
		<xsl:variable name="main_bank_name" select="$references/references/main_bank_name"/>
		<xsl:variable name="customer_bank_reference" select="$references/references/customer_bank_reference"/>
	
		<com.misys.portal.product.ln.common.LoanFile>
			<com.misys.portal.product.ln.common.Loan>
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code>
					<xsl:value-of select="$brch_code"/>
				</brch_code>
				<company_id>
					<xsl:value-of select="$company_id"/>
				</company_id>
				<company_name>
					<xsl:value-of select="$company_name"/>
				</company_name>
				<xsl:if test="$entity">
					<entity>
						<xsl:value-of select="$entity"/>
					</entity>
				</xsl:if>
				
				
				<!-- from Product -->
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
				
				<xsl:call-template name="manageProdStatCode">
					<xsl:with-param name="product" select="."/>
				</xsl:call-template>

				<!-- Change the product status to Close if the loan status comes as inactive from the back office -->
				<xsl:if test="ln_status and ln_status = 'Inactive'">
					<prod_stat_code>77</prod_stat_code>
				</xsl:if> 
<!-- 				<xsl:if test="product_code"> -->
<!-- 					<product_code> -->
<!-- 						<xsl:value-of select="product_code"/> -->
<!-- 					</product_code> -->
<!-- 				</xsl:if> -->
				<xsl:if test="appl_date">
					<appl_date>
						<xsl:value-of select="appl_date"/>
					</appl_date>
				</xsl:if>


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
				
				<!-- from TransactionProduct -->
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
				<xsl:if test="tnx_stat_code">
					<tnx_stat_code>
						<xsl:value-of select="tnx_stat_code"/>
					</tnx_stat_code>
				</xsl:if>
				<xsl:if test="tnx_amt">
					<tnx_amt>
						<xsl:value-of select="tnx_amt"/>
					</tnx_amt>
				</xsl:if>
				<xsl:if test="tnx_cur_code">
					<tnx_cur_code>
						<xsl:value-of select="tnx_cur_code"/>
					</tnx_cur_code>
				</xsl:if>
				
								
				<!-- from Loan -->
				<xsl:if test="bo_facility_id">
					<bo_facility_id>
						<xsl:value-of select="bo_facility_id"/>
					</bo_facility_id>
				</xsl:if>
				<xsl:if test="bo_facility_name">
					<bo_facility_name>
						<xsl:value-of select="bo_facility_name"/>
					</bo_facility_name>
				</xsl:if>
				<xsl:if test="bo_deal_id">
					<bo_deal_id>
						<xsl:value-of select="bo_deal_id"/>
					</bo_deal_id>
				</xsl:if>
				<xsl:if test="bo_deal_name">
					<bo_deal_name>
						<xsl:value-of select="bo_deal_name"/>
					</bo_deal_name>
				</xsl:if>
				<xsl:if test="bo_tnx_id">
					<bo_tnx_id>
						<xsl:value-of select="bo_tnx_id"/>
					</bo_tnx_id>
				</xsl:if>				
				<xsl:if test="fcn">
					<fcn>
						<xsl:value-of select="fcn"/>
					</fcn>
				</xsl:if>
				<xsl:if test="status">
					<status>
						<xsl:choose>
							<xsl:when test="status[.= 'ACTIVE']">A</xsl:when>
							<xsl:when test="status[.= 'INACTIVE']">I</xsl:when>
						</xsl:choose>
					</status>
				</xsl:if>	
				<xsl:if test="loan_type">
					<loan_type>
						<xsl:value-of select="loan_type"/>
					</loan_type>
				</xsl:if>	
				<xsl:if test="period_start_date">
					<period_start_date>
						<xsl:value-of select="period_start_date"/>
					</period_start_date>
				</xsl:if>
				<xsl:if test="period_end_date">
					<period_end_date>
						<xsl:value-of select="period_end_date"/>
					</period_end_date>
				</xsl:if>	
				<xsl:if test="prepayment_term">
					<prepayment_term>
						<xsl:value-of select="prepayment_term"/>
					</prepayment_term>
				</xsl:if>
				<xsl:if test="request_type_operation">
					<request_type_operation>
						<xsl:value-of select="request_type_operation"/>
					</request_type_operation>
				</xsl:if>
						
				<borrower_reference>
					<xsl:value-of select="$customer_bank_reference"/>
				</borrower_reference>
				<xsl:choose>
					<xsl:when test="borrower_abbv_name">
						<borrower_abbv_name>
							<xsl:value-of select="borrower_abbv_name"/>
						</borrower_abbv_name>
					</xsl:when>
					<xsl:otherwise>
						<borrower_abbv_name>
							<xsl:value-of select="$company_name"/>
						</borrower_abbv_name>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="borrower_name">
					<borrower_name>
						<xsl:value-of select="borrower_name"/>
					</borrower_name>
				</xsl:if>
				<xsl:if test="borrower_address_line_1">
					<borrower_address_line_1>
						<xsl:value-of select="borrower_address_line_1"/>
					</borrower_address_line_1>
				</xsl:if>
				<xsl:if test="borrower_address_line_2">
					<borrower_address_line_2>
						<xsl:value-of select="borrower_address_line_2"/>
					</borrower_address_line_2>
				</xsl:if>
				<xsl:if test="borrower_dom">
					<borrower_dom>
						<xsl:value-of select="borrower_dom"/>
					</borrower_dom>
				</xsl:if>
				<xsl:if test="borrower_country">
					<borrower_country>
						<xsl:value-of select="borrower_country"/>
					</borrower_country>
				</xsl:if>
				<xsl:if test="borrower_email">
					<borrower_email>
						<xsl:value-of select="borrower_email"/>
					</borrower_email>
				</xsl:if>
				<xsl:if test="interest_amt">
					<interest_amt>
						<xsl:value-of select="interest_amt"/>
					</interest_amt>
				</xsl:if>
				<xsl:if test="late_fee_amt">
					<late_fee_amt>
						<xsl:value-of select="late_fee_amt"/>
					</late_fee_amt>
				</xsl:if>
				<xsl:if test="fault_interest_amt">
					<fault_interest_amt>
						<xsl:value-of select="fault_interest_amt"/>
					</fault_interest_amt>
				</xsl:if>
				<xsl:if test="past_interest_amt">
					<past_interest_amt>
						<xsl:value-of select="past_interest_amt"/>
					</past_interest_amt>
				</xsl:if>				
				<xsl:if test="effective_date">
					<xsl:choose>
						<xsl:when test="prod_stat_code='08'">
							<amd_date>
								<xsl:value-of select="effective_date"/>
							</amd_date>
						</xsl:when>
						<xsl:when test="prod_stat_code='23'">
							<maturity_date>
								<xsl:value-of select="effective_date"/>
							</maturity_date>
						</xsl:when>
						<xsl:otherwise>
							<effective_date>
								<xsl:value-of select="effective_date"/>
							</effective_date>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:if test="lockout_date">
					<lockout_date>
						<xsl:value-of select="lockout_date"/>
					</lockout_date>
				</xsl:if>				
				<xsl:if test="ln_maturity_date">
					<ln_maturity_date>
						<xsl:value-of select="ln_maturity_date"/>
					</ln_maturity_date>
				</xsl:if>				
				<xsl:if test="maturity_date">
					<maturity_date>
						<xsl:value-of select="maturity_date"/>
					</maturity_date>
				</xsl:if>
				<xsl:if test="ln_cur_code">
					<ln_cur_code>
						<xsl:value-of select="ln_cur_code"/>
					</ln_cur_code>
				</xsl:if>
				<xsl:if test="ln_amt">
					<ln_amt>
						<xsl:value-of select="ln_amt"/>
					</ln_amt>
				</xsl:if>
				<xsl:if test="ln_liab_amt">
					<ln_liab_amt>
						<xsl:value-of select="ln_liab_amt"/>
					</ln_liab_amt>
				</xsl:if>	
				<xsl:if test="non_cash_amt">
					<non_cash_amt>
						<xsl:value-of select="non_cash_amt"/>
					</non_cash_amt>
				</xsl:if>	
				<xsl:if test="risk_type">
					<risk_type>
						<xsl:value-of select="risk_type"/>
					</risk_type>
				</xsl:if>
				<xsl:if test="pricing_option">
					<pricing_option>
						<xsl:value-of select="pricing_option"/>
					</pricing_option>
				</xsl:if>
				<xsl:if test="match_funding">
					<match_funding>
						<xsl:value-of select="match_funding"/>
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
				<xsl:if test="rate">
					<rate>
						<xsl:value-of select="rate"/>
					</rate>
				</xsl:if>
				<xsl:if test="repricing_date">
					<repricing_date>
						<xsl:value-of select="repricing_date"/>
					</repricing_date>
				</xsl:if>
				<xsl:if test="repricing_frequency">
					<repricing_frequency>
						<xsl:value-of select="repricing_frequency"/>
					</repricing_frequency>
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
				<xsl:if test="property_name">
					<property_name>
						<xsl:value-of select="property_name"/>
					</property_name>
				</xsl:if>
				<xsl:if test="note_date">
					<note_date>
						<xsl:value-of select="note_date"/>
					</note_date>
				</xsl:if>
				<xsl:if test="net_rate">
					<net_rate>
						<xsl:value-of select="net_rate"/>
					</net_rate>
				</xsl:if>
				<xsl:if test="tnx_val_date">
					<tnx_val_date>
						<xsl:value-of select="tnx_val_date"/>
					</tnx_val_date>
				</xsl:if>
				<xsl:if test="eoc_ddlpi">
					<eoc_ddlpi>
						<xsl:value-of select="eoc_ddlpi"/>
					</eoc_ddlpi>
				</xsl:if>
				<xsl:if test="eom_ddlpi">
					<eom_ddlpi>
						<xsl:value-of select="eom_ddlpi"/>
					</eom_ddlpi>
				</xsl:if>
				<xsl:if test="borrower_contact_number">
					<borrower_contact_number>
						<xsl:value-of select="borrower_contact_number"/>
					</borrower_contact_number>
				</xsl:if>
				<xsl:if test="additional_amt">
					<additional_amt>
						<xsl:value-of select="additional_amt"/>
					</additional_amt>
				</xsl:if>
				<xsl:if test="interest_days">
					<interest_days>
						<xsl:value-of select="interest_days"/>
					</interest_days>
				</xsl:if>
				<xsl:if test="factor">
					<factor>
						<xsl:value-of select="factor"/>
					</factor>
				</xsl:if>
				<xsl:if test="period_over">
					<period_over>
						<xsl:value-of select="period_over"/>
					</period_over>
				</xsl:if>
				<xsl:if test="period_left">
					<period_left>
						<xsl:value-of select="period_left"/>
					</period_left>
				</xsl:if>
				<xsl:if test="premium_amt">
					<premium_amt>
						<xsl:value-of select="premium_amt"/>
					</premium_amt>
				</xsl:if>
				<xsl:if test="min_premium_amt">
					<min_premium_amt>
						<xsl:value-of select="min_premium_amt"/>
					</min_premium_amt>
				</xsl:if>
				<xsl:if test="reporting_method">
					<reporting_method>
						<xsl:value-of select="reporting_method"/>
					</reporting_method>
				</xsl:if>
				<xsl:if test="is_auto_rollover_enabled">
					<is_auto_rollover_enabled>
						<xsl:value-of select="is_auto_rollover_enabled"/>
					</is_auto_rollover_enabled>
				</xsl:if>
				<ln_access_type>				
					<xsl:choose>
						<xsl:when test="ln_access_type and ln_access_type[.!=''] and ln_access_type[.!='NULL']"><xsl:value-of select="ln_access_type"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="loanIQ:getDefaultLNAccessType()"/></xsl:otherwise>
					</xsl:choose>
				</ln_access_type>
				
				<xsl:if test="fxRate">
					<fx_conversion_rate>
						<xsl:value-of select="fxRate"/>
					</fx_conversion_rate>
				</xsl:if>
				
				<xsl:if test="fac_cur_code">
					<fac_cur_code>
						<xsl:value-of select="fac_cur_code"/>
					</fac_cur_code>
				</xsl:if>
				
				<xsl:if test="period">
					<period>
						<xsl:value-of select="period"/>
					</period>
				</xsl:if>
				<xsl:if test="sublimit_name">
					<additional_field name="sublimit_name" type="string" scope="none">
						<xsl:value-of select="sublimit_name"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="isSwingline">
					<additional_field name="isSwingline" type="string" scope="none">
						<xsl:value-of select="isSwingline"/>
					</additional_field>
				</xsl:if>
				<!-- initial draw-down rrid tag for historical loan -->
				<xsl:if test="drawdown_rrid">
					<additional_field name="drawdown_rrid" type="string" scope="none">
						<xsl:value-of select="drawdown_rrid"/>
					</additional_field>
				</xsl:if>
				<!-- loan re-pricing rrid tag for historical loan -->
				<xsl:if test="loan_repricing_trans_rid">
					<additional_field name="loan_repricing_trans_rid" type="string" scope="none">
						<xsl:value-of select="loan_repricing_trans_rid"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="principal_payment/bo_deal_id">
					<bo_deal_id>
						<xsl:value-of select="principal_payment/bo_deal_id"/>
					</bo_deal_id>
				</xsl:if>
				<xsl:if test="principal_payment/bo_deal_name">
					<bo_deal_name>
						<xsl:value-of select="principal_payment/bo_deal_name"/>
					</bo_deal_name>
				</xsl:if>
				
				<xsl:if test="principal_payment/bo_facility_id">
					<bo_facility_id>
						<xsl:value-of select="principal_payment/bo_facility_id"/>
					</bo_facility_id>
				</xsl:if>
				
				<xsl:if test="principal_payment/bo_facility_name">
					<bo_facility_name>
						<xsl:value-of select="principal_payment/bo_facility_name"/>
					</bo_facility_name>
				</xsl:if>
				
				<xsl:if test="principal_payment/ln_maturity_date">
					<ln_maturity_date>
						<xsl:value-of select="principal_payment/ln_maturity_date"/>
					</ln_maturity_date>
				</xsl:if>
				
				<xsl:if test="principal_payment/pricing_option">
					<pricing_option>
						<xsl:value-of select="principal_payment/pricing_option"/>
					</pricing_option>
				</xsl:if>
				
				<xsl:if test="principal_payment/risk_type">
					<risk_type>
						<xsl:value-of select="principal_payment/risk_type"/>
					</risk_type>
				</xsl:if>
				<xsl:if test="principal_payment/ln_amt">
					<ln_amt>
						<xsl:value-of select="principal_payment/ln_amt"/>
					</ln_amt>
				</xsl:if>
				<xsl:if test="principal_payment/tnx_amt">
					<tnx_amt>
						<xsl:value-of select="principal_payment/tnx_amt"/>
					</tnx_amt>
				</xsl:if>
				<xsl:if test="principal_payment/tnx_cur_code">
					<tnx_cur_code>
						<xsl:value-of select="principal_payment/tnx_cur_code"/>
					</tnx_cur_code>
				</xsl:if>
				<xsl:if test="principal_payment/ln_liab_amt">
					<ln_liab_amt>
						<xsl:value-of select="principal_payment/ln_liab_amt"/>
					</ln_liab_amt>
				</xsl:if>
				<xsl:if test="principal_payment/ln_cur_code">
					<ln_cur_code>
						<xsl:value-of select="principal_payment/ln_cur_code"/>
					</ln_cur_code>
				</xsl:if>
				<xsl:if test="principal_payment/repricing_date">
					<repricing_date>
						<xsl:value-of select="principal_payment/repricing_date"/>
					</repricing_date>
				</xsl:if>
				<xsl:if test="principal_payment/repricing_frequency">
					<repricing_frequency>
						<xsl:value-of select="principal_payment/repricing_frequency"/>
					</repricing_frequency>
				</xsl:if>
				
				
				<xsl:if test="interest_payment/bo_deal_id">
					<bo_deal_id>
						<xsl:value-of select="interest_payment/bo_deal_id"/>
					</bo_deal_id>
				</xsl:if>
				<xsl:if test="interest_payment/bo_deal_name">
					<bo_deal_name>
						<xsl:value-of select="interest_payment/bo_deal_name"/>
					</bo_deal_name>
				</xsl:if>
				
				<xsl:if test="interest_payment/bo_facility_id">
					<bo_facility_id>
						<xsl:value-of select="interest_payment/bo_facility_id"/>
					</bo_facility_id>
				</xsl:if>
				
				<xsl:if test="interest_payment/bo_facility_name">
					<bo_facility_name>
						<xsl:value-of select="interest_payment/bo_facility_name"/>
					</bo_facility_name>
				</xsl:if>
				
				<xsl:if test="interest_payment/ln_amt">
					<ln_amt>
						<xsl:value-of select="principal_payment/ln_amt"/>
					</ln_amt>
				</xsl:if>
				<xsl:if test="interest_payment/ln_cur_code">
					<ln_cur_code>
						<xsl:value-of select="principal_payment/ln_cur_code"/>
					</ln_cur_code>
				</xsl:if>
				<xsl:if test="interest_payment/repricing_date">
					<repricing_date>
						<xsl:value-of select="interest_payment/repricing_date"/>
					</repricing_date>
				</xsl:if>
				<xsl:if test="interest_payment/repricing_frequency">
					<repricing_frequency>
						<xsl:value-of select="interest_payment/repricing_frequency"/>
					</repricing_frequency>
				</xsl:if>
				
				<xsl:if test="interest_payment/ln_amt">
					<additional_field name="interest_payment_amount" type="string" scope="master">
						<xsl:value-of select="interest_payment/ln_amt"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="interest_payment/ln_cur_code">
					<additional_field name="interest_amount_currency" type="string" scope="master">
						<xsl:value-of select="interest_payment/ln_cur_code"/>
					</additional_field>
				</xsl:if>
			</com.misys.portal.product.ln.common.Loan>


			<!--Payement terms-->
			<xsl:apply-templates select="payments/payment">
				<xsl:with-param name="companyId" select="company_id"/>
				<xsl:with-param name="refId" select="ref_id"/>
				<xsl:with-param name="tnxId" select="tnx_id"/>
			</xsl:apply-templates>
			
			<!-- Banks -->
			<com.misys.portal.product.common.Bank role_code="01">
				<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				<brch_code><xsl:value-of select="brch_code"/></brch_code>
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
			
			<!-- Narratives -->
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="bo_comment"/>
				<xsl:with-param name="type_code">11</xsl:with-param>
				<xsl:with-param name="ref_id" select="ref_id"/>
				<xsl:with-param name="tnx_id" select="tnx_id"/>
				<xsl:with-param name="company_id" select="company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="free_format_text"/>
				<xsl:with-param name="type_code">12</xsl:with-param>
				<xsl:with-param name="ref_id" select="ref_id"/>
				<xsl:with-param name="tnx_id" select="tnx_id"/>
				<xsl:with-param name="company_id" select="company_id"/>
			</xsl:call-template>
			<xsl:call-template name="narrative">
				<xsl:with-param name="narrative" select="amd_details"/>
				<xsl:with-param name="type_code">13</xsl:with-param>
				<xsl:with-param name="ref_id" select="ref_id"/>
				<xsl:with-param name="tnx_id" select="tnx_id"/>
				<xsl:with-param name="company_id" select="company_id"/>
			</xsl:call-template>
			
			<!-- Create Charges elements -->
			<xsl:apply-templates select="charges/charge">
				<xsl:with-param name="ref_id" select="ref_id"/>
				<xsl:with-param name="tnx_id" select="tnx_id"/>
				<xsl:with-param name="company_id" select="company_id"/>
			</xsl:apply-templates>
			
			<!-- Create Attachment elements -->
			<xsl:apply-templates select="attachments/attachment">
				<xsl:with-param name="tnx_stat_code" select="tnx_stat_code"/>
				<xsl:with-param name="ref_id" select="ref_id"/>
				<xsl:with-param name="tnx_id" select="tnx_id"/>
				<xsl:with-param name="company_id" select="company_id"/>
			</xsl:apply-templates>
			
			<!-- Cross References -->
			<xsl:apply-templates select="cross_references/cross_reference"/>
			
			<xsl:for-each select = "oldLoans/oldLoan">
				<xsl:variable name="crossreference" select="service:manageReferences(//product_code,'' ,'' , bo_ref_id, bo_tnx_id,'' , $company_id, $company_name, /../borrower_reference, $main_bank_abbv_name, '01')"/>
				<xsl:variable name="child_ref_id" select="$crossreference/references/ref_id"/>
				<xsl:variable name="child_tnx_id" select="$crossreference/references/tnx_id"/>
				<com.misys.portal.product.common.CrossReference>
					<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
					<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
					<product_code>LN</product_code>
					<child_product_code>LN</child_product_code>
					<type_code>09</type_code>
					<child_ref_id><xsl:value-of select="$child_ref_id"/></child_ref_id>
					<child_tnx_id><xsl:value-of select="$child_tnx_id"/></child_tnx_id>
					<xsl:if test="ln_liab_amt">
						<additional_field name="ln_liab_amt" type="decimal" scope="none">
							<xsl:value-of select="ln_liab_amt"/>
						</additional_field>
					 </xsl:if>
					 <xsl:if test="ln_amt">
						<additional_field name="ln_amt" type="decimal" scope="none">
							<xsl:value-of select="ln_amt"/>
						</additional_field>
					 </xsl:if>
					<xsl:if test="tnx_cur_code">
						<additional_field name="tnx_cur_code" type="string" scope="none">
							<xsl:value-of select="tnx_cur_code"/>
						</additional_field>
					</xsl:if>
					<xsl:if test="tnx_amt">
						<additional_field name="tnx_amt" type="decimal" scope="none">
							<xsl:value-of select="tnx_amt"/>
						</additional_field>
					</xsl:if>
					<xsl:if test="prod_stat_code">
						<additional_field name="prod_stat_code" type="string" scope="none">
							<xsl:value-of select="prod_stat_code"/>
						</additional_field>
					</xsl:if>
					<!-- Change the product status to Close if the loan status comes as inactive from the back office -->
					<xsl:if test="ln_status and ln_status = 'Inactive'">
						<additional_field name="prod_stat_code" type="string" scope="none">77</additional_field>
					</xsl:if> 
					<xsl:if test="repricing_date">
						<additional_field name="repricing_date" type="date" scope="none">
							<xsl:value-of select="repricing_date"/>
						</additional_field>
					</xsl:if>
					<xsl:if test="bo_tnx_id">
						<additional_field name="bo_tnx_id" type="string" scope="none">
							<xsl:value-of select="bo_tnx_id"/>
						</additional_field>
					</xsl:if>
				</com.misys.portal.product.common.CrossReference>
			</xsl:for-each>
			
		</com.misys.portal.product.ln.common.LoanFile>
	</xsl:template>
</xsl:stylesheet>
