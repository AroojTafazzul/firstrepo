<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<!-- Copyright (c) 2006-2012 Misys , All Rights Reserved -->
<xsl:stylesheet version="1.0"
	xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" 
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
	xmlns:fo="http://www.w3.org/1999/XSL/Format" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
	xmlns:payeeutils="xalan://com.misys.portal.product.util.PayeeUtil" 
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:formatter="xalan://com.misys.portal.common.tools.ConvertTools"
 	xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	<xsl:import href="settlement_common.xsl"/>
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>
	<xsl:variable name="background">
		BLACK
	</xsl:variable>
	<xsl:variable name="loc_lan">
          <xsl:value-of select="defaultresource:getResource('LOCAL_LANGUAGE')"/>
     </xsl:variable>
     <xsl:variable name="accountNickName">
     	<xsl:value-of select="defaultresource:getResource('NICKNAME_ENABLED')"/>
     </xsl:variable>
     <xsl:variable name="beneficiaryNickName">
     	<xsl:value-of select="defaultresource:getResource('BENEFICIARY_NICKNAME_ENABLED')"/>
     </xsl:variable>
      <xsl:variable name="swift_flag" select="defaultresource:getResource('OPICS_SWIFT_ENABLED')"/>

	<xsl:template match="ft_tnx_record">
		<!-- Bill Payment Local and Default Language variables -->
		
		<!-- HEADER -->
		
		<!-- FOOTER -->
		
		<!-- BODY -->
		
	<xsl:call-template name="header"/>
    <xsl:call-template name="footer"/>
    <xsl:call-template name="body"/>
  </xsl:template>
	<xsl:template match="customer_payee_ref_record">
		<xsl:for-each select="//*[starts-with(name(),'label')]">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of select="."/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="."/>
				</xsl:with-param>										
			</xsl:call-template>
		</xsl:for-each>	
		<xsl:for-each select="//*[starts-with(name(),'ref_value')]">
			<xsl:call-template name="table_cell">				
				<xsl:with-param name="right_text">
					<xsl:value-of select="."/>
				</xsl:with-param>							
			</xsl:call-template>
		</xsl:for-each>	
	</xsl:template>
	<xsl:template name="intermediarybankdetails">
		<xsl:if test="intermediary_bank_name">
		<fo:block id="intermediaryBankdetails"/>
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_INTERMEDIARY_BANK_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<!-- swift bic code -->
						<xsl:if test="intermediary_bank_swift_bic_code[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SWIFT_BIC_CODE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="intermediary_bank_swift_bic_code"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<!-- Bank name and address -->
						<xsl:if test="intermediary_bank_name[.!='']">					
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="intermediary_bank_name"/>
							</xsl:with-param>
						</xsl:call-template>
	
						<!-- Address -->
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="intermediary_bank_address_line_1"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="intermediary_bank_address_line_2[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="intermediary_bank_address_line_2"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="intermediary_bank_dom[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="intermediary_bank_dom"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						</xsl:if>
						<!-- intermediary_bank_country -->
						<xsl:if test="intermediary_bank_country[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getCodeData($language,'*','*','C006',intermediary_bank_country)"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<!-- Clearing Code and description -->
						<xsl:if test="intermediary_bank_clearing_code[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CLEARING_CODE_DESCRIPTION')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="intermediary_bank_clearing_code"/> 
								<xsl:value-of select="intermediary_bank_clearing_code_desc"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
				</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
		</xsl:template>
	<xsl:template name="header">
    <fo:static-content flow-name="xsl-region-before">
			<xsl:call-template name="header_issuing_bank"/>
		</fo:static-content>
  </xsl:template>
  <xsl:template name="body">
    <fo:flow flow-name="xsl-region-body" font-size="{$pdfFontSize}">
			<xsl:call-template name="disclammer_template"/>
		 <xsl:if test=" (not(tnx_id) or (tnx_type_code[.!='01'] and tnx_type_code[.!='03'] and tnx_type_code[.!='04'] and tnx_type_code[.!='13']) or preallocated_flag[.='Y'])">
                     <xsl:call-template name="table_template">
                           <xsl:with-param name="text">
                           <xsl:call-template name="title">
                                  <xsl:with-param name="text">
                                         <xsl:value-of
                                                select="localization:getGTPString($language, 'XSL_HEADER_EVENT_DETAILS')" />
                                  </xsl:with-param>
                          </xsl:call-template>
                           <xsl:variable name="ref_id_for_company_name"><xsl:value-of select="ref_id"/></xsl:variable>
     						<xsl:variable name="product_code"><xsl:value-of select="product_code"/></xsl:variable>
     						<!-- MPS-59965 :- Incorrect Release Date/Time is coming in case of Cancelled Post Dated Transactions in PDF -->
     						<xsl:if test="release_dttm[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_RELEASE_DTTM')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="formatter:formatReportDate(release_dttm,$rundata)" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
                           <xsl:if test="company_name[.!='']">
	                           <xsl:call-template name="table_cell">
	                                  <xsl:with-param name="left_text">
	                                        <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_COMPANY_NAME')" />
	                                   </xsl:with-param>
	                                    <xsl:with-param name="right_text">
                                         <xsl:value-of select="utils:getCompanyName($ref_id_for_company_name,$product_code)"/>
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
                           <xsl:if test="tnx_type_code[.!='']">
	                             <xsl:call-template name="table_cell">
	                                  <xsl:with-param name="left_text">
	                                         <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_TYPE')" />
	                                  </xsl:with-param>
	                                  <xsl:with-param name="right_text">
	                                        <xsl:value-of select="localization:getDecode($language, 'N002', tnx_type_code[.])"/>
	        								 <xsl:if test="sub_tnx_type_code[.!='']">&nbsp;<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code[.])"/></xsl:if>
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
                           	<!-- MPS-59965 :- Issue Date is missing in case of Cancelled Post Dated Transactions in PDF -->
                           <xsl:if test="iss_date[.!='']">
                           		<xsl:call-template name="table_cell">
                                  	<xsl:with-param name="left_text">
                                    	<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ISSUE_DATE')" />
                                  	</xsl:with-param>
                           			<xsl:with-param name="right_text">
                                         <xsl:value-of select="iss_date" />
                                	</xsl:with-param>
                           		</xsl:call-template>
                           </xsl:if>
                           <xsl:if test="(product_code[. != 'FX'] and sub_product_code[.!='TRTD'] and cust_ref_id[.!=''])">
                              <xsl:call-template name="table_cell">
		                              <xsl:with-param name="left_text">                                    
		                                                   <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')" />
		                              </xsl:with-param>
		                              <xsl:with-param name="right_text">
		                                     <xsl:value-of select="cust_ref_id" />
		                              </xsl:with-param>
		                       </xsl:call-template>
		                 </xsl:if>
     					 <xsl:if test="(sub_product_code[.='INT'] or sub_product_code[.='TPT']) and counterparties/counterparty[counterparty_type='02']/counterparty_reference[.!=''] and issuing_bank/name[.!='']">
        						<xsl:call-template name="table_cell">
	                                  <xsl:with-param name="left_text">                                    
	                                                       <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BEN_REF')" />
	                                  </xsl:with-param>
	                                  <xsl:with-param name="right_text">
	                                        <xsl:value-of select="counterparties/counterparty[counterparty_type='02']/counterparty_reference"/>
	                                  </xsl:with-param>
	                           </xsl:call-template>
        					</xsl:if>
      						<xsl:if test="sub_product_code[.!='TRTD'] and bo_ref_id[.!='']">
                              <xsl:call-template name="table_cell">
                                    <xsl:with-param name="left_text">                                    
                                                              <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')" />
                                     </xsl:with-param>
                                     <xsl:with-param name="right_text">
                                               <xsl:value-of select="bo_ref_id"/>
                                      </xsl:with-param>
                                </xsl:call-template>
        				</xsl:if>
	    				
     					<xsl:if test="issuing_bank/name[.!='']">
                                  <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">                                    
                                                              <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_ISSUING_BANK')" />
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="issuing_bank/name" />
                                         </xsl:with-param>
                                  </xsl:call-template>
                          </xsl:if>
                         
                          <xsl:if test="appl_date[.!='']">
                                  <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">                                    
                                                              <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')" />
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="appl_date" />
                                         </xsl:with-param>
                                  </xsl:call-template>
                           </xsl:if>
                            <xsl:if test="ft_amt[.!='']">
                                  <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">                                    
                                                              <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FT_AMT_LABEL')" />
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                              <xsl:value-of select="ft_cur_code"/> <xsl:value-of select="ft_amt"/>
                                         </xsl:with-param>
                                  </xsl:call-template>
                           </xsl:if>
                    		<xsl:if test="fee_act_no[. != '']">
								<xsl:call-template name="title">
									<xsl:with-param name="text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_HEADER_INSTRUCTIONS')" />
									</xsl:with-param>
								</xsl:call-template>
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

		<!-- Bank Message -->
		<xsl:if test="tnx_stat_code[.='04'] or (tnx_stat_code[.='03'] and sub_tnx_stat_code[.='89' or .='90' or .='91']) or security:isBank($rundata)">
		<fo:block id="bankmsgdetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:choose>	
								<xsl:when test="product_code[.='IN' or .='IP' or .='PO' or .='SO' or .='CN' or .!='PICO' or .!='PIDD']">
									<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_BANK_MESSAGE')" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_BANK_MESSAGE')" />	
								</xsl:otherwise>
							</xsl:choose>
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
					<xsl:if test="bo_comment[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_COMMENT_BANK')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of
									select="bo_comment" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="sub_product_code[.!='TRTD'] and bo_ref_id[.!='']">
      
                                  <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">                                    
                                                              <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')" />
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                               <xsl:value-of select="bo_ref_id"/>
                                         </xsl:with-param>
                                  </xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<!-- MPS-60916 :- Bank File Upload Details -->
			<xsl:if test="attachments/attachment[type = '02']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BANK_FILE_UPLOAD')"/>
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
							<xsl:with-param name="column_1_text"><xsl:value-of select="formatter:wrapStringforPDF($colWidth,$title)"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_weight"/>
							<xsl:with-param name="column_1_text_align">left</xsl:with-param>
							<xsl:with-param name="column_2_text"><xsl:value-of select="formatter:wrapStringforPDF($colWidth,$filename)"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_weight"/>
							<xsl:with-param name="column_2_text_align">left</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						</xsl:for-each>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
				<!-- Charge Details :- MPS-61757 -->
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
					
					<xsl:if test="bulk_ref_id[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_BK_REF_ID')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bulk_ref_id" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Display Entity -->
					<xsl:if test="entity[.!=''] and sub_product_code[.!='TRINT'] and sub_product_code[.!='TRTPT'] and sub_product_code[.!='TINT'] and sub_product_code[.!='TTPT']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ENTITY')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="entity"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="applicant_act_name[.!=''] and sub_product_code[.!='TRINT'] and sub_product_code[.!='TRTPT']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							<xsl:choose>
								<xsl:when test="sub_product_code ='BILLP' or sub_product_code ='DDA' or sub_product_code ='BILLS'">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_DEBIT_ACCOUNT')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSFER_FROM')"/>
								</xsl:otherwise>
							</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="applicant_act_name"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="$accountNickName='true' and applicant_act_nickname!='' and security:isCustomer($rundata) and securityCheck:hasPermission($rundata,'sy_account_nickname_access')">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language,'XSL_ACCOUNT_NICK_NAME')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="applicant_act_nickname"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Display transfer_from -->
					<xsl:if test="transfer_from[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							<xsl:choose>
								<xsl:when test="sub_product_code ='BILLP' or sub_product_code ='DDA' or sub_product_code ='BILLS'">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_DEBIT_ACCOUNT')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSFER_FROM')"/>
								</xsl:otherwise>
							</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="transfer_from"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Display issuing_bank_name -->
					<xsl:if test="issuing_bank/name[.!=''] and sub_product_code[.!='TRINT'] and sub_product_code[.!='TRTPT'] and sub_product_code[.!='TTPT'] and sub_product_code[.!='TINT']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'BANK_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="issuing_bank/name"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Display product_type -->
					<xsl:if test="sub_product_code[.!=''] and (sub_product_code[.!='DDA'] and sub_product_code [.!='BILLS'] and sub_product_code[.!='TRINT'] and sub_product_code[.!='TRTPT'] and sub_product_code[.!='TINT'] and sub_product_code[.!='TTPT'])">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODUCT_TYPE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								 <xsl:choose>
							     	<xsl:when test="bulk_ref_id[.!=''] and sub_product_code[.!='']">
							     		<xsl:value-of select="localization:getDecode($language, 'N047',  concat(sub_product_code,'_BK'))"/>
							     	</xsl:when>
							        <xsl:otherwise>
								        <xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code)"/> 
								    </xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ref_id"/>
						</xsl:with-param>
					</xsl:call-template>
					
					<!-- Display template_id -->
					<xsl:if test="template_id[.!=''] and (product_code[.='FT'] and tnx_type_code[.!='54']) and not(starts-with(template_id, 'BK'))">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TEMPLATE_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="template_id"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="bo_ref_id[.!=''] and (sub_product_code[.='TRINT'] or sub_product_code[.='TRTPT'])">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bo_ref_id"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="cust_ref_id[.!=''] and (sub_product_code[.='TRINT'] or sub_product_code[.='TRTPT']  or sub_product_code[.='TINT'] or sub_product_code[.='TTPT'])">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="cust_ref_id"/>
							</xsl:with-param>				
						</xsl:call-template>
					</xsl:if>
					
					<!-- Product Code -->
					<xsl:if test="(sub_product_code[.='TRINT'] or sub_product_code[.='TRTPT']) and product_code[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_CODE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getDecode($language, 'N001', product_code[.])"/>
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
					
							</xsl:with-param>
							</xsl:call-template>
			<!-- priority Code -->
			<xsl:if test="sub_product_code[.='MUPS']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_PRIORITY_DETAILS_HEADER')" />	
								</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_CLEARING_CODE_NAME')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="clearing_code"/>
								</xsl:with-param>
							</xsl:call-template>
					    </xsl:with-param>
			</xsl:call-template>
			</xsl:if>  
			 <!--Beneficiary Details -->
			 <!-- Currently adding this block here and adding a check for INt ,DOM,TPT ,for this issue fo files needs to be refactored later -->
			<xsl:if test="counterparties/counterparty/counterparty_name[.!=''] and sub_product_code[.='INT'  or .='DOM' or .='TPT' or .='HVPS' or .='HVXB'  or .='MUPS']">			
			<fo:block id="transferToDetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							 <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSFER_TO_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							<xsl:choose>
								<xsl:when test="sub_product_code ='INT' or sub_product_code ='TINT'">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSFER_TO')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BENEFICIARY_NAME')"/>
								</xsl:otherwise>
							</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="sub_product_code ='TINT'">
										<xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/> <xsl:value-of select="counterparties/counterparty/counterparty_act_no"/> <xsl:value-of select="counterparties/counterparty/counterparty_name"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="counterparties/counterparty/counterparty_name"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					<xsl:if test="$beneficiaryNickName='true' and counterparties/counterparty/beneficiary_nickname[.!=''] and security:isCustomer($rundata)">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'BENEFICIARY_NICKNAME_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="counterparties/counterparty/beneficiary_nickname"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="$beneficiaryNickName='true' and counterparties/counterparty/counterparty_act_nickname[.!=''] and security:isCustomer($rundata) and sub_product_code[.='INT']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'BENEFICIARY_NICKNAME_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="counterparties/counterparty/counterparty_act_nickname"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="sub_product_code[.='MEPS' or .='RTGS' or .='TTPT'] and counterparties/counterparty/counterparty_address_line_1[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
							       <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>	
							     </xsl:with-param>       								   	                									   	        
					             <xsl:with-param name="right_text">						                	
						   	            <xsl:value-of select="counterparties/counterparty/counterparty_address_line_1"/>							   	        
					              </xsl:with-param>
				             </xsl:call-template> 
				              
				              <xsl:if test="counterparties/counterparty/counterparty_address_line_2[.!='']">
				              <xsl:call-template name="table_cell">
				              	<xsl:with-param name="left_text"></xsl:with-param>
					               <xsl:with-param name="right_text">									                	
						   	            <xsl:value-of select="counterparties/counterparty/counterparty_address_line_2"/>							   	        
					                </xsl:with-param>
					           </xsl:call-template>     		
				              </xsl:if>
				              
				              <xsl:if test="counterparties/counterparty/counterparty_dom[.!='']">
				              <xsl:call-template name="table_cell">
				              	<xsl:with-param name="left_text"></xsl:with-param>
					              <xsl:with-param name="right_text">									                	
						   	            <xsl:value-of select="counterparties/counterparty/counterparty_dom"/>							   	        
					                </xsl:with-param>
					          </xsl:call-template>      
				              </xsl:if>	
					</xsl:if>
					<xsl:if test="sub_product_code[.!='INT' and .!='TINT'] and counterparties/counterparty/counterparty_act_no[.!='']">
						 <xsl:call-template name="table_cell">
			              	<xsl:with-param name="left_text">
			              		 <xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_ACCOUNT')"/> 
			              	</xsl:with-param>
				              <xsl:with-param name="right_text">									                	
									<xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/> &nbsp; <xsl:value-of select="counterparties/counterparty/counterparty_act_no"/>						   	            
				              </xsl:with-param>
				          </xsl:call-template>  
					</xsl:if>
					<xsl:if test="pre_approved_status[.='Y']">
						 <xsl:call-template name="table_cell">
			              	<xsl:with-param name="left_text">
			              		 <xsl:value-of select="localization:getGTPString($language, 'XSL_TPT_PAB')"/> 
			              	</xsl:with-param>
				              <xsl:with-param name="right_text">									                	
									<xsl:value-of select="localization:getGTPString($language, 'N034_Y')"/>						   	            
				              </xsl:with-param>
				          </xsl:call-template>  
					</xsl:if>
					<xsl:if test="transfer_purpose[.!='']">
						<xsl:variable name="transfer_purpose_code"><xsl:value-of select="transfer_purpose"/></xsl:variable>
						<xsl:call-template name="table_cell">
			              	<xsl:with-param name="left_text">
			              		 <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSFER_PURPOSE')"/> 
			              	</xsl:with-param>
				              <xsl:with-param name="right_text">	
				              	<xsl:value-of select="utils:retrieveTransferPurposeDescRTGS($rundata, $transfer_purpose_code)"/>								                	
				              </xsl:with-param>
				          </xsl:call-template>  
					</xsl:if>
					<xsl:if test="(sub_product_code[.='IBG'] or sub_product_code[.='DOM']) and counterparties/counterparty/cpty_bank_code">
						<xsl:call-template name="table_cell">
			              	<xsl:with-param name="left_text">
			              		 <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_BRANCH_CODE')"/> 
			              	</xsl:with-param>
				              <xsl:with-param name="right_text">	
				              	<xsl:value-of select="counterparties/counterparty/cpty_bank_code"/>/<xsl:value-of select="counterparties/counterparty/cpty_branch_code"/>								                	
				              </xsl:with-param>
			           </xsl:call-template>  
					</xsl:if>
					<xsl:if test="(sub_product_code[.='MEPS'] or sub_product_code[.='RTGS']) and counterparties/counterparty/cpty_bank_swift_bic_code[.!='']">
						<xsl:call-template name="table_cell">
			              	<xsl:with-param name="left_text">
			              		 <xsl:value-of select="localization:getGTPString($language, 'XSL_SWIFT_BIC_CODE')"/> 
			              	</xsl:with-param>
				              <xsl:with-param name="right_text">	
				              	<xsl:value-of select="counterparties/counterparty/cpty_bank_swift_bic_code"/>								                	
				              </xsl:with-param>
			           </xsl:call-template>
					</xsl:if>
					<xsl:if test="sub_product_code[.='MUPS']">
						<xsl:call-template name="table_cell">
			              	<xsl:with-param name="left_text">
			              		 <xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_IFSC_CODE')"/> 
			              	</xsl:with-param>
				              <xsl:with-param name="right_text">	
				              	<xsl:value-of select="counterparties/counterparty/cpty_bank_swift_bic_code"/>								                	
				              </xsl:with-param>
			           </xsl:call-template>
					</xsl:if>
					<!-- HVPS Bank code and name -->
					<xsl:if test="sub_product_code[.='HVPS' or .='HVXB'] and cnaps_bank_code[.!='']">	
						<xsl:call-template name="table_cell">
			              	<xsl:with-param name="left_text">
			              		 <xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_CNAPS_BANK_CODE')"/> 
			              	</xsl:with-param>
				              <xsl:with-param name="right_text">	
				              	<xsl:value-of select="cnaps_bank_code"/>								                	
				              </xsl:with-param>
			           </xsl:call-template>
					</xsl:if>
					<xsl:if test="sub_product_code[.='HVPS' or .='HVXB'] and cnaps_bank_name[.!='']">
						<xsl:call-template name="table_cell">
			              	<xsl:with-param name="left_text">
			              		 <xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_CNAPS_BANK_NAME')"/> 
			              	</xsl:with-param>
				              <xsl:with-param name="right_text">	
				              	<xsl:value-of select="cnaps_bank_name"/>								                	
				              </xsl:with-param>
			           </xsl:call-template>
					</xsl:if>
					<!-- Non HVPS and HVXB Bank name  -->	
					<xsl:if test="sub_product_code[.!='HVPS' and .!='HVXB'] and counterparties/counterparty/cpty_bank_name[.!='']">	
						<xsl:call-template name="table_cell">
			              	<xsl:with-param name="left_text">
			              		 <xsl:choose>
									<xsl:when test="sub_product_code[.='MUPS']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_IFSC_BANK_NAME')"/>
									</xsl:when>
									<xsl:otherwise>
						              <xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_BANK_NAME_WITH_ADDRESS')"/>
									</xsl:otherwise>
								</xsl:choose>
			              	</xsl:with-param>
				              <xsl:with-param name="right_text">	
				              	<xsl:value-of select="counterparties/counterparty/cpty_bank_name"/>								                	
				              </xsl:with-param>
			           </xsl:call-template>
					</xsl:if>
					<!-- Branch -->
					<xsl:if test="counterparties/counterparty/cpty_branch_name[.!='']">
						<xsl:call-template name="table_cell">
			              	<xsl:with-param name="left_text">
						         <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BRANCH_NAME')"/>
			              	</xsl:with-param>
				              <xsl:with-param name="right_text">	
				              	<xsl:value-of select="counterparties/counterparty/cpty_branch_name"/>								                	
				              </xsl:with-param>
			           </xsl:call-template>
					</xsl:if>
					<!-- Address -->
					<xsl:if test="sub_product_code[.='MEPS'] or sub_product_code[.='RTGS'] and counterparties/counterparty/cpty_bank_address_line_1[.!='']">
						<xsl:call-template name="table_cell">
			              	<xsl:with-param name="left_text">
						         <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
			              	</xsl:with-param>
				              <xsl:with-param name="right_text">	
				              	<xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_1"/>								                	
				              </xsl:with-param>
				             </xsl:call-template>  
				              <xsl:if test="counterparties/counterparty/cpty_bank_address_line_2[.!='']">
				              <xsl:call-template name="table_cell">
				              	<xsl:with-param name="left_text"></xsl:with-param>
					               <xsl:with-param name="right_text">									                	
						   	            <xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_2"/>							   	        
					                </xsl:with-param>
					           </xsl:call-template>     		
				              </xsl:if>
				              <xsl:if test="counterparties/counterparty/cpty_bank_dom[.!='']">
				              <xsl:call-template name="table_cell">
				              	<xsl:with-param name="left_text"></xsl:with-param>
					               <xsl:with-param name="right_text">									                	
						   	            <xsl:value-of select="counterparties/counterparty/cpty_bank_dom"/>							   	        
					                </xsl:with-param>
					           </xsl:call-template>     		
				              </xsl:if>
			          
					</xsl:if>
					<!-- IFSC Address -->
					<xsl:if test="sub_product_code[.='MUPS']">
						<xsl:call-template name="table_cell">
			              	<xsl:with-param name="left_text">
						         <xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_IFSC_BANK_ADDRESS')"/>
			              	</xsl:with-param>
				              <xsl:with-param name="right_text">	
				              	<xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_1"/>							                	
				              </xsl:with-param>
				               </xsl:call-template>
				               <xsl:if test="counterparties/counterparty/cpty_bank_address_line_2[.!='']">
				              <xsl:call-template name="table_cell">
				              	<xsl:with-param name="left_text"></xsl:with-param>
					               <xsl:with-param name="right_text">									                	
						   	            <xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_2"/>							   	        
					                </xsl:with-param>
					           </xsl:call-template>     		
				              </xsl:if>
			          
					</xsl:if>
					<!-- Bank City -->
					<xsl:if test="sub_product_code[.='MUPS'] and counterparties/counterparty/cpty_bank_dom[.!='']">
						<xsl:call-template name="table_cell">
			              	<xsl:with-param name="left_text">
						         <xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_IFSC_CITY')"/>
			              	</xsl:with-param>
				              <xsl:with-param name="right_text">	
				              	<xsl:value-of select="counterparties/counterparty/cpty_bank_dom"/>								                	
				              </xsl:with-param>
			           </xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			
			</xsl:if>
	<!-- Currently adding this block here ,refactoring of xsl is required for this issue which will be done later. -->
		<xsl:if test="remittance_description[.!=''] and sub_product_code[.='MT103'  or .='FI103' or .='FI202']">			
			<fo:block id="remittancedetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REMITTANCEREASON')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<fo:block xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider" white-space-collapse="false">
				<fo:table>
					<fo:table-column column-width="50%"/>
					<fo:table-column column-width="50%"/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
								<fo:table>
								<fo:table-column column-width="50%"/>
								<fo:table-column column-width="50%"/>
									<fo:table-body start-indent="2pt">
										<fo:table-row>
											<fo:table-cell>
												<fo:block> </fo:block>												
											</fo:table-cell>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
										<xsl:if test="remittance_description[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
									                <xsl:value-of select="localization:getGTPString($language, 'XSL_REMITTANCE_DESCRIPTION')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
									                 <xsl:value-of select="remittance_description"/>
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										</xsl:if>
										<xsl:if test="remittance_code[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
									                <xsl:value-of select="localization:getGTPString($language, 'XSL_REMITTANCECODE')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
									                 <xsl:value-of select="remittance_code"/>
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										</xsl:if>
									</fo:table-body>
								</fo:table>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			</xsl:if>
			
			<fo:block id="applicantDetails"/>
			<xsl:if test="(sub_product_code[.='TRINT'] or sub_product_code[.='TRTPT'] or sub_product_code[.='TINT'] or sub_product_code[.='TTPT']) and (entity[.!=''] or applicant_name[.!=''] or applicant_address_line_1[.!=''] or applicant_address_line_2[.!=''] or applicant_dom[.!=''])">
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
										<xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/>
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
							<!-- Display address -->
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
									<xsl:with-param name="left_text"></xsl:with-param>
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
							
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="counterparties/counterparty/counterparty_name[.!=''] and sub_product_code[.='TTPT']">
					<fo:block id="beneficiaryDetails"/>
					<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						
						<xsl:if test="counterparties/counterparty/counterparty_name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BENEFICIARY_NAME')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty/counterparty_name"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						
						<xsl:if test="counterparties/counterparty/counterparty_address_line_1[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty/counterparty_address_line_1"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Display address -->
						<xsl:if test="counterparties/counterparty/counterparty_address_line_2[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty/counterparty_address_line_2"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
							<xsl:if test="counterparties/counterparty/counterparty_dom[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="counterparties/counterparty/counterparty_dom2"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_ACCOUNT')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/> &nbsp; <xsl:value-of select="counterparties/counterparty/counterparty_act_no"/>
								</xsl:with-param>
							</xsl:call-template>
							
							<xsl:if test="counterparties/counterparty/cpty_bank_name[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_BANK_NAME_WITH_ADDRESS')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="counterparties/counterparty/cpty_bank_name"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="counterparties/counterparty/cpty_branch_name[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BRANCH_NAME')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="counterparties/counterparty/cpty_branch_name"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
						
						<!-- linked licenses -->
			<xsl:if test="(sub_product_code[.='TINT'] or sub_product_code[.='TTPT']) and ((security:isBank($rundata) and  securityCheck:hasPermission($rundata,'tradeadmin_ls_access')) or (security:isCustomer($rundata) and securityCheck:hasPermission($rundata,'ls_access') = 'true')) and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true'"> 
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
						<fo:table-column column-width="0"/>
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

			<!-- outgoing ft_beneficiarydetails_ends-->
			<!--  account details/beneficiary starts-->
			<xsl:if test="sub_product_code[.='TINT']"> 
				<fo:block id="transferDetails"/>
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSFER_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
					<!-- Beneficiary name and details -->
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_NAME_DESCRIPTION')"/>
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="counterparties/counterparty/counterparty_act_no"/>
					</xsl:with-param>
				</xsl:call-template>

				<!-- Amount -->
				<xsl:if test="ft_amt[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_FT_AMT_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ft_cur_code" />&nbsp;
							<xsl:value-of select="ft_amt" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			<!-- mps  debit currency -->
			<!-- Debit Currency / Amount in Save mode-->
<!-- 				<xsl:if test="tnx_stat_code[.='01'] and ft_cur_code[.!=''] and ft_amt[.!=''] and counterparties/counterparty/counterparty_amt[.='']">
					<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_CCY_AND_AMT')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ft_cur_code"/> <xsl:value-of select="ft_amt"/>	
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if> -->

				<!-- Debit Currency / Amount -->
				<xsl:if test="debit_ccy[.!=''] and debit_amt[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_CCY_AND_AMT')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="debit_ccy"/> <xsl:value-of select="debit_amt"/>	
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

			

				<xsl:if test="rate[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_RATE_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="rate"/>	
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_FT_COUNTERPARTY_REFERENCE')"/>
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="counterparties/counterparty/counterparty_reference"/>
					</xsl:with-param>
					</xsl:call-template>
				<!-- forward contract no. -->
				<xsl:if test="fwd_contract_no[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="fwd_contract_no"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<!-- payment_details_to_beneficiary -->
				<xsl:if test="narrative_additional_instructions[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTS_DETAILS_TO_BENEFICIARY')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="narrative_additional_instructions"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>

<!--  account details/beneficiary ends -->

		<!--  transfer details outgoing ft starts-->
			<xsl:if test="sub_product_code[.='TTPT']"> 
				<fo:block id="transferDetails"/>
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSFER_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<!-- fund transfer amount -->
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FT_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="ft_cur_code"/> <xsl:value-of select="ft_amt"/>
							</xsl:with-param>
						</xsl:call-template>
			
						<!-- transfer reference -->
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_FT_COUNTERPARTY_REFERENCE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty/counterparty_reference" />
								</xsl:with-param>
							</xsl:call-template>
						
			
						<!-- forward contract number-->
						<xsl:if test="fwd_contract_no[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="fwd_contract_no"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
			
						<!-- charge option -->
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
								<xsl:choose>
							     		<xsl:when test="open_chrg_brn_by_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_SHA')"/></xsl:when>
							     		<xsl:when test="open_chrg_brn_by_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_OUR')"/></xsl:when>
							     		<xsl:when test="open_chrg_brn_by_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_BEN')"/></xsl:when>
							     		</xsl:choose>	
								</xsl:with-param>
							</xsl:call-template>
			
						<!-- payment_details_to_beneficiary -->
						<xsl:if test="narrative_additional_instructions[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTS_DETAILS_TO_BENEFICIARY')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="narrative_additional_instructions"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!--  transfer details outgoing ft ends-->
			
			<!--Bank Details-->
			<xsl:if test="sub_product_code[.='TRINT'] or sub_product_code[.='TRTPT'] or sub_product_code[.='TINT'] or sub_product_code[.='TTPT']">
			<fo:block id="bankdetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BANK_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					
					
						<!-- Issuing Bank -->
				<xsl:if test="sub_product_code[.!='TINT']">	
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							 <xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ISSUING_BANK')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
					
					<xsl:if test="issuing_bank_name[.!='']">
						<xsl:apply-templates select="issuing_bank_name">
							<xsl:with-param name="theNodeName" select="'issuing_bank_name'"/>
							<xsl:with-param name="issuing_bank_name" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_PAY_THROUGH_BANK')"/>
						</xsl:apply-templates>
					</xsl:if>
					
					<!-- 
					<xsl:apply-templates select="issuing_bank">
						<xsl:with-param name="theNodeName" select="'issuing_bank'" />
						<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ISSUING_BANK')" />
					</xsl:apply-templates>
					<xsl:if test="account_with_bank/name[.!='']">
						<xsl:apply-templates select="account_with_bank">
							<xsl:with-param name="theNodeName" select="'account_with_bank'" />
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ACCOUNT_WITH_BANK')" />
						</xsl:apply-templates>
					</xsl:if>
					<xsl:if test="pay_through_bank/name[.!='']">
						<xsl:apply-templates select="pay_through_bank">
							<xsl:with-param name="theNodeName" select="'pay_through_bank'" />
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_PAY_THROUGH_BANK')" />
						</xsl:apply-templates>
					</xsl:if> -->
					
					<xsl:if test="issuing_bank/name[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="issuing_bank/name"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="applicant_reference[.!=''] and tnx_stat_code[.!='']">
						<xsl:variable name="appl_ref">
                <xsl:value-of select="applicant_reference"/>
              </xsl:variable>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CUST_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="(count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) &gt;= 1) and (//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]/description[.!=''])">
										<xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]/description"/>
									</xsl:when>
									<xsl:when test="(count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) = 0) and (//*/avail_main_banks/bank/customer_reference[reference=$appl_ref]/description[.!=''])">
										<xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$appl_ref]/description"/>
									</xsl:when>
									<xsl:when test="not(//*/avail_main_banks)">
										<xsl:value-of select="$appl_ref"/>
									</xsl:when>
									<xsl:otherwise>
											<xsl:value-of select="utils:decryptApplicantReference(applicant_reference)" />											
									</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Account with bank details and pay through bank for outgoing ft starts-->
					<xsl:if test="account_with_bank/name[.!=''] and (sub_product_code[.!='TRINT'] and sub_product_code[.!='TRTPT'] and sub_product_code[.!='TINT'] and sub_product_code[.='TTPT'])">
						<xsl:apply-templates select="account_with_bank">
							<xsl:with-param name="theNodeName" select="'account_with_bank'" />
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ACCOUNT_WITH_BANK')" />
						</xsl:apply-templates>
					</xsl:if>
					<xsl:if test="pay_through_bank/name[.!=''] and (sub_product_code[.!='TRINT'] and sub_product_code[.!='TRTPT'] and sub_product_code[.!='TINT'] and sub_product_code[.='TTPT'])">
						<xsl:apply-templates select="pay_through_bank">
							<xsl:with-param name="theNodeName" select="'pay_through_bank'" />
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_PAY_THROUGH_BANK')" />
						</xsl:apply-templates>
					</xsl:if>
					<!--  Account with bank details and pay through bank for outgoing ft ends -->
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if> 
			
			<!--transfer Details -->
			<xsl:if test="sub_product_code[.='TRINT'] or sub_product_code[.='TRTPT']">		
						
				<fo:block id="transferDetails"/>
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									 <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSFER_DETAILS')"/>
								</xsl:with-param>
							</xsl:call-template>
							<!-- Contract Type -->
							<xsl:if test="ft_type[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_TYPE_LABEL')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="localization:getDecode($language, 'N029', ft_type[.])"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							
							<!-- Debit Reference -->
							<xsl:if test="payment_deal_no[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_DEBIT_ID')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="payment_deal_no"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							
							<!-- Credit Reference -->
							<xsl:if test="xfer_deal_no[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_CREDIT_ID')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="xfer_deal_no"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							
							<!-- FX Reference -->
							<xsl:if test="fx_deal_no[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_FX_ID')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="fx_deal_no"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							
							<!-- Ordering Account -->
							<xsl:if test="applicant_act_no[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ORDERING_ACT_NO')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="applicant_act_no"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							
							<!-- Debit Currency / Amount in Save mode-->
							<xsl:if test="tnx_stat_code[.='01'] and ft_cur_code[.!=''] and ft_amt[.!=''] and counterparties/counterparty/counterparty_amt[.='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_CCY_AND_AMT')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="ft_cur_code"/> <xsl:value-of select="ft_amt"/>	
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							
							<!-- Debit Currency / Amount -->
							<xsl:if test="debit_ccy[.!=''] and debit_amt[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_DEAL_SUMMARY_LABEL_DEBIT_CCY_AND_AMT')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="debit_ccy"/> <xsl:value-of select="debit_amt"/>	
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						
							<!-- Transfer Currency / Amount -->
							<xsl:if test="counterparties/counterparty[counterparty_type='02']/counterparty_cur_code[.!=''] and counterparties/counterparty[counterparty_type='02']/counterparty_amt[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_DEAL_SUMMARY_LABEL_TRANSFERT_CURRENCY_AMOUNT')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="counterparties/counterparty[counterparty_type='02']/counterparty_cur_code"/> <xsl:value-of select="counterparties/counterparty[counterparty_type='02']/counterparty_amt"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							
							<xsl:if test="counterparties/counterparty[counterparty_type='04']/counterparty_cur_code[.!=''] and counterparties/counterparty[counterparty_type='04']/counterparty_amt[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_TREASURY_PAYMENT_AMT_LABEL')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/counterparty_cur_code"/> <xsl:value-of select="counterparties/counterparty[counterparty_type='04']/counterparty_amt"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							
								
							<xsl:if test="rate[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_RATE_LABEL')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="rate"/>	
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<!-- Request Date -->
							<xsl:if test="iss_date[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FT_REQUEST_DATE_LABEL')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="iss_date"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		
		<!-- Settlement Details -->
		
		<xsl:if test="sub_product_code[.='TRINT'] or sub_product_code[.='TRTPT'] or sub_product_code[.='PIDD'] or sub_product_code[.='PICO']">		
		<fo:block id="settlement Details"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							 <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SETTLEMENT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					
			<xsl:if test="sub_product_code[.='PIDD'] or sub_product_code[.='PICO']">
				<!-- Beneficiary Details-->
				<xsl:call-template name="subtitle">
					<xsl:with-param name="text">
						 <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')"/>
					</xsl:with-param>
				</xsl:call-template>
					
				<!-- Beneficiary Name -->
				<xsl:if test="(counterparties/counterparty[counterparty_type='02'] and tnx_stat_code[.!='01']) or sub_product_code[.='PIDD']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BENEFICIARY_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="counterparties/counterparty/counterparty_name"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				
								
				<!-- Beneficiary Name 2 -->
				<xsl:if test="beneficiary_name_2[.!='']">
					<xsl:call-template name="table_cell">
						<!-- <xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARYDETAILS_NAME')"/>
						</xsl:with-param> -->
						<xsl:with-param name="right_text">
							<xsl:value-of select="beneficiary_name_2"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				
				<!-- Beneficiary Account Number -->
				<xsl:if test="counterparties/counterparty[counterparty_type='02']/counterparty_act_no[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SETTLEMENT_DETAILS_BENEFICIARY_ACCOUNT')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="counterparties/counterparty[counterparty_type='02']/counterparty_act_no"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
		
				<!-- Beneficiary Nick Name -->
				<xsl:if test="$beneficiaryNickName='true' and counterparties/counterparty/beneficiary_nickname[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_NICKNAME')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="counterparties/counterparty/beneficiary_nickname"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>				
					
				<!-- Address line -->
				<xsl:if test="counterparties/counterparty[counterparty_address_line_1[.!='']]">
				  <xsl:call-template name="table_cell">
					  <xsl:with-param name="left_text">
						  <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
					  </xsl:with-param>
					  <xsl:with-param name="right_text">
						<xsl:value-of select="counterparties/counterparty/counterparty_address_line_1"/>
					  </xsl:with-param>
				  </xsl:call-template>
				</xsl:if>  
					
				<xsl:if test="counterparties/counterparty[counterparty_address_line_2[.!='']]">
				  <xsl:call-template name="table_cell">
					  <!-- <xsl:with-param name="left_text">
						  <xsl:value-of
						     	select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')" />
					  </xsl:with-param> -->
					  <xsl:with-param name="right_text">
						<xsl:value-of select="counterparties/counterparty/counterparty_address_line_2"/>
					  </xsl:with-param>
				  </xsl:call-template>
				</xsl:if>
				
				<xsl:if test="beneficiary_address_line_4[.!='']">
				 <xsl:call-template name="table_cell">
					  <!-- <xsl:with-param name="left_text">
						  <xsl:value-of
						     	select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')" />
					  </xsl:with-param> -->
					  <xsl:with-param name="right_text">
						<xsl:value-of select="beneficiary_address_line_4"/>
					  </xsl:with-param>
				  </xsl:call-template>
				</xsl:if>
					 
				<xsl:if test="counterparties/counterparty/counterparty_dom[.!='']"> 
				 <xsl:call-template name="table_cell">
					  <!-- <xsl:with-param name="left_text">
						  <xsl:value-of
						     	select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')" />
					  </xsl:with-param> -->
					  <xsl:with-param name="right_text">
						<xsl:value-of select="counterparties/counterparty/counterparty_dom"/>
					  </xsl:with-param>
				  </xsl:call-template>
				</xsl:if>
				    
			    <xsl:if test="beneficiary_postal_code[.!='']">
			    	<xsl:call-template name="table_cell">
					  <xsl:with-param name="left_text">
						  <xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_POSTAL_CODE')"/>
					  </xsl:with-param>
					  <xsl:with-param name="right_text">
						<xsl:value-of select="beneficiary_postal_code"/>
					  </xsl:with-param>
				  </xsl:call-template>
			    </xsl:if>	
				    									
				<xsl:if test="counterparties/counterparty[counterparty_country[.!='']]">
				  <xsl:call-template name="table_cell">
					  <xsl:with-param name="left_text">
						  <xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_COUNTRY')"/>
					  </xsl:with-param>
					  <xsl:with-param name="right_text">
						<xsl:value-of select="counterparties/counterparty/counterparty_country"/>
					  </xsl:with-param>
				  </xsl:call-template>
			   </xsl:if>
			   <!-- Pre-approved Beneficiary -->
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_PRE_APPROVED')"/>
					</xsl:with-param>
					<xsl:with-param name="right_text">
					<xsl:choose>
						<xsl:when test="pre_approved_status[.='Y']">
							<xsl:value-of select="localization:getDecode($language, 'N034', 'Y')"/> 
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="localization:getDecode($language, 'N034', 'N')"/>
						</xsl:otherwise>
					</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>

			</xsl:if> 	
				
			<xsl:if test="sub_product_code[.='TRINT']">
							
					<!-- Beneficiary Details -->
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							 <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					
					<!-- Beneficiary Name -->
					<xsl:if test="counterparties/counterparty[counterparty_type='02']/counterparty_reference[.!=''] and tnx_stat_code[.!='01']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARYDETAILS_NAME')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="counterparties/counterparty[counterparty_type='02']/counterparty_reference"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
					<!-- Beneficiary Account Number -->
					<xsl:if test="counterparties/counterparty[counterparty_type='02']/counterparty_act_no[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SETTLEMENT_DETAILS_BENEFICIARY_ACCOUNT')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="counterparties/counterparty[counterparty_type='02']/counterparty_act_no"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:if>
				
			<xsl:if test="sub_product_code[.='TRTPT'] ">
				
				<xsl:choose>
					<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.!=''] and counterparties/counterparty[counterparty_type='04']/counterparty_name[.!=''] ">
						<!-- Beneficiary Details -->
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								 <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						
						<xsl:if test="counterparties/counterparty[counterparty_type='04']/settlement_mean[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SETTLEMENT_DETAILS_SETTLEMENT_MEANS')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/settlement_mean"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						
						<xsl:if test="counterparties/counterparty[counterparty_type='04']/settlement_account[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SETTLEMENT_DETAILS_SETTLEMENT_ACCOUNTNUMBER')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/settlement_account"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						
						<xsl:if test="counterparties/counterparty[counterparty_type='04']/counterparty_name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_NAME')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/counterparty_name"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						
						
												<!-- beneficiary address -->
	  
	    	
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/counterparty_address_line_1[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_ADDRESS')"/>
					</xsl:with-param>
					<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="normalize-space(counterparties/counterparty[counterparty_type='04']/counterparty_address_line_1) != ''">
									<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/counterparty_address_line_1"/>
								</xsl:when>
								<xsl:otherwise> <!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
							</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/counterparty_address_line_2[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_ADDRESS_2')"/>
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="normalize-space(counterparties/counterparty[counterparty_type='04']/counterparty_address_line_2) != ''">
								<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/counterparty_address_line_2"/>
								</xsl:when>
								<xsl:otherwise> <!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
							</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/counterparty_dom[.!='']">
				<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_CITY')"/>
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="normalize-space(counterparties/counterparty[counterparty_type='04']/counterparty_dom) != ''">
								<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/counterparty_dom"/>
								</xsl:when>
								<xsl:otherwise> <!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
							</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/counterparty_country[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_COUNTRY')"/>
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="normalize-space(counterparties/counterparty[counterparty_type='04']/counterparty_country) != ''">
									<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/counterparty_country"/>
							</xsl:when>
							<xsl:otherwise> <!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
							</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			
			<xsl:if test="$swift_flag='true'">
				<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_bene_details_clrc[.!='']">
					<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
							<xsl:value-of
							select="localization:getGTPString($language, 'XSL_CLEARING_CODE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_bene_details_clrc) != ''">
								<xsl:choose>
								<xsl:when test="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_bene_details_clrc,$rundata)!=''">
										<xsl:value-of select="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_bene_details_clrc,$rundata)"/>
								</xsl:when>
								<xsl:otherwise>
										<xsl:value-of select="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_bene_details_clrc)"/>
								</xsl:otherwise>
								</xsl:choose>
									</xsl:when>
									<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
								</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
			</xsl:if>
			
			<!-- beneficiary account number -->	
			<xsl:choose>
				<xsl:when test="counterparties/counterparty[counterparty_type='04']/counterparty_act_no !=''">	
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SETTLEMENT_DETAILS_BENEFICIARY_ACCOUNT')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
						<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/counterparty_act_no"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
			
			<!-- bank BIC/SWIFT code -->
			<xsl:choose>
				<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_bank_swift_bic_code !=''">	
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_BIC_CODE_SWIFT')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
						<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_bank_swift_bic_code"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
			
			<!-- bank BIC/SWIFT code -->
			<xsl:choose>
				<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_bank_name !=''">	
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_bank_name"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		
		<!-- bank branch name -->
		<xsl:choose>
			<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_branch_name !=''">	
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_BRANCH')"/>
					</xsl:with-param>
					<xsl:with-param name="right_text">
					<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_branch_name"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
		
		<xsl:choose>
			<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_branch_address_line_1 !='' or counterparties/counterparty[counterparty_type='04']/cpty_branch_address_line_2!=''">	
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_ADRESS')"/>
					</xsl:with-param>
					<xsl:with-param name="right_text">
					<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_branch_address_line_1"/>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_branch_address_line_2 !=''">	
				<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_CITY')"/>
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_branch_address_line_2) != ''">
								<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_branch_address_line_2"/>
								</xsl:when>
								<xsl:otherwise> <!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
							</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="$swift_flag='true'">
				<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_bank_dom !=''">	
				<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_CITY')"/>
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_bank_dom) != ''">
								<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_bank_dom"/>
								</xsl:when>
								<xsl:otherwise> <!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
							</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				</xsl:if>
				<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_bank_country !=''">	
				<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_COUNTRY')"/>
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_bank_country) != ''">
									<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_bank_country"/>
								</xsl:when>
								<xsl:otherwise> <!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
							</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="$swift_flag='true'">
					<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_beneficiary_bank_clrc !=''">	
						<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CLEARING_CODE')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_beneficiary_bank_clrc) != ''">
											<xsl:choose>
													<xsl:when test="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_beneficiary_bank_clrc,$rundata)!=''">
															<xsl:value-of select="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_beneficiary_bank_clrc,$rundata)"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_beneficiary_bank_clrc)" />
													</xsl:otherwise>
													</xsl:choose>
										</xsl:when>
										<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
									</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:if>
		</xsl:when> 
	</xsl:choose>
		
	<!-- bank routing number -->
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_benif_bank_routing_no !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_NUMBER')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_benif_bank_routing_no"/>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:when>
	</xsl:choose>
	
	<!-- ordering customer account number -->
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_order_act_no !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_ACCOUNT_NO')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_act_no"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
	
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_name !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_NAME')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_name"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>	
	
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_city !=''or counterparties/counterparty[counterparty_type='04']/cpty_order_cust_addr!=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_ADDRESS')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_addr"/>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="table_cell">
			<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_CITYSTATE')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:choose>
						<xsl:when test="normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_order_cust_city) != ''">
							<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_city"/>
							</xsl:when>
							<xsl:otherwise> <!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_country[.!='']">
			<xsl:call-template name="table_cell">
			<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_COUNTRY')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:choose>
						<xsl:when test="normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_order_cust_country) != ''">
							<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_country"/>
						</xsl:when>
						<xsl:otherwise> <!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			<xsl:if test="$swift_flag='true'">
				<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_order_details_clrc[.!='']">
					<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_CLEARING_CODE')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
										<xsl:choose>
											<xsl:when test="normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_order_details_clrc) != ''">
											<xsl:choose>
												<xsl:when test="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_order_details_clrc,$rundata)!=''">
														<xsl:value-of select="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_order_details_clrc,$rundata)"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_order_details_clrc)"/>
												</xsl:otherwise>
											</xsl:choose>								
											</xsl:when>
											<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
										</xsl:choose>
								</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:if>
		</xsl:when>
	</xsl:choose>	
		
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_order_account_no !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_ACCOUNT_NO')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_account_no"/>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:when>
	</xsl:choose>
	
	<!-- swift charge -->
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_swift_charges_paid !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_DEAL_SUMMARY_LABEL_SWIFT_CHARGES_TYPE')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="localization:getDecode($language,'N017',counterparties/counterparty[counterparty_type='04']/cpty_swift_charges_paid)"/>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:when>
	</xsl:choose>
	
	<!-- End of beneficiary-fields -->	
		
	
	<!--                                          -->
	<!-- Start free format settlement additional fields -->
	<!--                                          -->			
	<!-- <xsl:choose>
		<xsl:when test="not(normalize-space(cpty_inter_swift_bic_code)) and not(normalize-space(cpty_inter_bank_name)) and not(normalize-space(cpty_inter_bank_addr)) and not(normalize-space(cpty_inter_city_state)) and not(normalize-space(cpty_inter_country)) and
		not(normalize-space(cpty_inter_routing_no)) and not(normalize-space(cpty_inter_routing_1)) and not(normalize-space(cpty_inter_routing_2)) and not(normalize-space(cpty_inter_routing_3))  
		and normalize-space(cpty_inter_routing_4) and normalize-space(cpty_inter_routing_5) and normalize-space(cpty_inter_routing_6)"> 	
			 -->
			 
<xsl:choose>
		<!-- <xsl:when test="normalize-space(cpty_inter_swift_bic_code) !='' or normalize-space(cpty_inter_bank_name) !='' or 
		normalize-space(cpty_inter_bank_addr) !='' or normalize-space(cpty_inter_city_state) !='' or normalize-space(cpty_inter_country) !='' or 
		normalize-space(cpty_inter_routing_no) !='' or normalize-space(cpty_special_routing_1) !='' or normalize-space(cpty_special_routing_2) !='' or 
		normalize-space(cpty_inter_routing_3) !='' or normalize-space(cpty_inter_routing_4) !='' or normalize-space(cpty_inter_routing_5) !='' or 
		normalize-space(cpty_inter_routing_6) !=''">  -->	
		
	<xsl:when test="(counterparties/counterparty[counterparty_type='04']/cpty_inter_swift_bic_code[.!=''])    or (counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_name[.!=''])    or (counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_addr[.!=''])    or (counterparties/counterparty[counterparty_type='04']/cpty_inter_city_state[.!=''])    or (counterparties/counterparty[counterparty_type='04']/cpty_inter_country[.!=''])    or starts-with(counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no, '/')    or (counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no[.!=''])    or (counterparties/counterparty[counterparty_type='04']/cpty_special_routing_1[.!=''])    or (counterparties/counterparty[counterparty_type='04']/cpty_special_routing_2[.!=''])    or (counterparties/counterparty[counterparty_type='04']/cpty_special_routing_3[.!=''])    or (counterparties/counterparty[counterparty_type='04']/cpty_special_routing_4[.!=''])    or (counterparties/counterparty[counterparty_type='04']/cpty_special_routing_5[.!=''])    or (counterparties/counterparty[counterparty_type='04']/cpty_special_routing_6[.!=''])">
	 	
		<xsl:call-template name="subtitle">
		
			<xsl:with-param name="text">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_ADDITIONAL_INSTRUCTIONS_TAB_LABEL')"/>
				</xsl:with-param>
				<!-- <xsl:with-param name="text">
						<xsl:call-template name="settlement-additional-fields" />
				</xsl:with-param> -->
		</xsl:call-template>
		
		<!-- intermediary bank BIC/SWIFT code -->
		<xsl:choose>
			<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_inter_swift_bic_code !=''">	
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_BIC')"/>
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_inter_swift_bic_code"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
		
		<!-- intermediary bank name -->
		<xsl:choose>
			<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_name !=''">	
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK')"/>
					</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_name"/>
						</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
					
					
		
	<!-- beneficiary address -->
	<xsl:choose>    
	    	 <xsl:when test="not(normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_addr)) and not(normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_inter_city_state)) and not(normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_inter_country))">
	         <!-- nothing to display -->
	    	 </xsl:when>
	    	 <xsl:otherwise> 
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_STREET')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_addr) != ''">
								<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_addr"/>
							</xsl:when>
							<xsl:otherwise> <!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="table_cell">
			<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_CITY')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:choose>
						<xsl:when test="normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_inter_city_state) != ''">
							<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_inter_city_state"/>
							</xsl:when>
							<xsl:otherwise> <!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_inter_country[.!='']">
			<xsl:call-template name="table_cell">
			<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_COUNTRY')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:choose>
						<xsl:when test="normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_inter_country) != ''">
							<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_inter_country"/>
						</xsl:when>
						<xsl:otherwise> <!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			<xsl:if test="$swift_flag='true'">
				<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_clrc[.!='']">
						<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_CLEARING_CODE')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_clrc) != ''">
										<xsl:choose>
											<xsl:when test="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_clrc,$rundata)!=''">
													<xsl:value-of select="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_clrc,$rundata)"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_clrc)"/>
											</xsl:otherwise>
										</xsl:choose>								
										</xsl:when>
										<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
									</xsl:choose>
							</xsl:with-param>
					</xsl:call-template>
			</xsl:if>
			</xsl:if>
		</xsl:otherwise>
	</xsl:choose> 
		
	
	<!-- intermediary bank routing number -->
	<xsl:choose>
			<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_ABA')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
					
	<!-- special routing instruction 1 -->
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_1 !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_1')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_1"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>		
		
	<!-- special routing instruction 2 -->
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_2 !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_2')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_2"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>	
		
		
	<!-- special routing instruction 3 -->
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_3 !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_3')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_3"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>	
	
	<!-- special routing instruction 4 -->
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_4 !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_4')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_4"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>	
	
	<!-- special routing instruction 5 -->
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_5 !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_5')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_5"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
	
	<!-- special routing instruction 6 -->
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_6 !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_6')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_6"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
		
		
		</xsl:when>
	</xsl:choose>
	
<!-- End of addtional -->		
	
<!--                                       -->
	<!-- free format settlement payment fields -->
<!--                                       -->
			<xsl:choose>
					<xsl:when test="normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_1) or normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_2) or normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_3) or normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_4)">		
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_PAYMENT_DETAILS_TAB_LABEL')"/>
							</xsl:with-param>
							<!-- <xsl:with-param name="text">
									<xsl:call-template name="settlement-additional-fields" />
							</xsl:with-param> -->
					</xsl:call-template>
					
					<!-- payment detail 1 -->
					<xsl:choose>
						<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_1 !=''">	
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_ADDITIONAL_DETAILS_LINE_1')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_1"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					
					<!-- payment detail 2 -->
					<xsl:choose>
						<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_2 !=''">	
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_ADDITIONAL_DETAILS_LINE_2')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_2"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					
					<!-- payment detail 3 -->
					<xsl:choose>
						<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_3 !=''">	
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_ADDITIONAL_DETAILS_LINE_3')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_3"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					
					<!-- payment detail 4 -->
					<xsl:choose>
						<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_4 !=''">	
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_ADDITIONAL_DETAILS_LINE_4')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_4"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					
			</xsl:when>
		</xsl:choose>			
	</xsl:when>
	
	<xsl:otherwise>
		<xsl:apply-templates select="counterparties/counterparty"/>	
	</xsl:otherwise>
					
   </xsl:choose>
						
					
				
		  </xsl:if>
	</xsl:with-param>
</xsl:call-template>
			
			<!-- comments for return -->
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
		</xsl:if>
			
			
			<!--recurring payment Details -->	
			<xsl:if test="sub_product_code[.='PICO'] or sub_product_code[.='MT103'] or sub_product_code[.='MT101']  or sub_product_code[.='HVPS'] or sub_product_code[.='HVXB'] or sub_product_code[.='BILLP'] or sub_product_code[.='BILLS'] or sub_product_code[.='INT'] or sub_product_code[.='TPT'] or sub_product_code[.='DOM'] or sub_product_code[.='PIDD'] or sub_product_code[.='MUPS'] or sub_product_code[.='MEPS'] or sub_product_code[.='RTGS'] or sub_product_code[.='FI103'] or sub_product_code[.='FI202']">
				<xsl:if test="recurring_payment_enabled[.='Y'] and tnx_type_code[.!='15']">			
					<fo:block id="recurringPaymentDetails"/>
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
						<xsl:choose> 
							<xsl:when test="sub_product_code[.='PICO'] or sub_product_code[.='DOM'] or sub_product_code[.='INT']  or sub_product_code[.='HVPS'] or sub_product_code[.='HVXB'] or sub_product_code[.='TPT'] or sub_product_code[.='MT101'] or sub_product_code[.='MT103'] or sub_product_code[.='PIDD'] or sub_product_code[.='MUPS'] or sub_product_code[.='MEPS'] or sub_product_code[.='RTGS'] or sub_product_code[.='FI103'] or sub_product_code[.='FI202']">
								<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RECURRING_PAYMENT_DETAILS')"/>
								</xsl:with-param>
							</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_RECURRING_PAYMENT_DETAILS')"/>
								</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
							<xsl:if test="recurring_start_date[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SO_START_DATE')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="recurring_start_date"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="recurring_frequency[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_FREQUENCY_MODE')"/>									
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="localization:getDecode($language, 'N416', recurring_frequency)"/>							
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="recurring_on[.!=''] and recurring_frequency[.!=''] and recurring_frequency[.!='DAILY'] and recurring_frequency[.!='WEEKLY'] ">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_RECUR_ON')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:if test="recurring_on[.='01']">
						                 	<xsl:value-of select="localization:getGTPString($language, 'XSL_RECUR_ON_EXACT_DAY')"/>
						                 </xsl:if>
						                 <xsl:if test="recurring_on[.='02']">
						                 	<xsl:value-of select="localization:getGTPString($language, 'XSL_RECUR_ON_LAST_DAY')"/>
						                 </xsl:if>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="recurring_end_date">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SO_END_DATE')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="recurring_end_date"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="recurring_number_transfers[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_NUMBER_OF_TRANSFERS')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="recurring_number_transfers"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>					
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>				
			</xsl:if>		
			
			<!--Ordering Customer Details -->	
			<xsl:if test="sub_product_code[.='FI103'] and (sub_product_code[.!='BILLP'] or sub_product_code[.!='DDA'] or sub_product_code[.!='BILLS'])">	
			<fo:block id="orderingCustomerDetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ORDERING_CUSTOMER_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					
					<!-- Ordering Customer Name and address -->
					<xsl:if test="ordering_customer_name[.!='']">					
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ordering_customer_name"/>
						</xsl:with-param>
					</xsl:call-template>

					<!-- Address -->
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ordering_customer_address_line_1"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="ordering_customer_address_line_2[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="ordering_customer_address_line_2"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="ordering_customer_dom[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="ordering_customer_dom"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					</xsl:if>
					<!-- ordering_customer_account -->
					<xsl:if test="ordering_customer_account[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'ACCOUNTNO_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="ordering_customer_account"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- swift bic code -->
					<xsl:if test="ordering_customer_swift_bic_code[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ORIGINATING_INSTITUTION_SWIFT_BIC_CODE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ordering_customer_swift_bic_code"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!-- Bank name and address -->
					<xsl:if test="ordering_customer_bank_name[.!='']">					
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ordering_customer_bank_name"/>
						</xsl:with-param>
					</xsl:call-template>

					<!-- Address -->
					<xsl:if test="ordering_customer_address_line_2[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ordering_customer_bank_address_line_1"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="ordering_customer_address_line_2[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="ordering_customer_bank_address_line_2"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="ordering_customer_bank_dom[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="ordering_customer_bank_dom"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					</xsl:if>
					<!--ordering_customer_bank_country -->
					<xsl:if test="ordering_customer_bank_country[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="localization:getCodeData($language,'*','*','C006',ordering_customer_bank_country)"/>							
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!-- ordering_customer_bank_account -->
					<xsl:if test="ordering_customer_bank_account[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'ACCOUNTNO_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="ordering_customer_bank_account"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			
			<!--ordering-institution-details -->	
			<xsl:if test="sub_product_code[.='FI202'] and (sub_product_code[.!='BILLP'] or sub_product_code[.!='DDA'] or sub_product_code[.!='BILLS'])">		
			<fo:block id="orderingInstitutionDetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ORDERING_INSTITUTION_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- swift bic code -->
					<xsl:if test="ordering_institution_swift_bic_code[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SWIFT_BIC_CODE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ordering_institution_swift_bic_code"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!-- ordering-institution name and address -->
					<xsl:if test="ordering_institution_name[.!='']">					
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ORDERING_INSTITUTION_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ordering_institution_name"/>
						</xsl:with-param>
					</xsl:call-template>

					<!-- Address -->
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ordering_institution_address_line_1"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="ordering_institution_address_line_2[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="ordering_institution_address_line_2"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="ordering_institution_dom[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="ordering_institution_dom"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					</xsl:if>
					<!-- ordering_institution_country -->
					<xsl:if test="ordering_institution_country[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ordering_institution_country"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!-- ordering_institution_account -->
					<xsl:if test="ordering_institution_account[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'ACCOUNTNO_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ordering_institution_account"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
			</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			
			<!--Beneficiary Details -->
			<xsl:if test="sub_product_code[.!='BILLP'] or sub_product_code[.!='DDA'] or sub_product_code[.!='BILLS'] ">
			<xsl:choose>
			<xsl:when test="sub_product_code[.='MEPS'] or sub_product_code[.='RTGS'] or sub_product_code[.='MT101'] or sub_product_code[.='MT103'] or sub_product_code[.='FI103'] or sub_product_code[.='FI202']">
				<fo:block id="benedetails"/>
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="counterparties/counterparty/counterparty_name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>								
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty/counterparty_name"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="$beneficiaryNickName='true' and counterparties/counterparty/beneficiary_nickname[.!=''] and security:isCustomer($rundata)">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'BENEFICIARY_NICKNAME_LABEL')"/>								
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty/beneficiary_nickname"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="counterparties/counterparty/counterparty_address_line_1[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>								
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty/counterparty_address_line_1"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="counterparties/counterparty/counterparty_address_line_2[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									&nbsp;							
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty/counterparty_address_line_2"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="counterparties/counterparty/counterparty_dom[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									&nbsp;										
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty/counterparty_dom"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="counterparties/counterparty/counterparty_country[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>								
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty/counterparty_country"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="counterparties/counterparty/counterparty_act_no[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_ACCOUNT_REMITTANCE')"/>								
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty/counterparty_act_no"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="pre_approved_status[.='Y']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getGTPString($language,'XSL_TPT_PAB')"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="counterparties/counterparty/cpty_bank_swift_bic_code[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SWIFT_BIC_CODE')"/>								
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty/cpty_bank_swift_bic_code"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="counterparties/counterparty/cpty_bank_name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>								
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty/cpty_bank_name"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="counterparties/counterparty/cpty_bank_address_line_1[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>								
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_1"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="counterparties/counterparty/cpty_bank_address_line_2[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									&nbsp;							
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_2"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="counterparties/counterparty/cpty_bank_dom[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									&nbsp;										
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counterparties/counterparty/cpty_bank_dom"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="counterparties/counterparty/cpty_bank_country[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>										
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getCodeData($language,'*','*','C006',counterparties/counterparty/cpty_bank_country)"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="beneficiary_bank_clearing_code[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CLEARING_CODE_DESCRIPTION')"/>										
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="beneficiary_bank_clearing_code"/>
									<xsl:value-of select="intermediary_bank_clearing_code_desc"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Branch name and address -->
						<xsl:if test="beneficiary_bank_branch_address_line_1[.!='']">	
							<!-- Address -->
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_BRANCH_ADDRESS')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="beneficiary_bank_branch_address_line_1"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="beneficiary_bank_branch_address_line_2[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="beneficiary_bank_branch_address_line_2"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="beneficiary_bank_branch_dom[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="beneficiary_bank_branch_dom"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="beneficiary_name[.!='']">			
			<fo:block id="benedetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:choose> 
								<xsl:when test="sub_product_code[.='FI202']"> <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_INSTITUTION_DETAILS')"/>
								</xsl:when>
								<xsl:otherwise> <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					<!--beneficiary_institution swift bic code -->
					<xsl:if test="beneficiary_institution_swift_bic_code[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SWIFT_BIC_CODE')"/>								
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="beneficiary_institution_swift_bic_code"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:choose> 
								<xsl:when test="sub_product_code[.='FI202']"> <xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_INSTITUTION_NAME')"/>
								</xsl:when>
								<xsl:otherwise> <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
								</xsl:otherwise>
							</xsl:choose>
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
					<!-- beneficiary_account -->
					<xsl:if test="beneficiary_account[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:choose> 
								<xsl:when test="sub_product_code[.='FI202']"> <xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_INSTITUTION_ACCOUNT')"/>
								</xsl:when>
								<xsl:otherwise> <xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_ACCOUNT')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="beneficiary_account"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!-- swift bic code -->
					<xsl:if test="beneficiary_bank_swift_bic_code[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:choose> 
								<xsl:when test="sub_product_code[.='FI202']"> <xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_INSTITUTION_SWIFT_CODE')"/>
								</xsl:when>
								<xsl:otherwise> <xsl:value-of select="localization:getGTPString($language, 'XSL_SWIFT_BIC_CODE')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="beneficiary_bank_swift_bic_code"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!-- Bank name and address -->
					<xsl:if test="beneficiary_bank_name[.!='']">					
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:choose> 
								<xsl:when test="sub_product_code[.='FI202']"> <xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_INSTITUTION_BANK_ADDRESS_NAME')"/>
								</xsl:when>
								<xsl:otherwise> <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="beneficiary_bank_name"/>
						</xsl:with-param>
					</xsl:call-template>

					<!-- Address -->
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="beneficiary_bank_address_line_1"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="beneficiary_bank_address_line_2[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="beneficiary_bank_address_line_2"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="beneficiary_bank_dom[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="beneficiary_bank_dom"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					</xsl:if>
					<!-- beneficiary_bank_country -->
					<xsl:if test="beneficiary_bank_country[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="beneficiary_bank_country"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					
					<!-- Branch name and address -->
					<xsl:if test="beneficiary_bank_branch_address_line_1[.!='']">	
					<!-- Address -->
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_BRANCH_ADDRESS')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="beneficiary_bank_branch_address_line_1"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="beneficiary_bank_branch_address_line_2[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="beneficiary_bank_branch_address_line_2"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="beneficiary_bank_branch_dom[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="beneficiary_bank_branch_dom"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					</xsl:if>
					
					<!-- Clearing Code and description -->
					<xsl:if test="beneficiary_bank_clearing_code[.!=''] and ft_type[.='07']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_CLEARING_CODE_DESCRIPTION')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="beneficiary_bank_clearing_code"/> 
							<xsl:value-of select="beneficiary_bank_clearing_code_desc"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:when>
			</xsl:choose>
			</xsl:if>
			
			<!--intermediary bank Details -->
			
			 <xsl:variable name="mt103InterbankDetailsflag" select="defaultresource:getResource('MT103_INTER_BANK_DETAILS_DISPLAY')"/>
		     <xsl:variable name="mt101InterbankDetailsflag" select="defaultresource:getResource('MT101_INTER_BANK_DETAILS_DISPLAY')"/>
		     <xsl:variable name="fi103InterbankDetailsflag" select="defaultresource:getResource('FI103_INTER_BANK_DETAILS_DISPLAY')"/>
		     <xsl:variable name="fi202InterbankDetailsflag" select="defaultresource:getResource('FI202_INTER_BANK_DETAILS_DISPLAY')"/>
		        
		     <xsl:if test="intermediary_bank_swift_bic_code[.!=''] and((sub_product_code[.='MT103'] and $mt103InterbankDetailsflag = 'true') or (sub_product_code[.='MT101'] and $mt101InterbankDetailsflag = 'true') or (sub_product_code[.='FI103'] and $fi103InterbankDetailsflag = 'true') or (sub_product_code[.='FI202'] and $fi202InterbankDetailsflag = 'true'))">
				<xsl:call-template name="intermediarybankdetails"/>
			</xsl:if>
			<xsl:if test="sub_product_code[.!='BILLP'] and sub_product_code[.!='DDA']  and sub_product_code[.!='BILLS'] and sub_product_code[.!='MT103'] and sub_product_code[.!='MT101'] and sub_product_code[.!='FI103'] and sub_product_code[.!='FI202'] and sub_product_code[.!='TRINT'] and sub_product_code[.!='TRTPT'] and sub_product_code[.!='PIDD'] and sub_product_code[.!='DOM'] and sub_product_code[.!='BANKB'] and sub_product_code[.!='INT'] and sub_product_code[.!='TPT']">
				<xsl:call-template name="intermediarybankdetails"/>
			</xsl:if>
	
			<!--transaction Details -->
			<fo:block id="transactiondetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- Display payee -->
					<xsl:choose>
						<xsl:when test="customer_payee/customer_payee_record/payee_name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">							
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYEE')"/>
									</xsl:with-param>
								<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="$loc_lan = $language and customer_payee/customer_payee_record/local_payee_name[.!='']">
										<xsl:value-of select="customer_payee/customer_payee_record/local_payee_name"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="customer_payee/customer_payee_record/payee_name"/>
									</xsl:otherwise>
								</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
						  <xsl:if test="payee_name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">							
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYEE')"/>
									</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="payee_name"/>
								</xsl:with-param>
							</xsl:call-template>
						  </xsl:if>
						</xsl:otherwise>
					</xsl:choose>
					
					<xsl:if test="service_name[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">							
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SERVICE')"/>
								</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
								<xsl:when test="$loc_lan = $language and customer_payee/customer_payee_record/local_service_name[.!='']">
									<xsl:value-of select="customer_payee/customer_payee_record/local_service_name"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="service_name"/>
								</xsl:otherwise>
							</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
					<xsl:choose>
     				<xsl:when test="customer_payee/customer_payee_record">
     				<xsl:variable name="payeeCode">
                  <xsl:value-of select="payee_code"/>
                </xsl:variable>
                <xsl:variable name="issuing_bank"><xsl:value-of select="/ft_tnx_record/issuing_bank/abbv_name"/></xsl:variable>
						<xsl:for-each select="customer_payee/customer_payee_record/customer_payee_refs/customer_payee_ref_record">
						<xsl:variable name="reference_id">
                    <xsl:value-of select="reference_id"/>
                  </xsl:variable>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:choose>
									<xsl:when test="$loc_lan = $language and local_label[.!='']">
										<xsl:value-of select="local_label"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="label"/>
									     <xsl:text>: </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="field_type[.='S']">
										<xsl:value-of select="payeeutils:getDescriptionFromCode($payeeCode, $reference_id, ref_value, $language, $loc_lan, $issuing_bank)"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="ref_value"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>						
						</xsl:call-template>
						</xsl:for-each>
     				</xsl:when>
     				<xsl:otherwise>
     					<!-- bill_reference_number and other similar fields... -->
					<xsl:for-each select="//*[starts-with(name(),'customer_payee_ref_')]">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_BILL_REFERENCE')"/> <xsl:number value="position()" format="1:" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								 <xsl:value-of select="."/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:for-each>
     				</xsl:otherwise>
   				</xsl:choose>		
					

					<!-- BP and DDA Amount-->
					<xsl:if test="ft_amt[.!=''] and (ft_type[.='07'] or ft_type[.='08'])">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:choose>
									<xsl:when test="sub_product_code ='BILLP'">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENT_AMOUNT')"/>
									</xsl:when>
									<xsl:when test="sub_product_code ='DDA'">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_LIMIT_AMOUNT')"/>
									</xsl:when>
								    <xsl:when test="sub_product_code ='BILLS'">
								        <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TRANSFER')"/>
								    </xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_IR_AMT_LABEL2')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ft_cur_code"/> <xsl:value-of select="ft_amt"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="ft_amt[.!=''] and sub_product_code[.!='DDA'] and (not(amount_access) or  (amount_access[.='true'])) and sub_product_code[.!='BILLP'] and sub_product_code[.!='BILLS']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						<xsl:choose>
							<xsl:when test="sub_product_code[.='PIDD' or .='MT103' or .='PICO' or .='FI103']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_REMITTANCE_AMT_LABEL')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TRANSFER')"/>
							</xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ft_cur_code"/> <xsl:value-of select="ft_amt"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>			
					
					<!-- charge_option -->
					<xsl:if test="charge_option[.!=''] and sub_product_code[.!='HVXB']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							 <xsl:choose>
								 <xsl:when test="charge_option[. = 'SHA'] and sub_product_code[.='MEPS']">
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_SHA_MEPS')"/>
                              </xsl:when>
                              <xsl:when test="charge_option[. = 'SHA'] and sub_product_code[.='RTGS']">
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_SHA_RTGS')"/>
                              </xsl:when>
                              <xsl:when test="charge_option[. = 'SHA']">
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_SHA')"/>
                              </xsl:when>	
								<xsl:when test="charge_option[. = 'OUR'] and sub_product_code[.='MEPS']">
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_OUR_MEPS')"/>
                              </xsl:when>	
                              <xsl:when test="charge_option[. = 'OUR'] and  sub_product_code[.='RTGS']">
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_OUR_RTGS')"/>
                              </xsl:when>	
                              	<xsl:when test="charge_option[. = 'OUR']">
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_OUR')"/>
                              </xsl:when>						     
								<xsl:when test="charge_option[. = 'BEN'] and sub_product_code[.='MEPS']">
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_BEN_MEPS')"/>
                              </xsl:when>
                              <xsl:when test="charge_option[. = 'BEN'] and  sub_product_code[.='RTGS']">
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_BEN_RTGS')"/>
                              </xsl:when>
                              <xsl:when test="charge_option[. = 'BEN']">
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_BEN')"/>
                              </xsl:when>
                              <xsl:otherwise>
                              	<xsl:variable name ="chargeOption">XSL_CHARGE_OPTION_<xsl:value-of select="charge_option"/></xsl:variable>
                              	<xsl:value-of select="localization:getGTPString($language, $chargeOption)"/>
                              </xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>					
					<!-- transfer date -->
					<xsl:if test="(not(recurring_payment_enabled) or recurring_payment_enabled[.='N']) and iss_date[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:choose>
								<xsl:when test="sub_product_code[.='MT103'] or sub_product_code[.='MEPS'] or sub_product_code[.='RTGS']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PROCESSING_DATE')"/>
								</xsl:when>
								<xsl:when test="sub_product_code[.='PICO']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_VALUE_DATE')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSFER_DATE')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="iss_date"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>					
					<!-- start date -->
					<xsl:if test="start_date[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_START_DATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="start_date"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>					
					<!-- end date -->
					<xsl:if test="end_date[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_END_DATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="end_date"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="transfer_purpose[.!=''] and sub_product_code[.='RTGS']">
						<xsl:variable name="transfer_purpose_code">
                          <xsl:value-of select="transfer_purpose"/>
                        </xsl:variable>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">								
					            <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSFER_PURPOSE')"/> 
					     </xsl:with-param>
						<xsl:with-param name="right_text">	
								<xsl:value-of select="utils:retrieveTransferPurposeDescRTGS($rundata, $transfer_purpose_code)"/>						   	            
			                </xsl:with-param>
			               </xsl:call-template>
					</xsl:if>			
					<!-- related_reference -->
					<xsl:if test="related_reference[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_RELATED_REFERENCE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="related_reference"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!-- Urgent Payment -->
					<xsl:if test="urgent_transfer[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_URGENT_TRANSFER_VIEW')"/></xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:if test="urgent_transfer[.='Y']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_URGENT_TRANSFER_YES')"/>
							</xsl:if>
							<xsl:if test="urgent_transfer[.='N']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_URGENT_TRANSFER_NO')"/>
							</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					
					<!-- Related Transaction Date -->
					<xsl:if test="related_transaction_date[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_RELATED_TNX_DATE')"/></xsl:with-param>
							<xsl:with-param name="right_text"><xsl:value-of select="related_transaction_date"/></xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Charge Option -->
					<xsl:if test="charge_option[.!=''] and sub_product_code[.='HVXB']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION')"/></xsl:with-param>
							<xsl:with-param name="right_text">
						    	<xsl:choose>
								     <xsl:when test="charge_option[. = 'OUR']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_OUR')"/></xsl:when>								     
								     <xsl:when test="charge_option[. = 'BEN']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_BEN')"/></xsl:when>
						    		 <xsl:when test="charge_option[. = 'SHA']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_SHA')"/></xsl:when>
						    	</xsl:choose>							
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>					
					<!-- Cross Border Remark -->
					<xsl:if test="cross_border_remark[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CROSS_BORDER_REMARK')"/></xsl:with-param>
							<xsl:with-param name="right_text"><xsl:value-of select="cross_border_remark"/></xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
					<!-- customer_reference -->
					<xsl:if test="cust_ref_id[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:choose> 							
								<xsl:when test="sub_product_code[.='FI103']"> <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTION_REFERENCE')"/>
								</xsl:when>
								<xsl:when test="sub_product_code[.='FI202']"> <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTION_REFERENCE')"/>
								</xsl:when>
								<xsl:otherwise> <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="cust_ref_id"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!-- beneficiary_reference -->
					<xsl:if test="counterparties/counterparty[counterparty_type='02']/counterparty_reference[.!=''] and (sub_product_code[.='TPT'] or sub_product_code[.='INT'] or sub_product_code[.='DOM'] or sub_product_code[.='HVPS'] or sub_product_code[.='HVXB'] or sub_product_code[.='MUPS'])">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							 <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BEN_REF')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="counterparties/counterparty/counterparty_reference"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!-- Business Type -->
					<xsl:variable name="businessTypeDescription">CNAPS_BUSINESS_TYPE_<xsl:value-of select="sub_product_code"/>_<xsl:value-of select="business_type"/></xsl:variable>
					<xsl:if test="business_type[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BUSINESS_TYPE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="business_type"/> - <xsl:value-of select="localization:getGTPString($language, $businessTypeDescription)"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
					<!-- Business Detail Type -->
					<xsl:variable name="businessDetailTypeDescription">CNAPS_BUSINESS_DETAIL_TYPE_<xsl:value-of select="sub_product_code"/>_<xsl:value-of select="business_detail_type"/></xsl:variable>					
					<xsl:if test="business_detail_type[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BUSINESS_DETAIL_TYPE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="business_detail_type"/> - <xsl:value-of select="localization:getGTPString($language, $businessDetailTypeDescription)"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
					
					<!-- payment_details_to_beneficiary -->
					<xsl:if test="payment_details_to_beneficiary[.!=''] and (sub_product_code[.!='MEPS'] and sub_product_code[.!='RTGS'])">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTS_DETAILS_TO_BENEFICIARY')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="payment_details_to_beneficiary"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!-- sender_to_receiver_info -->
					<xsl:if test="sender_to_receiver_info[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SENDER_TO_RECEIVER_INFORMATION')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="sender_to_receiver_info"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!-- Processing date -->
					<xsl:if test="processing_date[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PROCESSING_DATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="processing_date"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!-- request_date -->
					<xsl:if test="request_date[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REQUEST_DATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="request_date"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!--  Debit Account For Charges --> 
					<xsl:if test="debit_account_for_charges[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DEBIT_ACCOUNT_FOR_CHARGES')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="debit_account_for_charges"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!-- Drawn on Country and Delivery Send mode -->
					<xsl:if test="sub_product_code[.='PIDD' or .='PICO']">
					   <xsl:if test="drawn_on_country[.!='']">
						  <xsl:call-template name="table_cell">
						       <xsl:with-param name="left_text">
							      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_DRAWN_ON_COUNTRY')"/>
						       </xsl:with-param>
						       <xsl:with-param name="right_text">
								  <xsl:value-of select="drawn_on_country"/>
						        </xsl:with-param>
						  </xsl:call-template>
					   </xsl:if>
					   <xsl:if test="adv_send_mode[.!='']">
						  <xsl:call-template name="table_cell">
						       <xsl:with-param name="left_text">
							      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_DELIVERY_MODE')"/>
						       </xsl:with-param>
						       <xsl:with-param name="right_text">
								  <xsl:value-of select="localization:getDecode($language, 'N018', adv_send_mode)"/>
						        </xsl:with-param>
						  </xsl:call-template>
					   </xsl:if>
					   <xsl:if test="collecting_bank_code[.!='']">
						  <xsl:call-template name="table_cell">
						       <xsl:with-param name="left_text">
							      <xsl:value-of select="localization:getGTPString($language, 'XSL_BRANCH_CODE')"/>
						       </xsl:with-param>
						       <xsl:with-param name="right_text">
								  <xsl:value-of select="collecting_bank_code"/>
								  <xsl:value-of select="collecting_branch_code"/>
						        </xsl:with-param>
						  </xsl:call-template>
					   </xsl:if>
					     <xsl:if test="collectors_name[.!='']">
						  <xsl:call-template name="table_cell">
						       <xsl:with-param name="left_text">
							      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_COLLECTORS_NAME')"/>
						       </xsl:with-param>
						       <xsl:with-param name="right_text">
								  <xsl:value-of select="collectors_name"/>
						        </xsl:with-param>
						  </xsl:call-template>
					   </xsl:if>
					     <xsl:if test="collectors_id[.!='']">
						  <xsl:call-template name="table_cell">
						       <xsl:with-param name="left_text">
							      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_COLLECTORS_ID')"/>
						       </xsl:with-param>
						       <xsl:with-param name="right_text">
								  <xsl:value-of select="collectors_id"/>
						        </xsl:with-param>
						  </xsl:call-template>
					   </xsl:if>
					   <xsl:if test="narrative_additional_instructions/text[.!='']">
						  <xsl:call-template name="table_cell">
						       <xsl:with-param name="left_text">
							      <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_PAYMT_LABEL')"/>
						       </xsl:with-param>
						       <xsl:with-param name="right_text">
								  <xsl:value-of select="narrative_additional_instructions/text"/>
						        </xsl:with-param>
						  </xsl:call-template>
					   </xsl:if>
				    	<xsl:choose>
						<xsl:when test="sub_product_code[.='PICO']">
							<fo:table-row>
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" space-after.optimum="50.0pt"
												space-before.conditionality="retain">						
										<xsl:value-of select="localization:getGTPString($language,'XSL_GENERALDETAILS_DELIVERY_MODE_PICO_DISCLAIMER')"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:when>
						<xsl:otherwise>
						 <xsl:if test="bulk_ref_id[.='']">
							<fo:table-row>
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" space-after.optimum="50.0pt"
												space-before.conditionality="retain">							
										<xsl:value-of select="localization:getGTPString($language,'XSL_GENERALDETAILS_DELIVERY_MODE_PIDD_DISCLAIMER')"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						  </xsl:if>
						</xsl:otherwise>
						</xsl:choose>
				    	</xsl:if>
						
					<!-- IFSC Description -->
					<xsl:if test="sub_product_code[.='MUPS'] and mups_description_address_line_1[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_MUPS_DESCRIPTION_ADDRESS_HEADER')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="mups_description_address_line_1"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="right_text">
								<xsl:if test="mups_description_address_line_2[.!='']">
									<xsl:value-of select="mups_description_address_line_2"/>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="right_text">
								<xsl:if test="mups_description_address_line_3[.!='']">
									<xsl:value-of select="mups_description_address_line_3"/>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="right_text">
									<xsl:if test="mups_description_address_line_4[.!='']">
										<xsl:value-of select="mups_description_address_line_4"/>
									</xsl:if> 
								</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
				</xsl:call-template>
				<fo:block id="feedetails"/>
				<xsl:if test="count(payment_fee_details/Debit_fees/feeDetails) != 0">
				<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_HEADER_FEE_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_FEE_DETAILS_DISCLAIMER_VIEW')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_HEADER_TRANSACTION_FEE_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				
				<xsl:for-each select="payment_fee_details/Debit_fees/feeDetails">
					<xsl:call-template name="TRANSACTION-FEE-DETAILS" />
				</xsl:for-each>
				</xsl:if>
				<xsl:if test="count(payment_fee_details/Agent_fees/feeDetails) != 0">
				<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_HEADER_AGENT_FEE_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:for-each select="payment_fee_details/Agent_fees/feeDetails">
					<xsl:call-template name="TRANSACTION-FEE-DETAILS" />
				</xsl:for-each>
				</xsl:if>
			
			<xsl:if test="(sub_product_code[.='MEPS'] or sub_product_code[.='RTGS'])and payment_details_to_beneficiary[.!='']">			
			<fo:block font-size="{$pdfFontSize}" keep-together="always" white-space-collapse="false">
			<fo:block id="paymentNarrativeDetails"/>
				<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
					<fo:table-column column-width="{$pdfTableWidth}"/>
					<fo:table-column column-width="0"/>
					<fo:table-body>
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PAYMENT_NARRATIVE_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<fo:table-row>
							<fo:table-cell>
								<fo:block space-before.conditionality="retain" space-before.optimum="10.0pt" start-indent="20.0pt">
									<xsl:value-of select="payment_details_to_beneficiary"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			</xsl:if>
			
			<xsl:if test="(sub_product_code[.='MT101']  or sub_product_code[.='DOM'] or sub_product_code[.='MT103'] or sub_product_code[.='TPT'] or sub_product_code[.='MUPS']  or sub_product_code[.='HVPS'] or sub_product_code[.='HVXB'] or sub_product_code[.='MEPS'] or sub_product_code[.='RTGS']) and notify_beneficiary_email[.!='']">

			<fo:block id="beneficiaryemailnotification"/>		
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
				<xsl:if test="notify_beneficiary_email[.!='']">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_BENEFICIARY_NOTIFICATION')"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!-- Display notify_beneficiary_email -->
					<xsl:if test="notify_beneficiary_email[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">							
									<xsl:value-of select="localization:getGTPString($language, 'XSL_FT_NOTIFY_BENEFICIARY')"/>
								</xsl:with-param>
							<xsl:with-param name="right_text">
									<xsl:value-of select="notify_beneficiary_email"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	
				
			<!-- FX Details for PaperInstruments -->
			<!-- <xsl:call-template name="fx-common-details"/> -->
			
			<!-- Beneficiary Details for Bulk FTs -->
			 <xsl:call-template name="beneficiary-advice"/>
			
			<!--forex Details -->	
			<xsl:if test="sub_product_code[.!='BILLP'] and sub_product_code[.!='DDA'] and sub_product_code[.!='BILLS'] ">	
			<!-- FX Details for PaperInstruments -->
			<xsl:call-template name="fx-common-details"/>
			</xsl:if>
			
			<!-- beneficiary Advice details -->		
			<xsl:if test="bene_adv_flag[.='Y'] and sub_product_code[.!='BILLP'] and sub_product_code[.!='DDA'] and sub_product_code[.!='BILLS'] and sub_product_code[.!='TRINT'] and sub_product_code[.!='TRTPT'] and sub_product_code[.!='DOM'] and sub_product_code[.!='MT101'] and sub_product_code[.!='MT103'] and sub_product_code[.!='INT']">
			<fo:block id="beneAdvicedetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_ADVICE_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			
			<!--Instruction to Bank -->
			<xsl:if test="instruction_to_bank[.!='']">
			<fo:block font-size="{$pdfFontSize}" keep-together="always" white-space-collapse="false">
				<fo:block id="instructiontobankdetails"/>
				<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
					<fo:table-column column-width="{$pdfTableWidth}"/>
					<fo:table-column column-width="0"/>
					<fo:table-body>
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_INSTRUCTION_TO_BANK_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<fo:table-row>
							<fo:table-cell>
								<fo:block space-before.conditionality="retain" space-before.optimum="10.0pt" start-indent="20.0pt">
									<xsl:value-of select="instruction_to_bank"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			</xsl:if>
			
			<!--transaction Remarks -->
			<xsl:if test="transaction_remarks[.!='']">
			<fo:block font-size="{$pdfFontSize}" keep-together="always" white-space-collapse="false">
				<fo:block id="tnxRemarksdetails"/>
				<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
					<fo:table-column column-width="{$pdfTableWidth}"/>
					<fo:table-column column-width="0"/>
					<fo:table-body>
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_REMARKS_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<fo:table-row>
							<fo:table-cell>
								<fo:block space-before.conditionality="retain" space-before.optimum="10.0pt" start-indent="20.0pt">
									<xsl:value-of select="transaction_remarks"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			</xsl:if>
			<!--transaction Remarks -->
			<xsl:if test="free_format_text/text[.!='']">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:choose>
				     			<xsl:when test="sub_product_code ='TPT' or sub_product_code ='INT' or sub_product_code ='HVPS' or sub_product_code ='HVXB'"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_PAYMENT_NARRATIVE')"/></xsl:when>
				     			<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_REMARKS_DETAILS')"/></xsl:otherwise>
				     		</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:apply-templates select="free_format_text">
						<xsl:with-param name="theNodeName" select="'free_format_text'"/>
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
				<fo:block color="{$footerFontColor}" font-weight="bold" text-align="start">
					<!-- <xsl:value-of select="localization:getGTPString($language, 'XSL_FO_PAGE')" 
						/>&nbsp; -->
					<fo:page-number/>
					/
					<!-- &nbsp;<xsl:value-of select="localization:getGTPString($language, 
						'XSL_FO_OF')" />&nbsp; -->
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
  
  
  
  <xsl:template name="TRANSACTION-FEE-DETAILS">
  <fo:block>
  <fo:table>
  <fo:table-body>
	<fo:table-row>
		<fo:table-cell>
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:if test="fee_name != ''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_FT_FEE_NAME')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="fee_name"/>
						</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="fee_amt != ''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_FT_FEE_AMOUNT')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="fee_amt"/>
						</xsl:with-param>
				</xsl:call-template>
				</xsl:if>					
				<xsl:if test="tax_amount != ''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_FT_TAX_AMOUNT')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="tax_amount"/>
						</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="tax_on_tax_amt != ''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_FT_TAX_ON_TAX_AMOUNT')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="tax_on_tax_amt"/>
						</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="total_fee != ''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_FT_TOTAL_FEES')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="total_fee"/>
						</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="total_transaction_fee != '' or total_agent_fee != ''">
				<xsl:choose>
				<xsl:when test="total_transaction_fee != '' and total_transaction_fee != 0.00">
				<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_FT_TOTAL_TRANSACTION_FEES')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="total_transaction_fee"/>
						</xsl:with-param>
				</xsl:call-template>
				</xsl:when>
				<xsl:when test="total_agent_fee != '' and total_agent_fee != 0.00">
				<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_FT_TOTAL_AGENT_FEES')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="total_agent_fee"/>
						</xsl:with-param>
				</xsl:call-template>
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
				</xsl:if>
				<xsl:call-template name="table_cell">					
				</xsl:call-template>
				<xsl:if test="grand_total_fees != '' and grand_total_fees != 0.00">
				<xsl:call-template name="table_cell3">
						<xsl:with-param name="left_text3">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GRAND_TOTAL_FEES')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="grand_total_fees"/>
						</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
			
			</xsl:with-param>
		</xsl:call-template>
		</fo:table-cell>
		</fo:table-row>
		<fo:table-row>
		<fo:table-cell>
		<fo:block> </fo:block>												
		</fo:table-cell>
		</fo:table-row>
		</fo:table-body>
		</fo:table>
		</fo:block>
	</xsl:template>
</xsl:stylesheet>