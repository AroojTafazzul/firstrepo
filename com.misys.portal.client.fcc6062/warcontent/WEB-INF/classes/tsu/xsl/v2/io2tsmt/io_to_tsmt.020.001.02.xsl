<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	exclude-result-prefixes="tools">
	
	<xsl:output method="xml" encoding="UTF-8"/>

	<xsl:param name="tid"/>
	<xsl:param name="tnxId"/>
	<xsl:param name="serviceCode"/>
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Match template -->
	<xsl:template match="io_tnx_record">
		<Document>
			<MisMtchAccptnc>
				<AccptncId>
					<Id><xsl:value-of select="$tnxId"/></Id>
					<CreDtTm><xsl:value-of select="tools:getCurrentTMAFormatDateTime()"/></CreDtTm>
				</AccptncId>
				<TxId>
					<Id><xsl:value-of select="$tid"/></Id>
				</TxId>
				<SubmitrTxRef>
					<Id><xsl:value-of select="$tnxId"/></Id>
				</SubmitrTxRef>
				<DataSetMtchRptRef>
						<Id>
							<xsl:value-of select="dataset_match_report/DataSetMtchRpt/RptId/Id" />
						</Id>
						<CreDtTm>
							<xsl:value-of select="dataset_match_report/DataSetMtchRpt/RptId/CreDtTm" />
						</CreDtTm>
				</DataSetMtchRptRef>
			</MisMtchAccptnc>
		</Document>	
	</xsl:template>	
</xsl:stylesheet>	