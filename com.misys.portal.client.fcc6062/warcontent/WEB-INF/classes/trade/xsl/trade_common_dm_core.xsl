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
   Copyright (c) 2000-2005 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:import href="product_addons.xsl"/>
	<xsl:import href="trade_common_dm_details.xsl"/>
	<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="executeImage"><xsl:value-of select="$images_path"/>execute.png</xsl:param>
	<xsl:param name="searchGifImage"><xsl:value-of select="$images_path"/>pic_search.gif</xsl:param>
	<xsl:param name="trashImage"><xsl:value-of select="$images_path"/>pic_trash.gif</xsl:param>
	<xsl:param name="editGifImage"><xsl:value-of select="$images_path"/>pic_edit.gif</xsl:param>
	<xsl:param name="formSendImage"><xsl:value-of select="$images_path"/>pic_form_send.gif</xsl:param>
	<xsl:param name="formSaveImage"><xsl:value-of select="$images_path"/>pic_form_save.gif</xsl:param>
	<xsl:param name="formCancelImage"><xsl:value-of select="$images_path"/>pic_form_cancel.gif</xsl:param>
	<xsl:param name="formHelpImage"><xsl:value-of select="$images_path"/>pic_form_help.gif</xsl:param>
	<xsl:param name="upImage"><xsl:value-of select="$images_path"/>pic_up.gif</xsl:param>
	<xsl:param name="listImage"><xsl:value-of select="$images_path"/>pic_list.gif</xsl:param>
	

	<!-- -->
	<!--TEMPLATE Main for document generation-->
	<!-- -->
	<xsl:template match="dm_tnx_record" mode="folder">
		<!-- -->
		<script type="text/javascript">
			fncPreloadImages('<xsl:value-of select="utils:getImagePath($searchGifImage)"/>', '<xsl:value-of select="utils:getImagePath($executeImage)"/>', '<xsl:value-of select="utils:getImagePath($editGifImage)"/>', '<xsl:value-of select="utils:getImagePath($trashImage)"/>'); 
		</script>

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
							<img border="0">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formSaveImage)"/></xsl:attribute>
							</img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)" onclick="fncPerform('submit');return false;">
							<img border="0">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formSendImage)"/></xsl:attribute>
							</img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/>
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

			<!--*********************************************-->
			<!-- Templates must be put before the input form -->
			<!--*********************************************-->
			
			<!-- Terms and Conditions template -->
			<div style="position:absolute;visibility:hidden;">
				<table>
					<tbody>
						<xsl:attribute name="id">term_template</xsl:attribute>
						<xsl:call-template name="TERM_DETAILS">
							<xsl:with-param name="structure_name">term</xsl:with-param>
							<xsl:with-param name="mode">template</xsl:with-param>
						</xsl:call-template>
					</tbody>
				</table>
			</div>

			<!-- Product details template -->
			<div style="position:absolute;visibility:hidden;">
				<table>
					<tbody>
						<xsl:attribute name="id">product_template</xsl:attribute>
						<xsl:call-template name="PRODUCT_DETAILS">
							<xsl:with-param name="structure_name">product</xsl:with-param>
							<xsl:with-param name="mode">template</xsl:with-param>
						</xsl:call-template>
					</tbody>
				</table>
			</div>

			<!-- Packing details template -->
			<div style="position:absolute;visibility:hidden;">
				<table>
					<tbody>
						<xsl:attribute name="id">packing_template</xsl:attribute>
						<xsl:call-template name="PACKAGE_DETAILS">
							<xsl:with-param name="structure_name">packing</xsl:with-param>
							<xsl:with-param name="mode">template</xsl:with-param>
						</xsl:call-template>
					</tbody>
				</table>
			</div>

			<!-- Charge details template -->
			<div style="position:absolute;visibility:hidden;">
				<table>
					<tbody>
						<xsl:attribute name="id">charge_template</xsl:attribute>
						<xsl:call-template name="CHARGE_DETAILS">
							<xsl:with-param name="structure_name">charge</xsl:with-param>
							<xsl:with-param name="mode">template</xsl:with-param>
						</xsl:call-template>
					</tbody>
				</table>
			</div>

			<!--******************-->
			<!-- End of Templates -->
			<!--******************-->

		
			<p><br/></p>
	
			<form name="fakeform1" onsubmit="return false;">
	
			<!--Insert the Branch Code and Company ID as hidden fields-->
			
			<input type="hidden" name="brch_code"><xsl:attribute name="value"><xsl:value-of select="brch_code"/></xsl:attribute></input>
			<input type="hidden" name="company_id"><xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute></input>
			<input type="hidden" name="company_name"><xsl:attribute name="value"><xsl:value-of select="company_name"/></xsl:attribute></input>
			<input type="hidden" name="tnx_id"><xsl:attribute name="value"><xsl:value-of select="tnx_id"/></xsl:attribute></input>
			<input type="hidden" name="tnx_type_code"><xsl:attribute name="value"><xsl:value-of select="tnx_type_code"/></xsl:attribute></input>
			<input type="hidden" name="sub_tnx_type_code"><xsl:attribute name="value"><xsl:value-of select="sub_tnx_type_code"/></xsl:attribute></input>
			<input type="hidden" name="amd_no"><xsl:attribute name="value"><xsl:value-of select="amd_no"/></xsl:attribute></input>
			<input type="hidden" name="parent_ref_id"><xsl:attribute name="value"><xsl:value-of select="parent_ref_id"/></xsl:attribute></input>
			<input type="hidden" name="parent_product_code"><xsl:attribute name="value"><xsl:value-of select="parent_product_code"/></xsl:attribute></input>
			<input type="hidden" name="parent_bo_ref_id"><xsl:attribute name="value"><xsl:value-of select="parent_bo_ref_id"/></xsl:attribute></input>
		<!-- Previous ctl date, used for synchronisation issues -->
		<input type="hidden" name="old_ctl_dttm"><xsl:attribute name="value"><xsl:value-of select="ctl_dttm"/></xsl:attribute></input>
			
			<!--The following general details are fetched from database, and the data already localized-->
			<!--General Details-->
	
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1" colspan="3">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/></b>
					</td>
					<xsl:if test="parent_ref_id[.!='']">
						<td align="right" class="FORMH1">
							<a name="anchor_view_parent_details" href="javascript:void(0)">
								<xsl:attribute name="onclick">fncShowReporting('DETAILS', 'EL', '<xsl:value-of select="parent_ref_id"/>');return false;</xsl:attribute>
								<img border="0" src="/content/images/preview.png" name="img_view_full_details">
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VIEW_PARENT_TRANSACTION_DETAILS')"/></xsl:attribute>
								</img>
							</a>
						</td>
					</xsl:if>
				</tr>
			</table>
			
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_FOLDER_REF_ID')"/></td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="ref_id"/></font>
						<input type="hidden" name="ref_id"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/></td>
					<td>
						<input type="text" size="15" maxlength="34" name="cust_ref_id" onblur="fncRestoreInputStyle('fakeform1','cust_ref_id');">
							<xsl:attribute name="value"><xsl:value-of select="cust_ref_id"/></xsl:attribute>
						</input>
					</td>
				</tr>	
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')"/></td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="appl_date"/></font>
						<input type="hidden" name="appl_date"><xsl:attribute name="value"><xsl:value-of select="appl_date"/></xsl:attribute></input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<font class="FORMMANDATORY">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_PREPARATION_DATE')"/>
						</font>
					</td>
					<td>
						<input type="text" size="10" maxlength="10" name="prep_date" onblur="fncRestoreInputStyle('fakeform1','prep_date');fncCheckPreparationDate(this);">
							<xsl:attribute name="value"><xsl:value-of select="prep_date"/></xsl:attribute>
						</input><script>DateInput('prep_date','<xsl:value-of select="prep_date"/>')</script>
					</td>
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<font class="FORMMANDATORY">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_AMOUNT')"/>
						</font>
					</td>
					<td>
						<input type="text" size="3" maxlength="3" name="total_currency">
							<xsl:attribute name="value"><xsl:value-of select="cur_code"/></xsl:attribute>
							<xsl:attribute name="onblur">fncCheckTotalCurrency('total_currency', 'old_total_currency'); fncRestoreInputStyle('fakeform1','total_currency'); fncFormatAmount(document.forms['fakeform1'].total_amount,fncGetCurrencyDecNo(this.value));</xsl:attribute>
						</input>
						<!-- Hidden field used to store the previous old total currency -->
						<input type="hidden" name="old_total_currency">
							<xsl:attribute name="value"><xsl:value-of select="cur_code"/></xsl:attribute>
						</input>
					</td>
					<td>
						<input type="text" size="20" maxlength="15" name="total_amount" onblur="fncRestoreInputStyle('fakeform1','total_amount');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].total_currency.value));document.forms['fakeform1'].reporting_currency.value=this.value">
							<xsl:attribute name="value">
								<xsl:if test="dm_amt[.!='']">
									<xsl:value-of select="dm_amt"/>
								</xsl:if>
							</xsl:attribute>
						</input>
						<input type="hidden" name="reporting_currency" >
							<xsl:attribute name="value"><xsl:value-of select="Totals/Total/totalCurrencyCode"/></xsl:attribute>
						</input>
					</td>
					<td width="30" align="right">
						<a name="anchor_search_currency" href="javascript:void(0)">
							<xsl:attribute name="onclick">fncSearchPopup("currency", "fakeform1","['total_currency']");return false;</xsl:attribute>
							<img border="0" name="img_search_currency">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
			</table>
			<br/>
			<table width="570" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EUCP_FLAG')"/>
					</td>
					<td>
						<input type="checkbox" name="eucp_flag" onclick="fncShowHideEucpDetails(this);">
							<xsl:if test="eucp_flag[. = 'Y']">
								<xsl:attribute name="checked"/>
							</xsl:if>
						</input>
					</td>
				</tr>
			</table>
			<div id="eucp_details">
				<xsl:if test="eucp_flag[.!='Y']">
					<xsl:attribute name="style">display:none</xsl:attribute>
				</xsl:if>
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EUCP_VERSION')"/>
						</td>
						<td>
							<select name="eucp_version" onchange="fncRestoreInputStyle('fakeform1','eucp_version');">
								<option value="1.0">
									<xsl:if test="eucp_version[. = '1.0']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									1.0
								</option>
							</select>
						</td>
					</tr>
				</table>
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EUCP_PRESENTATION_PLACE')"/>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td>
							<textarea wrap="hard" name="eucp_presentation_place" rows="3" cols="40" onblur="fncFormatTextarea(this,3,40);fncRestoreInputStyle('fakeform1','eucp_presentation_place');">
								<xsl:value-of select="eucp_presentation_place"/>
							</textarea>
						</td>
					</tr>
				</table>
			</div>
			
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
			
			
			<!--Consignee Details-->
			
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="15">&nbsp;</td>
					<td class="FORMH2" align="left">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONSIGNEE_DETAILS')"/></b>
					</td>
					<td class="FORMH2" align="right">
						<a name="anchor_search_beneficiary" href="javascript:void(0)">
							<xsl:attribute name="onclick">fncSearchPopup('beneficiary', 'fakeform1',"['consignee_name', 'consignee_address_line_1', 'consignee_address_line_2', 'consignee_dom']",'', '', '<xsl:value-of select="product_code"/>');return false;</xsl:attribute>
							<img border="0" name="img_search_beneficiary">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CONSIGNEE')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
			</table>
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="consignee_name" onblur="fncRestoreInputStyle('fakeform1','consignee_name');">
							<xsl:attribute name="value"><xsl:value-of select="counterparty_name"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="consignee_address_line_1" onblur="fncRestoreInputStyle('fakeform1','consignee_address_line_1');">
							<xsl:attribute name="value"><xsl:value-of select="counterparty_address_line_1"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>
						<input type="text" size="35" maxlength="35" name="consignee_address_line_2" onblur="fncRestoreInputStyle('fakeform1','consignee_address_line_2');">
							<xsl:attribute name="value"><xsl:value-of select="counterparty_address_line_2"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>
						<input type="text" size="35" maxlength="35" name="consignee_dom" onblur="fncRestoreInputStyle('fakeform1','consignee_dom');">
							<xsl:attribute name="value"><xsl:value-of select="counterparty_dom"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
					<td>
						<input type="text" size="35" maxlength="34" name="consignee_reference" onblur="fncRestoreInputStyle('fakeform1','consignee_reference');">
							<xsl:attribute name="value"><xsl:value-of select="counterparty_reference"/></xsl:attribute>
						</input>
					</td>
				</tr>
					
			</table>
			
			<p>
				<br/>
			</p>
			
			
	<xsl:choose>
		<xsl:when test="tnx_type_code[.='01' or .='02' or .='03']">
			<!--Edit or Hide the template details -->
			<script type="text/javascript">
			<![CDATA[
				if (NS4) 
				{
					document.write("<ilayer name='divTransactionDetailsEnabling' visibility='visible' position='static'>");
				}
				else
				{
					document.write("<div id='divTransactionDetailsEnabling' style='display:block'>");
				}
			]]>
			</script>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="20">&nbsp;</td>
					<td>
						<a name="EditTransactionDetails" href="javascript:void(0)" onclick="fncEditTemplateDetails();return false;">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_EDIT_TEMPLATE')"/>
						</a>
					</td>
			   </tr>
			</table>
			<script type="text/javascript">
				<![CDATA[
				  if (NS4) 
				  {
				    document.write("</ilayer>");
				  }
				  else
				  {
				    document.write("</div>");
				  }
				]]>
			</script>
			
			<br/>
			
			<script type="text/javascript">
			<![CDATA[
				if (NS4) 
				{
					document.write("<ilayer name='divTransactionDetails' visibility='hidden' position='absolute'>");
				}
				else
				{
					document.write("<div id='divTransactionDetails' style='display:none'>");
				}
			]]>
			</script>
			
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="20">&nbsp;</td>
					<td>
						<a name="HideTransactionDetails" href="javascript:void(0)" onclick="fncHideTemplateDetails();return false;">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_HIDE_TEMPLATE')"/>
						</a>
					</td>
				</tr>
			</table>
		</xsl:when>
		<xsl:otherwise/>
	</xsl:choose>
	
	
	
			<p>
				<br/>
				<br/>
			</p>
			
			<!--The following data are fetched the xml document preparation representation, and both dates and amounts are expressed in standard bolero format.-->
			<!--A conversion is therefore required to have it in user locale -->
			<!--References-->
	
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1" colspan="3">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REFERENCES')"/></b>
					</td>
					<td align="right" class="FORMH1">
						<a href="#">
							<img border="0" >
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($upImage)"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
			</table>
			
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COUNTRY_OF_ORIGIN')"/></td>
					<td>
						<input type="text" size="15" maxlength="20" name="country_of_origin" onblur="fncRestoreInputStyle('fakeform1','country_of_origin');">
							<xsl:attribute name="value"><xsl:value-of select="CountryOfOrigin/countryName"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COUNTRY_OF_DESTINATION')"/></td>
					<td>
						<input type="text" size="15" maxlength="20" name="country_of_destination" onblur="fncRestoreInputStyle('fakeform1','country_of_destination');">
							<xsl:attribute name="value"><xsl:value-of select="CountryOfDestination/countryName"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PURCHASE_ORDER')"/></td>
					<td>
						<input type="text" size="15" maxlength="20" name="purchase_order_identifier" onblur="fncRestoreInputStyle('fakeform1','purchase_order_identifier');">
							<xsl:attribute name="value"><xsl:value-of select="purchaseOrderReference"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COMMERCIAL_INVOICE')"/></td>
					<td>
						<input type="text" size="15" maxlength="20" name="comercial_invoice_identifier" onblur="fncRestoreInputStyle('fakeform1','comercial_invoice_identifier');">
							<xsl:attribute name="value"><xsl:value-of select="commercialInvoiceReference"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_ISSUING_BANK_REFERENCE')"/></td>
					<td>
						<input type="text" size="15" maxlength="20" name="issuing_bank_reference" onblur="fncRestoreInputStyle('fakeform1','issuing_bank_reference');">
							<xsl:attribute name="value"><xsl:value-of select="documentaryCreditReference"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_ADVISING_BANK_REFERENCE')"/></td>
					<td>
						<input type="text" size="15" maxlength="20" name="advising_bank_reference" onblur="fncRestoreInputStyle('fakeform1','advising_bank_reference');">
							<xsl:attribute name="value"><xsl:value-of select="exportDocumentaryCreditReference"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_EXPORTER_REFERENCE')"/></td>
					<td>
						<input type="text" size="15" maxlength="20" name="exporter_reference" onblur="fncRestoreInputStyle('fakeform1','exporter_reference');">
							<xsl:attribute name="value"><xsl:value-of select="exporterReference"/></xsl:attribute>
						</input>
					</td>
				</tr>
			</table>
			
			<p><br/></p>
			
			<!--Parties Details-->
			
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1" colspan="3">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PARTIES_DETAILS')"/></b>
					</td>
					<td align="right" class="FORMH1">
						<a href="#">
							<img border="0" >
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($upImage)"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
			</table>
					
			<br/>
			
			<!--Shipper Details-->
			
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="15">&nbsp;</td>
					<td class="FORMH2" align="left">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SHIPPER_DETAILS')"/></b>
					</td>
					<td class="FORMH2" align="right">
						<a name="anchor_search_shipper" href="javascript:void(0)">
							<xsl:attribute name="onclick">fncSearchPopup('beneficiary', 'fakeform1',"['shipper_name', 'shipper_address_line_1', 'shipper_address_line_2', 'shipper_dom']",'', '', '<xsl:value-of select="product_code"/>');return false;</xsl:attribute>
						</a>
					</td>
				</tr>
			</table>
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="shipper_name" onblur="fncRestoreInputStyle('fakeform1','shipper_name');">
							<xsl:attribute name="value">
								<xsl:choose>
									<xsl:when test="user_company"><xsl:value-of select="user_company/name"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="Shipper/organizationName"/></xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="shipper_address_line_1" onblur="fncRestoreInputStyle('fakeform1','shipper_address_line_1');">
							<xsl:attribute name="value">
								<xsl:choose>
									<xsl:when test="user_company"><xsl:value-of select="user_company/address_line_1"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="Shipper/addressLine1"/></xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>
						<input type="text" size="35" maxlength="35" name="shipper_address_line_2" onblur="fncRestoreInputStyle('fakeform1','shipper_address_line_2');">
							<xsl:attribute name="value">
								<xsl:choose>
									<xsl:when test="user_company"><xsl:value-of select="user_company/address_line_2"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="Shipper/addressLine2"/></xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>
						<input type="text" size="35" maxlength="35" name="shipper_dom" onblur="fncRestoreInputStyle('fakeform1','shipper_dom');">
							<xsl:attribute name="value">
								<xsl:choose>
									<xsl:when test="user_company"><xsl:value-of select="user_company/dom"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="Shipper/addressLine3"/></xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
					<td>
						<input type="text" size="35" maxlength="34" name="shipper_reference" onblur="fncRestoreInputStyle('fakeform1','shipper_reference');">
							<xsl:attribute name="value"><xsl:value-of select="Shipper/organizationReference"/></xsl:attribute>
						</input>
					</td>
				</tr>
					
			</table>
			
			<p><br/></p>
			
			
			
			<!--Buyer Details-->
			
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="15">&nbsp;</td>
					<td class="FORMH2" align="left">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BUYER_DETAILS')"/></b>
					</td>
					<td class="FORMH2" align="right">
						<a name="anchor_search_beneficiary" href="javascript:void(0)">
							<xsl:attribute name="onclick">fncSearchPopup('beneficiary', 'fakeform1',"['buyer_name', 'buyer_address_line_1', 'buyer_address_line_2', 'buyer_dom']",'', '', '<xsl:value-of select="product_code"/>');return false;</xsl:attribute>
							<img border="0"  name="img_search_beneficiary">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_BUYER')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
			</table>
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="buyer_name" onblur="fncRestoreInputStyle('fakeform1','buyer_name');">
							<xsl:attribute name="value"><xsl:value-of select="Buyer/organizationName"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="buyer_address_line_1" onblur="fncRestoreInputStyle('fakeform1','buyer_address_line_1');">
							<xsl:attribute name="value"><xsl:value-of select="Buyer/addressLine1"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>
						<input type="text" size="35" maxlength="35" name="buyer_address_line_2" onblur="fncRestoreInputStyle('fakeform1','buyer_address_line_2');">
							<xsl:attribute name="value"><xsl:value-of select="Buyer/addressLine2"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>
						<input type="text" size="35" maxlength="35" name="buyer_dom" onblur="fncRestoreInputStyle('fakeform1','buyer_dom');">
							<xsl:attribute name="value"><xsl:value-of select="Buyer/addressLine3"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
					<td>
						<input type="text" size="35" maxlength="34" name="buyer_reference" onblur="fncRestoreInputStyle('fakeform1','buyer_reference');">
							<xsl:attribute name="value"><xsl:value-of select="Buyer/organizationReference"/></xsl:attribute>
						</input>
					</td>
				</tr>
					
			</table>
			
			<p><br/></p>
			
			<!--Billto Details-->
			
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="15">&nbsp;</td>
					<td class="FORMH2" align="left">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BILL_TO_DETAILS')"/></b>
					</td>
					<td class="FORMH2" align="right">
						<a name="anchor_search_beneficiary" href="javascript:void(0)">
							<xsl:attribute name="onclick">fncSearchPopup('beneficiary', 'fakeform1',"['bill_to_name', 'bill_to_address_line_1', 'bill_to_address_line_2', 'bill_to_dom']",'', '', '<xsl:value-of select="product_code"/>');return false;</xsl:attribute>
							<img border="0" name="img_search_beneficiary">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_BILLTO')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
			</table>
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="bill_to_name" onblur="fncRestoreInputStyle('fakeform1','bill_to_name');">
							<xsl:attribute name="value"><xsl:value-of select="BillTo/organizationName"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="bill_to_address_line_1" onblur="fncRestoreInputStyle('fakeform1','bill_to_address_line_1');">
							<xsl:attribute name="value"><xsl:value-of select="BillTo/addressLine1"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>
						<input type="text" size="35" maxlength="35" name="bill_to_address_line_2" onblur="fncRestoreInputStyle('fakeform1','bill_to_address_line_2');">
							<xsl:attribute name="value"><xsl:value-of select="BillTo/addressLine2"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>
						<input type="text" size="35" maxlength="35" name="bill_to_dom" onblur="fncRestoreInputStyle('fakeform1','bill_to_dom');">
							<xsl:attribute name="value"><xsl:value-of select="BillTo/addressLine3"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
					<td>
						<input type="text" size="35" maxlength="34" name="bill_to_reference" onblur="fncRestoreInputStyle('fakeform1','bill_to_reference');">
							<xsl:attribute name="value"><xsl:value-of select="BillTo/organizationReference"/></xsl:attribute>
						</input>
					</td>
				</tr>
					
			</table>
			
			<p><br/></p>
			
			
			<!--***************-->
			<!-- Terms Details -->
			<!--***************-->
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1" colspan="3">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TERMS_DETAILS')"/></b>
					</td>
					<td align="right" class="FORMH1">
						<a href="#">
							<img border="0" >
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
					<!--<td width="40">&nbsp;</td>-->
					<td>
						
						<!-- Disclaimer -->
						<div>
							<xsl:attribute name="id">term_disclaimer</xsl:attribute>
							<xsl:if test="count(TermsAndConditions/clause) != 0">
								<xsl:attribute name="style">display:none</xsl:attribute>
							</xsl:if>
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TERMDETAILS_NO_TERM')"/></b>
						</div>
						
						<table border="0" width="570" cellpadding="0" cellspacing="1" id="term_master_table">
							<xsl:if test="count(TermsAndConditions/clause) = 0">
								<xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
							</xsl:if>
							<tbody id="term_table">

								<!-- Columns Header -->
								<tr>
									<xsl:attribute name="id">term_table_header_1</xsl:attribute>
									<xsl:if test="count(TermsAndConditions/clause) = 0">
										<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
									</xsl:if>
									<th class="FORMH2" align="center" width="90%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TABLE_CLAUSE')"/></th>
									<th class="FORMH2" width="10%">&nbsp;</th>
								</tr>
								
								<!-- Details -->
								<xsl:for-each select="TermsAndConditions/clause">
									
									<xsl:call-template name="TERM_DETAILS">
										<xsl:with-param name="structure_name">term</xsl:with-param>
										<xsl:with-param name="mode">existing</xsl:with-param>
										<xsl:with-param name="data"><xsl:value-of select="."/></xsl:with-param>
									</xsl:call-template>
									
								</xsl:for-each>
							</tbody>
						</table>
						<br/>
						<a href="javascript:void(0)">
							<xsl:attribute name="onClick">fncPreloadImages('<xsl:value-of select="utils:getImagePath($searchGifImage)"/>', '<xsl:value-of select="utils:getImagePath($editGifImage)"/>', '<xsl:value-of select="utils:getImagePath($trashImage)"/>'); fncLaunchProcess("fncAddElement('fakeform1', 'term', 'fncDefaultTermDetails')");</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TERMDETAILS_ADD_TERM')"/>
						</a>
					</td>
				</tr>
			</table>
			<p><br/></p>
			<!--*********************-->
			<!-- End of Term Details -->
			<!--*********************-->
			
			<!--Routing Summary / Shipment Details-->
	
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1" colspan="3">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ROUTING_SUMMARY_DETAILS')"/></b>
					</td>
					<td align="right" class="FORMH1">
						<a href="#">
							<img border="0" >
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($upImage)"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
			</table>
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TRANSPORT_SERVICE')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="transport_service" onblur="fncRestoreInputStyle('fakeform1','transport_service');">
							<xsl:attribute name="value"><xsl:value-of select="RoutingSummary/transportService"/></xsl:attribute>
						</input>
					</td>
				</tr>	
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TRANSPORT_BY')"/></td>
					<td>
							<select name="transport_type" onchange="fncRestoreInputStyle('fakeform1','transport_type');">
								<option value="">
									<xsl:if test="RoutingSummary/transportType[. = '']">
										<xsl:attribute name="selected"/>
									</xsl:if>
								</option>
								<option value="MARITIME">
									<xsl:if test="RoutingSummary/transportType[. = 'MARITIME']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_01_SEA')"/>
								</option>
								<option value="RAIL">
									<xsl:if test="RoutingSummary/transportType[. = 'RAIL']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_03_RAIL')"/>
								</option>
								<option value="ROAD">
									<xsl:if test="RoutingSummary/transportType[. = 'ROAD']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_04_TRUCK')"/>
								</option>
								<option value="AIR">
									<xsl:if test="RoutingSummary/transportType[. = 'AIR']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_02_AIR')"/>
								</option>
								<option value="MAIL">
									<xsl:if test="RoutingSummary/transportType[. = 'MAIL']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_05_POSTAGE')"/>
								</option>
								<option value="MULTIMODAL">
									<xsl:if test="RoutingSummary/transportType[. = 'MULTIMODAL']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_06_MIXED')"/>
								</option>
								<option value="INLANDWATER">
									<xsl:if test="RoutingSummary/transportType[. = 'INLANDWATER']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_09_INLAND_WATER')"/>
								</option>
							</select>
						</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DEPARTURE_DATE')"/></td>
					<td>
						<input type="text" size="10" maxlength="10" name="departure_date" onblur="fncRestoreInputStyle('fakeform1','departure_date');fncCheckDepartureDate(this);">
							<xsl:attribute name="value">
								<xsl:if test="RoutingSummary/departureDate[.!='']">
									<xsl:variable name="date"><xsl:value-of select="RoutingSummary/departureDate"/></xsl:variable>
									<xsl:value-of select="converttools:getLocaleTimestampRepresentation($date,$language)"/>
								</xsl:if>
							</xsl:attribute>
						</input><script>DateInput('departure_date','<xsl:value-of select="departure_date"/>')</script>
					</td>
				</tr>	
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_LOADING_PLACE')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="place_of_loading" onblur="fncRestoreInputStyle('fakeform1','place_of_loading');">
							<xsl:attribute name="value"><xsl:value-of select="RoutingSummary/PlaceOfLoading/locationName"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DISCHARGE_PLACE')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="place_of_discharge" onblur="fncRestoreInputStyle('fakeform1','place_of_discharge');">
							<xsl:attribute name="value"><xsl:value-of select="RoutingSummary/PlaceOfDischarge/locationName"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DELIVERY_PLACE')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="place_of_delivery" onblur="fncRestoreInputStyle('fakeform1','place_of_delivery');">
							<xsl:attribute name="value"><xsl:value-of select="RoutingSummary/PlaceOfDelivery/locationName"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_VESSEL')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="vessel_name" onblur="fncRestoreInputStyle('fakeform1','vessel_name');">
							<xsl:attribute name="value"><xsl:value-of select="RoutingSummary/vesselName"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TRANSPORT_REFERENCE')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="transport_reference" onblur="fncRestoreInputStyle('fakeform1','transport_reference');">
							<xsl:attribute name="value"><xsl:value-of select="RoutingSummary/transportReference"/></xsl:attribute>
						</input>
					</td>
				</tr>	
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_RECEIPT_PLACE')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="place_of_receipt" onblur="fncRestoreInputStyle('fakeform1','place_of_receipt');">
							<xsl:attribute name="value"><xsl:value-of select="RoutingSummary/PlaceOfReceipt/locationName"/></xsl:attribute>
						</input>
					</td>
				</tr>
			</table>
				
			<!--Incoterms-->
			
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
		    		<td width="40">&nbsp;</td>
		    		<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_INCOTERMS')"/></td>
					<td>
						<select name="inco_term" onchange="fncRestoreInputStyle('fakeform1','inco_term');">
							<option value="">
								<xsl:if test="Incoterms/incotermsCode[. = '']">
									<xsl:attribute name="selected"/>
								</xsl:if>
							</option>
							<option value="EXW">
								<xsl:if test="Incoterms/incotermsCode[. = 'EXW']">
									<xsl:attribute name="selected"/>
								</xsl:if>
								EXW
							</option>
							<option value="FCA">
								<xsl:if test="Incoterms/incotermsCode[. = 'FCA']">
									<xsl:attribute name="selected"/>
								</xsl:if>
								FCA
							</option>
							<option value="FAS">
								<xsl:if test="Incoterms/incotermsCode[. = 'FAS']">
									<xsl:attribute name="selected"/>
								</xsl:if>
								FAS
							</option>
							<option value="FOB">
								<xsl:if test="Incoterms/incotermsCode[. = 'FOB']">
									<xsl:attribute name="selected"/>
								</xsl:if>
								FOB
							</option>
							<option value="CFR">
								<xsl:if test="Incoterms/incotermsCode[. = 'CFR']">
									<xsl:attribute name="selected"/>
								</xsl:if>
								CFR
							</option>
							<option value="CIF">
								<xsl:if test="Incoterms/incotermsCode[. = 'CIF']">
									<xsl:attribute name="selected"/>
								</xsl:if>
								CIF
							</option>
							<option value="CPT">
								<xsl:if test="Incoterms/incotermsCode[. = 'CPT']">
									<xsl:attribute name="selected"/>
								</xsl:if>
								CPT
							</option>
							<option value="CIP">
								<xsl:if test="Incoterms/incotermsCode[. = 'CIP']">
									<xsl:attribute name="selected"/>
								</xsl:if>
								CIP
							</option>
							<option value="DAF">
								<xsl:if test="Incoterms/incotermsCode[. = 'DAF']">
									<xsl:attribute name="selected"/>
								</xsl:if>
								DAF
							</option>
							<option value="DES">
								<xsl:if test="Incoterms/incotermsCode[. = 'DES']">
									<xsl:attribute name="selected"/>
								</xsl:if>
								DES
							</option>
							<option value="DEQ">
								<xsl:if test="Incoterms/incotermsCode[. = 'DEQ']">
									<xsl:attribute name="selected"/>
								</xsl:if>
								DEQ
							</option>
							<option value="DDU">
								<xsl:if test="Incoterms/incotermsCode[. = 'DDU']">
									<xsl:attribute name="selected"/>
								</xsl:if>
								DDU
							</option>
							<option value="DDP">
								<xsl:if test="Incoterms/incotermsCode[. = 'DDP']">
									<xsl:attribute name="selected"/>
								</xsl:if>
								DDP
							</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_INCOTERMS_PLACE')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="incoterm_place" onblur="fncRestoreInputStyle('fakeform1','incoterm_place');">
							<xsl:attribute name="value"><xsl:value-of select="Incoterms/incotermsPlace"/></xsl:attribute>
						</input>
					</td>
				</tr>
			</table>
	
			<p><br/></p>
	



			<!--*****************-->
			<!-- Product Details -->
			<!--*****************-->
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1" colspan="3">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PRODUCT_DETAILS')"/></b>
					</td>
					<td align="right" class="FORMH1">
						<a href="#">
							<img border="0" >
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
					<!--<td width="40">&nbsp;</td>-->
					<td>

						<!-- Disclaimer -->
						<div>
							<xsl:attribute name="id">product_disclaimer</xsl:attribute>
							<xsl:if test="count(LineItemDetails/Item) != 0">
								<xsl:attribute name="style">display:none</xsl:attribute>
							</xsl:if>
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_NO_PRODUCT')"/></b>
						</div>
								
						<table border="0" width="570" cellpadding="0" cellspacing="1" id="product_master_table">
							<xsl:if test="count(LineItemDetails/Item) = 0">
								<xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
							</xsl:if>
							<tbody id="product_table">

								<!-- Columns Header -->
								<tr>
									<xsl:attribute name="id">product_table_header_1</xsl:attribute>
									<xsl:if test="count(LineItemDetails/Item) = 0">
										<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
									</xsl:if>
									<th class="FORMH2" rowspan="2" align="center" width="20%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_REFERENCE')"/></th>
									<th class="FORMH2" rowspan="2" align="center" width="30%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_PRODUCT')"/></th>
									<th class="FORMH2" colspan="3" align="center" width="40%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_TOTALVALUE')"/></th>
									<th class="FORMH2" rowspan="2" width="10%">&nbsp;</th>
								</tr>
								<tr>
									<xsl:attribute name="id">product_table_header_2</xsl:attribute>
									<xsl:if test="count(LineItemDetails/Item) = 0">
										<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
									</xsl:if>
									<th class="FORMH2" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_RATE')"/></th>
									<th class="FORMH2" colspan="2" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_VALUE')"/></th>
								</tr>

								<!-- Details -->
								<xsl:for-each select="LineItemDetails/Item">
									
									<!--
									<xsl:call-template name="PRODUCT_DETAILS">
										<xsl:with-param name="structure_name">product</xsl:with-param>
										<xsl:with-param name="mode">existing</xsl:with-param>
									</xsl:call-template>
									-->
									
									<xsl:call-template name="PRODUCT_DETAILS">

										<xsl:with-param name="structure_name">product</xsl:with-param>
										<xsl:with-param name="mode">existing</xsl:with-param>
										<xsl:with-param name="product_identifier"><xsl:value-of select="productIdentification"/></xsl:with-param>
										<xsl:with-param name="product_description"><xsl:value-of select="productName"/></xsl:with-param>
										<xsl:with-param name="purchase_order_id"><xsl:value-of select="purchaseOrderReference"/></xsl:with-param>
										<xsl:with-param name="export_license_id"><xsl:value-of select="exportLicenseReference"/></xsl:with-param>
										<xsl:with-param name="base_currency"><xsl:value-of select="baseCurrencyCode"/></xsl:with-param>
										<xsl:with-param name="base_unit"><xsl:value-of select="baseUnitOfMeasureCode"/></xsl:with-param>
										<xsl:with-param name="base_price"><xsl:value-of select="converttools:getLocaleAmountRepresentation(basePrice,baseCurrencyCode,$language)"/></xsl:with-param>
										<xsl:with-param name="product_quantity"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(itemQuantity,$language)"/></xsl:with-param>
										<xsl:with-param name="product_unit"><xsl:value-of select="itemQuantityUnitOfMeasureCode"/></xsl:with-param>
										<xsl:with-param name="product_currency"><xsl:value-of select="totalCurrencyCode"/></xsl:with-param>
										<xsl:with-param name="product_rate"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(rate,$language)"/></xsl:with-param>
										<xsl:with-param name="product_price"><xsl:value-of select="converttools:getLocaleAmountRepresentation(totalPrice,totalCurrencyCode,$language)"/></xsl:with-param>

									</xsl:call-template>
									
								</xsl:for-each>
							</tbody>
						</table>
						<br/>
						<a href="javascript:void(0)">
							<xsl:attribute name="onClick">fncPreloadImages('<xsl:value-of select="utils:getImagePath($searchGifImage)"/>', '<xsl:value-of select="utils:getImagePath($executeImage)"/>', '<xsl:value-of select="utils:getImagePath($editGifImage)"/>', '<xsl:value-of select="utils:getImagePath($trashImage)"/>'); fncLaunchProcess("fncAddElement('fakeform1', 'product', 'fncDefaultProductDetails')");</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_ADD_PRODUCT')"/>
						</a>
					</td>
				</tr>
			</table>
			<p><br/></p>
			<!--************************-->
			<!-- End of Product Details -->
			<!--************************-->



			<!--*****************-->
			<!-- Packing Details -->
			<!--*****************-->
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1" colspan="3">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PACKING_DETAILS')"/></b>
					</td>
					<td align="right" class="FORMH1">
						<a href="#">
							<img border="0" >
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
					<!--<td width="40">&nbsp;</td>-->
					<td>

						<!-- Disclaimer -->
						<div>
							<xsl:attribute name="id">packing_disclaimer</xsl:attribute>
							<xsl:if test="count(PackingDetail/Package) != 0">
								<xsl:attribute name="style">display:none</xsl:attribute>
							</xsl:if>
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_NO_PACKAGE')"/></b>
						</div>
						
						<table border="0" width="570" cellpadding="0" cellspacing="1" id="packing_master_table">
							<xsl:if test="count(PackingDetail/Package) = 0">
								<xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
							</xsl:if>
							<tbody id="packing_table">
								
								<!-- Columns Header -->
								<tr>
									<xsl:attribute name="id">packing_table_header_1</xsl:attribute>
									<xsl:if test="count(PackingDetail/Package) = 0">
										<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
									</xsl:if>
									<th class="FORMH2" align="center" width="10%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_QUANTITY')"/></th>
									<th class="FORMH2" align="center" width="10%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_TYPE')"/></th>
									<th class="FORMH2" align="center" width="40%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_DESCRIPTION')"/></th>
									<th class="FORMH2" align="center" width="30%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_MARKS')"/></th>
									<th class="FORMH2" width="10%"></th>
								</tr>
								
								<!-- Details -->
								<xsl:for-each select="PackingDetail/Package">
									
									<!--
									<xsl:call-template name="PACKAGE_DETAILS">
										<xsl:with-param name="structure_name">packing</xsl:with-param>
										<xsl:with-param name="mode">existing</xsl:with-param>
									</xsl:call-template>
									-->
									
									<xsl:call-template name="PACKAGE_DETAILS">

										<xsl:with-param name="structure_name">packing</xsl:with-param>
										<xsl:with-param name="mode">existing</xsl:with-param>
										<xsl:with-param name="package_number"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(numberOfPackages,$language)"/></xsl:with-param>
										<xsl:with-param name="package_type"><xsl:value-of select="typeOfPackage"/></xsl:with-param>
										<xsl:with-param name="package_description"><xsl:value-of select="productName"/></xsl:with-param>
										<xsl:with-param name="package_height"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(heightValue,$language)"/></xsl:with-param>
										<xsl:with-param name="package_width"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(widthValue,$language)"/></xsl:with-param>
										<xsl:with-param name="package_length"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(lengthValue,$language)"/></xsl:with-param>
										<xsl:with-param name="package_dimension_unit"><xsl:value-of select="dimensionUnitCode"/></xsl:with-param>
										<xsl:with-param name="package_netweight"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(netWeightValue,$language)"/></xsl:with-param>
										<xsl:with-param name="package_grossweight"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(grossWeightValue,$language)"/></xsl:with-param>
										<xsl:with-param name="package_weight_unit"><xsl:value-of select="weightUnitCode"/></xsl:with-param>
										<xsl:with-param name="package_grossvolume"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(grossVolumeValue,$language)"/></xsl:with-param>
										<xsl:with-param name="package_volume_unit"><xsl:value-of select="volumeUnitCode"/></xsl:with-param>
										<xsl:with-param name="package_marks"><xsl:value-of select="marksAndNumbers"/></xsl:with-param>
	

									</xsl:call-template>
									
								</xsl:for-each>
							</tbody>
						</table>
						<br/>
						<a href="javascript:void(0)">
							<xsl:attribute name="onClick">fncPreloadImages('<xsl:value-of select="utils:getImagePath($searchGifImage)"/>', '<xsl:value-of select="utils:getImagePath($editGifImage)"/>', '<xsl:value-of select="utils:getImagePath($trashImage)"/>'); fncLaunchProcess("fncAddElement('fakeform1', 'packing', 'fncDefaultPackingDetails')");</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_ADD_PACKAGE')"/>
						</a>
					</td>
				</tr>
			</table>
			<p><br/></p>
			<!--************************-->
			<!-- End of Packing Details -->
			<!--************************-->
	
			
			
			<!-- Summary of total weight and volumes-->
			
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_NETWEIGHT')"/></td>
					<td>
						
						<input type="text" size="10" maxlength="10" name="total_net_weight" onblur="fncRestoreInputStyle('fakeform1','total_net_weight');fncFormatDecimal(this);">
							<xsl:attribute name="value">
								<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(PackingDetail/totalNetWeightValue,$language)"/>
							</xsl:attribute>
						</input>
					</td>
					<td>
						<input type="text" size="3" maxlength="3" name="total_net_weight_unit" onblur="fncRestoreInputStyle('fakeform1','total_net_weight_unit');">
							<xsl:attribute name="value"><xsl:value-of select="PackingDetail/totalNetWeightUnitCode"/></xsl:attribute>
						</input>
						&nbsp;
						<a name="anchor_search_weight_unit" href="javascript:void(0)">
							<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', 'total_net_weight_unit', 'C002');return false;</xsl:attribute>
							<img border="0" name="img_search_weight_unit">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_WEIGHT_UNIT')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_GROSSWEIGHT')"/></td>
					<td>
						<input type="text" size="10" maxlength="10" name="total_gross_weight" onblur="fncRestoreInputStyle('fakeform1','total_gross_weight');fncFormatDecimal(this);">
							<xsl:attribute name="value">
								<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(PackingDetail/totalGrossWeightValue,$language)"/>
							</xsl:attribute>
						</input>
					</td>
					<td>
						<input type="text" size="3" maxlength="3" name="total_gross_weight_unit" onblur="fncRestoreInputStyle('fakeform1','total_gross_weight_unit');">
							<xsl:attribute name="value"><xsl:value-of select="PackingDetail/totalGrossWeightUnitCode"/></xsl:attribute>
						</input>
						&nbsp;
						<a name="anchor_search_weight_unit" href="javascript:void(0)">
							<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', 'total_gross_weight_unit', 'C002');return false;</xsl:attribute>
							<img border="0"  name="img_search_weight_unit">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_WEIGHT_UNIT')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_NETVOLUMNE')"/></td>
					<td>
						<input type="text" size="10" maxlength="10" name="total_net_volume" onblur="fncRestoreInputStyle('fakeform1','total_net_volume');fncFormatDecimal(this);">
							<xsl:attribute name="value">
								<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(PackingDetail/totalNetVolumeValue,$language)"/>
							</xsl:attribute>
						</input>
					</td>
					<td>
						<input type="text" size="3" maxlength="3" name="total_net_volume_unit" onblur="fncRestoreInputStyle('fakeform1','total_net_volume_unit');">
							<xsl:attribute name="value"><xsl:value-of select="PackingDetail/totalNetVolumeUnitCode"/></xsl:attribute>
						</input>
						&nbsp;
						<a name="anchor_search_volume_unit" href="javascript:void(0)">
							<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', 'total_net_volume_unit', 'C003');return false;</xsl:attribute>
							<img border="0" name="img_search_volume_unit">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VOLUME_UNIT')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_GROSSVOLUME')"/></td>
					<td>
						<input type="text" size="10" maxlength="10" name="total_gross_volume" onblur="fncRestoreInputStyle('fakeform1','total_gross_volume');fncFormatDecimal(this);">
							<xsl:attribute name="value">
								<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(PackingDetail/totalGrossVolumeValue,$language)"/>
							</xsl:attribute>
						</input>
					</td>
					<td>
						<input type="text" size="3" maxlength="3" name="total_gross_volume_unit" onblur="fncRestoreInputStyle('fakeform1','total_gross_volume_unit');">
							<xsl:attribute name="value"><xsl:value-of select="PackingDetail/totalGrossVolumeUnitCode"/></xsl:attribute>
						</input>
						&nbsp;
						<a name="anchor_search_volume_unit" href="javascript:void(0)">
							<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', 'total_gross_volume_unit', 'C003');return false;</xsl:attribute>
							<img border="0"  name="img_search_volume_unit">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VOLUME_UNIT')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
			</table>
	
			<p><br/></p>
	
			<!--*********************-->
			<!-- Charges or Discount -->
			<!--*********************-->
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1" colspan="3">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CHARGE_DETAILS')"/></b>
					</td>
					<td align="right" class="FORMH1">
						<a href="#">
							<img border="0" >
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
					<!--<td width="40">&nbsp;</td>-->
					<td>

						<!-- Disclaimer -->
						<div>
							<xsl:attribute name="id">charge_disclaimer</xsl:attribute>
							<xsl:if test="count(GeneralChargesOrDiscounts) != 0">
								<xsl:attribute name="style">display:none</xsl:attribute>
							</xsl:if>
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_NO_CHARGE')"/></b>
						</div>
						
						<table border="0" width="570" cellpadding="0" cellspacing="1" id="charge_master_table">
							<xsl:if test="count(GeneralChargesOrDiscounts) = 0">
								<xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
							</xsl:if>
							<tbody id="charge_table">
								
								<!-- Columns Header -->
								<tr>
									<xsl:attribute name="id">charge_table_header_1</xsl:attribute>
									<xsl:if test="count(GeneralChargesOrDiscounts) = 0">
										<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
									</xsl:if>
									<th class="FORMH2" rowspan="2" align="center" width="40%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_TYPE')"/></th>
									<th class="FORMH2" rowspan="2" colspan="2" align="center" width="20%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_AMOUNT')"/></th>
									<th class="FORMH2" colspan="3" align="center" width="30%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_EQUIVALENTAMOUNT')"/></th>
									<th class="FORMH2" rowspan="2" width="10%"></th>
								</tr>
								<tr>
									<xsl:attribute name="id">charge_table_header_2</xsl:attribute>
									<xsl:if test="count(GeneralChargesOrDiscounts) = 0">
										<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
									</xsl:if>
									<th class="FORMH2" align="center" width="80"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_RATE')"/></th>
									<th class="FORMH2" colspan="2" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_VALUE')"/></th>
								</tr>
								
								<!-- Details -->
								<xsl:for-each select="GeneralChargesOrDiscounts">

									<xsl:call-template name="CHARGE_DETAILS">

										<xsl:with-param name="structure_name">charge</xsl:with-param>
										<xsl:with-param name="mode">existing</xsl:with-param>
										<xsl:with-param name="charge_type"><xsl:value-of select="chargeType"/></xsl:with-param>
										<xsl:with-param name="charge_description"><xsl:value-of select="chargeDescription"/></xsl:with-param>
										<xsl:with-param name="charge_currency"><xsl:value-of select="chargeCurrencyCode"/></xsl:with-param>
										<xsl:with-param name="charge_amount"><xsl:value-of select="converttools:getLocaleAmountRepresentation(chargeAmount,chargeCurrencyCode,$language)"/></xsl:with-param>
										<xsl:with-param name="charge_rate"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(rate,$language)"/></xsl:with-param>
										<xsl:with-param name="charge_reporting_currency"><xsl:value-of select="chargeReportingCurrencyCode"/></xsl:with-param>
										<xsl:with-param name="charge_reporting_amount"><xsl:value-of select="converttools:getLocaleAmountRepresentation(chargeReportingAmount,chargeReportingCurrencyCode,$language)"/></xsl:with-param>
										
									</xsl:call-template>
									
								</xsl:for-each>
							</tbody>
						</table>
						<br/>
						<a href="javascript:void(0)">
							<xsl:attribute name="onClick">fncPreloadImages('<xsl:value-of select="utils:getImagePath($searchGifImage)"/>', '<xsl:value-of select="utils:getImagePath($executeImage)"/>', '<xsl:value-of select="utils:getImagePath($editGifImage)"/>', '<xsl:value-of select="utils:getImagePath($trashImage)"/>'); fncLaunchProcess("fncAddElement('fakeform1', 'charge', 'fncDefaultChargeDetails')");</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_ADD_CHARGE')"/>
						</a>
					</td>
				</tr>
			</table>
			<p><br/></p>
			
			<!--****************************-->
			<!-- End of Charges or Discount -->
			<!--****************************-->
			
			<!--Payment Terms-->
	
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1" colspan="3">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PAYMENT_TERMS_DETAILS')"/></b>
					</td>
					<td align="right" class="FORMH1">
						<a href="#">
							<img border="0" >
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($upImage)"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
			</table>
			<br/>
			<table border="0" cellpadding="0" cellspacing="0" width="570">
			<tr>
				<td width="40">&nbsp;</td>
				<td>
					<textarea wrap="hard" name="payment_terms" cols="65" rows="8">
						<xsl:attribute name="onblur">fncFormatTextarea(this,100,65);fncRestoreInputStyle('fakeform1','payment_terms');</xsl:attribute>
						<xsl:apply-templates select="PaymentTerms/line"/>
					</textarea>
				</td>
				<td valign="top">
					<a href="javascript:void(0)">
						<xsl:attribute name="onclick">fncSearchPopup('phrase','fakeform1',"['payment_terms']",'', '', '<xsl:value-of select="product_code"/>');return false;</xsl:attribute>
						<xsl:attribute name="name">anchor_search_free_format_text</xsl:attribute>
						<img border="0" >
							<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($listImage)"/></xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_PHRASES')"/></xsl:attribute>
							<xsl:attribute name="name">img_search_free_format_text</xsl:attribute>
						</img>
					</a>
				</td>
			</tr>
			</table>
	
			<p><br/></p>

			<!--Additional Information-->
	
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1" colspan="3">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ADDITIONAL_DETAILS')"/></b>
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
			<table border="0" cellpadding="0" cellspacing="0" width="570">
			<tr>
				<td  width="40">&nbsp;</td>
				<td>
					<textarea wrap="hard" name="additionnal_information" cols="65" rows="8">
						<xsl:attribute name="onblur">fncFormatTextarea(this,100,65);fncRestoreInputStyle('fakeform1','additionnal_information');</xsl:attribute>
						<xsl:apply-templates select="AdditionalInformation/line"/>
					</textarea>
				</td>
				<td valign="top">
					<a href="javascript:void(0)">
						<xsl:attribute name="onclick">fncSearchPopup('phrase','fakeform1',"['additionnal_information']",'', '', '<xsl:value-of select="product_code"/>');return false;</xsl:attribute>
						<xsl:attribute name="name">anchor_search_free_format_text</xsl:attribute>
						<img border="0" >
							<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($listImage)"/></xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_PHRASES')"/></xsl:attribute>
							<xsl:attribute name="name">img_search_free_format_text</xsl:attribute>
						</img>
					</a>
				</td>
			</tr>
			</table>
	
			<p><br/></p>
	
	
	<!--Edit or Hide the template details -->
	<xsl:choose>
		<xsl:when test="tnx_type_code[.='01' or .='02' or .='03']">
			<script type="text/javascript">
				<![CDATA[
				  if (NS4) 
				  {
				    document.write("</ilayer>");
				  }
				  else
				  {
				    document.write("</div>");
				  }
				]]>
		</script>
		</xsl:when>
		<xsl:otherwise/>
	</xsl:choose>
			
			</form>
			
			<p><br/></p>
			<p><br/></p>
			
			<!--POST parameters-->
			<form name="realform" method="POST" action="/gtp/screen/DocumentManagementScreen">
			
				<!--POST parameters-->
				<input type="hidden" name="operation" value="SAVE"/>
				<input type="hidden" name="mode" value="DRAFT"/>
				<input type="hidden" name="tnxtype"><xsl:attribute name="value"><xsl:value-of select="$tnxTypeCode"/></xsl:attribute></input>
				<input type="hidden" name="TransactionData"/>
			</form>
	
		</td>
		</tr>
		<tr>
		<td align="center">
		
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
						<a href="javascript:void(0)" onclick="fncPerform('submit');return false;">
							<img border="0" >
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formSendImage)"/></xsl:attribute>
							</img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/>
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
	
	<!--Other Templates-->
	
	<!-- Additional Informations 
	<xsl:template match="AdditionalInformation/line">
		<xsl:value-of select="."/>
	</xsl:template>
	-->
	<!-- Terms and Conditions 
	<xsl:template name="TERM_DETAILS">

		<xsl:param name="structure_name"/>
		<xsl:param name="mode"/>
		<xsl:param name="suffix">
			<xsl:if test="$mode = 'existing'"><xsl:value-of select="position()"></xsl:value-of></xsl:if>
			<xsl:if test="$mode = 'template'">nbElement</xsl:if>
		</xsl:param>
		<xsl:param name="data"></xsl:param>

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
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_term_clause_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="$data"/>
					</xsl:if>
				</div>
			</td>
			
			<td align="center" width="40">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_2</xsl:attribute>
				</xsl:if>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDisplayElement('<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
					<img border="0" src="/content/images/pic_edit.gif">
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
					</img>
				</a>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDeleteElement('<xsl:value-of  select="$structure_name"/>', <xsl:value-of select="$suffix"/>, ['term_table_header_1']);</xsl:attribute>
					<img border="0" src="/content/images/pic_trash.gif">
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/></xsl:attribute>
					</img>
				</a>
			</td>
		</tr>

		<tr>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td colspan="2">
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
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td width="100">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TERMDETAILS_CLAUSE')"/>
											</font>
										</td>
										<td>
											<input type="text" size="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_term_clause_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_term_clause_<xsl:value-of select="$suffix"/>');</xsl:attribute>
												<xsl:attribute name="value">
													<xsl:if test="$mode = 'existing'">
														<xsl:value-of select="$data"/>
													</xsl:if>
												</xsl:attribute>
											</input>
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="$suffix"/>
												</xsl:attribute>
											</input>
											<a href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('phrase','fakeform1','<xsl:value-of  select="$structure_name"/>_details_term_clause_<xsl:value-of select="$suffix"/>');return false;</xsl:attribute>
												<xsl:attribute name="name">anchor_search_free_format_text</xsl:attribute>
												<img border="0" src="/content/images/pic_list.gif">
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_PHRASES')"/></xsl:attribute>
													<xsl:attribute name="name">img_search_free_format_text</xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<table width="100%">
												<td align="right" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">fncAddElementValidate('<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, '', ['term_clause'], ['term_clause'], ['term_table_header_1']);</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
													</a>
												</td>
												<td width="10%"></td>
												<td align="left" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">fncAddElementCancel('<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, 'term_clause', ['term_table_header_1']);</xsl:attribute>
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
	-->
	
	<!--Payment Terms 
	<xsl:template match="PaymentTerms/line">
		<xsl:value-of select="."/>
	</xsl:template>
	-->
	
	<!-- Charge Details template 
	<xsl:template name="CHARGE_DETAILS">

		<xsl:param name="structure_name"/>
		<xsl:param name="mode"/>
		<xsl:param name="suffix">
			<xsl:if test="$mode = 'existing'"><xsl:value-of select="position()"></xsl:value-of></xsl:if>
			<xsl:if test="$mode = 'template'">nbElement</xsl:if>
		</xsl:param>
		<xsl:param name="charge_type"/>
		<xsl:param name="charge_description"/>
		<xsl:param name="charge_currency"/>
		<xsl:param name="charge_amount"/>
		<xsl:param name="charge_rate"/>
		<xsl:param name="charge_reporting_currency"/>
		<xsl:param name="charge_reporting_amount"/>
		
		<tr>
			<xsl:if test="$mode = 'template'">
				<xsl:attribute name="style">visibility:hidden</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="id">
				<xsl:value-of select="$structure_name"/>_header_<xsl:value-of select="$suffix"/>
			</xsl:attribute>
			
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_1</xsl:attribute>
				</xsl:if>
				<div align="left">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_charge_type_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="chargeType"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_3</xsl:attribute>
				</xsl:if>
				<div align="center">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_charge_currency_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:if test="chargeAmount[.!='']">
							<xsl:value-of select="chargeCurrencyCode"/>
						</xsl:if>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_4</xsl:attribute>
				</xsl:if>
				<div align="right">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_charge_amount_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:if test="chargeAmount[.!='']">
							<xsl:value-of select="converttools:getLocaleAmountRepresentation(chargeAmount,chargeCurrencyCode,$language)"/>
						</xsl:if>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_5</xsl:attribute>
				</xsl:if>
				<div align="center">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_charge_rate_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="rate"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_6</xsl:attribute>
				</xsl:if>
				<div align="center">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_charge_reporting_currency_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:if test="chargeReportingAmount[.!='']">
							<xsl:value-of select="//Totals/Total/totalCurrencyCode"/>
						</xsl:if>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_7</xsl:attribute>
				</xsl:if>
				<div align="right">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_charge_reporting_amount_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:if test="chargeReportingAmount[.!='']">
							<xsl:value-of select="converttools:getLocaleAmountRepresentation(chargeReportingAmount,//Totals/Total/totalCurrencyCode,$language)"/>
						</xsl:if>
					</xsl:if>
				</div>
			</td>
			
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_8</xsl:attribute>
				</xsl:if>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDisplayElement('<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
					<img border="0" src="/content/images/pic_edit.gif">
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
					</img>
				</a>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDeleteElement('<xsl:value-of  select="$structure_name"/>', <xsl:value-of select="$suffix"/>, ['charge_table_header_1', 'charge_table_header_2']);</xsl:attribute>
					<img border="0" src="/content/images/pic_trash.gif">
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/></xsl:attribute>
					</img>
				</a>
			</td>

		</tr>
		
		<tr>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td colspan="10">
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
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_TYPE')"/>
											</font>
										</td>
										<td>
											<input type="text" size="30" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_charge_type_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_charge_type_<xsl:value-of select="$suffix"/>');</xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="chargeType"/></xsl:attribute>
											</input>
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="$suffix"/>
												</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_DESCRIPTION')"/>
										</td>
										<td>
											<input type="text" size="30" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_charge_description_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="chargeDescription"/></xsl:attribute>
											</input>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_AMOUNT')"/>
											</font>
										</td>
										<td>
											<input type="text" size="3" maxlength="3">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_charge_currency_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="chargeCurrencyCode"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_charge_currency_<xsl:value-of select="$suffix"/>');fncDefaultExchangeRate('fakeform1', '<xsl:value-of select="$structure_name"/>_details_charge_currency_<xsl:value-of select="$suffix"/>', '<xsl:value-of select="$structure_name"/>_details_charge_reporting_currency_<xsl:value-of select="$suffix"/>', '<xsl:value-of  select="$structure_name"/>_details_charge_rate_<xsl:value-of select="$suffix"/>'); fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_charge_currency_<xsl:value-of select="$suffix"/>');fncCheckValidCurrency(this);fncFormatAmount(document.forms['fakeform1'].<xsl:value-of select="$structure_name"/>_details_charge_amount_<xsl:value-of select="$suffix"/>, fncGetCurrencyDecNo(this.value));</xsl:attribute>
											</input>
											<input type="text" size="20" maxlength="15">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_charge_amount_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_charge_amount_<xsl:value-of select="$suffix"/>');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].<xsl:value-of select="$structure_name"/>_details_charge_currency_<xsl:value-of select="$suffix"/>.value));</xsl:attribute>
												<xsl:attribute name="value">
													<xsl:if test="chargeAmount[.!='']">
														<xsl:value-of select="converttools:getLocaleAmountRepresentation(chargeAmount,chargeCurrencyCode,$language)"/>
													</xsl:if>
												</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_currency" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('currency', 'fakeform1', '<xsl:value-of  select="$structure_name"/>_details_charge_currency_<xsl:value-of select="$suffix"/>');return false;</xsl:attribute>
												<img border="0" src="/content/images/pic_search.gif" name="img_search_currency">
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>	
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_RATE')"/>
										</td>
										<td>
											<input type="text" size="10" maxlength="10">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_charge_rate_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="rate"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_charge_rate_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_EQV_AMOUNT')"/>
											</font>
										</td>
										<td>
											<input type="text" size="3" maxlength="3" disabled="disabled">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_charge_reporting_currency_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_charge_reporting_currency_<xsl:value-of select="$suffix"/>');</xsl:attribute>
												<xsl:attribute name="value">
													<xsl:if test="chargeReportingAmount[.!='']">
														<xsl:value-of select="//Totals/Total/totalCurrencyCode"/>
													</xsl:if>
												</xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_charge_reporting_currency_<xsl:value-of select="$suffix"/>');fncCheckValidCurrency(this);fncFormatAmount(document.forms['fakeform1'].<xsl:value-of select="$structure_name"/>_details_charge_reporting_amount_<xsl:value-of select="$suffix"/>, fncGetCurrencyDecNo(this.value));</xsl:attribute>
											</input>
											<input type="text" size="20" maxlength="15">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_charge_reporting_amount_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_charge_reporting_amount_<xsl:value-of select="$suffix"/>');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].<xsl:value-of select="$structure_name"/>_details_charge_reporting_currency_<xsl:value-of select="$suffix"/>.value));</xsl:attribute>
												<xsl:attribute name="value">
													<xsl:if test="chargeReportingAmount[.!='']">
														<xsl:value-of select="converttools:getLocaleAmountRepresentation(chargeReportingAmount,//Totals/Total/totalCurrencyCode,$language)"/>
													</xsl:if>
												</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_currency" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncComputeChargeAmount('fakeform1', '<xsl:value-of select="$suffix"/>');return false;</xsl:attribute>
												<img border="0" src="/content/images/execute.png" name="img_search_currency">
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_COMPUTE')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td colspan="2">
											<table width="100%">
												<td align="right" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">if (fncAddElementValidate('<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, '', ['charge_type', 'charge_amount', 'charge_currency','charge_reporting_currency', 'charge_reporting_amount'], ['charge_type', 'charge_amount', 'charge_currency', 'charge_rate', 'charge_reporting_currency', 'charge_reporting_amount'], ['charge_table_header_1', 'charge_table_header_2']) == true) { fncDisplayCancelButton('<xsl:value-of select="$structure_name"/>', '<xsl:value-of select="$suffix"/>');}</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
													</a>
												</td>
												<td width="10%"/>
												<td align="left" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_cancel_button_<xsl:value-of select="$suffix"/></xsl:attribute>
														<xsl:attribute name="onClick">fncAddElementCancel('<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, 'charge_type', ['charge_table_header_1', 'charge_table_header_2']);</xsl:attribute>
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
	-->
	
	<!--Packing Details 
	<xsl:template name="PACKAGE_DETAILS">
		
		<xsl:param name="structure_name"/>
		<xsl:param name="mode"/>
		<xsl:param name="suffix">
			<xsl:if test="$mode = 'existing'"><xsl:value-of select="position()"></xsl:value-of></xsl:if>
			<xsl:if test="$mode = 'template'">nbElement</xsl:if>
		</xsl:param>
		<xsl:param name="package_number"/>
		<xsl:param name="package_type"/>
		<xsl:param name="package_description"/>
		<xsl:param name="package_height"/>
		<xsl:param name="package_width"/>
		<xsl:param name="package_length"/>
		<xsl:param name="package_dimension_unit"/>
		<xsl:param name="package_netweight"/>
		<xsl:param name="package_grossweight"/>
		<xsl:param name="package_weight_unit"/>
		<xsl:param name="package_grossvolume"/>
		<xsl:param name="package_volume_unit"/>
		<xsl:param name="package_marks"/>

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
				<div align="right">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_package_number_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="numberOfPackages"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_2</xsl:attribute>
				</xsl:if>
				<div align="center">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_package_type_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="typeOfPackage"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_3</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_package_description_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="productName"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_4</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_package_marks_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="marksAndNumbers"/>
					</xsl:if>
				</div>
			</td>
			
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_5</xsl:attribute>
				</xsl:if>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDisplayElement('<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
					<img border="0" src="/content/images/pic_edit.gif">
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
					</img>
				</a>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDeleteElement('<xsl:value-of  select="$structure_name"/>', <xsl:value-of select="$suffix"/>, ['packing_table_header_1']);</xsl:attribute>
					<img border="0" src="/content/images/pic_trash.gif">
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/></xsl:attribute>
					</img>
				</a>
			</td>
		</tr>

		<tr>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td colspan="6">
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
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_NUMBER')"/>
											</font>
										</td>
										<td>
											<input type="text" size="10" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_number_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(numberOfPackages, $language)"/>
												</xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_package_number_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="$suffix"/>
												</xsl:attribute>
											</input>
											<input type="text" size="3" maxlength="3">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_type_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="typeOfPackage"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_type_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_package_type" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', '<xsl:value-of  select="$structure_name"/>_details_package_type_<xsl:value-of select="$suffix"/>', 'C005');return false;</xsl:attribute>
												<img border="0" src="/content/images/pic_search.gif" name="img_search_package_type">
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_PACKAGE_TYPE')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_DESCRIPTION')"/>
											</font>
										</td>
										<td>
											<input type="text" size="30" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_package_description_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="productName"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_package_description_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_DIMENSION_UNIT')"/>
										</td>
										<td>
											<input type="text" size="3" maxlength="3">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_dimension_unit_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="dimensionUnitCode"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_dimension_unit_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
											&nbsp;	
											<a name="anchor_search_dimension_unit" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', '<xsl:value-of  select="$structure_name"/>_details_package_dimension_unit_<xsl:value-of select="$suffix"/>', 'C004');return false;</xsl:attribute>
												<img border="0" src="/content/images/pic_search.gif" name="img_search_dimension_unit">
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_DIMENSION_UNIT')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_HEIGHT')"/>
										</td>
										<td>
											<input type="text" size="10" maxlength="10" >
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_height_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(heightValue, $language)"/>
												</xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_height_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_WIDTH')"/>
										</td>
										<td>
											<input type="text" size="10" maxlength="10" >
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_width_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(widthValue, $language)"/>
												</xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_width_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_LENGTH')"/>
										</td>
										<td>
											<input type="text" size="10" maxlength="10" >
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_length_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(lengthValue, $language)"/>
												</xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_length_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_WEIGHT_UNIT')"/>
										</td>
										<td>
											<input type="text" size="3" maxlength="3">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_weight_unit_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="weightUnitCode"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_weight_unit_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_weight_unit" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', '<xsl:value-of  select="$structure_name"/>_details_package_weight_unit_<xsl:value-of select="$suffix"/>', 'C002');return false;</xsl:attribute>
												<img border="0" src="/content/images/pic_search.gif" name="img_search_weight_unit">
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_WEIGHT_UNIT')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_NETWEIGHT')"/>
										</td>
										<td>
											<input type="text" size="10" maxlength="10" >
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_netweight_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(netWeightValue, $language)"/>
												</xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_netweight_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_GROSSWEIGHT')"/>
										</td>
										<td>
											<input type="text" size="10" maxlength="10" >
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_grossweight_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(grossWeightValue, $language)"/>
												</xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_grossweight_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_GROSSVOLUME')"/>
										</td>
										<td>
											<input type="text" size="10" maxlength="10">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_grossvolume_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(grossVolumeValue, $language)"/>
												</xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_grossvolume_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
											<input type="text" size="3" maxlength="3">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_volume_unit_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="volumeUnitCode"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_volume_unit_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_volume_unit" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', '<xsl:value-of  select="$structure_name"/>_details_package_volume_unit_<xsl:value-of select="$suffix"/>', 'C003');return false;</xsl:attribute>
												<img border="0" src="/content/images/pic_search.gif" name="img_search_volume_unit">
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VOLUME_UNIT')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_MARKS')"/>
										</td>
										<td>
											<input type="text" size="30" maxlength="35" >
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_marks_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="marksAndNumbers"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_marks_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td colspan="2">
											<table width="100%">
												<td align="right" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">fncAddElementValidate('<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, '', ['package_number', 'package_type', 'package_description'], ['package_number', 'package_type', 'package_description', 'package_marks'], ['packing_table_header_1']);</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
													</a>
												</td>
												<td width="10%"/>
												<td align="left" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">fncAddElementCancel('<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, 'package_type', ['packing_table_header_1']);</xsl:attribute>
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
	-->

	<!--Product Details 
	<xsl:template name="PRODUCT_DETAILS">

		<xsl:param name="structure_name"/>
		<xsl:param name="mode"/>
		<xsl:param name="suffix">
			<xsl:if test="$mode = 'existing'"><xsl:value-of select="position()"></xsl:value-of></xsl:if>
			<xsl:if test="$mode = 'template'">nbElement</xsl:if>
		</xsl:param>-

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
				<div align="center">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_product_identifier_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="productIdentification"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_2</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_product_description_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="productName"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_3</xsl:attribute>
				</xsl:if>
				<div align="right">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_product_rate_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(rate, $language)"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_4</xsl:attribute>
				</xsl:if>
				<div align="center">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_product_currency_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:if test="totalPrice[.!='']">
							<xsl:value-of select="//Totals/Total/totalCurrencyCode"/>
						</xsl:if>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_5</xsl:attribute>
				</xsl:if>
				<div align="right">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_product_price_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:if test="totalPrice[.!='']">
							<xsl:value-of select="converttools:getLocaleAmountRepresentation(totalPrice,//Totals/Total/totalCurrencyCode,$language)"/>
						</xsl:if>
					</xsl:if>
				</div>
			</td>
			
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_6</xsl:attribute>
				</xsl:if>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDisplayElement('<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
					<img border="0" src="/content/images/pic_edit.gif">
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
					</img>
				</a>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDeleteElement('<xsl:value-of  select="$structure_name"/>', <xsl:value-of select="$suffix"/>, ['product_table_header_1', 'product_table_header_2']);</xsl:attribute>
					<img border="0" src="/content/images/pic_trash.gif">
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/></xsl:attribute>
					</img>
				</a>
			</td>
		</tr>

		<tr>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td colspan="6">
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
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_REFERENCE')"/>
											</font>
										</td>
										<td>
											<input type="text" size="15" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_product_identifier_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="productIdentification"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_product_identifier_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="$suffix"/>
												</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_DESCRIPTION')"/>
										</td>
										<td>
											<input type="text" size="30" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_product_description_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="productName"/></xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PURCHASE_ORDER')"/>
										</td>
										<td>
											<input type="text" size="15" maxlength="35" >
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_purchase_order_id_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="purchaseOrderReference"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_purchase_order_id_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_EXPORT_LICENSE_ID')"/>
										</td>
										<td>
											<input type="text" size="15" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_export_license_id_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="exportLicenseReference"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_export_license_id_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_BASE_UNIT')"/>
											</font>
										</td>
										<td>
											<input type="text" size="3" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_base_unit_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="baseUnitOfMeasureCode"/></xsl:attribute>
												<xsl:attribute name="onblur">fncDefaultProductUnit('fakeform1', '<xsl:value-of select="$suffix"/>');fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_base_unit_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_measure_unit" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', '<xsl:value-of  select="$structure_name"/>_details_base_unit_<xsl:value-of select="$suffix"/>', 'C001');return false;</xsl:attribute>
												<img border="0" src="/content/images/pic_search.gif" name="img_search_measure_unit">
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_MEASURE_UNIT')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_BASE_PRICE')"/>
											</font>
										</td>
										<td>
											<input type="text" size="3" maxlength="3">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_base_currency_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="onblur">fncDefaultExchangeRate('fakeform1', '<xsl:value-of select="$structure_name"/>_details_base_currency_<xsl:value-of select="$suffix"/>', '<xsl:value-of select="$structure_name"/>_details_product_currency_<xsl:value-of select="$suffix"/>', '<xsl:value-of  select="$structure_name"/>_details_product_rate_<xsl:value-of select="$suffix"/>'); fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_base_currency_<xsl:value-of select="$suffix"/>');fncCheckValidCurrency(this);fncFormatAmount(document.forms['fakeform1'].<xsl:value-of  select="$structure_name"/>_details_base_price_<xsl:value-of select="$suffix"/>, fncGetCurrencyDecNo(this.value));</xsl:attribute>
												<xsl:attribute name="value">
													<xsl:if test="basePrice[.!='']">
														<xsl:value-of select="baseCurrencyCode"/>
													</xsl:if>
												</xsl:attribute>
											</input>
											<input type="text" size="20" maxlength="15">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_base_price_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:if test="basePrice[.!='']">
														<xsl:value-of select="converttools:getLocaleAmountRepresentation(basePrice,baseCurrencyCode,$language)"/>
													</xsl:if>
												</xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_base_price_<xsl:value-of select="$suffix"/>');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].<xsl:value-of  select="$structure_name"/>_details_base_currency_<xsl:value-of select="$suffix"/>.value));</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_currency" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('currency', 'fakeform1', '<xsl:value-of  select="$structure_name"/>_details_base_currency_<xsl:value-of select="$suffix"/>');return false;</xsl:attribute>
												<img border="0" src="/content/images/pic_search.gif" name="img_search_currency">
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_PRODUCT_QUANTITY')"/>
											</font>
										</td>
										<td>
											<input type="text" size="10">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_product_quantity_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(itemQuantity, $language)"/>
												</xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_product_quantity_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
											<input type="text" size="3" maxlength="3">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_product_unit_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="itemQuantityUnitOfMeasureCode"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_product_unit_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_measure_unit" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', '<xsl:value-of  select="$structure_name"/>_details_product_unit_<xsl:value-of select="$suffix"/>', 'C001');return false;</xsl:attribute>
												<img border="0" src="/content/images/pic_search.gif" name="img_search_measure_unit">
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_MEASURE_UNIT')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_PRODUCT_RATE')"/>
										</td>
										<td>
											<input type="text" size="10">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_product_rate_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(rate, $language)"/>
												</xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_product_rate_<xsl:value-of select="$suffix"/>');fncCheckRate(this);</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_PRODUCT_PRICE')"/>
											</font>
										</td>
										<td>
											<input type="text" size="3" maxlength="3" disabled="disabled">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_product_currency_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:if test="totalPrice[.!='']">
														<xsl:value-of select="//Totals/Total/totalCurrencyCode"/>
													</xsl:if>
												</xsl:attribute>
											</input>
											<input type="text" size="20" maxlength="15">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_product_price_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:if test="totalPrice[.!='']">
														<xsl:value-of select="converttools:getLocaleAmountRepresentation(totalPrice,//Totals/Total/totalCurrencyCode,$language)"/>
													</xsl:if>
												</xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_product_price_<xsl:value-of select="$suffix"/>');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].<xsl:value-of  select="$structure_name"/>_details_product_currency_<xsl:value-of select="$suffix"/>.value));</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_currency" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncComputeProductAmount('fakeform1', '<xsl:value-of select="$suffix"/>');return false;</xsl:attribute>
												<img border="0" src="/content/images/execute.png" name="img_search_currency">
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_COMPUTE')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td colspan="2">
											<table width="100%">
												<td align="right" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">if (fncAddElementValidate('<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, '', ['product_identifier', 'base_unit', 'base_currency', 'base_price', 'product_quantity', 'product_unit', 'product_currency', 'product_price'], ['product_identifier', 'product_description', 'product_rate', 'product_currency', 'product_price'], ['product_table_header_1', 'product_table_header_2']) == true) { fncDisplayCancelButton('<xsl:value-of select="$structure_name"/>', '<xsl:value-of select="$suffix"/>'); }</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
													</a>
												</td>
												<td width="10%"/>
												<td align="left" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_cancel_button_<xsl:value-of select="$suffix"/></xsl:attribute>
														<xsl:attribute name="onClick">fncAddElementCancel('<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, 'product_identifier', ['product_table_header_1', 'product_table_header_2']);</xsl:attribute>
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
	-->

</xsl:stylesheet>
