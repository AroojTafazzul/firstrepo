<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:java="http://xml.apache.org/xalan/java"
		xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		xmlns:tool="xalan://com.misys.portal.interfaces.core.ToolsFactory"
		exclude-result-prefixes="converttools localization defaultresource tool">
		
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	
	<xsl:param name="base_url"/>
	<xsl:param name="language"/>
	
	
	<xsl:variable name="isdynamiclogo">
        <xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
   </xsl:variable>
	
	<!-- common instructions for the webapplication and the incoming loader -->
	<xsl:template match="el_tnx_record">
		
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="Section1-pm" margin-right="75.0pt" margin-left="75.0pt" margin-bottom="36.6pt" margin-top="36.6pt" page-height="841.9pt" page-width="595.3pt">
					<fo:region-body margin-bottom="80.0pt" margin-top="100.0pt"/>
					<fo:region-before extent="100.0pt"/>
					<fo:region-after extent="36.6pt"/>
				</fo:simple-page-master>
				<fo:page-sequence-master master-name="Section1-ps">
					<fo:repeatable-page-master-reference master-reference="Section1-pm"/>
				</fo:page-sequence-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="Section1-ps">
			
				<!-- HEADER-->
				<fo:static-content flow-name="xsl-region-before">
					<xsl:call-template name="header"/>
				</fo:static-content>
				
				<!-- FOOTER-->
				<fo:static-content flow-name="xsl-region-after">
					<xsl:call-template name="footer"/>
				</fo:static-content>
				
				<!-- BODY-->
				<xsl:call-template name="body"/>
					
			</fo:page-sequence>
		</fo:root>
		
	</xsl:template>
	<xsl:template match="documents/document">
		<fo:table-row>
			<fo:table-cell border-left-style="solid" border-left-width=".25pt" border-bottom-style="solid" border-bottom-width=".25pt">
				<fo:block start-indent="3.0pt" padding-top="1.0pt" padding-bottom=".5pt">
					<xsl:choose>
                   <xsl:when test="code and code[.!= ''] and code[.!= '99']"><xsl:value-of select="localization:getDecode($language, 'C064', code)"/></xsl:when>
                  <xsl:otherwise><xsl:value-of select="name"/></xsl:otherwise>
               </xsl:choose>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell border-left-style="solid" border-left-width=".25pt" border-bottom-style="solid" border-bottom-width=".25pt">
				<fo:block text-align="center" start-indent="3.0pt" padding-top="1.0pt" padding-bottom=".5pt">
					<xsl:value-of select="first_mail"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell border-left-style="solid" border-left-width=".25pt" border-bottom-style="solid" border-bottom-width=".25pt" border-right-style="solid" border-right-width=".25pt">
				<fo:block text-align="center" start-indent="3.0pt" padding-top="1.0pt" padding-bottom=".5pt">
					<xsl:value-of select="second_mail"/>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	  <xsl:template name="header">
	  	<fo:block font-size="8.0pt" font-family="serif">
			<xsl:call-template name="header-text"/>
		</fo:block>
	  </xsl:template>
	  
	  
	<xsl:template name="header-text">
		<fo:block font-weight="bold">
			<xsl:value-of select="advising_bank/name"/>
		</fo:block>
		<fo:block>&nbsp;</fo:block>
		<fo:block>&nbsp;</fo:block>
		<fo:block font-weight="bold" font-size="10.0pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_EL_HEADER_NOTE')"/></fo:block>
		<fo:block>&nbsp;</fo:block>
		<fo:block>&nbsp;</fo:block>
		<fo:table width="440.0pt">
			<fo:table-column column-width="280.0pt"/>
			<fo:table-column column-width="160.0pt"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_EL_LETTER_TO')"/></fo:block>
						<fo:block>&nbsp;</fo:block>
						<fo:block><xsl:value-of select="advising_bank/name"/></fo:block>
						<fo:block><xsl:value-of select="advising_bank/address_line_1"/></fo:block>
						<fo:block><xsl:value-of select="advising_bank/address_line_2"/></fo:block>
						<fo:block><xsl:value-of select="advising_bank/dom"/></fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_EL_LETTER_FROM')"/></fo:block>
						<fo:block>&nbsp;</fo:block>
						<fo:block><xsl:value-of select="beneficiary_abbv_name"/></fo:block>
						<fo:block><xsl:value-of select="beneficiary_name"/></fo:block>
						<fo:block><xsl:value-of select="beneficiary_address_line_1"/></fo:block>
						<fo:block><xsl:value-of select="beneficiary_address_line_2"/></fo:block>
						<fo:block><xsl:value-of select="beneficiary_dom"/></fo:block>
						<fo:block><xsl:value-of select="beneficiary_address_line_4"/></fo:block>
						<fo:block><xsl:value-of select="beneficiary_country"/></fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
		<fo:block>&nbsp;</fo:block>
		<fo:block>&nbsp;</fo:block>
	</xsl:template>
	
	<xsl:template name="footer">
		<!-- Page number -->
		<fo:block font-size="7.0pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_EL_FOOTER_NOTE')"/></fo:block>
		<fo:block font-size="10.0pt" font-family="serif" text-align="end">Page<fo:page-number />of<fo:page-number-citation ref-id="LastPage" />
		</fo:block>
	</xsl:template>
	
	<xsl:template name="body">
		<fo:flow flow-name="xsl-region-body" font-size="10.0pt" font-family="serif">
			<fo:block>&nbsp;</fo:block>
			<fo:block>&nbsp;</fo:block>
			<fo:block text-align="justify" margin-top="10.0pt" font-size="7.0pt"><xsl:value-of select="localization:getGTPString($language, 'XSL_EL_BODY_NOTE')"/></fo:block>
			<fo:block>&nbsp;</fo:block>
			
			<!-- General Details -->
			<fo:block font-weight="bold"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/></fo:block>
			<fo:block>&nbsp;</fo:block>
			<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_DATE')"/>&nbsp;<xsl:value-of select="tnx_val_date"/></fo:block>
			<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/>&nbsp;<xsl:value-of select="bo_ref_id"/></fo:block>
			<xsl:if test="cust_ref_id[.!='']">
				<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/>&nbsp;<xsl:value-of select="cust_ref_id"/></fo:block>
			</xsl:if>
			<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTIONDETAILS_AMOUNT')"/>&nbsp;<xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/></fo:block>
			<fo:block>&nbsp;</fo:block>
			<fo:block>&nbsp;</fo:block>
			
			<!-- Applicant Details -->
			<fo:block font-weight="bold"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_APPLICANT_DETAILS')"/></fo:block>
			<fo:block>&nbsp;</fo:block>
			<fo:table width="440.0pt">
				<fo:table-column column-width="60.0pt"/>
				<fo:table-column column-width="380.0pt"/>
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_NAME')"/></fo:block>
							<fo:block><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/></fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block><xsl:value-of select="applicant_name"/></fo:block>
							<fo:block><xsl:value-of select="applicant_address_line_1"/></fo:block>
							<fo:block><xsl:value-of select="applicant_address_line_2"/></fo:block>
							<fo:block><xsl:value-of select="applicant_dom"/></fo:block>
							<fo:block><xsl:value-of select="applicant_country"/></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
			<fo:block>&nbsp;</fo:block>
			<fo:block>&nbsp;</fo:block>
			
			<!-- Documents -->
			<xsl:if test="documents/document">
				<fo:block font-weight="bold"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DOCUMENT_DETAILS')"/></fo:block>
				<fo:table width="440.0pt" margin-top="18.0pt">
					<fo:table-column column-width="240.0pt"/>
					<fo:table-column column-width="100.0pt"/>
					<fo:table-column column-width="100.0pt"/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell background-color="#E6E6E6" border-left-style="solid" border-left-width=".25pt" border-top-style="solid" border-top-width=".25pt" border-bottom-style="solid" border-bottom-width=".25pt">
								<fo:block font-weight="bold" text-align="center" padding-top="1.0pt" padding-bottom=".5pt">Documents</fo:block>
							</fo:table-cell>
							<fo:table-cell background-color="#E6E6E6" border-left-style="solid" border-left-width=".25pt" border-top-style="solid" border-top-width=".25pt" border-bottom-style="solid" border-bottom-width=".25pt">
								<fo:block font-weight="bold" text-align="center" padding-top="1.0pt" padding-bottom=".5pt">Originals</fo:block>
							</fo:table-cell>
							<fo:table-cell background-color="#E6E6E6" border-left-style="solid" border-left-width=".25pt" border-right-style="solid" border-right-width=".25pt" border-top-style="solid" border-top-width=".25pt" border-bottom-style="solid" border-bottom-width=".25pt">
								<fo:block font-weight="bold" text-align="center" padding-top="1.0pt" padding-bottom=".5pt">Copies</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<xsl:apply-templates select="documents/document[first_mail != '' or second_mail != '' or code != '']"/>
					</fo:table-body>
				</fo:table>
			</xsl:if>
			<fo:block>&nbsp;</fo:block>
			<fo:block>&nbsp;</fo:block>
			
            <!-- Additional Instructions -->
			<fo:block font-weight="bold"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS')"/></fo:block>
			<fo:block>&nbsp;</fo:block>
			<fo:block><xsl:value-of select="narrative_additional_instructions/text"/></fo:block>
			
			<fo:block>&nbsp;</fo:block>
			<fo:block>&nbsp;</fo:block>
			
			<!-- Payment Instructions -->
			<fo:block font-weight="bold"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS')"/></fo:block>
			<fo:block>&nbsp;</fo:block>
			<fo:block><xsl:value-of select="narrative_payment_instructions/text"/></fo:block>
			<fo:block id="LastPage" font-size="1pt"/>
		</fo:flow>
	</xsl:template>
	
</xsl:stylesheet>