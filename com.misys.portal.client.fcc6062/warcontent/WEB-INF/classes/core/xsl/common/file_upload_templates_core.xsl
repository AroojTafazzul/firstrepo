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
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
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
 
 

<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
<xsl:variable name="fileTypeImgPathPrefix"><xsl:value-of select="$contextPath"/>/content/images/file_</xsl:variable> 
<xsl:param name="deleteImage"><xsl:value-of select="$images_path"/>delete.png</xsl:param>
<xsl:param name="docImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>doc.gif</xsl:param> 
<xsl:param name="textImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>txt.gif</xsl:param> 
<xsl:param name="pdfImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>pdf.gif</xsl:param> 
<xsl:param name="gifImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>gif.gif</xsl:param> 
<xsl:param name="zipImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>zip.gif</xsl:param> 
<xsl:param name="extImage"><xsl:value-of select="$fileTypeImgPathPrefix"/>ext.gif</xsl:param> 


    
  <xsl:template name="upload-logo">
  	<xsl:param name="name"/>
  	<xsl:param name="button-label"/>
  	
  	<div class="field clear">
  		<span style="width:175px; text-align: right; margin-right: 5px; float:left;">
  		<button dojoType="dijit.form.Button" type="button" style="display:inline">
			<xsl:attribute name="onclick">misys.showLogoUploadDialog()</xsl:attribute>
			<xsl:attribute name="id">openUploadLogoDialog</xsl:attribute>
			<xsl:attribute name="value"><xsl:value-of select="localization:getGTPString($language, $button-label)"/></xsl:attribute>
			<xsl:value-of select="localization:getGTPString($language, $button-label)"/>
		</button>
		</span>
		<div style="display:none">
			<xsl:attribute name="id"><xsl:value-of select="$name"/>-logo-row</xsl:attribute>
			<img>
				<xsl:attribute name="id"><xsl:value-of select="$name"/>-image</xsl:attribute>
			    <xsl:attribute name="src"/>
			    <xsl:attribute name="style">width:100%</xsl:attribute>
			</img>
		</div>
		<xsl:call-template name="hidden-field">
		   <xsl:with-param name="name" select="$name"/>
		   <xsl:with-param name="value"/>
		</xsl:call-template> 
		
  	</div>
  	
  	<xsl:call-template name="dialog">
	  <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FILE_DETAILS')"/></xsl:with-param>
	  <xsl:with-param name="id">logoUploadDialog</xsl:with-param>
	  <xsl:with-param name="content">
	    <xsl:call-template name="form-wrapper">
	      <xsl:with-param name="name">sendlogofiles</xsl:with-param>
	      <xsl:with-param name="parseFormOnLoad">N</xsl:with-param>
	      <xsl:with-param name="enctype">multipart/form-data</xsl:with-param>
	      <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/GTPUploadLogoScreen</xsl:with-param>
	      <xsl:with-param name="override-displaymode">edit</xsl:with-param>
	      <xsl:with-param name="content">
		    <xsl:call-template name="hidden-field">
		      <xsl:with-param name="value">UPLOAD</xsl:with-param>
		      <xsl:with-param name="name">operation</xsl:with-param>
		    </xsl:call-template>     
	        <xsl:call-template name="input-field">
	          <xsl:with-param name="label">XSL_FILESDETAILS_FILE</xsl:with-param>
	          <xsl:with-param name="name">logofile</xsl:with-param>
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
	        <button dojoType="dijit.form.Button" id="uploadButton" type="button">
	           <xsl:attribute name="onclick">misys.uploadLogo('<xsl:value-of select="$name"/>')</xsl:attribute>
	           <xsl:attribute name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_UPLOAD')"/></xsl:attribute>
	           <xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_UPLOAD')"/>
	        </button>
	        <button dojoType="dijit.form.Button" id="cancelUpload" onclick="misys.hideLogoUploadDialog();" type="button">
	           <xsl:attribute name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/></xsl:attribute>
	             <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
	        </button>
	      </xsl:with-param>
	    </xsl:call-template>
	  </xsl:with-param>
	</xsl:call-template>
  </xsl:template>
    
  <xsl:template name="attachments-file">
   <xsl:param name="max-files">5</xsl:param>
   <xsl:param name="attachment_type"/>
   <xsl:param name="existing-attachments" select="attachments/attachment"/>
   <xsl:param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:param>
   <xsl:param name="attachment-group"></xsl:param>
   <xsl:choose>
    <xsl:when test="$displaymode='view' and $mode = 'DRAFT'">
     <!-- Don't show the file details for the draft view mode, but do in all other cases -->
    </xsl:when>
    <xsl:otherwise>
    <xsl:choose>
    <!-- Only display attachments in general view mode, and when the collaborationmode is 'bank'-->
    
    <xsl:when test="$displaymode='view'">
    <xsl:if test="count($existing-attachments) > 0">
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
		<xsl:with-param name="parseFormOnLoad">N</xsl:with-param>
		<xsl:with-param name="enctype">multipart/form-data</xsl:with-param>
		<xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/GTPUploadScreen</xsl:with-param>
		<xsl:with-param name="override-displaymode">edit</xsl:with-param>
		<xsl:with-param name="content">
		 <div class="widgetContainer">
		  <xsl:call-template name="hidden-field">
		   <xsl:with-param name="name">attachmentid</xsl:with-param>
		   <xsl:with-param name="value"><xsl:value-of select="attachment_id"/></xsl:with-param>
		  </xsl:call-template> 
		  <xsl:call-template name="hidden-field">
		   <xsl:with-param name="name">att_item_id</xsl:with-param>
		   <xsl:with-param name="value"><xsl:value-of select="item_id"/></xsl:with-param>
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
		  <xsl:call-template name="hidden-field">
		   <xsl:with-param name="name">token</xsl:with-param>
		   <xsl:with-param name="value">><xsl:value-of select="_token"/></xsl:with-param>
		  </xsl:call-template>
		 </div>
		</xsl:with-param>
       </xsl:call-template>
      </div>
     </div>
     </xsl:if>
    </xsl:when>
    <xsl:otherwise>

      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend"><xsl:value-of select="$legend"/></xsl:with-param>
       <xsl:with-param name="content">

         <xsl:call-template name="files-table">
          <xsl:with-param name="max-attachments" select="$max-files"/>
          <xsl:with-param name="existing-attachments" select="$existing-attachments"></xsl:with-param>
	 	 <xsl:with-param name="attachment-group" select="$attachment-group"/>         
         </xsl:call-template>

         <button dojoType="dijit.form.Button" type="button" onclick="misys.showUploadDialog('{$attachment-group}')">
           <xsl:attribute name="id">
       	    <xsl:choose>
       	     <xsl:when test="$attachment-group != ''"><xsl:value-of select="$attachment-group"/></xsl:when>
       	     <xsl:otherwise>openUploadDialog</xsl:otherwise>
       	    </xsl:choose>
       	   </xsl:attribute>
           <xsl:attribute name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_ADD_FILE_ITEM')"/></xsl:attribute>
           <xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_ADD_FILE_ITEM')"/>
         </button>
       <xsl:choose>
       <xsl:when test="$attachment-group = ''">
       <div id="fileUploadFields" style="display:none">
        <xsl:call-template name="dialog">
         <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FILE_DETAILS')"/></xsl:with-param>
         <xsl:with-param name="id">fileUploadDialog</xsl:with-param>
         <xsl:with-param name="content">
          <xsl:call-template name="form-wrapper">
          <xsl:with-param name="name">sendfiles</xsl:with-param>
          <xsl:with-param name="parseFormOnLoad">N</xsl:with-param>
          <xsl:with-param name="enctype">multipart/form-data</xsl:with-param>
          <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/GTPUploadScreen</xsl:with-param>
          <xsl:with-param name="override-displaymode">edit</xsl:with-param>
          <xsl:with-param name="content">
          <div class="widgetContainer">
           <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">attachment_type</xsl:with-param>
            <xsl:with-param name="value"><xsl:value-of select="$attachment_type"/></xsl:with-param>
           </xsl:call-template> 
           <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">attachmentid</xsl:with-param>
            <xsl:with-param name="value"><xsl:value-of select="attachment_id"/></xsl:with-param>
           </xsl:call-template> 
           <xsl:call-template name="hidden-field">
		    <xsl:with-param name="name">att_item_id</xsl:with-param>
		    <xsl:with-param name="value"><xsl:value-of select="item_id"/></xsl:with-param>
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
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_FILESDETAILS_TITLE</xsl:with-param>
           <xsl:with-param name="name">title</xsl:with-param>
           <xsl:with-param name="value"/>
           <xsl:with-param name="size">30</xsl:with-param>
           <xsl:with-param name="maxsize">255</xsl:with-param>
           <xsl:with-param name="swift-validate">N</xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_FILESDETAILS_FILE</xsl:with-param>
           <xsl:with-param name="name">file</xsl:with-param>
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
            <button dojoType="dijit.form.Button" id="uploadButton" onclick="fncSendFileAttachment()" type="button">
             <xsl:attribute name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_UPLOAD')"/></xsl:attribute>
             <xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_UPLOAD')"/>
            </button>
            <button dojoType="dijit.form.Button" id="cancelUpload" onclick="dijit.byId('fileUploadDialog').hide()" type="button">
             <xsl:attribute name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/></xsl:attribute>
             <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
            </button>
           </xsl:with-param>
          </xsl:call-template>
         </xsl:with-param>
        </xsl:call-template>
       </div>
       </xsl:when>
       <xsl:otherwise>
       <!-- This form is just an holder for hidden value. We assume that the standard upload dialog form is
       in the page -->
		<div style="display:none">
		<xsl:attribute name="id">fileUploadFields<xsl:value-of select="$attachment-group"/></xsl:attribute>
		<xsl:call-template name="dialog">
		  <xsl:with-param name="id">fileUploadDialog<xsl:value-of select="$attachment-group"/></xsl:with-param>
		  <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FILE_DETAILS')"/></xsl:with-param>
		  <xsl:with-param name="content">
		   <xsl:call-template name="form-wrapper">
            <xsl:with-param name="name">sendfiles<xsl:value-of select="$attachment-group"/></xsl:with-param>
            <xsl:with-param name="parseFormOnLoad">N</xsl:with-param>
            <xsl:with-param name="override-displaymode">edit</xsl:with-param>
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
       </xsl:choose>
      </xsl:with-param> 
    </xsl:call-template>

   </xsl:otherwise>
  </xsl:choose> 
    </xsl:otherwise>
   </xsl:choose>

</xsl:template>

  <!--
   Attach an object or dynamic item to a transaction.
   
   header-label : localization key of the section header
   existing-attachments : select the existing attachments
   override-form-name : form-name, if required
   max-attachments : maximum number of attachments allowed. Pass in -1 to allow unlimited
   
   attachment-prefix : can be files, documents, etc.
   attachment-table-summary : localization key for the table summary
   attachment-table-caption : localization key for the table caption
   attachment-table-thead : HTML fragment for THEAD contents of attachment table
   -->
   <xsl:template name="files-table">
    <!-- Existing attachments -->
    <xsl:param name="existing-attachments"/>
    
    <xsl:param name="attachment-group"/>
   
    <!-- Counting the attachments -->
    <xsl:param name="max-attachments">1</xsl:param>

    <!-- Javascript var to track open files-->
    <xsl:if test="$displaymode='edit' or ($displaymode='view' and (count($existing-attachments) > 0))">
     <xsl:if test="$displaymode='edit'">
      <script>
      	  dojo.ready(function(){
      	  	misys._config = misys._config || {};
      	 	misys._config.attachedFiles = misys._config.attachedFiles || [];
      	  	if(!misys._config.attachedFiles['<xsl:value-of select="$attachment-group"/>']) {
      	  		misys._config.attachedFiles['<xsl:value-of select="$attachment-group"/>'] = 
      	  			<xsl:value-of select="count($existing-attachments)"/>;
      	  	}
      	  });
      </script> 
     </xsl:if>
    
     <!-- Table of attached items. -->
     <table border="0" cellpadding="0" cellspacing="0" class="attachments">
     <xsl:attribute name="id">files_master_table<xsl:value-of select="$attachment-group"/></xsl:attribute>
      <xsl:attribute name="summary">
       <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ATTACHMENTS_SUMMARY')"/>
      </xsl:attribute>
      <xsl:if test="count($existing-attachments) = 0">
       <xsl:attribute name="style">display:none;</xsl:attribute>
      </xsl:if>
      <xsl:if test="$displaymode = 'edit'">
       <caption><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ATTACHMENTS_CAPTION')"/>&nbsp;<xsl:if test="$max-attachments!='-1'">(<xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_MAX')"/> <xsl:value-of select="$max-attachments"/>)</xsl:if></caption>
      </xsl:if>
      <thead>
       <tr>
        <th class="small-tblheader" scope="col">&nbsp;</th>
        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILES_COLUMN_TITLE')"/></th>
        <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILES_COLUMN_FILE')"/></th>
        <xsl:if test="$displaymode='edit'"><th class="button-tblheader" scope="col">&nbsp;</th></xsl:if>
       </tr>
      </thead>
      <tbody>
		<xsl:attribute name="id">files_table_details<xsl:value-of select="$attachment-group"/></xsl:attribute>      
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
            <xsl:with-param name="attachment-group" select="$attachment-group"/>
           </xsl:call-template>
          </tr>
         </xsl:for-each>
        </xsl:otherwise>
       </xsl:choose>
      </tbody>
     </table>
          
	 <!-- Disclaimer -->
	 <p class="empty-list-notice">
		<xsl:attribute name="id">files-notice<xsl:value-of select="$attachment-group"/></xsl:attribute> 	 
	  <xsl:if test="count($existing-attachments)!=0">
	   <xsl:attribute name="style">display:none</xsl:attribute>
	  </xsl:if>
	  <xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_NO_FILE_ITEM')"/>&nbsp;<xsl:if test="$max-attachments!=-1 and $displaymode='edit'">(<xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_MAX')"/> <xsl:value-of select="$max-attachments"/>)</xsl:if>
	 </p>
   </xsl:if>
  </xsl:template>

  <!-- 
   A row in the attachment table. 
  -->
  <xsl:template name="file-upload-table-row">
   <xsl:param name="existing">N</xsl:param>
   <xsl:param name="nbElement"/>
   <xsl:param name="attachment-group"/>
   
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
      <a href="javascript:void(0)">
       <xsl:attribute name="onclick">misys.downloadFile('<xsl:value-of select="$nbElement"/>');</xsl:attribute>
       <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_TITLE_ATTACHMENT_DOWNLOAD')"/></xsl:attribute>
       <xsl:value-of select="file_name"/>
      </a>
    </xsl:if>
   </td>
   <xsl:if test="$existing='Y' and $displaymode='edit'">
    <td>
    <xsl:choose>
     <xsl:when test="auto_gen_doc_code != ''">&nbsp;</xsl:when>
     <xsl:otherwise>
     <div dojoType="dijit.form.DropDownButton" class="noborder">
      <xsl:attribute name="label"><![CDATA[<img src="]]><xsl:value-of select="utils:getImagePath($deleteImage)"/><![CDATA[" alt="delete"/>]]></xsl:attribute>
      <span/>
      <div dojoType="dijit.TooltipDialog">
       <xsl:attribute name="execute">misys.deleteStaticDocument(<xsl:value-of select="$nbElement"/><xsl:if test="$attachment-group!=''">,<xsl:value-of select="$attachment-group"/></xsl:if>)</xsl:attribute>
       <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'DeleteAttachment')"/></xsl:attribute>
       <p><xsl:value-of select="localization:getGTPString($language, 'XSL_TITLE_ATTACHMENT_NOTICE')"/></p>
       <button dojoType="dijit.form.Button" type="submit"><xsl:value-of select="localization:getGTPString($language, 'XSL_TITLE_ATTACHMENT_DELETE')"/></button>
      </div>
     </div>
     </xsl:otherwise>
     </xsl:choose>
    </td>
   </xsl:if>
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