<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="utils">

	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>
	
	<!-- Common elements to save among all products -->
	<xsl:include href="../../../core/xsl/products/save_common.xsl"/>
	
    <!-- TODO: Avengers work on this -->
	<!-- payment term -->
	<xsl:include href="../../../openaccount/xsl/products/po_save_common.xsl"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Process Loan -->
	<xsl:template match="ln_tnx_record">
		<result>
			<com.misys.portal.product.ln.common.Loan>
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id" /></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id" /></xsl:attribute>

				<!-- from Product -->
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
				<xsl:if test="company_name">
					<company_name>
						<xsl:value-of select="company_name"/>
					</company_name>
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
				<xsl:if test="note_rate">
					<note_rate>
						<xsl:value-of select="note_rate"/>
					</note_rate> 
				</xsl:if>
				<xsl:if test="appl_date">
					<appl_date>
						<xsl:value-of select="appl_date"/>
					</appl_date>
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
						<xsl:value-of select="status"/>
					</status>
				</xsl:if>
				<xsl:if test="borrower_reference">
					<borrower_reference>
						<xsl:value-of select="utils:decryptApplicantReference(borrower_reference)"/>
					</borrower_reference>
				</xsl:if>				
				<xsl:if test="borrower_abbv_name">
					<borrower_abbv_name>
						<xsl:value-of select="borrower_abbv_name"/>
					</borrower_abbv_name>
				</xsl:if>
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
				<xsl:if test="borrower_contact_number">
					<borrower_contact_number>
						<xsl:value-of select="borrower_contact_number"/>
					</borrower_contact_number>
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
				<xsl:if test="effective_date">
					<effective_date>
						<xsl:value-of select="effective_date"/>
					</effective_date>
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
				<xsl:if test="loan_type">
					<loan_type>
						<xsl:value-of select="loan_type"/>
					</loan_type>
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
				<xsl:if test="request_type_operation">
					<request_type_operation>
						<xsl:value-of select="request_type_operation"/>
					</request_type_operation>
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
				<xsl:if test="additional_amt">
					<additional_amt>
						<xsl:value-of select="additional_amt"/>
					</additional_amt>
				</xsl:if>
				<xsl:if test="min_prepayment_premium_pct">
					<min_prepayment_premium_pct>
						<xsl:value-of select="min_prepayment_premium_pct"/>
					</min_prepayment_premium_pct>
				</xsl:if>
				<xsl:if test="interest_days">
					<interest_days>
						<xsl:value-of select="interest_days"/>
					</interest_days>
				</xsl:if>
				<xsl:if test="prepayment_term">
					<prepayment_term>
						<xsl:value-of select="prepayment_term"/>
					</prepayment_term>
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
				<xsl:if test="premium_amt">
					<premium_amt>
						<xsl:value-of select="premium_amt"/>
					</premium_amt>
				</xsl:if>
				<xsl:if test="premium_percent">
					<premium_percent>
						<xsl:value-of select="premium_percent"/>
					</premium_percent>
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
				<xsl:if test="period">
					<period>
						<xsl:value-of select="period"/>
					</period>
				</xsl:if>
				
				<xsl:if test="fx_conversion_rate">
					<fx_conversion_rate>
						<xsl:value-of select="fx_conversion_rate"/>
					</fx_conversion_rate>
				</xsl:if>
				<xsl:if test="borrower_limit_cur_code">
					<fac_cur_code>
						<xsl:value-of select="borrower_limit_cur_code"/>
					</fac_cur_code>
				</xsl:if>
				
				<!--Payement terms-->
				<xsl:apply-templates select="payments/payment">
					<xsl:with-param name="brchCode" select="brch_code"/>
					<xsl:with-param name="companyId" select="company_id"/>
					<xsl:with-param name="refId" select="ref_id"/>
					<xsl:with-param name="tnxId" select="tnx_id"/>
					<xsl:with-param name="payment_terms_type" select="payment_terms_type"/>
				</xsl:apply-templates>
				
				<xsl:if test="accept_legal_text">
					<additional_field name="isLegalTextAccepted" type="string" scope="master" description="Accept Legal Text">
						<xsl:value-of select="accept_legal_text"/>
					</additional_field>
				 </xsl:if>
				 
				 <xsl:if test="sublimit_name">
					<additional_field name="sublimit_name" type="string" scope="master" description="Sublimit Name">
						<xsl:value-of select="sublimit_name"/>
					</additional_field>
				 </xsl:if>
				 
				  <xsl:if test="isSwingline">
					<additional_field name="isSwingline" type="string" scope="master" description="Swingline Flag">
						<xsl:value-of select="isSwingline"/>
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
				   
				<xsl:if test="loan_request_type">
					<additional_field name="loan_request_type" type="string" scope="master" description="Loan Request Type">
						<xsl:value-of select="loan_request_type"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="facility_type">
					<additional_field name="facility_type" type="string" scope="master" description="Facility Type">
						<xsl:value-of select="facility_type"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="interest_payment_selected">
					<additional_field name="interest_payment_selected" type="string" scope="master" description="Interest Payment Selected">
						<xsl:value-of select="interest_payment_selected"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="total_interest_due">
					<additional_field name="total_interest_due" type="string" scope="master" description="Total Interest Due">
						<xsl:value-of select="total_interest_due"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="interest_payment_amount">
					<additional_field name="interest_payment_amount" type="string" scope="master" description="Interest Payment Amount">
						<xsl:value-of select="interest_payment_amount"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="interest_payment_type">
					<additional_field name="interest_payment_type" type="string" scope="master" description="Payment Type">
						<xsl:value-of select="interest_payment_type"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="interest_payment_date">
					<additional_field name="interest_payment_date" type="string" scope="master" description="Interest Due Date">
						<xsl:value-of select="interest_payment_date"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="interest_amount_currency">
					<additional_field name="interest_amount_currency" type="string" scope="master" description="interest Amount Currency">
						<xsl:value-of select="interest_amount_currency"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="swinglineAllowed">
					<additional_field name="swinglineAllowed" type="string" scope="master" description="Swingline Flag">
						<xsl:value-of select="swinglineAllowed"/>
					</additional_field>
				</xsl:if>
				
				<xsl:if test="drawdownAllowed">
					<additional_field name="drawdownAllowed" type="string" scope="master" description="Drawdown Flag">
						<xsl:value-of select="drawdownAllowed"/>
					</additional_field>
				</xsl:if>
				
				<!-- Previous ctl date, used for synchronisation issues -->
				<xsl:if test="old_ctl_dttm">
					<additional_field name="old_ctl_dttm" type="time" scope="none" description="Previous control date used for synchronisation issues">
						<xsl:value-of select="old_ctl_dttm"/>
					</additional_field>
				</xsl:if>
					
					
				<!-- Security -->
				<xsl:if test="token">
					<additional_field name="token" type="string" scope="none" description="Security token">
						<xsl:value-of select="token"/>
					</additional_field>
				</xsl:if>
				
							
				<!-- Re authentication -->
				<xsl:call-template name="AUTHENTICATION"/>
				<!-- collaboration -->
				<xsl:call-template name="collaboration" />
				
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.product.ln.common.Loan>
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
			<com.misys.portal.product.common.Narrative>
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
				<xsl:if test="ref_id">
					<ref_id>
						<xsl:value-of select="ref_id"/>
					</ref_id>
				</xsl:if>
				<xsl:if test="tnx_id">
					<tnx_id>
						<xsl:value-of select="tnx_id"/>
					</tnx_id>
				</xsl:if>
				<type_code>11</type_code>
				<xsl:if test="bo_comment">
					<text>
						<xsl:value-of select="bo_comment"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative>
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
				<xsl:if test="ref_id">
					<ref_id>
						<xsl:value-of select="ref_id"/>
					</ref_id>
				</xsl:if>
				<xsl:if test="tnx_id">
					<tnx_id>
						<xsl:value-of select="tnx_id"/>
					</tnx_id>
				</xsl:if>
				<type_code>12</type_code>
				<xsl:if test="free_format_text">
					<text>
						<xsl:value-of select="free_format_text"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<com.misys.portal.product.common.Narrative>
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
				<xsl:if test="ref_id">
					<ref_id>
						<xsl:value-of select="ref_id"/>
					</ref_id>
				</xsl:if>
				<xsl:if test="tnx_id">
					<tnx_id>
						<xsl:value-of select="tnx_id"/>
					</tnx_id>
				</xsl:if>
				<type_code>13</type_code>
				<xsl:if test="amd_details">
					<text>
						<xsl:value-of select="amd_details"/>
					</text>
				</xsl:if>
			</com.misys.portal.product.common.Narrative>
			<!-- Linked loans for repricing -->
			<xsl:for-each select="linked_loans/loan_ref_id">
				<com.misys.portal.product.common.CrossReference>
					<ref_id><xsl:value-of select="../../ref_id"/></ref_id>
					<tnx_id><xsl:value-of select="../../tnx_id"/></tnx_id>
					<product_code>LN</product_code>
					<child_ref_id><xsl:value-of select="."/></child_ref_id>
					<child_product_code>LN</child_product_code>
					<type_code>09</type_code>
				</com.misys.portal.product.common.CrossReference>
			</xsl:for-each>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
