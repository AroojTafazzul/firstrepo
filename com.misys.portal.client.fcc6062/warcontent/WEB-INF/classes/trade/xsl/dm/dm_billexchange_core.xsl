<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:gtp="http://www.neomalogic.com"
		xmlns:cmp="http://www.bolero.net"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization converttools">
		
<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:import href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="upImage"><xsl:value-of select="$images_path"/>pic_up.gif</xsl:param>
	<xsl:param name="formSaveImage"><xsl:value-of select="$images_path"/>pic_form_save.gif</xsl:param>
	<xsl:param name="formCancelImage"><xsl:value-of select="$images_path"/>pic_form_cancel.gif</xsl:param>
	<xsl:param name="formHelpImage"><xsl:value-of select="$images_path"/>pic_form_help.gif</xsl:param>
	<xsl:param name="searchGifImage"><xsl:value-of select="$images_path"/>pic_search.gif</xsl:param>
	<xsl:param name="listImage"><xsl:value-of select="$images_path"/>pic_list.gif</xsl:param>
	
	
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

	<!-- -->
	<!--TEMPLATE Main for document generation-->
	<!-- -->
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
							<img border="0">
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
					<td class="FORMH1" colspan="3">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_BILL_OF_EXCHANGE')"/></b>&nbsp;-&nbsp;
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
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_VERSION')"/></td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="version"/></font>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TYPE')"/></td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_BILL_OF_EXCHANGE')"/></font>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_FORMAT')"/></td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="format"/></font>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DESCRIPTION')"/></td>
					<td>
						<input type="text" size="15" maxlength="35" name="description" onblur="fncRestoreInputStyle('fakeform1','description');">
							<xsl:attribute name="value"><xsl:value-of select="description"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>	
				<tr>
					<td>&nbsp;</td>
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
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COUNTRY_OF_ORIGIN')"/></td>
					<td>
						<input type="text" size="15" maxlength="35" name="country_of_origin" onblur="fncRestoreInputStyle('fakeform1','country_of_origin');">
							<xsl:attribute name="value"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:GeneralInformation/gtp:PlaceOfIssue/gtp:locationName"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PURCHASE_ORDER')"/></td>
					<td>
						<input type="text" size="15" maxlength="35" name="purchase_order_identifier" onblur="fncRestoreInputStyle('fakeform1','purchase_order_identifier');">
							<xsl:attribute name="value"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:GeneralInformation/gtp:PurchaseOrderIdentifier/gtp:documentNumber"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_ISSUING_BANK_REFERENCE')"/></td>
					<td>
						<input type="text" size="15" maxlength="35" name="issuing_bank_reference" onblur="fncRestoreInputStyle('fakeform1','issuing_bank_reference');">
							<xsl:attribute name="value"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:GeneralInformation/gtp:DocumentaryCreditIdentifier/gtp:documentNumber"/></xsl:attribute>
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
				</tr>
			</table>
					
			<br/>
			
			<!--Seller Details-->
			
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="15">&nbsp;</td>
					<td class="FORMH2" align="left">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SELLER_DETAILS')"/></b>
					</td>
					<td class="FORMH2" align="right">
						<a name="anchor_search_seller" href="javascript:void(0)">
							<xsl:attribute name="onclick">fncSearchPopup('beneficiary', 'fakeform1',"['seller_name', 'seller_address_line_1', 'seller_address_line_2', 'seller_dom']");return false;</xsl:attribute>
						</a>
					</td>
				</tr>
			</table>
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="seller_name" onblur="fncRestoreInputStyle('fakeform1','seller_name');">
							<xsl:attribute name="value">
								<xsl:choose>
									<xsl:when test="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:organizationName != ''"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:organizationName"/></xsl:when>
									<!-- Defaulting for scratch opening-->
									<xsl:otherwise><xsl:value-of select="user_company/name"/></xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="seller_address_line_1" onblur="fncRestoreInputStyle('fakeform1','seller_address_line_1');">
							<xsl:attribute name="value">
								<xsl:choose>
									<xsl:when test="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='1'] != ''"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='1']"/></xsl:when>
									<!-- Defaulting for scratch opening-->
									<xsl:otherwise><xsl:value-of select="user_company/address_line_1"/></xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>
						<input type="text" size="35" maxlength="35" name="seller_address_line_2" onblur="fncRestoreInputStyle('fakeform1','seller_address_line_2');">
							<xsl:attribute name="value">
								<xsl:choose>
									<xsl:when test="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='2'] != ''"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='2']"/></xsl:when>
									<!-- Defaulting for scratch opening-->
									<xsl:otherwise><xsl:value-of select="user_company/address_line_2"/></xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>
						<input type="text" size="35" maxlength="35" name="seller_dom" onblur="fncRestoreInputStyle('fakeform1','seller_dom');">
							<xsl:attribute name="value">
								<xsl:choose>
									<xsl:when test="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='3'] != ''"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='3']"/></xsl:when>
									<!-- Defaulting for scratch opening-->
									<xsl:otherwise><xsl:value-of select="user_company/dom"/></xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
					<td>
						<input type="text" size="35" maxlength="34" name="seller_reference" onblur="fncRestoreInputStyle('fakeform1','seller_reference');">
							<xsl:attribute name="value"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:OrganizationIdentification/gtp:organizationReference"/></xsl:attribute>
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
							<xsl:attribute name="onclick">fncSearchPopup('beneficiary', 'fakeform1',"['bill_to_name', 'bill_to_address_line_1', 'bill_to_address_line_2', 'bill_to_dom']");return false;</xsl:attribute>
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
							<xsl:attribute name="value"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:BillTo/gtp:organizationName"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
					<td>
						<input type="text" size="35" maxlength="35" name="bill_to_address_line_1" onblur="fncRestoreInputStyle('fakeform1','bill_to_address_line_1');">
							<xsl:attribute name="value"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:BillTo/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='1']"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>
						<input type="text" size="35" maxlength="35" name="bill_to_address_line_2" onblur="fncRestoreInputStyle('fakeform1','bill_to_address_line_2');">
							<xsl:attribute name="value"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:BillTo/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='2']"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>
						<input type="text" size="35" maxlength="35" name="bill_to_dom" onblur="fncRestoreInputStyle('fakeform1','bill_to_dom');">
							<xsl:attribute name="value"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:BillTo/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='3']"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
					<td>
						<input type="text" size="35" maxlength="34" name="bill_to_reference" onblur="fncRestoreInputStyle('fakeform1','bill_to_reference');">
							<xsl:attribute name="value"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:BillTo/gtp:OrganizationIdentification/gtp:organizationReference"/></xsl:attribute>
						</input>
					</td>
				</tr>
					
			</table>
			
			<p><br/></p>
			
			<!--Amount Details-->
	
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1" colspan="3">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TOTALS_DETAILS')"/></b>
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
			
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<font class="FORMMANDATORY">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_AMOUNT')"/>
						</font>
					</td>
					<td>
						<input type="text" size="3" maxlength="3" name="total_currency" onblur="fncRestoreInputStyle('fakeform1','total_currency');fncCheckValidCurrency(this);">
							<xsl:attribute name="value"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Totals/gtp:TotalAmount/gtp:MultiCurrency/gtp:currencyCode"/></xsl:attribute>
						</input>
					</td>
					<td>
						<input type="text" size="20" maxlength="15" name="total_amount" onblur="fncRestoreInputStyle('fakeform1','total_amount');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].total_currency.value));">
							<xsl:attribute name="value">
								<xsl:if test="gtp:BillOfExchange/gtp:Body/gtp:Totals/gtp:TotalAmount/gtp:MultiCurrency/gtp:value[.!='']">
									<xsl:variable name="amount"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Totals/gtp:TotalAmount/gtp:MultiCurrency/gtp:value"/></xsl:variable>
									<xsl:variable name="currency"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Totals/gtp:TotalAmount/gtp:MultiCurrency/gtp:currencyCode"/></xsl:variable>
									<xsl:value-of select="converttools:getLocaleAmountRepresentation($amount,$currency,$language)"/>
								</xsl:if>
							</xsl:attribute>
						</input>
					</td>
					<td>
						<a name="anchor_search_reporting_currency" href="javascript:void(0)">
							<xsl:attribute name="onclick">fncSearchPopup('currency', 'fakeform1',"['total_currency']");return false;</xsl:attribute>
							<img border="0" name="img_search_reporting_currency">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
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
					<textarea wrap="hard" name="additionnal_information" cols="65" rows="8" >
						<xsl:attribute name="onblur">fncFormatTextarea(this,100,65);fncRestoreInputStyle('fakeform1','additionnal_information');</xsl:attribute>
						<xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:AdditionalInformation/gtp:line"/>
					</textarea>
				</td>
				<td valign="top">
					<a href="javascript:void(0)">
						<xsl:attribute name="onclick">fncSearchPopup('phrase','fakeform1',"['additionnal_information']");return false;</xsl:attribute>
						<xsl:attribute name="name">anchor_search_free_format_text</xsl:attribute>
						<img border="0">
							<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($listImage)"/></xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_PHRASES')"/></xsl:attribute>
							<xsl:attribute name="name">img_search_free_format_text</xsl:attribute>
						</img>
					</a>
				</td>
			</tr>
			</table>
	
			<br/>
			</form>
			
			<!--POST parameters-->
			<form name="realform" method="POST" action="/gtp/screen/DocumentManagementScreen">
			
				<!--POST parameters-->
				<input type="hidden" name="operation" value="SAVE"/>
				<input type="hidden" name="referenceid"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
				<input type="hidden" name="option" value="DOCUMENT"/>
				<input type="hidden" name="mode" value="DRAFT"/>
				<input type="hidden" name="TransactionData"/>
				<input type="hidden" name="code"><xsl:attribute name="value"><xsl:value-of select="code"/></xsl:attribute></input>
				<input type="hidden" name="format"><xsl:attribute name="value"><xsl:value-of select="format"/></xsl:attribute></input>
				<input type="hidden" name="type"><xsl:attribute name="value"><xsl:value-of select="type"/></xsl:attribute></input>
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
							<img border="0">
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
			
		</td>
		</tr>
		</table>
		
		</td>
		</tr>
		</table>

	</xsl:template>

	
	<!-- -->	
	<!--Other Templates-->
	
	<!--Additional Informations-->
	<xsl:template match="gtp:AdditionalInformation/gtp:line">
		<xsl:value-of select="."/>
	</xsl:template>
	
</xsl:stylesheet>
