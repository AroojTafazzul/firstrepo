<?xml version="1.0"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"	
		exclude-result-prefixes="localization">
	<!--
		Copyright (c) 2000-2012 Misys (http://www.misysbanking.com),
		All Rights Reserved. 
	-->
	<!-- Transform MT798<757> (Settlement of Import Documentary) into lc_tnx_record -->
	<!-- Import common functions -->	
	<xsl:import href="MTXXX_common.xsl"/>
	<xsl:param name="reference"/> 
	<xsl:param name="language">en</xsl:param> 
	<!-- reference should be equal to CustomerReferenceNumber in the message --> 
	<xsl:param name="product_code">LC</xsl:param>  
  
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT757']"/>
    </xsl:template>

    <xsl:template match="MeridianMessage">
	    <xsl:variable name="cust-reference-enabled">
	   		<xsl:value-of select="defaultresource:getResource('USE_72C_IN_MT798_FOR_CUSTREF')"/>
	   	</xsl:variable>
		<xsl:variable name="cust-reference" select="service:retrieveCustomerReferenceFromBoRefId(DocCreditNo, 'LC')"/>
		<lc_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/lc.xsd">    	
	    	<brch_code>00001</brch_code>
			<bo_ref_id><xsl:value-of select="DocCreditNo"/></bo_ref_id>
			<xsl:if test="CustomerReferenceNumber != '' and CustomerReferenceNumber != 'NONREF'">
				<ref_id><xsl:value-of select="CustomerReferenceNumber"/></ref_id>
			</xsl:if>
			<!-- <bo_tnx_id><xsl:value-of select="BankReferenceNumber"/></bo_tnx_id> -->
			<xsl:if test="PresentationReferenceNumber">
				<bo_tnx_id>
					<xsl:value-of select="PresentationReferenceNumber"/>
				</bo_tnx_id>
			</xsl:if>
			<cust_ref_id><xsl:value-of select="AdditionalCustomerReference"/></cust_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code/>
			<prod_stat_code>05</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code><xsl:value-of select="$product_code"/></product_code>
			<xsl:if test="IssueDate">
			<iss_date><xsl:value-of select="IssueDate"/></iss_date>
			</xsl:if>
			<xsl:if test="CreationDateTime">
				<xsl:apply-templates select="CreationDateTime"/>
			</xsl:if>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT757']/IssuingBankA"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT757']/IssuingBankD"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT757']/NominatedConfirmingBankA"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT757']/NominatedConfirmingBankD"/>
			
			<xsl:if test="CreditAmount">
				<lc_cur_code><xsl:value-of select="substring(CreditAmount,1,3)"/></lc_cur_code>
				<xsl:variable name="amount">
					<xsl:call-template name="format_amount">
						<xsl:with-param name="amount"><xsl:value-of select="substring(CreditAmount,4)"/></xsl:with-param>
					</xsl:call-template>		
				</xsl:variable>
				<lc_amt><xsl:value-of select="$amount"/></lc_amt>
			</xsl:if>
			
			<xsl:if test="TotalAmountForSettlementAccount">
				<tnx_cur_code><xsl:value-of select="substring(TotalAmountForSettlementAccount,1,3)"/></tnx_cur_code>
				<xsl:variable name="amount">
					<xsl:call-template name="format_amount">
						<xsl:with-param name="amount"><xsl:value-of select="substring(TotalAmountForSettlementAccount,4)"/></xsl:with-param>
					</xsl:call-template>		
				</xsl:variable>
				<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
			</xsl:if>

			<applicant_reference>
				<xsl:choose>
					<xsl:when test="$cust-reference-enabled = 'true'">
						<xsl:call-template name="extract_customer_reference">
							<xsl:with-param name="input" select="BankToCorporateInformation"/>
							<xsl:with-param name="prefix">CUST/</xsl:with-param>
						</xsl:call-template>					
					</xsl:when>
					<xsl:when test="$cust-reference-enabled = 'false'">
						<xsl:value-of select="$cust-reference"/>	
					</xsl:when>
				</xsl:choose>
			</applicant_reference>
	
			<bo_comment>
				<xsl:text>
This is a Settlement of Import Documentary Credit.
See the attached SWIFT message for all details.
				
				</xsl:text>
				<xsl:if test="BankToCorporateInformation != ''">
					<xsl:text>
BANK TO CORPORATE INFO:
					</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="substring-after(BankToCorporateInformation, '\n')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				
				<xsl:if test="DetailsOfCommisionAndCharges != ''">
					<xsl:text>
DETAILS OF COMMISION AND CHARGES:
					</xsl:text>
					<xsl:call-template name="backslashn_replace">
					<xsl:with-param name="input_text">
						<xsl:value-of select="DetailsOfCommisionAndCharges"/>
					</xsl:with-param>
					</xsl:call-template><xsl:text>
					</xsl:text>
				</xsl:if>
			</bo_comment>
			<xsl:apply-templates select="FileIdentification"/>
		</lc_tnx_record>
    </xsl:template> 	 	  
</xsl:stylesheet>