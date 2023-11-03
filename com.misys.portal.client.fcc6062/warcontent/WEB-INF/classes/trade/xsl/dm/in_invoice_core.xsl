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
		exclude-result-prefixes="localization converttools">
		
<!--
   Copyright (c) 2000-2005 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:import href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:import href="../trade_common_dm_details.xsl"/>
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
		<script type="text/javascript" src="/content/OLD/javascript/trade_create_document.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_amount.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_date.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/trade_common_dm.js"></script>

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
				
			
			
				<!--The following data are fetched the xml document preparation representation, and both dates and amounts are expressed in standard bolero format.-->
				<!--A conversion is therefore required to have it in user locale -->
	
				<!--References-->
		
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="3">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_COMM_INVOICE')"/></b>&nbsp;-&nbsp;
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
							<font class="REPORTDATA"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_COMM_INVOICE')"/></font>
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
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COMMERCIAL_INVOICE')"/></td>
						<td>
							<input type="text" size="15" maxlength="35" name="comercial_invoice_identifier" onblur="fncRestoreInputStyle('fakeform1','comercial_invoice_identifier');">
								<xsl:attribute name="value">
								<xsl:if test="CommercialInvoice/Header/cmp:DocumentID/cmp:GeneralID[.='']">
									<xsl:value-of select="cust_ref_id"/>
								</xsl:if>
								<xsl:value-of select="CommercialInvoice/Header/cmp:DocumentID/cmp:GeneralID"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<!-- The reporting currency is amendable by the user. It is initially defaulted from the total currency. -->
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170">
							<font class="FORMMANDATORY">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_REPORTING_CURRENCY')"/>
							</font>
						</td>
						
						<td>
							<input type="text" size="3" maxlength="3" name="reporting_currency">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Totals/TotalAmount/MultiCurrency/currencyCode"/></xsl:attribute>
								<xsl:attribute name="onblur">fncCheckTotalCurrency('reporting_currency', 'old_reporting_currency'); fncRestoreInputStyle('fakeform1','reporting_currency'); document.forms['fakeform1'].total_currency.value=this.value;</xsl:attribute>
							</input>
							<!-- Hidden field used to store the previous old total currency -->
							<input type="hidden" name="old_reporting_currency">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Totals/TotalAmount/MultiCurrency/currencyCode"/></xsl:attribute>
							</input>
							<a name="anchor_search_reporting_currency" href="javascript:void(0)">
								<xsl:attribute name="onclick">fncSearchPopup('currency', 'fakeform1',"['reporting_currency']");return false;</xsl:attribute>
								<img border="0" src="/content/images/pic_search.gif" name="img_search_reporting_currency">
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
								</img>
							</a>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COUNTRY_OF_ORIGIN')"/></td>
						<td>
							<input type="text" size="15" maxlength="35" name="country_of_origin" onblur="fncRestoreInputStyle('fakeform1','country_of_origin');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/RoutingSummary/CountryOfOrigin/countryName"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PURCHASE_ORDER')"/></td>
						<td>
							<input type="text" size="15" maxlength="35" name="purchase_order_identifier" onblur="fncRestoreInputStyle('fakeform1','purchase_order_identifier');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/GeneralInformation/PurchaseOrderIdentifier/documentNumber"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_ISSUING_BANK_REFERENCE')"/></td>
						<td>
							<input type="text" size="15" maxlength="35" name="issuing_bank_reference" onblur="fncRestoreInputStyle('fakeform1','issuing_bank_reference');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/GeneralInformation/DocumentaryCreditIdentifier/documentNumber"/></xsl:attribute>
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
								<img border="0" src="/content/images/pic_search.gif" name="img_search_beneficiary">
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_SELLER')"/></xsl:attribute>
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
							<input type="text" size="35" maxlength="35" name="seller_name" onblur="fncRestoreInputStyle('fakeform1','seller_name');">
								<xsl:attribute name="value">
									<xsl:choose>
										<xsl:when test="CommercialInvoice/Body/Parties/Seller/organizationName != ''"><xsl:value-of select="CommercialInvoice/Body/Parties/Seller/organizationName"/></xsl:when>
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
										<xsl:when test="CommercialInvoice/Body/Parties/Seller/AddressInformation/FullAddress/line[position()='1'] != ''"><xsl:value-of select="CommercialInvoice/Body/Parties/Seller/AddressInformation/FullAddress/line[position()='1']"/></xsl:when>
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
										<xsl:when test="CommercialInvoice/Body/Parties/Seller/AddressInformation/FullAddress/line[position()='2'] != ''"><xsl:value-of select="CommercialInvoice/Body/Parties/Seller/AddressInformation/FullAddress/line[position()='2']"/></xsl:when>
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
										<xsl:when test="CommercialInvoice/Body/Parties/Seller/AddressInformation/FullAddress/line[position()='3'] != ''"><xsl:value-of select="CommercialInvoice/Body/Parties/Seller/AddressInformation/FullAddress/line[position()='3']"/></xsl:when>
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
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Parties/Seller/OrganizationIdentification/organizationReference"/></xsl:attribute>
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
								<xsl:attribute name="onclick">fncSearchPopup('beneficiary', 'fakeform1',"['buyer_name', 'buyer_address_line_1', 'buyer_address_line_2', 'buyer_dom']");return false;</xsl:attribute>
								<img border="0" src="/content/images/pic_search.gif" name="img_search_beneficiary">
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
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Parties/Buyer/organizationName"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
						<td>
							<input type="text" size="35" maxlength="35" name="buyer_address_line_1" onblur="fncRestoreInputStyle('fakeform1','buyer_address_line_1');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='1']"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>
							<input type="text" size="35" maxlength="35" name="buyer_address_line_2" onblur="fncRestoreInputStyle('fakeform1','buyer_address_line_2');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='2']"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>
							<input type="text" size="35" maxlength="35" name="buyer_dom" onblur="fncRestoreInputStyle('fakeform1','buyer_dom');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='3']"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
						<td>
							<input type="text" size="35" maxlength="34" name="buyer_reference" onblur="fncRestoreInputStyle('fakeform1','buyer_reference');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Parties/Buyer/OrganizationIdentification/organizationReference"/></xsl:attribute>
							</input>
						</td>
					</tr>
						
				</table>
				
				<p><br/></p>
				<!--Consignee Details-->
				<table border="0" cellspacing="0" width="570">
					<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONSIGNEE_DETAILS')"/></b>
						</td>
						<td class="FORMH2" align="right">
							<a name="anchor_search_beneficiary" href="javascript:void(0)">
								<xsl:attribute name="onclick">fncSearchPopup('beneficiary', 'fakeform1',"['consignee_name', 'consignee_address_line_1', 'consignee_address_line_2', 'consignee_dom']");return false;</xsl:attribute>
								<img border="0" src="/content/images/pic_search.gif" name="img_search_beneficiary">
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
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Parties/Consignee/organizationName"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
						<td>
							<input type="text" size="35" maxlength="35" name="consignee_address_line_1" onblur="fncRestoreInputStyle('fakeform1','consignee_address_line_1');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='1']"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>
							<input type="text" size="35" maxlength="35" name="consignee_address_line_2" onblur="fncRestoreInputStyle('fakeform1','consignee_address_line_2');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='2']"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>
							<input type="text" size="35" maxlength="35" name="consignee_dom" onblur="fncRestoreInputStyle('fakeform1','consignee_dom');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='3']"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
						<td>
							<input type="text" size="35" maxlength="34" name="consignee_reference" onblur="fncRestoreInputStyle('fakeform1','consignee_reference');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Parties/Consignee/OrganizationIdentification/organizationReference"/></xsl:attribute>
							</input>
						</td>
					</tr>
						
				</table>
				
				<p>
					<br/>
				</p>
				
				<!--Billto Details-->
				
				<table border="0" cellspacing="0" width="570">
					<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BILL_TO_DETAILS')"/>&nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PARTIES_DETAILS_INFORMATION')"/></b>
						</td>
						<td class="FORMH2" align="right">
							<a name="anchor_search_beneficiary" href="javascript:void(0)">
								<xsl:attribute name="onclick">fncSearchPopup('beneficiary', 'fakeform1',"['bill_to_name', 'bill_to_address_line_1', 'bill_to_address_line_2', 'bill_to_dom']");return false;</xsl:attribute>
								<img border="0" src="/content/images/pic_search.gif" name="img_search_beneficiary">
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
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Parties/BillTo/organizationName"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
						<td>
							<input type="text" size="35" maxlength="35" name="bill_to_address_line_1" onblur="fncRestoreInputStyle('fakeform1','bill_to_address_line_1');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Parties/BillTo/AddressInformation/FullAddress/line[position()='1']"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>
							<input type="text" size="35" maxlength="35" name="bill_to_address_line_2" onblur="fncRestoreInputStyle('fakeform1','bill_to_address_line_2');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Parties/BillTo/AddressInformation/FullAddress/line[position()='2']"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>
							<input type="text" size="35" maxlength="35" name="bill_to_dom" onblur="fncRestoreInputStyle('fakeform1','bill_to_dom');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Parties/BillTo/AddressInformation/FullAddress/line[position()='3']"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
						<td>
							<input type="text" size="35" maxlength="34" name="bill_to_reference" onblur="fncRestoreInputStyle('fakeform1','bill_to_reference');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Parties/BillTo/OrganizationIdentification/organizationReference"/></xsl:attribute>
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
								<img border="0" src="/content/images/pic_up.gif">
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
								<xsl:if test="count(CommercialInvoice/Body/TermsAndConditions/clause) != 0">
									<xsl:attribute name="style">display:none</xsl:attribute>
								</xsl:if>
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TERMDETAILS_NO_TERM')"/></b>
							</div>
							
							<table border="0" width="570" cellpadding="0" cellspacing="1" id="term_master_table">
								<xsl:if test="count(CommercialInvoice/Body/TermsAndConditions/clause) = 0">
									<xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
								</xsl:if>
								<tbody id="term_table">
	
									<!-- Columns Header -->
									<tr>
										<xsl:attribute name="id">term_table_header_1</xsl:attribute>
										<xsl:if test="count(CommercialInvoice/Body/TermsAndConditions/clause) = 0">
											<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
										</xsl:if>
										<th class="FORMH2" align="center" width="90%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TABLE_CLAUSE')"/></th>
										<th class="FORMH2" width="10%">&nbsp;</th>
									</tr>
									
									<!-- Details -->
									<xsl:for-each select="CommercialInvoice/Body/TermsAndConditions/clause">
										
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
								<xsl:attribute name="onClick">fncAddElement('fakeform1', 'term', '');</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TERMDETAILS_ADD_TERM')"/>
							</a>
						</td>
					</tr>
				</table>
				<!--*********************-->
				<!-- End of Term Details -->
				<!--*********************-->
						
				<p><br/></p>
				
				
				<!--Routing Summary / Shipment Details-->
		
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="3">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ROUTING_SUMMARY_DETAILS')"/></b>
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
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TRANSPORT_SERVICE')"/></td>
						<td>
							<input type="text" size="35" maxlength="35" name="transport_service" onblur="fncRestoreInputStyle('fakeform1','transport_service');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/RoutingSummary/transportService"/></xsl:attribute>
							</input>
						</td>
					</tr>	
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TRANSPORT_BY')"/></td>
						<td>
								<select name="transport_type" onchange="fncRestoreInputStyle('fakeform1','transport_type');">
									<option value="">
									</option>
									<option value="MARITIME">
										<xsl:if test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification">
											<xsl:attribute name="selected"/>
										</xsl:if>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_01_SEA')"/>
									</option>
									<option value="RAIL">
										<xsl:if test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/RailTransportIdentification">
											<xsl:attribute name="selected"/>
										</xsl:if>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_03_RAIL')"/>
									</option>
									<option value="ROAD">
										<xsl:if test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/RoadTransportIdentification">
											<xsl:attribute name="selected"/>
										</xsl:if>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_04_TRUCK')"/>
									</option>
									<option value="AIR">
										<xsl:if test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/FlightDetails">
											<xsl:attribute name="selected"/>
										</xsl:if>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_02_AIR')"/>
									</option>
									<!-- Not used for commercial invoice: no corresponding fields
									<option value="MAIL">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_05_POSTAGE')"/>
									</option>
									<option value="MULTIMODAL">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_06_MIXED')"/>
									</option>
									-->
									<option value="INLANDWATER">
										<xsl:if test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification[. = 'INLANDWATER']">
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
									<xsl:if test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/VoyageDetail/departureDate[.!='']">
										<xsl:variable name="date"><xsl:value-of select="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/VoyageDetail/departureDate"/></xsl:variable>
										<xsl:value-of select="converttools:getLocaleTimestampRepresentation($date,$language)"/>
									</xsl:if>
									<xsl:if test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/FlightDetails/departureDate[.!='']">
										<xsl:variable name="date"><xsl:value-of select="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/FlightDetails/departureDate"/></xsl:variable>
										<xsl:value-of select="converttools:getLocaleTimestampRepresentation($date,$language)"/>
									</xsl:if>
								</xsl:attribute>
							</input>
						</td>
					</tr>	
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_LOADING_PLACE')"/></td>
						<td>
							<input type="text" size="35" maxlength="35" name="place_of_loading" onblur="fncRestoreInputStyle('fakeform1','place_of_loading');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/RoutingSummary/PlaceOfLoading/locationName"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DISCHARGE_PLACE')"/></td>
						<td>
							<input type="text" size="35" maxlength="35" name="place_of_discharge" onblur="fncRestoreInputStyle('fakeform1','place_of_discharge');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/RoutingSummary/PlaceOfDischarge/locationName"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DELIVERY_PLACE')"/></td>
						<td>
							<input type="text" size="35" maxlength="35" name="place_of_delivery" onblur="fncRestoreInputStyle('fakeform1','place_of_delivery');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/RoutingSummary/PlaceOfDelivery/locationName"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_VESSEL')"/></td>
						<td>
							<input type="text" size="35" maxlength="35" name="vessel_name" onblur="fncRestoreInputStyle('fakeform1','vessel_name');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/Vessel/vesselName"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TRANSPORT_REFERENCE')"/></td>
						<td>
							<input type="text" size="35" maxlength="35" name="transport_reference" onblur="fncRestoreInputStyle('fakeform1','transport_reference');">
								<xsl:attribute name="value">
									<xsl:if test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification">
										<xsl:value-of select="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/VoyageDetail/voyageNumber"/>
									</xsl:if>
									<xsl:if test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/FlightDetails">
										<xsl:value-of select="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/FlightDetails/flightNumber"/>
									</xsl:if>
									<xsl:if test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/RoadTransportIdentification">
										<xsl:value-of select="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/RoadTransportIdentification/licencePlateIdentification"/>
									</xsl:if>
									<xsl:if test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/RailTransportIdentification">
										<xsl:value-of select="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/RailTransportIdentification/locomotiveNumber"/>
									</xsl:if>
								</xsl:attribute>
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
									<xsl:if test="CommercialInvoice/Body/GeneralInformation/Incoterms/incotermsCode[. = '']">
										<xsl:attribute name="selected"/>
									</xsl:if>
								</option>
								<option value="EXW">
									<xsl:if test="CommercialInvoice/Body/GeneralInformation/Incoterms/incotermsCode[. = 'EXW']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									EXW
								</option>
								<option value="FCA">
									<xsl:if test="CommercialInvoice/Body/GeneralInformation/Incoterms/incotermsCode[. = 'FCA']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									FCA
								</option>
								<option value="FAS">
									<xsl:if test="CommercialInvoice/Body/GeneralInformation/Incoterms/incotermsCode[. = 'FAS']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									FAS
								</option>
								<option value="FOB">
									<xsl:if test="CommercialInvoice/Body/GeneralInformation/Incoterms/incotermsCode[. = 'FOB']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									FOB
								</option>
								<option value="CFR">
									<xsl:if test="CommercialInvoice/Body/GeneralInformation/Incoterms/incotermsCode[. = 'CFR']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									CFR
								</option>
								<option value="CIF">
									<xsl:if test="CommercialInvoice/Body/GeneralInformation/Incoterms/incotermsCode[. = 'CIF']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									CIF
								</option>
								<option value="CPT">
									<xsl:if test="CommercialInvoice/Body/GeneralInformation/Incoterms/incotermsCode[. = 'CPT']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									CPT
								</option>
								<option value="CIP">
									<xsl:if test="CommercialInvoice/Body/GeneralInformation/Incoterms/incotermsCode[. = 'CIP']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									CIP
								</option>
								<option value="DAF">
									<xsl:if test="CommercialInvoice/Body/GeneralInformation/Incoterms/incotermsCode[. = 'DAF']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									DAF
								</option>
								<option value="DES">
									<xsl:if test="CommercialInvoice/Body/GeneralInformation/Incoterms/incotermsCode[. = 'DES']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									DES
								</option>
								<option value="DEQ">
									<xsl:if test="CommercialInvoice/Body/GeneralInformation/Incoterms/incotermsCode[. = 'DEQ']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									DEQ
								</option>
								<option value="DDU">
									<xsl:if test="CommercialInvoice/Body/GeneralInformation/Incoterms/incotermsCode[. = 'DDU']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									DDU
								</option>
								<option value="DDP">
									<xsl:if test="CommercialInvoice/Body/GeneralInformation/Incoterms/incotermsCode[. = 'DDP']">
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
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/GeneralInformation/Incoterms/NamedLocation/locationName"/></xsl:attribute>
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
								<img border="0" src="/content/images/pic_up.gif">
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
								<xsl:if test="count(CommercialInvoice/Body/LineItemDetails/LineItem) != 0">
									<xsl:attribute name="style">display:none</xsl:attribute>
								</xsl:if>
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_NO_PRODUCT')"/></b>
							</div>
									
							<table border="0" width="570" cellpadding="0" cellspacing="1" id="product_master_table">
								<xsl:if test="count(CommercialInvoice/Body/LineItemDetails/LineItem) = 0">
									<xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
								</xsl:if>
								<tbody id="product_table">
	
									<!-- Columns Header -->
									<tr>
										<xsl:attribute name="id">product_table_header_1</xsl:attribute>
										<xsl:if test="count(CommercialInvoice/Body/LineItemDetails/LineItem) = 0">
											<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
										</xsl:if>
										<th class="FORMH2" rowspan="2" align="center" width="20%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_REFERENCE')"/></th>
										<th class="FORMH2" rowspan="2" align="center" width="30%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_PRODUCT')"/></th>
										<th class="FORMH2" colspan="3" align="center" width="40%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_TOTALVALUE')"/></th>
										<th class="FORMH2" rowspan="2" width="10%">&nbsp;</th>
									</tr>
									<tr>
										<xsl:attribute name="id">product_table_header_2</xsl:attribute>
										<xsl:if test="count(CommercialInvoice/Body/LineItemDetails/LineItem) = 0">
											<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
										</xsl:if>
										<th class="FORMH2" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_RATE')"/></th>
										<th class="FORMH2" colspan="2" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_VALUE')"/></th>
									</tr>
	
									<!-- Details -->
									<xsl:for-each select="CommercialInvoice/Body/LineItemDetails/LineItem">
										
										<xsl:call-template name="PRODUCT_DETAILS">
	
											<xsl:with-param name="structure_name">product</xsl:with-param>
											<xsl:with-param name="mode">existing</xsl:with-param>
											<xsl:with-param name="product_identifier"><xsl:value-of select="Product/ProductIdentifiers/productIdentification"/></xsl:with-param>
											<xsl:with-param name="product_description"><xsl:value-of select="Product/productName"/></xsl:with-param>
											<xsl:with-param name="purchase_order_id"><xsl:value-of select="PurchaseOrderIdentifier/documentNumber"/></xsl:with-param>
											<xsl:with-param name="export_license_id"><xsl:value-of select="ExportLicenseIdentifier/documentNumber"/></xsl:with-param>
											<xsl:with-param name="base_currency"><xsl:value-of select="UnitPrice/currencyCode"/></xsl:with-param>
											<xsl:with-param name="base_unit"><xsl:value-of select="UnitPrice/unitOfMeasureCode"/></xsl:with-param>
											<xsl:with-param name="base_price"><xsl:value-of select="converttools:getLocaleAmountRepresentation(UnitPrice/value,UnitPrice/currencyCode,$language)"/></xsl:with-param>
											<xsl:with-param name="product_quantity"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(LineItemQuantity/value,$language)"/></xsl:with-param>
											<xsl:with-param name="product_unit"><xsl:value-of select="LineItemQuantity/unitOfMeasureCode"/></xsl:with-param>
											<xsl:with-param name="product_currency"><xsl:value-of select="gtp:EquivalentAmount/gtp:currencyCode"/></xsl:with-param>
											<xsl:with-param name="product_rate"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(gtp:EquivalentAmount/gtp:rate,$language)"/></xsl:with-param>
											<xsl:with-param name="product_price"><xsl:value-of select="converttools:getLocaleAmountRepresentation(gtp:EquivalentAmount/gtp:value,gtp:EquivalentAmount/gtp:currencyCode,$language)"/></xsl:with-param>
	
										</xsl:call-template>
										
									</xsl:for-each>
								</tbody>
							</table>
							<br/>
							<a href="javascript:void(0)">
								<xsl:attribute name="onClick">fncAddElement('fakeform1', 'product', 'fncDefaultProductDetails');</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_ADD_PRODUCT')"/>
							</a>
						</td>
					</tr>
				</table>
				<!--************************-->
				<!-- End of Product Details -->
				<!--************************-->
				<p><br/></p>
		
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
								<img border="0" src="/content/images/pic_up.gif">
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
								<xsl:if test="count(CommercialInvoice/Body/gtp:PackingDetail/gtp:Package) != 0">
									<xsl:attribute name="style">display:none</xsl:attribute>
								</xsl:if>
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_NO_PACKAGE')"/></b>
							</div>
							
							<table border="0" width="570" cellpadding="0" cellspacing="1" id="packing_master_table">
								<xsl:if test="count(CommercialInvoice/Body/gtp:PackingDetail/gtp:Package) = 0">
									<xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
								</xsl:if>
								<tbody id="packing_table">
									
									<!-- Columns Header -->
									<tr>
										<xsl:attribute name="id">packing_table_header_1</xsl:attribute>
										<xsl:if test="count(CommercialInvoice/Body/gtp:PackingDetail/gtp:Package) = 0">
											<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
										</xsl:if>
										<th class="FORMH2" align="center" width="10%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_QUANTITY')"/></th>
										<th class="FORMH2" align="center" width="10%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_TYPE')"/></th>
										<th class="FORMH2" align="center" width="40%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_DESCRIPTION')"/></th>
										<th class="FORMH2" align="center" width="30%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_MARKS')"/></th>
										<th class="FORMH2" width="10%"></th>
									</tr>
									
									<!-- Details -->
									<xsl:for-each select="CommercialInvoice/Body/gtp:PackingDetail/gtp:Package">
										
										<xsl:call-template name="PACKAGE_DETAILS">
	
											<xsl:with-param name="structure_name">packing</xsl:with-param>
											<xsl:with-param name="mode">existing</xsl:with-param>
											<xsl:with-param name="package_number"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(gtp:PackageCount/gtp:numberOfPackages,$language)"/></xsl:with-param>
											<xsl:with-param name="package_type"><xsl:value-of select="gtp:PackageCount/gtp:typeOfPackage"/></xsl:with-param>
											<xsl:with-param name="package_description"><xsl:value-of select="gtp:Content/gtp:Product/gtp:productName"/></xsl:with-param>
											<xsl:with-param name="package_height"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(gtp:PackageDimensions/gtp:heightValue,$language)"/></xsl:with-param>
											<xsl:with-param name="package_width"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(gtp:PackageDimensions/gtp:widthValue,$language)"/></xsl:with-param>
											<xsl:with-param name="package_length"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(gtp:PackageDimensions/gtp:lengthValue,$language)"/></xsl:with-param>
											<xsl:with-param name="package_dimension_unit"><xsl:value-of select="gtp:PackageDimensions/gtp:dimensionUnitCode"/></xsl:with-param>
											<xsl:with-param name="package_netweight"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(gtp:NetWeight/gtp:value,$language)"/></xsl:with-param>
											<xsl:with-param name="package_grossweight"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(gtp:GrossWeight/gtp:value,$language)"/></xsl:with-param>
											<xsl:with-param name="package_weight_unit"><xsl:value-of select="gtp:NetWeight/gtp:weightUnitCode"/></xsl:with-param>
											<xsl:with-param name="package_grossvolume"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(gtp:GrossVolume/gtp:value,$language)"/></xsl:with-param>
											<xsl:with-param name="package_volume_unit"><xsl:value-of select="gtp:GrossVolume/gtp:volumeUnitCode"/></xsl:with-param>
											<xsl:with-param name="package_marks"><xsl:value-of select="gtp:marksAndNumbers"/></xsl:with-param>
		
	
										</xsl:call-template>
										
									</xsl:for-each>
								</tbody>
							</table>
							<br/>
							<a href="javascript:void(0)">
								<xsl:attribute name="onClick">fncAddElement('fakeform1', 'packing', 'fncDefaultPackingDetails');</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_ADD_PACKAGE')"/>
							</a>
						</td>
					</tr>
				</table>
				<!--************************-->
				<!-- End of Packing Details -->
				<!--************************-->
				<br/>
		
				<!-- Summary of total weight and volumes-->
				
				<table width="570" widborder="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_NETWEIGHT')"/></td>
						<td>
							<input type="text" size="10" maxlength="10" name="total_net_weight" onblur="fncRestoreInputStyle('fakeform1','total_net_weight'); fncFormatDecimal(this);">
								<xsl:attribute name="value">
									<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalNetWeight/gtp:value,$language)"/>
								</xsl:attribute>
							</input>
							<input type="text" size="3" maxlength="3" name="total_net_weight_unit" onblur="fncRestoreInputStyle('fakeform1','total_net_weight_unit');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalNetWeight/gtp:weightUnitCode"/></xsl:attribute>
							</input>
							&nbsp;
							<a name="anchor_search_weight_unit" href="javascript:void(0)">
								<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', 'total_net_weight_unit', 'C002');return false;</xsl:attribute>
								<img border="0" src="/content/images/pic_search.gif" name="img_search_weight_unit">
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_WEIGHT_UNIT')"/></xsl:attribute>
								</img>
							</a>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_GROSSWEIGHT')"/></td>
						<td>
							<input type="text" size="10" maxlength="10" name="total_gross_weight" onblur="fncRestoreInputStyle('fakeform1','total_gross_weight'); fncFormatDecimal(this);">
								<xsl:attribute name="value">
									<!--
									<xsl:value-of select="CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalGrossWeight/gtp:value"/>
									-->
									<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalGrossWeight/gtp:value,$language)"/>
								</xsl:attribute>
							</input>
							<input type="text" size="3" maxlength="3" name="total_gross_weight_unit" onblur="fncRestoreInputStyle('fakeform1','total_gross_weight_unit');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalGrossWeight/gtp:weightUnitCode"/></xsl:attribute>
							</input>
							&nbsp;
							<a name="anchor_search_weight_unit" href="javascript:void(0)">
								<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', 'total_gross_weight_unit', 'C002');return false;</xsl:attribute>
								<img border="0" src="/content/images/pic_search.gif" name="img_search_weight_unit">
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_WEIGHT_UNIT')"/></xsl:attribute>
								</img>
							</a>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_NETVOLUMNE')"/></td>
						<td>
							<input type="text" size="10" maxlength="10" name="total_net_volume" onblur="fncRestoreInputStyle('fakeform1','total_net_volume'); fncFormatDecimal(this);">
								<xsl:attribute name="value">
									<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalNetVolume/gtp:value,$language)"/>
								</xsl:attribute>
							</input>
							<input type="text" size="3" maxlength="3" name="total_net_volume_unit" onblur="fncRestoreInputStyle('fakeform1','total_net_volume_unit');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalNetVolume/gtp:volumeUnitCode"/></xsl:attribute>
							</input>
							&nbsp;
							<a name="anchor_search_volume_unit" href="javascript:void(0)">
								<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', 'total_net_volume_unit', 'C003');return false;</xsl:attribute>
								<img border="0" src="/content/images/pic_search.gif" name="img_search_volume_unit">
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VOLUME_UNIT')"/></xsl:attribute>
								</img>
							</a>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_GROSSVOLUME')"/></td>
						<td>
							<input type="text" size="10" maxlength="10" name="total_gross_volume" onblur="fncRestoreInputStyle('fakeform1','total_gross_volume'); fncFormatDecimal(this);">
								<xsl:attribute name="value">
									<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalGrossVolume/gtp:value,$language)"/>
								</xsl:attribute>
							</input>
							<input type="text" size="3" maxlength="3" name="total_gross_volume_unit" onblur="fncRestoreInputStyle('fakeform1','total_gross_volume_unit');">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalGrossVolume/gtp:volumeUnitCode"/></xsl:attribute>
							</input>
							&nbsp;
							<a name="anchor_search_volume_unit" href="javascript:void(0)">
								<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', 'total_gross_volume_unit', 'C003');return false;</xsl:attribute>
								<img border="0" src="/content/images/pic_search.gif" name="img_search_volume_unit">
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
								<img border="0" src="/content/images/pic_up.gif">
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
								<xsl:if test="count(CommercialInvoice/Body/GeneralChargesOrDiscounts) != 0">
									<xsl:attribute name="style">display:none</xsl:attribute>
								</xsl:if>
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_NO_CHARGE')"/></b>
							</div>
							
							<table border="0" width="570" cellpadding="0" cellspacing="1" id="charge_master_table">
								<xsl:if test="count(CommercialInvoice/Body/GeneralChargesOrDiscounts) = 0">
									<xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
								</xsl:if>
								<tbody id="charge_table">
									
									<!-- Columns Header -->
									<tr>
										<xsl:attribute name="id">charge_table_header_1</xsl:attribute>
										<xsl:if test="count(CommercialInvoice/Body/GeneralChargesOrDiscounts) = 0">
											<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
										</xsl:if>
										<th class="FORMH2" rowspan="2" align="center" width="40%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_TYPE')"/></th>
										<!--
										<th class="FORMH2" rowspan="2" align="center" width="20%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_DESCRIPTION')"/></th>
										-->
										<th class="FORMH2" rowspan="2" colspan="2" align="center" width="20%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_AMOUNT')"/></th>
										<th class="FORMH2" colspan="3" align="center" width="30%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_EQUIVALENTAMOUNT')"/></th>
										<th class="FORMH2" rowspan="2" width="10%"></th>
									</tr>
									<tr>
										<xsl:attribute name="id">charge_table_header_2</xsl:attribute>
										<xsl:if test="count(CommercialInvoice/Body/GeneralChargesOrDiscounts) = 0">
											<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
										</xsl:if>
										<th class="FORMH2" align="center" width="80"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_RATE')"/></th>
										<th class="FORMH2" colspan="2" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_VALUE')"/></th>
									</tr>
									
									<!-- Details -->
									<xsl:for-each select="CommercialInvoice/Body/GeneralChargesOrDiscounts">
										
										<xsl:call-template name="CHARGE_DETAILS">
	
											<xsl:with-param name="structure_name">charge</xsl:with-param>
											<xsl:with-param name="mode">existing</xsl:with-param>
											<xsl:with-param name="charge_type"><xsl:value-of select="LumpSumChargeWithDocumentIdentifier/chargeType"/></xsl:with-param>
											<xsl:with-param name="charge_description"><xsl:value-of select="LumpSumChargeWithDocumentIdentifier/DocumentIdentifier/documentNumber"/></xsl:with-param>
											<xsl:with-param name="charge_currency"><xsl:value-of select="LumpSumChargeWithDocumentIdentifier/ChargeAmount/currencyCode"/></xsl:with-param>
											<xsl:with-param name="charge_amount"><xsl:value-of select="converttools:getLocaleAmountRepresentation(LumpSumChargeWithDocumentIdentifier/ChargeAmount/value,LumpSumChargeWithDocumentIdentifier/ChargeAmount/currencyCode,$language)"/></xsl:with-param>
											<xsl:with-param name="charge_rate"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(LumpSumChargeWithDocumentIdentifier/gtp:EquivalentAmount/gtp:rate,$language)"/></xsl:with-param>
											<xsl:with-param name="charge_reporting_currency"><xsl:value-of select="LumpSumChargeWithDocumentIdentifier/gtp:EquivalentAmount/gtp:currencyCode"/></xsl:with-param>
											<xsl:with-param name="charge_reporting_amount"><xsl:value-of select="converttools:getLocaleAmountRepresentation(LumpSumChargeWithDocumentIdentifier/gtp:EquivalentAmount/gtp:value,LumpSumChargeWithDocumentIdentifier/gtp:EquivalentAmount/gtp:currencyCode,$language)"/></xsl:with-param>
											
										</xsl:call-template>
										
									</xsl:for-each>
								</tbody>
							</table>
							<br/>
							<a href="javascript:void(0)">
								<xsl:attribute name="onClick">fncAddElement('fakeform1', 'charge', 'fncDefaultChargeDetails');</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_ADD_CHARGE')"/>
							</a>
						</td>
					</tr>
				</table>
				<!--****************************-->
				<!-- End of Charges or Discount -->
				<!--****************************-->
		
				<p><br/></p>
				
				<!--Amount Details-->
		
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="3">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TOTALS_DETAILS')"/></b>
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
				
				<table width="570" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="150">
							<font class="FORMMANDATORY">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_AMOUNT')"/>
							</font>
						</td>
						<td>
							<input type="text" size="3" name="total_currency" onfocus="this.blur();">
								<xsl:attribute name="value"><xsl:value-of select="CommercialInvoice/Body/Totals/TotalAmount/MultiCurrency/currencyCode"/></xsl:attribute>
							</input>
							<input type="text" size="20" maxlength="15" name="total_amount" onblur="fncRestoreInputStyle('fakeform1','total_amount');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms	['fakeform1'].total_currency.value));">
								<xsl:attribute name="value">
									<xsl:if test="CommercialInvoice/Body/Totals/TotalAmount/MultiCurrency/value[.!='']">
										<xsl:variable name="amount"><xsl:value-of select="CommercialInvoice/Body/Totals/TotalAmount/MultiCurrency/value"/></xsl:variable>
										<xsl:variable name="currency"><xsl:value-of select="CommercialInvoice/Body/Totals/TotalAmount/MultiCurrency/currencyCode"/></xsl:variable>
										<xsl:value-of select="converttools:getLocaleAmountRepresentation($amount,$currency,$language)"/>
									</xsl:if>
								</xsl:attribute>
							</input>
							&nbsp;<a name="anchor_search_reporting_currency" href="javascript:void(0)">
								<xsl:attribute name="onclick">fncSearchPopup('currency', 'fakeform1',"['total_currency']");return false;</xsl:attribute>
								<img border="0" src="/content/images/pic_search.gif" name="img_search_reporting_currency">
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
								</img>
							</a>
						</td>
					</tr>
				</table>
				
				<p><br/></p>


				<!--Payment Terms-->
		
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="3">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PAYMENT_TERMS_DETAILS')"/></b>
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
		
				<table border="0" cellpadding="0" cellspacing="0" width="570">
				<tr>
					<td width="40">&nbsp;</td>
					<td>
						<textarea wrap="hard" name="payment_terms" cols="65" rows="8">
							<xsl:attribute name="onblur">fncFormatTextarea(this,100,65);fncRestoreInputStyle('fakeform1','payment_terms');</xsl:attribute>
							<xsl:apply-templates select="CommercialInvoice/Body/PaymentTerms/PaymentTermsDetail/UserDefinedPaymentTerms/line"/>
						</textarea>
					</td>
					<td valign="top">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncSearchPopup('phrase','fakeform1',"['payment_terms']");return false;</xsl:attribute>
							<xsl:attribute name="name">anchor_search_free_format_text</xsl:attribute>
							<img border="0" src="/content/images/pic_list.gif">
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
								<img border="0" src="/content/images/pic_up.gif">
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
							<xsl:apply-templates select="CommercialInvoice/Body/AdditionalInformation/line"/>
						</textarea>
					</td>
					<td valign="top">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncSearchPopup('phrase','fakeform1',"['additionnal_information']");return false;</xsl:attribute>
							<xsl:attribute name="name">anchor_search_free_format_text</xsl:attribute>
							<img border="0" src="/content/images/pic_list.gif">
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_PHRASES')"/></xsl:attribute>
								<xsl:attribute name="name">img_search_free_format_text</xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
				</table>
		
				<p><br/></p>
		
			
	
			</form>
			
			<!--POST parameters-->
			<form name="realform" method="POST" action="/gtp/screen/DocumentManagementScreen">
			
				<!--POST parameters-->
				<input type="hidden" name="operation"/>
				<input type="hidden" name="referenceid"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
				<input type="hidden" name="tnxid"><xsl:attribute name="value"><xsl:value-of select="tnx_id"/></xsl:attribute></input>
				<input type="hidden" name="option" value="DOCUMENT"/>
				<input type="hidden" name="tnxtype" value="01"/>
				<!--input type="hidden" name="mode" value=""/-->
				<input type="hidden" name="TransactionData"/>
				<input type="hidden" name="documentcode"><xsl:attribute name="value"><xsl:value-of select="code"/></xsl:attribute></input>
				<input type="hidden" name="documentformat"><xsl:attribute name="value"><xsl:value-of select="format"/></xsl:attribute></input>
				<input type="hidden" name="documentscreen"><xsl:attribute name="value">INVOICE</xsl:attribute></input>
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
