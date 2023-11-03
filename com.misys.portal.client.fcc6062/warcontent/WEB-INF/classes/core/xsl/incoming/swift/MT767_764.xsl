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
	<!-- Transform MT767 into bg_tnx_record. -->
	<!-- Used for Notification of Amendment of Guarantee -->
	<!-- Import common functions -->
	<xsl:import href="MTXXX_common.xsl"/>
   <xsl:param name="reference"/>
   <xsl:param name="language">en</xsl:param>  
   <xsl:param name="product_code">BG</xsl:param>      
   
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT767']"/>
    </xsl:template>
	
    <xsl:template match="MeridianMessage[ExternalMessageType = 'MT767']">	
		<bg_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/bg.xsd">
        <brch_code>00001</brch_code>
        <!-- TODO: check if the ref_id is not in the message instead of retrieving it from the tnx_id -->
        <xsl:variable name="refid"><xsl:value-of select="service:retrieveRefIdFromTnxId($reference, $product_code)"/></xsl:variable>
        <xsl:variable name="processingbankidentifier"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT764']/ProcessingBankIdentifier"/></xsl:variable>
        <ref_id><xsl:value-of select="$refid"/></ref_id>           
		<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT764']/GuaranteeNumber"/></bo_ref_id>
		<tnx_id><xsl:value-of select="$reference"/></tnx_id>   
		<tnx_type_code>03</tnx_type_code>
		<prod_stat_code>08</prod_stat_code>
		<tnx_stat_code>04</tnx_stat_code>  
		<product_code><xsl:value-of select="$product_code"/></product_code>	
		<xsl:apply-templates select="DateOfIssueOrRequestToIssue"/>		
		<xsl:apply-templates select="NumberOfAmmendment"/>
		<applicant_reference><xsl:value-of select="service:retrieveCustomerBankReference($refid, $reference, $product_code)"/></applicant_reference>
		<xsl:if test="$processingbankidentifier != ''">
			<xsl:variable name="processingBank" select="utils:getProcessingBank($refid, $reference, $processingbankidentifier)"/>
			<processing_bank>
				<abbv_name><xsl:value-of select="$processingBank/processing_bank/abbv_name"></xsl:value-of></abbv_name>
				<name><xsl:value-of select="$processingBank/processing_bank/name"></xsl:value-of></name>
				<address_line_1><xsl:value-of select="$processingBank/processing_bank/address_line_1"></xsl:value-of></address_line_1>
				<address_line_2><xsl:value-of select="$processingBank/processing_bank/address_line_2"></xsl:value-of></address_line_2>
				<dom><xsl:value-of select="$processingBank/processing_bank/address_dom"></xsl:value-of></dom>
				<iso_code><xsl:value-of select="$processingBank/processing_bank/iso_code"></xsl:value-of></iso_code>
			</processing_bank>
		</xsl:if>					
		<bo_comment>
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT764']/SpecialAgreements and ../MeridianMessage[ExternalMessageType = 'MT764']/SpecialAgreements != ''">	
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT764']/SpecialAgreements"/>
		</xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>
		</xsl:if>
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT764']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT764']/BankToCorporateInformation != ''">
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT764']/BankToCorporateInformation"/>
		</xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>
		</xsl:if>
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT764']/BankContact and ../MeridianMessage[ExternalMessageType = 'MT764']/BankContact != ''">
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT764']/BankContact"/>
		</xsl:with-param>
		</xsl:call-template>
		</xsl:if>				
		</bo_comment>
		<amd_details>
			<xsl:apply-templates select="AmendmentDetails"/>
		</amd_details>												   	
      	</bg_tnx_record>
    </xsl:template>
    
	<xsl:template match="AmendmentDetails">		
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>	
	</xsl:template>	
</xsl:stylesheet>