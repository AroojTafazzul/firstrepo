<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright (c) 2006-2012 Misys , All Rights Reserved -->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:localization="xalan://com.misys.portal.common.localization.Localization" xmlns:security="xalan://com.misys.portal.security.GTPSecurity" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="settlement_common.xsl"/>
	
	 <xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>

	<xsl:template match="td_tnx_record">
		<!-- HEADER-->
		
		<!-- BODY-->
		
	<xsl:call-template name="header"/>
    <xsl:call-template name="body"/>
  </xsl:template>
	
<xsl:template name="header">
    <fo:static-content flow-name="xsl-region-before">
			<xsl:call-template name="header_issuing_bank"/>
		</fo:static-content>
  </xsl:template>
  <xsl:template name="body">
    <fo:flow flow-name="xsl-region-body" font-size="{$pdfFontSize}">
			<!-- Part 1.0 -->
			<xsl:call-template name="disclammer_template"/>
			
			<!-- Rollover Request  Details-->
			<xsl:if test="tnx_stat_code [.='03'] and sub_tnx_type_code[.='28']">
			<fo:block id="rolloverDetails"/>			
			<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ACTION_ROLLOVER_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
					<xsl:if test="value_date[.!=''] and sub_product_code[.='TRTD']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TD_START_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="value_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="maturity_date[.!=''] and sub_product_code[.='TRTD']">
						<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_TRTD_MATURITY_DATE_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="maturity_date"/>
								</xsl:with-param>
							</xsl:call-template>
					</xsl:if>
					<xsl:if test="td_amt[.!=''] and sub_product_code[.='TRTD']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_ORG_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="td_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="interest_capitalisation[.!=''] and sub_product_code[.='TRTD']">
						<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_TD_INTEREST_CAPITALISATION_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="interest_capitalisation"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="remarks[.!=''] and sub_product_code[.='TRTD']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_TD_REMARKS')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="remarks"/>
								</xsl:with-param>
							</xsl:call-template>		
						</xsl:if>	
				</xsl:with-param>	
			</xsl:call-template>

          		
			<xsl:call-template name="table_template">
					<xsl:with-param name="text">
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONTRACT_DETAILS')"/>
									</xsl:with-param>
							</xsl:call-template>
					<xsl:if test="trade_id[.!=''] and sub_product_code[.='TRTD']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TD_TRADE_ID_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="trade_id"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				<xsl:if test="maturity_date[.!=''] and sub_product_code[.='TRTD']">
					<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TRTD_MATURITY_DATE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="maturity_date"/>
							</xsl:with-param>
						</xsl:call-template>
				</xsl:if>
				<xsl:if test="rate[.!=''] and sub_product_code[.='TRTD']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TD_RATE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="rate"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				<xsl:if test="interest[.!=''] and sub_product_code[.='TRTD']">
					<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TD_INTEREST_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="interest"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
				</xsl:with-param>	
			</xsl:call-template>
		</xsl:if>

			<!-- Part 2.0: General Details -->
			<fo:block id="generalDetails"/>
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="title">
								<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/>
								</xsl:with-param>
						</xsl:call-template>
					
					<!-- Display Entity -->
					<xsl:if test="entity[.!=''] and sub_product_code[.!='TRTD']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ENTITY')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="entity"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
				<!-- Transfer from Account -->
						<xsl:if test="entity[.!=''] and sub_product_code[.!='TRTD' and .!='CSTD']] and product_code[.!='TD']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TD_DEBIT_ACCOUNT')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="applicant_act_name"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text"></xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="applicant_act_nickname"/>
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
					
					<xsl:if test="sub_product_code[.='TRTD']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="bo_ref_id"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="cust_ref_id[.!=''] and sub_product_code[.='TRTD']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="cust_ref_id"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="product_code[.!='']and sub_product_code[.='TRTD']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_CODE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getGTPString($language,concat('TOPMENU_', sub_product_code))"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="appl_date[. != ''] and product_code[.!='TD']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="appl_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
						
						<!-- Term Deposit Account -->
						<xsl:if test="placement_act_name[.!=''] and product_code[.='TD'] and sub_product_code[.='CSTD']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_TD_TERM_DEPOSIT_ACCOUNT')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="placement_act_name"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text"></xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="applicant_act_nickname"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<!-- Transfer From in TD -->
						<xsl:if test="(tnx_type_code[.='01'] or tnx_type_code[.='03']  or tnx_type_code[.='13'] or not(tnx_type_code)) and product_code[.='TD'] and applicant_act_name[.!='']">
							<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_TD_DEBIT_ACCOUNT')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="applicant_act_name"/>
									</xsl:with-param>
							</xsl:call-template>
				     </xsl:if>
				     <!-- 	 Application Date -->
					 <xsl:if test="tnx_val_date[.!= ''] or (appl_date[.!=''] and product_code[.='TD'])">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
									<xsl:choose>
									<xsl:when test="tnx_val_date[.!= '']">
										<xsl:value-of select="tnx_val_date"/>
									</xsl:when>
									<xsl:when test="appl_date[.!=''] and product_code[.='TD']">
										<xsl:value-of select="appl_date"/>
									</xsl:when>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>	
			</xsl:call-template>
			
					
			<fo:block id="recurringPaymentDetails"/>
			<xsl:if test="sub_product_code[.='TRTD']  and (entity[.!=''] or applicant_name[.!=''] or applicant_address_line_1[.!=''] or applicant_address_line_2[.!=''] or applicant_dom[.!=''])">
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
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			
						<!--Bank Details-->
			<xsl:if test="sub_product_code[.='TRTD']">
			<fo:block id="bankdetails"/>
				<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BANK_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ISSUING_BANK')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="issuing_bank[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ISSUER_NAME_BANK')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="issuing_bank/name"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="applicant_reference[.!=''] and avail_main_banks/bank/customer_reference[.!='']">
						<xsl:variable name="appl_ref">
							<xsl:value-of select="applicant_reference"/>
						</xsl:variable>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CUST_REFERENCE')"/>
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
			
			<!-- Settlement Details -->
			<xsl:if test="counterparties/counterparty/counterparty_cur_code[.!=''] and (counterparties/counterparty/counterparty_act_no[.!='']or counterparties/counterparty/counterparty_name[.!=''])">
			<xsl:call-template name="settlement-details"/>
			</xsl:if>
			
			<!--Contract Detail -->
			<xsl:if test="not(tnx_id) or tnx_type_code[.!='13']"> 
			<fo:block id="contractDetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONTRACT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="trade_id[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_TRADE_ID_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="trade_id"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="td_amt[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TD_AMOUNT_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="td_cur_code"/> <xsl:value-of select="td_amt"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="value_date[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TD_START_DATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="value_date"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="maturity_date[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TD_MATURITY_DATE_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="maturity_date"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="rate[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TD_INTEREST_RATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="rate"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="interest[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_INTEREST_AMOUNT')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="interest"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="total_with_interest[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TD_TOTAL_WITH_INTEREST_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="total_with_interest"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="trader_remarks[.!='']">
						<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TD_REMARKS')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="trader_remarks"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>	
					
					<xsl:if test="remarks[.!=''] and sub_product_code[.='TRTD']">
						<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TD_REMARKS')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="remarks"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>	
					
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
		</xsl:if>
			
						
			<xsl:if test="sub_product_code[.!='TRTD']">	
			<!-- Transaction Details -->
			<fo:block id="transactionDetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
				<fo:block>
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
									        <!-- Fixed Deposit Type -->
									        <xsl:if test="tnx_type_code[.='01'] or (security:isBank($rundata) and not(tnx_type_code))">
										        <xsl:if test="td_type[. != '']">
											    <fo:table-row>
										           <fo:table-cell>
										            <fo:block>
                                <xsl:value-of select="localization:getGTPString($language, 'XSL_TD_DEPOSIT_TYPE')"/>
                              </fo:block>            
										           </fo:table-cell>
										           <fo:table-cell>
										            <fo:block>
                                <xsl:value-of select="localization:getDecode($language, 'N414', td_type)"/>
                              </fo:block>
										           </fo:table-cell>
										        </fo:table-row>
										        </xsl:if>
									        </xsl:if>
									        <!-- Placement Account -->
												<xsl:if test="placement_act_name[.!=''] and sub_product_code[.!='CSTD']">
												<fo:table-row>
										           <fo:table-cell>
										            <fo:block>
                              <xsl:value-of select="localization:getGTPString($language, 'XSL_FD_ACCOUNTT_NUMBER')"/>
                            </fo:block>            
										           </fo:table-cell>
										           <fo:table-cell>
										            <fo:block>
                              <xsl:value-of select="placement_act_name"/>
                            </fo:block>
										           </fo:table-cell>
										        </fo:table-row>
												</xsl:if>
									        <!-- Maturity Instructions -->
									       <xsl:if test="((tnx_type_code[.='01'] or (security:isBank($rundata) and not(tnx_type_code))) or tnx_type_code[.='03']) and maturity_instruction[.!='']">
										   		<fo:table-row>
										           <fo:table-cell>
										            <fo:block>
											            <xsl:choose>
														<xsl:when test="tnx_type_code[.='01'] or (security:isBank($rundata) and not(tnx_type_code))">
                                  <xsl:value-of select="localization:getGTPString($language, 'XSL_TD_MATURITY_INSTRUCTIONS')"/>
                                </xsl:when>
														<xsl:when test="tnx_type_code[.='03']">
                                  <xsl:value-of select="localization:getGTPString($language, 'XSL_TD_MODIFY_MATURITY_INSTRUCTIONS')"/>
                                </xsl:when>
													   </xsl:choose>
												   </fo:block>            
										           </fo:table-cell>
										           <fo:table-cell>
										            <fo:block>
                              <xsl:value-of select="maturity_instruction_name"/>
                            </fo:block>
										           </fo:table-cell>
										        </fo:table-row>
										   </xsl:if>
									       <!-- Value Date -->
									        <xsl:if test="value_date[. != ''] and sub_product_code[.= 'CSTD'] and tnx_type_code[.='01']">
												<fo:table-row>
										           <fo:table-cell>
										            <fo:block>
                              <xsl:value-of select="localization:getGTPString($language, 'XSL_TD_VALUE_DATE')"/>
                            </fo:block>            
										           </fo:table-cell>
										           <fo:table-cell>
										            <fo:block>
                              <xsl:value-of select="value_date"/>
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
										<fo:table-body start-indent="2pt">
											<fo:table-row>
									           <fo:table-cell>
									            <fo:block> </fo:block>            
									           </fo:table-cell>
									           <fo:table-cell>
									            <fo:block> </fo:block>
									           </fo:table-cell>
									        </fo:table-row>
									        <!-- Tenor -->
									         <xsl:if test="value_date_term_code[. != '']">
												<fo:table-row>
										           <fo:table-cell>
										            <fo:block>
                              <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR')"/>
                            </fo:block>            
										           </fo:table-cell>
										           <fo:table-cell>
										            <fo:block>
                              <xsl:value-of select="value_date_term_number"/> <xsl:value-of select="localization:getDecode($language, 'N413', value_date_term_code)"/>
                            </fo:block>
										           </fo:table-cell>
										        </fo:table-row>
										    </xsl:if>
									        <!-- Placement Amount -->
									        <xsl:if test="(tnx_type_code[.='01' or .='03' or .='13'] or (security:isBank($rundata) and not(tnx_type_code))) and td_amt[.!='']">										        
												<fo:table-row>
										           <fo:table-cell>
										            <fo:block>
                              <xsl:value-of select="localization:getGTPString($language, 'XSL_TD_PLACEMENT_AMOUNT')"/>
                            </fo:block>            
										           </fo:table-cell>
										           <fo:table-cell>
										            <fo:block>
                              <xsl:value-of select="td_cur_code"/> <xsl:value-of select="td_amt"/>
                            </fo:block>
										           </fo:table-cell>
										        </fo:table-row>											    
										    </xsl:if>
									        <!-- Credit Account -->
									   		<xsl:if test="credit_act_name[.!='']">
										   		<fo:table-row>
										           <fo:table-cell>
										            <fo:block>
										            <xsl:choose>
														<xsl:when test="tnx_type_code[.='01' or .='03'] or (security:isBank($rundata) and not(tnx_type_code))">
                                  <xsl:value-of select="localization:getGTPString($language, 'XSL_TD_CREDIT_ACCOUNT')"/>
                                </xsl:when>
														<xsl:when test="tnx_type_code[.='13']">
                                  <xsl:value-of select="localization:getGTPString($language, 'XSL_NET_SETTLEMENT_AMT_CREDIT_TO')"/>
                                </xsl:when>
													</xsl:choose>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_TD_CREDIT_ACCOUNT')"/>
													</fo:block>                        
										           </fo:table-cell>
										           <fo:table-cell>
										            <fo:block>
                              <xsl:value-of select="credit_act_name"/>
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
									     
			<!--forex Details -->
			<fo:block id="fxDetails"/>					
			<xsl:call-template name="fx-common-details"/>
			
			<xsl:if test="sub_prodct_code[.!='TRTD']">
			<!-- Interest Details -->
			<fo:block id="interestDetails"/>
			<xsl:if test="interest[.!='']">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TD_INTEREST_RATE_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:with-param>
			 </xsl:call-template>
			 </xsl:if>
				<fo:block>
					<fo:table>
						<fo:table-column column-width="70%"/>
						<fo:table-column column-width="30%"/>
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
									        <!-- Interest Rate PA -->
											<xsl:if test="interest[.!='']">
									        <fo:table-row>
									           <fo:table-cell>
									            <fo:block>
                              <xsl:value-of select="localization:getGTPString($language, 'XSL_TD_INTEREST_RATE_PA')"/>
                            </fo:block>            
									           </fo:table-cell>
									           <fo:table-cell>
									            <fo:block>
                              <xsl:value-of select="interest * 100"/> %</fo:block>
									           </fo:table-cell>
									        </fo:table-row>
									        </xsl:if>
									        <xsl:if test="fx_total_utilise_amt[.!='']">
									        <fo:table-row>
									           <fo:table-cell>
									            <fo:block>
                              <xsl:value-of select="localization:getGTPString($language, 'XSL_TD_EQUIVALENT_CONTRACT_AMOUNT')"/>
                            </fo:block>            
									           </fo:table-cell>
									           <fo:table-cell>
									            <fo:block>
                              <xsl:value-of select="applicant_act_cur_code"/> <xsl:value-of select="fx_total_utilise_amt"/>
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
			<!-- Part 4: Transaction Remarks -->
			<fo:block id="transactionremarks"/>
			<xsl:if test="remarks[.!=''] and sub_product_code[.!='TRTD']">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
								<xsl:choose>
								    <xsl:when test="(tnx_type_code[.='01'] or (security:isBank($rundata) and not(tnx_type_code))) or tnx_type_code[.='03']">
									   <xsl:value-of select="localization:getGTPString($language, 'XSL_TD_TRANSACTION_REMARKS')"/>
									</xsl:when>
									<xsl:otherwise>
									   <xsl:value-of select="localization:getGTPString($language, 'XSL_SETTLEMENT_INSTRUCTIONS')"/>
									</xsl:otherwise>
								</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			 </xsl:call-template>
			 </xsl:if>
			 
			 <xsl:if test="sub_product_code[.!='TRTD']">
				<fo:block>
					<fo:table>
						<fo:table-column column-width="100%"/>
							<fo:table-body>
								<fo:table-row>
		         					 <fo:table-cell padding-left="10pt">
										<xsl:choose>
										<xsl:when test="((tnx_type_code[.='01'] or (security:isBank($rundata) and not(tnx_type_code))) or tnx_type_code[.='03']) and remarks[.!= '']">
									       <fo:block>
											<xsl:value-of select="remarks"/>
									       </fo:block>
										</xsl:when>
										<xsl:otherwise>
                      <fo:block> </fo:block>
                    </xsl:otherwise>
										</xsl:choose>
									</fo:table-cell>
								</fo:table-row>
								<fo:table-row>
									<fo:table-cell>
									<fo:block>
                    <xsl:value-of select="localization:getGTPString($language, 'XSL_TD_NOTE')"/> <xsl:value-of select="localization:getGTPString($language, 'XSL_TD_LABEL')"/>
                  </fo:block>
									</fo:table-cell>
								</fo:table-row>
						</fo:table-body>
				 	</fo:table>
				</fo:block>
		</xsl:if>	
			
	<!-- 
		<xsl:template name="maturityandcreditdetails">
			 <xsl:if test="((tnx_type_code[.='01'] or (security:isBank($rundata) and not(tnx_type_code))) or tnx_type_code[.='03']) and maturity_instruction[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:choose>
						<xsl:when test="tnx_type_code[.='01'] or (security:isBank($rundata) and not(tnx_type_code))"><xsl:value-of	
							select="localization:getGTPString($language, 'XSL_TD_MATURITY_INSTRUCTIONS')"/></xsl:when>
						<xsl:when test="tnx_type_code[.='03']"><xsl:value-of	
							select="localization:getGTPString($language, 'XSL_TD_MODIFY_MATURITY_INSTRUCTIONS')"/></xsl:when>
					   </xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="right_text">
						<xsl:value-of select="maturity_instruction_name"/>
						</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</xsl:template>	  -->   
		
<!--		<xsl:template name="commondetails">-->
<!--				<xsl:if test="tnx_type_code[.='01'] or (security:isBank($rundata) and not(tnx_type_code))">-->
<!--					 Deposit Type -->
<!--				   <xsl:if test="td_type[. != '']">-->
<!--						<xsl:call-template name="table_cell">-->
<!--							<xsl:with-param name="left_text">-->
<!--								<xsl:value-of-->
<!--									select="localization:getGTPString($language, 'XSL_TD_DEPOSIT_TYPE')" />-->
<!--								</xsl:with-param>-->
<!--								<xsl:with-param name="right_text">-->
<!--								<xsl:value-of select="localization:getDecode($language, 'N414', td_type)"/>-->
<!--								<xsl:choose>-->
<!--							   	  <xsl:when test="td_type[.='01']">-->
<!--							       Fixed Deposit-->
<!--							      </xsl:when>-->
<!--							      <xsl:when test="td_type[.='02']">-->
<!--							       7 Days Flexi-->
<!--							      </xsl:when>-->
<!--							    </xsl:choose>-->
<!--							</xsl:with-param>-->
<!--						</xsl:call-template>-->
<!--					</xsl:if>-->
<!--					</xsl:if>-->
<!--					<xsl:if test="tnx_type_code[.='03'] or tnx_type_code[.='13']">-->
<!--					<xsl:if test="placement_act_name[.!='']">-->
<!--						<xsl:call-template name="table_cell">-->
<!--							<xsl:with-param name="left_text">-->
<!--								<xsl:value-of-->
<!--									select="localization:getGTPString($language, 'XSL_FIXED_DEPOSIT_DETAILS')" />-->
<!--							</xsl:with-param>-->
<!--							<xsl:with-param name="right_text">-->
<!--								<xsl:value-of select="placement_act_name" />-->
<!--							</xsl:with-param>-->
<!--						</xsl:call-template>-->
<!--					</xsl:if>-->
<!--					</xsl:if>-->
<!--					 Tenor -->
<!--				    <xsl:if test="value_date_term_code[. != '']">-->
<!--						<xsl:call-template name="table_cell">-->
<!--							<xsl:with-param name="left_text">-->
<!--								<xsl:value-of-->
<!--									select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR')" />-->
<!--								</xsl:with-param>-->
<!--								<xsl:with-param name="right_text">-->
<!--								<xsl:value-of select="value_date_term_number"/>&nbsp;<xsl:value-of select="localization:getDecode($language, 'N413', value_date_term_code)"/>-->
<!--								<xsl:choose>-->
<!--							   	  <xsl:when test="value_date_term_code[.='01']">-->
<!--							       1 Month-->
<!--							      </xsl:when>-->
<!--							      <xsl:when test="value_date_term_code[.='02']">-->
<!--							       2 Month-->
<!--							      </xsl:when>-->
<!--							    </xsl:choose>-->
<!--							</xsl:with-param>-->
<!--						</xsl:call-template>-->
<!--					</xsl:if>-->
<!--					 Placement Account -->
<!--					<xsl:if test="(tnx_type_code[.='01'] or (security:isBank($rundata) and not(tnx_type_code))) and placement_act_name[.!='']">-->
<!--						<xsl:call-template name="table_cell">-->
<!--							<xsl:with-param name="left_text">-->
<!--								<xsl:value-of-->
<!--									select="localization:getGTPString($language, 'XSL_FIXED_DEPOSIT_DETAILS')" />-->
<!--							</xsl:with-param>-->
<!--							<xsl:with-param name="right_text">-->
<!--								<xsl:value-of select="placement_act_name" />-->
<!--							</xsl:with-param>-->
<!--						</xsl:call-template>-->
<!--					</xsl:if>-->
<!--					 Placement Amount -->
<!--					<xsl:if test="(tnx_type_code[.='01'] or (security:isBank($rundata) and not(tnx_type_code))) and td_amt[.!='']">-->
<!--					<xsl:call-template name="table_cell">-->
<!--						<xsl:with-param name="left_text">-->
<!--							<xsl:value-of-->
<!--								select="localization:getGTPString($language, 'XSL_TD_PLACEMENT_AMOUNT')" />-->
<!--						</xsl:with-param>-->
<!--						<xsl:with-param name="right_text">-->
<!--							<xsl:value-of select="td_cur_code" />&nbsp;<xsl:value-of select="td_amt" />-->
<!--						</xsl:with-param>-->
<!--					</xsl:call-template>-->
<!--					</xsl:if>-->
<!--					 Interest Rate PA -->
<!--					<xsl:if test="interest[.!='']">-->
<!--						<xsl:call-template name="table_cell">-->
<!--							<xsl:with-param name="left_text">-->
<!--								<xsl:value-of-->
<!--									select="localization:getGTPString($language, 'XSL_TD_INTEREST_RATE_PA')" />-->
<!--							</xsl:with-param>-->
<!--							<xsl:with-param name="right_text">-->
<!--								<xsl:value-of select="interest" />&nbsp;%-->
<!--							</xsl:with-param>-->
<!--						</xsl:call-template>-->
<!--					</xsl:if>-->
<!--					 Debit Account -->
<!--					<xsl:if test="(tnx_type_code[.='01'] or (security:isBank($rundata) and not(tnx_type_code))) and applicant_act_name[.!='']">-->
<!--						<xsl:call-template name="table_cell">-->
<!--							<xsl:with-param name="left_text">-->
<!--								<xsl:value-of-->
<!--									select="localization:getGTPString($language, 'XSL_TD_DEBIT_ACCOUNT')" />-->
<!--							</xsl:with-param>-->
<!--							<xsl:with-param name="right_text">-->
<!--								<xsl:value-of select="applicant_act_name" />-->
<!--							</xsl:with-param>-->
<!--						</xsl:call-template>-->
<!--					</xsl:if>-->
<!--					 Maturity Date -->
<!--					<xsl:if test="(tnx_type_code[.='03'] or tnx_type_code[.='13']) and maturity_date[.!='']">-->
<!--						<xsl:call-template name="table_cell">-->
<!--							<xsl:with-param name="left_text">-->
<!--								<xsl:value-of-->
<!--									select="localization:getGTPString($language, 'XSL_GENERALDETAILS_MATURITY_DATE')" />-->
<!--							</xsl:with-param>-->
<!--							<xsl:with-param name="right_text">-->
<!--								<xsl:value-of select="maturity_date" />-->
<!--							</xsl:with-param>-->
<!--						</xsl:call-template>-->
<!--					</xsl:if>-->
<!--					 Outstanding Amount -->
<!--					<xsl:if test="(tnx_type_code[.='03'] or tnx_type_code[.='13']) and td_liab_amt[.!=''] and td_cur_code[. != '']">-->
<!--						<xsl:call-template name="table_cell">-->
<!--							<xsl:with-param name="left_text">-->
<!--										<xsl:value-of-->
<!--											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_AMT_LABEL')" />-->
<!--							</xsl:with-param>-->
<!--							<xsl:with-param name="right_text">-->
<!--								<xsl:value-of select="concat(td_cur_code, ' ', td_liab_amt)" />-->
<!--							</xsl:with-param>-->
<!--						</xsl:call-template>-->
<!--					</xsl:if>-->
<!--					<xsl:if test="tnx_type_code[.='13']">	-->
<!--					 Accured Interest -->
<!--					<xsl:if test="accured_interest[.!='']">-->
<!--						<xsl:call-template name="table_cell">-->
<!--							<xsl:with-param name="left_text">-->
<!--										<xsl:value-of-->
<!--											select="localization:getGTPString($language, 'XSL_ACCURED_INTEREST')" />-->
<!--							</xsl:with-param>-->
<!--							<xsl:with-param name="right_text">-->
<!--								<xsl:value-of select="accured_interest" />-->
<!--							</xsl:with-param>-->
<!--						</xsl:call-template>-->
<!--					</xsl:if>-->
<!--					 Premature Withdrawl -->
<!--					<xsl:if test="premature_withdrawal_penalty[.!='']">-->
<!--						<xsl:call-template name="table_cell">-->
<!--							<xsl:with-param name="left_text">-->
<!--										<xsl:value-of-->
<!--											select="localization:getGTPString($language, 'XSL_PREMATURE_WITHDRAWAL_PENALTY')" />-->
<!--							</xsl:with-param>-->
<!--							<xsl:with-param name="right_text">-->
<!--								<xsl:value-of select="premature_withdrawal_penalty" />-->
<!--							</xsl:with-param>-->
<!--						</xsl:call-template>-->
<!--					</xsl:if>-->
<!--					Withholding Tax  -->
<!--					<xsl:if test="withholding_tax[.!='']">-->
<!--						<xsl:call-template name="table_cell">-->
<!--							<xsl:with-param name="left_text">-->
<!--										<xsl:value-of-->
<!--											select="localization:getGTPString($language, 'XSL_WITHHOLDING_TAX')" />-->
<!--							</xsl:with-param>-->
<!--							<xsl:with-param name="right_text">-->
<!--								<xsl:value-of select="withholding_tax" />-->
<!--							</xsl:with-param>-->
<!--						</xsl:call-template>-->
<!--					</xsl:if>-->
<!--					HoldMail Charges-->
<!--					<xsl:if test="hold_mail_charges[.!='']">-->
<!--						<xsl:call-template name="table_cell">-->
<!--							<xsl:with-param name="left_text">-->
<!--										<xsl:value-of-->
<!--											select="localization:getGTPString($language, 'XSL_HOLD_MAIL_CHARGES')" />-->
<!--							</xsl:with-param>-->
<!--							<xsl:with-param name="right_text">-->
<!--								<xsl:value-of select="hold_mail_charges" />-->
<!--							</xsl:with-param>-->
<!--						</xsl:call-template>-->
<!--					</xsl:if>-->
<!--					Annual Postage Fee-->
<!--					<xsl:if test="annual_postage_fee[.!='']">-->
<!--						<xsl:call-template name="table_cell">-->
<!--							<xsl:with-param name="left_text">-->
<!--										<xsl:value-of-->
<!--											select="localization:getGTPString($language, 'XSL_ANNUAL_POSTAGE_FEE')" />-->
<!--							</xsl:with-param>-->
<!--							<xsl:with-param name="right_text">-->
<!--								<xsl:value-of select="annual_postage_fee" />-->
<!--							</xsl:with-param>-->
<!--						</xsl:call-template>-->
<!--					</xsl:if>-->
<!--					Annual Postage Fee-->
<!--					<xsl:if test="withdrawable_interest[.!='']">-->
<!--						<xsl:call-template name="table_cell">-->
<!--							<xsl:with-param name="left_text">-->
<!--										<xsl:value-of-->
<!--											select="localization:getGTPString($language, 'XSL_WITHDRAWABLE_INTEREST')" />-->
<!--							</xsl:with-param>-->
<!--							<xsl:with-param name="right_text">-->
<!--								<xsl:value-of select="withdrawable_interest" />-->
<!--							</xsl:with-param>-->
<!--						</xsl:call-template>-->
<!--					</xsl:if>-->
<!--					Net Settlement Amount-->
<!--					<xsl:if test="net_settlement_amount[.!='']">-->
<!--						<xsl:call-template name="table_cell">-->
<!--							<xsl:with-param name="left_text">-->
<!--										<xsl:value-of-->
<!--											select="localization:getGTPString($language, 'XSL_NET_SETTLEMENT_AMOUNT')" />-->
<!--							</xsl:with-param>-->
<!--							<xsl:with-param name="right_text">-->
<!--								<xsl:value-of select="net_settlement_amount" />-->
<!--							</xsl:with-param>-->
<!--						</xsl:call-template>-->
<!--					</xsl:if>-->
<!--					</xsl:if>-->
<!--					Original Maturity Instruction  -->
<!--					<xsl:if test="tnx_type_code[.='03'] and maturity_instruction[.!='']">-->
<!--						<xsl:call-template name="table_cell">-->
<!--							<xsl:with-param name="left_text">-->
<!--								<xsl:value-of-->
<!--									select="localization:getGTPString($language, 'XSL_TD_CURRENT_MATURITY_INSTRUCTIONS')" />-->
<!--							</xsl:with-param>-->
<!--							<xsl:with-param name="right_text">-->
<!--							      <xsl:choose>-->
<!--							       <xsl:when test="org_previous_file/td_tnx_record/maturity_instruction[.='01']">Auto renwal of principal and interest</xsl:when>-->
<!--							       <xsl:when test="org_previous_file/td_tnx_record/maturity_instruction[.='02']">Auto renwal of principal and credit interest</xsl:when>-->
<!--							      <xsl:when test="org_previous_file/td_tnx_record/maturity_instruction[.!='']"><xsl:value-of select="org_previous_file/td_tnx_record/maturity_instruction_name"/></xsl:when>-->
<!--							      </xsl:choose>-->
<!--							</xsl:with-param>-->
<!--						</xsl:call-template>-->
<!--					</xsl:if>-->
<!--	</xsl:template>-->
	</fo:flow>
  </xsl:template>
</xsl:stylesheet>
