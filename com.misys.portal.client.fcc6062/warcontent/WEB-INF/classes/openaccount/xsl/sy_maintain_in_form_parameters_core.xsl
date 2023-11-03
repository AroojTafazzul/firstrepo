<?xml version="1.0" encoding="UTF-8" ?>
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

	<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="rundata"/>
	<xsl:param name="token"/>
	
	<xsl:template match="/">
		<xsl:apply-templates select="section_records"/>
	</xsl:template>

	<!--TEMPLATE Main-->

	<xsl:template match="section_records">

	<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"></script>
	<script type="text/javascript">
		<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
	</script>
	<script type="text/javascript" src="/content/OLD/javascript/openaccount/sy_maintain_po_form.js"></script>

	<p><br/></p>
		
	<table border="0" width="100%">
		<tr>
			<td align="center" border="0">
				<table border="0">
					<tr>
						<td align="left" border="0">
							<!-- FORM -->
							<form name="fakeform1" onsubmit="return false;">
								<input type="hidden" name="product_code" value="IN"/>
								<table border="0" cellspacing="0" cellpadding="0" bgcolor="white">
									<!-- Show the company details -->
									<xsl:apply-templates select="static_company"/>
									
									<p><br/></p>
									
									<table border="0" width="570" cellpadding="0" cellspacing="0" rules="none">
										<tr>
											<td class="FORMH1" border="0">
												<b><xsl:value-of select="localization:getGTPString($language, 'XSL_PO_MAINTAIN_FORM_HEADER')"/></b>
											</td>
											<td align="right" class="FORMH1" border="0">
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
											<td><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINE_ITEMS')"/></td>
										</tr>
										<tr>
										<td width="40">&nbsp;</td>
											<td colspan="2">
												<table width="100%">
													<tr>
														<td width="40">&nbsp;</td>
														<td width="200"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINE_ITEMS_PRODUCT')"/></td>
														<td>
															<input type="checkbox" name="section_li_product">
																<xsl:if test="sections/section[. ='section_li_product']">
																	<xsl:attribute name="checked"/>
																</xsl:if>
															</input>
														</td>
													</tr>
													<tr>
														<td width="40">&nbsp;</td>
														<td width="200"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_DETAILS')"/></td>
														<td>
															<input type="checkbox" name="section_li_amount_details">
																<xsl:if test="sections/section[. ='section_li_amount_details']">
																	<xsl:attribute name="checked"/>
																</xsl:if>
															</input>
														</td>
													</tr>
													<!-- not available for Invoice -->
													<input type="hidden" value="Y" name="section_li_shipment_details"/>
													<input type="hidden" value="Y" name="section_li_inco_terms"/>
													<input type="hidden" value="Y" name="section_li_routing_summary"/>
												</table>
											</td>
										</tr>
										<tr>
											<td width="40">&nbsp;</td>
											<td width="300"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_DETAILS')"/></td>
											<td>
												<input type="checkbox" name="section_in_amount_details">
													<xsl:if test="sections/section[. ='section_in_amount_details']">
														<xsl:attribute name="checked"/>
													</xsl:if>
												</input>
											</td>
										</tr>
										<tr>
											<td width="40">&nbsp;</td>
											<td width="300"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_INCO_TERMS_DETAILS')"/></td>
											<td>
												<input type="checkbox" name="section_in_inco_terms">
													<xsl:if test="sections/section[. ='section_in_inco_terms']">
														<xsl:attribute name="checked"/>
													</xsl:if>
												</input>
											</td>
										</tr>
										<tr>
											<td width="40">&nbsp;</td>
											<td width="300"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ROUTING_SUMMARY_DETAILS')"/></td>
											<td>
												<input type="checkbox" name="section_in_routing_summary">
													<xsl:if test="sections/section[. ='section_in_routing_summary']">
														<xsl:attribute name="checked"/>
													</xsl:if>
												</input>
											</td>
										</tr>
									</table>	
								</table>
							</form>
							<form name="realform" method="POST">
							<xsl:attribute name="action">/gtp/screen/InvoiceScreen</xsl:attribute>
								<input type="hidden" name="operation" value="SAVE_FEATURES"/>
								<input type="hidden" name="token" >
								<xsl:attribute name="value"><xsl:value-of select="$token"/></xsl:attribute>
								</input>
								<input type="hidden" name="TransactionData"/>
							</form>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<center>
		<table border="0" cellspacing="2" cellpadding="8">
			<tr>
				<td align="middle" valign="center" border="0">
					<a href="javascript:void(0)" onclick="fncPerform('save');return false;">
						<img border="0" src="/content/images/pic_form_save.gif"/>
						<br/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
					</a>
				</td>
				<td align="middle" valign="center" border="0">
					<a href="javascript:void(0)" onclick="fncPerform('cancel');return false;">
						<img border="0" src="/content/images/pic_form_cancel.gif"/>
						<br/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
					</a>
				</td>
				<td align="middle" valign="center" border="0">
					<a href="javascript:void(0)" onclick="fncPerform('help');return false;">
						<img border="0" src="/content/images/pic_form_help.gif"/>
						<br/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_HELP')"/>
					</a>
				</td>
			</tr>
		</table>
	</center>
	</xsl:template>
	
	<!--******************************-->
	<!-- Template for Company Details -->
	<!--******************************-->
	
	<xsl:template match="static_company">
		<table border="0" width="570" cellpadding="0" cellspacing="0" bgcolor="white">
			<tr>
				<td class="FORMH1" border="0">
					<b>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_COMPANY_DETAILS')"/>
					</b>
				</td>
			</tr>
		</table>
		<br/>
		<table border="0" width="570" cellpadding="0" cellspacing="0" bgcolor="white">
			<tr>
				<td width="40" border="0">&nbsp;</td>
				<td width="200" border="0">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ABREVIATED_NAME')"/>
				</td>
				<td border="0">
					<font class="REPORTDATA">
						<xsl:value-of select="abbv_name"/>
					</font>
					<input type="hidden" name="company_id">
						<xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute>
					</input>
					<input type="hidden" name="type">
						<xsl:attribute name="value"><xsl:value-of select="type"/></xsl:attribute>
					</input>
					<input type="hidden" name="brch_code">
						<xsl:attribute name="value"><xsl:value-of select="brch_code"/></xsl:attribute>
					</input>
					<input type="hidden" name="abbv_name">
						<xsl:attribute name="value"><xsl:value-of select="abbv_name"/></xsl:attribute>
					</input>
				</td>
			</tr>
			
			<!--xsl:choose>
 				<xsl:when test="entities">
					<tr>
						<td width="40" border="0">&nbsp;</td>
						<td width="200">
							<font class="FORMMANDATORY">
							  <xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ENTITY')"/>
							</font>
						</td>
						<td>
							<input name="entity" size="35" onblur="fncRestoreInputStyle('fakeform1','entity');" onfocus="this.blur();">
							  <xsl:attribute name="value"><xsl:value-of select="entity"/></xsl:attribute>
							</input>
							 &nbsp;                  
							<a name="anchor_search_entity" href="javascript:void(0)">
							  <xsl:attribute name="onclick">
								fncEntityPopup('entity', 'fakeform1',"['entity']",'PO','','','COMPANY');return false;
							  </xsl:attribute>
							  <img border="0" src="/content/images/search.png" name="img_search_entity">
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_ENTITY')"/></xsl:attribute>
							  </img>
							</a>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<input name="entity" type="hidden" value="*"/>
				</xsl:otherwise>
			</xsl:choose-->
		
			<tr>
				<td width="40" border="0">&nbsp;</td>
				<td width="200" border="0">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_NAME')"/>
				</td>
				<td border="0">
					<font class="REPORTDATA">
						<xsl:value-of select="name"/>
					</font>
					<input type="hidden" name="name">
						<xsl:attribute name="value"><xsl:value-of select="name"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td width="40" border="0">&nbsp;</td>
				<td width="200" border="0">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ADDRESS')"/>
				</td>
				<td border="0">
					<font class="REPORTDATA">
						<xsl:value-of select="address_line_1"/>
					</font>
					<input type="hidden" name="address_line_1">
						<xsl:attribute name="value"><xsl:value-of select="address_line_1"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<xsl:if test="address_line_2[.!='']">
				<tr>
					<td width="40" border="0">&nbsp;</td>
					<td width="200" border="0">&nbsp;</td>
					<td border="0">
						<font class="REPORTDATA">
							<xsl:value-of select="address_line_2"/>
						</font>
						<input type="hidden" name="address_line_2">
							<xsl:attribute name="value"><xsl:value-of select="address_line_2"/></xsl:attribute>
						</input>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="dom[.!='']">
				<tr>
					<td width="40" border="0">&nbsp;</td>
					<td width="200" border="0">&nbsp;</td>
					<td border="0">
						<font class="REPORTDATA">
							<xsl:value-of select="dom"/>
						</font>
						<input type="hidden" name="dom">
							<xsl:attribute name="value"><xsl:value-of select="dom"/></xsl:attribute>
						</input>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="contact_name[.!='']">
				<tr>
					<td width="40" border="0">&nbsp;</td>
					<td width="200" border="0">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_CONTACT_NAME')"/>
					</td>
					<td border="0">
						<font class="REPORTDATA">
							<xsl:value-of select="contact_name"/>
						</font>
						<input type="hidden" name="contact_name">
							<xsl:attribute name="value"><xsl:value-of select="contact_name"/></xsl:attribute>
						</input>
					</td>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>

</xsl:stylesheet>