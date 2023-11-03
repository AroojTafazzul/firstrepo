<?xml version="1.0" encoding="UTF-8"?>
<!-- ########################################################## Templates 
	for displaying transaction summaries. Copyright (c) 2000-2008 Misys (http://www.misys.com), 
	All Rights Reserved. version: 1.0 date: 12/03/08 author: Cormac Flynn email: 
	cormac.flynn@misys.com ########################################################## -->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="localization converttools xmlRender defaultresource security">

	<xsl:output method="xml" indent="yes" />
	<xsl:param name="rundata"/>
	<xsl:param name="language"/>

		<xsl:template name="key-details">
			<key_details>
				<ref_id>
					<xsl:value-of select="ref_id"/>
				</ref_id>
				<tnx_id>
					<xsl:value-of select="tnx_id"/>
				</tnx_id>
				<productcode>
					<xsl:value-of select="product_code"/>
				</productcode>
				<subproductcode>
					<xsl:value-of select="sub_product_code"/>
				</subproductcode>
				<tnxtype>
					"<xsl:value-of select="tnx_type_code"/>"
				</tnxtype>
				<token>
					<xsl:value-of select="token"/>
				</token>
				<list_keys>
					<xsl:value-of select="list_keys"/>
				</list_keys>
			</key_details>
		</xsl:template>
		<xsl:template name="common-general-details">
			<xsl:call-template name="mobile-field">
						<xsl:with-param name="label"
							select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')" />
						<xsl:with-param name="value" select="ref_id" />
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
					<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')" />
					<xsl:with-param name="value">
						<xsl:value-of select="bo_ref_id" />
					</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
					<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_CODE')" />
					<xsl:with-param name="value" select="localization:getDecode($language, 'N001', product_code)" />
				</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')" />
				<xsl:with-param name="value" select="appl_date" />
			</xsl:call-template>
		</xsl:template>
	
		<xsl:template name="applicant-details">
			<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'ENTITY_LABEL')"/>
								<xsl:with-param name="value" select="entity"/>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
								<xsl:with-param name="value" select="applicant_name"/>
			</xsl:call-template>
		</xsl:template>
	

		<xsl:template name="issuing-bank-details">
				<xsl:call-template name="mobile-field">
						<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
						<xsl:with-param name="value" select="issuing_bank_abbv_name"/>
				</xsl:call-template>
				<xsl:call-template name="mobile-field">
						<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CUST_REFERENCE')"/>
						<xsl:with-param name="value" select="issuing_bank_customer_reference"/>
				</xsl:call-template>
		</xsl:template>
		
		<xsl:template name="ft-transfer-payment-details">
			<xsl:call-template name="mobile-field">
						<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_CONTRACT_FX_TYPE_LABEL')"/>
						<xsl:with-param name="value" select="localization:getDecode($language, 'N029', ft_type[.])"/>
			</xsl:call-template>
			<xsl:if test="sub_product_code[.='TRINT']">
				<xsl:call-template name="mobile-field">
							<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ORDERING_ACT_NO')"/>
							<xsl:with-param name="value" select="applicant_act_no"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="mobile-field">
						<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_CCY_AND_AMT')"/></xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="ft_cur_code"/>&nbsp;<xsl:value-of select="ft_amt"/></xsl:with-param>
			</xsl:call-template>
			<xsl:if test="sub_product_code[.='TRINT']">
				<xsl:call-template name="mobile-field">
							<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_FT_DEAL_SUMMARY_LABEL_TRANSFERT_CURRENCY_AMOUNT')"/></xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/>&nbsp;<xsl:value-of select="counterparties/counterparty/counterparty_amt"/></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="sub_product_code[.='TRTPT']">
				<xsl:call-template name="mobile-field">
							<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_TREASURY_PAYMENT_AMT_LABEL')"/></xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="payment_cur_code"/>&nbsp;<xsl:value-of select="payment_amt"/></xsl:with-param>
				</xsl:call-template>
			</xsl:if>	
			<xsl:call-template name="mobile-field">
						<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FT_REQUEST_DATE_LABEL')"/></xsl:with-param>
						<xsl:with-param name="value" select="iss_date"/>
			</xsl:call-template>
		</xsl:template>
		
		<xsl:template name="ft-settlement-details">
			<xsl:call-template name="mobile-field">
						<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_SETTLEMENT_DETAILS_BENEFICIARY_DETAILS')"/>
						<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='02']/counterparty_reference"/>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
						<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_SETTLEMENT_DETAILS_BENEFICIARY_ACCOUNT')"/>
						<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='02']/counterparty_act_no"/>
			</xsl:call-template>
		</xsl:template>
		
		<xsl:template name="td-trtd-details">
			<xsl:call-template name="mobile-field">
						<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_FT_AMT_LABEL')"/></xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="input_td_cur_code"/>&nbsp;<xsl:value-of select="input_td_amt"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
						<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FT_REQUEST_DATE_LABEL')"/></xsl:with-param>
						<xsl:with-param name="value" select="input_value_date"/>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
						<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FT_REQUEST_DATE_LABEL')"/></xsl:with-param>
						<xsl:with-param name="value" select="input_maturity_date"/>
			</xsl:call-template>
		</xsl:template>
		
		<xsl:template name="return-comments">
			<xsl:call-template name="mobile-field">
					<xsl:with-param name="value" select="return_comments"/>
					<xsl:with-param name="mobile-textarea">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:template>
		
     	<xsl:template name="mobile-field">
			<xsl:param name="label"></xsl:param>
			<xsl:param name="value"></xsl:param>
			<xsl:param name="mobile-textarea"></xsl:param>
			<object>
				<label>
					<xsl:value-of select="$label" />
				</label>
				<value>
					<xsl:value-of select="$value" />
				</value>
				<xsl:if test="$mobile-textarea = 'Y'">
					<mobileTextareaContent>true</mobileTextareaContent>
				</xsl:if>
			</object>
		</xsl:template>
</xsl:stylesheet>