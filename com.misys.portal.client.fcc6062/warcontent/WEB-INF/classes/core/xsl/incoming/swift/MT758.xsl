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
	<!-- Transform MT798<758> Settlement of Export Documentary Credit into el_tnx_record-->
	<!-- Import common functions -->	
	<xsl:import href="MTXXX_common.xsl"/>
   <xsl:param name="reference"/> 
   <xsl:param name="language">en</xsl:param>  
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT758']"/>
    </xsl:template>
	
    <xsl:template match="MeridianMessage">
    <xsl:variable name="cust-reference-enabled">
   		<xsl:value-of select="defaultresource:getResource('USE_72C_IN_MT798_FOR_CUSTREF')"/>
   	</xsl:variable>
	<xsl:variable name="cust-reference" select="service:retrieveCustomerReferenceFromBoRefId(DocCreditNo, 'EL')"/>
       <el_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/el.xsd">
        <brch_code>00001</brch_code>
        <xsl:if test="CustomerReferenceNumber">
			<ref_id><xsl:value-of select="CustomerReferenceNumber"/></ref_id>
		</xsl:if>
		<bo_ref_id><xsl:value-of select="DocCreditNo"/></bo_ref_id>
		<xsl:if test="PresentationReferenceNumber">
			<bo_tnx_id><xsl:value-of select="PresentationReferenceNumber"/></bo_tnx_id>
		</xsl:if>
		<tnx_type_code>15</tnx_type_code>
		<sub_tnx_type_code/>
		<prod_stat_code>05</prod_stat_code>
		<tnx_stat_code>04</tnx_stat_code>
		<product_code>EL</product_code>
		<xsl:if test="IssueDate">
			<iss_date><xsl:value-of select="IssueDate"/></iss_date>
		</xsl:if>
		<xsl:if test="CreationDateTime">
			<xsl:apply-templates select="CreationDateTime"/>
		</xsl:if>
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT758']/IssuingBankA"/>
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT758']/IssuingBankD"/>
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT758']/NominatedConfirmingBankA"/>
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT758']/NominatedConfirmingBankD"/>
		<!-- Drawing amount -->
		<xsl:if test="DrawingAmount">
		<tnx_cur_code><xsl:value-of select="substring(DrawingAmount, 1,3)"/></tnx_cur_code>
		<xsl:variable name="amount">
			<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(DrawingAmount,4)"/></xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
		</xsl:if>
		<beneficiary_reference>
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
		</beneficiary_reference>
		<xsl:if test="CreditAmount">
			<lc_cur_code><xsl:value-of select="substring(CreditAmount,1,3)"/></lc_cur_code>
			<xsl:variable name="amount">
				<xsl:call-template name="format_amount">
					<xsl:with-param name="amount"><xsl:value-of select="substring(CreditAmount,4)"/></xsl:with-param>
				</xsl:call-template>		
			</xsl:variable>
			<lc_amt><xsl:value-of select="$amount"/></lc_amt>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="AccountWithBankA">
				<principal_act_no>
					<xsl:value-of select="AccountWithBankA"/>
				</principal_act_no>
			</xsl:when>
			<xsl:otherwise>
				<principal_act_no>
					<xsl:value-of select="AccountWithBankB"/>
				</principal_act_no>
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:if test="SettlementAccountNo">
			<fee_act_no><xsl:value-of select="SettlementAccountNo"/></fee_act_no>
		</xsl:if>	
		<bo_comment>
			<xsl:text>
This is a notification of settlement. 
See the attached SWIFT message for all details.
			</xsl:text>
			
			<xsl:if test="BankToCorporateInformation != ''">
			<xsl:text>
BANK TO CORPORATE INFO:
			</xsl:text>
			<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text">
				<xsl:value-of select="BankToCorporateInformation"/>
			</xsl:with-param>
			</xsl:call-template><xsl:text>
			</xsl:text>
			</xsl:if>
					
			<xsl:if test="NominatedConfirmingBankContact != ''">
			<xsl:text>
NOMINATED/CONFIRMING BANK CONTACT:
			</xsl:text>
			<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text">
				<xsl:value-of select="NominatedConfirmingBankContact"/>
			</xsl:with-param>
			</xsl:call-template><xsl:text>
			</xsl:text>
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
		</el_tnx_record>	
    </xsl:template>
</xsl:stylesheet>