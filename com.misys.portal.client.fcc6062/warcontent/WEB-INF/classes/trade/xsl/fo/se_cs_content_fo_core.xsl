<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com), All 
	Rights Reserved. -->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck" xmlns:security="xalan://com.misys.portal.security.GTPSecurity" xmlns:utils="xalan://com.misys.portal.common.tools.Utils" xmlns:localization="xalan://com.misys.portal.common.localization.Localization" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="localization security securityCheck utils" version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>


	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>

	<xsl:template match="se_tnx_record">
		<!-- HEADER -->
		
		<!-- FOOTER -->
		
		<!-- BODY -->
		
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
			
			<!-- General Details START-->		
		<xsl:if test="security:isBank($rundata) or sub_product_code[.='CQBKR'] or sub_product_code[.='COCQS'] ">	
			<fo:block id="gendetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- Entity -->
					<xsl:if test="entity[.!=''] and sub_product_code[.!='CQBKR'] and sub_product_code[.!='COCQS']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ENTITY')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="entity"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Bank name -->
					<xsl:if test="issuing_bank/name[.!=''] and (sub_product_code[.='CQBKR'] or sub_product_code[.='COCQS'])">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:choose>
								<xsl:when test="$isMultiBank='Y'">
									<xsl:value-of select="localization:getGTPString($language, 'CUSTOMER_BANK_LABEL')" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="localization:getGTPString($language, 'BANK_NAME')" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="issuing_bank/name" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!--System ID  -->
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="ref_id"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- Nick Name  -->
					<xsl:if test="applicant_act_nickname[.!=''] and security:isCustomer($rundata) and securityCheck:hasPermission($rundata,'sy_account_nickname_access')">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACCOUNT_NICK_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="applicant_act_nickname"/>
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
					<!--application Date -->
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="appl_date"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- type -->
					<xsl:if test="sub_product_code[.!=''] and sub_product_code[.!='CQBKR'] and sub_product_code[.!='COCQS']">
 		 			<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SECURE_EMAIL_TYPE')"/>
		   				</xsl:with-param>	
		   				<xsl:with-param name="right_text">
							<xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code[.])" />
						</xsl:with-param>
		   			</xsl:call-template>
		   			</xsl:if>
 					<!-- account number -->
					<xsl:if test="act_no[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SE_ACT_NO_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="act_no"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Bank Reference -->
					<xsl:if test="bo_ref_id[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SE_BANK_REF')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bo_ref_id"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- template id -->
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
					<!-- UPLOAD FILE TYPE -->
					<xsl:if test="sub_product_code[.='ULOAD'] and upload_file_type[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'UPLOAD_FILE_TYPE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="upload_file_type"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_SIZE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="file_size"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>				
					<!-- Priority -->
					<xsl:if test="priority[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SE_PRIORITY')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
					            <xsl:when test="priority[.='1']">
					                   <xsl:value-of select="localization:getGTPString($language, 'XSL_SE_PRIORITY_HIGH')"/>
					            </xsl:when>
					            <xsl:when test="priority[.='2']">
					                    <xsl:value-of select="localization:getGTPString($language, 'XSL_SE_PRIORITY_MEDIUM')"/>
					            </xsl:when>
					            <xsl:when test="priority[.='3']">
					                   <xsl:value-of select="localization:getGTPString($language, 'XSL_SE_PRIORITY_LOW')"/>
					            </xsl:when>
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
					<!-- Topic -->
					<xsl:if test="topic[.!=''] and se_type[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SE_TOPIC')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="topic"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- ADVICES TYPE -->
					<xsl:if test="se_type[.='09']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SE_ADVICES_TYPE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getDecode($language, 'N430', '09')"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="se_type[.='10']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SE_ADVICES_TYPE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getDecode($language, 'N430', '10')"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="sub_product_code[.!='CQBKR'] and sub_product_code[.!='COCQS']">
						<!-- Issuing Bank subtitle-->
						<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'ADDENDUM_ISSUING_BANK')"/>
								</xsl:with-param>
						</xsl:call-template>
						<!-- bank name -->
						<xsl:if test="issuing_bank/name[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="issuing_bank/name" />
									</xsl:with-param>
								</xsl:call-template>
						</xsl:if>
					</xsl:if>
					</xsl:with-param>
					</xsl:call-template>
					
			</xsl:if>
			<!-- General Details END-->
			
			
				
			<!--Cheque Details START-->
			<xsl:if test="sub_product_code[.='COCQS'] or sub_product_code[.='CQBKR']">
			<fo:block id="chequedetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CHEQUE_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<fo:block xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider" white-space-collapse="false">
				<fo:table>
					<fo:table-column column-width="60%"/>
					<fo:table-column column-width="40%"/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
								<fo:table>
								<fo:table-column column-width="40%"/>
								<fo:table-column column-width="60%"/>
									<fo:table-body start-indent="2pt">
										<fo:table-row>
											<fo:table-cell>
												<fo:block> </fo:block>												
											</fo:table-cell>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
										<!-- Entity -->
										<xsl:if test="entity[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ENTITY')"/>
												</fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="entity"/>
												</fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="applicant_act_name[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_SE_ACT_NO_LABEL')"/>
												</fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="applicant_act_name"/>
												</fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="cheque_type[.!='']">	
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_CHEQUEDETAILS_CHEQUE_TYPE')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>													
													<xsl:value-of select="localization:getDecode($language, 'N115', cheque_type)"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="cheque_number_from[.!='']">	
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CHEQUE_NUMBER_FROM')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="cheque_number_from"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="cheque_number_to[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CHEQUE_NUMBER_TO')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="cheque_number_to"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>	
										
										<xsl:if test="no_of_cheque_books[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_NUMBER_OF_CHEQUE_BOOKS')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="no_of_cheque_books"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>																											
										<xsl:if test="adv_send_mode[.!='']">	
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_DELIVERY_MODE')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>													
													<xsl:value-of select="localization:getDecode($language, 'N018', adv_send_mode)"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										
										<xsl:if test="collecting_bank_code[.!='']">	
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_BRANCH_CODE')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="collecting_bank_code"/> / <xsl:value-of select="collecting_branch_code"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>												
										<xsl:if test="collectors_name[.!='']">	
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_COLLECTORS_NAME')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="collectors_name"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="collectors_id[.!='']">	
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_COLLECTORS_ID')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="collectors_id"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>											
										<fo:table-row>
										<fo:table-cell number-columns-spanned="3" padding-top="15pt" wrap-option="wrap">
												<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_CQBKR_DISCLAIMER')"/>
								   	            </fo:block>	
										</fo:table-cell>
										</fo:table-row>	
														
									</fo:table-body>
								</fo:table>
							</fo:table-cell>
											               
						      <fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
						        <fo:table>
						       <fo:table-column column-width="40%"/>
								<fo:table-column column-width="60%"/>
									<fo:table-body>
										<fo:table-row>
											<fo:table-cell>
												<fo:block> </fo:block>												
											</fo:table-cell>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
									    <xsl:if test="appl_date[.!='']">		
										<fo:table-row>
											<fo:table-cell>
												<fo:block>												
										            <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')"/> 
										        </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="appl_date"/>									   	            
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
			<!--Transaction Details END -->
			
		
		
			
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
</xsl:stylesheet>