<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:security="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization security utils">
		
<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:import href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:import href="../../core/xsl/common/trade_common.xsl"/>
	
	<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="rundata"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="formSendImage"><xsl:value-of select="$images_path"/>pic_form_send.gif</xsl:param>
	<xsl:param name="formCancelImage"><xsl:value-of select="$images_path"/>pic_form_cancel.gif</xsl:param>
	<xsl:param name="formHelpImage"><xsl:value-of select="$images_path"/>pic_form_help.gif</xsl:param>
	<xsl:param name="printerImage"><xsl:value-of select="$images_path"/>pic_printer.gif</xsl:param>
	<xsl:param name="ribbonImage"><xsl:value-of select="$images_path"/>pic_ribbon.gif</xsl:param>
	
	<xsl:template match="/">
		
		<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"></script>
		<script type="text/javascript">
			<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script type="text/javascript" src="/content/OLD/javascript/trade_present_dm.js"></script>
		<!-- The following javascript is used for the advice generation handling -->
		<script type="text/javascript" src="/content/OLD/javascript/trade_common_dm.js"></script>
		
		<!-- Include some eventual additional elements -->
		<xsl:call-template name="client_addons"/>
		
		<table border="0" width="100%" cellspacing="2" cellpadding="4" class="FORMTABLEBORDER">
		<tr>
		<td class="FORMTABLE" align="center">
		
		<table border="0">
		<tr>
		<td align="center">
		
		
					<table border="0" cellspacing="2" cellpadding="8">
						<tr>
							<td align="middle" valign="center">
								<a href="javascript:void(0)" onclick="fncPerform('submit');return false;">
									<img border="0" >
										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formSendImage)"/></xsl:attribute>
									</img><br/>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/>
								</a>
							</td>
							<td align="middle" valign="center">
								<a href="javascript:void(0)">
									<xsl:attribute name="onclick">fncShowPreview('SUMMARY','<xsl:value-of select="dm_tnx_record/product_code"/>','<xsl:value-of select="dm_tnx_record/ref_id"/>','<xsl:value-of select="dm_tnx_record/tnx_id"/>','DMReportingPopup');return false;</xsl:attribute>
									<img border="0" >
										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($printerImage)"/></xsl:attribute>
									</img><br/>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_PREVIEW')"/>
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
									<img border="0" >
										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formHelpImage)"/></xsl:attribute>
									</img><br/>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_HELP')"/>
								</a>
							</td>
						</tr>
					</table>
	</td>
	</tr>
	<tr>
	<td align="left">
		
		<xsl:apply-templates select="dm_tnx_record" mode="present_rep"/>
		
	</td>
	</tr>
	<tr>
	<td align="center">
				
					<table border="0" cellspacing="2" cellpadding="8">
						<tr>
							<td align="middle" valign="center">
								<a href="javascript:void(0)" onclick="fncPerform('submit');return false;">
									<img border="0" >
										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formSendImage)"/></xsl:attribute>
									</img><br/>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/>
								</a>
							</td>
							<td align="middle" valign="center">
								<a href="javascript:void(0)">
									<xsl:attribute name="onclick">fncShowPreview('SUMMARY','<xsl:value-of select="dm_tnx_record/product_code"/>','<xsl:value-of select="dm_tnx_record/ref_id"/>','<xsl:value-of select="dm_tnx_record/tnx_id"/>');return false;</xsl:attribute>
									<img border="0" >
										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($printerImage)"/></xsl:attribute>
									</img><br/>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_PREVIEW')"/>
								</a>
							</td>
							<td align="middle" valign="center">
								<a href="javascript:void(0)" onclick="fncPerform('cancel');return false;">
									<img border="0" >
										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formCancelImage)"/></xsl:attribute></img><br/>
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
						</tr>
					</table>
					
	</td>
	</tr>
	</table>
	
	</td>
	</tr>
	</table>
	</xsl:template>

	<xsl:template match="dm_tnx_record" mode="present_rep">

		<!--Variable that holds the tnx type code-->
		<xsl:variable name="tnxTypeCode"><xsl:value-of select="tnx_type_code"/></xsl:variable>
		
		<table>
		<tr>
		<td align="left">
		
			<p><br/></p>
	
			<form name="fakeform1" onsubmit="return false;">
				<!--Insert the Branch Code and Company ID as hidden fields-->
				
				<input type="hidden" name="brch_code"><xsl:attribute name="value"><xsl:value-of select="brch_code"/></xsl:attribute></input>
				<input type="hidden" name="company_id"><xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute></input>
				<input type="hidden" name="company_name"><xsl:attribute name="value"><xsl:value-of select="company_name"/></xsl:attribute></input>
				<input type="hidden" name="ref_id"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
				<input type="hidden" name="tnx_id"><xsl:attribute name="value"><xsl:value-of select="tnx_id"/></xsl:attribute></input>
				<input type="hidden" name="amd_no"><xsl:attribute name="value"><xsl:value-of select="amd_no"/></xsl:attribute></input>
				<input type="hidden" name="parent_ref_id"><xsl:attribute name="value"><xsl:value-of select="parent_ref_id"/></xsl:attribute></input>
				<input type="hidden" name="parent_product_code"><xsl:attribute name="value"><xsl:value-of select="parent_product_code"/></xsl:attribute></input>
				<input type="hidden" name="parent_bo_ref_id"><xsl:attribute name="value"><xsl:value-of select="parent_bo_ref_id"/></xsl:attribute></input>
				<input type="hidden" name="sub_tnx_type_code"><xsl:attribute name="value"><xsl:value-of select="sub_tnx_type_code"/></xsl:attribute></input>
			</form>
			
			<form name="realform" method="POST" action="/gtp/screen/DocumentManagementScreen">
				<input type="hidden" name="operation" value=""/>
				<input type="hidden" name="mode" value="UNSIGNED"/>
				<input type="hidden" name="tnxtype"><xsl:attribute name="value"><xsl:value-of select="$tnxTypeCode"/></xsl:attribute></input>
				<input type="hidden" name="TransactionData"/>
			</form>

				<!--The following general details are fetched from database, and the data already localized-->
				<!--General Details-->
		
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
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="appl_date"/></font></td>
					</tr>
				</table>
				<p><br/></p>
				<table border="0" cellpadding="0" cellspacing="0">
					<xsl:if test="pres_ref_id[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_PRESENTATION_REF_ID')"/></td>
							<td><font class="REPORTDATA"><xsl:value-of select="pres_ref_id"/></font></td>
						</tr>
					</xsl:if>
					<xsl:if test="parent_ref_id[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CREDIT_REFERENCE')"/></td>
							<td><font class="REPORTDATA"><xsl:value-of select="parent_ref_id"/></font></td>
						</tr>
					</xsl:if>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRESENTATION_AMOUNT')"/></td>
						<td>
							<font class="REPORTBLUE">
								<xsl:value-of select="tnx_cur_code"/>&nbsp;
								<xsl:value-of select="tnx_amt"/>
							</font>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRESENTATION_TO_BANK')"/></td>
						<td>
							<font class="REPORTBLUE">
								<xsl:value-of select="issuing_bank/name"/>
							</font>
						</td>
					</tr>
				</table>
				<br/>
				<table border="0" cellpadding="0" cellspacing="0">
					<xsl:choose>
						<xsl:when test="eucp_flag[.='Y']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EUCP_FLAG')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/></font></td>
							</tr>	
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EUCP_CREDIT_REFERENCE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="eucp_reference"/></font></td>
							</tr>	
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170" valign="top"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EUCP_PRESENTATION_PLACE')"/></td>
								<td>
									<font class="REPORTDATA">
										<xsl:call-template name="string_replace">
											<xsl:with-param name="input_text" select="eucp_presentation_place" />
										</xsl:call-template>
									</font>
								</td>
							</tr>	
						</xsl:when>
						<xsl:otherwise>
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EUCP_FLAG')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/></font></td>
							</tr>	
						</xsl:otherwise>
					</xsl:choose>
				</table>
				
				<p><br/></p>
				
				
				<!--Parties Details-->
				
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="3">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PARTIES_DETAILS')"/></b>
						</td>
					</tr>
				</table>
						
				<br/>
				
				
				<!--Counterparty Details (Consignee details) -->
				
				<xsl:if test="counterparty_name[.!=''] or counterparty_address_line_1[.!=''] or counterparty_address_line_2[.!=''] or counterparty_dom[.!=''] or counterparty_reference[.!='']">
		
					<table border="0" cellspacing="0" width="570">
						<tr>
							<td width="15">&nbsp;</td>
							<td class="FORMH2" align="left">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONSIGNEE_DETAILS')"/></b>
							</td>
						</tr>
					</table>
					<table border="0" cellspacing="0" width="570">
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
										<xsl:when test="counterparty_address_line_1[.!='']">&nbsp;</xsl:when>
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
								<td><font class="REPORTDATA"><xsl:value-of 	select="counterparty_reference"/></font></td>
							</tr>
						</xsl:if>
					</table>
				</xsl:if>
				
				<p><br/></p>
				
				<xsl:if test="free_format_text[.!='']">
		
					<!--Narrative Details-->
		
					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tbody>
							<tr>
								<td class="FORMH1">
									<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREE_FORMAT_INSTRUCTIONS')"/></b>
								</td>
							</tr>
						</tbody>
					</table>
					
					<br/>
					
					<xsl:if test="type[. != '']">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRESENTATION_COMPLETENESS')"/></td>
								<td>
									<xsl:if test="type[. = '01']">
										<font class="REPORTDATA"><xsl:value-of select="localization:getDecode($language, 'N040', '01')"/></font>
									</xsl:if>
									<xsl:if test="type[. = '02']">
										<font class="REPORTDATA"><xsl:value-of select="localization:getDecode($language, 'N040', '02')"/></font>
									</xsl:if>
								</td>
							</tr>
						</table>
					</xsl:if>
					
					<table border="0" cellspacing="0" width="570">
						<tr>
							<td width="40">&nbsp;</td>
							<td>
								<font class="REPORTNORMAL">
									<xsl:call-template name="string_replace">
										<xsl:with-param name="input_text" select="free_format_text" />
									</xsl:call-template>
									<br/>
								</font>
							</td>
						</tr>
					</table>
					
					<p><br/></p>
				
				</xsl:if>

				<!--Document Selection-->
		
				<!--Document Selection-->
				<xsl:if test="documents/document">
					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
							<td class="FORMH1" colspan="3">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DOCUMENTS_PRESENTED')"/></b>
							</td>
						</tr>
					</table>
					<br/>
					<!--Generated documents-->
					<!-- All presented documents are flagged as attached in the structure -->
					<xsl:if test="documents/document[attached='Y']">
						<table border="0" cellpadding="0" cellspacing="0">
							<xsl:apply-templates select="documents/document[attached='Y']" mode="present_rep"/>
						</table>
					</xsl:if>
					
				<p><br/></p>
					<!--Temp section for signed documents-->
					<!--//todo: Remove when implkementation final-->
					<!--
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="500">Temp Section: below are the signed documents saved</td>
						</tr>
					</table>
					<table border="0" cellpadding="0" cellspacing="0">
						<xsl:apply-templates select="attachments/attachment" mode="present_rep"/>
					</table>
					-->
				</xsl:if>
				
				<p><br/></p>
			
			</td>
		</tr>
		</table>
	</xsl:template>
	
	<xsl:template match="document" mode="present_rep">
		<tr>
			<td width="40" align="center">&nbsp;</td>
			<td>
				- <a href="javascript:void(0)">
					<xsl:attribute name="onclick">document.form_<xsl:value-of select="attachment_id"/>.submit();return false;</xsl:attribute>
					<xsl:variable name="localization_key"><xsl:value-of select="code"/></xsl:variable>
					<xsl:value-of select="cust_ref_id"/>&nbsp;(<xsl:value-of select="localization:getDecode($language, 'C064', $localization_key)"/>)
				</a>
			</td>
			<td width="40" align="center">&nbsp;</td>
			<td>
				<xsl:if test="security:hasPermission(utils:getUserACL($rundata),'dm_sign',utils:getUserEntities($rundata))">

				<xsl:if test="type[.='01'] and transformation_code[starts-with(.,'PDF')]">
					<a name="anchor_sign_pdf" href="javascript:void(0)">
						<xsl:attribute name="onclick">fncOpenPDF('<xsl:value-of select="attachment_id"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="tnx_id"/>');return false;</xsl:attribute>
						<img border="0"  name="img_sign_pdf">
							<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($ribbonImage)"/></xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_SIGN_PDF')"/></xsl:attribute>
							<!-- //toto : localize -->
						</img>
					</a>
				</xsl:if>
				
				</xsl:if>
			</td>
			<form 
				accept-charset="UNKNOWN" 
				method="POST" 
				enctype="application/x-www-form-urlencoded">
				<xsl:attribute name="action">/gtp/screen/GTPDownloadScreen</xsl:attribute>
				<xsl:attribute name="name">form_<xsl:value-of select="attachment_id"/></xsl:attribute>
				<input type="hidden" name="attachmentid">
					<xsl:attribute name="value"><xsl:value-of select="attachment_id"/></xsl:attribute>
				</input>
			</form>
		</tr>
	</xsl:template>

	
</xsl:stylesheet>
