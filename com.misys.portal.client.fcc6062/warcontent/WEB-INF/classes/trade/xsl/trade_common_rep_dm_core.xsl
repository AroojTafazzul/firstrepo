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
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<xsl:import href="trade_common.xsl"/>
	<xsl:import href="trade_common_rep_dm_details.xsl"/>

	<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="upImage"><xsl:value-of select="$images_path"/>pic_up.gif</xsl:param>
	
	
	<!--TEMPLATE Main-->
	<!--Import the common dm templates -->

	<xsl:template match="dm_tnx_record" mode="folder">

		<!--Variable that holds the tnx type code-->
		<xsl:variable name="tnxTypeCode"><xsl:value-of select="tnx_type_code"/></xsl:variable>
		
		<table border="0">
			<tr>
				<td align="left">
			
				<p><br/></p>
				<form name="fakeform1" onsubmit="return false;">
					<!--Insert the details required to perform the submission-->
					
					<input type="hidden" name="brch_code"><xsl:attribute name="value"><xsl:value-of select="brch_code"/></xsl:attribute></input>
					<input type="hidden" name="company_id"><xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute></input>
					<input type="hidden" name="company_name"><xsl:attribute name="value"><xsl:value-of select="company_name"/></xsl:attribute></input>
					<input type="hidden" name="ref_id"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
					<input type="hidden" name="tnx_id"><xsl:attribute name="value"><xsl:value-of select="tnx_id"/></xsl:attribute></input>
					<input type="hidden" name="amd_no"><xsl:attribute name="value"><xsl:value-of select="amd_no"/></xsl:attribute></input>
					<input type="hidden" name="parent_ref_id"><xsl:attribute name="value"><xsl:value-of select="parent_ref_id"/></xsl:attribute></input>
					<input type="hidden" name="parent_product_code"><xsl:attribute name="value"><xsl:value-of select="parent_product_code"/></xsl:attribute></input>
					<input type="hidden" name="parent_bo_ref_id"><xsl:attribute name="value"><xsl:value-of select="parent_bo_ref_id"/></xsl:attribute></input>
         		<!-- Previous ctl date, used for synchronisation issues -->
         		<input type="hidden" name="old_ctl_dttm"><xsl:attribute name="value"><xsl:value-of select="ctl_dttm"/></xsl:attribute></input>
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
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_PREPARATION_DATE')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="prep_date"/></font></td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_AMOUNT')"/></td>
						<td>
							<font class="REPORTBLUE">
								<xsl:value-of select="cur_code"/>&nbsp;
								<xsl:value-of select="dm_amt"/>
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
							<!-- Not available in edit mode ...
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EUCP_CREDIT_REFERENCE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="eucp_reference"/></font></td>
							</tr>
							-->	
         				<xsl:if test="eucp_version[. != '']">
         					<tr>
         						<td width="40">&nbsp;</td>
         						<td width="150">
         							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EUCP_VERSION')"/>
         						</td>
         						<td>
         							<font class="REPORTDATA"><xsl:value-of select="eucp_version"/></font>
         						</td>
         					</tr>
         				</xsl:if>
         				<xsl:if test="eucp_presentation_place[. != '']">
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
         				</xsl:if>
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
				
				<!-- Separation between the folder and the template details -->
				<font class="REPORTDATA"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TEMPLATE_DETAILS')"/>:</font>
				<p></p>
								
				
				<!--The following data are fetched the xml document preparation representation, and both dates and amounts are expressed in standard bolero format.-->
				<!--A conversion is therefore required to have it in user locale -->
				<!--References-->
				
				
				<xsl:if test="purchaseOrderReference[.!=''] or commercialInvoiceReference[.!=''] or documentaryCreditReference[.!=''] or exportDocumentaryCreditReference[.!=''] or exporterReference[.!='']">
		
					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
							<td class="FORMH1" colspan="3">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REFERENCES')"/></b>
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
					
					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_REPORTING_CURRENCY')"/></td>
							<td><font class="REPORTBLUE"><xsl:value-of select="Totals/Total/totalCurrencyCode"/></font></td>
						</tr>
						<xsl:if test="CountryOfOrigin/countryName[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COUNTRY_OF_ORIGIN')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="CountryOfOrigin/countryName"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="CountryOfDestination/countryName[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COUNTRY_OF_DESTINATION')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="CountryOfDestination/countryName"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="purchaseOrderReference[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PURCHASE_ORDER')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="purchaseOrderReference"/>	</font></td>
							</tr>
						</xsl:if>
						<xsl:if test="commercialInvoiceReference[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COMMERCIAL_INVOICE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of 	select="commercialInvoiceReference"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="documentaryCreditReference[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_ISSUING_BANK_REFERENCE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of 	select="documentaryCreditReference"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="exportDocumentaryCreditReference[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_ADVISING_BANK_REFERENCE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of 	select="exportDocumentaryCreditReference"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="exporterReference[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_EXPORTER_REFERENCE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="exporterReference"/></font></td>
							</tr>
						</xsl:if>
						
					</table>
					
					<p><br/></p>
					
				</xsl:if>
				
			
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
				
				<xsl:if test="Shipper/organizationName[.!=''] or Shipper/addressLine1[.!=''] or Shipper/addressLine2[.!=''] or Shipper/addressLine3[.!=''] or Shipper/organizationReference[.!='']">
		
					<table border="0" cellspacing="0" width="570">
						<tr>
							<td width="15">&nbsp;</td>
							<td class="FORMH2" align="left">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SHIPPER_DETAILS')"/></b>
							</td>
						</tr>
					</table>
					<table border="0" cellspacing="0" width="570">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
							<td><font class="REPORTDATA"><xsl:value-of select="Shipper/organizationName"/></font></td>
						</tr>
						<xsl:if test="Shipper/addressLine1[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="Shipper/addressLine1"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="Shipper/addressLine2[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170">
									<xsl:choose>
										<xsl:when test="Shipper/addressLine1[.!='']">&nbsp;</xsl:when>
										<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></xsl:otherwise>
									</xsl:choose>
								</td>
								<td><font class="REPORTDATA"><xsl:value-of select="Shipper/addressLine2"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="Shipper/addressLine3[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170">
									<xsl:choose>
										<xsl:when test="Shipper/addressLine1[.!=''] or Shipper/addressLine2[.!='']">&nbsp;</xsl:when>
										<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></xsl:otherwise>
									</xsl:choose>
								</td>
								<td><font class="REPORTDATA"><xsl:value-of select="Shipper/addressLine3"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="Shipper/organizationReference[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of 	select="Shipper/organizationReference"/></font></td>
							</tr>
						</xsl:if>
					</table>
					
					<p><br/></p>
					
				</xsl:if>
					
				<!--Consignee Details-->
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
										<xsl:when test="counterparty_address_line_2[.!='']">&nbsp;</xsl:when>
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
								<td><font class="REPORTDATA"><xsl:value-of select="counterparty_reference"/></font></td>
							</tr>
						</xsl:if>
					</table>
					<p><br/></p>
					
				</xsl:if>

				<!--Billto Details-->
				
				<xsl:if test="BillTo/organizationName[.!=''] or BillTo/addressLine1[.!=''] or BillTo/addressLine2[.!=''] or BillTo/addressLine3[.!=''] or BillTo/organizationReference[.!='']">
		
					<table border="0" cellspacing="0" width="570">
						<tr>
							<td width="15">&nbsp;</td>
							<td class="FORMH2" align="left">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BILL_TO_DETAILS')"/></b>
							</td>
						</tr>
					</table>
					<table border="0" cellspacing="0" width="570">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></td>
							<td><font class="REPORTDATA"><xsl:value-of select="BillTo/organizationName"/></font></td>
						</tr>
						<xsl:if test="BillTo/addressLine1[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="BillTo/addressLine1"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="BillTo/addressLine2[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170">
									<xsl:choose>
										<xsl:when test="BillTo/addressLine1[.!='']">&nbsp;</xsl:when>
										<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></xsl:otherwise>
									</xsl:choose>
								</td>
								<td><font class="REPORTDATA"><xsl:value-of select="BillTo/addressLine2"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="BillTo/addressLine3[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170">
									<xsl:choose>
										<xsl:when test="BillTo/addressLine1[.!=''] or BillTo/addressLine2[.!='']">&nbsp;</xsl:when>
										<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></xsl:otherwise>
									</xsl:choose>
								</td>
								<td><font class="REPORTDATA"><xsl:value-of select="BillTo/addressLine3"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="BillTo/organizationReference[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of 	select="BillTo/organizationReference"/></font></td>
							</tr>
						</xsl:if>
					</table>
					
					<p><br/></p>
					
				</xsl:if>
				
				<!--Buyer Details-->
				
				<xsl:if test="Buyer/organizationName[.!=''] or Buyer/addressLine1[.!=''] or Buyer/addressLine2[.!=''] or Buyer/addressLine3[.!=''] or Buyer/organizationReference[.!='']">
		
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
							<td><font class="REPORTDATA"><xsl:value-of select="Buyer/organizationName"/></font></td>
						</tr>
						<xsl:if test="Buyer/addressLine1[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="Buyer/addressLine1"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="Buyer/addressLine2[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170">
									<xsl:choose>
										<xsl:when test="Buyer/addressLine1[.!='']">&nbsp;</xsl:when>
										<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></xsl:otherwise>
									</xsl:choose>
								</td>
								<td><font class="REPORTDATA"><xsl:value-of select="Buyer/addressLine2"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="Buyer/addressLine3[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170">
									<xsl:choose>
										<xsl:when test="Buyer/addressLine1[.!=''] or Buyer/addressLine2[.!='']">&nbsp;</xsl:when>
										<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></xsl:otherwise>
									</xsl:choose>
								</td>
								<td><font class="REPORTDATA"><xsl:value-of select="Buyer/addressLine3"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="Buyer/organizationReference[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of 	select="Buyer/organizationReference"/></font></td>
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
								<img border="0">
									<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($upImage)"/></xsl:attribute>
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
								</img>
							</a>
						</td>
					</tr>
				</table>
			
				<xsl:if test="count(TermsAndConditions/clause) = 0">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TERMDETAILS_NO_TERM')"/></b>
					<br/>
				</xsl:if>
				
				<xsl:if test="count(TermsAndConditions/clause) != 0">

					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
							<td width="15">&nbsp;</td>
							<td>
								<table border="0" width="100%" cellpadding="0" cellspacing="1">
									<tr>
										<th class="FORMH2"></th>
										<th class="FORMH2" align="center"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TABLE_CLAUSE')"/></th>
										<th class="FORMH2" align="center"></th>
									</tr>
									<!--<xsl:apply-templates select="TermsAndConditions/clause"/>-->
									<xsl:for-each select="TermsAndConditions/clause">
										<xsl:call-template name="TERM_DETAILS">
											<xsl:with-param name="position"><xsl:value-of select="position()"></xsl:value-of></xsl:with-param>
											<xsl:with-param name="data"><xsl:value-of select="."/></xsl:with-param>
										</xsl:call-template> 
										<!--xsl:call-template name="TERM_DETAILS"/-->
									</xsl:for-each>
								</table>
							</td>
						</tr>
					</table>
				</xsl:if>

				<p><br/></p>
						
				<!--Routing Summary / Shipment Details-->

				<xsl:if test="RoutingSummary/transportType[.!=''] or RoutingSummary/departureDate[.!=''] or RoutingSummary/PlaceOfLoading/locationName[.!=''] or RoutingSummary/PlaceOfDischarge/locationName[.!=''] or RoutingSummary/PlaceOfDelivery/locationName[.!=''] or RoutingSummary/vesselName[.!=''] or RoutingSummary/transportReference[.!=''] or RoutingSummary/PlaceOfReceipt/locationName[.!=''] or Incoterms/incotermsCode[.!=''] or Incoterms/incotermsPlace[.!='']">
				
					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
							<td class="FORMH1">
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
						<xsl:if test="RoutingSummary/transportService[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TRANSPORT_SERVICE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="RoutingSummary/transportService"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="RoutingSummary/transportType[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TRANSPORT_BY')"/></td>
								<td>
									<font class="REPORTDATA">
										<xsl:choose>
											<xsl:when test="RoutingSummary/transportType[. = 'MARITIME']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_01_SEA')"/>
											</xsl:when>
											<xsl:when test="RoutingSummary/transportType[. = 'RAIL']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_03_RAIL')"/>
											</xsl:when>
											<xsl:when test="RoutingSummary/transportType[. = 'ROAD']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_04_TRUCK')"/>
											</xsl:when>
											<xsl:when test="RoutingSummary/transportType[. = 'AIR']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_02_AIR')"/>
											</xsl:when>
											<xsl:when test="RoutingSummary/transportType[. = 'MAIL']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_05_POSTAGE')"/>
											</xsl:when>
											<xsl:when test="RoutingSummary/transportType[. = 'MULTIMODAL']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_06_MIXED')"/>
											</xsl:when>
											<xsl:when test="RoutingSummary/transportType[. = 'INLANDWATER']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_09_INLAND_WATER')"/>
											</xsl:when>
											<xsl:otherwise/>
										</xsl:choose>
									</font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="RoutingSummary/departureDate[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DEPARTURE_DATE')"/></td>
								<td>
									<font class="REPORTDATA">
										<xsl:variable name="date"><xsl:value-of select="RoutingSummary/departureDate"/></xsl:variable>
										<xsl:value-of select="converttools:getLocaleTimestampRepresentation($date,$language)"/>
									</font>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="RoutingSummary/PlaceOfLoading/locationName[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_LOADING_PLACE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="RoutingSummary/PlaceOfLoading/locationName"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="RoutingSummary/PlaceOfDischarge/locationName[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DISCHARGE_PLACE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="RoutingSummary/PlaceOfDischarge/locationName"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="RoutingSummary/PlaceOfDelivery/locationName[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_DELIVERY_PLACE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="RoutingSummary/PlaceOfDelivery/locationName"/></font></td>
							</tr>
						</xsl:if>
						<tr><td>&nbsp;</td></tr>
						<xsl:if test="RoutingSummary/vesselName[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_VESSEL')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="RoutingSummary/vesselName"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="RoutingSummary/transportReference[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TRANSPORT_REFERENCE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="RoutingSummary/transportReference"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="RoutingSummary/PlaceOfReceipt/locationName[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_RECEIPT_PLACE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="RoutingSummary/PlaceOfReceipt/locationName"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="Incoterms/incotermsCode[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_INCOTERMS')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="Incoterms/incotermsCode"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="Incoterms/incotermsPlace[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_INCOTERMS_PLACE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="Incoterms/incotermsPlace"/></font></td>
							</tr>
						</xsl:if>
					</table>
					
					<p><br/></p>
					
				</xsl:if>
				
		
				<!--Product Details-->

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
				
				<xsl:if test="count(LineItemDetails/Item) = 0">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_NO_PRODUCT')"/></b>
					<br/>
				</xsl:if>
			
				<xsl:if test="count(LineItemDetails/Item) != 0">
					<xsl:for-each select="LineItemDetails/Item">
						<xsl:call-template name="PRODUCT_DETAILS">

							<xsl:with-param name="position"><xsl:value-of select="position()"></xsl:value-of></xsl:with-param>
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
								<img border="0" >
									<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($upImage)"/></xsl:attribute>
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
								</img>
							</a>
						</td>
					</tr>
				</table>
				
				<br/>
				
				<xsl:if test="count(PackingDetail/Package) = 0">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_NO_PACKAGE')"/></b>
					<br/>
				</xsl:if>

				<xsl:if test="count(PackingDetail/Package) != 0">
					<xsl:for-each select="PackingDetail/Package">
						<xsl:call-template name="PACKAGE_DETAILS">

							<xsl:with-param name="position"><xsl:value-of select="position()"/></xsl:with-param>
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
						<br/>
					</xsl:for-each>
				</xsl:if>
				
				<br/>
				
				<!-- Summary of total wight and volumes-->
				
				<table border="0" cellspacing="0" width="570">
					<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_SUMMARY')"/></b>
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					
					<xsl:if test="PackingDetail/totalNetWeightValue[.!=''] or PackingDetail/totalNetWeightUnitCode[.!=''] ">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_NETWEIGHT')"/></td>
							<td><font class="REPORTDATA">
								<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(PackingDetail/totalNetWeightValue,$language)"/>&nbsp;
								<xsl:value-of select="PackingDetail/totalNetWeightUnitCode"/>
							</font></td>
						</tr>
					</xsl:if>
					
					<xsl:if test="PackingDetail/totalGrossWeightValue[.!=''] or PackingDetail/totalGrossWeightUnitCode[.!=''] ">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_GROSSWEIGHT')"/></td>
							<td><font class="REPORTDATA">
								<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(PackingDetail/totalGrossWeightValue,$language)"/>&nbsp;
								<xsl:value-of select="PackingDetail/totalGrossWeightUnitCode"/>
							</font></td>
						</tr>
					</xsl:if>
					
					<xsl:if test="PackingDetail/totalNetVolumeValue[.!=''] or PackingDetail/totalNetVolumeUnitCode[.!=''] ">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_NETVOLUMNE')"/></td>
							<td><font class="REPORTDATA">
								<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(PackingDetail/totalNetVolumeValue,$language)"/>&nbsp;
								<xsl:value-of select="PackingDetail/totalNetVolumeUnitCode"/>
							</font></td>
						</tr>
					</xsl:if>
					
					<xsl:if test="PackingDetail/totalGrossVolumeValue[.!=''] or PackingDetail/totalGrossVolumeUnitCode[.!=''] ">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TOTAL_GROSSVOLUME')"/></td>
							<td><font class="REPORTDATA">
								<xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(PackingDetail/totalGrossVolumeValue,$language)"/>&nbsp;
								<xsl:value-of select="PackingDetail/totalNetVolumeUnitCode"/>
							</font></td>
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
								<img border="0" >
									<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($upImage)"/></xsl:attribute>
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
								</img>
							</a>
						</td>
					</tr>
				</table>
				
				<br/>
				
				<xsl:if test="count(GeneralChargesOrDiscounts) = 0">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_NO_CHARGE')"/></b>
					<br/>
				</xsl:if>

				<xsl:if test="count(GeneralChargesOrDiscounts) != 0">
						<xsl:for-each select="GeneralChargesOrDiscounts">
							<xsl:call-template name="CHARGE_DETAILS">
								<xsl:with-param name="position"><xsl:value-of select="position()"/></xsl:with-param>
								<xsl:with-param name="structure_name">charge</xsl:with-param>
								<xsl:with-param name="mode">existing</xsl:with-param>
								<xsl:with-param name="charge_type"><xsl:value-of select="chargeType"/></xsl:with-param>
								<xsl:with-param name="charge_description"><xsl:value-of select="chargeDescription"/></xsl:with-param>
								<xsl:with-param name="charge_currency"><xsl:value-of select="chargeCurrencyCode"/></xsl:with-param>
								<xsl:with-param name="charge_amount"><xsl:value-of select="converttools:getLocaleAmountRepresentation(value,chargeCurrencyCode,$language)"/></xsl:with-param>
								<xsl:with-param name="charge_rate"><xsl:value-of select="converttools:getLocaleBigDecimalRepresentation(rate,$language)"/></xsl:with-param>
								<xsl:with-param name="charge_reporting_currency"><xsl:value-of select="chargeReportingCurrencyCode"/></xsl:with-param>
								<xsl:with-param name="charge_reporting_amount"><xsl:value-of select="converttools:getLocaleAmountRepresentation(chargeReportingAmount,chargeReportingCurrencyCode,$language)"/></xsl:with-param>
							</xsl:call-template>
							<br/>
						</xsl:for-each>
				</xsl:if>
				
				<p><br/></p>
				
				
				<!--Payment Terms-->
				
				<xsl:if test="PaymentTerms/line[.!='']">
				
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
		
					<table border="0" cellpadding="0" cellspacing="0" width="570">
						<tr>
							<td width="40">&nbsp;</td>
							<td><font class="REPORTDATA"><xsl:value-of select="PaymentTerms/line"/></font></td>
						</tr>
					</table>
		
					<p><br/></p>
					
				</xsl:if>
		
				<!--Additional Information-->
				
				<xsl:if test="AdditionalInformation/line[.!='']">
				
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
			
					<table border="0" cellpadding="0" cellspacing="0" width="570">
						<tr>
							<td width="40">&nbsp;</td>
							<td><font class="REPORTDATA"><xsl:value-of select="AdditionalInformation/line"/></font></td>
						</tr>
					</table>
		
					<p><br/></p>
				
				</xsl:if>
				
			<!--
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
			-->
				
			</td>
		</tr>
	</table>
	</xsl:template>
		
</xsl:stylesheet>
