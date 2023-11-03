<?xml version="1.0" encoding="UTF-8"?>
<!--
		Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com), All
		Rights Reserved.
	-->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:localization="xalan://com.misys.portal.common.localization.Localization" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>

	<xsl:template match="la_tnx_record">
		<!-- HEADER-->
		
		<!-- BODY-->
		
	<xsl:call-template name="header"/>
    <xsl:call-template name="body"/>
  </xsl:template>
<xsl:template name="header">
    <fo:static-content flow-name="xsl-region-before">
			<xsl:call-template name="header_recipient_bank"/>
		</fo:static-content>
  </xsl:template>
  <xsl:template name="body">
    <fo:flow flow-name="xsl-region-body" font-size="{$pdfFontSize}">
			<!-- Part 1.0 -->
			<xsl:call-template name="disclammer_template"/>

			<!-- Part 2.0: General Details -->
			<fo:block id="generalDetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- Syst ID -->
					<xsl:if test="ref_id[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="ref_id"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- TODO Customer Reference -->
					
					<!-- Application date -->
					<xsl:if test="tnx_val_date[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="tnx_val_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- What else ? -->
					
					<!-- Part 2.1: Issuing Bank -->
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ISSUING_BANK')"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- Issuing bank name -->
					<xsl:if test="issuing_bank/name[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="issuing_bank/name"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<!-- Part 3: Request for quote -->
			<fo:block id="requestQuote"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REQUEST_FOR_QUOTE_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- td currency / amount -->
					<xsl:if test="la_amt[. != ''] and la_cur_code[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_LA_AMOUNT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="concat(la_cur_code, ' ', la_amt)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- value date -->
					<xsl:if test="value_date[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_LA_VALUE_DATE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="value_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- value date -->
					<xsl:if test="maturity_date[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_LA_MATURITY_DATE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="maturity_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<!-- Part 4: Contract Details -->
			<fo:block id="contractDetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONTRACT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- Transaction number -->
					<xsl:if test="trade_id[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LA_TRADE_ID_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="trade_id"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Deal number -->
					<xsl:if test="bo_ref_id[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bo_ref_id"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Rate -->
					<xsl:if test="rate[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_LA_RATE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="rate"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Interest -->
					<xsl:if test="interest[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_LA_INTEREST_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="interest"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:element name="fo:block">
				<xsl:attribute name="font-size">1pt</xsl:attribute>
				<xsl:attribute name="id">
                    <xsl:value-of select="concat('LastPage_',../@section)"/>
                </xsl:attribute>
			</xsl:element>
		</fo:flow>
  </xsl:template>
</xsl:stylesheet>
