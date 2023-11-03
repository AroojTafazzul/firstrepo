<?xml version="1.0" encoding="UTF-8"?>
<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" 
				xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
				xmlns:fo="http://www.w3.org/1999/XSL/Format" 
				xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
				xmlns:loaniq="xalan://com.misys.portal.loan.loaniq.LoanIQAdapter" 
				xmlns:java="http://xml.apache.org/xalan/java"
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils" 
				xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
 				xmlns:user="xalan://com.misys.portal.security.GTPUser" 
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
     <xsl:param name="optionCode">OTHERS</xsl:param>
    <xsl:param name="reviewandprint">false</xsl:param>
    <xsl:variable name="isdynamiclogo">
        <xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
    </xsl:variable>
    
    <xsl:template match="bk_tnx_record">
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
							<xsl:value-of select="utils:decryptApplicantReference(ref_id)"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_LOAN_BORROWER_REFERENCE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="utils:decryptApplicantReference(loan_list/loan/loan_borrower_reference)"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_DETAILS_DEAL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="loan_list/loan/loan_deal_name"/>
						</xsl:with-param>
					</xsl:call-template>
												
					<xsl:if test="loan_list/loan/entity[.!= '']">	
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_DETAILS_ENTITY')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="loan_list/loan/entity"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="appl_date[.!='']">
                    	<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="appl_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>					
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BANK_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
                     <!--bank name -->
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="issuing_bank/abbv_name"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- borrower refernce -->
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_LOAN_BORROWER_REFERENCE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="utils:decryptApplicantReference(loan_list/loan/loan_borrower_reference)"/>
						</xsl:with-param>
					</xsl:call-template>
			   </xsl:with-param>
			</xsl:call-template>
	        
    
			<!-- linked-loan-details -->
			<xsl:if test="loan_list">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LOAN_REPRICED')"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<fo:block white-space-collapse="false">
					<fo:table font-family="{$pdfFont}" start-indent="2pt" width="{$pdfTableWidth}">
						<!-- <fo:table-column column-width="9%"/>
						<fo:table-column column-width="9%"/>
						<fo:table-column column-width="8%"/>
						<fo:table-column column-width="12%"/>
						<fo:table-column column-width="10%"/>
						<fo:table-column column-width="8%"/>
						<fo:table-column column-width="10%"/>
						<fo:table-column column-width="10%"/>
						<fo:table-column column-width="7%"/>
						<fo:table-column column-width="10%"/>
						<fo:table-column column-width="10%"/>
						<fo:table-column column-width="8%"/> -->
						<!-- HEADER -->
						<xsl:variable name="colWidth">9%</xsl:variable>
						<fo:table-header color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold">
							<fo:table-row text-align="center">
<!-- 								<fo:table-cell border-style="solid" border-width=".25pt"> -->
<!-- 									<fo:block text-align="center"> -->
<!-- 										<xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/> -->
<!-- 									</fo:block> -->
<!-- 								</fo:table-cell> -->
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:call-template name="zero_width_space_1">
										    <xsl:with-param name="data"><xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/></xsl:with-param>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:call-template name="zero_width_space_1">
										    <xsl:with-param name="data"><xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_FAC_NAME')"/></xsl:with-param>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
								
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:call-template name="zero_width_space_1">
										    <xsl:with-param name="data"><xsl:value-of select="localization:getGTPString($language, 'LN_FACILITY_CURRENCY')"/></xsl:with-param>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
								
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:call-template name="zero_width_space_1">
										    <xsl:with-param name="data"><xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_BO_REF')"/></xsl:with-param>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
								
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:value-of select="localization:getGTPString($language, 'CUST_REFERENCE')"/>
									</fo:block>
								</fo:table-cell>
								
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:call-template name="zero_width_space_1">
										    <xsl:with-param name="data"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPRICING_LOAN_PRICING_OPTION')"/></xsl:with-param>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:call-template name="zero_width_space_1">
										    <xsl:with-param name="data"><xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_CCY')"/></xsl:with-param>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:call-template name="zero_width_space_1">
										    <xsl:with-param name="data"><xsl:value-of select="localization:getGTPString($language, 'CURRENT_OUTSTANDING_AMT')"/></xsl:with-param>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>		
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:call-template name="zero_width_space_1">
										    <xsl:with-param name="data"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LN_FX_RATE')"/></xsl:with-param>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>	
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:call-template name="zero_width_space_1">
										    <xsl:with-param name="data"><xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_EFFECTIVE_DATE')"/></xsl:with-param>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>		
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:call-template name="zero_width_space_1">
										    <xsl:with-param name="data"><xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_REPRICING_FREQUENCY')"/></xsl:with-param>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>			
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:call-template name="zero_width_space_1">
										    <xsl:with-param name="data"><xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_REPRICING_DATE')"/></xsl:with-param>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>							
							</fo:table-row>
						</fo:table-header>

						<!-- BODY -->
						<fo:table-body start-indent="2pt">
							<xsl:for-each select="loan_list/loan">
								<fo:table-row text-align="center">
<!-- 									<fo:table-cell border-style="solid" border-width=".25pt"> -->
<!-- 										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center"> -->
<!-- 											<xsl:value-of select="./loan_ref_id"/> -->
<!-- 										</fo:block> -->
<!-- 									</fo:table-cell> -->
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="./loan_ref_id"/></xsl:with-param>
											</xsl:call-template>
										</fo:block>
									</fo:table-cell>
																		
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="./loan_facility_name"/></xsl:with-param>
											</xsl:call-template>
										</fo:block>
									</fo:table-cell>
									
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="./loan_ccy"/></xsl:with-param>
											</xsl:call-template>
										</fo:block>
									</fo:table-cell>
									
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="./loan_bo_ref"/></xsl:with-param>
											</xsl:call-template>
										</fo:block>
									</fo:table-cell>
									
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="./loan_cust_ref_id"/></xsl:with-param>
											</xsl:call-template>
										</fo:block>
									</fo:table-cell>
									
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="localization:getCodeData($language,'**','LN','C030', ./loan_pricing_option)" /></xsl:with-param>
											</xsl:call-template>
										</fo:block>
									</fo:table-cell>								

									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="./loan_ccy"/></xsl:with-param>
											</xsl:call-template>
										</fo:block>
									</fo:table-cell>

									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data">
											    	<xsl:value-of select="loaniq:getFormatedAmount(./loan_outstanding_amt, ./loan_ccy, $language)"/>
											    </xsl:with-param>
											</xsl:call-template>
										</fo:block>
									</fo:table-cell>
									
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="loaniq:formatFXConversionRateValues(./fx_conversion_rate,$language)"/></xsl:with-param>
											</xsl:call-template>
										</fo:block>
									</fo:table-cell>
									
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:value-of select="./loan_effective_date"/>
										</fo:block>
									</fo:table-cell>									
									
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:value-of select="concat(translate(./loan_repricing_frequency,'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ','') ,' ', localization:getDecode($language, 'C031', translate(./loan_repricing_frequency,'0123456789 ','')))"/>
										</fo:block>
									</fo:table-cell>
									
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:value-of select="./loan_repricing_date"/>
										</fo:block>
									</fo:table-cell>
									
									<xsl:if test="./status[.!= 'A']">
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="./status"/></xsl:with-param>
											</xsl:call-template>
										</fo:block>
									</fo:table-cell>
									</xsl:if>
								</fo:table-row>
							</xsl:for-each>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</xsl:if>
			<xsl:variable name="repricingLnAmt" select="sum(loan_list//loan_current_amt)" />
			<xsl:if test="number($repricingLnAmt) &gt; 0">	
				 <xsl:call-template name="table_template">			 
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REPRICING_TOTAL_AMOUNT')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="loan_list/loan/loan_ccy" />&#160;<xsl:value-of select="loaniq:getFormatedAmount($repricingLnAmt,loan_list/loan/loan_ccy,$language)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			
			<!-- Repricing-New-loan-details -->
			<xsl:if test="product_file_set">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_NEW_LOAN_LABEL')"/>
							</xsl:with-param>
						</xsl:call-template>						
					</xsl:with-param>
				</xsl:call-template>
				<fo:block white-space-collapse="false">
					<fo:table font-family="{$pdfFont}" start-indent="2pt" width="{$pdfTableWidth}">
						<!-- <fo:table-column column-number="1" column-width="16%"/>
						<fo:table-column column-number="2" column-width="11%"/>
						<fo:table-column column-number="3" column-width="7%"/>						
						<fo:table-column column-number="4" column-width="15%"/>
						<fo:table-column column-number="5" column-width="11%"/>
						<fo:table-column column-number="6" column-width="12%"/>
						<fo:table-column column-number="7" column-width="11%"/>
						<fo:table-column column-number="8" column-width="11%"/> -->
						<!-- HEADER -->
						<fo:table-header color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold">
							<fo:table-row text-align="center">
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:call-template name="zero_width_space_1">
										    <xsl:with-param name="data"><xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/></xsl:with-param>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
								
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:call-template name="zero_width_space_1">
										    <xsl:with-param name="data"><xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_FAC_NAME')"/></xsl:with-param>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
								
								<xsl:if test="product_file_set/ln_tnx_record/bo_ref_id[.!= '']">
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:call-template name="zero_width_space_1">
										    <xsl:with-param name="data"><xsl:value-of select="localization:getGTPString($language, 'LN_REPRICE_GRID_HEADER_LOAN_ALIAS')"/></xsl:with-param>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
								</xsl:if>
								
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:call-template name="zero_width_space_1">
										    <xsl:with-param name="data"><xsl:value-of select="localization:getGTPString($language, 'CUST_REFERENCE')"/></xsl:with-param>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>

								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:call-template name="zero_width_space_1">
										    <xsl:with-param name="data"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPRICING_LOAN_PRICING_OPTION')"/></xsl:with-param>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
								
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<!-- <xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_CCY')"/> -->
										<xsl:call-template name="zero_width_space_1">
										    <xsl:with-param name="data"><xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_CCY')"/></xsl:with-param>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>

								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:value-of select="localization:getGTPString($language, 'CURRENT_OUTSTANDING_AMT')"/>
									</fo:block>
								</fo:table-cell>

								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_EFFECTIVE_DATE')"/>
									</fo:block>
								</fo:table-cell>

								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_MATURITY_DATE')"/>
									</fo:block>
								</fo:table-cell>

								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center">
										<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_REPRICING_FREQUENCY')"/>
									</fo:block>
								</fo:table-cell>	
								
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center" margin-right="1px">
										<xsl:value-of select="localization:getGTPString($language, 'XLS_REPRICING_LOAN_REPRICING_DATE')"/>
									</fo:block>
								</fo:table-cell>																								
								
							</fo:table-row>
						</fo:table-header>

						<!-- BODY -->
						<fo:table-body start-indent="2pt">
							<xsl:for-each select="product_file_set/ln_tnx_record">
								<fo:table-row text-align="center">
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="./ref_id"/></xsl:with-param>
											</xsl:call-template>
										</fo:block>
									</fo:table-cell>
									
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="./bo_facility_name"/></xsl:with-param>
											</xsl:call-template>
										</fo:block>
									</fo:table-cell>
									
									<xsl:if test="//product_file_set/ln_tnx_record/bo_ref_id[.!= '']">
										<fo:table-cell border-style="solid" border-width=".25pt">
											<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
												<xsl:call-template name="zero_width_space_1">
												    <xsl:with-param name="data"><xsl:value-of select="./bo_ref_id"/></xsl:with-param>
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
									</xsl:if>
									
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="./cust_ref_id" /></xsl:with-param>
											</xsl:call-template>										</fo:block>
									</fo:table-cell>

									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="localization:getCodeData($language,'**','LN','C030', ./pricing_option)" /></xsl:with-param>
											</xsl:call-template>										
										</fo:block>
									</fo:table-cell>

									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="./ln_cur_code"/></xsl:with-param>
											</xsl:call-template>										
										</fo:block>
									</fo:table-cell>

									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="right">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="./ln_amt"/></xsl:with-param>
											</xsl:call-template>									
										</fo:block>
									</fo:table-cell>

									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="./effective_date"/></xsl:with-param>
											</xsl:call-template>									
										</fo:block>
									</fo:table-cell>

									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="./ln_maturity_date"/></xsl:with-param>
											</xsl:call-template>									
										</fo:block>
									</fo:table-cell>

									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="concat(translate(./repricing_frequency,'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ','') ,' ', localization:getDecode($language, 'C031', translate(./repricing_frequency,'0123456789 ','')))"/></xsl:with-param>
											</xsl:call-template>										
										</fo:block>
									</fo:table-cell>

									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data"><xsl:value-of select="./repricing_date"/></xsl:with-param>
											</xsl:call-template>										
										</fo:block>
									</fo:table-cell>																											
								</fo:table-row>
							</xsl:for-each>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</xsl:if>
				<xsl:variable name="repricingNewLnAmt" select="translate(bk_total_amt, ',' ,'')" />

			 <xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPRICING_TOTAL_NEW_LOAN_AMOUNT')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="loan_list/loan/loan_ccy" />&#160;<xsl:value-of select="loaniq:getFormatedAmount($repricingNewLnAmt,loan_list/loan/loan_ccy,$language)" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="adjust_payment_options[.!= '']">	
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REPRICING_TOTAL_PRINCIPAL_PAYMENT_AMOUNT')"/> 
							</xsl:with-param>
							<xsl:with-param name="right_text">
							  <xsl:value-of select="loan_list/loan/loan_ccy" />&#160;<xsl:value-of select="loaniq:getFormatedAmount(total_principal_amt,loan_list/loan/loan_ccy,$language)"/>						
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="loan_list/loan/fac_cur_code [.!= ''] and loan_list/loan/loan_ccy != loan_list/loan/fac_cur_code"> 
					 <xsl:choose>
				      	 	<xsl:when test="not(tnx_id) or tnx_stat_code[.='04']"> 
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
												<xsl:value-of select="localization:getGTPString($language, 'LN_FX_RATE')"/>
							</xsl:with-param>
											<xsl:with-param name="right_text"><xsl:value-of select="product_file_set/ln_tnx_record/fx_conversion_rate"/></xsl:with-param>
										</xsl:call-template>
				      	 	</xsl:when>
				      	 	<xsl:otherwise>
					      		<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_INDICATIVE_FX_RATE')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">1&#160;<xsl:value-of select="loan_list/loan/fac_cur_code"/>&#160;=&#160;<xsl:value-of select="product_file_set/ln_tnx_record/fx_conversion_rate"/>&#160;<xsl:value-of select="loan_list/loan/loan_ccy"/>
									</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="table_cell">
							<xsl:with-param name="right_text">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_INDICATIVE_FX_NOTE')"/>
							</xsl:with-param>
						</xsl:call-template>
				      	 	</xsl:otherwise>
				      	 </xsl:choose>
					</xsl:if>
					
					<xsl:if test="borrower_settlement_ind[.!= '']">	
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PDF_BORROWER_SETTLEMENT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
							
							   <xsl:if test="borrower_settlement_ind[.='Y']">
							    	<xsl:value-of select="localization:getGTPString($language, 'XSL_PDF_BORROWER_SETTLEMENT_YES')"/>
							   </xsl:if>
							   <xsl:if test="borrower_settlement_ind[.!='Y']">
							    	<xsl:value-of select="localization:getGTPString($language, 'XSL_PDF_BORROWER_SETTLEMENT_NO')"/>
							   </xsl:if>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:variable name="repricingNewLnAmt" select="translate(bk_total_amt, ',' ,'')"/>
					<xsl:variable name="repricingLnAmt" select="sum(loan_list//ln_amt)" />
					<xsl:variable name="loanIncrease" select="($repricingNewLnAmt - $repricingLnAmt)" />
					<xsl:if test="number($loanIncrease) &gt;= 0 ">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REPRICING_LOAN_INCREASE_AMOUNT')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
						    	<xsl:value-of select="loan_list/loan/loan_ccy" />&#160;<xsl:value-of select="loaniq:getFormatedAmount($loanIncrease,loan_list/loan/loan_ccy,$language)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:choose>
				<xsl:when test="(defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED_FOR_REPRICING')='true' or defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED_FOR_REPRICING')='mandatory') and product_file_set/ln_tnx_record/rem_inst_description[.!= '']">  
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REMITTANCE_INSTRUCTION_DETAILS')"/>
								</xsl:with-param>
							</xsl:call-template>						
						</xsl:with-param>
					</xsl:call-template>
					<fo:block white-space-collapse="false">
						<fo:table font-family="{$pdfFont}" start-indent="2pt" width="{$pdfTableWidth}">
							<fo:table-column column-width="33%"/>
							<fo:table-column column-width="33%"/>
							<fo:table-column column-width="33%"/>						
							
							<!-- HEADER -->
							<fo:table-header color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold">
								<fo:table-row text-align="center">
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block text-align="center">
											<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_CURRENCY')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block text-align="center">
											<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_ACCOUNT_NO')"/>
										</fo:block>
									</fo:table-cell>								
									
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block text-align="center">
											<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_DESCRIPTION')"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-header>
							
							<!-- BODY -->
							
							<fo:table-body start-indent="2pt">
								<fo:table-row text-align="center">
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:value-of select="product_file_set/ln_tnx_record/ln_cur_code"/>
										</fo:block>
									</fo:table-cell>
								
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:value-of select="product_file_set/ln_tnx_record/rem_inst_account_no"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:value-of select="product_file_set/ln_tnx_record/rem_inst_description"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>
				</xsl:when>
				<xsl:when test="defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED_FOR_REPRICING')='true' and product_file_set/ln_tnx_record/rem_inst_description[.= '']">
				<fo:block white-space-collapse="false">
					<fo:table font-family="{$pdfFont}" start-indent="2pt" width="{$pdfTableWidth}">
						<fo:table-column column-width="100%"/>
						<!-- HEADER -->
						<fo:table-header color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold">
							<fo:table-row text-align="center">
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block font-size="15pt" text-align="left">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REMITTANCE_INSTRUCTION_DETAILS')"/>
									</fo:block> 
								</fo:table-cell>
							</fo:table-row>
						</fo:table-header>
						
						<!-- BODY -->
						
						<fo:table-body start-indent="2pt">
							<fo:table-row text-align="center">
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
										<xsl:value-of select="localization:getGTPString($language, 'NO_REMITTANCE_INSTRUCTION')"/>
									</fo:block>
								</fo:table-cell>																						
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
				</xsl:when>
		</xsl:choose>
					
      
			<xsl:if test="interest_payment[.='Y']">	
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="title">
								<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PDF_INTEREST_PAYMENT')"/>
								</xsl:with-param>
							</xsl:call-template>						
						</xsl:with-param>
					</xsl:call-template>
					<fo:block white-space-collapse="false">
						<fo:table font-family="{$pdfFont}" start-indent="2pt" width="{$pdfTableWidth}">
							<fo:table-column column-width="20%"/>
							<fo:table-column column-width="20%"/>
							<fo:table-column column-width="20%"/>						
	
							<!-- HEADER -->
							<fo:table-header color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold">
								<fo:table-row text-align="center">
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block text-align="center">
											<xsl:value-of select="localization:getGTPString($language, 'LN_REPRICE_GRID_HEADER_LOAN_ALIAS')"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block text-align="center">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_CCY')"/>
										</fo:block>
									</fo:table-cell>								
	
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block text-align="right">
											<xsl:value-of select="localization:getGTPString($language, 'LN_PRJ_CYC_DUE')"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-header>
	
							<!-- BODY -->
							
							<fo:table-body start-indent="2pt">
								<xsl:for-each select="loan_list/loan">
										<xsl:variable name="loanAlias" select="./loan_bo_ref"/>
									     <xsl:variable name="intAmtVal" select="../../interest_due_amts/interestDueAmt [loan_alias = $loanAlias]/value"/>
										<!-- <xsl:variable name="intAmtTag" select="concat('interestDueAmt_',./loan_bo_ref)"/>
										<xsl:variable name="intAmtVal" select="//*[name()=$intAmtTag]"/> -->
									<fo:table-row text-align="center">
										<fo:table-cell border-style="solid" border-width=".25pt">
											<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
												<xsl:value-of select="./loan_bo_ref"/>
											</fo:block>
										</fo:table-cell>
	
										<fo:table-cell border-style="solid" border-width=".25pt">
											<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
												<xsl:value-of select="./loan_ccy"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border-style="solid" border-width=".25pt">
											<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="right">
												<xsl:value-of select="loaniq:getFormatedAmount($intAmtVal,./loan_ccy,$language)"/>
											</fo:block>
										</fo:table-cell>
																																					
									</fo:table-row>
								</xsl:for-each>
							</fo:table-body>
						</fo:table>
					</fo:block>
			</xsl:if>
			
			<xsl:if test="return_comments/text[.!='']">
   				<fo:block id="returnComments"/>
			
				<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="title">
							<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_MC_COMMENTS_FOR_RETURN')"/>
							</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="return_comments/text"/>
							</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>	
			</xsl:if>
			
			<xsl:if test="defaultresource:getResource('DISPLAY_LEGAL_TEXT_FOR_LOAN') = 'true' and isLegalTextAccepted [.='Y'] and legal_text_value != '' and ($optionCode = 'SNAPSHOT_PDF' or $reviewandprint = 'true')">
			   <xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LEGAL_SECTION')"/>
							</xsl:with-param>
						</xsl:call-template>
	       				<xsl:call-template name="table_cell2">
							<xsl:with-param name="text">
								<xsl:value-of select="legal_text_value"/>
							</xsl:with-param>
						 </xsl:call-template>
				   </xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			
			<xsl:variable name="list"><xsl:value-of select="authorizer_id"/></xsl:variable>
			<xsl:if test="defaultresource:getResource('DISPLAY_AUTHORIZER_NAME') = 'true' and $list != '' and isLegalTextAccepted [.='Y'] and ($optionCode = 'SNAPSHOT_PDF' or $reviewandprint = 'true') ">
				<xsl:variable name="userNames" select="utils:extractUserName($list)"/>
				<xsl:variable name="item">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_AUTHORIZED_USER_NAME')"/>
							<xsl:value-of select="$userNames"/>
				</xsl:variable>
				 <xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AUTHORIZER_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
	       				<xsl:call-template name="table_cell2">
							<xsl:with-param name="text">
								<xsl:value-of select="$item"/>
							</xsl:with-param>
						 </xsl:call-template>
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
            <xsl:value-of select="number($pdfMargin)"/>pt</xsl:attribute>
					<xsl:value-of select="convertTools:internalDateToStringDate($systemDate,$language)"/>
				</fo:block>
			</fo:block>
		</fo:static-content>
  </xsl:template>
</xsl:stylesheet>
