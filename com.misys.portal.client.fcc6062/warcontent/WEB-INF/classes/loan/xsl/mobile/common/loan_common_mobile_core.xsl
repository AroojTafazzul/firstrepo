<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to all 

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      10/15/10
author:    Pascal Marzin
email:     Pascal.Marzin@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	exclude-result-prefixes="localization utils">
	
	<xsl:output method="xml" omit-xml-declaration="yes"/>
	<xsl:param name="language">en</xsl:param>
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
						<xsl:value-of select="tnx_type_code"/>"
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
			<xsl:call-template name='mobile-field'>
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/>
				<xsl:with-param name="value" select="ref_id"/>
			</xsl:call-template>
			
			<xsl:call-template name='mobile-field'>
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID_LN')"/>
				<xsl:with-param name="value" select='bo_ref_id'/>
			</xsl:call-template>
			
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/>
				<xsl:with-param name="value" select="cust_ref_id"/>
			</xsl:call-template>
		</xsl:template>
		
		<xsl:template name="facility-details">
			<xsl:call-template name='mobile-field'>
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_FACILITYDETAILS_DEAL')"/>
				<xsl:with-param name="value" select="bo_deal_name"/>
			</xsl:call-template>
			
			<xsl:call-template name='mobile-field'>
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_FACILITYDETAILS_FACILITY')"/>
				<xsl:with-param name="value" select='bo_facility_name'/>
			</xsl:call-template>
			
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_FACILITYDETAILS_ID')"/>
				<xsl:with-param name="value" select="fcn"/>
			</xsl:call-template>
			<xsl:call-template name='mobile-field'>
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_LOAN_EFFECTIVE_DATE')"/>
				<xsl:with-param name="value" select="facility_effective_date"/>
			</xsl:call-template>
			
			<xsl:call-template name='mobile-field'>
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_DATE')"/>
				<xsl:with-param name="value" select='facility_expiry_date'/>
			</xsl:call-template>
			
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_FACILITY_BORROWER_LIMIT')"/>
				<xsl:with-param name="value" select="borrower_limit"/>
			</xsl:call-template>
			
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_FACILITY_BORROWER_AVAILABLE')"/>
				<xsl:with-param name="value" select="borrower_available"/>
			</xsl:call-template>
		</xsl:template>
		
		<xsl:template name="borrower-details">
			<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'ENTITY_LABEL')"/>
								<xsl:with-param name="value" select="entity"/>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
								<xsl:with-param name="value" select="borrower_name"/>
			</xsl:call-template>
		</xsl:template>
		
		
		<xsl:template name="loan-details">
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')"/>
				<xsl:with-param name="value" select="appl_date"/>
			</xsl:call-template>
			
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_LOAN_EFFECTIVE_DATE')"/>
				<xsl:with-param name="value" select="effective_date"/>
			</xsl:call-template>
			
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_LOAN_AMOUNT')"/>
				<xsl:with-param name="value">
					<xsl:value-of select="ln_cur_code"/>&nbsp;<xsl:value-of select="ln_amt" />
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_LOAN_PRICING_OPTION')"/>
				<xsl:with-param name="value" select="localization:getDecode($language, 'C030', pricing_option)"/>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_LOAN_RISK_TYPE')"/>
				<xsl:with-param name="value" select="localization:getDecode($language,'C032', risk_type)"/>
			</xsl:call-template>
		</xsl:template>
		
		<xsl:template name="loan-payment-details">
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_LOAN_PAYMENT_DATE')"/>
				<xsl:with-param name="value" select="maturity_date"/>
			</xsl:call-template>
			
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_LOAN_PAYMENT_AMT')"/>
				<xsl:with-param name="value"><xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/></xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_LOAN_LIAB_NEW_AMT')"/>
				<xsl:with-param name="value">
					<xsl:value-of select="ln_cur_code"/>&nbsp;<xsl:value-of select="ln_liab_amt" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:template>
		<xsl:template name="loan-increase-details">
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_GENERALDETAILS_LOAN_AMD_DATE')"/>
				<xsl:with-param name="value" select="amd_date"/>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_LOAN_AMEND_INCREASE_AMT')"/>
				<xsl:with-param name="value"><xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_LOAN_LIAB_NEW_AMT')"/>
				<xsl:with-param name="value">
					<xsl:value-of select="ln_cur_code"/>&nbsp;<xsl:value-of select="ln_liab_amt" />
				</xsl:with-param>
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