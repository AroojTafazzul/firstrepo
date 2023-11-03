<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<!-- Copyright (c) 2006-2013 Misys , All Rights Reserved -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization">
	
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl" />
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl" />
	
	<!--Activation of Fop extensions (generating bookmarks)-->
	<xsl:param name="fop1.extensions" select="1"></xsl:param>
	<xsl:param name="base_url" />
	<xsl:param name="systemDate" />
	<xsl:param name="rundata" />
	<!-- Get the language code -->
	<xsl:param name="language" />
	
	<xsl:include href="lc_content_fo.xsl" />
	
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" font-family="{$pdfFont}" writing-mode="{$writingMode}">

			<xsl:call-template name="general-layout-master" />
			
			<!-- bookmark section -->
		    <fo:bookmark-tree>
		    <fo:bookmark internal-destination="txndetails">
                          <fo:bookmark-title><xsl:value-of
                                                       select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_DETAILS')" />
                                  </fo:bookmark-title>
                      </fo:bookmark>
                       <fo:bookmark internal-destination="reportdetails">
                          <fo:bookmark-title><xsl:value-of
                                                       select="localization:getGTPString($language, 'XSL_HEADER_REPORTING_DETAILS')" />
                                  </fo:bookmark-title>
                      </fo:bookmark>
		        <fo:bookmark internal-destination="gendetails">
		            <fo:bookmark-title><xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="amountdetails">
		            <fo:bookmark-title><xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_AMOUNT_DETAILS')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="revolvingdetails">
		            <fo:bookmark-title><xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_REVOLVING_DETAILS')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="paymentdetails">
		            <fo:bookmark-title><xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_PAYMENT_DETAILS')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="shipmentdetails">
		            <fo:bookmark-title><xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_SHIPMENT_DETAILS')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="bankdetails">
		        	<fo:bookmark-title>
		        	<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_BANK_DETAILS')" />
		      		 </fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="limitdetails">
		            <fo:bookmark-title><xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_FACILITY_LIMIT_SECTION')" />
		      		 </fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="linkedlicensedetails">
		        	<fo:bookmark-title>
		        	<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_LINKED_LICENSES')" />
		      		 </fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="narativedetails">
		        	<fo:bookmark-title>
		        		<xsl:value-of 
		        					select="localization:getGTPString($language, 'XSL_HEADER_NARRATIVE_DETAILS')" />
		      		</fo:bookmark-title>
		        </fo:bookmark>
		    </fo:bookmark-tree>
		    
			<fo:page-sequence initial-page-number="1"
				master-reference="Section1-ps">
				<!-- Put the name of the bank on the left -->
				<fo:static-content text-align="center" flow-name="xsl-region-start">
					<fo:block font-size="8pt" text-align="center" color="#FFFFFF"
						font-weight="bold" font-family="{$pdfFont}">
						<xsl:value-of select="localization:getDecode($language, 'N001', lc_tnx_record/product_code[.])"/>
					</fo:block>
				</fo:static-content>
				<!--Apply lc_content_fo.xsl on lc_tnx_record-->
				<xsl:apply-templates select="child::*[1]" />
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>
