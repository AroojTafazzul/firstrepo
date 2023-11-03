<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<!-- Copyright (c) 2006-2012 Misys , All Rights Reserved -->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" 
				xmlns:formatter="xalan://com.misys.portal.common.tools.ConvertTools"
				xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
				xmlns:fo="http://www.w3.org/1999/XSL/Format" 
				xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
				xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
				xmlns:security="xalan://com.misys.portal.security.GTPSecurity" 
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils" 
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
				xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>
	<xsl:variable name="background">
		BLACK
	</xsl:variable>
	<xsl:param name="sender-reference-name">applicant_reference</xsl:param>
	<xsl:param name="main-bank-name">issuing_bank</xsl:param>
	<xsl:variable name="sender-reference-value">
	    <xsl:choose>
	     <!-- current customer reference not null (draft) -->
	     <xsl:when test="//*[name()=$sender-reference-name] != ''">
	       <xsl:value-of select="//*[name()=$sender-reference-name]"/>
	     </xsl:when>
	     <!-- not entity defined and only one bank and only one customer reference available -->
	     <xsl:when test="entities[.= '0']">
	       <xsl:if test="count(avail_main_banks/bank/customer_reference)=1">
	         <xsl:value-of select="avail_main_banks/bank/customer_reference/reference"/>
	       </xsl:if>
	     </xsl:when>
	     <!-- only one entity, only one bank and only one customer reference available -->
	     <xsl:otherwise>
	       <xsl:if test="count(avail_main_banks/bank/entity/customer_reference)=1">
	         <xsl:value-of select="avail_main_banks/bank/entity/customer_reference/reference"/>
	       </xsl:if>          
	     </xsl:otherwise>
	    </xsl:choose>
   	</xsl:variable>
   	<xsl:variable name="main_bank_abbv_name_value">
   	 <xsl:value-of select="//*[name()=$main-bank-name]/abbv_name"/>
   </xsl:variable>

	<xsl:template match="tf_tnx_record">
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

					<xsl:if test="not(tnx_id) or (tnx_type_code[.!='01'] and tnx_type_code[.!='13'] and tnx_type_code[.!='15']) or preallocated_flag[.='Y']"><!--201708 changes added code for Existing records  -->
			 <fo:block id="evedetails_tf" />
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_EVENT_DETAILS')" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="company_name[.!=''] or product_code[.='TF']">
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
					<xsl:if test="sub_product_code[.!=''] and product_code[.='TF']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_LABEL')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of
									select="localization:getDecode($language, 'N047', sub_product_code[.])" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="ref_id" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="cust_ref_id[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="cust_ref_id" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="cross_references/cross_reference/child_product_code[.!='IP' and .!='IN' and .!='PO' and .!='SO'] and (cross_references/cross_reference/child_ref_id=ref_id and cross_references/cross_reference/ref_id != cross_references/cross_reference/child_ref_id)"> 
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ANCESTOR_LINKED_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="cross_references/cross_reference/ref_id"/> (<xsl:value-of select="localization:getDecode($language, 'N043', cross_references/cross_reference/type_code)"/>)
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
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
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="tnx_stat_code[.='04'] or security:isBank($rundata)">
			<xsl:call-template name="table_template">
			<xsl:with-param name="text">
			<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_BANK_MESSAGE')" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_PROD_STAT_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="localization:getDecode($language, 'N005', prod_stat_code[.])"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="bo_ref_id"/>
						</xsl:with-param>
					</xsl:call-template>	
			</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			</xsl:if>
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
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_COMPANY_NAME')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="company_name"/><!-- 20170807_01 -->
                                         </xsl:with-param>
                                  </xsl:call-template>                            
                                  <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_CODE')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of
                                                select="localization:getDecode($language, 'N001', product_code[.])" />
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
                                  <xsl:if test="tnx_type_code[.!='']">
                                  	<xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_TRANSACTION_TYPE')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                       		<xsl:choose>
                                            	<xsl:when test="tnx_type_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_01_NEW')"/></xsl:when>
                                            	<xsl:when test="tnx_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_02_UPDATE')"/></xsl:when>
                                            	<xsl:when test="tnx_type_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_03_AMEND')"/></xsl:when>
                                            	<xsl:when test="tnx_type_code[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_04_EXTEND')"/></xsl:when>
                                            	<xsl:when test="tnx_type_code[. = '05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_05_ACCEPT')"/></xsl:when>
                                            	<xsl:when test="tnx_type_code[. = '06']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_06_CONFIRM')"/></xsl:when>
                                             	<xsl:when test="tnx_type_code[. = '07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_07_CONSENT')"/></xsl:when>
                                             	<xsl:when test="tnx_type_code[. = '08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_08_SETTLE')"/></xsl:when>
                                             	<xsl:when test="tnx_type_code[. = '09']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_09_TRANSFER')"/></xsl:when>
                                            	<xsl:when test="tnx_type_code[. = '10']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_10_DRAWDOWN')"/></xsl:when>
                                             	<xsl:when test="tnx_type_code[. = '11']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_11_REVERSE')"/></xsl:when>
                                             	<xsl:when test="tnx_type_code[. = '12']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_12_DELETE')"/></xsl:when>
                                             	<xsl:when test="tnx_type_code[. = '13']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_13_INQUIRE')"/></xsl:when>
                                             	<xsl:when test="tnx_type_code[. = '14']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_14_CANCEL')"/></xsl:when>
                                             	<xsl:when test="tnx_type_code[. = '15']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_15_REPORTING')"/></xsl:when>
                                            	<xsl:when test="tnx_type_code[. = '16']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_16_REINSTATE')"/></xsl:when>
                                                <xsl:when test="tnx_type_code[. = '17']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_17_PURGE')"/></xsl:when>
                                                <xsl:when test="tnx_type_code[. = '18']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_18_PRESENT')"/></xsl:when>
                                                <xsl:when test="tnx_type_code[. = '19']"><xsl:value-of select="localization:getGTPString($language, 'XSL_TNXTYPECODE_19_ASSIGN')"/></xsl:when>
											</xsl:choose>
                                            <xsl:if test="sub_tnx_type_code[. != '']">&nbsp;
                                                <xsl:choose>
                                                	<xsl:when test="sub_tnx_type_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_01_INCREASE')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_02_DECREASE')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_03_TERMS')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_04_UPLOAD')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_05_RELEASE')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '06']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_06_BACK_TO_BACK')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_07_GENERATION')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_08_DISCREPANT_ACK')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '09']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_09_DISCREPANT_NACK')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '11']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '16']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '65']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '66']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '67']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '96']">(<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code)"/>)</xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '88']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_88_WORDING_ACK')"/></xsl:when>
                                                	<xsl:when test="sub_tnx_type_code[. = '89']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXTYPECODE_89_WORDING_NACK')"/></xsl:when>
                                                </xsl:choose>
											</xsl:if>
                                         </xsl:with-param>
                                  	</xsl:call-template>
                                  </xsl:if>
                                  <xsl:if test="release_dttm[.!='']">
                                   <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_RELEASE_DTTM')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="formatter:formatReportDate(release_dttm,$rundata)" />
                                         </xsl:with-param>
                                  </xsl:call-template>
                                  </xsl:if>
                                  <xsl:if test="tnx_type_code[.='03']">
                                  <xsl:if test="amd_no[.!='']">
                                   <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_AMD_NO')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="amd_no" />
                                         </xsl:with-param>
                                  </xsl:call-template>
                                  </xsl:if>
                                  <xsl:if test="amd_date[.!='']">
                                   <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_AMD_DATE')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="amd_date" />
                                         </xsl:with-param>
                                  </xsl:call-template>
                                  </xsl:if>
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
                                  </xsl:with-param>
                     </xsl:call-template>
                     <fo:block id="reportdetails"/>
					 <xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REPORTING_DETAILS')"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="prod_stat_code[.!=''] and (not(tnx_id) or tnx_type_code[.='15'])">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_NEW_TNX_STAT_LABEL')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="localization:getDecode($language, 'N005', prod_stat_code[.])"/>
 									</xsl:with-param>
								</xsl:call-template> 
							</xsl:if>
							<xsl:if test="prod_stat_code[.!=''] and tnx_type_code[.!='15']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_NEW_TNX_STAT_LABEL')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:choose>
											<xsl:when test="prod_stat_code[.='01']"><xsl:value-of select="localization:getGTPString($language,'XSL_PRODSTATCODE_01_REJECTED')"/></xsl:when>
											<xsl:when test="prod_stat_code[ .='76']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_APPROVED')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_03_NEW')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_04_ACCEPTED')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_05_SETTLED')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_07_UPDATED')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_08_AMENDED')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='11']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_11_RELEASED')"/></xsl:when>	
											<xsl:when test="prod_stat_code[.='78']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_78_WORDING_UNDER_REVIEW')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='79']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_79_FINAL_WORDING')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='18']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_18_INPROGRESS')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXSTATCODE_05_STOPOVER_TO_SENT')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='98']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_98_PROVISIONAL')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='14']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_14_PART_SIGHT_PAYMT')"/></xsl:when>
											<xsl:when test="prod_stat_code[.='15']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_15_FULL_SIGHT_PAYMT')"/></xsl:when>
										</xsl:choose>
									</xsl:with-param>
								</xsl:call-template> 
							</xsl:if>
							<xsl:if test="doc_ref_no[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_DOC_REF_NO')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="doc_ref_no"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="claim_reference[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_CLAIM_REFERENCE_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="claim_reference" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="claim_present_date[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_CLAIM_PRESENT_DATE_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="claim_present_date" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="claim_amt[.!=''] and claim_cur_code[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_CLAIM_AMOUNT_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="claim_cur_code" />&nbsp;<xsl:value-of select="claim_amt" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>						
							<xsl:if test="bo_ref_id[.!=''] and tnx_type_code[.!='03'] and tnx_type_code[.!='15']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="bo_ref_id"/>
                                    </xsl:with-param>
                             </xsl:call-template>  
                             </xsl:if>
                                  <xsl:if test="release_dttm[.!='']">
                                   <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_RELEASE_DTTM')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="formatter:formatReportDate(release_dttm,$rundata)" />
                                         </xsl:with-param>
                                  </xsl:call-template>
                                  </xsl:if>
                             <xsl:if test="release_amt[.!=''] and tnx_type_code[.='03'] and sub_tnx_type_code[.='05']">
                             	<xsl:call-template name="table_cell">
                             		<xsl:with-param name="left_text">
                             			<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_SI_RELEASE_AMT_LABEL')"/>
                             		</xsl:with-param>
                             		<xsl:with-param name="right_text">
                             			<xsl:value-of select="release_amt"/>
                                    </xsl:with-param>
                                </xsl:call-template>
                             </xsl:if>
                             <xsl:if test="action_req_code[.!='']">
                             <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ACTION_REQUIRED')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                         <xsl:choose>
          <xsl:when test="action_req_code[.='99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CUSTOMER_INSTRUCTIONS')"/></xsl:when>
          <xsl:when test="action_req_code[.='12']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_DISCREPANCY_RESPONSE')"/></xsl:when>
          <xsl:when test="action_req_code[.='26']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CLEAN_RESPONSE')"/></xsl:when>
          <xsl:when test="action_req_code[.='07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CONSENT_RESPONSE')"/></xsl:when>
          <xsl:when test="action_req_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_AMENDMENT_RESPONSE')"/></xsl:when>
          <xsl:when test="action_req_code[.='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REQUIRED_CANCEL_RESPONSE')"/></xsl:when>
         </xsl:choose>
                                    </xsl:with-param>
                             </xsl:call-template>
                             </xsl:if>
                          </xsl:with-param>
                     </xsl:call-template>
				    <xsl:if test="bo_comment[.!='']">
		<fo:block linefeed-treatment="preserve" white-space-collapse="false" white-space="pre">
		           <fo:table width="{$pdfTableWidth}"
					font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
					<fo:table-column column-width="{$pdfTableWidth}" />
					<fo:table-column column-width="0"/>
					<fo:table-body>
						<xsl:call-template name="subtitle2">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language,'XSL_REPORTINGDETAILS_COMMENT')" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell2">
							<xsl:with-param name="text">
								<xsl:value-of select="bo_comment"/>
							</xsl:with-param>
						</xsl:call-template>
					</fo:table-body>
				</fo:table>
			</fo:block>
			</xsl:if>
			<xsl:if test="count(charges/charge[created_in_session = 'Y']) != 0">
						<xsl:call-template name="table_template">
							<xsl:with-param name="text">
								<xsl:call-template name="title">
									<xsl:with-param name="text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PRODUCT_CHARGE_DETAILS')" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:for-each select="charges/charge[created_in_session = 'Y' and chrg_code != 'OTHER']">
							<xsl:call-template name="CHARGE" />
						</xsl:for-each>
						<xsl:for-each select="charges/charge[created_in_session = 'Y' and chrg_code = 'OTHER']">
							<xsl:call-template name="CHARGE" />
						</xsl:for-each>
						</xsl:if>
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
					<!-- Details of ancestors -->
				   <xsl:if test="cross_references/cross_reference/child_product_code[.!='IP' and .!='IN' and .!='PO' and .!='SO'] and (cross_references/cross_reference/child_ref_id=ref_id and cross_references/cross_reference/ref_id != cross_references/cross_reference/child_ref_id)"> 
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ANCESTOR_LINKED_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="cross_references/cross_reference/ref_id"/> (<xsl:value-of select="localization:getDecode($language, 'N043', cross_references/cross_reference/type_code)"/>)
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
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
					<xsl:if test="bo_lc_ref_id[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_LC_REF_ID')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bo_lc_ref_id"/>
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
					<!--application Date -->
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="appl_date"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="security:isCustomer($rundata) and tnx_amt[.!=''] and (sub_tnx_type_code[.='38'] or sub_tnx_type_code[.='39'])">
			  			<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPAYMENT_AMOUNT')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/> 
						</xsl:with-param>
					</xsl:call-template>
	       			</xsl:if>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REQUESTED_ISSUE_DATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="iss_date"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="security:isBank($rundata) and tnx_amt[.!=''] and (sub_tnx_type_code[.='38'] or sub_tnx_type_code[.='39'])">
			  			<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPAYMENT_AMOUNT')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/> 
						</xsl:with-param>
					</xsl:call-template>
	       			</xsl:if>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DAYS')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="tenor"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_MATURITY_DATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="maturity_date"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">				
						<xsl:with-param name="right_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_MATURITY_DISCLAIMER')"/>							
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code[.])"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="sub_product_code[.='IOTHF'] or sub_product_code[.='EOTHF']">   
						<xsl:if test="sub_product_code_text[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="sub_product_code_text"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
					</xsl:if>
					<!-- Client Additional Fields and added new financing types to above Fin Type field -->
					<xsl:if test="related_reference[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_RELATED_REFERENCE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="related_reference"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
				  <xsl:variable name="parent_product"><xsl:value-of select="cross_references/cross_reference/product_code"/></xsl:variable>
                <xsl:variable name="parent_liab_amt">

              <xsl:if test="$parent_product ='TF'">fin_liab_amt</xsl:if>
                       </xsl:variable>
              <xsl:variable name="parent_cur_code">
              <xsl:if test="$parent_product ='TF'">fin_cur_code</xsl:if>
              </xsl:variable>
          <xsl:variable name="parent_liab_amt_value" select="//*[name()=$parent_liab_amt]"></xsl:variable>
                  <xsl:variable name="parent_liab_cur_code_value" select="//*[name()=$parent_cur_code]"></xsl:variable>     
               <xsl:if test="bill_amt[.!=''] or $parent_liab_cur_code_value[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_BILL_AMOUNT')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
               <xsl:choose>
              <xsl:when test="bill_amt[.!=''] and bill_amt_cur_code[.!='']">
              <xsl:value-of select="bill_amt_cur_code"/>&nbsp;<xsl:value-of select="bill_amt"/>
              </xsl:when>
              <xsl:otherwise>
                     <xsl:value-of select="$parent_liab_cur_code_value"/>&nbsp;
              <xsl:value-of select="$parent_liab_amt_value"/>
              </xsl:otherwise>
         </xsl:choose>  
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="description_of_goods[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DESCRIPTION_OF_GOODS')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="description_of_goods"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
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
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ENTITY')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="entity"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="applicant_name"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- Address -->
					<xsl:if test="applicant_address_line_1[.!=''] or applicant_address_line_2[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="applicant_address_line_1"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- <xsl:if test="applicant_address_line_2[.!='']"> -->
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
					<!-- Display Entity -->
					<!-- <xsl:if test="applicant_reference[.!=''] and (not(tnx_id) or (tnx_type_code[.!='01'] and tnx_type_code[.!='15'] and tnx_type_code[.!='13']) or preallocated_flag[.='Y'])">201708, no required from Existing Records. Syncing with RP 
					 <xsl:if test="applicant_reference[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="applicant_reference" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if> -->
					<!--<xsl:if test="applicant_reference[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="applicant_reference" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				--></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:apply-templates select="issuing_bank">
						<xsl:with-param name="theNodeName" select="'issuing_bank'"/>
						<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language,'XSL_BANKDETAILS_TAB_FINANCING_BANK')"/>
					</xsl:apply-templates>
					<xsl:if test ="//*/avail_main_banks/bank/entity/customer_reference[reference=$sender-reference-value]/description[.!=''] or 
								//*/avail_main_banks/bank/customer_reference[reference=$sender-reference-value]/description or
								//*/avail_main_banks/bank/entity/customer_reference/description[.!=''] or
								//*/avail_main_banks/bank/customer_reference/description or
								org_previous_file/tf_tnx_record/applicant_reference[.!='']" >
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CUST_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
								<xsl:when test="defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'">
								<xsl:choose>
								<xsl:when test="count(avail_main_banks/bank/entity/customer_reference[reference=$sender-reference-value]) >= 1 or count(avail_main_banks/bank/entity/customer_reference) >= 1 ">
							           <xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank/entity/customer_reference/reference)"/>
							        </xsl:when>
							        <xsl:when test="(//*/avail_main_banks/bank/customer_reference/description[.!=''])">
							        	 <xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank/customer_reference/reference)"/>
							        </xsl:when>
							        <xsl:otherwise>
							          <xsl:value-of select="org_previous_file/tf_tnx_record/applicant_reference" />		
							        </xsl:otherwise>
								</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
								<xsl:choose>
								<xsl:when test="count(avail_main_banks/bank/entity/customer_reference[reference=$sender-reference-value]) >= 1 or count(avail_main_banks/bank/entity/customer_reference) >= 1 ">
							           <xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference/description"/>
							        </xsl:when>
							        <xsl:when test="(//*/avail_main_banks/bank/customer_reference/description[.!=''])">
							        	 <xsl:value-of select="//*/avail_main_banks/bank/customer_reference/description"/>
							        </xsl:when>
							        <xsl:otherwise>
							          <xsl:value-of select="org_previous_file/tf_tnx_record/applicant_reference" />		
							        </xsl:otherwise>
								</xsl:choose>
								</xsl:otherwise>
							   	</xsl:choose>
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
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FIN_AMT_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="fin_cur_code"/>&nbsp;<xsl:value-of select="fin_amt"/> 
							
						</xsl:with-param>
					</xsl:call-template>
					<!-- MPS-41651- Outstanding Amount -->
					<xsl:if test="fin_outstanding_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="fin_cur_code"/>&nbsp;<xsl:value-of select="fin_outstanding_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="fin_liab_amt[.!='']  and security:isBank($rundata)">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="fin_cur_code"/>&nbsp;<xsl:value-of select="fin_liab_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="req_pct[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IN_INVOICE_ELIGIBLE_PCT')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
   			  <xsl:when test="$language = 'fr' "><xsl:value-of select="translate(format-number(translate(req_pct, ',','.') * 100, '#.########'),'.',',')"/></xsl:when>
    	     <xsl:otherwise><xsl:value-of select="format-number(req_pct * 100, '#.########')"/></xsl:otherwise>
         						 </xsl:choose>
         						 </xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="req_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IN_INVOICE_ELIGIBLE_AMT')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								  <xsl:value-of select="req_cur_code"/>&nbsp;<xsl:value-of select="req_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			
			<!-- linked licenses -->
			<xsl:if test="((security:isBank($rundata) and  securitycheck:hasPermission($rundata,'tradeadmin_ls_access')) or (security:isCustomer($rundata) and securitycheck:hasPermission($rundata,'ls_access') = 'true')) and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true'">
			<fo:block id="linkedlicensedetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINKED_LICENSES')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:choose>
				<xsl:when test="linked_licenses/license">
					<fo:block keep-together="always">
					<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
						<fo:table-column column-width="{$pdfTableWidth}"/>	
						<fo:table-column column-width="0"/> <!--  dummy column -->	
						<fo:table-body>
							<fo:table-row>
							<fo:table-cell>
							<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
						      	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
			  				       	<fo:table-column column-width="20.0pt"/>
			  				       	<fo:table-column column-width="proportional-column-width(2)"/>
						        	<fo:table-column column-width="proportional-column-width(2)"/>
						        	<fo:table-column column-width="proportional-column-width(2)"/>
						        	<fo:table-column column-width="proportional-column-width(2)"/>
						        	<fo:table-column column-width="proportional-column-width(1)"/>
						        	<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
										<fo:table-row text-align="center">
										<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'BO_REF')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'LICENSE_NUMBER')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt"><xsl:value-of select="localization:getGTPString($language, 'LS_ALLOCATED_AMT')"/></fo:block></fo:table-cell>
						        		</fo:table-row>
						        	</fo:table-header>
						        	<fo:table-body>
							        		<xsl:for-each select="linked_licenses/license">
							        		<fo:table-row>
												<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
													<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="ls_ref_id"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
													<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="bo_ref_id"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
													<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="ls_number"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
													<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:value-of select="ls_allocated_amt"/>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
								         </xsl:for-each>
						        	</fo:table-body>
								</fo:table>
							</fo:block>
							</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
			  </xsl:when>
			  <xsl:otherwise>
				  <xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NO_LINKED_LS_ITEMS')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			  </xsl:otherwise>
		  </xsl:choose>
		  </xsl:if>
			
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
			
			<!--<xsl:if test="fx_details[.!='']">
			<fo:block id="fxdetails" />
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_EXCHANGE_RATE')" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_GENERALDETAILS_FX_DETAILS')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="fx_details" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			-->
			<xsl:call-template name="fx-common-details"/>
			<!--Additional Details-->
			<xsl:if test="goods_desc[.!='']">
				<fo:block id="additionnaldetails"/>
				<fo:block white-space-collapse="false">
					<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
						<fo:table-column column-width="{$pdfTableWidth}"/>
						<fo:table-column column-width="0"/> <!--  dummy column -->
						<fo:table-body>
							<xsl:call-template name="title2">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ADDITIONAL_DETAILS')"/>
								</xsl:with-param>
							</xsl:call-template>
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block space-before.conditionality="retain" space-before.optimum="10.0pt" start-indent="20.0pt" linefeed-treatment="preserve" white-space="pre">
										<xsl:value-of select="goods_desc"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
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
