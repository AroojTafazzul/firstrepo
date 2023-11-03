<?xml version="1.0"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com) All Rights Reserved. -->
<!--  This file acts as  holder to transform the bulk information and the secured email transaction information -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:user="xalan://com.misys.portal.security.GTPUser"
			exclude-result-prefixes="security user">
	<xsl:template match="user_details">
	<result>
 		<com.misys.portal.systemfeatures.common.GTPUserFile>
 			<xsl:apply-templates select="user">
 				<xsl:with-param name="operation_type"><xsl:value-of select="./operation_type"/></xsl:with-param>
 			</xsl:apply-templates>
 			<xsl:apply-templates select="user_roles"/>
 			<xsl:apply-templates select="user_entities"/>
		</com.misys.portal.systemfeatures.common.GTPUserFile>
	</result>
	</xsl:template>
	
	<xsl:template match="user">
		<xsl:param name="operation_type"/>
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
			<xsl:if test="correspondence_language">
				<correspondence_language>
					<xsl:value-of select="correspondence_language"/>
				</correspondence_language>
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
			
			<additional_field name="operation_type" type="string" scope="none">
				<xsl:value-of select="$operation_type"/>
			</additional_field>	
			<xsl:apply-templates select="additional_field"/>
		</com.misys.portal.security.db.ExtendableGTPUserTnxImpl>
	</xsl:template>
	
	<xsl:template match="user_roles">
		<result>
			<xsl:for-each select="group_set">
				<xsl:variable name="group_abbv_name">
					<xsl:if test="group_abbv_name">
						<xsl:value-of select="group_abbv_name"/>
					</xsl:if>
				</xsl:variable>
				
				<xsl:choose>
					<!-- If group has roles associated -->
					<xsl:when test="count(user_role)>0">
						<xsl:if test="//user_role/rolename[.!='' ] or //user_role/role_id[.!='']">
							<xsl:for-each select="user_role">
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
									<additional_field name="group_abbv_name" type="string" scope="none">
										<xsl:value-of select="$group_abbv_name"/>
									</additional_field>
									<additional_field name="limit_cur_code" type="string" scope="none">
										<xsl:value-of select="limit_cur_code"/>
									</additional_field>
									<additional_field name="limit_amt" type="string" scope="none">
										<xsl:value-of select="limit_amt"/>
									</additional_field>
								</com.misys.portal.security.db.GTPRoleBulkImpl>
							</xsl:for-each>
						</xsl:if>
					</xsl:when>
					<!-- A case when group name is sent with no roles in it indicating revocation of roles for that group -->
					<xsl:otherwise>
						<com.misys.portal.security.db.GTPRoleBulkImpl>
							<additional_field name="group_abbv_name" type="string" scope="none">
								<xsl:value-of select="$group_abbv_name"/>
							</additional_field>
						</com.misys.portal.security.db.GTPRoleBulkImpl>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</result>
	</xsl:template>
	
	<xsl:template match="user_entities">
		<result>
			<xsl:for-each select="entity_set">
				<xsl:variable name="entity_name">
					<xsl:if test="entity_name">
						<xsl:value-of select="entity_name"/>
					</xsl:if>
				</xsl:variable>
				<xsl:choose>
					<!-- If entity has roles associated -->
					<xsl:when test="count(entity_role)>0">
						<xsl:if test="//entity_role/rolename[.!='']">
							<xsl:for-each select="entity_role">
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
									<additional_field name="entity_name" type="string" scope="none">
										<xsl:value-of select="$entity_name"/>
									</additional_field>
								</com.misys.portal.security.db.GTPRoleBulkImpl>
							</xsl:for-each>							
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<com.misys.portal.security.db.GTPRoleBulkImpl>
							<additional_field name="entity_name" type="string" scope="none">
								<xsl:value-of select="$entity_name"/>
							</additional_field>
						</com.misys.portal.security.db.GTPRoleBulkImpl>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</result>
	</xsl:template>
</xsl:stylesheet>