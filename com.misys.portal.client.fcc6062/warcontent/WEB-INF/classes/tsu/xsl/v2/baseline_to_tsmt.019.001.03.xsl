<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--<xsl:import href="baseline_to_tsu_message_common.xsl"/>-->

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:param name="tid"/>
<xsl:param name="messageId"/>
<xsl:param name="messageCreationDate"/>
<xsl:param name="BIC"/>

<xsl:template match="/">
  <xsl:apply-templates select="bn_tnx_record/narrative_xml"/>
</xsl:template>

<!-- Main template -->
<xsl:template match="narrative_xml">

  <Document>
  <InitlBaselnSubmissn>
    <SubmissnId>
      <Id><xsl:value-of select="$messageId"/></Id>
      <CreDtTm><xsl:value-of select="$messageCreationDate"/></CreDtTm>
    </SubmissnId>
    <TxId><Id><xsl:value-of select="$tid"/></Id></TxId>
    <SubmitrTxRef>
      <Id><!--<xsl:value-of select="SubmitrBaselnId/Id"/>--></Id>
      <IdIssr>
        <BIC><xsl:value-of select="$BIC"/></BIC>
      </IdIssr>
    </SubmitrTxRef>
    <Instr>
    	<Tp/>
    </Instr>
    
    <xsl:apply-templates select="Baseln"/>

	<BuyrBkCtctPrsn>
		<Nm/>
	</BuyrBkCtctPrsn>
		
  </InitlBaselnSubmissn>
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

			<xsl:when test="name()='OrdrdTtlAmt'">
				<TtlAmt>
					<xsl:attribute name="Ccy"><xsl:value-of select="@Ccy"/></xsl:attribute>
					<xsl:value-of select="."/>
				</TtlAmt>
			</xsl:when>
			<xsl:when test="name()='AccptdTtlAmt'"/>
			<xsl:when test="name()='OutsdngTtlAmt'"/>
			<xsl:when test="name()='PdgTtlAmt'"/>
			
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

			<xsl:when test="name()='SubmitrBaselnId'">
				<SubmitrBaselnId>
					<Id/>
					<Vrsn/>
					<Submitr>
						<BIC><xsl:value-of select="$BIC"/></BIC>
					</Submitr>
				</SubmitrBaselnId>
			</xsl:when>

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

</xsl:stylesheet>