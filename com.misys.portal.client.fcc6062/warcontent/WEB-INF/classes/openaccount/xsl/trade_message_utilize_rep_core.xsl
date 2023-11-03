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
	<xsl:import href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:import href="../com_attachment.xsl"/>

	<xsl:output method="html" indent="no"/>

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
	<xsl:param name="section_li_adjustment"/>
	<xsl:param name="section_li_shipment_details"/>
	<xsl:param name="section_li_inco_terms"/>
	<xsl:param name="section_li_routing_summary"/>

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<!--TEMPLATE Main-->

	<xsl:template match="po_tnx_record">

		<!--Define the nodeName and screenName variables for the current product -->

		<xsl:variable name="nodeName"><xsl:value-of select="name(.)"/></xsl:variable>
		<xsl:variable name="screenName">
			<xsl:choose>
				<xsl:when test="product_code[.='LC']">LetterOfCreditScreen</xsl:when>
				<xsl:when test="product_code[.='SI']">StandbyIssuedScreen</xsl:when>
				<xsl:when test="product_code[.='PO']">PurchaseOrderScreen</xsl:when>
			</xsl:choose>
		</xsl:variable>
		
		<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"/>
		<script type="text/javascript" src="/content/OLD/javascript/com_attachment.js"/>
		<script type="text/javascript">
			<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script type="text/javascript" src="/content/OLD/javascript/openaccount/trade_message_utilize.js"/>
		
		
		<!-- Include some eventual additional elements -->
		<xsl:call-template name="client_addons"/>
		
		<table border="0" width="100%" cellspacing="2" cellpadding="4" class="FORMTABLEBORDER">
		<tr>
		<td class="FORMTABLE" align="center">
		
		<table border="0">
		<tr>
		<td align="center">
							
			<table border="0" cellspacing="2" cellpadding="8">
				<tr>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('save','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_save.gif"/><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('submit','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_send.gif"/><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('cancel','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_cancel.gif"/><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('help','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_help.gif"/><br/>
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
			<input type="hidden" name="company_name"><xsl:attribute name="value"><xsl:value-of select="company_name"/></xsl:attribute></input>
			<input type="hidden" name="tnx_id"><xsl:attribute name="value"><xsl:value-of select="tnx_id"/></xsl:attribute></input>
			<input type="hidden" name="issuing_bank_abbv_name"><xsl:attribute name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:attribute></input>
			<input type="hidden" name="total_cur_code"><xsl:attribute name="value"><xsl:value-of select="total_cur_code"/></xsl:attribute></input>
			<input type="hidden" name="total_amt"><xsl:attribute name="value"><xsl:value-of select="total_amt"/></xsl:attribute></input>
			<!-- Previous ctl date, used for synchronisation issues -->
			<input type="hidden" name="old_ctl_dttm"><xsl:attribute name="value"><xsl:value-of select="ctl_dttm"/></xsl:attribute></input>
			
			<input type="hidden" name="prod_stat_code" value=""/>
				<!--xsl:if test="product_code[.='PO']"><xsl:attribute name="value">22</xsl:attribute></xsl:if>
			</input-->
			
			<!--General Details-->
			
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/></b>
					</td>
					<td align="right" class="FORMH1">
						<a name="anchor_view_full_details" href="javascript:void(0)">
							<xsl:attribute name="onclick">fncShowReporting('SUMMARY', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="cross_references/cross_reference[type_code='01']/tnx_id"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/preview.png" name="img_view_full_details">
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VIEW_DISCREPANCY_ADVICE')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
			</table>
			
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/>
					</td>
					<td>
						<font class="REPORTBLUE"><xsl:value-of select="ref_id"/></font>
						<input type="hidden" name="ref_id">
							<xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<xsl:if test="cust_ref_id[.!='']">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="150">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/>
						</td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="cust_ref_id"/></font>
							<input type="hidden" name="cust_ref_id">
								<xsl:attribute name="value"><xsl:value-of select="cust_ref_id"/></xsl:attribute>
							</input>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="bo_ref_id[.!='']">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="150">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/>
						</td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="bo_ref_id"/></font>
							<input type="hidden" name="bo_ref_id">
								<xsl:attribute name="value"><xsl:value-of select="bo_ref_id"/></xsl:attribute>
							</input>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="iss_date[.!='']">
					<tr><td>&nbsp;</td></tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="150">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ISSUE_DATE')"/>
						</td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="iss_date"/></font>
							<input type="hidden" name="iss_date">
								<xsl:attribute name="value"><xsl:value-of select="iss_date"/></xsl:attribute>
							</input>
						</td>
					</tr>
				</xsl:if>
	
				<tr><td colspan="3">&nbsp;</td></tr>
				
   			<tr>
   				<td width="40">&nbsp;</td>
   				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_DISCREPANCY_RESPONSE')"/></td>
   				<td>
   					<font class="REPORTBLUE">
   						<xsl:choose>
   							<xsl:when test="sub_tnx_type_code[.='08']">
   								<xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/>
   							</xsl:when>
   							<xsl:when test="sub_tnx_type_code[.='09']">
   								<xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/>
   							</xsl:when>
   						</xsl:choose>
   					</font>
   				</td>
   			</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_UTILIZATION_PAID_AMOUNT')"/></td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/></font>
					</td>
				</tr>
			</table>
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td>
						<font class="REPORTDATA">
							<xsl:choose>
								<xsl:when test="financing_request_flag[.='Y']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_UTILIZATION_FINANCING_REQUEST_ACK')"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_UTILIZATION_FINANCING_REQUEST_NACK')"/></xsl:otherwise>
							</xsl:choose>
						</font>
					</td>
				</tr>
				
			</table>
		
			<p><br/></p>
			
			<!--Payment Terms Details-->
			<xsl:if test="$section_po_payment_terms!='N' and count(payments/payment)>0">
				
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
				
				<!--Payment / Settlement Details-->
			
				<xsl:apply-templates select="payments" mode="controlled"/>
		
				<br/>
		
			</xsl:if>
		
			<!--Settlement Terms Details-->
			<xsl:if test="$section_po_settlement_terms!='N' and (seller_account_iban[.!=''] or seller_account_bban[.!='']  or seller_account_upic[.!='']  or seller_account_id[.!=''] or fin_inst_name[.!=''] or fin_inst_bic[.!=''])">
				
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
			
				<xsl:if test="seller_account_iban[.!=''] or seller_account_bban[.!='']  or seller_account_upic[.!='']  or seller_account_id[.!='']">
			
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
							<font class="REPORTDATA">
								<xsl:choose>
									<xsl:when test="seller_account_iban[.!='']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN')"/></xsl:when>
									<xsl:when test="seller_account_bban[.!='']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_BBAN')"/></xsl:when>
									<xsl:when test="seller_account_upic[.!='']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN')"/></xsl:when>
									<xsl:when test="seller_account_id[.!='']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_OTHER')"/></xsl:when>
									<xsl:otherwise/>
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
				
				</xsl:if>
				
				<xsl:if test="fin_inst_name[.!=''] or fin_inst_bic[.!='']">
			
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
						<td width="150">
							<font class="FORMMANDATORY">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
							</font>
						</td>
						<td><font class="REPORTDATA"><xsl:value-of select="fin_inst_name"/></font></td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="150">
							<font class="FORMMANDATORY">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BIC_CODE')"/>
							</font>
						</td>
						<td><font class="REPORTDATA"><xsl:value-of select="fin_inst_bic"/></font></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="fin_inst_street_name"/></font></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="fin_inst_post_code"/></font></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="fin_inst_town_name"/></font></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="fin_inst_country_sub_div"/></font></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="fin_inst_country"/></font></td>
					</tr>
				</table>
				
			</xsl:if>
		
		</xsl:if>
			
		<xsl:if test="free_format_text[.!='']">
			
			<p><br/></p>
				
			<!--Free Format Message-->
		
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREE_FORMAT')"/></b>
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
	
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="15">&nbsp;</td>
					<td>
						<font class="REPORTNORMAL">
							<xsl:call-template name="string_replace">
								<xsl:with-param name="input_text" select="free_format_text" />
							</xsl:call-template>
							<br/>
						</font>
					</td>
				</tr>
			</table>
		
		</xsl:if>
			
		</form>
		
		<p><br/></p>
		
		
		<!--Optional File Upload Details-->

		<xsl:if test="attachments/attachment/file_name[.!='']">
			<xsl:apply-templates select="attachments/attachment" mode="control"/>
		</xsl:if>
		
		<br/>
		

		
		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tr>
				<td width="5">&nbsp;</td>
				<td>
					<form name="realform" accept-charset="UNKNOWN" method="POST" enctype="multipart/form-data">
						<xsl:attribute name="action">/gtp/screen/<xsl:value-of select="$screenName"/></xsl:attribute>
						<input type="hidden" name="operation" value=""/>
						<input type="hidden" name="mode" value="UNSIGNED"/>
						<input type="hidden" name="tnxtype" value="13"/>
						<input type="hidden" name="TransactionData"/>
						<xsl:call-template name="hidden-field">
						   <xsl:with-param name="name">referenceid</xsl:with-param>
						   <xsl:with-param name="value" select="ref_id"/>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
						   <xsl:with-param name="name">tnxid</xsl:with-param>
						   <xsl:with-param name="value" select="tnx_id"/>
						</xsl:call-template>						
					</form>
				</td>
			</tr>
		</table>

		<p><br/></p>
					
	</td>
	</tr>
	<tr>
		<td align="center">
			<table border="0" cellspacing="2" cellpadding="8">
				<tr>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('save','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_save.gif"/><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('submit','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_send.gif"/><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('cancel','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_cancel.gif"/><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('help','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_help.gif"/><br/>
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
