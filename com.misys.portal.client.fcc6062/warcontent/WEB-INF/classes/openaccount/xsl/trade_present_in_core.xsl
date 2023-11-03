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

	<xsl:import href="po_common.xsl"/>
	<xsl:import href="../com_attachment.xsl"/>
	
	<xsl:output method="html" indent="no" />

	<!-- All marks used to shown/hidden form's sections-->
	<xsl:param name="section_in_line_items"/>
	<xsl:param name="section_in_amount_details"/>
	<xsl:param name="section_in_inco_terms"/>
	<xsl:param name="section_in_routing_summary"/>
	
	<xsl:param name="section_li_product"/>
	<xsl:param name="section_li_amount_details"/>
	<xsl:param name="section_li_shipment_details"/>
	<xsl:param name="section_li_inco_terms"/>
	<xsl:param name="section_li_routing_summary"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="executeImage"><xsl:value-of select="$images_path"/>execute.png</xsl:param>
	<xsl:param name="editImage"><xsl:value-of select="$images_path"/>edit.png</xsl:param>
	<xsl:param name="deleteImage"><xsl:value-of select="$images_path"/>delete.png</xsl:param>
	<xsl:param name="searchImage"><xsl:value-of select="$images_path"/>search.png</xsl:param>
	
	

	<!-- Get the language code -->
	<xsl:param name="language"/>
	
	<xsl:template match="/">
		<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"></script>
		<script type="text/javascript">
			<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script type="text/javascript" src="/content/OLD/javascript/com_currency.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/openaccount/trade_present_in.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/openaccount/com_functions_po.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_amount.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_date.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_attachment.js"></script>
			
		<xsl:apply-templates select="in_tnx_record"/>
	</xsl:template>

	<!-- -->
	<!--TEMPLATE Main for document preparation (upload)-->
	<!-- -->
	<xsl:template match="in_tnx_record">
		

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
	
			<form name="fakeform1" onsubmit="return false;">
	
				<!--Insert the Branch Code and Company ID as hidden fields-->
				
				<input type="hidden" name="brch_code"><xsl:attribute name="value"><xsl:value-of select="brch_code"/></xsl:attribute></input>
				<input type="hidden" name="company_id"><xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute></input>
				<input type="hidden" name="company_name"><xsl:attribute name="value"><xsl:value-of select="company_name"/></xsl:attribute></input>
				<input type="hidden" name="tnx_id"><xsl:attribute name="value"><xsl:value-of select="tnx_id"/></xsl:attribute></input>
				<input type="hidden" name="ref_id"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
      			<!-- Previous ctl date, used for synchronisation issues -->
      			<input type="hidden" name="old_ctl_dttm"><xsl:attribute name="value"><xsl:value-of select="ctl_dttm"/></xsl:attribute></input>
				<input type="hidden" name="issuer_ref_id"><xsl:attribute name="value"><xsl:value-of select="issuer_ref_id"/></xsl:attribute></input>
				<input type="hidden" name="sub_tnx_type_code"><xsl:attribute name="value"><xsl:value-of select="sub_tnx_type_code"/></xsl:attribute></input>
				<input type="hidden" name="tnx_type_code"><xsl:attribute name="value"><xsl:value-of select="tnx_type_code"/></xsl:attribute></input>
				
				<input type="hidden" name="presentation_flag"><xsl:attribute name="value">Y</xsl:attribute></input>

				<!--The following general details are fetched from database, and the data already localized-->
				<!--General Details-->
		
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="3">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/></b>
						</td>
						<td align="right" class="FORMH1">
						<xsl:choose>
							<xsl:when test="sub_tnx_type_code[.!='04']">
		   						<a name="anchor_view_full_details" href="javascript:void(0)">
		   							<xsl:attribute name="onclick">fncShowReporting('DETAILS', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>');return false;</xsl:attribute>
		   							<img border="0" src="/content/images/preview.png" name="img_view_full_details">
		   								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VIEW_INVOICE')"/></xsl:attribute>
		   							</img>
		   						</a>
							</xsl:when>
							<xsl:otherwise>						
								<td align="right" class="FORMH1">
									<a name="anchor_view_full_details" href="javascript:void(0)">
										<xsl:attribute name="onclick">fncShowReporting('DETAILS', '<xsl:value-of select="org_previous_file/so_tnx_record/product_code"/>', '<xsl:value-of select="org_previous_file/so_tnx_record/ref_id"/>');return false;</xsl:attribute>
										<img border="0" src="/content/images/preview.png" name="img_view_full_details">
											<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VIEW_TRANSACTION_DETAILS')"/></xsl:attribute>
										</img>
									</a>
								</td>
							</xsl:otherwise>
						</xsl:choose>
					</td>
					</tr>
				</table>
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<!--tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_FOLDER_REF_ID')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="ref_id"/></font>
							<input type="hidden" name="ref_id"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
						</td>
					</tr-->
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="ref_id"/></font>
							<input type="hidden" name="ref_id"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
						</td>
					</tr>
					<xsl:if test="cust_ref_id[.!='']">
   					<tr>
   						<td width="40">&nbsp;</td>
   						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/></td>
   						<td>
   							<font class="REPORTDATA"><xsl:value-of select="cust_ref_id"/></font>
   							<input type="hidden" name="cust_ref_id"><xsl:attribute name="value"><xsl:value-of select="cust_ref_id"/></xsl:attribute></input>
   						</td>
   					</tr>
					</xsl:if>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="appl_date"/></font>
							<input type="hidden" name="appl_date"><xsl:attribute name="value"><xsl:value-of select="appl_date"/></xsl:attribute></input>
						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
				</table>
				<table width="570" border="0" cellpadding="0" cellspacing="0">
					<!--
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170">
							<font class="FORMMANDATORY">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_PRESENTATION_REF_ID')"/>
							</font>
						</td>
						<td>
							<input type="text" size="15" maxlength="34" name="data_set_id" onblur="fncRestoreInputStyle('fakeform1','data_set_id');">
								<xsl:attribute name="value"><xsl:value-of select="data_set_id"/></xsl:attribute>
							</input>
						</td>
					</tr>
					-->
					<!--	
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CREDIT_REFERENCE')"/></td>
						<td>
							<input type="text" size="15" maxlength="34" name="parent_ref_id" onblur="fncRestoreInputStyle('fakeform1','parent_ref_id');">
								<xsl:attribute name="value"><xsl:value-of select="parent_ref_id"/></xsl:attribute>
							</input>
						</td>
					</tr>
					-->	
         		<tr>
         			<td width="40">&nbsp;</td>
         			<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/></td>
         			<td>
         				<input type="text" size="15" maxlength="34" name="cust_ref_id" onblur="fncRestoreInputStyle('fakeform1','cust_ref_id');">
         					<xsl:attribute name="value"><xsl:value-of select="cust_ref_id"/></xsl:attribute>
         				</input>
         			</td>
         		</tr>	
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRESENTATION_AMOUNT')"/>
						</td>
						<td>
							<input type="text" size="3" maxlength="3" name="tnx_cur_code">
								<xsl:attribute name="value"><xsl:value-of select="tnx_cur_code"/></xsl:attribute>
   							<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','tnx_cur_code');fncCheckValidCurrency(this);fncFormatAmount(document.forms['fakeform1'].tnx_amt,fncGetCurrencyDecNo(this.value)); if (document.forms['fakeform1'].financing_request_flag) { if (document.forms['fakeform1'].financing_request_flag.checked) {document.forms['fakeform1'].fin_cur_code.value=document.forms['fakeform1'].tnx_cur_code.value;document.forms['fakeform1'].fin_amt.value=document.forms['fakeform1'].tnx_amt.value;}};document.forms['fakeform1'].total_cur_code.value=this.value</xsl:attribute>
							</input>
							<input type="text" size="20" maxlength="15" name="tnx_amt" >
								<xsl:attribute name="value"><xsl:value-of select="tnx_amt"/></xsl:attribute>
   							<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','tnx_amt');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].tnx_cur_code.value)); if (document.forms['fakeform1'].financing_request_flag) { if (document.forms['fakeform1'].financing_request_flag.checked) {document.forms['fakeform1'].fin_cur_code.value=document.forms['fakeform1'].tnx_cur_code.value;document.forms['fakeform1'].fin_amt.value=document.forms['fakeform1'].tnx_amt.value;}};document.forms['fakeform1'].total_amt.value=this.value</xsl:attribute>
							</input>&nbsp;
      					<a name="anchor_search_invoice_currency" href="javascript:void(0)">
      						<xsl:attribute name="onclick">fncSearchPopup('currency', 'fakeform1',"['tnx_cur_code']");return false;</xsl:attribute>
            						<img border="0" name="img_search_invoice_currency">
            						<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchImage)"/></xsl:attribute>
      								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
      						</img>
      					</a>
      					<input name="total_amt" type="hidden"><xsl:attribute name="value"><xsl:value-of select="tnx_amt"/></xsl:attribute></input>
						<input name="total_cur_code" type="hidden"><xsl:attribute name="value"><xsl:value-of select="tnx_cur_code"/></xsl:attribute></input>
							
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRESENTATION_FINAL')"/>
						</td>
						<td>
							<input type="checkbox" name="final_presentation">
								<xsl:if test="final_presentation[.='Y']">
									<xsl:attribute name="checked"/>
								</xsl:if>
							</input>
						</td>
					</tr>
					<tr>
   					<td colspan="3">&nbsp;</td>
 					</tr>
   				<tr>
   					<td width="40">&nbsp;</td>
   					<td colspan="2"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_UTILIZATION_FINANCING_REQUEST')"/>&nbsp;
   						<input type="checkbox" name="financing_request_flag">
   							<xsl:attribute name="onclick">if (document.forms['fakeform1'].financing_request_flag.checked) {document.forms['fakeform1'].fin_cur_code.value=document.forms['fakeform1'].tnx_cur_code.value;document.forms['fakeform1'].fin_amt.value=document.forms['fakeform1'].tnx_amt.value;} else {document.forms['fakeform1'].fin_cur_code.value='';document.forms['fakeform1'].fin_amt.value='';}</xsl:attribute>
   							<xsl:if test="financing_request_flag[. = 'Y']">
									<xsl:attribute name="checked"/>
								</xsl:if>
   						</input>
   					</td>
   				</tr>
				</table>
				<table width="570" border="0" cellpadding="0" cellspacing="0">
					<input type="hidden" name="fin_cur_code">
						<xsl:attribute name="value"><xsl:value-of select="fin_cur_code"/></xsl:attribute>
					</input>
					<input type="hidden" name="fin_amt">
						<xsl:attribute name="value"><xsl:value-of select="fin_amt"/></xsl:attribute>
					</input>
   				<!--
 					<tr>
						<td width="40">&nbsp;</td>
						<td width="170">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_FINANCING_AMOUNT')"/>
						</td>
						<td>
							<input type="text" size="3" maxlength="3" name="fin_cur_code" onfocus="if (!document.forms['fakeform1'].financing_request_flag.checked) this.blur();" onblur="fncRestoreInputStyle('fakeform1','fin_cur_code');fncCheckValidCurrency(this);fncFormatAmount(document.forms['fakeform1'].fin_amt,fncGetCurrencyDecNo(this.value));">
								<xsl:attribute name="value"><xsl:value-of select="fin_cur_code"/></xsl:attribute>
							</input>
							<input type="text" size="20" maxlength="15" name="fin_amt" onblur="fncRestoreInputStyle('fakeform1','fin_amt');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].fin_cur_code.value));" onfocus="if (!document.forms['fakeform1'].financing_request_flag.checked) this.blur();">
								<xsl:attribute name="value"><xsl:value-of select="fin_amt"/></xsl:attribute>
							</input>&nbsp;
      					<a name="anchor_search_fin_currency" href="javascript:void(0)">
      						<xsl:attribute name="onclick">if (document.forms['fakeform1'].financing_request_flag.checked) fncSearchPopup('currency', 'fakeform1',"['fin_cur_code']");return false;</xsl:attribute>
            						<img border="0" src="/content/images/search.png" name="img_search_fin_currency">
      							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
      						</img>
      					</a>
						</td>
					</tr>
					-->
					<!--tr>
						<td width="40">&nbsp;</td>
						<td width="170">
							<font class="FORMMANDATORY">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PRESENTATION_TO_BANK')"/>
							</font>
						</td>
						<td>
							<select name="issuing_bank_abbv_name" onchange="document.forms['fakeform1'].issuing_bank_name.value = this.options[this.selectedIndex].text">
								<xsl:apply-templates select="issuing_bank"/>
								<xsl:apply-templates select="potential_issuing_bank"/>
							</select>
							<input type="hidden" name="issuing_bank_name">
								<xsl:attribute name="value">
									<xsl:choose>
										<xsl:when test="issuing_bank/name[.!='']">
											<xsl:value-of select="issuing_bank/name"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="potential_issuing_bank[position()='1']/name"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute>
							</input>
						</td>
					</tr-->
				</table>
					<!--Issuing Bank -->
					<input type="hidden" name="issuing_bank_name">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="issuing_bank/name[.!='']">
									<xsl:value-of select="issuing_bank/name"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="potential_issuing_bank[position()='1']/name"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</input>
							
					<input type="hidden" name="issuing_bank_abbv_name">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="issuing_bank/abbv_name[.!='']">
									<xsl:value-of select="issuing_bank/abbv_name"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="potential_issuing_bank[position()='1']/abbv_name"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</input>
					
					<!-- Submitter BIC (is the same as issuing bank) -->
					<input type="hidden" name="submitr_bic">
						<xsl:attribute name="value"><xsl:value-of select="issuing_bank/iso_code"/></xsl:attribute>
					</input>
					

				<p><br/></p>
				
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
					<input type="radio" value="AMNT" name="payment_terms_type" onclick="fncCheckPaymentTerms('fakeform1','po_payment')">
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
					<input type="radio" value="PRCT" name="payment_terms_type" onclick="fncCheckPaymentTerms('fakeform1','po_payment')">		
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
						<xsl:with-param name="form_name">fakeform1</xsl:with-param>
						<xsl:with-param name="default_cur_code"><xsl:value-of select="tnx_cur_code"/></xsl:with-param>
						<!-- <xsl:with-param name="created_in_session">Y</xsl:with-param>-->
					</xsl:call-template>
				</tbody>
			</table>
		</div>
		
		<xsl:call-template name="payments">
			<xsl:with-param name="structure_name">po_payment</xsl:with-param>
			<xsl:with-param name="form_name">fakeform1</xsl:with-param>
			<xsl:with-param name="currency">tnx_cur_code</xsl:with-param>
			<xsl:with-param name="currency_form_name">fakeform1</xsl:with-param>
			<!-- <xsl:with-param name="created_in_session">Y</xsl:with-param>-->
		</xsl:call-template>
		
		<p><br/></p>
		
		
		<!--Parties Details-->
				
				<!-- 
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="3">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PARTIES_DETAILS')"/></b>
						</td>
					</tr>
				</table>
						
				<br/>
				
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
						<td><font class="REPORTDATA"><xsl:value-of select="buyer_name"/></font></td>
					</tr>
      			<tr>
      				<td width="40">&nbsp;</td>
      				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/></td>
      				<td><font class="REPORTDATA"><xsl:value-of select="buyer_bei"/></font></td>
      			</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="buyer_street_name"/></font></td>
					</tr>
      			<tr>
      				<td>&nbsp;</td>
      				<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/></td>
      				<td><font class="REPORTDATA"><xsl:value-of select="buyer_post_code"/></font></td>
      			</tr>
					<tr>
						<td>&nbsp;</td>
      				<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="buyer_town_name"/></font></td>
					</tr>
      			<tr>
      				<td>&nbsp;</td>
      				<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/></td>
      				<td><font class="REPORTDATA"><xsl:value-of select="buyer_country_sub_div"/></font></td>
      			</tr>
      			<tr>
      				<td>&nbsp;</td>
      				<td><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/></td>
      				<td><font class="REPORTDATA"><xsl:value-of select="buyer_country"/></font></td>
      			</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
						<td><font class="REPORTDATA"><xsl:value-of select="buyer_reference"/></font></td>
					</tr>
						
				</table>
				
				<p><br/></p>
				-->
				
				<!--Free Format Message-->

				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREE_FORMAT_INSTRUCTIONS')"/></b>
						</td>
					</tr>
				</table>
				
				<br/>
	
				<!--
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="05">&nbsp;</td>
						<td>
							<input type="checkbox" name="type_checkbox" onclick="if (this.checked) document.fakeform1.type.value='02'; else document.fakeform1.type.value='01';">
								<xsl:if test="type[.='02']">
									<xsl:attribute name="checked"/>
								</xsl:if>
							</input>
							<input type="hidden" name="type">
								<xsl:attribute name="value"><xsl:value-of select="type"/></xsl:attribute>
							</input>
						</td>
						<td>&nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRESENTATION_COMPLETE')"/></td>
					</tr>
				</table>
				<br/>
				-->
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="5">&nbsp;</td>
						<td>
							<textarea wrap="hard" name="free_format_text" cols="65" rows="8">
								<xsl:attribute name="onblur">fncFormatTextarea(this,100,65);fncRestoreInputStyle('fakeform1','free_format_text');</xsl:attribute>
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
					
			<br/>
		
			<xsl:if test="sub_tnx_type_code[.!='04']">
   			<table border="0" cellspacing="0" width="570">
   				<tr>
   					<td width="5">&nbsp;</td>
   					<td>
         				<xsl:value-of select="localization:getGTPString($language, 'XSL_PRESENT_IN_PREVIEW')"/>&nbsp;
         				<a name="anchor_preview" href="javascript:void(0)" target="_blank">
         					<!--xsl:attribute name="onclick">document.form_in_preview.submit();return false;</xsl:attribute-->
         					<xsl:attribute name="onclick">fncExportDocument('IN', 'PDF_IN', '<xsl:value-of select="ref_id"/>', '', 'DRAFT');return false;</xsl:attribute>
         					<img border="0" src="/content/images/pic_end.gif" name="img_preview">
         						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VIEW_ADVICE')"/></xsl:attribute>
         					</img>
         				</a>
   					</td>
   				</tr>
   			</table>
   		</xsl:if>

				<!--Document Selection-->
				<!--
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="3">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DOCUMENTS_PRESENTED')"/></b>
						</td>
					</tr>
				</table>
				<br/>
			
					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
							<td align="center">
								<table border="0" width="570" cellpadding="0" cellspacing="1">
									<tr>
										<th class="FORMH2" nowrap="nowrap" width="20" align="center"></th>
										<th class="FORMH2" align="center" width="100" nowrap="nowrap"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_REFERENCE_FULL')"/></th>
										<th class="FORMH2" align="center" nowrap="nowrap"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_VERSION_FULL')"/></th>
										<th class="FORMH2" align="center" nowrap="nowrap"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_TYPE')"/></th>
										<th class="FORMH2" align="center" colspan="2"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_PRES_FORMAT')"/></th>
									</tr>
               				<xsl:call-template name="collection_document">
               					<xsl:with-param name="document_key" select="1"/>
               					<xsl:with-param name="document_title" select="title"/>
               					<xsl:with-param name="document_code" select="code"/>
               					<xsl:with-param name="document_id" select="document_id"/>
               					<xsl:with-param name="attachment_id" select="attachment_id"/>
               					<xsl:with-param name="document_type" select="type"/>
               					<xsl:with-param name="document_format" select="format"/>
               					<xsl:with-param name="document_transformation_code" select="transformation_code"/>
               					<xsl:with-param name="document_cust_ref_id" select="cust_ref_id"/>
               					<xsl:with-param name="document_version" select="version"/>
               					<xsl:with-param name="tnx_id" select="tnx_id"/>
               					<xsl:with-param name="ref_id" select="ref_id"/>
               					<xsl:with-param name="attached" select="attached"/>
               					<xsl:with-param name="transformation_node" select="transformation"/>
               				</xsl:call-template>
								</table>
							</td>
						</tr>
						<tr>
							<td width="40">&nbsp;</td>
							<td/>
						</tr>
						<tr>
							<td width="40">&nbsp;</td>
							<td/>
						</tr>
					</table>
					-->

				<br/>
				
			</form>
					
			<form name="realform" accept-charset="UNKNOWN" method="POST" action="/gtp/screen/InvoiceScreen">
				<input type="hidden" name="operation" value="SAVE"/>
				<input type="hidden" name="mode" value="DRAFT"/>
				<input type="hidden" name="tnxtype"><xsl:attribute name="value"><xsl:value-of select="tnx_type_code"/></xsl:attribute></input>
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



	<!-- Display a document form
	<xsl:template name="collection_document">
		<xsl:param name="document_key"/>
		<xsl:param name="document_title"/>
		<xsl:param name="document_code"/>
		<xsl:param name="document_id"/>
		<xsl:param name="attachment_id"/>
		<xsl:param name="document_type"/>
		<xsl:param name="document_format"/>
		<xsl:param name="document_transformation_code"/>
		<xsl:param name="document_cust_ref_id"/>
		<xsl:param name="document_version"/>
		<xsl:param name="tnx_id"/>
		<xsl:param name="ref_id"/>
		<xsl:param name="attached"/>
		<xsl:param name="transformation_node"/>
		
		<tr>
			<td nowrap="nowrap" align="center">&nbsp;&nbsp;<xsl:value-of select="$document_key"/>&nbsp;&nbsp;</td>
			<td nowrap="nowrap" align="left">
				<input type="hidden">
					<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_version</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_version"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_tnx_id</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$tnx_id"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_type</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_type"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_format</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_format"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_title</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_title"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_id</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_id"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_code</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_code"/></xsl:attribute>
				</input>
				<input type="hidden">
					<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_cust_ref_id</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="$document_cust_ref_id"/></xsl:attribute>
				</input>
				<xsl:if test="(not($document_cust_ref_id)) or ($document_cust_ref_id='')">
					<xsl:text>&nbsp;</xsl:text>
				</xsl:if>
				<xsl:value-of select="$document_cust_ref_id"/>
			</td>
			<td align="center" nowrap="nowrap">
				<xsl:if test="(not($document_version)) or ($document_version='')">
					<xsl:text>-</xsl:text>
				</xsl:if><xsl:value-of select="$document_version"/>
			</td>
			<td align="left" nowrap="nowrap">
				&nbsp;<xsl:choose>
					<xsl:when test="$document_code!='00'">
						<xsl:variable name="localization_key"><xsl:value-of select="code"/></xsl:variable>
						<xsl:value-of select="localization:getDecode($language, 'N023', $localization_key)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$document_title"/>
					</xsl:otherwise>
				</xsl:choose>&nbsp;
			</td>
			<xsl:choose>
				<xsl:when test="$transformation_node and $attached='Y'">
					<td align="left">
						<select>
							<xsl:attribute name="name">option_<xsl:value-of select="document_id"/>_transformation</xsl:attribute>
							<option>
								<xsl:attribute name="name"><xsl:value-of select="$document_transformation_code"/></xsl:attribute>
								<xsl:attribute name="value"><xsl:value-of select="$document_transformation_code"/></xsl:attribute>
								<xsl:attribute name="selected"/>
								<xsl:value-of select="localization:getDecode($language, 'N036', $document_transformation_code)"/>
							</option>
							<option>
								<xsl:attribute name="name"></xsl:attribute>
								<xsl:attribute name="value"></xsl:attribute>
							</option>
							<xsl:apply-templates select="$transformation_node[transformation_code!=$document_transformation_code]"/>
						</select>
					</td>
				</xsl:when>
				<xsl:when test="$transformation_node">
					<td align="left">
						<select>
							<xsl:attribute name="name">option_<xsl:value-of select="document_id"/>_transformation</xsl:attribute>
							<option>
								<xsl:attribute name="name"></xsl:attribute>
								<xsl:attribute name="value"></xsl:attribute>
								<xsl:attribute name="selected"/>
							</option>
							<xsl:apply-templates select="$transformation_node"/>
						</select>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td align="center">-</td>
				</xsl:otherwise>
			</xsl:choose>
			<td align="center">
				<a name="anchor_preview" href="javascript:void(0)" target="_blank">
					<xsl:attribute name="onclick">var transformation = option_<xsl:value-of select="document_id"/>_transformation.options[option_<xsl:value-of select="document_id"/>_transformation.selectedIndex].value; fncExportDocument(transformation,'<xsl:value-of select="$document_id"/>','<xsl:value-of select="$document_code"/>','<xsl:value-of select="$document_format"/>', '<xsl:value-of select="$ref_id"/>');return false;</xsl:attribute>
					<img border="0" src="/content/images/pic_end.gif" name="img_preview">
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VIEW_ADVICE')"/></xsl:attribute>
					</img>
				</a>
			</td>
		</tr>
		
	</xsl:template>
	-->


	<!--TEMPLATE Seller \ Issuing Bank: shows the selection popup of available issuing banks-->

	<xsl:template match="issuing_bank | potential_issuing_bank">
		<option>
			<xsl:attribute name="value"><xsl:value-of select="abbv_name"/></xsl:attribute>
			<xsl:value-of select="name"/>
		</option>
	</xsl:template>
	
</xsl:stylesheet>
