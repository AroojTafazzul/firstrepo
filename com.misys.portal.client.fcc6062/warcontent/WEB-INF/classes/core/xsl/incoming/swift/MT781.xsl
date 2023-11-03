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
	<!-- Transform MT781 (Settlement of Guarantee Claim for Payment and/or charges) into bg_tnx_record/si_tnx_record/br_tnx_record/sr_tnx_record-->
	<!-- Import common functions -->	
	<xsl:import href="MTXXX_common.xsl"/>
   <xsl:param name="reference"/> 
   <xsl:param name="language">en</xsl:param> 
   <!-- reference should be equal to CustomerReferenceNumber in the message --> 
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
			 		<xsl:when test="$lowercase_product_code = 'br'">http://www.neomalogic.com/gtp/interfaces/xsd/br.xsd</xsl:when>
			 		<xsl:when test="$lowercase_product_code = 'sr'">http://www.neomalogic.com/gtp/interfaces/xsd/sr.xsd</xsl:when>
			 	</xsl:choose>
    		</xsl:attribute>
        <brch_code>00001</brch_code> 
        <!-- Customer reference number is the $reference -->
        <ref_id><xsl:value-of select="$reference"/></ref_id>
        <xsl:if test="$lowercase_product_code = 'sr'">    
        <lc_ref_id><xsl:value-of select="GuaranteeAndCreditNumber"/></lc_ref_id>
        </xsl:if>  
        
		<tnx_type_code>15</tnx_type_code>
		<sub_tnx_type_code/>		
		<prod_stat_code>85</prod_stat_code>
		<tnx_stat_code>04</tnx_stat_code>
		<product_code><xsl:value-of select="$product_code"/></product_code>
		<!-- Bg amount -->
		<xsl:variable name="tnxamount">
			<xsl:value-of select="substring(TotalAmountSettlementAccount, 4)"/>
		</xsl:variable>			
		<xsl:variable name="tnxcurcode">
			<xsl:value-of select="substring(TotalAmountSettlementAccount,1,3)"/>
		</xsl:variable>		
		<tnx_cur_code><xsl:value-of select="$tnxcurcode"/></tnx_cur_code>	
		<xsl:variable name="amount">
			<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="$tnxamount"/></xsl:with-param>
			</xsl:call-template>		
		</xsl:variable>
		<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
		<xsl:choose>
			<xsl:when test="$lowercase_product_code = 'br' or $lowercase_product_code = 'sr'">
			  <beneficiary_reference>
				<xsl:call-template name="extract_customer_reference">
					<xsl:with-param name="input" select="InstructionsFromTheBank"/>
				</xsl:call-template>
			  </beneficiary_reference>
			</xsl:when>
			<xsl:otherwise>
				<applicant_reference>
					<xsl:call-template name="extract_customer_reference">
						<xsl:with-param name="input" select="InstructionsFromTheBank"/>
					</xsl:call-template>
				</applicant_reference>	
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="$lowercase_product_code = 'bg' or $lowercase_product_code = 'si' or $lowercase_product_code = 'lc'">
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
				<claim_reference><xsl:value-of select="GuaranteeAndCreditNumber"/></claim_reference>
			</xsl:if>
		</xsl:if>
		<principal_act_no><xsl:value-of select="SettlementAccount"/></principal_act_no>
		<xsl:if test="$lowercase_product_code = 'br'">
			<issuing_bank>
        		<reference><xsl:value-of select="GuaranteeAndCreditNumber"/></reference>
        	</issuing_bank>
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
		<charges>
			<xsl:apply-templates select="DetailsOfOwnCommissionAndCharges"/>
		</charges>
		</xsl:element>
    </xsl:template> 	 	  
</xsl:stylesheet>
