<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<!--
		Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com), All
		Rights Reserved.
	-->
<xsl:stylesheet 
	xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
	xmlns:fo="http://www.w3.org/1999/XSL/Format" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:common="http://exslt.org/common"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>

	<xsl:template match="sr_tnx_record">
		<!-- HEADER-->
		
		<!-- FOOTER-->
		
		<!-- BODY-->
		
	<xsl:call-template name="header"/>
    <xsl:call-template name="footer"/>
    <xsl:call-template name="body"/>
  </xsl:template>
<xsl:template name="header">
    <fo:static-content flow-name="xsl-region-before">
			<xsl:call-template name="header_advising_bank"/>
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
                                         <xsl:value-of select="utils:getCompanyName(ref_id,product_code)" />
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
                           <xsl:if test="issuing_bank/name[.!='']">
                                  <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of
                                                       select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_ISSUING_BANK')" />
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="issuing_bank/name" />
                                         </xsl:with-param>
                                  </xsl:call-template>
                           </xsl:if>
                           <xsl:if test="lc_ref_id[.!='']">
										<xsl:call-template name="table_cell">
											<xsl:with-param name="left_text">
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IMPORT_LC_REF_ID')" />
											</xsl:with-param>
											<xsl:with-param name="right_text">
												<xsl:value-of select="lc_ref_id" />
											</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
                           </xsl:with-param>
                           </xsl:call-template>
                           </xsl:if>
                     <fo:block id="txndetails"/>
                     <xsl:if test="security:isBank($rundata)">
                     <xsl:call-template name="table_template">
                           <xsl:with-param name="text">
                                  <xsl:call-template name="title">
                                         <xsl:with-param name="text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_DETAILS')"/>
                                         </xsl:with-param>
                                  </xsl:call-template>                            
                                  <xsl:if test="company_name[.!='']">
                                  <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_COMPANY_NAME')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="company_name"/>
                                         </xsl:with-param>
                                  </xsl:call-template> 
                                  </xsl:if>                           
                                  <xsl:if test="product_code[.!='']">
                                  <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_CODE')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of
                                                select="localization:getDecode($language, 'N001', product_code[.])" />
                                         </xsl:with-param>
                                  </xsl:call-template> 
                                  </xsl:if>
                                  <xsl:if test="ref_id[.!='']">
                                  <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="ref_id"/>
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
                                  <xsl:if test="lc_ref_id[.!='']">
								  	<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IMPORT_LC_REF_ID')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="lc_ref_id" />
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
                                            <xsl:if test="sub_tnx_type_code[. != '']"><xsl:text> </xsl:text>
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
                                                <xsl:value-of select="release_dttm" />
                                         </xsl:with-param>
                                  </xsl:call-template> 
                                  </xsl:if>
									<xsl:if test="iss_date[.!=''] and (not(tnx_id) or tnx_type_code[.!='01'])">
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
                     </xsl:if>
					<xsl:if test="security:isBank($rundata)">
						<fo:block id="reportdetails"/>
						<xsl:call-template name="table_template">
							<xsl:with-param name="text">
								<xsl:call-template name="title">
									<xsl:with-param name="text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REPORTING_DETAILS')"/>
									</xsl:with-param>
								</xsl:call-template>                            
                             	<xsl:choose>
                              <xsl:when test="tnx_type_code[.='01']">
                              </xsl:when> 
                                <xsl:when test="tnx_type_code[.!='15'] and tnx_type_code[.!='01']">
                                    <xsl:call-template name="table_cell">
                                  <xsl:with-param name="left_text">
                                         <xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_NEW_TNX_STAT_LABEL')"/>
                                  </xsl:with-param>
                                  <xsl:with-param name="right_text">
                                  <xsl:choose>
                                 <xsl:when test="prod_stat_code[.='03'] or prod_stat_code[.='08'] or prod_stat_code[.='07'] or prod_stat_code[.='05'] or prod_stat_code[.='04'] or prod_stat_code[.='11']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_APPROVED')"/></xsl:when>
					             <xsl:when test="prod_stat_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_01_REJECTED')"/></xsl:when>
					              <xsl:when test="prod_stat_code[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBTNXSTATCODE_05_STOPOVER_TO_SENT')"/></xsl:when>
                              </xsl:choose>
                                    </xsl:with-param>
                             </xsl:call-template> 
                             </xsl:when> 
								 <xsl:otherwise>
                                 <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_NEW_TNX_STAT_LABEL')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                             <xsl:choose>
					<xsl:when test="prod_stat_code[.='07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_07_UPDATED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_03_NEW')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='32']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_32_AMENDMENT_REFUSED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_08_AMENDED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='09']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_09_EXTENDED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_04_ACCEPTED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_05_SETTLED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='13']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_13_PART_SETTLED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='06']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_06_CANCELLED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='11']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_11_RELEASED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='12']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_12_DISCREPANT')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='14']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_14_PART_SIGHT_PAYMT')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='15']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_15_FULL_SIGHT_PAYMT')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='31']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_31_AMENDMENT_AWAITING_BENEFICIARY_APPROVAL')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='81']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_81_CANCEL_AWAITING_BENEFICIARY_RESPONSE')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='82']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_82_CANCEL_REFUSED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='10']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_10_PURGED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='42']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_42_EXPIRED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='84']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_84_CLAIM_PRESENTATION')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='85']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_85_CLAIM_SETTLEMENT')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='86']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_86_EXTEND_PAY')"/></xsl:when>      
					<xsl:when test="prod_stat_code[.='26']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_26_CLEAN')"/></xsl:when> 
					<xsl:when test="prod_stat_code[.='78']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_78_WORDING_UNDER_REVIEW')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='79']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_79_FINAL_WORDING')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='16']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_16_NOTIFICATION_OF_CHARGES')"/></xsl:when>
     				<xsl:when test="prod_stat_code[.='24']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_24_REQUEST_FOR_SETTLEMENT')"/></xsl:when>
     				<xsl:when test="prod_stat_code[.='66']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_66_ESTABLISHED')"/></xsl:when>
					<xsl:when test="prod_stat_code[.='72']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_72_PO_ESTABLISHED')"/></xsl:when>     
				</xsl:choose>
				</xsl:with-param>
				</xsl:call-template>
				</xsl:otherwise>
                </xsl:choose>
                
                                <xsl:if test="tnx_amt[.!=''] and (not(tnx_id) or (tnx_type_code[.!='01'] and sub_tnx_type_code[.!='05']))">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_DOCS_AMT_LABEL')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="tnx_cur_code" />&nbsp;<xsl:value-of select="tnx_amt" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
			                <xsl:if test="maturity_date[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_GENERALDETAILS_MATURITY_DATE')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="maturity_date" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
                              <xsl:if test="bo_ref_id[.!=''] and (not(tnx_id) or tnx_type_code[.!='15'])">
                                  <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                         <xsl:value-of select="bo_ref_id"/>
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
                              <xsl:if test="release_dttm[.!='']">
                                   <xsl:call-template name="table_cell">
                                         <xsl:with-param name="left_text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_RELEASE_DTTM')"/>
                                         </xsl:with-param>
                                         <xsl:with-param name="right_text">
                                                <xsl:value-of select="convertTools:formatReportDate(release_dttm,$rundata)" />
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
					<xsl:if test="lc_ref_id[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IMPORT_LC_REF_ID')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="lc_ref_id"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
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
					<xsl:if test="lc_exp_date_type_code[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text"><xsl:value-of select="localization:getGTPString($language, 'GENERALDETAILS_EXPIRY_TYPE')"/></xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="lc_exp_date_type_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_EXP_DATE_TYPE_SPECIFIC')"/></xsl:when>
									<xsl:when test="lc_exp_date_type_code[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_EXP_DATE_TYPE_CONDITIONAL')"/></xsl:when>
									<xsl:when test="lc_exp_date_type_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_EXP_DATE_TYPE_UNLIMITED')"/></xsl:when>
								</xsl:choose>
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
						<xsl:if test="exp_event[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_EVENT')"/>
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="exp_event"/>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
					<xsl:if test="expiry_place[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_PLACE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="expiry_place"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="lc_govern_country[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_PLACE_OF_JURISDICTION')"/></xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="lc_govern_country"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="lc_govern_text[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text"><xsl:value-of select="localization:getGTPString($language, 'GOVERNING_LABEL')"/></xsl:with-param>
							<xsl:with-param name="right_text"><xsl:value-of select="lc_govern_text"/></xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="demand_indicator[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_DEMAND_INDICATOR')"/></xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="demand_indicator[.='NMLT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DEMAND_INDICATOR_NMLT')"/>&nbsp;</xsl:when>
									<xsl:when test="demand_indicator[.='NMPT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DEMAND_INDICATOR_NMPT')"/>&nbsp;</xsl:when>
									<xsl:when test="demand_indicator[.='NPRT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DEMAND_INDICATOR_NPRT')"/>&nbsp;</xsl:when>
									<xsl:when test="demand_indicator[.='PMPT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DEMAND_INDICATOR_PMPT')"/>&nbsp;</xsl:when>
							    </xsl:choose>
							</xsl:with-param>							
						</xsl:call-template>
					</xsl:if>
					
					
					<xsl:if test="amd_no[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_AMD_NO')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="utils:formatAmdNo(amd_no)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="eucp_flag[. = 'Y']">
				<fo:table font-family="{$pdfFontData}" font-weight="bold" keep-together="always" space-before.conditionality="retain" space-before.optimum="10.0pt" width="{$pdfTableWidth}">
					<fo:table-column column-width="{$pdfTableWidth}"/>
					<fo:table-column column-width="0"/> <!--  dummy column -->
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:block start-indent="20.0pt">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EUCP_DISCLAIMER')"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:if test="eucp_version[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EUCP_VERSION')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="eucp_version"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="eucp_presentation_place[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EUCP_PRESENTATION_PLACE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="eucp_presentation_place"/>
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
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')"/>
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
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ABBV_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="beneficiary_abbv_name"/>
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
					<xsl:if test="beneficiary_address_line_4[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="beneficiary_address_line_4"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="beneficiary_reference[.!='']">
			          	<xsl:variable name="ben_ref" select="//beneficiary_reference"/>							
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
					<!-- Display Entity -->
								<xsl:variable name="beneficiary_ref">
			              			<xsl:value-of select="beneficiary_reference"/>
			          			</xsl:variable>
								<xsl:value-of select="utils:decryptApplicantReference($beneficiary_ref)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="sub_tnx_type_code[.='19']">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_ASSIGNEE_DETAILS')" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="assignee_name" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<fo:block font-weight="bold">
									<xsl:value-of select="assignee_address_line_1" />
								</fo:block>
								
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="assignee_address_line_2[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<fo:block font-weight="bold">
										<xsl:value-of select="assignee_address_line_2" />
									</fo:block>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="assignee_dom[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<fo:block font-weight="bold">
										<xsl:value-of select="assignee_dom" />
									</fo:block>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:if>
					<xsl:if test="sub_tnx_type_code[.='12']">
				<xsl:call-template name="subtitle">
					<xsl:with-param name="text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SECOND_BENEFICIARY_DETAILS')" />
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="sec_beneficiary_name" />
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<fo:block font-weight="bold">
							<xsl:value-of select="sec_beneficiary_address_line_1" />
						</fo:block>
						<xsl:if test="sec_beneficiary_address_line_2[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<fo:block font-weight="bold">
										<xsl:value-of select="sec_beneficiary_address_line_2" />
									</fo:block>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="sec_beneficiary_dom[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<fo:block font-weight="bold">
										<xsl:value-of select="sec_beneficiary_dom" />
									</fo:block>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="sec_beneficiary_reference[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<!-- <xsl:choose>
									<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$beneficiary_ref]) &gt;= 1">
								      	<xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$beneficiary_ref]/description"/>
								     </xsl:when>
								     <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$beneficiary_ref]) = 0">
								     	<xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$beneficiary_ref]/description"/>
								     </xsl:when>
								</xsl:choose> -->
							<xsl:value-of select="sec_beneficiary_reference" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
			</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="lc_type[.='01' or .='02']">
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
						<!-- Adress -->
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
						<xsl:if test="applicant_address_line_4[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="applicant_address_line_4"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>

						  <!-- Display Entity for Applicant-->
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
						
						<xsl:if test="applicant_reference[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="applicant_reference"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="applicant_contact_number[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_BENEFICIARY_CONTACT_NUMBER')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="applicant_contact_number" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>

						<xsl:if test="applicant_email[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_JURISDICTION_EMAIL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="applicant_email" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:apply-templates select="issuing_bank">
							<xsl:with-param name="theNodeName" select="'issuing_bank'"/>
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ISSUING_BANK')"/>
						</xsl:apply-templates>
						<xsl:if test="sub_tnx_type_code[.='19']">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_ASSIGNEE_DETAILS')" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="assignee_name" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<fo:block font-weight="bold">
									<xsl:value-of select="assignee_address_line_1" />
								</fo:block>
								
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="assignee_address_line_2[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<fo:block font-weight="bold">
										<xsl:value-of select="assignee_address_line_2" />
									</fo:block>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="assignee_dom[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<fo:block font-weight="bold">
										<xsl:value-of select="assignee_dom" />
									</fo:block>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:if>
					<xsl:if test="(notify_amendment_flag[.]!='') or (substitute_invoice_flag[.]!='') or (advise_mode_code[.]!='')">
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:choose>
										<xsl:when test="sub_tnx_type_code[.='19']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSFER_DETAILS')" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_TRANSFER_DETAILS')" />
										</xsl:otherwise>
									</xsl:choose>
									
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NOTIFY_AMENDMENT')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:if test="notify_amendment_flag[.='Y']">
										<xsl:value-of select="localization:getGTPString($language, 'N034_Y')" />
									</xsl:if>
									<xsl:if test="notify_amendment_flag[.='N']">
										<xsl:value-of select="localization:getGTPString($language, 'N034_N')" />
									</xsl:if>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_SUBSTITUTE_INVOICE')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:if test="substitute_invoice_flag[.='Y']">
										<xsl:value-of select="localization:getGTPString($language, 'N034_Y')" />
									</xsl:if>
									<xsl:if test="substitute_invoice_flag[.='N']">
										<xsl:value-of select="localization:getGTPString($language, 'N034_N')" />
									</xsl:if>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADVISE_MODE')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:if test="advise_mode_code[.='01']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADVISE_MODE_DIRECT')" />
									</xsl:if>
									<xsl:if test="advise_mode_code[.='02']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADVISE_MODE_THRU_BANK')" />
									</xsl:if>
								</xsl:with-param>
							</xsl:call-template>

							<xsl:if test="advise_mode_code[.='02']">
								<xsl:call-template name="subtitle">
									<xsl:with-param name="text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ADVISE_THRU_BANK')" />
									</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:if test="advise_mode_code[.='01']">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADVISE_MODE_DIRECT')" />
										</xsl:if>
										<xsl:if test="advise_mode_code[.='02']">
											<xsl:value-of select="advise_thru_bank/name" />
										</xsl:if>
									</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<fo:block font-weight="bold" 
											space-before.conditionality="retain">
											<xsl:value-of select="advise_thru_bank/address_line_1" />
										</fo:block>
								     </xsl:with-param>
								   </xsl:call-template> 
								 <xsl:if test="advise_thru_bank/address_line_2[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="right_text">
											<fo:block font-weight="bold">
												<xsl:value-of select="advise_thru_bank/address_line_2" />
											</fo:block>
										</xsl:with-param>
									</xsl:call-template>
								 </xsl:if>
								 <xsl:if test="advise_thru_bank/dom[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="right_text">
											<fo:block font-weight="bold">
												<xsl:value-of select="advise_thru_bank/dom" />
											</fo:block>
										</xsl:with-param>
									</xsl:call-template>
								 </xsl:if>
								  <xsl:if test="advise_thru_bank/address_line_4[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="right_text">
											<fo:block font-weight="bold">
												<xsl:value-of select="advise_thru_bank/address_line_4" />
											</fo:block>
										</xsl:with-param>
								    </xsl:call-template>
								 </xsl:if>
								 
								<xsl:if test="advise_thru_bank/iso_code[.!='']">
								 <xsl:call-template name="table_cell">
							    <xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BIC_CODE')" />
							    </xsl:with-param>		 
							    <xsl:with-param name="right_text">
										<fo:block font-weight="bold">
											<xsl:value-of select="advise_thru_bank/iso_code"/>
										</fo:block>
						        </xsl:with-param>
						        </xsl:call-template>	
						        </xsl:if>
							</xsl:if>
							
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
				<!--Bank Details-->
				<!-- <fo:block id="bankdetails"/>
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
					</xsl:with-param>
				</xsl:call-template>

			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:if test="advising_bank/name[.!='']">
						<xsl:apply-templates select="advising_bank">
							<xsl:with-param name="theNodeName" select="'advising_bank'"/>
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_ADVISING_BANK')"/>
						</xsl:apply-templates>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template> -->
			<!--Amount Details-->
			<fo:block id="amountdetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:choose>
								<xsl:when test="$swift2018Enabled">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_CONFIRMATION_DETAILS')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_DETAILS')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					<fo:table-row>
						<fo:table-cell>
							<fo:block space-before.conditionality="retain" space-before.optimum="10.0pt"/>
						</fo:table-cell>
					</fo:table-row>
					<!--Form of LC-->
					<xsl:if test="lc_type[.='01']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<fo:block font-weight="bold">
									<xsl:choose>
										<xsl:when test="irv_flag[. = 'Y']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_IRREVOCABLE')"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_REVOCABLE')"/> 
										</xsl:otherwise>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="ntrf_flag[. = 'Y']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_NON_TRANSFERABLE')"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_TRANSFERABLE')"/>
										</xsl:otherwise>
									</xsl:choose>
									
									<xsl:if test="stnd_by_lc_flag[. = 'Y']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_STAND_BY')"/>
								    </xsl:if>
								    
								    
								</fo:block>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="ntrf_flag[.!=''] and ntrf_flag[.='N'] and narrative_transfer_conditions/text[.!='']">
									<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text"><xsl:value-of select="localization:getGTPString($language, 'TRANSFER_CONDITION')"/></xsl:with-param>
									<xsl:with-param name="right_text">
									<xsl:value-of select="narrative_transfer_conditions/text"/>
									</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
						<xsl:if test="cfm_inst_code[. = '01'] or cfm_inst_code[. = '02'] or cfm_inst_code[. = '03']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_CFM_INST_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="cfm_inst_code[. = '01']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_CFM_INST_CONFIRM')"/>
										</xsl:when>
										<xsl:when test="cfm_inst_code[. = '02']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_CFM_INST_MAY_ADD')"/>
										</xsl:when>
										<xsl:when test="cfm_inst_code[. = '03']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_CFM_INST_WITHOUT')"/>
										</xsl:when>
										<xsl:otherwise/>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- SWIFT 2018 -->
						<xsl:if test="$swift2018Enabled and req_conf_party_flag[. !=''] or requested_confirmation_party/iso_code[.!=''] ">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONFDETAILS_REQUESTED_CONFIRMATION_PARTY')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="req_conf_party_flag[. = 'Advising Bank']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISING')"/>
									</xsl:when>
									<xsl:when test="req_conf_party_flag[. = 'Advise Thru Bank']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISE_THRU')"/>
									</xsl:when>
									<xsl:when test="req_conf_party_flag[. = 'Other']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_OTHER')"/>
									</xsl:when>
									<xsl:otherwise/>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:apply-templates select="requested_confirmation_party">
							<xsl:with-param name="theNodeName" select="'requested_confirmation_party'"/>
						</xsl:apply-templates>
					</xsl:if>
					<xsl:if test="cfm_flag[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_CFM_FLAG_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="cfm_flag[. = 'Y']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/>
								</xsl:when>
								<xsl:when test="cfm_flag[. = 'N']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/>
								</xsl:when>
								<xsl:otherwise/>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="lc_amt[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_LC_AMT_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="lc_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="lc_amt"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="not(tnx_id) or lc_available_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_AVAILABLE_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="lc_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="lc_available_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="not(tnx_id) or lc_liab_amt[.!=''] and security:isBank($rundata)">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="lc_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="lc_liab_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="lc_type[.='01']">
						<fo:table-row>
							<fo:table-cell>
								<fo:block space-before.conditionality="retain" space-before.optimum="10.0pt"/>
							</fo:table-cell>
						</fo:table-row>
						<!--Variation in Drawing-->
						<xsl:if test="pstv_tol_pct[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<fo:inline font-family="{$pdfFont}">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')"/>
									</fo:inline>
									<fo:inline font-weight="bold">
										<xsl:value-of select="pstv_tol_pct"/> %
									</fo:inline>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="neg_tol_pct[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<fo:inline font-family="{$pdfFont}">
										<xsl:choose>
											<xsl:when test="pstv_tol_pct[. = '']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_LABEL')"/>
											</xsl:when>
											<xsl:otherwise/>
										</xsl:choose>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')"/>
									</fo:inline>
									<fo:inline font-weight="bold">
										<xsl:value-of select="neg_tol_pct"/> %
									</fo:inline>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="not($swift2018Enabled)">
						<xsl:if test="max_cr_desc_code[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:choose>
										<xsl:when test="pstv_tol_pct[. = ''] and neg_tol_pct[. = ''] and max_cr_desc_code[.!='']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_LABEL')"/>
										</xsl:when>
										<xsl:otherwise> 
										</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<fo:inline font-family="{$pdfFont}">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_LABEL')"/>
									</fo:inline>
									<fo:inline font-weight="bold">
                                           
										<xsl:choose>
											<xsl:when test="max_cr_desc_code[. = '3']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_NOTEXCEEDING')"/>
											</xsl:when>
											<xsl:otherwise/>
										</xsl:choose>
									</fo:inline>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						</xsl:if>
						<!-- Charges Born By Flags -->
						<xsl:if test="open_chrg_brn_by_code[.='01' or .='02']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_ISS_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="open_chrg_brn_by_code[. = '01']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_APPLICANT')"/>
										</xsl:when>
										<xsl:when test="open_chrg_brn_by_code[. = '02']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BENEFICIARY')"/>
										</xsl:when>
										<xsl:otherwise/>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="corr_chrg_brn_by_code[.='01' or .='02']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_CORR_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="corr_chrg_brn_by_code[. = '01']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_APPLICANT')"/>
										</xsl:when>
										<xsl:when test="corr_chrg_brn_by_code[. = '02']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BENEFICIARY')"/>
										</xsl:when>
										<xsl:otherwise/>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="is_MT798[.='N'] and cfm_chrg_brn_by_code[.='01' or .='02'] and $confirmationChargesEnabled">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_CFM_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="cfm_chrg_brn_by_code[. = '01']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_APPLICANT')"/>
										</xsl:when>
										<xsl:when test="cfm_chrg_brn_by_code[. = '02']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BENEFICIARY')"/>
										</xsl:when>
										<xsl:otherwise/>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="$swift2018Enabled and amd_chrg_brn_by_code[.='01' or .='02' or .='07']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_AMD_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<fo:block font-weight="bold">
										<xsl:choose>
											<xsl:when test="amd_chrg_brn_by_code[. = '01']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_APPLICANT')"/>
											</xsl:when>
											<xsl:when test="amd_chrg_brn_by_code[. = '02']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BENEFICIARY')"/>
											</xsl:when>
											<xsl:when test="amd_chrg_brn_by_code[. = '07']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_OTHER')"/>
											</xsl:when>
											<xsl:otherwise/>
										</xsl:choose>
									</fo:block>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="amd_chrg_brn_by_code[. = '07']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text"/>									
								<xsl:with-param name="right_text">
									<fo:block font-weight="bold">										
										<xsl:value-of select="narrative_amend_charges_other"/>											
									</fo:block>
								</xsl:with-param>
							</xsl:call-template>
							</xsl:if>
						</xsl:if>
						<!-- Applicable Rules -->
						<xsl:if test="applicable_rules[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_RULES_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getDecode($language, 'N065', applicable_rules)"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="applicable_rules[.='99']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text"/>
									<xsl:with-param name="right_text">
										<xsl:value-of select="applicable_rules_text"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:if>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<!--Renewal Details-->
			<xsl:if test="renew_flag[. = 'Y']">
				<fo:block id="renewaldetails"/>
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_DETAILS_LABEL')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_RENEW_ON')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="renew_on_code[.= '01']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/>
									</xsl:when>
									<xsl:when test="renew_on_code[.= '02']">
										<xsl:value-of select="renewal_calendar_date"/>
									</xsl:when>
									<xsl:otherwise/>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_RENEW_FOR')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="renew_for_nb"/> 
								<xsl:value-of select="localization:getDecode($language, 'N074', renew_for_period)"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="advise_renewal_flag[. = 'Y']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_ADVISE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_DAYS_NOTICE')"/>&nbsp;<xsl:value-of select="advise_renewal_days_nb"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>

						<xsl:if test="rolling_renewal_flag[. = 'Y']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_ROLLING_RENEWAL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_RENEW_ON')"/> <xsl:choose>
											<xsl:when test="rolling_renew_on_code[.= '01']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/>
											</xsl:when>
											<xsl:when test="rolling_renew_on_code[.= '03']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EVERY')"/>
											</xsl:when>
										</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="rolling_renew_for_nb[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="localization:getGTPString($language, 'FREQUENCY_LABEL')"/> <xsl:value-of select="rolling_renew_for_nb"/> <xsl:value-of select="localization:getDecode($language, 'N074', rolling_renew_for_period)"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="rolling_day_in_month[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_ROLLING_DAY_IN_MONTH')"/> <xsl:value-of select="rolling_day_in_month"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_NUMBER_RENEWALS')"/> <xsl:value-of select="rolling_renewal_nb"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CANCELLATION_NOTICE')"/> <xsl:value-of select="rolling_cancellation_days"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="renew_amt_code[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_AMOUNT')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getDecode($language, 'N075', renew_amt_code)"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="projected_expiry_date[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_PROJECTED_EXPIRY_DATE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="projected_expiry_date"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="final_expiry_date[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_FINAL_EXPIRY_DATE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="final_expiry_date"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="lc_type[.='01']">
				<!--Payment Details-->
				<fo:block id="paymentdetails"/>
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PAYMENT_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<!--Call Template for Credit Available With Bank-->
						<xsl:apply-templates select="credit_available_with_bank">
							<xsl:with-param name="theNodeName" select="'credit_available_with_bank'"/>
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_LABEL')"/>
						</xsl:apply-templates>
						<xsl:if test="cr_avl_by_code[. = '01'] or cr_avl_by_code[. = '02'] or cr_avl_by_code[. = '03'] or cr_avl_by_code[. = '04'] or cr_avl_by_code[. = '05'] or cr_avl_by_code[. = '06']">
							<!--Credit Available By-->
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="cr_avl_by_code[. = '01']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_PAYMENT')"/>
										</xsl:when>
										<xsl:when test="cr_avl_by_code[. = '02']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_ACCEPTANCE')"/>
										</xsl:when>
										<xsl:when test="cr_avl_by_code[. = '03']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_NEGOTIATION')"/>
										</xsl:when>
										<xsl:when test="cr_avl_by_code[. = '04']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_DEFERRED')"/>
										</xsl:when>
										<xsl:when test="cr_avl_by_code[. = '05']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_MIXED')"/>
										</xsl:when>
										<xsl:when test="cr_avl_by_code[. = '06']">
                                            <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_DEMAND')" />
                                        </xsl:when>
										<xsl:otherwise/>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="draft_term[.!='']">
							<xsl:call-template name="table_cell_1">
								<xsl:with-param name="left_text">
									<xsl:choose>
										<xsl:when test="cr_avl_by_code[. = '02'] or cr_avl_by_code[. = '03']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAFT_LABEL')"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_PAYMT_LABEL')"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="draft_term"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				<!--Drawee Details Bank-->
				<xsl:if test="drawee_details_bank/name[.!='']">
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:apply-templates select="drawee_details_bank">
								<xsl:with-param name="theNodeName" select="'drawee_details_bank/name'"/>
								<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_LABEL')"/>
							</xsl:apply-templates>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<!--Shipment Details-->
				<fo:block id="shipmentdetails"/>
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SHIPMENT_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<fo:table-row keep-with-previous="always">
							<fo:table-cell>
								<fo:block space-before.conditionality="retain" space-before.optimum="10.0pt"/>
							</fo:table-cell>
						</fo:table-row>
						<xsl:if test="ship_from[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_SHIP_FROM')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ship_from"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- SWIFT 2006 -->
						<xsl:if test="ship_loading[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_SHIP_LOADING')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ship_loading"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="ship_discharge[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_SHIP_DISCHARGE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ship_discharge"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- SWIFT 2006 -->
						<xsl:if test="ship_to[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_SHIP_TO')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ship_to"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- MPS- starts SR -->
						   <xsl:if test="part_ship_detl[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="part_ship_detl[. = 'ALLOWED']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_ALLOWED')"/>
									</xsl:when>
									<xsl:when test="part_ship_detl[. = '' or . = 'NOT ALLOWED']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED')"/>
									</xsl:when>
									<xsl:when test="part_ship_detl[. = 'NONE']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_NONE')"/>
									</xsl:when>
									<xsl:when test="part_ship_detl[. = 'CONDITIONAL']">
								       	 	<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_CONDITIONAL')"/>
						 	 	 	</xsl:when>
									<xsl:when test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_PART_SHIP_OTHER')"/>
									</xsl:when>
								</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						   </xsl:if>
							<xsl:if test="part_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE' and . != 'CONDITIONAL']"> 
								<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">									
								</xsl:with-param>
								<xsl:with-param name="right_text">								
											<xsl:value-of select="part_ship_detl"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="tran_ship_detl[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:choose>
										<xsl:when test="$swift2018Enabled">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL_LC')"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL')"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
	          							<xsl:when test="tran_ship_detl[. = 'ALLOWED']">
	          								<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_ALLOWED')"/>
	          							</xsl:when>
	          							<xsl:when test="tran_ship_detl[. = '' or . = 'NOT ALLOWED']">
	          								<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED')"/>
	          							</xsl:when>
	          							<xsl:when test="tran_ship_detl[. = 'NONE']">
	          								<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_NONE')"/>
	          							</xsl:when>
	          							<xsl:when test="tran_ship_detl[. = 'CONDITIONAL']">
								       	 	<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_CONDITIONAL')"/>
						 	 	 	 </xsl:when>
	          							<xsl:when test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED']">
	          								<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_TRAN_SHIP_OTHER')"/>
	          							</xsl:when>    						
         							</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						   </xsl:if>	
							<xsl:if test="tran_ship_detl[. != '' and . != 'ALLOWED' and . != 'NOT ALLOWED' and . != 'NONE' and . != 'CONDITIONAL']">  
							<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
									<xsl:value-of select="tran_ship_detl"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="last_ship_date[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_LAST_SHIP_DATE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="last_ship_date"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="inco_term_year[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_INCO_TERM_YEAR')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="inco_term_year"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="inco_term[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_INCO_TERM')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getCodeData($language,'*','*','N212',inco_term)"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="inco_place[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_INCO_PLACE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="inco_place"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			
			<xsl:if test="narrative_full_details[.!='']">
				<!--Standby LC Details-->
				<fo:block id="lcdetails"/>
				<fo:block white-space-collapse="false">
					<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
						<!-- <fo:table-column column-width="{$pdfTableWidth}"/> -->
						<fo:table-body>
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_STANDBY_LC_DETAILS')"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="applicable_rules[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_RULES_LABEL')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getDecode($language, 'N065', applicable_rules)"/>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="applicable_rules[.='99']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text"/>
									<xsl:with-param name="right_text">
										<xsl:value-of select="applicable_rules_text"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:if>
							<fo:table-row>
								<fo:table-cell>
									<fo:block font-weight="bold" space-before.conditionality="retain" space-before.optimum="10.0pt" start-indent="20.0pt" white-space-collapse="false" linefeed-treatment="preserve" white-space="pre">
										<xsl:value-of select="narrative_full_details"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</xsl:if>
			<xsl:if test="lc_type[.='01']">
			<xsl:choose>
			<xsl:when test="$swift2018Enabled and (defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true')">
			<xsl:if test="narrative_description_goods[.!=''] or narrative_special_beneficiary[.!=''] or narrative_special_recvbank[.!=''] or narrative_documents_required[.!=''] or narrative_additional_instructions[.!=''] or narrative_charges[.!=''] or narrative_additional_amount[.!=''] or narrative_payment_instructions[.!='']  or narrative_shipment_period[.!=''] or narrative_sender_to_receiver[.!='']">
					<xsl:call-template name="pdfExtendedNarrative"/>
			</xsl:if>		
					<xsl:if test="narrative_charges[.!=''] or narrative_additional_amount[.!=''] or narrative_payment_instructions[.!='']  or narrative_shipment_period[.!=''] or narrative_sender_to_receiver[.!='']">
					<fo:block id="narative"/>
					<fo:block white-space-collapse="false" linefeed-treatment="preserve" white-space="pre">
						<fo:table font-family="{$pdfFontData}" font-size="11pt" space-before.conditionality="retain" space-before.optimum="10.0pt" width="{$pdfTableWidth}">
							<fo:table-column column-width="{$pdfTableWidth}"/>
							<fo:table-column column-width="0"/> <!--  dummy column -->
							<fo:table-body>
								<xsl:if test="narrative_charges[.!='']">
									<xsl:apply-templates select="narrative_charges">
										<xsl:with-param name="theNodeName" select="'narrative_charges'"/>
										<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_CHARGES')"/>
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="narrative_additional_amount[.!='']">
									<xsl:apply-templates select="narrative_additional_amount">
										<xsl:with-param name="theNodeName" select="'narrative_additional_amount'"/>
										<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_AMOUNT')"/>
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="narrative_payment_instructions[.!='']">
									<xsl:apply-templates select="narrative_payment_instructions">
										<xsl:with-param name="theNodeName" select="'narrative_payment_instructions'"/>
										<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS')"/>
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="narrative_shipment_period[.!='']">
									<xsl:apply-templates select="narrative_shipment_period">
										<xsl:with-param name="theNodeName" select="'narrative_shipment_period'"/>
										<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SHIPMENT_PERIOD')"/>
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="narrative_sender_to_receiver[.!='']">
									<xsl:apply-templates select="narrative_sender_to_receiver">
										<xsl:with-param name="theNodeName" select="'narrative_sender_to_receiver'"/>
										<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SENDER_TO_RECEIVER')"/>
									</xsl:apply-templates>
								</xsl:if>
							</fo:table-body>
						</fo:table>
					</fo:block>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
			<xsl:if test="narrative_description_goods[.!=''] or narrative_documents_required[.!=''] or narrative_additional_instructions[.!=''] or narrative_charges[.!=''] or narrative_additional_amount[.!=''] or narrative_payment_instructions[.!=''] or narrative_period_presentation[.!=''] or narrative_shipment_period[.!=''] or narrative_sender_to_receiver[.!='']">
					<!--Narrative Details-->
					<fo:block id="narative"/>
					<fo:block white-space-collapse="false" linefeed-treatment="preserve" white-space="pre">
						<fo:table font-family="{$pdfFontData}" font-size="11pt" space-before.conditionality="retain" space-before.optimum="10.0pt" width="{$pdfTableWidth}">
							<fo:table-column column-width="{$pdfTableWidth}"/>
							<fo:table-column column-width="0"/>
							<fo:table-body>
								<xsl:call-template name="title">
									<xsl:with-param name="text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_NARRATIVE_DETAILS')"/>
									</xsl:with-param>
								</xsl:call-template>
								<xsl:if test="narrative_description_goods[.!='']">
									<xsl:apply-templates select="narrative_description_goods">
										<xsl:with-param name="theNodeName" select="'narrative_description_goods'"/>
										<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS')"/>
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="narrative_documents_required[.!='']">
									<xsl:apply-templates select="narrative_documents_required">
										<xsl:with-param name="theNodeName" select="'narrative_documents_required'"/>
										<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED')"/>
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="narrative_additional_instructions[.!='']">
									<xsl:apply-templates select="narrative_additional_instructions">
										<xsl:with-param name="theNodeName" select="'narrative_additional_instructions'"/>
										<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS')"/>
									</xsl:apply-templates>
								</xsl:if>
								<!-- SWIFT 2018 -->
								<xsl:if test="$swift2018Enabled">
									<xsl:if test="narrative_special_beneficiary[.!='']">
										<xsl:apply-templates select="narrative_special_beneficiary">
											<xsl:with-param name="theNodeName" select="'narrative_special_beneficiary'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF')"/>
										</xsl:apply-templates>
									</xsl:if>
									<xsl:if test="security:isBank($rundata) and narrative_special_recvbank[.!='']">
										<xsl:apply-templates select="narrative_special_recvbank">
											<xsl:with-param name="theNodeName" select="'narrative_special_recvbank'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV')"/>
										</xsl:apply-templates>
									</xsl:if>
								</xsl:if>
								<xsl:if test="narrative_charges[.!='']">
									<xsl:apply-templates select="narrative_charges">
										<xsl:with-param name="theNodeName" select="'narrative_charges'"/>
										<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_CHARGES')"/>
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="narrative_additional_amount[.!='']">
									<xsl:apply-templates select="narrative_additional_amount">
										<xsl:with-param name="theNodeName" select="'narrative_additional_amount'"/>
										<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_AMOUNT')"/>
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="narrative_payment_instructions[.!='']">
									<xsl:apply-templates select="narrative_payment_instructions">
										<xsl:with-param name="theNodeName" select="'narrative_payment_instructions'"/>
										<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS')"/>
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="not($swift2018Enabled)">
									<xsl:if test="narrative_period_presentation[.!='']">
										<xsl:apply-templates select="narrative_period_presentation">
											<xsl:with-param name="theNodeName" select="'narrative_period_presentation'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_PERIOD_PRESENTATION')"/>
										</xsl:apply-templates>
									</xsl:if>
								</xsl:if>
								<xsl:if test="narrative_shipment_period[.!='']">
									<xsl:apply-templates select="narrative_shipment_period">
										<xsl:with-param name="theNodeName" select="'narrative_shipment_period'"/>
										<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SHIPMENT_PERIOD')"/>
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="narrative_sender_to_receiver[.!='']">
									<xsl:apply-templates select="narrative_sender_to_receiver">
										<xsl:with-param name="theNodeName" select="'narrative_sender_to_receiver'"/>
										<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SENDER_TO_RECEIVER')"/>
									</xsl:apply-templates>
								</xsl:if>
							</fo:table-body>
						</fo:table>
					</fo:block>
				</xsl:if>
			</xsl:otherwise>
			</xsl:choose>
			</xsl:if>
			<!-- SWIFT 2018 -->
			<xsl:if test="$swift2018Enabled">
				<fo:block id="periodPresentation" font-family="{$pdfFontData}" font-size="11pt" space-before.conditionality="retain" space-before.optimum="10.0pt">
				<xsl:if test="period_presentation_days[.!=''] or narrative_period_presentation[.!='']">
				<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="subtitle2">
								<xsl:with-param name="text">						
									<xsl:value-of select="localization:getGTPString($language, 'XSL_TAB_PERIOD_PRESENTATION_IN_DAYS')"/>
								</xsl:with-param>
							</xsl:call-template>						
						<xsl:if test="period_presentation_days[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PERIOD_NO_OF_DAYS')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="period_presentation_days"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="narrative_period_presentation[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_TAB_PERIOD_DESCRIPTION')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="narrative_period_presentation"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>			
					</fo:block>		
				</xsl:if>
				
		 <xsl:if test="$swift2019Enabled">
      <xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_DELIVERY_INSTRUCTIONS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<fo:table-row keep-with-previous="always">
							<fo:table-cell>
								<fo:block space-before.conditionality="retain" space-before.optimum="10.0pt"/>
							</fo:table-cell>
						</fo:table-row>
						<xsl:if test="delv_org[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE')"/></xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="delv_org[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_COLLECTION')"/>&nbsp;</xsl:when>
										<xsl:when test="delv_org[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_COURIER')"/>&nbsp;</xsl:when>
										<xsl:when test="delv_org[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_MAIL')"/>&nbsp;</xsl:when>
										<xsl:when test="delv_org[.='04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_MESSENGER')"/>&nbsp;</xsl:when>
										<xsl:when test="delv_org[.='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_REGISTERED_MAIL')"/>&nbsp;</xsl:when>
										<xsl:when test="delv_org[.='99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_OTHER')"/>&nbsp;</xsl:when>
									</xsl:choose>
								</xsl:with-param>		
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="delv_org_text[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text"/>
								<xsl:with-param name="right_text"><xsl:value-of select="delv_org_text"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						
						<xsl:if test="delivery_to[.!=''] or narrative_delivery_to/text[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_DELIVERY_TO_COLLECTION_BY')"/></xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:variable name="delv_to_code"><xsl:value-of select="delivery_to"></xsl:value-of></xsl:variable>								
									<xsl:value-of select="localization:getDecode($language, 'N292', $delv_to_code)"/>
								</xsl:with-param>		
							</xsl:call-template>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="right_text">
									<xsl:if test="narrative_delivery_to/text[.!='']">
										<xsl:value-of select="narrative_delivery_to/text"/>
									</xsl:if>
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
