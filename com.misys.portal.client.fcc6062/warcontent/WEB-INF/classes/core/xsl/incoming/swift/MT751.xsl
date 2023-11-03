<?xml version="1.0"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
		exclude-result-prefixes="localization service">
<!--
   Copyright (c) 2000-2012 Misys (http://www.misysbanking.com),
   All Rights Reserved. 
-->
	<!-- Transform MT798<751> (Notification of authorisation to Pay, Accept or Negotiate) into el_tnx_record-->
	<!-- Depending on the party notified (applicant or beneficiairy).
	To determine what is the product, we use the customer reference that (tag 21A of the swift) that is the portal system reference -->
	<!-- Import common functions -->	
	<xsl:import href="MTXXX_common.xsl"/>
   <xsl:param name="reference"/> 
   <xsl:param name="language">en</xsl:param>  
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT751']"/>
    </xsl:template>
	
    <xsl:template match="MeridianMessage">
    	<!-- <xsl:variable name="cust-reference-enabled">
	   		<xsl:value-of select="defaultresource:getResource('USE_72C_IN_MT798_FOR_CUSTREF')"/>
	   	</xsl:variable>
		<xsl:variable name="cust-reference" select="service:retrieveCustomerReferenceFromBoRefId(DocCreditNo, 'EL')"/> -->
		<xsl:variable name="lcRefid"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT751']/DocCreditNo"/></xsl:variable>
		<xsl:variable name="refid"><xsl:value-of select="service:retrieveRefIdFromMasterByLCRefId($lcRefid, 'EL')"/></xsl:variable>
       <el_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/el.xsd">
        <brch_code>00001</brch_code>
		<lc_ref_id><xsl:value-of select="$lcRefid"/></lc_ref_id>         
		<bo_tnx_id><xsl:value-of select="BankReferenceNumber"/></bo_tnx_id>
		<tnx_type_code>15</tnx_type_code>
		<sub_tnx_type_code/>
		<!-- Accepted -->
		<prod_stat_code>04</prod_stat_code>
		<tnx_stat_code>04</tnx_stat_code>
		<product_code>EL</product_code>
		<ref_id><xsl:value-of select="$refid"/></ref_id>
		<xsl:apply-templates select="DateOfIssue"/>
		<xsl:apply-templates select="IssuingBankA"/>
		<xsl:apply-templates select="IssuingBankD"/>
		<xsl:apply-templates select="NominatedConfirmingBankA"/>
		<xsl:apply-templates select="NominatedConfirmingBankD"/>
		<xsl:apply-templates select="Applicant"/>
		<xsl:if test="TotalAmountAdvised">
			<tnx_cur_code><xsl:value-of select="substring(TotalAmountAdvised,1,3)"/></tnx_cur_code>
			<!-- Credit amount -->
			<xsl:variable name="amount">
				<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(TotalAmountAdvised,4)"/></xsl:with-param>
				</xsl:call-template>		
			</xsl:variable>
			<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>			
		</xsl:if>
		<xsl:if test="PrincipalAmount">
			<tnx_cur_code><xsl:value-of select="substring(PrincipalAmount,1,3)"/></tnx_cur_code>
			<xsl:variable name="amount">
				<xsl:call-template name="format_amount">
					<xsl:with-param name="amount"><xsl:value-of select="substring(PrincipalAmount,4)"/></xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
		</xsl:if>
		<beneficiary_reference>
			<!-- <xsl:choose>
				<xsl:when test="$cust-reference-enabled = 'true'">
					<xsl:call-template name="extract_customer_reference">
						<xsl:with-param name="input">
						<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT751']/BankToCorporateInformation"/>
						</xsl:with-param>
					</xsl:call-template>					
				</xsl:when>
				<xsl:when test="$cust-reference-enabled = 'false'">
					<xsl:value-of select="$cust-reference"/>	
				</xsl:when>
			</xsl:choose> -->
		</beneficiary_reference>
		<xsl:apply-templates select="Applicant"/>	
		<maturity_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="../MeridianMessage[ExternalMessageType = 'MT751']/MaturityDate"/></xsl:call-template></maturity_date>
		<xsl:if test="CreationDateTime">
			<xsl:apply-templates select="CreationDateTime"/>
		</xsl:if>		
		<bo_comment><xsl:text>This is a Notification of authorisation to Pay, Accept or Negotiate.
See the attached SWIFT message for all details.
			</xsl:text>
			<xsl:if test="BankToCorporateInformation != ''">
				<xsl:call-template name="backslashn_replace">
				<xsl:with-param name="input_text">
					<xsl:value-of select="BankToCorporateInformation"/>
				</xsl:with-param>
				</xsl:call-template>
				<xsl:text>
				</xsl:text>
			</xsl:if>
			<xsl:if test="PaymentTerms != ''">
				<xsl:text>Payment Terms: </xsl:text>
				<xsl:call-template name="PaymentTerms">
					<xsl:with-param name="input_text">
						<xsl:value-of select="PaymentTerms"/>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:text>
				</xsl:text>
			</xsl:if>
			<xsl:if test="PaymentLiability != ''">
				<xsl:text>Payment Liability: </xsl:text>
				<xsl:call-template name="PaymentLiability">
					<xsl:with-param name="input_text">
						<xsl:value-of select="PaymentLiability"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</bo_comment>
		</el_tnx_record>
    </xsl:template>
</xsl:stylesheet>