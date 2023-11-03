<?xml version="1.0"?>
<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				exclude-result-prefixes="service">

	<xsl:template match="fscm_program_details">
		<result>
	 		<com.misys.portal.systemfeatures.common.FSCMProgramFile>
	 			<xsl:apply-templates select="fscm_program">
	 				<xsl:with-param name="operationType"><xsl:value-of select="./operation_type"/></xsl:with-param>
	 			</xsl:apply-templates>
	 		</com.misys.portal.systemfeatures.common.FSCMProgramFile>
	 	</result>
	</xsl:template>
	
	<xsl:template match="fscm_program">
		<xsl:param name="operationType"/>
		<xsl:variable name="custComp"  select="service:manageCompanyReferencesForStaticData(//customer_reference)"/>
		<xsl:variable name="custCompanyId" select="$custComp/references/company_id"/>
		<xsl:variable name="customerAbbvName" select="$custComp/references/company_name"/>
		<xsl:variable name="bankAbbvName" select="$custComp/references/main_bank_abbv_name"/>
		<xsl:variable name="customerBankReference" select="$custComp/references/customer_bank_reference"/>
		
		<com.misys.portal.systemfeatures.common.FSCMProgram>
			<xsl:if test="$custCompanyId">
				<company_id>
					<xsl:value-of select="$custCompanyId"/>
				</company_id>
			</xsl:if>
			<xsl:if test="brch_code">
				<brch_code>
					<xsl:value-of select="brch_code"/>
				</brch_code>
			</xsl:if>
			<xsl:if test="program_id">
				<program_id>
					<xsl:value-of select="program_id"/>
				</program_id>
			</xsl:if>
			<xsl:if test="program_code">
				<program_code>
					<xsl:value-of select="program_code"/>
				</program_code>
			</xsl:if>
			<xsl:if test="program_name">
				<program_name>
					<xsl:value-of select="program_name"/>
				</program_name>
			</xsl:if>
			<xsl:if test="customer_reference">
				<customer_reference>
					<xsl:value-of select="$customerBankReference"/>
				</customer_reference>
			</xsl:if>
			<xsl:if test="$customerAbbvName">
				<customer_abbv_name>
					<xsl:value-of select="$customerAbbvName"/>
				</customer_abbv_name>
			</xsl:if>
			<xsl:if test="$bankAbbvName">
				<bank_abbv_name>
					<xsl:value-of select="$bankAbbvName"/>
				</bank_abbv_name>
			</xsl:if>
			<xsl:if test="program_type">
				<program_type>
					<xsl:value-of select="program_type"/>
				</program_type>
			</xsl:if>
			<xsl:if test="program_sub_type">
				<program_sub_type>
					<xsl:value-of select="program_sub_type"/>
				</program_sub_type>
			</xsl:if>
			<xsl:if test="sales_reference">
				<sales_reference>
					<xsl:value-of select="sales_reference"/>
				</sales_reference>
			</xsl:if>
			<xsl:if test="status">
				<status>
					<xsl:value-of select="status"/>
				</status>
			</xsl:if>
			<xsl:if test="start_date">
				<start_date>
					<xsl:value-of select="start_date"/>
				</start_date>
			</xsl:if>
			<xsl:if test="expiry_date">
				<expiry_date>
					<xsl:value-of select="expiry_date"/>
				</expiry_date>
			</xsl:if>
			<xsl:if test="narrative">
				<narrative>
					<xsl:value-of select="narrative"/>
				</narrative>
			</xsl:if>
			<xsl:if test="customer_role">
				<customer_role>
					<xsl:value-of select="customer_role"/>
				</customer_role>
			</xsl:if>
			<xsl:if test="anchorparty_role">
				<anchorparty_role>
					<xsl:value-of select="anchorparty_role"/>
				</anchorparty_role>
			</xsl:if>
			<xsl:if test="counterparty_role">
				<counterparty_role>
					<xsl:value-of select="counterparty_role"/>
				</counterparty_role>
			</xsl:if>
			<xsl:if test="invoice_uploaded_by">
				<invoice_uploaded_by>
					<xsl:value-of select="invoice_uploaded_by"/>
				</invoice_uploaded_by>
			</xsl:if>
			<xsl:if test="invoice_submitted_by">
				<invoice_submitted_by>
					<xsl:value-of select="invoice_submitted_by"/>
				</invoice_submitted_by>
			</xsl:if>
			<xsl:if test="buyer_acceptance_required">
				<buyer_acceptance_required>
					<xsl:value-of select="buyer_acceptance_required"/>
				</buyer_acceptance_required>
			</xsl:if>
			<xsl:if test="finance_requested_by">
				<finance_requested_by>
					<xsl:value-of select="finance_requested_by"/>
				</finance_requested_by>
			</xsl:if>
			<xsl:if test="finance_debit_party">
				<finance_debit_party>
					<xsl:value-of select="finance_debit_party"/>
				</finance_debit_party>
			</xsl:if>
			<xsl:if test="finance_credit_party">
				<finance_credit_party>
					<xsl:value-of select="finance_credit_party"/>
				</finance_credit_party>
			</xsl:if>
			<xsl:if test="invoice_settled_by">
				<invoice_settled_by>
					<xsl:value-of select="invoice_settled_by"/>
				</invoice_settled_by>
			</xsl:if>
			<xsl:if test="principal_risk_party">
				<principal_risk_party>
					<xsl:value-of select="principal_risk_party"/>
				</principal_risk_party>
			</xsl:if>
			<xsl:if test="multiple_finance_allowed">
				<multiple_finance_allowed>
					<xsl:value-of select="multiple_finance_allowed"/>
				</multiple_finance_allowed>
			</xsl:if>
			<xsl:if test="credit_limit_cur_code">
				<credit_limit_cur_code>
					<xsl:value-of select="credit_limit_cur_code"/>
				</credit_limit_cur_code>
			</xsl:if>
			<xsl:if test="credit_limit">
				<credit_limit>
					<xsl:value-of select="credit_limit"/>
				</credit_limit>
			</xsl:if>
			<xsl:if test="available_amt_cur_code">
				<available_amt_cur_code>
					<xsl:value-of select="available_amt_cur_code"/>
				</available_amt_cur_code>
			</xsl:if>
			<xsl:if test="available_amt">
				<available_amt>
					<xsl:value-of select="available_amt"/>
				</available_amt>
			</xsl:if>
			<xsl:if test="residual_payment_by">
				<residual_payment_by>
					<xsl:value-of select="residual_payment_by"/>
				</residual_payment_by>
			</xsl:if>
			<xsl:if test="created_dttm">
				<created_dttm>
					<xsl:value-of select="created_dttm"/>
				</created_dttm>
			</xsl:if>
			<xsl:if test="modified_dttm">
				<modified_dttm>
					<xsl:value-of select="modified_dttm"/>
				</modified_dttm>
			</xsl:if>
			<xsl:if test="credit_note_submitted_by">
				<credit_note_submitted_by>
					<xsl:value-of select="credit_note_submitted_by"/>
				</credit_note_submitted_by>
			</xsl:if>
			<additional_field name="operation_type" type="string" scope="none">
				<xsl:value-of select="$operationType"/>
			</additional_field>
		</com.misys.portal.systemfeatures.common.FSCMProgram>
	</xsl:template>	
</xsl:stylesheet>