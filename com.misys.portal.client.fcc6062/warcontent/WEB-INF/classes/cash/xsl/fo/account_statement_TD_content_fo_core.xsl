<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:localization="xalan://com.misys.portal.common.localization.Localization" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>


	<xsl:variable name="headerFontSize">7</xsl:variable>
	<xsl:variable name="blockFontSize">7</xsl:variable>
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>

	<xsl:template match="TD_STATEMENT">
		<!-- HEADER -->
		
		<!-- FOOTER --> 
		
		<!-- BODY -->
		
	<xsl:call-template name="header_TD"/>
    <xsl:call-template name="footer_TD"/>
    <xsl:call-template name="body_TD"/>
  </xsl:template>
	
	<!--  Account Details, Displayed only for Account Statement-->
	<xsl:template name="account-details-TD">
		<fo:block id="acctDetails"/>
			<fo:block white-space-collapse="false">
				<fo:table>
					<fo:table-column column-width="25%"/>
					<fo:table-column column-width="75%"/>
					<fo:table-header>
						<fo:table-row keep-with-next="always">
							<fo:table-cell number-columns-spanned="2">
								<xsl:call-template name="title_private">
									<xsl:with-param name="content">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/>
									</xsl:with-param>
								</xsl:call-template>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-header>
					<fo:table-body>
						<!--  Entity -->
						<fo:table-row>
							<fo:table-cell>
								<fo:block>
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AB_ENTITY')"/>
              </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
                <xsl:value-of select="ENTITY"/>
              </fo:block>
							</fo:table-cell>
						</fo:table-row>
						<!-- Account Number -->
						<fo:table-row>
							<fo:table-cell>
								<fo:block>
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AB_ACCOUNT_NO')"/>
              </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
                <xsl:value-of select="ACCOUNT_NO"/>
              </fo:block>
							</fo:table-cell>
						</fo:table-row>
						<!-- Account Name -->				
						<fo:table-row>
							<fo:table-cell>
								<fo:block>
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AB_ACCOUNT_NAME')"/>
              </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
                <xsl:value-of select="ACCOUNT_NAME"/>
              </fo:block>
							</fo:table-cell>
						</fo:table-row>
						<!-- Account Branch-->
						<fo:table-row>
							<xsl:choose>
								<xsl:when test="BRANCH">
									<fo:table-cell>
										<fo:block>
                    <xsl:value-of select="localization:getGTPString($language, 'XSL_AB_ACCOUNT_BRANCH_NAME')"/>
                  </fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>
                    <xsl:value-of select="BRANCH"/>
                  </fo:block>
									</fo:table-cell>
								</xsl:when>
								<xsl:otherwise>
									<fo:table-cell>
										<fo:block/>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block/>
									</fo:table-cell>
								</xsl:otherwise>
							</xsl:choose>
						</fo:table-row>
						<!-- Account Type -->
						<fo:table-row>
							<fo:table-cell>
								<fo:block>
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AB_ACCOUNT_TYPE')"/>
              </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
                <xsl:value-of select="ACCOUNT_TYPE"/>
              </fo:block>
							</fo:table-cell>
						</fo:table-row>
						
						<!-- TD Type-->
						<fo:table-row>
							<fo:table-cell>
								<fo:block>
                <xsl:value-of select="localization:getGTPString($language, 'XSL_AB_TYPE')"/>
              </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
                <xsl:value-of select="GROUP"/>
              </fo:block>
							</fo:table-cell>								
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
	</xsl:template>	

	<!-- TD Account Statement -->
	<xsl:template name="account-statement-TD">
		<fo:block id="acctStatement"/>
		<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="title">
						<xsl:with-param name="text">
							<xsl:value-of select="./GROUP"/>
            <xsl:value-of select="localization:getGTPString($language, 'XSL_COL_TITLE_DETAILS')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
		    </xsl:call-template>
					
		     <fo:block font-size="7.0pt" white-space-collapse="false"> 
				<fo:table>
					<fo:table-column column-width="8%"/>
					<fo:table-column column-width="12%"/>
					<fo:table-column column-width="8%"/>
					<fo:table-column column-width="12%"/>
					<fo:table-column column-width="9%"/>
					<fo:table-column column-width="6%"/>
					<fo:table-column column-width="9%"/>
					<fo:table-column column-width="10%"/>
					<fo:table-column column-width="13%"/>
					<fo:table-column column-width="12%"/>
					<fo:table-body>
						<fo:table-row>
					  		<fo:table-cell number-columns-spanned="10">
						      	<fo:block> </fo:block>
						    </fo:table-cell>
						</fo:table-row>
						  <fo:table-row background-color="#7692B7" color="white" font-weight="bold" margin="1pt" text-align="center">
								<fo:table-cell border="1pt solid black">
									<fo:block>
						                <xsl:value-of select="localization:getGTPString($language, 'XSL_COL_DEPOSIT_NUMBER')"/>
					   	            </fo:block>	
								</fo:table-cell>
								<fo:table-cell border="1pt solid black">
									<fo:block>											
							            <xsl:value-of select="localization:getGTPString($language, 'XSL_COL_PRODUCT_TYPE')"/> 
							        </fo:block>	
								</fo:table-cell>
								<fo:table-cell border="1pt solid black">
									<fo:block>											
							            <xsl:value-of select="localization:getGTPString($language, 'XSL_COL_CURRENCY')"/> 
							        </fo:block>	
								</fo:table-cell>
								<fo:table-cell border="1pt solid black">
									<fo:block>											
							            <xsl:value-of select="localization:getGTPString($language, 'XSL_COL_PRINCIPAL_AMOUNT')"/> 
							        </fo:block>	
								</fo:table-cell>
								<fo:table-cell border="1pt solid black">
									<fo:block>											
							            <xsl:value-of select="localization:getGTPString($language, 'XSL_COL_VALUE_DATE')"/> 
							        </fo:block>	
								</fo:table-cell>
								<fo:table-cell border="1pt solid black">
									<fo:block>											
							            <xsl:value-of select="localization:getGTPString($language, 'XSL_COL_TENOR')"/> 
							        </fo:block>	
								</fo:table-cell>
								<fo:table-cell border="1pt solid black">
									<fo:block>											
							            <xsl:value-of select="localization:getGTPString($language, 'XSL_COL_MATURITY_DATE')"/> 
							        </fo:block>	
								</fo:table-cell>
								<fo:table-cell border="1pt solid black">
									<fo:block>											
							            <xsl:value-of select="localization:getGTPString($language, 'XSL_COL_INTEREST_RATE')"/> 
							        </fo:block>	
								</fo:table-cell>
								<fo:table-cell border="1pt solid black">
									<fo:block>											
							            <xsl:value-of select="localization:getGTPString($language, 'XSL_COL_CONTRACTED_INTEREST_RATE')"/> 
							        </fo:block>	
								</fo:table-cell>
								<fo:table-cell border="1pt solid black">
									<fo:block>											
							            <xsl:value-of select="localization:getGTPString($language, 'XSL_COL_REMARKS')"/> 
							        </fo:block>	
								</fo:table-cell>
							</fo:table-row>	
						<xsl:if test="(count(JSONARRAY/JSONOBJECT) &gt; 0)">	
							<xsl:for-each select="JSONARRAY/JSONOBJECT">
								<xsl:variable name="position" select="position()"/>
								<fo:table-row>
									<xsl:attribute name="background-color">
					      				<xsl:choose>
					      					<xsl:when test="$position mod 2 = 1">#CBE3FF</xsl:when>
					      					<xsl:otherwise>#F0F7FF</xsl:otherwise>
					      				</xsl:choose>
					      			</xsl:attribute>
							  		<fo:table-cell>
								      	<fo:block>
                    <xsl:value-of select="TDNUM"/>
                  </fo:block>
								    </fo:table-cell>
								    <fo:table-cell>
								      	<fo:block>
                    <xsl:value-of select="PRODUCT_TYPE"/>
                  </fo:block>
								    </fo:table-cell>
								    <fo:table-cell>
								      	<fo:block text-align="center">
                    <xsl:value-of select="CUR_CODE"/>
                  </fo:block>
								    </fo:table-cell>
								      <fo:table-cell>
								      	<fo:block text-align="end">
                    <xsl:value-of select="AMT"/>
                  </fo:block>
								    </fo:table-cell>
								      <fo:table-cell>
								      	<fo:block text-align="center">
                    <xsl:value-of select="VALUE_DATE"/>
                  </fo:block>
								    </fo:table-cell>
								    <fo:table-cell>
								      	<fo:block text-align="center">
                    <xsl:value-of select="TENOR"/>
                  </fo:block>
								    </fo:table-cell>
								    <fo:table-cell>
								      	<fo:block text-align="center">
                    <xsl:value-of select="MATURITY_DATE"/>
                  </fo:block>
								    </fo:table-cell>
								    <fo:table-cell>
								      	<fo:block text-align="end">
                    <xsl:value-of select="INTEREST_RATE"/>
                  </fo:block>
								    </fo:table-cell>
								    <fo:table-cell>
								      	<fo:block text-align="end">
                    <xsl:value-of select="MATURITY_AMOUNT"/>
                  </fo:block>
								    </fo:table-cell>
								    <fo:table-cell>
								      	<fo:block>
                    <xsl:value-of select="REMARK"/>
                  </fo:block>
								    </fo:table-cell>
								</fo:table-row>
							</xsl:for-each>
						</xsl:if>
					</fo:table-body>
				</fo:table>
		</fo:block>
	</xsl:template>		

    
<xsl:template name="header_TD">
    <fo:static-content flow-name="xsl-region-before">
			<xsl:call-template name="header_no_bank">
				<xsl:with-param name="headerTitle">XSL_HEADER_ACCOUNT_STATEMENT</xsl:with-param>
			</xsl:call-template>
		</fo:static-content>
  </xsl:template>
  <xsl:template name="body_TD">
    <fo:flow flow-name="xsl-region-body" font-size="10.0pt" xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider">
							
			<fo:block id="accountStatementTD"/>
			<!-- Account Details and Statement -->	
			<xsl:call-template name="account-details-TD"/>		
			<xsl:call-template name="account-statement-TD"/>			
		</fo:flow>
  </xsl:template>
  <xsl:template name="footer_TD">
    <fo:static-content flow-name="xsl-region-after">
			<fo:block font-family="{$pdfFont}" font-size="8.0pt" keep-together="always">
				<fo:block>
					<xsl:attribute name="end-indent">
            <xsl:value-of select="number($pdfMargin)"/>pt</xsl:attribute>
					<xsl:value-of select="convertTools:internalDateToStringDate($systemDate,$language)"/>
				</fo:block>
			</fo:block>
		</fo:static-content>
  </xsl:template>
</xsl:stylesheet>
