<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright (c) 2006-2012 Misys , All Rights Reserved -->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:localization="xalan://com.misys.portal.common.localization.Localization" xmlns:utils="xalan://com.misys.portal.common.tools.Utils" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>


	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>

	<xsl:template match="ft_tnx_record[ft_type/text()='01' or ft_type/text()='02']">
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
			<fo:block id="gendetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/>
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
										<xsl:if test="applicant_act_name[.!='']">	
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
										            <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSFER_FROM')"/>									   	                									   	        
								                </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>										                	
									   	            <xsl:value-of select="applicant_act_name"/>									   	        
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="issuing_bank/name[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>												
										            <xsl:value-of select="localization:getGTPString($language, 'BANK_LABEL')"/> 
										        </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="issuing_bank/name"/>									   	            
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										</xsl:if>
										<xsl:if test="sub_product_code[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODUCT_TYPE')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code)"/>
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										</xsl:if>											
									</fo:table-body>
								</fo:table>
							</fo:table-cell>				               
						    <fo:table-cell>
						        <fo:table>
						       <fo:table-column column-width="40%"/>
								<fo:table-column column-width="60%"/>
									<fo:table-body start-indent="1pt">
									<fo:table-row>
								           <fo:table-cell>
								            <fo:block> </fo:block>            
								           </fo:table-cell>
								           <fo:table-cell>
								            <fo:block> </fo:block>
								           </fo:table-cell>
								        </fo:table-row>
										<fo:table-row>
											<fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="ref_id"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<xsl:if test="bo_ref_id[.!='']">
										<fo:table-row>
											<fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="bo_ref_id"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<fo:table-row>
											<fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
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
										<xsl:if test="template_id[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>											
														<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TEMPLATE_ID')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="template_id"/>													
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
			
			<xsl:if test="sub_product_code[.='TINT'  or .='TTPT'] and (applicant_name[.!=''] or applicant_address_line_1[.!=''] or applicant_address_line_2[.!=''] or applicant_dom[.!=''])">
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
							<xsl:if test="applicant_act_no[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ORDERING_ACT_NO')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="applicant_act_cur_code"/> <xsl:value-of select="applicant_act_no"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			
			 <!--Recurring Payment Details -->
			<xsl:if test="recurring_payment_enabled[.='Y']">			
			<fo:block id="recurringPaymentDetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							 <xsl:value-of select="localization:getGTPString($language, 'XSL_RECURRING_PAYMENT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
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
					<xsl:choose> 
						<xsl:when test="recurring_frequency[.='DAILY' or .='WEEKLY' or .='MONTHLY' or .='QUARTERLY']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_FREQUENCY_MODE')"/>									
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getDecode($language, 'N416', recurring_frequency)"/>							
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_FREQUENCY_MODE')"/>									
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="recurring_frequency"/>							
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="recurring_end_date[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SO_END_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="recurring_end_date"/>
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
			
			 <!--Beneficiary Details -->
			<xsl:if test="counterparties/counterparty/counterparty_name[.!='']">			
			<fo:block id="transferToDetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							 <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSFER_TO_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<fo:block xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider" font-size="8pt" white-space-collapse="false">
				<fo:table>
					<fo:table-column column-width="40%"/>
					<fo:table-column column-width="60%"/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
								<fo:table>
								<fo:table-column column-width="25%"/>
								<fo:table-column column-width="75%"/>
									<fo:table-body start-indent="2pt">
									<fo:table-row>
								           <fo:table-cell>
								            <fo:block> </fo:block>            
								           </fo:table-cell>
								           <fo:table-cell>
								            <fo:block> </fo:block>
								           </fo:table-cell>
								        </fo:table-row>
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:choose>
														<xsl:when test="sub_product_code[.='INT'  or .='TINT']"> 
															<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSFER_TO')"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BENEFICIARY_NAME')"/>
														</xsl:otherwise>
													</xsl:choose>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:choose>
														<xsl:when test="sub_product_code[.='INT' or .='TINT']">
															<xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/> <xsl:value-of select="counterparties/counterparty/counterparty_act_no"/> <xsl:value-of select="counterparties/counterparty/counterparty_name"/>
														</xsl:when>
														<xsl:otherwise>
											                <xsl:value-of select="counterparties/counterparty/counterparty_name"/>
														</xsl:otherwise>
													</xsl:choose>
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										<xsl:if test="sub_product_code[.='MEPS' or .='TTPT'] and counterparties/counterparty/counterparty_address_line_1[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
										            <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>									   	                									   	        
								                </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>									                	
									   	            <xsl:value-of select="counterparties/counterparty/counterparty_address_line_1"/>							   	        
								                </fo:block>	
								                <xsl:if test="counterparties/counterparty/counterparty_address_line_2[.!='']">
									               <fo:block>									                	
										   	            <xsl:value-of select="counterparties/counterparty/counterparty_address_line_2"/>							   	        
									                </fo:block>	
								                </xsl:if>
								                <xsl:if test="counterparties/counterparty/counterparty_dom[.!='']">
									                <fo:block>									                	
										   	            <xsl:value-of select="counterparties/counterparty/counterparty_dom"/>							   	        
									                </fo:block>
								                </xsl:if>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<!-- beneficiary_account -->
										<xsl:if test="sub_product_code[.!='INT' and .!='TINT'] and counterparties/counterparty/counterparty_act_no[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>											
										            <xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_ACCOUNT')"/> 
										        </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>	
													<xsl:value-of select="counterparties/counterparty/counterparty_act_no"/>						   	            
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										</xsl:if>
										<xsl:if test="transfer_purpose[.!='']">
											<xsl:variable name="transfer_purpose_code">
                          <xsl:value-of select="transfer_purpose"/>
                        </xsl:variable>
										<fo:table-row>
											<fo:table-cell>
												<fo:block>											
										            <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSFER_PURPOSE')"/> 
										        </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>	
													<xsl:value-of select="utils:retrieveTransferPurposeDesc($rundata, $transfer_purpose_code)"/>						   	            
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										</xsl:if>
									</fo:table-body>
								</fo:table>
							</fo:table-cell>				               
						    <fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
						        <fo:table>
						        <fo:table-column column-width="30%"/>
								<fo:table-column column-width="70%"/>
									<fo:table-body start-indent="1pt">
									<fo:table-row>
								           <fo:table-cell>
								            <fo:block> </fo:block>            
								           </fo:table-cell>
								           <fo:table-cell>
								            <fo:block> </fo:block>
								           </fo:table-cell>
								        </fo:table-row>
										<xsl:if test="sub_product_code[.='IBG'] and counterparties/counterparty/cpty_bank_code">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_BRANCH_CODE')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="counterparties/counterparty/cpty_bank_code"/> 
													<xsl:value-of select="counterparties/counterparty/cpty_branch_code"/>
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										</xsl:if>
										<!-- swift bic code -->
										<xsl:if test="sub_product_code[.='MEPS'] and counterparties/counterparty/cpty_bank_swift_bic_code[.!='']">								
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_SWIFT_BIC_CODE')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="counterparties/counterparty/cpty_bank_swift_bic_code"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<!-- Bank name and address -->
										<xsl:if test="counterparties/counterparty/cpty_bank_name[.!='']">	
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_BANK_NAME_WITH_ADDRESS')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="counterparties/counterparty/cpty_bank_name"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<!-- Branch -->
										<xsl:if test="counterparties/counterparty/cpty_branch_name[.!='']">	
										<fo:table-row>
											<fo:table-cell>
												<fo:block>												
														<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BRANCH_NAME')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="counterparties/counterparty/cpty_branch_name"/>													
											   </fo:block>
											</fo:table-cell>
										</fo:table-row>
									  </xsl:if>
									  <!-- Address -->
										<xsl:if test="sub_product_code[.='MEPS']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>											
														<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_1"/>											
											   </fo:block>
											    <xsl:if test="counterparties/counterparty/cpty_bank_address_line_2[.!='']">
									                <fo:block>								                	
										   	            <xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_2"/>							   	        
									                </fo:block>	
								                </xsl:if>
								                <xsl:if test="counterparties/counterparty/cpty_bank_dom[.!='']">
									                <fo:block>							                	
										   	            <xsl:value-of select="counterparties/counterparty/cpty_bank_dom"/>							   	        
									                </fo:block>
								                </xsl:if>	
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
		<!--transaction Details -->		
			<fo:block id="transactiondetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_DETAILS')"/>
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
								        <xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
											<xsl:if test="ft_amt[.!='']">
												<fo:table-row>
													<fo:table-cell>
														<fo:block>
											                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TRANSFER')"/>
										   	            </fo:block>	
													</fo:table-cell>
													<fo:table-cell>
														<fo:block>
											                <xsl:value-of select="ft_cur_code"/> <xsl:value-of select="ft_amt"/>
										                </fo:block>	
													</fo:table-cell>
												</fo:table-row>	
											</xsl:if>
										</xsl:if>
										<!-- customer_reference -->
										<xsl:if test="cust_ref_id[.!=''] and sub_product_code[.!='TTPT' and .!='TINT']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
										            <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/>									   	                									   	        
								                </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>									                	
									   	            <xsl:value-of select="cust_ref_id"/>									   	        
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										
										<xsl:if test="sub_product_code[.='TTPT'] and open_chrg_brn_by_code[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
										            <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION')"/>									   	                									   	        
								                </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>									                	
									   	            <xsl:choose>
									   	            <xsl:when test="open_chrg_brn_by_code[. = '01']">
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_SHA')"/>
                              </xsl:when>
									   	            <xsl:when test="open_chrg_brn_by_code[. = '02']">
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_OUR')"/>
                              </xsl:when>
									   	            <xsl:when test="open_chrg_brn_by_code[. = '03']">
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_BEN')"/>
                              </xsl:when>
											     	</xsl:choose>									   	        
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										
										<xsl:if test="narrative_additional_instructions[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>	
												<xsl:choose>
												<xsl:when test="sub_product_code[.='TINT' or .='TTPT']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTS_DETAILS_TO_BENEFICIARY')"/>
												</xsl:when>
												<xsl:otherwise>									
										           <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_PAYMENT_DETAILS')"/> 
										        </xsl:otherwise>
										        </xsl:choose>
										        </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="narrative_additional_instructions"/>									   	            
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										</xsl:if>																	
									</fo:table-body>
								</fo:table>
							</fo:table-cell>				               
						    <fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
						        <fo:table>
						        <fo:table-column column-width="40%"/>
								<fo:table-column column-width="60%"/>
									<fo:table-body start-indent="1pt">
									<fo:table-row>
								           <fo:table-cell>
								            <fo:block> </fo:block>            
								           </fo:table-cell>
								           <fo:table-cell>
								            <fo:block> </fo:block>
								           </fo:table-cell>
								        </fo:table-row>
									<!-- Processing date -->
									<xsl:if test="iss_date[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TRANSFER_DATE')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="iss_date"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</xsl:if>
									<xsl:if test="counterparties/counterparty/counterparty_reference[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="counterparties/counterparty/counterparty_reference"/>
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
			
			<!--Bank Details-->
			<xsl:if test="sub_product_code[.='TINT' or .='TTPT']">
			<fo:block id="bankdetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BANK_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:apply-templates select="issuing_bank">
						<xsl:with-param name="theNodeName" select="'issuing_bank'"/>
						<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ISSUING_BANK')"/>
					</xsl:apply-templates>
					<xsl:if test="account_with_bank/name[.!='']">
						<xsl:apply-templates select="account_with_bank">
							<xsl:with-param name="theNodeName" select="'account_with_bank'"/>
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ACCOUNT_WITH_BANK')"/>
						</xsl:apply-templates>
					</xsl:if>
					<xsl:if test="pay_through_bank/name[.!='']">
						<xsl:apply-templates select="pay_through_bank">
							<xsl:with-param name="theNodeName" select="'pay_through_bank'"/>
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_PAY_THROUGH_BANK')"/>
						</xsl:apply-templates>
					</xsl:if>
					<xsl:if test="applicant_reference[.!='']">
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
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			
			<!--forex Details -->		
			<xsl:call-template name="fx-common-details"/>
			<!--<fo:block id="forexdetails" />
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_FOREIGN_EXCHANGE_DETAILS')" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>-->
			
			<!-- beneficiary Advice details -->		
			<xsl:call-template name="beneficiary-advice"/>
						
			<!--Transaction Remarks -->
			<xsl:if test="free_format_text[.!=''] and sub_product_code[.!='TTPT' and .!='TINT']">
			<fo:block id="tnxRemarksdetails"/>
				<xsl:call-template name="table_template">	
					<xsl:with-param name="text">		
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_REMARKS_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text"/>
							<xsl:with-param name="right_text">
								<xsl:value-of select="free_format_text"/>
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
