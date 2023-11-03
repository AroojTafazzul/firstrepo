<?xml version="1.0" encoding="UTF-8"?>
<!--
   Copyright (c) 2000-2012 Misys
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
	<xsl:import href="ip_repayment_fo.xsl" />
	<xsl:import href="ip_collection_fo.xsl" />

    <xsl:variable name="isdynamiclogo">
        <xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
    </xsl:variable>
  	
	
    <xsl:template match="ip_tnx_record">
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
 <xsl:choose>
	<xsl:when test="sub_tnx_type_code[.='A4']">
		<xsl:call-template name="repayment" />
	</xsl:when>
	<xsl:when test="tnx_type_code[.='85']">
		<xsl:call-template name="settlement" />
	</xsl:when>
 	<xsl:otherwise>
    <fo:flow flow-name="xsl-region-body" font-size="{$pdfFontSize}">
            <xsl:choose>
                <xsl:when test="tnx_type_code[.='15'] or tnx_type_code[.='03'] or tnx_type_code[.='13'] or (finance_requested_flag[.='Y' or .='P'] and tnx_type_code[.='63'])">
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
                        
                        <xsl:if test=".!sub_tnx_type_code or (sub_tnx_type_code[.!='72'] and sub_tnx_type_code[.!='73'])">
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
                        <xsl:if test="iss_date[.!='']">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_INVOICE_DATE')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="iss_date"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <xsl:if test="due_date[.!='']">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_DUE_DATE')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="due_date"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                       
                        <xsl:if test=".!sub_tnx_type_code or (sub_tnx_type_code[.='72'] or sub_tnx_type_code[.='73'])">                          
	         				<xsl:if test="total_net_amt[.!='']">
	                            <fo:table-row keep-with-previous="always">
	                                <fo:table-cell>
	                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
	                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IN_INVOICE_AMOUNT')"/>
	                                    </fo:block>
	                                </fo:table-cell>
	                                <fo:table-cell>
	                                    <fo:block font-weight="bold">
	                                       <xsl:value-of select="total_net_cur_code"/> <xsl:value-of select="total_net_amt"/>
	                                    </fo:block>
	                                </fo:table-cell>
	                            </fo:table-row>
	                        </xsl:if>
	                        <xsl:if test="prod_stat_code[.!='']">
	                          <fo:table-row keep-with-previous="always">
	                                <fo:table-cell>
	                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
	                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_PROD_STAT_LABEL')"/>
	                                    </fo:block>
	                                </fo:table-cell>
	                                <fo:table-cell>
	                                    <fo:block font-weight="bold">
	                                       <xsl:value-of select="localization:getDecode($language, 'N005', prod_stat_code[.])" />
	                                    </fo:block>
	                                </fo:table-cell>
	                            </fo:table-row>
							</xsl:if>  
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
	                                    <fo:block background-color="{$backgroundSubtitles}" end-indent="20.0pt" font-family="{$pdfFont}" font-weight="bold" space-after.optimum="10.0pt" space-before.optimum="10.0pt" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BUYER_DETAILS')"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<xsl:if test="buyer_name[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
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
											<xsl:value-of select="buyer_street_name"/>
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
						</fo:table-body>
					</fo:table>
				</fo:block>
				<!-- FSCM Programme Detail -->
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
							<xsl:if test="seller_reference[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="utils:decryptApplicantReference(seller_reference)"/>
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
									<fo:block background-color="{$backgroundSubtitles}" end-indent="20.0pt" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SELLER_DETAILS')"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<xsl:if test="seller_name[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold" space-before.optimum="10.0pt">
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
											<xsl:value-of select="seller_street_name"/>
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

			<xsl:if test="sub_tnx_type_code and (sub_tnx_type_code[.='72'] or sub_tnx_type_code[.='73'])">
				<fo:block keep-together="always">
                	<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
                    <fo:table-column column-width="{$labelColumnWidth}"/>
                    <fo:table-column column-width="{$detailsColumnWidth}"/>
                    <fo:table-body>
                    	<fo:table-row>
							<fo:table-cell number-columns-spanned="2">
								<fo:block> </fo:block>	
							</fo:table-cell>
						</fo:table-row>
                   		<fo:table-row>
           					<fo:table-cell number-columns-spanned="2">
                    			<fo:block background-color="{$backgroundTitles}" color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt">
                        			<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREE_FORMAT')"/>
                        		</fo:block>
                     		</fo:table-cell>
             			</fo:table-row>
             			<xsl:if test="free_format_text != ''">
					 		<fo:table-row keep-with-previous="always">	
		                     	<fo:table-cell>
	                        		<fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
		                            	<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREE_FORMAT')"/>
	                            	</fo:block>
		                        </fo:table-cell>
	                        	<fo:table-cell>
		                        	<fo:block font-weight="bold" space-before.optimum="10.0pt">
	                            	 	<xsl:value-of select="free_format_text"/>
	                            	</fo:block>
		                        </fo:table-cell>
                			</fo:table-row>
						</xsl:if>
                   	</fo:table-body> 
	                </fo:table>
		        </fo:block>  
	       </xsl:if> 
			<!--Bill To Details-->
			<xsl:if test="bill_to_name[.!='']">
			<fo:block keep-together="always">
				<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
					<fo:table-column column-width="{$labelColumnWidth}"/>
					<fo:table-column column-width="{$detailsColumnWidth}"/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell number-columns-spanned="2">
								<fo:block background-color="{$backgroundSubtitles}" end-indent="20.0pt" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt" start-indent="20.0pt">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BILL_TO_DETAILS')"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
									</fo:block>

								</fo:table-cell>
							</fo:table-row>	                        
	                    </fo:table-body>
                	</fo:table>
            	</fo:block>
            </xsl:if>
            
			<xsl:if test=".!sub_tnx_type_code or (sub_tnx_type_code[.!='72'] and sub_tnx_type_code[.!='73'])">
				<!--Narrative Details-->
				<fo:block keep-together="always">
	                <fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
	                    <fo:table-column column-width="{$labelColumnWidth}"/>
	                    <fo:table-column column-width="{$detailsColumnWidth}"/>
	                    <fo:table-body>
	                        <fo:table-row>
	                            <fo:table-cell number-columns-spanned="2">
	                                <fo:block background-color="{$backgroundTitles}" color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt">
	                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DESCRIPTION_GOODS')"/>
	                                </fo:block>
	                            </fo:table-cell>
	                        </fo:table-row>
	                        
	                        <fo:table-row keep-with-previous="always">
	                            <fo:table-cell>
	                                <fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
	                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_GOODS_DESC')"/>
	                                </fo:block>
	                            </fo:table-cell>
	                            <fo:table-cell>
	                                <fo:block font-weight="bold" space-before.optimum="10.0pt">
	                                    <xsl:value-of select="narrative_description_goods"/>
	                                </fo:block>
	                            </fo:table-cell>
	                        </fo:table-row>
							<xsl:if test="total_cur_code[.!='']">
	                            <fo:table-row keep-with-previous="always">
	                                <fo:table-cell>
	                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
	                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_CURRENCY_CODE')"/>
	                                    </fo:block>
	                                </fo:table-cell>
	                                <fo:table-cell>
	                                    <fo:block font-weight="bold">
	                                        <xsl:value-of select="total_cur_code"/>
	                                    </fo:block>
	                                </fo:table-cell>
	                            </fo:table-row>
	                        </xsl:if>
	                        <xsl:if test="total_amt[.!=''] and sub_product_code [.='SMP']">
	                            <fo:table-row keep-with-previous="always">
	                                <fo:table-cell>
	                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
	                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_PO_FACE_VALUE')"/>
	                                    </fo:block>
	                                </fo:table-cell>
	                                <fo:table-cell>
	                                    <fo:block font-weight="bold">
	                                        <xsl:value-of select="face_total_cur_code"/> <xsl:value-of select="total_amt"/>
	                                    </fo:block>
	                                </fo:table-cell>
	                            </fo:table-row>
	                        </xsl:if>
	                        <xsl:if test="total_adjustments[.!='']">
	                            <fo:table-row keep-with-previous="always">
	                                <fo:table-cell>
	                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
	                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_INVOICE_ADJUSTMENT_VALUE')"/>
	                                    </fo:block>
	                                </fo:table-cell>
	                                <fo:table-cell>
	                                    <fo:block font-weight="bold">
	                                        <xsl:value-of select="adjustment_cur_code"/> <xsl:value-of select="total_adjustments"/>
	                                    </fo:block>
	                                </fo:table-cell>
	                            </fo:table-row>
	                        </xsl:if>
	                        <xsl:if test="adjustment_direction[.!=''] and total_adjustments[.!='']">
	                            <fo:table-row keep-with-previous="always">
	                                <fo:table-cell>
	                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
	                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADJUSTMENT_DIRECTION')"/>
	                                    </fo:block>
	                                </fo:table-cell>
	                                <fo:table-cell>
	                                    <fo:block font-weight="bold">
	                                        <xsl:value-of select="localization:getDecode($language, 'N216', adjustment_direction)"/>
	                                    </fo:block>
	                                </fo:table-cell>
	                            </fo:table-row>
	                        </xsl:if>
	                        <xsl:if test="total_net_amt[.!='']">
	                            <fo:table-row keep-with-previous="always">
	                                <fo:table-cell>
	                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
	                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_PO_TOTAL_NET_AMT_LABEL')"/>
	                                    </fo:block>
	                                </fo:table-cell>
	                                <fo:table-cell>
	                                    <fo:block font-weight="bold">
	                                       <xsl:value-of select="total_net_cur_code"/> <xsl:value-of select="total_net_amt"/>
	                                    </fo:block>
	                                </fo:table-cell>
	                            </fo:table-row>
	                        </xsl:if>
		                  </fo:table-body> 
		                </fo:table>
			        </fo:block>  
	        
				<!--Bill To Details-->
				<xsl:if test="bill_to_name[.!='']">
				<fo:block keep-together="always">
					<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
						<fo:table-column column-width="{$labelColumnWidth}"/>
						<fo:table-column column-width="{$detailsColumnWidth}"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell number-columns-spanned="2">
									<fo:block background-color="{$backgroundSubtitles}" end-indent="20.0pt" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BILL_TO_DETAILS')"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold" space-before.optimum="10.0pt">
											<xsl:value-of select="bill_to_name"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							
							<xsl:if test="bill_to_bei[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="bill_to_bei"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
							<xsl:if test="bill_to_street_name[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="bill_to_street_name"/>
												<xsl:call-template name="zero_width_space_1">
														<xsl:with-param name="data" select="bill_to_street_name"/>
												</xsl:call-template>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
							<xsl:if test="bill_to_post_code[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="bill_to_post_code"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
							<xsl:if test="bill_to_town_name[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="bill_to_town_name"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
							<xsl:if test="bill_to_country_sub_div[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="bill_to_country_sub_div"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
							<xsl:if test="bill_to_country[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="bill_to_country"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
						</fo:table-body>
					</fo:table>
				</fo:block>
				</xsl:if>
				<!--Ship To Details-->
				<xsl:if test="ship_to_name[.!='']">
				<fo:block keep-together="always">
					<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
						<fo:table-column column-width="{$labelColumnWidth}"/>
						<fo:table-column column-width="{$detailsColumnWidth}"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell number-columns-spanned="2">
									<fo:block background-color="{$backgroundSubtitles}" end-indent="20.0pt" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SHIP_TO_DETAILS')"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold" space-before.optimum="10.0pt">
											<xsl:value-of select="ship_to_name"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							
							<xsl:if test="ship_to_bei[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="ship_to_bei"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
							<xsl:if test="ship_to_street_name[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="ship_to_street_name"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
							<xsl:if test="ship_to_post_code[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="ship_to_post_code"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
							<xsl:if test="ship_to_town_name[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="ship_to_town_name"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
							<xsl:if test="ship_to_country_sub_div[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="ship_to_country_sub_div"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
							<xsl:if test="ship_to_country[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="ship_to_country"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
						</fo:table-body>
					</fo:table>
				</fo:block>				
				</xsl:if>
				<!--Consignee To Details-->
				<xsl:if test="consgn_name[.!='']">
				<fo:block keep-together="always">
					<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
						<fo:table-column column-width="{$labelColumnWidth}"/>
						<fo:table-column column-width="{$detailsColumnWidth}"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell number-columns-spanned="2">
									<fo:block background-color="{$backgroundSubtitles}" end-indent="20.0pt" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONSIGNEE_DETAILS')"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold" space-before.optimum="10.0pt">
											<xsl:value-of select="consgn_name"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							
							<xsl:if test="consgn_bei[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="consgn_bei"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
							<xsl:if test="consgn_street_name[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="consgn_street_name"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
							<xsl:if test="consgn_post_code[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="consgn_post_code"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
							<xsl:if test="consgn_town_name[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="consgn_town_name"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
							<xsl:if test="consgn_country_sub_div[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="consgn_country_sub_div"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
							<xsl:if test="consgn_country[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="consgn_country"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
						</fo:table-body>
					</fo:table>
				</fo:block>			
				</xsl:if>			          
				<fo:block> </fo:block>	
				<!--Descripton of Goods Details-->
					<xsl:if test="count(line_items/lt_tnx_record) != 0 or goods_desc[.!='']">
						<fo:block keep-together="always">
							<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
								<fo:table-column column-width="{$labelColumnWidth}"/>
								<fo:table-column column-width="{$detailsColumnWidth}"/>
								<fo:table-body>
									<fo:table-row>
										<fo:table-cell number-columns-spanned="2">
											<fo:block background-color="{$backgroundTitles}" color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DESCRIPTION_GOODS')"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell number-columns-spanned="2">
											<fo:block> </fo:block>	
										</fo:table-cell>
									</fo:table-row>
									<xsl:if test="goods_desc[.!='']">
			                         <fo:table-row keep-with-previous="always">
			                             <fo:table-cell>
			                                 <fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
			                                     <xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_GOODS_DESC')"/>
			                                 </fo:block>
			                             </fo:table-cell>
			                             <fo:table-cell>
			                                 <fo:block font-weight="bold" space-before.optimum="10.0pt">
			                                 	<xsl:call-template name="zero_width_space_1">
													<xsl:with-param name="data" select="goods_desc"/>
												</xsl:call-template>
			                                 </fo:block>
			                             </fo:table-cell>
			                         </fo:table-row>
			                         </xsl:if>						
								</fo:table-body>
							</fo:table>
			            <!-- Display line items -->
			            <xsl:apply-templates select="line_items"/>					
						</fo:block>	
					</xsl:if>
				<fo:block> </fo:block>	

		    <xsl:if test="sub_product_code != 'SMP'">	
	     	<fo:block keep-together="always">          
	          <fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
	          	<fo:table-column column-width="{$labelColumnWidth}"/>
	            <fo:table-column column-width="{$detailsColumnWidth}"/>
	             	<fo:table-body>			
				         <!-- Total Goods Amount -->
	                  <fo:table-row keep-with-previous="always">
	                  	<fo:table-cell>
	                     	<fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
	                      		<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL')"/>
	                  		</fo:block>
	              			</fo:table-cell>
	              			<fo:table-cell>
	                  		<fo:block font-weight="bold" space-before.optimum="10.0pt">
	                      		<xsl:value-of select="total_cur_code"/> <xsl:value-of select="total_amt"/>
	                  		</fo:block>
	              			</fo:table-cell>
	            		</fo:table-row>
	            		<!-- <xsl:if test="liab_total_amt[.!='']">
	    						<fo:table-row keep-with-previous="always">
	                       <fo:table-cell>
	                        <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
	                       		<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_AMT_LABEL')"/>
	                        </fo:block>
	                       </fo:table-cell>
	                       <fo:table-cell>
	                       	<fo:block font-weight="bold">
	                       		<xsl:value-of select="liab_total_cur_code"/>&nbsp;<xsl:value-of select="liab_total_amt"/>
	                        </fo:block>
	                      </fo:table-cell>
	                  	</fo:table-row> 
	                  </xsl:if>  -->
						</fo:table-body>
					</fo:table>             	
	         </fo:block>	      	
	         </xsl:if>
			<fo:block> </fo:block>		         
	         <!--Amount Details-->
	         <xsl:if test= "sub_product_code != 'SMP'"> 
			 <fo:block keep-together="always">
			 <!-- <xsl:if test="$section_amount_details != 'N'"> -->
	          <fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
	          	<fo:table-column column-width="{$labelColumnWidth}"/>
	            <fo:table-column column-width="{$detailsColumnWidth}"/>
	             	<fo:table-body>
	               	<fo:table-row>
	                  	<fo:table-cell number-columns-spanned="2">
	                          <fo:block background-color="{$backgroundTitles}" color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt">
	                              <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_DETAILS')"/>
	                          </fo:block>
	                     </fo:table-cell>
	                </fo:table-row>
	                <fo:table-row>
	                  	<fo:table-cell number-columns-spanned="2">
	                          <fo:block> </fo:block>
	                     </fo:table-cell>
	                </fo:table-row>
				  	<fo:table-row keep-with-previous="always" space-before.optimum="10.0pt">
						<fo:table-cell number-columns-spanned="2">
							<!-- Adjustments Details -->
	                         	<xsl:if test="count(adjustments/adjustment) != 0">
				                	<xsl:apply-templates select="adjustments">
				                		<xsl:with-param name="isSubItem">Y</xsl:with-param>
				                	</xsl:apply-templates>
				                </xsl:if>   
				                <!-- Taxes Details -->
				                <xsl:if test="count(taxes/tax) != 0">
				                	<xsl:apply-templates select="taxes">
				                		<xsl:with-param name="isSubItem">Y</xsl:with-param>
				                	</xsl:apply-templates>
				                </xsl:if>
				                <!-- Freight Charges Details -->
				                <xsl:if test="count(freightCharges/freightCharge) != 0">
				                	<xsl:apply-templates select="freightCharges">
				                		<xsl:with-param name="isSubItem">Y</xsl:with-param>
				                	</xsl:apply-templates>
				                </xsl:if>
							<!-- Total Net Amount -->
							<fo:block white-space-collapse="false">
							   <fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
								   <fo:table-column column-width="{$labelColumnWidth}"/>
								   <fo:table-column column-width="{$detailsColumnWidth}"/>
								   <fo:table-body>
	                               <fo:table-row keep-with-previous="always">
	                               	<fo:table-cell>
	                                  	<fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
	                                   		<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_PO_TOTAL_NET_AMT_LABEL')"/>
	                               		</fo:block>
	                           			</fo:table-cell>
	                           			<fo:table-cell>
	                               		<fo:block font-weight="bold" space-before.optimum="10.0pt">
	                                   		<xsl:value-of select="total_net_cur_code"/> <xsl:value-of select="total_net_amt"/>
	                               		</fo:block>
	                           			</fo:table-cell>
	                         		</fo:table-row>
	                         		<xsl:if test="liab_total_net_amt[.!='']">
	                 						<fo:table-row keep-with-previous="always">
	                                    <fo:table-cell>
	                                     <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
	                                    		<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_NET_AMT_LABEL')"/>
	                                     </fo:block>
	                                    </fo:table-cell>
	                                    <fo:table-cell>
	                                    	<fo:block font-weight="bold">
	                                    		<xsl:value-of select="liab_total_net_cur_code"/> <xsl:value-of select="liab_total_net_amt"/>
	                                     </fo:block>
	                                   </fo:table-cell>
	                               	</fo:table-row> 
	                               </xsl:if>                         
									  </fo:table-body>
								  </fo:table>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					 <fo:table-row>
	                  	<fo:table-cell number-columns-spanned="2">
	                          <fo:block> </fo:block>
	                     </fo:table-cell>
	                </fo:table-row>                        
					</fo:table-body>
				</fo:table>
	        </fo:block>
			</xsl:if>  
	
	                     
				<!-- Payment Terms -->
			<fo:block id="paymenttermsdetails"/>
			<xsl:if test="count(payments/payment) &gt; 0">
				<xsl:apply-templates select="payments"/>
			</xsl:if>
				  
				<!-- Settlement Terms Details -->
				<xsl:if test="seller_account_type[.!=''] or fin_inst_name[.!=''] or fin_inst_bic[.!='']">			  
	              <fo:block keep-together="always">
	                  <fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
	                      <fo:table-column column-width="{$labelColumnWidth}"/>
	                      <fo:table-column column-width="{$detailsColumnWidth}"/>
	                      <fo:table-body>
	                          <fo:table-row>
	                              <fo:table-cell number-columns-spanned="2">
	                                  <fo:block background-color="{$backgroundTitles}" color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt">
	                                  <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SETTLEMENT_TERMS_DETAILS')"/>
	                                  </fo:block>
	                              </fo:table-cell>
	                         </fo:table-row>
	                      </fo:table-body>
	                   </fo:table>
	              </fo:block>              
			</xsl:if>             	
					<!-- Seller Account -->
					<xsl:if test="seller_account_iban[.!=''] or  seller_account_bban[.!=''] or  seller_account_upic[.!=''] or  seller_account_id[.!='']">
					
					<fo:block keep-together="always">
						<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
							<fo:table-column column-width="{$labelColumnWidth}"/>
							<fo:table-column column-width="{$detailsColumnWidth}"/>
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell number-columns-spanned="2">
										<fo:block background-color="{$backgroundSubtitles}" end-indent="20.0pt" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_SELLER_ACCOUNT')"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<xsl:if test="seller_account_iban[.!=''] or seller_account_bban[.!=''] or seller_account_upic[.!=''] or seller_account_id[.!='']">
									<fo:table-row keep-with-previous="always">
										<fo:table-cell>
											<fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE')"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block font-weight="bold" space-before.optimum="10.0pt">
											<xsl:choose>
												<xsl:when test="seller_account_iban[.!='']">
													<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN')"/>
												</xsl:when>
												<xsl:when test="seller_account_bban[.!='']">
													<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_BBAN')"/>
												</xsl:when>
												<xsl:when test="seller_account_upic[.!='']">
													<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_UPIC')"/>
												</xsl:when>
												<xsl:when test="seller_account_id[.!='']">
													<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_OTHER')"/>
												</xsl:when>
											</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:if>
								<xsl:if test="seller_account_name[.!='']">
									<fo:table-row keep-with-previous="always">
										<fo:table-cell>
											<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>															
											<fo:block font-weight="bold">
	                                    <xsl:value-of select="seller_account_name"/>
	                                  </fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:if> 						
								<xsl:if test="seller_account_iban[.!=''] or seller_account_bban[.!=''] or seller_account_upic[.!=''] or seller_account_id[.!='']">
									<fo:table-row keep-with-previous="always">
										<fo:table-cell>
											<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_SELLER_ACCOUNT_NUMBER')"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block font-weight="bold">
											<xsl:choose>
												<xsl:when test="seller_account_iban[.!='']">
	                                        <xsl:value-of select="seller_account_iban"/>
	                                      </xsl:when>
												<xsl:when test="seller_account_bban[.!='']">
	                                        <xsl:value-of select="seller_account_bban"/>
	                                      </xsl:when>
												<xsl:when test="seller_account_upic[.!='']">
	                                        <xsl:value-of select="seller_account_upic"/>
	                                      </xsl:when>
												<xsl:when test="seller_account_id[.!='']">
	                                        <xsl:value-of select="seller_account_id"/>
	                                      </xsl:when>
											</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:if> 
							</fo:table-body>
						</fo:table>
					</fo:block>  
					</xsl:if>               
	
					<!-- Financial institution -->
					<xsl:if test="fin_inst_name[.!=''] or fin_inst_bic[.!='']">
					<fo:block keep-together="always">
						<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
							<fo:table-column column-width="{$labelColumnWidth}"/>
							<fo:table-column column-width="{$detailsColumnWidth}"/>
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell number-columns-spanned="2">
										<fo:block background-color="{$backgroundSubtitles}" end-indent="20.0pt" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_FINANCIAL_INSTITUTION')"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<xsl:if test="fin_inst_name[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold" space-before.optimum="10.0pt">
											<xsl:value-of select="fin_inst_name"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								</xsl:if>
								<xsl:if test="fin_inst_bic[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BIC_CODE')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="fin_inst_bic"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								</xsl:if>
								<xsl:if test="fin_inst_street_name[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="fin_inst_street_name"/>
												<xsl:call-template name="zero_width_space_1">
													<xsl:with-param name="data" select="fin_inst_street_name"/>
												</xsl:call-template>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								</xsl:if>
								<xsl:if test="fin_inst_post_code[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="fin_inst_post_code"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								</xsl:if>
								<xsl:if test="fin_inst_town_name[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="fin_inst_town_name"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								</xsl:if>
								<xsl:if test="fin_inst_country_sub_div[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="fin_inst_country_sub_div"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								</xsl:if>							
								<xsl:if test="fin_inst_country[.!='']">
								<fo:table-row keep-with-previous="always">
									<fo:table-cell>
										<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="bold">
											<xsl:value-of select="fin_inst_country"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								</xsl:if>																																																			
							</fo:table-body>
						</fo:table>
					</fo:block>
					</xsl:if>
				
	            <!-- Bank Details -->
	            <fo:block white-space-collapse="false">
	                <fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
	                    <fo:table-column column-width="{$labelColumnWidth}"/>
	                    <fo:table-column column-width="{$detailsColumnWidth}"/>
	                    <fo:table-body>
	                        <fo:table-row>
	                            <fo:table-cell number-columns-spanned="2">
	                                <fo:block background-color="{$backgroundTitles}" color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt">
	                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BANK_DETAILS')"/>
	                                </fo:block>
	                            </fo:table-cell>
	                        </fo:table-row>
													
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
	                                                   <xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$buyer_ref]/description"/>
	                                            </xsl:when>
	                                            <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$buyer_ref]) = 0 or count(//*/avail_main_banks/bank/entity/customer_reference) = 0">
	                                                   <xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$buyer_ref]/description"/>
	                                            </xsl:when>
	                                    	</xsl:choose>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if> 						
							<!-- <xsl:if test="advising_bank/name[.!='']">
								<xsl:apply-templates select="advising_bank">
									<xsl:with-param name="theNodeName" select="'advising_bank'"/>
									<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ADVISING_BANK')"/>
	                       		</xsl:apply-templates>
							</xsl:if> -->
									
	   							<!-- <fo:table-row keep-with-previous="always">
	   								<fo:table-cell number-columns-spanned="2">
	   									<fo:block background-color="{$backgroundSubtitles}"
	   										font-family="{$pdfFont}" font-weight="bold"
	   										start-indent="20.0pt" space-before.optimum="10.0pt" end-indent="20.0pt">
	   										<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_BUYER_BANK')"/>
	   									</fo:block>
	   								</fo:table-cell>
	   							</fo:table-row>
	   							<fo:table-row keep-with-previous="always">
	   								<fo:table-cell>
	   									<fo:block font-family="{$pdfFont}" start-indent="20.0pt" space-before.optimum="10.0pt">
	   										<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_LABEL')"/>
	   									</fo:block>
	   								</fo:table-cell>
	   								<fo:table-cell>
	   									<fo:block font-weight="bold" space-before.optimum="10.0pt">
	   											<xsl:choose>
	   												<xsl:when test="buyer_bank_type_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_ISSUING')"/></xsl:when>
	   												<xsl:when test="buyer_bank_type_code[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_ADVISING')"/></xsl:when>
	   												<xsl:otherwise/>
	   											</xsl:choose>
	   									</fo:block>
	   								</fo:table-cell>
	   							</fo:table-row>
							
	   							<fo:table-row keep-with-previous="always">
	   								<fo:table-cell number-columns-spanned="2">
	   									<fo:block background-color="{$backgroundSubtitles}"
	   										font-family="{$pdfFont}" font-weight="bold"
	   										start-indent="20.0pt" space-before.optimum="10.0pt" end-indent="20.0pt">
	   										<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_SELLER_BANK')"/>
	   									</fo:block>
	   								</fo:table-cell>
	   							</fo:table-row>
	   							<fo:table-row keep-with-previous="always">
	   								<fo:table-cell>
	   									<fo:block font-family="{$pdfFont}" start-indent="20.0pt" space-before.optimum="10.0pt">
	   										<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_LABEL')"/>
	   									</fo:block>
	   								</fo:table-cell>
	   								<fo:table-cell>
	   									<fo:block font-weight="bold" space-before.optimum="10.0pt">
	   											<xsl:choose>
	   												<xsl:when test="seller_bank_type_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_ISSUING')"/></xsl:when>
	   												<xsl:when test="seller_bank_type_code[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_ADVISING')"/></xsl:when>
	   												<xsl:otherwise/>
	   											</xsl:choose>
	   									</fo:block>
	   								</fo:table-cell>
	   							</fo:table-row> -->
									
	                    </fo:table-body>
	                </fo:table>
	            </fo:block>
	            
	            <!-- Credit Note Invoices Details -->
            	<xsl:call-template name="credit_note_invoices_details"/>
		
				<!-- Documents Required - This is not used ? --> 
	             <!-- <fo:block white-space-collapse="false">
	                  <fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
	                      <fo:table-column column-width="{$labelColumnWidth}"/>
	                      <fo:table-column column-width="{$detailsColumnWidth}"/>
	                      <fo:table-body>
	                          <fo:table-row>
	                              <fo:table-cell number-columns-spanned="2">
	                                  <fo:block space-before.optimum="10.0pt"
	                                  background-color="{$backgroundTitles}"
	                                  color="{$fontColorTitles}" font-weight="bold" font-family="{$pdfFont}">
	                                  <xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED')"/>
	                                  </fo:block>
	                              </fo:table-cell>
	                         </fo:table-row>
							<xsl:if test="reqrd_commercial_dataset[.!='']">                         
							<fo:table-row keep-with-previous="always">
	                            <fo:table-cell>
	                                <fo:block font-family="{$pdfFont}"
	                                    start-indent="20.0pt" space-before.optimum="10.0pt">
	                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_COMMERCIAL_DATASET')"/>
	                                </fo:block>
	                            </fo:table-cell>
	                            <fo:table-cell>
	                                <fo:block font-weight="bold" space-before.optimum="10.0pt">
										<xsl:choose>
											<xsl:when test="reqrd_commercial_dataset[.='Y']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_COMMERCIAL_DATASET_REQUIRED')"/></xsl:when>
											<xsl:when test="reqrd_commercial_dataset[.='N']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_COMMERCIAL_DATASET_NOT_REQUIRED')"/></xsl:when>
											<xsl:otherwise/>
										</xsl:choose>
	                                </fo:block>
	                            </fo:table-cell>
	                        </fo:table-row>
	                        </xsl:if>
							<xsl:if test="reqrd_transport_dataset[.!='']">
							<fo:table-row keep-with-previous="always">
	                            <fo:table-cell>
	                                <fo:block font-family="{$pdfFont}"
	                                    start-indent="20.0pt">
	                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_TRANSPORT_DATASET')"/>
	                                </fo:block>
	                            </fo:table-cell>
	                            <fo:table-cell>
	                                <fo:block font-weight="bold">
										<xsl:choose>
											<xsl:when test="reqrd_transport_dataset[.='Y']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_TRANSPORT_DATASET_REQUIRED')"/></xsl:when>
											<xsl:when test="reqrd_transport_dataset[.='N']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_TRANSPORT_DATASET_NOT_REQUIRED')"/></xsl:when>
										</xsl:choose>
	                                </fo:block>
	                            </fo:table-cell>
	                        </fo:table-row>						
							</xsl:if>
							<xsl:if test="last_match_date[.!='']">
							<fo:table-row keep-with-previous="always">
	                            <fo:table-cell>
	                                <fo:block font-family="{$pdfFont}"
	                                    start-indent="20.0pt" space-before.optimum="10.0pt">
	                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_LAST_MATCH_DATE')"/>
	                                </fo:block>
	                            </fo:table-cell>
	                            <fo:table-cell>
	                                <fo:block font-weight="bold" space-before.optimum="10.0pt">
										<xsl:value-of select="last_match_date"/>
	                                </fo:block>
	                            </fo:table-cell>
	                        </fo:table-row>						
							
							</xsl:if>						                                            
	                        </fo:table-body>
	                      </fo:table>
	                  </fo:block> -->
					<xsl:if test="part_ship[.!=''] or part_ship[.!=''] or last_ship_date[.!='']">
					 <fo:block white-space-collapse="false">
	                  <fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
	                      <fo:table-column column-width="{$labelColumnWidth}"/>
	                      <fo:table-column column-width="{$detailsColumnWidth}"/>
	                      <fo:table-body>
	                          <fo:table-row>
	                              <fo:table-cell number-columns-spanned="2">
	                                  <fo:block background-color="{$backgroundTitles}" color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt">
	                                  <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SHIPMENT_DETAILS')"/>
	                                  </fo:block>
	                              </fo:table-cell>
	                         </fo:table-row>
							<xsl:if test="part_ship[.!='']">                         
							<fo:table-row keep-with-previous="always">
	                            <fo:table-cell>
	                                <fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
	                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_LABEL')"/>
	                                </fo:block>
	                            </fo:table-cell>
	                            <fo:table-cell>
	                                <fo:block font-weight="bold" space-before.optimum="10.0pt">
										<xsl:choose>
											<xsl:when test="part_ship[.='Y']">
	                            <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/>
	                          </xsl:when>
											<xsl:when test="part_ship[.='N']">
	                            <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/>
	                          </xsl:when>
											<xsl:otherwise/>
										</xsl:choose>
	                                </fo:block>
	                            </fo:table-cell>
	                        </fo:table-row>
	                        </xsl:if>
							<xsl:if test="tran_ship[.!='']">
							<fo:table-row keep-with-previous="always">
	                            <fo:table-cell>
	                                <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
	                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL')"/>
	                                </fo:block>
	                            </fo:table-cell>
	                            <fo:table-cell>
	                                <fo:block font-weight="bold">
										<xsl:choose>
											<xsl:when test="tran_ship[.='Y']">
	                            <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/>
	                          </xsl:when>
											<xsl:when test="tran_ship[.='N']">
	                            <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/>
	                          </xsl:when>
											<xsl:otherwise/>
										</xsl:choose>
	                                </fo:block>
	                            </fo:table-cell>
	                        </fo:table-row>						
							</xsl:if>
							<xsl:if test="last_ship_date[.!='']">
							<fo:table-row keep-with-previous="always">
	                            <fo:table-cell>
	                                <fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
	                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_LAST_SHIP_DATE')"/>
	                                </fo:block>
	                            </fo:table-cell>
	                            <fo:table-cell>
	                                <fo:block font-weight="bold" space-before.optimum="10.0pt">
										<xsl:value-of select="last_ship_date"/>
	                                </fo:block>
	                            </fo:table-cell>
	                        </fo:table-row>						
							
							</xsl:if>						                                            
	                        </fo:table-body>
	                      </fo:table>
	                  </fo:block>
					  </xsl:if>
					  			
					<!-- Inco Terms Details -->
					<xsl:apply-templates select="incoterms"/>
					
					<!-- Routing Summary Details -->
					<xsl:apply-templates select="routing_summaries"/>
												 	               
					<!-- <fo:block keep-together="always">
						<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
							<fo:table-column column-width="{$labelColumnWidth}"/>
							<fo:table-column column-width="{$detailsColumnWidth}"/>
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell number-columns-spanned="2">
										<fo:block space-before.optimum="10.0pt"	background-color="{$backgroundSubtitles}" start-indent="20.0pt"
											end-indent="20.0pt" font-weight="bold" font-family="{$pdfFont}">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_SELLER_ACCOUNT')"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block> -->
		</xsl:if>
				<!-- Users Informations Details -->             			     		  
			  	<xsl:apply-templates select="user_defined_informations"/>	
			  	
				<!-- Contact Person Details -->
				<xsl:apply-templates select="contacts"/>								  		  
			                                          

            <xsl:element name="fo:block">
                <xsl:attribute name="font-size">1pt</xsl:attribute>
                <xsl:attribute name="id">
                    <xsl:value-of select="concat('LastPage_',../@section)"/>
                </xsl:attribute>
            </xsl:element>
        </fo:flow>
 	 </xsl:otherwise>
  </xsl:choose>
  </xsl:template>
  <xsl:template name="footer">
    <fo:static-content flow-name="xsl-region-after">
			<fo:block font-family="{$pdfFont}" font-size="8.0pt" keep-together="always">
				<!-- Page number -->
				<fo:block color="{$footerFontColor}" font-weight="bold" text-align="start">
					<!-- <xsl:value-of select="localization:getGTPString($language, 'XSL_FO_PAGE')" />&nbsp; -->
					<fo:page-number/> /
					<!-- &nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_FO_OF')" />&nbsp; -->
					<fo:page-number-citation>
						<xsl:attribute name="ref-id">
                                        <xsl:value-of select="concat('LastPage_',../@section)"/>
                                        </xsl:attribute>
					</fo:page-number-citation>
				</fo:block>
				<fo:block color="{$footerFontColor}" text-align="start">
					<xsl:attribute name="end-indent">
	                                 	<xsl:value-of select="number($pdfMargin)"/>pt
	                                 </xsl:attribute>
					<xsl:value-of select="convertTools:internalDateToStringDate($systemDate,$language)"/>
				</fo:block>
			</fo:block>
		</fo:static-content>
  </xsl:template>
</xsl:stylesheet>
