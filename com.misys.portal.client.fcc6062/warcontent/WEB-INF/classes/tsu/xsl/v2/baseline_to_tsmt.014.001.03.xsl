<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="baseline_to_tsu_message_common.xsl"/>

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:param name="tid"/>
<xsl:param name="messageId"/>
<xsl:param name="messageCreationDate"/>

<xsl:template match="/">
  <xsl:apply-templates select="bn_tnx_record/narrative_xml/Baseln"/>
</xsl:template>

<!-- Main template -->
<xsl:template match="Baseln">

  <Document>
  <DataSetSubmissn>
    <SubmissnId>
      <Id><xsl:value-of select="$messageId"/></Id>
      <CreDtTm><xsl:value-of select="$messageCreationDate"/></CreDtTm>
    </SubmissnId>
    <RltdTxRefs>
      <TxId><xsl:value-of select="$tid"/></TxId>
      <PurchsOrdrRef>
      	<Id><xsl:value-of select="PurchsOrdrRef/Id"/></Id>
      	<DtOfIsse><xsl:value-of select="PurchsOrdrRef/DtOfIsse"/></DtOfIsse>
      </PurchsOrdrRef>
      <ForcdMtch/>
    </RltdTxRefs>
    <CmonSubmissnRef>
      <Id/>
    </CmonSubmissnRef>
    <Instr>
      <Tp/>
    </Instr>
    <BuyrBk>
      <BIC><xsl:value-of select="BuyrBk/BIC"/></BIC>
    </BuyrBk>
    <SellrBk>
      <BIC><xsl:value-of select="SellrBk/BIC"/></BIC>
    </SellrBk>
    <!--<ComrclDataSet>
      <DataSetId>
      <Id/>
      <Vrsn/>
      <Submitr>
        <BIC><xsl:value-of select="Submitr/BIC"/></BIC>
      </Submitr>
    </DataSetId>
    <ComrclDocRef>
      <Id/>
      <DtOfIsse/>
    </ComrclDocRef>

    <xsl:apply-templates select="Buyr"/>

    <xsl:apply-templates select="Sellr"/>

    <xsl:apply-templates select="BllTo"/>
    <Goods>
      <PurchsOrdrRef>
        <Id><xsl:value-of select="PurchsOrdrRef/Id"/></Id>
        <DtOfIsse><xsl:value-of select="PurchsOrdrRef/DtOfIsse"/></DtOfIsse>
      </PurchsOrdrRef>
      
      <xsl:apply-templates select="Goods/LineItmDtls"/>
      
      <LineItmsTtlAmt>
        <xsl:attribute name="Ccy"><xsl:value-of select="Goods/LineItmsTtlAmt/@Ccy"/></xsl:attribute>
        <xsl:value-of select="Goods/LineItmsTtlAmt"/>
      </LineItmsTtlAmt>

      <xsl:apply-templates select="Goods/FrghtChrgs"/>
      
      <xsl:apply-templates select="Goods/Adjstmnt"/>

      <xsl:apply-templates select="Goods/Tax"/>

      <TtlNetAmt>
        <xsl:attribute name="Ccy"><xsl:value-of select="Goods/TtlNetAmt/@Ccy"/></xsl:attribute>
        <xsl:value-of select="Goods/TtlNetAmt"/>
      </TtlNetAmt>

    </Goods>

    <xsl:apply-templates select="PmtTerms"/>
    
    <xsl:apply-templates select="SttlmTerms"/>

  </ComrclDataSet>-->
  
  <!-- <NewTrnsprtDataSet>  
  </NewTrnsprtDataSet>-->
	
  </DataSetSubmissn>
  </Document>
  
</xsl:template>

<!-- Line item template -->
<xsl:template match="LineItmDtls">
  
  <ComrclLineItms>
    <LineItmNb><xsl:value-of select="LineItmNb"/></LineItmNb>
    <Qty>
      <xsl:choose>
        <xsl:when test="Qty/UnitOfMeasrCd">
          <UnitOfMeasrCd><xsl:value-of select="Qty/UnitOfMeasrCd"/></UnitOfMeasrCd>
        </xsl:when>
        <xsl:when test="Qty/OthrUnitOfMeasr">
          <OthrUnitOfMeasr><xsl:value-of select="Qty/UnitOfMeasrCd/OthrUnitOfMeasr"/></OthrUnitOfMeasr>
        </xsl:when>
      </xsl:choose>
      <Val><xsl:value-of select="Qty/Val"/></Val>
      <Fctr><xsl:value-of select="Qty/Fctr"/></Fctr>
    </Qty>
    <UnitPric>
      <xsl:choose>
        <xsl:when test="UnitPric/UnitOfMeasrCd">
          <UnitOfMeasrCd><xsl:value-of select="UnitPric/UnitOfMeasrCd"/></UnitOfMeasrCd>
        </xsl:when>
        <xsl:when test="UnitPric/OthrUnitOfMeasr">
          <OthrUnitOfMeasr><xsl:value-of select="UnitPric/OthrUnitOfMeasr"/></OthrUnitOfMeasr>
        </xsl:when>
      </xsl:choose>
      <Amt>
        <xsl:attribute name="Ccy"><xsl:value-of select="UnitPric/Amt/@Ccy"/></xsl:attribute>
        <xsl:value-of select="UnitPric/Amt"/>
      </Amt>
      <Fctr><xsl:value-of select="UnitPric/Fctr"/></Fctr>
    </UnitPric>
    <xsl:if test="PdctNm"><PdctNm><xsl:value-of select="PdctNm"/></PdctNm></xsl:if>
    
    <xsl:apply-templates select="PdctIdr"/>
    
    <xsl:apply-templates select="PdctChrtcs"/>

    <xsl:apply-templates select="PdctCtgy"/>

    <xsl:apply-templates select="Adjstmnt"/>

    <TtlAmt>
      <xsl:attribute name="Ccy"><xsl:value-of select="TtlAmt/@Ccy"/></xsl:attribute>
      <xsl:value-of select="TtlAmt"/>
    </TtlAmt>

  </ComrclLineItms>
  
</xsl:template>

<!-- <xsl:template match="PdctIdr">
  <PdctIdr>
    <xsl:choose>
      <xsl:when test="StrdPdctIdr">
        <Tp><xsl:value-of select="StrdPdctIdr/Tp"/></Tp>
        <Idr><xsl:value-of select="StrdPdctIdr/Idr"/></Idr>
      </xsl:when>
      <xsl:when test="OthrPdctIdr">
        <Id><xsl:value-of select="OthrPdctIdr/Id"/></Id>
        <IdTp><xsl:value-of select="OthrPdctIdr/IdTp"/></IdTp>
      </xsl:when>
    </xsl:choose>
  </PdctIdr>
</xsl:template>

<xsl:template match="PdctChrtcs">
  <PdctChrtcs>
    <xsl:choose>
      <xsl:when test="StrdPdctChrtcs">
        <Tp><xsl:value-of select="StrdPdctChrtcs/Tp"/></Tp>
        <Chrtcs><xsl:value-of select="StrdPdctIdr/Chrtcs"/></Chrtcs>
      </xsl:when>
      <xsl:when test="OthrPdctChrtcs">
        <Id><xsl:value-of select="OthrPdctChrtcs/Id"/></Id>
        <IdTp><xsl:value-of select="OthrPdctChrtcs/IdTp"/></IdTp>
      </xsl:when>
    </xsl:choose>
  </PdctChrtcs>
</xsl:template>

<xsl:template match="PdctCtgy">
  <PdctCtgy>
    <xsl:choose>
      <xsl:when test="StrdPdctCtgy">
        <Tp><xsl:value-of select="StrdPdctCtgy/Tp"/></Tp>
        <Ctgy><xsl:value-of select="StrdPdctCtgy/Ctgy"/></Ctgy>
      </xsl:when>
      <xsl:when test="OthrPdctCtgy">
        <Id><xsl:value-of select="OthrPdctCtgy/Id"/></Id>
        <IdTp><xsl:value-of select="OthrPdctCtgy/IdTp"/></IdTp>
      </xsl:when>
    </xsl:choose>
  </PdctCtgy>
</xsl:template>

<xsl:template match="Adjstmnt">
  <Adjstmnt>
    <xsl:choose>
      <xsl:when test="Tp">
        <Tp><xsl:value-of select="Tp"/></Tp>
      </xsl:when>
      <xsl:when test="OthrAdjstmntTp">
        <OthrAdjstmntTp><xsl:value-of select="OthrAdjstmntTp"/></OthrAdjstmntTp>
      </xsl:when>
    </xsl:choose>
    <Drctn><xsl:value-of select="Drctn"/></Drctn>
    <Amt>
      <xsl:attribute name="Ccy"><xsl:value-of select="Amt/@Ccy"/></xsl:attribute>
      <xsl:value-of select="Amt"/>
    </Amt>
  </Adjstmnt>
</xsl:template>

<xsl:template match="Tax">
  <Tax>
    <xsl:choose>
      <xsl:when test="Tp">
        <Tp><xsl:value-of select="Tp"/></Tp>
      </xsl:when>
      <xsl:when test="OthrTaxTp">
        <OthrTaxTp><xsl:value-of select="OthrTaxTp"/></OthrTaxTp>
      </xsl:when>
    </xsl:choose>
    <Amt>
      <xsl:attribute name="Ccy"><xsl:value-of select="Amt/@Ccy"/></xsl:attribute>
      <xsl:value-of select="Amt"/>
    </Amt>
  </Tax>
</xsl:template>

<xsl:template match="Chrgs">
  <Chrgs>
    <xsl:choose>
      <xsl:when test="Tp">
        <Tp><xsl:value-of select="Tp"/></Tp>
      </xsl:when>
      <xsl:when test="OthrChrgsTp">
        <OthrChrgsTp><xsl:value-of select="OthrChrgsTp"/></OthrChrgsTp>
      </xsl:when>
    </xsl:choose>
    <Amt>
      <xsl:attribute name="Ccy"><xsl:value-of select="Amt/@Ccy"/></xsl:attribute>
      <xsl:value-of select="Amt"/>
    </Amt>
  </Chrgs>
</xsl:template>

<xsl:template match="PmtTerms">
  <PmtTerms>
    <xsl:choose>
      <xsl:when test="OthrPmtTerms">
        <OthrPmtTerms><xsl:value-of select="OthrPmtTerms"/></OthrPmtTerms>
      </xsl:when>
      <xsl:when test="PmtCd">
        <PmtCd>
          <Cd><xsl:value-of select="PmtCd/Cd"/></Cd>
          <NbOfDays><xsl:value-of select="PmtCd/NbOfDays"/></NbOfDays>
        </PmtCd>
      </xsl:when>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="Pctg">
        <Pctg><xsl:value-of select="Pctg"/></Pctg>
      </xsl:when>
      <xsl:when test="Amt">
        <Amt>
          <xsl:attribute name="Ccy"><xsl:value-of select="Amt/@Ccy"/></xsl:attribute>
          <xsl:value-of select="Amt"/>
        </Amt>
      </xsl:when>
    </xsl:choose>
  </PmtTerms>
</xsl:template>

<xsl:template match="SttlmTerms">
  <SttlmTerms>
    <xsl:if test="FnlAgt">
      <FnlAgt>
        <xsl:choose>
          <xsl:when test="FnlAgt/BIC">
            <BIC><xsl:value-of select="FnlAgt/BIC"/></BIC>
          </xsl:when>
          <xsl:when test="FnlAgt/NmAndAdr">
            <NmAndAdr>
              <Nm><xsl:value-of select="FnlAgt/NmAndAdr/Nm"/></Nm>
              <Adr>
                <xsl:if test="FnlAgt/NmAndAdr/Adr/StrtNm"><StrtNm><xsl:value-of select="FnlAgt/NmAndAdr/Adr/StrtNm"/></StrtNm></xsl:if>
                <PstCdId><xsl:value-of select="FnlAgt/NmAndAdr/Adr/PstCdId"/></PstCdId>
                <TwnNm><xsl:value-of select="FnlAgt/NmAndAdr/Adr/TwnNm"/></TwnNm>
                <xsl:if test="FnlAgt/NmAndAdr/Adr/CtrySubDvsn"><CtrySubDvsn><xsl:value-of select="FnlAgt/NmAndAdr/Adr/CtrySubDvsn"/></CtrySubDvsn></xsl:if>
                <Ctry><xsl:value-of select="FnlAgt/NmAndAdr/Adr/Ctry"/></Ctry>
              </Adr>
            </NmAndAdr>
          </xsl:when>
        </xsl:choose>
      </FnlAgt>
    </xsl:if>
    <BnfcryAcct>
      <xsl:choose>
        <xsl:when test="BnfcryAcct/Nm">
          <Nm><xsl:value-of select="BnfcryAcct/Nm"/></Nm>
        </xsl:when>
        <xsl:when test="BnfcryAcct/Id">
          <Id>
            <xsl:choose>
              <xsl:when test="BnfcryAcct/Id/IBAN"><IBAN><xsl:value-of select="BnfcryAcct/Id/IBAN"/></IBAN></xsl:when>
              <xsl:when test="BnfcryAcct/Id/BBAN"><BBAN><xsl:value-of select="BnfcryAcct/Id/BBAN"/></BBAN></xsl:when>
              <xsl:when test="BnfcryAcct/Id/UPIC"><UPIC><xsl:value-of select="BnfcryAcct/Id/UPIC"/></UPIC></xsl:when>
              <xsl:when test="BnfcryAcct/Id/DmstAcct"><DmstAcct><Id><xsl:value-of select="BnfcryAcct/Id/DmstAcct/Id"/></Id></DmstAcct></xsl:when>
            </xsl:choose>
          </Id>
        </xsl:when>
        <xsl:when test="BnfcryAcct/NmAndId">
          <Id>
            <xsl:choose>
              <xsl:when test="BnfcryAcct/NmAndId/IBAN"><IBAN><xsl:value-of select="BnfcryAcct/NmAndId/IBAN"/></IBAN></xsl:when>
              <xsl:when test="BnfcryAcct/NmAndId/BBAN"><BBAN><xsl:value-of select="BnfcryAcct/NmAndId/BBAN"/></BBAN></xsl:when>
              <xsl:when test="BnfcryAcct/NmAndId/UPIC"><UPIC><xsl:value-of select="BnfcryAcct/NmAndId/UPIC"/></UPIC></xsl:when>
              <xsl:when test="BnfcryAcct/NmAndId/DmstAcct"><DmstAcct><Id><xsl:value-of select="BnfcryAcct/NmAndId/DmstAcct/Id"/></Id></DmstAcct></xsl:when>
            </xsl:choose>
          </Id>
          <Nm><xsl:value-of select="BnfcryAcct/Nm"/></Nm>
        </xsl:when>
      </xsl:choose>
    </BnfcryAcct>
  </SttlmTerms>
</xsl:template>-->

</xsl:stylesheet>