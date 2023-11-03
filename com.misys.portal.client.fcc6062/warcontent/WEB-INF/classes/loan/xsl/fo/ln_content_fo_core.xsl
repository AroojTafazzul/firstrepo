<?xml version="1.0" encoding="UTF-8"?>
<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" 
				xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
				xmlns:fo="http://www.w3.org/1999/XSL/Format" 
				xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
				xmlns:backoffice="xalan://com.misys.portal.loan.loaniq.LoanIQAdapter" 
				xmlns:java="http://xml.apache.org/xalan/java"
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				xmlns:loanutils="xalan://com.misys.portal.common.tools.LoanUtils"
				xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
 				xmlns:user="xalan://com.misys.portal.security.GTPUser" 
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:param name="optionCode">OTHERS</xsl:param>
    <xsl:param name="reviewandprint">false</xsl:param>
    <xsl:variable name="isdynamiclogo">
        <xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
    </xsl:variable>
    
    <xsl:template match="ln_tnx_record">
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
  <xsl:template name="replace-eof-with-br-tag">
	  <xsl:param name="text"/>
	  <xsl:choose>
	    <xsl:when test="contains($text, '&#xa;')">
	      <xsl:value-of select="substring-before($text, '&#xa;')"/>
	      <br/>
	      <xsl:call-template name="replace-eof-with-br-tag">
	        <xsl:with-param 
	          name="text" 
	          select="substring-after($text, '&#xa;')"
	        />
	      </xsl:call-template>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="$text"/>
	    </xsl:otherwise>
	  </xsl:choose>
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
							<xsl:value-of select="ref_id"/>
						</xsl:with-param>
					</xsl:call-template>
				 <xsl:if test="bulk_ref_id[.!=''] ">	
					<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_BK_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bulk_ref_id"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
			                <!-- bo_ref_id -->
                    <xsl:if test="bo_ref_id[.!=''] or preallocated_flag[.='Y']">
                        <xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID_LN')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bo_ref_id"/>
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
 		    <!-- Deal and facilities -->
                    <xsl:if test="sub_tnx_type_code[.!='97'] or prod_stat_code[.='03'] or prod_stat_code[.='07'] or prod_stat_code[.='77']">
	                    <xsl:if test="bo_deal_name[.!='']">
	                        <xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_FACILITYDETAILS_DEAL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="bo_deal_name"/>
								</xsl:with-param>
						 	</xsl:call-template>
	                    </xsl:if>
						<xsl:if test="bo_facility_name[.!='']">
	                        <xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_FACILITYDETAILS_FACILITY')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="bo_facility_name"/>
								</xsl:with-param>
						 	</xsl:call-template>
						</xsl:if>
                    </xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<!--Bank Details-->
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
							<xsl:value-of select="utils:decryptApplicantReference(borrower_reference)"/>
						</xsl:with-param>
					</xsl:call-template>
			   </xsl:with-param>
			</xsl:call-template>
	            
            <xsl:if test="(not(tnx_id) or tnx_type_code[.!='13']) and entity[.!=''] and (borrower_name[.!=''] or borrower_address_line_1[.!=''] or borrower_address_line_2[.!=''] or borrower_dom[.!=''] or borrower_reference[.!=''])">
                <!--Borrower Details-->
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ENTITY_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="borrower_name[.!='']">
                            <xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="borrower_name"/>
								</xsl:with-param>
							</xsl:call-template>
                        </xsl:if>
                        <xsl:if test="borrower_address_line_1[.!='']">
                           	<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="borrower_address_line_1"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="borrower_address_line_2[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="borrower_address_line_2"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="borrower_dom[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="borrower_dom"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						 </xsl:if>
						 
                         <!-- Display Entity -->
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
                         <!--<xsl:if test="borrower_reference[.!='']">
                             <xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'BORROWER_REFERENCE_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="utils:decryptApplicantReference(borrower_reference)"/>
								</xsl:with-param>
							 </xsl:call-template>
                         </xsl:if> -->
					</xsl:with-param>
				</xsl:call-template>
            </xsl:if>
             <xsl:variable name="interestDetails" select="backoffice:getInterestDetails(bo_ref_id)"/>
            <!-- linked-loan-details -->
			<xsl:if test="loan_list">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINKED_LOAN_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<fo:block white-space-collapse="false">
					<fo:table font-family="{$pdfFont}" start-indent="10pt" width="{$pdfTableWidth}">
						<fo:table-column column-width="17%"/>
						<fo:table-column column-width="18%"/>
						<fo:table-column column-width="10%"/>
						<fo:table-column column-width="20%"/>
						<fo:table-column column-width="15%"/>
						<fo:table-column column-width="20%"/>
						<!-- HEADER -->
						<fo:table-header color="{$fontColorTitles}"  font-family="{$pdfFont}" font-weight="bold">
							<fo:table-row text-align="center">
								<fo:table-cell border-style="solid" border-width=".25pt" background-color="{$tableheaderbckgrcol}">
									<fo:block text-align="center">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_REF_ID')"/>
									</fo:block>
								</fo:table-cell>

								<fo:table-cell border-style="solid" border-width=".25pt" background-color="{$tableheaderbckgrcol}">
									<fo:block text-align="center">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_BO_REF')"/>
									</fo:block>
								</fo:table-cell>

								<fo:table-cell border-style="solid" border-width=".25pt" background-color="{$tableheaderbckgrcol}">
									<fo:block text-align="center">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_CCY')"/>
									</fo:block>
								</fo:table-cell>

								<fo:table-cell border-style="solid" border-width=".25pt" background-color="{$tableheaderbckgrcol}">
									<fo:block text-align="center">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_OUTSTANDING_AMT')"/>
									</fo:block>
								</fo:table-cell>

								<fo:table-cell border-style="solid" border-width=".25pt" background-color="{$tableheaderbckgrcol}">
									<fo:block text-align="center">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_REPRICING_DATE')"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell border-style="solid" border-width=".25pt" background-color="{$tableheaderbckgrcol}">
									<fo:block text-align="center">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKEDLOANDETAILS_FACILITY_NAME')"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-header>
						<!-- BODY -->
						<fo:table-body start-indent="2pt">
							<xsl:for-each select="loan_list/loan">
								<fo:table-row text-align="center">
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:value-of select="./loan_ref_id"/>
										</fo:block>
									</fo:table-cell>

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
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:value-of select="backoffice:getFormatedAmount(./loan_outstanding_amt, ./loan_ccy, $language)" />
										</fo:block>
									</fo:table-cell>

									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:value-of select="./loan_repricing_date"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:value-of select="./loan_facility_name"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:for-each>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</xsl:if>

 			<xsl:if test="sub_tnx_type_code[.='97']">
			 <xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FACILITY_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="bo_deal_name[.!='']">
                        <xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_FACILITYDETAILS_DEAL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bo_deal_name"/>
							</xsl:with-param>
					 	</xsl:call-template>
                    </xsl:if>
					<xsl:if test="bo_facility_name[.!='']">
                        <xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_FACILITYDETAILS_FACILITY')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bo_facility_name"/>
							</xsl:with-param>
					 	</xsl:call-template>
					</xsl:if>                 
					
				</xsl:with-param>
			</xsl:call-template>
           
          </xsl:if>  
			 
			<!-- Reporting Details Fieldset. -->
			<xsl:if test="product_code[.='LN'] and security:isBank($rundata) and ($optionCode = 'SNAPSHOT_PDF' or $reviewandprint = 'true' or prod_stat_code[.='02'])">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REPORTING_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_NEW_TNX_STAT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getDecode($language, 'N005', prod_stat_code)"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="tnx_type_code[.='01'] and bo_ref_id[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_OUTSTANDING_ALIAS')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="bo_ref_id"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="bo_comment [.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_COMMENT')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="bo_comment"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			 
            <!--Loan Details-->
            <xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LOAN_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					 <!--Form of LN-->
                     <!--application Date -->
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
					<xsl:if test="effective_date[.!=''] and (not(tnx_id) or tnx_type_code[.!='13'])">
                        <xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LOAN_EFFECTIVE_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="effective_date"/>
							</xsl:with-param>
						</xsl:call-template>
                    </xsl:if>
                    <xsl:if test="not(tnx_id) or tnx_type_code[.!='13']">
                    	
                    	<!-- Loan Amount -->
                    	<xsl:if test="ln_amt[.!='']">
                    	 <xsl:choose>
							<xsl:when test="sub_tnx_type_code[.='97']">
                    	           <xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_REPRICEDLOAN_OUT_AMT')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="ln_cur_code"/> <xsl:value-of select="ln_amt"/>
									</xsl:with-param>
						  		</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="tnx_type_code[.='03']">
										<xsl:call-template name="table_cell">
											<xsl:with-param name="left_text">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_LOAN_AMOUNT')"/>
											</xsl:with-param>
											<xsl:with-param name="right_text">
												<xsl:value-of select="ln_cur_code"/> <xsl:value-of select="org_previous_file/ln_tnx_record/ln_liab_amt"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_LOAN_AMOUNT')"/>
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="ln_cur_code"/> <xsl:value-of select="ln_amt"/>
										</xsl:with-param>
										</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						 </xsl:choose>
                    	</xsl:if>
	                    
						<!-- Loan Liable amount -->
	                    <xsl:if test="not(tnx_id) and ln_liab_amt[.!='']">
	                        <xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_AMT_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ln_cur_code"/> <xsl:value-of select="ln_liab_amt"/>
								</xsl:with-param>
							</xsl:call-template>
	                    </xsl:if>
	                     <xsl:if test="fx_conversion_rate[.!=''] and fac_cur_code[.!=''] and (string(ln_cur_code)!=string(fac_cur_code))">
	                     	<xsl:if test="not(tnx_id) or tnx_stat_code[.='04']">
                     			<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XLS_FX_RATE')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text"><xsl:value-of select="fx_conversion_rate"/></xsl:with-param>
								</xsl:call-template>
	                     	</xsl:if>
	                     	<xsl:if test="tnx_type_code[.!='03'] and tnx_stat_code[.!='04']">
                     			<xsl:call-template name="table_cell">
	                     			<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_INDICATIVE_FX_RATE')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">1&#160;<xsl:value-of select="fac_cur_code"/>&#160;=&#160;<xsl:value-of select="fx_conversion_rate"/>&#160;<xsl:value-of select="ln_cur_code"/></xsl:with-param>
						 		</xsl:call-template>
						 	  	<xsl:call-template name="table_cell">
									<xsl:with-param name="right_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_INDICATIVE_FX_NOTE')"/>
									</xsl:with-param>
						 		</xsl:call-template>
	                     	</xsl:if>
	                    </xsl:if>
	                    
	                    <!-- Pricing Option -->
	                    <xsl:if test="pricing_option[.!='']">
		                     <xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_LOAN_PRICING_OPTION')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getCodeData($language,'**','LN','C030', pricing_option)" />
								</xsl:with-param>
							</xsl:call-template>
	                    </xsl:if>
	                    
	                    <!-- Repricing Frequency -->
	                    <xsl:if test="repricing_frequency[.!='']">
		                    <!-- Take an example of '10M' available as a <tag-value /> -->
	                    	<!-- extracting '10' from  '10M'-->
							<xsl:variable name="scalarOfRepricingFrequency">
								<xsl:value-of select="translate(repricing_frequency,'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ','')"/>
							</xsl:variable>
							<!-- extracting 'M' or 'm' from  '10M' -->
							<xsl:variable name="unitOfRepricingFrequency">
								<xsl:value-of select="translate(repricing_frequency,'0123456789 ','')"/>
							</xsl:variable>
							
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_LOAN_REPRICING_FREQUENCY')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="concat($scalarOfRepricingFrequency, ' ', localization:getDecode($language, 'C031', $unitOfRepricingFrequency))"/>
								</xsl:with-param>
							</xsl:call-template>
	                	</xsl:if>
	                		                    
	                	<!-- Repricing Date -->
	                	<xsl:if test="repricing_date[.!='']">
		                     <xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REPRICING_DATE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="repricing_date"/>
								</xsl:with-param>
							</xsl:call-template>
	                	</xsl:if>
	                	
	                	<!-- Risk Type -->
	                    <xsl:if test="risk_type[.!='']">
		                     <xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_LOAN_RISK_TYPE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getDecode($language, 'C032', risk_type)"/>
								</xsl:with-param>
							</xsl:call-template>
	                	</xsl:if> 
	                </xsl:if>
	                
	                <!-- Maturity Date -->
                    <xsl:if test="ln_maturity_date[.!='']">
                        <xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_MATURITY_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="ln_maturity_date"/>
							</xsl:with-param>
						</xsl:call-template>
                    </xsl:if>
                    
                    <!-- Loan status -->
                    <xsl:if test="status[.!='']">
                        <xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LOAN_STATUS')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getDecode($language, 'N431', status)"/>
							</xsl:with-param>
						</xsl:call-template>
                    </xsl:if>    
			   </xsl:with-param>
			</xsl:call-template>


<!--  Remittance Instruction Details -->
			<xsl:choose>
			<xsl:when test="tnx_id[.!=''] and sub_tnx_type_code[.!='97'] and tnx_type_code[.!='03'] and sub_tnx_type_code[.!='16'] and (defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED')='true' or defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED')='mandatory') and rem_inst_description[.!= '']">  
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
												<xsl:value-of select="ln_cur_code"/>
											</fo:block>
										</fo:table-cell>
	
										<fo:table-cell border-style="solid" border-width=".25pt">
											<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
												<xsl:value-of select="rem_inst_account_no"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border-style="solid" border-width=".25pt">
											<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
												<xsl:value-of select="rem_inst_description"/>
											</fo:block>
										</fo:table-cell>
																																					
									</fo:table-row>
								
							</fo:table-body>
						</fo:table>
					</fo:block>
					</xsl:when>
					<xsl:when test="tnx_id[.!=''] and sub_tnx_type_code[.!='97'] and tnx_type_code[.!='03'] and sub_tnx_type_code[.!='16'] and defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED')='true' and rem_inst_description[.= '']">
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
					
      
						<!--Bank Details-->
			<xsl:if test="not(tnx_id)">  
            <xsl:call-template name="table_template">         
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_INTEREST_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					 
					<xsl:if test="$interestDetails/interest_cycle_frequency[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XLS_INTEREST_DETAILS_INTEREST_CYC_FREQUENCY')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="$interestDetails/interest_cycle_frequency"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="$interestDetails/base_rate[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XLS_INTEREST_DETAILS_BASE_RATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="backoffice:formatRateValues($interestDetails/base_rate,$interestDetails/currency,$language)"/>%
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="$interestDetails/spread[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XLS_INTEREST_DETAILS_SPREAD')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="backoffice:formatRateValues($interestDetails/spread,$interestDetails/currency,$language)"/>%
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="$interestDetails/rac_rate[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XLS_INTEREST_DETAILS_RAC_RATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="backoffice:formatRateValues($interestDetails/rac_rate,$interestDetails/currency,$language)"/>%
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="$interestDetails/all_in_rate[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XLS_INTEREST_DETAILS_ALL_IN_RATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="backoffice:formatRateValues($interestDetails/all_in_rate,$interestDetails/currency,$language)"/>%
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					
					
										
						<xsl:if test="$interestDetails/projected_interested_due[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XLS_PROJECTED_INTERESTED_DUE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="$interestDetails/projected_interested_due"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
					
					
					<xsl:if test="not(tnx_id)">
					
					<xsl:if test="$interestDetails/total_interest_amount[.!='']">
							<xsl:variable name="arrayList1" select="java:java.util.ArrayList.new()" />
							<xsl:variable name="void" select="java:add($arrayList1, concat('', loanutils:convertApiDateToFccDate($interestDetails/today_date,$language)))"/>
							<xsl:variable name="void" select="java:add($arrayList1, concat('', $interestDetails/currency))"/>
							<xsl:variable name="void" select="java:add($arrayList1, concat('', backoffice:getFormatedAmount($interestDetails/total_interest_amount,$interestDetails/currency,$language)))"/>		
							<xsl:variable name="args1" select="java:toArray($arrayList1)"/>
							
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getFormattedString($language, 'LOAN_DETAILS_INTEREST_DUE_PDF', $args1)" disable-output-escaping="yes"/> <xsl:value-of select="loanutils:convertApiDateToFccDate($interestDetails/today_date,$language)"/>:
							</xsl:with-param>
							<xsl:with-param name="right_text">		
													<xsl:value-of select="ln_cur_code"/> <xsl:value-of select="backoffice:getFormatedAmount($interestDetails/total_interest_amount,$interestDetails/currency,$language)"/>
							</xsl:with-param>
						</xsl:call-template>
				  </xsl:if>
					
					</xsl:if>
			   </xsl:with-param>
			</xsl:call-template>
			
<!-- 			<xsl:if test="not(tnx_id)"> -->
			<xsl:variable name="interestDetailsCycle" select="backoffice:getInterestCycleDetails(bo_ref_id)"/>	
			
			<xsl:if test="$interestDetailsCycle/loan_interest_details/cycles">
			<xsl:variable name="loan_ccy"><xsl:value-of select="ln_cur_code"/></xsl:variable>
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_INTEREST_CYCLE_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<fo:block white-space-collapse="false">
					<fo:table font-family="{$pdfFont}" start-indent="12pt" width="{$pdfTableWidth}">
						<fo:table-column column-width="9%"/>
						<fo:table-column column-width="12%"/>
						<fo:table-column column-width="12%"/>
						<fo:table-column column-width="12%"/>
						<fo:table-column column-width="15%"/>
						<fo:table-column column-width="12%"/>
						<fo:table-column column-width="12%"/>
						<fo:table-column column-width="12%"/>
						<!-- HEADER -->
						<fo:table-header color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold">
							<fo:table-row text-align="center">
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center">
										<xsl:value-of select="localization:getGTPString($language, 'LN_INTEREST_CYCLE_NO')"/>
									</fo:block>
								</fo:table-cell>

								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center">
										<xsl:value-of select="localization:getGTPString($language, 'LN_START_DATE')"/>
									</fo:block>
								</fo:table-cell>

								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center">
										<xsl:value-of select="localization:getGTPString($language, 'LN_END_DATE')"/>
									</fo:block>
								</fo:table-cell>

								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center">
										<xsl:value-of select="localization:getGTPString($language, 'LN_DUE_DATE')"/>
									</fo:block>
								</fo:table-cell>

								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center">
										<xsl:value-of select="localization:getGTPString($language, 'LN_PRJ_CYC_DUE')"/>
									</fo:block>
								</fo:table-cell>
								
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center">
										<xsl:value-of select="localization:getGTPString($language, 'LN_ACCURED_TO_DATE')"/>
									</fo:block>
								</fo:table-cell>
								
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center">
										<xsl:value-of select="localization:getGTPString($language, 'LN_PAID_TO_DATE')"/>
									</fo:block>
								</fo:table-cell>
								
								<fo:table-cell border-style="solid" border-width=".25pt">
									<fo:block text-align="center">
										<xsl:value-of select="localization:getGTPString($language, 'LN_BILLED_INTEREST')"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-header>

						<!-- BODY -->
						<fo:table-body start-indent="2pt">
							<xsl:for-each select="$interestDetailsCycle/loan_interest_details/cycles/cycle">
								<fo:table-row text-align="center">
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
											<xsl:value-of select="./interest_cycle"/>
										</fo:block>
									</fo:table-cell>

									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
										<xsl:value-of select="loanutils:convertApiDateToFccDate(./start_date,$language)"/>
										</fo:block>
									</fo:table-cell>

									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
										<xsl:value-of select="loanutils:convertApiDateToFccDate(./end_date,$language)"/>
										</fo:block>
									</fo:table-cell>

									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="center">
										<xsl:value-of select="loanutils:convertApiDateToFccDate(./due_date,$language)"/>
										</fo:block>
									</fo:table-cell>

									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="right">
										<xsl:value-of select="backoffice:getFormatedAmount(./projected_cycleDue_amt, $loan_ccy, $language)"/>										
										</fo:block>
									</fo:table-cell>
									
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="right">
										<xsl:value-of select="backoffice:getFormatedAmount(./accrued_toDate_amt/, $loan_ccy, $language)" />
										</fo:block>
									</fo:table-cell>
									
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="right">
										<xsl:value-of select="backoffice:getFormatedAmount(./paid_toDate_amt, $loan_ccy, $language)"/>
										</fo:block>
									</fo:table-cell>
									
									<fo:table-cell border-style="solid" border-width=".25pt">
										<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="right">
										<xsl:value-of select="backoffice:getFormatedAmount(./billed_interest_amt, $loan_ccy, $language)"/>	
										</fo:block>
									</fo:table-cell>
									
								</fo:table-row>
							</xsl:for-each>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</xsl:if>
			</xsl:if>
			

			
			<xsl:if test="tnx_type_code[.='03']">
			   <xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LOAN_AMENDMENT')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="amd_date[. != '']">
				        <xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_LOAN_AMD_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="amd_date"/>
							</xsl:with-param>
						 </xsl:call-template>
				    </xsl:if>
					<xsl:if test="org_previous_file/ln_tnx_record/ln_liab_amt[. != '']">
	       				<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LOAN_LIAB_ORIGINAL_AMT')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								  <xsl:value-of select="ln_cur_code"/>&#160;<xsl:value-of select="org_previous_file/ln_tnx_record/ln_liab_amt"/>
							</xsl:with-param>
						 </xsl:call-template>
       				</xsl:if>
	      			<xsl:if test="tnx_amt[. != '']">
	      				<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LOAN_AMEND_INCREASE_AMT')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								  <xsl:value-of select="ln_cur_code"/>&#160;<xsl:value-of select="tnx_amt"/>
							</xsl:with-param>
						 </xsl:call-template>
	      			</xsl:if>
	      			<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_LOAN_LIAB_NEW_AMT')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							  <xsl:value-of select="ln_cur_code"/>&#160;<xsl:value-of select="ln_liab_amt"/>
						</xsl:with-param>
					</xsl:call-template>
	      			<xsl:if test="org_previous_file/ln_tnx_record/fx_conversion_rate[.!=''] and org_previous_file/ln_tnx_record/fac_cur_code[.!=''] and (string(org_previous_file/ln_tnx_record/ln_cur_code)!=string(org_previous_file/ln_tnx_record/fac_cur_code))">
                       <xsl:choose>
	                       <xsl:when test="tnx_stat_code != 04">
		                        <xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_INDICATIVE_FX_RATE')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">1&#160;<xsl:value-of select="fac_cur_code"/>&#160;=&#160;<xsl:value-of select="fx_conversion_rate"/>&#160;<xsl:value-of select="ln_cur_code"/>
									</xsl:with-param>
							 	</xsl:call-template>
							 	<xsl:call-template name="table_cell">
									<xsl:with-param name="right_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_INDICATIVE_FX_NOTE')"/>
									</xsl:with-param>
						 		</xsl:call-template>
					 		</xsl:when>
					 		<xsl:otherwise>
		    					<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'LN_FX_RATE')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text"><xsl:value-of select="backoffice:getFXRate(fac_cur_code,ln_cur_code,issuing_bank/abbv_name,$language)"/></xsl:with-param>
							 	</xsl:call-template>
	    					</xsl:otherwise>
    					</xsl:choose>
                   </xsl:if>
			   </xsl:with-param>
			</xsl:call-template>
			
			</xsl:if>
			
				<!-- Additional Information Provided by the Client -->
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<!-- No empty table allowed -->
				<fo:table-row>
					<fo:table-cell number-columns-spanned="2">
						<fo:block/>
					</fo:table-cell>
				</fo:table-row>

				<xsl:if test="free_format_text[.!='']">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_LOAN_ADDITIONAL_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>		
				<xsl:if test="free_format_text[.!='']">
						<xsl:call-template name="subtitle2">
							<xsl:with-param name="text">
										<xsl:value-of select="localization:getGTPString($language,'XSL_LOAN_INCREASE_REASON')"/>	
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell2">
							<xsl:with-param name="text">
								<xsl:value-of select="free_format_text"/>
							</xsl:with-param>
						</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>            
            <!--Payment Details-->
            <!--Call Template for Credit Available With Bank-->
            <xsl:if test="tnx_type_code[.='13']">
	            <xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PAYMENT_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="ln_maturity_date[. != '']">
					        <xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_MATURITY_DATE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ln_maturity_date"/>
								</xsl:with-param>
							 </xsl:call-template>
					    </xsl:if>
						<xsl:if test="principal_act_no[. != '']">
		       				<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="principal_act_no"/>
								</xsl:with-param>
							 </xsl:call-template>
	       				</xsl:if>
		      			<xsl:if test="fee_act_no[. != '']">
		      				<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="fee_act_no"/>
								</xsl:with-param>
							 </xsl:call-template>
		      			</xsl:if>
		      			<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_FINANCING_BANK')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="issuing_bank/name"/>
							</xsl:with-param>
						</xsl:call-template>
				   </xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			
			<xsl:if test="tnx_type_code[.='13']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LOAN_PAYMENT')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="ln_maturity_date[. != '']">
					        <xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_LOAN_PAYMENT_DATE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ln_maturity_date"/>
								</xsl:with-param>
							 </xsl:call-template>
					    </xsl:if>

						<xsl:if test="ln_liab_amt[. != '']">
							<xsl:variable name="tempLnLiabAmt" select="translate(org_previous_file/ln_tnx_record/ln_liab_amt,',', '')" />
							<xsl:variable name="tempTnxAmt" select="translate(tnx_amt,',', '')" />
					    	<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_LOAN_AMOUNT')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="tnx_amt != '' and number($tempLnLiabAmt)">
											<xsl:value-of select="ln_cur_code"/> <xsl:value-of select="format-number($tempLnLiabAmt, '###,###,###,###.00')" />
										</xsl:when>
										<!-- Invalid scenario, so showing invalid number. Like, 'NaN' -->
										<xsl:otherwise>
											<xsl:value-of select="ln_cur_code"/> <xsl:value-of select="format-number(ln_liab_amt + tnx_amt, '###,###,###,###.00')" />
										</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="tnx_amt[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_LOAN_PAYMENT_AMT')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ln_cur_code"/> <xsl:value-of select="tnx_amt"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="ln_liab_amt[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_LOAN_LIAB_NEW_AMT')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ln_cur_code"/> <xsl:value-of select="ln_liab_amt"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
				   </xsl:with-param>
				</xsl:call-template>
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
			<xsl:if test="defaultresource:getResource('DISPLAY_AUTHORIZER_NAME') = 'true' and $list != '' and ($optionCode = 'SNAPSHOT_PDF' or $reviewandprint = 'true') ">
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
