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
	<xsl:template match="sp_tnx_record">
		<result>
			<com.misys.portal.cash.product.sp.common.Sweep>
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
				
				<xsl:if test="sweeping_type">
					<sweeping_type>
						<xsl:value-of select="sweeping_type"/>
					</sweeping_type>
				</xsl:if>
				<xsl:if test="sweeping_status">
					<sweeping_status>
						<xsl:value-of select="sweeping_status"/>
					</sweeping_status>
				</xsl:if>
				<xsl:if test="sweeping_description">
					<sweeping_description>
						<xsl:value-of select="sweeping_description"/>
					</sweeping_description>
				</xsl:if>
				<xsl:if test="concentration_account_no">
					<concentration_account_no>
						<xsl:value-of select="concentration_account_no"/>
					</concentration_account_no>
				</xsl:if>
				<xsl:if test="concentration_account_cur_code">
					<concentration_account_cur_code>
						<xsl:value-of select="concentration_account_cur_code"/>
					</concentration_account_cur_code>
				</xsl:if>
				<xsl:if test="frequency">
					<frequency>
						<xsl:value-of select="frequency"/>
					</frequency>
				</xsl:if>
				<xsl:if test="start_date">
					<start_date>
						<xsl:value-of select="start_date"/>
					</start_date>
				</xsl:if>
				<xsl:if test="end_date">
					<end_date>
						<xsl:value-of select="end_date"/>
					</end_date>
				</xsl:if>
				<xsl:if test="sweep_method">
					<sweep_method>
						<xsl:value-of select="sweep_method"/>
					</sweep_method>
				</xsl:if>
				
				<xsl:if test="min_balance_cur_code">
					<floor_amt_cur_code>
						<xsl:value-of select="min_balance_cur_code"/>
					</floor_amt_cur_code>
				</xsl:if>
				<xsl:if test="min_balance_amt">
					<floor_amt>
						<xsl:value-of select="min_balance_amt"/>
					</floor_amt>
				</xsl:if>
				<xsl:if test="max_balance_amt">
					<ceiling_amt>
						<xsl:value-of select="max_balance_amt"/>
					</ceiling_amt>
				</xsl:if>
				<xsl:if test="max_balance_cur_code">
					<ceiling_amt_cur_code>
						<xsl:value-of select="max_balance_cur_code"/>
					</ceiling_amt_cur_code>
				</xsl:if>
				
				<xsl:if test="sweeping_method_deficit[.='Y'] and sweeping_method_surplus[.='Y']">
					<sweep_method>DEFICIT_AND_SURPLUS</sweep_method>
				</xsl:if>
				<xsl:if test="sweeping_method_deficit[.='N'] and sweeping_method_surplus[.='Y']">
					<sweep_method>SURPLUS</sweep_method>
				</xsl:if>
				<xsl:if test="sweeping_method_deficit[.='Y'] and sweeping_method_surplus[.='N']">
					<sweep_method>DEFICIT</sweep_method>
				</xsl:if>
				
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.cash.product.sp.common.Sweep>
			
			<!-- Retrieve funding sweep accounts -->
			<xsl:for-each select="//*[starts-with(name(), 'funding_account_no_')]">
				<xsl:call-template name="sweepAccount">
					<xsl:with-param name="id"><xsl:value-of select="substring-after(name(), 'funding_account_no_')"/></xsl:with-param>
					<xsl:with-param name="type">FUNDING_ACCT</xsl:with-param>
					<xsl:with-param name="prefix">funding</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!-- Retrieve receiving sweep accounts -->
			<xsl:for-each select="//*[starts-with(name(), 'receiving_account_no_')]">
				<xsl:call-template name="sweepAccount">
					<xsl:with-param name="id"><xsl:value-of select="substring-after(name(), 'receiving_account_no_')"/></xsl:with-param>
					<xsl:with-param name="type">RECEIVING_ACCT</xsl:with-param>
					<xsl:with-param name="prefix">receiving</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
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
					<xsl:with-param name="brchCode"><xsl:value-of select="//sp_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//sp_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//sp_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//sp_tnx_record/tnx_id"/></xsl:with-param>
					<xsl:with-param name="position"><xsl:value-of select="substring-after(name(), 'charge_details_chrg_details_')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			
			<!-- Second, the charges inputted earlier -->
			<xsl:for-each select="//*[starts-with(name(), 'old_charge_details_position_')]">
				<xsl:call-template name="OLD_CHARGE">
					<xsl:with-param name="brchCode"><xsl:value-of select="//sp_tnx_record/brch_code"/></xsl:with-param>
					<xsl:with-param name="companyId"><xsl:value-of select="//sp_tnx_record/company_id"/></xsl:with-param>
					<xsl:with-param name="refId"><xsl:value-of select="//sp_tnx_record/ref_id"/></xsl:with-param>
					<xsl:with-param name="tnxId"><xsl:value-of select="//sp_tnx_record/tnx_id"/></xsl:with-param>
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
	
	<xsl:template name="sweepAccount">
		<xsl:param name="id"/>
		<xsl:param name="type"/>
		<xsl:param name="prefix"/>
		<com.misys.portal.cash.product.sp.common.SweepAccount>
			<type><xsl:value-of select="$type"/></type>
			<xsl:if test="//*[starts-with(name(), concat($prefix, concat('_account_no_', $id)))]">
				<account_no>
					<xsl:value-of select="//*[starts-with(name(), concat($prefix, concat('_account_no_', $id)))]"/>
				</account_no>
			</xsl:if>
			<xsl:if test="//*[starts-with(name(), concat($prefix, concat('_min_transfer_amt_', $id)))]">
				<min_transfer_amount>
					<xsl:value-of select="//*[starts-with(name(), concat($prefix, concat('_min_transfer_amt_', $id)))]"/>
				</min_transfer_amount>
			</xsl:if>
			<xsl:if test="//*[starts-with(name(), concat($prefix, concat('_min_transfer_cur_code_', $id)))]">
				<min_transfer_cur_code>
					<xsl:value-of select="//*[starts-with(name(), concat($prefix, concat('_min_transfer_cur_code_', $id)))]"/>
				</min_transfer_cur_code>
			</xsl:if>
			<xsl:if test="//*[starts-with(name(), concat($prefix, concat('_keep_balance_amt_', $id)))]">
				<keep_balance_amount>
					<xsl:value-of select="//*[starts-with(name(), concat($prefix, concat('_keep_balance_amt_', $id)))]"/>
				</keep_balance_amount>
			</xsl:if>
			<xsl:if test="//*[starts-with(name(), concat($prefix, concat('_keep_balance_cur_code_', $id)))]">
				<keep_balance_cur_code>
					<xsl:value-of select="//*[starts-with(name(), concat($prefix, concat('_keep_balance_cur_code_', $id)))]"/>
				</keep_balance_cur_code>
			</xsl:if>
		</com.misys.portal.cash.product.sp.common.SweepAccount>
	</xsl:template>
	
	

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
