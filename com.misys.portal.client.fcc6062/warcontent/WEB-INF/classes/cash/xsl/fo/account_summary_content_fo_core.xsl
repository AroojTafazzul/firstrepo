<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;">]>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:java="http://xml.apache.org/xalan/java"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider">
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
	
	<!-- Account Summary -->	
	<xsl:template match="acct_summary_info">
	<xsl:param name="title_key"/>
	<xsl:variable name="arrayList1" select="java:java.util.ArrayList.new()"/>
	<xsl:variable name="void" select="java:add($arrayList1, concat('', (title)))"/>
	<xsl:variable name="args1" select="java:toArray($arrayList1)"/>
		<fo:block id="accountSummaryInfo" font-weight="bold" font-family="{$pdfFont}" font-size="14pt">
			<xsl:value-of select="localization:getFormattedString($language, $title_key, $args1)"/>
		</fo:block>
	</xsl:template>
	<xsl:template match="accountSummaryCurrent | accountSummarySavings | accountSummaryFixedTerm | accountSummaryLoan | accountSummaryExternal  | accountSummaryTreasury">
		<xsl:param name="title_key"/>
		<fo:block id="acctSummary.{name()}"/>
		<xsl:if test="(count(table_data_pdf/array) > 0)">	
			<fo:block xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider" white-space-collapse="false">
				<fo:table>
					<xsl:for-each select="table_format_pdf/array">
						<fo:table-column>
							<xsl:attribute name="column-width"><xsl:value-of select="./column_width"/></xsl:attribute>
						</fo:table-column>
					</xsl:for-each>
					<fo:table-header>
						<fo:table-row keep-with-next="always">
							<fo:table-cell number-columns-spanned="{count(table_format_pdf/array)}">
								<xsl:call-template name="title_private">
									<xsl:with-param name="content">
										<xsl:value-of select="localization:getGTPString($language, $title_key)"/>
									</xsl:with-param>
								</xsl:call-template>
							</fo:table-cell>
						</fo:table-row>
					  <fo:table-row margin="1pt" font-weight="bold" background-color="{$backgroundTitles}" text-align="center" color="white">
					  	<xsl:if test="1 > count(table_format_pdf/array)">
						  	<fo:table-cell>
						      	<fo:block>&nbsp;</fo:block>
						    </fo:table-cell>
						</xsl:if>
					  	<xsl:for-each select="table_format_pdf/array">
					  		<fo:table-cell>
						      	<fo:block>
						      		<xsl:value-of select="./column_label"></xsl:value-of>
						      	</fo:block>
						    </fo:table-cell>
					  	</xsl:for-each>
					  </fo:table-row>
					</fo:table-header>
					<fo:table-body>
						<xsl:if test="1 > count(table_data_pdf/array)">
							<fo:table-row>
						  		<fo:table-cell>
							      	<fo:block>&nbsp;</fo:block>
							    </fo:table-cell>
						  	</fo:table-row>
						</xsl:if>
						<xsl:for-each select="table_data_pdf/array">
							<xsl:variable name="position" select="position()"/>
							<xsl:variable name="parentData" select="."/>		
							<xsl:choose>
								<xsl:when test="$parentData/*[name() = 'aggregate-0']">
									<fo:table-row>
										<xsl:attribute name="background-color">#D0D0D0</xsl:attribute>
										<fo:table-cell number-columns-spanned="{count(../../table_format_pdf/array)-1}">
											<fo:block margin="1pt">
												<xsl:value-of select="./aggregate-0"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block margin="1pt" text-align="right">
												<xsl:value-of select="./aggregate-1"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block margin="1pt" text-align="right">
												<xsl:value-of select="./aggregate-2"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:when>
								<xsl:otherwise>														
									<fo:table-row>
										<xsl:attribute name="background-color">
							      			<xsl:choose>
							      				<xsl:when test="$position mod 2 = 1"><xsl:value-of select="$tableRowOddColor"/></xsl:when>
							      				<xsl:otherwise><xsl:value-of select="$tableRowEvenColor"/></xsl:otherwise>
							      			</xsl:choose>
							      		</xsl:attribute>
										<xsl:for-each select="../../table_format_pdf/array">
											<xsl:variable name="column-name-before-trim">
												<xsl:choose>
													<xsl:when test="contains(./column_name, '(')">
														<xsl:value-of select="substring-before(./column_name, '(')"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="./column_name"/>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<xsl:variable name="column-name"><xsl:value-of select="translate($column-name-before-trim, '&#x20;&#x9;&#xD;&#xA;', '')"/></xsl:variable>
											<xsl:variable name="alignment"><xsl:value-of select="./column_alignment"/></xsl:variable>
											<xsl:variable name="column-width"><xsl:value-of select="./column_width"/></xsl:variable>
											<fo:table-cell>
												<fo:block margin="1pt">
										      		<xsl:attribute name="text-align">
										      			<xsl:value-of select="$alignment"/>	
										      		</xsl:attribute>									      		
										      		<xsl:variable name="column-value"><xsl:value-of select="$parentData/*[name() = $column-name]"/></xsl:variable>
										      		<xsl:call-template name="cr_replace">
										      			 <xsl:with-param name="input_text" select="$column-value"/>
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
	</xsl:template>

	<!-- TEMPLATE Carriage Return Replace -->
    <xsl:template name="cr_replace">
  		<xsl:param name="input_text"/>
		<xsl:variable name="cr"><xsl:text>&#xa;</xsl:text></xsl:variable>
		<xsl:choose>
			<xsl:when test="contains($input_text,$cr)">
                 <!--Call the template in charge of replacing the spaces by NBSPs-->
                 <fo:block>
                 <xsl:value-of select="substring-before($input_text,$cr)"/></fo:block>
                 <xsl:call-template name="cr_replace">
				 <xsl:with-param name="input_text" select="substring-after($input_text,$cr)"/>
                 </xsl:call-template>
            </xsl:when>
			<xsl:otherwise>
                <fo:block><xsl:value-of select="$input_text"></xsl:value-of></fo:block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>	
    
<xsl:template name="header">
    <fo:static-content flow-name="xsl-region-before">
			<xsl:call-template name="header_account">
				<xsl:with-param name="headerTitle">XSL_HEADER_ACCOUNT_SUMMARY</xsl:with-param>
			</xsl:call-template>
		</fo:static-content>
  </xsl:template>
  <xsl:template name="body">
    <fo:flow flow-name="xsl-region-body" font-size="8.0pt">
			<fo:block id="accountSummary"/>
			<!-- Account Summary -->
			<xsl:apply-templates select="acct_summary_info">
				<xsl:with-param name="title_key">ACCOUNT_SUMMARY_INFORMATION</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="accountSummaryCurrent">
				<xsl:with-param name="title_key">PORTLET_accountSummaryCurrent</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="accountSummarySavings">
				<xsl:with-param name="title_key">PORTLET_accountSummarySavings</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="accountSummaryFixedTerm">
				<xsl:with-param name="title_key">PORTLET_accountSummaryFixedTerm</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="accountSummaryLoan">
				<xsl:with-param name="title_key">PORTLET_accountSummaryLoan</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="accountSummaryExternal">
				<xsl:with-param name="title_key">PORTLET_accountSummaryExternal</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="accountSummaryTreasury">
			<xsl:with-param name="title_key">PORTLET_accountSummaryTreasury</xsl:with-param>
			</xsl:apply-templates>
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
					<fo:page-number/> /
					<fo:page-number-citation>
						<xsl:attribute name="ref-id">
                                        <xsl:value-of select="concat('LastPage_',../@section)"/>
                                        </xsl:attribute>
					</fo:page-number-citation>
				</fo:block>
				<!-- <fo:block text-align="start" color="#7692B7">
					<xsl:attribute name="end-indent"><xsl:value-of select="number($pdfMargin)" />pt</xsl:attribute>
					<xsl:value-of
						select="convertTools:internalDateToStringDate($systemDate,$language)" />
				</fo:block> -->
			</fo:block>
		</fo:static-content>
  </xsl:template>
</xsl:stylesheet>
