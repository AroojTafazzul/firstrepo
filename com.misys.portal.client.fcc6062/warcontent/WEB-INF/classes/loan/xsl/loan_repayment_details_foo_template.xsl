<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com), All Rights Reserved. -->
<xsl:stylesheet
	xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider"
	xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	

	<xsl:param name="language">en</xsl:param>

	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')" />
	</xsl:variable>
	
	
	<xsl:template match="/">
	<xsl:apply-templates select="lnRepaymentDetails"/>
</xsl:template>

	<xsl:template match="lnRepaymentDetails">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
		     <fo:layout-master-set>
                <fo:simple-page-master master-name="A4-portrail" page-height="297mm" page-width="210mm" margin-top="5mm" margin-bottom="5mm" margin-left="5mm" margin-right="5mm">
                    <fo:region-body margin-top="25mm" margin-bottom="20mm"/>
                    <fo:region-before region-name="xsl-region-before" extent="25mm" display-align="before" precedence="true"/>
              </fo:simple-page-master>
            </fo:layout-master-set>
		<fo:page-sequence initial-page-number="1" master-reference="A4-portrail">

		<!-- HEADER -->

		<!-- FOOTER -->

		<!-- BODY -->

			<!-- <xsl:call-template name="header" />-->
			<!--<xsl:call-template name="footer" /> -->
			 <xsl:call-template name="body" /> 
		</fo:page-sequence>
		</fo:root>
	</xsl:template>



	<xsl:template name="header">
		<fo:static-content flow-name="xsl-region-before">
			<!-- <xsl:call-template name="header_issuing_bank" /> -->
		</fo:static-content>
	</xsl:template>
	<xsl:template name="body">
			<fo:static-content flow-name="xsl-region-before">
				<fo:table table-layout="fixed" width="100%" font-size="10pt" border-color="black" border-width="0.4mm" border-style="solid">
					<fo:table-column column-width="80%" />
					<fo:table-body>
						<fo:table-row>						
							<fo:table-cell text-align="left" display-align="center" padding-left="2mm">
								<fo:block>
									<xsl:value-of select="localization:getGTPString($language, 'XLS_REPAYMENT_DETAILS_REPAYMENT_TYPE')"/> <xsl:value-of select="repaymentType" />												
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>						
							<fo:table-cell text-align="left" display-align="center" padding-left="2mm">
								<fo:block>
									<xsl:value-of select="localization:getGTPString($language, 'XLS_REPAYMENT_DETAILS_REPAYMENT_FREQUENCY')"/> <xsl:value-of select="repaymentFrequency" />												
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>						
							<fo:table-cell text-align="left" display-align="center" padding-left="2mm">
								<fo:block>
									<xsl:value-of select="localization:getGTPString($language, 'XLS_REPAYMENT_DETAILS_REPAYMENT_OUTSTANDING_AMT')"/> <xsl:value-of select="currentOutstandingAmt" />													
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:static-content>
			<xsl:if test="repaymentType[.= 'FIXED PRICIPLE AND INTEREST DUE' 
				or .= 'PRICIPLE SCHEDULE' or .= 'BULLET SCHEDULE' or .= 'Principal Only']"> 
			<xsl:call-template name="LoanRepaymentDetailsFixed-Bullet-Principle"/>

			</xsl:if>
			<xsl:if test="repaymentType[.= 'FIXED (PRINCIPLE AND INTEREST DUE)']">
				<xsl:call-template name="LoanRepaymentDetailsFixed"/>
			</xsl:if>
			


	</xsl:template>
	<xsl:template name="LoanRepaymentDetailsFixed-Bullet-Principle">
			<fo:flow flow-name="xsl-region-body">

			<fo:block white-space-collapse="false">
				<fo:table table-layout="fixed" width="100%" font-size="10pt" border-color="black" border-width="0.35mm" border-style="solid" text-align="center" display-align="center" space-after="5mm">
					<fo:table-column column-width="8%" />
					<fo:table-column column-width="10%" />
					<fo:table-column column-width="10%" />
					<fo:table-column column-width="20%" />
					<fo:table-column column-width="10%" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>																												
						</fo:table-row>
						<fo:table-row>
								<fo:table-cell>
									<fo:block><xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_CYCLE_NO')"/> </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block><xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_PRINCIPLE_AMT')"/> </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block><xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_UNPAID_PRINCIPLE_AMT')"/> </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block><xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_DUE_DATE')"/> </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block><xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_REMAINING_AMT')"/> </fo:block>
								</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>																												
						</fo:table-row>						
						<xsl:for-each select="scheduleItems/scheduleItem">
						<xsl:variable name="loanDetails" select="."/>
						          <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="$loanDetails/cycleNo"/>
                                        </fo:block>
                                    </fo:table-cell>
                                     <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="$loanDetails/principleAmt"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="$loanDetails/unpaidPrincipleAmt"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="$loanDetails/dueDate"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="$loanDetails/remainingAmt"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:for-each>
                   </fo:table-body>
               	</fo:table>
            </fo:block>
        </fo:flow>

	</xsl:template>
	
	<xsl:template name="LoanRepaymentDetailsFixed">
		<fo:flow flow-name="xsl-region-body">

			<fo:block white-space-collapse="false">
				<fo:table table-layout="fixed" width="100%" font-size="10pt" border-color="black" border-width="0.35mm" border-style="solid" text-align="center" display-align="center" space-after="5mm">
					<fo:table-column column-width="8%" />
					<fo:table-column column-width="10%" />
					<fo:table-column column-width="10%" />
					<fo:table-column column-width="10%" />
					<fo:table-column column-width="10%" />
					<fo:table-column column-width="10%" />
					<fo:table-column column-width="20%" />
					<fo:table-column column-width="10%" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>																												
						</fo:table-row>
						<fo:table-row>
								<fo:table-cell>
									<fo:block><xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_CYCLE_NO')"/> </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block><xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_AMT')"/> </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block><xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_INTEREST_AMT')"/> </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block><xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_UNPAID_INTEREST_AMT')"/> </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block><xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_PRINCIPLE_AMT')"/> </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block><xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_UNPAID_PRINCIPLE_AMT')"/> </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block><xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_DUE_DATE')"/> </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block><xsl:value-of select="localization:getGTPString($language, 'LN_REPAYMENT_REMAINING_AMT')"/> </fo:block>
								</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block> </fo:block>
							</fo:table-cell>																												
						</fo:table-row>						
						<xsl:for-each select="scheduleItems/scheduleItem">
						<xsl:variable name="loanDetails" select="."/>
						          <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="$loanDetails/cycleNo"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="$loanDetails/paymentAmt"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="$loanDetails/interestAmt"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="$loanDetails/unpaidInterestAmt"/>
                                        </fo:block>
                                    </fo:table-cell>
                                     <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="$loanDetails/principleAmt"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="$loanDetails/unpaidPrincipleAmt"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="$loanDetails/dueDate"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:value-of select="$loanDetails/remainingAmt"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:for-each>
                   </fo:table-body>
               	</fo:table>
            </fo:block>
        </fo:flow>
	</xsl:template>
	
	<xsl:template name="footer">
		<fo:static-content flow-name="xsl-region-after">

		</fo:static-content>
	</xsl:template>
</xsl:stylesheet>
