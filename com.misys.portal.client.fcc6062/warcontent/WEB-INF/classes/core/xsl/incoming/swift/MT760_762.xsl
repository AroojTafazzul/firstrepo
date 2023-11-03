<?xml version="1.0"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"		
		exclude-result-prefixes="localization service utils">
<!--
   Copyright (c) 2000-2010 Misys (http://www.misysbanking.com),
   All Rights Reserved. 
-->
	<!-- Transform MT760 into bg_tnx_record -->
	<!-- Import common functions -->	
	<xsl:import href="MTXXX_common.xsl"/>
   <xsl:param name="reference"/> 
   <xsl:param name="language">en</xsl:param>  
   <xsl:param name="product_code">BG</xsl:param>
  
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT760']"/>
    </xsl:template>
	
    <xsl:template match="MeridianMessage[ExternalMessageType = 'MT760']">
	 	
    <!--  get the payment for future use -->
		<xsl:variable name="payment_type">
			<xsl:choose>
				<xsl:when test="AvailWithByA"><xsl:call-template name="extract_payment_type"><xsl:with-param name="input_text"><xsl:value-of select="AvailWithByA"/></xsl:with-param></xsl:call-template></xsl:when>
				<xsl:when test="AvailWithByD"><xsl:call-template name="extract_payment_type"><xsl:with-param name="input_text"><xsl:value-of select="AvailWithByD"/></xsl:with-param></xsl:call-template></xsl:when>
			</xsl:choose>
		</xsl:variable> 

 		<bg_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/bg.xsd">
        <brch_code>00001</brch_code> 
        <!-- TODO: we may get it from the index details -->
        <ref_id><xsl:value-of select="$reference"/></ref_id>
        <!-- Retrieve the tnx_id from the ref_id so that the right transaction is updated -->
        <xsl:variable name="tnxid"><xsl:value-of select="service:retrieveTnxIdFromRefId($reference, $product_code, '01')"/></xsl:variable>
        <xsl:variable name="processingbankidentifier"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT762']/ProcessingBankIdentifier"/></xsl:variable>              
		<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT762']/GuaranteeNumber"/></bo_ref_id>
		<tnx_id><xsl:value-of select="$tnxid"/></tnx_id>  
		<tnx_type_code>01</tnx_type_code>
		<!-- <sub_tnx_type_code/> -->		
		<prod_stat_code>03</prod_stat_code>
		<tnx_stat_code>04</tnx_stat_code>
		<product_code><xsl:value-of select="$product_code"/></product_code>
		<!-- Should it be mandatory ?? -->
		<xsl:if test="Date">
			<iss_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="Date"/></xsl:call-template></iss_date>
		</xsl:if>
		<xsl:variable name="bgamount">
			<xsl:call-template name="get_guarantee_amount"/>
		</xsl:variable>
		<xsl:variable name="bgcurcode">
			<xsl:value-of select="substring($bgamount,1,3)"/>
		</xsl:variable>		
		<tnx_cur_code><xsl:value-of select="$bgcurcode"/></tnx_cur_code>
		<!-- Bg amount -->
		<xsl:variable name="amount">
			<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring($bgamount,4)"/></xsl:with-param>
			</xsl:call-template>		
		</xsl:variable>
		<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
		<bg_cur_code><xsl:value-of select="$bgcurcode"/></bg_cur_code>
		<bg_amt><xsl:value-of select="$amount"/></bg_amt>
		<bg_liab_amt><xsl:value-of select="$amount"/></bg_liab_amt>	
		<applicant_reference><xsl:value-of select="service:retrieveCustomerBankReference($reference, $tnxid, $product_code)"/></applicant_reference>		
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT762']/Beneficiary"/>
		<adv_send_mode>01</adv_send_mode>
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT762']/AlternativeApplicant"/>
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT762']/IssuingBankA"/>
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT762']/IssuingBankD"/>		
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT762']/AdvisingBankA"/>
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT762']/AdvisingBankD"/>	
		<xsl:if test="$processingbankidentifier != ''">
			<xsl:variable name="processingBank" select="utils:getProcessingBank($reference, $tnxid, $processingbankidentifier)"/>
			<processing_bank>
				<abbv_name><xsl:value-of select="$processingBank/processing_bank/abbv_name"></xsl:value-of></abbv_name>
				<name><xsl:value-of select="$processingBank/processing_bank/name"></xsl:value-of></name>
				<address_line_1><xsl:value-of select="$processingBank/processing_bank/address_line_1"></xsl:value-of></address_line_1>
				<address_line_2><xsl:value-of select="$processingBank/processing_bank/address_line_2"></xsl:value-of></address_line_2>
				<dom><xsl:value-of select="$processingBank/processing_bank/address_dom"></xsl:value-of></dom>
				<iso_code><xsl:value-of select="$processingBank/processing_bank/iso_code"></xsl:value-of></iso_code>
			</processing_bank>
		</xsl:if>
		<narrative_additional_instructions>
		<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text">
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT762']/DetailsOfGuarantee"/>
			</xsl:with-param>
		</xsl:call-template>		
		</narrative_additional_instructions>	
		<bo_comment>
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT762']/SpecialAgreements and ../MeridianMessage[ExternalMessageType = 'MT762']/SpecialAgreements != ''">	
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT762']/SpecialAgreements"/>
		</xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>
		</xsl:if>
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT762']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT762']/BankToCorporateInformation != ''">
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT762']/BankToCorporateInformation"/>
		</xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>
		</xsl:if>
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT762']/BankContact and ../MeridianMessage[ExternalMessageType = 'MT762']/BankContact != ''">
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT762']/BankContact"/>
		</xsl:with-param>
		</xsl:call-template>
		</xsl:if>			
		</bo_comment>	
		</bg_tnx_record>
    </xsl:template>
	
    <xsl:template name="get_guarantee_amount">
    	<xsl:param name="node"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT762']/GuaranteeAmount"/></xsl:param>
		<xsl:value-of select="substring-after($node, '/')"/>
	</xsl:template>
	
    <xsl:template name="get_validity_type">
    	<xsl:param name="node"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT762']/ValidityType"/></xsl:param>
		<xsl:value-of select="$node"/>
	</xsl:template> 
	
	<xsl:template name="get_validity_type_code">
		<xsl:param name="input"/>
		<xsl:variable name="code">
			<xsl:call-template name="get_validity_type">
				<xsl:with-param name="input" select="$input"/>
			</xsl:call-template>	
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$code = 'LIMT'">02</xsl:when>
			<xsl:when test="$code = 'UNLM'">01</xsl:when>
		</xsl:choose>
	</xsl:template>	 	 	  
</xsl:stylesheet>
