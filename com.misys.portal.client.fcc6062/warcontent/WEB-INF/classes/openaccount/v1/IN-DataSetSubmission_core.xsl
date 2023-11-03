<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:Doc="urn:swift:xsd:$tsmt.014.001.02"
	xmlns:intools="xalan://com.misys.portal.interfaces.tools.InterfacesTools"
	xmlns:default="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:idgenerator="xalan://com.misys.portal.product.util.generator.ReferenceIdGenerator"
	xmlns:tools="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:tsutools="xalan://com.misys.portal.tsu.util.common.Tools"
	xmlns:crossreftools="xalan://com.misys.portal.product.util.CrossReferenceTool"
	exclude-result-prefixes="tools default intools idgenerator crossreftools">
	
	<xsl:import href="common.xsl"/>
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" cdata-section-elements="narrative_xml"/>
	
	<!-- Get the interface environment -->
	<xsl:param name="context"/>
	<xsl:param name="language"/>
	<xsl:param name="tnxstatcode"/>
	

	<!--
	Copyright (c) 2000-2007 NEOMAlogic (http://www.neomalogic.com),
	All Rights Reserved. 
	-->
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process PO-->
	<xsl:template match="in_tnx_record">
		<!--<xsl:variable name="references" select="crossreftools:getMasterAncestorReferenceAsNode('IN', ref_id, '02', 'PO')"/>
		<xsl:variable name="poRefId"><xsl:value-of select="$references/references/reference"/></xsl:variable>-->

		<!-- Get the baseline -->
		<xsl:variable name="baseline" select="tsutools:convertToNode(tsutools:retrieveXMLBaselineFromTID(tid))"/>

		<xsl:variable name="poRefId"><xsl:value-of select="$baseline//*[local-name()='PurchsOrdrRef']/Id"/></xsl:variable>
		<xsl:variable name="tuRefId"><xsl:value-of select="idgenerator:generate('TU')"/></xsl:variable>
		<tu_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/tu.xsd">
			<brch_code><xsl:value-of select="default:getResource('BRANCH_CODE')"/></brch_code>
			<ref_id><xsl:value-of select="$tuRefId"/></ref_id>
    		<tnx_type_code>18</tnx_type_code>
			<prod_stat_code>40</prod_stat_code>
			<tnx_stat_code><xsl:value-of select="$tnxstatcode"/></tnx_stat_code>
			<product_code>TU</product_code>
			<creation_date><xsl:value-of select="tsutools:getCurrentDateTime()"/></creation_date>
			<tid><xsl:value-of select="tid"/></tid>
			<po_ref_id><xsl:value-of select="$poRefId"/></po_ref_id>
			<cpty_ref_id><xsl:value-of select="issuer_ref_id"/></cpty_ref_id>
			<cpty_bank></cpty_bank>
			<role><xsl:value-of select="submission_type"/></role>
			<cur_code><xsl:value-of select="total_cur_code"/></cur_code>
			<ordered_amt><xsl:value-of select="total_amt"/></ordered_amt>
			<accepted_amt></accepted_amt>
			<buyer_name><xsl:value-of select="buyer_name"/></buyer_name>
			<seller_name><xsl:value-of select="seller_name"/></seller_name>
			<message_type>014</message_type>
			<baseline_stat_code></baseline_stat_code>
			<baseline_ref_id></baseline_ref_id>
			<request_for_action></request_for_action>
			<link_ref_id></link_ref_id>
			<issuing_bank>
				<abbv_name><xsl:value-of select="issuing_bank/abbv_name"/></abbv_name>
				<name><xsl:value-of select="issuing_bank/name"/></name>
			</issuing_bank>
			<!-- TSU MESSAGE -->
			<narrative_xml>
			&lt;Doc:Document xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:Doc="urn:swift:xsd:$tsmt.014.001.02">
			&lt;Doc:tsmt.014.001.02>
				&lt;Doc:SubmissnId>
					&lt;Doc:Id><xsl:value-of select="$tuRefId"/>&lt;/Doc:Id>
					&lt;Doc:CreDtTm><xsl:value-of select="tools:getW3CIsoDateTime()"/>&lt;/Doc:CreDtTm>
				&lt;/Doc:SubmissnId>
				&lt;Doc:TxRltdRefs>
					&lt;Doc:TxId><xsl:choose>
						<xsl:when test="tid[.!='']"><xsl:value-of select="tid"/></xsl:when>
						<xsl:otherwise/>
						<!--xsl:value-of select="intools:retrieveTIDFromPORefIf(po_ref_id,'context')"/-->
						</xsl:choose>&lt;/Doc:TxId>
					&lt;Doc:SubmitrTxRef>
						&lt;Doc:Id><xsl:value-of select="ref_id"/>&lt;/Doc:Id>
						&lt;Doc:IdIssr>
							&lt;Doc:BIC><!-- submit always by Issuing Bank --><xsl:choose>
									<xsl:when test="issuing_bank/iso_code[.!= '']"><xsl:value-of select="issuing_bank/iso_code"/></xsl:when>
									<xsl:when test="issuing_bank/abbv_name[.!= '']"><xsl:value-of select="intools:retrieveBICFromAbbvName(issuing_bank/abbv_name, $context)"/></xsl:when>
									<xsl:otherwise/>
								</xsl:choose>&lt;/Doc:BIC>
						&lt;/Doc:IdIssr>
					&lt;/Doc:SubmitrTxRef>
					&lt;Doc:FnlSubmissn><xsl:call-template name="YesNoIndicator">
								<xsl:with-param name="value">
									<xsl:value-of select="final_presentation"/>
								</xsl:with-param></xsl:call-template>&lt;/Doc:FnlSubmissn>				
				&lt;/Doc:TxRltdRefs>
				&lt;Doc:Instr>
					&lt;Doc:Tp>MTCH<!--xsl:value-of select="additional_field[@name='submission_type']"/-->&lt;/Doc:Tp>
				&lt;/Doc:Instr>
				
				<!--&lt;Doc:TxId>
					
				&lt;/Doc:TxId>
					
				&lt;Doc:SubmitrTxRef>
					
				&lt;/Doc:SubmitrTxRef>
					
		
				&lt;Doc:FnlSubmissn>
					
				&lt;/Doc:FnlSubmissn>-->
					
				&lt;Doc:BuyrBk>
					&lt;Doc:BIC><xsl:choose>
						<xsl:when test="buyer_bank/iso_code[.!= '']"><xsl:value-of select="buyer_bank/iso_code"/></xsl:when>
						<xsl:when test="buyer_bank/abbv_name[.!= '']"><xsl:value-of select="intools:retrieveBICFromAbbvName(buyer_bank/abbv_name, $context)"/></xsl:when>
						<xsl:otherwise/>
					</xsl:choose>&lt;/Doc:BIC>
				&lt;/Doc:BuyrBk>
				&lt;Doc:SellrBk>
					&lt;Doc:BIC><xsl:choose>
						<xsl:when test="seller_bank/iso_code[.!= '']"><xsl:value-of select="seller_bank/iso_code"/></xsl:when>
						<xsl:when test="submission_type[.='LODG']">
							<xsl:choose>
								<xsl:when test="buyer_bank/iso_code[.!= '']"><xsl:value-of select="buyer_bank/iso_code"/></xsl:when>
								<xsl:when test="buyer_bank/abbv_name[.!= '']"><xsl:value-of select="intools:retrieveBICFromAbbvName(buyer_bank/abbv_name, $context)"/></xsl:when>
								<xsl:otherwise/>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="seller_bank/abbv_name != ''"><xsl:value-of select="intools:retrieveBICFromAbbvName(seller_bank/abbv_name, $context)"/></xsl:when>
						<xsl:otherwise/>
					</xsl:choose>&lt;/Doc:BIC>
				&lt;/Doc:SellrBk>
					
				<!--	Stored (previous) data set not managed
				&lt;Doc:StordDataSetRef>
				
				&lt;/Doc:StordDataSetRef>
				-->
				
				&lt;Doc:NewComrclDataSet>
         		&lt;Doc:DataSetId>
         			&lt;Doc:Id><xsl:value-of select="ref_id"/>&lt;/Doc:Id>
						&lt;Doc:Vrsn>0&lt;/Doc:Vrsn>
						&lt;Doc:Submitr>
							&lt;Doc:BIC><!--xsl:value-of select="config:getString('product.tsu.issuer.bic.default')"/--><xsl:value-of select="submitr_bic"/>&lt;/Doc:BIC>
						&lt;/Doc:Submitr>
         		&lt;/Doc:DataSetId>
         		&lt;Doc:ComrclDocRef>
         			&lt;Doc:Id><xsl:value-of select="ref_id"/>&lt;/Doc:Id>
         			&lt;Doc:DtOfIsse><xsl:call-template name="ISODate">
								<xsl:with-param name="date">
									<xsl:value-of select="appl_date"/>
								</xsl:with-param></xsl:call-template>&lt;/Doc:DtOfIsse>
         		&lt;/Doc:ComrclDocRef>
         		&lt;Doc:Buyr>
						&lt;Doc:Nm><xsl:value-of select="buyer_name"/>&lt;/Doc:Nm>
						&lt;Doc:PstlAdr>
							<xsl:if test="buyer_street_name[.!='']">
								&lt;Doc:StrtNm><xsl:value-of select="buyer_street_name"/>&lt;/Doc:StrtNm>
							</xsl:if>
							&lt;Doc:PstCdId><xsl:value-of select="buyer_post_code"/>&lt;/Doc:PstCdId>
							&lt;Doc:TwnNm><xsl:value-of select="buyer_town_name"/>&lt;/Doc:TwnNm>
							<xsl:if test="buyer_country_sub_div[.!='']">
								&lt;Doc:CtrySubDvsn><xsl:value-of select="buyer_country_sub_div"/>&lt;/Doc:CtrySubDvsn>
							</xsl:if>
							&lt;Doc:Ctry><xsl:value-of select="buyer_country"/>&lt;/Doc:Ctry>
						&lt;/Doc:PstlAdr>
					&lt;/Doc:Buyr>
					&lt;Doc:Sellr>
						&lt;Doc:Nm><xsl:value-of select="seller_name"/>&lt;/Doc:Nm>
						&lt;Doc:PstlAdr>
							<xsl:if test="seller_street_name[.!='']">
								&lt;Doc:StrtNm><xsl:value-of select="seller_street_name"/>&lt;/Doc:StrtNm>
								</xsl:if>
							&lt;Doc:PstCdId><xsl:value-of select="seller_post_code"/>&lt;/Doc:PstCdId>
							&lt;Doc:TwnNm><xsl:value-of select="seller_town_name"/>&lt;/Doc:TwnNm>
							<xsl:if test="seller_country_sub_div[.!='']">
								&lt;Doc:CtrySubDvsn><xsl:value-of select="seller_country_sub_div"/>&lt;/Doc:CtrySubDvsn>
							</xsl:if>
							&lt;Doc:Ctry><xsl:value-of select="seller_country"/>&lt;/Doc:Ctry>
						&lt;/Doc:PstlAdr>
					&lt;/Doc:Sellr>
         		<xsl:if test="bill_to_name[.!='']">
						&lt;Doc:BllTo>
							&lt;Doc:Nm><xsl:value-of select="bill_to_name"/>&lt;/Doc:Nm>
							&lt;Doc:PstlAdr>
								&lt;Doc:StrtNm><xsl:value-of select="bill_to_street_name"/>&lt;/Doc:StrtNm>
								&lt;Doc:PstCdId><xsl:value-of select="bill_to_post_code"/>&lt;/Doc:PstCdId>
								&lt;Doc:TwnNm><xsl:value-of select="bill_to_town_name"/>&lt;/Doc:TwnNm>
								&lt;Doc:CtrySubDvsn><xsl:value-of select="buyer_country_sub_div"/>&lt;/Doc:CtrySubDvsn>
								&lt;Doc:Ctry><xsl:value-of select="bill_to_country"/>&lt;/Doc:Ctry>
							&lt;/Doc:PstlAdr>
						&lt;/Doc:BllTo>
					</xsl:if>
					&lt;Doc:Goods>
						&lt;Doc:PurchsOrdrRef>
							&lt;Doc:Id><xsl:value-of select="$poRefId"/>&lt;/Doc:Id>
            				&lt;Doc:DtOfIsse><xsl:value-of select="$baseline//*[local-name()='PurchsOrdrRef']/DtOfIsse"/>&lt;/Doc:DtOfIsse>
						&lt;/Doc:PurchsOrdrRef>
						
						<!-- Line Items -->
						<xsl:apply-templates select="line_items/lt_tnx_record"/>
						&lt;Doc:LineItmsTtlAmt Ccy="<xsl:value-of select="total_cur_code"/>"><xsl:call-template name="CurrencyAndAmount_SimpleType">
								<xsl:with-param name="amount">
									<xsl:value-of select="total_amt"/>
								</xsl:with-param>
							</xsl:call-template>&lt;/Doc:LineItmsTtlAmt>
						<!-- Inco Terms -->
						<xsl:apply-templates select="incoterms/incoterm"/>						
						<!-- Adjustments -->
						<xsl:apply-templates select="adjustments/allowance" mode="adjustments"/>					
						<!-- Freight Charges -->
						<xsl:if test="freight_charges_type[.!='']">
							&lt;Doc:FrghtChrgs>
								&lt;Doc:Tp><xsl:value-of select="freight_charges_type"/>&lt;/Doc:Tp>
								<xsl:apply-templates select="freight_charges/allowance" mode="freight_charges"/>
							&lt;/Doc:FrghtChrgs>
						</xsl:if>
						<!-- Taxes -->
						<xsl:apply-templates select="taxes/allowance" mode="taxes"/>
						<!-- Total Net Amount -->
						&lt;Doc:TtlNetAmt Ccy="<xsl:value-of select="total_net_cur_code"/>"><xsl:call-template name="CurrencyAndAmount_SimpleType">
								<xsl:with-param name="amount">
									<xsl:value-of select="total_net_amt"/>
								</xsl:with-param>
							</xsl:call-template>&lt;/Doc:TtlNetAmt>
						<!-- Buyer Informations-->
						<xsl:apply-templates select="user_defined_informations/user_defined_information[type='01']" mode="buyer"/>
						<!-- Seller Informations-->
						<xsl:apply-templates select="user_defined_informations/user_defined_information[type='02']" mode="seller"/>
					&lt;/Doc:Goods>
					<!-- Payment Terms -->
					<xsl:apply-templates select="payments/payment"/>
					<!-- Settlement Terms -->
					<xsl:if test="seller_account_name[.!=''] or seller_account_iban[.!=''] or seller_account_bban[.!=''] or seller_account_upic[.!=''] or seller_account_id[.!='']">
					&lt;Doc:SttlmTerms>
						<xsl:if test="fin_inst_bic[.!=''] or fin_inst_name[.!='']">
						&lt;Doc:FnlAgt>
							<xsl:choose>
								<xsl:when test="fin_inst_bic[.!='']">
									&lt;Doc:BIC><xsl:value-of select="fin_inst_bic"/>&lt;/Doc:BIC>
								</xsl:when>
								<xsl:otherwise>
									&lt;Doc:NmAndId>
										&lt;Doc:Id>
											<xsl:if test="fin_inst_street_name[.!='']">
												&lt;Doc:StrtNm><xsl:value-of select="fin_inst_street_name"/>&lt;Doc:/StrtNm>
											</xsl:if>
											&lt;Doc:PstCdId><xsl:value-of select="fin_inst_post_code"/>&lt;/Doc:PstCdId>
											&lt;Doc:TwnNm><xsl:value-of select="fin_inst_town_name"/>&lt;/Doc:TwnNm>
											<xsl:if test="fin_inst_country_sub_div[.!='']">
												&lt;Doc:CtrySubDvsn><xsl:value-of select="fin_inst_country_sub_div"/>&lt;/Doc:CtrySubDvsn>
											</xsl:if>
											&lt;Doc:Ctry><xsl:value-of select="fin_inst_country"/>&lt;/Doc:Ctry>
										&lt;Doc:Id>
										&lt;Doc:Name><xsl:value-of select="fin_inst_name"/>&lt;/Doc:Name>
									&lt;/Doc:NmAndId>
								</xsl:otherwise>
							</xsl:choose>
						&lt;/Doc:FnlAgt>
						</xsl:if>
						&lt;Doc:BnfcryAcct>
							<xsl:choose>
								<xsl:when test="seller_account_name[.=''] and (seller_account_iban[.!=''] or seller_account_bban[.!='']  or seller_account_upic[.!=''] or seller_account_id[.!=''])">
									&lt;Doc:Id>
										<xsl:choose>
											<xsl:when test="seller_account_iban[.!='']">
												&lt;Doc:IBAN><xsl:value-of select="seller_account_iban"/>&lt;/Doc:IBAN>
											</xsl:when>
											<xsl:when test="seller_account_bban[.!='']">
												&lt;Doc:BBAN><xsl:value-of select="seller_account_bban"/>&lt;/Doc:BBAN>
											</xsl:when>
											<xsl:when test="seller_account_upic[.!='']">
												&lt;Doc:UPIC><xsl:value-of select="seller_account_upic"/>&lt;/Doc:UPIC>
											</xsl:when>
											<xsl:when test="seller_account_id[.!='']">
												&lt;Doc:DmstAcct>
													&lt;Doc:Id><xsl:value-of select="seller_account_id"/>&lt;/Doc:Id>
												&lt;/Doc:DmstAcct>
											</xsl:when>
										</xsl:choose>
									&lt;/Doc:Id>
								</xsl:when>
								<xsl:when test="seller_account_name[.!=''] and (seller_account_iban[.!=''] or seller_account_bban[.!='']  or seller_account_upic[.!=''] or seller_account_id[.!=''])">
									&lt;Doc:NmAndId>
										&lt;Doc:Id>
											<xsl:choose>
												<xsl:when test="seller_account_iban[.!='']">
													&lt;Doc:IBAN><xsl:value-of select="seller_account_iban"/>&lt;/Doc:IBAN>
												</xsl:when>
												<xsl:when test="seller_account_bban[.!='']">
													&lt;Doc:BBAN><xsl:value-of select="seller_account_bban"/>&lt;/Doc:BBAN>
												</xsl:when>
												<xsl:when test="seller_account_upic[.!='']">
													&lt;Doc:UPIC><xsl:value-of select="seller_account_upic"/>&lt;/Doc:UPIC>
												</xsl:when>
												<xsl:when test="seller_account_id[.!='']">
													&lt;Doc:DmstAcct>
														&lt;Doc:Id><xsl:value-of select="seller_account_id"/>&lt;/Doc:Id>
													&lt;/Doc:DmstAcct>
												</xsl:when>
											</xsl:choose>
										&lt;/Doc:Id>
										&lt;Doc:Nm><xsl:value-of select="seller_account_name"/>&lt;/Doc:Nm>
									&lt;/Doc:NmAndId>
								</xsl:when>
								<xsl:when test="seller_account_name[.!='']">
									&lt;Doc:Nm><xsl:value-of select="seller_account_name"/>&lt;/Doc:Nm>
								</xsl:when>
								<xsl:otherwise>
									&lt;Doc:Nm>NA&lt;/Doc:Nm>
								</xsl:otherwise>
							</xsl:choose>
						&lt;/Doc:BnfcryAcct>
					&lt;/Doc:SttlmTerms>
					</xsl:if>
				&lt;/Doc:NewComrclDataSet>
				<!-- transport Dataset not generated  
				&lt;Doc:NewTrnsprtDataSet>
				
				&lt;/Doc:NewTrnsprtDataSet>
				-->
			&lt;/Doc:tsmt.014.001.02>
		&lt;/Doc:Document>
		</narrative_xml>
		
		<!-- Link DataSetSubmission with Invoice -->
		<cross_references>
			<cross_reference>
				<ref_id><xsl:value-of select="ref_id"/></ref_id>
				<product_code>IN</product_code>
				<child_product_code>TU</child_product_code>
				<child_ref_id><xsl:value-of select="$tuRefId"/></child_ref_id>
				<type_code>06</type_code>
			</cross_reference>
		</cross_references>
		
	</tu_tnx_record>
		
	</xsl:template>
	<!-- Line Item Template-->
	<xsl:template match="lt_tnx_record">
		&lt;Doc:ComrclLineItms>
			&lt;Doc:LineItmId><xsl:value-of select="cust_ref_id"/>&lt;/Doc:LineItmId>
			<!-- Line Item Quantity -->
			&lt;Doc:Qty>
				<xsl:choose>
					<xsl:when test="qty_other_unit_measr[.!='']">
						&lt;Doc:OthrUnitOfMeasr><xsl:value-of select="qty_other_unit_measr"/>&lt;/Doc:OthrUnitOfMeasr>
					</xsl:when>
					<xsl:otherwise>
						&lt;Doc:UnitOfMeasrCd><xsl:value-of select="qty_unit_measr_code"/>&lt;/Doc:UnitOfMeasrCd>
					</xsl:otherwise>
				</xsl:choose>
				&lt;Doc:Val><xsl:value-of select="qty_val"/>&lt;/Doc:Val>
				<xsl:if test="qty_factor[.!='']">
					&lt;Doc:Fctr><xsl:value-of select="qty_factor"/>&lt;/Doc:Fctr>
				</xsl:if>
			&lt;/Doc:Qty>
			<xsl:if test="qty_tol_pstv_pct[.!=''] or qty_tol_neg_pct[.!='']">
				&lt;Doc:QtyTlrnce>
					<xsl:choose>
						<xsl:when test="qty_tol_pstv_pct[.!='']">
							&lt;Doc:PlusPct><xsl:value-of select="qty_tol_pstv_pct"/>&lt;/Doc:PlusPct>
							&lt;Doc:MnsPct>0&lt;/Doc:MnsPct>
						</xsl:when>
						<xsl:when test="qty_tol_neg_pct[.!='']">
							&lt;Doc:PlusPct>0&lt;/Doc:PlusPct>
							&lt;Doc:MnsPct><xsl:value-of select="qty_tol_neg_pct"/>&lt;/Doc:MnsPct>
						</xsl:when>
					</xsl:choose>
				&lt;/Doc:QtyTlrnce>
			</xsl:if>
			<!-- Line Item Price -->
			<xsl:if test="price_amt[.!='']">
				&lt;Doc:UnitPric>
					<xsl:choose>
						<xsl:when test="price_other_unit_measr[.!='']">
							&lt;Doc:OthrUnitOfMeasr><xsl:value-of select="price_other_unit_measr"/>&lt;/Doc:OthrUnitOfMeasr>
						</xsl:when>
						<xsl:otherwise>
							&lt;Doc:UnitOfMeasrCd><xsl:value-of select="price_unit_measr_code"/>&lt;/Doc:UnitOfMeasrCd>
						</xsl:otherwise>
					</xsl:choose>
					&lt;Doc:Amt Ccy="<xsl:value-of select="price_cur_code"/>"><xsl:call-template name="CurrencyAndAmount_SimpleType">
							<xsl:with-param name="amount">
								<xsl:value-of select="price_amt"/>
							</xsl:with-param>
							</xsl:call-template>&lt;/Doc:Amt>
					<xsl:if test="price_factor[.!='']">
						&lt;Doc:Fctr><xsl:value-of select="price_factor"/>&lt;/Doc:Fctr>
					</xsl:if>
				&lt;/Doc:UnitPric>
			</xsl:if>
			<xsl:if test="price_tol_pstv_pct[.!=''] or price_tol_neg_pct[.!=''] ">
				&lt;Doc:PricTlrnce>
					&lt;Doc:PlusPct><xsl:choose>
               		<xsl:when test="price_tol_pstv_pct[.!='']"><xsl:value-of select="price_tol_pstv_pct"/></xsl:when>
               		<xsl:otherwise>0</xsl:otherwise>
               	</xsl:choose>&lt;/Doc:PlusPct>
					&lt;Doc:MnsPct><xsl:choose>
               		<xsl:when test="price_tol_neg_pct[.!='']"><xsl:value-of select="price_tol_neg_pct"/></xsl:when>
               		<xsl:otherwise>0</xsl:otherwise>
               	</xsl:choose>&lt;/Doc:MnsPct>
				&lt;/Doc:PricTlrnce>
			</xsl:if>
			<!-- Line item Details -->
			&lt;Doc:PdctNm><xsl:value-of select="product_name"/>&lt;/Doc:PdctNm>
			<!-- Line Item Product Identifiers -->
			<xsl:apply-templates select="product_identifiers/product_identifier"/>
			<!-- Line Item Product Characteristics -->
			<xsl:apply-templates select="product_characteristics/product_characteristic"/>
			<!-- Line Item Product Categories -->
			<xsl:apply-templates select="product_categories/product_category"/>
			<!-- Other Line Items Details -->
			<xsl:if test="product_orgn[.!='']">
				&lt;Doc:PdctOrgn><xsl:value-of select="product_orgn"/>&lt;/Doc:PdctOrgn>
			</xsl:if>
			<!-- Line Item Adjustments -->
			<xsl:apply-templates select="adjustments/allowance" mode="adjustments"/>
			<!-- Line Item Total Amount -->
			&lt;Doc:TtlAmt Ccy="<xsl:value-of select="total_net_cur_code"/>"><xsl:call-template name="CurrencyAndAmount_SimpleType">
					<xsl:with-param name="amount">
						<xsl:value-of select="total_net_amt"/>
					</xsl:with-param>
					</xsl:call-template>&lt;/Doc:TtlAmt>
		&lt;/Doc:ComrclLineItms>
	</xsl:template>
</xsl:stylesheet>
