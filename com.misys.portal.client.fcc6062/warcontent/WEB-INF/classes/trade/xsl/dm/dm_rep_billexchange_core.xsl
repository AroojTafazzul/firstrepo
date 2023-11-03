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
			<table id="toolbar" border="0" cellspacing="2" cellpadding="8">
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
					<td class="FORMH1" colspan="3">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_BILL_OF_EXCHANGE')"/></b>&nbsp;-&nbsp;
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
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CUST_REF_ID')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="cust_ref_id"/></font>
						</td>
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
						<font class="REPORTDATA"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_BILL_OF_EXCHANGE')"/></font>
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
				<tr>
					<td>&nbsp;</td>
				</tr>	
				<tr>
					<td>&nbsp;</td>
				</tr>	
				<xsl:if test="prep_date[.!='']">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PREPARATION_DATE')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="prep_date"/></font>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="gtp:BillOfExchange/gtp:Body/gtp:GeneralInformation/gtp:PlaceOfIssue/gtp:locationName[.!='']">	
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COUNTRY_OF_ORIGIN')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:GeneralInformation/gtp:PlaceOfIssue/gtp:locationName"/></font>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="gtp:BillOfExchange/gtp:Body/gtp:GeneralInformation/gtp:PurchaseOrderIdentifier/gtp:documentNumber[.!='']">	
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PURCHASE_ORDER')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:GeneralInformation/gtp:PurchaseOrderIdentifier/gtp:documentNumber"/></font>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="gtp:BillOfExchange/gtp:Body/gtp:GeneralInformation/gtp:DocumentaryCreditIdentifier/gtp:documentNumber[.!='']">	
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_ISSUING_BANK_REFERENCE')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:GeneralInformation/gtp:DocumentaryCreditIdentifier/gtp:documentNumber"/></font>
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
			
			<!--Seller Details-->

			<xsl:if test="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:organizationName[.!=''] or gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='1'][.!=''] or gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='2'][.!=''] or gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='3'][.!=''] or gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:OrganizationIdentification/gtp:organizationReference[.!='']">
				<table border="0" cellspacing="0" width="570">
					<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SELLER_DETAILS')"/></b>
						</td>
					</tr>
				</table>
				<table border="0" cellspacing="0" width="570">
					<xsl:if test="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:organizationName[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:organizationName"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='1'][.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='1']"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='2'][.!='']">
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='2']"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='3'][.!='']">
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='3']"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:OrganizationIdentification/gtp:organizationReference[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:OrganizationIdentification/gtp:organizationReference"/></font>
							</td>
						</tr>
					</xsl:if>
				</table>
				
				<br/>
			</xsl:if>
			
			
			<!--Billto Details-->
			
			<xsl:if test="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:BillTo/gtp:organizationName[.!=''] or gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:BillTo/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='1'][.!=''] or gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:BillTo/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='2'][.!=''] or gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:BillTo/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='3'][.!=''] or gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:BillTo/gtp:OrganizationIdentification/gtp:organizationReference[.!='']">
				<table border="0" cellspacing="0" width="570">
					<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BILL_TO_DETAILS')"/></b>
						</td>
					</tr>
				</table>
				<table border="0" cellspacing="0" width="570">
					<xsl:if test="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:BillTo/gtp:organizationName[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:organizationName"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:BillTo/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='1'][.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='1']"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:BillTo/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='2'][.!='']">
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='2']"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:BillTo/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='3'][.!='']">
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:AddressInformation/gtp:FullAddress/gtp:line[position()='3']"/></font>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:BillTo/gtp:OrganizationIdentification/gtp:organizationReference[.!='']">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
							<td>
								<font class="REPORTDATA"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Parties/gtp:Seller/gtp:OrganizationIdentification/gtp:organizationReference"/></font>
							</td>
						</tr>
					</xsl:if>
				</table>
				
				<br/>
			</xsl:if>
			
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
			
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_AMOUNT')"/>
					</td>
					<td>
						<font class="REPORTDATA">
							<xsl:variable name="amount"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Totals/gtp:TotalAmount/gtp:MultiCurrency/gtp:value"/></xsl:variable>
							<xsl:variable name="currency"><xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Totals/gtp:TotalAmount/gtp:MultiCurrency/gtp:currencyCode"/></xsl:variable>
							<xsl:value-of select="gtp:BillOfExchange/gtp:Body/gtp:Totals/gtp:TotalAmount/gtp:MultiCurrency/gtp:currencyCode"/>&nbsp;
							<xsl:value-of select="converttools:getLocaleAmountRepresentation($amount,$currency,$language)"/>
						</font>
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
					<xsl:for-each select="gtp:BillOfExchange/gtp:Body/gtp:AdditionalInformation/gtp:line">
						<xsl:value-of select="."></xsl:value-of>
					</xsl:for-each>
				</td>
			</tr>
			</table>
	
			<br/>

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

	
	<!-- -->	
	<!--Other Templates-->
	
	<!--Additional Informations-->
	<xsl:template match="gtp:AdditionalInformation/gtp:line">
		<xsl:value-of select="."/>
	</xsl:template>
	
</xsl:stylesheet>
