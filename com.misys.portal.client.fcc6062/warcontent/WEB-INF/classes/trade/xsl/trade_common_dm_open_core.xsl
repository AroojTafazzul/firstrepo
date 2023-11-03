<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization converttools">
		
<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:import href="product_addons.xsl"/>
	<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="trashImage"><xsl:value-of select="$images_path"/>pic_trash.gif</xsl:param>
	<xsl:param name="searchGifImage"><xsl:value-of select="$images_path"/>pic_search.gif</xsl:param>
	<xsl:param name="formModifyImage"><xsl:value-of select="$images_path"/>pic_form_modify.gif</xsl:param>
	<xsl:param name="formPlusImage"><xsl:value-of select="$images_path"/>pic_form_plus.gif</xsl:param>
	<xsl:param name="formCancelImage"><xsl:value-of select="$images_path"/>pic_form_cancel.gif</xsl:param>
	<xsl:param name="formHelpImage"><xsl:value-of select="$images_path"/>pic_form_help.gif</xsl:param>
	<xsl:param name="formTrashImage"><xsl:value-of select="$images_path"/>pic_form_trash.gif</xsl:param>
	<xsl:param name="endImage"><xsl:value-of select="$images_path"/>pic_end.gif</xsl:param>
	
	
	
	<!-- -->
	<!--TEMPLATE Main for document folder opening-->
	<!-- -->
	<xsl:template match="dm_tnx_record" mode="open">
		<xsl:apply-templates select=".">
			<xsl:with-param name="operation">open</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	
	<!-- -->
	<!--TEMPLATE Main for document folder versioning-->
	<!-- -->
	<xsl:template match="dm_tnx_record" mode="version">
		<xsl:apply-templates select=".">
			<xsl:with-param name="operation">version</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	
	<!-- -->
	<!--TEMPLATE Common for document folder -->
	<!-- -->
	<xsl:template match="dm_tnx_record">
		<xsl:param name="operation"/>
	
		<!--Variable that holds the tnx type code-->
		<xsl:variable name="tnxTypeCode"><xsl:value-of select="tnx_type_code"/></xsl:variable>
		<!--Variable that holds the current number of documents that is going to be shown in the upload screen-->
		<xsl:variable name="documentsNumber">
			<xsl:choose>
				<xsl:when test="documents/document">
					<xsl:apply-templates select="documents/document" mode="count"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<!-- Include some eventual additional elements -->
		<xsl:call-template name="client_addons"/>
		
		<table border="0" width="100%" cellspacing="2" cellpadding="4" class="FORMTABLEBORDER">
		<tr>
		<td align="center" class="FORMTABLE">
		
		<table border="0">
		
		<tr>
		<td align="left">
		
			<p><br/></p>
	
			<form name="fakeform1" onsubmit="return false;">
	
				<!--Insert the Branch Code and Company ID as hidden fields-->
				
				<input type="hidden" name="brch_code"><xsl:attribute name="value"><xsl:value-of select="brch_code"/></xsl:attribute></input>
				<input type="hidden" name="product_code"><xsl:attribute name="value"><xsl:value-of select="product_code"/></xsl:attribute></input>
				<input type="hidden" name="company_id"><xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute></input>
				<input type="hidden" name="company_name"><xsl:attribute name="value"><xsl:value-of select="company_name"/></xsl:attribute></input>
				<input type="hidden" name="tnx_id"><xsl:attribute name="value"><xsl:value-of select="tnx_id"/></xsl:attribute></input>
				<input type="hidden" name="ref_id"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
				<input type="hidden" name="amd_no"><xsl:attribute name="value"><xsl:value-of select="amd_no"/></xsl:attribute></input>
				<input type="hidden" name="parent_ref_id"><xsl:attribute name="value"><xsl:value-of select="parent_ref_id"/></xsl:attribute></input>
				<input type="hidden" name="parent_product_code"><xsl:attribute name="value"><xsl:value-of select="parent_product_code"/></xsl:attribute></input>
				<input type="hidden" name="parent_bo_ref_id"><xsl:attribute name="value"><xsl:value-of select="parent_bo_ref_id"/></xsl:attribute></input>
				<input type="hidden" name="sub_tnx_type_code"><xsl:attribute name="value"><xsl:value-of select="sub_tnx_type_code"/></xsl:attribute></input>
				<input type="hidden" name="tnx_type_code"><xsl:attribute name="value"><xsl:value-of select="tnx_type_code"/></xsl:attribute></input>
		<!-- Previous ctl date, used for synchronisation issues -->
		<input type="hidden" name="old_ctl_dttm"><xsl:attribute name="value"><xsl:value-of select="ctl_dttm"/></xsl:attribute></input>
				
				<!-- -->
				<!-- Folder Details-->
				
				<!-- General Details-->
				<table border="0" width="600" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="3">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/></b>
						</td>
					</tr>
				</table>
		
				<table border="0" width="600" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_FOLDER_REF_ID')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="ref_id"/></font>
						</td>
					</tr>
					<xsl:if test="cust_ref_id[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/></td>
							<td><font class="REPORTDATA"><xsl:value-of select="cust_ref_id"/></font></td>
						</tr>
					</xsl:if>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="appl_date"/></font></td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_PREPARATION_DATE')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="prep_date"/></font></td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_AMOUNT')"/></td>
						<td>
							<font class="REPORTBLUE">
								<xsl:value-of select="cur_code"/>&nbsp;
								<xsl:if test="dm_amt[.!='']">
									<xsl:value-of select="dm_amt"/>
								</xsl:if>
							</font>
						</td>
					</tr>
				</table>
				<br/>
				
				<!--Parties Details-->
				<xsl:if test="counterparty_name[.!=''] or counterparty_address_line_1[.!=''] or counterparty_address_line_2[.!=''] or counterparty_dom[.!=''] or counterparty_reference[.!='']">
		
					<table border="0" width="600" cellpadding="0" cellspacing="0">
						<tr>
							<td class="FORMH1" colspan="3">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PARTIES_DETAILS')"/></b>
							</td>
						</tr>
					</table>
						
					<br/>
				
					<!--Consignee Details-->
					<table border="0" cellspacing="0" width="600">
						<tr>
							<td width="15">&nbsp;</td>
							<td class="FORMH2" align="left">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONSIGNEE_DETAILS')"/></b>
							</td>
						</tr>
					</table>
					<table border="0" cellspacing="0" width="600">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
							<td><font class="REPORTDATA"><xsl:value-of select="counterparty_name"/></font></td>
						</tr>
						<xsl:if test="counterparty_address_line_1[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="counterparty_address_line_1"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="counterparty_address_line_2[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170">
									<xsl:choose>
										<xsl:when test="counterparty_address_line_2[.!='']">&nbsp;</xsl:when>
										<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></xsl:otherwise>
									</xsl:choose>
								</td>
								<td><font class="REPORTDATA"><xsl:value-of select="counterparty_address_line_2"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="counterparty_dom[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170">
									<xsl:choose>
										<xsl:when test="counterparty_address_line_1[.!=''] or counterparty_address_line_2[.!='']">&nbsp;</xsl:when>
										<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></xsl:otherwise>
									</xsl:choose>
								</td>
								<td><font class="REPORTDATA"><xsl:value-of select="counterparty_dom"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="counterparty_reference[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="counterparty_reference"/></font></td>
							</tr>
						</xsl:if>
					</table>
					<br/>
					
				</xsl:if>
				
				<!--Versionned Documents -->
				<table border="0" width="600" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="3">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DOCUMENTS_VERSIONNED')"/></b>
						</td>
					</tr>
				</table>
				
				<br/>
				<table border="0" width="600" cellpadding="0" cellspacing="0">
					<xsl:choose>
						<xsl:when test="versionned_documents/document">
							<tr>
								<td align="center">
									<table border="0" width="600" cellpadding="0" cellspacing="1">
										<tr>
											<th class="FORMH2" nowrap="nowrap" width="5%" align="center"></th>
											<th class="FORMH2" align="center" width="30%" nowrap="nowrap"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_REFERENCE_FULL')"/></th>
											<th class="FORMH2" align="center" width="5%" nowrap="nowrap"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_VERSION_FULL')"/></th>
											<th class="FORMH2" align="center" width="30%" nowrap="nowrap"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_TYPE')"/></th>
											<th class="FORMH2" align="center" width="30%" colspan="2"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_VIEW')"/></th>
											<!--<th class="FORMH2" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_OPEN')"/></th>-->
										</tr>
										<!-- Call the template for documents already prepared-->
										<xsl:apply-templates select="versionned_documents/document" mode="list_versionned"/>
									</table>
								</td>
							</tr>
						</xsl:when>
						<xsl:otherwise>
							<tr>
								<td width="40">&nbsp;</td>
								<td><b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_NONE_VERSIONNED')"/></b></td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
				</table>
							
				<p><br/></p>
				
				<!-- -->
				<!--Documents Under Preparation -->
				<!-- -->
		
				<table border="0" width="600" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="3">
							<xsl:choose>
								<xsl:when test="$operation = 'version'">
									<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DOCUMENTS_AVAILABLE_FOR_VERSION')"/></b>
								</xsl:when>
								<xsl:otherwise>
									<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DOCUMENTS_UNDER_PREPARATION')"/></b>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
				</table>

				<br/>
				
				<xsl:choose>
					<xsl:when test="documents/document[document_id!='']">
						<table border="0" width="600" cellpadding="0" cellspacing="0">
							<tr>
								<td align="center">
		
									<table border="0" width="600" cellpadding="0" cellspacing="1">
										<tr>
											<th class="FORMH2" nowrap="nowrap" width="5%" align="center"></th>
											<th class="FORMH2" align="center" width="25%" nowrap="nowrap"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_REFERENCE_FULL')"/></th>
											<th class="FORMH2" align="center" width="5%" nowrap="nowrap"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_VERSION_FULL')"/></th>
											<th class="FORMH2" align="center" width="30%" nowrap="wrap"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_TYPE')"/></th>
											<xsl:choose>
												<xsl:when test="$operation = 'version'"></xsl:when>
												<xsl:otherwise>
													<th class="FORMH2" align="center" nowrap="nowrap" width="30%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_STATUS')"/></th>
												</xsl:otherwise>
											</xsl:choose>
											<th class="FORMH2" align="center" nowrap="nowrap" colspan="2" width="30%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_PREVIEW')"/></th>
											<xsl:choose>
												<xsl:when test="$operation = 'version'">
													<th class="FORMH2" align="center" width="5%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_SELECT')"/></th>
												</xsl:when>
												<xsl:otherwise>
													<th class="FORMH2" align="center" width="5%">
														<img border="0" >
															<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($trashImage)"/></xsl:attribute>
															<xsl:attribute name="name">img_remove_document</xsl:attribute>
														</img>
													</th>
												</xsl:otherwise>
											</xsl:choose>
										</tr>
										
										<!-- Call the template for documents already prepared-->
										<xsl:choose>
											<!-- The incomplete documents are not proposed for version-->
											<xsl:when test="$operation = 'version'">
												<xsl:apply-templates select="documents/document[tnx_stat_code!='01']" mode="version"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="documents/document" mode="preparation"/>
											</xsl:otherwise>
										</xsl:choose>
										
									</table>
								</td>
							</tr>
						</table>
					</xsl:when>
					<xsl:otherwise>
						<table border="0" width="600" cellpadding="0" cellspacing="0">
							<tr>
								<td width="40">&nbsp;</td>
								<td><b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_NONE_UNDER_PREPARATION')"/></b></td>
							</tr>
						</table>
					</xsl:otherwise>
				</xsl:choose>
					
				<br/>

			
				<!-- -->
				<!-- Form proposed in order to ADD documents, in the case of standard opening -->
				<!-- -->
				<xsl:choose>
				<xsl:when test="$operation = 'version'">
				</xsl:when>
				<xsl:otherwise>
					<!-- We store the formats for each document code in a JavaScript array -->
					<script>
						dojo.ready(function(){
							misys._config = misys._config || {};
							misys._config.codeFormats = [];
							<xsl:apply-templates select="potential_documents/document" mode="code_format"/>
						});
					</script>
				
					<!-- Add document anchor -->
					<a id="add_document_anchor" href="javascript:void(0)" onclick="document.fakeform1.add_mode[0].checked = true; document.fakeform1.add_mode[1].checked = false; document.fakeform1.add_mode[2].checked = false; document.fakeform1.add_mode[3].checked = false; fncShowObject('add_document_anchor', false); fncShowObject('add_document', true);"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_ADD')"/></a>
					<p/>
					
					<!-- Main add document form -->
					<div id="add_document" style="display:none">
					<table border="1" width="600">
						<tr>
						<td>
						<table border="0" cellpadding="0" cellspacing="0" width="100%">
							<tr><td>&nbsp;</td></tr>
							<tr><td width="40">&nbsp;</td><td>
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
							
							<tr>
								<td width="10%">
								 	<input type="radio" name="add_mode" value="01" onclick="fncShowFromScratchSection()">
											<xsl:attribute name="checked"/>
									</input>
								</td>
								<td width="85%">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_ADD_NEW')"/>
								</td>
							</tr>
							<tr>
								<td>
									<input type="radio" name="add_mode" value="02" onclick="fncShowUploadSection()">
										<xsl:if test="add_mode[. = '02']">
											<xsl:attribute name="checked"/>
										</xsl:if>
									</input>
								</td>
								<td>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_ADD_UPLOAD')"/>
								</td>
							</tr>
							<tr>
								<td>
									<input type="radio" name="add_mode" value="03" onclick="fncShowNewVersionSection(); fncHandleVersion(this);">
										<xsl:if test="add_mode[. = '03']">
											<xsl:attribute name="checked"/>
										</xsl:if>
									</input>
								</td>
								<td>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_ADD_VERSION')"/>
								</td>
							</tr>
							<tr>
								<td>
									<input type="radio" name="add_mode" value="04" onclick="fncShowFromExistingSection()">
										<xsl:if test="add_mode[. = '04']">
											<xsl:attribute name="checked"/>
										</xsl:if>
									</input>
								</td>
								<td>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_ADD_COPY')"/>
								</td>
							</tr>
							</table>
							</td></tr>
							<tr><td>&nbsp;</td></tr>
						</table>
						</td></tr>
						<tr><td>
						
						<!-- From scratch section -->
						<div id="from_scratch" style="display:block">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr><td>&nbsp;</td></tr>
								<tr>
									<td width="40">&nbsp;</td>
									<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TYPE')"/></td>
									<td>
										<select onchange="fncPopulateFormats(this,document.fakeform1.add_new_format);">
											<xsl:attribute name="name">add_new_code</xsl:attribute>
											<!-- Empty code selected by default -->
											<option>
												<xsl:attribute name="name"/>
												<xsl:attribute name="value"/>
												<xsl:attribute name="selected"/>
											</option>
											<!-- Others -->
											<xsl:apply-templates select="potential_documents/document" mode="code"/>
										</select>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_FORMAT')"/></td>
									<td>
										<select>
											<xsl:attribute name="name">add_new_format</xsl:attribute>
										</select>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>
										<input type="checkbox" name="add_new_from_template">
											<xsl:attribute name="checked"/>
										</input>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_USE_TEMPLATE')"/>
									</td>
								</tr>
							</table>
						</div>
					
						<!-- Upload section -->
						<div id="upload" style="display:none">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr><td>&nbsp;</td></tr>
								<tr>
									<td width="40">&nbsp;</td>
									<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TYPE')"/></td>
									<td>
										<select onchange="if (add_upload_code.value != '00') add_upload_other_code.value = '';">
											<xsl:attribute name="name">add_upload_code</xsl:attribute>
											<!-- Empty code selected by default -->
											<option>
												<xsl:attribute name="name"/>
												<xsl:attribute name="value"/>
												<xsl:attribute name="selected"/>
											</option>
											<!-- Add the OTHER option -->
											<option>
												<xsl:attribute name="name">00</xsl:attribute>
												<xsl:attribute name="value">00</xsl:attribute>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_OTHER_FORMAT')"/>
											</option>
											<!-- Add the OTHER existing known codes -->
											<xsl:apply-templates select="potential_documents/document" mode="code"/>
										</select>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>
										<input type="text" size="30" maxlength="35" name="add_upload_other_code" onfocus="if (add_upload_code.value != '00') blur();" onblur="fncRestoreInputStyle('fakeform1','add_upload_other_code');">
											<xsl:attribute name="value"></xsl:attribute>
										</input>
									</td>
								</tr>
							</table>
						</div>

						<!-- New version section -->
						<div id="new_version" style="display:none">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr><td>&nbsp;</td></tr>
								<tr>
									<td width="40">&nbsp;</td>
									<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_SELECT')"/></td>
									<td>
										<input type="hidden" size="20" maxlength="20" name="add_version_folder" onfocus="blur();" onblur="fncHandleVersion(this);">
											<xsl:attribute name="value"></xsl:attribute>
										</input>
										<input type="hidden" size="20" maxlength="20" name="add_version_document_id" onfocus="blur();" onblur="fncHandleVersion(this);">
											<xsl:attribute name="value"></xsl:attribute>
										</input>
								            	<input type="text" size="20" maxlength="20" name="add_version_cust_ref_id" onfocus="blur();" onblur="fncHandleVersion(this);">
									        		<xsl:attribute name="value"></xsl:attribute>
								            	</input>
										&nbsp;&nbsp;<a name="anchor_add_copy" href="javascript:void(0)">
											<xsl:attribute name="onclick">fncSearchPopup('documents', 'fakeform1',"['add_version_cust_ref_id','add_version_folder','add_version_document_id']",'<xsl:value-of select="ref_id"/>', 'DocumentListPopup','<xsl:value-of select="product_code"/>');return false;</xsl:attribute>
											<img border="0" name="img_search_document_copy">
												<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
												<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_DOCUMENT')"/></xsl:attribute>
											</img>
										</a>
									</td>
								</tr>
							</table>
						</div>						
					
						<!-- From existing section -->
						<div id="from_existing" style="display:none">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr><td>&nbsp;</td></tr>
								<tr>
									<td width="40">&nbsp;</td>
									<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_SELECT')"/></td>
									<td>
										<input type="text" size="20" maxlength="20" name="add_copy_folder" onfocus="blur();">
											<xsl:attribute name="value"></xsl:attribute>
										</input>
										<input type="hidden" size="10" maxlength="22" name="add_copy_document_id" onfocus="blur();">
											<xsl:attribute name="value"></xsl:attribute>
										</input>
										&nbsp;&nbsp;<a name="anchor_add_copy" href="javascript:void(0)">
										<xsl:attribute name="onclick">fncSearchPopup('folders', 'fakeform1',"['add_copy_cust_ref_id','add_copy_folder','add_copy_document_id']","", 'DocumentListPopup', '<xsl:value-of select="product_code"/>');return false;</xsl:attribute>
										<img border="0" name="img_search_document_copy">
											<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
											<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_DOCUMENT')"/></xsl:attribute>
										</img>
										</a>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>
										<input type="text" size="20" maxlength="20" name="add_copy_cust_ref_id" onfocus="blur();">
											<xsl:attribute name="value"></xsl:attribute>
										</input>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TYPE')"/></td>
									<td>
										<select>
											<xsl:attribute name="name">add_copy_code</xsl:attribute>
											<!-- Empty code selected by default -->
											<option>
												<xsl:attribute name="name"/>
												<xsl:attribute name="value"/>
												<xsl:attribute name="selected"/>
											</option>
											<xsl:apply-templates select="potential_documents/document" mode="code"/>
										</select>
									</td>
								</tr>
							</table>
						</div>
						
						<!-- Document reference -->
						<div id="document_reference" style="display:block">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr><td>&nbsp;</td></tr>
								<tr>
									<td width="40">&nbsp;</td>
									<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CUST_REF_ID')"/></td>
									<td>
										<input type="text" size="20" maxlength="20" name="add_cust_ref_id" onfocus="fncHandleDocumentReference(this);" onblur="fncRestoreInputStyle('fakeform1','add_cust_ref_id');">
											<xsl:attribute name="value"></xsl:attribute>
										</input>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DESCRIPTION')"/></td>
									<td>
										<input type="text" size="30" maxlength="35" name="add_description" onblur="fncRestoreInputStyle('fakeform1','add_description');">
											<xsl:attribute name="value"></xsl:attribute>
										</input>
									</td>
								</tr>
							</table>
						</div>
						
						<p/>
						
						<!-- Cancel anchor -->
						<table width="100%">
							<tr>
							<td align="center">
								<a href="javascript:void(0)" onClick="fncShowObject('add_document_anchor', true); fncCancelDocumentAdd();">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
								</a>
							</td>
							</tr>
						</table>
						
						</td></tr>
						</table>
						</div>
					
					<p><br/></p>


				</xsl:otherwise>
				</xsl:choose>
				
			</form>
			
			<!-- The following form is used for the fianl POST -->
			<form 
				name="realform" 
				accept-charset="UNKNOWN" 
				method="POST" 
				action="/gtp/screen/DocumentManagementScreen">

				<input type="hidden" name="referenceid"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
				<input type="hidden" name="productcode"><xsl:attribute name="value"><xsl:value-of select="product_code"/></xsl:attribute></input>
				<xsl:choose>
					<xsl:when test="$operation = 'version'">
						<input type="hidden" name="operation" value="VERSION"/>
					</xsl:when>
					<xsl:when test="$operation = 'open'">
						<input type="hidden" name="operation" value="SAVE"/>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="operation"/>
					</xsl:otherwise>
				</xsl:choose>
				<input type="hidden" name="option"></input>
				<input type="hidden" name="document_id"></input>
				<input type="hidden" name="document_tnx_id"></input>
				<input type="hidden" name="TransactionData"/>

			</form>
		
			<p><br/></p>
			
		</td>
		</tr>
		<tr>
		<td align="center">
		
			<table border="0" cellspacing="2" cellpadding="8">
				<tr>
					<xsl:choose>
						<xsl:when test="$operation='version'">
							<td align="middle" valign="center">
								<a href="javascript:void(0)" onclick="fncPerform('version');return false;">
									<img border="0" >
										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formModifyImage)"/></xsl:attribute>
									</img><br/>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_VERSION')"/>
								</a>
							</td>
						</xsl:when>
						<xsl:otherwise>
							<td align="middle" valign="center">
								<a href="javascript:void(0)" onclick="fncPerform('add');return false;">
									<img border="0">
										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formPlusImage)"/></xsl:attribute>
									</img><br/>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')"/>
								</a>
							</td>
						</xsl:otherwise>
					</xsl:choose>
					<td align="middle" valign="center">
						<a href="javascript:void(0)" onclick="fncPerform('cancel');return false;">
							<img border="0" >
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formCancelImage)"/></xsl:attribute>
							</img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)" onclick="fncPerform('help');return false;">
							<img border="0" >
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formHelpImage)"/></xsl:attribute>
							</img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_HELP')"/>
						</a>
					</td>
					<xsl:choose>
						<xsl:when test="$operation='version'">
						</xsl:when>
						<xsl:otherwise>
							<td align="middle" valign="center">
								<a href="javascript:void(0)" onclick="fncPerform('delete');return false;">
									<img border="0">
										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formTrashImage)"/></xsl:attribute>
									</img><br/>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')"/>
								</a>
							</td>
						</xsl:otherwise>
					</xsl:choose>
				</tr>
			</table>
			
		</td>
		</tr>
		</table>
		
		</td>
		</tr>
		</table>

	</xsl:template>


	<xsl:template match="documents/document" mode="preparation">
		<xsl:choose>
			<!--Filter out the potential empty generated documents-->
			<xsl:when test="type[.='01'] and document_id[.='']">
				<!-- Nothing to do -->
			</xsl:when>
			<!--The file hasn't been uploaded yet-->
			<xsl:otherwise>
				<xsl:call-template name="collection_document_preparation">
					<xsl:with-param name="document_key" select="position()"/>
					<xsl:with-param name="tnx_id" select="tnx_id"/>
					<xsl:with-param name="tnx_stat_code" select="tnx_stat_code"/>
					<xsl:with-param name="document_title" select="title"/>
					<xsl:with-param name="document_cust_ref_id" select="cust_ref_id"/>
					<xsl:with-param name="document_version" select="version"/>
					<xsl:with-param name="document_code" select="code"/>
					<xsl:with-param name="document_id" select="document_id"/>
					<xsl:with-param name="attachment_id" select="attachment_id"/>
					<xsl:with-param name="document_type" select="type"/>
					<xsl:with-param name="document_format" select="format"/>
					<xsl:with-param name="ref_id" select="ref_id"/>
					<xsl:with-param name="transformation_node" select="transformation"/>
					<xsl:with-param name="mode">preparation</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="documents/document" mode="version">
		<xsl:choose>
			<!--Filter out the potential empty generated documents-->
			<xsl:when test="type[.='01'] and document_id[.='']">
				<!-- Nothing to do -->
			</xsl:when>
			<!--Filter out the incomplete documents
			<xsl:when test="tnx_stat_code[.='01']">
			</xsl:when>
			-->

			<!--The file hasn't been uploaded yet-->
			<xsl:otherwise>
				<xsl:call-template name="collection_document_preparation">
					<xsl:with-param name="document_key" select="position()"/>
					<xsl:with-param name="tnx_id" select="tnx_id"/>
					<xsl:with-param name="tnx_stat_code" select="tnx_stat_code"/>
					<xsl:with-param name="document_title" select="title"/>
					<xsl:with-param name="document_cust_ref_id" select="cust_ref_id"/>
					<xsl:with-param name="document_version" select="version"/>
					<xsl:with-param name="document_code" select="code"/>
					<xsl:with-param name="document_id" select="document_id"/>
					<xsl:with-param name="attachment_id" select="attachment_id"/>
					<xsl:with-param name="document_type" select="type"/>
					<xsl:with-param name="document_format" select="format"/>
					<xsl:with-param name="ref_id" select="ref_id"/>
					<xsl:with-param name="transformation_node" select="transformation"/>
					<xsl:with-param name="mode">version</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="versionned_documents/document" mode="list_versionned">
		<xsl:choose>
			<!--Filter out the potential empty generated documents-->
			<xsl:when test="type[.='01'] and document_id[.='']">
				<!-- Nothing to do -->
			</xsl:when>
			<!--The file hasn't been uploaded yet-->
			<xsl:otherwise>
				<xsl:variable name="mode">list_versionned</xsl:variable>
				<xsl:call-template name="collection_document_versionned">
					<xsl:with-param name="document_key" select="position()"/>
					<xsl:with-param name="document_title" select="title"/>
					<xsl:with-param name="document_cust_ref_id" select="cust_ref_id"/>
					<xsl:with-param name="document_version" select="version"/>
					<xsl:with-param name="document_code" select="code"/>
					<xsl:with-param name="document_id" select="document_id"/>
					<xsl:with-param name="attachment_id" select="attachment_id"/>
					<xsl:with-param name="document_type" select="type"/>
					<xsl:with-param name="document_format" select="format"/>
					<xsl:with-param name="ref_id" select="ref_id"/>
					<xsl:with-param name="transformation_node" select="transformation"/>
					<xsl:with-param name="mode">list_versionned</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="versionned_documents/document" mode="version">
		<option>
			<xsl:attribute name="name"><xsl:value-of select="document_id"/></xsl:attribute>
			<xsl:attribute name="value"><xsl:value-of select="document_id"/></xsl:attribute>
			<xsl:attribute name="selected"/>
			<xsl:value-of select="cust_ref_id"/><xsl:if test="version[.!='']"> (<xsl:value-of select="version"/>)</xsl:if>
		</option>
	</xsl:template>

	<!--Count the number of documents-->
	<xsl:template match="documents/document" mode="count">
		<xsl:if test="position()=last()">
			<xsl:value-of select="position()"/>
		</xsl:if>
	</xsl:template>

	<!-- Display a document form-->
	<xsl:template name="collection_document_preparation">
		<xsl:param name="document_key"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="tnx_stat_code"/>
		<xsl:param name="document_cust_ref_id"/>
		<xsl:param name="document_version"/>
		<xsl:param name="document_title"/>
		<xsl:param name="document_code"/>
		<xsl:param name="document_id"/>
		<xsl:param name="attachment_id"/>
		<xsl:param name="document_type"/>
		<xsl:param name="document_format"/>
		<xsl:param name="ref_id"/>
		<xsl:param name="transformation_node"/>
		<xsl:param name="mode"/>
		
		<tr>
			<td nowrap="nowrap" align="center">&nbsp;&nbsp;<xsl:value-of select="$document_key"/>&nbsp;&nbsp;</td>
			<td nowrap="nowrap" align="left">
				<input type="hidden">
					<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_version</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_version"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_tnx_id</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_type</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_type"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_format</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_format"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_title</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_title"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_id</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_id"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_code</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_code"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_cust_ref_id</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_cust_ref_id"/></xsl:attribute>
				</input>
				<xsl:choose>
					<xsl:when test="$mode = 'version'">
						<!--
						&nbsp;&nbsp;<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('preview', '<xsl:value-of select="$document_key"/>');return false;</xsl:attribute>
							<xsl:value-of select="$document_cust_ref_id"/>
						</a>&nbsp;&nbsp;
						-->
						<xsl:value-of select="$document_cust_ref_id"/>
					</xsl:when>
					<xsl:otherwise>
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('edit', '<xsl:value-of select="$document_key"/>');return false;</xsl:attribute>
							<xsl:value-of select="$document_cust_ref_id"/>
						</a>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<!-- Document version -->
			<td align="center" nowrap="nowrap">
				<xsl:if test="(not($document_version)) or ($document_version='')">
					<xsl:text>-</xsl:text>
				</xsl:if><xsl:value-of select="$document_version"/>
			</td>
			<!-- Document code -->
			<td align="left" nowrap="wrap">
				&nbsp;<xsl:choose>
					<xsl:when test="$document_code!='00'">
						<xsl:variable name="localization_key"><xsl:value-of select="code"/></xsl:variable>
						<xsl:value-of select="localization:getDecode($language, 'C064', $document_code)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$document_title"/>
					</xsl:otherwise>
				</xsl:choose>&nbsp;
			</td>
			<!-- Document status -->
			<xsl:choose>
				<xsl:when test="$mode = 'version'"></xsl:when>
				<xsl:otherwise>
					<td align="center" nowrap="nowrap">
						&nbsp;<xsl:choose>
							<!-- Generated document : incomplete -->
							<xsl:when test="$tnx_stat_code='01'"><xsl:value-of select="localization:getDecode($language, 'N004', '01')"/></xsl:when>
							<!-- Document already uploaded : uncontrolled-->
							<xsl:when test="$tnx_stat_code='02'"><xsl:value-of select="localization:getDecode($language, 'N004', '02')"/></xsl:when>
							<!-- Document to be uploaded -->
							<xsl:otherwise>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_INCOMPLETE')"/>
							</xsl:otherwise>
						</xsl:choose>&nbsp;
					</td>
				</xsl:otherwise>
			</xsl:choose>
			<!-- Transformations -->
			<xsl:choose>
				<xsl:when test="$transformation_node and (type[.='01'] or $attachment_id[.!=''])">
					<td align="left" nowrap="nowrap">
						<xsl:if test="type[.='01'] or $attachment_id[.!='']">
							<select>
								<xsl:attribute name="name">option_<xsl:value-of select="document_id"/>_transformation</xsl:attribute>
								<!-- We hardcode the HTML control popup in the list of available output -->
				                  		<option>
				                  			<xsl:attribute name="name">N036_HTML</xsl:attribute>
				                  			<xsl:attribute name="value">N036_HTML</xsl:attribute>
				                  			<xsl:attribute name="selected"/>
				                  			<xsl:value-of select="localization:getDecode($language, 'N036', 'HTML')"/>
				                  		</option>
								<!-- We add the other transformations -->
								<xsl:apply-templates select="$transformation_node"/>
							</select>
						</xsl:if>
					</td>
					<td>
						<xsl:if test="type[.='01'] or $attachment_id[.!='']">
							<a name="anchor_preview" href="javascript:void(0)" target="_blank">
								<!-- Specific behaviour for the HTML option, where we invoke the reporting
								 popup -->
								<xsl:attribute name="onclick">var transformation = option_<xsl:value-of select="document_id"/>_transformation.options[option_<xsl:value-of select="document_id"/>_transformation.selectedIndex].value; if (transformation=='N036_HTML') fncViewDocument('<xsl:value-of select="$ref_id"/>','<xsl:value-of select="$document_id"/>','<xsl:value-of select="$tnx_id"/>'); else fncExportDocument(transformation,'<xsl:value-of select="$document_id"/>','<xsl:value-of select="$document_code"/>','<xsl:value-of select="$document_format"/>', '<xsl:value-of select="$ref_id"/>','<xsl:value-of select="$tnx_id"/>');return false;</xsl:attribute>
								<img border="0" name="img_preview">
									<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($endImage)"/></xsl:attribute>
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VIEW_ADVICE')"/></xsl:attribute>
								</img>
							</a>
						</xsl:if>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td align="center">-</td>
					<td></td>
				</xsl:otherwise>
			</xsl:choose>
			<!-- Actions -->
			<xsl:choose>
				<xsl:when test="$mode = 'version'">
					<xsl:choose>
						<xsl:when test="$tnx_stat_code='01'">
							<td align="center">-</td>
						</xsl:when>
						<xsl:otherwise>
							<td align="center">
								&nbsp;<input type="checkbox">
									<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_versionned</xsl:attribute>
								</input>&nbsp;
							</td>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<td align="center">
						<input type="checkbox">
							<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_deleted</xsl:attribute>
						</input>
					</td>
				</xsl:otherwise>
			</xsl:choose>
		</tr>
		
	</xsl:template>
	
	<!-- Display a document form-->
	<xsl:template name="collection_document_versionned">
		<xsl:param name="document_key"/>
		<xsl:param name="document_cust_ref_id"/>
		<xsl:param name="document_version"/>
		<xsl:param name="document_title"/>
		<xsl:param name="document_code"/>
		<xsl:param name="document_id"/>
		<xsl:param name="attachment_id"/>
		<xsl:param name="document_type"/>
		<xsl:param name="document_format"/>
		<xsl:param name="ref_id"/>
		<xsl:param name="transformation_node"/>
		<xsl:param name="mode"/>
		
		<tr>
			<td nowrap="nowrap" align="center">&nbsp;&nbsp;<xsl:value-of select="$document_key"/>&nbsp;&nbsp;</td>
			<td nowrap="nowrap" align="left">
				<input type="hidden">
					<xsl:attribute name="name">versionned_document_<xsl:value-of select="$document_key"/>_id</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_id"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">versionned_cust_ref_id_<xsl:value-of select="$document_id"/></xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_cust_ref_id"/></xsl:attribute>
				</input>
				<!--
				&nbsp;&nbsp;<a href="javascript:void(0)">
					<xsl:attribute name="onclick">fncPerform('view', '<xsl:value-of select="$document_key"/>');return false;</xsl:attribute>
					<xsl:value-of select="$document_cust_ref_id"/>
				</a>&nbsp;&nbsp;
				-->
				<xsl:value-of select="$document_cust_ref_id"/>
			</td>
			<!-- Document version -->
			<td align="center" nowrap="nowrap">
				<xsl:if test="(not($document_version)) or ($document_version='')">
					<xsl:text>-</xsl:text>
				</xsl:if><xsl:value-of select="$document_version"/>
			</td>
			<!-- Document code -->
			<td align="left" nowrap="nowrap">
				&nbsp;<xsl:value-of select="localization:getDecode($language, 'C064', $document_code)"/>&nbsp;
			</td>
			<!-- Transformations -->
			<xsl:choose>
				<xsl:when test="$transformation_node and (type[.='01'] or $attachment_id[.!=''])">
					<td align="left">
						<xsl:if test="type[.='01'] or $attachment_id[.!='']">
							<select>
								<xsl:attribute name="name">option_<xsl:value-of select="document_id"/>_transformation</xsl:attribute>
								<!-- We hardcode the HTML control popup in the list of available output -->
                  		<option>
                  			<xsl:attribute name="name">N036_HTML</xsl:attribute>
                  			<xsl:attribute name="value">N036_HTML</xsl:attribute>
                  			<xsl:attribute name="selected"/>
                  			<xsl:value-of select="localization:getDecode($language, 'N036', 'HTML')"/>
                  		</option>
								<!-- We add the other transformations -->
								<xsl:apply-templates select="$transformation_node"/>
							</select>
						</xsl:if>
					</td>
					<td>
						<xsl:if test="type[.='01'] or $attachment_id[.!='']">
							<a name="anchor_preview" href="javascript:void(0)" target="_blank">
								<!-- Specific behaviour for the HTML option, where we invoke the reporting
								 popup -->
								<xsl:attribute name="onclick">var transformation = option_<xsl:value-of select="document_id"/>_transformation.options[option_<xsl:value-of select="document_id"/>_transformation.selectedIndex].value; if (transformation=='N036_HTML') fncViewDocument('<xsl:value-of select="$ref_id"/>','<xsl:value-of select="$document_id"/>'); else fncExportDocument(transformation,'<xsl:value-of select="$document_id"/>','<xsl:value-of select="$document_code"/>','<xsl:value-of select="$document_format"/>', '<xsl:value-of select="$ref_id"/>');return false;</xsl:attribute>
								<img border="0" name="img_preview">
									<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($endImage)"/></xsl:attribute>
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VIEW_ADVICE')"/></xsl:attribute>
								</img>
							</a>
						</xsl:if>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td align="center">-</td>
					<td></td>
				</xsl:otherwise>
			</xsl:choose>
		</tr>
	</xsl:template>

	<xsl:template match="transformation">
		<option>
			<xsl:attribute name="name"><xsl:value-of select="transformation_code"/></xsl:attribute>
			<xsl:attribute name="value"><xsl:value-of select="transformation_code"/></xsl:attribute>
			<!--xsl:attribute name="selected"/-->
			<xsl:variable name="localization_key"><xsl:value-of select="transformation_code"/></xsl:variable>
			<xsl:value-of select="localization:getDecode($language, 'N036', $localization_key)"/>
		</option>
	</xsl:template>

	<xsl:template match="potential_documents/document" mode="code">
		<option>
			<xsl:attribute name="name"><xsl:value-of select="code"/></xsl:attribute>
			<xsl:attribute name="value"><xsl:value-of select="code"/></xsl:attribute>
			<xsl:variable name="localization_key"><xsl:value-of select="code"/></xsl:variable>
			<xsl:value-of select="localization:getDecode($language, 'C064', $localization_key)"/>
		</option>
	</xsl:template>

	<!--TEMPLATE Create the array of codes and formats-->
	<xsl:template match="potential_documents/document" mode="code_format">
		<xsl:variable name="code"><xsl:value-of select="code"/></xsl:variable>
		codeFormats['<xsl:value-of select="code"/>'] = new Array(
			 <xsl:apply-templates select="../document[code=$code]" mode="array"/>
			 '','');
	</xsl:template>
	
	<!--TEMPLATE Codes and formats (to populate the array)-->

	<xsl:template match="potential_documents/document" mode="array">
		<xsl:variable name="localization_key"><xsl:value-of select="format"/></xsl:variable>
		'<xsl:value-of select="format"/>','<xsl:value-of select="localization:getDecode($language, 'N035', $localization_key)"/>',
	</xsl:template>

	<!--TEMPLATE Codes and formats (to populate the options)-->

	<xsl:template match="potential_documents/document" mode="option">
		<option>
			<xsl:attribute name="name"><xsl:value-of select="format"/></xsl:attribute>
			<xsl:attribute name="value"><xsl:value-of select="format"/></xsl:attribute>
			<xsl:variable name="localization_key"><xsl:value-of select="format"/></xsl:variable>
			<xsl:value-of select="localization:getDecode($language, 'N035', $localization_key)"/>

		</option>
	</xsl:template>

	<xsl:template match="potential_documents/document" mode="format">
		<option>
			<xsl:attribute name="name"><xsl:value-of select="format"/></xsl:attribute>
			<xsl:attribute name="value"><xsl:value-of select="format"/></xsl:attribute>
			<xsl:attribute name="selected"/>
			<xsl:variable name="localization_key"><xsl:value-of select="format"/></xsl:variable>
			<xsl:value-of select="localization:getDecode($language, 'N035', $localization_key)"/>
		</option>
	</xsl:template>


</xsl:stylesheet>
