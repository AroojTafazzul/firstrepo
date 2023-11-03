<?xml version="1.0" encoding="UTF-8"?>
<!--
		Copyright (c) 2000-2004 Misys (http://www.Misys.com), All
		Rights Reserved.
	-->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:localization="xalan://com.misys.portal.common.localization.Localization" xmlns:utils="xalan://com.misys.portal.common.tools.Utils" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>
	<xsl:variable name="background">
		BLACK
	</xsl:variable>

	<xsl:template match="cr_tnx_record">
		<!-- HEADER-->
		
		<!-- FOOTER-->
		
		<!-- BODY-->
		
	<xsl:call-template name="header"/>
    <xsl:call-template name="footer"/>
    <xsl:call-template name="body"/>
  </xsl:template>
<xsl:template name="header">
    <fo:static-content flow-name="xsl-region-before">
			<xsl:call-template name="header_issuing_bank"/>
		</fo:static-content>
  </xsl:template>
  <xsl:template name="body">
    <fo:flow flow-name="xsl-region-body" font-size="{$pdfFontSize}">
			<xsl:call-template name="disclammer_template"/>

			<fo:block id="gendetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ref_id"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="cn_reference[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CN_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="cn_reference"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- customer ref id -->
					<xsl:if test="cust_ref_id[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="cust_ref_id"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- bo_ref_id -->
					<xsl:if test="bo_ref_id[.!=''] and (not(tnx_id) or tnx_type_code[.!='01'] or preallocated_flag[.='Y'])">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bo_ref_id"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- bo_template_id -->
					<xsl:if test="template_id[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TEMPLATE_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="template_id"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!--application Date -->
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="appl_date"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- Issued Stand by LC type details -->
					
					<xsl:if test="iss_date[.!=''] and (not(tnx_id) or tnx_type_code[.!='01'])">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ISSUE_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="iss_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="exp_date[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="exp_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>					
					</xsl:with-param>
				</xsl:call-template>
			
				<!--Buyer Details-->
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BUYER_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						
						<!-- Display Entities -->
						<xsl:if test="entity[.!='']">
						<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ENTITY')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
                        <xsl:value-of select="entity"/>
                        </xsl:with-param>
						</xsl:call-template>
			   			</xsl:if>
			   			
						<xsl:if test="buyer_name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="buyer_name"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Address -->
						<xsl:if test="buyer_bei[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="buyer_bei"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="buyer_street_name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="buyer_street_name"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="buyer_post_code[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="buyer_post_code"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="buyer_town_name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="buyer_town_name"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="buyer_country_sub_div[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="buyer_country_sub_div"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="buyer_country[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="buyer_country"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- commented as part of MPS-39538  -->
						<!-- <xsl:if test="buyer_reference[.!='']">
							<xsl:variable name="buyer_ref">
              <xsl:value-of select="buyer_reference"/>
            </xsl:variable>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$buyer_ref]) &gt;= 1">
									      	<xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$buyer_ref]/description"/>
									     </xsl:when>
									     <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$buyer_ref]) = 0">
									     	<xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$buyer_ref]/description"/>
									     </xsl:when>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if> -->	
					</xsl:with-param>
				</xsl:call-template>
				
				<!-- FSCM Programme Code -->
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PROGRAMME_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="//program_name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_PROGRAM')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="//program_name"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			
						
				<!--Seller Details-->
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SELLER_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="seller_name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="seller_name"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Address -->
						<xsl:if test="seller_bei[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="seller_bei"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="seller_street_name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="seller_street_name"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="seller_post_code[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="seller_post_code"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="seller_town_name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="seller_town_name"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="seller_country_sub_div[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="seller_country_sub_div"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="seller_country[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="seller_country"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- commented as part of MPS-39538  -->
						<!-- <xsl:if test="seller_reference[.!='']">
							<xsl:variable name="seller_ref">
              <xsl:value-of select="seller_reference"/>
            </xsl:variable>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$seller_ref]) &gt;= 1">
									      	<xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$seller_ref]/description"/>
									     </xsl:when>
									     <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$seller_ref]) = 0">
									     	<xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$seller_ref]/description"/>
									     </xsl:when>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if> -->	
					</xsl:with-param>
				</xsl:call-template>
			<!--Amount Details-->
			<fo:block id="amountdetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CN_AMOUNT')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="cn_cur_code"/> 
							<xsl:value-of select="cn_amt"/>
						</xsl:with-param>
					</xsl:call-template>					
				</xsl:with-param>
			</xsl:call-template>		
				
			<!--Bank Details-->
			<fo:block id="bankdetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BANK_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:apply-templates select="issuing_bank">
						<xsl:with-param name="theNodeName" select="'issuing_bank'"/>
						<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ISSUING_BANK')"/>
					</xsl:apply-templates>
					<xsl:if test="buyer_reference[.!='']">
							<xsl:variable name="buyer_ref"><xsl:value-of select="buyer_reference" /></xsl:variable>
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" start-indent="40.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CUST_REFERENCE')"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">
										<xsl:choose>
                                            <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$buyer_ref]) >= 1 or count(//*/avail_main_banks/bank/entity/customer_reference) >= 1">
                                                   <xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference/description"/>
                                            </xsl:when>
                                            <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$buyer_ref]) = 0 or count(//*/avail_main_banks/bank/entity/customer_reference) = 0">
                                                   <xsl:value-of select="//*/avail_main_banks/bank/customer_reference/description"/>
                                            </xsl:when>
                                    	</xsl:choose>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:if test="invoice-items/invoice">
			<fo:block keep-together="always">
			<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
				<fo:table-column column-width="{$pdfTableWidth}"/>		
				<fo:table-column column-width="0" /> <!--  dummy column -->	
				<fo:table-header>
					<fo:table-row>
						<fo:table-cell>
							<fo:block background-color="{$backgroundSubtitles}" end-indent="20.0pt" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt" start-indent="20.0pt">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_INVOICE_ITEMS')"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<fo:table-body>
					<fo:table-row>
					<fo:table-cell>
					<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
				      	<fo:table font-family="{$pdfFontData}" table-layout="fixed" width="{$pdfNestedTableWidth}">
	  				       	<fo:table-column column-width="40.0pt"/>
	  				       	<fo:table-column column-width="proportional-column-width(2)"/>
				        	<fo:table-column column-width="proportional-column-width(2)"/>
				        	<fo:table-column column-width="proportional-column-width(2)"/>
				        	<fo:table-column column-width="proportional-column-width(1)"/>
				        	<fo:table-column column-width="proportional-column-width(2)"/>
				        	<fo:table-header color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold">
								<fo:table-row text-align="center">
								<fo:table-cell>
                            <fo:block> </fo:block>
                          </fo:table-cell> 	
				        		<fo:table-cell>
                            <fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt">
                              <xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>
                            </fo:block>
                          </fo:table-cell>
				        		<fo:table-cell>
                            <fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt">
                              <xsl:value-of select="localization:getGTPString($language, 'INVOICE_REFERENCE_LABEL')"/>
                            </fo:block>
                          </fo:table-cell>
                          <fo:table-cell>
                            <fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt">
                              <xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/>
                            </fo:block>
                          </fo:table-cell>
                          <fo:table-cell>
                            <fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt">
                              <xsl:value-of select="localization:getGTPString($language, 'INVOICE_AMOUNT')"/>
                            </fo:block>
                          </fo:table-cell>
				        		<fo:table-cell>
                            <fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt">
                              <xsl:value-of select="localization:getGTPString($language, 'CREDIT_NOTE_AMOUNT')"/>
                            </fo:block>
                          </fo:table-cell>
				        		</fo:table-row>
				        	</fo:table-header>
				        	<fo:table-body>
				        		
					        		<xsl:for-each select="invoice-items/invoice">
					        		<fo:table-row>
										<fo:table-cell>
                              <fo:block> </fo:block>
                            </fo:table-cell> 
										<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
											<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="left">
												<xsl:value-of select="invoice_ref_id"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
											<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="left">
												<xsl:value-of select="invoice_reference"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
											<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="left">
												<xsl:value-of select="invoice_currency"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
											<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="left">
												<xsl:value-of select="invoice_amount"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
											<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="left">
												<xsl:value-of select="invoice_settlement_amt"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
						         </xsl:for-each>
				        	</fo:table-body>
						</fo:table>
					</fo:block>
					</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
		</xsl:if>
		
		<xsl:if test="free_format_text/text[.!='']">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREE_FORMAT')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:apply-templates select="free_format_text">
						<xsl:with-param name="theNodeName" select="'free_format_text'"/>
						<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_HEADER_SELLER_BANK_MESSAGE')"/>
					</xsl:apply-templates>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
			
			<xsl:element name="fo:block">
				<xsl:attribute name="font-size">1pt</xsl:attribute>
				<xsl:attribute name="id">
	                   <xsl:value-of select="concat('LastPage_',../@section)"/>
	               </xsl:attribute>
			</xsl:element>
		</fo:flow>
  </xsl:template>
  <xsl:template name="footer">
    <fo:static-content flow-name="xsl-region-after">
			<fo:block font-family="{$pdfFont}" font-size="8.0pt" keep-together="always">
				<!-- Page number -->
				<fo:block color="#00aeef" font-weight="bold" text-align="start">
					<!-- <xsl:value-of select="localization:getGTPString($language, 'XSL_FO_PAGE')" />&nbsp; -->
					<fo:page-number/> /
					<!-- &nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_FO_OF')" />&nbsp; -->
					<fo:page-number-citation>
						<xsl:attribute name="ref-id">
                                        <xsl:value-of select="concat('LastPage_',../@section)"/>
                                        </xsl:attribute>
					</fo:page-number-citation>
				</fo:block>
				<fo:block color="#00aeef" text-align="start">
					<xsl:attribute name="end-indent">
	                                 	<xsl:value-of select="number($pdfMargin)"/>pt
	                                 </xsl:attribute>
					<xsl:value-of select="convertTools:internalDateToStringDate($systemDate,$language)"/>
				</fo:block>
			</fo:block>
		</fo:static-content>
  </xsl:template>
</xsl:stylesheet>
