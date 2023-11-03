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
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" cdata-section-elements="narrative_xml"/>
	
	<!-- Get the interface environment -->
	<xsl:param name="context"/>
	
	<xsl:variable name="grouping_separator"><xsl:text>,</xsl:text></xsl:variable>
	<xsl:variable name="decimal_separator"><xsl:text>.</xsl:text></xsl:variable>
	
	<!--
	Copyright (c) 2000-2007 NEOMAlogic (http://www.neomalogic.com),
	All Rights Reserved. 
	-->

	<!--                      -->
	<!-- TSU to Oppen Account -->
	<!--                      -->
	
	<!-- Line Item Template-->
	<xsl:template match="lt_tnx_record">
		&lt;Doc:LineItmDtls>
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
							</xsl:with-param></xsl:call-template>&lt;/Doc:Amt>
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
			<!-- Other Line Items Details-->
			<xsl:if test="product_orgn[.!='']">
				&lt;Doc:PdctOrgn><xsl:value-of select="product_orgn"/>&lt;/Doc:PdctOrgn>
			</xsl:if>
			<xsl:if test="last_ship_date[.!='']">
			&lt;Doc:LatstShipmntDt><xsl:call-template name="ISODate">
					<xsl:with-param name="date">
						<xsl:value-of select="last_ship_date"/>
					</xsl:with-param></xsl:call-template>&lt;/Doc:LatstShipmntDt>
			</xsl:if>
			<!-- Line item Routing Summary -->
			<xsl:apply-templates select="routing_summaries"/>
			<!--RtgSummry>
				<xsl:choose>
					<xsl:when test="count(routing_summaries/routing_summary[type='01']) > 0">
						&lt;Doc:IndvTrnsprt-->
						<!-- Line Item Transport By Air -->
						<!--xsl:apply-templates select="routing_summaries/routing_summary[type='01' and transport_mode='02']" mode="by_air"/-->
						<!-- Line ItemTransport By Sea -->
						<!--xsl:apply-templates select="routing_summaries/routing_summary[type='01' and transport_mode='01']"/-->
						<!-- Line Item Transport By Road -->
						<!--xsl:apply-templates select="routing_summaries/routing_summary[type='01' and transport_mode='03']"/-->
						<!-- Line Item Transport By Rail -->
						<!--xsl:apply-templates select="routing_summaries/routing_summary[type='01' and transport_mode='04']"/-->
						<!--/IndvTrnsprt>								
					</xsl:when>
					<xsl:when test="count(routing_summaries/routing_summary[type='02']) > 0">
						&lt;Doc:MltmdlTrnsprt-->
						<!-- Line Item Transport Depart Airport -->
						<!--xsl:apply-templates select="routing_summaries/routing_summary[type='02' and transport_mode='02' and transport_sub_type=['01']"/-->
						<!-- Line Item Transport Depart Airport  -->
						<!--xsl:apply-templates select="routing_summaries/routing_summary[type='02' and transport_mode='02' and transport_sub_type=['02']]"/-->
						<!-- Line Item Transport Port Of Loading -->
						<!--xsl:apply-templates select="routing_summaries/routing_summary[type='02' and transport_mode='01' and transport_sub_type=['01']]"/-->
						<!--  PO Transport Port Of Discharge -->
						<!--xsl:apply-templates select="routing_summaries/routing_summary[type='02' and transport_mode='01' and transport_sub_type=['02']]"/-->
						<!--  PO Transport Place of Reception -->
						<!--xsl:apply-templates select="routing_summaries/routing_summary[type='02' and transport_mode='01' and transport_sub_type=['02']]"/-->
						<!--  PO Transport Place Delivery -->
						<!--xsl:apply-templates select="routing_summaries/routing_summary[type='02' and transport_mode='01' and transport_sub_type=['02']]"/-->
						<!--  PO Transport Taking Charge -->
						<!--xsl:apply-templates select="routing_summaries/routing_summary[type='02' and transport_mode='01' and transport_sub_type=['02']]"/-->
						<!--  PO Transport Place of Final Destination -->
						<!--xsl:apply-templates select="routing_summaries/routing_summary[type='02' and transport_mode='01' and transport_sub_type=['02']]"/-->
						<!--/MltmdlTrnsprt>								
					</xsl:when>
				</xsl:choose>
			</RtgSummry-->
			<!-- Line Item Inco Terms -->
			<xsl:apply-templates select="incoterms/incoterm"/>
			<!-- Line Item Adjustments -->
			<xsl:apply-templates select="adjustments/allowance" mode="adjustments"/>
			<!-- Line Item Total Amount -->
			&lt;Doc:TtlAmt Ccy="<xsl:value-of select="total_net_cur_code"/>"><xsl:call-template name="CurrencyAndAmount_SimpleType">
					<xsl:with-param name="amount">
						<xsl:value-of select="total_net_amt"/>
					</xsl:with-param></xsl:call-template>&lt;/Doc:TtlAmt>
		&lt;/Doc:LineItmDtls>
	</xsl:template>
	<!-- Payment Terms Template -->
	<xsl:template match="payment">
		&lt;Doc:PmtTerms>
			<xsl:choose>
				<xsl:when test="other_paymt_terms[.!='']">
					&lt;Doc:OthrPmtTerms>
						<xsl:value-of select="other_paymt_terms"/>
					&lt;/Doc:OthrPmtTerms>
				</xsl:when>
				<xsl:otherwise>
					&lt;Doc:PmtCd>
						&lt;Doc:Cd><xsl:value-of select="code"/>&lt;/Doc:Cd>
						<xsl:if test="nb_days[.!='']">
							&lt;Doc:NbOfDays><xsl:value-of select="nb_days"/>&lt;/Doc:NbOfDays>
						</xsl:if>
					&lt;/Doc:PmtCd>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="pct[.!='']">
					&lt;Doc:Pctg><xsl:value-of select="pct"/>&lt;/Doc:Pctg>
				</xsl:when>
				<xsl:otherwise>
					&lt;Doc:Amt Ccy="<xsl:value-of select="cur_code"/>"><xsl:call-template name="CurrencyAndAmount_SimpleType">
							<xsl:with-param name="amount">
								<xsl:value-of select="amt"/>
							</xsl:with-param></xsl:call-template>&lt;/Doc:Amt>
				</xsl:otherwise>
			</xsl:choose>
		&lt;/Doc:PmtTerms>
	</xsl:template>
	<!-- Inco Terms Template -->
	<xsl:template match="incoterm">
		&lt;Doc:Incotrms>
			<xsl:choose>
				<xsl:when test="other[.!='']">
					&lt;Doc:Othr><xsl:value-of select="other"/>&lt;/Doc:Othr>
				</xsl:when>
				<xsl:otherwise>
					&lt;Doc:Cd><xsl:value-of select="code"/>&lt;/Doc:Cd>
				</xsl:otherwise>
			</xsl:choose>
			&lt;Doc:Lctn><xsl:value-of select="location"/>&lt;/Doc:Lctn>
		&lt;/Doc:Incotrms>
	</xsl:template>
	<!-- Freight Charges Template -->
	<xsl:template match="allowance" mode="freight_charges">
		&lt;Doc:Chrgs>
			<xsl:choose>
				<xsl:when test="other_type[.!='']">
					&lt;Doc:OthrChrgsTp><xsl:value-of select="other_type"/>&lt;/Doc:OthrChrgsTp>
				</xsl:when>
				<xsl:otherwise>
					&lt;Doc:Tp><xsl:value-of select="type"/>&lt;/Doc:Tp>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="amt[.!='']">
					&lt;Doc:Amt Ccy="<xsl:value-of select="cur_code"/>"><xsl:call-template name="CurrencyAndAmount_SimpleType">
							<xsl:with-param name="amount">
								<xsl:value-of select="amt"/>
							</xsl:with-param></xsl:call-template>&lt;/Doc:Amt>
				</xsl:when>
				<xsl:otherwise>
					&lt;Doc:Rate><xsl:call-template name="PercentageRate">
							<xsl:with-param name="rate">
								<xsl:value-of select="rate"/>
							</xsl:with-param></xsl:call-template>
					&lt;/Doc:Rate>
				</xsl:otherwise>
			</xsl:choose>
		&lt;/Doc:Chrgs>
	</xsl:template>
	
	<!-- Adjustments Template -->
	<xsl:template match="allowance" mode="adjustments">
		&lt;Doc:Adjstmnt>
			<xsl:choose>
				<xsl:when test="other_type[.!='']">
					&lt;Doc:OthrAdjstmntTp><xsl:value-of select="other_type"/>&lt;/Doc:OthrAdjstmntTp>
				</xsl:when>
				<xsl:otherwise>
					&lt;Doc:Tp><xsl:value-of select="type"/>&lt;/Doc:Tp>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="amt[.!='']">
					&lt;Doc:Amt Ccy="<xsl:value-of select="cur_code"/>"><xsl:call-template name="CurrencyAndAmount_SimpleType">
							<xsl:with-param name="amount">
								<xsl:value-of select="amt"/>
							</xsl:with-param></xsl:call-template>&lt;/Doc:Amt>
				</xsl:when>
				<xsl:otherwise>
					&lt;Doc:Rate><xsl:call-template name="PercentageRate">
							<xsl:with-param name="rate">
								<xsl:value-of select="rate"/>
							</xsl:with-param></xsl:call-template>
					&lt;/Doc:Rate>
				</xsl:otherwise>
			</xsl:choose>
			&lt;Doc:Drctn><xsl:value-of select="direction"/>&lt;/Doc:Drctn>
		&lt;/Doc:Adjstmnt>
	</xsl:template>
	
	<!-- Taxes Template -->
	<xsl:template match="allowance" mode="taxes">
		&lt;Doc:Tax>
			<xsl:choose>
				<xsl:when test="other_type[.!='']">
					&lt;Doc:OthrTaxTp><xsl:value-of select="other_type"/>&lt;/Doc:OthrTaxTp>
				</xsl:when>
				<xsl:otherwise>
					&lt;Doc:Tp><xsl:value-of select="type"/>&lt;/Doc:Tp>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="amt[.!='']">
					&lt;Doc:Amt> Ccy="<xsl:value-of select="cur_code"/>"><xsl:call-template name="CurrencyAndAmount_SimpleType">
							<xsl:with-param name="amount">
								<xsl:value-of select="amt"/>
							</xsl:with-param>
						</xsl:call-template>&lt;/Doc:Amt>
				</xsl:when>
				<xsl:otherwise>
					&lt;Doc:Rate><xsl:call-template name="PercentageRate">
							<xsl:with-param name="rate">
								<xsl:value-of select="rate"/>
							</xsl:with-param></xsl:call-template>&lt;/Doc:Rate>
				</xsl:otherwise>
			</xsl:choose>
		&lt;/Doc:Tax>
	</xsl:template>
	
	<!-- Buyer Informations -->
	<xsl:template match="user_defined_information" mode="buyer">
		&lt;Doc:BuyrDfndInf>
			&lt;Doc:Labl><xsl:value-of select="label"/>&lt;/Doc:Labl>
			&lt;Doc:Inf><xsl:value-of select="information"/>&lt;/Doc:Inf>
		&lt;/Doc:BuyrDfndInf>
	</xsl:template>
	
	<!--Seller Informations -->
	<xsl:template match="user_defined_information" mode="seller">
		&lt;Doc:SellrDfndInf>
			&lt;Doc:Labl><xsl:value-of select="label"/>&lt;/Doc:Labl>
			&lt;Doc:Inf><xsl:value-of select="information"/>&lt;/Doc:Inf>
		&lt;/Doc:SellrDfndInf>
	</xsl:template>
	
	<!-- Transport By Air -->
	<xsl:template match="routing_summary" mode="by_air">
		&lt;Doc:TrnsprtByAir>
			<!-- Departure -->
			<!-- Destination -->
		&lt;/Doc:TrnsprtByAir>
	</xsl:template>
	<!-- Airport Template -->
	<!--xsl:template name="airport">
		<xsl:choose>
			<xsl:when test="">
				&lt;Doc:AirprtCd>
					<xsl:value-of select="label"/>
				</AirprtCd>
			</xsl:when>
			<xsl:when test="">
				&lt;Doc:OthrAirprtDesc>
						
					</OthrAirprtDesc>
			</xsl:when>
		</xsl:choose>
	</xsl:template-->
	
	<!-- Product Identifiers-->
	<xsl:template match="product_identifier">
		&lt;Doc:PdctIdr>
			<xsl:choose>
				<xsl:when test="other_type[.!='']">
					&lt;Doc:OthrPdctIdr>
						&lt;Doc:Id><xsl:value-of select="other_type"/>&lt;/Doc:Id>
						&lt;Doc:IdTp><xsl:value-of select="identifier"/>&lt;/Doc:IdTp>
					&lt;/Doc:OthrPdctIdr>
				</xsl:when>
				<xsl:otherwise>
					&lt;Doc:StrdPdctIdr>
						&lt;Doc:Tp><xsl:value-of select="type"/>&lt;/Doc:Tp>
						&lt;Doc:Idr><xsl:value-of select="identifier"/>&lt;/Doc:Idr>
					&lt;/Doc:StrdPdctIdr>
				</xsl:otherwise>
			</xsl:choose>
		&lt;/Doc:PdctIdr>
	</xsl:template>
	
	<!-- Product Characteristics-->
	<xsl:template match="product_characteristic">
		&lt;Doc:PdctChrtcs>
			<xsl:choose>
				<xsl:when test="other_type[.!='']">
					&lt;Doc:OthrPdctChrtcs>
						&lt;Doc:Id><xsl:value-of select="other_type"/>&lt;/Doc:Id>
						&lt;Doc:IdTp><xsl:value-of select="identifier"/>&lt;/Doc:IdTp>
					&lt;/Doc:OthrPdctChrtcs>
				</xsl:when>
				<xsl:otherwise>
					&lt;Doc:StrdPdctChrtcs>
						&lt;Doc:Tp><xsl:value-of select="type"/>&lt;/Doc:Tp>
						&lt;Doc:Chrtcs><xsl:value-of select="characteristic"/>&lt;/Doc:Chrtcs>
					&lt;/Doc:StrdPdctChrtcs>
				</xsl:otherwise>
			</xsl:choose>
		&lt;/Doc:PdctChrtcs>
	</xsl:template>
	
	<!-- Product Categories-->
	<xsl:template match="product_category">
		&lt;Doc:PdctCtgy>
			<xsl:choose>
				<xsl:when test="other_type[.!='']">
					&lt;Doc:OthrPdctCtgy>
						&lt;Doc:Id><xsl:value-of select="other_type"/>&lt;/Doc:Id>
						&lt;Doc:IdTp><xsl:value-of select="identifier"/>&lt;/Doc:IdTp>
					&lt;/Doc:OthrPdctCtgy>
				</xsl:when>
				<xsl:otherwise>
					&lt;Doc:StrdPdctCtgy>
						&lt;Doc:Tp><xsl:value-of select="type"/>&lt;/Doc:Tp>
						&lt;Doc:Ctgy><xsl:value-of select="category"/>&lt;/Doc:Ctgy>
					&lt;/Doc:StrdPdctCtgy>
				</xsl:otherwise>
			</xsl:choose>
		&lt;/Doc:PdctCtgy>
	</xsl:template>
	
	<!-- Contact Person Template -->
	<!--xsl:template name="contact_person">
		<xsl:param name="root_node"/>
		<xsl:param name="type"/>
		<xsl:for-each select="*[name() = concat('contact_',$type)]">
			<xsl:if test="./name[.!='']">
				<xsl:element name="{$root_node}">
					<xsl:apply-templates select="."/>
				</xsl:element>
			</xsl:if>
		</xsl:for-each>
	</xsl:template-->
	<!-- Contact Person Details -->
	<xsl:template match="contact">
		<xsl:if test="name[.!='']">
			<xsl:variable name="rootName">
				<xsl:choose>
					<xsl:when test="type[.='02']">BuyrCtctPrsn</xsl:when>
					<xsl:when test="type[.='01']">SellrCtctPrsn</xsl:when>
					<xsl:when test="type[.='04']">BuyrBkCtctPrsn</xsl:when>
					<xsl:when test="type[.='03']">SellrBkCtctPrsn</xsl:when>
					<xsl:when test="type[.='05']">BllToCtctPrsn</xsl:when>
					<xsl:when test="type[.='06']">ShipToCtctPrsn</xsl:when>
					<xsl:when test="type[.='07']">ConsgnCtctPrsn</xsl:when>
				</xsl:choose>
			</xsl:variable>
			&lt;Doc:<xsl:value-of select="$rootName"/>>
				&lt;Doc:Nm><xsl:value-of select="name"/>&lt;/Doc:Nm>
				<xsl:if test="name_prefix[.!='']">&lt;Doc:NmPrfx><xsl:value-of select="name_prefix"/>&lt;/Doc:NmPrfx></xsl:if>
				<xsl:if test="given_name[.!='']">&lt;Doc:GvnNm><xsl:value-of select="given_name"/>&lt;/Doc:GvnNm></xsl:if>
				<xsl:if test="role[.!='']">&lt;Doc:Role><xsl:value-of select="role"/>&lt;/Doc:Role></xsl:if>
				<xsl:if test="phone_number[.!='']">&lt;Doc:PhneNb><xsl:value-of select="phone_number"/>&lt;/Doc:PhneNb></xsl:if>
				<xsl:if test="fax_number[.!='']">&lt;Doc:FaxNb><xsl:value-of select="fax_number"/>&lt;/Doc:FaxNb></xsl:if>
				<xsl:if test="email[.!='']">&lt;Doc:EmailAdr><xsl:value-of select="email"/>&lt;/Doc:EmailAdr></xsl:if>
			&lt;/Doc:<xsl:value-of select="$rootName"/>>
		</xsl:if>
	</xsl:template>
	
	<!-- ISODate Template -->
	<xsl:template name="ISODate">
		<xsl:param name="date"/>
		<xsl:value-of select="substring($date, 7, 4)"/>-<xsl:value-of select="substring($date,4, 2)"/>-<xsl:value-of select="substring($date,1,2)"/>
	</xsl:template>
	
	<!-- YesNoIndicator Template -->
	<xsl:template name="YesNoIndicator">
		<xsl:param name="value"/>
		<xsl:choose>
			<xsl:when test="$value='Y'">true</xsl:when>
			<xsl:when test="$value='N'">false</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<!-- Amount Template TP -> TSU -->
	<xsl:template name="CurrencyAndAmount_SimpleType">
		<xsl:param name="amount"/>
		<xsl:variable name="grouping_separator"><xsl:text>,</xsl:text></xsl:variable>
		<xsl:choose>
			<xsl:when test="contains($amount,$grouping_separator)">
				<xsl:value-of select="substring-before($amount,$grouping_separator)"/><xsl:call-template name="CurrencyAndAmount_SimpleType">
					<xsl:with-param name="amount" select="substring-after($amount,$grouping_separator)"/></xsl:call-template>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$amount"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- Rate Template (= Amount Template) -->
	<xsl:template name="PercentageRate">
		<xsl:param name="rate"/><xsl:call-template name="CurrencyAndAmount_SimpleType">
				<xsl:with-param name="amount"><xsl:value-of select="$rate"/></xsl:with-param></xsl:call-template>
</xsl:template>
		
	<!-- Routing Summaries Template -->
	<xsl:template match="routing_summaries">
		<xsl:if test="routing_summary">
		&lt;Doc:RtgSummry>
			<xsl:choose>
				<!-- Individual Transport-->
				<xsl:when test="count(routing_summary[transport_type='01']) > 0">
					&lt;Doc:IndvTrnsprt>
						<!-- Create the Transports By Air -->
						<xsl:for-each select="routing_summary[transport_mode='01' and transport_type='01']">
							<!-- Group the Transports By Air -->
							<xsl:variable name="currentTransportGroup"><xsl:value-of select="transport_group"/></xsl:variable>
							<xsl:if test="count(preceding-sibling::routing_summary[transport_mode='01' and transport_type='01' and transport_group = $currentTransportGroup]) = 0">
								&lt;Doc:TrnsprtByAir>
									<!-- Departure Airports (AirportName1Choice Type)-->
									<xsl:apply-templates select="../routing_summary[transport_mode='01' and transport_type='01' and transport_group = $currentTransportGroup and transport_sub_type='01']">
										<xsl:with-param name="rootName">DprtureAirprt</xsl:with-param>
									</xsl:apply-templates>						
									<!-- Destination Airports (AirportName1Choice Type)-->
									<xsl:apply-templates select="../routing_summary[transport_mode='01' and transport_type='01' and transport_group = $currentTransportGroup and transport_sub_type='02']">
										<xsl:with-param name="rootName">DstnAirprt</xsl:with-param>
									</xsl:apply-templates>&lt;/Doc:TrnsprtByAir>
							</xsl:if>
						</xsl:for-each>
						
						<!-- Create the Transports By Sea -->
						<xsl:for-each select="routing_summary[transport_mode='02' and transport_type='01']">
							<!-- Group the Transports By Sea -->
							<xsl:variable name="currentTransportGroup"><xsl:value-of select="transport_group"/></xsl:variable>
							<xsl:if test="count(preceding-sibling::routing_summary[transport_mode='02' and transport_type='01' and transport_group = $currentTransportGroup]) = 0">
								&lt;Doc:TrnsprtBySea>
									<!--  Port Of Loading -->
									<xsl:apply-templates select="../routing_summary[transport_mode='02' and transport_type='01' and transport_group = $currentTransportGroup and transport_sub_type='01']"/>				
									<!--  Port Of Discharge -->
									<xsl:apply-templates select="../routing_summary[transport_mode='02' and transport_type='01' and transport_group = $currentTransportGroup and transport_sub_type='02']"/>	
								&lt;/Doc:TrnsprtBySea>					
							</xsl:if>
						</xsl:for-each>
						
						<!-- Create the Transports By Road -->
						<xsl:for-each select="routing_summary[transport_mode='03' and transport_type='01']">
							<!-- Group the Transports By Road -->
							<xsl:variable name="currentTransportGroup"><xsl:value-of select="transport_group"/></xsl:variable>
							<xsl:if test="count(preceding-sibling::routing_summary[transport_mode='03' and transport_type='01' and transport_group = $currentTransportGroup]) = 0">
								&lt;Doc:TrnsprtByRoad>
								<!-- Place Of Receipt -->
								<xsl:apply-templates select="../routing_summary[transport_mode='03' and transport_type='01' and transport_group = $currentTransportGroup and transport_sub_type='01']"/>						
								<!-- Place Of Delivery -->
								<xsl:apply-templates select="../routing_summary[transport_mode='03' and transport_type='01' and transport_group = $currentTransportGroup and transport_sub_type='02']"/>						
								&lt;/Doc:TrnsprtByRoad>
							</xsl:if>
						</xsl:for-each>
						
						<!-- Create the Transports By Rail -->
						<xsl:for-each select="routing_summary[transport_mode='04' and transport_type='01']">
							<!-- Group the Transports By Rail -->
							<xsl:variable name="currentTransportGroup"><xsl:value-of select="transport_group"/></xsl:variable>
							<xsl:if test="count(preceding-sibling::routing_summary[transport_mode='04' and transport_type='01' and transport_group = $currentTransportGroup]) = 0">
								&lt;Doc:TrnsprtByRail>
								<!-- Place Of Receipt -->
								<xsl:apply-templates select="../routing_summary[transport_mode='04' and transport_type='01' and transport_group = $currentTransportGroup and transport_sub_type='01']"/>
								<!-- Place Of Delivery -->
								<xsl:apply-templates select="../routing_summary[transport_mode='04' and transport_type='01' and transport_group = $currentTransportGroup and transport_sub_type='02']"/>						
								&lt;/Doc:TrnsprtByRail>
							</xsl:if>
						</xsl:for-each>						
					&lt;/Doc:IndvTrnsprt>
				</xsl:when>
				<!-- Multimodal transport -->
				<xsl:when test="count(routing_summary[transport_type='02']) > 0">
					&lt;Doc:MltmdlTrnsprt>
						<!-- Departure Airports (AirportName1Choice Type)-->
						<xsl:apply-templates select="routing_summary[transport_mode='01' and transport_type='02'  and transport_sub_type='01']">
							<xsl:with-param name="rootName">DprtureAirprt</xsl:with-param>
						</xsl:apply-templates>						
						<!-- Destination Airports (AirportName1Choice Type)-->
						<xsl:apply-templates select="routing_summary[transport_mode='01' and transport_type='02' and transport_sub_type='02']">
							<xsl:with-param name="rootName">DstnAirprt</xsl:with-param>
						</xsl:apply-templates>
						<!--  Port Of Loading -->
						<xsl:apply-templates select="routing_summary[transport_mode='02' and transport_type='02' and transport_sub_type='01']"/>				
						<!--  Port Of Discharge -->
						<xsl:apply-templates select="routing_summary[transport_mode='02' and transport_type='02' and transport_sub_type='02']"/>	
						<!-- Place Of Receipt -->
						<xsl:apply-templates select="routing_summary[transport_mode='' and transport_type='02' and transport_sub_type='01' and taking_in_charge ='' and place_final_dest='']"/>						
						<!-- Place Of Delivery -->
						<xsl:apply-templates select="routing_summary[transport_mode='' and transport_type='02' and transport_sub_type='02' and taking_in_charge ='' and place_final_dest='']"/>					
						<!-- Taking In Charge -->
						<xsl:apply-templates select="routing_summary[transport_type='02' and taking_in_charge !='']"/>
						<!-- Place Of Final Destination -->
						<xsl:apply-templates select="routing_summary[transport_type='02' and place_final_dest !='']"/>									
					&lt;/Doc:MltmdlTrnsprt>			
				</xsl:when>
			</xsl:choose>
		&lt;/Doc:RtgSummry>
		</xsl:if>
	</xsl:template>
		
	<!-- Airport Template (AirportName1Choice Type) -->
	<xsl:template match="routing_summary[transport_mode='01']">
		<xsl:param name="rootName"/>
		
		<xsl:variable name="airportCode">
			<xsl:choose>
				<xsl:when test="transport_sub_type[. = '01']">	
					<xsl:value-of select="airport_loading_code"/>			
				</xsl:when>
				<xsl:when test="transport_sub_type[. = '02']">
					<xsl:value-of select="airport_discharge_code"/>
				</xsl:when>
			</xsl:choose>				
		</xsl:variable>
		
		<xsl:variable name="airportName">
			<xsl:choose>
				<xsl:when test="transport_sub_type[. = '01']">	
					<xsl:value-of select="airport_loading_name"/>			
				</xsl:when>
				<xsl:when test="transport_sub_type[. = '02']">
					<xsl:value-of select="airport_discharge_name"/>
				</xsl:when>
			</xsl:choose>			
		</xsl:variable>

		<xsl:variable name="town">
			<xsl:choose>
				<xsl:when test="transport_sub_type[. = '01']">	
					<xsl:value-of select="town_loading"/>			
				</xsl:when>
				<xsl:when test="transport_sub_type[. = '02']">
					<xsl:value-of select="town_discharge"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		
		&lt;Doc:<xsl:value-of select="$rootName"/>>	
			<xsl:choose>
				<xsl:when test="$airportCode != ''">
					&lt;Doc:AirprtCd><xsl:value-of select="$airportCode"/>&lt;/Doc:AirprtCd>
				</xsl:when>
				<xsl:when test="$town != ''">
					&lt;Doc:OthrAirprtDesc>
						&lt;Doc:Twn><xsl:value-of select="$town"/>&lt;/Doc:Twn>
						&lt;Doc:AirprtNm><xsl:value-of select="$airportName"/>&lt;/Doc:AirprtNm>						
					&lt;/Doc:OthrAirprtDesc>
				</xsl:when>				
			</xsl:choose>			
		&lt;/Doc:<xsl:value-of select="$rootName"/>>	
	</xsl:template>
	
	<!-- Port Template -->
	<xsl:template match="routing_summary[transport_mode='02']">
		<xsl:choose>
			<xsl:when test="transport_sub_type[. = '01']">
				&lt;Doc:PortOfLoadng><xsl:value-of select="port_loading"/>&lt;/Doc:PortOfLoadng>		
			</xsl:when>
			<xsl:when test="transport_sub_type[. = '02']">
				&lt;Doc:PortOfDschrge><xsl:value-of select="port_discharge"/>&lt;/Doc:PortOfDschrge>
			</xsl:when>
		</xsl:choose>	
	</xsl:template>
	
	<!-- Place Template -->
	<xsl:template match="routing_summary[transport_mode='03' or transport_mode='04' or transport_mode='']">
		<xsl:choose>
			<xsl:when test="transport_sub_type[. = '01']">
				&lt;Doc:PlcOfRct><xsl:value-of select="place_receipt"/>&lt;/Doc:PlcOfRct>		
			</xsl:when>
			<xsl:when test="transport_sub_type[. = '02']">
				&lt;Doc:PlcOfDlvry><xsl:value-of select="place_delivery"/>&lt;/Doc:PlcOfDlvry>
			</xsl:when>
		</xsl:choose>	
	</xsl:template>
	
	<!-- Taking In Charge Template -->
	<xsl:template match="routing_summary[transport_type='02' and taking_in_charge !='']">
		&lt;Doc:TakngInChrg><xsl:value-of select="taking_in_charge"/>&lt;/Doc:TakngInChrg>	
	</xsl:template>
	
	<!-- Place Of Final Destination -->
	<xsl:template match="routing_summary[transport_type='02' and place_final_dest !='']">
		&lt;Doc:PlcOfFnlDstn><xsl:value-of select="place_final_dest"/>&lt;/Doc:PlcOfFnlDstn>	
	</xsl:template>
	
	
		<!-- Add carriage return / break line-->
	<xsl:template name="format_line">
		<xsl:param name="input_text"/>
		<xsl:param name="length"/>
		<xsl:variable name="cr">
			<xsl:text>
</xsl:text>
		</xsl:variable>
		<xsl:choose>
			<!-- text's length < length -->
			<xsl:when test="string-length($input_text) &lt; $length"><xsl:value-of select="$input_text"/></xsl:when>
			<!-- text contains CR-->
			<xsl:when test="contains($input_text,$cr)">
				<xsl:call-template name="split_line">
					<xsl:with-param name="input_text" select="substring-before($input_text,$cr)"/>
					<xsl:with-param name="length"><xsl:value-of select="$length"/></xsl:with-param>
					<xsl:with-param name="pos">0</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="$cr"/>
				<xsl:call-template name="split_line">
					<xsl:with-param name="input_text" select="substring-after($input_text,$cr)"/>
					<xsl:with-param name="length"><xsl:value-of select="$length"/></xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<!-- text does not contain CR-->
			<xsl:otherwise>
				<xsl:call-template name="split_line">
					<xsl:with-param name="input_text" select="$input_text"/>
					<xsl:with-param name="length"><xsl:value-of select="$length"/></xsl:with-param>
					<xsl:with-param name="pos">0</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- Split line-->
	<xsl:template name="split_line">
		<xsl:param name="input_text"/>
		<xsl:param name="length"/>
		<xsl:param name="pos"/>
		<xsl:variable name="cr"><xsl:text>
</xsl:text>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="contains($input_text,' ')">
				<xsl:choose>
					<!-- less than max length -->
					<xsl:when test="$pos+string-length(substring-before($input_text,' ')) &lt; $length">
						<xsl:if test="$pos !=0"><xsl:value-of select="' '"/></xsl:if><xsl:value-of select="substring-before($input_text,' ')"/>
						<xsl:call-template name="split_line">
							<xsl:with-param name="input_text" select="substring-after($input_text,' ')"/>
							<xsl:with-param name="length"><xsl:value-of select="$length"/></xsl:with-param>
							<xsl:with-param name="pos"><xsl:value-of select="$pos+string-length(substring-before($input_text,' '))+1"/></xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<!-- more than max length -->
						<xsl:value-of select="$cr"/>
						<xsl:value-of select="substring-before($input_text,' ')"/><xsl:value-of select="' '"/>
						<xsl:call-template name="split_line">
							<xsl:with-param name="input_text" select="substring-after($input_text,' ')"/>
							<xsl:with-param name="length"><xsl:value-of select="$length"/></xsl:with-param>
							<xsl:with-param name="pos">1</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$input_text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- Amount Template -->
	<xsl:template name="TP_amount">
		<xsl:param name="amount"/>
   		<xsl:choose>
   			<xsl:when test="contains($amount,$decimal_separator)">
   				<xsl:call-template name="format_amount">
   					<xsl:with-param name="amount"><xsl:value-of select="substring-before($amount,$decimal_separator)"/></xsl:with-param>
   				</xsl:call-template><xsl:value-of select="$decimal_separator"/><xsl:value-of select="substring-after($amount,$decimal_separator)"/>
   			</xsl:when>
   			<xsl:otherwise>
   				<xsl:call-template name="format_amount">
   					<xsl:with-param name="amount"><xsl:value-of select="substring-before($amount,$decimal_separator)"/></xsl:with-param>
   				</xsl:call-template>
   			</xsl:otherwise>
   		</xsl:choose>
   </xsl:template>
		
	<xsl:template name="format_amount">
		<xsl:param name="amount"/>
		<xsl:choose>
   		<xsl:when test="string-length($amount) &gt; 3">
   			<xsl:call-template name="format_amount">
      			<xsl:with-param name="amount"><xsl:value-of select="substring($amount,1,string-length($amount)-3)"/></xsl:with-param>
      		</xsl:call-template><xsl:value-of select="$grouping_separator"/><xsl:value-of select="substring($amount,string-length($amount)-2,3)"/>
   		</xsl:when>
   		<xsl:otherwise><xsl:value-of select="$amount"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	

	<!--                               -->
	<!-- TSU to Open Account templates -->
	<!--                               -->
	
	<!-- Baseline -->
   <xsl:template match="ComrclDataSet | PushdThrghBaseln"> 
    	<xsl:param name="submission_type"/>
   	<tnx_cur_code><xsl:value-of select="Goods/LineItmsTtlAmt/@Ccy"/></tnx_cur_code>
   	<tnx_amt>
   		<xsl:call-template name="TP_amount">
   			<xsl:with-param name="amount"><xsl:value-of select="Goods/LineItmsTtlAmt"/></xsl:with-param>
   		</xsl:call-template>
   	</tnx_amt>
   	
   	<!--entity></entity-->
   	
   	<!--- Parties -->
   	<xsl:apply-templates select="Buyr"/>
   	<xsl:apply-templates select="Sellr"/>
   	<xsl:apply-templates select="BllTo"/>
   	<xsl:apply-templates select="ShipTo"/>
   	<xsl:apply-templates select="Consgn"/>
   	
   	<xsl:if test="Goods/GoodsDesc">
   		<goods_desc><xsl:value-of select="Goods/GoodsDesc"/></goods_desc>
   	</xsl:if>
   	
   	<xsl:if test="Goods/PrtlShipmnt">
   		<part_ship>
   			<xsl:choose>
					<xsl:when test="Goods/PrtlShipmnt='true'">Y</xsl:when>
					<xsl:when test="Goods/PrtlShipmnt='false'">N</xsl:when>
				</xsl:choose>
			</part_ship>
   	</xsl:if>
   	
   	<xsl:if test="Goods/TrnsShipmnt">
   		<tran_ship>
   			<xsl:choose>
					<xsl:when test="Goods/TrnsShipmnt='true'">Y</xsl:when>
					<xsl:when test="Goods/TrnsShipmnt='false'">N</xsl:when>
				</xsl:choose>
			</tran_ship>
   	</xsl:if>
   	
   	<xsl:if test="Goods/LatstShipmntDt">
   		<last_ship_date>
   			<xsl:call-template name="ISODate2TP">
   				<xsl:with-param name="date"><xsl:value-of select="Goods/LatstShipmntDt"/></xsl:with-param>
   			</xsl:call-template>
   		</last_ship_date>
   	</xsl:if>
   	
   	<nb_mismatch></nb_mismatch>
   	<full_match></full_match>
   	
   	<!-- Amounts -->
   	<total_amt>
   		<xsl:call-template name="TP_amount">
   			<xsl:with-param name="amount"><xsl:value-of select="Goods/LineItmsTtlAmt"/></xsl:with-param>
   		</xsl:call-template>
   	</total_amt>
   	<total_cur_code><xsl:value-of select="Goods/LineItmsTtlAmt/@Ccy"/></total_cur_code>
   	<total_net_amt>
			<xsl:call-template name="TP_amount">
   			<xsl:with-param name="amount"><xsl:value-of select="Goods/TtlNetAmt"/></xsl:with-param>
   		</xsl:call-template>
   	</total_net_amt>
   	<total_net_cur_code><xsl:value-of select="Goods/TtlNetAmt/@Ccy"/></total_net_cur_code>
   	<!--liab_total_amt></liab_total_amt>
   	<liab_total_cur_code></liab_total_cur_code>
   	<liab_total_net_amt></liab_total_net_amt>
   	<liab_total_net_cur_code></liab_total_net_cur_code-->
   	
   	<!-- Settlements -->
   	<xsl:apply-templates select="SttlmTerms"/>
   	
   	<xsl:if test="Goods/LatstShipmntDt[.!='']">
      	<last_match_date>
      		<xsl:call-template name="ISODate2TP">
      				<xsl:with-param name="date"><xsl:value-of select="Goods/LatstShipmntDt"/></xsl:with-param>
      		</xsl:call-template>
      	</last_match_date>
   	</xsl:if>
   	
   	<reqrd_commercial_dataset></reqrd_commercial_dataset>
   	<reqrd_transport_dataset></reqrd_transport_dataset>
   	
   	<xsl:if test="SubmitrBaselnId/Submitr/BIC">
   		<submitr_bic></submitr_bic>
   	</xsl:if>
   	
   	<!--data_set_id></data_set_id-->
   	
   	<xsl:if test="Goods/FrghtChrgs">
      	<freight_charges_type><xsl:value-of select="Goods/FrghtChrgs/Tp"/></freight_charges_type>
   	</xsl:if>
   	
   	<xsl:if test="PmtTerms">
      	<payment_terms_type>
      		<xsl:choose>
      			<xsl:when test="PmtTerms/Pctg">PRCT</xsl:when>
      			<xsl:when test="PmtTerms/Amt">AMNT</xsl:when>
      			<xsl:otherwise/>
      		</xsl:choose>
      	</payment_terms_type>
   	</xsl:if>

      <!--version></version-->
   	
   	<xsl:if test="$submission_type='FPTR'">
      	<buyer_bank_type_code>01
      		<!--xsl:choose>
      			<xsl:when test="$submission_type='FPTR'">01</xsl:when>
      			<xsl:when test="$submission_type='LODG'"-->
      				<!--xsl:choose>
							<xsl:when test="BuyrBk">01</xsl:when>
							<xsl:when test="BuyrBk/BIC = ../SellrBk/BIC">02</xsl:when>
						</xsl:choose-->
					<!--/xsl:when>
				</xsl:choose-->
      	</buyer_bank_type_code>
      	<seller_bank_type_code>02
      		<!--xsl:choose>
      			<xsl:when test="$submission_type='FPTR'">02</xsl:when>
      			<xsl:when test="$submission_type='LODG'"-->
      				<!--xsl:choose>
							<xsl:when test="BuyrBk">01</xsl:when>
							<xsl:when test="BuyrBk/BIC = ../SellrBk/BIC">02</xsl:when>
						</xsl:choose-->
					<!--/xsl:when>
				</xsl:choose-->
			</seller_bank_type_code>
		</xsl:if>
		
   	<!--issuer_type_code></issuer_type_code-->
   	
   	<!--final_presentation></final_presentation-->
   	
   	<xsl:if test="$submission_type = 'LODG' or $submission_type = 'FPTR'">
   		<submission_type><xsl:value-of select="$submission_type"/></submission_type>
   	</xsl:if>
   	
   	<tid><xsl:value-of select="//TxId/Id"/></tid>
   	
     	<!-- Line Items -->
    	<line_items>
   		<xsl:apply-templates select="Goods/ComrclLineItms | Goods/LineItmDtls"/>
   	</line_items>
   						
   	<!-- Contacts -->
   	<xsl:if test="//BuyrCtctPrsn[.!=''] | //SellrCtctPrsn[.!=''] | //SellrBkCtctPrsn[.!=''] | //BllToCtctPrsn[.!=''] | //ShipToCtctPrsn[.!=''] | //ConsgnCtctPrsn[.!='']">
      	<contacts>
         	<xsl:apply-templates select="//BuyrCtctPrsn">
         		<xsl:with-param name="type">02</xsl:with-param>
         	</xsl:apply-templates>
         	<xsl:apply-templates select="//SellrCtctPrsn">
         		<xsl:with-param name="type">01</xsl:with-param>
         	</xsl:apply-templates>
         	<xsl:apply-templates select="//BuyrBkCtctPrsn">
         		<xsl:with-param name="type">04</xsl:with-param>
         	</xsl:apply-templates>
         	<xsl:apply-templates select="//SellrBkCtctPrsn">
         		<xsl:with-param name="type">03</xsl:with-param>
         	</xsl:apply-templates>
         	<xsl:apply-templates select="//BllToCtctPrsn">
         		<xsl:with-param name="type">05</xsl:with-param>
         	</xsl:apply-templates>
         	<xsl:apply-templates select="//ShipToCtctPrsn">
         		<xsl:with-param name="type">06</xsl:with-param>
         	</xsl:apply-templates>
         	<xsl:apply-templates select="//ConsgnCtctPrsn">
         		<xsl:with-param name="type">07</xsl:with-param>
         	</xsl:apply-templates>
      	</contacts>
      </xsl:if>
     	
   	<!-- Payments -->
   	<xsl:if test="PmtTerms">
      	<payments>
      		<xsl:apply-templates select="PmtTerms"/>
      	</payments>
   	</xsl:if>

			<!-- Inco Terms -->
		<incoterms>
   		<xsl:apply-templates select="Goods/Incotrms"/>
   	</incoterms>      	
   	
   	<!-- Adjustments -->
   	<adjustments>
   		<xsl:apply-templates select="Goods/Adjstmnt"/>
   	</adjustments>
   	   			
    	<!-- Taxes -->
   	<taxes>
   		<xsl:apply-templates select="Goods/Tax"/>
   	</taxes>

      	<!-- Freight Charges -->
   	<freight_charges>
   		<xsl:apply-templates select="FrghtChrgs/Chrgs"/>
   	</freight_charges>
   	
   	<!-- User information -->
   	<xsl:if test="Goods/BuyrDfndInf or Goods/SellrDfndInf">
   		<user_defined_informations>
      		<xsl:apply-templates select="Goods/BuyrDfndInf"/>
      		<xsl:apply-templates select="Goods/SellrDfndInf"/>
			</user_defined_informations>
		</xsl:if>
   	      	
  		<!-- Routing Summaries -->
   	<!--xsl:apply-templates select=""/-->
   	
	</xsl:template>
	
	<!-- Futur -->
	<xsl:template match="TrnsprtDataSet"> 
	
	</xsl:template>
	
	<!-- Party Template -->
	
	<!-- Buyer -->
	<xsl:template match="Buyr">
			<xsl:call-template name="TP_party">
				<xsl:with-param name="party_name">buyer</xsl:with-param>
				<xsl:with-param name="bic"><xsl:value-of select="//BuyrBk/BIC"/></xsl:with-param>
			</xsl:call-template>
	</xsl:template>
	
	<!-- Seller -->
	<xsl:template match="Sellr">
			<xsl:call-template name="TP_party">
				<xsl:with-param name="party_name">seller</xsl:with-param>
				<xsl:with-param name="bic"><xsl:value-of select="//SellrBk/BIC"/></xsl:with-param>
			</xsl:call-template>
	</xsl:template>
	
	<!-- Bill To -->
	<xsl:template match="BllTo">
			<xsl:call-template name="TP_party">
				<xsl:with-param name="party_name">bill_to</xsl:with-param>
				<xsl:with-param name="bic"/>
			</xsl:call-template>
	</xsl:template>
	
	<!-- Consignee -->
	<xsl:template match="Consgn">
			<xsl:call-template name="TP_party">
				<xsl:with-param name="party_name">consgn</xsl:with-param>
				<xsl:with-param name="bic"/>
			</xsl:call-template>
	</xsl:template>
	
	<!-- Ship To -->
	<xsl:template match="ShipTo">
			<xsl:call-template name="TP_party">
				<xsl:with-param name="party_name">ship_to</xsl:with-param>
				<xsl:with-param name="bic"/>
			</xsl:call-template>
	</xsl:template>
	
	<!-- Common TP Party Template -->
	<xsl:template name="TP_party">
		<xsl:param name="party_name"/>
		<xsl:param name="bic"/>
		<!--xsl:element name="{$party_name}_abbv_name></buyer_reference-->
		<xsl:element name="{$party_name}_name"><xsl:value-of select="Nm"/></xsl:element>
		<xsl:element name="{$party_name}_bei"><xsl:value-of select="Bei"/></xsl:element>
		<xsl:if test="$bic != ''">
			<xsl:element name="{$party_name}_bank_bic"><xsl:value-of select="$bic"/></xsl:element>
		</xsl:if>
		<xsl:apply-templates select="PstlAdr">
			<xsl:with-param name="party_name"><xsl:value-of select="$party_name"/></xsl:with-param>
		</xsl:apply-templates>
		<!--xsl:element name="{$party_name}_reference></buyer_reference-->
	</xsl:template>
	
	<!-- Common party template : address -->
	<xsl:template match="PstlAdr | Adr">
		<xsl:param name="party_name"/>
		<xsl:element name="{$party_name}_street_name"><xsl:value-of select="StrtNm"/></xsl:element>
		<xsl:element name="{$party_name}_post_code"><xsl:value-of select="PstCdId"/></xsl:element>
		<xsl:element name="{$party_name}_town_name"><xsl:value-of select="TwnNm"/></xsl:element>
		<xsl:element name="{$party_name}_country_sub_div"><xsl:value-of select="CtrySubDvsn"/></xsl:element>
		<xsl:element name="{$party_name}_country"><xsl:value-of select="Ctry"/></xsl:element>
	</xsl:template>
	
	<!-- Settlement -->
	<xsl:template match="SttlmTerms">
		<xsl:apply-templates select="FnlAgt"/>
		<xsl:apply-templates select="BnfcryAcct"/>
   </xsl:template>
    
   <!-- Financial Institution -->
   <xsl:template match="FnlAgt">
    	<fin_inst_bic><xsl:value-of select="BIC"/></fin_inst_bic>
    	<fin_inst_name><xsl:value-of select="NmAndAdr/Nm"/></fin_inst_name>
    	<xsl:apply-templates select="NmAndAdr/Adr">
			<xsl:with-param name="party_name">fin_inst</xsl:with-param>
		</xsl:apply-templates>
   </xsl:template>
    
   <!-- Beneficiary Account -->
   <xsl:template match="BnfcryAcct">
   	<xsl:choose>
   		<xsl:when test="Nm">
   			<seller_account_name><xsl:value-of select="Nm"/></seller_account_name>
   		</xsl:when>
   		<xsl:when test="Id">
         	<seller_account_iban><xsl:value-of select="IBAN"/></seller_account_iban>
         	<seller_account_bban><xsl:value-of select="BBAN"/></seller_account_bban>
         	<seller_account_upic><xsl:value-of select="UPIC"/></seller_account_upic>
         	<seller_account_id><xsl:value-of select="DmstAcct/Id"/></seller_account_id>
      	</xsl:when>
      	<xsl:when test="NmAndId">
      		<seller_account_name><xsl:value-of select="Nm"/></seller_account_name>
      		<seller_account_iban><xsl:value-of select="IBAN"/></seller_account_iban>
         	<seller_account_bban><xsl:value-of select="BBAN"/></seller_account_bban>
         	<seller_account_upic><xsl:value-of select="UPIC"/></seller_account_upic>
         	<seller_account_id><xsl:value-of select="DmstAcct/Id"/></seller_account_id>
      	</xsl:when>
   	</xsl:choose>
   </xsl:template>
   
   
   <!-- Inco Terms -->
    <xsl:template match="Incotrms">
    	<incoterm>
			<!--inco_term_id></inco_term_id-->
			<xsl:choose>
				<xsl:when test="Cd[.!='']"><code><xsl:value-of select="Cd"/></code></xsl:when>
				<xsl:otherwise><other><xsl:value-of select="Othr"/></other></xsl:otherwise>
			</xsl:choose>
			<location><xsl:value-of select="Lctn"/></location>
		</incoterm>
    </xsl:template>
    
    <!-- Adjustments -->
    <xsl:template match="Adjstmnt">
    	<allowance>
			<!--allowance_id></allowance_id-->
			<allowance_type>02</allowance_type>
			<xsl:choose>
				<xsl:when test="Tp[.!='']"><type><xsl:value-of select="Tp"/></type></xsl:when>
				<xsl:otherwise><other_type><xsl:value-of select="OthrAdjstmntTp"/></other_type></xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="Amt[.!='']">
					<amt>
   					<xsl:call-template name="TP_amount">
      					<xsl:with-param name="amount"><xsl:value-of select="Amt"/></xsl:with-param>
      				</xsl:call-template>
      			</amt>
      			<cur_code><xsl:value-of select="Amt/@Ccy"/></cur_code>
      		</xsl:when>
      		<xsl:otherwise><rate><xsl:value-of select="Rate"/></rate></xsl:otherwise>
      	</xsl:choose>
      	<xsl:if test="direction[. != '']">
				<direction><xsl:value-of select="Drctn"/></direction>
			</xsl:if>
		</allowance>
    </xsl:template>
    
    <!-- Freight Charges -->
    <xsl:template match="Chrgs">
    	<allowance>
			<!--allowance_id></allowance_id-->
			<allowance_type>03</allowance_type>
			<xsl:choose>
				<xsl:when test="Tp[.!='']"><type><xsl:value-of select="Tp"/></type></xsl:when>
				<xsl:otherwise><other_type><xsl:value-of select="OthrChrgsTp"/></other_type></xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="Amt[.!='']">
					<amt>
   					<xsl:call-template name="TP_amount">
      					<xsl:with-param name="amount"><xsl:value-of select="Amt"/></xsl:with-param>
      				</xsl:call-template>
      			</amt>
      			<cur_code><xsl:value-of select="Amt/@Ccy"/></cur_code>
      		</xsl:when>
      		<xsl:otherwise><rate><xsl:value-of select="Rate"/></rate></xsl:otherwise>
      	</xsl:choose>
			<xsl:if test="direction[. != '']">
				<direction><xsl:value-of select="Drctn"/></direction>
			</xsl:if>
		</allowance>
    </xsl:template>
    
	<!-- Taxes -->
   <xsl:template match="Tax">
    	<allowance>
   		<!--allowance_id></allowance_id-->
   		<allowance_type>01</allowance_type>
   		<xsl:choose>
				<xsl:when test="Tp[.!='']"><type><xsl:value-of select="Tp"/></type></xsl:when>
				<xsl:otherwise><other_type><xsl:value-of select="OthrTaxTp"/></other_type></xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="Amt[.!='']">
					<amt>
   					<xsl:call-template name="TP_amount">
      					<xsl:with-param name="amount"><xsl:value-of select="Amt"/></xsl:with-param>
      				</xsl:call-template>
      			</amt>
      			<cur_code><xsl:value-of select="Amt/@Ccy"/></cur_code>
      		</xsl:when>
      		<xsl:otherwise><rate><xsl:value-of select="Rate"/></rate></xsl:otherwise>
      	</xsl:choose>
   		<xsl:if test="direction[. != '']">
				<direction><xsl:value-of select="Drctn"/></direction>
			</xsl:if>
   	</allowance>
    </xsl:template>

   <!-- Payment Terms -->
 	<xsl:template match="PmtTerms">
    	<payment>
   		<!--payment_id></payment_id-->
   		<xsl:choose>
   			<xsl:when test="PmtCd/Cd">
   				<code><xsl:value-of select="PmtCd/Cd"/></code>
   			</xsl:when>
   			<xsl:when test="OthrPmtTerms">
   				<other_paymt_terms><xsl:value-of select="OthrPmtTerms"/></other_paymt_terms>
   			</xsl:when>
   		</xsl:choose>
   		<nb_days><xsl:value-of select="PmtCd/NbOfDays"/></nb_days>
   		<amt>
   			<xsl:call-template name="TP_amount">
      			<xsl:with-param name="amount"><xsl:value-of select="Amt"/></xsl:with-param>
      		</xsl:call-template>
      	</amt>
   		<cur_code><xsl:value-of select="Amt/@Ccy"/></cur_code>
   		<pct><xsl:value-of select="Pctg"/></pct>
   	</payment>
    </xsl:template>
    
   <!-- User Informations -->
 	<xsl:template match="BuyrDfndInf">
    	<user_defined_information>
   		<!--user_info_id></user_info_id-->
   		<type>01</type>
   		<label><xsl:value-of select="Labl"/></label>
   		<information><xsl:value-of select="Inf"/></information>
   	</user_defined_information>
    </xsl:template>
    
 	<xsl:template match="SellrDfndInf">
    	<user_defined_information>
   		<!--user_info_id></user_info_id-->
   		<type>02</type>
   		<label><xsl:value-of select="Labl"/></label>
   		<information><xsl:value-of select="Inf"/></information>
   	</user_defined_information>
    </xsl:template>
    
    <!-- Line Items -->
    <xsl:template match="ComrclLineItms | LineItmDtls">
    	<lt_tnx_record>
			<cust_ref_id><xsl:value-of select="LineItmId"/></cust_ref_id>
			<product_code>LT</product_code>
			<tnx_cur_code><xsl:value-of select="TtlAmt/@Ccy"/></tnx_cur_code>
			<tnx_amt>
				<xsl:call-template name="TP_amount">
      			<xsl:with-param name="amount"><xsl:value-of select="TtlAmt"/></xsl:with-param>
      		</xsl:call-template>
			</tnx_amt>
			<line_item_number><xsl:value-of select="LineItmId"/></line_item_number>
			<xsl:if test="Qty/UnitOfMeasrCd">
				<qty_unit_measr_code><xsl:value-of select="Qty/UnitOfMeasrCd"/></qty_unit_measr_code>
			</xsl:if>
			<qty_other_unit_measr><xsl:value-of select="Qty/OthrUnitOfMeasr"/></qty_other_unit_measr>
			<qty_val><xsl:value-of select="Qty/Val"/></qty_val>
			<xsl:if test="Qty/Fctr">
				<qty_factor><xsl:value-of select="Qty/Fctr"/></qty_factor>
			</xsl:if>
			<!--qty_tol_pstv_pct/>
			<qty_tol_neg_pct/-->
			<xsl:if test="Qty/Fctr">
				<price_unit_measr_code><xsl:value-of select="UnitPric/UnitOfMeasrCd"/></price_unit_measr_code>
			</xsl:if>
			<price_other_unit_measr><xsl:value-of select="UnitPric/OthrUnitOfMeasr"/></price_other_unit_measr>
			<price_amt>
				<xsl:call-template name="TP_amount">
      			<xsl:with-param name="amount"><xsl:value-of select="UnitPric/Amt"/></xsl:with-param>
      		</xsl:call-template>
			</price_amt>
			<price_cur_code><xsl:value-of select="UnitPric/Amt/@Ccy"/></price_cur_code>
			<xsl:if test="UnitPric/Fctr">
				<price_factor><xsl:value-of select="UnitPric/Fctr"/></price_factor>
			</xsl:if>
			<xsl:if test="PricTlrnce/PlusPct">
				<price_tol_pstv_pct><xsl:value-of select="PricTlrnce/PlusPct"/></price_tol_pstv_pct>
			</xsl:if>
			<xsl:if test="PricTlrnce/MnsPct">
				<price_tol_neg_pct><xsl:value-of select="PricTlrnce/MnsPct"/></price_tol_neg_pct>
			</xsl:if>
			<xsl:if test="PdctNm">
				<product_name><xsl:value-of select="PdctNm"/></product_name>
			</xsl:if>
			<xsl:if test="PdctOrgn">
				<product_orgn><xsl:value-of select="PdctOrgn"/></product_orgn>
			</xsl:if>
			<xsl:if test="LatstShipmntDt">
   			<last_ship_date>
   				<xsl:call-template name="ISODate2TP">
      				<xsl:with-param name="date"><xsl:value-of select="LatstShipmntDt"/></xsl:with-param>
      			</xsl:call-template>
      		</last_ship_date>
      	</xsl:if>
			<total_amt>
				<xsl:call-template name="TP_amount">
      			<xsl:with-param name="amount"><xsl:value-of select="TtlAmt"/></xsl:with-param>
      		</xsl:call-template>
      	</total_amt>
			<total_cur_code><xsl:value-of select="TtlAmt/@Ccy"/></total_cur_code>
			<!--total_net_amt>
				<xsl:call-template name="TP_amount">
      			<xsl:with-param name="amount"><xsl:value-of select="TtlAmt"/></xsl:with-param>
      		</xsl:call-template>
      	</total_net_amt>
			<total_net_cur_code><xsl:value-of select="TtlAmt/@Ccy"/></total_net_cur_code-->
			
			<!--order_total_amt/>
			<order_total_cur_code/>
			<order_total_net_amt/>
			<order_total_net_cur_code/-->
			
			<!--accepted_total_amt/>
			<accepted_total_cur_code/>
			<accepted_total_net_amt/>
			<accepted_total_net_cur_code/-->
			
			<!--liab_total_amt/>
			<liab_total_cur_code/>
			<liab_total_net_amt/>
			<liab_total_net_cur_code/-->
			
			<!-- Inco Terms -->
			<incoterms>
      		<xsl:apply-templates select="Incotrms"/>
      	</incoterms>
      	
      	<!-- Adjustments -->
      	<adjustments>
      		<xsl:apply-templates select="Adjstmnt"/>
      	</adjustments>
      	
      	<!-- Taxes -->
      	<taxes>
      		<xsl:apply-templates select="Tax"/>
      	</taxes>

      	<!-- Freight Charges -->
      	<freight_charges>
      		<xsl:apply-templates select="FrghtChrgs/Chrgs"/>
      	</freight_charges>
      	
      	<!-- Goods definition -->
      	<xsl:if test="PdctIdr">
         	<product_identifiers>
         		<xsl:apply-templates select="PdctIdr"/>
         	</product_identifiers>
      	</xsl:if>
      	
      	<xsl:if test="PdctCtgy">
         	<product_categories>
         		<xsl:apply-templates select="PdctCtgy"/>
         	</product_categories>
      	</xsl:if>
      	
      	<xsl:if test="PdctChrtcs">
         	<product_characteristics>
         		<xsl:apply-templates select="PdctChrtcs"/>
         	</product_characteristics>
      	</xsl:if>
			
			<!-- Routing Summaries -->
      	<!--xsl:apply-templates select=""/-->
      	
		</lt_tnx_record>
    </xsl:template>
    
    <!-- Goods definition -->
    <!-- Product Identifier-->
    <xsl:template match="PdctIdr">
    	<product_identifier>
   		<!--goods_id></goods_id-->
   		<goods_type>01</goods_type>
   		<goods_sub_type><xsl:value-of select="Inf"/></goods_sub_type>
   		<type><xsl:value-of select="StrdPdctIdr/Tp"/></type>
   		<other_type><xsl:value-of select="OthrPdctIdr/IdTp"/></other_type>
   		<identifier>
      		<xsl:choose>
      			<xsl:when test="StrdPdctIdr/Tp"><xsl:value-of select="StrdPdctIdr/Idr"/></xsl:when>
      			<xsl:when test="OthrPdctIdr/Id"><xsl:value-of select="OthrPdctIdr/IdTp"/></xsl:when>
      		</xsl:choose>
   		</identifier>
   		<characteristic/>
   		<category/>
   	</product_identifier>
    </xsl:template>
    
    <!-- Product Characteristic-->
    <xsl:template match="PdctChrtcs">
    	<product_characteristic>
   		<!--goods_id></goods_id-->
   		<goods_type>03</goods_type>
   		<goods_sub_type><xsl:value-of select="Inf"/></goods_sub_type>
   		<type><xsl:value-of select="StrdPdctChrtcs/Tp"/></type>
   		<other_type><xsl:value-of select="OthrPdctChrtcs/IdTp"/></other_type>
   		<identifier/>
   		<characteristic>
      		<xsl:choose>
      			<xsl:when test="StrdPdctChrtcs/Tp"><xsl:value-of select="StrdPdctChrtcs/Idr"/></xsl:when>
      			<xsl:when test="OthrPdctChrtcs/Id"><xsl:value-of select="OthrPdctChrtcs/IdTp"/></xsl:when>
      		</xsl:choose>
      	</characteristic>
   		<category/>
   	</product_characteristic>
    </xsl:template>
    
    <!-- Product Category-->
    <xsl:template match="PdctCtgy">
    	<product_category>
   		<!--goods_id></goods_id-->
   		<goods_type>02</goods_type>
   		<goods_sub_type><xsl:value-of select="Inf"/></goods_sub_type>
   		<type><xsl:value-of select="StrdPdctCtgy/Tp"/></type>
   		<other_type><xsl:value-of select="StrdPdctCtgy/IdTp"/></other_type>
   		<identifier/>
   		<characteristic/>
   		<category>
      		<xsl:choose>
      			<xsl:when test="StrdPdctCtgy/Tp"><xsl:value-of select="StrdPdctCtgy/Idr"/></xsl:when>
      			<xsl:when test="OthrPdctCtgy/Id"><xsl:value-of select="OthrPdctCtgy/IdTp"/></xsl:when>
      		</xsl:choose>
      	</category>
   	</product_category>
    </xsl:template>
    
    <!-- Contacts -->
    <xsl:template match="BuyrCtctPrsn | SellrCtctPrsn | BuyrBkCtctPrsn | SellrBkCtctPrsn | BllToCtctPrsn | ShipToCtctPrsn | ConsgnCtctPrsn">
    	<xsl:param name="type"/>
    	<contact>
       	<!--ctcprsn_id-->
			<type><xsl:value-of select="$type"/></type>		
			<name><xsl:value-of select="Nm"/></name>
			<name_prefix><xsl:value-of select="NmPrfx"/></name_prefix>
			<given_name><xsl:value-of select="GvnNm"/></given_name>
			<role><xsl:value-of select="Role"/></role>
			<phone_number><xsl:value-of select="PhoneNb"/></phone_number>
			<fax_number><xsl:value-of select="FaxNb"/></fax_number>
			<email><xsl:value-of select="EmailAdr"/></email>
    	</contact>
    </xsl:template>
    
	<!-- ISODate to TP -->
	<xsl:template name="ISODate2TP">
		<xsl:param name="date"/>
		<xsl:value-of select="substring($date, 9, 2)"/>/<xsl:value-of select="substring($date,6, 2)"/>/<xsl:value-of select="substring($date,1,4)"/>
	</xsl:template>

	<!-- Multiply operand1 by operand2 -->
	<xsl:template name="multiply">
		<xsl:param name="operand1"/>
		<xsl:param name="operand2"/>
		
		
	</xsl:template>

</xsl:stylesheet>