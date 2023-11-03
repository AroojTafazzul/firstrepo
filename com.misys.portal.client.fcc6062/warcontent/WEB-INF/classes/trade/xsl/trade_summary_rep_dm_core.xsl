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
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
<xsl:import href="../../core/xsl/common/trade_common.xsl"/>
<xsl:import href="../../core/xsl/common/com_attachment.xsl"/>
<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="upImage"><xsl:value-of select="$images_path"/>pic_up.gif</xsl:param>
	
	<xsl:template match="/">
		<script type="text/javascript" src="/content/OLD/javascript/trade_common_dm.js"></script>
		<xsl:apply-templates select="dm_tnx_record"/>
	</xsl:template>

	<!--TEMPLATE Main-->

	<xsl:template match="dm_tnx_record">

		<p><br/></p>
		
		<!-- Event Details -->

		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tr>
				<td class="FORMH1">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_EVENT_DETAILS')"/>&nbsp;&nbsp;</b>
				</td>
				<xsl:if test="release_dttm[.!='']">
					<td class="FORMH1" align="right">
						<font style="font-size: 8pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_RELEASE_DTTM')"/>&nbsp;<xsl:value-of select="release_dttm"/></font>
					</td>
				</xsl:if>
			</tr>
		</table>
		<br/>


		<!-- Event Summary Header -->

		<table border="0" width="570" cellpadding="0" cellspacing="0">
		
			<tr>
				<td width="40">&nbsp;</td>
				<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_CODE')"/></td>
				<td>
					<font class="REPORTDATA">
						<xsl:choose>
							<xsl:when test="product_code[. = 'DM']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODUCTCODE_DM')"/>
							</xsl:when>
							<xsl:otherwise/>
						</xsl:choose>
					</font>
				</td>
			</tr>
			<tr>
				<td width="40">&nbsp;</td>
				<td width="170">Type:</td>
				<td>
					<font class="REPORTBLUE">
						<xsl:choose>
							<xsl:when test="tnx_type_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_01_NEW')"/></xsl:when>
							<xsl:when test="tnx_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_02_UPDATE')"/></xsl:when>
							<xsl:when test="tnx_type_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_03_AMEND')"/></xsl:when>
							<xsl:when test="tnx_type_code[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_04_EXTEND')"/></xsl:when>
							<xsl:when test="tnx_type_code[. = '05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_05_ACCEPT')"/></xsl:when>
							<xsl:when test="tnx_type_code[. = '06']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_06_CONFIRM')"/></xsl:when>
							<xsl:when test="tnx_type_code[. = '07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_07_CONSENT')"/></xsl:when>
							<xsl:when test="tnx_type_code[. = '08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_08_SETTLE')"/></xsl:when>
							<xsl:when test="tnx_type_code[. = '09']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_09_TRANSFER')"/></xsl:when>
							<xsl:when test="tnx_type_code[. = '10']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_10_DRAWDOWN')"/></xsl:when>
							<xsl:when test="tnx_type_code[. = '11']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_11_REVERSE')"/></xsl:when>
							<xsl:when test="tnx_type_code[. = '12']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_12_DELETE')"/></xsl:when>
							<xsl:when test="tnx_type_code[. = '13']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_13_INQUIRE')"/></xsl:when>
							<xsl:when test="tnx_type_code[. = '14']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_14_CANCEL')"/></xsl:when>
							<xsl:when test="tnx_type_code[. = '15']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_15_REPORTING')"/></xsl:when>
							<xsl:when test="tnx_type_code[. = '16']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_16_REINSTATE')"/></xsl:when>
							<xsl:when test="tnx_type_code[. = '17']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_17_PURGE')"/></xsl:when>
							<xsl:when test="tnx_type_code[. = '18']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_18_PRESENT')"/></xsl:when>
							<xsl:otherwise/>
						</xsl:choose>
						<xsl:if test="sub_tnx_type_code[.='08']">
   						&nbsp;(<xsl:value-of select="localization:getDecode($language, 'N003', '10')"/>)
						</xsl:if>
					</font>
				</td>
			</tr>
			<tr>
				<td width="40">&nbsp;</td>
				<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/></td>
				<td>
					<font class="REPORTBLUE"><xsl:value-of select="ref_id"/></font>
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
			
		<xsl:choose>
			<!-- NEW -->
			<xsl:when test="tnx_type_code[. = '01']">
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<xsl:if test="tnx_amt[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TNX_AMT_LABEL')"/></td>
							<td>
								<font class="REPORTDATA">
									<xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/>
								</font>
							</td>
						</tr>
					</xsl:if>
				</table>
			</xsl:when>
			
			<!-- AMEND -->
			<xsl:when test="tnx_type_code[. = '03']">
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr><td colspan="3">&nbsp;</td></tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_AMD_NO')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="amd_no"/></font></td>
					</tr>
				</table>
			</xsl:when>
			
			<!-- UPDATE : VERSION -->
			<xsl:when test="tnx_type_code[. = '02']">
				<!--Document Selection-->
				<xsl:if test="documents/document">
					<p><br/></p>
					<table border="0" cellspacing="0" width="570">
						<tr>
							<td width="40">&nbsp;</td>
							<td><b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DOCUMENTS_VERSIONNED')"/>:</b></td>
						</tr>
					</table>
					<table border="0" cellpadding="0" cellspacing="0">
						<xsl:apply-templates select="documents/document" mode="version_summary"/>
					</table>
					<p><br/></p>
				</xsl:if>
			</xsl:when>
			
			<!-- PRESENTATION -->
			<xsl:when test="tnx_type_code[. = '18']">
				<br/>
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_PRESENTATION_REF_ID')"/></td>
						<td>
							<font class="REPORTDATA">
								<xsl:value-of select="pres_ref_id"/>&nbsp;
							</font>
						</td>
					</tr>
					<xsl:if test="parent_ref_id[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CREDIT_REFERENCE')"/></td>
							<td><font class="REPORTDATA"><xsl:value-of select="parent_ref_id"/></font></td>
						</tr>
					</xsl:if>
					<xsl:if test="tnx_amt[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRESENTATION_AMOUNT')"/></td>
							<td>
								<font class="REPORTDATA">
									<xsl:value-of select="tnx_cur_code"/>&nbsp;
									<xsl:value-of select="tnx_amt"/>
								</font>
							</td>
						</tr>
					</xsl:if>
					<!--Issuing Bank -->
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRESENTATION_TO_BANK')"/></td>
						<td>
							<font class="REPORTDATA">
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
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EUCP_PRESENTATION_PLACE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="eucp_presentation_place"/></font></td>
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
					<p><br/></p>
				</xsl:if>
				
				<!--Document Selection-->
				<xsl:if test="documents/document">
					<table border="0" cellspacing="0" width="570">
						<tr>
							<td width="15">&nbsp;</td>
							<td class="FORMH2" align="left">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DOCUMENTS_PRESENTED')"/></b>
							</td>
						</tr>
					</table>
					<table border="0" cellpadding="0" cellspacing="0">
						<xsl:apply-templates select="documents/document" mode="present_summary"/>
					</table>
					<p><br/></p>
				</xsl:if>
				
			</xsl:when>
			
			<!-- Only the transaction type for the other cases -->
			<xsl:otherwise/>
			
		</xsl:choose>
			
		
		<xsl:if test="type[.!=''] or free_format_text[.!='']">
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="15">&nbsp;</td>
					<td class="FORMH2" align="left">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREE_FORMAT_INSTRUCTIONS')"/></b>
					</td>
				</tr>
			</table>
			<xsl:if test="type[.!='']">
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
					<tr><td>&nbsp;</td></tr>
				</table>
			</xsl:if>
			<!-- Free format text -->
			<xsl:if test="free_format_text[.!='']">
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
				<p>&nbsp;</p>
			</xsl:if>
		</xsl:if>

		<!-- Bank Message, only for presentations since the NEW and AMEND are not submitted to the bank -->
		
		<xsl:if test="tnx_stat_code[.='04']">

			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BANK_MESSAGE')"/></b>
					</td>
					<xsl:if test="bo_release_dttm[.!='']">
						<td class="FORMH1" align="right">
							<font style="font-size: 8pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_DTTM')"/>&nbsp;<xsl:value-of select="bo_release_dttm"/></font>
						</td>
					</xsl:if>
				</tr>
			</table>
			<br/>
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="190"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_PROD_STAT_LABEL')"/></td>
					<td align="left">
						<font class="REPORTDATA">
							<xsl:choose>
								<xsl:when test="prod_stat_code[.='01']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/>
								</xsl:when>
								<xsl:when test="prod_stat_code[.='03']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_03_NEW')"/>
								</xsl:when>
								<xsl:when test="prod_stat_code[.='04']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_04_ACCEPTED')"/>
								</xsl:when>
								<xsl:when test="prod_stat_code[.='05']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_05_SETTLED')"/>
								</xsl:when>
								<xsl:when test="prod_stat_code[.='13']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_13_PART_SETTLED')"/>
								</xsl:when>
								<xsl:when test="prod_stat_code[.='06']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_06_CANCELLED')"/>
								</xsl:when>
								<xsl:when test="prod_stat_code[.='07']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_07_UPDATED')"/>
								</xsl:when>
								<xsl:when test="prod_stat_code[.='08']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_08_AMENDED')"/>
								</xsl:when>
								<xsl:when test="prod_stat_code[.='09']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_09_EXTENDED')"/>
								</xsl:when>
								<xsl:when test="prod_stat_code[.='10']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_10_PURGED')"/>
								</xsl:when>
								<xsl:when test="prod_stat_code[.='11']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_11_RELEASED')"/>
								</xsl:when>
								<xsl:when test="prod_stat_code[.='12']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_12_DISCREPANT')"/>
								</xsl:when>
								<xsl:when test="prod_stat_code[.='26']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_26_CLEAN')"/>
								</xsl:when>
							</xsl:choose>
						</font>
					</td>
				</tr>
			</table>
			<br/>
		
			<xsl:if test="bo_comment[.!='']">
				<table border="0" cellspacing="0" width="570">
					<tr>
						<td width="40">&nbsp;</td>
						<td align="left"><b><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_COMMENT_BANK')"/></b></td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td>
							<font class="REPORTNORMAL">
								<xsl:call-template name="string_replace">
									<xsl:with-param name="input_text" select="bo_comment" />
								</xsl:call-template>
								<br/>
							</font>
						</td>
					</tr>
				</table>
				<br/>
			</xsl:if>
			<xsl:if test="attachments/attachment[type = '02']">
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
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<th width="18">&nbsp;</th>
						<th class="FORMH2" align="center" width="275"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILES_COLUMN_TITLE')"/></th>
						<th width="2">&nbsp;</th>
						<th class="FORMH2" align="center" width="275"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILES_COLUMN_FILE')"/></th>
					</tr>
					<xsl:apply-templates select="attachments/attachment[type = '02']" mode="bank"/>
				</table>
				<p><br/></p>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="document" mode="present_summary">
		<tr>
			<td width="40" align="center">&nbsp;</td>
			<td>
				- <a href="javascript:void(0)">
					<xsl:attribute name="onclick">document.form_<xsl:value-of select="attachment_id"/>.submit();return false;</xsl:attribute>
					<xsl:variable name="localization_key"><xsl:value-of select="code"/></xsl:variable>
					<xsl:value-of select="cust_ref_id"/>&nbsp;(<xsl:value-of select="localization:getDecode($language, 'C064', $localization_key)"/>)
				</a>
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

	<xsl:template match="document" mode="version_summary">
		<tr>
			<td width="40" align="center">&nbsp;</td>
			<td>
				- <a href="javascript:void(0)">
					<!-- Link toward the tnx document -->
					<xsl:attribute name="onclick">fncViewDocument('<xsl:value-of select="ref_id"/>','<xsl:value-of select="document_id"/>','<xsl:value-of select="tnx_id"/>');return false;</xsl:attribute>
					<xsl:variable name="localization_key"><xsl:value-of select="code"/></xsl:variable>
					<xsl:value-of select="cust_ref_id"/>&nbsp;(<xsl:value-of select="localization:getDecode($language, 'C064', $localization_key)"/>)
				</a>
			</td>
 		</tr>
	</xsl:template>

	
</xsl:stylesheet>




