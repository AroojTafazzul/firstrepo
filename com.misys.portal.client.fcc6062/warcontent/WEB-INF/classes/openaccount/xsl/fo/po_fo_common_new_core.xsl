<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<!--
	Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
	All Rights Reserved. 
-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	
	<!-- Common variables and templates -->
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	
	<xsl:variable name="pdfNestedTableWidth">
		<xsl:value-of select="number(substring-before($pdfTableWidth,'%')) - 10" />%
	</xsl:variable>
	<xsl:variable name="nestedLabelColumnWidth">
		<xsl:value-of select="number(substring-before($labelColumnWidth,'%')) - 5" />%
	</xsl:variable>
	<xsl:variable name="nestedDetailsColumnWidth">
		<xsl:value-of select="number(substring-before($detailsColumnWidth,'%')) - 5" />%
	</xsl:variable>
	<xsl:variable name="background">
		BLACK
	</xsl:variable>
	
	<!-- Adjustments template (Header)-->
	<xsl:template match="adjustments">
		<xsl:param name="isSubItem">N</xsl:param>
		<xsl:param name="isSubSubItem">N</xsl:param>
		
		<xsl:if test="count(adjustment) > 0">	

			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:choose>
						<xsl:when test="$isSubSubItem = 'Y'">
							<xsl:call-template name="sub_subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ADJUSTMENTS_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="$isSubItem = 'Y'">
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ADJUSTMENTS_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ADJUSTMENTS_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
	
			<xsl:choose>
				<xsl:when test="count(adjustment[amt!='']) != 0 and count(adjustment[rate!='']) = 0">
					<xsl:call-template name="table_3_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_CUR_CODE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
								<xsl:with-param name="column_3_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_AMOUNT')"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_weight"/>
								<xsl:with-param name="column_3_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each adjustment -->
							<xsl:apply-templates select="adjustment"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="count(adjustment[rate!='']) != 0 and count(adjustment[amt!='']) = 0">
					<xsl:call-template name="table_2_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_RATE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each adjustment -->
							<xsl:apply-templates select="adjustment"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="table_3_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_CUR_CODE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
								<xsl:with-param name="column_3_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_AMOUNT_OR_RATE')"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_weight"/>
								<xsl:with-param name="column_3_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each adjustment -->
							<xsl:apply-templates select="adjustment"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	<!-- Adjustment template -->
	<xsl:template match="adjustment | tax | freight_charge | freightCharge | allowance">
		<!-- Set the value of the displayed type-->
		<xsl:variable name="displayedType">
			<xsl:choose>
				<xsl:when test="type[. !='']">
					<xsl:value-of select="localization:getDecode($language, 'N210', type)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="other_type"/>
				</xsl:otherwise>						
			</xsl:choose>			
		</xsl:variable>
		
		<xsl:variable name="elementName"><xsl:value-of select="name()"/></xsl:variable>

		<xsl:choose>
			<xsl:when test="count(../*[name()=$elementName and amt!='']) != 0 and count(../*[name()=$elementName and rate!='']) = 0">
				<xsl:call-template name="table_cell_3_columns">
					<xsl:with-param name="column_1_text"><xsl:value-of select="$displayedType"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
					<xsl:with-param name="column_2_text"><xsl:value-of select="cur_code"/></xsl:with-param>
					<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
					<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
					<xsl:with-param name="column_2_text_align">center</xsl:with-param>
					<xsl:with-param name="column_3_text">
						<xsl:choose>
							<xsl:when test="direction[.='ADDD']">+</xsl:when>
							<xsl:when test="direction[.='SUBS']">-</xsl:when>
							<xsl:otherwise/>
						</xsl:choose>
						<xsl:value-of select="amt"/>		
					</xsl:with-param>
					<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
					<xsl:with-param name="column_3_text_font_weight">bold</xsl:with-param>
					<xsl:with-param name="column_3_text_align">right</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="count(../*[name()=$elementName and rate!='']) != 0 and count(../*[name()=$elementName and amt!='']) = 0">
				<xsl:call-template name="table_cell_2_columns">
					<xsl:with-param name="column_1_text"><xsl:value-of select="$displayedType"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
					<xsl:with-param name="column_1_text_align">center</xsl:with-param>
					<xsl:with-param name="column_2_text">
						<xsl:choose>
							<xsl:when test="direction[.='ADDD']">+</xsl:when>
							<xsl:when test="direction[.='SUBS']">-</xsl:when>
							<xsl:otherwise/>
						</xsl:choose>
						<xsl:value-of select="rate"/>%		
					</xsl:with-param>
					<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
					<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
					<xsl:with-param name="column_2_text_align">right</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="table_cell_3_columns">
					<xsl:with-param name="column_1_text"><xsl:value-of select="$displayedType"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
					<xsl:with-param name="column_2_text"><xsl:value-of select="cur_code"/></xsl:with-param>
					<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
					<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
					<xsl:with-param name="column_2_text_align">center</xsl:with-param>
					<xsl:with-param name="column_3_text">
						<xsl:choose>
							<xsl:when test="direction[.='ADDD']">+</xsl:when>
							<xsl:when test="direction[.='SUBS']">-</xsl:when>
							<xsl:otherwise/>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="cur_code[.!='']">
								<xsl:value-of select="amt"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="rate"/>%
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
					<xsl:with-param name="column_3_text_font_weight">bold</xsl:with-param>
					<xsl:with-param name="column_3_text_align">right</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- Taxes template (Header)-->
	<xsl:template match="taxes">
		<xsl:param name="isSubItem">N</xsl:param>
		<xsl:param name="isSubSubItem">N</xsl:param>
	
		<xsl:if test="count(tax) > 0">
		
			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:choose>
						<xsl:when test="$isSubSubItem = 'Y'">
							<xsl:call-template name="sub_subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TAXES_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="$isSubItem = 'Y'">
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TAXES_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TAXES_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
	
			<xsl:choose>
				<xsl:when test="count(tax[amt!='']) != 0 and count(tax[rate!='']) = 0">
					<xsl:call-template name="table_3_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_CUR_CODE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
								<xsl:with-param name="column_3_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_AMOUNT')"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_weight"/>
								<xsl:with-param name="column_3_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each tax -->
							<xsl:apply-templates select="tax"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="count(tax[rate!='']) != 0 and count(tax[amt!='']) = 0">
					<xsl:call-template name="table_2_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_RATE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each adjustment -->
							<xsl:apply-templates select="tax"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="table_3_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_CUR_CODE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
								<xsl:with-param name="column_3_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_AMOUNT_OR_RATE')"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_weight"/>
								<xsl:with-param name="column_3_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each tax -->
							<xsl:apply-templates select="tax"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<!-- Freight Charges Details --> 
	<xsl:template match="freightCharges">
		<xsl:param name="isSubItem">N</xsl:param>
		<xsl:param name="isSubSubItem">N</xsl:param>
					
		<xsl:if test="count(freightCharge) > 0">
		
			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:choose>
						<xsl:when test="$isSubSubItem = 'Y'">
							<xsl:call-template name="sub_subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREIGHT_CHARGES_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="$isSubItem = 'Y'">
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREIGHT_CHARGES_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREIGHT_CHARGES_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>

			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_FREIGHT_CHARGES_TYPE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="../freight_charges_type[. = 'CLCT']">
									<xsl:value-of select="localization:getDecode($language, 'N211', 'CLCT')"/>
								</xsl:when>
								<xsl:when test="../freight_charges_type[. = 'PRPD']">
									<xsl:value-of select="localization:getDecode($language, 'N211', 'PRPD')"/>
								</xsl:when>
								<xsl:otherwise/>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>

			<xsl:call-template name="spacer_template"/>
				
			<xsl:choose>
				<xsl:when test="count(freightCharge[amt!='']) != 0 and count(freightCharge[rate!='']) = 0">
					<xsl:call-template name="table_3_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_CUR_CODE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
								<xsl:with-param name="column_3_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_AMOUNT')"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_weight"/>
								<xsl:with-param name="column_3_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each freight charge -->
							<xsl:apply-templates select="freightCharge"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="count(freightCharge[rate!='']) != 0 and count(freightCharge[amt!='']) = 0">
					<xsl:call-template name="table_2_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_RATE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each adjustment -->
							<xsl:apply-templates select="freightCharge"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="table_3_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_CUR_CODE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
								<xsl:with-param name="column_3_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_AMOUNT_OR_RATE')"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_weight"/>
								<xsl:with-param name="column_3_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each freight charge -->
							<xsl:apply-templates select="freightCharge"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	<!--Line Item Freight Charges Details -->
	<xsl:template match="freight_charges">
		<xsl:param name="isSubItem">N</xsl:param>
		<xsl:param name="isSubSubItem">N</xsl:param>
					
		<xsl:if test="count(freight_charge) > 0">
		
			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:choose>
						<xsl:when test="$isSubSubItem = 'Y'">
							<xsl:call-template name="sub_subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREIGHT_CHARGES_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="$isSubItem = 'Y'">
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREIGHT_CHARGES_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREIGHT_CHARGES_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>

			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_FREIGHT_CHARGES_TYPE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="../freight_charges_type[. = 'CLCT']">
									<xsl:value-of select="localization:getDecode($language, 'N211', 'CLCT')"/>
								</xsl:when>
								<xsl:when test="../freight_charges_type[. = 'PRPD']">
									<xsl:value-of select="localization:getDecode($language, 'N211', 'PRPD')"/>
								</xsl:when>
								<xsl:otherwise/>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>

			<xsl:call-template name="spacer_template"/>
				
			<xsl:choose>
				<xsl:when test="count(freight_charge[amt!='']) != 0 and count(freight_charge[rate!='']) = 0">
					<xsl:call-template name="table_3_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_CUR_CODE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
								<xsl:with-param name="column_3_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_AMOUNT')"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_weight"/>
								<xsl:with-param name="column_3_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each freight charge -->
							<xsl:apply-templates select="freight_charge"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="count(freight_charge[rate!='']) != 0 and count(freight_charge[amt!='']) = 0">
					<xsl:call-template name="table_2_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_RATE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each adjustment -->
							<xsl:apply-templates select="freight_charge"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="table_3_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_CUR_CODE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
								<xsl:with-param name="column_3_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_AMOUNT_OR_RATE')"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_weight"/>
								<xsl:with-param name="column_3_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each freight charge -->
							<xsl:apply-templates select="freight_charge"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	
	<!-- Payment Terms template (Header) -->
	<xsl:template match="payments">
		<xsl:param name="payments-id"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PAYMENT_TERMS_DETAILS')"/></xsl:param>
		<xsl:param name="pymt_due_date"/>
		<xsl:param name="expected_payment_date"/>
		<xsl:param name="tnx_type_code"/>
		<!-- <xsl:if test="count(payment) > 0">-->

			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="id" select="$payments-id" />
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PAYMENT_TERMS_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:choose>
						<xsl:when test="$tnx_type_code = '63'">
							<xsl:if test="$pymt_due_date != ''">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_PAYMENT_DUE_DATE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="$pymt_due_date" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="$expected_payment_date != ''">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_EXPECTED_PAYMENT_DATE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="$expected_payment_date" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:when>
						<xsl:when test="$tnx_type_code = '49'">
							<xsl:if test="$expected_payment_date != ''">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_EXPECTED_PAYMENT_DATE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="$expected_payment_date" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="$pymt_due_date != ''">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_PAYMENT_DUE_DATE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="$pymt_due_date" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:if test="$tnx_type_code != '49'">
				<xsl:apply-templates select="payment"/>
			</xsl:if>
	
			

		<!-- </xsl:if>-->
		
	</xsl:template>
	
	<!-- Payment term template -->
	<xsl:template match="payment">
	
		<!-- Set the value of the displayed type-->
		<xsl:variable name="displayedCode">
			<xsl:choose>
				<xsl:when test="code[.!='' and .!='OTHR']">
					<xsl:value-of select="localization:getDecode($language, 'N208', code)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="other_paymt_terms"/>
				</xsl:otherwise>						
			</xsl:choose>
		</xsl:variable>

		<!-- Payment term -->
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="subtitle">
					<xsl:with-param name="text">
						<xsl:value-of select="$displayedCode"/>
						<xsl:if test="nb_days[.!='']">
							&nbsp;(+<xsl:value-of select="nb_days"/>&nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_PAYMENT_PERIOD_DAYS')"/>)
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>

		<!-- Product details -->
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:if test="paymt_date !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_PO_PAYMENT_DATE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="paymt_date" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="amt !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_PO_PAYMENT_AMT')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="cur_code"/>&nbsp;<xsl:value-of select="amt"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="pct !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_PO_PAYMENT_PERCENTAGE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="pct"/>%
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				
				<xsl:if test="itp_payment_amt !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_NET_PAYMENT_AMOUNT')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="itp_payment_amt"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				
				<xsl:if test="itp_payment_date !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_EXPECTED__ITP_PAYMENT_DATE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="itp_payment_date"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="spacer_template"/>
	</xsl:template>
	
	<!-- Incoterms template (Header) -->
	<xsl:template match="incoterms">
		<xsl:param name="isSubItem">N</xsl:param>
		<xsl:param name="isSubSubItem">N</xsl:param>
		
		<xsl:if test="count(incoterm) > 0">
			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:choose>
						<xsl:when test="$isSubSubItem = 'Y'">
							<xsl:call-template name="sub_subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_INCO_TERMS_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="$isSubItem = 'Y'">
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_INCO_TERMS_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_INCO_TERMS_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
	
			<xsl:call-template name="table_2_columns_template">
				<xsl:with-param name="text">
					<xsl:call-template name="table_cell_2_columns">
						<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_INCO_TERMS_CODE')"/></xsl:with-param>
						<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
						<xsl:with-param name="column_1_text_font_weight"/>
						<xsl:with-param name="column_1_text_align">center</xsl:with-param>
						<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_INCO_TERMS_LOCATION')"/></xsl:with-param>
						<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
						<xsl:with-param name="column_2_text_font_weight"/>
						<xsl:with-param name="column_2_text_align">center</xsl:with-param>
					</xsl:call-template>
					<!-- Display each incoterm -->
					<xsl:apply-templates select="incoterm"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<!-- Incoterm template -->
	<xsl:template match="incoterm">
		<!-- Set the value of incoterm -->
		<xsl:variable name="inco_term_code">
			<xsl:choose>
				<xsl:when test="code != ''">
					<xsl:value-of select="localization:getDecode($language, 'N212', code)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="other"/>
				</xsl:otherwise>						
			</xsl:choose>			
		</xsl:variable>

		<xsl:call-template name="table_cell_2_columns">
			<xsl:with-param name="column_1_text"><xsl:value-of select="$inco_term_code"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
			<xsl:with-param name="column_2_text_align">center</xsl:with-param>
			<xsl:with-param name="column_2_text"><xsl:value-of select="location"/></xsl:with-param>
			<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
			<xsl:with-param name="column_2_text_align">left</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	
	
	<!-- Routing summaries template (Header)-->
	<xsl:template match="routing_summaries">
		<xsl:if test="count(routing_summary) > 0">	
		   <xsl:call-template name="table_template">
		      <xsl:with-param name="text">
		        <xsl:call-template name="title"> 
		        <xsl:with-param name="text">
		        <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ROUTING_SUMMARY_DETAILS')" />
		        </xsl:with-param> 
		        </xsl:call-template>
		      </xsl:with-param>
		    </xsl:call-template>  
		       
		
		
		<xsl:if test="transport_type != ''"> 
		    <xsl:call-template name="table_cell"> 
		        <xsl:with-param name="left_text">
                     <xsl:value-of select="localization:getGTPString($language, 'XSL_PO_ROUTING_SUMMARY_TRANSPORT_TYPE')"/>
                </xsl:with-param> 
                <xsl:with-param name="right_text">
                    <xsl:choose>
					<xsl:when test="count(routing_summary/transport_type[. = '01']) != 0">
					<xsl:value-of select="localization:getDecode($language, 'N213', '01')"/>
					</xsl:when>
					<xsl:when test="count(routing_summary/transport_type[. = '02']) != 0">
					<xsl:value-of select="localization:getDecode($language, 'N213', '02')"/>
					</xsl:when>
				</xsl:choose> 
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
                    
                 
                        
				<!-- Individual mode air-->
				<xsl:if test="count(routing_summary[transport_mode='01' and transport_type='01']) > 0">
					<xsl:call-template name="spacer_template"/> 
					    <xsl:call-template name="table_template"> 
					        <xsl:with-param name="text"> 
					            <xsl:call-template name="subtitle"> 
					                 <xsl:with-param name="text">
				                         <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_AIR')" />
					                 </xsl:with-param> 
					            </xsl:call-template>
					        </xsl:with-param>
					    </xsl:call-template>		
											
					<!-- Display each group of transport by air -->
					<xsl:for-each select="routing_summary[transport_mode='01' and transport_type='01']">
						<xsl:variable name="currentTransportGroup"><xsl:value-of select="transport_group"/></xsl:variable>
							<xsl:if test="count(preceding-sibling::routing_summary[transport_mode='01' and transport_type='01' and transport_group = $currentTransportGroup]) = 0">				
									<xsl:call-template name="table_2_columns_template">
										<xsl:with-param name="text">
											<xsl:call-template name="table_cell_2_columns">
												<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_SUB_TYPE')"/></xsl:with-param>
												<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
												<xsl:with-param name="column_1_text_font_weight"/>
												<xsl:with-param name="column_1_text_align">center</xsl:with-param>
												<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_AIRPORT')"/></xsl:with-param>
												<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
												<xsl:with-param name="column_2_text_font_weight"/>
												<xsl:with-param name="column_2_text_align">center</xsl:with-param>
											</xsl:call-template>
											<!-- Display each airport of the group -->
											<xsl:apply-templates select="../routing_summary[transport_mode='01' and transport_type='01' and transport_group = $currentTransportGroup]"/>
										</xsl:with-param>
									</xsl:call-template>
			  			</xsl:if>
			  		</xsl:for-each>	
			  	</xsl:if>	

				<!-- Individual mode sea-->
				<xsl:if test="count(routing_summary[transport_mode='02' and transport_type='01']) > 0">
					<xsl:call-template name="spacer_template"/> 
					    <xsl:call-template name="table_template"> 
					        <xsl:with-param name="text"> 
					            <xsl:call-template name="subtitle"> 
					                 <xsl:with-param name="text">
				                         <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_SEA')" />
					                 </xsl:with-param> 
					            </xsl:call-template>
					        </xsl:with-param>
					    </xsl:call-template>		
											
					<!-- Display each group of transport by sea -->
					<xsl:for-each select="routing_summary[transport_mode='02' and transport_type='01']">
							<xsl:variable name="currentTransportGroup"><xsl:value-of select="transport_group"/></xsl:variable>
								<xsl:if test="count(preceding-sibling::routing_summary[transport_mode='02' and transport_type='01' and transport_group = $currentTransportGroup]) = 0">					               				
									<xsl:call-template name="table_2_columns_template">
										<xsl:with-param name="text">
											<xsl:call-template name="table_cell_2_columns">
												<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_SUB_TYPE')"/></xsl:with-param>
												<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
												<xsl:with-param name="column_1_text_font_weight"/>
												<xsl:with-param name="column_1_text_align">center</xsl:with-param>
												<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_PORT')"/></xsl:with-param>
												<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
												<xsl:with-param name="column_2_text_font_weight"/>
												<xsl:with-param name="column_2_text_align">center</xsl:with-param>
											</xsl:call-template>
											<!-- Display each port of the group -->
											<xsl:apply-templates select="../routing_summary[transport_mode='02' and transport_type='01' and transport_group = $currentTransportGroup]"/>
										</xsl:with-param>
								</xsl:call-template>
			  			</xsl:if>
			  		</xsl:for-each> 
			  	</xsl:if>				
				
				<!-- Individual mode road-->
				<xsl:if test="count(routing_summary[transport_mode='03' and transport_type='01']) > 0">
					<xsl:call-template name="spacer_template"/> 
					    <xsl:call-template name="table_template"> 
					        <xsl:with-param name="text"> 
					            <xsl:call-template name="subtitle"> 
					                 <xsl:with-param name="text">
				                         <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD')" />
					                 </xsl:with-param> 
					            </xsl:call-template>
					        </xsl:with-param>
					    </xsl:call-template>		
											
					<!-- Display each group of transport by road -->
					<xsl:for-each select="routing_summary[transport_mode='03' and transport_type='01']">
								<xsl:variable name="currentTransportGroup"><xsl:value-of select="transport_group"/></xsl:variable>
									<xsl:if test="count(preceding-sibling::routing_summary[transport_mode='03' and transport_type='01' and transport_group = $currentTransportGroup]) = 0">            				
									<xsl:call-template name="table_2_columns_template">
										<xsl:with-param name="text">
											<xsl:call-template name="table_cell_2_columns">
												<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_SUB_TYPE')"/></xsl:with-param>
												<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
												<xsl:with-param name="column_1_text_font_weight"/>
												<xsl:with-param name="column_1_text_align">center</xsl:with-param>
												<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_ROAD_PLACE')"/></xsl:with-param>
												<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
												<xsl:with-param name="column_2_text_font_weight"/>
												<xsl:with-param name="column_2_text_align">center</xsl:with-param>
											</xsl:call-template>
											<!-- Display each road place of the group -->
											<xsl:apply-templates select="../routing_summary[transport_mode='03' and transport_type='01' and transport_group = $currentTransportGroup]"/>
										</xsl:with-param>
									</xsl:call-template>
			  			</xsl:if>
			  		</xsl:for-each>	 
			  	</xsl:if>
				
				<!-- Individual mode rail-->
				<xsl:if test="count(routing_summary[transport_mode='04' and transport_type='01']) > 0">
					<xsl:call-template name="spacer_template"/> 
					    <xsl:call-template name="table_template"> 
					        <xsl:with-param name="text"> 
					            <xsl:call-template name="subtitle"> 
					                 <xsl:with-param name="text">
				                         <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL')" />
					                 </xsl:with-param> 
					            </xsl:call-template>
					        </xsl:with-param>
					    </xsl:call-template>		
											
					<!-- Display each group of transport by rail -->
					<xsl:for-each select="routing_summary[transport_mode='04' and transport_type='01']">
							<xsl:variable name="currentTransportGroup"><xsl:value-of select="transport_group"/></xsl:variable>
								<xsl:if test="count(preceding-sibling::routing_summary[transport_mode='04' and transport_type='01' and transport_group = $currentTransportGroup]) = 0">		
									<xsl:call-template name="table_2_columns_template">
										<xsl:with-param name="text">
											<xsl:call-template name="table_cell_2_columns">
												<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_SUB_TYPE')"/></xsl:with-param>
												<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
												<xsl:with-param name="column_1_text_font_weight"/>
												<xsl:with-param name="column_1_text_align">center</xsl:with-param>
												<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_RAIL_PLACE')"/></xsl:with-param>
												<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
												<xsl:with-param name="column_2_text_font_weight"/>
												<xsl:with-param name="column_2_text_align">center</xsl:with-param>
											</xsl:call-template>
											<!-- Display each rail place of the group -->
											<xsl:apply-templates select="../routing_summary[transport_mode='04' and transport_type='01' and transport_group = $currentTransportGroup]"/>
										</xsl:with-param>
									</xsl:call-template>
			  			</xsl:if>
			  		</xsl:for-each>	
			  	</xsl:if>
				
				
			<!-- Multimodal mode -->
				<!-- Airports -->
				<xsl:if test="count(routing_summary[transport_mode='01' and transport_type='02']) > 0">
					<xsl:call-template name="spacer_template"/> 
					    <xsl:call-template name="table_template"> 
					        <xsl:with-param name="text"> 
					            <xsl:call-template name="subtitle"> 
					                 <xsl:with-param name="text">
				                         <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_AIRPORT')" />
					                 </xsl:with-param> 
					            </xsl:call-template>
					        </xsl:with-param>
					    </xsl:call-template>					               				
							<xsl:call-template name="table_2_columns_template">
								<xsl:with-param name="text">
									<xsl:call-template name="table_cell_2_columns">
										<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_SUB_TYPE')"/></xsl:with-param>
										<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
										<xsl:with-param name="column_1_text_font_weight"/>
										<xsl:with-param name="column_1_text_align">center</xsl:with-param>
										<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_AIRPORT')"/></xsl:with-param>
										<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
										<xsl:with-param name="column_2_text_font_weight"/>
										<xsl:with-param name="column_2_text_align">center</xsl:with-param>
									</xsl:call-template>
										<!-- Display each airports -->
									<xsl:apply-templates select="routing_summary[transport_mode='01' and transport_type='02']"/>
								</xsl:with-param>
							</xsl:call-template>	
			  	</xsl:if>
				
				<!-- Ports -->
				<xsl:if test="count(routing_summary[transport_mode='02' and transport_type='02']) > 0">
					<xsl:call-template name="spacer_template"/> 
					    <xsl:call-template name="table_template"> 
					        <xsl:with-param name="text"> 
					            <xsl:call-template name="subtitle"> 
					                 <xsl:with-param name="text">
				                         <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_PORT')" />
					                 </xsl:with-param> 
					            </xsl:call-template>
					        </xsl:with-param>
					    </xsl:call-template>					               				
							<xsl:call-template name="table_2_columns_template">
								<xsl:with-param name="text">
									<xsl:call-template name="table_cell_2_columns">
										<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_SUB_TYPE')"/></xsl:with-param>
										<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
										<xsl:with-param name="column_1_text_font_weight"/>
										<xsl:with-param name="column_1_text_align">center</xsl:with-param>
										<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_PORT')"/></xsl:with-param>
										<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
										<xsl:with-param name="column_2_text_font_weight"/>
										<xsl:with-param name="column_2_text_align">center</xsl:with-param>
									</xsl:call-template>
										<!-- Display each port -->
									<xsl:apply-templates select="routing_summary[transport_mode='02' and transport_type='02']"/>
								</xsl:with-param>
							</xsl:call-template>	
			  	</xsl:if>
				
				<!-- Places -->
				<xsl:if test="count(routing_summary[transport_mode='' and transport_type='02' and taking_in_charge ='' and place_final_dest='']) > 0">
					<xsl:call-template name="spacer_template"/> 
					    <xsl:call-template name="table_template"> 
					        <xsl:with-param name="text"> 
					            <xsl:call-template name="subtitle"> 
					                 <xsl:with-param name="text">
				                         <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_PLACE')" />
					                 </xsl:with-param> 
					            </xsl:call-template>
					        </xsl:with-param>
					    </xsl:call-template>					               				
							<xsl:call-template name="table_2_columns_template">
								<xsl:with-param name="text">
									<xsl:call-template name="table_cell_2_columns">
										<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_SUB_TYPE')"/></xsl:with-param>
										<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
										<xsl:with-param name="column_1_text_font_weight"/>
										<xsl:with-param name="column_1_text_align">center</xsl:with-param>
										<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_PLACE')"/></xsl:with-param>
										<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
										<xsl:with-param name="column_2_text_font_weight"/>
										<xsl:with-param name="column_2_text_align">center</xsl:with-param>
									</xsl:call-template>
										<!-- Display each port -->
									<xsl:apply-templates select="routing_summary[transport_mode='' and transport_type='02' and taking_in_charge ='' and place_final_dest='']"/>
								</xsl:with-param>
							</xsl:call-template>	
			  	</xsl:if>
				
				<!-- Taking in charge -->
				<xsl:if test="count(routing_summary[transport_type='02' and taking_in_charge !='']) > 0">
					<xsl:call-template name="spacer_template"/> 
					    <xsl:call-template name="table_template"> 
					        <xsl:with-param name="text"> 
					            <xsl:call-template name="subtitle"> 
					                 <xsl:with-param name="text">
				                         <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TAKING_IN_CHARGE')" />
					                 </xsl:with-param> 
					            </xsl:call-template>
					        </xsl:with-param>
					    </xsl:call-template>					               				
							<xsl:call-template name="table_2_columns_template">
								<xsl:with-param name="text">
									<xsl:call-template name="table_cell_2_columns">
										<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TAKING_IN_CHARGE')"/></xsl:with-param>
										<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
										<xsl:with-param name="column_1_text_font_weight"/>
										<xsl:with-param name="column_1_text_align">center</xsl:with-param>
										<xsl:with-param name="column_2_text"></xsl:with-param>
										<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
										<xsl:with-param name="column_2_text_font_weight"/>
										<xsl:with-param name="column_2_text_align">center</xsl:with-param>
									</xsl:call-template>
										<!-- Display each taking in charge -->
									<xsl:apply-templates select="routing_summary[transport_type='02' and taking_in_charge !='']"/>
								</xsl:with-param>
							</xsl:call-template>	
			  	</xsl:if>
				
				<!-- Place of Final Destination -->
				<xsl:if test="count(routing_summary[transport_type='02' and place_final_dest !='']) > 0">
					<xsl:call-template name="spacer_template"/> 
					    <xsl:call-template name="table_template"> 
					        <xsl:with-param name="text"> 
					            <xsl:call-template name="subtitle"> 
					                 <xsl:with-param name="text">
				                         <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_PLACE_FINAL_DEST')" />
					                 </xsl:with-param> 
					            </xsl:call-template>
					        </xsl:with-param>
					    </xsl:call-template>					               				
							<xsl:call-template name="table_2_columns_template">
								<xsl:with-param name="text">
									<xsl:call-template name="table_cell_2_columns">
										<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_PLACE_FINAL_DEST')"/></xsl:with-param>
										<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
										<xsl:with-param name="column_1_text_font_weight"/>
										<xsl:with-param name="column_1_text_align">center</xsl:with-param>
										<xsl:with-param name="column_2_text"></xsl:with-param>
										<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
										<xsl:with-param name="column_2_text_font_weight"/>
										<xsl:with-param name="column_2_text_align">center</xsl:with-param>
									</xsl:call-template>
										<!-- Display each place of final destination -->
									<xsl:apply-templates select="routing_summary[transport_type='02' and place_final_dest !='']"/>
								</xsl:with-param>
							</xsl:call-template>	
			  	</xsl:if>
		</xsl:if>										
	</xsl:template>
	
	<!-- Airport Details template -->
	<xsl:template match="routing_summary[transport_mode='01']">
		<xsl:variable name="transportSubType"><xsl:value-of select="transport_sub_type"/></xsl:variable>
		
		<xsl:variable name="airportCode">
			<xsl:choose>
				<xsl:when test="$transportSubType = '01'">	
					<xsl:value-of select="airport_loading_code"/>			
				</xsl:when>
				<xsl:when test="$transportSubType = '02'">
					<xsl:value-of select="airport_discharge_code"/>
				</xsl:when>
			</xsl:choose>				
		</xsl:variable>
		
		<xsl:variable name="airportName">
			<xsl:choose>
				<xsl:when test="$transportSubType = '01'">	
					<xsl:value-of select="airport_loading_name"/>			
				</xsl:when>
				<xsl:when test="$transportSubType = '02'">
					<xsl:value-of select="airport_discharge_name"/>
				</xsl:when>
			</xsl:choose>			
		</xsl:variable>

		<xsl:variable name="town">
			<xsl:choose>
				<xsl:when test="$transportSubType = '01'">	
					<xsl:value-of select="town_loading"/>			
				</xsl:when>
				<xsl:when test="$transportSubType = '02'">
					<xsl:value-of select="town_discharge"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="decodedAirportName">
			<xsl:if test="$airportName != ''">
				(<xsl:value-of select="$airportName"/>)
			</xsl:if>
		</xsl:variable>
		
		<xsl:variable name="airportIdentifier">
			<xsl:choose>
				<xsl:when test="$airportName != ''">
					<xsl:value-of select="$airportName"/>
				</xsl:when>
				<xsl:when test="$airportCode != '' ">
					<xsl:value-of select="$airportCode"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>		
		<fo:table-row keep-with-previous="always">
			<!-- <fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> -->
			<fo:table-cell><fo:block><xsl:value-of select="localization:getDecode($language, 'N215', $transportSubType)"/></fo:block></fo:table-cell>
			<fo:table-cell>
			<fo:block>
				<xsl:if test="$airportCode!=''" >
					<xsl:value-of select="$airportCode"/>
				</xsl:if>	
				<xsl:if test="$town!=''" >
					<xsl:value-of select="$town"/>
				</xsl:if>			
				<xsl:if test="$decodedAirportName!=''" >
					<xsl:value-of select="$decodedAirportName"/>
				</xsl:if>
			</fo:block>
			</fo:table-cell>
		</fo:table-row>	
	</xsl:template>
	
	<!-- Port Details template -->
	<xsl:template match="routing_summary[transport_mode='02']">
		<xsl:variable name="transportSubType"><xsl:value-of select="transport_sub_type"/></xsl:variable>

		<xsl:variable name="port">
			<xsl:choose>
				<xsl:when test="$transportSubType = '01'">
					<xsl:value-of select="port_loading"/>				
				</xsl:when>
				<xsl:when test="$transportSubType = '02'">
					<xsl:value-of select="port_discharge"/>				
				</xsl:when>					
			</xsl:choose>
		</xsl:variable>	
			
		<fo:table-row keep-with-previous="always">
			<!-- <fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> -->
			<fo:table-cell><fo:block><xsl:value-of select="localization:getDecode($language, 'N215', $transportSubType)"/></fo:block></fo:table-cell>
			<fo:table-cell>
			<fo:block>
				<xsl:value-of select="$port"/>
			</fo:block>
			</fo:table-cell>
		</fo:table-row>	
	</xsl:template>	
	
	<!-- Place Details template -->
	<xsl:template match="routing_summary[transport_mode='03' or transport_mode='04'] | routing_summary[transport_mode='' and transport_type='02' and taking_in_charge ='' and place_final_dest='']">
		<xsl:variable name="transportSubType"><xsl:value-of select="transport_sub_type"/></xsl:variable>

		<xsl:variable name="place">
			<xsl:choose>
				<xsl:when test="$transportSubType = '01'">
					<xsl:value-of select="place_receipt"/>	
				</xsl:when>
				<xsl:when test="$transportSubType = '02'">
					<xsl:value-of select="place_delivery"/>
				</xsl:when>
			</xsl:choose>				
		</xsl:variable>	
			
		<fo:table-row keep-with-previous="always">
			<!-- <fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> -->
			<fo:table-cell><fo:block><xsl:value-of select="localization:getDecode($language, 'N215', $transportSubType)"/></fo:block></fo:table-cell>
			<fo:table-cell>
			<fo:block>
				<xsl:value-of select="$place"/>
			</fo:block>
			</fo:table-cell>
		</fo:table-row>	
	</xsl:template>
	
	<!-- Taking in Charge Details template -->
	<xsl:template match="routing_summary[transport_type='02' and taking_in_charge !='']">
		<fo:table-row keep-with-previous="always">
			<!-- <fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> -->
			<fo:table-cell>
			<fo:block>
				<xsl:value-of select="taking_in_charge"/>
			</fo:block>
			</fo:table-cell>
		</fo:table-row>	
	</xsl:template>	
	
	<!-- Place Of Final Destination Details template -->
	<xsl:template match="routing_summary[transport_type='02' and place_final_dest !='']">
		<fo:table-row>
			<!-- <fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> -->
			<fo:table-cell>
			<fo:block>
				<xsl:value-of select="place_final_dest"/>
			</fo:block>
			</fo:table-cell>
		</fo:table-row>	
	</xsl:template>		
	
	<!-- Users Informations Details template -->
	<xsl:template match="user_defined_informations">
		<!-- Users Informations -->
		<xsl:if test="count(user_defined_information) > 0">

			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_USER_INFORMATION_DETAILS')" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
	
			<!-- Buyers Informations -->
			<xsl:if test="count(user_defined_information[type = '01']) > 0">
			
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_BUYER_INFORMATIONS')" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="table_2_columns_template">
					<xsl:with-param name="text">
						<xsl:call-template name="table_cell_2_columns">
							<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_USER_INFORMATION_LABEL')"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_weight"/>
							<xsl:with-param name="column_1_text_align">center</xsl:with-param>
							<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_USER_INFORMATION_INFORMATION')"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_weight"/>
							<xsl:with-param name="column_2_text_align">center</xsl:with-param>
						</xsl:call-template>
						<!-- Display each incoterm -->
						<xsl:apply-templates select="user_defined_information[type = '01']"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<!-- Sellers Informations -->
			<xsl:if test="count(user_defined_information[type = '02']) > 0">

				<xsl:call-template name="spacer_template"/>
				
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_SELLER_INFORMATIONS')" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="table_2_columns_template">
					<xsl:with-param name="text">
						<xsl:call-template name="table_cell_2_columns">
							<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_USER_INFORMATION_LABEL')"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_weight"/>
							<xsl:with-param name="column_1_text_align">center</xsl:with-param>
							<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_USER_INFORMATION_INFORMATION')"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_weight"/>
							<xsl:with-param name="column_2_text_align">center</xsl:with-param>
						</xsl:call-template>
						<!-- Display each incoterm -->
						<xsl:apply-templates select="user_defined_information[type = '02']"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

		</xsl:if>
	</xsl:template>
	
	<!-- User Informations template -->
	<xsl:template match="user_defined_information[type = '01' or type = '02' ]">
		<xsl:call-template name="table_cell_2_columns">
			<xsl:with-param name="column_1_text"><xsl:value-of select="label"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
			<xsl:with-param name="column_2_text_align">left</xsl:with-param>
			<xsl:with-param name="column_2_text"><xsl:value-of select="information"/></xsl:with-param>
			<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
			<xsl:with-param name="column_2_text_align">left</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Contacts template (Header) -->
	<xsl:template match="contacts">
		<xsl:if test="count(contact) > 0">
			
			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONTACT_PERSON_DETAILS')" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
	
			<xsl:call-template name="table_2_columns_template">
				<xsl:with-param name="text">
					<xsl:call-template name="table_cell_2_columns">
						<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_CONTACT_PERSON_TYPE')"/></xsl:with-param>
						<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
						<xsl:with-param name="column_1_text_font_weight"/>
						<xsl:with-param name="column_1_text_align">center</xsl:with-param>
						<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_CONTACT_PERSON_ROLE')"/></xsl:with-param>
						<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
						<xsl:with-param name="column_2_text_font_weight"/>
						<xsl:with-param name="column_2_text_align">center</xsl:with-param>
					</xsl:call-template>
					<!-- Display each contact -->
					<xsl:apply-templates select="contact"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>    		
	</xsl:template>
	
	<!-- Contact template -->
	<xsl:template match="contact">		
		<xsl:call-template name="table_cell_2_columns">
			<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getDecode($language, 'N200', type)"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
			<xsl:with-param name="column_2_text_align">center</xsl:with-param>
			<xsl:with-param name="column_2_text">
				<xsl:value-of select="localization:getDecode($language, 'N204', name_prefix)"/>&nbsp;
				<xsl:call-template name="zero_width_space_1">
					<xsl:with-param name="data" select="name"/>
				</xsl:call-template>
			</xsl:with-param>
			<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
			<xsl:with-param name="column_2_text_align">left</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Line items template -->
	<xsl:template match="line_items">
	<!-- <fo:block keep-together="always">
			<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
				<fo:table-column column-width="{$labelColumnWidth}"/>
                    <fo:table-column column-width="{$detailsColumnWidth}"/>		
				<fo:table-header>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="2">
							<fo:block margin="10.0pt"	background-color="{$backgroundSubtitles}" color="{$fontColorTitles}" start-indent="20.0pt"
								end-indent="20.0pt" font-weight="bold" font-family="{$pdfFont}">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINE_ITEMS')" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<fo:table-body>-->
	        		<!-- Display each line item -->
					<xsl:apply-templates select="lt_tnx_record"/>
				<!-- </fo:table-body>
			</fo:table>
		</fo:block>-->
	</xsl:template>	

	<!-- Line item Details template -->
	<xsl:template match="lt_tnx_record">
	
		<xsl:variable name="product_decode">
			<xsl:choose>
				<xsl:when test="product_name[. !='']">
					<xsl:value-of select="product_name"/>
				</xsl:when>
				<!--xsl:otherwise>
					<xsl:value-of select=""/> identifiers, categories, ...
				</xsl:otherwise-->						
			</xsl:choose>			
		</xsl:variable>	
		
		<xsl:variable name="quantity_decode">
			<xsl:if test="qty_val[. != '']">
				<xsl:choose>
					<xsl:when test="qty_unit_measr_code[. !='']">
						<xsl:value-of select="qty_val[.!= '']"/>&nbsp;<xsl:value-of select="localization:getDecode($language, 'N202', qty_unit_measr_code[.])"/>
					</xsl:when>
					<xsl:when test="qty_other_unit_measr[.!='']">
						<xsl:value-of select="qty_val[.!= '']"/>&nbsp;<xsl:value-of select="qty_other_unit_measr"/>
					</xsl:when>
					<xsl:otherwise/>						
				</xsl:choose>
			</xsl:if>			
		</xsl:variable>	
		
		<xsl:variable name="price_decode">
			<xsl:if test="price_val[. != '']">
				<xsl:choose>
					<xsl:when test="price_measr_code[. !='']">
						<xsl:value-of select="price_val[.!= '']"/>&nbsp;<xsl:value-of select="localization:getDecode($language, 'N202', price_unit_measr_code[.])"/>
					</xsl:when>
					<xsl:when test="price_unit_measr[.!='']">
						<xsl:value-of select="price_val[.!= '']"/>&nbsp;<xsl:value-of select="price_other_unit_measr"/>
					</xsl:when>
					<xsl:otherwise/>						
				</xsl:choose>
			</xsl:if>			
		</xsl:variable>
		

		<!-- Line Item -->
		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="subtitle">
					<xsl:with-param name="text">
						<xsl:choose>
							<xsl:when test="cust_ref_id[.!='']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_LINE_ITEMS_NUMBER')" />&nbsp;<xsl:value-of select="cust_ref_id"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_LINE_ITEMS_NUMBER')" />&nbsp;<xsl:value-of select="line_item_number"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>

		<!-- Product details -->
		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="sub_subtitle">
					<xsl:with-param name="text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINE_ITEMS_PRODUCT')" />
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_DETAILS_LINE_ITEMS_PRODUCT_NAME')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:call-template name="zero_width_space_1">
									<xsl:with-param name="data" select="product_name"/>
								</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="product_orgn !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_LINE_ITEMS_PRODUCT_ORIGIN')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="product_orgn" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>

		<!-- Product identifiers -->
		<xsl:if test="count(product_identifiers/product_identifier) != 0">
			<xsl:apply-templates select="product_identifiers"/>
		</xsl:if>
		
		<!-- Product characteristics -->
		<xsl:if test="count(product_characteristics/product_characteristic) != 0">
			<xsl:apply-templates select="product_characteristics"/>
		</xsl:if>

		<!-- Product categories -->
		<xsl:if test="count(product_categories/product_category) != 0">
			<xsl:apply-templates select="product_categories"/>
		</xsl:if>

		
		<!-- Product details -->
		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="sub_subtitle">
					<xsl:with-param name="text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINE_ITEMS_QUANTITY')" />
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_DETAILS_LINE_ITEMS_QUANTITY_CODE')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="qty_unit_measr_code[.!='']"><xsl:value-of select="localization:getDecode($language, 'N202', qty_unit_measr_code)"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="qty_other_unit_measr"/></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_LINE_ITEMS_QUANTITY_VALUE')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="qty_val" />
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="qty_factor != ''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_LINE_ITEMS_QUANTITY_FACTOR')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="qty_factor" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="qty_tol_pstv_pct != ''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_LINE_ITEMS_PRICE_TOLERANCE_POS')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="qty_tol_pstv_pct" />%
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="qty_tol_neg_pct != ''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_LINE_ITEMS_PRICE_TOLERANCE_NEG')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="qty_tol_neg_pct" />%
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>


		<!-- Price details -->
		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="sub_subtitle">
					<xsl:with-param name="text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINE_ITEMS_PRICE')" />
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_DETAILS_LINE_ITEMS_PRICE_CODE')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="price_unit_measr_code[.!='']"><xsl:value-of select="localization:getDecode($language, 'N202', price_unit_measr_code)"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="price_other_unit_measr"/></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_DETAILS_LINE_ITEMS_PRICE_VALUE')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="price_cur_code"/>&nbsp;<xsl:value-of select="price_amt"/>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="price_factor != ''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_LINE_ITEMS_PRICE_FACTOR')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="price_factor"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="price_tol_pstv_pct != ''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_LINE_ITEMS_PRICE_TOLERANCE_POS')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="price_tol_pstv_pct"/>%
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="price_tol_neg_pct != ''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_LINE_ITEMS_PRICE_TOLERANCE_NEG')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="price_tol_neg_pct"/>%
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_DETAILS_PO_LINE_ITEM_AMT')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="total_cur_code"/>&nbsp;<xsl:value-of select="total_amt"/>
					</xsl:with-param>
				</xsl:call-template>
  			</xsl:with-param>
  		</xsl:call-template>              
        
		<!-- Line item adjustments -->
		<xsl:if test="count(adjustments/allowance) != 0">
			<xsl:apply-templates select="adjustments" mode="line-item">
				<xsl:with-param name="isSubSubItem">Y</xsl:with-param>
			</xsl:apply-templates>
		</xsl:if>
		
		<!-- Line item taxes -->
		<xsl:if test="count(taxes/allowance) != 0">
			<xsl:apply-templates select="taxes" mode="line-item">
				<xsl:with-param name="isSubSubItem">Y</xsl:with-param>
			</xsl:apply-templates>
		</xsl:if>

		<!-- Line item freight charges -->
		<xsl:if test="count(freight_charges/allowance) != 0">
			<xsl:apply-templates select="freight_charges" mode="line-item">
				<xsl:with-param name="isSubSubItem">Y</xsl:with-param>
			</xsl:apply-templates>
		</xsl:if>
        
		<!-- Line item Shipment details -->
		<xsl:if test="last_ship_date != ''">
			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="sub_subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SHIPMENT_DETAILS')" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="earliest_ship_date != ''">
 					<xsl:call-template name="table_cell">
 						<xsl:with-param name="left_text">
 							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_EARLIEST_SHIP_DATE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="earliest_ship_date"/>
						</xsl:with-param>
					</xsl:call-template>	
					</xsl:if>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_LAST_SHIP_DATE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="last_ship_date"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
        
		<!-- Line item incoterms -->
		<xsl:if test="count(incoterms/incoterm) != 0">
			<xsl:apply-templates select="incoterms">
				<xsl:with-param name="isSubSubItem">Y</xsl:with-param>
			</xsl:apply-templates>
		</xsl:if>
		
		<!-- Routing Summary details -->
		<xsl:if test="routing_summaries/air_routing_summaries/rs_tnx_record or routing_summaries/sea_routing_summaries/rs_tnx_record or routing_summaries/rail_routing_summaries/rs_tnx_record or routing_summaries/road_routing_summaries/rs_tnx_record">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ROUTING_SUMMARY_IND_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:apply-templates select="routing_summaries/air_routing_summaries/rs_tnx_record | routing_summaries/sea_routing_summaries/rs_tnx_record | routing_summaries/rail_routing_summaries/rs_tnx_record | routing_summaries/road_routing_summaries/rs_tnx_record">
				<xsl:with-param name="subItem">Y</xsl:with-param>
			</xsl:apply-templates>
		</xsl:if>
		<xsl:if test="routing_summaries/rs_tnx_record">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ROUTING_SUMMARY_MULTIMODAL_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:apply-templates select="routing_summaries/rs_tnx_record">
				<xsl:with-param name="subItem">Y</xsl:with-param>
			</xsl:apply-templates>
		</xsl:if>
		<fo:block break-after="page"/>
	</xsl:template>
	
	<!--********************************-->
	<!-- PO Product Identifiers Details -->
	<!--********************************-->
	<xsl:template match="product_identifiers">

		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="sub_subtitle">
					<xsl:with-param name="text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINE_ITEMS_PRODUCT_IDENTIFIERS')" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="table_2_columns_template">
			<xsl:with-param name="text">
				<xsl:call-template name="table_cell_2_columns">
					<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PRODUCT_IDENTIFIER_CODE')"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_weight"/>
					<xsl:with-param name="column_1_text_align">center</xsl:with-param>
					<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PRODUCT_IDENTIFIER_DESCRIPTION')"/></xsl:with-param>
					<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
					<xsl:with-param name="column_2_text_font_weight"/>
					<xsl:with-param name="column_2_text_align">center</xsl:with-param>
				</xsl:call-template>
				<!-- Display each incoterm -->
				<xsl:apply-templates select="product_identifier"/>
			</xsl:with-param>
		</xsl:call-template>
		
	</xsl:template>


	<xsl:template match="product_identifier">
		<!-- Set the value of product_identifier -->
		<xsl:variable name="product_identifier_type">
			<xsl:choose>
				<xsl:when test="type[. !='']">
					<xsl:value-of select="localization:getDecode($language, 'N220', type)"/>
				</xsl:when>
				<xsl:when test="other_type[. !='']">
					<xsl:value-of select="other_type"/>
				</xsl:when>
			</xsl:choose>       
		</xsl:variable>

		<xsl:call-template name="table_cell_2_columns">
			<xsl:with-param name="column_1_text"><xsl:value-of select="$product_identifier_type"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
			<xsl:with-param name="column_2_text_align">left</xsl:with-param>
			<xsl:with-param name="column_2_text"><xsl:value-of select="identifier"/></xsl:with-param>
			<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
			<xsl:with-param name="column_2_text_align">left</xsl:with-param>
		</xsl:call-template>

	</xsl:template>
	
	<xsl:template match="product_characteristics">

		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="sub_subtitle">
					<xsl:with-param name="text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINE_ITEMS_PRODUCT_CHARACTERISTICS')" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="table_2_columns_template">
			<xsl:with-param name="text">
				<xsl:call-template name="table_cell_2_columns">
					<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PRODUCT_CHARACTERISTIC_CODE')"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_weight"/>
					<xsl:with-param name="column_1_text_align">center</xsl:with-param>
					<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PRODUCT_CHARACTERISTIC_DESCRIPTION')"/></xsl:with-param>
					<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
					<xsl:with-param name="column_2_text_font_weight"/>
					<xsl:with-param name="column_2_text_align">center</xsl:with-param>
				</xsl:call-template>
				<!-- Display each incoterm -->
				<xsl:apply-templates select="product_characteristic"/>
			</xsl:with-param>
		</xsl:call-template>

	</xsl:template>
  
	<xsl:template match="product_characteristic">
		<!-- Set the value of product_characteristic -->
		<xsl:variable name="product_characteristic_type">
			<xsl:choose>
				<xsl:when test="type[. !='']">
					<xsl:value-of select="localization:getDecode($language, 'N222', type[.])"/>
				</xsl:when>
				<xsl:when test="other_type[. !='']">
					<xsl:value-of select="other_type"/>
				</xsl:when>
				<xsl:otherwise/>		
			</xsl:choose>				
		</xsl:variable>	
		
		<xsl:call-template name="table_cell_2_columns">
			<xsl:with-param name="column_1_text"><xsl:value-of select="$product_characteristic_type"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
			<xsl:with-param name="column_2_text_align">left</xsl:with-param>
			<xsl:with-param name="column_2_text"><xsl:value-of select="characteristic"/></xsl:with-param>
			<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
			<xsl:with-param name="column_2_text_align">left</xsl:with-param>
		</xsl:call-template>

	</xsl:template>
  
	<xsl:template match="product_categories">

		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="sub_subtitle">
					<xsl:with-param name="text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINE_ITEMS_PRODUCT_CATEGORIES')" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="table_2_columns_template">
			<xsl:with-param name="text">
				<xsl:call-template name="table_cell_2_columns">
					<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PRODUCT_CATEGORY_CODE')"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_weight"/>
					<xsl:with-param name="column_1_text_align">center</xsl:with-param>
					<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PRODUCT_CATEGORY_DESCRIPTION')"/></xsl:with-param>
					<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
					<xsl:with-param name="column_2_text_font_weight"/>
					<xsl:with-param name="column_2_text_align">center</xsl:with-param>
				</xsl:call-template>
				<!-- Display each incoterm -->
				<xsl:apply-templates select="product_category"/>
			</xsl:with-param>
		</xsl:call-template>

	</xsl:template>
  
	<xsl:template match="product_category">
		<!-- Set the value of product_category -->
		<xsl:variable name="product_category_type">
			<xsl:choose>
				<xsl:when test="type[. !='']">
					<xsl:value-of select="localization:getDecode($language, 'N221', type)"/>
				</xsl:when>
				<xsl:when test="other_type[. !='']">
					<xsl:value-of select="other_type"/>
				</xsl:when>
				<xsl:otherwise/>		
			</xsl:choose>				
		</xsl:variable>
		
		<xsl:call-template name="table_cell_2_columns">
			<xsl:with-param name="column_1_text"><xsl:value-of select="$product_category_type"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
			<xsl:with-param name="column_2_text_align">left</xsl:with-param>
			<xsl:with-param name="column_2_text"><xsl:value-of select="category"/></xsl:with-param>
			<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
			<xsl:with-param name="column_2_text_align">left</xsl:with-param>
		</xsl:call-template>

	</xsl:template>
	
	<xsl:template match="adjustments" mode="line-item">
	<xsl:param name="isSubItem">N</xsl:param>
	<xsl:param name="isSubSubItem">N</xsl:param>
		<xsl:if test="count(allowance) > 0">	
			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:choose>
						<xsl:when test="$isSubSubItem = 'Y'">
							<xsl:call-template name="sub_subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ADJUSTMENTS_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="$isSubItem = 'Y'">
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ADJUSTMENTS_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ADJUSTMENTS_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:choose>
				<xsl:when test="count(allowance[amt!='']) != 0 and count(allowance[rate!='']) = 0">
					<xsl:call-template name="table_3_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_CUR_CODE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
								<xsl:with-param name="column_3_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_AMOUNT')"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_weight"/>
								<xsl:with-param name="column_3_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each adjustment -->
							<xsl:apply-templates select="allowance[allowance_type='02']"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="count(allowance[rate!='']) != 0 and count(allowance[amt!='']) = 0">
					<xsl:call-template name="table_2_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_RATE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each adjustment -->
							<xsl:apply-templates select="allowance[allowance_type='02']"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="table_3_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_CUR_CODE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
								<xsl:with-param name="column_3_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_AMOUNT_OR_RATE')"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_weight"/>
								<xsl:with-param name="column_3_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each adjustment -->
							<xsl:apply-templates select="allowance[allowance_type='02']"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>		
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="taxes" mode="line-item">
		<xsl:param name="isSubItem">N</xsl:param>
		<xsl:param name="isSubSubItem">N</xsl:param>
	
		<xsl:if test="count(allowance) > 0">
		
			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:choose>
						<xsl:when test="$isSubSubItem = 'Y'">
							<xsl:call-template name="sub_subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TAXES_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="$isSubItem = 'Y'">
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TAXES_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TAXES_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
	
			<xsl:choose>
				<xsl:when test="count(allowance[amt!='']) != 0 and count(allowance[rate!='']) = 0">
					<xsl:call-template name="table_3_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_CUR_CODE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
								<xsl:with-param name="column_3_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_AMOUNT')"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_weight"/>
								<xsl:with-param name="column_3_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each tax -->
							<xsl:apply-templates select="allowance"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="count(allowance[rate!='']) != 0 and count(allowance[amt!='']) = 0">
					<xsl:call-template name="table_2_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_RATE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each adjustment -->
							<xsl:apply-templates select="allowance"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="table_3_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_CUR_CODE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
								<xsl:with-param name="column_3_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_AMOUNT_OR_RATE')"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_weight"/>
								<xsl:with-param name="column_3_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each tax -->
							<xsl:apply-templates select="allowance"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	<!--Line Item Freight Charges Details -->
	<xsl:template match="freight_charges" mode="line-item">
		<xsl:param name="isSubItem">N</xsl:param>
		<xsl:param name="isSubSubItem">N</xsl:param>
					
		<xsl:if test="count(allowance) > 0">
		
			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:choose>
						<xsl:when test="$isSubSubItem = 'Y'">
							<xsl:call-template name="sub_subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREIGHT_CHARGES_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="$isSubItem = 'Y'">
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREIGHT_CHARGES_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREIGHT_CHARGES_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>

			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_FREIGHT_CHARGES_TYPE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="../freight_charges_type[. = 'CLCT']">
									<xsl:value-of select="localization:getDecode($language, 'N211', 'CLCT')"/>
								</xsl:when>
								<xsl:when test="../freight_charges_type[. = 'PRPD']">
									<xsl:value-of select="localization:getDecode($language, 'N211', 'PRPD')"/>
								</xsl:when>
								<xsl:otherwise/>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>

			<xsl:call-template name="spacer_template"/>
				
			<xsl:choose>
				<xsl:when test="count(allowance[amt!='']) != 0 and count(allowance[rate!='']) = 0">
					<xsl:call-template name="table_3_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_CUR_CODE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
								<xsl:with-param name="column_3_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_AMOUNT')"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_weight"/>
								<xsl:with-param name="column_3_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each freight charge -->
							<xsl:apply-templates select="allowance"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="count(allowance[rate!='']) != 0 and count(allowance[amt!='']) = 0">
					<xsl:call-template name="table_2_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_RATE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each adjustment -->
							<xsl:apply-templates select="allowance"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="table_3_columns_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_TYPE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">center</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_CUR_CODE')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">center</xsl:with-param>
								<xsl:with-param name="column_3_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_AMOUNT_OR_RATE')"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_weight"/>
								<xsl:with-param name="column_3_text_align">center</xsl:with-param>
							</xsl:call-template>
							<!-- Display each freight charge -->
							<xsl:apply-templates select="allowance"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	<!-- <xsl:template match="bank_payment_obligation">
	<xsl:apply-templates select="PmtOblgtn"/>
	</xsl:template> -->
	
	<xsl:template match="bank_payment_obligation/PmtOblgtn">
		
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_OBLIGOR_BANK')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="./OblgrBk/BIC" />
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_RECIPIENT_BANK')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="./RcptBk/BIC" />
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="Amt !=''">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_LABEL_PAYMENT_OBLIGATION_AMOUNT')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="Amt" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="Pctg !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_LABEL_PAYMENT_OBLIGATION_PERCENT')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="Pctg" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="XpryDt !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_DATE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="XpryDt" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				
				<xsl:if test="AplblLaw !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_LABEL_APPLICABLE_LAW')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="AplblLaw" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				
				<xsl:if test="count(./PmtTerms) != 0 and ./PmtTerms != ''">
				<xsl:for-each select="PmtTerms">
					<xsl:call-template name="sub_subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PAYMENT_TERMS_DETAILS')" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="PmtCd/Cd !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_LABEL_PAYMENT_CODE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="PmtCd/Cd" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="PmtCd/NbOfDays !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_LABEL_NO_OF_DAYS')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="PmtCd/NbOfDays" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="OthrPmtTerms !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_LABEL_OTHER_PAYMENT_TERMS')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="OthrPmtTerms" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="Amt !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_PDF_PAYMENT_OBLIGATION_AMOUNT')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="Amt" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="Pctg !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_LABEL_PAYMENT_OBLIGATION_PERCENT')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="Pctg" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
				</xsl:for-each>
				</xsl:if>
				
				<xsl:if test="./SttlmTerms/CdtrAgt/BIC !='' or ./SttlmTerms/CdtrAgt/NmAndAdr/Nm !='' or ./SttlmTerms/CdtrAgt/NmAndAdr/Adr/StrtNm !='' or ./SttlmTerms/CdtrAgt/NmAndAdr/Adr/PstCdId !='' or ./SttlmTerms/CdtrAgt/NmAndAdr/Adr/TwnNm !='' or ./SttlmTerms/CdtrAgt/NmAndAdr/Adr/CtrySubDvsn !='' or ./SttlmTerms/CdtrAgt/NmAndAdr/Adr/Ctry !='' or ./SttlmTerms/CdtrAcct/Id/IBAN !='' or ./SttlmTerms/CdtrAcct/Id/Othr/Issr !='' or ./SttlmTerms/CdtrAcct/Id/Othr/Id !='' or ./SttlmTerms/CdtrAcct/Id/Othr/SchmeNm/Cd !='' or ./SttlmTerms/CdtrAcct/Id/Othr/SchmeNm/Prtry !='' or ./SttlmTerms/CdtrAcct/Tp/Cd !='' or ./SttlmTerms/CdtrAcct/Tp/Prtry !='' or ./SttlmTerms/CdtrAcct/Ccy !='' or ./SttlmTerms/CdtrAcct/Nm !=''">
					<xsl:call-template name="sub_subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SETTLEMENT_TERMS')" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="./SttlmTerms/CdtrAgt/BIC !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_PDF_CREDITOR_AGENT_BIC')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./SttlmTerms/CdtrAgt/BIC" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="./SttlmTerms/CdtrAgt/NmAndAdr/Nm !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_PDF_CREDITOR_AGENT_NAME')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./SttlmTerms/CdtrAgt/NmAndAdr/Nm" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="./SttlmTerms/CdtrAgt/NmAndAdr/Adr/StrtNm !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_PDF_CREDITOR_AGENT_STREET_NAME')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./SttlmTerms/CdtrAgt/NmAndAdr/Adr/StrtNm" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="./SttlmTerms/CdtrAgt/NmAndAdr/Adr/PstCdId !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_PDF_CREDITOR_AGENT_POST_CODE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./SttlmTerms/CdtrAgt/NmAndAdr/Adr/PstCdId" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="./SttlmTerms/CdtrAgt/NmAndAdr/Adr/TwnNm !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_PDF_CREDITOR_AGENT_TOWN')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./SttlmTerms/CdtrAgt/NmAndAdr/Adr/TwnNm" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="./SttlmTerms/CdtrAgt/NmAndAdr/Adr/CtrySubDvsn !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_PDF_CREDITOR_AGENT_COUNTRY_SUB_DIV')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./SttlmTerms/CdtrAgt/NmAndAdr/Adr/CtrySubDvsn" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="./SttlmTerms/CdtrAgt/NmAndAdr/Adr/Ctry !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_PDF_CREDITOR_AGENT_COUNTRY')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./SttlmTerms/CdtrAgt/NmAndAdr/Adr/Ctry" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="./SttlmTerms/CdtrAcct/Id/IBAN !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./SttlmTerms/CdtrAcct/Id/IBAN" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="./SttlmTerms/CdtrAcct/Id/BBAN !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_BBAN')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./SttlmTerms/CdtrAcct/Id/BBAN" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="./SttlmTerms/CdtrAcct/Id/UPIC !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_UPIC')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./SttlmTerms/CdtrAcct/Id/UPIC" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="./SttlmTerms/CdtrAcct/Id/PrtryAcct/Id !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_PDF_CREDITOR_ACCNT_ID')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./SttlmTerms/CdtrAcct/Id/PrtryAcct/Id" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="./SttlmTerms/CdtrAcct/Tp/Cd !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_LABEL_PAYMENT_CODE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./SttlmTerms/CdtrAcct/Tp/Cd" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="./SttlmTerms/CdtrAcct/Tp/Prtry !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_PDF_PAYMENT_PROP')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./SttlmTerms/CdtrAcct/Tp/Prtry" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="./SttlmTerms/CdtrAcct/Nm !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./SttlmTerms/CdtrAcct/Nm" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="./SttlmTerms/CdtrAcct/Ccy !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_CURRENCY')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./SttlmTerms/CdtrAcct/Ccy" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
				</xsl:if>
		</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	
	<xsl:template match="commercial_dataset/ComrclDataSetReqrd">
		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:if test="./Submitr/BIC !=''">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_SUBMITTER_BIC')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="./Submitr/BIC" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				</xsl:with-param>
				</xsl:call-template>
				</xsl:template>
				
	<xsl:template match="transport_dataset/TrnsprtDataSetReqrd">
		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:if test="./Submitr/BIC !=''">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_SUBMITTER_BIC')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="./Submitr/BIC" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				</xsl:with-param>
				</xsl:call-template>
				</xsl:template>
				
	<xsl:template match="insurance_dataset/InsrncDataSetReqrd">
		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="subtitle">
					<xsl:with-param name="text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PDF_INSURANCE_DATASET')" />
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="count(./Submitr) != 0">
				<xsl:for-each select="./Submitr">
				<xsl:if test="./BIC !=''">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_SUBMITTER_BIC')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="./BIC" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				</xsl:for-each>
				</xsl:if>
				<xsl:if test="./MtchIssr/Nm !='' or ./MtchIssr/Ctry !='' or ./MtchIssr/PrtryId/Id !='' or ./MtchIssr/PrtryId/IdTp !=''">
				<xsl:call-template name="sub_subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_MATCH_ISSUER')" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="./MtchIssr/Nm !=''">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						&nbsp;<xsl:value-of
							select="localization:getGTPString($language, 'XSL_DETAILS_PO_MATCH_NAME')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:call-template name="zero_width_space_1">
							<xsl:with-param name="data" select="./MtchIssr/Nm"/>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="./MtchIssr/Ctry !=''">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						&nbsp;<xsl:value-of
							select="localization:getGTPString($language, 'XSL_DETAILS_PO_COUNTRY')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="./MtchIssr/Ctry" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_DETAILS_PO_PROPRIETARY_IDENTIFICATION')" />
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="./MtchIssr/PrtryId/Id !=''">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						&nbsp;<xsl:value-of
							select="localization:getGTPString($language, 'XSL_DETAILS_PO_IDENTIFICATION')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="./MtchIssr/PrtryId/Id" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="./MtchIssr/PrtryId/IdTp !=''">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						&nbsp;<xsl:value-of
							select="localization:getGTPString($language, 'XSL_DETAILS_PO_IDENTIFICATION_TYPE')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="./MtchIssr/PrtryId/IdTp" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				</xsl:if>
				<xsl:if test="./MtchIsseDt !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_PO_MATCH_ISSUE_DATE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="./MtchIsseDt = 'Y'">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REQUIRED')" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NOT_REQUIRED')" />						
							</xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="./MtchAmt !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_PO_MATCH_AMOUNT')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="./MtchAmt = 'Y'">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REQUIRED')" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NOT_REQUIRED')" />						
							</xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="./MtchTrnsprt !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_PO_MATCH_TRANSPORT')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="./MtchTrnsprt = 'Y'">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REQUIRED')" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NOT_REQUIRED')" />						
							</xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="./MtchAssrdPty !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_PO_MATCH_ASSURED_PARTY')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./MtchAssrdPty" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="count(./ClausesReqrd) != 0">
				<xsl:for-each select="./ClausesReqrd">
				<xsl:if test=". !=''">
					<xsl:call-template name="sub_subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_CLAUSES_REQUIRED_HEADER')" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_MATCH_ASSURED_PARTY')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="." />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				</xsl:for-each>
				</xsl:if>
				</xsl:with-param>
				</xsl:call-template>
				</xsl:template>
				
	<xsl:template match="certificate_dataset/CertDataSetReqrd">
		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="spacer_template"/>
				<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="subtitle">
					<xsl:with-param name="text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PDF_CERTIFICATE_DATASET')" />
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="count(./Submitr) != 0">
				<xsl:for-each select="./Submitr">
				<xsl:if test="./BIC !=''">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_SUBMITTER_BIC')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="./BIC" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				</xsl:for-each>
				</xsl:if>
				<xsl:if test="./CertTp !=''">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_DETAILS_PO_CERTIFICATE_TYPE')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="./CertTp" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="./MtchIssr/Nm !='' or ./MtchIssr/Ctry !='' or ./MtchIssr/PrtryId/Id !='' or ./MtchIssr/PrtryId/IdTp !=''">
				<xsl:call-template name="sub_subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_MATCH_ISSUER')" />
						</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="./MtchIssr/Nm !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							&nbsp;<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_PO_MATCH_NAME')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:call-template name="zero_width_space_1">
								<xsl:with-param name="data" select="./MtchIssr/Nm"/>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="./MtchIssr/Ctry !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							&nbsp;<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_PO_COUNTRY')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./MtchIssr/Ctry" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_DETAILS_PO_PROPRIETARY_IDENTIFICATION')" />
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="./MtchIssr/PrtryId/Id !=''">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						&nbsp;<xsl:value-of
							select="localization:getGTPString($language, 'XSL_DETAILS_PO_IDENTIFICATION')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="./MtchIssr/PrtryId/Id" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="./MtchIssr/PrtryId/IdTp !=''">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						&nbsp;<xsl:value-of
							select="localization:getGTPString($language, 'XSL_DETAILS_PO_IDENTIFICATION_TYPE')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="./MtchIssr/PrtryId/IdTp" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				</xsl:if>
				<xsl:if test="./MtchIsseDt !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_PO_MATCH_ISSUE_DATE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="./MtchIsseDt = 'Y'">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REQUIRED')" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NOT_REQUIRED')" />						
							</xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="./MtchInspctnDt !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_PO_MATCH_INSPECTION_DATE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="./MtchInspctnDt = 'Y'">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REQUIRED')" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NOT_REQUIRED')" />						
							</xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="./AuthrsdInspctrInd !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_PO_AUTHORIZED_INSPECTOR_INDICATOR')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="./AuthrsdInspctrInd = 'Y'">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REQUIRED')" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NOT_REQUIRED')" />						
							</xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="./MtchConsgn !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_PO_MATCH_CONSIGNEE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="./MtchConsgn = 'Y'">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REQUIRED')" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NOT_REQUIRED')" />						
							</xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="./MtchManfctr/Nm !='' or ./MtchManfctr/Ctry !='' or ./MtchManfctr/PrtryId/Id !='' or ./MtchManfctr/PrtryId/IdTp !=''">
				<xsl:call-template name="sub_subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_MATCH_MANUFACTURER')" />
						</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="./MtchManfctr/Nm !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							&nbsp;<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_PO_MATCH_NAME')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:call-template name="zero_width_space_1">
								<xsl:with-param name="data" select="./MtchIssr/Nm"/>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="./MtchManfctr/Ctry !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							&nbsp;<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_PO_COUNTRY')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./MtchIssr/Ctry" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_DETAILS_PO_PROPRIETARY_IDENTIFICATION')" />
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="./MtchManfctr/PrtryId/Id !=''">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						&nbsp;<xsl:value-of
							select="localization:getGTPString($language, 'XSL_DETAILS_PO_IDENTIFICATION')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="./MtchIssr/PrtryId/Id" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="./MtchManfctr/PrtryId/IdTp !=''">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						&nbsp;<xsl:value-of
							select="localization:getGTPString($language, 'XSL_DETAILS_PO_IDENTIFICATION_TYPE')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="./MtchIssr/PrtryId/IdTp" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				</xsl:if>
				<xsl:if test="count(./LineItmId) != 0">
				<xsl:for-each select="./LineItmId">
				<xsl:if test=". !=''">
					<xsl:call-template name="sub_subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_LINE_ITEM_IDENTIFICATION_HEADER')" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_LINE_ITEM_IDENTIFICATION')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="." />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				</xsl:for-each>
				</xsl:if>
				</xsl:with-param>
				</xsl:call-template>
				</xsl:template>
				
	<xsl:template match="other_certificate_dataset/OthrCertDataSetReqrd">
		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="subtitle">
					<xsl:with-param name="text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PDF_OTHER_CERTIFICATE_DATASET')" />
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="count(./Submitr) != 0">
					<xsl:for-each select="./Submitr">
						<xsl:if test="./BIC !=''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_SUBMITTER_BIC')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="./BIC" />
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="./CertTp !=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_PO_CERTIFICATE_TYPE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="./CertTp" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="routing_summaries/air_routing_summaries/rs_tnx_record | routing_summaries/sea_routing_summaries/rs_tnx_record | routing_summaries/rail_routing_summaries/rs_tnx_record | routing_summaries/road_routing_summaries/rs_tnx_record">
		<xsl:param name="subItem">N</xsl:param>
		<!-- Individual Routing Summary Details : start -->
		<xsl:if test="routing_summary_mode = '01'">
			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:choose>
						<xsl:when test="$subItem = 'Y'">
							<xsl:call-template name="sub_subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_AIR')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_AIR')"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_CARRIER_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="air_carrier_name"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			
			<!-- Display each departure -->
			<xsl:apply-templates select="departures"/>
			
			<!-- Display each destination -->
			<xsl:apply-templates select="destinations"/>
				
		</xsl:if>
		<xsl:if test="routing_summary_mode = '02'">
			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:choose>
						<xsl:when test="$subItem = 'Y'">
							<xsl:call-template name="sub_subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_SEA')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_SEA')"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_CARRIER_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="sea_carrier_name"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
					
			<!-- Display each loading port -->
			<xsl:apply-templates select="loading_ports"/>
		
			<!-- Display each discharge port -->
			<xsl:apply-templates select="discharge_ports"/>
				
		</xsl:if>
		<xsl:if test="routing_summary_mode = '03'">
			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:choose>
						<xsl:when test="$subItem = 'Y'">
							<xsl:call-template name="sub_subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD')"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_CARRIER_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="road_carrier_name"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<!-- Display each road receipt place -->
			<xsl:apply-templates select="road_receipt_places"/>
		
			<!-- Display each road delivery place -->
			<xsl:apply-templates select="road_delivery_places"/>
		</xsl:if>
		<xsl:if test="routing_summary_mode = '04'">
			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:choose>
						<xsl:when test="$subItem = 'Y'">
							<xsl:call-template name="sub_subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL')" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL')"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_CARRIER_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="rail_carrier_name"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			
			<!-- Display each rail receipt place -->
			<xsl:apply-templates select="rail_receipt_places"/>
			<!-- Display each rail delivery place -->
			<xsl:apply-templates select="rail_delivery_places"/>
			
		</xsl:if>
		<!-- Individual Routing Summary Details : end -->
	</xsl:template>
	
	<xsl:template match="departures">
			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="sub_subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DEPARTURE')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="table_3_columns_template">
				<xsl:with-param name="text">
					<xsl:call-template name="table_cell_3_columns">
						<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_IO_DEPT_AIRPORT_CODE')"/></xsl:with-param>
						<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
						<xsl:with-param name="column_1_text_font_weight"/>
						<xsl:with-param name="column_1_text_align">center</xsl:with-param>
						<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_IO_DEPT_OTR_AIRPORT_TOWN')"/></xsl:with-param>
						<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
						<xsl:with-param name="column_2_text_font_weight"/>
						<xsl:with-param name="column_2_text_align">center</xsl:with-param>
						<xsl:with-param name="column_3_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_IO_DEPT_OTR_AIRPORT_NAME')"/></xsl:with-param>
						<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
						<xsl:with-param name="column_3_text_font_weight"/>
						<xsl:with-param name="column_3_text_align">center</xsl:with-param>
					</xsl:call-template>
					<!-- Display each departure -->
					<xsl:apply-templates select="departure"/>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:template>
	<xsl:template match="departure">
		<xsl:call-template name="table_cell_3_columns">
			<xsl:with-param name="column_1_text"><xsl:value-of select="departure_airport_code"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
			<xsl:with-param name="column_2_text"><xsl:value-of select="departure_air_town"/></xsl:with-param>
			<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
			<xsl:with-param name="column_2_text_align">center</xsl:with-param>
			<xsl:with-param name="column_3_text"><xsl:value-of select="departure_airport_name"/></xsl:with-param>
			<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_3_text_font_weight">bold</xsl:with-param>
			<xsl:with-param name="column_3_text_align">center</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="destinations">
		<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="sub_subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DESTINATION')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="table_3_columns_template">
				<xsl:with-param name="text">
					<xsl:call-template name="table_cell_3_columns">
						<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_IO_DEST_AIRPORT_CODE')"/></xsl:with-param>
						<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
						<xsl:with-param name="column_1_text_font_weight"/>
						<xsl:with-param name="column_1_text_align">center</xsl:with-param>
						<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_IO_DEST_OTR_AIRPORT_TOWN')"/></xsl:with-param>
						<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
						<xsl:with-param name="column_2_text_font_weight"/>
						<xsl:with-param name="column_2_text_align">center</xsl:with-param>
						<xsl:with-param name="column_3_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_IO_DEST_OTR_AIRPORT_NAME')"/></xsl:with-param>
						<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
						<xsl:with-param name="column_3_text_font_weight"/>
						<xsl:with-param name="column_3_text_align">center</xsl:with-param>
					</xsl:call-template>
					<!-- Display each destination -->
					<xsl:apply-templates select="destination"/>
				</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	
	<xsl:template match="destination">
		<xsl:call-template name="table_cell_3_columns">
			<xsl:with-param name="column_1_text"><xsl:value-of select="destination_airport_code"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
			<xsl:with-param name="column_2_text"><xsl:value-of select="destination_air_town"/></xsl:with-param>
			<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
			<xsl:with-param name="column_2_text_align">center</xsl:with-param>
			<xsl:with-param name="column_3_text"><xsl:value-of select="destination_airport_name"/></xsl:with-param>
			<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_3_text_font_weight">bold</xsl:with-param>
			<xsl:with-param name="column_3_text_align">right</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="discharge_ports">
			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="sub_subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_ROUTING_SUMMARY_LOADING_PORT')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="table_1_column_template">
				<xsl:with-param name="text">
					<xsl:call-template name="table_cell_1_column">
						<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_IO_PORT_OF_LOADING')"/></xsl:with-param>
						<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
						<xsl:with-param name="column_1_text_font_weight"/>
						<xsl:with-param name="column_1_text_align">center</xsl:with-param>
					</xsl:call-template>
					<!-- Display each discharge port -->
					<xsl:apply-templates select="discharge_port"/>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:template>
	<xsl:template match="discharge_port">
		<xsl:call-template name="table_cell_1_column">
			<xsl:with-param name="column_1_text"><xsl:value-of select="loading_port_name"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="loading_ports">
		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="sub_subtitle">
					<xsl:with-param name="text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_ROUTING_SUMMARY_DISCHARGE_PORT')"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="table_1_column_template">
			<xsl:with-param name="text">
				<xsl:call-template name="table_cell_1_column">
					<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_IO_PORT_OF_DISCHARGE')"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_weight"/>
					<xsl:with-param name="column_1_text_align">center</xsl:with-param>
				</xsl:call-template>
				<!-- Display each loading port -->
				<xsl:apply-templates select="loading_port"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="loading_port">
		<xsl:call-template name="table_cell_1_column">
			<xsl:with-param name="column_1_text"><xsl:value-of select="discharge_port_name"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="rail_delivery_places">
			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_1_column_template">
				<xsl:with-param name="text">
					<xsl:call-template name="table_cell_1_column">
						<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_TRNS_BY_RAIL_DELIVERY_PLACE')"/></xsl:with-param>
						<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
						<xsl:with-param name="column_1_text_font_weight"/>
						<xsl:with-param name="column_1_text_align">center</xsl:with-param>
					</xsl:call-template>
					<!-- Display each rail delivery place -->
					<xsl:apply-templates select="rail_delivery_place"/>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:template>
	<xsl:template match="rail_delivery_place">
		<xsl:call-template name="table_cell_1_column">
			<xsl:with-param name="column_1_text"><xsl:value-of select="rail_delivery_place_name"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="rail_receipt_places">
		<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_1_column_template">
				<xsl:with-param name="text">
					<xsl:call-template name="table_cell_1_column">
						<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_TRNS_BY_RAIL_RECEIPT_PLACE')"/></xsl:with-param>
						<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
						<xsl:with-param name="column_1_text_font_weight"/>
						<xsl:with-param name="column_1_text_align">center</xsl:with-param>
					</xsl:call-template>
					<!-- Display each rail receipt place -->
					<xsl:apply-templates select="rail_receipt_place"/>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:template>
	<xsl:template match="rail_receipt_place">
		<xsl:call-template name="table_cell_1_column">
			<xsl:with-param name="column_1_text"><xsl:value-of select="rail_receipt_place_name"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="road_delivery_places">
		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="table_1_column_template">
			<xsl:with-param name="text">
				<xsl:call-template name="table_cell_1_column">
					<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_TRNS_BY_RAIL_DELIVERY_PLACE')"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_weight"/>
					<xsl:with-param name="column_1_text_align">center</xsl:with-param>
				</xsl:call-template>
				<!-- Display each road delivery place -->
				<xsl:apply-templates select="road_delivery_place"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="road_delivery_place">
		<xsl:call-template name="table_cell_1_column">
			<xsl:with-param name="column_1_text"><xsl:value-of select="road_delivery_place_name"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="road_receipt_places">
		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="table_1_column_template">
			<xsl:with-param name="text">
				<xsl:call-template name="table_cell_1_column">
					<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_TRNS_BY_RAIL_RECEIPT_PLACE')"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_weight"/>
					<xsl:with-param name="column_1_text_align">center</xsl:with-param>
				</xsl:call-template>
				<!-- Display each road receipt place -->
				<xsl:apply-templates select="road_receipt_place"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="road_receipt_place">
		<xsl:call-template name="table_cell_1_column">
			<xsl:with-param name="column_1_text"><xsl:value-of select="road_receipt_place_name"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
			<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Multi modal Routing Summary Details -->
	<xsl:template match="routing_summaries/rs_tnx_record">
		<xsl:param name="subItem">N</xsl:param>
		<xsl:if test="taking_in_charge != '' or place_of_final_destination != ''">
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:if test="taking_in_charge != ''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TAKING_IN_CHARGE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="taking_in_charge"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="place_of_final_destination != ''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PLACE_OF_FINAL_DEST')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="place_of_final_destination"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="mismatch-report">
	<xsl:param name="outerCounter">1</xsl:param>
	<xsl:param name="node"/>
	<xsl:param name="outerLimit"/>
	<xsl:param name="innerLimit"><xsl:value-of select="count($node/MisMtchInf[number($outerCounter)]/MisMtchdElmt)"></xsl:value-of></xsl:param>
	<xsl:param name="innerCounter">1</xsl:param>
		
		<xsl:call-template name="spacer_template"/>
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_MISMATCH_SEQ_NO')"/>
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="$node/MisMtchInf[number($outerCounter)]/SeqNb"/>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_MISMATCH_DETAILS')"/>
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:call-template name="zero_width_space_1">
							<xsl:with-param name="data" select="$node/MisMtchInf[number($outerCounter)]/RuleDesc"/>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="table_2_columns_template">
			<xsl:with-param name="text">
				<xsl:call-template name="table_cell_2_columns">
					<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_ELEMENT_NAME')"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
					<xsl:with-param name="column_1_text_font_weight"/>
					<xsl:with-param name="column_1_text_align">center</xsl:with-param>
					<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_ELEMENT_VALUE')"/></xsl:with-param>
					<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
					<xsl:with-param name="column_2_text_font_weight"/>
					<xsl:with-param name="column_2_text_align">center</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="mismatch-elements">
			<xsl:with-param name="innerCounter"><xsl:value-of select="$innerCounter"/></xsl:with-param>
			<xsl:with-param name="node" select="$node/MisMtchInf[number($outerCounter)]"/>
			<xsl:with-param name="innerLimit" select="$innerLimit"/>
			<xsl:with-param name="outerCounter"><xsl:value-of select="$outerCounter"/></xsl:with-param>
		</xsl:call-template>
		
		
		<xsl:if test="number($outerCounter)+1 &lt;= number($outerLimit)">
			<xsl:call-template name="mismatch-report">
				<xsl:with-param name="outerCounter"><xsl:value-of select="number($outerCounter)+1"/></xsl:with-param>
				<xsl:with-param name="node" select="$node"/>
				<xsl:with-param name="outerLimit" select="$outerLimit"/>
			</xsl:call-template>
		</xsl:if>
		
	</xsl:template>
	
	<xsl:template name="mismatch-elements">
		<xsl:param name="innerCounter"/>
		<xsl:param name="node"/>
		<xsl:param name="innerLimit"/>
		<xsl:param name="outerCounter"/>
			<xsl:call-template name="table_2_columns_template">
				<xsl:with-param name="text">
					<xsl:call-template name="table_cell_2_columns">
						<xsl:with-param name="column_1_text"><xsl:value-of select="$node/MisMtchdElmt[number($innerCounter)]/ElmtNm"/></xsl:with-param>
						<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
						<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
						<xsl:with-param name="column_2_text_align">center</xsl:with-param>
						<xsl:with-param name="column_2_text"><xsl:value-of select="$node/MisMtchdElmt[number($innerCounter)]/ElmtVal"/></xsl:with-param>
						<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFontData"/></xsl:with-param>
						<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
						<xsl:with-param name="column_2_text_align">center</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="number($innerCounter)+1 &lt;= number($innerLimit)">
				<xsl:call-template name="mismatch-elements">
					<xsl:with-param name="innerCounter"><xsl:value-of select="number($innerCounter)+1"/></xsl:with-param>
					<xsl:with-param name="node" select="$node"/>
					<xsl:with-param name="innerLimit" select="$innerLimit"/>
				</xsl:call-template>
			</xsl:if>
	</xsl:template>
	
</xsl:stylesheet>