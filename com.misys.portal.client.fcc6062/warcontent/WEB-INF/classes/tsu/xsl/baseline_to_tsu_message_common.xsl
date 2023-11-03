<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="PdctIdr">
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

<xsl:template match="RtgSummry">
  <RtgSummry>
    <xsl:choose>
      <xsl:when test="IndvTrnsprt">
        <IndvTrnsprt>
          <xsl:apply-templates select="IndvTrnsprt/TrnsprtByAir"/>
          <xsl:apply-templates select="IndvTrnsprt/TrnsprtBySea"/>
          <xsl:apply-templates select="IndvTrnsprt/TrnsprtByRoad"/>
          <xsl:apply-templates select="IndvTrnsprt/TrnsprtByRail"/>
        </IndvTrnsprt>
      </xsl:when>
      <xsl:when test="MltmdlTrnsprt">
        <MltmdlTrnsprt>
          <xsl:apply-templates select="MltmdlTrnsprt/DprtureAirprt"/>
          <xsl:apply-templates select="MltmdlTrnsprt/DstnAirprt"/>
          <xsl:apply-templates select="MltmdlTrnsprt/PortOfLoadng"/>
          <xsl:apply-templates select="MltmdlTrnsprt/PortOfDschrge"/>
          <xsl:apply-templates select="MltmdlTrnsprt/PlcOfRct"/>
          <xsl:apply-templates select="MltmdlTrnsprt/PlcOfDlvry"/>
          <xsl:apply-templates select="MltmdlTrnsprt/TakngInChrg"/>
          <xsl:apply-templates select="MltmdlTrnsprt/PlcOfFnlDstn"/>
        </MltmdlTrnsprt>
      </xsl:when>
    </xsl:choose>
  </RtgSummry>      
</xsl:template>

<xsl:template match="FrghtChrgs">
  <FrghtChrgs>
    <Tp><xsl:value-of select="Tp"/></Tp>
    <xsl:apply-templates select="Chrgs"/>
  </FrghtChrgs>
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
    <xsl:choose>
      <xsl:when test="Amt">
        <Amt>
          <xsl:attribute name="Ccy"><xsl:value-of select="Amt/@Ccy"/></xsl:attribute>
          <xsl:value-of select="Amt"/>
        </Amt>
      </xsl:when>
      <xsl:when test="Rate">
        <Rate><xsl:value-of select="Rate"/></Rate>
      </xsl:when>
    </xsl:choose>
  </Chrgs>
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
    <xsl:choose>
      <xsl:when test="Amt">
        <Amt>
          <xsl:attribute name="Ccy"><xsl:value-of select="Amt/@Ccy"/></xsl:attribute>
          <xsl:value-of select="Amt"/>
        </Amt>
      </xsl:when>
      <xsl:when test="Rate">
        <Rate><xsl:value-of select="Rate"/></Rate>
      </xsl:when>
    </xsl:choose>
    <Drctn><xsl:value-of select="Drctn"/></Drctn>
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
    <xsl:choose>
      <xsl:when test="Amt">
        <Amt>
          <xsl:attribute name="Ccy"><xsl:value-of select="Amt/@Ccy"/></xsl:attribute>
          <xsl:value-of select="Amt"/>
        </Amt>
      </xsl:when>
      <xsl:when test="Rate">
        <Rate><xsl:value-of select="Rate"/></Rate>
      </xsl:when>
    </xsl:choose>
  </Tax>
</xsl:template>

<xsl:template match="BuyrDfndInf">
  <BuyrDfndInf>
    <Labl><xsl:value-of select="Labl"/></Labl>
    <Inf><xsl:value-of select="Inf"/></Inf>
  </BuyrDfndInf>
</xsl:template>

<xsl:template match="SellrDfndInf">
  <SellrDfndInf>
    <Labl><xsl:value-of select="Labl"/></Labl>
    <Inf><xsl:value-of select="Inf"/></Inf>
  </SellrDfndInf>
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
          <xsl:if test="PmtCd/NbOfDays"><NbOfDays><xsl:value-of select="PmtCd/NbOfDays"/></NbOfDays></xsl:if>
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
</xsl:template>

<xsl:template match="DataSetReqrd">
  <DataSetReqrd>
    <xsl:if test="LatstMtchDt"><LatstMtchDt><xsl:value-of select="Labl"/></LatstMtchDt></xsl:if>
    <ReqrdComrclDataSet><xsl:value-of select="ReqrdComrclDataSet"/></ReqrdComrclDataSet>
    <ReqrdTrnsprtDataSet><xsl:value-of select="ReqrdTrnsprtDataSet"/></ReqrdTrnsprtDataSet>
    <Submitr>
      <BIC><xsl:value-of select="BIC"/></BIC>
    </Submitr>
  </DataSetReqrd>
</xsl:template>

<xsl:template match="Buyr">
  <Buyr>
    <xsl:choose>
      <xsl:when test="Nm">
        <Nm><xsl:value-of select="Nm"/></Nm>
      </xsl:when>
      <xsl:when test="BEI">
        <BEI><xsl:value-of select="BEI"/></BEI>
      </xsl:when>
    </xsl:choose>
    <PstlAdr>
      <xsl:if test="PstlAdr/StrtNm"><StrtNm><xsl:value-of select="PstlAdr/StrtNm"/></StrtNm></xsl:if>
      <PstCdId><xsl:value-of select="PstlAdr/PstCdId"/></PstCdId>
      <TwnNm><xsl:value-of select="PstlAdr/TwnNm"/></TwnNm>
      <xsl:if test="PstlAdr/CtrySubDvsn"><CtrySubDvsn><xsl:value-of select="PstlAdr/CtrySubDvsn"/></CtrySubDvsn></xsl:if>
      <Ctry><xsl:value-of select="PstlAdr/Ctry"/></Ctry>
    </PstlAdr>
  </Buyr>
</xsl:template>

<xsl:template match="Sellr">
  <Sellr>
    <xsl:choose>
      <xsl:when test="Nm">
        <Nm><xsl:value-of select="Nm"/></Nm>
      </xsl:when>
      <xsl:when test="BEI">
        <BEI><xsl:value-of select="BEI"/></BEI>
      </xsl:when>
    </xsl:choose>
    <PstlAdr>
      <xsl:if test="PstlAdr/StrtNm"><StrtNm><xsl:value-of select="PstlAdr/StrtNm"/></StrtNm></xsl:if>
      <PstCdId><xsl:value-of select="PstlAdr/PstCdId"/></PstCdId>
      <TwnNm><xsl:value-of select="PstlAdr/TwnNm"/></TwnNm>
      <xsl:if test="PstlAdr/CtrySubDvsn"><CtrySubDvsn><xsl:value-of select="PstlAdr/CtrySubDvsn"/></CtrySubDvsn></xsl:if>
      <Ctry><xsl:value-of select="PstlAdr/Ctry"/></Ctry>
    </PstlAdr>
  </Sellr>
</xsl:template>

<xsl:template match="BllTo">
  <BllTo>
    <xsl:choose>
      <xsl:when test="Nm">
        <Nm><xsl:value-of select="Nm"/></Nm>
      </xsl:when>
      <xsl:when test="BEI">
        <BEI><xsl:value-of select="BEI"/></BEI>
      </xsl:when>
    </xsl:choose>
    <PstlAdr>
      <xsl:if test="PstlAdr/StrtNm"><StrtNm><xsl:value-of select="PstlAdr/StrtNm"/></StrtNm></xsl:if>
      <PstCdId><xsl:value-of select="PstlAdr/PstCdId"/></PstCdId>
      <TwnNm><xsl:value-of select="PstlAdr/TwnNm"/></TwnNm>
      <xsl:if test="PstlAdr/CtrySubDvsn"><CtrySubDvsn><xsl:value-of select="PstlAdr/CtrySubDvsn"/></CtrySubDvsn></xsl:if>
      <Ctry><xsl:value-of select="PstlAdr/Ctry"/></Ctry>
    </PstlAdr>
  </BllTo>
</xsl:template>

<xsl:template match="ShipTo">
  <ShipTo>
    <xsl:choose>
      <xsl:when test="Nm">
        <Nm><xsl:value-of select="Nm"/></Nm>
      </xsl:when>
      <xsl:when test="BEI">
        <BEI><xsl:value-of select="BEI"/></BEI>
      </xsl:when>
    </xsl:choose>
    <PstlAdr>
      <xsl:if test="PstlAdr/StrtNm"><StrtNm><xsl:value-of select="PstlAdr/StrtNm"/></StrtNm></xsl:if>
      <PstCdId><xsl:value-of select="PstlAdr/PstCdId"/></PstCdId>
      <TwnNm><xsl:value-of select="PstlAdr/TwnNm"/></TwnNm>
      <xsl:if test="PstlAdr/CtrySubDvsn"><CtrySubDvsn><xsl:value-of select="PstlAdr/CtrySubDvsn"/></CtrySubDvsn></xsl:if>
      <Ctry><xsl:value-of select="PstlAdr/Ctry"/></Ctry>
    </PstlAdr>
  </ShipTo>
</xsl:template>

<xsl:template match="Consgn">
  <Consgn>
    <xsl:choose>
      <xsl:when test="Nm">
        <Nm><xsl:value-of select="Nm"/></Nm>
      </xsl:when>
      <xsl:when test="BEI">
        <BEI><xsl:value-of select="BEI"/></BEI>
      </xsl:when>
    </xsl:choose>
    <PstlAdr>
      <xsl:if test="PstlAdr/StrtNm"><StrtNm><xsl:value-of select="PstlAdr/StrtNm"/></StrtNm></xsl:if>
      <PstCdId><xsl:value-of select="PstlAdr/PstCdId"/></PstCdId>
      <TwnNm><xsl:value-of select="PstlAdr/TwnNm"/></TwnNm>
      <xsl:if test="PstlAdr/CtrySubDvsn"><CtrySubDvsn><xsl:value-of select="PstlAdr/CtrySubDvsn"/></CtrySubDvsn></xsl:if>
      <Ctry><xsl:value-of select="PstlAdr/Ctry"/></Ctry>
    </PstlAdr>
  </Consgn>
</xsl:template>

</xsl:stylesheet>