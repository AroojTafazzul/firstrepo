<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:localization="xalan://com.misys.portal.common.localization.Localization" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl"/>
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>

	<xsl:variable name="headerFontSize">7</xsl:variable>
	<xsl:variable name="blockFontSize">7</xsl:variable>
	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>

	<xsl:template match="jsonArray">
		<!-- HEADER -->
		
		<!-- FOOTER -->
		
		<!-- BODY -->
		
	<xsl:call-template name="header"/>
    <xsl:call-template name="footer"/>
    <xsl:call-template name="body"/>
  </xsl:template>
	
	<!--  Account Details, Displayed only for Account Statement-->
	<xsl:template name="account-details">
		<fo:block id="acctDetails"/>
		<xsl:if test="(count(acct_details_table_data_pdf/array) &gt; 0)">	
			<fo:block xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider" white-space-collapse="false">
				<fo:table>
					<fo:table-column column-width="20%"/>
					<fo:table-column column-width="20%"/>
					<fo:table-column column-width="20%"/>
					<fo:table-column column-width="20%"/>
					<fo:table-column column-width="20%"/>
					<fo:table-header>
						<fo:table-row font-size="8.0pt" keep-with-next="always">
							<fo:table-cell number-columns-spanned="4">
								<xsl:call-template name="title_private">
									<xsl:with-param name="content">
										<xsl:value-of select="account_details_title"/>
									</xsl:with-param>
								</xsl:call-template>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-header>
					<fo:table-body>
						<xsl:for-each select="acct_details_table_data_pdf/array">
						
						
							<fo:table-row>
							<xsl:if test="./ENTITY">
								<fo:table-cell>
									<fo:block>
                      <xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/>
                    </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
                      <xsl:value-of select="./ENTITY"/>
                    </fo:block>
								</fo:table-cell>
								</xsl:if>
								<fo:table-cell>
								<fo:block>
                    <xsl:value-of select="localization:getGTPString($language, 'XSL_AB_ACCOUNT_NO')"/>
                  </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
                    <xsl:value-of select="./ACCOUNT_NO"/>
                  </fo:block>
							</fo:table-cell>
							</fo:table-row>
						
						
						<!--  Row 1, Account type and Account No -->
						<fo:table-row>
							<fo:table-cell>
								<fo:block>
                    <xsl:value-of select="localization:getGTPString($language, 'XSL_AB_ACCOUNT_TYPE')"/>
                  </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
                    <xsl:value-of select="./ACCOUNT_TYPE"/>
                  </fo:block>
							</fo:table-cell>
							<xsl:if test="./ACCOUNT_NAME">
								<fo:table-cell>
									<fo:block>
                      <xsl:value-of select="localization:getGTPString($language, 'XSL_AB_ACCOUNT_NAME')"/>
                    </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
                      <xsl:value-of select="./ACCOUNT_NAME"/>
                    </fo:block>
								</fo:table-cell>
							</xsl:if>
						</fo:table-row>
					
						<!--  Row 2, Account Cur and Account Name -->
						<fo:table-row>
							<fo:table-cell>
								<fo:block>
                    <xsl:value-of select="localization:getGTPString($language, 'XSL_AB_ACCOUNT_CURRENCY')"/>
                  </fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
                    <xsl:value-of select="./ACCOUNT_CURRENCY"/>
                  </fo:block>
							</fo:table-cell>
							<xsl:if test="./BANK_ABBV_NAME">
								<fo:table-cell>
									<fo:block>
                      <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME_AND')"/>
                    </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
                      <xsl:value-of select="./BANK_ABBV_NAME"/>
                    </fo:block>
								</fo:table-cell>
							</xsl:if>	
						</fo:table-row>
							
						<!--  Row 3, Account Status and Ledger balance -->
						<fo:table-row>
							<fo:table-cell>
								<fo:block>
                    <xsl:value-of select="localization:getGTPString($language, 'STATUS')"/>
                  </fo:block>
							</fo:table-cell>
							<fo:table-cell>
									<fo:block>
                    <xsl:value-of select="./STATUS"/>
                  </fo:block>
							</fo:table-cell>
							<xsl:if test="./LEDGER_BALANCE">
								<fo:table-cell>
									<fo:block>
                      <xsl:value-of select="localization:getGTPString($language, 'XSL_AB_LEDGER_BALANCE')"/>
                    </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
                      <xsl:value-of select="./LEDGER_BALANCE"/>
                    </fo:block>
								</fo:table-cell>
							</xsl:if>
						</fo:table-row>
						
						<!--  Row 4, Account Status and available balance -->
						<fo:table-row>
							<fo:table-cell>
								<fo:block/>
							</fo:table-cell>
							<fo:table-cell>
									<fo:block/>
							</fo:table-cell>								
							<xsl:if test="./AVAILABLE_BALANCE">
								<fo:table-cell>
									<fo:block>
                      <xsl:value-of select="localization:getGTPString($language, 'XSL_AB_AVAILABLE_BALANCE')"/>
                    </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
                      <xsl:value-of select="./AVAILABLE_BALANCE"/>
                    </fo:block>
								</fo:table-cell>
							</xsl:if>
						</fo:table-row>
						
						<!--  Row 5, Account Status and reserved balance -->
						<fo:table-row>
							<fo:table-cell>
								<fo:block/>
							</fo:table-cell>
							<fo:table-cell>
									<fo:block/>
							</fo:table-cell>								
							<xsl:if test="./RESERVED_BALANCE">
								<fo:table-cell>
									<fo:block>
                      <xsl:value-of select="localization:getGTPString($language, 'XSL_AB_RESERVED_BALANCE')"/>
                    </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
                      <xsl:value-of select="./RESERVED_BALANCE"/>
                    </fo:block>
								</fo:table-cell>
							</xsl:if>
						</fo:table-row>
						
						<!--  Row 1, Entity and Account Currency -->
						<!-- <fo:table-row>
							<xsl:choose>
								<xsl:when test="./ENTITY">
									<fo:table-cell>
										<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_AB_ENTITY')" /></fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block><xsl:value-of select="./ENTITY"/></fo:block>
									</fo:table-cell>
								</xsl:when>
								<xsl:otherwise>
									<fo:table-cell>
										<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_AB_ENTITY')" /></fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block><xsl:value-of select="./COMPANY" /></fo:block>
									</fo:table-cell>
								</xsl:otherwise>
							</xsl:choose>
							<fo:table-cell>
								<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_AB_ACCOUNT_CURRENCY')" /></fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block><xsl:value-of select="./ACCOUNT_CURRENCY"/></fo:block>
							</fo:table-cell>
						</fo:table-row>
						Row 2, Account No and Actual Bal
						<fo:table-row>
							<fo:table-cell>
								<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_AB_ACCOUNT_NO')" /></fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block><xsl:value-of select="./ACCOUNT_NO"/></fo:block>
							</fo:table-cell>
							<xsl:choose>
								<xsl:when test="./ACTUAL_BALANCE">
									<fo:table-cell>
										<fo:block><xsl:value-of select="localization:getGTPString($language, 'AB_Actual_Balance')" /></fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block><xsl:value-of select="./ACTUAL_BALANCE"/></fo:block>
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
						Row 3, Account Name and Cleared Balance
						<fo:table-row>
							<fo:table-cell>
								<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_AB_ACCOUNT_NAME')" /></fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block><xsl:value-of select="./ACCOUNT_NAME"/></fo:block>
							</fo:table-cell>
							<xsl:choose>
								<xsl:when test="./CLEARED_BALANCE">
									<fo:table-cell>
										<fo:block><xsl:value-of select="localization:getGTPString($language, 'AB_Cleared_Balance')" /></fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block><xsl:value-of select="./CLEARED_BALANCE"/></fo:block>
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
						
						Row 4, Account Type and uncleared bal
						<fo:table-row>
								<fo:table-cell>
									<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_AB_ACCOUNT_TYPE')" /></fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block><xsl:value-of select="./ACCOUNT_TYPE"/></fo:block>
								</fo:table-cell>
							<xsl:choose>
								<xsl:when test="./UNCLEARED_BALANCE">
									<fo:table-cell>
										<fo:block><xsl:value-of select="localization:getGTPString($language, 'AB_Uncleared_Balance')" /></fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block><xsl:value-of select="./UNCLEARED_BALANCE"/></fo:block>
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
							
						Row 5, Account Status and working bal
							<fo:table-row>
									<fo:table-cell>
									<fo:block><xsl:value-of select="localization:getGTPString($language, 'AB_Account_Status')" /></fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block><xsl:value-of select="./STATUS"/></fo:block>
								</fo:table-cell>
								<xsl:choose>
									<xsl:when test="./WORKING_BALANCE">
										<fo:table-cell>
											<fo:block><xsl:value-of select="localization:getGTPString($language, 'AB_Working_Balance')" /></fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block><xsl:value-of select="./WORKING_BALANCE"/></fo:block>
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
							
							Row 6, Account Branch and Available Balance 
							<fo:table-row>
								<xsl:choose>
									<xsl:when test="./BRANCH">
										<fo:table-cell>
											<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_AB_ACCOUNT_BRANCH')" /></fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block><xsl:value-of select="./BRANCH"/></fo:block>
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
								<xsl:choose>
									<xsl:when test="./AVAILABLE_BALANCE">
										<fo:table-cell>
											<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_AB_AVAILABLE_BALANCE')" /></fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block><xsl:value-of select="./AVAILABLE_BALANCE"/></fo:block>
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
							Row 7, Overdraft Facility and Total Float
							<fo:table-row>
								<xsl:choose>
									<xsl:when test="./OVERDRAFT_FACILITY">
										<fo:table-cell>
											<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_AB_OVERDRAFT_FACILITY')" /></fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block><xsl:value-of select="./OVERDRAFT_FACILITY"/></fo:block>
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
								<xsl:choose>
									<xsl:when test="./TOTAL_FLOAT">
										<fo:table-cell>
											<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_AB_TOTAL_FLOAT')" /></fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block><xsl:value-of select="./TOTAL_FLOAT"/></fo:block>
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
							Row 8, Overdraft Interest Rate
							<fo:table-row>
								<xsl:choose>
									<xsl:when test="./OVERDRAFT_INTEREST_RATE">
										<fo:table-cell>
											<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_AB_OVERDRAFT_INTEREST_RATE')" /></fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block><xsl:value-of select="./OVERDRAFT_INTEREST_RATE"/></fo:block>
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
								<fo:table-cell>
									<fo:block/>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block/>
								</fo:table-cell>
							</fo:table-row>	 -->				
						</xsl:for-each>
					</fo:table-body>
				</fo:table>
			</fo:block>
		</xsl:if>
	</xsl:template>
	
	<!-- Account Statement Movements only for External Accounts-->	
	<xsl:template name="account-statement-movements">
		<fo:block id="acctStatementMovements"/>
		<xsl:if test="(count(acct_statement_movements_data_pdf/array) &gt; 0)">	
			<fo:block xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider" white-space-collapse="false">
				<fo:table>
					<xsl:for-each select="acct_statement_movements_format_pdf/array">
						<fo:table-column>
							<xsl:attribute name="column-width">
                <xsl:value-of select="./column_width"/>
              </xsl:attribute>
						</fo:table-column>
					</xsl:for-each>
					<fo:table-header>
						<fo:table-row font-size="8.0pt" keep-with-next="always">
							<fo:table-cell number-columns-spanned="6">
								<xsl:call-template name="title_private">
									<xsl:with-param name="content">
										<xsl:value-of select="account_statement_movements_title"/>
									</xsl:with-param>
								</xsl:call-template>
							</fo:table-cell>
						</fo:table-row>
					  <fo:table-row background-color="#7692B7" color="white" font-weight="bold" margin="1pt" text-align="center">
					  	<xsl:if test="1 &gt; count(acct_statement_movements_format_pdf/array)">
						  	<fo:table-cell>
						      	<fo:block> </fo:block>
						    </fo:table-cell>
						</xsl:if>
					  	<xsl:for-each select="acct_statement_movements_format_pdf/array">
					  		<fo:table-cell>
						      	<fo:block>
						      		<xsl:value-of select="./column_label"/>
						      	</fo:block>
						    </fo:table-cell>
					  	</xsl:for-each>
					  </fo:table-row>
					</fo:table-header>
					<fo:table-body>
						<xsl:if test="1 &gt; count(acct_statement_movements_data_pdf/array)">
							<fo:table-row>
						  		<fo:table-cell>
							      	<fo:block> </fo:block>
							    </fo:table-cell>
						  	</fo:table-row>
						</xsl:if>
						<xsl:for-each select="acct_statement_movements_data_pdf/array">
							<xsl:variable name="position" select="position()"/>
							<xsl:variable name="parentData" select="."/>								
							<fo:table-row>
								<xsl:attribute name="background-color">
					      			<xsl:choose>
					      				<xsl:when test="$position mod 2 = 1">#CBE3FF</xsl:when>
					      				<xsl:otherwise>#F0F7FF</xsl:otherwise>
					      			</xsl:choose>
					      		</xsl:attribute>
								<xsl:for-each select="../../acct_statement_movements_format_pdf/array">
									<xsl:variable name="column-name">
                    <xsl:value-of select="translate(./column_name, ' &#9;&#13;&#10;', '')"/>
                  </xsl:variable>
									<xsl:variable name="alignment">
                    <xsl:value-of select="./column_alignment"/>
                  </xsl:variable>
									<xsl:variable name="column-width">
                    <xsl:value-of select="./column_width"/>
                  </xsl:variable>
									<fo:table-cell>
										<fo:block margin="1pt">
								      		<xsl:attribute name="text-align">
								      			<xsl:value-of select="$alignment"/>	
								      		</xsl:attribute>									      		
								      		<xsl:variable name="column-value">
                        <xsl:value-of select="$parentData/*[name() = $column-name]"/>
                      </xsl:variable>
								      		<xsl:call-template name="cr_replace">
								      			 <xsl:with-param name="input_text" select="$column-value"/>
								      		</xsl:call-template>
								      	</fo:block>
						      		</fo:table-cell>
							    </xsl:for-each>
							</fo:table-row>
						</xsl:for-each>
					</fo:table-body>
				</fo:table>
			</fo:block>	
		</xsl:if>
	</xsl:template>		
	

	<!--  Account Statement -->
	<xsl:template name="account-statement">
		<fo:block id="acctStatement"/>
		<xsl:if test="(count(acct_statement_table_data_pdf/array) &gt; 0)">	
			<fo:block xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider" white-space-collapse="false">
				<fo:table>
					<xsl:for-each select="acct_statement_table_format_pdf/array">
						<fo:table-column>
							<xsl:attribute name="column-width">
                <xsl:value-of select="./column_width"/>
              </xsl:attribute>
						</fo:table-column>
					</xsl:for-each>
					<fo:table-header>
						<fo:table-row keep-with-next="always">
							<fo:table-cell number-columns-spanned="6">
								<xsl:call-template name="title_private">
									<xsl:with-param name="content">
										<xsl:value-of select="account_statement_title"/>
									</xsl:with-param>
								</xsl:call-template>
							</fo:table-cell>
						</fo:table-row>
					  <fo:table-row background-color="#7692B7" color="white" font-weight="bold" margin="1pt" text-align="center">
					  	<xsl:if test="1 &gt; count(acct_statement_table_format_pdf/array)">
						  	<fo:table-cell>
						      	<fo:block> </fo:block>
						    </fo:table-cell>
						</xsl:if>
					  	<xsl:for-each select="acct_statement_table_format_pdf/array">
					  		<fo:table-cell>
						      	<fo:block>
						      		<xsl:value-of select="./column_label"/>
						      	</fo:block>
						    </fo:table-cell>
					  	</xsl:for-each>
					  </fo:table-row>
					</fo:table-header>
					<fo:table-body>
						<xsl:if test="1 &gt; count(acct_statement_table_data_pdf/array)">
							<fo:table-row>
						  		<fo:table-cell>
							      	<fo:block> </fo:block>
							    </fo:table-cell>
						  	</fo:table-row>
						</xsl:if>
						<xsl:for-each select="acct_statement_table_data_pdf/array">
							<xsl:variable name="position" select="position()"/>
							<xsl:variable name="parentData" select="."/>		
							<xsl:choose>
								<xsl:when test="$parentData/*[name() = 'Aggregate-0']">
									<fo:table-row>
										<xsl:attribute name="background-color">#D0D0D0</xsl:attribute>
										<fo:table-cell number-columns-spanned="3">
											<fo:block margin="1pt">
												<xsl:value-of select="./Aggregate-0"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block margin="1pt" text-align="right">
												<xsl:value-of select="./Aggregate-1"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block margin="1pt" text-align="right">
												<xsl:value-of select="./Aggregate-2"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:when>
								<xsl:otherwise>														
									<fo:table-row>
										<xsl:attribute name="background-color">
							      			<xsl:choose>
							      				<xsl:when test="$position mod 2 = 1">#CBE3FF</xsl:when>
							      				<xsl:otherwise>#F0F7FF</xsl:otherwise>
							      			</xsl:choose>
							      		</xsl:attribute>
										<xsl:for-each select="../../acct_statement_table_format_pdf/array">
											<xsl:variable name="column-name">
                        <xsl:value-of select="translate(./column_name, ' &#9;&#13;&#10;', '')"/>
                      </xsl:variable>
											<xsl:variable name="alignment">
                        <xsl:value-of select="./column_alignment"/>
                      </xsl:variable>
											<xsl:variable name="column-width">
                        <xsl:value-of select="./column_width"/>
                      </xsl:variable>
											<fo:table-cell>
												<fo:block margin="1pt">
										      		<xsl:attribute name="text-align">
										      			<xsl:value-of select="$alignment"/>	
										      		</xsl:attribute>									      		
										      		<xsl:variable name="column-value">
                            <xsl:value-of select="$parentData/*[name() = $column-name]"/>
                          </xsl:variable>
										      		<xsl:call-template name="cr_replace">
										      			 <xsl:with-param name="input_text" select="convertTools:wrapStringforPDF($column-width,$column-value)"/>
										      		</xsl:call-template>
										      	</fo:block>
								      		</fo:table-cell>
									    </xsl:for-each>
									</fo:table-row>
								</xsl:otherwise>
							</xsl:choose>	
						</xsl:for-each>
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
	</xsl:template>		
		
	<!-- TEMPLATE Carriage Return Replace -->
    <xsl:template name="cr_replace">
  		<xsl:param name="input_text"/>
		<xsl:variable name="cr">
      <xsl:text>
</xsl:text>
    </xsl:variable>
		<xsl:choose>
			<xsl:when test="contains($input_text,$cr)">
                 <!--Call the template in charge of replacing the spaces by NBSPs-->
                 <fo:block>
                 <xsl:value-of select="substring-before($input_text,$cr)"/>
        </fo:block>
                 <xsl:call-template name="cr_replace">
				 <xsl:with-param name="input_text" select="substring-after($input_text,$cr)"/>
                 </xsl:call-template>
            </xsl:when>
			<xsl:otherwise>
                <fo:block>
          <xsl:value-of select="$input_text"/>
        </fo:block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>	
    
<xsl:template name="header">
    <fo:static-content flow-name="xsl-region-before">
			<xsl:call-template name="header_account">
				<xsl:with-param name="headerTitle">XSL_HEADER_ACCOUNT_STATEMENT</xsl:with-param>
			</xsl:call-template>
		</fo:static-content>
  </xsl:template>
  <xsl:template name="body">
    <fo:flow flow-name="xsl-region-body" font-size="8.0pt">
			<fo:block id="accountStatement"/>
			<!-- Account Details and Statement -->	
			<xsl:call-template name="account-details"/>		
			<xsl:call-template name="account-statement-movements"/>
			<xsl:call-template name="account-statement"/>			
		</fo:flow>
  </xsl:template>
  <xsl:template name="footer">
    <fo:static-content flow-name="xsl-region-after">
			<fo:block font-family="{$pdfFont}" font-size="8.0pt" keep-together="always">
				<!-- Page number -->
				<fo:block color="{$footerFontColor}" font-weight="bold" text-align="start">
					<fo:page-number/> /
					<fo:page-number-citation>
						<xsl:attribute name="ref-id">
              <xsl:value-of select="concat('LastPage_',../@section)"/>
            </xsl:attribute>
					</fo:page-number-citation>
				</fo:block>
				<fo:block color="{$footerFontColor}" text-align="start">
					<xsl:attribute name="end-indent">
            <xsl:value-of select="number($pdfMargin)"/>pt</xsl:attribute>
					<xsl:value-of select="convertTools:internalDateToStringDate($systemDate,$language)"/>
				</fo:block>
			</fo:block>		
		</fo:static-content>
  </xsl:template>
</xsl:stylesheet>
