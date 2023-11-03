<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
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
	
	<xsl:template match="/">
		<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"></script>
		<script type="text/javascript">
			<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script type="text/javascript" src="/content/OLD/javascript/com_currency.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/trade_details.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_amount.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_date.js"></script>

		<xsl:apply-templates select="document"/>
	</xsl:template>



	<xsl:template match="document">
	
	<!-- Include some eventual additional elements -->
	<xsl:call-template name="client_addons"/>

		<table border="0" width="100%" cellspacing="2" cellpadding="4" class="FORMTABLEBORDER">
		<tr>
		<td align="center" class="FORMTABLE">
		
		<table border="0">
		<tr>
		<td align="center">
			<table  id="toolbar" border="0" cellspacing="2" cellpadding="8">
				<tr>
					<td align="middle" valign="center">
						<a href="javascript:fncPerform('print')">
							<img border="0" src="/content/images/pic_printer.gif"></img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_PRINT')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:fncPerform('close')">
							<img border="0" src="/content/images/pic_form_cancel.gif"></img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_CLOSE')"/>
						</a>
					</td>
				</tr>
			</table>
			
		</td>
		</tr>
		<tr>
		<td align="left">
		
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
				<input type="hidden" name="format"><xsl:attribute name="value"><xsl:value-of select="format"/></xsl:attribute></input>
				
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
							<font class="REPORTDATA"><xsl:value-of select="description"/></font>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PREPARATION_DATE')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="prep_date"/></font>
						</td>
					</tr>	
					<tr>
						<td>&nbsp;</td>
					</tr>	
				</table>
			
			</form>
			
			
			
			<!--Optional File Upload Details-->
			<xsl:if test="attachments/attachment/file_name[.!='']">
      		<table border="0" width="570" cellpadding="0" cellspacing="0">
      			<tr>
      				<td class="FORMH1" colspan="3">
      					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FILE_UPLOAD')"/></b>
      				</td>
      			</tr>
      		</table>
				<xsl:if test="format[.='BXD']">
   				<table border="0" cellpadding="0" cellspacing="0" width="100%">
   					<tr>
   						<td width="40">&nbsp;</td>
   						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_BOLERO_UPLOAD')"/></td>
   						<td><font class="REPORTDATA"><xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/></font></td>
   					</tr>
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_BOLERO_DTD')"/></td>
   						<td>
								<xsl:variable name="dtd_code">
									<xsl:value-of select="dtd_code"/>
								</xsl:variable>
   							<font class="REPORTDATA"><xsl:value-of select="localization:getCodeData($language,'*','*','C008',$dtd_code)"/></font>
   						</td>
						</tr>
   				</table>
				</xsl:if>
      		<br/>
				<xsl:apply-templates select="attachments/attachment" mode="control"/>
			</xsl:if>
		
			
			
		</td>
		</tr>
		
		<tr>
		<td align="center">
		
			<table border="0" cellspacing="2" cellpadding="8">
				<tr>
					<td align="middle" valign="center">
						<a href="javascript:fncPerform('print')">
							<img border="0" src="/content/images/pic_printer.gif"></img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_PRINT')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:fncPerform('close')">
							<img border="0" src="/content/images/pic_form_cancel.gif"></img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_CLOSE')"/>
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
	
	<!--TEMPLATE Attachment - Control Client 
	This template has been copied from trade_common.xsl since we need to handle the
	Bolero flag-->
	<xsl:template match="attachment" mode="control">

		<table border="0" cellspacing="0" width="570">
			<tr>
				<td width="15">&nbsp;</td>
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

	
	
</xsl:stylesheet>
