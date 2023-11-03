<?xml version="1.0"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		exclude-result-prefixes="localization">
<!--
   Copyright (c) 2000-2010 Misys (http://www.misysbanking.com),
   All Rights Reserved. 
-->
	<!-- Transform MT714 (Acknowledgment of claim for payment under Guarantee / Standby Letter of Credit) into br_tnx_record -->
	<!-- Import common functions -->	
	<xsl:import href="MTXXX_common.xsl"/>
   <xsl:param name="reference"/> 
   <xsl:param name="language">en</xsl:param>  
  
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT714']"/>
    </xsl:template>
	
    <xsl:template match="MeridianMessage">
   		<xsl:variable name="product_code"><xsl:value-of select="substring(CustomerReferenceNumber,1,2)"/></xsl:variable>
    	<xsl:variable name="lowercase_product_code">
    		<xsl:value-of select="translate($product_code, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
    	</xsl:variable>
    	<xsl:variable name="root_node"><xsl:value-of select="$lowercase_product_code"/>_tnx_record</xsl:variable>
		<xsl:element name="{$root_node}">
			 <xsl:attribute name="xsi:noNamespaceSchemaLocation">
			 	<xsl:choose>
			 		<xsl:when test="$lowercase_product_code = 'br'">http://www.neomalogic.com/gtp/interfaces/xsd/br.xsd</xsl:when>
			 		<xsl:when test="$lowercase_product_code = 'sr'">http://www.neomalogic.com/gtp/interfaces/xsd/sr.xsd</xsl:when>			 		
			 	</xsl:choose>
    		</xsl:attribute>
        <brch_code>00001</brch_code>
        <ref_id><xsl:value-of select="CustomerReferenceNumber"/></ref_id>
        <xsl:if test="$lowercase_product_code = 'sr'">
        	<lc_ref_id><xsl:value-of select="GuaranteeAndCreditNumber"/></lc_ref_id>
        </xsl:if>
		<bo_ref_id><xsl:value-of select="BankReferenceNumber"/></bo_ref_id>
		<tnx_id>
			<xsl:call-template name="extract_tnx_id">
				<xsl:with-param name="input" select="InstructionsFromTheBank"/>
			</xsl:call-template>
		</tnx_id>
		<tnx_type_code>15</tnx_type_code>
		<sub_tnx_type_code/>
		<prod_stat_code>84</prod_stat_code><!-- WARRANTY_CLAIM -->
		<tnx_stat_code>04</tnx_stat_code>
		<product_code><xsl:value-of select="$product_code"/></product_code>
		<xsl:if test="$lowercase_product_code = 'sr'">
		<iss_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="DateOfIssue"/></xsl:call-template></iss_date>
		</xsl:if>
		<!-- <xsl:apply-templates select="DateOfClaimForPayment"/>-->
		<xsl:variable name="tnxamount">
			<xsl:value-of select="substring(AmountClaimed, 4)"/>
		</xsl:variable>			
		<xsl:variable name="tnxcurcode">
			<xsl:value-of select="substring(AmountClaimed,1,3)"/>
		</xsl:variable>		
		<!--<exp_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="NewValidityExpiryDate"/></xsl:call-template></exp_date>-->		
		<tnx_cur_code><xsl:value-of select="$tnxcurcode"/></tnx_cur_code>
		<!-- Bg amount -->
		<xsl:variable name="amount">
			<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="$tnxamount"/></xsl:with-param>
			</xsl:call-template>		
		</xsl:variable>
		<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
		<beneficiary_reference>
			<xsl:call-template name="extract_customer_reference">
				<xsl:with-param name="input" select="InstructionsFromTheBank"/>
			</xsl:call-template>
		</beneficiary_reference>
		<xsl:if test="$lowercase_product_code = 'br'">
        	<issuing_bank>
        		<reference><xsl:value-of select="GuaranteeAndCreditNumber"/></reference>
        	</issuing_bank>
        </xsl:if>
		<bo_comment>
		<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text"><xsl:value-of select="BankToCorporateInformation"/></xsl:with-param>
		</xsl:call-template>
		<!-- 
		<xsl:if test="BankToCorporateInformation != ''">
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="BankToCorporateInformation"/>
		</xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>
		</xsl:if>
		 -->
		<xsl:if test="BankContact != ''">
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="BankContact"/>
		</xsl:with-param>
		</xsl:call-template>
		</xsl:if>			
		</bo_comment>
		<!-- If 23X is there then call the below line -->
		<!-- <xsl:apply-templates select="FileIdentification"/>		 -->						
		</xsl:element>
    </xsl:template>	 	  
</xsl:stylesheet>
