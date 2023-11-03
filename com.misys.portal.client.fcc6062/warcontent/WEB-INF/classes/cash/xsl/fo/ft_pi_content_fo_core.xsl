<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright (c) 2006-2012 Misys , All Rights Reserved -->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:localization="xalan://com.misys.portal.common.localization.Localization" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>

	<xsl:template match="ft_tnx_record[ft_type/text()='10']">
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
			<!-- General Details END-->
			
			<!--Recurring Payment Details START-->
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
			<!--Recurring Payment Details END-->
			
			<!--Benificiary Details START-->
			<fo:block id="benedetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<fo:block xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider" white-space-collapse="false">
				<fo:table>
					<fo:table-column column-width="100%"/>
					
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
										<xsl:if test="counterparties/counterparty/counterparty_name[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
									                <xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARYDETAILS_NAME_PI')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
									                <xsl:value-of select="counterparties/counterparty/counterparty_name"/>
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										</xsl:if>
										<xsl:if test="beneficiary_name_2[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>									                
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
									                <xsl:value-of select="beneficiary_name_2"/>
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										</xsl:if>
										<xsl:if test="beneficiary_name_3[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>									                
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
									                <xsl:value-of select="beneficiary_name_3"/>
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
										<xsl:if test="beneficiary_address_line_4[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="beneficiary_address_line_4"/> 
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
										<xsl:if test="beneficiary_postal_code[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_POSTAL_CODE')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="beneficiary_postal_code"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="counterparties/counterparty/counterparty_country">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_COUNTRY')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="counterparties/counterparty/counterparty_country"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="counterparties/counterparty/counterparty_act_no[.!='']">
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
								</fo:table-body>
								</fo:table>
							</fo:table-cell>						
						    
						    
						       
						</fo:table-row>								
					</fo:table-body>
				</fo:table>
			</fo:block>
			<!--Benificiary Details END -->
			
			<!--Transaction Details START-->
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
										<xsl:if test="drawn_on_country[.!=''] and bulk_ref_id[.='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
									                <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_DRAWN_ON_COUNTRY')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
									                 <xsl:value-of select="drawn_on_country"/>
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										</xsl:if>								
										<xsl:if test="cust_ref_id[.!='']">
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
<!--										<xsl:if test="adv_send_mode[.!='']">	-->
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_PAYMENT_DETAILS')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="narrative_additional_instructions/text"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
<!--										</xsl:if>		-->
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
										<xsl:if test="mailing_other_name_address[.!='']">	
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_MAILING_NAME_ADDRESS_OTHER')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="mailing_other_name_address"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>		
										<xsl:if test="mailing_other_postal_code[.!='']">	
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_COLLECTORS_NAME')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="mailing_other_postal_code"/> 
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>	
										<xsl:if test="mailing_other_country[.!='']">	
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="mailing_other_country"/> 
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
									<fo:table-body>
										<fo:table-row>
											<fo:table-cell>
												<fo:block> </fo:block>												
											</fo:table-cell>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
									    <xsl:if test="iss_date[.!='']">		
										<fo:table-row>
											<fo:table-cell>
												<fo:block>												
										            <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_VALUE_DATE')"/> 
										        </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="iss_date"/>									   	            
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
			<!--Transaction Details END -->
			
			<!-- FX Details for PaperInstruments -->
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
