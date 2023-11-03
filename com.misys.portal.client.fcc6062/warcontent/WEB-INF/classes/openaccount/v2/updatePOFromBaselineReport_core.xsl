<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:default="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	exclude-result-prefixes="default tools">

	<xsl:import href="common.xsl"/>
	
	<xsl:output method="xml" indent="yes"/>
	
	<xsl:param name="source"/>
	
	<xsl:variable name="baselineReport" select="tools:convertToNode($source)"/>
	
	<xsl:template match="/">
		<xsl:copy >
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match = "*">
		<xsl:param name="currentLineItemNumber"/>
		<!-- <currentLineItemNumber><xsl:value-of select="$currentLineItemNumber"/></currentLineItemNumber>-->
		<xsl:choose>
			<!--           -->
			<!-- PO record -->
			<!--           -->

			<!-- Total Ordered Amount -->
			<xsl:when test="local-name()='order_total_amt'">
				<xsl:element name="order_total_amt">
					<xsl:value-of select="$baselineReport//RptdLineItm/OrdrdLineItmsTtlAmt"/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="local-name()='order_total_cur_code'">
				<xsl:element name="order_total_cur_code">
					<xsl:value-of select="$baselineReport//RptdLineItm/OrdrdLineItmsTtlAmt/@Ccy"/>
				</xsl:element>
			</xsl:when>
			<!-- Total Ordered Net Amount -->
			<xsl:when test="local-name()='order_total_net_amt'">
				<xsl:element name="order_total_net_amt">
					<xsl:value-of select="$baselineReport//RptdLineItm/OrdrdTtlNetAmt"/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="local-name()='order_total_net_cur_code'">
				<xsl:element name="order_total_net_cur_code">
					<xsl:value-of select="$baselineReport//RptdLineItm/OrdrdTtlNetAmt/@Ccy"/>
				</xsl:element>
			</xsl:when>
			<!-- Total Accepted Amount -->
			<xsl:when test="local-name()='accpt_total_amt'">
				<xsl:element name="accpt_total_amt">
					<xsl:value-of select="$baselineReport//RptdLineItm/AccptdLineItmsTtlAmt"/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="local-name()='accpt_total_cur_code'">
				<xsl:element name="accpt_total_cur_code">
					<xsl:value-of select="$baselineReport//RptdLineItm/AccptdLineItmsTtlAmt/@Ccy"/>
				</xsl:element>
			</xsl:when>
			<!-- Total Accepted Net Amount -->
			<xsl:when test="local-name()='accpt_total_net_amt'">
				<xsl:element name="accpt_total_net_amt">
					<xsl:value-of select="$baselineReport//RptdLineItm/AccptdTtlNetAmt"/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="local-name()='accpt_total_net_cur_code'">
				<xsl:element name="accpt_total_net_cur_code">
					<xsl:value-of select="$baselineReport//RptdLineItm/AccptdTtlNetAmt/@Ccy"/>
				</xsl:element>
			</xsl:when>
			<!-- Total Outstanding Amount -->
			<xsl:when test="local-name()='liab_total_amt'">
				<xsl:element name="liab_total_amt">
					<xsl:value-of select="$baselineReport//RptdLineItm/OutsdngLineItmsTtlAmt"/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="local-name()='outstanding_total_amt'">
				<xsl:element name="outstanding_total_amt">
					<xsl:value-of select="$baselineReport//RptdLineItm/OutsdngLineItmsTtlAmt"/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="local-name()='liab_total_cur_code'">
				<xsl:element name="liab_total_cur_code">
					<xsl:value-of select="$baselineReport//RptdLineItm/OutsdngLineItmsTtlAmt/@Ccy"/>
				</xsl:element>
			</xsl:when>
			<!-- Total Outstanding Net Amount -->
			<xsl:when test="local-name()='liab_total_net_amt'">
				<xsl:element name="liab_total_net_amt">
					<xsl:value-of select="$baselineReport//RptdLineItm/OutsdngTtlNetAmt"/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="local-name()='liab_total_net_cur_code'">
				<xsl:element name="liab_total_net_cur_code">
					<xsl:value-of select="$baselineReport//RptdLineItm/OutsdngTtlNetAmt/@Ccy"/>
				</xsl:element>
			</xsl:when>

			
			<!--           -->
			<!-- Line Item -->
			<!--           -->
			
			<xsl:when test="local-name()='line_items'">
				
				<line_items>

					<!-- First browse existing SO line items and merge them with the BaselineReport line items -->
					<xsl:apply-templates select="lt_tnx_record" mode="mergeWithBaselineReport"/>
				
					<!-- Secondly browse existing BaselineReport line items and add them if not existing as SO line items -->
					<xsl:variable name="xmlRecord" select="//po_tnx_record"/>
					<xsl:for-each select="$baselineReport//LineItmDtls">
						<xsl:variable name="lineItemNumber" select="./LineItmId"/>
						
						<xsl:if test="count($xmlRecord//lt_tnx_record[line_item_number=$lineItemNumber]) = 0">
							<xsl:call-template name="copyBaselineReportLineItemAsSOLineItem">
								<xsl:with-param name="lineItemNumber" select="$lineItemNumber"/>
								<xsl:with-param name="xmlRecord" select="$xmlRecord"/>
							</xsl:call-template>
						</xsl:if>
					</xsl:for-each>

				</line_items>

			</xsl:when>
			
			<xsl:otherwise>
				<xsl:element name="{local-name()}">
					<xsl:apply-templates select = "node()|@*">
						<xsl:with-param name="currentLineItemNumber" select="$currentLineItemNumber"/>
					</xsl:apply-templates>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match = "@*">
		<xsl:attribute name="{local-name()}">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:template>

	<xsl:template name="mergeLtTnxRecordWithBaselineReport">
		<xsl:param name="lineItemNumber"/>
		
		<lt_tnx_record>
			<brch_code><xsl:value-of select="brch_code"/></brch_code>
			<ref_id><xsl:value-of select="ref_id"/></ref_id>
			<bo_ref_id><xsl:value-of select="bo_ref_id"/></bo_ref_id>
			<cust_ref_id><xsl:value-of select="$lineItemNumber"/></cust_ref_id>
			<po_ref_id><xsl:value-of select="po_ref_id"/></po_ref_id>
			<company_name><xsl:value-of select="company_name"/></company_name>
			<tnx_type_code><xsl:value-of select="tnx_type_code"/></tnx_type_code>
			<sub_tnx_type_code><xsl:value-of select="sub_tnx_type_code"/></sub_tnx_type_code>
			<prod_stat_code><xsl:value-of select="prod_stat_code"/></prod_stat_code>
			<tnx_stat_code><xsl:value-of select="tnx_stat_code"/></tnx_stat_code>
			<product_code>LT</product_code>
			<tnx_cur_code><xsl:value-of select="TtlAmt/@Ccy"/></tnx_cur_code>
			<tnx_amt>
				<xsl:call-template name="TP_amount">
      			<xsl:with-param name="amount"><xsl:value-of select="TtlAmt"/></xsl:with-param>
      		</xsl:call-template>
			</tnx_amt>
			<entity><xsl:value-of select="entity"/></entity>
			<line_item_number><xsl:value-of select="$lineItemNumber"/></line_item_number>
			<xsl:choose>
				<xsl:when test="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OrdrdQty">
					<qty_unit_measr_code><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OrdrdQty/UnitOfMeasrCd"/></qty_unit_measr_code>
					<qty_other_unit_measr><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OrdrdQty/OthrUnitOfMeasr"/></qty_other_unit_measr>
					<qty_val><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OrdrdQty/Val"/></qty_val>
					<qty_factor><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OrdrdQty/Fctr"/></qty_factor>
				</xsl:when>
				<xsl:otherwise>
					<qty_unit_measr_code><xsl:value-of select="qty_unit_measr_code"/></qty_unit_measr_code>
					<qty_other_unit_measr><xsl:value-of select="qty_other_unit_measr"/></qty_other_unit_measr>
					<qty_val><xsl:value-of select="qty_val"/></qty_val>
					<qty_factor><xsl:value-of select="qty_factor"/></qty_factor>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/AccptdQty">
					<accpt_qty_unit_measr_code><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/AccptdQty/UnitOfMeasrCd"/></accpt_qty_unit_measr_code>
					<accpt_qty_other_unit_measr><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/AccptdQty/OthrUnitOfMeasr"/></accpt_qty_other_unit_measr>
					<accpt_qty_val><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/AccptdQty/Val"/></accpt_qty_val>
					<accpt_qty_factor><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/AccptdQty/Fctr"/></accpt_qty_factor>
				</xsl:when>
				<xsl:otherwise>
					<accpt_qty_unit_measr_code><xsl:value-of select="accpt_qty_unit_measr_code"/></accpt_qty_unit_measr_code>
					<accpt_qty_other_unit_measr><xsl:value-of select="accpt_qty_other_unit_measr"/></accpt_qty_other_unit_measr>
					<accpt_qty_val><xsl:value-of select="accpt_qty_val"/></accpt_qty_val>
					<accpt_qty_factor><xsl:value-of select="accpt_qty_factor"/></accpt_qty_factor>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OutsdngQty">
					<outsdng_qty_unit_measr_code><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OutsdngQty/UnitOfMeasrCd"/></outsdng_qty_unit_measr_code>
					<outsdng_qty_other_unit_measr><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OutsdngQty/OthrUnitOfMeasr"/></outsdng_qty_other_unit_measr>
					<outsdng_qty_val><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OutsdngQty/Val"/></outsdng_qty_val>
					<outsdng_qty_factor><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OutsdngQty/Fctr"/></outsdng_qty_factor>
				</xsl:when>
				<xsl:otherwise>
					<outsdng_qty_unit_measr_code><xsl:value-of select="outsdng_qty_unit_measr_code"/></outsdng_qty_unit_measr_code>
					<outsdng_qty_other_unit_measr><xsl:value-of select="outsdng_qty_other_unit_measr"/></outsdng_qty_other_unit_measr>
					<outsdng_qty_val><xsl:value-of select="outsdng_qty_val"/></outsdng_qty_val>
					<outsdng_qty_factor><xsl:value-of select="outsdng_qty_factor"/></outsdng_qty_factor>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PdgQty">
					<pdg_qty_unit_measr_code><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PdgQty/UnitOfMeasrCd"/></pdg_qty_unit_measr_code>
					<pdg_qty_other_unit_measr><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PdgQty/OthrUnitOfMeasr"/></pdg_qty_other_unit_measr>
					<pdg_qty_val><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PdgQty/Val"/></pdg_qty_val>
					<pdg_qty_factor><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PdgQty/Fctr"/></pdg_qty_factor>
				</xsl:when>
				<xsl:otherwise>
					<pdg_qty_unit_measr_code><xsl:value-of select="pdg_qty_unit_measr_code"/></pdg_qty_unit_measr_code>
					<pdg_qty_other_unit_measr><xsl:value-of select="pdg_qty_other_unit_measr"/></pdg_qty_other_unit_measr>
					<pdg_qty_val><xsl:value-of select="pdg_qty_val"/></pdg_qty_val>
					<pdg_qty_factor><xsl:value-of select="pdg_qty_factor"/></pdg_qty_factor>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/QtyTlrnce">
					<qty_tol_pstv_pct><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/QtyTlrnce/PlusPct"/></qty_tol_pstv_pct>
					<qty_tol_neg_pct><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/QtyTlrnce/MnsPct"/></qty_tol_neg_pct>
				</xsl:when>
				<xsl:otherwise>
					<qty_tol_pstv_pct><xsl:value-of select="qty_tol_pstv_pct"/></qty_tol_pstv_pct>
					<qty_tol_neg_pct><xsl:value-of select="qty_tol_neg_pct"/></qty_tol_neg_pct>
				</xsl:otherwise>
			</xsl:choose>
			<price_unit_measr_code><xsl:value-of select="price_unit_measr_code"/></price_unit_measr_code>
			<price_other_unit_measr><xsl:value-of select="price_other_unit_measr"/></price_other_unit_measr>
			<price_amt><xsl:value-of select="price_amt"/></price_amt>
			<price_cur_code><xsl:value-of select="price_cur_code"/></price_cur_code>
			<price_factor><xsl:value-of select="price_factor"/></price_factor>
			<xsl:choose>
				<xsl:when test="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PricTlrnce">
					<price_tol_pstv_pct><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PricTlrnce/PlusPct"/></price_tol_pstv_pct>
					<price_tol_neg_pct><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PricTlrnce/MnsPct"/></price_tol_neg_pct>
				</xsl:when>
				<xsl:otherwise>
					<price_tol_pstv_pct><xsl:value-of select="price_tol_pstv_pct"/></price_tol_pstv_pct>
					<price_tol_neg_pct><xsl:value-of select="price_tol_neg_pct"/></price_tol_neg_pct>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PdctNm">
					<product_name><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PdctNm"/></product_name>
				</xsl:when>
				<xsl:otherwise>
					<product_name><xsl:value-of select="product_name"/></product_name>
				</xsl:otherwise>
			</xsl:choose>
			<product_orgn><xsl:value-of select="product_orgn"/></product_orgn>
			<freight_charges_type><xsl:value-of select="freight_charges_type"/></freight_charges_type>
			<last_ship_date><xsl:value-of select="last_ship_date"/></last_ship_date>
			<!-- <xsl:choose>
				<xsl:when test="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OrdrdAmt">
					<order_total_net_amt><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OrdrdAmt"/></order_total_net_amt>
					<order_total_net_cur_code><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OrdrdAmt/@Ccy"/></order_total_net_cur_code>
				</xsl:when>
				<xsl:otherwise>
					<apply-templates select="order_total_net_amt"/>
					<apply-templates select="order_total_net_cur_code"/>
				</xsl:otherwise>
			</xsl:choose>-->
			<xsl:choose>
				<xsl:when test="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/AccptdAmt">
					<accpt_total_amt><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/AccptdAmt"/></accpt_total_amt>
					<accpt_total_cur_code><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/AccptdAmt/@Ccy"/></accpt_total_cur_code>
				</xsl:when>
				<xsl:otherwise>
					<accpt_total_amt><xsl:value-of select="accpt_total_amt"/></accpt_total_amt>
					<accpt_total_cur_code><xsl:value-of select="accpt_total_cur_code"/></accpt_total_cur_code>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OutsdngAmt">
					<liab_total_amt><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OutsdngAmt"/></liab_total_amt>
					<liab_total_cur_code><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OutsdngAmt/@Ccy"/></liab_total_cur_code>
				</xsl:when>
				<xsl:otherwise>
					<liab_total_amt><xsl:value-of select="liab_total_amt"/></liab_total_amt>
					<liab_total_cur_code><xsl:value-of select="liab_total_cur_code"/></liab_total_cur_code>
				</xsl:otherwise>
			</xsl:choose>
		</lt_tnx_record>
		
	</xsl:template>		

	<xsl:template name="copyBaselineReportLineItemAsSOLineItem">
		<xsl:param name="lineItemNumber"/>
		<xsl:param name="xmlRecord"/>
		
		<lt_tnx_record>
			<brch_code><xsl:value-of select="$xmlRecord/brch_code"/></brch_code>
			<ref_id><xsl:value-of select="ref_id"/></ref_id>
			<bo_ref_id><xsl:value-of select="$xmlRecord/bo_ref_id"/></bo_ref_id>
			<cust_ref_id><xsl:value-of select="$lineItemNumber"/></cust_ref_id>
			<po_ref_id><xsl:value-of select="$xmlRecord/po_ref_id"/></po_ref_id>
			<company_name><xsl:value-of select="$xmlRecord/company_name"/></company_name>
			<tnx_type_code><xsl:value-of select="$xmlRecord/tnx_type_code"/></tnx_type_code>
			<sub_tnx_type_code><xsl:value-of select="$xmlRecord/sub_tnx_type_code"/></sub_tnx_type_code>
			<prod_stat_code><xsl:value-of select="$xmlRecord/prod_stat_code"/></prod_stat_code>
			<tnx_stat_code><xsl:value-of select="$xmlRecord/tnx_stat_code"/></tnx_stat_code>
			<product_code>LT</product_code>
			<tnx_cur_code><xsl:value-of select="TtlAmt/@Ccy"/></tnx_cur_code>
			<tnx_amt>
				<xsl:call-template name="TP_amount">
      			<xsl:with-param name="amount"><xsl:value-of select="TtlAmt"/></xsl:with-param>
      		</xsl:call-template>
			</tnx_amt>
			<entity><xsl:value-of select="$xmlRecord/entity"/></entity>
			<line_item_number><xsl:value-of select="$lineItemNumber"/></line_item_number>
			<qty_unit_measr_code><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OrdrdQty/UnitOfMeasrCd"/></qty_unit_measr_code>
			<qty_other_unit_measr><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OrdrdQty/OthrUnitOfMeasr"/></qty_other_unit_measr>
			<qty_val><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OrdrdQty/Val"/></qty_val>
			<qty_factor><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OrdrdQty/Fctr"/></qty_factor>
			<accpt_qty_unit_measr_code><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/AccptdQty/UnitOfMeasrCd"/></accpt_qty_unit_measr_code>
			<accpt_qty_other_unit_measr><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/AccptdQty/OthrUnitOfMeasr"/></accpt_qty_other_unit_measr>
			<accpt_qty_val><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/AccptdQty/Val"/></accpt_qty_val>
			<accpt_qty_factor><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/AccptdQty/Fctr"/></accpt_qty_factor>
			<outsdng_qty_unit_measr_code><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OutsdngQty/UnitOfMeasrCd"/></outsdng_qty_unit_measr_code>
			<outsdng_qty_other_unit_measr><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OutsdngQty/OthrUnitOfMeasr"/></outsdng_qty_other_unit_measr>
			<outsdng_qty_val><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OutsdngQty/Val"/></outsdng_qty_val>
			<outsdng_qty_factor><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OutsdngQty/Fctr"/></outsdng_qty_factor>
			<pdg_qty_unit_measr_code><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PdgQty/UnitOfMeasrCd"/></pdg_qty_unit_measr_code>
			<pdg_qty_other_unit_measr><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PdgQty/OthrUnitOfMeasr"/></pdg_qty_other_unit_measr>
			<pdg_qty_val><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PdgQty/Val"/></pdg_qty_val>
			<pdg_qty_factor><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PdgQty/Fctr"/></pdg_qty_factor>
			<xsl:if test="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/QtyTlrnce">
				<qty_tol_pstv_pct><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/QtyTlrnce/PlusPct"/></qty_tol_pstv_pct>
				<qty_tol_neg_pct><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/QtyTlrnce/MnsPct"/></qty_tol_neg_pct>
			</xsl:if>
			<!-- Surprisingly, the price details are not exposed in the BaselineReport  -->
			<!-- How to handle the case where a new line item is added upon PO amendment? -->
			<!-- <price_unit_measr_code><xsl:value-of select="price_unit_measr_code"/></price_unit_measr_code>
			<price_other_unit_measr><xsl:value-of select="price_other_unit_measr"/></price_other_unit_measr>
			<price_amt><xsl:value-of select="price_amt"/></price_amt>
			<price_cur_code><xsl:value-of select="price_cur_code"/></price_cur_code>
			<price_factor><xsl:value-of select="price_factor"/></price_factor>-->
			<xsl:if test="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PricTlrnce">
				<price_tol_pstv_pct><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PricTlrnce/PlusPct"/></price_tol_pstv_pct>
				<price_tol_neg_pct><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PricTlrnce/MnsPct"/></price_tol_neg_pct>
			</xsl:if>
			<xsl:if test="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PdctNm">
				<product_name><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/PdctNm"/></product_name>
			</xsl:if>
			<!-- Items not exposed in the BaselineReport ! -->
			<!-- <product_orgn><xsl:value-of select="product_orgn"/></product_orgn>
			<freight_charges_type><xsl:value-of select="freight_charges_type"/></freight_charges_type>
			<last_ship_date><xsl:value-of select="last_ship_date"/></last_ship_date>-->
			<xsl:if test="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OrdrdAmt">
				<order_total_net_amt><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OrdrdAmt"/></order_total_net_amt>
				<order_total_net_cur_code><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OrdrdAmt/@Ccy"/></order_total_net_cur_code>
			</xsl:if>
			<xsl:if test="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/AccptdAmt">
				<accpt_total_amt><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/AccptdAmt"/></accpt_total_amt>
				<accpt_total_cur_code><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/AccptdAmt/@Ccy"/></accpt_total_cur_code>
			</xsl:if>
			<xsl:if test="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OutsdngAmt">
				<liab_total_amt><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OutsdngAmt"/></liab_total_amt>
				<liab_total_cur_code><xsl:value-of select="$baselineReport//LineItmDtls[LineItmId=$lineItemNumber]/OutsdngAmt/@Ccy"/></liab_total_cur_code>
			</xsl:if>
		</lt_tnx_record>
		
	</xsl:template>		
	
	<xsl:template match="lt_tnx_record" mode="mergeWithBaselineReport">
		<xsl:variable name="lineItemNumber" select="line_item_number"/>

		<xsl:if test="count($baselineReport//LineItmDtls[LineItmId=$lineItemNumber]) > 0">
			<xsl:call-template name="mergeLtTnxRecordWithBaselineReport">
				<xsl:with-param name="lineItemNumber" select="$lineItemNumber"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	</xsl:stylesheet>
