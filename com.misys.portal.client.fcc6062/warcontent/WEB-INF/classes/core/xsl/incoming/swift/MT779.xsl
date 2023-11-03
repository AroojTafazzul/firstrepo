<?xml version="1.0"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"	
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"	
		exclude-result-prefixes="localization utils">
<!--
   Copyright (c) 2000-2010 Misys (http://www.misysbanking.com),
   All Rights Reserved. 
-->
	<!-- Transform MT779 (Claim for payment of Guarantee Information) into bg_tnx_record or si_tnx_record -->
	<!-- Import common functions -->	
	<xsl:import href="MTXXX_common.xsl"/>
   <xsl:param name="reference"/> 
   <xsl:param name="language">en</xsl:param>  
   <xsl:param name="product_code"><xsl:value-of select="substring($reference,1,2)"/></xsl:param>    
  
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage"/>
    </xsl:template>
	
    <xsl:template match="MeridianMessage">
    	<xsl:variable name="lowercase_product_code">
    		<xsl:value-of select="translate($product_code, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
    	</xsl:variable>
    	<xsl:variable name="root_node"><xsl:value-of select="$lowercase_product_code"/>_tnx_record</xsl:variable>
    	<xsl:variable name="processingbankidentifier"><xsl:value-of select="ProcessingBankIdentifier"/></xsl:variable>
		<xsl:element name="{$root_node}">
			 <xsl:attribute name="xsi:noNamespaceSchemaLocation">
			 	<xsl:choose>
			 		<xsl:when test="$lowercase_product_code = 'bg'">http://www.neomalogic.com/gtp/interfaces/xsd/bg.xsd</xsl:when>
			 		<xsl:when test="$lowercase_product_code = 'si'">http://www.neomalogic.com/gtp/interfaces/xsd/si.xsd</xsl:when>
			 		<xsl:when test="$lowercase_product_code = 'lc'">http://www.neomalogic.com/gtp/interfaces/xsd/lc.xsd</xsl:when>
			 	</xsl:choose>
    		</xsl:attribute>
        <brch_code>00001</brch_code>  
        <ref_id><xsl:value-of select="$reference"/></ref_id>     
		<tnx_type_code>15</tnx_type_code>
		<sub_tnx_type_code/>
		<prod_stat_code>84</prod_stat_code><!-- WARRANTY_CLAIM -->
		<tnx_stat_code>04</tnx_stat_code>
		<product_code><xsl:value-of select="$product_code"/></product_code>
		<xsl:variable name="bgamount">
			<xsl:value-of select="substring(AmountClaimed, 4)"/>
		</xsl:variable>			
		<xsl:variable name="bgcurcode">
			<xsl:value-of select="substring(AmountClaimed,1,3)"/>
		</xsl:variable>		
		<!--<exp_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="NewValidityExpiryDate"/></xsl:call-template></exp_date>-->		
		<tnx_cur_code><xsl:value-of select="$bgcurcode"/></tnx_cur_code>
		<!-- Bg amount -->
		<xsl:variable name="amount">
			<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="$bgamount"/></xsl:with-param>
			</xsl:call-template>		
		</xsl:variable>
		<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
		<applicant_reference>
			<xsl:call-template name="extract_customer_reference">
				<xsl:with-param name="input" select="InstructionsFromTheBank"/>
			</xsl:call-template>
		</applicant_reference>
		<xsl:if test="AmountClaimed">
			<xsl:variable name="claimamount">
				<xsl:value-of select="substring(AmountClaimed, 4)"/>
			</xsl:variable>			
			<xsl:variable name="claimcurcode">
				<xsl:value-of select="substring(AmountClaimed,1,3)"/>
			</xsl:variable>
			<claim_cur_code><xsl:value-of select="$claimcurcode"/></claim_cur_code>	
			<xsl:variable name="claimamt">
				<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="$claimamount"/></xsl:with-param>
				</xsl:call-template>		
			</xsl:variable>
			<claim_amt><xsl:value-of select="$claimamt"/></claim_amt>
		</xsl:if>
		<claim_reference><xsl:value-of select="GuaranteeAndCreditNumber"/></claim_reference>
		<xsl:if test="DateOfClaimForPayment">
		  <claim_present_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="DateOfClaimForPayment"/></xsl:call-template></claim_present_date>
		</xsl:if>
		<xsl:if test="$lowercase_product_code = 'bg' and $processingbankidentifier != ''">
			<xsl:variable name="processingBank" select="utils:getProcessingBank($reference, '', $processingbankidentifier)"/>
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
		<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text"><xsl:value-of select="TextOfClaimForPayment"/></xsl:with-param>
		</xsl:call-template>		
		<xsl:if test="BankToCorporateInformation != ''">
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="BankToCorporateInformation"/>
		</xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>
		</xsl:if>
		<xsl:if test="BankContact != ''">
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="BankContact"/>
		</xsl:with-param>
		</xsl:call-template>
		</xsl:if>			
		</bo_comment>								
		</xsl:element>
    </xsl:template>	 	  
</xsl:stylesheet>
