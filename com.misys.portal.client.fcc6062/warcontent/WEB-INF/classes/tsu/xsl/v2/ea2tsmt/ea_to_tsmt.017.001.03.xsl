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
<!-- TO DO Certificate DataSet, Other CertificateDataset -->
<xsl:template match="ea_tnx_record">

  <Document>
  <FwdDataSetSubmissnRpt>
    <RptId>
      <Id><xsl:value-of select="$messageId"/></Id>
      <CreDtTm><xsl:value-of select="$messageCreationDate"/></CreDtTm>
    </RptId>
    <RltdTxRefs>
      <TxId><Id><xsl:value-of select="$tid"/></Id></TxId>
      <PurchsOrdrRef>
		<Id><xsl:value-of select="po_ref_id"/></Id>
		<DtOfIsse><xsl:value-of select="tools:getCurrentTMAFormatDateTime()"/></DtOfIsse>
	  </PurchsOrdrRef>
	  <ForcdMtch>true</ForcdMtch>
	  <EstblishdBaselnId>
          <Id><xsl:value-of select="$tid"/></Id>
          <Vrsn></Vrsn>
           <TxSts></TxSts>
        </EstblishdBaselnId>
    </RltdTxRefs>
    
    <CmonSubmissnRef>
        <Id><!-- Commercial Doc Ref Invoice Number --></Id>
    </CmonSubmissnRef>
    
    <Submitr>
        <BIC><xsl:value-of select="seller_bank_bic"/></BIC>
    </Submitr>
    <BuyrBk>
        <BIC><xsl:value-of select="buyer_bank_bic"/></BIC>
    </BuyrBk>
    <SellrBk>
        <BIC><xsl:value-of select="seller_bank_bic"/></BIC>
    </SellrBk>
    
    <ComrclDataSet>
    	<DataSetId>
            <Id></Id>
            <Vrsn></Vrsn>
            <Submitr>
                <BIC><xsl:value-of select="seller_bank_bic"/></BIC>
            </Submitr>
        </DataSetId>
        <ComrclDocRef>
            <InvcNb><xsl:value-of select="invoice_number"/></InvcNb>
            <IsseDt><xsl:value-of select="tools:getCurrentTMAFormatDateTime(invoice_iss_date)"/></IsseDt>
        </ComrclDocRef>
        <!-- Buyer details start -->
		<Buyr>
			<Nm><xsl:value-of select="buyer_name"/></Nm>
			<!-- TODO:: what need to be added (?)ProprietaryIdentification need to be added relation(0..1) -->
			<PstlAdr>
				<xsl:if test="buyer_street_name">
					<StrtNm><xsl:value-of select="buyer_street_name"/></StrtNm>
				</xsl:if>
			<!-- TODO:: correct mapping? PostCodeIdentification <PstCdId> -->
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
			<Nm><xsl:value-of select="seller_name"/></Nm>
			<!-- what need to be added (?)ProprietaryIdentification need to be added relation(0..1) -->
			<PstlAdr>
				<xsl:if test="seller_street_name">
					<StrtNm><xsl:value-of select="seller_street_name"/></StrtNm>
				</xsl:if>
			<!-- correct mapping? PostCodeIdentification <PstCdId> -->
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
		
		<Goods>
			<PurchsOrdrRef>
                <Id><xsl:value-of select="po_ref_id"/></Id>
				<DtOfIsse><xsl:value-of select="tools:getCurrentTMAFormatDateTime()"/></DtOfIsse>
            </PurchsOrdrRef>
			<FnlSubmissn></FnlSubmissn>
			<!-- Line Items -->
			<xsl:apply-templates select="line_items/lt_tnx_record"/>
			
			<LineItmsTtlAmt>
			<!-- TO DO The line item total amt is the good total amt  -->
				<xsl:attribute name="Ccy"><xsl:value-of select="total_cur_code"/></xsl:attribute>
				<xsl:value-of select="total_net_amt"/>
			</LineItmsTtlAmt>
			
			<TtlNetAmt>
			<!-- TO DO The line item total amt is the good total amt  -->
				<xsl:attribute name="Ccy"><xsl:value-of select="total_cur_code"/></xsl:attribute>
				<xsl:value-of select="total_net_amt"/>
			</TtlNetAmt>
			 <Incotrms>
                <IncotrmsCd>
                    <Cd></Cd>
                </IncotrmsCd>
                <Lctn></Lctn>
            </Incotrms>			
		</Goods>
        <PmtTerms>
        	<xsl:variable name="paymentduedate">
					<xsl:value-of select="pymnt_due_date"/>
			</xsl:variable>
           <xsl:apply-templates select="payments/payment">
           		<xsl:with-param name = "pymt_due_date">
						<xsl:value-of select="$paymentduedate"/>
				</xsl:with-param>
			</xsl:apply-templates>
           <AmtOrPctg><!-- TO DO
                <Amt Ccy = ""></Amt> -->
            </AmtOrPctg>
        </PmtTerms>
        <SttlmTerms>
            <CdtrAcct>
                <Id>
                    <IBAN></IBAN>
                </Id>
                <Nm></Nm>
            </CdtrAcct>
        </SttlmTerms>
    </ComrclDataSet>
    
     <TrnsprtDataSet>
     	<DataSetId>
            <Id></Id>
            <Vrsn></Vrsn>
            <Submitr>
                <BIC><xsl:value-of select="seller_bank_bic"/></BIC>
            </Submitr>
        </DataSetId>
        <!-- Buyer details start -->
		<Buyr>
			<Nm><xsl:value-of select="buyer_name"/></Nm>
			<!-- TODO:: what need to be added (?)ProprietaryIdentification need to be added relation(0..1) -->
			<PstlAdr>
				<xsl:if test="buyer_street_name">
					<StrtNm><xsl:value-of select="buyer_street_name"/></StrtNm>
				</xsl:if>
			<!-- TODO:: correct mapping? PostCodeIdentification <PstCdId> -->
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
			<Nm><xsl:value-of select="seller_name"/></Nm>
			<!-- what need to be added (?)ProprietaryIdentification need to be added relation(0..1) -->
			<PstlAdr>
				<xsl:if test="seller_street_name">
					<StrtNm><xsl:value-of select="seller_street_name"/></StrtNm>
				</xsl:if>
			<!-- correct mapping? PostCodeIdentification <PstCdId> -->
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
		<!-- Buyer details start -->
		<Buyr>
			<Nm><xsl:value-of select="buyer_name"/></Nm>
			<!-- TODO:: what need to be added (?)ProprietaryIdentification need to be added relation(0..1) -->
			<PstlAdr>
				<xsl:if test="buyer_street_name">
					<StrtNm><xsl:value-of select="buyer_street_name"/></StrtNm>
				</xsl:if>
			<!-- TODO:: correct mapping? PostCodeIdentification <PstCdId> -->
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
		
		<!-- Consignor details start -->
		<Consgnr>
			<Nm></Nm>
			<!-- what need to be added (?)ProprietaryIdentification need to be added relation(0..1) -->
			<PstlAdr>				
				<StrtNm></StrtNm>
				<PstCdId></PstCdId>
				<TwnNm></TwnNm>
				<CtrySubDvsn></CtrySubDvsn>
				<Ctry></Ctry>
			</PstlAdr>
		</Consgnr>
		<!-- Consignor details end -->
        <TrnsprtInf>
        	<TrnsprtDocRef>
                <Id></Id>
                <DtOfIsse><!--TO DO Might be invoice issue date  --></DtOfIsse>
            </TrnsprtDocRef>
	        <TrnsprtdGoods>
	             <PurchsOrdrRef>
	                 <Id><xsl:value-of select="po_ref_id"/></Id>
					<DtOfIsse><xsl:value-of select="tools:getCurrentTMAFormatDateTime()"/></DtOfIsse>
	             </PurchsOrdrRef>
	             <GoodsDesc></GoodsDesc>
	         </TrnsprtdGoods>
	         <RtgSummry>
	              <IndvTrnsprt>
	                  <TrnsprtByAir>
	                      <DprtureAirprt>
	                          <OthrAirprtDesc>
	                              <Twn></Twn>
	                          </OthrAirprtDesc>
	                      </DprtureAirprt>
	                      <DstnAirprt>
	                          <OthrAirprtDesc>
	                              <Twn></Twn>
	                          </OthrAirprtDesc>
	                      </DstnAirprt>
	                  </TrnsprtByAir>
	              </IndvTrnsprt>
	          </RtgSummry>
	        <ShipmntDt>
                <ActlShipmntDt></ActlShipmntDt>
            </ShipmntDt>
        </TrnsprtInf>
     </TrnsprtDataSet>
  </FwdDataSetSubmissnRpt>
  </Document>
  
</xsl:template>

  <!-- Line Items -->
	<xsl:template match="line_items/lt_tnx_record">
		<ComrclLineItms>
			<LineItmId><xsl:value-of select="line_item_number"/></LineItmId>
			<Qty>
				<UnitOfMeasrCd><xsl:value-of select="qty_unit_measr_code"/></UnitOfMeasrCd>
				<Val><xsl:value-of select="qty_val"/></Val>
			</Qty>
			<TtlAmt>
			<xsl:attribute name="Ccy"><xsl:value-of select="total_cur_code"/></xsl:attribute>
			<xsl:value-of select="total_net_amt"/></TtlAmt>
		</ComrclLineItms>
	</xsl:template>
	
	<xsl:template match="payments/payment">
	<xsl:param name="pymt_due_date"/>
		<PmtTerms>
			<xsl:if test="code[. != '']">
				<PmtCd><xsl:value-of select="code"/></PmtCd>
			</xsl:if>
			<xsl:if test="$pymt_due_date != ''">
				<PmtDueDt><xsl:value-of select="tools:getCurrentTMAFormatDateTime($pymt_due_date)"/></PmtDueDt>
			</xsl:if>
		</PmtTerms>
	</xsl:template>

</xsl:stylesheet>