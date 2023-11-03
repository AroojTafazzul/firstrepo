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
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:import href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:import href="../trade_common_rep_dm_details.xsl"/>
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
		<!--script type="text/javascript" src="/content/OLD/javascript/trade_create_document.js"></script-->
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
				
				<!--The following data are fetched the xml document preparation representation, and both dates and amounts are expressed in standard bolero format.-->
				<!--A conversion is therefore required to have it in user locale -->
		
				<!--References-->
		
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="3">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_PACKING_LIST')"/></b>&nbsp;-&nbsp;
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REFERENCES')"/></b>
						</td>
					</tr>
				</table>
				
				<br/>
				
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
					<xsl:if test="version[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_VERSION')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="version"/></font>
							</td>
						</tr>
					</xsl:if>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TYPE')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_PACKING_LIST')"/></font>
						</td>
					</tr>
					<xsl:if test="format[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_FORMAT')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="format"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="description[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DESCRIPTION')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="description"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="prep_date[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PREPARATION_DATE')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="prep_date"/></font>
							</td>
						</tr>
					</xsl:if>
					<tr>
						<td>&nbsp;</td>
					</tr>	
					<tr>
						<td>&nbsp;</td>
					</tr>	
					<xsl:if test="PackingList/Body/GeneralInformation/CommercialInvoiceIdentifier/documentNumber[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COMMERCIAL_INVOICE')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/GeneralInformation/CommercialInvoiceIdentifier/documentNumber"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="PackingList/Body/GeneralInformation/PurchaseOrderIdentifier/documentNumber[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PURCHASE_ORDER')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/GeneralInformation/PurchaseOrderIdentifier/documentNumber"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="PackingList/Body/GeneralInformation/gtp:DocumentaryCreditIdentifier/gtp:documentNumber[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_ISSUING_BANK_REFERENCE')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/GeneralInformation/gtp:DocumentaryCreditIdentifier/gtp:documentNumber"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="PackingList/Body/GeneralInformation/CountryOfOrigin/countryName[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COUNTRY_OF_ORIGIN')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/GeneralInformation/CountryOfOrigin/countryName"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="PackingList/Body/GeneralInformation/CountryOfDestination/countryName[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COUNTRY_OF_DESTINATION')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/GeneralInformation/CountryOfDestination/countryName"/></font>
							</td>
						</tr>
					</xsl:if>
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
				
				
				<!-- Issuing Party Details = Shipper Details-->
				
				<xsl:if test="PackingList/Body/Parties/IssuingParty/organizationName[.!=''] or PackingList/Body/Parties/IssuingParty/AddressInformation/FullAddress/line[position()='1'][.!=''] or PackingList/Body/Parties/IssuingParty/AddressInformation/FullAddress/line[position()='2'][.!=''] or PackingList/Body/Parties/IssuingParty/AddressInformation/FullAddress/line[position()='3'][.!=''] or PackingList/Body/Parties/IssuingParty/OrganizationIdentification/organizationReference[.!='']">
					<table border="0" cellspacing="0" width="570">
						<tr>
							<td width="15">&nbsp;</td>
							<td class="FORMH2" align="left">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ISSUING_PARTY_DETAILS')"/></b>
							</td>
						</tr>
					</table>
					<table border="0" cellspacing="0" width="570">
						<xsl:if test="PackingList/Body/Parties/IssuingParty/organizationName[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/IssuingParty/organizationName"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="PackingList/Body/Parties/IssuingParty/AddressInformation/FullAddress/line[position()='1'][.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/IssuingParty/AddressInformation/FullAddress/line[position()='1']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="PackingList/Body/Parties/IssuingParty/AddressInformation/FullAddress/line[position()='2'][.!='']">
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/IssuingParty/AddressInformation/FullAddress/line[position()='2']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="PackingList/Body/Parties/IssuingParty/AddressInformation/FullAddress/line[position()='3'][.!='']">
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/IssuingParty/AddressInformation/FullAddress/line[position()='3']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="PackingList/Body/Parties/IssuingParty/OrganizationIdentification/organizationReference[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/IssuingParty/OrganizationIdentification/organizationReference"/></font>
								</td>
							</tr>
						</xsl:if>
					</table>
					
					<br/>
				
				</xsl:if>
				
				<!--Seller Details-->
				
				<xsl:if test="PackingList/Body/Parties/Seller/organizationName[.!=''] or PackingList/Body/Parties/Seller/AddressInformation/FullAddress/line[position()='1'][.!=''] or PackingList/Body/Parties/Seller/AddressInformation/FullAddress/line[position()='2'][.!=''] or PackingList/Body/Parties/Seller/AddressInformation/FullAddress/line[position()='3'][.!=''] or PackingList/Body/Parties/Seller/OrganizationIdentification/organizationReference[.!='']">
					<table border="0" cellspacing="0" width="570">
						<tr>
							<td width="15">&nbsp;</td>
							<td class="FORMH2" align="left">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SELLER_DETAILS')"/></b>
							</td>
						</tr>
					</table>
					<table border="0" cellspacing="0" width="570">
						<xsl:if test="PackingList/Body/Parties/Seller/organizationName[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/Seller/organizationName"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="PackingList/Body/Parties/Seller/AddressInformation/FullAddress/line[position()='1'][.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/Seller/AddressInformation/FullAddress/line[position()='1']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="PackingList/Body/Parties/Seller/AddressInformation/FullAddress/line[position()='2'][.!='']">
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/Seller/AddressInformation/FullAddress/line[position()='2']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="PackingList/Body/Parties/Seller/AddressInformation/FullAddress/line[position()='3'][.!='']">
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/Seller/AddressInformation/FullAddress/line[position()='3']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="PackingList/Body/Parties/Seller/OrganizationIdentification/organizationReference[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/Seller/OrganizationIdentification/organizationReference"/></font>
								</td>
							</tr>
						</xsl:if>
					</table>
					
					<br/>
				</xsl:if>
				
				<!--Consignee Details-->
				
				<xsl:if test="PackingList/Body/Parties/Consignee/organizationName[.!=''] or PackingList/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='1'][.!=''] or PackingList/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='2'][.!=''] or PackingList/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='3'][.!=''] or PackingList/Body/Parties/Consignee/OrganizationIdentification/organizationReference[.!='']">
					<table border="0" cellspacing="0" width="570">
						<tr>
							<td width="15">&nbsp;</td>
							<td class="FORMH2" align="left">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONSIGNEE_DETAILS')"/></b>
							</td>
						</tr>
					</table>
					<table border="0" cellspacing="0" width="570">
						<xsl:if test="PackingList/Body/Parties/Consignee/organizationName[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/Consignee/organizationName"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="PackingList/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='1'][.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='1']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="PackingList/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='2'][.!='']">
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='2']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="PackingList/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='3'][.!='']">
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='3']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="PackingList/Body/Parties/Consignee/OrganizationIdentification/organizationReference[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/Consignee/OrganizationIdentification/organizationReference"/></font>
								</td>
							</tr>
						</xsl:if>
					</table>
					
					<br/>
				</xsl:if>
				
				<!--Buyer Details-->
				
				<xsl:if test="PackingList/Body/Parties/Buyer/organizationName[.!=''] or PackingList/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='1'][.!=''] or PackingList/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='2'][.!=''] or PackingList/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='3'][.!=''] or PackingList/Body/Parties/Buyer/OrganizationIdentification/organizationReference[.!='']">
					<table border="0" cellspacing="0" width="570">
						<tr>
							<td width="15">&nbsp;</td>
							<td class="FORMH2" align="left">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BUYER_DETAILS')"/></b>
							</td>
						</tr>
					</table>
					<table border="0" cellspacing="0" width="570">
						<xsl:if test="PackingList/Body/Parties/Buyer/organizationName[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/Buyer/organizationName"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="PackingList/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='1'][.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='1']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="PackingList/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='2'][.!='']">
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='2']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="PackingList/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='3'][.!='']">
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='3']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="PackingList/Body/Parties/Buyer/OrganizationIdentification/organizationReference[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/Parties/Buyer/OrganizationIdentification/organizationReference"/></font>
								</td>
							</tr>
						</xsl:if>
					</table>
					
					<br/>
				</xsl:if>
				
				<p><br/></p>
				
				<!--Terms and Conditions-->
		
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
				
				<xsl:if test="count(PackingList/Body/TermsAndConditions/clause) = 0">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TERMDETAILS_NO_TERM')"/></b>
				</xsl:if>
				
				<xsl:if test="count(PackingList/Body/TermsAndConditions/clause) != 0">

					<table border="0" width="570" cellpadding="0" cellspacing="1">
						<tr>
							<td width="15">&nbsp;</td>
							<td>
								<table border="0" width="100%" cellpadding="0" cellspacing="1">
									<tr>
										<th class="FORMH2"></th>
										<th class="FORMH2" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TABLE_CLAUSE')"/></th>
										<th class="FORMH2" align="center"></th>
									</tr>
									<xsl:for-each select="PackingList/Body/TermsAndConditions/clause">
										<xsl:call-template name="TERM_DETAILS">
											<xsl:with-param name="position"><xsl:value-of select="position()"></xsl:value-of></xsl:with-param>
											<xsl:with-param name="data"><xsl:value-of select="."/></xsl:with-param>
										</xsl:call-template>
									</xsl:for-each>
								</table>
							</td>
						</tr>
					</table>
				</xsl:if>

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
				
				<br/>
		
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<xsl:if test="PackingList/Body/RoutingSummary/transportService[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TRANSPORT_SERVICE')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/RoutingSummary/transportService"/></font>
							</td>
						</tr>	
					</xsl:if>
					<xsl:if test="PackingList/Body/RoutingSummary/transportType[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TRANSPORT_BY')"/></td>
							<td>
									<font class="REPORTDATA">
										<xsl:choose>
											<xsl:when test="PackingList/Body/RoutingSummary/transportType[. = 'MARITIME']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_01_SEA')"/>
											</xsl:when>
											<xsl:when test="PackingList/Body/RoutingSummary/transportType[. = 'RAIL']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_03_RAIL')"/>
											</xsl:when>
											<xsl:when test="PackingList/Body/RoutingSummary/transportType[. = 'ROAD']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_04_TRUCK')"/>
											</xsl:when>
											<xsl:when test="PackingList/Body/RoutingSummary/transportType[. = 'AIR']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_02_AIR')"/>
											</xsl:when>
											<xsl:when test="PackingList/Body/RoutingSummary/transportType[. = 'MAIL']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_05_POSTAGE')"/>
											</xsl:when>
											<xsl:when test="PackingList/Body/RoutingSummary/transportType[. = 'MULTIMODAL']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_06_MIXED')"/>
											</xsl:when>
											<xsl:when test="PackingList/Body/RoutingSummary/transportType[. = 'INLANDWATER']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_09_INLAND_WATER')"/>
											</xsl:when>
											<xsl:otherwise/>
										</xsl:choose>
									</font>
							</td>
						</tr>
					</xsl:if>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DEPARTURE_DATE')"/></td>
						<td>
							<font class="REPORTDATA">
								<xsl:if test="PackingList/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/VoyageDetail/departureDate[.!='']">
									<xsl:variable name="date"><xsl:value-of select="PackingList/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/VoyageDetail/departureDate"/></xsl:variable>
									<xsl:value-of select="converttools:getLocaleTimestampRepresentation($date,$language)"/>
								</xsl:if>
								<xsl:if test="PackingList/Body/RoutingSummary/MeansOfTransport/FlightDetails/departureDate[.!='']">
									<xsl:variable name="date"><xsl:value-of select="PackingList/Body/RoutingSummary/MeansOfTransport/FlightDetails/departureDate"/></xsl:variable>
									<xsl:value-of select="converttools:getLocaleTimestampRepresentation($date,$language)"/>
								</xsl:if>
							</font>
						</td>
					</tr>	
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_LOADING_PLACE')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/RoutingSummary/PlaceOfLoading/locationName"/></font>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DISCHARGE_PLACE')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/RoutingSummary/PlaceOfDischarge/locationName"/></font>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DELIVERY_PLACE')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/RoutingSummary/PlaceOfDelivery/locationName"/></font>
						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_VESSEL')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="PackingList/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/Vessel/vesselName"/></font>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TRANSPORT_REFERENCE')"/></td>
						<td>
							<font class="REPORTDATA">
								<xsl:if test="PackingList/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification">
									<xsl:value-of select="PackingList/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/VoyageDetail/voyageNumber"/>
								</xsl:if>
								<xsl:if test="PackingList/Body/RoutingSummary/MeansOfTransport/FlightDetails">
									<xsl:value-of select="PackingList/Body/RoutingSummary/MeansOfTransport/FlightDetails/flightNumber"/>
								</xsl:if>
								<xsl:if test="PackingList/Body/RoutingSummary/MeansOfTransport/RoadTransportIdentification">
									<xsl:value-of select="PackingList/Body/RoutingSummary/MeansOfTransport/RoadTransportIdentification/licencePlateIdentification"/>
								</xsl:if>
								<xsl:if test="PackingList/Body/RoutingSummary/MeansOfTransport/RailTransportIdentification">
									<xsl:value-of select="PackingList/Body/RoutingSummary/MeansOfTransport/RailTransportIdentification/locomotiveNumber"/>
								</xsl:if>
							</font>
						</td>
					</tr>	
				</table>
				<br/>
				
					<!-- Doesn't exist in commercial invoice
					<tr>
						<td width="100">&nbsp;</td>
						<td width="200"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_RECEIPT_PLACE')"/></td>
						<td>
							<input type="text" size="34" maxlength="34" name="place_of_receipt" onblur="fncRestoreInputStyle('fakeform1','place_of_receipt');">
								<xsl:attribute name="value"><xsl:value-of select="PackingList/Body/RoutingSummary/PlaceOfReceipt/locationName"/></xsl:attribute>
							</input>
						</td>
					</tr>
					-->
					
		
				
				<!--Product Details-->
		
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
				
				
				<xsl:if test="count(PackingList/Body/Consignment/ConsignmentDetail/Commodity/CommodityDescription) = 0">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_NO_PRODUCT')"/></b>
				</xsl:if>
			
				<xsl:if test="count(PackingList/Body/Consignment/ConsignmentDetail/Commodity/CommodityDescription) != 0">
					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
							<td width="15">&nbsp;</td>
							<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="1">
									<tr>
										<th class="FORMH2" align="center"></th>
										<th class="FORMH2" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_PRODUCT')"/></th>
									</tr>
									<xsl:for-each select="PackingList/Body/Consignment/ConsignmentDetail/Commodity/CommodityDescription">
										<xsl:call-template name="PRODUCT_SIMPLE">
											<xsl:with-param name="position"><xsl:value-of select="position()"></xsl:value-of></xsl:with-param>
											<xsl:with-param name="product_description"><xsl:value-of select="."></xsl:value-of></xsl:with-param>
										</xsl:call-template>
									</xsl:for-each>
								</table>
							</td>
						</tr>
					</table>
				</xsl:if>
				
				<p><br/></p>
		
				<!--Packing Details-->

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
				
				<xsl:if test="count(PackingList/Body/PackingDetail/Package) = 0">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_NO_PACKAGE')"/></b>
				</xsl:if>

				<xsl:if test="count(PackingList/Body/PackingDetail/Package) != 0">
					<xsl:for-each select="PackingList/Body/PackingDetail/Package">
						<xsl:call-template name="PACKAGE_DETAILS">
							<xsl:with-param name="position">1</xsl:with-param>

							<xsl:with-param name="position"><xsl:value-of select="position()"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="package_number"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(PackageCount/numberOfPackages,$language)"/></xsl:with-param>
							<xsl:with-param name="package_type"><xsl:value-of select="PackageCount/typeOfPackage"/></xsl:with-param>
							<xsl:with-param name="package_description"><xsl:value-of select="Content/Product/productName"/></xsl:with-param>
							<xsl:with-param name="package_height"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(PackageDimensions/heightValue,$language)"/></xsl:with-param>
							<xsl:with-param name="package_width"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(PackageDimensions/widthValue,$language)"/></xsl:with-param>
							<xsl:with-param name="package_length"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(PackageDimensions/lengthValue,$language)"/></xsl:with-param>
							<xsl:with-param name="package_dimension_unit"><xsl:value-of select="PackageDimensions/dimensionUnitCode"/></xsl:with-param>
							<xsl:with-param name="package_netweight"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(NetWeight/value,$language)"/></xsl:with-param>
							<xsl:with-param name="package_grossweight"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(GrossWeight/value,$language)"/></xsl:with-param>
							<xsl:with-param name="package_weight_unit"><xsl:value-of select="NetWeight/weightUnitCode"/></xsl:with-param>
							<xsl:with-param name="package_grossvolume"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(GrossVolume/value,$language)"/></xsl:with-param>
							<xsl:with-param name="package_volume_unit"><xsl:value-of select="GrossVolume/volumeUnitCode"/></xsl:with-param>
							<xsl:with-param name="package_marks"><xsl:value-of select="marksAndNumbers"/></xsl:with-param>

						</xsl:call-template>
						<br/>
					</xsl:for-each>
				</xsl:if>
				
				<p><br/></p>
				
				<!-- Summary of total weight and volumes-->
				<table border="0" cellspacing="0" width="570">
					<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_SUMMARY')"/></b>
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<xsl:if test="PackingList/Body/PackingDetail/TotalNetWeight/value[.!=''] or PackingList/Body/PackingDetail/TotalNetWeight/value[.!=''] ">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_NETWEIGHT')"/></td>
							<td><font class="REPORTDATA">
								<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(PackingList/Body/PackingDetail/TotalNetWeight/value,$language)"/>&nbsp;
								<xsl:value-of select="PackingList/Body/PackingDetail/TotalNetWeight/weightUnitCode"/>
							</font></td>
						</tr>
					</xsl:if>
					
					<xsl:if test="PackingList/Body/PackingDetail/TotalGrossWeight/value[.!=''] or PackingList/Body/PackingDetail/TotalGrossWeight/value[.!=''] ">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_GROSSWEIGHT')"/></td>
							<td><font class="REPORTDATA">
								<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(PackingList/Body/PackingDetail/TotalGrossWeight/value,$language)"/>&nbsp;
								<xsl:value-of select="PackingList/Body/PackingDetail/TotalGrossWeight/weightUnitCode"/>
							</font></td>
						</tr>
					</xsl:if>
					
					<xsl:if test="PackingList/Body/PackingDetail/TotalNetVolume/value[.!=''] or PackingList/Body/PackingDetail/TotalNetVolume/value[.!=''] ">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_NETVOLUMNE')"/></td>
							<td><font class="REPORTDATA">
								<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(PackingList/Body/PackingDetail/TotalNetVolume/value,$language)"/>&nbsp;
								<xsl:value-of select="PackingList/Body/PackingDetail/TotalNetVolume/volumeUnitCode"/>
							</font></td>
						</tr>
					</xsl:if>
					
					<xsl:if test="PackingList/Body/PackingDetail/TotalGrossVolume/value[.!=''] or PackingList/Body/PackingDetail/TotalGrossVolume/value[.!=''] ">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_GROSSVOLUME')"/></td>
							<td><font class="REPORTDATA">
								<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(PackingList/Body/PackingDetail/TotalGrossVolume/value,$language)"/>&nbsp;
								<xsl:value-of select="PackingList/Body/PackingDetail/TotalGrossVolume/volumeUnitCode"/>
							</font></td>
						</tr>
					</xsl:if>
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
						<xsl:for-each select="PackingList/Body/AdditionalInformation/line">
							<xsl:value-of select="."/>
						</xsl:for-each>
					</td>
				</tr>
				</table>
		
				<p><br/></p>
		
			</form>
			
			<!--POST parameters-->
			<!--
			<form name="realform" method="POST" action="/gtp/screen/DocumentManagementScreen">
				<input type="hidden" name="operation" value="SAVE"/>
				<input type="hidden" name="referenceid"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
				<input type="hidden" name="option" value="DOCUMENT"/>
				<input type="hidden" name="TransactionData"/>
				<input type="hidden" name="code"><xsl:attribute name="value"><xsl:value-of select="code"/></xsl:attribute></input>
				<input type="hidden" name="format"><xsl:attribute name="value"><xsl:value-of select="format"/></xsl:attribute></input>
				<input type="hidden" name="type"><xsl:attribute name="value"><xsl:value-of select="type"/></xsl:attribute></input>
			</form>
			-->
			
	
			<p><br/></p>
			
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


			
	


</xsl:stylesheet>
