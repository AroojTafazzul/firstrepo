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
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_COMM_INVOICE')"/></b>&nbsp;-&nbsp;
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REFERENCES')"/></b>
						</td>
					</tr>
				</table>
				
				<br/>
				
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
					<tr>
						<td>&nbsp;</td>
					</tr>	
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COMMERCIAL_INVOICE')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Header/cmp:DocumentID/cmp:GeneralID"/></font>
						</td>
					</tr>
					<!-- The reporting currency is amendable by the user. It is initially defaulted from the total currency. -->
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_REPORTING_CURRENCY')"/>
						</td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Totals/TotalAmount/MultiCurrency/currencyCode"/></font>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COUNTRY_OF_ORIGIN')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/RoutingSummary/CountryOfOrigin/countryName"/></font>
						</td>
					</tr>
					<!-- No country of dest in DTD
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COUNTRY_OF_DESTINATION')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/RoutingSummary/CountryOfDestination/countryName"/></font>
						</td>
					</tr>
					-->
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PURCHASE_ORDER')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/GeneralInformation/PurchaseOrderIdentifier/documentNumber"/></font>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_ISSUING_BANK_REFERENCE')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/GeneralInformation/DocumentaryCreditIdentifier/documentNumber"/></font>
						</td>
					</tr>
					<!--tr>
						<td width="100">&nbsp;</td>
						<td width="200"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_ADVISING_BANK_REFERENCE')"/></td>
						<td>
							<input type="text" size="15" maxlength="20" name="advising_bank_reference" onblur="fncRestoreInputStyle('fakeform1','advising_bank_reference');">
								<xsl:attribute name="value"><xsl:value-of select="exportDocumentaryCreditReference"/></xsl:attribute>
							</input>
						</td>
					</tr-->
					<!--tr>
						<td width="100">&nbsp;</td>
						<td width="200"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_EXPORTER_REFERENCE')"/></td>
						<td>
							<input type="text" size="15" maxlength="20" name="exporter_reference" onblur="fncRestoreInputStyle('fakeform1','exporter_reference');">
								<xsl:attribute name="value"><xsl:value-of select="exporterReference"/></xsl:attribute>
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
				
				<!--Shipper Details-->

				<xsl:if test="CommercialInvoice/Body/Parties/Shipper/organizationName[.!=''] or CommercialInvoice/Body/Parties/Shipper/AddressInformation/FullAddress/line[position()='1'][.!=''] or CommercialInvoice/Body/Parties/Shipper/AddressInformation/FullAddress/line[position()='2'][.!=''] or CommercialInvoice/Body/Parties/Shipper/AddressInformation/FullAddress/line[position()='3'][.!=''] or CommercialInvoice/Body/Parties/Shipper/OrganizationIdentification/organizationReference[.!='']">
					<table border="0" cellspacing="0" width="570">
						<tr>
							<td width="15">&nbsp;</td>
							<td class="FORMH2" align="left">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SHIPPER_DETAILS')"/></b>
							</td>
						</tr>
					</table>
					<table border="0" cellspacing="0" width="570">
						<xsl:if test="CommercialInvoice/Body/Parties/Shipper/organizationName[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/Shipper/organizationName"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="CommercialInvoice/Body/Parties/Shipper/AddressInformation/FullAddress/line[position()='1'][.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/Shipper/AddressInformation/FullAddress/line[position()='1']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="CommercialInvoice/Body/Parties/Shipper/AddressInformation/FullAddress/line[position()='2'][.!='']">
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/Shipper/AddressInformation/FullAddress/line[position()='2']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="CommercialInvoice/Body/Parties/Shipper/AddressInformation/FullAddress/line[position()='3'][.!='']">
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/Shipper/AddressInformation/FullAddress/line[position()='3']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="CommercialInvoice/Body/Parties/Shipper/OrganizationIdentification/organizationReference[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/Shipper/OrganizationIdentification/organizationReference"/></font>
								</td>
							</tr>
						</xsl:if>
					</table>
					
					<p><br/></p>
				</xsl:if>
				
				<!--Consignee Details-->
				
				<xsl:if test="CommercialInvoice/Body/Parties/Consignee/organizationName[.!=''] or CommercialInvoice/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='1'][.!=''] or CommercialInvoice/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='2'][.!=''] or CommercialInvoice/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='3'][.!=''] or CommercialInvoice/Body/Parties/Consignee/OrganizationIdentification/organizationReference[.!='']">
					<table border="0" cellspacing="0" width="570">
						<tr>
							<td width="15">&nbsp;</td>
							<td class="FORMH2" align="left">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONSIGNEE_DETAILS')"/></b>
							</td>
						</tr>
					</table>
					<table border="0" cellspacing="0" width="570">
						<xsl:if test="CommercialInvoice/Body/Parties/Consignee/organizationName[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/Consignee/organizationName"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="CommercialInvoice/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='1'][.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='1']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="CommercialInvoice/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='2'][.!='']">
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='2']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="CommercialInvoice/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='3'][.!='']">
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/Consignee/AddressInformation/FullAddress/line[position()='3']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="CommercialInvoice/Body/Parties/Consignee/OrganizationIdentification/organizationReference[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/Consignee/OrganizationIdentification/organizationReference"/></font>
								</td>
							</tr>
						</xsl:if>
					</table>
					
					<p><br/></p>
				</xsl:if>
					
				
				<!--Billto Details-->
				
				<xsl:if test="CommercialInvoice/Body/Parties/BillTo/organizationName[.!=''] or CommercialInvoice/Body/Parties/BillTo/AddressInformation/FullAddress/line[position()='1'][.!=''] or CommercialInvoice/Body/Parties/BillTo/AddressInformation/FullAddress/line[position()='2'][.!=''] or CommercialInvoice/Body/Parties/BillTo/AddressInformation/FullAddress/line[position()='3'][.!=''] or CommercialInvoice/Body/Parties/BillTo/OrganizationIdentification/organizationReference[.!='']">
					<table border="0" cellspacing="0" width="570">
						<tr>
							<td width="15">&nbsp;</td>
							<td class="FORMH2" align="left">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BILL_TO_DETAILS')"/></b>
							</td>
						</tr>
					</table>
					<table border="0" cellspacing="0" width="570">
						<xsl:if test="CommercialInvoice/Body/Parties/BillTo/organizationName[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/BillTo/organizationName"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="CommercialInvoice/Body/Parties/BillTo/AddressInformation/FullAddress/line[position()='1'][.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/BillTo/AddressInformation/FullAddress/line[position()='1']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="CommercialInvoice/Body/Parties/BillTo/AddressInformation/FullAddress/line[position()='2'][.!='']">
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/BillTo/AddressInformation/FullAddress/line[position()='2']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="CommercialInvoice/Body/Parties/BillTo/AddressInformation/FullAddress/line[position()='3'][.!='']">
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/BillTo/AddressInformation/FullAddress/line[position()='3']"/></font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="CommercialInvoice/Body/Parties/BillTo/OrganizationIdentification/organizationReference[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
								<td>
									<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/BillTo/OrganizationIdentification/organizationReference"/></font>
								</td>
							</tr>
						</xsl:if>
					</table>
				
					<p><br/></p>
				</xsl:if>
				
				<!--Buyer Details-->
				
				<xsl:if test="CommercialInvoice/Body/Parties/Buyer/organizationName[.!=''] or CommercialInvoice/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='1'][.!=''] or CommercialInvoice/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='2'][.!=''] or CommercialInvoice/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='3'][.!=''] or CommercialInvoice/Body/Parties/Buyer/OrganizationIdentification/organizationReference[.!='']">
					<table border="0" cellspacing="0" width="570">
						<tr>
							<td width="15">&nbsp;</td>
							<td class="FORMH2" align="left">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BUYER_DETAILS')"/></b>
							</td>
						</tr>
					</table>
						<table border="0" cellspacing="0" width="570">
							<xsl:if test="CommercialInvoice/Body/Parties/Buyer/organizationName[.!='']">
								<tr>
									<td width="40">&nbsp;</td>
									<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
									<td>
										<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/Buyer/organizationName"/></font>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="CommercialInvoice/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='1'][.!='']">
								<tr>
									<td width="40">&nbsp;</td>
									<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
									<td>
										<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='1']"/></font>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="CommercialInvoice/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='2'][.!='']">
								<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>
										<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='2']"/></font>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="CommercialInvoice/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='3'][.!='']">
								<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>
										<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/Buyer/AddressInformation/FullAddress/line[position()='3']"/></font>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="CommercialInvoice/Body/Parties/Buyer/OrganizationIdentification/organizationReference[.!='']">
								<tr>
									<td width="40">&nbsp;</td>
									<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
									<td>
										<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/Parties/Buyer/OrganizationIdentification/organizationReference"/></font>
									</td>
								</tr>
							</xsl:if>
						</table>				
					
					<p><br/></p>
				</xsl:if>
				
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
				
				<xsl:if test="count(CommercialInvoice/Body/TermsAndConditions/clause) = 0">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TERMDETAILS_NO_TERM')"/></b>
				</xsl:if>
				
				<xsl:if test="count(CommercialInvoice/Body/TermsAndConditions/clause) != 0">
					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
							<td width="40">&nbsp;</td>
							<td>
								<table border="0" width="570" cellpadding="0" cellspacing="1">
									<tr>
										<th class="FORMH2"></th>
										<th class="FORMH2" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TABLE_CLAUSE')"/></th>
										<th class="FORMH2" align="center"></th>
									</tr>
									<xsl:for-each select="CommercialInvoice/Body/TermsAndConditions/clause">
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
					<xsl:if test="CommercialInvoice/Body/RoutingSummary/transportService[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TRANSPORT_SERVICE')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/RoutingSummary/transportService"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification[.!=''] or CommercialInvoice/Body/RoutingSummary/MeansOfTransport/RailTransportIdentification[.!=''] or CommercialInvoice/Body/RoutingSummary/MeansOfTransport/RoadTransportIdentification[.!=''] or CommercialInvoice/Body/RoutingSummary/MeansOfTransport/FlightDetails[.!=''] or CommercialInvoice/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TRANSPORT_BY')"/></td>
							<td>
								<font class="REPORTDATA">
									<xsl:choose>
										<xsl:when test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification[.!='']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_01_SEA')"/>
										</xsl:when>
										<xsl:when test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/RailTransportIdentification[.!='']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_03_RAIL')"/>
										</xsl:when>
										<xsl:when test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/RoadTransportIdentification[.!='']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_04_TRUCK')"/>
										</xsl:when>
										<xsl:when test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/FlightDetails[.!='']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_02_AIR')"/>
										</xsl:when>
										<xsl:when test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification[.!='']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_09_INLAND_WATER')"/>
										</xsl:when>
										<xsl:otherwise/>
									</xsl:choose>
								</font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/VoyageDetail/departureDate[.!=''] or CommercialInvoice/Body/RoutingSummary/MeansOfTransport/FlightDetails/departureDate[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DEPARTURE_DATE')"/></td>
							<td>
								<font class="REPORTDATA">
									<xsl:if test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/VoyageDetail/departureDate[.!='']">
										<xsl:variable name="date"><xsl:value-of select="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/VoyageDetail/departureDate"/></xsl:variable>
										<xsl:value-of select="converttools:getLocaleTimestampRepresentation($date,$language)"/>
									</xsl:if>
									<xsl:if test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/FlightDetails/departureDate[.!='']">
										<xsl:variable name="date"><xsl:value-of select="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/FlightDetails/departureDate"/></xsl:variable>
										<xsl:value-of select="converttools:getLocaleTimestampRepresentation($date,$language)"/>
									</xsl:if>
								</font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="CommercialInvoice/Body/RoutingSummary/PlaceOfLoading/locationName[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_LOADING_PLACE')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/RoutingSummary/PlaceOfLoading/locationName"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="CommercialInvoice/Body/RoutingSummary/PlaceOfDischarge/locationName[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DISCHARGE_PLACE')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/RoutingSummary/PlaceOfDischarge/locationName"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="CommercialInvoice/Body/RoutingSummary/PlaceOfDelivery/locationName[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DELIVERY_PLACE')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/RoutingSummary/PlaceOfDelivery/locationName"/></font>
							</td>
						</tr>
					</xsl:if>
						<tr><td>&nbsp;</td></tr>
					<xsl:if test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/Vessel/vesselName">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_VESSEL')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/Vessel/vesselName"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="CommercialInvoice/Body/RoutingSummary/MeansOfTransport/SeaTransportIdentification/VoyageDetail/voyageNumber or CommercialInvoice/Body/RoutingSummary/MeansOfTransport/FlightDetails/flightNumber or CommercialInvoice/Body/RoutingSummary/MeansOfTransport/RoadTransportIdentification/licencePlateIdentification or CommercialInvoice/Body/RoutingSummary/MeansOfTransport/RailTransportIdentification/locomotiveNumber">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TRANSPORT_REFERENCE')"/></td>
							<td>
								<font class="REPORTDATA">
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
								</font>
							</td>
						</tr>
					</xsl:if>
				</table>
					
				<!--Incoterms-->
				
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<xsl:if test="CommercialInvoice/Body/GeneralInformation/Incoterms/incotermsCode[.!='']">
						<tr>
				    		<td width="40">&nbsp;</td>
				    		<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_INCOTERMS')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/GeneralInformation/Incoterms/incotermsCode"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="CommercialInvoice/Body/GeneralInformation/Incoterms/NamedLocation/locationName[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_INCOTERMS_PLACE')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="CommercialInvoice/Body/GeneralInformation/Incoterms/NamedLocation/locationName"/></font>
							</td>
						</tr>
					</xsl:if>
				</table>
		
				<p><br/></p>
		
				
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
				
				<xsl:if test="count(CommercialInvoice/Body/LineItemDetails/LineItem) = 0">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_NO_PRODUCT')"/></b>
				</xsl:if>
			
				<xsl:if test="count(CommercialInvoice/Body/LineItemDetails/LineItem) != 0">
					<xsl:for-each select="CommercialInvoice/Body/LineItemDetails/LineItem">
						<xsl:call-template name="PRODUCT_DETAILS">

							<xsl:with-param name="position"><xsl:value-of select="position()"></xsl:value-of></xsl:with-param>
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
						<!-- xsl:call-template name="PRODUCT_DETAILS"/ -->
						<br/>
					</xsl:for-each>
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

				<xsl:if test="count(CommercialInvoice/Body/gtp:PackingDetail/gtp:Package) = 0">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_NO_PACKAGE')"/></b>
				</xsl:if>

				<xsl:if test="count(CommercialInvoice/Body/gtp:PackingDetail/gtp:Package) != 0">
					<xsl:for-each select="CommercialInvoice/Body/gtp:PackingDetail/gtp:Package">
					
						<xsl:call-template name="PACKAGE_DETAILS">

							<xsl:with-param name="position"><xsl:value-of select="position()"></xsl:value-of></xsl:with-param>
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
						
						<!--
						<xsl:call-template name="PACKAGE_DETAILS">
							<xsl:with-param name="position"><xsl:value-of select="position()"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="package_number"><xsl:value-of select="gtp:PackageCount/gtp:numberOfPackages"/></xsl:with-param>
							<xsl:with-param name="package_type"><xsl:value-of select="gtp:PackageCount/gtp:typeOfPackage"/></xsl:with-param>
							<xsl:with-param name="package_description"><xsl:value-of select="gtp:Content/gtp:Product/gtp:productName"/></xsl:with-param>
							<xsl:with-param name="package_height"><xsl:value-of select="gtp:PackageDimensions/gtp:heightValue"/></xsl:with-param>
							<xsl:with-param name="package_width"><xsl:value-of select="gtp:PackageDimensions/gtp:widthValue"/></xsl:with-param>
							<xsl:with-param name="package_length"><xsl:value-of select="gtp:PackageDimensions/gtp:lengthValue"/></xsl:with-param>
							<xsl:with-param name="package_dimension_unit"><xsl:value-of select="gtp:PackageDimensions/gtp:dimensionUnitCode"/></xsl:with-param>
							<xsl:with-param name="package_netweight"><xsl:value-of select="gtp:NetWeight/gtp:value"/></xsl:with-param>
							<xsl:with-param name="package_grossweight"><xsl:value-of select="gtp:GrossWeight/gtp:value"/></xsl:with-param>
							<xsl:with-param name="package_weight_unit"><xsl:value-of select="gtp:NetWeight/gtp:weightUnitCode"/></xsl:with-param>
							<xsl:with-param name="package_grossvolume"><xsl:value-of select="gtp:GrossVolume/gtp:value"/></xsl:with-param>
							<xsl:with-param name="package_volume_unit"><xsl:value-of select="gtp:GrossVolume/gtp:volumeUnitCode"/></xsl:with-param>
							<xsl:with-param name="package_marks"><xsl:value-of select="gtp:marksAndNumbers"/></xsl:with-param>
						</xsl:call-template>
						-->
						
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
				<table border="0" cellpadding="0" cellspacing="0" width="570">
					<xsl:if test="CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalNetWeight/gtp:value[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_NETWEIGHT')"/></td>
							<td>
								<font class="REPORTDATA">
									<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalNetWeight/gtp:value,$language)"/>&nbsp;
									<xsl:value-of select="CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalNetWeight/gtp:weightUnitCode"/>
								</font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalGrossWeight/gtp:value[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_GROSSWEIGHT')"/></td>
							<td>
								<font class="REPORTDATA">
									<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalGrossWeight/gtp:value,$language)"/>&nbsp;
									<xsl:value-of select="CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalGrossWeight/gtp:weightUnitCode"/>
								</font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalNetVolume/gtp:value[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_NETVOLUMNE')"/></td>
							<td>
								<font class="REPORTDATA">
									<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalNetVolume/gtp:value,$language)"/>&nbsp;
									<xsl:value-of select="CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalNetVolume/gtp:volumeUnitCode"/>
								</font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalGrossVolume/gtp:value[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_GROSSVOLUME')"/></td>
							<td>
								<font class="REPORTDATA">
									<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalGrossVolume/gtp:value,$language)"/>&nbsp;
									<xsl:value-of select="CommercialInvoice/Body/gtp:PackingDetail/gtp:TotalGrossVolume/gtp:volumeUnitCode"/>
								</font>
							</td>
						</tr>
					</xsl:if>
				</table>
		
				<p><br/></p>
		
				<!--Charges or Discount-->
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
				
				<xsl:if test="count(CommercialInvoice/Body/GeneralChargesOrDiscounts/LumpSumChargeWithDocumentIdentifier) = 0">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_NO_CHARGE')"/></b>
				</xsl:if>

				<xsl:if test="count(CommercialInvoice/Body/GeneralChargesOrDiscounts/LumpSumChargeWithDocumentIdentifier) != 0">
						<xsl:for-each select="CommercialInvoice/Body/GeneralChargesOrDiscounts">
						
							<xsl:call-template name="CHARGE_DETAILS">
								<xsl:with-param name="position"><xsl:value-of select="position()"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="charge_type"><xsl:value-of select="LumpSumChargeWithDocumentIdentifier/chargeType"/></xsl:with-param>
								<xsl:with-param name="charge_description"><xsl:value-of select="LumpSumChargeWithDocumentIdentifier/DocumentIdentifier/documentNumber"/></xsl:with-param>
								<xsl:with-param name="charge_currency"><xsl:value-of select="LumpSumChargeWithDocumentIdentifier/ChargeAmount/currencyCode"/></xsl:with-param>
								<xsl:with-param name="charge_amount"><xsl:value-of select="converttools:getLocaleAmountRepresentation(LumpSumChargeWithDocumentIdentifier/ChargeAmount/value,LumpSumChargeWithDocumentIdentifier/ChargeAmount/currencyCode,$language)"/></xsl:with-param>
								<xsl:with-param name="charge_rate"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(LumpSumChargeWithDocumentIdentifier/gtp:EquivalentAmount/gtp:rate,$language)"/></xsl:with-param>
								<xsl:with-param name="charge_reporting_currency"><xsl:value-of select="LumpSumChargeWithDocumentIdentifier/gtp:EquivalentAmount/gtp:currencyCode"/></xsl:with-param>
								<xsl:with-param name="charge_reporting_amount"><xsl:value-of select="converttools:getLocaleAmountRepresentation(LumpSumChargeWithDocumentIdentifier/gtp:EquivalentAmount/gtp:value,LumpSumChargeWithDocumentIdentifier/gtp:EquivalentAmount/gtp:currencyCode,$language)"/></xsl:with-param>
							</xsl:call-template>
							
							<!--
							<xsl:call-template name="CHARGE_DETAILS">
											<xsl:with-param name="position"><xsl:value-of select="position()"></xsl:value-of></xsl:with-param>
											<xsl:with-param name="charge_type"><xsl:value-of select="chargeType"/></xsl:with-param>
											<xsl:with-param name="charge_description"><xsl:value-of select="DocumentIdentifier/documentNumber"/></xsl:with-param>
											<xsl:with-param name="charge_currency"><xsl:value-of select="ChargeAmount/currencyCode"/></xsl:with-param>
											<xsl:with-param name="charge_amount"><xsl:value-of select="ChargeAmount/value"/></xsl:with-param>
											<xsl:with-param name="charge_rate"><xsl:value-of select="gtp:EquivalentAmount/gtp:rate"/></xsl:with-param>
											<xsl:with-param name="charge_reporting_currency"><xsl:value-of select="gtp:EquivalentAmount/gtp:currencyCode"/></xsl:with-param>
											<xsl:with-param name="charge_reporting_amount"><xsl:value-of select="gtp:EquivalentAmount/gtp:value"/></xsl:with-param>
							</xsl:call-template>
							-->
							<br/>
						</xsl:for-each>
				</xsl:if>
				
				<!--
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
				
				<xsl:if test="count(CommercialInvoice/Body/GeneralChargesOrDiscounts/LumpSumChargeWithDocumentIdentifier) = 0">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_NO_CHARGE')"/></b>
				</xsl:if>
				
				<xsl:if test="count(CommercialInvoice/Body/GeneralChargesOrDiscounts/LumpSumChargeWithDocumentIdentifier) != 0">
					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
							<td width="40">&nbsp;</td>
							<td>
								<table border="0" width="570" cellpadding="0" cellspacing="1">
									<tr>
										<th class="FORMH2" rowspan="2" align="center"></th>
										<th class="FORMH2" rowspan="2" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_TYPE')"/></th>
										<th class="FORMH2" rowspan="2" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_DESCRIPTION')"/></th>
										<th class="FORMH2" rowspan="2" colspan="2" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_AMOUNT')"/></th>
										<th class="FORMH2" colspan="3" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_EQUIVALENTAMOUNT')"/></th>
									</tr>
									<tr>
										<th class="FORMH2" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_RATE')"/></th>
										<th class="FORMH2" colspan="2" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_VALUE')"/></th>
									</tr>
									<xsl:for-each select="CommercialInvoice/Body/GeneralChargesOrDiscounts/LumpSumChargeWithDocumentIdentifier">
										<xsl:call-template name="CHARGE_DETAILS">
											<xsl:with-param name="position"><xsl:value-of select="position()"></xsl:value-of></xsl:with-param>
											<xsl:with-param name="charge_type"><xsl:value-of select="chargeType"/></xsl:with-param>
											<xsl:with-param name="charge_description"><xsl:value-of select="DocumentIdentifier/documentNumber"/></xsl:with-param>
											<xsl:with-param name="charge_currency"><xsl:value-of select="ChargeAmount/currencyCode"/></xsl:with-param>
											<xsl:with-param name="charge_amount"><xsl:value-of select="ChargeAmount/value"/></xsl:with-param>
											<xsl:with-param name="charge_rate"><xsl:value-of select="gtp:EquivalentAmount/gtp:rate"/></xsl:with-param>
											<xsl:with-param name="charge_reporting_currency"><xsl:value-of select="gtp:EquivalentAmount/gtp:currencyCode"/></xsl:with-param>
											<xsl:with-param name="charge_reporting_amount"><xsl:value-of select="gtp:EquivalentAmount/gtp:value"/></xsl:with-param>
										</xsl:call-template>
									</xsl:for-each>
								</table>
							</td>
						</tr>
					</table>
				</xsl:if>
				-->
		
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
				
				<xsl:if test="CommercialInvoice/Body/Totals/TotalAmount/MultiCurrency/value[.!='']">
					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_AMOUNT')"/>
							</td>
							<td>
								<font class="REPORTDATA">
									<xsl:variable name="amount"><xsl:value-of select="CommercialInvoice/Body/Totals/TotalAmount/MultiCurrency/value"/></xsl:variable>
									<xsl:variable name="currency"><xsl:value-of select="CommercialInvoice/Body/Totals/TotalAmount/MultiCurrency/currencyCode"/></xsl:variable>
									<xsl:value-of select="$currency"/>&nbsp;
									<xsl:value-of select="converttools:getLocaleAmountRepresentation($amount,$currency,$language)"/>
								</font>
							</td>
						</tr>
					</table>
				</xsl:if>
			
				<p><br/></p>
			
				<!--Payment Terms-->
		
				<xsl:if test="count(CommercialInvoice/Body/PaymentTerms/PaymentTermsDetail/UserDefinedPaymentTerms/line) != 0">
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
			
					<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td>
							<xsl:for-each select="CommercialInvoice/Body/PaymentTerms/PaymentTermsDetail/UserDefinedPaymentTerms/line">
								<xsl:value-of select="."/>
							</xsl:for-each>
						</td>
					</tr>
					</table>
			
					<p><br/></p>
				</xsl:if>
				
				
				<!--Additional Information-->
		
				<xsl:if test="count(CommercialInvoice/Body/AdditionalInformation/line) != 0">
					<table border="0"  width="570" cellpadding="0" cellspacing="0">
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
			
					<table border="0"  width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td  width="40">&nbsp;</td>
						<td>
							<xsl:for-each select="CommercialInvoice/Body/AdditionalInformation/line">
								<xsl:value-of select="."/>
							</xsl:for-each>
						</td>
					</tr>
					</table>
			
					<p><br/></p>
				</xsl:if>
	
			</form>
			
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
