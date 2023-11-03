<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:param name="tid"/>
<xsl:param name="messageId"/>
<xsl:param name="messageCreationDate"/>

<xsl:template match="/">
  <xsl:apply-templates select="tu_tnx_record/narrative_xml/Document/MisMtchAccptncNtfctn"/>
</xsl:template>

<!-- Main template -->
<xsl:template match="MisMtchAccptncNtfctn">

  <Document>
  <RoleAndBaselnRjctn>
    <RjctnId>
      <Id><xsl:value-of select="$messageId"/></Id>
      <CreDtTm><xsl:value-of select="$messageCreationDate"/></CreDtTm>
    </RjctnId>
    <RltdMsgRef>
      <Id><xsl:value-of select="NtfctnId/Id"/></Id>
      <CreDtTm><xsl:value-of select="NtfctnId/CreDtTm"/></CreDtTm>
    </RltdMsgRef>
    <TxId>
      <Id><xsl:value-of select="$tid"/></Id>
    </TxId>
  </RoleAndBaselnRjctn>
  </Document>
  
</xsl:template>

</xsl:stylesheet>