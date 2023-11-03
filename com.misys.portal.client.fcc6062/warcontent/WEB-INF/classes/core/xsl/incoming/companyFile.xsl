<?xml version="1.0"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com) All Rights Reserved. -->
<!--  This file acts as  holder to transform the bulk information and the secured email transaction information -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:company="xalan://com.misys.portal.security.GTPCompany"
			exclude-result-prefixes="security company">
	<xsl:template match="company_details">
	<result>
 		<com.misys.portal.systemfeatures.common.GTPCompanyFile>
 			<xsl:apply-templates select="company">
 				<xsl:with-param name="operation_type"><xsl:value-of select="./operation_type"/></xsl:with-param>
 			</xsl:apply-templates>
 			<xsl:apply-templates select="user"/>
 			<xsl:apply-templates select="customer_references"/>
 			<xsl:apply-templates select="roles"/>
 			<xsl:apply-templates select="attached_banks"/>
 			<xsl:apply-templates select="static_beneficiary"/>
		</com.misys.portal.systemfeatures.common.GTPCompanyFile>
	</result>
	</xsl:template>
	
	<xsl:template match="company">
		<xsl:param name="operation_type"/>
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
			<xsl:if test="return_comments">
				<return_comments>
					<xsl:value-of select="return_comments"/>
				</return_comments>
			</xsl:if>
			<xsl:if test="psml_template">
				<psml_template>
					<xsl:value-of select="psml_template"/>
				</psml_template>
			</xsl:if>
			<additional_field name="operation_type" type="string" scope="none">
				<xsl:value-of select="$operation_type"/>
			</additional_field>	
			<xsl:if test="owner_abbv_name">
				<additional_field name="owner_abbv_name" type="string" scope="none">
					<xsl:value-of select="owner_abbv_name"/>
				</additional_field>
			</xsl:if>
			<xsl:if test="rmGroup">
				<rmGroup>
					<xsl:value-of select="rmGroup"/>
				</rmGroup>
			</xsl:if>
			<xsl:if test="internal_channel">
				<internal_channel>
					<xsl:value-of select="internal_channel"/>
				</internal_channel>
			</xsl:if>
			
			<xsl:apply-templates select="additional_field"/>
		</com.misys.portal.security.GTPExtendedCompanyTnx>
	</xsl:template>
	
	<xsl:template match="user">
		<com.misys.portal.security.db.ExtendableGTPUserTnxImpl>
			<xsl:if test="user_id">
				<user_id>
					<xsl:value-of select="user_id"/>
				</user_id>
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
			<xsl:if test="company_abbv_name">
				<company_abbv_name>
					<xsl:value-of select="company_abbv_name"/>
				</company_abbv_name>
			</xsl:if>
			<xsl:if test="company_id">
				<company_id>
					<xsl:value-of select="company_id"/>
				</company_id>
			</xsl:if>
			<xsl:if test="country">
				<country>
					<xsl:value-of select="country"/>
				</country>
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
			<xsl:if test="created">
				<created>
					<xsl:value-of select="created"/>
				</created>
			</xsl:if>
			<xsl:if test="cur_code">
				<cur_code>
					<xsl:value-of select="cur_code"/>
				</cur_code>
			</xsl:if>
			<xsl:if test="deleted">
				<deleted>
					<xsl:value-of select="deleted"/>
				</deleted>
			</xsl:if>
			<xsl:if test="dom">
				<dom>
					<xsl:value-of select="dom"/>
				</dom>
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
			<xsl:if test="first_name">
				<first_name>
					<xsl:value-of select="first_name"/>
				</first_name>
			</xsl:if>
			<xsl:if test="language">
				<language>
					<xsl:value-of select="language"/>
				</language>
			</xsl:if>
			<xsl:if test="lastlogin">
				<lastlogin>
					<xsl:value-of select="lastlogin"/>
				</lastlogin>
			</xsl:if>
			<xsl:if test="last_name">
				<last_name>
					<xsl:value-of select="last_name"/>
				</last_name>
			</xsl:if>
			<xsl:if test="login_id">
				<login_id>
					<xsl:value-of select="login_id"/>
				</login_id>
			</xsl:if>
			<xsl:if test="modified">
				<modified>
					<xsl:value-of select="modified"/>
				</modified>
			</xsl:if>
			<xsl:if test="org_login_id">
				<org_login_id>
					<xsl:value-of select="org_login_id"/>
				</org_login_id>
			</xsl:if>
			<xsl:if test="password_value">
				<password_value>
					<xsl:value-of select="password_value"/>
				</password_value>
			</xsl:if>
			<xsl:if test="pending_trans_notify">
				<pending_trans_notify>
					<xsl:value-of select="pending_trans_notify"/>
				</pending_trans_notify>
			</xsl:if>
			<xsl:if test="phone">
				<phone>
					<xsl:value-of select="phone"/>
				</phone>
			</xsl:if>
			<xsl:if test="reference">
				<reference>
					<xsl:value-of select="reference"/>
				</reference>
			</xsl:if>
			<xsl:if test="time_zone">
				<time_zone>
					<xsl:value-of select="time_zone"/>
				</time_zone>
			</xsl:if>
			<xsl:if test="one_fa_last_login">
				<one_fa_last_login>
					<xsl:value-of select="one_fa_last_login"/>
				</one_fa_last_login>
			</xsl:if>
			<xsl:if test="employee_department">
				<employee_department>
					<xsl:value-of select="employee_department"/>
				</employee_department>
			</xsl:if>
			<xsl:if test="login_attempts">
				<login_attempts>
					<xsl:value-of select="login_attempts"/>
				</login_attempts>
			</xsl:if>
			<xsl:if test="password_expiry">
				<password_expiry>
					<xsl:value-of select="password_expiry"/>
				</password_expiry>
			</xsl:if>
			<xsl:if test="employee_no">
				<employee_no>
					<xsl:value-of select="employee_no"/>
				</employee_no>
			</xsl:if>
			<xsl:if test="creator_id">
				<creator_id>
					<xsl:value-of select="creator_id"/>
				</creator_id>
			</xsl:if>
			<xsl:if test="creator_login">
				<creator_login>
					<xsl:value-of select="creator_login"/>
				</creator_login>
			</xsl:if>
			<xsl:if test="creator_company">
				<creator_company>
					<xsl:value-of select="creator_company"/>
				</creator_company>
			</xsl:if>
			<xsl:if test="reauth_mode">
				<reauth_mode>
					<xsl:value-of select="reauth_mode"/>
				</reauth_mode>
			</xsl:if>
			<xsl:if test="legal_no">
				<legal_no>
					<xsl:value-of select="legal_no"/>
				</legal_no>
			</xsl:if>
			<xsl:if test="legal_country">
				<legal_country>
					<xsl:value-of select="legal_country"/>
				</legal_country>
			</xsl:if>
			<xsl:if test="legal_type">
				<legal_type>
					<xsl:value-of select="legal_type"/>
				</legal_type>
			</xsl:if>
			<xsl:if test="terms_conds_accept_date">
				<terms_conds_accept_date>
					<xsl:value-of select="terms_conds_accept_date"/>
				</terms_conds_accept_date>
			</xsl:if>
			<xsl:if test="access_counter">
				<access_counter>
					<xsl:value-of select="access_counter"/>
				</access_counter>
			</xsl:if>
			<xsl:if test="password_migrated">
				<password_migrated>
					<xsl:value-of select="password_migrated"/>
				</password_migrated>
			</xsl:if>
			<xsl:if test="locked_time">
				<locked_time>
					<xsl:value-of select="locked_time"/>
				</locked_time>
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
			<xsl:if test="return_comments">
				<return_comments>
					<xsl:value-of select="return_comments"/>
				</return_comments>
			</xsl:if>
			<xsl:if test="init_pass_mc">
				<init_pass_mc>
					<xsl:value-of select="init_pass_mc"/>
				</init_pass_mc>
			</xsl:if>
			<xsl:if test="init_key">
				<init_key>
					<xsl:value-of select="init_key"/>
				</init_key>
			</xsl:if>
			<xsl:if test="company_default_user">
				<company_default_user>
					<xsl:value-of select="company_default_user"/>
				</company_default_user>
			</xsl:if>
			
			<xsl:if test="rmGroup">
				<rmGroup>
					<xsl:value-of select="rmGroup"/>
				</rmGroup>
			</xsl:if>
			<xsl:apply-templates select="additional_field"/>
		</com.misys.portal.security.db.ExtendableGTPUserTnxImpl>
	</xsl:template>
	
	<xsl:template match="static_beneficiary">
		<com.misys.portal.systemfeatures.common.StaticBeneficiary>
			<xsl:if test="beneficiary_id">
				<beneficiary_id>
					<xsl:value-of select="beneficiary_id"/>
				</beneficiary_id>
			</xsl:if>
			<xsl:if test="abbv_name">
				<abbv_name>
					<xsl:value-of select="abbv_name"/>
				</abbv_name>
			</xsl:if>
			<xsl:if test="name">
				<name>
					<xsl:value-of select="name"/>
				</name>
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
			<xsl:if test="dom">
				<dom>
					<xsl:value-of select="dom"/>
				</dom>
			</xsl:if>
			<xsl:if test="country">
				<country>
					<xsl:value-of select="country"/>
				</country>
			</xsl:if>
			<xsl:if test="contact_name">
				<contact_name>
					<xsl:value-of select="contact_name"/>
				</contact_name>
			</xsl:if>
			<xsl:if test="phone">
				<phone>
					<xsl:value-of select="phone"/>
				</phone>
			</xsl:if>
			<xsl:if test="fax">
				<fax>
					<xsl:value-of select="fax"/>
				</fax>
			</xsl:if>
			<xsl:if test="telex">
				<telex>
					<xsl:value-of select="telex"/>
				</telex>
			</xsl:if>
			<xsl:if test="reference">
				<reference>
					<xsl:value-of select="reference"/>
				</reference>
			</xsl:if>
			<xsl:if test="email">
				<email>
					<xsl:value-of select="email"/>
				</email>
			</xsl:if>
			<xsl:if test="web_address">
				<web_address>
					<xsl:value-of select="web_address"/>
				</web_address>
			</xsl:if>
			<xsl:if test="access_opened">
				<access_opened>
					<xsl:value-of select="access_opened"/>
				</access_opened>
			</xsl:if>
			<xsl:if test="notification_enabled">
				<notification_enabled>
					<xsl:value-of select="notification_enabled"/>
				</notification_enabled>
			</xsl:if>
			<xsl:if test="fscm_enabled">
				<fscm_enabled>
						<xsl:value-of select="fscm_enabled"/>
				</fscm_enabled>
			</xsl:if>
			<xsl:if test="beneficiary_company_abbv_name">
				<beneficiary_company_abbv_name>
					<xsl:value-of select="beneficiary_company_abbv_name"/>
				</beneficiary_company_abbv_name>
			</xsl:if>
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
			<xsl:if test="owner_customer_abbv_name">
				<additional_field name="owner_customer_abbv_name" type="string" scope="none">
					<xsl:value-of select="owner_customer_abbv_name"/>
				</additional_field>
			</xsl:if>
			<xsl:apply-templates select="additional_field"/>
		</com.misys.portal.systemfeatures.common.StaticBeneficiary>
	</xsl:template>
	
	<xsl:template match="customer_references">
		<result>
			<xsl:for-each select="reference_record">
				<com.misys.portal.product.util.CustomerReference>
					<xsl:if test="customer_abbv_name">
						<customer_abbv_name>
							<xsl:value-of select="customer_abbv_name"/>
						</customer_abbv_name>
					</xsl:if>
					<xsl:if test="customer_id">
						<customer_id>
							<xsl:value-of select="customer_id"/>
						</customer_id>
					</xsl:if>
					<xsl:if test="bank_abbv_name">
						<bank_abbv_name>
							<xsl:value-of select="bank_abbv_name"/>
						</bank_abbv_name>
					</xsl:if>
					<xsl:if test="bank_id">
						<bank_id>
							<xsl:value-of select="bank_id"/>
						</bank_id>
					</xsl:if>
					<xsl:if test="reference">
						<reference>
							<xsl:value-of select="reference"/>
						</reference>
					</xsl:if>
					<xsl:if test="description">
						<description>
							<xsl:value-of select="description"/>
						</description>
					</xsl:if>
					<xsl:if test="back_office_1">
						<back_office_1>
							<xsl:value-of select="back_office_1"/>
						</back_office_1>
					</xsl:if>
					<xsl:if test="back_office_2">
						<back_office_2>
							<xsl:value-of select="back_office_2"/>
						</back_office_2>
					</xsl:if>
					<xsl:if test="back_office_3">
						<back_office_3>
							<xsl:value-of select="back_office_3"/>
						</back_office_3>
					</xsl:if>
					<xsl:if test="back_office_4">
						<back_office_4>
							<xsl:value-of select="back_office_4"/>
						</back_office_4>
					</xsl:if>
					<xsl:if test="back_office_5">
						<back_office_5>
							<xsl:value-of select="back_office_5"/>
						</back_office_5>
					</xsl:if>
					<xsl:if test="back_office_6">
						<back_office_6>
							<xsl:value-of select="back_office_6"/>
						</back_office_6>
					</xsl:if>
					<xsl:if test="back_office_7">
						<back_office_7>
							<xsl:value-of select="back_office_7"/>
						</back_office_7>
					</xsl:if>
					<xsl:if test="back_office_8">
						<back_office_8>
							<xsl:value-of select="back_office_8"/>
						</back_office_8>
					</xsl:if>
					<xsl:if test="back_office_9">
						<back_office_9>
							<xsl:value-of select="back_office_9"/>
						</back_office_9>
					</xsl:if>
					<xsl:if test="default_reference">
						<default_reference>
							<xsl:value-of select="default_reference"/>
						</default_reference>
					</xsl:if>	
					<xsl:apply-templates select="additional_field"/>
				</com.misys.portal.product.util.CustomerReference>
			</xsl:for-each>
		</result>
	</xsl:template>
	
	<xsl:template match="roles">
		<result>
			<xsl:for-each select="company_role">
				<com.misys.portal.security.db.GTPRoleBulkImpl>
					<xsl:if test="role_id">
						<role_id>
							<xsl:value-of select="role_id"/>
						</role_id>
					</xsl:if>
					<xsl:if test="owner_id">
						<owner_id>
							<xsl:value-of select="owner_id"/>
						</owner_id>
					</xsl:if>
					<xsl:if test="roledest">
						<roledest>
							<xsl:value-of select="roledest"/>
						</roledest>
					</xsl:if>
					<xsl:if test="roletype">
						<roletype>
							<xsl:value-of select="roletype"/>
						</roletype>
					</xsl:if>
					<xsl:if test="rolename">
						<rolename>
							<xsl:value-of select="rolename"/>
						</rolename>
					</xsl:if>
				</com.misys.portal.security.db.GTPRoleBulkImpl>
			</xsl:for-each>
		</result>
	</xsl:template>
	
	
	<xsl:template match="attached_banks">
			<xsl:for-each select="bank_abbv_name">
				<xsl:variable name="bank" select="security:getCompany(.)"/>
				<xsl:variable name="bank_id" select="company:getIdAsInt($bank)"></xsl:variable>
				<result>	
					<com.misys.portal.security.db.CustomerBankBulk>
						<bank_id>
							<xsl:value-of select="$bank_id"/>
						</bank_id>
					</com.misys.portal.security.db.CustomerBankBulk>
				</result>
			</xsl:for-each>
	</xsl:template>
	
</xsl:stylesheet>
