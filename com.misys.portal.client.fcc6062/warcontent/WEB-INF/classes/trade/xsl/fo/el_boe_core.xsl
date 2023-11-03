<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
##########################################################
XSL for Generation of Bill of Exchange

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      17/08/15
author:    shapalod
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:java="http://xml.apache.org/xalan/java"
		xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:tool="xalan://com.misys.portal.interfaces.core.ToolsFactory"
		exclude-result-prefixes="converttools localization defaultresource utils tool">
		
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	
	<xsl:param name="base_url"/>
	<xsl:param name="language"/>
	
	<xsl:variable name="isdynamiclogo">
        <xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
   </xsl:variable>

	<!-- common instructions for the webapplication and the incoming loader -->
	<xsl:template match="el_tnx_record">
		
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="Section1-pm" margin-right="75.0pt" margin-left="75.0pt" margin-bottom="36.6pt" margin-top="36.6pt" page-height="841.9pt" page-width="595.3pt">
					<fo:region-body margin-bottom="80.0pt" margin-top="100.0pt"/>
					<fo:region-before extent="100.0pt"/>
					<fo:region-after extent="36.6pt"/>
				</fo:simple-page-master>
				<fo:page-sequence-master master-name="Section1-ps">
					<fo:repeatable-page-master-reference master-reference="Section1-pm"/>
				</fo:page-sequence-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="Section1-ps">
			
				<!-- HEADER-->
				<fo:static-content flow-name="xsl-region-before">
					<xsl:call-template name="header"/>
				</fo:static-content>
				
				<!-- FOOTER-->
				<fo:static-content flow-name="xsl-region-after">
					<xsl:call-template name="footer"/>
				</fo:static-content>
				
				<!-- BODY-->
				<xsl:call-template name="body"/>
					
			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!-- Header details -->
	  <xsl:template name="header">
	  	<fo:block font-size="15.0pt" font-family="serif">
	  		<fo:table width="440.0pt">
				<fo:table-column column-width="150.0pt"/>
				<fo:table-column column-width="290.0pt"/>
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block>&nbsp;</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block font-size="15.0pt" font-family="serif" font-weight="bold">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_BOE_HEADER')"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
		<fo:block>&nbsp;</fo:block>
	  	<fo:block font-size="8.0pt" font-family="serif">
		  	<fo:table width="440.0pt">
					<fo:table-column column-width="300.0pt"/>
					<fo:table-column column-width="140.0pt"/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<xsl:call-template name="drawer"/>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-weight="bold"><xsl:value-of select="localization:getGTPString($language, 'XSL_BOE_DATE_OF_ISSUE')"/></fo:block>
								<fo:block>
									<xsl:value-of select="appl_date"/>
								</fo:block>
								</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
			</fo:table>
		</fo:block>
		<fo:block>&nbsp;</fo:block>
		<fo:block>&nbsp;</fo:block>
	  </xsl:template>
	  
	  <!-- Drawer Details -->
	  <xsl:template name="drawer">
			<fo:block font-weight="bold"><xsl:value-of select="localization:getGTPString($language, 'XSL_BOE_DRAWER')"/></fo:block>
			<fo:block>
				<xsl:value-of select="applicant_name"/>
			</fo:block>
			<xsl:if test="applicant_address_line_1[. != '']">
				<fo:block>
					<xsl:value-of select="applicant_address_line_1"/>
				</fo:block>
			</xsl:if>
			<xsl:if test="applicant_address_line_2[. != '']">
				<fo:block>
					<xsl:value-of select="applicant_address_line_2"/>
				</fo:block>
			</xsl:if>
			<xsl:if test="applicant_dom[. != '']">
				<fo:block>
					<xsl:value-of select="applicant_dom"/>
				</fo:block>
			</xsl:if>
			<xsl:if test="applicant_address_line_4[. != '']">
				<fo:block>
					<xsl:value-of select="applicant_address_line_4"/>
				</fo:block>
			</xsl:if>
			<fo:block>&nbsp;</fo:block>
	  </xsl:template>
		
		<!-- Footer details i.e. Page number -->
		<xsl:template name="footer">
			<!-- Page number -->
			<fo:block font-size="10.0pt" font-family="serif" text-align="end">Page<fo:page-number/>of<fo:page-number-citation ref-id="LastPage" />
			</fo:block>
		</xsl:template>
	
		<!-- Body of the Bill of Exchange -->
		<xsl:template name="body">
			<fo:flow flow-name="xsl-region-body" font-size="10.0pt" font-family="serif">
					<fo:block font-size="8.0pt" font-family="serif">
						<fo:table width="440.0pt">
							<fo:table-column column-width="300.0pt"/>
							<fo:table-column column-width="140.0pt"/>
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell>
										<fo:block font-weight="bold"><xsl:value-of select="localization:getGTPString($language, 'XSL_BOE_AMT_IN_FIGURES')"/></fo:block>
										<fo:block>
											<xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>&nbsp;</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>
					<fo:block text-align="justify" margin-top="10.0pt"><xsl:value-of select="draft_term"/>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_BOE_BODY12')"/>&nbsp;
					<fo:inline font-weight="bold"><xsl:value-of select="localization:getGTPString($language, 'XSL_BOE')"/>
					</fo:inline>&nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_BOE_BODY2')"/>&nbsp;
					<fo:inline font-weight="bold"><xsl:value-of select="localization:getGTPString($language, 'XSL_BOE_OURSELVES')"/>
					</fo:inline></fo:block>
					<fo:block text-align="justify" margin-top="10.0pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_BOE_SUM')"/>&nbsp;<xsl:value-of select="utils:spellout($language, tnx_amt, tnx_cur_code)"/></fo:block>
					<fo:block text-align="justify" margin-top="10.0pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_BOE_PAYABLE_AT')"/>&nbsp;<xsl:value-of select="draft_term"/></fo:block>
					<fo:block>&nbsp;</fo:block>
					<fo:block>
						<fo:block font-weight="bold"><xsl:value-of select="localization:getGTPString($language, 'XSL_BOE_ACCEPTED_ON')"/></fo:block>
						<fo:block>&nbsp;</fo:block>
					</fo:block>
					<fo:block>
						<fo:block font-weight="bold"><xsl:value-of select="localization:getGTPString($language, 'XSL_BOE_PAYMENT_ON')"/></fo:block>
						<fo:block>&nbsp;</fo:block>
						<fo:block>&nbsp;</fo:block>
					</fo:block>
					<fo:table width="440.0pt" margin-top="18.0pt">
						<fo:table-column column-width="300.0pt"/>
						<fo:table-column column-width="140.0pt"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell>
									<fo:block font-weight="bold"><xsl:value-of select="localization:getGTPString($language, 'XSL_BOE_DRAWEE')"/></fo:block>
									<fo:block wrap-option="wrap">
										<xsl:value-of select="beneficiary_name"/>
									</fo:block>
									<xsl:if test="beneficiary_address_line_1[. != '']">
										<fo:block hyphenate="true">
											<xsl:value-of select="beneficiary_address_line_1"/>
										</fo:block>
									</xsl:if>
									<xsl:if test="beneficiary_address_line_2[. != '']">
										<fo:block keep-together="always">
											<xsl:value-of select="beneficiary_address_line_2"/>
										</fo:block>
									</xsl:if>
									<xsl:if test="beneficiary_dom[. != '']">
										<fo:block keep-together.within-line="always">
											<xsl:value-of select="beneficiary_dom"/>
										</fo:block>
									</xsl:if>
									<xsl:if test="beneficiary_address_line_4[. != '']">
										<fo:block keep-together="always">
											<xsl:value-of select="beneficiary_address_line_4"/>
										</fo:block>
									</xsl:if>
									<fo:block>&nbsp;</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<fo:block font-weight="bold"><xsl:value-of select="localization:getGTPString($language, 'XSL_BOE_DRAWER_NAME')"/></fo:block>
										<fo:block>
											<xsl:value-of select="applicant_name"/>
										</fo:block>
										<fo:block>&nbsp;</fo:block>
										<fo:block>&nbsp;</fo:block>
									</fo:block>
									<fo:block>
										<fo:block font-weight="bold"><xsl:value-of select="localization:getGTPString($language, 'XSL_BOE_DRAWER_SIGNATURE')"/></fo:block>
										<fo:block>&nbsp;</fo:block>
										<fo:block>&nbsp;</fo:block>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
					<fo:block id="LastPage" font-size="1pt"/>
			</fo:flow>
		</xsl:template>
	
</xsl:stylesheet>