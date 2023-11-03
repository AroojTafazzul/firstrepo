<?xml version="1.0" encoding="UTF-8" ?>
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

	<xsl:import href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:import href="../../core/xsl/common/com_cross_references.xsl"/>
	
	<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="formTrashImage"><xsl:value-of select="$images_path"/>pic_form_trash.gif</xsl:param>
	<xsl:param name="formCancelImage"><xsl:value-of select="$images_path"/>pic_form_cancel.gif</xsl:param>
	<xsl:param name="formHelpImage"><xsl:value-of select="$images_path"/>pic_form_help.gif</xsl:param>
	<xsl:param name="endImage"><xsl:value-of select="$images_path"/>pic_end.gif</xsl:param>
	
	<xsl:template match="/">
		<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"></script>
		<script type="text/javascript">
			<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script type="text/javascript" src="/content/OLD/javascript/com_currency.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/trade_purge_dm.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_amount.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_date.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/trade_common_dm.js"></script>
		
		<xsl:apply-templates select="dm_tnx_record"/>
	</xsl:template>



	<xsl:template match="dm_tnx_record">

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
				
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="3">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/></b>
						</td>
					</tr>
				</table>
				<table border="0" width="570" cellpadding="0" cellspacing="0">
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
				</table>
				
				<p><br/></p>
				
				<!--Versionned Documents -->
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="3">
							
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DOCUMENTS_VERSIONNED')"/></b>
						</td>
					</tr>
				</table>
				<br/>
				
				<xsl:if test="count(versionned_documents/document) = 0">
					<!-- Disclaimer -->
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_NONE_VERSIONNED')"/></b>
				</xsl:if>

				<xsl:if test="count(versionned_documents/document) != 0">
					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
							<td width="5">&nbsp;</td>
							<td>
	
								<table border="0" width="570" cellpadding="0" cellspacing="1">
									<tr>
										<th class="FORMH2" nowrap="nowrap" width="5%" align="center"></th>
										<th class="FORMH2" align="center" width="25%" nowrap="nowrap"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_REFERENCE_FULL')"/></th>
										<th class="FORMH2" align="center" width="5%" nowrap="nowrap"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_VERSION_FULL')"/></th>
										<th class="FORMH2" align="center" width="30%" nowrap="nowrap"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_TYPE')"/></th>
										<th class="FORMH2" align="center" width="30%" colspan="2"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_VIEW')"/></th>
										<th class="FORMH2" align="center" width="5%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_SELECT')"/></th>
									</tr>
									<!-- Call the template for documents already prepared-->
									<xsl:apply-templates select="versionned_documents/document" mode="list_versionned"/>
								</table>
							</td>
						</tr>
					</table>
				</xsl:if>
							
				<p><br/></p>
				
			</form>
			
			<!-- The following form is used for the final POST -->
			<form 
				name="realform" 
				accept-charset="UNKNOWN" 
				method="POST" 
				action="/gtp/screen/DocumentManagementScreen">

				<input type="hidden" name="referenceid"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
				<input type="hidden" name="productcode"><xsl:attribute name="value"><xsl:value-of select="product_code"/></xsl:attribute></input>
				<input type="hidden" name="operation" value="PURGE"/>
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
					<td align="middle" valign="center">
						<a href="javascript:void(0)" onclick="fncPerform('purge');return false;">
							<img border="0" >
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formTrashImage)"/></xsl:attribute>
							</img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/>
						</a>
					</td>
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
							<img border="0">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formHelpImage)"/></xsl:attribute>
							</img><br/>
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
					<xsl:attribute name="name">versionned_document_<xsl:value-of select="$document_key"/>_version</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_version"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">versionned_document_<xsl:value-of select="$document_key"/>_type</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_type"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">versionned_document_<xsl:value-of select="$document_key"/>_format</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_format"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">versionned_document_<xsl:value-of select="$document_key"/>_title</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_title"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">versionned_document_<xsl:value-of select="$document_key"/>_id</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_id"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">versionned_document_<xsl:value-of select="$document_key"/>_code</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_code"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">versionned_document_<xsl:value-of select="$document_key"/>_cust_ref_id</xsl:attribute>
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
				<xsl:value-of select="localization:getDecode($language, 'C064', $document_code)"/>
			</td>
			<!-- Transformations -->
			<xsl:choose>
				<xsl:when test="$transformation_node and (type[.='01'] or attachment_id[.!=''])">
					<td align="left">
						<xsl:if test="type[.='01'] or attachment_id[.!='']">
							<select>
								<xsl:attribute name="name">option_<xsl:value-of select="document_id"/>_transformation</xsl:attribute>
								<!-- We hardcode the HTML control popup in the list of available output -->
				                  		<option>
				                  			<xsl:attribute name="name">N036_HTML</xsl:attribute>
				                  			<xsl:attribute name="value">N036_HTML</xsl:attribute>
				                  			<xsl:attribute name="selected"/>
				                  			<xsl:value-of select="localization:getDecode($language, 'N036', 'HTML')"/>
				                  		</option>
								<xsl:apply-templates select="$transformation_node"/>
							</select>
						</xsl:if>
					</td>
					<td align="center">
						<xsl:if test="type[.='01'] or attachment_id[.!='']">
							<a name="anchor_preview" href="javascript:void(0)" target="_blank">
								<!-- Specific behaviour for the HTML option, where we invoke the reporting
								 popup -->
								<xsl:attribute name="onclick">var transformation = option_<xsl:value-of select="document_id"/>_transformation.options[option_<xsl:value-of select="document_id"/>_transformation.selectedIndex].value; if (transformation=='N036_HTML') fncViewDocument('<xsl:value-of select="$ref_id"/>','<xsl:value-of select="$document_id"/>'); else fncExportDocument(transformation ,'<xsl:value-of select="$document_id"/>','<xsl:value-of select="$document_code"/>','<xsl:value-of select="$document_format"/>','<xsl:value-of select="$ref_id"/>');return false;</xsl:attribute>
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
			<!-- Select -->
			<td align="center">
				<input type="checkbox">
					<xsl:attribute name="name">versionned_document_<xsl:value-of select="$document_key"/>_deleted</xsl:attribute>
				</input>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="transformation">
		<option>
			<xsl:attribute name="name"><xsl:value-of select="transformation_code"/></xsl:attribute>
			<xsl:attribute name="value"><xsl:value-of select="transformation_code"/></xsl:attribute>
			<xsl:variable name="localization_key"><xsl:value-of select="transformation_code"/></xsl:variable>
			<xsl:value-of select="localization:getDecode($language, 'N036', $localization_key)"/>
		</option>
	</xsl:template>

</xsl:stylesheet>
