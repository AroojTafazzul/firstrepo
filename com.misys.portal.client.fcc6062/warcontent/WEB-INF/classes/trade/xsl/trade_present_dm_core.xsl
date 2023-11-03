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

	<xsl:import href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:import href="../../core/xsl/common/com_cross_references.xsl"/>
	
	<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="formSaveImage"><xsl:value-of select="$images_path"/>pic_form_save.gif</xsl:param>
	<xsl:param name="formCancelImage"><xsl:value-of select="$images_path"/>pic_form_cancel.gif</xsl:param>
	<xsl:param name="formHelpImage"><xsl:value-of select="$images_path"/>pic_form_help.gif</xsl:param>
	<xsl:param name="formSendImage"><xsl:value-of select="$images_path"/>pic_form_send.gif</xsl:param>
	<xsl:param name="searchGifImage"><xsl:value-of select="$images_path"/>pic_search.gif</xsl:param>
	<xsl:param name="listImage"><xsl:value-of select="$images_path"/>pic_list.gif</xsl:param>
	<xsl:param name="attachmentImage"><xsl:value-of select="$images_path"/>pic_attachment.gif</xsl:param>
	<xsl:param name="endImage"><xsl:value-of select="$images_path"/>pic_end.gif</xsl:param>
	

  <!-- Get the session's informations -->
	<xsl:param name="rundata"/>
	
	<xsl:template match="/">
		<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"></script>
		<script type="text/javascript">
			<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script type="text/javascript" src="/content/OLD/javascript/com_currency.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/trade_present_dm.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_amount.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/com_date.js"></script>
		<script type="text/javascript" src="/content/OLD/javascript/trade_common_dm.js"></script>
			
		<xsl:apply-templates select="dm_tnx_record" mode="present"/>
	</xsl:template>

	<!-- -->
	<!--TEMPLATE Main for document preparation (upload)-->
	<!-- -->
	<xsl:template match="dm_tnx_record" mode="present">

		<!--Variable that holds the tnx type code-->
		<xsl:variable name="tnxTypeCode"><xsl:value-of select="tnx_type_code"/></xsl:variable>
		<!--Variable that holds the current number of documents that is going to be shown in the upload screen-->
		<xsl:variable name="documentsNumber">
			<xsl:choose>
				<xsl:when test="documents/document">
					<xsl:apply-templates select="documents/document[type='01' or attachment_id!='']" mode="count"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
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
						<a href="javascript:void(0)" onclick="fncPerform('release');return false;">
							<img border="0" >
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formSendImage)"/></xsl:attribute>
								
							</img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/>
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
							<img border="0">
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
		
			<p><br/></p>
	
							<!-- We store the customer references for each bank in a JavaScript array -->
							<script>
								dojo.ready(function(){
									misys._config = misys._config || {};
									misys._config.customerReferences = {};
									<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
								});
							</script>

			<form name="fakeform1" onsubmit="return false;">
	
				<!--Insert the Branch Code and Company ID as hidden fields-->
				
				<input type="hidden" name="brch_code"><xsl:attribute name="value"><xsl:value-of select="brch_code"/></xsl:attribute></input>
				<input type="hidden" name="company_id"><xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute></input>
				<input type="hidden" name="company_name"><xsl:attribute name="value"><xsl:value-of select="company_name"/></xsl:attribute></input>
				<input type="hidden" name="tnx_id"><xsl:attribute name="value"><xsl:value-of select="tnx_id"/></xsl:attribute></input>
				<input type="hidden" name="ref_id"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
				<input type="hidden" name="amd_no"><xsl:attribute name="value"><xsl:value-of select="amd_no"/></xsl:attribute></input>
				<input type="hidden" name="parent_product_code"><xsl:attribute name="value"><xsl:value-of select="parent_product_code"/></xsl:attribute></input>
				<input type="hidden" name="parent_bo_ref_id"><xsl:attribute name="value"><xsl:value-of select="parent_bo_ref_id"/></xsl:attribute></input>
				<input type="hidden" name="sub_tnx_type_code"><xsl:attribute name="value"><xsl:value-of select="sub_tnx_type_code"/></xsl:attribute></input>
      		<!-- Previous ctl date, used for synchronisation issues -->
      		<input type="hidden" name="old_ctl_dttm"><xsl:attribute name="value"><xsl:value-of select="ctl_dttm"/></xsl:attribute></input>
				
				<!--The following general details are fetched from database, and the data already localized-->
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
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_FOLDER_REF_ID')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="ref_id"/></font>
							<input type="hidden" name="ref_id"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/></td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="cust_ref_id"/></font>
							<input type="hidden" name="cust_ref_id"><xsl:attribute name="value"><xsl:value-of select="cust_ref_id"/></xsl:attribute></input>
						</td>
					</tr>	
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
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170">
							<font class="FORMMANDATORY">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_PRESENTATION_REF_ID')"/>
							</font>
						</td>
						<td>
							<input type="text" size="15" maxlength="34" name="pres_ref_id" onblur="fncRestoreInputStyle('fakeform1','pres_ref_id');">
								<xsl:attribute name="value"><xsl:value-of select="pres_ref_id"/></xsl:attribute>
							</input>
						</td>
					</tr>	
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CREDIT_REFERENCE')"/></td>
						<td>
							<input type="text" size="15" maxlength="34" name="parent_ref_id" onblur="fncRestoreInputStyle('fakeform1','parent_ref_id');">
								<xsl:attribute name="value"><xsl:value-of select="parent_ref_id"/></xsl:attribute>
							</input>
						</td>
					</tr>	
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRESENTATION_AMOUNT')"/>
						</td>
						<td>
							<input type="text" size="3" maxlength="3" name="tnx_cur_code" onblur="fncRestoreInputStyle('fakeform1','tnx_cur_code');fncCheckValidCurrency(this);fncFormatAmount(document.forms['fakeform1'].tnx_amt,fncGetCurrencyDecNo(this.value));">
								<xsl:attribute name="value"><xsl:value-of select="tnx_cur_code"/></xsl:attribute>
							</input>
							<input type="text" size="20" maxlength="15" name="tnx_amt" onblur="fncRestoreInputStyle('fakeform1','tnx_amt');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].tnx_cur_code.value));">
								<xsl:attribute name="value"><xsl:value-of select="tnx_amt"/></xsl:attribute>
							</input>
							&nbsp;<a name="anchor_search_currency" href="javascript:void(0)">
								<xsl:attribute name="onclick">fncSearchPopup("currency", "fakeform1","['tnx_cur_code']");return false;</xsl:attribute>
								<img border="0" name="img_search_currency">
									<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
								</img>
							</a>
						</td>
					</tr>
					<!--Issuing Bank -->
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170">
							<font class="FORMMANDATORY">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PRESENTATION_TO_BANK')"/>
							</font>
						</td>
						<td>

							<!--
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
							-->
                              <!-- Retrieve only abbv_name and name. Address may be hidden in input field -->
                               <xsl:call-template name="main_bank_selectbox">
                                   <xsl:with-param name="main_bank_form">fakeform1</xsl:with-param>
                                   <xsl:with-param name="main_bank_name">issuing_bank</xsl:with-param>
                                   <xsl:with-param name="sender_name">applicant</xsl:with-param>
                                   <xsl:with-param name="sender_reference_name">applicant_reference</xsl:with-param>
                               </xsl:call-template>
						</td>
					</tr>
														<!-- The selection of the related customer reference (turned into the applicant_reference)
										 if at least one exists -->	
										 <!--							
                           <xsl:call-template name="customer_reference_selectbox">
                             <xsl:with-param name="main_bank_form">fakeform1</xsl:with-param>
                             <xsl:with-param name="main_bank_name">issuing_bank</xsl:with-param>
                             <xsl:with-param name="sender_name">applicant</xsl:with-param>
                             <xsl:with-param name="sender_reference_name">applicant_reference</xsl:with-param>
                           </xsl:call-template>										-->
					
				</table>
				<br/>

				<table width="570" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EUCP_FLAG')"/>
						</td>
						<td>
							<input type="checkbox" name="eucp_flag" onclick="fncShowHideEucpDetails(this);">
								<xsl:if test="eucp_flag[. = 'Y']">
									<xsl:attribute name="checked"/>
								</xsl:if>
							</input>
						</td>
					</tr>
				</table>
				<div id="eucp_details">
					<xsl:if test="eucp_flag[.!='Y']">
						<xsl:attribute name="style">display:none</xsl:attribute>
					</xsl:if>
					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
							<td width="40">&nbsp;</td>
							<td width="170">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EUCP_CREDIT_REFERENCE')"/>
							</td>
							<td>
								<!--
								<select name="eucp_version" onchange="fncRestoreInputStyle('fakeform1','eucp_version');">
									<option value="1.0">
										<xsl:if test="eucp_version[. = '1.0']">
											<xsl:attribute name="selected"/>
										</xsl:if>
										1.0
									</option>
								</select>
								-->
								<input type="text" size="15" maxlength="34" name="eucp_reference" onblur="fncRestoreInputStyle('fakeform1','eucp_reference');">
									<xsl:attribute name="value"><xsl:value-of select="eucp_reference"/></xsl:attribute>
								</input>
							</td>
						</tr>
					</table>
					<table border="0" width="570" cellpadding="0" cellspacing="0">
						<tr>
							<td width="40">&nbsp;</td>
							<td>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EUCP_PRESENTATION_PLACE')"/>
							</td>
						</tr>
						<tr>
							<td width="40">&nbsp;</td>
							<td>
								<textarea wrap="hard" name="eucp_presentation_place" rows="3" cols="40" onblur="fncFormatTextarea(this,3,40);fncRestoreInputStyle('fakeform1','eucp_presentation_place');">
									<xsl:value-of select="eucp_presentation_place"/>
								</textarea>
							</td>
						</tr>
					</table>
				</div>
				
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
				
				<!--Consignee Details-->
				
				<table border="0" cellspacing="0" width="570">
					<tr>
						<td width="15">&nbsp;</td>
						<td class="FORMH2" align="left">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONSIGNEE_DETAILS')"/></b>
						</td>
						<td class="FORMH2" align="right">
							<a name="anchor_search_beneficiary" href="javascript:void(0)">
								<xsl:attribute name="onclick">fncSearchPopup('beneficiary', 'fakeform1',"['consignee_name', 'consignee_address_line_1', 'consignee_address_line_2', 'consignee_dom']",'', '', '<xsl:value-of select="product_code"/>');return false;</xsl:attribute>
								<img border="0" name="img_search_beneficiary">
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
								<xsl:attribute name="value"><xsl:value-of select="counterparty_name"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></td>
						<td>
							<input type="text" size="35" maxlength="35" name="consignee_address_line_1" onblur="fncRestoreInputStyle('fakeform1','consignee_address_line_1');">
								<xsl:attribute name="value"><xsl:value-of select="counterparty_address_line_1"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>
							<input type="text" size="35" maxlength="35" name="consignee_address_line_2" onblur="fncRestoreInputStyle('fakeform1','consignee_address_line_2');">
								<xsl:attribute name="value"><xsl:value-of select="counterparty_address_line_2"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>
							<input type="text" size="35" maxlength="35" name="consignee_dom" onblur="fncRestoreInputStyle('fakeform1','consignee_dom');">
								<xsl:attribute name="value"><xsl:value-of select="counterparty_dom"/></xsl:attribute>
							</input>
						</td>
					</tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
						<td>
							<input type="text" size="35" maxlength="34" name="consignee_reference" onblur="fncRestoreInputStyle('fakeform1','consignee_reference');">
								<xsl:attribute name="value"><xsl:value-of select="counterparty_reference"/></xsl:attribute>
							</input>
						</td>
					</tr>
						
				</table>
				
				<p><br/></p>
				
				<!--Free Format Message-->

				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREE_FORMAT_INSTRUCTIONS')"/></b>
						</td>
					</tr>
				</table>
				
				<br/>
	
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
								<img border="0" >
									<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($listImage)"/></xsl:attribute>
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_PHRASES')"/></xsl:attribute>
									<xsl:attribute name="name">img_search_free_format_text</xsl:attribute>
								</img>
							</a>
						</td>
					</tr>
				</table>
					
				<p><br/></p>
					
				<!--Document Selection-->
		
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1" colspan="3">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DOCUMENTS_PRESENTED')"/></b>
						</td>
					</tr>
				</table>
				<br/>
			
				<!-- Disclaimer -->
				<xsl:if test="count(documents/document) = 0 or documents/document[document_id='']">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_NONE_PRESENTED')"/></b>
				</xsl:if>

				<xsl:if test="count(documents/document) != 0 and documents/document[document_id!='']">
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
										<th class="FORMH2" align="center">
											<img border="0">
												<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($attachmentImage)"/></xsl:attribute>
												<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_ATTACH_ROW')"/></xsl:attribute>
												<xsl:attribute name="name">img_remove_documetn</xsl:attribute>
											</img>
										</th>
									</tr>
									<!-- Call the template for documents already prepared-->
									<xsl:apply-templates select="documents/document" mode="present"/>
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
				</xsl:if>

				<br/>
				
			</form>
					
			<form name="realform" method="POST" action="/gtp/screen/DocumentManagementScreen">
				<input type="hidden" name="operation" value="SAVE"/>
				<input type="hidden" name="mode" value="DRAFT"/>
				<input type="hidden" name="tnxtype"><xsl:attribute name="value"><xsl:value-of select="$tnxTypeCode"/></xsl:attribute></input>
				<input type="hidden" name="TransactionData"/>
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
						<a href="javascript:void(0)" onclick="fncPerform('release');return false;">
							<img border="0">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formSendImage)"/></xsl:attribute>
							</img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/>
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


	<xsl:template match="documents/document" mode="present">
		<xsl:choose>
			<!--Filter out the potential empty generated documents-->
			<xsl:when test="type[.='01'] and document_id[.='']">
				<!-- Nothing to do -->
			</xsl:when>
			<!--The file hasn't been uploaded yet-->
			<xsl:otherwise>
				<xsl:call-template name="collection_document">
					<xsl:with-param name="document_key" select="position()"/>
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
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--Count the number of documents-->
	<xsl:template match="documents/document" mode="count">
		<xsl:if test="position()=last()">
			<xsl:value-of select="position()"/>
		</xsl:if>
	</xsl:template>

	<!-- Display a document form-->
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
			<!-- Document version -->
			<td align="center" nowrap="nowrap">
				<xsl:if test="(not($document_version)) or ($document_version='')">
					<xsl:text>-</xsl:text>
				</xsl:if><xsl:value-of select="$document_version"/>
			</td>
			<!-- Document code -->
			<td align="left" nowrap="nowrap">
				&nbsp;<xsl:choose>
					<xsl:when test="$document_code!='00'">
						<xsl:variable name="localization_key"><xsl:value-of select="code"/></xsl:variable>
						<xsl:value-of select="localization:getDecode($language, 'C064', $localization_key)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$document_title"/>
					</xsl:otherwise>
				</xsl:choose>&nbsp;
			</td>
			<!-- Transformations -->
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
					<img border="0" name="img_preview">
						<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($endImage)"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VIEW_ADVICE')"/></xsl:attribute>
					</img>
				</a>
			</td>
			<td align="center">
				<xsl:choose>
					<xsl:when test="$attachment_id!='' or $document_type='01'">
						<input type="checkbox">
							<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_attached</xsl:attribute>
							<xsl:if test="$attached='Y'"><xsl:attribute name="checked"/></xsl:if>
						</input>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden">
							<xsl:attribute name="name">document_<xsl:value-of select="$document_key"/>_attached</xsl:attribute>
							<xsl:attribute name="value">N</xsl:attribute>
						</input>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
		
	</xsl:template>

	<xsl:template match="transformation">
		<option>
			<xsl:attribute name="name"><xsl:value-of select="transformation_code"/></xsl:attribute>
			<xsl:attribute name="value"><xsl:value-of select="transformation_code"/></xsl:attribute>
			<xsl:variable name="localization_key"><xsl:value-of select="transformation_code"/></xsl:variable>
			<xsl:value-of select="localization:getDecode($language, 'N036', $localization_key)"/>
		</option>
	</xsl:template>

	<!--TEMPLATE Issuing Bank: shows the selection popup of available issuing banks-->

	<xsl:template match="issuing_bank | potential_issuing_bank">
		<option>
			<xsl:attribute name="value"><xsl:value-of select="abbv_name"/></xsl:attribute>
			<xsl:value-of select="name"/>
		</option>
	</xsl:template>

	<!--TEMPLATE Issuing Bank (Main Details)-->

	<xsl:template match="bank" mode="main">
		<xsl:param name="bank"><xsl:value-of select="abbv_name"/></xsl:param>
		<option>
			<xsl:attribute name="value"><xsl:value-of select="$bank"/></xsl:attribute>
			<xsl:if test="../../issuing_bank/abbv_name=$bank">
			 	<xsl:attribute name="selected"/>
			</xsl:if>
			<xsl:value-of select="name"/>
		</option>
	</xsl:template>
	
</xsl:stylesheet>
