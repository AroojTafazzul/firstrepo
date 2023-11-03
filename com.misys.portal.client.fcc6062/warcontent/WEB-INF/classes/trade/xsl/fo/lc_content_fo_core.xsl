<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<!-- Copyright (c) 2006-2012 Misys , All Rights Reserved -->
<xsl:stylesheet 
	xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" 
	xmlns:formatter="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
	xmlns:fo="http://www.w3.org/1999/XSL/Format" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity" 
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck" 
	version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>

	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>
	<xsl:variable name="background">
		BLACK
	</xsl:variable>
	<xsl:variable name="isLcStructuredFormatAccess">
		<xsl:if test="security:isBank($rundata) = 'true' and securitycheck:hasPermission($rundata,'lc_create_structured_format') = 'true'">Y</xsl:if>
	</xsl:variable>
	
	<xsl:template match="lc_tnx_record">
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
			<xsl:if test="(not(tnx_id) or (tnx_type_code[.!='01'] and tnx_type_code[.!='15'] and tnx_type_code[.!='03'] and tnx_type_code[.!='04'] and tnx_type_code[.!='13']) or preallocated_flag[.='Y'])">
		    	<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_EVENT_DETAILS')" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="company_name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_COMPANY_NAME')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="company_name" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="product_code[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_CODE')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of
										select="localization:getDecode($language, 'N001', product_code[.])" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="sub_product_code[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_SUBPRODUCT_CODE')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of
										select="localization:getDecode($language, 'N047', sub_product_code[.])" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="ref_id[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ref_id" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="cust_ref_id[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="cust_ref_id" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="principal_act_no[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="principal_act_no" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="fee_act_no[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="fee_act_no" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
                <xsl:if test="security:isBank($rundata))">
                	<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_HEADER_BANK_MESSAGE')" />	
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="prod_stat_code[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_PROD_STAT_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of
											select="localization:getDecode($language, 'N005', prod_stat_code[.])" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="bo_ref_id[.!='']">
						<xsl:call-template name="table_template">
							<xsl:with-param name="text">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="bo_ref_id" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:if>
          	</xsl:if>
			<xsl:if test="security:isBank($rundata)">
                     <fo:block id="txndetails"/>
                     <xsl:call-template name="table_template">
                           <xsl:with-param name="text">
                                  <xsl:call-template name="title">
                                         <xsl:with-param name="text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_DETAILS')"/>
                                         </xsl:with-param>
                                  </xsl:call-template>                            
                                  <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_COMPANY_NAME')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="utils:getCompanyName(ref_id,product_code)"/><!-- 20170807_01 -->
                                         </xsl:with-param>
                                  </xsl:call-template>                            
                                  <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_CODE')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of
                                                select="localization:getDecode($language, 'N001', product_code[.])" />
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
                                  <xsl:if test="cust_ref_id[.!='']">
                                   <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="cust_ref_id"/>
                                         </xsl:with-param>
                                  </xsl:call-template>
                                  </xsl:if>
                                  <xsl:if
							            test="bo_ref_id[.!=''] and (not(tnx_id) or tnx_type_code[.!='01'] or preallocated_flag[.='y'])">
							      <xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
									    <xsl:value-of select="bo_ref_id" />
								    </xsl:with-param>
							     </xsl:call-template>
						        </xsl:if>                      
                                  <xsl:if test="tnx_type_code[.!='']">
                                  	<xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_TRANSACTION_TYPE')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                       		<xsl:value-of select="localization:getDecode($language, 'N002', tnx_type_code[.])"/>
                                       		<xsl:if test="sub_tnx_type_code[. != ''] and sub_tnx_type_code[. = '08'] and product_code[.='LC']">&nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_DISCREPANCY_RESPONSE')"/>
                                       		</xsl:if>	
                                       		<xsl:if test="sub_tnx_type_code[. != ''] and sub_tnx_type_code[. = '09']and product_code[.='LC']">&nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_09_DISCREPANT_NACK')"/>
                                       		</xsl:if>
                                            <xsl:if test="sub_tnx_type_code[. != ''] and sub_tnx_type_code[. != '08' and . != '09']">&nbsp;<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code[.])"/>
											</xsl:if>
                                         </xsl:with-param>
                                  	</xsl:call-template>
                                  </xsl:if>
                                  <xsl:if test="sub_tnx_type_code[.!= ''] and sub_tnx_type_code[.= '08' or .= '09'] and product_code[.='LC']">		
						           <xsl:call-template name="table_cell">		
							           <xsl:with-param name="left_text">
							             <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_DISCREPANCY_RESPONSE')"/>
                                       </xsl:with-param>		
							           <xsl:with-param name="right_text">		
							           <xsl:choose>		
								           <xsl:when test="sub_tnx_type_code[. = '08'] and product_code[.='LC']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DISCREPANCY_RESPONSE_AGREE_TO_PAY')"/></xsl:when>		
								           <xsl:when test="sub_tnx_type_code[. = '09'] and product_code[.='LC']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DISCREPANCY_RESPONSE_HOLD_THE_DOCUMENT')"/></xsl:when>		
								       </xsl:choose>		
							           </xsl:with-param>		
							       </xsl:call-template>		
						          </xsl:if>                     
                                  <xsl:if test="release_dttm[.!='']">
                                   <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_RELEASE_DTTM')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="formatter:formatReportDate(release_dttm,$rundata)" />
                                         </xsl:with-param>
                                  </xsl:call-template>
                                  </xsl:if>
                                  <xsl:if test="tnx_type_code[.='03']">
                                  <xsl:if test="amd_no[.!='']">
                                   <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_AMD_NO')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="utils:formatAmdNo(amd_no)" />
                                         </xsl:with-param>
                                  </xsl:call-template>
                                  </xsl:if>
                                  <xsl:if test="amd_date[.!='']">
                                   <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_AMD_DATE')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="amd_date" />
                                         </xsl:with-param>
                                  </xsl:call-template>
                                  </xsl:if>
								</xsl:if>
                                  <xsl:if test="iss_date[.!='']">
                                   <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ISSUE_DATE')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="iss_date"/>
                                         </xsl:with-param>
                                  </xsl:call-template>
                                  </xsl:if>
                                  </xsl:with-param>
                     </xsl:call-template>
                     <fo:block id="reportdetails"/>
					 <xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REPORTING_DETAILS')"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="prod_stat_code[.!=''] and (not(tnx_id) or tnx_type_code[.='15'])">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_NEW_TNX_STAT_LABEL')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="localization:getDecode($language, 'N005', prod_stat_code[.])"/>
 									</xsl:with-param>
								</xsl:call-template> 
							</xsl:if>
							<xsl:if test="prod_stat_code[.!=''] and tnx_type_code[.!='15']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_NEW_TNX_STAT_LABEL')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:choose>
											<xsl:when test="prod_stat_code[.='01']"><xsl:value-of select="localization:getGTPString($language,'XSL_PRODSTATCODE_01_REJECTED')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='03' or .='04' or .='05' or .='07' or .='08' or .='11' or .='76']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_APPROVED')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='78']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_78_WORDING_UNDER_REVIEW')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='79']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_79_FINAL_WORDING')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='18']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_18_INPROGRESS')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXSTATCODE_05_STOPOVER_TO_SENT')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='98']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_98_PROVISIONAL')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='14']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_14_PART_SIGHT_PAYMT')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='15']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_15_FULL_SIGHT_PAYMT')"/></xsl:when>
										</xsl:choose>
									</xsl:with-param>
								</xsl:call-template> 
							</xsl:if>
							<xsl:if test="doc_ref_no[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_DOC_REF_NO')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="doc_ref_no"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="(sub_tnx_type_code[.='25' or .='62' or .='63'] or prod_stat_code[.='84' or .='85' or .='87' or .='88'])">
							<xsl:if test="claim_reference[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_CLAIM_REFERENCE_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="claim_reference" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="claim_present_date[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_CLAIM_PRESENT_DATE_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="claim_present_date" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="claim_amt[.!=''] and claim_cur_code[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_CLAIM_AMOUNT_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="claim_cur_code" />&nbsp;<xsl:value-of select="claim_amt" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							</xsl:if>
							<xsl:if test="(prod_stat_code[.='A9'] or prod_stat_code[.='12'] or prod_stat_code[.='13'] or prod_stat_code[.='14'] or prod_stat_code[.='15'] or prod_stat_code[.='26'] or prod_stat_code[.='84'] or prod_stat_code[.='85'])and tnx_amt[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_DOCS_AMT_LABEL')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="tnx_cur_code" />&nbsp;<xsl:value-of select="tnx_amt" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="maturity_date[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_MATURITY_DATE')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="maturity_date"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="latest_answer_date[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_LATEST_ANSWER_DATE')"/>					
									</xsl:with-param>									
									<xsl:with-param name="right_text">
										<xsl:value-of select="latest_answer_date"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>						
							<xsl:if test="bo_ref_id[.!=''] and tnx_type_code[.!='03'] and tnx_type_code[.!='15']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="bo_ref_id"/>
                                    </xsl:with-param>
                             </xsl:call-template>  
                             </xsl:if>
                               <xsl:if test="release_amt[.!=''] and tnx_type_code[.='03'] and sub_tnx_type_code[.='05']">
                             	<xsl:call-template name="table_cell">
                             		<xsl:with-param name="left_text">
                             			<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_SI_RELEASE_AMT_LABEL')"/>
                             		</xsl:with-param>
                             		<xsl:with-param name="right_text">
                             			<xsl:value-of select="release_amt"/>
                                    </xsl:with-param>
                                </xsl:call-template>
                             </xsl:if>
                             <xsl:if test="action_req_code[.!='']">
                             <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ACTION_REQUIRED')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                        <xsl:value-of select="localization:getDecode($language, 'N042', action_req_code[.])"/>
                                    </xsl:with-param>
                             </xsl:call-template>
                             </xsl:if>
                           </xsl:with-param>
                     </xsl:call-template>
				    <xsl:if test="bo_comment[.!='']">
		<fo:block linefeed-treatment="preserve" white-space-collapse="false" white-space="pre">
		           <fo:table width="{$pdfTableWidth}"
					font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
					<fo:table-column column-width="{$pdfTableWidth}" />
					<fo:table-column column-width="0"/>
					<fo:table-body>
						<xsl:call-template name="subtitle2">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language,'XSL_REPORTINGDETAILS_COMMENT')" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell2">
							<xsl:with-param name="text">
								<xsl:value-of select="bo_comment"/>
							</xsl:with-param>
						</xsl:call-template>
					</fo:table-body>
				</fo:table>
			</fo:block>
			</xsl:if>
		        <xsl:if test="count(charges/charge[created_in_session = 'Y']) != 0">
						<xsl:call-template name="table_template">
							<xsl:with-param name="text">
								<xsl:call-template name="title">
									<xsl:with-param name="text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PRODUCT_CHARGE_DETAILS')" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:for-each select="charges/charge[created_in_session = 'Y' and chrg_code != 'OTHER']">
							<xsl:call-template name="CHARGE" />
						</xsl:for-each>
						<xsl:for-each select="charges/charge[created_in_session = 'Y' and chrg_code = 'OTHER']">
							<xsl:call-template name="CHARGE" />
						</xsl:for-each>
				</xsl:if>
			</xsl:if>
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
					
				 <xsl:if test="cross_references/cross_reference/child_product_code[.!='IP' and .!='IN' and .!='PO' and .!='SO' and .!='TD'] and (cross_references/cross_reference/child_ref_id=ref_id and cross_references/cross_reference/ref_id != cross_references/cross_reference/child_ref_id)  and (cross_reference/product_code= .!='FB')"> 
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ANCESTOR_LINKED_REFERENCE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="cross_references/cross_reference/ref_id"/> (<xsl:value-of select="localization:getDecode($language, 'N043', cross_references/cross_reference/type_code)"/>)
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				
				<xsl:if test="cross_references/cross_reference/child_product_code[.!='IP' and .!='IN' and .!='PO' and .!='SO' and .!='CR' and .!='CN' and .!='FX' and .!='TD' and .!='SI']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_NO_LINKED_REFERENCE')" />
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
					<xsl:if test="iss_date[.!=''] and (not(tnx_id) or tnx_type_code[.!='01'])  or security:isBank($rundata)">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ISSUE_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="iss_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="stnd_by_lc_flag[. = 'Y']">
					<xsl:if test="lc_exp_date_type_code[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text"><xsl:value-of select="localization:getGTPString($language, 'GENERALDETAILS_EXPIRY_TYPE')"/></xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="lc_exp_date_type_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_EXP_DATE_TYPE_SPECIFIC')"/></xsl:when>
									<xsl:when test="lc_exp_date_type_code[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_EXP_DATE_TYPE_CONDITIONAL')"/></xsl:when>
									<xsl:when test="lc_exp_date_type_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_EXP_DATE_TYPE_UNLIMITED')"/></xsl:when>
								</xsl:choose>
							</xsl:with-param>		
						</xsl:call-template>
					</xsl:if>
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
					<xsl:if test="product_code ='LC' and exp_event[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_EVENT')"/>
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="exp_event"/>
										</xsl:with-param>
									</xsl:call-template>
					</xsl:if>
					<xsl:if test="expiry_place[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_PLACE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="expiry_place"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="stnd_by_lc_flag[. = 'Y']">
					<xsl:if test="lc_govern_country[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_PLACE_OF_JURISDICTION')"/></xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="lc_govern_country"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="lc_govern_text[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text"><xsl:value-of select="localization:getGTPString($language, 'GOVERNING_LABEL')"/></xsl:with-param>
								<xsl:with-param name="right_text"><xsl:value-of select="lc_govern_text"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:if>
					<xsl:if test="purchase_order[.!=''] and defaultresource:getResource('PURCHASE_ORDER_REFERENCE_ENABLED') = 'true'">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_PUO_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="purchase_order"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="provisional_status[.='Y'] and security:isBank($rundata) != 'true'">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text"/>
							<xsl:with-param name="right_text">
								<xsl:if test="provisional_status[.='Y'] and prod_stat_code[.!='03']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PROVISIONAL')"/>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="amd_no[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_AMD_NO')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="utils:formatAmdNo(amd_no)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="eucp_flag[. = 'Y']">
				<fo:table font-family="{$pdfFontData}" font-weight="bold" space-before.conditionality="retain" space-before.optimum="10.0pt" width="{$pdfTableWidth}">
					<fo:table-column column-width="{$pdfTableWidth}"/>
					<fo:table-column column-width="0"/> <!--  dummy column -->
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:block start-indent="20.0pt">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EUCP_DISCLAIMER')"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:if test="eucp_version[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EUCP_VERSION')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="eucp_version"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!--
							Presentation place not shown in SI: SWIFT 47a should be used
							instead
						-->
						<!--
							xsl:if test="eucp_presentation_place[. != '']"> <fo:table-row>
							<fo:table-cell/> <fo:table-cell> <fo:block
							font-family="{$pdfFont}"> <xsl:value-of
							select="localization:getGTPString($language,
							'XSL_GENERALDETAILS_EUCP_PRESENTATION_PLACE')"/> </fo:block>
							</fo:table-cell> <fo:table-cell> <fo:block font-weight="bold">
							<xsl:value-of select="eucp_presentation_place"/> </fo:block>
							</fo:table-cell> </fo:table-row> </xsl:if
						-->
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="applicant_name !='' or applicant_address_line_1 !='' or applicant_address_line_2 !='' or applicant_dom !='' or applicant_address_line_4 !='' or applicant_reference !='' or entity !=''">
				<!--Applicant Details-->
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_APPLICANT_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="applicant_name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="applicant_name"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Display address -->
						<xsl:if test="applicant_address_line_1[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="applicant_address_line_1"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="applicant_address_line_2[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="applicant_address_line_2"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="applicant_dom[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="applicant_dom"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="applicant_address_line_4[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="applicant_address_line_4"/>
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
						<!-- Display reference  -->
						<!-- commented as part of MPS-39538  -->
					<xsl:variable name="appl_ref">
	                      <xsl:value-of select="applicant_reference"/>
	                </xsl:variable>
					<xsl:if test="applicant_reference[.!=''] and security:isBank($rundata)">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CUST_REFERENCE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="tnx_type_code[.='01'] and release_dttm[.='']"><xsl:value-of select="//*/customer_references/customer_reference[reference=$appl_ref]/description"/></xsl:when>
									<xsl:otherwise>
									<xsl:value-of select="utils:decryptApplicantReference(applicant_reference)"/>
									</xsl:otherwise>
								</xsl:choose>	
								</xsl:with-param>
							</xsl:call-template>
					</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			
			<xsl:if test="alt_applicant_name !='' or alt_applicant_address_line_1 !='' or alt_applicant_address_line_2 !='' or alt_applicant_dom !=''  or alt_applicant_address_line_4 !='' or alt_applicant_country !=''">
			<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ALTERNATE_PARTY_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="alt_applicant_name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ALT_APPLICANT_NAME')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="alt_applicant_name"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Display address -->
						<xsl:if test="alt_applicant_address_line_1[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ALT_APPLICANT_ADDRESS')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="alt_applicant_address_line_1"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="alt_applicant_address_line_2[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="alt_applicant_address_line_2"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="alt_applicant_dom[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="alt_applicant_dom"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="alt_applicant_address_line_4[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="alt_applicant_address_line_4"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="alt_applicant_country[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ALT_APPLICANT_COUNTRY')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getCodeData($language,'*','*','C006',alt_applicant_country)"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="alt_applicant_cust_ref[.!='']">
						<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ALTERNATE_APPLICANT_REF')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="alt_applicant_cust_ref"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						</xsl:if>
						</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
			
			<xsl:if test="(lc_type [.!='04' and .!='02'] or tnx_type_code !='01' or (lc_type[.='02'] and $isLcStructuredFormatAccess)) and beneficiary_name !=''">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<!--Beneficiary Details-->
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="beneficiary_name"/>
							</xsl:with-param>
						</xsl:call-template>
						<!-- Address -->
						<xsl:if test="applicant_address_line_1[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="beneficiary_address_line_1"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="beneficiary_address_line_2[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="beneficiary_address_line_2"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="beneficiary_dom[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="beneficiary_dom"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="beneficiary_address_line_4[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="beneficiary_address_line_4"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					<xsl:if test="beneficiary_country[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'COUNTRY')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<!-- <xsl:value-of select="beneficiary_country" /> -->
								<xsl:value-of select="localization:getCodeData($language,'*','*','C006',beneficiary_country)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
						<xsl:if test="beneficiary_reference[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="beneficiary_reference"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="(lc_type [.!='04' and .!='02'] or tnx_type_code !='01' or (lc_type[.='02'] and $isLcStructuredFormatAccess)) and issuing_bank !=''">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<!--Issuing Bank Details-->
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ISSUING_BANK')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_SWIFT_CODE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="issuing_bank/iso_code"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="issuing_bank/name"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BIC_CODE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="issuing_bank/iso_code"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!--Amount Details-->
			<fo:block id="amountdetails"/>
			<!-- <fo:block> -->
			<!-- <fo:block keep-together="always"> -->
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
						<xsl:choose>
             				<xsl:when test="not($swift2018Enabled) or ($swift2018Enabled and sub_tnx_type_code[.='11'])">
                             	<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_DETAILS')"/>
              				</xsl:when>
              				<xsl:otherwise>
                             	<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_CONFIRMATION_DETAILS')"/> 
             				</xsl:otherwise>
                     	</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					<!--Form of LC-->
					<xsl:if test="irv_flag[.!=''] and ntrf_flag[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="irv_flag[. = 'Y']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_IRREVOCABLE')"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_REVOCABLE')"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="ntrf_flag[. = 'Y']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_NON_TRANSFERABLE')"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_TRANSFERABLE')"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:if test="stnd_by_lc_flag[. = 'Y']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_STAND_BY')"/>
									</xsl:if>
									<xsl:if test="revolving_flag[. = 'Y']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_REVOLVING')"/>
									</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if
						test="ntrf_flag[.!=''] and ntrf_flag[.='N'] and narrative_transfer_conditions/text[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'TRANSFER_CONDITION')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of
									select="narrative_transfer_conditions/text" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="cfm_inst_code[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_CFM_INST_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="cfm_inst_code[. = '01']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_CFM_INST_CONFIRM')"/>
									</xsl:when>
									<xsl:when test="cfm_inst_code[. = '02']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_CFM_INST_MAY_ADD')"/>
									</xsl:when>
									<xsl:when test="cfm_inst_code[. = '03']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_CFM_INST_WITHOUT')"/>
									</xsl:when>
									<xsl:otherwise/>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="lc_amt[.!='']">
						<xsl:choose>
						<xsl:when test="tnx_type_code[.='03'] and tnx_stat_code[.!='04'] and $swift2018Enabled">
      						<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_LC_AMT_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="lc_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="lc_amt"/>
								</xsl:with-param>
							</xsl:call-template>
      					</xsl:when>
      					<xsl:when test="tnx_type_code[.='03'] and tnx_stat_code[.!='04']">
      						<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_LC_AMT_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="lc_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="org_previous_file/lc_tnx_record/lc_amt"/>
								</xsl:with-param>
							</xsl:call-template>
      					</xsl:when>
      					<xsl:otherwise>					
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_LC_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="lc_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="lc_amt"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<!-- MPS-41651- Available Amount -->
					<xsl:if test="not(tnx_id) or lc_available_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_AVAILABLE_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="lc_cur_code"/> <xsl:value-of select="lc_available_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="not(tnx_id) or lc_liab_amt[.!=''] and security:isBank($rundata)">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="lc_cur_code"/> <xsl:value-of select="lc_liab_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text"/>
						<xsl:with-param name="right_text"/>
					</xsl:call-template>
					<xsl:if test="po_activated[. = 'Y']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ASSISTANT')"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					<xsl:if test="lc_type[.!='04'] or tnx_type_code[.!='01']">
						<fo:table-row>
							<fo:table-cell>
								<fo:block space-before.conditionality="retain" space-before.optimum="10.0pt"/>
							</fo:table-cell>
						</fo:table-row>
						<!--Variation in Drawing-->
						<xsl:if test="pstv_tol_pct[.!=''] or neg_tol_pct[.!=''] or max_cr_desc_code[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						 <xsl:if test="org_previous_file/lc_tnx_record/pstv_tol_pct[.!=''] and pstv_tol_pct[. = '']">
						 <xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="org_previous_file/lc_tnx_record/pstv_tol_pct"/>%
								</xsl:with-param>
							</xsl:call-template>
						 </xsl:if>
						<xsl:if test="pstv_tol_pct[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="pstv_tol_pct"/>%
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						 <xsl:if test="org_previous_file/lc_tnx_record/neg_tol_pct[.!=''] and neg_tol_pct[. = '']">
						<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="org_previous_file/lc_tnx_record/neg_tol_pct"/>%
								</xsl:with-param>
							</xsl:call-template>
							</xsl:if>
						<xsl:if test="neg_tol_pct[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								       <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="neg_tol_pct"/>%
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="not($swift2018Enabled)">
						<xsl:if test="max_cr_desc_code[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
										<xsl:choose>
											<xsl:when test="max_cr_desc_code[. = '3']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_NOTEXCEEDING')"/>
											</xsl:when>
											<xsl:otherwise/>
										</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						</xsl:if>
						
						<!-- Charges Born By Flags -->
						<xsl:if test="open_chrg_brn_by_code[.='01' or .='02']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_ISS_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="open_chrg_brn_by_code[. = '01']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_APPLICANT')"/>
										</xsl:when>
										<xsl:when test="open_chrg_brn_by_code[. = '02']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BENEFICIARY')"/>
										</xsl:when>
										<xsl:otherwise/>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="corr_chrg_brn_by_code[.='01' or .='02']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_CORR_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="corr_chrg_brn_by_code[. = '01']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_APPLICANT')"/>
										</xsl:when>
										<xsl:when test="corr_chrg_brn_by_code[. = '02']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BENEFICIARY')"/>
										</xsl:when>
										<xsl:otherwise/>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="is_MT798[.='N'] and cfm_chrg_brn_by_code[.='01' or .='02'] and $confirmationChargesEnabled">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_CFM_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<fo:block font-weight="bold">
										<xsl:choose>
											<xsl:when test="cfm_chrg_brn_by_code[. = '01']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_APPLICANT')"/>
											</xsl:when>
											<xsl:when test="cfm_chrg_brn_by_code[. = '02']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BENEFICIARY')"/>
											</xsl:when>
											<xsl:otherwise/>
										</xsl:choose>
									</fo:block>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
							<xsl:if test="$swift2018Enabled and is_MT798[.='N']">
							<xsl:if test="amd_chrg_brn_by_code[.='01' or .='02' or .='07' or .='05' or .='09']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_AMD_LABEL')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<fo:block font-weight="bold">
											<xsl:choose>
												<xsl:when test="amd_chrg_brn_by_code[. = '01']">
													<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_APPLICANT')"/>
												</xsl:when>
												<xsl:when test="amd_chrg_brn_by_code[. = '02']">
													<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BENEFICIARY')"/>
												</xsl:when>
												<xsl:when test="amd_chrg_brn_by_code[. = '07']">
													<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_OTHER')"/>
												</xsl:when>
												<xsl:when test="amd_chrg_brn_by_code[. = '05']">
													<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_SHARED')"/>
												</xsl:when>
												<xsl:when test="amd_chrg_brn_by_code[. = '09']">
													<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_NONE')"/>
												</xsl:when>
												<xsl:otherwise/>
											</xsl:choose>
										</fo:block>
									</xsl:with-param>
								</xsl:call-template>
								<xsl:if test="amd_chrg_brn_by_code[. = '07' or .='05']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text"/>									
									<xsl:with-param name="right_text">
										<fo:block font-weight="bold">										
											<xsl:value-of select="narrative_amend_charges_other"/>											
										</fo:block>
									</xsl:with-param>
								</xsl:call-template>
								</xsl:if>
							</xsl:if>
							</xsl:if>
					</xsl:if>
					<xsl:if test="applicable_rules[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_RULES_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getDecode($language, 'N065', applicable_rules)"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="applicable_rules[.='99']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text"/>
								<xsl:with-param name="right_text">
									<xsl:value-of select="applicable_rules_text"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>	
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<!--  </fo:block> -->
			<!--Renewal Details-->
			<fo:block id="renewaldetails"/>
			<xsl:if test="renew_flag[. = 'Y'] and stnd_by_lc_flag[. = 'Y']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_DETAILS_LABEL')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_RENEW_ON')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="renew_on_code[.= '01']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/>
									</xsl:when>
									<xsl:when test="renew_on_code[.= '02']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CALENDAR')"/><xsl:text> </xsl:text><xsl:value-of select="renewal_calendar_date"/>
									</xsl:when>
									<xsl:otherwise/>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_RENEW_FOR')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="renew_for_nb"/> <xsl:value-of select="localization:getDecode($language, 'N074', renew_for_period)"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="advise_renewal_flag[. = 'Y']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_ADVISE_FO')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_DAYS_NOTICE')"/>&nbsp;<xsl:value-of select="advise_renewal_days_nb"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>

						<xsl:if test="rolling_renewal_flag[. = 'Y']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_ROLLING_RENEWAL_FO')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_RENEW_ON')"/> <xsl:choose>
											<xsl:when test="rolling_renew_on_code[.= '01']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/>
											</xsl:when>
											<xsl:when test="rolling_renew_on_code[.= '03']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EVERY')"/>
											</xsl:when>
										</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="rolling_renew_for_nb[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="localization:getGTPString($language, 'FREQUENCY_LABEL')"/> <xsl:value-of select="rolling_renew_for_nb"/> <xsl:value-of select="localization:getDecode($language, 'N074', rolling_renew_for_period)"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="rolling_day_in_month[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_ROLLING_DAY_IN_MONTH')"/> <xsl:value-of select="rolling_day_in_month"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_NUMBER_RENEWALS')"/> <xsl:value-of select="rolling_renewal_nb"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CANCELLATION_NOTICE')"/> <xsl:value-of select="rolling_cancellation_days"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="rolling_renewal_flag[. = 'N'] and rolling_renewal_nb[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_NUMBER_RENEWALS')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="rolling_renewal_nb"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="renew_amt_code[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_AMOUNT')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getDecode($language, 'N075', renew_amt_code)"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="projected_expiry_date[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_PROJECTED_EXPIRY_DATE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="projected_expiry_date"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="final_expiry_date[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_FINAL_EXPIRY_DATE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="final_expiry_date"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!--Revolving Details-->
			<xsl:if test="revolving_flag[.='Y']">
				<fo:block id="revolvingdetails"/>
				<!-- <fo:block> -->
				<!-- <fo:block keep-together="always"> -->
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REVOLVING_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="revolve_period[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_REVOLVE_PERIOD')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="$language='fr'"><xsl:value-of select="translate(format-number(revolve_period, '###,###,###,###,###'), ',', ' ' )" /></xsl:when>
							    	<xsl:otherwise><xsl:value-of select="format-number(revolve_period, '###,###,###,###,###')"/></xsl:otherwise>
							    </xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="revolve_frequency[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_REVOLVE_FREQUENCY')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getDecode($language, 'C049', revolve_frequency)"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="revolve_time_no[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_REVOLVE_TIME_NUMBER')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="$language='fr'"><xsl:value-of select="translate(format-number(revolve_time_no, '###,###,###,###,###'), ',', ' ' )" /></xsl:when>
							    	<xsl:otherwise><xsl:value-of select="format-number(revolve_time_no, '###,###,###,###,###')"/></xsl:otherwise>
							    </xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="cumulative_flag[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									&nbsp;
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="cumulative_flag[.='Y']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CUMULATIVE')"/></xsl:when>
										<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_NON_CUMULATIVE')"/></xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="next_revolve_date[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_NEXT_REVOLVE_DATE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="next_revolve_date"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="notice_days[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_NOTICE_DAYS')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="$language='fr'"><xsl:value-of select="translate(format-number(notice_days, '###,###,###,###,###'), ',', ' ' )" /></xsl:when>
							    	<xsl:otherwise><xsl:value-of select="format-number(notice_days, '###,###,###,###,###')"/></xsl:otherwise>
							    </xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="charge_upto[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_UPTO')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getDecode($language, 'C050', charge_upto)"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			
			<xsl:if test="lc_type[.!='04' and .!='02'] or tnx_type_code !='01' or (lc_type = '02' and $isLcStructuredFormatAccess = 'Y')">
				<!--Payment Details-->
				<fo:block id="paymentdetails"/>
				<!--Call Template for Credit Available With Bank-->
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PAYMENT_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:apply-templates select="credit_available_with_bank">
							<xsl:with-param name="theNodeName" select="'credit_available_with_bank'"/>
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_LABEL')"/>
						</xsl:apply-templates>
						<xsl:if test="cr_avl_by_code !=''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="cr_avl_by_code[. = '01']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_PAYMENT')"/>
									</xsl:when>
									<xsl:when test="cr_avl_by_code[. = '02']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_ACCEPTANCE')"/>
									</xsl:when>
									<xsl:when test="cr_avl_by_code[. = '03']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_NEGOTIATION')"/>
									</xsl:when>
									<xsl:when test="cr_avl_by_code[. = '04']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_DEFERRED')"/>
									</xsl:when>
									<xsl:when test="cr_avl_by_code[. = '05']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_MIXED')"/>
									</xsl:when>
									<xsl:otherwise/>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
						<!-- Not required to show as this field is not shown on the UI and preview screen -->
                        <!-- <xsl:call-template name="table_cell">
                            <xsl:with-param name="left_text">
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_TYPE')"/>
                            </xsl:with-param>
                            <xsl:with-param name="right_text">
                                <xsl:value-of select="credit_available_with_bank_type"/>
                            </xsl:with-param>
                        </xsl:call-template> -->
						<xsl:if test="draft_term[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:choose>
										<xsl:when test="cr_avl_by_code[. = '02'] or cr_avl_by_code[. = '03']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAFT_LABEL')"/>
										</xsl:when>
										<xsl:when test="cr_avl_by_code[. = '05']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_MIXED_DETAILS')"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_PAYMT_LABEL')"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="tenor_maturity_date[.! = '']">
											<xsl:value-of select="localization:getGTPString($language, 'MATURITY_DATE')"/><xsl:text> </xsl:text><xsl:value-of select="tenor_maturity_date"/>
									    </xsl:when>
									    <xsl:otherwise>
									    	<xsl:value-of select="draft_term"/>
									    </xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				<!--Drawee Details Bank-->
				<xsl:if test="drawee_details_bank/name[.!='']">
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:apply-templates select="drawee_details_bank">
								<xsl:with-param name="theNodeName" select="'drawee_details_bank'"/>
								<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_LABEL')"/>
							</xsl:apply-templates>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="lc_type !='02' or (lc_type = '02' and $isLcStructuredFormatAccess = 'Y')">
				<!--Shipment Details-->
				<!--Shipment From, To, Partial and Trans Shipments-->
				<fo:block id="shipmentdetails"/>
				<xsl:if test="ship_from[.!=''] or ship_loading[.!=''] or ship_discharge[.!=''] or ship_to[.!=''] or part_ship_detl[.!=''] or tran_ship_detl[.!=''] or last_ship_date[.!=''] or inco_term[.!=''] or inco_place[.!=''] ">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SHIPMENT_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<!--Shipment From, To, Partial and Trans Shipments-->
						<xsl:if test="ship_from[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_SHIP_FROM')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ship_from"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- SWIFT 2006 -->
						<xsl:if test="ship_loading[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_SHIP_LOADING')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ship_loading"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="ship_discharge[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_SHIP_DISCHARGE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ship_discharge"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- SWIFT 2006 -->
						<xsl:if test="ship_to[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_SHIP_TO')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ship_to"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="part_ship_detl[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="part_ship_detl[. = 'ALLOWED']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/>
									</xsl:when>
									<xsl:when test="part_ship_detl[. = 'NOT ALLOWED']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/>
									</xsl:when>
									<xsl:when test="part_ship_detl[. = 'NONE']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NONE')" />
									</xsl:when>
									<xsl:when test="part_ship_detl[. = 'CONDITIONAL']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_CONDITIONAL')" />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="part_ship_detl"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:if test="tran_ship_detl[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<!-- SWIFT 2018 -->
								<xsl:choose>
								<xsl:when test="$swift2018Enabled">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL_LC')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL')"/>
								</xsl:otherwise>
							</xsl:choose>
								
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="tran_ship_detl[. = 'ALLOWED']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/>
									</xsl:when>
									<xsl:when test="tran_ship_detl[. = 'NOT ALLOWED']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/>
									</xsl:when>
									<xsl:when test="tran_ship_detl[. = 'NONE']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NONE')" />
									</xsl:when>
									<xsl:when test="tran_ship_detl[. = 'CONDITIONAL']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_CONDITIONAL')" />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="tran_ship_detl"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:if test="last_ship_date[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_LAST_SHIP_DATE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="last_ship_date"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
							<xsl:if test="inco_term_year[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_INCO_TERM_YEAR')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="inco_term_year"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="inco_term[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_INCO_TERM')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getCodeData($language,'*','*','N212',inco_term)"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="inco_place[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_INCO_PLACE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="inco_place"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
                        <!-- transport mode always shown if there is any value if there is not value show Others -->
                          <xsl:if test="transport_mode[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRANSPORT_MODE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="transport_mode[. = 'AIRT'  or . = 'SEAT' or . = 'RAIL' or . = 'ROAD' or . = 'MULT']">
										<xsl:value-of select="localization:getDecode($language, 'N803', transport_mode)"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRANSPORT_MODE_OTHR')"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>						
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
			</xsl:if>
			</xsl:if>
			<!-- </fo:block> -->
			<!--Bank Details-->
				<fo:block id="bankdetails"/>
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
							<xsl:choose>
             					<xsl:when test="not($swift2018Enabled) or ($swift2018Enabled and sub_tnx_type_code[.='11'])">
                             		<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BANK_DETAILS')"/>
              					</xsl:when>
              					<xsl:otherwise>
                             		<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BANK_DETAILS_LC')"/>
             					</xsl:otherwise>
                     		</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:apply-templates select="issuing_bank">
							<xsl:with-param name="theNodeName" select="'issuing_bank'"/>
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ISSUING_BANK')"/>
						</xsl:apply-templates>
						<xsl:variable name="appl_ref">
                                          <xsl:value-of select="applicant_reference"/>
                        </xsl:variable>
                        
                        <!-- Added the customer check for MPS-58881 -->
                         <xsl:if test="security:isCustomer($rundata))">
                         <xsl:call-template name="table_cell">                        
                                  <xsl:with-param name="left_text">
                                         <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CUST_REFERENCE')"/>
                                  </xsl:with-param>
                                  <xsl:with-param name="right_text">
 								  <xsl:choose>
                                        <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) &gt;= 1 or count(//*/avail_main_banks/bank/entity/customer_reference) &gt;= 1">
                                        <xsl:choose>
                                        <xsl:when test="defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'">
                                        <xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]/reference)"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                        <xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]/description"/>
                                        </xsl:otherwise>
                                        </xsl:choose>
                                       </xsl:when>
                                       <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) = 0 or count(//*/avail_main_banks/bank/entity/customer_reference) = 0">
                                           <xsl:choose>
                                           <xsl:when test="defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'">
                                           <xsl:choose>
                                           <xsl:when test="//*/avail_main_banks/bank/entity/customer_reference/description[.!='']">
                                                        <xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank/customer_reference/reference)"/>
                                                   </xsl:when>
                                                   <xsl:when test="//*/avail_main_banks/bank[./abbv_name = //*[name()='issuing_bank']/abbv_name]/customer_reference[reference=$appl_ref]/description[.!='']">
                                                          <xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank[./abbv_name = //*[name()='issuing_bank']/abbv_name]/customer_reference[reference=$appl_ref]/reference)"/>
                                                     </xsl:when>
                                                   <xsl:otherwise>
                                                        <xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank/customer_reference/reference)"/>   
                                                   </xsl:otherwise>
                                           </xsl:choose>
                                           </xsl:when>
                                           <xsl:otherwise>
                                           <xsl:choose>
                                                   <xsl:when test="//*/avail_main_banks/bank/entity/customer_reference/description[.!='']">
                                                        <xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank/customer_reference/reference)"/>
                                                   </xsl:when>
                                                   <xsl:when test="//*/avail_main_banks/bank[./abbv_name = //*[name()='issuing_bank']/abbv_name]/customer_reference[reference=$appl_ref]/description[.!='']">
                                                          <xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank[./abbv_name = //*[name()='issuing_bank']/abbv_name]/customer_reference[reference=$appl_ref]/reference)"/>
                                                     </xsl:when>
                                                   <xsl:otherwise>
                                                        <xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank/customer_reference/reference)"/>   
                                                   </xsl:otherwise>
                                                   </xsl:choose>
                                            </xsl:otherwise>
                                           </xsl:choose>
                                        </xsl:when>
                                    </xsl:choose>
                                  </xsl:with-param>
                         </xsl:call-template>
                         </xsl:if>
						<xsl:variable name="iss_bank">
								<xsl:value-of select="//lc_tnx_record/issuing_bank/abbv_name"/>
							</xsl:variable>
						<xsl:choose>
								<xsl:when test="$swift2018Enabled">
									<xsl:if test="advising_bank/name[.!=''] or advising_bank/iso_code[.!='']">
										<xsl:apply-templates select="advising_bank">
											<xsl:with-param name="theNodeName" select="'advising_bank'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ADVISING_BANK')"/>
										</xsl:apply-templates>
									</xsl:if>
									<xsl:if test="advise_thru_bank/name[.!=''] or advise_thru_bank/iso_code[.!='']">
										<xsl:apply-templates select="advise_thru_bank">
											<xsl:with-param name="theNodeName" select="'advise_thru_bank'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_BENEFICIARY_BANK')"/>
										</xsl:apply-templates>
									</xsl:if>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="advising_bank/name[.!=''] or advising_bank/iso_code[.!='']">
										<xsl:apply-templates select="advising_bank">
											<xsl:with-param name="theNodeName" select="'advising_bank'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ADVISING_BANK')"/>
										</xsl:apply-templates>
									</xsl:if>
									<xsl:if test="advise_thru_bank/name[.!=''] or advise_thru_bank/iso_code[.!='']">
										<xsl:apply-templates select="advise_thru_bank">
											<xsl:with-param name="theNodeName" select="'advise_thru_bank'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_BENEFICIARY_BANK')"/>
										</xsl:apply-templates>
									</xsl:if>
								</xsl:otherwise>
						</xsl:choose>
						
						<!-- SWIFT 2018 -->
						<xsl:if test="$swift2018Enabled">
							<xsl:if test="requested_confirmation_party/name[.!=''] or requested_confirmation_party/iso_code[.!=''] or //req_conf_party_flag[. !='']">
								<xsl:apply-templates select="requested_confirmation_party">
									<xsl:with-param name="theNodeName" select="'requested_confirmation_party'"/>
									<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_REQUESTED_CONFIRMATION_PARTY')"/>
								</xsl:apply-templates>
							</xsl:if>
						</xsl:if>
						
					</xsl:with-param>
				</xsl:call-template>
			
					<!-- Facility/Limit Details -->
			<xsl:if test="//limit_details/limit_reference[.!='']">	
				<fo:block id="limitdetails"/>
				<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FACILITY_LIMIT_SECTION')"/>
						</xsl:with-param>
					</xsl:call-template>

					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_FACILITY_REFERENCE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="limit_details/facility_reference"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="facility_date[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_FACILITY_DATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="facility_date"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_LIMIT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_LIMIT_REFERENCE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="limit_details/limit_reference"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="limit_review_date[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_LIMIT_DATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="limit_review_date"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
            		<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_BOOKING_AMOUNT')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="limit_details/cur_code"/>&nbsp;<xsl:value-of select="limit_details/booking_amt"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="(lc_type !='02' or (lc_type = '02' and $isLcStructuredFormatAccess = 'Y'))  and ((security:isBank($rundata) and  securitycheck:hasPermission($rundata,'tradeadmin_ls_access')) or (security:isCustomer($rundata) and securitycheck:hasPermission($rundata,'ls_access') = 'true')) and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true'">
			<!-- linked licenses -->
			<fo:block id="linkedlicensedetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINKED_LICENSES')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:choose>
				<xsl:when test="linked_licenses/license">
					<fo:block keep-together="always">
					<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
						<fo:table-column column-width="{$pdfTableWidth}"/>		
						<fo:table-column column-width="0"/> <!--  dummy column -->
						<fo:table-body>
							<fo:table-row>
							<fo:table-cell>
							<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
						      	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
			  				       	<fo:table-column column-width="20.0pt"/>
			  				       	<fo:table-column column-width="proportional-column-width(2)"/>
						        	<fo:table-column column-width="proportional-column-width(2)"/>
						        	<fo:table-column column-width="proportional-column-width(2)"/>
						        	<fo:table-column column-width="proportional-column-width(2)"/>
						        	<fo:table-column column-width="proportional-column-width(1)"/>
						        	<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
										<fo:table-row text-align="center">
										<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'BO_REF')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'LICENSE_NUMBER')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'LS_ALLOCATED_AMT')"/></fo:block></fo:table-cell>
						        		</fo:table-row>
						        	</fo:table-header>
						        	<fo:table-body>
							        		<xsl:for-each select="linked_licenses/license">
							        		<fo:table-row>
												<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
													<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="ls_ref_id"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
													<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="bo_ref_id"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
													<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="ls_number"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
													<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:value-of select="ls_allocated_amt"/>
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
			  </xsl:when>
			  <xsl:otherwise>
				  <xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NO_LINKED_LS_ITEMS')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			  </xsl:otherwise>
		  </xsl:choose>
		  </xsl:if>
			<!--Narrative Details-->
			<fo:block id="narativedetails"/>
			<xsl:choose>
				<xsl:when test="$swift2018Enabled and (defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'false') and 
				(tnx_stat_code [ .='01'] or tnx_stat_code [ .='02'] or tnx_stat_code[.='03'] or tnx_stat_code[.='05'] or tnx_stat_code[.='06'])">
		<xsl:if test="(lc_type[.!='04' and .!='02'] or tnx_type_code !='01' or 
		(lc_type = '02' and $isLcStructuredFormatAccess = 'Y')) and
		((narrative_description_goods != '' or //narrative_description_goods != '') or 
		(narrative_documents_required != '' or //narrative_documents_required != '') or 
		(narrative_additional_instructions != '' or //narrative_additional_instructions != '') or narrative_charges != '' 
		or narrative_additional_amount != '' or narrative_payment_instructions != '' or narrative_period_presentation !='' 
		or narrative_shipment_period != '' or free_format_text != '' or narrative_sender_to_receiver != '' 
		or narrative_paying_bank_instructions != '' or (narrative_special_beneficiary != '' or //narrative_special_beneficiary != '') 
		or (narrative_special_recvbank != '' or //narrative_special_recvbank != ''))">
		<fo:block white-space-collapse="false">
							<fo:table font-family="{$pdfFontData}" space-before.conditionality="retain" space-before.optimum="20.0pt" width="{$pdfTableWidth}">
								<fo:table-column column-width="{$pdfTableWidth}"/>
								<fo:table-column column-width="0"/>
								<fo:table-body>
									<xsl:call-template name="title2">
										<xsl:with-param name="text">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_NARRATIVE_DETAILS')"/>
										</xsl:with-param>
									</xsl:call-template>
									<xsl:choose>
										<xsl:when test="narrative_description_goods[.!='']">
											<xsl:apply-templates select="narrative_description_goods">
												<xsl:with-param name="theNodeName" select="'narrative_description_goods'"/>
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS')"/>
											</xsl:apply-templates>
										</xsl:when>
										<xsl:when test="//narrative_description_goods[.!=''] and //narrative_description_goods/issuance/data/datum/text[.!='']">
										<xsl:choose>
											<xsl:when test="org_previous_file/lc_tnx_record/narrative_description_goods[.!='']">
												<xsl:apply-templates select="org_previous_file/lc_tnx_record/narrative_description_goods">
													<xsl:with-param name="theNodeName" select="'narrative_description_goods'"/>
													<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS')"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="//org_previous_file/lc_tnx_record/narrative_description_goods">
													<xsl:with-param name="theNodeName" select="'narrative_description_goods'"/>
													<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS')"/>
												</xsl:apply-templates>
											</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
									</xsl:choose>
								</fo:table-body>
							</fo:table>
							</fo:block>
									 <xsl:if test="defaultresource:getResource('PURCHASE_ORDER_ASSISTANT') = 'true'">
   						
									<xsl:call-template name="purchase-order"/> 
									</xsl:if> 
									
									<xsl:if test="not(security:isBank($rundata)) and narrative_description_goods[.!='']">
									
									</xsl:if>
								<xsl:if test="((narrative_documents_required != '' or //narrative_documents_required != '') 
								or (narrative_additional_instructions != '' or //narrative_additional_instructions != '') 
								or narrative_charges != '' or narrative_additional_amount != '' or narrative_payment_instructions != '' 
								or narrative_period_presentation !='' or narrative_shipment_period != '' or narrative_sender_to_receiver != '' 
								or narrative_paying_bank_instructions != '')">
								<fo:block white-space-collapse="false">
								<fo:table font-family="{$pdfFontData}" space-before.conditionality="retain" space-before.optimum="20.0pt" width="{$pdfTableWidth}">
								<fo:table-column column-width="{$pdfTableWidth}"/>
								<fo:table-column column-width="0"/>
								<fo:table-body>
									<xsl:choose>
										<xsl:when test="narrative_documents_required[.!='']">
											<xsl:apply-templates select="narrative_documents_required">
												<xsl:with-param name="theNodeName" select="'narrative_documents_required'"/>
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED')"/>
											</xsl:apply-templates>
										</xsl:when>
										<xsl:when test="//narrative_documents_required[.!=''] and //narrative_documents_required/issuance/data/datum/text[.!='']">
										<xsl:choose>
										<xsl:when test="org_previous_file/lc_tnx_record/narrative_documents_required[.!='']">
											<xsl:apply-templates select="org_previous_file/lc_tnx_record/narrative_documents_required">
												<xsl:with-param name="theNodeName" select="'narrative_documents_required'"/>
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED')"/>
											</xsl:apply-templates>
										</xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates select="//org_previous_file/lc_tnx_record/narrative_documents_required">
												<xsl:with-param name="theNodeName" select="'narrative_documents_required'"/>
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED')"/>
											</xsl:apply-templates>
										</xsl:otherwise>
										</xsl:choose>
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="narrative_additional_instructions[.!='']">
											<xsl:apply-templates select="narrative_additional_instructions">
												<xsl:with-param name="theNodeName" select="'narrative_additional_instructions'"/>
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS')"/>
											</xsl:apply-templates>
										</xsl:when>
										<xsl:when test="//narrative_additional_instructions[.!=''] and //narrative_additional_instructions/issuance/data/datum/text[.!='']">
										<xsl:choose>
											<xsl:when test="org_previous_file/lc_tnx_record/narrative_additional_instructions">
												<xsl:apply-templates select="org_previous_file/lc_tnx_record/narrative_additional_instructions">
													<xsl:with-param name="theNodeName" select="'narrative_additional_instructions'"/>
													<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS')"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="//org_previous_file/lc_tnx_record/narrative_additional_instructions">
													<xsl:with-param name="theNodeName" select="'narrative_additional_instructions'"/>
													<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS')"/>
												</xsl:apply-templates>
											</xsl:otherwise>
										</xsl:choose>
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="narrative_special_beneficiary[.!='']">
											<xsl:apply-templates select="narrative_special_beneficiary">
												<xsl:with-param name="theNodeName" select="'narrative_special_beneficiary'"/>
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF')"/>
											</xsl:apply-templates>
										</xsl:when>
										<xsl:when test="//narrative_special_beneficiary[.!=''] and //narrative_special_beneficiary/issuance/data/datum/text[.!='']">
										<xsl:choose>
											<xsl:when test="org_previous_file/lc_tnx_record/narrative_special_beneficiary">
												<xsl:apply-templates select="org_previous_file/lc_tnx_record/narrative_special_beneficiary">
													<xsl:with-param name="theNodeName" select="'narrative_special_beneficiary'"/>
													<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF')"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="//org_previous_file/lc_tnx_record/narrative_special_beneficiary">
													<xsl:with-param name="theNodeName" select="'narrative_special_beneficiary'"/>
													<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF')"/>
												</xsl:apply-templates>
											</xsl:otherwise>
										</xsl:choose>
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="security:isBank($rundata) and narrative_special_recvbank[.!='']">
											<xsl:apply-templates select="narrative_special_recvbank">
												<xsl:with-param name="theNodeName" select="'narrative_special_recvbank'"/>
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV')"/>
											</xsl:apply-templates>
										</xsl:when>
										<xsl:when test="security:isBank($rundata) and //narrative_special_recvbank[.!=''] and //narrative_special_recvbank/issuance/data/datum/text[.!='']">
										<xsl:choose>
											<xsl:when test="org_previous_file/lc_tnx_record/narrative_special_recvbank">
												<xsl:apply-templates select="org_previous_file/lc_tnx_record/narrative_special_recvbank">
													<xsl:with-param name="theNodeName" select="'narrative_special_recvbank'"/>
													<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV')"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="//org_previous_file/lc_tnx_record/narrative_special_recvbank">
													<xsl:with-param name="theNodeName" select="'narrative_special_recvbank'"/>
													<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV')"/>
												</xsl:apply-templates>
											</xsl:otherwise>
										</xsl:choose>
										</xsl:when>
									</xsl:choose>
									<xsl:if test="narrative_charges[.!='']">
										<xsl:apply-templates select="narrative_charges">
											<xsl:with-param name="theNodeName" select="'narrative_charges'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_CHARGES')"/>
										</xsl:apply-templates>
									</xsl:if>
									<xsl:if test="narrative_additional_amount[.!='']">
										<xsl:apply-templates select="narrative_additional_amount">
											<xsl:with-param name="theNodeName" select="'narrative_additional_amount'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_AMOUNT')"/>
										</xsl:apply-templates>
									</xsl:if>
									<xsl:if test="narrative_payment_instructions[.!='']">
										<xsl:apply-templates select="narrative_payment_instructions">
											<xsl:with-param name="theNodeName" select="'narrative_payment_instructions'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS')"/>
										</xsl:apply-templates>
									</xsl:if>
									<!-- Commented for Swift 2018 Changes -->
									<!-- <xsl:if test="narrative_period_presentation[.!='']">
										<xsl:apply-templates select="narrative_period_presentation">
											<xsl:with-param name="theNodeName" select="'narrative_period_presentation'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_PERIOD_PRESENTATION')"/>
										</xsl:apply-templates>
									</xsl:if> -->
									<xsl:if test="narrative_shipment_period[.!='']">
										<xsl:apply-templates select="narrative_shipment_period">
											<xsl:with-param name="theNodeName" select="'narrative_shipment_period'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SHIPMENT_PERIOD')"/>
										</xsl:apply-templates>
									</xsl:if>
									<xsl:if test="narrative_sender_to_receiver[.!='']">
										<xsl:apply-templates select="narrative_sender_to_receiver">
											<xsl:with-param name="theNodeName" select="'narrative_sender_to_receiver'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SENDER_TO_RECEIVER')"/>
										</xsl:apply-templates>
									</xsl:if>
									<xsl:if test="narrative_paying_bank_instructions[.!='']">
										<xsl:apply-templates select="narrative_paying_bank_instructions">
											<xsl:with-param name="theNodeName" select="'narrative_paying_bank_instructions'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_PAYING_BANK_INSTRUCTIONS')"/>
										</xsl:apply-templates>
									</xsl:if>
								</fo:table-body>
							</fo:table>
						</fo:block>
						</xsl:if>
					</xsl:if>
		</xsl:when>
				<xsl:when test="$swift2018Enabled and (defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true')">
					<xsl:if test="(lc_type[.!='04' and .!='02'] or tnx_type_code !='01' or (lc_type = '02' and $isLcStructuredFormatAccess = 'Y')) and ((narrative_description_goods != '' or //narrative_description_goods != '') or (narrative_documents_required != '' or //narrative_documents_required != '') or (narrative_additional_instructions != '' or //narrative_additional_instructions != '') or narrative_charges != '' or narrative_additional_amount != '' or narrative_payment_instructions != '' or narrative_period_presentation !='' or narrative_shipment_period != '' or free_format_text != '' or narrative_sender_to_receiver != '' or narrative_paying_bank_instructions != '' or (narrative_special_beneficiary != '' or //narrative_special_beneficiary != '') or (narrative_special_recvbank != '' or //narrative_special_recvbank != ''))">
						<xsl:call-template name="pdfExtendedNarrative"/>
						 <xsl:if test="defaultresource:getResource('PURCHASE_ORDER_ASSISTANT') = 'true'">
   								 <xsl:call-template name="purchase-order"/>
							</xsl:if>			 
						<xsl:if test="(narrative_charges != '' or narrative_additional_amount != '' or narrative_payment_instructions != '' or narrative_shipment_period != '' or narrative_sender_to_receiver != '' or narrative_paying_bank_instructions != '')">
						<fo:block white-space-collapse="false">
						<fo:table font-family="{$pdfFontData}" space-before.conditionality="retain" space-before.optimum="20.0pt" width="{$pdfTableWidth}">
						<fo:table-column column-width="{$pdfTableWidth}"/>
						<fo:table-column column-width="0"/> <!--  dummy column -->
						<fo:table-body>
							<xsl:if test="narrative_charges[.!='']">
								<xsl:apply-templates select="narrative_charges">
									<xsl:with-param name="theNodeName" select="'narrative_charges'"/>
									<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_CHARGES')"/>
								</xsl:apply-templates>
							</xsl:if>
							<xsl:if test="narrative_additional_amount[.!='']">
								<xsl:apply-templates select="narrative_additional_amount">
									<xsl:with-param name="theNodeName" select="'narrative_additional_amount'"/>
									<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_AMOUNT')"/>
								</xsl:apply-templates>
							</xsl:if>
							<xsl:if test="narrative_payment_instructions[.!='']">
								<xsl:apply-templates select="narrative_payment_instructions">
									<xsl:with-param name="theNodeName" select="'narrative_payment_instructions'"/>
									<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS')"/>
								</xsl:apply-templates>
							</xsl:if>
							<xsl:if test="narrative_period_presentation[.!='']">
								<xsl:apply-templates select="narrative_period_presentation">
									<xsl:with-param name="theNodeName" select="'narrative_period_presentation'"/>
									<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_PERIOD_PRESENTATION')"/>
								</xsl:apply-templates>
							</xsl:if>
							<xsl:if test="narrative_shipment_period[.!='']">
								<xsl:apply-templates select="narrative_shipment_period">
									<xsl:with-param name="theNodeName" select="'narrative_shipment_period'"/>
									<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SHIPMENT_PERIOD')"/>
								</xsl:apply-templates>
							</xsl:if>
							<xsl:choose>
								<xsl:when test="security:isBank($rundata)">
									<xsl:if test="narrative_sender_to_receiver[.!='']">
										<xsl:apply-templates select="narrative_sender_to_receiver">
											<xsl:with-param name="theNodeName" select="'narrative_sender_to_receiver'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SENDER_TO_RECEIVER')"/>
										</xsl:apply-templates>
									</xsl:if>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="free_format_text[.!='']">
										<xsl:apply-templates select="free_format_text">
											<xsl:with-param name="theNodeName" select="'free_format_text'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SENDER_TO_RECEIVER')"/>
										</xsl:apply-templates>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:if test="narrative_paying_bank_instructions[.!='']">
								<xsl:apply-templates select="narrative_paying_bank_instructions">
									<xsl:with-param name="theNodeName" select="'narrative_paying_bank_instructions'"/>
									<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_PAYING_BANK_INSTRUCTIONS')"/>
								</xsl:apply-templates>
							</xsl:if>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</xsl:if>
		</xsl:if>
		</xsl:when>
		<xsl:when test="$swift2018Enabled and (defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'false')">
		
		<xsl:if test="(lc_type[.!='04' and .!='02'] or tnx_type_code !='01' or (lc_type = '02' and $isLcStructuredFormatAccess = 'Y')) 
					and 
					((narrative_description_goods != '' or //narrative_description_goods != '') or
					(narrative_documents_required != '' or //narrative_documents_required != '') or
					(narrative_additional_instructions != '' or //narrative_additional_instructions != '')
					  or narrative_charges != '' or narrative_additional_amount != '' or narrative_payment_instructions != '' 
					  or narrative_period_presentation !='' or narrative_shipment_period != '' or free_format_text != '' 
					  or narrative_sender_to_receiver != '' or narrative_paying_bank_instructions != '' 
					  or (narrative_special_beneficiary != '' or //narrative_special_beneficiary != '') or 
					  (narrative_special_recvbank != '' or //narrative_special_recvbank != ''))">
							<fo:block white-space-collapse="false">
							<fo:table font-family="{$pdfFontData}" space-before.conditionality="retain" space-before.optimum="20.0pt" width="{$pdfTableWidth}">
								<fo:table-column column-width="{$pdfTableWidth}"/>
								<fo:table-column column-width="0"/> <!--  dummy column -->
								<fo:table-body>
									<xsl:call-template name="title2">
										<xsl:with-param name="text">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_NARRATIVE_DETAILS')"/>
										</xsl:with-param>
									</xsl:call-template>
									<xsl:choose>
										<xsl:when test="narrative_description_goods[.!='']">
											<xsl:apply-templates select="narrative_description_goods">
												<xsl:with-param name="theNodeName" select="'narrative_description_goods'"/>
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS')"/>
											</xsl:apply-templates>
										</xsl:when>
										<xsl:when test="//narrative_description_goods[.!=''] and //narrative_description_goods/issuance/data/datum/text[.!='']">
										<xsl:choose>
											<xsl:when test="original_xml/lc_tnx_record/narrative_description_goods[.!='']">
												<xsl:apply-templates select="original_xml/lc_tnx_record/narrative_description_goods">
													<xsl:with-param name="theNodeName" select="'narrative_description_goods'"/>
													<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS')"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="//original_xml/lc_tnx_record/narrative_description_goods">
													<xsl:with-param name="theNodeName" select="'narrative_description_goods'"/>
													<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS')"/>
												</xsl:apply-templates>
											</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
									</xsl:choose>
								</fo:table-body>
							</fo:table>
							</fo:block>
									 <xsl:if test="defaultresource:getResource('PURCHASE_ORDER_ASSISTANT') = 'true'">
   						
									<xsl:call-template name="purchase-order"/> 
									</xsl:if> 
									
									<xsl:if test="not(security:isBank($rundata)) and narrative_description_goods[.!='']">
									
									</xsl:if>
								<xsl:if test="((narrative_documents_required != '' or //narrative_documents_required != '') or (narrative_additional_instructions != '' or //narrative_additional_instructions != '') or narrative_charges != '' or narrative_additional_amount != '' or narrative_payment_instructions != '' or narrative_period_presentation !='' or narrative_shipment_period != '' or narrative_sender_to_receiver != '' or narrative_paying_bank_instructions != '')">
								<fo:block white-space-collapse="false">
								<fo:table font-family="{$pdfFontData}" space-before.conditionality="retain" space-before.optimum="20.0pt" width="{$pdfTableWidth}">
								<fo:table-column column-width="{$pdfTableWidth}"/>
								<fo:table-column column-width="0"/>
								<fo:table-body>
									<xsl:choose>
										<xsl:when test="narrative_documents_required[.!='']">
											<xsl:apply-templates select="narrative_documents_required">
												<xsl:with-param name="theNodeName" select="'narrative_documents_required'"/>
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED')"/>
											</xsl:apply-templates>
										</xsl:when>
										<xsl:when test="//narrative_documents_required[.!=''] and //narrative_documents_required/issuance/data/datum/text[.!='']">
										<xsl:choose>
										<xsl:when test="original_xml/lc_tnx_record/narrative_documents_required[.!='']">
											<xsl:apply-templates select="original_xml/lc_tnx_record/narrative_documents_required">
												<xsl:with-param name="theNodeName" select="'narrative_documents_required'"/>
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED')"/>
											</xsl:apply-templates>
										</xsl:when>
										<xsl:otherwise>
											<xsl:apply-templates select="//original_xml/lc_tnx_record/narrative_documents_required">
												<xsl:with-param name="theNodeName" select="'narrative_documents_required'"/>
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED')"/>
											</xsl:apply-templates>
										</xsl:otherwise>
										</xsl:choose>
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="narrative_additional_instructions[.!='']">
											<xsl:apply-templates select="narrative_additional_instructions">
												<xsl:with-param name="theNodeName" select="'narrative_additional_instructions'"/>
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS')"/>
											</xsl:apply-templates>
										</xsl:when>
										<xsl:when test="//narrative_additional_instructions[.!=''] and //narrative_additional_instructions/issuance/data/datum/text[.!='']">
										<xsl:choose>
											<xsl:when test="original_xml/lc_tnx_record/narrative_additional_instructions">
												<xsl:apply-templates select="original_xml/lc_tnx_record/narrative_additional_instructions">
													<xsl:with-param name="theNodeName" select="'narrative_additional_instructions'"/>
													<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS')"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="//original_xml/lc_tnx_record/narrative_additional_instructions">
													<xsl:with-param name="theNodeName" select="'narrative_additional_instructions'"/>
													<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS')"/>
												</xsl:apply-templates>
											</xsl:otherwise>
										</xsl:choose>
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="narrative_special_beneficiary[.!='']">
											<xsl:apply-templates select="narrative_special_beneficiary">
												<xsl:with-param name="theNodeName" select="'narrative_special_beneficiary'"/>
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF')"/>
											</xsl:apply-templates>
										</xsl:when>
										<xsl:when test="//narrative_special_beneficiary[.!=''] and //narrative_special_beneficiary/issuance/data/datum/text[.!='']">
										<xsl:choose>
											<xsl:when test="original_xml/lc_tnx_record/narrative_special_beneficiary">
												<xsl:apply-templates select="original_xml/lc_tnx_record/narrative_special_beneficiary">
													<xsl:with-param name="theNodeName" select="'narrative_special_beneficiary'"/>
													<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF')"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="//original_xml/lc_tnx_record/narrative_special_beneficiary">
													<xsl:with-param name="theNodeName" select="'narrative_special_beneficiary'"/>
													<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF')"/>
												</xsl:apply-templates>
											</xsl:otherwise>
										</xsl:choose>
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="security:isBank($rundata) and narrative_special_recvbank[.!='']">
											<xsl:apply-templates select="narrative_special_recvbank">
												<xsl:with-param name="theNodeName" select="'narrative_special_recvbank'"/>
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV')"/>
											</xsl:apply-templates>
										</xsl:when>
										<xsl:when test="security:isBank($rundata) and //narrative_special_recvbank[.!=''] and //narrative_special_recvbank/issuance/data/datum/text[.!='']">
										<xsl:choose>
											<xsl:when test="original_xml/lc_tnx_record/narrative_special_recvbank">
												<xsl:apply-templates select="original_xml/lc_tnx_record/narrative_special_recvbank">
													<xsl:with-param name="theNodeName" select="'narrative_special_recvbank'"/>
													<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV')"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="//original_xml/lc_tnx_record/narrative_special_recvbank">
													<xsl:with-param name="theNodeName" select="'narrative_special_recvbank'"/>
													<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV')"/>
												</xsl:apply-templates>
											</xsl:otherwise>
										</xsl:choose>
										</xsl:when>
									</xsl:choose>
									<xsl:if test="narrative_charges[.!='']">
										<xsl:apply-templates select="narrative_charges">
											<xsl:with-param name="theNodeName" select="'narrative_charges'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_CHARGES')"/>
										</xsl:apply-templates>
									</xsl:if>
									<xsl:if test="narrative_additional_amount[.!='']">
										<xsl:apply-templates select="narrative_additional_amount">
											<xsl:with-param name="theNodeName" select="'narrative_additional_amount'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_AMOUNT')"/>
										</xsl:apply-templates>
									</xsl:if>
									<xsl:if test="narrative_payment_instructions[.!='']">
										<xsl:apply-templates select="narrative_payment_instructions">
											<xsl:with-param name="theNodeName" select="'narrative_payment_instructions'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS')"/>
										</xsl:apply-templates>
									</xsl:if>
									<!-- Commented for Swift 2018 Changes -->
									<!-- <xsl:if test="narrative_period_presentation[.!='']">
										<xsl:apply-templates select="narrative_period_presentation">
											<xsl:with-param name="theNodeName" select="'narrative_period_presentation'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_PERIOD_PRESENTATION')"/>
										</xsl:apply-templates>
									</xsl:if> -->
									<xsl:if test="narrative_shipment_period[.!='']">
										<xsl:apply-templates select="narrative_shipment_period">
											<xsl:with-param name="theNodeName" select="'narrative_shipment_period'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SHIPMENT_PERIOD')"/>
										</xsl:apply-templates>
									</xsl:if>
									<xsl:if test="narrative_sender_to_receiver[.!='']">
										<xsl:apply-templates select="narrative_sender_to_receiver">
											<xsl:with-param name="theNodeName" select="'narrative_sender_to_receiver'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SENDER_TO_RECEIVER')"/>
										</xsl:apply-templates>
									</xsl:if>
									<xsl:if test="narrative_paying_bank_instructions[.!='']">
										<xsl:apply-templates select="narrative_paying_bank_instructions">
											<xsl:with-param name="theNodeName" select="'narrative_paying_bank_instructions'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_PAYING_BANK_INSTRUCTIONS')"/>
										</xsl:apply-templates>
									</xsl:if>
								</fo:table-body>
							</fo:table>
						</fo:block>
						</xsl:if>
					</xsl:if>
		</xsl:when>
		</xsl:choose>
			<!-- SWIFT 2018 -->
			<fo:block id="periodPresentation"/>
			<xsl:if test="$swift2018Enabled">
			<xsl:if test="period_presentation_days[.!=''] or narrative_period_presentation[.!='']">
			<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
							<fo:block>							
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TAB_PERIOD_PRESENTATION_IN_DAYS')"/>
							</fo:block>
							</xsl:with-param>
						</xsl:call-template>						
					<xsl:if test="period_presentation_days[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PERIOD_NO_OF_DAYS')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="period_presentation_days"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="narrative_period_presentation[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_TAB_PERIOD_DESCRIPTION')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="narrative_period_presentation"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				</xsl:if>
				
			<xsl:if test="return_comments[.!=''] and tnx_stat_code[.!='03' and .!='04']">  <!-- MPS-43899 -->
			<fo:block font-size="{$pdfFontSize}" keep-together="always" white-space-collapse="false">
				<fo:block id="description"/>
				<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
					<fo:table-column column-width="{$pdfTableWidth}"/>
					<fo:table-column column-width="0"/> <!--  dummy column -->
					<fo:table-body>
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_MC_COMMENTS_FOR_RETURN')"/>
							</xsl:with-param>
						</xsl:call-template>
						<fo:table-row>
							<fo:table-cell>
								<fo:block space-before.conditionality="retain" space-before.optimum="10.0pt" start-indent="20.0pt">
									<xsl:value-of select="return_comments"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			</xsl:if>

			<xsl:if test="narrative_full_details[.!='']">
				<!--Standby LC Full Details-->
				<fo:block>
					<fo:table font-family="{$pdfFontData}" font-size="11pt" space-before.conditionality="retain" space-before.optimum="10.0pt" width="{$pdfTableWidth}">
						<fo:table-column column-width="{$pdfTableWidth}"/>
						<fo:table-column column-width="0"/> <!--  dummy column -->
						<fo:table-body>
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:choose>
										<xsl:when test="lc_type != '02' or (lc_type = '02' and $isLcStructuredFormatAccess = 'Y')">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREEFORMAT_NARRATIVE')"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_NARRATIVE_DETAILS')"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block space-before.conditionality="retain" space-before.optimum="10.0pt" start-indent="20.0pt" white-space-collapse="false" linefeed-treatment="preserve" white-space="pre" font-size="{$pdfFontSize}" font-weight="bold">
										<xsl:value-of select="narrative_full_details"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</xsl:if>
			<xsl:if test="security:isBank($rundata) and stnd_by_lc_flag[. = 'Y'] and $swift2019Enabled">
						<fo:block id="bankInstrDetails"/>
						<xsl:call-template name="table_template">
							<xsl:with-param name="text">
								<xsl:call-template name="title">
									<xsl:with-param name="text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_DELIVERY_INSTRUCTIONS')"/>
									</xsl:with-param>
								</xsl:call-template>
								
								<xsl:if test="delv_org[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE')"/></xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="delv_org[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_COLLECTION')"/>&nbsp;</xsl:when>
										<xsl:when test="delv_org[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_COURIER')"/>&nbsp;</xsl:when>
										<xsl:when test="delv_org[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_MAIL')"/>&nbsp;</xsl:when>
										<xsl:when test="delv_org[.='04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_MESSENGER')"/>&nbsp;</xsl:when>
										<xsl:when test="delv_org[.='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_REGISTERED_MAIL')"/>&nbsp;</xsl:when>
										<xsl:when test="delv_org[.='99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_OTHER')"/>&nbsp;</xsl:when>
									</xsl:choose>
								</xsl:with-param>		
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="delv_org_text[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text"/>
								<xsl:with-param name="right_text"><xsl:value-of select="delv_org_text"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						
						<xsl:if test="delivery_to[.!=''] or narrative_delivery_to/text[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_DELIVERY_TO_COLLECTION_BY')"/></xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:variable name="delv_to_code"><xsl:value-of select="delivery_to"></xsl:value-of></xsl:variable>								
									<xsl:value-of select="localization:getDecode($language, 'N292', $delv_to_code)"/>
								</xsl:with-param>		
							</xsl:call-template>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="right_text">
									<xsl:if test="narrative_delivery_to/text[.!='']">
										<xsl:value-of select="narrative_delivery_to/text"/>
									</xsl:if>
								</xsl:with-param>		
							</xsl:call-template>
						</xsl:if>
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