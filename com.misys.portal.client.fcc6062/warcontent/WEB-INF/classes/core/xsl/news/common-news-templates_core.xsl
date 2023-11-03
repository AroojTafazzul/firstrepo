<?xml version="1.0" encoding="UTF-8"?>
<!-- ########################################################## Templates 
	that are common to forms on the customer side. This stylesheet should be 
	the first thing imported by customer-side XSLTs. This should be the first 
	include for forms on the customer side. Copyright (c) 2000-2008 Misys (http://www.misys.com), 
	All Rights Reserved. version: 1.0 date: 12/03/08 author: Cormac Flynn email: 
	cormac.flynn@misys.com ########################################################## -->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	exclude-result-prefixes="localization">

	<xsl:param name="displaymode">
		view
	</xsl:param>
	<xsl:variable name="fileTypeImgPathPrefix"><xsl:value-of select="$contextPath"/>/content/images/file_</xsl:variable> 
   <xsl:variable name="docImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>doc.gif</xsl:variable> 
   <xsl:variable name="textImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>txt.gif</xsl:variable> 
   <xsl:variable name="pdfImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>pdf.gif</xsl:variable> 
   <xsl:variable name="gifImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>gif.gif</xsl:variable> 
   <xsl:variable name="zipImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>zip.gif</xsl:variable> 
   <xsl:variable name="extImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>ext.gif</xsl:variable>

	<!-- Common includes. -->


	<xsl:template name="upload-form-news">
		<div>
			<div dojoType="dijit.form.Form" id="downloadfilesnews-attachment" class="form" name="downloadfilesnews-attachment"
				method="POST" enctype="multipart/form-data"><xsl:attribute name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/GTPDownloadScreen</xsl:attribute>&nbsp;
				<input type="hidden" name="attachment_type" id="attachment_type" value="news"/>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="get-image-icon">
	   <!--
	    Simple template to returns an appropriate image based on the file extension, otherwise we use
	    a default one
	    -->
	   <xsl:param name="fileName"/>
	   
	   <xsl:variable name="fileType" select="substring-after($fileName,'.')"/>
	   <xsl:choose>
	    <xsl:when test="$fileType = 'doc'"><xsl:value-of select="$docImage"/></xsl:when>
	    <xsl:when test="$fileType = 'txt'"><xsl:value-of select="$textImage"/></xsl:when>
	    <xsl:when test="$fileType = 'pdf'"><xsl:value-of select="$pdfImage"/></xsl:when>
	    <xsl:when test="$fileType = 'gif'"><xsl:value-of select="$gifImage"/></xsl:when>
	    <xsl:when test="$fileType = 'zip'"><xsl:value-of select="$zipImage"/></xsl:when>
	    <xsl:otherwise><xsl:value-of select="$extImage"/></xsl:otherwise>
	   </xsl:choose>
	 
	 </xsl:template>


</xsl:stylesheet>