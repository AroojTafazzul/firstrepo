<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--<xsl:import href="baseline_to_tsu_message_common.xsl"/>-->

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:param name="tid"/>
<xsl:param name="messageId"/>
<xsl:param name="messageCreationDate"/>

<xsl:template match="/">
  <xsl:apply-templates select="bn_tnx_record/narrative_xml"/>
</xsl:template>

<!-- Main template -->
<xsl:template match="narrative_xml">

  <Document>
  <BaselnAmdmntReq>
    <ReqId>
      <Id><xsl:value-of select="$messageId"/></Id>
      <CreDtTm><xsl:value-of select="$messageCreationDate"/></CreDtTm>
    </ReqId>
    <TxId><Id><xsl:value-of select="$tid"/></Id></TxId>
    
    <xsl:apply-templates select="Baseln"/>

    <!--<Baseln>
      <SubmitrBaselnId>
        <Id><xsl:value-of select="SubmitrBaselnId/Id"/></Id>
        <Vrsn><xsl:value-of select="SubmitrBaselnId/Vrsn"/></Vrsn>
        <Submitr>
          <BIC><xsl:value-of select="SubmitrBaselnId/Submitr/BIC"/></BIC>
        </Submitr>
        <SvcCd><xsl:value-of select="SubmitrBaselnId/SvcCd"/></SvcCd>
      </SubmitrBaselnId>
      <PurchsOrdrRef>
        <Id><xsl:value-of select="PurchsOrdrRef/Id"/></Id>
      </PurchsOrdrRef>

      <xsl:apply-templates select="Buyr"/>

      <xsl:apply-templates select="Sellr"/>
      
      <BuyrBk>
        <BIC><xsl:value-of select="BuyrBk/BIC"/></BIC>
      </BuyrBk>
      <SellrBk>
        <BIC><xsl:value-of select="SellrBk/BIC"/></BIC>
      </SellrBk>

      <xsl:apply-templates select="BllTo"/>

      <xsl:apply-templates select="ShipTo"/>
      
      <xsl:apply-templates select="Consgn"/>
      
      <Goods>
        <xsl:if test="Goods/GoodsDesc"><GoodsDesc><xsl:value-of select="Goods/GoodsDesc"/></GoodsDesc></xsl:if>
        <PrtlShipmnt><xsl:value-of select="Goods/PrtlShipmnt"/></PrtlShipmnt>
        <xsl:if test="Goods/TrnsShipmnt"><PrtlShipmnt><xsl:value-of select="Goods/PrtlShipmnt"/></PrtlShipmnt></xsl:if>
        <xsl:if test="Goods/LatstShipmntDt"><LatstShipmntDt><xsl:value-of select="Goods/LatstShipmntDt"/></LatstShipmntDt></xsl:if>

        <xsl:apply-templates select="Goods/LineItmDtls"/>

        <LineItmsTtlAmt>
          <xsl:attribute name="Ccy"><xsl:value-of select="Goods/LineItmsTtlAmt/@Ccy"/></xsl:attribute>
          <xsl:value-of select="Goods/LineItmsTtlAmt"/>
        </LineItmsTtlAmt>

        <xsl:apply-templates select="Goods/RtgSummry"/>
      
        <xsl:apply-templates select="Goods/Incotrms"/>
      
        <xsl:apply-templates select="Goods/FrghtChrgs"/>
      
        <xsl:apply-templates select="Goods/Adjstmnt"/>

        <xsl:apply-templates select="Goods/Tax"/>
      
        <TtlNetAmt>
          <xsl:attribute name="Ccy"><xsl:value-of select="Goods/TtlNetAmt/@Ccy"/></xsl:attribute>
          <xsl:value-of select="Goods/TtlNetAmt"/>
        </TtlNetAmt>

        <xsl:apply-templates select="Goods/BuyrDfndInf"/>

        <xsl:apply-templates select="Goods/SellrDfndInf"/>

      </Goods>

      <xsl:apply-templates select="PmtTerms"/>
    
      <xsl:apply-templates select="SttlmTerms"/>
    
      <xsl:apply-templates select="DataSetReqrd"/>

    </Baseln>-->
  </BaselnAmdmntReq>
  </Document>
  
</xsl:template>

    <xsl:template match="Baseln">
      <xsl:copy>
        <xsl:apply-templates select="node()|@*"/>
      </xsl:copy>
    </xsl:template>

  <xsl:template match="node() | @*">
		<xsl:choose>
			<xsl:when test="name()='OrdrdQty'">
				<Qty>
					<xsl:if test="UnitOfMeasrCd"><UnitOfMeasrCd><xsl:value-of select="UnitOfMeasrCd"/></UnitOfMeasrCd></xsl:if>
					<xsl:if test="OthrUnitOfMeasr"><OthrUnitOfMeasr><xsl:value-of select="OthrUnitOfMeasr"/></OthrUnitOfMeasr></xsl:if>
					<Val><xsl:value-of select="Val"/></Val>
					<xsl:if test="Fctr"><Fctr><xsl:value-of select="Fctr"/></Fctr></xsl:if>
				</Qty>
			</xsl:when>
			<xsl:when test="name()='AccptdQty'"/>
			<xsl:when test="name()='OutsdngQty'"/>
			<xsl:when test="name()='PdgQty'"/>

			<xsl:when test="name()='OrdrdAmt'">
				<TtlAmt>
					<xsl:attribute name="Ccy"><xsl:value-of select="@Ccy"/></xsl:attribute>
					<xsl:value-of select="."/>
				</TtlAmt>
			</xsl:when>
			<xsl:when test="name()='AccptdAmt'"/>
			<xsl:when test="name()='OutsdngAmt'"/>
			<xsl:when test="name()='PdgAmt'"/>
			
			<xsl:when test="name()='OrdrdLineItmsTtlAmt'">
				<LineItmsTtlAmt>
					<xsl:attribute name="Ccy"><xsl:value-of select="@Ccy"/></xsl:attribute>
					<xsl:value-of select="."/>
				</LineItmsTtlAmt>
			</xsl:when>
			<xsl:when test="name()='AccptdLineItmsTtlAmt'"/>
			<xsl:when test="name()='OutsdngLineItmsTtlAmt'"/>
			<xsl:when test="name()='PdgLineItmsTtlAmt'"/>

			<xsl:when test="name()='OrdrdTtlNetAmt'">
				<TtlNetAmt>
					<xsl:attribute name="Ccy"><xsl:value-of select="@Ccy"/></xsl:attribute>
					<xsl:value-of select="."/>
				</TtlNetAmt>
			</xsl:when>
			<xsl:when test="name()='AccptdTtlNetAmt'"/>
			<xsl:when test="name()='OutsdngTtlNetAmt'"/>
			<xsl:when test="name()='PdgTtlNetAmt'"/>

			<xsl:otherwise>
				<xsl:copy >
					<xsl:apply-templates select = "node()|@*"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
  </xsl:template>

  <xsl:template match="@*">
    <xsl:copy>
         <xsl:apply-templates select = "@*"/>
    </xsl:copy>
  </xsl:template>



<!-- Line item template -->
<!--<xsl:template match="LineItmDtls">
  
  <LineItmDtls>
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
    <QtyTlrnce>
      <PlusPct><xsl:value-of select="QtyTlrnce/PlusPct"/></PlusPct>
      <MnsPct><xsl:value-of select="QtyTlrnce/MnsPct"/></MnsPct>
    </QtyTlrnce>
    <xsl:if test="UnitPric">
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
    </xsl:if>
    <xsl:if test="PricTlrnce">
      <PricTlrnce>
        <PlusPct><xsl:value-of select="PricTlrnce/PlusPct"/></PlusPct>
        <MnsPct><xsl:value-of select="PricTlrnce/MnsPct"/></MnsPct>
      </PricTlrnce>
    </xsl:if>
    
    <xsl:apply-templates select="PdctIdr"/>
    
    <xsl:apply-templates select="PdctChrtcs"/>

    <xsl:apply-templates select="PdctCtgy"/>
    
    <xsl:if test="PdctOrgn"><PdctOrgn><xsl:value-of select="PdctOrgn"/></PdctOrgn></xsl:if>
    <xsl:if test="LatstShipmntDt"><LatstShipmntDt><xsl:value-of select="LatstShipmntDt"/></LatstShipmntDt></xsl:if>

    <xsl:apply-templates select="RtgSummry"/>

    <xsl:apply-templates select="Incotrms"/>
    
    <xsl:apply-templates select="Adjstmnt"/>
     
    <TtlAmt>
      <xsl:attribute name="Ccy"><xsl:value-of select="TtlAmt/@Ccy"/></xsl:attribute>
      <xsl:value-of select="TtlAmt"/>
    </TtlAmt>

  </LineItmDtls>
  
</xsl:template>-->


</xsl:stylesheet>