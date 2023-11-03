<?xml version="1.0"?>
<!--
  		Copyright (c) 2000-2008 Misys (http://www.misys.com)
  		All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
				exclude-result-prefixes="localization">
			
	<!-- Accounts -->
	<xsl:template match="Publications" mode="accounts">
		<accounts>
			<xsl:apply-templates select="Publication/ItemArray/anyType" mode="account"/>
		</accounts>
	</xsl:template>
	
	<xsl:template match="anyType" mode="account">
		<account>
		<xsl:if test="BRCHCODE">
			<brch_code>
				<xsl:value-of select="BRCHCODE"/>
			</brch_code>
		</xsl:if>
		<xsl:if test="COMPANYID">
			<company_id>
				<xsl:value-of select="COMPANYID"/>
			</company_id>
		</xsl:if>		
		<xsl:if test="CUSTOMERREFERENCE">
			<customer_reference>
				<xsl:value-of select="CUSTOMERREFERENCE"/>
			</customer_reference>
		</xsl:if>
		<xsl:if test="ACCOUNTID">
			<account_id>
				<xsl:value-of select="ACCOUNTID"/>
			</account_id>
		</xsl:if>
		<xsl:if test="ENTITY">
			<entity>
				<xsl:value-of select="ENTITY"/>
			</entity>
		</xsl:if>
		<xsl:if test="ACCOUNTNO">
			<account_no>
				<xsl:value-of select="ACCOUNTNO"/>
			</account_no>
		</xsl:if>
		<xsl:if test="TYPE">
			<account_type>
				<xsl:choose>
					<xsl:when test="TYPE='C'">07</xsl:when>
					<xsl:when test="TYPE='T'">12</xsl:when> 
				</xsl:choose>
			</account_type>
			<description>
				<xsl:choose>
					<xsl:when test="TYPE='C'"><xsl:value-of select="localization:getDecode('en', 'N068', '07')"/></xsl:when>
					<xsl:when test="TYPE='T'"><xsl:value-of select="localization:getDecode('en', 'N068', '12')"/></xsl:when> 
				</xsl:choose>
			</description>
		</xsl:if>
		<xsl:if test="FORMAT">
			<format>99</format>
		</xsl:if>
		<xsl:if test="OWNERTYPE">
			<owner_type>10</owner_type>
		</xsl:if>
		<xsl:if test="ISOCODE">
			<iso_code>
				<xsl:value-of select="ISOCODE"/>
			</iso_code>
		</xsl:if>
		<xsl:if test="NAME">
			<name>
				<xsl:value-of select="NAME"/>
			</name>
		</xsl:if>
		<xsl:if test="ADDRESSLINE1">
			<address_line_1>
				<xsl:value-of select="ADDRESSLINE1"/>
			</address_line_1>
		</xsl:if>
		<xsl:if test="ADDRESSLINE2">
			<address_line_2>
				<xsl:value-of select="ADDRESSLINE2"/>
			</address_line_2>
		</xsl:if>
		<xsl:if test="DOM">
			<dom>
				<xsl:value-of select="DOM"/>
			</dom>
		</xsl:if>
		<xsl:if test="COUNTRY">
			<country>
				<xsl:value-of select="COUNTRY"/>
			</country>
		</xsl:if>
		<xsl:if test="BANKNAME">
			<bank_name>
				<xsl:value-of select="BANKNAME"/>
			</bank_name>
		</xsl:if>
		<xsl:if test="BANKADDRESSLINE1">
			<bank_address_line_1>
				<xsl:value-of select="BANKADDRESSLINE1"/>
			</bank_address_line_1>
		</xsl:if>
		<xsl:if test="BANKADDRESSLINE2">
			<bank_address_line_2>
				<xsl:value-of select="BANKADDRESSLINE2"/>
			</bank_address_line_2>
		</xsl:if>
		<xsl:if test="BANKDOM ">
			<bank_dom>
				<xsl:value-of select="BANKDOM "/>
			</bank_dom>
		</xsl:if>
		<xsl:if test="CURCODE">
			<cur_code>
				<xsl:value-of select="CURCODE"/>
			</cur_code>
		</xsl:if>
		<xsl:if test="ROUTINGBIC">
			<routing_bic>
				<xsl:value-of select="ROUTINGBIC"/>
			</routing_bic>
		</xsl:if>
		<xsl:if test="CUSTOMERREFERENCE">
			<branch_no>
				<xsl:value-of select="substring-before(CUSTOMERREFERENCE, '/')"/>
			</branch_no>
		</xsl:if>
		<xsl:if test="OVERDRAFTLIMIT and  OVERDRAFTLIMIT[.!='']">
			<overdraft_limit>
				<xsl:value-of select='format-number(OVERDRAFTLIMIT, "###,###,##0.00")' />
			</overdraft_limit>
		</xsl:if>
		<xsl:if test="INTERESTRATE and  INTERESTRATE[.!='']">
			<interest_rate>
				<xsl:value-of select='format-number(INTERESTRATE, "###,###,##0.00")' />
			</interest_rate>
		</xsl:if>
		<xsl:if test="INTERESTRATE_MATURITY and INTERESTRATE_MATURITY[.!='']">
			<interest_rate_maturity>
				<xsl:value-of select='format-number(INTERESTRATE_MATURITY, "###,###,##0.00")' />
			</interest_rate_maturity>
		</xsl:if>
		<xsl:if test="INTERESTRATE_CREDIT and INTERESTRATE_CREDIT[.!='']">
			<interest_rate_credit>
				<xsl:value-of select='format-number(INTERESTRATE_CREDIT, "###,###,##0.00")' />
			</interest_rate_credit>
		</xsl:if>
		<xsl:if test="INTERESTRATE_DEBIT and INTERESTRATE_DEBIT[.!='']">
			<interest_rate_debit>
				<xsl:value-of select='format-number(INTERESTRATE_DEBIT, "###,###,##0.00")' />
			</interest_rate_debit>
		</xsl:if>
		<xsl:if test="PRINCIPALAMOUNT and PRINCIPALAMOUNT[.!='']">
			<principal_amount>
				<xsl:value-of select='format-number(PRINCIPALAMOUNT, "###,###,##0.00")' />
			</principal_amount>
		</xsl:if>
		<xsl:if test="MATURITYAMOUNT and MATURITYAMOUNT[.!='']">
			<maturity_amount>
				<xsl:value-of select='format-number(MATURITYAMOUNT, "###,###,##0.00")' />
			</maturity_amount>
		</xsl:if>
		<xsl:if test="STARTDATE">
			<start_date>
				<xsl:call-template name="opicsDate2portalDate">
					<xsl:with-param name="date">
						<xsl:value-of select="STARTDATE"/>
					</xsl:with-param>
				</xsl:call-template>
			</start_date>
		</xsl:if>
		<xsl:if test="ENDDATE">
			<end_date>
				<xsl:call-template name="opicsDate2portalDate">
					<xsl:with-param name="date">
						<xsl:value-of select="ENDDATE"/>
					</xsl:with-param>
				</xsl:call-template>
			</end_date>
		</xsl:if>
		<xsl:if test="ACTION">
			<actv_flag>
				<xsl:choose>
					<xsl:when test="ACTION='NEW'">Y</xsl:when>
					<xsl:when test="ACTION='MODIFIED'">Y</xsl:when>
					<xsl:when test="ACTION='CLOSED'">N</xsl:when>
					<xsl:when test="ACTION='REOPENED'">Y</xsl:when>
					<xsl:when test="ACTION='BLOCKED-D'">Y</xsl:when>
					<xsl:when test="ACTION='BLOCKED-W'">Y</xsl:when>
					<xsl:when test="ACTION='BLOCKED-DW'">N</xsl:when>
					<xsl:when test="ACTION='UNBLOCKED'">Y</xsl:when>
				</xsl:choose>
			</actv_flag>
		</xsl:if>
		<xsl:if test="BOCUSTNUMBER ">
			<bo_cust_number>
				<xsl:value-of select="substring-after(CUSTOMERREFERENCE, '/')"/>
			</bo_cust_number>
		</xsl:if>
		<bank_account_product_type>*</bank_account_product_type>		
		<xsl:if test="TYPE">
			<bank_account_type>
				<xsl:choose>
					<xsl:when test="TYPE='C'">CN</xsl:when>
					<xsl:when test="TYPE='T'">SETA</xsl:when> 
				</xsl:choose>
			</bank_account_type>
		</xsl:if>
		<customer_account_type>*</customer_account_type>
		<nra>Y</nra>
		<!-- Account display name, currently concatenates currency, account number and the internal account type description -->
		<acct_name>
			<xsl:value-of select="CURCODE" />
			<xsl:text> </xsl:text>
			<xsl:value-of select="ACCOUNTNO" />
			<xsl:text> </xsl:text>
			<xsl:choose>
				<xsl:when test="TYPE='C'"><xsl:value-of select="localization:getDecode('en', 'N068', '07')"/></xsl:when>
				<xsl:when test="TYPE='T'"><xsl:value-of select="localization:getDecode('en', 'N068', '12')"/></xsl:when> 
			</xsl:choose>
		</acct_name>
		<xsl:if test="DESCRIPTION">
			<settlement_means>
				<xsl:value-of select="DESCRIPTION"/>
			</settlement_means>
		</xsl:if>
		</account>
	</xsl:template>
		
</xsl:stylesheet>