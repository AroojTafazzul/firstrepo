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
   Copyright (c) 2000-2005 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:import href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:import href="../trade_common_dm_details.xsl"/>
	<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="formSaveImage"><xsl:value-of select="$images_path"/>pic_form_save.gif</xsl:param>
	<xsl:param name="formCancelImage"><xsl:value-of select="$images_path"/>pic_form_cancel.gif</xsl:param>
	<xsl:param name="formHelpImage"><xsl:value-of select="$images_path"/>pic_form_help.gif</xsl:param>
	<xsl:param name="upImage"><xsl:value-of select="$images_path"/>pic_up.gif</xsl:param>	
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
							<img border="0">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formSaveImage)"/></xsl:attribute>
							</img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
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
		
			<!-- Product details template -->
			<div style="position:absolute;visibility:hidden;">
				<table>
					<tbody>
						<xsl:attribute name="id">product_template</xsl:attribute>
						<xsl:call-template name="PRODUCT_SUMMARY">
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
						<td class="FORMH1" colspan="1">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_CERTIFICATE_ORIGIN')"/></b>&nbsp;-&nbsp;
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
							<font class="REPORTDATA"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_CERTIFICATE_ORIGIN')"/></font>
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
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COUNTRY_OF_ORIGIN')"/></td>
						<td>
							<input type="text" size="15" maxlength="35" name="country_of_origin" onblur="fncRestoreInputStyle('fakeform1','country_of_origin');">
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/GeneralInformation/CountryOfOrigin/countryName"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COUNTRY_OF_DESTINATION')"/></td>
						<td>
							<input type="text" size="15" maxlength="35" name="country_of_destination" onblur="fncRestoreInputStyle('fakeform1','country_of_destination');">
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/GeneralInformation/CountryOfDestination/countryName"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PURCHASE_ORDER')"/></td>
						<td>
							<input type="text" size="15" maxlength="35" name="purchase_order_identifier" onblur="fncRestoreInputStyle('fakeform1','purchase_order_identifier');">
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/GeneralInformation/gtp:PurchaseOrderIdentifier/gtp:documentNumber"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_ISSUING_BANK_REFERENCE')"/></td>
						<td>
							<input type="text" size="15" maxlength="35" name="issuing_bank_reference" onblur="fncRestoreInputStyle('fakeform1','issuing_bank_reference');">
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/GeneralInformation/gtp:DocumentaryCreditIdentifier/gtp:documentNumber"/></xsl:attribute>
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
				
				<!-- Issuing Party Details-->
				
				<table border="0" cellspacing="0" width="570">
					<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ISSUING_PARTY_DETAILS')"/></b>
						</td>
						<td class="FORMH2" align="right">
							<a name="anchor_search_issuing_party" href="javascript:void(0)">
								<xsl:attribute name="onclick">fncSearchPopup('beneficiary', 'fakeform1',"['issuing_party_name', 'issuing_party_address_line_1', 'issuing_party_address_line_2', 'issuing_party_dom']");return false;	</xsl:attribute>
							</a>
						</td>
					</tr>
				</table>
				<table border="0" cellspacing="0" width="570">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
						<td>
							<input type="text" size="35" maxlength="35" name="issuing_party_name" onblur="fncRestoreInputStyle('fakeform1','issuing_party_name');">
								<xsl:attribute name="value">
									<xsl:choose>
										<xsl:when test="CertificateOfOrigin/Body/Parties/IssuingParty/organizationName != ''"><xsl:value-of select="CertificateOfOrigin/Body/Parties/IssuingParty/organizationName"/></xsl:when>
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
							<input type="text" size="35" maxlength="35" name="issuing_party_address_line_1" onblur="fncRestoreInputStyle('fakeform1','issuing_party_address_line_1');">
								<xsl:attribute name="value">
									<xsl:choose>
										<xsl:when test="CertificateOfOrigin/Body/Parties/IssuingParty/AddressInformation/FullAddress/line[position()='1'] != ''"><xsl:value-of select="CertificateOfOrigin/Body/Parties/IssuingParty/AddressInformation/FullAddress/line[position()='1']"/></xsl:when>
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
							<input type="text" size="35" maxlength="35" name="issuing_party_address_line_2" onblur="fncRestoreInputStyle('fakeform1','issuing_party_address_line_2');">
								<xsl:attribute name="value">
									<xsl:choose>
										<xsl:when test="CertificateOfOrigin/Body/Parties/IssuingParty/AddressInformation/FullAddress/line[position()='2'] != ''"><xsl:value-of select="CertificateOfOrigin/Body/Parties/IssuingParty/AddressInformation/FullAddress/line[position()='2']"/></xsl:when>
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
							<input type="text" size="35" maxlength="35" name="issuing_party_dom" onblur="fncRestoreInputStyle('fakeform1','issuing_party_dom');">
								<xsl:attribute name="value">
									<xsl:choose>
										<xsl:when test="CertificateOfOrigin/Body/Parties/IssuingParty/AddressInformation/FullAddress/line[position()='3'] != ''"><xsl:value-of select="CertificateOfOrigin/Body/Parties/IssuingParty/AddressInformation/FullAddress/line[position()='3']"/></xsl:when>
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
							<input type="text" size="35" maxlength="34" name="issuing_party_reference" onblur="fncRestoreInputStyle('fakeform1','issuing_party_reference');">
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/Parties/IssuingParty/OrganizationIdentification/organizationReference"/></xsl:attribute>
							</input>
						</td>
					</tr>
						
				</table>
				
				<p><br/></p>
	
				<!--Shipper Details-->
				
				<table border="0" cellspacing="0" width="570">
					<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SHIPPER_DETAILS')"/></b>
						</td>
						<td class="FORMH2" align="right">
							<a name="anchor_search_shipper" href="javascript:void(0)">
								<xsl:attribute name="onclick">fncSearchPopup('beneficiary', 'fakeform1',"['shipper_name', 'shipper_address_line_1', 'shipper_address_line_2', 'shipper_dom']");return false;</xsl:attribute>
								<img border="0"  name="img_search_beneficiary">
									<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_SHIPPER')"/></xsl:attribute>
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
							<input type="text" size="35" maxlength="35" name="shipper_name" onblur="fncRestoreInputStyle('fakeform1','shipper_name');">
								<xsl:attribute name="value">
									<xsl:choose>
										<xsl:when test="CertificateOfOrigin/Body/Parties/Shipper/organizationName"><xsl:value-of select="CertificateOfOrigin/Body/Parties/Shipper/organizationName"/></xsl:when>
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
							<input type="text" size="35" maxlength="35" name="shipper_address_line_1" onblur="fncRestoreInputStyle('fakeform1','shipper_address_line_1');">
								<xsl:attribute name="value">
									<xsl:choose>
										<xsl:when test="CertificateOfOrigin/Body/Parties/Shipper/AddressInformation/FullAddress/line[position()='1'] != ''"><xsl:value-of select="CertificateOfOrigin/Body/Parties/Shipper/AddressInformation/FullAddress/line[position()='1']"/></xsl:when>
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
							<input type="text" size="35" maxlength="35" name="shipper_address_line_2" onblur="fncRestoreInputStyle('fakeform1','shipper_address_line_2');">
								<xsl:attribute name="value">
									<xsl:choose>
										<xsl:when test="CertificateOfOrigin/Body/Parties/Shipper/AddressInformation/FullAddress/line[position()='2'] != ''"><xsl:value-of select="CertificateOfOrigin/Body/Parties/Shipper/AddressInformation/FullAddress/line[position()='2']"/></xsl:when>
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
							<input type="text" size="35" maxlength="35" name="shipper_dom" onblur="fncRestoreInputStyle('fakeform1','shipper_dom');">
								<xsl:attribute name="value">
									<xsl:choose>
										<xsl:when test="CertificateOfOrigin/Body/Parties/Shipper/AddressInformation/FullAddress/line[position()='3'] != ''"><xsl:value-of select="CertificateOfOrigin/Body/Parties/Shipper/AddressInformation/FullAddress/line[position()='3']"/></xsl:when>
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
							<input type="text" size="35" maxlength="34" name="shipper_reference" onblur="fncRestoreInputStyle('fakeform1','shipper_reference');">
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/Parties/Shipper/OrganizationIdentification/organizationReference"/></xsl:attribute>
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
								<img border="0"  name="img_search_beneficiary">
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
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/Parties/Consignee/organizationName"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
						<td>
							<input type="text" size="35" maxlength="35" name="consignee_address_line_1" onblur="fncRestoreInputStyle('fakeform1','consignee_address_line_1');">
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='1']"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>
							<input type="text" size="35" maxlength="35" name="consignee_address_line_2" onblur="fncRestoreInputStyle('fakeform1','consignee_address_line_2');">
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='2']"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>
							<input type="text" size="35" maxlength="35" name="consignee_dom" onblur="fncRestoreInputStyle('fakeform1','consignee_dom');">
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='3']"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
						<td>
							<input type="text" size="35" maxlength="34" name="consignee_reference" onblur="fncRestoreInputStyle('fakeform1','consignee_reference');">
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/Parties/Consignee/OrganizationIdentification/organizationReference"/></xsl:attribute>
							</input>
						</td>
					</tr>
						
				</table>
				
				<p>
					<br/>
				</p>
				
				<!--Buyer Details: son't exist in certificate of origin -->
				
				
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
				
				<br/>
		
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TRANSPORT_BY')"/></td>
						<td>
								<select name="transport_type" onchange="fncRestoreInputStyle('fakeform1','transport_type');">
									<option value="">
									</option>
									<option value="MARITIME">
										<xsl:if test="CertificateOfOrigin/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification">
											<xsl:attribute name="selected"/>
										</xsl:if>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_01_SEA')"/>
									</option>
									<option value="RAIL">
										<xsl:if test="CertificateOfOrigin/Body/RoutingSummary/MeansOfTransport/RailTransportIdentification">
											<xsl:attribute name="selected"/>
										</xsl:if>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_03_RAIL')"/>
									</option>
									<option value="ROAD">
										<xsl:if test="CertificateOfOrigin/Body/RoutingSummary/MeansOfTransport/RoadTransportIdentification">
											<xsl:attribute name="selected"/>
										</xsl:if>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_04_TRUCK')"/>
									</option>
									<option value="AIR">
										<xsl:if test="CertificateOfOrigin/Body/RoutingSummary/MeansOfTransport/FlightDetails">
											<xsl:attribute name="selected"/>
										</xsl:if>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_02_AIR')"/>
									</option>
									<option value="INLANDWATER">
										<xsl:if test="CertificateOfOrigin/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification[. = 'INLANDWATER']">
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
									<xsl:if test="CertificateOfOrigin/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/VoyageDetail/departureDate[.!='']">
										<xsl:variable name="date"><xsl:value-of select="CertificateOfOrigin/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/VoyageDetail/departureDate"/></xsl:variable>
										<xsl:value-of select="converttools:getLocaleTimestampRepresentation($date,$language)"/>
									</xsl:if>
									<xsl:if test="CertificateOfOrigin/Body/RoutingSummary/MeansOfTransport/FlightDetails/departureDate[.!='']">
										<xsl:variable name="date"><xsl:value-of select="CertificateOfOrigin/Body/RoutingSummary/MeansOfTransport/FlightDetails/departureDate"/></xsl:variable>
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
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/RoutingSummary/PlaceOfLoading/locationName"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DISCHARGE_PLACE')"/></td>
						<td>
							<input type="text" size="35" maxlength="35" name="place_of_discharge" onblur="fncRestoreInputStyle('fakeform1','place_of_discharge');">
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/RoutingSummary/PlaceOfDischarge/locationName"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DELIVERY_PLACE')"/></td>
						<td>
							<input type="text" size="35" maxlength="35" name="place_of_delivery" onblur="fncRestoreInputStyle('fakeform1','place_of_delivery');">
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/RoutingSummary/PlaceOfDelivery/locationName"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_VESSEL')"/></td>
						<td>
							<input type="text" size="35" maxlength="35" name="vessel_name" onblur="fncRestoreInputStyle('fakeform1','vessel_name');">
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/Vessel/vesselName"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TRANSPORT_REFERENCE')"/></td>
						<td>
							<input type="text" size="35" maxlength="35" name="transport_reference" onblur="fncRestoreInputStyle('fakeform1','transport_reference');">
								<xsl:attribute name="value">
									<xsl:if test="CertificateOfOrigin/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification">
										<xsl:value-of select="CertificateOfOrigin/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/VoyageDetail/voyageNumber"/>
									</xsl:if>
									<xsl:if test="CertificateOfOrigin/Body/RoutingSummary/MeansOfTransport/FlightDetails">
										<xsl:value-of select="CertificateOfOrigin/Body/RoutingSummary/MeansOfTransport/FlightDetails/flightNumber"/>
									</xsl:if>
									<xsl:if test="CertificateOfOrigin/Body/RoutingSummary/MeansOfTransport/RoadTransportIdentification">
										<xsl:value-of select="CertificateOfOrigin/Body/RoutingSummary/MeansOfTransport/RoadTransportIdentification/licencePlateIdentification"/>
									</xsl:if>
									<xsl:if test="CertificateOfOrigin/Body/RoutingSummary/MeansOfTransport/RailTransportIdentification">
										<xsl:value-of select="CertificateOfOrigin/Body/RoutingSummary/MeansOfTransport/RailTransportIdentification/locomotiveNumber"/>
									</xsl:if>
								</xsl:attribute>
							</input>
						</td>
					</tr>	
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_RECEIPT_PLACE')"/></td>
						<td>
							<input type="text" size="35" maxlength="35" name="place_of_receipt" onblur="fncRestoreInputStyle('fakeform1','place_of_receipt');">
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/RoutingSummary/PlaceOfReceipt/locationName"/></xsl:attribute>
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
								<xsl:if test="count(CertificateOfOrigin/Body/ConsignmentDetail/Product) != 0">
									<xsl:attribute name="style">display:none</xsl:attribute>
								</xsl:if>
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_NO_PRODUCT')"/></b>
							</div>
									
							<table border="0" width="570" cellpadding="0" cellspacing="1" id="product_master_table">
								<xsl:if test="count(CertificateOfOrigin/Body/ConsignmentDetail/Product) = 0">
									<xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
								</xsl:if>
								<tbody id="product_table">
	
									<!-- Columns Header -->
									<tr>
										<xsl:attribute name="id">product_table_header_1</xsl:attribute>
										<xsl:if test="count(CertificateOfOrigin/Body/ConsignmentDetail/Product) = 0">
											<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
										</xsl:if>
										<th class="FORMH2" rowspan="2" align="center" width="20%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_REFERENCE')"/></th>
										<th class="FORMH2" rowspan="2" align="center" width="30%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_PRODUCT')"/></th>
										<th class="FORMH2" colspan="2" align="center" width="40%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_QUANTITY')"/></th>
										<th class="FORMH2" rowspan="2" width="10%">&nbsp;</th>
									</tr>
									<tr>
										<xsl:attribute name="id">product_table_header_2</xsl:attribute>
										<xsl:if test="count(CertificateOfOrigin/Body/ConsignmentDetail/Product) = 0">
											<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
										</xsl:if>
										<th class="FORMH2" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_VALUE')"/></th>
										<th class="FORMH2" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_UNIT')"/></th>
									</tr>
	
									<!-- Details -->
									<xsl:for-each select="CertificateOfOrigin/Body/ConsignmentDetail/Product">
										
										<xsl:call-template name="PRODUCT_SUMMARY">
	
											<xsl:with-param name="structure_name">product</xsl:with-param>
											<xsl:with-param name="mode">existing</xsl:with-param>
											<xsl:with-param name="product_identifier"><xsl:value-of select="ProductIdentifiers/productIdentification"/></xsl:with-param>
											<xsl:with-param name="product_description"><xsl:value-of select="productName"/></xsl:with-param>
											<xsl:with-param name="product_quantity"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(ProductQuantity/value,$language)"/></xsl:with-param>
											<xsl:with-param name="product_unit"><xsl:value-of select="ProductQuantity/unitOfMeasureCode"/></xsl:with-param>

										</xsl:call-template>
										
									</xsl:for-each>
								</tbody>
							</table>
							<br/>
							<a href="javascript:void(0)">
								<xsl:attribute name="onClick">fncAddElement('fakeform1', 'product', '');</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_ADD_PRODUCT')"/>
							</a>
						</td>
					</tr>
				</table>
				<p><br/></p>
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
								<xsl:if test="count(CertificateOfOrigin/Body/gtp:PackingDetail/gtp:Package) != 0">
									<xsl:attribute name="style">display:none</xsl:attribute>
								</xsl:if>
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_NO_PACKAGE')"/></b>
							</div>
							
							<table border="0" width="570" cellpadding="0" cellspacing="1" id="packing_master_table">
								<xsl:if test="count(CertificateOfOrigin/Body/gtp:PackingDetail/gtp:Package) = 0">
									<xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
								</xsl:if>
								<tbody id="packing_table">
									
									<!-- Columns Header -->
									<tr>
										<xsl:attribute name="id">packing_table_header_1</xsl:attribute>
										<xsl:if test="count(CertificateOfOrigin/Body/gtp:PackingDetail/gtp:Package) = 0">
											<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
										</xsl:if>
										<th class="FORMH2" align="center" width="10%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_QUANTITY')"/></th>
										<th class="FORMH2" align="center" width="10%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_TYPE')"/></th>
										<th class="FORMH2" align="center" width="40%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_DESCRIPTION')"/></th>
										<th class="FORMH2" align="center" width="30%"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_MARKS')"/></th>
										<th class="FORMH2" width="10%"></th>
									</tr>
									
									<!-- Details -->
									<xsl:for-each select="CertificateOfOrigin/Body/gtp:PackingDetail/gtp:Package">
										
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
								<xsl:attribute name="onClick">fncAddElement('fakeform1', 'packing', '');</xsl:attribute>
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
				
				<table width="570" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_NETWEIGHT')"/></td>
						<td>
							<input type="text" size="10" maxlength="10" name="total_net_weight" onblur="fncRestoreInputStyle('fakeform1','total_net_weight'); fncFormatDecimal(this);">
								<xsl:attribute name="value">
									<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(CertificateOfOrigin/Body/gtp:PackingDetail/gtp:TotalNetWeight/gtp:value,$language)"/>
								</xsl:attribute>
							</input>
							<input type="text" size="3" maxlength="3" name="total_net_weight_unit" onblur="fncRestoreInputStyle('fakeform1','total_net_weight_unit');">
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/gtp:PackingDetail/gtp:TotalNetWeight/gtp:weightUnitCode"/></xsl:attribute>
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
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_GROSSWEIGHT')"/></td>
						<td>
							<input type="text" size="10" maxlength="10" name="total_gross_weight" onblur="fncRestoreInputStyle('fakeform1','total_gross_weight'); fncFormatDecimal(this);">
								<xsl:attribute name="value">
									<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(CertificateOfOrigin/Body/gtp:PackingDetail/gtp:TotalGrossWeight/gtp:value,$language)"/>
								</xsl:attribute>
							</input>
							<input type="text" size="3" maxlength="3" name="total_gross_weight_unit" onblur="fncRestoreInputStyle('fakeform1','total_gross_weight_unit');">
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/gtp:PackingDetail/gtp:TotalGrossWeight/gtp:weightUnitCode"/></xsl:attribute>
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
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_NETVOLUMNE')"/></td>
						<td>
							<input type="text" size="10" maxlength="10" name="total_net_volume" onblur="fncRestoreInputStyle('fakeform1','total_net_volume'); fncFormatDecimal(this);">
								<xsl:attribute name="value">
									<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(CertificateOfOrigin/Body/gtp:PackingDetail/gtp:TotalNetVolume/gtp:value,$language)"/>
								</xsl:attribute>
							</input>
							<input type="text" size="3" maxlength="3" name="total_net_volume_unit" onblur="fncRestoreInputStyle('fakeform1','total_net_volume_unit');">
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/gtp:PackingDetail/gtp:TotalNetVolume/gtp:volumeUnitCode"/></xsl:attribute>
							</input>
							&nbsp;
							<a name="anchor_search_volume_unit" href="javascript:void(0)">
								<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', 'total_net_volume_unit', 'C003');return false;</xsl:attribute>
								<img border="0"  name="img_search_volume_unit">
									<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
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
									<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(CertificateOfOrigin/Body/gtp:PackingDetail/gtp:TotalGrossVolume/gtp:value,$language)"/>
								</xsl:attribute>
							</input>
							<input type="text" size="3" maxlength="3" name="total_gross_volume_unit" onblur="fncRestoreInputStyle('fakeform1','total_gross_volume_unit');">
								<xsl:attribute name="value"><xsl:value-of select="CertificateOfOrigin/Body/gtp:PackingDetail/gtp:TotalGrossVolume/gtp:volumeUnitCode"/></xsl:attribute>
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
	
				<!--Additional Information-->
		
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="3">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ADDITIONAL_DETAILS')"/></b>
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
					<td  width="40">&nbsp;</td>
					<td>
						<textarea wrap="hard" name="additionnal_information" cols="65" rows="8">
							<xsl:attribute name="onblur">fncFormatTextarea(this,100,65);fncRestoreInputStyle('fakeform1','additionnal_information');</xsl:attribute>
							<xsl:apply-templates select="CertificateOfOrigin/Body/AdditionalInformation/line"/>
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
		
				<p><br/></p>
		
			
			
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
							<img border="0" >
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formSaveImage)"/></xsl:attribute>
							</img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
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
		</table>
		
		</td>
		</tr>
		</table>

	</xsl:template>

	
</xsl:stylesheet>
