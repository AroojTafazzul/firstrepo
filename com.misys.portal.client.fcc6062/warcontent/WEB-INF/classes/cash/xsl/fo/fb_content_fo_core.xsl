<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<!-- Copyright (c) 2006-2012 Misys , All Rights Reserved -->
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" 
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
	xmlns:fo="http://www.w3.org/1999/XSL/Format" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
	xmlns:formatter="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:payeeutils="xalan://com.misys.portal.product.util.PayeeUtil" 
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	 <xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>
	<xsl:variable name="loc_lan">
          <xsl:value-of select="defaultresource:getResource('LOCAL_LANGUAGE')"/>
     </xsl:variable>

	<xsl:template match="fb_tnx_record">
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
    <fo:block id="testdetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_EVENT_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
						<xsl:if test="release_dttm[.!='']">
					<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_EVENT_DATE')" />
							</xsl:with-param>
					<xsl:with-param name="right_text">
							<xsl:value-of select="formatter:formatReportDate(release_dttm,$rundata)" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_CODE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getDecode($language, 'N001', product_code[.])"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="tnx_type_code[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_PRODUCT_TYPE')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="localization:getDecode($language, 'N002', tnx_type_code[.])"/>
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
					
					<xsl:if test="issuing_bank/name[.!='']">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'BANK_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="issuing_bank/name"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			
			<fo:block id="invdetails"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BANK_INVOICE_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			
			
			<fo:block xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider" white-space-collapse="false">
				<fo:table>
					<fo:table-column column-width="60%"/>
					<fo:table-column column-width="40%"/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
								<fo:table>
								<fo:table-column column-width="40%"/>
								<fo:table-column column-width="60%"/>
									<fo:table-body start-indent="2pt">
										<fo:table-row>
											<fo:table-cell>
												<fo:block> </fo:block>												
											</fo:table-cell>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
										 <fo:table-row>
											<fo:table-cell>
												<fo:block>
									                <xsl:value-of select="localization:getGTPString($language, 'XSL_BANKINVOICEDETAILS_INVOICE_REFERENCE')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
									                <xsl:value-of select="bo_ref_id"/>
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										 <fo:table-row>
											<fo:table-cell>
												<fo:block>
										            <xsl:value-of select="localization:getGTPString($language, 'XSL_BANKINVOICEDETAILS_INVOICE_CURRENCY')"/>									   	                									   	        
								                </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>										                	
									   	            <xsl:value-of select="fb_cur_code"/>									   	        
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKINVOICEDETAILS_INVOICE_AMOUNT')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>													
													<xsl:value-of select="inv_amt"/>
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKINVOICEDETAILS_PRV_DUE_AMT')"/>
								   	            </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>													
													<xsl:value-of select="prev_due_amt"/>
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_BANKINVOICEDETAILS_RECD_AMT')" />
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="recd_amt" />
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_BANKINVOICEDETAILS_DUE_AMT')" />
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="due_amt" />
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									</fo:table-body>
								</fo:table>
							</fo:table-cell>	
							
						    <fo:table-cell>
						       <fo:table>
						        <fo:table-column column-width="50%"/>
								<fo:table-column column-width="50%"/>
									<fo:table-body>
									<fo:table-row>
											<fo:table-cell>
												<fo:block> </fo:block>												
											</fo:table-cell>
											<fo:table-cell>
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
									   <fo:table-row>
											<fo:table-cell>
												<fo:block>												
										            <xsl:value-of select="localization:getGTPString($language, 'XSL_BANKINVOICEDETAILS_INVOICE_ENTITY')"/> 
										        </fo:block>	
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="entity"/>									   	            
								                </fo:block>	
											</fo:table-cell>
										</fo:table-row>	
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKINVOICEDETAILS_INVOICE_CUST_ID')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="utils:decryptApplicantReference(applicant_reference)"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKINVOICEDETAILS_INVOICE_DATE')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="appl_date"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row>
											<fo:table-cell>
												<fo:block>											
														<xsl:value-of select="localization:getGTPString($language, 'XSL_BANKINVOICEDETAILS_INVOICE_DUE_DATE')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="inv_due_date"/>													
											   </fo:block>
											</fo:table-cell>
										</fo:table-row>
									  </fo:table-body>
								</fo:table>
						    </fo:table-cell>      
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>	
			
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