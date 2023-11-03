<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Copyright (c) 2000-2012 Misys (http://www.misys.com), All 
		Rights Reserved. -->
	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<!-- Process STATIC ACCOUNT -->
	<xsl:template match="static_account">
		<result>
			<com.misys.portal.cash.product.ab.common.Account>
				<!-- keys must be attributes -->
				<xsl:attribute name="account_id"><xsl:value-of select="account_id" /></xsl:attribute>
				<brch_code>
					<xsl:value-of select="brch_code" />
				</brch_code>
                <additional_field name="entity" type="string" scope="none" description="">
                    <xsl:value-of select="entity"/>
                </additional_field>
				<account_no>
					<xsl:value-of select="account_no" />
				</account_no>
				<description>
					<xsl:value-of select="description" />
				</description>
				<account_type>
					<xsl:value-of select="account_type" />
				</account_type>
				<iso_code>
					<xsl:value-of select="iso_code" />
				</iso_code>
				<bank_name>
					<xsl:value-of select="bank_name" />
				</bank_name>
				<cur_code>
					<xsl:value-of select="account_cur_code" />
				</cur_code>
				<address_line_1>
					<xsl:value-of select="address_line_1" />
				</address_line_1>
				<address_line_2>
					<xsl:value-of select="address_line_2" />
				</address_line_2>
				<dom>
					<xsl:value-of select="dom" />
				</dom>
				<country>
					<xsl:value-of select="country" />
				</country>
				<xsl:if test="format">
					<format>
						<xsl:value-of select="format" />
					</format>
				</xsl:if>
				<bank_address_line_1>
					<xsl:value-of select="bank_address_line_1" />
				</bank_address_line_1>
				<bank_address_line_2>
					<xsl:value-of select="bank_address_line_2" />
				</bank_address_line_2>
				<bank_dom>
					<xsl:value-of select="bank_dom" />
				</bank_dom>
				<xsl:if test="erp_id">
					<additional_field name="erp_id" type="string"
						scope="master">
						<xsl:value-of select="erp_id" />
					</additional_field>
				</xsl:if>
				<xsl:if test="pre_approved">
					<additional_field name="pre_approved" type="string"
						scope="master">
						<xsl:value-of select="pre_approved" />
					</additional_field>
				</xsl:if>
				<xsl:if test="threshold_cur_code">
					<additional_field name="threshold_cur_code" type="string"
						scope="master">
						<xsl:value-of select="threshold_cur_code" />
					</additional_field>
				</xsl:if>
				<xsl:if test="threshold_amt">
					<additional_field name="threshold_amt" type="string"
						scope="master">
						<xsl:value-of select="threshold_amt" />
					</additional_field>
				</xsl:if>
				<xsl:if test="email_1">
					<additional_field name="email_1" type="string"
						scope="master">
						<xsl:value-of select="email_1" />
					</additional_field>
				</xsl:if>
				<!-- Fields need to persist when the account type is IAFT for transaction purpose -->
				<xsl:if test="bo_account_id">
					<additional_field name="bo_account_id" type="string"
						scope="master">
						<xsl:value-of select="bo_account_id" />
					</additional_field>
				</xsl:if>
				<xsl:if test="bo_account_type">
					<additional_field name="bo_account_type" type="string"
						scope="master">
						<xsl:value-of select="bo_account_type" />
					</additional_field>
				</xsl:if>
				<xsl:if test="bo_account_currency">
					<additional_field name="bo_account_currency" type="string"
						scope="master">
						<xsl:value-of select="bo_account_currency" />
					</additional_field>
				</xsl:if>
				<xsl:if test="bo_branch_code">
					<additional_field name="bo_branch_code" type="string"
						scope="master">
						<xsl:value-of select="bo_branch_code" />
					</additional_field>
				</xsl:if>
				<xsl:if test="bo_product_type">
					<additional_field name="bo_product_type" type="string"
						scope="master">
						<xsl:value-of select="bo_product_type" />
					</additional_field>
				</xsl:if>
				<!-- Addendum Fields -->
				<xsl:if test="beneficiary_id">
					<additional_field name="beneficiary_id" type="string"
						scope="master">
						<xsl:value-of select="beneficiary_id" />
					</additional_field>
				</xsl:if>
				<xsl:if test="mailing_name">
					<additional_field name="mailing_name" type="string"
						scope="master">
						<xsl:value-of select="mailing_name" />
					</additional_field>
				</xsl:if>
				<xsl:if test="mailing_address_line_1">
					<additional_field name="mailing_address_line_1" type="string"
						scope="master">
						<xsl:value-of select="mailing_address_line_1" />
					</additional_field>
				</xsl:if>
				<xsl:if test="mailing_address_line_2">
					<additional_field name="mailing_address_line_2" type="string"
						scope="master">
						<xsl:value-of select="mailing_address_line_2" />
					</additional_field>
				</xsl:if>
				<xsl:if test="mailing_address_line_3">
					<additional_field name="mailing_address_line_3" type="string"
						scope="master">
						<xsl:value-of select="mailing_address_line_3" />
					</additional_field>
				</xsl:if>
				<xsl:if test="mailing_address_line_4">
					<additional_field name="mailing_address_line_4" type="string"
						scope="master">
						<xsl:value-of select="mailing_address_line_4" />
					</additional_field>
				</xsl:if>
				<xsl:if test="mailing_address_line_5">
					<additional_field name="mailing_address_line_5" type="string"
						scope="master">
						<xsl:value-of select="mailing_address_line_5" />
					</additional_field>
				</xsl:if>
				<xsl:if test="mailing_address_line_6">
					<additional_field name="mailing_address_line_6" type="string"
						scope="master">
						<xsl:value-of select="mailing_address_line_6" />
					</additional_field>
				</xsl:if>
				<xsl:if test="postal_code">
					<additional_field name="postal_code" type="string"
						scope="master">
						<xsl:value-of select="postal_code" />
					</additional_field>
				</xsl:if>
				<xsl:if test="beneficiary_country">
					<additional_field name="beneficiary_country" type="string"
						scope="master">
						<xsl:value-of select="beneficiary_country" />
					</additional_field>
				</xsl:if>
				<xsl:if test="email_2">
					<additional_field name="email_2" type="string"
						scope="master">
						<xsl:value-of select="email_2" />
					</additional_field>
				</xsl:if>
				<xsl:if test="fax">
					<additional_field name="fax" type="string"
						scope="master">
						<xsl:value-of select="fax" />
					</additional_field>
				</xsl:if>
				<xsl:if test="ivr">
					<additional_field name="ivr" type="string"
						scope="master">
						<xsl:value-of select="ivr" />
					</additional_field>
				</xsl:if>
				<xsl:if test="phone">
					<additional_field name="phone" type="string"
						scope="master">
						<xsl:value-of select="phone" />
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_details_postal_code">
					<additional_field name="bene_details_postal_code" type="string"
						scope="master">
						<xsl:value-of select="bene_details_postal_code" />
					</additional_field>
				</xsl:if>
				<xsl:if test="bene_details_country">
					<additional_field name="bene_details_country" type="string"
						scope="master">
						<xsl:value-of select="bene_details_country" />
					</additional_field>
				</xsl:if>
			
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.cash.product.ab.common.Account>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
