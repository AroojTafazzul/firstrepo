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
				xmlns:fo="http://www.w3.org/1999/XSL/Format" 
				xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
				xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
				xmlns:security="xalan://com.misys.portal.security.GTPSecurity" 
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils" 
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>
	<xsl:variable name="background">
		BLACK
	</xsl:variable>
	<xsl:template match="bg_tnx_record">
		<!-- HEADER-->
		
		<!-- BODY-->
		
	<xsl:call-template name="header"/>
	<xsl:call-template name="footer"/>
    <xsl:call-template name="body"/>
  </xsl:template>
<xsl:template name="header">
    <fo:static-content flow-name="xsl-region-before">
			<xsl:call-template name="header_recipient_bank"/>
		</fo:static-content>
  </xsl:template>
  <xsl:template name="body">
    <fo:flow flow-name="xsl-region-body" font-size="{$pdfFontSize}">

			<xsl:call-template name="disclammer_template"/>

			
	<xsl:if test="not(tnx_id) or (tnx_type_code[.!='01'] and tnx_type_code[.!='03'] and tnx_type_code[.!='04'] and tnx_type_code[.!='13'] and tnx_type_code[.!='15']) or preallocated_flag[.='Y']">
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
							<xsl:value-of select="ref_id"/>
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
					<!-- bo_ref_id -->
                           </xsl:with-param>
                           </xsl:call-template>
                           <xsl:if test="(tnx_stat_code[.='04'] or not(tnx_id)) and security:isBank($rundata)">
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
			<xsl:if test="extend_pay_date[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_EXTEND_PAY_DATE_LABEL')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="extend_pay_date" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="latest_date_reply[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_LATEST_DATE_REPLY_LABEL')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="latest_date_reply" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
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
                          <!--         <xsl:if test="bo_ref_id[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bo_ref_id"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if> -->
                                  <xsl:if test="tnx_type_code[.!='']">
                                  	<xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_TRANSACTION_TYPE')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                       		<xsl:choose>
                                            	<xsl:when test="tnx_type_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_01_NEW')"/></xsl:when>
                                            	<xsl:when test="tnx_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_02_UPDATE')"/></xsl:when>
                                            	<xsl:when test="tnx_type_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_03_AMEND')"/></xsl:when>
                                            	<xsl:when test="tnx_type_code[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_04_EXTEND')"/></xsl:when>
                                            	<xsl:when test="tnx_type_code[. = '05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_05_ACCEPT')"/></xsl:when>
                                            	<xsl:when test="tnx_type_code[. = '06']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_06_CONFIRM')"/></xsl:when>
                                             	<xsl:when test="tnx_type_code[. = '07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_07_CONSENT')"/></xsl:when>
                                             	<xsl:when test="tnx_type_code[. = '08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_08_SETTLE')"/></xsl:when>
                                             	<xsl:when test="tnx_type_code[. = '09']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_09_TRANSFER')"/></xsl:when>
                                            	<xsl:when test="tnx_type_code[. = '10']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_10_DRAWDOWN')"/></xsl:when>
                                             	<xsl:when test="tnx_type_code[. = '11']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_11_REVERSE')"/></xsl:when>
                                             	<xsl:when test="tnx_type_code[. = '12']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_12_DELETE')"/></xsl:when>
                                             	<xsl:when test="tnx_type_code[. = '13']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_13_INQUIRE')"/></xsl:when>
                                             	<xsl:when test="tnx_type_code[. = '14']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_14_CANCEL')"/></xsl:when>
                                             	<xsl:when test="tnx_type_code[. = '15']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_15_REPORTING')"/></xsl:when>
                                            	<xsl:when test="tnx_type_code[. = '16']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_16_REINSTATE')"/></xsl:when>
                                                <xsl:when test="tnx_type_code[. = '17']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_17_PURGE')"/></xsl:when>
                                                <xsl:when test="tnx_type_code[. = '18']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_18_PRESENT')"/></xsl:when>
                                                <xsl:when test="tnx_type_code[. = '19']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_19_ASSIGN')"/></xsl:when>
											</xsl:choose>
                                            <xsl:if test="sub_tnx_type_code[. != '']">&nbsp;
                                                <xsl:choose>
                                                	<xsl:when test="sub_tnx_type_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_01_INCREASE')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_02_DECREASE')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_03_TERMS')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_04_UPLOAD')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_05_RELEASE')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '06']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_06_BACK_TO_BACK')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_07_GENERATION')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_08_DISCREPANT_ACK')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '09']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_09_DISCREPANT_NACK')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '11']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '16']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '65']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '66']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '67']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '96']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '88']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_88_WORDING_ACK')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '89']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_89_WORDING_NACK')"/></xsl:when>
                                                </xsl:choose>
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
                                                <xsl:value-of select="formatter:formatReportDate(release_dttm,$rundata)" />
                                         </xsl:with-param>
                                  </xsl:call-template>
                                  </xsl:if>
                                  <xsl:if test="tnx_type_code[.='03' or .='15']">
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
											<xsl:when test="prod_stat_code[.='98']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_98_PROVISIONAL')"/></xsl:when>
										</xsl:choose>
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
											<xsl:when test="prod_stat_code[.='98']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_98_PROVISIONAL')"/></xsl:when>
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
                                  <!-- <xsl:if test="release_dttm[.!='']">
                                   <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_RELEASE_DTTM')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="formatter:formatReportDate(release_dttm,$rundata)" />
                                         </xsl:with-param>
                                  </xsl:call-template>
                                  </xsl:if> -->
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
					<xsl:if  test="security:isCustomer($rundata)">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ref_id"/>
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
					<xsl:if test="cust_ref_id[. != '']">
					<xsl:if  test="security:isCustomer($rundata)">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="cust_ref_id"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					</xsl:if>
					<xsl:if test="bo_ref_id[.!=''] and (not(tnx_id) or tnx_type_code[.!='01'] or preallocated_flag[.='Y'])">
					<xsl:if  test="security:isCustomer($rundata)">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bo_ref_id"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
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
			<!--application Date -->
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
				<xsl:if  test="security:isCustomer($rundata)">
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
					</xsl:if>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EFFECTIVE_DATE_TYPE')"/>
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
									<xsl:value-of select="iss_date_type_details"/>
								</xsl:when>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="iss_date[.!=''] and (not(tnx_id) or tnx_type_code[.!='01' and .!='15'])">
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
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_DATE_TYPE')"/>
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
					<xsl:if test="exp_date[.!=''] and exp_date_type_code[.!= '01']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="exp_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="exp_event[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_EVENT')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<fo:block font-weight="bold" linefeed-treatment="preserve" white-space-collapse="false" white-space="pre">
								<xsl:value-of select="exp_event"/>
								</fo:block>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="reduction_authorised[.!=''] and product_code[.='BG']"> <!-- and tnx_type_code[.!='03'] and sub_tnx_type_code[.!='05'] and tnx_stat_code[.!='03']"> -->
						<xsl:call-template name="table_cell">
							<!-- <xsl:with-param name="left_text">
							</xsl:with-param> -->
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="reduction_authorised[. = 'Y']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REDUCTION_AUTHORISED_YES')"/> 
									</xsl:when>
									<!-- <xsl:otherwise>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REDUCTION_AUTHORISED_NO')"/> 
									</xsl:otherwise> -->
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="reduction_clause[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REDUCTION_CLAUSE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="reduction_clause[. = '01']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REDUCTION_PER_DELIVERIES')"/>
									</xsl:when>
									<xsl:when test="reduction_clause[. = '02']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REDUCTION_UPON_REALISATION')"/>
									</xsl:when>
									<xsl:when test="reduction_clause[. = '03']">
										<xsl:value-of select="reduction_clause_other"/>
									</xsl:when>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="amd_no[.!=''] and (product_code[.!='BG'] and tnx_type_code[.!='03'] and sub_tnx_type_code[.!='05'] and tnx_stat_code[.!='03'])">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_AMD_COUNT')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="utils:formatAmdNo(amd_no)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
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
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="applicant_name"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- Address -->
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
					<xsl:if test="applicant_country[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<!-- <xsl:value-of select="applicant_country" /> -->
								<xsl:value-of select="localization:getCodeData($language,'*','*','C006',applicant_country)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- commented as part of MPS-39538  -->
					<!-- <xsl:if test="applicant_reference[.!='']">
						<xsl:variable name="appl_ref">
              <xsl:value-of select="applicant_reference"/>
            </xsl:variable>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="utils:decryptApplicantReference(applicant_reference)" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if> -->
					<!-- For Account -->
					<xsl:if test="for_account[. = 'Y']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_FOR_THE_ACCOUNT_OF')"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!--Alternative Applicant Details-->
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
					<!-- Address -->
					<xsl:if test="alt_applicant_address_line_1[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ALT_APPLICANT_ADDRESS')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="alt_applicant_address_line_1"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
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
								<!-- <xsl:value-of select="alt_applicant_country" /> -->
								<xsl:value-of select="localization:getCodeData($language,'*','*','C006',alt_applicant_country)"/>
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
					<!-- Name -->
					<xsl:if test="beneficiary_name != ''">
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
					<xsl:if test="beneficiary_address_line_1 != ''">
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
					<xsl:if test="beneficiary_country[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>
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
				</xsl:with-param>
			</xsl:call-template>
			<!--Contact Details-->
			<xsl:if test="contact_name[.!=''] or contact_country[.!=''] or contact_address_line_1[.!=''] or contact_address_line_2[.!=''] or contact_dom[.!=''] or contact_address_line_4[.!='']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONTACT_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="contact_name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="contact_name"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Address -->
						<xsl:if test="contact_address_line_1[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="contact_address_line_1"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="contact_address_line_2[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="contact_address_line_2"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="contact_dom[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="contact_dom"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="contact_address_line_4[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="contact_address_line_4"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="contact_country[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<!-- <xsl:value-of select="contact_country" /> -->
									<xsl:value-of select="localization:getCodeData($language,'*','*','C006',contact_country)"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!--Amount Details-->
			<fo:block id="amountdetails"/>
			<xsl:if test="bg_cur_code != '' or bg_amt != ''">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<!--Guarantee Currency and Amount-->
					<xsl:if test="bg_cur_code != '' or bg_amt != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_GTEE_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bg_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="bg_amt"/>
							</xsl:with-param>
						</xsl:call-template>
				   </xsl:if>
					<xsl:if test="(bg_cur_code [.!=''] and bg_liab_amt[.!=''] and security:isCustomer($rundata)) or (bg_cur_code [.!=''] and bg_liab_amt[.!='']  and tnx_type_code[.='03'] and sub_tnx_type_code[.='05'] and tnx_stat_code[.!='04'] and security:isBank($rundata))">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bg_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="bg_liab_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Consortium -->
					<xsl:if test="consortium[. = 'Y']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_CONSORTIUM')"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="consortium[. = 'Y'] ">
						<xsl:call-template name="table_cell">							
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONSORTIUM_DETAILS_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">								
								<fo:block font-weight="bold" linefeed-treatment="preserve" white-space-collapse="false" white-space="pre">
								<xsl:value-of select="consortium_details"/>								
								</fo:block>
							</xsl:with-param>															
						</xsl:call-template>
					</xsl:if>
						<xsl:if test="net_exposure_cur_code != '' or net_exposure_amt != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NET_EXPOSUER_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">								
								<xsl:value-of select="net_exposure_cur_code"/> 
								<xsl:value-of select="net_exposure_amt"/>
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
					<xsl:if test="not(tnx_id) or bg_liab_amt[.!='']  and security:isBank($rundata)">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="concat(bg_cur_code,' ',bg_liab_amt)"/> 
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="bg_release_flag[. = 'Y']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_GTEE_RELEASE_FULL')" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="spacer_template"/>
			
			<xsl:if test="open_chrg_brn_by_code[.!=''] or corr_chrg_brn_by_code[.!=''] or cfm_chrg_brn_by_code[.!='']">		
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BG_ISS_LABEL')"/>
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
						<xsl:if test="corr_chrg_brn_by_code[.='01' or .='02']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BG_CORR_LABEL')"/>
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
						<xsl:if test="cfm_chrg_brn_by_code[.='01' or .='02']">
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
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!--Renewal Details-->
			<fo:block id="renewaldetails"/>
			<xsl:if test="renew_flag[. = 'Y'] or renew_amt_code[.!='']">
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
									<xsl:when test="renew_on_code[.= '01']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/>
									</xsl:when>
									<xsl:when test="renew_on_code[.= '02']">
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
						<xsl:if test="renew_for_nb[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_RENEW_FOR')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="renew_for_nb"/> <xsl:value-of select="localization:getDecode($language, 'N074', renew_for_period)"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
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
									 <xsl:choose>
											<xsl:when test="rolling_renew_on_code[.= '01']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/>
											</xsl:when>
											<xsl:when test="rolling_renew_on_code[.= '03']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EVERY')"/>
											</xsl:when>
										</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
							</xsl:if>
							<xsl:if test="rolling_renew_for_nb[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'FREQUENCY_LABEL')"/> 
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="rolling_renew_for_nb"/> <xsl:value-of select="localization:getDecode($language, 'N074', rolling_renew_for_period)"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="rolling_day_in_month[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_ROLLING_DAY_IN_MONTH')"/> 
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="rolling_day_in_month"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="rolling_renewal_nb[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_NUMBER_RENEWALS')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									 <xsl:value-of select="rolling_renewal_nb"/>
								</xsl:with-param>
							</xsl:call-template>
							</xsl:if>
							<xsl:if test="rolling_cancellation_days[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CANCELLATION_NOTICE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									 <xsl:value-of select="rolling_cancellation_days"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						</xsl:if>
						<xsl:if test="renew_amt_code[. != '']">
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
			
			<fo:block id="bankdetails"/>
			<!--Bank Details-->
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BANK_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
							<xsl:when test="lead_bank_flag[.='Y']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LEAD_BANK')"/>
							</xsl:when>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:choose>
								<xsl:when test="lead_bank_flag[.='Y']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LEAD_BANK_NAME')"/>
								</xsl:when>
								<xsl:when test="issuing_bank_type_code[.='02'] or (not(security:isBank($rundata)))">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_RECIPIENT_BANK')"/>
								</xsl:when>
								<xsl:otherwise>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_RECIPIENT_ISSUING_BANK')"/>
								</xsl:otherwise>
			                    </xsl:choose>
		                        </xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="recipient_bank/name"/>
								</xsl:with-param>
							</xsl:call-template>
					<xsl:if test="applicant_reference[.!='']">
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
									                 <xsl:when test="//*/avail_main_banks/bank/entity/customer_reference/description[.!=''] and defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'">
									                      <xsl:value-of select="//*/avail_main_banks/bank/customer_reference/description"/>
									                 </xsl:when>  
									                 <xsl:when test="//*/avail_main_banks/bank/entity/customer_reference/description[.!='']  and defaultresource:getResource('ISSUER_REFERENCE_NAME') [.!= 'true']'">
									                      <xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank/customer_reference/reference)"/>
									                 </xsl:when>
									                 <xsl:otherwise>
									                          <xsl:choose>
														<xsl:when test="//*/avail_main_banks/bank/customer_reference[reference=$appl_ref]/description[.!='']  and defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'false'">
																<xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$appl_ref]/description"/>                                                     
															</xsl:when>   
                                                     <xsl:otherwise>
                                                          <xsl:value-of select="//*/customer_references/customer_reference[reference=$appl_ref]/description)"/>
                                                     </xsl:otherwise>										
                                                     </xsl:choose>  
									                 </xsl:otherwise>
									         </xsl:choose>
									    </xsl:when>
									</xsl:choose>

                                  </xsl:with-param>
                         </xsl:call-template>
					</xsl:if>
					<xsl:choose>
					
						<!-- Indirect -->
						<xsl:when test="issuing_bank_type_code[.='02']">
						<xsl:if test="security:isCustomer($rundata)">
							<xsl:apply-templates select="recipient_bank">
								<xsl:with-param name="theNodeName" select="'recipient_bank'"/>
								<xsl:with-param name="theNodeDescription">
									<xsl:choose>
										<xsl:when test="lead_bank_flag[.='Y']"><xsl:value-of select="localization:getGTPString($language,'XSL_LEAD_BANK')"/></xsl:when>
										<xsl:otherwise><xsl:value-of select="localization:getGTPString($language,'XSL_BANKDETAILS_TAB_RECIPIENT_BANK')"/></xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:apply-templates>
					<xsl:if test="tnx_type_code[.!='05'] and applicant_reference[.!='']">
							<xsl:variable name="appl_ref">
								<xsl:value-of select="applicant_reference"/>
							</xsl:variable>
							
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CUST_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) >= 1">
									<xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]/description"/>
								</xsl:when>
								<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) = 0">
									<xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$appl_ref]/description"/>
								</xsl:when>
							</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					</xsl:if>
							<xsl:apply-templates select="issuing_bank">
								<xsl:with-param name="theNodeName" select="'issuing_bank'"/>
								<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language,'XSL_BANKDETAILS_TAB_LOCAL_GUARANTOR')"/>
							</xsl:apply-templates>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ISSUING_INSTRUCTIONS_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_INDIRECT')"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<!-- Direct -->
						<xsl:otherwise>
						<!-- <xsl:if test="security:isCustomer($rundata)">
							<xsl:apply-templates select="recipient_bank">
								<xsl:with-param name="theNodeName" select="'recipient_bank'"/>
								<xsl:with-param name="theNodeDescription">
									<xsl:choose>
										<xsl:when test="lead_bank_flag[.='Y']"><xsl:value-of select="localization:getGTPString($language,'XSL_LEAD_BANK')"/></xsl:when>
										<xsl:otherwise><xsl:value-of select="localization:getGTPString($language,'XSL_BANKDETAILS_TAB_RECIPIENT_BANK')"/></xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:apply-templates>
				<xsl:if test="tnx_type_code[.!='05'] and applicant_reference[.!='']">
							<xsl:variable name="appl_ref">
								<xsl:value-of select="applicant_reference"/>
							</xsl:variable>
							<xsl:variable name="rec_bank">
								<xsl:value-of select="//bg_tnx_record/recipient_bank/abbv_name"/>
							</xsl:variable>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CUST_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) >= 1">
									<xsl:value-of select="//*/avail_main_banks/bank[abbv_name = $rec_bank]/entity/customer_reference[reference=$appl_ref]/description"/>
								</xsl:when>
								<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) = 0">
								<xsl:value-of select="//*/avail_main_banks/bank[abbv_name = $rec_bank]/customer_reference[reference=$appl_ref]/description"/>
								</xsl:when>
							</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					</xsl:if> -->
							<xsl:apply-templates select="issuing_bank">
								<xsl:with-param name="theNodeName" select="'issuing_bank'"/>
								<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language,'XSL_BANKDETAILS_TAB_LOCAL_GUARANTOR')"/>
							</xsl:apply-templates>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ISSUING_INSTRUCTIONS_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_DIRECT')"/>
								</xsl:with-param>
							</xsl:call-template>
							<!-- <xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_RECIPIENT_BANK')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="recipient_bank/name"/>
								</xsl:with-param>
							</xsl:call-template> -->
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="advising_bank/name[.!='']">
						<xsl:apply-templates select="advising_bank">
							<xsl:with-param name="theNodeName" select="'advising_bank'"/>
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ADVISING_BANK')"/>
						</xsl:apply-templates>
					</xsl:if>
					<xsl:if test="adv_bank_conf_req[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="adv_bank_conf_req[. = 'Y']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_ADVISING_BANK_CONFIRMATION_REQUIRED_YES')"/> 
									</xsl:when>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				<xsl:if test="security:isCustomer($rundata)">
					<xsl:if test="confirming_bank/name[.!='']">
						<xsl:apply-templates select="confirming_bank">
							<xsl:with-param name="theNodeName" select="'confirming_bank'"/>
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_CONFIRMING_BANK')"/>
						</xsl:apply-templates>
					</xsl:if>
					</xsl:if>
					<xsl:if test="processing_bank/name[.!='']">
						<xsl:apply-templates select="processing_bank">
							<xsl:with-param name="theNodeName" select="'processing_bank'"/>
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_PROCESSING_BANK')"/>
						</xsl:apply-templates>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			
		<!--Guarantee Details-->
			<fo:block id="guaranteedetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GTEE_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="bg_type_code[.!='']">
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
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="bg_type_details"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="bg_code[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_NAME')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bg_code"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="provisional_status[.='Y'] and security:isBank($rundata) != 'true'">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text"/>
							<xsl:with-param name="right_text">
								<xsl:if test="provisional_status[.='Y']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PROVISIONAL')"/>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="character_commitment[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_CHARACTER_COMMITMENT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="character_commitment[. = '01']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_CONDITIONAL')"/>
									</xsl:when>
									<xsl:when test="character_commitment[. = '02']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_FIRST_DEMAND')"/>
									</xsl:when>
									<xsl:otherwise/>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="bg_rule[.!='']">
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
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_RULES_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $rule_code)"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="bg_rule_other"/>
						</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="bg_text_type_code[. = '01' or . = '02' or . = '03' or . = '04']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="bg_text_type_code[. = '01']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_BANK_STANDARD')"/>
								</xsl:when>
								<xsl:when test="bg_text_type_code[. = '02']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_WORDING_ATTACHED')"/>
								</xsl:when>
								<xsl:when test="bg_text_type_code[. = '03']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_SAME_AS_SPECIFY')"/>
									<!-- &nbsp;<xsl:value-of select="bg_text_type_details" /> -->
								</xsl:when>
								<xsl:when test="bg_text_type_code[. = '04']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_BENEFICIARY_ATTACHED')"/>
								</xsl:when>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="bg_text_type_code[. = '03'] and bg_text_type_details[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bg_text_type_details"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="text_language[.!=''] or text_language_other[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_LANGUAGE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="text_language[. != '' and . !='*']">
										<xsl:value-of select="localization:getDecode($language, 'N061', text_language)"/>
									</xsl:when>
									<xsl:when test="text_language_other[. != '']">
                    					<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_LANGUAGE_OTHER')"/>  
                					</xsl:when>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="text_language_other"/>
						</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="narrative_additional_instructions[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_OTHER_INSTRUCTIONS')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="narrative_additional_instructions/text"/>
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
								<xsl:value-of select="concat(contract_cur_code,' ',contract_amt)"/> 
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="contract_pct[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_CONTRACT_PCT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="contract_pct"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					</xsl:with-param>
			</xsl:call-template>			
		</xsl:if>		
			
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
				<fo:block color="{$footerFontColor}" font-weight="bold" text-align="start">
					<fo:page-number/>
					/
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
