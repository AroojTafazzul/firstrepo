<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	
	xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	exclude-result-prefixes="tools utils security ">

	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<!-- Get the interface environment -->
	
	<xsl:param name="banks"/>
	<xsl:param name="language">en</xsl:param>

	<!--
	Copyright (c) 2000-2012 Misys (http://www.misys.com),
	All Rights Reserved. 
	-->
	<xsl:template match="Message[Header/MsgType[. = 'REG' or . = 'CUSTDETAIL']]/Content/CustDetail">
		<xsl:variable name="references" select="tools:manageCompanyReferences(BMCustNo,$banks,'FT')"/>
		<xsl:variable name="company_id" select="$references/references/company_id"/>
		<xsl:variable name="company_name" select="$references/references/company_name"/>
		<xsl:variable name="owner_id" select="$references/references/owner_id"/>
		<xsl:variable name="company_exists" select="$references/references/company_exists"/>
		<xsl:variable name="cust_status" select="$references/references/actv_flag"/>
		<xsl:variable name="previous_status" select="$references/references/actv_flag"/>
		<xsl:variable name="actv_flag" select="utils:activeFlagBusinessCodeForCustomer(CustStatus, $company_exists, $cust_status)"/>
		<xsl:variable name="actv_flag_user" select="utils:activeFlagBusinessCodeForUser(CustStatus)"/>
		<xsl:variable name="user_id" select="$references/references/user_id"/>
		
		<!-- <xsl:variable name="company_id" /> -->
		<!-- <xsl:variable name="company_name" />
		<xsl:variable name="owner_id" /> -->
	
		<result>
		<!-- Skip the company creation if CustStatus come as "DELETED" for non existing companies -->
		<xsl:if test="not($company_exists ='false' and CustStatus and CustStatus [.= 'DELETE'])">
		   <com.misys.portal.interfaces.incoming.CompanyFile>
				<com.misys.portal.interfaces.incoming.Company>
				    <company_id><xsl:value-of select="$company_id"/></company_id>
				    <abbv_name><xsl:value-of select="$company_name" /></abbv_name>
				    <name>
				     <xsl:choose>
							<xsl:when test="(CustName[. !='']) and (CustName[. !=' '])">
								<xsl:value-of select="CustName" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="BMCustNo" />
							</xsl:otherwise>
						</xsl:choose>
					</name>
					<street_name><xsl:value-of select="Address/Adrs1" /></street_name>
					<town_name><xsl:value-of select="Address/Adrs2" /></town_name>
					<country_sub_div><xsl:value-of select="Address/City" /></country_sub_div>
					<post_code><xsl:value-of select="Address/PostCode" /></post_code>
					<county><xsl:value-of select="Address/County" /></county>
					<country_name><xsl:value-of select="Address/Country" /></country_name>
				    <contact_name>
					    <xsl:choose>
							<xsl:when test="(Contact/ContactName[. !='']) and (Contact/ContactName[. !=' '])">
								<xsl:value-of select="Contact/ContactName" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="BMCustNo" />
							</xsl:otherwise>
						</xsl:choose>
				    </contact_name>
				    <phone><xsl:value-of select="Contact/ContactPhone" /></phone>
				    <reference><xsl:value-of select="BMCustNo" /></reference>
				    <email><xsl:value-of select="Contact/ContactEMail" /></email>
				    <company_type><xsl:value-of select="utils:companyTypeBusinessCode(CustomerType)" /></company_type>
				    <owner_id><xsl:value-of select="$owner_id" /></owner_id>
				    <language><xsl:value-of select= "$language" /></language>
				    <base_cur_code></base_cur_code>
				    <actv_flag><xsl:value-of select="$actv_flag" /></actv_flag>
				    <previous_status><xsl:value-of select="$previous_status" /></previous_status>
				    <company_exists><xsl:value-of select="$company_exists" /></company_exists>
				   	 <default_contract><xsl:value-of select="tools:isDefaultCustomerReference(BMCustNo,'Y',$banks,'FT')" /></default_contract>
			    </com.misys.portal.interfaces.incoming.Company>
			  	<xsl:if test="$company_exists ='false'">
				    <com.misys.portal.interfaces.incoming.User>
				    	<!-- <user_id><xsl:value-of select="$user_id"/></user_id> -->
						<login_id>
							<xsl:choose>
								<xsl:when test="(CustAuth/UserId[. !='']) and (CustAuth/UserId[. !=' '])">
									<xsl:value-of select="CustAuth/UserId" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="BMCustNo" />
								</xsl:otherwise>
							</xsl:choose>
						</login_id>
						<password_value>
							<xsl:choose>
								<xsl:when test="(CustAuth/Password[. !='']) and (CustAuth/Password[. !=' '])">
									<xsl:value-of select="CustAuth/Password" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="tools:generatePassword()"></xsl:value-of>
								</xsl:otherwise>
							</xsl:choose>
						</password_value>
						<first_name>
							<xsl:value-of select="CustName" />
						</first_name>
						<!-- topopulate before commiting the user -->
						<company_id>
							<xsl:value-of
								select="$company_id" />
						</company_id>
						<company_abbv_name>
							<xsl:value-of select="BMCustNo" />
						</company_abbv_name>
						<address_line_1>
							<xsl:value-of select="Address/Adrs1" />
						</address_line_1>
						<address_line_2>
							<xsl:value-of select="Address/Adrs2" />
						</address_line_2>
						<country_sub_div>
							<xsl:value-of select="Address/City" />
						</country_sub_div>
						<county>
							<xsl:value-of select="Address/County" />
						</county>
						<country_name>
							<xsl:value-of select="Address/Country" />
						</country_name>
						<dom>
							<xsl:value-of select="Address/PostCode" />
						</dom>
						<phone>
							<xsl:value-of select="Contact/ContactPhone" />
						</phone>
						<email>
							<xsl:value-of select="Contact/ContactEMail" />
						</email>
						<language>
							<xsl:value-of select="$language" />
						</language>
						<cur_code></cur_code>
						<time_zone>Europe/London</time_zone>
						<actv_flag><xsl:value-of select="$actv_flag_user" /></actv_flag>						
					</com.misys.portal.interfaces.incoming.User>
			  	 </xsl:if>
		     </com.misys.portal.interfaces.incoming.CompanyFile>
		     </xsl:if>
		</result>
	</xsl:template>
</xsl:stylesheet>
