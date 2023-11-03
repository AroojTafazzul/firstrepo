<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright (c) 2006-2012 Misys , All Rights Reserved -->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:localization="xalan://com.misys.portal.common.localization.Localization" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:utils="xalan://com.misys.portal.common.tools.Utils" version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	
	<xsl:import href="settlement_common.xsl"/>

	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>

	<xsl:template match="fx_tnx_record">
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

			<fo:block id="generalDetails"/>
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
					<!-- bo_ref_id -->
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

					<!--product code -->
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_CODE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="localization:getGTPString($language,concat('TOPMENU_', product_code))"/>
						</xsl:with-param>
					</xsl:call-template>

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

			<xsl:if test="applicant_name[.!=''] or applicant_address_line_1[.!=''] or applicant_address_line_2[.!=''] or applicant_dom[.!=''] or applicant_reference[.!='']">
				<!--Applicant Details -->
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

			<!-- </fo:block> -->
			<!--Bank Details -->
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
				</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="tnx_type_code[.!='13'] or prod_stat_code[. ='03']">
			<fo:block id="contractDetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONTRACT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_TYPE_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="localization:getGTPString($language, concat('FX_CONTRACT_TYPE_', sub_product_code))"/>
						</xsl:with-param>
					</xsl:call-template>


					<!-- Purchase/Sale -->
					<xsl:if test="contract_type[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="contract_type[. = '01']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_PURCHASE_LABEL')"/>
									</xsl:when>
									<xsl:when test="contract_type[. = '02']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_SALE_LABEL')"/>
									</xsl:when>
									<xsl:when test="contract_type[. = '03']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_CONTACT_LABEL')"/>
									</xsl:when>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>

					<xsl:if test="original_amt[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_ORG_CUR_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="fx_cur_code"/> <xsl:value-of select="original_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>

					<xsl:if test="fx_cur_code[.!= ''] and fx_amt[.!= '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_AMOUNT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="fx_cur_code"/> <xsl:value-of select="fx_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>

					<xsl:if test="rate[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_RATE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="rate"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>

					<xsl:if test="counter_cur_code[. != ''] or counter_amt[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_REMAINING_COUNTER_AMT')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="counter_cur_code"/> <xsl:value-of select="counter_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>

					<!-- option date -->
					<xsl:if test="option_date[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_OPTION_DATE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="option_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
					<!-- value date -->
					<xsl:if test="value_date[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_VALUE_DATE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="value_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
				<xsl:if test="remarks[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_REMARKS')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="remarks"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
 
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
			
			<!-- <xsl:if test="hasDDA[.='Y']"> -->
			<xsl:if test="(count(counterparties/counterparty[counterparty_type='04'])and (counterparties/counterparty/counterparty_act_no[.!=''] or counterparties/counterparty/counterparty_name[.!=''])) or (count(counterparties/counterparty[counterparty_type='03'])and (counterparties/counterparty/counterparty_act_no[.!=''] or counterparties/counterparty/counterparty_name[.!=''])) or count(counterparties/counterparty[counterparty_type='02'])">
			<xsl:call-template name="settlement-details"/>
			</xsl:if>
			
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
				<fo:block color="#00aeef" text-align="start">
					<xsl:attribute name="end-indent">
            <xsl:value-of select="number($pdfMargin)"/>pt</xsl:attribute>
					<xsl:value-of select="convertTools:internalDateToStringDate($systemDate,$language)"/>
				</fo:block>
			</fo:block>
		</fo:static-content>
  </xsl:template>
</xsl:stylesheet>
