<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Process ACCOUNT-->
	<xsl:template match="account_management">
		<result>
			<com.misys.portal.cash.product.ab.common.Account>
			
			<brch_code><xsl:value-of select="brch_code"/></brch_code>
			<company_id><xsl:value-of select="company_id"/></company_id>
			<account_no><xsl:value-of select="account_no"/></account_no>
						
			<xsl:if test="account_id">
				<account_id>
					<xsl:value-of select="account_id"/>
				</account_id>
			</xsl:if>
			
			<entity><xsl:value-of select="entity"/></entity>
			<xsl:if test="description">
				<description>
					<xsl:value-of select="description"/>
				</description>
			</xsl:if>
			<xsl:if test="type">
				<type>
					<xsl:value-of select="type"/>
				</type>
			</xsl:if>
			<xsl:if test="format">
				<format>
					<xsl:value-of select="format"/>
				</format>
			</xsl:if>
			<xsl:if test="owner_type">
				<owner_type>
					<xsl:value-of select="owner_type"/>
				</owner_type>
			</xsl:if>
			<xsl:if test="iso_code">
				<iso_code>
					<xsl:value-of select="iso_code"/>
				</iso_code>
			</xsl:if>
			<xsl:if test="account_name">
				<name>
					<xsl:value-of select="account_name"/>
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
			<xsl:if test="bank_country">
				<country>
					<xsl:value-of select="bank_country"/>
				</country>
			</xsl:if>
			<xsl:if test="bank_name">
				<bank_name>
					<xsl:value-of select="bank_name"/>
				</bank_name>
			</xsl:if>
			<xsl:if test="bank_address_line_1">
				<bank_address_line_1>
					<xsl:value-of select="bank_address_line_1"/>
				</bank_address_line_1>
			</xsl:if>
			<xsl:if test="bank_address_line_2">
				<bank_address_line_2>
					<xsl:value-of select="bank_address_line_2"/>
				</bank_address_line_2>
			</xsl:if>
			<xsl:if test="bank_dom">
				<bank_dom>
					<xsl:value-of select="bank_dom"/>
				</bank_dom>
			</xsl:if>
			<xsl:if test="currency_cur_code">
				<cur_code>
					<xsl:value-of select="currency_cur_code"/>
				</cur_code>
			</xsl:if>
			<xsl:if test="routing_bic">
				<routing_bic>
					<xsl:value-of select="routing_bic"/>
				</routing_bic>
			</xsl:if>
			<xsl:if test="branch_no">
				<branch_no>
					<xsl:value-of select="branch_no"/>
				</branch_no>
			</xsl:if>
			<xsl:if test="overdraft_limit">
				<overdraft_limit>
					<xsl:value-of select="overdraft_limit"/>
				</overdraft_limit>
			</xsl:if>
			<xsl:if test="interest_rate">
				<interest_rate>
					<xsl:value-of select="interest_rate"/>
				</interest_rate>
			</xsl:if>
			<xsl:if test="interest_rate_maturity">
				<interest_rate_maturity>
					<xsl:value-of select="interest_rate_maturity"/>
				</interest_rate_maturity>
			</xsl:if>
			<xsl:if test="interest_rate_credit">
				<interest_rate_credit>
					<xsl:value-of select="interest_rate_credit"/>
				</interest_rate_credit>
			</xsl:if>
			<xsl:if test="interest_rate_debit">
				<interest_rate_debit>
					<xsl:value-of select="interest_rate_debit"/>
				</interest_rate_debit>
			</xsl:if>
			<xsl:if test="principal_amount">
				<principal_amount>
					<xsl:value-of select="principal_amount"/>
				</principal_amount>
			</xsl:if>
			<xsl:if test="maturity_amount">
				<maturity_amount>
					<xsl:value-of select="maturity_amount"/>
				</maturity_amount>
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
			<xsl:if test="actv_flag">
				<actv_flag>
					<xsl:value-of select="actv_flag"/>
				</actv_flag>
			</xsl:if>
			<xsl:if test="bo_cust_number">
				<bo_cust_number>
					<xsl:value-of select="bo_cust_number"/>
				</bo_cust_number>
			</xsl:if>
			
			<xsl:if test="bank_chips_uid">
				<bank_chips_uid>
					<xsl:value-of select="bank_chips_uid"/>
				</bank_chips_uid>
			</xsl:if>
			<xsl:if test="intermediary_bank_country">
				<intermediary_country>
					<xsl:value-of select="intermediary_bank_country"/>
				</intermediary_country>
			</xsl:if>
			<xsl:if test="intermediary_bank_name">
				<intermediary_bank_name>
					<xsl:value-of select="intermediary_bank_name"/>
				</intermediary_bank_name>
			</xsl:if>
			<xsl:if test="intermediary_branch_no">
				<intermediary_branch_no>
					<xsl:value-of select="intermediary_branch_no"/>
				</intermediary_branch_no>
			</xsl:if>
			<xsl:if test="intermediary_chips_uid">
				<intermediary_chips_uid>
					<xsl:value-of select="intermediary_chips_uid"/>
				</intermediary_chips_uid>
			</xsl:if>
			<xsl:if test="intermed_bank_address_line_1">
				<intermed_bank_address_line_1>
					<xsl:value-of select="intermed_bank_address_line_1"/>
				</intermed_bank_address_line_1>
			</xsl:if>
			<xsl:if test="intermed_bank_address_line_2">
				<intermed_bank_address_line_2>
					<xsl:value-of select="intermed_bank_address_line_2"/>
				</intermed_bank_address_line_2>
			</xsl:if>
			<xsl:if test="intermediary_bank_dom">
				<intermediary_bank_dom>
					<xsl:value-of select="intermediary_bank_dom"/>
				</intermediary_bank_dom>
			</xsl:if>
			<xsl:if test="email">
				<email>
					<xsl:value-of select="email"/>
				</email>
			</xsl:if>
			<xsl:if test="max_transfert_amt">
				<max_transfer_limit>
					<xsl:value-of select="max_transfert_amt"/>
				</max_transfer_limit>
			</xsl:if>
			<nickname>
				   <xsl:value-of select="nickname"></xsl:value-of>
			</nickname>
		
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.cash.product.ab.common.Account>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
