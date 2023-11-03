<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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
  <BaselnReSubmissn>
    <SubmissnId>
      <Id><xsl:value-of select="$messageId"/></Id>
      <CreDtTm><xsl:value-of select="$messageCreationDate"/></CreDtTm>
    </SubmissnId>
    <TxId><Id><xsl:value-of select="$tid"/></Id></TxId>
    <SubmitrTxRef>
      <Id><!--<xsl:value-of select="SubmitrBaselnId/Id"/>--></Id>
      <IdIssr>
        <BIC><!--<xsl:value-of select="Submitr/BIC"/>--></BIC>
      </IdIssr>
    </SubmitrTxRef>
    
    <xsl:apply-templates select="Baseln"/>

  </BaselnReSubmissn>
  </Document>
  
</xsl:template>

    <xsl:template match="Baseln">
      <xsl:copy>
        <xsl:apply-templates select="node()|@*"/>
      </xsl:copy>
    </xsl:template>

  <xsl:template match="node() | @*">
    <xsl:copy>
         <xsl:apply-templates select = "node()|@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*">
    <xsl:copy>
         <xsl:apply-templates select = "@*"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>