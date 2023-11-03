<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
	<!--
   Copyright (c) 2000-2013 Misys,
   All Rights Reserved. 
	-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl" />
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl" />
	<xsl:param name="base_url" />
	<xsl:param name="systemDate" />
	<!-- Get the language code -->
	<xsl:param name="language" />
	<xsl:param name="rundata" />
	<xsl:include href="sg_indemnity_content_fo.xsl" />
	<xsl:template match="/">
 		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" font-family="{$pdfFont}" writing-mode="{$writingMode}">

			<xsl:call-template name="general-layout-master" />
			
			<fo:page-sequence initial-page-number="1"
				master-reference="Section1-ps">
				<!-- Put the name of the bank on the left -->
				<fo:static-content text-align="center" flow-name="xsl-region-start">
					<fo:block font-size="8pt" text-align="center" color="#FFFFFF"
						font-weight="bold" font-family="{$pdfFont}">
						Shipping Guarantee
					</fo:block>
				</fo:static-content>
				<!--Apply sg_content_fo.xsl on sg_tnx_record-->
				<xsl:apply-templates select="child::*[1]" />
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>
