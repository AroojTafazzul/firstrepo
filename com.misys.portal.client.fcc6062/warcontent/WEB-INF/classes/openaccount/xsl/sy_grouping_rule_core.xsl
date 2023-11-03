<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 		
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
		xmlns:currencytools="xalan://com.misys.portal.common.currency.CurrencyData"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization converttools currencytools">

<!--
   Copyright (c) 2000-2007 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<!-- Import report stylesheet (for criterion template reuse) -->
	<!-- xsl:import href="../report/report.xsl"/-->

	<xsl:output method="html" indent="no"/>
	
	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="rundata"/>
	<xsl:param name="parm_id"/>
	<xsl:param name="hasEntities">
    	<xsl:choose>
		  <xsl:when test="grouping_rule_records/entities">Y</xsl:when>
		  <xsl:otherwise>N</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="editImage"><xsl:value-of select="$images_path"/>edit.png</xsl:param>
	<xsl:param name="deleteImage"><xsl:value-of select="$images_path"/>delete.png</xsl:param>
	<xsl:param name="searchImage"><xsl:value-of select="$images_path"/>search.png</xsl:param>
	
  
	<xsl:template match="/">
		<xsl:apply-templates select="grouping_rule_records"/>
	</xsl:template>
	
	
	<!--***************-->
	<!-- TEMPLATE Main -->
	<!--***************-->
	
	<xsl:template match="grouping_rule_records">
    <script type="text/javascript" src="/content/OLD/javascript/com_functions.js"/>
    <script type="text/javascript" src="/content/OLD/javascript/com_amount.js"/>
    <script type="text/javascript" src="/content/OLD/javascript/com_currency.js"/>
	<!-- Import report javascript (for criterion management) -->
    <script type="text/javascript" src="/content/js-src/misys/report/report.js"/>
	<script type="text/javascript">
		<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
	</script>
	<script type="text/javascript" src="/content/OLD/javascript/openaccount/sy_grouping_rule.js"/>
	<script type="text/javascript">
		fncPreloadImages('<xsl:value-of select="utils:getImagePath($editImage)"/>', '<xsl:value-of select="utils:getImagePath($deleteImage)"/>'); 
	</script>
	<!--  Definition of columns and operators -->
	<script type="text/javascript">
		var candidate = "groupingRule";
		//var arrCandidateName = new Array();
		var arrProductColumn = new Array();
		var arrColumn = new Array();
		var arrValuesSet = new Array();
		//var arrCandidate = new Array();
		//var arrComputedFieldId = new Array();
		
		arrProductColumn["groupingRule"] = new Array();
		arrProductColumn["groupingRule"][0] = "order_total_cur_code";
		arrProductColumn["groupingRule"][1] = "buyer_name";
		arrProductColumn["groupingRule"][2] = "buyer_street_name";
		arrProductColumn["groupingRule"][3] = "buyer_post_code";
		arrProductColumn["groupingRule"][4] = "buyer_town_name";
		arrProductColumn["groupingRule"][5] = "buyer_country_sub_div";
		arrProductColumn["groupingRule"][6] = "buyer_country";
		arrProductColumn["groupingRule"][7] = "buyer_bei";
		arrProductColumn["groupingRule"][8] = "seller_name";
		arrProductColumn["groupingRule"][9] = "seller_street_name";
		arrProductColumn["groupingRule"][10] = "seller_post_code";
		arrProductColumn["groupingRule"][11] = "seller_town_name";
		arrProductColumn["groupingRule"][12] = "seller_country_sub_div";
		arrProductColumn["groupingRule"][13] = "seller_country";
		arrProductColumn["groupingRule"][14] = "seller_bei";
		arrProductColumn["groupingRule"][15] = "goods_desc";
		arrProductColumn["groupingRule"][16] = "order_total_net_amt";
		arrProductColumn["groupingRule"][16] = "ref_id";
		
		arrColumn["order_total_cur_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_order_total_cur_code')"/>");
		arrColumn["order_total_net_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_order_total_net_amt')"/>");
		arrColumn["buyer_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_buyer_name')"/>");
		arrColumn["buyer_street_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_buyer_street_name')"/>");
		arrColumn["buyer_post_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_buyer_post_code')"/>");
		arrColumn["buyer_town_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_buyer_town_name')"/>");
		arrColumn["buyer_country_sub_div"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_buyer_country_sub_div')"/>");
		arrColumn["buyer_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_buyer_country')"/>");
		arrColumn["buyer_bei"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_buyer_bei')"/>");
		arrColumn["goods_desc"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_goods_desc')"/>");
		arrColumn["seller_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_name')"/>");
		arrColumn["seller_street_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_street_name')"/>");
		arrColumn["seller_post_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_post_code')"/>");
		arrColumn["seller_town_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_town_name')"/>");
		arrColumn["seller_country_sub_div"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_country_sub_div')"/>");
		arrColumn["seller_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_country')"/>");
		arrColumn["seller_bei"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_bei')"/>");
		arrColumn["ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ref_id')"/>");

		// Definition of currencies		
		arrValuesSet["order_total_cur_code"] = <xsl:value-of select="currencytools:getJavascriptCurrenciesArray()"/>
		//
		// Definition of criteria operators
		//
		arrCriteriaOperators = new Array();
		arrCriteriaOperators["different"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIA_different')"/>";
		arrCriteriaOperators["equal"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIA_equal')"/>";
		arrCriteriaOperators["infOrEqual"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIA_infOrEqual')"/>";
		arrCriteriaOperators["supOrEqual"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIA_supOrEqual')"/>";
		arrCriteriaOperators["inferior"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIA_inferior')"/>";
		arrCriteriaOperators["superior"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIA_superior')"/>";
		arrCriteriaOperators["like"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIA_like')"/>";
		arrCriteriaOperators["notLike"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIA_notLike')"/>";
		arrCriteriaOperators["isNull"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIA_isNull')"/>";
		arrCriteriaOperators["isNotNull"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIA_isNotNull')"/>";
		
	</script>

		<p><br/></p>
		
		<table border="0" width="100%">
			<tr>
				<td align="center" border="0">
			
					<table border="0">
						<tr>
							<td align="left" border="0">

								<!-- Grouping rule template -->								
								<div style="position:absolute;visibility:hidden;">
										<table>
											<tbody>
												<xsl:attribute name="id">grouping_rule_template</xsl:attribute>
												<xsl:call-template name="rule_record">
													<xsl:with-param name="structure_name">grouping_rule</xsl:with-param>
													<xsl:with-param name="mode">template</xsl:with-param>
												</xsl:call-template>
											</tbody>
										</table>
								</div>

								<!-- Criteria template -->
								<div style="display:none;" id="criteriaTemplate">
									<table>
										<tbody>
											<xsl:attribute name="id">criteriaTemplate_template</xsl:attribute>
											<xsl:call-template name="CRITERIA">
												<xsl:with-param name="structure_name">criteriaTemplate</xsl:with-param>
												<xsl:with-param name="mode">template</xsl:with-param>
											</xsl:call-template>
										</tbody>
									</table>
								</div>
								<div style="display:none;" id="criteria_master_template"/>

								<!-- FORM -->
								<form name="fakeform1" onsubmit="return false;">
									<table border="0" cellspacing="0" cellpadding="0" bgcolor="white">
										
										<!-- Show the company details -->
										<xsl:apply-templates select="static_company"/>
										
										<p><br/></p>
										
										<table border="0" width="570" cellpadding="0" cellspacing="0" bgcolor="white">
											<tr>
												<td class="FORMH1" border="0">
													<b>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GROUPING_RULE_DETAILS')"/>
													</b>
												</td>
											</tr>
										</table>
										<br/>
										<table border="0" width="570" cellpadding="0" cellspacing="0">
											<tr>
												<td width="40">&nbsp;</td>
												<td>
													<xsl:variable name="countrecords">
														<xsl:value-of select="count(grouping_rule)"/>
													</xsl:variable>
													<!-- Disclaimer -->
													<div>
														<xsl:attribute name="id">grouping_rule_disclaimer</xsl:attribute>
														<xsl:if test="$countrecords != 0">
															<xsl:attribute name="style">display:none</xsl:attribute>
														</xsl:if>
														<b><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_NO_GROUPING_RULE_SETUP')"/></b>
													</div>			
													<!-- Existing records -->
													<table border="0" width="570" cellpadding="0" cellspacing="1">
														<xsl:attribute name="id">grouping_rule_master_table</xsl:attribute>
														<xsl:if test="$countrecords = 0">
															<xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
														</xsl:if>
														<tbody>
															<xsl:attribute name="id">grouping_rule_table</xsl:attribute>
															<!-- Columns Header -->
															<tr>
																<xsl:attribute name="id">grouping_rule_table_header_1</xsl:attribute>
																<xsl:if test="$countrecords = 0">
																	<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
																</xsl:if>
																<th class="FORMH2" align="center" width="20%">
																	<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_GROUPING_RULE_DESCRIPTION_HEADER')"/>
																</th>
																<xsl:if test="$hasEntities='Y'">
																<th class="FORMH2" align="center" width="15%">
																	<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_GROUPING_RULE_ENTITY_HEADER')"/>
																</th>
																</xsl:if>
																<th class="FORMH2" align="center" width="15%">
																	<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_GROUPING_RULE_PRODUCT_CODE_HEADER')"/>
																</th>
																<th class="FORMH2" align="center" width="10%">
																	<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_GROUPING_RULE_RETENTION_HEADER')"/>
																</th>
																<th class="FORMH2" align="center" width="10%">
																	<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_GROUPING_RULE_CUR_CODE_HEADER')"/>
																</th>
																<th class="FORMH2" align="center" width="15%">
																	<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_GROUPING_RULE_AMOUNT_HEADER')"/>
																</th>
																<th class="FORMH2" align="center" width="5%">
																	<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_GROUPING_RULE_ORDER_HEADER')"/>
																</th>
																<th class="FORMH2" align="center" width="10%">&nbsp;</th>
															</tr>
															<!-- Details -->
															<xsl:apply-templates select="grouping_rule"/>
														</tbody>
													</table>
													<br/>
													<a href="javascript:void(0)">
														<xsl:attribute name="onclick">fncPreloadImages('<xsl:value-of select="utils:getImagePath($editImage)"/>', '<xsl:value-of select="utils:getImagePath($deleteImage)"/>');fncLaunchProcess("fncAddElement('fakeform1', 'grouping_rule', '')");</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ADD_GROUPING_RULE')"/>	
													</a>
												</td>
											</tr>
										</table>
										<p>
											<br/>
										</p>
									</table>
								</form>
								
								<form name="realform" method="POST">
									<xsl:attribute name="action">/gtp/screen/PurchaseOrderScreen</xsl:attribute>
									<input type="hidden" name="operation" value="SAVE_FEATURES"/>
                 					 <input type="hidden" name="option" value="RULE_MAINTENANCE"/>
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
					<td align="middle" valign="middle" border="0">
						<a href="javascript:void(0)" onclick="fncPerform('save');return false;">
							<img border="0" src="/content/images/pic_form_save.gif"/>
							<br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
						</a>
					</td>
					<td align="middle" valign="middle" border="0">
						<a href="javascript:void(0)" onclick="fncPerform('cancel');return false;">
							<img border="0" src="/content/images/pic_form_cancel.gif"/>
							<br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
						</a>
					</td>
					<td align="middle" valign="middle" border="0">
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
			<xsl:if test="street_name[.!='']">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="200"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ADDRESS_STREET_NAME')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="street_name"/></font></td>
				</tr>
			</xsl:if>
			<xsl:if test="post_code[.!='']">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="200"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ADDRESS_POST_CODE')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="post_code"/></font></td>
				</tr>
			</xsl:if>
			<xsl:if test="town_name[.!='']">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="200"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ADDRESS_TOWN_NAME')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="town_name"/></font></td>
				</tr>
			</xsl:if>
			<xsl:if test="country_sub_div[.!='']">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="200"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ADDRESS_COUNTRY_SUB_DIVISION')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="country_sub_div"/></font></td>
				</tr>
			</xsl:if>
			<xsl:if test="country[.!='']">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="200"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_COUNTRY')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="country"/></font></td>
				</tr>
			</xsl:if>	
		</table>
	</xsl:template>
	
	<!-- -->
	<xsl:template match="grouping_rule">
		<xsl:call-template name="rule_record">
			<xsl:with-param name="structure_name">grouping_rule</xsl:with-param>
			<xsl:with-param name="mode">existing</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="rule_record">
		
		<!-- Mandatory Parameters -->
		<xsl:param name="structure_name"/>
		<xsl:param name="mode"/>
		<xsl:param name="suffix">
			<xsl:if test="$mode = 'existing'">
				<xsl:value-of select="position()"/>
			</xsl:if>
			<xsl:if test="$mode = 'template'">nbElement</xsl:if>
		</xsl:param>
		<!-- Header -->
		<tr>
			<xsl:if test="$mode = 'template'">
				<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_<xsl:value-of select="$suffix"/></xsl:attribute>
			
			<td align="left">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_0</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_description_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="description"/>
					</xsl:if>
				</div>
			</td>
			<xsl:if test="$hasEntities ='Y'">
				<td align="left">
					<xsl:if test="$mode = 'template'">
						<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_1</xsl:attribute>
					</xsl:if>
					<div>
						<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_entity_<xsl:value-of select="$suffix"/></xsl:attribute>
						<xsl:if test="$mode = 'existing'">
						  <xsl:variable name="codeval">
							<xsl:choose>
							  <xsl:when test="entity='**'">*</xsl:when>
							  <xsl:when test="$mode='existing'">
								<xsl:value-of select="entity"/>
							  </xsl:when>
							</xsl:choose>
						  </xsl:variable>
						  <xsl:value-of select="$codeval"/>
						</xsl:if>
					</div>
				</td>
			</xsl:if>
			<td align="left">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_2</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_product_decode_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:variable name="codeval"><xsl:value-of select="product_code"/></xsl:variable>
						<xsl:value-of select="localization:getDecode($language, 'N001', $codeval)"/>
					</xsl:if>
				</div>
			</td>
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_3</xsl:attribute>
				</xsl:if>
 				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_retention_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="retention"/>
					</xsl:if>
				</div>
			</td>
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_4</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_min_cur_code_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="min_cur_code"/>				
					</xsl:if>
				</div>
			</td>
			<td align="right">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_5</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_min_amt_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="min_amt"/>				
					</xsl:if>
				</div>
			</td>
			<td align="right">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_6</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_rule_order_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="rule_order"/>				
					</xsl:if>
				</div>
			</td>
			<!-- Delete / Edit button -->
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_7</xsl:attribute>
				</xsl:if>
				<!--<span>-->
					<a href="javascript:void(0)">
						<xsl:attribute name="onClick">fncDisplayElement('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
						<img border="0" src="/content/images/edit.png">
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
						</img>
					</a>
					<a href="javascript:void(0)">
						<xsl:attribute name="onClick">fncDeleteElement('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, ['<xsl:value-of select="$structure_name"/>_table_header_1']);</xsl:attribute>
						<img border="0" src="/content/images/delete.png">
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/></xsl:attribute>
						</img>
					</a>
					<!--<table style="display:inline">
					  <xsl:if test="position() != 1">
					    <tr>
					      <td>
					        <a href="javascript:void(0)">
					          <xsl:attribute name="onclick">fncSwitchRows('<xsl:value-of select="$structure_name"/>', '<xsl:value-of select="position()"/>','<xsl:value-of select="position()-1"/>');return false;</xsl:attribute>
					          <img border="0" src="/content/images/pic_up.gif">
					            <xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_SORT_UP')"/></xsl:attribute>
					          </img>
					        </a>
					      </td>
					    </tr>
					  </xsl:if>
					  <xsl:if test="position() != count(//grouping_rule_records/grouping_rule)">
					    <tr>
					      <td>
					        <a href="javascript:void(0)">
					          <xsl:attribute name="onclick">fncSwitchRows('<xsl:value-of select="$structure_name"/>', '<xsl:value-of select="position()+1"/>', '<xsl:value-of select="position()"/>');return false;</xsl:attribute>
					          <img border="0" src="/content/images/pic_down.gif">
					            <xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_SORT_DOWN')"/></xsl:attribute>
					          </img>
					        </a>
					      </td>
					    </tr>
					 </xsl:if>
					</table>-->
				<!--</span>-->
			</td>
		</tr>
		<!-- Details displaid on demand -->
		<tr>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td width="100%">
				<xsl:attribute name="colspan">
					<xsl:choose>
						<xsl:when test="$hasEntities='Y'">8</xsl:when>
						<xsl:otherwise>7</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
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
										<td colspan="3">&nbsp;</td>
									</tr>
									<!-- position -->
									<input type="hidden">
										<xsl:attribute name="name">
											<xsl:value-of select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/>
										</xsl:attribute>
										<xsl:attribute name="value">
											<xsl:value-of select="$suffix"/>
										</xsl:attribute>
									</input>
									<!-- rule id -->
									<input type="hidden">
										<xsl:attribute name="name">
											<xsl:value-of select="$structure_name"/>_details_rule_id_<xsl:value-of select="$suffix"/>
										</xsl:attribute>
										<xsl:attribute name="value">
											<xsl:value-of select="rule_id"/>
										</xsl:attribute>
									</input>
									<!-- description -->
									<tr>
										<td width="150" border="0">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_GROUPING_RULE_DESCRIPTION')"/>
											</font>
										</td>
										<td border="0" colspan="2">
											<input type="text" name="description" size="35" maxlength="60">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_description_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="description"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_description_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
										</td>
									</tr>
									<!-- entity -->
									<xsl:choose>
										<xsl:when test="$hasEntities='Y'">
										<tr>
											<td width="150" border="0">
												<font class="FORMMANDATORY">
													<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_GROUPING_RULE_ENTITY')"/>
												</font>
											</td>
											<td colspan="2">
												<input size="35" onfocus="this.blur();">
													  <xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_entity_<xsl:value-of select="$suffix"/>');</xsl:attribute>
													  <xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_entity_<xsl:value-of select="$suffix"/></xsl:attribute>
													  <xsl:attribute name="value">
														<xsl:choose>
														  <xsl:when test="entity='**'">*</xsl:when>
														  <xsl:when test="$mode='existing'">
															<xsl:value-of select="entity"/>
														  </xsl:when>
														</xsl:choose>
													  </xsl:attribute>
												</input>&nbsp;
												<a name="anchor_search_entity" href="javascript:void(0)">
												  <xsl:attribute name="onclick">fncEntityPopup('entity', 'fakeform1',"['<xsl:value-of select="$structure_name"/>_details_entity_<xsl:value-of select="$suffix"/>']",'PO','','','COMPANY');return false;</xsl:attribute>
												   <img border="0" name="img_search_entity">
												   	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchImage)"/></xsl:attribute>
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_ENTITY')"/></xsl:attribute>
												   </img>
												</a>
											</td>
										</tr>
										</xsl:when>
										<xsl:otherwise>
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_entity_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">*</xsl:attribute>
											</input>
										</xsl:otherwise>
									</xsl:choose>
									<!-- destination / product code -->
									<tr>
										<td width="150" border="0">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_GROUPING_RULE_DESTINATION')"/>
											</font>
										</td>
										<td border="0" colspan="2">
											<table width="100%">
												<tr>
													<td width="50%"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_GROUPING_RULE_DESTINATION_OA')"/></td>
													<td>
														<input type="radio" value="FO">
															<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_product_code_<xsl:value-of select="$suffix"/></xsl:attribute>
															<xsl:if test="product_code[.='FO'] or $mode = 'template'">
																<xsl:attribute name="checked"/>
															</xsl:if>
															<xsl:attribute name="onclick">document.fakeform1.<xsl:value-of select="$structure_name"/>_details_product_decode_<xsl:value-of select="$suffix"/>.value='<xsl:value-of select="localization:getDecode($language, 'N001', 'FO')"/>'</xsl:attribute>
														</input>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td width="150" border="0">
											&nbsp;
										</td>
										<td border="0" colspan="2">					
											<table width="100%">
												<tr>
													<td width="50%"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_GROUPING_RULE_DESTINATION_LC')"/></td>
													<td>
														<input type="radio" value="LC">
															<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_product_code_<xsl:value-of select="$suffix"/></xsl:attribute>
															<xsl:if test="product_code[.='LC']">
																<xsl:attribute name="checked"/>
															</xsl:if>
															<xsl:attribute name="onclick">document.fakeform1.<xsl:value-of select="$structure_name"/>_details_product_decode_<xsl:value-of select="$suffix"/>.value='<xsl:value-of select="localization:getDecode($language, 'N001', 'LC')"/>'</xsl:attribute>
														</input>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<input type="hidden">
										<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_product_decode_<xsl:value-of select="$suffix"/></xsl:attribute>
										<xsl:attribute name="value">
											<xsl:choose>
												<xsl:when test="$mode='existing' and product_code[.!='']">
													<xsl:variable name="product_code"><xsl:value-of select="product_code"/></xsl:variable>
													<xsl:value-of select="localization:getDecode($language, 'N001', $product_code)"/>
												</xsl:when>
												<xsl:otherwise>*</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
									</input>
									<!-- retention -->
									<tr>
										<td width="150" border="0">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_GROUPING_RULE_RETENTION')"/>
											</font>
										</td>
										<td border="0" colspan="2">
											<input type="text" name="retention" size="2" maxlength="2">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_retention_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="retention"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_retention_<xsl:value-of select="$suffix"/>');fncValidateRetention(this);</xsl:attribute>
											</input>
										</td>
									</tr>
									<!-- min. currency -->
									<tr>
										<td width="150" border="0">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_GROUPING_CUR_CODE')"/>
											</font>
										</td>
										<td border="0" colspan="2">
											<input type="text" size="3" maxlength="3">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_min_cur_code_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="min_cur_code"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_min_cur_code_<xsl:value-of select="$suffix"/>');fncCheckValidCurrency(this);fncFormatAmount(document.forms['fakeform1'].<xsl:value-of select="$structure_name"/>_details_min_amt_<xsl:value-of select="$suffix"/>, fncGetCurrencyDecNo(this.value));</xsl:attribute>
											</input>
											&nbsp;
											<a name="anchor_search_iso_currency" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncSearchPopup('currency', 'fakeform1',"['<xsl:value-of select="$structure_name"/>_details_min_cur_code_<xsl:value-of select="$suffix"/>']");return false;</xsl:attribute>
												<img border="0" name="img_search_iso_currency">
													<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchImage)"/></xsl:attribute>
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
												</img>
											</a>
										</td>
									</tr>
									<!-- min. amount -->
									<tr>
										<td width="150" border="0">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_GROUPING_AMOUNT')"/>
											</font>
										</td>
										<td border="0" colspan="2">
											<input type="text" size="20" maxlength="15">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_min_amt_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="min_amt"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_min_amt_<xsl:value-of select="$suffix"/>');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].<xsl:value-of select="$structure_name"/>_details_min_cur_code_<xsl:value-of select="$suffix"/>.value));document.forms['fakeform1'].<xsl:value-of select="$structure_name"/>_details_unformatted_min_amt_<xsl:value-of select="$suffix"/>.value=fncUnFormatTextAmount(document.forms["fakeform1"].<xsl:value-of select="$structure_name"/>_details_min_amt_<xsl:value-of select="$suffix"/>.value);</xsl:attribute>
											</input>
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_unformatted_min_amt_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="unformatted_min_amt"/></xsl:attribute>
											</input>
										</td>
									</tr>
									<!-- rule order -->
									<tr>
										<td width="150" border="0">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_GROUPING_RULE_ORDER')"/>
											</font>
										</td>
										<td border="0" colspan="2">
											<input type="text" size="2" maxlength="2">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_rule_order_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="rule_order"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_rule_order_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr><td colspan="3">&nbsp;</td></tr>
								<!--  criteria -->
                                <tr><td colspan="3">
								<table width="100%" border="0">
									<tr>
										<td width="3%"/>
										<td width="100%">
											<div>
												<!--<input type="hidden">
													<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/></xsl:attribute>
													<xsl:attribute name="value"><xsl:value-of select="$suffix"/></xsl:attribute>
												</input>-->
												<!-- Criteria section -->
												<!-- Disclaimer -->
												<div>
													<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_<xsl:value-of select="$suffix"/>_criteria_disclaimer</xsl:attribute>
													<b>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_NO_CRITERIA')"/>
													</b>
												</div>
												<table border="0" width="100%" cellpadding="0" cellspacing="1">
													<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_<xsl:value-of select="$suffix"/>_criteria_master_table</xsl:attribute>
													<xsl:if test="count(report/listdef/candidate/filter/criteria) = 0">
														<xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
													</xsl:if>
													<tbody>
														<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_<xsl:value-of select="$suffix"/>_criteria_table</xsl:attribute>
														<!-- Columns Header  -->
														<tr>
															<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_<xsl:value-of select="$suffix"/>_criteria_table_header_1</xsl:attribute>
															<th class="FORMH2" align="center" width="30%">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FILTER_TABLE_COLUMN')"/>
															</th>
															<th class="FORMH2" align="center" width="30%">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FILTER_TABLE_OPERATOR')"/>
															</th>
															<th class="FORMH2" align="center" width="30%">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FILTER_TABLE_VALUE')"/>
															</th>
															<th class="FORMH2" width="10%">&nbsp;</th>
														</tr>
														<!-- Details  -->
														<xsl:for-each select="report/listdef/candidate/filter/criteria[column/@name != 'entity' and column/@name != 'link_ref_id']">
															<xsl:call-template name="CRITERIA">
																<xsl:with-param name="structure_name">
																	<xsl:value-of select="$structure_name"/>_<xsl:value-of select="$suffix"/>_criteria</xsl:with-param>
																<xsl:with-param name="mode">existing</xsl:with-param>
															</xsl:call-template>
														</xsl:for-each>
													</tbody>
												</table>
												<br/>
												<a href="javascript:void(0)">
													<xsl:attribute name="onClick">fncPreloadImages('<xsl:value-of select="utils:getImagePath($searchImage)"/>', '<xsl:value-of select="utils:getImagePath($editImage)"/>', '<xsl:value-of select="utils:getImagePath($deleteImage)"/>'); fncLaunchProcessCriteria('<xsl:value-of select="$structure_name"/>_<xsl:value-of select="$suffix"/>');</xsl:attribute>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ADD_CRITERIA')"/>
												</a>
											</div>
										</td>
									</tr>
								</table>
                                </td></tr>

								<tr><td colspan="3"></td></tr>
									<tr>
										<td colspan="3">
											<table width="100%">
												<td align="right" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">fncAddRuleValidate('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, '', ['<xsl:value-of select="$structure_name"/>_table_header_1']);</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
													</a>
												</td>
												<td width="10%"/>
												<td align="left" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">fncAddElementCancel('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, 'retention', ['<xsl:value-of select="$structure_name"/>_table_header_1']);</xsl:attribute>
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
	
	
	<!--**********-->
	<!-- Criteria -->
	<!--**********-->
	<xsl:template name="CRITERIA">
		<!-- Mandatory Parameters -->
		<xsl:param name="structure_name"/>
		<xsl:param name="mode"/>
		<xsl:param name="suffix">
			<xsl:if test="$mode = 'existing'">
				<xsl:value-of select="position()"/>
			</xsl:if>
			<xsl:if test="$mode = 'template'">nbElement</xsl:if>
		</xsl:param>
		<!-- Header  -->
		<tr>
			<xsl:if test="$mode = 'template'">
				<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_1</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_column_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:variable name="key">XSL_REPORT_COL_<xsl:value-of select="column/@name"/>
						</xsl:variable>
						<xsl:value-of select="localization:getGTPString($language, $key)"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_2</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_operator_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:variable name="key">XSL_REPORT_CRITERIA_<xsl:value-of select="operator/@type"/>
						</xsl:variable>
						<xsl:value-of select="localization:getGTPString($language, $key)"/>
					</xsl:if>
				</div>
			</td>
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_3</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_displaid_value_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:choose>
							<xsl:when test="value/@type = 'parameter'">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FILTERDETAILS_PARAMETER_CHOICE')"/>&nbsp;<xsl:value-of select="value"/>
							</xsl:when>
							<xsl:when test="value/@type = 'string'">
								<xsl:choose>
									<xsl:when test="column/@type = 'String'">
										<xsl:value-of select="value"/>
									</xsl:when>
									<xsl:when test="column/@type = 'Amount'">
										<xsl:variable name="amount">
											<xsl:value-of select="substring-before(value, '@')"/>
										</xsl:variable>
										<xsl:variable name="currency">
											<xsl:value-of select="substring-after(value, '@')"/>
										</xsl:variable>
										<xsl:value-of select="converttools:getLocaleAmountRepresentation($amount, $currency, $language)"/>&nbsp;<xsl:value-of select="$currency"/>
									</xsl:when>
									<xsl:when test="column/@type = 'Date'">
										<xsl:variable name="date">
											<xsl:value-of select="value"/>
										</xsl:variable>
										<xsl:value-of select="converttools:getLocaleTimestampRepresentation($date,$language)"/>
									</xsl:when>
									<xsl:when test="column/@type = 'ValuesSet'">
										<xsl:call-template name="Column_Value_Description">
											<xsl:with-param name="columnName"><xsl:value-of select="column/@name"/></xsl:with-param>
											<xsl:with-param name="columnValue"><xsl:value-of select="value"/></xsl:with-param>
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
				</div>
			</td>
			<!-- Delete / Edit button   -->
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_4	</xsl:attribute>
				</xsl:if>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncCheckCriteriaLists('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>); fncEnableDisableOperandType('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>); fncDisplayElement('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
					<img border="0" src="/content/images/edit.png">
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
					</img>
				</a>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDeleteElement('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, ['<xsl:value-of select="$structure_name"/>_table_header_1']);</xsl:attribute>
					<img border="0" src="/content/images/delete.png">
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/></xsl:attribute>
					</img>
				</a>
			</td>
		</tr>
		<!-- Details displaid on demand -->
		<tr>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td colspan="4">
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
										<td colspan="2">&nbsp;</td>
									</tr>
									<!-- Column section -->
									<tr>
										<td colspan="2">
											<table border="0" width="100%">
												<tr>
													<td width="100">
														<font class="FORMMANDATORY">
															<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FILTERDETAILS_COLUMN')"/>
														</font>
													</td>
													<td>
														<table border="0" width="100%">
															<tr>
																<td>
																	<select size="1">
																		<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_column_<xsl:value-of select="$suffix"/></xsl:attribute>
																		<xsl:attribute name="onchange">document.forms['fakeform1'].elements['<xsl:value-of select="$structure_name"/>_details_actual_value_type_<xsl:value-of select="$suffix"/>'].value='';</xsl:attribute>
																		<!--<xsl:attribute name="onblur">fncDefaultCriteriaOperators('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>); fncPopulateActualCriteriaColumn('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>); fncEnableDisableValueType('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>); fncRestoreInputStyle('fakeform1', '<xsl:value-of select="$structure_name"/>_details_column_<xsl:value-of select="$suffix"/>');</xsl:attribute>-->
																		<xsl:attribute name="onblur">fncDefaultCriteriaOperators('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>); fncDefaultCriteriaRadioButtons('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>); fncDeleteParameterAndValueFields('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>); fncPopulateActualCriteriaColumn('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>); fncDefaultCriteriaValue('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>); fncRestoreInputStyle('fakeform1', '<xsl:value-of select="$structure_name"/>_details_column_<xsl:value-of select="$suffix"/>');</xsl:attribute>
																		<option value="">
																			<xsl:attribute name="selected"/>
																		</option>
																	</select>
																	<input type="hidden">
																		<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/></xsl:attribute>
																		<xsl:attribute name="value"><xsl:value-of select="$suffix"/></xsl:attribute>
																	</input>
																	<input type="hidden">
																		<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_actual_column_<xsl:value-of select="$suffix"/></xsl:attribute>
																		<xsl:attribute name="value"><xsl:if test="$mode = 'existing'"><xsl:value-of select="column/@name"/></xsl:if></xsl:attribute>
																	</input>
																	<input type="hidden">
																		<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_actual_column_type_<xsl:value-of select="$suffix"/></xsl:attribute>
																		<xsl:attribute name="value"><xsl:if test="$mode = 'existing'"><xsl:value-of select="column/@type"/></xsl:if></xsl:attribute>
																	</input>
																</td>
															</tr>
														</table>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<!-- Operator section -->
									<tr>
										<td colspan="2">
											<table border="0" width="100%">
												<tr>
													<td width="100">
														<font class="FORMMANDATORY">
															<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FILTERDETAILS_OPERATOR')"/>
														</font>
													</td>
													<td>
														<table border="0" width="100%">
															<tr>
																<td>
																	<select size="1">
																		<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_operator_<xsl:value-of select="$suffix"/></xsl:attribute>
																		<xsl:attribute name="onblur">fncEnableDisableOperandType('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>); fncDefaultCriteriaValue('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>); fncPopulateActualCriteriaOperator('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>); fncRestoreInputStyle('fakeform1', '<xsl:value-of select="$structure_name"/>_details_operator_<xsl:value-of select="$suffix"/>');</xsl:attribute>
																		<option value="">
																			<xsl:attribute name="selected"/>
																		</option>
																	</select>
																	<input type="hidden">
																		<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_actual_operator_<xsl:value-of select="$suffix"/></xsl:attribute>
																		<xsl:attribute name="value">
                                      <xsl:if test="$mode = 'existing'">
                                        <xsl:value-of select="operator/@type"/>
                                      </xsl:if>
                                    </xsl:attribute>
																	</input>
																</td>
															</tr>
														</table>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<!-- Parameter/Value checkbox section -->
									<!-- <tr>
										<td colspan="2">
											<table border="0" width="100%">
												<tr>
													<td width="100">&nbsp;</td>
													<td>
														<table border="0" width="100%">
															<tr>
																<td>
																	<input type="radio">
																		<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_value_type_<xsl:value-of select="$suffix"/></xsl:attribute>
																		<xsl:attribute name="onclick">fncDefaultCriteriaValue('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
																		<xsl:choose>
																			<xsl:when test="$mode='existing'">
																				<xsl:if test="value/@type='parameter'">
																					<xsl:attribute name="checked">true</xsl:attribute>
																				</xsl:if>
																			</xsl:when>
																			<xsl:otherwise>
																				<xsl:attribute name="disabled">true</xsl:attribute>
																			</xsl:otherwise>
																		</xsl:choose>
																	</input>
																	<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FILTERDETAILS_PARAMETER_CHOICE')"/>
																	&nbsp; &nbsp; &nbsp;
																	<input type="radio">
																		<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_value_type_<xsl:value-of select="$suffix"/></xsl:attribute>
																		<xsl:attribute name="onclick">fncDefaultCriteriaValue('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
																		<xsl:choose>
																			<xsl:when test="$mode='existing'">
																				<xsl:if test="value/@type='string'">
																					<xsl:attribute name="checked">true</xsl:attribute>
																				</xsl:if>
																			</xsl:when>
																			<xsl:otherwise>
																				<xsl:attribute name="disabled">true</xsl:attribute>
																			</xsl:otherwise>
																		</xsl:choose>
																	</input>
																	<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FILTERDETAILS_VALUE_CHOICE')"/>
																	<input type="hidden">
																		<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_actual_value_type_<xsl:value-of select="$suffix"/></xsl:attribute>
																		<xsl:if test="$mode='existing'">
																			<xsl:attribute name="value"><xsl:value-of select="value/@type"/></xsl:attribute>
																		</xsl:if>
																	</input>
																</td>
															</tr>
														</table>
													</td>
												</tr>
											</table>
										</td>
									</tr>-->
									<!-- Operand section -->
									<tr>
										<td colspan="2">
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_actual_value_type_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:if test="$mode='existing'">
													<xsl:attribute name="value"><xsl:value-of select="value/@type"/></xsl:attribute>
												</xsl:if>
											</input>
											<!-- Hidden field storing the value to be displaid on the screen -->
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_displaid_value_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:if test="$mode = 'existing'"><xsl:choose><xsl:when test="value/@type = 'string'"><xsl:choose><xsl:when test="column/@type = 'String'"><xsl:value-of select="value"/></xsl:when><xsl:when test="column/@type = 'Amount'"><xsl:variable name="amount"><xsl:value-of select="substring-before(value, '@')"/></xsl:variable><xsl:variable name="currency"><xsl:value-of select="substring-after(value, '@')"/></xsl:variable><xsl:value-of select="converttools:getLocaleAmountRepresentation($amount, $currency, $language)"/></xsl:when><xsl:when test="column/@type = 'Date'"><xsl:variable name="date"><xsl:value-of select="value"/></xsl:variable><xsl:value-of select="converttools:getLocaleTimestampRepresentation($date,$language)"/></xsl:when></xsl:choose></xsl:when></xsl:choose></xsl:if></xsl:attribute>
											</input>
											<!-- Parameter -->
											<!-- <div>
												<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_parameter_section_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="style">display:none;</xsl:attribute>
												<table border="0" width="100%">
													<tr>
														<td width="100">
															<font class="FORMMANDATORY">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FILTERDETAILS_PARAMETER')"/>
															</font>
														</td>
														<td>
															<table border="0" width="100%">
																<tr>
																	<td>
																		<select size="1">
																			<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_parameter_select_<xsl:value-of select="$suffix"/></xsl:attribute>
																			<xsl:attribute name="onblur">if (! fncCheckUseOfParameterInOtherCriteria('fakeform1', '<xsl:value-of select="$structure_name"/>', this.value, <xsl:value-of select="$suffix"/>)) { fncSetDisplaidValue('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, '<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FILTERDETAILS_PARAMETER_CHOICE')"/>' + ' ' + this.options[this.selectedIndex].text); fncPopulateActualCriteriaParameter('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);} fncRestoreInputStyle('fakeform1', '<xsl:value-of select="$structure_name"/>_details_parameter_select_<xsl:value-of select="$suffix"/>');</xsl:attribute>
																			<option value="">
																				<xsl:attribute name="selected"/>
																			</option>
																		</select>
																		<input type="hidden">
																			<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_actual_parameter_<xsl:value-of select="$suffix"/></xsl:attribute>
																			<xsl:if test="$mode = 'existing'">
																				<xsl:if test="value/@type = 'parameter'">
																					<xsl:attribute name="value"><xsl:value-of select="value"/></xsl:attribute>
																				</xsl:if>
																			</xsl:if>
																		</input>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</div>-->
											<!-- String -->
											<div>
												<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_string_section_<xsl:value-of select="$suffix"/></xsl:attribute>
												<!-- xsl:attribute name="style">display:none;</xsl:attribute-->
												<table width="100%">
													<tr>
														<td width="100">
															<font class="FORMMANDATORY">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FILTERDETAILS_VALUE')"/>
															</font>
														</td>
														<td>
															<table border="0" width="100%">
																<tr>
																	<td>
																		<input type="text" size="35">
																			<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_string_value_<xsl:value-of select="$suffix"/></xsl:attribute>
																			<xsl:attribute name="onblur">fncSetDisplaidValue('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, this.value); fncRestoreInputStyle('fakeform1', '<xsl:value-of select="$structure_name"/>_details_string_value_<xsl:value-of select="$suffix"/>');</xsl:attribute>
																			<xsl:attribute name="value">
																				<xsl:if test="$mode = 'existing'">
																					<xsl:if test="value/@type = 'string'">
																						<xsl:if test="column/@type = 'String'">
																							<xsl:value-of select="value"/>
																						</xsl:if>
																					</xsl:if>
																				</xsl:if>
																			</xsl:attribute>
																		</input>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</div>
											<!-- Amount -->
											<div>
												<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_amount_section_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="style">display:none;</xsl:attribute>
												<table width="100%">
													<tr>
														<td width="100">
															<font class="FORMMANDATORY">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FILTERDETAILS_AMOUNT')"/>
															</font>
														</td>
														<td>
															<table border="0" width="100%">
																<tr>
																	<td>
																		<input type="text" size="3">
																			<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_amount_currency_value_<xsl:value-of select="$suffix"/></xsl:attribute>
																			<xsl:attribute name="onblur">fncCheckValidCurrency(this); fncFormatAmount(document.forms['fakeform1'].<xsl:value-of select="$structure_name"/>_details_amount_value_<xsl:value-of select="$suffix"/>, fncGetCurrencyDecNo(this.value)); fncSetDisplaidValue('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, document.forms['fakeform1'].elements['<xsl:value-of select="$structure_name"/>_details_amount_value_<xsl:value-of select="$suffix"/>'].value + ' ' + this.value); fncRestoreInputStyle('fakeform1', '<xsl:value-of select="$structure_name"/>_details_amount_currency_value_<xsl:value-of select="$suffix"/>');</xsl:attribute>
																			<xsl:attribute name="value">
																				<xsl:if test="$mode = 'existing'">
																					<xsl:if test="value/@type = 'string'">
																						<xsl:value-of select="substring-after(value, '@')"/>
																					</xsl:if>
																				</xsl:if>
																			</xsl:attribute>
																		</input>
																		<input type="text" size="20" maxlength="15">
																			<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_amount_value_<xsl:value-of select="$suffix"/></xsl:attribute>
																			<xsl:attribute name="onblur">fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].<xsl:value-of select="$structure_name"/>_details_amount_currency_value_<xsl:value-of select="$suffix"/>.value)); fncSetDisplaidValue('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, this.value + ' ' + document.forms['fakeform1'].elements['<xsl:value-of select="$structure_name"/>_details_amount_currency_value_<xsl:value-of select="$suffix"/>'].value); fncRestoreInputStyle('fakeform1', '<xsl:value-of select="$structure_name"/>_details_amount_value_<xsl:value-of select="$suffix"/>');</xsl:attribute>
																			<xsl:attribute name="value">
																				<xsl:if test="$mode = 'existing'">
																					<xsl:if test="value/@type = 'string'">
																						<xsl:if test="column/@type = 'Amount'">
																							<xsl:variable name="amount"><xsl:value-of select="substring-before(value, '@')"/></xsl:variable>
																							<xsl:variable name="currency"><xsl:value-of select="substring-after(value, '@')"/></xsl:variable>
																							<xsl:value-of select="converttools:getLocaleAmountRepresentation($amount, $currency, $language)"/>
																						</xsl:if>
																					</xsl:if>
																				</xsl:if>
																			</xsl:attribute>
																		</input>
																		&nbsp;
																		<a href="javascript:void(0)">
																			<xsl:attribute name="onclick">fncDynamicSearchPopup('currency', 'fakeform1', '<xsl:value-of select="$structure_name"/>_details_amount_currency_value_<xsl:value-of select="$suffix"/>');</xsl:attribute>
																			<img border="0">
																				<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchImage)"/></xsl:attribute>
																				<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
																			</img>
																		</a>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</div>
											<!-- Date -->
											<div>
												<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_date_section_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="style">display:none;</xsl:attribute>
												<table width="100%">
													<tr>
														<td width="100">
															<font class="FORMMANDATORY">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FILTERDETAILS_DATE')"/>
															</font>
														</td>
														<td>
															<table border="0" width="100%">
																<tr>
																	<td>
																		<input type="text" size="10" maxlength="10">
																			<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_date_value_<xsl:value-of select="$suffix"/></xsl:attribute>
																			<xsl:attribute name="onblur">fncCheckValueDate('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, this); fncRestoreInputStyle('fakeform1', '<xsl:value-of select="$structure_name"/>_details_date_value_<xsl:value-of select="$suffix"/>');</xsl:attribute>
																			<xsl:attribute name="value">
																				<xsl:if test="$mode = 'existing'">
																					<xsl:if test="value/@type = 'string'">
																						<xsl:if test="column/@type = 'Date'">
																							<xsl:variable name="date"><xsl:value-of select="value"/></xsl:variable>
																							<xsl:value-of select="converttools:getLocaleTimestampRepresentation($date,$language)"/>
																						</xsl:if>
																					</xsl:if>
																				</xsl:if>
																			</xsl:attribute>
																		</input>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</div>
											<!-- Values set -->
											<div>
												<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_values_set_section_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="style">display:none;</xsl:attribute>
												<table border="0" width="100%">
													<tr>
														<td width="100">
															<font class="FORMMANDATORY">
																<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FILTERDETAILS_VALUE')"/>
															</font>
														</td>
														<td>
															<table border="0" width="100%">
																<tr>
																	<td>
																		<select size="1">
																			<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_values_set_select_<xsl:value-of select="$suffix"/></xsl:attribute>
																			<xsl:attribute name="onblur">fncSetDisplaidValue('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, this.options[this.selectedIndex].text); fncPopulateActualCriteriaValuesSet('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>); fncRestoreInputStyle('fakeform1', '<xsl:value-of select="$structure_name"/>_details_values_set_select_<xsl:value-of select="$suffix"/>');</xsl:attribute>
																			<option value="">
																				<xsl:attribute name="selected"/>
																			</option>
																		</select>
																		<input type="hidden">
																			<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_values_set_parameter_<xsl:value-of select="$suffix"/></xsl:attribute>
																			<xsl:attribute name="value">
																				<xsl:if test="$mode = 'existing'">
																					<xsl:if test="value/@type = 'string'">
																						<xsl:if test="column/@type = 'ValuesSet'">
																							<xsl:value-of select="value"/>
																						</xsl:if>
																					</xsl:if>
																				</xsl:if>
																			</xsl:attribute>
																		</input>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</div>
										</td>
									</tr>
									<tr>
										<td colspan="2">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="2">
											<table width="100%">
												<td align="right" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">if (fncCheckCriteriaMandatoryFields('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>)) fncAddElementValidate('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, '', ['column', 'operator'], ['column', 'operator', 'displaid_value'], ['<xsl:value-of select="$structure_name"/>_table_header_1']);</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
													</a>
												</td>
												<td width="10%"/>
												<td align="left" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_cancel_button_<xsl:value-of select="$suffix"/></xsl:attribute>
														<xsl:attribute name="onClick">fncAddElementCancel('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, 'column', ['<xsl:value-of select="$structure_name"/>_table_header_1']);</xsl:attribute>
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

	<!--*************************************************************************-->
	<!-- Template used that returns the localized description of a business code -->
	<!--*************************************************************************-->
	<xsl:template name="Column_Value_Description">
		<xsl:param name="columnName"></xsl:param>
		<xsl:param name="columnValue"></xsl:param>
	</xsl:template>
	
</xsl:stylesheet>
