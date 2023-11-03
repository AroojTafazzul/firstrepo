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
  <InttToPayNtfctn>
    <NtfctnId>
      <Id><xsl:value-of select="$messageId"/></Id>
      <CreDtTm><xsl:value-of select="$messageCreationDate"/></CreDtTm>
    </NtfctnId>
    <TxId><Id><xsl:value-of select="$tid"/></Id></TxId>
	<!-- <SubmitrTxRef/>-->
    <BuyrBk>
      <BIC><xsl:value-of select="BuyrBk/BIC"/></BIC>
    </BuyrBk>
    <SellrBk>
      <BIC><xsl:value-of select="SellrBk/BIC"/></BIC>
    </SellrBk>
    <InttToPay>
      <XpctdPmtDt/>
    </InttToPay>
  </InttToPayNtfctn>
  </Document>

</xsl:template>

</xsl:stylesheet>