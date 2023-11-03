<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    exclude-result-prefixes="localization">

	<xsl:template name="bank-terms-conditions">
		<div id="tncContent">
			<div id="page_1">
				<p style="font-weight: bold"><xsl:value-of select="localization:getGTPString($language, 'SERVICE_AGREEMENT')" /></p>
				<br/>
				<p style="max-width:900px;"><xsl:value-of select="localization:getGTPString($language, 'PLACEHOLDER_TERMS_CONDITIONS')" /></p>
				<br/>
				<p style="max-width:900px;"><xsl:value-of select="localization:getGTPString($language, 'TERMS_AND_CONDITIONS_1')" /></p>
				<br/>
				<p style="max-width:900px;"><xsl:value-of select="localization:getGTPString($language, 'TERMS_AND_CONDITIONS_2')" /></p>
				<br/>
				<p style="max-width:900px;"><xsl:value-of select="localization:getGTPString($language, 'TERMS_AND_CONDITIONS_3')" /></p>
				<br/>
				<p style="max-width:900px;"><xsl:value-of select="localization:getGTPString($language, 'TERMS_AND_CONDITIONS_4')" /></p>
				<br/>
				<p style="max-width:900px;"><xsl:value-of select="localization:getGTPString($language, 'TERMS_AND_CONDITIONS_5')" /></p>
			</div>
			<br/>
			<div id="page_2">
				<p style="max-width:900px;"><xsl:value-of select="localization:getGTPString($language, 'TERMS_AND_CONDITIONS_6')" /></p>
				<br/>
				<p style="max-width:900px;"><xsl:value-of select="localization:getGTPString($language, 'TERMS_AND_CONDITIONS_7')" /></p>
				<br/>
				<p style="max-width:900px;"><xsl:value-of select="localization:getGTPString($language, 'TERMS_AND_CONDITIONS_8')" /></p>
			</div>
		</div>
	</xsl:template>
	
</xsl:stylesheet>