<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
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
	<xsl:param name="product-code"/>
	<xsl:param name="displaymode"/>
	<xsl:param name="mode"/>
    <xsl:param name="realform-action"/>
    <xsl:param name="collaborationmode"/>
    <xsl:param name="section_line_item_adjustments_details"/>
    <xsl:param name="section_line_item_taxes_details"/>
    <xsl:param name="section_line_item_freight_charges_details"/>
    <xsl:param name="section_line_item_shipment_details"/>
    <xsl:param name="section_line_item_inco_terms_details"/>
    <xsl:param name="searchImage"><xsl:value-of select="$images_path"/>search.png</xsl:param>
    <xsl:param name="executeImage"><xsl:value-of select="$images_path"/>execute.png</xsl:param>
	<xsl:param name="editImage"><xsl:value-of select="$images_path"/>edit.png</xsl:param>
	<xsl:param name="deleteImage"><xsl:value-of select="$images_path"/>delete.png</xsl:param>

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
		<script type="text/javascript">
			<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script type="text/javascript" src="/content/OLD/javascript/openaccount/trade_message_utilize.js"/>
		<script type="text/javascript" src="/content/OLD/javascript/com_amount.js"/>
		<script type="text/javascript" src="/content/OLD/javascript/com_currency.js"/>
		<script type="text/javascript" src="/content/OLD/javascript/com_attachment.js"></script>
		
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

			<div style="display:none;">
				<table>
					<tbody>
						<xsl:attribute name="id">files_template</xsl:attribute>
						<xsl:call-template name="FILES_UPLOAD_DETAILS">
							<xsl:with-param name="structure_name">files</xsl:with-param>
							<xsl:with-param name="mode">template</xsl:with-param>
							<xsl:with-param name="formName">sendfiles</xsl:with-param>
							<xsl:with-param name="max_file">1</xsl:with-param>
						</xsl:call-template>
					</tbody>
				</table>
			</div>
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
			
			<input type="hidden" name="prod_stat_code">
				<xsl:if test="product_code[.='PO']"><xsl:attribute name="value">04</xsl:attribute></xsl:if>
			</input>
			
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
				
   			<!-- Show the Invoice ID if existing (eg: for presentation reporting) -->
   			<xsl:if test="product_code[.='PO'] and (invoice_cust_ref_id[.!=''] or org_previous_file/po_tnx_record/invoice_cust_ref_id[.!=''])">
   				<tr>
   					<td width="40">&nbsp;</td>
   					<td width="150">
   						<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IN_ISSUER_REF_ID')"/>
   					</td>
   					<td>
   						<font class="REPORTDATA">
   							<xsl:choose>
	                        <xsl:when test="invoice_cust_ref_id[.!='']"><xsl:value-of select="invoice_cust_ref_id"/></xsl:when>
	                        <xsl:otherwise><xsl:value-of select="org_previous_file/po_tnx_record/invoice_cust_ref_id"/></xsl:otherwise>
                        </xsl:choose>
   						</font>
   						<input type="hidden" name="invoice_cust_ref_id">
   							<xsl:attribute name="value">
      							<xsl:choose>
   	                        <xsl:when test="invoice_cust_ref_id[.!='']"><xsl:value-of select="invoice_cust_ref_id"/></xsl:when>
   	                        <xsl:otherwise><xsl:value-of select="org_previous_file/po_tnx_record/invoice_cust_ref_id"/></xsl:otherwise>
                           </xsl:choose>
   							</xsl:attribute>
   						</input>
   					</td>
   				</tr>
   			</xsl:if>
				<tr>
   				<td width="40">&nbsp;</td>
   				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_UTILIZATION_INVOICE_AMOUNT')"/></td>
   				<td><font class="REPORTDATA"><xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/></font></td>
   				<input type="hidden" name="org_amt"><xsl:attribute name="value"><xsl:value-of select="tnx_amt"/></xsl:attribute></input>
   				<input type="hidden" name="org_cur_code"><xsl:attribute name="value"><xsl:value-of select="tnx_cur_code"/></xsl:attribute></input>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150">
						<font class="FORMMANDATORY">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_DISCREPANCY_RESPONSE')"/>
						</font>
					</td>
					<td>
						<select name="sub_tnx_type_code">
							<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','sub_tnx_type_code')</xsl:attribute>
							<xsl:attribute name="onchange">fncResetPaidAmount();</xsl:attribute>
							<option value ="">
								<xsl:if test="sub_tnx_type_code[.='']">
									<xsl:attribute name="selected"/>
								</xsl:if>
							</option>
							<option value="08">
								<xsl:if test="sub_tnx_type_code[.='08']">
									<xsl:attribute name="selected"/>
								</xsl:if>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/>
							</option>
							<option value="09">
								<xsl:if test="sub_tnx_type_code[.='09']">
									<xsl:attribute name="selected"/>
								</xsl:if>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/>
							</option>
						</select>
					</td>
				</tr>
				<!--
				<tr>
   				<td width="40">&nbsp;</td>
   				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRESENTATION_FINAL')"/></td>
   				<td><font class="REPORTDATA"><xsl:value-of select="localization:getDecode($language, 'N034', final_presentation)"/></font></td>
				</tr>
				-->
				<!-- No PAID amount for CALYON -->
				<input type="hidden" name="tnx_cur_code">
					<xsl:attribute name="value"><xsl:value-of select="tnx_cur_code"/></xsl:attribute>
				</input>
				<input type="hidden" name="tnx_amt">
					<xsl:attribute name="value"><xsl:value-of select="tnx_amt"/></xsl:attribute>
				</input>
				<!--
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150">
						<font class="FORMMANDATORY">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_UTILIZATION_PAID_AMOUNT')"/>
						</font>
					</td>
					<td>
						<input type="text" size="3" maxlength="3" name="tnx_cur_code" onblur="fncRestoreInputStyle('fakeform1','tnx_cur_code');fncCheckValidCurrency(this);fncFormatAmount(document.forms['fakeform1'].tnx_amt, fncGetCurrencyDecNo(this.value));">
							<xsl:attribute name="value"><xsl:value-of select="tnx_cur_code"/></xsl:attribute>
							<xsl:attribute name="onfocus">fncPaymentReadOnly(this);</xsl:attribute>
						</input>
						<input type="text" size="20" maxlength="15" name="tnx_amt" onblur="fncRestoreInputStyle('fakeform1','tnx_amt');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].tnx_cur_code.value));">
							<xsl:attribute name="value"><xsl:value-of select="tnx_amt"/></xsl:attribute>
							<xsl:attribute name="onfocus">fncPaymentReadOnly(this);</xsl:attribute>
						</input>&nbsp;
						<a name="anchor_search_po_currency" href="javascript:void(0)">
   						<xsl:attribute name="onclick">fncSearchPopup('currency', 'fakeform1',"['tnx_cur_code']");return false;</xsl:attribute>
   						<img border="0" src="/content/images/search.png" name="img_search_po_currency">
   							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
   						</img>
						</a>
					</td>
				</tr>
				-->
				<!--
				<tr>
   				<td width="40">&nbsp;</td>
   				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_PO_TOTAL_NET_AMT_LABEL')"/></td>
   				<td><font class="REPORTDATA"><xsl:value-of select="total_net_cur_code"/>&nbsp;<xsl:value-of select="total_net_amt"/></font></td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_NET_AMT_LABEL')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="liab_total_net_cur_code"/>&nbsp;<xsl:value-of select="liab_total_net_amt"/></font></td>
				</tr>
				-->
				<tr><td colspan="3">&nbsp;</td></tr>
				<!--
				<tr>
					<td width="40">&nbsp;</td>
					<td colspan="2"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_UTILIZATION_FINANCING_REQUEST')"/>&nbsp;
						<input type="checkbox" name="financing_request_flag">
							<xsl:attribute name="onclick">fncPaymentReadOnly(this);</xsl:attribute>
						</input>
					</td>
				</tr>
				-->
			</table>
			<!-- No need to ACK financing for CALYON
			<xsl:if test="org_previous_file/po_tnx_record/supplier_fin_request_flag[.='Y']">
				<table border="0" width="570" cellpadding="0" cellspacing="0">
   				<tr>
   					<td width="40">&nbsp;</td>
   					<td width="200">
   						<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_UTILIZATION_FINANCING_ELIGIBLE')"/>
   					</td>
   					<td>
   						<select name="supplier_fin_eligible_flag">
   							<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','supplier_fin_eligible_flag')</xsl:attribute>
   							<option value ="">
   								<xsl:if test="supplier_fin_eligible_flag[.='']">
   									<xsl:attribute name="selected"/>
   								</xsl:if>
   							</option>
   							<option value="Y">
   								<xsl:if test="supplier_fin_eligible_flag[.='Y']">
   									<xsl:attribute name="selected"/>
   								</xsl:if>
   								<xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/>
   							</option>
   							<option value="N">
   								<xsl:if test="supplier_fin_eligible_flag[.='N']">
   									<xsl:attribute name="selected"/>
   								</xsl:if>
   								<xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/>
   							</option>
   						</select>
   					</td>
   				</tr>
				</table>
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_UTILIZATION_FINANCING_AMOUNT')"/>
						</td>
						<td>
								<input type="text" size="3" maxlength="3" name="supplier_fin_cur_code" onfocus="if (document.forms['fakeform1'].supplier_fin_eligible_flag.value != 'Y') this.blur();" onblur="fncRestoreInputStyle('fakeform1','supplier_fin_cur_code');fncCheckValidCurrency(this);fncFormatAmount(document.forms['fakeform1'].supplier_fin_amt,fncGetCurrencyDecNo(this.value));">
									<xsl:attribute name="value">
										<xsl:choose>
	                              <xsl:when test="inp_dttm[.='']">
	                              	<xsl:value-of select="org_previous_file/po_tnx_record/supplier_fin_cur_code"/>
	                              </xsl:when>
                                 <xsl:otherwise>
                                 	<xsl:value-of select="supplier_fin_cur_code"/>
                                 </xsl:otherwise>
                              </xsl:choose>
									</xsl:attribute>
								</input>
								<input type="text" size="20" maxlength="15" name="supplier_fin_amt" onblur="fncRestoreInputStyle('fakeform1','supplier_fin_amt');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].supplier_fin_cur_code.value));" onfocus="if (document.forms['fakeform1'].supplier_fin_eligible_flag.value != 'Y') this.blur();">
									<xsl:attribute name="value">
										<xsl:choose>
	                              <xsl:when test="inp_dttm[.='']">
	                              	<xsl:value-of select="org_previous_file/po_tnx_record/supplier_fin_amt"/>
	                              </xsl:when>
                                 <xsl:otherwise>
                                 	<xsl:value-of select="supplier_fin_amt"/>
                                 </xsl:otherwise>
                              </xsl:choose>
									</xsl:attribute>
								</input>&nbsp;
      					<a name="anchor_search_fin_currency" href="javascript:void(0)">
						<xsl:attribute name="onclick">if (document.forms['fakeform1'].supplier_fin_eligible_flag.value != 'Y') fncSearchPopup('currency', 'fakeform1',"['supplier_fin_cur_code']");return false;</xsl:attribute>
      						<img border="0" src="/content/images/search.png" name="img_search_fin_currency">
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
						</img>
					</a>
						</td>
					</tr>
				</table>
			</xsl:if>
			-->
		
			<p><br/></p>
			
			<!--Payment Terms Details-->
			<xsl:if test="$section_po_payment_terms!='N' and count(payments/payment[created_in_session='Y'])>0">
					
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
					
					<br/>
					
					<!--Payment / Settlement Details-->
					<xsl:apply-templates select="payments" mode="po_presentation">
						<xsl:with-param name="structure_name">po_payment</xsl:with-param>
					</xsl:apply-templates>
		
				<p><br/></p>
		
			</xsl:if>

			<!--Payment / Settlement Details / Save details-->
			<xsl:apply-templates select="payments" mode="po_presentation_save_payments">
				<xsl:with-param name="structure_name">po_payment</xsl:with-param>
			</xsl:apply-templates>

		
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

		<table>
			<tr>
				<td width="5">&nbsp;</td>
				<td>
					<textarea wrap="hard" name="free_format_text" cols="65" rows="12">
						<xsl:attribute name="onblur">fncFormatTextarea(this,100,65);fncRestoreInputStyle('fakeform1','free_format_text')</xsl:attribute>
						<xsl:value-of select="free_format_text"/>
					</textarea>
				</td>
				<td valign="top">
					<a href="javascript:void(0)">
						<xsl:attribute name="onclick">fncSearchPopup('phrase','fakeform1',"['free_format_text']",'', '', '<xsl:value-of select="product_code"/>');return false;</xsl:attribute>
						<xsl:attribute name="name">anchor_search_free_format_text</xsl:attribute>
						<img border="0" src="/content/images/open_dialog.png">
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_PHRASES')"/></xsl:attribute>
							<xsl:attribute name="name">img_search_free_format_text</xsl:attribute>
						</img>
					</a>
				</td>
			</tr>
		</table>
			
		</form>
		
		<p><br/></p>
		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tr>
				<td width="5">&nbsp;</td>
				<td>
					<form name="realform" accept-charset="UNKNOWN" method="POST">
						<xsl:attribute name="action">/gtp/screen/<xsl:value-of select="$screenName"/></xsl:attribute>
						<input type="hidden" name="operation" value=""/>
						<input type="hidden" name="mode" value="DRAFT"/>
						<input type="hidden" name="tnxtype" value="13"/>
						<input type="hidden" name="attIds" value=""/>
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
	<tr align="left">
	<td>
    <form name="sendfiles" id="sendfiles" enctype="multipart/form-data" method="post" target="hiddeniframe">
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1" colspan="3">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_OPTIONAL_FILE_UPLOAD')"/></b>
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

			<div>
				<xsl:attribute name="id">files_disclaimer</xsl:attribute>
				<xsl:if test="count(attachments/attachment) != 0">
					<xsl:attribute name="style">display:none</xsl:attribute>
				</xsl:if>
				<b><xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_NO_FILE_ITEM')"/></b>
			</div>

			<table border="0" width="560" cellpadding="0" cellspacing="1" id="files_master_table" >
				<xsl:if test="count(attachments/attachment) = 0">
					<xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
				</xsl:if>
				<tbody id="files_table">

					<tr>
						<xsl:attribute name="id">files_table_header_1</xsl:attribute>
						<xsl:if test="count(attachments/attachment) = 0">
							<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
						</xsl:if>
						<th class="FORMH2" align="center" width="45%"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILES_COLUMN_TITLE')"/></th>
						<th class="FORMH2" align="center" width="45%"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILES_COLUMN_FILE')"/></th>
						<th class="FORMH2" width="10%">&nbsp;</th>
					</tr>

					<xsl:for-each select="attachments/attachment">
						<xsl:call-template name="FILES_UPLOAD_DETAILS">
							<xsl:with-param name="structure_name">files</xsl:with-param>
							<xsl:with-param name="mode">existing</xsl:with-param>
							<xsl:with-param name="formName">sendfiles</xsl:with-param>
							<xsl:with-param name="max_file">1</xsl:with-param>
						</xsl:call-template>
					</xsl:for-each>
					
				</tbody>
			</table>
			<br/>
			
			<div>
				<xsl:attribute name="id">attachment_add</xsl:attribute>
				<xsl:if test="count(attachments/attachment) > 0">
					<xsl:attribute name="style">display:none</xsl:attribute>
				</xsl:if>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncPreloadImages('<xsl:value-of select="utils:getImagePath($searchImage)"/>', '<xsl:value-of select="utils:getImagePath($executeImage)"/>', '<xsl:value-of select="utils:getImagePath($editImage)"/>', '<xsl:value-of select="utils:getImagePath($deleteImage)"/>'); fncLaunchProcess("fncAddElement('sendfiles', 'files', '')");</xsl:attribute>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_ADD_FILE_ITEM')"/>
				</a>
			</div>

			<p><br/></p>
        <div id="messageCallBack"></div>
		<input type="hidden" name="attachmentid"/>
		<input type="hidden" name="identifier"/>
		<input type="hidden" name="returnFunction"/>
		<input type="hidden" name="att_company_id"><xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute></input>
		<input type="hidden" name="att_ref_id"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
		<input type="hidden" name="att_tnx_id"><xsl:attribute name="value"><xsl:value-of select="tnx_id"/></xsl:attribute></input>
		<input type="hidden" name="att_title"/>
		<input type="hidden" name="operation"/>
    </form>
    <iframe name="hiddeniframe" id="hiddeniframe" style="display:none;" src="about:blank"></iframe>
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
