<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	exclude-result-prefixes="tools">

<!-- <xsl:import href="../io2tsmt/io_to_tsmt_common.xsl"/> -->
<xsl:output method="xml" encoding="UTF-8"/>

<xsl:param name="tid"/>
<xsl:param name="tnxId"/>
<xsl:param name="bic"/>

<xsl:template match="/">
  <xsl:apply-templates />
</xsl:template>

<!-- Main template -->
<xsl:template match="ea_tnx_record">

  <Document>
  <StsChngReq>
    <ReqId>
      <Id><xsl:value-of select="$tnxId"/></Id>
      <CreDtTm><xsl:value-of select="tools:getCurrentTMAFormatDateTime()"/></CreDtTm>
    </ReqId>
    <TxId><Id><xsl:value-of select="$tid"/></Id></TxId>
    <SubmitrTxRef><Id><xsl:value-of select="$tid"/></Id></SubmitrTxRef>
    <ReqdSts><Sts>CLSD</Sts></ReqdSts>
    <ReqRsn><Desc><xsl:value-of select="close_comments"/></Desc></ReqRsn>
  </StsChngReq>
  </Document>
  
</xsl:template>


</xsl:stylesheet>