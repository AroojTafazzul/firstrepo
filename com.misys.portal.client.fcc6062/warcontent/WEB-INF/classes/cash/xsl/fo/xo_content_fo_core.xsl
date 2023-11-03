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

	<xsl:template match="xo_tnx_record">
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
			
			<!-- Part 3: Contract Details -->
			<fo:block id="contractDetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONTRACT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- Purchase/Sale -->
					<xsl:if test="contract_type[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="contract_type[. = '01']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_SALE_LABEL')"/>
									</xsl:when>
									<xsl:when test="contract_type[. = '02']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_PURCHASE_LABEL')"/>
									</xsl:when>
									<xsl:when test="contract_type[. = '03']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_CONTACT_LABEL')"/>
									</xsl:when>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Expiration code -->
					<xsl:if test="expiration_code[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_XO_EXPIRATION_CODE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getDecode($language, 'N412', expiration_code[.])"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Expiration date -->
					<xsl:if test="expiration_date[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_XO_EXPIRATION_DATE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="expiration_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="expiration_date_term_number[. != ''] or expiration_date_term_code[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_VALUE_DATE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="concat(expiration_date_term_number, ' ', localization:getDecode($language, 'N413', expiration_date_term_code[.]))"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Counter currency -->
					<xsl:if test="counter_cur_code[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_SETTLEMENT_CURRENCY_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="counter_cur_code"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Currency amount -->
					<xsl:if test="fx_cur_code[. != ''] and fx_amt[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_AMOUNT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="concat(fx_cur_code, ' ', fx_amt)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- value date -->
					<xsl:if test="value_date[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_VALUE_DATE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="value_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="value_date_term_number[. != ''] or value_date_term_code[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_VALUE_DATE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="concat(value_date_term_number, ' ', localization:getDecode($language, 'N413', value_date_term_code[.]))"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Market order -->
					<xsl:if test="market_order[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_XO_MARKET_ORDER_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="market_order[. = 'Y']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Trigger position -->
					<xsl:if test="trigger_pos[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_XO_TRIGGER_POS_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="trigger_pos"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Trigger Stop -->
					<xsl:if test="trigger_stop[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_XO_TRIGGER_STOP_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="trigger_stop"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Trigger Limit -->
					<xsl:if test="trigger_limit[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_XO_TRIGGER_LIMIT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="trigger_limit"/>
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
