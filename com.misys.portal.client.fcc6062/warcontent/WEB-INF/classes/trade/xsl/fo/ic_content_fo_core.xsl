<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<!--
		Copyright (c) 2006-2012 Misys ,
		All	Rights Reserved.
	-->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" 
				xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
				xmlns:security="xalan://com.misys.portal.security.GTPSecurity" 
				xmlns:fo="http://www.w3.org/1999/XSL/Format"
			    xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
			    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
			    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	<xsl:include href="../../core/xsl/common/ls_common.xsl" />
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>
	<xsl:variable name="background">
		BLACK
	</xsl:variable>
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>

	<xsl:template match="ic_tnx_record">
		<!-- HEADER-->
		
		<!-- FOOTER-->
		
		<!-- BODY-->
		
	<xsl:call-template name="header"/>
    <xsl:call-template name="footer"/>
    <xsl:call-template name="body"/>
  </xsl:template>
<xsl:template name="header">
    <fo:static-content flow-name="xsl-region-before">
			<xsl:call-template name="header_presenting_bank"/>
		</fo:static-content>
  </xsl:template>
  <xsl:template name="body">
    <fo:flow flow-name="xsl-region-body" font-size="{$pdfFontSize}">
			<xsl:call-template name="disclammer_template"/>
			<xsl:if test="not(tnx_id) or (tnx_type_code[.!='01'] and tnx_type_code[.!='13']) or preallocated_flag[.='Y']">
			 	<fo:block id="evedetails_ic" />
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_EVENT_DETAILS')" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="company_name[.!=''] or product_code[.='IC']">
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
						<xsl:if test="product_code[.='IC']">
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
						<xsl:if test="presenting_bank/name[.!='']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRESENTING_BANK')"/>
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="presenting_bank/name"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>	
					</xsl:with-param>
				</xsl:call-template>
				<!-- Bank Message -->
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
            <!-- Transaction Details Section -->
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
	                          	<xsl:value-of select="utils:getCompanyName(ref_id,product_code)"/><!-- 20170807_01 -->
	                        </xsl:with-param>
                        </xsl:call-template>                            
                        <xsl:call-template name="table_cell">
                        	<xsl:with-param name="left_text">
                            	<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_CODE')"/>
                            </xsl:with-param>
                            <xsl:with-param name="right_text">
                            	<xsl:value-of select="localization:getDecode($language, 'N001', product_code[.])" />
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
							<!-- Application Date -->
						 <xsl:if test="appl_date[. != '']">
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
						
                        <xsl:if test="tnx_type_code[.!='']">
                        	<xsl:call-template name="table_cell">
                            	<xsl:with-param name="left_text">
                                	<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_TRANSACTION_TYPE')"/>
                                </xsl:with-param>
                                <xsl:with-param name="right_text">
                                	<xsl:value-of select="localization:getDecode($language, 'N002', tnx_type_code[.])"/>
                                    <xsl:if test="sub_tnx_type_code[. != '']">&nbsp;
                                    	<xsl:value-of select="localization:getDecode($language, 'N003', sub_tnx_type_code[.])"/>
									</xsl:if>
                                </xsl:with-param>
                            </xsl:call-template>
                        
                        </xsl:if>
                   	</xsl:with-param>
              	</xsl:call-template> 
             <!-- Reporting Details Section -->
                <fo:block id="reportdetails"/>
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="title">
							<xsl:with-param name="text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REPORTING_DETAILS')"/>
							</xsl:with-param>
						</xsl:call-template>
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
				<!-- Charges Details Section -->
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
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CREATION_DATE')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="appl_date"/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- <xsl:if test="ic_type_code != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_COLL_TYPE_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:choose>
									<xsl:when test="ic_type_code = '01'">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_COLL_TYPE_REGULAR')"/>
									</xsl:when>
									<xsl:when test="ic_type_code = '02' or ic_type_code = '03'">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_COLL_TYPE_DIRECT')"/>
									</xsl:when>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if> -->
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
							<xsl:if test="term_code[.!='01'] and (term_code[.!='03'] or tenor_type[.!='01'])">
						     	<xsl:text> / </xsl:text><xsl:value-of select="tenor_days"/><xsl:text> </xsl:text>
						     	<xsl:choose>
							     	<xsl:when test="tenor_period[.='D']">
							     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_DAYS')"/><xsl:text> </xsl:text>
							     	</xsl:when>
							     	<xsl:when test="tenor_period[.='W']">
							     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_WEEKS')"/><xsl:text> </xsl:text>
							     	</xsl:when>
							     	<xsl:when test="tenor_period[.='M']">
							     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_MONTHS')"/><xsl:text> </xsl:text>
							     	</xsl:when>
							     	<xsl:when test="tenor_period[.='Y']">
							     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_YEARS')"/><xsl:text> </xsl:text>
							     	</xsl:when>
						     	</xsl:choose>
						     	<xsl:if test="tenor_from_after[.='A'] or tenor_from_after[.='E'] or tenor_from_after[.='F']">
							     	          <xsl:value-of select="localization:getDecode($language, 'C052', tenor_from_after)"/><xsl:text> </xsl:text>
							     	</xsl:if>
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
				<xsl:if test="(tenor_type[.='02'] or tenor_type[.='03']) and tenor_maturity_date[.!='']">
				<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_MATURITY')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="tenor_maturity_date"/>
						</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				<xsl:if test="tenor_base_date != ''">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_BASE_DATE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
							<xsl:value-of select="tenor_base_date"/>
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
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="drawee_name"/>
						</xsl:with-param>
					</xsl:call-template>
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
			<!--Drawer Details-->
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DRAWER_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="drawer_name"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="drawer_address_line_1[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="drawer_address_line_1"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
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
					<xsl:if test="drawer_reference[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="drawer_reference"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<!--Amount Details-->
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
					<!--Collection Currency and Amount-->
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_COLL_AMT_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="concat(ic_cur_code, ' ', ic_amt)" />
						</xsl:with-param>
					</xsl:call-template>
				<!-- MPS-41651- Outstanding amount -->
					<xsl:if test="not(tnx_id) or ic_outstanding_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_OS_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="ic_cur_code"/> <xsl:value-of select="ic_outstanding_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<!-- MPS-55947(In case of of collections liability amount won't be updated as per banks perspective) -->
					<!-- <xsl:if test="not(tnx_id) or ic_liab_amt[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="ic_cur_code"/> <xsl:value-of select="concat(' ', ic_liab_amt)" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>  -->
				</xsl:with-param>
			</xsl:call-template>
			
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
		
			<!--Bank Details-->
			<fo:block id="bankdetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
						<xsl:if test="remitting_bank/name[.!=''] or collecting_bank/name[.!='']">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BANK_DETAILS')"/>
							</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					<!-- <xsl:apply-templates select="presenting_bank">
						<xsl:with-param name="theNodeName" select="'presenting_bank'"/>
						<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_PRESENTING_BANK')"/>
					</xsl:apply-templates> -->
					<xsl:if test="remitting_bank/name[.!='']">
						<xsl:apply-templates select="remitting_bank">
							<xsl:with-param name="theNodeName" select="'remitting_bank'"/>
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language,  'XSL_BANKDETAILS_TAB_REMITTING_BANK')"/>
						</xsl:apply-templates>
					</xsl:if>
					<xsl:if test="collecting_bank/name[.!='']">
						<xsl:apply-templates select="collecting_bank">
							<xsl:with-param name="theNodeName" select="'collecting_bank'"/>
							<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_BANKDETAILS_TAB_COLLECTING_BANK')"/>
						</xsl:apply-templates>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
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
			
			<!-- Goods description pane to be displayed above collection instructions pane- similar to pop up-MPS-40014 -->
			<!-- Desc of Goods Narrative -->
			<fo:block id="goodsdescription"/>
			<xsl:if test="narrative_description_goods[.!='']">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">	
     				<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_NARRATIVE_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
			    </xsl:with-param>
			</xsl:call-template>
			</xsl:if>		
			<xsl:if test="narrative_description_goods[.!='']">
				<xsl:call-template name="table_template2">
					<xsl:with-param name="text">
						<xsl:apply-templates select="narrative_description_goods">
							<xsl:with-param name="theNodeName"
								select="'narrative_description_goods'" />
							<xsl:with-param name="theNodeDescription"
								select="localization:getGTPString($language, 'XSL_DESCRIPTION_OF_GOODS')" />
						</xsl:apply-templates>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			
			<!-- Collections instructions -->
			<fo:block id="collectioninstructions"/>
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
					<!-- Other instructions to be displayed under collection instructions pane similar to pop up-MPS-40014 -->
					<xsl:if test="narrative_additional_instructions[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_OTHER_INSTRUCTIONS')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
									<xsl:value-of select="narrative_additional_instructions"/>
							</xsl:with-param>
					   </xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="list_item">
				<xsl:with-param name="item">
					<xsl:choose>
						<xsl:when test="waive_chrg_flag[. = 'Y']">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_WAIVE_YES')"/>
						</xsl:when>
						<xsl:when test="waive_chrg_flag[. = 'N']">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_WAIVE_NO')"/>
						</xsl:when>
						<xsl:otherwise/>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<!-- Protest and Other Instructions -->
			<xsl:call-template name="list_item">
				<xsl:with-param name="item">
						<xsl:choose>
							<xsl:when test="protest_non_paymt[. = 'Y']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_PROTEST_PAYMT_YES')"/>
							</xsl:when>
							<xsl:when test="protest_non_paymt[. = 'N']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_PROTEST_PAYMT_NO')"/>
							</xsl:when>
							<xsl:otherwise/>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="list_item">
				<xsl:with-param name="item">
					<xsl:choose>
						<xsl:when test="protest_non_accpt[. = 'Y']">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_PROTEST_ACCPT_YES')"/>
						</xsl:when>
						<xsl:when test="protest_non_accpt[. = 'N']">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_PROTEST_ACCPT_NO')"/>
						</xsl:when>
						<xsl:otherwise/>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="protest_adv_send_mode[.!='']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<fo:table-row keep-with-previous="always">
							<fo:table-cell number-columns-spanned="2">
								<fo:block start-indent="20.0pt">
									<fo:inline>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_PROTEST_ADV_SEND_MODE_LABEL')"/>
									</fo:inline>
									<fo:inline font-weight="bold">
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
									</fo:inline>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="list_item">
				<xsl:with-param name="item">
					<xsl:choose>
						<xsl:when test="accpt_defd_flag[. = 'Y']">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_ACCPT_DEFD_YES')"/>
						</xsl:when>
						<xsl:when test="accpt_defd_flag[. = 'N']">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_ACCPT_DEFD_NO')"/>
						</xsl:when>
						<xsl:otherwise/>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="list_item">
				<xsl:with-param name="item">
					<xsl:choose>
						<xsl:when test="store_goods_flag[. = 'Y']">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_STORE_GOODS_YES')"/>
						</xsl:when>
						<xsl:when test="store_goods_flag[. = 'N']">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_STORE_GOODS_NO')"/>
						</xsl:when>
						<xsl:otherwise/>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			
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
			  				       	<fo:table-column column-width="5.0pt"/>
			  				       	<fo:table-column column-width="proportional-column-width(9)"/>
			  				       	<fo:table-column column-width="proportional-column-width(2)"/>
			  				       	<fo:table-column column-width="proportional-column-width(3)"/>
			  				       	<fo:table-column column-width="proportional-column-width(3)"/>
						        	<fo:table-column column-width="proportional-column-width(3)"/>
						        	<fo:table-column column-width="proportional-column-width(2)"/>
						        	<fo:table-column column-width="proportional-column-width(3)"/>
						        	<fo:table-column column-width="proportional-column-width(1)"/>
						        	<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
										<fo:table-row text-align="center">
										<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell>
										<fo:table-cell><fo:block border-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".5pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_COLUMN_DOCUMENT')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block border-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".5pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOC_COLUMN_NO')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block border-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".5pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOC_COLUMN_DATE')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block border-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".5pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_1ST_MAIL_LABEL')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block border-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".5pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_2ND_MAIL_LABEL')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block border-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".5pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_TOTAL')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block border-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".5pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_MAP_TO_ATTACHMENT')"/></fo:block></fo:table-cell>
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
