<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="baseline_to_tsu_message_common.xsl"/>

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:param name="tid"/>
<xsl:param name="messageId"/>
<xsl:param name="messageCreationDate"/>

<xsl:template match="/">
  <xsl:apply-templates select="tu_tnx_record/narrative_xml/Document/StsXtnsnReqNtfctn"/>
</xsl:template>

<!-- Main template -->
<xsl:template match="StsXtnsnReqNtfctn">

  <Document>
  <StsXtnsnReqRjctn>
    <RjctnId>
      <Id><xsl:value-of select="$messageId"/></Id>
      <CreDtTm><xsl:value-of select="$messageCreationDate"/></CreDtTm>
    </RjctnId>
    <TxId>
      <Id><xsl:value-of select="$tid"/></Id>
    </TxId>
    <SubmitrTxRef>
      <Id><xsl:value-of select="UsrTxRef/Id"/></Id>
      <!-- <IdIssr>
      	<BIC><xsl:value-of select="UsrTxRef/IdIssr/BIC"/></BIC>
      </IdIssr>-->
    </SubmitrTxRef>
    <StsNotToBeXtnded>
    	<Sts><xsl:value-of select="XtndedSts/Sts"/></Sts>
    </StsNotToBeXtnded>
    <RjctnRsn><Desc/></RjctnRsn>
  </StsXtnsnReqRjctn>
  </Document>
  
</xsl:template>

</xsl:stylesheet>