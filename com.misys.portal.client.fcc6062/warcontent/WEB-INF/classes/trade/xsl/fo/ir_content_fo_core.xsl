<?xml version="1.0" encoding="UTF-8"?>
<!--
		Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com), All
		Rights Reserved.
	-->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:localization="xalan://com.misys.portal.common.localization.Localization" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:utils="xalan://com.misys.portal.common.tools.Utils" version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>

	<xsl:template match="ir_tnx_record">
		<!-- HEADER First page-->
		
		<!-- FOOTER-->
		
		<!-- BODY-->
		
	<xsl:call-template name="header"/>
    <xsl:call-template name="footer"/>
    <xsl:call-template name="body"/>
  </xsl:template>
<xsl:template name="header">
    <fo:static-content flow-name="xsl-region-before">
			<xsl:call-template name="header_remitting_bank"/>
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
                                         <xsl:value-of select="ref_id" />
                                  </xsl:with-param>
                           </xsl:call-template>
                           </xsl:if>
                       <xsl:if test="cust_ref_id[.!='']">
                                  <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">                                    
                                                              <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')" />
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="cust_ref_id" />
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
					<!-- bo_ref_id -->
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
					<xsl:if test="appl_date[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CREATION_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="appl_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="ir_type_code[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TYPE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="ir_type_code[. = '01']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TYPE_IR')"/>
									</xsl:when>
									<xsl:when test="ir_type_code[. = '02']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TYPE_IR_CHEQUE')"/>
									</xsl:when>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="remittance_date[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IR_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="remittance_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>

					<!--
						<fo:table-row keep-with-previous="always"> <fo:table-cell>
						<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
						<xsl:value-of select="localization:getGTPString($language,
						'IR_INSTRUCTIONS_REQUIRED_LABEL')"/> </fo:block> </fo:table-cell>
						<fo:table-cell> <fo:block font-weight="bold"> <xsl:if
						test="instructions_required[.!='']"> <xsl:choose> <xsl:when
						test="instructions_required[. = 'Y']"> <xsl:value-of
						select="localization:getGTPString($language, 'XSL_YES')"/>
						</xsl:when> <xsl:when test="instructions_required[. = 'N']">
						<xsl:value-of select="localization:getGTPString($language,
						'XSL_NO')"/> </xsl:when> </xsl:choose> </xsl:if> </fo:block>
						</fo:table-cell> </fo:table-row>
					-->

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
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="beneficiary_name"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test = "beneficiary_abbv_name!=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ABBV_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="beneficiary_abbv_name"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
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
			<!--Remitter Details-->
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REMITTER_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="remitter_name"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="remitter_address_line_1"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="remitter_address_line_2[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="remitter_address_line_2"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="remitter_dom[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="remitter_dom"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="remitter_reference[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="utils:decryptApplicantReference(remitter_reference)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
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
					<!--Collection Currency and Amount-->

					<fo:table-row keep-with-previous="always">
						<fo:table-cell>
							<fo:block font-family="{$pdfFont}" space-before.conditionality="retain" space-before.optimum="10.0pt" start-indent="20.0pt">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_COLL_AMT_LABEL')"/>
							</fo:block>
						</fo:table-cell>
						<xsl:if test="(ir_cur_code[.!='']) or (ir_amt[.!=''])">
							<fo:table-cell>
								<fo:block font-weight="bold" space-before.conditionality="retain" space-before.optimum="10.0pt">
									<xsl:value-of select="ir_cur_code"/>
									<fo:inline space-start="10.0pt">
                    <xsl:value-of select="ir_amt"/>
                  </fo:inline>
								</fo:block>
							</fo:table-cell>
						</xsl:if>
					</fo:table-row>
					<fo:table-row keep-with-previous="always">
						<fo:table-cell>
							<fo:block font-family="{$pdfFont}" start-indent="20.0pt">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_AMT_LABEL')"/>
							</fo:block>
						</fo:table-cell>
						<xsl:if test="(ir_cur_code[.!='']) or (ir_liab_amt[.!=''])">
							<fo:table-cell>
								<fo:block font-weight="bold">
									<xsl:value-of select="ir_cur_code"/>
									<xsl:text> </xsl:text>
                  <xsl:value-of select="ir_liab_amt"/>
								</fo:block>
							</fo:table-cell>
						</xsl:if>
					</fo:table-row>
				</xsl:with-param>
			</xsl:call-template>
			<!--Remittance bank Details-->
			<fo:block id="remittancebankdetail"/>
			<xsl:if test="remitting_bank/name[.!='']">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_INWARD_REMITTANCE_TAB_REMITTANCE_BANK')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="remitting_bank/name[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="remitting_bank/name"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:if test="remitting_bank/address_line_1[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="remitting_bank/address_line_1"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
					 <xsl:if test="remitting_bank/address_line_2[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="remitting_bank/address_line_2"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="remitting_bank/dom[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="remitting_bank/dom"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			<!--Issuing bank Details-->
			<fo:block id="issuingbankdetail"/>
			<xsl:if test="issuing_bank/name[.!='']">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_INWARD_REMITTANCE_TAB_ISSUING_BANK')"/>
						</xsl:with-param>
					</xsl:call-template>
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
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			<!--Payamentdetails Details-->
			<fo:block id="payamentdetails"/>
			<xsl:if test="narrative_payment_details[.!='']">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PAYMENT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="narrative_payment_details"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			<!--Settlement Details-->
			<fo:block id="settlementdetails"/>
			<xsl:if test="act_no[.!=''] or fwd_contract_no[.!='']">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SETTLEMENT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="act_no[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_NO')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="act_no"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
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
