<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet [
    <!ENTITY nbsp "&#160;">
]>
<!--
   Copyright (c) 2000-2011 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    xmlns:colorprovider="xalan://com.misys.portal.common.resources.ColorResourceProvider"
    xmlns:java="http://xml.apache.org/xalan/java"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
    exclude-result-prefixes="localization">    
    <xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
    <xsl:param name="base_url"/>
    <xsl:param name="systemDate"/>
    <!-- Get the language code -->
    <xsl:param name="language"/>
    <!-- <xsl:param name="rundata"/> -->
    
    <xsl:param name="search_date"/>
    <xsl:param name="login"/>
    <xsl:param name="reference"/>
    <xsl:param name="actioncode"/>
    
    <xsl:param name="company"/>
    <xsl:param name="result"/>
    <xsl:param name="ipaddress"/>
    <xsl:param name="user"/>
    <xsl:param name="operation"/>
    
    <xsl:param name="isbank"/>

    <xsl:include href="audit_content_fo.xsl"/>
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
                <!--Apply po_content_fo.xsl on po_tnx_record-->
                <xsl:apply-templates select="child::*[1]"/>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
</xsl:stylesheet>
