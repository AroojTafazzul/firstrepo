<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
  exclude-result-prefixes="tools">
  
<xsl:output method="xml" encoding="UTF-8"/>

<xsl:param name="tid"/>
<xsl:param name="tnxId"/>
<xsl:param name="serviceCode"/>
<xsl:param name="messageId"/>
<xsl:param name="messageCreationDate"/>

<xsl:template match="/">
  <xsl:apply-templates />
</xsl:template>

<!-- Main template -->
<xsl:template match="ea_tnx_record">

<Document>
	<BaselnReSubmissn>
		<SubmissnId>
			<Id><xsl:value-of select="$tnxId"/></Id>
			<CreDtTm><xsl:value-of select="tools:getCurrentTMAFormatDateTime()"/></CreDtTm>
		</SubmissnId>
		<TxId><Id><xsl:value-of select="$tid"/></Id></TxId>
		<SubmitrTxRef>
			<Id><xsl:value-of select="$tnxId"/></Id>
		</SubmitrTxRef>
 
		<!-- Actual baseline details -->
		<Baseln>
			<SubmitrBaselnId>
				<Id>
					<xsl:value-of select="$tnxId" />
				</Id>
				<Vrsn>1</Vrsn>
				<Submitr>
					<BIC>
						<xsl:value-of select="buyer_bank_bic" />
					</BIC>
				</Submitr>
			</SubmitrBaselnId>
			<!-- Externalize this to portal.properties -->
			<SvcCd><xsl:value-of select="$serviceCode"/></SvcCd>
			<PurchsOrdrRef>
				<Id><xsl:value-of select="po_ref_id"/></Id>
				<DtOfIsse><xsl:value-of select="tools:getCurrentTMAFormatDate()"/></DtOfIsse>
			</PurchsOrdrRef>
			<!-- Buyer details start -->
			<Buyr>
				<Nm><xsl:value-of select="buyer_abbv_name"/></Nm>
				<xsl:if test="buyer_proprietary_id and buyer_proprietary_id !=''">
					<PrtryId>
						<Id><xsl:value-of select="buyer_proprietary_id"/></Id>
			     			<IdTp><xsl:value-of select="buyer_proprietary_id_type"/></IdTp>
			     		</PrtryId>
			     	</xsl:if>
				<PstlAdr>
					<xsl:if test="buyer_street_name">
						<StrtNm><xsl:value-of select="buyer_street_name"/></StrtNm>
					</xsl:if>
					<xsl:if test="buyer_post_code">
						<PstCdId><xsl:value-of select="buyer_post_code"/></PstCdId>
					</xsl:if>
					<xsl:if test="buyer_town_name">
						<TwnNm><xsl:value-of select="buyer_town_name"/></TwnNm>
					</xsl:if>
					<xsl:if test="buyer_country_sub_div">
						<CtrySubDvsn><xsl:value-of select="buyer_country_sub_div"/></CtrySubDvsn>
					</xsl:if>
					<Ctry><xsl:value-of select="buyer_country"/></Ctry>
				</PstlAdr>
			</Buyr>
			<!-- Buyer details end -->
			
			<!-- Seller details start -->
			<Sellr>
				<Nm><xsl:value-of select="seller_abbv_name"/></Nm>
				<xsl:if test="seller_proprietary_id and seller_proprietary_id !=''">
					<PrtryId>
						<Id><xsl:value-of select="seller_proprietary_id"/></Id>
			    		<IdTp><xsl:value-of select="seller_proprietary_id_type"/></IdTp>
			    	</PrtryId>
			    </xsl:if>					
				<PstlAdr>
					<xsl:if test="seller_street_name">
						<StrtNm><xsl:value-of select="seller_street_name"/></StrtNm>
					</xsl:if>
					<xsl:if test="seller_post_code">
						<PstCdId><xsl:value-of select="seller_post_code"/></PstCdId>
					</xsl:if>
					<xsl:if test="seller_town_name">
						<TwnNm><xsl:value-of select="seller_town_name"/></TwnNm>
					</xsl:if>
					<xsl:if test="seller_country_sub_div">
						<CtrySubDvsn><xsl:value-of select="seller_country_sub_div"/></CtrySubDvsn>
					</xsl:if>
					<Ctry><xsl:value-of select="seller_country"/></Ctry>
				</PstlAdr>
			</Sellr>
			<!-- Seller details end -->
			
			<!-- Buyer bank BIC -->
			<BuyrBk>
				<BIC><xsl:value-of select="buyer_bank_bic"/></BIC>
			</BuyrBk>
			<!-- Seller bank BIC -->
			<SellrBk>
				<BIC><xsl:value-of select="seller_bank_bic"/></BIC>
			</SellrBk>
			<!-- Buyer and Seller side submitting bank implemented as single input fields allowing only one bank BIC -->
			<xsl:if test="buyer_submitting_bank_bic and buyer_submitting_bank_bic !=''">
				<BuyrSdSubmitgBk>
					<BIC><xsl:value-of select="buyer_submitting_bank_bic" /></BIC>
				</BuyrSdSubmitgBk>
			</xsl:if>
			<xsl:if test="seller_submitting_bank_bic and seller_submitting_bank_bic !=''">
				<SellrSdSubmitgBk>
					<BIC><xsl:value-of select="seller_submitting_bank_bic" /></BIC>
				</SellrSdSubmitgBk>
			</xsl:if>
			
	  		<xsl:if test="bill_to_name and bill_to_name !=''">
			<BllTo>
				<Nm><xsl:value-of select="bill_to_name"/></Nm>
				<xsl:if test="seller_proprietary_id and seller_proprietary_id !=''">
					<PrtryId>
						<Id><xsl:value-of select="seller_proprietary_id"/></Id>
			    		<IdTp><xsl:value-of select="seller_proprietary_id_type"/></IdTp>
			    	</PrtryId>
			    </xsl:if>			
				<PstlAdr>
					<xsl:if test="bill_to_street_name and bill_to_street_name !=''">
						<StrtNm><xsl:value-of select="bill_to_street_name"/></StrtNm>
					</xsl:if>
					<xsl:if test="bill_to_post_code and bill_to_post_code !=''">
						<PstCdId><xsl:value-of select="bill_to_post_code"/></PstCdId>
					</xsl:if>
					<xsl:if test="bill_to_town_name and bill_to_town_name !=''">
						<TwnNm><xsl:value-of select="bill_to_town_name"/></TwnNm>
					</xsl:if>
					<xsl:if test="bill_to_country_sub_div and bill_to_country_sub_div !=''">
						<CtrySubDvsn><xsl:value-of select="bill_to_country_sub_div"/></CtrySubDvsn>
					</xsl:if>
					<Ctry><xsl:value-of select="bill_to_country"/></Ctry>
				</PstlAdr>
			</BllTo>
			</xsl:if>
			
			<xsl:if test="ship_to_name and ship_to_name !=''">
			<ShipTo>
				<Nm><xsl:value-of select="ship_to_name"/></Nm>
				<xsl:if test="seller_proprietary_id and seller_proprietary_id !=''">
					<PrtryId>
						<Id><xsl:value-of select="seller_proprietary_id"/></Id>
			    		<IdTp><xsl:value-of select="seller_proprietary_id_type"/></IdTp>
			    	</PrtryId>
			    </xsl:if>
				
				<PstlAdr>
					<xsl:if test="ship_to_street_name and ship_to_street_name !=''">
						<StrtNm><xsl:value-of select="ship_to_street_name"/></StrtNm>
					</xsl:if>
					<xsl:if test="ship_to_post_code and ship_to_post_code !=''">
						<PstCdId><xsl:value-of select="ship_to_post_code"/></PstCdId>
					</xsl:if>
					<xsl:if test="ship_to_town_name and ship_to_town_name !=''">
						<TwnNm><xsl:value-of select="ship_to_town_name"/></TwnNm>
					</xsl:if>
					<xsl:if test="ship_to_country_sub_div and ship_to_country_sub_div !=''">
						<CtrySubDvsn><xsl:value-of select="ship_to_country_sub_div"/></CtrySubDvsn>
					</xsl:if>
					<Ctry><xsl:value-of select="ship_to_country"/></Ctry>
				</PstlAdr>
			</ShipTo>
			</xsl:if>
			
			<xsl:if test="consgn_name and consgn_name !=''">
			<Consgn>
				<Nm><xsl:value-of select="consgn_name"/></Nm>
				<xsl:if test="seller_proprietary_id and seller_proprietary_id !=''">
					<PrtryId>
						<Id><xsl:value-of select="seller_proprietary_id"/></Id>
			    		<IdTp><xsl:value-of select="seller_proprietary_id_type"/></IdTp>
			    	</PrtryId>
			    </xsl:if>
			    
				<PstlAdr>
					<xsl:if test="consgn_street_name and consgn_street_name !=''">
						<StrtNm><xsl:value-of select="consgn_street_name"/></StrtNm>
					</xsl:if>
					<xsl:if test="consgn_post_code and consgn_post_code !=''">
						<PstCdId><xsl:value-of select="consgn_post_code"/></PstCdId>
					</xsl:if>
					<xsl:if test="consgn_town_name and consgn_town_name !=''">
						<TwnNm><xsl:value-of select="consgn_town_name"/></TwnNm>
					</xsl:if>
					<xsl:if test="consgn_country_sub_div and consgn_country_sub_div !=''">
						<CtrySubDvsn><xsl:value-of select="consgn_country_sub_div"/></CtrySubDvsn>
					</xsl:if>
					<Ctry><xsl:value-of select="consgn_country"/></Ctry>
				</PstlAdr>
			</Consgn>
			</xsl:if>
			
			<!-- Goods -->
			<Goods>
			    <xsl:if test="goods_desc and goods_desc !=''">
			    	<GoodsDesc>
			    		<xsl:value-of select="goods_desc"/>
			   		</GoodsDesc>
			   	</xsl:if>
				<PrtlShipmnt>
					<xsl:choose>
						<xsl:when test="part_ship[.='Y']">true</xsl:when>
						<xsl:otherwise>false</xsl:otherwise>
					</xsl:choose>
				</PrtlShipmnt>
				<xsl:if test="tran_ship and tran_ship !=''">
					<TrnsShipmnt>
						<xsl:choose>
							<xsl:when test="tran_ship[.='Y']">true</xsl:when>
							<xsl:otherwise>false</xsl:otherwise>
			   		 		</xsl:choose>
					</TrnsShipmnt>
				</xsl:if>
			
				<!-- Line Items -->
				<xsl:apply-templates select="line_items/lt_tnx_record"/>
			
				<LineItmsTtlAmt>
					<xsl:attribute name="Ccy"><xsl:value-of select="total_cur_code" /></xsl:attribute>
					<xsl:value-of select="total_amt" />
				</LineItmsTtlAmt>
			
			
				<xsl:if
					test="routing_summaries/rs_tnx_record or (routing_summaries/air_routing_summaries or routing_summaries/sea_routing_summaries or routing_summaries/road_routing_summaries or routing_summaries/rail_routing_summaries)">
					<RtgSummry>
						<IndvTrnsprt>
							<xsl:if test="routing_summaries/air_routing_summaries">
								<xsl:apply-templates
									select="routing_summaries/air_routing_summaries/rs_tnx_record" />
							</xsl:if>
							<xsl:if test="routing_summaries/sea_routing_summaries">
								<xsl:apply-templates
									select="routing_summaries/sea_routing_summaries/rs_tnx_record" />
							</xsl:if>
							<xsl:if test="routing_summaries/road_routing_summaries">
								<xsl:apply-templates
									select="routing_summaries/road_routing_summaries/rs_tnx_record" />
							</xsl:if>
							<xsl:if test="routing_summaries/rail_routing_summaries">
								<xsl:apply-templates
									select="routing_summaries/rail_routing_summaries/rs_tnx_record" />
							</xsl:if>
						</IndvTrnsprt>
						<xsl:apply-templates select="routing_summaries/rs_tnx_record"
							mode="multimodal" />
					</RtgSummry>
				</xsl:if> 
			
				<xsl:if test="incoterms/incoterm">
					<xsl:apply-templates select="incoterms/incoterm" />
				</xsl:if>
			
				<xsl:if test="adjustments/adjustment">
					<xsl:apply-templates select="adjustments/adjustment" />
				</xsl:if>
			
				<xsl:if test="freightCharges/freightCharge">
					<FrghtChrgs>
						<Tp>
							<xsl:value-of select="freight_charges_type" />
						</Tp>
						<xsl:apply-templates select="freightCharges/freightCharge" />
					</FrghtChrgs>
				</xsl:if>
			
				<xsl:if test="taxes/tax">
					<xsl:apply-templates select="taxes/tax" />
				</xsl:if>
			
				<TtlNetAmt>
					<xsl:attribute name="Ccy"><xsl:value-of select="total_net_cur_code" /></xsl:attribute>
					<xsl:value-of select="total_net_amt" />
				</TtlNetAmt>
				
				<xsl:if test="user_defined_informations">
					<xsl:apply-templates select="user_defined_informations/user_defined_information" />
				</xsl:if>
				
			</Goods>
			<PmtTerms>
				<xsl:apply-templates select="payments/payment"/>
			</PmtTerms>
		
			<xsl:if
				test="seller_account_iban[.!=''] or seller_account_bban[.!=''] or seller_account_upic[.!=''] or seller_account_id[.!='']">
			<SttlmTerms>
				<xsl:if
					test="(fin_inst_bic or fin_inst_name) and(fin_inst_bic !='' or fin_inst_name!='') ">
				<CdtrAgt>
					<xsl:choose>
						<xsl:when test="fin_inst_bic and fin_inst_bic!=''">
							<BIC>
								<xsl:value-of select="fin_inst_bic" />
							</BIC>
						</xsl:when>
						<xsl:when test="fin_inst_name and fin_inst_name!=''">
							<NmAndAdr>
								<Nm>
									<xsl:value-of select="fin_inst_name" />
								</Nm>
								<Adr>
									<xsl:if test="fin_inst_street_name">
										<StrtNm>
											<xsl:value-of select="fin_inst_street_name" />
										</StrtNm>
									</xsl:if>
									<PstCdId>
										<xsl:value-of select="fin_inst_post_code" />
									</PstCdId>
									<TwnNm>
										<xsl:value-of select="fin_inst_town_name" />
									</TwnNm>
									<xsl:if test="fin_inst_country_sub_div">
										<CtrySubDvsn>
											<xsl:value-of select="fin_inst_country_sub_div" />
										</CtrySubDvsn>
									</xsl:if>
									<Ctry>
										<xsl:value-of select="fin_inst_country" />
									</Ctry>
								</Adr>
							</NmAndAdr>
						</xsl:when>
					</xsl:choose>
				</CdtrAgt>
				</xsl:if>
				<CdtrAcct>
					<Id>
						<xsl:choose>
							<xsl:when test="seller_account_iban and seller_account_iban!=''">
								<IBAN>
									<xsl:value-of select="seller_account_iban" />
								</IBAN>
							</xsl:when>
							<xsl:when test="seller_account_bban and seller_account_bban!=''">
								<BBAN>
									<xsl:value-of select="seller_account_bban" />
								</BBAN>
							</xsl:when>
							<xsl:when test="seller_account_upic and seller_account_upic!=''">
								<UPIC>
									<xsl:value-of select="seller_account_upic" />
								</UPIC>
							</xsl:when>
							<xsl:when test="seller_account_id and seller_account_id!=''">
								<PrtryAcct>
									<Id>
										<xsl:value-of select="seller_account_id" />
									</Id>
								</PrtryAcct>
							</xsl:when>
						</xsl:choose>
					</Id>
					<xsl:if
						test="(seller_account_type_code or seller_account_type_prop) and (seller_account_type_code!='' or seller_account_type_prop!='') ">
						<Tp>
							<xsl:choose>
								<xsl:when
									test="seller_account_type_code and seller_account_type_code!=''">
									<Cd>
										<xsl:value-of select="seller_account_type_code" />
									</Cd>
								</xsl:when>
								<xsl:otherwise>
									<Prtry>
										<xsl:value-of select="seller_account_type_prop" />
									</Prtry>
								</xsl:otherwise>
							</xsl:choose>
						</Tp>
					</xsl:if>
	
					<xsl:if test="seller_account_cur_code and seller_account_cur_code!=''">
						<Ccy>
							<xsl:value-of select="seller_account_cur_code" />
						</Ccy>
					</xsl:if>
	
					<xsl:if test="seller_account_name  and seller_account_name!=''">
						<Nm>
							<xsl:value-of select="seller_account_name" />
						</Nm>
					</xsl:if>
				</CdtrAcct>
			</SttlmTerms>
			</xsl:if>
					
			<xsl:if test="bank_payment_obligation/PmtOblgtn">
				<xsl:apply-templates select="bank_payment_obligation/PmtOblgtn"/>
			</xsl:if>
	
			<xsl:if test="last_match_date and last_match_date !=''">
				<LatstMtchDt>
					<xsl:value-of select="tools:getCurrentTMAFormatDate(last_match_date,'simpleDate')"/>  
				</LatstMtchDt>
			</xsl:if>
	
			<xsl:if test="commercial_dataset/ComrclDataSetReqrd">
				<xsl:copy-of select="commercial_dataset/ComrclDataSetReqrd" />
			</xsl:if>
		
			<xsl:if test="transport_dataset/TrnsprtDataSetReqrd">
				<xsl:copy-of select="transport_dataset/TrnsprtDataSetReqrd" />
			</xsl:if>
			
			<xsl:if test="insurance_dataset/InsrncDataSetReqrd">
				<InsrncDataSetReqrd>
					<xsl:copy-of select="insurance_dataset/InsrncDataSetReqrd/Submitr"/>
					<xsl:if test="insurance_dataset/InsrncDataSetReqrd/MtchIssr">
						<xsl:copy-of select="insurance_dataset/InsrncDataSetReqrd/MtchIssr"/>
					</xsl:if>
					<xsl:if test="insurance_dataset/InsrncDataSetReqrd/MtchIsseDt">
						<xsl:copy-of select="insurance_dataset/InsrncDataSetReqrd/MtchIsseDt"/>
					</xsl:if>
					<xsl:if test="insurance_dataset/InsrncDataSetReqrd/MtchTrnsprt">
						<xsl:copy-of select="insurance_dataset/InsrncDataSetReqrd/MtchTrnsprt"/>
					</xsl:if>
					<xsl:if test="insurance_dataset/InsrncDataSetReqrd/MtchAmt">
						<xsl:copy-of select="insurance_dataset/InsrncDataSetReqrd/MtchAmt"/>
					</xsl:if>
					<xsl:if test="insurance_dataset/InsrncDataSetReqrd/ClausesReqrd">
						<xsl:copy-of select="insurance_dataset/InsrncDataSetReqrd/ClausesReqrd"/>
					</xsl:if>
					<xsl:if test="insurance_dataset/InsrncDataSetReqrd/MtchAssrdPty">
						<xsl:copy-of select="insurance_dataset/InsrncDataSetReqrd/MtchAssrdPty"/>
					</xsl:if>
				</InsrncDataSetReqrd>
			</xsl:if>
			
			<xsl:if test="certificate_dataset/CertDataSetReqrd">
				<CertDataSetReqrd>
					<xsl:copy-of select="certificate_dataset/CertDataSetReqrd/Submitr"/>
					<xsl:copy-of select="certificate_dataset/CertDataSetReqrd/CertTp"/>
					<xsl:if test="certificate_dataset/CertDataSetReqrd/MtchIssr">
						<xsl:copy-of select="certificate_dataset/CertDataSetReqrd/MtchIssr"/>
					</xsl:if>
					<xsl:if test="certificate_dataset/CertDataSetReqrd/MtchIsseDt">
						<xsl:copy-of select="certificate_dataset/CertDataSetReqrd/MtchIsseDt"/>
					</xsl:if>
					<xsl:if test="certificate_dataset/CertDataSetReqrd/MtchInspctnDt">
						<xsl:copy-of select="certificate_dataset/CertDataSetReqrd/MtchInspctnDt"/>
					</xsl:if>
					<xsl:if test="certificate_dataset/CertDataSetReqrd/AuthrsdInspctrInd">
						<xsl:copy-of select="certificate_dataset/CertDataSetReqrd/AuthrsdInspctrInd"/>
					</xsl:if>
					<xsl:if test="certificate_dataset/CertDataSetReqrd/MtchConsgn">
						<xsl:copy-of select="certificate_dataset/CertDataSetReqrd/MtchConsgn"/>
					</xsl:if>
					<xsl:if test="certificate_dataset/CertDataSetReqrd/MtchManfctr">
						<xsl:copy-of select="certificate_dataset/CertDataSetReqrd/MtchManfctr"/>
					</xsl:if>
					<xsl:if test="certificate_dataset/CertDataSetReqrd/LineItmId">
						<xsl:copy-of select="certificate_dataset/CertDataSetReqrd/LineItmId"/>
					</xsl:if>
				</CertDataSetReqrd>
			</xsl:if>
			
			<xsl:if test="other_certificate_dataset/OthrCertDataSetReqrd">
				<OthrCertDataSetReqrd>
					<xsl:copy-of select="other_certificate_dataset/OthrCertDataSetReqrd/Submitr" />
					<xsl:copy-of select="other_certificate_dataset/OthrCertDataSetReqrd/CertTp" />
				</OthrCertDataSetReqrd>
			</xsl:if>
	
			<InttToPayXpctd>
				<xsl:choose>
					<xsl:when test="intent_to_pay_flag[.='Y']">true</xsl:when>
					<xsl:otherwise>false</xsl:otherwise>
				</xsl:choose>
			</InttToPayXpctd>
		</Baseln>

		<xsl:if test="contacts/contact">
			<xsl:apply-templates select="contacts/contact"/>
		</xsl:if>
			
	 </BaselnReSubmissn>
</Document>
  
</xsl:template>

<!-- Line Items -->
<xsl:template match="line_items/lt_tnx_record">
	<LineItmDtls>
		<LineItmId><xsl:value-of select="line_item_number"/></LineItmId>
		<Qty>
			<xsl:choose>
			 <xsl:when test="qty_unit_measr_code !=''">
					<UnitOfMeasrCd>
						<xsl:value-of select="qty_unit_measr_code"/>
					</UnitOfMeasrCd>
			 </xsl:when>
			 <xsl:otherwise>
					<OthrUnitOfMeasr>
						<xsl:value-of select="qty_other_unit_measr"/>
					</OthrUnitOfMeasr>
			 </xsl:otherwise>
			</xsl:choose>
			<Val>
				<xsl:value-of select="qty_val"/>
			</Val>
			<xsl:if test="qty_factor and qty_factor !=''">
				<Fctr>
					<xsl:value-of select="qty_factor"/>
				</Fctr>
			</xsl:if>
		</Qty>
		<xsl:if test="qty_tol_pstv_pct and qty_tol_pstv_pct !=''">
			<QtyTlrnce>
				<PlusPct>
					<xsl:value-of select="qty_tol_pstv_pct" />
				</PlusPct>
				<MnsPct>
					<xsl:value-of select="qty_tol_neg_pct" />
				</MnsPct>
			</QtyTlrnce>
		</xsl:if>
		<xsl:if test="price_amt and price_amt !=''">
			<UnitPric>
					<xsl:choose>
						<xsl:when test="price_unit_measr_code !=''">
							<UnitOfMeasrCd>
								<xsl:value-of select="price_unit_measr_code"/>
							</UnitOfMeasrCd>
						</xsl:when>
						<xsl:otherwise>
							<OthrUnitOfMeasr>
								<xsl:value-of select="price_other_unit_measr"/>
							</OthrUnitOfMeasr>
						</xsl:otherwise>
					</xsl:choose>
				<Amt>
					 <xsl:attribute name="Ccy">
				       	<xsl:value-of select="price_cur_code" />
				     </xsl:attribute>
					 <xsl:value-of select="price_amt"/>
				</Amt>
				<xsl:if test="price_factor and price_factor !=''">
					<Fctr>
						<xsl:value-of select="price_factor"/>
					</Fctr>
				</xsl:if>
			</UnitPric>
		</xsl:if>
		<xsl:if test="price_tol_pstv_pct and price_tol_pstv_pct !=''">
			<PricTlrnce>
				<PlusPct>
					<xsl:value-of select="price_tol_pstv_pct"/>
				</PlusPct>
				<MnsPct>
					<xsl:value-of select="price_tol_neg_pct"/>
				</MnsPct>
			</PricTlrnce>
		</xsl:if>
		<xsl:if test="product_name and product_name !=''">
			<PdctNm>
				<xsl:value-of select="product_name"/>
			</PdctNm>
		</xsl:if>
		
		<xsl:if test="product_identifiers/product_identifier">
			<xsl:apply-templates select="product_identifiers/product_identifier"/>
		</xsl:if>
		
		<xsl:if test="product_characteristics/product_characteristic">
			<xsl:apply-templates select="product_characteristics/product_characteristic"/>
		</xsl:if>
		
		<xsl:if test="product_categories/product_category">
			<xsl:apply-templates select="product_categories/product_category"/>
		</xsl:if>
		
		<xsl:if test="product_orgn and product_orgn !=''">
			<xsl:apply-templates select="product_orgn"/>
		</xsl:if>
			
		<xsl:if test="(earliest_ship_date !='' or last_ship_date !='') or (shipment_schedules/shipment_schedule)">
			<ShipmntSchdl>
				<xsl:choose>
					<xsl:when test="earliest_ship_date !='' or last_ship_date !=''">
						<ShipmntDtRg>
							<xsl:if test="earliest_ship_date !=''">
								<EarlstShipmntDt>
									<xsl:value-of select="tools:getCurrentTMAFormatDate(earliest_ship_date,'simpleDate')"/>
								</EarlstShipmntDt>
							</xsl:if>
							<xsl:if test="last_ship_date !=''">	
								<LatstShipmntDt>
									<xsl:value-of select="tools:getCurrentTMAFormatDate(last_ship_date,'simpleDate')"/>
								</LatstShipmntDt>
							</xsl:if>
						</ShipmntDtRg>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="shipment_schedules/shipment_schedule" />
					</xsl:otherwise>
				</xsl:choose>
			</ShipmntSchdl>
		</xsl:if>

		<xsl:if	test="routing_summaries/rs_tnx_record or (routing_summaries/air_routing_summaries or routing_summaries/sea_routing_summaries or routing_summaries/road_routing_summaries or routing_summaries/rail_routing_summaries)">
			<RtgSummry>
				<IndvTrnsprt>
					<xsl:if test="routing_summaries/air_routing_summaries">
						<xsl:apply-templates select="routing_summaries/air_routing_summaries/rs_tnx_record" />
					</xsl:if>
					<xsl:if test="routing_summaries/sea_routing_summaries">
						<xsl:apply-templates select="routing_summaries/sea_routing_summaries/rs_tnx_record" />
					</xsl:if>
					<xsl:if test="routing_summaries/road_routing_summaries">
						<xsl:apply-templates select="routing_summaries/road_routing_summaries/rs_tnx_record" />
					</xsl:if>
					<xsl:if test="routing_summaries/rail_routing_summaries">
						<xsl:apply-templates select="routing_summaries/rail_routing_summaries/rs_tnx_record" />
					</xsl:if>
				</IndvTrnsprt>
				<xsl:apply-templates select="routing_summaries/rs_tnx_record"
					mode="multimodal" />
			</RtgSummry>
		</xsl:if> 

		<xsl:if test="incoterms/incoterm">
			<xsl:apply-templates select="incoterms/incoterm"/>
		</xsl:if>
		
		<xsl:if test="adjustments/allowance">
			<xsl:apply-templates select="adjustments/allowance" mode="adjustment" />
		</xsl:if>
		
		<xsl:if test="freight_charges/allowance">
			<FrghtChrgs>
			<Tp><xsl:value-of select="freight_charges_type"/></Tp>
			<xsl:apply-templates select="freight_charges/allowance" mode="freight_charge"/>
			</FrghtChrgs>
		</xsl:if>
		
		<xsl:if test="taxes/allowance">
			<xsl:apply-templates select="taxes/allowance" mode="tax"/>
		</xsl:if>

		<TtlAmt>
			<xsl:attribute name="Ccy"><xsl:value-of select="total_cur_code" /></xsl:attribute>
			<xsl:value-of select="total_amt" />
		</TtlAmt>
		
	</LineItmDtls>
</xsl:template>
	
<xsl:template match="rs_tnx_record" mode="multimodal">
	<xsl:if test="routing_summary_type='02'">
	    <MltmdlTrnsprt>
	       <TakngInChrg>
	     	  <xsl:value-of select="taking_in_charge"/>
	       </TakngInChrg>
	       
	       <PlcOfFnlDstn>
	       	 <xsl:value-of select="place_of_final_destination"/>
	       </PlcOfFnlDstn>
	    </MltmdlTrnsprt>
	</xsl:if>
</xsl:template>

<!-- Transport By Air -->
<xsl:template match="routing_summaries/air_routing_summaries/rs_tnx_record">
	<TrnsprtByAir>
		<xsl:apply-templates select="departures/departure" />
		<xsl:apply-templates select="destinations/destination" />
		<xsl:if test="air_carrier_name and air_carrier_name!=''">
			<AirCrrierNm>
				<xsl:value-of select="air_carrier_name"/>
			</AirCrrierNm>
		</xsl:if>
	</TrnsprtByAir>
</xsl:template>

<!-- Transport By Sea -->
<xsl:template match="routing_summaries/sea_routing_summaries/rs_tnx_record">
	<TrnsprtBySea>
		<xsl:apply-templates select="loading_ports/loading_port" />
		<xsl:apply-templates select="discharge_ports/discharge_port" />
		<xsl:if test="sea_carrier_name and sea_carrier_name!=''">
			<SeaCrrierNm>
				<xsl:value-of select="sea_carrier_name"/>
			</SeaCrrierNm>
		</xsl:if>
	</TrnsprtBySea>
</xsl:template>

<!-- Transport By Road -->
<xsl:template match="routing_summaries/road_routing_summaries/rs_tnx_record">
	<TrnsprtByRoad>
		<xsl:apply-templates select="road_receipt_places/road_receipt_place" />
		<xsl:apply-templates select="road_delivery_places/road_delivery_place" />
		<xsl:if test="road_carrier_name and road_carrier_name!=''">
			<RoadCrrierNm>
				<xsl:value-of select="road_carrier_name"/>
			</RoadCrrierNm>
		</xsl:if>
	</TrnsprtByRoad>
</xsl:template>

<!-- Transport By Rail -->
<xsl:template match="routing_summaries/rail_routing_summaries/rs_tnx_record">
	<TrnsprtByRail>
		<xsl:apply-templates select="rail_receipt_places/rail_receipt_place" />
		<xsl:apply-templates select="rail_delivery_places/rail_delivery_place" />
		<xsl:if test="rail_carrier_name and rail_carrier_name!=''">
			<RailCrrierNm>
				<xsl:value-of select="rail_carrier_name" />
			</RailCrrierNm>
		</xsl:if>
	</TrnsprtByRail>
</xsl:template>

<xsl:template match="departures/departure">
	<xsl:if test="departure_airport_code or departure_air_town">
		<DprtureAirprt>
			<xsl:choose>
				<xsl:when test="departure_airport_code and departure_airport_code!=''">
					<AirprtCd><xsl:value-of select="departure_airport_code"/>
					</AirprtCd>
				</xsl:when>
				<xsl:otherwise>
					<OthrAirprtDesc>
						<Twn><xsl:value-of select="departure_air_town"/></Twn>
						<xsl:if test="departure_airport_name and departure_airport_name!=''">
							<AirprtNm>
								<xsl:value-of select="departure_airport_name"/>
							</AirprtNm>
						</xsl:if>
					</OthrAirprtDesc>
				</xsl:otherwise>	
			</xsl:choose>
		</DprtureAirprt>
	</xsl:if>	
</xsl:template>

<xsl:template match="destinations/destination">
	<DstnAirprt>
		<xsl:choose>
			<xsl:when test="destination_airport_code and destination_airport_code!=''">
				<AirprtCd>
					<xsl:value-of select="destination_airport_code"/>
				</AirprtCd>
			</xsl:when>
			<xsl:otherwise>
				<OthrAirprtDesc>
					<Twn><xsl:value-of select="destination_air_town"/></Twn>
					<xsl:if test="destination_airport_name and destination_airport_name!=''">
						 <AirprtNm>
							<xsl:value-of select="destination_airport_name"/>
						</AirprtNm>
					</xsl:if>
				</OthrAirprtDesc>
			</xsl:otherwise>
		</xsl:choose>
	</DstnAirprt>
</xsl:template>

<xsl:template match="loading_ports/loading_port">
	<xsl:if
		test="loading_port_name and loading_port_name!=''">
		<PortOfLoadng>
			<xsl:value-of select="loading_port_name" />
		</PortOfLoadng>
	</xsl:if>
</xsl:template>

<xsl:template match="discharge_ports/discharge_port">
	<PortOfDschrge>
		<xsl:value-of select="discharge_port_name"/>
	</PortOfDschrge>
</xsl:template>

<xsl:template match="rail_receipt_places/rail_receipt_place">
	<xsl:if	test="rail_receipt_place_name and rail_receipt_place_name!=''">
	<PlcOfRct>
		<xsl:value-of select="rail_receipt_place_name" />
	</PlcOfRct>
	</xsl:if>
</xsl:template>

<xsl:template match="rail_delivery_places/rail_delivery_place">
	<PlcOfDlvry>
		<xsl:value-of select="rail_delivery_place_name"/>
	</PlcOfDlvry>
</xsl:template>

<xsl:template match="road_receipt_places/road_receipt_place">
	<xsl:if	test="road_receipt_place_name and road_receipt_place_name!=''">
	<PlcOfRct>
		<xsl:value-of select="road_receipt_place_name" />
	</PlcOfRct>
	</xsl:if>
</xsl:template>

<xsl:template match="road_delivery_places/road_delivery_place">
	<PlcOfDlvry>
		<xsl:value-of select="road_delivery_place_name"/>
	</PlcOfDlvry>
</xsl:template>

<!-- Bank Payment Obligation -->
<xsl:template match="bank_payment_obligation/PmtOblgtn">
	<PmtOblgtn>
		<OblgrBk>
			<BIC>
				<xsl:value-of select="OblgrBk/BIC" />
			</BIC>
		</OblgrBk>
		<RcptBk>
			<BIC>
				<xsl:value-of select="RcptBk/BIC" />
			</BIC>
		</RcptBk>
		<xsl:choose>
			<xsl:when test="Amt and Amt!=''">
				<xsl:copy-of select="Amt" />
			</xsl:when>
			<xsl:otherwise>
				<Pctg>
					<xsl:value-of select="Pctg" />
				</Pctg>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="ChrgsAmt and ChrgsAmt !=''">
			<xsl:copy-of select="ChrgsAmt" />
		</xsl:if>
		<xsl:if test="ChrgsPctg and ChrgsPctg !=''">
			<ChrgsPctg>
				<xsl:value-of select="ChrgsPctg" />
			</ChrgsPctg>
		</xsl:if>
		<XpryDt>
			<xsl:value-of select="XpryDt" />
		</XpryDt>
		<xsl:if test="AplblLaw and AplblLaw !=''">
			<AplblLaw>
				<xsl:value-of select="AplblLaw" />
			</AplblLaw>
		</xsl:if>
		<xsl:if test="PmtTerms">
			<PmtTerms>
				<xsl:choose>
					<xsl:when test="PmtTerms/OthrPmtTerms != ''">
						<OthrPmtTerms>
							<xsl:value-of select="PmtTerms/OthrPmtTerms" />
						</OthrPmtTerms>
					</xsl:when>
					<xsl:otherwise>
						<PmtCd>
							<Cd>
								<xsl:value-of select="PmtTerms/PmtCd/Cd" />
							</Cd>
							<xsl:if test="PmtTerms/PmtCd/NbOfDays != ''">
								<NbOfDays>
									<xsl:value-of select="PmtTerms/PmtCd/NbOfDays" />
								</NbOfDays>
							</xsl:if>
						</PmtCd>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="PmtTerms/Pctg != ''">
						<Pctg>
							<xsl:value-of select="PmtTerms/Pctg" />
						</Pctg>
					</xsl:when>
					<xsl:otherwise>
						<Amt>
							<xsl:attribute name="Ccy"><xsl:value-of
								select="Amt/@Ccy" /></xsl:attribute>
							<xsl:value-of select="PmtTerms/Amt" />
						</Amt>
					</xsl:otherwise>
				</xsl:choose>
	
			</PmtTerms>
		</xsl:if>
	
		<xsl:if
			test="SttlmTerms/CdtrAcct/Id/IBAN[.!=''] or SttlmTerms/CdtrAcct/Id/BBAN[.!=''] or SttlmTerms/CdtrAcct/Id/UPIC[.!=''] or SttlmTerms/CdtrAcct/Id/PrtryAcct[.!='']">
			<SttlmTerms>
				<xsl:if
					test="SttlmTerms/CdtrAgt/BIC[.!=''] or SttlmTerms/CdtrAgt/NmAndAdr/Nm[.!='']">
					<CdtrAgt>
						<xsl:choose>
							<xsl:when test="SttlmTerms/CdtrAgt/BIC[.!='']">
								<BIC>
									<xsl:value-of select="SttlmTerms/CdtrAgt/BIC" />
								</BIC>
							</xsl:when>
							<xsl:when test="SttlmTerms/CdtrAgt/NmAndAdr/Nm[.!='']">
								<NmAndAdr>
									<Nm>
										<xsl:value-of select="SttlmTerms/CdtrAgt/NmAndAdr/Nm" />
									</Nm>
									<Adr>
										<xsl:if test="SttlmTerms/CdtrAgt/NmAndAdr/Adr/StrtNm != ''">
											<StrtNm>
												<xsl:value-of select="SttlmTerms/CdtrAgt/NmAndAdr/Adr/StrtNm" />
											</StrtNm>
										</xsl:if>
										<PstCdId>
											<xsl:value-of select="SttlmTerms/CdtrAgt/NmAndAdr/Adr/PstCdId" />
										</PstCdId>
										<TwnNm>
											<xsl:value-of select="SttlmTerms/CdtrAgt/NmAndAdr/Adr/TwnNm" />
										</TwnNm>
										<xsl:if test="SttlmTerms/CdtrAgt/NmAndAdr/Adr/CtrySubDvsn != ''">
											<CtrySubDvsn>
												<xsl:value-of select="SttlmTerms/CdtrAgt/NmAndAdr/Adr/CtrySubDvsn" />
											</CtrySubDvsn>
										</xsl:if>
										<Ctry>
											<xsl:value-of select="SttlmTerms/CdtrAgt/NmAndAdr/Adr/Ctry" />
										</Ctry>
									</Adr>
								</NmAndAdr>
							</xsl:when>
						</xsl:choose>
					</CdtrAgt>
				</xsl:if>
				<CdtrAcct>
					<Id>
						<xsl:choose>
							<xsl:when test="SttlmTerms/CdtrAcct/Id/IBAN != ''">
								<IBAN>
									<xsl:value-of select="SttlmTerms/CdtrAcct/Id/IBAN" />
								</IBAN>
							</xsl:when>
							<xsl:when test="SttlmTerms/CdtrAcct/Id/BBAN != ''">
								<BBAN>
									<xsl:value-of select="SttlmTerms/CdtrAcct/Id/BBAN" />
								</BBAN>
							</xsl:when>
							<xsl:when test="SttlmTerms/CdtrAcct/Id/UPIC != ''">
								<UPIC>
									<xsl:value-of select="SttlmTerms/CdtrAcct/Id/UPIC" />
								</UPIC>
							</xsl:when>
							<xsl:when test="SttlmTerms/CdtrAcct/Id/PrtryAcct != ''">
								<PrtryAcct>
									<Id>
										<xsl:value-of select="SttlmTerms/CdtrAcct/Id/PrtryAcct" />
									</Id>
								</PrtryAcct>
							</xsl:when>
						</xsl:choose>
					</Id>
					<xsl:if
						test="SttlmTerms/CdtrAcct/Tp/Cd[.!=''] or SttlmTerms/CdtrAcct/Tp/Prtry[.!='']">
						<Tp>
							<xsl:choose>
								<xsl:when test="SttlmTerms/CdtrAcct/Tp/Cd[.!='']">
									<Cd>
										<xsl:value-of select="SttlmTerms/CdtrAcct/Tp/Cd" />
									</Cd>
								</xsl:when>
								<xsl:otherwise>
									<Prtry>
										<xsl:value-of select="SttlmTerms/CdtrAcct/Tp/Prtry" />
									</Prtry>
								</xsl:otherwise>
							</xsl:choose>
						</Tp>
					</xsl:if>
	
					<xsl:if test="SttlmTerms/CdtrAcct/Ccy != ''">
						<Ccy>
							<xsl:value-of select="SttlmTerms/CdtrAcct/Ccy" />
						</Ccy>
					</xsl:if>
	
					<xsl:if test="SttlmTerms/CdtrAcct/Nm != ''">
						<Nm>
							<xsl:value-of select="SttlmTerms/CdtrAcct/Nm" />
						</Nm>
					</xsl:if>
				</CdtrAcct>
			</SttlmTerms>
		</xsl:if>

	</PmtOblgtn>
</xsl:template>

<!-- Contact Details -->
<xsl:template match="contacts/contact">
	<xsl:if test="type[.='01']">
		<BuyrCtctPrsn>
			<Nm><xsl:value-of select="name"/></Nm>
			<NmPrfx><xsl:value-of select="name_prefix"/></NmPrfx>
			<GvnNm><xsl:value-of select="given_name"/></GvnNm>
			<Role><xsl:value-of select="role"/></Role>
			<PhneNb><xsl:value-of select="phone_number"/></PhneNb>
			<FaxNb><xsl:value-of select="fax_number"/></FaxNb>
			<EmailAdr><xsl:value-of select="email"/></EmailAdr>
		</BuyrCtctPrsn>		
	</xsl:if>
	<xsl:if test="type[.='02']">
		<SellrCtctPrsn>
			<Nm><xsl:value-of select="name"/></Nm>
			<NmPrfx><xsl:value-of select="name_prefix"/></NmPrfx>
			<GvnNm><xsl:value-of select="given_name"/></GvnNm>
			<Role><xsl:value-of select="role"/></Role>
			<PhneNb><xsl:value-of select="phone_number"/></PhneNb>
			<FaxNb><xsl:value-of select="fax_number"/></FaxNb>
			<EmailAdr><xsl:value-of select="email"/></EmailAdr>
		</SellrCtctPrsn>
	</xsl:if>
	<xsl:choose>
		<xsl:when test="type[.='03']">
			<SellrBkCtctPrsn>
				<Nm><xsl:value-of select="name"/></Nm>
				<NmPrfx><xsl:value-of select="name_prefix"/></NmPrfx>
				<GvnNm><xsl:value-of select="given_name"/></GvnNm>
				<Role><xsl:value-of select="role"/></Role>
				<PhneNb><xsl:value-of select="phone_number"/></PhneNb>
				<FaxNb><xsl:value-of select="fax_number"/></FaxNb>
				<EmailAdr><xsl:value-of select="email"/></EmailAdr>
			</SellrBkCtctPrsn>
		</xsl:when>
		<xsl:when test="type[.='04']">
			<BuyrBkCtctPrsn>
				<Nm><xsl:value-of select="name"/></Nm>
				<NmPrfx><xsl:value-of select="name_prefix"/></NmPrfx>
				<GvnNm><xsl:value-of select="given_name"/></GvnNm>
				<Role><xsl:value-of select="role"/></Role>
				<PhneNb><xsl:value-of select="phone_number"/></PhneNb>
				<FaxNb><xsl:value-of select="fax_number"/></FaxNb>
				<EmailAdr><xsl:value-of select="email"/></EmailAdr>
			</BuyrBkCtctPrsn>
		</xsl:when>
		<xsl:otherwise/>
	</xsl:choose>
	<xsl:if test="type[.='08']">
		<OthrBkCtctPrsn>
			<BIC><xsl:value-of select="bic"/></BIC>
			<Nm><xsl:value-of select="name"/></Nm>
			<NmPrfx><xsl:value-of select="name_prefix"/></NmPrfx>
			<GvnNm><xsl:value-of select="given_name"/></GvnNm>
			<Role><xsl:value-of select="role"/></Role>
			<PhneNb><xsl:value-of select="phone_number"/></PhneNb>
			<FaxNb><xsl:value-of select="fax_number"/></FaxNb>
			<EmailAdr><xsl:value-of select="email"/></EmailAdr>
		</OthrBkCtctPrsn>		
	</xsl:if>
</xsl:template>

<!-- Incoterm Details -->
<xsl:template match="incoterms/incoterm">
  <Incotrms>
	    <xsl:choose>
	      <xsl:when test="code != 'OTHR'">
	        <Cd><xsl:value-of select="code"/></Cd>
	      </xsl:when>
	      <xsl:otherwise>
	        <Othr><xsl:value-of select="other"/></Othr>
	      </xsl:otherwise>
	    </xsl:choose>
    	<xsl:if test="location and location !=''">
    		<Lctn>
    			<xsl:value-of select="location"/>
    		</Lctn>
 		</xsl:if>
  </Incotrms>
</xsl:template>

<!-- Adjustment on Goods in case of Price variance -->
<xsl:template match="adjustments/adjustment">
  <Adjstmnt>
	    <xsl:choose>
	      <xsl:when test="type != 'OTHR'">
	        <Tp><xsl:value-of select="type"/></Tp>
	      </xsl:when>
	      <xsl:otherwise>
	        <OthrAdjstmntTp><xsl:value-of select="other_type"/></OthrAdjstmntTp>
	      </xsl:otherwise>
	    </xsl:choose>
	    <xsl:choose>
	      <xsl:when test="amt !=''">
	        <Amt>
	          <xsl:attribute name="Ccy"><xsl:value-of select="cur_code"/></xsl:attribute>
	          <xsl:value-of select="amt"/>
	        </Amt>
	      </xsl:when>
	      <xsl:otherwise>
	        <Pctg><xsl:value-of select="rate"/></Pctg>
	      </xsl:otherwise>
	    </xsl:choose>
 	   <Drctn><xsl:value-of select="direction"/></Drctn>
  </Adjstmnt>
</xsl:template>

<!-- FreightCharges: Service associated charges -->
<xsl:template match="freightCharges/freightCharge">
  <Chrgs>
	    <xsl:choose>
	      <xsl:when test="type != 'OTHR'">
	        <Tp><xsl:value-of select="type"/></Tp>
	      </xsl:when>
	      <xsl:otherwise>
	        <OthrChrgsTp><xsl:value-of select="other_type"/></OthrChrgsTp>
	      </xsl:otherwise>
	    </xsl:choose>
	    <xsl:choose>
	      <xsl:when test="amt !=''">
	        <Amt>
	          <xsl:attribute name="Ccy"><xsl:value-of select="cur_code"/></xsl:attribute>
	          <xsl:value-of select="amt"/>
	        </Amt>
	      </xsl:when>
	      <xsl:otherwise>
	        <Pctg><xsl:value-of select="rate"/></Pctg>
	      </xsl:otherwise>
	    </xsl:choose>
  </Chrgs>
</xsl:template>

<!-- Tax: Money due to the Government -->
<xsl:template match="taxes/tax">
  <Tax>
	    <xsl:choose>
	      <xsl:when test="type != 'OTHR'">
	        <Tp><xsl:value-of select="type"/></Tp>
	      </xsl:when>
	      <xsl:otherwise>
	        <OthrTaxTp><xsl:value-of select="other_type"/></OthrTaxTp>
	      </xsl:otherwise>
	    </xsl:choose>
	    <xsl:choose>
	      <xsl:when test="amt !=''">
	        <Amt>
	          <xsl:attribute name="Ccy"><xsl:value-of select="cur_code"/></xsl:attribute>
	          <xsl:value-of select="amt"/>
	        </Amt>
	      </xsl:when>
	      <xsl:otherwise>
	        <Pctg><xsl:value-of select="rate"/></Pctg>
	      </xsl:otherwise>
	    </xsl:choose>
  </Tax>
</xsl:template>

<xsl:template match="user_defined_informations/user_defined_information">
	<xsl:if test="type ='02'">
	  <BuyrDfndInf>
	    <Labl><xsl:value-of select="label"/></Labl>
	    <Inf><xsl:value-of select="information"/></Inf>
	  </BuyrDfndInf>
  	</xsl:if>
  	<xsl:if test="type ='01'">
	  <SellrDfndInf>
	    <Labl><xsl:value-of select="label"/></Labl>
	    <Inf><xsl:value-of select="information"/></Inf>
	  </SellrDfndInf>
  	</xsl:if>
</xsl:template>

<!-- Payment Items -->
<xsl:template match="payments/payment">
	<xsl:choose>
		<xsl:when test="other_paymt_terms and other_paymt_terms!=''">
			<OthrPmtTerms>
				<xsl:value-of select="other_paymt_terms" />
			</OthrPmtTerms>
		</xsl:when>
		<xsl:otherwise>
			<PmtCd>
				<Cd>
					<xsl:value-of select="code" />
				</Cd>
				<xsl:if test="nb_days and nb_days!=''">
					<NbOfDays>
						<xsl:value-of select="nb_days" />
					</NbOfDays>
				</xsl:if>
			</PmtCd>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:choose>
		<xsl:when test="pct and pct!=''">
			<Pctg>
				<xsl:value-of select="pct" />
			</Pctg>
		</xsl:when>
		<xsl:otherwise>
			<Amt>
				<xsl:attribute name="Ccy"><xsl:value-of select="cur_code" /></xsl:attribute>
				<xsl:value-of select="amt" />
			</Amt>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="product_identifiers/product_identifier">
  <PdctIdr>
    <xsl:choose>
      <xsl:when test="type != 'OTHR'">
      	<StrdPdctIdr>
        	<Tp><xsl:value-of select="type"/></Tp>
        	<Idr><xsl:value-of select="identifier"/></Idr>
        </StrdPdctIdr>
      </xsl:when>
      <xsl:otherwise>
      	<OthrPdctIdr>
	        <Id><xsl:value-of select="other_type"/></Id>
	        <IdTp><xsl:value-of select="identifier"/></IdTp>
        </OthrPdctIdr>
      </xsl:otherwise>
    </xsl:choose>
  </PdctIdr>
</xsl:template>
	
<xsl:template match="product_characteristics/product_characteristic">
  <PdctChrtcs>
    <xsl:choose>
      <xsl:when test="type != 'OTHR'">
      	<StrdPdctChrtcs>
	        <Tp><xsl:value-of select="type"/></Tp>
	        <Chrtcs><xsl:value-of select="characteristic"/></Chrtcs>
        </StrdPdctChrtcs>
      </xsl:when>
      <xsl:otherwise>
      	<OthrPdctChrtcs>
	        <Id><xsl:value-of select="other_type"/></Id>
	        <IdTp><xsl:value-of select="characteristic"/></IdTp>
        </OthrPdctChrtcs>
      </xsl:otherwise>
    </xsl:choose>
  </PdctChrtcs>
</xsl:template>
	
<xsl:template match="product_categories/product_category">
  <PdctCtgy>
    <xsl:choose>
      <xsl:when test="type != 'OTHR'">
      	<StrdPdctCtgy>
	        <Tp><xsl:value-of select="type"/></Tp>
	        <Ctgy><xsl:value-of select="category"/></Ctgy>
        </StrdPdctCtgy>
      </xsl:when>
      <xsl:otherwise>
      	<OthrPdctCtgy>
	        <Id><xsl:value-of select="other_type"/></Id>
	        <IdTp><xsl:value-of select="category"/></IdTp>
        </OthrPdctCtgy>
      </xsl:otherwise>
    </xsl:choose>
  </PdctCtgy>
</xsl:template>


<xsl:template match="product_orgn">
	<PdctOrgn>
		<xsl:value-of select="." />
	</PdctOrgn>
</xsl:template>

<xsl:template match="shipment_schedules/shipment_schedule">
	<ShipmntSubSchdl>
		<SubQtyVal><xsl:value-of select="sub_shipment_quantity_value" /></SubQtyVal>
		<xsl:if test="schedule_earliest_ship_date and schedule_earliest_ship_date != ''">
			<EarlstShipmntDt><xsl:value-of select="tools:getCurrentTMAFormatDate(schedule_earliest_ship_date,'simpleDate')"/></EarlstShipmntDt>
		</xsl:if>
		<xsl:if test="schedule_latest_ship_date and schedule_latest_ship_date != ''">
			<LatstShipmntDt><xsl:value-of select="tools:getCurrentTMAFormatDate(schedule_latest_ship_date, 'simpleDate')"/></LatstShipmntDt>
		</xsl:if>
	</ShipmntSubSchdl>
</xsl:template>

<!-- LineItems: Adjustment on Goods in case of Price variance -->
<xsl:template match="adjustments/allowance" mode="adjustment">
  <Adjstmnt>
	    <xsl:choose>
	      <xsl:when test="type != 'OTHR'">
	        <Tp><xsl:value-of select="type"/></Tp>
	      </xsl:when>
	      <xsl:otherwise>
	        <OthrAdjstmntTp><xsl:value-of select="other_type"/></OthrAdjstmntTp>
	      </xsl:otherwise>
	    </xsl:choose>
	    <xsl:choose>
	      <xsl:when test="amt !=''">
	        <Amt>
	          <xsl:attribute name="Ccy"><xsl:value-of select="cur_code"/></xsl:attribute>
	          <xsl:value-of select="amt"/>
	        </Amt>
	      </xsl:when>
	      <xsl:otherwise>
	        <Pctg><xsl:value-of select="rate"/></Pctg>
	      </xsl:otherwise>
	    </xsl:choose>
   	   <Drctn><xsl:value-of select="direction"/></Drctn>
  </Adjstmnt>
</xsl:template>

<!-- LineItems: FreightCharges - Service associated charges -->
<xsl:template match="freight_charges/allowance" mode="freight_charge">
  <Chrgs>
	    <xsl:choose>
	      <xsl:when test="type != 'OTHR'">
	        <Tp><xsl:value-of select="type"/></Tp>
	      </xsl:when>
	      <xsl:otherwise>
	        <OthrChrgsTp><xsl:value-of select="other_type"/></OthrChrgsTp>
	      </xsl:otherwise>
	    </xsl:choose>
	    <xsl:choose>
	      <xsl:when test="amt !=''">
	        <Amt>
	          <xsl:attribute name="Ccy"><xsl:value-of select="cur_code"/></xsl:attribute>
	          <xsl:value-of select="amt"/>
	        </Amt>
	      </xsl:when>
	      <xsl:otherwise>
	        <Pctg><xsl:value-of select="rate"/></Pctg>
	      </xsl:otherwise>
	    </xsl:choose>
  </Chrgs>
</xsl:template>


<!-- LineItems: Tax - Money due to the Government -->
<xsl:template match="taxes/allowance" mode="tax">
  <Tax>
	    <xsl:choose>
	      <xsl:when test="type != 'OTHR'">
	        <Tp><xsl:value-of select="type"/></Tp>
	      </xsl:when>
	      <xsl:otherwise>
	        <OthrTaxTp><xsl:value-of select="other_type"/></OthrTaxTp>
	      </xsl:otherwise>
	    </xsl:choose>
	    <xsl:choose>
	      <xsl:when test="amt !=''">
	        <Amt>
	          <xsl:attribute name="Ccy"><xsl:value-of select="cur_code"/></xsl:attribute>
	          <xsl:value-of select="amt"/>
	        </Amt>
	      </xsl:when>
	      <xsl:otherwise>
	        <Pctg><xsl:value-of select="rate"/></Pctg>
	      </xsl:otherwise>
	    </xsl:choose>
  </Tax>
</xsl:template>

</xsl:stylesheet>