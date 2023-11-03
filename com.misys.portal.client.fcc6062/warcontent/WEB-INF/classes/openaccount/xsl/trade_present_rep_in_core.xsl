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

	<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	
	<xsl:template match="/">
		<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_attachment.js"/>
		<script type="text/javascript">
			<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script type="text/javascript" src="/content/OLD/javascript/com_currency.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/openaccount/trade_present_in.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_amount.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_date.js"></script>
			
		<xsl:apply-templates select="in_tnx_record"/>
	</xsl:template>

	<!-- -->
	<!--TEMPLATE Main for document preparation (upload)-->
	<!-- -->
	<xsl:template match="in_tnx_record">
		

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
						<a href="javascript:void(0)" onclick="fncPerform('submit');return false;">
							<img border="0" src="/content/images/pic_form_send.gif"></img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/>
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
		
			<p><br/></p>
	
			<form name="fakeform1" onsubmit="return false;">
	
				<!--Insert the Branch Code and Company ID as hidden fields-->
				
				<input type="hidden" name="brch_code"><xsl:attribute name="value"><xsl:value-of select="brch_code"/></xsl:attribute></input>
				<input type="hidden" name="company_id"><xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute></input>
				<input type="hidden" name="company_name"><xsl:attribute name="value"><xsl:value-of select="company_name"/></xsl:attribute></input>
				<input type="hidden" name="tnx_id"><xsl:attribute name="value"><xsl:value-of select="tnx_id"/></xsl:attribute></input>
				<input type="hidden" name="ref_id"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
      		<!-- Previous ctl date, used for synchronisation issues -->
      		<input type="hidden" name="old_ctl_dttm"><xsl:attribute name="value"><xsl:value-of select="ctl_dttm"/></xsl:attribute></input>
				
				<!--The following general details are fetched from database, and the data already localized-->
				<!--General Details-->
		
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="3">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/></b>
						</td>
						<td align="right" class="FORMH1">
						<a name="anchor_view_full_details" href="javascript:void(0)">
							<xsl:attribute name="onclick">fncShowReporting('DETAILS', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/preview.png" name="img_view_full_details">
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VIEW_INVOICE')"/></xsl:attribute>
							</img>
						</a>
					</td>
					</tr>
				</table>
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<!--tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_FOLDER_REF_ID')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="ref_id"/></font>
							<input type="hidden" name="ref_id"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
						</td>
					</tr-->
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="ref_id"/></font></td>
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
					<tr><td>&nbsp;</td></tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_PRESENTATION_REF_ID')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="data_set_id"/></font></td>
					</tr>
					<!--	
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CREDIT_REFERENCE')"/></td>
						<td>
							<input type="text" size="15" maxlength="34" name="parent_ref_id" onblur="fncRestoreInputStyle('fakeform1','parent_ref_id');">
								<xsl:attribute name="value"><xsl:value-of select="parent_ref_id"/></xsl:attribute>
							</input>
						</td>
					</tr>
					-->	
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRESENTATION_AMOUNT')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="tnx_cur_code"/></font>&nbsp;<font class="REPORTDATA"><xsl:value-of select="tnx_amt"/></font></td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRESENTATION_FINAL')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="localization:getDecode($language, 'N034', final_presentation)"/></font></td>
					</tr>
					<!--Issuing Bank -->
					<!--tr>
						<td width="40">&nbsp;</td>
						<td width="170">
							<font class="FORMMANDATORY">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PRESENTATION_TO_BANK')"/>
							</font>
						</td>
						<td>
							<select name="seller_bank_abbv_name" onchange="document.forms['fakeform1'].seller_bank_name.value = this.options[this.selectedIndex].text">
								<xsl:apply-templates select="seller_bank"/>
								<xsl:apply-templates select="potential_issuing_bank"/>
							</select>
							<input type="hidden" name="seller_bank_name">
								<xsl:attribute name="value">
									<xsl:choose>
										<xsl:when test="seller_bank/name[.!='']">
											<xsl:value-of select="seller_bank/name"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="potential_issuing_bank[position()='1']/name"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute>
							</input>
						</td>
					</tr-->
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
				
				<!--Buyer Details-->
				
				<table border="0" cellspacing="0" width="570">
					<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BUYER_DETAILS')"/></b>
						</td>
					</tr>
				</table>
				<table border="0" cellspacing="0" width="570">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="buyer_name"/></font></td>
					</tr>
      			<tr>
      				<td width="40">&nbsp;</td>
      				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/></td>
      				<td><font class="REPORTDATA"><xsl:value-of select="buyer_bei"/></font></td>
      			</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="buyer_street_name"/></font></td>
					</tr>
      			<tr>
      				<td>&nbsp;</td>
      				<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/></td>
      				<td><font class="REPORTDATA"><xsl:value-of select="buyer_post_code"/></font></td>
      			</tr>
					<tr>
						<td>&nbsp;</td>
      				<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="buyer_town_name"/></font></td>
					</tr>
      			<tr>
      				<td>&nbsp;</td>
      				<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/></td>
      				<td><font class="REPORTDATA"><xsl:value-of select="buyer_country_sub_div"/></font></td>
      			</tr>
      			<tr>
      				<td>&nbsp;</td>
      				<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/></td>
      				<td><font class="REPORTDATA"><xsl:value-of select="buyer_country"/></font></td>
      			</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="buyer_reference"/></font></td>
					</tr>
						
				</table>
				
				<p><br/></p>
				
				<!--Free Format Message-->
				
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tbody>
						<tr>
							<td class="FORMH1" colspan="3">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREE_FORMAT_INSTRUCTIONS')"/></b>
							</td>
							<td align="right" class="FORMH1">
								<a href="#">
									<img border="0" src="/content/images/pic_up.gif">
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
								</img>
								</a>
							</td>
						</tr>
					</tbody>
				</table>
				
				<br/>
				
				<xsl:if test="free_format_text[.!='']">
					<xsl:apply-templates select="free_format_text">
						<xsl:with-param name="theNodeName" select="'free_format_text'"/>
						<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_HEADER_FREE_FORMAT_INSTRUCTIONS')"/>
					</xsl:apply-templates>
				</xsl:if>
				
				
				<br/>
				
				<br/>

			<table border="0" cellspacing="0" width="570">
				<tr>
					<td>
      				<xsl:value-of select="localization:getGTPString($language, 'XSL_PRESENT_IN_PREVIEW')"/>&nbsp;
      				<a name="anchor_preview" href="javascript:void(0)" target="_blank">
      					<!--xsl:attribute name="onclick">document.form_in_preview.submit();return false;</xsl:attribute-->
      					<xsl:attribute name="onclick">fncExportDocument('IN', 'PDF_IN', '<xsl:value-of select="ref_id"/>', '', 'DRAFT');return false;</xsl:attribute>
      					<img border="0" src="/content/images/pic_end.gif" name="img_preview">
      						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VIEW_ADVICE')"/></xsl:attribute>
      					</img>
      				</a>
					</td>
				</tr>
			</table>

			<br/>
				
			</form>
					
			<form name="realform" method="POST" action="/gtp/screen/InvoiceScreen">
				<input type="hidden" name="operation" value="SAVE"/>
				<input type="hidden" name="mode" value="DRAFT"/>
				<input type="hidden" name="tnxtype"><xsl:attribute name="value"><xsl:value-of select="tnx_type_code"/></xsl:attribute></input>
				<input type="hidden" name="TransactionData"/>
				<xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">referenceid</xsl:with-param>
				   <xsl:with-param name="value" select="ref_id"/>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">tnxid</xsl:with-param>
				   <xsl:with-param name="value" select="tnx_id"/>
				</xsl:call-template>
			</form>

			<p><br/></p>
			
		</td>
		</tr>
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
						<a href="javascript:void(0)" onclick="fncPerform('submit');return false;">
							<img border="0" src="/content/images/pic_form_send.gif"></img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/>
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
