<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<!-- Copyright (c) 2006-2012 Misys , All Rights Reserved -->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" 
				xmlns:formatter="xalan://com.misys.portal.common.tools.ConvertTools"
				xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
				xmlns:fo="http://www.w3.org/1999/XSL/Format" 
				xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
				xmlns:security="xalan://com.misys.portal.security.GTPSecurity" 
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils" 
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>

	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>

	<xsl:template match="ls_tnx_record">
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
                                                <xsl:value-of select="company_name"/><!-- 20170807_01 -->
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
                                  
                                  <xsl:if test="bo_ref_id[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="bo_ref_id"/>
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
                                   <xsl:if test="iss_date[.!=''] and product_code[.='LS']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<fo:block font-family="{$pdfFont}">
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ISSUE_DATE')" />
											</fo:block>
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="iss_date" />
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
                                                <xsl:value-of select="amd_no" />
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
											<xsl:when test="prod_stat_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='03' or .='04' or .='05' or .='07' or .='08' or .='11' or .='76']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_APPROVED')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='78']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_78_WORDING_UNDER_REVIEW')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='79']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_79_FINAL_WORDING')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='18']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_18_INPROGRESS')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXSTATCODE_05_STOPOVER_TO_SENT')"/></xsl:when>
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
                          
			</xsl:if>
			
			<fo:block id="gendetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="security:isCustomer($rundata)">
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
					<xsl:if test="bo_ref_id[.!=''] and (not(tnx_id) or tnx_type_code[.!='01'])">
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
					<xsl:if test="amd_no[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_AMD_COUNT')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="amd_no"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LABEL_LICENSE_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="ls_type[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LICENSE_TYPE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getCodeData($language,'*','LS','C026', ls_type)"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:if test="license/license_definition/ls_name[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LICENSE_NAME')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="license/license_definition/ls_name"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:if test="license/license_definition/allow_overdraw[.!='' and .='Y']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LICENSE_ALLOW_OVERDRAW')"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:if test="license/license_definition/allow_multi_ls[.!='' and .='Y']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LICENSE_ALLOW_MULTI_LS')"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:if test="allow_multi_cur[.!='' and .='Y']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LICENSE_MULTI_CURRENCY')"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:if test="ls_number[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LICENSE_NUMBER')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="ls_number"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:if test="auth_reference[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AUTH_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="auth_reference"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:if test="reg_date[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REG_DATE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="reg_date"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						
						<xsl:if test="security:isCustomer($rundata) and iss_date[.!='']">
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
			
			<xsl:if test="applicant_name[.!=''] or applicant_address_line_1[.!=''] or applicant_address_line_2[.!=''] or applicant_dom[.!=''] or applicant_reference[.!=''] or further_identification[.!='']">
				<!--Applicant Details-->
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="license/license_definition/principal_label"/>
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
						</xsl:if>
						
						<xsl:if test="further_identification[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_FURTHER_IDENTIFICATION')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="further_identification"/>
								</xsl:with-param>
							</xsl:call-template>
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
						<!-- Applicant reference is removed under Applicant details as it is available under bank details (in accordance with MPS-39538- removed for LC)-->
						<!-- <xsl:if test="applicant_reference[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="utils:decryptApplicantReference(applicant_reference)"/>   
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if> -->
						
						
						
						<!-- <xsl:if test="applicant_reference/description[.!=''] and //*/avail_main_banks">
							<xsl:variable name="appl_ref">
				               <xsl:value-of select="applicant_reference"/>
				            </xsl:variable>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) &gt;= 1">
									      	<xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]/description"/>
									     </xsl:when>
									     <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) = 0">
									     	<xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$appl_ref]/description"/>
									     </xsl:when>
									</xsl:choose>
									
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if> -->
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="beneficiary_name[.!=''] or beneficiary_address_line_1[.!=''] or beneficiary_address_line_2[.!=''] or beneficiary_dom[.!=''] or beneficiary_reference[.!='']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<!--Beneficiary Details-->
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="license/license_definition/non_principal_label"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="beneficiary_name[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="beneficiary_name"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<!-- Address -->
						<xsl:if test="beneficiary_address_line_1[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="beneficiary_address_line_1"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
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
						<xsl:if test="beneficiary_country[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
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
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<!--Form of LS-->
					<xsl:if test="ls_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_LS_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="ls_cur_code"/> <xsl:value-of select="ls_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="additional_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_ADDITIONAL_AMT')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="additional_cur_code"/> <xsl:value-of select="additional_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="narrative_additional_amount[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_ADDITIONAL_AMT_DETAILS')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="narrative_additional_amount"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="total_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LICENSE_TOTAL_AMT')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="total_cur_code"/> <xsl:value-of select="total_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="ls_liab_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="ls_cur_code"/> <xsl:value-of select="ls_liab_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text"/>
						<xsl:with-param name="right_text"/>
					</xsl:call-template>
					<fo:table-row>
						<fo:table-cell>
							<fo:block space-before.conditionality="retain" space-before.optimum="10.0pt"/>
						</fo:table-cell>
					</fo:table-row>
					<!--Variation in Drawing-->
					<xsl:if test="pstv_tol_pct[.!=''] or neg_tol_pct[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
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
				</xsl:with-param>
			</xsl:call-template>
			<!--  </fo:block> -->
			<xsl:if test="(not(tnx_id) or tnx_type_code[.='01' or .='03' or .='15']) and (valid_from_date[.!=''] or valid_to_date[.!=''])">
				<!--Validity Details-->
				<fo:block id="validitydetails"/>
				<!--Call Template for Credit Available With Bank-->
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_VALIDITY_DETAILS_LABEL')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="valid_from_date[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_VALID_FROM')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="valid_from_date"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:if test="valid_for_nb[.!=''] and valid_for_period[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_VALIDITY_PERIOD')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="valid_for_nb"/> <xsl:value-of select="localization:getCodeData($language,'*','LS','C029', valid_for_period)"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:if test="valid_to_date[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_VALID_TO')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="valid_to_date"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:if test="latest_payment_date[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LATEST_PAYMENT_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="latest_payment_date"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<!--Shipment Details-->
				<!--Shipment From, To, Partial and Trans Shipments-->
				<xsl:if test="origin_country[.!=''] or supply_country[.!=''] or inco_term[.!=''] or inco_place[.!='']">
				<fo:block id="shipmentdetails"/>
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SHIPMENT_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="origin_country[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_CTY_OF_ORIGIN')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getCodeData($language,'*','*','C006',origin_country)"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="supply_country[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_CTY_OF_SUPPLY')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getCodeData($language,'*','*','C006',supply_country)"/>
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
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!-- </fo:block> -->
			<!--Bank Details-->
			<fo:block id="bankdetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BANK_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					
					
					<xsl:if test="issuing_bank/name[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="issuing_bank/name" />
									</xsl:with-param>
								</xsl:call-template>
						</xsl:if>
					
					
					    <xsl:variable name="appl_ref">
                                          <xsl:value-of select="applicant_reference"/>
                        </xsl:variable>
                        <xsl:call-template name="table_cell">
                                  <xsl:with-param name="left_text">
                                         <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CUST_REFERENCE')"/>
                                  </xsl:with-param>
                                  <xsl:with-param name="right_text">
                                <xsl:choose>
										<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) &gt;= 1 or count(//*/avail_main_banks/bank/entity/customer_reference) &gt;= 1">
									      	<xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference/description"/>
									     </xsl:when>
									     <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) = 0 or count(//*/avail_main_banks/bank/entity/customer_reference) = 0">
									         <xsl:choose>
									                 <xsl:when test="//*/avail_main_banks/bank/entity/customer_reference/description[.!='']">
									                      <xsl:value-of select="//*/avail_main_banks/bank/customer_reference/description"/>
									                 </xsl:when>  
									                 <xsl:otherwise>
									                      <xsl:value-of select="utils:decryptApplicantReference(applicant_reference)"/>   
									                 </xsl:otherwise>
									         </xsl:choose>
									    </xsl:when>
									</xsl:choose>

                                  </xsl:with-param>
                         </xsl:call-template>
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
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ADVISE_THRU_BANK')"/>
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
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ADVISE_THRU_BANK')"/>
										</xsl:apply-templates>
									</xsl:if>
								</xsl:otherwise>
						</xsl:choose>
			</xsl:with-param>
		   </xsl:call-template>
			<!--Narrative Details-->
			<fo:block id="narativedetails"/>
			<xsl:if test="ls_type[.!='04'] or tnx_type_code[.!='01']">
				<fo:block white-space-collapse="false">
					<fo:table font-family="{$pdfFontData}" font-size="11pt" space-before.conditionality="retain" space-before.optimum="20.0pt" width="{$pdfTableWidth}">
						<fo:table-column column-width="{$pdfTableWidth}"/>
						<fo:table-column column-width="0"/>
						<fo:table-body>
							<xsl:call-template name="title2">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_NARRATIVE_DETAILS')"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="narrative_description_goods[.!='']">
								<xsl:apply-templates select="narrative_description_goods">
									<xsl:with-param name="theNodeName" select="'narrative_description_goods'"/>
									<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS')"/>
								</xsl:apply-templates>
							</xsl:if>
							<xsl:if test="narrative_additional_instructions[.!='']">
								<xsl:apply-templates select="narrative_additional_instructions">
									<xsl:with-param name="theNodeName" select="'narrative_additional_instructions'"/>
									<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS')"/>
								</xsl:apply-templates>
							</xsl:if>
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
