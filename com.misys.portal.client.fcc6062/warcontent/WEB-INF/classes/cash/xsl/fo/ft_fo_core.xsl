<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<!-- Copyright (c) 2006-2013 Misys , All Rights Reserved -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider">
	
	<xsl:import href="../../../core/xsl/fo/fo_common.xsl" />
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl" />
	
	<xsl:param name="base_url"/>
	<xsl:param name="systemDate"/>
	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="rundata"/>
	
	<xsl:include href="ft_common_content_fo.xsl"/>
	<xsl:include href="ft_remittance_content_fo.xsl"/>
	<xsl:include href="ft_pi_content_fo.xsl"/>	
	
	<!-- TODO : DDA And BILL Payment Must be moved out of ft_content_fo.xsl into  ft_dda_billp_content_fo.xsl -->	
	<xsl:include href="ft_content_fo.xsl"/>
	
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" font-family="{$pdfFont}" writing-mode="{$writingMode}">

			<xsl:call-template name="general-layout-master" />
			
			<!-- bookmark section -->
		    <fo:bookmark-tree>
		        <fo:bookmark internal-destination="evedetails">
		            <fo:bookmark-title><xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_EVENT_DETAILS')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="bankmsgdetails">
		            <fo:bookmark-title>							
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
					</fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="gendetails">
		            <fo:bookmark-title><xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		       <xsl:if test="sub_product_code[.!='INT']">
		        <fo:bookmark internal-destination="recurringPaymentdetails">
		            <fo:bookmark-title>		            	
		            	<xsl:value-of select="localization:getGTPString($language, 'XSL_RECURRING_PAYMENT')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="orderingCustomerDetails">
		            <fo:bookmark-title>		            	
		            	<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ORDERING_CUSTOMER_DETAILS')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="orderingInstitutionDetails">
		            <fo:bookmark-title>		            	
		            	<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ORDERING_INSTITUTION_DETAILS')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="benedetails">
		            <fo:bookmark-title>		            	
		            	<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="linkedlicensedetails">
		            <fo:bookmark-title><xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_LINKED_LICENSES')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		        <xsl:variable name="mt103InterbankDetailsflag" select="defaultresource:getResource('MT103_INTER_BANK_DETAILS_DISPLAY')"/>
		        <xsl:variable name="mt101InterbankDetailsflag" select="defaultresource:getResource('MT101_INTER_BANK_DETAILS_DISPLAY')"/>
		        <xsl:variable name="fi103InterbankDetailsflag" select="defaultresource:getResource('FI103_INTER_BANK_DETAILS_DISPLAY')"/>
		        <xsl:variable name="fi202InterbankDetailsflag" select="defaultresource:getResource('FI202_INTER_BANK_DETAILS_DISPLAY')"/>
		        
		        <xsl:if test="(ft_tnx_record/sub_product_code[.='MT103'] and $mt103InterbankDetailsflag = 'true') or (ft_tnx_record/sub_product_code[.='MT101'] and $mt101InterbankDetailsflag = 'true') 
		        		or (ft_tnx_record/sub_product_code[.='FI103'] and $fi103InterbankDetailsflag = 'true') or (ft_tnx_record/sub_product_code[.='FI202'] and $fi202InterbankDetailsflag = 'true')">
			         <fo:bookmark internal-destination="intermediaryBankdetails">
			            <fo:bookmark-title><xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_INTERMEDIARY_BANK_DETAILS')" />
						</fo:bookmark-title>
			        </fo:bookmark>
		        </xsl:if>
		        <xsl:if test="ft_tnx_record/sub_product_code[.!='FI202'] and ft_tnx_record/sub_product_code[.!='FI103'] and ft_tnx_record/sub_product_code[.!='MT101'] and ft_tnx_record/sub_product_code[.!='MT103'] and ft_tnx_record/sub_product_code[.!='BANKB']">
			         <fo:bookmark internal-destination="intermediaryBankdetails">
			            <fo:bookmark-title><xsl:value-of
									select="localization:getGTPString($language, 'XSL_HEADER_INTERMEDIARY_BANK_DETAILS')" />
						</fo:bookmark-title>
			         </fo:bookmark>
		        </xsl:if>
		       </xsl:if>
		        <!-- transfer details starts -->
		       <fo:bookmark internal-destination="transferDetails">
		            <fo:bookmark-title>		            	
		            	<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSFER_DETAILS')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		       <!--  transfer details starts -->
		         <fo:bookmark internal-destination="transferToDetails">
		            <fo:bookmark-title>		            	
		            	<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSFER_TO_DETAILS')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="transactiondetails">
		            <fo:bookmark-title><xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_DETAILS')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		         <xsl:if test="sub_product_code[.!='INT']">
		         <fo:bookmark internal-destination="fxdetails">
		            <fo:bookmark-title><xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_EXCHANGE_RATE')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		         <fo:bookmark internal-destination="beneficiaryemailnotification">
		            <fo:bookmark-title><xsl:value-of
								select="localization:getGTPString($language, 'XSL_FT_BENEFICIARY_NOTIFICATION')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		        </xsl:if>
		        <fo:bookmark internal-destination="bankdetails">
		            <fo:bookmark-title><xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_BANK_DETAILS')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="forexdetails">
		            <fo:bookmark-title><xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_FOREIGN_EXCHANGE_DETAILS')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="beneAdvicedetails">
		            <fo:bookmark-title><xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_ADVICE_DETAILS')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="instructiontobankdetails">
		            <fo:bookmark-title><xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_INSTRUCTION_TO_BANK_DETAILS')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="remittancedetails">
		            <fo:bookmark-title><xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_REMITTANCEREASON')" />
					</fo:bookmark-title>
		        </fo:bookmark>
		        <fo:bookmark internal-destination="tnxRemarksdetails">
		            <fo:bookmark-title>
		            <xsl:choose>
					     <xsl:when test="ft_tnx_record/sub_product_code[.='TPT'] or ft_tnx_record/sub_product_code[.='INT'] or ft_tnx_record/sub_product_code[.='HVPS'] or ft_tnx_record/sub_product_code[.='HVXB']"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_PAYMENT_NARRATIVE')"/></xsl:when>
					     <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TRANSACTION_REMARKS_DETAILS')"/></xsl:otherwise>
					</xsl:choose>
					</fo:bookmark-title>
		        </fo:bookmark>
		    </fo:bookmark-tree> 
		    
			<fo:page-sequence initial-page-number="1" master-reference="Section1-ps">
				<!-- Put the name of the bank on the left -->
				<fo:static-content text-align="center" flow-name="xsl-region-start">
					<fo:block font-size="8pt" text-align="center" color="#FFFFFF"
						font-weight="bold" font-family="{$pdfFont}">
						<xsl:value-of select="localization:getDecode($language, 'N047', ft_tnx_record/sub_product_code[.])"/>
					</fo:block>
				</fo:static-content>
				<!--Apply ft_content_fo.xsl on ft_tnx_record-->
				<xsl:apply-templates select="child::*[1]" />
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>