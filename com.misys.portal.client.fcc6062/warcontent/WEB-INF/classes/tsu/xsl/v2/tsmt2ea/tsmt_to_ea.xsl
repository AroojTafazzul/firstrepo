<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	xmlns:tnxidgenerator="xalan://com.misys.portal.product.util.generator.TransactionIdGenerator"
	xmlns:refidgenerator="xalan://com.misys.portal.product.util.generator.ReferenceIdGenerator"
	exclude-result-prefixes="tools tnxidgenerator refidgenerator">
	
	<xsl:output method ="xml"/>
	
	<xsl:param name="tnxId"/>
	<xsl:param name="serviceCode"/>
	<xsl:param name="language">en</xsl:param>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:variable name="bankDetailsFromSellerBic" select="tools:retrieveBankDetailsFromBICCode(//PushdThrghBaseln/SellrBk/BIC,//Sellr/Nm)" />
		<xsl:variable name="eaRefId"><xsl:value-of select="refidgenerator:generate('EA')"/></xsl:variable>
		<xsl:variable name="eaTnxId"><xsl:value-of select="tnxidgenerator:generate()"/></xsl:variable>
		<ea_tnx_record>
			<ref_id>
				<xsl:value-of select ="$eaRefId"/>
			</ref_id>
			<tnx_id>
				<xsl:value-of select ="$eaTnxId"/>
			</tnx_id>
			<brch_code>00001</brch_code>
			<tnx_type_code>30</tnx_type_code>
			<prod_stat_code>98</prod_stat_code>
			<tnx_stat_code>06</tnx_stat_code>
			<sub_tnx_type_code>69</sub_tnx_type_code>
			<product_code>EA</product_code>
			<inp_user_id>0</inp_user_id>
			<tnx_amt>
				<xsl:value-of select="//Goods/TtlNetAmt"/>
			</tnx_amt>
			<tnx_cur_code>
				<xsl:value-of select="//Goods/TtlNetAmt/@Ccy"/>
			</tnx_cur_code>
			<seller_abbv_name>
					<xsl:value-of select="//Sellr/Nm"/>
			</seller_abbv_name>
			<seller_name>
					<xsl:value-of select="//Sellr/Nm"/>
			</seller_name>
			<buyer_abbv_name>
				<xsl:value-of select="//Buyr/Nm"/>
			</buyer_abbv_name>
			<seller_proprietary_id>
				<xsl:value-of select="//Sellr/Prtry/Id"/>
			</seller_proprietary_id>
			<seller_proprietary_id_type>
				<xsl:value-of select="//Sellr/Prtry/IdTp"/>
			</seller_proprietary_id_type>
			<buyer_name>
				<xsl:value-of select="//Buyr/Nm"/>
			</buyer_name>
			<bpo_used_status>
				<xsl:choose>
					<xsl:when test="//PushdThrghBaseln/PmtOblgtn != ''">Y</xsl:when>
					<xsl:otherwise>N</xsl:otherwise>
				</xsl:choose>
			</bpo_used_status>
			<buyer_proprietary_id>
				<xsl:value-of select="//Buyr/Prtry/Id"/>
			</buyer_proprietary_id>
			<buyer_proprietary_id_type>
				<xsl:value-of select="//Buyr/Prtry/IdTp"/>
			</buyer_proprietary_id_type>
			<buyer_bank_bic>
				<xsl:value-of select="//BuyrBk/BIC"/>
			</buyer_bank_bic>
			<seller_bank_bic>
				<xsl:value-of select="//SellrBk/BIC"/>	
			</seller_bank_bic>
			<buyer_submitting_bank_bic>
				<xsl:value-of select="//BuyrSdSubmitgBk/BIC"/>
			</buyer_submitting_bank_bic>
			<seller_submitting_bank_bic>
				<xsl:value-of select="//SellrSdSubmitgBk/BIC"/>	
			</seller_submitting_bank_bic>
			<buyer_street_name>
				<xsl:value-of select="//Buyr/PstlAdr/StrtNm"/>
			</buyer_street_name>
			<buyer_post_code>
				<xsl:value-of select="//Buyr/PstlAdr/PstCdId"/>
			</buyer_post_code>
			<buyer_town_name>
				<xsl:value-of select="//Buyr/PstlAdr/TwnNm"/>
			</buyer_town_name>
			<buyer_country_sub_div>
				<xsl:value-of select="//Buyr/PstlAdr/CtrySubDvsn"/>
			</buyer_country_sub_div>
			<buyer_country_sub_div>
				<xsl:value-of select="//Buyr/PstlAdr/CtrySubDvsn"/>
			</buyer_country_sub_div>
			<buyer_country>
				<xsl:value-of select="//Buyr/PstlAdr/Ctry"/>
			</buyer_country>
			<seller_street_name>
				<xsl:value-of select="//Sellr/PstlAdr/StrtNm"/>
			</seller_street_name>
			<seller_post_code>
				<xsl:value-of select="//Sellr/PstlAdr/PstCdId"/>
			</seller_post_code>
			<seller_town_name>
				<xsl:value-of select="//Sellr/PstlAdr/TwnNm"/>
			</seller_town_name>
			<seller_country_sub_div>
				<xsl:value-of select="//Sellr/PstlAdr/CtrySubDvsn"/>
			</seller_country_sub_div>
			<seller_country>
				<xsl:value-of select="//Sellr/PstlAdr/Ctry"/>
			</seller_country>
			<seller_country_sub_div>
				<xsl:value-of select="//Sellr/PstlAdr/CtrySubDvsn"/>
			</seller_country_sub_div>
			<bill_to_abbv_name>
				<xsl:value-of select="//BllTo/Nm"/>
			</bill_to_abbv_name>
			<bill_to_name>
				<xsl:value-of select="//BllTo/Nm"/>
			</bill_to_name>
			<bill_to_prtry_id>
				<xsl:value-of select="//BllTo/Prtry/Id"/>
			</bill_to_prtry_id>
			<bill_to_prtry_idTp>
				<xsl:value-of select="//BllTo/Prtry/IdTp"/>
			</bill_to_prtry_idTp>		
			<bill_to_street_name>
				<xsl:value-of select="//BllTo/PstlAdr/StrtNm"/>
			</bill_to_street_name>
			<bill_to_town_name>
				<xsl:value-of select="//BllTo/PstlAdr/TwnNm"/>
			</bill_to_town_name>
			<bill_to_country_sub_div>
				<xsl:value-of select="//BllTo/PstlAdr/CtrySubDvsn"/>
			</bill_to_country_sub_div>
			<bill_to_post_code>
				<xsl:value-of select="//BllTo/PstlAdr/PstCdId"/>
			</bill_to_post_code>
			<bill_to_country>
				<xsl:value-of select="//BllTo/PstlAdr/Ctry"/>
			</bill_to_country>
			<ship_to_abbv_name>
				<xsl:value-of select="//ShipTo/Nm"/>
			</ship_to_abbv_name>
			<ship_to_prtry_id>
				<xsl:value-of select="//ShipTo/Prtry/Id"/>
			</ship_to_prtry_id>
			<ship_to_prtry_idTp>
				<xsl:value-of select="//ShipTo/Prtry/IdTp"/>
			</ship_to_prtry_idTp>	
			<ship_to_name>
				<xsl:value-of select="//ShipTo/Nm"/>
			</ship_to_name>
			<ship_to_street_name>
				<xsl:value-of select="//ShipTo/PstlAdr/StrtNm"/>
			</ship_to_street_name>
			<ship_to_town_name>
				<xsl:value-of select="//ShipTo/PstlAdr/TwnNm"/>
			</ship_to_town_name>
			<ship_to_country_sub_div>
				<xsl:value-of select="//ShipTo/PstlAdr/CtrySubDvsn"/>
			</ship_to_country_sub_div>
			<ship_to_post_code>
				<xsl:value-of select="//ShipTo/PstlAdr/PstCdId"/>
			</ship_to_post_code>
			<ship_to_country>
				<xsl:value-of select="//ShipTo/PstlAdr/Ctry"/>
			</ship_to_country>
			<consgn_abbv_name>
				<xsl:value-of select="//Consgn/Nm"/>
			</consgn_abbv_name>
			<consgn_name>
				<xsl:value-of select="//Consgn/Nm"/>
			</consgn_name>
			<consgn_to_prtry_id>
				<xsl:value-of select="//Consgn/Prtry/Id"/>
			</consgn_to_prtry_id>
			<consgn_to_prtry_idTp>
				<xsl:value-of select="//Consgn/Prtry/IdTp"/>
			</consgn_to_prtry_idTp>	
			<consgn_street_name>
				<xsl:value-of select="//Consgn/PstlAdr/StrtNm"/>
			</consgn_street_name>
			<consgn_town_name>
				<xsl:value-of select="//Consgn/PstlAdr/TwnNm"/>
			</consgn_town_name>
			<consgn_country_sub_div>
				<xsl:value-of select="//Consgn/PstlAdr/CtrySubDvsn"/>
			</consgn_country_sub_div>
			<consgn_post_code>
				<xsl:value-of select="//Consgn/PstlAdr/PstCdId"/>
			</consgn_post_code>
			<consgn_country>
				<xsl:value-of select="//Consgn/PstlAdr/Ctry"/>
			</consgn_country>
			<xsl:if test="//Goods/GoodsDesc">
			<goods_desc>
				<xsl:value-of select="//Goods/GoodsDesc"/>
			</goods_desc>
			</xsl:if>
			<xsl:if test="//Goods/ShipmntDtRg//LatstShipmntDt">
				<last_ship_date>
					<xsl:value-of select="//ShipmntDtRg/LatstShipmntDt"/>
				</last_ship_date>
			</xsl:if>
			<xsl:if test="//Goods/ShipmntDtRg/EarlstShipmntDt">
				<earliest_ship_date>
					<xsl:value-of select="//ShipmntDtRg/EarlstShipmntDt"/>
				</earliest_ship_date>
			</xsl:if>
			<xsl:if test="//CreDtTm">
				<iss_date>
					<xsl:value-of select="tools:convertISODateTime2MTPDateTime(//CreDtTm,$language)"/>
				</iss_date>
			</xsl:if>
			<xsl:if test="//PushdThrghBaseln/PurchsOrdrRef/DtOfIsse">
				<po_issue_date>
					<xsl:value-of select="//PushdThrghBaseln/PurchsOrdrRef/DtOfIsse"/>
				</po_issue_date>
			</xsl:if>	
			<xsl:if test="//LatstMtchDt"> 
				<last_match_date>
					<xsl:value-of select="//LatstMtchDt"/>
				</last_match_date>
			</xsl:if>
			<xsl:if test="//PmtDueDt"> 
				<due_date>
					<xsl:value-of select="//PmtDueDt"/>
				</due_date>
			</xsl:if>		
			<xsl:if test="//PmtOblgtn/XpryDt"> 
				<exp_date>
					<xsl:value-of select="//PmtOblgtn/XpryDt"/>
				</exp_date>
			</xsl:if>	
			<po_ref_id>
				<xsl:value-of select="//PushdThrghBaseln/PurchsOrdrRef/Id"/>
			</po_ref_id>
			<part_ship>
			    <xsl:choose>
			    		<xsl:when test="//Goods/PrtlShipmnt[.='true']">Y</xsl:when>
			    		<xsl:otherwise>N</xsl:otherwise>
			    </xsl:choose>
			</part_ship>
			<tran_ship>
				 <xsl:choose>
			    		<xsl:when test="//Goods/TrnsShipmnt[.='true']">Y</xsl:when>
			    		<xsl:otherwise>N</xsl:otherwise>
			    </xsl:choose>
			</tran_ship>
			<payments>
			 <xsl:for-each select="//PushdThrghBaseln/PmtTerms">
				<payment>
					<xsl:choose>
						<xsl:when test="OthrPmtTerms">
							<other_paymt_terms>
								<xsl:value-of select="OthrPmtTerms"/>
							</other_paymt_terms>
						</xsl:when>
						<xsl:otherwise>
							<code>
							 	<xsl:value-of select="PmtCd/Cd"/>
							</code>
							<xsl:if test="PmtCd/NbOfDays">							
								<nb_days>
									<xsl:value-of select="PmtCd/NbOfDays"/>
								</nb_days>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>	
						<xsl:when test="Amt">
							<cur_code>
								<xsl:value-of select="Amt/@Ccy"/>
							</cur_code>
							<amt>
								<xsl:value-of select="Amt"/>
							</amt>
						</xsl:when>
						<xsl:otherwise>
							<cur_code>
								<xsl:value-of select="//Goods/TtlNetAmt/@Ccy"/>
							</cur_code>
							<pct>
								<xsl:value-of select="Pctg"/>
							</pct>
						</xsl:otherwise>
					</xsl:choose>
					<is_valid>Y</is_valid>
				</payment>
			</xsl:for-each>
			</payments>								 
			<xsl:if test="//PushdThrghBaseln/SttlmTerms">
			<fin_inst_bic><xsl:value-of select="//PushdThrghBaseln/SttlmTerms/CdtrAgt/BIC"/></fin_inst_bic>								
			<fin_inst_name><xsl:value-of select="//PushdThrghBaseln/SttlmTerms/CdtrAgt/NmAndAdr/Nm"/></fin_inst_name>
			<fin_inst_street_name><xsl:value-of select="//PushdThrghBaseln/SttlmTerms/CdtrAgt/NmAndAdr/Adr/StrtNm"/></fin_inst_street_name>
			<fin_inst_post_code><xsl:value-of select="//PushdThrghBaseln/SttlmTerms/CdtrAgt/NmAndAdr/Adr/PstCdId"/></fin_inst_post_code>
			<fin_inst_town_name><xsl:value-of select="//PushdThrghBaseln/SttlmTerms/CdtrAgt/NmAndAdr/Adr/TwnNm"/></fin_inst_town_name>
			<fin_inst_country_sub_div><xsl:value-of select="//PushdThrghBaseln/SttlmTerms/CdtrAgt/NmAndAdr/Adr/CtrySubDvsn"/></fin_inst_country_sub_div>
			<fin_inst_country><xsl:value-of select="//PushdThrghBaseln/SttlmTerms/CdtrAgt/NmAndAdr/Adr/Ctry"/></fin_inst_country>
			<seller_account_iban><xsl:value-of select="//PushdThrghBaseln/SttlmTerms/CdtrAcct/Id/IBAN"/></seller_account_iban>
			<seller_account_bban><xsl:value-of select="//PushdThrghBaseln/SttlmTerms/CdtrAcct/Id/BBAN"/></seller_account_bban>
			<seller_account_upic><xsl:value-of select="//PushdThrghBaseln/SttlmTerms/CdtrAcct/Id/UPIC"/></seller_account_upic>
			<seller_account_id><xsl:value-of select="//PushdThrghBaseln/SttlmTerms/CdtrAcct/Id/Othr"/></seller_account_id>			
			<seller_account_type_code><xsl:value-of select="//PushdThrghBaseln/SttlmTerms/CdtrAcct/Tp/Cd"/></seller_account_type_code>			
			<seller_account_cur_code><xsl:value-of select="//PushdThrghBaseln/SttlmTerms/CdtrAcct/Ccy"/></seller_account_cur_code>
			<seller_account_name><xsl:value-of select="//PushdThrghBaseln/SttlmTerms/CdtrAcct/Nm"/></seller_account_name>
			
			</xsl:if>
						
			<xsl:if test="//PushdThrghBaseln/PmtOblgtn != ''">
				<bank_payment_obligation>
					<bpo>
	    				<xsl:variable name="cdata">![CDATA[</xsl:variable>
						<xsl:variable name="end">]]</xsl:variable>
						<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:apply-templates select="//PushdThrghBaseln/PmtOblgtn" mode="update"/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
					</bpo>
					<bpo_xml>
						<xsl:copy-of select="//PushdThrghBaseln/PmtOblgtn"/>
					</bpo_xml>
				</bank_payment_obligation>
			</xsl:if>			
			<lineItems>
				   <xsl:for-each select="//Goods/LineItmDtls">
					   <lineItem>
					   		<line_item_number>
					   		 	 <xsl:value-of select="LineItmId"/>
					   		</line_item_number>
					   		<qty_unit_measr_code>
					   		 	<xsl:value-of select="Qty/UnitOfMeasrCd"/>
					   		</qty_unit_measr_code>
					   		<qty_val>
					   			<xsl:value-of select="Qty/Val"/>
					   		</qty_val>
					   		<qty_factor>
					   			<xsl:value-of select="Qty/Fctr"/>
					   		</qty_factor>
					   		<qty_tol_pstv_pct>
					   			<xsl:value-of select="QtyTlrnce/PlusPct"/>
					   		</qty_tol_pstv_pct>
							<qty_tol_neg_pct>
								<xsl:value-of select="QtyTlrnce/MnsPct"/>
							</qty_tol_neg_pct>
					   		<price_unit_measr_code>
					   			<xsl:value-of select="UnitPric/UnitPric/UnitOfMeasrCd"/>
					   		</price_unit_measr_code>
					   		<price_cur_code>
					   			<xsl:value-of select="UnitPric/Amt/@Ccy"/>
					   		</price_cur_code>
					   		<price_amt>
					   			<xsl:value-of select="UnitPric/Amt"/>
					   		</price_amt>
					   		<price_factor>
					   			<xsl:value-of select="UnitPric/Fctr"/>
					   		</price_factor>
					   		<price_tol_pstv_pct>
					   			<xsl:value-of select="PricTlrnce/PlusPct"/>
					   		</price_tol_pstv_pct>
					   		<price_tol_neg_pct>
					   			<xsl:value-of select="PricTlrnce/MnsPct"/>
					   		</price_tol_neg_pct>
					   		<product_name>
					   			<xsl:value-of select="PdctNm"/>
					   		</product_name>
					   		<total_net_cur_code>
					   			<xsl:value-of select="TtlAmt/@Ccy"/>
					   		</total_net_cur_code>
					   		<total_cur_code>
					   			<xsl:value-of select="TtlAmt/@Ccy"/>
					   		</total_cur_code>
					   		<total_amt>
								<xsl:value-of select="TtlAmt"/>
					   		</total_amt>
					   		<total_net_amt>
								<xsl:value-of select="TtlAmt"/>
							</total_net_amt>
					   		<product_orgn>
					   			<xsl:value-of select="PdctOrgn"/>
					   		</product_orgn>
					   		<freight_charges_type>
					   			<xsl:value-of select="FrghtChrgs/Tp"/>
					   		</freight_charges_type>
					   		<xsl:if test="//ShipmntDtRg/LatstShipmntDt"> 
					   			<last_ship_date>
					   				<xsl:value-of select="//ShipmntDtRg/LatstShipmntDt"/>
					   			</last_ship_date>
					   		</xsl:if>	
					   		<xsl:if test="//ShipmntDtRg/EarlstShipmntDt"> 
					   			<earliest_ship_date>
					   				<xsl:value-of select="//ShipmntDtRg/EarlstShipmntDt"/>
					   			</earliest_ship_date>
					   		</xsl:if>				   		
					   		<productIdentifiers>
					   			 <xsl:for-each select="PdctIdr">
										<productIdentifier>
										    <xsl:choose>
										    <xsl:when test="StrdPdctIdr/Tp != 'OTHR'">
												<type>
													<xsl:value-of select="StrdPdctIdr/Tp"/>
												</type>
												<description>
													<xsl:value-of select="StrdPdctIdr/Idr"/>
												</description>
											</xsl:when>
											<xsl:otherwise>
												<other_type>
													<xsl:value-of select="OthrPdctIdr/Id"/>
												</other_type>
												<description>
													<xsl:value-of select="OthrPdctIdr/IdTp"/>
												</description>
											</xsl:otherwise>
											</xsl:choose>
											<is_valid>Y</is_valid>
										</productIdentifier>
								</xsl:for-each>
						   </productIdentifiers>
						   <productCharacteristics>
						      <xsl:for-each select="PdctChrtcs">
								<productCharacteristic>									
										<xsl:choose>
											<xsl:when test="StrdPdctChrtcs/Tp != 'OTHR'">
												<type><xsl:value-of select="StrdPdctChrtcs/Tp"/></type>
												<description><xsl:value-of select="StrdPdctChrtcs/Chrtcs"/></description>
											</xsl:when>	
											<xsl:otherwise>
												<other_type><xsl:value-of select="OthrPdctChrtcs/Id"/></other_type>
												<description><xsl:value-of select="OthrPdctChrtcs/IdTp"/></description>
											</xsl:otherwise>										
										</xsl:choose>	
										<is_valid>Y</is_valid>
								</productCharacteristic>
							  </xsl:for-each>
							</productCharacteristics>
							<productCategories>
								<xsl:for-each select="PdctCtgy">
								<productCategory>									
										<xsl:choose>
											<xsl:when test="StrdPdctCtgy/Tp != 'OTHR' ">
												<type><xsl:value-of select="StrdPdctCtgy/Tp"/></type>
												<description><xsl:value-of select="StrdPdctCtgy/Ctgy"/></description>
											</xsl:when>	
											<xsl:otherwise>
												<other_type><xsl:value-of select="OthrPdctCtgy/Id"/></other_type>
												<description><xsl:value-of select="OthrPdctCtgy/IdTp"/></description>
											</xsl:otherwise>										
										</xsl:choose>	
										<is_valid>Y</is_valid>
								</productCategory>
							  </xsl:for-each>
							</productCategories>
							<shipmentSchedules>																
								<xsl:for-each select="ShipmntSchdl/ShipmntSubSchdl">
									<shipmentSchedule>
										<xsl:if test="SubQtyVal">
											<sub_shipment_quantity_value><xsl:value-of select="SubQtyVal"/></sub_shipment_quantity_value>
										</xsl:if>								
										<xsl:if test="EarlstShipmntDt">
											<schedule_earliest_ship_date><xsl:value-of select="EarlstShipmntDt"/></schedule_earliest_ship_date>
										</xsl:if>
										<xsl:if test="LatstShipmntDt">
											<schedule_latest_ship_date><xsl:value-of select="LatstShipmntDt"/></schedule_latest_ship_date>
										</xsl:if>
										<is_valid>Y</is_valid>
									</shipmentSchedule>								
								</xsl:for-each>						
							</shipmentSchedules>							
							<routingSummaries>
								<xsl:for-each select="RtgSummry/IndvTrnsprt/TrnsprtByAir">
									<routingSummary>									
											<routing_summary_mode>01</routing_summary_mode>
											<routing_summary_type>01</routing_summary_type>
											<xsl:if test="AirCrrierNm">
												<air_carrier_name><xsl:value-of select="AirCrrierNm"/></air_carrier_name>											
											</xsl:if>
											<is_valid>Y</is_valid>
											<departures>
												<xsl:for-each select="DprtureAirprt">
												<departure>
													<xsl:choose>
														<xsl:when test="AirprtCd">
															<departure_airport_code><xsl:value-of select="AirprtCd"/></departure_airport_code>
														</xsl:when>
														<xsl:otherwise>
															<departure_air_town><xsl:value-of select="OthrAirprtDesc/Twn"/></departure_air_town>
															<xsl:if test="OthrAirprtDesc/AirprtNm">
																<departure_airport_name><xsl:value-of select="OthrAirprtDesc/AirprtNm"/></departure_airport_name>
															</xsl:if>															
														</xsl:otherwise>														
													</xsl:choose>
													<routing_summary_sub_type>01</routing_summary_sub_type>	
													<is_valid>Y</is_valid>												
												</departure>
												</xsl:for-each>											
											</departures>
											<destinations>
												<xsl:for-each select="DstnAirprt">
													<destination>
														<xsl:choose>
															<xsl:when test="AirprtCd">
																<destination_airport_code><xsl:value-of select="AirprtCd"/></destination_airport_code>
															</xsl:when>
															<xsl:otherwise>
																<destination_air_town><xsl:value-of select="OthrAirprtDesc/Twn"/></destination_air_town>
																<xsl:if test="OthrAirprtDesc/AirprtNm">
																	<destination_airport_name><xsl:value-of select="OthrAirprtDesc/AirprtNm"/></destination_airport_name>
																</xsl:if>															
															</xsl:otherwise>
														</xsl:choose>		
														<routing_summary_sub_type>02</routing_summary_sub_type>			
														<is_valid>Y</is_valid>									
													</destination>
												</xsl:for-each>
											</destinations>											
										</routingSummary>
									</xsl:for-each>
								</routingSummaries>								
													
								<routingSummaries>
									<xsl:for-each select="RtgSummry/IndvTrnsprt/TrnsprtBySea">
										<routingSummary>
												<routing_summary_mode>02</routing_summary_mode>
												<routing_summary_type>01</routing_summary_type>
												<xsl:if test="SeaCrrierNm">
													<sea_carrier_name><xsl:value-of select="SeaCrrierNm"/></sea_carrier_name>
												</xsl:if>
												<is_valid>Y</is_valid>
												
													<loading_ports>													
														<xsl:for-each select="PortOfLoadng">
															<loading_port>
																<loading_port_name><xsl:value-of select="."/></loading_port_name>		
																<routing_summary_sub_type>03</routing_summary_sub_type>
																<is_valid>Y</is_valid>																									
															</loading_port> 														
														</xsl:for-each>	
													</loading_ports>													
													<discharge_ports>
														<xsl:for-each select="PortOfDschrge">
															<discharge_port>
																<discharge_port_name><xsl:value-of select="."/></discharge_port_name>
																<routing_summary_sub_type>04</routing_summary_sub_type>
																<is_valid>Y</is_valid>													
															</discharge_port> 														
														</xsl:for-each>	
													</discharge_ports>
										</routingSummary>	
									</xsl:for-each>							
								</routingSummaries>
								
								<routingSummaries>
									<xsl:for-each select="RtgSummry/IndvTrnsprt/TrnsprtByRoad">
										<routingSummary>
											<routing_summary_mode>03</routing_summary_mode>
											<routing_summary_type>01</routing_summary_type>
											<xsl:if test="RoadCrrierNm">
													<road_carrier_name><xsl:value-of select="RoadCrrierNm"/></road_carrier_name>
											</xsl:if>
											<is_valid>Y</is_valid>
											
												<road_receipt_places>
													<xsl:for-each select="PlcOfRct">
														<road_receipt_place>
															<road_receipt_place_name><xsl:value-of select="."/></road_receipt_place_name>	
															<is_valid>Y</is_valid>
															<routing_summary_sub_type>05</routing_summary_sub_type>												
														</road_receipt_place> 																							
													</xsl:for-each>	
												</road_receipt_places>	
												<road_delivery_places>
													<xsl:for-each select="PlcOfDlvry">
														<road_delivery_place>
															<road_delivery_place_name>
																<xsl:value-of select="."/>		
															</road_delivery_place_name>
															<is_valid>Y</is_valid>
															<routing_summary_sub_type>06</routing_summary_sub_type>												
														</road_delivery_place> 
													</xsl:for-each>	
												</road_delivery_places>																								
										</routingSummary>
									</xsl:for-each>	
								</routingSummaries>								
								
								<routingSummaries>
									<xsl:for-each select="RtgSummry/IndvTrnsprt/TrnsprtByRail">
										<routingSummary>
											<routing_summary_mode>04</routing_summary_mode>
											<routing_summary_type>01</routing_summary_type>
											<xsl:if test="RailCrrierNm">
												<rail_carrier_name><xsl:value-of select="RailCrrierNm"/></rail_carrier_name>
											</xsl:if>	
											<is_valid>Y</is_valid>											
											<rail_receipt_places>
												<xsl:for-each select="PlcOfRct">
													<rail_receipt_place>
														<rail_receipt_place_name><xsl:value-of select="."/></rail_receipt_place_name>	
														<is_valid>Y</is_valid>
														<routing_summary_sub_type>07</routing_summary_sub_type>													
													</rail_receipt_place> 
												</xsl:for-each>	
											</rail_receipt_places>	
											<rail_delivery_places>
												<xsl:for-each select="PlcOfDlvry">
													<rail_delivery_place>
														<rail_delivery_place_name><xsl:value-of select="."/></rail_delivery_place_name>	
														<is_valid>Y</is_valid>
														<routing_summary_sub_type>08</routing_summary_sub_type>													
													</rail_delivery_place> 
												</xsl:for-each>	
											</rail_delivery_places>																						
										</routingSummary>
									</xsl:for-each>
							</routingSummaries>
							<xsl:if test="RtgSummry/MltmdlTrnsprt/TakngInChrg">
								<taking_in_charge>
									<xsl:value-of select="RtgSummry/MltmdlTrnsprt/TakngInChrg"/>
								</taking_in_charge>
								<final_dest_place>
									<xsl:value-of select="RtgSummry/MltmdlTrnsprt/PlcOfFnlDstn"/>
								</final_dest_place>
							</xsl:if>												
							<freightCharges>
								<xsl:for-each select="FrghtChrgs/Chrgs">
									<freightCharge>									
										<type>
											<xsl:value-of select="Tp"/>
										</type>
										<other_type>
											<xsl:value-of select="OthrChrgsTp"/>
										</other_type>
										<cur_code>
											<xsl:value-of select="Amt/@Ccy"/>
										</cur_code>
										<amt>
											<xsl:value-of select="Amt"/>
										</amt>
										<rate>
											<xsl:value-of select="Pctg"/>
										</rate>												
										<is_valid>Y</is_valid>
									</freightCharge>
								</xsl:for-each>
							</freightCharges>
							<taxes>
								<xsl:for-each select="Tax">
									<tax>
										<type>
											<xsl:value-of select="Tp"/>
										</type>
										<other_type>
											<xsl:value-of select="OthrTaxTp"/>
										</other_type>
										<cur_code>
											<xsl:value-of select="Amt/@Ccy"/>
										</cur_code>
										<amt>
											<xsl:value-of select="Amt"/>
										</amt>
										<rate />
										<is_valid>Y</is_valid>
									</tax>
								 </xsl:for-each>
							</taxes>
						<incoterms>
							<xsl:for-each select="Incotrms">
								<incoterm>
									<xsl:choose>
										<xsl:when test="Othr">
											<code>OTHR</code>
											<other>
												<xsl:value-of select="Othr"/>
											</other>
										</xsl:when>
										<xsl:otherwise>
											<code>
												<xsl:value-of select="Cd"/>
											</code>
										</xsl:otherwise>
									</xsl:choose>
									<location>
										<xsl:value-of select="Lctn"/>
									</location>
									<is_valid>Y</is_valid>
								</incoterm>
							</xsl:for-each>
					</incoterms>
					<adjustments>
						<xsl:for-each select="Adjstmnt">
							<adjustment>
								<type>
									<xsl:value-of select="Tp"/>
								</type>
								<other_type>
									<xsl:value-of select="OthrAdjstmntTp"/>
								</other_type>
								<direction>
									<xsl:value-of select="Drctn"/>
								</direction>
								<cur_code>
									<xsl:value-of select="Amt/@Ccy"/>
								</cur_code>
								<amt>
									<xsl:value-of select="Amt"/>
								</amt>
								<rate>
									<xsl:value-of select="Rate"/>
								</rate>
								<is_valid>Y</is_valid>
							</adjustment>
						</xsl:for-each>
		  			</adjustments>
		  			<is_valid>Y</is_valid>
					   </lineItem>		
			   		</xsl:for-each>
			   	</lineItems>
		   	<LineItmsTtlAmt><xsl:value-of select="//Goods/LineItmsTtlAmt/@Ccy"/></LineItmsTtlAmt>
		   	<routingSummaries>
				<xsl:for-each select="//Goods/RtgSummry/IndvTrnsprt/TrnsprtByAir">
					<routingSummary>									
							<routing_summary_mode>01</routing_summary_mode>
							<routing_summary_type>01</routing_summary_type>
							<xsl:if test="AirCrrierNm">
								<air_carrier_name><xsl:value-of select="AirCrrierNm"/></air_carrier_name>											
							</xsl:if>
							<is_valid>Y</is_valid>
							<departures>
								<xsl:for-each select="DprtureAirprt">
								<departure>
									<xsl:choose>
										<xsl:when test="AirprtCd">
											<departure_airport_code><xsl:value-of select="AirprtCd"/></departure_airport_code>
										</xsl:when>
										<xsl:otherwise>
											<departure_air_town><xsl:value-of select="OthrAirprtDesc/Twn"/></departure_air_town>
											<xsl:if test="OthrAirprtDesc/AirprtNm">
												<departure_airport_name><xsl:value-of select="OthrAirprtDesc/AirprtNm"/></departure_airport_name>
											</xsl:if>															
										</xsl:otherwise>														
									</xsl:choose>
									<routing_summary_sub_type>01</routing_summary_sub_type>	
									<is_valid>Y</is_valid>												
								</departure>
								</xsl:for-each>											
							</departures>
							<destinations>
								<xsl:for-each select="DstnAirprt">
									<destination>
										<xsl:choose>
											<xsl:when test="AirprtCd">
												<destination_airport_code><xsl:value-of select="AirprtCd"/></destination_airport_code>
											</xsl:when>
											<xsl:otherwise>
												<destination_air_town><xsl:value-of select="OthrAirprtDesc/Twn"/></destination_air_town>
												<xsl:if test="OthrAirprtDesc/AirprtNm">
													<destination_airport_name><xsl:value-of select="OthrAirprtDesc/AirprtNm"/></destination_airport_name>
												</xsl:if>															
											</xsl:otherwise>
										</xsl:choose>		
										<routing_summary_sub_type>01</routing_summary_sub_type>			
										<is_valid>Y</is_valid>									
									</destination>
								</xsl:for-each>
							</destinations>											
						</routingSummary>
					</xsl:for-each>
				</routingSummaries>								
									
				<routingSummaries>
					<xsl:for-each select="//Goods/RtgSummry/IndvTrnsprt/TrnsprtBySea">
						<routingSummary>
								<routing_summary_mode>02</routing_summary_mode>
								<routing_summary_type>02</routing_summary_type>
								<xsl:if test="SeaCrrierNm">
									<sea_carrier_name><xsl:value-of select="SeaCrrierNm"/></sea_carrier_name>
								</xsl:if>
								<is_valid>Y</is_valid>
								
									<loading_ports>													
										<xsl:for-each select="PortOfLoadng">
											<loading_port>
												<loading_port_name><xsl:value-of select="."/></loading_port_name>		
												<routing_summary_sub_type>03</routing_summary_sub_type>
												<is_valid>Y</is_valid>																									
											</loading_port> 														
										</xsl:for-each>	
									</loading_ports>													
									<discharge_ports>
										<xsl:for-each select="PortOfDschrge">
											<discharge_port>
												<discharge_port_name><xsl:value-of select="."/></discharge_port_name>
												<routing_summary_sub_type>04</routing_summary_sub_type>
												<is_valid>Y</is_valid>													
											</discharge_port> 														
										</xsl:for-each>	
									</discharge_ports>
						</routingSummary>	
					</xsl:for-each>							
				</routingSummaries>
				
				<routingSummaries>
					<xsl:for-each select="//Goods/RtgSummry/IndvTrnsprt/TrnsprtByRoad">
						<routingSummary>
							<routing_summary_mode>03</routing_summary_mode>
							<routing_summary_type>03</routing_summary_type>
							<xsl:if test="RoadCrrierNm">
									<road_carrier_name><xsl:value-of select="RoadCrrierNm"/></road_carrier_name>
							</xsl:if>
							<is_valid>Y</is_valid>
							
								<road_receipt_places>
									<xsl:for-each select="PlcOfRct">
										<road_receipt_place>
											<road_receipt_place_name><xsl:value-of select="."/></road_receipt_place_name>	
											<is_valid>Y</is_valid>
											<routing_summary_sub_type>05</routing_summary_sub_type>												
										</road_receipt_place> 																							
									</xsl:for-each>	
								</road_receipt_places>	
								<road_delivery_places>
									<xsl:for-each select="PlcOfDlvry">
										<road_delivery_place>
											<road_delivery_place_name>
												<xsl:value-of select="."/>		
											</road_delivery_place_name>
											<is_valid>Y</is_valid>
											<routing_summary_sub_type>06</routing_summary_sub_type>												
										</road_delivery_place> 
									</xsl:for-each>	
								</road_delivery_places>																								
						</routingSummary>
					</xsl:for-each>	
				</routingSummaries>								
				
				<routingSummaries>
					<xsl:for-each select="//Goods/RtgSummry/IndvTrnsprt/TrnsprtByRail">
						<routingSummary>
							<routing_summary_mode>04</routing_summary_mode>
							<routing_summary_type>04</routing_summary_type>
							<xsl:if test="RailCrrierNm">
								<rail_carrier_name><xsl:value-of select="RailCrrierNm"/></rail_carrier_name>
							</xsl:if>	
							<is_valid>Y</is_valid>											
							<rail_receipt_places>
								<xsl:for-each select="PlcOfRct">
									<rail_receipt_place>
										<rail_receipt_place_name><xsl:value-of select="."/></rail_receipt_place_name>	
										<is_valid>Y</is_valid>
										<routing_summary_sub_type>07</routing_summary_sub_type>													
									</rail_receipt_place> 
								</xsl:for-each>	
							</rail_receipt_places>	
							<rail_delivery_places>
								<xsl:for-each select="PlcOfDlvry">
									<rail_delivery_place>
										<rail_delivery_place_name><xsl:value-of select="."/></rail_delivery_place_name>	
										<is_valid>Y</is_valid>
										<routing_summary_sub_type>08</routing_summary_sub_type>													
									</rail_delivery_place> 
								</xsl:for-each>	
							</rail_delivery_places>																						
						</routingSummary>
					</xsl:for-each>
			</routingSummaries>
			<xsl:if test="//Goods/RtgSummry/MltmdlTrnsprt/TakngInChrg">
				<taking_in_charge>
					<xsl:value-of select="//Goods/RtgSummry/MltmdlTrnsprt/TakngInChrg"/>
				</taking_in_charge>
				<final_dest_place>
					<xsl:value-of select="//Goods/RtgSummry/MltmdlTrnsprt/PlcOfFnlDstn"/>
				</final_dest_place>
			</xsl:if>  	
		   
			<total_cur_code>
				<xsl:value-of select="//Goods/TtlNetAmt/@Ccy"/>
			</total_cur_code>
			<total_amt>
				<xsl:value-of select="//Goods/TtlNetAmt"/>
			</total_amt>
			<total_net_cur_code>
				<xsl:value-of select="//Goods/TtlNetAmt/@Ccy"/>
			</total_net_cur_code>
			<total_net_amt>
				<xsl:value-of select="//Goods/TtlNetAmt"/>
			</total_net_amt>
			<incoterms>
				<xsl:for-each select="//Goods/Incotrms">
					<incoterm>
						<xsl:choose>
							<xsl:when test="Othr">
								<code>OTHR</code>
								<other>
									<xsl:value-of select="Othr"/>
								</other>
							</xsl:when>
							<xsl:otherwise>
								<code>
									<xsl:value-of select="Cd"/>
								</code>
							</xsl:otherwise>
						</xsl:choose>
						<location>
							<xsl:value-of select="Lctn"/>
						</location>
						<is_valid>Y</is_valid>
					</incoterm>
				</xsl:for-each>
			</incoterms>
			<adjustments>
				<xsl:for-each select="//Goods/Adjstmnt">
					<adjustment>
						<type>
							<xsl:value-of select="Tp"/>
						</type>
						<other_type>
							<xsl:value-of select="OthrAdjstmntTp"/>
						</other_type>
						<direction>
							<xsl:value-of select="Drctn"/>
						</direction>
						<cur_code>
							<xsl:value-of select="Amt/@Ccy"/>
						</cur_code>
						<amt>
							<xsl:value-of select="Amt"/>
						</amt>
						<rate>
							<xsl:value-of select="Rate"/>
						</rate>
						<is_valid>Y</is_valid>
					</adjustment>
				</xsl:for-each>
  			</adjustments>
		  <taxes>
			<xsl:for-each select="//Goods/Tax">
					<tax>
						<type>
							<xsl:value-of select="Tp"/>
						</type>
						<other_type>
							<xsl:value-of select="OthrTaxTp"/>
						</other_type>
						<cur_code>
							<xsl:value-of select="Amt/@Ccy"/>
						</cur_code>
						<amt>
							<xsl:value-of select="Amt"/>
						</amt>
						<rate>
							<xsl:value-of select="Pctg"/>
						</rate>
						<is_valid>Y</is_valid>
					</tax>
			  </xsl:for-each>
			</taxes>
		  	<freightCharges>
				<xsl:for-each select="//Goods/FrghtChrgs/Chrgs">
					<freightCharge>									
						<type>
							<xsl:value-of select="Tp"/>
						</type>
						<other_type>
							<xsl:value-of select="OthrChrgsTp"/>
						</other_type>
						<cur_code>
							<xsl:value-of select="Amt/@Ccy"/>
						</cur_code>
						<amt>
							<xsl:value-of select="Amt"/>
						</amt>
						<rate>
							<xsl:value-of select="Pctg"/>
						</rate>												
						<is_valid>Y</is_valid>
					</freightCharge>
				</xsl:for-each>
			</freightCharges>
		   	<contacts>
		   		<xsl:for-each select="//SellrCtctPrsn">
				   	 <contact>
				   	    <type>01</type>
						<type_decode>Contact Seller</type_decode>
						<bic></bic>
						<name_prefix>
							<xsl:value-of select="//SellrCtctPrsn/NmPrfx"/>
						</name_prefix>
						<name_value>
							<xsl:value-of select="//SellrCtctPrsn/Nm"/>
						</name_value>
						<given_name>
							<xsl:value-of select="//SellrCtctPrsn/GvnNm"/>
						</given_name>
						<role>
							<xsl:value-of select="//SellrCtctPrsn/Role"/>
						</role>
						<phone_number>
							<xsl:value-of select="//SellrCtctPrsn/PhneNb"/>
						</phone_number>
						<fax_number>
							<xsl:value-of select="//SellrCtctPrsn/FaxNb"/>
						</fax_number>
						<email>
							<xsl:value-of select="//SellrCtctPrsn/EmailAdr"/>
						</email>
						<is_valid>Y</is_valid>
				   	 </contact>
			   	 </xsl:for-each>
			   	 <xsl:for-each select="//BuyrCtctPrsn">
				   	 <contact>
				   	    <type>02</type>
						<type_decode>Contact Buyer</type_decode>
						<bic></bic>
						<name_prefix>
							<xsl:value-of select="//BuyrCtctPrsn/NmPrfx"/>
						</name_prefix>
						<name_value>
							<xsl:value-of select="//BuyrCtctPrsn/Nm"/>
						</name_value>
						<given_name>
							<xsl:value-of select="//BuyrCtctPrsn/GvnNm"/>
						</given_name>
						<role>
							<xsl:value-of select="//BuyrCtctPrsn/Role"/>
						</role>
						<phone_number>
							<xsl:value-of select="//BuyrCtctPrsn/PhneNb"/>
						</phone_number>
						<fax_number>
							<xsl:value-of select="//BuyrCtctPrsn/FaxNb"/>
						</fax_number>
						<email>
							<xsl:value-of select="//BuyrCtctPrsn/EmailAdr"/>
						</email>
						<is_valid>Y</is_valid>
				   	 </contact>
			   	 </xsl:for-each>
			   	 <xsl:for-each select="//SellrBkCtctPrsn">
				   	 <contact>
				   	    <type>03</type>
						<type_decode>Contact Seller Bank</type_decode>
						<bic></bic>
						<name_prefix>
							<xsl:value-of select="//SellrBkCtctPrsn/NmPrfx"/>
						</name_prefix>
						<name_value>
							<xsl:value-of select="//SellrBkCtctPrsn/Nm"/>
						</name_value>
						<given_name>
							<xsl:value-of select="//SellrBkCtctPrsn/GvnNm"/>
						</given_name>
						<role>
							<xsl:value-of select="//SellrBkCtctPrsn/Role"/>
						</role>
						<phone_number>
							<xsl:value-of select="//SellrBkCtctPrsn/PhneNb"/>
						</phone_number>
						<fax_number>
							<xsl:value-of select="//SellrBkCtctPrsn/FaxNb"/>
						</fax_number>
						<email>
							<xsl:value-of select="//SellrBkCtctPrsn/EmailAdr"/>
						</email>
						<is_valid>Y</is_valid>
				   	 </contact>
			   	 </xsl:for-each>
			   	 <xsl:for-each select="//BuyrBkCtctPrsn">
				   	 <contact>
				   	    <type>04</type>
						<type_decode>Contact Buyer Bank</type_decode>
						<bic></bic>
						<name_prefix>
							<xsl:value-of select="//BuyrBkCtctPrsn/NmPrfx"/>
						</name_prefix>
						<name_value>
							<xsl:value-of select="//BuyrBkCtctPrsn/Nm"/>
						</name_value>
						<given_name>
							<xsl:value-of select="//BuyrBkCtctPrsn/GvnNm"/>
						</given_name>
						<role>
							<xsl:value-of select="//BuyrBkCtctPrsn/Role"/>
						</role>
						<phone_number>
							<xsl:value-of select="//BuyrBkCtctPrsn/PhneNb"/>
						</phone_number>
						<fax_number>
							<xsl:value-of select="//BuyrBkCtctPrsn/FaxNb"/>
						</fax_number>
						<email>
							<xsl:value-of select="//BuyrBkCtctPrsn/EmailAdr"/>
						</email>
						<is_valid>Y</is_valid>
				   	 </contact>
			   	 </xsl:for-each>
			   	 <xsl:for-each select="//OthrBkCtctPrsn">
				   	 <contact>
				   	    <type>08</type>
						<type_decode>Contact Other</type_decode>
						<bic><xsl:value-of select="//OthrBkCtctPrsn/BIC"/></bic>
						<name_prefix>
							<xsl:value-of select="//OthrBkCtctPrsn/NmPrfx"/>
						</name_prefix>
						<name_value>
							<xsl:value-of select="//OthrBkCtctPrsn/Nm"/>
						</name_value>
						<given_name>
							<xsl:value-of select="//OthrBkCtctPrsn/GvnNm"/>
						</given_name>
						<role>
							<xsl:value-of select="//OthrBkCtctPrsn/Role"/>
						</role>
						<phone_number>
							<xsl:value-of select="//OthrBkCtctPrsn/PhneNb"/>
						</phone_number>
						<fax_number>
							<xsl:value-of select="//OthrBkCtctPrsn/FaxNb"/>
						</fax_number>
						<email>
							<xsl:value-of select="//OthrBkCtctPrsn/EmailAdr"/>
						</email>
						<is_valid>Y</is_valid>
				   	 </contact>
			   	 </xsl:for-each>
		   	</contacts>
		   	
		   	<buyer_defined_informations>
				<xsl:for-each select="//Goods/BuyrDfndInf">
					<buyer_defined_information>
							<label>
								<xsl:value-of select="Labl"/>
							</label>
							<information>
								<xsl:value-of select="Inf"/>
							</information>
							<is_valid>Y</is_valid>
					</buyer_defined_information>
				</xsl:for-each>
	    	</buyer_defined_informations>
	    	
	    	<seller_defined_informations>
				<xsl:for-each select="//Goods/SellrDfndInf">
					<seller_defined_information>
						<label>
							<xsl:value-of select="Labl"/>
						</label>
						<information>
							<xsl:value-of select="Inf"/>
						</information>
					</seller_defined_information>
				</xsl:for-each>   	
	    	</seller_defined_informations>
		   	<tid>
		   		<xsl:value-of select="//TxId/Id"/>
		   	</tid>
			<issuing_bank_abbv_name><xsl:value-of select="$bankDetailsFromSellerBic/bank_details/bank_abbv_name"/></issuing_bank_abbv_name>
			<issuing_bank_name><xsl:value-of select="$bankDetailsFromSellerBic/bank_details/bank_name"/></issuing_bank_name>
			<issuing_bank_address_line_1><xsl:value-of select="$bankDetailsFromSellerBic/bank_details/bank_addr_line_1"/></issuing_bank_address_line_1>
			<issuing_bank_address_line_2><xsl:value-of select="$bankDetailsFromSellerBic/bank_details/bank_addr_line_2"/></issuing_bank_address_line_2>
			<issuing_bank_dom><xsl:value-of select="$bankDetailsFromSellerBic/bank_details/bank_dom"/></issuing_bank_dom>
			<issuing_bank_reference><xsl:value-of select="$bankDetailsFromSellerBic/bank_details/bank_ref"/></issuing_bank_reference>
			<issuing_bank_iso_code><xsl:value-of select="//PushdThrghBaseln/SellrBk/BIC"/></issuing_bank_iso_code>
			<!-- <UsrTxRef_id><xsl:value-of select="//UsrTxRef/Id"/></UsrTxRef_id>
			<UsrTxRef_IdIssrbic><xsl:value-of select="//UsrTxRef/IdIssr/BIC"/></UsrTxRef_IdIssrbic>
			<SubmitrBaselnId>
				<Id><xsl:value-of select="//PushdThrghBaseln/SubmitrBaselnId/Id"/></Id>
		        <Vrsn><xsl:value-of select="//PushdThrghBaseln/SubmitrBaselnId/Vrsn"/></Vrsn>
		        <Submitr>
		          <BIC><xsl:value-of select="//PushdThrghBaseln/SubmitrBaselnId/Submitr/BIC"/></BIC>
		        </Submitr>
			</SubmitrBaselnId>
			<SvcCd><xsl:value-of select="//PushdThrghBaseln/SvcCd"/></SvcCd> -->
			
			<xsl:if test="//PushdThrghBaseln/ComrclDataSetReqrd != ''">
				<commercial_dataset>
    				<xsl:variable name="cdata">![CDATA[</xsl:variable>
					<xsl:variable name="end">]]</xsl:variable>
					<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="//PushdThrghBaseln/ComrclDataSetReqrd"/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
				</commercial_dataset>
			</xsl:if>
			<xsl:if test="//PushdThrghBaseln/TrnsprtDataSetReqrd != ''">
				<transport_dataset>
    				<xsl:variable name="cdata">![CDATA[</xsl:variable>
					<xsl:variable name="end">]]</xsl:variable>
					<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="//PushdThrghBaseln/TrnsprtDataSetReqrd"/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
				</transport_dataset>
			</xsl:if>
			<xsl:if test="//PushdThrghBaseln/InsrncDataSetReqrd != ''">
				<insurance_dataset>
    				<xsl:variable name="cdata">![CDATA[</xsl:variable>
					<xsl:variable name="end">]]</xsl:variable>
					<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="//PushdThrghBaseln/InsrncDataSetReqrd"/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
				</insurance_dataset>
			</xsl:if>
			
			<xsl:if test="//PushdThrghBaseln/CertDataSetReqrd != ''">
				<certificate_dataset>
    				<xsl:variable name="cdata">![CDATA[</xsl:variable>
					<xsl:variable name="end">]]</xsl:variable>
					<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="//PushdThrghBaseln/CertDataSetReqrd"/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
				</certificate_dataset>
			</xsl:if>
			<xsl:if test="//PushdThrghBaseln/OthrCertDataSetReqrd != ''">
				<other_certificate_dataset>
    				<xsl:variable name="cdata">![CDATA[</xsl:variable>
					<xsl:variable name="end">]]</xsl:variable>
					<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="//PushdThrghBaseln/OthrCertDataSetReqrd"/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
				</other_certificate_dataset>
			</xsl:if>
			<!-- <InttToPayXpctd><xsl:value-of select="//PushdThrghBaseln/InttToPayXpctd"/></InttToPayXpctd> -->
			
			
			<!-- <RptPurp>
				<Tp><xsl:value-of select="//RptPurp/Tp"/></Tp>
			</RptPurp>
			<ReqForActn>
				<ReqForActn_Tp><xsl:value-of select="//ReqForActn/Tp"/></ReqForActn_Tp>
				<ReqForActn_Desc><xsl:value-of select="//ReqForActn/Desc"/></ReqForActn_Desc>
			</ReqForActn> -->
		</ea_tnx_record>
	</xsl:template>
		
	<xsl:template match="//PushdThrghBaseln/PmtOblgtn" mode="update">
	<xsl:variable name="buyerBankBIC" select="//BuyrBk/BIC"/>
	<PmtOblgtn>
		<xsl:choose>
			<xsl:when test="$buyerBankBIC = ./OblgrBk/BIC">
				<buyer_bank_bpo>Y</buyer_bank_bpo>
			</xsl:when>
			<xsl:otherwise>
				<buyer_bank_bpo>N</buyer_bank_bpo>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="node()|@*" />
	</PmtOblgtn>
	</xsl:template>
	<xsl:template match="OblgrBk">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="RcptBk">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="Amt">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="Pctg">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="XpryDt">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="ChrgsAmt">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="ChrgsPctg">
		<xsl:copy-of select="." />
	</xsl:template>
 	<xsl:template match="AplblLaw">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="PmtTerms">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="SttlmTerms">
		<xsl:copy-of select="." />
	</xsl:template>
	
</xsl:stylesheet>
