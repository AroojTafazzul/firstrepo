<?xml version="1.0"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"		
		xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"	
		exclude-result-prefixes="localization service">
<!--
   Copyright (c) 2000-2010 Misys (http://www.misysbanking.com),
   All Rights Reserved. 
-->
	<!-- Transform MT777 (Query to extend or pay Guarantee) into bg_tnx_record or si_tnx_record -->
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
		<xsl:element name="{$root_node}">
			 <xsl:attribute name="xsi:noNamespaceSchemaLocation">
			 	<xsl:choose>
			 		<xsl:when test="$lowercase_product_code = 'bg'">http://www.neomalogic.com/gtp/interfaces/xsd/bg.xsd</xsl:when>
			 		<xsl:when test="$lowercase_product_code = 'si'">http://www.neomalogic.com/gtp/interfaces/xsd/si.xsd</xsl:when>
			 	</xsl:choose>
    		</xsl:attribute>
        <xsl:variable name="tnxId"><xsl:value-of select="service:retrieveTnxIdFromRefId($reference, $product_code, '15')"/></xsl:variable>
        <brch_code>00001</brch_code>   
        <ref_id><xsl:value-of select="$reference"/></ref_id> 
		<bo_ref_id><xsl:value-of select="GuaranteeAndCreditNumber"/></bo_ref_id>
		<tnx_id><xsl:value-of select="$tnxId"/></tnx_id>    
		<tnx_type_code>15</tnx_type_code>
		<sub_tnx_type_code/>
		<prod_stat_code>86</prod_stat_code>
		<tnx_stat_code>04</tnx_stat_code>
		<product_code><xsl:value-of select="$product_code"/></product_code>
		<exp_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="NewValidityExpiryDate"/></xsl:call-template></exp_date>			
		<!-- This message contains either an amount or the requested new expiry date
		so, do not set the amount of the transaction -->
		<!-- <xsl:if test="AmountClaimed">
			<xsl:variable name="bgamount">
				<xsl:value-of select="substring(AmountClaimed, 4)"/>
			</xsl:variable>			
			<xsl:variable name="bgcurcode">
				<xsl:value-of select="substring(AmountClaimed,1,3)"/>
			</xsl:variable>	
			<tnx_cur_code><xsl:value-of select="$bgcurcode"/></tnx_cur_code>
			<xsl:variable name="amount">
				<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="$bgamount"/></xsl:with-param>
				</xsl:call-template>		
			</xsl:variable>
			<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>			
		</xsl:if>-->
		<applicant_reference>
			<xsl:call-template name="extract_customer_reference">
				<xsl:with-param name="input" select="InstructionsFromTheBank"/>
			</xsl:call-template>
		</applicant_reference>
		<bo_comment>
		<!-- tag 31L New Validity Expiry Date -->
		<xsl:if test="NewValidityExpiryDate">
		- New expiry date: <xsl:call-template name="format_date"><xsl:with-param name="input_date" select="NewValidityExpiryDate"/></xsl:call-template>
			<xsl:text>
			</xsl:text>
		</xsl:if>
		<!-- tag 49J Text of Extend or Pay Request-->
		<xsl:if test="TextOfExtendOrPayRequest">
		- Text of the request to extend or pay:<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="TextOfExtendOrPayRequest"/>
		</xsl:with-param>
		</xsl:call-template>
		<xsl:text>
		</xsl:text>
		</xsl:if>
		<!-- tag 31T Latest Date for Reply -->
		<xsl:if test="LatestDateForReply">
		- Latest date for a response: <xsl:call-template name="format_date"><xsl:with-param name="input_date" select="LatestDateForReply"/></xsl:call-template>
			<xsl:text>
			</xsl:text>
		</xsl:if>		
		<xsl:if test="InstructionsFromTheBank">
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="substring-after(InstructionsFromTheBank, '\n')"/>
		</xsl:with-param>
		</xsl:call-template>
		<xsl:text>
		</xsl:text>
		</xsl:if>			
		<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text"><xsl:value-of select="TextOfClaimForPayment"/></xsl:with-param>
		</xsl:call-template>		
		<xsl:if test="BankToCorporateInformation != ''">
		- Bank information:
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="BankToCorporateInformation"/>
		</xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>
		</xsl:if>
		<xsl:if test="BankContact != ''">
		- Bank contact:
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="BankContact"/>
		</xsl:with-param>
		</xsl:call-template>
		</xsl:if>			
		</bo_comment>
		<cross_references>
			<cross_reference>
	            <brch_code>00001</brch_code>
				<product_code><xsl:value-of select="$product_code"/></product_code>
	            <type_code>01</type_code>			
			</cross_reference>
		</cross_references>
		<xsl:if test="DateOfExtendOrPayRequest">
			<additional_field name="request_date" type="date" scope="transaction"><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="DateOfExtendOrPayRequest"/></xsl:call-template></additional_field>
		</xsl:if>
		<action_req_code>07</action_req_code>								
		</xsl:element>
    </xsl:template>	 	  
</xsl:stylesheet>