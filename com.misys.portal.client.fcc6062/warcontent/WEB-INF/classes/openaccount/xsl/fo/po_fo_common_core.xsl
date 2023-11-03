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
	
	<xsl:param name="section_amount_details">N</xsl:param>
	
	<!-- Ajustements template (Header)-->
	<xsl:template match="adjustments">
		<xsl:if test="count(adjustment[allowance_type='02']) > 0">
		<fo:block keep-together="always">
			<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
				<fo:table-column column-width="{$pdfTableWidth}"/>	
				<fo:table-column column-width="0" /> <!--  dummy column -->		
				<fo:table-header>
					<fo:table-row>
						<fo:table-cell>
							<fo:block space-before.optimum="10.0pt"	background-color="{$backgroundSubtitles}" start-indent="20.0pt"
								end-indent="20.0pt" font-weight="bold" font-family="{$pdfFont}">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ADJUSTMENTS_DETAILS')" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<fo:table-body>
					<fo:table-row keep-with-previous="always">
					<fo:table-cell>
					<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
				      	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
	  				       	<fo:table-column column-width="40.0pt"/>
	  				       	<fo:table-column column-width="proportional-column-width(6)"/>
							<xsl:choose>
								<xsl:when test="count(adjustment[amt!='']) != 0 and count(adjustment[rate!='']) = 0">
									<fo:table-column column-width="proportional-column-width(1)"/>
									<fo:table-column column-width="proportional-column-width(2)"/>
									<fo:table-column column-width="0"/>
									<fo:table-column column-width="0"/>
									<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
										<fo:table-row text-align="center">
										<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
										<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_TYPE')"/></fo:block></fo:table-cell>
										<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_CUR_CODE')"/></fo:block></fo:table-cell>
										<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_AMOUNT')"/></fo:block></fo:table-cell>	        			        		
										</fo:table-row>
									</fo:table-header>
								</xsl:when>
								<xsl:when test="count(adjustment[rate!='']) != 0 and count(adjustment[amt!='']) = 0">
									<fo:table-column column-width="proportional-column-width(3)"/>
									<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
										<fo:table-row text-align="center">
										<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
										<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_TYPE')"/></fo:block></fo:table-cell>
										<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_RATE')"/></fo:block></fo:table-cell>	        			        		
										</fo:table-row>
									</fo:table-header>
								</xsl:when>
								<xsl:otherwise>
									<fo:table-column column-width="proportional-column-width(1)"/>
									<fo:table-column column-width="proportional-column-width(2)"/>
									<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
										<fo:table-row text-align="center">
										<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
										<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_TYPE')"/></fo:block></fo:table-cell>
										<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_CUR_CODE')"/></fo:block></fo:table-cell>
										<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_AMOUNT_OR_RATE')"/></fo:block></fo:table-cell>	        			        		
										</fo:table-row>
									</fo:table-header>
								</xsl:otherwise>
							</xsl:choose>
							<!-- Display each adjustment -->
							<fo:table-body>
								<xsl:apply-templates select="adjustment[allowance_type='02']"/>
							</fo:table-body>
						</fo:table>
					</fo:block>
					</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
		</xsl:if>
	</xsl:template>
	
	<!-- Adjustment template -->
	<xsl:template match="adjustment[allowance_type='02']">
		<!-- Set the displayed direction -->
		<xsl:variable name="adjustment_direction"><xsl:value-of select="direction"/></xsl:variable>		
		<xsl:variable name="displayedDirection">
			<xsl:if test="direction[. != '']">
				<xsl:value-of select="localization:getDecode($language, 'N216', $adjustment_direction)"/>
			</xsl:if>
		</xsl:variable>
		
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
		<fo:table-row keep-with-previous="always">
		<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
      	<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
			<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
				<xsl:value-of select="$displayedType"/>
			</fo:block>
		</fo:table-cell>
		<xsl:choose>
			<xsl:when test="count(../adjustment[amt!='']) != 0 and count(../adjustment[rate!='']) = 0">
      			<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
					<fo:block text-align="center" padding-top="1.0pt" padding-bottom=".5pt">
						<xsl:value-of select="cur_code"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
					<fo:block text-align="right" padding-top="1.0pt" padding-bottom=".5pt">
						<xsl:choose>
							<xsl:when test="direction[.='ADDD']">+</xsl:when>
							<xsl:when test="direction[.='SUBS']">-</xsl:when>
							<xsl:otherwise/>
						</xsl:choose>
						<xsl:value-of select="amt"/>		
					</fo:block>
				</fo:table-cell>
			</xsl:when>
			<xsl:when test="count(../adjustment[rate!='']) != 0 and count(../adjustment[amt!='']) = 0">			
      			<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
					<fo:block text-align="right" padding-top="1.0pt" padding-bottom=".5pt">
						<xsl:choose>
							<xsl:when test="direction[.='ADDD']">+</xsl:when>
							<xsl:when test="direction[.='SUBS']">-</xsl:when>
							<xsl:otherwise/>
						</xsl:choose>
						<xsl:value-of select="rate"/>%		
					</fo:block>
				</fo:table-cell>				
			</xsl:when>
			<xsl:otherwise>
      			<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
					<fo:block text-align="center" padding-top="1.0pt" padding-bottom=".5pt">
						<xsl:value-of select="cur_code"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
					<fo:block text-align="right" padding-top="1.0pt" padding-bottom=".5pt">
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
					</fo:block>
				</fo:table-cell>
			</xsl:otherwise>	
		</xsl:choose>        			        		
      	</fo:table-row>
	</xsl:template>
	
	<!-- Taxes template (Header)-->
	<xsl:template match="taxes">
		<xsl:if test="count(tax[allowance_type='01']) > 0">	
		<fo:block keep-together="always">
			<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
				<fo:table-column column-width="{$pdfTableWidth}"/>	
				<fo:table-column column-width="0"/> <!--  dummy column -->		
				<fo:table-header>
					<fo:table-row>
						<fo:table-cell>
							<fo:block space-before.optimum="10.0pt"	background-color="{$backgroundSubtitles}" start-indent="20.0pt"
								end-indent="20.0pt" font-weight="bold" font-family="{$pdfFont}">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TAXES_DETAILS')" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<fo:table-body>
					<fo:table-row keep-with-previous="always">
					<fo:table-cell>
					<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
				      	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
	  				       	<fo:table-column column-width="40.0pt"/>
	  				       	<fo:table-column column-width="proportional-column-width(6)"/>
							<xsl:choose>
									<xsl:when test="count(tax[amt!='']) != 0 and count(tax[rate!='']) = 0">
				        				<fo:table-column column-width="proportional-column-width(1)"/>
										<fo:table-column column-width="proportional-column-width(2)"/>
										<fo:table-column column-width="0"/> <!--  dummy column -->
										<fo:table-column column-width="0"/> <!--  dummy column -->
										<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
											<fo:table-row text-align="center">
											<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
											<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_TYPE')"/></fo:block></fo:table-cell>
											<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_CUR_CODE')"/></fo:block></fo:table-cell>
											<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_AMOUNT')"/></fo:block></fo:table-cell>	        			        		
											</fo:table-row>
										</fo:table-header>
									</xsl:when>
									<xsl:when test="count(tax[rate!='']) != 0 and count(tax[amt!='']) = 0">
										<fo:table-column column-width="proportional-column-width(3)"/>
										<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
											<fo:table-row text-align="center">
											<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
											<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_TYPE')"/></fo:block></fo:table-cell>
											<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_RATE')"/></fo:block></fo:table-cell>	        			        		
											</fo:table-row>
										</fo:table-header>
									</xsl:when>
									<xsl:otherwise>
										<fo:table-column column-width="proportional-column-width(1)"/>
										<fo:table-column column-width="proportional-column-width(2)"/>
										<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
											<fo:table-row text-align="center">
											<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
											<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_TYPE')"/></fo:block></fo:table-cell>
											<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_AMOUNT_OR_RATE')"/></fo:block></fo:table-cell>	        			        		
											</fo:table-row>
										</fo:table-header>
									</xsl:otherwise>
								</xsl:choose>
				        	<fo:table-body>
				        		<!-- Display each taxe -->
								<xsl:apply-templates select="tax[allowance_type='01']"/>
				        	</fo:table-body>
						</fo:table>
					</fo:block>
					</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
		</xsl:if>
	</xsl:template>
	
	<!-- Taxe template -->
	<xsl:template match="tax[allowance_type='01']">
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
			
		<fo:table-row keep-with-previous="always">
		<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
      	<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
			<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
				<xsl:value-of select="$displayedType"/>
			</fo:block>
		</fo:table-cell>
		<xsl:choose>
			<xsl:when test="count(../tax[amt!='']) != 0 and count(../tax[rate!='']) = 0">
      			<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
					<fo:block text-align="center" padding-top="1.0pt" padding-bottom=".5pt">
						<xsl:value-of select="cur_code"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
					<fo:block text-align="right" padding-top="1.0pt" padding-bottom=".5pt">
						<xsl:choose>
							<xsl:when test="direction[.='ADDD']">+</xsl:when>
							<xsl:when test="direction[.='SUBS']">-</xsl:when>
							<xsl:otherwise/>
						</xsl:choose>
						<xsl:value-of select="amt"/>		
					</fo:block>
				</fo:table-cell>
			</xsl:when>
			<xsl:when test="count(../tax[rate!='']) != 0 and count(../tax[amt!='']) = 0">			
      			<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
					<fo:block text-align="right" padding-top="1.0pt" padding-bottom=".5pt">
						+<xsl:value-of select="rate"/>%		
					</fo:block>
				</fo:table-cell>				
			</xsl:when>
			<xsl:otherwise>
      			<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
					<fo:block text-align="right" padding-top="1.0pt" padding-bottom=".5pt">
						<xsl:value-of select="cur_code"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
					<fo:block text-align="right" padding-top="1.0pt" padding-bottom=".5pt">
						+<xsl:choose>
							<xsl:when test="cur_code[.!='']">
								<xsl:value-of select="amt"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="rate"/>%
							</xsl:otherwise>
						</xsl:choose>
					</fo:block>
				</fo:table-cell>
			</xsl:otherwise>	
		</xsl:choose>        		        			        		
      	</fo:table-row>
	</xsl:template>	
	
	<!-- Freight Charges Details -->
	<xsl:template match="freightCharges">
		<xsl:if test="count(freightCharge[allowance_type='03']) > 0">	
		<fo:block keep-together="always">
			<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
				<fo:table-column column-width="{$pdfTableWidth}"/>	
				<fo:table-column column-width="0"/> <!--  dummy column -->
				<fo:table-header>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="2">
							<fo:block space-before.optimum="10.0pt"	background-color="{$backgroundSubtitles}" start-indent="20.0pt"
								end-indent="20.0pt" font-weight="bold" font-family="{$pdfFont}">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREIGHT_CHARGES_DETAILS')" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<fo:table-body>
					<fo:table-row>
			        	<fo:table-cell>		        	
				        	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
								<fo:table-column column-width="40.0pt"/>
		  				       	<fo:table-column column-width="proportional-column-width(1)"/>
		  				       	<fo:table-column column-width="proportional-column-width(1)"/>		
		  				       	<fo:table-body>
		  				       	<fo:table-row>
		  				       		<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell>
		  				       		<fo:table-cell>
		  				       			<fo:block font-family="{$pdfFont}"  space-before.optimum="10.0pt">
			        						<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_FREIGHT_CHARGES_TYPE')"/>
			        					</fo:block>
		  				       		</fo:table-cell>
		  				       		<fo:table-cell>
					        		<fo:block font-weight="bold" space-before.optimum="10.0pt">			        		
									<xsl:choose>
										<xsl:when test="../freight_charges_type[. = 'CLCT']">
											<xsl:value-of select="localization:getDecode($language, 'N211', 'CLCT')"/>
										</xsl:when>
										<xsl:when test="../freight_charges_type[. = 'PRPD']">
											<xsl:value-of select="localization:getDecode($language, 'N211', 'PRPD')"/>
										</xsl:when>
										<xsl:otherwise/>
									</xsl:choose>
									</fo:block>
									</fo:table-cell>	  				       		 	
		  				       	</fo:table-row>
		  				       	</fo:table-body>
							</fo:table>
						</fo:table-cell>								
					</fo:table-row>
					<fo:table-row keep-with-previous="always">
					<fo:table-cell>
					<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
				      	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
	  				       	<fo:table-column column-width="40.0pt"/>
	  				       	<fo:table-column column-width="proportional-column-width(6)"/>
							<xsl:choose>
									<xsl:when test="count(freightCharge[amt!='']) != 0 and count(freightCharge[rate!='']) = 0">
				        				<fo:table-column column-width="proportional-column-width(1)"/>
										<fo:table-column column-width="proportional-column-width(2)"/>
										<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
											<fo:table-row text-align="center">
											<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
											<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_TYPE')"/></fo:block></fo:table-cell>
											<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_CUR_CODE')"/></fo:block></fo:table-cell>
											<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_AMOUNT')"/></fo:block></fo:table-cell>	        			        		
											</fo:table-row>
										</fo:table-header>
									</xsl:when>
									<xsl:when test="count(freightCharge[rate!='']) != 0 and count(freightCharge[amt!='']) = 0">
										<fo:table-column column-width="proportional-column-width(3)"/>
										<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
											<fo:table-row text-align="center">
											<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
											<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_TYPE')"/></fo:block></fo:table-cell>
											<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_RATE')"/></fo:block></fo:table-cell>	        			        		
											</fo:table-row>
										</fo:table-header>
									</xsl:when>
									<xsl:otherwise>
										<fo:table-column column-width="proportional-column-width(1)"/>
										<fo:table-column column-width="proportional-column-width(2)"/>
										<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
											<fo:table-row text-align="center">
											<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
											<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_TYPE')"/></fo:block></fo:table-cell>
											<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_AMOUNT_OR_RATE')"/></fo:block></fo:table-cell>	        			        		
											</fo:table-row>
										</fo:table-header>
									</xsl:otherwise>
								</xsl:choose>
				        	<fo:table-body>
				        		<!-- Display each freight charge -->
								<xsl:apply-templates select="freightCharge[allowance_type='03']"/>
				        	</fo:table-body>
						</fo:table>
					</fo:block>
					</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
		</xsl:if>
	</xsl:template>
	
	<!-- Freight Charges template -->
	<xsl:template match="freightCharge[allowance_type='03']">
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
		<fo:table-row keep-with-previous="always">
		<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
      	<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
			<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
				<xsl:value-of select="$displayedType"/>
			</fo:block>
		</fo:table-cell>
		<xsl:choose>
			<xsl:when test="count(../freightCharge[amt!='']) != 0 and count(../freightCharge[rate!='']) = 0">
      			<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
					<fo:block text-align="center" padding-top="1.0pt" padding-bottom=".5pt">
						<xsl:value-of select="cur_code"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
					<fo:block text-align="right" padding-top="1.0pt" padding-bottom=".5pt">
						<xsl:choose>
							<xsl:when test="direction[.='ADDD']">+</xsl:when>
							<xsl:when test="direction[.='SUBS']">-</xsl:when>
							<xsl:otherwise/>
						</xsl:choose>
						<xsl:value-of select="amt"/>		
					</fo:block>
				</fo:table-cell>
			</xsl:when>
			<xsl:when test="count(../freightCharge[rate!='']) != 0 and count(../freightCharge[amt!='']) = 0">			
      			<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
					<fo:block text-align="right" padding-top="1.0pt" padding-bottom=".5pt">
						+<xsl:value-of select="rate"/>%		
					</fo:block>
				</fo:table-cell>				
			</xsl:when>
			<xsl:otherwise>
      			<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
					<fo:block text-align="right" padding-top="1.0pt" padding-bottom=".5pt">
						<xsl:value-of select="cur_code"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
					<fo:block text-align="right" padding-top="1.0pt" padding-bottom=".5pt">
						+<xsl:choose>
							<xsl:when test="cur_code[.!='']">
								<xsl:value-of select="amt"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="rate"/>%
							</xsl:otherwise>
						</xsl:choose>
					</fo:block>
				</fo:table-cell>
			</xsl:otherwise>	
		</xsl:choose> 	        			        		
      	</fo:table-row>
	</xsl:template>
	
	<!-- Payment Terms template (Header) -->
	<xsl:template match="payments">
		<xsl:if test="count(payment) > 0">
			<fo:block keep-together="always">
                <fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
                    <fo:table-column column-width="{$labelColumnWidth}"/>
                    <fo:table-column column-width="{$detailsColumnWidth}"/>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell number-columns-spanned="2">
                                <fo:block space-before.optimum="10.0pt"
                                    background-color="{$backgroundTitles}"
                                    color="{$fontColorTitles}" font-weight="bold" font-family="{$pdfFont}">
                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PAYMENT_TERMS_DETAILS')"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                            <fo:table-cell keep-with-previous="always" number-columns-spanned="2">
                                <fo:block>&nbsp;</fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                            <fo:table-cell number-columns-spanned="2">
                                <fo:block>
									<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
										<fo:table-column column-width="40.0pt"/>
										<xsl:choose>
											<xsl:when test="./cur_code[.!=''] or //*/payment_terms_type[.='AMNT']">	
												<fo:table-column column-width="proportional-column-width(6)"/>
												<fo:table-column column-width="proportional-column-width(1)"/>
												<fo:table-column column-width="proportional-column-width(2)"/>
												<fo:table-header>        			        	
													<fo:table-row text-align="center"  font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
														<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
														<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PAYMENT_CONDITION')"/></fo:block></fo:table-cell>
														<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PAYMENT_CUR_CODE')"/></fo:block></fo:table-cell>
														<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PAYMENT_AMOUNT')"/></fo:block></fo:table-cell>
													</fo:table-row>
												</fo:table-header>
											</xsl:when>
											<xsl:otherwise>
												<fo:table-column column-width="proportional-column-width(6)"/>
												<fo:table-column column-width="proportional-column-width(3)"/>
												<fo:table-header>        			        	
													<fo:table-row text-align="center"  font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
														<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
														<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PAYMENT_CONDITION')"/></fo:block></fo:table-cell>
														<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PAYMENT_PCT')"/></fo:block></fo:table-cell>	
													</fo:table-row>
												</fo:table-header>
											</xsl:otherwise>
										</xsl:choose>
										<fo:table-body>        		
											<!-- Display each payment term -->
											<xsl:apply-templates select="payment"/>
										</fo:table-body>
									</fo:table>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                            <fo:table-cell keep-with-previous="always" number-columns-spanned="2">
                                <fo:block>&nbsp;</fo:block>
                            </fo:table-cell>
                        </fo:table-row>
					</fo:table-body>
				</fo:table>  
             </fo:block>
		</xsl:if>    		
	</xsl:template>
	
	<!-- Payment term template -->
	<xsl:template match="payment">
		<!-- Set the value of the displayed type-->
		<xsl:variable name="displayedCode">
			<xsl:choose>
				<xsl:when test="code[. !='']">
					<xsl:value-of select="localization:getDecode($language, 'N208', code[.])"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="other_paymt_terms"/>
				</xsl:otherwise>						
			</xsl:choose>
		</xsl:variable>
		
		<fo:table-row keep-with-previous="always">
		<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
      	<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
	      	<fo:block text-align="left"  padding-top="1.0pt" padding-bottom=".5pt">
		      	<xsl:value-of select="$displayedCode"/>
				<xsl:if test="nb_days[.!='']">
					&nbsp;(+<xsl:value-of select="nb_days"/>&nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_PAYMENT_PERIOD_DAYS')"/>)
				</xsl:if>				
			</fo:block>
		</fo:table-cell>
		<xsl:choose>
			<xsl:when test="//*/payment_terms_type[.='AMNT']">									
				<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
					<fo:block text-align="center" padding-top="1.0pt" padding-bottom=".5pt">
						<xsl:value-of select="cur_code"/>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
	      			<fo:block text-align="right" padding-top="1.0pt" padding-bottom=".5pt">
						<xsl:value-of select="amt"/>
					</fo:block>
				</fo:table-cell>
			</xsl:when>
			<xsl:otherwise>
				<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
	      			<fo:block text-align="right" padding-top="1.0pt" padding-bottom=".5pt">
						<xsl:value-of select="pct"/>%
					</fo:block>
				</fo:table-cell>
			</xsl:otherwise>
		</xsl:choose>
      	</fo:table-row>	
	</xsl:template>
	
	<!-- Incoterms template (Header) -->
	<xsl:template match="incoterms">
		<xsl:if test="count(incoterm) > 0">
			<fo:block keep-together="always">
                <fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
                    <fo:table-column column-width="{$labelColumnWidth}"/>
                    <fo:table-column column-width="{$detailsColumnWidth}"/>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell number-columns-spanned="2">
                                <fo:block space-before.optimum="10.0pt"
                                    background-color="{$backgroundTitles}"
                                    color="{$fontColorTitles}" font-weight="bold" font-family="{$pdfFont}">
                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_INCO_TERMS_DETAILS')"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
					  	<fo:table-row keep-with-previous="always">
							<fo:table-cell>				
								<fo:block white-space-collapse="false">
									<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
									  <fo:table-column column-width="{$labelColumnWidth}"/>
									  <fo:table-column column-width="{$detailsColumnWidth}"/>
										 <fo:table-body>
										 <fo:table-row>
										 <fo:table-cell>
											<fo:block space-before.optimum="10.0pt" white-space-collapse="true"> 
												<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
												<fo:table-column column-width="40.0pt"/>
													<fo:table-column column-width="proportional-column-width(1)"/>
													<fo:table-column column-width="proportional-column-width(1)"/>
													<fo:table-header>        			        	
														<fo:table-row text-align="center" font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
															<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
															<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_INCO_TERMS_CODE')"/></fo:block></fo:table-cell>
															<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_INCO_TERMS_LOCATION')"/></fo:block></fo:table-cell>
														</fo:table-row>
													</fo:table-header>
													<fo:table-body>  							      		
														<!-- Display each incoterm -->
														<xsl:apply-templates select="incoterm"/>
													</fo:table-body>
												</fo:table>
											</fo:block>                            
											</fo:table-cell>
										</fo:table-row>
										</fo:table-body>
									</fo:table>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>                        
					</fo:table-body>
				</fo:table>  
             </fo:block>
		</xsl:if>    		
	</xsl:template>
	
	<!-- Incoterm template -->
	<xsl:template match="incoterm">
		<!-- Set the value of incoterm -->
		<xsl:variable name="inco_term_code">
			<xsl:choose>
				<xsl:when test="code[. !='']">
					<xsl:value-of select="localization:getDecode($language, 'N212', code)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="other"/>
				</xsl:otherwise>						
			</xsl:choose>			
		</xsl:variable>
		
		<fo:table-row keep-with-previous="always">
		<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
      	<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
	      	<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
				<xsl:value-of select="$inco_term_code"/>				
			</fo:block>
		</fo:table-cell>
			<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
				<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
					<xsl:value-of select="location"/>
				</fo:block>
			</fo:table-cell>	        			        		
      	</fo:table-row>	
	</xsl:template>	
	
	<!-- Routing summaries template (Header)-->
	<xsl:template match="routing_summaries">
		<xsl:if test="count(routing_summary) > 0">	
		<fo:block keep-together="always">
			<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
                <fo:table-column column-width="{$labelColumnWidth}"/>
                <fo:table-column column-width="{$detailsColumnWidth}"/>			
				<fo:table-header>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="2">
                       		<fo:block space-before.optimum="10.0pt" background-color="{$backgroundTitles}"
                                    color="{$fontColorTitles}" font-weight="bold" font-family="{$pdfFont}">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ROUTING_SUMMARY_DETAILS')" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<fo:table-body>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block font-family="{$pdfFont}"
                                start-indent="20.0pt" space-before.optimum="10.0pt">
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_PO_ROUTING_SUMMARY_TRANSPORT_TYPE')"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-weight="bold" space-before.optimum="10.0pt">
                            	<xsl:choose>
								<xsl:when test="count(routing_summary/transport_type[. = '01']) != 0">
									<xsl:value-of select="localization:getDecode($language, 'N213', '01')"/>
								</xsl:when>
								<xsl:when test="count(routing_summary/transport_type[. = '02']) != 0">
									<xsl:value-of select="localization:getDecode($language, 'N213', '02')"/>
								</xsl:when>
								</xsl:choose>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                    <fo:table-cell number-columns-spanned="2">
				<!-- Individual mode air-->
				<xsl:if test="count(routing_summary[transport_mode='01' and transport_type='01']) > 0">
					<fo:block keep-together="always">
						<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
							<fo:table-column column-width="{$pdfTableWidth}"/>
							<fo:table-column column-width="0"/> <!--  dummy column -->	
							<fo:table-header>
							<fo:table-row>
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"	background-color="{$backgroundSubtitles}" start-indent="20.0pt"
										end-indent="20.0pt" font-weight="bold" font-family="{$pdfFont}">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_AIR')" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							</fo:table-header>
							<fo:table-body>
							<fo:table-row keep-with-previous="always">
							<fo:table-cell>						
								<!-- Display each group of transport by air -->
								<xsl:for-each select="routing_summary[transport_mode='01' and transport_type='01']">
									<xsl:variable name="currentTransportGroup"><xsl:value-of select="transport_group"/></xsl:variable>
									<xsl:if test="count(preceding-sibling::routing_summary[transport_mode='01' and transport_type='01' and transport_group = $currentTransportGroup]) = 0">				
									<fo:block keep-together="always">
									<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
										<fo:table-column column-width="{$pdfTableWidth}"/>	
										<fo:table-column column-width="0"/> <!--  dummy column -->
									<fo:table-body>
										<fo:table-row>
											<fo:table-cell>				
											<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
									      	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
						  				       	<fo:table-column column-width="60.0pt"/>
						  				       	<fo:table-column column-width="proportional-column-width(1)"/>
									        	<fo:table-column column-width="proportional-column-width(1)"/>
									        	<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
													<fo:table-row text-align="center">
													<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
									        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_SUB_TYPE')"/></fo:block></fo:table-cell>
									        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_AIRPORT')"/></fo:block></fo:table-cell>	        			        		
									        		</fo:table-row>
									        	</fo:table-header>
									        	<fo:table-body>
													<!-- Display each airport of the group -->					
													<xsl:apply-templates select="../routing_summary[transport_mode='01' and transport_type='01' and transport_group = $currentTransportGroup]"/>
									        	</fo:table-body>
											</fo:table>
										</fo:block>	
										</fo:table-cell>
										</fo:table-row>
										</fo:table-body>
										</fo:table>		
									</fo:block>
									</xsl:if>
								</xsl:for-each>						
							</fo:table-cell>
							</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>
				</xsl:if>		
					
				<!-- Individual mode sea-->
				<xsl:if test="count(routing_summary[transport_mode='02' and transport_type='01']) > 0">
					<fo:block keep-together="always">
						<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
							<fo:table-column column-width="{$pdfTableWidth}"/>	
							<fo:table-column column-width="0"/> <!--  dummy column -->
							<fo:table-header>
							<fo:table-row>
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"	background-color="{$backgroundSubtitles}" start-indent="20.0pt"
										end-indent="20.0pt" font-weight="bold" font-family="{$pdfFont}">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_SEA')" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							</fo:table-header>
							<fo:table-body>
							<fo:table-row keep-with-previous="always">
							<fo:table-cell>
							<!-- Display each group of transport by sea -->
								<xsl:for-each select="routing_summary[transport_mode='02' and transport_type='01']">
									<xsl:variable name="currentTransportGroup"><xsl:value-of select="transport_group"/></xsl:variable>
									<xsl:if test="count(preceding-sibling::routing_summary[transport_mode='02' and transport_type='01' and transport_group = $currentTransportGroup]) = 0">				
									<fo:block keep-together="always">
									<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
										<fo:table-column column-width="{$pdfTableWidth}"/>	
										<fo:table-column column-width="0"/> <!--  dummy column -->
									<fo:table-body>
										<fo:table-row>
											<fo:table-cell>				
											<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
									      	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
						  				       	<fo:table-column column-width="60.0pt"/>
						  				       	<fo:table-column column-width="proportional-column-width(1)"/>
									        	<fo:table-column column-width="proportional-column-width(1)"/>
									        	<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
													<fo:table-row text-align="center">
													<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
									        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_SUB_TYPE')"/></fo:block></fo:table-cell>
									        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_PORT')"/></fo:block></fo:table-cell>	        			        		
									        		</fo:table-row>
									        	</fo:table-header>
									        	<fo:table-body>
													<!-- Display each port of the group -->					
													<xsl:apply-templates select="../routing_summary[transport_mode='02' and transport_type='01' and transport_group = $currentTransportGroup]"/>
									        	</fo:table-body>
											</fo:table>
										</fo:block>	
										</fo:table-cell>
										</fo:table-row>
										</fo:table-body>
										</fo:table>		
									</fo:block>
									</xsl:if>
								</xsl:for-each>					
							</fo:table-cell>
							</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>		
				</xsl:if>
				
				<!-- Individual mode road-->
				<xsl:if test="count(routing_summary[transport_mode='03' and transport_type='01']) > 0">
					<fo:block keep-together="always">
						<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
							<fo:table-column column-width="{$pdfTableWidth}"/>	
							<fo:table-column column-width="0"/> <!--  dummy column -->
							<fo:table-header>
							<fo:table-row>
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"	background-color="{$backgroundSubtitles}" start-indent="20.0pt"
										end-indent="20.0pt" font-weight="bold" font-family="{$pdfFont}">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD')" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							</fo:table-header>
							<fo:table-body>
							<fo:table-row keep-with-previous="always">
							<fo:table-cell>
							<!-- Display each group of transport by road -->
								<xsl:for-each select="routing_summary[transport_mode='03' and transport_type='01']">
									<xsl:variable name="currentTransportGroup"><xsl:value-of select="transport_group"/></xsl:variable>
									<xsl:if test="count(preceding-sibling::routing_summary[transport_mode='03' and transport_type='01' and transport_group = $currentTransportGroup]) = 0">				
									<fo:block keep-together="always">
									<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
										<fo:table-column column-width="{$pdfTableWidth}"/>	
										<fo:table-column column-width="0"/> <!--  dummy column -->
									<fo:table-body>
										<fo:table-row>
											<fo:table-cell>				
											<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
									      	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
						  				       	<fo:table-column column-width="60.0pt"/>
						  				       	<fo:table-column column-width="proportional-column-width(1)"/>
									        	<fo:table-column column-width="proportional-column-width(1)"/>
									        	<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
													<fo:table-row text-align="center">
													<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
									        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_SUB_TYPE')"/></fo:block></fo:table-cell>
									        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_ROAD_PLACE')"/></fo:block></fo:table-cell>	        			        		
									        		</fo:table-row>
									        	</fo:table-header>
									        	<fo:table-body>
													<!-- Display each road place of the group -->					
													<xsl:apply-templates select="../routing_summary[transport_mode='03' and transport_type='01' and transport_group = $currentTransportGroup]"/>
									        	</fo:table-body>
											</fo:table>
										</fo:block>	
										</fo:table-cell>
										</fo:table-row>
										</fo:table-body>
										</fo:table>		
									</fo:block>
									</xsl:if>
								</xsl:for-each>					
							</fo:table-cell>
							</fo:table-row>					
							</fo:table-body>
						</fo:table>
					</fo:block>		
				</xsl:if>
				
				<!-- Individual mode rail-->
				<xsl:if test="count(routing_summary[transport_mode='04' and transport_type='01']) > 0">
					<fo:block keep-together="always">
						<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
							<fo:table-column column-width="{$pdfTableWidth}"/>	
							<fo:table-column column-width="0"/> <!--  dummy column -->
							<fo:table-header>
							<fo:table-row>
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"	background-color="{$backgroundSubtitles}" start-indent="20.0pt"
										end-indent="20.0pt" font-weight="bold" font-family="{$pdfFont}">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL')" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							</fo:table-header>
							<fo:table-body>
							<fo:table-row keep-with-previous="always">
							<fo:table-cell>
							<!-- Display each group of transport by rail -->
							<xsl:for-each select="routing_summary[transport_mode='04' and transport_type='01']">
								<xsl:variable name="currentTransportGroup"><xsl:value-of select="transport_group"/></xsl:variable>
								<xsl:if test="count(preceding-sibling::routing_summary[transport_mode='04' and transport_type='01' and transport_group = $currentTransportGroup]) = 0">				
								<fo:block keep-together="always">
								<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
									<fo:table-column column-width="{$pdfTableWidth}"/>	
									<fo:table-column column-width="0"/> <!--  dummy column -->
								<fo:table-body>
									<fo:table-row>
										<fo:table-cell>				
										<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
								      	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
					  				       	<fo:table-column column-width="60.0pt"/>
					  				       	<fo:table-column column-width="proportional-column-width(1)"/>
								        	<fo:table-column column-width="proportional-column-width(1)"/>
								        	<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
												<fo:table-row text-align="center">
												<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
								        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_SUB_TYPE')"/></fo:block></fo:table-cell>
								        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_RAIL_PLACE')"/></fo:block></fo:table-cell>	        			        		
								        		</fo:table-row>
								        	</fo:table-header>
								        	<fo:table-body>
												<!-- Display each rail place of the group -->					
												<xsl:apply-templates select="../routing_summary[transport_mode='04' and transport_type='01' and transport_group = $currentTransportGroup]"/>
								        	</fo:table-body>
										</fo:table>
									</fo:block>	
									</fo:table-cell>
									</fo:table-row>
									</fo:table-body>
									</fo:table>		
								</fo:block>
								</xsl:if>
							</xsl:for-each>					
							</fo:table-cell>
							</fo:table-row>					
							</fo:table-body>
						</fo:table>
					</fo:block>		
				</xsl:if>
				
			<!-- Multimodal mode -->
				<!-- Aiports -->
				<xsl:if test="count(routing_summary[transport_mode='01' and transport_type='02']) > 0">
				<fo:block keep-together="always">
					<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
						<fo:table-column column-width="{$pdfTableWidth}"/>		
						<fo:table-column column-width="0"/> <!--  dummy column -->	
						<fo:table-header>
							<fo:table-row>
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"	background-color="{$backgroundSubtitles}" start-indent="20.0pt"
										end-indent="20.0pt" font-weight="bold" font-family="{$pdfFont}">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_AIRPORT')" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-header>
						<fo:table-body>
							<fo:table-row keep-with-previous="always">
							<fo:table-cell>
							<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
						      	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
			  				       	<fo:table-column column-width="40.0pt"/>
			  				       	<fo:table-column column-width="proportional-column-width(1)"/>
						        	<fo:table-column column-width="proportional-column-width(1)"/>
						        	<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
										<fo:table-row text-align="center">
										<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_SUB_TYPE')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_AIRPORT')"/></fo:block></fo:table-cell>       			        		
						        		</fo:table-row>
						        	</fo:table-header>
						        	<fo:table-body>
						        		<!-- Display each aiports -->
										<xsl:apply-templates select="routing_summary[transport_mode='01' and transport_type='02']"/>
						        	</fo:table-body>
								</fo:table>
							</fo:block>
							</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
				</xsl:if>
				
				<!-- Ports -->
				<xsl:if test="count(routing_summary[transport_mode='02' and transport_type='02']) > 0">
				<fo:block keep-together="always">
					<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
						<fo:table-column column-width="{$pdfTableWidth}"/>	
						<fo:table-column column-width="0"/> <!--  dummy column -->		
						<fo:table-header>
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"	background-color="{$backgroundSubtitles}" start-indent="20.0pt"
										end-indent="20.0pt" font-weight="bold" font-family="{$pdfFont}">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_PORT')" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-header>
						<fo:table-body>
							<fo:table-row keep-with-previous="always">
							<fo:table-cell>
							<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
						      	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
			  				       	<fo:table-column column-width="40.0pt"/>
			  				       	<fo:table-column column-width="proportional-column-width(1)"/>
						        	<fo:table-column column-width="proportional-column-width(1)"/>
						        	<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
										<fo:table-row text-align="center">
										<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_SUB_TYPE')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_PORT')"/></fo:block></fo:table-cell>       			        		
						        		</fo:table-row>
						        	</fo:table-header>
						        	<fo:table-body>
						        		<!-- Display each port -->
										<xsl:apply-templates select="routing_summary[transport_mode='02' and transport_type='02']"/>
						        	</fo:table-body>
								</fo:table>
							</fo:block>
							</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
				</xsl:if>
				
				<!-- Places -->
				<xsl:if test="count(routing_summary[transport_mode='' and transport_type='02' and taking_in_charge ='' and place_final_dest='']) > 0">
				<fo:block keep-together="always">
					<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
						<fo:table-column column-width="{$pdfTableWidth}"/>	
						<fo:table-column column-width="0"/> <!--  dummy column -->		
						<fo:table-header>
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"	background-color="{$backgroundSubtitles}" start-indent="20.0pt"
										end-indent="20.0pt" font-weight="bold" font-family="{$pdfFont}">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_PLACE')" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-header>
						<fo:table-body>
							<fo:table-row keep-with-previous="always">
							<fo:table-cell>
							<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
						      	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
			  				       	<fo:table-column column-width="40.0pt"/>
			  				       	<fo:table-column column-width="proportional-column-width(1)"/>
						        	<fo:table-column column-width="proportional-column-width(1)"/>
						        	<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
										<fo:table-row text-align="center">
										<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_SUB_TYPE')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_PLACE')"/></fo:block></fo:table-cell>       			        		
						        		</fo:table-row>
						        	</fo:table-header>
						        	<fo:table-body>
						        		<!-- Display each place -->
										<xsl:apply-templates select="routing_summary[transport_mode='' and transport_type='02' and taking_in_charge ='' and place_final_dest='']"/>
						        	</fo:table-body>
								</fo:table>
							</fo:block>
							</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
				</xsl:if>
				
				<!-- Taking In Charge -->
				<xsl:if test="count(routing_summary[transport_type='02' and taking_in_charge !='']) > 0">
				<fo:block keep-together="always">
					<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
						<fo:table-column column-width="{$pdfTableWidth}"/>	
						<fo:table-column column-width="0"/> <!--  dummy column -->		
						<fo:table-header>
							<fo:table-row>
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"	background-color="{$backgroundSubtitles}" start-indent="20.0pt"
										end-indent="20.0pt" font-weight="bold" font-family="{$pdfFont}">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TAKING_IN_CHARGE')" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-header>
						<fo:table-body>
							<fo:table-row keep-with-previous="always">
							<fo:table-cell>
							<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
						      	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
			  				       	<fo:table-column column-width="40.0pt"/>
			  				       	<fo:table-column column-width="proportional-column-width(1)"/>
						        	<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
										<fo:table-row text-align="center">
										<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_TAKING_IN_CHARGE')"/></fo:block></fo:table-cell>   			        		
						        		</fo:table-row>
						        	</fo:table-header>
						        	<fo:table-body>
						        		<!-- Display each taking in charge -->
										<xsl:apply-templates select="routing_summary[transport_type='02' and taking_in_charge !='']"/>
						        	</fo:table-body>
								</fo:table>
							</fo:block>
							</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
				</xsl:if>
				
				<!-- Place Of Final Destination -->
				<xsl:if test="count(routing_summary[transport_type='02' and place_final_dest !='']) > 0">
				<fo:block keep-together="always">
					<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
						<fo:table-column column-width="{$pdfTableWidth}"/>	
						<fo:table-column column-width="0"/> <!--  dummy column -->		
						<fo:table-header>
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"	background-color="{$backgroundSubtitles}" start-indent="20.0pt"
										end-indent="20.0pt" font-weight="bold" font-family="{$pdfFont}">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_PLACE_FINAL_DEST')" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-header>
						<fo:table-body>
							<fo:table-row keep-with-previous="always">
							<fo:table-cell>
							<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
						      	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
			  				       	<fo:table-column column-width="40.0pt"/>
			  				       	<fo:table-column column-width="proportional-column-width(1)"/>
						        	<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
										<fo:table-row text-align="center">
										<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ROUTING_SUMMARY_PLACE_FINAL_DEST')"/></fo:block></fo:table-cell>   			        		
						        		</fo:table-row>
						        	</fo:table-header>
						        	<fo:table-body>
						        		<!-- Display each place of final dest -->
										<xsl:apply-templates select="routing_summary[transport_type='02' and place_final_dest !='']"/>
						        	</fo:table-body>
								</fo:table>
							</fo:block>
							</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
				</xsl:if>                    
                    </fo:table-cell>
                    </fo:table-row>			
				</fo:table-body>
			</fo:table>
		</fo:block>
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
			<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell>
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
			<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell>
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
			<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell>
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
			<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell>
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
			<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell>
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
			<fo:block keep-together="always">
	     	<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
	         <fo:table-column column-width="{$pdfTableWidth}"/>
	         <fo:table-column column-width="0"/> <!--  dummy column -->
	        <fo:table-header>
	             <fo:table-row>
	                 <fo:table-cell>
	                     <fo:block space-before.optimum="10.0pt"
	                         background-color="{$backgroundTitles}"
	                         color="{$fontColorTitles}" font-weight="bold" font-family="{$pdfFont}">
	                         <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_USER_INFORMATION_DETAILS')"/>
	                     </fo:block>
	                 </fo:table-cell>
	             </fo:table-row>
	            </fo:table-header>
	            <fo:table-body>
	             <fo:table-row keep-with-previous="always">
	             <fo:table-cell>
				<!-- Buyers Informations -->
				<xsl:if test="count(user_defined_information[type='01']) > 0">
					<fo:block keep-together="always">
						<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
							<fo:table-column column-width="{$pdfTableWidth}"/>	
							<fo:table-column column-width="0"/> <!--  dummy column -->
							<fo:table-header>
							<fo:table-row>
								<fo:table-cell number-columns-spanned="2">
									<fo:block space-before.optimum="10.0pt"	background-color="{$backgroundSubtitles}" start-indent="20.0pt"
										end-indent="20.0pt" font-weight="bold" font-family="{$pdfFont}">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_BUYER_INFORMATIONS')" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							</fo:table-header>
							<fo:table-body>
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
											<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
													<fo:table-column column-width="40.0pt"/>
													<fo:table-column column-width="proportional-column-width(1)"/>
													<fo:table-column column-width="proportional-column-width(1)"/>
													<fo:table-header>        			        	
														<fo:table-row text-align="center" font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
															<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
															<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_USER_INFORMATION_LABEL')"/></fo:block></fo:table-cell>
															<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_USER_INFORMATION_INFORMATION')"/></fo:block></fo:table-cell>
														</fo:table-row>
													</fo:table-header>
													<fo:table-body>  		        		
														<!-- Display each contact -->
														<xsl:apply-templates select="user_defined_information[type = '01']"/>
													</fo:table-body>
											</fo:table>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>						
							</fo:table-body>						
						</fo:table>
					</fo:block>			
				</xsl:if>
					
				<!-- Sellers informations -->
				<xsl:if test="count(user_defined_information[type='02']) > 0">		             
					<fo:block keep-together="always">
						<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
							<fo:table-column column-width="{$pdfTableWidth}"/>	
							<fo:table-column column-width="0"/> <!--  dummy column -->
							<fo:table-header>
							<fo:table-row>
								<fo:table-cell number-columns-spanned="2">
									<fo:block space-before.optimum="10.0pt"	background-color="{$backgroundSubtitles}" start-indent="20.0pt"
										end-indent="20.0pt" font-weight="bold" font-family="{$pdfFont}">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_SELLER_INFORMATIONS')" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							</fo:table-header>
							<fo:table-body>
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
											<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
													<fo:table-column column-width="40.0pt"/>
													<fo:table-column column-width="proportional-column-width(1)"/>
													<fo:table-column column-width="proportional-column-width(1)"/>
													<fo:table-header>        			        	
														<fo:table-row text-align="center" font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
															<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
															<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_USER_INFORMATION_LABEL')"/></fo:block></fo:table-cell>
															<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_USER_INFORMATION_INFORMATION')"/></fo:block></fo:table-cell>
														</fo:table-row>
													</fo:table-header>
													<fo:table-body>  		        		
														<!-- Display each contact -->
														<xsl:apply-templates select="user_defined_information[type = '02']"/>
													</fo:table-body>
											</fo:table>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>						
							</fo:table-body>	
						</fo:table>
					</fo:block>			
				</xsl:if>	             
	             	
	             </fo:table-cell>
	             </fo:table-row>
	           </fo:table-body>
	         </fo:table>
	     	 </fo:block>
     	 </xsl:if>	
	</xsl:template>
	
	<!-- User Informations template -->
	<xsl:template match="user_defined_information[type = '01' or type = '02' ]">
		<fo:table-row keep-with-previous="always">
		<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
		<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
	      	<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
				<xsl:value-of select="label"/>				
			</fo:block>
		</fo:table-cell>
      	<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
	      	<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
				<xsl:value-of select="information"/>
			</fo:block>
		</fo:table-cell>	        			        		
      	</fo:table-row>	
	</xsl:template>
	
	<!-- Contacts template (Header) -->
	<xsl:template match="contacts">
		<xsl:if test="count(contact) > 0">
			<fo:block keep-together="always">
                <fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
                    <fo:table-column column-width="{$labelColumnWidth}"/>
                    <fo:table-column column-width="{$detailsColumnWidth}"/>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell number-columns-spanned="2">
                                <fo:block space-before.optimum="10.0pt"
                                    background-color="{$backgroundTitles}"
                                    color="{$fontColorTitles}" font-weight="bold" font-family="{$pdfFont}">
                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONTACT_PERSON_DETAILS')"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
					  	<fo:table-row keep-with-previous="always">
							<fo:table-cell>				
								<fo:block white-space-collapse="false">
									<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
									  <fo:table-column column-width="{$labelColumnWidth}"/>
									  <fo:table-column column-width="{$detailsColumnWidth}"/>
										 <fo:table-body>
										 <fo:table-row>
										 <fo:table-cell>
											<fo:block space-before.optimum="10.0pt" white-space-collapse="true"> 
												<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
												<fo:table-column column-width="40.0pt"/>
													<fo:table-column column-width="proportional-column-width(1)"/>
													<fo:table-column column-width="proportional-column-width(1)"/>
													<fo:table-header>        			        	
														<fo:table-row text-align="center" font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
															<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
															<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_CONTACT_PERSON_TYPE')"/></fo:block></fo:table-cell>
															<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_CONTACT_PERSON_ROLE')"/></fo:block></fo:table-cell>
														</fo:table-row>
													</fo:table-header>
													<fo:table-body>  		        		
														<!-- Display each contact -->
														<xsl:apply-templates select="contact"/>
													</fo:table-body>
												</fo:table>
											</fo:block>                            
											</fo:table-cell>
										</fo:table-row>
										</fo:table-body>
									</fo:table>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>                        
					</fo:table-body>
				</fo:table>  
             </fo:block>
		</xsl:if>    		
	</xsl:template>
	
	<!-- Contact template -->
	<xsl:template match="contact">		
		<fo:table-row keep-with-previous="always">
		<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
      	<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
	      	<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
				<xsl:value-of select="localization:getDecode($language, 'N200', type)"/>
			</fo:block>
		</fo:table-cell>
      	<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
	      	<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
      		<xsl:value-of select="localization:getDecode($language, 'N204', name_prefix)"/>&nbsp;<xsl:value-of select="name"/>
      	</fo:block>
      	</fo:table-cell>
		<!--fo:table-cell><fo:block><xsl:value-of select="role"/></fo:block></fo:table-cell-->	      	        			        		
      	</fo:table-row>	
	</xsl:template>
	
	<!-- Line items template -->
	<xsl:template match="line_items">
	<fo:block keep-together="always">
			<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
				<fo:table-column column-width="{$pdfTableWidth}"/>	
				<fo:table-column column-width="0"/> <!--  dummy column -->		
				<fo:table-header>
					<fo:table-row>
						<fo:table-cell>
							<fo:block space-before.optimum="10.0pt"	background-color="{$backgroundSubtitles}" start-indent="20.0pt"
								end-indent="20.0pt" font-weight="bold" font-family="{$pdfFont}">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINE_ITEMS')" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<fo:table-body>
					<fo:table-row>
					<fo:table-cell>
					<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
				      	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
	  				       	<fo:table-column column-width="40.0pt"/>
	  				       	<fo:table-column column-width="proportional-column-width(2)"/>
				        	<fo:table-column column-width="proportional-column-width(2)"/>
				        	<fo:table-column column-width="proportional-column-width(2)"/>
				        	<fo:table-column column-width="proportional-column-width(1)"/>
				        	<fo:table-column column-width="proportional-column-width(2)"/>
				        	<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
								<fo:table-row text-align="center">
								<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
				        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_LINE_ITEM_NUMBER')"/></fo:block></fo:table-cell>
				        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_LINE_ITEM_PRODUCT')"/></fo:block></fo:table-cell>
				        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_LINE_ITEM_QUANTITY')"/></fo:block></fo:table-cell>	        			        		
				        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_LINE_ITEM_CUR_CODE')"/></fo:block></fo:table-cell>
				        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_LINE_ITEM_NET_AMOUNT')"/></fo:block></fo:table-cell>			        						        		
				        		</fo:table-row>
				        	</fo:table-header>
				        	<fo:table-body>
				        		<!-- Display each line item -->
								<xsl:apply-templates select="lt_tnx_record"/>
				        	</fo:table-body>
						</fo:table>
					</fo:block>
					</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
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
		
		<fo:table-row>
			<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 
			<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
				<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
					<xsl:value-of select="cust_ref_id"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
				<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
					<xsl:value-of select="$product_decode"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
				<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
					<xsl:value-of select="$quantity_decode"/>
				</fo:block>
			</fo:table-cell>
			 <fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
				<fo:block text-align="center" padding-top="1.0pt" padding-bottom=".5pt">
				<xsl:value-of select="total_net_cur_code"/>
			</fo:block>
			</fo:table-cell>
			<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
				<fo:block text-align="right" padding-top="1.0pt" padding-bottom=".5pt">
					<xsl:value-of select="total_net_amt"/>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>		
			
	</xsl:template>

</xsl:stylesheet>