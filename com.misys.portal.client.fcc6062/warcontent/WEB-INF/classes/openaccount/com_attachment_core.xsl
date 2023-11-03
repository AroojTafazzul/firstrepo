<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		exclude-result-prefixes="localization">
<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<!-- Get the language code -->
	<xsl:param name="language"/>


	<!-- ***************** -->
	<!-- Disclaimer Notice -->
	<!-- ***************** -->

	<!--TEMPLATE Collection File Upload-->
	<!-- Collection File Upload Details -->
	<xsl:template name="FILES_UPLOAD_DETAILS">

		<xsl:param name="structure_name"/>
		<xsl:param name="mode"/>
		<xsl:param name="suffix">
			<xsl:if test="$mode = 'existing'"><xsl:value-of select="position()"/></xsl:if>
			<xsl:if test="$mode = 'template'">nbElement</xsl:if>
		</xsl:param>
		<xsl:param name="formName"/>
		<xsl:param name="max_file"/>

		<tr>
			<xsl:if test="$mode = 'template'">
				<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="id">
				<xsl:value-of select="$structure_name"/>_header_<xsl:value-of select="$suffix"/>
			</xsl:attribute>
			
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_1</xsl:attribute>
				</xsl:if>
				<div align="left">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_title_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
							<xsl:value-of select="title"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_2</xsl:attribute>
				</xsl:if>
				<div align="left">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_name_<xsl:value-of select="$suffix"/></xsl:attribute>
								<xsl:if test="$mode = 'existing'">
									<a href="javascript:void(0)">
										<xsl:attribute name="onClick">fncDownloadFileElement('<xsl:value-of select="$formName"/>', '<xsl:value-of select="$structure_name"/>', '<xsl:value-of select="$suffix"/>');</xsl:attribute>
										<xsl:value-of select="file_name"/>
									</a>
							</xsl:if>
				</div>
			</td>
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_3</xsl:attribute>
				</xsl:if>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDisplayElement('<xsl:value-of select="$formName"/>', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
					<img border="0" src="/content/images/pic_edit.gif">
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
					</img>
				</a>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDeleteFileElement('<xsl:value-of select="$formName"/>', '<xsl:value-of  select="$structure_name"/>', <xsl:value-of select="$suffix"/>, ['<xsl:value-of  select="$structure_name"/>_table_header_1'], <xsl:value-of select="$max_file"/>);</xsl:attribute>
					<img border="0" src="/content/images/pic_trash.gif">
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/></xsl:attribute>
					</img>
				</a>
			</td>
		</tr>

		<tr>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td colspan="5">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_details_template_cell_1</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:if test="$mode = 'existing'">
						<xsl:attribute name="style">display:none;</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_display_details_<xsl:value-of select="$suffix"/></xsl:attribute>
					<table border="1" width="100%">
						<tr>
							<td>
								<table width="100%" cellpadding="0" cellspacing="0">
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_TITLE')"/>
										</td>
										<td>
											<input size="30" maxlength="255" type="text" value="">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_title_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="onblur">fncUpdateFileNameSection('<xsl:value-of select="$formName"/>', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_FILE')"/>
											</font>
										</td>
										<td>
											<input size="30" maxlength="255" type="file" value="">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_file_name_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="onblur">fncUpdateFileNameSection('<xsl:value-of select="$formName"/>', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
											</input>
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="$suffix"/>
												</xsl:attribute>
											</input>
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_file_id_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_file_id_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:if test="$mode = 'existing'">
														<xsl:value-of select="attachment_id"/>
													</xsl:if>
												</xsl:attribute>
											</input>
										</td>
									</tr>
								</table>
								<div>
								<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_name_section_<xsl:value-of select="$suffix"/></xsl:attribute>
								<xsl:attribute name="style">
									<!--xsl:if test="$mode = 'template'">display:none</xsl:if-->
									display:none
								</xsl:attribute>
								<table width="100%" cellpadding="0" cellspacing="0">
									<tr>
										<td width="150">
											&nbsp;
										</td>
										<td>
											<input type="text" size="35" maxlength="255">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_name_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
                              			<xsl:if test="$mode = 'existing'">
                              					<xsl:value-of select="name"/>
                              			</xsl:if>
												</xsl:attribute>
											</input>
										</td>
									</tr>
								</table>
								</div>
								<table width="100%" cellpadding="0" cellspacing="0">
									<tr>
										<td colspan="2">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="2">
											<table width="100%">
												<td align="right" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">fncUploadFileElement('<xsl:value-of select="$formName"/>', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, '', ['name'], ['name', 'file_title'], ['files_table_header_1'], <xsl:value-of select="$max_file"/>)</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
													</a>
												</td>
												<td width="10%"/>
												<td align="left" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_cancel_button_<xsl:value-of select="$suffix"/></xsl:attribute>
														<xsl:attribute name="onClick">fncAddElementCancel('<xsl:value-of select="$formName"/>', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, 'name', ['files_table_header_1']);</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
													</a>
												</td>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</xsl:template>


	<!--TEMPLATE Attachment - Control Client -->
	
	<xsl:template match="attachment" mode="control">

		<table border="0" cellspacing="0" width="570">
			<tr>
				<td width="18">&nbsp;</td>
				<td width="275">
					<xsl:value-of select="title"/>
				</td>
				<td width="275">
					<a href="javascript:void(0)">
						<xsl:attribute name="onclick">document.form_<xsl:value-of select="attachment_id"/>.submit();return false;</xsl:attribute>
							<xsl:value-of select="file_name"/>
					</a>
				</td>
			</tr>
		</table>
		<form 
			accept-charset="UNKNOWN" 
			method="POST" 
			enctype="application/x-www-form-urlencoded">
			<xsl:attribute name="action">/gtp/screen/GTPDownloadScreen/file/<xsl:value-of select="file_name"/></xsl:attribute>
			<xsl:attribute name="name">form_<xsl:value-of select="attachment_id"/></xsl:attribute>
			<input type="hidden" name="attachmentid">
				<xsl:attribute name="value"><xsl:value-of select="attachment_id"/></xsl:attribute>
			</input>
		</form>

	</xsl:template>

	<!--TEMPLATE Attachment - Reporting Bank -->
	
	<xsl:template match="attachment" mode="bank">

		<table border="0" cellspacing="0" width="570">
			<tr>
				<td width="18">&nbsp;</td>
				<td width="275">
					<xsl:value-of select="title"/>
				</td>
				<td>
					<a href="javascript:void(0)">
						<xsl:attribute name="onclick">document.form_<xsl:value-of select="attachment_id"/>.submit();return false;</xsl:attribute>
							<xsl:value-of select="file_name"/>
					</a>
				</td>
			</tr>
		</table>
		<form 
			accept-charset="UNKNOWN" 
			method="POST" 
			enctype="application/x-www-form-urlencoded">
			<xsl:attribute name="action">/gtp/screen/GTPDownloadScreen/file/<xsl:value-of select="file_name"/></xsl:attribute>
			<xsl:attribute name="name">form_<xsl:value-of select="attachment_id"/></xsl:attribute>
			<input type="hidden" name="attachmentid">
				<xsl:attribute name="value"><xsl:value-of select="attachment_id"/></xsl:attribute>
			</input>
		</form>

	</xsl:template>

	<!-- Hidden Collection File Details -->
	<xsl:template name="FILES_UPLOAD_DETAILS_HIDDEN">
      <input type="hidden">
      	<xsl:attribute name="name">files_details_position_<xsl:value-of select="position()"/></xsl:attribute>
      	<xsl:attribute name="value"><xsl:value-of select="position()"/></xsl:attribute>
      </input>
      <input type="hidden">
      	<xsl:attribute name="name">files_details_file_id_<xsl:value-of select="position()"/></xsl:attribute>
      	<xsl:attribute name="value"><xsl:value-of select="file_id"/></xsl:attribute>
      </input>
      <input type="hidden">
      	<xsl:attribute name="name">files_details_file_name_<xsl:value-of select="position()"/></xsl:attribute>
      	<xsl:attribute name="value"><xsl:value-of select="file_name"/></xsl:attribute>
      </input>
      <input type="hidden">
      	<xsl:attribute name="name">files_details_name_<xsl:value-of select="position()"/></xsl:attribute>
      	<xsl:attribute name="value"><xsl:value-of select="name"/></xsl:attribute>
      </input>
      <input type="hidden">
      	<xsl:attribute name="name">files_details_title_<xsl:value-of select="position()"/></xsl:attribute>
      	<xsl:attribute name="value"><xsl:value-of select="file_title"/></xsl:attribute>
      </input>
	</xsl:template>
</xsl:stylesheet>