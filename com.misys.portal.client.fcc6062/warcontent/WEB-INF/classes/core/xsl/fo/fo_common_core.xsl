<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
	]>
<!--
	Copyright (c) 2000-2013 Misys (http://www.misys.com), All
	Rights Reserved.
-->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider"
xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
xmlns:fo="http://www.w3.org/1999/XSL/Format"
xmlns:common="http://exslt.org/common"
xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
exclude-result-prefixes="localization utils colorresource defaultresource security ">

	<xsl:param name="pdf_logo_url"/>
	<!--
		*********************************************************************
		This stylesheet has the common functions,colours used by the XSL-FO
		stylesheets used in products transactions to generate
		PDF documents details popups,
		*********************************************************************
	-->

	<!-- Backgound Colours common to all Fo stylesheets-->

	<xsl:variable name="backgroundSubtitles3">#<xsl:value-of
		select="colorresource:getResource('row_pdf_title3')" /></xsl:variable>
	<xsl:variable name="backgroundSubtitles">#<xsl:value-of
		select="colorresource:getResource('row_pdf_title2')" /></xsl:variable>
	<xsl:variable name="backgroundTitles">
		<xsl:choose>
			<xsl:when test="defaultresource:getResource('ANGULAR_HOMEPAGE') = 'true'">#<xsl:value-of select="colorresource:getResource('fccui_background_color')"/></xsl:when>
			<xsl:otherwise>#<xsl:value-of select="colorresource:getResource('row_pdf_title1')"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="fontColorTitles">
		<xsl:choose>
			<xsl:when test="defaultresource:getResource('ANGULAR_HOMEPAGE') = 'true'">#<xsl:value-of select="colorresource:getResource('fccui_pdf_font_title1')"/></xsl:when>
			<xsl:otherwise>#<xsl:value-of select="colorresource:getResource('row_pdf_font_title1')"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="titlePrivateBorderSize">
		<xsl:choose>
			<xsl:when test="defaultresource:getResource('ANGULAR_HOMEPAGE') = 'true'">1px</xsl:when>
			<xsl:otherwise>2px</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="titlePrivateFontSize">
		<xsl:choose>
			<xsl:when test="defaultresource:getResource('ANGULAR_HOMEPAGE') = 'true'">13pt</xsl:when>
			<xsl:otherwise>16pt</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="footerFontColor">
		<xsl:choose>
			<xsl:when test="defaultresource:getResource('ANGULAR_HOMEPAGE') = 'true'">#<xsl:value-of select="colorresource:getResource('fccui_pdf_footer_color')"/></xsl:when>
			<xsl:otherwise>#<xsl:value-of select="colorresource:getResource('row_pdf_font_title1')"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="tableheaderbckgrcol">#<xsl:value-of
		select="colorresource:getResource('row_pdf_table_hcol_bckgrd')"
		/></xsl:variable>
		<xsl:variable name="backgroundImage">
		<xsl:if test="defaultresource:getResource('GTP_PDF_BACKGROUND_IMG_DISPLAY') = 'true'">  
 		url('<xsl:value-of select="$base_url"/><xsl:value-of select="defaultresource:getResource('GTP_PDF_BACKGROUND_IMG_PATH')" />')
 		</xsl:if>
 		</xsl:variable>
 	<xsl:variable name="background">
		BLACK
	</xsl:variable>
	<!-- 
		Defines the language writting dirrection
		To change tables details and label position
	 -->
	<xsl:variable name="rtlwriting" select="translate(localization:getGTPString($language, 'TEXT_DIRECTION'), 'rtl', 'RTL') = 'RTL'" />
	<xsl:variable name="writingMode">
		<xsl:choose>
			<xsl:when test="$rtlwriting">rl-tb</xsl:when>
			<xsl:otherwise>lr-tb</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="horizontalAlign">
		<xsl:choose>
			<xsl:when test="$rtlwriting">left</xsl:when>
			<xsl:otherwise>right</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:param name="header33Image">url('<xsl:value-of select="$base_url" />/fo_icons/header_33px.jpg')</xsl:param>
	<xsl:param name="headerImage">url('<xsl:value-of select="$base_url" />/fo_icons/header.jpg')</xsl:param>
	<xsl:variable name="backgroundTitleImages"><xsl:value-of select="utils:getImagePath($header33Image)"></xsl:value-of></xsl:variable>
	<xsl:variable name="backgroundHeader"><xsl:value-of select="utils:getImagePath($headerImage)"></xsl:value-of></xsl:variable>

	<!-- Size and fonts common to all Fo stylesheets-->
	<xsl:variable name="pageHeight"><xsl:value-of select="defaultresource:getResource('PDF_PAGE_HEIGHT')" /></xsl:variable>
	<xsl:variable name="pageWidth"><xsl:value-of select="defaultresource:getResource('PDF_PAGE_WIDTH')" /></xsl:variable>
	<xsl:variable name="pdfFont"><xsl:value-of select="defaultresource:getFOFont('PDF_LABEL_FONT', $language)" /></xsl:variable>
	<xsl:variable name="pdfFontData"><xsl:value-of select="defaultresource:getFOFont('PDF_DATA_FONT', $language)" /></xsl:variable>
	<xsl:variable name="pdfFontSize"><xsl:value-of select="defaultresource:getResource('PDF_FONT_SIZE')" /></xsl:variable>
	<xsl:variable name="pdfMargin"><xsl:value-of
			select="substring-before(defaultresource:getResource('PDF_PRODUCT_DETAILS_MARGIN'),'pt')" /></xsl:variable>
	<xsl:variable name="pageDetailsWidth"><xsl:value-of select="substring-before($pageWidth,'pt')" /></xsl:variable>
	<xsl:variable name="leftTextColor"><xsl:value-of select="defaultresource:getResource('LEFT_TEXT_COLOR')" /></xsl:variable>
	<xsl:variable name="labelColumnWidth"><xsl:value-of
			select="defaultresource:getResource('PDF_PRODUCT_COLUMN_LABEL_WIDTH')" /></xsl:variable>
	<xsl:variable name="detailsColumnWidth"><xsl:value-of select="defaultresource:getResource('PDF_PRODUCT_COLUMN_DETAILS_WIDTH')" /></xsl:variable>
	<!--  for testing only -->
	<xsl:variable name="borderColor">
		<xsl:choose>
			<xsl:when test="defaultresource:getResource('ANGULAR_HOMEPAGE') = 'true'">#<xsl:value-of select="colorresource:getResource('fccui_border_color')"/></xsl:when>
			<xsl:otherwise>#<xsl:value-of select="colorresource:getResource('row_pdf_border')"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<!-- Defines region body margins for first page and the other (default) pages -->
	<xsl:variable name="defaultBodyMarginRight">0pt</xsl:variable>
	<xsl:variable name="defaultBodyMarginLeft">10pt</xsl:variable>
	<xsl:variable name="defaultBodyMarginBottom">16pt</xsl:variable>
	<xsl:variable name="defaultBodyMarginTop">0pt</xsl:variable>

	<xsl:variable name="firstPageBodyMarginRight">0pt</xsl:variable>
	<xsl:variable name="firstPageBodyMarginLeft">10pt</xsl:variable>
	<xsl:variable name="firstPageBodyMarginBottom">16pt</xsl:variable>
	<xsl:variable name="firstPageBodyMarginTop">140pt</xsl:variable>
	
	<!--
		xsl:variable name="pdfTableWidth"><xsl:value-of select
		="(number($pageDetailsWidth))-(number($pdfMargin)*4)"
		/>pt</xsl:variable
	-->
	
	<xsl:variable name="pdfTableWidth">100%</xsl:variable>
	<xsl:variable name="pdfNestedTableWidth">105%</xsl:variable>
	<xsl:variable name="nestedLabelColumnWidth">105%</xsl:variable>
	<xsl:variable name="nestedDetailsColumnWidth">105%</xsl:variable>
	<xsl:variable name="swift2018Enabled" select="defaultresource:isSwift2018Enabled()"/>
	<xsl:variable name="swift2019Enabled" select="defaultresource:isSwift2019Enabled()"/>
	<xsl:variable name="confirmationChargesEnabled" select="defaultresource:getResource('CONFIRMATION_CHARGES_ENABLED')"/>
	<xsl:param name="warningImage">url('{$base_url}/fo_icons/warning.gif')</xsl:param>
	
	<xsl:variable name="tableRowOddColor">
		<xsl:choose>
			<xsl:when test="defaultresource:getResource('ANGULAR_HOMEPAGE') = 'true'">#<xsl:value-of select="colorresource:getResource('white')"/></xsl:when>
			<xsl:otherwise>#CBE3FF</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="tableRowEvenColor">
		<xsl:choose>
			<xsl:when test="defaultresource:getResource('ANGULAR_HOMEPAGE') = 'true'">#<xsl:value-of select="colorresource:getResource('fccui_row_even_color')"/></xsl:when>
			<xsl:otherwise>#F0F7FF</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<!-- *************** -->
	<!-- Spacer template -->
	<!-- *************** -->
	<xsl:template name="spacer_template">
		<fo:block space-before.optimum="10.0pt"/>
	</xsl:template>
	
	<!-- ******************* -->
	<!-- Disclammer template -->
	<!-- ******************* -->
	<xsl:template name="disclammer_template">
		<fo:block border-top="{$borderColor} solid 1px"
			border-bottom="{$borderColor} solid 1px">
			<xsl:choose>
				<xsl:when
					test="tnx_type_code[.='15'] or tnx_type_code[.='03'] or tnx_type_code[.='13'] or tnx_type_code[.='86'] or tnx_type_code[.='87'] or (product_code[.='FX'] and prod_stat_code[.='03']) or (product_code[.='TD'] and (sub_product_code[.='TRTD'] or sub_product_code[.='CSTD'] )) or (product_code[.='FT'] and (sub_product_code[.='TRINT'] or sub_product_code[.='TRTPT'])) or (product_code[.='LN'] and prod_stat_code[.='03' or .='07' or .='77']) or (product_code[.='BK'] and prod_stat_code[.='03'])">
					<xsl:call-template name="product_summary" />
					<fo:block break-after="page" />
					<xsl:call-template name="disclaimer" />
				</xsl:when>
				<!--Insert the Disclaimer Notice-->
				<xsl:when test="(not(tnx_id) or tnx_type_code[.!='01']) and not(product_code[.='IO'] and tnx_type_code[.='38'])">
					<xsl:call-template name="disclaimer" />
				</xsl:when>
				<!--Insert the transaction summary-->
				<xsl:otherwise>
					<xsl:call-template name="product_summary" />
					<fo:block break-after="page" />
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test = "(product_code[.='IO'] or product_code[.='EA']) and error_msg != ''">
				<xsl:call-template name="warning" />
			</xsl:if>
		</fo:block>
	</xsl:template>

	<!-- ************** -->
	<!-- Table template -->
	<!-- ************** -->
	<xsl:template name="table_template">
		<xsl:param name="text" />
		<fo:block white-space-collapse="true">
			<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
				<fo:table-column column-width="{$labelColumnWidth}" />
				<fo:table-column column-width="{$detailsColumnWidth}" />
				<fo:table-body>
					<xsl:copy-of select="$text" />
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<!-- ******************************* -->
	<!-- Table template (1col)			 -->
	<!-- ******************************* -->
	<xsl:template name="table_template2">
		<xsl:param name="text" />
		<fo:table width="{$pdfTableWidth}" font-size="{$pdfFontSize}"
				  font-family="{$pdfFontData}" table-layout="fixed">
			<fo:table-column column-width="{$pdfTableWidth}" />
			<fo:table-column column-width="0"/><!-- dummy column -->
			<fo:table-body>
				<xsl:copy-of select="$text" />
			</fo:table-body>
		</fo:table>
	</xsl:template>

	<!-- ***************************** -->
	<!-- Title Common Aspect (private) -->
	<!-- ***************************** -->
	<xsl:template name="title_private">
		<xsl:param name="content" />
		<xsl:param name ="backGroundTitles">url('<xsl:value-of select="$base_url" />/fo_icons/backgroundtitles.jpg')</xsl:param>
		<fo:block border-bottom="{$borderColor} solid {$titlePrivateBorderSize}"
				  space-before.optimum="20.0pt" space-before.conditionality="retain"
				  space-after.optimum="10.0pt" space-after.conditionality="retain" >
			<xsl:attribute name="background-image"><xsl:value-of select="utils:getImagePath($backGroundTitles)"></xsl:value-of></xsl:attribute>
			<fo:block space-before.optimum="5.0pt" 
					  space-before.conditionality="retain" space-after.optimum="5.0pt"
					  space-after.conditionality="retain" color="{$fontColorTitles}"
					  font-weight="bold" font-family="{$pdfFont}" font-size="{$titlePrivateFontSize}">
				<xsl:copy-of select="$content" />
			</fo:block>
		</fo:block>
	</xsl:template>

	<!-- ******************************** -->
	<!-- Subtitle Common Aspect (private) -->
	<!-- ******************************** -->
	<xsl:template name="subtitle_private">
		<xsl:param name="content" />
		<fo:block space-before.optimum="10.0pt" background-color="#ffffff"
				  space-before.conditionality="retain" space-after.optimum="10.0pt"
				  space-after.conditionality="retain" font-weight="bold" font-family="{$pdfFont}"
				  border-top="{$borderColor} solid 1px" border-bottom="{$borderColor} solid 1px">
			<fo:block start-indent="20.0pt" end-indent="20.0pt">
				<xsl:copy-of select="$content" />
			</fo:block>
		</fo:block>
	</xsl:template>

	<!-- *********** -->
	<!-- Table Title -->
	<!-- *********** -->
	<xsl:template name="title">
		<xsl:param name="text" />
		<fo:table-row keep-with-next="always">
			<fo:table-cell number-columns-spanned="2">
				<xsl:call-template name="title_private">
					<xsl:with-param name="content">
						<xsl:copy-of select="$text" />
					</xsl:with-param>
				</xsl:call-template>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<!-- ********************************* -->
	<!-- Table Title 2 (for one col table) -->
	<!-- ********************************* -->
	<xsl:template name="title2">
		<xsl:param name="text" />
		<fo:table-row keep-with-next="always">
			<fo:table-cell number-columns-spanned="2">
				<xsl:call-template name="title_private">
					<xsl:with-param name="content">
						<xsl:copy-of select="$text" />
					</xsl:with-param>
				</xsl:call-template>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<!-- ************** -->
	<!-- Table Subtitle -->
	<!-- ************** -->
	<xsl:template name="subtitle">
		<xsl:param name="text" />
		<fo:table-row keep-with-next="always">
			<fo:table-cell number-columns-spanned="2">
				<xsl:call-template name="subtitle_private">
					<xsl:with-param name="content">
						<xsl:copy-of select="$text" />
					</xsl:with-param>
				</xsl:call-template>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<!-- ************************************ -->
	<!-- Table Subtitle 2 (for one col table) -->
	<!-- ************************************ -->
	<xsl:template name="subtitle2">
		<xsl:param name="text" />
		<fo:table-row keep-with-next="always">
			<fo:table-cell number-columns-spanned="2">
				<xsl:call-template name="subtitle_private">
					<xsl:with-param name="content">
						<xsl:copy-of select="$text" />
					</xsl:with-param>
				</xsl:call-template>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<!-- ******************************** -->
	<!-- Table row with two cols template -->
	<!-- ******************************** -->
	<xsl:template name="table_cell">
		<xsl:param name="left_text" />
		<xsl:param name="right_text" />
		<fo:table-row>
			<fo:table-cell keep-together="always">
				<fo:block start-indent="40.0pt" font-family="{$pdfFont}">
					<xsl:copy-of select="$left_text" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell keep-together="always" font-weight="bold">
				<fo:block>
					<xsl:choose>
						<xsl:when test="defaultresource:isIBEXFOService()">
							<xsl:copy-of select="$right_text"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="zero_width_space_1">
							    <xsl:with-param name="data"><xsl:copy-of select="$right_text"/></xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
	
	<!-- ******************************** -->
	<!-- Table row with two cols template -->
	<!-- ******************************** -->
	<xsl:template name="table_cell_1">
		<xsl:param name="left_text" />
		<xsl:param name="right_text" />
		<fo:table-row>
			<fo:table-cell keep-together="always">
				<fo:block start-indent="40.0pt" font-family="{$pdfFont}">
					<xsl:copy-of select="$left_text" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell linefeed-treatment="preserve" keep-together="always" font-weight="bold" white-space="pre">
				<fo:block>
					<xsl:copy-of select="$right_text" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<!-- ******************************* -->
	<!-- Table row with one col template -->
	<!-- ******************************* -->
	<xsl:template name="table_cell2">
		<xsl:param name="text" />
		<fo:table-row keep-with-previous="always" >
			<fo:table-cell number-columns-spanned="2">
				<fo:block linefeed-treatment="preserve" white-space-collapse="false" font-weight="bold"
					space-before.conditionality="retain" start-indent="40.0pt">
					<xsl:copy-of select="$text" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
	
	<!-- ******************************************* -->
	<!-- Table row with two col bold template        -->
	<!-- ******************************************* -->
	
	<xsl:template name="table_cell3">
		<xsl:param name="left_text3" />
		<xsl:param name="right_text" />
		<fo:table-row>
			<fo:table-cell keep-together="always" font-weight="bold">
				<fo:block start-indent="40.0pt" font-family="{$pdfFont}">
					<xsl:copy-of select="$left_text3" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell keep-together="always" font-weight="bold">
				<fo:block>
					<xsl:choose>
						<xsl:when test="defaultresource:isIBEXFOService()">
							<xsl:copy-of select="$right_text"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="zero_width_space_1">
							    <xsl:with-param name="data"><xsl:copy-of select="$right_text"/></xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<!-- *********** -->
	<!-- Table Title For Amount Details -->
	<!-- *********** -->
	<xsl:template name="title_amt_details">
		<xsl:param name="text" />
		<fo:table-row keep-with-next="always">
			<fo:table-cell number-columns-spanned="2">
				<xsl:call-template name="title_private_amt_details">
					<xsl:with-param name="content">
						<xsl:copy-of select="$text" />
					</xsl:with-param>
				</xsl:call-template>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>


	<!-- ***************************** -->
	<!-- Title Common Aspect (private) For Amount Details -->
	<!-- ***************************** -->
	<xsl:template name="title_private_amt_details">
		<xsl:param name ="backGroundTitles">url('<xsl:value-of select="$base_url" />/fo_icons/backgroundtitles.jpg')</xsl:param>
	
		<xsl:param name="content" />
		<fo:block border-bottom="{$borderColor} solid 2px"
				  space-before.optimum="20.0pt" space-before.conditionality="retain"
				  space-after.optimum="10.0pt" space-after.conditionality="retain" >
			<xsl:attribute name="background-image"><xsl:value-of select="utils:getImagePath($backGroundTitles)"></xsl:value-of></xsl:attribute>
			<fo:block space-before.optimum="5.0pt" id="AmountDetails"
					  space-before.conditionality="retain" space-after.optimum="5.0pt"
					  space-after.conditionality="retain" color="{$borderColor}"
					  font-weight="bold" font-family="{$pdfFont}" font-size="16pt">
				<xsl:copy-of select="$content" />
			</fo:block>
		</fo:block>
	</xsl:template>

	<!-- ***************** -->
	<!-- Disclaimer Notice -->
	<!-- ***************** -->
	<xsl:template name="disclaimer">
	<xsl:param name="backWarningImage">url('<xsl:value-of select="$base_url" />/fo_icons/back_warn.jpg</xsl:param>
		<fo:table background-color="#ffffff"
				  table-layout="fixed" background-image="utils:getImagePath($backWarningImage)">
			<fo:table-column column-width="10%" />
			<fo:table-column column-width="90%" />
			<fo:table-body>
				<fo:table-row>
				<!-- Warning symbol -->
					<fo:table-cell width="2cm">
						<fo:block>
							<fo:external-graphic content-height="2cm" content-width="2cm" src="url('{$base_url}/fo_icons/warning.gif')" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block keep-together="always" font-size="9pt" white-space-collapse="false">
							<fo:block font-family="{$pdfFont}" font-weight="bold" 
									  space-before.optimum="10.0pt" space-before.conditionality="retain">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTING_DISCLAIMER_LABEL')" />
							</fo:block>
							<fo:block font-family="{$pdfFont}" space-after.optimum="50.0pt"
								space-before.conditionality="retain">
								<xsl:call-template name ="tokenize-string">
							   		<xsl:with-param name ="text"><xsl:value-of select ="localization:getGTPString($language, 'XSL_REPORTING_DISCLAIMER')"/></xsl:with-param>
							   		<xsl:with-param name ="delimiter">.</xsl:with-param>
							 	</xsl:call-template>
							 </fo:block>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
	</xsl:template>
	
	<xsl:template name="warning">
	<xsl:param name="backWarningImage">url('<xsl:value-of select="$base_url" />/fo_icons/back_warn.jpg</xsl:param>
		<fo:table background-color="#ffffff"
				  table-layout="fixed" background-image="utils:getImagePath($backWarningImage)">
			<fo:table-column column-width="10%" />
			<fo:table-column column-width="90%" />
			<fo:table-body>
				<fo:table-row>
				<!-- Warning symbol -->
					<fo:table-cell width="2cm">
						<fo:block>
							<fo:external-graphic content-height="2cm" content-width="2cm" src="url('{$base_url}/fo_icons/warning.gif')" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block keep-together="always" font-size="9pt" white-space-collapse="false">
							<fo:block font-family="{$pdfFont}" font-weight="bold" 
									  space-before.optimum="10.0pt" space-before.conditionality="retain">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_WARNINGS')" />
							</fo:block>
							<fo:block font-family="{$pdfFont}" space-after.optimum="50.0pt"
								space-before.conditionality="retain">
								<xsl:call-template name ="tokenize-string">
							   		<xsl:with-param name ="text"><xsl:value-of select ="error_msg"/></xsl:with-param>
							   		<xsl:with-param name ="delimiter">:</xsl:with-param>
							   	</xsl:call-template>	
							</fo:block>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
	</xsl:template>

	<!-- ****************** -->
	<!-- Bank logo Template -->
	<!-- ****************** -->
		<xsl:template name="bank_logo">
		<xsl:param name="bankName" />
		<fo:block start-indent="{number($pdfMargin)}pt">
			<xsl:if test="defaultresource:getResource('GTP_PDF_LOGO_DISPLAY') = 'true'">  
			<fo:external-graphic content-height="1.5cm" content-width="3.5cm">
				<xsl:attribute name="src">
                    <xsl:choose>
                   		<xsl:when test="$isdynamiclogo='true'">url('<xsl:value-of
								select="$base_url" />/advices/<xsl:value-of
								select="$bankName" />.gif')</xsl:when>
                   		<xsl:when test="$pdf_logo_url and $pdf_logo_url != ''">url('<xsl:value-of select="$pdf_logo_url"/>')</xsl:when>
						<xsl:otherwise>url('<xsl:value-of select="$base_url" />/advices/logo.gif')</xsl:otherwise>
					</xsl:choose>
                </xsl:attribute>
			</fo:external-graphic>
			</xsl:if>
		</fo:block>
		
	</xsl:template>

	<!-- **************** -->
	<!-- Common Templates -->
	<!-- **************** -->
	<!-- TEMPLATE Single Quote String Replace -->
	<xsl:template name="quote_replace">
		<xsl:param name="input_text" />
		<xsl:variable name="squote">
			<xsl:text>'</xsl:text>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="contains($input_text,$squote)">
				<xsl:value-of select="substring-before($input_text,$squote)" />
				\
				<xsl:value-of select="$squote" />
				<xsl:call-template name="quote_replace">
					<xsl:with-param name="input_text"
						select="substring-after($input_text,$squote)" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$input_text" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- TEMPLATE Space String Replace -->
	<xsl:template name="space_replace">
		<xsl:param name="input_text" />
		<xsl:choose>
			<xsl:when test="contains($input_text,' ')">
				<xsl:value-of select="substring-before($input_text,' ')" />
				<xsl:text>&nbsp;</xsl:text>
				<xsl:call-template name="space_replace">
					<xsl:with-param name="input_text"
						select="substring-after($input_text,' ')" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$input_text" />
			</xsl:otherwise>
		</xsl:choose>
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
	
	<!-- ************* -->
	<!-- List template -->
	<!-- ************* -->
	<xsl:template name="list_item" >
		<xsl:param name="item" />
		<fo:table width="100%" space-before="5pt" space-after="5pt" table-layout="fixed">
			<fo:table-column column-width="1cm" />
			<fo:table-column />
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell><fo:block font-family="{$pdfFontData}">&#x2022;</fo:block></fo:table-cell>
					<fo:table-cell><fo:block font-family="{$pdfFontData}"><xsl:copy-of select="$item" /></fo:block></fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
	</xsl:template>

	<!-- **************** -->
	<!-- Header templates -->
	<!-- **************** -->
	
	<xsl:template name="header_presenting_bank">
		<xsl:call-template name="header_bank">
			<xsl:with-param name="bankNode" select="presenting_bank" />
			<xsl:with-param name="productCode" select="product_code[.]" />
		</xsl:call-template>		
	</xsl:template>

	<xsl:template name="header_remitting_bank">
		<xsl:call-template name="header_bank">
			<xsl:with-param name="bankNode" select="remitting_bank" />
			<xsl:with-param name="productCode" select="product_code[.]" />
		</xsl:call-template>		
	</xsl:template>

	<xsl:template name="header_advising_bank">
		<xsl:call-template name="header_bank">
			<xsl:with-param name="bankNode" select="advising_bank" />
			<xsl:with-param name="productCode" select="product_code[.]" />
		</xsl:call-template>		
	</xsl:template>
	
	<xsl:template name="header_issuing_bank">
		<xsl:call-template name="header_bank">
			<xsl:with-param name="bankNode" select="issuing_bank" />
			<xsl:with-param name="productCode" select="product_code[.]" />
			<xsl:with-param name="subProductCode" select="sub_product_code[.]" />
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="header_recipient_bank">
		<xsl:call-template name="header_bank">
			<xsl:with-param name="bankNode" select="recipient_bank" />
			<xsl:with-param name="productCode" select="product_code[.]" />
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="header_account">
		<xsl:param name="headerTitle"/>
		<xsl:call-template name="header_bank">
			<xsl:with-param name="bankNode" select="bank_details/array" />
			<xsl:with-param name="headerTitle" select="$headerTitle" />
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="header_bank">
		<xsl:param name="bankNode" />
		<xsl:param name="productCode" />
		<xsl:param name="subProductCode" />
		<xsl:param name="headerImage">url('<xsl:value-of select="$base_url" />/fo_icons/header.jpg')</xsl:param>
		<xsl:for-each select="$bankNode">
			<fo:block font-family="{$pdfFont}" color="{$backgroundSubtitles3}">
				<fo:table  background-position-horizontal="{$horizontalAlign}"
						   background-position-vertical="top"
						   table-layout="fixed" 
						   background-image="utils:getImagePath($headerImage)" >
					<fo:table-column column-width="proportional-column-width(1)" />
					<fo:table-column column-width="proportional-column-width(1)" />
					<xsl:if test="name[. != '']">
						<fo:table-column column-width="proportional-column-width(1)" />
						<xsl:if test="phone[. != ''] or  fax[. != ''] or telex[. != ''] or  iso_code[. != '']">
							<fo:table-column column-width="proportional-column-width(1)" />
						</xsl:if>
					</xsl:if>
					
					<xsl:if test="$productCode != '' and $subProductCode = ''">
						<fo:table-column column-width="proportional-column-width(1)" />
					</xsl:if>
					<xsl:if test="$subProductCode != 'SMP'">
							<fo:table-column column-width="proportional-column-width(1)" />
					</xsl:if>
					
					<fo:table-body>
						<fo:table-row>
							<!-- Bank logo -->
							<fo:table-cell>
								<xsl:call-template name="bank_logo">
								<xsl:with-param name="bankName" select="abbv_name" />
								</xsl:call-template>
							</fo:table-cell>
							<fo:table-cell>
							 <fo:block>
								  &nbsp;
							 </fo:block>
							</fo:table-cell>   
							<xsl:if test="name[.!='']">
								<fo:table-cell font-size="8.0pt">
									<fo:block>
										<xsl:value-of select="name" />
									</fo:block>
									<xsl:if test="address_line_1[.!='']">
										<fo:block>
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data" select="address_line_1"/>
											</xsl:call-template>
										</fo:block>
									</xsl:if>
									<xsl:if test="address_line_2[.!='']">
										<fo:block>
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data" select="address_line_2"/>
											</xsl:call-template>
										</fo:block>
									</xsl:if>
									<xsl:if test="dom[.!='']">
										<fo:block>
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data" select="dom"/>
											</xsl:call-template>
										</fo:block>
									</xsl:if>
									<xsl:if test="address_line_4[.!='']">
										<fo:block>
											<xsl:call-template name="zero_width_space_1">
											    <xsl:with-param name="data" select="address_line_4"/>
											</xsl:call-template>
										</fo:block>
									</xsl:if>
								</fo:table-cell>
								<xsl:if test="phone[.!=''] or fax[.!=''] or telex[.!=''] or iso_code[.!='']">
									<fo:table-cell font-size="8.0pt">
										<xsl:if test="phone[.!='']">
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FO_COMMON_PHONE')" />
												<xsl:call-template name="zero_width_space_1">
											    	<xsl:with-param name="data" select="phone"/>
												</xsl:call-template>
											</fo:block>
										</xsl:if>
										<xsl:if test="fax[.!='']">
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FO_COMMON_FAX')" />
												<xsl:call-template name="zero_width_space_1">
											    	<xsl:with-param name="data" select="fax"/>
												</xsl:call-template>
											</fo:block>
										</xsl:if>
										<xsl:if test="telex[.!='']">
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FO_COMMON_TELEX')" />
												<xsl:call-template name="zero_width_space_1">
											    	<xsl:with-param name="data" select="telex"/>
												</xsl:call-template>
											</fo:block>
										</xsl:if>
										<xsl:if test="iso_code[.!='']">
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FO_COMMON_SWIFT')" />
												<xsl:call-template name="zero_width_space_1">
											    	<xsl:with-param name="data" select="iso_code"/>
												</xsl:call-template>
											</fo:block>
										</xsl:if>
									</fo:table-cell>
								</xsl:if>
							</xsl:if>
							<xsl:if test="$productCode != '' and $subProductCode = ''">
								<fo:table-cell border-left="1px solid {$backgroundSubtitles}"
											   font-size="{number(substring-before($pdfFontSize,'pt'))+2}pt">
									<fo:block font-weight="bold" text-align="center" end-indent="{number($pdfMargin)}pt">
										<xsl:value-of select="localization:getDecode($language, 'N001', $productCode)" />
									</fo:block>
								</fo:table-cell>
							</xsl:if>
							<xsl:if test="$subProductCode != 'SMP'">
								<fo:table-cell border-left="1px solid {$backgroundSubtitles}"
											   font-size="{number(substring-before($pdfFontSize,'pt'))+2}pt">
									<fo:block font-weight="bold" text-align="center" end-indent="{number($pdfMargin)}pt">
										<xsl:value-of select="localization:getDecode($language, 'N047', $subProductCode)" />
									</fo:block>
								</fo:table-cell>
							</xsl:if>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
		</xsl:for-each>
	</xsl:template>
	
	<!-- SWIFT2018 Narrative PDF view -->
	<xsl:template name="pdfExtendedNarrative">
	<fo:block white-space-collapse="false" page-break-after="always">
							<fo:table font-family="{$pdfFontData}" space-before.conditionality="retain" space-before.optimum="20.0pt" width="{$pdfTableWidth}">
								<fo:table-column column-width="{$pdfTableWidth}"/>
								<fo:table-column column-width="0"/>
								<fo:table-body>
									<xsl:call-template name="title2">
										<xsl:with-param name="text">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_NARRATIVE_DETAILS')"/>
										</xsl:with-param>
									</xsl:call-template>
									</fo:table-body>
							</fo:table>
						</fo:block>
						
			<xsl:choose>
				 <xsl:when test="narrative_description_goods/amendments/amendment/data !='' or narrative_description_goods/issuance/data/datum/text !='' or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])">
					<fo:block white-space-collapse="false" page-break-after="always">
						<fo:table width="{$pdfTableWidth}" 
						font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
							<fo:table-column column-width="{$pdfTableWidth}" />
							<fo:table-column column-width="0" /> <!--  dummy column -->
							<fo:table-body>
								<xsl:apply-templates select="narrative_description_goods">
									<xsl:with-param name="theNodeName" select="'narrative_description_goods'"/>
									<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS')"/>
								</xsl:apply-templates>
	
							</fo:table-body>
						</fo:table>
					</fo:block>
				</xsl:when>
				<xsl:when test="narrative_description_goods[.!=''] and (//narrative_description_goods/amendments/amendment/data !='' or //narrative_description_goods/issuance/data/datum/text !='') or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])">
					<fo:block white-space-collapse="false" page-break-after="always">
							<fo:table width="{$pdfTableWidth}" 
							font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
								<fo:table-column column-width="{$pdfTableWidth}" />
								<fo:table-column column-width="0" /> <!--  dummy column -->
								<fo:table-body>
									<xsl:choose>
									<xsl:when test="original_xml/lc_tnx_record/narrative_description_goods[.!='']">
											<xsl:apply-templates select="original_xml/lc_tnx_record/narrative_description_goods">
												<xsl:with-param name="theNodeName" select="'narrative_description_goods'"/>
												<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS')"/>
											</xsl:apply-templates>
									</xsl:when>
									<xsl:otherwise>
										<xsl:apply-templates select="//original_xml/lc_tnx_record/narrative_description_goods">
											<xsl:with-param name="theNodeName" select="'narrative_description_goods'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS')"/>
										</xsl:apply-templates>
									</xsl:otherwise>
									</xsl:choose>
								</fo:table-body>
							</fo:table>
					</fo:block>
				</xsl:when>
			</xsl:choose>

			<xsl:choose>
 			 <xsl:when test="narrative_documents_required/amendments/amendment/data !='' or narrative_documents_required/issuance/data/datum/text !='' or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])">
				<fo:block white-space-collapse="false" page-break-after="always">
					<fo:table width="{$pdfTableWidth}" 
					font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
						<fo:table-column column-width="{$pdfTableWidth}" />
						<fo:table-column column-width="0"/> <!--  dummy column -->
						<fo:table-body>

							<xsl:apply-templates select="narrative_documents_required">
								<xsl:with-param name="theNodeName" select="'narrative_documents_required'"/>
								<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED')"/>
							</xsl:apply-templates>

						</fo:table-body>
					</fo:table>
				</fo:block>
			</xsl:when>
			<xsl:when test="narrative_documents_required[.!=''] and (//narrative_documents_required/amendments/amendment/data !='' or //narrative_documents_required/issuance/data/datum/text[.!='']) or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])">
				<fo:block white-space-collapse="false" page-break-after="always">
					<fo:table width="{$pdfTableWidth}" 
					font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
						<fo:table-column column-width="{$pdfTableWidth}" />
						<fo:table-column column-width="0"/> <!--  dummy column -->
						<fo:table-body>
						<xsl:choose>
							<xsl:when test="original_xml/lc_tnx_record/narrative_documents_required[.!='']">
								<xsl:apply-templates select="original_xml/lc_tnx_record/narrative_documents_required">
									<xsl:with-param name="theNodeName" select="'narrative_documents_required'"/>
									<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED')"/>
								</xsl:apply-templates>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="//original_xml/lc_tnx_record/narrative_documents_required">
									<xsl:with-param name="theNodeName" select="'narrative_documents_required'"/>
									<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED')"/>
								</xsl:apply-templates>
							</xsl:otherwise>
						</xsl:choose>
					</fo:table-body>
					</fo:table>
				</fo:block>
			</xsl:when>
			</xsl:choose>
			
			<xsl:choose>
				<xsl:when test="narrative_additional_instructions/amendments/amendment/data !='' or narrative_additional_instructions/issuance/data/datum/text !='' or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])" >
					<fo:block white-space-collapse="false" page-break-after="always">
						<fo:table width="{$pdfTableWidth}" 
						font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
							<fo:table-column column-width="{$pdfTableWidth}" />
							<fo:table-column column-width="0" /> <!--  dummy column -->
							<fo:table-body>
	
								<xsl:apply-templates select="narrative_additional_instructions">
									<xsl:with-param name="theNodeName" select="'narrative_additional_instructions'"/>
									<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS')"/>
								</xsl:apply-templates>
	
							</fo:table-body>
						</fo:table>
					</fo:block>
				</xsl:when>
				<xsl:when test="narrative_additional_instructions[.!=''] and (//narrative_additional_instructions/amendments/amendment/data !='' or //narrative_additional_instructions/issuance/data/datum/text[.!='']) or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])">
					<fo:block white-space-collapse="false" page-break-after="always">
						<fo:table width="{$pdfTableWidth}" 
						font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
							<fo:table-column column-width="{$pdfTableWidth}" />
							<fo:table-column column-width="0" /> <!--  dummy column -->
							<fo:table-body>
						<xsl:choose>
							<xsl:when test="original_xml/lc_tnx_record/narrative_additional_instructions">
								<xsl:apply-templates select="original_xml/lc_tnx_record/narrative_additional_instructions">
									<xsl:with-param name="theNodeName" select="'narrative_additional_instructions'"/>
									<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS')"/>
								</xsl:apply-templates>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="//original_xml/lc_tnx_record/narrative_additional_instructions">
									<xsl:with-param name="theNodeName" select="'narrative_additional_instructions'"/>
									<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS')"/>
								</xsl:apply-templates>
							</xsl:otherwise>
							</xsl:choose>
							</fo:table-body>
							</fo:table>
					</fo:block>
				</xsl:when>
			</xsl:choose>
			
			<xsl:choose>
			<xsl:when test="narrative_special_beneficiary/amendments/amendment/data !='' or narrative_special_beneficiary/issuance/data/datum/text !='' or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])" >
				<fo:block white-space-collapse="false" page-break-after="always">
					<fo:table width="{$pdfTableWidth}" 
					font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
						<fo:table-column column-width="{$pdfTableWidth}" />
						<fo:table-column column-width="0" /> <!--  dummy column -->
						<fo:table-body>

							<xsl:apply-templates select="narrative_special_beneficiary">
								<xsl:with-param name="theNodeName" select="'narrative_special_beneficiary'"/>
								<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF')"/>
							</xsl:apply-templates>

						</fo:table-body>
					</fo:table>
				</fo:block>
			</xsl:when>
			<xsl:when test="narrative_special_beneficiary[.!=''] and (//narrative_special_beneficiary/amendments/amendment/data !='' or //narrative_special_beneficiary/issuance/data/datum/text[.!='']) or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])">
					<fo:block white-space-collapse="false" page-break-after="always">
					<fo:table width="{$pdfTableWidth}" 
					font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
						<fo:table-column column-width="{$pdfTableWidth}" />
						<fo:table-column column-width="0" /> <!--  dummy column -->
						<fo:table-body>
					
							<xsl:choose>
								<xsl:when test="original_xml/lc_tnx_record/narrative_special_beneficiary">
									<xsl:apply-templates select="original_xml/lc_tnx_record/narrative_special_beneficiary">
										<xsl:with-param name="theNodeName" select="'narrative_special_beneficiary'"/>
										<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF')"/>
									</xsl:apply-templates>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="//original_xml/lc_tnx_record/narrative_special_beneficiary">
										<xsl:with-param name="theNodeName" select="'narrative_special_beneficiary'"/>
										<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF')"/>
									</xsl:apply-templates>
								</xsl:otherwise>
							</xsl:choose>
							
							</fo:table-body>
					</fo:table>
				</fo:block>
			</xsl:when>
			</xsl:choose>
			
			<xsl:choose>
				<xsl:when test="security:isBank($rundata) and (narrative_special_recvbank/amendments/amendment/data !='' or narrative_special_recvbank/issuance/data/datum/text !='' or (prod_stat_code[.='F1'] or prod_stat_code[.='F2']))">
					<fo:block white-space-collapse="false" page-break-after="always">
						<fo:table width="{$pdfTableWidth}" 
						font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
							<fo:table-column column-width="{$pdfTableWidth}" />
							<fo:table-column column-width="0" /> <!--  dummy column -->
							<fo:table-body>
	
								<xsl:apply-templates select="narrative_special_recvbank">
									<xsl:with-param name="theNodeName" select="'narrative_special_recvbank'"/>
									<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV')"/>
								</xsl:apply-templates>
	
							</fo:table-body>
						</fo:table>
					</fo:block>
				</xsl:when>  
				<xsl:when test="security:isBank($rundata) and //narrative_special_recvbank[.!=''] and (//narrative_special_recvbank/amendments/amendment/data !='' or //narrative_special_recvbank/issuance/data/datum/text !='') or (prod_stat_code[.='F1'] or prod_stat_code[.='F2'])">
					<fo:block white-space-collapse="false" page-break-after="always">
						<fo:table width="{$pdfTableWidth}" 
						font-size="{$pdfFontSize}" font-family="{$pdfFontData}">
							<fo:table-column column-width="{$pdfTableWidth}" />
							<fo:table-column column-width="0" /> <!--  dummy column -->
							<fo:table-body>
	
								<xsl:choose>
									<xsl:when test="original_xml/lc_tnx_record/narrative_special_recvbank">
										<xsl:apply-templates select="original_xml/lc_tnx_record/narrative_special_recvbank">
											<xsl:with-param name="theNodeName" select="'narrative_special_recvbank'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV')"/>
										</xsl:apply-templates>
									</xsl:when>
									<xsl:otherwise>
										<xsl:apply-templates select="//original_xml/lc_tnx_record/narrative_special_recvbank">
											<xsl:with-param name="theNodeName" select="'narrative_special_recvbank'"/>
											<xsl:with-param name="theNodeDescription" select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV')"/>
										</xsl:apply-templates>
									</xsl:otherwise>
								</xsl:choose>
								</fo:table-body>
						</fo:table>
					</fo:block>
				</xsl:when>
			</xsl:choose>
		</xsl:template>

	<xsl:template name="purchase-order">
		 <!-- Purchase Order -->
		  	<xsl:if test="not(security:isBank($rundata)) and narrative_description_goods[.!='']">
			<fo:block id="purchaseOrder"/>
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PURCHASE_ORDER')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:choose>
				<xsl:when test="line_items/lineItems/lineItem and count(line_items/lineItems/lineItem) != 0">
					<fo:block keep-together="always">
					<fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}">
						<fo:table-column column-width="{$pdfTableWidth}"/>
						<fo:table-column column-width="0" /> <!--  dummy column -->		
						<fo:table-body>
							<fo:table-row>
							<fo:table-cell>
							<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
						      	<fo:table width="{$pdfNestedTableWidth}" font-family="{$pdfFontData}" table-layout="fixed">
			  				       	<fo:table-column column-width="20.0pt"/>
			  				       	<fo:table-column column-width="9%"/>
						        	<fo:table-column column-width="17%"/>
						        	<fo:table-column column-width="45%"/>
						        	<fo:table-column column-width="10%"/>
						        	<fo:table-column column-width="10%"/>
						        	<fo:table-header font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold">
										<fo:table-row text-align="center">
										<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 	
						        		<fo:table-cell><fo:block  border-right-style="solid" border-right-width=".20pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PDF_NUMBER')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block  border-right-style="solid" border-right-width=".20pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PDF_UNITMEASURE')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block  border-left-style="solid" border-left-width=".20pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PDF_DESCRIPTION')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block  border-left-style="solid" border-left-width=".20pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PDF_AMOUNT')"/></fo:block></fo:table-cell>
						        		<fo:table-cell><fo:block  border-left-style="solid" border-left-width=".20pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PDF_CURRENCY')"/></fo:block></fo:table-cell>
						        		
						        		</fo:table-row>
						        	</fo:table-header>
						        	<fo:table-body>
							        		<xsl:for-each select="line_items/lineItems/lineItem">
							        		<fo:table-row>
												<fo:table-cell><fo:block>&nbsp;</fo:block></fo:table-cell> 
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".20pt">
													<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="qty_val"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".20pt">
													<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="qty_unit_measr_label"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".20pt">
													<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="product_name"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".20pt">
													<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt">
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="price_amt"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".20pt" padding-right="2.0pt">
													<fo:block text-align="left" padding-top="1.0pt" padding-bottom=".5pt" >
														<xsl:call-template name="zero_width_space_1">
														    <xsl:with-param name="data" select="price_cur_code"/>
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
					<fo:block>&nbsp;</fo:block>
				</fo:block>
			  </xsl:when>
			  <xsl:otherwise>
				  <xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_PURCHASE_ORDER')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			  </xsl:otherwise>
		  </xsl:choose>
		  <xsl:if test="fake_total_cur_code[.!=''] and fake_total_amt[.!='']">
				<xsl:call-template name="table_template">
					<xsl:with-param name="text">
						<xsl:call-template name="table_cell">
							<xsl:with-param name="left_text">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL')"/>
							</xsl:with-param>
							<xsl:with-param name="right_text">
								<xsl:value-of select="fake_total_cur_code"/> <xsl:value-of select="fake_total_amt"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		  <xsl:if test="total_net_cur_code[.!=''] and total_net_amt[.!='']">
			<xsl:call-template name="table_template">
					<xsl:with-param name="text">
				<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_PO_TOTAL_NET_AMT_LABEL')"/>
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of select="total_net_cur_code"/> <xsl:value-of select="total_net_amt"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:with-param>
					</xsl:call-template>
			</xsl:if>
		 </xsl:if>
		  
		  <!-- Purchase Order -->
	</xsl:template>
	<!-- ********************** -->
	<!-- Bank Details Templates -->
	<!-- ********************** -->
	<!-- TEMPLATE Banks -->
	<xsl:template
		match="issuing_bank | remitting_bank | recipient_bank | credit_available_with_bank | drawee_details_bank | advising_bank | advise_thru_bank | collecting_bank | presenting_bank  | confirming_bank | account_with_bank | pay_through_bank | buyer_bank | seller_bank | processing_bank | requested_confirmation_party | first_advising_bank">
		<xsl:param name="theNodeName" />
		<xsl:param name="theNodeDescription" />
		<xsl:param name="up">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:param>
		<xsl:param name="lo">abcdefghijklmnopqrstuvwxyz</xsl:param>
		<xsl:variable name="type"><xsl:value-of select="//credit_available_with_bank_type"/></xsl:variable>
		<xsl:choose>
			<xsl:when test="$swift2018Enabled">
				<!-- For export letter of credit requested confirmation party does not require subtitle -->
		<xsl:if test="not(//product_code[.='EL' or .='SR'] and $theNodeName = 'requested_confirmation_party') ">
		<xsl:call-template name="subtitle">
			<xsl:with-param name="text">
				<xsl:value-of select="$theNodeDescription" />
			</xsl:with-param>
		</xsl:call-template>
		</xsl:if>
		<!-- For import letter of credit requested confirmation party flag is displayed before the Bank data -->
		<xsl:if test="//product_code[.='LC'] and $theNodeName = 'requested_confirmation_party'">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_CONFDETAILS_REQUESTED_CONFIRMATION_PARTY')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:choose>
				<xsl:when test="/lc_tnx_record/req_conf_party_flag[. = 'Advising Bank']">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISING')"/>
				</xsl:when>
				<xsl:when test="/lc_tnx_record/req_conf_party_flag[. = 'Advise Thru Bank']">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISE_THRU')"/>
				</xsl:when>
				<xsl:when test="/lc_tnx_record/req_conf_party_flag[. = 'Other']">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_OTHER')"/>
				</xsl:when>
				<xsl:otherwise/>
				</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="//product_code[.='SI'] and $theNodeName = 'requested_confirmation_party'">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_CONFDETAILS_REQUESTED_CONFIRMATION_PARTY')"/>
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:choose>
				<xsl:when test="/si_tnx_record/req_conf_party_flag[. = 'Advising Bank']">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISING')"/>
				</xsl:when>
				<xsl:when test="/si_tnx_record/req_conf_party_flag[. = 'Advise Thru Bank']">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_ADVISE_THRU')"/>
				</xsl:when>
				<xsl:when test="/si_tnx_record/req_conf_party_flag[. = 'Other']">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SELECT_REQUESTED_CONFIRMATION_PARTY_OTHER')"/>
				</xsl:when>
				<xsl:otherwise/>
				</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="subtitle">
					<xsl:with-param name="text">
						<xsl:value-of select="$theNodeDescription" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		
			<xsl:if test="$theNodeName='credit_available_with_bank' and name[.!=''] and //product_code[.!='EL'] and //product_code[.!='SR']">
				<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_TYPE')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:choose>
					<xsl:when test="$theNodeName='drawee_details_bank'">
						<xsl:choose>
							<xsl:when test="name[translate(.,$up,$lo)='issuing bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ISSUING_BANK')">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ISSUING_BANK')"/>
							</xsl:when>
							<xsl:when test="name[translate(.,$up,$lo)='confirming bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_CONFIRMING_BANK')">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_CONFIRMING_BANK')"/>
							</xsl:when>
								<xsl:when test="name[translate(.,$up,$lo)='advising bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ADVISING_BANK')">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ADVISING_BANK')"/>
							</xsl:when>
							<xsl:when test="name[translate(.,$up,$lo)='negotiating bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_NEGOTIATING_BANK')">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_NEGOTIATING_BANK')"/>
							</xsl:when>
							<xsl:when test="name[translate(.,$up,$lo)='reimbursing bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_REIMBURSING_BANK')">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_REIMBURSING_BANK')"/>
							</xsl:when>
							<xsl:when test="name[translate(.,$up,$lo)='applicant'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_APPLICANT')">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_APPLICANT')"/>
							</xsl:when>
							<xsl:when test="name[translate(.,$up,$lo)='first advising bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_FIRST_ADVISING_BANK')">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_FIRST_ADVISING_BANK')"/>
							</xsl:when>
							<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_OTHER')"/></xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$theNodeName='credit_available_with_bank'">
					  <xsl:choose>
					  	<xsl:when test="translate($type,$up,$lo)='issuing bank'">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ISSUING_BANK')"/>
						</xsl:when>
						<xsl:when test="translate($type,$up,$lo)='advising bank'">
						         <xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ADVISING_BANK')"/>
						</xsl:when>
						<xsl:when test="translate($type,$up,$lo)='any bank'">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ANY_BANK')"/>
						</xsl:when>
						<xsl:otherwise>
	   							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_OTHER')"/>
	   					</xsl:otherwise>
					 </xsl:choose>
					</xsl:when>
					<xsl:otherwise>
					 <xsl:choose>
					  	<xsl:when test="name[. = ''] or (normalize-space(name)='Advising Bank' or normalize-space(name)=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ADVISING_BANK')) or (normalize-space(name)='Any Bank' or normalize-space(name)=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ANY_BANK')) or (normalize-space(name)='Issuing Bank' or normalize-space(name)=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_ISSUING_BANK'))">
    							<xsl:value-of select="name"/>
   						</xsl:when>
   						<xsl:otherwise>
     							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_OTHER')"/>
   						</xsl:otherwise>
					 </xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		<xsl:if test="name[.!='']">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
				<xsl:choose>
					<xsl:when test="$theNodeName='credit_available_with_bank' and product_code != 'EL'">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')" />
					</xsl:when>
				<xsl:otherwise>
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BANK_NAME')" />
				</xsl:otherwise>
				</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:choose>
					<xsl:when test="$theNodeName='drawee_details_bank'">
						<xsl:choose>
							<xsl:when test="name[translate(.,$up,$lo)='issuing bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ISSUING_BANK')">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ISSUING_BANK')"/>
							</xsl:when>
							<xsl:when test="name[translate(.,$up,$lo)='confirming bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_CONFIRMING_BANK')">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_CONFIRMING_BANK')"/>
							</xsl:when>
								<xsl:when test="name[translate(.,$up,$lo)='advising bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ADVISING_BANK')">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ADVISING_BANK')"/>
							</xsl:when>
							<xsl:when test="name[translate(.,$up,$lo)='negotiating bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_NEGOTIATING_BANK')">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_NEGOTIATING_BANK')"/>
							</xsl:when>
							<xsl:when test="name[translate(.,$up,$lo)='reimbursing bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_REIMBURSING_BANK')">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_REIMBURSING_BANK')"/>
							</xsl:when>
							<xsl:when test="name[translate(.,$up,$lo)='applicant'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_APPLICANT')">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_APPLICANT')"/>
							</xsl:when>
							<xsl:when test="name[translate(.,$up,$lo)='first advising bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_FIRST_ADVISING_BANK')">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_FIRST_ADVISING_BANK')"/>
							</xsl:when>
						    <xsl:otherwise>
								<xsl:choose>
									<xsl:when test="//product_code[.='LC' or .='SI' or .='SR' or .='EL']">
										<xsl:value-of select="name" />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_OTHER')"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>						
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$theNodeName='credit_available_with_bank' and //product_code [.= 'LC'] and type !=''">
		     		<xsl:value-of select="localization:getCodeData($language,'*','*','C098', type)"/>
		    		</xsl:when>
					<xsl:otherwise><xsl:value-of select="name"/></xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if
			test="not((contains($theNodeName,'issuing_bank') and //product_code[.='LI' or .='LC' or .='SI' or .='SG' or .='TF' or .='FT' or .='PO' or .='IN' or .='IP' or .='LS']) or (contains($theNodeName,'advising_bank') and //product_code[.='EL' or .='SR' or .='SO']) or (contains($theNodeName,'remitting_bank') and //product_code[.='EC']) or (contains($theNodeName,'presenting_bank') and //product_code[.='IC']) or (contains($theNodeName,'recipient_bank') and //product_code[.='BG'])) or (contains($theNodeName,'first_advising_bank') and //product_code[.='EL'])">
			<xsl:if test="address_line_1[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="address_line_1" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="address_line_2[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:choose>
							<xsl:when test="address_line_1[.!='']" />
							<xsl:otherwise>
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="address_line_2" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="dom[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:choose>
							<xsl:when test="address_line_1[.!=''] or address_line_2[.!='']" />
							<xsl:otherwise>
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="dom" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="address_line_4[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:choose>
							<xsl:when test="address_line_1[.!=''] or address_line_2[.!=''] or dom[.!='']" />
							<xsl:otherwise>
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="address_line_4" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="iso_code[.!=''] and //product_code[.!='LI']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BIC_CODE')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="iso_code" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="reference[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="reference" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
		<xsl:if test="(contains($theNodeName,'issuing_bank') and //product_code[.='SG' or .='LI' or .='LS'])" >
			<xsl:if test="//applicant_reference[.!=''] and //*/customer_references">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_CUST_REFERENCE')" />
					</xsl:with-param>
					<xsl:with-param name="name">applicant_reference</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:variable name="appl_ref"><xsl:value-of select="//applicant_reference"/></xsl:variable>
						<xsl:choose>
	      							<xsl:when test="security:isBank($rundata)">
      									<xsl:value-of select="//*/customer_references/customer_reference/description"/>
    	 							</xsl:when>
    	 							<xsl:when test="defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'">
    	 							<xsl:choose>
    	 							<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) >= 1">
                                    	<xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]/reference)"/>
									</xsl:when>                                 	
	    	 						<xsl:otherwise>
	    	 							<xsl:value-of select="utils:decryptApplicantReference(//*/customer_references/customer_reference[reference=$appl_ref]/reference)"/>
	    	 						</xsl:otherwise>
    	 							</xsl:choose>
    	 							</xsl:when>
    	 							<xsl:otherwise>
    	 							<xsl:choose>
    	 							<xsl:when test="count(//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]) >= 1">
                                    	<xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$appl_ref]/description"/>
									</xsl:when>                                 	
	    	 						<xsl:otherwise>
	    	 							<xsl:value-of select="//*/customer_references/customer_reference[reference=$appl_ref]/description"/>
	    	 						</xsl:otherwise>
    	 							</xsl:choose>
    	 							</xsl:otherwise>
    					</xsl:choose> 
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>  
	</xsl:template>
	
	<!--
		TEMPLATE Narratives Description of Goods, Documents Required,
		Additional Instructions, Charges, Additional Amount, Payment
		Instructions, Period for Presentation, Shipment Period, Sender to
		Receiver Information
	-->
	<xsl:template
		match="narrative_description_goods | narrative_documents_required | narrative_additional_instructions | narrative_charges | narrative_additional_amount | narrative_payment_instructions | narrative_payment_details | narrative_period_presentation | narrative_shipment_period | narrative_sender_to_receiver | free_format_text | narrative_special_beneficiary | narrative_special_recvbank">
		<xsl:param name="theNodeName" />
		<xsl:param name="theNodeDescription" />
		<xsl:if test="$theNodeDescription != ''">
			<xsl:call-template name="subtitle2">
				<xsl:with-param name="text">
					<xsl:value-of select="$theNodeDescription" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:choose>
		<xsl:when test="$swift2018Enabled and ($theNodeName='narrative_description_goods' or $theNodeName='narrative_documents_required' or $theNodeName='narrative_additional_instructions' or $theNodeName='narrative_special_beneficiary' or $theNodeName='narrative_special_recvbank') and (common:node-set(.)/issuance or common:node-set(.)/amendments)">		
			<xsl:call-template name="table_cell2">
				<xsl:with-param name="text" >	
					
					<xsl:if test="common:node-set(.)/issuance !=''">
						<fo:block start-indent="0.0pt" keep-together="always" font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold" border-top="{$borderColor} solid 1px" border-bottom="{$borderColor} solid 1px">
							<fo:block start-indent="40.0pt">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
							</fo:block>
						</fo:block>
						<xsl:value-of select="common:node-set(.)/issuance/data/datum/text" />
					</xsl:if>
					
					<xsl:if test="common:node-set(.)/amendments/amendment/data !=''">
						<xsl:for-each select="common:node-set(.)/amendments/amendment">
						<fo:block>&nbsp;</fo:block>
						<fo:block start-indent="0.0pt" keep-together="always" font-family="{$pdfFont}" color="{$fontColorTitles}" font-weight="bold" border-top="{$borderColor} solid 1px" border-bottom="{$borderColor} solid 1px">
							<fo:block start-indent="40.0pt">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp; <xsl:value-of select="sequence"/>
							</fo:block>
						</fo:block>
							<xsl:for-each select="data/datum">						
								/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
								<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
								<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/ <xsl:value-of select="text" /> <xsl:if test="response[.='Rejected']"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REJECTED')"/></xsl:if>						
							</xsl:for-each>								
						</xsl:for-each>											
					</xsl:if>			
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
		<xsl:call-template name="table_cell2">
			<xsl:with-param name="text" >
				<xsl:value-of select="." />
			</xsl:with-param>
		</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--TEMPLATE Document-->
	<xsl:template match="document">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:choose>
						<xsl:when test="code[.='01']">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DOCUMENTS_BILL_OF_EXCHANGE')" />
						</xsl:when>
						<xsl:when test="code[.='02']">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DOCUMENTS_SIGNED_COMM_INVOICE')" />
						</xsl:when>
						<xsl:when test="code[.='03']">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DOCUMENTS_INSR_POLICY_CERTIFICATE')" />
						</xsl:when>
						<xsl:when test="code[.='04']">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DOCUMENTS_PACKING_LIST')" />
						</xsl:when>
						<xsl:when test="code[.='05']">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DOCUMENTS_CERTIFICATE_ORIGIN')" />
						</xsl:when>
						<xsl:when test="code[.='06']">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DOCUMENTS_INSPECTION_CERTIFICATE')" />
						</xsl:when>
						<xsl:when test="code[.='07']">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DOCUMENTS_SIGNED_BL')" />
						</xsl:when>
						<xsl:when test="code[.='08']">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DOCUMENTS_NON_NEG_BL')" />
						</xsl:when>
						<xsl:when test="code[.='09']">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DOCUMENTS_AIR_WAYBILL')" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="name" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<fo:table>
						<fo:table-body >
						<fo:table-row>
							<fo:table-cell>
				            <fo:block text-align="{left}" >
				            	<xsl:call-template name="zero_width_space_1">
								    <xsl:with-param name="data" select="doc_no"/>
								</xsl:call-template>
							</fo:block>            
				           </fo:table-cell>
				           <fo:table-cell>
				            <fo:block text-align="{left}" padding-top="1.0pt" padding-bottom=".5pt">
				            	<xsl:call-template name="zero_width_space_1">
								    <xsl:with-param name="data" select="doc_date"/>
								</xsl:call-template>
							</fo:block>            
				           </fo:table-cell>
				           <fo:table-cell>
				            <fo:block text-align="{left}" padding-top="1.0pt" padding-bottom=".5pt">
				            	<xsl:call-template name="zero_width_space_1">
								    <xsl:with-param name="data" select="first_mail"/>
								</xsl:call-template>
							</fo:block>            
				           </fo:table-cell>
				           <fo:table-cell>
				            <fo:block text-align="{left}" padding-top="1.0pt" padding-bottom=".5pt">
				            	<xsl:call-template name="zero_width_space_1">
								    <xsl:with-param name="data" select="second_mail"/>
								</xsl:call-template>
							</fo:block>            
				           </fo:table-cell>
				           <fo:table-cell>
				            <fo:block text-align="{left}" padding-top="1.0pt" padding-bottom=".5pt">
				            	<xsl:call-template name="zero_width_space_1">
								    <xsl:with-param name="data" select="total"/>
								</xsl:call-template>
							</fo:block>            
				           </fo:table-cell>
				        </fo:table-row>
						</fo:table-body>
					</fo:table>				
				</xsl:with-param>
			</xsl:call-template>

	</xsl:template>
	<!-- Instructions for the Bank Only -->
	<xsl:template name="additional_information">
		<fo:block keep-together="always" white-space-collapse="false">
			<xsl:call-template name="table_template">
				<xsl:with-param name="text">
					<xsl:if
						test="free_format_text[.!=''] or attachments/attachment[type='01'] or principal_act_no[.!=''] or fee_act_no[.!=''] or ((adv_send_mode[.!=''] and (adv_send_mode[.='01' or .='02' or .='03' or .='04'])) and tnx_type_code[.='01' or .='03']) or (docs_send_mode[.!=''] and tnx_type_code[.='01']) or (fwd_contract_no[.!=''] and product_code[.='EC'])">
						<fo:table-row>
							<fo:table-cell number-columns-spanned="2">
								<fo:block space-before.optimum="10.0pt"
									space-before.conditionality="retain" background-color="{$backgroundTitles}"
									color="{$backgroundSubtitles3}" font-family="{$pdfFont}"
									font-weight="bold">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_HEADER_INSTRUCTIONS')" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<xsl:if
						test="adv_send_mode[. != ''] and tnx_type_code[.='01' or .='03' or .='13']">
						<!--Advice Send Mode-->
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
									<xsl:otherwise />
								</xsl:choose>
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
					<xsl:if
						test="principal_act_no[. != ''] or fee_act_no[. != ''] or (fwd_contract_no[.!=''] and product_code[.='EC'])">
						<xsl:if test="principal_act_no[. != '']">
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
						<xsl:if test="fee_act_no[. != '']">
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
						<xsl:if test="fwd_contract_no[.!=''] and product_code[.='EC']">
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">1
									<xsl:value-of
										select="localization:getGTPString($language,'XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of select="fwd_contract_no" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:if>
					<xsl:if test="free_format_text[.!='']">
						<fo:table-row>
							<fo:table-cell>
								<fo:block start-indent="20.0pt"
									font-family="{$pdfFontData}" space-before.optimum="10.0pt"
									space-before.conditionality="retain">
									<xsl:value-of select="free_format_text" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
		</fo:block>
	</xsl:template>
	<!--TEMPLATE Attachment - Control Client -->
	<xsl:template match="attachment" mode="control">
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of select="title" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="file_name" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<!--TEMPLATE Attachment - Reporting Bank -->
	<xsl:template match="attachment" mode="bank">
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of select="title" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of select="file_name" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<!--  TEMPLATE Counterparty -->
	<xsl:template match="counterparties/counterparty">
		<xsl:if test="counterparty_act_no[.!='']">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BENEFICIARY_ACT_NO')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="counterparty_act_no" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="counterparty_name[.!='']">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BENEFICIARY_NAME')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="counterparty_name" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="counterparty_address_line_1[.!='']">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="counterparty_address_line_1" />
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					&nbsp;
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="counterparty_address_line_2" />
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					&nbsp;
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="counterparty_dom" />
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					&nbsp;
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="counterparty_address_line_4" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="counterparty_amt[.!='']">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_FT_AMT_LABEL')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="counterparty_cur_code" />&nbsp;
					<xsl:value-of select="counterparty_amt" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="counterparty_reference[.!='']">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="counterparty_reference" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sub_subtitle">
		<xsl:param name="text" />
		<fo:table-row keep-with-next="always">
			<fo:table-cell number-columns-spanned="2">
				<xsl:call-template name="sub_subtitle_private">
					<xsl:with-param name="content">
						<xsl:copy-of select="$text" />
					</xsl:with-param>
				</xsl:call-template>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
	
	<!-- ******************************** -->
	<!-- Sub-subtitle Common Aspect (private) -->
	<!-- ******************************** -->
	<xsl:template name="sub_subtitle_private">
		<xsl:param name="content" />
		<fo:block margin="10.0pt" background-color="#ffffff"
					space-before.conditionality="retain" space-after.optimum="10.0pt"
					space-after.conditionality="retain" font-weight="bold" font-family="{$pdfFont}"
					border-bottom="{$borderColor} solid 1px">
			<fo:block start-indent="20.0pt" end-indent="20.0pt">
				<xsl:copy-of select="$content" />
			</fo:block>
		</fo:block>
	</xsl:template>
	<!-- ************************** -->
	<!-- Table template (3 columns) -->
	<!-- ************************** -->
	<xsl:template name="table_3_columns_template">
		<xsl:param name="text"/>
		<xsl:param name="table_width" select="$pdfTableWidth"/>
		<xsl:param name="column_1_width">33%</xsl:param>
		<xsl:param name="column_2_width">33%</xsl:param>
		<xsl:param name="column_3_width">34%</xsl:param>
		<fo:block white-space-collapse="false" margin-left="20.0pt" margin-right="20.0pt">
			<fo:table width="{$table_width}" font-family="{$pdfFontData}" table-layout="fixed">
				<fo:table-column column-width="{$column_1_width}" border="{$borderColor} solid 1px"/>
				<fo:table-column column-width="{$column_2_width}" border="{$borderColor} solid 1px"/>
				<fo:table-column column-width="{$column_3_width}" border="{$borderColor} solid 1px"/>
				<fo:table-body>
					<xsl:copy-of select="$text" />
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>
	<!-- ******************************* -->
	<!-- Table row  template (3 columns) -->
	<!-- ******************************* -->
	<xsl:template name="table_cell_3_columns">
		<xsl:param name="column_1_text"/>
		<xsl:param name="column_1_text_font_family"/>
		<xsl:param name="column_1_text_font_weight"/>
		<xsl:param name="column_1_text_align">left</xsl:param>
		<xsl:param name="column_2_text"/>
		<xsl:param name="column_2_text_font_family"/>
		<xsl:param name="column_2_text_font_weight"/>
		<xsl:param name="column_2_text_align">left</xsl:param>
		<xsl:param name="column_3_text"/>
		<xsl:param name="column_3_text_font_family"/>
		<xsl:param name="column_3_text_font_weight"/>
		<xsl:param name="column_3_text_align">left</xsl:param>
		<xsl:param name="background_color"><xsl:value-of select="$backgroundSubtitles"/></xsl:param>
		<fo:table-row>
			<fo:table-cell keep-together="always" background-color="{$background_color}">
				<xsl:if test="$column_1_text_font_weight != ''">
					<xsl:attribute name="font-weight"><xsl:value-of select="$column_1_text_font_weight"/></xsl:attribute>
				</xsl:if>
				<xsl:if test="$column_1_text_font_family != ''">
					<xsl:attribute name="font-family"><xsl:value-of select="$column_1_text_font_family"/></xsl:attribute>
				</xsl:if>
				<fo:block text-align="{$column_1_text_align}">
					<xsl:copy-of select="$column_1_text" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell keep-together="always" background-color="{$background_color}">
				<xsl:if test="$column_2_text_font_weight != ''">
					<xsl:attribute name="font-weight"><xsl:value-of select="$column_2_text_font_weight"/></xsl:attribute>
				</xsl:if>
				<xsl:if test="$column_2_text_font_family != ''">
					<xsl:attribute name="font-family"><xsl:value-of select="$column_2_text_font_family"/></xsl:attribute>
				</xsl:if>
				<fo:block text-align="{$column_2_text_align}">
					<xsl:copy-of select="$column_2_text" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell keep-together="always" background-color="{$background_color}">
				<xsl:if test="$column_3_text_font_weight != ''">
					<xsl:attribute name="font-weight"><xsl:value-of select="$column_3_text_font_weight"/></xsl:attribute>
				</xsl:if>
				<xsl:if test="$column_3_text_font_family != ''">
					<xsl:attribute name="font-family"><xsl:value-of select="$column_3_text_font_family"/></xsl:attribute>
				</xsl:if>
				<fo:block text-align="{$column_3_text_align}">
					<xsl:copy-of select="$column_3_text" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
	
	<!-- ************************** -->
	<!-- Table template (2 columns) -->
	<!-- ************************** -->
	<xsl:template name="table_2_columns_template">
		<xsl:param name="text"/>
		<xsl:param name="table_width" select="$pdfTableWidth"/>
		<xsl:param name="column_1_width">50%</xsl:param>
		<xsl:param name="column_2_width">50%</xsl:param>
		<fo:block white-space-collapse="false" margin-left="20.0pt" margin-right="20.0pt">
			<fo:table width="{$table_width}" font-family="{$pdfFontData}" table-layout="fixed">
				<fo:table-column column-width="{$column_1_width}" border="{$borderColor} solid 1px"/>
				<fo:table-column column-width="{$column_2_width}" border="{$borderColor} solid 1px"/>
				<fo:table-body>
					<xsl:copy-of select="$text" />
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>
	
	<xsl:template name="table_cell_2_columns">
		<xsl:param name="column_1_text"/>
		<xsl:param name="column_1_text_font_family"/>
		<xsl:param name="column_1_text_font_weight"/>
		<xsl:param name="column_1_text_align">left</xsl:param>
		<xsl:param name="column_2_text"/>
		<xsl:param name="column_2_text_font_family"/>
		<xsl:param name="column_2_text_font_weight"/>
		<xsl:param name="column_2_text_align">left</xsl:param>
		<xsl:param name="background_color"><xsl:value-of select="$backgroundSubtitles"/></xsl:param>
		<fo:table-row>
			<fo:table-cell keep-together="always" background-color="{$background_color}">
				<xsl:if test="$column_1_text_font_weight != ''">
					<xsl:attribute name="font-weight"><xsl:value-of select="$column_1_text_font_weight"/></xsl:attribute>
				</xsl:if>
				<xsl:if test="$column_1_text_font_family != ''">
					<xsl:attribute name="font-family"><xsl:value-of select="$column_1_text_font_family"/></xsl:attribute>
				</xsl:if>
				<fo:block text-align="{$column_1_text_align}">
					<xsl:copy-of select="$column_1_text" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell keep-together="always" background-color="{$background_color}">
				<xsl:if test="$column_2_text_font_weight != ''">
					<xsl:attribute name="font-weight"><xsl:value-of select="$column_2_text_font_weight"/></xsl:attribute>
				</xsl:if>
				<xsl:if test="$column_2_text_font_family != ''">
					<xsl:attribute name="font-family"><xsl:value-of select="$column_2_text_font_family"/></xsl:attribute>
				</xsl:if>
				<fo:block text-align="{$column_2_text_align}">
					<xsl:copy-of select="$column_2_text" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
	
	<!-- ************************** -->
	<!-- Table template (1 column) -->
	<!-- ************************** -->
	<xsl:template name="table_1_column_template">
		<xsl:param name="text"/>
		<xsl:param name="table_width" select="$pdfTableWidth"/>
		<xsl:param name="column_1_width">100%</xsl:param>
		<fo:block white-space-collapse="false" margin-left="20.0pt" margin-right="20.0pt">
			<fo:table width="{$table_width}" font-family="{$pdfFontData}" table-layout="fixed">
				<fo:table-column column-width="{$column_1_width}" border="{$borderColor} solid 1px"/>
				<fo:table-body>
					<xsl:copy-of select="$text" />
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>
	
	<xsl:template name="table_cell_1_column">
		<xsl:param name="column_1_text"/>
		<xsl:param name="column_1_text_font_family"/>
		<xsl:param name="column_1_text_font_weight"/>
		<xsl:param name="column_1_text_align">left</xsl:param>
		<xsl:param name="background_color"><xsl:value-of select="$backgroundSubtitles"/></xsl:param>
		<fo:table-row>
			<fo:table-cell keep-together="always" background-color="{$background_color}">
				<xsl:if test="$column_1_text_font_weight != ''">
					<xsl:attribute name="font-weight"><xsl:value-of select="$column_1_text_font_weight"/></xsl:attribute>
				</xsl:if>
				<xsl:if test="$column_1_text_font_family != ''">
					<xsl:attribute name="font-family"><xsl:value-of select="$column_1_text_font_family"/></xsl:attribute>
				</xsl:if>
				<fo:block text-align="{$column_1_text_align}">
					<xsl:copy-of select="$column_1_text" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<!--
		This template defines the general layout used by most PDF export files.
	-->
	<xsl:template name="general-layout-master">	
	<xsl:param name="backGroundAirImage">url('{$base_url}/fo_icons/background_air.jpg')</xsl:param>
		<fo:layout-master-set>
			<fo:simple-page-master master-name="Section1-pm" writing-mode="{$writingMode}"
				page-height="{$pageHeight}" page-width="{$pageWidth}" margin="{number($pdfMargin)}pt">
				<!-- BODY -->
				<fo:region-body margin-right="{$defaultBodyMarginRight}" 	margin-left="{$defaultBodyMarginLeft}" 
								margin-bottom="{$defaultBodyMarginBottom}"	margin-top="{$defaultBodyMarginTop}" 
								background-image="{$backgroundImage}" />
				<!-- Region after (this is the bottom of the page) -->
				<fo:region-after display-align="before" extent="16pt" />

				<!-- Region start (left on ltr, right on rtl) -->
				<fo:region-start reference-orientation="90" background-color="{$backgroundTitles}" extent="8pt" />
			</fo:simple-page-master>
			
			<!--
				The processing of the first page is different from the others: no
				bank's adress on the rest of the pages
			-->
			<fo:simple-page-master  master-name="first1" page-height="{$pageHeight}" page-width="{$pageWidth}" 
									margin-right="{number($pdfMargin)}pt" margin-left="{number($pdfMargin)}pt"
									margin-bottom="{number($pdfMargin)}pt" margin-top="{number($pdfMargin)}pt"
									writing-mode="{$writingMode}" >
				<!-- Body -->
				<fo:region-body margin-right="{$firstPageBodyMarginRight}" margin-left="{$firstPageBodyMarginLeft}" 
								margin-bottom="{$firstPageBodyMarginBottom}" margin-top="{$firstPageBodyMarginTop}"
								background-image="{$backgroundImage}" />

				<!-- Region before (this is the header) -->
				<fo:region-before	background-repeat="no-repeat" background-image="utils:getImagePath($backGroundAirImage)"
									margin-right="{number($pdfMargin)}pt" margin-left="{number($pdfMargin)+8}pt"
									display-align="before" extent="140pt" />

				<!-- Region after (this is the bottom of the page) -->
				<fo:region-after display-align="before" extent="16pt" />
				
				<!-- Region start (left on ltr, right on rtl) -->
				<fo:region-start reference-orientation="90" background-color="{$backgroundTitles}" extent="8pt" />

			</fo:simple-page-master>
			
			<fo:page-sequence-master master-name="Section1-ps">
				<fo:repeatable-page-master-alternatives>
					<fo:conditional-page-master-reference
						master-reference="first1" page-position="first" />
					<fo:conditional-page-master-reference
						master-reference="Section1-pm" page-position="rest" />
				</fo:repeatable-page-master-alternatives>
			</fo:page-sequence-master>
		</fo:layout-master-set>
	</xsl:template>


	<xsl:template name="header_no_bank">
	<xsl:param name="headerImage">url('<xsl:value-of select="$base_url" />/fo_icons/header.jpg')</xsl:param>
		<xsl:param name="headerTitle">MAIN_TITLE</xsl:param>
		<fo:block font-family="{$pdfFont}" color="{$backgroundSubtitles3}">
			<fo:table background-position="top right" table-layout="fixed" 
			background-color="{$borderColor}" background-image="utils:getImagePath($headerImage)">
				<fo:table-column column-width="proportional-column-width(1)" />
				<fo:table-column column-width="proportional-column-width(1)" />
				<fo:table-body>
					<fo:table-row>
						<!-- Bank logo -->
						<fo:table-cell>
								<xsl:call-template name="bank_logo">
								<xsl:with-param name="bankName">logo</xsl:with-param>								
								</xsl:call-template>						
						</fo:table-cell>
						<fo:table-cell border-left="1px solid {$backgroundSubtitles}" font-size="{number(substring-before($pdfFontSize,'pt'))+2}pt">
							<fo:block font-weight="bold" text-align="center" end-indent="{number($pdfMargin)}pt">
								<xsl:value-of select="localization:getGTPString($language, $headerTitle)" />
							</fo:block>
						</fo:table-cell>
						
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>
	
	<!-- handling line break break control in a table -->
	<xsl:template name="zero_width_space_1">
	<xsl:param name="data"/>
	<xsl:param name="counter" select="0"/>
	<xsl:choose>
	    <xsl:when test="$counter &lt; (string-length($data)+1)">
	      <xsl:value-of select='concat(substring($data,$counter,1),"&#8203;")'/>
	       <xsl:call-template name="zero_width_space_2">
	   	       <xsl:with-param name="data" select="$data"/>
	   	       <xsl:with-param name="counter" select="$counter+1"/>
	  	  </xsl:call-template>
	    </xsl:when>
	    <xsl:otherwise>
	    </xsl:otherwise>
	  </xsl:choose>
   </xsl:template>
   
   <xsl:template name="zero_width_space_2">
	<xsl:param name="data"/>
	<xsl:param name="counter"/>
	   <xsl:value-of select='concat(substring($data,$counter,1),"&#8203;")'/>
	   <xsl:call-template name="zero_width_space_1">
	    <xsl:with-param name="data" select="$data"/>
	    <xsl:with-param name="counter" select="$counter+1"/>
	  </xsl:call-template>
   </xsl:template>
   
   <xsl:template name ="tokenize-string">
	<xsl:param name = "text"/>
	<xsl:param name = "delimiter">:</xsl:param>
	<xsl:choose>
		<xsl:when test="substring-before($text, $delimiter) != ''">	
		<fo:block font-family="{$pdfFont}" space-after.optimum="5.0pt"
								space-before.conditionality="retain">
			<xsl:value-of select="localization:getGTPString($language, substring-before($text, $delimiter))" disable-output-escaping="yes" />
		</fo:block>
		</xsl:when>
		<xsl:otherwise>
		<fo:block font-family="{$pdfFont}" space-after.optimum="5.0pt"
								space-before.conditionality="retain">
			<xsl:value-of select="localization:getGTPString($language, $text)"/>
		</fo:block>
		</xsl:otherwise>
	</xsl:choose>
    <xsl:if test="contains($text,$delimiter)">
        <xsl:call-template name="tokenize-string">
            <xsl:with-param name="text" select="substring-after($text, $delimiter)" disable-output-escaping="yes"/>
            <xsl:with-param name ="delimiter"><xsl:value-of select ="$delimiter"/></xsl:with-param>
        </xsl:call-template>
    </xsl:if>
	</xsl:template>
	<xsl:template name="exchange-rate-details">
	<xsl:if test="fx_exchange_rate[.!=''] and fx_nbr_contracts[.!='']">
		<fo:block keep-together="always">
        	<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
            	<fo:table-column column-width="{$labelColumnWidth}"/>
                <fo:table-column column-width="{$detailsColumnWidth}"/>
                <fo:table-body>
                	<fo:table-row>
                    	<fo:table-cell number-columns-spanned="6">
                        	<fo:block background-color="{$backgroundTitles}" color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt">
                            	<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_EXCHANGE_RATE')"/>
                            </fo:block>
                        </fo:table-cell>
                   	</fo:table-row>
                	<fo:table-row keep-with-previous="always">
                    	<fo:table-cell >                            
                        	<fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt" start-indent="20.0pt">
                            	<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_RATES')" />                                   
                           	</fo:block>
                       </fo:table-cell>
                       <fo:table-cell>
                       		<fo:block font-family="{$pdfFont}" space-before.optimum="10.0pt">
                            	<xsl:if test="fx_rates_type[. = '01']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_BOARD_RATES')" />
								</xsl:if>
						   		<xsl:if test="fx_rates_type[. = '02'] and fx_nbr_contracts[. > '0']">
						    		<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_CONTRACTS')" />
						   		</xsl:if>	
							</fo:block>
						</fo:table-cell>
                        <fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body> 
			</fo:table>
			<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
            		<fo:table-column column-width="25%" />
						<fo:table-column column-width="20%" />
						<fo:table-column column-width="1%" />
						<fo:table-column column-width="25%" />
						<fo:table-column column-width="9%" />
						<fo:table-column column-width="20%" />
                <fo:table-body>
					<xsl:if test="fx_rates_type[. = '01']">
						<xsl:if test="fx_exchange_rate[.!='']">
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}" space-before.conditionality="retain" start-indent="20.0pt">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_EXCHANGE_RATE')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}">
										<xsl:value-of select="fx_exchange_rate" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block></fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_EQUIVALENT_AMT')" />
								</fo:block>
									</fo:table-cell>
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}">
										<xsl:value-of select="fx_exchange_rate_cur_code" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-family="{$pdfFont}">
										<xsl:value-of select="fx_exchange_rate_amt" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<fo:table-row keep-with-previous="always">
								<fo:table-cell number-columns-spanned="3">
									<fo:block font-family="{$pdfFont}" space-before.conditionality="retain" start-indent="20.0pt">		
										<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_BOARD_RATE_LABEL')" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
					</xsl:if>
					<xsl:if test="fx_rates_type[. = '02']">
						<xsl:call-template name="nbr-of-fx-contracts-">
					    	<xsl:with-param name="i">1</xsl:with-param>
					    	<xsl:with-param name="count"><xsl:value-of select="fx_nbr_contracts"/></xsl:with-param>
						</xsl:call-template>     
<!-- 					 	<xsl:if test="fx_nbr_contracts[. > '0']"> -->
<!-- 							<fo:table-row keep-with-previous="always"> -->
<!-- 								<fo:table-cell number-columns-spanned="6"> -->
<!-- 									<fo:block font-family="{$pdfFont}" space-before.conditionality="retain" start-indent="20.0pt"> -->
<!-- 										<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_CONTRACT_LABEL')" /> -->
<!-- 									</fo:block> -->
<!-- 								</fo:table-cell> -->
<!-- 							</fo:table-row> -->
<!-- 						</xsl:if> -->
					</xsl:if>
				
				</fo:table-body> 
			</fo:table>			
		</fo:block>
		<fo:block> </fo:block>
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
			<fo:table-row keep-with-previous="always">
				<fo:table-cell>
					<fo:block font-family="{$pdfFont}" space-before.conditionality="retain" start-indent="20.0pt">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_CONTRACT_NBR')" />
					</fo:block>
				</fo:table-cell>
				<fo:table-cell>
					<fo:block font-family="{$pdfFont}" space-before.conditionality="retain" start-indent="20.0pt">
						<xsl:value-of select="//*[starts-with(name(), concat('fx_contract_nbr_', $row))]"></xsl:value-of>
					</fo:block>
				</fo:table-cell>
				<fo:table-cell>
					<fo:block></fo:block>
				</fo:table-cell>
				<xsl:if test="//*[starts-with(name(), concat('fx_contract_nbr_amt_', $row))][.!='']">
					<fo:table-cell>
						<fo:block font-family="{$pdfFont}" space-before.conditionality="retain" start-indent="20.0pt">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_FX_EQUIVALENT_AMT')" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block font-family="{$pdfFont}" space-before.conditionality="retain" start-indent="20.0pt">
							<xsl:value-of select="//*[starts-with(name(), concat('fx_contract_nbr_cur_code_', $row))]"></xsl:value-of>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block font-family="{$pdfFont}" space-before.conditionality="retain" start-indent="20.0pt">
							<xsl:value-of select="//*[starts-with(name(), concat('fx_contract_nbr_amt_', $row))]"></xsl:value-of>
						</fo:block>
					</fo:table-cell>
				</xsl:if>
			</fo:table-row>
		</xsl:if>
	</xsl:template>	
	
	<xsl:template name="credit_note_invoices_details">
	 <xsl:if test="credit-note-items/credit-note">
			<fo:block keep-together="always">
			<fo:table font-family="{$pdfFontData}" width="{$pdfTableWidth}">
				<fo:table-column column-width="{$pdfTableWidth}"/>	
				<fo:table-column column-width="0" /> <!--  dummy column -->		
				<fo:table-header>
					<fo:table-row>
						<fo:table-cell>
							<fo:block background-color="{$backgroundSubtitles}" end-indent="20.0pt" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt" start-indent="20.0pt">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CREDIT_NOTE_DETALS')"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<fo:table-body>
					<fo:table-row>
					<fo:table-cell>
					<fo:block space-before.optimum="10.0pt" white-space-collapse="true">
				      	<fo:table font-family="{$pdfFontData}" table-layout="fixed" width="{$pdfNestedTableWidth}">
	  				       	<fo:table-column column-width="40.0pt"/>
	  				       	<fo:table-column column-width="proportional-column-width(2)"/>
				        	<fo:table-column column-width="proportional-column-width(2)"/>
				        	<fo:table-column column-width="proportional-column-width(2)"/>
				        	<fo:table-column column-width="proportional-column-width(2)"/>
				        	<fo:table-header color="{$fontColorTitles}" font-family="{$pdfFont}" font-weight="bold">
								<fo:table-row text-align="center">
								<fo:table-cell>
                            <fo:block> </fo:block>
                          </fo:table-cell> 	
				        		<fo:table-cell>
                            <fo:block background-color="{$backgroundSubtitles3}" border-right-color="{$background}" border-right-style="solid" border-right-width=".25pt">
                              <xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>
                            </fo:block>
                          </fo:table-cell>
				        		<fo:table-cell>
                            <fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt">
                              <xsl:value-of select="localization:getGTPString($language, 'CREDIT_NOTE_REFERENCE_LABEL')"/>
                            </fo:block>
                          </fo:table-cell>
                          <fo:table-cell>
                            <fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt">
                              <xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/>
                            </fo:block>
                          </fo:table-cell>
                          <fo:table-cell>
                            <fo:block background-color="{$backgroundSubtitles3}" border-left-color="{$background}" border-left-style="solid" border-left-width=".25pt">
                              <xsl:value-of select="localization:getGTPString($language, 'CREDIT_NOTE_SETTLED_AMOUNT')"/>
                            </fo:block>
                          </fo:table-cell>
				        	</fo:table-row>
				        	</fo:table-header>
				        	<fo:table-body>
				        		
					        		<xsl:for-each select="credit-note-items/credit-note">
					        		<fo:table-row>
										<fo:table-cell>
                              <fo:block> </fo:block>
                            </fo:table-cell> 
										<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
											<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="left">
												<xsl:value-of select="ref_id"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
											<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="left">
												<xsl:value-of select="credit_note_reference"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
											<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="left">
												<xsl:value-of select="invoice_currency"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell border-color="{$backgroundSubtitles3}" border-style="solid" border-width=".25pt">
											<fo:block padding-bottom=".5pt" padding-top="1.0pt" text-align="left">
												<xsl:value-of select="invoice_settlement_amt"/>
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
	</xsl:template>
	
	
	
	
</xsl:stylesheet>
