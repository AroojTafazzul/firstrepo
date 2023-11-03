<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com), All Rights Reserved. -->
<xsl:stylesheet
	xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider"
	xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="fo_common.xsl" />
	<xsl:import href="fo_summary.xsl" />
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')" />
	</xsl:variable>
	<xsl:variable name="accountNickName">
     	<xsl:value-of select="defaultresource:getResource('NICKNAME_ENABLED')"/>
     </xsl:variable>
	<xsl:template match="bk_tnx_record">
		<!-- HEADER -->

		<!-- FOOTER -->

		<!-- BODY -->

		<xsl:call-template name="header" />
		<xsl:call-template name="footer" />
		<xsl:call-template name="body" />
	</xsl:template>

	<xsl:template match="product_file_set/ft_tnx_record">
		<fo:table-row>
			<xsl:variable name="position" select="position()" />
			<xsl:attribute name="background-color">
		<xsl:choose>
		<xsl:when test="$position mod 2 = 1">#CBE3FF</xsl:when>
		<xsl:otherwise>#F0F7FF</xsl:otherwise>
		</xsl:choose>
		</xsl:attribute>
			<fo:table-cell>
				<fo:block font-size="8pt">
					<xsl:value-of select="ref_id" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block font-size="8pt">
					<xsl:call-template name="zero_width_space_1">
					    <xsl:with-param name="data"><xsl:value-of select="counterparties/counterparty/counterparty_name" /></xsl:with-param>
					</xsl:call-template>
				</fo:block>
			</fo:table-cell>
			<xsl:if test="/bk_tnx_record/child_sub_product_code[.!='TPT' and .!='INT' and .!= 'MT103' and .!= 'HVXB' and .!= 'MUPS' and .!='MEPS' and .!='RTGS' and .!='HVPS']">
			<fo:table-cell>
				<fo:block font-size="8pt">
					<xsl:if test="counterparties/counterparty/cpty_bank_code[.!='']">
						<xsl:value-of select="counterparties/counterparty/cpty_bank_code" />
					</xsl:if>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block font-size="8pt">
					<xsl:if test="counterparties/counterparty/cpty_branch_code[.!='']">
						<xsl:value-of select="counterparties/counterparty/cpty_branch_code" />
					</xsl:if>
				</fo:block>
			</fo:table-cell>
			
			 </xsl:if> 
			 <xsl:if test="/bk_tnx_record/child_sub_product_code [.='MUPS']"> 
				<fo:table-cell>
					<fo:block font-size="8pt">
						<xsl:if test="counterparties/counterparty/cpty_bank_swift_bic_code[.!='']">
						<xsl:call-template name="zero_width_space_1">
					    	<xsl:with-param name="data"><xsl:value-of select="counterparties/counterparty/cpty_bank_swift_bic_code" /></xsl:with-param>
						</xsl:call-template>
						</xsl:if>
					</fo:block>
				</fo:table-cell>
			 </xsl:if>
			 
			 
			<fo:table-cell>
				<fo:block font-size="8pt">
					<xsl:if test="counterparties/counterparty/counterparty_act_no[.!='']">
						<xsl:call-template name="zero_width_space_1">
					    <xsl:with-param name="data"><xsl:value-of select="counterparties/counterparty/counterparty_act_no" /></xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block font-size="8pt">
					<xsl:value-of select="ft_cur_code" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block font-size="8pt">
					<xsl:if
						test="not(../../amount_access) or  (../../amount_access[.='true'])  ">
						<xsl:value-of select="ft_amt" />
					</xsl:if>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block font-size="8pt">
					<xsl:if test="tnx_stat_code[.!='']">
						<xsl:value-of
							select="localization:getDecode($language, 'N004', tnx_stat_code)" />
					</xsl:if>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
	              <fo:block font-size="8pt" text-align="end">
	                      <xsl:if test="prod_stat_code[.!='']">
	                              <xsl:value-of
	                                      select="localization:getDecode($language, 'N005', prod_stat_code)" />
	                      </xsl:if>
	              </fo:block>
 	 		</fo:table-cell>
		</fo:table-row>
		<!-- <fo:table-row keep-together="always"> <xsl:variable name="position" 
			select="position()"/> <xsl:attribute name="background-color"> <xsl:choose> 
			<xsl:when test="$position mod 2 = 1">#CBE3FF</xsl:when> <xsl:otherwise>#F0F7FF</xsl:otherwise> 
			</xsl:choose> </xsl:attribute> <fo:table-cell> <fo:block/> </fo:table-cell> 
			<fo:table-cell number-columns-spanned="3"> <fo:block> <xsl:if test="counterparties/counterparty/cpty_bank_code[.!='']"> 
			<xsl:value-of select="counterparties/counterparty/cpty_bank_code"/>/ </xsl:if> 
			<xsl:if test="counterparties/counterparty/cpty_branch_code[.!='']"> <xsl:value-of 
			select="counterparties/counterparty/cpty_branch_code"/>/ </xsl:if> <xsl:if 
			test="counterparties/counterparty/counterparty_act_no[.!='']"> <xsl:value-of 
			select="counterparties/counterparty/counterparty_act_no"/> </xsl:if> </fo:block> 
			</fo:table-cell> </fo:table-row> -->
	</xsl:template>
	
	<xsl:template match="product_file_set/ip_tnx_record">
		<fo:table-row>
			<xsl:variable name="position" select="position()" />
			<xsl:attribute name="background-color">
		<xsl:choose>
		<xsl:when test="$position mod 2 = 1">#CBE3FF</xsl:when>
		<xsl:otherwise>#F0F7FF</xsl:otherwise>
		</xsl:choose>
		</xsl:attribute>
			<fo:table-cell>
				<fo:block font-size="5pt">
					<xsl:value-of select="ref_id" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block font-size="5pt">
					<xsl:value-of select="issuer_ref_id" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block font-size="5pt">
					<xsl:value-of select="fscm_program/program_name" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block font-size="4pt">
					<xsl:value-of select="seller_name" />					
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block font-size="4pt">					
					<xsl:value-of select="buyer_name" />				
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block font-size="5pt">
					<xsl:value-of select="total_net_cur_code" />
				</fo:block>
			</fo:table-cell>
			<xsl:if test="tnx_type_code[.='63']">
				<fo:table-cell>
					<fo:block font-size="5pt">					
						<xsl:value-of select="total_net_amt" />					
					</fo:block>
				</fo:table-cell>
			</xsl:if>				
			<fo:table-cell>
				<fo:block font-size="5pt">					
					<xsl:value-of select="finance_amt" />					
				</fo:block>
			</fo:table-cell>
			<xsl:if test="tnx_type_code[.='63']">
				<fo:table-cell>
					<fo:block font-size="5pt">					
						<xsl:value-of select="liab_total_net_amt" />					
					</fo:block>
				</fo:table-cell>
				<fo:table-cell>
					<fo:block font-size="5pt">					
						<xsl:value-of select="iss_date" />					
					</fo:block>
				</fo:table-cell>
				<fo:table-cell>
					<fo:block font-size="5pt">					
						<xsl:value-of select="due_date" />					
					</fo:block>
				</fo:table-cell>
			</xsl:if>
			<xsl:if test="tnx_type_code[.='13'] or tnx_type_code[.='15']">
				<fo:table-cell>
					<fo:block font-size="5pt">					
						<xsl:value-of select="outstanding_repayment_amt" />					
					</fo:block>
				</fo:table-cell>
			
				<fo:table-cell>
					<fo:block font-size="5pt">					
						<xsl:choose>
						<xsl:when test="total_repaid_amt[.='']">
							&#xA0;
						</xsl:when>	
						<xsl:otherwise>
							<xsl:value-of select="total_repaid_amt" />
						</xsl:otherwise>
					</xsl:choose>				
					</fo:block>
				</fo:table-cell>
			
				<fo:table-cell>
					<fo:block font-size="5pt">					
						<xsl:value-of select="fin_date" />					
					</fo:block>
				</fo:table-cell>
				<fo:table-cell>
					<fo:block font-size="5pt">					
						<xsl:value-of select="fin_due_date" />					
					</fo:block>
				</fo:table-cell>
			</xsl:if>
			<!-- <xsl:if test="tnx_type_code[.='63']">
				<fo:table-cell>
					<fo:block font-size="5pt">					
						<xsl:value-of select="inv_eligible_pct" />					
					</fo:block>
				</fo:table-cell>
			</xsl:if> -->
			<fo:table-cell>
				<fo:block font-size="5pt" text-align="end">
					<xsl:if test="prod_stat_code[.!='']">
						<xsl:value-of
							select="localization:getDecode($language, 'N005', prod_stat_code)" />
					</xsl:if>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
	
	<xsl:template match="product_file_set/in_tnx_record">
		<fo:table-row>
			<xsl:variable name="position" select="position()" />
			<xsl:attribute name="background-color">
		<xsl:choose>
		<xsl:when test="$position mod 2 = 1">#CBE3FF</xsl:when>
		<xsl:otherwise>#F0F7FF</xsl:otherwise>
		</xsl:choose>
		</xsl:attribute>
			<fo:table-cell>
				<fo:block font-size="5pt">
					<xsl:value-of select="ref_id" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block font-size="5pt">
					<xsl:value-of select="issuer_ref_id" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block font-size="5pt">
					<xsl:value-of select="fscm_program/program_name" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block font-size="4pt">
					<xsl:value-of select="seller_name" />					
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block font-size="4pt">					
					<xsl:value-of select="buyer_name" />				
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block font-size="5pt">
					<xsl:value-of select="total_net_cur_code" />
				</fo:block>
			</fo:table-cell>
			<xsl:if test="tnx_type_code[.='63']">
				<fo:table-cell>
					<fo:block font-size="5pt">					
						<xsl:value-of select="total_net_amt" />					
					</fo:block>
				</fo:table-cell>
			</xsl:if>				
			<fo:table-cell>
				<fo:block font-size="5pt">					
					<xsl:value-of select="finance_amt" />					
				</fo:block>
			</fo:table-cell>
			<xsl:if test="tnx_type_code[.='63']">
				<fo:table-cell>
					<fo:block font-size="5pt">					
						<xsl:value-of select="liab_total_net_amt" />					
					</fo:block>
				</fo:table-cell>
				<fo:table-cell>
					<fo:block font-size="5pt">					
						<xsl:value-of select="iss_date" />					
					</fo:block>
				</fo:table-cell>
				<fo:table-cell>
					<fo:block font-size="5pt">					
						<xsl:value-of select="due_date" />					
					</fo:block>
				</fo:table-cell>
				<!-- <fo:table-cell>
					<fo:block font-size="5pt">					
						<xsl:value-of select="inv_eligible_pct" />					
					</fo:block>
				</fo:table-cell> -->
			</xsl:if>	
			<xsl:if test="tnx_type_code[.='13'] or tnx_type_code[.='15']">
				<fo:table-cell>
					<fo:block font-size="5pt">					
						<xsl:value-of select="outstanding_repayment_amt" />					
					</fo:block>
				</fo:table-cell>
			
				<fo:table-cell>
					<fo:block font-size="5pt">					
						<xsl:choose>
						<xsl:when test="total_repaid_amt[.='']">
							&#xA0;
						</xsl:when>	
						<xsl:otherwise>
							<xsl:value-of select="total_repaid_amt" />
						</xsl:otherwise>
					</xsl:choose>				
					</fo:block>
				</fo:table-cell>
			
				<fo:table-cell>
					<fo:block font-size="5pt">					
						<xsl:value-of select="fin_date" />					
					</fo:block>
				</fo:table-cell>
				<fo:table-cell>
					<fo:block font-size="5pt">					
						<xsl:value-of select="fin_due_date" />					
					</fo:block>
				</fo:table-cell>
			</xsl:if>	
			<fo:table-cell>
				<fo:block font-size="5pt" text-align="end">
					<xsl:if test="prod_stat_code[.!='']">
						<xsl:value-of
							select="localization:getDecode($language, 'N005', prod_stat_code)" />
					</xsl:if>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
	<xsl:template name="header">
		<fo:static-content flow-name="xsl-region-before">
			<xsl:call-template name="header_issuing_bank" />
		</fo:static-content>
	</xsl:template>
	<xsl:template name="body">
		<fo:flow flow-name="xsl-region-body" font-size="{$pdfFontSize}">
			<xsl:call-template name="disclammer_template" />
			<fo:block id="gendetails" />
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="bk_type_var"><xsl:value-of select="bk_type"/></xsl:variable>
			<fo:block white-space-collapse="false">
				<fo:table>
					<fo:table-column column-width="50%" />
					<fo:table-column column-width="50%" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
								<fo:table>
									<fo:table-column column-width="40%" />
									<fo:table-column column-width="60%" />
									<fo:table-body start-indent="2pt">
										<fo:table-row>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
										<xsl:if test ="entity and entity !=''">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>													
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ENTITY')" />													
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="entity" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
									    </xsl:if>
										<xsl:if test="issuing_bank/name[.!='']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="localization:getGTPString($language, 'CUSTOMER_BANK_LABEL')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="issuing_bank/name" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>									    
										<xsl:if
											test="(bk_type='PAYMT' or bk_type='PAYRL') and applicant_act_name[.!='']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_TRANSFER_FROM')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="applicant_act_name" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
											<xsl:if test="$accountNickName='true' and applicant_act_nickname!=''">
												<fo:table-row>
													<fo:table-cell>
														<fo:block>
															<xsl:value-of select="localization:getGTPString($language,'XSL_ACCOUNT_NICK_NAME')"/>
														</fo:block>
													</fo:table-cell>
													<fo:table-cell>
														<fo:block>
															<xsl:value-of select="applicant_act_nickname" />
														</fo:block>
													</fo:table-cell>
												</fo:table-row>
											</xsl:if>
										</xsl:if>
										<xsl:if test="child_sub_product_code[.!='']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_BK_PRODUCT_TYPE')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getDecode($language, 'N047',concat(child_sub_product_code,'_BK'))" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<xsl:if test="bk_type='COLLE' and applicant_act_name[.!='']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_TRANSFER_TO')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="applicant_act_name" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
											<xsl:if test="$accountNickName='true' and applicant_act_nickname!=''">
												<xsl:call-template name="table_cell">
													<xsl:with-param name="left_text"></xsl:with-param>
													<xsl:with-param name="right_text">
														<xsl:value-of select="applicant_act_nickname"/>
													</xsl:with-param>
												</xsl:call-template>
											</xsl:if>
										</xsl:if>

										<xsl:if test="bk_type[.='PAYMT']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_BK_PRODUCT_GROUP')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_BK_PAYMENTS')" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<xsl:if test="bk_type[.='COLLE']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_BK_PRODUCT_GROUP')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_BK_COLLECTION')" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<xsl:if test="bk_type[.='PAYRL']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_BK_PRODUCT_GROUP')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_BK_PAYROLL')" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<xsl:if test="child_sub_product_code[.='MUPS']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_CLEARING_CODE_NAME')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="clearing_code" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<xsl:if test="narrative_additional_instructions[.!='']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BULK_DESCRIPTION')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="narrative_additional_instructions" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<xsl:if test="pre_approved_status[.='Y']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_BULK_PAB_ONLY')" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
									</fo:table-body>
								</fo:table>
							</fo:table-cell>
							<fo:table-cell>
								<fo:table>
									<fo:table-column column-width="40%" />
									<fo:table-column column-width="60%" />
									<fo:table-body start-indent="1pt">
										<fo:table-row>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
										<!--xsl:if test="issuing_bank/name[.!='']"> <fo:table-row> <fo:table-cell> 
											<fo:block> <xsl:value-of select="localization:getGTPString($language, 'BANK_LABEL')" 
											/> </fo:block> </fo:table-cell> <fo:table-cell> <fo:block> <xsl:value-of 
											select="issuing_bank/name" /> </fo:block> </fo:table-cell> </fo:table-row> 
											</xsl:if -->
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of
														select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')" />
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="ref_id" />
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<xsl:if test="bo_ref_id !=''">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of
														select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')" />
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="bo_ref_id" />
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test = "appl_date != ''">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="appl_date" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<xsl:if test="value_date != ''">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TRANSFER_DATE')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="value_date" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<xsl:if test="bk_type[.='PAYRL']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_BK_PAYROLL_TYPE_LABEL')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
									                           <xsl:if test="payroll_type[.='EMPL']">
									                                  <xsl:value-of select="localization:getGTPString($language, 'XSL_BK_PAYROLL_TYPE_EMPL_IN_FO')" />
									                           </xsl:if>
									                           <xsl:if test="payroll_type[.='EXEC']">
									                                  <xsl:value-of select="localization:getGTPString($language, 'XSL_BK_PAYROLL_TYPE_EXEC_IN_FO')" />
									                           </xsl:if>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<!-- customer_reference -->
										<xsl:if test="cust_ref_id[.!='']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BULK_REF_ID')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="cust_ref_id" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<xsl:if test="template_id[.!='']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TEMPLATE_ID')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="template_id" />
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
			
			<xsl:if test="product_code[.='IN'] or product_code[.='IP']">
				<fo:block id="customerreference" />
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_BANK_DETAILS')" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				
				<fo:block white-space-collapse="false">
					<fo:table>
						<fo:table-column column-width="50%" />
						<fo:table-column column-width="50%" />
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
									<fo:table>
										<fo:table-column column-width="40%" />
										<fo:table-column column-width="60%" />
										<fo:table-body start-indent="2pt">
											<fo:table-row>
												<fo:table-cell>
													<fo:block> </fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block> </fo:block>
												</fo:table-cell>
											</fo:table-row>
											<xsl:if test="applicant_reference[.!='']">
												<fo:table-row>
													<fo:table-cell>
														<fo:block>
															<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')" />
														</fo:block>
													</fo:table-cell>
													<fo:table-cell>
														<fo:block>
															<xsl:value-of select="issuing_bank/name" />
	                 		 							</fo:block>
													</fo:table-cell>
												</fo:table-row>
												<xsl:variable name="applicant_ref"><xsl:value-of select="applicant_reference" /></xsl:variable>
												<fo:table-row>
													<fo:table-cell>
														<fo:block>
															<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')" />
														</fo:block>
													</fo:table-cell>
													<fo:table-cell>
														<fo:block>
															<xsl:choose>
	                                            				<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$applicant_ref]) >= 1">
	                                                   				<xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$applicant_ref]/description"/>
	                                            				</xsl:when>
	                                            				<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$applicant_ref]) = 0">
	                                                   				<xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$applicant_ref]/description"/>
	                                            				</xsl:when>
	                                    					</xsl:choose>
														</fo:block>
													</fo:table-cell>
												</fo:table-row>
											</xsl:if>
										</fo:table-body>
									</fo:table>
								</fo:table-cell>
								<fo:table-cell>
									<fo:table>
										<fo:table-column column-width="40%" />
										<fo:table-column column-width="60%" />
										<fo:table-body start-indent="1pt">
											<fo:table-row>
												<fo:table-cell>
													<fo:block> </fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block> </fo:block>
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
			
			<!--Bulk Summary -->
			<fo:block id="bulksummary" />
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_BULK_SUMMARY')" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:choose>
                <xsl:when test="child_sub_product_code ='MEPS' or child_sub_product_code ='RTGS'">
				  <fo:block>
				    <xsl:value-of select="localization:getGTPString($language, 'XSL_BK_MEPS_RTGS_DISCLAIMER')" />
				  </fo:block>
				</xsl:when>
			</xsl:choose>
			<!-- Content to show Bulk Summary In sync with reporting pop up -->
			<fo:block white-space-collapse="false">
				<fo:table>
					<fo:table-column column-width="50%" />
					<fo:table-column column-width="50%" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
								<fo:table>
									<fo:table-column column-width="60%" />
									<fo:table-column column-width="40%" />
									<fo:table-body start-indent="2pt">
										<fo:table-row>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
										<xsl:if test="bk_total_amt[.!='']">
											<fo:table-row>
												<fo:table-cell>
													<xsl:choose>
	                                            		<xsl:when test="sub_product_code ='IPBR' or sub_product_code ='INBR'">
															<fo:block>
																<xsl:value-of
																	select="localization:getGTPString($language, 'XSL_BK_TOTAL_REPAYMENT_AMT')" />
															</fo:block>
														</xsl:when>
														<xsl:otherwise>
															<fo:block>
																<xsl:value-of
																	select="localization:getGTPString($language, 'XSL_BK_TOTAL_AMT')" />
															</fo:block>
														</xsl:otherwise>
													</xsl:choose>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="bk_cur_code" />
														<xsl:text> </xsl:text>
														<xsl:value-of select="bk_total_amt" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<xsl:if test="total_approved_amt[.!='']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_BK_TOTAL_APPROVED_AMT')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="bk_cur_code" />
														<xsl:text> </xsl:text>
														<xsl:value-of select="total_approved_amt" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<xsl:if test="bk_repaid_amt[.!=''] and (sub_product_code = 'INBR' or sub_product_code = 'IPBR')">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_BK_REPAID_AMT')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="bk_repaid_cur_code" />
														<xsl:text> </xsl:text>
														<xsl:value-of select="bk_repaid_amt" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<xsl:if test="bk_repay_date[.!='']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_BK_REPAID_DATE')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="bk_repay_date" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<xsl:if test="bk_fin_amt[.!='']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_BK_FIN_AMT')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="bk_fin_cur_code" />
														<xsl:text> </xsl:text>
														<xsl:value-of select="bk_fin_amt" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>										
										<xsl:if test="record_number[.!='']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_BK_RECORD_NUMBER')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="record_number" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<!-- Commenting as part of MPS-63187
										<xsl:if test="no_approved_records[.!='']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_BK_APPROVED_RECORD_NUMBER')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="no_approved_records" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if> -->
									</fo:table-body>
								</fo:table>
							</fo:table-cell>
							<fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
								<fo:table>
									<fo:table-column column-width="60%" />
									<fo:table-column column-width="40%" />
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
										<xsl:if test="bk_highest_amt[.!=''] and (not(amount_access) or (amount_access[.='true']))">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_BK_HIGHEST_AMT')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="bk_cur_code" />
														<xsl:text> </xsl:text>
														<xsl:value-of select="bk_highest_amt" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<xsl:if test="highest_approved_amt[.!=''] and (not(amount_access) or (amount_access[.='true']))">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_BK_HIGHEST_APPROVED_AMT')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="bk_cur_code" />
														<xsl:text> </xsl:text>
														<xsl:value-of select="highest_approved_amt" />
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
										<xsl:if test="no_approved_records[.!='']">
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_BK_APPROVED_RECORD_NUMBER')" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:value-of select="no_approved_records" />
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
			<!--transaction Details -->
			<fo:block id="transactiondetails" />
			<xsl:if
				test="(product_file_set/ft_tnx_record or product_file_set/ip_tnx_record or product_file_set/in_tnx_record) and (not(item_access) or  (item_access[.='true'])) ">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_DETAILS')" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<!--Transaction Remarks -->
			<xsl:if test="free_format_text[.!='']">
				<fo:block id="tnxRemarksdetails" />
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_REMARKS_DETAILS')" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text" />
							<xsl:with-param name="right_text">
								<xsl:value-of select="free_format_text" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<!--Individual Transfer Details -->
			<xsl:if
				test="product_file_set/ft_tnx_record and (not(item_access) or  (item_access[.='true'])) ">
				<fo:block white-space-collapse="false"
					xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider">
					<fo:table>
						<fo:table-column column-width="20%" />
						<fo:table-column column-width="17%" />
						<xsl:if test="child_sub_product_code!='TPT' and child_sub_product_code!='INT' and child_sub_product_code!= 'MT103' and child_sub_product_code!= 'MUPS'">
						<fo:table-column column-width="8%" />
						<fo:table-column column-width="3%" />
						</xsl:if>
						<xsl:if test="child_sub_product_code[.='MUPS']">
						<fo:table-column column-width="8%" />
						</xsl:if>
						<fo:table-column column-width="12%" />
						<fo:table-column column-width="10%" />
						<fo:table-column column-width="10%" />
						<!-- Fixing  column width to ensure Product Status is displayed in the pdf.15% is too much for a column due to which some columns are not visible in pdf-->
						<fo:table-column column-width="10%" />
						<fo:table-column column-width="10%" />

						<fo:table-header>
							<fo:table-row background-color="#7692B7" color="white"
								font-weight="bold" keep-with-next="always">
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="localization:getGTPString($language, 'REFERENCEID')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_BENEFICIARY_NAME_HEADER')" />
									</fo:block>
								</fo:table-cell>
								<xsl:if test="child_sub_product_code!='TPT' and child_sub_product_code!='INT' and child_sub_product_code!= 'MT103' and child_sub_product_code!= 'HVXB' and child_sub_product_code!= 'HVPS' and child_sub_product_code!= 'MUPS' and child_sub_product_code!= 'MEPS' and child_sub_product_code!= 'RTGS'">
									<fo:table-cell >
										<fo:block  >
											<xsl:value-of
												select="localization:getGTPString($language, 'HEADER_BANK_CODE')" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell >
										<fo:block  >
											<xsl:value-of
												select="localization:getGTPString($language, 'HEADER_BRANCH_CODE')" />
										</fo:block>
									</fo:table-cell>
								 </xsl:if>
								<xsl:if test="child_sub_product_code [.='MUPS']">
									<fo:table-cell >
										<fo:block >
											<xsl:value-of
												select="localization:getGTPString($language, 'HEADER_IFSC_CODE')" />
										</fo:block>
									</fo:table-cell>
								 </xsl:if>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_COL_ACCT_NUM')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="localization:getGTPString($language, 'ACCOUNTCCY')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of select="localization:getGTPString($language, 'AMOUNT')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of select="localization:getGTPString($language, 'STATUS')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
	                                  <fo:block text-align="end">
	                                        <xsl:value-of select="localization:getGTPString($language, 'PRODUCT_STATUS')" />
	                                  </fo:block>
                         		</fo:table-cell>
							</fo:table-row>
							<!-- <fo:table-row background-color="#7692B7" color="white" font-weight="bold"> 
								<fo:table-cell> <fo:block> </fo:block> </fo:table-cell> <fo:table-cell number-columns-spanned="3"> 
								<fo:block> <xsl:value-of select="localization:getGTPString($language, 'HEADER_BANK_CODE_BRANCH_CODE')"/> 
								</fo:block> </fo:table-cell> </fo:table-row> -->
						</fo:table-header>
						<fo:table-body start-indent="2pt">
							<xsl:apply-templates select="product_file_set/ft_tnx_record" />
						</fo:table-body>
					</fo:table>
				</fo:block>
			</xsl:if>
			
			<xsl:if
				test="product_file_set/ip_tnx_record and (not(item_access) or  (item_access[.='true'])) ">
				<fo:block white-space-collapse="false"
					xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider">
					<fo:table>
					<xsl:choose>
					 <xsl:when test ="entity and entity !=''">
						<fo:table-column column-width="10%" />
						<fo:table-column column-width="10%" />
						<fo:table-column column-width="7%" />
						<fo:table-column column-width="8%" />
						<fo:table-column column-width="8%" />
						<fo:table-column column-width="8%" />
						<fo:table-column column-width="4%" />
						<fo:table-column column-width="8%" />
						<fo:table-column column-width="8%" />
						<fo:table-column column-width="8%" />
						<fo:table-column column-width="8%" />
						<fo:table-column column-width="8%" />
						<!-- <fo:table-column column-width="6%" /> -->
						<fo:table-column column-width="10%" />
					</xsl:when>
					<xsl:otherwise>
						<fo:table-column column-width="10%" />
						<fo:table-column column-width="10%" />
						<fo:table-column column-width="10%" />
						<fo:table-column column-width="8%" />
						<fo:table-column column-width="8%" />
						<fo:table-column column-width="4%" />
						<fo:table-column column-width="8%" />
						<fo:table-column column-width="8%" />
						<fo:table-column column-width="8%" />
						<fo:table-column column-width="8%" />
						<fo:table-column column-width="8%" />
						<!-- <fo:table-column column-width="6%" /> -->
						<fo:table-column column-width="10%" />
					</xsl:otherwise>
				</xsl:choose>
					
						<fo:table-header>
							<fo:table-row background-color="#7692B7" color="white"
								font-weight="bold" keep-with-next="always" font-size="6pt">
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="localization:getGTPString($language, 'REFERENCEID')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="localization:getGTPString($language, 'INVOICE_REFERENCE_LABEL')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="localization:getGTPString($language, 'PROGRAM_NAME')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell >
									<fo:block  >
										<xsl:value-of
											select="localization:getGTPString($language, 'SELLER_NAME')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="localization:getGTPString($language, 'BUYER_NAME')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="localization:getGTPString($language, 'ACCOUNTCCY')" />
									</fo:block>
								</fo:table-cell>
								<xsl:if test="sub_product_code[.='IPBF']">
									<fo:table-cell>
										<fo:block>
											<xsl:value-of select="localization:getGTPString($language, 'INVOICE_AMOUNT')" />
										</fo:block>
									</fo:table-cell>
								</xsl:if>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of select="localization:getGTPString($language, 'FINANCED_AMNT')" />
									</fo:block>
								</fo:table-cell>
								<xsl:if test="sub_product_code[.='IPBF']">
									<fo:table-cell>
										<fo:block>
											<xsl:value-of select="localization:getGTPString($language, 'OS_AMOUNT')" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>
											<xsl:value-of select="localization:getGTPString($language, 'INVOICE_DATE')" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>
											<xsl:value-of select="localization:getGTPString($language, 'INVOICE_DUE_DATE')" />
										</fo:block>
									</fo:table-cell>
									<!-- <fo:table-cell>
										<fo:block>
											<xsl:value-of select="localization:getGTPString($language, 'FIN_REQUESTED_PERCENT')" />
										</fo:block>
									</fo:table-cell> -->
								</xsl:if>
								<xsl:if test="sub_product_code ='IPBR'">
									<fo:table-cell>
										<fo:block>
											<xsl:value-of select="localization:getGTPString($language, 'OUTSTANDING_REPAY_AMT')" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>
											<xsl:value-of select="localization:getGTPString($language, 'TOTAL_REPAID_AMT')" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>
											<xsl:value-of select="localization:getGTPString($language, 'FINANCE_ISSUE_DATE')" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>
											<xsl:value-of select="localization:getGTPString($language, 'FINANCE_DUE_DATE')" />
										</fo:block>
									</fo:table-cell>
								</xsl:if>
								<fo:table-cell>
									<fo:block text-align="end">
										<xsl:value-of select="localization:getGTPString($language, 'STATUS')" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>	
						</fo:table-header>
						<fo:table-body start-indent="2pt">
							<xsl:apply-templates select="product_file_set/ip_tnx_record" />
						</fo:table-body>
					</fo:table>
				</fo:block>
			</xsl:if>
			<xsl:if
				test="product_file_set/in_tnx_record and (not(item_access) or  (item_access[.='true'])) ">
				<fo:block white-space-collapse="false"
					xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider">
					<fo:table>
						<xsl:choose>
							 <xsl:when test ="entity and entity !=''">
								<fo:table-column column-width="10%" />
								<fo:table-column column-width="10%" />
								<fo:table-column column-width="7%" />
								<fo:table-column column-width="8%" />
								<fo:table-column column-width="8%" />
								<fo:table-column column-width="8%" />
								<fo:table-column column-width="4%" />
								<fo:table-column column-width="8%" />
								<fo:table-column column-width="8%" />
								<fo:table-column column-width="8%" />
								<fo:table-column column-width="8%" />
								<fo:table-column column-width="8%" />
								<!-- <fo:table-column column-width="6%" /> -->
								<fo:table-column column-width="10%" />
							</xsl:when>
							<xsl:otherwise>
								<fo:table-column column-width="10%" />
								<fo:table-column column-width="10%" />
								<fo:table-column column-width="10%" />
								<fo:table-column column-width="8%" />
								<fo:table-column column-width="4%" />
								<fo:table-column column-width="8%" />
								<fo:table-column column-width="8%" />
								<fo:table-column column-width="8%" />
								<fo:table-column column-width="8%" />
								<fo:table-column column-width="8%" />
								<fo:table-column column-width="8%" />
								<!-- <fo:table-column column-width="6%" /> -->
								<fo:table-column column-width="10%" />
							</xsl:otherwise>
						</xsl:choose>

						<fo:table-header>
							<fo:table-row background-color="#7692B7" color="white"
								font-weight="bold" keep-with-next="always" font-size="6pt">
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="localization:getGTPString($language, 'REFERENCEID')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="localization:getGTPString($language, 'INVOICE_REFERENCE_LABEL')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="localization:getGTPString($language, 'PROGRAM_NAME')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell >
									<fo:block  >
										<xsl:value-of
											select="localization:getGTPString($language, 'SELLER_NAME')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="localization:getGTPString($language, 'BUYER_NAME')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="localization:getGTPString($language, 'ACCOUNTCCY')" />
									</fo:block>
								</fo:table-cell>
								<xsl:if test="sub_product_code[.='INBF']">
									<fo:table-cell>
										<fo:block>
											<xsl:value-of select="localization:getGTPString($language, 'INVOICE_AMOUNT')" />
										</fo:block>
									</fo:table-cell>
								</xsl:if>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of select="localization:getGTPString($language, 'FINANCED_AMNT')" />
									</fo:block>
								</fo:table-cell>
								<xsl:if test="sub_product_code[.='INBF']">
									<fo:table-cell>
										<fo:block>
											<xsl:value-of select="localization:getGTPString($language, 'OS_AMOUNT')" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>
											<xsl:value-of select="localization:getGTPString($language, 'INVOICE_DATE')" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>
											<xsl:value-of select="localization:getGTPString($language, 'INVOICE_DUE_DATE')" />
										</fo:block>
									</fo:table-cell>
									<!-- <fo:table-cell>
										<fo:block>
											<xsl:value-of select="localization:getGTPString($language, 'FIN_REQUESTED_PERCENT')" />
										</fo:block>
									</fo:table-cell> -->
								</xsl:if>
								<xsl:if test="sub_product_code ='INBR'">
									<fo:table-cell>
										<fo:block>
											<xsl:value-of select="localization:getGTPString($language, 'OUTSTANDING_REPAY_AMT')" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>
											<xsl:value-of select="localization:getGTPString($language, 'TOTAL_REPAID_AMT')" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>
											<xsl:value-of select="localization:getGTPString($language, 'FINANCE_ISSUE_DATE')" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>
											<xsl:value-of select="localization:getGTPString($language, 'FINANCE_DUE_DATE')" />
										</fo:block>
									</fo:table-cell>
								</xsl:if>
								<fo:table-cell>
									<fo:block text-align="end">
										<xsl:value-of select="localization:getGTPString($language, 'STATUS')" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>	
						</fo:table-header>
						<fo:table-body start-indent="2pt">
							<xsl:apply-templates select="product_file_set/in_tnx_record" />
						</fo:table-body>
					</fo:table>
				</fo:block>
			</xsl:if>

			<xsl:element name="fo:block">
				<xsl:attribute name="font-size">1pt</xsl:attribute>
				<xsl:attribute name="id">
                    <xsl:value-of select="concat('LastPage_',../@section)" />
                </xsl:attribute>
			</xsl:element>
		</fo:flow>
	</xsl:template>
	<xsl:template name="footer">
		<fo:static-content flow-name="xsl-region-after">
			<fo:block font-family="{$pdfFont}" font-size="8.0pt"
				keep-together="always">
				<!-- Page number -->
				<fo:block color="{$footerFontColor}" font-weight="bold" text-align="start">
					<fo:page-number />
					/
					<fo:page-number-citation>
						<xsl:attribute name="ref-id">
							<xsl:value-of select="concat('LastPage_',../@section)" />
						</xsl:attribute>
					</fo:page-number-citation>
				</fo:block>
				<fo:block color="{$footerFontColor}" text-align="start">
					<xsl:attribute name="end-indent">
						<xsl:value-of select="number($pdfMargin)" />
					</xsl:attribute>
					<xsl:value-of
						select="convertTools:internalDateToStringDate($systemDate,$language)" />
				</fo:block>
			</fo:block>
		</fo:static-content>
	</xsl:template>
</xsl:stylesheet>