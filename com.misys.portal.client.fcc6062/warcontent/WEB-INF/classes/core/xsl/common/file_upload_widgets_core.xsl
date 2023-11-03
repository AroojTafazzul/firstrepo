<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Implementation of generic templates for the attachment and uploading of files, with a 
transaction.

Global variables referenced in these templates
 $main-form-name

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
    xmlns:security="xalan://com.misys.portal.common.tools.SecurityUtils"
    xmlns:gtpsecurity="xalan://com.misys.portal.security.GTPSecurity"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    xmlns:java="http://xml.apache.org/xalan/java"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
    exclude-result-prefixes="localization defaultresource java utils">
    <xsl:include href="e2ee_file_common.xsl" />
	<xd:doc>
		<xd:short>Template to upload files.</xd:short>
		<xd:detail>
			Used to upload the files form the UI
		</xd:detail>
		<xd:param name="max-files">maximum number of files can be uploaded</xd:param>
		<xd:param name="attachment_type">Type of attachment</xd:param>
		<xd:param name="existing-attachments">existing attachments</xd:param>
		<xd:param name="legend">header line</xd:param>
		<xd:param name="attachment-group">Attachment group</xd:param>
		<xd:param name="with-wrapper">wrapper default Y</xd:param>
		<xd:param name="parse-widgets">parse widgets default Y</xd:param>
		<xd:param name="callback">optional callback method called after the attachment upload</xd:param>
		<xd:param name="show-status-column">to show the status column default N</xd:param>
		<xd:param name="override-displaymode">display mode </xd:param>
		<xd:param name="title-size">Total size, default 255</xd:param>
	</xd:doc>
    <xsl:template name="attachments-file-dojo">
		<xsl:param name="max-files"><xsl:value-of select="defaultresource:getResource('FILE_UPLOAD_MAX_LIMIT')"/></xsl:param>
		<xsl:param name="attachment_type"/>
		<xsl:param name="existing-attachments" select="attachments/attachment"/>
		<xsl:param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:param>
		<xsl:param name="attachment-group"/>
		<xsl:param name="with-wrapper">Y</xsl:param>
		<xsl:param name="parse-widgets">Y</xsl:param>
		<xsl:param name="callback"></xsl:param><!-- optional callback method called after the attachment upload -->
		<xsl:param name="show-status-column">N</xsl:param>
		<xsl:param name="override-displaymode" select="$displaymode"/>
		<xsl:param name="title-size">35</xsl:param>
		
    	<div style="display:none">
    	    <xsl:attribute name="id">file-attachment-template<xsl:value-of select="$attachment-group"/></xsl:attribute>
			<div class="clear">
				<p dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
				 <xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_NO_FILE_ITEM')"/>
				</p>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode"/>
				</div>
			</div>
		</div>
    	<xsl:if test="$override-displaymode = 'edit' or ($override-displaymode = 'view' and count($existing-attachments) > 0) or (tnx_type_code and tnx_type_code = '32' and $mode='ACCEPT')">
			<xsl:variable name="addButton">
				<div class="widgetContainer">
					<xsl:if test="$attachment_type != 'BULK_FILE_UPLOAD'">
						<button dojoType="dijit.form.Button" type="button">
							<xsl:attribute name="onClick">misys.addFileItem('<xsl:value-of select="$attachment-group"/>')</xsl:attribute>
							<xsl:attribute name="id">openUploadDialogBtn<xsl:value-of select="$attachment-group"/></xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_ADD_FILE_ITEM')"/>
						</button>
					</xsl:if>
					<xsl:if test="$attachment_type = 'BULK_FILE_UPLOAD'">
						<button dojoType="dijit.form.Button" type="button">
							<xsl:attribute name="onClick">misys.addBulkFileItem('<xsl:value-of select="$attachment-group"/>')</xsl:attribute>
							<xsl:attribute name="id">openUploadDialogBtn<xsl:value-of select="$attachment-group"/></xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_ADD_FILE_ITEM')"/>
						 </button>
					</xsl:if>
				</div>
			</xsl:variable>
			<!-- To render dynamic Information regarding allowed Max. files and Max. size per attachment -->
        	<xsl:variable name="eachFileMaxSize"><xsl:value-of select="utils:getMaxSizePerAttachment($rundata)"/></xsl:variable>
        	<xsl:variable name="arrayList" select="java:java.util.ArrayList.new()"/>
			<xsl:variable name="void" select="java:add($arrayList, concat('', ($max-files)))"/>
			<xsl:variable name="void" select="java:add($arrayList, concat('', ($eachFileMaxSize)))"/>
			<xsl:variable name="args" select="java:toArray($arrayList)"/>
			<xsl:variable name="preformattedLegend">
				<xsl:value-of select="localization:getFormattedString($language, $legend, $args)"/>
			</xsl:variable>
			
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">
					<xsl:choose>
						<xsl:when test="$preformattedLegend != ''"><xsl:value-of select="$preformattedLegend"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="$legend"/></xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="localized">
					<xsl:choose>
						<xsl:when test="$preformattedLegend != ''">N</xsl:when>
						<xsl:otherwise>Y</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="legend-type">
					<xsl:choose>
						<xsl:when test="$with-wrapper = 'Y'">toplevel-header</xsl:when>
						<xsl:otherwise>indented-header</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="content">			
					<xsl:if test="count($existing-attachments) = 0">
						<p class="empty-list-notice">
						<xsl:attribute name="id">noFilesNotice<xsl:value-of select="$attachment-group"/></xsl:attribute>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_NO_FILE_ITEM')"/>
						</p>
					</xsl:if>
					<xsl:call-template name="build-attachment-table-dojo-items">
						<xsl:with-param name="existing-attachments" select="$existing-attachments" />
						<xsl:with-param name="max-files"><xsl:value-of select="$max-files"/></xsl:with-param>
						<xsl:with-param name="attachment_type"><xsl:value-of select="$attachment_type"/></xsl:with-param>
						<xsl:with-param name="attachment-group"><xsl:value-of select="$attachment-group"/></xsl:with-param>
						<xsl:with-param name="callback"><xsl:value-of select="$callback"/></xsl:with-param>
						<xsl:with-param name="show-status-column"><xsl:value-of select="$show-status-column"/></xsl:with-param>
						<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
					</xsl:call-template>
					<!-- This div is required to force the content to appear -->
					<div style="height:1px">&nbsp;</div>
					<xsl:if test="$override-displaymode = 'edit' or tnx_type_code and tnx_type_code = '32' and $mode='ACCEPT'">
						<!-- <xsl:copy-of select="$addButton"/> -->
						<!-- We need to uncomment the below lines for E2EE file enablement  -->
						<xsl:choose> 
	    					<xsl:when test="$isFileE2EEEnabled != 'true'">
								<xsl:copy-of select="$addButton"/>
							</xsl:when>
							<xsl:otherwise>							 
								<xsl:call-template name="e2ee_file"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</xsl:with-param>
				<xsl:with-param name="parse-widgets">
					<xsl:choose>
						<xsl:when test="count($existing-attachments) > 0 and $parse-widgets= 'Y'">Y</xsl:when>
						<xsl:otherwise>N</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:call-template name="attachment-file-adds-template">
			<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
			<xsl:with-param name="attachment-group"><xsl:value-of select="$attachment-group"/></xsl:with-param>
			<xsl:with-param name="attachment_type"><xsl:value-of select="$attachment_type"/></xsl:with-param>
		</xsl:call-template>
		<!-- Dialog End -->
		<div class="offscreen">
			<xsl:attribute name="id">downloadfiles-container<xsl:value-of select="$attachment-group"/></xsl:attribute>
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name">downloadfiles<xsl:value-of select="$attachment-group"/></xsl:with-param>
				<xsl:with-param name="parseFormOnLoad">Y</xsl:with-param>
				<xsl:with-param name="enctype">multipart/form-data</xsl:with-param>
				<xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/GTPDownloadScreen</xsl:with-param>
				<xsl:with-param name="override-displaymode">edit</xsl:with-param>
				<xsl:with-param name="content">&nbsp;
				</xsl:with-param>
			</xsl:call-template>
		</div>
    </xsl:template>

    <xsl:template name="build-attachment-table-dojo-items">
    	<xsl:param name="existing-attachments"/>
    	<xsl:param name="max-files"/>
    	<xsl:param name="attachment_type"/>
    	<xsl:param name="attachment-group"/>
    	<xsl:param name="callback"/>
    	<xsl:param name="override-displaymode" select="$displaymode"/>
    	<xsl:param name="show-status-column">N</xsl:param>
    	<div dojoType="misys.product.widget.AttachmentFiles">
    		<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_FILES_COLUMN_FILE_TYPE')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_FILES_COLUMN_TITLE')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_FILES_COLUMN_FILE')"/>
			</xsl:attribute>
			<xsl:attribute name="id">attachment-file<xsl:value-of select="$attachment-group"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FILE_DETAILS')"/></xsl:attribute>
    		<xsl:attribute name="attachmentGroup"><xsl:value-of select="$attachment-group"/></xsl:attribute>
    		<xsl:attribute name="dialogOKCallback"><xsl:value-of select="$callback"/></xsl:attribute>
    		<xsl:attribute name="viewMode">
    			<xsl:choose>
    				<xsl:when test="auto_gen_doc_code != ''">view</xsl:when>
    				<xsl:otherwise><xsl:value-of select="$override-displaymode"/></xsl:otherwise>
    			</xsl:choose>
    		</xsl:attribute>
    		<xsl:attribute name="maxFiles"><xsl:value-of select="$max-files"/></xsl:attribute>
    		<xsl:attribute name="showStatusColumn"><xsl:value-of select="boolean($show-status-column = 'Y')"/></xsl:attribute>
    		<xsl:for-each select="$existing-attachments">
				<xsl:variable name="file" select="."/>
				<div dojoType="misys.product.widget.AttachmentFile">
					<xsl:attribute name="attachment_id"><xsl:value-of select="$file/attachment_id"/></xsl:attribute>
					<xsl:attribute name="file_type"><xsl:value-of select="$file/type"/></xsl:attribute>
					<xsl:attribute name="file_title"><xsl:value-of select="security:encodeHTML($file/title)"/></xsl:attribute>
					<xsl:attribute name="file_name"><xsl:value-of select="security:decodeHTML($file/file_name)"/></xsl:attribute>
					<xsl:attribute name="file_status"><xsl:value-of select="$file/status"/></xsl:attribute>
					<xsl:attribute name="file_status_decoded"><xsl:value-of select="localization:getDecode($language, 'N804', $file/status)"/></xsl:attribute>
					<xsl:attribute name="file_access_dttm"><xsl:value-of select="$file/access_dttm"/></xsl:attribute>
					<xsl:attribute name="file_description"><xsl:value-of select="$file/description"/></xsl:attribute>
					<xsl:attribute name="fileact"><xsl:value-of select="$file/for_fileact"/></xsl:attribute>
				</div>
			</xsl:for-each>
			<script>
             dojo.ready(function(){
                     misys._config = misys._config || {};
                             misys._config.uploadservice_extensions_allowed = <xsl:value-of select="defaultresource:getResource('UPLOADSERVICE_EXTENSIONS_ALLOWED')"/>;
							 misys._config.isCustUser = <xsl:value-of select="gtpsecurity:isCustomer($rundata) or gtpsecurity:isCounterparty($rundata)"/>;
                     });
	        </script>
    	</div>
    </xsl:template>
    <xsl:template name="attachment-file-adds-template">
    	<xsl:param name="attachment-group"/>
    	<xsl:param name="attachment_type"/>
    	<xsl:param name="override-displaymode" select="$displaymode"/>
    	<xsl:param name="title-size">35</xsl:param>
    	<!-- DIALOG START -->
		<div style="display:none">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<xsl:attribute name="id">file-attachment<xsl:value-of select="$attachment-group"/>-dialog-template</xsl:attribute>

			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name">sendfiles<xsl:value-of select="$attachment-group"/></xsl:with-param>
				<xsl:with-param name="parseFormOnLoad">N</xsl:with-param>
				<xsl:with-param name="enctype">multipart/form-data</xsl:with-param>
				<xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/GTPUploadScreen</xsl:with-param>
				<xsl:with-param name="override-displaymode">edit</xsl:with-param>
				
				<xsl:with-param name="content">
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">attachment_id<xsl:value-of select="$attachment-group"/></xsl:with-param>
					</xsl:call-template> 
				  <xsl:if test="$attachment_type = 'BULK_FILE_UPLOAD' or $attachment_type = 'BENEFICIARY_FILE_UPLOAD' or $attachment_type = 'EXTERNAL_ACCOUNT_MT940_FILE_UPLOAD'">
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">attachment-type</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="$attachment_type"/></xsl:with-param>
					</xsl:call-template>
				  </xsl:if>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">file_type<xsl:value-of select="$attachment-group"/></xsl:with-param>
					</xsl:call-template> 
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">file_name<xsl:value-of select="$attachment-group"/></xsl:with-param>
					</xsl:call-template> 
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">file_status<xsl:value-of select="$attachment-group"/></xsl:with-param>
					</xsl:call-template> 
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">file_access_dttm<xsl:value-of select="$attachment-group"/></xsl:with-param>
					</xsl:call-template> 
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">file_description<xsl:value-of select="$attachment-group"/></xsl:with-param>
					</xsl:call-template> 
				         
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FILESDETAILS_TITLE</xsl:with-param>
						<xsl:with-param name="name">file_title<xsl:value-of select="$attachment-group"/></xsl:with-param>
						<xsl:with-param name="value"/>
						<xsl:with-param name="size">30</xsl:with-param>
						<xsl:with-param name="maxsize"><xsl:value-of select="$title-size"/></xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="swift-validate">N</xsl:with-param>
						<xsl:with-param name="override-displaymode">edit</xsl:with-param>
						<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('ATTACHMENT_SECTION_FILE_DETAILS_TITLE_REGEX')"/></xsl:with-param>
					</xsl:call-template>
			
					<div>
						<label for="file{$attachment-group}"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_FILE')"/></label>				        
						<input id="file{$attachment-group}" name="file" type="file" onchange="if(dijit.byId('uploadButton')) dijit.byId('uploadButton').focus();" onbeforeeditfocus="return false;" size="20" maxsize="255"/>
					</div>
			
				</xsl:with-param>
			</xsl:call-template>
			        
	        <div class="dijitDialogPaneActionBar">
	        	<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button dojoType="dijit.form.Button" type="button">
							<xsl:attribute name="id">uploadButton<xsl:value-of select="$attachment-group"/></xsl:attribute>
							<xsl:attribute name="onClick">misys.uploadFile('file-attachment<xsl:value-of select="$attachment-group"/>-dialog-template', '<xsl:value-of select="$attachment-group"/>');
							if(dojo.isIE){						
							misys.clearFilePath();
							}
							</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')"/>
						</button>
						<button dojoType="dijit.form.Button" type="button">
							<xsl:attribute name="onClick">dijit.byId('file-attachment<xsl:value-of select="$attachment-group"/>-dialog-template').hide();</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
						</button>
					</xsl:with-param>
				</xsl:call-template>
			</div>
				
		</div>
		
    </xsl:template>
    
    
  <!--
    delivery channel options.
   -->
  <xsl:template name="delivery-channel-options">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="FACT">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_FILEACT_DELIVERY_CHANNEL_FACT')"/>
     </option>
     <option value="FAXT">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_FILEACT_DELIVERY_CHANNEL_FAXT')"/>
     </option>
     <option value="EMAL">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_FILEACT_DELIVERY_CHANNEL_EMAL')"/>
     </option>
      <option value="MAIL">
       <xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_FILEACT_DELIVERY_CHANNEL_MAIL')"/>
      </option>
      <option value="COUR">
       <xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_FILEACT_DELIVERY_CHANNEL_COUR')"/>
      </option> 
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="localization:getDecode($language, 'N802', delivery_channel)"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>    
</xsl:stylesheet>


