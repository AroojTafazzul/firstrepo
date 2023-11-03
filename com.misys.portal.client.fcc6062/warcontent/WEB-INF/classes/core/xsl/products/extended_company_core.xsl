<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
<!--
   Copyright (c) 2000-2010 Misys (http://www.misys.com),
   All Rights Reserved. 
-->

	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="company">
		<result>
			<com.misys.portal.security.GTPExtendedCompanyTnx>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="abbv_name">
					<abbv_name>
						<xsl:value-of select="abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="actv_flag">
					<actv_flag>
						<xsl:value-of select="actv_flag"/>
					</actv_flag>
				</xsl:if>
				<xsl:if test="address_line_1">
					<address_line_1>
						<xsl:value-of select="address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="address_line_2">
					<address_line_2>
						<xsl:value-of select="address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="attachment_max_upload_size">
					<attachment_max_upload_size>
						<xsl:value-of select="attachment_max_upload_size"/>
					</attachment_max_upload_size>
				</xsl:if>
				<xsl:if test="authorize_own_transaction">
					<authorize_own_transaction>
						<xsl:value-of select="authorize_own_transaction"/>
					</authorize_own_transaction>
				</xsl:if>
				<xsl:if test="auto_fwd_date">
					<auto_fwd_date>
						<xsl:value-of select="auto_fwd_date"/>
					</auto_fwd_date>
				</xsl:if>
				<xsl:if test="base_cur_code">
					<base_cur_code>
						<xsl:value-of select="base_cur_code"/>
					</base_cur_code>
				</xsl:if>
				<xsl:if test="bei">
					<bei>
						<xsl:value-of select="bei"/>
					</bei>
				</xsl:if>
				<xsl:if test="bulk_authorize_limit">
					<bulk_authorize_limit>
						<xsl:value-of select="bulk_authorize_limit"/>
					</bulk_authorize_limit>
				</xsl:if>
				<xsl:if test="bulk_draft_on_error">
					<bulk_draft_on_error>
						<xsl:value-of select="bulk_draft_on_error"/>
					</bulk_draft_on_error>
				</xsl:if>
				<xsl:if test="charge_account">
					<charge_account>
						<xsl:value-of select="charge_account"/>
					</charge_account>
				</xsl:if>
				<xsl:if test="charge_account_address_line_1">
					<charge_account_address_line_1>
						<xsl:value-of select="charge_account_address_line_1"/>
					</charge_account_address_line_1>
				</xsl:if>
				<xsl:if test="charge_account_address_line_2">
					<charge_account_address_line_2>
						<xsl:value-of select="charge_account_address_line_2"/>
					</charge_account_address_line_2>
				</xsl:if>
				<xsl:if test="charge_account_address_line_3">
					<charge_account_address_line_3>
						<xsl:value-of select="charge_account_address_line_3"/>
					</charge_account_address_line_3>
				</xsl:if>
				<xsl:if test="charge_account_address_line_4">
					<charge_account_address_line_4>
						<xsl:value-of select="charge_account_address_line_4"/>
					</charge_account_address_line_4>
				</xsl:if>
				<xsl:if test="check_duplicate_cust_ref">
					<check_duplicate_cust_ref>
						<xsl:value-of select="check_duplicate_cust_ref"/>
					</check_duplicate_cust_ref>
				</xsl:if>
				<xsl:if test="check_duplicate_file">
					<check_duplicate_file>
						<xsl:value-of select="check_duplicate_file"/>
					</check_duplicate_file>
				</xsl:if>
				<xsl:if test="check_file_hash_value">
					<check_file_hash_value>
						<xsl:value-of select="check_file_hash_value"/>
					</check_file_hash_value>
				</xsl:if>
				<xsl:if test="company_group">
					<company_group>
						<xsl:value-of select="company_group"/>
					</company_group>
				</xsl:if>
				<xsl:if test="contact_name">
					<contact_name>
						<xsl:value-of select="contact_name"/>
					</contact_name>
				</xsl:if>
				<xsl:if test="country">
					<country>
						<xsl:value-of select="country"/>
					</country>
				</xsl:if>
				<xsl:if test="country_legalid">
					<country_legalid>
						<xsl:value-of select="country_legalid"/>
					</country_legalid>
				</xsl:if>
				<xsl:if test="country_name">
					<country_name>
						<xsl:value-of select="country_name"/>
					</country_name>
				</xsl:if>
				<xsl:if test="country_sub_div">
					<country_sub_div>
						<xsl:value-of select="country_sub_div"/>
					</country_sub_div>
				</xsl:if>
				<xsl:if test="county">
					<county>
						<xsl:value-of select="county"/>
					</county>
				</xsl:if>
				<xsl:if test="crm_email">
					<crm_email>
						<xsl:value-of select="crm_email"/>
					</crm_email>
				</xsl:if>
				<xsl:if test="dom">
					<dom>
						<xsl:value-of select="dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="dual_control">
					<dual_control>
						<xsl:value-of select="dual_control"/>
					</dual_control>
				</xsl:if>
				<xsl:if test="dashboard_screen_type">
					<dashboard_screen_type>
						<xsl:value-of select="dashboard_screen_type"/>
					</dashboard_screen_type>
				</xsl:if>
				<xsl:if test="email">
					<email>
						<xsl:value-of select="email"/>
					</email>
				</xsl:if>
				<xsl:if test="fax">
					<fax>
						<xsl:value-of select="fax"/>
					</fax>
				</xsl:if>
				<xsl:if test="file_encryption_method">
					<file_encryption_method>
						<xsl:value-of select="file_encryption_method"/>
					</file_encryption_method>
				</xsl:if>
				<xsl:if test="iso_code">
					<iso_code>
						<xsl:value-of select="iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="language">
					<language>
						<xsl:value-of select="language"/>
					</language>
				</xsl:if>
				<xsl:if test="legal_id_no">
					<legal_id_no>
						<xsl:value-of select="legal_id_no"/>
					</legal_id_no>
				</xsl:if>
				<xsl:if test="legal_id_type">
					<legal_id_type>
						<xsl:value-of select="legal_id_type"/>
					</legal_id_type>
				</xsl:if>
				<xsl:if test="merge_demerge_allowed">
					<merge_demerge_allowed>
						<xsl:value-of select="merge_demerge_allowed"/>
					</merge_demerge_allowed>
				</xsl:if>
				<xsl:if test="name">
					<name>
						<xsl:value-of select="name"/>
					</name>
				</xsl:if>
				<xsl:if test="owner_id">
					<owner_id>
						<xsl:value-of select="owner_id"/>
					</owner_id>
				</xsl:if>
				<xsl:if test="password_expiry">
					<password_expiry>
						<xsl:value-of select="password_expiry"/>
					</password_expiry>
				</xsl:if>
				<xsl:if test="phone">
					<phone>
						<xsl:value-of select="phone"/>
					</phone>
				</xsl:if>
				<xsl:if test="post_code">
					<post_code>
						<xsl:value-of select="post_code"/>
					</post_code>
				</xsl:if>
				<xsl:if test="reference">
					<reference>
						<xsl:value-of select="reference"/>
					</reference>
				</xsl:if>
				<xsl:if test="reject_file_on_error">
					<reject_file_on_error>
						<xsl:value-of select="reject_file_on_error"/>
					</reject_file_on_error>
				</xsl:if>
				<xsl:if test="retention_period">
					<retention_period>
						<xsl:value-of select="retention_period"/>
					</retention_period>
				</xsl:if>
				<xsl:if test="street_name">
					<street_name>
						<xsl:value-of select="street_name"/>
					</street_name>
				</xsl:if>
				<xsl:if test="telex">
					<telex>
						<xsl:value-of select="telex"/>
					</telex>
				</xsl:if>
				<xsl:if test="town_name">
					<town_name>
						<xsl:value-of select="town_name"/>
					</town_name>
				</xsl:if>
				<xsl:if test="type">
					<type>
						<xsl:value-of select="type"/>
					</type>
				</xsl:if>
				<xsl:if test="web_address">
					<web_address>
						<xsl:value-of select="web_address"/>
					</web_address>
				</xsl:if>
				<xsl:if test="maker_id">
					<maker_id>
						<xsl:value-of select="maker_id"/>
					</maker_id>
				</xsl:if>
				<xsl:if test="checker_id">
					<checker_id>
						<xsl:value-of select="checker_id"/>
					</checker_id>
				</xsl:if>
				<xsl:if test="tnx_id">
					<tnx_id>
						<xsl:value-of select="tnx_id"/>
					</tnx_id>
				</xsl:if>
				<xsl:if test="maker_dttm">
					<maker_dttm>
						<xsl:value-of select="maker_dttm"/>
					</maker_dttm>
				</xsl:if>
				<xsl:if test="checker_dttm">
					<checker_dttm>
						<xsl:value-of select="checker_dttm"/>
					</checker_dttm>
				</xsl:if>
				<xsl:if test="tnx_type_code">
					<tnx_type_code>
						<xsl:value-of select="tnx_type_code"/>
					</tnx_type_code>
				</xsl:if>
				<xsl:if test="tnx_stat_code">
					<tnx_stat_code>
						<xsl:value-of select="tnx_stat_code"/>
					</tnx_stat_code>
				</xsl:if>
				<xsl:if test="treasury_branch_reference">
					<treasury_branch_reference>
						<xsl:value-of select="treasury_branch_reference"/>
					</treasury_branch_reference>
				</xsl:if>
				<xsl:if test="liquidity_frequency">
					<liquidity_frequency>
						<xsl:value-of select="liquidity_frequency"/>
					</liquidity_frequency>
				</xsl:if>
				<xsl:if test="liquidity_balance_type">
					<liquidity_balance_type>
						<xsl:value-of select="liquidity_balance_type"/>
					</liquidity_balance_type>
				</xsl:if>
				<xsl:if test="liquidity_ccy_cur_code">
					<liquidity_ccy_cur_code>
						<xsl:value-of select="liquidity_ccy_cur_code"/>
					</liquidity_ccy_cur_code>
				</xsl:if>
				<xsl:if test="psml_template">
					<psml_template>
						<xsl:value-of select="psml_template"/>
					</psml_template>
				</xsl:if>
				<xsl:if test="internal_channel">
					<internal_channel>
						<xsl:value-of select="internal_channel"/>
					</internal_channel>
				</xsl:if>
				<xsl:if test="return_comments">
					<return_comments>
						<xsl:value-of select="return_comments"/>
					</return_comments>
				</xsl:if>
				<xsl:if test="rmGroup">
					<rmGroup>
						<xsl:value-of select="rmGroup"/>
					</rmGroup>
				</xsl:if>
				<additional_field name="conditions_01" type="string" scope="transaction">
						<xsl:value-of select="conditions_01"/>
				</additional_field>
				<additional_field name="conditions_02" type="string" scope="transaction">
						<xsl:value-of select="conditions_02"/>
				</additional_field>
				<additional_field name="conditions_03" type="string" scope="transaction">
						<xsl:value-of select="conditions_03"/>
				</additional_field>
				<additional_field name="conditions_04" type="string" scope="transaction">
						<xsl:value-of select="conditions_04"/>
				</additional_field>
				<additional_field name="conditions_05" type="string" scope="transaction">
						<xsl:value-of select="conditions_05"/>
				</additional_field>
				<additional_field name="conditions_06" type="string" scope="transaction">
						<xsl:value-of select="conditions_06"/>
				</additional_field>
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.security.GTPExtendedCompanyTnx>
		</result>
	</xsl:template>
	

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
