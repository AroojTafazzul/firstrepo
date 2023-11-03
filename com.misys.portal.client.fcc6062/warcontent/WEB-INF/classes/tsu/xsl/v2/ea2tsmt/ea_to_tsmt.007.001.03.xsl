<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	exclude-result-prefixes="tools">

	<!-- <xsl:import href="../io2tsmt/io_to_tsmt_common.xsl"/> -->
	<xsl:output method="xml" encoding="UTF-8" />

	<xsl:param name="tid" />
	<xsl:param name="tnxId" />
	<xsl:param name="bic" />
	<xsl:param name="messageId" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>

	<!-- Main template -->
	<xsl:template match="ea_tnx_record">

		<Document>
			<AmdmntRjctn>
				<RjctnId>
					<Id>
						<xsl:value-of select="$tnxId" />
					</Id>
					<CreDtTm>
						<xsl:value-of select="tools:getCurrentTMAFormatDateTime()" />
					</CreDtTm>
				</RjctnId>
				<TxId>
					<Id>
						<xsl:value-of select="$tid" />
					</Id>
				</TxId>
				<SubmitrTxRef>
					<Id>
						<xsl:value-of select="$tnxId" />
					</Id>
				</SubmitrTxRef>
				<DltaRptRef>
					<xsl:if test="delta_report/DltaRpt/RptId/Id != ''">
						<Id>
							<xsl:value-of select="delta_report/DltaRpt/RptId/Id" />
						</Id>
					</xsl:if>
					<xsl:if test="delta_report/DltaRpt/RptId/CreDtTm != ''">
						<CreDtTm>
							<xsl:value-of select="delta_report/DltaRpt/RptId/CreDtTm"/>
						</CreDtTm>
					</xsl:if>
				</DltaRptRef>
				<RjctdAmdmntNb>
					<xsl:if test="delta_report/DltaRpt/AmdmntNb/Nb != ''">
						<Nb>
							<xsl:value-of select="delta_report/DltaRpt/AmdmntNb/Nb" />
						</Nb>
					</xsl:if>
				</RjctdAmdmntNb>
				<RjctnRsn>
					<GblRjctnRsn>
						<xsl:if test="free_format_text != ''">
							<Desc>
								<xsl:value-of select="free_format_text" />
							</Desc>
						</xsl:if>
					</GblRjctnRsn>
				</RjctnRsn>
			</AmdmntRjctn>
		</Document>
	</xsl:template>
</xsl:stylesheet>