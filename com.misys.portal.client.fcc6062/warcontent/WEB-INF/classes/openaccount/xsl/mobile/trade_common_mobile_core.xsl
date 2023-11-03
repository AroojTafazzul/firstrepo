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
	<xsl:param name="language">en</xsl:param>

	<xsl:template match="lc_tnx_record | ri_tnx_record | li_tnx_record | sg_tnx_record | tf_tnx_record | el_tnx_record | ec_tnx_record | ic_tnx_record | ir_tnx_record | si_tnx_record | sr_tnx_record | bg_tnx_record | ft_tnx_record | br_tnx_record | ln_tnx_record | sw_tnx_record | td_tnx_record | fx_tnx_record | xo_tnx_record | eo_tnx_record | sw_tnx_record | ts_tnx_record | cs_tnx_record | cx_tnx_record | ct_tnx_record | st_tnx_record | se_tnx_record | la_tnx_record | to_tnx_record | sp_tnx_record | fa_tnx_record | bk_tnx_record | po_tnx_record | so_tnx_record | io_tnx_record | tu_tnx_record | ls_tnx_record | ea_tnx_record | cn_tnx_record | in_tnx_record | ip_tnx_record | io_tnx_record">
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
	
	<sections>
			<label>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')" />
			</label>
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
	</sections>
	
	<xsl:if test="product_code[.='LC' or .='BG' or .='SG' or .='SI' or .='TF' or .='FT']">
		<sections>
			<label>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_APPLICANT_DETAILS')" />
			</label>
			<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'ENTITY_LABEL')"/>
								<xsl:with-param name="value" select="entity"/>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
								<xsl:with-param name="value" select="applicant_name"/>
			</xsl:call-template>
		</sections>
	</xsl:if>
	
	<xsl:if test="product_code[.='LC' or .='BG' or .='SG' or .='SI']">
		<sections>
			<label>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')" />
			</label>
			<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
								<xsl:with-param name="value" select="beneficiary_name"/>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
								<xsl:with-param name="value" select="beneficiary_country"/>
			</xsl:call-template>
		</sections>
	</xsl:if>
	<xsl:if test="product_code[.='IP']">
		<sections>
				<label>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BUYER_DETAILS')" />
				</label>
		<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'ENTITY_LABEL')"/>
								<xsl:with-param name="value" select="entity"/>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
								<xsl:with-param name="value" select="buyer_name"/>
			</xsl:call-template>
		</sections>
		<sections>
				<label>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SELLER_DETAILS')" />
				</label>
		<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
								<xsl:with-param name="value" select="seller_name"/>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
								<xsl:with-param name="value" select="seller_country"/>
			</xsl:call-template>
		</sections>
	</xsl:if>
	<xsl:if test="product_code[.='IN' or .='CN' or .='IO']">
		<sections>
				<label>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SELLER_DETAILS')" />
				</label>
		<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'ENTITY_LABEL')"/>
								<xsl:with-param name="value" select="entity"/>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
								<xsl:with-param name="value" select="seller_name"/>
			</xsl:call-template>
		</sections>
		<sections>
				<label>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BUYER_DETAILS')" />
				</label>
		<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
								<xsl:with-param name="value" select="buyer_name"/>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
								<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
								<xsl:with-param name="value" select="buyer_country"/>
			</xsl:call-template>
		</sections>
	</xsl:if>
	<xsl:if test="product_code[.='EC']">
		<sections>
			<label>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DRAWER_DETAILS')" />
			</label>
			<xsl:call-template name="mobile-field">
					<xsl:with-param name="label" select="localization:getGTPString($language, 'ENTITY_LABEL')"/>
					<xsl:with-param name="value" select="entity"/>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
					<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
					<xsl:with-param name="value" select="drawer_name"/>
			</xsl:call-template>
		</sections>
		
		<sections>
			<label>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DRAWEE_DETAILS')" />
			</label>
			<xsl:call-template name="mobile-field">
					<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
					<xsl:with-param name="value" select="drawee_name"/>
			</xsl:call-template>
				<xsl:call-template name="mobile-field">
					<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
					<xsl:with-param name="value" select="drawee_country"/>
				</xsl:call-template>
		</sections>
	</xsl:if>
	<xsl:if test="product_code[.='EC' or .='FT' or .='CN']">
	<sections>
			<label>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BANK_DETAILS')" />
			</label>
			<xsl:call-template name="mobile-field">
					<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
					<xsl:with-param name="value" select="issuing_bank_abbv_name"/>
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
					<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CUST_REFERENCE')"/>
					<xsl:with-param name="value" select="issuing_bank_customer_reference"/>
			</xsl:call-template>
	</sections>
	</xsl:if>
	<xsl:if test="product_code[.='TF' or .='SG' or .='SI']">
		<xsl:choose>
			<xsl:when test="product_code[.='TF']">
				<label>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_FINANCING_BANK')" />
				</label>
			</xsl:when>
			<xsl:otherwise>
				<label>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ISSUING_BANK')" />
				</label>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:call-template name="mobile-field">
					<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_FINANCING_BANK')"/>
					<xsl:with-param name="value" select="remitting_bank_abbv_name"/>
		</xsl:call-template>
				<xsl:call-template name="mobile-field">
					<xsl:with-param name="label" select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CUST_REFERENCE')"/>
					<xsl:with-param name="value" select="remitting_bank_customer_reference"/>
		</xsl:call-template>
	</xsl:if>
	
	<sections>
		<label>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_DETAILS')" />
		</label>
		<xsl:call-template name="mobile-field">
				<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TRANSFER')"/></xsl:with-param>	
				<xsl:with-param name="value">
				<xsl:choose>
					<xsl:when test="product_code[.='LC' or .='SI']">
						<xsl:value-of select="lc_cur_code"/>&nbsp;<xsl:value-of select="lc_amt"/>
					</xsl:when>
					<xsl:when test="product_code[.='BG']">	
						<xsl:value-of select="bg_cur_code"/>&nbsp;<xsl:value-of select="bg_amt"/>
					</xsl:when>
					<xsl:when test="product_code[.='EC']">
						<xsl:value-of select="ec_cur_code"/>&nbsp;<xsl:value-of select="ec_amt"/>
					</xsl:when>
					<xsl:when test="product_code[.='SG']">
						<xsl:value-of select="sg_cur_code"/>&nbsp;<xsl:value-of select="sg_amt"/>
					</xsl:when>
					<xsl:when test="product_code[.='FT']">
						<xsl:value-of select="ft_cur_code"/>&nbsp;<xsl:value-of select="ft_amt"/>
					</xsl:when>
					<xsl:when test="product_code[.='CN']">
						<xsl:value-of select="cn_cur_code"/>&nbsp;<xsl:value-of select="cn_amt"/>
					</xsl:when>
					<xsl:when test="product_code[.='IN' or .='IP' or .='IO']">
						<xsl:value-of select="total_cur_code"/>&nbsp;<xsl:value-of select="total_amt"/>
					</xsl:when>
				</xsl:choose>
				</xsl:with-param> 
			</xsl:call-template>
		<xsl:call-template name="mobile-field">
				<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/></xsl:with-param>	
				<xsl:with-param name="value"><xsl:value-of select="cust_ref_id"/></xsl:with-param> 
		</xsl:call-template>
	</sections>
	
	<xsl:if test="product_code[.='BG']">
		<sections>
			<label>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GTEE_DETAILS')" />
			</label>
		<xsl:call-template name="mobile-field">
			<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_LABEL')"/></xsl:with-param>	
			<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'C011', bg_type_code)"/></xsl:with-param> 
		</xsl:call-template>
		<xsl:call-template name="mobile-field">
				<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_LABEL')"/></xsl:with-param>	
				<xsl:with-param name="value"><xsl:value-of select="bg_text_type_code"/></xsl:with-param> 
		</xsl:call-template>
		</sections>
	</xsl:if>
	
	<xsl:if test="product_code[.='SI']">
		<sections>
			<label>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_STANDBY_LC_DETAILS')" />
			</label>
		<xsl:call-template name="mobile-field">
			<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'STANDBY_ISSUED_TYPE')"/></xsl:with-param>	
			<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N805', product_type_code)"/></xsl:with-param> 
		</xsl:call-template>
		<xsl:call-template name="mobile-field">
				<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_RULES_LABEL')"/></xsl:with-param>	
				<xsl:with-param name="value"><xsl:value-of select="standby_rule_code"/></xsl:with-param> 
		</xsl:call-template>
		</sections>
	</xsl:if>
	
	</xsl:template>
	<xsl:template name="mobile-field">
		<xsl:param name="label"></xsl:param>
		<xsl:param name="value"></xsl:param>
		<object>
			<label>
				<xsl:value-of select="$label" />
			</label>
			<value>
				<xsl:value-of select="$value" />
			</value>
		</object>
	</xsl:template>
</xsl:stylesheet>