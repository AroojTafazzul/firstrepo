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
   Copyright (c) 2000-2007 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

<xsl:import href="po_common.xsl"/>
<xsl:import href="../../core/xsl/common/bank_common.xsl"/>
<xsl:import href="../../core/xsl/common/trade_common.xsl"/>	<!-- This is to include the CHARGE_DETAILS_HIDDEN template -->
<xsl:import href="../../core/xsl/common/com_cross_references.xsl"/>

<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	
	<!-- All marks used to shown/hidden form's sections-->
	<xsl:param name="section_po_line_items"/>
	<xsl:param name="section_po_amount_details"/>
	<xsl:param name="section_po_payment_terms"/>
	<xsl:param name="section_po_settlement_terms"/>
	<xsl:param name="section_po_documents_required"/>
	<xsl:param name="section_po_shipment_details"/>
	<xsl:param name="section_po_inco_terms"/>
	<xsl:param name="section_po_routing_summary"/>
	<xsl:param name="section_po_user_info"/>
	<xsl:param name="section_po_contact"/>
	
	<xsl:param name="section_li_product"/>
	<xsl:param name="section_li_amount_details"/>
	<xsl:param name="section_li_shipment_details"/>
	<xsl:param name="section_li_inco_terms"/>
	<xsl:param name="section_li_routing_summary"/>
	
	<xsl:template match="/">
		<xsl:apply-templates select="so_tnx_record"/>
	</xsl:template>

	<!--TEMPLATE Main-->

	<xsl:template match="so_tnx_record">

	<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"></script>
	<script type="text/javascript">
		<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
	</script>
	<script type="text/javascript" src="/content/OLD/javascript/com_currency.js"></script>
	<script type="text/javascript" src="/content/OLD/javascript/bank_common_reporting.js"></script>
	<script type="text/javascript" src="/content/OLD/javascript/openaccount/bank_so_reporting.js"></script>
	<script type="text/javascript" src="/content/OLD/javascript/openaccount/com_functions_po.js"></script>
	<script type="text/javascript" src="/content/OLD/javascript/com_amount.js"></script>
	<script type="text/javascript" src="/content/OLD/javascript/com_date.js"></script>
	
	<table border="0" width="100%" cellspacing="2" cellpadding="4" class="FORMTABLEBORDER">
	<tr>
	<td class="FORMTABLE" align="center">
	
	<table border="0">

	<!-- Display Common Reporting Input Area -->
	
	<xsl:call-template name="bank_reporting_area"/>
	
	<!-- Edit SO Transaction Details - BEGIN -->

	<tr>
	<td align="left">
	
	<xsl:choose>
		<xsl:when test="tnx_type_code[.!='01']">
			<!-- Creation of new SO Notification, we always show the transaction details -->
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="20">&nbsp;</td>
					<td>
						<a id="EditTransactionDetails" href="javascript:void(0)">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_EDIT_TRANSACTION')"/>
						</a>
					</td>
			   </tr>
			</table>
			
			<p><br/></p>
			
			<script type="text/javascript">
			<![CDATA[
				document.write("<div id='divTransactionDetails' style='display: none'>");
			]]>
			</script>
		</xsl:when>
		<xsl:otherwise>
			<hr/>
			<p><b><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></b></p>
		</xsl:otherwise>
	</xsl:choose>
	
	<form name="fakeform1" onsubmit="return false;">

		<!--Insert the Tnx Amount as hidden field-->
	
		<input type="hidden" name="brch_code"><xsl:attribute name="value"><xsl:value-of select="brch_code"/></xsl:attribute></input>
		<input type="hidden" name="company_id"><xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute></input>
		<input type="hidden" name="company_name"><xsl:attribute name="value"><xsl:value-of select="company_name"/></xsl:attribute></input>
		<input type="hidden" name="tnx_id"><xsl:attribute name="value"><xsl:value-of select="tnx_id"/></xsl:attribute></input>
		<input type="hidden" name="tnx_amt"><xsl:attribute name="value"><xsl:value-of select="tnx_amt"/></xsl:attribute></input>
		<input type="hidden" name="tnx_cur_code"><xsl:attribute name="value"><xsl:value-of select="tnx_cur_code"/></xsl:attribute></input>
		<!-- old_ctl_date used to check the transaction has not been modified in between -->
		<input type="hidden" name="old_ctl_dttm"><xsl:attribute name="value"><xsl:value-of select="bo_ctl_dttm"/></xsl:attribute></input>
			
			
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
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TEMPLATE_ID')"/></td>
				<td>
					<input type="text" size="15" maxlength="20" name="template_id" onblur="fncValidateTemplateId(this);fncRestoreInputStyle('fakeform1','template_id');">
						<xsl:attribute name="value"><xsl:value-of select="template_id"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<!--tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/></td>
				<td>
					<input type="text" size="15" maxlength="34" name="cust_ref_id" onblur="fncRestoreInputStyle('fakeform1','cust_ref_id');">
						<xsl:attribute name="value"><xsl:value-of select="cust_ref_id"/></xsl:attribute>
					</input>
				</td>
			</tr-->
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ISSUER_REF_ID')"/></td>
				<td>
					<input type="text" size="20" maxlength="35" name="issuer_ref_id" onblur="fncRestoreInputStyle('fakeform1','issuer_ref_id');">
						<xsl:attribute name="value"><xsl:value-of select="issuer_ref_id"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')"/></td>
				<td>
					<font class="REPORTDATA"><xsl:value-of select="appl_date"/></font>
					<input type="hidden" name="appl_date"><xsl:attribute name="value"><xsl:value-of select="appl_date"/></xsl:attribute></input>
				</td>
			</tr>
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150">
					<font class="FORMMANDATORY">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ISSUE_DATE')"/>
					</font>
				</td>
				<td>
					<input type="text" size="10" maxlength="10" name="iss_date" onblur="fncRestoreInputStyle('fakeform1','iss_date');fncCheckIssueDate(this);">
						<xsl:attribute name="value"><xsl:value-of select="iss_date"/></xsl:attribute>
					</input><script>DateInput('iss_date','<xsl:value-of select="iss_date"/>')</script>
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150">
					<font class="FORMMANDATORY">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TID')"/>
					</font>
				</td>
				<td>
					<input type="text" size="35" maxlength="35" name="tid" onblur="fncRestoreInputStyle('fakeform1','tid');">
						<xsl:attribute name="value"><xsl:value-of select="tid"/></xsl:attribute>
					</input>
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
				<xsl:if test="tnx_type_code[.='01']">
					<td class="FORMH2" align="right">
						<a name="anchor_search_seller" href="javascript:void(0)">
						<xsl:attribute name="onclick">fncEntityPopup('entity', 'fakeform1',"['company_id','seller_abbv_name','entity','seller_name', 'seller_bei', 'seller_street_name','seller_post_code','seller_town_name','seller_country_sub_div', 'seller_country']",'<xsl:value-of select="product_code"/>','','','BASELINE_CUSTOMER');return false;</xsl:attribute>
							<img border="0" src="/content/images/search.png" name="img_search_seller">
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_SELLER')"/>	</xsl:attribute>
							</img>
						</a>
					</td>	
				</xsl:if>
			</tr>
		</table>
		<table border="0" cellspacing="0" width="570">
		<xsl:choose>
			<xsl:when test="tnx_type_code[.='01']">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ENTITY')"/>
					</td>
					<td>
						<input type="text" size="35" maxlength="35" name="entity" onfocus="this.blur()">
							<xsl:attribute name="value"><xsl:value-of select="entity"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150">
						<font class="FORMMANDATORY">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ABBV_NAME')"/>
						</font>
					</td>
					<td>
						<input type="text" size="35" maxlength="35" name="seller_abbv_name" onfocus="this.blur();" onblur="fncRestoreInputStyle('fakeform1','seller_abbv_name');">
							<xsl:attribute name="value"><xsl:value-of select="seller_abbv_name"/></xsl:attribute>
						</input>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
			  <xsl:if test="entity[. !='']">
			  <tr>
				<td width="40">&nbsp;</td>
				<td width="150">
				  <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ENTITY')"/>
				</td>
				<td>
				  <font class="REPORTDATA"><xsl:value-of select="entity"/></font>
				</td>
			  </tr>
				</xsl:if>
			</xsl:otherwise>
		  </xsl:choose>
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150">
					<font class="FORMMANDATORY">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
					</font>
				</td>
				<td>
					<input type="text" size="35" maxlength="35" name="seller_name" onblur="fncRestoreInputStyle('fakeform1','seller_name');">
						<xsl:attribute name="value"><xsl:value-of select="seller_name"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<!--tr>
				<td width="40">&nbsp;</td>
				<td width="150">
					<font class="FORMMANDATORY">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_SELLER_BANK_BIC')"/>
					</font>
				</td>
				<td>
					<input type="text" size="11" maxlength="11" name="seller_bank_bic" onblur="fncRestoreInputStyle('fakeform1','seller_bank_bic');fncCheckBICFormat(this);">
						<xsl:attribute name="value"><xsl:value-of select="seller_bank_bic"/></xsl:attribute>
					</input>
				</td>
			</tr-->
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150">
					<!--font class="FORMMANDATORY"-->
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/>
					<!--/font-->
				</td>
				<td>
					<input type="text" size="11" maxlength="11" name="seller_bei" onblur="fncRestoreInputStyle('fakeform1','seller_bei');fncCheckBEIFormat(this);">
						<xsl:attribute name="value"><xsl:value-of select="seller_bei"/></xsl:attribute>
					</input>
				</td>
			</tr>

			<tr>
				<td>&nbsp;</td>
				<td>
					<!--font class="FORMMANDATORY"-->
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
					<!--/font-->
				</td>
				<td>
					<input type="text" size="35" maxlength="70" name="seller_street_name" onblur="fncRestoreInputStyle('fakeform1','seller_street_name');">
						<xsl:attribute name="value"><xsl:value-of select="seller_street_name"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<font class="FORMMANDATORY">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
					</font>
				</td>
				<td>
					<input type="text" size="16" maxlength="16" name="seller_post_code" onblur="fncRestoreInputStyle('fakeform1','seller_post_code');">
						<xsl:attribute name="value"><xsl:value-of select="seller_post_code"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<font class="FORMMANDATORY">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
					</font>
				</td>
				<td>
					<input type="text" size="35" maxlength="35" name="seller_town_name" onblur="fncRestoreInputStyle('fakeform1','seller_town_name');">
						<xsl:attribute name="value"><xsl:value-of select="seller_town_name"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/></td>
				<td>
					<input type="text" size="35" maxlength="35" name="seller_country_sub_div" onblur="fncRestoreInputStyle('fakeform1','seller_country_sub_div');">
						<xsl:attribute name="value"><xsl:value-of select="seller_country_sub_div"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<font class="FORMMANDATORY">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
					</font>
				</td>
				<td>
					<input type="text" size="2" maxlength="2" name="seller_country" onblur="fncRestoreInputStyle('fakeform1','seller_country');fncCheckCountryCode(this);">
						<xsl:attribute name="value"><xsl:value-of select="seller_country"/></xsl:attribute>
					</input>&nbsp;
					<a name="anchor_search_country" href="javascript:void(0)">
						<xsl:attribute name="onclick">fncSearchPopup('codevalue', 'fakeform1',"['seller_country']",'C006');return false;</xsl:attribute>
						<img border="0" src="/content/images/search.png" name="img_search_country">
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_COUNTRY')"/></xsl:attribute>
						</img>
					</a>
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
					<a name="anchor_search_buyer" href="javascript:void(0)">
						<xsl:attribute name="onclick">fncSearchPopup('beneficiary', 'fakeform1',"['buyer_name', 'buyer_bei', 'buyer_street_name', 'buyer_post_code', 'buyer_town_name', 'buyer_country_sub_div', 'buyer_country']", '', 'BaseLineListPopup', '<xsl:value-of select="product_code"/>');return false;</xsl:attribute>
						<img border="0" src="/content/images/search.png" name="img_search_buyer">
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_BENEFICIARY')"/></xsl:attribute>
						</img>
					</a>
				</td>
			</tr>
		</table>
		<table border="0" cellspacing="0" width="570">
			<input type="hidden" name="buyer_abbv_name">
				<xsl:attribute name="value"><xsl:value-of select="buyer_abbv_name"/></xsl:attribute>
			</input>
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150">
					<font class="FORMMANDATORY">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
					</font>
				</td>
				<td>
					<input type="text" size="35" maxlength="35" name="buyer_name" onblur="fncRestoreInputStyle('fakeform1','buyer_name');">
						<xsl:attribute name="value"><xsl:value-of select="buyer_name"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150">
					<!--font class="FORMMANDATORY"-->
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/>
					<!--/font-->
				</td>
				<td>
					<input type="text" size="11" maxlength="11" name="buyer_bei" onblur="fncRestoreInputStyle('fakeform1','buyer_bei');fncCheckBEIFormat(this);">
						<xsl:attribute name="value"><xsl:value-of select="buyer_bei"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<!--font class="FORMMANDATORY"-->
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
					<!--/font-->
				</td>
				<td>
					<input type="text" size="35" maxlength="70" name="buyer_street_name" onblur="fncRestoreInputStyle('fakeform1','buyer_street_name');">
						<xsl:attribute name="value"><xsl:value-of select="buyer_street_name"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<font class="FORMMANDATORY">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
					</font>
				</td>
				<td>
					<input type="text" size="16" maxlength="16" name="buyer_post_code" onblur="fncRestoreInputStyle('fakeform1','buyer_post_code');">
						<xsl:attribute name="value"><xsl:value-of select="buyer_post_code"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<font class="FORMMANDATORY">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
					</font>
				</td>
				<td>
					<input type="text" size="35" maxlength="35" name="buyer_town_name" onblur="fncRestoreInputStyle('fakeform1','buyer_town_name');">
						<xsl:attribute name="value"><xsl:value-of select="buyer_town_name"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/></td>
				<td>
					<input type="text" size="35" maxlength="34" name="buyer_country_sub_div" onblur="fncRestoreInputStyle('fakeform1','buyer_country_sub_div');">
						<xsl:attribute name="value"><xsl:value-of select="buyer_country_sub_div"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<font class="FORMMANDATORY">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
					</font>
				</td>
				<td>
					<input type="text" size="2" maxlength="2" name="buyer_country" onblur="fncRestoreInputStyle('fakeform1','buyer_country');fncCheckCountryCode(this);">
						<xsl:attribute name="value"><xsl:value-of select="buyer_country"/></xsl:attribute>
					</input>&nbsp;
					<a name="anchor_search_country" href="javascript:void(0)">
						<xsl:attribute name="onclick">fncSearchPopup('codevalue', 'fakeform1',"['buyer_country']",'C006');return false;</xsl:attribute>
						<img border="0" src="/content/images/search.png" name="img_search_country">
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_COUNTRY')"/></xsl:attribute>
						</img>
					</a>
				</td>
			</tr>
		</table>
		
		<p><br/></p>
		
		<table border="0" cellspacing="0" width="570">
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_DISPLAY_OTHER_PARTIES')"/>
				</td>
				<td>
					<input type="checkbox" name="display_other_parties">
						<xsl:if test="bill_to_name[. != ''] or ship_to_name[. != ''] or consgn_to_name[. != '']">
							<xsl:attribute name="checked"/>
						</xsl:if>
						<xsl:attribute name="onclick">fncShowOtherParties();</xsl:attribute>
					</input>
				</td>
			</tr>
		</table>
		
		<br/>
		
		<!--div id='divOtherParties' style='position:relative'-->
		<div id='divOtherParties'>
			<xsl:attribute name="style">
				<xsl:choose>
					<xsl:when test="bill_to_name[. != ''] or ship_to_name[. != ''] or consgn_to_name[. != '']">display:block</xsl:when>
					<xsl:otherwise>display:none</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			
			<br/>

			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td id="cell_bill_to" width="175" height="25" align="center">
						<xsl:attribute name="style">background-image: url(/content/images/tab_on<xsl:if test="bill_to_name[.!='']">_sel</xsl:if>.gif)</xsl:attribute>
						<a href="javascript:void(0)" onclick="fncShowTab(2,'bill_to','','_name','fakeform1');return false;" style="text-decoration: none">
							<font class="FORMTAB">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BILL_TO_DETAILS')"/>
							</font>
						</a>
					</td>
					<td id="cell_ship_to" width="175" height="25" align="center">
						<xsl:attribute name="style">background-image: url(/content/images/tab_off<xsl:if test="ship_to_name[.!='']">_sel</xsl:if>.gif)</xsl:attribute>
						<a href="javascript:void(0)" onclick="fncShowTab(2,'ship_to','','_name','fakeform1');return false;" style="text-decoration: none">
							<font class="FORMTAB">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SHIP_TO_DETAILS')"/>
							</font>
						</a>
					</td>		
					<td id="cell_consgn" width="175" height="25" align="center">
						<xsl:attribute name="style">background-image: url(/content/images/tab_off<xsl:if test="consgn_name[.!='']">_sel</xsl:if>.gif)</xsl:attribute>
						<a href="javascript:void(0)" onclick="fncShowTab(2,'consgn','','_name','fakeform1');return false;" style="text-decoration: none">
							<font class="FORMTAB">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONSIGNEE_DETAILS')"/>
							</font>
						</a>
					</td>			
				</tr>
				<tr>
					<td class="FORMH1" colspan="3" height="4"><table border="0" width="100%" cellpadding="0" cellspacing="0"><tr><td></td></tr></table></td>
				</tr>
			</table>

			<table border="0" width="570" height="200">
				<tr>
					<td valign="top">
						<!--Bill To Details-->
						<div id='div_bill_to' style='display: block'>
							<table border="0" cellspacing="0" width="570">
								<input type="hidden" name="bill_to_abbv_name">
														<xsl:attribute name="value"><xsl:value-of select="bill_to_abbv_name"/></xsl:attribute>
								</input>
								<tr>
									<td width="40">&nbsp;</td>
									<td width="150">
										<font class="FORMMANDATORY">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
										</font>
									</td>
									<td>
										<input type="text" size="35" maxlength="35" name="bill_to_name" onblur="fncRestoreInputStyle('fakeform1','bill_to_name');">
											<xsl:attribute name="value"><xsl:value-of select="bill_to_name"/></xsl:attribute>
										</input>
									</td>
									<td align="right">
										<a name="anchor_search_seller" href="javascript:void(0)">
											<xsl:attribute name="onclick">fncSearchPopup('beneficiary', 'fakeform1',"['bill_to_name', 'bill_to_post_code', 'bill_to_town_name', 'bill_to_country']",'', 'BaseLineListPopup', '<xsl:value-of select="product_code"/>');return false;</xsl:attribute>
											<img border="0" src="/content/images/search.png" name="img_search_counterparty">
												<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_BENEFICIARY')"/></xsl:attribute>
											</img>
										</a>
									</td>
								</tr>
								<!--tr>
									<td width="40">&nbsp;</td>
									<td width="150">
										<font class="FORMMANDATORY">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/>
										</font>
									</td>
									<td>
										<input type="text" size="11" maxlength="11" name="bill_to_bei" onblur="fncRestoreInputStyle('fakeform1','bill_to_bei');fncCheckBEIFormat(this);">
											<xsl:attribute name="value"><xsl:value-of select="bill_to_bei"/></xsl:attribute>
										</input>
									</td>
								</tr-->
								<tr>
									<td>&nbsp;</td>
									<td>
										<!--font class="FORMMANDATORY"-->
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
										<!--/font-->
									</td>
									<td>
										<input type="text" size="35" maxlength="70" name="bill_to_street_name" onblur="fncRestoreInputStyle('fakeform1','bill_to_street_name');">
											<xsl:attribute name="value"><xsl:value-of select="bill_to_street_name"/></xsl:attribute>
										</input>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>
										<font class="FORMMANDATORY">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
										</font>
									</td>
									<td>
										<input type="text" size="16" maxlength="16" name="bill_to_post_code" onblur="fncRestoreInputStyle('fakeform1','bill_to_post_code');">
											<xsl:attribute name="value"><xsl:value-of select="bill_to_post_code"/></xsl:attribute>
										</input>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>
										<font class="FORMMANDATORY">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
										</font>
									</td>
									<td>
										<input type="text" size="35" maxlength="35" name="bill_to_town_name" onblur="fncRestoreInputStyle('fakeform1','bill_to_town_name');">
											<xsl:attribute name="value"><xsl:value-of select="bill_to_town_name"/></xsl:attribute>
										</input>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/></td>
									<td>
										<input type="text" size="35" maxlength="34" name="bill_to_country_sub_div" onblur="fncRestoreInputStyle('fakeform1','bill_to_country_sub_div');">
											<xsl:attribute name="value"><xsl:value-of select="bill_to_country_sub_div"/></xsl:attribute>
										</input>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>
										<font class="FORMMANDATORY">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
										</font>
									</td>
									<td>
										<input type="text" size="2" maxlength="2" name="bill_to_country" onblur="fncRestoreInputStyle('fakeform1','bill_to_country');fncCheckCountryCode(this);">
											<xsl:attribute name="value"><xsl:value-of select="bill_to_country"/></xsl:attribute>
										</input>
									</td>
								</tr>
							</table>
						</div>
						<!--Ship To Details-->
						<div id='div_ship_to' style='display: none'>
							<table border="0" cellspacing="0" width="570">
								<input type="hidden" name="ship_to_abbv_name">
									<xsl:attribute name="value"><xsl:value-of select="ship_to_abbv_name"/></xsl:attribute>
								</input>
								<tr>
									<td width="40">&nbsp;</td>
									<td width="150">
										<font class="FORMMANDATORY">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
										</font>
									</td>
									<td>
										<input type="text" size="35" maxlength="35" name="ship_to_name" onblur="fncRestoreInputStyle('fakeform1','ship_to_name');">
											<xsl:attribute name="value"><xsl:value-of select="ship_to_name"/></xsl:attribute>
										</input>
									</td>
									<td align="right">
										<a name="anchor_search_seller" href="javascript:void(0)">
											<xsl:attribute name="onclick">fncSearchPopup('beneficiary', 'fakeform1',"['ship_to_name', 'ship_to_post_code', 'ship_to_town_name', 'ship_to_country']",'', 'BaseLineListPopup', '<xsl:value-of select="product_code"/>');return false;</xsl:attribute>
											<img border="0" src="/content/images/search.png" name="img_search_counterparty">
												<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_BENEFICIARY')"/></xsl:attribute>
											</img>
										</a>
									</td>
								</tr>
								<!--tr>
									<td width="40">&nbsp;</td>
									<td width="150">
										<font class="FORMMANDATORY">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/>
										</font>
									</td>
									<td>
										<input type="text" size="11" maxlength="11" name="ship_to_bei" onblur="fncRestoreInputStyle('fakeform1','ship_to_bei');fncCheckBEIFormat(this);">
											<xsl:attribute name="value"><xsl:value-of select="ship_to_bei"/></xsl:attribute>
										</input>
									</td>
								</tr-->
								<tr>
									<td>&nbsp;</td>
									<td>
										<!--font class="FORMMANDATORY"-->
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
										<!--/font-->
									</td>
									<td>
										<input type="text" size="35" maxlength="70" name="ship_to_street_name" onblur="fncRestoreInputStyle('fakeform1','bill_to_street_name');">
											<xsl:attribute name="value"><xsl:value-of select="ship_to_street_name"/></xsl:attribute>
										</input>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>
										<font class="FORMMANDATORY">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
										</font>
									</td>
									<td>
										<input type="text" size="16" maxlength="16" name="ship_to_post_code" onblur="fncRestoreInputStyle('fakeform1','bill_to_post_code');">
											<xsl:attribute name="value"><xsl:value-of select="ship_to_post_code"/></xsl:attribute>
										</input>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>
										<font class="FORMMANDATORY">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
										</font>
									</td>
									<td>
										<input type="text" size="35" maxlength="35" name="ship_to_town_name" onblur="fncRestoreInputStyle('fakeform1','bill_to_town_name');">
											<xsl:attribute name="value"><xsl:value-of select="ship_to_town_name"/></xsl:attribute>
										</input>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/></td>
									<td>
										<input type="text" size="35" maxlength="35" name="ship_to_country_sub_div" onblur="fncRestoreInputStyle('fakeform1','bill_to_country_sub_div');">
											<xsl:attribute name="value"><xsl:value-of select="ship_to_country_sub_div"/></xsl:attribute>
										</input>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>
										<font class="FORMMANDATORY">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
										</font>
									</td>
									<td>
										<input type="text" size="2" maxlength="2" name="ship_to_country" onblur="fncRestoreInputStyle('fakeform1','bill_to_country');fncCheckCountryCode(this);">
											<xsl:attribute name="value"><xsl:value-of select="ship_to_country"/></xsl:attribute>
										</input>
									</td>
								</tr>
							</table>
						</div>
						<!--Consignee To Details-->
						<div id='div_consgn' style='display: none'>
							<table border="0" cellspacing="0" width="570">
								<input type="hidden" name="consgn_abbv_name">
									<xsl:attribute name="value"><xsl:value-of select="consgn_abbv_name"/></xsl:attribute>
								</input>
								<tr>
									<td width="40">&nbsp;</td>
									<td width="150">
										<font class="FORMMANDATORY">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
										</font>
									</td>
									<td>
										<input type="text" size="35" maxlength="35" name="consgn_name" onblur="fncRestoreInputStyle('fakeform1','consgn_name');">
											<xsl:attribute name="value"><xsl:value-of select="consgn_name"/></xsl:attribute>
										</input>
									</td>
									<td align="right">
										<a name="anchor_search_seller" href="javascript:void(0)">
											<xsl:attribute name="onclick">fncSearchPopup('beneficiary', 'fakeform1',"['consgn_name', 'consgn_post_code', 'consgn_town_name', 'consgn_country']",'', 'BaseLineListPopup', '<xsl:value-of select="product_code"/>');return false;</xsl:attribute>
											<img border="0" src="/content/images/search.png" name="img_search_counterparty">
												<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_BENEFICIARY')"/></xsl:attribute>
											</img>
										</a>
									</td>
								</tr>
								<!--tr>
									<td width="40">&nbsp;</td>
									<td width="150">
										<font class="FORMMANDATORY">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/>
										</font>
									</td>
									<td>
										<input type="text" size="11" maxlength="11" name="consgn_bei" onblur="fncRestoreInputStyle('fakeform1','consgn_bei');fncCheckBEIFormat(this);">
											<xsl:attribute name="value"><xsl:value-of select="consgn_bei"/></xsl:attribute>
										</input>
									</td>
								</tr-->
								<tr>
									<td>&nbsp;</td>
									<td>
										<!--font class="FORMMANDATORY"-->
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
										<!--/font-->
									</td>
									<td>
										<input type="text" size="35" maxlength="70" name="consgn_street_name" onblur="fncRestoreInputStyle('fakeform1','consgn_street_name');">
											<xsl:attribute name="value"><xsl:value-of select="consgn_street_name"/></xsl:attribute>
										</input>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>
										<font class="FORMMANDATORY">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
										</font>
									</td>
									<td>
										<input type="text" size="16" maxlength="16" name="consgn_post_code" onblur="fncRestoreInputStyle('fakeform1','consgn_post_code');">
											<xsl:attribute name="value"><xsl:value-of select="consgn_post_code"/></xsl:attribute>
										</input>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>
										<font class="FORMMANDATORY">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
										</font>
									</td>
									<td>
										<input type="text" size="35" maxlength="35" name="consgn_town_name" onblur="fncRestoreInputStyle('fakeform1','consgn_town_name');">
											<xsl:attribute name="value"><xsl:value-of select="consgn_town_name"/></xsl:attribute>
										</input>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/></td>
									<td>
										<input type="text" size="35" maxlength="35" name="consgn_country_sub_div" onblur="fncRestoreInputStyle('fakeform1','consgn_country_sub_div');">
											<xsl:attribute name="value"><xsl:value-of select="consgn_country_sub_div"/></xsl:attribute>
										</input>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>
										<font class="FORMMANDATORY">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
										</font>
									</td>
									<td>
										<input type="text" size="2" maxlength="2" name="consgn_country" onblur="fncRestoreInputStyle('fakeform1','consgn_country');fncCheckCountryCode(this);">
											<xsl:attribute name="value"><xsl:value-of select="consgn_country"/></xsl:attribute>
										</input>
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
			</table>
		</div>
	
		<!-- end of fakeform1 -->
		</form>
		
		<br/>

		<!-- Goods / Line Items -->			
		<form name="form_goods">
			
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
		
		<table border="0" cellpadding="0" cellspacing="0" width="570">		
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_GOODS_DESC')"/></td>
				<td>
					<textarea wrap="hard" cols="35" rows="2" name="goods_desc">
						<xsl:attribute name="onblur">fncRestoreInputStyle('form_goods','goods_desc');fncFormatTextarea(this,2,35);</xsl:attribute>
						<xsl:value-of select="goods_desc"/>
					</textarea>		
				</td>
			</tr>
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150">
					<font class="FORMMANDATORY">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_CURRENCY_CODE')"/>
					</font>
				</td>
				<td width="10%">
					<input type="text" size="3" maxlength="3" name="total_cur_code" onblur="fncRestoreInputStyle('form_goods','total_cur_code');fncCheckValidCurrency(this);fncFormatAmount(document.forms['form_goods'].total_amt,fncGetCurrencyDecNo(this.value));document.forms['fakeform1'].tnx_amt.value=document.forms['form_goods'].total_amt.value;document.forms['fakeform1'].tnx_cur_code.value=this.value;fncUpdatePOCurrency(arrUpdatedElements,this.value);">
						<xsl:attribute name="value"><xsl:value-of select="total_cur_code"/></xsl:attribute>
					</input>&nbsp;
					<a name="anchor_search_po_currency" href="javascript:void(0)">
						<xsl:attribute name="onclick">fncSearchPopup('currency', 'form_goods',"['total_cur_code']");return false;</xsl:attribute>
						<img border="0" src="/content/images/search.png" name="img_search_po_currency">
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
						</img>
					</a>
				</td>
							
			</tr>
		</table>
			
		<br/>
		
		<xsl:if test="$section_po_line_items!='N'">
		
			
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
			
		<br/>
			
		<xsl:apply-templates select="line_items">	
			<xsl:with-param name="structure_name">po_line_item</xsl:with-param>
			<xsl:with-param name="form_name">form_goods</xsl:with-param>
			<xsl:with-param name="option"><xsl:value-of select="$option"/></xsl:with-param>
		</xsl:apply-templates>
	
		<xsl:if test="$section_li_product!='N'">
		<!-- po line items product identifiers template -->
		<div style="display:none;">
			<xsl:attribute name="id">po_line_item_product_identifier_div_template</xsl:attribute>
			<table>
				<tbody>
					<xsl:attribute name="id">po_line_item_product_identifier_template</xsl:attribute>
					<xsl:call-template name="PO_PRODUCT_IDENTIFIERS_DETAILS">
						<xsl:with-param name="structure_name">po_line_item_product_identifier</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_goods</xsl:with-param>
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<div style="display:none;">
			<xsl:attribute name="id">po_line_item_product_identifier_div_master_template</xsl:attribute>
		</div>	
		
		<!-- po line items product characteristics template -->
		<div style="display:none;">
			<xsl:attribute name="id">po_line_item_product_characteristic_div_template</xsl:attribute>
			<table>
				<tbody>
					<xsl:attribute name="id">po_line_item_product_characteristic_template</xsl:attribute>
					<xsl:call-template name="PO_PRODUCT_CHARACTERISTICS_DETAILS">
						<xsl:with-param name="structure_name">po_line_item_product_characteristic</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_goods</xsl:with-param>
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<div style="display:none;">
			<xsl:attribute name="id">po_line_item_product_characteristic_div_master_template</xsl:attribute>
		</div>	
		
		<!-- po line items product categories template -->
		<div style="display:none;">
			<xsl:attribute name="id">po_line_item_product_category_div_template</xsl:attribute>
			<table>
				<tbody>
					<xsl:attribute name="id">po_line_item_product_category_template</xsl:attribute>
					<xsl:call-template name="PO_PRODUCT_CATEGORIES_DETAILS">
						<xsl:with-param name="structure_name">po_line_item_product_category</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_goods</xsl:with-param>
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<div style="display:none;">
			<xsl:attribute name="id">po_line_item_product_category_div_master_template</xsl:attribute>
		</div>	
		</xsl:if>
		
		<xsl:if test="$section_li_amount_details !='N'">
		<!-- po line items adjustment template -->
		<div style="display:none;">
			<xsl:attribute name="id">po_line_item_adjustment_div_template</xsl:attribute>
			<table>
				<tbody>
					<xsl:attribute name="id">po_line_item_adjustment_template</xsl:attribute>
					<xsl:call-template name="ADJUSTMENT_DETAILS">
						<xsl:with-param name="structure_name">po_line_item_adjustment</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_goods</xsl:with-param>
					</xsl:call-template>
				</tbody>
			</table>
		</div>	

		<div style="display:none;">
			<xsl:attribute name="id">po_line_item_adjustment_div_master_template</xsl:attribute>
		</div>
		
		 <!-- po line items tax template -->
			<div style="display:none;">
				<xsl:attribute name="id">po_line_item_tax_div_template</xsl:attribute>
				<table>
					<tbody>
						<xsl:attribute name="id">po_line_item_tax_template</xsl:attribute>
						<xsl:call-template name="TAX_DETAILS">
							<xsl:with-param name="structure_name">po_line_item_tax</xsl:with-param>
							<xsl:with-param name="mode">template</xsl:with-param>
							<xsl:with-param name="form_name">form_goods</xsl:with-param>
						</xsl:call-template>
					</tbody>
				</table>
			</div>	
	
			<div style="display:none;">
				<xsl:attribute name="id">po_line_item_tax_div_master_template</xsl:attribute>
			</div>

			<!-- po line items tax template -->
			<div style="display:none;">
				<xsl:attribute name="id">po_line_item_freight_charge_div_template</xsl:attribute>
				<table>
					<tbody>
						<xsl:attribute name="id">po_line_item_freight_charge_template</xsl:attribute>
						<xsl:call-template name="FREIGHT_CHARGES_DETAILS">
							<xsl:with-param name="structure_name">po_line_item_freight_charge</xsl:with-param>
							<xsl:with-param name="mode">template</xsl:with-param>
							<xsl:with-param name="form_name">form_goods</xsl:with-param>
						</xsl:call-template>
					</tbody>
				</table>
			</div>	
	
			<div style="display:none;">
				<xsl:attribute name="id">po_line_item_freight_charge_div_master_template</xsl:attribute>
			</div>
		
		</xsl:if>				
				
		
		<xsl:if test="$section_li_inco_terms!='N'">
		<!-- po line items inco term template -->
		<div style="display:none;">
			<xsl:attribute name="id">po_line_item_inco_term_div_template</xsl:attribute>
			<table>
				<tbody>
					<xsl:attribute name="id">po_line_item_inco_term_template</xsl:attribute>
					<xsl:call-template name="INCO_TERMS_DETAILS">
						<xsl:with-param name="structure_name">po_line_item_inco_term</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_goods</xsl:with-param>
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<div style="display:none;">
			<xsl:attribute name="id">po_line_item_inco_term_div_master_template</xsl:attribute>
		</div>
		</xsl:if>
	
		<xsl:if test="$section_li_routing_summary!='N'">
		<!-- po line items routing summary templates -->

		</xsl:if>
	
		<br/>
		
		</xsl:if>
			
		<table border="0" cellpadding="0" cellspacing="0" width="570">		
			<!-- Total Line Items Amount -->
			<tr>
				<td width="40">&nbsp;</td>
				<td colspan="2">
					<table border="0" width="530" cellspacing="1">
						<tr>
							<td width="50%" align="left">
								<font class="FORMMANDATORY">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL')"/>
								</font>
							</td>
							<td width="10%" align="right">
								<input type="text" size="3" maxlength="3" name="fake_total_cur_code" readonly="true" onfocus="this.blur()">
									<xsl:attribute name="value"><xsl:value-of select="total_cur_code"/></xsl:attribute>
								</input>
							</td>
							<td width="30%" align="right">
								<input type="text" size="20" maxlength="15" readonly="true" name="total_amt" onblur="fncRestoreInputStyle('form_goods','total_amt');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['form_goods'].total_cur_code.value));document.forms['fakeform1'].tnx_amt.value=this.value; ">
									<xsl:attribute name="value"><xsl:value-of select="total_amt"/></xsl:attribute>
								</input>
							</td>						
							<!--td align="right">
								<a name="anchor_search_po_currency" href="javascript:void(0)">
									<xsl:attribute name="onclick">fncSearchPopup('currency', 'form_goods',"['total_cur_code']");return false;</xsl:attribute>
									<img border="0" src="/content/images/search.png" name="img_search_po_currency">
										<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
									</img>
								</a>
							</td-->
						</tr>
						<tr>
							<td align="left">
								<font class="FORMMANDATORY">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_AMT_LABEL')"/>
								</font>
							</td>
							<td>&nbsp;
							</td>
							<td align="right">
								<input type="text" size="20" maxlength="15" name="liab_total_amt" onblur="fncRestoreInputStyle('form_goods','liab_total_amt');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['form_goods'].total_cur_code.value));">
									<xsl:attribute name="value"><xsl:value-of select="liab_total_amt"/></xsl:attribute>
								</input>
								<input type="hidden" name="org_liab_total_amt">
									<xsl:attribute name="value"><xsl:value-of select="org_liab_total_amt"/></xsl:attribute>
								</input>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		
		</form>	
		
		<!--Amount Details-->
		
		<xsl:if test="$section_po_amount_details!='N'">
			
		<p><br/></p>
			
		<form name="form_amount">
		
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
		
		<!-- po Adjustment template-->
		<div style="display:none;">
			<table>
				<tbody>
					<xsl:attribute name="id">po_adjustment_template</xsl:attribute>
					<xsl:call-template name="ADJUSTMENT_DETAILS">
						<xsl:with-param name="structure_name">po_adjustment</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_amount</xsl:with-param>
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<xsl:call-template name="adjustments">
			<xsl:with-param name="structure_name">po_adjustment</xsl:with-param>
			<xsl:with-param name="form_name">form_amount</xsl:with-param>
			<xsl:with-param name="mode">existing</xsl:with-param>
		</xsl:call-template>
		
		<br/>
		
		<!-- Taxes -->
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
		
		<!-- po Tax templates-->
		<div style="display:none;">
			<table>
				<tbody>
					<xsl:attribute name="id">po_tax_template</xsl:attribute>
					<xsl:call-template name="TAX_DETAILS">
						<xsl:with-param name="structure_name">po_tax</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_amount</xsl:with-param>
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<xsl:call-template name="taxes">
			<xsl:with-param name="structure_name">po_tax</xsl:with-param>
			<xsl:with-param name="form_name">form_amount</xsl:with-param>
			<xsl:with-param name="mode">existing</xsl:with-param>
		</xsl:call-template>
		
		<br/>
		
		<!-- Freight Charges -->
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
		
		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_FREIGHT_CHARGES_TYPE')"/></td>
				<!-- Freight Charges Type (Collect or Prepaid) -->
				<td>
					<select name="freight_charges_type" onfocus="fncCheckIncoTermsAllowancesUnicity('form_amount', 'freight_charge', 86, this);">
						<xsl:attribute name="onchange">return fncProcessDivFreightCharges('div_freight_charges', 'form_amount', 'po_freight_charges', this, 38)</xsl:attribute>
						<option value="">&nbsp;</option>
						<option value="CLCT">	
							<xsl:if test="freight_charges_type[. = 'CLCT']">
								<xsl:attribute name="selected"/>
							</xsl:if>
							<xsl:value-of select="localization:getDecode($language, 'N211', 'CLCT')"/>
						</option>	
						<option value="PRPD">
							<xsl:if test="freight_charges_type[. = 'PRPD']">
								<xsl:attribute name="selected"/>
							</xsl:if>
							<xsl:value-of select="localization:getDecode($language, 'N211', 'PRPD')"/>	
						</option>												
					</select>
				</td>			
			</tr>			
		</table>
		
		<!-- po freight charges template-->
		<div style="display:none;">
			<table>
				<tbody>
					<xsl:attribute name="id">po_freight_charges_template</xsl:attribute>
					<xsl:call-template name="FREIGHT_CHARGES_DETAILS">
						<xsl:with-param name="structure_name">po_freight_charges</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_amount</xsl:with-param>
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<div id="div_freight_charges">
			<!-- No type freight charge type selected (i. e. no charges)  -->
			<xsl:attribute name="style">
				<xsl:choose>
					<xsl:when test="freight_charges_type[. = 'CLCT' or . = 'PRPD']">display:block</xsl:when>
					<xsl:otherwise>display:none</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>			
			<xsl:call-template name="freight_charges">
				<xsl:with-param name="structure_name">po_freight_charges</xsl:with-param>
				<xsl:with-param name="form_name">form_amount</xsl:with-param>
				<xsl:with-param name="mode">existing</xsl:with-param>
			</xsl:call-template>
		</div>
		
		<p><br/></p>
		
		</form>
		
		</xsl:if>
		
		<form name="form_net_amount">
			
		<table border="0" cellpadding="0" cellspacing="0" width="570">		
			<!-- Total Net Amount -->
			<tr>
				<td width="40">&nbsp;</td>
				<td colspan="2">
					<table border="0" width="530" cellspacing="1">
						<tr>
							<td width="50%" align="left">
								<font class="FORMMANDATORY">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_PO_TOTAL_NET_AMT_LABEL')"/>
								</font>
							</td>
							<td width="10%" align="center">
								<input type="text" size="3" maxlength="3" readonly="true" name="total_net_cur_code" onfocus="this.blur()" onblur="fncRestoreInputStyle('form_net_amount','total_net_cur_code');fncCheckValidCurrency(this);fncFormatAmount(document.forms['form_net_amount'].total_net_amt, fncGetCurrencyDecNo(this.value));document.forms['fakeform1'].tnx_amt.value=document.forms['form_net_amount'].total_net_amt.value;document.forms['fakeform1'].tnx_cur_code.value=this.value;">
									<xsl:attribute name="value"><xsl:value-of select="total_net_cur_code"/></xsl:attribute>
								</input>
							</td>
							<td width="30%" align="right">
								<input type="text" size="20" maxlength="15" readonly="true" name="total_net_amt" onblur="fncRestoreInputStyle('form_net_amount','total_net_amt');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['form_net_amount'].total_net_cur_code.value));document.forms['fakeform1'].tnx_amt.value=this.value;">
									<xsl:attribute name="value"><xsl:value-of select="total_net_amt"/></xsl:attribute>
								</input>
							</td>
							<!--td align="right">
								<a name="anchor_search_po_currency" href="javascript:void(0)">
									<xsl:attribute name="onclick">fncSearchPopup('currency', 'form_amount',"['total_net_cur_code']");return false;</xsl:attribute>
									<img border="0" src="/content/images/search.png" name="img_search_po_currency">
										<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
									</img>
								</a>
							</td-->
						</tr>
						<tr>
							<td align="left">
								<font class="FORMMANDATORY">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_NET_AMT_LABEL')"/>
								</font>
							</td>
							<td>&nbsp;
							</td>
							<td align="right">
								<input type="text" size="20" maxlength="15" name="liab_total_net_amt" onblur="fncRestoreInputStyle('form_net_amount','liab_total_net_amt');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['form_net_amount'].total_net_cur_code.value));" >
									<xsl:attribute name="value"><xsl:value-of select="liab_total_net_amt"/></xsl:attribute>
								</input>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		
		</form>

		<p><br/></p>
		
		<!--Payment Terms Details-->
		<xsl:if test="$section_po_payment_terms!='N'">
			
		<form name="form_payments">
			
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
		<table>
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_PAYMENT_TYPE')"/></td>
				<!-- Payment Type (amount or percentage) -->
				<td>
					<input type="radio" value="AMNT" name="payment_terms_type" onclick="fncCheckPaymentTerms('form_payments','po_payment')">
						<xsl:if test="payment_terms_type[. = 'AMNT'] and count(payments/payment) != 0">
							<xsl:attribute name="checked"/>
						</xsl:if>		
					</input>&nbsp;<xsl:value-of select="localization:getDecode($language, 'N209', 'AMNT')"/>				
				</td>			
			</tr>
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150">&nbsp;</td>
				<td>
					<input type="radio" value="PRCT" name="payment_terms_type" onclick="fncCheckPaymentTerms('form_payments','po_payment')">		
						<xsl:if test="payment_terms_type[. = 'PRCT'] and count(payments/payment) != 0">
							<xsl:attribute name="checked"/>
						</xsl:if>												
					</input>&nbsp;<xsl:value-of select="localization:getDecode($language, 'N209', 'PRCT')"/>					
				</td>			
			</tr>	
		</table>
		<div style="display:none;">
			<table>
				<tbody>
					<xsl:attribute name="id">po_payment_template</xsl:attribute>
					<xsl:call-template name="PAYMENT_DETAILS">
						<xsl:with-param name="structure_name">po_payment</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_payments</xsl:with-param>
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<xsl:call-template name="payments">
			<xsl:with-param name="structure_name">po_payment</xsl:with-param>
			<xsl:with-param name="form_name">form_payments</xsl:with-param>
			<xsl:with-param name="currency">total_cur_code</xsl:with-param>
			<xsl:with-param name="currency_form_name">form_goods</xsl:with-param>
		</xsl:call-template>
		
		</form>
		
		<p><br/></p>
		
		</xsl:if>
		
		<!--Settlement Terms Details-->
		<xsl:if test="$section_po_settlement_terms!='N'">
			
		<form name="form_settlement">
		
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
					<select name="seller_account_type">
						<xsl:attribute name="onchange">document.forms['form_settlement'].seller_account_value.value='';fncCheckAccountFormat('form_settlement', 'seller_account_value', 'seller_account_type');</xsl:attribute>
						<option value="">&nbsp;</option>
						<option value="IBAN">
							<xsl:if test="seller_account_iban[.!='']">
								<xsl:attribute name="selected"/>
							</xsl:if>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN')"/>
						</option>
						<option value="BBAN">
							<xsl:if test="seller_account_bban[.!='']">
								<xsl:attribute name="selected"/>
							</xsl:if>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_BBAN')"/>
						</option>
						<option value="UPIC">
							<xsl:if test="seller_account_upic[.!='']">
								<xsl:attribute name="selected"/>
							</xsl:if>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_UPIC')"/>
						</option>
						<option value="OTHER">
							<xsl:if test="seller_account_id[.!='']">
								<xsl:attribute name="selected"/>
							</xsl:if>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_OTHER')"/>
						</option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/></td>
				<td>
					<input type="text" size="35" maxlength="35" name="seller_account_name" onblur="fncRestoreInputStyle('form_settlement','seller_account_name');">
						<xsl:attribute name="value"><xsl:value-of select="seller_account_name"/></xsl:attribute>
					</input>
				</td>
				<td align="right">
					<a name="anchor_search_seller" href="javascript:void(0)">
						<xsl:attribute name="onclick">if(fncAccountFormatReadOnly('form_settlement', 'seller_account_type', 'seller_account_value')){fncSearchPopup('account', 'form_settlement',"['seller_account_value', 'seller_account_name']",'', '', '<xsl:value-of select="product_code"/>');return false;}</xsl:attribute>
						<img border="0" src="/content/images/search.png" name="img_search_counterparty">
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_BENEFICIARY')"/></xsl:attribute>
						</img>
					</a>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_SELLER_ACCOUNT_NUMBER')"/></td>
				<td>
					<input type="text" size="35" maxlength="35" name="seller_account_value" onfocus="fncAccountFormatReadOnly('form_settlement', 'seller_account_type', 'seller_account_value');">
						<xsl:attribute name="onblur">fncRestoreInputStyle('form_settlement','seller_account_value');fncCheckAccountFormat('form_settlement', 'seller_account_value', 'seller_account_type');</xsl:attribute>
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="seller_account_iban[.!='']"><xsl:value-of select="seller_account_iban"/></xsl:when>
								<xsl:when test="seller_account_bban[.!='']"><xsl:value-of select="seller_account_bban"/></xsl:when>
								<xsl:when test="seller_account_upic[.!='']"><xsl:value-of select="seller_account_upic"/></xsl:when>
								<xsl:when test="seller_account_id[.!='']"><xsl:value-of select="seller_account_id"/></xsl:when>
								<xsl:otherwise/>
							</xsl:choose>
						</xsl:attribute>
					</input>
				</td>
			</tr>
		</table>
		
		<br/>
		
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
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/></td>
				<td>
					<input type="text" size="35" maxlength="35" name="fin_inst_name" onblur="fncRestoreInputStyle('form_settlement','fin_inst_name');">
						<xsl:attribute name="value"><xsl:value-of select="fin_inst_name"/></xsl:attribute>
					</input>
				</td>
				<td align="right">
					<a name="anchor_search_fin_inst" href="javascript:void(0)">
						<xsl:attribute name="onclick">fncSearchPopup("baseline_bank", "form_settlement","['fin_inst_name', 'fin_inst_bic', 'fin_inst_street_name', 'fin_inst_post_code', 'fin_inst_town_name', 'fin_inst_country_sub_div', 'fin_inst_country']", '', 'BaseLineListPopup', '<xsl:value-of select="product_code"/>');return false;</xsl:attribute>
						<img border="0" src="/content/images/search.png" name="img_search_fin_inst">
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_BANK')"/></xsl:attribute>
						</img>
					</a>
				</td>
			</tr>
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BIC_CODE')"/></td>
				<td>
					<input type="text" size="11" maxlength="11" name="fin_inst_bic" onblur="fncRestoreInputStyle('form_settlement','fin_inst_bic');fncCheckBICFormat(this);">
						<xsl:attribute name="value"><xsl:value-of select="fin_inst_bic"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/></td>
				<td>
					<input type="text" size="35" maxlength="70" name="fin_inst_street_name" onblur="fncRestoreInputStyle('form_settlement','fin_inst_street_name');">
						<xsl:attribute name="value"><xsl:value-of select="fin_inst_street_name"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/></td>
				<td>
					<input type="text" size="16" maxlength="16" name="fin_inst_post_code" onblur="fncRestoreInputStyle('form_settlement','fin_inst_post_code');">
						<xsl:attribute name="value"><xsl:value-of select="fin_inst_post_code"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/></td>
				<td>
					<input type="text" size="35" maxlength="35" name="fin_inst_town_name" onblur="fncRestoreInputStyle('form_settlement','fin_inst_town_name');">
						<xsl:attribute name="value"><xsl:value-of select="fin_inst_town_name"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/></td>
				<td>
					<input type="text" size="35" maxlength="34" name="fin_inst_country_sub_div" onblur="fncRestoreInputStyle('form_settlement','fin_inst_country_sub_div');">
						<xsl:attribute name="value"><xsl:value-of select="fin_inst_country_sub_div"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/></td>
				<td>
					<input type="text" size="2" maxlength="2" name="fin_inst_country" onblur="fncRestoreInputStyle('form_settlement','fin_inst_country');fncCheckCountryCode(this);">
						<xsl:attribute name="value"><xsl:value-of select="fin_inst_country"/></xsl:attribute>
					</input>&nbsp;
					<a name="anchor_search_country" href="javascript:void(0)">
						<xsl:attribute name="onclick">fncSearchPopup('codevalue', 'form_settlement',"['fin_inst_country']",'C006');return false;</xsl:attribute>
						<img border="0" src="/content/images/search.png" name="img_search_country">
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_COUNTRY')"/></xsl:attribute>
						</img>
					</a>
				</td>
			</tr>
		</table>
		
		</form>
		
		<p><br/></p>
		
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
		
		<form name="form_advising_bank">
   		<div id='divAdvisingBank' style='display: none'> 
   			<input name="advising_bank_name" type="hidden">
   				<xsl:attribute name="value"><xsl:value-of select="advising_bank/name"/></xsl:attribute>
   			</input>
   			<input name="advising_bank_iso_code" type="hidden">
   				<xsl:attribute name="value"><xsl:value-of select="advising_bank/iso_code"/></xsl:attribute>
   			</input>
   		</div>
		</form>

		<br/>
		
		<div id='divBank0' style='position:relative'>
	
			<br/>
			
			<table cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td id="cell_issuing_bank" width="175" height="25" align="center">
					<xsl:attribute name="style">background-image: url(/content/images/tab_on<xsl:if test="issuing_bank/iso_code[.!='']">_sel</xsl:if>.gif)</xsl:attribute>
					<a href="javascript:void(0)" onclick="fncShowTab(1,'issuing_bank','','_name');return false;" style="text-decoration: none">
						<font class="FORMTABMANDATORY">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ISSUING_BANK')"/>
						</font>
					</a>
				</td>
				<td id="cell_seller_bank" width="175" height="25" align="center">
					<xsl:attribute name="style">background-image: url(/content/images/tab_off<xsl:if test="seller_bank_type_code[.!='']">_sel</xsl:if>.gif)</xsl:attribute>
					<a href="javascript:void(0)" onclick="fncShowTab(1,'seller_bank','','_name');return false;" style="text-decoration: none">
						<font class="FORMTABMANDATORY">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_SELLER_BANK')"/>
						</font>
					</a>
				</td>
				<td id="cell_buyer_bank" width="175" height="25" align="center">
					<xsl:attribute name="style">background-image: url(/content/images/tab_off<xsl:if test="buyer_bank_type_code[.!='']">_sel</xsl:if>.gif)</xsl:attribute>
					<a href="javascript:void(0)" onclick="fncShowTab(1,'buyer_bank','','_name');return false;" style="text-decoration: none">
						<font class="FORMTABMANDATORY">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_BUYER_BANK')"/>
						</font>
					</a>
				</td>
				
			</tr>
			<tr>
				<td class="FORMH1" colspan="3" height="4"><table border="0" width="100%" cellpadding="0" cellspacing="0"><tr><td></td></tr></table></td>
			</tr>
		</table>

			<table border="0" width="570" height="175">
				<tr>
					<td valign="top">


						<div id='div_issuing_bank' style='display: block'>
							
							<br/>
							
							<xsl:apply-templates select="issuing_bank">
               			<xsl:with-param name="theNodeName" select="'issuing_bank'"/>
               			<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ISSUING_BANK')"/>
               			<xsl:with-param name="theSubmissionType" select="submission_type"/>
							</xsl:apply-templates>

						</div>
						
						<div id='div_seller_bank' style='display: none'>
							
							<br/>
							
							<xsl:apply-templates select="seller_bank">
               			<xsl:with-param name="theNodeName" select="'seller_bank'"/>
               			<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_SELLER_BANK')"/>
               			<xsl:with-param name="theTypeCode" select="seller_bank_type_code"/>
               		</xsl:apply-templates>

						</div>
							
						<div id='div_buyer_bank' style='display: none'>
	
							<br/>
							
							<xsl:apply-templates select="buyer_bank">
								<xsl:with-param name="theNodeName" select="'buyer_bank'"/>
								<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_BUYER_BANK')"/>
								<xsl:with-param name="theTypeCode" select="buyer_bank_type_code"/>
							</xsl:apply-templates>

						</div>
							
					</td>
				</tr>
			</table>
		
		</div>

		<br/>

		<!-- Documents Required -->
		
		<xsl:if test="$section_po_documents_required!='N'">
			
		<form name="form_documents">
		
		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td class="FORMH1" colspan="3">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED')"/></b>
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
		
		<table cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td width="40">&nbsp;</td>
				<td width="270"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_COMMERCIAL_DATASET')"/></td>
				<td width="270"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_TRANSPORT_DATASET')"/></td>
			</tr>
			<tr>
				<td width="15">&nbsp;</td>
				<td>
					<input type="radio" name="reqrd_commercial_dataset" value="Y">
						<xsl:if test="reqrd_commercial_dataset[. = 'Y' or . = '']">
							<xsl:attribute name="checked"/>
						</xsl:if>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_COMMERCIAL_DATASET_REQUIRED')"/>
					</input>
				</td>
				<td>
					<input type="radio" name="reqrd_transport_dataset" value="Y" onclick="fncCheckTransshipment()">
						<xsl:if test="reqrd_transport_dataset[. = 'Y']">
							<xsl:attribute name="checked"/>
						</xsl:if>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_TRANSPORT_DATASET_REQUIRED')"/>
					</input>
				</td>
			</tr>
			<tr>
				<td width="40">&nbsp;</td>
				<td>
					<input type="radio" name="reqrd_commercial_dataset" value="N">
						<xsl:if test="reqrd_commercial_dataset[. = 'N']">
							<xsl:attribute name="checked"/>
						</xsl:if>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_COMMERCIAL_DATASET_NOT_REQUIRED')"/>
					</input>
				</td>
				<td>
					<input type="radio" name="reqrd_transport_dataset" value="N">
						<xsl:if test="reqrd_transport_dataset[. = 'N' or . = '']">
							<xsl:attribute name="checked"/>
						</xsl:if>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_TRANSPORT_DATASET_NOT_REQUIRED')"/>
					</input>
				</td>
			</tr>
			</table>
			
			<br/>
			
			<table cellspacing="0" cellpadding="0" border="0">
			<tr>
		    	<td width="40">&nbsp;</td>
		    	<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_LAST_MATCH_DATE')"/></td>
				<td>
					<input type="text" size="10" maxlength="10" name="last_match_date" onblur="fncRestoreInputStyle('form_documents','last_match_date');fncCheckLastMatchDate(this);">
						<xsl:attribute name="value"><xsl:value-of select="last_match_date"/></xsl:attribute>
					</input><script>DateInput('last_match_date','<xsl:value-of select="last_match_date"/>')</script>
				</td>
			</tr>
		</table>

		</form>
		
		<p><br/></p>
		
		</xsl:if>
		
		<!--Shipment Details-->
		<xsl:if test="$section_po_shipment_details!='N'">
			
		<form name="form_shipment">
		
		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tr>
				<td class="FORMH1" colspan="3">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SHIPMENT_DETAILS')"/></b>
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

		<!-- Lastest Shipment Date, Partial and Trans Shipments-->
		<table border="0" cellpadding="0" cellspacing="0" width="570">
			<tr>
				<td width="40">&nbsp;</td>
				<td width="270"><font class="FORMMANDATORY"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_LABEL')"/></font></td>
				<td width="270"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL')"/></td>
			</tr>
			<tr>
				<td width="40">&nbsp;</td>
				<td>
					<input type="radio" name="part_ship" value="Y">
						<xsl:if test="part_ship[. = 'Y' or . = '']">
							<xsl:attribute name="checked"/>
						</xsl:if>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/>
					</input>
				</td>
				<td>
					<select name="tran_ship" onchange="fncCheckTransshipment()" onblur="fncCheckTransshipment()">
						<option value="">&nbsp;</option>
						<option value="Y">
						<xsl:if test="tran_ship[. = 'Y']">
								<xsl:attribute name="selected"/>
							</xsl:if>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/>
						</option>
						<option value="N">
							<xsl:if test="tran_ship[.='N']">
								<xsl:attribute name="selected"/>
							</xsl:if>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/>
						</option>
					</select>
					<!--input type="radio" name="tran_ship" value="Y">
						<xsl:if test="tran_ship[. = 'Y']">
							<xsl:attribute name="checked"/>
						</xsl:if>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/>
					</input-->
				</td>
			</tr>
			<tr>
				<td width="40">&nbsp;</td>
				<td>
					<input type="radio" name="part_ship" value="N">
						<xsl:if test="part_ship[. = 'N']">
							<xsl:attribute name="checked"/>
						</xsl:if>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/>
					</input>
				</td>
				<!--td>
					<input type="radio" name="tran_ship" value="N">
						<xsl:if test="tran_ship[. = 'N']">
							<xsl:attribute name="checked"/>
						</xsl:if>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/>
					</input>
				</td-->
			</tr>
			</table>
			
			<br/>
			
			<table border="0" cellpadding="0" cellspacing="0" width="570">
			<tr>
		    	<td width="40">&nbsp;</td>
		    	<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_LAST_SHIP_DATE')"/></td>
				<td>
					<input type="text" size="10" maxlength="10" name="last_ship_date" onblur="fncCheckLastShipDate(this);fncRestoreInputStyle('form_shipment','last_ship_date');" onfocus="fncCheckLastShipDateUnicity(this);">
						<xsl:attribute name="value"><xsl:value-of select="last_ship_date"/></xsl:attribute>
					</input><script>DateInput('last_ship_date','<xsl:value-of select="last_ship_date"/>')</script>
				</td>
			</tr>
		</table>
		
		</form>
		
		<p><br/></p>
	
		</xsl:if>
		
		<!--Inco Terms Details-->	
		<xsl:if test="$section_po_inco_terms!='N'">
			
		<form name="form_inco_terms">
					
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
		
		<div style="display:none;">
			<table>
				<tbody>
					<xsl:attribute name="id">po_inco_term_template</xsl:attribute>
					<xsl:call-template name="INCO_TERMS_DETAILS">
						<xsl:with-param name="structure_name">po_inco_term</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_inco_terms</xsl:with-param>
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<xsl:call-template name="inco_terms">
			<xsl:with-param name="structure_name">po_inco_term</xsl:with-param>
			<xsl:with-param name="form_name">form_inco_terms</xsl:with-param>
			<xsl:with-param name="mode">existing</xsl:with-param>
		</xsl:call-template>
		
		</form>
		
		<p><br/></p>
		
		</xsl:if>
		
		
		<!--Routing Summary Details-->
		<xsl:if test="$section_po_routing_summary!='N'">
		<!--  -->
		<!-- Routing summary individual mode templates -->
		<!--  -->
		<!--Transport By Air Details template-->
		<div style="display:none;">
			<table>
				<tbody>
					<xsl:attribute name="id">po_routing_summary_individual_air_template</xsl:attribute>
					<xsl:call-template name="PO_ROUTING_SUMMARY_TRANSPORT_AIR_DETAILS">
						<xsl:with-param name="structure_name">po_routing_summary_individual_air</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
						<xsl:with-param name="nestedStructureName">po_airport</xsl:with-param>
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<!-- Transport By Air Details > Airport Details -->
		<div style="display:none;" id="po_airportTemplate">
			<table>
				<tbody>
					<xsl:attribute name="id">po_airportTemplate_template</xsl:attribute>
					<xsl:call-template name="PO_AIRPORT_DETAILS">
						<xsl:with-param name="structure_name">po_airportTemplate</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
						<xsl:with-param name="transport_mode">01</xsl:with-param>
						<xsl:with-param name="transport_type">01</xsl:with-param>
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<div style="display:none;" id="po_airport_master_template"/>	
		
		<!--Transport By Sea Details template-->
		<div style="display:none;">
			<table>
				<tbody>
					<xsl:attribute name="id">po_routing_summary_individual_sea_template</xsl:attribute>
					<xsl:call-template name="PO_ROUTING_SUMMARY_TRANSPORT_SEA_DETAILS">
						<xsl:with-param name="structure_name">po_routing_summary_individual_sea</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
						<xsl:with-param name="nestedStructureName">po_port</xsl:with-param>
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<!-- Transport By Sea Details > Port Details -->
		<div style="display:none;" id="po_portTemplate">
			<table>
				<tbody>
					<xsl:attribute name="id">po_portTemplate_template</xsl:attribute>
					<xsl:call-template name="PO_PORT_DETAILS">
						<xsl:with-param name="structure_name">po_portTemplate</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
						<xsl:with-param name="transport_mode">02</xsl:with-param>
						<xsl:with-param name="transport_type">01</xsl:with-param>						
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<div style="display:none;" id="po_port_master_template"/>
		
		<!--Transport By Road Details template -->
		<div style="display:none;">
			<table>
				<tbody>
					<xsl:attribute name="id">po_routing_summary_individual_road_template</xsl:attribute>
					<xsl:call-template name="PO_ROUTING_SUMMARY_TRANSPORT_ROAD_DETAILS">
						<xsl:with-param name="structure_name">po_routing_summary_individual_road</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
						<xsl:with-param name="nestedStructureName">po_road_place</xsl:with-param>
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<!-- Transport By Road Details > Place Details -->
		<div style="display:none;" id="po_road_placeTemplate">
			<table>
				<tbody>
					<xsl:attribute name="id">po_road_placeTemplate_template</xsl:attribute>
					<xsl:call-template name="PO_PLACE_DETAILS">
						<xsl:with-param name="structure_name">po_road_placeTemplate</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
							<xsl:with-param name="transport_mode">03</xsl:with-param>
							<xsl:with-param name="transport_type">01</xsl:with-param>						
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<div style="display:none;" id="po_road_place_master_template"/>	
		
		<!--Transport By Rail Details template-->
		<div style="display:none;">
			<table>
				<tbody>
					<xsl:attribute name="id">po_routing_summary_individual_rail_template</xsl:attribute>
					<xsl:call-template name="PO_ROUTING_SUMMARY_TRANSPORT_RAIL_DETAILS">
						<xsl:with-param name="structure_name">po_routing_summary_individual_rail</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
						<xsl:with-param name="nestedStructureName">po_rail_place</xsl:with-param>
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<!-- Transport By Rail Details > Place Details -->
		<div style="display:none;" id="po_rail_placeTemplate">
			<table>
				<tbody>
					<xsl:attribute name="id">po_rail_placeTemplate_template</xsl:attribute>
					<xsl:call-template name="PO_PLACE_DETAILS">
						<xsl:with-param name="structure_name">po_rail_placeTemplate</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
						<xsl:with-param name="transport_mode">04</xsl:with-param>
						<xsl:with-param name="transport_type">01</xsl:with-param>						
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<div style="display:none;" id="po_rail_place_master_template"/>
		
		
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
		
		<p/>
				
		<form name="form_routing_summaries">
		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150">
					<!--font class="FORMMANDATORY"-->					
					<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_ROUTING_SUMMARY_TRANSPORT_TYPE')"/>
					<!--/font-->
				</td>
				<td>
					<!-- Routing Summary Mode (Individual or Multimodal) -->
					<select name="transport_type" onfocus="fncCheckRoutingSummaryUnicity(this);">
						<xsl:attribute name="onchange">return fncProcessDivRtgSummary('div_routing_summaries_multimodal','div_routing_summaries_individual', 'form_routing_summaries','po_routing_summary_multimodal','po_routing_summary_individual', this);</xsl:attribute>
						<option value="">&nbsp;</option>
						<option value="01">
						<xsl:if test="count(/so_tnx_record/routing_summaries/routing_summary/transport_type[. = '01']) != 0">
								<xsl:attribute name="selected"/>
						</xsl:if>		
							<xsl:value-of select="localization:getDecode($language, 'N213', '01')"/>
						</option>
						<option value="02">
						<xsl:if test="count(/so_tnx_record/routing_summaries/routing_summary/transport_type[. = '02']) != 0">
								<xsl:attribute name="selected"/>
						</xsl:if>
							<xsl:value-of select="localization:getDecode($language, 'N213', '02')"/>
						</option>
					</select>
				</td>			
			</tr>			
		</table>
		
		<br/>
		<!-- Routing Summary Individual section -->
		<div id="div_routing_summaries_individual">
			<xsl:attribute name="style">
				<xsl:if test="count(/so_tnx_record/routing_summaries/routing_summary/transport_type[. = '01']) = 0">display:none</xsl:if>
			</xsl:attribute>
			<!--<form name="form_routing_summaries_individual">-->
					
				<!-- Transport By Air -->
				<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_AIR')"/></b>
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
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
					<td>
							<xsl:apply-templates select="routing_summaries" mode="po_air">
							<xsl:with-param name="structure_name">po_routing_summary_individual_air</xsl:with-param>
								<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
							</xsl:apply-templates>
					</td>
				</tr>
				</table>
				<!-- Transport By Sea -->
				<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_SEA')"/></b>
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
				<!-- Transport By Road -->		
				<table border="0" width="570" cellpadding="0" cellspacing="0">	
					<tr>
					<td>
							<xsl:apply-templates select="routing_summaries" mode="po_sea">
							<xsl:with-param name="structure_name">po_routing_summary_individual_sea</xsl:with-param>
								<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
							</xsl:apply-templates>
					</td>
				</tr>
				</table>
				<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD')"/></b>
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
				<table border="0" width="570" cellpadding="0" cellspacing="0">	
					<tr>
					<td>
							<xsl:apply-templates select="routing_summaries" mode="po_road">
							<xsl:with-param name="structure_name">po_routing_summary_individual_road</xsl:with-param>
								<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
							</xsl:apply-templates>						
					</td>
				</tr>
				</table>
				<!-- Transport By Rail -->
				<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL')"/></b>
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
				<table border="0" width="570" cellpadding="0" cellspacing="0">	
					<tr>
					<td>
							<xsl:apply-templates select="routing_summaries" mode="po_rail">
							<xsl:with-param name="structure_name">po_routing_summary_individual_rail</xsl:with-param>
								<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
							</xsl:apply-templates>									
					</td>
				</tr>								
			</table>
			<!--</form>-->
		</div>
		
	
				<!--  -->
				<!-- Routing summary Multimodal mode templates -->
				<!--  -->
				<!--Multimodal > Airport template-->
				<div style="display:none;">
					<table>
						<tbody>
							<xsl:attribute name="id">po_routing_summary_multimodal_airport_template</xsl:attribute>
							<xsl:call-template name="PO_AIRPORT_DETAILS">
								<xsl:with-param name="structure_name">po_routing_summary_multimodal_airport</xsl:with-param>
								<xsl:with-param name="mode">template</xsl:with-param>
								<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
								<xsl:with-param name="transport_mode">01</xsl:with-param>
								<xsl:with-param name="transport_type">02</xsl:with-param>
							</xsl:call-template>
						</tbody>
					</table>
				</div>	
				
				<!-- Multimodal > Port template-->
				<div style="display:none;">
					<table>
						<tbody>
							<xsl:attribute name="id">po_routing_summary_multimodal_port_template</xsl:attribute>
							<xsl:call-template name="PO_PORT_DETAILS">
								<xsl:with-param name="structure_name">po_routing_summary_multimodal_port</xsl:with-param>
								<xsl:with-param name="mode">template</xsl:with-param>
								<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
								<xsl:with-param name="transport_mode">02</xsl:with-param>
								<xsl:with-param name="transport_type">02</xsl:with-param>								
								
							</xsl:call-template>
						</tbody>
					</table>
				</div>
				
				<!-- Multimodal > Place template-->
				<div style="display:none;">
					<table>
						<tbody>
							<xsl:attribute name="id">po_routing_summary_multimodal_place_template</xsl:attribute>
							<xsl:call-template name="PO_PLACE_DETAILS">
								<xsl:with-param name="structure_name">po_routing_summary_multimodal_place</xsl:with-param>
								<xsl:with-param name="mode">template</xsl:with-param>
								<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
								<xsl:with-param name="transport_mode"></xsl:with-param>
								<xsl:with-param name="transport_type">02</xsl:with-param>
							</xsl:call-template>
						</tbody>
					</table>
				</div>
				
				<!-- Multimodal > Taking in charge template-->
				<div style="display:none;">
					<table>
						<tbody>
							<xsl:attribute name="id">po_routing_summary_multimodal_taking_in_charge_template</xsl:attribute>
							<xsl:call-template name="PO_TAKING_IN_CHARGE_DETAILS">
								<xsl:with-param name="structure_name">po_routing_summary_multimodal_taking_in_charge</xsl:with-param>
								<xsl:with-param name="mode">template</xsl:with-param>
								<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
							</xsl:call-template>
						</tbody>
					</table>
				</div>
				
				<!-- Multimodal > Place of Final Destination template-->
				<div style="display:none;">
					<table>
						<tbody>
						<xsl:attribute name="id">po_routing_summary_multimodal_place_final_dest_template</xsl:attribute>
						<xsl:call-template name="PO_PLACE_FINAL_DEST_DETAILS">
							<xsl:with-param name="structure_name">po_routing_summary_multimodal_place_final_dest</xsl:with-param>
							<xsl:with-param name="mode">template</xsl:with-param>
							<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
						</xsl:call-template>
					</tbody>
				</table>
			</div>	
		
		<!-- Routing Summary Multimodal section -->
		<div id="div_routing_summaries_multimodal">
			<xsl:attribute name="style">
				<xsl:if test="count(/so_tnx_record/routing_summaries/routing_summary/transport_type[. = '02']) = 0">display:none</xsl:if>
			</xsl:attribute>
				
				<!-- Airports -->
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_AIRPORT')"/></b>
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
			<table border="0" width="100%" cellspacing="0">
				<tr>
					<td>
								<xsl:call-template name="routing_summary_multimodal_airport">
									<xsl:with-param name="structure_name">po_routing_summary_multimodal_airport</xsl:with-param>
								<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>					
								</xsl:call-template>
							</td>
						</tr>
				</table>
						<!-- Ports -->
				<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_PORT')"/></b>
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
				<table border="0" width="100%" cellspacing="0">
					<tr>
							<td>
								<xsl:call-template name="routing_summary_multimodal_port">
									<xsl:with-param name="structure_name">po_routing_summary_multimodal_port</xsl:with-param>
								<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
				</table>
						<!-- Places -->
				<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_PLACE')"/></b>
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
				<table border="0" width="100%" cellspacing="0">
					<tr>
							<td>
								<xsl:call-template name="routing_summary_multimodal_place">
									<xsl:with-param name="structure_name">po_routing_summary_multimodal_place</xsl:with-param>
								<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
				</table>
						<!-- Taking In Charge -->
				<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TAKING_IN_CHARGE')"/></b>
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
				<table border="0" width="100%" cellspacing="0">
					<tr>
							<td>
								<xsl:call-template name="routing_summary_multimodal_taking_in_charge">
									<xsl:with-param name="structure_name">po_routing_summary_multimodal_taking_in_charge</xsl:with-param>
								<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>
				</table>
						<!-- Place Of Final Destination -->
				<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_PLACE_FINAL_DEST')"/></b>
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
				<table border="0" width="100%" cellspacing="0">
					<tr>
							<td>
								<xsl:call-template name="routing_summary_multimodal_place_final_dest">
									<xsl:with-param name="structure_name">po_routing_summary_multimodal_place_final_dest</xsl:with-param>
								<xsl:with-param name="form_name">form_routing_summaries</xsl:with-param>
								</xsl:call-template>
							</td>
						</tr>																		
			</table>

		</div>
			</form>
		
		<p><br/></p>
		
		</xsl:if>
		
		<!--User Informations Details-->
		<xsl:if test="$section_po_user_info!='N'">
			
		<form name="form_user_informations">
		
		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tr>
				<td class="FORMH1" colspan="3">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_USER_INFORMATION_DETAILS')"/></b>
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
				<td width="15">&nbsp;</td>
				<td class="FORMH2" align="left">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_BUYER_INFORMATIONS')"/></b>
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

		<div style="display:none;">
			<table>
				<tbody>
					<xsl:attribute name="id">po_buyer_defined_information_template</xsl:attribute>
					<xsl:call-template name="USER_DEFINED_INFORMATIONS_DETAILS">
						<xsl:with-param name="structure_name">po_buyer_defined_information</xsl:with-param>
						<xsl:with-param name="user_info_type">01</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_user_informations</xsl:with-param>
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<xsl:call-template name="user_defined_informations">
			<xsl:with-param name="user_info_type">01</xsl:with-param>
			<xsl:with-param name="structure_name">po_buyer_defined_information</xsl:with-param>
			<xsl:with-param name="form_name">form_user_informations</xsl:with-param>
		</xsl:call-template>
		
		<br/>
		
		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tr>
				<td width="15">&nbsp;</td>
				<td class="FORMH2" align="left">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_SELLER_INFORMATIONS')"/></b>
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
	
		<div style="display:none;">
			<table>
				<tbody>
					<xsl:attribute name="id">po_seller_defined_information_template</xsl:attribute>
					<xsl:call-template name="USER_DEFINED_INFORMATIONS_DETAILS">
						<xsl:with-param name="structure_name">po_seller_defined_information</xsl:with-param>
						<xsl:with-param name="user_info_type">02</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_user_informations</xsl:with-param>
					</xsl:call-template>
				</tbody>
			</table>
		</div>	
		
		<xsl:call-template name="user_defined_informations">
			<xsl:with-param name="user_info_type">02</xsl:with-param>
			<xsl:with-param name="structure_name">po_buyer_defined_information</xsl:with-param>
			<xsl:with-param name="form_name">form_user_informations</xsl:with-param>
		</xsl:call-template>
		
		</form>
		
		<p><br/></p>
		
		</xsl:if>
		
		<!--Contact Person Details-->
		<xsl:if test="$section_po_contact!='N'">
			
		<form name="form_contacts">
			
		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td class="FORMH1" colspan="3">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONTACT_PERSON_DETAILS')"/></b>
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

		<!-- Contacts templates-->
		<div style="display:none;">
			<table>
				<tbody>
					<xsl:attribute name="id">po_contact_template</xsl:attribute>
					<xsl:call-template name="CONTACT_DETAILS">
						<xsl:with-param name="structure_name">po_contact</xsl:with-param>
						<xsl:with-param name="mode">template</xsl:with-param>
						<xsl:with-param name="form_name">form_contacts</xsl:with-param>
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<xsl:call-template name="contacts">
			<xsl:with-param name="structure_name">po_contact</xsl:with-param>
			<xsl:with-param name="form_name">form_contacts</xsl:with-param>
		</xsl:call-template>
		
		</form>
		
		</xsl:if>

		<br/>		

	

		
		
	</td>
	</tr>
	</table>
	
	</td>
	</tr>
	</table>

	</xsl:template>
	
		
	<!--Other Templates-->
	
	<!-- TEMPLATE Issuing Bank -->

	<xsl:template match="issuing_bank">
		<xsl:param name="theNodeName"/>
		<xsl:param name="theNodeDescription"/>
		<xsl:param name="theSubmissionType"/>

		<form>
			<xsl:attribute name="name">form_<xsl:value-of select="$theNodeName"/></xsl:attribute>
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150">
						<font class="FORMMANDATORY">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
						</font>
					</td>
					<td>
						<input type="text" size="35" maxlength="35">
							<xsl:attribute name="name"><xsl:value-of select="$theNodeName"/>_name</xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="name"/></xsl:attribute>
							<xsl:attribute name="onfocus">this.blur();</xsl:attribute>
						</input>
					</td>
					<td>
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncSearchIssuingBankPopup("bank", "form_<xsl:value-of select="$theNodeName"/>","['<xsl:value-of select="$theNodeName"/>_name', '<xsl:value-of select="$theNodeName"/>_address_line_1', '<xsl:value-of select="$theNodeName"/>_address_line_2', '<xsl:value-of select="$theNodeName"/>_dom', '<xsl:value-of select="$theNodeName"/>_iso_code']");return false;</xsl:attribute>
							<xsl:attribute name="name">anchor_search_<xsl:value-of select="$theNodeName"/></xsl:attribute>
							<img border="0" src="/content/images/search.png">
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_BANK')"/></xsl:attribute>
								<xsl:attribute name="name">img_search_<xsl:value-of select="$theNodeName"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
					<td colspan="2">
						<input type="text" size="35" maxlength="35">
							<xsl:attribute name="name"><xsl:value-of select="$theNodeName"/>_address_line_1</xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="address_line_1"/></xsl:attribute>
							<xsl:attribute name="onblur">fncRestoreInputStyle('form_<xsl:value-of select="$theNodeName"/>','<xsl:value-of select="$theNodeName"/>_address_line_1');</xsl:attribute>
							<xsl:attribute name="onfocus">this.blur();</xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td colspan="2">
						<input type="text" size="35" maxlength="35">
							<xsl:attribute name="name"><xsl:value-of select="$theNodeName"/>_address_line_2</xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="address_line_2"/></xsl:attribute>
							<xsl:attribute name="onblur">fncRestoreInputStyle('form_<xsl:value-of select="$theNodeName"/>','<xsl:value-of select="$theNodeName"/>_address_line_2');</xsl:attribute>
							<xsl:attribute name="onfocus">this.blur();</xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td colspan="2">
						<input type="text" size="35" maxlength="35">
							<xsl:attribute name="name"><xsl:value-of select="$theNodeName"/>_dom</xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="dom"/></xsl:attribute>
							<xsl:attribute name="onblur">fncRestoreInputStyle('form_<xsl:value-of select="$theNodeName"/>','<xsl:value-of select="$theNodeName"/>_dom');</xsl:attribute>
							<xsl:attribute name="onfocus">this.blur();</xsl:attribute>
						</input>									
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150">
						<font class="FORMMANDATORY">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BIC_CODE')"/>
						</font>
					</td>
					<td colspan="2">
						<input type="text" size="11" maxlength="11">
							<xsl:attribute name="name"><xsl:value-of select="$theNodeName"/>_iso_code</xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="iso_code"/></xsl:attribute>
							<xsl:attribute name="onblur">fncRestoreInputStyle('form_<xsl:value-of select="$theNodeName"/>','<xsl:value-of select="$theNodeName"/>_dom');</xsl:attribute>
							<xsl:attribute name="onfocus">this.blur();</xsl:attribute>
						</input>									
					</td>
				</tr>
				<!-- Specifies whether the baseline has to be pushed to the other party or simply lodged. -->
   			<input type="hidden" name="submission_type" id="submission_type">
   				<xsl:attribute name="value"><xsl:value-of select="$theSubmissionType"/></xsl:attribute>
   			</input>	
			</table>
		</form>
	</xsl:template>
	
	<!-- TEMPLATE Buyer Bank -->

	<xsl:template match="buyer_bank">
		<xsl:param name="theNodeName"/>
		<xsl:param name="theNodeDescription"/>
		<xsl:param name="theTypeCode"/>

		<form>
			<xsl:attribute name="name">form_<xsl:value-of select="$theNodeName"/></xsl:attribute>
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150">
						<font class="FORMMANDATORY">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_LABEL')"/>
						</font>
					</td>
					<td colspan="2">
						<select>
							<xsl:attribute name="name"><xsl:value-of select="$theNodeName"/>_type_code</xsl:attribute>
							<xsl:attribute name="onchange">fncResetBuyerBank();fncRestoreInputStyle('form_<xsl:value-of select="$theNodeName"/>','<xsl:value-of select="$theNodeName"/>_type_code');</xsl:attribute>
							<option value="">&nbsp;</option>
							<option value="01">
								<xsl:if test="$theTypeCode='01'">
									<xsl:attribute name="selected"/>
								</xsl:if>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_ISSUING')"/>
							</option>
							<option value="02">
								<xsl:if test="$theTypeCode='02'">
									<xsl:attribute name="selected"/>
								</xsl:if>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_ADVISING')"/>
							</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150">
						<font class="FORMMANDATORY">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
						</font>
					</td>
					<td colspan="2">
						<input type="text" size="35" maxlength="35">
							<xsl:attribute name="name"><xsl:value-of select="$theNodeName"/>_name</xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="name"/></xsl:attribute>
							<xsl:attribute name="onfocus">this.blur()</xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<font class="FORMMANDATORY">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BIC_CODE')"/>
						</font>
					</td>
					<td colspan="2">
						<input type="text" size="11" maxlength="11">
							<xsl:attribute name="name"><xsl:value-of select="$theNodeName"/>_iso_code</xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="iso_code"/></xsl:attribute>
							<xsl:attribute name="onfocus">this.blur()</xsl:attribute>
						</input>
					</td>
				</tr>
			</table>
		</form>
	</xsl:template>
	
	<!-- Seller Bank -->
	<xsl:template match="seller_bank">
		<xsl:param name="theNodeName"/>
		<xsl:param name="theNodeDescription"/>
		<xsl:param name="theTypeCode"/>

		<form>
			<xsl:attribute name="name">form_<xsl:value-of select="$theNodeName"/></xsl:attribute>
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_LABEL')"/></td>
					<td colspan="2">
						<select>
							<xsl:attribute name="name"><xsl:value-of select="$theNodeName"/>_type_code</xsl:attribute>
							<xsl:attribute name="onchange">fncResetSellerBank();fncRestoreInputStyle('form_<xsl:value-of select="$theNodeName"/>','<xsl:value-of select="$theNodeName"/>_type_code');</xsl:attribute>
							<option value="">&nbsp;</option>
							<option value="02">
								<xsl:if test="$theTypeCode='02'">
									<xsl:attribute name="selected"/>
								</xsl:if>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_ADVISING')"/>
							</option>
							<option value="01">
								<xsl:if test="$theTypeCode='01'">
									<xsl:attribute name="selected"/>
								</xsl:if>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_ISSUING')"/>
							</option>
						</select>
					</td>
				</tr>		
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150">
						<font class="FORMMANDATORY">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
						</font>
					</td>
					<td colspan="2">
						<input type="text" size="35" maxlength="35">
							<xsl:attribute name="name"><xsl:value-of select="$theNodeName"/>_name</xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="name"/></xsl:attribute>
							<xsl:attribute name="onfocus">this.blur()</xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<font class="FORMMANDATORY">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BIC_CODE')"/>
						</font>
					</td>
					<td colspan="2">
						<input type="text" size="11" maxlength="11">
							<xsl:attribute name="name"><xsl:value-of select="$theNodeName"/>_iso_code</xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="iso_code"/></xsl:attribute>
							<xsl:attribute name="onfocus">this.blur()</xsl:attribute>
						</input>
					</td>
				</tr>
			</table>
		</form>
	</xsl:template>
	
	<!--Other Templates-->	
	<!--TEMPLATE Customer Reference-->

	<xsl:template match="customer_references/customer_reference">
		<option>
			<xsl:attribute name="value"><xsl:value-of select="reference"/></xsl:attribute>
			<xsl:if test="//buyer_reference=reference">
				<xsl:attribute name="selected"/>
			</xsl:if>
			<xsl:value-of select="description"/> (<xsl:value-of select="reference"/>)
		</option>
	</xsl:template>
		
</xsl:stylesheet>
