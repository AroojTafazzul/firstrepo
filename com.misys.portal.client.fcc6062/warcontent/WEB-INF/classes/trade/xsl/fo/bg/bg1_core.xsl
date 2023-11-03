<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:dateutils="xalan://com.misys.portal.core.project.util.DateUtils" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:utils="xalan://com.misys.portal.common.tools.Utils" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="utils dateutils converttools" version="1.0">
		
	<xsl:param name="mode"/>
	<xsl:param name="base_url"/>
	<xsl:param name="language"/>
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="guarantee_text">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master margin-bottom="36.6pt" margin-left="75.0pt" margin-right="75.0pt" margin-top="36.6pt" master-name="Section1-pm" page-height="841.9pt" page-width="595.3pt">
					<fo:region-body background-repeat="no-repeat" margin-bottom="36.6pt" margin-top="60.0pt">
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
				<!-- HEADER-->
				
				<!-- BODY-->
				
			<xsl:call-template name="header"/>
        <xsl:call-template name="body"/>
      </fo:page-sequence>
		</fo:root>
	</xsl:template>
<xsl:template name="header">
    <fo:static-content flow-name="xsl-region-before">
					<xsl:choose>
					<xsl:when test="$mode='PROJET'">
					<fo:table width="440.0pt">
						<fo:table-column column-width="145.0pt"/>
						<fo:table-column column-width="295.0pt"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell>
									<fo:block>
										<fo:external-graphic height="13pt" width="40pt">
	                                        <xsl:attribute name="src">
                        <xsl:value-of select="$base_url"/>/advices/<xsl:value-of select="bg_tnx_record/recipient_bank/abbv_name"/>.gif</xsl:attribute>
                                        </fo:external-graphic>
                                     </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block> </fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
					</xsl:when>
					<!-- <xsl:otherwise>
					<fo:table width="440.0pt">
						<fo:table-column column-width="440.0pt"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell
									border-right-color="black" border-right-width="0.5pt" border-right-style="solid"
									border-left-color="black" border-left-width="0.5pt" border-left-style="solid"
									border-bottom-color="black" border-bottom-width="0.5pt" border-bottom-style="solid"
									border-top-color="black" border-top-width="0.5pt" border-top-style="solid">
									<fo:block font-size="20.0pt" text-align="center"><xsl:value-of select="$mode"/></fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
					</xsl:otherwise> -->
					<xsl:otherwise>
					<fo:block/>
					</xsl:otherwise>
					</xsl:choose>
				</fo:static-content>
  </xsl:template>
  <xsl:template name="body">
    <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="10.0pt">
					<fo:block text-align="end">Acte NÂ° <xsl:value-of select="bg_tnx_record/ref_id"/>
      </fo:block>
					<fo:block font-weight="bold" space-before.optimum="20.0pt" text-align="center" text-decoration="underline">GARANTIE A PREMIERE DEMANDE</fo:block>
					<fo:block font-style="italic" text-align="center">(Repayment of loans granted by a third party bank)</fo:block>
					<fo:block space-before.optimum="20.0pt" text-align="justify">We refer to the Loan signed between <xsl:value-of select="bg_tnx_record/beneficiary_name"/>, <xsl:value-of select="bg_tnx_record/beneficiary_legal_form"/> capital of <xsl:value-of select="bg_tnx_record/beneficiary_capital_cur_code"/> <xsl:value-of select="bg_tnx_record/beneficiary_capital_amt"/>, Whose headquarters <xsl:value-of select="bg_tnx_record/beneficiary_address_line_1"/> - <xsl:value-of select="bg_tnx_record/beneficiary_address_line_2"/> - <xsl:value-of select="bg_tnx_record/beneficiary_dom"/> - <xsl:value-of select="bg_tnx_record/beneficiary_address_line_4"/>, acting as lender and the hereafter "<fo:inline font-style="italic">beneficiary</fo:inline>" and <xsl:value-of select="bg_tnx_record/applicant_name"/>, <xsl:value-of select="customer/legal_form"/> capital of <xsl:value-of select="customer/currency"/> <xsl:value-of select="converttools:getDefaultAmountRepresentation(customer/authorized_capital,customer/currency,$language)"/>, whose headquarters <xsl:value-of select="bg_tnx_record/applicant_address_line_1"/> <xsl:value-of select="bg_tnx_record/applicant_address_line_2"/> <xsl:value-of select="bg_tnx_record/applicant_dom"/> <xsl:value-of select="bg_tnx_record/applicant_address_line_4"/>, hereinafter referred to as the'"<fo:inline font-style="italic">borrower</fo:inline>", by which the Beneficiary has opened to the Borrower a loan <xsl:value-of select="bg_tnx_record/contract_cur_code"/> <xsl:value-of select="bg_tnx_record/contract_amt"/>
      </fo:block>
					<fo:block space-before.optimum="10.0pt" text-align="justify">In order <xsl:value-of select="bg_tnx_record/applicant_name"/> us, Calyon, unconditionally and irrevocably guarantee payment to the Beneficiary first application thereof an amount not to exceed a maximum of <xsl:value-of select="bg_tnx_record/bg_cur_code"/> <xsl:value-of select="bg_tnx_record/bg_amt"/>
      </fo:block>
					<fo:block space-before.optimum="10.0pt" text-align="justify">This warranty constitutes an independent and autonomous obligation with respect to obligations of the Borrower under the loan referred to above and, notwithstanding the reference is made&#128;&#139;, we renounce to raise any exception or because of any nature whatsoever to deny or to defer payment hereunder.</fo:block>
					<fo:block space-before.optimum="10.0pt" text-align="justify">Accordingly, we will pay the Beneficiary, at the first request on his part and the maximum amount above, any amount we could claim by registered letter with acknowledgment of receipt (recorded delivery) stating:</fo:block>
					<!-- <fo:list-item start-indent="30.0pt">
						<fo:list-item-label end-indent="label-end()">
							<fo:block>-</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>le montant rÃ©clamÃ©,</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item start-indent="30.0pt">
						<fo:list-item-label end-indent="label-end()">
							<fo:block>-</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>les rÃ©fÃ©rences de la prÃ©sente garantie, accompagnÃ©e :</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item start-indent="50.0pt">
						<fo:list-item-label end-indent="label-end()">
							<fo:block>
								<fo:inline font-size="20.0pt" font-family="Courier" font-weight="bold"> &#x2E; </fo:inline>
							</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>de la copie de la LRAR adressÃ©e Ã  l'Emprunteur par le BÃ©nÃ©ficiaire pour rÃ©clamer le montant des sommes qui lui sont dues,</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item start-indent="50.0pt">
						<fo:list-item-label end-indent="label-end()">
							<fo:block>
								<fo:inline font-size="20.0pt" font-family="Courier" font-weight="bold"> &#x2E; </fo:inline>
							</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>et de la certification que cette demande n'a pas Ã©tÃ© satisfaite.</fo:block>
						</fo:list-item-body>
					</fo:list-item> -->
					<fo:block space-before.optimum="10.0pt" text-align="justify">Any claim under this warranty must be made to the Bank at the following address:</fo:block>
					<fo:block margin-left="70.0pt">
        <xsl:value-of select="bank/name"/>
      </fo:block>
					<fo:block margin-left="70.0pt">
        <xsl:value-of select="bank/address_line_1"/>
      </fo:block>
					<fo:block margin-left="70.0pt">
        <xsl:value-of select="bank/address_line_2"/>
      </fo:block>
					<fo:block margin-left="70.0pt">
        <xsl:value-of select="bank/dom"/>
      </fo:block>
					<fo:block space-before.optimum="10.0pt" text-align="justify">This guarantee will be called one or more times. Any payment made under this decrease due to competition the maximum amount payable under this warranty.</fo:block>
					<fo:block space-before.optimum="10.0pt" text-align="justify">This warranty shall not validly be invoked by recorded delivery received by Calyon to his seat at the latest. Otherwise, this warranty will be automatically void and full right even if we are not restored.</fo:block>
					<fo:block space-before.optimum="10.0pt" text-align="justify">This warranty is governed by French law and any dispute relating in particular to its validity, interpretation or performance shall be within the exclusive jurisdiction of the Commercial Court of Paris.</fo:block>						
					
					<fo:table space-before.optimum="30.0pt" width="440.0pt">
						<fo:table-column column-width="250.0pt"/>
						<fo:table-column column-width="190.0pt"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell>
									<fo:block>Fait Ã  Paris, le</fo:block>
									<fo:block font-weight="bold" space-before.optimum="30.0pt">CALYON</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:flow>
  </xsl:template>
</xsl:stylesheet>
