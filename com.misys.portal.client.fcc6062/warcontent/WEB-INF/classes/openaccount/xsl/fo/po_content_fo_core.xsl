<?xml version="1.0" encoding="UTF-8"?>
<!--
   Copyright (c) 2000-2007 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved.
-->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:localization="xalan://com.misys.portal.common.localization.Localization" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
	<xsl:import href="po_fo_common_new.xsl"/>

	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>
  	
	
	<xsl:template match="po_tnx_record">
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
        	
			<fo:block id="gendetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- ref id -->
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
					<!-- PO ref id -->
					<xsl:if test="issuer_ref_id[. != '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_PO_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="issuer_ref_id"/>
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
					<!-- template_id -->
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
					<!--application Date -->
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="appl_date"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- issue date -->
					<xsl:if test="iss_date != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ISSUE_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="iss_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- amendment number -->
					<xsl:if test="amd_no[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_AMD_COUNT')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="amd_no"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>

			<!-- Applicant Details-->
			<xsl:call-template name="spacer_template"/>
			<fo:block id="applicantdetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BUYER_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="buyer_name != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:call-template name="zero_width_space_1">
									<xsl:with-param name="data" select="buyer_name"/>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="buyer_bei != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="buyer_bei"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="buyer_street_name != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:call-template name="zero_width_space_1">
									<xsl:with-param name="data" select="buyer_street_name"/>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="buyer_post_code != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="buyer_post_code"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="buyer_town_name != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="buyer_town_name"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="buyer_country_sub_div != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="buyer_country_sub_div"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="buyer_country != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="buyer_country"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- Display Entity -->
					<xsl:if test="entity != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ENTITY')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="entity"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="buyer_reference != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:variable name="buyer_ref"><xsl:value-of select="buyer_reference"/></xsl:variable>
								<xsl:variable name="tempCount"><xsl:value-of select="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$buyer_ref])" /></xsl:variable>
								<xsl:choose>
                                       <xsl:when test="$tempCount >= 1">
                                              <xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$buyer_ref]/description"/>
                                       </xsl:when>
                                       <xsl:when test="$tempCount = 0">
                                              <xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$buyer_ref]/description"/>
                                       </xsl:when>
                               	</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>

			<!-- Seller Details-->
			<xsl:call-template name="spacer_template"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SELLER_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="seller_name != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:call-template name="zero_width_space_1">
									<xsl:with-param name="data" select="seller_name"/>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="seller_bei != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="seller_bei"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="seller_street_name != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:call-template name="zero_width_space_1">
									<xsl:with-param name="data" select="seller_street_name"/>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="seller_post_code != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="seller_post_code"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="seller_town_name != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="seller_town_name"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="seller_country_sub_div != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="seller_country_sub_div"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="seller_country != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="seller_country"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>

			<!-- Bill To Details-->
			<xsl:call-template name="spacer_template"/>
			<xsl:if test="bill_to_name != ''">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BILL_TO_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="bill_to_name != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:call-template name="zero_width_space_1">
										<xsl:with-param name="data" select="bill_to_name"/>
									</xsl:call-template>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="bill_to_bei != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="bill_to_bei"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="bill_to_street_name != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:call-template name="zero_width_space_1">
										<xsl:with-param name="data" select="bill_to_street_name"/>
									</xsl:call-template>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="bill_to_post_code != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="bill_to_post_code"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="bill_to_town_name != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="bill_to_town_name"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="bill_to_country_sub_div != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="bill_to_country_sub_div"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="bill_to_country != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="bill_to_country"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<!-- Ship To Details-->
			<xsl:call-template name="spacer_template"/>
			<xsl:if test="ship_to_name != ''">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SHIP_TO_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="ship_to_name != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:call-template name="zero_width_space_1">
										<xsl:with-param name="data" select="ship_to_name"/>
									</xsl:call-template>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="ship_to_bei != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ship_to_bei"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="ship_to_street_name != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:call-template name="zero_width_space_1">
										<xsl:with-param name="data" select="ship_to_street_name"/>
									</xsl:call-template>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="ship_to_post_code != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ship_to_post_code"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="ship_to_town_name != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ship_to_town_name"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="ship_to_country_sub_div != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ship_to_country_sub_div"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="ship_to_country != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ship_to_country"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<!-- Consignee Details-->
			<xsl:call-template name="spacer_template"/>
			<xsl:if test="consgn_name != ''">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CONSIGNEE_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="consgn_name != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:call-template name="zero_width_space_1">
										<xsl:with-param name="data" select="consgn_name"/>
									</xsl:call-template>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="consgn_bei != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_BEI')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="consgn_bei"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="consgn_street_name != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:call-template name="zero_width_space_1">
										<xsl:with-param name="data" select="consgn_street_name"/>
									</xsl:call-template>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="consgn_post_code != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="consgn_post_code"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="consgn_town_name != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="consgn_town_name"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="consgn_country_sub_div != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="consgn_country_sub_div"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="consgn_country != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="consgn_country"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<!-- Description of Goods / Line Items-->
			<fo:block id="lineitemdetails"/>
			<xsl:if test="count(line_items/lt_tnx_record) != 0 or goods_desc[.!='']">
			
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DESCRIPTION_GOODS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="goods_desc != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_GOODS_DESC')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:call-template name="zero_width_space_1">
										<xsl:with-param name="data" select="goods_desc"/>
									</xsl:call-template>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="total_cur_code"/> <xsl:value-of select="total_amt"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="liab_total_amt != ''">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_AMT_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="liab_total_cur_code"/> <xsl:value-of select="liab_total_amt"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				
				<xsl:if test="part_ship != '' or part_ship != '' or last_ship_date != '' or earliest_ship_date != '' or tran_ship != ''">
				<fo:block id="shipment-details"/>
						<xsl:call-template name="spacer_template"/>
							<xsl:call-template name="table_template">
								<xsl:with-param name="text">
									<xsl:call-template name="subtitle">
										<xsl:with-param name="text">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SHIPMENT_DETAILS')"/>
										</xsl:with-param>
									</xsl:call-template>
									<xsl:if test="part_ship != ''">
										<xsl:call-template name="table_cell">
											<xsl:with-param name="left_text">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_LABEL')"/>
											</xsl:with-param>
											<xsl:with-param name="right_text">
												<xsl:choose>
													<xsl:when test="part_ship = 'Y'">
			                      						<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/>
			                    					</xsl:when>
													<xsl:when test="part_ship = 'N'">
			                      						<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/>
			                    					</xsl:when>
													<xsl:otherwise/>
												</xsl:choose>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test="tran_ship != ''">
										<xsl:call-template name="table_cell">
											<xsl:with-param name="left_text">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL')"/>
											</xsl:with-param>
											<xsl:with-param name="right_text">
												<xsl:choose>
													<xsl:when test="tran_ship = 'Y'">
			                      						<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/>
								                    </xsl:when>
													<xsl:when test="tran_ship = 'N'">
								                      <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/>
								                    </xsl:when>
													<xsl:otherwise/>
												</xsl:choose>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test="earliest_ship_date != ''">
										<xsl:call-template name="table_cell">
											<xsl:with-param name="left_text">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_EARLIEST_SHIP_DATE')"/>
											</xsl:with-param>
											<xsl:with-param name="right_text">
												<xsl:value-of select="earliest_ship_date"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test="last_ship_date != ''">
										<xsl:call-template name="table_cell">
											<xsl:with-param name="left_text">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_LAST_SHIP_DATE')"/>
											</xsl:with-param>
											<xsl:with-param name="right_text">
												<xsl:value-of select="last_ship_date"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
				<xsl:apply-templates select="line_items"/>

			</xsl:if>

			<!--Amount Details-->
			<fo:block id="amountdetails"/>
			
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>			

			<!-- Adjustments Details -->
			<xsl:if test="count(adjustments/adjustment) != 0">
				<xsl:apply-templates select="adjustments">
					<xsl:with-param name="isSubItem">Y</xsl:with-param>
				</xsl:apply-templates>
			</xsl:if>
			
			<!-- Taxes Details -->
			<xsl:if test="count(taxes/tax) != 0">
				<xsl:call-template name="spacer_template"/>
				<xsl:apply-templates select="taxes">
					<xsl:with-param name="isSubItem">Y</xsl:with-param>
				</xsl:apply-templates>
			</xsl:if>

			<!-- Freight Charges Details -->
			<xsl:if test="count(freightCharges/freightCharge) != 0">
				<xsl:call-template name="spacer_template"/>
				<xsl:apply-templates select="freightCharges">
					<xsl:with-param name="isSubItem">Y</xsl:with-param>
				</xsl:apply-templates>
			</xsl:if>

			<xsl:call-template name="spacer_template"/>
			
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_PO_TOTAL_NET_AMT_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="total_net_cur_code"/> <xsl:value-of select="total_net_amt"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="liab_total_net_amt != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_NET_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="liab_total_net_cur_code"/> <xsl:value-of select="liab_total_net_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>			


			<!-- Payment Terms -->
			<fo:block id="paymenttermsdetails"/>
			<xsl:if test="count(payments/payment) &gt; 0">
				<xsl:apply-templates select="payments"/>
			</xsl:if>
	
			<!--Settlement Terms Details-->
			<fo:block id="settlementtermsdetails"/>
			
<!-- 			<xsl:if test="seller_account_type != '' or fin_inst_name != '' or fin_inst_bic != ''"> -->
			<xsl:if test="seller_account_name != '' or seller_account_iban != '' or  seller_account_bban != '' or  seller_account_upic != '' or  seller_account_id != '' or fin_inst_name != '' or fin_inst_bic != ''">
				<!-- Seller Account -->
				<xsl:if test="seller_account_iban != '' or  seller_account_bban != '' or  seller_account_upic != '' or  seller_account_id != ''">
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SETTLEMENT_TERMS_DETAILS')"/>
								</xsl:with-param>
							</xsl:call-template>
							
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_SELLER_ACCOUNT')"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="seller_account_iban != ''">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN')"/>
										</xsl:when>
										<xsl:when test="seller_account_bban != ''">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_BBAN')"/>
										</xsl:when>
										<xsl:when test="seller_account_upic != ''">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_UPIC')"/>
										</xsl:when>
										<xsl:when test="seller_account_id != ''">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ACCOUNT_TYPE_OTHER')"/>
										</xsl:when>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
	
							<xsl:if test="seller_account_name != ''">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:call-template name="zero_width_space_1">
											<xsl:with-param name="data" select="seller_account_name"/>
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
	
							<xsl:if test="seller_account_iban != '' or seller_account_bban != '' or seller_account_upic != '' or seller_account_id != ''">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_SELLER_ACCOUNT_NUMBER')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:choose>
											<xsl:when test="seller_account_iban != ''">
						                        <xsl:value-of select="seller_account_iban"/>
						                      </xsl:when>
											<xsl:when test="seller_account_bban != ''">
						                        <xsl:value-of select="seller_account_bban"/>
						                      </xsl:when>
											<xsl:when test="seller_account_upic != ''">
						                        <xsl:value-of select="seller_account_upic"/>
						                      </xsl:when>
											<xsl:when test="seller_account_id != ''">
						                        <xsl:value-of select="seller_account_id"/>
						                      </xsl:when>
										</xsl:choose>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
						
				<!-- Financial institution -->
				<xsl:if test="fin_inst_name != '' or fin_inst_bic != ''">
					<xsl:call-template name="spacer_template"/>
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_FINANCIAL_INSTITUTION')"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="fin_inst_name != ''">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_NAME')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:call-template name="zero_width_space_1">
											<xsl:with-param name="data" select="fin_inst_name"/>
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="fin_inst_bic != ''">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BIC_CODE')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="fin_inst_bic"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="fin_inst_street_name != ''">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_STREET')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:call-template name="zero_width_space_1">
											<xsl:with-param name="data" select="fin_inst_street_name"/>
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="fin_inst_post_code != ''">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_POST_CODE')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="fin_inst_post_code"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="fin_inst_town_name != ''">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_TOWN')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="fin_inst_town_name"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="fin_inst_country_sub_div != ''">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="fin_inst_country_sub_div"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="fin_inst_country != ''">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PO_PARTIESDETAILS_COUNTRY')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="fin_inst_country"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:with-param>
					</xsl:call-template>			
				</xsl:if>
			</xsl:if>

			<xsl:call-template name="spacer_template"/>
			
			<!-- Documents required -->
			<fo:block id="documentsrequireddetails"/>

			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="reqrd_commercial_dataset != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_COMMERCIAL_DATASET')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="reqrd_commercial_dataset[.='Y']">
					                    <xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_COMMERCIAL_DATASET_REQUIRED')"/>
					                  </xsl:when>
									<xsl:when test="reqrd_commercial_dataset[.='N']">
					                    <xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_COMMERCIAL_DATASET_NOT_REQUIRED')"/>
					                  </xsl:when>
									<xsl:otherwise/>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="reqrd_transport_dataset != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_TRANSPORT_DATASET')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="reqrd_transport_dataset[.='Y']">
					                    <xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_TRANSPORT_DATASET_REQUIRED')"/>
					                  </xsl:when>
									<xsl:when test="reqrd_transport_dataset[.='N']">
					                    <xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_TRANSPORT_DATASET_NOT_REQUIRED')"/>
					                  </xsl:when>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="last_match_date != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_LAST_MATCH_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="last_match_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>

			<!-- Incoterms -->
			<xsl:apply-templates select="incoterms"/>
			
			<!-- Routing Summary details -->
			<xsl:if test="routing_summaries/air_routing_summaries/rs_tnx_record or routing_summaries/sea_routing_summaries/rs_tnx_record or routing_summaries/rail_routing_summaries/rs_tnx_record or routing_summaries/road_routing_summaries/rs_tnx_record">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ROUTING_SUMMARY_IND_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:apply-templates select="routing_summaries/air_routing_summaries/rs_tnx_record | routing_summaries/sea_routing_summaries/rs_tnx_record | routing_summaries/rail_routing_summaries/rs_tnx_record | routing_summaries/road_routing_summaries/rs_tnx_record">
					<xsl:with-param name="subItem">N</xsl:with-param>
				</xsl:apply-templates>
			</xsl:if>
			<xsl:if test="routing_summaries/rs_tnx_record">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ROUTING_SUMMARY_MULTIMODAL_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:apply-templates select="routing_summaries/rs_tnx_record">
					<xsl:with-param name="subItem">N</xsl:with-param>
				</xsl:apply-templates>
			</xsl:if>

			<!-- Users Informations Details -->             			     		  
		  	<xsl:apply-templates select="user_defined_informations"/>	

			<!--Contact Person Details-->
			<xsl:apply-templates select="contacts"/>								  		  

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
					<!-- <xsl:value-of select="localization:getGTPString($language, 'XSL_FO_PAGE')" />&nbsp; -->
					<fo:page-number/> /
					<!-- &nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_FO_OF')" />&nbsp; -->
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
