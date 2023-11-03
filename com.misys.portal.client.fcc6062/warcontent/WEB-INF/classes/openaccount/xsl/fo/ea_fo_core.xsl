<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<!--
   Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:xd="http://www.pnp-software.com/XSLTdoc">
	
    <xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
    <xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
    
    <xd:doc>
    	<xd:param name="systemDate">The current generated date shown in the PDF</xd:param>
   	 	<xd:param name="language">Language code in lower case.</xd:param>
   	 	<xd:param name="base_url">the url with will generate the form</xd:param>
    	<xd:param name="rundata">the data will be shown in pdf</xd:param>
    </xd:doc>
    <xsl:param name="base_url"/>
    <xsl:param name="systemDate"/>
	
    <!-- Get the language code -->
    <xsl:param name="language"/>
    <xsl:param name="rundata"/>    
    <xsl:include href="ea_content_fo.xsl"/>
     <xd:doc>
    	<xd:short>Sets layout of Pdf file for EA Screen</xd:short>
    	<xd:detail>
    		This templates sets layout for the PDF file for EA screen,It adds various attributes of margin of pdf(top,bottom.right.left) and 
    		fill it with given selected value.This templates also processes first page differently with rest of the page.
    	</xd:detail>
    </xd:doc>
    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="Section1-pm"
                    page-height="{$pageHeight}" page-width="{$pageWidth}">
                    <xsl:attribute name="margin">
                        <xsl:value-of select="number($pdfMargin)"/>pt</xsl:attribute>
                    <fo:region-body>
                        <xsl:attribute name="margin">
                            <xsl:value-of select="number($pdfMargin)"/>pt</xsl:attribute>
                    </fo:region-body>
                    <fo:region-after>
                        <xsl:attribute name="extent">
                            <xsl:value-of select="number(number($pdfMargin) div 2)"/>pt</xsl:attribute>
                    </fo:region-after>
                </fo:simple-page-master>
                <!--The processing of the first page is different from the others: no bank's adress on the rest of the pages-->
                <fo:simple-page-master master-name="first1"
                    page-height="{$pageHeight}" page-width="{$pageWidth}">
                    <xsl:attribute name="margin-right">
                        <xsl:value-of select="number($pdfMargin)"/>pt</xsl:attribute>
                    <xsl:attribute name="margin-left">
                        <xsl:value-of select="number($pdfMargin)"/>pt</xsl:attribute>
                    <xsl:attribute name="margin-bottom">
                        <xsl:value-of select="number($pdfMargin)"/>pt</xsl:attribute>
                    <xsl:attribute name="margin-top">
                        <xsl:value-of select="number($pdfMargin)*2"/>pt</xsl:attribute>
                    <fo:region-body>
                        <xsl:attribute name="margin-right">
                            <xsl:value-of select="number($pdfMargin)"/>pt</xsl:attribute>
                        <xsl:attribute name="margin-left">
                            <xsl:value-of select="number($pdfMargin)"/>pt</xsl:attribute>
                        <xsl:attribute name="margin-bottom">
                            <xsl:value-of select="number($pdfMargin)"/>pt</xsl:attribute>
                        <xsl:attribute name="margin-top">
                            <xsl:value-of select="number($pdfMargin)*3"/>pt</xsl:attribute>
                    </fo:region-body>
                    <fo:region-before>
                        <xsl:attribute name="extent">
                            <xsl:value-of select="number($pdfMargin)*2"/>pt</xsl:attribute>
                    </fo:region-before>
                    <fo:region-after>
                        <xsl:attribute name="extent">
                            <xsl:value-of select="number(number($pdfMargin) div 2)"/>pt</xsl:attribute>
                    </fo:region-after>
                </fo:simple-page-master>
                <fo:page-sequence-master master-name="Section1-ps">
                    <fo:repeatable-page-master-alternatives>
                        <fo:conditional-page-master-reference
                            master-reference="first1" page-position="first"/>
                        <fo:conditional-page-master-reference
                            master-reference="Section1-pm" page-position="rest"/>
                    </fo:repeatable-page-master-alternatives>
                </fo:page-sequence-master>
            </fo:layout-master-set>
            <fo:page-sequence initial-page-number="1" master-reference="Section1-ps">
                <!--Apply io_content_fo.xsl on io_tnx_record-->
                <xsl:apply-templates select="child::*[1]"/>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
</xsl:stylesheet>
