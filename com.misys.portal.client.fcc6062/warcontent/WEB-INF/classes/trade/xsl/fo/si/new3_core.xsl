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
				         <xsl:attribute name="background-image">url(<xsl:value-of select="$base_url"/>/advices/<xsl:value-of select="$mode"/>.gif)</xsl:attribute>
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
					<xsl:when test="$mode='ORIGINAL'">
					<fo:table width="440.0pt">
						<fo:table-column column-width="145.0pt"/>
						<fo:table-column column-width="295.0pt"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell>
									<fo:block>
										<fo:external-graphic height="46.5pt" width="142.5pt">
	                                        <xsl:attribute name="src">
                        <xsl:value-of select="$base_url"/>/advices/logo.gif</xsl:attribute>
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
					<xsl:otherwise>
					<fo:table width="440.0pt">
						<fo:table-column column-width="440.0pt"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell border-bottom-color="black" border-bottom-style="solid" border-bottom-width="0.5pt" border-left-color="black" border-left-style="solid" border-left-width="0.5pt" border-right-color="black" border-right-style="solid" border-right-width="0.5pt" border-top-color="black" border-top-style="solid" border-top-width="0.5pt">
									<fo:block font-size="20.0pt" text-align="center">
                    <xsl:value-of select="$mode"/>
                  </fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
					</xsl:otherwise>
					</xsl:choose>
				</fo:static-content>
  </xsl:template>
  <xsl:template name="body">
    <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="10.0pt">
					<fo:block text-align="end">Acte N° <xsl:value-of select="si_tnx_record/ref_id"/>
      </fo:block>
					<fo:block font-weight="bold" space-before.optimum="20.0pt" text-align="center" text-decoration="underline">GARANTIE A PREMIERE DEMANDE</fo:block>
					<fo:block font-style="italic" text-align="center">(Remboursement de concours accordés par une banque tierce)</fo:block>
					<fo:block space-before.optimum="20.0pt" text-align="justify">Nous nous référons au Prêt signé le entre <xsl:value-of select="si_tnx_record/beneficiary_name"/>, <xsl:value-of select="si_tnx_record/beneficiary_legal_form"/> au capital de <xsl:value-of select="si_tnx_record/beneficiary_capital_cur_code"/> <xsl:value-of select="si_tnx_record/beneficiary_capital_amt"/>, dont le siège social est situé <xsl:value-of select="si_tnx_record/beneficiary_address_line_1"/> - <xsl:value-of select="si_tnx_record/beneficiary_address_line_2"/> - <xsl:value-of select="si_tnx_record/beneficiary_dom"/> - <xsl:value-of select="si_tnx_record/beneficiary_address_line_4"/>, agissant comme prêteur et ci-après dénommé le "<fo:inline font-style="italic">Bénéficiaire</fo:inline>" et <xsl:value-of select="si_tnx_record/applicant_name"/>, <xsl:value-of select="customer/legal_form"/> au capital de <xsl:value-of select="customer/currency"/> <xsl:value-of select="converttools:getDefaultAmountRepresentation(customer/authorized_capital,customer/currency,$language)"/>, dont le siège social est situé <xsl:value-of select="si_tnx_record/applicant_address_line_1"/> <xsl:value-of select="si_tnx_record/applicant_address_line_2"/> <xsl:value-of select="si_tnx_record/applicant_dom"/> <xsl:value-of select="si_tnx_record/applicant_address_line_4"/>, ci-après dénommé l'"<fo:inline font-style="italic">Emprunteur</fo:inline>", par laquelle le Bénéficiaire a ouvert à l'Emprunteur un Prêt de <xsl:value-of select="si_tnx_record/contract_cur_code"/> <xsl:value-of select="si_tnx_record/contract_amt"/>
      </fo:block>
					<fo:block space-before.optimum="10.0pt" text-align="justify">D'ordre de <xsl:value-of select="si_tnx_record/applicant_name"/> nous, CALYON, garantissons inconditionnellement et irrévocablement le paiement au Bénéficiaire à première demande de celui-ci d'une somme qui n'excèdera pas un montant maximum de <xsl:value-of select="si_tnx_record/lc_cur_code"/> <xsl:value-of select="si_tnx_record/lc_amt"/>
      </fo:block>
					<fo:block space-before.optimum="10.0pt" text-align="justify">La présente garantie constituant une obligation indépendante et autonome par rapport aux obligations de l'Emprunteur au titre du prêt susvisé et ce, nonobstant la référence qui y est faite, nous renonçons à soulever une quelconque exception ou raison de quelque nature que ce soit pour refuser ou pour différer un paiement au titre des présentes.</fo:block>
					<fo:block space-before.optimum="10.0pt" text-align="justify">En conséquence, nous paierons au Bénéficiaire, à première demande de sa part et à concurrence du montant maximum précité, toute somme qu'il pourrait nous réclamer par Lettre Recommandée avec Avis de Réception (LRAR) mentionnant :</fo:block>
					<!-- <fo:list-item start-indent="30.0pt">
						<fo:list-item-label end-indent="label-end()">
							<fo:block>-</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>le montant réclamé,</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item start-indent="30.0pt">
						<fo:list-item-label end-indent="label-end()">
							<fo:block>-</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>les références de la présente garantie, accompagnée :</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item start-indent="50.0pt">
						<fo:list-item-label end-indent="label-end()">
							<fo:block>
								<fo:inline font-size="20.0pt" font-family="Courier" font-weight="bold"> &#x2E; </fo:inline>
							</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>de la copie de la LRAR adressée à l'Emprunteur par le Bénéficiaire pour réclamer le montant des sommes qui lui sont dues,</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item start-indent="50.0pt">
						<fo:list-item-label end-indent="label-end()">
							<fo:block>
								<fo:inline font-size="20.0pt" font-family="Courier" font-weight="bold"> &#x2E; </fo:inline>
							</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>et de la certification que cette demande n'a pas été satisfaite.</fo:block>
						</fo:list-item-body>
					</fo:list-item> -->
					<fo:block space-before.optimum="10.0pt" text-align="justify">Toute demande au titre de la présente garantie devra être faite à la Banque à l'adresse suivante :</fo:block>
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
					<fo:block space-before.optimum="10.0pt" text-align="justify">La présente garantie pourra être appelée en une ou plusieurs fois. Tout paiement effectué à ce titre diminuera à due concurrence le montant maximum payable au titre de la présente garantie.</fo:block>
					<fo:block space-before.optimum="10.0pt" text-align="justify">La présente garantie ne pourra valablement être mise en jeu que par LRAR reçue par CALYON à son siège au plus tard le . A défaut, la présente garantie sera automatiquement et de plein droit caduque même si elle ne nous est pas restituée.</fo:block>
					<fo:block space-before.optimum="10.0pt" text-align="justify">La présente garantie est régie par le droit français et tout litige, relatif notamment à sa validité, son interprétation ou son exécution, sera de la compétence exclusive du Tribunal de Commerce de Paris.</fo:block>						
					
					<fo:table space-before.optimum="30.0pt" width="440.0pt">
						<fo:table-column column-width="250.0pt"/>
						<fo:table-column column-width="190.0pt"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell>
									<fo:block>Fait à Paris, le</fo:block>
									<fo:block font-weight="bold" space-before.optimum="30.0pt">CALYON</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:flow>
  </xsl:template>
</xsl:stylesheet>
