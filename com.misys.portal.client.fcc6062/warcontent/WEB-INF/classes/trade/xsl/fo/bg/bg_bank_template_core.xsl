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
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="utils dateutils converttools defaultresource">
		
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
				        <!--  <xsl:attribute name="background-image">url(<xsl:value-of select="$base_url"/>/advices/logo.gif)</xsl:attribute> -->
				    </fo:region-body>
					<fo:region-before extent="50.0pt"/>
					<fo:region-after extent="36.6pt"/>
				</fo:simple-page-master>
				<fo:page-sequence-master master-name="Section1-ps">
					<fo:repeatable-page-master-reference master-reference="Section1-pm"/>
				</fo:page-sequence-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="Section1-ps">
			
				<!-- HEADER -->
				<fo:static-content flow-name="xsl-region-before">
					<xsl:call-template name="header"/>
				</fo:static-content>
				
				
				<!-- FOOTER -->
				<fo:static-content flow-name="xsl-region-after">
					<xsl:call-template name="footer"/>
				</fo:static-content>
				
				 <!-- BODY -->
				<fo:flow  flow-name="xsl-region-body" font-size="10.0pt" font-family="serif">
					<xsl:call-template name="body"/>
				</fo:flow>
				
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
	
	<!-- Templates for customization. -->
	
	<xsl:template name="header">
			<fo:table width="440.0pt">
				<fo:table-column column-width="145.0pt" />
				<fo:table-column column-width="295.0pt" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block>
								<xsl:call-template name="logo"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>&nbsp;
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
	</xsl:template>

	<xsl:template name="logo">
		<fo:external-graphic content-height="1.5cm" content-width="3.5cm" text-align="left">
			<xsl:attribute name="src"><xsl:value-of select="$base_url" />/advices/<xsl:value-of select="bg_tnx_record/recipient_bank/abbv_name" />.gif</xsl:attribute>
			
			<xsl:attribute name="src">
				<xsl:choose>
					<xsl:when test="$isdynamiclogo='true'">url('<xsl:value-of select="$base_url" />/advices/<xsl:value-of select="bg_tnx_record/recipient_bank/abbv_name" />/logo.gif')</xsl:when>
					<xsl:otherwise>url('<xsl:value-of select="$base_url" />/advices/logo.gif')</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</fo:external-graphic>
	</xsl:template>
	
 	<xsl:template name="body">
	
		<fo:block text-align="end">Act No. <xsl:value-of select="bg_tnx_record/ref_id"/></fo:block>
		<fo:block text-align="center" font-weight="bold" text-decoration="underline" space-before.optimum="20.0pt">WARRANTY FIRST APPLICATION</fo:block>
	    <fo:block text-align="center" font-style="italic">(Repayment of loans granted by a third party bank)</fo:block>
		<fo:block text-align="justify" space-before.optimum="20.0pt">We refer to the Loan signed between <xsl:value-of select="bg_tnx_record/beneficiary_name"/>, <xsl:value-of select="bg_tnx_record/beneficiary_legal_form"/> capital of <xsl:value-of select="bg_tnx_record/beneficiary_capital_cur_code"/>&nbsp;<xsl:value-of select="bg_tnx_record/beneficiary_capital_amt"/>, Whose headquarters <xsl:value-of select="bg_tnx_record/beneficiary_address_line_1"/> - <xsl:value-of select="bg_tnx_record/beneficiary_address_line_2"/> - <xsl:value-of select="bg_tnx_record/beneficiary_dom"/> - <xsl:value-of select="bg_tnx_record/beneficiary_address_line_4"/>, acting as lender and the hereafter "<fo:inline font-style="italic">beneficiary</fo:inline>" and <xsl:value-of select="bg_tnx_record/applicant_name"/>, <xsl:value-of select="customer/legal_form"/> capital of <xsl:value-of select="customer/currency"/>&nbsp;<xsl:value-of select="converttools:getDefaultAmountRepresentation(customer/authorized_capital,customer/currency,$language)"/>, whose headquarters <xsl:value-of select="bg_tnx_record/applicant_address_line_1"/>&nbsp;<xsl:value-of select="bg_tnx_record/applicant_address_line_2"/>&nbsp;<xsl:value-of select="bg_tnx_record/applicant_dom"/>&nbsp;<xsl:value-of select="bg_tnx_record/applicant_address_line_4"/>, hereinafter referred to as the'"<fo:inline font-style="italic">borrower</fo:inline>", by which the Beneficiary has opened to the Borrower a loan <xsl:value-of select="bg_tnx_record/contract_cur_code"/>&nbsp;<xsl:value-of select="bg_tnx_record/contract_amt"/></fo:block>
		<fo:block text-align="justify" space-before.optimum="10.0pt">In order <xsl:value-of select="bg_tnx_record/applicant_name"/> us, Misys Bank, unconditionally and irrevocably guarantee payment to the Beneficiary first application thereof an amount not to exceed a maximum of <xsl:value-of select="bg_tnx_record/bg_cur_code"/>&nbsp;<xsl:value-of select="bg_tnx_record/bg_amt"/></fo:block>
		<fo:block text-align="justify" space-before.optimum="10.0pt">This warranty constitutes an independent and autonomous obligation with respect to obligations of the Borrower under the loan referred to above and, notwithstanding the reference is made€‹, we renounce to raise any exception or because of any nature whatsoever to deny or to defer payment hereunder.</fo:block>
		<fo:block text-align="justify" space-before.optimum="10.0pt">Accordingly, we will pay the Beneficiary, at the first request on his part and the maximum amount above, any amount we could claim by registered letter with acknowledgment of receipt (recorded delivery) stating:</fo:block>
					
		<fo:block text-align="justify" space-before.optimum="10.0pt">Any claim under this warranty must be made to the Bank at the following address:</fo:block>
		<fo:block margin-left="70.0pt"><xsl:value-of select="bank/name"/></fo:block>
		<fo:block margin-left="70.0pt"><xsl:value-of select="bank/address_line_1"/></fo:block>
		<fo:block margin-left="70.0pt"><xsl:value-of select="bank/address_line_2"/></fo:block>
		<fo:block margin-left="70.0pt"><xsl:value-of select="bank/dom"/></fo:block>
		<fo:block text-align="justify" space-before.optimum="10.0pt">This guarantee will be called one or more times. Any payment made under this decrease due to competition the maximum amount payable under this warranty.</fo:block>
		<fo:block text-align="justify" space-before.optimum="10.0pt">This warranty shall not validly be invoked by recorded delivery received by Misys Bank to his seat at the latest. Otherwise, this warranty will be automatically void and full right even if we are not restored.</fo:block>
		<fo:block text-align="justify" space-before.optimum="10.0pt">This warranty is governed by French law and any dispute relating in particular to its validity, interpretation or performance shall be within the exclusive jurisdiction of the Commercial Court of Paris.</fo:block>
		
			<fo:table width="440.0pt" space-before.optimum="30.0pt">
				<fo:table-column column-width="250.0pt" />
				<fo:table-column column-width="190.0pt" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block>Done at Paris,</fo:block>
							<fo:block space-before.optimum="30.0pt" font-weight="bold">Misys Bank
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		<fo:block id="LastPage" font-size="1pt"/>
	</xsl:template> 

	<xsl:template name="footer">
		<fo:block font-size="10.0pt" font-family="serif" text-align="end">Page <fo:page-number /> of <fo:page-number-citation ref-id="LastPage" />
		</fo:block>
	</xsl:template>


</xsl:stylesheet>
