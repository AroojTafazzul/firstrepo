<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		exclude-result-prefixes="localization">
<!--
   Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:import href="po_common.xsl"/>
	<xsl:import href="bank_common_rep.xsl"/>
	<xsl:import href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:import href="../../core/xsl/common/trade_common.xsl"/>

	<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	
	<!-- All marks used to shown/hidden form's sections-->
	<xsl:param name="section_po_line_items"/>
	<xsl:param name="section_po_amount_details"/>
	<xsl:param name="section_po_payment_terms"/>
	<xsl:param name="section_po_settlement_terms"/>
	<xsl:param name="section_po_inco_terms"/>
	<xsl:param name="section_po_routing_summary"/>
	
	<xsl:param name="section_li_product"/>
	<xsl:param name="section_li_amount_details"/>
	<xsl:param name="section_li_shipment_details"/>
	<xsl:param name="section_li_inco_terms"/>
	<xsl:param name="section_li_routing_summary"/>
	
	<xsl:template match="/">
		<xsl:apply-templates select="po_tnx_record"/>
	</xsl:template>

	<!--TEMPLATE Main for IN records-->

	<xsl:template match="po_tnx_record">

	<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"></script>
	<script type="text/javascript">
		<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
	</script>
	<script type="text/javascript" src="/content/OLD/javascript/bank_po_reporting.js"></script>
	
	<table border="0" width="100%" cellspacing="2" cellpadding="4" class="FORMTABLEBORDER">
	<tr>
	<td class="FORMTABLE" align="center">
	
	<table border="0">

	<!-- Display Common Reporting Input Area -->
	
	<xsl:call-template name="bank_reporting_area_rep"/>
	
	<!-- View PO Transaction Details - BEGIN -->

	<tr>
	<td align="left">

	<xsl:choose>
		<!-- Uncomment the following for IN details editing
		<xsl:when test="tnx_type_code[.='01' or .='15' or .='13']">
		-->
		<xsl:when test="tnx_type_code[.='15' or .='13'] or (tnx_type_code[.='01'] and attachments/attachment[type = '01'])">
			
		<hr/>
		<p><b><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></b></p>

		<form name="fakeform1" onsubmit="return false;">

		<!--Insert the Tnx Amount as hidden field-->
		
		<input type="hidden" name="company_id"><xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute></input>
		<input type="hidden" name="brch_code"><xsl:attribute name="value"><xsl:value-of select="brch_code"/></xsl:attribute></input>
        <!-- old_ctl_date used to check the transaction has not been modified in between -->
		<input type="hidden" name="old_ctl_dttm"><xsl:attribute name="value"><xsl:value-of select="bo_ctl_dttm"/></xsl:attribute></input>

		<p><br/></p>

		<!--General Details-->

		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tr>
				<td class="FORMH1" colspan="3">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/></b>
				</td>
			</tr>
		</table>
		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/></td>
				<td>
					<font class="REPORTDATA"><xsl:value-of select="ref_id"/></font>
					<input type="hidden" name="ref_id"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
				</td>
			</tr>
			<xsl:if test="template_id[.!='']">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TEMPLATE_ID')"/></td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="template_id"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="cust_ref_id[.!='']">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/></td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="cust_ref_id"/></font>
					</td>
				</tr>	
			</xsl:if>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')"/></td>
				<td>
					<font class="REPORTDATA"><xsl:value-of select="appl_date"/></font>
				</td>
			</tr>
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ISSUE_DATE')"/></td>
				<td><font class="REPORTDATA"><xsl:value-of select="iss_date"/></font>
				</td>
			</tr>
		</table>
		
		<p><br/></p>
		
		<!--Seller Details-->	
		
		<table border="0" cellspacing="0" width="570">
			<tr>
				<td width="15">&nbsp;</td>
				<td class="FORMH2" align="left">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SELLER_DETAILS')"/></b>
				</td>
			</tr>
		</table>
		<table border="0" cellspacing="0" width="570">
			<!-- Display Entities -->
			<xsl:if test="entity[.!='']">
 				<tr>
					<td>&nbsp;</td>
					<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ENTITY')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="entity"/></font></td>
				</tr>
   			</xsl:if>
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/></td>
				<td><font class="REPORTDATA"><xsl:value-of select="seller_name"/></font></td>
			</tr>
			<xsl:if test="seller_bei[.!='']">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="seller_bei"/></font></td>
				</tr>
			</xsl:if>
			<xsl:if test="seller_street_name[.!='']">
			<tr>
				<td>&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/></td>
				<td><font class="REPORTDATA"><xsl:value-of select="seller_street_name"/></font></td>
			</tr>
			</xsl:if>
			<xsl:if test="seller_post_code[.!='']">
				<tr>
					<td>&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="seller_post_code"/></font></td>
				</tr>
			</xsl:if>
			<xsl:if test="seller_town_name[.!='']">
				<tr>
					<td>&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="seller_town_name"/></font></td>
				</tr>
			</xsl:if>
			<xsl:if test="seller_country_sub_div[.!='']">
				<tr>
					<td>&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="seller_country_sub_div"/></font></td>
				</tr>
			</xsl:if>
			<xsl:if test="seller_country[.!='']">
				<tr>
					<td>&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="seller_country"/></font></td>
				</tr>
			</xsl:if>
			<xsl:if test="seller_reference[.!='']">
				<tr>
					<td>&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="seller_reference"/></font></td>
				</tr>
			</xsl:if>
		</table>
				
		<p><br/></p>
		
		<!--Buyer Details-->
		<table border="0" cellspacing="0" width="570">
			<tr>
				<td width="15">&nbsp;</td>
				<td class="FORMH2" align="left">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SELLER_DETAILS')"/></b>
				</td>
			</tr>
		</table>
		<table border="0" cellspacing="0" width="570">
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/></td>
				<td>
					<font class="REPORTDATA"><xsl:value-of select="buyer_name"/></font>
				</td>
			</tr>
			<xsl:if test="buyer_bei[.!='']">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="buyer_bei"/></font></td>
				</tr>
			</xsl:if>
			<!--tr>
				<td width="40">&nbsp;</td>
				<td width="150">
					<font class="FORMMANDATORY">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_SELLER_BANK_BIC')"/>
					</font>
				</td>
				<td>
					<input type="text" size="11" maxlength="11" name="buyer_bank_bic" onblur="fncRestoreInputStyle('fakeform1','buyer_bank_bic');">
						<xsl:attribute name="value"><xsl:value-of select="buyer_bank_bic"/></xsl:attribute>
					</input>
				</td>
			</tr-->
			<xsl:if test="buyer_street_name[.!='']">
				<tr>
					<td>&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="buyer_street_name"/></font></td>
				</tr>
			</xsl:if>
			<xsl:if test="buyer_post_code[.!='']">
				<tr>
					<td>&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="buyer_post_code"/></font></td>
				</tr>
			</xsl:if>
			<xsl:if test="buyer_town_name[.!='']">
				<tr>
					<td>&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="buyer_town_name"/></font></td>
				</tr>
			</xsl:if>
			<xsl:if test="buyer_country_sub_div[.!='']">
				<tr>
					<td>&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="buyer_country_sub_div"/></font></td>
				</tr>
			</xsl:if>
			<xsl:if test="buyer_country[.!='']">
				<tr>
					<td>&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="buyer_country"/></font></td>
				</tr>
			</xsl:if>
		</table>
		
		<p><br/></p>
		
		<xsl:if test="bill_to_name[. != '']">
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
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="bill_to_name"/></font></td>
				</tr>
				<xsl:if test="bill_to_street_name[.!='']">
					<tr>
						<td>&nbsp;</td>
						<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="bill_to_street_name"/></font></td>
					</tr>
				</xsl:if>
				<xsl:if test="bill_to_post_code[.!='']">
					<tr>
						<td>&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="bill_to_post_code"/></font></td>
					</tr>
				</xsl:if>
				<xsl:if test="bill_to_town_name[.!='']">
					<tr>
						<td>&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="bill_to_town_name"/></font></td>
					</tr>
				</xsl:if>
				<xsl:if test="bill_to_country_sub_div[.!='']">
					<tr>
						<td>&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="bill_to_country_sub_div"/></font></td>
					</tr>
				</xsl:if>
				<xsl:if test="bill_to_country[.!='']">
					<tr>
						<td>&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="bill_to_country"/></font></td>
					</tr>
				</xsl:if>
			</table>
		</xsl:if>
		<!--Ship To Details-->
		<xsl:if test="ship_to_name[. != '']">
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="15">&nbsp;</td>
					<td class="FORMH2" align="left">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SHIP_TO_DETAILS')"/></b>
					</td>
				</tr>
			</table>
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="ship_to_name"/></font></td>
				</tr>
				<xsl:if test="ship_to_street_name[.!='']">
					<tr>
						<td>&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="ship_to_street_name"/></font></td>
					</tr>
				</xsl:if>
				<xsl:if test="ship_to_post_code[.!='']">
					<tr>
						<td>&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="ship_to_post_code"/></font></td>
					</tr>
				</xsl:if>
				<xsl:if test="ship_to_town_name[.!='']">
					<tr>
						<td>&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="ship_to_town_name"/></font></td>
					</tr>
				</xsl:if>
				<xsl:if test="ship_to_country_sub_div[.!='']">
					<tr>
						<td>&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="ship_to_country_sub_div"/></font></td>
					</tr>
				</xsl:if>
				<xsl:if test="ship_to_country[.!='']">
					<tr>
						<td>&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="ship_to_country"/></font></td>
					</tr>
				</xsl:if>
			</table>
		</xsl:if>
		<!--Consignee To Details-->
		<xsl:if test="consgn_name[. != '']">
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
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="consgn_name"/></font></td>
				</tr>
				<xsl:if test="consgn_street_name[.!='']">
					<tr>
						<td>&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="consgn_street_name"/></font></td>
					</tr>
				</xsl:if>
				<xsl:if test="consgn_post_code[.!='']">
					<tr>
						<td>&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="consgn_post_code"/></font></td>
					</tr>
				</xsl:if>
				<xsl:if test="consgn_town_name[.!='']">
					<tr>
						<td>&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="consgn_town_name"/></font></td>
					</tr>
				</xsl:if>
				<xsl:if test="consgn_country_sub_div[.!='']">
					<tr>
						<td>&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="consgn_country_sub_div"/></font></td>
					</tr>
				</xsl:if>
				<xsl:if test="consgn_country[.!='']">
					<tr>
						<td>&nbsp;</td>
						<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="consgn_country"/></font></td>
					</tr>
				</xsl:if>
			</table>
		</xsl:if>
								
		<br/>

		<!-- Goods / Line Items -->			
			
		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tr>
				<td class="FORMH1" colspan="3">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DESCRIPTION_GOODS')"/></b>
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
		
		<xsl:if test="goods_desc[.!='']">
			<table border="0" cellpadding="0" cellspacing="0" width="570">		
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_GOODS_DESC')"/></td>
					<td>
						<font class="REPORTDATA">
							<xsl:call-template name="string_replace">
								<xsl:with-param name="input_text" select="goods_desc"/>
							</xsl:call-template>
							<br/>
						</font>	
					</td>
				</tr>
			</table>
				
			<br/>
		
		</xsl:if>
		
		<xsl:if test="$section_po_line_items!='N'">
		
			<xsl:if test="count(line_items/lt_tnx_record) != 0">
				
				<!-- Line Items -->
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" colspan="3">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINE_ITEMS')"/></b>
						</td>
						<td align="right" class="FORMH2">
							<a href="#" name="line_item_header">
								<img border="0" src="/content/images/pic_up.gif">
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
								</img>
							</a>
						</td>
					</tr>
				</table>
					
				<!-- po line item template-->
			
				<xsl:apply-templates select="line_items" mode="controlled"/>
			
				<br/>
			
			</xsl:if>
		
		</xsl:if>
			
		<table border="0" cellpadding="0" cellspacing="0" width="570">		
			<!-- Total Line Items Amount -->
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL')"/></td>
				<td>
					<font class="REPORTDATA">
						<xsl:value-of select="total_cur_code"/>&nbsp;<xsl:value-of select="total_amt"/>
					</font>
				</td>
			</tr>
		</table>
		
		
		<p><br/></p>
		
		<!--Amount Details-->
		
		<xsl:if test="$section_po_amount_details!='N'">
			<xsl:if test="count(adjustments/allowance) != 0">
				
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="3">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_DETAILS')"/></b>
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
		
				<!-- Adjustments -->
				<xsl:if test="count(adjustments/allowance[allowance_type='02']) != 0">
					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
							<td width="15">&nbsp;</td>
							<td class="FORMH2" align="left">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ADJUSTMENTS_DETAILS')"/></b>
							</td>
							<td align="right" class="FORMH2">
								<a href="#">
									<img border="0" src="/content/images/pic_up.gif">
										<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
									</img>
								</a>
							</td>
						</tr>
					</table>
				
					<!-- po adjustment template-->
					<xsl:apply-templates select="adjustments" mode="controlled"/>
				
					<br/>
				</xsl:if>
		
				<!-- Taxes -->
				<xsl:if test="count(taxes/allowance[allowance_type='01']) != 0">
					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
							<td width="15">&nbsp;</td>
							<td class="FORMH2" align="left">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TAXES_DETAILS')"/></b>
							</td>
							<td align="right" class="FORMH2">
								<a href="#">
									<img border="0" src="/content/images/pic_up.gif">
										<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
									</img>
								</a>
							</td>
						</tr>
					</table>
				
					<!-- po tax templates-->
					<xsl:apply-templates select="taxes" mode="controlled"/>
					
					<br/>
				</xsl:if>
				
				<!-- Freight Charges -->
				<xsl:if test="count(freight_charges/allowance[allowance_type='03']) != 0">
					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
							<td width="15">&nbsp;</td>
							<td class="FORMH2" align="left">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREIGHT_CHARGES_DETAILS')"/></b>
							</td>
							<td align="right" class="FORMH2">
								<a href="#">
									<img border="0" src="/content/images/pic_up.gif">
										<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
									</img>
								</a>
							</td>
						</tr>
					</table>
				
					<br/>
				
					<table>
						<tr>
							<td width="40">&nbsp;</td>
							<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_FREIGHT_CHARGES_TYPE')"/></td>
							<!-- Freight Charges Type (Collect or Prepaid) -->
							<td>
								<font class="REPORTDATA">
								<xsl:choose>
									<xsl:when test="freight_charges_type[. = 'CLCT']">
										<xsl:value-of select="localization:getDecode($language, 'N211', 'CLCT')"/>
									</xsl:when>
									<xsl:when test="freight_charges_type[. = 'PRPD']">
										<xsl:value-of select="localization:getDecode($language, 'N211', 'PRPD')"/>
									</xsl:when>
									<xsl:otherwise/>
								</xsl:choose>
								</font>
							</td>	
						</tr>			
					</table>
				
					<!-- po freight charges template-->
					<xsl:apply-templates select="freight_charges" mode="controlled"/>
						
				</xsl:if>
		
				<xsl:if test="total_net_amt[.!='']">
					
					<p><br/></p>
					
					<table border="0" cellpadding="0" cellspacing="0" width="570">		
						<!-- Total Net Amount -->
						<tr>
							<td width="40">&nbsp;</td>
							<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_PO_TOTAL_NET_AMT_LABEL')"/></td>
							<td >
								<font class="REPORTDATA"><xsl:value-of select="total_net_cur_code"/>&nbsp;<xsl:value-of select="total_net_amt"/></font>
							</td>
						</tr>
					</table>
				
				</xsl:if>
				
				<br/>
				
			</xsl:if>
		</xsl:if>
		
		<!--Payment Terms Details-->
		<xsl:if test="$section_po_payment_terms!='N'">
			
			<xsl:if test="count(payments/payment) != 0">
				
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tbody>
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
					</tbody>
				</table>
				
				<!-- Payments templates-->
				<xsl:apply-templates select="payments" mode="controlled"/>
				
				<br/>
			
			</xsl:if>
		</xsl:if>
		
		<!--Settlement Terms Details-->
		<xsl:if test="$section_po_settlement_terms!='N'">
			
			<xsl:if test="seller_account_type[.!=''] or fin_inst_name[.!=''] or fin_inst_bic[.!='']">
			
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tbody>
						<tr>
							<td class="FORMH1" colspan="3">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SETTLEMENT_TERMS_DETAILS')"/></b>
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
			
				<xsl:if test="seller_account_iban[.!=''] or  seller_account_bban[.!=''] or  seller_account_upic[.!=''] or  seller_account_id[.!='']">
				
					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
							<td width="15">&nbsp;</td>
							<td class="FORMH2" align="left">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_SELLER_ACCOUNT')"/></b>
							</td>
							<td align="right" class="FORMH2">
								<a href="#">
									<img border="0" src="/content/images/pic_up.gif">
										<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
									</img>
								</a>
							</td>
						</tr>
					</table>
		
					<table border="0" cellspacing="0" width="570">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE')"/></td>
							<td>
								<font class="REPORTDATA">
									<xsl:choose>
										<xsl:when test="seller_account_iban[.!='']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN')"/>
										</xsl:when>
										<xsl:when test="seller_account_bban[.!='']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_BBAN')"/>
										</xsl:when>
										<xsl:when test="seller_account_upic[.!='']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_UPIC')"/>
										</xsl:when>
										<xsl:when test="seller_account_id[.!='']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_OTHER')"/>
										</xsl:when>
									</xsl:choose>
								</font>
							</td>
						</tr>
						<tr>
							<td width="40">&nbsp;</td>
							<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/></td>
							<td><font class="REPORTDATA"><xsl:value-of select="seller_account_name"/></font></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_SELLER_ACCOUNT_NUMBER')"/></td>
							<td>
								<font class="REPORTDATA">
									<xsl:choose>
										<xsl:when test="seller_account_iban[.!='']"><xsl:value-of select="seller_account_iban"/></xsl:when>
										<xsl:when test="seller_account_bban[.!='']"><xsl:value-of select="seller_account_bban"/></xsl:when>
										<xsl:when test="seller_account_upic[.!='']"><xsl:value-of select="seller_account_upic"/></xsl:when>
										<xsl:when test="seller_account_id[.!='']"><xsl:value-of select="seller_account_id"/></xsl:when>
										<xsl:otherwise/>
									</xsl:choose>
								</font>
							</td>
						</tr>
					</table>
					
					<br/>
			
				</xsl:if>
			
				<xsl:if test="fin_inst_name[.!=''] or fin_inst_bic[.!='']">
			
					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
							<td width="15">&nbsp;</td>
							<td class="FORMH2" align="left">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_FINANCIAL_INSTITUTION')"/></b>
							</td>
							<td align="right" class="FORMH2">
								<a href="#">
									<img border="0" src="/content/images/pic_up.gif">
										<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
									</img>
								</a>
							</td>
						</tr>
					</table>
			
					<table border="0" cellspacing="0" width="570">
						<xsl:if test="fin_inst_name[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="fin_inst_name"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="fin_inst_bic[.!='']">
							<tr>
								<td width="40">&nbsp;</td>
								<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BIC_CODE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="fin_inst_bic"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="fin_inst_street_name[.!='']">
							<tr>
								<td>&nbsp;</td>
								<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="fin_inst_street_name"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="fin_inst_post_code[.!='']">
							<tr>
								<td>&nbsp;</td>
								<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="fin_inst_post_code"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="fin_inst_town_name[.!='']">
							<tr>
								<td>&nbsp;</td>
								<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="fin_inst_town_name"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="fin_inst_country_sub_div[.!='']">
							<tr>
								<td>&nbsp;</td>
								<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="fin_inst_country_sub_div"/></font></td>
							</tr>
						</xsl:if>
						<xsl:if test="fin_inst_country[.!='']">
							<tr>
								<td>&nbsp;</td>
								<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/></td>
								<td><font class="REPORTDATA"><xsl:value-of select="fin_inst_country"/></font></td>
							</tr>
						</xsl:if>
					</table>
				
				</xsl:if>
			
			<p><br/></p>
			
			</xsl:if>
			
		</xsl:if>
    
		<!--Bank Details-->
		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tr>
				<td class="FORMH1" colspan="3">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BANK_DETAILS')"/></b>
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
		
		<xsl:apply-templates select="seller_bank">
			<xsl:with-param name="theNodeName" select="'seller_bank'"/>
			<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_SELLER_BANK')"/>
		</xsl:apply-templates>

		<xsl:if test="issuing_bank/name[.!='']">
			<br/>
			<xsl:apply-templates select="issuing_bank">
				<xsl:with-param name="theNodeName" select="'issuing_bank'"/>
				<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ISSUING_BANK')"/>
			</xsl:apply-templates>
		</xsl:if>
	
		<br/>
		
		<!--Inco Terms Details-->	
		<xsl:if test="$section_po_inco_terms!='N'">
			
			<xsl:if test="count(incoterms/incoterm) != 0">
						
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tbody>
						<tr>
							<td class="FORMH1" colspan="3">
								<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_INCO_TERMS_DETAILS')"/></b>
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
				
				<xsl:apply-templates select="incoterms" mode="controlled"/>
			
				<br/>
				
			</xsl:if>
			
		</xsl:if>
		
		
		<!--Routing Summary Details-->
		<xsl:if test="$section_po_routing_summary!='N'">
			
		<xsl:if test="count(/po_tnx_record/routing_summaries/routing_summary/transport_type) != 0">

		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tbody>
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
			</tbody>
		</table>
		
		<br/>
		
		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_ROUTING_SUMMARY_TRANSPORT_TYPE')"/></td>
				<td>
					<font class="REPORTDATA">
						<xsl:choose>
							<xsl:when test="count(/po_tnx_record/routing_summaries/routing_summary/transport_type[. = '01']) != 0">
								<xsl:value-of select="localization:getDecode($language, 'N213', '01')"/>
							</xsl:when>
							<xsl:when test="count(/po_tnx_record/routing_summaries/routing_summary/transport_type[. = '02']) != 0">
								<xsl:value-of select="localization:getDecode($language, 'N213', '02')"/>
							</xsl:when>
							<xsl:otherwise/>
						</xsl:choose>
					</font>
				</td>
			</tr>			
		</table>
		
		<!-- Routing Summary Individual section -->
		<div id="routing_summaries_individual">
			<xsl:attribute name="style">
				<xsl:if test="count(/po_tnx_record/routing_summaries/routing_summary/transport_type[. = '01']) = 0">display:none</xsl:if>
			</xsl:attribute>
			
			<table border="0" width="100%" cellspacing="0">
				<!-- Transport By Air -->
				<tr>
					<td>
						<xsl:apply-templates select="routing_summaries/routing_summary[transport_mode='01' and transport_type='01'][1]" mode="controlled">
							<xsl:with-param name="structure_name">po_routing_summary_individual_air</xsl:with-param>
							<xsl:with-param name="form_name">form_routing_summaries_individual</xsl:with-param>					
						</xsl:apply-templates>		
					</td>
				</tr>
				<!-- Transport By Sea -->
				<tr>
					<td>
						<xsl:apply-templates select="routing_summaries/routing_summary[transport_mode='02' and transport_type='01'][1]" mode="controlled">
							<xsl:with-param name="structure_name">po_routing_summary_individual_sea</xsl:with-param>
							<xsl:with-param name="form_name">form_routing_summaries_individual</xsl:with-param>
						</xsl:apply-templates>					
					</td>
				</tr>
				<!-- Transport By Road -->
				<tr>
					<td>
						<xsl:apply-templates select="routing_summaries/routing_summary[transport_mode='03' and transport_type='01'][1]" mode="controlled">
							<xsl:with-param name="structure_name">po_routing_summary_individual_road</xsl:with-param>
							<xsl:with-param name="form_name">form_routing_summaries_individual</xsl:with-param>
						</xsl:apply-templates>				
					</td>
				</tr>
				<!-- Transport By Rail -->
				<tr>
					<td>
					<xsl:apply-templates select="routing_summaries/routing_summary[transport_mode='04' and transport_type='01'][1]" mode="controlled">
							<xsl:with-param name="structure_name">po_routing_summary_individual_rail</xsl:with-param>
							<xsl:with-param name="form_name">form_routing_summaries_individual</xsl:with-param>
					</xsl:apply-templates>
					</td>
				</tr>								
			</table>
			
		</div>
		
		<!-- Routing Summary Multimodal section -->
		<div id="routing_summaries_multimodal">
			<xsl:attribute name="style">
				<xsl:if test="count(/po_tnx_record/routing_summaries/routing_summary/transport_type[. = '02']) = 0">display:none</xsl:if>
			</xsl:attribute>
			
			<table border="0" width="100%" cellspacing="0">
				<tr>
					<td>
						<!-- Airports -->
						<!--<xsl:call-template name="routing_summary_multimodal_airport_rep"/>-->
						<xsl:apply-templates select="routing_summaries/routing_summary[transport_type='02' and transport_mode='01'][1]" mode="controlled"/>
							</td>
						</tr>
				<tr>
						<!-- Ports -->
							<td>
						<!--<xsl:call-template name="routing_summary_multimodal_port_rep"/>-->
						<xsl:apply-templates select="routing_summaries/routing_summary[transport_type='02' and transport_mode='02'][1]" mode="controlled"/>
							</td>
						</tr>
				<tr>	
						<!-- Places -->
							<td>
						<!--<xsl:call-template name="routing_summary_multimodal_place_rep"/>-->
						<xsl:apply-templates select="routing_summaries/routing_summary[transport_type='02' and  transport_mode='' and taking_in_charge ='' and place_final_dest=''][1]" mode="controlled"/>
							</td>
						</tr>
				<tr>
						<!-- Taking In Charge -->
							<td>
						<!--<xsl:call-template name="routing_summary_multimodal_taking_in_charge_rep"/>-->
						<xsl:apply-templates select="routing_summaries/routing_summary[transport_type='02' and taking_in_charge !=''][1]" mode="controlled"/>
							</td>
						</tr>
				<tr>
						<!-- Place Of Final Destination -->
							<td>
						<!--<xsl:call-template name="routing_summary_multimodal_place_final_dest_rep"/>-->
						<xsl:apply-templates select="routing_summaries/routing_summary[transport_type='02' and place_final_dest !='']" mode="controlled"/>
							</td>
						</tr>																		
			</table>
			
		</div>	
		
		<p><br/></p>
		
		</xsl:if>
		
		</xsl:if>
		
	</form>

		</xsl:when>
		<xsl:otherwise>
			<!-- If the case is Pending, we simply create the fakeform1 -->
			<form name="fakeform1">
				<input type="hidden" name="company_id"><xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute></input>
      		<input type="hidden" name="brch_code"><xsl:attribute name="value"><xsl:value-of select="brch_code"/></xsl:attribute></input>
              <!-- old_ctl_date used to check the transaction has not been modified in between -->
      		<input type="hidden" name="old_ctl_dttm"><xsl:attribute name="value"><xsl:value-of select="bo_ctl_dttm"/></xsl:attribute></input>
			</form>
		</xsl:otherwise>
	</xsl:choose>
		
	<!-- View Transaction Details - END -->

	</td>
	</tr>
	</table>
	
	</td>
	</tr>
	</table>

	</xsl:template>

</xsl:stylesheet>
