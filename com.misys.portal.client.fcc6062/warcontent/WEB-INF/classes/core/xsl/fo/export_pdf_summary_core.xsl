<?xml version="1.0" encoding="UTF-8"?>
<!--
		Copyright (c) 2000-2013 Misys (http://www.misys.com), All
		Rights Reserved.
		version 1.0
		base version: 1.6
	-->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:localization="xalan://com.misys.portal.common.localization.Localization" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href="fo_common.xsl"/>
	<xsl:import href="fo_summary.xsl"/>
	<xsl:param name="base_url"/>
	<xsl:param name="systemDate"/>
	<!-- Get the language code -->
	<xsl:param name="language"/>

	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>
	
	<xsl:param name="headerImage">url('<xsl:value-of select="$base_url" />/fo_icons/header.jpg')</xsl:param>
	
	
	
	

	<!--TEMPLATE Main-->
	<xsl:template match="/">
		<fo:root font-family="{$pdfFont}" writing-mode="{$writingMode}" xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<xsl:call-template name="general-layout-master"/>
			<!-- Display summary content -->
			<fo:page-sequence master-reference="Section1-ps">
				<xsl:apply-templates mode="summary" select="child::*[1]"/>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!-- Summary content -->
	<xsl:template match="lc_tnx_record | se_tnx_record | li_tnx_record | sg_tnx_record |  td_tnx_record  | tf_tnx_record | el_tnx_record | ec_tnx_record | ic_tnx_record | si_tnx_record | sr_tnx_record | bg_tnx_record |  br_tnx_record | ft_tnx_record | ir_tnx_record  | po_tnx_record | so_tnx_record | in_tnx_record | xo_tnx_record | fa_tnx_record  | bk_tnx_record | ip_tnx_record | cn_tnx_record | cr_tnx_record | ls_tnx_record | ln_tnx_record | io_tnx_record" mode="summary">


		
		<!-- FOOTER-->
				
		<!-- BODY-->
		
	<xsl:call-template name="header"/>
    <xsl:call-template name="footer"/>
    <xsl:call-template name="body"/>
  </xsl:template>
<xsl:template name="header">
    <fo:static-content flow-name="xsl-region-before">
			<!-- HEADER-->
			<fo:block color="{$backgroundSubtitles3}" font-family="{$pdfFont}">
				<fo:table background-position="top right">
					<xsl:attribute name="background-color">
            <xsl:value-of select="$borderColor"/>
          </xsl:attribute>
					<xsl:attribute name="background-image"><xsl:value-of select="utils:getImagePath($headerImage)"></xsl:value-of></xsl:attribute>

					<fo:table-column column-width="25%"/>
					<fo:table-column column-width="25%"/>
					<fo:table-column column-width="25%"/>
					<fo:table-column column-width="25%"/>
					<fo:table-body>
						<fo:table-row>
							<xsl:choose>
								<xsl:when test="product_code[.='LC' or .='SG' or .='LI' or .='TF' or .='SI' or .='FT' or .='IR' or .='BK' or .='LS' or .='LN']">
																<!-- Bank logo -->
							<fo:table-cell>
								<xsl:call-template name="bank_logo">
        						<xsl:with-param name="bankName" select="issuing_bank/abbv_name" />
								</xsl:call-template>							
							</fo:table-cell>
									<xsl:if test="issuing_bank/name[. != '']">
										<fo:table-cell font-size="8.0pt">
											<fo:block>
												<xsl:value-of select="issuing_bank/name"/>
											</fo:block>
											<xsl:if test="issuing_bank/address_line_1[. != '']">
												<fo:block>
													<xsl:value-of select="issuing_bank/address_line_1"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="issuing_bank/address_line_2[. != '']">
												<fo:block>
													<xsl:value-of select="issuing_bank/address_line_2"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="issuing_bank/dom[. != '']">
												<fo:block>
													<xsl:value-of select="issuing_bank/dom"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="issuing_bank/address_line_4[. != '']">
												<fo:block>
													<xsl:value-of select="issuing_bank/address_line_4"/>
												</fo:block>
											</xsl:if>
										</fo:table-cell>
										<fo:table-cell font-size="8.0pt">
											<xsl:if test="issuing_bank/phone[. != '']">
												<fo:block>
													Tel:
													<xsl:value-of select="issuing_bank/phone"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="issuing_bank/fax[. != '']">
												<fo:block>
													Fax:
													<xsl:value-of select="issuing_bank/fax"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="issuing_bank/telex[. != '']">
												<fo:block>
													Telex:
													<xsl:value-of select="issuing_bank/telex"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="issuing_bank/iso_code[. != '']">
												<fo:block>
													SWIFT:
													<xsl:value-of select="issuing_bank/iso_code"/>
												</fo:block>
											</xsl:if>
											<!-- cell should not be empty -->
											<xsl:if test="issuing_bank/phone[.=''] and issuing_bank/fax[.=''] and issuing_bank/telex[. =''] and issuing_bank/iso_code[. = '']">
												<fo:block>
												</fo:block>
											</xsl:if>
										</fo:table-cell>
									</xsl:if>
								</xsl:when>
								<xsl:when test="product_code[.='EL' or .='SR' or .='BR']">
																								<!-- Bank logo -->
							<fo:table-cell>
								<xsl:call-template name="bank_logo">
        						<xsl:with-param name="bankName" select="advising_bank/abbv_name" />
								</xsl:call-template>							
							</fo:table-cell>
									<xsl:if test="advising_bank/name[. != '']">
										<fo:table-cell font-size="8.0pt">
											<fo:block>
												<xsl:value-of select="advising_bank/name"/>
											</fo:block>
											<xsl:if test="advising_bank/address_line_1[. != '']">
												<fo:block>
													<xsl:value-of select="advising_bank/address_line_1"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="advising_bank/address_line_2[. != '']">
												<fo:block>
													<xsl:value-of select="advising_bank/address_line_2"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="advising_bank/dom[. != '']">
												<fo:block>
													<xsl:value-of select="advising_bank/dom"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="advising_bank/address_line_4[. != '']">
												<fo:block>
													<xsl:value-of select="advising_bank/address_line_4"/>
												</fo:block>
											</xsl:if>
										</fo:table-cell>
										<fo:table-cell font-size="8.0pt">
											<xsl:if test="advising_bank/phone[. != '']">
												<fo:block>
													Tel:
													<xsl:value-of select="advising_bank/phone"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="advising_bank/fax[. != '']">
												<fo:block>
													Fax:
													<xsl:value-of select="advising_bank/fax"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="advising_bank/telex[. != '']">
												<fo:block>
													Telex:
													<xsl:value-of select="advising_bank/telex"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="advising_bank/iso_code[. != '']">
												<fo:block>
													SWIFT:
													<xsl:value-of select="advising_bank/iso_code"/>
												</fo:block>
											</xsl:if>
											<!-- cell should not be empty -->
											<xsl:if test="advising_bank/phone[.=''] and advising_bank/fax[.=''] and advising_bank/telex[. =''] and advising_bank/iso_code[. = '']">
												<fo:block>
												</fo:block>
											</xsl:if>
										</fo:table-cell>
									</xsl:if>
								</xsl:when>
								<xsl:when test="product_code[.='EC' or .='IR']">
							<fo:table-cell>
								<xsl:call-template name="bank_logo">
        						<xsl:with-param name="bankName" select="remitting_bank/abbv_name" />
								</xsl:call-template>							
							</fo:table-cell>
									<xsl:if test="remitting_bank/name[. != '']">
										<fo:table-cell font-size="8.0pt">
											<fo:block>
												<xsl:value-of select="remitting_bank/name"/>
											</fo:block>
											<xsl:if test="remitting_bank/address_line_1[. != '']">
												<fo:block>
													<xsl:value-of select="remitting_bank/address_line_1"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="remitting_bank/address_line_2[. != '']">
												<fo:block>
													<xsl:value-of select="remitting_bank/address_line_2"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="remitting_bank/dom[. != '']">
												<fo:block>
													<xsl:value-of select="remitting_bank/dom"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="remitting_bank/address_line_4[. != '']">
												<fo:block>
													<xsl:value-of select="remitting_bank/address_line_4"/>
												</fo:block>
											</xsl:if>
										</fo:table-cell>
										<fo:table-cell font-size="8.0pt">
											<xsl:if test="remitting_bank/phone[. != '']">
												<fo:block>
													Tel:
													<xsl:value-of select="remitting_bank/phone"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="remitting_bank/fax[. != '']">
												<fo:block>
													Fax:
													<xsl:value-of select="remitting_bank/fax"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="remitting_bank/telex[. != '']">
												<fo:block>
													Telex:
													<xsl:value-of select="remitting_bank/telex"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="remitting_bank/iso_code[. != '']">
												<fo:block>
													SWIFT:
													<xsl:value-of select="remitting_bank/iso_code"/>
												</fo:block>
											</xsl:if>
											<!-- cell should not be empty -->
											<xsl:if test="remitting_bank/phone[.=''] and remitting_bank/fax[.=''] and remitting_bank/telex[. =''] and remitting_bank/iso_code[. = '']">
												<fo:block>
												</fo:block>
											</xsl:if>
										</fo:table-cell>
									</xsl:if>
								</xsl:when>
								<xsl:when test="product_code[.='IC']">
							<fo:table-cell>
								<xsl:call-template name="bank_logo">
        						<xsl:with-param name="bankName" select="presenting_bank/abbv_name" />
								</xsl:call-template>							
							</fo:table-cell>								
									<xsl:if test="presenting_bank/name[. != '']">
										<fo:table-cell font-size="8.0pt">
											<fo:block>
												<xsl:value-of select="presenting_bank/name"/>
											</fo:block>
											<xsl:if test="presenting_bank/address_line_1[. != '']">
												<fo:block>
													<xsl:value-of select="presenting_bank/address_line_1"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="presenting_bank/address_line_2[. != '']">
												<fo:block>
													<xsl:value-of select="presenting_bank/address_line_2"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="presenting_bank/dom[. != '']">
												<fo:block>
													<xsl:value-of select="presenting_bank/dom"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="presenting_bank/address_line_4[. != '']">
												<fo:block>
													<xsl:value-of select="presenting_bank/address_line_4"/>
												</fo:block>
											</xsl:if>
										</fo:table-cell>
										<fo:table-cell font-size="8.0pt">
											<xsl:if test="presenting_bank/phone[. != '']">
												<fo:block>
													Tel:
													<xsl:value-of select="presenting_bank/phone"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="presenting_bank/fax[. != '']">
												<fo:block>
													Fax:
													<xsl:value-of select="presenting_bank/fax"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="presenting_bank/telex[. != '']">
												<fo:block>
													Telex:
													<xsl:value-of select="presenting_bank/telex"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="presenting_bank/iso_code[. != '']">
												<fo:block>
													SWIFT:
													<xsl:value-of select="presenting_bank/iso_code"/>
												</fo:block>
											</xsl:if>
											<!-- cell should not be empty -->
											<xsl:if test="presenting_bank/phone[.=''] and presenting_bank/fax[.=''] and presenting_bank/telex[. =''] and presenting_bank/iso_code[. = '']">
												<fo:block>
												</fo:block>
											</xsl:if>
										</fo:table-cell>
									</xsl:if>
								</xsl:when>
								<xsl:when test="product_code[.='BG']">
							<fo:table-cell>
								<xsl:call-template name="bank_logo">
        						<xsl:with-param name="bankName" select="recipient_bank/abbv_name" />
								</xsl:call-template>							
							</fo:table-cell>	
									<xsl:if test="recipient_bank/name[. != '']">
										<fo:table-cell font-size="8.0pt">
											<fo:block>
												<xsl:value-of select="recipient_bank/name"/>
											</fo:block>
											<xsl:if test="recipient_bank/address_line_1[. != '']">
												<fo:block>
													<xsl:value-of select="recipient_bank/address_line_1"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="recipient_bank/address_line_2[. != '']">
												<fo:block>
													<xsl:value-of select="recipient_bank/address_line_2"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="recipient_bank/dom[. != '']">
												<fo:block>
													<xsl:value-of select="recipient_bank/dom"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="recipient_bank/address_line_4[. != '']">
												<fo:block>
													<xsl:value-of select="recipient_bank/address_line_4"/>
												</fo:block>
											</xsl:if>
										</fo:table-cell>
										<fo:table-cell font-size="8.0pt">
											<xsl:if test="recipient_bank/phone[. != '']">
												<fo:block>
													Tel:
													<xsl:value-of select="recipient_bank/phone"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="recipient_bank/fax[. != '']">
												<fo:block>
													Fax:
													<xsl:value-of select="recipient_bank/fax"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="recipient_bank/telex[. != '']">
												<fo:block>
													Telex:
													<xsl:value-of select="recipient_bank/telex"/>
												</fo:block>
											</xsl:if>
											<xsl:if test="recipient_bank/iso_code[. != '']">
												<fo:block>
													SWIFT:
													<xsl:value-of select="recipient_bank/iso_code"/>
												</fo:block>
											</xsl:if>
											<!-- cell should not be empty -->
											<xsl:if test="recipient_bank/phone[.=''] and recipient_bank/fax[.=''] and recipient_bank/telex[. =''] and recipient_bank/iso_code[. = '']">
												<fo:block>
												</fo:block>
											</xsl:if>
										</fo:table-cell>
									</xsl:if>
								</xsl:when>
								<xsl:otherwise/>
							</xsl:choose>
							<fo:table-cell>
								<xsl:attribute name="font-size">
                                        <xsl:value-of select="number(substring-before($pdfFontSize,'pt'))+2"/>pt</xsl:attribute>
								<fo:block font-weight="bold" text-align="center">
									<xsl:attribute name="end-indent">
                                        <xsl:value-of select="number($pdfMargin)"/>pt</xsl:attribute>
									<xsl:value-of select="localization:getDecode($language, 'N001', product_code[.])"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			<!-- anci -->
			<!--  -->
			
			
		</fo:static-content>
  </xsl:template>
  <xsl:template name="body">
    <fo:flow flow-name="xsl-region-body" font-size="{$pdfFontSize}">
			<!--Insert the transaction summary-->
			<xsl:call-template name="product_summary"/>
			<xsl:call-template name="fx-common-details"/>
			<xsl:element name="fo:block">
				<xsl:attribute name="font-size">1pt</xsl:attribute>
				<xsl:attribute name="id">
                            <xsl:value-of select="concat('LastPage_',../@section)"/>
                        </xsl:attribute>
			</xsl:element>
		</fo:flow>
  </xsl:template>
  <xsl:template name="footer">
    <fo:static-content flow-name="xsl-region-after">
			<fo:block font-family="{$pdfFont}" font-size="8.0pt" keep-together="always">
				<!-- Page number -->
				<fo:block color="{$footerFontColor}" font-weight="bold" text-align="start">
					<!-- <xsl:value-of select="localization:getGTPString($language, 'XSL_FO_PAGE')" />&nbsp; -->
					<fo:page-number/> /
					<!-- &nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_FO_OF')" />&nbsp; -->
					<fo:page-number-citation>
						<xsl:attribute name="ref-id">
                                        <xsl:value-of select="concat('LastPage_',../@section)"/>
                                        </xsl:attribute>
					</fo:page-number-citation>
				</fo:block>
				<fo:block color="{$footerFontColor}" text-align="start">
					<xsl:attribute name="end-indent">
	                                 	<xsl:value-of select="number($pdfMargin)"/>pt
	                                 </xsl:attribute>
					<xsl:value-of select="convertTools:internalDateToStringDate($systemDate,$language)"/>
				</fo:block>
			</fo:block>
		</fo:static-content>
  </xsl:template>
</xsl:stylesheet>
