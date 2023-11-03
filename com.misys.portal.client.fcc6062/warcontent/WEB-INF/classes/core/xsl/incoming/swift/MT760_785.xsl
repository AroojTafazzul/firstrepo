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
	<!-- Transform MT798<785/760> (Notification of Standby LC) into si_tnx_record -->
	<!-- Import common functions -->	
	<xsl:import href="MTXXX_common.xsl"/>
   <xsl:param name="reference"/> 
   <xsl:param name="language">en</xsl:param>  
   <xsl:param name="product_code">SI</xsl:param>
  
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT760']"/>
    </xsl:template>
	
    <xsl:template match="MeridianMessage[ExternalMessageType = 'MT760']">
		<si_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/si.xsd">
        <brch_code>00001</brch_code>       
       	<!-- TODO: we may get it from the index details -->
        <ref_id><xsl:value-of select="$reference"/></ref_id>
        <!-- Retrieve the tnx_id from the ref_id so that the right transaction is updated -->
        <xsl:variable name="tnxid"><xsl:value-of select="service:retrieveTnxIdFromRefId($reference, $product_code, '01')"/></xsl:variable>              
		<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT785']/CreditNumber"/></bo_ref_id>
		<tnx_id><xsl:value-of select="$tnxid"/></tnx_id>
		<tnx_type_code>01</tnx_type_code>
		<sub_tnx_type_code/>		
		<prod_stat_code>03</prod_stat_code>
		<tnx_stat_code>04</tnx_stat_code>
		<product_code><xsl:value-of select="$product_code"/></product_code>
		<iss_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="Date"/></xsl:call-template></iss_date>
		<exp_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="../MeridianMessage[ExternalMessageType = 'MT785']/ValidityExpiryDate"/></xsl:call-template></exp_date>	
		<xsl:variable name="siamount">
			<xsl:call-template name="get_amount"/>
		</xsl:variable>
		<xsl:variable name="sicurcode">
			<xsl:value-of select="substring($siamount,1,3)"/>
		</xsl:variable>			
		<tnx_cur_code><xsl:value-of select="$sicurcode"/></tnx_cur_code>
		<!-- SI amount -->
		<xsl:variable name="amount">
			<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring($siamount,4)"/></xsl:with-param>
			</xsl:call-template>		
		</xsl:variable>
		<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
		<lc_cur_code><xsl:value-of select="$sicurcode"/></lc_cur_code>
		<lc_amt><xsl:value-of select="$amount"/></lc_amt>
		<!-- SI amount -->
		<xsl:variable name="positive_tolerance"><xsl:value-of select="substring-before(../MeridianMessage[ExternalMessageType = 'MT785']/PercentageCrAmountTolerance,'/')"/></xsl:variable>		
		<xsl:variable name="liab_amt"><xsl:value-of select="number(translate($amount,',','')) + number(translate($amount,',','')) * number($positive_tolerance div 100)"/></xsl:variable>
		<lc_liab_amt>
			<xsl:choose>
				<xsl:when test="string(number($positive_tolerance))='NaN'"><xsl:value-of select="$amount"/>
				</xsl:when>
				<xsl:otherwise><xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="$liab_amt"/></xsl:with-param></xsl:call-template></xsl:otherwise>
			</xsl:choose>
		</lc_liab_amt>
		<applicant_reference><xsl:value-of select="service:retrieveCustomerBankReference($reference, $tnxid, $product_code)"/></applicant_reference>		
		<xsl:apply-templates select="PercentageCrAmountTolerance"/>	
		<xsl:apply-templates select="MaxCrAmount"/>		
		<bo_comment>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT785']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT785']/BankToCorporateInformation != ''">
			<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text">
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT785']/BankToCorporateInformation"/>
			</xsl:with-param>
			</xsl:call-template><xsl:text>
			</xsl:text>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT785']/BankContact and ../MeridianMessage[ExternalMessageType = 'MT785']/BankContact != ''">
			<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text">
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT785']/BankContact"/>
			</xsl:with-param>
			</xsl:call-template>
			</xsl:if>			
		</bo_comment>	
		</si_tnx_record>
    </xsl:template>
	
    <xsl:template name="get_amount">
    	<xsl:param name="node"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT785']/CreditAmount"/></xsl:param>
		<xsl:value-of select="$node"/>
	</xsl:template> 	 	  
</xsl:stylesheet>
