<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright (c) 2006-2012 Misys , All Rights Reserved -->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:localization="xalan://com.misys.portal.common.localization.Localization" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>

	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>

	<xsl:template match="ft_tnx_record[ft_type/text()='09']">
		<!-- HEADER -->
		
		<!-- FOOTER -->
		
		<!-- BODY -->
		
	<xsl:call-template name="header"/>
    <xsl:call-template name="footer"/>
    <xsl:call-template name="body"/>
  </xsl:template>
	<xsl:template name="intermediarybanksdetails">
		<fo:block id="intermediaryBankdetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_INTERMEDIARY_BANK_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<fo:block xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider" font-size="8pt" white-space-collapse="false">
				<fo:table>
					<fo:table-column column-width="50%"/>
					<fo:table-column column-width="50%"/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
								<fo:table>
								<fo:table-column column-width="30%"/>
								<fo:table-column column-width="70%"/>
									<fo:table-body start-indent="2pt">
										<fo:table-row>
											<fo:table-cell>
												<fo:block> </fo:block>												
											</fo:table-cell>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
									    <xsl:if test="intermediary_bank_swift_bic_code[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
									                <xsl:value-of select="localization:getGTPString($language, 'XSL_SWIFT_BIC_CODE')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
									                 <xsl:value-of select="intermediary_bank_swift_bic_code"/>
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										</xsl:if>
										<xsl:if test="intermediary_bank_name[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="intermediary_bank_name"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										</xsl:if>
										<xsl:if test="intermediary_bank_address_line_1[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="intermediary_bank_address_line_1"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="intermediary_bank_address_line_2[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>											
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="intermediary_bank_address_line_2"/>													
											   </fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="intermediary_bank_dom[.!='']">
										<fo:table-row>
										<fo:table-cell>
												<fo:block>											
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="intermediary_bank_dom"/>													
											   </fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="intermediary_bank_country[.!='']">
										<fo:table-row>
										<fo:table-cell>
												<fo:block>	
													<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>										
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="intermediary_bank_country"/>													
											   </fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>				
									</fo:table-body>
								</fo:table>
							</fo:table-cell>
											               
						    <fo:table-cell>
						        <fo:table>
						       <fo:table-column column-width="30%"/>
								<fo:table-column column-width="70%"/>
									<fo:table-body>
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
												<fo:block> </fo:block>												
											</fo:table-cell>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
									    <xsl:if test="intermediary_bank_clearing_code[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_CLEARING_CODE_DESCRIPTION')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="intermediary_bank_clearing_code"/>
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
						       <fo:table-column column-width="50%"/>
								<fo:table-column column-width="50%"/>
									<fo:table-body>
									<fo:table-row>
											<fo:table-cell>
												<fo:block> </fo:block>												
											</fo:table-cell>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
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
										<fo:table-row>
											<fo:table-cell>
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
			
		<!--Recurring Payment Details -->
			<xsl:if test="recurring_payment_enabled[.='Y']">			
			<fo:block id="recurringPaymentDetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
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
			
			<xsl:if test="sub_product_code[.='FI103'] and (sub_product_code[.!='BILLP'] or sub_product_code[.!='DDA'] or sub_product_code[.!='BILLS'])">
			  <fo:block id="orderingCustomerDetails"/>
			   <xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ORDERING_CUSTOMER_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			  </xsl:call-template>
			</xsl:if>
			<fo:block xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider" font-size="8pt" white-space-collapse="false">
				<fo:table>
					<fo:table-column column-width="50%"/>
					<fo:table-column column-width="50%"/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
								<fo:table>
								<fo:table-column column-width="30%"/>
								<fo:table-column column-width="70%"/>
									<fo:table-body start-indent="2pt">
										<fo:table-row>
											<fo:table-cell>
												<fo:block> </fo:block>												
											</fo:table-cell>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
										<xsl:if test="ordering_customer_name[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
									                <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
									                <xsl:value-of select="ordering_customer_name"/>
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										</xsl:if>
										<xsl:if test="ordering_customer_address_line_1[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="ordering_customer_address_line_1"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="ordering_customer_address_line_2[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="ordering_customer_address_line_2"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="ordering_customer_dom[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="ordering_customer_dom"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="ordering_customer_account[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_ACCOUNT_NUMBER')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="ordering_customer_account"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
									</fo:table-body>
								</fo:table>
							</fo:table-cell>
							
						    <fo:table-cell>
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
									 <xsl:if test="ordering_customer_bank_swift_bic_code[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>												
										            <xsl:value-of select="localization:getGTPString($language, 'XSL_ORIGINATING_INSTITUTION_SWIFT_BIC_CODE')"/> 
										        </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="ordering_customer_bank_swift_bic_code"/>									   	            
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="ordering_customer_bank_name[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="ordering_customer_bank_name"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="ordering_customer_bank_address_line_1[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="ordering_customer_bank_address_line_1"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="ordering_customer_bank_address_line_2[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>											
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="ordering_customer_bank_address_line_2"/>													
											   </fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="ordering_customer_bank_dom[.!='']">
										<fo:table-row>
										<fo:table-cell>
												<fo:block>											
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="ordering_customer_bank_dom"/>													
											   </fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="ordering_customer_bank_country[.!='']">
										<fo:table-row>
										<fo:table-cell>
												<fo:block>	
													<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>										
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="ordering_customer_bank_country"/>													
											   </fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="ordering_customer_bank_account[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_ACCOUNT_NUMBER')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="ordering_customer_bank_account"/>
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
			
			<fo:block id="benedetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:choose> 
								<xsl:when test="sub_product_code[.='FI202']"> <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_INSTITUTION_DETAILS')"/>
								</xsl:when>
								<xsl:otherwise> <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')"/>
								</xsl:otherwise>
							</xsl:choose>
						
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<fo:block xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider" font-size="8pt" white-space-collapse="false">
				<fo:table>
					<fo:table-column column-width="50%"/>
					<fo:table-column column-width="50%"/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
								<fo:table>
								<xsl:choose> 
									<xsl:when test="sub_product_code[.='FI202']"> 
										<fo:table-column column-width="30%"/>
										<fo:table-column column-width="70%"/>
									</xsl:when>
									<xsl:otherwise> 
										<fo:table-column column-width="20%"/>
										<fo:table-column column-width="80%"/>
									</xsl:otherwise>
								</xsl:choose>
								
									<fo:table-body start-indent="2pt">
										<fo:table-row>
											<fo:table-cell>
												<fo:block> </fo:block>												
											</fo:table-cell>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
										<xsl:if test="counterparties/counterparty/counterparty_name[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<xsl:choose> 
													<xsl:when test="sub_product_code[.='FI202']"> 
														<fo:block>
									               			<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_INSTITUTION_NAME')"/>
								   	          			</fo:block>	
													</xsl:when>
													<xsl:otherwise> 
														<fo:block>
									               			<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARYDETAILS_NAME_REMITTANCE')"/>
								   	           			 </fo:block>	
													</xsl:otherwise>
												</xsl:choose>												
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
									                <xsl:value-of select="counterparties/counterparty/counterparty_name"/>
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										</xsl:if>
										<xsl:if test="counterparties/counterparty/counterparty_address_line_1[.!='']">
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
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="counterparties/counterparty/counterparty_address_line_2[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="counterparties/counterparty/counterparty_address_line_2"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="counterparties/counterparty/counterparty_dom[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="counterparties/counterparty/counterparty_dom"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="counterparties/counterparty/counterparty_act_no[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<xsl:choose> 
													<xsl:when test="sub_product_code[.='FI202']"> 
														<fo:block>
									               			<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_INSTITUTION_ACCOUNT')"/>
								   	          			</fo:block>	
													</xsl:when>
													<xsl:otherwise> 
														<fo:block>
									               			<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_ACCOUNT_REMITTANCE')"/>
								   	           			 </fo:block>	
													</xsl:otherwise>
												</xsl:choose>												
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="counterparties/counterparty/counterparty_act_no"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
									</fo:table-body>
								</fo:table>
							</fo:table-cell>
							
						    <fo:table-cell>
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
									 <xsl:if test="counterparties/counterparty/cpty_bank_swift_bic_code[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<xsl:choose> 
													<xsl:when test="sub_product_code[.='FI202']"> 
														<fo:block>
									               			<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_INSTITUTION_SWIFT_CODE')"/> 
								   	          			</fo:block>	
													</xsl:when>
													<xsl:otherwise> 
														<fo:block>
									               			<xsl:value-of select="localization:getGTPString($language, 'XSL_SWIFT_BIC_CODE')"/> 
								   	           			 </fo:block>	
													</xsl:otherwise>
												</xsl:choose>												
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="counterparties/counterparty/cpty_bank_swift_bic_code"/>									   	            
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="counterparties/counterparty/cpty_bank_name[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<xsl:choose> 
													<xsl:when test="sub_product_code[.='FI202']"> 
														<fo:block>
									               			<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_INSTITUTION_BANK_ADDRESS_NAME')"/>
								   	          			</fo:block>	
													</xsl:when>
													<xsl:otherwise> 
														<fo:block>
									               			<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_BANK_NAME_WITH_ADDRESS')"/> 
								   	           			 </fo:block>	
													</xsl:otherwise>
												</xsl:choose>										
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="counterparties/counterparty/cpty_bank_name"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="counterparties/counterparty/cpty_bank_address_line_1[.!='']">
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
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="counterparties/counterparty/cpty_bank_address_line_2[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>											
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_2"/>													
											   </fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="counterparties/counterparty/cpty_bank_dom[.!='']">
										<fo:table-row>
										<fo:table-cell>
												<fo:block>											
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="counterparties/counterparty/cpty_bank_dom"/>													
											   </fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="counterparties/counterparty/cpty_bank_country[.!='']">
										<fo:table-row>
										<fo:table-cell>
												<fo:block>	
													<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>										
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="counterparties/counterparty/cpty_bank_country"/>													
											   </fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="beneficiary_bank_clearing_code[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_CLEARING_CODE_DESCRIPTION')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="beneficiary_bank_clearing_code"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>										
										<xsl:if test="beneficiary_bank_branch_address_line_1[.!='']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_BRANCH_ADDRESS')"/>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="beneficiary_bank_branch_address_line_1"/>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<xsl:if test="beneficiary_bank_branch_address_line_2[.!='']">										
											<fo:table-row>
											<fo:table-cell>
													<fo:block>											
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="beneficiary_bank_branch_address_line_2"/>													
												   </fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<xsl:if test="beneficiary_bank_branch_dom[.!='']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>											
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="beneficiary_bank_branch_dom"/>													
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
			<!-- Intermediary bank details -->
			 <xsl:variable name="mt103InterbankDetailsflag" select="defaultresource:getResource('MT103_INTER_BANK_DETAILS_DISPLAY')"/>
		     <xsl:variable name="mt101InterbankDetailsflag" select="defaultresource:getResource('MT101_INTER_BANK_DETAILS_DISPLAY')"/>
		     <xsl:variable name="fi103InterbankDetailsflag" select="defaultresource:getResource('FI103_INTER_BANK_DETAILS_DISPLAY')"/>
		     <xsl:variable name="fi202InterbankDetailsflag" select="defaultresource:getResource('FI202_INTER_BANK_DETAILS_DISPLAY')"/>
		     
		     <xsl:if test="(sub_product_code[.='MT103'] and $mt103InterbankDetailsflag = 'true') or (sub_product_code[.='MT101'] and $mt101InterbankDetailsflag = 'true')              or (sub_product_code[.='FI103'] and $fi103InterbankDetailsflag = 'true') or (sub_product_code[.='FI202'] and $fi202InterbankDetailsflag = 'true')">
				<xsl:call-template name="intermediarybanksdetails"/>
			</xsl:if>
			<xsl:if test="sub_product_code[.!='MT103'] and sub_product_code[.!='MT101'] and sub_product_code[.!='FI103'] and sub_product_code[.!='FI202']">
				<xsl:call-template name="intermediarybankdetails"/>
			</xsl:if>
		
			<xsl:if test="remittance_description[.!='']">			
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
									    <xsl:if test="ft_amt[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
									                <xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_REMITTANCE_AMT_LABEL')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
									                 <xsl:value-of select="ft_cur_code"/> <xsl:value-of select="ft_amt"/>
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										</xsl:if>
										<xsl:if test="charge_option[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
												   <xsl:choose>
													 <xsl:when test="charge_option[. = 'SHA']">
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_SHA')"/>
                              </xsl:when>
										    		 <xsl:when test="charge_option[. = 'OUR']">
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_OUR')"/>
                              </xsl:when>								     
										    		 <xsl:when test="charge_option[. = 'BEN']">
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_BEN')"/>
                              </xsl:when>
										    		</xsl:choose>
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										</xsl:if>
										<xsl:if test="debit_account_for_charges[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_DEBIT_ACCOUNT_FOR_CHARGES')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
												  <xsl:value-of select="debit_account_for_charges"/>
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										</xsl:if>
										<xsl:if test="cust_ref_id[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTION_REFERENCE')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="cust_ref_id"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="payment_details_to_beneficiary[.!='']">	
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTS_DETAILS_TO_BENEFICIARY')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="payment_details_to_beneficiary"/> 
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
									<fo:table-body>
										<fo:table-row>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
									    <xsl:if test="iss_date[.!=''] and recurring_payment_enabled[.='N']">		
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
										            <xsl:value-of select="localization:getGTPString($language, 'XSL_PROCESSING_DATE')"/> 
										        </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="iss_date"/>
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="request_date[.!='']">		
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_REQUEST_DATE')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="request_date"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									 </xsl:if>
									 <xsl:if test="sender_to_receiver_info[.!='']">	
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SENDER_TO_RECEIVER_INFORMATION')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="sender_to_receiver_info"/> 
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
			<xsl:if test="instruction_to_bank[.!='']">			
			<fo:block id="instructionToBankDetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_INSTRUCTION_TO_BANK_DETAILS')"/>
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
									                 <xsl:value-of select="instruction_to_bank"/>
								                </fo:block>
											</fo:table-cell>
										</fo:table-row>	
										
									</fo:table-body>
								</fo:table>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			</xsl:if>
			<!-- FX Details -->
			<xsl:call-template name="fx-common-details"/>
			
			<!-- beneficiary Advice details -->		
			<xsl:call-template name="beneficiary-advice"/>
			
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
