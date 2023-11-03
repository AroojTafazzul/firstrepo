<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<!-- Copyright (c) 2006-2013 Misys , All Rights Reserved -->

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:fo="http://www.w3.org/1999/XSL/Format" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
		<xsl:import href="../../../core/xsl/fo/export_pdf_summary.xsl"/>
	<xsl:param name="fop1.extensions" select="1"></xsl:param>
	<xsl:param name="base_url"/>
	<xsl:param name="systemDate"/>

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="rundata" />
	
	
	<xsl:template match="/">
		
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>

				<!--The processing of the first page is different from the others: no bank's adress on the rest of the pages-->
				<fo:simple-page-master master-name="first1" margin-right="30.0pt" margin-left="30.0pt" margin-bottom="36.6pt" margin-top="36.6pt" page-height="841.9pt" page-width="595.3pt">
					<fo:region-body margin-bottom="50.0pt" margin-top="50.0pt"/>
					<fo:region-before extent="100.0pt"/>
					<fo:region-after extent="36.6pt"/>
				</fo:simple-page-master>

				<fo:simple-page-master master-name="Section1-pm" margin-right="30.0pt" margin-left="30.0pt" margin-bottom="36.6pt" margin-top="36.6pt" page-height="841.9pt" page-width="595.3pt">
					<!--fo:region-before extent="100.0pt"/-->
					<fo:region-body margin-bottom="50.0pt" margin-top="20.0pt"/>
					<fo:region-after extent="36.6pt"/>
				</fo:simple-page-master>

				<xsl:apply-templates select="/root/record" mode="sections"/>

			</fo:layout-master-set>
		
		<xsl:apply-templates select="/root/record" mode="bodies"/>

		</fo:root>
	</xsl:template>
	
	<xsl:template match="record" mode="sections">
		<fo:page-sequence-master>
			<xsl:attribute name="master-name">
				<xsl:value-of select="@section"/>
			</xsl:attribute>
			<fo:repeatable-page-master-alternatives>
				<fo:conditional-page-master-reference master-reference="first1" page-position="first"/>
				<fo:conditional-page-master-reference master-reference="Section1-pm" page-position="rest"/>
			</fo:repeatable-page-master-alternatives>
		</fo:page-sequence-master>
	</xsl:template>


	<xsl:template match="record" mode="bodies">
		<fo:page-sequence initial-page-number="1">
			<xsl:attribute name="master-reference">
				<xsl:value-of select="@section"/>
			</xsl:attribute>

		<!-- <xsl:choose> -->
				<!-- <xsl:when test="child::*[1]/tnx_type_code='15' and child::*[1]/prod_stat_code='12'"> -->
					<xsl:apply-templates select="child::*[1]" mode="summary"/>
				<!-- </xsl:when> -->
				<!-- <xsl:otherwise>
					<xsl:apply-templates select="child::*[1]"/>
				</xsl:otherwise> -->
			<!-- </xsl:choose> -->
		
		</fo:page-sequence>
	</xsl:template>

</xsl:stylesheet>
