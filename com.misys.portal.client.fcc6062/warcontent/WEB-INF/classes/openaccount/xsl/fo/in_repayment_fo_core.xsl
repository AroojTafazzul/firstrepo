<?xml version="1.0" encoding="UTF-8"?>
<!--
   Copyright (c) 2000-2017 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" 
				xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
				xmlns:fo="http://www.w3.org/1999/XSL/Format" 
				xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="utils" 
				version="1.0">
    
	<xsl:import href="po_fo_common_new.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>

    <xsl:variable name="isdynamiclogo">
        <xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
    </xsl:variable>
    

  <xsl:template name="repayment">
   <fo:flow flow-name="xsl-region-body" font-size="{$pdfFontSize}">
            <xsl:choose>
                <xsl:when test="tnx_type_code[.='15'] or tnx_type_code[.='03'] or tnx_type_code[.='13']">
                    <xsl:call-template name="product_summary"/>
                    <fo:block break-after="page"/>
                    <xsl:call-template name="disclaimer"/>
                </xsl:when>
                <!--Insert the Disclaimer Notice-->
                <xsl:when test="not(tnx_id) or tnx_type_code[.!='01']">
                    <xsl:call-template name="disclaimer"/>
                </xsl:when>
                <!--Insert the transaction summary-->
                <xsl:otherwise>
                    <xsl:call-template name="product_summary"/>
                    <fo:block break-after="page"/>
                </xsl:otherwise>
            </xsl:choose>
            <fo:block keep-together="always">
                <fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
                    <fo:table-column column-width="{$labelColumnWidth}"/>
                    <fo:table-column column-width="{$detailsColumnWidth}"/>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell number-columns-spanned="2">
                                <fo:block background-color="{$backgroundTitles}" color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt">
                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row keep-with-previous="always">
                            <fo:table-cell>
                                <fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block font-weight="bold" space-before.optimum="10.0pt">
                                    <xsl:value-of select="ref_id"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <!-- customer ref id -->
                        <xsl:if test="cust_ref_id[. != '']">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="cust_ref_id"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <xsl:if test="issuer_ref_id[. != '']">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_INVOICE_REFERENCE')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="issuer_ref_id"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <xsl:if test="bulk_ref_id[. != '']">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_BK_REF_ID')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="bulk_ref_id"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <!-- bo_ref_id -->
                        <xsl:if test="bo_ref_id[.!=''] and (not(tnx_id) or tnx_type_code[.!='01'] or preallocated_flag[.='Y'])">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="bo_ref_id"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <!-- fin_bo_ref_id -->
                        <xsl:if test="bo_ref_id[.!=''] and (not(tnx_id) or tnx_type_code[.!='01'] or preallocated_flag[.='Y'])">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_FIN_BO_REF_ID')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="fin_bo_ref_id"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <!-- bo_template_id -->
                        <xsl:if test="template_id[.!='']">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TEMPLATE_ID')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="template_id"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <!--application Date -->
                        <fo:table-row keep-with-previous="always">
                            <fo:table-cell>
                                <fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block font-weight="bold" space-before.optimum="10.0pt">
                                    <xsl:value-of select="appl_date"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                         <xsl:if test="fin_date[.!='']">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_FINANCE_ISSUE_DATE')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="fin_date"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>    
                         <xsl:if test="fin_due_date[.!='']">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_FINANCE_DUE_DATE')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="fin_due_date"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <xsl:if test="exp_date[.!='']">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_DATE')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="exp_date"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <xsl:if test="expiry_place[.!='']">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_PLACE')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="expiry_place"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <xsl:if test="po_ref_id[.!='']">
                          <fo:table-row keep-with-previous="always">
                            <fo:table-cell>
                              <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_PO_REF_ID')"/>
                              </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                              <fo:block font-weight="bold">
                                <xsl:value-of select="po_ref_id"/>
                              </fo:block>
                            </fo:table-cell>
                          </fo:table-row>
                        </xsl:if>
                        <xsl:if test="amd_no[.!='']">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_AMD_COUNT')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="amd_no"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
						<xsl:if test="finance_amt[.!='']">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IN_FINANCE_AMOUNT')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="finance_cur_code"/> <xsl:value-of select="finance_amt"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                    </fo:table-body>
                </fo:table>
            </fo:block>
            
			<!-- Seller Details -->
                <fo:block keep-together="always">
                    <fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
                        <fo:table-column column-width="{$labelColumnWidth}"/>
                        <fo:table-column column-width="{$detailsColumnWidth}"/>
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell number-columns-spanned="2">
                                    <fo:block background-color="{$backgroundSubtitles}" end-indent="20.0pt" font-family="{$pdfFont}" font-weight="bold" space-after.optimum="10.0pt" space-before.optimum="10.0pt" start-indent="20.0pt">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SELLER_DETAILS')"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<!-- Display Entities -->
						<xsl:if test="entity[.!='']">
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ENTITY')"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold" space-before.optimum="10.0pt">
										<xsl:value-of select="entity"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
			   			</xsl:if>
						<xsl:if test="seller_name[.!='']">
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">
										<xsl:value-of select="seller_name"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
						<xsl:if test="seller_bei[.!='']">
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">
										<xsl:value-of select="seller_bei"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
						<xsl:if test="seller_street_name[.!='']">
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">
<!-- 										<xsl:value-of select="seller_street_name"/> -->
											<xsl:call-template name="zero_width_space_1">
									<xsl:with-param name="data" select="seller_street_name"/>
								</xsl:call-template>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
						<xsl:if test="seller_post_code[.!='']">
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">
										<xsl:value-of select="seller_post_code"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
						<xsl:if test="seller_town_name[.!='']">
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">
										<xsl:value-of select="seller_town_name"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
						<xsl:if test="seller_country_sub_div[.!='']">
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">
										<xsl:value-of select="seller_country_sub_div"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
						<xsl:if test="seller_country[.!='']">
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">
										<xsl:value-of select="seller_country"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
					</fo:table-body>
				</fo:table>
			</fo:block>
			
			<fo:block keep-together="always">
				<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
					<fo:table-column column-width="{$labelColumnWidth}"/>
					<fo:table-column column-width="{$detailsColumnWidth}"/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell number-columns-spanned="2">
								<fo:block background-color="{$backgroundSubtitles}" end-indent="20.0pt" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt" start-indent="20.0pt">
									<xsl:value-of select="localization:getGTPString($language, 'TABLE_HEADER_PROGRAMME')"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<xsl:if test="fscm_programme_code[.!='']">
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_PROGRAM')"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">
										<xsl:for-each select="fscm_programme_code">
									    	<xsl:if test="self::node()[text()= '03']">
										    	<xsl:value-of select="localization:getDecode($language, 'N084', '03')"/>
										  	 </xsl:if>
										  	 <xsl:if test="self::node()[text()= '05']">
										    	<xsl:value-of select="localization:getDecode($language, 'N084', '05')"/>
										  	 </xsl:if>
									   </xsl:for-each>
									   <xsl:value-of select="fscm_programme_code"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
					</fo:table-body>
				</fo:table>	
			</fo:block>	
						
			
            
			<!-- Buyer Details -->
			<fo:block keep-together="always">
				<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
					<fo:table-column column-width="{$labelColumnWidth}"/>
					<fo:table-column column-width="{$detailsColumnWidth}"/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell number-columns-spanned="2">
								<fo:block background-color="{$backgroundSubtitles}" end-indent="20.0pt" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt" start-indent="20.0pt">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BUYER_DETAILS')"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<xsl:if test="buyer_name[.!='']">
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold" space-before.optimum="10.0pt">
										<xsl:value-of select="buyer_name"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
						<xsl:if test="buyer_bei[.!='']">
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">
										<xsl:value-of select="buyer_bei"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
						<xsl:if test="buyer_street_name[.!='']">
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">
<!-- 										<xsl:value-of select="buyer_street_name"/> -->
											<xsl:call-template name="zero_width_space_1">
												<xsl:with-param name="data" select="buyer_street_name"/>
											</xsl:call-template>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
						<xsl:if test="buyer_post_code[.!='']">
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">
										<xsl:value-of select="buyer_post_code"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
						<xsl:if test="buyer_town_name[.!='']">
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">
										<xsl:value-of select="buyer_town_name"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
						<xsl:if test="buyer_country_sub_div[.!='']">
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">
										<xsl:value-of select="buyer_country_sub_div"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
						<xsl:if test="buyer_country[.!='']">
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">
										<xsl:value-of select="buyer_country"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
					</fo:table-body>
				</fo:table>
			</fo:block>	
			<fo:block> </fo:block>
			<!--Repayment Details-->
			<fo:block keep-together="always">
                <fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
                    <fo:table-column column-width="{$labelColumnWidth}"/>
                    <fo:table-column column-width="{$detailsColumnWidth}"/>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell number-columns-spanned="2">
                                <fo:block background-color="{$backgroundTitles}" color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt">
                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCE_REPAYMENT_DETAILS')"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        
                        <fo:table-row keep-with-previous="always">
                            <fo:table-cell>
                                <fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCE_REPAYMENT_ACTION')"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block font-weight="bold" space-before.optimum="10.0pt">
                                    <xsl:value-of select="localization:getCodeData($language,'*','*','C078' , finance_repayment_action)"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
					 <xsl:if test="outstanding_repayment_amt[.!='']">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_OUTSTANDING_REPAYMENT')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="outstanding_repayment_cur_code"/> <xsl:value-of select="outstanding_repayment_amt"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                      </xsl:if>
                      <xsl:if test="finance_repayment_amt[.!='']">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_REPAYMENT_AMOUNT')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="finance_repayment_cur_code"/> <xsl:value-of select="finance_repayment_amt"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                      </xsl:if> 
					  <xsl:if test="interest_repayment_amt[.!='']">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_INTEREST_REPAYMENT')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="interest_repayment_cur_code"/> <xsl:value-of select="interest_repayment_amt"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
					  <xsl:if test="charges_repayment_amt[.!='']">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGES_REPAYMENT')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="charges_repayment_cur_code"/> <xsl:value-of select="charges_repayment_amt"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
					  <xsl:if test="total_repaid_amt[.!='']">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_TOTAL_REPAID_AMT')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="total_repaid_cur_code"/> <xsl:value-of select="total_repaid_amt"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>                             
	                  </fo:table-body> 
	                </fo:table>
		        </fo:block>  
		          
			<fo:block> </fo:block>	      
        <xsl:call-template name="exchange-rate-details"/> 
        <xsl:if test="free_format_text[.!='']">         
	   		<fo:block keep-together="always">
	                <fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
	                    <fo:table-column column-width="{$labelColumnWidth}"/>
	                    <fo:table-column column-width="{$detailsColumnWidth}"/>                    
		                    <fo:table-body>		                   
		                        <fo:table-row>
		                            <fo:table-cell number-columns-spanned="2">
		                                <fo:block background-color="{$backgroundTitles}" color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt">
		                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_FOR_THE_BANK')"/>
		                                </fo:block>
		                            </fo:table-cell>
		                        </fo:table-row>
		                        <fo:table-row keep-with-previous="always">
		                            <fo:table-cell>
		                                <fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
		                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_FOR_THE_BANK')"/>
		                                </fo:block>
		                            </fo:table-cell>
		                            <fo:table-cell>
		                                <fo:block font-weight="bold" space-before.optimum="10.0pt">
		                                    <xsl:value-of select="free_format_text"/>
		                                </fo:block>
		                            </fo:table-cell>
		                        </fo:table-row>		                   
		                    </fo:table-body>                    
	                   </fo:table>
	         </fo:block>
          </xsl:if>
        <xsl:if test="bo_comment[.!='']">         
	   		<fo:block keep-together="always">
	                <fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
	                    <fo:table-column column-width="{$labelColumnWidth}"/>
	                    <fo:table-column column-width="{$detailsColumnWidth}"/>                    
		                    <fo:table-body>		                   
		                        <fo:table-row>
		                            <fo:table-cell number-columns-spanned="2">
		                                <fo:block background-color="{$backgroundTitles}" color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt">
		                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_FROM_THE_BANK')"/>
		                                </fo:block>
		                            </fo:table-cell>
		                        </fo:table-row>
		                        <fo:table-row keep-with-previous="always">
		                            <fo:table-cell>
		                                <fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
		                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_FROM_THE_BANK')"/>
		                                </fo:block>
		                            </fo:table-cell>
		                            <fo:table-cell>
		                                <fo:block font-weight="bold" space-before.optimum="10.0pt">
		                                    <xsl:value-of select="bo_comment"/>
		                                </fo:block>
		                            </fo:table-cell>
		                        </fo:table-row>		                   
		                    </fo:table-body>                    
	                   </fo:table>
	         </fo:block>
          </xsl:if>           
	  		  
			
            <xsl:element name="fo:block">
                <xsl:attribute name="font-size">1pt</xsl:attribute>
                <xsl:attribute name="id">
                    <xsl:value-of select="concat('LastPage_',../@section)"/>
                </xsl:attribute>
            </xsl:element>
        </fo:flow> 
  </xsl:template>
 
</xsl:stylesheet>
