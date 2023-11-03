<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="baseline_to_tsu_message_common.xsl"/>

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:param name="tid"/>
<xsl:param name="messageId"/>
<xsl:param name="messageCreationDate"/>

<xsl:template match="/">
  <xsl:apply-templates select="tu_tnx_record/narrative_xml/Document/DltaRpt"/>
</xsl:template>

<!-- Main template -->
<xsl:template match="DltaRpt">

  <Document>
  <AmdmntAccptnc>
    <AccptncId>
      <Id><xsl:value-of select="$messageId"/></Id>
      <CreDtTm><xsl:value-of select="$messageCreationDate"/></CreDtTm>
    </AccptncId>
    <TxId>
      <Id><xsl:value-of select="$tid"/></Id>
    </TxId>
    <SubmitrTxRef>
      <Id><xsl:value-of select="SubmitrPropsdBaselnRef/Id"/></Id>
      <!-- <IdIssr>
      	<BIC><xsl:value-of select="SubmitrPropsdBaselnRef/Submitr/BIC"/></BIC>
      </IdIssr>-->
    </SubmitrTxRef>
    <DltaRptRef>
    	<Id><xsl:value-of select="RptId/Id"/></Id>
    	<CreDtTm><xsl:value-of select="RptId/CreDtTm"/></CreDtTm>
    </DltaRptRef>
    <AccptdAmdmntNb>
    	<Nb><xsl:value-of select="AmdmntNb/Nb"/></Nb>
    </AccptdAmdmntNb>
  </AmdmntAccptnc>
  </Document>
  
</xsl:template>

</xsl:stylesheet>