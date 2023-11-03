<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:intools="xalan://com.misys.portal.interfaces.tools.InterfacesTools"
	xmlns:default="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:config="xalan://com.misys.portal.core.util.JetspeedResources"
	xmlns:idgenerator="xalan://com.misys.portal.product.util.generator.ReferenceIdGenerator"
	xmlns:tools="xalan://com.misys.portal.common.tools.ConvertTools"
	exclude-result-prefixes="tools default intools idgenerator config">
	
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
	<xsl:template match="po_tnx_record">
	
		<xsl:variable name="referenceId" select="idgenerator:generate('TU')"/>
		
		<tu_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/tu.xsd">
			<brch_code><xsl:value-of select="default:getResource('BRANCH_CODE')"/></brch_code>
			<ref_id><xsl:value-of select="$referenceId"/></ref_id>
    		<tnx_type_code>30</tnx_type_code>
			<prod_stat_code>03</prod_stat_code>
			<!-- Demo TSU -->
			<!-- <tnx_stat_code><xsl:value-of select="$tnxstatcode"/></tnx_stat_code>-->
			<tnx_stat_code>05</tnx_stat_code>
			<product_code>TU</product_code>
			<tid/>
			<po_ref_id><xsl:value-of select="ref_id"/></po_ref_id>
			<cpty_ref_id><xsl:value-of select="issuer_ref_id"/></cpty_ref_id>
			<cpty_bank></cpty_bank>
			<role><xsl:value-of select="submission_type"/></role>
			<tnx_cur_code><xsl:value-of select="total_cur_code"/></tnx_cur_code>
			<tnx_amt><xsl:value-of select="total_amt"/></tnx_amt>
			<cur_code><xsl:value-of select="total_cur_code"/></cur_code>
			<ordered_amt><!--<xsl:value-of select="total_amt"/>-->0</ordered_amt>
			<accepted_amt>0</accepted_amt>
			<buyer_name><xsl:value-of select="buyer_name"/></buyer_name>
			<seller_name><xsl:value-of select="seller_name"/></seller_name>
			<message_type>019</message_type>
			<baseline_stat_code></baseline_stat_code>
			<baseline_ref_id></baseline_ref_id>
			<request_for_action></request_for_action>
			<link_ref_id></link_ref_id>
			<issuing_bank>
				<abbv_name><xsl:value-of select="issuing_bank/abbv_name"/></abbv_name>
				<name><xsl:value-of select="issuing_bank/name"/></name>
				<iso_code><xsl:choose><xsl:when test="buyer_bank/iso_code[.!= '']"><xsl:value-of select="buyer_bank/iso_code"/></xsl:when><xsl:when test="buyer_bank/abbv_name[.!= '']"><xsl:value-of select="intools:retrieveBICFromAbbvName(buyer_bank/abbv_name, $context)"/></xsl:when><xsl:otherwise/></xsl:choose></iso_code>
			</issuing_bank>
			<!-- TSU MESSAGE -->
			<narrative_xml>
			&lt;Doc:Document xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:Doc="urn:iso:std:iso:20022:tech:xsd:tsmt.019.001.03">
			&lt;Doc:InitlBaselnSubmissn>
				&lt;Doc:SubmissnId>
					&lt;Doc:Id><xsl:value-of select="$referenceId"/>&lt;/Doc:Id>
					&lt;Doc:CreDtTm><xsl:value-of select="tools:getW3CIsoDateTime()"/>&lt;/Doc:CreDtTm>
				&lt;/Doc:SubmissnId>
				&lt;Doc:SubmitrTxRef>
					&lt;Doc:Id><xsl:value-of select="ref_id"/>&lt;/Doc:Id>
				&lt;/Doc:SubmitrTxRef>
				&lt;Doc:Instr>
					&lt;Doc:Tp><xsl:value-of select="submission_type"/>&lt;/Doc:Tp>
				&lt;/Doc:Instr>
				&lt;Doc:Baseln>
					&lt;Doc:SubmitrBaselnId>
						&lt;Doc:Id><xsl:value-of select="ref_id"/>&lt;/Doc:Id>
						&lt;Doc:Vrsn>0&lt;/Doc:Vrsn>
						&lt;Doc:Submitr>&lt;Doc:BIC><xsl:choose>
							<!-- submit by Issuing Bank -->
							<xsl:when test="issuing_bank/iso_code[.!= '']"><xsl:value-of select="issuing_bank/iso_code"/></xsl:when>
							<xsl:when test="issuing_bank/abbv_name[.!= '']"><xsl:value-of select="intools:retrieveBICFromAbbvName(issuing_bank/abbv_name, $context)"/></xsl:when>
							<xsl:otherwise/>
						</xsl:choose>&lt;/Doc:BIC>
						&lt;/Doc:Submitr>
					&lt;/Doc:SubmitrBaselnId>
					&lt;Doc:SvcCd>LEV1&lt;/Doc:SvcCd>
					&lt;Doc:PurchsOrdrRef>
						&lt;Doc:Id><xsl:value-of select="ref_id"/>&lt;/Doc:Id>
						&lt;Doc:DtOfIsse><xsl:call-template name="ISODate">
								<xsl:with-param name="date">
									<xsl:value-of select="appl_date"/>
								</xsl:with-param></xsl:call-template>&lt;/Doc:DtOfIsse>
					&lt;/Doc:PurchsOrdrRef>
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
					<xsl:if test="ship_to_name[.!='']">
						&lt;Doc:ShipTo>
							&lt;Doc:Nm><xsl:value-of select="ship_to_name"/>&lt;/Doc:Nm>
							&lt;Doc:PstlAdr>
								&lt;Doc:StrtNm><xsl:value-of select="ship_to_street_name"/>&lt;/Doc:StrtNm>
								&lt;Doc:PstCdId><xsl:value-of select="ship_to_post_code"/>&lt;/Doc:PstCdId>
								&lt;Doc:TwnNm><xsl:value-of select="ship_to_town_name"/>&lt;/Doc:TwnNm>
								&lt;Doc:CtrySubDvsn><xsl:value-of select="ship_to_country_sub_div"/>&lt;/Doc:CtrySubDvsn>
								&lt;Doc:Ctry><xsl:value-of select="ship_to_country"/>&lt;/Doc:Ctry>
							&lt;/Doc:PstlAdr>
						&lt;/Doc:ShipTo>
					</xsl:if>
					<xsl:if test="consgn_name[.!='']">
						&lt;Doc:Consgn>
							&lt;Doc:Nm><xsl:value-of select="consgn_name"/>&lt;/Doc:Nm>
							&lt;Doc:PstlAdr>
								&lt;Doc:StrtNm><xsl:value-of select="consgn_street_name"/>&lt;/Doc:StrtNm>
								&lt;Doc:PstCdId><xsl:value-of select="consgn_post_code"/>&lt;/Doc:PstCdId>
								&lt;Doc:TwnNm><xsl:value-of select="consgn_town_name"/>&lt;/Doc:TwnNm>
								&lt;Doc:CtrySubDvsn><xsl:value-of select="consgn_country_sub_div"/>&lt;/Doc:CtrySubDvsn>
								&lt;Doc:Ctry><xsl:value-of select="consgn_country"/>&lt;/Doc:Ctry>
							&lt;/Doc:PstlAdr>
						&lt;/Doc:Consgn>
					</xsl:if>
					&lt;Doc:Goods>
						<!-- Carriage returns ?-->
						<xsl:if test="goods_desc[. != '']">
							&lt;Doc:GoodsDesc><xsl:value-of select="goods_desc"/>&lt;/Doc:GoodsDesc>
						</xsl:if>
						&lt;Doc:PrtlShipmnt><xsl:call-template name="YesNoIndicator">
								<xsl:with-param name="value">
									<xsl:value-of select="part_ship"/>
								</xsl:with-param></xsl:call-template>&lt;/Doc:PrtlShipmnt>
						<!--&lt;Doc:PrtlShipmnt>false&lt;/Doc:PrtlShipmnt>-->
						<xsl:if test="tran_ship[.!='']">
						&lt;Doc:TrnsShipmnt><xsl:call-template name="YesNoIndicator">
								<xsl:with-param name="value">
									<xsl:value-of select="tran_ship"/>
								</xsl:with-param></xsl:call-template>&lt;/Doc:TrnsShipmnt>
						</xsl:if>
						<xsl:if test="last_ship_date[.!='']">
							&lt;Doc:ShipmntDtRg>
								&lt;Doc:LatstShipmntDt><xsl:call-template name="ISODate">
										<xsl:with-param name="date">
											<xsl:value-of select="last_ship_date"/>
										</xsl:with-param>
									</xsl:call-template>&lt;/Doc:LatstShipmntDt>
							&lt;/Doc:ShipmntDtRg>
						</xsl:if>
						<!-- Line Items -->
						<xsl:apply-templates select="line_items/lt_tnx_record"/>
						&lt;Doc:LineItmsTtlAmt Ccy="<xsl:value-of select="total_cur_code"/>"><xsl:call-template name="CurrencyAndAmount_SimpleType">
								<xsl:with-param name="amount">
									<xsl:value-of select="total_amt"/>
								</xsl:with-param></xsl:call-template>&lt;/Doc:LineItmsTtlAmt>
						<!-- Routing Summaries -->
						<xsl:apply-templates select="routing_summaries"/>
						
						<!--RtgSummry>
							<xsl:choose>
								<xsl:when test="count(routing_summaries/routing_summary[type='01']) > 0">
									&lt;Doc:IndvTrnsprt-->
							<!-- PO Transport By Air -->
							<!--xsl:apply-templates select="routing_summaries/routing_summary[type='01' and transport_mode='02']" mode="by_air"/-->
							<!-- PO Transport By Sea -->
							<!--xsl:apply-templates select="routing_summaries/routing_summary[type='01' and transport_mode='01']"/-->
							<!-- PO Transport By Road -->
							<!--xsl:apply-templates select="routing_summaries/routing_summary[type='01' and transport_mode='03']"/-->
							<!-- PO Transport By Rail -->
							<!--xsl:apply-templates select="routing_summaries/routing_summary[type='01' and transport_mode='04']"/-->
							<!--/IndvTrnsprt>								
								</xsl:when>
								<xsl:when test="count(routing_summaries/routing_summary[type='02']) > 0">
									&lt;Doc:MltmdlTrnsprt-->
							<!-- PO Transport Depart Airport -->
							<!--xsl:apply-templates select="routing_summaries/routing_summary[type='02' and transport_mode='02' and transport_sub_type='01']"/-->
							<!-- PO Transport Depart Airport  -->
							<!--xsl:apply-templates select="routing_summaries/routing_summary[type='02' and transport_mode='02' and transport_sub_type='02']"/-->
							<!-- PO Transport Port Of Loading -->
							<!--xsl:apply-templates select="routing_summaries/routing_summary[type='02' and transport_mode='01' and transport_sub_type='01']"/-->
							<!-- PO Transport Port Of Discharge -->
							<!--xsl:apply-templates select="routing_summaries/routing_summary[type='02' and transport_mode='01' and transport_sub_type='02']"/-->
							<!-- PO Transport Place of Reception -->
							<!--xsl:apply-templates select="routing_summaries/routing_summary[type='02' and transport_mode='01' and transport_sub_type='02']"/-->
							<!-- PO Transport Place Delivery -->
							<!--xsl:apply-templates select="routing_summaries/routing_summary[type='02' and transport_mode='01' and transport_sub_type='02']"/-->
							<!-- PO Transport Taking Charge -->
							<!--xsl:apply-templates select="routing_summaries/routing_summary[type='02' and transport_mode='01' and transport_sub_type='02']"/-->
							<!-- PO Transport Place of Final Destination -->
							<!--xsl:apply-templates select="routing_summaries/routing_summary[type='02' and transport_mode='01' and transport_sub_type='02']"/-->
							<!--/MltmdlTrnsprt>								
								</xsl:when>
							</xsl:choose>
						</RtgSummry-->
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
								</xsl:with-param></xsl:call-template>&lt;/Doc:TtlNetAmt>
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
									&lt;Doc:NmAndAdr>
										&lt;Doc:Nm><xsl:value-of select="fin_inst_name"/>&lt;/Doc:Nm>
										&lt;Doc:Adr>
											<xsl:if test="fin_inst_street_name[.!='']">
												&lt;Doc:StrtNm><xsl:value-of select="fin_inst_street_name"/>&lt;/Doc:StrtNm>
											</xsl:if>
											&lt;Doc:PstCdId><xsl:value-of select="fin_inst_post_code"/>&lt;/Doc:PstCdId>
											&lt;Doc:TwnNm><xsl:value-of select="fin_inst_town_name"/>&lt;/Doc:TwnNm>
											<xsl:if test="fin_inst_country_sub_div[.!='']">
												&lt;Doc:CtrySubDvsn><xsl:value-of select="fin_inst_country_sub_div"/>&lt;/Doc:CtrySubDvsn>
											</xsl:if>
											&lt;Doc:Ctry><xsl:value-of select="fin_inst_country"/>&lt;/Doc:Ctry>
										&lt;/Doc:Adr>
									&lt;/Doc:NmAndAdr>
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
					
					<xsl:if test="obligor_bank/iso_code or obligor_bank/iso_code != ''">
						&lt;Doc:PmtOblgtn>
							&lt;Doc:OblgrBk>
								&lt;Doc:BIC><xsl:choose>
							<xsl:when test="obligor_bank/iso_code[.!= '']"><xsl:value-of select="obligor_bank/iso_code"/></xsl:when>
							<xsl:when test="obligor_bank/abbv_name[.!= '']"><xsl:value-of select="intools:retrieveBICFromAbbvName(obligor_bank/abbv_name, $context)"/></xsl:when>
							<xsl:otherwise/>
						</xsl:choose>&lt;Doc:BIC>
							&lt;/Doc:OblgrBk>
							&lt;Doc:RcptBk>
								&lt;Doc:BIC><xsl:choose>
							<xsl:when test="recipient_bank/iso_code[.!= '']"><xsl:value-of select="recipient_bank/iso_code"/></xsl:when>
							<xsl:when test="recipient_bank/abbv_name[.!= '']"><xsl:value-of select="intools:retrieveBICFromAbbvName(recipient_bank/abbv_name, $context)"/></xsl:when>
							<xsl:otherwise/>
						</xsl:choose>&lt;Doc:BIC>
							&lt;/Doc:RcptBk>
							<!-- BPO Amount -->
							<xsl:if test="bpo_amt[.!= '']">
								&lt;Doc:Amt Ccy="<xsl:value-of select="bpo_cur_code"/>"><xsl:call-template name="CurrencyAndAmount_SimpleType">
										<xsl:with-param name="amount">
											<xsl:value-of select="bpo_amt"/>
										</xsl:with-param></xsl:call-template>&lt;/Doc:Amt>
							</xsl:if>
							<!-- BPO Percentage -->
							<xsl:if test="bpo_pct[.!= '']">
								&lt;Doc:Pctg><xsl:value-of select="bpo_pct"/>&lt;/Doc:Pctg>
							</xsl:if>
							<!-- BPO Charges Amount -->
							<xsl:if test="bpo_amt[.!= '']">
								&lt;Doc:ChrgsAmt Ccy="<xsl:value-of select="bpo_chrg_cur_code"/>"><xsl:call-template name="CurrencyAndAmount_SimpleType">
										<xsl:with-param name="amount">
											<xsl:value-of select="bpo_chrg_amt"/>
										</xsl:with-param></xsl:call-template>&lt;/Doc:ChrgsAmt>
							</xsl:if>
							<!-- BPO Charges Percentage -->
							<xsl:if test="bpo_chrg_pct[.!= '']">
								&lt;Doc:ChrgsPctg><xsl:value-of select="bpo_chrg_pct"/>&lt;/Doc:ChrgsPctg>
							</xsl:if>
							<!-- BPO Expiry Date -->
							<xsl:if test="bpo_exp_date[.!= '']">
								&lt;Doc:XpryDt><xsl:call-template name="ISODate">
								<xsl:with-param name="date">
									<xsl:value-of select="bpo_exp_date"/>
								</xsl:with-param></xsl:call-template>&lt;/Doc:XpryDt>
							</xsl:if>
							<!-- BPO Applicable Law -->
							<xsl:if test="bpo_applicable_law[.!= '']">
								&lt;Doc:AplblLaw><xsl:value-of select="bpo_applicable_law"/>&lt;/Doc:AplblLaw>
							</xsl:if>
						&lt;/Doc:PmtOblgtn>
					</xsl:if>
					
					</xsl:if>
						<xsl:if test="last_match_date[.!='']">
						&lt;Doc:LatstMtchDt><xsl:call-template name="ISODate">
								<xsl:with-param name="date">
									<xsl:value-of select="last_match_date"/>
								</xsl:with-param></xsl:call-template>&lt;/Doc:LatstMtchDt>
						</xsl:if>
						&lt;Doc:ComrclDataSetReqrd>
							&lt;Doc:Submitr>
								&lt;Doc:BIC><xsl:choose>
								<!-- submit by buyer -->
								<!--<xsl:when test="issuer_type_code[.='01']">
									<xsl:choose>
										<xsl:when test="buyer_bank/iso_code[.!= '']"><xsl:value-of select="buyer_bank/iso_code"/></xsl:when>
										<xsl:when test="buyer_bank/abbv_name[.!= '']"><xsl:value-of select="intools:retrieveBICFromAbbvName(buyer_bank/abbv_name, $context)"/></xsl:when>
										<xsl:otherwise/>
									</xsl:choose>
								</xsl:when>-->
								<!-- submit by seller -->
								<!-- <xsl:otherwise>
									<xsl:choose>-->
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
									<!-- </xsl:choose>
								</xsl:otherwise>-->
							</xsl:choose>&lt;/Doc:BIC>
							&lt;/Doc:Submitr>
						&lt;/Doc:ComrclDataSetReqrd>
						<xsl:if test="reqrd_transport_dataset = 'Y'">
							&lt;Doc:TrnsprtDataSetReqrd>
								&lt;Doc:Submitr>
									&lt;Doc:BIC><xsl:choose>
									<!-- submit by buyer -->
									<!--<xsl:when test="issuer_type_code[.='01']">
										<xsl:choose>
											<xsl:when test="buyer_bank/iso_code[.!= '']"><xsl:value-of select="buyer_bank/iso_code"/></xsl:when>
											<xsl:when test="buyer_bank/abbv_name[.!= '']"><xsl:value-of select="intools:retrieveBICFromAbbvName(buyer_bank/abbv_name, $context)"/></xsl:when>
											<xsl:otherwise/>
										</xsl:choose>
									</xsl:when>-->
									<!-- submit by seller -->
									<!-- <xsl:otherwise>
										<xsl:choose>-->
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
										<!-- </xsl:choose>
									</xsl:otherwise>-->
								</xsl:choose>&lt;/Doc:BIC>
								&lt;/Doc:Submitr>
							&lt;/Doc:TrnsprtDataSetReqrd>
							&lt;Doc:InttToPayXpctd>false&lt;/Doc:InttToPayXpctd>
						</xsl:if>
						&lt;/Doc:Baseln>
						<!-- Buyer Contact -->
						<xsl:apply-templates select="contacts/contact[type='02']"/>
						<!-- Seller Contact -->
						<xsl:apply-templates select="contacts/contact[type='01']"/>
						<!-- Buyer Bank Contact -->
						<xsl:apply-templates select="contacts/contact[type='04']"/>
						<!-- Seller Bank Contact -->
						<xsl:apply-templates select="contacts/contact[type='03']"/>
						<!-- Bill To Contact -->
						<xsl:apply-templates select="contacts/contact[type='05']"/>
						<!-- Ship To Contact -->
						<xsl:apply-templates select="contacts/contact[type='06']"/>
						<!-- Consignee Contact -->
						<xsl:apply-templates select="contacts/contact[type='07']"/>
			&lt;/Doc:InitlBaselnSubmissn>
		&lt;/Doc:Document>
		</narrative_xml>
	</tu_tnx_record>
		
	</xsl:template>
</xsl:stylesheet>
