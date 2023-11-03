<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:dateutils="xalan://com.misys.portal.core.project.util.DateUtils"
		xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
		exclude-result-prefixes="utils dateutils converttools">
		
	<xsl:param name="mode"/>
	<xsl:param name="base_url"/>
	<xsl:param name="language" />
	<xsl:variable name="isdynamiclogo">
        <xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
    </xsl:variable>
    
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="guarantee_text">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="Section1-pm" margin-right="75.0pt" margin-left="75.0pt" margin-bottom="36.6pt" margin-top="36.6pt" page-height="841.9pt" page-width="595.3pt">
					<fo:region-body margin-bottom="36.6pt" margin-top="60.0pt" background-repeat="no-repeat">
				         <!-- <xsl:attribute name="background-image">url(<xsl:value-of select="$base_url"/>/advices/<xsl:value-of select="$mode"/>.gif)</xsl:attribute> -->
				    </fo:region-body>
					<fo:region-before extent="50.0pt"/>
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
				
				<!-- FOOTER -->
				<fo:static-content flow-name="xsl-region-after">
					<xsl:call-template name="footer"/>
				</fo:static-content>
				
				<!-- BODY-->
				<fo:flow flow-name="xsl-region-body" font-size="10.0pt" font-family="serif">
					<xsl:call-template name="body"/>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
	
	<!-- Templates for customization. -->
	<!-- Header template -->
	<xsl:template name="header">
		<fo:table width="440.0pt">
			<fo:table-column column-width="145.0pt"/>
			<fo:table-column column-width="295.0pt"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block>
							<xsl:call-template name="logo"/>
                        </fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>&nbsp;</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
	</xsl:template>
	
	<!-- Logo template -->
	<xsl:template name="logo">
        <fo:external-graphic content-height="1.5cm" content-width="3.5cm" text-align="left">
			<xsl:attribute name="src">
				<xsl:choose>
					<xsl:when test="$isdynamiclogo='true'">url('<xsl:value-of select="$base_url"/>/advices/<xsl:value-of select="si_tnx_record/recipient_bank/abbv_name" />/logo.gif')</xsl:when>
					<xsl:otherwise>url('<xsl:value-of select="$base_url" />/advices/logo.gif')</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</fo:external-graphic>
	</xsl:template>
	
	<!-- Body template -->
	<xsl:template name="body">
		<fo:block text-align="end">Act No. <xsl:value-of select="si_tnx_record/ref_id"/></fo:block>
		<fo:block text-align="center" font-weight="bold" text-decoration="underline" space-before.optimum="20.0pt">WARRANTY FIRST APPLICATION</fo:block>
		<fo:block text-align="center" font-style="italic">(Repayment granted by another bank)</fo:block>
		<fo:block text-align="justify" space-before.optimum="20.0pt">We refer to the Loan signed between <xsl:value-of select="si_tnx_record/beneficiary_name"/>, <xsl:value-of select="si_tnx_record/beneficiary_legal_form"/> capital of<xsl:value-of select="si_tnx_record/beneficiary_capital_cur_code"/>&nbsp;<xsl:value-of select="si_tnx_record/beneficiary_capital_amt"/>, whose registered office is located <xsl:value-of select="si_tnx_record/beneficiary_address_line_1"/> - <xsl:value-of select="si_tnx_record/beneficiary_address_line_2"/> - <xsl:value-of select="si_tnx_record/beneficiary_dom"/> - <xsl:value-of select="si_tnx_record/beneficiary_address_line_4"/>, acting as lender and hereinafter referred to as the "<fo:inline font-style="italic">beneficiary</fo:inline>" and <xsl:value-of select="si_tnx_record/applicant_name"/>, <xsl:value-of select="customer/legal_form"/> capital of <xsl:value-of select="customer/currency"/>&nbsp;<xsl:value-of select="converttools:getDefaultAmountRepresentation(customer/authorized_capital,customer/currency,$language)"/>, whose registered office is located <xsl:value-of select="si_tnx_record/applicant_address_line_1"/>&nbsp;<xsl:value-of select="si_tnx_record/applicant_address_line_2"/>&nbsp;<xsl:value-of select="si_tnx_record/applicant_dom"/>&nbsp;<xsl:value-of select="si_tnx_record/applicant_address_line_4"/>, hereinafter referred to as the"<fo:inline font-style="italic">borrower</fo:inline>", by which the Beneficiary open to the Borrower a loan <xsl:value-of select="si_tnx_record/contract_cur_code"/>&nbsp;<xsl:value-of select="si_tnx_record/contract_amt"/></fo:block>
		<fo:block text-align="justify" space-before.optimum="10.0pt">On instructions from <xsl:value-of select="si_tnx_record/applicant_name"/> us, Misys Bank, unconditionally and irrevocably guarantee payment to the Beneficiary first demand of it an amount not to exceed a maximum amount of <xsl:value-of select="si_tnx_record/lc_cur_code"/>&nbsp;<xsl:value-of select="si_tnx_record/lc_amt"/></fo:block>
		<fo:block text-align="justify" space-before.optimum="10.0pt">This warranty constitutes an independent and autonomous obligation with respect to the obligations of the Borrower under the aforementioned loan and, notwithstanding the reference made to it, we renounce raise any exception or because of some kind to refuse or to postpone payment hereunder.</fo:block>
		<fo:block text-align="justify" space-before.optimum="10.0pt">Therefore, we will pay the Beneficiary, at first request from him and up to the maximum amount mentioned above, any money we could claim by registered letter with acknowledgment of receipt (recorded delivery) stating:</fo:block>
		<fo:block text-align="justify" space-before.optimum="10.0pt">Any claim under this warranty must be made to the Bank at the following address:</fo:block>
		<fo:block margin-left="70.0pt"><xsl:value-of select="bank/name"/></fo:block>
		<fo:block margin-left="70.0pt"><xsl:value-of select="bank/address_line_1"/></fo:block>
		<fo:block margin-left="70.0pt"><xsl:value-of select="bank/address_line_2"/></fo:block>
		<fo:block margin-left="70.0pt"><xsl:value-of select="bank/dom"/></fo:block>
		<fo:block text-align="justify" space-before.optimum="10.0pt">This guarantee will be called once or several times. Any payment made in that capacity will decrease by this amount the maximum amount payable under this warranty.</fo:block>
		<fo:block text-align="justify" space-before.optimum="10.0pt">This warranty shall not validly be invoked by recorded delivery received by Misys Bank at its headquarters at the latest. Otherwise, the warranty will be void automatically and by law even if it is not returned to us.</fo:block>
		<fo:block text-align="justify" space-before.optimum="10.0pt">This guarantee is governed by French law and any dispute relating in particular to its validity, interpretation or its execution, will be the exclusive jurisdiction of the Commercial Court of Paris.</fo:block>						
		
		<fo:table width="440.0pt" space-before.optimum="30.0pt">
			<fo:table-column column-width="250.0pt"/>
			<fo:table-column column-width="190.0pt"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block>Done at Paris,</fo:block>
						<fo:block space-before.optimum="30.0pt" font-weight="bold">Misys Bank</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
		<fo:block id="LastPage" font-size="1pt"/>
	</xsl:template>
	
	<!-- Footer template -->
	<xsl:template name="footer">
		<fo:block font-size="10.0pt" font-family="serif" text-align="end">Page <fo:page-number /> of <fo:page-number-citation ref-id="LastPage" /></fo:block>
	</xsl:template>
	
</xsl:stylesheet>
