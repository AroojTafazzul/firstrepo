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

	<xsl:import href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:import href="../com_attachment.xsl"/>
	<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="executeImage"><xsl:value-of select="$images_path"/>execute.png</xsl:param>
	
	
	<xsl:template match="/">
		<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_attachment.js"/>
		<script type="text/javascript">
			<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script type="text/javascript" src="/content/OLD/javascript/com_currency.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/trade_create_document.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_amount.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_date.js"></script>

		<xsl:apply-templates select="document"/>
	</xsl:template>



	<xsl:template match="document">
	
		<!--Variable that holds the tnx type code-->
		<xsl:variable name="tnxTypeCode"><xsl:value-of select="tnx_type_code"/></xsl:variable>
		
		<!-- Include some eventual additional elements -->
		<xsl:call-template name="client_addons"/>
		
		<table border="0" width="100%" cellspacing="2" cellpadding="4" class="FORMTABLEBORDER">
		<tr>
		<td align="center" class="FORMTABLE">
		
		<table border="0">
		<tr>
		<td align="center">
			<table border="0" cellspacing="2" cellpadding="8">
				<tr>
					<td align="middle" valign="center">
						<a href="javascript:void(0)" onclick="fncPerform('save');return false;">
							<img border="0" src="/content/images/pic_form_save.gif"></img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)" onclick="fncPerform('cancel');return false;">
							<img border="0" src="/content/images/pic_form_cancel.gif"></img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)" onclick="fncPerform('help');return false;">
							<img border="0" src="/content/images/pic_form_help.gif"></img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_HELP')"/>
						</a>
					</td>
				</tr>
			</table>
			
		</td>
		</tr>
		<tr>
		<td align="left">
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
		
			<p><br/></p>
	
			<form name="fakeform1">
	
				<!--Insert the Branch Code and Company ID as hidden fields-->
				<input type="hidden" name="brch_code"><xsl:attribute name="value"><xsl:value-of select="brch_code"/></xsl:attribute></input>
				<input type="hidden" name="company_id"><xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute></input>
				<input type="hidden" name="document_id"><xsl:attribute name="value"><xsl:value-of select="document_id"/></xsl:attribute></input>
				<input type="hidden" name="code"><xsl:attribute name="value"><xsl:value-of select="code"/></xsl:attribute></input>
				<input type="hidden" name="tnx_id"><xsl:attribute name="value"><xsl:value-of select="tnx_id"/></xsl:attribute></input>
				<input type="hidden" name="ref_id"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
				<input type="hidden" name="type"><xsl:attribute name="value"><xsl:value-of select="type"/></xsl:attribute></input>
				<input type="hidden" name="version"><xsl:attribute name="value"><xsl:value-of select="version"/></xsl:attribute></input>
				<input type="hidden" name="cust_ref_id"><xsl:attribute name="value"><xsl:value-of select="cust_ref_id"/></xsl:attribute></input>
				<!-- We store the initial format -->
				<input type="hidden" name="old_format"><xsl:attribute name="value"><xsl:value-of select="format"/></xsl:attribute></input>
				<!-- The format may be modified within the form -->
				<input type="hidden" name="format"><xsl:attribute name="value"><xsl:value-of select="format"/></xsl:attribute></input>
				<input type="hidden" name="title"><xsl:attribute name="value"><xsl:value-of select="title"/></xsl:attribute></input>
				
				<!--References-->
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="1">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REFERENCES')"/></b>
						</td>
					</tr>
				</table>
				<table border="0" width="570" cellpadding="0" cellspacing="0">
				
					<!-- Reminder of the folder details. -->
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_FOLDER_REF_ID')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="ref_id"/></font>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CUST_REF_ID')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="cust_ref_id"/></font>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TYPE')"/></td>
						<td>
							<xsl:choose>
								<xsl:when test="code[.='00']">
									<font class="REPORTDATA"><xsl:value-of select="title"/></font>
								</xsl:when>
								<xsl:otherwise>
									<xsl:variable name="localization_key"><xsl:value-of select="code"/></xsl:variable>
									<font class="REPORTDATA"><xsl:value-of select="localization:getDecode($language, 'C064', $localization_key)"/></font>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DESCRIPTION')"/></td>
						<td>
							<input type="text" size="30" maxlength="35" name="description" onblur="fncRestoreInputStyle('fakeform1','description');">
								<xsl:attribute name="value"><xsl:value-of select="description"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PREPARATION_DATE')"/></td>
						<td>
							<input type="text" size="10" maxlength="10" name="prep_date" onblur="fncRestoreInputStyle('fakeform1','prep_date');fncCheckPreparationDate(this);">
								<xsl:attribute name="value"><xsl:value-of select="prep_date"/></xsl:attribute>
							</input><script>DateInput('prep_date','<xsl:value-of select="prep_date"/>')</script>
						</td>
					</tr>	
					<tr>
						<td>&nbsp;</td>
					</tr>	
				</table>
			
			</form>
			<form 
				name="realform" 
				accept-charset="UNKNOWN" 
				method="POST" 
				action="/gtp/screen/DocumentManagementScreen" 
				enctype="multipart/form-data">
				
				<!-- Upload Type section -->
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_BOLERO_UPLOAD')"/></td>
						<td>
							<input type="checkbox" name="check_bolero">
								<xsl:attribute name="onclick">fncChooseBoleroFormat(this);</xsl:attribute>
								<xsl:if test="format[.='BXD']">
									<xsl:attribute name="checked"/>
								</xsl:if>
							</input>
						</td>
					</tr>
				</table>
				<!-- Bolero Upload section -->
				<div id="bolero_upload" style="display:none">
					<table border="0" cellpadding="0" cellspacing="0" width="100%">
						<tr><td>&nbsp;</td></tr>
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170">
								<font class="FORMMANDATORY"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_BOLERO_DTD')"/></font>
							</td>
							<td>
				           	<input type="hidden" name="add_bolero_upload_dtd_code" onfocus="blur();">
				        		<xsl:attribute name="value"></xsl:attribute>
				           	</input>
				           	<input type="text" size="35" maxlength="35" name="add_bolero_upload_dtd" onfocus="blur();">
				        		<xsl:attribute name="value"></xsl:attribute>
				           	</input>
									&nbsp;
									<a name="anchor_search_bolero_dtd" href="javascript:void(0)">
										<xsl:attribute name="onclick">fncSearchPopup('codevalue', 'realform', "['add_bolero_upload_dtd_code','add_bolero_upload_dtd']", 'C008');return false;</xsl:attribute>
										<img border="0" src="/content/images/pic_search.gif" name="img_search_bolero_dtd">
											<xsl:attribute name="alt">Search Bolero DTD</xsl:attribute>
										</img>
									</a>
							</td>
						</tr>
					</table>
				</div>
					<script type="text/javascript">fncChooseBoleroFormat(document.realform.check_bolero);</script>
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_NAME')"/>:</td>
						<td>
							<input type="hidden" name="operation" value="SAVE"/>
							<input type="hidden" name="referenceid"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
							<input type="hidden" name="option" value="DOCUMENT"/>
							<input type="hidden" name="mode" value="DRAFT"/>
							<input type="hidden" name="TransactionData"/>
							<input type="hidden" name="code"><xsl:attribute name="value"><xsl:value-of select="code"/></xsl:attribute></input>
							<input type="hidden" name="format"><xsl:attribute name="value"><xsl:value-of select="format"/></xsl:attribute></input>
							<input type="hidden" name="attIds" value=""/>
							<input type="hidden" name="type"><xsl:attribute name="value"><xsl:value-of select="type"/></xsl:attribute></input>
						</td>
					</tr>
				</table>

				
			</form>
			
	
			<p><br/></p>
			
		</td>
		</tr>
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
								<img border="0" src="/content/images/pic_up.gif">
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
						<xsl:attribute name="onClick">fncPreloadImages('/content/images/pic_search.gif', '<xsl:value-of select="utils:getImagePath($executeImage)"/>', '/content/images/pic_edit.gif', '/content/images/pic_trash.gif'); fncLaunchProcess("fncAddElement('sendfiles', 'files', '')");</xsl:attribute>
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
		
		<tr>
		<td align="center">
		
			<table border="0" cellspacing="2" cellpadding="8">
				<tr>
					<td align="middle" valign="center">
						<a href="javascript:void(0)" onclick="heckLostAttachments();fncPerform('save');return false;">
							<img border="0" src="/content/images/pic_form_save.gif"></img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)" onclick="fncPerform('cancel');return false;">
							<img border="0" src="/content/images/pic_form_cancel.gif"></img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)" onclick="fncPerform('help');return false;">
							<img border="0" src="/content/images/pic_form_help.gif"></img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_HELP')"/>
						</a>
					</td>
				</tr>
			</table>
			
		</td>
		</tr>
		</table>
		
		</td>
		</tr>
		</table>
	
	</xsl:template>
	
	
	
</xsl:stylesheet>
