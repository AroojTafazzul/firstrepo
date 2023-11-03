<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<!-- Copyright (c) 2006-2012 Misys , All Rights Reserved -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:formatter="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:securityUtils="xalan://com.misys.portal.common.tools.SecurityUtils"
	exclude-result-prefixes="security xmlRender formatter utils">
	<!--
		***********************************************************************************************
	-->
	<!--
		This stylesheet has the common functions to display products summaries
		by the XSL-FO stylesheets
	-->
	<!--
		***********************************************************************************************
	-->
	<xsl:import href="fo_common.xsl" />
	<xsl:param name="rundata" />
	<xsl:param name="option" />
	<xsl:param name="isMultiBank">N</xsl:param>
	<xsl:param name="optionCode">OTHERS</xsl:param>

	<!--Summary of the  transaction-->
	<xsl:template name="product_summary">
		<!-- Event Summary Header -->
			<fo:block id="evedetails" />
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:if test="tnx_stat_code[.='01' or .='02' or .='05' or .='06'] or (finance_requested_flag[.='Y' or .='P'] and tnx_type_code[.='63'])">
					<!-- xsl:if test="tnx_stat_code = '02'" -->
					<fo:table-row>
						<fo:table-cell number-columns-spanned="2">
							<fo:block color="black" space-before.optimum="10.0pt"
								space-before.conditionality="retain">
								<xsl:value-of select="localization:getGTPString($language, 'INFO_MSG_PREVIEW_UNCONTROLLED')" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:if>
				<xsl:call-template name="title">
					<xsl:with-param name="text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_HEADER_EVENT_DETAILS')" />
					</xsl:with-param>
				</xsl:call-template>
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
				 <xsl:variable name="ref_id_for_company_name"><xsl:value-of select="ref_id"/></xsl:variable>
     			<xsl:variable name="product_code"><xsl:value-of select="product_code"/></xsl:variable>
				<xsl:if test="company_name[.!=''] and sub_product_code[.!='TRINT'] and sub_product_code[.!='TRTPT'] and product_code[.!='FX'] and product_code[.!='SE']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_COMPANY_NAME')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
						 <xsl:value-of select="utils:getCompanyName($ref_id_for_company_name,$product_code)"/>
					</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="company_name[.!=''] and product_code[.='FX']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_COMPANY_NAME')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
						 <xsl:value-of select="utils:getCompanyName($ref_id_for_company_name,$product_code)"/>
					</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
						<xsl:if test="company_name[.!=''] and product_code[.='SE']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_COMPANY_NAME')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
						 <xsl:value-of select="utils:getCompanyName($ref_id_for_company_name,$product_code)"/>
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
						<xsl:choose>
			      			<xsl:when test="product_code[.='BK'] and sub_product_code[.!=''] and sub_product_code[.='LNRPN']">
			      			<xsl:value-of select="localization:getDecode($language, 'N001', 'LN')"/></xsl:when>
			       			<xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N001', product_code[.])"/></xsl:otherwise>
			       		</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="sub_product_code[.!=''] and product_code[.!='IN' and .!='IP']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:choose>
			      			<xsl:when test="product_code[.='TF']">
			      				<xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_LABEL')" />
			      			</xsl:when>
			       			<xsl:otherwise>
			       				<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_SUBPRODUCT_CODE')" />
			       			</xsl:otherwise>
			       		</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of
							select="localization:getDecode($language, 'N047', sub_product_code[.])" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="tnx_type_code[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_TYPE')" />
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
									  <xsl:if test="tnx_type_code[.='86'] or tnx_type_code[.='87']">
										 <xsl:value-of select="concat(' [',localization:getGTPString($language, 'XSL_OLD_NAME'),old_name,',',localization:getGTPString($language, 'XSL_NEW_NAME'),new_name,']')" />
									</xsl:if>
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
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="ref_id" />
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="(iss_date[.!=''] and product_code[.!='BG'] and tnx_stat_code[.!='04']) or (product_code[.='BG'] and tnx_type_code[.!= '03'] and tnx_type_code[.!='01'])">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ISSUE_DATE')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="iss_date"/>
							</xsl:with-param>
						</xsl:call-template>
				</xsl:if>
					<xsl:if test="entity[.!=''] and sub_product_code[.='CQBKR']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ENTITY')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="entity"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				<xsl:if test="product_code='EC' and presenting_bank/name !='' and tnx_type_code[.!= '01']">
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
				<xsl:if test="product_code='EC' and remitting_bank/name !='' and tnx_type_code[.!= '01']">
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
				<xsl:if test="product_code[.='FX'] and tnx_stat_code[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_STAT_CODE_LABEL')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="localization:getDecode($language, 'N004', tnx_stat_code)" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>

				<xsl:if test="product_code[.='FT'] and (sub_product_code[.='TRINT'] or sub_product_code[.='TRTPT']) and tnx_stat_code[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_STAT_CODE_LABEL')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="localization:getDecode($language, 'N004', tnx_stat_code)" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="(product_code[.='TD'] and sub_product_code[.='TRTD']) and tnx_stat_code[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_STAT_CODE_LABEL')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="localization:getDecode($language, 'N004', tnx_stat_code)" />
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
			<!-- 	<xsl:if test="not(product_code[.='IP'] and tnx_type_code[.='85'])">  -->
				<xsl:if test="cust_ref_id[.!=''] and (product_code[.!='FX'] and product_code[.!='BK'] and sub_product_code[.!='TRTD'])">
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
				<xsl:if test="bo_tnx_id[.!=''] and product_code[.!='FX'] and product_code[.!='TD'] and sub_product_code[.!='TRTPT'] and sub_product_code[.!='TRINT'] " >
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_EVENT_REFERENCE')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bo_tnx_id" />
						</xsl:with-param>
					</xsl:call-template>
 	     		</xsl:if>
 	     				
 	     		<!-- Related Event Reference -->
					 <xsl:if test="prod_stat_code[.='08' or .='06'] and tnx_type_code[.='03' or .='15'] and cross_references">
 	   					<xsl:choose>
		  				<xsl:when test="product_code[.='LC']">
							<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'RELATED_EVENT_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="org_previous_file/lc_tnx_record/bo_tnx_id"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:when>
						<xsl:when test="product_code[.='EL'] and org_previous_file/el_tnx_record/bo_tnx_id[.!='']">
							<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'RELATED_EVENT_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="org_previous_file/el_tnx_record/bo_tnx_id"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:when>
						
						<xsl:when test="product_code[.='BG']">
							<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'RELATED_EVENT_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="org_previous_file/bg_tnx_record/bo_tnx_id"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:when>
						
						<xsl:when test="product_code[.='BR']">
							<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'RELATED_EVENT_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="org_previous_file/br_tnx_record/bo_tnx_id"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:when>												
						<xsl:when test="product_code[.='SI']">
							<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'RELATED_EVENT_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="org_previous_file/si_tnx_record/bo_tnx_id"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:when>												

						<xsl:when test="product_code[.='SR']  and org_previous_file/sr_tnx_record/bo_tnx_id[.!='']">
							<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'RELATED_EVENT_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="org_previous_file/sr_tnx_record/bo_tnx_id"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:when>												
						</xsl:choose>
					</xsl:if>
				<xsl:if test="cust_ref_id[.!=''] and (product_code[.='BK'])">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BULK_REF_ID')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="cust_ref_id" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
					<xsl:if test="bo_ref_id[.!=''] and product_code[.='SE' or .='LI' or .='LC' or .='EC']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SE_BANK_REF')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bo_ref_id"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="tnx_type_code[.='24']">					  
					  <xsl:if test="exp_date[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_DATE')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="exp_date" />
							</xsl:with-param>
						</xsl:call-template>
					 </xsl:if>
					  
					   <xsl:if test="tnx_cur_code[.!=''] and tnx_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:choose>
						            <xsl:when test="product_code[.='LC' or .='EL' or .='SI' or .='SR']">
						            	<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_LC_AMT_LABEL')" />
						            </xsl:when>
						            <xsl:when test="product_code[.='EC' or .='IC' or .='IR']">
						           	 	<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_COLL_AMT_LABEL')" />
									</xsl:when>
						            <xsl:when test="product_code[.='SG' or .='BG' or .='BR']">
						            	<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_GTEE_AMT_LABEL')" />
						            </xsl:when>
						           	 <xsl:when test="product_code[.='LI']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_LI_AMT_LABEL')" />
									 </xsl:when>
					           </xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
						          <xsl:when test="product_code[.='LC'] or product_code[.='SI'] or product_code[.='EL'] or product_code[.='SR']">
						          		<xsl:value-of select="lc_cur_code"/>&nbsp;<xsl:value-of select="lc_amt"/>
						          </xsl:when>
						           <xsl:when test="product_code[.='BG'] or product_code[.='BR']">
						          		 <xsl:value-of select="bg_cur_code"/>&nbsp;<xsl:value-of select="bg_amt"/>
						           </xsl:when>
						           <xsl:otherwise>
							          <xsl:variable name="cur_code_name"> <xsl:value-of select="product_code"/>_cur_code  </xsl:variable>
							          <xsl:variable name="amt_name"> <xsl:value-of select="product_code"/>_amt  </xsl:variable>
							          <xsl:value-of select="$cur_code_name"/>&nbsp;<xsl:value-of select="$amt_name"/>
						           </xsl:otherwise>
					           </xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					 </xsl:if>
			     </xsl:if>
				<xsl:if test="(sub_product_code[.='INT'] or sub_product_code[.='TPT']) and counterparties/counterparty[counterparty_type='02']/counterparty_reference[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BEN_REF')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="counterparties/counterparty[counterparty_type='02']/counterparty_reference" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="cross_references/cross_reference/child_product_code[.='SG']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_NO_LINKED_REFERENCE')" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="product_code[.='IN' or .='IP' or .='BG' or .='IC' or .='BK' or .='EC' or .='IR' or .='LS'] or sub_product_code[.='PICO']">
						<xsl:if test="(bo_ref_id[.!=''] and ((product_code[.!='SE'] and (not(tnx_id) or tnx_type_code[.!='01'] or preallocated_flag[.='Y']) and (product_code[.='IC'])) or ((product_code[.='LC'] or product_code[.='EL'] or product_code[.='BR']  or product_code[.= 'LS'] or product_code[.='IR']) and ((tnx_type_code[.='01'] and tnx_stat_code[.='04']) or tnx_type_code[.!='01'] or preallocated_flag[.='Y']))))">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="bo_ref_id" />
									</xsl:with-param>
								</xsl:call-template>
						</xsl:if>
						<xsl:if test="fin_bo_ref_id[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_FIN_BO_REF_ID')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="fin_bo_ref_id" />
									</xsl:with-param>
								</xsl:call-template>
						</xsl:if>
						<xsl:if test="issuing_bank/name[.!=''] and product_code[.!='LS'] and sub_tnx_type_code[.!='24']">
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
						<!-- Presenting bank details appears twice in event details at Bank side as this field is specified in ic_content_fo_core also -->
						<!-- issue fix MPS-59908 -->
						<!-- <xsl:if test="presenting_bank/name[.!=''] and product_code[.='IC'] and not(security:isBank($rundata))">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRESENTING_BANK')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="presenting_bank/name" />
									</xsl:with-param>
								</xsl:call-template>
						</xsl:if> -->
						<xsl:if test="sub_tnx_type_code[.!='A4'] and ((product_code[.!='IP' or .!='IN'])and tnx_type_code[.!='85']) and sub_prod_code[.!='PICO']">
							<xsl:if test="iss_date[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
										select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IN_INVOICE_DATE')" />
									</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="iss_date"/>
										</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="due_date[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
										select="localization:getGTPString($language, 'XSL_GENERALDETAILS_DUE_DATE')" />
									</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="due_date"/>
										</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:if>
					   
						<xsl:if test="repay_date[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
									select="localization:getGTPString($language, 'XSL_REPAYMENT_FINANCE_DATE')" />
								</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="repay_date"/>
									</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
				</xsl:if>
				<!-- Provisional flow for finance request event details : START -->
				<xsl:if test="product_code[.='TF'] and tnx_type_code[.='13'] and sub_tnx_type_code[.='66' or .='67']">
					<xsl:if test="tenor[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DAYS')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="tenor" />
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
				</xsl:if>
				<!-- Provisional flow for finance request event details : END -->
				<xsl:if test="product_code[.='EA'] and nb_mismatch[. != '']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_LABEL_NO_OF_MISMATCHES')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="nb_mismatch" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="product_code[.='EA'] and mismatches[. != '']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_MISMATCHES')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:call-template name="cr_replace">
							 	<xsl:with-param name="input_text">
							 		<xsl:value-of select="mismatches" />
							 	</xsl:with-param>
							 </xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="product_code[.='FX'] or (product_code[.='TD'] and sub_product_code[.='TRTD'])">
        		<!-- Trade ID -->
				<xsl:if test="trade_id[. != '']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_CONTRACT_FX_TRADE_ID_LABEL')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="trade_id" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				
				<xsl:if test="bo_tnx_id[. != '']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_TNX_ID')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="bo_tnx_id" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				
				</xsl:if> 
		
					<xsl:if test="product_code[.='FX']">
										
						<!-- Transaction Currency / Amount: -->
						<xsl:if test="fx_cur_code[. != ''] or fx_amt[. != ''] or tnx_cur_code[. != ''] or tnx_amt[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TNX_AMT_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="product_code[.='FX'] and tnx_cur_code[.!=''] and tnx_amt[.!='']">
											<xsl:value-of select="concat(tnx_cur_code, ' ', tnx_amt)" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="concat(fx_cur_code, ' ', fx_amt)" />
										</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:if>
											
						<xsl:if test="(product_code[.='FX'] or (product_code[.='TD'] and sub_product_code[.='TRTD'])) and rate[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CONTRACT_FX_RATE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="rate" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="(product_code[.='TD'] and sub_product_code[.='TRTD'])">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'APPL_DATE')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="appl_date" />
								</xsl:with-param>
							</xsl:call-template>
							
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_TD_START_DATE')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="value_date" />
								</xsl:with-param>
							</xsl:call-template>
						<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_TD_MATURITY_DATE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="maturity_date" />
								</xsl:with-param>
							</xsl:call-template>
							
							<xsl:if test="td_cur_code[. != ''] or td_amt[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_TD_AMOUNT_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="concat(td_cur_code, ' ', td_amt)" />
								</xsl:with-param>
							</xsl:call-template>
							</xsl:if>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_TD_INTEREST_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="interest" />
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_TD_TOTAL_WITH_INTEREST_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="total_with_interest" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					<xsl:if test="product_code[.='FX'] and (prod_stat_code[.='03'] or tnx_type_code[.='13'])">				
						<!-- Counter Transaction Currency / Amount: -->
							<xsl:if test="counter_cur_code[. != ''] or counter_amt[. != '']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_CONTRACT_FX_COUNTER_TRANSACTION_COUNTER_AMT')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:choose>
											<xsl:when test="product_code[.='FX'] and tnx_counter_amt[.!='']">
												<xsl:value-of select="concat(counter_cur_code, ' ', tnx_counter_amt)" />
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="concat(counter_cur_code, ' ', counter_amt)" />
											</xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						
							<!-- Application Date -->
						 <xsl:if test="appl_date[. != ''] and tnx_type_code[.='13']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
										<xsl:value-of 
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
										<xsl:value-of select="appl_date" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if> 
						
							<!-- Option Date -->
						<xsl:if test="option_date[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
										<xsl:value-of 
											select="localization:getGTPString($language, 'XSL_CONTRACT_FX_OPTION_DATE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
										<xsl:value-of select="option_date" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						
							<!-- Value Date -->
						<xsl:if test="value_date[. != ''] or takedown_value_date[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
										<xsl:value-of 
											select="localization:getGTPString($language, 'XSL_CONTRACT_FX_VALUE_DATE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
										<xsl:choose>
										<xsl:when test="product_code[.='FX'] and takedown_value_date[.!='']">
											<xsl:value-of select="takedown_value_date" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="value_date" />
										</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
				</xsl:if>
				<xsl:if test="issuer_ref_id[.!=''] and product_code[.='PO' or .='IO']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_GENERALDETAILS_PO_REF_ID')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="issuer_ref_id" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="tid[.!=''] and product_code[.='IO'] and tnx_type_code[.='03']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_LABEL_TMA_REF')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="tid" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<!-- Details of ancestors -->
				<xsl:if test="cross_references/cross_reference/child_product_code[.!='FX' and .!='IP' and .!='IN' and .!='PO' and .!='SO' and .!='TD'] and (cross_references/cross_reference/child_ref_id=ref_id and cross_references/cross_reference/ref_id != cross_references/cross_reference/child_ref_id)  and (cross_reference/product_code= .!='FB')"> 
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ANCESTOR_LINKED_REFERENCE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="cross_references/cross_reference/ref_id"/><xsl:if test="cross_references/cross_reference/child_product_code[.!='FX']"> (<xsl:value-of select="localization:getDecode($language, 'N043', cross_references/cross_reference/type_code)"/>)</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="cross_references/cross_reference/child_product_code[.='FX'] and (ref_id != cross_references/cross_reference/child_ref_id)"> 
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ANCESTOR_LINKED_REFERENCE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="cross_references/cross_reference/child_ref_id"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="cross_references/cross_reference/type_code[.='02'] and product_code[.!='IN' and .!='IP'and .!='SG' and .!='BK' and .!='LC'] ">
					<xsl:variable name="parent_file" select="xmlRender:getXMLMasterNode(cross_references/cross_reference[./type_code='02']/product_code, cross_references/cross_reference[./type_code='02']/ref_id, $language)"/>
					<xsl:call-template name="table_cell">					
					<xsl:with-param name="left_text">
							<xsl:choose>						
								 <xsl:when test="product_code[.!='TD']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_LC_REF_ID')" />
								  </xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="localization:getGTPString($language, 'BANK_REFERENCE_LABEL')" />
								</xsl:otherwise> 
							</xsl:choose>
					</xsl:with-param>			
						<xsl:with-param name="right_text">
							<xsl:value-of select="$parent_file/bo_ref_id"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if
					test="(((bo_ref_id[.!=''] and tnx_type_code[.='01'] and tnx_stat_code[.='04'] and (product_code[.!='FT'] and (sub_product_code[.!='TRINT'] or sub_product_code[.!='TRTPT']))) or (bo_ref_id[.!=''] and tnx_type_code[.!='01']) or preallocated_flag[.='Y']) and product_code[.!='FX'] and (product_code[.!='TD'] and sub_product_code[.!='TRTD'] and product_code[.='FT'] and sub_product_code[.!='TRINT'] and sub_product_code[.='TRTPT']) )">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:choose>
								<xsl:when test="product_code[.='LN']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID_LN')" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="bo_ref_id" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="product_code[.='FX']">
					<xsl:if test="liquidation_amt[.!=''] and liquidation_cur_code[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TREASURY_LIQUIDATION_AMT_LABEL')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="liquidation_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="liquidation_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="liquidation_date[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LIQUIDATION_DATE')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="liquidation_date"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="liquidation_rate[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LIQUIDATION_RATE')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="liquidation_rate"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="liquidation_profit_loss[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_LIQUIDATION_AMT_GAIN_LOSS')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getDecode($language, 'N429', liquidation_profit_loss[.])"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="original_amt[.!=''] and original_cur_code[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_ORG_CUR_AMT_LABEL')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="original_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="original_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="original_counter_amt[.!=''] and original_counter_cur_code[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_COUNTER_ORG_CUR_AMT_LABEL')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="original_counter_cur_code"/><xsl:text> </xsl:text><xsl:value-of select="original_counter_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>	
				</xsl:if>
				
				<xsl:if test="bo_ref_id[.!=''] and (product_code[.='TF'] or product_code[.='FX'] or product_code[.='TD']  or (product_code[.='FT'] and (sub_product_code[.='TRINT'] or sub_product_code[.='TRTPT'] or sub_product_code[.='INT'] or sub_product_code[.='BILLP'] or sub_product_code[.='TPT'])) or product_code[.='SI' or .='SR'])">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="bo_ref_id" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<!--  Fixed as part of 41835, 41833,41829 -->
				<xsl:if test="bo_ref_id[.!=''] and product_code [.='EL'] and prod_stat_code [.='03' or .='02'] and tnx_type_code [.='01' or .='13']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="bo_ref_id" />
									</xsl:with-param>
								</xsl:call-template>
					</xsl:if>				
				
				<xsl:if	test="bo_ref_id[.!=''] and product_code[.='BG'] and tnx_type_code[.='03'] and sub_tnx_type_code[.='05'] and tnx_stat_code[.='03']">
					<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bo_ref_id" />
							</xsl:with-param>
						</xsl:call-template>
				</xsl:if>
				
				<xsl:if test="doc_ref_no[.!=''] and product_code[.='LC' or .='BG' or .='SR' or .='SI' or .='BR']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_DOC_REF_NO')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="doc_ref_no" />
							</xsl:with-param>
						</xsl:call-template>
				</xsl:if>
				<!-- prod_stat_code ='' check is required for creating LC from clean LC -->
				<xsl:if test="prod_stat_code[.='12' or .='03' or .='26' or .=''] and tnx_type_code[.='15' or .='01' or .='13' or .='03'] and cross_references">
                        <xsl:choose>
                        <xsl:when test="product_code[.='LC']">
                               <xsl:call-template name="table_cell">
                               <xsl:with-param name="left_text">
                                     <xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_NO_LINKED_REFERENCE')" />
                               </xsl:with-param>
                        </xsl:call-template>
                        </xsl:when>
                        </xsl:choose>
                    </xsl:if>
					<xsl:if test="sub_tnx_type_code[.='25' or .='62'] and product_code[.!='LS']">
					<xsl:if
						test="tnx_cur_code[.!=''] and tnx_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_SETTLEMENT_AMT_LABEL')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:if>
				<xsl:if test="//issuing_bank/name[.!=''] and product_code[.='SR']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_ISSUING_BANK')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="//issuing_bank/name" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test=" not(count(cross_reference[ref_id != child_ref_id]) &gt; 0) and cross_references/cross_reference/child_product_code[.='EL']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						<fo:block>
							<fo:inline font-style="italic"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_NO_LINKED_REFERENCE')" /></fo:inline> 
						</fo:block>							
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>			
				<xsl:if test="lc_ref_id[.!=''] and product_code[.='EL' or .='SR']">
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
				
				<!-- Remittance Letter Details -->
				<xsl:if test="sub_tnx_type_code[.='87'] and product_code[.='EL']">
					<xsl:if test="tnx_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_AMOUNT')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="tnx_cur_code" />&nbsp;<xsl:value-of select="tnx_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="applicant_name[.!='']">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_APPLICANT_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
									<xsl:value-of select="applicant_name" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
									<xsl:value-of select="applicant_address_line_1" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text"/>
							<xsl:with-param name="right_text">
									<xsl:value-of select="applicant_address_line_2" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text"/>
							<xsl:with-param name="right_text">
									<xsl:value-of select="applicant_dom" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text"/>
							<xsl:with-param name="right_text">
									<xsl:value-of select="applicant_address_line_4" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
					<!-- <xsl:if test="documents/document">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DOCUMENTS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text"/>
							<xsl:with-param name="right_text">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_1ST_MAIL_LABEL')"/> 
								<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_2ND_MAIL_LABEL')"/> 
							</xsl:with-param>
						</xsl:call-template>
						<xsl:apply-templates select="documents/document"/>
					</xsl:if> -->
					
					<xsl:if test="narrative_additional_instructions[.!='']">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell2">
							<xsl:with-param name="text">
									<xsl:value-of select="narrative_additional_instructions" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					
					<xsl:if test="narrative_payment_instructions[.!='']">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS')"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell2">
							<xsl:with-param name="text">
									<xsl:value-of select="narrative_payment_instructions" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:if>
				
				<xsl:if
					test="bo_lc_ref_id[.!=''] and product_code[.='SG' or .='LI' or .='TF' or .='FT']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_LC_REF_ID')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="bo_lc_ref_id" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="cross_references/cross_reference/ref_id[.!='']">
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
				</xsl:if>
				<xsl:if test="alt_lc_ref_id[.!=''] and product_code[.='LI']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_LC_REF_ID')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="alt_lc_ref_id" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="deal_ref_id[.!=''] and product_code[.='LI']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_GENERALDETAILS_RELATED_REF_ID')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="deal_ref_id" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				
				<xsl:if test="topic_description[.!=''] and product_code[.='SE'] and sub_product_code[.='CTCHP' or .='SEEML']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SECURE_EMIAIL_REQUEST_TYPE')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
								 <xsl:value-of select="topic_description"/>
							</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
				<!-- Document Amount or Maturity date may be modified by bank -->
				<xsl:if test="sub_tnx_type_code[.='08']">
					<xsl:if test="tnx_cur_code[.!=''] and tnx_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_DOCS_AMT_LABEL')" />
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
				</xsl:if>
				<xsl:choose>
					<!-- NEW -->
					<xsl:when test="tnx_type_code[. = '01'] or (prod_stat_code[.='03'] and product_code[.='TD'] and (sub_product_code[.='TRTD'] or sub_product_code[.='CSTD']))">
					
					<!-- Mapping of Bank w.r.t Products -->
						<xsl:choose>
							<xsl:when
								test="product_code[.='LC' or .='SE'  or .='SG' or .='LI' or .='TF' or .='SI' or .='FT' or .='IR' or .='PO' or .='IN' or .='LS' or .='TD']  and sub_product_code[.!='TRINT'] and sub_product_code[.!='TRTPT'] and sub_product_code [.!= 'SMP'] and sub_product_code[.!='PICO'] and issuing_bank/name[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:choose>
											<xsl:when test="$isMultiBank='Y'">
												<xsl:value-of select="localization:getGTPString($language, 'CUSTOMER_BANK_LABEL')" />
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_ISSUING_BANK')" />
											</xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="issuing_bank/name" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:when test="product_code[.='EL' or .='SR' or .='BR']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_ADVISING_BANK')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="advising_bank/name" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:when test="product_code[.='EC']">
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
								<xsl:if test="remitting_bank/name !=''">
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
								<xsl:if test="bo_ref_id[.!=''] and security:isCustomer($rundata)">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="bo_ref_id" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
							</xsl:when>
							<xsl:when test="product_code[.='IC']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRESENTING_BANK')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="presenting_bank/name" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:when test="product_code[.='IR'] and remitting_bank/name[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_REMITTING_BANK')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="remitting_bank/name" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<!-- <xsl:when test="product_code[.='BG']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_RECIPIENT_BANK')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="recipient_bank/name" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when> -->
							<!-- If product_code has nothing: Donot Map to any of the bank  -->
							<xsl:otherwise />
							
						</xsl:choose>
						
						<xsl:choose>
							<xsl:when test="product_code[.='SE'] and sub_product_code[.='DT']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_DOC_TRACK_ID')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="doc_track_id" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<!-- Export nothing: if (product_code, sub_product_code) is not (SE, DT) respectively -->
							<xsl:otherwise />
						</xsl:choose>
						
						<!-- Application Date -->
						<!-- Issue fix MPS-59908 -->
						<xsl:if test="appl_date[. != ''] and sub_product_code != 'SMP' and (product_code !='IC' or (security:isCustomer($rundata)))">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
										<xsl:value-of 
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_APPLICATION_DATE')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
										<xsl:value-of select="appl_date" />
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
						<xsl:if test="exec_date[.!=''] and tnx_stat_code[.='04']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<fo:block font-family="{$pdfFont}">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXECUTION_DATE')" />
									</fo:block>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="exec_date" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:choose>
							<xsl:when test="product_code[.='TF']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DAYS')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="tenor" />
									</xsl:with-param>
								</xsl:call-template>
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
							</xsl:when>
							<xsl:when test="product_code[.='EC' or .='IC']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<fo:block font-weight="bold">
											<xsl:choose>
												<xsl:when test="term_code[. = '01']">
													<xsl:value-of
														select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DP')" />
												</xsl:when>
												<xsl:when test="term_code[. = '02']">
													<xsl:value-of
														select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_DA')" />
												</xsl:when>
												<xsl:when test="term_code[. = '03']">
													<xsl:value-of
														select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_OTHER')" />
												</xsl:when>
												<xsl:when test="term_code[. = '04']">
													<xsl:value-of
														select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR_AVAL')" />
												</xsl:when>
												<xsl:when test="tenor_desc[.!='']">
													<xsl:value-of select="tenor_desc" />
												</xsl:when>
											</xsl:choose>
										</fo:block>
									</xsl:with-param>
								</xsl:call-template>
								<xsl:if test="tenor_desc[.!='']">
											<xsl:call-template name="table_cell">
										 <xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BILL_TENOR')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="tenor_desc" />
										</xsl:with-param>
									</xsl:call-template>
										</xsl:if>
							</xsl:when>
							<xsl:when test="product_code ='LS'">
								<xsl:if test="ls_number[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_LICENSE_NUMBER')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="ls_number" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="(product_code ='SI' or product_code ='SR') and (lc_exp_date_type_code[.!=''])">
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
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_DATE')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="exp_date" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="(product_code ='SI' or product_code ='SR' or product_code ='LC') and exp_event[.!='']">
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
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_PLACE')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="expiry_place" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:choose>
									<xsl:when test="product_code[.='LC' or .='EL' or .='SI' or .='SR'] and tnx_type_code[.='03']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TNX_AMT_LABEL')" />
									</xsl:when>
									<xsl:when test="product_code[.='LC' or .='EL' or .='SI' or .='SR']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_LC_AMT_LABEL')" />
									</xsl:when>
									<xsl:when test="product_code[.='EC' or .='IC' or .='IR']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_COLL_AMT_LABEL')" />
									</xsl:when>
									<xsl:when test="product_code[.='SG' or .='BG' or .='BR']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_GTEE_AMT_LABEL')" />
									</xsl:when>
									<xsl:when test="product_code[.='TF']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FIN_AMT_LABEL')" />
									</xsl:when>
									<xsl:when test="product_code[.='FT'] and sub_product_code[.!='TRINT'] and sub_product_code[.!='TRTPT']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FT_AMT_LABEL')" />
									</xsl:when>
									<xsl:when test="product_code[.='LI']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_LI_AMT_LABEL')" />
									</xsl:when>
									<xsl:when test="product_code[.='PO' or .='IO' or .='EA']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL')" />
									</xsl:when>
									<xsl:when test="product_code[.='IN' or .='IP'] and sub_product_code !='SMP'">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL')" />
									</xsl:when>
									<xsl:when test="product_code[.='FA']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FA_AMT_LABEL')" />
									</xsl:when>
									<xsl:when test="product_code[.='BK'] and sub_product_code[.='IPBR']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_BK_TOTAL_REPAYMENT_AMT')" />
									</xsl:when>
									<xsl:when test="product_code[.='BK']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_BK_AMT_LABEL')" />
									</xsl:when>
									<xsl:when test="product_code[.='CN' or .='CR']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CN_AMOUNT')" />
									</xsl:when>
									<xsl:when test="product_code[.='LS']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_LICENSE_TOTAL_AMT')" />
									</xsl:when>
									<xsl:when test="product_code[.='FX'] and prod_stat_code[.!='02' and .!='03']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TNX_AMT_LABEL')" />
									</xsl:when>
									<xsl:when test="product_code[.='LN']">
										<xsl:value-of 
											select="localization:getGTPString($language, 'XSL_LOAN_AMOUNT')" />
									</xsl:when>
									<xsl:when test="product_code[.='TD']">
										<xsl:value-of 
											select="localization:getGTPString($language, 'XSL_TD_PLACEMENT_AMOUNT')"/>
									</xsl:when>									
								</xsl:choose>
							</xsl:with-param>
							<!-- <xsl:with-param name="right_text">
								<xsl:value-of select="tnx_cur_code" />
								<fo:inline space-start="10.0pt"><xsl:value-of select="tnx_amt" /></fo:inline>
							</xsl:with-param> -->
							
							<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="product_code[.='FX']">
									 <xsl:choose>
									 	<xsl:when test="prod_stat_code[.!='02' and .!='03']">
									 		<xsl:value-of select="tnx_cur_code" />
									 		<fo:inline space-start="10.0pt"><xsl:value-of select="concat(' ', tnx_amt)" /></fo:inline>
									 	</xsl:when>
									 </xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="product_code[.='TD'] and (sub_product_code[.='TRTD'] or sub_product_code[.='CSTD'])">
											<xsl:value-of select="td_cur_code" />
											<fo:inline space-start="10.0pt"><xsl:value-of select="concat(' ', td_amt)" /></fo:inline>
										</xsl:when>
										<xsl:when test="sub_product_code[.='TRINT'] or sub_product_code[.='TRTPT']">
										</xsl:when>
										<xsl:when test = "sub_product_code != 'SMP'">
											<xsl:value-of select="tnx_cur_code" />
											<fo:inline space-start="10.0pt"><xsl:value-of select="concat(' ', tnx_amt)" /></fo:inline>
										</xsl:when>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
							</xsl:with-param>
							
						</xsl:call-template>
						<xsl:if test="tnx_type_code[.='03'] and lc_amt[.!= '']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NEW_LC_AMT_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="lc_cur_code" />
											<fo:inline space-start="10.0pt"><xsl:value-of select="concat(' ', lc_amt)" /></fo:inline>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						<xsl:if test="product_code[.='FX'] and  prod_stat_code[.!='03']">
						<!-- Counter Transaction Currency / Amount: -->
							<xsl:if test="counter_cur_code[. != ''] or counter_amt[. != '']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_CONTRACT_FX_COUNTER_TRANSACTION_COUNTER_AMT')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="concat(counter_cur_code, ' ', counter_amt)" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<!-- Option Date -->
						<xsl:if test="option_date[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
										<xsl:value-of 
											select="localization:getGTPString($language, 'XSL_CONTRACT_FX_OPTION_DATE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
										<xsl:value-of select="option_date" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						
							<!-- Value Date -->
						<xsl:if test="value_date[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
										<xsl:value-of 
											select="localization:getGTPString($language, 'XSL_CONTRACT_FX_VALUE_DATE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
										<xsl:value-of select="value_date" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						</xsl:if>
						<!-- Action required -->
						<xsl:if test="product_code[.='FX'] or (product_code[.='TD'] and sub_product_code[.='TRTD'])"> 
						<xsl:if test="action_req_code[. != '']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									<xsl:value-of 
											select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ACTION_REQUIRED')" />
									</xsl:with-param>				
									<xsl:with-param name="right_text">
										<xsl:value-of select="localization:getDecode($language, 'N042', action_req_code)" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:if> 
					</xsl:when>
					<!-- AMEND -->
					<xsl:when test="tnx_type_code[.='03']">
						<xsl:if test="(amd_no[.!=''] and ((security:isCustomer($rundata) and tnx_stat_code[.='04']) or security:isBank($rundata)))">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_GENERALDETAILS_AMD_NO')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="utils:formatAmdNo(amd_no)" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="amd_date[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								<xsl:choose>
									<xsl:when test="$swift2018Enabled and product_code[.='LC']">
										<xsl:value-of
										select="localization:getGTPString($language, 'XSL_GENERALDETAILS_AMD_CAN_DATE')" />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of
										select="localization:getGTPString($language, 'XSL_GENERALDETAILS_AMD_DATE')" />
									</xsl:otherwise>
								</xsl:choose>
									
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="amd_date" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="amd_details[.!='']">
							<fo:table-row>
								<fo:table-cell keep-together="always">
									<fo:block start-indent="40.0pt" font-family="{$pdfFont}">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_AMENDMENT_NARRATIVE_LABEL')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell keep-together="auto" linefeed-treatment="preserve" white-space-collapse="false" white-space="pre" font-weight="bold" wrap-option="wrap">
									<fo:block>
				 						<xsl:value-of select="amd_details" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
						<xsl:if test="ec_amt[.!=''] and product_code = 'EC'">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NEW_EC_AMT_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ec_amt" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="product_code[.='BG']">
							<xsl:if test="iss_date_type_code[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_DATE_TYPE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:choose>
								         <xsl:when test="iss_date_type_code[. = '01']">
								          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ISSUANCE')"/>
								         </xsl:when>
								         <xsl:when test="iss_date_type_code[. = '02']">
								          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_CONTRACT_SIGN')"/>
								         </xsl:when>
								         <xsl:when test="iss_date_type_code[. = '03']">
								          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ADV_PAYMT')"/>
								         </xsl:when>
								         <xsl:when test="iss_date_type_code[. = '99']">
								          <xsl:value-of select="iss_date_type_details"/>
								         </xsl:when>
								       </xsl:choose>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="iss_date[.!=''] ">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ISSUE_DATE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="iss_date"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:if>
					 <!-- Expiry Type Code -->	
						<xsl:if	test="product_code[.='SI'] and org_previous_file/si_tnx_record/lc_exp_date_type_code!=lc_exp_date_type_code and lc_exp_date_type_code[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text"><xsl:value-of select="localization:getGTPString($language, 'GENERALDETAILS_NEW_EXPIRY_TYPE')"/></xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="lc_exp_date_type_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_EXP_DATE_TYPE_SPECIFIC')"/></xsl:when>
										<xsl:when test="lc_exp_date_type_code[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_EXP_DATE_TYPE_CONDITIONAL')"/></xsl:when>
										<xsl:when test="lc_exp_date_type_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_EXP_DATE_TYPE_UNLIMITED')"/></xsl:when>
									</xsl:choose>
								</xsl:with-param>		
							</xsl:call-template>
						</xsl:if>
						
						<xsl:choose>
							<xsl:when test="product_code[.='BG']">
							<xsl:choose>
								<xsl:when test ="not(org_previous_file/bg_tnx_record/exp_date=exp_date and exp_date[.!=''] and org_previous_file/bg_tnx_record/exp_date_type_code=exp_date_type_code)">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ORG_EXPIRY_DATE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:choose>
											<xsl:when test="org_previous_file/bg_tnx_record/exp_date_type_code[.='01']">
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_NONE')" />
											</xsl:when>
											<xsl:when test="org_previous_file/bg_tnx_record/exp_date_type_code[.='02']">
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_FIXED')" />
											</xsl:when>
											<xsl:when test="org_previous_file/bg_tnx_record/exp_date_type_code[.='03']">
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_PROJECTED')" />
											</xsl:when>
										</xsl:choose>
										<xsl:if test="exp_date[.!='']">
											(<xsl:value-of select="org_previous_file/bg_tnx_record/exp_date"/>)
										</xsl:if>
									</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_NEW_EXPIRY_DATE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:choose>
											<xsl:when test="exp_date_type_code[.='01']">
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_EXPDATETYPECODE_01_NO_DATE')" />
											</xsl:when>
											<xsl:when test="exp_date_type_code[.='02']">
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_EXPDATETYPECODE_02_FIXED')" />
											</xsl:when>
											<xsl:when test="exp_date_type_code[.='03']">
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_EXPDATETYPECODE_03_PROJECTED')" />
											</xsl:when>
										</xsl:choose>
										<xsl:if test="exp_date[.!=''] and exp_date_type_code[.!= '01']">
											(<xsl:value-of select="exp_date" />)
										</xsl:if>
									</xsl:with-param>
								</xsl:call-template>
								</xsl:when>
								<xsl:when test ="org_previous_file/bg_tnx_record/exp_date=exp_date and exp_date[.!=''] and org_previous_file/bg_tnx_record/exp_date_type_code=exp_date_type_code">
									<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_DATE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:choose>
											<xsl:when test="exp_date_type_code[.='01']">
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_EXPDATETYPECODE_01_NO_DATE')" />
											</xsl:when>
											<xsl:when test="exp_date_type_code[.='02']">
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_EXPDATETYPECODE_02_FIXED')" />
											</xsl:when>
											<xsl:when test="exp_date_type_code[.='03']">
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_EXPDATETYPECODE_03_PROJECTED')" />
											</xsl:when>
										</xsl:choose>
										<xsl:if test="exp_date[.!=''] and exp_date_type_code[.!= '01']">
											(<xsl:value-of select="exp_date" />)
										</xsl:if>
									</xsl:with-param>
								</xsl:call-template>
								</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:when
								test="product_code[.='LC'] and org_previous_file/lc_tnx_record/exp_date!=exp_date and exp_date[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_NEW_EXPIRY_DATE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="exp_date" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:when
								test="product_code[.='SI'] and org_previous_file/si_tnx_record/exp_date!=exp_date and exp_date[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_NEW_EXPIRY_DATE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="exp_date" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise />
						</xsl:choose>
						<xsl:if test="sub_tnx_type_code[.!='03'] and tnx_amt[.!='']">
							<xsl:if test="product_code[.='LC' or .='SI'] and (org_previous_accepted_file/lc_tnx_record/lc_amt[.!=''] or org_previous_accepted_file/si_tnx_record/lc_amt[.!=''])">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_ORG_LC_AMT_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:choose>
											<xsl:when test="product_code[.='LC']">
												<xsl:value-of select="lc_cur_code" />&nbsp;<xsl:value-of select="utils:trimTheValue(org_previous_accepted_file/lc_tnx_record/lc_amt)"/>
											</xsl:when>
											<xsl:when test="product_code[.='SI']">
												<xsl:value-of select="lc_cur_code" />&nbsp;<xsl:value-of select="utils:trimTheValue(org_previous_accepted_file/si_tnx_record/lc_amt)"/>
											</xsl:when>
											<xsl:otherwise/>
										</xsl:choose>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TNX_AMT_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="tnx_cur_code" />&nbsp;<xsl:value-of select="tnx_amt" />
								</xsl:with-param>
							</xsl:call-template>
							<xsl:choose>
								<xsl:when test="product_code[.='BG']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NEW_GTEE_AMT_LABEL')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="bg_cur_code" />&nbsp;<xsl:value-of select="bg_amt" />
										</xsl:with-param>
									</xsl:call-template>

									<xsl:if test="bg_release_flag[.='Y']">
										<xsl:choose>
											<xsl:when test="sub_tnx_type_code[.!='05']">
												<xsl:call-template name="table_cell">
													<xsl:with-param name="left_text">
													</xsl:with-param>
													<xsl:with-param name="right_text">
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_GTEE_RELEASE_YES')" />
													</xsl:with-param>
												</xsl:call-template>
											</xsl:when>
              								<xsl:otherwise>
              									<xsl:call-template name="table_cell">
													<xsl:with-param name="left_text">
													</xsl:with-param>
													<xsl:with-param name="right_text">
														<xsl:value-of
															select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_GTEE_RELEASE_FULL')" />
													</xsl:with-param>
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:if>
								</xsl:when>
								<xsl:when test="product_code[.='EL' or .='LC' or .='SR']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NEW_LC_AMT_LABEL')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="lc_cur_code" />&nbsp;<xsl:value-of select="lc_amt" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:when>
								<xsl:when test="product_code[.='SI'] and sub_tnx_type_code[.!='05']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NEW_LC_AMT_LABEL')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="lc_cur_code" />&nbsp;<xsl:value-of select="lc_amt" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:when>
								<xsl:when test="product_code[.='BG']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NEW_LC_AMT_LABEL')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="bg_cur_code" />&nbsp;<xsl:value-of select="bg_amt" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise />
							</xsl:choose>
						</xsl:if>
						<xsl:if test="product_code[.='LS']">
							<xsl:if test="ls_number[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_LICENSE_NUMBER')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="ls_number" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="auth_reference[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AUTH_REFERENCE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="auth_reference" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NEW_LS_AMT_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="ls_cur_code" />&nbsp;<xsl:value-of select="ls_amt" />
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="additional_amt[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NEW_ADDITIONAL_AMT_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="ls_cur_code" />&nbsp;<xsl:value-of select="additional_amt" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NEW_TOTAL_AMT_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="total_cur_code" />&nbsp;<xsl:value-of select="total_amt" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:when>
					<!-- MESSAGE -->
					<xsl:when test="tnx_type_code[.='13']">
						<xsl:if test="sub_tnx_type_code[.='12' or .='19']">
							<xsl:if test="sub_tnx_type_code[.='12']">
								<!-- Expiry Date and Place -->
								<xsl:if test="org_previous_file/el_tnx_record/exp_date[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_DATE_TRANSFER')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="org_previous_file/el_tnx_record/exp_date" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="exp_date[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_DATE_TRANSFER')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="exp_date" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="expiry_place[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_PLACE_TRANSFER')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="expiry_place" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<!-- Second Beneficiary -->
								<xsl:call-template name="subtitle">
									<xsl:with-param name="text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_HEADER_SECOND_BENEFICIARY_DETAILS')" />
									</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="sec_beneficiary_name" />
									</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="table_cell">
								     <xsl:with-param name="left_text">
									  <xsl:value-of
									    select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')" />
								     </xsl:with-param>
								      <xsl:with-param name="right_text">
											<fo:block font-weight="bold">
										<xsl:value-of select="sec_beneficiary_address_line_1" />
											</fo:block>
										</xsl:with-param>
								</xsl:call-template>
								<xsl:if test="sec_beneficiary_address_line_2[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="right_text">
											<fo:block font-weight="bold">
												<xsl:value-of select="sec_beneficiary_address_line_2" />
											</fo:block>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="sec_beneficiary_dom[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="right_text">
											<fo:block font-weight="bold">
												<xsl:value-of select="sec_beneficiary_dom" />
											</fo:block>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="sec_beneficiary_address_line_4[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="right_text">
											<fo:block font-weight="bold">
												<xsl:value-of select="sec_beneficiary_address_line_4" />
											</fo:block>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>

								<xsl:if test="sec_beneficiary_reference[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="sec_beneficiary_reference" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
							</xsl:if>
							<xsl:if test="sub_tnx_type_code[.='19']">

								<!-- Second Beneficiary -->
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
										<xsl:with-param name="right_text">
											<fo:block font-weight="bold">
												<xsl:value-of select="assignee_address_line_2" />
											</fo:block>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="assignee_dom[.!='']">
										<xsl:call-template name="table_cell">
											<xsl:with-param name="right_text">
												<fo:block font-weight="bold">
											<xsl:value-of select="assignee_dom" />
												</fo:block>
											</xsl:with-param>
										</xsl:call-template>
								</xsl:if>
								<xsl:if test="assignee_address_line_4[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="right_text">
											<fo:block font-weight="bold">
												<xsl:value-of select="assignee_address_line_4" />
											</fo:block>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="assignee_reference[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="assignee_reference" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
							</xsl:if>
							<!-- Transfer Amount -->
							<xsl:call-template name="title_amt_details">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_DETAILS')" />
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_ORG_LC_AMT_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<fo:block font-weight="bold" 
										space-before.conditionality="retain">
										<xsl:value-of select="lc_cur_code" />&nbsp;<xsl:value-of select="lc_amt" />
									</fo:block>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:choose>
										<xsl:when test="sub_tnx_type_code[.='19']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_ASG_AMT_LABEL')" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TRF_AMT_LABEL')" />
										</xsl:otherwise>
									</xsl:choose>
									
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<fo:block font-weight="bold">
										<xsl:value-of select="tnx_cur_code" />&nbsp;<xsl:value-of select="tnx_amt" />
									</fo:block>
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
							<xsl:if test="$swift2019Enabled">
							<xsl:call-template name="title">
								<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_DELIVERY_INSTRUCTIONS')" />
								</xsl:with-param>
							</xsl:call-template>
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
							</xsl:if>
							</xsl:if>

							<!-- Changing this condition as to not to display the narrative details for SR only and not for ELC fo -->
							<xsl:if test="sub_tnx_type_code[.='12'] and not(product_code[.='SR'] and ($swift2018Enabled))">
								<xsl:call-template name="title">
									<xsl:with-param name="text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_SHIPMENT_NARRATIVE_DETAILS')" />
									</xsl:with-param>
								</xsl:call-template>
								
								<xsl:if test="org_previous_file/el_tnx_record/last_ship_date[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_ORG_LAST_SHIP_DATE')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="org_previous_file/el_tnx_record/last_ship_date" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="last_ship_date[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_LAST_SHIP_DATE_TRANSFER')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="last_ship_date" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="inco_term[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_INCO_TERM_TRANSFER')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="inco_term" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="inco_place[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_INCO_PLACE_TRANSFER')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="inco_place" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="narrative_description_goods[.!=''] and not($swift2018Enabled)">
									<xsl:apply-templates select="narrative_description_goods">
										<xsl:with-param name="theNodeName" select="'narrative_description_goods'" />
										<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TRANSFER_DESCRIPTION_GOODS')" />
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="not ($swift2018Enabled)">
									<xsl:if test="narrative_period_presentation[.!='']">
										<xsl:apply-templates select="narrative_period_presentation">
											<xsl:with-param name="theNodeName" select="'narrative_period_presentation'" />
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TRANSFER_PERIOD_PRESENTATION')" />
										</xsl:apply-templates>
									</xsl:if>
								</xsl:if>
											
								<xsl:if test="narrative_shipment_period[.!='']">
									<xsl:apply-templates select="narrative_shipment_period">
										<xsl:with-param name="theNodeName" select="'narrative_shipment_period'" />
										<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TRANSFER_SHIPMENT_PERIOD')" />
									</xsl:apply-templates>
								</xsl:if>
								<fo:table-row keep-with-next="always">
									<fo:table-cell number-columns-spanned="2">
										<fo:block white-space-collapse="false" page-break-after="always">&nbsp;</fo:block>
									</fo:table-cell>
								</fo:table-row>	
								<xsl:if test="$swift2018Enabled">
									<xsl:choose>
									<xsl:when test = "defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'true'">
										<xsl:if test="narrative_description_goods[.!='']">
										<fo:table-row keep-with-next="always">
											<fo:table-cell number-columns-spanned="2">
												<fo:block white-space-collapse="false" page-break-after="always">
													<fo:table width="{$pdfTableWidth}" 
													font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
														<fo:table-column column-width="{$pdfTableWidth}" />
														<fo:table-column column-width="0" /> <!--  dummy column -->
														<fo:table-body>
															<xsl:apply-templates select="narrative_description_goods">
																<xsl:with-param name="theNodeName" select="'narrative_description_goods'" />
																<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TRANSFER_DESCRIPTION_GOODS')" />
															</xsl:apply-templates>
														</fo:table-body>
													</fo:table>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="narrative_documents_required[.!='']">
										<fo:table-row keep-with-next="always">
											<fo:table-cell number-columns-spanned="2">
												<fo:block white-space-collapse="false" page-break-after="always">
													<fo:table width="{$pdfTableWidth}" 
													font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
														<fo:table-column column-width="{$pdfTableWidth}" />
														<fo:table-column column-width="0" /> <!--  dummy column -->
														<fo:table-body>
															<xsl:apply-templates select="narrative_documents_required">
																<xsl:with-param name="theNodeName" select="'narrative_documents_required'" />
																<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TRANSFER_DOCUMENTS_REQUIRED')" />
															</xsl:apply-templates>
														</fo:table-body>
													</fo:table>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="narrative_additional_instructions[.!='']">
										<fo:table-row keep-with-next="always">
											<fo:table-cell number-columns-spanned="2">
												<fo:block white-space-collapse="false" page-break-after="always">
													<fo:table width="{$pdfTableWidth}" 
													font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
														<fo:table-column column-width="{$pdfTableWidth}" />
														<fo:table-column column-width="0" /> <!--  dummy column -->
														<fo:table-body>
															<xsl:apply-templates select="narrative_additional_instructions">
																<xsl:with-param name="theNodeName" select="'narrative_additional_instructions'" />
																<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TRANSFER_ADDITIONAL_INSTRUCTIONS')" />
															</xsl:apply-templates>
														</fo:table-body>
													</fo:table>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="narrative_special_beneficiary[.!='']">
										<fo:table-row keep-with-next="always">
											<fo:table-cell number-columns-spanned="2">
												<fo:block white-space-collapse="false" page-break-after="always">
													<fo:table width="{$pdfTableWidth}" 
													font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
														<fo:table-column column-width="{$pdfTableWidth}" />
														<fo:table-column column-width="0" /> <!--  dummy column -->
														<fo:table-body>
															<xsl:apply-templates select="narrative_special_beneficiary">
																<xsl:with-param name="theNodeName" select="'narrative_special_beneficiary'" />
																<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVE_TAB_SPECIAL_PMNT_CON_BENEF_TNF')" />
															</xsl:apply-templates>
														</fo:table-body>
													</fo:table>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
										<xsl:if test="narrative_special_recvbank[.!=''] and security:isBank($rundata)">
										<fo:table-row keep-with-next="always">
											<fo:table-cell number-columns-spanned="2">
												<fo:block white-space-collapse="false" page-break-after="always">
													<fo:table width="{$pdfTableWidth}" 
													font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
														<fo:table-column column-width="{$pdfTableWidth}" />
														<fo:table-column column-width="0" /> <!--  dummy column -->
														<fo:table-body>
															<xsl:apply-templates select="narrative_special_recvbank">
																<xsl:with-param name="theNodeName" select="'narrative_special_recvbank'" />
																<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVE_TAB_SPECIAL_PMNT_CON_RECEIV_TNF')" />
															</xsl:apply-templates>
														</fo:table-body>
													</fo:table>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										</xsl:if>
									</xsl:when>
									<xsl:when test = "defaultresource:getResource('SWIFT_EXTENDED_NARRATIVE_ENABLE') = 'false'">
										<xsl:if test="narrative_description_goods[.!='']">
											<xsl:apply-templates select="narrative_description_goods">
												<xsl:with-param name="theNodeName" select="'narrative_description_goods'" />
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TRANSFER_DESCRIPTION_GOODS')" />
											</xsl:apply-templates>
										</xsl:if>
										<xsl:if test="narrative_documents_required[.!='']">
											<xsl:apply-templates select="narrative_documents_required">
												<xsl:with-param name="theNodeName" select="'narrative_documents_required'" />
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TRANSFER_DOCUMENTS_REQUIRED')" />
											</xsl:apply-templates>
										</xsl:if>
										<xsl:if test="narrative_additional_instructions[.!='']">
											<xsl:apply-templates select="narrative_additional_instructions">
												<xsl:with-param name="theNodeName" select="'narrative_additional_instructions'" />
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TRANSFER_ADDITIONAL_INSTRUCTIONS')" />
											</xsl:apply-templates>
										</xsl:if>
										<xsl:if test="narrative_special_beneficiary[.!='']">
											<xsl:apply-templates select="narrative_special_beneficiary">
												<xsl:with-param name="theNodeName" select="'narrative_special_beneficiary'" />
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVE_TAB_SPECIAL_PMNT_CON_BENEF_TNF')" />
											</xsl:apply-templates>
										</xsl:if>
										<xsl:if test="narrative_special_recvbank[.!=''] and security:isBank($rundata)">
											<xsl:apply-templates select="narrative_special_recvbank">
												<xsl:with-param name="theNodeName" select="'narrative_special_recvbank'" />
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVE_TAB_SPECIAL_PMNT_CON_RECEIV_TNF')" />
											</xsl:apply-templates>
										</xsl:if>
									</xsl:when>
									<xsl:otherwise/>
									</xsl:choose>
								</xsl:if>
								<xsl:if test="$swift2018Enabled">
									<xsl:if test="period_presentation_days[.!=''] or narrative_period_presentation[.!='']">
										<xsl:call-template name="subtitle2">
											<xsl:with-param name="text">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_TAB_PERIOD_PRESENTATION_IN_DAYS')" />
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
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:if>
							<xsl:if test="product_code[.='EL']  and sub_tnx_type_code[.='12'] and return_comments[.!=''] and tnx_stat_code[.!='03' and .!='04']">      <!-- MPS-43899 START -->
								<xsl:call-template name="title">
									<xsl:with-param name="text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_MC_COMMENTS_FOR_RETURN')" />
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
						  </xsl:if>     <!-- MPS-43899 END -->
											
				      <xsl:if test="sub_tnx_type_code[.='20' or .='21']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<fo:block font-family="{$pdfFont}">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ISSUE_DATE')" />
									</fo:block>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="iss_date" />
								</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="org_previous_file/bg_tnx_record/exp_date_type_code[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<fo:block font-family="{$pdfFont}">
											<xsl:value-of
														select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ORG_EXPIRY_DATE')" />
										</fo:block>
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:choose>
									        <xsl:when test="org_previous_file/bg_tnx_record/exp_date_type_code[. = '02']">
									          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_FIXED')"/>
									        </xsl:when>
									        <xsl:when test="org_previous_file/bg_tnx_record/exp_date_type_code[. = '03']">
									          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_PROJECTED')"/>
									        </xsl:when>
									        <xsl:when test="org_previous_file/bg_tnx_record/exp_date_type_code[. = '01']">
									          <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_NONE')"/>
									        </xsl:when>
									     </xsl:choose>
									     (<xsl:value-of select="org_previous_file/bg_tnx_record/exp_date"/>)
									</xsl:with-param>
						        </xsl:call-template>
						    </xsl:if>
							<xsl:choose>
				              <!-- Extend -->
					          <xsl:when test="sub_tnx_type_code[.='20']">
					          	<xsl:if test="exp_date[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_GENERALDETAILS_NEW_EXPIRY_DATE')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="exp_date" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
					          </xsl:when>
					          <!-- Pay -->
					          <xsl:when test="sub_tnx_type_code[.='21']">
					          	<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TNX_AMT_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="tnx_cur_code" />&nbsp;<xsl:value-of select="tnx_amt" />
									</xsl:with-param>
								</xsl:call-template>
					          </xsl:when>
					       </xsl:choose>
						</xsl:if>
						<xsl:if test="sub_tnx_type_code[.='85' or .='78' or .='91'] or tnx_type_code[.='63']">
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
							<xsl:if test="iss_date[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_INVOICE_DATE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="iss_date" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="due_date[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_DUE_DATE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="due_date" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="tnx_amt[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IN_INVOICE_AMOUNT')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="tnx_cur_code" />&nbsp;<xsl:value-of select="tnx_amt" />
								</xsl:with-param>
							</xsl:call-template>
							</xsl:if>
							<xsl:if test="finance_offer_flag[.='Y']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
									select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IN_FINANCE_OFFER_FLAG_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
											<xsl:value-of select="localization:getGTPString($language,'N034_Y')" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="finance_cur_code[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
										select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IN_INVOICE_ELIGIBLE_CUR')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="finance_cur_code" />
								</xsl:with-param>
							</xsl:call-template>
							</xsl:if>
							<xsl:if test="finance_requested_flag[.='Y' or .='P'] and tnx_type_code[.='63']">
								<!-- <xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IN_FINANCE_CURRENCY')" />
										</xsl:with-param>
											<xsl:with-param name="right_text">
												<xsl:choose>
									    			<xsl:when test="finance_requested_cur_code[.='']"><xsl:value-of select="inv_eligible_cur_code"/></xsl:when>
									    			<xsl:otherwise><xsl:value-of select="finance_requested_cur_code"/></xsl:otherwise>
									    		</xsl:choose>
											</xsl:with-param>
								</xsl:call-template> -->
								<!-- <xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IN_FINANCE_REQUESTED_AMT')" />
										</xsl:with-param>
											<xsl:with-param name="right_text">
											<xsl:value-of select="finance_requested_cur_code"/>&nbsp;<xsl:value-of select="finance_requested_amt"/>
										</xsl:with-param>
								</xsl:call-template>
 -->							<!-- 	<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_AMT_LABEL')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="liab_total_net_amt"/>
										</xsl:with-param>
								</xsl:call-template> -->
				          	</xsl:if>
							<xsl:call-template name="title">
								<xsl:with-param name="text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_HEADER_OPTIONAL_PROGRAMME_CONDITIONS')" />
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">&nbsp;</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of
										select="conditions" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Claim Details -->
						<xsl:if test="product_code[.='BG' or .='SI' or .='LC'] and tnx_type_code[.='13'] and (prod_stat_code[.='84' or .='87' or .='88'] or sub_tnx_type_code[.='25' or .='62' or .='63'])">
							<xsl:if test="claim_reference and claim_reference[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_CLAIM_REFERENCE_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="claim_reference" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="claim_present_date and claim_present_date[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_CLAIM_PRESENT_DATE_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="claim_present_date" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="claim_amt and claim_amt[.!=''] and claim_cur_code and claim_cur_code[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_CLAIM_AMOUNT_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="claim_cur_code" />&nbsp;<xsl:value-of select="claim_amt" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:if>
						<!-- MESSAGE LC CLEAN -->
						<xsl:if test="prod_stat_code[.='26'] ">
							<!-- Issue Date -->
					     	<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ISSUE_DATE')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="iss_date" />
								</xsl:with-param>
							</xsl:call-template>
					     	<!-- Expiry Date -->
					     	<xsl:if test="exp_date[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_DATE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="exp_date" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
					     	<!-- Document Amount -->
					     	<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_DOCS_AMT_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="product_code[.='LC'] and document_amt[.!='']">
											<xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="document_amt"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
					     	<!-- Debit Amount -->
					     	<xsl:if test="product_code[.='LC'] and debit_amt[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_DEBIT_AMT_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										 <xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="debit_amt"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:if>
						<xsl:if test="product_code[.='LS']">
							<xsl:if test="ls_number[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_LICENSE_NUMBER')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="ls_number" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="auth_reference[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AUTH_REFERENCE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="auth_reference" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="reg_date[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REG_DATE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="reg_date" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="sub_tnx_type_code[.='25']">
								<xsl:if test="ls_settlement_amt[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_LS_SETTLEMENT_AMT_LABEL')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="ls_cur_code" />&nbsp;<xsl:value-of select="ls_settlement_amt" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="add_settlement_amt[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_ADD_SETTLEMENT_AMT_LABEL')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="ls_cur_code" />&nbsp;<xsl:value-of select="add_settlement_amt" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="tnx_amt[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOTAL_SETTLEMENT_AMT_LABEL')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="ls_cur_code" />&nbsp;<xsl:value-of select="tnx_amt" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
							</xsl:if>
						</xsl:if>
						<xsl:if test="product_code[.='FX'] and action_req_code[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ACTION_REQUIRED')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of
										select="localization:getDecode($language, 'N042', action_req_code)" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:when>
					
					<!-- REPORTING -->
					<xsl:when test="tnx_type_code[.='15']">
						<xsl:choose>
							<!--
								Show the amendment date and number for all products that can
								effectively be amended
							-->
							<xsl:when
								test="prod_stat_code[.='08'] and product_code[.='EL' or .='LC' or .='BG' or .='SI' or .='SR']">
									<xsl:if test="product_code[.='LC' or .='EL' or .='SI' or .='SR'] and tnx_amt[.!=''] and tnx_cur_code[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TNX_AMT_LABEL')" />
										</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="tnx_cur_code" />&nbsp;<xsl:value-of select="tnx_amt" />
									</xsl:with-param>
									</xsl:call-template>
								</xsl:if>								
								<xsl:if test="amd_no[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_GENERALDETAILS_AMD_NO')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="utils:formatAmdNo(amd_no)" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="amd_date[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_GENERALDETAILS_AMD_DATE')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="amd_date" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>								
								<xsl:if test="amd_details[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_AMENDMENT_NARRATIVE_LABEL')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="amd_details" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
							</xsl:when>
							
							<!-- To show tnx_amt in Event details for acceptance event (MT753) -->
				          	<xsl:when test="(product_code[.='EL'] or product_code[.='LC']) and prod_stat_code[.='07'] and tnx_amt[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_DOCS_AMT_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="tnx_cur_code" />&nbsp;<xsl:value-of select="tnx_amt" />
									</xsl:with-param>
								</xsl:call-template>
				          	</xsl:when>
							
							<xsl:when test="product_code='EC' and ec_amt !='' and not(security:isBank($rundata))">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NEW_EC_AMT_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="ec_amt" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<!--
								For a reporting of Acceptance, Discrepancy, Payment at Sight,
								Partial Payment at Sight, Settlement, or Partial Settlement on
								LC or SI, show the documents amount and maturity date
							-->
							<!-- Also added for 'EL' and 'SR' -->
							<xsl:when
								test="prod_stat_code[.='04' or .='05' or .='12' or .='13' or .='14' or .='15' or .='A9' ] and product_code[.='LC' or .='SI' or .='EL' or .='SR' or .='IC' or .='EC']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_DOCS_AMT_LABEL')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="tnx_cur_code" />&nbsp;<xsl:value-of select="tnx_amt" />
									</xsl:with-param>
								</xsl:call-template>
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
								<xsl:if test="latest_answer_date[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_LATEST_ANSWER_DATE')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="latest_answer_date" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<!-- Only the transaction type for the other cases -->
					<xsl:otherwise />
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:if test="(product_code[.='EL'])">
		<xsl:if test="documents/document">
			<!-- <fo:block id="documents"/> -->
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
						<fo:table-column column-width="0" /> <!--  dummy column -->		
						<fo:table-body>
							<fo:table-row>
							<fo:table-cell>
							<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
						      	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="auto">
			  				       	<fo:table-column column-width="15.0pt"/>
			  				       	<fo:table-column column-width="proportional-column-width(2)"/>
			  				       	<fo:table-column column-width="proportional-column-width(2)"/>
			  				       <fo:table-header font-family="{$pdfFont}" font-weight="bold">
										<fo:table-row text-align="center">
										<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell>
										<fo:table-cell><fo:block>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</fo:block></fo:table-cell>
										<fo:table-cell><fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_1ST_MAIL_LABEL')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_2ND_MAIL_LABEL')"/></fo:block></fo:table-cell>
						        		</fo:table-row>
						        	</fo:table-header>
						        	<fo:table-body>
							        		<xsl:for-each select="documents/document">
							        		<fo:table-row>
												<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 
												<fo:table-cell >
													<fo:block text-align="center" padding-top="1.0pt" padding-bottom=".5pt">
													<fo:inline font-weight="bold">
														<xsl:choose>
															<xsl:when test="code and code[.!= ''] and code[.!= '99']">
																<xsl:value-of select="localization:getDecode($language, 'C064', code)"/>
															</xsl:when>
															<xsl:when test="name and name[.!='']">
																<xsl:value-of select="name" />
															</xsl:when>
															<xsl:otherwise />
														</xsl:choose>
														</fo:inline>
													</fo:block>
												</fo:table-cell>
												
												<fo:table-cell >
													<fo:block text-align="center" padding-top="1.0pt" padding-bottom=".5pt">
													<fo:inline font-weight="bold">
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="first_mail"/>
														</xsl:call-template>
														</fo:inline>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell >
													<fo:block text-align="center" padding-top="1.0pt" padding-bottom=".5pt">
													<fo:inline font-weight="bold">
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="second_mail"/>
														</xsl:call-template>
														</fo:inline>
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
			</xsl:if>
		
		<!-- Amend:  Variation in Drawing -->
		<xsl:if test="product_code[.='LC'] and tnx_type_code[.='03']">
			<xsl:if
				test="org_previous_file/lc_tnx_record/pstv_tol_pct!=pstv_tol_pct or org_previous_file/lc_tnx_record/neg_tol_pct!=neg_tol_pct or org_previous_file/lc_tnx_record/max_cr_desc_code!=max_cr_desc_code">
				<xsl:call-template name="variation_drawing">
					<xsl:with-param name="pstv_tol_pct">
						<xsl:value-of select="pstv_tol_pct" />
					</xsl:with-param>
					<xsl:with-param name="neg_tol_pct">
						<xsl:value-of select="neg_tol_pct" />
					</xsl:with-param>
					<xsl:with-param name="max_cr_desc_code">
						<xsl:value-of select="max_cr_desc_code" />
					</xsl:with-param>
					<xsl:with-param name="org_pstv_tol_pct">
						<xsl:value-of select="org_previous_file/lc_tnx_record/pstv_tol_pct" />
					</xsl:with-param>
					<xsl:with-param name="org_neg_tol_pct">
						<xsl:value-of select="org_previous_file/lc_tnx_record/neg_tol_pct" />
					</xsl:with-param>
					<xsl:with-param name="org_max_cr_desc_code">
						<xsl:value-of select="org_previous_file/lc_tnx_record/max_cr_desc_code" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if
				test="narrative_additional_amount!=org_previous_file/lc_tnx_record/narrative_additional_amount">
				<xsl:call-template name="amend_additional_amount">
					<xsl:with-param name="narrative_additional_amount">
						<xsl:value-of select="narrative_additional_amount" />
					</xsl:with-param>
					<xsl:with-param name="org_narrative_additional_amount">
						<xsl:value-of
							select="org_previous_file/lc_tnx_record/narrative_additional_amount" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
		<xsl:if test="product_code[.='SI'] and tnx_type_code[.='03']">
			<xsl:if
				test="org_previous_file/si_tnx_record/pstv_tol_pct!=pstv_tol_pct or org_previous_file/si_tnx_record/neg_tol_pct!=neg_tol_pct or org_previous_file/si_tnx_record/max_cr_desc_code!=max_cr_desc_code">
				<xsl:call-template name="variation_drawing">
					<xsl:with-param name="pstv_tol_pct">
						<xsl:value-of select="pstv_tol_pct" />
					</xsl:with-param>
					<xsl:with-param name="neg_tol_pct">
						<xsl:value-of select="neg_tol_pct" />
					</xsl:with-param>
					<xsl:with-param name="max_cr_desc_code">
						<xsl:value-of select="max_cr_desc_code" />
					</xsl:with-param>
					<xsl:with-param name="org_pstv_tol_pct">
						<xsl:value-of select="org_previous_file/si_tnx_record/pstv_tol_pct" />
					</xsl:with-param>
					<xsl:with-param name="org_neg_tol_pct">
						<xsl:value-of select="org_previous_file/si_tnx_record/neg_tol_pct" />
					</xsl:with-param>
					<xsl:with-param name="org_max_cr_desc_code">
						<xsl:value-of select="org_previous_file/si_tnx_record/max_cr_desc_code" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="beneficiary-amendment-details"></xsl:call-template>
			<xsl:if test="$option != 'EXPORT_PDF_FULL'">
			<xsl:call-template name="renewal-amend-details"></xsl:call-template>
			</xsl:if>
			<xsl:if
				test="narrative_additional_amount!=org_previous_file/si_tnx_record/narrative_additional_amount">
				<xsl:call-template name="amend_additional_amount">
					<xsl:with-param name="narrative_additional_amount">
						<xsl:value-of select="narrative_additional_amount" />
					</xsl:with-param>
					<xsl:with-param name="org_narrative_additional_amount">
						<xsl:value-of
							select="org_previous_file/si_tnx_record/narrative_additional_amount" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
		<xsl:if test="product_code[.='BG'] and tnx_type_code[.='03']">
			<xsl:if
				test="org_previous_file/bg_tnx_record/pstv_tol_pct!=pstv_tol_pct or org_previous_file/bg_tnx_record/neg_tol_pct!=neg_tol_pct or org_previous_file/bg_tnx_record/max_cr_desc_code!=max_cr_desc_code">
				<xsl:call-template name="variation_drawing">
					<xsl:with-param name="pstv_tol_pct">
						<xsl:value-of select="pstv_tol_pct" />
					</xsl:with-param>
					<xsl:with-param name="neg_tol_pct">
						<xsl:value-of select="neg_tol_pct" />
					</xsl:with-param>
					<xsl:with-param name="max_cr_desc_code">
						<xsl:value-of select="max_cr_desc_code" />
					</xsl:with-param>
					<xsl:with-param name="org_pstv_tol_pct">
						<xsl:value-of select="org_previous_file/bg_tnx_record/pstv_tol_pct" />
					</xsl:with-param>
					<xsl:with-param name="org_neg_tol_pct">
						<xsl:value-of select="org_previous_file/bg_tnx_record/neg_tol_pct" />
					</xsl:with-param>
					<xsl:with-param name="org_max_cr_desc_code">
						<xsl:value-of select="org_previous_file/bg_tnx_record/max_cr_desc_code" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="beneficiary-amendment-details"></xsl:call-template>
			<xsl:if test="$option != 'EXPORT_PDF_FULL'">
			<xsl:call-template name="renewal-amend-details"></xsl:call-template>
			</xsl:if>
			<xsl:if
				test="narrative_additional_amount!=org_previous_file/bg_tnx_record/narrative_additional_amount">
				<xsl:call-template name="amend_additional_amount">
					<xsl:with-param name="narrative_additional_amount">
						<xsl:value-of select="narrative_additional_amount" />
					</xsl:with-param>
					<xsl:with-param name="org_narrative_additional_amount">
						<xsl:value-of
							select="org_previous_file/bg_tnx_record/narrative_additional_amount" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
		<!-- Shipment details -->
		<xsl:if
			test="product_code[.='LC'] and tnx_type_code[.='03'] and (
			(ship_from!='' and ship_from!=org_previous_file/lc_tnx_record/ship_from) or 
			(ship_loading!='' and ship_loading!=org_previous_file/lc_tnx_record/ship_loading) or 
			(ship_discharge!='' and ship_discharge!=org_previous_file/lc_tnx_record/ship_discharge) or 
			(ship_to!='' and ship_to!=org_previous_file/lc_tnx_record/ship_to) or 
			(narrative_shipment_period!='' and narrative_shipment_period!=org_previous_file/lc_tnx_record/narrative_shipment_period) or 
			(last_ship_date!='' and last_ship_date!=org_previous_file/lc_tnx_record/last_ship_date))">
			<xsl:call-template name="amend_shipment_details">
				<xsl:with-param name="ship_from">
					<xsl:value-of select="ship_from" />
				</xsl:with-param>
				<!-- SWIFT 2006 -->
				<xsl:with-param name="ship_loading">
					<xsl:value-of select="ship_loading" />
				</xsl:with-param>
				<xsl:with-param name="ship_discharge">
					<xsl:value-of select="ship_discharge" />
				</xsl:with-param>
				<!-- SWIFT 2006 -->
				<xsl:with-param name="ship_to">
					<xsl:value-of select="ship_to" />
				</xsl:with-param>
				<xsl:with-param name="last_ship_date">
					<xsl:value-of select="last_ship_date" />
				</xsl:with-param>
				<xsl:with-param name="narrative_shipment_period">
					<xsl:value-of select="narrative_shipment_period" />
				</xsl:with-param>
				<xsl:with-param name="org_ship_to">
					<xsl:value-of select="org_previous_file/lc_tnx_record/ship_to" />
				</xsl:with-param>
				<xsl:with-param name="org_ship_from">
					<xsl:value-of select="org_previous_file/lc_tnx_record/ship_from" />
				</xsl:with-param>
				<!-- SWIFT 2006 -->
				<xsl:with-param name="org_ship_loading">
					<xsl:value-of select="org_previous_file/lc_tnx_record/ship_loading" />
				</xsl:with-param>
				<xsl:with-param name="org_ship_discharge">
					<xsl:value-of select="org_previous_file/lc_tnx_record/ship_discharge" />
				</xsl:with-param>
				<!-- SWIFT 2006 -->
				<xsl:with-param name="org_last_ship_date">
					<xsl:value-of select="org_previous_file/lc_tnx_record/last_ship_date" />
				</xsl:with-param>
				<xsl:with-param name="org_narrative_shipment_period">
					<xsl:value-of
						select="org_previous_file/lc_tnx_record/narrative_shipment_period" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if
			test="product_code[.='SI'] and tnx_type_code[.='03'] and not($swift2018Enabled) and (
			(ship_from!='' and ship_from!=org_previous_file/si_tnx_record/ship_from) or 
			(ship_loading!='' and ship_loading!=org_previous_file/si_tnx_record/ship_loading) or 
			(ship_discharge!='' and ship_discharge!=org_previous_file/si_tnx_record/ship_discharge) or 
			(ship_to!='' and ship_to!=org_previous_file/si_tnx_record/ship_to) or 
			(narrative_shipment_period!='' and narrative_shipment_period!=org_previous_file/si_tnx_record/narrative_shipment_period) or 
			(last_ship_date!='' and last_ship_date!=org_previous_file/si_tnx_record/last_ship_date))">
			<xsl:call-template name="amend_shipment_details">
				<xsl:with-param name="ship_from">
					<xsl:value-of select="ship_from" />
				</xsl:with-param>
				<!-- SWIFT 2006 -->
				<xsl:with-param name="ship_loading">
					<xsl:value-of select="ship_loading" />
				</xsl:with-param>
				<xsl:with-param name="ship_discharge">
					<xsl:value-of select="ship_discharge" />
				</xsl:with-param>
				<!-- SWIFT 2006 -->
				<xsl:with-param name="ship_to">
					<xsl:value-of select="ship_to" />
				</xsl:with-param>
				<xsl:with-param name="last_ship_date">
					<xsl:value-of select="last_ship_date" />
				</xsl:with-param>
				<xsl:with-param name="narrative_shipment_period">
					<xsl:value-of select="narrative_shipment_period" />
				</xsl:with-param>
				<xsl:with-param name="org_ship_to">
					<xsl:value-of select="org_previous_file/si_tnx_record/ship_to" />
				</xsl:with-param>
				<xsl:with-param name="org_ship_from">
					<xsl:value-of select="org_previous_file/si_tnx_record/ship_from" />
				</xsl:with-param>
				<!-- SWIFT 2006 -->
				<xsl:with-param name="org_ship_loading">
					<xsl:value-of select="org_previous_file/si_tnx_record/ship_loading" />
				</xsl:with-param>
				<xsl:with-param name="org_ship_discharge">
					<xsl:value-of select="org_previous_file/si_tnx_record/ship_discharge" />
				</xsl:with-param>
				<!-- SWIFT 2006 -->
				<xsl:with-param name="org_last_ship_date">
					<xsl:value-of select="org_previous_file/si_tnx_record/last_ship_date" />
				</xsl:with-param>
				<xsl:with-param name="org_narrative_shipment_period">
					<xsl:value-of
						select="org_previous_file/si_tnx_record/narrative_shipment_period" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<!-- Additional details are provided for an amendment -->
		<xsl:if test="product_code[.='BG'] and tnx_type_code[.='03'] and sub_tnx_type_code[.='05']">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<fo:table-row>
						<fo:table-cell number-columns-spanned="2">
							<fo:block />
						</fo:table-cell>
					</fo:table-row>
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_RELEASE_AMOUNT_DETAILS')" />
						</xsl:with-param>
					</xsl:call-template>
			
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_GTEE_RELEASE_AMT_LABEL')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="bg_cur_code" />&nbsp;<xsl:value-of select="release_amt" />
						</xsl:with-param>
					</xsl:call-template>
		
					<xsl:if test="bg_release_flag[.='Y']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_GTEE_RELEASE_FULL')" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="amd_details[.!='']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language,'XSL_HEADER_AMENDMENT_NARRATIVE')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="amd_details" />
								</xsl:with-param>
							</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
		<!-- Additional details are provided for an amendment -->
		<xsl:if test="product_code[.='SI'] and sub_tnx_type_code[.='05'] and lc_release_flag[.='Y']">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_GTEE_RELEASE_FULL')" />
							</xsl:with-param>
						</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<!-- Additional Information Provided by the Client for amendment -->
		<xsl:if test="amd_details[.!=''] and (product_code[.!='BG'] and tnx_type_code[.!='03'] and sub_tnx_type_code[.!='05'] and tnx_stat_code[.!='03'])">
			<fo:block keep-together="always">
				<fo:table width="{$pdfTableWidth}" keep-together="always"
					font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
					<fo:table-column column-width="{$pdfTableWidth}" />
					<fo:table-column column-width="0" /> <!--  dummy column -->
					<fo:table-body>
						<xsl:call-template name="subtitle2">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language,'XSL_HEADER_AMENDMENT_NARRATIVE')" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell2">
							<xsl:with-param name="text">
								<xsl:value-of select="amd_details"/>
							</xsl:with-param>
						</xsl:call-template>
					</fo:table-body>
				</fo:table>
			</fo:block>
		</xsl:if>
		<!-- Additional Information Provided by the Client -->
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
			<xsl:variable name="headerExist">false</xsl:variable>
			
				<!-- No empty table allowed -->
				<fo:table-row>
					<fo:table-cell number-columns-spanned="2">
						<fo:block />
					</fo:table-cell>
				</fo:table-row>
				<xsl:if
					test="(not(lc_type) or lc_type !='02') and (free_format_text[.!=''] and (sub_product_code[.!='DOM']) and (sub_product_code[.!='HVPS']) and 
						(sub_product_code[.!='HVXB']) and (sub_product_code[.!='CTCHP']) and (sub_product_code[.!='INT']) and 
						(sub_product_code[.!='BILLP']) and (sub_product_code[.!='PICO']) and (sub_product_code[.!='PIDD']) and 
						(sub_product_code[.!='TPT']) and (sub_product_code[.!='MT101']) and (sub_product_code[.!='MT103']) and 
						(sub_product_code[.!='FI103']) and (sub_product_code[.!='FI202']) and (sub_product_code[.!='ULOAD']))
						 and (free_format_text !='' or 
					     attachments/attachment[type='01'] or 
					     principal_act_no !='' or 
					     fee_act_no !='' or 
					     ((adv_send_mode !='' and (adv_send_mode[.='01' or .='02' or .='03' or .='04' or .='99'])) and tnx_type_code[.='01' or .='03']) or 
					     (docs_send_mode !='' and tnx_type_code ='01') or 
					     (fwd_contract_no !='' and (product_code ='EC'))) or ((product_code = 'IP' or product_code = 'IN') and tnx_type_code[.!='85'])">
							<xsl:variable name="headerExist">true</xsl:variable>
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_INSTRUCTIONS')" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="delivery_channel[. != '']">
					<!--Advice Attachments Send Mode-->
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_REQ_DELIVERY_CHANNEL_LABEL')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="delivery_channel[. = 'FACT']">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_FILESDETAILS_FILEACT_DELIVERY_CHANNEL_FACT')" />
								</xsl:when>
								<xsl:when test="delivery_channel[. = 'FAXT']">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_FILESDETAILS_FILEACT_DELIVERY_CHANNEL_FAXT')" />
								</xsl:when>
								<xsl:when test="delivery_channel[. = 'EMAL']">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_FILESDETAILS_FILEACT_DELIVERY_CHANNEL_EMAL')" />
								</xsl:when>
								<xsl:when test="delivery_channel[. = 'MAIL']">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_FILESDETAILS_FILEACT_DELIVERY_CHANNEL_MAIL')" />
								</xsl:when>
								<xsl:when test="delivery_channel[. = 'COUR']">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_FILESDETAILS_FILEACT_DELIVERY_CHANNEL_COUR')" />
								</xsl:when>								
								<xsl:otherwise>
									<xsl:value-of select="localization:getDecode($language, 'N802', delivery_channel)"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>				
				
				<xsl:if test="principal_act_no[. != ''] or free_format_text[. != ''] or fee_act_no[. != ''] or 
							(fwd_contract_no[.!=''] and product_code[.='EC']) or
							(product_code[.='TF'] and ((repayment_mode[.!=''] and sub_tnx_type_code[.='38']) or
							(tnx_amt[.!=''] and tnx_type_code[.!='03']) or
							interest_amt[.!=''] or settlement_code[.!='']))">
					<xsl:if test="principal_act_no[. != ''] and ((product_code[.!='LI' and .!='EC' and .!='BG']) and (tnx_type_code[ .!= '13']))">
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
					<xsl:if test="fee_act_no[. != ''] and ((product_code[.!='LI' and .!='EC' and .!='BG']) and (tnx_type_code[ .!= '13']))">
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
					<xsl:if test="product_code[.='TF']">
						<xsl:if test="repayment_mode[.!=''] and sub_tnx_type_code[.='38']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_REPAYMENT_MODE')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:if test="repayment_mode[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPAYMENT_PRINCIPAL')"/></xsl:if>
									<xsl:if test="repayment_mode[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPAYMENT_PRINCIPAL_INTEREST')"/></xsl:if>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="tnx_amt[.!=''] and (tnx_type_code[.!='03'] and tnx_type_code[.!='01'])">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_REPAYMENT_AMOUNT')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="repayment_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="interest_amt[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_INTEREST_AMOUNT')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="repayment_cur_code"/>&nbsp;<xsl:value-of select="interest_amt"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="settlement_code[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_GENERALDETAILS_SETTLEMENT_METHOD')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:if test="settlement_code[.='01']"><xsl:value-of select="localization:getDecode($language, 'N045', '01')"/></xsl:if>
									<xsl:if test="settlement_code[.='03']"><xsl:value-of select="localization:getDecode($language, 'N045', '03')"/></xsl:if>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:if>
					<xsl:if test="fwd_contract_no[.!=''] and product_code[.!='IR' and .!='EC' and .!='IC' and .!='LC' and .!='SI']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="fwd_contract_no"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					</xsl:if>
					
						
						
					<xsl:if test="(free_format_text[.!=''] and (sub_product_code[.!='DOM']) and (sub_product_code[.!='HVPS']) and 
					(sub_product_code[.!='HVXB']) and (sub_product_code[.!='CTCHP']) and (sub_product_code[.!='INT']) and 
					(sub_product_code[.!='BILLP']) and (sub_product_code[.!='PICO']) and (sub_product_code[.!='PIDD']) and 
					(sub_product_code[.!='TPT']) and (sub_product_code[.!='MT101']) and (sub_product_code[.!='MT103']) and 
					(sub_product_code[.!='FI103']) and (sub_product_code[.!='FI202']) and (sub_product_code[.!='ULOAD']) or 
					(product_code[.='LC'] and adv_send_mode[. != ''] and tnx_type_code[.='01' or .='03']) or 
					(product_code[.='BG'] and adv_send_mode[. != ''] and tnx_type_code[.='01' or .='03']) or
					(product_code[.='EC'] and docs_send_mode[.!= ''] and tnx_type_code[.='01'])) and
					 not($headerExist and
					 (product_code[.='BG' or .='LI' or .='SI' or .='EL' or .='SR' or .='LC' or .='IR' or .='EC' or .='IC' or .='SG' or .='BR' or .='FT'])
					  and not(product_code[.='FT'] and sub_product_code[.='PICO' or .='PIDD' or .='INT' or .='TPT']))">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:choose>
									<xsl:when test="product_code[.='FT'] and sub_product_code[.='PICO' or .='PIDD' or .='INT' or .='TPT']">
										<xsl:value-of select="localization:getGTPString($language,'XSL_HEADER_TRANSACTION_REMARKS')" />
									</xsl:when>
									<xsl:when test="product_code[.='LS'] and sub_tnx_type_code[.='96']">
										<xsl:value-of select="localization:getGTPString($language,'XSL_REASON_FOR_CANCELLATION_TITLE')" />
									</xsl:when>
									<xsl:when test="product_code[.='BG' or .='LI' or .='SI' or .='EL' or .='SR' or .='LC' or .='IR' or .='EC' or .='IC' or .='SG' or .='BR' or .='FT']">
										<xsl:value-of select="localization:getGTPString($language,'XSL_HEADER_INSTRUCTIONS')" />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="localization:getGTPString($language,'XSL_HEADER_FREE_FORMAT_TITLE')" />
									</xsl:otherwise>
								</xsl:choose>
								
							</xsl:with-param>
							
						</xsl:call-template>
						</xsl:if>
						<xsl:if test="(not(product_code[.='EL'] and sub_tnx_type_code[.='87']) and (adv_send_mode[. != ''] and (adv_send_mode[.='01' or .='02' or .='03' or .='04' or .='99']))and tnx_type_code[.='01' or .='03' or .='13'] and sub_product_code[.!='CQBKR']) or (product_code[.='BG'])">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_REQ_SEND_MODE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="adv_send_mode[. = '01']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')" />
									</xsl:when>
									<xsl:when test="adv_send_mode[. = '02']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')" />
									</xsl:when>
									<xsl:when test="adv_send_mode[. = '03']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')" />
									</xsl:when>
									<xsl:when test="adv_send_mode[. = '04']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_REGISTERED_POST')" />
									</xsl:when>
									<xsl:when test="adv_send_mode[. = '99']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_OTHER')" />
									</xsl:when>
									<xsl:otherwise />
								</xsl:choose>
							</xsl:with-param>
							</xsl:call-template>
							<xsl:if test="adv_send_mode[.='99']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text"/>
									<xsl:with-param name="right_text">
									<xsl:value-of select="adv_send_mode_text"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>	
						</xsl:if>
						<xsl:if test="docs_send_mode[. != ''] and tnx_type_code[.='01']">
					<!--Documents Send Mode-->
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_DOCS_SEND_MODE_LABEL')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="docs_send_mode[. = '03']">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')" />
								</xsl:when>
								<xsl:when test="docs_send_mode[. = '04']">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_REGISTERED_POST')" />
								</xsl:when>
								<xsl:otherwise />
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
					
						
						<xsl:if test="principal_act_no[. != ''] and ((product_code[.='LI' or .='BG' or .='EC']) or (product_code[.='TF'] and tnx_type_code[ .= '13']))">
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
					<xsl:if test="fee_act_no[. != ''] and ((product_code[.='LI' or .='BG' or .='EC']) or (product_code[.='TF'] and tnx_type_code[ .= '13']))">
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
					<xsl:if test="delivery_to[.!=''] and product_code[.='BG']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_LABEL')"/>
									<!-- xsl:value-of select="delivery_to" />  -->
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:variable name="delv_to_code"><xsl:value-of select="delivery_to"></xsl:value-of></xsl:variable>								
								<xsl:value-of select="localization:getDecode($language, 'N292', $delv_to_code)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="product_code[.='TF'] and tnx_type_code[ .= '13'] and security:isCustomer($rundata)">
							 <xsl:if test="tnx_amt[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_REPAYMENT_AMOUNT')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="repayment_cur_code" />&nbsp;<xsl:value-of select="tnx_amt" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							 <xsl:if test="repayment_mode[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_REPAYMENT_MODE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:choose>
											<xsl:when test="repayment_mode[.='01']">
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_REPAYMENT_PRINCIPAL')" />
											</xsl:when>
											<xsl:when test="repayment_mode[.='02']">
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_REPAYMENT_PRINCIPAL_INTEREST')" />
											</xsl:when>
										</xsl:choose>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>							
							<xsl:if test="interest_amt[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_INTEREST_AMOUNT')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="repayment_cur_code" />&nbsp;<xsl:value-of select="interest_amt" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="settlement_code[.!= '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_GENERALDETAILS_SETTLEMENT_METHOD')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="settlement_code[.='01']">
										<xsl:value-of
											select="localization:getDecode($language, 'N045', '01')" />
									</xsl:when>
									<xsl:when test="settlement_code[.='03']">
										<xsl:value-of
											select="localization:getDecode($language, 'N045', '03')" />
									</xsl:when>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					</xsl:if>
					<xsl:if test="fwd_contract_no[.!= '']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="fwd_contract_no"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="free_format_text[.!=''] and (sub_product_code[.!='DOM']) and (sub_product_code[.!='BILLP']) and (sub_product_code[.!='TPT']) and (sub_product_code[.!='PICO']) and (sub_product_code[.!='INT']) and (sub_product_code[.!='PIDD']) and (sub_product_code[.!='MT101']) and (sub_product_code[.!='MT103']) and (sub_product_code[.!='FI103']) and (sub_product_code[.!='FI202']) and (sub_product_code[.!='HVPS']) and (sub_product_code[.!='HVXB']) and (product_code[.!='SE'] or (product_code[.='SE'] and sub_product_code[.!='COCQS'])) and (sub_product_code[.!='CTCHP']) and (sub_product_code[.!='ULOAD'])">
						<xsl:choose>
						<xsl:when test="product_code[.='LC'] and security:isBank($rundata)">
						<xsl:apply-templates select="free_format_text">
							<xsl:with-param name="theNodeName" select="'free_format_text'" />
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_FREE_FORMAT_CUSTOMER_INSTRUCTIONS')" />
						</xsl:apply-templates>
						</xsl:when>
						<xsl:when test="product_code[.='EL' or 'SR']">
							<xsl:apply-templates select="free_format_text">
								<xsl:with-param name="theNodeName" select="'free_format_text'" />
								<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_HEADER_FREE_FORMAT_TITLE')" />
							</xsl:apply-templates>
						</xsl:when>
						<xsl:otherwise>
						<xsl:apply-templates select="free_format_text">
							<xsl:with-param name="theNodeName" select="'free_format_text'" />
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_HEADER_FREE_FORMAT_TITLE')" />
						</xsl:apply-templates>
						</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				
				<!-- 	</xsl:if> -->
					<xsl:if test="return_comments/text[.!=''] and (tnx_stat_code[.!='03' and .!='04']) and not((product_code[.='LN']) or (product_code[.='BK'] and sub_product_code[.='LNRPN']))">
                       <xsl:call-template name="subtitle2">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language,'XSL_HEADER_MC_COMMENTS_FOR_RETURN')" />
							</xsl:with-param>
			           </xsl:call-template>
						   <xsl:call-template name="table_cell2">
		 				   <xsl:with-param name="text">
								<xsl:value-of select="return_comments/text" />
						   </xsl:with-param>
					   </xsl:call-template>
					</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		
		<xsl:if test="attachments/attachment[type = '01']">
			<xsl:variable name="delivery-channel"><xsl:value-of select="delivery_channel"/></xsl:variable>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_CUSTOMER_FILE_UPLOAD')" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:choose>
				<!-- File Act send mode needs uses 3 columned template and the rest uses 2 columned tempalte. -->
				<xsl:when test="delivery_channel and delivery_channel[.='FACT']">
					<xsl:call-template name="table_3_columns_template">
						<xsl:with-param name="table_width">100%</xsl:with-param>
						<xsl:with-param name="column_1_width">45%</xsl:with-param>
						<xsl:with-param name="column_2_width">45%</xsl:with-param>
						<xsl:with-param name="column_3_width">10%</xsl:with-param>
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_TITLE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_NAME')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
								<xsl:with-param name="column_3_text">
									<xsl:choose>
										<xsl:when test="delivery_channel[. = 'FACT']">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_ACT')"/>
										</xsl:when>
									</xsl:choose>
								</xsl:with-param>
								<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_weight">bold</xsl:with-param>
								<xsl:with-param name="column_3_text_align">center</xsl:with-param>
							</xsl:call-template>
							<xsl:for-each select="attachments/attachment">
							<xsl:if test="type = '01'">
							<xsl:variable name="filename"><xsl:value-of select="securityUtils:decodeHTML(file_name)"/></xsl:variable>
							<xsl:variable name="title"><xsl:value-of select="title"/></xsl:variable>
							<xsl:variable name="colWidth">40%</xsl:variable>
							<xsl:call-template name="table_cell_3_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="title" /></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">left</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="securityUtils:decodeHTML(file_name)" /></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">left</xsl:with-param>
								<xsl:with-param name="column_3_text">
									<xsl:choose>
										<xsl:when test="$delivery-channel = 'FACT' and for_fileact[.!='']">
											<xsl:value-of select="localization:getDecode($language, 'N034', for_fileact[.])" />
										</xsl:when>
										<xsl:when test="$delivery-channel = 'FACT' and for_fileact[.='']">
											<xsl:value-of select="localization:getDecode($language, 'N034', 'N')" />
										</xsl:when>
									</xsl:choose>
								</xsl:with-param>
								<xsl:with-param name="column_3_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_3_text_font_weight"/>
								<xsl:with-param name="column_3_text_align">center</xsl:with-param>
							</xsl:call-template>
							</xsl:if>
							</xsl:for-each>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>				
				<xsl:otherwise>
					<xsl:call-template name="table_2_columns_template">
						<xsl:with-param name="table_width">100%</xsl:with-param>
						<xsl:with-param name="column_1_width">50%</xsl:with-param>
						<xsl:with-param name="column_2_width">50%</xsl:with-param>
						<xsl:with-param name="text">					
							<xsl:call-template name="table_cell_2_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_TITLE')"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_NAME')"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
							</xsl:call-template>
							<xsl:for-each select="attachments/attachment">
							<xsl:if test="type = '01'">
							<xsl:variable name="filename"><xsl:value-of select="securityUtils:decodeHTML(file_name)"/></xsl:variable>
							<xsl:variable name="title"><xsl:value-of select="title"/></xsl:variable>
							<xsl:variable name="colWidth">45%</xsl:variable>
							<xsl:call-template name="table_cell_2_columns">
								<xsl:with-param name="column_1_text"><xsl:value-of select="formatter:wrapStringforPDF($colWidth,$title)" /></xsl:with-param>
								<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_1_text_font_weight"/>
								<xsl:with-param name="column_1_text_align">left</xsl:with-param>
								<xsl:with-param name="column_2_text"><xsl:value-of select="formatter:wrapStringforPDF($colWidth,$filename)" /></xsl:with-param>
								<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
								<xsl:with-param name="column_2_text_font_weight"/>
								<xsl:with-param name="column_2_text_align">left</xsl:with-param>
							</xsl:call-template>
							</xsl:if>
							</xsl:for-each>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>

			</xsl:choose>		
		</xsl:if>
		<!--stop  -->
		
		
		<!-- NOTE: While un-commenting the block below, please add apt condition to restrict this
		 section's visibility to the product and subproducts for which it is being added -->
<!-- 		<xsl:if test="tnx_stat_code[.='04'] or (tnx_stat_code[.='03'] and sub_tnx_stat_code[.='89' or .='90' or .='91']) or security:isBank($rundata)">
	<xsl:call-template name="table_template">
		<xsl:with-param name="text">
			<xsl:call-template name="title">
				<xsl:with-param name="text">
					<xsl:choose>
						<xsl:when
							test="product_code[.='IN' or .='IP' or .='PO' or .='SO' or .='CN']">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_MESSAGE')" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_BANK_MESSAGE')" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="bo_release_dttm[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_DTTM')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of
							select="formatter:formatReportDate(bo_release_dttm,$rundata)" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="prod_stat_code[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_PROD_STAT_LABEL')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when
								test="(product_code[.='LN'] or product_code[.='BK'] and sub_product_code[.='LNRPN']) and  prod_stat_code='01' and tnx_stat_code='04' and (sub_tnx_stat_code='05' or sub_tnx_stat_code='' or sub_tnx_stat_code='17'   ) ">
								<xsl:value-of
									select="localization:getGTPString($language, 'STATUS_CODE_LOAN_CANCELLED')" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of
									select="localization:getDecode($language, 'N005', prod_stat_code[.])" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>	
			<xsl:if test="bo_comment[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_COMMENT_BANK')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						
								<xsl:value-of select="bo_comment" />
							
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="sub_product_code[.!='TRTD'] and bo_ref_id[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="bo_ref_id" />
							</xsl:with-param>
						</xsl:call-template>	
			</xsl:if>
			<xsl:if test="action_req_code[.!=''] and product_code[.!='FX']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ACTION_REQUIRED')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of
									select="localization:getDecode($language, 'N042', action_req_code)" />
							</xsl:with-param>
						</xsl:call-template>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
</xsl:if> -->

		<!-- Bank Message -->
		<xsl:if test="(tnx_stat_code[.='04'] or security:isBank($rundata) or (finance_requested_flag[.='Y' or .='P'] and tnx_type_code[.='63']) or ((product_code [.='IP' or .='IN']) and tnx_type_code[.='85'])) and product_code[.!='FT']">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:choose>	
								<xsl:when test="product_code[.='IN' or .='IP' or .='PO' or .='SO' or .='CN']">
									<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_MESSAGE')" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_BANK_MESSAGE')" />	
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
							<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_DTTM')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								 <xsl:choose>	
									<xsl:when test="release_dttm[.!='']">
										<xsl:value-of select="formatter:formatReportDate(release_dttm,$rundata)"/>	
									</xsl:when>
								<xsl:otherwise>
		    						<xsl:value-of select="formatter:formatReportDate(bo_release_dttm,$rundata)"/>	
								</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
				<xsl:if test="$optionCode != 'SNAPSHOT_PDF'">
					<xsl:if test="prod_stat_code[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_PROD_STAT_LABEL')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="(product_code[.='LN'] or product_code[.='BK'] and sub_product_code[.='LNRPN']) and  prod_stat_code='01' and tnx_stat_code='04' and (sub_tnx_stat_code='05' or sub_tnx_stat_code='' or sub_tnx_stat_code='17'   ) ">
									    <xsl:value-of select="localization:getGTPString($language, 'STATUS_CODE_LOAN_CANCELLED')" />
					                </xsl:when>
									<xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N005', prod_stat_code[.])"/></xsl:otherwise>
							</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:if>
					<xsl:if test="free_format_text[.!=''] and (product_code[.='SE'] and sub_product_code[.='COCQS'])">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_COMMENT_BANK')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="free_format_text"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
						<xsl:if test="product_code[.='IN' or .='IP']">
							<xsl:if test="eligibility_flag[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
										select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ELIGIBILITY_STATUS_LABEL')" />
									</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="localization:getDecode($language, 'N085', eligibility_flag[.])" />
										</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="full_finance_accepted_flag[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
										select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IN_FULL_FINANCING_FLAG_LABEL')" />
									</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="full_finance_accepted_flag" />
										</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="total_net_amt[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
										select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IN_INVOICE_AMOUNT')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="total_net_cur_code"/>&nbsp;<xsl:value-of select="total_net_amt"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="inv_eligible_amt[.!=''] and sub_tnx_type_code[.!='A4'] and tnx_type_code[.!='85']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
										select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IN_INVOICE_ELIGIBLE_AMOUNT')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="inv_eligible_cur_code"/>&nbsp;<xsl:value-of select="inv_eligible_amt"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="finance_requested_flag[.='Y' or .='P'] and tnx_type_code[.='63']">
								<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IN_FINANCE_CURRENCY')" />
										</xsl:with-param>
											<xsl:with-param name="right_text">
												<xsl:choose>
									    			<xsl:when test="finance_requested_cur_code[.='']"><xsl:value-of select="inv_eligible_cur_code"/></xsl:when>
									    			<xsl:otherwise><xsl:value-of select="finance_requested_cur_code"/></xsl:otherwise>
									    		</xsl:choose>
											</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
											select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IN_FINANCE_REQUESTED_AMT')" />
										</xsl:with-param>
											<xsl:with-param name="right_text">
											<xsl:value-of select="finance_requested_cur_code"/>&nbsp;<xsl:value-of select="finance_requested_amt"/>
										</xsl:with-param>
								</xsl:call-template>
				          	</xsl:if>
				          	<xsl:if test="finance_amt[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
										select="localization:getGTPString($language, 'XSL_GENERALDETAILS_IN_FINANCE_AMOUNT')" />
									</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="finance_cur_code"/>&nbsp;<xsl:value-of select="finance_amt"/>
										</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="finance_repayment_amt[.!=''] and sub_tnx_type_code[.='A4']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
										select="localization:getGTPString($language, 'XSL_REPAYMENT_AMOUNT')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="finance_repayment_cur_code"/>&nbsp;<xsl:value-of select="finance_repayment_amt"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="total_repaid_amt[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
										select="localization:getGTPString($language, 'TOTAL_REPAID_AMT')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="total_repaid_cur_code"/>&nbsp;<xsl:value-of select="total_repaid_amt"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>							
							<xsl:if test="outstanding_repayment_amt[.!='']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
										select="localization:getGTPString($language, 'XSL_OUTSTANDING_REPAYMENT')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="outstanding_repayment_cur_code"/>&nbsp;<xsl:value-of select="outstanding_repayment_amt"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="settlement_amt[.!=''] and tnx_type_code[.='85']">
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SETTLEMENT_AMOUNT')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="settlement_cur_code"/>&nbsp;<xsl:value-of select="settlement_amt"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="liab_total_amt[.!=''] and not (product_code[.='IN' or .='IP'])">
								<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_AMT_LABEL')" />
										</xsl:with-param>
											<xsl:with-param name="right_text">
												<xsl:value-of select="liab_total_amt"/>
											</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="liab_total_net_amt[.!=''] and product_code[.='IP' or .='IN']">
								<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
											select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_AMT_LABEL')" />
										</xsl:with-param>
											<xsl:with-param name="right_text">
												<xsl:value-of select="liab_total_net_cur_code"/>&nbsp;<xsl:value-of select="liab_total_net_amt"/>
											</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="conditions[.!='']">
								<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of
											select="localization:getGTPString($language, 'XSL_HEADER_OPTIONAL_PROGRAMME_CONDITIONS')" />
										</xsl:with-param>
											<xsl:with-param name="right_text">
												<xsl:value-of select="conditions"/>
											</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="bo_ref_id[.!=''] and sub_product_code[.!='TRINT'] and sub_product_code[.!='TRTPT'] and sub_product_code[.!='TRTD'] and product_code[.!='FX' and .!='IN' and .!='IP']">
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
			<xsl:if test="product_code[.='BG']">
				<xsl:if test="extend_pay_date[.!='']">
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_EXTEND_PAY_DATE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="extend_pay_date" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="latest_date_reply[.!='']">
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_LATEST_DATE_REPLY_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="latest_date_reply" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:if>
			<xsl:if test="tnx_type_code[.!='24']">
			<xsl:if test="product_code[.='SI' or .='LC']">
				<xsl:if test="claim_reference[.!='']">
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CLAIM_REFERENCE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="claim_reference" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="claim_present_date[.!='']">
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CLAIM_PRESENT_DATE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="claim_present_date" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="claim_amt[.!=''] and claim_cur_code[.!='']">
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CLAIM_AMOUNT_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="claim_cur_code" />&nbsp;<xsl:value-of select="claim_amt" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:if>
			<xsl:if test="action_req_code[.!=''] and product_code[.!='FX']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ACTION_REQUIRED')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of
									select="localization:getDecode($language, 'N042', action_req_code)" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			</xsl:if>
		<xsl:if test="bo_comment[.!='']">
					<fo:table width="{$pdfTableWidth}" 
					font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
					<fo:table-column column-width="{$pdfTableWidth}" />
					<fo:table-column column-width="0"/> <!--  dummy column -->
					<fo:table-body>
						<xsl:call-template name="subtitle2">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language,'XSL_REPORTINGDETAILS_COMMENT_BANK')" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:choose>
							<xsl:when test = "(prod_stat_code[.='01'] and sub_tnx_stat_code[.='20']) and (product_code[.='LN'] or (product_code[.='BK'] and sub_product_code[.='LNRPN']))">
								<xsl:call-template name="table_cell2">
									<xsl:with-param name="text">
										<xsl:value-of select="localization:getGTPString($language,'LN_BUSINESS_VALIDATION_ERROR')" />
									</xsl:with-param>
								</xsl:call-template>	
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="table_cell2">
									<xsl:with-param name="text">
										<xsl:value-of select="bo_comment"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:if test="action_req_code[.!=''] and product_code[.!='FX']">
						</xsl:if>
					</fo:table-body>
				</fo:table>
			</xsl:if>
			<xsl:if test="attachments/attachment[type = '02']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_BANK_FILE_UPLOAD')" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="table_2_columns_template">
					<xsl:with-param name="table_width">100%</xsl:with-param>
					<xsl:with-param name="column_1_width">50%</xsl:with-param>
					<xsl:with-param name="column_2_width">50%</xsl:with-param>
					<xsl:with-param name="text">					
						<xsl:call-template name="table_cell_2_columns">
							<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_TITLE')"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
							<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_NAME')"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
						</xsl:call-template>
						<xsl:for-each select="attachments/attachment">
						<xsl:if test="type = '02'">
						<xsl:call-template name="table_cell_2_columns">
							<xsl:with-param name="column_1_text"><xsl:value-of select="title" /></xsl:with-param>
							<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_weight"/>
							<xsl:with-param name="column_1_text_align">left</xsl:with-param>
							<xsl:with-param name="column_2_text"><xsl:value-of select="securityUtils:decodeHTML(file_name)" /></xsl:with-param>
							<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_weight"/>
							<xsl:with-param name="column_2_text_align">left</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						</xsl:for-each>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="attachments/attachment[type = '07']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTIONAL_ATTACHMENT')" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="table_2_columns_template">
					<xsl:with-param name="table_width">100%</xsl:with-param>
					<xsl:with-param name="column_1_width">50%</xsl:with-param>
					<xsl:with-param name="column_2_width">50%</xsl:with-param>
					<xsl:with-param name="text">					
						<xsl:call-template name="table_cell_2_columns">
							<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_TITLE')"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
							<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_NAME')"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
						</xsl:call-template>
						<xsl:for-each select="attachments/attachment">
						<xsl:if test="type = '07'">
						<xsl:call-template name="table_cell_2_columns">
							<xsl:with-param name="column_1_text"><xsl:value-of select="title" /></xsl:with-param>
							<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_weight"/>
							<xsl:with-param name="column_1_text_align">left</xsl:with-param>
							<xsl:with-param name="column_2_text"><xsl:value-of select="securityUtils:decodeHTML(file_name)" /></xsl:with-param>
							<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_weight"/>
							<xsl:with-param name="column_2_text_align">left</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						</xsl:for-each>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="attachments/attachment[type = '08']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_UPLOADED_SWIFT_FILES')" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="table_2_columns_template">
					<xsl:with-param name="table_width">100%</xsl:with-param>
					<xsl:with-param name="column_1_width">50%</xsl:with-param>
					<xsl:with-param name="column_2_width">50%</xsl:with-param>
					<xsl:with-param name="text">					
						<xsl:call-template name="table_cell_2_columns">
							<xsl:with-param name="column_1_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_TITLE')"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_weight">bold</xsl:with-param>
							<xsl:with-param name="column_2_text"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILE_NAME')"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_weight">bold</xsl:with-param>
						</xsl:call-template>
						<xsl:for-each select="attachments/attachment">
						<xsl:if test="type = '08'">
						<xsl:call-template name="table_cell_2_columns">
							<xsl:with-param name="column_1_text"><xsl:value-of select="title" /></xsl:with-param>
							<xsl:with-param name="column_1_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_1_text_font_weight"/>
							<xsl:with-param name="column_1_text_align">left</xsl:with-param>
							<xsl:with-param name="column_2_text"><xsl:value-of select="securityUtils:decodeHTML(file_name)" /></xsl:with-param>
							<xsl:with-param name="column_2_text_font_family"><xsl:value-of select="$pdfFont"/></xsl:with-param>
							<xsl:with-param name="column_2_text_font_weight"/>
							<xsl:with-param name="column_2_text_align">left</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						</xsl:for-each>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		
		<!-- Charges -->
		<xsl:choose>
        	 <xsl:when test="count(charges/charge[created_in_session = 'Y']) != 0 and product_code[.!='LI'] and product_code[.!='BG'] and product_code[.!='LC'] and product_code[.!='BR'] and product_code[.!='IC'] and product_code[.!='EL'] and product_code[.!='EC'] and product_code[.!='SI'] and product_code[.!='SR'] and product_code[.!='TF']" >
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
			</xsl:when>
		  <xsl:when test="count(charges/charge[created_in_session = 'Y']) != 0 and (product_code[.='LI'] or product_code[.='BG'] or product_code[.='LC'] or product_code[.='IC'] or product_code[.='EL'] or product_code[.='EC'] or product_code[.='SI'] or product_code[.='BR'] or product_code[.='SR'] or product_code[.='TF']) and security:isCustomer($rundata)">
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
			</xsl:when>
		</xsl:choose>
		
		<!-- Discrepant Details  LC/SI -->
		<xsl:if test="org_discrepant_file/lc_tnx_record">
			<xsl:apply-templates select="org_discrepant_file/lc_tnx_record"
				mode="discrepant" />
		</xsl:if>
		<xsl:if test="org_discrepant_file/si_tnx_record">
			<xsl:apply-templates select="org_discrepant_file/si_tnx_record"
				mode="discrepant" />
		</xsl:if>
		
		<!-- XO inquiry -->
        <xsl:if test="tnx_type_code[.='13'] and  product_code[.='XO']">
        	<xsl:choose>
        		<!-- Update -->
        		<xsl:when test="sub_tnx_type_code[.='18']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_CONTRACT_DETAILS')" />
							</xsl:with-param>
						</xsl:call-template>
						<!-- Purchase/Sale -->
						<xsl:if test="contract_type[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="contract_type[. = '01']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_SALE_LABEL')" />
										</xsl:when>
										<xsl:when test="contract_type[. = '02']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_PURCHASE_LABEL')" />
										</xsl:when>
										<xsl:when test="contract_type[. = '03']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_CONTACT_LABEL')" />
										</xsl:when>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Expiration code -->
						<xsl:if test="expiration_code[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CONTRACT_XO_EXPIRATION_CODE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="localization:getDecode($language, 'N412', expiration_code[.])" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Expiration date -->
						<xsl:if test="expiration_date[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CONTRACT_XO_EXPIRATION_DATE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="expiration_date" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="expiration_date_term_number[. != ''] or expiration_date_term_code[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CONTRACT_FX_VALUE_DATE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="concat(expiration_date_term_number, ' ', localization:getDecode($language, 'N413', expiration_date_term_code[.]))" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Counter currency -->
						<xsl:if test="counter_cur_code[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CONTRACT_FX_SETTLEMENT_CURRENCY_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="counter_cur_code" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Currency amount -->
						<xsl:if test="fx_cur_code[. != ''] and fx_amt[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_AMOUNT_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="concat(fx_cur_code, ' ', fx_amt)" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Option Date -->
						<xsl:if test="option_date[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
										<xsl:value-of 
											select="localization:getGTPString($language, 'XSL_CONTRACT_FX_OPTION_DATE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
										<xsl:value-of select="option_date" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- value date -->
						<xsl:if test="value_date[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CONTRACT_FX_VALUE_DATE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="value_date" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="value_date_term_number[. != ''] or value_date_term_code[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CONTRACT_FX_VALUE_DATE_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="concat(value_date_term_number, ' ', localization:getDecode($language, 'N413', value_date_term_code[.]))" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Market order -->
						<xsl:if test="market_order[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CONTRACT_XO_MARKET_ORDER_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:choose>
										<xsl:when test="market_order[. = 'Y']">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_YES')" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_NO')" />
										</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Trigger position -->
						<xsl:if test="trigger_pos[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CONTRACT_XO_TRIGGER_POS_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="trigger_pos" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Trigger Stop -->
						<xsl:if test="trigger_stop[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CONTRACT_XO_TRIGGER_STOP_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="trigger_stop" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Trigger Limit -->
						<xsl:if test="trigger_limit[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_CONTRACT_XO_TRIGGER_LIMIT_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="trigger_limit" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
        		</xsl:when>
        		<!-- Cancel -->
        		<xsl:when test="sub_tnx_type_code[.='22']">
        			<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_ACTION_CANCEL_DETAILS')" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_CONTRACT_XO_CANCEL_REASON_LABEL')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="cancel_reason" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
					</xsl:call-template>
        		</xsl:when>
        		<!-- Confirm -->
        		<xsl:when test="sub_tnx_type_code[.='23']">
        			
        		</xsl:when>
        	</xsl:choose>
        </xsl:if>
        </xsl:if>
        
   	</xsl:template>
	<xsl:template match="lc_tnx_record | si_tnx_record " mode="discrepant">
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="title">
					<xsl:with-param name="text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_HEADER_DISCREPANT_DETAILS')" />
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="bo_release_dttm[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_DATE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of
								select="formatter:formatDttmToDate(bo_release_dttm,$language)" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="tnx_cur_code[.!='']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_DOCS_AMT_LABEL')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="tnx_cur_code" />&nbsp;
							<xsl:value-of select="tnx_amt" />
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
			</xsl:with-param>
		</xsl:call-template>
		<xsl:if test="bo_comment[.!='']">
			<fo:block start-indent="20.0pt" font-family="{$pdfFontData}"
				white-space-collapse="false">
				<fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt"
					space-before.conditionality="retain">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_COMMENT_BANK')" />
				</fo:block>
				<fo:block space-before.optimum="10.0pt"
					space-before.conditionality="retain">
					<xsl:value-of select="bo_comment" />
				</fo:block>
			</fo:block>
		</xsl:if>
		<xsl:if test="action_req_code[.!='']">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ACTION_REQUIRED')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of
								select="localization:getDecode($language, 'N042', action_req_code)" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="attachments/attachment[type = '02']">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FILES_ATTACHED')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:apply-templates select="attachments/attachment[type = '02']"
								mode="bank" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template name="amend_additional_amount">
		<xsl:param name="narrative_additional_amount" />
		<xsl:param name="org_narrative_additional_amount" />
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<!-- <fo:table-row>
					<fo:table-cell > <fo:block/> </fo:table-cell>
					<fo:table-cell > <fo:block/> </fo:table-cell>
				</fo:table-row> -->
				<xsl:if test="$org_narrative_additional_amount!=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_ORG_ADDITIONAL_AMT')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="$org_narrative_additional_amount" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_NEW_ADDITIONAL_AMT')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="$narrative_additional_amount" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="variation_drawing">
		<xsl:param name="pstv_tol_pct" />
		<xsl:param name="neg_tol_pct" />
		<xsl:param name="max_cr_desc_code" />
		<xsl:param name="org_pstv_tol_pct" />
		<xsl:param name="org_neg_tol_pct" />
		<xsl:param name="org_max_cr_desc_code" />
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<!-- Amend:  Variation in Drawing -->
				<xsl:choose>
				<xsl:when test="(pstv_tol_pct[.!=''] or neg_tol_pct[.!=''] or max_cr_desc_code[.!='']) and ($org_pstv_tol_pct!='' or $org_neg_tol_pct!='' or $org_max_cr_desc_code!='')">
				<xsl:call-template name="table_cell"/>
				<xsl:if test="$org_pstv_tol_pct!=''and ($pstv_tol_pct != $org_pstv_tol_pct)">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_ORG_TOL_LABEL')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="$org_pstv_tol_pct" />&nbsp;%
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$org_neg_tol_pct!='' and ($neg_tol_pct != $org_neg_tol_pct)">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:choose>
								<xsl:when test="$org_pstv_tol_pct=''">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_ORG_TOL_LABEL')" />
								</xsl:when>
								<xsl:otherwise>&nbsp;
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="$org_neg_tol_pct" />&nbsp;%
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$org_max_cr_desc_code!='' and ($max_cr_desc_code != $org_max_cr_desc_code)">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:choose>
								<xsl:when test="$org_pstv_tol_pct='' and $org_neg_tol_pct='' and $org_max_cr_desc_code!=''">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_ORG_TOL_LABEL')" />
								</xsl:when>
								<xsl:otherwise>&nbsp;
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="right_text">
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_LABEL')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="$org_max_cr_desc_code='3'">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_NOTEXCEEDING')" />
								</xsl:when>
								<xsl:otherwise />
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				</xsl:when>
				<xsl:otherwise>
				 <xsl:if test="$pstv_tol_pct!='' or $neg_tol_pct!='' or $max_cr_desc_code!=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_ORG_TOL_LABEL')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NO_ORG_TOL')" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="$pstv_tol_pct!='' or $neg_tol_pct!='' or $max_cr_desc_code!=''">
				<xsl:if test="$pstv_tol_pct!='' and ($pstv_tol_pct != $org_pstv_tol_pct)">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NEW_TOL_LABEL')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_PSTV')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="$pstv_tol_pct" />&nbsp;%
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$neg_tol_pct!='' and ($neg_tol_pct != $org_neg_tol_pct)">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:choose>
								<xsl:when test="$pstv_tol_pct='' or ($pstv_tol_pct = $org_pstv_tol_pct)">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NEW_TOL_LABEL')" />
								</xsl:when>
								<xsl:otherwise>&nbsp;
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_NEG')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="$neg_tol_pct" />&nbsp;%
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$max_cr_desc_code!='' and ($max_cr_desc_code != $org_max_cr_desc_code)">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:choose>
								<xsl:when test="$pstv_tol_pct='' and $neg_tol_pct='' and $max_cr_desc_code!=''">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_NEW_TOL_LABEL')" />
								</xsl:when>
								<xsl:otherwise>&nbsp;
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="right_text">
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_LABEL')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
								<xsl:when test="$max_cr_desc_code='3'">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_NOTEXCEEDING')" />
								</xsl:when>
								<xsl:otherwise />
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				</xsl:when>
				<xsl:otherwise>
				<!-- MPS-40578 07-08-17 -->
				<xsl:if test="$pstv_tol_pct='' and $neg_tol_pct='' and $max_cr_desc_code=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
						</xsl:with-param>
						<xsl:with-param name="right_text">
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="amend_shipment_details">
		<xsl:param name="ship_from" />
		<xsl:param name="org_ship_from" />
		<!-- SWIFT 2006 -->
		<xsl:param name="ship_loading" />
		<xsl:param name="org_ship_loading" />
		<xsl:param name="ship_discharge" />
		<xsl:param name="org_ship_discharge" />
		<!-- SWIFT 2006 -->
		<xsl:param name="ship_to" />
		<xsl:param name="org_ship_to" />
		<xsl:param name="last_ship_date" />
		<xsl:param name="org_last_ship_date" />
		<xsl:param name="narrative_shipment_period" />
		<xsl:param name="org_narrative_shipment_period" />
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="title">
					<xsl:with-param name="text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_HEADER_AMENDED_SHIPMENT_DETAILS')" />
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="$ship_from!='' and $ship_from!=$org_ship_from">
					<xsl:if test="$org_ship_from!=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_ORG_SHIP_FROM')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="$org_ship_from" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NEW_SHIP_FROM')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="$ship_from" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<!-- SWIFT 2006 -->
				<xsl:if test="$ship_loading!='' and $ship_loading!=$org_ship_loading">
					<xsl:if test="$org_ship_loading!=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_ORG_SHIP_LOADING')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="$org_ship_loading" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NEW_SHIP_LOADING')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="$ship_loading" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$ship_discharge!='' and $ship_discharge!=$org_ship_discharge">
					<xsl:if test="$org_ship_discharge!=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_ORG_SHIP_DISCHARGE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="$org_ship_discharge" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NEW_SHIP_DISCHARGE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="$ship_discharge" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<!-- SWIFT 2006 -->
				<xsl:if test="$ship_to!='' and $ship_to!=$org_ship_to">
					<xsl:if test="$org_ship_to!=''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_ORG_SHIP_TO')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="$org_ship_to" />
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NEW_SHIP_TO')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="$ship_to" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if
					test="narrative_shipment_period!=$org_narrative_shipment_period or last_ship_date!=$org_last_ship_date">
					<xsl:if test="$org_last_ship_date!=''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_ORG_LAST_SHIP_DATE')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="$org_last_ship_date" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="$org_narrative_shipment_period!=''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_ORG_SHIPMENT_PERIOD')" />
								</xsl:with-param>
							<xsl:with-param name="right_text">
									<xsl:value-of select="$org_narrative_shipment_period" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="$last_ship_date!=''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_SHIPMENTDETAILS_NEW_LAST_SHIP_DATE')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="$last_ship_date" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="$narrative_shipment_period!=''">
						<!-- <fo:table-row>
							<fo:table-cell />
							<fo:table-cell />
						</fo:table-row> -->
						<fo:table-row>
							<fo:table-cell number-columns-spanned="2">
								<fo:block font-family="{$pdfFont}"
									space-before.optimum="10.0pt" space-before.conditionality="retain"
									start-indent="20.0pt">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_NEW_SHIPMENT_PERIOD')" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell number-columns-spanned="2">
								<fo:block space-before.optimum="5.0pt"
									space-before.conditionality="retain" white-space-collapse="false"
									start-indent="20.0pt">
									<xsl:value-of select="$narrative_shipment_period" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- Charge template -->
	<xsl:template name="CHARGE">
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:if test="chrg_code != ''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_CHARGE_HEADER_CHARGE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
							<xsl:when test="chrg_code[.='ISSFEE']">
								<xsl:value-of 
								   select="localization:getGTPString($language, 'XSL_CHARGE_CODE_ISSFEE')"/>
								</xsl:when>
				
							<xsl:when test="chrg_code[.='COMMISSION']">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_CHARGE_CODE_COMMISSION')" />
							</xsl:when>
							<xsl:when test="chrg_code[.='OTHER']">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_CHARGE_CODE_OTHER')" />
							</xsl:when>
						<xsl:otherwise />						
		                </xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="additional_comment != ''">
					<xsl:call-template name="table_cell_1">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_CHARGE_DESCRIPTION')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="additional_comment" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="chrg_type != ''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_CHARGE_TYPE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:choose>
	   							<xsl:when test="chrg_type[.='C']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_TYPE_CREDIT')"/></xsl:when>
	   							<xsl:when test="chrg_type[.='D']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_TYPE_DEBIT')"/></xsl:when>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_CHARGE_AMOUNT')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="cur_code" />&nbsp;<xsl:value-of select="amt" />
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="exchange_rate != ''">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_CHARGE_EXCH_RATE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="exchange_rate" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

				<xsl:if test="eqv_cur_code != '' and product_code != 'SG' " >
                    <xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_CHARGE_EQV_AMOUNT')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="eqv_cur_code" />&nbsp;<xsl:value-of select="eqv_amt" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_CHARGE_STATUS')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="localization:getDecode($language, 'N057', status[.])"/>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="status[. = '01'] and settlement_date[. != '']">
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_CHARGE_SETTLEMENT_DATE')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="settlement_date" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- TD Details -->
	<xsl:template name="td-commondetails">
		<!--<xsl:if test="tnx_type_code[.='03'] or tnx_type_code[.='13']">
			<xsl:if test="placement_act_name[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'TD_TERM_DEPOSIT_ACCOUNT')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="placement_act_name" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
	    </xsl:if>
		--><!-- Tenor -->
	    <xsl:if test="value_date_term_code[. != '']">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TENOR')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
					  <xsl:value-of select="value_date_term_number"/>&nbsp;<xsl:value-of select="localization:getDecode($language, 'N413', value_date_term_code)"/>
					</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<!-- Interest Rate PA -->
		<xsl:if test="interest[.!='']">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_TD_INTEREST_RATE_PA')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="interest" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<!-- Maturity Date -->
		<xsl:if test="(tnx_type_code[.='03'] or tnx_type_code[.='13']) and maturity_date[.!='']">
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
		<!-- Outstanding Amount -->
		<xsl:if test="(tnx_type_code[.='03'] or tnx_type_code[.='13']) and td_liab_amt[.!=''] and td_cur_code[. != '']">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_AMT_LABEL')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="liab_total_amt"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="tnx_type_code[.='13']">	
			<!-- Accured Interest -->
			<xsl:if test="accured_interest[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_ACCURED_INTEREST')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="accured_interest" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!-- Premature Withdrawl -->
			<xsl:if test="premature_withdrawal_penalty[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_PREMATURE_WITHDRAWAL_PENALTY')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="premature_withdrawal_penalty" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!--Withholding Tax  -->
			<xsl:if test="withholding_tax[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_WITHHOLDING_TAX')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="withholding_tax" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!--HoldMail Charges-->
			<xsl:if test="hold_mail_charges[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HOLD_MAIL_CHARGES')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="hold_mail_charges" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!--Annual Postage Fee-->
			<xsl:if test="annual_postage_fee[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_ANNUAL_POSTAGE_FEE')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="annual_postage_fee" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!--Annual Postage Fee-->
			<xsl:if test="withdrawable_interest[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_WITHDRAWABLE_INTEREST')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="withdrawable_interest" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!--Net Settlement Amount-->
			<xsl:if test="net_settlement_amount[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_NET_SETTLEMENT_AMOUNT')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="net_settlement_amount" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
		<!--Original Maturity Instruction  -->
		<xsl:if test="tnx_type_code[.='03'] and maturity_instruction_code[.!='']">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_TD_CURRENT_MATURITY_INSTRUCTIONS')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
				      <xsl:choose>
				      <xsl:when test="org_previous_file/td_tnx_record/maturity_instruction_code[.!='']"><xsl:value-of select="org_previous_file/td_tnx_record/maturity_instruction_name"/></xsl:when>
				      <!--
				       <xsl:when test="org_previous_file/td_tnx_record/maturity_instruction[.='01']">Auto renwal of principal and interest</xsl:when>
				       <xsl:when test="org_previous_file/td_tnx_record/maturity_instruction[.='02']">Auto renwal of principal and credit interest</xsl:when>
				      --></xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="td-maturityandcreditdetails">
		 <xsl:if test="(tnx_type_code[.='01'] or tnx_type_code[.='03']) and maturity_instruction_code[. != '']">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:choose>
					<xsl:when test="tnx_type_code[.='01']"><xsl:value-of	
						select="localization:getGTPString($language, 'XSL_TD_MATURITY_INSTRUCTIONS')"/></xsl:when>
					<xsl:when test="tnx_type_code[.='03']"><xsl:value-of	
						select="localization:getGTPString($language, 'XSL_TD_MODIFY_MATURITY_INSTRUCTIONS')"/></xsl:when>
				   </xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="right_text">
					<xsl:choose>
					<xsl:when test="maturity_instruction_code[.!='']"><xsl:value-of select="maturity_instruction_name"/></xsl:when>
					</xsl:choose>
					</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<!-- Credit Account -->
		<xsl:if test="credit_act_name[.!='']">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:choose>
					<xsl:when test="tnx_type_code[.='01']"><xsl:value-of	
						select="localization:getGTPString($language, 'XSL_TD_CREDIT_ACCOUNT')"/></xsl:when>
					<xsl:when test="tnx_type_code[.='03']"><xsl:value-of	
						select="localization:getGTPString($language, 'XSL_TD_CREDIT_INTEREST_TO_ACCOUNT')"/></xsl:when>
					<xsl:when test="tnx_type_code[.='13']"><xsl:value-of	
						select="localization:getGTPString($language, 'XSL_NET_SETTLEMENT_AMT_CREDIT_TO')"/></xsl:when>
					</xsl:choose>
					</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="credit_act_name" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="fx-common-details">
		<xsl:if test="fx_rates_type[.!=''] and (fx_nbr_contracts[. > '0'] or fx_exchange_rate[.!=''])">
			<fo:block id="fxdetails" />
	<!--  Show only when Fx exchange rates or contracts are present -->
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
								select="localization:getGTPString($language, 'XSL_FX_RATES')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:if test="fx_rates_type[. = '01'] and fx_exchange_rate[.!='']">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_BOARD_RATES')" />
							</xsl:if>
						   <xsl:if test="fx_rates_type[. = '02'] and fx_nbr_contracts[. > '0']">
						    <xsl:value-of select="localization:getGTPString($language, 'XSL_FX_CONTRACTS')" />
						   </xsl:if>	
						</xsl:with-param>
					</xsl:call-template>
					</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="fx_rates_type[. = '01']">
			   <xsl:if test="fx_exchange_rate[.!='']">
					<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
						<!-- <fo:table-column column-width="{$pdfTableWidth}" />-->
						<fo:table-column column-width="25%" />
						<fo:table-column column-width="20%" />
						<fo:table-column column-width="1%" />
						<fo:table-column column-width="25%" />
						<fo:table-column column-width="9%" />
						<fo:table-column column-width="20%" />
						<fo:table-body>
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"
										space-before.conditionality="retain" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_EXCHANGE_RATE')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"
										space-before.conditionality="retain" start-indent="20.0pt">
										<xsl:value-of select="fx_exchange_rate" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"
										space-before.conditionality="retain" start-indent="20.0pt">
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"
										space-before.conditionality="retain" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_EQUIVALENT_AMT')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"
										space-before.conditionality="retain" start-indent="20.0pt">
										<xsl:value-of select="fx_exchange_rate_cur_code" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"
										space-before.conditionality="retain" start-indent="20.0pt">
										<xsl:value-of select="fx_exchange_rate_amt" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
					</xsl:if>
					<xsl:if test="fx_tolerance_rate[.!='']">
					<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
						<!-- <fo:table-column column-width="{$pdfTableWidth}" />-->
						<fo:table-column column-width="25%" />
						<fo:table-column column-width="20%" />
						<fo:table-column column-width="1%" />
						<fo:table-column column-width="25%" />
						<fo:table-column column-width="9%" />
						<fo:table-column column-width="20%" />
						<fo:table-body>
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"
										space-before.conditionality="retain" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_TOLERANCE_RATE')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"
										space-before.conditionality="retain" start-indent="20.0pt">
										<xsl:value-of select="fx_tolerance_rate" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"
										space-before.conditionality="retain" start-indent="20.0pt">
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"
										space-before.conditionality="retain" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_EQUIVALENT_AMT')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"
										space-before.conditionality="retain" start-indent="20.0pt">
										<xsl:value-of select="fx_tolerance_rate_cur_code" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"
										space-before.conditionality="retain" start-indent="20.0pt">
										<xsl:value-of select="fx_tolerance_rate_amt" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
					</xsl:if>
					<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
						<fo:table-column column-width="100%" />
						<fo:table-body>
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block space-before.optimum="10.0pt"
										space-before.conditionality="retain" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_BOARD_RATE_LABEL')" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</xsl:if>
				<!-- Contracts Details -->
				<xsl:if test="fx_rates_type[. = '02']">
					<xsl:call-template name="nbr-of-fx-contracts-">
					     <xsl:with-param name="i">1</xsl:with-param>
					     <xsl:with-param name="count"><xsl:value-of select="fx_nbr_contracts"/></xsl:with-param>
					</xsl:call-template>     
				     <xsl:if test="fx_nbr_contracts[. > '0']">
				    <fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
					<fo:table-column column-width="49%" />
					<fo:table-column column-width="1%" />
					<fo:table-column column-width="20%" />
					<fo:table-column column-width="10%" />
					<fo:table-column column-width="20%" />
					<fo:table-body>
						<fo:table-row keep-with-previous="always">
							<fo:table-cell>
								<fo:block space-before.optimum="10.0pt"
									space-before.conditionality="retain" start-indent="20.0pt">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_CONTRACT_LABEL')" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block space-before.optimum="10.0pt"
									space-before.conditionality="retain" start-indent="20.0pt">
								</fo:block>
							</fo:table-cell>
							<xsl:if test="fx_total_utilise_amt[.!=''] and product_code[.!='TD']">
							<fo:table-cell>
								<fo:block space-before.optimum="10.0pt"
									space-before.conditionality="retain" start-indent="20.0pt">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_TOTAL_AMT_TO_UTILISE')" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block space-before.optimum="10.0pt"
									space-before.conditionality="retain" start-indent="20.0pt">
									<xsl:value-of select="fx_total_utilise_cur_code" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block space-before.optimum="10.0pt"
									space-before.conditionality="retain" start-indent="20.0pt">
									<xsl:value-of select="fx_total_utilise_amt" />
								</fo:block>
							</fo:table-cell>
							</xsl:if>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
				     </xsl:if>
				</xsl:if>		
		</xsl:if>
	</xsl:template>
		
	<xsl:template name="nbr-of-fx-contracts-">
	   <xsl:param name="i"/>
	   <xsl:param name="count"/>
	   <xsl:if test="$i &lt;= $count">
		   <xsl:variable name="row"><xsl:value-of select="$i" /></xsl:variable>
	       <xsl:call-template name="fx-contract-nbr-fields">
	       		<xsl:with-param name="row"><xsl:value-of select="$i" /></xsl:with-param>
	       </xsl:call-template>
	   </xsl:if>
	   <xsl:if test="$i &lt;= $count">
	      <xsl:call-template name="nbr-of-fx-contracts-">
	          <xsl:with-param name="i">
	              <xsl:value-of select="$i + 1"/>
	          </xsl:with-param>
	          <xsl:with-param name="count">
	              <xsl:value-of select="$count"/>
	          </xsl:with-param>
	      </xsl:call-template>
	   </xsl:if>
	</xsl:template>
	
	<xsl:template name="fx-contract-nbr-fields">
    	<xsl:param name="row" />
	    <xsl:if test="//*[starts-with(name(), concat('fx_contract_nbr_', $row))]">
			<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
				<!-- <fo:table-column column-width="{$pdfTableWidth}" />-->
				<fo:table-column column-width="25%" />
				<fo:table-column column-width="20%" />
				<fo:table-column column-width="1%" />
				<fo:table-column column-width="25%" />
				<fo:table-column column-width="9%" />
				<fo:table-column column-width="20%" />
				<fo:table-body>
					<fo:table-row keep-with-previous="always">
						<fo:table-cell>
							<fo:block space-before.optimum="10.0pt"
								space-before.conditionality="retain" start-indent="20.0pt">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_CONTRACT_NBR')" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block space-before.optimum="10.0pt"
								space-before.conditionality="retain" start-indent="20.0pt">
								<xsl:value-of select="//*[starts-with(name(), concat('fx_contract_nbr_', $row))]"></xsl:value-of>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block space-before.optimum="10.0pt"
								space-before.conditionality="retain" start-indent="20.0pt">
							</fo:block>
						</fo:table-cell>
						<xsl:if test="//*[starts-with(name(), concat('fx_contract_nbr_amt_', $row))][.!='']">
						<fo:table-cell>
							<fo:block space-before.optimum="10.0pt"
								space-before.conditionality="retain" start-indent="20.0pt">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_EQUIVALENT_AMT')" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block space-before.optimum="10.0pt"
								space-before.conditionality="retain" start-indent="20.0pt">
								<xsl:value-of select="//*[starts-with(name(), concat('fx_contract_nbr_cur_code_', $row))]"></xsl:value-of>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block space-before.optimum="10.0pt"
								space-before.conditionality="retain" start-indent="20.0pt">
								<xsl:value-of select="//*[starts-with(name(), concat('fx_contract_nbr_amt_', $row))]"></xsl:value-of>
							</fo:block>
						</fo:table-cell>
						</xsl:if>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</xsl:if>
	</xsl:template>
	<xsl:template name="beneficiary-advice">
		<xsl:if test="bene_adv_flag[.='Y']">	
		<fo:block id="beneAdvicedetails" />
		<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_ADVICE_DETAILS')" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DESTINATION_DETAILS')" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
		</xsl:call-template>
		<fo:block white-space-collapse="false">
			<fo:table>
				<fo:table-column column-width="100%"/>
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell padding-bottom="2.5pt">
							<xsl:choose>
								<xsl:when test="$rtlwriting">
									<xsl:attribute name="padding-right">10pt</xsl:attribute>
									<xsl:attribute name="margin-right">50pt</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="padding-left">10pt</xsl:attribute>
									<xsl:attribute name="margin-left">50pt</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
							<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE')" /></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
			<fo:table>
				<fo:table-column column-width="90%" />
				<fo:table-column column-width="10%" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell padding-bottom="2.5pt">
							<xsl:choose>
								<xsl:when test="$rtlwriting">
									<xsl:attribute name="padding-right">10pt</xsl:attribute>
									<xsl:attribute name="margin-right">150pt</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="padding-left">10pt</xsl:attribute>
									<xsl:attribute name="margin-left">150pt</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
							<fo:table>
								<fo:table-column column-width="40%" />
								<fo:table-column column-width="60%" />
								<fo:table-body start-indent="2pt">
									<fo:table-row>
								           <fo:table-cell>
								            <fo:block>&nbsp;</fo:block>            
								           </fo:table-cell>
								           <fo:table-cell>
								            <fo:block>&nbsp;</fo:block>
								           </fo:table-cell>
								    </fo:table-row>
									<xsl:if test="bene_adv_email_flag = 'Y' and ( bene_adv_email_1 !='' or bene_adv_email_21 !='' or bene_adv_email_22 !='')">
										<fo:table-row>
											<fo:table-cell>
												<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_EMAIL')" /></fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block><xsl:value-of select="bene_adv_email_1"/></fo:block>	
											</fo:table-cell>
									    </fo:table-row>
									</xsl:if>
									<xsl:if test="bene_adv_email_flag = 'Y' and bene_adv_email_21 !=''">
										<fo:table-row>
											<fo:table-cell>
												<fo:block></fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block><xsl:value-of select="bene_adv_email_21"/></fo:block>	
											</fo:table-cell>
									    </fo:table-row>
									</xsl:if>
									<xsl:if test="bene_adv_email_flag = 'Y' and bene_adv_email_22 !=''">
										<fo:table-row>
											<fo:table-cell>
												<fo:block></fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block><xsl:value-of select="bene_adv_email_22"/></fo:block>	
											</fo:table-cell>
									    </fo:table-row>
									</xsl:if>
									<xsl:if test="bene_adv_phone_flag = 'Y'">
										<fo:table-row>
											<fo:table-cell>
												<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_PHONE')" /></fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block><xsl:value-of select="bene_adv_phone"/></fo:block>	
											</fo:table-cell>
									    </fo:table-row>
									</xsl:if>
									<xsl:if test="bene_adv_fax_flag = 'Y'">
										<fo:table-row>
											<fo:table-cell>
												<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_FAX')" /></fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block><xsl:value-of select="bene_adv_fax"/></fo:block>	
											</fo:table-cell>
									    </fo:table-row>
									</xsl:if>
									<xsl:if test="bene_adv_ivr_flag = 'Y'">
										<fo:table-row>
											<fo:table-cell>
												<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_IVR')" /></fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block><xsl:value-of select="bene_adv_ivr"/></fo:block>	
											</fo:table-cell>
									    </fo:table-row>
									</xsl:if>
									<xsl:if test="bene_adv_print_flag = 'Y'">
										<fo:table-row>
											<fo:table-cell>
												<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_PRINT')" /></fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>Yes</fo:block>	
											</fo:table-cell>
									    </fo:table-row>
									</xsl:if>
									<xsl:if test="bene_adv_mail_flag = 'Y'">
										<fo:table-row>
											<fo:table-cell>
												<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_MAIL')" /></fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>Yes</fo:block>	
											</fo:table-cell>
									    </fo:table-row>
									</xsl:if>
									<xsl:if test="bene_adv_mail_flag = 'Y'">
										<fo:table-row>
											<fo:table-cell>
												<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_MAILING_NAME_ADDRESS')" /></fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block><xsl:value-of select="bene_adv_mailing_name_add_1"/></fo:block>	
											</fo:table-cell>
									    </fo:table-row>
									    <xsl:if test="bene_adv_mailing_name_add_2 != ''">
										    <fo:table-row>
												<fo:table-cell>
													<fo:block>&nbsp;</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block><xsl:value-of select="bene_adv_mailing_name_add_2"/></fo:block>	
												</fo:table-cell>
										    </fo:table-row>
										</xsl:if>
									    <xsl:if test="bene_adv_mailing_name_add_3 != ''">
										    <fo:table-row>
												<fo:table-cell>
													<fo:block>&nbsp;</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block><xsl:value-of select="bene_adv_mailing_name_add_3"/></fo:block>	
												</fo:table-cell>
										    </fo:table-row>
										</xsl:if>
									    <xsl:if test="bene_adv_mailing_name_add_4 != ''">
										    <fo:table-row>
												<fo:table-cell>
													<fo:block>&nbsp;</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block><xsl:value-of select="bene_adv_mailing_name_add_4"/></fo:block>	
												</fo:table-cell>
										    </fo:table-row>
										</xsl:if>
									    <xsl:if test="bene_adv_mailing_name_add_5 != ''">
										    <fo:table-row>
												<fo:table-cell>
													<fo:block>&nbsp;</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block><xsl:value-of select="bene_adv_mailing_name_add_5"/></fo:block>	
												</fo:table-cell>
										    </fo:table-row>
										</xsl:if>
									    <xsl:if test="bene_adv_mailing_name_add_6 != ''">
										    <fo:table-row>
												<fo:table-cell>
													<fo:block>&nbsp;</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block><xsl:value-of select="bene_adv_mailing_name_add_6"/></fo:block>	
												</fo:table-cell>
										    </fo:table-row>
										</xsl:if>
										<xsl:if test="bene_adv_country != ''">
										    <fo:table-row>
												<fo:table-cell>
													<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_COUNTRY')" /></fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block><xsl:value-of select="bene_adv_country"/></fo:block>
												</fo:table-cell>
										    </fo:table-row>
									    </xsl:if>
									    <xsl:if test="bene_adv_postal_code != ''">
										    <fo:table-row>
												<fo:table-cell>
													<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_POSTAL_CODE')" /></fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block><xsl:value-of select="bene_adv_postal_code"/></fo:block>
												</fo:table-cell>
										    </fo:table-row>
									    </xsl:if>
									</xsl:if>
								</fo:table-body>
							</fo:table>
						</fo:table-cell>
						<fo:table-cell padding-bottom="2.5pt">
							<xsl:choose>
								<xsl:when test="$rtlwriting">
									<xsl:attribute name="padding-right">10pt</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="padding-left">10pt</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>						
							<fo:block>&nbsp;</fo:block>	
						</fo:table-cell>				               
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
		<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_BENE_ADVICE_ADV_CONTENT')" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
		</xsl:call-template>
		<fo:block white-space-collapse="false">
			<fo:table>
				<fo:table-column column-width="90%" />
				<fo:table-column column-width="10%" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell padding-bottom="2.5pt">
							<xsl:choose>
								<xsl:when test="$rtlwriting">
									<xsl:attribute name="padding-right">10pt</xsl:attribute>
									<xsl:attribute name="margin-right">150pt</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="padding-left">10pt</xsl:attribute>
									<xsl:attribute name="margin-left">150pt</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
							<fo:table>
								<fo:table-column column-width="40%" />
								<fo:table-column column-width="60%" />
								<fo:table-body start-indent="2pt">
									<fo:table-row>
								           <fo:table-cell>
								            <fo:block>&nbsp;</fo:block>            
								           </fo:table-cell>
								           <fo:table-cell>
								            <fo:block>&nbsp;</fo:block>
								           </fo:table-cell>
								    </fo:table-row>
									<xsl:if test="bene_adv_beneficiary_id != ''">
										<fo:table-row>
											<fo:table-cell>
												<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_BENEFICIARY_ID')" /></fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block><xsl:value-of select="bene_adv_beneficiary_id"/></fo:block>	
											</fo:table-cell>
									    </fo:table-row>
									</xsl:if>
									<xsl:if test="bene_adv_payer_name_1 != '' or bene_adv_payer_name_2 != ''">
										<fo:table-row>
											<fo:table-cell>
												<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_PAYER_NAME')" /></fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block><xsl:value-of select="bene_adv_payer_name_1"/></fo:block>	
											</fo:table-cell>
									    </fo:table-row>
									</xsl:if>
									<xsl:if test="bene_adv_payer_name_2 != ''">
										<fo:table-row>
											<fo:table-cell>
												<fo:block></fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block><xsl:value-of select="bene_adv_payer_name_2"/></fo:block>	
											</fo:table-cell>
									    </fo:table-row>
									</xsl:if>
									<xsl:if test="bene_adv_payer_ref_no != ''">
										<fo:table-row>
											<fo:table-cell>
												<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_PAYER_REF_NO')" /></fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block><xsl:value-of select="bene_adv_payer_ref_no"/></fo:block>	
											</fo:table-cell>
									    </fo:table-row>
									</xsl:if>
									<xsl:if test="bene_adv_free_format_msg != ''">
										<fo:table-row>
											<fo:table-cell>
												<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_FREE_FORMAT_MSG')" /></fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block><xsl:value-of select="bene_adv_free_format_msg"/></fo:block>	
											</fo:table-cell>
									    </fo:table-row>
									</xsl:if>
									<xsl:if test="bene_adv_table_format != ''">
										<fo:table-row>
											<fo:table-cell>
												<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_TABLE_FORMAT')" /></fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block><xsl:value-of select="bene_adv_table_format"/></fo:block>	
											</fo:table-cell>
									    </fo:table-row>
									</xsl:if>
								</fo:table-body>
							</fo:table>
						</fo:table-cell>
						<fo:table-cell padding-bottom="2.5pt">
							<xsl:choose>
								<xsl:when test="$rtlwriting">
									<xsl:attribute name="padding-right">10pt</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="padding-left">10pt</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>						
							<fo:block>&nbsp;</fo:block>	
						</fo:table-cell>				               
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
		<xsl:if test="bene_adv_table_format != '' and (count(bene_advice_table_data_pdf/array) > 0)">	
			<fo:block xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider" white-space-collapse="false">
				<fo:table>
					<xsl:variable name="width"><xsl:value-of select="100 div count(bene_advice_table_format_pdf/table)"/>%</xsl:variable>
					<xsl:for-each select="bene_advice_table_format_pdf/table">
						<fo:table-column>
							<xsl:attribute name="column-width"><xsl:value-of select="$width"/></xsl:attribute>
						</fo:table-column>
					</xsl:for-each>
					<fo:table-header>
					  <fo:table-row>
					  	<xsl:if test="1 > count(bene_advice_table_format_pdf/table)">
						  	<fo:table-cell>
						      	<fo:block>&nbsp;</fo:block>
						    </fo:table-cell>
						</xsl:if>
					  	<xsl:for-each select="bene_advice_table_format_pdf/table">
					  		<fo:table-cell>
						      	<fo:block margin="1pt" font-weight="bold" background-color="#7692B7" text-align="center" color="white">
						      		<xsl:value-of select="./column_label"></xsl:value-of>
						      	</fo:block>
						    </fo:table-cell>
					  	</xsl:for-each>
					  </fo:table-row>
					</fo:table-header>
					<fo:table-body>
						<xsl:if test="1 > count(bene_advice_table_data_pdf/array)">
							<fo:table-row>
						  		<fo:table-cell>
							      	<fo:block>&nbsp;</fo:block>
							    </fo:table-cell>
						  	</fo:table-row>
						</xsl:if>
						<xsl:for-each select="bene_advice_table_data_pdf/array">
							<xsl:variable name="position" select="position()"/>
							<xsl:variable name="parentData" select="."/>
							<fo:table-row>
								<xsl:for-each select="../../bene_advice_table_format_pdf/table">
									<xsl:variable name="column-name"><xsl:value-of select="translate(./column_label, '&#x20;&#x9;&#xD;&#xA;', '')"/></xsl:variable>
									<xsl:variable name="alignment"><xsl:value-of select="./column_alignment"/></xsl:variable>
									<fo:table-cell>
										<fo:block margin="1pt">
								      		<xsl:attribute name="background-color">
								      			<xsl:choose>
								      				<xsl:when test="$position mod 2 = 1">#CBE3FF</xsl:when>
								      				<xsl:otherwise>#F0F7FF</xsl:otherwise>
								      			</xsl:choose>
								      		</xsl:attribute>
								      		<xsl:attribute name="text-align">
								      			<xsl:value-of select="$alignment"/>	
								      		</xsl:attribute>
								      		<xsl:value-of select="$parentData/*[name() = $column-name]"/> 
								      	</fo:block>
						      		</fo:table-cell>
							    </xsl:for-each>
							</fo:table-row>
						</xsl:for-each>
					</fo:table-body>
				</fo:table>
			</fo:block>	
		</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="beneficiary-amendment-details">
         <xsl:if test="product_code[.='BG']  and beneficiary_name[.!=''] and (beneficiary_name != org_previous_file/bg_tnx_record/beneficiary_name)">
           		<!--Beneficiary Details-->
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="beneficiary_name" />
							</xsl:with-param>
						</xsl:call-template>
						<!-- Adress -->
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="beneficiary_address_line_1" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="beneficiary_address_line_2[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="beneficiary_address_line_2" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="beneficiary_dom[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="beneficiary_dom" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="beneficiary_address_line_4[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="beneficiary_address_line_4" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>

						<xsl:if test="beneficiary_country[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="beneficiary_country" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="beneficiary_reference[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="beneficiary_reference" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
        
          <xsl:if test="product_code[.='SI'] and beneficiary_name[.!=''] and (beneficiary_name != org_previous_file/si_tnx_record/beneficiary_name)">
           <!--Beneficiary Details-->
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="subtitle">
							<xsl:with-param name="text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="beneficiary_name" />
							</xsl:with-param>
						</xsl:call-template>
						<!-- Adress -->
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="beneficiary_address_line_1" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="beneficiary_address_line_2[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="beneficiary_address_line_2" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="beneficiary_dom[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="beneficiary_dom" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="beneficiary_address_line_4[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="beneficiary_address_line_4" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>

						<xsl:if test="beneficiary_country[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CONTRY')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="beneficiary_country" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="beneficiary_reference[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="beneficiary_reference" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

	</xsl:template>
	<xsl:template name="renewal-amend-details">
		<!--Renewal Details-->
			<xsl:if test="renew_flag[. = 'Y']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:if test="//product_code[.='SI']">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_DETAILS_LABEL')"/>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_RENEWAL_RENEW_ON')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="renew_on_code[.= '01']">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')" />
									</xsl:when>
									<xsl:when test="renew_on_code[.= '02']">
										<xsl:value-of select="renewal_calendar_date" />
									</xsl:when>
									<xsl:otherwise />
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_RENEWAL_RENEW_FOR')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="renew_for_nb" />&nbsp;<xsl:value-of select="localization:getDecode($language, 'N074', renew_for_period)" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="advise_renewal_flag[. = 'Y']">
							<xsl:choose>
								<xsl:when test="//product_code[.='SI']">
									<xsl:call-template name="subtitle">
									<xsl:with-param name="text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_ADVISE_FO')"/>
									</xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_RENEWAL_DAYS_NOTICE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="advise_renewal_days_nb" />
									</xsl:with-param>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_RENEWAL_ADVISE_FO')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="advise_renewal_days_nb" />&nbsp;<xsl:value-of	select="localization:getGTPString($language, 'XSL_RENEWAL_DAYS_NOTICE_FO')" />
									</xsl:with-param>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>

						<xsl:if test="rolling_renewal_flag[. = 'Y']">
							<xsl:choose>
								<xsl:when test="//product_code[.='SI']">
									<xsl:call-template name="subtitle">
									<xsl:with-param name="text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_ROLLING_RENEWAL_FO')"/>
									</xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_RENEWAL_RENEW_ON')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:choose>
												<xsl:when test="rolling_renew_on_code[.= '01']">
													<xsl:value-of
													select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')" />
												</xsl:when>
												<xsl:when test="rolling_renew_on_code[.= '03']">
													<xsl:value-of
													select="localization:getGTPString($language, 'XSL_RENEWAL_EVERY')" />
												</xsl:when>
										</xsl:choose>
									</xsl:with-param>
									</xsl:call-template>
								<xsl:if test="rolling_renew_for_nb[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of select="localization:getGTPString($language, 'FREQUENCY_LABEL')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="rolling_renew_for_nb" />&nbsp;<xsl:value-of select="localization:getDecode($language, 'N074', rolling_renew_for_period)" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="rolling_day_in_month[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_ROLLING_DAY_IN_MONTH')" />
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of select="rolling_day_in_month" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_NUMBER_RENEWALS')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="rolling_renewal_nb" />
									</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CANCELLATION_NOTICE')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of select="rolling_cancellation_days" />
									</xsl:with-param>
								</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_RENEWAL_ROLLING_RENEWAL_FO')" />
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_RENEWAL_RENEW_ON')" />&nbsp;<xsl:choose>
												<xsl:when test="rolling_renew_on_code[.= '01']">
													<xsl:value-of
													select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')" />
												</xsl:when>
												<xsl:when test="rolling_renew_on_code[.= '03']">
													<xsl:value-of
													select="localization:getGTPString($language, 'XSL_RENEWAL_EVERY')" />
												</xsl:when>
											</xsl:choose>
									</xsl:with-param>
									</xsl:call-template>
								<xsl:if test="rolling_renew_for_nb[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'FREQUENCY_LABEL')" />&nbsp;<xsl:value-of select="rolling_renew_for_nb" />&nbsp;<xsl:value-of select="localization:getDecode($language, 'N074', rolling_renew_for_period)" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="rolling_day_in_month[.!='']">
									<xsl:call-template name="table_cell">
										<xsl:with-param name="left_text">
										</xsl:with-param>
										<xsl:with-param name="right_text">
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_ROLLING_DAY_IN_MONTH')" />&nbsp;<xsl:value-of select="rolling_day_in_month" />
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_RENEWAL_NUMBER_RENEWALS')" />&nbsp;<xsl:value-of select="rolling_renewal_nb" />
									</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="table_cell">
									<xsl:with-param name="left_text">
									</xsl:with-param>
									<xsl:with-param name="right_text">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_RENEWAL_CANCELLATION_NOTICE')" />&nbsp;<xsl:value-of select="rolling_cancellation_days" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
							</xsl:choose>

						</xsl:if>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_RENEWAL_AMOUNT')" />
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of
									select="localization:getDecode($language, 'N075', renew_amt_code)" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="projected_expiry_date[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_RENEWAL_PROJECTED_EXPIRY_DATE')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="projected_expiry_date" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="final_expiry_date[. != '']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_RENEWAL_FINAL_EXPIRY_DATE')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="final_expiry_date" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
	</xsl:template>
	
</xsl:stylesheet>