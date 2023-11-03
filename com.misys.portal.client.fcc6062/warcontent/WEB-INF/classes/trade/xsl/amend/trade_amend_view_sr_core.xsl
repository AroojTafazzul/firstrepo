<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Import Letter of Credit (LC) Form, Customer Side.
 
 Note: Templates beginning with lc_ are in lc_common.xsl

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

##########################################################
-->
<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp "&#160;"> 
]>

<xsl:stylesheet 
  version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:common="http://exslt.org/common"
	exclude-result-prefixes="localization utils common">

	<!-- 
		Global Parameters.
		These are used in the imported XSL, and to set global params in the JS 
	-->
	<xsl:param name="rundata"/>
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="product-code">SR</xsl:param>
	<xsl:param name="displaymode">view</xsl:param>
 	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="collaborationmode">none</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action">
		<xsl:value-of select="$contextPath"/>
		<xsl:value-of select="$servletPath"/>/screen/LetterOfCreditScreen</xsl:param>
	<xsl:param name="featureid"/>
	<xsl:param name="show-eucp">N</xsl:param>

	<!-- Global Imports. -->
	<xsl:include href="../../../trade/xsl/amend/trade_amend_report.xsl" />

	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	
	<xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz</xsl:variable>
   	<xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
	<xsl:variable name="lower-product-code" select="translate($product-code, $upper, $lower)"/>
	
	<xsl:variable name="tnx_record">/<xsl:value-of select="$lower-product-code"/>_tnx_record</xsl:variable>
		
	<xsl:variable name="tnx_path" select="/sr_tnx_record" />
	<xsl:variable name="prev_path" select="/sr_tnx_record/org_previous_file/sr_tnx_record" />
	
	<xsl:template match="/">
		<xsl:apply-templates select="sr_tnx_record"/>		
	</xsl:template>


</xsl:stylesheet>