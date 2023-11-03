<?xml version="1.0"?>
<!--
   Copyright (c) 2000-2010 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	exclude-result-prefixes="tools">
	
	<xsl:param name="bo_type" />
	<xsl:param name="banks" />

	<!-- 
		2 top-level elements are proposed to update Accounts, Statements, Balances or Statements and Balances only

		<accounts>
			when processed, Accounts, Statements and Balances are updated or created if they don't exist in database
		<accountStatements>
			when processed, only Statements and Balances are update or created. Accounts must exist in database
	 -->

	<!-- a list of Account (with optional Statements and Balances) -->
	<xsl:template match="accounts">
		<result>
			<com.misys.portal.interfaces.incoming.AccountSet>
				<xsl:apply-templates select="account" />
			</com.misys.portal.interfaces.incoming.AccountSet>
		</result>
	</xsl:template>

	<!-- a list of Account (with optional Statements and Balances) -->
	<xsl:template match="accountStatements">
		<result>
			<com.misys.portal.interfaces.incoming.AccountStatementsSet>
				<xsl:apply-templates select="account" />
			</com.misys.portal.interfaces.incoming.AccountStatementsSet>
		</result>
	</xsl:template>

	<!-- 
	 ***********************************************************************************************
	 -->

	<!-- 1 Account contains details and Statements -->
	<xsl:template match="account">
		<xsl:param name="references"
			select="tools:manageAccountStatementReferences(iso_code, account_no, cur_code, '02', bo_cust_number, $bo_type , $banks, statements/statement/idx)" />
		        <xsl:variable name="accType">
            <xsl:choose>
                <xsl:when test="bank_account_type">
                   <xsl:value-of select="utils:trimTheValue(bank_account_type)"/>
                </xsl:when>
                <xsl:otherwise>
                   <xsl:value-of select="utils:getAccountType(account_no)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        	<xsl:variable name="referencesForCid" select="tools:manageCompanyReferences(bo_cust_number, $banks, 'FT')"/>
            <xsl:variable name="company_id" select="$referencesForCid/referencesForCid/company_id"/>
        <xsl:if test="bank_account_type">
		<xsl:variable name="internalAcctType" select="utils:retrieveInternalAccountType($accType, $company_id)"/>
		</xsl:if>
        		<com.misys.portal.cash.product.ab.common.Account>
			<xsl:attribute name="account_id"><xsl:value-of select="$references/references/account_id"/></xsl:attribute>
			<xsl:call-template name="account-details">
				<xsl:with-param name="references" select="$references" />
			</xsl:call-template>			
			<xsl:apply-templates select="statements">
				<xsl:with-param name="references" select="$references" />
			</xsl:apply-templates>			
		</com.misys.portal.cash.product.ab.common.Account>
	</xsl:template>

	<!-- Account details -->
	<xsl:template name="account-details">
		<xsl:param name="references" />
		<brch_code>
			<xsl:value-of select="$brch_code" />
		</brch_code>
		<xsl:choose>
			<xsl:when test="bank_abbv_name and bank_abbv_name[.!='']">
				<bank_abbv_name><xsl:value-of select="bank_abbv_name"/></bank_abbv_name>
			</xsl:when>
			<xsl:otherwise>
				<bank_abbv_name><xsl:value-of select="$references/references/main_bank_abbv_name"/></bank_abbv_name>
			</xsl:otherwise>
		</xsl:choose>
		<!-- <account_no><xsl:value-of select="$references/references/account_no"/></account_no> -->
		<xsl:if test="account_no">
			<account_no>
				<xsl:value-of select="account_no" />
			</account_no>
		</xsl:if>
		<xsl:if test="description">
			<description>
				<xsl:value-of select="description" />
			</description>
		</xsl:if>
		<xsl:if test="account_type">
			<account_type>
				<xsl:value-of select="account_type" />
			</account_type>
		</xsl:if>
		<xsl:if test="format">
			<format>
				<xsl:value-of select="format" />
			</format>
		</xsl:if>
		<xsl:if test="owner_type">
			<owner_type>
				<xsl:value-of select="owner_type" />
			</owner_type>
		</xsl:if>
		<xsl:if test="iso_code">
			<iso_code>
				<xsl:value-of select="iso_code" />
			</iso_code>
		</xsl:if>
		<xsl:if test="name">
			<name>
				<xsl:value-of select="name" />
			</name>
		</xsl:if>
		<xsl:if test="address_line_1">
			<address_line_1>
				<xsl:value-of select="address_line_1" />
			</address_line_1>
		</xsl:if>
		<xsl:if test="address_line_2">
			<address_line_2>
				<xsl:value-of select="address_line_2" />
			</address_line_2>
		</xsl:if>
		<xsl:if test="dom">
			<dom>
				<xsl:value-of select="dom" />
			</dom>
		</xsl:if>
		<xsl:if test="country">
			<country>
				<xsl:value-of select="country" />
			</country>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="bank_name and bank_name[.!='']">
				<bank_name><xsl:value-of select="bank_name"/></bank_name>
			</xsl:when>
			<xsl:otherwise>
				<bank_name><xsl:value-of select="$references/references/main_bank_name"/></bank_name>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="bank_address_line_1">
			<bank_address_line_1>
				<xsl:value-of select="bank_address_line_1" />
			</bank_address_line_1>
		</xsl:if>
		<xsl:if test="bank_address_line_2">
			<bank_address_line_2>
				<xsl:value-of select="bank_address_line_2" />
			</bank_address_line_2>
		</xsl:if>
		<xsl:if test="bank_dom">
			<bank_dom>
				<xsl:value-of select="bank_dom" />
			</bank_dom>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="$references/references/cur_code">
				<cur_code>
					<xsl:value-of select="$references/references/cur_code" />
				</cur_code>
			</xsl:when>
			<xsl:otherwise>
				<cur_code>
					<xsl:value-of select="cur_code" />
				</cur_code>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:if test="routing_bic">
			<routing_bic>
				<xsl:value-of select="routing_bic" />
			</routing_bic>
		</xsl:if>
		<xsl:if test="branch_no">
			<branch_no>
				<xsl:value-of select="branch_no" />
			</branch_no>
		</xsl:if>
		<xsl:if test="overdraft_limit">
			<overdraft_limit>
				<xsl:value-of select="overdraft_limit" />
			</overdraft_limit>
		</xsl:if>
		<xsl:if test="interest_rate">
			<interest_rate>
				<xsl:value-of select="interest_rate" />
			</interest_rate>
		</xsl:if>
		<xsl:if test="interest_rate_maturity">
			<interest_rate_maturity>
				<xsl:value-of select="interest_rate_maturity" />
			</interest_rate_maturity>
		</xsl:if>
		<xsl:if test="interest_rate_credit">
			<interest_rate_credit>
				<xsl:value-of select="interest_rate_credit" />
			</interest_rate_credit>
		</xsl:if>
		<xsl:if test="interest_rate_debit">
			<interest_rate_debit>
				<xsl:value-of select="interest_rate_debit" />
			</interest_rate_debit>
		</xsl:if>
		<xsl:if test="principal_amount">
			<principal_amount>
				<xsl:value-of select="principal_amount" />
			</principal_amount>
		</xsl:if>
		<xsl:if test="maturity_amount">
			<maturity_amount>
				<xsl:value-of select="maturity_amount" />
			</maturity_amount>
		</xsl:if>
		<xsl:if test="start_date">
			<start_date>
				<xsl:value-of select="start_date" />
			</start_date>
		</xsl:if>
		<xsl:if test="end_date">
			<end_date>
				<xsl:value-of select="end_date" />
			</end_date>
		</xsl:if>
		<xsl:if test="actv_flag">
			<actv_flag>
				<xsl:value-of select="actv_flag" />
			</actv_flag>
		</xsl:if>
		<xsl:if test="bo_cust_number">
			<bo_cust_number>
				<xsl:value-of select="$references/references/bo_cust_number" />
			</bo_cust_number>
		</xsl:if>
		<xsl:if test="bo_type">
			<bo_type>
				<xsl:value-of select="bo_type" />
			</bo_type>
		</xsl:if>
		<xsl:if test="email">
			<email>
				<xsl:value-of select="email" />
			</email>
		</xsl:if>
		<xsl:if test="max_transfer_limit">
			<max_transfer_limit>
				<xsl:value-of select="max_transfer_limit" />
			</max_transfer_limit>
		</xsl:if>
		<xsl:if test="bank_chips_uid">
			<bank_chips_uid>
				<xsl:value-of select="bank_chips_uid" />
			</bank_chips_uid>
		</xsl:if>
		<xsl:if test="intermediary_country">
			<intermediary_country>
				<xsl:value-of select="intermediary_country" />
			</intermediary_country>
		</xsl:if>
		<xsl:if test="intermediary_bank_name">
			<intermediary_bank_name>
				<xsl:value-of select="intermediary_bank_name" />
			</intermediary_bank_name>
		</xsl:if>
		<xsl:if test="intermediary_branch_no">
			<intermediary_branch_no>
				<xsl:value-of select="intermediary_branch_no" />
			</intermediary_branch_no>
		</xsl:if>
		<xsl:if test="intermediary_chips_uid">
			<intermediary_chips_uid>
				<xsl:value-of select="intermediary_chips_uid" />
			</intermediary_chips_uid>
		</xsl:if>
		<xsl:if test="intermed_bank_address_line_1">
			<intermed_bank_address_line_1>
				<xsl:value-of select="intermed_bank_address_line_1" />
			</intermed_bank_address_line_1>
		</xsl:if>
		<xsl:if test="intermed_bank_address_line_2">
			<intermed_bank_address_line_2>
				<xsl:value-of select="intermed_bank_address_line_2" />
			</intermed_bank_address_line_2>
		</xsl:if>
		<xsl:if test="intermed_bank_dom">
			<intermed_bank_dom>
				<xsl:value-of select="intermed_bank_dom" />
			</intermed_bank_dom>
		</xsl:if>
		<xsl:if test="bank_id">
			<bank_id>
				<xsl:value-of select="bank_id" />
			</bank_id>
		</xsl:if>
		<xsl:if test="acct_name">
			<acct_name>
				<xsl:value-of select="acct_name" />
			</acct_name>
		</xsl:if>
		<xsl:if test="created_date">
			<created_dttm>
				<xsl:value-of select="created_date" />
			</created_dttm>
		</xsl:if>
		<xsl:if test="modified_date">
			<modified_dttm>
				<xsl:value-of select="modified_date" />
			</modified_dttm>
		</xsl:if>
		<xsl:if test="alternative_acct_no">
			<alternative_acct_no>
				<xsl:value-of select="alternative_acct_no" />
			</alternative_acct_no>
		</xsl:if>
		<xsl:if test="bank_account_product_type">
			<additional_field name="bank_account_product_type"
				type="string" scope="master">
				<xsl:value-of select="bank_account_product_type" />
			</additional_field>
		</xsl:if>
		<xsl:if test="td_type">
			<additional_field name="td_type"
				type="string" scope="master">
				<xsl:value-of select="td_type" />
			</additional_field>
		</xsl:if>
		<xsl:if test="bank_account_type">
			<additional_field name="bank_account_type" type="string"
				scope="master">
				<xsl:value-of select="bank_account_type" />
			</additional_field>
		</xsl:if>
		<xsl:if test="customer_account_type">
			<additional_field name="customer_account_type" type="string"
				scope="master">
				<xsl:value-of select="customer_account_type" />
			</additional_field>
		</xsl:if>
		<xsl:if test="nra">
			<additional_field name="nra" type="string" scope="master">
				<xsl:value-of select="nra" />
			</additional_field>
		</xsl:if>
		<xsl:if test="settlement_means">
			<additional_field name="settlement_means" type="string" scope="master">
				<xsl:value-of select="settlement_means" />
			</additional_field>
		</xsl:if>
		<xsl:apply-templates select="additional_field"/>
	</xsl:template>

	<!-- 1 Statements is a list of Statement -->
	<xsl:template match="statements">
		<xsl:param name="references" />
		<xsl:apply-templates select="statement">
			<xsl:with-param name="references" select="$references" />
		</xsl:apply-templates>
	</xsl:template>

	<!-- 1 Statement contains Balances and Lines -->
	<xsl:template match="statement">
		<xsl:param name="references" />
		<com.misys.portal.cash.product.ab.common.AccountStatement>
			<brch_code><xsl:value-of select="$brch_code"/></brch_code>
			<xsl:if test="$references/references/statement_id">
				<statement_id><xsl:value-of select="$references/references/statement_id"/></statement_id>
			</xsl:if>
			<xsl:if test="$references/references/account_id">
				<account_id><xsl:value-of select="$references/references/account_id"/></account_id>
			</xsl:if>
			<xsl:if test="type">
				<type>
					<xsl:value-of select="type" />
				</type>
			</xsl:if>
			<xsl:if test="idx">
				<idx>
					<xsl:value-of select="idx" />
				</idx>
			</xsl:if>
			<xsl:if test="seq_idx">
				<seq_idx>
					<xsl:value-of select="seq_idx" />
				</seq_idx>
			</xsl:if>
			<xsl:if test="description">
				<description>
					<xsl:value-of select="description" />
				</description>
			</xsl:if>
			<xsl:if test="value_date">
				<value_date>
					<xsl:value-of select="value_date" />
				</value_date>
			</xsl:if>
			<xsl:if test="remove_from_date">
				<additional_field name="remove_from_date" type="string" scope="master">
					<xsl:value-of select="remove_from_date" />
				</additional_field>
			</xsl:if>
			<xsl:apply-templates select="balances/balance">
				<xsl:with-param name="references" select="$references" />
			</xsl:apply-templates>

			<xsl:apply-templates select="lines/line">
				<xsl:with-param name="references" select="$references" />
			</xsl:apply-templates>
		</com.misys.portal.cash.product.ab.common.AccountStatement>
	</xsl:template>

	<!-- Balance -->
	<xsl:template match="balance">
		<xsl:param name="references" />
		<com.misys.portal.cash.product.ab.common.AccountBalance>
			<xsl:if test="$references/references/statement_id">
				<statement_id><xsl:value-of select="$references/references/statement_id"/></statement_id>		
			</xsl:if>
			<xsl:if test="type">
				<type>
					<xsl:value-of select="type" />
				</type>
			</xsl:if>
			<xsl:variable name ="type"><xsl:value-of select="type"/></xsl:variable>
			<xsl:if test="$references/references/balances/balance_id[@type = $type]">
				<balance_id>
					<xsl:value-of select="$references/references/balances/balance_id[@type = $type]"/>
				</balance_id>
			</xsl:if>
			<xsl:if test="value_date">
				<value_date>
					<xsl:value-of select="value_date" />
				</value_date>
			</xsl:if>
			<xsl:if test="cur_code">
				<cur_code>
					<xsl:value-of select="cur_code" />
				</cur_code>
			</xsl:if>
			<xsl:if test="amt">
				<amt>
					<xsl:value-of select="amt" />
				</amt>
			</xsl:if>
		</com.misys.portal.cash.product.ab.common.AccountBalance>
	</xsl:template>

	<!-- Statement line -->
	<xsl:template match="line">
		<xsl:param name="references" />
		<com.misys.portal.cash.product.ab.common.AccountStatementLine>
			<statement_id><xsl:value-of select="$references/references/statement_id"/></statement_id>
			<xsl:if test="line_id">
				<line_id><xsl:value-of select="line_id"/></line_id>
			</xsl:if>
			<xsl:if test="post_date">
				<post_date>
					<xsl:value-of select="post_date" />
				</post_date>
			</xsl:if>
			<xsl:if test="value_date">
				<value_date>
					<xsl:value-of select="value_date" />
				</value_date>
			</xsl:if>
			<xsl:if test="cur_code">
				<cur_code>
					<xsl:value-of select="cur_code" />
				</cur_code>
			</xsl:if>
			<xsl:if test="withdrawal">
				<withdrawal>
					<xsl:value-of select="withdrawal" />
				</withdrawal>
			</xsl:if>
			<xsl:if test="deposit">
				<deposit>
					<xsl:value-of select="deposit" />
				</deposit>
			</xsl:if>
			<xsl:if test="type">
				<tnx_type>
					<xsl:value-of select="type" />
				</tnx_type>
			</xsl:if>
			<xsl:if test="cust_ref_id">
				<cust_ref_id>
					<xsl:value-of select="cust_ref_id" />
				</cust_ref_id>
			</xsl:if>
			<xsl:if test="bo_ref_id">
				<bo_ref_id>
					<xsl:value-of select="bo_ref_id" />
				</bo_ref_id>
			</xsl:if>
			<xsl:if test="bo_tnx_id">
				<bo_tnx_id>
					<xsl:value-of select="bo_tnx_id" />
				</bo_tnx_id>
			</xsl:if>
			<xsl:if test="supplementary_details">
				<supplementary_details>
					<xsl:value-of select="supplementary_details" />
				</supplementary_details>
			</xsl:if>
			<xsl:if test="entry_type">
				<entry_type>
					<xsl:value-of select="entry_type" />
				</entry_type>
			</xsl:if>
			<xsl:if test="description">
				<description>
					<xsl:value-of select="description" />
				</description>
			</xsl:if>
			<xsl:if test="runbal_booked">
				<runbal_booked>
					<xsl:value-of select="runbal_booked" />
				</runbal_booked>
			</xsl:if>
			<xsl:if test="runbal_cleared">
				<runbal_cleared>
					<xsl:value-of select="runbal_cleared" />
				</runbal_cleared>
			</xsl:if>
			<xsl:if test="cheque_number">
				<cheque_number>
					<xsl:value-of select="cheque_number" />
				</cheque_number>
			</xsl:if>
			<xsl:if test="branch_teller">
				<branch_teller>
					<xsl:value-of select="branch_teller" />
				</branch_teller>
			</xsl:if>
			<xsl:if test="reference_1">
				<reference_1>
					<xsl:value-of select="reference_1" />
				</reference_1>
			</xsl:if>
			<xsl:if test="reference_2">
				<reference_2>
					<xsl:value-of select="reference_2" />
				</reference_2>
			</xsl:if>
			<xsl:if test="reference_3">
				<reference_3>
					<xsl:value-of select="reference_3" />
				</reference_3>
			</xsl:if>
			<xsl:if test="reference_4">
				<reference_4>
					<xsl:value-of select="reference_4" />
				</reference_4>
			</xsl:if>
			<xsl:if test="reference_5">
				<reference_5>
					<xsl:value-of select="reference_5" />
				</reference_5>
			</xsl:if>
		</com.misys.portal.cash.product.ab.common.AccountStatementLine>
	</xsl:template>

</xsl:stylesheet>