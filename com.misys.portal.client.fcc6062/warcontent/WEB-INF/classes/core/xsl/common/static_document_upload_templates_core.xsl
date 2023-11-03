<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Implementation of generic templates for the attachment and uploading of files, with a 
transaction.

Global variables referenced in these templates
 $main-form-name

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      24/01/11
author:    Gilles Weber
email:     gilles.weber@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
    exclude-result-prefixes="localization">
<xsl:variable name="fileTypeImgPathPrefix"><xsl:value-of select="$contextPath"/>/content/images/file_</xsl:variable> 
<xsl:variable name="docImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>doc.gif</xsl:variable> 
<xsl:variable name="textImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>txt.gif</xsl:variable> 
<xsl:variable name="pdfImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>pdf.gif</xsl:variable> 
<xsl:variable name="gifImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>gif.gif</xsl:variable> 
<xsl:variable name="zipImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>zip.gif</xsl:variable> 
<xsl:variable name="extImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>ext.gif</xsl:variable>  
    
  <xsl:template name="static-document">
   <!-- <xsl:param name="max-files">5</xsl:param>-->
   <xsl:param name="existing-static-document"/>
   <xsl:param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:param>
   <xsl:param name="add-button-label"/>
   <xsl:param name="add-button-id">staticDocumentAddButton</xsl:param>
   <xsl:param name="static-document-field-id"/>
   <xsl:param name="static-document-field-label"/>
   <xsl:param name="document-id-field-id"/>
   <!-- <xsl:param name="attachment-group"></xsl:param>-->
   <xsl:choose>
    <xsl:when test="$displaymode='view' and $mode = 'DRAFT'">
     <!-- Don't show the file details for the draft view mode, but do in all other cases -->
    </xsl:when>
    <xsl:otherwise>
    <xsl:choose>
    <!-- Only display attachments in general view mode, and when the collaborationmode is 'bank'-->
    
    <xsl:when test="$displaymode='view'">
    <!-- <xsl:if test="count($existing-attachments) > 0">
     <div class="attachments-container widgetContainer">
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend"><xsl:value-of select="$legend"/></xsl:with-param>
       <xsl:with-param name="legend-type">
        <xsl:choose>
         <xsl:when test="$displaymode='view' and $mode!='UNSIGNED'">indented-header</xsl:when>
         <xsl:otherwise>toplevel-header</xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="content">
        <xsl:call-template name="files-table">
         <xsl:with-param name="existing-attachments" select="$existing-attachments"/>
         <xsl:with-param name="attachment-group" select="$attachment-group"/>
        </xsl:call-template>
       </xsl:with-param>
      </xsl:call-template>
      <div id="fileUploadFields" style="display:none">
       <xsl:call-template name="form-wrapper">
		<xsl:with-param name="name">sendfiles</xsl:with-param>
		<xsl:with-param name="enctype">multipart/form-data</xsl:with-param>
		<xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/GTPUploadScreen</xsl:with-param>
		<xsl:with-param name="override-displaymode">edit</xsl:with-param>
		<xsl:with-param name="parse-widgets">N</xsl:with-param>
		<xsl:with-param name="content">
		 <div>
		  <xsl:call-template name="hidden-field">
		   <xsl:with-param name="name">attachmentid</xsl:with-param>
		   <xsl:with-param name="value"><xsl:value-of select="attachment_id"/></xsl:with-param>
		  </xsl:call-template> 
		  <xsl:call-template name="hidden-field">
		   <xsl:with-param name="name">att_ref_id</xsl:with-param>
		   <xsl:with-param name="value"><xsl:value-of select="ref_id"/></xsl:with-param>
		  </xsl:call-template>
		  <xsl:call-template name="hidden-field">
		   <xsl:with-param name="name">att_tnx_id</xsl:with-param>
		   <xsl:with-param name="value"><xsl:value-of select="tnx_id"/></xsl:with-param>
		  </xsl:call-template>
		  <xsl:call-template name="hidden-field">
		   <xsl:with-param name="name">identifier</xsl:with-param>
		   <xsl:with-param name="value"></xsl:with-param>
		  </xsl:call-template>
		  <xsl:call-template name="hidden-field">
		   <xsl:with-param name="name">group</xsl:with-param>
		   <xsl:with-param name="value"></xsl:with-param>
		  </xsl:call-template>
		  <xsl:call-template name="hidden-field">
		   <xsl:with-param name="name">operation</xsl:with-param>
		   <xsl:with-param name="value">UPLOAD</xsl:with-param>
		  </xsl:call-template>
		  <xsl:call-template name="hidden-field">
		   <xsl:with-param name="name">max-files</xsl:with-param>
		   <xsl:with-param name="value"><xsl:value-of select="$max-files"/></xsl:with-param>
		  </xsl:call-template>
		 </div>
		</xsl:with-param>
       </xsl:call-template>
      </div>
     </div>
     </xsl:if>-->
    </xsl:when>
    <xsl:otherwise>
     <!-- <div class="main-form">
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend"><xsl:value-of select="$legend"/></xsl:with-param>
       <xsl:with-param name="content">-->
        <!-- <div class="widgetContainer">
         <xsl:call-template name="files-table">
          <xsl:with-param name="max-attachments" select="$max-files"/>
          <xsl:with-param name="existing-attachments" select="$existing-attachments"></xsl:with-param>
	 	 <xsl:with-param name="attachment-group" select="$attachment-group"/>         
         </xsl:call-template>
        </div>-->
       	<xsl:call-template name="input-field">
	     <xsl:with-param name="label" select="$static-document-field-label"/>
	     <xsl:with-param name="name" select="$static-document-field-id"/>
	     <xsl:with-param name="size">40</xsl:with-param>
	     <xsl:with-param name="maxsize">40</xsl:with-param>
	     <xsl:with-param name="button-type">download-static-document</xsl:with-param>
	    </xsl:call-template>
        <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name" select="$document-id-field-id"/>
	    </xsl:call-template>
        
       	<xsl:call-template name="row-wrapper">
			<xsl:with-param name="content">
	          <button dojoType="dijit.form.Button" id="{$add-button-id}" type="button" onclick="misys.openStaticDocumentDialog('{$static-document-field-id}')">
	           <!-- <xsl:attribute name="value"><xsl:value-of select="$add-button-label"/></xsl:attribute>-->
	           <xsl:value-of select="localization:getGTPString($language, $add-button-label)"/>
	          </button>
	        </xsl:with-param>
    	</xsl:call-template>
    
       <!-- <xsl:choose>
       <xsl:when test="$attachment-group = ''"> -->
       <xsl:call-template name="static-document-dialog"/>
       
   </xsl:otherwise>
  </xsl:choose> 
    </xsl:otherwise>
   </xsl:choose>

</xsl:template>

 
  <!-- TODO: move to common (same as for attachment) -->
  <xsl:template name="get-image-icon-static-document">
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
  
  <xsl:template name="static-document-dialog">
       <div id="staticDocumentUploadFields" style="display:none">
        <xsl:call-template name="dialog">
         <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FILE_DETAILS')"/></xsl:with-param>
         <xsl:with-param name="id">staticDocumentUploadDialog</xsl:with-param>
         <xsl:with-param name="content">
          <xsl:call-template name="form-wrapper">
          <xsl:with-param name="name">sendStaticDocument</xsl:with-param>
          <xsl:with-param name="enctype">multipart/form-data</xsl:with-param>
          <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/GTPStaticDocumentUploadScreen</xsl:with-param>
          <xsl:with-param name="override-displaymode">edit</xsl:with-param>
          <xsl:with-param name="content">

           <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">documentid</xsl:with-param>
            <xsl:with-param name="id">static_documentid</xsl:with-param>
            <xsl:with-param name="value"><xsl:value-of select="document_id"/></xsl:with-param>
           </xsl:call-template> 
           <!-- <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">att_ref_id</xsl:with-param>
            <xsl:with-param name="value"><xsl:value-of select="ref_id"/></xsl:with-param>
           </xsl:call-template>
           <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">att_tnx_id</xsl:with-param>
            <xsl:with-param name="value"><xsl:value-of select="tnx_id"/></xsl:with-param>
           </xsl:call-template>-->
           <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">identifier</xsl:with-param>
            <xsl:with-param name="id">static_identifier</xsl:with-param>
            <xsl:with-param name="value"></xsl:with-param>
           </xsl:call-template>
           <!-- <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">group</xsl:with-param>
            <xsl:with-param name="value"></xsl:with-param>
           </xsl:call-template>-->
           <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">operation</xsl:with-param>
            <xsl:with-param name="id">static_operation</xsl:with-param>
            <xsl:with-param name="value">UPLOAD</xsl:with-param>
           </xsl:call-template>
           <!-- <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">max-files</xsl:with-param>
            <xsl:with-param name="value"><xsl:value-of select="$max-files"/></xsl:with-param>
           </xsl:call-template>-->

          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_FILESDETAILS_TITLE</xsl:with-param>
           <xsl:with-param name="name">title</xsl:with-param>
           <xsl:with-param name="id">static_title</xsl:with-param>
           <xsl:with-param name="value"/>
           <xsl:with-param name="size">30</xsl:with-param>
           <xsl:with-param name="maxsize">255</xsl:with-param>
           <xsl:with-param name="swift-validate">N</xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_FILESDETAILS_FILE</xsl:with-param>
           <xsl:with-param name="name">file</xsl:with-param>
           <xsl:with-param name="id">static_file</xsl:with-param>
           <xsl:with-param name="value"/>
           <xsl:with-param name="type">file</xsl:with-param>
           <xsl:with-param name="size">20</xsl:with-param>
           <xsl:with-param name="maxsize">255</xsl:with-param>
           <xsl:with-param name="required">Y</xsl:with-param>
           <xsl:with-param name="swift-validate">N</xsl:with-param>
          </xsl:call-template>
         </xsl:with-param>
         </xsl:call-template>
         </xsl:with-param>
         <xsl:with-param name="buttons">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="id">uploadButton</xsl:with-param>
           <xsl:with-param name="content">
            <button dojoType="dijit.form.Button" id="staticDocumentUploadButton" onclick="misys.uploadStaticDocument()" type="button">
             <xsl:attribute name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_UPLOAD')"/></xsl:attribute>
             <xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_UPLOAD')"/>
            </button>
            <button dojoType="dijit.form.Button" id="staticDocumentCancelUpload" onclick="dijit.byId('staticDocumentUploadDialog').hide()" type="button">
             <xsl:attribute name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/></xsl:attribute>
             <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
            </button>
           </xsl:with-param>
          </xsl:call-template>
         <!-- </xsl:with-param>
        </xsl:call-template>
       </div>-->
       <!-- </xsl:when>
       <xsl:otherwise>
       This form is just an holder for hidden value. We assume that the standard upload dialog form is
       in the page 
		<div style="display:none">
		<xsl:attribute name="id">fileUploadFields<xsl:value-of select="$attachment-group"/></xsl:attribute>
		<xsl:call-template name="dialog">
		  <xsl:with-param name="id">fileUploadDialog<xsl:value-of select="$attachment-group"/></xsl:with-param>
		  <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FILE_DETAILS')"/></xsl:with-param>
		  <xsl:with-param name="content">
		   <xsl:call-template name="form-wrapper">
          <xsl:with-param name="name">sendfiles<xsl:value-of select="$attachment-group"/></xsl:with-param>
          <xsl:with-param name="override-displaymode">edit</xsl:with-param>
          <xsl:with-param name="parse-widgets">N</xsl:with-param>
          <xsl:with-param name="content">
           <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">max-files<xsl:value-of select="$attachment-group"/></xsl:with-param>
            <xsl:with-param name="value"><xsl:value-of select="$max-files"/></xsl:with-param>
           </xsl:call-template>  
          </xsl:with-param>
          </xsl:call-template>
		  </xsl:with-param>
		</xsl:call-template>  
         </div>       
       </xsl:otherwise>
       </xsl:choose>-->
      </xsl:with-param> 
    </xsl:call-template>
    </div>
  </xsl:template>
 </xsl:stylesheet>