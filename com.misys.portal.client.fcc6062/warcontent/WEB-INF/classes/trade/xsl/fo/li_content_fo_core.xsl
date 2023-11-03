<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<!--
		Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com), All
		Rights Reserved.
	-->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:localization="xalan://com.misys.portal.common.localization.Localization" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:security="xalan://com.misys.portal.security.GTPSecurity" xmlns:formatter="xalan://com.misys.portal.common.tools.ConvertTools" version="1.0" xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>

	<xsl:template match="li_tnx_record">
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
			<xsl:call-template name="disclammer_template"/>
			<!-- Event Details -->
			<xsl:if test="not(tnx_id)">
			<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_EVENT_DETAILS')" />
							</xsl:with-param>
						</xsl:call-template>
						<!-- Company Name -->
						<xsl:if test="company_name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_COMPANY_NAME')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="company_name" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Product Code -->
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_CODE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of
								select="localization:getDecode($language, 'N001', product_code[.])" />
							</xsl:with-param>
						</xsl:call-template>
						<!-- Reference ID -->
						<xsl:if test="ref_id[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ref_id" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Customer Reference -->
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
					  <!--  Reference -->
					  <xsl:if test="deal_ref_id[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_RELATED_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="deal_ref_id"/>
							</xsl:with-param>
						</xsl:call-template>
					 </xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
		<!--transaction Details -->		
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
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_COMPANY_NAME')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
						<xsl:value-of select="company_name" />
					</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="product_code[.!='']">
					<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_CODE')" />
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
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_TRANSACTION_TYPE')" />
						</xsl:with-param>				
						<xsl:with-param name="right_text">
							<xsl:choose>
								<!-- Checking product_code First -->
								<xsl:when test="product_code[.='LN']">
									<!-- Perform product specific exercises -->
									 <xsl:choose>
									 	<xsl:when test="tnx_type_code[.='03']">
									 		<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_TYPE_INCREASE')"/>
									 	</xsl:when>
									 	<xsl:when test="tnx_type_code[.='13']">
									 		<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_TYPE_PAYMENT')"/>
									 	</xsl:when>
									 	<xsl:otherwise>
									 		<xsl:value-of select="localization:getDecode($language, 'N002', tnx_type_code[.])" />
									 	</xsl:otherwise>
									 </xsl:choose>
									<xsl:if test="sub_tnx_type_code and sub_tnx_type_code[.!='']">
									    <xsl:value-of select="concat(' (',localization:getDecode($language, 'N003', sub_tnx_type_code[.]),')')" />
									</xsl:if>
								</xsl:when>
								<xsl:when test="product_code[.='LC']">
									<xsl:value-of select="localization:getDecode($language, 'N002', tnx_type_code[.])" />
									<xsl:if test="sub_tnx_type_code and sub_tnx_type_code[.!='']">
										<xsl:value-of select="concat(' ',localization:getDecode($language, 'N003', sub_tnx_type_code[.]))" />
									</xsl:if>
									<!-- Perform product specific exercises -->
									<xsl:if test="tnx_type_code[.='13'] and lc_message_type_clean and lc_message_type_clean[.='BillArrivalClean']">
										&nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_26_ADVISE_OF_BILL_ARRV_CLEAN')" />
									</xsl:if>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="localization:getDecode($language, 'N002', tnx_type_code[.])" />
									<xsl:if test="sub_tnx_type_code and sub_tnx_type_code[.!='']">
										<xsl:value-of select="concat(' ',localization:getDecode($language, 'N003', sub_tnx_type_code[.]))" />
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
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
				<xsl:if test="iss_date[.!=''] and (tnx_stat_code[.='04'] and product_code[.!='FX'] and sub_product_code[.!='TRTD']) and sub_product_code != 'SMP'">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<fo:block font-family="{$pdfFont}">
										<xsl:choose>
											<xsl:when test="product_code[.='FT']">
												<xsl:choose>
														<xsl:when test="product_code[.='FT'] and (sub_product_code[.='TRINT'] or sub_product_code[.='TRTPT'])">
													<xsl:value-of
														select="localization:getGTPString($language, 'XSL_CONTRACT_FT_REQUEST_DATE_LABEL')" />
														</xsl:when>
													<xsl:otherwise>
														<xsl:value-of
														select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXECUTION_DATE')" />
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ISSUE_DATE')" />
											</xsl:otherwise>
										</xsl:choose>
									</fo:block>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="iss_date" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			<!--Reporting Details -->	
			 <xsl:if test="security:isBank($rundata)"> 	
			<fo:block id="reportdetails"/>
					 <xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REPORTING_DETAILS')"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="prod_stat_code[.!=''] ">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_NEW_TNX_STAT_LABEL')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:choose>
											<xsl:when test="prod_stat_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_APPROVED')"/></xsl:when>
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
					
					<!-- Parent Reference -->
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
					<!-- Bank Reference (LC) -->
					<xsl:if test="cross_references/cross_reference/type_code[.='02']">
					<xsl:variable name="parent_file" select="xmlRender:getXMLMasterNode(cross_references/cross_reference[./type_code='02']/product_code, cross_references/cross_reference[./type_code='02']/ref_id, $language)"/>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_LC_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="$parent_file/bo_ref_id"/>
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
					<xsl:if test="bo_lc_ref_id[.!=''] or alt_lc_ref_id[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_LC_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="bo_lc_ref_id[.!='']">
										<xsl:value-of select="bo_lc_ref_id"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="alt_lc_ref_id"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="deal_ref_id[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_RELATED_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="deal_ref_id"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="applicant_name[.!=''] or applicant_address_line_1[.!=''] or applicant_address_line_2[.!=''] or applicant_dom[.!=''] or applicant_reference[.!='']">
				<!--Applicant Details-->
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_APPLICANT_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
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
						<!-- Adress -->
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
						<xsl:if test="applicant_reference[.!=''] and security:isBank($rundata)">
							<xsl:variable name="appl_ref">
                               <xsl:value-of select="applicant_reference"/>
                            </xsl:variable>
                            <xsl:variable name="iss_bank">
								<xsl:value-of select="//li_tnx_record/issuing_bank/abbv_name"/>
							</xsl:variable>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<!-- <xsl:choose>
										<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) &gt;= 1">
									      		<xsl:value-of select="//*/avail_main_banks/bank[abbv_name = $iss_bank]/entity/customer_reference[reference=$appl_ref]/description"/>
									     </xsl:when>
									     <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) = 0">
									     		<xsl:value-of select="//*/avail_main_banks/bank[abbv_name = $iss_bank]/customer_reference[reference=$appl_ref]/description"/>
									     </xsl:when>
									</xsl:choose> -->
									<xsl:choose>
	      							<xsl:when test="security:isBank($rundata)">
      									<xsl:value-of select="//*/customer_references/customer_reference[reference=$appl_ref]/description"/>
    	 							</xsl:when>
	    	 						<xsl:otherwise>
	    	 							<xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]/description"/>
	    	 						</xsl:otherwise>
    					</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!--Beneficiary Details-->
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
						    	<xsl:choose>
								   <xsl:when test="//*/cross_references/cross_reference[product_code='EL']"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS_BUYER')"/></xsl:when>
								   <xsl:when test="//*/cross_references/cross_reference[product_code='LC']"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS_TRANS_COMP')"/></xsl:when>
							  	   <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')"/></xsl:otherwise>  
								</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_TYPE_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:if test="bene_type_code[. = '01']">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_TYPE_01_SHIPPER')"/>
              </xsl:if>
        					<xsl:if test="bene_type_code[. = '02']">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_TYPE_02_BUYER')"/>
              </xsl:if>
        					<xsl:if test="bene_type_code[. = '99']">
                <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_TYPE_99_OTHER')"/>
              </xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="bene_type_other[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bene_type_other"/>
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
					<!-- Adress -->
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
				</xsl:with-param>
			</xsl:call-template>
			<!--Bank Details-->
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
				   <xsl:apply-templates select="issuing_bank">
						<xsl:with-param name="theNodeName" select="'issuing_bank'"/>
						<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language,'XSL_BANKDETAILS_TAB_ISSUING_BANK')"/>
					</xsl:apply-templates>
				</xsl:with-param>
			</xsl:call-template>
			<!--Amount Details-->
			
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
							<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_LI_AMT_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="li_cur_code"/> 
							<xsl:value-of select="li_amt"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="li_liab_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="li_cur_code"/> 
								<xsl:value-of select="li_liab_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>

			<!--Letter of Indemnity Details-->
			<fo:block id="lidetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LI_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_COUNTERSIGNATURE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="countersign_flag[. = 'Y']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/>
								</xsl:when>
								<xsl:when test="countersign_flag[. = 'N']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/>
								</xsl:when>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="shipping_by[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_CARRIER_NAME')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="shipping_by"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="trans_doc_type_code[.!='']">
						<xsl:variable name="doc_type_code">
              <xsl:value-of select="trans_doc_type_code"/>
            </xsl:variable>
						<xsl:variable name="productCode">
              <xsl:value-of select="product_code"/>
            </xsl:variable>
						<xsl:variable name="parameterId">C014</xsl:variable>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRANS_DOC_TYPE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $doc_type_code)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="trans_doc_type_other[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="right_text">
								<xsl:value-of select="trans_doc_type_other"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="bol_number[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRANS_DOC_REF')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bol_number"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="bol_date[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRANS_DOC_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bol_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<!--Description Goods-->
			<fo:block id="descriptiongoods"/>
				<fo:block linefeed-treatment="preserve" white-space-collapse="false" white-space="pre">
				<fo:table font-family="{$pdfFont}" width="{$pdfTableWidth}">
					<fo:table-column column-width="{$pdfTableWidth}"/>
					<fo:table-column column-width="0"/>
					<fo:table-body>
						<xsl:call-template name="title2">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DESCRIPTION_GOODS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LABEL_DESCRIPTION_GOODS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<fo:table-row>
							<fo:table-cell>
								<fo:block space-before.optimum="10.0pt" start-indent="20.0pt">
									<xsl:value-of select="narrative_description_goods"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			
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