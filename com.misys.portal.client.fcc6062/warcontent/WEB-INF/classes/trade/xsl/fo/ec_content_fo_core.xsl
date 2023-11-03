<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<!--
		Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com), All
		Rights Reserved.
	-->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" 
				xmlns:formatter="xalan://com.misys.portal.common.tools.ConvertTools"
				xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
				xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils" 
				xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
				xmlns:fo="http://www.w3.org/1999/XSL/Format" 
				xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>
	<xsl:variable name="background">
		BLACK
	</xsl:variable>
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>

	<xsl:template match="ec_tnx_record">
		<!-- HEADER-->
		
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

	<xsl:if test="(not(tnx_id) or (tnx_type_code[.!='01'] and tnx_type_code[.!='03'] and tnx_type_code[.!='04'] and tnx_type_code[.!='13'] and tnx_type_code[.!='15']) or preallocated_flag[.='Y'])">
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
				<xsl:if test="principal_act_no[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="principal_act_no" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="fee_act_no[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="fee_act_no" />
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
				<xsl:if test="remitting_bank/name[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_REMITTING_BANK')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="remitting_bank/name" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="presenting_bank/name[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRESENTING_BANK')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="presenting_bank/name" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
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
				<xsl:if test="fwd_contract_no[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="fwd_contract_no" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		    <xsl:if test="security:isBank($rundata) and (tnx_stat_code[.='04'] or not(tnx_id))">
                        <xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_BANK_MESSAGE')" />	
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="prod_stat_code[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_PROD_STAT_LABEL')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of
									select="localization:getDecode($language, 'N005', prod_stat_code[.])" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="bo_ref_id[.!=''] and tnx_id[.!='']">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="bo_ref_id" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:if>
       <xsl:if test="product_code[.='EC'] and security:isBank($rundata)">
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
							<xsl:value-of select="utils:getCompanyName(ref_id,product_code)"/>
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
					  </xsl:with-param>
				  </xsl:call-template> 
				  </xsl:if>	
				  <xsl:if test="release_dttm[.!='']">
				  <xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_RELEASE_DTTM')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="formatter:formatReportDate(release_dttm,$rundata)"/>
						</xsl:with-param>
					</xsl:call-template>	
					</xsl:if>			
					</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			<fo:block id="reportdetails"/>
			<xsl:if test="security:isBank($rundata)">
                     <xsl:call-template name="table_template">
                           <xsl:with-param name="text">
                                  <xsl:call-template name="title">
                                         <xsl:with-param name="text">
                                                <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REPORTING_DETAILS')"/>
                                         </xsl:with-param>
                                  </xsl:call-template>   
                                    <xsl:choose>
                                  <xsl:when test="tnx_type_code[.!='15']"> 
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
									<xsl:when test="prod_stat_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_03_NEW')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_04_ACCEPTED')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_05_SETTLED')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='06']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_06_CANCELLED')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_07_UPDATED')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='32']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_32_AMENDMENT_REFUSED')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_08_AMENDED')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='09']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_09_EXTENDED')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='10']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_10_PURGED')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='11']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_11_RELEASED')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='12']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_12_DISCREPANT')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='13']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_13_PART_SETTLED')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='14']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_14_PART_SIGHT_PAYMT')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='15']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_15_FULL_SIGHT_PAYMT')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='16']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_16_NOTIFICATION_OF_CHARGES')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='24']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_24_REQUEST_FOR_SETTLEMENT')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='26']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_26_CLEAN')"/></xsl:when> 
									<xsl:when test="prod_stat_code[.='31']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_31_AMENDMENT_AWAITING_BENEFICIARY_APPROVAL')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='42']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_42_EXPIRED')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='78']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_78_WORDING_UNDER_REVIEW')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='79']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_79_FINAL_WORDING')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='81']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_81_CANCEL_AWAITING_BENEFICIARY_RESPONSE')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='82']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_82_CANCEL_REFUSED')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='84']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_84_CLAIM_PRESENTATION')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='85']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_85_CLAIM_SETTLEMENT')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='86']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_86_EXTEND_PAY')"/></xsl:when>
									<xsl:when test="prod_stat_code[.='66']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_66_ESTABLISHED')"/></xsl:when>
								    <xsl:when test="prod_stat_code[.='72']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PRODSTATCODE_72_PO_ESTABLISHED')"/></xsl:when>     
                              </xsl:choose>
                                    </xsl:with-param>
                             </xsl:call-template>
                             </xsl:otherwise>
                              </xsl:choose>    
                             <xsl:if test="release_dttm[.!=''] and security:isCustomer($rundata)">
                             <xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_RELEASE_DTTM')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="formatter:formatReportDate(release_dttm,$rundata)"/>
								</xsl:with-param>
							</xsl:call-template>
							</xsl:if>	
					<xsl:if test="tnx_type_code[. = '01'] and bo_ref_id[.!='']">
                         <xsl:call-template name="table_cell">
                                <xsl:with-param name="left_text">
                                       <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/>
                                </xsl:with-param>
                                <xsl:with-param name="right_text">
                                <xsl:value-of select="bo_ref_id"/>
                           </xsl:with-param>
                         </xsl:call-template>   
                     </xsl:if>
                     <xsl:if test="(prod_stat_code[.='04'] or prod_stat_code[.='12'] or prod_stat_code[.='13'] or prod_stat_code[.='14'] or prod_stat_code[.='15'] or prod_stat_code[.='05'] or prod_stat_code[.='07'])and tnx_amt[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_DOCS_AMT_LABEL')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="tnx_cur_code" />&nbsp;<xsl:value-of select="tnx_amt" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
                     <xsl:if test="maturity_date[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_MATURITY_DATE')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="maturity_date"/>
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
					<xsl:if test="dir_coll_letter_flag[. = 'Y'] and security:isBank($rundata) and ec_type_code[.='02']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_DIR_COLL_LETTER_LABEL')"/>
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
					<!-- bo_template_id -->
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
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_COLL_TYPE_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="ec_type_code[.='01']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_COLL_TYPE_REGULAR')"/>
								</xsl:when>
								<xsl:when test="ec_type_code[.='02'] or ec_type_code[.='03']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_COLL_TYPE_DIRECT')"/>
								</xsl:when>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<fo:block font-weight="bold">
								<xsl:choose>
									<xsl:when test="term_code[. = '01']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DP')"/>
									</xsl:when>
									<xsl:when test="term_code[. = '02']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DA')"/>
									</xsl:when>
									<xsl:when test="term_code[. = '03']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_OTHER')"/>
									</xsl:when>
									<xsl:when test="term_code[. = '04']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_AVAL')"/>
									</xsl:when>
								</xsl:choose>
					     	<xsl:if test="tenor_desc[.!='']"><xsl:text> / </xsl:text><xsl:value-of select="tenor_desc"/></xsl:if>
							<xsl:if test="term_code[.!='01'] and (term_code[.!='03'] or tenor_type[.!='01']) and tenor_days[.!=''] and tenor_period[.!='']">
						     	<xsl:text> / </xsl:text><xsl:value-of select="tenor_days"/>
						     	<xsl:text> </xsl:text>
						     	<xsl:choose>
							     	<xsl:when test="tenor_period[.='D']">
							     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_DAYS')"/>
							     	</xsl:when>
							     	<xsl:when test="tenor_period[.='W']">
							     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_WEEKS')"/>
							     	</xsl:when>
							     	<xsl:when test="tenor_period[.='M']">
							     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_MONTHS')"/>
							     	</xsl:when>
							     	<xsl:when test="tenor_period[.='Y']">
							     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_YEARS')"/>
							     	</xsl:when>
						     	</xsl:choose>
						     	<xsl:choose>
							     	<xsl:when test="tenor_from_after[.='A']">
							     		<xsl:text> </xsl:text>
							     	          <xsl:value-of select="localization:getDecode($language, 'C052', tenor_from_after)"/>
							     		<xsl:text> </xsl:text>
							     	</xsl:when>
							     	<xsl:when test="tenor_from_after[.='E']">
							     		<xsl:text> </xsl:text>
							     	          <xsl:value-of select="localization:getDecode($language, 'C052', tenor_from_after)"/>
							     		<xsl:text> </xsl:text>
							     	</xsl:when>
							     	<xsl:when test="tenor_from_after[.='F']">
							     		<xsl:text> </xsl:text>
							     	          <xsl:value-of select="localization:getDecode($language, 'C052', tenor_from_after)"/>
							     		<xsl:text> </xsl:text>
							     	</xsl:when>
						     	</xsl:choose>
						     	<xsl:choose>
							     	<xsl:when test="tenor_days_type[.='O']">
							     			<xsl:value-of select="tenor_type_details"/>
							     	</xsl:when>
							     	<xsl:otherwise>
			     					     	 <xsl:value-of select="localization:getDecode($language, 'C053', tenor_days_type)"/>
							     	</xsl:otherwise>
						     	</xsl:choose>
				     	</xsl:if>
						</fo:block>
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DRAFT_AGAINST')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
						<xsl:choose>
					     <xsl:when test="tenor_type[.='01']">
					     <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_SIGHT')"/>
					     </xsl:when>
   					     <xsl:when test="tenor_type[.='02']">
   					     <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_ACEP')"/>
   					     </xsl:when>
   					     <xsl:when test="tenor_type[.='03']">
   					     <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_AVAL')"/>
   					     </xsl:when>
					     </xsl:choose>
						</xsl:with-param>
				</xsl:call-template>
					<!-- <xsl:if test="(dir_coll_letter_flag[. = 'Y'] and security:isCustomer($rundata)) or (ec_type_code[.!='02'] and security:isBank($rundata)) "> -->
				<xsl:if test="tenor_maturity_date[.!='']">
				<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_MATURITY')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="tenor_maturity_date"/>
						</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="table_cell">				
						<xsl:with-param name="right_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_MATURITY_DISCLAIMER')"/>							
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="tenor_base_date[.!='']">
				<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_BASE_DATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="tenor_base_date"/>
						</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<!-- </xsl:if> -->
				<xsl:if test="dir_coll_letter_flag[.='Y']">
				<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_DIR_COLL_LETTER_LABEL')"/>
						</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="boe_flag[.='Y']">
				<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_BILL_OF_EXCHANGE')"/>
						</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<!--Drawer Details-->
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DRAWER_DETAILS')"/>
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
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="drawer_name"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- Address -->
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="drawer_address_line_1"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="drawer_address_line_2[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="drawer_address_line_2"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="drawer_dom[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="drawer_dom"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="drawer_address_line_4[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="drawer_address_line_4"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="drawer_country[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getCodeData($language,'*','*','C006',drawer_country)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>

					<xsl:if test="drawer_reference[.!='']">
						<xsl:variable name="drawer_ref"><xsl:value-of select="drawer_reference"/></xsl:variable>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
								    <xsl:when test="security:isBank($rundata)">
      									<xsl:value-of select="utils:decryptApplicantReference($drawer_ref)"/>
    	 							</xsl:when>
    	 							<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$drawer_ref]) &gt;= 1">
								      	<xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$drawer_ref]/description"/>
								    </xsl:when>
							        <xsl:otherwise>
								     	<xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$drawer_ref]/description"/>
								    </xsl:otherwise>
									
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<!--Drawee Details-->
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DRAWEE_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="drawee_name[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="drawee_name"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<!--  Address -->
					<xsl:if test="drawee_address_line_1[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="drawee_address_line_1"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:if test="drawee_address_line_2[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="drawee_address_line_2"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="drawee_dom[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="drawee_dom"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="drawee_address_line_4[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="drawee_address_line_4"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>

					<xsl:if test="drawee_country[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getCodeData($language,'*','*','C006',drawee_country)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="drawee_reference[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="drawee_reference"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<!--Amount  Details-->
			<fo:block id="amountdetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
				<xsl:choose>
      				<xsl:when test="tnx_type_code[.='03'] and tnx_stat_code[.!='04']">
      					<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_COLL_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
							<xsl:value-of select="concat(ec_cur_code , ' ' , org_previous_file/ec_tnx_record/ec_amt)"/>
							</xsl:with-param>
						</xsl:call-template>
      				</xsl:when>
      				<xsl:otherwise>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_COLL_AMT_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="concat(ec_cur_code , ' ' , ec_amt)"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
					<!-- MPS-41651- Available Amount -->
					<xsl:if test="not(tnx_id) or ec_outstanding_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="concat(ec_cur_code , ' ' , ec_outstanding_amt)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- MPS-55947(In case of of collections liability amount won't be updated as per banks perspective) -->
					<!-- <xsl:if test="not(tnx_id) or ec_liab_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="concat(ec_cur_code , ' ' , ec_liab_amt)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if> -->
				</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="ec_type_code !=''">
			<xsl:if test="((security:isBank($rundata) and  securitycheck:hasPermission($rundata,'tradeadmin_ls_access')) or (security:isCustomer($rundata) and securitycheck:hasPermission($rundata,'ls_access') = 'true')) and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true'">
			<!-- linked licenses -->
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
		  </xsl:if>
		  
			<!--Bank Details-->
			<fo:block id="bankdetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BANK_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="security:isCustomer($rundata)">
					<xsl:apply-templates select="remitting_bank">
						<xsl:with-param name="theNodeName" select="'remitting_bank'"/>
						<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_REMITTING_BANK')"/>
					</xsl:apply-templates>
					<xsl:variable name="drawer_ref"><xsl:value-of select="drawer_reference"/></xsl:variable>
					<xsl:variable name="rem_bank"><xsl:value-of select="//ec_tnx_record/remitting_bank/abbv_name"/></xsl:variable>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CUST_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
							    <xsl:choose>
							    <xsl:when test="defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'">
							    <xsl:choose>
							    <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$drawer_ref]) >= 1">
									<xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank[abbv_name = $rem_bank]/entity/customer_reference[reference=$drawer_ref]/reference)"/>
								</xsl:when>
								<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$drawer_ref]) = 0">
										<xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank[abbv_name = $rem_bank]/customer_reference[reference=$drawer_ref]/reference)"/>
								</xsl:when>
							    </xsl:choose>
							    </xsl:when>
							    <xsl:otherwise>
							    <xsl:choose>
							    <xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$drawer_ref]) >= 1">
									<xsl:value-of select="//*/avail_main_banks/bank[abbv_name = $rem_bank]/entity/customer_reference[reference=$drawer_ref]/description"/>
								</xsl:when>
								<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$drawer_ref]) = 0">
										<xsl:value-of select="//*/avail_main_banks/bank[abbv_name = $rem_bank]/customer_reference[reference=$drawer_ref]/description"/>
								</xsl:when>
							    </xsl:choose>
							    
							    </xsl:otherwise>
								
							    </xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="presenting_bank/name[.!='']">
						<xsl:apply-templates select="presenting_bank">
							<xsl:with-param name="theNodeName" select="'presenting_bank'"/>
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_PRESENTING_BANK')"/>
						</xsl:apply-templates>
						  <xsl:if test="presenting_bank/contact_name[.!='']"> 
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_DETAILS_CONTACT_PERSON_DETAILS')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="presenting_bank/contact_name" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="presenting_bank/phone[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_DETAILS_PO_CONTACT_PHONE_NUMBER')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="presenting_bank/phone" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
					</xsl:if>
					<xsl:if test="collecting_bank/name[.!='']">
						<xsl:apply-templates select="collecting_bank">
							<xsl:with-param name="theNodeName" select="'collecting_bank'"/>
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_COLLECTING_BANK')"/>
						</xsl:apply-templates>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			
		  
		  <!-- Desc of Goods Narrative -->
			<fo:block id="goodsdescription"/>
			<xsl:if test="narrative_description_goods[.!='']">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">	
     				<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DESCRIPTION_GOODS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:apply-templates select="narrative_description_goods">
							<xsl:with-param name="theNodeName"
								select="'narrative_description_goods'" />
							<xsl:with-param name="theNodeDescription"
								select="localization:getGTPString($language, 'XSL_LABEL_DESCRIPTION_GOODS')" />
						</xsl:apply-templates>
			    </xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			
			<!--Shipment Details-->
			<fo:block id="shipmentdetails"/>
			<xsl:if test="bol_number[.!=''] or shipping_by[.!=''] or ship_from[.!=''] or ship_to[.!=''] or inco_term[.!=''] or inco_place[.!='']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SHIPMENT_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="bol_number[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_BOL_NUMBER')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="bol_number"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="shipping_by[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_SHIPPING_BY')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="shipping_by"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
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
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="inco_term_year[.!='']">
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_INCO_TERM_YEAR')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
								  <xsl:value-of select="inco_term_year"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="inco_term[.!='']">
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_INCO_TERM')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
								   <xsl:value-of select="localization:getCodeData($language,'*','*','N212',inco_term)"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="inco_place[.!='']">
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_INCO_PLACE')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="inco_place"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:if>
			<!-- Collections instructions -->
			<!-- Acceptance and Payment Send Modes -->
			<fo:block id="collectionsinstructions"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_COLLECTION_INSTRUCTIONS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="paymt_adv_send_mode[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_PAYMT_ADV_SEND_MODE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="paymt_adv_send_mode[.='01']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/>
									</xsl:when>
									<xsl:when test="paymt_adv_send_mode[.='02']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/>
									</xsl:when>
									<xsl:when test="paymt_adv_send_mode[.='03']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/>
									</xsl:when>
									<xsl:when test="paymt_adv_send_mode[.='04']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_REGISTERED_POST')"/>
									</xsl:when>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="accpt_adv_send_mode[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_ACCPT_ADV_SEND_MODE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="accpt_adv_send_mode[.='01']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/>
									</xsl:when>
									<xsl:when test="accpt_adv_send_mode[.='02']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/>
									</xsl:when>
									<xsl:when test="accpt_adv_send_mode[.='03']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/>
									</xsl:when>
									<xsl:when test="accpt_adv_send_mode[.='04']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_REGISTERED_POST')"/>
									</xsl:when>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="open_chrg_brn_by_code[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_OPEN_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="open_chrg_brn_by_code[. = '04']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_DRAWER')"/>
								</xsl:when>
								<xsl:when test="open_chrg_brn_by_code[. = '03']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_DRAWEE')"/>
								</xsl:when>
								<xsl:otherwise/>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
						<xsl:if test="corr_chrg_brn_by_code[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_CORR_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="corr_chrg_brn_by_code[. = '04']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_DRAWER')"/>
								</xsl:when>
								<xsl:when test="corr_chrg_brn_by_code[. = '03']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_DRAWEE')"/>
								</xsl:when>
								<xsl:otherwise/>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
						<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="waive_chrg_flag[. = 'Y']">
									<fo:block>
				                    	<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_WAIVE_YES')"/>
				                  	</fo:block>
								</xsl:when>
								<xsl:when test="waive_chrg_flag[. = 'N']">
									<fo:block>
				                    	<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_WAIVE_NO')"/>
				                  	</fo:block>
								</xsl:when>
								<!--<xsl:otherwise/>-->
							</xsl:choose>
							</xsl:with-param>
							</xsl:call-template>
							
							
							
							<!-- Protest and Other Instructions -->
							<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="protest_non_paymt[. = 'Y']">
									<fo:block>
			                   	 		<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_PROTEST_PAYMT_YES')"/>
			                 	 	</fo:block>
								</xsl:when>
								<xsl:when test="protest_non_paymt[. = 'N']">
									<fo:block>
				                    	<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_PROTEST_PAYMT_NO')"/>
				                  	</fo:block>
								</xsl:when>
							</xsl:choose>
							</xsl:with-param>
							</xsl:call-template>
							
							<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
							<xsl:when test="term_code[.='02']">
								<xsl:choose>
									<xsl:when test="protest_non_accpt[. = 'Y']">
										<fo:block>
					                      <xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_PROTEST_ACCPT_YES')"/>
					                    </fo:block>
									</xsl:when>
									<xsl:when test="protest_non_accpt[. = 'N']">
										<fo:block>
					                      <xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_PROTEST_ACCPT_NO')"/>
					                    </fo:block>
									</xsl:when>
									<!--<xsl:otherwise/>-->
								</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="protest_non_accpt[. = 'Y']">
									<fo:block>
		                      <xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_PROTEST_ACCPT_FLAG')"/>
		                    </fo:block>
							</xsl:if>
								</xsl:otherwise>
								</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			
			<!--	</fo:list-block>-->

			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
							<xsl:if test="protest_adv_send_mode[.!='']">			
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_PROTEST_ADV_SEND_MODE_LABEL')"/>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:choose>
											<xsl:when test="protest_adv_send_mode[.='01']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/>
											</xsl:when>
											<xsl:when test="protest_adv_send_mode[.='02']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/>
											</xsl:when>
											<xsl:when test="protest_adv_send_mode[.='03']">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/>
											</xsl:when>
											<xsl:when test="protest_adv_send_mode[.='04']">
												<xsl:value-of select="localization:getGTPString($language,  'XSL_INSTRUCTIONS_ADV_SEND_MODE_REGISTERED_POST')"/>
											</xsl:when>
										</xsl:choose>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>	
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
									<xsl:choose>
									<xsl:when test="term_code[.='02']">
											<xsl:choose>
												<xsl:when test="accpt_defd_flag[. = 'Y']">
													<fo:block>
                        								<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_ACCPT_DEFD_YES')"/>
                      								</fo:block>
												</xsl:when>
												<xsl:when test="accpt_defd_flag[. = 'N']">
													<fo:block>
						                       			 <xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_ACCPT_DEFD_NO')"/>
						                      		</fo:block>
												</xsl:when>
											</xsl:choose>
										</xsl:when>
										<xsl:otherwise>
										<xsl:if test="accpt_defd_flag[. = 'Y']">
											<fo:block>
					                        	<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_ACCPT_DEFD_FLAG')"/>
					                      	</fo:block>
										</xsl:if>
										</xsl:otherwise>
									</xsl:choose>
									</xsl:with-param>
									</xsl:call-template>
								   <xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
									<xsl:choose>
									<xsl:when test="store_goods_flag[. = 'Y']">
											<fo:block>
											          <xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_STORE_GOODS_YES')"/>
											</fo:block>
										</xsl:when>
										<xsl:when test="store_goods_flag[. = 'N']">
												<fo:block>
												          <xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_STORE_GOODS_NO')"/>
												</fo:block>
										</xsl:when>
									</xsl:choose>
									</xsl:with-param>
								</xsl:call-template>
								
				</xsl:with-param>
			</xsl:call-template>		
			<xsl:if test="needs_refer_to[.!='']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_NEEDS_REFER_TO')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="needs_refer_to"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text"/>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="needs_instr_by_code[. = 'Y']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_NEEDS_INFORMATION_ONLY')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_NEEDS_ACCEPT_NO_RESERVE')"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			
		  <xsl:if test="narrative_additional_instructions[.!='']">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
				<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
                  <xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_OTHER_INSTRUCTIONS')"/>
				</xsl:with-param>
					<xsl:with-param name="right_text">
							<xsl:value-of select="narrative_additional_instructions" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
           </xsl:if>
					
			<!-- return comments -->
<!-- 		<xsl:call-template name="return-comments"/> -->
		
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
			<!--Documents-->
			<xsl:if test="documents/document">
			<fo:block id="documents"/>
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DOCUMENTS')"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>			
				<fo:block keep-together="always">
					<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
						<fo:table-column column-width="{$pdfTableWidth}"/>	
						<fo:table-column column-width="0"/> <!--  dummy column -->	
						<fo:table-body>
							<fo:table-row>
							<fo:table-cell>
							<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
						      	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
			  				       	<fo:table-column column-width="15.0pt"/>
			  				       	<fo:table-column column-width="proportional-column-width(2)"/>
			  				       	<fo:table-column column-width="proportional-column-width(2)"/>
			  				       	<fo:table-column column-width="proportional-column-width(2)"/>
			  				       	<fo:table-column column-width="proportional-column-width(2)"/>
						        	<fo:table-column column-width="proportional-column-width(2)"/>
						        	<fo:table-column column-width="proportional-column-width(2)"/>
						        	<fo:table-column column-width="proportional-column-width(2)"/>
						        	<fo:table-column column-width="proportional-column-width(1)"/>
						        	<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
										<fo:table-row text-align="center">
										<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell>
										<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".5pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_COLUMN_DOCUMENT')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".5pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_NO')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".5pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_DATE')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".5pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_1ST_MAIL_LABEL')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".5pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_2ND_MAIL_LABEL')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".5pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_TOTAL')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".5pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_MAP_TO_ATTACHMENT')"/></fo:block></fo:table-cell>
						        		</fo:table-row>
						        	</fo:table-header>
						        	<fo:table-body>
							        		<xsl:for-each select="documents/document">
							        		<fo:table-row>
												<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
													<fo:block text-align="center" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:choose>
															<xsl:when test="code and code[.!= ''] and code[.!= '99']">
																<xsl:value-of select="localization:getDecode($language, 'C064', code)"/>
															</xsl:when>
															<xsl:when test="name and name[.!='']">
																<xsl:value-of select="name" />
															</xsl:when>
															<xsl:otherwise />
														</xsl:choose>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
													<fo:block text-align="center" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="doc_no"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
													<fo:block text-align="center" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="doc_date"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
													<fo:block text-align="center" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="first_mail"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
													<fo:block text-align="center" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="second_mail"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
													<fo:block text-align="center" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="total"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
													<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="mapped_attachment_name"/>
														</xsl:call-template>
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
