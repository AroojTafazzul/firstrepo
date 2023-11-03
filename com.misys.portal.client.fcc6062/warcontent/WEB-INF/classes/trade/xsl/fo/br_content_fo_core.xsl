<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<!--
		Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com), All
		Rights Reserved.
	-->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:formatter="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	version="1.0">
	
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl" />
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	<xsl:variable name="background">
		BLACK
	</xsl:variable>
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>

	<xsl:template match="br_tnx_record">
		<!-- HEADER-->
		

		<!-- FOOTER-->
		

		<!-- BODY-->
		
	<xsl:call-template name="header"/>
    <xsl:call-template name="footer"/>
    <xsl:call-template name="body"/>
  </xsl:template>
<xsl:template name="header">
    <fo:static-content flow-name="xsl-region-before">
			<xsl:call-template name="header_advising_bank"/>
		</fo:static-content>
  </xsl:template>
  <xsl:template name="body">
    <fo:flow flow-name="xsl-region-body" font-size="{$pdfFontSize}">
			<!--
				<fo:block space-before="75.0pt"
				space-before.conditionality="retain">
			-->

			<xsl:call-template name="disclammer_template"/>
			
				<xsl:if test="((not(tnx_id) and tnx_type_code[.!='']) or (tnx_type_code[.!='01'] and tnx_type_code[.!='03'] and tnx_type_code[.!='04'] and tnx_type_code[.!='13'] and tnx_type_code[.!='15']) or preallocated_flag[.='Y'])">
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
                                                              <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')" />
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
		<xsl:if test="(not(tnx_id) or tnx_stat_code[.='04']) and security:isBank($rundata)">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BANK_MESSAGE')" />		
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="bo_release_dttm[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_DTTM')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of
									select="formatter:formatReportDate(bo_release_dttm,$rundata)" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
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
				<xsl:if test="claim_reference[.!='']">
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CLAIM_REFERENCE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="claim_reference" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="claim_present_date[.!='']">
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CLAIM_PRESENT_DATE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="claim_present_date" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="claim_amt[.!=''] and claim_cur_code[.!='']">
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CLAIM_AMOUNT_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="claim_cur_code" />&nbsp;<xsl:value-of select="claim_amt" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			<xsl:if test="bo_comment[.!='']">
			<fo:block page-break-before="always">
				<fo:table width="{$pdfTableWidth}" 
					font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
					<fo:table-column column-width="{$pdfTableWidth}" />
					<fo:table-column column-width="0" />
					<fo:table-body>
						<xsl:call-template name="subtitle2">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language,'XSL_REPORTINGDETAILS_COMMENT_BANK')" />
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
			<xsl:if test="action_req_code[.!='']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ACTION_REQUIRED')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of
									select="localization:getDecode($language, 'N042', action_req_code)" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="attachments/attachment[type = '02']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_BANK_FILE_UPLOAD')" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="table_2_columns_template">
					<xsl:with-param name="table_width">100%</xsl:with-param>
					<xsl:with-param name="column_1_width">50%</xsl:with-param>
					<xsl:with-param name="column_2_width">50%</xsl:with-param>
					<xsl:with-param name="text">					
						<xsl:call-template name="table_cell_2_columns">
							<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_TITLE')"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
							<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_NAME')"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
						</xsl:call-template>
						<xsl:for-each select="attachments/attachment">
						<xsl:if test="type = '02'">
						<xsl:variable name="filename"><xsl:value-of select="file_name"/></xsl:variable>
						<xsl:variable name="title"><xsl:value-of select="title"/></xsl:variable>
						<xsl:variable name="colWidth">35%</xsl:variable>
						<xsl:call-template name="table_cell_2_columns">
							<xsl:with-param name="column_1_text"><xsl:value-of select="formatter:wrapStringforPDF($colWidth,$title)" /></xsl:with-param>
							<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_weight"/>
							<xsl:with-param name="column_1_text_align">left</xsl:with-param>
							<xsl:with-param name="column_2_text"><xsl:value-of select="formatter:wrapStringforPDF($colWidth,$filename)" /></xsl:with-param>
							<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_weight"/>
							<xsl:with-param name="column_2_text_align">left</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						</xsl:for-each>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="attachments/attachment[type = '07']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTIONAL_ATTACHMENT')" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="table_2_columns_template">
					<xsl:with-param name="table_width">100%</xsl:with-param>
					<xsl:with-param name="column_1_width">50%</xsl:with-param>
					<xsl:with-param name="column_2_width">50%</xsl:with-param>
					<xsl:with-param name="text">					
						<xsl:call-template name="table_cell_2_columns">
							<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_TITLE')"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
							<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_NAME')"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
						</xsl:call-template>
						<xsl:for-each select="attachments/attachment">
						<xsl:if test="type = '07'">
						<xsl:call-template name="table_cell_2_columns">
							<xsl:with-param name="column_1_text"><xsl:value-of select="title" /></xsl:with-param>
							<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_weight"/>
							<xsl:with-param name="column_1_text_align">left</xsl:with-param>
							<xsl:with-param name="column_2_text"><xsl:value-of select="file_name" /></xsl:with-param>
							<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_weight"/>
							<xsl:with-param name="column_2_text_align">left</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						</xsl:for-each>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
      </xsl:if>
					<xsl:if test="security:isBank($rundata) and (not(tnx_id) or tnx_stat_code[.='05' or .='04' or .='15'])">
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
                                                <xsl:value-of select="company_name"/>
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
	                                  <xsl:choose>
                                  <xsl:when test="bo_ref_id[.!=''] and (not(tnx_id) or tnx_type_code[.!='01'])">
                                  	<xsl:call-template name="table_cell">
                                  		<xsl:with-param name="left_text">
                                  			<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')" />
                                  		</xsl:with-param>
                                  		<xsl:with-param name="right_text">
                                  			<xsl:value-of select="bo_ref_id" />
                                  		</xsl:with-param>
                                  	</xsl:call-template>
                                  </xsl:when>
                                   <xsl:when test="bo_ref_id[.!=''] and tnx_type_code[.='01']">
                                  	<xsl:call-template name="table_cell">
                                  		<xsl:with-param name="left_text">
                                  			<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')" />
                                  		</xsl:with-param>
                                  		<xsl:with-param name="right_text">
                                  			<xsl:value-of select="bo_ref_id" />
                                  		</xsl:with-param>
                                  	</xsl:call-template>
                                  </xsl:when>
                                  </xsl:choose>
                                  <xsl:if test="cust_ref_id[.!=''] and tnx_type_code[.='13'] and sub_tnx_type_code[.='25']">
                                  <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="cust_ref_id"/>
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
                                  <xsl:if test="tnx_type_code[.='13'] and sub_tnx_type_code[.='' or .='24' or .='25']">
                                  	<xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_RELEASE_DTTM')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="convertTools:formatReportDate(release_dttm,$rundata)"/>
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
                                  <xsl:if test="(not(tnx_id) or tnx_type_code[.!='01' and .!='13']) and prod_stat_code[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_NEW_TNX_STAT_LABEL')"/>
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:choose>
												<xsl:when test="prod_stat_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_03_NEW')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_04_ACCEPTED')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_05_SETTLED')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='06']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_06_CANCELLED')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_07_UPDATED')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_08_AMENDED')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='09']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_09_EXTENDED')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='10']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_10_PURGED')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='11']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_11_RELEASED')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='12']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_12_DISCREPANT')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='13']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_13_PART_SETTLED')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='14']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_14_PART_SIGHT_PAYMT')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='15']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_15_FULL_SIGHT_PAYMT')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='16']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_16_NOTIFICATION_OF_CHARGES')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='24']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_24_REQUEST_FOR_SETTLEMENT')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='26']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_26_CLEAN')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='31']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_31_AMENDMENT_AWAITING_BENEFICIARY_APPROVAL')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='32']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_32_AMENDMENT_REFUSED')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='42']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_42_EXPIRED')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='78']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_78_WORDING_UNDER_REVIEW')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='79']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_79_FINAL_WORDING')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='81']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_81_CANCEL_AWAITING_BENEFICIARY_RESPONSE')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='82']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_82_CANCEL_REFUSED')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='84']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_84_CLAIM_PRESENTATION')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='85']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_85_CLAIM_SETTLEMENT')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='86']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_86_EXTEND_PAY')"/></xsl:when> 
												<xsl:when test="prod_stat_code[.='66']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_66_ESTABLISHED')"/></xsl:when>
											    <xsl:when test="prod_stat_code[.='72']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_72_PO_ESTABLISHED')"/></xsl:when>     
											</xsl:choose>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="tnx_type_code[.='13'] and sub_tnx_type_code[.='' or .='24' or .='25']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_NEW_TNX_STAT_LABEL')"/>
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:choose>
												<xsl:when test="prod_stat_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/></xsl:when>
												<xsl:when test="prod_stat_code[.='07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_APPROVED')"/></xsl:when>
											</xsl:choose>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
                             <xsl:if test="bo_ref_id[.!=''] and tnx_type_code[.='01']">
                             <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                         <xsl:value-of select="bo_ref_id"/>
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
                             <xsl:if test="action_req_code[.!='']">
                             <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ACTION_REQUIRED')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                         <xsl:choose>
          <xsl:when test="action_req_code[.='99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CUSTOMER_INSTRUCTIONS')"/></xsl:when>
          <xsl:when test="action_req_code[.='12']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_DISCREPANCY_RESPONSE')"/></xsl:when>
          <xsl:when test="action_req_code[.='26']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CLEAN_RESPONSE')"/></xsl:when>
          <xsl:when test="action_req_code[.='07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CONSENT_RESPONSE')"/></xsl:when>
          <xsl:when test="action_req_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_AMENDMENT_RESPONSE')"/></xsl:when>
          <xsl:when test="action_req_code[.='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CANCEL_RESPONSE')"/></xsl:when>
         </xsl:choose>
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
			 	 <xsl:if test="iss_date_type_code[.!='']">
					   <xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_DATE_TYPE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="iss_date_type_code[. = '01']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ISSUANCE')"/>
								</xsl:when>
								<xsl:when test="iss_date_type_code[. = '02']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_CONTRACT_SIGN')"/>
								</xsl:when>
								<xsl:when test="iss_date_type_code[. = '03']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ADV_PAYMT')"/>
								</xsl:when>
								<xsl:when test="iss_date_type_code[. = '99']">
                                                   <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_OTHER')"/>
								</xsl:when>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
                     </xsl:if>
                     <xsl:if test="iss_date_type_details[.!='']">
                       <xsl:call-template name="table_cell">
                          <xsl:with-param name="left_text"/>
                          <xsl:with-param name="right_text">
                             <xsl:value-of select="iss_date_type_details"/>
                          </xsl:with-param>
                       </xsl:call-template>
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
                     <xsl:if test="exp_date_type_code[. = '01' or . = '02' or . = '03']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_DATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="exp_date_type_code[. = '02']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_FIXED')"/>
								</xsl:when>
								<xsl:when test="exp_date_type_code[. = '03']">
                                                     <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_PROJECTED')"/>
								</xsl:when>
								<xsl:when test="exp_date_type_code[. = '01']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_NONE')"/>
								</xsl:when>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
                     </xsl:if>
					<xsl:if test="exp_date[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<fo:block font-weight="bold">
									<xsl:value-of select="exp_date"/>
								</fo:block>
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
					<xsl:if test="amd_date[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_AMD_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="amd_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="related_ref[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_RELATED_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="related_ref"/>
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
				</xsl:with-param>
			</xsl:call-template>
			<!--Beneficiary Details-->
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test = "beneficiary_abbv_name!=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ABBV_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="beneficiary_abbv_name"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="beneficiary_name"/>
						</xsl:with-param>
					</xsl:call-template>
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
					<xsl:if test="beneficiary_address_line_4[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="beneficiary_address_line_4"/>
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
					<!-- <xsl:if test="beneficiary_reference[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="beneficiary_reference"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if> -->
				</xsl:with-param>
			</xsl:call-template>

			<!--Applicant Details-->
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_APPLICANT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="applicant_name"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- Address -->
					<xsl:if test="applicant_address_line_1[.!='']">					
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="applicant_address_line_1"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
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
					<!-- <xsl:if test="entity[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ENTITY')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="entity"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if> -->
					<xsl:if test="applicant_reference[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="utils:decryptApplicantReference(applicant_reference)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			
			<!--Renewal Details-->
			<fo:block id="renewaldetails"/>
			<xsl:if test="renew_flag = 'Y' ">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_DETAILS_LABEL')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="renew_on_code[.= '01' or .= '02']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_RENEW_ON')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="renew_on_code= '01'">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/>
									</xsl:when>
									<xsl:when test="renew_on_code= '02'">
										  <xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CALENDAR')"/>
									</xsl:when>
									<xsl:otherwise/>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:if test="renew_on_code[.= '02']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="renew_on_code[.= '02']">
										<xsl:value-of select="renewal_calendar_date"/>
									</xsl:when>
									<xsl:otherwise/>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_RENEW_FOR')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="renew_for_nb"/> <xsl:value-of select="localization:getDecode($language, 'N074', renew_for_period)"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="advise_renewal_flag = 'Y'">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_ADVISE_FO')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_DAYS_NOTICE')"/> <xsl:value-of select="advise_renewal_days_nb"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>

						<xsl:if test="rolling_renewal_flag[. = 'Y'] or rolling_renewal_nb[.!='']">
							<xsl:call-template name="subtitle">
									<xsl:with-param name="text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_RENEWAL_ROLLING_RENEWAL_FO')" />
									</xsl:with-param>
								</xsl:call-template>
								<xsl:if test="rolling_renew_on_code[.= '01' or .= '03']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_RENEW_ON')"/> 
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<!-- <xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_RENEW_ON')"/>  -->
									<xsl:choose>
											<xsl:when test="rolling_renew_on_code = '01'">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/>
											</xsl:when>
											<xsl:when test="rolling_renew_on_code = '03'">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EVERY')"/>
											</xsl:when>
										</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
							</xsl:if>
							<xsl:if test="rolling_renew_for_nb !=''">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="localization:getGTPString($language, 'FREQUENCY_LABEL')"/> <xsl:value-of select="rolling_renew_for_nb"/> <xsl:value-of select="localization:getDecode($language, 'N074', rolling_renew_for_period)"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="rolling_day_in_month !='' ">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_ROLLING_DAY_IN_MONTH')"/> <xsl:value-of select="rolling_day_in_month"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="rolling_renewal_nb !='' ">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_NUMBER_RENEWALS')"/> <xsl:value-of select="rolling_renewal_nb"/>
								</xsl:with-param>
							</xsl:call-template>
							</xsl:if>
							<xsl:if test="rolling_cancellation_days !='' ">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CANCELLATION_NOTICE')"/> <xsl:value-of select="rolling_cancellation_days"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						</xsl:if>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_AMOUNT')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getDecode($language, 'N075', renew_amt_code)"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="projected_expiry_date != '' ">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_PROJECTED_EXPIRY_DATE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="projected_expiry_date"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="final_expiry_date != '' ">
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

			<!--Amount Details-->
			<fo:block id="amountdetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<!--Guarantee Currency and Amount-->
					<xsl:if test="bg_amt[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_GTEE_AMT_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="bg_cur_code"/> <xsl:value-of select="bg_amt"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="bg_liab_amt[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_AMT_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="bg_cur_code"/> <xsl:value-of select="bg_liab_amt"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!-- MPS-41651- Available Amount -->
					<xsl:if test="not(tnx_id) or bg_available_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_AVAILABLE_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bg_cur_code"/> <xsl:value-of select="bg_available_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="bg_release_flag[. = 'Y']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_GTEE_RELEASE_YES')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text"> </xsl:with-param>
						</xsl:call-template>
					</xsl:if>
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
					<xsl:if test="advising_bank/name[.!='']">
						<xsl:apply-templates select="advising_bank">
							<xsl:with-param name="theNodeName" select="'advising_bank'"/>
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ADVISING_BANK')"/>
						</xsl:apply-templates>
					</xsl:if>
					<!--
						<fo:table-row keep-with-previous="always"> <fo:table-cell>
						<fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt"
						start-indent="20.0pt"> <xsl:value-of
						select="localization:getGTPString($language,
						'XSL_BANKDETAILS_TYPE_LABEL')"/> </fo:block> </fo:table-cell>
						<fo:table-cell> <fo:block font-weight="bold"
						space-before.optimum="10.0pt"> <xsl:choose> <xsl:when
						test="issuing_bank_type_code[. = '01']"> <xsl:value-of
						select="localization:getGTPString($language,
						'XSL_BANKDETAILS_TYPE_RECIPIENT')"/> </xsl:when> <xsl:when
						test="issuing_bank_type_code[. = '02']"> <xsl:value-of
						select="localization:getGTPString($language,
						'XSL_BANKDETAILS_TYPE_OTHER')"/> </xsl:when> </xsl:choose>
						</fo:block> </fo:table-cell> </fo:table-row>
					-->
					
						
							<xsl:apply-templates select="issuing_bank">
								<xsl:with-param name="theNodeName" select="'issuing_bank'"/>
								<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language,'XSL_BANKDETAILS_TAB_ISSUING_BANK')"/>
							</xsl:apply-templates>
					
					<xsl:if test="confirming_bank/name[.!='']">
						<xsl:apply-templates select="confirming_bank">
							<xsl:with-param name="theNodeName" select="'confirming_bank'"/>
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_CONFIRMING_BANK')"/>
						</xsl:apply-templates>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			
			<!-- linked licenses -->
			<xsl:if test="((security:isBank($rundata) and  securitycheck:hasPermission($rundata,'tradeadmin_ls_access')) or (security:isCustomer($rundata) and securitycheck:hasPermission($rundata,'ls_access') = 'true')) and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true'">
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
		  
			<!--Guarantee Details-->
			<fo:block id="guaranteedetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GTEE_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:variable name="gtee_type_code">
            <xsl:value-of select="bg_type_code"/>
          </xsl:variable>
                    <xsl:variable name="productCode">
            <xsl:value-of select="product_code"/>
          </xsl:variable>
                    <xsl:variable name="subProductCode">
            <xsl:value-of select="sub_product_code"/>
          </xsl:variable>
					<xsl:variable name="parameterId">C011</xsl:variable>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $gtee_type_code)"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="bg_rule[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_RULES_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								 <!-- <xsl:choose> -->
									<!-- <xsl:when test="bg_rule[. != '99']"> -->
										<xsl:variable name="rule_code">
											<xsl:value-of select="bg_rule"/>
										</xsl:variable>
										<xsl:variable name="productCode">
                      <xsl:value-of select="product_code"/>
                    </xsl:variable>
										<xsl:variable name="subProductCode">
                      <xsl:value-of select="sub_product_code"/>
                    </xsl:variable>
										<xsl:variable name="parameterId">C013</xsl:variable>
										<xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $rule_code)"/>
									<!-- </xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="bg_rule_other"/>
										</xsl:otherwise>
									</xsl:choose> -->
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="bg_text_type_code[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="bg_text_type_code[. = '01']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_STANDARD')"/>
									</xsl:when>
									<xsl:when test="bg_text_type_code[. = '02']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_ATTACHED')"/>
									</xsl:when>
									<xsl:when test="bg_text_type_code[. = '03']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_SAME_AS')"/> 
										<xsl:value-of select="text_type_details"/>
									</xsl:when>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="bg_text_language[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_LANGUAGE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="bg_text_language[. != '' and . !='*']">
										<xsl:value-of select="localization:getDecode($language, 'N061', bg_text_language)"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="text_language_other"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:if test="contract_ref[.!=''] or contract_narrative[.!=''] or contract_date[.!=''] or tender_expiry_date[.!=''] or contract_amt[.!=''] or contract_pct[.!='']">
			<fo:block id="contractdetails"/>
			<xsl:call-template name="table_template">
			<xsl:with-param name="text">
			<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONTRACT_DETAILS')"/>
						</xsl:with-param>
			</xsl:call-template>	
						 <xsl:variable name="contract_ref_code"><xsl:value-of select="contract_ref"></xsl:value-of></xsl:variable>
		     <xsl:variable name="parameterId">C051</xsl:variable>
		     <xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
				     <xsl:if test="contract_ref[.!='']">
				     	<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_CONTRACT_REF_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $contract_ref_code)"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					 <xsl:if test="contract_narrative[.!='']">
				    	 <xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_NARRATIVE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="contract_narrative"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					<xsl:if test="contract_date[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_CONTRACT_DATE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="contract_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="tender_expiry_date[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TENDER_EXP_DATE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="tender_expiry_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="contract_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_CONTRACT_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
							<xsl:value-of select="contract_cur_code"/> <xsl:value-of select="contract_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="contract_pct[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_CONTRACT_PCT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="contract_pct"/> %
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					</xsl:with-param>
			</xsl:call-template>	
			</xsl:if>
			<!-- Other Instructions Narrative -->
			<xsl:if test="narrative_additional_instructions[.!='']">
				<fo:block white-space-collapse="false" linefeed-treatment="preserve" white-space="pre">
					<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
						<fo:table-column column-width="{$pdfTableWidth}"/>
						<fo:table-column column-width="0"/> <!--  dummy column -->
						<fo:table-body>
							<xsl:apply-templates select="narrative_additional_instructions">
								<xsl:with-param name="theNodeName" select="'narrative_additional_instructions'"/>
								<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_GTEEDETAILS_OTHER_INSTRUCTIONS')"/>
							</xsl:apply-templates>
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
			<!-- </fo:block>-->
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
