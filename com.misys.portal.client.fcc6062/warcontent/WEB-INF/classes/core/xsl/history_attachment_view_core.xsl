<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
	exclude-result-prefixes="localization">

	<!--
   Copyright (c) 2000-2010 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
	-->
	
	
	<xsl:output method="html" indent="no"/>
	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="contextPath"/>
	<xsl:param name="servletPath"/>
	
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="attachment_list">
	 
		<xsl:call-template name="files-table">
		<xsl:with-param name="existing-attachments" select="attachment"/>
		</xsl:call-template>
     <div class="widgetContainer">
	   <div dojoType="dijit.form.Form" name="downloadfiles" id="downloadfiles" class="form" method="POST"
			enctype="multipart/form-data">
			<xsl:attribute name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/GTPDownloadScreen</xsl:attribute>
			&nbsp;
		</div>
     </div>
	</xsl:template>

   <xsl:template name="files-table">
    <!-- Existing attachments -->
    <xsl:param name="existing-attachments"/>    
	<div style="overflow:scroll;height:250px;width:100%;overflow:auto">	
     <!-- Table of attached items. -->
     <table border="0" cellpadding="0" cellspacing="0" class="attachments">
     <xsl:attribute name="id">files_master_table</xsl:attribute>
      <xsl:attribute name="summary">
       <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ATTACHMENTS_SUMMARY')"/>
      </xsl:attribute>
      <xsl:if test="count($existing-attachments) = 0">
       <xsl:attribute name="style">display:none;</xsl:attribute>
      </xsl:if>
      <thead>
       <tr>
        <th class="small-tblheader" scope="col">&nbsp;</th>
        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILES_COLUMN_TITLE')"/></th>
        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILES_COLUMN_FILE')"/></th>
        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILES_COLUMN_STATUS')"/></th>
       </tr>
      </thead>
      <tbody>
		<xsl:attribute name="id">files_table_details</xsl:attribute>      
        <!-- Insert first row for HTML validation purposes and JS. -->
        <xsl:choose>
         <xsl:when test="count($existing-attachments) = 0"><tr style="display:none;"><td/><td/><td/><td/><td/></tr></xsl:when>
         <xsl:otherwise>
         <xsl:for-each select="$existing-attachments">
          <tr>
           <xsl:attribute name="id">file_row_<xsl:value-of select="attachment_id"/></xsl:attribute>
           <xsl:call-template name="file-upload-table-row">
            <xsl:with-param name="nbElement" select="attachment_id"/>
            <xsl:with-param name="existing">Y</xsl:with-param>
           </xsl:call-template>
          </tr>
         </xsl:for-each>
        </xsl:otherwise>
       </xsl:choose>
      </tbody>
     </table>
     </div>
	 <!-- Disclaimer -->
	 <p class="empty-list-notice">
		<xsl:attribute name="id">files-notice</xsl:attribute> 	 
	  <xsl:if test="count($existing-attachments)!=0">
	   <xsl:attribute name="style">display:none</xsl:attribute>
	  </xsl:if>
	  <xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_NO_FILE_ITEM')"/>
	 </p>
  </xsl:template>

  <xsl:template name="file-upload-table-row">
   <xsl:param name="existing">N</xsl:param>
   <xsl:param name="nbElement"/>
   
   <td>
    <xsl:if test="$existing='Y'"><xsl:attribute name="class">existing-attachment</xsl:attribute></xsl:if>
    <img width="17" height="18">
     <xsl:attribute name="src">
      <xsl:call-template name="get-image-icon">
       <xsl:with-param name="fileName"><xsl:value-of select="file_name"/></xsl:with-param>
      </xsl:call-template>
     </xsl:attribute>
     <xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_FILETYPE')"/></xsl:attribute>
     <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_FILETYPE')"/></xsl:attribute>
     <xsl:attribute name="id">files_fileimg_<xsl:value-of select="$nbElement"/></xsl:attribute>
    </img>
   </td>
   <td>
    <xsl:if test="$existing='Y'"><xsl:attribute name="class">existing-attachment</xsl:attribute></xsl:if>
    <xsl:if test="title">
      <a href="javascript:void(0)">
       <xsl:attribute name="onclick">misys.downloadFile('<xsl:value-of select="$nbElement"/>');</xsl:attribute>
       <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_TITLE_ATTACHMENT_DOWNLOAD')"/></xsl:attribute>
       <xsl:value-of select="title"/>
      </a>
    </xsl:if>
   </td>
   <td>
    <xsl:if test="$existing='Y'"><xsl:attribute name="class">existing-attachment</xsl:attribute></xsl:if>
    <xsl:if test="file_name[.!= '']">
      <!-- <a href="javascript:void(0)">
       <xsl:attribute name="onclick">misys.downloadFile('<xsl:value-of select="$nbElement"/>');</xsl:attribute>
       <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_TITLE_ATTACHMENT_DOWNLOAD')"/></xsl:attribute> -->
       <xsl:value-of select="file_name"/>
     <!--  </a> -->
    </xsl:if>
   </td>
   <td>
    <xsl:if test="$existing='Y'"><xsl:attribute name="class">existing-attachment</xsl:attribute></xsl:if>
    <xsl:if test="tnx_stat_code[.!= '']">
    <!--   <a href="javascript:void(0)">
       <xsl:attribute name="onclick">misys.downloadFile('<xsl:value-of select="$nbElement"/>');</xsl:attribute>
       <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_TITLE_ATTACHMENT_DOWNLOAD')"/></xsl:attribute> -->
       <xsl:choose>
       	<xsl:when test="tnx_stat_code[.='04'] and file_act and file_act[.='Y']">
	    	<xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_DELIVERY_CHANNEL_FILEACT_ACK')" />
	    </xsl:when>
	    <xsl:otherwise>
	    	<xsl:value-of select="localization:getDecode($language, 'N004', tnx_stat_code)" />
	    </xsl:otherwise>
       </xsl:choose>
     <!--  </a> -->
    </xsl:if>
   </td>
  </xsl:template>


  <xsl:template name="get-image-icon">
   <!--
    Simple template to returns an appropriate image based on the file extension, otherwise we use
    a default one
    -->
   <xsl:param name="fileName"/>
   
   <xsl:variable name="fileType" select="substring-after($fileName,'.')"/>
   <xsl:variable name="fileTypeImgPathPrefix"><xsl:value-of select="$contextPath"/>/content/images/file_</xsl:variable>
   <xsl:variable name="docImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>doc.gif</xsl:variable>
   <xsl:variable name="docxImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>docx.gif</xsl:variable>
   <xsl:variable name="xlsxImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>xlsx.gif</xsl:variable>
   <xsl:variable name="jpegImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>jpeg.gif</xsl:variable>
   <xsl:variable name="pngImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>png.gif</xsl:variable>
   <xsl:variable name="xlsImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>xls.gif</xsl:variable>  
   <xsl:variable name="textImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>txt.gif</xsl:variable> 
   <xsl:variable name="pdfImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>pdf.gif</xsl:variable> 
   <xsl:variable name="gifImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>gif.gif</xsl:variable> 
   <xsl:variable name="zipImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>zip.gif</xsl:variable> 
   <xsl:variable name="extImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>ext.gif</xsl:variable>
   <xsl:variable name="csvImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>csv.gif</xsl:variable> 
   
   <xsl:choose>
    <xsl:when test="$fileType = 'doc'"><xsl:value-of select="$docImage"/></xsl:when>
    <xsl:when test="$fileType = 'docx'"><xsl:value-of select="$docxImage"/></xsl:when>
    <xsl:when test="$fileType = 'xlsx'"><xsl:value-of select="$xlsxImage"/></xsl:when>
    <xsl:when test="$fileType = 'xls'"><xsl:value-of select="$xlsImage"/></xsl:when>
    <xsl:when test="$fileType = 'jpeg'"><xsl:value-of select="$jpegImage"/></xsl:when>
    <xsl:when test="$fileType = 'png'"><xsl:value-of select="$pngImage"/></xsl:when>
    <xsl:when test="$fileType = 'txt'"><xsl:value-of select="$textImage"/></xsl:when>
    <xsl:when test="$fileType = 'pdf'"><xsl:value-of select="$pdfImage"/></xsl:when>
    <xsl:when test="$fileType = 'gif'"><xsl:value-of select="$gifImage"/></xsl:when>
    <xsl:when test="$fileType = 'zip'"><xsl:value-of select="$zipImage"/></xsl:when>
    <xsl:when test="$fileType = 'csv'"><xsl:value-of select="$csvImage"/></xsl:when>
    <xsl:otherwise><xsl:value-of select="$extImage"/></xsl:otherwise>
   </xsl:choose>
  </xsl:template>

</xsl:stylesheet>