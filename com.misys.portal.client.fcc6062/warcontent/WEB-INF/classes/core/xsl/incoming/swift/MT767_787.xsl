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
	<!-- Transform MT798<767/787> Notification of Amendment Standby LC into si_tnx_record. -->
	<!-- Import common functions -->
	<xsl:import href="MTXXX_common.xsl"/>
   <xsl:param name="reference"/>
   <xsl:param name="language">en</xsl:param> 
   <xsl:param name="product_code">SI</xsl:param>        
   
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT767']"/>
    </xsl:template>
	
    <xsl:template match="MeridianMessage[ExternalMessageType = 'MT767']">
		<si_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/si.xsd">
        <brch_code>00001</brch_code>
        <!-- TODO: check if the ref_id is not in the message instead of retrieving it from the tnx_id -->
        <xsl:variable name="refid"><xsl:value-of select="service:retrieveRefIdFromTnxId($reference, $product_code)"/></xsl:variable>
        <ref_id><xsl:value-of select="$refid"/></ref_id>           
		<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT787']/CreditNumber"/></bo_ref_id>
		<tnx_id><xsl:value-of select="$reference"/></tnx_id> 		
		<tnx_type_code>03</tnx_type_code>
		<sub_tnx_type_code>
		<xsl:choose>
			<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT787']/IncreaseOfCreditAmount">01</xsl:when>
			<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT787']/DecreaseOfCreditAmount">02</xsl:when>
			<xsl:otherwise>03</xsl:otherwise>		
		</xsl:choose>	
		</sub_tnx_type_code>		
		<prod_stat_code>08</prod_stat_code>
		<tnx_stat_code>04</tnx_stat_code>  
		<product_code>SI</product_code>	
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT787']/NewValidityExpiryDate">
		<exp_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="../MeridianMessage[ExternalMessageType = 'MT787']/NewValidityExpiryDate"/></xsl:call-template></exp_date>		
		</xsl:if>
		<xsl:apply-templates select="DateOfIssueOrRequestToIssue"/>	
		<xsl:call-template name="IncreaseOfDecreaseOfDocCreditAmount"/>
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT787']/NewCreditAmountAfterAmendment">
			<!-- Credit amount -->
			<xsl:variable name="amount">
				<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT787']/NewCreditAmountAfterAmendment,4)"/></xsl:with-param>
				<xsl:with-param name="language"><xsl:value-of select="$language"/></xsl:with-param></xsl:call-template>		
			</xsl:variable>		
			<lc_cur_code><xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT787']/NewCreditAmountAfterAmendment,1,3)"/></lc_cur_code>			  	
	      	<lc_amt><xsl:value-of select="$amount"/></lc_amt>
      	</xsl:if>
		<applicant_reference><xsl:value-of select="service:retrieveCustomerBankReference($refid, $reference, $product_code)"/></applicant_reference>      	
      	<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT787']/NewPercentageCrAmountTolerance"/>				
		<xsl:apply-templates select="NumberOfAmmendment"/>					
		<bo_comment>	
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT787']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT787']/BankToCorporateInformation != ''">
			<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text">
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT787']/BankToCorporateInformation"/>
			</xsl:with-param>
			</xsl:call-template><xsl:text>
			</xsl:text>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT787']/BankContact and ../MeridianMessage[ExternalMessageType = 'MT787']/BankContact != ''">
			<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text">
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT787']/BankContact"/>
			</xsl:with-param>
			</xsl:call-template>
			</xsl:if>					
		</bo_comment>
		<amd_details>
			<xsl:apply-templates select="AmendmentDetails"/>
		</amd_details>												   	
      	</si_tnx_record>
    </xsl:template>
    
	<xsl:template match="AmendmentDetails">		
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>	
	</xsl:template>	
	
	<xsl:template name="IncreaseOfDecreaseOfDocCreditAmount">
		<xsl:if test="//MeridianMessage[ExternalMessageType = 'MT787']/IncreaseOfCreditAmount or //MeridianMessage[ExternalMessageType = 'MT787']/DecreaseOfCreditAmount">
			<xsl:variable name="increaserAmt">
				<xsl:choose>
				<xsl:when test="//MeridianMessage[ExternalMessageType = 'MT787']/IncreaseOfCreditAmount">
					<xsl:value-of select="number(translate(substring(//MeridianMessage[ExternalMessageType = 'MT787']/IncreaseOfCreditAmount,4),',','.'))"/>
				</xsl:when>
				<xsl:otherwise>0.0</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="decreaseAmount">
				<xsl:choose>
				<xsl:when test="//MeridianMessage[ExternalMessageType = 'MT787']/DecreaseOfCreditAmount">
					<xsl:value-of select="number(translate(substring(//MeridianMessage[ExternalMessageType = 'MT787']/DecreaseOfCreditAmount,4),',','.'))"/>
				</xsl:when>
				<xsl:otherwise>0.0</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<tnx_cur_code>
			<xsl:choose>
			<xsl:when test="//MeridianMessage[ExternalMessageType = 'MT787']/IncreaseOfCreditAmount">
				<xsl:value-of select="substring(//MeridianMessage[ExternalMessageType = 'MT787']/IncreaseOfCreditAmount,1,3)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="substring(//MeridianMessage[ExternalMessageType = 'MT787']/DecreaseOfCreditAmount,1,3)"/>
			</xsl:otherwise>	
			</xsl:choose>
			</tnx_cur_code>	
			<xsl:variable name="tmpAmt">
				<xsl:choose>
					<xsl:when test="$increaserAmt > $decreaseAmount"><xsl:value-of select="number(translate($increaserAmt,',','')) - number(translate($decreaseAmount,',',''))"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="number(translate($decreaseAmount,',','')) - number(translate($increaserAmt,',',''))"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<tnx_amt>
				<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="$tmpAmt"/></xsl:with-param>
				<xsl:with-param name="language"><xsl:value-of select="$language"/></xsl:with-param></xsl:call-template>				
			</tnx_amt>				
		</xsl:if>
	</xsl:template>	
	
</xsl:stylesheet>