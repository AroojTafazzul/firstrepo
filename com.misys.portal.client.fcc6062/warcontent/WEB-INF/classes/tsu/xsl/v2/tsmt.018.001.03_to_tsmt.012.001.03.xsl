<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!--
   This stylesheet extracts the baseline from an InitialBaselineSubmission message.
-->

<xsl:stylesheet xmlns:xsl = "http://www.w3.org/1999/XSL/Transform" version = "1.0">
	<xsl:output method = "xml" indent = "yes"/>

	<xsl:param name="tid"/>
	<xsl:param name="messageId"/>
	<xsl:param name="messageCreationDate"/>
	<xsl:param name="bic"/>

	<xsl:template match="/">
  		<xsl:apply-templates select="tu_tnx_record/narrative_xml/Document/FullPushThrghRpt"/>
	</xsl:template>


	<!-- Main template -->
	<xsl:template match="FullPushThrghRpt">
		<Document>
		<BIC><xsl:value-of select="$bic"/></BIC>
		<BaselnReSubmissn>
			<SubmissnId>
				<Id><xsl:value-of select="$messageId"/></Id>
				<CreDtTm><xsl:value-of select="$messageCreationDate"/></CreDtTm>
			</SubmissnId>
			<TxId><Id><xsl:value-of select="$tid"/></Id></TxId>
			<SubmitrTxRef>
				<Id/>
			</SubmitrTxRef>

			<Baseln>
				<xsl:apply-templates select="PushdThrghBaseln/*"/>
			</Baseln>
			
			<xsl:if test="BuyrCtctPrsn">
				<xsl:apply-templates select="BuyrCtctPrsn"/>
			</xsl:if>
			<xsl:if test="SellrCtctPrsn">
				<xsl:apply-templates select="SellrCtctPrsn"/>
			</xsl:if>
			<xsl:if test="SellrBkCtctPrsn">
				<xsl:apply-templates select="SellrBkCtctPrsn"/>
			</xsl:if>
			<xsl:if test="BuyrBkCtctPrsn">
				<xsl:apply-templates select="BuyrBkCtctPrsn"/>
			</xsl:if>
			<xsl:if test="OthrBkCtctPrsn">
				<xsl:apply-templates select="OthrBkCtctPrsn"/>
			</xsl:if>
			
		</BaselnReSubmissn>
		</Document>
	</xsl:template>

	<!-- Override Submitter BIC with the BIC of the bank replying -->
	<xsl:template match="*[local-name() = 'Submitr' and local-name(..) = 'SubmitrBaselnId']">
		<Submitr>
			<BIC><xsl:value-of select="$bic"/></BIC>
		</Submitr>
	</xsl:template>

	<xsl:template match="PushdThrghBaseln/*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="node() | @*">
		<xsl:copy>
			<xsl:apply-templates select = "node()|@*"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>