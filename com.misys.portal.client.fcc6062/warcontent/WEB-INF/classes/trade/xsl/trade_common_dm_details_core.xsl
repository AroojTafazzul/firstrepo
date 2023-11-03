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
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization converttools">
		
<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="editGifImage"><xsl:value-of select="$images_path"/>pic_edit.gif</xsl:param>
	<xsl:param name="trashImage"><xsl:value-of select="$images_path"/>pic_trash.gif</xsl:param>
	<xsl:param name="listImage"><xsl:value-of select="$images_path"/>pic_list.gif</xsl:param>
	<xsl:param name="searchGifImage"><xsl:value-of select="$images_path"/>pic_search.gif</xsl:param>
	
	
	<!-- -->	
	<!--Other Templates-->
	
	<!--Additional Informations-->
	<xsl:template match="AdditionalInformation/line">
		<xsl:value-of select="."/>
	</xsl:template>
	
	<!-- Terms and Conditions -->
	<xsl:template name="TERM_DETAILS">

		<!-- Specific parameters -->
		<!--
		<xsl:param name="position"/>
		<xsl:param name="term_clause"/>
		-->

		<!-- Mandatory Parameters -->
		<xsl:param name="structure_name"/>
		<xsl:param name="mode"/>
		<xsl:param name="suffix">
			<xsl:if test="$mode = 'existing'"><xsl:value-of select="position()"></xsl:value-of></xsl:if>
			<xsl:if test="$mode = 'template'">nbElement</xsl:if>
		</xsl:param>
		<xsl:param name="data"></xsl:param>
		<!-- Header -->
		<tr>
			<xsl:if test="$mode = 'template'">
				<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="id">
				<xsl:value-of select="$structure_name"/>_header_<xsl:value-of select="$suffix"/>
			</xsl:attribute>
			
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_1</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_term_clause_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="$data"/>
					</xsl:if>
				</div>
			</td>
			
			<!-- Delete / Edit button -->
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_2</xsl:attribute>
				</xsl:if>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDisplayElement('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
					<img border="0">
						<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($editGifImage)"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
					</img>
				</a>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDeleteElement('fakeform1', '<xsl:value-of  select="$structure_name"/>', <xsl:value-of select="$suffix"/>, ['term_table_header_1']);</xsl:attribute>
					<img border="0" >
						<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($trashImage)"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/></xsl:attribute>
					</img>
				</a>
			</td>
		</tr>

		<!-- Details displaid on demand -->
		<tr>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td colspan="2">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_details_template_cell_1</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:if test="$mode = 'existing'">
						<xsl:attribute name="style">display:none;</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_display_details_<xsl:value-of select="$suffix"/></xsl:attribute>
					<table border="1" width="100%">
						<tr>
							<td>
								<table width="100%" cellpadding="0" cellspacing="0">
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td width="100">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_TERMDETAILS_CLAUSE')"/>
											</font>
										</td>
										<td>
											<input type="text" size="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_term_clause_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:if test="$mode = 'existing'">
														<xsl:value-of select="$data"/>
													</xsl:if>
												</xsl:attribute>
											</input>
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="$suffix"/>
												</xsl:attribute>
											</input>
											<a href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('phrase','fakeform1','<xsl:value-of  select="$structure_name"/>_details_term_clause_<xsl:value-of select="$suffix"/>');return false;</xsl:attribute>
												<xsl:attribute name="name">anchor_search_free_format_text</xsl:attribute>
												<img border="0" >
													<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($listImage)"/></xsl:attribute>
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_PHRASES')"/></xsl:attribute>
													<xsl:attribute name="name">img_search_free_format_text</xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<table width="100%">
												<td align="right" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">fncAddElementValidate('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, '', ['term_clause'], ['term_clause'], ['term_table_header_1']);</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
													</a>
												</td>
												<td width="10%"></td>
												<td align="left" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_cancel_button_<xsl:value-of select="$suffix"/></xsl:attribute>
														<xsl:attribute name="onClick">fncAddElementCancel('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, 'term_clause', ['term_table_header_1']);</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
													</a>
												</td>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</xsl:template>

	<!--Payment Terms-->
	<xsl:template match="PaymentTerms/PaymentTermsDetail/UserDefinedPaymentTerms/line">
		<xsl:value-of select="."/>
	</xsl:template>
	
	<!-- Charge Details template -->
	<xsl:template name="CHARGE_DETAILS">

		<!-- Mandatory Parameters -->
		<xsl:param name="structure_name"/>
		<xsl:param name="mode"/>
		<xsl:param name="suffix">
			<xsl:if test="$mode = 'existing'"><xsl:value-of select="position()"></xsl:value-of></xsl:if>
			<xsl:if test="$mode = 'template'">nbElement</xsl:if>
		</xsl:param>
		<xsl:param name="charge_type"/>
		<xsl:param name="charge_description"/>
		<xsl:param name="charge_currency"/>
		<xsl:param name="charge_amount"/>
		<xsl:param name="charge_rate"/>
		<xsl:param name="charge_reporting_currency"/>
		<xsl:param name="charge_reporting_amount"/>
		
		<!-- Header -->
		<tr>
			<xsl:if test="$mode = 'template'">
				<xsl:attribute name="style">visibility:hidden</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="id">
				<xsl:value-of select="$structure_name"/>_header_<xsl:value-of select="$suffix"/>
			</xsl:attribute>
			
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_1</xsl:attribute>
				</xsl:if>
				<div align="left">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_charge_type_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="$charge_type"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_2</xsl:attribute>
				</xsl:if>
				<div align="center">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_charge_currency_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:if test="$charge_amount!=''">
							<xsl:value-of select="$charge_currency"/>
						</xsl:if>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_3</xsl:attribute>
				</xsl:if>
				<div align="right">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_charge_amount_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:if test="$charge_amount!=''">
							<xsl:value-of select="$charge_amount"/>
						</xsl:if>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_4</xsl:attribute>
				</xsl:if>
				<div align="center">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_charge_rate_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="$charge_rate"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_5</xsl:attribute>
				</xsl:if>
				<div align="center">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_charge_reporting_currency_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:if test="$charge_reporting_amount!=''">
							<xsl:value-of select="$charge_reporting_currency"/>
						</xsl:if>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_6</xsl:attribute>
				</xsl:if>
				<div align="right">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_charge_reporting_amount_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:if test="$charge_reporting_amount!=''">
							<xsl:value-of select="$charge_reporting_amount"/>
						</xsl:if>
					</xsl:if>
				</div>
			</td>
			
			<!-- Delete button -->
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_7</xsl:attribute>
				</xsl:if>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDisplayElement('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
					<img border="0" >
						<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($editGifImage)"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
					</img>
				</a>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDeleteElement('fakeform1', '<xsl:value-of  select="$structure_name"/>', <xsl:value-of select="$suffix"/>, ['charge_table_header_1', 'charge_table_header_2']);</xsl:attribute>
					<img border="0">
						<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($trashImage)"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/></xsl:attribute>
					</img>
				</a>
			</td>

		</tr>
		
		<!-- Details displaid on demand -->
		<tr>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td colspan="10">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_details_template_cell_1</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:if test="$mode = 'existing'">
						<xsl:attribute name="style">display:none;</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_display_details_<xsl:value-of select="$suffix"/></xsl:attribute>
					<table border="1" width="100%">
						<tr>
							<td>
								<table width="100%" cellpadding="0" cellspacing="0">
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_TYPE')"/>
											</font>
										</td>
										<td>
											<input type="text" size="30" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_charge_type_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$charge_type"/></xsl:attribute>
											</input>
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="$suffix"/>
												</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_DESCRIPTION')"/>
										</td>
										<td>
											<input type="text" size="30" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_charge_description_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$charge_description"/></xsl:attribute>
											</input>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_AMOUNT')"/>
											</font>
										</td>
										<td>
											<input type="text" size="3" maxlength="3">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_charge_currency_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$charge_currency"/></xsl:attribute>
												<xsl:attribute name="onblur">fncDefaultExchangeRate('fakeform1', '<xsl:value-of select="$structure_name"/>_details_charge_currency_<xsl:value-of select="$suffix"/>', '<xsl:value-of select="$structure_name"/>_details_charge_reporting_currency_<xsl:value-of select="$suffix"/>', '<xsl:value-of  select="$structure_name"/>_details_charge_rate_<xsl:value-of select="$suffix"/>'); fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_charge_currency_<xsl:value-of select="$suffix"/>');fncCheckValidCurrency(this);fncFormatAmount(document.forms['fakeform1'].<xsl:value-of select="$structure_name"/>_details_charge_amount_<xsl:value-of select="$suffix"/>, fncGetCurrencyDecNo(this.value));</xsl:attribute>
											</input>
											<input type="text" size="20" maxlength="15">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_charge_amount_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_charge_currency_<xsl:value-of select="$suffix"/>');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].<xsl:value-of select="$structure_name"/>_details_charge_currency_<xsl:value-of select="$suffix"/>.value));</xsl:attribute>
												<xsl:attribute name="value">
													<xsl:if test="$charge_amount != ''">
														<xsl:value-of select="$charge_amount"/>
													</xsl:if>
												</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_currency" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('currency', 'fakeform1', '<xsl:value-of  select="$structure_name"/>_details_charge_currency_<xsl:value-of select="$suffix"/>');return false;</xsl:attribute>
												<img border="0" name="img_search_currency">
													<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_RATE')"/>
										</td>
										<td>
											<input type="text" size="10" maxlength="10">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_charge_rate_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$charge_rate"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_charge_rate_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_EQV_AMOUNT')"/>
											</font>
										</td>
										<td>
											<input type="text" size="3" maxlength="3" disabled="disabled">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_charge_reporting_currency_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:if test="$charge_reporting_amount != ''">
														<xsl:value-of select="$charge_reporting_currency"/>
													</xsl:if>
												</xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_charge_reporting_currency_<xsl:value-of select="$suffix"/>');fncCheckValidCurrency(this);fncFormatAmount(document.forms['fakeform1'].<xsl:value-of select="$structure_name"/>_details_charge_reporting_amount_<xsl:value-of select="$suffix"/>, fncGetCurrencyDecNo(this.value));</xsl:attribute>
											</input>
											<input type="text" size="20" maxlength="15">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_charge_reporting_amount_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_charge_reporting_currency_<xsl:value-of select="$suffix"/>');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].<xsl:value-of select="$structure_name"/>_details_charge_reporting_currency_<xsl:value-of select="$suffix"/>.value));</xsl:attribute>
												<xsl:attribute name="value">
													<xsl:if test="$charge_reporting_amount != ''">
														<xsl:value-of select="$charge_reporting_amount"/>
													</xsl:if>
												</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_currency" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncComputeChargeAmount('fakeform1', '<xsl:value-of select="$suffix"/>');return false;</xsl:attribute>												<img border="0" src="/content/images/execute.png" name="img_search_currency">
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_COMPUTE')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td colspan="2">
											<table width="100%">
												<td align="right" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">fncAddElementValidate('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, '', ['charge_type', 'charge_amount', 'charge_currency','charge_reporting_currency', 'charge_reporting_amount'], ['charge_type', 'charge_amount', 'charge_currency', 'charge_rate', 'charge_reporting_currency', 'charge_reporting_amount'], ['charge_table_header_1', 'charge_table_header_2']); </xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
													</a>
												</td>
												<td width="10%"/>
												<td align="left" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_cancel_button_<xsl:value-of select="$suffix"/></xsl:attribute>
														<xsl:attribute name="onClick">fncAddElementCancel('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, 'charge_type', ['charge_table_header_1', 'charge_table_header_2']);</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
													</a>
												</td>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</xsl:template>
	
	<!--Packing Details-->
	<xsl:template name="PACKAGE_DETAILS">
		
		<!-- Mandatory Parameters -->
		<xsl:param name="structure_name"/>
		<xsl:param name="mode"/>
		<xsl:param name="suffix">
			<xsl:if test="$mode = 'existing'"><xsl:value-of select="position()"></xsl:value-of></xsl:if>
			<xsl:if test="$mode = 'template'">nbElement</xsl:if>
		</xsl:param>
		<xsl:param name="package_number"/>
		<xsl:param name="package_type"/>
		<xsl:param name="package_description"/>
		<xsl:param name="package_height"/>
		<xsl:param name="package_width"/>
		<xsl:param name="package_length"/>
		<xsl:param name="package_dimension_unit"/>
		<xsl:param name="package_netweight"/>
		<xsl:param name="package_grossweight"/>
		<xsl:param name="package_weight_unit"/>
		<xsl:param name="package_grossvolume"/>
		<xsl:param name="package_volume_unit"/>
		<xsl:param name="package_marks"/>
		<!-- Header -->
		<tr>
			<xsl:if test="$mode = 'template'">
				<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="id">
				<xsl:value-of select="$structure_name"/>_header_<xsl:value-of select="$suffix"/>
			</xsl:attribute>
			
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_1</xsl:attribute>
				</xsl:if>
				<div align="right">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_package_number_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="$package_number"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_2</xsl:attribute>
				</xsl:if>
				<div align="center">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_package_type_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="$package_type"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_3</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_package_description_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="$package_description"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_4</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_package_marks_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="$package_marks"/>
					</xsl:if>
				</div>
			</td>
			
			<!-- Delete / Edit button -->
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_5</xsl:attribute>
				</xsl:if>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDisplayElement('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
					<img border="0" >
						<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($editGifImage)"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
					</img>
				</a>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDeleteElement('fakeform1', '<xsl:value-of  select="$structure_name"/>', <xsl:value-of select="$suffix"/>, ['packing_table_header_1']);</xsl:attribute>
					<img border="0"
						<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($trashImage)"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/></xsl:attribute>
					</img>
				</a>
			</td>
		</tr>

		<!-- Details displaid on demand -->
		<tr>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td colspan="6">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_details_template_cell_1</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:if test="$mode = 'existing'">
						<xsl:attribute name="style">display:none;</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_display_details_<xsl:value-of select="$suffix"/></xsl:attribute>
					<table border="1" width="100%">
						<tr>
							<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_NUMBER')"/>
											</font>
										</td>
										<td>
											<input type="text" size="10" maxlength="10">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_number_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$package_number"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_number_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="$suffix"/>
												</xsl:attribute>
											</input>
											<input type="text" size="3" maxlength="3">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_type_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$package_type"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_type_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_package_type" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', '<xsl:value-of  select="$structure_name"/>_details_package_type_<xsl:value-of select="$suffix"/>', 'C005');return false;</xsl:attribute>
												<img border="0" name="img_search_package_type">
													<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_PACKAGE_TYPE')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_DESCRIPTION')"/>
											</font>
										</td>
										<td>
											<input type="text" size="30" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_description_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$package_description"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_description_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_DIMENSION_UNIT')"/>
										</td>
										<td>
											<input type="text" size="3" maxlength="3">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_dimension_unit_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$package_dimension_unit"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_dimension_unit_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
											&nbsp;	
											<a name="anchor_search_dimension_unit" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', '<xsl:value-of  select="$structure_name"/>_details_package_dimension_unit_<xsl:value-of select="$suffix"/>', 'C004');return false;</xsl:attribute>
												<img border="0" name="img_search_dimension_unit">
													<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_DIMENSION_UNIT')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_HEIGHT')"/>
										</td>
										<td>
											<input type="text" size="10" maxlength="10">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_height_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$package_height"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_height_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_WIDTH')"/>
										</td>
										<td>
											<input type="text" size="10" maxlength="10">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_width_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$package_width"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_width_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_LENGTH')"/>
										</td>
										<td>
											<input type="text" size="10" maxlength="10">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_length_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$package_length"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_length_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_WEIGHT_UNIT')"/>
										</td>
										<td>
											<input type="text" size="3" maxlength="3">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_weight_unit_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$package_weight_unit"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_weight_unit_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_weight_unit" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', '<xsl:value-of  select="$structure_name"/>_details_package_weight_unit_<xsl:value-of select="$suffix"/>', 'C002');return false;</xsl:attribute>
												<img border="0"  name="img_search_weight_unit">
													<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_WEIGHT_UNIT')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_NETWEIGHT')"/>
										</td>
										<td>
											<input type="text" size="10" maxlength="10">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_netweight_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$package_netweight"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_netweight_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_GROSSWEIGHT')"/>
										</td>
										<td>
											<input type="text" size="10" maxlength="10">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_grossweight_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$package_grossweight"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_grossweight_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_GROSSVOLUME')"/>
										</td>
										<td>
											<input type="text" size="10" maxlength="10">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_grossvolume_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$package_grossvolume"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_grossvolume_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
											<input type="text" size="3" maxlength="3">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_volume_unit_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$package_volume_unit"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_volume_unit_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_volume_unit" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', '<xsl:value-of  select="$structure_name"/>_details_package_volume_unit_<xsl:value-of select="$suffix"/>', 'C003');return false;</xsl:attribute>
												<img border="0" name="img_search_volume_unit">
													<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VOLUME_UNIT')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_MARKS')"/>
										</td>
										<td>
											<input type="text" size="30" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_package_marks_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$package_marks"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_package_marks_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td colspan="2">
											<table width="100%">
												<td align="right" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">fncAddElementValidate('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, '', ['package_number', 'package_type', 'package_description'], ['package_number', 'package_type', 'package_description', 'package_marks'], ['packing_table_header_1']);</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
													</a>
												</td>
												<td width="10%"/>
												<td align="left" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_cancel_button_<xsl:value-of select="$suffix"/></xsl:attribute>
														<xsl:attribute name="onClick">fncAddElementCancel('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, 'package_type', ['packing_table_header_1']);</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
													</a>
												</td>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</xsl:template>


	<!--Product Details-->
	<xsl:template name="PRODUCT_DETAILS">

		<!-- Mandatory Parameters -->
		<xsl:param name="structure_name"/>
		<xsl:param name="mode"/>
		<xsl:param name="suffix">
			<xsl:if test="$mode = 'existing'"><xsl:value-of select="position()"></xsl:value-of></xsl:if>
			<xsl:if test="$mode = 'template'">nbElement</xsl:if>
		</xsl:param>
		<xsl:param name="product_identifier"/>
		<xsl:param name="product_description"/>
		<xsl:param name="purchase_order_id"/>
		<xsl:param name="export_license_id"/>
		<xsl:param name="base_currency"/>
		<xsl:param name="base_unit"/>
		<xsl:param name="base_price"/>
		<xsl:param name="product_quantity"/>
		<xsl:param name="product_unit"/>
		<xsl:param name="product_currency"/>
		<xsl:param name="product_rate"/>
		<xsl:param name="product_price"/>
		<!-- Header -->
		<tr>
			<xsl:if test="$mode = 'template'">
				<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="id">
				<xsl:value-of select="$structure_name"/>_header_<xsl:value-of select="$suffix"/>
			</xsl:attribute>
			
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_1</xsl:attribute>
				</xsl:if>
				<div align="center">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_product_identifier_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="$product_identifier"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_2</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_product_description_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="$product_description"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_3</xsl:attribute>
				</xsl:if>
				<div align="right">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_product_rate_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="$product_rate"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_4</xsl:attribute>
				</xsl:if>
				<div align="center">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_product_currency_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:if test="$product_price != ''">
							<xsl:value-of select="$product_currency"/>
						</xsl:if>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_5</xsl:attribute>
				</xsl:if>
				<div align="right">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_product_price_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:if test="$product_price != ''">
							<xsl:value-of select="$product_price"/>
						</xsl:if>
					</xsl:if>
				</div>
			</td>
			
			<!-- Delete / Edit button -->
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_6</xsl:attribute>
				</xsl:if>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDisplayElement('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
					<img border="0" >
						<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($editGifImage)"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
					</img>
				</a>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDeleteElement('fakeform1', '<xsl:value-of  select="$structure_name"/>', <xsl:value-of select="$suffix"/>, ['product_table_header_1', 'product_table_header_2']);</xsl:attribute>
					<img border="0" >
						<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($trashImage)"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/></xsl:attribute>
					</img>
				</a>
			</td>
		</tr>

		<!-- Details displaid on demand -->
		<tr>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td colspan="6">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_details_template_cell_1</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:if test="$mode = 'existing'">
						<xsl:attribute name="style">display:none;</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_display_details_<xsl:value-of select="$suffix"/></xsl:attribute>
					<table border="1" width="100%">
						<tr>
							<td>
								<table width="100%" cellpadding="0" cellspacing="0">
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_REFERENCE')"/>
											</font>
										</td>
										<td>
											<input type="text" size="35" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_product_identifier_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$product_identifier"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_product_identifier_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="$suffix"/>
												</xsl:attribute>
											</input>
											&nbsp;
											<a href="javascript:void(0)">
												<xsl:attribute name="onclick">fncSearchPopup('product', 'fakeform1', "['<xsl:value-of select="$structure_name"/>_details_product_identifier_<xsl:value-of select="$suffix"/>', '<xsl:value-of  select="$structure_name"/>_details_product_description_<xsl:value-of select="$suffix"/>']", ,'', '', '<xsl:value-of select="product_code"/>');return false;</xsl:attribute>
												<img border="0" >
													<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_PRODUCT')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_DESCRIPTION')"/>
										</td>
										<td>
											<textarea wrap="hard" cols="50" rows="5">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_product_description_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1', '<xsl:value-of select="$structure_name"/>_details_product_description_<xsl:value-of select="$suffix"/>'); fncFormatTextarea(this,5,50);</xsl:attribute>
												<xsl:value-of select="$product_description"/>
											</textarea>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_PURCHASE_ORDER_ID')"/>
										</td>
										<td>
											<input type="text" size="15" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_purchase_order_id_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$purchase_order_id"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_purchase_order_id_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_EXPORT_LICENSE_ID')"/>
										</td>
										<td>
											<input type="text" size="15" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_export_license_id_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$export_license_id"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_export_license_id_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_BASE_UNIT')"/>
											</font>
										</td>
										<td>
											<input type="text" size="3" maxlength="3">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_base_unit_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$base_unit"/></xsl:attribute>
												<xsl:attribute name="onblur">fncDefaultProductUnit('fakeform1', '<xsl:value-of select="$suffix"/>');fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_base_unit_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_measure_unit" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', '<xsl:value-of  select="$structure_name"/>_details_base_unit_<xsl:value-of select="$suffix"/>', 'C001');return false;</xsl:attribute>
												<img border="0" name="img_search_measure_unit">
													<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_MEASURE_UNIT')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_BASE_PRICE')"/>
											</font>
										</td>
										<td>
											<input type="text" size="3" maxlength="3">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_base_currency_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="onblur">fncDefaultExchangeRate('fakeform1', '<xsl:value-of select="$structure_name"/>_details_base_currency_<xsl:value-of select="$suffix"/>', '<xsl:value-of select="$structure_name"/>_details_product_currency_<xsl:value-of select="$suffix"/>', '<xsl:value-of  select="$structure_name"/>_details_product_rate_<xsl:value-of select="$suffix"/>'); fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_base_currency_<xsl:value-of select="$suffix"/>');fncCheckValidCurrency(this);fncFormatAmount(document.forms['fakeform1'].<xsl:value-of  select="$structure_name"/>_details_base_price_<xsl:value-of select="$suffix"/>, fncGetCurrencyDecNo(this.value));</xsl:attribute>
												<xsl:attribute name="value">
													<xsl:if test="$base_price !='' ">
														<xsl:value-of select="$base_currency"/>
													</xsl:if>
												</xsl:attribute>
											</input>
											<input type="text" size="20" maxlength="15">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_base_price_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:if test="$base_price != ''">
														<xsl:value-of select="$base_price"/>
													</xsl:if>
												</xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_base_price_<xsl:value-of select="$suffix"/>');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].<xsl:value-of  select="$structure_name"/>_details_base_currency_<xsl:value-of select="$suffix"/>.value));</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_currency" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('currency', 'fakeform1', '<xsl:value-of  select="$structure_name"/>_details_base_currency_<xsl:value-of select="$suffix"/>');return false;</xsl:attribute>
												<img border="0" name="img_search_currency">
													<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_PRODUCT_QUANTITY')"/>
											</font>
										</td>
										<td>
											<input type="text" size="10" maxlength="10">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_product_quantity_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$product_quantity"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_product_quantity_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
											<input type="text" size="3" maxlength="3">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_product_unit_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$product_unit"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_product_unit_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_measure_unit" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', '<xsl:value-of  select="$structure_name"/>_details_product_unit_<xsl:value-of select="$suffix"/>', 'C001');return false;</xsl:attribute>
												<img border="0" name="img_search_measure_unit">
													<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_MEASURE_UNIT')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_PRODUCT_RATE')"/>
										</td>
										<td>
											<input type="text" size="10" maxlength="10">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_product_rate_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$product_rate"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_product_rate_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_PRODUCT_PRICE')"/>
											</font>
										</td>
										<td>
											<input type="text" size="3" maxlength="3" disabled="disabled">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_product_currency_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:if test="$product_price !=''">
														<xsl:value-of select="$product_currency"/>
													</xsl:if>
												</xsl:attribute>
											</input>
											<input type="text" size="20" maxlength="15">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_product_price_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:if test="$product_price !=''">
														<xsl:value-of select="$product_price"/>
													</xsl:if>
												</xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_product_price_<xsl:value-of select="$suffix"/>');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].<xsl:value-of  select="$structure_name"/>_details_product_currency_<xsl:value-of select="$suffix"/>.value));</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_currency" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncComputeProductAmount('fakeform1', '<xsl:value-of select="$suffix"/>');return false;</xsl:attribute>
												<img border="0" src="/content/images/execute.png" name="img_search_currency">
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_COMPUTE')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td colspan="2">
											<table width="100%">
												<td align="right" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">fncAddElementValidate('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, '', ['product_identifier', 'base_unit', 'base_currency', 'base_price','product_quantity', 'product_unit', 'product_currency', 'product_price'], ['product_identifier', 'product_description', 'product_rate', 'product_currency', 'product_price'], ['product_table_header_1', 'product_table_header_2']);</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
													</a>
												</td>
												<td width="10%"/>
												<td align="left" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_cancel_button_<xsl:value-of select="$suffix"/></xsl:attribute>
														<xsl:attribute name="onClick">fncAddElementCancel('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, 'product_identifier', ['product_table_header_1', 'product_table_header_2']);</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
													</a>
												</td>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</xsl:template>
	
		<!--Product Details-->
	<xsl:template name="PRODUCT_SUMMARY">

		<!-- Mandatory Parameters -->
		<xsl:param name="structure_name"/>
		<xsl:param name="mode"/>
		<xsl:param name="suffix">
			<xsl:if test="$mode = 'existing'"><xsl:value-of select="position()"></xsl:value-of></xsl:if>
			<xsl:if test="$mode = 'template'">nbElement</xsl:if>
		</xsl:param>
		<xsl:param name="product_identifier"/>
		<xsl:param name="product_description"/>
		<xsl:param name="product_quantity"/>
		<xsl:param name="product_unit"/>
		
		<!-- Header -->
		<tr>
			<xsl:if test="$mode = 'template'">
				<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="id">
				<xsl:value-of select="$structure_name"/>_header_<xsl:value-of select="$suffix"/>
			</xsl:attribute>
			
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_1</xsl:attribute>
				</xsl:if>
				<div align="center">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_product_identifier_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="$product_identifier"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_2</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_product_description_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="$product_description"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_3</xsl:attribute>
				</xsl:if>
				<div align="right">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_product_quantity_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="$product_quantity"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_4</xsl:attribute>
				</xsl:if>
				<div align="center">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_product_unit_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
							<xsl:value-of select="$product_unit"/>
					</xsl:if>
				</div>
			</td>
			
			<!-- Delete / Edit button -->
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_6</xsl:attribute>
				</xsl:if>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDisplayElement('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
					<img border="0">
						<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($editGifImage)"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
					</img>
				</a>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDeleteElement('fakeform1', '<xsl:value-of  select="$structure_name"/>', <xsl:value-of select="$suffix"/>, ['product_table_header_1', 'product_table_header_2']);</xsl:attribute>
					<img border="0">
						<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($trashImage)"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/></xsl:attribute>
					</img>
				</a>
			</td>
		</tr>

		<!-- Details displaid on demand -->
		<tr>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td colspan="6">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_details_template_cell_1</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:if test="$mode = 'existing'">
						<xsl:attribute name="style">display:none;</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_display_details_<xsl:value-of select="$suffix"/></xsl:attribute>
					<table border="1" width="100%">
						<tr>
							<td>
								<table width="100%" cellpadding="0" cellspacing="0">
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_REFERENCE')"/>
											</font>
										</td>
										<td>
											<input type="text" size="15" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_product_identifier_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$product_identifier"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_product_identifier_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="$suffix"/>
												</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_DESCRIPTION')"/>
										</td>
										<td>
											<input type="text" size="30" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_product_description_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$product_description"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_product_description_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_PRODUCT_QUANTITY')"/>
											</font>
										</td>
										<td>
											<input type="text" size="10" maxlength="10">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_product_quantity_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$product_quantity"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_product_quantity_<xsl:value-of select="$suffix"/>');fncFormatDecimal(this);</xsl:attribute>
											</input>
											<input type="text" size="3" maxlength="3">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_product_unit_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$product_unit"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_product_unit_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_measure_unit" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncDynamicSearchPopup('codevalue', 'fakeform1', '<xsl:value-of  select="$structure_name"/>_details_product_unit_<xsl:value-of select="$suffix"/>', 'C001');return false;</xsl:attribute>
												<img border="0" name="img_search_measure_unit">
													<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchGifImage)"/></xsl:attribute>
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_MEASURE_UNIT')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td colspan="2">
											<table width="100%">
												<td align="right" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">fncAddElementValidate('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, '', ['product_identifier', 'product_quantity', 'product_unit'], ['product_identifier', 'product_description','product_quantity', 'product_unit'], ['product_table_header_1', 'product_table_header_2']);</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
													</a>
												</td>
												<td width="10%"/>
												<td align="left" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_cancel_button_<xsl:value-of select="$suffix"/></xsl:attribute>
														<xsl:attribute name="onClick">fncAddElementCancel('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, 'product_identifier', ['product_table_header_1', 'product_table_header_2']);</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
													</a>
												</td>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</xsl:template>

	<!--Product Details-->
	<xsl:template name="PRODUCT_SIMPLE">

		<!-- Mandatory Parameters -->
		<xsl:param name="structure_name"/>
		<xsl:param name="mode"/>
		<xsl:param name="suffix">
			<xsl:if test="$mode = 'existing'"><xsl:value-of select="position()"></xsl:value-of></xsl:if>
			<xsl:if test="$mode = 'template'">nbElement</xsl:if>
		</xsl:param>
		<xsl:param name="product_description"/>
		<!-- Header -->
		<tr>
			<xsl:if test="$mode = 'template'">
				<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="id">
				<xsl:value-of select="$structure_name"/>_header_<xsl:value-of select="$suffix"/>
			</xsl:attribute>
			
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_2</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_product_description_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="$product_description"/>
					</xsl:if>
				</div>
			</td>
				
			<!-- Delete / Edit button -->
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_6</xsl:attribute>
				</xsl:if>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDisplayElement('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
					<img border="0" >
						<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($editGifImage)"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
					</img>
				</a>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDeleteElement('fakeform1', '<xsl:value-of  select="$structure_name"/>', <xsl:value-of select="$suffix"/>, ['product_table_header_1', 'product_table_header_2']);</xsl:attribute>
					<img border="0">
						<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($trashImage)"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/></xsl:attribute>
					</img>
				</a>
			</td>
		</tr>

		<!-- Details displaid on demand -->
		<tr>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td colspan="6">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_details_template_cell_1</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:if test="$mode = 'existing'">
						<xsl:attribute name="style">display:none;</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_display_details_<xsl:value-of select="$suffix"/></xsl:attribute>
					<table border="1" width="100%">
						<tr>
							<td>
								<table width="100%" cellpadding="0" cellspacing="0">
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td width="150">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_DESCRIPTION')"/>
										</td>
										<td>
											<input type="text" size="30" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_product_description_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$product_description"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_product_description_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="$suffix"/>
												</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td colspan="2">
											<table width="100%">
												<td align="right" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">fncAddElementValidate('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, '', ['product_description'], ['product_description'], ['product_table_header_1', 'product_table_header_2']);</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
													</a>
												</td>
												<td width="10%"/>
												<td align="left" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_cancel_button_<xsl:value-of select="$suffix"/></xsl:attribute>
														<xsl:attribute name="onClick">fncAddElementCancel('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, 'product_description', ['product_table_header_1', 'product_table_header_2']);</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
													</a>
												</td>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</xsl:template>


</xsl:stylesheet>
