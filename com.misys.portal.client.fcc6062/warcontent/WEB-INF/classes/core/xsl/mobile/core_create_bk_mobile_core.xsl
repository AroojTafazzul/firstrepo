<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:collabutils="xalan://com.misys.portal.common.tools.CollaborationUtils"
	exclude-result-prefixes="xmlRender localization ftProcessing securitycheck utils security defaultresource collabutils">
	<!-- <xsl:import href='trade_common_mobile_core.xsl' /> -->
	<xsl:param name="language">en</xsl:param>
	
	<xsl:include href="../../../cash/xsl/mobile/common/cash_common_mobile.xsl"/>
	<xsl:output method="xml" indent="yes" />
	
	<xsl:template match="/">
		<xsl:apply-templates select="bk_tnx_record"/>
	</xsl:template>
	
	<xsl:template match="bk_tnx_record">
		<xsl:call-template name="key-details"/>
		<sections>
			<label>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')" />
			</label>
			<xsl:call-template name="common-general-details"/>
		</sections>
		<xsl:if test="return_comments[.!='']">
			<sections>
				<label>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@return_comments')" />
				</label>
				<xsl:call-template name="return-comments"/>
				<xsl:call-template name="mobile-field">
						<xsl:with-param name="label"></xsl:with-param>
						<xsl:with-param name="value"></xsl:with-param>
				</xsl:call-template>	
			</sections>
		</xsl:if>
		<sections>
			<label>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_DETAILS')" />
			</label>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_BK_AMT_LABEL')"/></xsl:with-param>	
				<xsl:with-param name="value"><xsl:value-of select="bk_cur_code"/>&nbsp;<xsl:value-of select="bk_total_amt"/></xsl:with-param> 
			</xsl:call-template>
			<xsl:call-template name="mobile-field">
				<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_BK_HIGHEST_AMT')"/></xsl:with-param>	
				<xsl:with-param name="value"><xsl:value-of select="bk_cur_code"/>&nbsp;<xsl:value-of select="bk_highest_amt"/></xsl:with-param> 
			</xsl:call-template>	
		</sections>
	</xsl:template>
</xsl:stylesheet>