<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="baseline_to_tsu_message_common.xsl"/>

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:param name="tid"/>
<xsl:param name="messageId"/>
<xsl:param name="messageCreationDate"/>
<xsl:param name="bic"/>

<xsl:template match="/">
  <xsl:apply-templates select="bn_tnx_record/narrative_xml/Baseln"/>
</xsl:template>

<!-- Main template -->
<xsl:template match="Baseln">

  <Document>
  <StsXtnsnReq>
    <ReqId>
      <Id><xsl:value-of select="$messageId"/></Id>
      <CreDtTm><xsl:value-of select="$messageCreationDate"/></CreDtTm>
    </ReqId>
    <TxId><Id><xsl:value-of select="$tid"/></Id></TxId>
    <StsToBeXtnded>
      <Sts/>
      <ChngDtTm><xsl:value-of select="$messageCreationDate"/></ChngDtTm>
    </StsToBeXtnded>
  </StsXtnsnReq>
  </Document>
  
</xsl:template>


</xsl:stylesheet>