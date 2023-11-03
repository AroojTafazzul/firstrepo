<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	exclude-result-prefixes="tools">

<xsl:import href="io_to_tsmt_common.xsl"/>

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:param name="tid"/>
<xsl:param name="serviceCode"/>
<xsl:param name="tnxId"/>

<xsl:template match="/">
  <xsl:apply-templates />
</xsl:template>

<!-- Main template -->
<xsl:template match="io_tnx_record">

  <Document>
  <BaselnAmdmntReq>
    <ReqId>
      <Id><xsl:value-of select="$tnxId"/></Id>
      <CreDtTm><xsl:value-of select="tools:getCurrentTMAFormatDateTime()"/></CreDtTm>
    </ReqId>
    <TxId>
    	<Id><xsl:value-of select="$tid"/></Id>
    </TxId>
    <SubmitrTxRef>
    	<Id><xsl:value-of select="$tnxId"/></Id>
    </SubmitrTxRef>
    <Baseln>
      <SubmitrBaselnId>
        <Id><xsl:value-of select="$tnxId"/></Id>
        <Vrsn>1</Vrsn>
        <Submitr>
          <BIC><xsl:value-of select="buyer_bank_bic"/></BIC>
        </Submitr>
      </SubmitrBaselnId>
      <SvcCd><xsl:value-of select="$serviceCode"/></SvcCd>
      <PurchsOrdrRef>
        <Id><xsl:value-of select="po_ref_id"/></Id>
        <DtOfIsse><xsl:value-of select="tools:getCurrentTMAFormatDateTime()"/></DtOfIsse>
      </PurchsOrdrRef>

      <Buyr>
      	<Nm><xsl:value-of select="buyer_name"/></Nm>
      	<PrtryId>
      		<Id></Id>
      		<IdTp></IdTp>
      	</PrtryId>
      	<PstlAdr>
      		<xsl:if test="buyer_street_name and buyer_street_name !=''"><StrtNm><xsl:value-of select="buyer_street_name"/></StrtNm></xsl:if>
      		<xsl:if test="buyer_post_code and buyer_post_code !=''"><PstCdId><xsl:value-of select="buyer_post_code"/></PstCdId></xsl:if>
      		<xsl:if test="buyer_town_name and buyer_town_name !=''"><TwnNm><xsl:value-of select="buyer_town_name"/></TwnNm></xsl:if>
      		<xsl:if test="buyer_country_sub_div and buyer_country_sub_div !=''"><CtrySubDvsn><xsl:value-of select="buyer_country_sub_div"/></CtrySubDvsn></xsl:if>
      		<Ctry><xsl:value-of select="buyer_country"/></Ctry>
      	</PstlAdr>
      </Buyr>

      <Sellr>
	        <Nm><xsl:value-of select="seller_name"/></Nm>
	      	<PrtryId>
	      		<Id></Id>
	      		<IdTp></IdTp>
	      	</PrtryId>
	      	<PstlAdr>
	      		<xsl:if test="seller_street_name and seller_street_name !=''"><StrtNm><xsl:value-of select="seller_street_name"/></StrtNm></xsl:if>
	      		<xsl:if test="seller_post_code and seller_post_code !=''"><PstCdId><xsl:value-of select="seller_post_code"/></PstCdId></xsl:if>
	      		<xsl:if test="seller_town_name and seller_town_name !=''"><TwnNm><xsl:value-of select="seller_town_name"/></TwnNm></xsl:if>
	      		<xsl:if test="seller_country_sub_div and seller_country_sub_div !=''"><CtrySubDvsn><xsl:value-of select="seller_country_sub_div"/></CtrySubDvsn></xsl:if>
	      		<Ctry><xsl:value-of select="seller_country"/></Ctry>
	      	</PstlAdr>
      	</Sellr>
       
      <BuyrBk>
      	<BIC><xsl:value-of select="buyer_bank_bic"/></BIC>
      </BuyrBk>
      
      <SellrBk>
      	<BIC><xsl:value-of select="seller_bank_bic"/></BIC>
      </SellrBk>
      
      <!-- TODO start -->
      <xsl:apply-templates select="BuyrSdSubmitgBk"/>
      
      <xsl:apply-templates select="SellrSdSubmitgBk"/>
      <!-- TODO end -->
      
      <xsl:if test="bill_to_name and bill_to_name !=''">
	      <BllTo>
		    <Nm><xsl:value-of select="bill_to_name"/></Nm>
	      	<PrtryId>
	      		<Id></Id>
	      		<IdTp></IdTp>
	      	</PrtryId>
	      	<PstlAdr>
	      		<xsl:if test="bill_to_street_name and bill_to_street_name !=''"><StrtNm><xsl:value-of select="bill_to_street_name"/></StrtNm></xsl:if>
	      		<xsl:if test="bill_to_post_code and bill_to_post_code !=''"><PstCdId><xsl:value-of select="bill_to_post_code"/></PstCdId></xsl:if>
	      		<xsl:if test="bill_to_town_name and bill_to_town_name !=''"><TwnNm><xsl:value-of select="bill_to_town_name"/></TwnNm></xsl:if>
	      		<xsl:if test="bill_to_country_sub_div and bill_to_country_sub_div !=''"><CtrySubDvsn><xsl:value-of select="bill_to_country_sub_div"/></CtrySubDvsn></xsl:if>
	      		<Ctry><xsl:value-of select="bill_to_country"/></Ctry>
	      	</PstlAdr>
		  </BllTo>
	  </xsl:if>
      
      <xsl:if test="ship_to_name and ship_to_name !=''">
	      <ShipTo>
			  <Nm><xsl:value-of select="ship_to_name"/></Nm>
		      <PrtryId>
		      	<Id></Id>
		      	<IdTp></IdTp>
		      </PrtryId>
		      <PstlAdr>
		      	<xsl:if test="ship_to_street_name and ship_to_street_name !=''"><StrtNm><xsl:value-of select="ship_to_street_name"/></StrtNm></xsl:if>
		      	<xsl:if test="ship_to_post_code and ship_to_post_code !=''"><PstCdId><xsl:value-of select="ship_to_post_code"/></PstCdId></xsl:if>
		      	<xsl:if test="ship_to_town_name and ship_to_town_name !=''"><TwnNm><xsl:value-of select="ship_to_town_name"/></TwnNm></xsl:if>
		      	<xsl:if test="ship_to_country_sub_div and ship_to_country_sub_div !=''"><CtrySubDvsn><xsl:value-of select="ship_to_country_sub_div"/></CtrySubDvsn></xsl:if>
		      	<Ctry><xsl:value-of select="ship_to_country"/></Ctry>
		      </PstlAdr>
	      	</ShipTo>
      	</xsl:if>
      
      <xsl:if test="consgn_name and consgn_name !=''">
	      <Consgn>
	      		<Nm><xsl:value-of select="consgn_name"/></Nm>
	      		<PrtryId>
	      			<Id></Id>
	      			<IdTp></IdTp>
	      		</PrtryId>
	      		<PstlAdr>
	      			<xsl:if test="consgn_street_name and consgn_street_name !=''"><StrtNm><xsl:value-of select="consgn_street_name"/></StrtNm></xsl:if>
	      			<xsl:if test="consgn_post_code and consgn_post_code !=''"><PstCdId><xsl:value-of select="consgn_post_code"/></PstCdId></xsl:if>
	      			<xsl:if test="consgn_town_name and consgn_town_name !=''"><TwnNm><xsl:value-of select="consgn_town_name"/></TwnNm></xsl:if>
	      			<xsl:if test="consgn_country_sub_div and consgn_country_sub_div !=''"><CtrySubDvsn><xsl:value-of select="consgn_country_sub_div"/></CtrySubDvsn></xsl:if>
	      			<Ctry><xsl:value-of select="consgn_country"/></Ctry>
	      		</PstlAdr>
	      	</Consgn>
      	</xsl:if>
      	
      <Goods>
        <xsl:if test="goods_desc and goods_desc !=''"><GoodsDesc><xsl:value-of select="goods_desc"/></GoodsDesc></xsl:if>
        <PrtlShipmnt><xsl:value-of select="part_ship"/></PrtlShipmnt>
        <xsl:if test="tran_ship and tran_ship !=''"><TrnsShipmnt><xsl:value-of select="tran_ship"/></TrnsShipmnt></xsl:if>
        
        <!-- TODO start -->
        <ShipmntDtRg>
        	<EarlstShipmntDt></EarlstShipmntDt>
        	<LatstShipmntDt></LatstShipmntDt>
		</ShipmntDtRg>
		<!-- TODO end -->
		
        <xsl:apply-templates select="line_items/lt_tnx_record" mode="amend"/>
        
        <LineItmsTtlAmt>
          <xsl:attribute name="Ccy"><xsl:value-of select="total_cur_code"/></xsl:attribute>
          <xsl:value-of select="total_amt"/>
        </LineItmsTtlAmt>
		
		<!-- TODO start -->
		<!-- <xsl:if test="routing_summaries/routing_summary">
			<RtgSummry>
				<IndvTrnsprt>
					<xsl:apply-templates select="routing_summaries/routing_summary" mode="individual"/>
				</IndvTrnsprt>
				<xsl:apply-templates select="routing_summaries/routing_summary" mode="multimodal"/>
	        </RtgSummry>
        </xsl:if> -->
        <!-- TODO end -->
        
      	<xsl:if test="incoterms/incoterm">
        	<xsl:apply-templates select="incoterms/incoterm"/>
        </xsl:if>
        
        <xsl:if test="adjustments/adjustment">
        	<xsl:apply-templates select="adjustments/adjustment"/>
      	</xsl:if>
      	
      	<xsl:if test="freightCharges/freightCharge">
      		<FrghtChrgs>
				<Tp><xsl:value-of select="freight_charges_type"/></Tp>
	        	<xsl:apply-templates select="freightCharges/freightCharge"/>
        	</FrghtChrgs>
        </xsl:if>
      	
      	<xsl:if test="taxes/tax">
        	<xsl:apply-templates select="taxes/tax"/>
        </xsl:if>
      
        <TtlNetAmt>
          <xsl:attribute name="Ccy"><xsl:value-of select="total_net_cur_code"/></xsl:attribute>
          <xsl:value-of select="total_net_amt"/>
        </TtlNetAmt>
		
		<xsl:if test="user_defined_informations">
        	<xsl:apply-templates select="user_defined_informations/user_defined_information"/>
        </xsl:if>

      </Goods>

      <xsl:apply-templates select="payments/payment" mode="amend"/>
    
      <SttlmTerms>
	    <xsl:if test="CdtrAgt">
	      <CdtrAgt>
	        <xsl:choose>
	          <xsl:when test="CdtrAgt/BIC">
	            <BIC><xsl:value-of select="CdtrAgt/BIC"/></BIC>
	          </xsl:when>
	          <xsl:when test="CdtrAgt/NmAndAdr">
	            <NmAndAdr>
	              <Nm><xsl:value-of select="CdtrAgt/NmAndAdr/Nm"/></Nm>
	              <Adr>
	                <xsl:if test="CdtrAgt/NmAndAdr/Adr/StrtNm"><StrtNm><xsl:value-of select="CdtrAgt/NmAndAdr/Adr/StrtNm"/></StrtNm></xsl:if>
	                <PstCdId><xsl:value-of select="CdtrAgt/NmAndAdr/Adr/PstCdId"/></PstCdId>
	                <TwnNm><xsl:value-of select="CdtrAgt/NmAndAdr/Adr/TwnNm"/></TwnNm>
	                <xsl:if test="CdtrAgt/NmAndAdr/Adr/CtrySubDvsn"><CtrySubDvsn><xsl:value-of select="CdtrAgt/NmAndAdr/Adr/CtrySubDvsn"/></CtrySubDvsn></xsl:if>
	                <Ctry><xsl:value-of select="CdtrAgt/NmAndAdr/Adr/Ctry"/></Ctry>
	              </Adr>
	            </NmAndAdr>
	          </xsl:when>
	        </xsl:choose>
	      </CdtrAgt>
	    </xsl:if>
	    <CdtrAcct>
	      <xsl:choose>
	        <xsl:when test="CdtrAcct/Nm">
	          <Nm><xsl:value-of select="CdtrAcct/Nm"/></Nm>
	        </xsl:when>
	        <xsl:when test="CdtrAcct/Id">
	          <Id>
	            <xsl:choose>
	              <xsl:when test="CdtrAcct/Id/IBAN"><IBAN><xsl:value-of select="CdtrAcct/Id/IBAN"/></IBAN></xsl:when>
	              <xsl:when test="CdtrAcct/Id/Othr">
	              <Othr>
	              	<Id></Id>
	              	<SchmeNm>
	              		<Cd></Cd>
	              		<Prtry></Prtry>
	              	</SchmeNm>
	              	<Issr></Issr>
	              </Othr>
	              </xsl:when>
	            </xsl:choose>
	          </Id>
	        </xsl:when>
	        <xsl:when test="CdtrAcct/Tp">
	        <Tp>
	        	<Cd></Cd>
	        	<Prtry></Prtry>
	        </Tp>
	        </xsl:when>
	      </xsl:choose>
	      <Ccy></Ccy>
	      <Nm></Nm>
	    </CdtrAcct>
	  </SttlmTerms>
      
      <xsl:if test="bank_payment_obligation/PmtOblgtn">
      	<xsl:apply-templates select="bank_payment_obligation/PmtOblgtn"/>
      </xsl:if>
      
      <xsl:if test="LatstMtchDt and LatstMtchDt !=''"><LatstMtchDt></LatstMtchDt></xsl:if>
    
      <ComrclDataSetReqrd>
      	<xsl:apply-templates select="commercial_dataset/ComrclDataSetReqrd/Submitr"/>
      </ComrclDataSetReqrd>
      
      <xsl:if test="transport_dataset/TrnsprtDataSetReqrd">
	      <TrnsprtDataSetReqrd>
	      	<xsl:apply-templates select="transport_dataset/TrnsprtDataSetReqrd/Submitr"/>
	      </TrnsprtDataSetReqrd>
      </xsl:if>
      
      <xsl:if test="insurance_dataset/InsrncDataSetReqrd">
	      <InsrncDataSetReqrd>
	      	<xsl:apply-templates select="insurance_dataset/InsrncDataSetReqrd/Submitr"/>
	      	<xsl:if test="insurance_dataset/InsrncDataSetReqrd/MtchIssr/Nm !=''">
		      	<MtchIssr>
		      		<Nm><xsl:value-of select="insurance_dataset/InsrncDataSetReqrd/MtchIssr/Nm"/></Nm>
		      		<xsl:if test="insurance_dataset/InsrncDataSetReqrd/MtchIssr/PrtryId/Id !=''">
			      		<PrtryId>
			      			<Id><xsl:value-of select="insurance_dataset/InsrncDataSetReqrd/MtchIssr/PrtryId/Id"/></Id>
			      			<IdTp><xsl:value-of select="insurance_dataset/InsrncDataSetReqrd/MtchIssr/PrtryId/IdTp"/></IdTp>
			      		</PrtryId>
			      	</xsl:if>
		      		<Ctry><xsl:value-of select="insurance_dataset/InsrncDataSetReqrd/MtchIssr/Ctry"/></Ctry>
		      	</MtchIssr>
	      	</xsl:if>
	      	<MtchIsseDt><xsl:value-of select="insurance_dataset/InsrncDataSetReqrd/MtchIsseDt"/></MtchIsseDt>
	      	<MtchTrnsprt><xsl:value-of select="insurance_dataset/InsrncDataSetReqrd/MtchTrnsprt"/></MtchTrnsprt>
	      	<MtchAmt><xsl:value-of select="insurance_dataset/InsrncDataSetReqrd/MtchAmt"/></MtchAmt>
	      	<xsl:if test="insurance_dataset/InsrncDataSetReqrd/ClausesReqrd !=''">
	      		<xsl:apply-templates select="insurance_dataset/InsrncDataSetReqrd/ClausesReqrd"/>
	      	</xsl:if>
	      	<xsl:if test="insurance_dataset/InsrncDataSetReqrd/MtchAssrdPty !=''"><MtchAssrdPty><xsl:value-of select="insurance_dataset/InsrncDataSetReqrd/MtchAssrdPty"/></MtchAssrdPty></xsl:if>
	      </InsrncDataSetReqrd>
      </xsl:if>
      
      <xsl:if test="certificate_dataset/CertDataSetReqrd">
      	<xsl:apply-templates select="certificate_dataset/CertDataSetReqrd"/>
      </xsl:if>
      
      <xsl:if test="other_certificate_dataset/OthrCertDataSetReqrd">
      	<xsl:apply-templates select="other_certificate_dataset/OthrCertDataSetReqrd"/>
      </xsl:if>
      
      <InttToPayXpctd></InttToPayXpctd>
    </Baseln>
    
    <xsl:if test="contacts/contact">
    	<xsl:apply-templates select="contacts/contact"/>
    </xsl:if>
    
  </BaselnAmdmntReq>
  </Document>
  
</xsl:template>

<xsl:template match="lt_tnx_record" mode="amend">
	<LineItmDtls>
		<LineItmId><xsl:value-of select="line_item_number"/></LineItmId>
		<Qty>
			<UnitOfMeasr>
				<xsl:choose>
					<xsl:when test="qty_unit_measr_code !=''">
						<UnitOfMeasrCd><xsl:value-of select="qty_unit_measr_code"/></UnitOfMeasrCd>
					</xsl:when>
					<xsl:otherwise>
						<OthrUnitOfMeasr><xsl:value-of select="qty_other_unit_measr"/></OthrUnitOfMeasr>
					</xsl:otherwise>
				</xsl:choose>
			</UnitOfMeasr>
			<Val><xsl:value-of select="qty_val"/></Val>
			<xsl:if test="qty_factor and qty_factor !=''"><Fctr><xsl:value-of select="qty_factor"/></Fctr></xsl:if>
		</Qty>
		<xsl:if test="qty_tol_pstv_pct and qty_tol_pstv_pct !=''">
			<QtyTlrnce>
				<PlusPct><xsl:value-of select="qty_tol_pstv_pct"/></PlusPct>
				<MnsPct><xsl:value-of select="qty_tol_neg_pct"/></MnsPct>
			</QtyTlrnce>
		</xsl:if>
		
		<xsl:if test="price_amt and price_amt !=''">
			<UnitPric>
				<UnitPric>
					<xsl:choose>
						<xsl:when test="price_unit_measr_code !=''">
							<UnitOfMeasrCd><xsl:value-of select="price_unit_measr_code"/></UnitOfMeasrCd>
						</xsl:when>
						<xsl:otherwise>
							<OthrUnitOfMeasr><xsl:value-of select="price_other_unit_measr"/></OthrUnitOfMeasr>
						</xsl:otherwise>
					</xsl:choose>
				</UnitPric>
				<Amt><xsl:value-of select="price_amt"/></Amt>
				<xsl:if test="price_factor and price_factor !=''"><Fctr><xsl:value-of select="price_factor"/></Fctr></xsl:if>
			</UnitPric>
		</xsl:if>
		
		<xsl:if test="price_tol_pstv_pct and price_tol_pstv_pct !=''">
			<PricTlrnce>
				<PlusPct><xsl:value-of select="price_tol_pstv_pct"/></PlusPct>
				<MnsPct><xsl:value-of select="price_tol_neg_pct"/></MnsPct>
			</PricTlrnce>
		</xsl:if>
		
		<xsl:if test="product_name and product_name !=''"><PdctNm><xsl:value-of select="product_name"/></PdctNm></xsl:if>
		
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
		
		<!-- TODO start-->
		<ShipmntSchdl>
			<ShipmntDtRg>
				<EarlstShipmntDt></EarlstShipmntDt>
				<LatstShipmntDt></LatstShipmntDt>
			</ShipmntDtRg>
			<xsl:apply-templates select="ShipmntSubSchdl"/>
		</ShipmntSchdl>
		<!-- TODO end-->
		
		<!-- TODO start -->
		<!-- <xsl:if test="routing_summaries/routing_summary">
			<RtgSummry>
				<IndvTrnsprt>
					<xsl:apply-templates select="routing_summaries/routing_summary" mode="individual"/>
				</IndvTrnsprt>
				<xsl:apply-templates select="routing_summaries/routing_summary" mode="multimodal"/>
	        </RtgSummry>
        </xsl:if> -->
        <!-- TODO end -->
		
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
			<xsl:attribute name="Ccy"><xsl:value-of select="total_cur_code"/></xsl:attribute>
			<xsl:value-of select="total_amt"/>
		</TtlAmt>
		
		<xsl:if test="incoterms/incoterm">
			<xsl:apply-templates select="incoterms/incoterm"/>
		</xsl:if>
	</LineItmDtls>
</xsl:template>

</xsl:stylesheet>