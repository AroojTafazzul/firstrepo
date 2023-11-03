<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<!--
		Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com), All
		Rights Reserved.
	-->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" 
				xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
				xmlns:fo="http://www.w3.org/1999/XSL/Format" 
				xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
				xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender" 
				xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
				xmlns:formatter="xalan://com.misys.portal.common.tools.ConvertTools"
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>

	<xsl:template match="sg_tnx_record">
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
			
<!--Event Details-->
            <!-- <xsl:if test="not(tnx_stat_code)"> -->
			<fo:block id="eventdetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_EVENT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="release_dttm[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_RELEASE_DTTM')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="formatter:formatReportDate(release_dttm,$rundata)" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="company_name[.!='']">
						<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_COMPANY_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="utils:getCompanyName(ref_id,product_code)"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="product_code[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_CODE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
						<xsl:choose>
			     			<xsl:when test="product_code[.='BK'] and sub_product_code[.!=''] and sub_product_code[.='LNRPN']">
			     			<xsl:value-of select="localization:getDecode($language, 'N001', 'LN')"/></xsl:when>
			      			<xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N001', product_code[.])"/></xsl:otherwise>
       		            </xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="tnx_type_code[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_TYPE')" />
						</xsl:with-param>				
						<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getDecode($language, 'N002', tnx_type_code[.])" />
									<xsl:if test="sub_tnx_type_code and sub_tnx_type_code[.!='']">
									<xsl:value-of select="concat(' ',localization:getDecode($language, 'N003', sub_tnx_type_code[.]))" />
									</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="ref_id[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ref_id"/>
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
					
					<xsl:if test="bo_tnx_id[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_EVENT_REFERENCE')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bo_tnx_id" />
						</xsl:with-param>
					</xsl:call-template>
 	     		    </xsl:if>
					<xsl:if test="issuing_bank/name[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_ISSUING_BANK')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="issuing_bank/name" />
									</xsl:with-param>
								</xsl:call-template>
						</xsl:if>
						 <xsl:if test="iss_date[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ISSUE_DATE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="iss_date" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Application Date -->
						 <xsl:if test="appl_date[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
										<xsl:value-of 
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
										<xsl:value-of select="appl_date" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if> 
						
						<xsl:if test="exp_date[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_DATE')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="exp_date" />
										</xsl:with-param>
									</xsl:call-template>
						</xsl:if>
						<xsl:if test="(sg_amt[.!=''])">
						<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_GTEE_AMT_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
						<xsl:value-of select="concat(sg_cur_code, ' ', sg_amt)" />
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
				<xsl:if test="cross_references/cross_reference/child_product_code[.!='IP' and .!='IN' and .!='PO' and .!='SO' and .!='TD'] and (cross_references/cross_reference/child_ref_id=ref_id and cross_references/cross_reference/ref_id != cross_references/cross_reference/child_ref_id)"> 
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
					<xsl:if test="bo_lc_ref_id[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_LC_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bo_lc_ref_id"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="deal_ref_id[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_GENERALDETAILS_RELATED_REF_ID')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="deal_ref_id" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				
				<!-- Instructions for the Bank Only -->
				<xsl:if test="fee_act_no[. != ''] or principal_act_no[. !=''] or free_format_text[.!='']">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_INSTRUCTIONS')" />
						</xsl:with-param>
					</xsl:call-template>
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
					<xsl:if test="principal_act_no[. !='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="principal_act_no"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="free_format_text[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_CORRESPONDENCE_DETAILS')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="free_format_text"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
				</xsl:if>
				
				</xsl:with-param>
				</xsl:call-template>
				
				<!-- Customer File Upload Section -->
			<xsl:if test="attachments/attachment[type = '01']">
			<xsl:variable name="delivery-channel"><xsl:value-of select="delivery_channel"/></xsl:variable>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_CUSTOMER_FILE_UPLOAD')" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:choose>
				<!-- File Act send mode needs uses 3 columned template and the rest uses 2 columned tempalte. -->
				<xsl:when test="delivery_channel and delivery_channel[.='FACT']">
					<xsl:call-template name="table_3_columns_template">
						<xsl:with-param name="table_width">100%</xsl:with-param>
						<xsl:with-param name="column_1_width">45%</xsl:with-param>
						<xsl:with-param name="column_2_width">45%</xsl:with-param>
						<xsl:with-param name="column_3_width">10%</xsl:with-param>
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_TITLE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_NAME')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
								<xsl:with-param name="column_3_text">
									<xsl:choose>
										<xsl:when test="delivery_channel[. = 'FACT']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_ACT')"/>
										</xsl:when>
									</xsl:choose>
								</xsl:with-param>
								<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_weight">bold</xsl:with-param>
								<xsl:with-param name="column_3_text_align">center</xsl:with-param>
							</xsl:call-template>
							<xsl:for-each select="attachments/attachment">
							<xsl:if test="type = '01'">
							<xsl:variable name="filename"><xsl:value-of select="file_name"/></xsl:variable>
							<xsl:variable name="title"><xsl:value-of select="title"/></xsl:variable>
							<xsl:variable name="colWidth">40%</xsl:variable>
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="title" /></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">left</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="file_name" /></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">left</xsl:with-param>
								<xsl:with-param name="column_3_text">
									<xsl:choose>
										<xsl:when test="$delivery-channel = 'FACT' and for_fileact[.!='']">
											<xsl:value-of select="localization:getDecode($language, 'N034', for_fileact[.])" />
										</xsl:when>
										<xsl:when test="$delivery-channel = 'FACT' and for_fileact[.='']">
											<xsl:value-of select="localization:getDecode($language, 'N034', 'N')" />
										</xsl:when>
									</xsl:choose>
								</xsl:with-param>
								<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_weight"/>
								<xsl:with-param name="column_3_text_align">center</xsl:with-param>
							</xsl:call-template>
							</xsl:if>
							</xsl:for-each>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>				
				<xsl:otherwise>
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
							<xsl:if test="type = '01'">
							<xsl:variable name="filename"><xsl:value-of select="file_name"/></xsl:variable>
							<xsl:variable name="title"><xsl:value-of select="title"/></xsl:variable>
							<xsl:variable name="colWidth">45%</xsl:variable>
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
				</xsl:otherwise>

			</xsl:choose>		
		</xsl:if>
				
				 <xsl:if test="(security:isBank($rundata) or tnx_stat_code[.='04'])">
                        <xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_BANK_MESSAGE')" />	
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
			<xsl:if test="bo_ref_id[.!=''] ">
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
			<xsl:if test="bo_comment[.!=''] ">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_COMMENT_BANK')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bo_comment" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="action_req_code[.!=''] ">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ACTION_REQUIRED')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getDecode($language, 'N042', action_req_code)" />
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
                                  
                                  <xsl:if test="tnx_type_code[.!='']">
                                  	<xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_TRANSACTION_TYPE')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                       		<xsl:value-of select="localization:getDecode($language, 'N002', tnx_type_code[.])"/>
                                            <xsl:if test="sub_tnx_type_code[. != '']">&nbsp;
                                               <xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code[.])"/>
											</xsl:if>
                                         </xsl:with-param>
                                  	</xsl:call-template>
                                  </xsl:if>
                                  <xsl:if test="release_dttm[.!='']">
                                   <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_RELEASE_DTTM')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="release_dttm" />
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
							</xsl:with-param>
							</xsl:call-template>
                          </xsl:if>
                                  
			
			!-- Charges Details Section -->
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
					<!--  parent refrence started -->
					<xsl:if test="cross_references/cross_reference/child_product_code[.!='IP' and .!='IN' and .!='PO' and .!='SO' and .!='TD'] and (cross_references/cross_reference/child_ref_id=ref_id and cross_references/cross_reference/ref_id != cross_references/cross_reference/child_ref_id)"> 
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
					<xsl:if test="cross_references/cross_reference/child_product_code[.='SG']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_NO_LINKED_REFERENCE')" />
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
					<!--application Date -->
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="appl_date"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="bo_lc_ref_id[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_LC_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bo_lc_ref_id"/>
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
			<xsl:if test="applicant_name[.!=''] or applicant_address_line_1[.!=''] or applicant_address_line_2[.!=''] or applicant_dom[.!=''] or applicant_address_line_4[.!=''] or applicant_reference[.!='']">
				<!--Applicant Details-->
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_APPLICANT_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
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
						<!--  reference from pdf removed starts -->
						 <!--<xsl:if test="applicant_reference[.!='']">
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
						</xsl:if>-->
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!--Beneficiary Details-->
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SG_BENEFICIARY_DETAILS')"/>
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
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:apply-templates select="issuing_bank">
						<xsl:with-param name="theNodeName" select="'issuing_bank'"/>
						<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language,'XSL_BANKDETAILS_TAB_ISSUING_BANK')"/>
					</xsl:apply-templates>
				</xsl:with-param>
			</xsl:call-template>
			<!--Amount Details-->
			<xsl:if test="(sg_amt[.!='']) or (sg_liab_amt[.!=''])">
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
							<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_GTEE_AMT_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="concat(sg_cur_code, ' ', sg_amt)" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="sg_liab_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="concat(sg_cur_code, ' ', sg_liab_amt)" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			<!--Guarantee Details-->
			<fo:block id="guaranteedetails"/>
			<xsl:if test=" shipping_by [.!=''] or bol_number[.!=''] or shipping_mode[.!='']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GTEE_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="bol_number[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_BOL_NUMBER')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="bol_number"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="shipping_mode[.! = '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_SHIPPING_MODE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:if test="shipping_mode[. != '']">
										<xsl:value-of select="localization:getDecode($language, 'N012', shipping_mode)"/>
									</xsl:if>
									<!--
										xsl:choose> <xsl:when test="shipping_mode[. = '01']">
										<xsl:value-of select="localization:getGTPString($language,
										'XSL_SHIPPINGMODE_01_SEA')"/> </xsl:when> <xsl:when
										test="shipping_mode[. = '02']"> <xsl:value-of
										select="localization:getGTPString($language,
										'XSL_SHIPPINGMODE_02_AIR')"/> </xsl:when> <xsl:when
										test="shipping_mode[. = '03']"> <xsl:value-of
										select="localization:getGTPString($language,
										'XSL_SHIPPINGMODE_03_RAIL')"/> </xsl:when> <xsl:when
										test="shipping_mode[. = '04']"> <xsl:value-of
										select="localization:getGTPString($language,
										'XSL_SHIPPINGMODE_04_TRUCK')"/> </xsl:when> <xsl:when
										test="shipping_mode[. = '05']"> <xsl:value-of
										select="localization:getGTPString($language,
										'XSL_SHIPPINGMODE_05_POSTAGE')"/> </xsl:when> <xsl:when
										test="shipping_mode[. = '06']"> <xsl:value-of
										select="localization:getGTPString($language,
										'XSL_SHIPPINGMODE_06_MIXED')"/> </xsl:when> <xsl:when
										test="shipping_mode[. = '07']"> <xsl:value-of
										select="localization:getGTPString($language,
										'XSL_SHIPPINGMODE_07_COURIER')"/> </xsl:when> <xsl:when
										test="shipping_mode[. = '08']"> <xsl:value-of
										select="localization:getGTPString($language,
										'XSL_SHIPPINGMODE_08_LOCAL_DELIVERY')"/> </xsl:when>
										<xsl:otherwise/> </xsl:choose
									-->
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="shipping_by[.! = '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_SHIPPING_BY')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="shipping_by"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!--Description Goods-->
			<xsl:if test="goods_desc[.! = '']">
				<fo:block linefeed-treatment="preserve" white-space-collapse="false" white-space="pre">
			           <fo:table width="{$pdfTableWidth}"
						font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
						<fo:table-column column-width="{$pdfTableWidth}" />
						<fo:table-column column-width="0" />
						<fo:table-body>
						<xsl:call-template name="title2">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DESCRIPTION_GOODS')"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="subtitle2">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language,'XSL_LABEL_DESCRIPTION_GOODS')" />
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="table_cell2">
								<xsl:with-param name="text">
									<xsl:value-of select="goods_desc"/>
								</xsl:with-param>
							</xsl:call-template>
					</fo:table-body>
				</fo:table>
			</fo:block>
			</xsl:if>
			<xsl:if test="return_comments[.!=''] and tnx_stat_code[.!='03' and .!='04']">   <!-- MPS-43899 -->
				<fo:block id="returncomments" />
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_MC_COMMENTS_FOR_RETURN')" />
							</xsl:with-param>
						</xsl:call-template>

						<xsl:if test="return_comments/text[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="return_comments/text" />
								</xsl:with-param>
								<xsl:with-param name="right_text" />
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
	                                 	<xsl:value-of select="number($pdfMargin)"/>pt
	                                 </xsl:attribute>
					<xsl:value-of select="convertTools:internalDateToStringDate($systemDate,$language)"/>
				</fo:block>
			</fo:block>
		</fo:static-content>
  </xsl:template>
</xsl:stylesheet>
