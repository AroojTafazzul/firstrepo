<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization">

<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:import href="com_attachment.xsl"/>
	<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="executeImage"><xsl:value-of select="$images_path"/>execute.png</xsl:param>
	<xsl:param name="formSaveImage"><xsl:value-of select="$images_path"/>pic_form_save.gif</xsl:param>
	<xsl:param name="formCancelImage"><xsl:value-of select="$images_path"/>pic_form_cancel.gif</xsl:param>
	<xsl:param name="formHelpImage"><xsl:value-of select="$images_path"/>pic_form_help.gif</xsl:param>
	<xsl:param name="upImage"><xsl:value-of select="$images_path"/>pic_up.gif</xsl:param>
	<xsl:param name="editGifImage"><xsl:value-of select="$images_path"/>pic_edit.gif</xsl:param>
	<xsl:param name="trashImage"><xsl:value-of select="$images_path"/>pic_trash.gif</xsl:param>
	<xsl:param name="searchImage"><xsl:value-of select="$images_path"/>pic_search.gif</xsl:param>
	
	
	
	<xsl:template match="/">
		<xsl:apply-templates select="parameters_record"/>
	</xsl:template>

	<!--TEMPLATE Main-->

	<xsl:template match="parameters_record">

		<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"></script>
		<script type="text/javascript">
			<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script type="text/javascript" src="/content/OLD/javascript/dm_parameters.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_attachment.js"></script>
	
		<p><br/></p>
		<center>
	
			<div style="display:none;">
				<table>
					<tbody>
						<xsl:attribute name="id">files_template</xsl:attribute>
						<xsl:call-template name="FILES_UPLOAD_DETAILS">
							<xsl:with-param name="structure_name">files</xsl:with-param>
							<xsl:with-param name="mode">template</xsl:with-param>
							<xsl:with-param name="formName">sendfiles</xsl:with-param>
							<xsl:with-param name="max_file">1</xsl:with-param>
						</xsl:call-template>
					</tbody>
				</table>
			</div>
			<table border="0" cellspacing="0" cellpadding="0">
	
				<!-- POST instructions -->
				<form
					name="realform"
					method="POST"
					accept-charset="UNKNOWN" 
					action="/gtp/screen/DocumentManagementScreen">
					
					<input type="hidden" name="operation" value="SAVE"/>
					<input type="hidden" name="TransactionData"/>
					<input type="hidden" name="attIds" value=""/>
				</form>
				<tr align="left">
				<td>
			    <form name="sendfiles" id="sendfiles" enctype="multipart/form-data" method="post" target="hiddeniframe">
						<table border="0" width="570" cellpadding="0" cellspacing="0">
							<tr>
								<td class="FORMH1" colspan="3">
									<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_OPTIONAL_FILE_UPLOAD')"/></b>
								</td>
								<td align="right" class="FORMH1">
									<a href="#">
										<img border="0">
											<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($upImage)"/></xsl:attribute>										
											<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
										</img>
									</a>
								</td>
							</tr>
						</table>
					
						<br/>
			
						<div>
							<xsl:attribute name="id">files_disclaimer</xsl:attribute>
							<xsl:if test="count(attachments/attachment) != 0">
								<xsl:attribute name="style">display:none</xsl:attribute>
							</xsl:if>
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_NO_FILE_ITEM')"/></b>
						</div>
			
						<table border="0" width="560" cellpadding="0" cellspacing="1" id="files_master_table" >
							<xsl:if test="count(attachments/attachment) = 0">
								<xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
							</xsl:if>
							<tbody id="files_table">
			
								<tr>
									<xsl:attribute name="id">files_table_header_1</xsl:attribute>
									<xsl:if test="count(attachments/attachment) = 0">
										<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
									</xsl:if>
									<th class="FORMH2" align="center" width="45%"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILES_COLUMN_TITLE')"/></th>
									<th class="FORMH2" align="center" width="45%"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILES_COLUMN_FILE')"/></th>
									<th class="FORMH2" width="10%">&nbsp;</th>
								</tr>
			
								<xsl:for-each select="attachments/attachment">
									<xsl:call-template name="FILES_UPLOAD_DETAILS">
										<xsl:with-param name="structure_name">files</xsl:with-param>
										<xsl:with-param name="mode">existing</xsl:with-param>
										<xsl:with-param name="formName">sendfiles</xsl:with-param>
										<xsl:with-param name="max_file">1</xsl:with-param>
									</xsl:call-template>
								</xsl:for-each>
								
							</tbody>
						</table>
						<br/>
						
						<div>
							<xsl:attribute name="id">attachment_add</xsl:attribute>
							<xsl:if test="count(attachments/attachment) > 0">
								<xsl:attribute name="style">display:none</xsl:attribute>
							</xsl:if>
							<a href="javascript:void(0)">
								<xsl:attribute name="onClick">fncPreloadImages('<xsl:value-of select="utils:getImagePath($searchImage)"/>', '<xsl:value-of select="utils:getImagePath($executeImage)"/>', '<xsl:value-of select="utils:getImagePath($editGifImage)"/>', '<xsl:value-of select="utils:getImagePath($trashImage)"/>'); fncLaunchProcess("fncAddElement('sendfiles', 'files', '')");</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_ADD_FILE_ITEM')"/>
							</a>
						</div>
			
						<p><br/></p>
			        <div id="messageCallBack"></div>
					<input type="hidden" name="attachmentid"/>
					<input type="hidden" name="identifier"/>
					<input type="hidden" name="returnFunction"/>
					<input type="hidden" name="att_company_id"><xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute></input>
					<input type="hidden" name="att_ref_id"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
					<input type="hidden" name="att_tnx_id"><xsl:attribute name="value"><xsl:value-of select="tnx_id"/></xsl:attribute></input>
					<input type="hidden" name="att_title"/>
					<input type="hidden" name="operation"/>
			    </form>
			    <iframe name="hiddeniframe" id="hiddeniframe" style="display:none;" src="about:blank"></iframe>
				</td>
				</tr>
				<!-- Show the transformations associated with each document -->
				<xsl:apply-templates select="document_record" mode="input"/>
				
			</table>
		</center>

		<center>	
			<table border="0" cellspacing="2" cellpadding="8">
				<tr>
					<td align="middle" valign="center">
						<a href="javascript:void(0)" onclick="fncPerform('save');return false;">
							<img border="0" >
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formSaveImage)"/></xsl:attribute>
							</img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)" onclick="fncPerform('cancel');return false;">
							<img border="0">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formCancelImage)"/></xsl:attribute>
							</img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)" onclick="fncPerform('help');return false;">
							<img border="0">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formHelpImage)"/></xsl:attribute>
							</img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_HELP')"/>
						</a>
					</td>
				</tr>
			</table>
		</center>
	</xsl:template>

	<!-- Template for The transformations related to a given document -->
	<xsl:template match="document_record" mode="input">
	
		<xsl:variable name="formName">
			<xsl:choose>
				<xsl:when test="document_code[.!='']">form_<xsl:value-of select="document_code"/>_<xsl:value-of select="document_format"/></xsl:when>
				<xsl:otherwise>form_document_<xsl:value-of select="position()"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<form>
			<xsl:attribute name="name"><xsl:value-of select="$formName"/></xsl:attribute>

			<input type="hidden" name="document_name"><xsl:attribute name="value"><xsl:value-of select="document_name"/></xsl:attribute></input>
			<input type="hidden" name="document_code"><xsl:attribute name="value"><xsl:value-of select="document_code"/></xsl:attribute></input>
			<input type="hidden" name="document_format"><xsl:attribute name="value"><xsl:value-of select="document_format"/></xsl:attribute></input>
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1">
						<b>
							<!-- Transformation code -->
							<xsl:choose>
								<xsl:when test="document_code[.!=''] and document_code[.!='*']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSFORMATIONS_FOR')"/>&nbsp;
									<xsl:value-of select="document_name"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSFORMATIONS')"/>
								</xsl:otherwise>
							</xsl:choose>
							<!-- Transformation format -->
							<xsl:variable name="localization_key"><xsl:value-of select="document_format"/></xsl:variable>
							<xsl:if test="$localization_key != ''">&nbsp;(<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_FORMAT')"/>&nbsp;<xsl:value-of select="localization:getDecode($language, 'N035', $localization_key)"/>)</xsl:if>
						</b>
					</td>
				</tr>
			</table>
			<br/>
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td width="40">&nbsp;</td>
					<td>
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td align="left" valign="top" width="50%">
									<select multiple="true" size="4" name="transformation_list" style="width:200px">
										<xsl:apply-templates select="transformation" mode="input"/>
									</select>
								</td>
								<td align="middle" nowrap="true">
									<input class="BUTTON" type="button"><xsl:attribute name="onclick">fncMoveOptions(document.forms['<xsl:value-of select="$formName"/>'].elements['avail_list'],document.forms['<xsl:value-of select="$formName"/>'].elements['transformation_list']);return false;</xsl:attribute><xsl:attribute name="value">&lt;&lt;<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')"/></xsl:attribute></input>
									<br/><br/><br/>
									<input class="BUTTON" type="button"><xsl:attribute name="onclick">fncMoveOptions(document.forms['<xsl:value-of select="$formName"/>'].elements['transformation_list'],document.forms['<xsl:value-of select="$formName"/>'].elements['avail_list']);return false;</xsl:attribute><xsl:attribute name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')"/> &gt;&gt;</xsl:attribute></input>
								</td>
								<td align="right" valign="top" width="50%">
									<select multiple="true" size="4" name="avail_list" style="width:200px">
										<xsl:apply-templates select="avail_transformation" mode="input"/>
									</select>
							</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>			
			
		</form>

	</xsl:template>

	<!-- Template for Transformation Description (whether already given or still available) in Input Mode -->
	<xsl:template match="transformation | avail_transformation" mode="input">
		<option>
			<xsl:attribute name="value"><xsl:value-of select="code"/></xsl:attribute>
			<xsl:value-of select="description"/>
		</option>
	</xsl:template>

		
</xsl:stylesheet>
